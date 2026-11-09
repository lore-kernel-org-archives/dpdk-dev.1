Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8793606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 02:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ngYU2SVl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB62B40272;
	Mon,  9 Nov 2026 03:30:33 +0100 (CET)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com
 [209.85.222.54])
 by mails.dpdk.org (Postfix) with ESMTPS id B848F4021E
 for <dev@dpdk.org>; Mon,  9 Nov 2026 03:30:32 +0100 (CET)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-9999f21f617so68757241.1
 for <dev@dpdk.org>; Sun, 08 Nov 2026 18:30:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794191431; cv=none;
 d=google.com; s=arc-20260327;
 b=n+sBJlaDTtyIevirYfQsv1lHSkw99TNg/iN8hsn3cnfkAjIZ1qaD02PWni1m7jm1rm
 RxhjThOL2M7mYu6aRC++eSkrDUylIVfbrcqOEtaDeJWD3nSkCvMdX78Wvg+ctHMnbGup
 38AxNvWpoyfhN79DCPM8vzIkefAJIleLow4u85+2FQYZ7jYs8LASjdWe9Bf5aKHQlP/2
 zUYkzszZuetvDiE9wV4lcJ8OHyw4twHBubwra1uVcl3lU9t9iANnrmafCgivoOdcK0iD
 PLrmE9zJuhYQXi608Ngt2X0N3683lx0aVGMh/iwwnGO8u40YwlkpZA7BVp5SvgeOL4Z3
 nXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AbtYCYhlbohG1NLR/upMoVeVn3eejGmmP0rK0xQVH4M=;
 fh=TzhYogxWabZ7rUN9pSAS2R5p0J+UpZfOQpRYz27SqVU=;
 b=kmZwv9J4orrmfrtUwB9aRI/iuOIll1SXih7NIL6sUSPXuzUlbz4nu4lFzWTEYSBQVi
 zxucsOxW7djrjc0YTy4zYmr5KgP5JzME45BJNMhT7LDp3Q/3FSIcxgvXDyQu+vPfQWIj
 bK4BzrHAYQQXTm29DCDuzjKo8AKKOSnW3cyT8LZ6e9YOxvCHD1kRn5c6zR40HfTZxYf2
 1zjbeuEF4jxzek3RaB7rXKaZNaiMM/6kYtRbbjVMAhYXtvqJol19GOpBiyyUtp4Kj5Rc
 n05sO5kLGrGg3ZXQ0lMAm4uDP3bKpUORtu/NR+kVIYCRQVH9v3qT+ZbmdUZkQGjOKX2S
 tiGw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794191431; x=1794796231; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AbtYCYhlbohG1NLR/upMoVeVn3eejGmmP0rK0xQVH4M=;
 b=ngYU2SVlN1pQEnDjlio8wUzpDzWjaK9tX3KdENrTRA4/QpWH8hJp2Zl2+i/wqs+10M
 4g+I7UlZJG+gIsDplJvZR/K6cTbkxLz0OE1yexGJTBDH0CA3RLLXGv3FwFad9wTVh98q
 UX7J/o3DWaE7OHl16iguQwUqPSBr0pUH5XfZ4IvFmeoh1/M5uGE9Vh+VZOaGxYWu/+Q8
 iLpGNbTN7vekfDu2kOnZVG5SWvI1nQeosfzndV3SUiJ4Qt3UC/nZlsbHptFJuGEXo/4Z
 9TWnPVxYDnVpl5GSgW3hQffqncr/mRzivJrRIOsrGyeQrf6tDvLrPBha5bi8j8VG9XRu
 oPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794191431; x=1794796231;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AbtYCYhlbohG1NLR/upMoVeVn3eejGmmP0rK0xQVH4M=;
 b=TW/BDF+P0hEsOnVK0GgoFMMKRQmnlcCLv+owtvO0YnMc2Vq5YDbnGMDrTS1ZINC1Sl
 ZvfKoVKZHwVG9M1vlbQSMycfUSPoWFHZMdvE5jgxMe1SbXYlhQXnO6cLTYQIKrZ73u/Y
 z9BWSz7sr4mw5sSdS07fkJlTOTsn7d+RZg9B9sD9v/y5Z5JBAawuED4u7D/bBBCKbjd6
 +AT9H5TnOBaPKXcuV6rg2HY0DuZiBOrBJ4qi01476n1sDJJCXs0YEIYUJjaTgAGzoiSI
 xbmmqSdPdBWDCt+/tza1vRkCwoSVQFG7VXESsiPqAjCKLJkQnB/jxVrF1COQ8mq9XhG0
 liyw==
X-Forwarded-Encrypted: i=1;
 AL+hErFuPCElz0afoGOWJUCPsw2Q3BVK6G9a+kRWUtKiSnHLzGKxG82+mNd03Yk2PGe/laWSGoY=@dpdk.org
X-Gm-Message-State: APuU4Z9ciPEfNmtH9DUCu1s1R23GZGp4/AbLT0Aggcly6MhEBiNXID0V
 riImf2hlaZQwsPJm26VIXgOp2eFHxdQSA23AwSHZuQJvwMwkjdfXBW9Q5VXk6lgoBy6JjOeeZEk
 KaJigXUfwMsq131KzOUbOzZp7Tr+QHBY=
X-Gm-Gg: AYBFou1GDA3Pkr3qqUBbTzPh7TeE5QOXxR8qAZQgiGp4Vn6uoC4Ny/8hyePbNzQedoB
 AUrP6eLX8FltqtgBO13g06mGLn9KTyQPGAvqUDN9JZ36Rv7ERWZaT+EHA2UI71ZKi6AmasHWz9T
 y2cSlFEcEUdRZWr6NlyeeC++0JkjBiv3zwIggsh7xi9/hR97eYhuFRRYBr/cnskbv85+3/hcFWt
 zJhAsoEf6NJCUFh0H3sM9FG1muATnQEf14qh9wRmfgG8DBschEav0R58Z0sKy1lw1SUkvHQ3D0l
 BgfB3+Svvkq7WIBQ7ruLruY5H1dWdYpBtgisyy7LCXblfYqIpLhrD4TYZbT/hks0Z9AA2Mp03I2
 0eVU3zBIKWvx1PMw3gsSaUZvbiUYyzgrar25BZAvkAaZK+RoEoncWGTaOGw==
X-Received: by 2002:a05:6102:4188:b0:7c1:75c5:c4c with SMTP id
 ada2fe7eead31-7d2db200b05mr464645137.25.1794191431218; Sun, 08 Nov 2026
 18:30:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
 <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
In-Reply-To: <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
From: Pravin Pathak <pravinpathakdev@gmail.com>
Date: Sun, 8 Nov 2026 21:30:20 -0500
X-Gm-Features: AclHuK-B-krFs_pf6rfJzNPlPYgwlgbxexnvZmCgujzCQuAGWKr8gMLZybmU-Uk
Message-ID: <CAPbG5O_hYnLaSARh3jnw3LFToaF_S9dnjpNPFVfmJHGN2Lr9qQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
To: Jerin Jacob <jerinjacobk@gmail.com>
Cc: mattias.ronnblom@ericcson.com, dev@dpdk.org, jerinj@marvell.com, 
 mike.ximing.chen@intel.com, bruce.richardson@intel.com, thomas@monjalon.net, 
 david.marchand@redhat.com, nipun.gupta@amd.com, chenbox@nvidia.com, 
 tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 2:29=E2=80=AFAM Jerin Jacob <jerinjacobk@gmail.com> =
wrote:
>
> On Sat, Nov 7, 2026 at 7:00=E2=80=AFAM Pravin Pathak <pravinpathakdev@gma=
il.com> wrote:
> >
> > From: Pravin Pathak <pravin.pathak.dev@gmail.com>
> >
> > This series introduces the Software Load Balancer (SLB) Eventdev PMD
> > (`event_slb`) supporting parallel, atomic and ordered queues. It is
> > a distributed software scheduler that scales well.
> >
> > Motivation
> > ----------
> > Existing software eventdev PMDs face trade-offs between centralized
> > bottlenecks and feature coverage:
> > - `event_sw` relies on a dedicated centralized scheduler consuming
> >   an extra CPU core. The single scheduling core also limits maximum
> >   throughput and it does not scale.
> > - `event_dsw` distributes scheduling across worker cores without a
> >   central scheduler core, but does not support ordered queues and
> >   incurs per-port control ring messaging overhead during atomic flow
> >   migrations. It also does not support service priority.
> >
> > Design Overview
> > ---------------
> > `event_slb` is a distributed (`RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED`),
> > maintenance-free (`RTE_EVENT_DEV_CAP_MAINTENANCE_FREE`) software eventd=
ev
> > PMD that supports Atomic, Ordered, Parallel, and Single-Link queues:
>
> @mattias.ronnblom@ericcson.com  - drivers/event/dsw/
> @liangma@liangbit.com - drivers/event/opdl/
> NO MAINTAINER for drivers/event/sw/
>
> Hi Pravin,
> Creating new flavours. of evendev SW drivers is a maintenance burden,
> If this is close to DSW then please introduce mode in DSW driver and
> have function pointer switches for fastpath,
> Also claim should be backed by performance test values. Use
> testeventdev test cases and share the numbers to prove one way or
> another.
>
> In summary, IMO, it better to take NEW SW PMD when
> a)It operates completely different than DSW and SW and it is NOT
> possible to update existing SW PMDs
> b)Able to show better performance than existing drivers on the specific c=
ases.
>
This driver is architecturally completely different from DSW. And it addres=
ses
the gap of scalable software eventdev that can support ordered queues and
service priority. The skeleton is borrowed from DSW instead of writing
a new one.
But the underlying architecture is completely different. SLB uses
queues instead of
directly enquing to destination ports. DSW is an enqueue time scheduler
whereas SLB is a dequeue time scheduler. Very basic mechanism is different.
SLB does atomic flow migration is based on the port queue associated with t=
he
atomic queue being full. It does not compute CPU load but checks if core is
able to serve the queue at mapped priority and if not, flows are migrated.
SLB is maintenance free unlike DSW. Flow migration happens without any
core-to-core communication required. SLB architecture allows extension to
support event priorities and configurable number of service priorities.
I will make patches with AI review fixes. AI comparison is matching
the structure and not underlying architecture. So it shows similarity.
>
> >
> > 1. Queue-Centric Ring Architecture:
> >    - Parallel and Single-Link queues map directly to `rte_event_ring`
> >      instances (MP/MC for parallel, MP/SC for single-link), allowing
> >      zero-copy burst enqueue and dequeue without history tracking.
> >    - Ordered queues use the ring slot index at dequeue time as an impli=
cit
> >      sequence number into a per-queue reorder buffer, draining contiguo=
us
> >      completed events in order without global sequence counters. This
> >          makes ordered queue implementaion highly efficient performing =
close
> >          to parallel queues.
> >    - Atomic queues use a main MP/SC queue ring alongside per-port SP/SC
> >      rings and a 2048-entry flow-to-port affinity table. All cores
> >          served by the atomic queue are used for scheduling.
> >
> > 2. Lock-Free / Zero-Pause Atomic Flow Migration:
> >    - When an atomic queue refills per-port rings and detects persistent
> >      congestion on a destination port, SLB selects the lightest flow on
> >      that port (outside the migration cooldown window) and waits for
> >          queues in-flight events to drain naturally before switching th=
e
> >          flow's port affinity and schedule hold-buffer entries.
> >    - Hold buffer is used for buffering events towards migrating ports
> >      while allowing serving other ports.
> >    - Implementaion avoids cross-port pause/unpause control rings while
> >      preserving strict per-flow ordering.
> >
> > 3. Credit-Based Backpressure & Priority Scheduling:
> >    - A global atomic credit pool with per-port local credit caches boun=
ds
> >      total in-flight events (`nb_events_limit`) and enforces
> >          `new_event_threshold` with minimal atomic contention.
> >    - Ports support two strict service priority levels with
> >      round-robin scheduling within each priority level.
> >
> > 4. Observability & Testing:
> >    - Device and per-port/per-queue extended statistics (`xstats`),
> >      detailed `rte_event_dev_dump()` diagnostics, and a unit self-test
> >      suite (`eventdev_selftest_slb`) covering parallel, atomic, ordered=
,
> >      single-link, priority, backpressure, stop-flush, and multi-core
> >      atomic migration scenarios.
> >
> > 5. Future Plan:
> >    - Supporting Event priority
> >    - Optimizing atomic flow migration
> >
> > Pravin Pathak (8):
> >   event/slb: introduce software load balancer PMD
> >   event/slb: add support for ordered queues
> >   event/slb: add support for atomic queues
> >   event/slb: add dynamic flow migration for atomic queues
> >   event/slb: add extended statistics and diagnostics
> >   event/slb: add self-test and documentation
> >   event/slb: update resets and credit defaults
> >   event/slb: improve port linking, config checks and atomic refill
> >
> >  MAINTAINERS                           |    6 +
> >  app/test/test_eventdev.c              |    7 +
> >  doc/guides/eventdevs/features/slb.ini |   25 +
> >  doc/guides/eventdevs/index.rst        |    1 +
> >  doc/guides/eventdevs/slb.rst          |   61 ++
> >  drivers/event/meson.build             |    1 +
> >  drivers/event/slb/meson.build         |   21 +
> >  drivers/event/slb/slb_evdev.c         |  904 ++++++++++++++++++
> >  drivers/event/slb/slb_evdev.h         |  263 ++++++
> >  drivers/event/slb/slb_event.c         | 1219 +++++++++++++++++++++++++
> >  drivers/event/slb/slb_selftest.c      |  522 +++++++++++
> >  drivers/event/slb/slb_xstats.c        |  347 +++++++
> >  12 files changed, 3377 insertions(+)
> >  create mode 100644 doc/guides/eventdevs/features/slb.ini
> >  create mode 100644 doc/guides/eventdevs/slb.rst
> >  create mode 100644 drivers/event/slb/meson.build
> >  create mode 100644 drivers/event/slb/slb_evdev.c
> >  create mode 100644 drivers/event/slb/slb_evdev.h
> >  create mode 100644 drivers/event/slb/slb_event.c
> >  create mode 100644 drivers/event/slb/slb_selftest.c
> >  create mode 100644 drivers/event/slb/slb_xstats.c
> >
> > --
> > 2.53.0
> >
