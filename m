Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51001C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:07:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99418402F1;
	Sun, 29 Jun 2025 19:07:42 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012042.outbound.protection.outlook.com [52.101.71.42])
 by mails.dpdk.org (Postfix) with ESMTP id E2763402D2
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YU4/pN/4mrgHQTjVSHnAHg1CHA/BnyMNixD1QVOoVc9n99/wPE7UVDql69nlgF7cOzbW5OlYWt9pRJqiVwDAjbJD74LauRT16uxvL3udyAcNgOjvCKvxFrQV6fE+Q3JLeSyP3GK9elN5maqg2c0vqNUHLO4cnIPqa5/wbbaQ5nsMTkKUvrqPwF50YlLOpAelesJ2BDk5NJiPWP4dj2/icyZL9XCl8BEPkby3h98OLrAXYDxNo/C4xV6UHYijmWRzaQ6doIlzShvQMmY/1/J6L27z/EZjEfqa9t8oodS71H4eCzfs+CG/+I4I7dPPcPjuc1CGtSIFGgOL5oOvEj1LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqqSF6mWYlVk+g5w6xojeJFWmHJYbe4AWG+hgyo+ju4=;
 b=rykfTeaBzA5/zDzjoX57UqgrrWK3diatHsMm+p66pIF/RAOE2PrcAwpx59qIE2N8Pc01bK6FN4EfIqsns/sHbks1gplWJ9fLPq3NfmhVRKHLw6AUDrVLlmxYjomwV5yX1SaPHjD64AQyHRMu774SNy4Nwxu9mXNwOPQQ/+XBpmH1EvHbiWeHU4hWqpCSsMfXGYpx2V1P//ucrMC+HTMLsLfY6hD8gGngQz+W3IyZ0TVGVglJDdY7vG5tmLId2FKDqyDUhfHbh5Es8Sqb5+lbG6UVHCPgvmU/yvqubmRVnHVCGLZQA2byHU4GxJ/KYB2B66C7ghdPEb+TxydcZ9tsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqqSF6mWYlVk+g5w6xojeJFWmHJYbe4AWG+hgyo+ju4=;
 b=oaXUH4t0W0YluYG9hBLQy1VqLH3SqpBdnAYFw2L9Tnx3Gx9WLnWBriva5cSRMk399rUEg33Evl4SdftAeC68yko0JIANkP/z58iFTWsrsu7h0DXOGM6Txqkt6DXhR5BMXnJ+uD75KNBbM+Y8vMzSx/np4Sbc0Ur1rRG8E1jIdyr1H4PRCgWsHLsmc8Y2x8NfthK/afLCPp/aYXSqJepdpyhFwGFCUWy4nmqiHxbojnLJ+t351QKiFOnUw7wg8kdwSQfb4wsPQcWS8vpwRAvx6CChOZv/KaeqsZzn0FdJOxvAX3oqKHBHhZxJ4riFuTwRoZ4nec4bQdFgwA4ixmirVw==
Received: from DU7P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::13)
 by AS8PR07MB7142.eurprd07.prod.outlook.com (2603:10a6:20b:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Sun, 29 Jun
 2025 17:07:33 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::a3) by DU7P251CA0011.outlook.office365.com
 (2603:10a6:10:551::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Sun,
 29 Jun 2025 17:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 29 Jun 2025 17:07:33 +0000
Received: from seliicinfr00049.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 29 Jun 2025 19:07:33 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00049.seli.gic.ericsson.se (Postfix) with ESMTP id
 ED22338007D; Sun, 29 Jun 2025 19:07:32 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "Maria
 Lingemark" <maria.lingemark@ericsson.com>, Luka Jankovic
 <luka.jankovic@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: [RFC 2/4] event/dsw: add support for credit preallocation
Date: Sun, 29 Jun 2025 18:52:12 +0200
Message-ID: <20250629165214.3468-3-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
References: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|AS8PR07MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df273a6-6d78-4461-1076-08ddb72f708b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dS9PUmdlT1FNWnhCRUFLT1NjNWhPaVh6Ny9kN2p3WGY0b3h1Tk9hV1dXNlJL?=
 =?utf-8?B?ZDVzdytkVjBndmh3SU9ueEYvby84d3owSnIwY3pXdUtiMENRcEY3MHdtanNn?=
 =?utf-8?B?Ujl1ZE96WTVLK1FGQkdjYk85YWFLSUo1anI2emFyMyt0VjB0N1pldE1qOWlQ?=
 =?utf-8?B?eXpUdTF1TUZEM050bEdhME50d012U1g5YnJYa0hqMWtuY2VDTFNNNTdxSFZm?=
 =?utf-8?B?c2Njd2hBUU5DWXRDTE91Q2JOSmVLWFBpYTAvdHBkVXpLcjZETFo2KzdKb2pk?=
 =?utf-8?B?WnU0SGxCeWhGRmpvUU9RMjBaUWl2emxhNUZPUjY1VEJSTXZtKys2NTB3T2pL?=
 =?utf-8?B?VTJPZ3RuSVZWRUZoNE95ZWY3dW1RbGFBQ0wrcEhRSjlnNy9TQlVtTlBrYnZ1?=
 =?utf-8?B?M1d1ODE3OERBZ3VaejBxZXVRK2hHRnZ5UlBBZGp1R1REenAwY0ozTjhZOXlU?=
 =?utf-8?B?ZDF3R2JUMTExTkNqZmdBWGpKOFlONmtJNWI0MFVXKzBVMHI4QVRubWYrTlhS?=
 =?utf-8?B?eDFNeFcvQ3NDa1FJdmw4MXpMeVRueFJYVEJjYVhzQjk4SzEzTFRORUthTUFp?=
 =?utf-8?B?S25YM09nVndSanRIeTR0cHRxK0ZGck41dDNjdHBBUmxVYmNqQkhrR0Vub0FC?=
 =?utf-8?B?RFZYUmp1MVE5b094TlJyUlRVVTlkU2RqTU1DMFk4LzNwT1hDc3JCdVA3WTVj?=
 =?utf-8?B?dmpwMlZhNHgvbml2OEpWVlJlc3BSR0dyT2thWWRVQTRxYnZNNFRDSTl3bTNz?=
 =?utf-8?B?U2J1UHY4ZEh3UVZkaXQvVUlPVlR4RkNPZ1lwdFBxVUEyaGkwSlNHZzFjUFFv?=
 =?utf-8?B?d1dZVHpCcWFHb09scG1NMTRDa1BRa2JJeGptM0tJOVRoVnNSRDY4Skg5ZEND?=
 =?utf-8?B?UHVXYkswbjJXa2JRcEdTbFBxcmxaV1BFREM3R3FwR2RpNU9YYXhySzRMRENQ?=
 =?utf-8?B?TDk1MGJqOXdvV3RFRDAyZ3orNDJFOC92U0VKQkNlUnJjS2h6MDU2akQxb1Uw?=
 =?utf-8?B?ZWh5SG1uSldyV2hMczNoQ1haYkZDZzdJNzBOOEJ4RW05cEFwdld5c3gxMWVL?=
 =?utf-8?B?M2lkaTJxWUVSZXRGSTkwQVRPcHg3cHRPZVpvSXZiQVE2RWtDUVRSLzk2TTVM?=
 =?utf-8?B?WVhIQVJLSDJLT2F3SCtheGt4YUhEdXAxUDZ3ckQrOVdlRlFaRU40bzBSbVZD?=
 =?utf-8?B?TVRRR0FXeFo4Qkk4dks5dTMyOVhQd09TSWMxaFo0cUNKYXRNcEtlUnhqVUlw?=
 =?utf-8?B?RWNIaGVPZ25raWhWOEVaV3Y4UVY3bWZaOXhIeVBnL0MvT0F3VkxzRjFGR1E4?=
 =?utf-8?B?eXdIZXNETk5oMGdxajVnd3BnTkxTMUVlMkFtVEdhcm9qVkdmRnYvVlNGTlE3?=
 =?utf-8?B?NEtHNEpGUFNqcW8vWFFTR2VzVXYxSnBDb29pR2RXai85RFUrUlhqNlh2V3BO?=
 =?utf-8?B?UHA0d2FkbzR3bVlXZGYweHRmc2JzbXRRN0p3NHhCRGEvWDdQenpCUGczRHBJ?=
 =?utf-8?B?YVRVdmNCMGNmUWpjY3paUTFQNW04QjFPWVVPVlZYQnZiWU5lSHVDSTRiejlu?=
 =?utf-8?B?VlhMZXBrUVpjQmtFcWEvVS9LVDdsbkxPYjg5bjRsSXd2NmpxTFBLMjRYVDVZ?=
 =?utf-8?B?dG8wM3ZCNm5QSVpmVWNaUEhOYVJrQm52WVc3b3pnekhCMXljY0lKbEdTbEVy?=
 =?utf-8?B?WExyMlZUWXlDb2phOVJYN2F6cGtuTFZRdDlkY0hHVS9EcVFrdDdPdUNMTmd6?=
 =?utf-8?B?MjYzbGpLcjFYY0RScHdpVGJkTWxjcWVoTnNpZlpmalkxRDBLdFdnRi9qaCsr?=
 =?utf-8?B?dU9XcG9xd29WTnZOZFZIbk5hcFBNWk1FRFdiMXZhY3lSQm9PcFRMTnJ6bTRC?=
 =?utf-8?B?Qmt5Y3FmMXZ6R0ttZzNhWUxVdCtGVjBlM3NKcTl1cEc3VnN1TU5ML1NYMXZy?=
 =?utf-8?B?VFhWM1NJWTVDWDVSeDBYSHo2aXRtaGNMM3dEQWNXZmNUc1BBYXV3dWErdzdH?=
 =?utf-8?B?UDZJcjd6Z2I0NXZTcDg0cnhvd1dkKzZMbXNLcDY5elFSdFcrZWdVenFuSGMy?=
 =?utf-8?Q?e9ilbD?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:33.5263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df273a6-6d78-4461-1076-08ddb72f708b
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7142
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

Implement RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 drivers/event/dsw/dsw_evdev.c  |  5 ++-
 drivers/event/dsw/dsw_evdev.h  |  6 +++
 drivers/event/dsw/dsw_event.c  | 70 ++++++++++++++++++++++++++++------
 drivers/event/dsw/dsw_xstats.c |  3 ++
 4 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/drivers/event/dsw/dsw_evdev.c b/drivers/event/dsw/dsw_evdev.c
index e819412639..ecc1d947dd 100644
--- a/drivers/event/dsw/dsw_evdev.c
+++ b/drivers/event/dsw/dsw_evdev.c
@@ -228,7 +228,8 @@ dsw_info_get(struct rte_eventdev *dev __rte_unused,
 		RTE_EVENT_DEV_CAP_NONSEQ_MODE|
 		RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT|
 		RTE_EVENT_DEV_CAP_CARRY_FLOW_ID |
-		RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ
+		RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ |
+		RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION
 	};
 }
 
@@ -458,6 +459,8 @@ dsw_probe(struct rte_vdev_device *vdev)
 	dev->enqueue_forward_burst = dsw_event_enqueue_forward_burst;
 	dev->dequeue_burst = dsw_event_dequeue_burst;
 	dev->maintain = dsw_event_maintain;
+	dev->credit_alloc = dsw_event_credit_alloc;
+	dev->credit_free = dsw_event_credit_free;
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
diff --git a/drivers/event/dsw/dsw_evdev.h b/drivers/event/dsw/dsw_evdev.h
index d78c5f4f26..c026b0a135 100644
--- a/drivers/event/dsw/dsw_evdev.h
+++ b/drivers/event/dsw/dsw_evdev.h
@@ -208,6 +208,7 @@ struct __rte_cache_aligned dsw_port {
 
 	uint64_t enqueue_calls;
 	uint64_t new_enqueued;
+	uint64_t new_prealloced_enqueued;
 	uint64_t forward_enqueued;
 	uint64_t release_enqueued;
 	uint64_t queue_enqueued[DSW_MAX_QUEUES];
@@ -284,6 +285,11 @@ uint16_t dsw_event_dequeue_burst(void *port, struct rte_event *events,
 				 uint16_t num, uint64_t wait);
 void dsw_event_maintain(void *port, int op);
 
+int dsw_event_credit_alloc(void *port, unsigned int new_event_threshold,
+			   unsigned int num_credits);
+
+int dsw_event_credit_free(void *port, unsigned int num_credits);
+
 int dsw_xstats_get_names(const struct rte_eventdev *dev,
 			 enum rte_event_dev_xstats_mode mode,
 			 uint8_t queue_port_id,
diff --git a/drivers/event/dsw/dsw_event.c b/drivers/event/dsw/dsw_event.c
index 399d9f050e..09f353b324 100644
--- a/drivers/event/dsw/dsw_event.c
+++ b/drivers/event/dsw/dsw_event.c
@@ -93,9 +93,11 @@ dsw_port_return_credits(struct dsw_evdev *dsw, struct dsw_port *port,
 
 static void
 dsw_port_enqueue_stats(struct dsw_port *port, uint16_t num_new,
-		       uint16_t num_forward, uint16_t num_release)
+		       uint16_t num_new_prealloced, uint16_t num_forward,
+		       uint16_t num_release)
 {
 	port->new_enqueued += num_new;
+	port->new_prealloced_enqueued += num_new_prealloced;
 	port->forward_enqueued += num_forward;
 	port->release_enqueued += num_release;
 }
@@ -1322,12 +1324,26 @@ dsw_port_flush_out_buffers(struct dsw_evdev *dsw, struct dsw_port *source_port)
 		dsw_port_transmit_buffered(dsw, source_port, dest_port_id);
 }
 
+static inline bool
+dsw_should_backpressure(struct dsw_evdev *dsw, int32_t new_event_threshold)
+{
+	int32_t credits_on_loan;
+	bool over_threshold;
+
+	credits_on_loan = rte_atomic_load_explicit(&dsw->credits_on_loan,
+						   rte_memory_order_relaxed);
+
+	over_threshold = credits_on_loan > new_event_threshold;
+
+	return over_threshold;
+}
+
 static __rte_always_inline uint16_t
 dsw_event_enqueue_burst_generic(struct dsw_port *source_port,
 				const struct rte_event events[],
 				uint16_t events_len, bool op_types_known,
-				uint16_t num_new, uint16_t num_forward,
-				uint16_t num_release)
+				uint16_t num_new, uint16_t num_new_prealloced,
+				uint16_t num_forward, uint16_t num_release)
 {
 	struct dsw_evdev *dsw = source_port->dsw;
 	bool enough_credits;
@@ -1364,6 +1380,9 @@ dsw_event_enqueue_burst_generic(struct dsw_port *source_port,
 			case RTE_EVENT_OP_NEW:
 				num_new++;
 				break;
+			case RTE_EVENT_OP_NEW_PREALLOCED:
+				num_new_prealloced++;
+				break;
 			case RTE_EVENT_OP_FORWARD:
 				num_forward++;
 				break;
@@ -1379,9 +1398,7 @@ dsw_event_enqueue_burst_generic(struct dsw_port *source_port,
 	 * above the water mark.
 	 */
 	if (unlikely(num_new > 0 &&
-		     rte_atomic_load_explicit(&dsw->credits_on_loan,
-					      rte_memory_order_relaxed) >
-		     source_port->new_event_threshold))
+		     dsw_should_backpressure(dsw, source_port->new_event_threshold)))
 		return 0;
 
 	enough_credits = dsw_port_acquire_credits(dsw, source_port, num_new);
@@ -1397,7 +1414,8 @@ dsw_event_enqueue_burst_generic(struct dsw_port *source_port,
 	RTE_VERIFY(num_forward + num_release <= source_port->pending_releases);
 	source_port->pending_releases -= (num_forward + num_release);
 
-	dsw_port_enqueue_stats(source_port, num_new, num_forward, num_release);
+	dsw_port_enqueue_stats(source_port, num_new, num_new_prealloced,
+			       num_forward, num_release);
 
 	for (i = 0; i < events_len; i++) {
 		const struct rte_event *event = &events[i];
@@ -1409,9 +1427,9 @@ dsw_event_enqueue_burst_generic(struct dsw_port *source_port,
 	}
 
 	DSW_LOG_DP_PORT_LINE(DEBUG, source_port->id, "%d non-release events "
-			"accepted.", num_new + num_forward);
+			"accepted.", num_new + num_new_prealloced + num_forward);
 
-	return (num_new + num_forward + num_release);
+	return (num_new + num_new_prealloced + num_forward + num_release);
 }
 
 uint16_t
@@ -1424,7 +1442,7 @@ dsw_event_enqueue_burst(void *port, const struct rte_event events[],
 		events_len = source_port->enqueue_depth;
 
 	return dsw_event_enqueue_burst_generic(source_port, events,
-					       events_len, false, 0, 0, 0);
+					       events_len, false, 0, 0, 0, 0);
 }
 
 uint16_t
@@ -1438,7 +1456,7 @@ dsw_event_enqueue_new_burst(void *port, const struct rte_event events[],
 
 	return dsw_event_enqueue_burst_generic(source_port, events,
 					       events_len, true, events_len,
-					       0, 0);
+					       0, 0, 0);
 }
 
 uint16_t
@@ -1451,7 +1469,7 @@ dsw_event_enqueue_forward_burst(void *port, const struct rte_event events[],
 		events_len = source_port->enqueue_depth;
 
 	return dsw_event_enqueue_burst_generic(source_port, events,
-					       events_len, true, 0,
+					       events_len, true, 0, 0,
 					       events_len, 0);
 }
 
@@ -1604,3 +1622,31 @@ void dsw_event_maintain(void *port, int op)
 	if (op & RTE_EVENT_DEV_MAINT_OP_FLUSH)
 		dsw_port_flush_out_buffers(dsw, source_port);
 }
+
+int dsw_event_credit_alloc(void *port, unsigned int new_event_threshold,
+			   unsigned int num_credits)
+{
+	struct dsw_port *source_port = port;
+	struct dsw_evdev *dsw = source_port->dsw;
+	bool enough_credits;
+
+	if (dsw_should_backpressure(dsw, new_event_threshold))
+		return 0;
+
+	enough_credits = dsw_port_acquire_credits(dsw, source_port, num_credits);
+
+	if (!enough_credits)
+		return 0;
+
+	return num_credits;
+}
+
+int dsw_event_credit_free(void *port, unsigned int num_credits)
+{
+	struct dsw_port *source_port = port;
+	struct dsw_evdev *dsw = source_port->dsw;
+
+	dsw_port_return_credits(dsw, source_port, num_credits);
+
+	return 0;
+}
diff --git a/drivers/event/dsw/dsw_xstats.c b/drivers/event/dsw/dsw_xstats.c
index f61dfd80a8..2b58c26cb8 100644
--- a/drivers/event/dsw/dsw_xstats.c
+++ b/drivers/event/dsw/dsw_xstats.c
@@ -65,6 +65,7 @@ static struct dsw_xstat_dev dsw_dev_xstats[] = {
 	}
 
 DSW_GEN_PORT_ACCESS_FN(new_enqueued)
+DSW_GEN_PORT_ACCESS_FN(new_prealloced_enqueued)
 DSW_GEN_PORT_ACCESS_FN(forward_enqueued)
 DSW_GEN_PORT_ACCESS_FN(release_enqueued)
 
@@ -136,6 +137,8 @@ DSW_GEN_PORT_ACCESS_FN(last_bg)
 static struct dsw_xstats_port dsw_port_xstats[] = {
 	{ "port_%u_new_enqueued", dsw_xstats_port_get_new_enqueued,
 	  false },
+	{ "port_%u_new_prealloced_enqueued",
+	  dsw_xstats_port_get_new_prealloced_enqueued, false },
 	{ "port_%u_forward_enqueued", dsw_xstats_port_get_forward_enqueued,
 	  false },
 	{ "port_%u_release_enqueued", dsw_xstats_port_get_release_enqueued,
-- 
2.43.0

