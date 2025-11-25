Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59DCCFD315
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 08:36:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3C80402E8;
	Tue, 25 Nov 2025 09:36:27 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 0896A402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 09:36:25 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dFwxl6jXgzHnHBj;
 Tue, 25 Nov 2025 16:35:39 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 2FFEE1402F2;
 Tue, 25 Nov 2025 16:36:24 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 25 Nov 2025 08:36:23 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 25 Nov 2025 08:36:23 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Marat Khalili
 <marat.khalili@huawei.com>
Subject: RE: [PATCH] maintainers: update for BPF test coverage
Thread-Topic: [PATCH] maintainers: update for BPF test coverage
Thread-Index: AQHcXW3JLmq4MCuQZ0mL3Fti0dVkc7UDEWcg
Date: Tue, 25 Nov 2025 08:36:23 +0000
Message-ID: <2eba644eba404147a57bbaf333bbe6dc@huawei.com>
References: <20251124181123.3427921-1-thomas@monjalon.net>
In-Reply-To: <20251124181123.3427921-1-thomas@monjalon.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.220]
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



> When adding the directory app/test/bpf,
> the file MAINTAINERS was not updated.
>=20
> Fixes: cf1e03f881af ("test/bpf: add ELF loading")
> Fixes: 81038845c90b ("test/bpf: add Rx and Tx filtering")
>=20
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
>=20
> ---
>=20
> Kontantin, are you OK to be the maintainer of these new tests?

Yep.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27a4981b10..d7d8dbdb25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1907,6 +1907,7 @@ M: Konstantin Ananyev
> <konstantin.v.ananyev@yandex.ru>
>  F: lib/bpf/
>  F: examples/bpf/
>  F: app/test/test_bpf.c
> +F: app/test/bpf/
>  F: app/test-pmd/bpf_cmd.*
>  F: doc/guides/prog_guide/bpf_lib.rst
>=20
> --
> 2.51.0

