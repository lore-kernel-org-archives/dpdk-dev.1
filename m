Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94191C54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4489440668;
	Fri, 30 May 2025 09:14:25 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
 by mails.dpdk.org (Postfix) with ESMTP id 4242E40671
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIW0Of5ZnAW7Xz7ZVve4NfqGyo/+PVYeLMaBJQicPbk6PGDrXW8cXUbBCArqOz7KjFRrUiyLzuZ1HDyvMAdSrepbsw4cwY0ZKLRRX+aG9udqsXI3FMAREOmPKkMzDxU6KozIM56y8DRE0ZBqYMvprg4IIakAVxoPPeHPQAhcbxmMSGrC87vmz2ALqPFyBKAguXu44i2NQMCGgDu4R0hsyp02zZ06ucI9SESUAIqTGm/76Z7M+f7BmSLtNEsb/QcBDwqS49uxHrwDQBKPTLzvM/PgqvIzxJ0OPhyhVn1PMvEFfoNQVVpM3Ll+fGZ/b4Wp+R/fq33rtyp6FJDiwYQIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93MdefBw0jA0A5+WRy0g+aG3ddRyCdD8Xq2wUWWv9ZI=;
 b=P73mDegupd4Gbpcl63Ulsut0yxbUEP2LY90AqAZWQLtIXOQuR/iEQBrHcqoiHmcPuo+MW/PbhV1T3MRMhbZdK063Bw2Zr6JdnfThn/NGMPyJRz/wfQEjQMH4LRm8EUB+klYe9+kHnFgHEPZXZ3wKWmSLKK75okZBueWy8pJB+dGzYhU6EYKGkWF8Il0TcAr36gHQYiLoNOoYy7zIpKYx9lssulGIWvdENYSuTMe3xtLPlHChdHebLNr8+oBkimImvH0VmVs0L0E5fd2n5v0fZDsjyRatDKbyOqVMSJHMfQFnOTq+Ezk/GrkmEIrOppzVosiXiRxBgzV0tZRlQJhD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93MdefBw0jA0A5+WRy0g+aG3ddRyCdD8Xq2wUWWv9ZI=;
 b=HckmvKIehu5m0FBv7cuMMrM3ktaZiUWjksINEY1tmwx1ufKvfpZTDPlnfumKLXbyyUckNqI48kn3wHIzLkp18JzPrHGjt2T5Pj+mrwgCZ/yiOVqZkPUH4vB+czQ9yQdixPw0zn/BktScHA2yRKx3sWiAlXw0y4xHIUK23Pu5rtL76ZG0djQPaU4WIVmZf42yvJzGkxTQgMsKdTlMSoNPbuqOWwg7hppOaL3bpP88OzRRS5EC2Vt2afY9HujWx4m8rpCV8DwWwg0VSW3Uf0TEWhqmuDwxP5P6vlpsPRXc12HHWYyg7fKqO52Hi7c8CyPma43vUj3UW6I1+uF04Iuwfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 07:14:23 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:23 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 08/11] net/dpaa2: support dpmac Tx stats in xstats
Date: Fri, 30 May 2025 12:43:41 +0530
Message-Id: <20250530071344.2939434-9-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f4b1c8-81d5-4a40-cc64-08dd9f499a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AeJzWgKBmr8SfLJ2vuuhrTXjHnPjUkAjiwHjG0BI4I+T0vw0RL3+FCP9eBVm?=
 =?us-ascii?Q?F8rlrlQJTYY9gnloxzbZxUbb5X+ARXbLKseHdDdxWbQyVxFQ3+eEfuNhaQvn?=
 =?us-ascii?Q?VLV7n7qPQ3NE7FEb8yvh7JMv3beaoFtnVovNgDGLm0LV+xc/5e402Lc57Oyb?=
 =?us-ascii?Q?cL9dShoxDPupQ9n3tEZ+AlBQzeKB/Kif8qVO5y9E1tbgl9D56p0EmWSx428S?=
 =?us-ascii?Q?Mysksk1bZt+fmNmMrvyMB4ZZhWlU1e9G8bxO20kElfm3fb1l48tZQDV+oZna?=
 =?us-ascii?Q?13ptgcqfRZTKIbMj3x3TwmcYY9mDcs8KpWn+SitAsOV0LA5g3jWgswrumCwO?=
 =?us-ascii?Q?fv5ItaTQSHVNe7xFz6BOo/PZLGVwQJUMuMjH1918Q0j46V/DEVnehuQSt8tK?=
 =?us-ascii?Q?prJw/noKDtZg56auaoRfBNpde2b9b4olUc3IPv5aL4alRE1zU22GxvWuQb7p?=
 =?us-ascii?Q?JMGfcpX0HslVLba7U1+OVKqY5AQh4XIH381R+Skx7NQflNVR+6zjn/FkXeC+?=
 =?us-ascii?Q?G8ZwLi7x8SRebPbv+oCS8tCDOgTYjZZcKL8xIHp0g2d+Nc3UMp4LYmFT0FWP?=
 =?us-ascii?Q?Z2eB6CTooJT++/ejV/qWo6S1jY4cgq0bWCE+KSo1f1A+2hEx75yHVluHXPzv?=
 =?us-ascii?Q?/I5cN1gQ514pFoEVt8Z+GV0AQMdWtYk8iKFd/gG49ixo5Oqdh2Q4jeRAaOsc?=
 =?us-ascii?Q?vPjtVdSGsEfBd0TD1eZ0+EZ22EHV51TXgvXTMSYwEHoAJjkvFJVoESfkimoF?=
 =?us-ascii?Q?/nLihscNNR2/nZcwi8Z6IqCNDXBNZo3XpwSxFNJFm4QfjVDapS9NvHE2LQ8t?=
 =?us-ascii?Q?q9p0n7uk/MhLAArdLI7vGwpDVnBkB3QUzxmx/+qKbTHJfhShtKXfAF14TJL4?=
 =?us-ascii?Q?H/GWbBbcX2Mb3OeKMGKI1qNFb1cHGVTN6Mt6ydHASTYNcHcFm9BpgxNW1phq?=
 =?us-ascii?Q?UDBQEHLkQVAkqfwJZgMxj0knoZzGvxJPCdvqP92MfJGZIZCtqq2Dq8bnqxGA?=
 =?us-ascii?Q?/mc1Axzs5aQ3a3Zc03RzqAoasLcnF3G+v4Sk/myWH/evKCLUxarbJXEG2DLD?=
 =?us-ascii?Q?4OR/D99bb8iE9lzhJi9oZf59oV7u2mHtLo8klAQvZo8jxz7OtRAa+iImXk4F?=
 =?us-ascii?Q?tyeKjwNA5jPLBWf3pCyUlWEOeanwdQbmGso9a/fddQVUNyG+9FsbhHJbEBX+?=
 =?us-ascii?Q?HDGpmhuFopdjZLjQfRsvXG3gQBF7cM6KqyxI4XP0f2lRnixbdtEe3bU70Ihi?=
 =?us-ascii?Q?G7edC6NAQmgvZNMsclADxekBoWd2kCbjftBj3TOaxCvXdEstFWNhBS9fu+LW?=
 =?us-ascii?Q?KJ+yyrAN1264jPtA7CU4yCVZQruIU2Wjg+gUezxAz9gwtClUgKpYwup7BpAy?=
 =?us-ascii?Q?0JrNQp/QnCaZ4ceeoIDOfRa6Obx9XldvFUPHIvJkNXC0Z6LsIJsoRyaYc1bN?=
 =?us-ascii?Q?CkAfzIwlA6r1tTnGKVop2+RK5v9eIhXrMEdMTpvUClq28wbXhKtabE389eAW?=
 =?us-ascii?Q?yu9lN7y1efW//4I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02cerCqLQJq88T6I+C8LFqOHS3Sw4XE9Tv85pfRNudzL9pi4gJLChNBtV0tb?=
 =?us-ascii?Q?KcsDiB3Xl69AguzMsTBcdWVJgT2YPiYTBZgIWoCnZgIhhPQvVqD8OdEiN9Mr?=
 =?us-ascii?Q?OvGwvELyonmsEIMgOmugqlBwnvEUNxBM1/fcMUBnPW6XUMBGgARkbT+2q/LP?=
 =?us-ascii?Q?N53ruWzvTZ76imTU7Zc08sppYg15dukrRZJzeShD+DGnEFI/aDIZHWrStiDr?=
 =?us-ascii?Q?n2yvHT2F916XJbt9KAHfvbcoB8LsLHvDet+PH3tsyjVyhGQWkhgLIVUQk9LZ?=
 =?us-ascii?Q?22R1jBh8ut1KQCu/LUHpAGbBIzTNbpqervcssBYxGdLNChwq+uXsrysQemZB?=
 =?us-ascii?Q?gHECxh2XVJVR19XO/REyFhRFGZOggXZVuITSCPd6A1DwpvtSfEJOgu0M0E//?=
 =?us-ascii?Q?NzjOkZ+1EREl2vGdjgSEhqmtTyMaSTm3Q4Qdjs3VlN0q8TTPDKJRI/uji2iF?=
 =?us-ascii?Q?qagxVDSWS61OPBmf6tyylxgz2nwHdVf8x5D+KTDfHYuL95Tfz079FQ9/EkaH?=
 =?us-ascii?Q?o6bkFELdMS4GiRiXqc6/o+82PZrCKb27IVuw8DPAIHEyfy6UmkC+jxgi1Y53?=
 =?us-ascii?Q?bn7duTk9cDMCvg5XVj9T5rlcRpkEtPjS0G9AL35LqiqQf/0+ZJKQLrzRKlwE?=
 =?us-ascii?Q?dhwJbmA7LTo+uHWlpgbWXTJ0E0sr669DQ263y+cpvhfOvqDIc+a5ldq6rJxY?=
 =?us-ascii?Q?HXMVsrL7C6JhLg8RcO0BvxMjDaJCJmmXmS1UxnMD3ReAdyuY74KhX7wVRo7U?=
 =?us-ascii?Q?TcIYagUv2dk245sUmzb9LwvZiooSrRC+0+807aQSbu8r3KKljL+JNdPjRLX1?=
 =?us-ascii?Q?23ROLSKQx0YXYsOvDIKuhuXtqrm3PujvKhqrq1c1U+ne/0Yk9aNM95dJYaq9?=
 =?us-ascii?Q?Ka9Agl/vOFoQ5vKeKiYRqjGnCfHoFFHj3iSykv6Z428K6oosX9uTaNXrj5r0?=
 =?us-ascii?Q?Y6dby5Pf0O25dNzUtfkvMh9njOtZIbGDHI0irwR/ObjXKp9gf6C1/n15rO0J?=
 =?us-ascii?Q?uLgCOapVrWjpdPGwZjKHrsKFAwRx64/ynMnhiuvgJWVaqrfKwovNg85HTnMl?=
 =?us-ascii?Q?ZnWal7vL0rpUYqqIyPl2rDdJW9acWfm9aUYIgHQQ5oSNsmB4t8uQI/6f4PlX?=
 =?us-ascii?Q?jzdXZJGG7zY6EA2yQGi8N86NgoozJCXEMbStOQnxvDB/BRDkP9LaAZk1Qark?=
 =?us-ascii?Q?SyGRfDgAMsmrG0WIRBWGayMCCk2jsup8gjVHT/JwfCqs1IoJDeof6a66dytw?=
 =?us-ascii?Q?AXmojQfY3AVooIzxAqkcpsw7CqH3Ai5AeqF4+SOQ8EQX4y8SmZ7Z9eiKmt1k?=
 =?us-ascii?Q?lDNpIeJzcQFJC7bJpYVCoWeFMFFsukPoE0FmynWNnrS5T5XvbD6Wnj1ZZ65M?=
 =?us-ascii?Q?MqrB6ORWPrnrHpB4gUw8lWir9qQNkj0nzHVdBEHPK0aP55IQPEt6QN13ACLG?=
 =?us-ascii?Q?SEqjXY6OZPZHcQ9tLIl3YAOTe/vF3JxTBCx43bLaMyx5amU97JTN/me9t6/v?=
 =?us-ascii?Q?jYhI4Hmjjw2+K/VHXGS+nQuzyBwx103aDkhDnM+HAYK4oHYvCKE96EkOi6vR?=
 =?us-ascii?Q?c34PU636qp/OzfTb+Fg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f4b1c8-81d5-4a40-cc64-08dd9f499a91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:23.4088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoJsP2IE2F6thI5wI7XZfet6FreImOcFFK18RbkeZdmlvpQejtCgeREBhEsJTiGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

Added all mac counters including Tx stats buckets for
packet sizes in xstats.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 20 +++++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h |  4 ++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index bbf4df69d4..298fded65e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1,7 +1,7 @@
 /* * SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2024 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
@@ -134,6 +134,24 @@ static const struct rte_dpaa2_xstats_name_off dpaa2_xstats_strings[] = {
 	{"mac_tx_frame errors", 0, 0},
 	{"mac_rx_frames ok", 0, 0},
 	{"mac_tx_frames ok", 0, 0},
+	{"mac_tx_64 bytes", 0, 0},
+	{"mac_tx_65-127 bytes", 0, 0},
+	{"mac_tx_128-255 bytes", 0, 0},
+	{"mac_tx_256-511 bytes", 0, 0},
+	{"mac_tx_512-1023 bytes", 0, 0},
+	{"mac_tx_1024-1518 bytes", 0, 0},
+	{"mac_tx_1519-max bytes", 0, 0},
+	{"mac_rx_all_bytes", 0, 0},
+	{"mac_rx_fcs_err", 0, 0},
+	{"mac_rx_vlan_frame", 0, 0},
+	{"mac_rx_undersized", 0, 0},
+	{"mac_rx_control_frame", 0, 0},
+	{"mac_rx_frame_discard_not_trunc", 0, 0},
+	{"mac_tx_all_bytes", 0, 0},
+	{"mac_tx_fcs_err", 0, 0},
+	{"mac_tx_vlan_frame", 0, 0},
+	{"mac_tx_all_frame", 0, 0},
+	{"mac_tx_control_frame", 0, 0},
 };
 
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 532c257203..570b1608a0 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2015-2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2022 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
@@ -131,7 +131,7 @@
 #define DPAA2_PKT_TYPE_VLAN_2		0x0260
 
 /* mac counters */
-#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_GOOD_FRAME + 1)
+#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
 #define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
 #define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
 
-- 
2.25.1

