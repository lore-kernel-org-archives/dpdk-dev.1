Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B70C7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:08:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3803340666;
	Sun, 29 Jun 2025 19:07:46 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013028.outbound.protection.outlook.com
 [40.107.162.28]) by mails.dpdk.org (Postfix) with ESMTP id E898C402E8
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:07:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOUPU+9Q/I0IPpjYso5qvIi39xF3W7jcAOnZE3AcvywLLIKOW5sfZmPsACi0QrR9Ujrup1W70eET2I0IBY/pYcmre9xwnf8A/n3CakKtGd3BB3tmxScKKKVjZpfq6s+rSGJznYtwMh29PqXYX+X0cSk/fpojuiVw3BiusFp57I/5nUqJYoxZZsmR5TWuOeixk73Xs1aHEQQWhIVPIHLauqOgErUzV1VSBkcg53CurCA6LozPh4UdnGdgnIBXinYehxswYkKxQHngAi5baLcGCoGrOPI0F9QamHB18QA0V8ScMV5qfzCLcwikNQn78GwRw+MoILdQq/Rbc925wztV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lWvz3QAXcL4wceJdbsK246QtcT/4J67TxPlG7UWNlQ=;
 b=UAX+KFCTQbIytz/AWec0dtrWy4tk1mi5TYuPwWAPpnz3e/RUNqPEGD1JYe5Dp1JlmFo0uxAV9KdzdXuQVq5WEx+aFNCIDQpeA2LdEJjtEMyVRqDRJzgDzi9gxrUEppW1ehYbFi6lW00riRBLSjTlbA8DqhjNv7LdXDGJDjCDAqmTNNKspZFSeqRKNCr2AR/m5EnJuz5nmuf7H5ZH5a8NVKdphCwk2kOWUyymlNcy3QR6hIpqUp49o0SyTO5K+GQAt2CTNcGYkt4mFGe41lo/VxgrpxyivWsPGz0kkkx8rKfbObNfPnGqEMd34YHgROUSiLoXIIkPgbZrTKR8bUEMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lWvz3QAXcL4wceJdbsK246QtcT/4J67TxPlG7UWNlQ=;
 b=K/2/gK96Jb6xik9e60anuR3oiLdpbrRjrkvIkFMmYjl4JYgSKcdLFzy7aqK4kA5lYGlETZjAdzgFJkR3A9QYiUstJo3cqXTimI53+t7W2mf3mlsP8aQHsWYpsCfbEI0b/iKlwvN7vgdwbAVwXFwEEHJEHmX7xF5rJR6rbj/1uvrB3fZXoRA4yXNj/1QrJzQtoVLqIK95SIpuuyK9v6kXtP4ILEEqD57wiI6JFHyoDoEZkRuc1ipY47A84LS5NyWD0Qe88GHx+LVFZ5GH249YrI/7DAw7PKBQ1V9bMV6SSMMNlNxaNSeN/8HOlpRCNN5yx/uMeNO3e/Ju+v8ORumkZA==
Received: from DBBPR09CA0048.eurprd09.prod.outlook.com (2603:10a6:10:d4::36)
 by OSKPR07MB10448.eurprd07.prod.outlook.com (2603:10a6:e10:9d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Sun, 29 Jun
 2025 17:07:33 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::7) by DBBPR09CA0048.outlook.office365.com
 (2603:10a6:10:d4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.28 via Frontend Transport; Sun,
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
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 id 15.2.1544.14; Sun, 29 Jun 2025 19:07:32 +0200
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00049.seli.gic.ericsson.se (Postfix) with ESMTP id
 CBEA1380070; Sun, 29 Jun 2025 19:07:32 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "Maria
 Lingemark" <maria.lingemark@ericsson.com>, Luka Jankovic
 <luka.jankovic@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, =?UTF-8?q?Mattias=20R=C3=B6nnblom?=
 <mattias.ronnblom@ericsson.com>
Subject: [RFC 0/4] Add support for event credit preallocation
Date: Sun, 29 Jun 2025 18:52:10 +0200
Message-ID: <20250629165214.3468-1-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|OSKPR07MB10448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8b3a60-d8eb-4072-386e-08ddb72f7079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3hwQzcrL3NXS2taUmt1ZzJXZkVPYWlpR3F3UElTL25leWJBQzNNT2NPS01J?=
 =?utf-8?B?UXVBbEozUU85RU83bDQ2VmRTa2RLQnBCSzBxT2N2SGRvNkxnSTN4TGxEN1Ay?=
 =?utf-8?B?NHA4eVo4WDNhM0gvTFU3cnEzZXY5TnhsYmtTMWNqajlrMWpmWWs0emdqbTB3?=
 =?utf-8?B?QmpwRGNuSSt5Y1N4ZnErcHhMeWJicnJRaVNUMUUvYm9TU2JPWmNYSCtDUUEw?=
 =?utf-8?B?Zk1oQ20vNTMzT3ViSXA1dWhzTi9XV3g5TWtRUnJ2eUlXM1VkSDYwSkMzc1FT?=
 =?utf-8?B?VFZUVWVnWnVJbW40Q2kvTFc5cXZhVDYxM1ZPRkpvTUYrdHIyeThYOUswNjlY?=
 =?utf-8?B?a3c0czN5SmxHWFA4WjFnMitNbnVieW9xOWQxSWxvdDJlc29jSmRNbUFKUUFN?=
 =?utf-8?B?L3ZzNnNaMnc5S1dWSWJMQjQ5UGhldWgwOUcyR3VYb3BuS3BtcVhkVVNaWkY4?=
 =?utf-8?B?Z2Z2RmsyY1dBVUxlVlg1UzNrSERmWHhkc1FXOFdySlJobXFsMEl5QVYvZlBM?=
 =?utf-8?B?MGpwY3BuZGJITzQzU2FGdFBLU2dRVmhRaHRQZ0MxcGo5REMxSTdzK3NLbmlS?=
 =?utf-8?B?RjllcTlua1ZDNThEUDJDZTQzc1Vnd1RkbDU2WkRPRDN3Sm9XRGh1d2c5YThp?=
 =?utf-8?B?d1lpSldML0U1c0RXMTZmT3pvb1BiNVNiRURJWGNSTEVRUFJtUXJpelRlYlJT?=
 =?utf-8?B?M0s5WWNYZ01ZZWtQQnlMVUtuYVMycVdGeDh5WGRVMWVLMUN5a2dBZVk3NVRV?=
 =?utf-8?B?Y3JSZkVmMVZwQzdHZlN1WmF6NzcycTgzaUVuYStqNDhxd29PUlpJS0ZKaXJK?=
 =?utf-8?B?RzF5bUFlT2Z4cHBoMUMybXYwSnNrVzZFTGlObnUvWmV1UmRBUW04UzRUbFpn?=
 =?utf-8?B?bSsxQmxsbmlRNGxxS2c1OU91T3M0bG9GeVJLVHNjRFdzOG9aaTA4cHNCcWZz?=
 =?utf-8?B?RjE5dmZkNVVZTUtkSDlWM0hnU2JITzlJaHcxN1l2WmlDNmNtckN5WWxBQmNh?=
 =?utf-8?B?dTVua2RLQWo0b25oOC9UQ3MyKzFEclBCOFNoVWNzdU1lUk0wdUJ0NHI1dzRs?=
 =?utf-8?B?UmU1a2xScTdqeEJqR2F6R2lPNXFES0c3ekZ3L2syQnBQNmhTTVBOaHJIc29X?=
 =?utf-8?B?bS93VjYrTit1RkFaaXJWSWlzQUVVOHFueFp3VnBTd1o1SGRBUWE4RlNCSGhY?=
 =?utf-8?B?a2MvK1JrZHZ3K0xSNVFQZElmNW5mTjNjK0UyUWpaU3BmdUhtVEtCRWU2WFJF?=
 =?utf-8?B?THVvd09oaW9QMHBmQTEzdDZodzJpeDNDeitrM3R2SkNDZnkycDNjSUZVQWc0?=
 =?utf-8?B?R2pPbFdzZDRVTXJWQndlOG9NOEVxM1VvYllRYjVPZ0RpNmtBRlI4bG0zT1Iy?=
 =?utf-8?B?bnNSMmR3MTlXYTE5bzZZdXNjV0FTK2lTTW1Dby81QzgvdHJaS2JYME5PbEZU?=
 =?utf-8?B?WDNSYmZVdEhqQ1QzNCtYSDExazkvQ25ZY0t2NHRxTS90WThxZW5QVzhkbld2?=
 =?utf-8?B?T0srMmNxZ0x1Sm5qMVNISllnbTlvTlYvK1Z3QWdOZTRPcWxHZWcwL0wwMTBE?=
 =?utf-8?B?Qy9UUGhJT2xYMFNEa2tvOWo5V0Q5UU9NejhYZUhHNWNLQkhSSjdPV0JhNHVx?=
 =?utf-8?B?Z093bTdpQ0VxZXZWclNmYVl1ajEwNURoN1NkL3A0dlBhbFBkNDFndUdTYnhT?=
 =?utf-8?B?QWIwV1lZUUg3TXdrb2ZCT2NCZGdTbUpXSWdkT1h6STkrVm11SzJTdmdXaXN3?=
 =?utf-8?B?SjI3QUhXUGN5YmloM2cvVFJucTlpeTQzOGwybDhHVXg4QWswMk9uMnNzQkpM?=
 =?utf-8?B?b2RXT2ZBTTJVYldCcTNQT3FVc0FNdFE2K0dXQXRpaThWMWsvdTFWT1hmVnZp?=
 =?utf-8?B?c0tjdFY0VWZsNXlvY1J2YXJqUGJvaXlySWJzdENsNFJUUWxJUVQxaFdyWmZm?=
 =?utf-8?B?alRLVWhPc1RHUjhidUk3aUN4V1NvbDk3aExzRy9SajhIamJNU1krblQvQWNi?=
 =?utf-8?B?OVlnV1RsZngrWUtBdytJdkFRVDFmYXBwS2szZWtvLzJ3ekVzYVduSTJGRUJO?=
 =?utf-8?Q?B1Rl41?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 17:07:33.4060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8b3a60-d8eb-4072-386e-08ddb72f7079
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10448
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

Events of type RTE_EVENT_OP_NEW are often generated as a result of
some stimuli from the world outside the event machine. Examples of
such input can be a timeout in an application-managed timer wheel, a
control plane message on a lockless ring, an incoming packet
triggering the release of buffered packets, or a descriptor arriving
on some hardware queue.

In non-event-triggered cases, the external-trigger-to-eventdev-event
mechanism serves the same role as various Eventdev adapters, but for
input that does not have native Eventdev support.

The actual RTE_EVENT_OP_NEW event enqueue is often preceded by a
processing. Such processing may be both expensive or effectively
irreversible. In addition, in case the enqueue is likely to fail,
there is not even a point in polling the external source for new
input.

In such a scenario, efficiency could potentially be improved and code
complexity reduced in case the application could know ahead of time,
with some certainty, that the enqueue operation will succeed.

Event devices have a mechanism that puts an upper bound to the number
of in-flight (buffered) events. In many cases (e.g., DLB, DSW, and SW)
there is a credit system putting an upper bound on the number of
in-flight events. A new event consumes a credit, which is returned
to the credit pool when the event is released. In the current
Eventdev API, all this happens "under the hood" and is not visible
to the application.

This patchset optionally splits the enqueue operation into two steps:
1) rte_event_credit_alloc() to allocate "slots" for the events, in the
   form of credits. One credit grants the application the right to
   enqueue one event of the type RTE_EVENT_OP_NEW_PREALLOCED.
2) The actual enqueue operation, with the rte_event.op set to
   RTE_EVENT_OP_NEW_PREALLOCED.

The new operation type RTE_EVENT_OP_NEW_PREALLOCED is identical to
RTE_EVENT_OP_NEW, with the only exception that credit allocation
(either conceptually or literally) has already been successfully
completed.

Whether or not a credit allocation will succeed depends on the
new_event_threshold of the request. In the current Eventdev API,
new_event_threshold is strictly a port-level configuration. Beyond
simply allocating a credit, this patchset also address flexibility in
terms of making the new_event_threshold a per-allocation property.

Control over new_event_threshold is very important to tune system
behavior at overload.

In the general case, failure to allocate a credit is only one reason
an enqueue operation may fail. API semantics-wise, the possession of a
credit does not guarantee that the subsequent enqueue operation will
succeed. Certain event device implementations may come with stronger
guarantees.

In case the application decides not to (or fails to) spend its credits
enqueuing RTE_EVENT_OP_NEW_PREALLOCED events, it may return them using
the new rte_event_credit_free() function.

For performance and API consistency reasons, a new preallocation-optimized
enqueue function rte_event_enqueue_prealloced_burst() is added.

To allow the application to query if the credit management and the new
enqueue function are available on a particular event device, a new
capability RTE_EVENT_DEV_CAP_CREDIT_PREALLOCATION is added.

Mattias Rönnblom (4):
  eventdev: add support for credit preallocation
  event/dsw: add support for credit preallocation
  eventdev: add enqueue optimized for prealloced events
  event/dsw: implement enqueue optimized for prealloced events

 drivers/event/dsw/dsw_evdev.c        |   6 +-
 drivers/event/dsw/dsw_evdev.h        |   9 ++
 drivers/event/dsw/dsw_event.c        |  86 ++++++++++--
 drivers/event/dsw/dsw_xstats.c       |   3 +
 lib/eventdev/eventdev_pmd.h          |   6 +
 lib/eventdev/eventdev_private.c      |  24 ++++
 lib/eventdev/eventdev_trace_points.c |   8 ++
 lib/eventdev/rte_eventdev.h          | 193 +++++++++++++++++++++++++++
 lib/eventdev/rte_eventdev_core.h     |  12 ++
 lib/eventdev/rte_eventdev_trace_fp.h |  19 +++
 10 files changed, 354 insertions(+), 12 deletions(-)

-- 
2.43.0

