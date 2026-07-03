Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FACDC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 18:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F09E6402C5;
	Fri,  3 Jul 2026 20:56:45 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id AED804026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 20:56:44 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-8000e21f014so10994237b3.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 11:56:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783105004; cv=none;
 d=google.com; s=arc-20260327;
 b=ggruYVjetc0aTcotTjTcS5aO38jltksemyHpdo0fGE9iFvqclluDDY8XAAu79+SSfz
 qlQcjejd6+JsE49fGtib6kqUQsVgErDCJlg2ByDgspqa0DNtCoNjOtqIOoOK6aGLK3Z4
 CSR6PLaHauUH/gYn3jpoVnMIyQPasv7WJX81Nn+FPIL74h+3P5C5gSR4y88bbusfuefY
 2w1G88/11uYalafK/GMWzkSu/kQxt04i42AI5unCo4bQUexWpg//cdZ31ij8LeGiWafd
 f1FbJ5SPc1UWgPfnAaNjw/iwWEtB079jBVSmxBmiypj3mgEAUUFOHWV0EaCuEgtefCpl
 Uk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=oY55OIROpS7bcEL1IXNkwUPG3rsiG25LQTQ3HTIv5WY=;
 fh=rCfiINuRmtObFMhdg243Hh01bmeohFqFPqsHG1kBLPs=;
 b=nq+NAG6l7weNBoQn+HqIgrPwxWCXDl2BxB3n+NE4f0lWwanz+5ke9RJCBlFQeLy/mh
 uQFr1KqpIH9f5fElFsUD2nF/Obe3kaAmRUBQAZU9IjyLFngVyVBfHAoMh7YgGmGeLPBR
 64UXJBqyTJAGGaOz5AIaUkLTjx7r9ecMNQFihRKShp7iFzrDwIm10DZL7MzJyXmJu3Lj
 z376yKKZK0EZIopffhpD3MadlILr4vsz+OuXiHDuYNf9b/8ia/ju3f9AAu5eQgXci/64
 t2sO71dwvyWzmAF/aRj9GiWl5AfKdTjS7c5YJZ5CwKmICWXWV42VJ5HNRelrj0WMhsYP
 seaA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783105004; x=1783709804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY55OIROpS7bcEL1IXNkwUPG3rsiG25LQTQ3HTIv5WY=;
 b=GqzcEinIqWK/t4raCLpJfPfcvBvLA+WqBISSe1CL+Cwv8TURjAQTGP0G26K8RAYgOj
 AyA6Nxzx/J9ASCNi8DsT4FYZxtE4Injd5/PP3gyd/ldKJFWLZlPgs7tGDY3uJGjYaXgO
 HxhjGSN4ZiqB96ujvpUnIFL3sFwL1f5giRPREFdNYXLjndcYs/ErGX7u6fz3yJ45odIy
 kZ2lbvpQQpoTtDaZ/d5ufy1VKd6SgoEMv3H15APP5oqcf5h3AmAYwHzDQwqbj3/PEN5g
 y0hAkPeIe6k0MrJjDTfKqPIhDqf77a1It3WDTGxqKfqFr2M5ClhJ7O8zufbfLQu5zZ2v
 znuw==
X-Gm-Message-State: AOJu0YwBd4+gpeYtGm30IlI1N9GBeEQRRyv87ww3LmLL/sMHl+aQL2c8
 1Tz0TPd/eOQ1uxQS9D0lr0IeJN8JRXQJFYG7csGIO8kbN/EXXBSw/kYZc2pWxIC+kAYAVl7l9ce
 yKvYvIQnnUriIN3hMS3/i1+cRVLPCv6g=
X-Gm-Gg: AfdE7cl7RiveB6Bp7CIpZUc+bY//qAum5s/uMNGmU+IVfKe6BsAlLWrrU+JwgB/aT53
 civgieLQR41cw1thVeO5DwOHo0hEOEB3nLpiX/QNu+fhLwgK3BAHnkKL4Fvbdqc0zKMIcq082mm
 45ILp8fcxdsZs8UZKcq3+v3dFtBxxvgDmz4WRekdUG+1D4xfqLYxgda2I2TIhz0IdgOK/+nfp9n
 gk3gLSGp/wGOR0ZgCsNdqzeGfHvt8hFg2MQ8fAfIgHECjpIV/nTRJ5YBkklor9nULhOOt8M/dPK
 i1cgiVSyNalymxEZr6j5bDdJ0hOvXQ==
X-Received: by 2002:a05:690c:c4e3:b0:80c:85c6:898b with SMTP id
 00721157ae682-81739ee7cbfmr5181007b3.58.1783105003899; Fri, 03 Jul 2026
 11:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
 <20260703090345.3e4099cd@phoenix.local>
In-Reply-To: <20260703090345.3e4099cd@phoenix.local>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 3 Jul 2026 20:56:32 +0200
X-Gm-Features: AVVi8CcEJD8hEsDj89h03BIYuBoE8Y8FJwV4mDmRpiFZoWeWfIOuWNCQDwIHPgY
Message-ID: <CAHHRULUxDHRCQC-0fuxfjx9KvUPpJ4-QAEDr3mQQuy1jJgAGgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] net/dpaa2: NAPI-style Rx queue interrupts
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>,
 David Marchand <david.marchand@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005acfc70655b97c40"
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

--0000000000005acfc70655b97c40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Le ven. 3 juil. 2026, 18:03, Stephen Hemminger <stephen@networkplumber.org>
a =C3=A9crit :

> On Tue, 30 Jun 2026 16:43:23 +0200
> Maxime Leroy <maxime@leroys.fr> wrote:
>
> > This series lets a dpaa2 worker sleep on a queue's data-availability
> > notification instead of busy-polling, exposed through the generic
> > rte_eth_dev_rx_intr_* API (NAPI-style: poll while frames keep coming,
> > arm the interrupt and sleep when the queue runs dry).
> >
> > Why it is not a trivial .rx_queue_intr_enable
> > ----------------------------------------------
> > A worker wakes on its software portal's DQRI, which fires when the
> > portal's DQRR holds frames. The default dpaa2 Rx burst pulls frames
> > from the FQ with a volatile dequeue and cannot be interrupt-driven; to
> > wake on the DQRI the FQ must instead be pushed to the portal's DQRR.
> >
> > The natural dpni_set_queue with a notification destination would have t=
o
> > target the worker's portal, but that portal is only known once a worker
> > affines, after dev_start, and that MC command holds the global MC lock
> > long enough to wedge the firmware while traffic runs. So the bind canno=
t
> > be done late, against the polling lcore.
> >
> > Design
> > ------
> > Each Rx FQ is bound to its own DPCON channel, statically, at dev_start
> > while the dpni is still disabled (no knowledge of the polling lcore). A
> > worker later subscribes its own ethrx portal to the channel and arms th=
e
> > DQRI in rx_queue_intr_enable, a one-shot per-portal op, never the wedgi=
ng
> > set_queue. On a wakeup the worker drains each of its queues by a volati=
le
> > dequeue on the queue's own DPCON channel (one FQ per channel, so no
> > per-frame demux); it polls all its queues, the same scheduling contract
> > as plain DPDK polling. A queue can be re-homed to another lcore at
> > runtime with no set_queue and no port stop.
> >
> > This reuses the event PMD's pushed/DQRR model but with one DPCON per FQ
> > and static affinity (no QBMan scheduling), so the DPCON allocator is
> > moved from the event driver to the fslmc bus and shared.
> >
> > Patch 1 disables the DPCON channel before closing it, an event/dpaa2 fi=
x
> > the shared allocator depends on. Patches 2 to 4 move the DPCON allocato=
r
> > to the fslmc bus, make the portal DQRI epoll optional, and add the
> > dpcon_set_notification MC command. Patch 5 adds the interrupt support
> > proper; patch 6 pins each DPIO's MSI to the lcore that arms it, a laten=
cy
> > optimisation.
> >
> > Tested on LX2160A (lx2160acex7).
> >
> > v3:
> > - Reworked the Rx drain. Both versions bind one DPCON per FQ, but v2
> >   drained the shared portal DQRR and demuxed frames to their FQ by
> >   fqd_ctx, stashing foreign frames in a per-queue FIFO. v3 drains each
> >   queue with a volatile dequeue on its own channel (one FQ per channel)=
,
> >   which drops the demux and stash code.
> > - Dropped the rx_queue_count fix; it is applied to main.
> > - Dropped the software VLAN strip patch; an independent net/dpaa2
> cleanup,
> >   sent standalone and now applied to next-net.
> > - Dropped the Depends-on: the ethdev fast-path ops fix is now in main.
> > - Split the dpcon_set_notification MC command into its own patch.
> > - Added an event/dpaa2 fix to disable the DPCON channel before close,
> >   needed once the allocator is shared.
> > - Dropped the DQRI holdoff-tuning patch; the immediate-DQRI holdoff is
> now
> >   set inline in the arm path.
> > - Added a patch reusing the event driver's MSI-affinity helper (exposed
> >   from its RTE_EVENT_DPAA2 guard) to pin the portal MSI to the lcore th=
at
> >   arms it, so a CDAN wake lands on the worker's own core.
> >
> > v2:
> > - Dropped the RSS RETA patch, an independent net/dpaa2 change the
> >   interrupt path does not require; it will be sent as its own series.
> > - Dropped the ethdev fast-path ops fix; it is now a standalone series.
> > - Dropped the eal/interrupts -EEXIST fix, applied to main by David
> >   Marchand.
> > - Declared qbman_swp_interrupt_set_inhibit and qbman_swp_dqrr_size
> >   __rte_internal (David Marchand).
> > - Minor formatting cleanup in the Rx interrupt setup.
> >
> > Maxime Leroy (6):
> >   event/dpaa2: disable channel before closing it
> >   bus/fslmc: move DPCON management from event driver to bus
> >   bus/fslmc/dpio: make the portal DQRI epoll optional
> >   bus/fslmc/mc: implement dpcon_set_notification
> >   net/dpaa2: support Rx queue interrupts
> >   net/dpaa2: pin Rx queue interrupt to the polling core
> >
> >  doc/guides/nics/dpaa2.rst                     |  21 +
> >  doc/guides/nics/features/dpaa2.ini            |   1 +
> >  doc/guides/rel_notes/release_26_07.rst        |   1 +
> >  drivers/bus/fslmc/mc/dpcon.c                  |  31 ++
> >  drivers/bus/fslmc/mc/fsl_dpcon.h              |  18 +
> >  drivers/bus/fslmc/meson.build                 |   1 +
> >  .../fslmc/portal}/dpaa2_hw_dpcon.c            |  17 +-
> >  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 112 ++++--
> >  drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |  12 +
> >  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  12 +
> >  .../fslmc/qbman/include/fsl_qbman_portal.h    |   5 +
> >  drivers/bus/fslmc/qbman/qbman_portal.c        |   5 +
> >  drivers/event/dpaa2/dpaa2_eventdev.h          |   3 -
> >  drivers/event/dpaa2/meson.build               |   1 -
> >  drivers/net/dpaa2/dpaa2_ethdev.c              | 372 +++++++++++++++++-
> >  drivers/net/dpaa2/dpaa2_ethdev.h              |   4 +
> >  drivers/net/dpaa2/dpaa2_rxtx.c                | 104 +++--
> >  17 files changed, 649 insertions(+), 71 deletions(-)
> >  rename drivers/{event/dpaa2 =3D> bus/fslmc/portal}/dpaa2_hw_dpcon.c (8=
8%)
> >
> >
> > base-commit: 030328f5f920a87dabde54dacd4f5ac411ddcac9
>
> Looks good, applied to net-next


Thanks for the merge.

But this patchset have not been acked by Hemant. Right now, Hemant have
asked some fixes on this serie. Hemant also said it needs some time to test
it.

--0000000000005acfc70655b97c40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Stephen,=C2=A0<br><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le ven. 3 juil.=
 2026, 18:03, Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumbe=
r.org">stephen@networkplumber.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On Tue, 30 Jun 2026 16:43:23 +0200<br>
Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr" target=3D"_blank" rel=
=3D"noreferrer">maxime@leroys.fr</a>&gt; wrote:<br>
<br>
&gt; This series lets a dpaa2 worker sleep on a queue&#39;s data-availabili=
ty<br>
&gt; notification instead of busy-polling, exposed through the generic<br>
&gt; rte_eth_dev_rx_intr_* API (NAPI-style: poll while frames keep coming,<=
br>
&gt; arm the interrupt and sleep when the queue runs dry).<br>
&gt; <br>
&gt; Why it is not a trivial .rx_queue_intr_enable<br>
&gt; ----------------------------------------------<br>
&gt; A worker wakes on its software portal&#39;s DQRI, which fires when the=
<br>
&gt; portal&#39;s DQRR holds frames. The default dpaa2 Rx burst pulls frame=
s<br>
&gt; from the FQ with a volatile dequeue and cannot be interrupt-driven; to=
<br>
&gt; wake on the DQRI the FQ must instead be pushed to the portal&#39;s DQR=
R.<br>
&gt; <br>
&gt; The natural dpni_set_queue with a notification destination would have =
to<br>
&gt; target the worker&#39;s portal, but that portal is only known once a w=
orker<br>
&gt; affines, after dev_start, and that MC command holds the global MC lock=
<br>
&gt; long enough to wedge the firmware while traffic runs. So the bind cann=
ot<br>
&gt; be done late, against the polling lcore.<br>
&gt; <br>
&gt; Design<br>
&gt; ------<br>
&gt; Each Rx FQ is bound to its own DPCON channel, statically, at dev_start=
<br>
&gt; while the dpni is still disabled (no knowledge of the polling lcore). =
A<br>
&gt; worker later subscribes its own ethrx portal to the channel and arms t=
he<br>
&gt; DQRI in rx_queue_intr_enable, a one-shot per-portal op, never the wedg=
ing<br>
&gt; set_queue. On a wakeup the worker drains each of its queues by a volat=
ile<br>
&gt; dequeue on the queue&#39;s own DPCON channel (one FQ per channel, so n=
o<br>
&gt; per-frame demux); it polls all its queues, the same scheduling contrac=
t<br>
&gt; as plain DPDK polling. A queue can be re-homed to another lcore at<br>
&gt; runtime with no set_queue and no port stop.<br>
&gt; <br>
&gt; This reuses the event PMD&#39;s pushed/DQRR model but with one DPCON p=
er FQ<br>
&gt; and static affinity (no QBMan scheduling), so the DPCON allocator is<b=
r>
&gt; moved from the event driver to the fslmc bus and shared.<br>
&gt; <br>
&gt; Patch 1 disables the DPCON channel before closing it, an event/dpaa2 f=
ix<br>
&gt; the shared allocator depends on. Patches 2 to 4 move the DPCON allocat=
or<br>
&gt; to the fslmc bus, make the portal DQRI epoll optional, and add the<br>
&gt; dpcon_set_notification MC command. Patch 5 adds the interrupt support<=
br>
&gt; proper; patch 6 pins each DPIO&#39;s MSI to the lcore that arms it, a =
latency<br>
&gt; optimisation.<br>
&gt; <br>
&gt; Tested on LX2160A (lx2160acex7).<br>
&gt; <br>
&gt; v3:<br>
&gt; - Reworked the Rx drain. Both versions bind one DPCON per FQ, but v2<b=
r>
&gt;=C2=A0 =C2=A0drained the shared portal DQRR and demuxed frames to their=
 FQ by<br>
&gt;=C2=A0 =C2=A0fqd_ctx, stashing foreign frames in a per-queue FIFO. v3 d=
rains each<br>
&gt;=C2=A0 =C2=A0queue with a volatile dequeue on its own channel (one FQ p=
er channel),<br>
&gt;=C2=A0 =C2=A0which drops the demux and stash code.<br>
&gt; - Dropped the rx_queue_count fix; it is applied to main.<br>
&gt; - Dropped the software VLAN strip patch; an independent net/dpaa2 clea=
nup,<br>
&gt;=C2=A0 =C2=A0sent standalone and now applied to next-net.<br>
&gt; - Dropped the Depends-on: the ethdev fast-path ops fix is now in main.=
<br>
&gt; - Split the dpcon_set_notification MC command into its own patch.<br>
&gt; - Added an event/dpaa2 fix to disable the DPCON channel before close,<=
br>
&gt;=C2=A0 =C2=A0needed once the allocator is shared.<br>
&gt; - Dropped the DQRI holdoff-tuning patch; the immediate-DQRI holdoff is=
 now<br>
&gt;=C2=A0 =C2=A0set inline in the arm path.<br>
&gt; - Added a patch reusing the event driver&#39;s MSI-affinity helper (ex=
posed<br>
&gt;=C2=A0 =C2=A0from its RTE_EVENT_DPAA2 guard) to pin the portal MSI to t=
he lcore that<br>
&gt;=C2=A0 =C2=A0arms it, so a CDAN wake lands on the worker&#39;s own core=
.<br>
&gt; <br>
&gt; v2:<br>
&gt; - Dropped the RSS RETA patch, an independent net/dpaa2 change the<br>
&gt;=C2=A0 =C2=A0interrupt path does not require; it will be sent as its ow=
n series.<br>
&gt; - Dropped the ethdev fast-path ops fix; it is now a standalone series.=
<br>
&gt; - Dropped the eal/interrupts -EEXIST fix, applied to main by David<br>
&gt;=C2=A0 =C2=A0Marchand.<br>
&gt; - Declared qbman_swp_interrupt_set_inhibit and qbman_swp_dqrr_size<br>
&gt;=C2=A0 =C2=A0__rte_internal (David Marchand).<br>
&gt; - Minor formatting cleanup in the Rx interrupt setup.<br>
&gt; <br>
&gt; Maxime Leroy (6):<br>
&gt;=C2=A0 =C2=A0event/dpaa2: disable channel before closing it<br>
&gt;=C2=A0 =C2=A0bus/fslmc: move DPCON management from event driver to bus<=
br>
&gt;=C2=A0 =C2=A0bus/fslmc/dpio: make the portal DQRI epoll optional<br>
&gt;=C2=A0 =C2=A0bus/fslmc/mc: implement dpcon_set_notification<br>
&gt;=C2=A0 =C2=A0net/dpaa2: support Rx queue interrupts<br>
&gt;=C2=A0 =C2=A0net/dpaa2: pin Rx queue interrupt to the polling core<br>
&gt; <br>
&gt;=C2=A0 doc/guides/nics/dpaa2.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 21 +<br>
&gt;=C2=A0 doc/guides/nics/features/dpaa2.ini=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 doc/guides/rel_notes/release_26_07.rst=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/bus/fslmc/mc/dpcon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 31 ++<br>
&gt;=C2=A0 drivers/bus/fslmc/mc/fsl_dpcon.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 18 +<br>
&gt;=C2=A0 drivers/bus/fslmc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 .../fslmc/portal}/dpaa2_hw_dpcon.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 17 +-<br>
&gt;=C2=A0 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c=C2=A0 =C2=A0 =C2=A0 | 1=
12 ++++--<br>
&gt;=C2=A0 drivers/bus/fslmc/portal/dpaa2_hw_dpio.h=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 12 +<br>
&gt;=C2=A0 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 12 +<br>
&gt;=C2=A0 .../fslmc/qbman/include/fsl_qbman_portal.h=C2=A0 =C2=A0 |=C2=A0 =
=C2=A05 +<br>
&gt;=C2=A0 drivers/bus/fslmc/qbman/qbman_portal.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 drivers/event/dpaa2/dpaa2_eventdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A03 -<br>
&gt;=C2=A0 drivers/event/dpaa2/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 -<br>
&gt;=C2=A0 drivers/net/dpaa2/dpaa2_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 372 +++++++++++++++++-<br>
&gt;=C2=A0 drivers/net/dpaa2/dpaa2_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt;=C2=A0 drivers/net/dpaa2/dpaa2_rxtx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 104 +++--<br>
&gt;=C2=A0 17 files changed, 649 insertions(+), 71 deletions(-)<br>
&gt;=C2=A0 rename drivers/{event/dpaa2 =3D&gt; bus/fslmc/portal}/dpaa2_hw_d=
pcon.c (88%)<br>
&gt; <br>
&gt; <br>
&gt; base-commit: 030328f5f920a87dabde54dacd4f5ac411ddcac9<br>
<br>
Looks good, applied to net-next</blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Thanks for the merge.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"></div><div dir=3D"auto">But this patchset have not=
 been acked by Hemant. Right now, Hemant have asked some fixes on this seri=
e. Hemant also said it needs some time to test it.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--0000000000005acfc70655b97c40--
