Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D42EC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:52:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 510B94066F;
	Wed, 11 Jun 2025 12:52:13 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
 by mails.dpdk.org (Postfix) with ESMTP id 83EAF40665;
 Wed, 11 Jun 2025 12:52:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1z0+pTJSMiLikxc09NoPHzNmsmrWfpQNAKZpMUH+kMNKf/VdfWzexV34/c2Uc2PLT7u8CgPual3K9WhwRy/kuRSyRaFRf4V37hlTJ/70zYZSAc1ZK+mJOALij1q1Qs2xXkzRXluKIkjMQJ1hDgfos6VtskUd9gEbzDI50sFN7iOPOqAShYm2+0MRyJUE8WeV6HOXblmUcOEjk3mjTr0gdvHcHWeoImwD6cpVvU0RI1f9+IBZ/D4R8T2vKPdM8Pv5QzP0sXWsqR2S0KbebAPwsE2hd7Xw8mUTM9/soTDFhegSpB/Ui1+Qu0iifgH3aQ7AdkD3WvmyRJyNMCLerFg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bzNHB+fr8iMdxTBNxdp4vZJgu3uc98ypnA/di1NeuU=;
 b=wgJnhIVeYWTON7XNTddWAgGR03uM21JyA3VMzZe+CskT+6Is6UcA020MtOl1e/bqxJ+PP5IOtgTNVlpyV07qU/8r5EvwQ50OyM3VRtEWYedsiEg4SMFKOewv3ugYgTf0ryU0NpHyqYdzJ64Zp0YFXFosumBifTvw57IZYFV9YyfEA16xzei0dbCF979bETbaytjKXNXMNU70amEfxPix2NZnV2x+h21v06A2DYBquSbDkk3cf6MSc1gyY5tpXajQtg1BccsmhqD6PsvWvG2bdCOw6DShmWL6dUEuv5Yqz9xsN5efizaYvZ613hL/+8WVzPm8VnBnv7X1Oj+p7Qwmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bzNHB+fr8iMdxTBNxdp4vZJgu3uc98ypnA/di1NeuU=;
 b=VXF+fH4egUqHkiJICFXrjqInRwXk44GV/LZPK0Vm3qaV8tJwMXEll9JbJehUmeG4TOF+RoJDYregllBNWOK9FWp7uIRIpuSL0jvKMevy81yjN9fpSfh5RTg5kn6rv8oRVbSXuW9QMZ+Ad9nSqpPmY9VTYtS9n426ypsNSEn90rCimJ7bXYm0ybuucnHp8jR9wOZCBUWYu0gmV336mP7P+nICkX+TcXwBKWxg2128ZfzQguayzeid6NtCDBQtadAP6dGAz/FxdMeo1rabI7THtWFXXJEUFVx+hleZlOrbwJvNju0jXK/gHRAmEPUruuEcbZWlC0Kx7f1AvCNl60Lgfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:09 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:09 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v4 01/11] net/dpaa2: fix issue of extract buffer preparation
Date: Wed, 11 Jun 2025 16:21:39 +0530
Message-Id: <20250611105149.655144-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ab6d60-b42d-484f-c118-08dda8d603a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/sr2wJTlhIe4ug4h0zge+J8GDPPuYGfJWEf9c8kWhRgciqZTwYDd07AoYjaS?=
 =?us-ascii?Q?sY6Nh4cui7SvTfwsSIdmP+H8/l8sfVNIpDbTstyx6+Qis/LXtfuAloMSBlAx?=
 =?us-ascii?Q?S5xP0INnwOlU3O68+ktddM8mfpDYQdgImH+RY49bReq3XCkyvw+GN548vyRX?=
 =?us-ascii?Q?X7s0J79UYTuKCDrEDKvZvF/o4m0D9zInTHtLOTUNdMedOfNyeAI9p4r0ec2Q?=
 =?us-ascii?Q?+horocRm2u4alQw1ohdPzP50QKdoiUEKPy73pD0BWAvLOuThZnRjh6Y4A5V+?=
 =?us-ascii?Q?IqxTvkyZ8w8bwOUI83KsDOUPxkiUnzvOuL+rZmjEeegnmqvKpmcg/KU/BmBZ?=
 =?us-ascii?Q?PjIya87xULRfbrtecedSQ6oq+r5BIvyxfDD+rEs1TWDtrNAn+23tZq2jpvJR?=
 =?us-ascii?Q?RAabNAYWOA/gwSAaHEspDaiEcwrFoZyJ0COg/ZbcFIEleGt9xVyjjVdCVIYU?=
 =?us-ascii?Q?H0xZCMMx92DwYxcj/qAle7npvVgtOVwvuaMZ+A9uoSmNiez2PabXjuihtaiv?=
 =?us-ascii?Q?IXF8gXww7SCv1GkCdWfD6jPgNnMJ1VK1MR0XLiWjV9afc5fSTrXoHJCRKYB+?=
 =?us-ascii?Q?UUu/yLcUr+6gaFUXhUXJ3gSYRppqE0BDSU4x9/f+i+F2t/7DvmHL2CpCK2pv?=
 =?us-ascii?Q?UpLiJ3mmVaqZTygM8DzSkUxf2aGowvTsreQJ3QYmPTvVS2W/vdPB5kjDtCmH?=
 =?us-ascii?Q?2oOkrCQxIuGUOl6380AtY766cGW4r1Yt4Kr2NF3B9gObZmEskuvD3xqRviCs?=
 =?us-ascii?Q?/YOXBCJtHATLisLL32XevrIKd0v3j+WVnN2U35wMO3UpT1KZc9YjM7hZUYfg?=
 =?us-ascii?Q?VMuRVO5/CxMXl0zyl3AbhncM8Evo31lM0xLtl/P6u2J31HHlM81d9kUxRemf?=
 =?us-ascii?Q?IpNw7sts3/me/Vm3bZ3xdde9k/rIHGHs3RaGaZKUTi8v4KxnhdL2MdxYhnZi?=
 =?us-ascii?Q?qZo/yoXYTgXHpmpVGkEU5oD+UsNf22aQJwH1QTUU5Mds223Kr7syjAx9Okn/?=
 =?us-ascii?Q?EWyBvIVW+hw/o55uB7cFPfww6P3ZxnpPLjmPu9iO9XjmvzIofPrs7l1aub9+?=
 =?us-ascii?Q?WZib3GINTAQEat9tpkRGKwSQxs73V22HrHEInSYSUoU79GbrHLna+DNfeGYq?=
 =?us-ascii?Q?H39GhNlDCmkhLbQNVXNWpe3A7/bM+ZqQyJyuIQTTAZvlc/68J2LwAWfkbSQ1?=
 =?us-ascii?Q?VB5qw8TKognId0bcdkKXyGbbkUVGZ6vxqpU8jLE8Zv1QuRh4HI+J795rSKUB?=
 =?us-ascii?Q?Veil8YlKS+KBZ+xDvcGEdHkNxrMxCPiJed1Pb2n5eokKAZ1awcbi815gjDd9?=
 =?us-ascii?Q?jQ56pZUWuwVivWEKMs6yMEjPoaXIAzuUfV/19uPs22XgUM3daHktVMpXI05i?=
 =?us-ascii?Q?6MVqlJQ2l0l18YpF1eobO4uJKogaF4DXwikKq5aXQyBnxS4iyUz99yECMV4Z?=
 =?us-ascii?Q?lclE9VgBp5KUnrry8wjlWeIdDfpFurEuT5nPupBVA4kOLlftZdm5qA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZqVC62vtKDHSzynWyx5WdUN3X1miQ7NPLvAyDPFnw+ULK0H7vvzbXcpA3Jb?=
 =?us-ascii?Q?PPiBmvkilNkJ6D6Ub3pqdGtlOVnQCvDZrX96AmC8dB7XL3LLcoDg6ByP5at8?=
 =?us-ascii?Q?aaY2DCxgGsLNUVZMHzzehi+kqBQTjrvwutQsVwmdYoQJ3ZgNHF7figTwhViw?=
 =?us-ascii?Q?G/wpg4HfbmOUE4qz+2C9HSxD0XQcfOEUTK8DUgrU8aMrRz7Wo5F5B7P2ddek?=
 =?us-ascii?Q?dx8enF1tWem83t9ldZ6UUWzbRNwfWib5wb8hApYyvE5yKwyjvS+XDQlepG+l?=
 =?us-ascii?Q?tALM7xml5/EmNb7CJkXPoePQzv96w27CRl8YmA8h/p1TRBcB5zD9j36M9svA?=
 =?us-ascii?Q?nwBYZzGS4ky6HspGTPI6Oxxd4CsmwGNPELbnnzACl9QBD+3tI/lmkZzqiFwT?=
 =?us-ascii?Q?QVGbeOWMzyiGmgxEWPwCqknxX+vnvfjSvMv/Bi0QPtUHFOFC4X56d3VFIvzl?=
 =?us-ascii?Q?99prsMXHdwqT2Lsld80cGPM46hhy8N8AYABvRFaWZBSnI3DQy0aXg93qbGn8?=
 =?us-ascii?Q?EPhK0toFmkBzVbOaBLwVI0gMCuLIZao3eU/tb+E/Z0zz+7f9c9SLNLl0YZq7?=
 =?us-ascii?Q?YjwKJmKd7JDME1oL8CdQJIUwqtIjra6PWg2UtVPZday+2WoIHST+aAE82+De?=
 =?us-ascii?Q?FoBdUX0BCYWfx7aiQKR92ROT6ohJEZBUYL6TNXBHWpzn+7A5F1fQ7Irr5ZQ2?=
 =?us-ascii?Q?ySjubus54T5d1jR4OqpAegF1vMMwffJtzRVUssvrPSWlK+e2iETOXjTFToZL?=
 =?us-ascii?Q?BT4igOGnwRHNc8sYKWYg4iKaGCC5CMFrnmbJIa7ibyls/aVFXc6Kl3Fgs1Fw?=
 =?us-ascii?Q?ujE16lEgUgA0ByDbz+ZPkHuLcZ/Y1mYJqaiWqNjBaRCBSmyQ1CtxaAXvMJqn?=
 =?us-ascii?Q?kEk/Ad1tBjxuI5MohQF0n5G68NWN4154gNfgWpUw4RYId7T5ioakPpfv+vbE?=
 =?us-ascii?Q?vnN+UiwoDMzkOBVhN+rkrWuMglmudx09HqG519m4mE66o6IlJWwql1O39jz9?=
 =?us-ascii?Q?AoZ9zfYC9p/puA1F7V8t00/PfqkaNli9YSRS/8DkHeCmAUywvqgQ0CwBora9?=
 =?us-ascii?Q?zoXlmMLuLRg788XUiOihaRLpIP20S/f7tvTOfhomrP0hLtxLVWMKnT7mro5g?=
 =?us-ascii?Q?xV8cMRlIxWcj1L0Mo+gTG6FqoSonomTUJoICI/H29n/39W9iOCOT1UDoudRG?=
 =?us-ascii?Q?Q5PDQJ9GSwC2+oBmdMwIxHWOEW/4O7bI0hz8ht6TX6g4688kqGdKsHko+/CB?=
 =?us-ascii?Q?+7VG1upo6xhXhLRTZqBUb3hKiVuPYclBauP0CiR6gh53gmq/WH20V9jDlkeb?=
 =?us-ascii?Q?7BpjsBySZhQPZjunlUKbRQLm2a0pA/okRgHA5dIbMvgCBCrxLGuoyIl37UTI?=
 =?us-ascii?Q?rwlx6JLuOVUe01ncIvq+AF2P2AIAgYF7nUhmyprlUXtO0794W2V5uhA6aYNA?=
 =?us-ascii?Q?Nw29ao5immYyJjL1cf2oftuaE0uiXxY8cB7/AoZkpfALRkDoaDlGK6d7vH+u?=
 =?us-ascii?Q?XX/155J0WeZkyJWMoa7acK75r0CBH6YeX3Q0dNCHWOR1Vhhl1bXLV49jAmbK?=
 =?us-ascii?Q?EhbLuY+1cteb09xrEaI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ab6d60-b42d-484f-c118-08dda8d603a2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:09.5874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSJlR5vCMr1jTLctZkvQY8M8xJQOAMeIirW0Iq3oPcOHXDMy7AbfXm+c4oyuJ8NY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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

From: Jun Yang <jun.yang@nxp.com>

1) The max size of extract buffer should be size of
   "struct dpni_ext_set_rx_tc_dist"(488), which is greater than 256.
2) dpkg_prepare_key_cfg is responsible to clear
   extract buffer before preparing.

Fixes: 25d0ae624245 ("net/dpaa2: check IOVA before sending MC command")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 4 ++--
 drivers/net/dpaa2/dpaa2_ethdev.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c53c2d0549..c154a574ce 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2788,7 +2788,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	/* Init fields w.r.t. classification */
 	memset(&priv->extract.qos_key_extract, 0,
 		sizeof(struct dpaa2_key_extract));
-	priv->extract.qos_extract_param = rte_malloc(NULL,
+	priv->extract.qos_extract_param = rte_zmalloc(NULL,
 		DPAA2_EXTRACT_PARAM_MAX_SIZE,
 		RTE_CACHE_LINE_SIZE);
 	if (!priv->extract.qos_extract_param) {
@@ -2799,7 +2799,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	for (i = 0; i < MAX_TCS; i++) {
 		memset(&priv->extract.tc_key_extract[i], 0,
 			sizeof(struct dpaa2_key_extract));
-		priv->extract.tc_extract_param[i] = rte_malloc(NULL,
+		priv->extract.tc_extract_param[i] = rte_zmalloc(NULL,
 			DPAA2_EXTRACT_PARAM_MAX_SIZE,
 			RTE_CACHE_LINE_SIZE);
 		if (!priv->extract.tc_extract_param[i]) {
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index b9dd9b22fd..b501fc091a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -31,7 +31,9 @@
 #define MAX_DPNI		8
 #define DPAA2_MAX_CHANNELS	16
 
-#define DPAA2_EXTRACT_PARAM_MAX_SIZE 256
+#define DPAA2_EXTRACT_PARAM_MAX_SIZE \
+	RTE_ALIGN(sizeof(struct dpni_ext_set_rx_tc_dist), 256)
+
 #define DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE 256
 
 #define DPAA2_RX_DEFAULT_NBDESC 512
@@ -60,7 +62,7 @@
 #define CONG_RX_OAL	128
 
 /* Size of the input SMMU mapped memory required by MC */
-#define DIST_PARAM_IOVA_SIZE 256
+#define DIST_PARAM_IOVA_SIZE DPAA2_EXTRACT_PARAM_MAX_SIZE
 
 /* Enable TX Congestion control support
  * default is disable
-- 
2.25.1

