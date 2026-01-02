Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC3DFA3741
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Jan 2026 12:50:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 016D440267;
	Fri,  2 Jan 2026 13:50:19 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 53E3040262
 for <dev@dpdk.org>; Fri,  2 Jan 2026 13:50:17 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djNmt3ttQzHnGd4;
 Fri,  2 Jan 2026 20:49:18 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 3E04C4057E;
 Fri,  2 Jan 2026 20:50:15 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 13:50:15 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 2 Jan 2026 13:50:15 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v10 2/9] test: add new function to get current file-prefix
 arg
Thread-Topic: [PATCH v10 2/9] test: add new function to get current
 file-prefix arg
Thread-Index: AQHceQ6tOsLxDPRKcE2taEsSH6QRebU+0Ewg
Date: Fri, 2 Jan 2026 12:50:14 +0000
Message-ID: <c49bc9ab7aea4f7b871a77d1ef79ddea@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
 <20251229220053.21981-3-stephen@networkplumber.org>
In-Reply-To: <20251229220053.21981-3-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday 29 December 2025 21:59
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH v10 2/9] test: add new function to get current file-prefi=
x arg
>=20
> Refactor so that there is one function to get current argument
> for "--file-prefix=3DXXX".
>=20
> The code does not need to initialize all these 4K buffers since
> they are directly used by functions that set them.
> The maximum sizeof of the current DPDK prefix is NAME_MAX (128)
> not PATH_MAX(4096) so save a significant amount of space.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/process.h | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/app/test/process.h b/app/test/process.h
> index f948a89786..251262d948 100644
> --- a/app/test/process.h
> +++ b/app/test/process.h
> @@ -199,15 +199,22 @@ process_dup(const char *const argv[], int numargs, =
const char *env_value)
>  	return status;
>  }
>=20
> -/* FreeBSD doesn't support file prefixes, so force compile failures for =
any
> - * tests attempting to use this function on FreeBSD.
> - */
> +/* FreeBSD doesn't support file prefixes, so no argument passed. */
> +#ifdef RTE_EXEC_ENV_FREEBSD
> +static inline const char *
> +file_prefix_arg(void)
> +{
> +	/* BSD target doesn't support prefixes at this point */
> +	return "";
> +}
> +#else
> +
>  #ifdef RTE_EXEC_ENV_LINUX
>  static inline char *
>  get_current_prefix(char *prefix, int size)
>  {
> -	char path[PATH_MAX] =3D {0};
> -	char buf[PATH_MAX] =3D {0};
> +	char path[64];
> +	char buf[PATH_MAX];
>=20
>  	/* get file for config (fd is always 3) */
>  	snprintf(path, sizeof(path), "/proc/self/fd/%d", 3);

I wonder if we ever learn what stood behind this.

> @@ -216,10 +223,29 @@ get_current_prefix(char *prefix, int size)
>  	if (readlink(path, buf, sizeof(buf)) =3D=3D -1)
>  		return NULL;
>=20
> -	/* get the prefix */
> +	/*
> +	 * path should be something like "/var/run/dpdk/config"

JFYI it's /run/dpdk/my-prefix/config on my system, although example correct=
ly demonstrates the algorithm.

> +	 * which results in prefix of "dpdk"
> +	 */
>  	rte_basename(dirname(buf), prefix, size);
> +	return prefix;
> +}
> +
> +/* Return a --file-prefix=3DXXXX argument or NULL */
> +static inline const char *
> +file_prefix_arg(void)
> +{
> +	static char prefix[NAME_MAX + sizeof("--file-prefix=3D")];
> +	char tmp[NAME_MAX];

Can current prefix change? Can we verify that it is filled already and retu=
rn immediately?

>=20
> +	if (get_current_prefix(tmp, sizeof(tmp)) =3D=3D NULL) {
> +		fprintf(stderr, "Error - unable to get current prefix!\n");
> +		return NULL;
> +	}
> +
> +	snprintf(prefix, sizeof(prefix), "--file-prefix=3D%s", tmp);
>  	return prefix;
> +#endif
>  }
>  #endif
>=20
> --
> 2.51.0

Considering the refactor in the next commit, with or without suggested opti=
mization,

Acked-by: Marat Khalili <marat.khalili@huawei.com>
