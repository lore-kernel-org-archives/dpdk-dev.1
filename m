Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67859C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78F5E402E1;
	Sun, 29 Jun 2025 19:07:36 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
 by mails.dpdk.org (Postfix) with ESMTP id D956C40288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NILmzZodajjb2Udz2ALv3wRRWGOaPhL8M1Ej7SJMOLgrmwc6o+hMxrOr4x3y06SljaC0PPRrQEb75bDb3hW0bsQmHO5qe7xdi6tnMQCcLOF9zM0vInpQsIDMAd61hNXbpKOOT27MRnx014WjE6eZ5NjRxBqkm58vSmJeW4cPr82GGMHGU1/ylNef3BIui8Cg1BSFRluMbA8vdeaYi4QEJ3jw0ihM75IPbaJ9SPmO3vRSYAIPSwrvbBdJ/DeG8L8C5n/OaCphs5gPidQd0gN7DcAasK7wB7mqhCGeeMRYUMqipsYt6vXzMstRMc71U4u4f3WhgSMbB2dmjwIg/QUrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63KVIN8tC8HJ2BtnYmHdNXVOYFTkBZDStzXid4wm94c=;
 b=SMA5/t3GLO8KaY8cvbBk9yH29GCagCpPfBEjkQzYNZwU/6jUShvLHi7TmEUvBMtlNvd4x26UYB1MM+aYSMn3ujGy8m4J5kTyXGT4Nf0UuXhJwQT23IihqIBqvBeSlHP0RHmaKekAcRcSMh+UBbU301nNK2gZb0c0vzwy2K0rR+hyRO4PJz8mWs+vueA7J6Nrq2SYQZqgIdWPgr/YnConNBnbL1VXahO5nLxyu28TcfCAGlUMswgVRGgM1hoFem9ZJVQMmrsGNEFeBqDmPp34dteQwP182UP6FLnFfHskeP5GO0SjnbFjZXishCzYojza1LPii21xEeasanCXpYhXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63KVIN8tC8HJ2BtnYmHdNXVOYFTkBZDStzXid4wm94c=;
 b=D7cCCw+Y63X6VI87wg4J/64sRWwrXZBRkB96TIc32B3ONzm54y7aWS4y/3YSNPj7W1VfDspd9uONXJBouV7RbPnfDIs2pxbsMszbcIb0ebmDTwXIHzhS3wUHN4vueZwyGUWKh2wmvL8UuiNN8ScGnRvobF4MvFvMkxFVGBOLedIjdJo2A6qawA2hFnN1cDxfwvTH9HTeoQ+1u6wk8p9HQIzvXwz4COESyxUx6b7ZIZ4992nxe+SgrJeljvCKZBJVyevXWFlwuCugAHsdr3oRP/fscGsxReAJb+Mx4Umav1nvwcYysVxCaYBh1gpwMNYk5fGiKrffCCYXYsUC4bvpSw==
Received: from DBBPR09CA0031.eurprd09.prod.outlook.com (2603:10a6:10:d4::19)
 by DB9PR07MB9103.eurprd07.prod.outlook.com (2603:10a6:10:3d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Sun, 29 Jun
 2025 17:07:33 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::cc) by DBBPR09CA0031.outlook.office365.com
 (2603:10a6:10:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.24 via Frontend Transport; Sun,
 29 Jun 2025 17:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 17:07:33 +0000
Received: from seliicinfr00049.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 29 Jun 2025 19:07:33 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00049.seli.gic.ericsson.se (Postfix) with ESMTP id
 0992338007F; Sun, 29 Jun 2025 19:07:33 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "Maria
 Lingemark" <maria.lingemark@ericsson.com>, Luka Jankovic
 <luka.jankovic@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: [RFC 3/4] eventdev: add enqueue optimized for prealloced events
Date: Sun, 29 Jun 2025 18:52:13 +0200
Message-ID: <20250629165214.3468-4-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
References: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|DB9PR07MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a165fa-8e6d-46e6-237c-08ddb72f7098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE5FTlBBY0tlMitPQlR0THVBTlZzRzl2WVd2UmhoOEwyK09hQ1hLMEtuYnhq?=
 =?utf-8?B?d01ZZzQ2ODM0NndkUjZiY2diaGQvMDhmSUFMdnpUMks3bGwvVEREQWhKcFRi?=
 =?utf-8?B?bjNVbFJ6c3lpTUM1VzNHSFdEcno4aHVEbWJsRHhKcHBla0dMZVp5R2lwbU8r?=
 =?utf-8?B?Tjl0U0tLakxFNk9IYlQrSUZvWUVOUDh0U0RaeEM2ZVRHNDM2SkMrcm5MSGZT?=
 =?utf-8?B?aE81WFpWMG1POEltUHREWktmbWQxQ0Z2aVBtREk3bitSZVlaOE1YTFZudEpO?=
 =?utf-8?B?QmpsRk00N3hEK05EbjE3Z29pMmVGRkxPTHhVZW9tVitnVXBsOFpPNnhhWnNs?=
 =?utf-8?B?ZVcvRXFzaDdLQVFBeWcwZm5yS0QxTFVMVkJ2WDVNRk1DV3IwTE40bzdNcVNT?=
 =?utf-8?B?WWQxdWllQUp5dkliWGtZNGpNUGJzR1l1NW1xQ29obHFTdGlVTDVBdFdyK1Mv?=
 =?utf-8?B?QlBpWlo3ZjhtNDR5VTNDQ2Q0akJtMjE4SVJZbDV6cVRQNUN4bjZzN1NTYzE1?=
 =?utf-8?B?eE9FcUZKQzdoa2ZEWXU1cDl4b2tsTVlhV3QxbHRaYmFhQUM4SEl4WnNQTzVT?=
 =?utf-8?B?a1FmMkp4YXN6eDkxVm5rQkFNUGE2V245bFpZbkVvMUdQdG5SMXpTNlhjM2ps?=
 =?utf-8?B?VytZdmZEWTdPdlllaWltalc2dnVYeVZyVU9abjUzaGZRb0VVdXQyNGcyRWRH?=
 =?utf-8?B?YTVjcy94bys2VVZ1elJYQlF0SUcrS2hYQVQwZGdTd0NqYm1RTXp0anEwZTla?=
 =?utf-8?B?SFBUdkZZZWhOWlpuK2JRMkw5cWl5TWp1YUhEY2JubUtMNy83dWp1WllkODlQ?=
 =?utf-8?B?ZmhDN3B6eU5MaVB1c3dtczdxMVNPYVFCT3lDd1h5Tlp2b09HS0hJMXJpcDgw?=
 =?utf-8?B?NFRaUVFISEFMNEk1MXVYNjlreUJrU0xXTElzU3hrejlrdjhHM3U3QWh5T0tl?=
 =?utf-8?B?SEc4SG9VUE9DTk9BZHBkdUtRd09BT2tzaTNVckVRUmx1Zm5pMEUyV3ZIbGYw?=
 =?utf-8?B?d0xEVnhwUkRJbDExWTJBR1NSWTJLSks0MXMyRVc4YVE2WmtLLzdJM2xJaGFu?=
 =?utf-8?B?UHQwdGZncUlDTjJVWWlqRG1YaGJFRFdPdmRFOW5Pc1J1Y21rWnlyUzYwc09J?=
 =?utf-8?B?R3hLYXFXSDVZWjlRcFVGM01xTWFtdXEvWTVla2tvY01GRWpRcGZnQ0d4eDRW?=
 =?utf-8?B?MDFIRnRaNmx6MTJqc1lIVWtTYjc3Vk8rMEtzaFFaZVpCK3RHTTVJd1RrL3Nu?=
 =?utf-8?B?bmhMS1d4TzFZREpJdWFudVNjbHR1UmdFV1pKOENVWlRVcExidVlEVnRLZmwy?=
 =?utf-8?B?eGpBaFBGU21xUEttNGlVdWFIbGtMTUNteWVXcmt0THNocU1sVTIxQkVRVUJi?=
 =?utf-8?B?enBXNW5HVkhVWHZOVzZuNE5sTEQzMURFcjdKV1JZQUY2b1pPUCtEd1Zua1Y5?=
 =?utf-8?B?eDcvQUpZRzRMem9EczQ3YUlsbjNiT1ZERjY1TzI5S3dOajJEcXRlNnFlU2RI?=
 =?utf-8?B?TXR2dFEra1JSVTFYYy8rVDFuN1ZTaDhGYk02bzdMczg2dkx2VTQra00zUUor?=
 =?utf-8?B?QmRCWmRGaXFqY3h0azcwdEhQSHFpRTJUaytiZHlhSjRaUjhBMlh5TXc3WHUy?=
 =?utf-8?B?QUJHRUFVaGZ0SkdmZFhaNEM3K1JGNGVTZXhXS1pLWU56c1pEL3lLRHp3U0hK?=
 =?utf-8?B?WWxuckpocTkwbVhzcFRxRnNLeXlWaFZWMlFNSC93YmljQ0psVExVSm5PNmU3?=
 =?utf-8?B?cEVlZGM3UGZwUmlBREx0VUJnbkJUZTc5TWhxRU9YajZ3TUxPVDlZaUIvTFhm?=
 =?utf-8?B?SStsZTRGREdOQUFUZGY1MCtSUjZqZEIrZVFYQWdWMjZ6TkhPQ2hycmwzZkJX?=
 =?utf-8?B?ck1GSDlkT0I4Mi9BQm1aQ0orMCtwTktoWEN3aGFqWFpEbU1vSkNjT2ZUaCt4?=
 =?utf-8?B?Q2tQOVMvc0xPMktTYmxmS3Fkc1pHTU1GWXp3VHJPR1F1VGFGUEp1S2d5ZEhq?=
 =?utf-8?B?WWphSlQ2T3B1N3E3b0NiVURkV1hrWnFDd0JZMkVEeFJwVlZBekozZmQwUTlQ?=
 =?utf-8?Q?QrrwZk?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:33.6112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a165fa-8e6d-46e6-237c-08ddb72f7098
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9103
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

Extend Eventdev API with an enqueue function for events of the
RTE_EVENT_OP_NEW_PREALLOCED operation type.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eventdev/eventdev_pmd.h      |  2 +
 lib/eventdev/eventdev_private.c  |  1 +
 lib/eventdev/rte_eventdev.h      | 72 ++++++++++++++++++++++++++++----
 lib/eventdev/rte_eventdev_core.h |  2 +
 4 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index 84ec3ea555..d636e9e7ac 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -166,6 +166,8 @@ struct __rte_cache_aligned rte_eventdev {
 	/**< Pointer to PMD enqueue burst function. */
 	event_enqueue_burst_t enqueue_new_burst;
 	/**< Pointer to PMD enqueue burst function(op new variant) */
+	event_enqueue_burst_t enqueue_new_prealloced_burst;
+	/**< Pointer to PMD enqueue burst function(op new prealloced variant) */
 	event_enqueue_burst_t enqueue_forward_burst;
 	/**< Pointer to PMD enqueue burst function(op forward variant) */
 	event_dequeue_burst_t dequeue_burst;
diff --git a/lib/eventdev/eventdev_private.c b/lib/eventdev/eventdev_private.c
index ec16125d83..d830ba8f3b 100644
--- a/lib/eventdev/eventdev_private.c
+++ b/lib/eventdev/eventdev_private.c
@@ -159,6 +159,7 @@ event_dev_fp_ops_set(struct rte_event_fp_ops *fp_op,
 {
 	fp_op->enqueue_burst = dev->enqueue_burst;
 	fp_op->enqueue_new_burst = dev->enqueue_new_burst;
+	fp_op->enqueue_new_prealloced_burst = dev->enqueue_new_prealloced_burst;
 	fp_op->enqueue_forward_burst = dev->enqueue_forward_burst;
 	fp_op->dequeue_burst = dev->dequeue_burst;
 	fp_op->maintain = dev->maintain;
diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 812ed2705c..fc71c54b3e 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -507,8 +507,8 @@ struct rte_event;
 #define RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION (1ULL << 21)
 /**< Event device supports credit preallocation for new events.
  *
- * The event device supports preallocation credits, which in turn allows
- * the use of @ref RTE_EVENT_OP_NEW_PREALLOCED.
+ * The event device supports preallocating credits, which in turn allows
+ * enqueueing events with operation type @ref RTE_EVENT_OP_NEW_PREALLOCED.
  *
  * @see rte_event_credit_alloc()
  * @see rte_event_credit_free()
@@ -2734,6 +2734,64 @@ rte_event_enqueue_new_burst(uint8_t dev_id, uint8_t port_id,
 					 fp_ops->enqueue_new_burst);
 }
 
+/**
+ * Enqueue a burst of events objects of operation type
+ * @ref RTE_EVENT_OP_NEW_PREALLOCED on an event device designated by its
+ * *dev_id* through the event port specified by *port_id*.
+ *
+ * Provides the same functionality as rte_event_enqueue_burst(),
+ * expect that application can use this API when the all objects in
+ * the burst contains the enqueue operation of the type
+ * @ref RTE_EVENT_OP_NEW_PREALLOCED. This specialized function can
+ * provide the additional hint to the PMD and optimize if possible.
+ *
+ * The rte_event_enqueue_new_prealloced_burst() result is undefined if
+ * the enqueue burst has event object of operation type !=
+ * @ref RTE_EVENT_OP_NEW_PREALLOCED.
+ *
+ * This function may only be called on event devices with the
+ * @ref RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION capability.
+ *
+ * @param dev_id
+ *   The identifier of the device.
+n * @param port_id
+ *   The identifier of the event port.
+ * @param ev
+ *   Points to an array of *nb_events* objects of type *rte_event* structure
+ *   which contain the event object enqueue operations to be processed.
+ * @param nb_events
+ *   The number of event objects to enqueue, typically number of
+ *   rte_event_port_attr_get(...RTE_EVENT_PORT_ATTR_ENQ_DEPTH...)
+ *   available for this port.
+ *
+ * @return
+ *   The number of event objects actually enqueued on the event device. The
+ *   return value can be less than the value of the *nb_events* parameter when
+ *   the event devices queue is full or if invalid parameters are specified in a
+ *   *rte_event*. If the return value is less than *nb_events*, the remaining
+ *   events at the end of ev[] are not consumed and the caller has to take care
+ *   of them, and rte_errno is set accordingly. Possible errno values include:
+ *   - EINVAL   The port ID is invalid, device ID is invalid, an event's queue
+ *              ID is invalid, or an event's sched type doesn't match the
+ *              capabilities of the destination queue.
+ *   - ENOSPC   The event port was backpressured and unable to enqueue
+ *              one or more events. This error code is only applicable to
+ *              closed systems.
+ * @see rte_event_port_attr_get(), RTE_EVENT_PORT_ATTR_ENQ_DEPTH
+ * @see rte_event_enqueue_burst()
+ */
+static inline uint16_t
+rte_event_enqueue_new_prealloced_burst(uint8_t dev_id, uint8_t port_id,
+				       const struct rte_event ev[],
+				       uint16_t nb_events)
+{
+	const struct rte_event_fp_ops *fp_ops;
+
+	fp_ops = &rte_event_fp_ops[dev_id];
+	return __rte_event_enqueue_burst(dev_id, port_id, ev, nb_events,
+					 fp_ops->enqueue_new_prealloced_burst);
+}
+
 /**
  * Enqueue a burst of events objects of operation type *RTE_EVENT_OP_FORWARD*
  * on an event device designated by its *dev_id* through the event port
@@ -2962,14 +3020,14 @@ rte_event_maintain(uint8_t dev_id, uint8_t port_id, int op)
  * The use of preallocated credits reduces the risk of enqueue
  * failures, but does not guarantee that such will not occur.
  *
- * Besides using up credits by enqueuing @ref RTE_EVENT_OP_NEW_PREALLOCAD
+ * Besides using up credits by enqueuing @ref RTE_EVENT_OP_NEW_PREALLOCED
  * events, the application may also return credits using
  * rte_event_credit_free().
  *
  * rte_event_credit_alloc() may also be used to pick a different @c
  * new_event_threshold than is configured on the event port.
  *
- * This function will only succeed for event devices which have the
+ * This function is only available on event devices which have the
  * @ref RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION flag set.
  *
  * The application may not attempt to enqueue @ref RTE_EVENT_OP_NEW_PREALLOCED
@@ -2993,7 +3051,7 @@ rte_event_maintain(uint8_t dev_id, uint8_t port_id, int op)
  *   The number of credits the application wish to acquire.
  * @return
  *  - The number of credits allocated (<= @c num_credits).
- *  - -EINVAL if *dev_id*,  *port_id*, or *op* is invalid.
+ *  - -EINVAL if *dev_id* or *port_id* is invalid.
  *  - -ENOTSUP if event device does not support credit preallocation.
  *
  * @see RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION
@@ -3028,7 +3086,7 @@ rte_event_credit_alloc(uint8_t dev_id, uint8_t port_id, unsigned int new_event_t
  *
  * Return unused credits allocated with rte_event_credit_alloc().
  *
- * This function will only succeed for event devices which have the
+ * This function is only available on event devices which have the
  * @ref RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION flag set.
  *
  * @param dev_id
@@ -3039,7 +3097,7 @@ rte_event_credit_alloc(uint8_t dev_id, uint8_t port_id, unsigned int new_event_t
  *   The number of credits the application wish to return.
  * @return
  *  - 0 on success.
- *  - -EINVAL if *dev_id*,  *port_id*, or *op* is invalid.
+ *  - -EINVAL if *dev_id* or *port_id* is invalid.
  *  - -ENOTSUP if event device does not support credit preallocation.
  *
  * @see RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION
diff --git a/lib/eventdev/rte_eventdev_core.h b/lib/eventdev/rte_eventdev_core.h
index 57a3ff4b67..89444e919e 100644
--- a/lib/eventdev/rte_eventdev_core.h
+++ b/lib/eventdev/rte_eventdev_core.h
@@ -63,6 +63,8 @@ struct __rte_cache_aligned rte_event_fp_ops {
 	/**< PMD enqueue burst function. */
 	event_enqueue_burst_t enqueue_new_burst;
 	/**< PMD enqueue burst new function. */
+	event_enqueue_burst_t enqueue_new_prealloced_burst;
+	/**< PMD enqueue burst new function. */
 	event_enqueue_burst_t enqueue_forward_burst;
 	/**< PMD enqueue burst fwd function. */
 	event_dequeue_burst_t dequeue_burst;
-- 
2.43.0

