Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0126C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:44:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CE9340264;
	Mon, 30 Jun 2025 13:44:26 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5E6734025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:44:25 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4a43afb04a7so12899161cf.0
 for <dev@dpdk.org>; Mon, 30 Jun 2025 04:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751283864; x=1751888664; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd5yGqmxGQLqfUZ7NeQdfpQZmVwBIYDuFQ5x+5IASK0=;
 b=RnebFTuClP2FBoHoJKycgpLU4voTvHDbkxItONj7VsQOxPp5h26tvbWBAVonuO1pBs
 HoXxzaeFxLnNYqcStQ+XkK1MxBxRcn09rjJD4TZ0G5sdtQWfb6OFaBbX8T9HEkZGZmeN
 eECXLhrdBl9b4ZMo7uOoidwze5bl5NuZWK2C10tMJFQz2sck/XrsRz7aqmc19G+u47wH
 WCyulG70jl3bFPCmJJLhwGq6D4Cj74uJqQfUeL+EeaXh/8fsQSw1Jhkzk3dfrBq+gsKN
 /DksaNVC9HnEu5VFowP13uSA2d0csCY3ifa7UEtcHQ6siFqi8FyqyLbvSkIjxahfG+zY
 HHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751283864; x=1751888664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rd5yGqmxGQLqfUZ7NeQdfpQZmVwBIYDuFQ5x+5IASK0=;
 b=NHcqvL2wlW0sa36EOqO2Xoiy9zvVbb+63hsiYBpWknQ9xkNZrBWjlW22qDIK3mCQjG
 J5ScU1K9TvtO+vzr824FyOv756Wx9V1aOrUk8b1Pkcs7ft9zPErej9SenVaZw9pv+8ya
 d6iy8HE95/NtOzNMbEeWD0ZRkVfod31QEdqpCvfwvRRe7bMH3bPM6c2ka4iTz7VBjj5I
 dToJ4CpuTT3lFAtrlIWhataX358Ecd532Yr7oC88HQRqWv0J/odrWaPZ+Im+tRE6YkcX
 pNVGx4wwTsPiFL+5sr+h7Xx/ysAhN/hIG0VbHCmMkLQPhXuCW2hhOZrlN69CfIBL3ec8
 9qhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQlNEUcTNqX4X3gUDJpeZnEO6Mo1OD0P04Uve1LYPJS7hzvJds8XVXy0OIKXtmRMbvFOI=@dpdk.org
X-Gm-Message-State: AOJu0YxalAyul1sDdvon/gDw9qwFZvlpgE+iKSi+Rg8NGzbpiFBfd/Sr
 GNQfsJLNvgU43uB5Uthp/qEKb42evWX7WZ2GpPz/dXi/DfSYwQrcxus3PvKFL7XrQPgSghYDDLR
 QFKIpddi4E9Ng25kb93a6m5f0yFYT+0c=
X-Gm-Gg: ASbGncuXwDQHqs4iwZ3LBBPvuM3MSNIBjAD9EkdpOD7iZNcf5+65oqVORq0H6pL05IS
 U6k3Fao4uL43GlhZlOD+dljG65GA8MEuYb7Pm0eAdrdipXpfaynboE1mp8ZuZXnxtM/AfcqXkAB
 G6/qeNqnQDzd+ByenodvktQWqlkebi3A1E7OMkPJUx+w==
X-Google-Smtp-Source: AGHT+IHYfCohZyvCjLl2K6OvmR1avm+Ja9UOejjMbAFEpo97sTUUp6ZF7Gxc6GwvJ2E9Mm2m3bnRQnOcziLgtaszfqY=
X-Received: by 2002:a05:622a:58c8:b0:49d:89bf:298f with SMTP id
 d75a77b69052e-4a7fcadf884mr200025771cf.22.1751283864039; Mon, 30 Jun 2025
 04:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250628045112.655999-1-pravin.pathak@intel.com>
 <CALBAE1NrMu3znG6N+iSQacxHWpoGmCe=azvTbkjEUQZGLY+DmA@mail.gmail.com>
 <bc0299d2-052d-4188-ab18-987360d65cb4@lysator.liu.se>
In-Reply-To: <bc0299d2-052d-4188-ab18-987360d65cb4@lysator.liu.se>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 30 Jun 2025 17:13:57 +0530
X-Gm-Features: Ac12FXyf1VXr37r1a47G63fnQ9qbSIVZzqYvCh12PL6CweVYlSNwTKivh5Tib0I
Message-ID: <CALBAE1MUrpZqWA=E78QiWy7k=H8QrYQ-=4vme4eHqSm8avBHJg@mail.gmail.com>
Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode support
To: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>
Cc: Pravin Pathak <pravin.pathak@intel.com>, dev@dpdk.org, jerinj@marvell.com, 
 mike.ximing.chen@intel.com, bruce.richardson@intel.com, thomas@monjalon.net,
 david.marchand@redhat.com, nipun.gupta@amd.com, chenbox@nvidia.com, 
 tirthendu.sarkar@intel.com, Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>, harry.chang@intel.com, 
 =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 30, 2025 at 4:47=E2=80=AFPM Mattias R=C3=B6nnblom <hofors@lysat=
or.liu.se> wrote:
>
> On 2025-06-30 11:19, Jerin Jacob wrote:
> > On Sat, Jun 28, 2025 at 11:17=E2=80=AFAM Pravin Pathak <pravin.pathak@i=
ntel.com> wrote:
> >>
> >> DLB2 port interrupt is implemented using DPDK interrupt
> >> framework. This allows eventdev dequeue API to sleep when
> >> the port queue is empty and gets wakeup when event arrives
> >> at the port. Port dequeue mode is configured using devargs
> >> argument port_dequeue_wait. Supported modes are polling and
> >> interrupt. Default mode is polling.
> >> This commit also adds code to handle device error interrupts
> >> and print alarm details.
> >>
> >> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
> >> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> >> ---
> >>   doc/guides/eventdevs/dlb2.rst              |  20 +
> >>   drivers/event/dlb2/dlb2.c                  | 236 +++++-
> >>   drivers/event/dlb2/dlb2_iface.c            |   7 +
> >>   drivers/event/dlb2/dlb2_iface.h            |   8 +
> >>   drivers/event/dlb2/dlb2_priv.h             |  18 +
> >>   drivers/event/dlb2/dlb2_user.h             | 112 +++
> >>   drivers/event/dlb2/pf/base/dlb2_hw_types.h |  70 ++
> >>   drivers/event/dlb2/pf/base/dlb2_osdep.h    |  46 ++
> >>   drivers/event/dlb2/pf/base/dlb2_regs.h     | 149 +++-
> >>   drivers/event/dlb2/pf/base/dlb2_resource.c | 825 +++++++++++++++++++=
++
> >>   drivers/event/dlb2/pf/base/dlb2_resource.h |   6 +
> >>   drivers/event/dlb2/pf/dlb2_pf.c            | 223 ++++++
> >>   12 files changed, 1711 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2=
.rst
> >> index 8ec7168f20..a4ba857351 100644
> >> --- a/doc/guides/eventdevs/dlb2.rst
> >> +++ b/doc/guides/eventdevs/dlb2.rst
> >> @@ -477,6 +477,26 @@ Example command to use as meson option for credit=
 handling:
> >>
> >>          meson configure -Dc_args=3D'-DDLB_SW_CREDITS_CHECKS=3D0 -DDLB=
_HW_CREDITS_CHECKS=3D1'
> >>
> >> +Interrupt Mode Support
> >> +~~~~~~~~~~~~~~~~~~~~~~
> >> +DLB dequeue supports interrupt mode for the API rte_event_dequeue_bur=
st().
> >> +The default port dequeue mode is polling. Dequeue wait mode can be co=
nfigured
> >> +on per eventdev port basis using devargs argument 'port_dequeue_wait'=
. In
> >> +interrupt mode, if the port queue is empty, the application thread wi=
ll block
> >> +on the interrupt until a new event arrives. It enters blocking mode o=
nly after
> >> +any specified timeout. During the timeout, it will poll the port queu=
e for
> >> +events as usual. Interrupt mode uses the DPDK interrupt support frame=
work.
> >> +
> >> +    .. code-block:: console
> >> +
> >> +       --allow ea:00.0,port_dequeue_wait=3Dall:interrupt
> >
> > Adding other eventdev PMD mainatainers.
> >
> > Looks like it can be a generic feature. i.e set this option is dev_conf=
igure()
> > If there is no objection, Please send a new patch around that.
>
> I've considered implementing this in DSW, although in a different manner
> (with eventfds and poll()).
>
> The dequeue timeout will still be honored in "interrupt mode", correct?
> It wasn't obvious from the description.

How is it in Intel PMD?

>
> What's being configured should just be a threshold time at which the
> event device would go from busy-polling to blocking the thread.
>
> Maybe it should be called something with "blocking" or "sleeping",
> instead of "interrupt", since interrupts are never directly involved.

Agree. or make it a power save mode or so.

>
> Anyway, seems like a good candidate for a generic feature to me.
>
