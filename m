Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B380FEA4FB0
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 11:21:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FAE94025E;
	Mon, 23 Feb 2026 12:21:33 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 0E69F400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 12:21:32 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKJMB5RrXzJ46cY;
 Mon, 23 Feb 2026 19:21:10 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 9B04340573;
 Mon, 23 Feb 2026 19:21:30 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 23 Feb 2026 12:21:30 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 23 Feb 2026 12:21:30 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH] app/test: simplify getting the current file prefix
Thread-Topic: [PATCH] app/test: simplify getting the current file prefix
Thread-Index: AQHcopFpmqIJVNYoq0yGx1UJjndK8LWQHPXQ
Date: Mon, 23 Feb 2026 11:21:30 +0000
Message-ID: <3ea36267a2594b27b017284d0eba2a30@huawei.com>
References: <20260220174952.2647744-1-bruce.richardson@intel.com>
In-Reply-To: <20260220174952.2647744-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.74]
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

> diff --git a/app/test/process.h b/app/test/process.h
> index 402dc4f96f..1ab5671943 100644
> --- a/app/test/process.h
> +++ b/app/test/process.h
> @@ -8,12 +8,11 @@
>  #include <errno.h>  /* errno */
>  #include <limits.h> /* PATH_MAX */
>  #ifndef RTE_EXEC_ENV_WINDOWS
> -#include <libgen.h> /* basename et al */
>  #include <sys/wait.h>
>  #endif
>  #include <stdlib.h> /* NULL */
>  #include <string.h> /* strerror */
> -#include <unistd.h> /* readlink */
> +#include <unistd.h>

Can we delete it entirely? Compiles for me at least.

>  #include <dirent.h>
>=20
>  #include <rte_string_fns.h> /* strlcpy */
> @@ -239,17 +238,7 @@ file_prefix_arg(void)
>  static inline char *
>  get_current_prefix(char *prefix, int size)
>  {
> -	char buf[PATH_MAX];
> -
> -	/* get file for config (fd is always 3) return NULL on error */
> -	if (readlink("/proc/self/fd/3", buf, sizeof(buf)) =3D=3D -1)
> -		return NULL;
> -
> -	/*
> -	 * path should be something like "/var/run/dpdk/config"
> -	 * which results in prefix of "dpdk"
> -	 */
> -	rte_basename(dirname(buf), prefix, size);
> +	rte_basename(rte_eal_get_runtime_dir(), prefix, size);
>  	return prefix;

Do we even need it as a separate function anymore?

>  }
>=20
> @@ -260,12 +249,8 @@ file_prefix_arg(void)
>  	static char prefix[NAME_MAX + sizeof("--file-prefix=3D")];
>  	char tmp[NAME_MAX];
>=20
> -	if (get_current_prefix(tmp, sizeof(tmp)) =3D=3D NULL) {
> -		fprintf(stderr, "Error - unable to get current prefix!\n");
> -		return NULL;
> -	}
> -
> -	snprintf(prefix, sizeof(prefix), "--file-prefix=3D%s", tmp);
> +	snprintf(prefix, sizeof(prefix), "--file-prefix=3D%s",
> +			get_current_prefix(tmp, sizeof(tmp)));
>  	return prefix;
>  #endif
>  }
> --
> 2.51.0

With or without comments above addressed,
Acked-by: Marat Khalili <marat.khalili@huawei.com>

Tested-by: Marat Khalili <marat.khalili@huawei.com>
