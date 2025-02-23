Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF90C021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 13:04:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06746402D6;
	Sun, 23 Feb 2025 14:04:24 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012007.outbound.protection.outlook.com [52.101.71.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5B89C402C2
 for <dev@dpdk.org>; Sun, 23 Feb 2025 14:04:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BN4lQNwhsmqaBs0MJ0BPtZwtWAg9CKhavmcIpo8xiQJuaw9Eg9vH+eNpa+7aYDcxeqx0laZzOUD/6xjnmNVeZoff+jULAOkE53mFEapKuRBH6cEErhTcxyCH0QbbeKgE8yH41Pp83HbJ/Uttu6s0swoUvdDbaA5EtkzMM3XbZbLIAvPBdR0EyYjlxIZd2bO3oYBfTUGKfXw4Rc2xax62jq2yZmU9X0wJpTVdxO3MDzDz6KHF4AMR6jVJAqwE7kf1s9ul/ytZE3ulubhb5V7NgLN0NbcT0BLsedFqfR3tQKUDCYD7ZwXhpb5kbcAKb55RDHzP0+9gntp8ZpsOnuao1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx8dTt8fd/aYIfwN8z5RNsu0TO2SXB1jeWqiCorAjrU=;
 b=sQ5Y5DfR+ItfXiEuwhSLbzMHZCrdPA+QEFe5teAUEPu5Vpd7dcah27HJHL31uaRmmFBGgJhCxRhmQP89QqmrdB02yi45xJOvsz8cehWIH2CzJ79wo20u4A6opqna+EiheE5/PVUKB8wNkVmqsX6nqDGtyiu43IigoypVUy5pB/DsAoX9GxQRr/XxrhOHIozBHgYEMI0UP96RUzDHfRqst7DLk/Iv+2Q6JWiNrHj2sCR3I8M5P0GPWTwwlzoZOd7fae9vZV3RPLAP1RstjoWHaUV1UYGYdnBptbUwk55Uv1olesyqs5pd/2FZ07C9/QOWpdofsHqTyElN6uqPkFCw7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx8dTt8fd/aYIfwN8z5RNsu0TO2SXB1jeWqiCorAjrU=;
 b=tyF5FmzsZ6iVEmKj+3Bakg4PXu2DXKcUqpLs92VhsbpkRRt6JAxfJdO8PL6BHf48CN0my3Ismy75Z9fr4li8M+gVLP8q9bybEo3zeGlYbwKc6wo9j/Z3lbgbvp4MS7s7P/RYWXexh04IY0ZmvBlarD5h/o6ue6sNRH+P489/LJaCBXaws0Uk0yU+bO468DDvV0OZKheD6yZOeUP+G5jhH1OBv0YmjKuWUokp0Lc1ymfYE7bpIOQuVhvcEjYutAUqeX2R3uMszUIGGf7P+McvJOeMzhFeZPUB+hJ7yBUmlUnXFVtBki/mpt1zvPjkYq9Ol9Wp6twQtgmc2O7UyzDYWA==
Received: from DU7P194CA0017.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::6) by
 PAXPR07MB8748.eurprd07.prod.outlook.com (2603:10a6:102:247::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 13:04:17 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::38) by DU7P194CA0017.outlook.office365.com
 (2603:10a6:10:553::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Sun,
 23 Feb 2025 13:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 23 Feb 2025 13:04:16 +0000
Received: from seliicinfr00049.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 23 Feb 2025 14:04:16 +0100
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00049.seli.gic.ericsson.se (Postfix) with ESMTP id
 E410838007A; Sun, 23 Feb 2025 14:04:15 +0100 (CET)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 1/1] eal/x86: replace inline assembly prefetch with cc builtins
Date: Sun, 23 Feb 2025 13:52:15 +0100
Message-ID: <20250223125215.358925-2-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223125215.358925-1-mattias.ronnblom@ericsson.com>
References: <20250223125215.358925-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|PAXPR07MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e81656-13e4-4744-a958-08dd540a9406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anQ5d3FCOW96TTFteEdMY2ZWQVNJMW9acXBjSzkwT1NQZnV5TGN1NEZxTmVO?=
 =?utf-8?B?Qzl6L1hrODRwNFJEY1JpMHE5dG53bVFkK09xaXBPNUtTMThuNk9WdUFqS2NM?=
 =?utf-8?B?RFdJQzZZQ0hCemVWYytRS0FPdEJlMTZEWkNPRGhUeVlSTXJKU0dOQjAyT2th?=
 =?utf-8?B?ZGVpOUd2WngyV3ZNQW15WVd3ZW92eUhwcVZtMGlQVloyejBaUndpUXVJckVj?=
 =?utf-8?B?endqemowR1V1VVYwTzB0cCtmdWRmSnNyNzJNYlZ5UWJRZ1M4VW92NFA3WHpn?=
 =?utf-8?B?Mkp4R0RQSnQ1OUl1NG9OeEJKZnZWT2ZPNWZHQ1VSeFdOSkhrdVRITWY3Y2ta?=
 =?utf-8?B?WkZsOGowelVyY0tYTE41TTRkdEtNSnhrMjAvQ3hXNXNiSlFUWHJTVStvVCt4?=
 =?utf-8?B?SlpQMnUza2c5djNKUTcxV0VyVDRYU2RpbkNqYnJmZHNON3FRbndvbVI5a0FP?=
 =?utf-8?B?TEFqVG1RdjRmb25HbmNHTjZjdktqdGdwUTN4dUVZb1RuQWNtQzRXcHVEa3RL?=
 =?utf-8?B?WFVWamtJYTJ4YXJNa0xTZXBDRzZIMTlySEs0WWtlUmtpalpJRmVZR0FoZ0hQ?=
 =?utf-8?B?YWZCbG1xUWlJcFg2OXlOYVJBYU8rSHJPTkkrOGJ3UnNLbG5vVnB4Y2szaGI1?=
 =?utf-8?B?YkJBVjkyU2RKWXFzb09LKy90QjhsNG1CWjRsYlp3Y0x2UjBIME50aXJ3TlVy?=
 =?utf-8?B?ZkVsMXB3V2tuT2dkRGJNdDZ4eEFRUkFWZS9zS1ovcjZpWG1jWGF2SDNrMXpp?=
 =?utf-8?B?RXdMd1l1d1hrbDRJSlF3RGZzNXloUHpoSHVyQmJQSnRiL1A2N1BiZWZhMDhv?=
 =?utf-8?B?Sm5KS2ZHMUJ6MTZ2UDhtRXJ5bjVZNWp6V1FGQWFxYzFuN0dZMVdHNGtNczdk?=
 =?utf-8?B?WHNiL3p2NXdZR1lQZE9WWXd4VEMyU3FxZU9PTUlUY2lveVNqeXM3ajZvTWEr?=
 =?utf-8?B?WWtDS212NlhVZlcvVzVjY1pqYitIUlZscU1QNEFoTDhkempzSDNCR2tnY2tH?=
 =?utf-8?B?YTBta001UTF4SGdVTS9iU2txWXhCL1NiZ3pRNEp4cVZaWDF4NERibDdlcC9J?=
 =?utf-8?B?aE1BLzJkSXVld09tRktldjBkKzk4d0NMQTJyTFNDUzlRcTVacDJETFpMcjdT?=
 =?utf-8?B?YnBWdDdtUTNpNWtUaVdwY0xXNW5ZakZMZitMbDhBUFBCUUk3MG4yRUZLWWl0?=
 =?utf-8?B?eW53Snh1TERFOG5UNlZSa0psLzVST0FXRUxqdzBzdEVGem5VeTV1QUw5U1Iz?=
 =?utf-8?B?RWRaWTVWMjFQNzNSN3F2OVp1TmxOQk5BKytDQk5mdUZRdFNYSmdSQXc1di9u?=
 =?utf-8?B?T1N0VEV3N0t4aFlpUEJOSXUrL2x0ZUFyUmYyeWEzc2xWVGdKQkdHRzVaUWpD?=
 =?utf-8?B?U2laUjRkbXFhUEZ5SHFrUEhubXFkeEh1QmUxdmtXVFJXMUdoUFhJN2FEeVYx?=
 =?utf-8?B?MlYwM0JyWTZWYmVIR3JHYytNd1JFWjhJeTc2TFhiL2Yya3YxczFmWkxNY3pH?=
 =?utf-8?B?MkpVTDBHODZHTThtcHpURlphNk5lVU9HZ3hzNWRsbVpXZjVVZU50aU1VK1Mx?=
 =?utf-8?B?ckR6Y3hjdWNrbitDVmM5YmZ4L2dubHBpTjNpZGlVRmZxRmxFMzM2NDJHSTZh?=
 =?utf-8?B?MFB4YjQ2a0VYWFRxazk3K2J3a01xNnRyQXhhZnlOb25aK2ZZYlhpSlZZMWEy?=
 =?utf-8?B?ajI5d1VrUFVjenUrcTQ2V1lqN3FKMjZCSlZBQnpUNnJodWZCc3ZhcTlWQnpW?=
 =?utf-8?B?aW1mUndzUDBLZ2tldVluaTVEMDZwTmxhRXZTbityYjQ0Ykl0TnptQ1RuTy9X?=
 =?utf-8?B?cVVtODRIOFlCRVAyTGdqRlFhZnRlRWNLSW41MjlrVWNVMVdaMnpFR0k3elF3?=
 =?utf-8?B?eGRheVExaHhaVWxVZ1FqU2tBd3ByVFRqOE5uWjlOYVVpM2plNHMwZFByTllN?=
 =?utf-8?B?SmFNQUlSR3BGZHVhbGVNTWRaTTFFWlhUU25Pam0yODhpakdkbWxpclk5QWcz?=
 =?utf-8?Q?XYJa5N2gLIncdp1FI1ls1A+e+OipGY=3D?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 13:04:16.5567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e81656-13e4-4744-a958-08dd540a9406
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8748
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

Implement the 32- and 64-bit x86 rte_prefetch<n>() functions and
rte_prefetch_non_temporal() using compiler builtins, rather than
inline assembly.

This change frees the compiler to do certain optimizations that
otherwise wouldn't be possible.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eal/x86/include/rte_prefetch.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/lib/eal/x86/include/rte_prefetch.h b/lib/eal/x86/include/rte_prefetch.h
index 34a609cc65..329b1a81f7 100644
--- a/lib/eal/x86/include/rte_prefetch.h
+++ b/lib/eal/x86/include/rte_prefetch.h
@@ -22,7 +22,11 @@ static inline void rte_prefetch0(const volatile void *p)
 #ifdef RTE_TOOLCHAIN_MSVC
 	_mm_prefetch((const char *)(uintptr_t)p, _MM_HINT_T0);
 #else
-	asm volatile ("prefetcht0 %[p]" : : [p] "m" (*(const volatile char *)p));
+	/* 0 indicates intention to read, 3 sets target cache level to L1. See
+	 * GCC docs where these integer constants are described in more detail:
+	 *  https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
+	 */
+	__builtin_prefetch((const void *)(uintptr_t)p, 0, 3);
 #endif
 }
 
@@ -31,7 +35,11 @@ static inline void rte_prefetch1(const volatile void *p)
 #ifdef RTE_TOOLCHAIN_MSVC
 	_mm_prefetch((const char *)(uintptr_t)p, _MM_HINT_T1);
 #else
-	asm volatile ("prefetcht1 %[p]" : : [p] "m" (*(const volatile char *)p));
+	/* 0 indicates intention to read, 2 sets target cache level to L2. See
+	 * GCC docs where these integer constants are described in more detail:
+	 *  https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
+	 */
+	__builtin_prefetch((const void *)(uintptr_t)p, 0, 2);
 #endif
 }
 
@@ -40,7 +48,11 @@ static inline void rte_prefetch2(const volatile void *p)
 #ifdef RTE_TOOLCHAIN_MSVC
 	_mm_prefetch((const char *)(uintptr_t)p, _MM_HINT_T2);
 #else
-	asm volatile ("prefetcht2 %[p]" : : [p] "m" (*(const volatile char *)p));
+	/* 0 indicates intention to read, 1 sets target cache level to L3. See
+	 * GCC docs where these integer constants are described in more detail:
+	 *  https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
+	 */
+	__builtin_prefetch((const void *)(uintptr_t)p, 0, 1);
 #endif
 }
 
@@ -49,7 +61,11 @@ static inline void rte_prefetch_non_temporal(const volatile void *p)
 #ifdef RTE_TOOLCHAIN_MSVC
 	_mm_prefetch((const char *)(uintptr_t)p, _MM_HINT_NTA);
 #else
-	asm volatile ("prefetchnta %[p]" : : [p] "m" (*(const volatile char *)p));
+	/* 0 indicates intention to read, 1 sets target cache level to L3. See
+	 * GCC docs where these integer constants are described in more detail:
+	 *  https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
+	 */
+	__builtin_prefetch((const void *)(uintptr_t)p, 0, 0);
 #endif
 }
 
-- 
2.43.0

