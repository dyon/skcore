UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask` | 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048 | 4096 | 8192 | 65536 | 131072 | 524288 | 4194304 | 8388608 | 67108864 | 536870912 
	WHERE `entry` IN (40144, 39863, 39864, 40142, 40143, 40145, 39944, 39945, 39823, 39747, 39805, 39746, 39922, 39899, 39920, 39751);