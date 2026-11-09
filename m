Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87A606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h1W0DkVp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 749B34060C;
	Mon,  9 Nov 2026 13:55:49 +0100 (CET)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 1D95540151
 for <dev@dpdk.org>; Mon,  9 Nov 2026 13:55:48 +0100 (CET)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-8b37c7d767aso4372927b3.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 04:55:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794228947; cv=none;
 d=google.com; s=arc-20260327;
 b=RslBADXI/A18Z3RfBgzUpgKMthd6GEL/Azmd+rG8GjwB83PLdMQnTh8gQVJglTl+Y4
 btgeLCh/6kbGElHAl/BqRMO3yuKxV4hyLGXfnBl6J6eaCssRl1l3i3owAVJU1nDkzN4q
 sjPSimp9JmkiRcraiJdFMOkX1a/6sgTLJjcf7TTo2Zo0GKJTnjvYADdN8oaWZAusC2JW
 0GB4hKH5SoPcpt0fjZnXFtYlXAMEhD/p/vWDp+ksu1axGOG5+NBQhc49qqo5Y7tTB14X
 N1vSZvmCr8yiUuc0hhXh/U1SrrK0uQvrEAXT3of/HJIkJOtCqt32ESEhyvGzVndSk47a
 7WKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jvifW0Rmk4GP5NzIE+I115HK3HtttGjMNXfXkBw61jY=;
 fh=TkrVCEdCs7ZsjCW0lC4RZFQERjy/YtVZBXCpsW9Jjts=;
 b=JkTkMFLZ+CN70TarTVhh6Oe38I2MA+ye16BqsAFnJjgzvtDyFNmjTaMbjo7bjiIKuz
 S5Eefb5WxOU7rSeMFm3liPjbTkQUu/zxQVJmsKx7fjtDcl9JyKLx0who6LJrJgXeBVg6
 ifPk1jA5+8hZrhTvYh+3vOS0wBWz6rKN4TPbod8wVZ5oOw3hcfTTdX2tKtaxueuYw3i5
 /nWLdNV2EG8oyNBlJXKhs6TcJBIY7UAs1LCAST7Z5zQkbKVuJac5aQM02UET84GlQHH+
 bjvW+mcosbiaiKTEdbmgTQq2dGpC9aWKR7ri6B4I+vN51C2BBb9a/cFiNJRtxYiYGYTg
 pKIA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794228947; x=1794833747; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jvifW0Rmk4GP5NzIE+I115HK3HtttGjMNXfXkBw61jY=;
 b=h1W0DkVp5QvU7QWd67PXlBbo23JAZ0B/g/C5SPQxltaTKn9RgAkytzqAAD39ty1vBF
 GWrOMTv7Ejhr5AB+aWMiITMHcJb5a3Tt0F+Z9HdsP8QX4Cb2s9OBDF504UV8fAh2gdLM
 q9XUf+BYIa6XioQVmkfl8AeIGGdgCm8ofpefTAqxc++w3Nr22GYQM0ZTeOE3k5Z8tgiK
 OkWf5DKpwW4Pdwy2tdc56ys5F+Jc30QCNoZAcNwwr78WZTRNWmVlncgryzjG/GD6SIZe
 JOzUZtncnBArrCduFUNx0khrZodCRh/IL18yOtshBJ8jX9oe/WT0PlgTpbXaCdw2D0Qk
 RqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794228947; x=1794833747;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jvifW0Rmk4GP5NzIE+I115HK3HtttGjMNXfXkBw61jY=;
 b=ZhSNq52zLCgmJl4g2YiymkMZka64wEWA954/rKDqRQm/ZlJqUeF87STp1NAi4+TH51
 AXiOlfysance7FRsTDKXMIBEfEO37kXB5IVB2bCOL/2UY97s8zqr9L9Rn5VJ9OPU31JP
 fCfXvbff69eIHgG02hrKTrZ5t5KSaUJAwGw4X/OiSJCz+/2Brvl1KjmpBLdzyso26Fof
 Kt+LnWzFukoc7hBGnZOPwBbYyuk3vCobXyf0s/mJLiCxfoVOy8a4csO9CHoH8BXGXtuA
 Rl/AVte9Owxngdxx6m7+QuWwxNrqmOQyqHbjcHewfzqg/rxAO8nit1LKUTsEmLE+Ygou
 lueg==
X-Forwarded-Encrypted: i=1;
 AL+hErGcnFnMSLfp5Pxe7f1Gw37FaioFk9gqM6SKgQ2RXRYroqtPVcDn3DRjQXT58DwVOz/B+Ps=@dpdk.org
X-Gm-Message-State: APuU4Z9hVp9h3s05K3aaZ9v7O8IKsyd7Piq8F27M1lvPEJ8SpFof3s8g
 6CdZZ+TWjevbd2HzeXi/MBCTA6wZC3FIWVZnLVXRhbto0erDJ/e/7Y/T2MBnm87/ck+QXRt10MY
 iU5uUQpYxtCWxtKCYJCnj6x8N7vP+xe8=
X-Gm-Gg: AYBFou32Hl1HWVYo68huoWC6t1pv6qsGJLgTZ0IN39rG5wchfe32LQKDbikSgXxgI3B
 kIkEtOgbEx8Pouy+42u515dFpwTPcyRyOqomwBLbauWVkNw7V9H335b+Ox3yrMlZnj+FB6PQrKT
 +NHNI+MRHCBoAxZhgiIhfeFr5DkvVS5JL0fJZHe4ASj4f6kf5rcu+06G0gQqX4nrB/DaF0poQ6+
 bNxT1EK132+5Zx5Czl1kXgjblFwPv1hOnD2GXM4qniRr5yzlwgzptbyB+d/8bb8jKgbj0qdWmj+
 6yfNic0s56KFJ68JQu3X8N6WAXJmf0bVdN713uI8g2XRhrYGKUeFKk1hER6BJMI6elmflXTH0uu
 /e2ZkaIgeWJBq+PWYjiTkCr8Liat0oxCcVWAzIK0nTbfsHx8CpKa0sNrEt+ll+g54lcrVzv4aKT
 iAX/HuhdV6ju+eUdoDtLfNz6KoWyjSzaTSZmMv8DpgC68K1kMgQh/nwNb9PC1h+a1U5G9jZa7w1
 QoMkJ/d
X-Received: by 2002:a05:690c:9990:b0:8b3:178e:66e with SMTP id
 00721157ae682-8b36ca7a8c5mr18911157b3.40.1794228946632; Mon, 09 Nov 2026
 04:55:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
 <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
 <CAPbG5O_hYnLaSARh3jnw3LFToaF_S9dnjpNPFVfmJHGN2Lr9qQ@mail.gmail.com>
In-Reply-To: <CAPbG5O_hYnLaSARh3jnw3LFToaF_S9dnjpNPFVfmJHGN2Lr9qQ@mail.gmail.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 9 Nov 2026 18:25:19 +0530
X-Gm-Features: AclHuK-yxyaNtazPZVY0Wrdm9j3PuF_x9FwHLR4iuXHPN_1dsZ8ULHJzMI0JmR4
Message-ID: <CALBAE1N77y7PkK9o09JwJ=e1GDin9jxyN7VfjvDgY2oFEr9prw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
To: Pravin Pathak <pravinpathakdev@gmail.com>
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

On Mon, Nov 9, 2026 at 8:00=E2=80=AFAM Pravin Pathak <pravinpathakdev@gmail=
.com> wrote:
>
> On Sat, Nov 7, 2026 at 2:29=E2=80=AFAM Jerin Jacob <jerinjacobk@gmail.com=
> wrote:
> >
> > On Sat, Nov 7, 2026 at 7:00=E2=80=AFAM Pravin Pathak <pravinpathakdev@g=
mail.com> wrote:
> > >
> > > From: Pravin Pathak <pravin.pathak.dev@gmail.com>
> > >
> > > This series introduces the Software Load Balancer (SLB) Eventdev PMD
> > > (`event_slb`) supporting parallel, atomic and ordered queues. It is
> > > a distributed software scheduler that scales well.
> > >
> > > Motivation
> > > ----------
> > > Existing software eventdev PMDs face trade-offs between centralized
> > > bottlenecks and feature coverage:
> > > - `event_sw` relies on a dedicated centralized scheduler consuming
> > >   an extra CPU core. The single scheduling core also limits maximum
> > >   throughput and it does not scale.
> > > - `event_dsw` distributes scheduling across worker cores without a
> > >   central scheduler core, but does not support ordered queues and
> > >   incurs per-port control ring messaging overhead during atomic flow
> > >   migrations. It also does not support service priority.
> > >
> > > Design Overview
> > > ---------------
> > > `event_slb` is a distributed (`RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED`),
> > > maintenance-free (`RTE_EVENT_DEV_CAP_MAINTENANCE_FREE`) software even=
tdev
> > > PMD that supports Atomic, Ordered, Parallel, and Single-Link queues:
> >
> > @mattias.ronnblom@ericcson.com  - drivers/event/dsw/
> > @liangma@liangbit.com - drivers/event/opdl/
> > NO MAINTAINER for drivers/event/sw/
> >
> > Hi Pravin,
> > Creating new flavours. of evendev SW drivers is a maintenance burden,
> > If this is close to DSW then please introduce mode in DSW driver and
> > have function pointer switches for fastpath,
> > Also claim should be backed by performance test values. Use
> > testeventdev test cases and share the numbers to prove one way or
> > another.
> >
> > In summary, IMO, it better to take NEW SW PMD when
> > a)It operates completely different than DSW and SW and it is NOT
> > possible to update existing SW PMDs
> > b)Able to show better performance than existing drivers on the specific=
 cases.
> >
> This driver is architecturally completely different from DSW. And it addr=
esses
> the gap of scalable software eventdev that can support ordered queues and
> service priority. The skeleton is borrowed from DSW instead of writing
> a new one.
> But the underlying architecture is completely different. SLB uses
> queues instead of
> directly enquing to destination ports. DSW is an enqueue time scheduler
> whereas SLB is a dequeue time scheduler. Very basic mechanism is differen=
t.
> SLB does atomic flow migration is based on the port queue associated with=
 the
> atomic queue being full. It does not compute CPU load but checks if core =
is
> able to serve the queue at mapped priority and if not, flows are migrated=
.
> SLB is maintenance free unlike DSW. Flow migration happens without any
> core-to-core communication required. SLB architecture allows extension to
> support event priorities and configurable number of service priorities.
> I will make patches with AI review fixes. AI comparison is matching
> the structure and not underlying architecture. So it shows similarity.


Lets get the performance  numbers for SLB vs DSW based on same test
case so  that we can decide.
Performance and scalability will be the aspect to decide the usage of
YET ANOTHER SW driver.



> >
> > >
> > > 1. Queue-Centric Ring Architecture:
> > >    - Parallel and Single-Link queues map directly to `rte_event_ring`
> > >      instances (MP/MC for parallel, MP/SC for single-link), allowing
> > >      zero-copy burst enqueue and dequeue without history tracking.
> > >    - Ordered queues use the ring slot index at dequeue time as an imp=
licit
> > >      sequence number into a per-queue reorder buffer, draining contig=
uous
> > >      completed events in order without global sequence counters. This
> > >          makes ordered queue implementaion highly efficient performin=
g close
> > >          to parallel queues.
> > >    - Atomic queues use a main MP/SC queue ring alongside per-port SP/=
SC
> > >      rings and a 2048-entry flow-to-port affinity table. All cores
> > >          served by the atomic queue are used for scheduling.
> > >
> > > 2. Lock-Free / Zero-Pause Atomic Flow Migration:
> > >    - When an atomic queue refills per-port rings and detects persiste=
nt
> > >      congestion on a destination port, SLB selects the lightest flow =
on
> > >      that port (outside the migration cooldown window) and waits for
> > >          queues in-flight events to drain naturally before switching =
the
> > >          flow's port affinity and schedule hold-buffer entries.
> > >    - Hold buffer is used for buffering events towards migrating ports
> > >      while allowing serving other ports.
> > >    - Implementaion avoids cross-port pause/unpause control rings whil=
e
> > >      preserving strict per-flow ordering.
> > >
> > > 3. Credit-Based Backpressure & Priority Scheduling:
> > >    - A global atomic credit pool with per-port local credit caches bo=
unds
> > >      total in-flight events (`nb_events_limit`) and enforces
> > >          `new_event_threshold` with minimal atomic contention.
> > >    - Ports support two strict service priority levels with
> > >      round-robin scheduling within each priority level.
> > >
> > > 4. Observability & Testing:
> > >    - Device and per-port/per-queue extended statistics (`xstats`),
> > >      detailed `rte_event_dev_dump()` diagnostics, and a unit self-tes=
t
> > >      suite (`eventdev_selftest_slb`) covering parallel, atomic, order=
ed,
> > >      single-link, priority, backpressure, stop-flush, and multi-core
> > >      atomic migration scenarios.
> > >
> > > 5. Future Plan:
> > >    - Supporting Event priority
> > >    - Optimizing atomic flow migration
> > >
> > > Pravin Pathak (8):
> > >   event/slb: introduce software load balancer PMD
> > >   event/slb: add support for ordered queues
> > >   event/slb: add support for atomic queues
> > >   event/slb: add dynamic flow migration for atomic queues
> > >   event/slb: add extended statistics and diagnostics
> > >   event/slb: add self-test and documentation
> > >   event/slb: update resets and credit defaults
> > >   event/slb: improve port linking, config checks and atomic refill
> > >
> > >  MAINTAINERS                           |    6 +
> > >  app/test/test_eventdev.c              |    7 +
> > >  doc/guides/eventdevs/features/slb.ini |   25 +
> > >  doc/guides/eventdevs/index.rst        |    1 +
> > >  doc/guides/eventdevs/slb.rst          |   61 ++
> > >  drivers/event/meson.build             |    1 +
> > >  drivers/event/slb/meson.build         |   21 +
> > >  drivers/event/slb/slb_evdev.c         |  904 ++++++++++++++++++
> > >  drivers/event/slb/slb_evdev.h         |  263 ++++++
> > >  drivers/event/slb/slb_event.c         | 1219 +++++++++++++++++++++++=
++
> > >  drivers/event/slb/slb_selftest.c      |  522 +++++++++++
> > >  drivers/event/slb/slb_xstats.c        |  347 +++++++
> > >  12 files changed, 3377 insertions(+)
> > >  create mode 100644 doc/guides/eventdevs/features/slb.ini
> > >  create mode 100644 doc/guides/eventdevs/slb.rst
> > >  create mode 100644 drivers/event/slb/meson.build
> > >  create mode 100644 drivers/event/slb/slb_evdev.c
> > >  create mode 100644 drivers/event/slb/slb_evdev.h
> > >  create mode 100644 drivers/event/slb/slb_event.c
> > >  create mode 100644 drivers/event/slb/slb_selftest.c
> > >  create mode 100644 drivers/event/slb/slb_xstats.c
> > >
> > > --
> > > 2.53.0
> > >
