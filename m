Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF1AC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 May 2025 08:17:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10B7240A75;
	Sun, 18 May 2025 10:17:22 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012035.outbound.protection.outlook.com [52.101.71.35])
 by mails.dpdk.org (Postfix) with ESMTP id A1A9E40A6E
 for <dev@dpdk.org>; Sun, 18 May 2025 10:17:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veIrtZ1MH+3ich58bHEPb3t5MY+ZHBfwVQoaIdrDpmj2H7mUXQbkfaKFWGZZOLPGeHfOwDvaJVVQCxcpHWaIs7+4ui18MUZky7c0D0tUliD5cNZI7xc5+JkY+jUAJQrETvg0qG4TzTJ6o46CUJ8IrZqmHgBr1Fsy/FwsZfp2+dOhs0oay1x0FstHjbvQ43gmnsJFjNYxug8bStsIcxgCSjMOy0jxSgFb+xyPZKtwwMcmQwTIUyEbu61YntuZak4Ny8Voln5ORZCgPZQEqKlwXYdrG3fZBaolBKxGwQqNVMZQ90idneG4dl0FmGaWH3c18nXOTNv0djKFMzmy5NdZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CTZ6wq0irrWxgz+AEzHo6qtQ3UEuNvTOdkC9aktfpw=;
 b=Ll6EnBDi1jIOZmfb8hRdgUYxBCN241hF8I0bnzQq6agvU7nzrQXu3N4SJj7k7/BKZMoWDjkIxH+0QRcZXIWBHIU9gTE7EfYOpctLJYt5khGrR2L2mECHfGTrROWhxjg6yID7PP6S4kbIMUE+aKUk/fWbmTb/vFhDfRCM/40hFyycpgHR5czMNOJG9XZgluZ/+HAV2uCe1/oyhNUIATR1T3f7UojOk5knW/fGIVUBLOekll76Pc1RTMx8xXJemZmsMUpiALpAnFu7zC1PLzTp758igV2fcCS7c7klIjidubdwfydrStbOMPgmGrYAygtCK1Mtzrc7Vn1Vfrt3Wr/fgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CTZ6wq0irrWxgz+AEzHo6qtQ3UEuNvTOdkC9aktfpw=;
 b=d0ArOE7qYzJbnSyAfYc+RUIbxAg1lab51Izl6hQkwlfDFUIjuKDtmV6cOMdjiLRfX/Kk9qxuLJjtBL82+9Xnw9+ilKlcIOojsXUeC+Q6Pb38LddV7mIq7MbESqfOcZDKy6eDX1x/rmmeoA/EDH9NmdtwcYTiyveGwK0wiIoIWhOCqXt9UVx0uD2/C1bGz2kWZmJgDhEOyMBltg2nL1Szkk+UTqUina9HwiT6GOmHkruCiJDfjzQt3JKPmh8lTQ3WgX+EJHPYQ+VNU44uJd2qzcditLE9AFo5Vg8qpgj7ZJfk513DFrm9f7BPinCnigvA8eN6fetK5zt1f5muUnaYDQ==
Received: from DU2P251CA0006.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::7) by
 VI1PR07MB6446.eurprd07.prod.outlook.com (2603:10a6:800:13f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Sun, 18 May
 2025 08:17:14 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::ed) by DU2P251CA0006.outlook.office365.com
 (2603:10a6:10:230::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Sun,
 18 May 2025 08:17:14 +0000
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
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 08:17:14 +0000
Received: from seliicinfr00050.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 18 May 2025 10:17:10 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00050.seli.gic.ericsson.se (Postfix) with ESMTP id
 CC5021C006B; Sun, 18 May 2025 10:17:10 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "David
 Marchand" <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>, 
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 3/3] bitset: promote API stable
Date: Sun, 18 May 2025 10:05:56 +0200
Message-ID: <20250518080556.675092-3-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
References: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|VI1PR07MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a129c92-1d55-4eff-d6be-08dd95e46590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGViQUwxZGJNMXNJYVk3aFZMbGNkVk9TMXowZ01Va1hiOUl5TjFEdXpwMG5j?=
 =?utf-8?B?YjVKdnFHOWViUHhkZ1dQRmRTZ2h1QjRSVysxY3o5NmRXd2M4N0t2U1c5cE5S?=
 =?utf-8?B?TXlZVVl1NTJtMElEOXNYWWlGTFQvRHlOOWFGNHhoK2JEVlE4SDBTUkU1Z2hW?=
 =?utf-8?B?aEVQelN1U3hUS0huSUZtb0xPekVsMitCSmE1TUR0M1NjSkJ0bmx2N0E4eHEx?=
 =?utf-8?B?UHZ4VkI2RXNqdlJESzJxL1lxbW1oMHpoTFN2TTNiUklJZVF6a2lDeVExUHls?=
 =?utf-8?B?ekoyOTl5QnRPQUJBVVJpSlhjN3pGYm4vTFRKeXhWZGFmUjd1NXlBTGU5dEsy?=
 =?utf-8?B?S1ROeTN5RDRxaXFweWYzNUhjaWZrR0ppV053RktVdmlGMUc1UElpOEVKYXp6?=
 =?utf-8?B?dFdmMWFhQXMvbjRFelN3eW1zSUxCWkFRSFpUMDYzaEhjS3NWQkltS2JJTUdu?=
 =?utf-8?B?OWJZR3oxUlp2Z0FOZC90YS9QYjdCVzViTnZqTm9IenJ1c1IwUTdXR1ZINEZi?=
 =?utf-8?B?NkprU1ZpelZlQW0xa014K2NUelBMN1Q3TnBPUkJKdDJPaE9UT1cxWnVQNTNv?=
 =?utf-8?B?OEptaHFnYTdOcU01dFEvVmFrV2FyQmFYSWtELzdUeExFczFTV0RETmEvSDBh?=
 =?utf-8?B?UUNBNFV1U0V5M283MDNsOGVNTmFMd3JvSEY1OTVJOFlRZlZVWkJiYitQdXpt?=
 =?utf-8?B?d3ZINjZnQklmKzRCd1ZER0k5Tm42ckpBM1FyQ3p5dCttTUhFT3ZSMVQwSjVX?=
 =?utf-8?B?TEhKYUsrNmhnQlRQSlQvTFFadkt6WXRzbG5zWW4rNmFMREIyVWZCMS9QU0Jt?=
 =?utf-8?B?dCtiTWk1UlhBUnpTR21BblEyTWpocjRrS09rRGQ0VXBxYm1nNEVpN2g2R09X?=
 =?utf-8?B?YVlwc285aDR0V0NtMU5LUHhVUzl1S05nUWlhOERmbUVudHpQd3plUTlzVHBO?=
 =?utf-8?B?V1ZnTVFueFJXdUpvOFl1REdJWmJSdTZyYjJ4bm5VNEladHVYNlZhVTREQzBJ?=
 =?utf-8?B?Z0pCZE1lVVZlME1hUUtpdDhuSlpqOVNvUTQ4aitZakxXUkd4MWp2ZUswYzFB?=
 =?utf-8?B?ZE9uckMxT1N4Q1VOb2tQcFFrUjBRTktDMnhpenBzYmdJOFdCeVpzWmthR21y?=
 =?utf-8?B?dXUzYkpHRFV0ZFNYMGtGekJ4ZmUvdDZIM25kZHNtbG12TmwxeHRLcW9HTm9k?=
 =?utf-8?B?VVhhSW5qS3l2ekVCWVR3WWdFQU9JdHhYYmJ3UURIYyswUFdyTjJNMEdyc1VZ?=
 =?utf-8?B?SUxhOE9jUFN0OXA1dStHSDE0ZUhjam9QMC8xbGxIRys1L2gxNUdCakI4ajY0?=
 =?utf-8?B?K0Y3Ykd3Mk03ZGVmdU0wb3FyNVczU240bG1XZ1RTRUM5RzBXNHY4UEpGbE5u?=
 =?utf-8?B?akJUWDFWUVVzcEJHNHgweGl2OHVmckkyaVVUSEpwR2tJQjlacm5OTjBFNm55?=
 =?utf-8?B?b0M3cWdVZDhLYWxhQUJZTTBlbThRKy83dnZxczlXc0VSUWt6OVVpUksyNDYz?=
 =?utf-8?B?MTZaaEtBY2QrTlVUdXo0TEN4MS83Vkh3VGpueStFbXlxVHpsdmpFMDhrTFM0?=
 =?utf-8?B?TjUwVnh6d0x5L0twM0ZENUpKWWhjSnF1MzFUQW5PbmFZREx2dGZXYTA4OTNU?=
 =?utf-8?B?aVhOalhFRkRjY0V5YnB4VXFLNndyZXN3Z2Y4cE84akprT2p5bk5ndnJHTlRx?=
 =?utf-8?B?SlRsbk1pNWUzL2VIelpRT3puME9MaTlCVkU1eFcySlE2cms3UGtMVGs3TlZD?=
 =?utf-8?B?RjkwVjF6T2wxd2wwMHBRcnRrSkdocGVMazllVzVBTUtGZGV4aGhncHE0b0F6?=
 =?utf-8?B?TktUR2FUK3JjVmwzdzluTm0xL3RBOU04VkhoV0E0SnZCZkhaajI2anBvWWdo?=
 =?utf-8?B?cjhmSmxJeUhtc2ovNmRmVDVZRVdYZndmZkt4SUpxb2c0aDNXTVZVNlVSQ1Ex?=
 =?utf-8?B?SklxMmhDVXhKRnN1OTk1d0pYVkZwZnh5aWZXSkJMVjBVaGR2MDBndnpiamxn?=
 =?utf-8?B?aEQzM1diSEJzV25FMVN0b3hBZy9yNTdKdDI4NmZ5S2FaTnhUSW82WkdsZjAy?=
 =?utf-8?Q?t2lqC6?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 08:17:14.4679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a129c92-1d55-4eff-d6be-08dd95e46590
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6446
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

Remove experimental tag on the bitset API.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eal/common/rte_bitset.c  |   2 +-
 lib/eal/include/rte_bitset.h | 137 -----------------------------------
 2 files changed, 1 insertion(+), 138 deletions(-)

diff --git a/lib/eal/common/rte_bitset.c b/lib/eal/common/rte_bitset.c
index 78001b1ee8..0844acffc1 100644
--- a/lib/eal/common/rte_bitset.c
+++ b/lib/eal/common/rte_bitset.c
@@ -10,7 +10,7 @@
 #include <eal_export.h>
 #include "rte_bitset.h"
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bitset_to_str, 24.11)
+RTE_EXPORT_SYMBOL(rte_bitset_to_str)
 ssize_t
 rte_bitset_to_str(const uint64_t *bitset, size_t num_bits, char *buf, size_t capacity)
 {
diff --git a/lib/eal/include/rte_bitset.h b/lib/eal/include/rte_bitset.h
index 27b7a2e34d..c199acc5be 100644
--- a/lib/eal/include/rte_bitset.h
+++ b/lib/eal/include/rte_bitset.h
@@ -87,9 +87,6 @@ extern "C" {
 	fun(&(bitset)[__RTE_BITSET_WORD_IDX(bit_num)], __RTE_BITSET_BIT_OFFSET(bit_num))
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Declare a bitset.
  *
  * Declare (e.g., as a struct field) or define (e.g., as a stack
@@ -115,9 +112,6 @@ extern "C" {
 				__RTE_BITSET_FOREACH_LEFT(var, size, start_bit, len), flags) : -1)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Iterate over all bits set.
  *
  * This macro iterates over all bits set (i.e., all ones) in the
@@ -136,9 +130,6 @@ extern "C" {
 	__RTE_BITSET_FOREACH(var, bitset, size, 0, size, 0)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Iterate over all bits cleared.
  *
  * This macro iterates over all bits cleared in the bitset, in the
@@ -156,9 +147,6 @@ extern "C" {
 	__RTE_BITSET_FOREACH(var, bitset, size, 0, size, __RTE_BITSET_FIND_FLAG_FIND_CLEAR)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Iterate over all bits set within a range.
  *
  * This macro iterates over all bits set (i.e., all ones) in the
@@ -182,9 +170,6 @@ extern "C" {
 	__RTE_BITSET_FOREACH(var, bitset, size, start_bit, len, 0)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Iterate over all cleared bits within a range.
  *
  * This macro iterates over all bits cleared (i.e., all zeroes) in the
@@ -215,9 +200,6 @@ extern "C" {
 		__RTE_BITSET_FIND_FLAG_WRAP | __RTE_BITSET_FIND_FLAG_FIND_CLEAR)
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Initializes a bitset.
  *
  * All bits are cleared.
@@ -231,7 +213,6 @@ extern "C" {
  * @param size
  *   The size of the bitset (in bits).
  */
-__rte_experimental
 static inline void
 rte_bitset_init(uint64_t *bitset, size_t size)
 {
@@ -239,9 +220,6 @@ rte_bitset_init(uint64_t *bitset, size_t size)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Test if a bit is set.
  *
  * @param bitset
@@ -251,7 +229,6 @@ rte_bitset_init(uint64_t *bitset, size_t size)
  * @return
  *   Returns true if the bit is '1', and false if the bit is '0'.
  */
-__rte_experimental
 static inline bool
 rte_bitset_test(const uint64_t *bitset, size_t bit_num)
 {
@@ -259,9 +236,6 @@ rte_bitset_test(const uint64_t *bitset, size_t bit_num)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Set a bit in the bitset.
  *
  * Bits are numbered from 0 to (size - 1) (inclusive).
@@ -273,7 +247,6 @@ rte_bitset_test(const uint64_t *bitset, size_t bit_num)
  * @param bit_num
  *   The index of the bit to be set.
  */
-__rte_experimental
 static inline void
 rte_bitset_set(uint64_t *bitset, size_t bit_num)
 {
@@ -281,9 +254,6 @@ rte_bitset_set(uint64_t *bitset, size_t bit_num)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Clear a bit in the bitset.
  *
  * Bits are numbered 0 to (size - 1) (inclusive).
@@ -295,7 +265,6 @@ rte_bitset_set(uint64_t *bitset, size_t bit_num)
  * @param bit_num
  *   The index of the bit to be cleared.
  */
-__rte_experimental
 static inline void
 rte_bitset_clear(uint64_t *bitset, size_t bit_num)
 {
@@ -303,9 +272,6 @@ rte_bitset_clear(uint64_t *bitset, size_t bit_num)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Set or clear a bit in the bitset.
  *
  * Bits are numbered 0 to (size - 1) (inclusive).
@@ -319,7 +285,6 @@ rte_bitset_clear(uint64_t *bitset, size_t bit_num)
  * @param bit_value
  *   Control if the bit should be set or cleared.
  */
-__rte_experimental
 static inline void
 rte_bitset_assign(uint64_t *bitset, size_t bit_num, bool bit_value)
 {
@@ -327,9 +292,6 @@ rte_bitset_assign(uint64_t *bitset, size_t bit_num, bool bit_value)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Change the value of a bit in the bitset.
  *
  * Bits are numbered 0 to (size - 1) (inclusive).
@@ -341,7 +303,6 @@ rte_bitset_assign(uint64_t *bitset, size_t bit_num, bool bit_value)
  * @param bit_num
  *   The index of the bit to be flipped.
  */
-__rte_experimental
 static inline void
 rte_bitset_flip(uint64_t *bitset, size_t bit_num)
 {
@@ -349,9 +310,6 @@ rte_bitset_flip(uint64_t *bitset, size_t bit_num)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically test if a bit is set.
  *
  * Atomically test if a bit in a bitset is set with the specified
@@ -366,7 +324,6 @@ rte_bitset_flip(uint64_t *bitset, size_t bit_num)
  * @return
  *   Returns true if the bit is '1', and false if the bit is '0'.
  */
-__rte_experimental
 static inline bool
 rte_bitset_atomic_test(const uint64_t *bitset, size_t bit_num, int memory_order)
 {
@@ -374,9 +331,6 @@ rte_bitset_atomic_test(const uint64_t *bitset, size_t bit_num, int memory_order)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically set a bit in the bitset.
  *
  * Set a bit in a bitset as an atomic operation, with the specified
@@ -395,7 +349,6 @@ rte_bitset_atomic_test(const uint64_t *bitset, size_t bit_num, int memory_order)
  * @param memory_order
  *   The memory order to use.
  */
-__rte_experimental
 static inline void
 rte_bitset_atomic_set(uint64_t *bitset, size_t bit_num, int memory_order)
 {
@@ -403,9 +356,6 @@ rte_bitset_atomic_set(uint64_t *bitset, size_t bit_num, int memory_order)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically clear a bit in the bitset.
  *
  * Clear a bit in a bitset as an atomic operation, with the specified
@@ -424,7 +374,6 @@ rte_bitset_atomic_set(uint64_t *bitset, size_t bit_num, int memory_order)
  * @param memory_order
  *   The memory order to use.
  */
-__rte_experimental
 static inline void
 rte_bitset_atomic_clear(uint64_t *bitset, size_t bit_num, int memory_order)
 {
@@ -432,9 +381,6 @@ rte_bitset_atomic_clear(uint64_t *bitset, size_t bit_num, int memory_order)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically set or clear a bit in the bitset.
  *
  * Assign a value to a bit in a bitset as an atomic operation, with
@@ -455,7 +401,6 @@ rte_bitset_atomic_clear(uint64_t *bitset, size_t bit_num, int memory_order)
  * @param memory_order
  *   The memory order to use.
  */
-__rte_experimental
 static inline void
 rte_bitset_atomic_assign(uint64_t *bitset, size_t bit_num, bool bit_value, int memory_order)
 {
@@ -463,9 +408,6 @@ rte_bitset_atomic_assign(uint64_t *bitset, size_t bit_num, bool bit_value, int m
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Atomically change the value of a bit in the bitset.
  *
  * Flip a bit in a bitset as an atomic operation, with the specified
@@ -484,7 +426,6 @@ rte_bitset_atomic_assign(uint64_t *bitset, size_t bit_num, bool bit_value, int m
  * @param memory_order
  *   The memory order to use.
  */
-__rte_experimental
 static inline void
 rte_bitset_atomic_flip(uint64_t *bitset, size_t bit_num, int memory_order)
 {
@@ -492,9 +433,6 @@ rte_bitset_atomic_flip(uint64_t *bitset, size_t bit_num, int memory_order)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Set all bits in the bitset.
  *
  * @param bitset
@@ -502,7 +440,6 @@ rte_bitset_atomic_flip(uint64_t *bitset, size_t bit_num, int memory_order)
  * @param size
  *   The size of the bitset (in bits).
  */
-__rte_experimental
 static inline void
 rte_bitset_set_all(uint64_t *bitset, size_t size)
 {
@@ -510,9 +447,6 @@ rte_bitset_set_all(uint64_t *bitset, size_t size)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Clear all bits in the bitset.
  *
  * @param bitset
@@ -520,7 +454,6 @@ rte_bitset_set_all(uint64_t *bitset, size_t size)
  * @param size
  *   The size of the bitset (in bits).
  */
-__rte_experimental
 static inline void
 rte_bitset_clear_all(uint64_t *bitset, size_t size)
 {
@@ -528,9 +461,6 @@ rte_bitset_clear_all(uint64_t *bitset, size_t size)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Count all set bits (also known as the @e weight).
  *
  * @param bitset
@@ -540,7 +470,6 @@ rte_bitset_clear_all(uint64_t *bitset, size_t size)
  * @return
  *   Returns the number of '1' bits in the bitset.
  */
-__rte_experimental
 static inline size_t
 rte_bitset_count_set(const uint64_t *bitset, size_t size)
 {
@@ -560,9 +489,6 @@ rte_bitset_count_set(const uint64_t *bitset, size_t size)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Count all cleared bits.
  *
  * @param bitset
@@ -572,7 +498,6 @@ rte_bitset_count_set(const uint64_t *bitset, size_t size)
  * @return
  *   Returns the number of '0' bits in the bitset.
  */
-__rte_experimental
 static inline size_t
 rte_bitset_count_clear(const uint64_t *bitset, size_t size)
 {
@@ -582,7 +507,6 @@ rte_bitset_count_clear(const uint64_t *bitset, size_t size)
 #define __RTE_BITSET_FIND_FLAG_FIND_CLEAR (1U << 0)
 #define __RTE_BITSET_FIND_FLAG_WRAP (1U << 1)
 
-__rte_experimental
 static inline ssize_t
 __rte_bitset_find_nowrap(const uint64_t *bitset, size_t __rte_unused size, size_t start_bit,
 		size_t len, bool find_clear)
@@ -630,7 +554,6 @@ __rte_bitset_find_nowrap(const uint64_t *bitset, size_t __rte_unused size, size_
 
 }
 
-__rte_experimental
 static inline ssize_t
 __rte_bitset_find(const uint64_t *bitset, size_t size, size_t start_bit, size_t len,
 		unsigned int flags)
@@ -658,9 +581,6 @@ __rte_bitset_find(const uint64_t *bitset, size_t size, size_t start_bit, size_t
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Find first bit set.
  *
  * Scans the bitset in the forward direction (i.e., starting at the
@@ -674,7 +594,6 @@ __rte_bitset_find(const uint64_t *bitset, size_t size, size_t start_bit, size_t
  *   Returns the index of the least significant '1', or -1 if all
  *   bits are '0'.
  */
-__rte_experimental
 static inline ssize_t
 rte_bitset_find_first_set(const uint64_t *bitset, size_t size)
 {
@@ -682,9 +601,6 @@ rte_bitset_find_first_set(const uint64_t *bitset, size_t size)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Find first bit set at offset.
  *
  * Scans the bitset in the forward direction (i.e., starting at the
@@ -704,7 +620,6 @@ rte_bitset_find_first_set(const uint64_t *bitset, size_t size)
  *   Returns the index of the least significant '1', or -1 if all
  *   bits are '0'.
  */
-__rte_experimental
 static inline ssize_t
 rte_bitset_find_set(const uint64_t *bitset, size_t size, size_t start_bit, size_t len)
 {
@@ -712,9 +627,6 @@ rte_bitset_find_set(const uint64_t *bitset, size_t size, size_t start_bit, size_
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Find first bit set at offset, with wrap-around.
  *
  * Scans the bitset in the forward direction (i.e., starting at the
@@ -735,7 +647,6 @@ rte_bitset_find_set(const uint64_t *bitset, size_t size, size_t start_bit, size_
  *   Returns the index of the least significant '1', or -1 if all
  *   bits are '0'.
  */
-__rte_experimental
 static inline ssize_t
 rte_bitset_find_set_wrap(const uint64_t *bitset, size_t size, size_t start_bit, size_t len)
 {
@@ -743,9 +654,6 @@ rte_bitset_find_set_wrap(const uint64_t *bitset, size_t size, size_t start_bit,
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Find first cleared bit.
  *
  * Scans the bitset in the forward direction (i.e., starting at the
@@ -759,7 +667,6 @@ rte_bitset_find_set_wrap(const uint64_t *bitset, size_t size, size_t start_bit,
  *   Returns the index of the least significant '0', or -1 if all
  *   bits are '1'.
  */
-__rte_experimental
 static inline ssize_t
 rte_bitset_find_first_clear(const uint64_t *bitset, size_t size)
 {
@@ -767,9 +674,6 @@ rte_bitset_find_first_clear(const uint64_t *bitset, size_t size)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Find first cleared bit at offset.
  *
  * Scans the bitset in the forward direction (i.e., starting at the
@@ -789,7 +693,6 @@ rte_bitset_find_first_clear(const uint64_t *bitset, size_t size)
  *   Returns the index of the least significant '0', or -1 if all
  *   bits are '1'.
  */
-__rte_experimental
 static inline ssize_t
 rte_bitset_find_clear(const uint64_t *bitset, size_t size, size_t start_bit, size_t len)
 {
@@ -797,9 +700,6 @@ rte_bitset_find_clear(const uint64_t *bitset, size_t size, size_t start_bit, siz
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Find first cleared bit at offset, with wrap-around.
  *
  * Scans the bitset in the forward direction (i.e., starting at the
@@ -820,7 +720,6 @@ rte_bitset_find_clear(const uint64_t *bitset, size_t size, size_t start_bit, siz
  *   Returns the index of the least significant '0', or -1 if all
  *   bits are '1'.
  */
-__rte_experimental
 static inline ssize_t
 rte_bitset_find_clear_wrap(const uint64_t *bitset, size_t size, size_t start_bit, size_t len)
 {
@@ -829,9 +728,6 @@ rte_bitset_find_clear_wrap(const uint64_t *bitset, size_t size, size_t start_bit
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Copy bitset.
  *
  * Copy the bits of the @c src_bitset to the @c dst_bitset.
@@ -845,7 +741,6 @@ rte_bitset_find_clear_wrap(const uint64_t *bitset, size_t size, size_t start_bit
  * @param size
  *   The size of the bitsets (in bits).
  */
-__rte_experimental
 static inline void
 rte_bitset_copy(uint64_t *__rte_restrict dst_bitset, const uint64_t *__rte_restrict src_bitset,
 		size_t size)
@@ -854,9 +749,6 @@ rte_bitset_copy(uint64_t *__rte_restrict dst_bitset, const uint64_t *__rte_restr
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Bitwise or two bitsets.
  *
  * Perform a bitwise OR operation on all bits in the two equal-size
@@ -872,7 +764,6 @@ rte_bitset_copy(uint64_t *__rte_restrict dst_bitset, const uint64_t *__rte_restr
  * @param size
  *   The size of the bitsets (in bits).
  */
-__rte_experimental
 static inline void
 rte_bitset_or(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t *src_bitset1,
 		size_t size)
@@ -884,9 +775,6 @@ rte_bitset_or(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Bitwise and two bitsets.
  *
  * Perform a bitwise AND operation on all bits in the two equal-size
@@ -902,7 +790,6 @@ rte_bitset_or(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t
  * @param size
  *   The size of the bitsets (in bits).
  */
-__rte_experimental
 static inline void
 rte_bitset_and(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t *src_bitset1,
 		size_t size)
@@ -914,9 +801,6 @@ rte_bitset_and(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Bitwise xor two bitsets.
  *
  * Perform a bitwise XOR operation on all bits in the two equal-size
@@ -932,7 +816,6 @@ rte_bitset_and(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t
  * @param size
  *   The size of the bitsets (in bits).
  */
-__rte_experimental
 static inline void
 rte_bitset_xor(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t *src_bitset1,
 		size_t size)
@@ -944,9 +827,6 @@ rte_bitset_xor(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Compute the bitwise complement of a bitset.
  *
  * Flip every bit in the @c src_bitset, and store the result in @c
@@ -959,7 +839,6 @@ rte_bitset_xor(uint64_t *dst_bitset, const uint64_t *src_bitset0, const uint64_t
  * @param size
  *   The size of the bitsets (in bits).
  */
-__rte_experimental
 static inline void
 rte_bitset_complement(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t size)
 {
@@ -970,9 +849,6 @@ rte_bitset_complement(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t s
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Shift bitset left.
  *
  * Perform a logical shift left of (multiply) @c src_bitset, and store
@@ -987,7 +863,6 @@ rte_bitset_complement(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t s
  * @param shift_bits
  *   The number of bits to shift the bitset.
  */
-__rte_experimental
 static inline void
 rte_bitset_shift_left(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t size,
 		size_t shift_bits)
@@ -1015,9 +890,6 @@ rte_bitset_shift_left(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t s
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Shift bitset right.
  *
  * Perform a logical shift right of (divide) @c src_bitset, and store
@@ -1032,7 +904,6 @@ rte_bitset_shift_left(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t s
  * @param shift_bits
  *   The number of bits to shift the bitset.
  */
-__rte_experimental
 static inline void
 rte_bitset_shift_right(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t size,
 		size_t shift_bits)
@@ -1071,9 +942,6 @@ rte_bitset_shift_right(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Compare two bitsets.
  *
  * Compare two bitsets for equality.
@@ -1085,7 +953,6 @@ rte_bitset_shift_right(uint64_t *dst_bitset, const uint64_t *src_bitset, size_t
  * @param size
  *   The size of the bitsets (in bits).
  */
-__rte_experimental
 static inline bool
 rte_bitset_equal(const uint64_t *bitset_a, const uint64_t *bitset_b, size_t size)
 {
@@ -1103,9 +970,6 @@ rte_bitset_equal(const uint64_t *bitset_a, const uint64_t *bitset_b, size_t size
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
  * Converts a bitset to a string.
  *
  * This function prints a string representation of the bitstring to
@@ -1127,7 +991,6 @@ rte_bitset_equal(const uint64_t *bitset_a, const uint64_t *bitset_b, size_t size
  *   Returns the number of bytes written (i.e., @c size + 1), or -EINVAL
  *   in case the buffer capacity was too small.
  */
-__rte_experimental
 ssize_t
 rte_bitset_to_str(const uint64_t *bitset, size_t size, char *buf, size_t capacity);
 
-- 
2.43.0

