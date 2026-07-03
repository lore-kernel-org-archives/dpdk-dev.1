Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A7BC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6CD2402C5;
	Fri,  3 Jul 2026 22:27:07 +0200 (CEST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51]) by mails.dpdk.org (Postfix) with ESMTP id 9BEAD4026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 22:27:06 +0200 (CEST)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-737de525d2eso924315137.2
 for <dev@dpdk.org>; Fri, 03 Jul 2026 13:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783110425; cv=none;
 d=google.com; s=arc-20260327;
 b=IXDTGLxjpUnFeWCGwgGeEXB+eylLR96mcwW+gm5K+zTVvvP8joGuE3ssAid2ORBXRO
 1J1lg+ONPGh8U6NswpcBjDX6o3jRO4hbase4ZeWV3JJ0+lqCVgn5pN2HBPyAaoKIRKhn
 12xSrCYedLnDAkj3SGt3GG3myyl5Dy5jvmausy5/q0mL9WGAcRkl7pwt/iZps8hnDeEU
 6hUNWggxXpMbzC+jhmOamGF7f8oAPjoaHXxB96A+IBYAM0gV0Qf4JgucjLlZpwpoi3QB
 XX5mz3wuMm3SzddMHXvSaP8pS6kO1bD1UUsPBeiKE9gMsUmVBrXvCME8og/SYpX2x0AJ
 Xpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cY4rbTPK1eJ8ScSqQEc3iKo3uo5DHFPWk1IakNs30iQ=;
 fh=HLXKSY4jf/WJhw9H10k3WAb+6gIrVPkVrrprdOReX+E=;
 b=qEIqju3mGvXVXXi0l+2eWNivLFYSkujgxA0bTPfRFP4NzcZLdIQy1HPRb1HndQNyB9
 KmPclWNq57hjILPQEn/JV6zVfdYvh3ul21P4UPzdrlRFlvzwPyUzkQT1GSR/zidewMAt
 xPr7IpkqUQM53P7PfVoUll7/J2ukGw3WE6iB+QDSLswEv9E3rJQIduA2v40eQ6NQo267
 7oHkrPNRY+YeixPfFLkGZJzEb1wfvmuKR1TKf9XBA3n/23inU3f11Pdami8+PMO1JK2O
 3FMwSiTNxfhuiYOYpEGqC8+n6spfpioN22Hv3ELJYWfPeKaBUQQmgCBQAC9ZvdNMzscv
 T1WQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783110425;
 x=1783715225; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cY4rbTPK1eJ8ScSqQEc3iKo3uo5DHFPWk1IakNs30iQ=;
 b=XKSJkDYDIfWel5PAHCUvbLv34BGz9anm0ElUsHA4aBSgrfoQ1iTZnEzIpgz5PC1gUP
 hOt826j2W9CDTeh8EqDyI8u5E51WDAOfLjyUJVIhMDGL2bRYlHh6SvEmRc/ij40Sw9LY
 ojE5sHobvjt2o22hSvqwvmlG7xtsrzN+4TuJI3mCHSdWRKhsBmQC4u87fmCH1fI5gySj
 FufIbr8Wojc73B2cprXn3fWz8xo6c5KkGoTZtdaHaNxwxH+6dnul9JtAI9rs/26zrqXB
 uGPm51/PwPlOmGULo6C2Vs/VEyKbFK8pCIr2vHEshUaPI0D5VONqVdYe5kfr0oCjCwrk
 8oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110425; x=1783715225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cY4rbTPK1eJ8ScSqQEc3iKo3uo5DHFPWk1IakNs30iQ=;
 b=WQRzdqFzyD02KWicL3bm10Jz+FVeIE+SXWgJEZNtPJzgfA2WRsNDvEa4hPf6b3zPui
 rARo8vaNzso0875D5C44glA4L5X2bpIMMpmMyQhZ6d6GFgq+/qfCabXxaFbqZiwrDV7s
 MGs+ZSMm1N6Obtzyh7fXTcOAA1UOQ7lnc4ZSAM4czKPNxYXeNElNbWfjmJZ763BmKvwb
 oGifWEiC6+aKQF475MEXtOd3pJlUk6X/J4X5N81YfyhOuuDwFzWH7+hzmRHGRz7WSQX4
 PaFQVmghut56hVGLkCXbBpW6lgdvcfxzBq/hrdq7vZT304JetVU1CGvSiXt97JpkhEv7
 +6kA==
X-Gm-Message-State: AOJu0YwqCI2UHZ9rUHpEul2wkEXCImyFP79+Q77XGT8mhaNWy9hyT3wi
 5rxBy1skFvSqWitluRtLOZHiWLyL0gNq4FY8wX1uehpOAgeVklW5s5jarJ5GhNg/FsWGyHvwE//
 /hh0qAg/ayU3DKfuj3hL9pODZsomnfIGtGHGqff2wsQ==
X-Gm-Gg: AfdE7cnwUAPcTnNTr5EK7+hajxMGRRiZSzEb+91UvZWHdU2t6mRktCBdtcO5iB1+KFG
 6uAM6ZnKjsCAvEhfc+qxP4af6uGoSGnB25ysqL/nZIsusnWQXBGqoBUUuZ6ebaA0LGiAeYJ1JFt
 a7fpuWFV7cp41ZbmxhbUGVVXXcJZs51HWJqEtaqgWJtLkgIzC6HcxAnb7F1SgM7bUqT0YsYiXS7
 0dB9YzjHdKRqV9cLjZXiRMzRdIiUHiaCa+StzGP23UMTJnybq+W/YatSatN6g/xNVzAOrG4Hw==
X-Received: by 2002:a05:6102:549f:b0:739:5cfb:50f4 with SMTP id
 ada2fe7eead31-7427d442dcemr237214137.11.1783110424716; Fri, 03 Jul 2026
 13:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260616102727.708948-1-maxime@leroys.fr>
 <20260630144329.457643-1-maxime@leroys.fr>
 <20260703090345.3e4099cd@phoenix.local>
 <CAHHRULUxDHRCQC-0fuxfjx9KvUPpJ4-QAEDr3mQQuy1jJgAGgA@mail.gmail.com>
In-Reply-To: <CAHHRULUxDHRCQC-0fuxfjx9KvUPpJ4-QAEDr3mQQuy1jJgAGgA@mail.gmail.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 3 Jul 2026 13:26:54 -0700
X-Gm-Features: AVVi8CfBC1EFKwznL3Ns8pao8exmHZ9jm628IP9GuNw8OZmgKYuPm_43ne_bN9Q
Message-ID: <CAOaVG16Uwxdjs53r4OrnFkUE7O0RhBuDHvj0X5cq0Mszp5FVSg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] net/dpaa2: NAPI-style Rx queue interrupts
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>,
 David Marchand <david.marchand@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000075f6920655babf4b"
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

--00000000000075f6920655babf4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Right I pulled it back

On Fri, Jul 3, 2026, 11:56 Maxime Leroy <maxime@leroys.fr> wrote:

> Hi Stephen,
>
> Le ven. 3 juil. 2026, 18:03, Stephen Hemminger <stephen@networkplumber.or=
g>
> a =C3=A9crit :
>
>> On Tue, 30 Jun 2026 16:43:23 +0200
>> Maxime Leroy <maxime@leroys.fr> wrote:
>>
>> > This series lets a dpaa2 worker sleep on a queue's data-availability
>> > notification instead of busy-polling, exposed through the generic
>> > rte_eth_dev_rx_intr_* API (NAPI-style: poll while frames keep coming,
>> > arm the interrupt and sleep when the queue runs dry).
>> >
>> > Why it is not a trivial .rx_queue_intr_enable
>> > ----------------------------------------------
>> > A worker wakes on its software portal's DQRI, which fires when the
>> > portal's DQRR holds frames. The default dpaa2 Rx burst pulls frames
>> > from the FQ with a volatile dequeue and cannot be interrupt-driven; to
>> > wake on the DQRI the FQ must instead be pushed to the portal's DQRR.
>> >
>> > The natural dpni_set_queue with a notification destination would have =
to
>> > target the worker's portal, but that portal is only known once a worke=
r
>> > affines, after dev_start, and that MC command holds the global MC lock
>> > long enough to wedge the firmware while traffic runs. So the bind cann=
ot
>> > be done late, against the polling lcore.
>> >
>> > Design
>> > ------
>> > Each Rx FQ is bound to its own DPCON channel, statically, at dev_start
>> > while the dpni is still disabled (no knowledge of the polling lcore). =
A
>> > worker later subscribes its own ethrx portal to the channel and arms t=
he
>> > DQRI in rx_queue_intr_enable, a one-shot per-portal op, never the
>> wedging
>> > set_queue. On a wakeup the worker drains each of its queues by a
>> volatile
>> > dequeue on the queue's own DPCON channel (one FQ per channel, so no
>> > per-frame demux); it polls all its queues, the same scheduling contrac=
t
>> > as plain DPDK polling. A queue can be re-homed to another lcore at
>> > runtime with no set_queue and no port stop.
>> >
>> > This reuses the event PMD's pushed/DQRR model but with one DPCON per F=
Q
>> > and static affinity (no QBMan scheduling), so the DPCON allocator is
>> > moved from the event driver to the fslmc bus and shared.
>> >
>> > Patch 1 disables the DPCON channel before closing it, an event/dpaa2 f=
ix
>> > the shared allocator depends on. Patches 2 to 4 move the DPCON allocat=
or
>> > to the fslmc bus, make the portal DQRI epoll optional, and add the
>> > dpcon_set_notification MC command. Patch 5 adds the interrupt support
>> > proper; patch 6 pins each DPIO's MSI to the lcore that arms it, a
>> latency
>> > optimisation.
>> >
>> > Tested on LX2160A (lx2160acex7).
>> >
>> > v3:
>> > - Reworked the Rx drain. Both versions bind one DPCON per FQ, but v2
>> >   drained the shared portal DQRR and demuxed frames to their FQ by
>> >   fqd_ctx, stashing foreign frames in a per-queue FIFO. v3 drains each
>> >   queue with a volatile dequeue on its own channel (one FQ per channel=
),
>> >   which drops the demux and stash code.
>> > - Dropped the rx_queue_count fix; it is applied to main.
>> > - Dropped the software VLAN strip patch; an independent net/dpaa2
>> cleanup,
>> >   sent standalone and now applied to next-net.
>> > - Dropped the Depends-on: the ethdev fast-path ops fix is now in main.
>> > - Split the dpcon_set_notification MC command into its own patch.
>> > - Added an event/dpaa2 fix to disable the DPCON channel before close,
>> >   needed once the allocator is shared.
>> > - Dropped the DQRI holdoff-tuning patch; the immediate-DQRI holdoff is
>> now
>> >   set inline in the arm path.
>> > - Added a patch reusing the event driver's MSI-affinity helper (expose=
d
>> >   from its RTE_EVENT_DPAA2 guard) to pin the portal MSI to the lcore
>> that
>> >   arms it, so a CDAN wake lands on the worker's own core.
>> >
>> > v2:
>> > - Dropped the RSS RETA patch, an independent net/dpaa2 change the
>> >   interrupt path does not require; it will be sent as its own series.
>> > - Dropped the ethdev fast-path ops fix; it is now a standalone series.
>> > - Dropped the eal/interrupts -EEXIST fix, applied to main by David
>> >   Marchand.
>> > - Declared qbman_swp_interrupt_set_inhibit and qbman_swp_dqrr_size
>> >   __rte_internal (David Marchand).
>> > - Minor formatting cleanup in the Rx interrupt setup.
>> >
>> > Maxime Leroy (6):
>> >   event/dpaa2: disable channel before closing it
>> >   bus/fslmc: move DPCON management from event driver to bus
>> >   bus/fslmc/dpio: make the portal DQRI epoll optional
>> >   bus/fslmc/mc: implement dpcon_set_notification
>> >   net/dpaa2: support Rx queue interrupts
>> >   net/dpaa2: pin Rx queue interrupt to the polling core
>> >
>> >  doc/guides/nics/dpaa2.rst                     |  21 +
>> >  doc/guides/nics/features/dpaa2.ini            |   1 +
>> >  doc/guides/rel_notes/release_26_07.rst        |   1 +
>> >  drivers/bus/fslmc/mc/dpcon.c                  |  31 ++
>> >  drivers/bus/fslmc/mc/fsl_dpcon.h              |  18 +
>> >  drivers/bus/fslmc/meson.build                 |   1 +
>> >  .../fslmc/portal}/dpaa2_hw_dpcon.c            |  17 +-
>> >  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      | 112 ++++--
>> >  drivers/bus/fslmc/portal/dpaa2_hw_dpio.h      |  12 +
>> >  drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |  12 +
>> >  .../fslmc/qbman/include/fsl_qbman_portal.h    |   5 +
>> >  drivers/bus/fslmc/qbman/qbman_portal.c        |   5 +
>> >  drivers/event/dpaa2/dpaa2_eventdev.h          |   3 -
>> >  drivers/event/dpaa2/meson.build               |   1 -
>> >  drivers/net/dpaa2/dpaa2_ethdev.c              | 372 +++++++++++++++++=
-
>> >  drivers/net/dpaa2/dpaa2_ethdev.h              |   4 +
>> >  drivers/net/dpaa2/dpaa2_rxtx.c                | 104 +++--
>> >  17 files changed, 649 insertions(+), 71 deletions(-)
>> >  rename drivers/{event/dpaa2 =3D> bus/fslmc/portal}/dpaa2_hw_dpcon.c (=
88%)
>> >
>> >
>> > base-commit: 030328f5f920a87dabde54dacd4f5ac411ddcac9
>>
>> Looks good, applied to net-next
>
>
> Thanks for the merge.
>
> But this patchset have not been acked by Hemant. Right now, Hemant have
> asked some fixes on this serie. Hemant also said it needs some time to te=
st
> it.
>
>

--00000000000075f6920655babf4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Right I pulled it back</div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 3=
, 2026, 11:56 Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr">maxime@l=
eroys.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"auto"><div>Hi Stephen,=C2=A0<br><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le ven. 3 juil. 2026, 18:03, =
Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org" target=
=3D"_blank" rel=3D"noreferrer">stephen@networkplumber.org</a>&gt; a =C3=A9c=
rit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tu=
e, 30 Jun 2026 16:43:23 +0200<br>
Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">maxime@leroys.fr</a>&gt; wrote:<br>
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
br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
</blockquote></div></div></div>
</blockquote></div>

--00000000000075f6920655babf4b--
