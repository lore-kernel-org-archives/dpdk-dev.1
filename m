Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0A0CA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 08:45:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDA8540289;
	Tue, 19 Aug 2025 10:45:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7487E40262
 for <dev@dpdk.org>; Tue, 19 Aug 2025 10:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755593141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0JMgwGJZBpYV3RFVBkvGZlva8/HImtuJHagCT7Eyi4=;
 b=K/U1a5qlcHFpxyQF7Y7z3NJrGLR5iEuivNY/aucY0hcQQ1EShrglpAJsS6j/XX4qjfpnwl
 5zdY48saSCHbi6wvVTiVvkj10HYQuFVM6adbR6J0LagdAqIhvRFsJlLWjU07gnEiBxt6MR
 mxgIDZ2yxxNaRPFMs9rZ2QNQ5zQgXEs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-Xd5QQ9BuPb6nBqx8dKGfOw-1; Tue, 19 Aug 2025 04:45:40 -0400
X-MC-Unique: Xd5QQ9BuPb6nBqx8dKGfOw-1
X-Mimecast-MFC-AGG-ID: Xd5QQ9BuPb6nBqx8dKGfOw_1755593139
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55ce5252d01so2901797e87.2
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755593139; x=1756197939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0JMgwGJZBpYV3RFVBkvGZlva8/HImtuJHagCT7Eyi4=;
 b=SX39YGdr9ONShH+juu9eCYxl42KoH1o3aVMu3RVysW3Lnz6aAcVovXpAWUgZA9RCRO
 hZSqOY59c3rfE5RDPb19TK6bU/9PVWgwiJt+VApOH9vvyDSD+nRcOvPOKLJbz78yKMwC
 SuqxR7Ec58FeTDAgVdlScP77Et9Mo7FSFMHhpKSu9ao+midXVJvx+1o+0qYE704rbajI
 mG0S/1YISRLImIy2AuUbrChXheUbbYgTKzYF8j704wK8YfgfPquEXTDkA3k3VQJHLW6Y
 2j27mj2UGVhhJ41fbLWukvtZmtc6Rn4A5iHdPEObx9a54d51Q1IGOkPQ8UWaaVx3Tdy3
 bIbg==
X-Gm-Message-State: AOJu0YyVSSTl2/RqzIPf//mh+3PAkxQuofa6zUtSZ2m0bMQe2Ei88Zvu
 k78FG9UfdGRluCbN37o7WXXGtDiQ5acSEwT8IixvOXMeKDRv3ZOsjJ7nwru8v50t54WECQ9uYI+
 U1Vf793qY4LQAOMCphmQtJcmGXJF4qaoG2tTp9vOQRnhxBgoGj7jRpTVTT+vnOVc6rekhAYECl8
 M2Fha3OQ7AczzLjq8wk2I=
X-Gm-Gg: ASbGncuR19p054YxOdlLOx18vpU8LY1okLUijztenmE7oDlObVLpEF77cBufkV3XJ2E
 +ZnB7iug17LmqTbKGp/L8H+eECSpMZet8mRZ0wXufuwPWnUUnJHYeA5lRhltwo0eJcP5GXB79by
 SlQjR35HbGt68m6fnen68wvYM=
X-Received: by 2002:a05:6512:31d2:b0:55b:9192:319b with SMTP id
 2adb3069b0e04-55e007e3cf4mr536795e87.53.1755593138773; 
 Tue, 19 Aug 2025 01:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVw7YHFqDVj58KDWG6TcEX5dARaviB4EO5O/J8+xNLhU8mt0515niYVEG+kSX77mT9g4O9+VuIaFzLYbo542w=
X-Received: by 2002:a05:6512:31d2:b0:55b:9192:319b with SMTP id
 2adb3069b0e04-55e007e3cf4mr536775e87.53.1755593138230; Tue, 19 Aug 2025
 01:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1753111484-27021-1-git-send-email-andremue@linux.microsoft.com>
 <1753111484-27021-3-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1753111484-27021-3-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 19 Aug 2025 10:45:26 +0200
X-Gm-Features: Ac12FXyAhdnN143aCdJiaiiiD8oOQcyOOonizOkIHQ0yYIS8MxiLtg09bBk5Uvk
Message-ID: <CAJFAV8xqSq3toYR2tUErhab=5aWnTRSL-+wrp8aHJMdzKiMnNg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drivers/net: remove use of non-standard array
 range initialization
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, howard_wang <howard_wang@realsil.com.cn>, 
 Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh <rasland@nvidia.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: siuVi-Egwnmo9Qf6ZafQG-wSWj6rd0b9AZVmT7vL4CQ_1755593139
X-Mimecast-Originator: redhat.com
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

Hello Andre,

On Mon, Jul 21, 2025 at 5:25=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Array range initialization is non-standard and is not provided by
> all compilers. MSVC does not implement it and ends up emitting
> errors like the one below:
>
> drivers/net/r8169/r8169_phy.c(380):
>     error C2143: syntax error: missing ':' before '...'
> case CFG_METHOD_48 ... CFG_METHOD_57:

The commitlog (and title) is not aligned anymore with the patch
content: there is more than the array range init now, and the realtek
driver build error is not relevant anymore.
Please reword.

This comment also applies to the first patch of the series.


>
> The fix is to explicitly initialize each element in the range.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Howard Wang <howard_wang@realsil.com.cn>

Howard acked on the realtek driver update (in a previous revision).
Now that this was reworked in a separate change (if I am not wrong,
commit d9ee71b5f1bc ("net/r8169: support RTL8168 series")), I don't
think this ack should be kept.


> ---
>  drivers/common/mlx5/mlx5_malloc.h   |  4 ++--
>  drivers/net/mlx5/mlx5_flow_dv.c     |  5 ++++-
>  drivers/net/mlx5/mlx5_rx.c          |  4 ++--
>  drivers/net/mlx5/mlx5_utils.c       |  4 ++--
>  drivers/net/octeon_ep/otx_ep_mbox.c | 24 ++++++++++++++++++++----
>  5 files changed, 30 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/common/mlx5/mlx5_malloc.h b/drivers/common/mlx5/mlx5=
_malloc.h
> index 6e5cc3d851..27d3e5bdf2 100644
> --- a/drivers/common/mlx5/mlx5_malloc.h
> +++ b/drivers/common/mlx5/mlx5_malloc.h
> @@ -118,8 +118,8 @@ void mlx5_free(void *addr);
>                 mem; \
>         }))
>  #else
> -#define mlx5_malloc_numa_tolerant(flags, size, align, socket)
> -       (mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (sock=
et)));
> +#define mlx5_malloc_numa_tolerant(flags, size, align, socket) \
> +       (mlx5_malloc((flags) | MLX5_NUMA_TOLERANT, (size), (align), (sock=
et)))

The "outer" () are unneeded.


>  #endif
>  #ifdef __cplusplus
>  }
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow=
_dv.c
> index 7b9e5018b8..54e1d0490a 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -19652,7 +19652,10 @@ mlx5_flow_dv_discover_counter_offset_support(str=
uct rte_eth_dev *dev)
>                 .size =3D sizeof(value.buf),
>         };
>         struct mlx5dv_flow_matcher_attr dv_attr =3D {
> -               .type =3D IBV_FLOW_ATTR_NORMAL | IBV_FLOW_ATTR_FLAGS_EGRE=
SS,
> +               /* Cast below is needed to avoid warning until bug
> +                * (https://bugs.dpdk.org/show_bug.cgi?id=3D1758) is fixe=
d.
> +                */
> +               .type =3D IBV_FLOW_ATTR_NORMAL | (enum ibv_flow_attr_type=
)IBV_FLOW_ATTR_FLAGS_EGRESS,

I assigned the bug to Raslan, I hope mlx5 guys can have a look soon.


>                 .priority =3D 0,
>                 .match_criteria_enable =3D 0,
>                 .match_mask =3D (void *)&mask,
> diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
> index 5e8c312d00..1385b23d94 100644
> --- a/drivers/net/mlx5/mlx5_rx.c
> +++ b/drivers/net/mlx5/mlx5_rx.c
> @@ -1093,7 +1093,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkt=
s, uint16_t pkts_n)
>                                 break;
>                         }
>                         pkt =3D seg;
> -                       MLX5_ASSERT(len >=3D (rxq->crc_present << 2));
> +                       MLX5_ASSERT(len >=3D (int)(rxq->crc_present << 2)=
);
>                         pkt->ol_flags &=3D RTE_MBUF_F_EXTERNAL;
>                         if (rxq->cqe_comp_layout && mcqe)
>                                 cqe =3D &rxq->title_cqe;
> @@ -1273,7 +1273,7 @@ mlx5_rx_burst_out_of_order(void *dpdk_rxq, struct r=
te_mbuf **pkts, uint16_t pkts
>                 }
>                 if (!pkt) {
>                         pkt =3D seg;
> -                       MLX5_ASSERT(len >=3D (rxq->crc_present << 2));
> +                       MLX5_ASSERT(len >=3D (int)(rxq->crc_present << 2)=
);
>                         pkt->ol_flags &=3D RTE_MBUF_F_EXTERNAL;
>                         if (rxq->cqe_comp_layout && mcqe)
>                                 cqe =3D &rxq->title_cqe;
> diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.=
c
> index f31b1652bc..c95e69b40f 100644
> --- a/drivers/net/mlx5/mlx5_utils.c
> +++ b/drivers/net/mlx5/mlx5_utils.c
> @@ -29,8 +29,8 @@
>         mem; \
>  }))
>  #else
> -#define pool_malloc(pool, flags, size, align, socket)
> -       (pool)->cfg.malloc((uint32_t)(flags) | NUMA_TOLERANT, (size), (al=
ign), (socket));
> +#define pool_malloc(pool, flags, size, align, socket) \
> +       (((pool)->cfg.malloc(((uint32_t)(flags) | MLX5_NUMA_TOLERANT), (s=
ize), (align), (socket))))
>  #endif

Ugh, there is a regression in there, from ce2cf3403f2a ("net/mlx5:
support NUMA node fallback") iiuc.
I am surprised this was not caught by the CI with clang.

Do we really need all those (()) ?


--=20
David Marchand

