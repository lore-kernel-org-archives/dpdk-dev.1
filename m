Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F3C8302B
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 16:23:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F38A402CB;
	Mon, 30 Jun 2025 18:23:07 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id E9738402A5
 for <dev@dpdk.org>; Mon, 30 Jun 2025 18:23:06 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4a76ea97cefso23214661cf.2
 for <dev@dpdk.org>; Mon, 30 Jun 2025 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751300586; x=1751905386; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dt4brV74PeW/mfmAo1I4mCauizyrkp2KAEelIv8Kdlk=;
 b=CL/U0kkJDtKrS4/kPzaRoMGPwArD4syQx33UF620uBhHM/CDuXuDrmA6fAlXetg1qi
 P7gfoT9Wqo7UnIZYYCFVJdb8++OqyCeny9pqb40HgM2j/NPBtNS95H1XW0Nf5Tp0IXl2
 nq+Rvmiq3yZxejwPHF900I4ENKmxfmOY7HmdDqyJ84Q8jJs7KIFDOCL8yW4QdO/iMnR3
 lzhHeJ/j29emhx5GD+l83NM9rLRCp8LPbnd1f2czGs0TN3h7R09evkKxJxPEdz+8b+hT
 cUrS5htwKxALJQTf4ThVhBPmIovPqQ5jd988pviW5ldWtKKOCv/x5gdU/YgDm/z/Gger
 +QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751300586; x=1751905386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dt4brV74PeW/mfmAo1I4mCauizyrkp2KAEelIv8Kdlk=;
 b=TeTe8lFracPVj92jSBL9oCYvCFDPRMFLhUxSJQ6LJaMCPP7i508KtWt0/WVSgu6h3Q
 mIpwX9PUT0ScCIvoVyB0EaOY39YkVGs3sjl5AD6p/Gpct/UgzAXp3V5GZ8WA/Urxpev9
 6USOIam4G5JkqPCNBOFZt5tbJWCClN0ssBHdZsAS5ja4B88G6zUhb9Dcey2dFyhHYbx/
 k6UDHbS83CIIlacGKS4cVmV5NVz6lP45fOTOAKqkN9eHfC5ky7vwWp18JjZ5lereJ4jm
 GD9HAYyEgqBHfLXCNC06bYYrVMZE8iK0S8PmAPwkcyU9YB9s6VV61U42iKHyqClnPsYT
 BzxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnxvLwvsmIlQqja7W9YfsOaeiafDSfeRlDrRSbhX+K5D3Yztd1tdJJ6ZFB6QCITCIwlRU=@dpdk.org
X-Gm-Message-State: AOJu0YyrCGyhFf3TqQZqTp48RHHDpbiNR5fcVPS35sS4YO5kXFYtyr3x
 +Uei26JgfZIV4BNJ5zV6HqWQslxWHD7cQL9t+ejUrw6duh6BbGU8bhwvXLX9JCoYWZ+Uwv67jV2
 zRSIc2dN9+NcJoJqIBO+Nkt6DfKxjOQA=
X-Gm-Gg: ASbGncvUtVdly5Y//CDqO2DmuSO5vRsoIDUAUtWrf+cloP8KNJjpsiFn1UAlmq8lZv0
 vTqEXUdrzMYBlpxHuvS7kDi0MLGlIdbOu9S/BKpv9nqWZWxr6JO7HJMFdIFKwu8wPochRhmNxxO
 yfGNMmiHEGxn2sahocDIkBiZhwvf1cm3vX0ev4BcM0LA==
X-Google-Smtp-Source: AGHT+IF7MKILKVswuMxaqm5Frnu03AHStSOOJKUYDHoJmP5OqyJJBiXzzQe153C5yGin6aSEQ2A2ZYHszGEDPtpVshM=
X-Received: by 2002:a05:622a:760f:b0:477:6c0e:d5b3 with SMTP id
 d75a77b69052e-4a7fdc22b55mr151371611cf.6.1751300585962; Mon, 30 Jun 2025
 09:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250628045112.655999-1-pravin.pathak@intel.com>
 <CALBAE1NrMu3znG6N+iSQacxHWpoGmCe=azvTbkjEUQZGLY+DmA@mail.gmail.com>
 <bc0299d2-052d-4188-ab18-987360d65cb4@lysator.liu.se>
 <CALBAE1MUrpZqWA=E78QiWy7k=H8QrYQ-=4vme4eHqSm8avBHJg@mail.gmail.com>
 <BL1PR11MB5461AD27C632B62C4A81FC59F446A@BL1PR11MB5461.namprd11.prod.outlook.com>
In-Reply-To: <BL1PR11MB5461AD27C632B62C4A81FC59F446A@BL1PR11MB5461.namprd11.prod.outlook.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 30 Jun 2025 21:52:39 +0530
X-Gm-Features: Ac12FXzFX2_OqBNBqv61Kk4D3jCfOFRMNSUB--ozw6NhPjBvxwcERa-tvm7fWfY
Message-ID: <CALBAE1PiJOPPYMawaLzzp0a3kXG-h9v9Lr80sc=c38eNJeS21g@mail.gmail.com>
Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode support
To: "Pathak, Pravin" <pravin.pathak@intel.com>
Cc: =?UTF-8?Q?Mattias_R=C3=B6nnblom?= <hofors@lysator.liu.se>, 
 "dev@dpdk.org" <dev@dpdk.org>, "jerinj@marvell.com" <jerinj@marvell.com>, 
 "Chen, Mike Ximing" <mike.ximing.chen@intel.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "Marchand, David" <david.marchand@redhat.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>, 
 "chenbox@nvidia.com" <chenbox@nvidia.com>, "Sarkar,
 Tirthendu" <tirthendu.sarkar@intel.com>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>, 
 "harry.chang@intel.com" <harry.chang@intel.com>,
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

On Mon, Jun 30, 2025 at 9:49=E2=80=AFPM Pathak, Pravin <pravin.pathak@intel=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jerin Jacob <jerinjacobk@gmail.com>
> > Sent: Monday, June 30, 2025 7:44 AM
> > To: Mattias R=C3=B6nnblom <hofors@lysator.liu.se>
> > Cc: Pathak, Pravin <pravin.pathak@intel.com>; dev@dpdk.org;
> > jerinj@marvell.com; Chen, Mike Ximing <mike.ximing.chen@intel.com>;
> > Richardson, Bruce <bruce.richardson@intel.com>; thomas@monjalon.net;
> > Marchand, David <david.marchand@redhat.com>; nipun.gupta@amd.com;
> > chenbox@nvidia.com; Sarkar, Tirthendu <tirthendu.sarkar@intel.com>; Pav=
an
> > Nikhilesh <pbhagavatula@marvell.com>; Shijith Thotton
> > <sthotton@marvell.com>; Hemant Agrawal <hemant.agrawal@nxp.com>;
> > Sachin Saxena <sachin.saxena@oss.nxp.com>; harry.chang@intel.com;
> > Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
> > Subject: Re: [PATCH v1] event/dlb2: add dequeue interrupt mode support
> >
> > On Mon, Jun 30, 2025 at 4:47=E2=80=AFPM Mattias R=C3=B6nnblom <hofors@l=
ysator.liu.se>
> > wrote:
> > >
> > > On 2025-06-30 11:19, Jerin Jacob wrote:
> > > > On Sat, Jun 28, 2025 at 11:17=E2=80=AFAM Pravin Pathak
> > <pravin.pathak@intel.com> wrote:
> > > >>
> > > >> DLB2 port interrupt is implemented using DPDK interrupt framework.
> > > >> This allows eventdev dequeue API to sleep when the port queue is
> > > >> empty and gets wakeup when event arrives at the port. Port dequeue
> > > >> mode is configured using devargs argument port_dequeue_wait.
> > > >> Supported modes are polling and interrupt. Default mode is polling=
.
> > > >> This commit also adds code to handle device error interrupts and
> > > >> print alarm details.
> > > >>
> > > >> Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
> > > >> Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
> > > >> ---
> > > >>   doc/guides/eventdevs/dlb2.rst              |  20 +
> > > >>   drivers/event/dlb2/dlb2.c                  | 236 +++++-
> > > >>   drivers/event/dlb2/dlb2_iface.c            |   7 +
> > > >>   drivers/event/dlb2/dlb2_iface.h            |   8 +
> > > >>   drivers/event/dlb2/dlb2_priv.h             |  18 +
> > > >>   drivers/event/dlb2/dlb2_user.h             | 112 +++
> > > >>   drivers/event/dlb2/pf/base/dlb2_hw_types.h |  70 ++
> > > >>   drivers/event/dlb2/pf/base/dlb2_osdep.h    |  46 ++
> > > >>   drivers/event/dlb2/pf/base/dlb2_regs.h     | 149 +++-
> > > >>   drivers/event/dlb2/pf/base/dlb2_resource.c | 825
> > +++++++++++++++++++++
> > > >>   drivers/event/dlb2/pf/base/dlb2_resource.h |   6 +
> > > >>   drivers/event/dlb2/pf/dlb2_pf.c            | 223 ++++++
> > > >>   12 files changed, 1711 insertions(+), 9 deletions(-)
> > > >>
> > > >> diff --git a/doc/guides/eventdevs/dlb2.rst
> > > >> b/doc/guides/eventdevs/dlb2.rst index 8ec7168f20..a4ba857351
> > 100644
> > > >> --- a/doc/guides/eventdevs/dlb2.rst
> > > >> +++ b/doc/guides/eventdevs/dlb2.rst
> > > >> @@ -477,6 +477,26 @@ Example command to use as meson option for
> > credit handling:
> > > >>
> > > >>          meson configure -Dc_args=3D'-DDLB_SW_CREDITS_CHECKS=3D0 -
> > DDLB_HW_CREDITS_CHECKS=3D1'
> > > >>
> > > >> +Interrupt Mode Support
> > > >> +~~~~~~~~~~~~~~~~~~~~~~
> > > >> +DLB dequeue supports interrupt mode for the API
> > rte_event_dequeue_burst().
> > > >> +The default port dequeue mode is polling. Dequeue wait mode can b=
e
> > > >> +configured on per eventdev port basis using devargs argument
> > > >> +'port_dequeue_wait'. In interrupt mode, if the port queue is
> > > >> +empty, the application thread will block on the interrupt until a
> > > >> +new event arrives. It enters blocking mode only after any
> > > >> +specified timeout. During the timeout, it will poll the port queu=
e for
> > events as usual. Interrupt mode uses the DPDK interrupt support framewo=
rk.
> > > >> +
> > > >> +    .. code-block:: console
> > > >> +
> > > >> +       --allow ea:00.0,port_dequeue_wait=3Dall:interrupt
> > > >
> > > > Adding other eventdev PMD mainatainers.
> > > >
> > > > Looks like it can be a generic feature. i.e set this option is
> > > > dev_configure() If there is no objection, Please send a new patch a=
round
> > that.
> > >
> > > I've considered implementing this in DSW, although in a different
> > > manner (with eventfds and poll()).
> > >
> > > The dequeue timeout will still be honored in "interrupt mode", correc=
t?
> > > It wasn't obvious from the description.
> >
> > How is it in Intel PMD?
>
> It would be best if we configure it per port using RTE_EVENT_PORT_CFG_* f=
lags. Will it be, OK?

Yes

> The dequeue timeout will be honored, and the decision to block or return =
will be made after the timeout.
> If not interrupt, it can be called blocking vs polling mode.  If the port=
 config is fine, I will create a new patch with it.
> Also, we should have this as a capability for eventdevs.

Yes

>
> >
> > >
> > > What's being configured should just be a threshold time at which the
> > > event device would go from busy-polling to blocking the thread.
> > >
> > > Maybe it should be called something with "blocking" or "sleeping",
> > > instead of "interrupt", since interrupts are never directly involved.
> >
> > Agree. or make it a power save mode or so.
> >
> > >
> > > Anyway, seems like a good candidate for a generic feature to me.
> > >
