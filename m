Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5468606A32C
	for <dpdk-dev@archiver.kernel.org>; Sat,  7 Nov 2026 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1/M5owa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D7CD4042E;
	Sat,  7 Nov 2026 08:29:49 +0100 (CET)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 2FD6B402F0
 for <dev@dpdk.org>; Sat,  7 Nov 2026 08:29:47 +0100 (CET)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-67c05273c38so1400623d50.1
 for <dev@dpdk.org>; Fri, 06 Nov 2026 23:29:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794036586; cv=none;
 d=google.com; s=arc-20260327;
 b=Mj5aHlpzC707CepA0RtfKz+piTt5coc1o28rrHn80cWYqH3qZF6V3sLKZdYcqD3h9Q
 hkdgIdGP3WOm44spw1jsPLg4GdbYTx7DP3rNOC6H6l7tN9qCNUCLg7TVmOrpwKb8F/i0
 I87BmwFWW3ZIhZNFM97Oqx9D6bC9b0x3qU7GQl85S1RWxCHMtxzt59MuzPWyvS6avPP0
 pMJs4v9Z8PeMTavcNB/pu9WWVc4PovjHEZxtlxxXHeLUYAgpSWYWzr1i2CkyorZy24dn
 h3tR5a9kbzqiWiZSmoes+nvCrdTRjft7H8HK40Lu4YT9O4hJVLsavI0J0wvHpW9DPtO5
 8sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w+HJoZ7AU7u52Sv6kXrapJFKo23C+8oT140rb/5Yy/M=;
 fh=jY9biCy3mNGHIKQKx/NtaPv6t0HSv9+YXlHbm53BlLY=;
 b=VSmbEbV3HY1A9q7/tp+auD22FlmYxzIrHfnPQ9dN7SufMj2XhLb8vlf7dKTT6N5tzD
 7o6HrAr0WQsDl6Je1Jfxg0JFWVNx3U1aPumhLlibmeA6k5TNe5t3cFJA7wqEmTSSCHDM
 NL3D/Iv1ejlAWuoH1cx6eh3Hqa+GSCR+pc/8kTpnhj/oHtA3FJvo4VKRrtKntm8buQdk
 +Wm0QSKiywAiNiP736TSgkTjxqXssu+AaxPbCMpI8jHjo64aodUWB+hO+NhHrPh0nr1K
 L2CAA4GcojBsWHMrtfqbf/WNZSJd45bIhceIXE73/Q/40qBubhaYRehPhoWndDwevDFk
 cW3w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794036586; x=1794641386; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w+HJoZ7AU7u52Sv6kXrapJFKo23C+8oT140rb/5Yy/M=;
 b=Y1/M5owa0AfIKwg3imkMPr88sdsV8L3mndPBHR1u2cM6IJBulk7lKqgW3rH3ZFipmA
 iT/U4TGzMhfjNVDQ6xxAXwYgMAz/jRE1DEA/5PKtjtBqgYh/JpfOGxoxXedhZMYbr3se
 klQWrK/gfHFjUtW6OXvOf02TbszWZ/YIoie8qKr1Ksn4myUbSKkcetGDJ87un5qu4PvG
 nnu19/ss8EfI2EeYeh2yfeQ/sgm19ID/5FxFHqedrMy0HO2p9gTKVM++dZP4T1UEEtnk
 mta3qBLp5vh/3Omm2kh3tHEcxoDzq2y3vtIYYqGfgsEmidv+OOy25TvAo8Df3VIvzEuN
 fbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036586; x=1794641386;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w+HJoZ7AU7u52Sv6kXrapJFKo23C+8oT140rb/5Yy/M=;
 b=ZijZ69EBEhfUWMjjfq+7eOYRdNjE8U+E7TYRMEmMJnb6+U7kUVgEehGAFshRHUyrOM
 ljeeKpBgvxy0r/nbWQ45W9pqniVp1lmwLb5jwEbGDzHSfp6w0ZLpiHW+0SZ2iGSu2muy
 miUsPfjUA/6qY0RatEC1RrN+BlfOxSu9O5AKJ8q7Cmu90xkuYiFwAgBz99DLfNQhKxGx
 wU0ISJqvmRXw9IcvWSn++9b2QBQ2NNYxbr1YgTAj1flD3jeh0OFjhm5VQWOETj+79CDR
 laauaYydekqTRBZlNEaBAbyZzv9QzRaPx5Uzthq/PmDHMVvrsYqKYwRTmYD6X2lt+YiQ
 JY+A==
X-Gm-Message-State: APuU4Z/E1/TD5cJG3BhSp/N+bmFc7PYm1b4VXfbigg3H9cgJ1HTpGgCT
 5ujeG/DlHQ9sJlHSQMwLNvk6E/oIA+nzJlcdl+z4Om4OY4reg9U8L+zYSc0OTUJjNQmOEmOvGd/
 /h3NGwcQyYe0nxjkt9fxJrT41EgB6Euw=
X-Gm-Gg: AYBFou005R7q0lvUww3fbUZFaXhnhwCOmTkTUBHVwyx9HNPmv307EYFW//A0CamFqEF
 Req/ZBT0wj2oixnziqJgfYO15aJoqhkLocvqRmD+KXn1WlgmVzIAyo54GnfuK8CaqOK4Ii56n6S
 WTYEh3hIGMWW+fOOfUJ9GPJTCvlJKqjOb/uYbRKJMFEX+cdw/MrIhq5zbRJ6FtPhkWzWSMjTfMq
 v/ugItnWgFxCoCKl0fZJB0QE6MHETkoFBOGNIsW3fn8GaY8EuXPMvK54u/99g8Vqvv+FYgAskZL
 ODUdH8sCjtQY3SL4GIkPuh7/vFUELPNz1Nf6itvzxoRKkKnIycQBk9VfjowxBXfgKwErVJ9lZCc
 QYoOMtXa/uanEVWVJC7+EduY5XChD1RGAx/QmIC0WcArWe7FY5wLaoCnst/u+5jXV1HXN5oO1sY
 6c0Aayz0cFoxoH9oDROuW2H60vo/6zEynATOb4RHinqHwWJo/iLK5yWCY8ViZMYNDTA88PVS12d
 MkcbmotFeUgcMxZlqUXYj0=
X-Received: by 2002:a05:690e:1444:b0:679:b50e:9a with SMTP id
 956f58d0204a3-67c146979bfmr3109797d50.108.1794036585804; Fri, 06 Nov 2026
 23:29:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
In-Reply-To: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Sat, 7 Nov 2026 12:59:18 +0530
X-Gm-Features: AclHuK9J2e-P_APM4huGikVzXa-BWUMkljA4NDgM1Bn8GW_IYH2vVZsT1eWJWfM
Message-ID: <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
To: Pravin Pathak <pravinpathakdev@gmail.com>, mattias.ronnblom@ericcson.com
Cc: dev@dpdk.org, jerinj@marvell.com, mike.ximing.chen@intel.com, 
 bruce.richardson@intel.com, thomas@monjalon.net, david.marchand@redhat.com, 
 nipun.gupta@amd.com, chenbox@nvidia.com, tirthendu.sarkar@intel.com, 
 Pravin Pathak <pravin.pathak.dev@gmail.com>
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

On Sat, Nov 7, 2026 at 7:00=E2=80=AFAM Pravin Pathak <pravinpathakdev@gmail=
.com> wrote:
>
> From: Pravin Pathak <pravin.pathak.dev@gmail.com>
>
> This series introduces the Software Load Balancer (SLB) Eventdev PMD
> (`event_slb`) supporting parallel, atomic and ordered queues. It is
> a distributed software scheduler that scales well.
>
> Motivation
> ----------
> Existing software eventdev PMDs face trade-offs between centralized
> bottlenecks and feature coverage:
> - `event_sw` relies on a dedicated centralized scheduler consuming
>   an extra CPU core. The single scheduling core also limits maximum
>   throughput and it does not scale.
> - `event_dsw` distributes scheduling across worker cores without a
>   central scheduler core, but does not support ordered queues and
>   incurs per-port control ring messaging overhead during atomic flow
>   migrations. It also does not support service priority.
>
> Design Overview
> ---------------
> `event_slb` is a distributed (`RTE_EVENT_DEV_CAP_DISTRIBUTED_SCHED`),
> maintenance-free (`RTE_EVENT_DEV_CAP_MAINTENANCE_FREE`) software eventdev
> PMD that supports Atomic, Ordered, Parallel, and Single-Link queues:

@mattias.ronnblom@ericcson.com  - drivers/event/dsw/
@liangma@liangbit.com - drivers/event/opdl/
NO MAINTAINER for drivers/event/sw/

Hi Pravin,
Creating new flavours. of evendev SW drivers is a maintenance burden,
If this is close to DSW then please introduce mode in DSW driver and
have function pointer switches for fastpath,
Also claim should be backed by performance test values. Use
testeventdev test cases and share the numbers to prove one way or
another.

In summary, IMO, it better to take NEW SW PMD when
a)It operates completely different than DSW and SW and it is NOT
possible to update existing SW PMDs
b)Able to show better performance than existing drivers on the specific cas=
es.


>
> 1. Queue-Centric Ring Architecture:
>    - Parallel and Single-Link queues map directly to `rte_event_ring`
>      instances (MP/MC for parallel, MP/SC for single-link), allowing
>      zero-copy burst enqueue and dequeue without history tracking.
>    - Ordered queues use the ring slot index at dequeue time as an implici=
t
>      sequence number into a per-queue reorder buffer, draining contiguous
>      completed events in order without global sequence counters. This
>          makes ordered queue implementaion highly efficient performing cl=
ose
>          to parallel queues.
>    - Atomic queues use a main MP/SC queue ring alongside per-port SP/SC
>      rings and a 2048-entry flow-to-port affinity table. All cores
>          served by the atomic queue are used for scheduling.
>
> 2. Lock-Free / Zero-Pause Atomic Flow Migration:
>    - When an atomic queue refills per-port rings and detects persistent
>      congestion on a destination port, SLB selects the lightest flow on
>      that port (outside the migration cooldown window) and waits for
>          queues in-flight events to drain naturally before switching the
>          flow's port affinity and schedule hold-buffer entries.
>    - Hold buffer is used for buffering events towards migrating ports
>      while allowing serving other ports.
>    - Implementaion avoids cross-port pause/unpause control rings while
>      preserving strict per-flow ordering.
>
> 3. Credit-Based Backpressure & Priority Scheduling:
>    - A global atomic credit pool with per-port local credit caches bounds
>      total in-flight events (`nb_events_limit`) and enforces
>          `new_event_threshold` with minimal atomic contention.
>    - Ports support two strict service priority levels with
>      round-robin scheduling within each priority level.
>
> 4. Observability & Testing:
>    - Device and per-port/per-queue extended statistics (`xstats`),
>      detailed `rte_event_dev_dump()` diagnostics, and a unit self-test
>      suite (`eventdev_selftest_slb`) covering parallel, atomic, ordered,
>      single-link, priority, backpressure, stop-flush, and multi-core
>      atomic migration scenarios.
>
> 5. Future Plan:
>    - Supporting Event priority
>    - Optimizing atomic flow migration
>
> Pravin Pathak (8):
>   event/slb: introduce software load balancer PMD
>   event/slb: add support for ordered queues
>   event/slb: add support for atomic queues
>   event/slb: add dynamic flow migration for atomic queues
>   event/slb: add extended statistics and diagnostics
>   event/slb: add self-test and documentation
>   event/slb: update resets and credit defaults
>   event/slb: improve port linking, config checks and atomic refill
>
>  MAINTAINERS                           |    6 +
>  app/test/test_eventdev.c              |    7 +
>  doc/guides/eventdevs/features/slb.ini |   25 +
>  doc/guides/eventdevs/index.rst        |    1 +
>  doc/guides/eventdevs/slb.rst          |   61 ++
>  drivers/event/meson.build             |    1 +
>  drivers/event/slb/meson.build         |   21 +
>  drivers/event/slb/slb_evdev.c         |  904 ++++++++++++++++++
>  drivers/event/slb/slb_evdev.h         |  263 ++++++
>  drivers/event/slb/slb_event.c         | 1219 +++++++++++++++++++++++++
>  drivers/event/slb/slb_selftest.c      |  522 +++++++++++
>  drivers/event/slb/slb_xstats.c        |  347 +++++++
>  12 files changed, 3377 insertions(+)
>  create mode 100644 doc/guides/eventdevs/features/slb.ini
>  create mode 100644 doc/guides/eventdevs/slb.rst
>  create mode 100644 drivers/event/slb/meson.build
>  create mode 100644 drivers/event/slb/slb_evdev.c
>  create mode 100644 drivers/event/slb/slb_evdev.h
>  create mode 100644 drivers/event/slb/slb_event.c
>  create mode 100644 drivers/event/slb/slb_selftest.c
>  create mode 100644 drivers/event/slb/slb_xstats.c
>
> --
> 2.53.0
>
