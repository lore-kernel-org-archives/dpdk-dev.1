Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFF4C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 08:43:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E016C40608;
	Wed, 25 Jun 2025 10:43:43 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id AA35D402B1;
 Wed, 25 Jun 2025 10:43:41 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRwLl2w3Sz6GFWx;
 Wed, 25 Jun 2025 16:42:55 +0800 (CST)
Received: from frapeml500004.china.huawei.com (unknown [7.182.85.22])
 by mail.maildlp.com (Postfix) with ESMTPS id CDFE71402EF;
 Wed, 25 Jun 2025 16:43:40 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml500004.china.huawei.com (7.182.85.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Jun 2025 10:43:40 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Wed, 25 Jun 2025 10:43:40 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Timothy Redaelli <tredaelli@redhat.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>
Subject: RE: [PATCH v2 04/10] eal: fix plugin dir walk
Thread-Topic: [PATCH v2 04/10] eal: fix plugin dir walk
Thread-Index: AQHb5EZCWPj59agRZEiyDQRreHMndbQTjA/g
Date: Wed, 25 Jun 2025 08:43:40 +0000
Message-ID: <dc88c2152e8e4cfbb55c91d99655661d@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-5-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-5-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.64]
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

Thank you for doing this.

> +static bool
> +ends_with(const char *str, size_t str_len, const char *tail)

I too think we should have a general ends_with, I for one had to code one j=
ust this week. However, I do not think it should support non-null-terminate=
d strings.

> +{
> +	size_t tail_len =3D strlen(tail);
> +
> +	return str_len >=3D tail_len && strncmp(&str[str_len - tail_len], tail,
> tail_len) =3D=3D 0;
> +}

Note that when str is not null-terminated and both str_len and tail_len are=
 zeroes &str[str_len - tail_len] will dereference one character after the e=
nd before taking a reference to it again, which would be a UB. (Won't happe=
n in your case of course since your tail is always non-empty, but may happe=
n if this function is moved into a general-use library.)

> @@ -417,13 +425,12 @@ eal_plugindir_init(const char *path)
>  	}
>=20
>  	while ((dent =3D readdir(d)) !=3D NULL) {
> +		size_t nlen =3D strnlen(dent->d_name, sizeof(dent->d_name));
>  		struct stat sb;
> -		int nlen =3D strnlen(dent->d_name, sizeof(dent->d_name));
>=20
>  		/* check if name ends in .so or .so.ABI_VERSION */
> -		if (strcmp(&dent->d_name[nlen - 3], ".so") !=3D 0 &&
> -		    strcmp(&dent->d_name[nlen - 4 - strlen(ABI_VERSION)],
> -			   ".so."ABI_VERSION) !=3D 0)
> +		if (!ends_with(dent->d_name, nlen, ".so") &&
> +				!ends_with(dent->d_name, nlen, ".so."ABI_VERSION))
>  			continue;

I do not think we should try to handle the non-null-terminated dent->d_name=
 case here, I'd just delete nlen and everything related to it. To be super-=
defensive we could add a check that `memchr(dent->d_name, 0, sizeof(dent->d=
_name)) !=3D NULL`, but I don't think it's needed.
