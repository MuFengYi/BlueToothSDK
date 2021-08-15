//
//  BLueToothManager.h
//  BlueToothSDK
//
//  Created by EmBing on 2021/8/1.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BLueToothManagerDelegate <NSObject>


/// 更新蓝牙状态回调
/// @param state 蓝牙状态
- (void)updateManagerState:(CBManagerState)state;


/// 发现蓝牙设备回调
/// @param peripheral 蓝牙链接属性
- (void)discoverPeripheral:(CBPeripheral*)peripheral;

/// 链接蓝牙成功回调
/// @param peripheral 蓝牙链接属性
- (void)connectSuccess:(CBPeripheral*)peripheral;

/// 链接失败回调
/// @param peripheral 蓝牙链接属性
- (void)connectFaile:(CBPeripheral*)peripheral;


/// 断开蓝牙链接回调
/// @param peripheral 蓝牙链接属性
- (void)disConnnect:(CBPeripheral*)peripheral;


/// 发现蓝牙特征值回调
/// @param characteristic 发现的蓝牙特征值
- (void)discoverCharacteristics:(CBCharacteristic*)characteristic;


/// 蓝牙特征读写数据
/// @param characteristic 特征值
/// @param peripheral 蓝牙链接属性
- (void)updateValueForCharacteristic:(CBCharacteristic*)characteristic peripheral:(CBPeripheral*)peripheral;

@end

@interface BLueToothManager : NSObject

/// 蓝牙代理
@property (nonatomic,strong)id<BLueToothManagerDelegate>delegate;


/// 开始扫描
- (void)scanStart;


/// 停止扫描
- (void)scanStop;


/// 链接蓝牙
/// @param peripheral 蓝牙属性
- (void)conneectPeripheral:(CBPeripheral*)peripheral;


/// 断开蓝牙链接
/// @param peripheral 蓝牙属性
- (void)disConnectPeripheral:(CBPeripheral*)peripheral;

@end

NS_ASSUME_NONNULL_END
