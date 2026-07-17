Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F98C4451C
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 12:34:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2AD54069D;
	Fri, 17 Jul 2026 14:34:28 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 978164029B
 for <dev@dpdk.org>; Fri, 17 Jul 2026 14:34:26 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so780974766b.0
 for <dev@dpdk.org>; Fri, 17 Jul 2026 05:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784291666; cv=none;
 d=google.com; s=arc-20260327;
 b=GKywfcjwC6YHIaLNv8VWcvM7eoydqmeZzPNf+JKg+8QdjVt1vvbRgRkUGh19CPbU9K
 ku5QcDDSUEXeQ87WK4GWDhq8JNoE2/YtusAixXe1kgPoY6EBf1N1X2IJ9DTKIt2KDJFp
 fI2tWelRjE3GUOsK198B3kOZa+dDIfANA1W6GsyZQwIBhP3QE4Ybo9v7/l08Vcs186AF
 4ahgE/u/0ZGbX1YzCA1cyfDNYp7qpwZTNwewfu1Jt75XmFzZpK8MTSD/7fvdno5ooDV1
 egYcnXvjH+zU50fPwDC3L6NukZdtNR5LXINjAxZbqK0FCPULD3rsdIScgq+iGDYBvtPi
 k38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Da9yL7zJe/7n8SjKKmo3FWHbtHgsq39dWCswVjB0608=;
 fh=bENSMzZevXotxgDQmMbib2ZJaCJ13NKTl1Q54dn7fTM=;
 b=bQ4Nem+82SE4NOR8Z3koA/3pVsxz7utjXckB0ffXqc55PaMa58B0Khoc7pApWW+PZr
 moAil53+iWVxJ4Kp6E7jSv1gn6b5XnoOs8PbjHms6wia8LzlinLOYqqAKV/UyE06OZy3
 Xpyo8zf9oU1sxpRMMlalTvC48m7kkFsC1JeTBRk15GWxdwRZc0hZIs9PsKgZTXD5yfzK
 lzwA7vIyusFEkPMOQeFH4BZ0LJ1wF8pjHhpOAmO9crC9RTSUw20DTaggAKRa1RWE667y
 XkzK/Y8mHbl32bQu1DlgjZi2l5OVTZnGGsgpIaNkPeZUGHPSzwFcOqJ5QusXfIjxRJUp
 GB4A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784291666;
 x=1784896466; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Da9yL7zJe/7n8SjKKmo3FWHbtHgsq39dWCswVjB0608=;
 b=VoywU7jtlkhzR1ViTXnfP42aPOjX99/XOw6TkdmnKr+laoKf7Lc3Q7KN/QHg6fwMJ1
 SeX5f8SgrSam5ji1OnYzT0ZiF9IN7M6ko5CirC26gUXrv1B4bNRcNWWcJre/deiM2Lq1
 0wOQ/TpoXCiQAXrd9CaCur8Btbd1ypY107gg20P4x22xXFQSS3OAxMVel5wjfksbR+Qw
 XjSAZ4ZXcthw9J+6nt3vQUKmAzJ5TKvJ/TOf/1P8O/Yo84hL/lUcNkiFjehEstcyFY1t
 +lcHF/2XUKMwja3GxWgNEz1wCq8AB8Rkhx09xvJZlYahmRLF9hg8BMpA5nVDqbYHoXxj
 jdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784291666; x=1784896466;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Da9yL7zJe/7n8SjKKmo3FWHbtHgsq39dWCswVjB0608=;
 b=MwIZtgX0jBPwi0bHqcyWxeb1nf38PILI/ZmmunXkm4q0dN65dD89pb6KNRpqXKInH1
 SadgUPMCenDy8/XTdibguLOSKj27OoGIiwV3HzSi01XEoVmazJOUzl16dgTpAyhVUw6A
 /jZrSENGhVmPEmcPaWtqtlY0EZ16rOIWoyxZLns+aD/4BnSw+pIVKUf61HIHBwG7/6Xn
 OcLYVTsikbcCwut0QysAy8Nx+uwRTL1DH5c7rXUi8mVJPTjc2t3sad/WGqEEK8PTDq/3
 YHK0hhqioj6CslVmcDkAypUEQKTNoSCYQ6dcCD/b1kbSDgg72MfQcJOhNXiNeTCuZUj+
 o7zg==
X-Gm-Message-State: AOJu0YwzqX52JPQT8rrfuv9B91US+mTXKsvu1e1oYItkGpTNFmHikeGA
 rdVkwmvetXlITG12a6e7oTcqIa7XL3YiwJvc3dReW32LrA0wNMIkKYPFPm+7MKSGcKDI3lPjXMJ
 TB85NJ+W7hxK+G1akOty2KbHjKzL+CIxDeCcOYf4/Gg==
X-Gm-Gg: AfdE7cnkCYq4iBm9ySXof5TgOe7ljjdDTlF/lrWiaiQW5prGG9hG798U5XZmFU8B/6X
 7FEz89nirIpZvrjFJ632wkB7BmAIV0wbE7hqC4o3vS00UzIAZy4WVGCg6M6RsafTnll+1iVPKAL
 wlIUVccuestgs2TpE6+asOx++Ug9pchL9ei/YvEp1HVXW4k96vH0Jme4+Z3k3dMfVtUv2aPjTf2
 2BZqgP4Lf9vNN4qN6plf3JM8+qAGGPzIDqz7K49AszJG092bKi8HQvSjKPcAeO6g/eqrXxFbE6b
 JW5MNRLhlFKvWmJg
X-Received: by 2002:a17:907:e8e:b0:c12:6632:e7f0 with SMTP id
 a640c23a62f3a-c16b46e7a56mr118954066b.24.1784291665698; Fri, 17 Jul 2026
 05:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260717095842.419130-1-maxime@leroys.fr>
 <20260717095842.419130-3-maxime@leroys.fr>
In-Reply-To: <20260717095842.419130-3-maxime@leroys.fr>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 17 Jul 2026 14:31:38 +0200
X-Gm-Features: AUfX_mwnaRcf-hOENXPiJBbs79DvdgfsiXA_I-bTBgM1AXcMfNpKfhGD4oI4Guw
Message-ID: <CAOaVG16_NrF=PNTzCVEuC_BWzt+4+4WHP6yXnHH=QbzitP2xiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/tap: drain queue FD in Rx interrupt mode
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev <dev@dpdk.org>, stable <stable@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000e8f2550656cdc6fd"
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

--000000000000e8f2550656cdc6fd
Content-Type: text/plain; charset="UTF-8"

Don't use int as a boolean. Use bool. Ideally find unused pad hole for it

On Fri, Jul 17, 2026, 11:59 AM Maxime Leroy <maxime@leroys.fr> wrote:

> The tap Rx path is driven by a SIGIO trigger: pmd_rx_burst() returns
> without reading the queue fd unless tap_trigger, bumped by the O_ASYNC
> signal handler, has advanced. That avoids a readv() on every empty poll.
>
> In Rx interrupt mode the application blocks on the queue fd through epoll
> and polls only after a wakeup. The epoll wakeup and the trigger are
> distinct signals, so the burst can return 0 right after a wakeup because
> the trigger has not advanced, leaving the fd readable with no further
> edge: traffic stalls.
>
> When the port is configured for Rx interrupts, drain the fd
> unconditionally in the burst and do not arm the SIGIO trigger on the data
> queue fd. A data queue fd can be closed and recreated on a later setup,
> so the mode must stay constant to keep every fd on the same SIGIO policy:
> it is fixed at configure time and a later change is rejected. Close and
> reopen the port to switch modes.
>
> Fixes: 4870a8cdd968 ("net/tap: support Rx interrupt")
> Cc: stable@dpdk.org
>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  drivers/net/tap/rte_eth_tap.c | 18 +++++++++++++++++-
>  drivers/net/tap/rte_eth_tap.h |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
> index 99ede19e49..ea9ef76335 100644
> --- a/drivers/net/tap/rte_eth_tap.c
> +++ b/drivers/net/tap/rte_eth_tap.c
> @@ -254,6 +254,10 @@ tun_alloc(struct pmd_internals *pmd, int
> is_keepalive, int persistent)
>                 goto error;
>         }
>
> +       /* interrupt mode wakes through epoll on the data queue fd, not
> the SIGIO trigger */
> +       if (pmd->intr_mode)
> +               return fd;
> +
>         /* Find a free realtime signal */
>         for (signo = SIGRTMIN + 1; signo < SIGRTMAX; signo++) {
>                 struct sigaction sa;
> @@ -477,7 +481,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs,
> uint16_t nb_pkts)
>         unsigned long num_rx_bytes = 0;
>         uint32_t trigger = tap_trigger;
>
> -       if (trigger == rxq->trigger_seen)
> +       if (!rxq->intr_mode && trigger == rxq->trigger_seen)
>                 return 0;
>
>         process_private = rte_eth_devices[rxq->in_port].process_private;
> @@ -937,6 +941,16 @@ tap_dev_configure(struct rte_eth_dev *dev)
>         struct pmd_internals *pmd = dev->data->dev_private;
>         int intr_mode = !!dev->data->dev_conf.intr_conf.rxq;
>
> +       /* The queue fd is created once and its SIGIO trigger is armed for
> poll
> +        * mode only; the interrupt mode cannot be toggled on an existing
> port.
> +        */
> +       if (pmd->intr_mode_set && pmd->intr_mode != intr_mode) {
> +               TAP_LOG(ERR,
> +                       "%s: Rx interrupt mode is fixed after configure,
> close and reopen the port to change it",
> +                       dev->device->name);
> +               return -ENOTSUP;
> +       }
> +
>         if (dev->data->nb_rx_queues != dev->data->nb_tx_queues) {
>                 TAP_LOG(ERR,
>                         "%s: number of rx queues %d must be equal to
> number of tx queues %d",
> @@ -947,6 +961,7 @@ tap_dev_configure(struct rte_eth_dev *dev)
>         }
>
>         pmd->intr_mode = intr_mode;
> +       pmd->intr_mode_set = 1;
>
>         TAP_LOG(INFO, "%s: %s: TX configured queues number: %u",
>                 dev->device->name, pmd->name, dev->data->nb_tx_queues);
> @@ -1620,6 +1635,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,
>         rxq->queue_id = rx_queue_id;
>         rxq->max_rx_segs = max_rx_segs;
>         rxq->rxmode = &dev->data->dev_conf.rxmode;
> +       rxq->intr_mode = internals->intr_mode;
>
>         dev->data->rx_queues[rx_queue_id] = rxq;
>         int fd = tap_setup_queue(dev, rx_queue_id, 1);
> diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
> index 3180719c34..abe22aac9f 100644
> --- a/drivers/net/tap/rte_eth_tap.h
> +++ b/drivers/net/tap/rte_eth_tap.h
> @@ -50,6 +50,7 @@ struct rx_queue {
>         uint16_t queue_id;              /* queue ID*/
>         struct queue_stats stats;        /* Stats for this RX queue */
>         uint16_t max_rx_segs;           /* max scatter segments per packet
> */
> +       uint16_t intr_mode;             /* 1 when Rx queue interrupts are
> used */
>         struct rte_eth_rxmode *rxmode;  /* RX features */
>         struct rte_mbuf *pool;          /* mbufs pool for this queue */
>         struct tun_pi pi;               /* packet info for iovecs */
> @@ -94,6 +95,7 @@ struct pmd_internals {
>
>         struct rte_intr_handle *intr_handle;         /* LSC interrupt
> handle. */
>         int intr_mode;                    /* Rx queue interrupt mode */
> +       int intr_mode_set;                /* intr_mode locked after
> configure */
>         int ka_fd;                        /* keep-alive file descriptor */
>         struct rte_mempool *gso_ctx_mp;     /* Mempool for GSO packets */
>  };
> --
> 2.43.0
>
>

--000000000000e8f2550656cdc6fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Don&#39;t use int as a boolean. Use bool. Ideally find un=
used pad hole for it</div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17, 2026, 11:59 AM Ma=
xime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr">maxime@leroys.fr</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The tap =
Rx path is driven by a SIGIO trigger: pmd_rx_burst() returns<br>
without reading the queue fd unless tap_trigger, bumped by the O_ASYNC<br>
signal handler, has advanced. That avoids a readv() on every empty poll.<br=
>
<br>
In Rx interrupt mode the application blocks on the queue fd through epoll<b=
r>
and polls only after a wakeup. The epoll wakeup and the trigger are<br>
distinct signals, so the burst can return 0 right after a wakeup because<br=
>
the trigger has not advanced, leaving the fd readable with no further<br>
edge: traffic stalls.<br>
<br>
When the port is configured for Rx interrupts, drain the fd<br>
unconditionally in the burst and do not arm the SIGIO trigger on the data<b=
r>
queue fd. A data queue fd can be closed and recreated on a later setup,<br>
so the mode must stay constant to keep every fd on the same SIGIO policy:<b=
r>
it is fixed at configure time and a later change is rejected. Close and<br>
reopen the port to switch modes.<br>
<br>
Fixes: 4870a8cdd968 (&quot;net/tap: support Rx interrupt&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"noreferrer"=
>stable@dpdk.org</a><br>
<br>
Signed-off-by: Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr" target=
=3D"_blank" rel=3D"noreferrer">maxime@leroys.fr</a>&gt;<br>
---<br>
=C2=A0drivers/net/tap/rte_eth_tap.c | 18 +++++++++++++++++-<br>
=C2=A0drivers/net/tap/rte_eth_tap.h |=C2=A0 2 ++<br>
=C2=A02 files changed, 19 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c<=
br>
index 99ede19e49..ea9ef76335 100644<br>
--- a/drivers/net/tap/rte_eth_tap.c<br>
+++ b/drivers/net/tap/rte_eth_tap.c<br>
@@ -254,6 +254,10 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive,=
 int persistent)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* interrupt mode wakes through epoll on the da=
ta queue fd, not the SIGIO trigger */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmd-&gt;intr_mode)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fd;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Find a free realtime signal */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (signo =3D SIGRTMIN + 1; signo &lt; SIGRTMA=
X; signo++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sigaction sa=
;<br>
@@ -477,7 +481,7 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint1=
6_t nb_pkts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long num_rx_bytes =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t trigger =3D tap_trigger;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (trigger =3D=3D rxq-&gt;trigger_seen)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rxq-&gt;intr_mode &amp;&amp; trigger =3D=
=3D rxq-&gt;trigger_seen)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 process_private =3D rte_eth_devices[rxq-&gt;in_=
port].process_private;<br>
@@ -937,6 +941,16 @@ tap_dev_configure(struct rte_eth_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct pmd_internals *pmd =3D dev-&gt;data-&gt;=
dev_private;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int intr_mode =3D !!dev-&gt;data-&gt;dev_conf.i=
ntr_conf.rxq;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The queue fd is created once and its SIGIO t=
rigger is armed for poll<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * mode only; the interrupt mode cannot be togg=
led on an existing port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pmd-&gt;intr_mode_set &amp;&amp; pmd-&gt;in=
tr_mode !=3D intr_mode) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TAP_LOG(ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%s: Rx interrupt mode is fixed after configure, close and r=
eopen the port to change it&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev-&gt;device-&gt;name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTSUP;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;data-&gt;nb_rx_queues !=3D dev-&gt;=
data-&gt;nb_tx_queues) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TAP_LOG(ERR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;%s: number of rx queues %d must be equal to number of tx q=
ueues %d&quot;,<br>
@@ -947,6 +961,7 @@ tap_dev_configure(struct rte_eth_dev *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmd-&gt;intr_mode =3D intr_mode;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pmd-&gt;intr_mode_set =3D 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TAP_LOG(INFO, &quot;%s: %s: TX configured queue=
s number: %u&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;device-&gt;=
name, pmd-&gt;name, dev-&gt;data-&gt;nb_tx_queues);<br>
@@ -1620,6 +1635,7 @@ tap_rx_queue_setup(struct rte_eth_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxq-&gt;queue_id =3D rx_queue_id;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxq-&gt;max_rx_segs =3D max_rx_segs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxq-&gt;rxmode =3D &amp;dev-&gt;data-&gt;dev_co=
nf.rxmode;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rxq-&gt;intr_mode =3D internals-&gt;intr_mode;<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;data-&gt;rx_queues[rx_queue_id] =3D rxq=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd =3D tap_setup_queue(dev, rx_queue_id, 1)=
;<br>
diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h<=
br>
index 3180719c34..abe22aac9f 100644<br>
--- a/drivers/net/tap/rte_eth_tap.h<br>
+++ b/drivers/net/tap/rte_eth_tap.h<br>
@@ -50,6 +50,7 @@ struct rx_queue {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t queue_id;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* queue ID*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct queue_stats stats;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Stats for this RX queue */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t max_rx_segs;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0/* max scatter segments per packet */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t intr_mode;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* 1 when Rx queue interrupts are used */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_eth_rxmode *rxmode;=C2=A0 /* RX feat=
ures */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mbuf *pool;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* mbufs pool for this queue */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tun_pi pi;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* packet info for iovecs */<br>
@@ -94,6 +95,7 @@ struct pmd_internals {<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_intr_handle *intr_handle;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* LSC interrupt handle. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int intr_mode;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Rx queue interrupt mode */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int intr_mode_set;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* intr_mode locked after configure */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ka_fd;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* keep-alive file descrip=
tor */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_mempool *gso_ctx_mp;=C2=A0 =C2=A0 =
=C2=A0/* Mempool for GSO packets */<br>
=C2=A0};<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000e8f2550656cdc6fd--
