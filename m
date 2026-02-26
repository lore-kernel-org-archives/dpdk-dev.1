Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814DCFD8FDA
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 17:05:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 184C4402EE;
	Thu, 26 Feb 2026 18:05:03 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 96CAB4028F;
 Thu, 26 Feb 2026 18:05:01 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMHqg4BxHzHnGdQ;
 Fri, 27 Feb 2026 01:04:15 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id D323A4056B;
 Fri, 27 Feb 2026 01:04:59 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Feb 2026 18:04:59 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 26 Feb 2026 18:04:59 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 1/2] app/test: fix ifdefs in header for managing
 subprocesses
Thread-Topic: [PATCH v2 1/2] app/test: fix ifdefs in header for managing
 subprocesses
Thread-Index: AQHcpnLNexBc85j+e0+xNonrXlpIRLWVNDYQ
Date: Thu, 26 Feb 2026 17:04:59 +0000
Message-ID: <000bae692fb04389bf642d5905185c2a@huawei.com>
References: <20260220174952.2647744-1-bruce.richardson@intel.com>
 <20260225162044.3670045-1-bruce.richardson@intel.com>
In-Reply-To: <20260225162044.3670045-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Wednesday 25 February 2026 16:21
> To: dev@dpdk.org
> Cc: Bruce Richardson <bruce.richardson@intel.com>; stable@dpdk.org
> Subject: [PATCH v2 1/2] app/test: fix ifdefs in header for managing subpr=
ocesses
>=20
> The #endif for the #ifdef Linux block to add the "get_current_prefix()"
> and the "file_prefix_arg()" functions to process.h was on the wrong
> line, leaving a stray "}" outside the block. Fix this and in the process
> (no pun intended) simplify the #ifdefs to just a non-Linux and a Linux
> block, removing one level of #ifdefs.
>=20
> Fixes: f17b6eacf00a ("test: avoid file prefix overflow")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/process.h | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/app/test/process.h b/app/test/process.h
> index 402dc4f96f..a21cdfd46d 100644
> --- a/app/test/process.h
> +++ b/app/test/process.h
> @@ -225,17 +225,14 @@ process_dup(const char *const argv[], int numargs, =
const char *env_value)
>  	return status;
>  }
>=20
> -/* FreeBSD doesn't support file prefixes, so no argument passed. */
> -#ifdef RTE_EXEC_ENV_FREEBSD
> +/* Only Linux supports file prefixes. */
> +#ifndef RTE_EXEC_ENV_LINUX
>  static inline const char *
>  file_prefix_arg(void)
>  {
> -	/* BSD target doesn't support prefixes at this point */
>  	return "";
>  }
> -#else
> -
> -#ifdef RTE_EXEC_ENV_LINUX
> +#else /* RTE_EXEC_ENV_LINUX */
>  static inline char *
>  get_current_prefix(char *prefix, int size)
>  {
> @@ -253,7 +250,7 @@ get_current_prefix(char *prefix, int size)
>  	return prefix;
>  }
>=20
> -/* Return a --file-prefix=3DXXXX argument or NULL */
> +/* Return a --file-prefix=3DXXXX argument */
>  static inline const char *
>  file_prefix_arg(void)
>  {
> @@ -267,8 +264,7 @@ file_prefix_arg(void)
>=20
>  	snprintf(prefix, sizeof(prefix), "--file-prefix=3D%s", tmp);
>  	return prefix;
> -#endif
>  }
> -#endif
> +#endif /* RTE_EXEC_ENV_LINUX */
>=20
>  #endif /* _PROCESS_H_ */
> --
> 2.51.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>

Tested on Linux.
