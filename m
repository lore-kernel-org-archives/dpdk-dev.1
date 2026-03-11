Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804131125852
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:32:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 817AF40ED4;
	Wed, 11 Mar 2026 17:32:11 +0100 (CET)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43]) by mails.dpdk.org (Postfix) with ESMTP id 3BBDB40E2E
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:32:10 +0100 (CET)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-67bb4e8955aso62551eaf.0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773246729;
 x=1773851529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKx/fw9D6/ARzYwV3PpUxI32T4EZAsQIN5L2yV0ML7M=;
 b=qc9PV8dK1dZnl3N4+sEOAlw3SPSV88S/B0qIV9VJNU8dMF/I6rGbg46CJqfmVtMhKn
 9EXGg2sQVC1QvYAayF9k8sX69GZdBmoGtqPziwdOQeIK+HjhLJwxyIaParCJpsqpi/h/
 rm4v8IfULZHbHZgJ0RPXXsJ5Es8U66W1JE3Cw5Oec4s6SukTw9MuKsig/VgjF+nkEV+f
 6Poz4+slv923rgty8cA1GWElBpSwTE1VkDe+oFqH8AL5ytkp8Wg7tS5oKlliENnzHLc2
 abSaOvgMFYLctT3hoSHbZh5MYqocVExRma2z87CAz2VwbFei78sB85eVtd5CsPviu9Il
 UR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773246729; x=1773851529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bKx/fw9D6/ARzYwV3PpUxI32T4EZAsQIN5L2yV0ML7M=;
 b=PmJr3mSWDnF5w+sZSKz32pDyih36wYc+QbAa9Q+NN7yH/Qfu+s6RUZPLD/70kFr+ZT
 NJSh7h5nBqniDZyiS7aSoMNT8b431OVyY1sZBjp3KyhJRcaqpFUn3+H81vxj2VL6qt+V
 KWpnn+wSeQx+fxKwlLsjBA1tLggO8/Qf+V/vZA0C9SoAeEGkTYvjjtMGpr2UBhAFBzzy
 Adt5ZtOqr2GOvhqdi3wSs5VsXSCx8e3xKP0Zw6TGJDk95Ny3qEODdt7CgSJU9PFCk2yS
 uxFwYJ2A7Djgbj9IVE+gQ0fexjjNlld+SirfzR3kHVoyRIYyZYqt3/rJW82iE0yXGTHm
 dh7A==
X-Gm-Message-State: AOJu0YzVubYH4dL+3DNBtuEfD+UmOdWhD5Dg8CwK3Y5asMCGikiVo2lp
 IB3KVyKkmfawVNnP07pBCHWh+msHFNy75Azj91RtS0ljoZel3kF45ojgGG5iL082RXM=
X-Gm-Gg: ATEYQzxVq+G+1y7oSca19RiO2Vz3wCVTqdIv/pcUwbIYFweYh+2yVZbXy7+r+wPZhbm
 t5nh1CCEmCinxpfedehMBEqy1BvClZMQ9xU/WVkx+g2iefmz1SOseRN0qBrUVKVI+jqMJJhu22f
 vMjiJ9wLWu9Gx95ViAsS45KQ+7TemO3LqEjhYlXt7aIx2v/ib7fgrT463n9lhUhUCpqgFIFbPu0
 0sgYaq92HSnKQIiTIELpeais4hrvr3kBtoxgq0ucqozxomXglAqYXW74KsU12G3cVwQCG5H3cWo
 HtdSaIZJS5th8EM4LDV37Re2RMv1PYu4eD3fT5BNILuJh1L+ZMyQK9o5QAziVz9NcZsy/HyvuaM
 anLFlsT9tMAbJF6JoMQvzct2yz8vPWv00Y3qqYXd1K4JjLyyhGq4varZyg8JAZviqs/vZScVE1Z
 SuHu10pP9uRdop+vKpAlDcrUVqONLdMCVPTnI=
X-Received: by 2002:a4a:e903:0:b0:67b:b5ca:cded with SMTP id
 006d021491bc7-67bc89c40a8mr1671019eaf.50.1773246729308; 
 Wed, 11 Mar 2026 09:32:09 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc93061f2sm1686372eaf.10.2026.03.11.09.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:32:08 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:29:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v2 04/10] net/mlx5: add per-queue packet pacing
 infrastructure
Message-ID: <20260311092912.40efad8e@phoenix.local>
In-Reply-To: <20260310232653.2935764-5-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
 <20260310232653.2935764-1-vjardin@free.fr>
 <20260310232653.2935764-5-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 11 Mar 2026 00:26:47 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> Add mlx5_txq_rate_limit structure and alloc/free helpers for
> per-queue data-rate packet pacing. Each Tx queue can now hold
> its own PP (Packet Pacing) index allocated via mlx5dv_pp_alloc()
> with MLX5_DATA_RATE mode.
>=20
> mlx5_txq_alloc_pp_rate_limit() converts Mbps to kbps for the PRM
> rate_limit field and allocates a dedicated PP index from the HW
> rate table. mlx5_txq_free_pp_rate_limit() releases it.
>=20
> The existing Clock Queue path (sh->txpp.pp / sh->txpp.pp_id) is
> untouched =E2=80=94 it uses MLX5_WQE_RATE for per-packet scheduling,
> while per-queue rate limiting uses MLX5_DATA_RATE.
>=20
> PP index cleanup is added to mlx5_txq_release() to prevent leaks
> when queues are destroyed.
>=20
> Supported hardware:
> - ConnectX-6 Dx: per-SQ rate via packet_pacing_rate_limit_index
> - ConnectX-7/8: same mechanism, plus wait-on-time coexistence
> - BlueField-2/3: same PP allocation support
>=20
> Not supported:
> - ConnectX-5: packet_pacing exists but MLX5_DATA_RATE mode may
>   not be available on all firmware versions
> - ConnectX-4 Lx and earlier: no packet_pacing capability
>=20
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

For better type safety, void * pointers should be avoided.
In this patch, struct mlx5_txq_rate_limit stores the PP context as void *pp.
This opaque pointer hides the type and makes the code harder for static ana=
lysis.

Use the actual type (struct mlx5dv_pp *) behind the HAVE_MLX5DV_PP_ALLOC gu=
ard
so the cast at ((struct mlx5dv_pp *)(rl->pp))->index becomes a direct membe=
r access.

Minor nit:
The line break in the dv_alloc_pp call hurts readability =E2=80=94 the func=
tion call,=20
its arguments, and the NULL check would be clearer on fewer lines:

=EF=BF=BC
rl->pp =3D mlx5_glue->dv_alloc_pp(sh->cdev->ctx, sizeof(pp), &pp, 0);
if (rl->pp =3D=3D NULL) {
