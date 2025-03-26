Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A0C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 13:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8810F402DF;
	Wed, 26 Mar 2025 14:14:53 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id DF8DF402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:14:51 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q9RiP4006605
 for <dev@dpdk.org>; Wed, 26 Mar 2025 06:14:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=Rofc3YtBV2TyYvR7NRV55nj
 1AbA4gi2nb8URBFtBHFY=; b=YYFfXt101JJvQvZjHF1TXc9QI58LdJDosgVTKeo
 mRfq5fph5Yu9WEkJakjJ8JcyGfIuMffjupStEPsfVe+OHglvpxDYMUoZWDw3Xr+4
 qMaRCu+Y783lZNlmQm/8bjrZPcwQ013/nE4noYVWxwe5o1am/icuOjhPkxi3oSfJ
 Km2t6mjwW/8P5vzZ96ynj7vsgnZuI5TJ3diwgGHzUJhAVFgr/qi8eq2dapb4Oheq
 tZ+IelG9Gi+zFOEe75KQpyVXpGgLiT+3dW65flAt1zv07oKzaVmEM3nrMSPrAsgP
 rO53Bi+WeMkaeak2oqzkcA1flPXh5VbrYr8zF8hSfN3qwAA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45meyk0enm-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 26 Mar 2025 06:14:50 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Mar 2025 06:14:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Mar 2025 06:14:50 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id CD4375B6932;
 Wed, 26 Mar 2025 06:14:48 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC 0/2] introduce event vector adapter
Date: Wed, 26 Mar 2025 18:44:34 +0530
Message-ID: <20250326131441.5965-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=G+wcE8k5 c=1 sm=1 tr=0 ts=67e3fdca cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=mt55rSQh51JoxOaaIAcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: CWOsZgzOlqgrp102nFmY4i1Ke1_B-rUX
X-Proofpoint-GUID: CWOsZgzOlqgrp102nFmY4i1Ke1_B-rUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

The event vector adapter supports offloading the creation of event vectors
by vectorizing objects (mbufs/ptrs/u64s).

An event vector adapter has the following working model:

         ┌──────────┐
         │  Vector  ├─┐
         │ adapter0 │ │
         └──────────┘ │
         ┌──────────┐ │   ┌──────────┐
         │  Vector  ├─┼──►│  Event   │
         │ adapter1 │ │   │  Queue0  │
         └──────────┘ │   └──────────┘
         ┌──────────┐ │
         │  Vector  ├─┘
         │ adapter2 │
         └──────────┘

         ┌──────────┐
         │  Vector  ├─┐
         │ adapter0 │ │   ┌──────────┐
         └──────────┘ ├──►│  Event   │
         ┌──────────┐ │   │  Queue1  │
         │  Vector  ├─┘   └──────────┘
         │ adapter1 │
         └──────────┘

 - A vector adapter can be seen as an extension to event queue. It helps in
   aggregating objects and generating a vector event which is enqueued to the
   event queue.

 - Multiple vector adapters can be created on an event queue, each with its
   own unique properties such as event properties, vector size, and timeout.
   Note: If the target event queue doesn't support RTE_EVENT_QUEUE_CFG_ALL_TYPES,
         then the vector adapter should use the same schedule type as the event
         queue.

 - Each vector adapter aggregates objects, generates a vector event and
   enqueues it to the event queue with the event properties mentioned in
   rte_event_vector_adapter_conf::ev.

 - After configuring the vector adapter, the Application needs to use the
   rte_event_vector_adapter_enqueue() function to enqueue objects i.e.,
   mbufs/ptrs/u64s to the vector adapter.
   On reaching the configured vector size or timeout, the vector adapter
   enqueues the event vector to the event queue.
   Note: Application should use the event_type and sub_event_type properly
         identifying the contents of vector event on dequeue.

 - If the vector adapter advertises the RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV
  capability, application can use the RTE_EVENT_VECTOR_ENQ_[S|E]OV flags
  to indicate the start and end of a vector event.
  * When RTE_EVENT_VECTOR_ENQ_SOV is set, the vector adapter will flush any
    aggregation in progress as a vector event and start aggregating a new
    vector event with the enqueued ptr.
  * When RTE_EVENT_VECTOR_ENQ_EOV is set, the vector adapter will add the
    current ptr enqueued to the aggregated event and enqueue the vector event
    to the event queue.
  * If both flags are set, the vector adapter will flush the current aggregation
    as a vector event and enqueue the current ptr as a single event to the event
    queue.

 - If the vector adapter reaches the configured vector size, it will enqueue
   the aggregated vector event to the event queue.

 - If the vector adapter reaches the configured vector timeout, it will flush
   the current aggregation as a vector event if the minimum vector size is
   reached, if not it will enqueue the objects as single events to the event
   queue.

 - If the vector adapter is unable to aggregate the objects into a vector event,
   it will enqueue the objects as single events to the event queue with the event
   properties mentioned in rte_event_vector_adapter_conf::ev_fallback.

 Before using the vector adapter, the application has to create and configure
 an event device and based on the event device capability it might require
 creating an additional event port.

 When the application creates the vector adapter using the
 ``rte_event_vector_adapter_create()`` function, the event device driver
 capabilities are checked. If an in-built port is absent, the application
 uses the default function to create a new event port.
 For finer control over event port creation, the application should use
 the ``rte_event_vector_adapter_create_ext()`` function.

 The application can enqueue one or more objects to the vector adapter using the
 ``rte_event_vector_adapter_enqueue()`` function and control the aggregation
 using the flags.

 Vector adapters report stats using the ``rte_event_vector_adapter_stats_get()``
 function and reset the stats using the ``rte_event_vector_adapter_stats_reset()``.

 The application can destroy the vector adapter using the
 ``rte_event_vector_adapter_destroy()`` function.

Pavan Nikhilesh (2):
  eventdev: introduce event vector adapter
  eventdev: add default software vector adapter

 config/rte_config.h                     |   1 +
 lib/eventdev/event_vector_adapter_pmd.h |  87 +++
 lib/eventdev/eventdev_pmd.h             |  38 ++
 lib/eventdev/meson.build                |   3 +
 lib/eventdev/rte_event_vector_adapter.c | 762 ++++++++++++++++++++++++
 lib/eventdev/rte_event_vector_adapter.h | 469 +++++++++++++++
 lib/eventdev/rte_eventdev.c             |  23 +
 lib/eventdev/rte_eventdev.h             |   8 +
 lib/eventdev/version.map                |  13 +
 9 files changed, 1404 insertions(+)
 create mode 100644 lib/eventdev/event_vector_adapter_pmd.h
 create mode 100644 lib/eventdev/rte_event_vector_adapter.c
 create mode 100644 lib/eventdev/rte_event_vector_adapter.h

--
2.43.0

