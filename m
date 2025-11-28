Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE3ACFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:37:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 657264013F;
	Fri, 28 Nov 2025 14:37:16 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id AB27F400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:37:14 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dHvTB6FYzzJ46DX;
 Fri, 28 Nov 2025 21:36:14 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 7155A1402FE;
 Fri, 28 Nov 2025 21:37:13 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 28 Nov 2025 13:37:13 +0000
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Fri, 28 Nov 2025 13:37:13 +0000
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [RFC v2] eal: use C library to parse filesystem table
Thread-Topic: [RFC v2] eal: use C library to parse filesystem table
Thread-Index: AQHcXmA65dHvrtx60EicIvbH4rhz67UIGyyg
Date: Fri, 28 Nov 2025 13:37:12 +0000
Message-ID: <5f929607b83342c7b78d82b037a3e7cd@huawei.com>
References: <20251122194921.158921-1-stephen@networkplumber.org>
 <20251125230636.157621-1-stephen@networkplumber.org>
In-Reply-To: <20251125230636.157621-1-stephen@networkplumber.org>
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


> Rather than doing parsing of /proc/mounts with open coded string
> handling, use the standard C library routines.
> These exist in BSD and Linux.
>=20
> It also avoids any possible issues with escaped strings etc
> which the library handles. See getmntent(3) man page.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> v2 - implement suggestion to simplify conditionals
>=20
>  lib/eal/linux/eal_hugepage_info.c | 58 ++++++++++---------------------
>  1 file changed, 18 insertions(+), 40 deletions(-)
>=20
> diff --git a/lib/eal/linux/eal_hugepage_info.c
> b/lib/eal/linux/eal_hugepage_info.c
> index d47a19c56a..7161b1a2fb 100644
> --- a/lib/eal/linux/eal_hugepage_info.c
> +++ b/lib/eal/linux/eal_hugepage_info.c
> @@ -13,6 +13,7 @@
>  #include <inttypes.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <mntent.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
>=20
> @@ -195,23 +196,13 @@ get_default_hp_size(void)
>  static int
>  get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, int len)
>  {
> -	enum proc_mount_fieldnames {
> -		DEVICE =3D 0,
> -		MOUNTPT,
> -		FSTYPE,
> -		OPTIONS,
> -		_FIELDNAME_MAX
> -	};
>  	static uint64_t default_size =3D 0;
>  	const char proc_mounts[] =3D "/proc/mounts";
> -	const char hugetlbfs_str[] =3D "hugetlbfs";
> -	const size_t htlbfs_str_len =3D sizeof(hugetlbfs_str) - 1;
>  	const char pagesize_opt[] =3D "pagesize=3D";
>  	const size_t pagesize_opt_len =3D sizeof(pagesize_opt) - 1;
> -	const char split_tok =3D ' ';
> -	char *splitstr[_FIELDNAME_MAX];
>  	char found[PATH_MAX] =3D "";
>  	char buf[BUFSIZ];
> +	struct mntent entry;
>  	const struct internal_config *internal_conf =3D
>  		eal_get_internal_configuration();
>  	const size_t hugepage_dir_len =3D (internal_conf->hugepage_dir !=3D NUL=
L)
> ?
> @@ -226,56 +217,43 @@ get_hugepage_dir(uint64_t hugepage_sz, char
> *hugedir, int len)
>  		return -1;
>  	}
>=20
> -	FILE *fd =3D fopen(proc_mounts, "r");
> -	if (fd =3D=3D NULL)
> +	FILE *mounts =3D setmntent(proc_mounts, "r");
> +	if (mounts =3D=3D NULL)
>  		rte_panic("Cannot open %s\n", proc_mounts);
>=20
>  	if (default_size =3D=3D 0)
>  		default_size =3D get_default_hp_size();
>=20
> -	while (fgets(buf, sizeof(buf), fd)){
> +	while (getmntent_r(mounts, &entry, buf, sizeof(buf))) {
>  		const char *pagesz_str;
> -		size_t mountpt_len =3D 0;
> -
> -		if (rte_strsplit(buf, sizeof(buf), splitstr, _FIELDNAME_MAX,
> -				split_tok) !=3D _FIELDNAME_MAX) {
> -			EAL_LOG(ERR, "Error parsing %s", proc_mounts);
> -			break; /* return NULL */
> -		}
> +		uint64_t pagesz =3D default_size;
> +		size_t mountpt_len;
>=20
> -		if (strncmp(splitstr[FSTYPE], hugetlbfs_str, htlbfs_str_len) !=3D 0)
> +		if (strcmp(entry.mnt_type, "hugetlbfs") !=3D 0)
>  			continue;
>=20
> -		pagesz_str =3D strstr(splitstr[OPTIONS], pagesize_opt);
> +		pagesz_str =3D strstr(entry.mnt_opts, pagesize_opt);
> +		if (pagesz_str)
> +			pagesz =3D
> rte_str_to_size(&pagesz_str[pagesize_opt_len]);
>=20
> -		/* if no explicit page size, the default page size is compared */
> -		if (pagesz_str =3D=3D NULL) {
> -			if (hugepage_sz !=3D default_size)
> -				continue;
> -		}
> -		/* there is an explicit page size, so check it */
> -		else {
> -			uint64_t pagesz =3D
> rte_str_to_size(&pagesz_str[pagesize_opt_len]);
> -			if (pagesz !=3D hugepage_sz)
> -				continue;
> -		}
> +		if (pagesz !=3D hugepage_sz)
> +			continue;
>=20
>  		/*
>  		 * If no --huge-dir option has been given, we're done.
>  		 */
>  		if (internal_conf->hugepage_dir =3D=3D NULL) {
> -			strlcpy(found, splitstr[MOUNTPT], len);
> +			strlcpy(found, entry.mnt_dir, len);
>  			break;
>  		}
>=20
> -		mountpt_len =3D strlen(splitstr[MOUNTPT]);
> +		mountpt_len =3D strlen(entry.mnt_dir);
>=20
>  		/*
>  		 * Ignore any mount that doesn't contain the --huge-dir directory
>  		 * or where mount point is not a parent path of --huge-dir
>  		 */
> -		if (strncmp(internal_conf->hugepage_dir, splitstr[MOUNTPT],
> -				mountpt_len) !=3D 0 ||
> +		if (strncmp(internal_conf->hugepage_dir, entry.mnt_dir,
> mountpt_len) !=3D 0 ||
>  			(hugepage_dir_len > mountpt_len &&
>  				internal_conf->hugepage_dir[mountpt_len] !=3D
> '/')) {
>  			continue;
> @@ -286,10 +264,10 @@ get_hugepage_dir(uint64_t hugepage_sz, char
> *hugedir, int len)
>  		 * (so /mnt/1 is preferred over /mnt for matching /mnt/1/2)).
>  		 */
>  		if (mountpt_len > strlen(found))
> -			strlcpy(found, splitstr[MOUNTPT], len);
> +			strlcpy(found, entry.mnt_dir, len);
>  	} /* end while fgets */
>=20
> -	fclose(fd);
> +	endmntent(mounts);
>=20
>  	if (found[0] !=3D '\0') {
>  		/* If needed, return the requested dir, not the mount point. */
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.51.0

