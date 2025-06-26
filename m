Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69952C7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2DE940287;
	Thu, 26 Jun 2025 16:07:20 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
 by mails.dpdk.org (Postfix) with ESMTP id AB1EA40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:07:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPG2HmvCGi2cvzxLwrhMpZHw/V0IsiIX3aNpOrOJB83ILRk3nXKd0NrmPsLBEIvgLRca19lFmjfqvUqwKI9iqdYxO7sMMzkrlHhqKaA1OR5GFjYQMwkQRzGZWmHT6GX/6yomh+1dxWO6scN8qudeZ+68UrWu+++04oxLE1R2rx9CilZoIsSqAnIUrAKq0C0dINW1M1YV3Hqfh9Caj+v55SHsX+wzTlQanCFGexsdNeZmCf33gWD6RKUCX1AOTul9C3JNi5fDWip4JeFGHfOLifvtszPtpj/kuHPbX4RBZuF6Xm2+L3SMfW33HUPqOdZmQyp8testMDk0NYmUWoAEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCWtPiwedgn5cN9aae3kLmceodcHgdvQTwJiJ8t/IzE=;
 b=ynG4hdS3zsYF+O8q8pk0qGb5f1ilNyFEwt20j+XNUWo+4JZgrT91UsPi+C0OpjI5zPQYQ+xhUkfp9xN1ERU+APJ2PsYpXGJ9hfzDuEj44Asc9XS1r2uasp2jcvbnPe7ZLf0DRX9kHkVEKU643iuDDPZ7pOfzQL7lZJ28RkUAw6lKA5rRnqON9uq/qjf38ArUe74F3K6uAKIbkso0uVkb/WoB+9NEsTvyt8XNYqs33p5JCl8ZuYrk26w+HwqZ9CLfzhY81E2vnDsviWquP+iC9U5/bWQdH+8uLSz43Pe+Dhl68eaBF4gwSLFgYwBxwzQkZPMPEZaOiB0DF67g8eqv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCWtPiwedgn5cN9aae3kLmceodcHgdvQTwJiJ8t/IzE=;
 b=pomHtER4Gdt/5V+fNNk6OmmyAqMyBHmkXR6JBPQK7eIoimQtKCO/vRYs/XI8JSC51bQj5PYhlGSlDH6dAO8GhG0idfa/7UrwGyQjImnbDSMMx+pBJKhXfFBDcZ4JxIcuSezv0C697WMpWBqT8IASQRjDi7mWaEJKB+8dynbXQxIW9T9wyJQRUMeKr4PwoARFa3dxBeR16ijP+vOgzjnmkRlq9qYPcgXLWE2Tbm3HYvVHa2U/SeTloOZKAxdbayfFU+wQLPm1y4tsaMM1mgSAklcj/DkPMZbX6Lx3T8kMhPYLW4Lg5Dw56ASrCVPv3FJwQcSTn0t1q3dWkm8wOP339Q==
Received: from AS9PR06CA0292.eurprd06.prod.outlook.com (2603:10a6:20b:45a::23)
 by AM7PR07MB6232.eurprd07.prod.outlook.com (2603:10a6:20b:135::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Thu, 26 Jun
 2025 14:07:17 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:45a:cafe::22) by AS9PR06CA0292.outlook.office365.com
 (2603:10a6:20b:45a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 14:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 14:07:16 +0000
Received: from seliicinfr00050.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 id 15.2.1544.14; Thu, 26 Jun 2025 16:07:15 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00050.seli.gic.ericsson.se (Postfix) with ESMTP id
 C3C9F1C006B; Thu, 26 Jun 2025 16:07:15 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: Jerin Jacob <jerinj@marvell.com>
CC: <dev@dpdk.org>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <hofors@lysator.liu.se>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: [PATCH] eventdev: make flag types consistent with API
Date: Thu, 26 Jun 2025 15:52:38 +0200
Message-ID: <20250626135238.168921-1-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|AM7PR07MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: cc55d764-2679-46f9-eb11-08ddb4bac1bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3pVdGFteFRpR3dLTUtROWJ5NVlPa0tXSXZtMGtaNTJYOHZkeVJ5K2ZzNzBE?=
 =?utf-8?B?Tk9BNnhKUGhaRmRweGdVNldCOWtLcnlCaUR3bmYxS0xuM3Z2N3E4V2Uzc2dV?=
 =?utf-8?B?QUtlanBJNDREcWEzYzZVbXBDNHF4cTVxMjZlaXNYV21xTnVlMDdreHpVZWZz?=
 =?utf-8?B?UTc2M3FiNjZiY21yU1IrT0Q5VEE5dUloS0Y2bkk0MkpDeWQ5cno4d1l1bUN3?=
 =?utf-8?B?REZZZzQ4Z1IrME51T3RWYi9sU25vMGNVaHVUTlNKbG1NTndZUDMvL3JKaDBk?=
 =?utf-8?B?dkdVVFlFZm1MMzdhMU1kc3BTNGFEeUxuY1piaktWT3B4YlpwWnVlTHBYSXlD?=
 =?utf-8?B?RnM2UmF4RVgrdzZKVEZFTCtQaDRobzZzYnpxaWF4dWhXaVJSa0NiMURqMXFn?=
 =?utf-8?B?dGRBdlErTlRMamkwYXpZZTU3ZzM2eTZvZ09wVkh5eUg4aUF5MUJIWkdqVkdH?=
 =?utf-8?B?UkwxSnkrT1lTTnJkUHhycW00cnVYWnNKSkg5eHFnd3V6MS9tS21aQXFyV2k0?=
 =?utf-8?B?Mm1rRFl5R2Uzbm93RDhhK0ZYZGI1MExjQ2hiSzZQUVE2cFNuZVByZHQ0aW93?=
 =?utf-8?B?bjZIUlNBTDdnY01wc2IwYVV5ZmJFUWJZejVBWUp1MFIyRGpLZW5jVEhibkV4?=
 =?utf-8?B?Mzc5YVZiYlowSDJjSUtHMzhqZVFpWXpUWTBHZHhWODdTMzQzV0hNQzFlWXEw?=
 =?utf-8?B?NW9SRWZKUE4remt4elphd3JBSmlNMVlwMmkzUlBwQVluQ0RLNExyUkQxWjFu?=
 =?utf-8?B?dnFOdk1DZDNsSDdrdGhmYXJWUGloU25GWmlHeDRRMjZJWXFCcm5RQ2RwOEhG?=
 =?utf-8?B?eTRSYVJqM0Q0WTJDOWdBeDhiRktJaTV6UzlBZzhGODZvQjM2dzlSbFRVVUF4?=
 =?utf-8?B?aWZVd1U5VkhicU5BaDVSZi96OGpaQVdVMEgxR3Z5SnA4TGduVWp4NVM3akpO?=
 =?utf-8?B?cDBkdG1SRFZFRXJSdXdBbHBWZXRHS2pRaU1BSkJpNHVnNGFnZFZMRDI5Rzhm?=
 =?utf-8?B?SEtyTWU4TWJabzY0RnNUelhJUmpjbmp4T1laOVUwaGdTMTFVY3RLeHZrWGto?=
 =?utf-8?B?WitDRFRkWUhrUXBGVHNNMjFnZkhERnFKaXUyZFlxZGlqaVhOTEtyRnBxWnNp?=
 =?utf-8?B?NnJZZW9jaHE2TGptZ1NZT2hBRm84L3hOUnJKWHc4Z1JPMVI5YnFwK09VYi9O?=
 =?utf-8?B?VVBCQWpsVXpRdFBnTFcwUXFOV2dVYTNkbmQ0bDZRbk5lZGxJRkZmSGxWYkM3?=
 =?utf-8?B?bnJzVHArYUE0RlY0bms4ODgzYTE0cmF3eXN3Uk5uUW5uMjBoZW5MMG85cWd4?=
 =?utf-8?B?bzMxaXd4Umg3YVdydGgwSVE3Z0VDaGtLR0s0QTVWZC9PYzVIbjM2MmErOEth?=
 =?utf-8?B?YS9TeUMwQ2J1eWp3VXBLblBDSWhOVzNnVUNvOGZkWTIvd0JwUnd5eEZiSnlp?=
 =?utf-8?B?bEhZcGFIQXQrUFZOYWg2dnNXZ0tZblBYdXZET2M4ZkV0ZHgzS0Iybm9zM3F1?=
 =?utf-8?B?RXNEandBMjB4bFlEeFF1dFpIMFkwQVFzclhEc0lKZjdXZWt4ZWJraDE3WlVa?=
 =?utf-8?B?WmVQeFpqNXJkK2lWWlAxNjdFZEYvTVlvWkhMcWkwN1FTZnNFWit0TnNKdXEv?=
 =?utf-8?B?cFFRcWZFL1JPcmExdHNVVlkzT0JvQ2Rlbi8xL3JCcHVnbHRYK3d0LzM5TS9t?=
 =?utf-8?B?QytQV25WNE80YUczS2xPenpxR1NudlB3NUR2WnBOOTBybHpNVklqVUplcnRY?=
 =?utf-8?B?eWF1bkNGSUZuZ1hyMjN5ZEdRblY5UmNSSjVNNUxzL2xMYWVjL2Z3UmEwNzJU?=
 =?utf-8?B?QjNsRmNWdnVaOGlRRFVndUFrVW9JZkFxbkw4bndPcnkyTHdnR3l6OSs0NFhL?=
 =?utf-8?B?aGR2TWxZRm9McVN0eEgrK0p4VUM2amtLZks4TGVuUVpqUC9kc0Njc1d3WVJj?=
 =?utf-8?B?OGNJNytMMTY1aTVwUTBPR3VUZDByMU5rWmVoY3N2YVRId1AzbkJFb2ZzbW0y?=
 =?utf-8?B?UU1td2ZkUzI4clR1M3NnNnl4RU02MU01L1NTNFcwenlZeG4xbUNhLzJhaFRM?=
 =?utf-8?Q?qyk2m0?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 14:07:16.3320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc55d764-2679-46f9-eb11-08ddb4bac1bd
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6232
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

Make RTE_EVENT_DEV_CAP_* flags' type consistent with the
rte_event_dev_info.event_dev_cap's type.

Make RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT consistent with
rte_event_dev_config.event_dev_cfg.

Make RTE_EVENT_QUEUE_CFG_* consistent with
rte_event_queue_conf.event_queue_cfg.

Make RTE_EVENT_PORT_CFG_* consistent with
rte_event_port_conf.event_port_cfg.

Make RTE_EVENT_TIMER_ADAPTER_CAP_* consistent with the caps parameter
in rte_event_eth_rx_adapter_caps_get().

The flags were all unsigned long longs (64 bits), but the
event_dev_cap, event_dev_cfg, event_queue_cfg, and event_port_cfg
fields and the caps parameter are all uint32_t. This change makes the
flags uint32_ts.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 lib/eventdev/rte_eventdev.h | 64 ++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 3c7fcbf0be..9b44c24f0e 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -249,7 +249,7 @@ struct rte_mbuf; /* we just use mbuf pointers; no need to include rte_mbuf.h */
 struct rte_event;
 
 /* Event device capability bitmap flags */
-#define RTE_EVENT_DEV_CAP_QUEUE_QOS           (1ULL << 0)
+#define RTE_EVENT_DEV_CAP_QUEUE_QOS           (UINT32_C(1) << 0)
 /**< Event scheduling prioritization is based on the priority and weight
  * associated with each event queue.
  *
@@ -267,7 +267,7 @@ struct rte_event;
  *  @see rte_event_queue_setup()
  *  @see rte_event_queue_attr_set()
  */
-#define RTE_EVENT_DEV_CAP_EVENT_QOS           (1ULL << 1)
+#define RTE_EVENT_DEV_CAP_EVENT_QOS           (UINT32_C(1) << 1)
 /**< Event scheduling prioritization is based on the priority associated with
  *  each event.
  *
@@ -281,7 +281,7 @@ struct rte_event;
 
  *  @see rte_event_enqueue_burst()
  */
-#define RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED   (1ULL << 2)
+#define RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED   (UINT32_C(1) << 2)
 /**< Event device operates in distributed scheduling mode.
  *
  * In distributed scheduling mode, event scheduling happens in HW or
@@ -291,7 +291,7 @@ struct rte_event;
  *
  * @see rte_event_dev_service_id_get()
  */
-#define RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPES     (1ULL << 3)
+#define RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPES     (UINT32_C(1) << 3)
 /**< Event device is capable of accepting enqueued events, of any type
  * advertised as supported by the device, to all destination queues.
  *
@@ -315,7 +315,7 @@ struct rte_event;
  * @see rte_event_queue_conf.schedule_type
  * @see rte_event_enqueue_burst()
  */
-#define RTE_EVENT_DEV_CAP_BURST_MODE          (1ULL << 4)
+#define RTE_EVENT_DEV_CAP_BURST_MODE          (UINT32_C(1) << 4)
 /**< Event device is capable of operating in burst mode for enqueue(forward,
  * release) and dequeue operation.
  *
@@ -326,7 +326,7 @@ struct rte_event;
  * @see rte_event_dequeue_burst()
  * @see rte_event_enqueue_burst()
  */
-#define RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE    (1ULL << 5)
+#define RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE    (UINT32_C(1) << 5)
 /**< Event device ports support disabling the implicit release feature, in
  * which the port will release all unreleased events in its dequeue operation.
  *
@@ -339,7 +339,7 @@ struct rte_event;
  * @see rte_event_enqueue_burst()
  */
 
-#define RTE_EVENT_DEV_CAP_NONSEQ_MODE         (1ULL << 6)
+#define RTE_EVENT_DEV_CAP_NONSEQ_MODE         (UINT32_C(1) << 6)
 /**< Event device is capable of operating in non-sequential mode.
  *
  * The path of the event is not necessary to be sequential. Application can change
@@ -351,7 +351,7 @@ struct rte_event;
  * qid which is not the next in the sequence.
  */
 
-#define RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK   (1ULL << 7)
+#define RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK   (UINT32_C(1) << 7)
 /**< Event device is capable of reconfiguring the queue/port link at runtime.
  *
  * If the flag is not set, the eventdev queue/port link is only can be
@@ -362,7 +362,7 @@ struct rte_event;
  * @see rte_event_port_unlink()
  */
 
-#define RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT (1ULL << 8)
+#define RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT (UINT32_C(1) << 8)
 /**< Event device is capable of setting up links between multiple queues and a single port.
  *
  * If the flag is not set, each port may only be linked to a single queue, and
@@ -372,7 +372,7 @@ struct rte_event;
  * @see rte_event_port_link()
  */
 
-#define RTE_EVENT_DEV_CAP_CARRY_FLOW_ID (1ULL << 9)
+#define RTE_EVENT_DEV_CAP_CARRY_FLOW_ID (UINT32_C(1) << 9)
 /**< Event device preserves the flow ID from the enqueued event to the dequeued event.
  *
  * If this flag is not set,
@@ -381,7 +381,7 @@ struct rte_event;
  * @see rte_event_dequeue_burst()
  */
 
-#define RTE_EVENT_DEV_CAP_MAINTENANCE_FREE (1ULL << 10)
+#define RTE_EVENT_DEV_CAP_MAINTENANCE_FREE (UINT32_C(1) << 10)
 /**< Event device *does not* require calls to rte_event_maintain().
  *
  * An event device that does not set this flag requires calls to
@@ -394,7 +394,7 @@ struct rte_event;
  * @see rte_event_maintain()
  */
 
-#define RTE_EVENT_DEV_CAP_RUNTIME_QUEUE_ATTR (1ULL << 11)
+#define RTE_EVENT_DEV_CAP_RUNTIME_QUEUE_ATTR (UINT32_C(1) << 11)
 /**< Event device is capable of changing the queue attributes at runtime i.e
  * after rte_event_queue_setup() or rte_event_dev_start() call sequence.
  *
@@ -404,7 +404,7 @@ struct rte_event;
  * @see rte_event_queue_setup()
  */
 
-#define RTE_EVENT_DEV_CAP_PROFILE_LINK (1ULL << 12)
+#define RTE_EVENT_DEV_CAP_PROFILE_LINK (UINT32_C(1) << 12)
 /**< Event device is capable of supporting multiple link profiles per event port.
  *
  * When set, the value of `rte_event_dev_info::max_profiles_per_port` is greater
@@ -418,7 +418,7 @@ struct rte_event;
  * @see RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK
  */
 
-#define RTE_EVENT_DEV_CAP_ATOMIC  (1ULL << 13)
+#define RTE_EVENT_DEV_CAP_ATOMIC  (UINT32_C(1) << 13)
 /**< Event device is capable of atomic scheduling.
  * When this flag is set, the application can configure queues with scheduling type
  * atomic on this event device.
@@ -426,7 +426,7 @@ struct rte_event;
  * @see RTE_SCHED_TYPE_ATOMIC
  */
 
-#define RTE_EVENT_DEV_CAP_ORDERED  (1ULL << 14)
+#define RTE_EVENT_DEV_CAP_ORDERED  (UINT32_C(1) << 14)
 /**< Event device is capable of ordered scheduling.
  * When this flag is set, the application can configure queues with scheduling type
  * ordered on this event device.
@@ -434,7 +434,7 @@ struct rte_event;
  * @see RTE_SCHED_TYPE_ORDERED
  */
 
-#define RTE_EVENT_DEV_CAP_PARALLEL  (1ULL << 15)
+#define RTE_EVENT_DEV_CAP_PARALLEL  (UINT32_C(1) << 15)
 /**< Event device is capable of parallel scheduling.
  * When this flag is set, the application can configure queues with scheduling type
  * parallel on this event device.
@@ -442,7 +442,7 @@ struct rte_event;
  * @see RTE_SCHED_TYPE_PARALLEL
  */
 
-#define RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ  (1ULL << 16)
+#define RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ  (UINT32_C(1) << 16)
 /**< Event device is capable of independent enqueue.
  * A new capability, RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ, will indicate that Eventdev
  * supports the enqueue in any order or specifically in a different order than the
@@ -461,7 +461,7 @@ struct rte_event;
  * only applies to ports that have enabled independent enqueue feature.
  */
 
-#define RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE (1ULL << 17)
+#define RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE (UINT32_C(1) << 17)
 /**< Event device supports event pre-scheduling.
  *
  * When this capability is available, the application can enable event pre-scheduling on the event
@@ -473,7 +473,7 @@ struct rte_event;
  * @see rte_event_dev_configure()
  */
 
-#define RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE_ADAPTIVE (1ULL << 18)
+#define RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE_ADAPTIVE (UINT32_C(1) << 18)
 /**< Event device supports adaptive event pre-scheduling.
  *
  * When this capability is available, the application can enable adaptive pre-scheduling
@@ -485,7 +485,7 @@ struct rte_event;
  * @see rte_event_dev_configure()
  */
 
-#define RTE_EVENT_DEV_CAP_PER_PORT_PRESCHEDULE (1ULL << 19)
+#define RTE_EVENT_DEV_CAP_PER_PORT_PRESCHEDULE (UINT32_C(1) << 19)
 /**< Event device supports event pre-scheduling per event port.
  *
  * When this flag is set, the event device allows controlling the event
@@ -495,7 +495,7 @@ struct rte_event;
  * @see rte_event_port_preschedule_modify()
  */
 
-#define RTE_EVENT_DEV_CAP_PRESCHEDULE_EXPLICIT (1ULL << 20)
+#define RTE_EVENT_DEV_CAP_PRESCHEDULE_EXPLICIT (UINT32_C(1) << 20)
 /**< Event device supports explicit pre-scheduling.
  *
  * When this flag is set, the application can issue pre-schedule request on
@@ -733,7 +733,7 @@ rte_event_dev_attr_get(uint8_t dev_id, uint32_t attr_id,
 
 
 /* Event device configuration bitmap flags */
-#define RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT (1ULL << 0)
+#define RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT (UINT32_C(1) << 0)
 /**< Override the global *dequeue_timeout_ns* and use per dequeue timeout in ns.
  *  @see rte_event_dequeue_timeout_ticks(), rte_event_dequeue_burst()
  */
@@ -873,7 +873,7 @@ rte_event_dev_configure(uint8_t dev_id,
 /* Event queue specific APIs */
 
 /* Event queue configuration bitmap flags */
-#define RTE_EVENT_QUEUE_CFG_ALL_TYPES          (1ULL << 0)
+#define RTE_EVENT_QUEUE_CFG_ALL_TYPES          (UINT32_C(1) << 0)
 /**< Allow events with schedule types ATOMIC, ORDERED, and PARALLEL to be enqueued to this queue.
  *
  * The scheduling type to be used is that specified in each individual event.
@@ -887,7 +887,7 @@ rte_event_dev_configure(uint8_t dev_id,
  * @see RTE_SCHED_TYPE_ORDERED, RTE_SCHED_TYPE_ATOMIC, RTE_SCHED_TYPE_PARALLEL
  * @see rte_event_enqueue_burst()
  */
-#define RTE_EVENT_QUEUE_CFG_SINGLE_LINK        (1ULL << 1)
+#define RTE_EVENT_QUEUE_CFG_SINGLE_LINK        (UINT32_C(1) << 1)
 /**< This event queue links only to a single event port.
  *
  * No load-balancing of events is performed, as all events
@@ -1113,14 +1113,14 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 /* Event port specific APIs */
 
 /* Event port configuration bitmap flags */
-#define RTE_EVENT_PORT_CFG_DISABLE_IMPL_REL    (1ULL << 0)
+#define RTE_EVENT_PORT_CFG_DISABLE_IMPL_REL    (UINT32_C(1) << 0)
 /**< Configure the port not to release outstanding events in
  * rte_event_dev_dequeue_burst(). If set, all events received through
  * the port must be explicitly released with RTE_EVENT_OP_RELEASE or
  * RTE_EVENT_OP_FORWARD. Must be unset if the device is not
  * RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE capable.
  */
-#define RTE_EVENT_PORT_CFG_SINGLE_LINK         (1ULL << 1)
+#define RTE_EVENT_PORT_CFG_SINGLE_LINK         (UINT32_C(1) << 1)
 /**< This event port links only to a single event queue.
  * The queue it links with should be similarly configured with the
  * @ref RTE_EVENT_QUEUE_CFG_SINGLE_LINK flag.
@@ -1128,7 +1128,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
  *  @see RTE_EVENT_QUEUE_CFG_SINGLE_LINK
  *  @see rte_event_port_setup(), rte_event_port_link()
  */
-#define RTE_EVENT_PORT_CFG_HINT_PRODUCER       (1ULL << 2)
+#define RTE_EVENT_PORT_CFG_HINT_PRODUCER       (UINT32_C(1) << 2)
 /**< Hint that this event port will primarily enqueue events to the system.
  * A PMD can optimize its internal workings by assuming that this port is
  * primarily going to enqueue NEW events.
@@ -1138,7 +1138,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
  *
  *  @see rte_event_port_setup()
  */
-#define RTE_EVENT_PORT_CFG_HINT_CONSUMER       (1ULL << 3)
+#define RTE_EVENT_PORT_CFG_HINT_CONSUMER       (UINT32_C(1) << 3)
 /**< Hint that this event port will primarily dequeue events from the system.
  * A PMD can optimize its internal workings by assuming that this port is
  * primarily going to consume events, and not enqueue NEW or FORWARD
@@ -1149,7 +1149,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
  *
  *  @see rte_event_port_setup()
  */
-#define RTE_EVENT_PORT_CFG_HINT_WORKER         (1ULL << 4)
+#define RTE_EVENT_PORT_CFG_HINT_WORKER         (UINT32_C(1) << 4)
 /**< Hint that this event port will primarily pass existing events through.
  * A PMD can optimize its internal workings by assuming that this port is
  * primarily going to FORWARD events, and not enqueue NEW or RELEASE events
@@ -1160,7 +1160,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
  *
  *  @see rte_event_port_setup()
  */
-#define RTE_EVENT_PORT_CFG_INDEPENDENT_ENQ   (1ULL << 5)
+#define RTE_EVENT_PORT_CFG_INDEPENDENT_ENQ   (UINT32_C(1) << 5)
 /**< Flag to enable independent enqueue. Must not be set if the device
  * is not RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ capable. This feature
  * allows an application to enqueue RTE_EVENT_OP_FORWARD or
@@ -1839,10 +1839,10 @@ int
 rte_event_eth_rx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 				uint32_t *caps);
 
-#define RTE_EVENT_TIMER_ADAPTER_CAP_INTERNAL_PORT (1ULL << 0)
+#define RTE_EVENT_TIMER_ADAPTER_CAP_INTERNAL_PORT (UINT32_C(1) << 0)
 /**< This flag is set when the timer mechanism is in HW. */
 
-#define RTE_EVENT_TIMER_ADAPTER_CAP_PERIODIC      (1ULL << 1)
+#define RTE_EVENT_TIMER_ADAPTER_CAP_PERIODIC      (UINT32_C(1) << 1)
 /**< This flag is set if periodic mode is supported. */
 
 /**
-- 
2.43.0

