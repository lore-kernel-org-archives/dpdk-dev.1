Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8816CC44520
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 11:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A321F402A7;
	Mon, 20 Jul 2026 13:16:21 +0200 (CEST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 6C9D74028E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 13:16:20 +0200 (CEST)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so853463466b.0
 for <dev@dpdk.org>; Mon, 20 Jul 2026 04:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784546180; cv=none;
 d=google.com; s=arc-20260327;
 b=AU2h2TGUqlKjYF6ZzHTtlAJt24DDj6v/s5CZmzKE/22QcE7SJqiDICZAPXm6px+OH4
 7CTUygIR4J4M5n4PVT31+yus2azQOaHzV6+FHadLicYXdr8pqxqOIgDFjUdNrBviIC9L
 YBIIUzw5zeGCfrkhqFdN/SsjKMaM2UfU9K6AOAYziTaOK36sRAN+5ZiOeUm5frKPLf6h
 UmuPtDcVEEVz8BTO3lVKLK6YxYqYpQGXAqZrmSVcyuCeDSP5PMSullm7EEMWy58KSumQ
 2vGm7PIBPt3SUqHWao6dZLd7KDwMtEQKf6CjgsGUU2W2VHTG/GvoaHlfyI7FLiUvt0FZ
 gRfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=No9B+GAgE/Ok3ypS8nYV1HxQpSSRSZonqdRfwayLUVI=;
 fh=bENSMzZevXotxgDQmMbib2ZJaCJ13NKTl1Q54dn7fTM=;
 b=mzlkzwnmoK/2TjqD9jQQ6TbkFCANxUoIq5wER3qzjsxOYTSOxeEcVQREiN+RIqvuBu
 XAGeczu5gaBRfm2aTzbfS1oFKM+4Gnqq1Yx6nc0iIMPdojKigAQuRvQoA+oUwuxNrbCl
 6GS8koDPyn4hk9NIMbcskM7FCCDI5MPJYcZMzPuWTZvdoWs5WaEAEDTMNM/DhGjkPRH6
 zd1YsjtfeqjBez3gHaU5/9g7JsB+VO+XCRMPFPgGD4iIzQT+580ExIcG6Yow9ooAkYuX
 b2aQMFPGzRau9l2GJobtmvEFOfSIENmiN2tN+1h4abv2fGHE0G11Kt0CMNsKGE98kD8N
 j81A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784546180;
 x=1785150980; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=No9B+GAgE/Ok3ypS8nYV1HxQpSSRSZonqdRfwayLUVI=;
 b=baksRRYXDqYndAIyodKGhKidXbxPqxevihBtbbneCzwHv0ToEzDcZVZTITnrP5ubRp
 jgr/BL+dMf88TdMG34SsAZqm0ixmG6Rerlwjspvz6IO9VFbgLETgS4Qgx7QAlgO7FtfN
 yoZ/w6S8Zms1YPaqsyXYkM6qLVbXUCiiMhysH52UmWY5H2MULjrb6M2ja748qLnxBZY6
 tp9YKhAcKu8C/O5KDhlgs2BGP83kk8h0Mmk/EtIcuM8Jfr3h9e+uQtrFP4lHE5hJ9oHc
 bXrOFAtj9l/0z3RjfVa6Kdbg4llBds5DVBnxLEssLdhMHmNhLOOb2y+n5CXvlLogIDdC
 IUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546180; x=1785150980;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=No9B+GAgE/Ok3ypS8nYV1HxQpSSRSZonqdRfwayLUVI=;
 b=dwURLLnW6m6G8LBs5yNJFZHDPX9iZWQITLlwt2ghkRWBmN9/cqu7TWBVwl6Uiam6Et
 lX3bGRxq0Oxa2S5q4NshJz7LO8Lgh0XKgjRXaDZahNaPr8Vm5ALV223nZVOd937myS4R
 xKJkE8DwK5eXuxTKqNe0DZHV4kA8y/0KnJMOrAX+9rZmAhT0MKwjk1UFOPSCm7LWB5in
 gpiGPIIbmypxvQZH9ueq3q4eYQm4KneqzMvhGcaM9rjN9C7FD58nyS9VLlH38NVikx5D
 g1UAIzOa/l2sehfFdQPGua5OOQbC0OAWdBx3UPZWDZPtpaHCKRsNli3/7VvVLT5R1ptX
 bSww==
X-Gm-Message-State: AOJu0Yzsp3YpokUQ+GjCLVvJorgIibmNMSc8M0lK0IJeBDmBTCOCHwkg
 16oKpAv1q4DppI/0fyk0sW/W7oDlkxJbOeAoxNIFl2vCQSeJlyHITnyWL11ftlc03mvCZuU5Rys
 FMNNPgFf0bKtE4rdogNNKXB+NTXpcsXC8Jq2EVOaCwA==
X-Gm-Gg: AfdE7ck7lJrfH/szzMi9jXaH4TTiS/KOScCbygkVdo08bMYOKKWKTRwv5EDhflbYvCf
 xiN6jDUl7OgxR9yAbSi5qMMdcrG6+jTmDnwy83TtbwyhiTVX9zZ05poEIYGT0CXfC6pF40vgdXG
 LXjd3iirOgXuL3oH9gODprd7isrSEGmKQx4il+FDMDMSzs2HirVTPXrk1r8F7ZKnSfeZve73Otj
 vYwDm7wMTC4SEnnqJ1q2NfEYHjdWQLJWLII2GEnuTdc5plU1TQRqT5IiRN7Q9D/4mUstSuHh6UT
 0knUodxPxtWUY4g=
X-Received: by 2002:a17:907:6d0e:b0:c16:89e0:dce0 with SMTP id
 a640c23a62f3a-c16920d90f1mr847927766b.11.1784546179552; Mon, 20 Jul 2026
 04:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260717095842.419130-1-maxime@leroys.fr>
 <20260717095842.419130-3-maxime@leroys.fr>
 <CAOaVG16_NrF=PNTzCVEuC_BWzt+4+4WHP6yXnHH=QbzitP2xiQ@mail.gmail.com>
 <CAHHRULUiZp2bLHONoDPhqexWd_ptXRLAQYVC=V3ojXonhecq1g@mail.gmail.com>
In-Reply-To: <CAHHRULUiZp2bLHONoDPhqexWd_ptXRLAQYVC=V3ojXonhecq1g@mail.gmail.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Mon, 20 Jul 2026 13:16:08 +0200
X-Gm-Features: AUfX_mwa8iRznf-oqG12lTXLfsGbVXKGl-CvU8QH6-l6rKuMhlza-20PZu4w_KM
Message-ID: <CAOaVG150C7+4cMpshTj2J=ZqtWBjeUdk+tpiKqL3zg0BUwj0cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/tap: drain queue FD in Rx interrupt mode
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev <dev@dpdk.org>, stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000001e2889065709098b"
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

--0000000000001e2889065709098b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

the coding style against bool is more of a keenel thing.

On Mon, Jul 20, 2026, 10:33 Maxime Leroy <maxime@leroys.fr> wrote:

> On Fri, Jul 17, 2026 at 2:34=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > Don't use int as a boolean. Use bool. Ideally find unused pad hole for =
it
>
> Agreed int-as-a-boolean is not great. But bool in a structure is
> discouraged by coding_style.rst:
>
>    "Uses of bool in structures are not preferred as is wastes space and
>     it's also not clear as to what type size the bool is."  (Ref: LKML)
>
> and that very LKML reference is Linus recommending the opposite of
> bool for struct members:
>
>    "please don't use bool in structures at all. [...] Use bool mainly as =
a
>     return type from functions [...]. [...] just make sure the base type =
is
>     unsigned [...] you can specify the base type as you wish [...] for
>     packing."
>
> The current tap PMD follows that too: the existing flags (persist,
> flow_init, flow_isolate) are all int, and stdbool.h is not even
> included in the headers.
>
> So for v2 I'll use uint8_t for intr_mode and intr_mode_set: fixed
> 1-byte size, unambiguous representation, and it fits the existing
> padding so neither struct grows (pmd_internals stays 144 bytes,
> rx_queue stays 80). That matches both the guide and the referenced
> LKML guidance.
>
> I can also add a third patch at the end of the series converting the
> existing int flags (persist, flow_init, flow_isolate) to uint8_t, to
> make the driver consistent
>
> >
> > On Fri, Jul 17, 2026, 11:59 AM Maxime Leroy <maxime@leroys.fr> wrote:
> >>
> >> The tap Rx path is driven by a SIGIO trigger: pmd_rx_burst() returns
> >> without reading the queue fd unless tap_trigger, bumped by the O_ASYNC
> >> signal handler, has advanced. That avoids a readv() on every empty pol=
l.
> >>
> >> In Rx interrupt mode the application blocks on the queue fd through
> epoll
> >> and polls only after a wakeup. The epoll wakeup and the trigger are
> >> distinct signals, so the burst can return 0 right after a wakeup becau=
se
> >> the trigger has not advanced, leaving the fd readable with no further
> >> edge: traffic stalls.
> >>
> >> When the port is configured for Rx interrupts, drain the fd
> >> unconditionally in the burst and do not arm the SIGIO trigger on the
> data
> >> queue fd. A data queue fd can be closed and recreated on a later setup=
,
> >> so the mode must stay constant to keep every fd on the same SIGIO
> policy:
> >> it is fixed at configure time and a later change is rejected. Close an=
d
> >> reopen the port to switch modes.
> >>
> >> Fixes: 4870a8cdd968 ("net/tap: support Rx interrupt")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> >> ---
> >>  drivers/net/tap/rte_eth_tap.c | 18 +++++++++++++++++-
> >>  drivers/net/tap/rte_eth_tap.h |  2 ++
> >>  2 files changed, 19 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/tap/rte_eth_tap.c
> b/drivers/net/tap/rte_eth_tap.c
> >> index 99ede19e49..ea9ef76335 100644
> >> --- a/drivers/net/tap/rte_eth_tap.c
> >> +++ b/drivers/net/tap/rte_eth_tap.c
> >> @@ -254,6 +254,10 @@ tun_alloc(struct pmd_internals *pmd, int
> is_keepalive, int persistent)
> >>                 goto error;
> >>         }
> >>
> >> +       /* interrupt mode wakes through epoll on the data queue fd, no=
t
> the SIGIO trigger */
> >> +       if (pmd->intr_mode)
> >> +               return fd;
> >> +
> >>         /* Find a free realtime signal */
> >>         for (signo =3D SIGRTMIN + 1; signo < SIGRTMAX; signo++) {
> >>                 struct sigaction sa;
> >> @@ -477,7 +481,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs,
> uint16_t nb_pkts)
> >>         unsigned long num_rx_bytes =3D 0;
> >>         uint32_t trigger =3D tap_trigger;
> >>
> >> -       if (trigger =3D=3D rxq->trigger_seen)
> >> +       if (!rxq->intr_mode && trigger =3D=3D rxq->trigger_seen)
> >>                 return 0;
> >>
> >>         process_private =3D rte_eth_devices[rxq->in_port].process_priv=
ate;
> >> @@ -937,6 +941,16 @@ tap_dev_configure(struct rte_eth_dev *dev)
> >>         struct pmd_internals *pmd =3D dev->data->dev_private;
> >>         int intr_mode =3D !!dev->data->dev_conf.intr_conf.rxq;
> >>
> >> +       /* The queue fd is created once and its SIGIO trigger is armed
> for poll
> >> +        * mode only; the interrupt mode cannot be toggled on an
> existing port.
> >> +        */
> >> +       if (pmd->intr_mode_set && pmd->intr_mode !=3D intr_mode) {
> >> +               TAP_LOG(ERR,
> >> +                       "%s: Rx interrupt mode is fixed after
> configure, close and reopen the port to change it",
> >> +                       dev->device->name);
> >> +               return -ENOTSUP;
> >> +       }
> >> +
> >>         if (dev->data->nb_rx_queues !=3D dev->data->nb_tx_queues) {
> >>                 TAP_LOG(ERR,
> >>                         "%s: number of rx queues %d must be equal to
> number of tx queues %d",
> >> @@ -947,6 +961,7 @@ tap_dev_configure(struct rte_eth_dev *dev)
> >>         }
> >>
> >>         pmd->intr_mode =3D intr_mode;
> >> +       pmd->intr_mode_set =3D 1;
> >>
> >>         TAP_LOG(INFO, "%s: %s: TX configured queues number: %u",
> >>                 dev->device->name, pmd->name, dev->data->nb_tx_queues)=
;
> >> @@ -1620,6 +1635,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
> >>         rxq->queue_id =3D rx_queue_id;
> >>         rxq->max_rx_segs =3D max_rx_segs;
> >>         rxq->rxmode =3D &dev->data->dev_conf.rxmode;
> >> +       rxq->intr_mode =3D internals->intr_mode;
> >>
> >>         dev->data->rx_queues[rx_queue_id] =3D rxq;
> >>         int fd =3D tap_setup_queue(dev, rx_queue_id, 1);
> >> diff --git a/drivers/net/tap/rte_eth_tap.h
> b/drivers/net/tap/rte_eth_tap.h
> >> index 3180719c34..abe22aac9f 100644
> >> --- a/drivers/net/tap/rte_eth_tap.h
> >> +++ b/drivers/net/tap/rte_eth_tap.h
> >> @@ -50,6 +50,7 @@ struct rx_queue {
> >>         uint16_t queue_id;              /* queue ID*/
> >>         struct queue_stats stats;        /* Stats for this RX queue */
> >>         uint16_t max_rx_segs;           /* max scatter segments per
> packet */
> >> +       uint16_t intr_mode;             /* 1 when Rx queue interrupts
> are used */
> >>         struct rte_eth_rxmode *rxmode;  /* RX features */
> >>         struct rte_mbuf *pool;          /* mbufs pool for this queue *=
/
> >>         struct tun_pi pi;               /* packet info for iovecs */
> >> @@ -94,6 +95,7 @@ struct pmd_internals {
> >>
> >>         struct rte_intr_handle *intr_handle;         /* LSC interrupt
> handle. */
> >>         int intr_mode;                    /* Rx queue interrupt mode *=
/
> >> +       int intr_mode_set;                /* intr_mode locked after
> configure */
> >>         int ka_fd;                        /* keep-alive file descripto=
r
> */
> >>         struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets
> */
> >>  };
> >> --
> >> 2.43.0
> >>
>
>
> --
> -------------------------------
> Maxime Leroy
> maxime@leroys.fr
>

--0000000000001e2889065709098b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">the coding style against bool is more of a keenel thing.=
=C2=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Jul 20, 2026, 10:33 Maxime Leroy &lt;=
<a href=3D"mailto:maxime@leroys.fr">maxime@leroys.fr</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Jul 17, 2026 at=
 2:34=E2=80=AFPM Stephen Hemminger<br>
&lt;<a href=3D"mailto:stephen@networkplumber.org" target=3D"_blank" rel=3D"=
noreferrer">stephen@networkplumber.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Don&#39;t use int as a boolean. Use bool. Ideally find unused pad hole=
 for it<br>
<br>
Agreed int-as-a-boolean is not great. But bool in a structure is<br>
discouraged by coding_style.rst:<br>
<br>
=C2=A0 =C2=A0&quot;Uses of bool in structures are not preferred as is waste=
s space and<br>
=C2=A0 =C2=A0 it&#39;s also not clear as to what type size the bool is.&quo=
t;=C2=A0 (Ref: LKML)<br>
<br>
and that very LKML reference is Linus recommending the opposite of<br>
bool for struct members:<br>
<br>
=C2=A0 =C2=A0&quot;please don&#39;t use bool in structures at all. [...] Us=
e bool mainly as a<br>
=C2=A0 =C2=A0 return type from functions [...]. [...] just make sure the ba=
se type is<br>
=C2=A0 =C2=A0 unsigned [...] you can specify the base type as you wish [...=
] for<br>
=C2=A0 =C2=A0 packing.&quot;<br>
<br>
The current tap PMD follows that too: the existing flags (persist,<br>
flow_init, flow_isolate) are all int, and stdbool.h is not even<br>
included in the headers.<br>
<br>
So for v2 I&#39;ll use uint8_t for intr_mode and intr_mode_set: fixed<br>
1-byte size, unambiguous representation, and it fits the existing<br>
padding so neither struct grows (pmd_internals stays 144 bytes,<br>
rx_queue stays 80). That matches both the guide and the referenced<br>
LKML guidance.<br>
<br>
I can also add a third patch at the end of the series converting the<br>
existing int flags (persist, flow_init, flow_isolate) to uint8_t, to<br>
make the driver consistent<br>
<br>
&gt;<br>
&gt; On Fri, Jul 17, 2026, 11:59 AM Maxime Leroy &lt;<a href=3D"mailto:maxi=
me@leroys.fr" target=3D"_blank" rel=3D"noreferrer">maxime@leroys.fr</a>&gt;=
 wrote:<br>
&gt;&gt;<br>
&gt;&gt; The tap Rx path is driven by a SIGIO trigger: pmd_rx_burst() retur=
ns<br>
&gt;&gt; without reading the queue fd unless tap_trigger, bumped by the O_A=
SYNC<br>
&gt;&gt; signal handler, has advanced. That avoids a readv() on every empty=
 poll.<br>
&gt;&gt;<br>
&gt;&gt; In Rx interrupt mode the application blocks on the queue fd throug=
h epoll<br>
&gt;&gt; and polls only after a wakeup. The epoll wakeup and the trigger ar=
e<br>
&gt;&gt; distinct signals, so the burst can return 0 right after a wakeup b=
ecause<br>
&gt;&gt; the trigger has not advanced, leaving the fd readable with no furt=
her<br>
&gt;&gt; edge: traffic stalls.<br>
&gt;&gt;<br>
&gt;&gt; When the port is configured for Rx interrupts, drain the fd<br>
&gt;&gt; unconditionally in the burst and do not arm the SIGIO trigger on t=
he data<br>
&gt;&gt; queue fd. A data queue fd can be closed and recreated on a later s=
etup,<br>
&gt;&gt; so the mode must stay constant to keep every fd on the same SIGIO =
policy:<br>
&gt;&gt; it is fixed at configure time and a later change is rejected. Clos=
e and<br>
&gt;&gt; reopen the port to switch modes.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: 4870a8cdd968 (&quot;net/tap: support Rx interrupt&quot;)<br=
>
&gt;&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"no=
referrer">stable@dpdk.org</a><br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr=
" target=3D"_blank" rel=3D"noreferrer">maxime@leroys.fr</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 drivers/net/tap/rte_eth_tap.c | 18 +++++++++++++++++-<br>
&gt;&gt;=C2=A0 drivers/net/tap/rte_eth_tap.h |=C2=A0 2 ++<br>
&gt;&gt;=C2=A0 2 files changed, 19 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_e=
th_tap.c<br>
&gt;&gt; index 99ede19e49..ea9ef76335 100644<br>
&gt;&gt; --- a/drivers/net/tap/rte_eth_tap.c<br>
&gt;&gt; +++ b/drivers/net/tap/rte_eth_tap.c<br>
&gt;&gt; @@ -254,6 +254,10 @@ tun_alloc(struct pmd_internals *pmd, int is_k=
eepalive, int persistent)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto =
error;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* interrupt mode wakes through epoll =
on the data queue fd, not the SIGIO trigger */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmd-&gt;intr_mode)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fd;=
<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Find a free realtime signal */=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (signo =3D SIGRTMIN + 1; sign=
o &lt; SIGRTMAX; signo++) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struc=
t sigaction sa;<br>
&gt;&gt; @@ -477,7 +481,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bu=
fs, uint16_t nb_pkts)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long num_rx_bytes =3D 0;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t trigger =3D tap_trigger;=
<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (trigger =3D=3D rxq-&gt;trigger_see=
n)<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rxq-&gt;intr_mode &amp;&amp; trig=
ger =3D=3D rxq-&gt;trigger_seen)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n 0;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_private =3D rte_eth_devic=
es[rxq-&gt;in_port].process_private;<br>
&gt;&gt; @@ -937,6 +941,16 @@ tap_dev_configure(struct rte_eth_dev *dev)<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct pmd_internals *pmd =3D dev=
-&gt;data-&gt;dev_private;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int intr_mode =3D !!dev-&gt;data-=
&gt;dev_conf.intr_conf.rxq;<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The queue fd is created once and it=
s SIGIO trigger is armed for poll<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * mode only; the interrupt mode canno=
t be toggled on an existing port.<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmd-&gt;intr_mode_set &amp;&amp; p=
md-&gt;intr_mode !=3D intr_mode) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_LOG(ER=
R,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;%s: Rx interrupt mode is fixed after configure, c=
lose and reopen the port to change it&quot;,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dev-&gt;device-&gt;name);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EN=
OTSUP;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;data-&gt;nb_rx_queues=
 !=3D dev-&gt;data-&gt;nb_tx_queues) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_L=
OG(ERR,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s: number of rx queues %d must be equal to n=
umber of tx queues %d&quot;,<br>
&gt;&gt; @@ -947,6 +961,7 @@ tap_dev_configure(struct rte_eth_dev *dev)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmd-&gt;intr_mode =3D intr_mode;<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0pmd-&gt;intr_mode_set =3D 1;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_LOG(INFO, &quot;%s: %s: TX co=
nfigured queues number: %u&quot;,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&=
gt;device-&gt;name, pmd-&gt;name, dev-&gt;data-&gt;nb_tx_queues);<br>
&gt;&gt; @@ -1620,6 +1635,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rxq-&gt;queue_id =3D rx_queue_id;=
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rxq-&gt;max_rx_segs =3D max_rx_se=
gs;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rxq-&gt;rxmode =3D &amp;dev-&gt;d=
ata-&gt;dev_conf.rxmode;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rxq-&gt;intr_mode =3D internals-&gt;in=
tr_mode;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;data-&gt;rx_queues[rx_que=
ue_id] =3D rxq;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int fd =3D tap_setup_queue(dev, r=
x_queue_id, 1);<br>
&gt;&gt; diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_e=
th_tap.h<br>
&gt;&gt; index 3180719c34..abe22aac9f 100644<br>
&gt;&gt; --- a/drivers/net/tap/rte_eth_tap.h<br>
&gt;&gt; +++ b/drivers/net/tap/rte_eth_tap.h<br>
&gt;&gt; @@ -50,6 +50,7 @@ struct rx_queue {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t queue_id;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* queue ID*/<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct queue_stats stats;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* Stats for this RX queue */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t max_rx_segs;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* max scatter segments per packet */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t intr_mode;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 1 when Rx queue interrupts are used */<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_eth_rxmode *rxmode;=C2=
=A0 /* RX features */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mbuf *pool;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* mbufs pool for this queue */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct tun_pi pi;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* packet info for iovecs */<br>
&gt;&gt; @@ -94,6 +95,7 @@ struct pmd_internals {<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_intr_handle *intr_hand=
le;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* LSC interrupt handle. */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int intr_mode;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Rx queue interrupt =
mode */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int intr_mode_set;=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* intr_mode locked after configure */<=
br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ka_fd;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* keep-aliv=
e file descriptor */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_mempool *gso_ctx_mp;=
=C2=A0 =C2=A0 =C2=A0/* Mempool for GSO packets */<br>
&gt;&gt;=C2=A0 };<br>
&gt;&gt; --<br>
&gt;&gt; 2.43.0<br>
&gt;&gt;<br>
<br>
<br>
-- <br>
-------------------------------<br>
Maxime Leroy<br>
<a href=3D"mailto:maxime@leroys.fr" target=3D"_blank" rel=3D"noreferrer">ma=
xime@leroys.fr</a><br>
</blockquote></div>

--0000000000001e2889065709098b--
