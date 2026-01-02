Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFCFA374B
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Jan 2026 14:04:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72CEA40267;
	Fri,  2 Jan 2026 15:04:03 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id DEEF340262
 for <dev@dpdk.org>; Fri,  2 Jan 2026 15:04:01 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djQPz3ffmzJ46CH;
 Fri,  2 Jan 2026 22:03:03 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id 18C2A40539;
 Fri,  2 Jan 2026 22:03:59 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:03:58 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 2 Jan 2026 15:03:58 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v10 3/9] test: refactor file prefix arg handling
Thread-Topic: [PATCH v10 3/9] test: refactor file prefix arg handling
Thread-Index: AQHceQ6wUn1ktwVztESYbUXwKFX4VrU+7REw
Date: Fri, 2 Jan 2026 14:03:58 +0000
Message-ID: <bc69435eb2f142dd8ffcbbf09c0aa008@huawei.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251229220053.21981-1-stephen@networkplumber.org>
 <20251229220053.21981-4-stephen@networkplumber.org>
In-Reply-To: <20251229220053.21981-4-stephen@networkplumber.org>
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

Please see a couple of nits inline.

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday 29 December 2025 21:59
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Subject: [PATCH v10 3/9] test: refactor file prefix arg handling
>=20
> Make setting up --file-prefix arg logic into a function,
> and avoid impossible case of file prefix path causing overflow
> of string.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/process.h        |   8 +--
>  app/test/test_eal_flags.c | 132 ++++++++++----------------------------
>  2 files changed, 37 insertions(+), 103 deletions(-)
>=20

// snip

> diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
> index e32f83d3c8..12cf123e81 100644
> --- a/app/test/test_eal_flags.c
> +++ b/app/test/test_eal_flags.c
> @@ -121,6 +121,8 @@ test_misc_flags(void)
>  #define no_shconf "--no-shconf"
>  #define allow "--allow"
>  #define vdev "--vdev"
> +#define file_prefix "--file-prefix"
> +

Are we using it anywhere?

// snip

> @@ -853,6 +802,18 @@ test_no_huge_flag(void)
>  	const char *argv2[] =3D {prgname, prefix, no_huge,
>  			"-m", DEFAULT_MEM_SIZE};
>=20
> +	if (launch_proc(argv1) !=3D 0) {
> +		printf("Error - process did not run ok with --no-huge flag\n");
> +		return -1;
> +	}
> +	if (launch_proc(argv2) !=3D 0) {
> +		printf("Error - process did not run ok with --no-huge and -m flags\n")=
;
> +		return -1;
> +	}
> +#ifdef RTE_EXEC_ENV_FREEBSD
> +	/* no other tests are applicable to FreeBSD */
> +	return 0;
> +#else
>  	/* With --no-huge and --socket-mem */
>  	const char *argv3[] =3D {prgname, prefix, no_huge,
>  			"--socket-mem=3D" DEFAULT_MEM_SIZE};
> @@ -867,19 +828,6 @@ test_no_huge_flag(void)
>  	const char * const argv6[] =3D {prgname, prefix, no_huge,
>  			"--huge-worker-stack=3D512"};
>=20
> -	if (launch_proc(argv1) !=3D 0) {
> -		printf("Error - process did not run ok with --no-huge flag\n");
> -		return -1;
> -	}
> -	if (launch_proc(argv2) !=3D 0) {
> -		printf("Error - process did not run ok with --no-huge and -m flags\n")=
;
> -		return -1;
> -	}
> -#ifdef RTE_EXEC_ENV_FREEBSD
> -	/* no other tests are applicable to FreeBSD */
> -	return 0;
> -#endif
> -
>  	if (launch_proc(argv3) =3D=3D 0) {
>  		printf("Error - process run ok with --no-huge and --socket-mem "
>  				"flags\n");
> @@ -898,6 +846,7 @@ test_no_huge_flag(void)
>  		printf("Error - process run ok with --no-huge and --huge-worker-stack=
=3Dsize flags");
>  		return -1;
>  	}
> +#endif
>  	return 0;

Duplicate return in FreeBSD case?

>  }

// snip the rest
