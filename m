Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71F6C54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:15:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B16C4066F;
	Fri, 30 May 2025 09:14:23 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
 by mails.dpdk.org (Postfix) with ESMTP id 040B84065E
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+YT9Ir+SRCJD4PZsb+3VuXRlkSubfAzK6GmXlbf48hQG5IIEBAZMQ8MKJ3jvQlXfVh1z/l/yg2Palbc1VCGgNel054y+FkizzPgULpQ5fnVD+nlunxdvuvnNpSFrgNNkqlq9iVAxAuO616aO6hUj2oSSOZLBf7aRJqNFp96HmEiRi23ZGHajK8CGVwWVl97Iek087NA8teGvd+erJdVHzKcFxe3xcuyYF2J4xerTW3ehEPEyJw8Kitjn/dLPQAkp3X+XOGOOZbaQ1RXtNLDLLXyZ5FZwUEd/zXFBd/yrxqFkDOtvukOVYWs3RS/rzozaym5/9o+bqNiOWyBT+QdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fA12+liluCLOCwyzx3qYsh8SsnR+bKM3kVNEU1+R8g=;
 b=QvHIPlB8ZDXE2G/j4d1iMycuPQqFrmc55m7DsHyqElbXYXn0WAkEsUnMpjHWH0UYVev3/u1IOtBbzo+bYtKbhJOzvMLgM+vBq9H+O2Lo5agLY+EOd2VCIIcTPx6MpgXwRlFGzWYDpcAqNKrCn/EG6ro2PMXsp6gQb+AJWvb5F+Jen0rGdfovzIJUSeuVZp+0j22qipRPgGfJX0S13jEOSfFIvXmuffgnj/ur7G5ufdOBgkM4BXwAs0rORhTgi9FlDIa4OoGJG4wuXqiM1rV9b/c14VQLa9zBLJ7qPwkqJQCE3yjfhSyU/kgrJ+jSpciawqq2fS7HeB70aEtx8epInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fA12+liluCLOCwyzx3qYsh8SsnR+bKM3kVNEU1+R8g=;
 b=g7fkgbBge6NmUPAU+bdjt4UaQF7YtBhE4o7KEOCioNaC8/I2SpPxnD4hPtlwVz/fbstSFYYVF3vet3Eqr16sfwsqub/q8K3gNLj+YP01JirshlVoCTi35uq2vNdy+OtpnF3kgSDViAY+0GotjeAP8o3quIuV9aGDzjTeOOYxKy9lF0pNWBQi8UmY4VMV8jsjhK60wElw3mpSCVk/REtwUuBUBYMM6cg8jPoXelLtRdngT4c0pzfZScLp6jzAmd1RlkTrIJhAaRuffpM9w6/sU5N9Vd7M73A3XWM4rqTqR2E/vUXk+tub38Ynl5G5SyJSgmTwYV/QlS8+Z4AYGJ10eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 07:14:21 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:21 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 07/11] net/dpaa2: support dpmac Tx stats
Date: Fri, 30 May 2025 12:43:40 +0530
Message-Id: <20250530071344.2939434-8-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b943215-46ab-42dc-f60d-08dd9f49991a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7hZdYSXtJk2kRjvdLzMaXqSQkF+rznqmVVVHx5rFkWUqcJF8GzWDFlRQBUFH?=
 =?us-ascii?Q?f1FxKJWoPO0a8uzk/apXGd9I9HqwAW6O8xRyml7T/Qz2SnAbMs9yxkZdOCuL?=
 =?us-ascii?Q?9ZGkSMSgtgLX5XVUeBCwyIcAVebKniFtaFXBwYL+SVUpD31LsaduiHKToWOV?=
 =?us-ascii?Q?RChntr51nTZchmNkQCZ5x9SbYlUeCr60ZXTBBAkGI281tPBw30Sbtssi+VH2?=
 =?us-ascii?Q?TzWq9tjw+DzKvqjsdSRUoEtoaBQQTr7hhZctAANBYfWW2tST/YUO3H7Qsjcg?=
 =?us-ascii?Q?OJx7sqpu0wqvSQQPvIQ7NadkFY6WlqQ3sKOHRmPTmXlrPQtbRWmQlFzpGZ22?=
 =?us-ascii?Q?+d5XPLBj7mqE/S9lMNEtbX0Xtg8msOzYkMyMvVeQImZMIQloMT2T4bdVOSqK?=
 =?us-ascii?Q?ltJnQA+rSKMlinw3dQuKIYQsQol87nvQLu1aA6bpOFkkcoQTAYgp87A38P8u?=
 =?us-ascii?Q?6hrafIpCovR4ffwLJdSAVltR4erOlC7z23LuLEiZDwZd1lEZiqs12tZAPqyW?=
 =?us-ascii?Q?ckyHaEchHwKUNaRcR6lFwkky4UvclvEICKTn1NtMLaAHq8moPZReb7ZgWJd+?=
 =?us-ascii?Q?5FpSzRWeAthRmKM1SPcNIH/6hwtAa60IQ4aSHZUBeqB38eUCUexqnGbtSxvH?=
 =?us-ascii?Q?Dn0vhWSC64a//z2I3Vr8toko3q3xNZF06rxmypC9IFvGO+leVLjqXupli5ti?=
 =?us-ascii?Q?FrIwJB9TuZAAHIl83PmxY16G9p3z3Jvrq3s3pI2SriTBMmC6fji4Djx4/g3C?=
 =?us-ascii?Q?Qa0hfBNPpDHWgkNWD9fai/QY/CS/ntI4FNlBtEYtKjDCOnEIoH2g7uRoTCEa?=
 =?us-ascii?Q?lEWC96rYBfu8g1Zpryr7mPjGEViaho8BaJSLKdMZh0dBFEnD5a4ybeWGjf2k?=
 =?us-ascii?Q?byerTJXE0W6xNJh8FNHAjV+aRpx2W5xSdJZUMsZBesModfIsSSOdEz0jBnx9?=
 =?us-ascii?Q?0vsFZsQmjXm9LEZJle930VPwnF7mQnMSLRfWrMUhrXPHhR113sJsdzFBmgiu?=
 =?us-ascii?Q?+VaJ55ccyNgGG270ieoS634UVhADHaYqAXI+C0uz4Lnr42b9T0ZiclQeFGqp?=
 =?us-ascii?Q?f5bCfjW3DZKA1UB9hNI4gA2KQazS5wk8aFCqw2TMqVeaXFuwa1RiMSPlS9i3?=
 =?us-ascii?Q?nMQmY+aU2LupiRjgTzBQntXR80v75hhWccl+C9hXohh37ZeSwT+7Ei85B7Wf?=
 =?us-ascii?Q?Dd2E6KKy9SRE3yR5SY60qk6wxKTXq/PGDoFxfJfZyidp+xYRvCbkb7uTfu7S?=
 =?us-ascii?Q?qc9DHRN7lZKASxfBf1SYYPHfQzuzfIoKUZgUN5IGl5FSnZOIGoFoIMRBBqWw?=
 =?us-ascii?Q?frNYDxBV+JxeQtq9P5P08fzHTudllwo1x+cyZPRdImPJbLFpSMdv/YwCAdba?=
 =?us-ascii?Q?R00vPaRgs7y/jmlvnXi1nJNoCa9gS7fTIko7rwg0IUHsME/HHz1KrucN1sUn?=
 =?us-ascii?Q?P2fMnJQPxTr7KsTXHbbUhS1nBVI5/jv3mb/fi8ORsZ0UZ5iT3NIudQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rV9eK9j/n369kpGTppZ9JxbBLjZ1ZhSDlwhC8NHiE5yrYl1BUx37JBKLf+DD?=
 =?us-ascii?Q?gw3vaxAfyXQ3DposyK47Im/IDxw/D2fmYBYny3TSsqhrT8eNzElOwLTDlG3B?=
 =?us-ascii?Q?Uf9Qcira12WvMh5s1dA2gNpcXrbeUR8u7NzaNc6JXAhwWqWNw1weHETMf3de?=
 =?us-ascii?Q?O3l4J8vds9AhXPgvq9rAnywAwWNHqwPw86a9s/bUzpme/lLyZPtFPfm4v0yd?=
 =?us-ascii?Q?MvgfIV6qSY4VOBZG99y5AMzXTpgzkARms3CphHnjJc86QoCVrC9e2XcDq4KD?=
 =?us-ascii?Q?UTV/MqM4P3DiI72hD7yCdN8wkm3girqurN5rsZZ/1PlnSj6oViS8EKa3rWPm?=
 =?us-ascii?Q?GcbUViHNVhhArKFHSxjWlBKVisHuiwH7RjPQmpgOHZl5uNIf47Ccn/sR7m9J?=
 =?us-ascii?Q?dXqYgfuM1+r6IKO9yLE+yNGZns5Vv0/H459txMGpLPzJkDtwM2VkFBgHz/mm?=
 =?us-ascii?Q?kGIPVRiwqPCc0vPrqebS5zLMU4hcu5Nvko+pqa7SRKfWcIbrCPzP8XWO+wiq?=
 =?us-ascii?Q?Xwge2jPT86bqgWgpSNy6ULnss40sGgl+VoTJAJ/2nVH5KrguWbRSJdwpT1sB?=
 =?us-ascii?Q?T+wQhFjfJ4f5XRvGNlNNVVmL4yPDsiOM0YX8QEY66KaEK7e2iOoXykE+cE8n?=
 =?us-ascii?Q?9Uva8GIpHQhL/d4gC+P5Zy+r2DkRPhBL7NQ+tDaXJ7+ljHV8OEw5U4+2sU6d?=
 =?us-ascii?Q?jQzDi857povU5KUjNHuHuzUz+bGUn9Dg2x/c4yGmFF7VZKfqEz4+VT+XCqYu?=
 =?us-ascii?Q?zW8NrlzzQHP9aj4SKHcs4vDP0MNbNUGEyWvN7i7xAjAPjki3n5MtodjnAHV/?=
 =?us-ascii?Q?FifzGL4y3GgEAuj6bCo/EfMFfc/dpRt3CB6j87aTcRtlV8FcpCHEp6Clo0oW?=
 =?us-ascii?Q?kAA7YaioNSQcdJyUom9yhHEKBOxPdQDgv/I6IuG/nRKeIGtMxphNldIgbwhJ?=
 =?us-ascii?Q?Lg1j18FSL9sLmPcd0brtopmuvtqjxAO7EWsRR1upENMI0WB4T3gzF+EkyDUt?=
 =?us-ascii?Q?H/lqBXIfBaTHiJKHf0OFghkJZOgUxPlOWQbpTqLn7lmzrXO+8mwjqpnKoWO+?=
 =?us-ascii?Q?K8ohu6jAKW/jhFw+0WKGMy+259WsMd9lJw++haAbjFhLZiPjd5HWHdDQy+/m?=
 =?us-ascii?Q?l813MmZRBW6h9QEmPN8B8+36aBkeRypTVs2RS+XaWiu1oYkFzoS36Kq55WVX?=
 =?us-ascii?Q?VHgVeJGbfZ/YbXfSxgMjv+Q+Y00gv7lkzN+DDxVD8vANYQiScSgBTpwgMMjo?=
 =?us-ascii?Q?0x1c3C9L76Rfq7Mm51y4o1ngvJZ+b4wgx5p3k6jUkOILTqw5Ga1sWkpTpfs+?=
 =?us-ascii?Q?kdel5hVAuUBdmUo9+Q3S1r55P/9bq5WL3+6c7zmikQ4IsVmY7RbR3zc95XTS?=
 =?us-ascii?Q?ldsyn4YylZctDlSrAl0xcqjpaAH+bcsbE2dlAXcNpWJKGxQbBj6g3Flqcj37?=
 =?us-ascii?Q?lnGY7zzXRV1pSZ5luFT+yJVWBoHK3GaGJqvK3CA9KfR2YYO/o0lCZlDMWMKH?=
 =?us-ascii?Q?SSwgc7Yh67wCysoVSdw5YPR4nNqUjqfAFXrv5yd38Ys8Q4SOGkRpLjCR0i2f?=
 =?us-ascii?Q?af/lCgQxIYAso4tOGkQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b943215-46ab-42dc-f60d-08dd9f49991a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:21.0781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEeJFzgUZJbS0E5GRhBNTB9/rbGaLWH4/zXknAQUnWxTRFk1+3iCkiQbK5MUP49o
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
packet sizes.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa2/mc/fsl_dpmac.h | 50 ++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
index f1be36ee79..a71f1658da 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -1,5 +1,5 @@
 /* Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2018-2022, 2024 NXP
+ * Copyright 2018-2022, 2024-2025 NXP
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -434,6 +434,34 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
  *			      pause frames.
  * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
  *			      pause frames.
+ * @DPMAC_CNT_EGR_FRAME_64: counts transmitted 64-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_127: counts transmitted 65 to 127-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_255: counts transmitted 128 to 255-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_511: counts transmitted 256 to 511-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1023: counts transmitted 512 to 1023-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1518: counts transmitted 1024 to 1518-bytes frames, good or bad.
+ * @DPMAC_CNT_EGR_FRAME_1519_MAX: counts transmitted 1519-bytes frames and
+ * larger (up to max frame length specified), good or bad.
+ * @DPMAC_CNT_ING_ALL_BYTE: counts bytes received in both good and bad packets
+ * @DPMAC_CNT_ING_FCS_ERR: counts frames received with a CRC-32 error but the
+ * frame is otherwise of correct length
+ * @DPMAC_CNT_ING_VLAN_FRAME: counts the received VLAN tagged frames which are valid.
+ * @DPMAC_CNT_ING_UNDERSIZED: counts received frames which were less than 64
+ * bytes long and with a good CRC.
+ * @DPMAC_CNT_ING_CONTROL_FRAME: counts received control frames (type 0x8808)
+ * but not pause frames.
+ * @DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC: counts the fully dropped frames (not
+ * truncated) due to internal errors of the MAC client. Occurs when a received
+ * FIFO overflows.
+ * @DPMAC_CNT_EGR_ALL_BYTE: counts transmitted bytes in both good and bad
+ * packets.
+ * @DPMAC_CNT_EGR_FCS_ERR: counts trasmitted frames with a CRC-32 error except
+ * for underflows.
+ * @DPMAC_CNT_EGR_VLAN_FRAME: counts the transmitted VLAN tagged frames which
+ * are valid.
+ * @DPMAC_CNT_EGR_ALL_FRAME: counts all trasmitted frames, good or bad.
+ * @DPMAC_CNT_EGR_CONTROL_FRAME: counts transmitted control frames (type
+ * 0x8808) but not pause frames.
  */
 enum dpmac_counter {
 	DPMAC_CNT_ING_FRAME_64,
@@ -463,7 +491,25 @@ enum dpmac_counter {
 	DPMAC_CNT_EGR_UCAST_FRAME,
 	DPMAC_CNT_EGR_ERR_FRAME,
 	DPMAC_CNT_ING_GOOD_FRAME,
-	DPMAC_CNT_EGR_GOOD_FRAME
+	DPMAC_CNT_EGR_GOOD_FRAME,
+	DPMAC_CNT_EGR_FRAME_64,
+	DPMAC_CNT_EGR_FRAME_127,
+	DPMAC_CNT_EGR_FRAME_255,
+	DPMAC_CNT_EGR_FRAME_511,
+	DPMAC_CNT_EGR_FRAME_1023,
+	DPMAC_CNT_EGR_FRAME_1518,
+	DPMAC_CNT_EGR_FRAME_1519_MAX,
+	DPMAC_CNT_ING_ALL_BYTE,
+	DPMAC_CNT_ING_FCS_ERR,
+	DPMAC_CNT_ING_VLAN_FRAME,
+	DPMAC_CNT_ING_UNDERSIZED,
+	DPMAC_CNT_ING_CONTROL_FRAME,
+	DPMAC_CNT_ING_FRAME_DISCARD_NOT_TRUNC,
+	DPMAC_CNT_EGR_ALL_BYTE,
+	DPMAC_CNT_EGR_FCS_ERR,
+	DPMAC_CNT_EGR_VLAN_FRAME,
+	DPMAC_CNT_EGR_ALL_FRAME,
+	DPMAC_CNT_EGR_CONTROL_FRAME
 };
 
 int dpmac_get_counter(struct fsl_mc_io *mc_io,
-- 
2.25.1

