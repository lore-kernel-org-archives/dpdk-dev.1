Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8DAC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:51:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 794C540696;
	Mon, 24 Aug 2026 17:51:18 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 74E7840270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 17:51:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=aWE9Lp5JuYC6Uek9PDaOJD/Pta/t+DyGI+JUQFMxKM4=;
 b=OeziOQ+mlFBglp6APbTPWUtVaNfr1vXOZFpWu3yr4rkojD7dfGYdqUh3L3xlHIJaPar9aYgYH
 PrPleyfZK1AgSZv1S5SESqgHrDCU/h3ymq7M+3QiMJDwY03x4lJZVY1AGAQb7Dm2FWYqTq8+PyN
 apYVSp747BR9v+B1NE49cJs=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hTFkW4mlszJ469g;
 Mon, 24 Aug 2026 23:50:59 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 11F0140584;
 Mon, 24 Aug 2026 23:51:16 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 17:51:15 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Mon, 24 Aug 2026 17:51:15 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Yang Xiaoliang <xiaoliangyang69@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>
Subject: RE: [PATCH] doc: fix typo in ipsec_secgw sample app guide
Thread-Topic: [PATCH] doc: fix typo in ipsec_secgw sample app guide
Thread-Index: AQHdJz0A50l/wMklkk2S32q3bTYlA7atciTg
Date: Mon, 24 Aug 2026 15:51:15 +0000
Message-ID: <4fdbb0dac20f4c4988d1de1266081859@huawei.com>
References: <20260808135031.18134-1-xiaoliangyang69@gmail.com>
In-Reply-To: <20260808135031.18134-1-xiaoliangyang69@gmail.com>
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
> From: Yang Xiaoliang <xiaoliangyang69@gmail.com>
> Sent: Saturday 8 August 2026 14:51
> To: dev@dpdk.org
> Cc: thomas@monjalon.net
> Subject: [PATCH] doc: fix typo in ipsec_secgw sample app guide
>=20
> Fix "depeneds" typo, should be "depends".
>=20
> Signed-off-by: Yang Xiaoliang <xiaoliangyang69@gmail.com>
> ---
>  doc/guides/sample_app_ug/ipsec_secgw.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample=
_app_ug/ipsec_secgw.rst
> index 7c31c96b7c..b40a15eb4f 100644
> --- a/doc/guides/sample_app_ug/ipsec_secgw.rst
> +++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
> @@ -260,7 +260,7 @@ Where:
>       via Rx queue setup.
>=20
>  *   ``--vector-pool-sz``: Number of buffers in vector pool.
> -    By default, vector pool size depeneds on packet pool size
> +    By default, vector pool size depends on packet pool size
>      and size of each vector.
>=20
>  *   ``--desc-nb NUMBER_OF_DESC``: Number of descriptors per queue pair.
> --
> 2.43.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
