// Using tutorial videos, lessions and other material we were tasked with assembling a basic Todo App in react-native to showcase and teach 
// ourselves how to use the program and its tools. Some notible changes from standard implementations is the usage of a image picker, an 
// additional page where we may store details, a unique color scheme and more. 

import React, { useState, useEffect } from 'react';
import {
  StyleSheet,
  SafeAreaView,
  View,
  TextInput,
  Text,
  FlatList,
  TouchableOpacity,
  Alert,
  Image,
} from 'react-native';
import Icon from 'react-native-vector-icons/MaterialIcons';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator, StackNavigationProp } from '@react-navigation/stack';
import { RouteProp } from '@react-navigation/native';
import * as ImagePicker from 'expo-image-picker';

const COLORS = { 
  primary: '#FF6347', // Tomato
  white: '#FFFAF0',   // Floral White
  background: '#FFDAB9' // Peach Puff
};

interface Task {
  id: number;
  description: string;
  summary: string;
  completed: boolean;
  imageUri?: string;
}

type RootStackParamList = {
  Home: undefined;
  Details: { task: Task };
};

type HomeScreenNavigationProp = StackNavigationProp<RootStackParamList, 'Home'>;

const HomeScreen = ({ navigation }: { navigation: HomeScreenNavigationProp }) => {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [taskInput, setTaskInput] = useState('');
  const [summaryInput, setSummaryInput] = useState('');

  useEffect(() => {
    loadTasksFromStorage();
  }, []);

  useEffect(() => {
    saveTasksToStorage(tasks);
  }, [tasks]);

  const addTask = () => {
    if (taskInput === '') {
      Alert.alert('Error', 'Please input a task');
    } else {
      const newTask = {
        id: Math.random(),
        description: taskInput,
        summary: summaryInput,
        completed: false,
      };
      setTasks([...tasks, newTask]);
      setTaskInput('');
      setSummaryInput('');
    }
  };

  const saveTasksToStorage = async (tasks: Task[]) => {
    try {
      const stringifyTasks = JSON.stringify(tasks);
      await AsyncStorage.setItem('tasks', stringifyTasks);
    } catch (error) {
      console.log(error);
    }
  };

  const loadTasksFromStorage = async () => {
    try {
      const tasks = await AsyncStorage.getItem('tasks');
      if (tasks != null) {
        setTasks(JSON.parse(tasks));
      }
    } catch (error) {
      console.log(error);
    }
  };

  const markTaskComplete = (taskId: number) => {
    const updatedTasks = tasks.map((task) => {
      if (task.id === taskId) {
        return { ...task, completed: true };
      }
      return task;
    });

    setTasks(updatedTasks);
  };

  const deleteTask = (taskId: number) => {
    Alert.alert('Confirm', 'Are you sure you want to delete this task?', [
      {
        text: 'Yes',
        onPress: () => {
          const updatedTasks = tasks.filter((task) => task.id !== taskId);
          setTasks(updatedTasks);
        },
      },
      {
        text: 'No',
      },
    ]);
  };

  const clearAllTasks = () => {
    Alert.alert('Confirm', 'Clear all tasks?', [
      {
        text: 'Yes',
        onPress: () => setTasks([]),
      },
      {
        text: 'No',
      },
    ]);
  };

  const TaskItem = ({ task }: { task: Task }) => {
    return (
      <TouchableOpacity onPress={() => navigation.navigate('Details', { task })}>
        <View style={styles.listItem}>
          <View style={{ flex: 1 }}>
            <Text
              style={{
                fontWeight: 'bold',
                fontSize: 15,
                color: COLORS.primary,
                textDecorationLine: task?.completed ? 'line-through' : 'none',
              }}>
              {task?.description}
            </Text>
          </View>
          {!task?.completed && (
            <TouchableOpacity onPress={() => markTaskComplete(task.id)}>
              <View style={[styles.actionIcon, { backgroundColor: 'green' }]}>
                <Icon name="thumb-up" size={20} color="white" />
              </View>
            </TouchableOpacity>
          )}
          <TouchableOpacity onPress={() => deleteTask(task.id)}>
            <View style={[styles.actionIcon, { backgroundColor: 'red' }]}>
              <Icon name="thumb-down" size={20} color="white" />
            </View>
          </TouchableOpacity>
        </View>
      </TouchableOpacity>
    );
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: COLORS.background }}>
      <View style={styles.header}>
        <Text style={{ fontWeight: 'bold', fontSize: 20, color: COLORS.primary }}>
          TASK MANAGER
        </Text>
        <Icon name="delete" size={25} color="red" onPress={clearAllTasks} />
      </View>
      <FlatList
        showsVerticalScrollIndicator={false}
        contentContainerStyle={{ padding: 20, paddingBottom: 100 }}
        data={tasks}
        renderItem={({ item }) => <TaskItem task={item} />}
        keyExtractor={(item) => item.id.toString()}
      />
      <View style={styles.footer}>
        <View style={styles.inputContainer}>
          <TextInput
            value={taskInput}
            placeholder="Add Task"
            onChangeText={(text) => setTaskInput(text)}
          />
          <TextInput
            value={summaryInput}
            placeholder="Add Summary"
            onChangeText={(text) => setSummaryInput(text)}
          />
        </View>
        <TouchableOpacity onPress={addTask}>
          <View style={styles.iconContainer}>
            <Icon name="add" color="white" size={30} />
          </View>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
};

const DetailsScreen = ({ route, navigation }: { 
  route: RouteProp<RootStackParamList, 'Details'>,
  navigation: StackNavigationProp<RootStackParamList, 'Details'>
}) => {
  const { task } = route.params;
  const [image, setImage] = useState<string | undefined>(task.imageUri);

  const pickImage = async () => {
    // Request permission to access media library
    const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (status !== 'granted') {
      Alert.alert('Sorry', 'We need camera roll permissions to make this work!');
      return;
    }

    // Launch image picker
    let result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      allowsEditing: true,
      aspect: [4, 3],
      quality: 1,
    });

    if (!result.canceled) {
      // Save the image URI to the task
      const newImageUri = result.assets[0].uri;
      setImage(newImageUri);

      // Retrieve existing tasks
      try {
        const tasksJson = await AsyncStorage.getItem('tasks');
        if (tasksJson) {
          let tasks: Task[] = JSON.parse(tasksJson);
          
          // Update the specific task with the new image
          const updatedTasks = tasks.map(t => 
            t.id === task.id ? {...t, imageUri: newImageUri} : t
          );

          // Save back to AsyncStorage
          await AsyncStorage.setItem('tasks', JSON.stringify(updatedTasks));
        }
      } catch (error) {
        console.error('Error updating task image:', error);
      }
    }
  };

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: COLORS.background }}>
      <View style={styles.detailsContainer}>
        <Text style={{ fontWeight: 'bold', fontSize: 20, color: COLORS.primary }}>
          {task.description}
        </Text>
        <Text style={{ fontSize: 16, color: COLORS.primary, marginBottom: 10 }}>
          {task.summary}
        </Text>
        
        {image && (
          <Image 
            source={{ uri: image }} 
            style={styles.taskImage} 
            resizeMode="cover" 
          />
        )}

        <TouchableOpacity 
          style={styles.imageUploadButton} 
          onPress={pickImage}
        >
          <Icon name="cloud-upload" size={24} color="white" />
          <Text style={styles.imageUploadButtonText}>
            {image ? 'Change Image' : 'Upload Image'}
          </Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
};

const Stack = createStackNavigator<RootStackParamList>();

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
        <Stack.Screen name="Details" component={DetailsScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

const styles = StyleSheet.create({
  footer: {
    position: 'absolute',
    bottom: 0,
    width: '100%',
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 20,
    backgroundColor: COLORS.white,
  },
  inputContainer: {
    height: 50,
    paddingHorizontal: 20,
    elevation: 40,
    backgroundColor: COLORS.white,
    flex: 1,
    marginVertical: 20,
    marginRight: 20,
    borderRadius: 30,
  },
  iconContainer: {
    height: 50,
    width: 50,
    backgroundColor: COLORS.primary,
    elevation: 40,
    borderRadius: 25,
    justifyContent: 'center',
    alignItems: 'center',
  },
  listItem: {
    padding: 20,
    backgroundColor: COLORS.white,
    flexDirection: 'row',
    elevation: 12,
    borderRadius: 7,
    marginVertical: 10,
  },
  actionIcon: {
    height: 25,
    width: 25,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 5,
    borderRadius: 3,
  },
  header: {
    padding: 20,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  detailsContainer: {
    padding: 20,
    flex: 1,
  },
  taskImage: {
    width: '100%',
    height: 250,
    borderRadius: 10,
    marginBottom: 15,
  },
  imageUploadButton: {
    position: 'absolute',
    bottom: 20,
    left: 20,
    flexDirection: 'row',
    backgroundColor: COLORS.primary,
    padding: 10,
    borderRadius: 25,
    alignItems: 'center',
    elevation: 5,
  },
  imageUploadButtonText: {
    color: 'white',
    marginLeft: 10,
    fontWeight: 'bold',
  },
});

export default App;
