Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689D9CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 02:49:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92E42402EB;
	Fri, 16 Oct 2026 04:49:38 +0200 (CEST)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42]) by mails.dpdk.org (Postfix) with ESMTP id 42504400EF
 for <dev@dpdk.org>; Fri, 16 Oct 2026 04:49:37 +0200 (CEST)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so2423121d50.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 19:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792118976; cv=none;
 d=google.com; s=arc-20260327;
 b=W2hgojcgDSlZfnoLmiXrqLU3nMIikH2lK/CzYW3EweEeshTu34Y+f6jQekHLcpBT9R
 jVLhn7+sQ2oEGTDb3NNMgwJeCWz8K6fXNi/UpzrjB9NGQy/Ycd2XeSCOqZ4D4z12U3c2
 avO8ZGy8hkbKxzTBoKbw2+myyO9kU7Q+K2PbGbkNgnVFOWZDLfO1iOvaBQx3QMAri8Uf
 IwcwmHHeRIImbh2IL0whUiAEBxw1KVH2bXCPmNkw9b18gQUgAb8gbhaxos786S5Dithb
 ehl2MJ7R0aFJ95DC9CmuGI8JlqhRN9WNNuKOvo0eg/2zUkDtgH3yAs+ObYtAjLOX/q7H
 JLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HA5ZvZGIkWFg6xoZ/QYATcb3gO13P6DtsGILJOJcUHw=;
 fh=H3Xhn9QvJJ0RZTahh/KbHsMLFNitrfUoo69XQZUqnso=;
 b=mz9Od3/gTBOVOOooy2O8cW96X/+Hpj6T4dlbVGXmkr9MA7pAJsAcSmzn0MUvXicItq
 2UMM7+2Hv0eq2Se8jipMWzkvQixY9latUZ1oqh++f2MIU116L25SYjgE0lNUWcLYXnSR
 qFARWieoDpbjT8ObAUYHjeLl3kWeR8OGPhyFK16063ov39wKs6NVy5mJcNZhOD8JXyPP
 hbyH9xena0OVuanOnEP8SFC5ANZxukEDMmbT47SrR9AKx4AP0EI08Nnav6nr5+GbiGca
 nQIo9/zyJXPk7zjxQgFRIt7kNn/X3auHWrn8aBD1hWw2BP0i04Hk3ZhLfoTzuRWASEj5
 hP7w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792118976; x=1792723776; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HA5ZvZGIkWFg6xoZ/QYATcb3gO13P6DtsGILJOJcUHw=;
 b=EY+tW1dvSlG1fRblUfw+G9RK1SS5XjXuxF2qpN/MfQGTHfUN5+fFTsa+yERl6c3k5Z
 CeYNR4g4wZ2nWoRCQcsgnfkn1Q0HAz1BABSu78biVnnV7VS3uvrmHYw2zDA369RdbQ9c
 SNSZY2c39W6dRkNh6hY7/bftgcyoKdihiE9n/gvAwPZLyqGNb5CKL0Mb5x5PojRFMMId
 aoS84CCIgOD9LE9Jk0TD8i8H7iU19KbCh3shP6kGWqVHPfh95Pq0cc/L3Lw8amMMP++W
 Ek2Pjn78hoVGC9dzC4vBdxYkhVlnTzYhS3vPfhaENmDk08zQAjysg6p7I5BxovcovX8S
 Lffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792118976; x=1792723776;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HA5ZvZGIkWFg6xoZ/QYATcb3gO13P6DtsGILJOJcUHw=;
 b=MMVQN7WCy/724SuJt9wwRM6NL2uKbxEP1/W/SU4ea6FWI/CdQ/IgjZMpj4Y3kNdhJl
 5UX+TDzaPTo9BOEX3aAZ6gyjVEyMOshhbzxsvPd/y6ktd3VRHB25zsMr9VaoufgA35qB
 2GIdBR7wRY17W72T3h+0kv71lll1/OVezmUAD1p0RXABAS2p1yrLiVvEWqUif00OJJgw
 Bo31ak0piMPSQuykvmirjcxJSfKh3FBcoWz3ujf8zFv3zhh2cT+b4rxhHkv++V0KLEh9
 YOCOSKljlRooYj447EcdpVNzQjxrag5NEUv3nbHUOjmd2t07983J5IbqbfbBIS7QKDEa
 erwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5dCRTNoAjSEARwEj4cdKtynVtt3M//p+tDowKCyHdqN88S/cjfBaIYobcuEkUXjgX2fg=@dpdk.org
X-Gm-Message-State: AFq9FYKzkIsvCjeaps1yU94YznkFFgWVh/mDnbQYvkAK31/OQJ5iEOZX
 CrIbmC7gJKLoar7PUdgIkalKI4DLT23so4nl/wmrKtrVLNksjMLwBtxXhzzGE1KYFdnSVH/5jkK
 FLC3xwHJjyW6OR8R+quxhyeHJSZqComM=
X-Gm-Gg: AYBFou3judFHab66fve1oGSOk6guqSj0C/+msJrsdxAxjnbNDUOKubnG3Zg4+/pWsl3
 lQlY7iH1ucK5Yi+4OgIKJoeXJLCw8GfX/n5FYMVxfS0b1+jTI0nDihjejLf+c4N4ZFiuVrTmIwJ
 mk5/64NxhWzQhJkyG5+u6moUA1cBTTnYLSV0FJ+eMgn1qYNN7dPMwlvyItkYMbeINs+i0wVtmlH
 iVCFIxgR9RaYXHz1P/eChDCIeYNOBr19i0MBPzsx2f2ODwjUAtOp4v/D66i9Z+1mxPiC5DHzJDS
 /c3DWJqUH2vH6EV3mTIOZShNaZEtgW9y0UqI1QMjOAFSOB/G2IpqQwQCUuc7CaYyonfTKSAX0kr
 o6Ok756TS8Tb0c196z19h8KVzyy4Jp2kZsNIZzk3T++Im+gJWqu2oce23NYLa40WpgYDflDKgOq
 wGFRbWpQI7oHrvO4Lr
X-Received: by 2002:a05:690e:1187:b0:679:ad30:f006 with SMTP id
 956f58d0204a3-679ad3101cemr541436d50.81.1792118976392; Thu, 15 Oct 2026
 19:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260909160637.3607104-1-rtice@cisco.com>
 <20260909160637.3607104-2-rtice@cisco.com>
 <CAMuDWKRJLZLLq5XLGNmysd7=GiNCOvGh+u=p510RqDNktOdbVg@mail.gmail.com>
In-Reply-To: <CAMuDWKRJLZLLq5XLGNmysd7=GiNCOvGh+u=p510RqDNktOdbVg@mail.gmail.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Fri, 16 Oct 2026 08:19:09 +0530
X-Gm-Features: AclHuK9GZVmSg0vO8FYlYDhRC-0l8Wtot7iVh4z7JWLRujGsneOyXqW0iCraYHU
Message-ID: <CALBAE1MKkdBc_h_mEJcTMy7jeYC0aYgq2Fhini6fjhgALj-uwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drivers: fix CN20K mbuf size truncation
To: Nithin Dabilpuram <nithind1988@gmail.com>
Cc: Randy L Tice <rtice@cisco.com>, dev@dpdk.org, stable@dpdk.org,
 thomas@monjalon.net, 
 pbhagavatula@marvell.com, sthotton@marvell.com, ndabilpuram@marvell.com, 
 kirankumark@marvell.com, skori@marvell.com, skoteshwar@marvell.com, 
 hkalra@marvell.com, rbhansali@marvell.com
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

On Tue, Sep 22, 2026 at 11:39=E2=80=AFAM Nithin Dabilpuram
<nithind1988@gmail.com> wrote:
>
> Acked-by: Nithin Dabilpuram <ndabilpuram@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks

>
> On Wed, Sep 9, 2026 at 9:37=E2=80=AFPM Randy L Tice <rtice@cisco.com> wro=
te:
> >
> > CN20K inline security receive paths recover the packet mbuf by
> > subtracting sizeof(struct rte_mbuf) from a pointer stored in
> > completion metadata.
> >
> > The size is currently kept in a uint8_t local variable before
> > that subtraction. This truncates the value when the mbuf structure
> > grows beyond 255 bytes, and can recover the wrong mbuf address.
> >
> > Use a uint32_t local value for the mbuf byte size so larger mbuf
> > layouts are handled correctly.
> >
> > Fixes: 5856f23129bb ("net/cnxk: support CN20K inline IPsec Rx")
> > Fixes: edd0d5f3c299 ("event/cnxk: support CN20K inline IPsec Rx")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Randy L Tice <rtice@cisco.com>
> > ---
> >  .mailmap                          | 1 +
> >  drivers/event/cnxk/cn20k_worker.h | 4 ++--
> >  drivers/net/cnxk/cn20k_rx.h       | 4 ++--
> >  3 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/.mailmap b/.mailmap
> > index fcb3d1bb3f..2a8b54ea23 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -1379,6 +1379,7 @@ Rakesh Kudurumalla <rkudurumalla@marvell.com> <rk=
udurumalla@caviumnetworks.com>
> >  Ralf Hoffmann <ralf.hoffmann@allegro-packets.com>
> >  Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com>
> >  Rami Rosen <ramirose@gmail.com> <roszenrami@gmail.com>
> > +Randy L Tice <rtice@cisco.com>
> >  Randy Schacher <stuart.schacher@broadcom.com>
> >  Rani Sharoni <ranish@nvidia.com>
> >  Ranjit Menon <ranjit.menon@intel.com>
> > diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn2=
0k_worker.h
> > index 6442113e09..5723a6eabb 100644
> > --- a/drivers/event/cnxk/cn20k_worker.h
> > +++ b/drivers/event/cnxk/cn20k_worker.h
> > @@ -48,7 +48,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, =
const uint32_t flags, struc
> >  {
> >         uint64_t mbuf_init =3D 0x100010000ULL | RTE_PKTMBUF_HEADROOM;
> >         struct cnxk_timesync_info *tstamp =3D ws->tstamp[port_id];
> > -       uint8_t m_sz =3D sizeof(struct rte_mbuf);
> > +       const uint32_t m_sz =3D sizeof(struct rte_mbuf);
> >         void *lookup_mem =3D ws->lookup_mem;
> >         uint64_t meta_aura =3D 0, laddr =3D 0;
> >         uintptr_t lbase =3D ws->lmt_base;
> > @@ -165,7 +165,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id=
, const uint32_t flags, struc
> >  static __rte_always_inline void
> >  cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, co=
nst uint32_t flags)
> >  {
> > -       uint8_t m_sz =3D sizeof(struct rte_mbuf);
> > +       const uint32_t m_sz =3D sizeof(struct rte_mbuf);
> >         uintptr_t sa_base =3D 0;
> >
> >         u64[0] =3D (u64[0] & (0x3ull << 32)) << 6 | (u64[0] & (0x3FFull=
 << 36)) << 4 |
> > diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
> > index f8fa6de2b9..b544868c03 100644
> > --- a/drivers/net/cnxk/cn20k_rx.h
> > +++ b/drivers/net/cnxk/cn20k_rx.h
> > @@ -702,7 +702,7 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf=
 **rx_pkts, uint16_t pkts, co
> >         uint64_t mbuf_init =3D rxq->mbuf_initializer;
> >         const void *lookup_mem =3D rxq->lookup_mem;
> >         const uint64_t data_off =3D rxq->data_off;
> > -       uint8_t m_sz =3D sizeof(struct rte_mbuf);
> > +       const uint32_t m_sz =3D sizeof(struct rte_mbuf);
> >         const uint64_t wdata =3D rxq->wdata;
> >         const uint32_t qmask =3D rxq->qmask;
> >         const uintptr_t desc =3D rxq->desc;
> > @@ -815,7 +815,7 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rt=
e_mbuf **rx_pkts, uint16_t pk
> >         uint64_t mbuf_init =3D rxq->mbuf_initializer;
> >         const void *lookup_mem =3D rxq->lookup_mem;
> >         const uint64_t data_off =3D rxq->data_off;
> > -       uint8_t m_sz =3D sizeof(struct rte_mbuf);
> > +       const uint32_t m_sz =3D sizeof(struct rte_mbuf);
> >         const uint64_t wdata =3D rxq->wdata;
> >         const uint32_t qmask =3D rxq->qmask;
> >         const uintptr_t desc =3D rxq->desc;
> > --
> > 2.35.6
> >
