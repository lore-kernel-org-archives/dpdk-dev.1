Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4236C28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 03:06:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1A5440668;
	Fri, 21 Mar 2025 04:06:38 +0100 (CET)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2135.outbound.protection.outlook.com [40.107.255.135])
 by mails.dpdk.org (Postfix) with ESMTP id 00B2240268;
 Fri, 21 Mar 2025 04:06:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA+jYTNHgjBwiv89pJyzhIGJhxn4b3DTREFnKatObg6SYqUWJQ/1usptIqe+dcTHu9OtUdPIIAvd9m1K/+yGx5tahiOvBNG/oCA52R4rHoKg5YHUMz5IKYojp2HrCRLcTYqEYyrsj3GiS88Umsag45c5dBLcUP9a5SV6Bd1mSgregGBkLsrlaabxPID4/tAtY587Ylcg4QTvSzPyoxsntoB3tkHhYECWZ/u8zNvfRGDq/Rhfm2zijxzmTiDzBD4NDzwvmWw7rHAlG7XSgvgLw41ta2FcTTSWY1r4crjGd1q0zD1rLQ5CARwqMpNiPaUETk3hQambn92u8b27Z/QGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWrJz0Qpcmg9bZBN5cfyzlhCqsjZzxnPOFrBN5pXUHY=;
 b=mxj4YPxP/In9owTcCre0bFDpcQtDo3ACWxgtIEwwaqIB5q/EiFoDrmd0Cr/RWHRNqkdUT38ZRfed+lDpzun0+1BWFUcS4USOcDoUcRk3MJhlLU5av5XXhgeQBQGHMCqwky8wbESovQaTnvNhnEclwKj5u7uTu2UppuaSvE2MK6ZW4H7oEMD4CCRY0JnaJRNKldrWMwUHzLCduVnvqcqVkRL2/r78F2vnlHv8MaxvyaM+hvx8KJIYtglL0jlBxmkWITU8UJNsHttuuRwHx9EozimL/dLEhhyAwnlhCcjiZtqUGoST/EitQAsETX+yJ9655eS+WBSVYPX1HIf82wvD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWrJz0Qpcmg9bZBN5cfyzlhCqsjZzxnPOFrBN5pXUHY=;
 b=gZzOVWHWTpLIOrz+nPh3gie8gcmAWfFianre1BPdu2eApt5RM71BFS2P9N6PoAJEWp5o2SWgrIXG1R6Xg45QVwz8lUtIJ03TuoCFK9ij9T6Ac7AH55oID8oOPVl/rEwNDRp0vh7O4vFVN/QF6gTK2nqC/Apz08jYnTsepESLkfvqR+LliJRkU3cJqvnbM+q2s4k+H1vcM1aLYiXyEzpjBffZSBIO32EjAMAv/W/LF9jgntN/OUS38p5pWew08V72F/kFswGOJ80DGT8NJ0icgUEEN6swwz2/jUcesma66ERI4V7n+q8XeBRPYIQw7bWFUvm/ru7mzVBJ65w7TMfemA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com (2603:1096:4:15c::13)
 by TY0PR06MB6882.apcprd06.prod.outlook.com (2603:1096:405:16::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 03:06:34 +0000
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4]) by SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 03:06:33 +0000
From: Shaokai Zhang <felix.zhang@jaguarmicro.com>
To: dev@dpdk.org
Cc: linville@tuxdriver.com, stable@dpdk.org,
 Joey Xing <joey.xing@jaguarmicro.com>
Subject: [PATCH v3 1/1] net/af_packet: register supported param fanout mode
Date: Fri, 21 Mar 2025 11:05:51 +0800
Message-ID: <20250321030552.6231-2-felix.zhang@jaguarmicro.com>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250321030552.6231-1-felix.zhang@jaguarmicro.com>
References: <20250320083707.5594-2-felix.zhang@jaguarmicro.com>
 <20250321030552.6231-1-felix.zhang@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To SI2PR06MB4234.apcprd06.prod.outlook.com
 (2603:1096:4:15c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4234:EE_|TY0PR06MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 427a3bd4-5a76-4383-6137-08dd682562c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WPUWg0wcH4GYXSB0G6HEi7xOuUbUNau09AIBzjJ5ixdgclyA7qYvenFxMIb0?=
 =?us-ascii?Q?BDKVzxHbXougLuQrSDzxcgq0KnXqAt6pucXE2M60fiGZq0/AXhQ84Yy5alXm?=
 =?us-ascii?Q?CCzl8W1Div30+ZAiY3jWWMZReVPLdY0ydUfRms9BAzPU3j8OUj/vcAkvWIdt?=
 =?us-ascii?Q?rr9QPQPfQ9BwEtZ+vNSa6xlLbgQAh3hC9HPR5lG4tCPjvR8bfwBFWUK98LFR?=
 =?us-ascii?Q?T7QhVkni8r+3OSbZ+ENOtqqre8DbvWt+BwgSsYYNPb94f8MGWd/CQ8Zuq7ah?=
 =?us-ascii?Q?Pks7V38g3ricw3XYpEQDCRZt+2BUJHD8uarMT8P/5tiFxFzhPRdEs12KxX6E?=
 =?us-ascii?Q?uSOx7Ve/dIxHTbnfyQ9/4eSCEXO9k/zJYpJN3NXVzeSV9EnUEKIArw3F5I18?=
 =?us-ascii?Q?jbXGKfH5l+lmZ/HuedPu7JtSZ/G2uD9oFuou75axwRtJd0geDujF4WydYgl3?=
 =?us-ascii?Q?LnmSKs2dxFxyqVCEUhg3EYPIbr3WoMuQTdUHETFquta0mLUL8uzgrrjQU7hI?=
 =?us-ascii?Q?QTLbKJB9fQhdhmQjT0qpn+meQdVEsdq96HVvGhHC+lxAFFT40oN2Ri+LDzMr?=
 =?us-ascii?Q?v0dFQgbtLikxgVi+2EZ3TVCALvL89P5TkKLVjXgaMnk2kF0ca2lW1bBMGhfj?=
 =?us-ascii?Q?eLstQ7pu3X3ipLt74R/O7sYfTUlI8Z5vawS3X5rkMI0y9OCNYHeejIsIU5gU?=
 =?us-ascii?Q?Tu3tyiMmJS++C68pFIOCMQzlAR9sX6Yf1ycFLGXa/9FcZ5yiODT83NSbOHqe?=
 =?us-ascii?Q?4gjB4PKSgoASAs9qP8ur3+GDfWsEGKfmyQEcEs7tto2YhSNtgGxQYfY+hfcj?=
 =?us-ascii?Q?i4PZs76X5EUEmZtA8F16rDjdIr7lMmvHcM/ije9PcQgfZnamLbfvtSpMVDHL?=
 =?us-ascii?Q?7AAb6psOI9U7r0KGk0dkmJtF5WgXDLfa1dYt851ijifSUBhnMbL+sLDY3Gkp?=
 =?us-ascii?Q?BOp5gKVQpR0X4x8kQOKvF29Wp3wCITdo7l5jcxa11W/qR7EVJcWyAQQM6dd7?=
 =?us-ascii?Q?A6izaV2Z5SO2PfLCp2p5SxLOaYiYr2K/eCVxqeTZ2CJklBT53jcA6Tp6qxGC?=
 =?us-ascii?Q?m7v8EWD/OuGfUmoaVcoOmJT89SZJmeH0ldpobYPFaJscgoXUFLncDVWiBonM?=
 =?us-ascii?Q?FD7MmBWYhWfodNUOjXT1WsPX+EK1B0yUwOX6KVGbNSWtewCFuNo2EwF3yCip?=
 =?us-ascii?Q?GLBE6XJIy0HhLvrdW9tPKbbwZk9uS7nPYyC/xk8g8lClJPy4vlgbu/gE94N+?=
 =?us-ascii?Q?IhJmUamJzT2mdef0RAnFjfy7XnMbzHu+VGfAw+f5Z+Cf/cwdTOKQiJAGYZn8?=
 =?us-ascii?Q?kNT4X5giLTbzNzhK2TD9Rvlj5ohW9uUtY1bXugRnfnAv6wn3vdronzxG+5no?=
 =?us-ascii?Q?4LmTKhAIRx34RuaEbpsRp22U3O4pnEHeIINEV8cz660JAVNNC1E6uf6YOrqI?=
 =?us-ascii?Q?92hia+sRSuiiiEe/920ndqtThzQiQRoM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4234.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wIRAVlpK5ju8ihVRthnEZAnKEjJddyrJk6QfF8ljeVSGnj0z9B40i7ummMXV?=
 =?us-ascii?Q?DxuXrrH5ilkUQ/7cO3o/NKv5Qgp4NBdPz1l5B+NPrpV5q8IAYlJj9UFq4ZWv?=
 =?us-ascii?Q?AXIKkZxx/f09sBWXev1kk+GdZkRVNNE8zUf4mR5Hu1DlQ+/5rGIAebqSRb+E?=
 =?us-ascii?Q?k8/tBib/6wGtBvCuWrFlfmwmMVPwRd3aMeQfBZJmRKbtqeEtLtbWPa2HUz2C?=
 =?us-ascii?Q?Q6cRR92feydLHfC/thALZVypCFmOsqi4n8ZYZEPgqPMz2jH4+HZ5VvY2NGrr?=
 =?us-ascii?Q?vxtGVCtJ+Nk0dMzy8OUHHHWFLkylM6Wsnh3b6ThVEv4Zb7y/ekdprANNXY7m?=
 =?us-ascii?Q?5YqgAUun0svrk4zhHManqrgKGXgogSgqMyYzldjPGCRIsuqjqseLDnFfH3vF?=
 =?us-ascii?Q?VvnW8f7lrQH0Cu2SS+OiszYcDbVzH0nXuyTjOxG4bo4rH1zsWg1EYJec7qk5?=
 =?us-ascii?Q?u8xOUBtz/StmS/dz6pLtbm/mRf6T0jyEeh78oKoqFKUrmnGeW92vAADn2Nm/?=
 =?us-ascii?Q?ktqOjdvMxY5oqgPecRnS8U8B+g+LmsLoRPl9t/rPJGx9r31NA5tpANAgE100?=
 =?us-ascii?Q?tKE/UWJyxkVAD8cr72/m3Qusj+814XyeaQUA4wxVX0eXdv+ULLrI6b3M2+Je?=
 =?us-ascii?Q?tMilFyrK1h+fz2pIdI0r3itPpkP4DxvYnv1O29s6LpqYvYzLQ8/fO4daayo3?=
 =?us-ascii?Q?iDr3o66qQddHpd8lBfw8cQpfDkxx2lg6n2UaQQJzo2CyW9R4+cI+KKzuiwqe?=
 =?us-ascii?Q?Alx4+7+SEVMdrAlgU0h1oOVjVEHqwmdxM6usK6MBqssorRM2iHBg/uv+T4Y7?=
 =?us-ascii?Q?PV/GplJ4qMlFgJYgjd+8A11S9dcyqiQqCKwaOZQzmCvkP5x6Uf9cw9/B6Leq?=
 =?us-ascii?Q?Lrf0HAnW4sUxv6QewyJMnRrmLU1GPv+mehXYgchRgjl6+SDoSsEsiWjvncTh?=
 =?us-ascii?Q?JeblRSRippbWo2aN3FovunS3krEkoGWFHI2Vkw83ww69tvcshQlEIUoZSAYN?=
 =?us-ascii?Q?knuWoVV6x8BfEphYDhQY3HzK+3VhHgabUGcjSBT8z7qfutoIGfjbNQAueHbV?=
 =?us-ascii?Q?p11dFojIU7DydRvEQJVbpg+YzdTsgXfhQvupccmTtG4nUUylhApOROeZF4sd?=
 =?us-ascii?Q?xoYSZ05stTcyOPFOZOtv9F7ytE3exhwTqVS20jxvuWRvgdFwtduzStdrNB5F?=
 =?us-ascii?Q?0kp9UGOfFv/UAFQmQS/WkhyEISBe/R88qYVCCazcRC5sPzpplzEKWN2sqbFl?=
 =?us-ascii?Q?UQoJnC4X8HIaTGKoSj7ORrsQEechVJtf+atbWNv64zdPuIhZOnRQWzqJHGcO?=
 =?us-ascii?Q?O31jfFALZleFksv3sCGLnHktQ0s4oSETUa8aUtwgojH8OPfFZaVIgrrz7co8?=
 =?us-ascii?Q?g5iQHtTlmwh9JIoG86REQ/fuPtjKJvRmnSmCpnvY3ulgpRTSyx1cl1pDV9H3?=
 =?us-ascii?Q?4WyPrEwVj5+zSILg//e6wmmXUr15bGIWuFFeD3pF4QhOGKpIYMCdfW0FGBvR?=
 =?us-ascii?Q?MqumnD41IZzTyiBoNpzi2MBGvigaIcsuT+/hpyJLrM0oF27cQiD3YsZcarpt?=
 =?us-ascii?Q?EV9v2P6yvuqf9rg5GOYFuGZhYgzTr2PgLllbVBrRDl2c/5Y64rCBrsvQntew?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427a3bd4-5a76-4383-6137-08dd682562c9
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4234.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 03:06:33.9249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K7d+5bOaeDWb5juY+61neQU+M4ATsjhevparXUuqQlTsuw3S7xhFZDF3MQQj9rSuqsZUifELIZp6GKdE7y8PxtckHgxucbGIajkRH/w3A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6882
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

Although af_packet PMD supports setting the fanout algorithm, it is not
explicitly declared during registration. Add fanout parameter registration
to facilitate users in quickly obtaining supported fanout algorithms.

Additionally, add configuration parameter printing during initialization.

Adjust unnecessary printing to debug level.

Fixes: d3bc77ab05a4 ("net/af_packet: allow changing fanout mode")
Cc: stable@dpdk.org

Signed-off-by: Shaokai Zhang <felix.zhang@jaguarmicro.com>
Reviewed-by: Joey Xing <joey.xing@jaguarmicro.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ab34285ed9..85bc1201b4 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -1167,11 +1167,16 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 		return -1;
 	}
 
-	PMD_LOG(INFO, "%s: AF_PACKET MMAP parameters:", name);
-	PMD_LOG(INFO, "%s:\tblock size %d", name, blocksize);
-	PMD_LOG(INFO, "%s:\tblock count %d", name, blockcount);
-	PMD_LOG(INFO, "%s:\tframe size %d", name, framesize);
-	PMD_LOG(INFO, "%s:\tframe count %d", name, framecount);
+	PMD_LOG(DEBUG, "%s: AF_PACKET MMAP parameters:", name);
+	PMD_LOG(DEBUG, "%s:\tblock size %d", name, blocksize);
+	PMD_LOG(DEBUG, "%s:\tblock count %d", name, blockcount);
+	PMD_LOG(DEBUG, "%s:\tframe size %d", name, framesize);
+	PMD_LOG(DEBUG, "%s:\tframe count %d", name, framecount);
+	PMD_LOG(DEBUG, "%s:\tqdisc bypass %d", name, qdisc_bypass);
+	if (fanout_mode)
+		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, fanout_mode);
+	else
+		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, "default PACKET_FANOUT_HASH");
 
 	if (rte_pmd_init_internals(dev, *sockfd, qpairs,
 				   blocksize, blockcount,
@@ -1274,4 +1279,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"blocksz=<int> "
 	"framesz=<int> "
 	"framecnt=<int> "
-	"qdisc_bypass=<0|1>");
+	"qdisc_bypass=<0|1> "
+	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm>");
-- 
2.47.1.windows.2

