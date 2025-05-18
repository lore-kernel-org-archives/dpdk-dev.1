Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6777DC3ABC9
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 May 2025 08:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F706400D6;
	Sun, 18 May 2025 10:17:19 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
 by mails.dpdk.org (Postfix) with ESMTP id E795B400D6
 for <dev@dpdk.org>; Sun, 18 May 2025 10:17:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuHRVlwwwsB4Zk/Di4bO5XIuRh89Dfb76hKmEQmN03y+YDxAbjeQZJs1GynIjHafgjF+pYNosOzvUyrHU37UG1nPcSwknyPMxqs3dWyFBTsRkoIdQbs5DNTcmszMvRUVj5R73vhYRmECkX9wp8rptcSeCpqqOh9eHB4Mv1ypa91gGRT5TFEuONrD5yyRhV3vCM9hhClm6D+wcIfszuZGCDrjL2idMjiCQBBKcnHTVQebKi8RG1qkQKMdKEe+ZIsyhq7uXYE/AYD0/Kzbw2iNrRTllAHlS9Txl1mlioxBFOJXz1mwRCMD1zmM1XlyF4fVeAA/4S7szuSNE1/nNjC2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S+rj9NMFPj9BcptqpRUFFrb0XCfVLFkKH8lZykQivM=;
 b=R/Qmlg1Xdz9OZaIqUQzsxTPxc/RfyEip/Sw4H0hkol2GJ1bHYA2rkTSK13GIf2G+1dryZzO/Hy8iQ4KoskJHPDN4gA3WMueNijwhrwlXgNyEAVKHXJMHCsghxyKuZ6MOqpzWwjNxtzsb/IppZYCbTUhKx+XR/twwyGJAmQRH+Qn9MhxgbWAf4klvWUIHFBJJ17LS2rk3tqRUNKv3/OT9DwTEzOR0uSx0p23plwKy+5SjxFfohv3BKKspe+2EsDu/orW4A9kFUtQiJCa67EEqh+fcYXlm3wZ4geBYnWhGpPzUmKulqZi1V2+0E4t/BH1O1gP7g9tV4TyNCm+sWHyQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S+rj9NMFPj9BcptqpRUFFrb0XCfVLFkKH8lZykQivM=;
 b=BBDC4OJk6yz7emnaTSuofrU37wFzjkbd8+RdiiP3CRqifzhPjs2ADbkTvYckGy/fTw0ov1iXGDctZ39YGNINpVMepy0ORk5UaZeQ/5w7vdfHLWxPc+VkryC8HwWF9GIFp2ektQQeObIFK6epZaIy8mlhXbERy4y2yHj7SN4IvII31GHsBCXD7xGOAcTUb/Phz/bjcrQMYBqELzJHlQR03a8f1kfqzjbVuT/Xt5m630t0GvyV5mV2K+ETdl+RjbgUrlCRYNT81pGqp4f1TRnPIHahmFxJrv4fGZDWEZlSY3K4BKy6yhsKSsFtHmx9IFi5C0G+c3UNP9YJTlT6kHBt1A==
Received: from DU2P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::35)
 by AS4PR07MB8825.eurprd07.prod.outlook.com (2603:10a6:20b:4f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Sun, 18 May
 2025 08:17:12 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::21) by DU2P251CA0023.outlook.office365.com
 (2603:10a6:10:230::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Sun,
 18 May 2025 08:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 08:17:10 +0000
Received: from seliicinfr00050.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 18 May 2025 10:17:09 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00050.seli.gic.ericsson.se (Postfix) with ESMTP id
 D21091C006B; Sun, 18 May 2025 10:17:09 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "David
 Marchand" <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>, 
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 1/3] bitops: promote bit manipulation API to stable
Date: Sun, 18 May 2025 10:05:54 +0200
Message-ID: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|AS4PR07MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: 84aa749e-9264-496e-b3d2-08dd95e4632f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVJaQTl6UnF2QTRtUzZ3a1VaejRKNVM3SFN3UFFxSjhjSE1jbEVEM1paRkc3?=
 =?utf-8?B?MWEzYlRDRFI3bjZlVXVjK2lSazVZTnNrVW5Td3ZVbHlzS0R1N0gyWDJ1Qzlq?=
 =?utf-8?B?SXR6bTZRTVBPQW5sL1hOM0licmVGVi8xK0k4UDRHS2IwZEZTb2pvNnNKaVlI?=
 =?utf-8?B?bXMxbytzTDdRdUEydklTR21kODRJV2hPZjdQeWdsS3FUbSsxNTJmL3V6SEdB?=
 =?utf-8?B?YnRYRDkzSzkzT3F1MjcvVDFnZE5RTE9ldy9mRVJzaDJBMWovMXdZNnRRaUxR?=
 =?utf-8?B?M2RoSzZEbjArZHVMdGN5SVJmQWdsdlRZa2llNU10WlJkM1BHQ1ZzMzBscXcw?=
 =?utf-8?B?SFRwekE1V2YwT1dYbDM5VFRSZWYyaGdXcW8xMlk0VDFvNjFrV05CN3RnbmVX?=
 =?utf-8?B?WkNRTzFDOEEwN1ZYRDc2dE5xZGp3dW82QXpqR2x6OGdjSlRERzBuVzJFZm15?=
 =?utf-8?B?NG10QVZDMVJpTHZYSkdHMWxnVFNmVmhRR1ZiR3BlelN5SHgzdWRkaEZRTlFm?=
 =?utf-8?B?VU56VW84SGxweXVhTWRORGxmbEFMYTBDdFRnUlJPWUVFcXRaNUIzVUV4ekN2?=
 =?utf-8?B?aG9JY0tBWTdpeWJSMkNTTlY5MEE0V2h0WjZsZlNYc3BwRk4rYjNaL3pJaUVN?=
 =?utf-8?B?N2tFcFFTVFp2eGtLMGlDdXRDR01GbXRRTDBKMHQ0RDRlanlsY0RaOUVoYkdk?=
 =?utf-8?B?TTd6UENPTXBHQWhGZ1lQc0N1YmxFbytLU2dZOHZGNS9wU0NDZUtQOSt2ai9Q?=
 =?utf-8?B?YVJ4d2tmWUtNLy9MUlhzTVFJNFJGbFBrZmY3cjZ2UjF5Q1Zwc0lRa2tKNTh6?=
 =?utf-8?B?WDBkNFFOa010S2VmaXJMRHU4eEM4T29GdkdTN3gwM0J6WjBzMy9KQjVGUGd5?=
 =?utf-8?B?cDhERkNzOUI5WXRPa3RyaG9lWlVPb3FZK0hPT1FQeEtGM3dlK3p4dUdhbDRQ?=
 =?utf-8?B?M1pIY0dhZytFOEF2ME5wYlFXREtoVjJVYkk0c0o0Q3NicDV0M2dtOWFaNCtS?=
 =?utf-8?B?U0tYcnIzOVpDVVpxZHoyZER5a1hRYlA3emlsQ2ZXQUQ5MlRNV3c2STdEY0F6?=
 =?utf-8?B?cE9pY2F0elhPSk9LdHdoc3dreWI4MXlFQytQSEdxVlllNm9KR3ZXdG1BczRR?=
 =?utf-8?B?dy85cGwyTXBHbzJSdWFCVnRkWjEwOGxxQUJWSzZIOFZNNWRodVdQRTFILzFN?=
 =?utf-8?B?L1pGS3g3UXFaODJreWhxVU83QmZJNnN4YTFLSkQ4cTNtVHlQeTZSSGs1S1dz?=
 =?utf-8?B?OC9XTXJiRFF3WTNiT29HYkwvTlZrUFh6RVBiRDRsNWFpYm9CV29VUmZqOXNq?=
 =?utf-8?B?RE45a2tQMUNHcmJIWWNRUVRiYUo5dXZxU3RESzdVdFV5NjdxNXlxdm9uZ1Ri?=
 =?utf-8?B?THE5RnhRaFI3TWh5bmNQaHdIRW8xc3NGZ0F3WHBWWlRCSit6dGJ4YkNnUm1O?=
 =?utf-8?B?ZmJlNUU5MnhlV0FybnZIRVNGMkU3TEkvOHBTOUJBb2JSemdLblN1YUtXTHc1?=
 =?utf-8?B?cVR5LzBqbDB2TzRsVDJTSDBnUDltVnptaytMRmloOFZWcVd6Y1RNcUhINHNh?=
 =?utf-8?B?LzF2bUQwcmdqZTI1OUhSMXlzZUxDQlhCcVkyM1dMTVA0KzFqN1NNdDRZSEZ2?=
 =?utf-8?B?RWkyY0FSaDMremNJN2RmSkZzVEVlZE8zQkxpZFUrUllFS0Jxb2Z3aTRQUDVT?=
 =?utf-8?B?M1pwWHRxS0Z2WFZobUlsOGtNWDJDWFlUaVhOVHc0YVRoSlpwSTV3Sno4QVcw?=
 =?utf-8?B?RndQMTlDdlZTZHprTHNkMnBwcFJyUU5saDlBMDFpNlN0ZkhlRStaU0U2QnV1?=
 =?utf-8?B?TnRtRUVSUHpoQWxYYkJIZC9qYlVtQm9JT0R0MXF1ZUY4MnV0cTZMM0RqSk9D?=
 =?utf-8?B?OThVMmNIdW9BelVJY2lMc2VFQlBrU1BhY3JhbmZPd2ROWnYvM2d6OWxIK24z?=
 =?utf-8?B?WVBiRC9UMjVyeXhMcmU1T254WTlkN2dPMGdadnJ1Q3c5bDZhM1QzN3RXRlNx?=
 =?utf-8?B?bkxCek5UaVpDSEx3VWVvMTkzTW5sSkJzaldJWlgwUkdNVDZSNThUZnhOV0lO?=
 =?utf-8?Q?SU4DCI?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 08:17:10.4717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84aa749e-9264-496e-b3d2-08dd95e4632f
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8825
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

Remove experimental tag from generic selection-based APIs to test and
modify individual bits in 32- or 64-bit words.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eal/include/rte_bitops.h | 58 ------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
index b9a6af381b..77d6ce9d63 100644
--- a/lib/eal/include/rte_bitops.h
+++ b/lib/eal/include/rte_bitops.h
@@ -110,9 +110,6 @@ extern "C" {
 		((typeof(mask))(((reg) & (mask)) >> rte_ctz64(mask)))
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Test bit in word.
  *
  * Generic selection macro to test the value of a bit in a 32-bit or
@@ -140,9 +137,6 @@ extern "C" {
 			(addr, nr)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Set bit in word.
  *
  * Generic selection macro to set a bit in a 32-bit or 64-bit
@@ -166,9 +160,6 @@ extern "C" {
 			(addr, nr)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Clear bit in word.
  *
  * Generic selection macro to clear a bit in a 32-bit or 64-bit
@@ -192,9 +183,6 @@ extern "C" {
 			(addr, nr)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Assign a value to a bit in word.
  *
  * Generic selection macro to assign a value to a bit in a 32-bit or 64-bit
@@ -219,9 +207,6 @@ extern "C" {
 			(addr, nr, value)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Flip a bit in word.
  *
  * Generic selection macro to change the value of a bit to '0' if '1'
@@ -245,9 +230,6 @@ extern "C" {
 			(addr, nr)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Test if a particular bit in a word is set with a particular memory
  * order.
  *
@@ -276,9 +258,6 @@ extern "C" {
 			(addr, nr, memory_order)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically set bit in word.
  *
  * Generic selection macro to atomically set bit specified by @c nr in
@@ -301,9 +280,6 @@ extern "C" {
 			(addr, nr, memory_order)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically clear bit in word.
  *
  * Generic selection macro to atomically set bit specified by @c nr in
@@ -326,9 +302,6 @@ extern "C" {
 			(addr, nr, memory_order)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically assign a value to bit in word.
  *
  * Generic selection macro to atomically set bit specified by @c nr in the
@@ -353,9 +326,6 @@ extern "C" {
 			(addr, nr, value, memory_order)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically flip bit in word.
  *
  * Generic selection macro to atomically negate the value of the bit
@@ -379,9 +349,6 @@ extern "C" {
 			(addr, nr, memory_order)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically test and set a bit in word.
  *
  * Generic selection macro to atomically test and set bit specified by
@@ -406,9 +373,6 @@ extern "C" {
 			(addr, nr, memory_order)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically test and clear a bit in word.
  *
  * Generic selection macro to atomically test and clear bit specified
@@ -433,9 +397,6 @@ extern "C" {
 			(addr, nr, memory_order)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically test and assign a bit in word.
  *
  * Generic selection macro to atomically test and assign bit specified
@@ -463,7 +424,6 @@ extern "C" {
 			(addr, nr, value, memory_order)
 
 #define __RTE_GEN_BIT_TEST(variant, qualifier, size) \
-__rte_experimental \
 static inline bool \
 __rte_bit_ ## variant ## test ## size(const qualifier uint ## size ## _t *addr, unsigned int nr) \
 { \
@@ -473,7 +433,6 @@ __rte_bit_ ## variant ## test ## size(const qualifier uint ## size ## _t *addr,
 }
 
 #define __RTE_GEN_BIT_SET(variant, qualifier, size) \
-__rte_experimental \
 static inline void \
 __rte_bit_ ## variant ## set ## size(qualifier uint ## size ## _t *addr, unsigned int nr) \
 { \
@@ -483,7 +442,6 @@ __rte_bit_ ## variant ## set ## size(qualifier uint ## size ## _t *addr, unsigne
 }
 
 #define __RTE_GEN_BIT_CLEAR(variant, qualifier, size) \
-__rte_experimental \
 static inline void \
 __rte_bit_ ## variant ## clear ## size(qualifier uint ## size ## _t *addr, unsigned int nr) \
 { \
@@ -493,7 +451,6 @@ __rte_bit_ ## variant ## clear ## size(qualifier uint ## size ## _t *addr, unsig
 }
 
 #define __RTE_GEN_BIT_ASSIGN(variant, qualifier, size) \
-__rte_experimental \
 static inline void \
 __rte_bit_ ## variant ## assign ## size(qualifier uint ## size ## _t *addr, unsigned int nr, \
 		bool value) \
@@ -505,7 +462,6 @@ __rte_bit_ ## variant ## assign ## size(qualifier uint ## size ## _t *addr, unsi
 }
 
 #define __RTE_GEN_BIT_FLIP(variant, qualifier, size) \
-__rte_experimental \
 static inline void \
 __rte_bit_ ## variant ## flip ## size(qualifier uint ## size ## _t *addr, unsigned int nr) \
 { \
@@ -525,13 +481,10 @@ __rte_bit_ ## variant ## flip ## size(qualifier uint ## size ## _t *addr, unsign
 	__RTE_GEN_BIT_OPS(,, size) \
 	__RTE_GEN_BIT_OPS(v_, volatile, size)
 
-#ifdef ALLOW_EXPERIMENTAL_API
 __RTE_GEN_BIT_OPS_SIZE(32)
 __RTE_GEN_BIT_OPS_SIZE(64)
-#endif
 
 #define __RTE_GEN_BIT_ATOMIC_TEST(variant, qualifier, size) \
-__rte_experimental \
 static inline bool \
 __rte_bit_atomic_ ## variant ## test ## size(const qualifier uint ## size ## _t *addr, \
 		unsigned int nr, int memory_order) \
@@ -544,7 +497,6 @@ __rte_bit_atomic_ ## variant ## test ## size(const qualifier uint ## size ## _t
 }
 
 #define __RTE_GEN_BIT_ATOMIC_SET(variant, qualifier, size) \
-__rte_experimental \
 static inline void \
 __rte_bit_atomic_ ## variant ## set ## size(qualifier uint ## size ## _t *addr, \
 		unsigned int nr, int memory_order) \
@@ -557,7 +509,6 @@ __rte_bit_atomic_ ## variant ## set ## size(qualifier uint ## size ## _t *addr,
 }
 
 #define __RTE_GEN_BIT_ATOMIC_CLEAR(variant, qualifier, size) \
-__rte_experimental \
 static inline void \
 __rte_bit_atomic_ ## variant ## clear ## size(qualifier uint ## size ## _t *addr, \
 		unsigned int nr, int memory_order) \
@@ -570,7 +521,6 @@ __rte_bit_atomic_ ## variant ## clear ## size(qualifier uint ## size ## _t *addr
 }
 
 #define __RTE_GEN_BIT_ATOMIC_FLIP(variant, qualifier, size) \
-__rte_experimental \
 static inline void \
 __rte_bit_atomic_ ## variant ## flip ## size(qualifier uint ## size ## _t *addr, \
 		unsigned int nr, int memory_order) \
@@ -583,7 +533,6 @@ __rte_bit_atomic_ ## variant ## flip ## size(qualifier uint ## size ## _t *addr,
 }
 
 #define __RTE_GEN_BIT_ATOMIC_ASSIGN(variant, qualifier, size) \
-__rte_experimental \
 static inline void \
 __rte_bit_atomic_## variant ## assign ## size(qualifier uint ## size ## _t *addr, \
 		unsigned int nr, bool value, int memory_order) \
@@ -595,7 +544,6 @@ __rte_bit_atomic_## variant ## assign ## size(qualifier uint ## size ## _t *addr
 }
 
 #define __RTE_GEN_BIT_ATOMIC_TEST_AND_SET(variant, qualifier, size) \
-__rte_experimental \
 static inline bool \
 __rte_bit_atomic_ ## variant ## test_and_set ## size(qualifier uint ## size ## _t *addr, \
 		unsigned int nr, int memory_order) \
@@ -610,7 +558,6 @@ __rte_bit_atomic_ ## variant ## test_and_set ## size(qualifier uint ## size ## _
 }
 
 #define __RTE_GEN_BIT_ATOMIC_TEST_AND_CLEAR(variant, qualifier, size) \
-__rte_experimental \
 static inline bool \
 __rte_bit_atomic_ ## variant ## test_and_clear ## size(qualifier uint ## size ## _t *addr, \
 		unsigned int nr, int memory_order) \
@@ -625,7 +572,6 @@ __rte_bit_atomic_ ## variant ## test_and_clear ## size(qualifier uint ## size ##
 }
 
 #define __RTE_GEN_BIT_ATOMIC_TEST_AND_ASSIGN(variant, qualifier, size) \
-__rte_experimental \
 static inline bool \
 __rte_bit_atomic_ ## variant ## test_and_assign ## size( \
 		qualifier uint ## size ## _t *addr, unsigned int nr, bool value, \
@@ -653,10 +599,8 @@ __rte_bit_atomic_ ## variant ## test_and_assign ## size( \
 	__RTE_GEN_BIT_ATOMIC_OPS(,, size) \
 	__RTE_GEN_BIT_ATOMIC_OPS(v_, volatile, size)
 
-#ifdef ALLOW_EXPERIMENTAL_API
 __RTE_GEN_BIT_ATOMIC_OPS_SIZE(32)
 __RTE_GEN_BIT_ATOMIC_OPS_SIZE(64)
-#endif
 
 /*------------------------ 32-bit relaxed operations ------------------------*/
 
@@ -1571,7 +1515,6 @@ rte_bit_ ## family ## fun(qualifier uint ## size ## _t *addr, arg1_type arg1_nam
 	__RTE_BIT_OVERLOAD_SZ_4R(family, fun, qualifier, 64, ret_type, arg1_type, arg1_name, \
 		arg2_type, arg2_name, arg3_type, arg3_name)
 
-#ifdef ALLOW_EXPERIMENTAL_API
 __RTE_BIT_OVERLOAD_2R(, test, const, bool, unsigned int, nr)
 __RTE_BIT_OVERLOAD_2(, set,, unsigned int, nr)
 __RTE_BIT_OVERLOAD_2(, clear,, unsigned int, nr)
@@ -1587,7 +1530,6 @@ __RTE_BIT_OVERLOAD_3R(atomic_, test_and_set,, bool, unsigned int, nr, int, memor
 __RTE_BIT_OVERLOAD_3R(atomic_, test_and_clear,, bool, unsigned int, nr, int, memory_order)
 __RTE_BIT_OVERLOAD_4R(atomic_, test_and_assign,, bool, unsigned int, nr, bool, value,
 	int, memory_order)
-#endif
 
 #endif
 
-- 
2.43.0

