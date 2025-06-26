Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163CBC7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:33:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5558C4021F;
	Thu, 26 Jun 2025 16:33:31 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
 by mails.dpdk.org (Postfix) with ESMTP id D2A9940156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:33:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz4xmu7tSCkoqeIkTY1r+GeCPQKrW7qQ6/aYArFIfutPm+lIhc12xU9u38BykObNn9PpNr7vspYepIcfo5509qbQq+vWjyPWdBNsF5FoBlBx/p26+zfqAjD5gihU0TFWjVDPjILGwxii1VEGU3tnBRGXCycqtw0JQ+kajm6TTBp/AydJkb48JvT91PrUAb/EQRKIyaZJZtJqh9JUiR67i4nauBgDpkajfPx4sLVYaze3KjzJvWsuYdqvOhfu2oDeOewaxm9fAYZH7y1HO9UXDZCoFhcyBPiceF2LQerXWMoij/q0S0/ViTeCQm74sLIw9uDN2Oz4c6mMM7KFVXnvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvwllsXT9alYc1HQ8a0HSR7lHl+JwrgdAEg16QQSPKI=;
 b=Wbm2xoZm1GleYNUningVkml0kWfoynLdA4PuFVdzJklSQl9MqAqEkb/4/p3DyNz8bjnAKBZ9vv10+jjyW+5slVqxDGeejUi1Uk55dtmN2E17k6iqT1a3M1VF9jdNbPYVOl4siZQSi1d8m+x3beGKFrbsYqHqMbxWWuloS9dWIeN12Ul0wRotkCC1DVcbJnxE1JIs8EcL+1Iqsj8O86X5Vt4GnM/vDY2XPryE+i5YTcOlR9cfpKPmqoGz7UReJ4VUNP2Ux0MOhWshNRWRk6uwVKX+ZDP39DRc+M5UhtBHdjg4C/2mkfdUgiSFMHUFhbI8rRBqjAezaximTtE3FEV0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvwllsXT9alYc1HQ8a0HSR7lHl+JwrgdAEg16QQSPKI=;
 b=YuIoglE8yCdqZSQsTj5m54IOA6WLeRKnlSNilbPFjMkXTjJ+ixbs5iGAprNK7LWlV0coFywvGS8Y3pSrgDpid8T3csEBjbD5nnTqVd1hZmihfqd9Eqvmuj+mvH40zttY29FDTik6ulC8SBMtny5zIV/SriEYwshPoH4aDT/HF/5CkAec/KbPC5UOFNcalI/JdKbhAeWtRDYlnwEFtYrdoVu3ntklkStJkfhpHrBHn3FAQyIEx6ld3wqwHLOabSJqG5YY2xuuwiN3PSWF0Epg8vv4OazbRsoEtRs5JSQR9FzgE/v2xn1oUx3bQ0w5kQ5sa7lH4o2XsPzTgKEXk4XJ/Q==
Received: from AM0PR02CA0172.eurprd02.prod.outlook.com (2603:10a6:20b:28e::9)
 by GVXPR07MB9892.eurprd07.prod.outlook.com (2603:10a6:150:11b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 14:33:28 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::64) by AM0PR02CA0172.outlook.office365.com
 (2603:10a6:20b:28e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 14:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 14:33:27 +0000
Received: from seliicinfr00050.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 id 15.2.1544.14; Thu, 26 Jun 2025 16:33:26 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00050.seli.gic.ericsson.se (Postfix) with ESMTP id
 95EE51C006B; Thu, 26 Jun 2025 16:33:26 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: Jerin Jacob <jerinj@marvell.com>
CC: <dev@dpdk.org>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <hofors@lysator.liu.se>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: [PATCH v2] eventdev: make flag types consistent with API
Date: Thu, 26 Jun 2025 16:18:44 +0200
Message-ID: <20250626141844.168970-1-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626135238.168921-1-mattias.ronnblom@ericsson.com>
References: <20250626135238.168921-1-mattias.ronnblom@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|GVXPR07MB9892:EE_
X-MS-Office365-Filtering-Correlation-Id: 8741b5b9-aaf1-414b-0647-08ddb4be6a5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVRTcW1lcEZ2RzVoQWNZeXY2QTdUbFFrVEZVOVB5bnZYU05qMnNLMzNmSHNr?=
 =?utf-8?B?TXovYmdkL1RrMHNGRzczZ0cxSFIxUlRTU3FvSjJ3TTBoL2x5SUh5aDdGaTFr?=
 =?utf-8?B?RW9KODFZbUdtQUhycEpvUzlnelp1VEhvaWJScisyOGwrT2ZueFZGMEFhS2Vy?=
 =?utf-8?B?RHRFaXA4alFHYnJ2a3ptRE5IMU5zSGFhaVJBNUZuVXloNEVEUi9FbWwyQlV4?=
 =?utf-8?B?TXI4elZqTmtrNVJ4WFp1SHdXN093dzF6ajFaVW9WNjgvQnI0YllkQXVzYWp2?=
 =?utf-8?B?ZWZwdFg4OWh4MXZHTE01UldlZTkxNmhWL1BGT3ZlSzh0dlQ1eUJCS0JkMXFr?=
 =?utf-8?B?allyemhRWmZuSTVObXFFWnFIYkluOWJsaXRMSjRWVG5TeUVGMWZhK04za1Fy?=
 =?utf-8?B?VVNzaFZmTXIvaWZaRnYwazF1VHI5aTA0Z043VENsQWtsdyt4eVdncEFMc1l1?=
 =?utf-8?B?NG5GdGxtMis2cTFuTEFFM0FCbzY0V0ZZUkk0dkRWQVpvTjZHUG0xb0NvaU91?=
 =?utf-8?B?Y0Q5a2RoV3VCNC9remFSWlFtMjllRE5Mbk1obGpQbndpMjVuV2JMMHFEUlFD?=
 =?utf-8?B?YjhuM2VYU2tEbFVtRWkydXVFaGxSNkJPWUJzSk0yc1ZWTUZQRUk4L2t1S0oy?=
 =?utf-8?B?SkhseVk1NkNaUkdDZjQ3bXl6V0FkajBPblBjdm5sOEhYY01MdTFHZUg2cTkr?=
 =?utf-8?B?NEI2QXMxNDVld0IvZG5WVFZNVTJuZHpBdUxTSUIrajNKcTF3MEEwbUNQdVdz?=
 =?utf-8?B?U1lGTmRCM0dYYVNiREdGMGpBeEtueHJzbXppZ3JnVUE3cy9Ocm9CWXBXdnlk?=
 =?utf-8?B?dXdyVmJ3SkFNU2JpdVRIVmxaS1lSazMvNG1HT1ptcnJZaldrOTdwZjlscHBV?=
 =?utf-8?B?NkljT3N2NXF3NzNwMGlJNVFDcUlCclViOGE0NXJqUnR1NHRxaTlOUUU4UjE1?=
 =?utf-8?B?WFlPdXQyQmhwcmVReGlOOXM4bkN0R05pODA5L1AwbUtETWQ4R0pNemp6Y2cr?=
 =?utf-8?B?Q0gwWmxJSlZ2clZjcE9PRkRpMXE5aWhlOUVwajVpenZIcVZpU3pjbFVCOWVm?=
 =?utf-8?B?OHhiMmpud1BIbHpsR1RycFE0ejBHdFZDdUhsamp2QjdMZ21QeFVDeTV3TEJL?=
 =?utf-8?B?bFZRaXUycVJ2UTcwRGNBVEN0em1pVUdqcHp4MkZHN2wwUUJzbmtCcFdtSzI1?=
 =?utf-8?B?ZkpJWjBqdzRMMUR4RGxoYWZEcFFZZWpidHFQREk5VWxkZVB2QmpTTnB2MGxl?=
 =?utf-8?B?d05XZU5MaDFZOXZkT3dtVElYN1hWV3BlaGpkZnBLSFJQTkllcms3a1FUM2RN?=
 =?utf-8?B?K2lPVEhBU3JHOTJhYVJvTTA3azAvL05LR1lDbGs4TjFkQSsxZlYzZVdGdnpY?=
 =?utf-8?B?WE5FTGtlMUxBRnFxc09Fb1RvOUZlZFZuMXlOeGRKWjNDR2s1TFUvb0E5ZnVY?=
 =?utf-8?B?T0ZCeGxYT2ExRGZhU1Juc1lPekVFUFBqMFlFZzNBUWphNWR3TzBzRWlNRlAr?=
 =?utf-8?B?KzNvNkR0aHpxVDQ5Ym1MN2hKRW82V2JWMVJ1emlLbTJWWUlDVWVNbktjOFhP?=
 =?utf-8?B?S1BHT3ZTK0grZXNVK2JPN01TL3ZOek1CUXNYK0gyaHBjakhoMzM3dUdKV1RL?=
 =?utf-8?B?MzZUazVKeHB3OGpGS1RBS25tV01xQ21aQlU0eERBVk56OXN5c0pqaVd5bGRY?=
 =?utf-8?B?WUdMTklSU25aaFIzMDdHTmo0dUZqM3RTMUxqWmxVVWJOWU1Jclg3eUFsTk14?=
 =?utf-8?B?dUxLekdlOHY0MWRhbUdXaWtDdXVHMHdUaVovN0U0eWpKWFVRZkc2cC9GdnRO?=
 =?utf-8?B?NDFuTXJJZENwMEdqWmhtWThFZ3JqTVI3amc1SzByUXI1enFNVmhMZnk1ekNE?=
 =?utf-8?B?NDJ0d0tMUk5URE9DeG1jbzNDVElSRkpNbFV3YzBqZGl6aTd6WVBDVWYvckZC?=
 =?utf-8?B?bzNhYnR3Wll3QnlDWUFSTEhCZW5xMkxTVmJpdTdCdG5xMmF3TnRsTWZzWHVj?=
 =?utf-8?B?NmkxM2dOblFJMUw5blM4dkp4VlJnaTU5WGZpaDFFUUZCVzdaV1ZvM2tXSCtF?=
 =?utf-8?Q?ncOKTb?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 14:33:27.7110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8741b5b9-aaf1-414b-0647-08ddb4be6a5c
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9892
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

--

v2:
 * Use RTE_BIT32() instead of open-coding the equivalent. (Jerin Jacob)
---
 lib/eventdev/rte_eventdev.h | 67 +++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 3c7fcbf0be..88c52a5520 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -237,8 +237,9 @@
  * \endcode
  */
 
-#include <rte_compat.h>
+#include <rte_bitops.h>
 #include <rte_common.h>
+#include <rte_compat.h>
 #include <rte_errno.h>
 #include <rte_mbuf_pool_ops.h>
 #include <rte_mempool.h>
@@ -249,7 +250,7 @@ struct rte_mbuf; /* we just use mbuf pointers; no need to include rte_mbuf.h */
 struct rte_event;
 
 /* Event device capability bitmap flags */
-#define RTE_EVENT_DEV_CAP_QUEUE_QOS           (1ULL << 0)
+#define RTE_EVENT_DEV_CAP_QUEUE_QOS           RTE_BIT32(0)
 /**< Event scheduling prioritization is based on the priority and weight
  * associated with each event queue.
  *
@@ -267,7 +268,7 @@ struct rte_event;
  *  @see rte_event_queue_setup()
  *  @see rte_event_queue_attr_set()
  */
-#define RTE_EVENT_DEV_CAP_EVENT_QOS           (1ULL << 1)
+#define RTE_EVENT_DEV_CAP_EVENT_QOS           RTE_BIT32(1)
 /**< Event scheduling prioritization is based on the priority associated with
  *  each event.
  *
@@ -281,7 +282,7 @@ struct rte_event;
 
  *  @see rte_event_enqueue_burst()
  */
-#define RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED   (1ULL << 2)
+#define RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED   RTE_BIT32(2)
 /**< Event device operates in distributed scheduling mode.
  *
  * In distributed scheduling mode, event scheduling happens in HW or
@@ -291,7 +292,7 @@ struct rte_event;
  *
  * @see rte_event_dev_service_id_get()
  */
-#define RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPES     (1ULL << 3)
+#define RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPES     RTE_BIT32(3)
 /**< Event device is capable of accepting enqueued events, of any type
  * advertised as supported by the device, to all destination queues.
  *
@@ -315,7 +316,7 @@ struct rte_event;
  * @see rte_event_queue_conf.schedule_type
  * @see rte_event_enqueue_burst()
  */
-#define RTE_EVENT_DEV_CAP_BURST_MODE          (1ULL << 4)
+#define RTE_EVENT_DEV_CAP_BURST_MODE          RTE_BIT32(4)
 /**< Event device is capable of operating in burst mode for enqueue(forward,
  * release) and dequeue operation.
  *
@@ -326,7 +327,7 @@ struct rte_event;
  * @see rte_event_dequeue_burst()
  * @see rte_event_enqueue_burst()
  */
-#define RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE    (1ULL << 5)
+#define RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE    RTE_BIT32(5)
 /**< Event device ports support disabling the implicit release feature, in
  * which the port will release all unreleased events in its dequeue operation.
  *
@@ -339,7 +340,7 @@ struct rte_event;
  * @see rte_event_enqueue_burst()
  */
 
-#define RTE_EVENT_DEV_CAP_NONSEQ_MODE         (1ULL << 6)
+#define RTE_EVENT_DEV_CAP_NONSEQ_MODE         RTE_BIT32(6)
 /**< Event device is capable of operating in non-sequential mode.
  *
  * The path of the event is not necessary to be sequential. Application can change
@@ -351,7 +352,7 @@ struct rte_event;
  * qid which is not the next in the sequence.
  */
 
-#define RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK   (1ULL << 7)
+#define RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK   RTE_BIT32(7)
 /**< Event device is capable of reconfiguring the queue/port link at runtime.
  *
  * If the flag is not set, the eventdev queue/port link is only can be
@@ -362,7 +363,7 @@ struct rte_event;
  * @see rte_event_port_unlink()
  */
 
-#define RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT (1ULL << 8)
+#define RTE_EVENT_DEV_CAP_MULTIPLE_QUEUE_PORT RTE_BIT32(8)
 /**< Event device is capable of setting up links between multiple queues and a single port.
  *
  * If the flag is not set, each port may only be linked to a single queue, and
@@ -372,7 +373,7 @@ struct rte_event;
  * @see rte_event_port_link()
  */
 
-#define RTE_EVENT_DEV_CAP_CARRY_FLOW_ID (1ULL << 9)
+#define RTE_EVENT_DEV_CAP_CARRY_FLOW_ID RTE_BIT32(9)
 /**< Event device preserves the flow ID from the enqueued event to the dequeued event.
  *
  * If this flag is not set,
@@ -381,7 +382,7 @@ struct rte_event;
  * @see rte_event_dequeue_burst()
  */
 
-#define RTE_EVENT_DEV_CAP_MAINTENANCE_FREE (1ULL << 10)
+#define RTE_EVENT_DEV_CAP_MAINTENANCE_FREE RTE_BIT32(10)
 /**< Event device *does not* require calls to rte_event_maintain().
  *
  * An event device that does not set this flag requires calls to
@@ -394,7 +395,7 @@ struct rte_event;
  * @see rte_event_maintain()
  */
 
-#define RTE_EVENT_DEV_CAP_RUNTIME_QUEUE_ATTR (1ULL << 11)
+#define RTE_EVENT_DEV_CAP_RUNTIME_QUEUE_ATTR RTE_BIT32(11)
 /**< Event device is capable of changing the queue attributes at runtime i.e
  * after rte_event_queue_setup() or rte_event_dev_start() call sequence.
  *
@@ -404,7 +405,7 @@ struct rte_event;
  * @see rte_event_queue_setup()
  */
 
-#define RTE_EVENT_DEV_CAP_PROFILE_LINK (1ULL << 12)
+#define RTE_EVENT_DEV_CAP_PROFILE_LINK RTE_BIT32(12)
 /**< Event device is capable of supporting multiple link profiles per event port.
  *
  * When set, the value of `rte_event_dev_info::max_profiles_per_port` is greater
@@ -418,7 +419,7 @@ struct rte_event;
  * @see RTE_EVENT_DEV_CAP_RUNTIME_PORT_LINK
  */
 
-#define RTE_EVENT_DEV_CAP_ATOMIC  (1ULL << 13)
+#define RTE_EVENT_DEV_CAP_ATOMIC  RTE_BIT32(13)
 /**< Event device is capable of atomic scheduling.
  * When this flag is set, the application can configure queues with scheduling type
  * atomic on this event device.
@@ -426,7 +427,7 @@ struct rte_event;
  * @see RTE_SCHED_TYPE_ATOMIC
  */
 
-#define RTE_EVENT_DEV_CAP_ORDERED  (1ULL << 14)
+#define RTE_EVENT_DEV_CAP_ORDERED  RTE_BIT32(14)
 /**< Event device is capable of ordered scheduling.
  * When this flag is set, the application can configure queues with scheduling type
  * ordered on this event device.
@@ -434,7 +435,7 @@ struct rte_event;
  * @see RTE_SCHED_TYPE_ORDERED
  */
 
-#define RTE_EVENT_DEV_CAP_PARALLEL  (1ULL << 15)
+#define RTE_EVENT_DEV_CAP_PARALLEL  RTE_BIT32(15)
 /**< Event device is capable of parallel scheduling.
  * When this flag is set, the application can configure queues with scheduling type
  * parallel on this event device.
@@ -442,7 +443,7 @@ struct rte_event;
  * @see RTE_SCHED_TYPE_PARALLEL
  */
 
-#define RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ  (1ULL << 16)
+#define RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ  RTE_BIT32(16)
 /**< Event device is capable of independent enqueue.
  * A new capability, RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ, will indicate that Eventdev
  * supports the enqueue in any order or specifically in a different order than the
@@ -461,7 +462,7 @@ struct rte_event;
  * only applies to ports that have enabled independent enqueue feature.
  */
 
-#define RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE (1ULL << 17)
+#define RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE RTE_BIT32(17)
 /**< Event device supports event pre-scheduling.
  *
  * When this capability is available, the application can enable event pre-scheduling on the event
@@ -473,7 +474,7 @@ struct rte_event;
  * @see rte_event_dev_configure()
  */
 
-#define RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE_ADAPTIVE (1ULL << 18)
+#define RTE_EVENT_DEV_CAP_EVENT_PRESCHEDULE_ADAPTIVE RTE_BIT32(18)
 /**< Event device supports adaptive event pre-scheduling.
  *
  * When this capability is available, the application can enable adaptive pre-scheduling
@@ -485,7 +486,7 @@ struct rte_event;
  * @see rte_event_dev_configure()
  */
 
-#define RTE_EVENT_DEV_CAP_PER_PORT_PRESCHEDULE (1ULL << 19)
+#define RTE_EVENT_DEV_CAP_PER_PORT_PRESCHEDULE RTE_BIT32(19)
 /**< Event device supports event pre-scheduling per event port.
  *
  * When this flag is set, the event device allows controlling the event
@@ -495,7 +496,7 @@ struct rte_event;
  * @see rte_event_port_preschedule_modify()
  */
 
-#define RTE_EVENT_DEV_CAP_PRESCHEDULE_EXPLICIT (1ULL << 20)
+#define RTE_EVENT_DEV_CAP_PRESCHEDULE_EXPLICIT RTE_BIT32(20)
 /**< Event device supports explicit pre-scheduling.
  *
  * When this flag is set, the application can issue pre-schedule request on
@@ -733,7 +734,7 @@ rte_event_dev_attr_get(uint8_t dev_id, uint32_t attr_id,
 
 
 /* Event device configuration bitmap flags */
-#define RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT (1ULL << 0)
+#define RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT RTE_BIT32(0)
 /**< Override the global *dequeue_timeout_ns* and use per dequeue timeout in ns.
  *  @see rte_event_dequeue_timeout_ticks(), rte_event_dequeue_burst()
  */
@@ -873,7 +874,7 @@ rte_event_dev_configure(uint8_t dev_id,
 /* Event queue specific APIs */
 
 /* Event queue configuration bitmap flags */
-#define RTE_EVENT_QUEUE_CFG_ALL_TYPES          (1ULL << 0)
+#define RTE_EVENT_QUEUE_CFG_ALL_TYPES          RTE_BIT32(0)
 /**< Allow events with schedule types ATOMIC, ORDERED, and PARALLEL to be enqueued to this queue.
  *
  * The scheduling type to be used is that specified in each individual event.
@@ -887,7 +888,7 @@ rte_event_dev_configure(uint8_t dev_id,
  * @see RTE_SCHED_TYPE_ORDERED, RTE_SCHED_TYPE_ATOMIC, RTE_SCHED_TYPE_PARALLEL
  * @see rte_event_enqueue_burst()
  */
-#define RTE_EVENT_QUEUE_CFG_SINGLE_LINK        (1ULL << 1)
+#define RTE_EVENT_QUEUE_CFG_SINGLE_LINK        RTE_BIT32(1)
 /**< This event queue links only to a single event port.
  *
  * No load-balancing of events is performed, as all events
@@ -1113,14 +1114,14 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 /* Event port specific APIs */
 
 /* Event port configuration bitmap flags */
-#define RTE_EVENT_PORT_CFG_DISABLE_IMPL_REL    (1ULL << 0)
+#define RTE_EVENT_PORT_CFG_DISABLE_IMPL_REL    RTE_BIT32(0)
 /**< Configure the port not to release outstanding events in
  * rte_event_dev_dequeue_burst(). If set, all events received through
  * the port must be explicitly released with RTE_EVENT_OP_RELEASE or
  * RTE_EVENT_OP_FORWARD. Must be unset if the device is not
  * RTE_EVENT_DEV_CAP_IMPLICIT_RELEASE_DISABLE capable.
  */
-#define RTE_EVENT_PORT_CFG_SINGLE_LINK         (1ULL << 1)
+#define RTE_EVENT_PORT_CFG_SINGLE_LINK         RTE_BIT32(1)
 /**< This event port links only to a single event queue.
  * The queue it links with should be similarly configured with the
  * @ref RTE_EVENT_QUEUE_CFG_SINGLE_LINK flag.
@@ -1128,7 +1129,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
  *  @see RTE_EVENT_QUEUE_CFG_SINGLE_LINK
  *  @see rte_event_port_setup(), rte_event_port_link()
  */
-#define RTE_EVENT_PORT_CFG_HINT_PRODUCER       (1ULL << 2)
+#define RTE_EVENT_PORT_CFG_HINT_PRODUCER       RTE_BIT32(2)
 /**< Hint that this event port will primarily enqueue events to the system.
  * A PMD can optimize its internal workings by assuming that this port is
  * primarily going to enqueue NEW events.
@@ -1138,7 +1139,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
  *
  *  @see rte_event_port_setup()
  */
-#define RTE_EVENT_PORT_CFG_HINT_CONSUMER       (1ULL << 3)
+#define RTE_EVENT_PORT_CFG_HINT_CONSUMER       RTE_BIT32(3)
 /**< Hint that this event port will primarily dequeue events from the system.
  * A PMD can optimize its internal workings by assuming that this port is
  * primarily going to consume events, and not enqueue NEW or FORWARD
@@ -1149,7 +1150,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
  *
  *  @see rte_event_port_setup()
  */
-#define RTE_EVENT_PORT_CFG_HINT_WORKER         (1ULL << 4)
+#define RTE_EVENT_PORT_CFG_HINT_WORKER         RTE_BIT32(4)
 /**< Hint that this event port will primarily pass existing events through.
  * A PMD can optimize its internal workings by assuming that this port is
  * primarily going to FORWARD events, and not enqueue NEW or RELEASE events
@@ -1160,7 +1161,7 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
  *
  *  @see rte_event_port_setup()
  */
-#define RTE_EVENT_PORT_CFG_INDEPENDENT_ENQ   (1ULL << 5)
+#define RTE_EVENT_PORT_CFG_INDEPENDENT_ENQ   RTE_BIT32(5)
 /**< Flag to enable independent enqueue. Must not be set if the device
  * is not RTE_EVENT_DEV_CAP_INDEPENDENT_ENQ capable. This feature
  * allows an application to enqueue RTE_EVENT_OP_FORWARD or
@@ -1839,10 +1840,10 @@ int
 rte_event_eth_rx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 				uint32_t *caps);
 
-#define RTE_EVENT_TIMER_ADAPTER_CAP_INTERNAL_PORT (1ULL << 0)
+#define RTE_EVENT_TIMER_ADAPTER_CAP_INTERNAL_PORT RTE_BIT32(0)
 /**< This flag is set when the timer mechanism is in HW. */
 
-#define RTE_EVENT_TIMER_ADAPTER_CAP_PERIODIC      (1ULL << 1)
+#define RTE_EVENT_TIMER_ADAPTER_CAP_PERIODIC      RTE_BIT32(1)
 /**< This flag is set if periodic mode is supported. */
 
 /**
-- 
2.43.0

