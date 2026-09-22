Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2DFC982F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 06:02:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AD12402D6;
	Tue, 22 Sep 2026 08:02:53 +0200 (CEST)
Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com
 [74.125.231.168])
 by mails.dpdk.org (Postfix) with ESMTP id 3FCBF4026C
 for <dev@dpdk.org>; Tue, 22 Sep 2026 08:02:52 +0200 (CEST)
Received: by mail-oo2-f40.google.com with SMTP id
 006d021491bc7-6c72bd8a017so2337100eaf.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 23:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790056971; cv=none;
 d=google.com; s=arc-20260327;
 b=k8JK8Qi41p7MVqvu5JdlW78k0iukVuGWS5O8Kh/E6bgrtIOEHOuUKO+pQKsg0Zc6GJ
 Bip19gGKEEr0c1u518jlYe32i6kGTC9NphaUW4CrSn6R1a9b5L0gu+kSyGgXsBlTKLey
 wgAak5PTo1rIouQGRCta1NXq0MeI8dH+/xSFH9+0Gb68qFk7Fu4rQ0CbFgqJSqgaj8Gs
 U3h1cdjfgy3vIYw8F0RB6U0DtrjUp6KLjnQKEqwTYA2u7VOKgvmQxPa/DuXpr+e9HGme
 hPREMGQDrozL3z6JHFVZPjWgccyFQylKuiTkUcm/GoHmlksBTVm+YaplXwQI0i/eI0wx
 irdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5hKMmCmPWD5/QjKTav5GyGZNAcfabKi3S8qsdijkmYA=;
 fh=gpg6MfolvWiJyB9/XSLzB05SqCK9tXDNrddjKndCcoU=;
 b=Q/UW20elWM5qzZArshG9IzQkWrZ/p2e95b56Q2bFju/EyP2M1XEWs6YBDVk+cKlti6
 kiJPx6UsPvFG9xkdbUJk3RhqEIvJK7u1ZsmCs+WpNyqIvvZlSjSMDYRTHAphQ7DH4t0v
 T6SSYiyOqcLUykyxzmTg88qMNYkuvmTfOunyz4yXKdRb8kzZyB4E/M6PPVz+h1WyZgHK
 9hsMRo8vvtm2U+UBcBzq2DuVXMAiw6KQzDhWNPMtaiYV7Hu3Ty4bSZvlSUFkDTqSXmug
 P5Rn4+zgDuBY8EoY7I4kC+lNi+sg2/dbwSlu+RoTEXEEM+Sc8h8r6v62tDQY/B/tosvk
 cLQA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790056971; x=1790661771; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5hKMmCmPWD5/QjKTav5GyGZNAcfabKi3S8qsdijkmYA=;
 b=N895XD2jprVTRLCmBXeWgMf67gEqC0W96mefDDwY3aMo8SXxS496mFBaRe6yDqi6Qy
 PT2jFzsbUcQEz56cm+N4JbN76Qqa7nUYwTEqoZzlF4rRboIAX6iVrHZ2xBS798SRDQM3
 Gft5ZEP5D7E+Pue/a6WVOHHn5ZB0vQ+nmzpf5z8CmGkRBgtUDD4vDBs1oDj6doS8WE/E
 vK8GOo6bECyOPFy9YsjWg2BoBvTKrJ7G6lRaMeWpUfX/2WrmbXkgyr0sUJxvw8rkWszh
 HHE1rpLqLHusrVwgIn7j0KB0nKE3lWNMYpikdFYdfI2N9ndAqX/OROImaAPsj0UMu1BF
 w+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790056971; x=1790661771;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5hKMmCmPWD5/QjKTav5GyGZNAcfabKi3S8qsdijkmYA=;
 b=FIOoOQ5tjTXERzijIJlHMn8fMrRr/qq1LJtGTi0nvXUSoLIDanIw7WuYvSM1x7JP1T
 M2or8YBdkltj523vRfJS5xWjr3b1grr8BzWwyQMUXGjjvRSDTgRU6hAnQtx3xwRWyM/W
 qP84usUyLerr9F0iUI1UMrp4oCwra0xxJSjftftlFPXeglCkZviyTqpM7NgyTxwH9BwR
 S59lXNR2Db0+s68lNMU3J7wNhmZqvDxyJnDpnl2inYeHFi3lLm4bqFV/2/fjmUbVTHz6
 OssKnpYv06TJWvZsmqZYuCZOcJ5qJJwZ1xm9lry5rbJFIHRSAtUhU1NWYkfIg2gfSNSV
 anLw==
X-Gm-Message-State: AFuF++lvLv9ja7x3tByxl4OKQfdEFX2NLTosQezRh5s46FHhqxr50fph
 WZFHGMf29zhdSeFdC9n6J3QgHlPpjQzDJcUCSs+vu8K1vP1n9JRpJGmNh1f/GQ52WTqn8KeO1az
 nlil0GMkkMtIYcDRGlS2DCssNkJ77b4s=
X-Gm-Gg: AYBFou0dk9Q0G6jm/WrNgqQkqgjwWH532SU2uSWf1s/uzbYsdCz0B9q0Ss0J5vVa30h
 t7bjl3dBC556WxA/AGGJtq9G/2mL4J+JyJ9Pns8R2Ny981c0rY9to46psh+F9WMtED6q3Kj+jLu
 nky2scW+/8/qQEo1E05dRsfm+bB5Fa/qdj5JqhYaX+Ap7RzyTU0jyKLoKTZ3oa6hP+oxzMjPZ+E
 420iUymGMIXxaAqBU0WZ0qBqggFzN/9ByU1THlz0uSgfyTJxbztZrIpy+GmEHDo4mcyFLKLfu+C
 tpyZpGsPFgrPNandLOISnJ0C5GR8PUCBxtZoRObfE4SeoL4vkBxc5lcU
X-Received: by 2002:a05:6820:1606:b0:6b7:83d6:2927 with SMTP id
 006d021491bc7-6ca9c654831mr12098159eaf.42.1790056971243; Mon, 21 Sep 2026
 23:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260909160637.3607104-1-rtice@cisco.com>
 <20260909160637.3607104-2-rtice@cisco.com>
In-Reply-To: <20260909160637.3607104-2-rtice@cisco.com>
From: Nithin Dabilpuram <nithind1988@gmail.com>
Date: Tue, 22 Sep 2026 11:32:39 +0530
X-Gm-Features: AcwNN1UmxoWGP6BhiiYV4XOYjTw7RyDYo_KUjP-720WO9FgKxCDeca7QKc3ugXE
Message-ID: <CAMuDWKRJLZLLq5XLGNmysd7=GiNCOvGh+u=p510RqDNktOdbVg@mail.gmail.com>
Subject: Re: [PATCH 1/1] drivers: fix CN20K mbuf size truncation
To: Randy L Tice <rtice@cisco.com>
Cc: dev@dpdk.org, stable@dpdk.org, thomas@monjalon.net, 
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

Acked-by: Nithin Dabilpuram <ndabilpuram@marvell.com>

On Wed, Sep 9, 2026 at 9:37=E2=80=AFPM Randy L Tice <rtice@cisco.com> wrote=
:
>
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
> @@ -1379,6 +1379,7 @@ Rakesh Kudurumalla <rkudurumalla@marvell.com> <rkud=
urumalla@caviumnetworks.com>
>  Ralf Hoffmann <ralf.hoffmann@allegro-packets.com>
>  Rami Rosen <ramirose@gmail.com> <rami.rosen@intel.com>
>  Rami Rosen <ramirose@gmail.com> <roszenrami@gmail.com>
> +Randy L Tice <rtice@cisco.com>
>  Randy Schacher <stuart.schacher@broadcom.com>
>  Rani Sharoni <ranish@nvidia.com>
>  Ranjit Menon <ranjit.menon@intel.com>
> diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k=
_worker.h
> index 6442113e09..5723a6eabb 100644
> --- a/drivers/event/cnxk/cn20k_worker.h
> +++ b/drivers/event/cnxk/cn20k_worker.h
> @@ -48,7 +48,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, co=
nst uint32_t flags, struc
>  {
>         uint64_t mbuf_init =3D 0x100010000ULL | RTE_PKTMBUF_HEADROOM;
>         struct cnxk_timesync_info *tstamp =3D ws->tstamp[port_id];
> -       uint8_t m_sz =3D sizeof(struct rte_mbuf);
> +       const uint32_t m_sz =3D sizeof(struct rte_mbuf);
>         void *lookup_mem =3D ws->lookup_mem;
>         uint64_t meta_aura =3D 0, laddr =3D 0;
>         uintptr_t lbase =3D ws->lmt_base;
> @@ -165,7 +165,7 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, =
const uint32_t flags, struc
>  static __rte_always_inline void
>  cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, cons=
t uint32_t flags)
>  {
> -       uint8_t m_sz =3D sizeof(struct rte_mbuf);
> +       const uint32_t m_sz =3D sizeof(struct rte_mbuf);
>         uintptr_t sa_base =3D 0;
>
>         u64[0] =3D (u64[0] & (0x3ull << 32)) << 6 | (u64[0] & (0x3FFull <=
< 36)) << 4 |
> diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
> index f8fa6de2b9..b544868c03 100644
> --- a/drivers/net/cnxk/cn20k_rx.h
> +++ b/drivers/net/cnxk/cn20k_rx.h
> @@ -702,7 +702,7 @@ cn20k_nix_recv_pkts(void *rx_queue, struct rte_mbuf *=
*rx_pkts, uint16_t pkts, co
>         uint64_t mbuf_init =3D rxq->mbuf_initializer;
>         const void *lookup_mem =3D rxq->lookup_mem;
>         const uint64_t data_off =3D rxq->data_off;
> -       uint8_t m_sz =3D sizeof(struct rte_mbuf);
> +       const uint32_t m_sz =3D sizeof(struct rte_mbuf);
>         const uint64_t wdata =3D rxq->wdata;
>         const uint32_t qmask =3D rxq->qmask;
>         const uintptr_t desc =3D rxq->desc;
> @@ -815,7 +815,7 @@ cn20k_nix_flush_recv_pkts(void *rx_queue, struct rte_=
mbuf **rx_pkts, uint16_t pk
>         uint64_t mbuf_init =3D rxq->mbuf_initializer;
>         const void *lookup_mem =3D rxq->lookup_mem;
>         const uint64_t data_off =3D rxq->data_off;
> -       uint8_t m_sz =3D sizeof(struct rte_mbuf);
> +       const uint32_t m_sz =3D sizeof(struct rte_mbuf);
>         const uint64_t wdata =3D rxq->wdata;
>         const uint32_t qmask =3D rxq->qmask;
>         const uintptr_t desc =3D rxq->desc;
> --
> 2.35.6
>
