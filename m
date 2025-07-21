Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC85C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 13:06:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 543474021E;
	Mon, 21 Jul 2025 15:06:12 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023099.outbound.protection.outlook.com
 [40.107.44.99]) by mails.dpdk.org (Postfix) with ESMTP id 73ADF4014F;
 Mon, 21 Jul 2025 15:06:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtAiLb5j0T14JxsU0XksZrmd75yCuIzXDUVemG3zIWyZc7U4HbAd7dVxSyq/nK9FwBYGPzGdYONHGBfYjmBvkt3G992iAg+pPxb4GywYLq8hJZT/79Nvy12M+Twl5PPwS032Mrr1gdS/QJqPSo595LzYMX1/Pzwi8kjnyCqTTAqjm7WKv9oqZRslktcIbjScoWAFij3KPDkuZJOKqVom+4QX4Xs4vpIst1yY3DVs8rhQUzG2k6K2Lp8RuU2yNCljrLLDz8rKHJaBvj/I52YGIjImxq9ryBHqvNeRewvraxHZmVo3BGZFRg/Y8iZUXmLVm+lO6VtU7UFLKioj0NuTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCO9GM3uX9QHoTWWF22dix8F+TZcPtEHLo21rfHG6EU=;
 b=UWkgmRG9V4w1aHomuE9oy7Gfs4Ck0X7dAvg6SGj94/rx872QcZI+GSXN6C6HZ7YidDzeqFA5n1+PSviDZN4vALO9kjWvzaownp0sMHq9+yOaJr9ESeaeFfoklNWYTNnA77UYVMB19wNkFTAqFuv09CxetCoAr8I6Bgt6xkR0zayt9Pq1cg5X0gAG17qm29B1BpMoge3O9vTp2wBYBvPF2ooGs6fYUMceoTAvQNEFP7hoEmPwLsDwf9rnZgddX67kw0/NmPbMP+mWyiqqSuy9UG0WButc3ZNDmsMqepID5zAfb9QWOQ0oR6Q0ix05s6P6GHPfhX31ME84rQZm3uWmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCO9GM3uX9QHoTWWF22dix8F+TZcPtEHLo21rfHG6EU=;
 b=k+L+KGYoMB0EbkzoxuoV/trwbVg6YDTM8HZt6qMRu3KQB/iSb5yEFLBxGH8l3xMF2WdxTsFykQd9tg9AIrQIyh2MFO1qQY7nW4XjDwpP6kVjvqK5rPlJhzCMeWbEFTmQjuBUTd3QLuV+ptOfhsX6q5y3if5UmWxxzO5ras/Rl7PjjM0yhMPPAItPkXBz7hf57X535FAdxd/hh1RoOLJ4rOLt7FQ/hyeHJIrhv2NAUDBTNIHai1NwobpunIZqZadezah+IG+Ul4MyFr9AFhQ0WXJlDv0TJph/RdsKnmZYiLqn9u+6zAY6/3Upirx3iy3qbJrD/MJnRLxvVEX/Dj9Dxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by SEZPR06MB6117.apcprd06.prod.outlook.com
 (2603:1096:101:f3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.42; Mon, 21 Jul
 2025 13:06:05 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%4]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 13:06:05 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru,
 stable@dpdk.org
Subject: [PATCH v2] ethdev: Align enable logic handling with disable functions
Date: Mon, 21 Jul 2025 21:05:45 +0800
Message-Id: <20250721130545.38200-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|SEZPR06MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: d04c55fe-68d1-4919-edce-08ddc857599d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8nysxyTD9y/1bEzpnqRVQyyTYSrJgBt474qu9Fnbc9XO1wf77exsUpC0DeW9?=
 =?us-ascii?Q?CvlRbKFwvi7sRIiYM2pZ5trlBzoBFHlKarjjL+VU7xnSoi9D1HrBeh8ezJMO?=
 =?us-ascii?Q?6JyvtPZo+Sc+9FWH7mTGmbm6VQschQ+xOUutqfrqsr38whtnpuaR9D4PExUl?=
 =?us-ascii?Q?8iugiu+H6fjeWG/WQGHEsaj0jVunTtFUxkg9qd+8QQZRJjflRdvGd5LXyEU9?=
 =?us-ascii?Q?b2durw71D1QkyoVoryfQtz29orVfTEaQW1/vD7J6YXwYzk7e5LBBpUENFhhF?=
 =?us-ascii?Q?7hLYysU00MVjdRMShGqmLYlm+oY1u4ZtY2pH0hBfykny1mbDyDPyFpYOLG7Z?=
 =?us-ascii?Q?xCMwcqe6RLK6wzYTcQQclRJJCLT1/KAG1c5SSuX7ctHhaBWcMcH6tx0Ot8VF?=
 =?us-ascii?Q?CPhNUH++xFN5QUgwkouaFmmR5uGvSn0qsQvPKxWwV1cNjEHsvP+KOhU7By5m?=
 =?us-ascii?Q?1BXmZrJjEM8F+TJxuE42pPxJIhynbO6zPXQNs+gxlmiw2sJiW9vvQRnmQBaV?=
 =?us-ascii?Q?i46pI8IsI5kcglyFXTbaoHGzgpgSkpxXHOGnlmbBYlPPTrWGHxMXIwS8zY13?=
 =?us-ascii?Q?rmrLQG+gKNkZCHg/yXYG+sI/oIFb45Y+dpKR5g71KhWxdMUvEHt1D7di8PD9?=
 =?us-ascii?Q?AEeDTU4shX0cMrRMF+GPgGHs4owBQkcAI1PVL3M5bcKLokC9rafdZoHt7lML?=
 =?us-ascii?Q?856ubcJ5bxQNAmGYQ4Faw24wQi145NOdYBKcOtFpWzCB53Pbz27Xvckj4nkL?=
 =?us-ascii?Q?hFahHfIJE03U7xE9xVsjUDgdra/HjeX9rPEyZg6t+LcsCRGT6RstPBnLBdqs?=
 =?us-ascii?Q?ozeO6Y/MdhlkpPs5gl7r97wHrxr/ymQanx+E3bFiSplqC54FN9hVpXz12nO2?=
 =?us-ascii?Q?/LVHAu3F/w2cu4GGYDlc+F2eTs0LBh0V6+XrfV0ka6v8jr65yZxtfhEj0NR/?=
 =?us-ascii?Q?p7U7qoFwZJD9AgGNfo05n9EUOfM+45ODhjw2Ic6dPcC8caLMuRq76WkcuNcI?=
 =?us-ascii?Q?332F+dAGVs/RkhVwv38S/7IAwv+yT04X8iA0NJUTiXPYfMEoI8RCC4X2qNqw?=
 =?us-ascii?Q?DN/j4pBxeknGQhtOQUhaosM8hxq6Hphap0RIHOwUbomAf8gz8JKECS154ycC?=
 =?us-ascii?Q?X/f6OQpmRCX0KWuhRo4GZRDE8rmP089xPRGSNTsnz+zERPtf0kvo0SFa94kG?=
 =?us-ascii?Q?gPwh6gCf86P7HUlNw+jjj2x3ED4urpiKxKuGMiYyrQmC4B6wNZszelrmvaUx?=
 =?us-ascii?Q?cB+irur6CkUyQgeKKMycFTxWH4yCDh4IkUfiV7vRYTREw9tsjBTL70ekAETc?=
 =?us-ascii?Q?wMTdkg2jM5hNziN7Mb5KXKfbMiCv1yEqtQQb343sijVoe2fJlaZkFfyvHZnP?=
 =?us-ascii?Q?FkVj3VkiTbHnwy7wvRa1d/B0m6RI6rB3SxHRnBw1Fq3dw9wEHo+u/U8oQCne?=
 =?us-ascii?Q?YOBxb/Mg6BpfRlIZgxbfZ/YwpNUhrpYV/pPcz+C8umPLMKJkkOVvOw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZWgUeXaFJDHFpyanYkfbLZDDJ19eHV3EwQVeyqRPQrKwahL40OAW3rZ3O9/M?=
 =?us-ascii?Q?l6/IcSsNab0eTzh13mdBkPV1/wht1mfr5FdGTtFzPXvX2tcudolltMf14irC?=
 =?us-ascii?Q?8c5BrsDrqfB1cXQGdJDOrc7/u+39roLA2u9tu7xAGh5T1n+vCCxDdwKKfXHf?=
 =?us-ascii?Q?xm+hKV5crnkUPH4NprRvRHHqxoIEOIkP7DZ57/FWmWJ4ygxQETd56K7I/tXj?=
 =?us-ascii?Q?XJtiPVeiDBNe1TKOYD/uIaqxwY/UDNjm/t7wxKJF2ZB3f0+epjbEcxeSRFj2?=
 =?us-ascii?Q?48qu0rIRDHOV0QIjcuAc7i7BsYXEX+ahKbuCa78B5QlSFPrHctM2N86q/6fW?=
 =?us-ascii?Q?Smmu4P17CoQq4wJAL1rYpTwox5fKeXe5zw+lfZZ+GqvcsQOWVgu+Ow+QmoCw?=
 =?us-ascii?Q?497P/96HstuLyVTFwPUopWq0y0NBrnM7fevKlhUiJmSgcXfaqg8l62hWrpkd?=
 =?us-ascii?Q?ZM0Z3xWOIpB4nZtpl9d1V6qV+ew8kT62g2MZJ2VMNVocBS5iL3DMJlZqLG5c?=
 =?us-ascii?Q?e7wcDLghqTeVsp9ss5UT+1ndpP2/AoQouhf/377r8QFPKpMemZrFoEKV9nfm?=
 =?us-ascii?Q?7mm+MCe7nugz+GYDcLUI4St9BInBvUAbw5AFNZnPi1+72KLpTPNNBCe1DoUM?=
 =?us-ascii?Q?5K/YA8sa+s+RuEWr+6w5YWAPPhVDlvOfkXWvW+dS/OvVHGyJCws4hh9Qv55H?=
 =?us-ascii?Q?Wh2+r48cjDxiI9ecEcR1RjBSBv2FeXBa+EJbLiufkZGcJraPM9cgWlCrlnGk?=
 =?us-ascii?Q?hsOkVXgUSWs3PJYpSm0xCAByeaRyFO3MALfhc7lcm5IJRgEnRwgjvAufKJkM?=
 =?us-ascii?Q?eLyYqVc6KOtWsDZCMCD+tESip/C3CRssiIPNSudGGx++BKJOeinNYXb1BAwY?=
 =?us-ascii?Q?ukoZa1hoomgG9guTPAdBzce17UM5LeBS1j5U2OqZvnulsNwueiMema+WBVm3?=
 =?us-ascii?Q?y1XjItC7rHyhHGB5zmMGMmJJHwdv3bpEVGP/9SaqRO5GjYvBtBP5zGSIPMEw?=
 =?us-ascii?Q?LvUk8gfMQTPy+87lo93wnSQ3M3OHvKuuiD0GtRwB2DoCgXSZPGWQWm08+XLM?=
 =?us-ascii?Q?DhS0PNJ4HUrq/d78U+R8/pp1IM4+4c7sR+9SW48/gdL6dzi+ZMnim7AFPdp+?=
 =?us-ascii?Q?0B0bAsUkjjRlf50QXF/GAPp2LnpTfA+cFMElQmgP5R+Mhs+4vN/bZHdul4Tp?=
 =?us-ascii?Q?k33MQxYpE2k5qCF3HCaO1ZjJczy0YuZKkWOtarfVrLkfQ+JEW39nWXJz5zDk?=
 =?us-ascii?Q?HZ9PLFtPvYo6fsG4bpH7HEQdQqyejIXQN2J7ZgKgZflmdtBc40mktBkbcU2m?=
 =?us-ascii?Q?h8fLY8UfGOky2c0Vs9jNOFj1ITJIWy0WAC9Ou7bseHyd8ccTjNhGpFz8c0iQ?=
 =?us-ascii?Q?UR8b5WQ96cKV4roVK12Vchv4HUyiH4LuKbsynSBp2BovzDETvO5Ro0aRel8B?=
 =?us-ascii?Q?W1Zj2wGjo0Vyveb/rev7QC5fW0VX26BtQk72/aiORc2OsllXw1SQcBXUazq6?=
 =?us-ascii?Q?W6okH/37YfL6GJW2fhSI+ma2tS+V4+0JKW5yHcCee/05wDC5a3wJqN9eUeA3?=
 =?us-ascii?Q?iq6rbIuGkspBD8GtzXAEhIXssnSf4Jvh5Jp6AYgZ8u/LFu2PY6eLv3L7za62?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04c55fe-68d1-4919-edce-08ddc857599d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:06:05.0145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kENJc5UCN9UAVFzL69i3W05MiUBuRH97Hm1rNHP73KXZ3GrB048VMdFMUu+UYMPsShWtFSel1nkQQjOes5/12WgGrXhPWdjkvirFSfkwQ/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
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

This patch modifies the handling logic of the "enable" related
operations. The key intention is to align it with the processing
approach of the "disable" functions.
Previously, there was an inconsistency in how failure scenarios were
dealt with between the "enable" and "disable" logic. Now, after
adjustment, their behaviors in exceptional cases are made more uniform.
Importantly, this change does not introduce any alteration to the actual
runtime behavior of the functions; it only serves to enhance code
consistency and maintainability, making the overall logic easier to
understand and maintain in the long run.
In this way, we ensure the codebase follows a more cohesive pattern,
reducing potential confusion during future development and maintenance
efforts that could stem from logical disparities.

Cc: stable@dpdk.org

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 lib/ethdev/rte_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..41f96071e2 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3018,7 +3018,8 @@ rte_eth_promiscuous_enable(uint16_t port_id)
 		return -ENOTSUP;
 
 	diag = dev->dev_ops->promiscuous_enable(dev);
-	dev->data->promiscuous = (diag == 0) ? 1 : 0;
+	if (diag == 0)
+		dev->data->promiscuous = 1;
 
 	diag = eth_err(port_id, diag);
 
@@ -3086,7 +3087,8 @@ rte_eth_allmulticast_enable(uint16_t port_id)
 	if (dev->dev_ops->allmulticast_enable == NULL)
 		return -ENOTSUP;
 	diag = dev->dev_ops->allmulticast_enable(dev);
-	dev->data->all_multicast = (diag == 0) ? 1 : 0;
+	if (diag == 0)
+		dev->data->all_multicast = 1;
 
 	diag = eth_err(port_id, diag);
 
-- 
2.19.0.rc0.windows.1

