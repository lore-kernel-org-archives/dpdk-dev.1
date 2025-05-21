Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75469C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:58:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2375241104;
	Wed, 21 May 2025 08:57:36 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
 by mails.dpdk.org (Postfix) with ESMTP id E66AA40EE3
 for <dev@dpdk.org>; Wed, 21 May 2025 08:57:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+7BU1FgmKIPIybxyUZmKc9Jy3ixUR9ztWB8wyXMsOx8vWIHgbXdLrvYKUAQyvEVfsCrOIqIRgiUuNlFeUT6hIr4rozmWuGoJn6mGFdx/z5FYYHtMyNHr+5dBFfdtwX+yfhxMA4gzsK1iMcxbhkPeKH+DpZRwsWIpf+pNWUa5nXVGLT4aReCxglguvlrggRaWS49FfYWv3CoxIXF4C7ZS3ptWhT5MbTWRSULT1TMAzwe/ljEPU7nYyNTsgALCP4C3VVQmRaflc17w8dqAHr1vbi8e9a4+MM5OcW2HAFfhAhiuBHNivRW6I+WUexYybwacEAZQnn5lsLEseF3VoSoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtQROJQQJKfKc66WaDvwSBiiAtHLt1u5e7D0fi0Uikc=;
 b=SnpijVq1bUX47PS/EiV2IhhqY1h4gWOvGV2FbNet51hf76YzmeRJQ7CTHEBJ4uuQ3sWfuAVqiL3FoLkv8UUHcyNneEGmexAcvqj3tP2fya6XatHCOCTyaKRLLW5VJMgIMaWHch7sjdrTDxPEmkbd6jtKym/eG0K89mAZSVJj2McaiFzMmyKrjKo5x7ofbaJnT5i96EPaUF/yDkzBvw9YZv08iTuEnhiUyyGdxocxBPrDHulFNqhL6cnWl3e0VJi1D7s4haiMtkxBk1G9D2Wp6vFIeIP/Jl/1eP4EvAsLjJuzpqnkc0gUTaJjlhmFW3v9PkYuo3lfc+lp7kLQtHe/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtQROJQQJKfKc66WaDvwSBiiAtHLt1u5e7D0fi0Uikc=;
 b=NhhOM9Gj0e/YpMQcXBHhwhTMhuJlTpaVrg1E3wYPxIsIcvKYu3na8i4foeW/IAPMT9/5P4hwZwoLWvC1jTnysCKlSKW+WbbRqyXbCuc1RayQNqq5HDqEUHvX3M+YD4w1PXJw/GQ2Y36zylUT02tjpT6UgPayhL49kscDrGUv6KlrDxYwvxHV746m7j0iOXMyXe6xApuTbs+bsvdAAtXRmA5XHBWprJtYt2512oBTTp8wFOtf4YmWX0GOc5GmFrdukhmJePvfAiSt6a5ITCR8Vd5d3yq1DPtUGyQnhqJ5BJx8Zuc0v2mH9bLf/gw1rNncgT3LC7JmBUqCth9tIiK28w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:57:32 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:31 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 7/9] net/dpaa2: configure buffer layout
Date: Wed, 21 May 2025 12:26:56 +0530
Message-Id: <20250521065658.857707-8-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f54e99-893c-4d02-27f2-08dd9834c1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JSjw+I8rMIAx8jUYJCPbLYstdmBplea4iOFtz3zBd5RLeulObRBfzj19Tehs?=
 =?us-ascii?Q?pvexwagUM5A7CacnHYn/NyRSXDCS+uA0g/e1NOy6DZLTQXqHOgcDEAK5KIok?=
 =?us-ascii?Q?zNQzyZxwz4WUIE0eygTAh1NFNfxvvRyXlicwDBkJ/cdWQQtBTRpkfeiv9tP5?=
 =?us-ascii?Q?KsspUc39lUXEcD6TjnjcYEu08eDZMY1uaYFxYUYJxImnCxPb8323vKxo08VY?=
 =?us-ascii?Q?ytqZrraosKOvmqx4wmrbXRRRHFrMAXScxtCVIGbD8B2QqGt26Cn1X3hnc76M?=
 =?us-ascii?Q?XJbMho6ubD4tMhMyR0Hb+QFtZ0Ss/3q2zZu4LpYd9NImhYglnhO35otLRELA?=
 =?us-ascii?Q?vJ4luPErQZdC/kzXRBidUGsjFl3BLkcU5LxwNjxnbCpYnd/M5ZhCJamQ2w9J?=
 =?us-ascii?Q?moYxgdboCBsBM59EA2AJG2kBdXzvAgtA6mwtIIOL0v4LestlGTa5lAKLZIwn?=
 =?us-ascii?Q?qDV3AT55LG6eAuLpHNGYMvsPf2iHSVtArRk6os7fpA02G1X+q2TNKOm+06Zp?=
 =?us-ascii?Q?nQ16CYi+lcNcOfeSSyp2wJ5+E9G8P6r8u3D1ahCH14sZCuOMc9z5l67C/kSd?=
 =?us-ascii?Q?FDXdcgOeY9yGiYG8LrIfWx6hALnKuXVq3Lpz9j2jEJ3qbpPhPezyF0uDslt7?=
 =?us-ascii?Q?mLZn+tQAmcbq5mbmTo5G6fT4kUHKKvpNaVchgyWC88zPqwJ2h7UwLcCkBheH?=
 =?us-ascii?Q?l7/VAtzdd1kmZ3SWDlTTpU65vL71v23fhPP6nQHFxcMQJ40OHsomlXkAT8zB?=
 =?us-ascii?Q?4se4G5Q35pkitP+EBJ/p+H8EMU0uDVf2LyGLomSvZ5uE+aBn7+YyXPRlBRIu?=
 =?us-ascii?Q?LTjZjZRZFcgyWw7AAOvgJ2ychHHCWu0IqUhdknkm9HCk9QUH4nZKmi0MpDio?=
 =?us-ascii?Q?6bi8ub8SxerAefdio/mVn7kNcYiO2B1uFb7luAnCrXu5suii1Rxnhe1a9egw?=
 =?us-ascii?Q?DIBLOxmtUhaSm7pF4CBQHL5BszeZDJ3EQZnWadC1rbG/8VjjcIHzUz19Z8ez?=
 =?us-ascii?Q?whqBwVlEFEdH8IAALjYb9qVm5/I6xrxpJjjGh8VjvfT8uenqpp9tn8XAd624?=
 =?us-ascii?Q?iMYbn8Jfx2ojTbNBQZz0fZL0PRNk+4yl2/72pQPzYhM48U5o6TE2isZJ2JQW?=
 =?us-ascii?Q?EHp+rNw5MVtnG2xxGLmH2K68p7BmyQiBpWvwsKFgGcURYPodnTqVlXpquELT?=
 =?us-ascii?Q?bPwHkJ5o58VhUEt2bQ6InXm5FeUzj8PNMiVvruTLDlktD9ecIOSdyak0BOF7?=
 =?us-ascii?Q?hoB3GrZqKfz4+F0GZeFdLIpM1+BH20F40k0Jy/9u/dbd+woZr0aRqa1aIl0t?=
 =?us-ascii?Q?0BZlJcQUMOU9ItghRJypzmFQYURgSM7nvt4G2A7HHwFNkNXEw8YRmpVo8LTJ?=
 =?us-ascii?Q?cpJWS6tWzEF87hzrbr13Moa7GU6rkYtdliRzzmjTE067ISjfMd9znztHZXnd?=
 =?us-ascii?Q?FdVJfY5WXrz5YkRA8VpLhda17u78PnvPp5fDBzqlaZQfCP5E+dqZSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eciqWioJCSuCWMjwr+lM2punfQzcMuTJw9Kr5efSXsOggBy2mUBhNS8Qm+oX?=
 =?us-ascii?Q?plUnHGmpsELJtbbzkK6FEzSj+HDidkbX/EVI2jOq3MfZRxUoyE4n9TNjX2/T?=
 =?us-ascii?Q?pTpnqeoFfgihR7dmB5V/qxa8igo9JRF7NZDEZfT9u3BJW73sVf2LohtrDmFx?=
 =?us-ascii?Q?iCErXm6E8QolHPWqJ4SHb/8jFeY3BswMn4tJX0kvWZvTkKtko59nLRpHw61j?=
 =?us-ascii?Q?WK4CD7CNyRFt9IOODiCPHpB0AZimAzCuJtJzibChXbtsyoN1lRaVp9OzyyAu?=
 =?us-ascii?Q?P5krsz8Ip5weTfKsH4Eprp0o2obbS5JdknERMIc5NI++l2MXtivLd2nft7qK?=
 =?us-ascii?Q?pzSW2FYgg7yQxct+hg7AOilitWOlx63yBXD4HEss2ptCAdKjFBhiyMmw7XyP?=
 =?us-ascii?Q?QGKCmer61k7R92Jw1oC39F8Gas5NUSJNYR/OOcj+A3YbLZP5SNLDP5LQmE96?=
 =?us-ascii?Q?jcldrH8Lsko8oHv0oCNGKTnWvwRmksBsDs8F6qUWB7+RJ3NriKWcCPGvLxq9?=
 =?us-ascii?Q?hDAItLzsP/VC5hZewuK4zZyziCqIKOZikj6ZH0jxzDto3aB33wqPdlokMQMn?=
 =?us-ascii?Q?B+L4ah6/tnhqp9Gxqh0M87MSsvJ+jGED77A36VTfns+dhrRhVVFyQZVeW3ZX?=
 =?us-ascii?Q?1iG8nlHvnERyZNrZx5mTt7s+Po1U0gybZywAt3dadv04/zYeDd0Q/lLbBB24?=
 =?us-ascii?Q?hJayvWYfMQG3vzyJpYlTmEVPi03IJkTSbr5iuFsdE8AX2S5/jzt/coEMdG2E?=
 =?us-ascii?Q?1RYRCQHm2BVXt70RDv+P0u75PLm+MxP458iCF9q87EQmDXecP7+iNq6ygZX5?=
 =?us-ascii?Q?yMoYjwhKwMi4jNbe/EOXcKd5YgIZ+FSHK8ixz8Z5lyibBUCUfWFbBhJFrEfp?=
 =?us-ascii?Q?SuLbi2B8mi0KJoZ93qFVmVfxguERLwvsJEuv6DFmKHByMXzXymIYH7d3pz8h?=
 =?us-ascii?Q?/afV2uvWtcyugYLCS2OSwBMpew5OrMJWJlaFypR3z38nw8cfFtQd6U9byeL8?=
 =?us-ascii?Q?XLkYf94T6UgB1OawjeIQkEk6Usn1b0N8XQWs0LRZq5gL/92TsntzRY04TX0j?=
 =?us-ascii?Q?iZ/eOjepeMi7oBmmkuN5TORDBRDL8Cwh/iM4HzQOKW1lgmZpUqmwQssOcy51?=
 =?us-ascii?Q?KsK45whZnkxKt/wpkIZcNhcPSQV05rdh8hPf+0yeRNjlodmWZq90GEE5WYfc?=
 =?us-ascii?Q?773T33LhObqgLDKkApvzIUeVZoUyD+s5m4R+Co11Is/x1L0OPTeBxKiwTlrx?=
 =?us-ascii?Q?vovwWRfbxLkWPkIVkR9z788WORueEmre9+eQUV/apBLHOtAOMyEa9OnM7Bq4?=
 =?us-ascii?Q?tSivNA5JT4afalqUvktcTRottnCzM+TQYTqrIFuPtwAaKNfPv7qI/2ja7UB+?=
 =?us-ascii?Q?J2UrvLmkt6+T/ydSiJ6kAbU/QbPWY7/v316q3Nve/9wZ/opQ3mWY9AG8F43N?=
 =?us-ascii?Q?rT0fmyfdTMX489FHdh+QZ/emYx8YpdWgFQXr1tuxwhFyWaQmwXmleON9z9MT?=
 =?us-ascii?Q?D6N20bxPTMGoBZR5xDZTYLMvizW4oaCwEDuoQHlW6KBsbJiGvrhvK2st9ozT?=
 =?us-ascii?Q?elpIvr7wSTDSuE48O/YsCqjnZC7+AbrzdlvBOijt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f54e99-893c-4d02-27f2-08dd9834c1d8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:31.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4LzJCyHcd9ojsXkijlFAIQogV3a67YM35MfIEAo0+bDCgDpZMTkrxVcaKRpr/oE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
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

Make header room big enough for IPSec with TX dynamic confirm enabled.
Ingress minimum header room:
64(size of parser result) + 8(address of SEC context) * 2.
Egress minimum header room:
88(FAEAD offset) + 8(FAEAD size) + 8(address of SEC context) * 2 +
114(expansion).

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h      | 10 ++++++++++
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    |  4 +---
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c       | 18 ++++++++++++++++--
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h |  6 ++++++
 drivers/net/dpaa2/dpaa2_ethdev.h             |  6 +++++-
 5 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
index be0719aac6..10bc191645 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_pvt.h
@@ -84,6 +84,16 @@
 #define DPAA2_INVALID_FLOW_ID 0xffff
 #define DPAA2_INVALID_CGID 0xff
 
+#define SEC_FLC_DHR_OUTBOUND	(-114)
+#define SEC_FLC_DHR_INBOUND	0
+
+/** Consider aligning with 8 bytes to multiply point size with 2.*/
+#define DPAA2_SEC_SIMPLE_FD_OB_MIN \
+	((-SEC_FLC_DHR_OUTBOUND) + sizeof(void *) * 2)
+
+#define DPAA2_SEC_SIMPLE_FD_IB_MIN \
+	((-SEC_FLC_DHR_INBOUND) + sizeof(void *) * 2)
+
 struct dpaa2_queue;
 
 struct eqresp_metadata {
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index e9b601c035..755c8e9cc3 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016,2020-2023 NXP
+ *   Copyright 2016,2020-2024 NXP
  *
  */
 
@@ -20,8 +20,6 @@ extern uint8_t cryptodev_driver_id;
 #define FLE_POOL_BUF_SIZE	256
 #define FLE_POOL_CACHE_SIZE	512
 #define FLE_SG_MEM_SIZE(num)	(FLE_POOL_BUF_SIZE + ((num) * 32))
-#define SEC_FLC_DHR_OUTBOUND	-114
-#define SEC_FLC_DHR_INBOUND	0
 
 #define MAX_QUEUES		64
 #define MAX_DESC_SIZE		64
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 8d00a86032..b1d473429a 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2021 NXP
+ *   Copyright 2016-2021,2023-2024 NXP
  *
  */
 
@@ -492,7 +492,21 @@ dpaa2_attach_bp_list(struct dpaa2_dev_priv *priv,
 	 */
 
 	/* ... rx buffer layout ... */
-	tot_size = RTE_PKTMBUF_HEADROOM;
+	if (priv->flags & DPAA2_TX_DYNAMIC_CONF_ENABLE) {
+		int out_min_hdr_room, in_min_hdr_room;
+		/** Additional headroom layout for IPSec with TX configure
+		 * dynamic enabled.
+		 */
+		in_min_hdr_room = DPAA2_RX_MIN_FD_OFFSET +
+			DPAA2_SEC_SIMPLE_FD_IB_MIN;
+		out_min_hdr_room = DPAA2_DYN_TX_MIN_FD_OFFSET +
+			DPAA2_SEC_SIMPLE_FD_OB_MIN;
+		tot_size = RTE_MAX(in_min_hdr_room, out_min_hdr_room);
+		if (tot_size < RTE_PKTMBUF_HEADROOM)
+			tot_size = RTE_PKTMBUF_HEADROOM;
+	} else {
+		tot_size = RTE_PKTMBUF_HEADROOM;
+	}
 	tot_size = RTE_ALIGN_CEIL(tot_size, DPAA2_PACKET_LAYOUT_ALIGN);
 
 	memset(&layout, 0, sizeof(struct dpni_buffer_layout));
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
index fb026d6e49..d156b07087 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h
@@ -253,6 +253,9 @@ struct dpaa2_annot_hdr {
 #define PARSE_ERROR_CODE(var)		((uint64_t)(var) & 0xFF00000000000000)
 #define SOFT_PARSING_CONTEXT(var)	((uint64_t)(var) & 0x00FFFFFFFFFFFFFF)
 
+#define DPAA2_RX_MIN_FD_OFFSET \
+	(DPAA2_FD_PTA_SIZE + sizeof(struct dpaa2_annot_hdr))
+
 /*FAEAD offset in anmotation area*/
 #define DPAA2_FD_HW_ANNOT_FAEAD_OFFSET	0x58
 
@@ -261,6 +264,9 @@ struct dpaa2_faead {
 	uint32_t ctrl;
 };
 
+#define DPAA2_DYN_TX_MIN_FD_OFFSET \
+	(DPAA2_FD_HW_ANNOT_FAEAD_OFFSET + sizeof(struct dpaa2_faead))
+
 /*FAEAD bits */
 /*A2 OMB contains valid data*/
 #define DPAA2_ANNOT_FAEAD_A2V		0x20000000
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index fd3119247a..b9dd9b22fd 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -70,8 +70,12 @@
 /* Disable RX tail drop, default is enable */
 #define DPAA2_RX_TAILDROP_OFF	0x04
 /* Tx confirmation enabled */
-#define DPAA2_TX_CONF_ENABLE	0x06
+#define DPAA2_TX_CONF_ENABLE	0x08
 
+/* Tx dynamic confirmation enabled,
+ * only valid with Tx confirmation enabled.
+ */
+#define DPAA2_TX_DYNAMIC_CONF_ENABLE	0x10
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
 
-- 
2.25.1

