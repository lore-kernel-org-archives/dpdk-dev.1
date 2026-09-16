Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49A6C982C3
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:48:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EB2D427D0;
	Wed, 16 Sep 2026 14:48:51 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DF9A8427C2
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:48:49 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=dr6TOlhngCb7P3scxFQTwJe7mQSDGJfElmi4KgQ3XX8=;
 b=lcEI6PwP/rIWfSxH3WdfGWM/+qxYkCk7KRLCpKN0WSs9SQArL0MIzEFPUW6vmbSRzrD4m0Tba
 4XKFZTfiyxcdImmKv+zvNEIFqEMaDdS0SVUEwEfq0rZUpA5cGmxsuGwFth7fyuyz2h+lmRgwDW6
 JxPYZG/TQ8kNjl7z9gkJWuI=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hlJbK2bhvzHnGdS;
 Wed, 16 Sep 2026 20:48:29 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id D9BD240570;
 Wed, 16 Sep 2026 20:48:43 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 13:48:43 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Wed, 16 Sep 2026 13:48:43 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [PATCH] maintainers: update for BPF library
Thread-Topic: [PATCH] maintainers: update for BPF library
Thread-Index: AQHdRcM8jpRT01bKIU2VmnWj2KgbM7bRJ7Ew
Date: Wed, 16 Sep 2026 12:48:43 +0000
Message-ID: <0b03434848f148c4ab471a57acf75bc5@huawei.com>
References: <20260916100203.65373-1-marat.khalili@huawei.com>
In-Reply-To: <20260916100203.65373-1-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.247.58]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> Marat Khalili will now make contributions to the BPF library
> as an individual in his personal capacity.
> So, updating his email in the MAINTAINERS file
> to be his personal email.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  .mailmap    | 2 +-
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 52d19bde6bf4..9f9692f9c538 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1007,7 +1007,7 @@ Manish Chopra <manishc@marvell.com>
>  Manish Kurup <manish.kurup@broadcom.com>
>  Manish Tomar <manish.tomar@nxp.com>
>  Mao Jiang <maox.jiang@intel.com>
> -Marat Khalili <marat.khalili@huawei.com>
> +Marat Khalili <qm2k21@gmail.com> <marat.khalili@huawei.com>
>  Marc Sune <marcdevel@gmail.com> <marc.sune@bisdn.de>
>  Marcel Apfelbaum <marcel@redhat.com>
>  Marcel Cornu <marcel.d.cornu@intel.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e99a65d1974d..adab8663c248 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1918,7 +1918,7 @@ F: doc/guides/howto/telemetry.rst
>=20
>  BPF
>  M: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
> -M: Marat Khalili <marat.khalili@huawei.com>
> +M: Marat Khalili <qm2k21@gmail.com>
>  F: lib/bpf/
>  F: examples/bpf/
>  F: app/test/test_bpf*
> --
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> 2.43.0

