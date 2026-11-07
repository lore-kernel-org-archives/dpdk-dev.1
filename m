Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD10606A326
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CU7RCqL7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B49402A4;
	Sat,  7 Nov 2026 02:30:20 +0100 (CET)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTPS id B51F740292
 for <dev@dpdk.org>; Sat,  7 Nov 2026 02:30:18 +0100 (CET)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-5366ae57896so12760161cf.3
 for <dev@dpdk.org>; Fri, 06 Nov 2026 17:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794015017; x=1794619817; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZOLHnUQJW+K4NZGhK6KMiFKxF7uxdXLiCtUtqR96NOI=;
 b=CU7RCqL7P9oIfLzxse1ysuA6liwMyyzvw7HQPfmkKGhzGGhv00a7/YrEaCaqUzk7Yl
 6BFDceQ7cOtzSGv7Ma5UUxY+CWlNGN9C+WES/Nk8l2NMdNynCFieVauv+ru6VPKjG0UD
 jbk3GtJ+ul1PzUrmifzn3jrF83WaFsT/m/1mpjrPTZBr1U7U1sFy6RFgJ85/hM4YzFun
 l4pnjTmBgqnQwvQBJ4+V4ODASESXzfjcBmapm8Y8/jTB5q8EdnFJwjCSSqpl8tbAMTK0
 Q3T4pb+gQe2l2sLh54rgecS9cmi/obLqiFDeBaG1AFl0QrBYtmKt6jyk1LmdQm3qnM3C
 UEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794015017; x=1794619817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZOLHnUQJW+K4NZGhK6KMiFKxF7uxdXLiCtUtqR96NOI=;
 b=uzwACsmtp43ULW6qAPbp/cWQFiDSGW9J3OoznC2a+/anW4KVNwUuTkOic0hTluhHKl
 W+uo3BOy0mUu2WQBygzbnA3gJ5M6cYlOIA6lomCOgeHFpVzx9Hljw5cv4qm5OYILXXBx
 uQDs/kyIh4dFY+qsu6FiYDHtyS2yP11Y+zURZd9oVYOezYOsCm+vO9exm9cBi7DRAk0U
 aQ4lsx9hPBJVWAn9npWwXBgJfTyrz/Rlymw7jW0lRmo2+UV4RA4hfUIGh32Sjjdw4dJS
 Qua7IMpXOoFeMtgYx0DK8UkNBifFKjtogDdW9lgjO2wYOHDLaSQ4sAN7RUoq0d4MqoHZ
 TV9Q==
X-Gm-Message-State: APuU4Z8uQ+KuGyEyiPRTA5I4y+saNoPjI04mQ7W3gJDRskjAkHgs3o5i
 a5DzSOXSWrB8EQcjZOqynzijbJ/g83QEvsVOQWjFXrg7S3CIVxi0KaBzZ6Ni2h+qeDt2Sw==
X-Gm-Gg: AYBFou09pbGMGBcww5p/XQQ1oUykVUKtNiK5dwHrN9jbZEr6q/Q2dQVsPXNQIepD65N
 M7hCzG0v0YuHyDyVPiW7cLrpSW+a0tj71TbAA4UwhlFrbk+2PG7nXZuUtMsWZQS3JmzydnlpFX3
 kfxDg9YeRpuADMe7BKQUYIS/TQy0wZtor1wu/5TABTV+QcjyqK+GvllT+mg/PgkxX6juVi4Wtic
 siq2GU99bZJ7pRi14bIc9EGlR1A4dTXqui/bLtrsiivrwcTPF3IRYcR1mZJ2rhBsF06GvxQnyvL
 ptDn6oxwO0335o4IOCy4sApKUg/UH8NRRV9Jqozm5zVCrOxeM7QJRB2VYp+s1PILOX3AqtzBeCN
 N0Uxw8fRP0buIDdOgI7VKi4GfSLuePXYHG2Y06YKyw3n7/pMF7BbIuRAqn5ciFBtHxdrz8b90o1
 BzBLob8zTZk+PAue5Sfn63zZJDffnwxbgT/PRtoUwuADWRSWvBN8MaDCiNLBzPdnHNmXJCorSru
 wiUiNEnL7VoUheiLG8EBKIVaVMgvTmVfVdLZGuJRuHYjriGvslcaikiyjV8UwIJgS2zCzn1mil3
 7txFQO7Y9zadE2M5KgPYAVtwGlehygH7zGJzSkswOSzxtxWqCUoSFpvYu+xZd6SM067PKEkYgTP
 q1HYULE7oaSMQsih9
X-Received: by 2002:ac8:5d10:0:b0:533:3192:7a8e with SMTP id
 d75a77b69052e-54e14079dd5mr65832001cf.43.1794015016183; 
 Fri, 06 Nov 2026 17:30:16 -0800 (PST)
Received: from pravin-HP-Z840 (ool-944c2ac1.dyn.optonline.net. [148.76.42.193])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54e257862bfsm33746111cf.6.2026.11.06.17.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 17:30:15 -0800 (PST)
From: Pravin Pathak <pravinpathakdev@gmail.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak.dev@gmail.com>
Subject: [PATCH v1 0/8] event/slb: introducing software load balancer eventdev
 PMD
Date: Fri,  6 Nov 2026 20:30:02 -0500
Message-ID: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pravin Pathak <pravin.pathak.dev@gmail.com>

This series introduces the Software Load Balancer (SLB) Eventdev PMD
(`event_slb`) supporting parallel, atomic and ordered queues. It is 
a distributed software scheduler that scales well.

Motivation
----------
Existing software eventdev PMDs face trade-offs between centralized
bottlenecks and feature coverage:
- `event_sw` relies on a dedicated centralized scheduler consuming
  an extra CPU core. The single scheduling core also limits maximum
  throughput and it does not scale.
- `event_dsw` distributes scheduling across worker cores without a
  central scheduler core, but does not support ordered queues and 
  incurs per-port control ring messaging overhead during atomic flow
  migrations. It also does not support service priority.

Design Overview
---------------
`event_slb` is a distributed (`RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED`),
maintenance-free (`RTE_EVENT_DEV_CAP_MAINTENANCE_FREE`) software eventdev
PMD that supports Atomic, Ordered, Parallel, and Single-Link queues:

1. Queue-Centric Ring Architecture:
   - Parallel and Single-Link queues map directly to `rte_event_ring`
     instances (MP/MC for parallel, MP/SC for single-link), allowing
     zero-copy burst enqueue and dequeue without history tracking.
   - Ordered queues use the ring slot index at dequeue time as an implicit
     sequence number into a per-queue reorder buffer, draining contiguous
     completed events in order without global sequence counters. This 
	 makes ordered queue implementaion highly efficient performing close
	 to parallel queues.
   - Atomic queues use a main MP/SC queue ring alongside per-port SP/SC
     rings and a 2048-entry flow-to-port affinity table. All cores
	 served by the atomic queue are used for scheduling.

2. Lock-Free / Zero-Pause Atomic Flow Migration:
   - When an atomic queue refills per-port rings and detects persistent
     congestion on a destination port, SLB selects the lightest flow on
     that port (outside the migration cooldown window) and waits for
	 queues in-flight events to drain naturally before switching the 
	 flow's port affinity and schedule hold-buffer entries.
   - Hold buffer is used for buffering events towards migrating ports
     while allowing serving other ports.
   - Implementaion avoids cross-port pause/unpause control rings while
     preserving strict per-flow ordering.

3. Credit-Based Backpressure & Priority Scheduling:
   - A global atomic credit pool with per-port local credit caches bounds
     total in-flight events (`nb_events_limit`) and enforces
	 `new_event_threshold` with minimal atomic contention.
   - Ports support two strict service priority levels with
     round-robin scheduling within each priority level.

4. Observability & Testing:
   - Device and per-port/per-queue extended statistics (`xstats`),
     detailed `rte_event_dev_dump()` diagnostics, and a unit self-test
     suite (`eventdev_selftest_slb`) covering parallel, atomic, ordered,
     single-link, priority, backpressure, stop-flush, and multi-core
     atomic migration scenarios.

5. Future Plan:
   - Supporting Event priority
   - Optimizing atomic flow migration

Pravin Pathak (8):
  event/slb: introduce software load balancer PMD
  event/slb: add support for ordered queues
  event/slb: add support for atomic queues
  event/slb: add dynamic flow migration for atomic queues
  event/slb: add extended statistics and diagnostics
  event/slb: add self-test and documentation
  event/slb: update resets and credit defaults
  event/slb: improve port linking, config checks and atomic refill

 MAINTAINERS                           |    6 +
 app/test/test_eventdev.c              |    7 +
 doc/guides/eventdevs/features/slb.ini |   25 +
 doc/guides/eventdevs/index.rst        |    1 +
 doc/guides/eventdevs/slb.rst          |   61 ++
 drivers/event/meson.build             |    1 +
 drivers/event/slb/meson.build         |   21 +
 drivers/event/slb/slb_evdev.c         |  904 ++++++++++++++++++
 drivers/event/slb/slb_evdev.h         |  263 ++++++
 drivers/event/slb/slb_event.c         | 1219 +++++++++++++++++++++++++
 drivers/event/slb/slb_selftest.c      |  522 +++++++++++
 drivers/event/slb/slb_xstats.c        |  347 +++++++
 12 files changed, 3377 insertions(+)
 create mode 100644 doc/guides/eventdevs/features/slb.ini
 create mode 100644 doc/guides/eventdevs/slb.rst
 create mode 100644 drivers/event/slb/meson.build
 create mode 100644 drivers/event/slb/slb_evdev.c
 create mode 100644 drivers/event/slb/slb_evdev.h
 create mode 100644 drivers/event/slb/slb_event.c
 create mode 100644 drivers/event/slb/slb_selftest.c
 create mode 100644 drivers/event/slb/slb_xstats.c

-- 
2.53.0

