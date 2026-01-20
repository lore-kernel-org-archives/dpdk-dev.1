Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB79C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 08:31:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD9B14279A;
	Wed, 21 Jan 2026 09:31:50 +0100 (CET)
Received: from mx1.wirefilter.com (mx1.wirefilter.com [82.147.223.86])
 by mails.dpdk.org (Postfix) with ESMTP id A08784013F
 for <dev@dpdk.org>; Tue, 20 Jan 2026 15:04:43 +0100 (CET)
Received: from egw.wirefilter.com (localhost.localdomain [127.0.0.1])
 by mx1.wirefilter.com (Proxmox) with ESMTP id B7E02C168A;
 Tue, 20 Jan 2026 15:08:22 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wirefilter.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=default; bh=ToxJuJFyyw/EqS4Ci
 eikNHj3qJW2S6aFviNWLJhhT1c=; b=TvU9/QE7d/khpdjOjrxICLtmziKLD6YSi
 iBmWNgl8aQQDyozW5CTAUW5VTHRqZoWpKJ5VXs41vgDYrsv3vT7R7eY13hthI5mu
 6a8mJr1u57gGB9dY3NpnKKS/8HMa7Lr6UM5FG+GjBU1YsfnzZWzeSioVGMldoXVv
 328ot4q1vALCGAyfTLEGKUjSgaEkmCCf+5S1pEiwf5G949YB1Oz+zAOEK/Xt/h43
 Kwj0PQpkzyiuveIr7RlgZ0Q2UogMNdxzpZghwPGGY77jzaoZGSsVWELRpTkASHoQ
 RYpPRd8xdgDk5ZKwIg11k8s23FFMaV7wa1o4LDy1T586T4sbjExRw==
Date: Tue, 20 Jan 2026 15:08:22 +0300 (AST)
From: Mohand Alrasheed <mrasheed@wirefilter.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: dev <dev@dpdk.org>, viacheslavo <viacheslavo@nvidia.com>, 
 bingz <bingz@nvidia.com>, orika <orika@nvidia.com>, 
 suanmingm <suanmingm@nvidia.com>, matan <matan@nvidia.com>, 
 jackmin <jackmin@nvidia.com>
Message-ID: <116677671.20111072.1768910902535.JavaMail.zimbra@wirefilter.com>
In-Reply-To: <wzzxujbhbn5dges7ukhceeiihnl6j5ztroncfdikj74v6lmxoc@hjvhdu6mak2h>
References: <205110942.16694617.1767623073046.JavaMail.zimbra@wirefilter.com>
 <wzzxujbhbn5dges7ukhceeiihnl6j5ztroncfdikj74v6lmxoc@hjvhdu6mak2h>
Subject: Re: [PATCH] net/mlx5: fix offset handling in
 mlx5_aso_cnt_sq_enqueue_burst
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.1.1.3]
X-Mailer: Zimbra 10.1.13_GA_4837 (ZimbraModernWebClient - SAF26
 (Mac)/10.1.13_GA_4837)
Thread-Topic: net/mlx5: fix offset handling in mlx5_aso_cnt_sq_enqueue_burst
Thread-Index: Wy6nXAsNPCGXTSK/QUoTQTBTwcyt+w==
X-Mailman-Approved-At: Wed, 21 Jan 2026 09:31:48 +0100
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

Hi Dariusz,

Thanks for the update. I=E2=80=99ve responded with my feedback in the linke=
d patch.

Best regards,
Mohand


-----Original Message-----
From: Dariusz <dsosnowski@nvidia.com>
To: Mohand <mrasheed@wirefilter.com>
Cc: dev <dev@dpdk.org>; viacheslavo <viacheslavo@nvidia.com>; bingz <bingz@=
nvidia.com>; orika <orika@nvidia.com>; suanmingm <suanmingm@nvidia.com>; ma=
tan <matan@nvidia.com>; jackmin <jackmin@nvidia.com>
Date: Monday, 12 January 2026 11:02 PM +03
Subject: Re: [PATCH] net/mlx5: fix offset handling in mlx5_aso_cnt_sq_enque=
ue_burst


Hi,

On Mon, Jan 05, 2026 at 05:24:33PM +0300, Mohand Alrasheed wrote:
>=20
> From 9ca4302dd93461a7b01ad05af82ee2bcadf47675 Mon Sep 17 00:00:00 2001
> From: Mohand Alrasheed <mrasheed@wirefilter.com>
> Date: Mon, 5 Jan 2026 15:44:25 +0300
> Subject: [PATCH] net/mlx5: fix offset handling in
>  mlx5_aso_cnt_sq_enqueue_burst
>=20
> mlx5_aso_cnt_sq_enqueue_burst() selects the ASO counter block using
> dcs_id_base/4 and ignores the batch offset. This causes every batch to
> target the first counter block, leading to counter aliasing (e.g. 2^16
> matches 0).
>=20
> This patch selects the counter block using the offset-adjusted index.
>=20
> Reproducible example: https://github.com/Hawzen/rte-flow-async-profiling/=
blob/5e654e3a8a0414a5fa8ed43274195f180760f0b5/examples/flow_filtering/repro=
duce.md

Thank you very much for your contribution and reporting this issue.

There is in fact another issue with flow counter query logic
in mlx5_aso_cnt_query_one_dcs() function.
This function did not take into account a case when
mlx5_aso_cnt_sq_enqueue_burst() would query fewer counters than requested,
which could happen when available space in the queue is smaller lower than =
"n".

We have upstreamed a patch which addresses both of these issues: https://pa=
tches.dpdk.org/project/dpdk/patch/20260112172324.1523241-1-dsosnowski@nvidi=
a.com/

Would you be able to test this patch locally on your side?

>=20
> Fixes: 4d368e1da3a453cbcac620e8844c0300b2f45cfa
> Cc: jackmin@nvidia.com
> Cc: stable@dpdk.org
> ---
>  drivers/net/mlx5/mlx5_flow_aso.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flo=
w_aso.c
> index feca8c3e89..a232289024 100644
> --- a/drivers/net/mlx5/mlx5_flow_aso.c
> +++ b/drivers/net/mlx5/mlx5_flow_aso.c
> @@ -1877,6 +1877,7 @@ mlx5_aso_cnt_sq_enqueue_burst(struct mlx5_hws_cnt_p=
ool *cpool,
>  =09sq->elts[0].burst_size =3D max;
>  =09ctrl_gen_id =3D dcs_id_base;
>  =09ctrl_gen_id /=3D 4;
> +=09ctrl_gen_id +=3D offset / 4;
>  =09do {
>  =09=09ccntid =3D upper_offset - max * 4;
>  =09=09wqe =3D &sq->sq_obj.aso_wqes[sq->head & mask];
> --
> 2.39.5
>=20
>=20

Best regards,
Dariusz Sosnowski


