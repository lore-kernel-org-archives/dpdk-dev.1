Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9951C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 May 2025 08:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8FC440A71;
	Sun, 18 May 2025 10:17:20 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012037.outbound.protection.outlook.com [52.101.71.37])
 by mails.dpdk.org (Postfix) with ESMTP id C2D6D40608
 for <dev@dpdk.org>; Sun, 18 May 2025 10:17:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BML4WXIkvjMaH3Il3o1WuUfM4SxPeF6SHA5aGPAYHmkm2estCfBEbcme3/Bjmvi+OLfC7EvDpAflyo5mPGNbZFnWi4JtR375jVzYzaLHatTrG7vg91dgUiEQT74uEM5m22LsWJW5LjftJvSHyg0NsMxUvb+EMQ3Bx4V+03hBdd3f+Q0rsfiE/N6SQ6GX1nhS+66vC+2eLNAOIqLa6nxIUPZcWPZ9u8MM/Fhj2OAYvyNEj9f50Os4Q1+A2ElYIWBHK+GV7f2g8JTMPiX2HJRY6jJxMMdX9mVVsfXXlnKhDx0zaQ6m89Aqxs6w4J1HJkXsdcJKR+8p288X0oO9hZQz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWFfr71EZ7hQiFU+/0Zmj0KaNjuXxdVMvdibH/pJweU=;
 b=oI6IUaI/pdI6onPgT/F0mloy+WxWP1zPHHDM0/LxVYitg7HNRFXSSmYsaK0IT4+LDofSL3r7IOpsu56UIgzZ1WgSSzf0T3lDy3/RUr6W07XhO0xPzfzn+QuROIsZP8U0zewMBOBx3d2qMAsAXgwPWPHNwTUgAos/UCHe2XtnigEZasXSCtPI0k3Vu2Oa1MP3owAzqDbQI1S/0loIWmjgxL5AXgEiXBhwgyOlGk1F9cHK3jiEa5txUP4CnF0J/qSZhOkXNOPsLTlR8zBRg6azaFdKHie91FqRTADQ8qFkuxq9zSMuDMhQ0ah7cjt1vyPV80Vz0U5tFl1CjSZ3nZPSAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWFfr71EZ7hQiFU+/0Zmj0KaNjuXxdVMvdibH/pJweU=;
 b=LYTpX5252YEetXlCzKlHXuDt/mRmLNg1oulNVJuKETCR75yDDpGahCTFey0bv6NFG5rvr5dBp3DTisWQ468sXt7/z9wIi4BWqRDxY/qY09+jZ4kWbZz6ApspU1VudMEKoXcnWWyGe7+vcOndyjJlAlFbbVyLb2UwWttjhgV0XzbTpmy1R6NEiT4ekTP0otwXxifcInPCpi1qu3xAODufN9gisKp8VA93FdR9/yy2YtF5gGXw2DdreiYllFjhmhwxDVn7b1D9i/IxB2iqro/gdV7ktGZoVB3CPw+IW2c6wVagfKlUi2HsTEApWUcg7FKFQpPAMXegHQTBRtmRjGCrTw==
Received: from DU2P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::14)
 by AM7PR07MB6721.eurprd07.prod.outlook.com (2603:10a6:20b:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 18 May
 2025 08:17:14 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::6) by DU2P251CA0004.outlook.office365.com
 (2603:10a6:10:230::14) with Microsoft SMTP Server (version=TLS1_3,
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
 15.20.8746.27 via Frontend Transport; Sun, 18 May 2025 08:17:12 +0000
Received: from seliicinfr00050.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 18 May 2025 10:17:10 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00050.seli.gic.ericsson.se (Postfix) with ESMTP id
 617D51C006B; Sun, 18 May 2025 10:17:10 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "David
 Marchand" <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>, 
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 2/3] bitset: remove experimental bitops workaround
Date: Sun, 18 May 2025 10:05:55 +0200
Message-ID: <20250518080556.675092-2-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
References: <20250518080556.675092-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|AM7PR07MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d2f01b1-c157-482d-0ac2-08dd95e46450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUM5YUtFaGQ4SHdMbzVKcHVsY2J5aEVuTERyeFpUbmNNdmdMT2tGZXBUS2Y4?=
 =?utf-8?B?WXg5cVhyakRkeXZOSkU5dFRFU2J6MTI0dVQ4ZUMrMzBaRXU5cHhOZjg5aGtH?=
 =?utf-8?B?dXQxOUtRNUtRTTJCbmVOd29NalY4MklyaHRva2ErSFYwVldSSG5yRGx1bnFj?=
 =?utf-8?B?V1p0djBGYkRSSWpTUnQwTkhYZ0hLS1dqandqYmtqRVJTOEhKUk9PeVFkVm9o?=
 =?utf-8?B?WCtpdmdtWFVicmpxSFZSWmRMdUlEVVNZTnJFUnk3ZFVoQjIvdFdNYXpZVFli?=
 =?utf-8?B?c2ZEaUo4SERYSzNNNE5uaFhKazFsQ0h6OWZ5dC9nZ3lxS3FOK05TcTdpMzVY?=
 =?utf-8?B?WUtGUGNjTlF2NTkwRHp1ZkpwWG1qRUJSNWV4VHMxQjVYNXZYRGxISXk2SE9Q?=
 =?utf-8?B?U0Zxb1RxclNrRFBweWx3WlYxcHkvU01oc0tNWWhmU3Via0JLcUw4TWo1dFB6?=
 =?utf-8?B?LytJdzAvSUNqQ0htUlB6NEZBMldldlA4RzR6VjZybnM0S0hFK0xWbDB0Vnc1?=
 =?utf-8?B?dUY3LzRiZUk5bUlhU1dLdkdJc0h5M3YzVlJ6MWlNQXdtRHhwVmZNR3I5YjJt?=
 =?utf-8?B?cDhLbXFYdzh4RnBLamtEVW8ydjhFeXU2TVB1OFRMdzZzb0RhV2RoOXVYMHA4?=
 =?utf-8?B?WnQwbWZVQlFWZEV1bnlyM0xEUURhVFZKWUZRek1hKzlxM1JJcUdsN3VNaHdD?=
 =?utf-8?B?Ly9ZZmxFYjJwOFNPT2Z4dGFZRCtxdGFIZFh4UDJzYW1uM3JPS2xhUWhlaGUv?=
 =?utf-8?B?M0RjT1I2YTdQdFk5S3hyQzlIOTF5OTV3WTVNeVE0cFUxMW8xTkxiUzRnU2N5?=
 =?utf-8?B?SnRjTkQyWTluTE1IdVUydTJVS1hGYkxieDlTRkR5KzE2UHpoNFpGWmJ6Q09V?=
 =?utf-8?B?Skc1T0NzclpGS0REMGJrQytGb3U1STVSZHVlSS9NMGNyWkJVbXU3TUtDNW1L?=
 =?utf-8?B?cE9EMitsQVZOell0ZVVTYmNURjQ4SklHTUl3QkRkRVBFdFptelZmOEY2UDZo?=
 =?utf-8?B?QmkzSm9BQjdlTXBnTEF4bjNyVm1LR1dXZTNYeXpZUnQxS01RMG45OXE2Vnk3?=
 =?utf-8?B?aGxNRWRkbWoybksrRVp4K084czJCbXg0MFRSREl3OHArcXVYTlkwdGozQlR0?=
 =?utf-8?B?QVM3RnVPeFBNQnVSUmphZW5ORk5KSU1LeUd1clE2RVdickw1aCt4MWdNWHpm?=
 =?utf-8?B?a0g3YjlQSzdsVkh2ZUxTQzhyRmFtVUdhQVZpNjJpdXgyUklRQnVDWnpKVTc3?=
 =?utf-8?B?NXFjTzRuTXBpT21nNnFhNGszOTkyd0MwRDRpdlFSYjFmSkNLZDByNlpRb0Na?=
 =?utf-8?B?V08rMGFOeDZCYmxmV1pXdkNlekFBT1FyQUdneUxSVDQ2VGgwaFhRQ29xVC9y?=
 =?utf-8?B?M1dnd3lKbm9xZEo5TlNGVHNMTWNIM2h1YUcwTFluOC9SNDA3OUxMSndjM1l0?=
 =?utf-8?B?KzFRQm1vemxub0k1Wng0amhBVndPZnZoM0ZRM0g2cW54MjZmNStBOVZzaFV3?=
 =?utf-8?B?b3MxUTNLMEx2bVBkYXh6YmRNM0R0aFBITFZNbzZoTWFvc2w0WEIvVEdNRFF5?=
 =?utf-8?B?QzhFRWQwOGo5TXNqVXJERlVmb2Q5RXFiUVl5S2FTMysvSDFTUEJaSVl0UE1h?=
 =?utf-8?B?OHpwRjM5WXZadHpRblhtcGFJQnFBNllyMmU3VlUzeVcvVzd0L3hsVi9aZ3l0?=
 =?utf-8?B?V3lyaHNUMWNKRlZMMC9DMjQ0K1ZYVzhXYUtwclRtbDRycHRtcThmSHV6RzZy?=
 =?utf-8?B?UVNvQXVtOFJXczNVcjYrR0cycmdnSXBWM2FNWWN4bGJnYTdNeXp2VGJSWEJF?=
 =?utf-8?B?WTAzMUJXWGFaSlZlN2t3NVdHWjNpSmJjMGY2Q1FlYmcyaURPRTNxZDdkbVhX?=
 =?utf-8?B?MytDTkVKbWRWekhNcElYUitXQzlsRkc4dHp3WHk5RlFhcytXdTE3OXRtRnpO?=
 =?utf-8?B?bkNhbHk4REJLZHIwbDJJcTFvRFZhWllVUWtycURJbjhjaG1CWms4LzJPNjE0?=
 =?utf-8?B?TW5jNnhHUlU0c3ZBeTJXaXlYV21GdGEyTlZSNE5FSzgrYmNoSnNNNEt3Z3Jk?=
 =?utf-8?Q?cyYt/G?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 08:17:12.3617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2f01b1-c157-482d-0ac2-08dd95e46450
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6721
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

With bitops APIs used by bitset stable, the workaround required to fix
build for GCC without experimental API is no longer needed.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eal/include/rte_bitset.h | 132 -----------------------------------
 1 file changed, 132 deletions(-)

diff --git a/lib/eal/include/rte_bitset.h b/lib/eal/include/rte_bitset.h
index 116121eec4..27b7a2e34d 100644
--- a/lib/eal/include/rte_bitset.h
+++ b/lib/eal/include/rte_bitset.h
@@ -255,13 +255,7 @@ __rte_experimental
 static inline bool
 rte_bitset_test(const uint64_t *bitset, size_t bit_num)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return __RTE_BITSET_DELEGATE(rte_bit_test, bitset, bit_num);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -283,13 +277,7 @@ __rte_experimental
 static inline void
 rte_bitset_set(uint64_t *bitset, size_t bit_num)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	__RTE_BITSET_DELEGATE(rte_bit_set, bitset, bit_num);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -311,13 +299,7 @@ __rte_experimental
 static inline void
 rte_bitset_clear(uint64_t *bitset, size_t bit_num)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	__RTE_BITSET_DELEGATE(rte_bit_clear, bitset, bit_num);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -341,14 +323,7 @@ __rte_experimental
 static inline void
 rte_bitset_assign(uint64_t *bitset, size_t bit_num, bool bit_value)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	__RTE_BITSET_DELEGATE_N(rte_bit_assign, bitset, bit_num, bit_value);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_SET_USED(bit_value);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -370,13 +345,7 @@ __rte_experimental
 static inline void
 rte_bitset_flip(uint64_t *bitset, size_t bit_num)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	__RTE_BITSET_DELEGATE(rte_bit_flip, bitset, bit_num);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -401,14 +370,7 @@ __rte_experimental
 static inline bool
 rte_bitset_atomic_test(const uint64_t *bitset, size_t bit_num, int memory_order)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return __RTE_BITSET_DELEGATE_N(rte_bit_atomic_test, bitset, bit_num, memory_order);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_SET_USED(memory_order);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -437,14 +399,7 @@ __rte_experimental
 static inline void
 rte_bitset_atomic_set(uint64_t *bitset, size_t bit_num, int memory_order)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	__RTE_BITSET_DELEGATE_N(rte_bit_atomic_set, bitset, bit_num, memory_order);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_SET_USED(memory_order);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -473,14 +428,7 @@ __rte_experimental
 static inline void
 rte_bitset_atomic_clear(uint64_t *bitset, size_t bit_num, int memory_order)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	__RTE_BITSET_DELEGATE_N(rte_bit_atomic_clear, bitset, bit_num, memory_order);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_SET_USED(memory_order);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -511,15 +459,7 @@ __rte_experimental
 static inline void
 rte_bitset_atomic_assign(uint64_t *bitset, size_t bit_num, bool bit_value, int memory_order)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	__RTE_BITSET_DELEGATE_N(rte_bit_atomic_assign, bitset, bit_num, bit_value, memory_order);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_SET_USED(bit_value);
-	RTE_SET_USED(memory_order);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -548,14 +488,7 @@ __rte_experimental
 static inline void
 rte_bitset_atomic_flip(uint64_t *bitset, size_t bit_num, int memory_order)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	__RTE_BITSET_DELEGATE_N(rte_bit_atomic_flip, bitset, bit_num, memory_order);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(bit_num);
-	RTE_SET_USED(memory_order);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -591,13 +524,7 @@ __rte_experimental
 static inline void
 rte_bitset_clear_all(uint64_t *bitset, size_t size)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	rte_bitset_init(bitset, size);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -649,13 +576,7 @@ __rte_experimental
 static inline size_t
 rte_bitset_count_clear(const uint64_t *bitset, size_t size)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return size - rte_bitset_count_set(bitset, size);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_VERIFY(false);
-#endif
 }
 
 #define __RTE_BITSET_FIND_FLAG_FIND_CLEAR (1U << 0)
@@ -714,7 +635,6 @@ static inline ssize_t
 __rte_bitset_find(const uint64_t *bitset, size_t size, size_t start_bit, size_t len,
 		unsigned int flags)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	bool find_clear = flags & __RTE_BITSET_FIND_FLAG_FIND_CLEAR;
 	bool may_wrap = flags & __RTE_BITSET_FIND_FLAG_WRAP;
 	bool does_wrap = (start_bit + len) > size;
@@ -735,14 +655,6 @@ __rte_bitset_find(const uint64_t *bitset, size_t size, size_t start_bit, size_t
 		rc = __rte_bitset_find_nowrap(bitset, size, start_bit, len, find_clear);
 
 	return rc;
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_SET_USED(start_bit);
-	RTE_SET_USED(len);
-	RTE_SET_USED(flags);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -766,13 +678,7 @@ __rte_experimental
 static inline ssize_t
 rte_bitset_find_first_set(const uint64_t *bitset, size_t size)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return __rte_bitset_find(bitset, size, 0, size, 0);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -802,15 +708,7 @@ __rte_experimental
 static inline ssize_t
 rte_bitset_find_set(const uint64_t *bitset, size_t size, size_t start_bit, size_t len)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return __rte_bitset_find(bitset, size, start_bit, len, 0);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_SET_USED(start_bit);
-	RTE_SET_USED(len);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -841,15 +739,7 @@ __rte_experimental
 static inline ssize_t
 rte_bitset_find_set_wrap(const uint64_t *bitset, size_t size, size_t start_bit, size_t len)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return __rte_bitset_find(bitset, size, start_bit, len, __RTE_BITSET_FIND_FLAG_WRAP);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_SET_USED(start_bit);
-	RTE_SET_USED(len);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -873,13 +763,7 @@ __rte_experimental
 static inline ssize_t
 rte_bitset_find_first_clear(const uint64_t *bitset, size_t size)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return __rte_bitset_find(bitset, size, 0, size, __RTE_BITSET_FIND_FLAG_FIND_CLEAR);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -909,15 +793,7 @@ __rte_experimental
 static inline ssize_t
 rte_bitset_find_clear(const uint64_t *bitset, size_t size, size_t start_bit, size_t len)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return __rte_bitset_find(bitset, size, start_bit, len, __RTE_BITSET_FIND_FLAG_FIND_CLEAR);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_SET_USED(start_bit);
-	RTE_SET_USED(len);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
@@ -948,16 +824,8 @@ __rte_experimental
 static inline ssize_t
 rte_bitset_find_clear_wrap(const uint64_t *bitset, size_t size, size_t start_bit, size_t len)
 {
-#ifdef ALLOW_EXPERIMENTAL_API
 	return __rte_bitset_find(bitset, size, start_bit, len,
 		__RTE_BITSET_FIND_FLAG_FIND_CLEAR | __RTE_BITSET_FIND_FLAG_WRAP);
-#else
-	RTE_SET_USED(bitset);
-	RTE_SET_USED(size);
-	RTE_SET_USED(start_bit);
-	RTE_SET_USED(len);
-	RTE_VERIFY(false);
-#endif
 }
 
 /**
-- 
2.43.0

