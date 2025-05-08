Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6311BC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 02:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 125734025A;
	Thu,  8 May 2025 04:34:14 +0200 (CEST)
Received: from HK3PR03CU002.outbound.protection.outlook.com
 (mail-eastasiaazon11021075.outbound.protection.outlook.com [52.101.129.75])
 by mails.dpdk.org (Postfix) with ESMTP id 2011C4014F
 for <dev@dpdk.org>; Thu,  8 May 2025 04:34:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpahVmLRqYVLi5LspmdpWeXl1cweNe2+aYh266sJUju84qZA4xukEbCuuAL8aSIstHhi0rKRg57kSR3FRv3GrScuK+EOsv1Yp7Key4is3VuTgtQxuTCY7P4p4p0N86goabCfYPC2K9mxfazPeS8w/PjSnFipmcU0QyUQ1JXyCh+JptmmKwHo08efgRzpnWlNaM6N4KPqSdwD4A6Ci6tLs14hBPooo/0/1W65MUCJqs9SHqnBa4SG3CylIUysehfVF/NF0N74pm1XpwfBcv4Xje9avdJ7PWSSsJvg6E2EjIyK2jS/U90Ut2FcSoVWitwSk9E285DRvufZ59/sqTwHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ejsph00Xiv2U+KgMTfRgGWICYoLBBL0wmxoqQLu8Vg=;
 b=IWR3v5Db56eUYjMZbmOuVpKJEhmidrkX9o2LloGLJMdo64b6QMEP81PRChRE57I+JRH9NafW+EzXBLe2NuZMQNfWSq2CptPxy5MtU0H1H9bod9psiy2s1MrjboMPgo1sNZTVEe6xDCSQDp3ILmApWz3dKG6JGWiu7XDJbNINMY5rsMfhnGYzhNiM9vyDpyeKdQLif9btdrBzfG9srcI3bUEabL0p48hYqkyIbdn8mnKnpmdLv1loADh1+NY6OKFgSx/ESM5jtvdNqGGSJR6Mk9Ki+370pq/TJn77qK9YdqdvlA2Ig6Y1gHzn/0CY/P+PUk+VHc1d3C0ciWQIvL0Dzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ejsph00Xiv2U+KgMTfRgGWICYoLBBL0wmxoqQLu8Vg=;
 b=TQ+YEdcqDYfoYa7//9ZTdurElUWX2/WG8MXSJ5el3KPn3TC1xRlcoseIU5/FKP4vP1WHca4LJXvDfuP/TMPAZJcT3BQk0RHxvhCUzZtmGsJlClc11Zo9/1rxGVq0W9fOY6YtTK/BmDEsWkkJ/qtea+DtoJe5lqsHAbWR1ElOF1phMtG8WcNynZQWVbDTTnxwKnGpra25i0XEq1AvzMJNaqpvje5CnDZ7wf8nzwi4JFTOKVmblhX/siDAtI6u3+O+nq5ersrlnj18Lb3medoNBLmH2JoJhvHXzEOzX/brxlAAX7Mh/imNp1tc1C9APi3gW58wCweDUHs+FdG/nUy5aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by SEZPR06MB5966.apcprd06.prod.outlook.com
 (2603:1096:101:ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 8 May
 2025 02:34:07 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%5]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 02:34:06 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru
Subject: [PATCH] ethdev: optimize how the values of the flag variables are
 assigned
Date: Thu,  8 May 2025 10:33:34 +0800
Message-Id: <20250508023334.28416-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|SEZPR06MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d480ffd-e7aa-4dbb-5e0b-08dd8dd8ce04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WWTOK9U4Hqb+lZCSIB5yhiY0pOGek/fB0dUDqiaboM70N4xKjFjQYldzgyJx?=
 =?us-ascii?Q?8S/XoXh7j92nog7GfdZym0FpIIDAj5q/xCJKavge8SNvQ00bRrjXtjDU4yjk?=
 =?us-ascii?Q?62KcBhNdzbnBrDnZtmjSk7a4lMfQWbpWsnGQVzKTyFsLWaeUu56YC5FHk+W4?=
 =?us-ascii?Q?A0m+i8Q9imk9egq/HXk2yl5o5+v+klYzh38rZeNC1D7HePCh0Dijp06bfDqf?=
 =?us-ascii?Q?ajzyDU7yz7rCJZS1nzKprt7IIG/tVvLvXyioPQFh/tCI22i7KygDEdjruxgO?=
 =?us-ascii?Q?aAYi084s2JEqGe76kYzdaqiUd5HiO8XHdomplfDvKdtGucsNF9x00v9pl4Ek?=
 =?us-ascii?Q?rM/Q3vyIgqaKeD/eEAqeQ3u37PF9prMw0pN6dzRFN7RpuByv2/V/KJGiEhv6?=
 =?us-ascii?Q?R5pb1RzI+FVjNiausfBRFaRn9Ix/3w3ZbAORj/ABrB9ZONhZwXgM1FqgsoMS?=
 =?us-ascii?Q?O41nxUbzNcdv+xbty28mDP2SqwNr4YVAYuyfgDmnGtvjV9ugnrig6edlbPD/?=
 =?us-ascii?Q?zlaWbDKIyU5Rsb93I0aE/YBV+J6ZK+vCHyFhXG/1+YWkNv9kfL4UpX4DlQhd?=
 =?us-ascii?Q?TwLSpjfgYWc3T2h6KtTmHvyOxlSDzzVFBl0Hs0+wpxizBq4lv7asWhm2UgbL?=
 =?us-ascii?Q?6kq6LhAVXrz5NCCZgVVrXM3aN9Pn1qBiA4TMUX5s07gTkh512txe4CmAhb5V?=
 =?us-ascii?Q?oMknc9NSHTBNfuLNSONpF/n1lu4sJLjl0Jf+XgqXqKKIb5Y37aX0U4WNbZz5?=
 =?us-ascii?Q?2Q3v+4MFJayRW5oWKhmvMvYKSOM8nqoltlXgTM9Di3ITCCirnc0OutBftrdE?=
 =?us-ascii?Q?6gN2Mrc0xVU7jmTQtYRBR8JMmGjtWxIpyNamJmuMgHqmXb8AsDxULhQHTsaq?=
 =?us-ascii?Q?sI+m4Gqjtd95ucSvohRcXOaC9jVgF7/u57DOpU6RL/Utl7EIO+7WckWJsiih?=
 =?us-ascii?Q?xNdncH4f4VOdAab6AFsDMfMCEnl2cfATUuaZeRQmcsd8y7+qpIt1G1/4G8iv?=
 =?us-ascii?Q?nUmAyKQ9jx9GRsd1hXZ0jRIpOAGCWpz+JUvVcd6+DlJsLyQpVoxEULy7zwwN?=
 =?us-ascii?Q?w5z6gvJ5TBktLX8N2dxEVoYbc7w3xowMgXIuZNml9OsemrATL87bhmoLsw/X?=
 =?us-ascii?Q?ZYdjssg8BLrLnk2KNbUtROEVzPRttdVVpb1cdbM1QIakQSA+fK0I5gIdntuG?=
 =?us-ascii?Q?aEv483Bc7Ged5fE/RMeF1dYb27a+g0rDRnpiBFJyC//FS84PakSJKr7PyeIW?=
 =?us-ascii?Q?b6BbgypEDWsmsUefC+B7+FBn2mD2SWkDGAyWVEyjAZwnHwMPPtg2Bam8pvKc?=
 =?us-ascii?Q?heOWmneHBby4NfdWv5a81SdnJpYlc8dQrZBbUqd4ckERhDMNKYT1vdpnLWdV?=
 =?us-ascii?Q?5U8djBGOJJKFuxZwU60N2GbZZfAjEzxJDkrMp+/byGXOgSF1mIDxUIvTpnap?=
 =?us-ascii?Q?kXoxIbaNaMe8WQ/1jWYRRdDUUqkWHGsFgwEyw9XixOYSJr1U12os+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q+aDo6K9QYmKjgTOBYKZp1C2d8KIQ+PlTJtm8npLkHrdyOzIRbnju/QlR41P?=
 =?us-ascii?Q?6u9zrot2tGNtME6Sr3yppO8PZdms7Er6WOP1TssZe7K1jRkv4mM1ILXBR2mj?=
 =?us-ascii?Q?n/InbpFoUY+Gnn5PFPFU/UEHIyN354D/wTVzOAM8BrVx+0eCZd6bAea3Dawz?=
 =?us-ascii?Q?yKbvXuRWuyZ13Cjj+4xhyleRX9docJOD/W5iWGf6oUfk43mXANOdue55ReAe?=
 =?us-ascii?Q?twD8UHn+fkn8cbmRJC3Eq7b3virO/6IM1zXPNDjWF5gb7vyXHpyS9HA96aay?=
 =?us-ascii?Q?PcYwiuyJw3ZxuieEP7j7T4YEuErFsqS7GND3pWg1ugahFtTA8MRgXWfvNRw8?=
 =?us-ascii?Q?Exed16aRCIJBeotb223Z6lG9SFD+kRTbXfuWdOe/r11YbNu6UXilChf+gE1W?=
 =?us-ascii?Q?V2HDcT9uE2fAa/l6t9wB33B1yvFZk3ncwHVdOOqnIjsMVxsBNg8jziZEelEQ?=
 =?us-ascii?Q?7hoB4pwXbXrg3YAMkjRvzoqC1pkkM81s73xn7Yr49dJH8WBZ1lFXMjjDJoW7?=
 =?us-ascii?Q?Ytxnh5zDyRLawOs6+1vTQaCPjKkDxTs92Oxzca5uhlUXCumjcVdQOVGeyI+G?=
 =?us-ascii?Q?+poEH38tmRobScyGkhSj/4KdQZ+aM2bN4uK5FMSSBcE88vwivdZNgH6fD050?=
 =?us-ascii?Q?dSFI04OFC963X9TWOLePLQ98PARBmsLDP3qHWSX8oqsK7MPWhejvgkEHnYxQ?=
 =?us-ascii?Q?tMwCHhp61FrOkkPE51loS3byHL5X6t9scg1aHtJpwyrkAgdlJQrgdVW3zBrv?=
 =?us-ascii?Q?XDhkIe6FNyruIoNxcctgxFf50DHwTutQskKgrPHV5lDhbnEHEX5T/I+gHSag?=
 =?us-ascii?Q?3OZ58C10L3+dy9MXRy/pM8rQP+GVfS4Hr1ryLQ+B79Ku9zH4YCJGQISWM9kC?=
 =?us-ascii?Q?tnXjEIHSb3zV8r52XD/X1EgtLLFRt8zea0HYRLpXn/opO+kuM8p2jRUuZTsa?=
 =?us-ascii?Q?ilmlb9zpMwPOiRtE0z6XZ8xbdMY9pLl881Ae3T0wI1focNXUr+7T1sLQrVFO?=
 =?us-ascii?Q?K/AfV+dv8u0Q2W5xKOF5jUf8ajzOJ2tikMHEYTCI2kHx+aEC0waKNQSi3kiX?=
 =?us-ascii?Q?8QnVu9jEJ6VdgIUJcfhUSo+jrQ8/GePtPMiMOSD+6perGOqUpHbcZIXLFpR6?=
 =?us-ascii?Q?mV0PdvDeL5Nc6nIuOV/jMgXD92TEXgOLwcdzwEV40rZqkU1JvkwqhWf0Vspd?=
 =?us-ascii?Q?dCDudWa0myM5uxExlJdIiGWHt4r8kbvoepiaGnNuJjDRLY03uNnoPteR31l1?=
 =?us-ascii?Q?hxrzU8pxfasQXx3NvgIbj4EJpBQfkS30oo7XE0jPkEUK74Y/F2FLRdCJ/I2l?=
 =?us-ascii?Q?gb9fT8wCWo9U5u2ExGJYGuJy/bJzjJi65WL3GT9zvQ18ByQs3CGQ28VQnUWO?=
 =?us-ascii?Q?Znd8C9h0LHNyX+noxS+GBFZ1Nw+idxTnAH41k81JW+Mq8neR6M7rRgUxgfXR?=
 =?us-ascii?Q?Z1R9hz5TXxxrg0lZNVfkU5Ec4QBP9BYtvsi1fRcMJqPdUWT0u1ZkNUatkPpe?=
 =?us-ascii?Q?VUWVCQXDDVRTBw3AZvfze8WUV4bx3l6cfEOLASHQ9QzSkcktpRRSyTTzycQg?=
 =?us-ascii?Q?JFZsXDcPYMsxBJygkV0418aCXyEBoTa7R+iB3z0+LVFFj/fPeqZrIbu4mbFB?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d480ffd-e7aa-4dbb-5e0b-08dd8dd8ce04
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 02:34:06.8010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n1WXKVpejgBVAc5tqqUAK9UdsS+bhqGgFqKlW7kzXG4byfMWmzu3V8O1a/a6d8ppbkRe0kKQ4/zevS3uajM+DAzmxpssJtguHJWNd+mjm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5966
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Set the values of the promiscuous and all_multicast variables
according to the return value.

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 lib/ethdev/rte_ethdev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d4197322a0..b1f593edc4 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3044,10 +3044,8 @@ rte_eth_promiscuous_disable(uint16_t port_id)
 	if (dev->dev_ops->promiscuous_disable == NULL)
 		return -ENOTSUP;
 
-	dev->data->promiscuous = 0;
 	diag = dev->dev_ops->promiscuous_disable(dev);
-	if (diag != 0)
-		dev->data->promiscuous = 1;
+	dev->data->promiscuous = (diag == 0) ? 0 : 1;
 
 	diag = eth_err(port_id, diag);
 
@@ -3112,10 +3110,9 @@ rte_eth_allmulticast_disable(uint16_t port_id)
 
 	if (dev->dev_ops->allmulticast_disable == NULL)
 		return -ENOTSUP;
-	dev->data->all_multicast = 0;
+
 	diag = dev->dev_ops->allmulticast_disable(dev);
-	if (diag != 0)
-		dev->data->all_multicast = 1;
+	dev->data->all_multicast = (diag == 0) ? 0 : 1;
 
 	diag = eth_err(port_id, diag);
 
-- 
2.19.0.rc0.windows.1

