//
//  Algorithm.m
//  YLExperimentForOC
//
//  Created by mingdffe on 16/5/4.
//  Copyright © 2016年 yilin. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm
- (void)algorithm
{
/**********
 1. Two Sum   https://leetcode.com/problems/two-sum/
     
     Example:
     Given nums = [2, 7, 11, 15], target = 9,
     
     Because nums[0] + nums[1] = 2 + 7 = 9,
     return [0, 1].
 
         vector<int> twoSum(vector<int> &numbers, int target)
         {
         //Key is the number and value is its index in the vector.
         unordered_map<int, int> hash;
         vector<int> result;
         for (int i = 0; i < numbers.size(); i++) {
         int numberToFind = target - numbers[i];
         
         //if numberToFind is found in map, return them
         if (hash.find(numberToFind) != hash.end()) {
         //+1 because indices are NOT zero based
         result.push_back(hash[numberToFind] + 1);
         result.push_back(i + 1);
         return result;
         }
         
         //number was not found. Put it in the map.
         hash[numbers[i]] = i;
         }
         return result;
         } 
 注:hash表的使用,key,value (选择好谁是key,谁是value,这里key是数组的值,value是数组下标,因为hash是根据key来找的),类似字典呢! hash.find(numberToFind) != hash.end()  //Key is the number and value is its index in the array.
     https://leetcode.com/discuss/10947/accepted-c-o-n-solution    c++
     注:边找边将hash(key) = value的要理解,机智
     https://leetcode.com/discuss/8150/accepted-java-o-n-solution  java
 
 *******/
    
/*******
 2. Add Two Numbers  https://leetcode.com/problems/add-two-numbers/
    
    You are given two linked lists representing two non-negative numbers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.
     
     Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
     Output: 7 -> 0 -> 8
 
         public class Solution {
         public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
         ListNode c1 = l1;
         ListNode c2 = l2;
         ListNode sentinel = new ListNode(0);
         ListNode d = sentinel;
         int sum = 0;
         while (c1 != null || c2 != null) {
         sum /= 10;
         if (c1 != null) {
         sum += c1.val;
         c1 = c1.next;
         }
         if (c2 != null) {
         sum += c2.val;
         c2 = c2.next;
         }
         d.next = new ListNode(sum % 10);
         d = d.next;
         }
         if (sum / 10 == 1)
         d.next = new ListNode(1);
         return sentinel.next;
         }
         }
    注:链表说穿了就是 date + 指针next,date你抽象化理解.
       https://leetcode.com/discuss/2308/is-this-algorithm-optimal-or-what
 
 *********/
    
 /********
    3. Longest Substring Without Repeating Characters  https://leetcode.com/problems/longest-substring-without-repeating-characters/
  
          public int lengthOfLongestSubstring(String s) {
          if (s.length()==0) return 0;
          HashMap<Character, Integer> map = new HashMap<Character, Integer>();
          int max=0;
          for (int i=0, j=0; i<s.length(); ++i){
          if (map.containsKey(s.charAt(i))){
             j = Math.max(j,map.get(s.charAt(i))+1);//参考abcdcb,当从d开始时,到b的时候,第二位b的index(b)<index(d),故无效
          }
          map.put(s.charAt(i),i);
          max = Math.max(max,i-j+1);
          }
              return max;
          }
        https://leetcode.com/discuss/23883/11-line-simple-java-solution-o-n-with-explanation
  
    注:1.似乎有点类似KMP中的一个环节 2.hashMAP的使用 hash(key) = value  key不能重复,hashset理解为只有KEY的hashmap
  *********/
  
  /****
   4. Median of Two Sorted Arrays   https://leetcode.com/problems/median-of-two-sorted-arrays/
   
      There are two sorted arrays nums1 and nums2 of size m and n respectively. Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
   这个属于第K小的问题.
    
   [堆排序]
    堆排序(Heapsort)是指利用堆积树（堆）这种数据结构所设计的一种排序算法，它是选择排序的一种。可以利用数组的特点快速定位指定索引的元素。堆分为大根堆和小根堆，是完全二叉树。大根堆的要求是每个节点的值都不大于其父节点的值，即A[PARENT[i]] >= A[i]。在数组的非降序排序中，需要使用的就是大根堆，因为根据大根堆的要求可知，最大的值一定在堆顶。
   
   大根堆和小根堆：根结点（亦称为堆顶）的关键字是堆里所有结点关键字中最小者的堆称为小根堆，又称最小堆。根结点（亦称为堆顶）的关键字是堆里所有结点关键字中最大者，称为大根堆，又称最大堆。注意：①堆中任一子树亦是堆。②以上讨论的堆实际上是二叉堆（Binary Heap），类似地可定义k叉堆。
   
   HMM隐马尔可夫
   • 评估问题:给定观察序列O和HMM λ=(π, A, B),判 断O是由λ产生的可能性有多大  前项后项问题
   
   • 解码问题:给定观察序列O和HMM λ=(π, A, B),判 断序列O对应的最优状态序列是什么 维比特算法
   
   • 学习问题:给定观察序列O,确定产生O的最可能 HMM λ=(π, A, B) 鲍姆威尔士(Baum-Welch)算法
   

 （1）用大根堆  排序  的基本思想
    ① 先将初始文件R[1..n]建成一个大根堆，此堆为初始的无序区
    ② 再将关键字最大的记录R[1]（即堆顶）和无序区的最后一个记录R[n]交换，由此得到新的无序区R[1..n-1]和有序区R[n]，且满足R[1..n-1].keys≤R[n].key
    ③由于交换后新的根R[1]可能违反堆性质，故应将当前无序区R[1..n-1]调整为堆。然后再次将R[1..n-1]中关键字最大的记录R[1]和该区间的最后一个记录R[n-1]交换，由此得到新的无序区R[1..n-2]和有序区R[n-1..n]，且仍满足关系R[1..n-2].keys≤R[n-1..n].keys，同样要将R[1..n-2]调整为堆。
      ……
      直到无序区只有一个元素为止。
   

   ①.建堆  
   ②.调整堆
   ③.堆排序
   
   [快速排序]
   [BFPRT算法] 分组的思想,比较精妙,也比较麻烦的感觉,利用的是不断分治找中位数,然后根据数学思想的过程.pass
   
   [分治思想]

   
   问题描述：设集合S中共有n个数据元素，要在S中找出第k小元素（k任意）。
   思路：
     1）首先对于这个问题想到的是直接用排序解决，一般在O（nlogn）解决。
     2）有没有更好的解决方法呢？因为使用排序有个明显的问题就是，我们现在只需要找出第k小的值是多少，并不要求集合被排的有序，因此，排序有点多余。
     3）现快速排序给了启发，类似于快速排序的一种分治的算法寻找第k小得元素能够是时间复杂度为近似的O（n），当然并不是比较次数就为n，通过大量的
       实践证明了比较次数介于2n与3n之间。

   
   ******/
 //-------------------------------------------------------------//
    
    
/******
 【leedcode】
	第一次：
 【 #67】
 
 解法：
	为了叙述的方便，在后文中用a和b表示输入的二进制字符串
 
	这道题目相对来说非常简单，同LC43一样是高精度计算的题目，但是这道题目相对来说就要简单很多。主要是因为二进制的进位是非常简单的，要么是0，要么是1，所以我们就没有必要先将字符串转化为数组存储的数字，统一进位之后再转回字符串，而是可以直接就是用一个临时变量来进行存储进位信息，也不会将题目的逻辑变得复杂。
 
	具体的实现主要分为这样几步：
	?因为字符串的顺序是从高到低进行存储的，不方便对齐进行加法，所以我们将a和b中较短的字符串前面添加一些0来使得他们的长度变为一致。
	?然后从a和b的最低位开始逐位做二进制加法，取余数和商记得要用2做除数而不是10。
	?另外，不要忘记答案的长度可能长于输入的字符串。
	http://tianmaying.com/tutorial/LC67
 
	// 注：①.假设a[i] ='5' , int a = a[i] - '0'  = 5 ,字符串转成数字的方法
 同样的，数字 5 变成字符 '5' 也是相同的, ‘5‘ = char(5+'0');
 
 
 
 
 【 #191】
 
 思路一：
 1、n&1 可得到最低位的数字，然后加到count变量中即可
 
 2、n>>>1，注意是三个>不是两个>，三个的是逻辑移位，两个的是算术移位（Java中的定义）
 
 缺点就是：有多少位就要需要移动多少次
 
 思路二：
 
 1、假设n＝ 1111000111000 那 n-1 = 1111000110111, (n-1) & n = 1111000110000，刚好把最后一个1给干掉了。也就是说， (n-1)&n 刚好会从最后一位开始
 ，每次会干掉一个1.这样速度就比下面的快了。有几个1，执行几次。
 
 //注:>>> java里面的  逻辑移位  。
 
 
 【#58】
 思路：
 ①.s.trim() 去掉 前后端字符的空格
 ②.从后往前，或者两边进行都是思路！两边进行还有两边同步进行和两边异步进行的区别。
 
 【#202】 happy number
 思路：
 ①.https://leetcode.com/discuss/33349/o-1-space-java-solution  一个走一步，一个走两步 ，如有循环的话
 一定会相遇的。
 ②. 思路和链表找环类似。
 
 //注：8》1 = 4  ,8》2 =2
 
 【 #8】  String to Integer
 
 ①.ret_64 = ret_64 * 10 + (str[i] - '0');
 
 
 【 #118】Pascal's Triangle
 ①.ArrayList.add(int index, E elemen) 方法将指定的元素E在此列表中的指定位置
 ②.题解巧妙的用一维函数减小了空间复杂度。
 
 【#189】Rotate Array
 ① 分成两部分转，然后整体转
 
 【#119】Pascal's Triangle II
 ①..题解巧妙的用一维函数减小了空间复杂度。
 ②.例如:1 2 1  -----> 1 2 1 0 ---->1 2 1 1  -->1 2 3 1 ------->1 3 3 1.
 
 
 【#75】Sort Colors
	①.0,1,2 排序问题，i++ ，碰到0 或者 2，从两边开始，2 放到后，0放在前http://tianmaying.com/tutorial/LC75
	②.很显然，数组常常从两边来搞，异步或者同步，然后有个标记啥的
 
 
 【#151】 Reverse Words in a String
	①.   String[] parts = s.trim().split("\\s+"); // 空格分开
 String out = "";
 if (parts.length > 0) {
 for (int i = parts.length - 1; i > 0; i--) {
 out += parts[i] + " "; //反向+
 }
 out += parts[0];
 }
 return out;
 【1】Two Sum
	①.hash【key】 =value ，利用hash的快速，下标来处理的。
	
 
 【27】 Remove Element
	①.
 3    int removeElement(vector<int>& nums, int val) {
 4        int s = 0;
 5        // 依次判断每个数是否等于val，将不等于的那些组成新数组
 6        for (int i = 0; i < nums.size(); i++) if (nums[i] != val) {
 7            // 等号右侧相当于原本数组中的数，等号左边相当于删除后新数组的数
 8            nums[s ++] = nums[i];
 9        }
 10        // 返回新长度
 11        return s;
	②. 利用已有数组，两个下标，异步
 
 
 【104】 Maximum Depth of Binary Tree
	①.当前树长度 = max(左子树深度, 右子树深度) + 1
 2    int getMaxDepth(TreeNode* root) {
 3        if (!root) return 0;
 4        int leftDepth = getMaxDepth(root -> left);
 5        int rightDepth = getMaxDepth(root -> right);
 6        return (leftDepth > rightDepth ? leftDepth : rightDepth) + 1;
 7    }
 
 
 【237】Delete Node in a Linked List
	①.不难，记住前驱就好了。
 
 
 【258】Add Digits
	①.不难题目啊
 
 【136】Single Number
	①.异或所有元素，剩下的就是 那一个
	②.例如 a a b  c  b   ，全部异或就剩下c了
	
 
 
 【263】 ugly number
	①.根据丑数的定义，丑数只能被2、3和5整除。也就是说如果一个数如果它能被2整除，我们把它连续除以2；
 如果能被3整除，就连续除以3；如果能被5整除，就除以连续5。如果最后我们得到的是1，那么这个数就是丑数，否则不是。
 
 
 【7】Reverse Integer
	①.不难， 注意下边界
 
 【125】Valid Palindrome
	①.不难,判断下是不是字符
 
 【234】 Palindrome Linked List
	①.
 bool isParadom(ListNode * head)
 {
 //如果链表为空或者仅有一个元素那么肯定是回文链表
 if (!head || !head->next) {
 return true;
 }
 //快慢指针法，寻找链表中心
 ListNode * slow, *fast;
 slow = fast = head;
 while (fast && fast->next) {
 slow = slow->next;
 fast = fast->next->next;
 }
 if (fast) {
 //链表元素奇数个
 slow->next = reverseList(slow->next);
 slow = slow->next;
 }else{
 //链表元素偶数个
 slow = reverseList(slow);
 }
 while (slow) {
 if (head->val != slow->val) {
 return false;
 }
 slow = slow->next;
 head = head->next;
 }
 return true;
 }
	②.使用快慢指针可以找到链表的中心！！ 一个走一步，一个走两步，看来还比较常用啊啊啊
 //快慢指针法，寻找链表中心
 ListNode * slow, *fast;
 slow = fast = head;
 while (fast && fast->next) {
 slow = slow->next;
 fast = fast->next->next;
 }
 if (fast) {
 //链表元素奇数个
 slow->next = reverseList(slow->next);
 slow = slow->next;
 }else{
 //链表元素偶数个
 slow = reverseList(slow);
 }
 
 【15】 3Sum
	①.似乎可以延伸到Ksum ，
	②.2sum的两端找的技巧非常棒
 if  num[i] + num[j]>target
 j--; //如果大于taget,大下标向前缩小
 else
 i++; //如果小于，小下标向后，
 注：类似贪心
 
 
 【18】  4Sum
	①.先不看吧
	②.http://www.sigmainfy.com/blog/summary-of-ksum-problems.html
 
 【111】Minimum Depth of Binary Tree
	① public int minDepth(TreeNode root)
 {
 if (root == null)   return 0;
 if (root.left == null)  return minDepth(root.right) + 1;
 if (root.right == null) return minDepth(root.left) + 1;
 return Math.min(minDepth(root.left),minDepth(root.right)) + 1;
 }
	②.很多问题包括递归，先从最简单的可以退出的情况考虑起来！
 
 【94】Binary Tree Inorder Traversal
	①.中序遍历
 //递归
 void inorder(TreeNode *root)
 {
 if (root == NULL)
 return;
 inorder(root->left);
 result.push_back(root->val);
 inorder(root->right);
 }
 ②.下次弄个非递归的吧。
 
 
 【144】Binary Tree Preorder Traversal
	①.先序
 
 
 
 【145】Binary Tree Postorder Traversal
	①.后序
 
 【70】Climbing Stairs
	①.数学
 int[] count = new int[n];
 count[0] = 1;
 count[1] = 2;
 for(int i = 2; i < n; i++){ //依次循环记录出每增加一个台阶可行的方案
 count[i] = count[i-1] + count[i-2];
 
 ②.表达式列出来了就还好
 
 【141】 Linked List Cycle
	①.
 while(fast!=NULL && fast->next!=NULL)
 
 {
 
 if(slow==fast) return true;
 
 slow=slow->next;
 
 fast=fast->next->next;
 
 }
 
 return false;
 
 }
 
 ②.异步，一步两步，一步两步
 
 
 【155】Min Stack
	①.两个栈:一个正常的栈，一个顶部一直记录最小的  例如  2 3 4 5
 
 
 【169】Majority Element
 ①.找中位数，代码先不看了吧
 
 
 【225】Implement Stack using Queues
	①.栈模拟队列，代码还没看
	②. 算法保证在任何时候都有一队列为空
 
 【232】Implement Queue using Stacks
	①,栈模拟队列，代码没看，思路知道
 
 
 【83】Remove Duplicates from Sorted List
 
 【12】 Integer to Roman
 
 
 【13】Roman to Integer
 
 
 【26】Roman to Integer
 
 【121】Best Time to Buy and Sell Stock
 
 【171】Excel Sheet Column Number
 
 【217】Contains Duplicate
 
 【 231】Power of Two
 
 【26 】Remove Duplicates from Sorted Array
 
 
 【13】
 
 【  15 】
 
 
 【18】
 
 【292 】
 
 【 283  】
 
 【226 】
 
 【 242】
 
 【  235】
 
 88   101   110  172   204

 
 */
    
}
@end
