Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D89CCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DBE940A6B;
	Mon,  6 Oct 2025 10:04:56 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
 by mails.dpdk.org (Postfix) with ESMTP id 7997840672
 for <dev@dpdk.org>; Mon,  6 Oct 2025 10:04:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5WyHE97xz5kKuT3JlmMTtNNLs1rEQJDwaICPTmy2kalGNClsUpmKdlkktR7FUwyxw+5o+WJHXIk3VQ7o/JIFdkTNB/Q+ZIkGlqlrvrgpErUe9xCOw3MbeNXBUoBRtBAP1q/CC4WoW7otHBDM9KxuEBCsnzkCCZ1TXiPkriE7aqhJNPa8zUiD8SNqGWSmFIONB0jRD6SX4hUKf6rT2AfJ7w67RsnPIrT+vQ807mo40CkAmJZqJHixeOGNm4qNbOYowuNvVQGfacQQxT/e4ob7quTGwc9QFbwBdz0rCh8WtI2nc88PtnQ2PGPWRFrZ8yu6+WAfBjH+FQWfVc9zp8CrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef94kP4ANl3ritbTY2h7uG4qJi5C23hEFuHuWOvcRwo=;
 b=Ab8b8LeC0uW3L+A3TOCOM0mWoXOSep8IwlIm5oGayk+6J0lKN+eM+ZG8T/wpZ5ykoHVHER/GVesG3+Mch1e/q39kzfcRO+aK1gTY9eZvKnn3T2IAGN0NokmLU0/polMZ9Mz1VurBJoU2dCKkZ+0tRFO06y6YwctVTFQOMtJ8eG0JAzIpAdAtFLlFtPgJ/khCkU8aRvKaIy1dVQXpoJ3BGnnweYYrhnbgq3vlQjggqhyDKCfaSOdSdvIlNKvm9HrUiBNaq/g/JVtnjBJaU7Ayidh8NV6kLzzAR3c2EPpBJYOG2zTNQE9S7BMNNqQnWCl/QVegDiERjh8ME5BGg5bE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef94kP4ANl3ritbTY2h7uG4qJi5C23hEFuHuWOvcRwo=;
 b=FjTUSJX08G3DCQp+x+TLgQQYTM32HnP4F4SnITqi5Ox6XUuZc8L75Y6t29yMCwFbP41dYQfIYKuzsd8PI1srlIKUfRCR0NH1qHF6ROi8e7ysma1fl6urAp9X7CUwdfA/Ao2xrbd6vow+dJ/Fnjavj2mNfCfAouueCKflIsdvCTD3aG2M55aUOzBV2satoeCjBifaYIqn5k72DcLx5PQ3xMTxR9KgBDh9fFh9bxFTbhaHM4E6Ax/F+C0K/caqRYiduLuIQHMTkCc7PY1iG2psTPHnx1KKbzsC2FZiGU4kenICCnTq1/lvLL1m3+ZKedcBIxrwmgSCL452UGAMNsrd/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM9PR04MB8098.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:47 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:47 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Subject: [PATCH 10/11] net/enetfec: support to set MAC address
Date: Mon,  6 Oct 2025 13:34:09 +0530
Message-Id: <20251006080410.1433284-11-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM9PR04MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 79feb7f4-3f25-4210-c8ca-08de04af0468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5o3l+J24pLWkCtZaTVlg5UlSjATolkZywH9T49GQEdBjkEkmhVUpFcWNHblG?=
 =?us-ascii?Q?KMkHzMMwVxi3lcoN+XjyJgZAUnS7Rp3r3waQZbU1gHFIsrXidGxg4t6oEyCt?=
 =?us-ascii?Q?+IXfTYVaJcsj5gwyUDtjskXjBWhiZnttUjjT4pcT5H3cJBWn3IGbOnSIxofh?=
 =?us-ascii?Q?Ab21vDY79oSgAVaBIRTFTb8XFKfRllfI/YPc79WeTjP0KBiMDTlrAFJfYZGu?=
 =?us-ascii?Q?5Lpk49zKbKL0m3HVUWxqMBKQtrUstGReAgNc/GzUbo6Rtnfla+E90kPwlFxi?=
 =?us-ascii?Q?lGyp0WbM1iedDT9N3mEy2ohSWiqpRwzi22UrPn3QCpFPnvE1pF7yMtkDnBSF?=
 =?us-ascii?Q?7HTRxM1fUTZgYQG40CvvMpKb8xV2CR72Wq2dbqRs7ByEcIyLFrY2U75vG6ps?=
 =?us-ascii?Q?Jjq55ba9fMflFvTRLItV+cMXIXrOfvX4JA7s97bJe9tWvkbkhkMc4s7jmqOo?=
 =?us-ascii?Q?lqQDop1TEnOqQySWaUmfIwc4kA8ybeKiM7LtxSvZ8cnG9uAQLrfBWBSQ0DN1?=
 =?us-ascii?Q?nhcB1M3H2AJA/il26Tzxhq2UaXkxAhR4tsnU7wGz276awhG3sdHHlgzOz5fN?=
 =?us-ascii?Q?keoaTo9US8OsXGdnO57tjJYi66Q1o+sgwJw7jVoiBIqrqXyQpqhI8LoVrtMr?=
 =?us-ascii?Q?UcwR9FaM/gUqYZzspkYT7Hmx7kw4taAfWM50UmH3+wFg8c0f7C2617XqyxgH?=
 =?us-ascii?Q?506kchVJ33EFKFvq0gRNau19txPGNM96/Szn4j8vGlkgAI/GN2M79Gh4OS9A?=
 =?us-ascii?Q?d4L39uI0J0DeO3jKGElodjHE7JuU94ndpDRz+bhtq0UkmzkKOJ+5pcylWXmP?=
 =?us-ascii?Q?bR3aEgmRZbyBi1mxLLCE2xbDThOh8r/Ld8NyJzVZg7lht8AEmlbFXhMgLiPg?=
 =?us-ascii?Q?5NYYn4XB0DVWQrKYIDsEHUa+yLrSkKiWWKj30bpIhXTtsNIYczEvXtbt0d51?=
 =?us-ascii?Q?wYDzYZLoTWiwbGnBj5zexXgr0HfV95J0iUTARNJ426jrTH/pPDlAtlTkfXjO?=
 =?us-ascii?Q?3qEnJR/ysEoQoJyq6/nZGc2VSWFC37wvAH1Xehg9DS2f1gZUk7T+4tH2z4SD?=
 =?us-ascii?Q?DA/AseN4xfRnQL2VnRYTjVRZh+fVJ9LORqcSm4oTTDeO0xwjKQxuQtLdhylO?=
 =?us-ascii?Q?vfrTLt6/VYgtvN28RBEyEM8TH/L30edZMgUYYqU0WI35I9i6riVrIu7NvF28?=
 =?us-ascii?Q?OA7HOrAp71oklOV+YQe0yJh+Hl3AX9uOPQeY1/ojGDsvRwrvoRinzdE2QB7F?=
 =?us-ascii?Q?gFR7CGZSghu6jzMl3hrj5zHTXck4nLR9R2kr+jQcdDMAESBf2EWSA9B0Hymg?=
 =?us-ascii?Q?EU+qpw3fsY+Oa4h8/VtInYc4YiX+JYyUBx0XoKeK4rs3koBidZGifmQSXDe9?=
 =?us-ascii?Q?oJEdLbHzl4B/RZ50QakLE7OYSzLkKO+UZrgL/Tui8/it+Sw2CHZqUqWwWItD?=
 =?us-ascii?Q?xr08KVdwoOLGfgN/glUB2+7iMkbhcmnPdfgtRIM2HLGxTQK//B5rNRAN1i4o?=
 =?us-ascii?Q?w4Mgqt2hnllPryFiP1+2xugiwLDLE66z1YYw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oYrdtUBdc3TvFedy5UOceagh6P0eFbNkXHIimXWx2qGzqbSjoAO0v1SjQkzV?=
 =?us-ascii?Q?4Ine1ob3mKinAiVqt2ZeaM15HO8OMyTo9DUhxeJV/Iif7tVvFJqjrSCiqutB?=
 =?us-ascii?Q?KPzgKVqI2+kLNm2x1JwtkoxESC30ZOGO4mkpDLPJ2ymyT9BQqhf7QVXp+C1k?=
 =?us-ascii?Q?XKIM9n4mH0TEJ2bHIJg+ykAoFiqZxuTMKHr2V/22uRNcqCcWV+1HUYj78YJ5?=
 =?us-ascii?Q?5PCmJD9m9NbAClqLac8gD8x+mdpey6JtXVp6g4QScBrOS5dTjb4SVASMtOaP?=
 =?us-ascii?Q?wQ6kKcUZ7O3ignLNWx0INUxK8ixdfWtjPPx9MRKNBJT6l4KdDxNSh2SW24gf?=
 =?us-ascii?Q?Hu5zDJXfY079I6ggzUZcdnGgWebGkcbdm0jW/T02MOZddVoxfI4OplL2QHJO?=
 =?us-ascii?Q?9VxkMf5xhXlrh0R1Pgxmj2viMhcnrzqCXUkfeovFbb3tFJ/sr9tftDt83iT4?=
 =?us-ascii?Q?cY55ItPxS3gUKRTdRFCO8r3cTAXiA8dVLZZdfsW60PczYlN3u+rQcT6Q1nKC?=
 =?us-ascii?Q?9+mmZWBj+/4kphEHstuz7NA6SEHrlZ6gbuAZU5utYtbwAePp7M7fmSjhCwyK?=
 =?us-ascii?Q?d2DEcYMkEsOTkbI7MhzEpizLaReZITTtVLgE/XczWdWcbnkSMM0HaTy94AzL?=
 =?us-ascii?Q?FIXnhFhyTpEdy1iaFMYOYrWNnnMf2l4ItyTpY8Iq9XdDBBxmrNFOZdAgh11d?=
 =?us-ascii?Q?D3Eyk9KSps4iR91F9/ALxONDuGCbjrw3IMm3fWXokdO27ENqjO48GOZGkki6?=
 =?us-ascii?Q?a9+QaodDCynh58zX1AX+gi4ow/dSFmUzP/kGmMW+fhnL/+L17E3AJXNlNDmS?=
 =?us-ascii?Q?Uw0WTi1U7LwzB+0yGpvec6zvpvseUbrWGXiDr58EhRFL7F3L475nQHmEEDzK?=
 =?us-ascii?Q?GBQsXADyIYv5wdc4zNZHdT9HFcl+dlnuZOK1nwACPXnLbegSBOlZupgiXJEK?=
 =?us-ascii?Q?PTkv4wzv+xddvZe88GodRfGHWnRUWDY6+Nh+eBbFric9gD8CHHLZzJqzbxPG?=
 =?us-ascii?Q?J+f7OQNxswuQQAPjoY71ufWDl1t7o4QLFpzog8bQ21LfIJ/nfXQaLXWYkl/M?=
 =?us-ascii?Q?8ElZRBJVa/WsvsH+IyOh1IyRso6kPxeaTN4y4rLCOQa+EUlUaU53oLUt1gGS?=
 =?us-ascii?Q?91TAnv+g+5ojF5Bso5SSQfkJu5K6lriNeTfJ5gIo78n3UBYdgmpxzrRyHGYV?=
 =?us-ascii?Q?3p8ZbHUj22rKW14pFd+8Hf8y/n2gK/mo0svLeUB9zoQ4diTKia7awU8iqgwd?=
 =?us-ascii?Q?QrUqp8PPJHuXaGFNpVu6B3UQ952mbZU9R2ngemGnQ92IqDG2+dmF+BxGkjpk?=
 =?us-ascii?Q?lyIdYd8rkVUasC1tqP0QhiWZ7L4Mt+29XUJICxr+M6lMJ0ndaJYdMMNpm2wG?=
 =?us-ascii?Q?j/oCDaYtXqBRPeau315ee31rE/1Hz948XPxPXdM2zLkr02elXbIsAlkGBcOA?=
 =?us-ascii?Q?mJMcMYtSJCKpr7Ugun4Yrhl7e6531pCeJ0az6JIAgCDjUqO7fwHXosT4zHpR?=
 =?us-ascii?Q?0IzbYdvvfab0dUxsVLhP9CWMmex0LetWKl8Ce2x/CtfuM8qD1fxtTAy+DD7E?=
 =?us-ascii?Q?WGc6nCs3JTrMxHe5SwXhu681fti2Zeb7t+sCQHc0CllpeMI1BysPj7crrinz?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79feb7f4-3f25-4210-c8ca-08de04af0468
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:47.4739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2i2B2fQOAYZanUv5uQnGvqf2dUUFjY44berRaZoLvPcgm6AoyvXuiUwjj5I1O7J35W7U38cR+3ovLmrdlTmGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8098
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

This patch adds the support of mac_addr_set.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_ethdev.c | 76 ++++++++++++++++---------------
 drivers/net/enetfec/enet_ethdev.h | 30 ++++++++++++
 2 files changed, 69 insertions(+), 37 deletions(-)

diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index 6d4d3e0fc2..959d5d4a6e 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -14,30 +14,6 @@
 #include "enet_regs.h"
 #include "enet_uio.h"
 
-#define ENETFEC_NAME_PMD                net_enetfec
-
-/* FEC receive acceleration */
-#define ENETFEC_RACC_IPDIS		RTE_BIT32(1)
-#define ENETFEC_RACC_PRODIS		RTE_BIT32(2)
-#define ENETFEC_RACC_SHIFT16		RTE_BIT32(7)
-#define ENETFEC_RACC_OPTIONS		(ENETFEC_RACC_IPDIS | \
-						ENETFEC_RACC_PRODIS)
-
-#define ENETFEC_PAUSE_FLAG_AUTONEG	0x1
-#define ENETFEC_PAUSE_FLAG_ENABLE	0x2
-
-/* Pause frame field and FIFO threshold */
-#define ENETFEC_FCE			RTE_BIT32(5)
-#define ENETFEC_RSEM_V			0x84
-#define ENETFEC_RSFL_V			16
-#define ENETFEC_RAEM_V			0x8
-#define ENETFEC_RAFL_V			0x8
-#define ENETFEC_OPD_V			0xFFF0
-
-/* Extended buffer descriptor */
-#define ENETFEC_EXTENDED_BD		0
-#define NUM_OF_BD_QUEUES		6
-
 /* Supported Rx offloads */
 static uint64_t dev_rx_offloads_sup =
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |
@@ -298,8 +274,7 @@ enetfec_multicast_enable(struct rte_eth_dev *dev)
 
 /* Set a MAC change in hardware. */
 static int
-enetfec_set_mac_address(struct rte_eth_dev *dev,
-		    struct rte_ether_addr *addr)
+enetfec_set_mac_address(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 {
 	struct enetfec_private *fep = dev->data->dev_private;
 
@@ -588,15 +563,15 @@ enetfec_eth_init(struct rte_eth_dev *dev)
 static int
 pmd_enetfec_probe(struct rte_vdev_device *vdev)
 {
+	char eth_name[ENETFEC_ETH_NAMESIZE];
 	struct rte_eth_dev *dev = NULL;
 	struct enetfec_private *fep;
-	const char *name;
-	int rc;
-	int i;
+	uint16_t *mac, high_mac = 0;
+	struct rte_ether_addr addr;
+	uint32_t tmac, low_mac = 0;
 	unsigned int bdsize;
-	struct rte_ether_addr macaddr = {
-		.addr_bytes = { 0x1, 0x1, 0x1, 0x1, 0x1, 0x1 }
-	};
+	const char *name;
+	int rc, i;
 
 	name = rte_vdev_device_name(vdev);
 	ENETFEC_PMD_LOG(INFO, "Initializing pmd_fec for %s", name);
@@ -637,8 +612,12 @@ pmd_enetfec_probe(struct rte_vdev_device *vdev)
 		fep->bd_addr_p = fep->bd_addr_p + bdsize;
 	}
 
+	/* Allocate memory for storing MAC addresses */
+	snprintf(eth_name, sizeof(eth_name), "enetfec_eth_mac_%d",
+		 dev->data->port_id);
+
 	/* Copy the station address into the dev structure, */
-	dev->data->mac_addrs = rte_zmalloc("mac_addr", RTE_ETHER_ADDR_LEN, 0);
+	dev->data->mac_addrs = rte_zmalloc(eth_name, RTE_ETHER_ADDR_LEN, 0);
 	if (dev->data->mac_addrs == NULL) {
 		ENETFEC_PMD_ERR("Failed to allocate mem %d to store MAC addresses",
 			RTE_ETHER_ADDR_LEN);
@@ -646,10 +625,33 @@ pmd_enetfec_probe(struct rte_vdev_device *vdev)
 		goto err;
 	}
 
-	/*
-	 * Set default mac address
-	 */
-	enetfec_set_mac_address(dev, &macaddr);
+	/* Set mac address */
+	mac = (uint16_t *)addr.addr_bytes;
+	low_mac = (uint32_t)rte_read32((uint8_t *)fep->hw_baseaddr_v + ENETFEC_PALR);
+	*mac = (uint16_t)low_mac;
+	mac++;
+	*mac = (uint16_t)(low_mac >> ENETFEC_MAC_SHIFT);
+	mac++;
+	tmac = (uint32_t)rte_read32((uint8_t *)fep->hw_baseaddr_v + ENETFEC_PAUR);
+	*mac = (uint16_t)(tmac >> ENETFEC_MAC_SHIFT);
+	high_mac = (uint16_t)(*mac);
+
+	if ((high_mac | low_mac) == 0 || (high_mac | low_mac) == ENETFEC_MAC_RESET) {
+		uint8_t *first_byte;
+
+		mac = (uint16_t *)addr.addr_bytes;
+		tmac = (uint32_t)rte_rand();
+		first_byte = (uint8_t *)&tmac;
+		*first_byte &= (uint8_t)~RTE_ETHER_GROUP_ADDR; /* clear multicast bit */
+		*first_byte |= RTE_ETHER_LOCAL_ADMIN_ADDR; /* set local assignment bit (IEEE802) */
+		*mac = (uint16_t)tmac;
+		mac++;
+		*mac = (uint16_t)(tmac >> ENETFEC_MAC_SHIFT);
+		mac++;
+		*mac = (uint16_t)rte_rand();
+	}
+
+	enetfec_set_mac_address(dev, &addr);
 
 	fep->bufdesc_ex = ENETFEC_EXTENDED_BD;
 	rc = enetfec_eth_init(dev);
diff --git a/drivers/net/enetfec/enet_ethdev.h b/drivers/net/enetfec/enet_ethdev.h
index ee5c244c91..4c063d1799 100644
--- a/drivers/net/enetfec/enet_ethdev.h
+++ b/drivers/net/enetfec/enet_ethdev.h
@@ -20,6 +20,36 @@
 #define OPT_FRAME_SIZE		(PKT_MAX_BUF_SIZE << 16)
 #define ENETFEC_MAX_RX_PKT_LEN	3000
 
+#define ENETFEC_NAME_PMD                net_enetfec
+
+/* eth name size */
+#define ENETFEC_ETH_NAMESIZE            20
+#define ENETFEC_MAC_SHIFT               16
+/* mac addr reset */
+#define ENETFEC_MAC_RESET		0xFFFFFFFF
+
+/* FEC receive acceleration */
+#define ENETFEC_RACC_IPDIS              RTE_BIT32(1)
+#define ENETFEC_RACC_PRODIS             RTE_BIT32(2)
+#define ENETFEC_RACC_SHIFT16            RTE_BIT32(7)
+#define ENETFEC_RACC_OPTIONS            (ENETFEC_RACC_IPDIS | \
+					ENETFEC_RACC_PRODIS)
+
+#define ENETFEC_PAUSE_FLAG_AUTONEG      0x1
+#define ENETFEC_PAUSE_FLAG_ENABLE       0x2
+
+/* Pause frame field and FIFO threshold */
+#define ENETFEC_FCE                     RTE_BIT32(5)
+#define ENETFEC_RSEM_V                  0x84
+#define ENETFEC_RSFL_V                  16
+#define ENETFEC_RAEM_V                  0x8
+#define ENETFEC_RAFL_V                  0x8
+#define ENETFEC_OPD_V                   0xFFF0
+
+/* Extended buffer descriptor */
+#define ENETFEC_EXTENDED_BD             0
+#define NUM_OF_BD_QUEUES                6
+
 #define __iomem
 #if defined(RTE_ARCH_ARM)
 #if defined(RTE_ARCH_64)
-- 
2.25.1

