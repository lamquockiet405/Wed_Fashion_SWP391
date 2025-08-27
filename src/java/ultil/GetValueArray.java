/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ultil;

/**
 *
 * @author Admin
 */
public class GetValueArray {
    public static String getSafeValue(String[] array, int index) {
        return (index >= 0 && index < array.length) ? array[index] : null;
    }
}
