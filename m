Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8EBC5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 16:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0611C400D7;
	Fri, 30 May 2025 18:25:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2501140041
 for <dev@dpdk.org>; Fri, 30 May 2025 18:25:45 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UCa4Px013074;
 Fri, 30 May 2025 09:25:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 DaY20LpM736HWgI+XLvFwZo+J18GF9NgL5hXMinDOg=; b=ekLfUQaSZ1DzyLEQK
 LBkSsAft3IONncoyrgOc+USdDGoue7Q8GfZuI7Pq+g4QAyMtWvBMZCou3oCKO3+3
 Iy+lkG3tUyR5I+0gyhwrLSMSImY1zdUZrXaj7tqSZeJm21Dh5q/PJRJRvVSkdUKg
 A3Oq75aJ+y/wfRHfu0h+ZiUkvyMYE5s38JcTBVJivEsV6wn8MIdLdDSKil8IgWr1
 Ow7AWQlmBdXUcWTBNa3wmFADPQD0/KnR1QlqId9/LD/wgdebxpDwbwkfI/LFBTH1
 aKSrmmAifXoJ+CDR4qOE7pCzck+ioc8leznDbD8xUemyRijy5a64fVhu5uq7qq29
 QWLXw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46yctmrgw2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 May 2025 09:25:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 30 May 2025 09:25:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 30 May 2025 09:25:43 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.164.240])
 by maili.marvell.com (Postfix) with ESMTP id 74A7C5B6924;
 Fri, 30 May 2025 09:25:38 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, <pbhagavatula@marvell.com>,
 <abhinandan.gujjar@intel.com>, <amitprakashs@marvell.com>,
 <s.v.naga.harish.k@intel.com>, <sthotton@marvell.com>,
 <pravin.pathak@intel.com>, <hemant.agrawal@nxp.com>,
 <sachin.saxena@nxp.com>, <mattias.ronnblom@ericsson.com>,
 <liangma@liangbit.com>, <peter.mccarthy@intel.com>,
 <harry.van.haaren@intel.com>, <anatoly.burakov@intel.com>,
 <erik.g.carrillo@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3 0/3] introduce event vector adapter
Date: Fri, 30 May 2025 21:55:29 +0530
Message-ID: <20250530162532.52464-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250529222437.91818-1-pbhagavatula@marvell.com>
References: <20250529222437.91818-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lPjDTHLjNAVvbKquvpywmoyk1fFenExh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE0NSBTYWx0ZWRfX037JOYjaLVG6
 roVeCMo7YZIjUyOCUGHb3Q8qql1l3wis1DLrB+1eWxg1OHaUH+7XdRiTev9P6p/1DY+MlbUJyQO
 qdzF3JCdL5vcAYL8y1FmTDRW+DrD106AuV1JF3ajfVO4h7AaL9OW9d7/rClQSUJtsgwZ7j03cNz
 Mnq9zNO0+O42d41qZa3fhg27MeoYSsWGl/7vF1yrob5Pz7BFtfcFfT3eXnQGm9PVpFVGxPemakW
 naJYSFI6cmVigOPL9LIqf5AbOwFa1E4nVzTC+YCVOtD18MwiOlEqNGDkPnGz/eRsNJOp/e2R0yw
 bMm8Oi8lSgOFvJ6WLnDCxO5efM3W12ORCi58genSYlZ1C/cLk8h4fXXseMqjxuGXNJybZKiPPlq
 Ff5I7LdzsyI0cxNYr4d6UqZIjjDbZ5hAcyNGGll3xEnR12ysswjJtLyg6s8SNH0qVrZtq36t
X-Proofpoint-ORIG-GUID: lPjDTHLjNAVvbKquvpywmoyk1fFenExh
X-Authority-Analysis: v=2.4 cv=I95lRMgg c=1 sm=1 tr=0 ts=6839dc09 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=qB-M9MyR3BpZaL-EI3AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_07,2025-05-30_01,2025-03-28_01
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
    Enqueue│  Vector  ├─┐
       ───►│ adapter 0│ │
           └──────────┘ │
           ┌──────────┐ │   ┌──────────┐
    Enqueue│  Vector  ├─┼──►│  Event   │
       ───►│ adapter 1│ │   │  Queue 0 │
           └──────────┘ │   └──────────┘
           ┌──────────┐ │
    Enqueue│  Vector  ├─┘
       ───►│ adapter n│
           └──────────┘

 - A vector adapter can be seen as an extension to event queue. It helps in
   aggregating objects and generating a vector event which is enqueued to the
   event queue.

 - Multiple vector adapters can be created on an event queue, each with its
   own unique properties such as event properties, vector size, and timeout.
   Note: If the target event queue doesn't support RTE_EVENT_QUEUE_CFG_ALL_TYPES
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
    aggregation in progress and start aggregating a new vector event with
    the enqueued objects.
  * When RTE_EVENT_VECTOR_ENQ_EOV is set, the vector adapter will add the
    objects enqueued to in-progress aggregation and enqueue the vector event
    to the event queue, even if configured vector size or timeout is not
    reached.
  * If both flags are set, the vector adapter will flush any aggregation in
    progress and enqueue the objects as a new vector event to the event queue.

 - If the vector adapter reaches the configured vector size, it will enqueue
   the aggregated vector event to the event queue.

 - If the vector adapter reaches the configured vector timeout, it will flush
   the aggregated objects as a vector event if the minimum vector size is
   reached, if not it will enqueue the objects as single events with fallback
   event properties mentioned in rte_event_vector_adapter_conf::ev_fallback.

 - If the vector adapter is unable to aggregate the objects into a vector event,
   it will enqueue the objects as single events to the event queue with the
   event properties mentioned in rte_event_vector_adapter_conf::ev_fallback.

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
 function and reset the stats using the
``rte_event_vector_adapter_stats_reset()``.

 The application can destroy the vector adapter using the
 ``rte_event_vector_adapter_destroy()`` function.

v2 Changes:
- Clarify documentation.
- Update MAINTAINERS file.

v3 Changes:
- Update documentation.

Pavan Nikhilesh (3):
  eventdev: introduce event vector adapter
  eventdev: add default software vector adapter
  app/eventdev: add vector adapter performance test

 MAINTAINERS                                   |   7 +
 app/test-eventdev/evt_common.h                |   9 +-
 app/test-eventdev/evt_options.c               |  14 +
 app/test-eventdev/evt_options.h               |   1 +
 app/test-eventdev/test_perf_atq.c             |  61 +-
 app/test-eventdev/test_perf_common.c          | 281 ++++--
 app/test-eventdev/test_perf_common.h          |  13 +-
 app/test-eventdev/test_perf_queue.c           |  66 +-
 app/test/meson.build                          |   1 +
 app/test/test_event_vector_adapter.c          | 682 ++++++++++++++
 config/rte_config.h                           |   1 +
 doc/api/doxy-api-index.md                     |   1 +
 doc/guides/eventdevs/features/default.ini     |   7 +
 .../eventdev/event_vector_adapter.rst         | 222 +++++
 doc/guides/prog_guide/eventdev/eventdev.rst   |  10 +-
 doc/guides/prog_guide/eventdev/index.rst      |   1 +
 doc/guides/rel_notes/release_25_07.rst        |  15 +
 doc/guides/tools/testeventdev.rst             |   6 +
 lib/eventdev/event_vector_adapter_pmd.h       |  85 ++
 lib/eventdev/eventdev_pmd.h                   |  38 +
 lib/eventdev/meson.build                      |   3 +
 lib/eventdev/rte_event_vector_adapter.c       | 864 ++++++++++++++++++
 lib/eventdev/rte_event_vector_adapter.h       | 477 ++++++++++
 lib/eventdev/rte_eventdev.c                   |  24 +
 lib/eventdev/rte_eventdev.h                   |  10 +
 25 files changed, 2800 insertions(+), 99 deletions(-)
 create mode 100644 app/test/test_event_vector_adapter.c
 create mode 100644 doc/guides/prog_guide/eventdev/event_vector_adapter.rst
 create mode 100644 lib/eventdev/event_vector_adapter_pmd.h
 create mode 100644 lib/eventdev/rte_event_vector_adapter.c
 create mode 100644 lib/eventdev/rte_event_vector_adapter.h

--
2.39.5 (Apple Git-154)

