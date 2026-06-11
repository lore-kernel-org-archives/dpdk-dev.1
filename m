Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DECDCD8C9D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 18:39:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BB8F43246;
	Thu, 11 Jun 2026 20:39:26 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2A1154025F
 for <dev@dpdk.org>; Thu, 11 Jun 2026 20:39:24 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-9157b94a07aso20759485a.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781203163; cv=none;
 d=google.com; s=arc-20240605;
 b=IFiDniYX6iS/UYWvvLsgHQjhPduqnF3AHUU5vs/ty2Brcbfu8LZDhrqTT9Okjy2zjn
 kh71XrOFcSygxoOoSptxGqsBUSPC5UACY8CoOZglU6S9eYZBNTodRwfUUN246jSydXY7
 QVa4GwD2VCGDUz9c08ju8lqwogGupDCa15AEWVkAXXZj/vVmlf7Hex17DrhD2javpYXN
 830/RHdNhdHJry5zpXWBy9OOCHST9tx+n+8jaR1WTO5Ci7qEa4IrpMyPs6/zAaSjzdhz
 Z2kg2Nt6BPyDupmL8PveNO3vrZthF0qWex9jalTnaBeq1mfWktBBvn5ufsQPw/bh+dbt
 H2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=KL6qNsHhhHQ1ksidmUIv2ZVGHAgWWd0TpmHSyMMwJYA=;
 fh=vgiQ8qO7x7a9MtbXs5dA6KZwSJMFZrWTAES2NmeMYIc=;
 b=OZHRaO7qgrexPC8cwvZRM3DHVP/a+DiPnfnLbZ6iOnrNHV2tM+vHE2Fq7VZgdIFabj
 2UxpDaTaP//xODTtlVQY0hWn/GtAmT/vgcGFZZMJQ7YMuK9uYyVbF/Rbf8/2uInEBj0h
 wcSbW9sDrR+6Yh6E35aMiIAYRy0Ju1PNiOZDNBPJyqm8TYiUjiVEyNaw5cVQFvOUfDxO
 eWfFcW3PjZtvN2Op+k/+udDdVwzW1FyZ02myP9k7akd146pNgVujrfvB4+/gr/VIxMJk
 Mn0M8cjzykI/huIQUVBNoG5Z7+iNMEzQ29aZoYWgQzbFwtukg5zBmY9mKibmeGR2wZDw
 fMkg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781203163; x=1781807963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL6qNsHhhHQ1ksidmUIv2ZVGHAgWWd0TpmHSyMMwJYA=;
 b=ScIosysaWUtiReaQPbX7XrXy0dK9Peb3X1lu6kR/Xta8IKiwngE/8lJTsUPU+nsuQX
 3gCifvJB/GdQm8dsLRjr6wUOLZiO3PjnAfNAIcCfvk/zuFS6xqw2PYe4jGDhE21wsFMy
 oTgFVhU+po1t6GOsRdsVInX8ojV1WyPwo5M4nltxxJ2d3sitIhSyuMzDyACsZNpHDv/n
 WWEplUDLV1u31uBkdl8w+SxlhxKmuFIQIsR7A5fUw67NkYO7xjZdaQtOazAbjqkTBJxl
 n7T9r9xR6hZbupob5NeG5nETJp2P/fR8QtXGvJJyGH7MFIw7cvavcnzYqMHh5+GcCeGu
 /w8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EKawfpIMiBmTZnoj/UxtSSYAlEw5T4pQZRya4jyI1ehXbW8aXURii1uZUakCULHa0E6c=@dpdk.org
X-Gm-Message-State: AOJu0Yx1vkHwEg2gl7wpTtS4rBYUIDWEnuK1HOfzCz7vpRnwiPqyGDQy
 f0rUA4QOaKa4IUkxMKxNEir4OCfHavhjtggQyIKoY7GEWVuqId9Z6LltdH6IpsMprHboTv486TS
 /1EHwGWXNFD/of55M/vS+ZWTgBaDVCCo=
X-Gm-Gg: Acq92OGCiWRIUhkltLHPTY14Ba7IYiMXq+rpLB/GI/AY0fqRO32XbgfjgOk2J90khu1
 9HbGhYxDeBkpNkJ26C/ytLnMrjrdXRxcG5QyktOEcMLjsRTmCPbXL0oo5itvZnW5CLo91SR0an6
 qfIex8eWiV2EnBNlFy2VVVmv2v2BbQQtaLDMg7+Q3DxRhVu+zAaYmlSQ/CWNaO1k7LreVWP4xuO
 ntOQdrLdbnJJ50mh8NLO+5U1xG49Ha3kGiMMdUbVELNCD5mYnkD8YrgZXjeexea40Na1AdBMR3S
 IGWlOsyasK1QsLlckc9zIVgbFt6IKD4h/06CfqDhiw==
X-Received: by 2002:a05:620a:1b93:b0:915:9de3:2260 with SMTP id
 af79cd13be357-9160ad0df56mr642996985a.24.1781203163354; Thu, 11 Jun 2026
 11:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260611154926.392670-1-maxime@leroys.fr>
 <20260611154926.392670-9-maxime@leroys.fr>
 <98CBD80474FA8B44BF855DF32C47DC35F65909@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65909@smartserver.smartshare.dk>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 11 Jun 2026 20:39:12 +0200
X-Gm-Features: AVVi8CcsVo-21eBmqtp5S9KUqE-pLHE1JaKTVb7zQImTwnN-41SXP9CjXjzujww
Message-ID: <CAHHRULUGdnTmpnAX2aONEMj3bJmN11RG2cHGJ7h3-qhjoJLsFw@mail.gmail.com>
Subject: Re: [PATCH 8/9] ethdev: keep fast-path ops valid after port stop
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, dev@dpdk.org, 
 stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Sunil Kumar Kori <skori@marvell.com>
Content-Type: multipart/alternative; boundary="000000000000d33e2a0653feada4"
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

--000000000000d33e2a0653feada4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 11 juin 2026, 18:01, Morten Br=C3=B8rup <mb@smartsharesystems.com> =
a
=C3=A9crit :

> > From: Maxime Leroy [mailto:maxime.leroys@gmail.com] On Behalf Of Maxime
> > Leroy
> > Sent: Thursday, 11 June 2026 17.49
> >
> > eth_dev_fp_ops_reset() restores a port's fast-path ops on stop/release
> > via a compound literal, so every field it omits is zeroed to NULL. It
> > sets only rx_pkt_burst/tx_pkt_burst (and the rxq/txq data), leaving
> > rx_queue_count, tx_queue_count, rx/tx_descriptor_status, tx_pkt_prepare
> > and the recycle callbacks NULL.
> >
> > In non-debug builds these ops are reached through an unguarded indirect
> > call (the NULL check exists only under RTE_ETHDEV_DEBUG_RX/TX). So a
> > thread calling e.g. rte_eth_rx_queue_count() on a port being stopped
> > dereferences NULL and crashes, while the same race on
> > rte_eth_rx_burst()
> > is harmless because the burst ops are reset to dummies. A poll-mode
> > worker re-checking rx_queue_count before arming the Rx interrupt and
> > sleeping hits exactly this.
> >
> > Reset these ops to the same dummies eth_dev_set_dummy_fops() installs,
> > so a stopped port behaves like a freshly allocated one: every fast-path
> > op is a safe no-op, none is NULL.
> >
> > Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> > Cc: stable@dpdk.org
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > ---
>
> Good catch.
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>
> Not related to the series, consider sending as separate patch.
>
Thanks for the review and Ack.

Agreed, this is a generic ethdev fix. I kept it in this series because the
NAPI user depends on it.

The current Grout NAPI loop arms RX queue interrupts and then re-checks
rte_eth_rx_queue_count() before blocking, to avoid sleeping when a packet
arrived between the last empty poll and epoll_wait.

With the current ethdev reset path, rx_burst is replaced by a dummy
callback on stop/release, but rx_queue_count becomes NULL. So if the port
is stopped concurrently, the NAPI worker dereferences a NULL function
pointer and
segfaults on that recheck.

I can split it out if maintainers prefer, but then the dpaa2 NAPI series
has a real dependency on the standalone ethdev fix.

>

--000000000000d33e2a0653feada4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Le jeu. 11 juin 2026, 18:01, Mor=
ten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems.com">mb@smartsha=
resystems.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">&gt; From: Maxime Leroy [mailto:<a href=3D"mailto:maxime.leroys@gmai=
l.com" target=3D"_blank" rel=3D"noreferrer">maxime.leroys@gmail.com</a>] On=
 Behalf Of Maxime<br>
&gt; Leroy<br>
&gt; Sent: Thursday, 11 June 2026 17.49<br>
&gt; <br>
&gt; eth_dev_fp_ops_reset() restores a port&#39;s fast-path ops on stop/rel=
ease<br>
&gt; via a compound literal, so every field it omits is zeroed to NULL. It<=
br>
&gt; sets only rx_pkt_burst/tx_pkt_burst (and the rxq/txq data), leaving<br=
>
&gt; rx_queue_count, tx_queue_count, rx/tx_descriptor_status, tx_pkt_prepar=
e<br>
&gt; and the recycle callbacks NULL.<br>
&gt; <br>
&gt; In non-debug builds these ops are reached through an unguarded indirec=
t<br>
&gt; call (the NULL check exists only under RTE_ETHDEV_DEBUG_RX/TX). So a<b=
r>
&gt; thread calling e.g. rte_eth_rx_queue_count() on a port being stopped<b=
r>
&gt; dereferences NULL and crashes, while the same race on<br>
&gt; rte_eth_rx_burst()<br>
&gt; is harmless because the burst ops are reset to dummies. A poll-mode<br=
>
&gt; worker re-checking rx_queue_count before arming the Rx interrupt and<b=
r>
&gt; sleeping hits exactly this.<br>
&gt; <br>
&gt; Reset these ops to the same dummies eth_dev_set_dummy_fops() installs,=
<br>
&gt; so a stopped port behaves like a freshly allocated one: every fast-pat=
h<br>
&gt; op is a safe no-op, none is NULL.<br>
&gt; <br>
&gt; Fixes: 066f3d9cc21c (&quot;ethdev: remove callback checks from fast pa=
th&quot;)<br>
&gt; Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"norefe=
rrer">stable@dpdk.org</a><br>
&gt; Signed-off-by: Maxime Leroy &lt;<a href=3D"mailto:maxime@leroys.fr" ta=
rget=3D"_blank" rel=3D"noreferrer">maxime@leroys.fr</a>&gt;<br>
&gt; ---<br>
<br>
Good catch.<br>
Acked-by: Morten Br=C3=B8rup &lt;<a href=3D"mailto:mb@smartsharesystems.com=
" target=3D"_blank" rel=3D"noreferrer">mb@smartsharesystems.com</a>&gt;<br>
<br>
Not related to the series, consider sending as separate patch.<br></blockqu=
ote></div></div><div dir=3D"auto"><div dir=3D"auto">Thanks for the review a=
nd Ack.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Agreed, this is =
a generic ethdev fix. I kept it in this series because the NAPI user depend=
s on it.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The current Gro=
ut NAPI loop arms RX queue interrupts and then re-checks rte_eth_rx_queue_c=
ount() before blocking, to avoid sleeping when a packet arrived between the=
 last empty poll and epoll_wait.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">With the current ethdev reset path, rx_burst is replaced by a dum=
my callback on stop/release, but rx_queue_count becomes NULL. So if the por=
t is stopped concurrently, the NAPI worker dereferences a NULL function poi=
nter and</div><div dir=3D"auto">segfaults on that recheck.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">I can split it out if maintainers prefer=
, but then the dpaa2 NAPI series has a real dependency on the standalone et=
hdev fix.</div></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quot=
e_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"></blockquote></div></div></div>

--000000000000d33e2a0653feada4--
