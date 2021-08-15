//
//  BLueToothManager.m
//  BlueToothSDK
//
//  Created by EmBing on 2021/8/1.
//

#import "BLueToothManager.h"

@interface BLueToothManager()<CBCentralManagerDelegate,CBPeripheralDelegate>
@property (nonatomic,strong)CBCentralManager    *centralManager;
@end

@implementation BLueToothManager

+ (instancetype)shareBlueManager
{
    static BLueToothManager* blueManager;
    @synchronized(self){
        if (!blueManager) {
            blueManager = [[BLueToothManager alloc] init];
        }
    }
    return blueManager;
}

- (instancetype)init
{
    if (self=[super init])
    {
        self.centralManager =   [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

- (void)scanStart
{
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)scanStop
{
    [self.centralManager stopScan];
}

- (void)disConnectPeripheral:(CBPeripheral*)peripheral
{
    [self.centralManager cancelPeripheralConnection:peripheral];
}

#pragma mark ----CBCentralManager delegate
- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    if (self.delegate!=nil)
    {
        [self.delegate updateManagerState:central.state];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (self.delegate!=nil)
    {
        [self.delegate discoverPeripheral:peripheral];
    }
}

- (void)conneectPeripheral:(CBPeripheral*)peripheral
{
    [self.centralManager connectPeripheral:peripheral options:nil];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    if (self.delegate!=nil)
    {
        [self.delegate connectSuccess:peripheral];
        [self startdidDiscoverCharacteristicsForService:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    if (self.delegate!=nil)
    {
        [self.delegate connectFaile:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error
{
    if (self.delegate!=nil)
    {
        [self.delegate disConnnect:peripheral];
    }
}

-(void)startdidDiscoverCharacteristicsForService:(CBPeripheral*)peripheral
{
    [peripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error
{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error
{
    if (self.delegate!=nil)
    {
        
    }
}

//获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (self.delegate!=nil)
    {
        [self.delegate updateValueForCharacteristic:characteristic peripheral:peripheral];
    }
}

//中心读取外设实时数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{

}

//用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}

@end
