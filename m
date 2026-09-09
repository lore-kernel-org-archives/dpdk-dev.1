Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE11C79FB6
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 17:16:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B0A140EF1;
	Wed,  9 Sep 2026 19:16:32 +0200 (CEST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by mails.dpdk.org (Postfix) with ESMTP id 96E3B4067D
 for <dev@dpdk.org>; Wed,  9 Sep 2026 19:16:30 +0200 (CEST)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5c65093556aso4741697e0c.2
 for <dev@dpdk.org>; Wed, 09 Sep 2026 10:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788974190; cv=none;
 d=google.com; s=arc-20260327;
 b=E8eRpDHd2itsorVPbWTFeQ4Xfu29KqeWEBQvtvSkM8Oo9Kh+TUOl8IxTQy9DEyNAmb
 BfBJq/gp/NP934wxzVJOOwo5mWZP0S3DQzJvW2rDl11g7/ecuAceR4hM49OiQcbejJBE
 vvh7WC+mTHmIGCFaxjovOnkDfuQL8MFVmK7Ux4vdJi7S7MQ8EqAGUFme2+mtxG4Z4ZTS
 pxyhdPpdBbSZ6EQ6lZaKVkAPvMpfuC7BE5+/ym0U+gnosk+OK8e9vIc0HSrWHz1OGjj7
 MimXbfpq9+XNVYi84A93G0M1xgW16AR19zK2GEb4t3U+aAXFwL+xDFG9KcBXjOvk0P6S
 h1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PV/lyhSSMpNlNe4Y7uDTWsGxtKSSD9Ngisnb3jKi+IQ=;
 fh=uiDAelihsw4Rxk8n12eizhCrM6kybnDEvW/oxINVS2Y=;
 b=isq2wW5s6NfD1ShW776o6py1TB7XdJ9k4Y8EVYsBYqBsCqeiXxFJ892wStydXwebzd
 ne65eReWgasvx1ox+c24JFQl2mLZUtQ53nYx5As0X3NTKtZRhEl3QIcQZgv8LBYi5648
 khNflzT17oKK0EYI6i4zK0IB1gSF8GjcYIQFcYqv5ycknq+JBYa2Q7eSJOvOUvInEmie
 8KdyeqiHOiK1maQAF07iPMSRsrbA46BUhq7IqEhcBpkWLRFC5ADTyk2tRcId552Va+p4
 cOpSNrglfIHUsIYaxaUaYYmR1tBXw4T7ZNBn6F7rpW4U60iFs3VRRr3N9WYm3E2gIwf2
 FdVw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788974190;
 x=1789578990; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PV/lyhSSMpNlNe4Y7uDTWsGxtKSSD9Ngisnb3jKi+IQ=;
 b=WL7wCKLy2w9aVz7cOefswNgN3A0WrBW7vO42cyxcBeDxPSjmx0qHY1qhF7THkBhfs1
 vj9r2VdGInXogGjd3rxz6RluQ4kQp+ucpN9MJhD8EusB3GShmcd3yhYx6GwlDs/VpGyo
 4jPcHt5Rdm9cOqyVLtm5iw/TT7Q3vsYxyJreEzsJHbA/CUeWhewPN/z0nZiEjaGLEK9m
 asE2+WHhGkxdRrnZhz8X/hZFeu5EVVoDfPESSuuVqBDASJH9npHIusWy4bQaAUnDBcUf
 dcQZLt6onYNcgP4IWBikckkXl9qgU7QXEeLcDGLb2dJ0/8a7GXeGwicNXmj3dP9HRnjb
 XnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788974190; x=1789578990;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PV/lyhSSMpNlNe4Y7uDTWsGxtKSSD9Ngisnb3jKi+IQ=;
 b=Xcxlheqffl5pyCqbCuI5mNseUgIyA6soRJEM1YsI8U26puzUqKZJoNHa3NVyclh/Zh
 f2sUG3kNvVlC6Bdf9ciXP1tpaYydaiNTwkz9euqge2JftiiYvQREoB+zODLneHQ8YfWn
 1azNjZCZj07mj4Bt1sGbVwfoQimgaCJZmbeTJvfVC692dIsTkqhZMM39wqsGs/4oUwYE
 36u7AhN9wVhNXPMCTb6paZvIQ/q00PefPB5meYWzK8zXansRSyPWzMIHWHptsByZRSRe
 VmJ78XuiTqLoDrtXTkEXoYdZYNRz0HOk98iyG2ZzoD/Q/vrsYKvdEFldXRJ7SwUyQoHB
 dxQA==
X-Gm-Message-State: AFuF++ltbZeosJn6XbaYrY/v35EvTpmeldxDmKeZ5AT4d2FLhPG/7h6V
 yq4TvPI0lfQoJO+P/FjNU9L19aQF+msAGgngtq8eFLCgLLlE/TvvV7Jm5U+vS2YUCL/GtI8BzLf
 6uI8+n41raMZvhbxoc/9+6Q3WG9KbwymQnMuDBV/uRg==
X-Gm-Gg: AYBFou32sRG1tUYL0FOavy5CWL+hSkJafwCGRXdxfFtwDmkO63rCvEiTh2kvtlF4+XU
 MeOCFePjYNJPF31PvYSnEYg4nbSZP7rbkLFJLiu9ylMz6mZPTxITTdHSrwztZ0yoY1Vki0e30Ej
 5ysPaqUvYHtuRn+eCBsRcnZ2MJnlgLtndba6D6kqKwN1Y6UV/jhWB+mCGEcF4Vm+wCiCeXoV7A9
 PC3LRH8XzEt4qO076cDDJaNyVORNb7a1EL/cOApuJLIqJBAOSUV7ZevHqrCY/ajOgIDXsdMAt7E
 ixMuduTLttjvfr7OwqCm2yrYPoIU85pu0i80re9cZwxAeWk2dwfKyTt99mPFTgRC1bnag2cJjRR
 1Qv+W0S0xRDRs4g==
X-Received: by 2002:a05:6122:e004:10b0:5bf:9461:91d with SMTP id
 71dfb90a1353d-5c7ed7dd661mr8415206e0c.5.1788974189712; Wed, 09 Sep 2026
 10:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260909160637.3607104-1-rtice@cisco.com>
 <20260909160637.3607104-2-rtice@cisco.com>
In-Reply-To: <20260909160637.3607104-2-rtice@cisco.com>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 9 Sep 2026 10:16:18 -0700
X-Gm-Features: AcwNN1VTm_h3ex1YRBdTOnorSCbINxZdpuVB-17TNvE8ZkcjPmhsPfjFSlBWDpU
Message-ID: <CAOaVG154GgZGQ56nGujW-bOUi9HYU9T0pqUQVMHyNHYu-1ayqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drivers: fix CN20K mbuf size truncation
To: Randy L Tice <rtice@cisco.com>
Cc: dev <dev@dpdk.org>, stable <stable@dpdk.org>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, rbhansali@marvell.com
Content-Type: multipart/alternative; boundary="00000000000017297a065b100362"
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

--00000000000017297a065b100362
Content-Type: text/plain; charset="UTF-8"

stop "cargo culting" use of always inline attribute. that attribute should
only be used in special cases where code breaks compilation without it. it
is not a go faster flag

On Wed, Sep 9, 2026, 09:06 Randy L Tice <rtice@cisco.com> wrote:

> CN20K inline security receive paths recover the packet mbuf by
> subtracting sizeof(struct rte_mbuf) from a pointer stored in
> completion metadata.
>
> The size is currently kept in a uint8_t local variable before
> that subtraction. This truncates the value when the mbuf structure
> grows beyond 255 bytes, and can recover the wrong mbuf address.
>
> Use a uint32_t local value for the mbuf byte size so larger mbuf
> layouts are handled correctly.
>
> Fixes: 5856f23129bb ("net/cnxk: support CN20K inline IPsec Rx")
> Fixes: edd0d5f3c299 ("event/cnxk: support CN20K inline IPsec Rx")
> Cc: stable@dpdk.org
>
> Signed-off-by: Randy L Tice <rtice@cisco.com>
> ---
>  .mailmap                          | 1 +
>  drivers/event/cnxk/cn20k_worker.h | 4 ++--
>  drivers/net/cnxk/cn20k_rx.h       | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index fcb3d1bb3f..2a8b54ea23 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1379,6 +1379,7 @@ Rakesh Kudurumalla <rkudurumalla@marvell.com> <
> rkudurumalla@caviumnetworks.com>
>  Ralf Hoffmann <ralf.hoffmann@allegro-packets.com>
>  Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com>
>  Rami Rosen <ramirose@gmail.com> <roszenrami@gmail.com>
> +Randy L Tice <rtice@cisco.com>
>  Randy Schacher <stuart.schacher@broadcom.com>
>  Rani Sharoni <ranish@nvidia.com>
>  Ranjit Menon <ranjit.menon@intel.com>
> diff --git a/drivers/event/cnxk/cn20k_worker.h
> b/drivers/event/cnxk/cn20k_worker.h
> index 6442113e09..5723a6eabb 100644
> --- a/drivers/event/cnxk/cn20k_worker.h
> +++ b/drivers/event/cnxk/cn20k_worker.h
> @@ -48,7 +48,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id,
> const uint32_t flags, struc
>  {
>         uint64_t mbuf_init = 0x100010000ULL | RTE_PKTMBUF_HEADROOM;
>         struct cnxk_timesync_info *tstamp = ws->tstamp[port_id];
> -       uint8_t m_sz = sizeof(struct rte_mbuf);
> +       const uint32_t m_sz = sizeof(struct rte_mbuf);
>         void *lookup_mem = ws->lookup_mem;
>         uint64_t meta_aura = 0, laddr = 0;
>         uintptr_t lbase = ws->lmt_base;
> @@ -165,7 +165,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id,
> const uint32_t flags, struc
>  static __rte_always_inline void
>  cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const
> uint32_t flags)
>  {
> -       uint8_t m_sz = sizeof(struct rte_mbuf);
> +       const uint32_t m_sz = sizeof(struct rte_mbuf);
>         uintptr_t sa_base = 0;
>
>         u64[0] = (u64[0] & (0x3ull << 32)) << 6 | (u64[0] & (0x3FFull <<
> 36)) << 4 |
> diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
> index f8fa6de2b9..b544868c03 100644
> --- a/drivers/net/cnxk/cn20k_rx.h
> +++ b/drivers/net/cnxk/cn20k_rx.h
> @@ -702,7 +702,7 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf
> **rx_pkts, uint16_t pkts, co
>         uint64_t mbuf_init = rxq->mbuf_initializer;
>         const void *lookup_mem = rxq->lookup_mem;
>         const uint64_t data_off = rxq->data_off;
> -       uint8_t m_sz = sizeof(struct rte_mbuf);
> +       const uint32_t m_sz = sizeof(struct rte_mbuf);
>         const uint64_t wdata = rxq->wdata;
>         const uint32_t qmask = rxq->qmask;
>         const uintptr_t desc = rxq->desc;
> @@ -815,7 +815,7 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct
> rte_mbuf **rx_pkts, uint16_t pk
>         uint64_t mbuf_init = rxq->mbuf_initializer;
>         const void *lookup_mem = rxq->lookup_mem;
>         const uint64_t data_off = rxq->data_off;
> -       uint8_t m_sz = sizeof(struct rte_mbuf);
> +       const uint32_t m_sz = sizeof(struct rte_mbuf);
>         const uint64_t wdata = rxq->wdata;
>         const uint32_t qmask = rxq->qmask;
>         const uintptr_t desc = rxq->desc;
> --
> 2.35.6
>
>

--00000000000017297a065b100362
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">stop &quot;cargo culting&quot; use of always inline attri=
bute. that attribute should only be used in special cases where code breaks=
 compilation without it. it is not a go faster flag</div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Wed, Sep 9, 2026, 09:06 Randy L Tice &lt;<a href=3D"mailto:rtice@cisco.com=
">rtice@cisco.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">CN20K inline security receive paths recover the packet mbu=
f by<br>
subtracting sizeof(struct rte_mbuf) from a pointer stored in<br>
completion metadata.<br>
<br>
The size is currently kept in a uint8_t local variable before<br>
that subtraction. This truncates the value when the mbuf structure<br>
grows beyond 255 bytes, and can recover the wrong mbuf address.<br>
<br>
Use a uint32_t local value for the mbuf byte size so larger mbuf<br>
layouts are handled correctly.<br>
<br>
Fixes: 5856f23129bb (&quot;net/cnxk: support CN20K inline IPsec Rx&quot;)<b=
r>
Fixes: edd0d5f3c299 (&quot;event/cnxk: support CN20K inline IPsec Rx&quot;)=
<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank" rel=3D"noreferrer"=
>stable@dpdk.org</a><br>
<br>
Signed-off-by: Randy L Tice &lt;<a href=3D"mailto:rtice@cisco.com" target=
=3D"_blank" rel=3D"noreferrer">rtice@cisco.com</a>&gt;<br>
---<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0drivers/event/cnxk/cn20k_worker.h | 4 ++--<br>
=C2=A0drivers/net/cnxk/cn20k_rx.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A03 files changed, 5 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index fcb3d1bb3f..2a8b54ea23 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -1379,6 +1379,7 @@ Rakesh Kudurumalla &lt;<a href=3D"mailto:rkudurumalla=
@marvell.com" target=3D"_blank" rel=3D"noreferrer">rkudurumalla@marvell.com=
</a>&gt; &lt;<a href=3D"mailto:rkudurumalla@caviumnetworks.com" target=3D"_=
blank" rel=3D"noreferrer">rkudurumalla@caviumnetworks.com</a>&gt;<br>
=C2=A0Ralf Hoffmann &lt;<a href=3D"mailto:ralf.hoffmann@allegro-packets.com=
" target=3D"_blank" rel=3D"noreferrer">ralf.hoffmann@allegro-packets.com</a=
>&gt;<br>
=C2=A0Rami Rosen &lt;<a href=3D"mailto:ramirose@gmail.com" target=3D"_blank=
" rel=3D"noreferrer">ramirose@gmail.com</a>&gt; &lt;<a href=3D"mailto:rami.=
rosen@intel.com" target=3D"_blank" rel=3D"noreferrer">rami.rosen@intel.com<=
/a>&gt;<br>
=C2=A0Rami Rosen &lt;<a href=3D"mailto:ramirose@gmail.com" target=3D"_blank=
" rel=3D"noreferrer">ramirose@gmail.com</a>&gt; &lt;<a href=3D"mailto:rosze=
nrami@gmail.com" target=3D"_blank" rel=3D"noreferrer">roszenrami@gmail.com<=
/a>&gt;<br>
+Randy L Tice &lt;<a href=3D"mailto:rtice@cisco.com" target=3D"_blank" rel=
=3D"noreferrer">rtice@cisco.com</a>&gt;<br>
=C2=A0Randy Schacher &lt;<a href=3D"mailto:stuart.schacher@broadcom.com" ta=
rget=3D"_blank" rel=3D"noreferrer">stuart.schacher@broadcom.com</a>&gt;<br>
=C2=A0Rani Sharoni &lt;<a href=3D"mailto:ranish@nvidia.com" target=3D"_blan=
k" rel=3D"noreferrer">ranish@nvidia.com</a>&gt;<br>
=C2=A0Ranjit Menon &lt;<a href=3D"mailto:ranjit.menon@intel.com" target=3D"=
_blank" rel=3D"noreferrer">ranjit.menon@intel.com</a>&gt;<br>
diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_w=
orker.h<br>
index 6442113e09..5723a6eabb 100644<br>
--- a/drivers/event/cnxk/cn20k_worker.h<br>
+++ b/drivers/event/cnxk/cn20k_worker.h<br>
@@ -48,7 +48,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, cons=
t uint32_t flags, struc<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mbuf_init =3D 0x100010000ULL | RTE_PKT=
MBUF_HEADROOM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct cnxk_timesync_info *tstamp =3D ws-&gt;ts=
tamp[port_id];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t m_sz =3D sizeof(struct rte_mbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t m_sz =3D sizeof(struct rte_mbuf)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *lookup_mem =3D ws-&gt;lookup_mem;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t meta_aura =3D 0, laddr =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t lbase =3D ws-&gt;lmt_base;<br>
@@ -165,7 +165,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, co=
nst uint32_t flags, struc<br>
=C2=A0static __rte_always_inline void<br>
=C2=A0cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, c=
onst uint32_t flags)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t m_sz =3D sizeof(struct rte_mbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t m_sz =3D sizeof(struct rte_mbuf)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uintptr_t sa_base =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u64[0] =3D (u64[0] &amp; (0x3ull &lt;&lt; 32)) =
&lt;&lt; 6 | (u64[0] &amp; (0x3FFull &lt;&lt; 36)) &lt;&lt; 4 |<br>
diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h<br>
index f8fa6de2b9..b544868c03 100644<br>
--- a/drivers/net/cnxk/cn20k_rx.h<br>
+++ b/drivers/net/cnxk/cn20k_rx.h<br>
@@ -702,7 +702,7 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf **r=
x_pkts, uint16_t pkts, co<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mbuf_init =3D rxq-&gt;mbuf_initializer=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const void *lookup_mem =3D rxq-&gt;lookup_mem;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint64_t data_off =3D rxq-&gt;data_off;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t m_sz =3D sizeof(struct rte_mbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t m_sz =3D sizeof(struct rte_mbuf)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint64_t wdata =3D rxq-&gt;wdata;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint32_t qmask =3D rxq-&gt;qmask;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uintptr_t desc =3D rxq-&gt;desc;<br>
@@ -815,7 +815,7 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_mb=
uf **rx_pkts, uint16_t pk<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mbuf_init =3D rxq-&gt;mbuf_initializer=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const void *lookup_mem =3D rxq-&gt;lookup_mem;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint64_t data_off =3D rxq-&gt;data_off;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t m_sz =3D sizeof(struct rte_mbuf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t m_sz =3D sizeof(struct rte_mbuf)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint64_t wdata =3D rxq-&gt;wdata;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint32_t qmask =3D rxq-&gt;qmask;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const uintptr_t desc =3D rxq-&gt;desc;<br>
-- <br>
2.35.6<br>
<br>
</blockquote></div>

--00000000000017297a065b100362--
