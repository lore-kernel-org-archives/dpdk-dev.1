Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929E3E9129A
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 15:00:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D7DC410F1;
	Thu,  5 Feb 2026 16:00:08 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 537694111B
 for <dev@dpdk.org>; Thu,  5 Feb 2026 16:00:07 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6L436lbczHnGd0;
 Thu,  5 Feb 2026 23:00:03 +0800 (CST)
Received: from dubpeml100003.china.huawei.com (unknown [7.214.147.98])
 by mail.maildlp.com (Postfix) with ESMTPS id 907CA40539;
 Thu,  5 Feb 2026 23:00:06 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100003.china.huawei.com (7.214.147.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Feb 2026 15:00:06 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 5 Feb 2026 15:00:06 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [PATCH] maintainers: update for bpf
Thread-Topic: [PATCH] maintainers: update for bpf
Thread-Index: AQHclp48IQPnKBTqVEOVw6PnzQcIGbV0Ms1w
Date: Thu, 5 Feb 2026 15:00:05 +0000
Message-ID: <45487b5bee4a4fe49088041a2a612f17@huawei.com>
References: <20260205125133.4291-1-marat.khalili@huawei.com>
In-Reply-To: <20260205125133.4291-1-marat.khalili@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.206.100]
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


>=20
> Add myself as co-maintainer for BPF.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>=20
> Following the suggestion by Thomas Monjalon and short discussion on
> techboard meeting.
>=20
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5683b87e4a..28ed707ebe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1903,6 +1903,7 @@ F: doc/guides/howto/telemetry.rst
>=20
>  BPF
>  M: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
> +M: Marat Khalili <marat.khalili@huawei.com>
>  F: lib/bpf/
>  F: examples/bpf/
>  F: app/test/test_bpf.c
> --
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.43.0
>=20

