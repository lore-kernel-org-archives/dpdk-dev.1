Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0420C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C06D4060A;
	Sun, 29 Jun 2025 19:07:45 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
 by mails.dpdk.org (Postfix) with ESMTP id D27A740288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5zS6FIsN0pq95VEPHzZKx92rRkxTi51+AriRloqe69ByiTruMSYWW3DimRbEHifGiCFiQP7tjJCHZ2CydDP/y8nRjqTEJSnKJZOF2T6XjpCBhVO2DxUWDWCiRLN9BfyYt/3WBWhyE6zdsDHNN+pGr05MQF/NQfob8FjR79uFnzRfBV/X5cQQKL/xU2jfF/ZJ+SmPQgtN6OwL64zoNlmyQpCrJF+z1N7ypa3D8PjubooXz49owcuaHpxUWaFS9wGqaWQvoLxl0rB3i9Kupkuho/9CFCOQqIUsCLb6kYxiJ9NrOmoIVLJcSJAKV7PdHf7E/NNxMukAhaJ2cQtIpD3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PonTqdc6WZ5L8MBMTxbB/dvUriaVKWPUNIZ3zdOjTXs=;
 b=nxjY86B8Ttbnc1MACMsDzf7ItHJNgHqUiBrFV12HSCwt6NCGtbIP8yHEjwl0ladxCTYf/K3NuAoscLGmhIcheTzB/kBTCr1aqi8lb+MlPpakqcCYhVDXT3oqGP8VIgVnSm3AA1BPpLAKWlVMYQUSPueLydWm8GFZ+UJZvEGgmgcbEADaep+f3TdkjgwYGPR9Yvj+xg+cW+kAUNnfSztzzE0SdWcupTjxXrtNliJfDtwWExZ6E9cu+buDNxIBYDWtN8wGJWLVdX1dfZSgLhfeWVv6eMn71L+cv0hQ5GSgSBh/sjQvUo5YbiNnwePlO8ywBUI8t+En/3VbkgXL7etJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PonTqdc6WZ5L8MBMTxbB/dvUriaVKWPUNIZ3zdOjTXs=;
 b=bkZ9tD4+iqXhm94n1KuCwcYpJR9btfnbTEdS8WAs2uJm6Pjv8SIavYmuDlVp5TLkOAh1fq5uOHpkGsgz2Tb60HdowvKXNBQK2nvOCFUmodfhtycspyH9N4/+NbHnuMCH2AIPOY37GifmAZc+csSt3iaV9jlexfVNDDhxyWFvSHuTrd4wxHcZFtfJF1+4eEcfT/vPrhpbQUxUFecu9obL5s0jcoGdC/xNWfKcuejFmCjaMEYGZyNRpAMGC537up5luwKMHKIsZRgbdmtQ0kjFSkhJ3zNz4w7MAqYvEuLqwLdYhqDxqqx/7OSfK9fkS4qY1Kal1rs+ocoVCAGJuotyOA==
Received: from DU7PR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::28) by DU4PR07MB10418.eurprd07.prod.outlook.com
 (2603:10a6:10:5ee::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Sun, 29 Jun
 2025 17:07:33 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::33) by DU7PR01CA0044.outlook.office365.com
 (2603:10a6:10:50e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Sun,
 29 Jun 2025 17:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:33 +0000
Received: from seliicinfr00049.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 29 Jun 2025 19:07:32 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00049.seli.gic.ericsson.se (Postfix) with ESMTP id
 DC0E638007A; Sun, 29 Jun 2025 19:07:32 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "Maria
 Lingemark" <maria.lingemark@ericsson.com>, Luka Jankovic
 <luka.jankovic@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: [RFC 1/4] eventdev: add support for credit preallocation
Date: Sun, 29 Jun 2025 18:52:11 +0200
Message-ID: <20250629165214.3468-2-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
References: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D00:EE_|DU4PR07MB10418:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d03928b-3501-4278-7a26-08ddb72f7085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHVLNGZ2MGFxelJlbldWOGxNSWpLZ1pXM0hZSVFlYy9zdmJLeWZ6U3BQWnlK?=
 =?utf-8?B?b2dTekNuU1JUSHRWdFZzeDBRSXVNNzAwZGV1SDBoNklobHA4dSttbXFMVGxy?=
 =?utf-8?B?ZThrMXM5SjltTzJ5N1k3SEQrUnBHREVVRFhJNU9PSCtvSzZnZlRVSjVDNFAy?=
 =?utf-8?B?T0d3MHZ1WDBpMThJditGaEN1cklsVmdZYVE5MGdteGE1QndyUll5QU4zemZR?=
 =?utf-8?B?ZHdTTGlTOG1veG5KRkpTTjFPOThiT2dNOEhwZzQ3YUFYaE4yeHRxRGJZZTJr?=
 =?utf-8?B?QnlwQlBCOEhXelJRNCsvY1p5M3Z3Y1dZY2xCYmRTUzRUT21WSlZFSlNhSU1T?=
 =?utf-8?B?YkkvZy9TTWxNZzFGKzdVSk1lWFVxenpST3pySTFYSlY1Qk9GbmdsR3hPZFo2?=
 =?utf-8?B?b1pWbGpQWkZSTUZIWUZsZWtTNW9SZU9rRCtaS0JXWThGVG4vZ3BGeWxHdDQ0?=
 =?utf-8?B?RldpTFJCaTFKNytNQ00vNFpTY2NmV3FyakhlTTVTMkphdFFWUCtIZ0hDU2Nk?=
 =?utf-8?B?VUxRSjZEdlFLSEw0aXZEN2xSdWFCWS9zUFc2UWpXeFMvM1dnbUJBUmJ6amxp?=
 =?utf-8?B?RDQycFJzZHpVSlJkQXA5aW1URFRiMWd5endiQUVwc2oxTTlGUW5iUk9yMU5n?=
 =?utf-8?B?Y3lKWjZzZnJJdDl1NS9CU0VMRURnV0xWbzdRYzczNWNLQXpuU281QkM4NGxi?=
 =?utf-8?B?cGhwV2N0TWp1M3FpSE9KUWZROHB5ejl0NkVmeWNiM1lCMlFjOW1nOGVPZ052?=
 =?utf-8?B?Zk1NdUg5T0hLZ2NodHJrSmM2OHg1S21UVVExdVdlRHV2R2piRyttODRsbXh6?=
 =?utf-8?B?UU5xSWliTm1pUXZIVnJVeFZjRW5EdmVPMEp6aExFNVVLQzZXT2lDcGlXQ1U4?=
 =?utf-8?B?aGpWRFB6cE8vM3pzR1ArTnhyQUZ5dXlLcUZuK1RscGswSUZidFNxMEFDVS9v?=
 =?utf-8?B?MGZXMDUvZTF2RTRiSTBFNklwVXZpRGVzS2JYY0dIVHl1bTEvT1lMd0RtSkZa?=
 =?utf-8?B?S241d3JkNmtZYXRreHRtS0pnYWhyVHFmaEppT0Y1dVBQVklqek8xWWNnMGVu?=
 =?utf-8?B?SWRmakV4VGVRdVFVNEI2RCszanN2MnNEOVhUQWUzeTR5TWdtd0NXUEtoTjln?=
 =?utf-8?B?c3JvcmFzcG5QVTBrZ1NkRXowS3NqS3o3dC9SSlBiaG5ucGJSYkZqaDFRZWRo?=
 =?utf-8?B?ZC9ENmJWTHBHSURqT3Fwdy92YTdkbzgrRkxRMTNreDVrYjh4U1RLRHFFSndS?=
 =?utf-8?B?VS8zc2RvL2FrTW9RMjgzS3BiU0tyVFoxYnRmdkdKR3NBSjIxNXh3cmhyTDM0?=
 =?utf-8?B?clpnZFNxc2hlbjhQQ2o5UVZ3ME1xbjdSaWVUMjJ6MCtCWDlrL28vN1djR1l5?=
 =?utf-8?B?ODVpNlNMWG1LYWZZZWVIaTVaT2xBV0V3eVVRektLVTV2c0R0QTdVaVJ5MTZT?=
 =?utf-8?B?Y3BFZy96MjRVVmcvZHg2SVBKekpmdnV5VWtnVmZrY0ZIdkdjZE5JR2NsbDRF?=
 =?utf-8?B?UllZc3RVUWN3VE5VVFhiWm80L1VoSklyc2owWWI4cTJTTW5KNHhDV1NEU2RM?=
 =?utf-8?B?SHQrZnpkQkhNNUMvM0xWaExjZDlZSExHTmk0Q3U2a25wVG1rNU9VQVNkVHg0?=
 =?utf-8?B?OFIwc0ljKzJBRXlLYml3d01kaDU1NWgvUGNCUm84MFBOR3ZocWpBWjY4Um1j?=
 =?utf-8?B?bVpMMnJNajFxYjVRK0MxbGgrZnNWNU5FTk54bGsyc2dJVWJNYlB1VXgwRFlv?=
 =?utf-8?B?ek54U00rRFI0T1QrcGNDY2VGeTdvK1dROWNKVTZneCtoN0JiREVNWktEa3JS?=
 =?utf-8?B?VDZqS0lOQ0J1L2NxckZ2a0xKSzFpQ2V1V0RuOWZ1VHFvLzJRc2ZPZGhMa0xJ?=
 =?utf-8?B?TWd1REFUb0JQVFVzVUR5bUNXT3dKRjVTN094VGl3L2NDWmpkYnQ2VnhidUpP?=
 =?utf-8?B?aEZxZXU1NVBuTXVWdklmWFZwblFOYnBUWVhzeUZ3VlZQdVZ2UEIxR2pEUXhn?=
 =?utf-8?B?T04rZ2pBR0FKSDhHZlpCK2lWUE9GV3hOejhFN29SMCt0Kzlzd1dZMzNCTzQ2?=
 =?utf-8?Q?MeYdqX?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:33.4884 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d03928b-3501-4278-7a26-08ddb72f7085
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10418
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

Optionally split the enqueue operation for new events into two steps;
allocating a "slot" for the event in the event device, and the actual
enqueue operation.

Pre-allocating credits reduces the risk of enqueue failures (i.e.,
backpressure) for new events. This is useful for applications
performing expensive or effectively irreversible processing before the
enqueue operation. In such a scenario, efficiency may be improved and
code complexity reduced, in case the application can know ahead of
time, with some certainty, that the enqueue operation will succeed.

A new function rte_event_credit_alloc() is used to allocate credits.
A new function rte_event_credit_free() may be used, in case the
application decides to not use allocated credits.

A new operation type RTE_EVENT_NEW_PREALLOCED is added, which is the
equivalent to RTE_EVENT_NEW, only the event consumes one of the
pre-allocated credits when the event is successfully enqueued.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eventdev/eventdev_pmd.h          |   4 +
 lib/eventdev/eventdev_private.c      |  23 +++++
 lib/eventdev/eventdev_trace_points.c |   8 ++
 lib/eventdev/rte_eventdev.h          | 135 +++++++++++++++++++++++++++
 lib/eventdev/rte_eventdev_core.h     |  10 ++
 lib/eventdev/rte_eventdev_trace_fp.h |  19 ++++
 6 files changed, 199 insertions(+)

diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index dda8ad82c9..84ec3ea555 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -172,6 +172,10 @@ struct __rte_cache_aligned rte_eventdev {
 	/**< Pointer to PMD dequeue burst function. */
 	event_maintain_t maintain;
 	/**< Pointer to PMD port maintenance function. */
+	event_credit_alloc_t credit_alloc;
+	/**< Pointer to PMD credit allocation function. */
+	event_credit_free_t credit_free;
+	/**< Pointer to PMD credit release function. */
 	event_tx_adapter_enqueue_t txa_enqueue_same_dest;
 	/**< Pointer to PMD eth Tx adapter burst enqueue function with
 	 * events destined to same Eth port & Tx queue.
diff --git a/lib/eventdev/eventdev_private.c b/lib/eventdev/eventdev_private.c
index dffd2c71d0..ec16125d83 100644
--- a/lib/eventdev/eventdev_private.c
+++ b/lib/eventdev/eventdev_private.c
@@ -34,6 +34,25 @@ dummy_event_maintain(__rte_unused void *port, __rte_unused int op)
 		"maintenance requested for unconfigured event device");
 }
 
+static int
+dummy_event_credit_alloc(__rte_unused void *port,
+			 __rte_unused unsigned int new_event_threshold,
+			 __rte_unused unsigned int num_credits)
+{
+	RTE_EDEV_LOG_ERR(
+		"credit allocation request for unconfigured event device");
+	return 0;
+}
+
+static int
+dummy_event_credit_free(__rte_unused void *port,
+			 __rte_unused unsigned int num_credits)
+{
+	RTE_EDEV_LOG_ERR(
+		"credit return request for unconfigured event device");
+	return 0;
+}
+
 static uint16_t
 dummy_event_tx_adapter_enqueue(__rte_unused void *port,
 			       __rte_unused struct rte_event ev[],
@@ -118,6 +137,8 @@ event_dev_fp_ops_reset(struct rte_event_fp_ops *fp_op)
 		.enqueue_forward_burst = dummy_event_enqueue_burst,
 		.dequeue_burst = dummy_event_dequeue_burst,
 		.maintain = dummy_event_maintain,
+		.credit_alloc = dummy_event_credit_alloc,
+		.credit_free = dummy_event_credit_free,
 		.txa_enqueue = dummy_event_tx_adapter_enqueue,
 		.txa_enqueue_same_dest = dummy_event_tx_adapter_enqueue_same_dest,
 		.ca_enqueue = dummy_event_crypto_adapter_enqueue,
@@ -141,6 +162,8 @@ event_dev_fp_ops_set(struct rte_event_fp_ops *fp_op,
 	fp_op->enqueue_forward_burst = dev->enqueue_forward_burst;
 	fp_op->dequeue_burst = dev->dequeue_burst;
 	fp_op->maintain = dev->maintain;
+	fp_op->credit_alloc = dev->credit_alloc;
+	fp_op->credit_free = dev->credit_free;
 	fp_op->txa_enqueue = dev->txa_enqueue;
 	fp_op->txa_enqueue_same_dest = dev->txa_enqueue_same_dest;
 	fp_op->ca_enqueue = dev->ca_enqueue;
diff --git a/lib/eventdev/eventdev_trace_points.c b/lib/eventdev/eventdev_trace_points.c
index ade6723b7b..c563f5cab1 100644
--- a/lib/eventdev/eventdev_trace_points.c
+++ b/lib/eventdev/eventdev_trace_points.c
@@ -50,6 +50,14 @@ RTE_EXPORT_SYMBOL(__rte_eventdev_trace_maintain)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_maintain,
 	lib.eventdev.maintain)
 
+RTE_EXPORT_SYMBOL(__rte_eventdev_credit_alloc)
+RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_credit_alloc,
+	lib.eventdev.credit_alloc)
+
+RTE_EXPORT_SYMBOL(__rte_eventdev_credit_free)
+RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_credit_free,
+	lib.eventdev.credit_free)
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_eventdev_trace_port_profile_switch, 23.11)
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_port_profile_switch,
 	lib.eventdev.port.profile.switch)
diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 3c7fcbf0be..812ed2705c 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -504,6 +504,16 @@ struct rte_event;
  * @see rte_event_port_preschedule()
  */
 
+#define RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION (1ULL << 21)
+/**< Event device supports credit preallocation for new events.
+ *
+ * The event device supports preallocation credits, which in turn allows
+ * the use of @ref RTE_EVENT_OP_NEW_PREALLOCED.
+ *
+ * @see rte_event_credit_alloc()
+ * @see rte_event_credit_free()
+ */
+
 /* Event device priority levels */
 #define RTE_EVENT_DEV_PRIORITY_HIGHEST   0
 /**< Highest priority level for events and queues.
@@ -1621,6 +1631,10 @@ struct __rte_aligned(16) rte_event_vector {
  * i.e. one not previously dequeued, into the event device, to be scheduled
  * for processing.
  */
+#define RTE_EVENT_OP_NEW_PREALLOCED     3
+/**< The @ref rte_event.op field must be set to this operation type to inject a new event
+ * for which a credit has already been allocated with rte_event_credit_alloc().
+ */
 #define RTE_EVENT_OP_FORWARD            1
 /**< The application must set the @ref rte_event.op field to this operation type to return a
  * previously dequeued event to the event device to be scheduled for further processing.
@@ -2933,6 +2947,127 @@ rte_event_maintain(uint8_t dev_id, uint8_t port_id, int op)
 	return 0;
 }
 
+/**
+ * Preallocate credits for new events.
+ *
+ * Preallocate credits for use with @ref RTE_EVENT_OP_NEW_PREALLOCED
+ * events. One credit gives the right to enqueue one such event. Upon
+ * successfully enqueuing an @ref RTE_EVENT_OP_NEW_PREALLOCED type
+ * event, one credit is considered spent.
+ *
+ * The credits are tied to the event port from which it was allocated.
+ * Thus, credit allocation and the enqueue operation must happen on
+ * the same port.
+ *
+ * The use of preallocated credits reduces the risk of enqueue
+ * failures, but does not guarantee that such will not occur.
+ *
+ * Besides using up credits by enqueuing @ref RTE_EVENT_OP_NEW_PREALLOCAD
+ * events, the application may also return credits using
+ * rte_event_credit_free().
+ *
+ * rte_event_credit_alloc() may also be used to pick a different @c
+ * new_event_threshold than is configured on the event port.
+ *
+ * This function will only succeed for event devices which have the
+ * @ref RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION flag set.
+ *
+ * The application may not attempt to enqueue @ref RTE_EVENT_OP_NEW_PREALLOCED
+ * events if it does not possess any credits (for that event port).
+ *
+ * Since credits are allocated against a certain @c new_event_threshold,
+ * and the number of in-flight events may change quickly (i.e., with
+ * an incoming burst of packets), storing credits for long durations
+ * of time may impact desired backpressure behavior. Also, since a
+ * credit represent an in-flight event, allocated but unused credits
+ * reduces the number of actual in-flight events allowed.
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @param port_id
+ *   The identifier of the event port.
+ * @param new_event_threshold
+ *   The @c new_event_threshold to use for this allocation. If set to 0, the
+ *   event port's @c new_event_threshold will be used.
+ * @param num_credits
+ *   The number of credits the application wish to acquire.
+ * @return
+ *  - The number of credits allocated (<= @c num_credits).
+ *  - -EINVAL if *dev_id*,  *port_id*, or *op* is invalid.
+ *  - -ENOTSUP if event device does not support credit preallocation.
+ *
+ * @see RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION
+ */
+static inline int
+rte_event_credit_alloc(uint8_t dev_id, uint8_t port_id, unsigned int new_event_threshold,
+		       unsigned int num_credits)
+{
+	const struct rte_event_fp_ops *fp_ops;
+	void *port;
+
+	fp_ops = &rte_event_fp_ops[dev_id];
+	port = fp_ops->data[port_id];
+#ifdef RTE_LIBRTE_EVENTDEV_DEBUG
+	if (dev_id >= RTE_EVENT_MAX_DEVS ||
+	    port_id >= RTE_EVENT_MAX_PORTS_PER_DEV)
+		return -EINVAL;
+
+	if (port == NULL)
+		return -EINVAL;
+#endif
+	rte_eventdev_trace_credit_alloc(dev_id, port_id, new_event_threshold, num_credits);
+
+	if (unlikely(fp_ops->credit_alloc == NULL))
+		return -ENOTSUP;
+
+	return fp_ops->credit_alloc(port, new_event_threshold, num_credits);
+}
+
+/**
+ * Return preallocated credits for new events.
+ *
+ * Return unused credits allocated with rte_event_credit_alloc().
+ *
+ * This function will only succeed for event devices which have the
+ * @ref RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION flag set.
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @param port_id
+ *   The identifier of the event port.
+ * @param num_credits
+ *   The number of credits the application wish to return.
+ * @return
+ *  - 0 on success.
+ *  - -EINVAL if *dev_id*,  *port_id*, or *op* is invalid.
+ *  - -ENOTSUP if event device does not support credit preallocation.
+ *
+ * @see RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION
+ */
+static inline int
+rte_event_credit_free(uint8_t dev_id, uint8_t port_id, unsigned int num_credits)
+{
+	const struct rte_event_fp_ops *fp_ops;
+	void *port;
+
+	fp_ops = &rte_event_fp_ops[dev_id];
+	port = fp_ops->data[port_id];
+#ifdef RTE_LIBRTE_EVENTDEV_DEBUG
+	if (dev_id >= RTE_EVENT_MAX_DEVS ||
+	    port_id >= RTE_EVENT_MAX_PORTS_PER_DEV)
+		return -EINVAL;
+
+	if (port == NULL)
+		return -EINVAL;
+#endif
+	rte_eventdev_trace_credit_free(dev_id, port_id, num_credits);
+
+	if (unlikely(fp_ops->credit_free == NULL))
+		return -ENOTSUP;
+
+	return fp_ops->credit_free(port, num_credits);
+}
+
 /**
  * Change the active profile on an event port.
  *
diff --git a/lib/eventdev/rte_eventdev_core.h b/lib/eventdev/rte_eventdev_core.h
index 1818483044..57a3ff4b67 100644
--- a/lib/eventdev/rte_eventdev_core.h
+++ b/lib/eventdev/rte_eventdev_core.h
@@ -25,6 +25,12 @@ typedef uint16_t (*event_dequeue_burst_t)(void *port, struct rte_event ev[],
 typedef void (*event_maintain_t)(void *port, int op);
 /**< @internal Maintains a port */
 
+typedef int (*event_credit_alloc_t)(void *port, unsigned int new_event_threshold, unsigned int num_credits);
+/**< @internal Allocates credits for new events */
+
+typedef int (*event_credit_free_t)(void *port, unsigned int num_credits);
+/**< @internal Returns credits for new events */
+
 typedef uint16_t (*event_tx_adapter_enqueue_t)(void *port,
 					       struct rte_event ev[],
 					       uint16_t nb_events);
@@ -63,6 +69,10 @@ struct __rte_cache_aligned rte_event_fp_ops {
 	/**< PMD dequeue burst function. */
 	event_maintain_t maintain;
 	/**< PMD port maintenance function. */
+	event_credit_alloc_t credit_alloc;
+	/**< PMD credit pre-allocation function. */
+	event_credit_free_t credit_free;
+	/**< PMD credit return function. */
 	event_tx_adapter_enqueue_t txa_enqueue;
 	/**< PMD Tx adapter enqueue function. */
 	event_tx_adapter_enqueue_t txa_enqueue_same_dest;
diff --git a/lib/eventdev/rte_eventdev_trace_fp.h b/lib/eventdev/rte_eventdev_trace_fp.h
index 8b794d1362..9a4b4f3f77 100644
--- a/lib/eventdev/rte_eventdev_trace_fp.h
+++ b/lib/eventdev/rte_eventdev_trace_fp.h
@@ -46,6 +46,25 @@ RTE_TRACE_POINT_FP(
 	rte_trace_point_emit_int(op);
 )
 
+RTE_TRACE_POINT_FP(
+	rte_eventdev_trace_credit_alloc,
+	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint8_t port_id,
+		unsigned int new_event_threshold, unsigned int num_credits),
+	rte_trace_point_emit_u8(dev_id);
+	rte_trace_point_emit_u8(port_id);
+	rte_trace_point_emit_int(new_event_threshold);
+	rte_trace_point_emit_int(num_credits);
+)
+
+RTE_TRACE_POINT_FP(
+	rte_eventdev_trace_credit_free,
+	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint8_t port_id,
+		unsigned int num_credits),
+	rte_trace_point_emit_u8(dev_id);
+	rte_trace_point_emit_u8(port_id);
+	rte_trace_point_emit_int(num_credits);
+)
+
 RTE_TRACE_POINT_FP(
 	rte_eventdev_trace_port_profile_switch,
 	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint8_t port_id, uint8_t profile),
-- 
2.43.0

