Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE26EC79FA1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 11:38:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF6C340374;
	Tue,  8 Sep 2026 13:38:01 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 8673B402F0
 for <dev@dpdk.org>; Tue,  8 Sep 2026 13:37:59 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=4sXJ1ono5SznuQzKEaWrSA3Ku4SaLqBi21TPEzgWQoI=;
 b=OgrZY7DQxNGfsYfWQuTJ5rfN3wd+EF3EtvhUmc6iaAenFSiElXWYnzGy+mp8FJv9I4CCxL5rf
 gk4LihmWE9vN8t7QLtjvWEW4xuBK/GWapKUbVgYkaW4daimyzA30hY0K3ua1JJe65ylPRK1lC0m
 Iwjri98LegoBeOYGL3H/HSY=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hfMNn5yPkzJ46d7
 for <dev@dpdk.org>; Tue,  8 Sep 2026 19:37:13 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 0164740576
 for <dev@dpdk.org>; Tue,  8 Sep 2026 19:37:55 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 12:37:54 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.2562.046; 
 Tue, 8 Sep 2026 12:37:54 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] cmdline: add cmdline_ prefix to dprintf
Thread-Topic: [PATCH] cmdline: add cmdline_ prefix to dprintf
Thread-Index: AQHdP3sPV1pyq0udvEyskjau4NWIL7bEjebQ
Date: Tue, 8 Sep 2026 11:37:53 +0000
Message-ID: <e7faa5d769fe447aad8dccd2a54ad56e@huawei.com>
References: <20260908101534.71961-1-marat.khalili@huawei.com>
In-Reply-To: <20260908101534.71961-1-marat.khalili@huawei.com>
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



> -----Original Message-----
> From: Marat Khalili <marat.khalili@huawei.com>
> Sent: Tuesday, September 8, 2026 11:16 AM
> Cc: dev@dpdk.org
> Subject: [PATCH] cmdline: add cmdline_ prefix to dprintf
>=20
> Macro `dprintf` defined in `cmdline_cirbuf.h` may clash with eponymous
> glibc macro. Add `cmdline_` prefix to the one defined by DPDK.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  lib/cmdline/cmdline.c        |  2 +-
>  lib/cmdline/cmdline_cirbuf.c | 28 ++++++++++++++--------------
>  lib/cmdline/cmdline_cirbuf.h |  6 +++---
>  lib/cmdline/cmdline_socket.c |  2 +-
>  4 files changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/lib/cmdline/cmdline.c b/lib/cmdline/cmdline.c
> index 51fbc36cefe1..1b2df0dcc8f6 100644
> --- a/lib/cmdline/cmdline.c
> +++ b/lib/cmdline/cmdline.c
> @@ -113,7 +113,7 @@ RTE_EXPORT_SYMBOL(cmdline_free)
>  void
>  cmdline_free(struct cmdline *cl)
>  {
> -	dprintf("called\n");
> +	cmdline_dprintf("called\n");
>=20
>  	if (!cl)
>  		return;
> diff --git a/lib/cmdline/cmdline_cirbuf.c b/lib/cmdline/cmdline_cirbuf.c
> index 07d9fc6b904f..5cc09c887ca3 100644
> --- a/lib/cmdline/cmdline_cirbuf.c
> +++ b/lib/cmdline/cmdline_cirbuf.c
> @@ -41,13 +41,13 @@ cirbuf_add_buf_head(struct cirbuf *cbuf, const char *=
c,
> unsigned int n)
>  	e =3D CIRBUF_IS_EMPTY(cbuf) ? 1 : 0;
>=20
>  	if (n < cbuf->start + e) {
> -		dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->start - n + e, n);
> +		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->start - n + e,
> n);
>  		memcpy(cbuf->buf + cbuf->start - n + e, c, n);
>  	}
>  	else {
> -		dprintf("s[%d] -> d[%d] (%d)\n", + n - (cbuf->start + e), 0,
> +		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", + n - (cbuf->start + e),
> 0,
>  			cbuf->start + e);
> -		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->maxlen - n +
> +		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->maxlen - n +
>  			(cbuf->start + e), 0, n - (cbuf->start + e));
>  		memcpy(cbuf->buf, c  + n - (cbuf->start + e) , cbuf->start + e);
>  		memcpy(cbuf->buf + cbuf->maxlen - n + (cbuf->start + e), c,
> @@ -73,13 +73,13 @@ cirbuf_add_buf_tail(struct cirbuf *cbuf, const char *=
c,
> unsigned int n)
>  	e =3D CIRBUF_IS_EMPTY(cbuf) ? 1 : 0;
>=20
>  	if (n < cbuf->maxlen - cbuf->end - 1 + e) {
> -		dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->end + !e, n);
> +		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->end + !e, n);
>  		memcpy(cbuf->buf + cbuf->end + !e, c, n);
>  	}
>  	else {
> -		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->end + !e, 0,
> +		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->end + !e, 0,
>  			cbuf->maxlen - cbuf->end - 1 + e);
> -		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->maxlen - cbuf->end - 1 +
> +		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->maxlen - cbuf-
> >end - 1 +
>  			e, 0, n - cbuf->maxlen + cbuf->end + 1 - e);
>  		memcpy(cbuf->buf + cbuf->end + !e, c, cbuf->maxlen -
>  		       cbuf->end - 1 + e);
> @@ -352,19 +352,19 @@ cirbuf_get_buf_head(struct cirbuf *cbuf, char *c,
> unsigned int size)
>  		return 0;
>=20
>  	if (cbuf->start <=3D cbuf->end) {
> -		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->start, 0, n);
> +		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->start, 0, n);
>  		memcpy(c, cbuf->buf + cbuf->start , n);
>  	}
>  	else {
>  		/* check if we need to go from end to the beginning */
>  		if (n <=3D cbuf->maxlen - cbuf->start) {
> -			dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->start, n);
> +			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->start,
> n);
>  			memcpy(c, cbuf->buf + cbuf->start , n);
>  		}
>  		else {
> -			dprintf("s[%d] -> d[%d] (%d)\n", cbuf->start, 0,
> +			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->start, 0,
>  				cbuf->maxlen - cbuf->start);
> -			dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->maxlen - cbuf-
> >start,
> +			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf-
> >maxlen - cbuf->start,
>  				n - cbuf->maxlen + cbuf->start);
>  			memcpy(c, cbuf->buf + cbuf->start , cbuf->maxlen - cbuf-
> >start);
>  			memcpy(c + cbuf->maxlen - cbuf->start, cbuf->buf,
> @@ -391,19 +391,19 @@ cirbuf_get_buf_tail(struct cirbuf *cbuf, char *c,
> unsigned int size)
>  		return 0;
>=20
>  	if (cbuf->start <=3D cbuf->end) {
> -		dprintf("s[%d] -> d[%d] (%d)\n", cbuf->end - n + 1, 0, n);
> +		cmdline_dprintf("s[%d] -> d[%d] (%d)\n", cbuf->end - n + 1, 0, n);
>  		memcpy(c, cbuf->buf + cbuf->end - n + 1, n);
>  	}
>  	else {
>  		/* check if we need to go from end to the beginning */
>  		if (n <=3D cbuf->end + 1) {
> -			dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->end - n + 1, n);
> +			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0, cbuf->end - n
> + 1, n);
>  			memcpy(c, cbuf->buf + cbuf->end - n + 1, n);
>  		}
>  		else {
> -			dprintf("s[%d] -> d[%d] (%d)\n", 0,
> +			cmdline_dprintf("s[%d] -> d[%d] (%d)\n", 0,
>  				cbuf->maxlen - cbuf->start, cbuf->end + 1);
> -			dprintf("s[%d] -> d[%d] (%d)\n",
> +			cmdline_dprintf("s[%d] -> d[%d] (%d)\n",
>  				cbuf->maxlen - n + cbuf->end + 1, 0, n - cbuf->end
> - 1);
>  			memcpy(c + cbuf->maxlen - cbuf->start,
>  					       cbuf->buf, cbuf->end + 1);
> diff --git a/lib/cmdline/cmdline_cirbuf.h b/lib/cmdline/cmdline_cirbuf.h
> index 8e571462ca5c..acd95ebc82ba 100644
> --- a/lib/cmdline/cmdline_cirbuf.h
> +++ b/lib/cmdline/cmdline_cirbuf.h
> @@ -23,10 +23,10 @@ struct cirbuf {
>  };
>=20
>  #ifdef RTE_LIBRTE_CMDLINE_DEBUG
> -#define dprintf_(fmt, ...) printf("line %3.3d - " fmt "%.0s", __LINE__,
> __VA_ARGS__)
> -#define dprintf(...) dprintf_(__VA_ARGS__, "dummy")
> +#define cmdline_dprintf_(fmt, ...) printf("line %3.3d - " fmt "%.0s", __=
LINE__,
> __VA_ARGS__)
> +#define cmdline_dprintf(...) cmdline_dprintf_(__VA_ARGS__, "dummy")
>  #else
> -#define dprintf(...) (void)0
> +#define cmdline_dprintf(...) ((void)0)
>  #endif
>=20
>=20
> diff --git a/lib/cmdline/cmdline_socket.c b/lib/cmdline/cmdline_socket.c
> index f3d62acdae41..9af3789fbc91 100644
> --- a/lib/cmdline/cmdline_socket.c
> +++ b/lib/cmdline/cmdline_socket.c
> @@ -26,7 +26,7 @@ cmdline_file_new(cmdline_parse_ctx_t *ctx, const char
> *prompt, const char *path)
>=20
>  	fd =3D open(path, O_RDONLY, 0);
>  	if (fd < 0) {
> -		dprintf("open() failed\n");
> +		cmdline_dprintf("open() failed\n");
>  		return NULL;
>  	}
>  	return cmdline_new(ctx, prompt, fd, -1);
> --
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> 2.43.0

