Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201B0C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:47:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0782140270;
	Mon, 24 Aug 2026 17:47:19 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1D90D400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 17:47:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=b8iu1Qwgmi+i3p+hftF2UFsg9wfdqzhC0mIAyICeLV4=;
 b=eh92AllpoVHFMb2ccY0l5W6RW43fVu2qNV43flw2G99R5dsh/t/oy3ULCGmhpPYTfel5T3sso
 J8ggnx7U7jikZ3SGLlRx+owHWyYdiSEjxLhKMw6juF1bhlepUMMujCYDgNq8QXBspJxk3XX9IV1
 pXUh4FIczFO7NNDM409IkL0=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hTFdt2gtWzJ46Yg;
 Mon, 24 Aug 2026 23:46:58 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id ED2044057A;
 Mon, 24 Aug 2026 23:47:14 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:47:14 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Mon, 24 Aug 2026 17:47:14 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Yang Xiaoliang <yang_xiaoliang1990@163.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>
Subject: RE: [PATCH] doc: fix typo in l3fwd sample app guide
Thread-Topic: [PATCH] doc: fix typo in l3fwd sample app guide
Thread-Index: AQHdJj1UguOpOuRUiEGogW5rqRHlU7atcfCw
Date: Mon, 24 Aug 2026 15:47:14 +0000
Message-ID: <597077b248584bab83f148098acb6cd5@huawei.com>
References: <20260807071546.13795-1-yang_xiaoliang1990@163.com>
In-Reply-To: <20260807071546.13795-1-yang_xiaoliang1990@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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

> -----Original Message-----
> From: Yang Xiaoliang <yang_xiaoliang1990@163.com>
> Sent: Friday 7 August 2026 08:16
> To: dev@dpdk.org
> Cc: thomas@monjalon.net; Yang Xiaoliang <yang_xiaoliang1990@163.com>
> Subject: [PATCH] doc: fix typo in l3fwd sample app guide
>=20
> Fix "menthod" typo, should be "method".
>=20
> Signed-off-by: Yang Xiaoliang <yang_xiaoliang1990@163.com>
> ---
>  doc/guides/sample_app_ug/l3_forward.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_=
app_ug/l3_forward.rst
> index 452bd8cc6c..0395474337 100644
> --- a/doc/guides/sample_app_ug/l3_forward.rst
> +++ b/doc/guides/sample_app_ug/l3_forward.rst
> @@ -210,7 +210,7 @@ In this command:
>=20
>  *   The --mode option defines PMD to be used for packet I/O.
>=20
> -*   The --eventq-sched option enables synchronization menthod of event q=
ueue so that packets will be
> scheduled accordingly.
> +*   The --eventq-sched option enables synchronization method of event qu=
eue so that packets will be
> scheduled accordingly.
>=20
>  If application uses S/W scheduler, it uses following DPDK services:
>=20
> --
> 2.43.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>

Consider also running this line through an LLM for better flow.
