Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF121606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mJ3g47w8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B075B402BF;
	Tue, 17 Nov 2026 18:55:44 +0100 (CET)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 0C4B6402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:55:43 +0100 (CET)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-7cc81984fceso33131137.0
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:55:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794938142; cv=none;
 d=google.com; s=arc-20260327;
 b=kLELt+mdjf3Mrob6vaNdI6ihMcmha+mWP224Tf8XqwfdVQpqQdiDz+YcCfbe+/1LiG
 /jg59BTnRBOiRx9Dl+tT1gcsgx9lv1+nhwt5604/wQ/zKRb1D2OTB8VILBPwURo9RKZu
 JsqYaXjAg3aBZXyUOSAvdFQNFB4uuo0fwkErYmCI1q9y/iSlIk53OfJYuNBgXoD3nGmg
 mn/8aRuuLnRgVGkAvkyiDSzUjgobkPm5NKuNtOakIpcZljIc4uP8qZKgBlxIanQcncuJ
 jvT2Gr+nPeNoDNgS5Q1olMWpCdDjwjAOtb49Pw25mwEF+pYntyBCMCHmjWiyIm/fT+dK
 UArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G+tTG1UROzBpEX0tjgMPTKFkH/KFF70LdOacs7hfDmM=;
 fh=3Nsh18EA9Jwpp9JeS5pmwbyJfTGZrgOZ5So2P4qUpi0=;
 b=kFYyx0na34cHafUh2D0TNNg/q2diEY/lKAeqA6vbRakxiGGsVKwW8HAF1Wk6CcLw1i
 DYnYRYGXwUGetKxCofooE1yD1zQX3SbTtXt+h7Z8UyBjHpA3a9sQ/j8Kh9UaX7ClNthJ
 UyiEq2TMeJW6l3bz/QduegjnXGdpkwujAVENNWMGLKqi13a+npbEF615j3ELa+dWMnWL
 qxbCQtukyNrbazCfYFNSoI267MsKPY+soDEoLdtq+htZL/4OFhMgtwWmoeP8V3yEQOXm
 54ywNrAHrOhzZrG1/UyEVsP0qZ6sQFIWX6/oLaDinM2i7f3r4zhL1qVHbGFj6fbI4jUh
 RaCQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794938142; x=1795542942; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G+tTG1UROzBpEX0tjgMPTKFkH/KFF70LdOacs7hfDmM=;
 b=mJ3g47w8/YdVDw2IhtSlvzCksjDgDg09n/wWK+tvGpCADDC+t5UMb5zRDn7aEyiskT
 xMqtlgk2ZxGVxFkC54KX8JD3aVaqW2xmsCS+JUg4H/vQKQtinAig4t+T0/l7fa8XwYRg
 ZPdmXRqNklUhQfsXFajq5ODOREKS01ZJ7AxtuG8oa9C/lx5Z/iNe4rOBoYSOIWeo72TM
 vWfYqT3ROTIoMlZnlT7URfulzMJYRyzj0mi1U3/DIkWA8ezQJkrvm18ZJ7t0LnC5dW6p
 hhYBEclY7QE3Iaz7YyoyqbccY6w9xBXlPd06sU7BVE1bl8TtBKR5vHR0FvyXIoOk/tYB
 aNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794938142; x=1795542942;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G+tTG1UROzBpEX0tjgMPTKFkH/KFF70LdOacs7hfDmM=;
 b=DSI3uYzk0+qScwsIWM6SETkwiNnh5Mi7hdu6KRaI2j1Q1vC7qOKhAjxQdXpEzJ5MXC
 U80FJBS3I9Z6MniBU35aqMoLLaKHzZwhYiRs1Q7z5BsOzvpDxtmGrXsY+Ba7ScFYWEWM
 SLAl7CnI7N0p3DJvvf/vcUF2Xv8CZ/t3lcMjqdueGfLfkBaq2TduaeIBcZCSfBpo4zkQ
 rSFVgnwokdXv1zXmqTq+Wj0LuEuhL/4rsckcPO2Bjr8YhLgI6SoqnBhsFpVrT5VR6fxX
 iXpRNvrToaAyhw14j4w3DuoUboBTsDnEhuEHMP/tBfbW1spIb0no364aiQG0DjmjxSmB
 NdqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHHsayO4BBcmskMNNpmQ54AkpJq4APSDRCqae14KAAIEhSLB8l4+wvBU63teJnbc2xW4S0=@dpdk.org
X-Gm-Message-State: APuU4Z9j57maJAYKgc7L/YgJ5duO0T/mDpy5K7wQuosdrbtT6h3/DXQh
 GKdICIXXwRKokepuJmt14kpUfgWV5hf0djNOZMFDhV68XeqDNVb0EUUYQ5P55CaMQculS+4/6gI
 BULeCSFMv0OGN0/ojDbekYHOmiCi4km0=
X-Gm-Gg: AYBFou1p1/ZlqOwaQxuWPoCUxWsP87k3jnUXJ4Q1UFjmXQxX32tnZfcMw6M7G4A0zmi
 i1KOrRd4zakm0HH2BBE1j6B/PyFHkVo8wj7+DZUmI3CUKjrdv3/IB39yqPeE63kZhBnswOjQm54
 dWFzPQ0J3TklS9oTCHGV1WSUcFvHfB//ekIVI/i5rb75DwwmL/tcYA3oF0zm9AWg8GJMohlXam2
 SuGpRqCQnXCB9Kh+hiPmIqnOyv6S3/eyhDyEO0z7GVVk53X4zOUj7M5CWK2+wU/pfINbcCKunfG
 U/Dmk6+ldzZKeZ+BJVjYElXWJWBgClFROVmfM1dxsb8DnP5wjHk5DOb21CQ47xMfxzc31CaczIg
 7s6Fra5Bv5rdt3rl3VZ8ckI2Fn9Duq4fExA4XrYxVuKE0kCktDbmO3hBUGO0fyKOcOjvEKZFGcH
 SUQIqWoieIvGVs8kMEPqc=
X-Received: by 2002:a05:6102:a4d:b0:7cc:828b:41f4 with SMTP id
 ada2fe7eead31-7d64db190fbmr4457972137.35.1794938141691; Tue, 17 Nov 2026
 09:55:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
 <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
 <CAPbG5O_hYnLaSARh3jnw3LFToaF_S9dnjpNPFVfmJHGN2Lr9qQ@mail.gmail.com>
 <CALBAE1N77y7PkK9o09JwJ=e1GDin9jxyN7VfjvDgY2oFEr9prw@mail.gmail.com>
 <SA1PR11MB680680CA639972DE92DB11B390712@SA1PR11MB6806.namprd11.prod.outlook.com>
 <CAPbG5O8uWmOcsWrY1DJ5MzNgeFZkAXBdMPvRcN7QBs4byoU2Ng@mail.gmail.com>
 <CALBAE1M22ZcTG0ofhE1-_G6_SoukoHRGc03vP3Fm55AA122axg@mail.gmail.com>
 <avyROPrxuK4BPY56@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <avyROPrxuK4BPY56@bricha3-mobl1.ger.corp.intel.com>
From: Pravin Pathak <pravinpathakdev@gmail.com>
Date: Tue, 17 Nov 2026 12:55:32 -0500
X-Gm-Features: Aa3M54r0e3Xi4AKpJ5IbQi9wGCUqRO0Rcmvf2YM_HCKz7KsLNwYaGe92MrIjdfc
Message-ID: <CAPbG5O8GU-6B_8sitJHB4Gjim2Tf=V=uRJ9=tzw-YGNASwGXoA@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Jerin Jacob <jerinjacobk@gmail.com>, mattias.ronnblom@ericcson.com, 
 "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "dev@dpdk.org" <dev@dpdk.org>,
 "jerinj@marvell.com" <jerinj@marvell.com>, 
 "mike.ximing.chen@intel.com" <mike.ximing.chen@intel.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>, 
 "chenbox@nvidia.com" <chenbox@nvidia.com>, mattias.ronnblom@ericsson.com
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 12:39=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Nov 17, 2026 at 10:55:12PM +0530, Jerin Jacob wrote:
> > On Tue, Nov 17, 2026 at 10:39=E2=80=AFPM Pravin Pathak
> > <pravinpathakdev@gmail.com> wrote:
> > >
> > > On Wed, Nov 11, 2026 at 9:22=E2=80=AFAM Sarkar, Tirthendu
> > > <tirthendu.sarkar@intel.com> wrote:
> > > >
> > > > On Mon, Nov 9, 2026 at 6:25 PM Jerin Jacob <jerinjacobk@gmail.com> =
wrote:
> > > > > Lets get the performance  numbers for SLB vs DSW based on same te=
st
> > > > > case so  that we can decide.
> > > > > Performance and scalability will be the aspect to decide the usag=
e of
> > > > > YET ANOTHER SW driver.
> > > >
> > > > Hi Pravin,
> > > >
> > > > A few points on top of Stephen's review, plus some early numbers si=
nce
> > > > Jerin asked for SLB vs DSW data.
> > > >
> > > > +1 to Stephen's two Errors in patch 2 (reorder slot reuse when RELE=
ASE
> > > > returns credits before the slot drains, and the lost wakeup in
> > > > slb_reorder_drain()) and to the credit-threshold issue in patch 1.
> > > > Those look like the ones that can lose or strand events.
> > > >
> > > > Additional comments:
> > > >
> > > > 1. slb_event.c, slb_event_enqueue_burst_generic(): the return value=
 of
> > > >    rte_event_ring_enqueue_burst() is ignored on every path and the
> > > >    function always returns events_len. Correctness then depends
> > > >    entirely on credits guaranteeing ring space. If that ever fails
> > > >    (e.g. the credit-threshold or reorder issues above, or applicati=
on
> > > >    misuse), events are silently dropped and their credits leak. At
> > > >    minimum, check the return value and report a short enqueue.
> > > >    Because the burst is sorted by destination queue before enqueue,
> > > >    a clean prefix count isn't possible after a partial failure, so
> > > >    this probably needs a space check up front or an explicit design
> > > >    statement that rings can never fill.
> > > >
> > > > 2. RTE_VERIFY(num_forward + num_release <=3D cur_pending) in the
> > > >    enqueue fast path aborts the whole process on application misuse
> > > >    (forwarding more events than were dequeued on that port). Please
> > > >    fail the enqueue and set rte_errno instead.
> > > >
> > > > 3. slb_configure(): max_inflight =3D RTE_MAX(nb_events_limit,
> > > >    nb_ports * SLB_PORT_MAX_CREDITS), so the device can hold more
> > > >    events than the application configured via nb_events_limit. If
> > > >    that is intended (to avoid credit-cache deadlock), please docume=
nt
> > > >    it in slb.rst.
> > > >
> > > > 4. slb_queue_setup() ignores queue_conf->priority; priority comes o=
nly
> > > >    from the link priority, yet dev_info reports
> > > >    max_event_queue_priority_levels =3D 2. Either honour queue prior=
ity or
> > > >    report 1 and document that priority is per link.
> > > >
> > > > Performance
> > > > -----------
> > > > Preliminary data from dpdk-test-eventdev perf_queue, series applied=
 on
> > > > v26.11-rc2, release build, Xeon 6505P (2x12C), physical cores only,
> > > > turbo on, default device settings, worker_deq_depth 16, 1024 flows.
> > > > Mpps, 1 synthetic producer, workers on socket 0:
> > > >
> > > >   stlist   driver   1w     2w     4w     8w
> > > >   p          slb       79.7   71.5   44.5   34.0
> > > >   p          dsw     50.1   46.3   45.1   41.9
> > > >   a          slb       54.3   65.3   57.0   43.9
> > > >   a          dsw     50.3   47.3   46.7   40.5
> > > >   a,a,a    slb      20.8    16.9   22.9   26.7
> > > >   a,a,a    dsw    20.8    18.4   20.1   18.2
> > > >   o          slb      61.7    29.5   36.6   27.4
> > > >   o          sw        7.7    10.0   11.7   13.7
> > > >   o,a       slb      36.0    19.5   28.3   28.9
> > > >   o,a       sw       3.8       5.7     7.5      7.2
> > > >
> > > > (event_dsw does not support ordered queues, so ordered rows are
> > > > against event_sw.)
> > > >
> > > > Observations:
> > > > - SLB is ahead at low worker counts but loses throughput faster as
> > > >   workers are added on single-stage parallel/atomic queues, which i=
s
> > > >   consistent with all workers contending on one MP/MC ring per queu=
e.
> > > > - Ordered queues are well ahead of event_sw (the only other SW PMD =
with
> > > >   ordered support), but SLB ordered throughput halves going from 1 =
to
> > > >   2 workers (61.7 -> 29.5 Mpps, reproduced), so the "close to
> > > >   parallel" claim only holds for a single worker (parallel: 79.7 ->
> > > >   71.5). This looks like the serialized reorder drain.
> > > > - With workers spanning both sockets (16/20 workers) all drivers dr=
op
> > > >   sharply; SLB falls to 5-10 Mpps vs DSW 3-14 depending on stlist.
> > > > - Note that with multiple producers perf_queue creates a separate
> > > >   queue set per producer, which splits SLB's per-queue contention; =
SLB
> > > >   scales very well in that mode (4 producers, 8 workers, atomic:
> > > >   ~235 Mpps vs ~158 for DSW at worker_deq_depth 16), but that does =
not
> > > >   reflect a pipeline where all traffic shares one atomic queue.
> > > > - order_queue passes with up to 16 workers. In that test SLB slows =
down
> > > >   as workers are added: with 8 workers it sustained ~1.0 M events/s=
 vs
> > > >   ~2.5 M events/s for event_sw (steady-state rate from the progress
> > > >   counter, 20M events); with 1-2 workers SLB was faster than event_=
sw
> > > >   (rough end-to-end timings, ~3.2 vs ~1.6-2.1 M events/s).
> > > >
> > > > These are untuned runs. In the 1-producer table the SLB/DSW atomic =
and
> > > > a,a,a rows, DSW parallel and SLB ordered were run twice and agreed
> > > > within ~5%; the other rows are single runs. Treat them as indicativ=
e.
> > > > It would help if v2 included your own perf_queue/pipeline numbers w=
ith
> > > > the exact command lines, ideally including a shared-queue case and
> > > > workers on more than one socket.
> > > >
> > > > Thanks,
> > > > Tirthendu
> > >
> > > Thanks Tirtha for the readings and comments. The main intention of in=
troducing
> > > SLB is to bridge the current gap where there is no distributed
> > > software eventdev
> > > supporting ordered queues and priorities. Current event_sw has a limi=
tation of
> > > single core scheduling limit. You can see it clearly from below
> > > performance tests
> > > where event_sw saturates early.
> >
> >
> > In that case (And looking at the performance numbers), I am OK to have
> > this new driver.  @mattias.ronnblom@ericcson.com  @Richardson, Bruce
> > any objections.
> >
> > @pravin.pathak.dev@gmail.com  If there is any common code between
> > Event SW PMDs THEN please think about have some place for common code
> > at driver/common/.../
> >
> No objections from me. Is this something that could completely replace th=
e
> event/sw driver in future, once it has stabilized?
>
> /Bruce
Bruce - Yes. Once event priority is added. That is the only missing
feature from event_sw.
I plan to add that next.
Jerin -  As I am using the DSW skeleton and credit scheme, in patch
V2, I kept mattias contribution
in headers intact. Corrected Mattias address on this thread.
