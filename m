Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B38CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:55:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5706402A0;
	Thu, 30 Apr 2026 13:55:05 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 84F734021F;
 Thu, 30 Apr 2026 13:55:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5szh6MnqzJ467G;
 Thu, 30 Apr 2026 19:54:56 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (unknown [7.214.147.241])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D5724057A;
 Thu, 30 Apr 2026 19:55:04 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml500001.china.huawei.com (7.214.147.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Apr 2026 12:55:03 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 30 Apr 2026 12:55:03 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Daniil Iskhakov <dish@amicon.ru>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "sdl.dpdk@linuxtesting.org"
 <sdl.dpdk@linuxtesting.org>, "rrv@amicon.ru" <rrv@amicon.ru>
Subject: RE: [PATCH v2] cmdline: prevent out-of-bounds read in completion
 buffer
Thread-Topic: [PATCH v2] cmdline: prevent out-of-bounds read in completion
 buffer
Thread-Index: AQHc177QTBQql4cnvEun4mhVJub7X7X3gA4Q
Date: Thu, 30 Apr 2026 11:55:03 +0000
Message-ID: <eb61a430bfe747299a4dd5478480d05d@huawei.com>
References: <20260427153430.1805689-1-dish@amicon.ru>
In-Reply-To: <20260427153430.1805689-1-dish@amicon.ru>
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



> tmp_buf is populated by the completion callback and is not guaranteed
> to be NUL-terminated.
>=20
> The code already accounts for this when computing tmp_size with
> strnlen(tmp_buf, sizeof(tmp_buf)). However, another loop in the same
> path still walks tmp_buf until a NUL byte is found, without checking
> the buffer limit.
>=20
> If the callback writes a full-sized non-NUL-terminated string, the loop
> may read past the end of tmp_buf.
>=20
> Fix this by bounding the iteration with sizeof(tmp_buf).
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Daniil Iskhakov <dish@amicon.ru>
> ---
> v2:
> - Resent to dev@dpdk.org because v1 was accidentally sent only to
> maintainers.
>=20
> Cc: sdl.dpdk@linuxtesting.org
> Cc: rrv@amicon.ru
> ---
>  lib/cmdline/cmdline_rdline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/cmdline/cmdline_rdline.c b/lib/cmdline/cmdline_rdline.c
> index ee070f0af3..bc91dc6002 100644
> --- a/lib/cmdline/cmdline_rdline.c
> +++ b/lib/cmdline/cmdline_rdline.c
> @@ -445,7 +445,7 @@ rdline_char_in(struct rdline *rdl, char c)
>  				rdline_puts(rdl, "\r\n");
>  				while (ret) {
>  					rdl->write_char(rdl, ' ');
> -					for (i=3D0 ; i < sizeof(tmp_buf) &&
> tmp_buf[i]; i++)
> +					for (i =3D 0 ; i < tmp_buf[i]; i++)

> Fix this by bounding the iteration with sizeof(tmp_buf).
The change doesn't much description, if fact it looks contrary.
Probably patch get screwed somehow?

>  						rdl->write_char(rdl, tmp_buf[i]);
>  					rdline_puts(rdl, "\r\n");
>  					ret =3D rdl->complete(rdl, rdl->left_buf,
> --
> 2.43.0

