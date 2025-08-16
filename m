Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAEBCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 Aug 2025 07:37:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1AA0400EF;
	Sat, 16 Aug 2025 09:37:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3FCB34003C
 for <dev@dpdk.org>; Sat, 16 Aug 2025 09:37:26 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BD1E02051E;
 Sat, 16 Aug 2025 09:37:25 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 4/7] test: replace unnecessary comma operators
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sat, 16 Aug 2025 09:37:23 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE3A@smartserver.smartshare.dk>
In-Reply-To: <20250815162629.161782-5-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 4/7] test: replace unnecessary comma operators
Thread-Index: AdwOAXE15QZqIDotRQOKVYSWgUNpvAAfwAmg
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
 <20250815162629.161782-5-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Chengwen Feng" <fengchengwen@huawei.com>,
 "Fan Zhang" <fanzhang.oss@gmail.com>, "Ashish Gupta" <ashishg@marvell.com>,
 "Chas Williams" <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 "Yipeng Wang" <yipeng1.wang@intel.com>,
 "Sameh Gobriel" <sameh.gobriel@intel.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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

> diff --git a/app/test/test_thash.c b/app/test/test_thash.c
> index 33b0c6adac..398db71839 100644
> --- a/app/test/test_thash.c
> +++ b/app/test/test_thash.c
> @@ -910,7 +910,7 @@ test_adjust_tuple_mult_reta(void)
>  {
>  	uint32_t i, j, np, nt;
>=20
> -	nt =3D 0, np =3D 0;
> +	nt =3D 0; np =3D 0;

Consider putting these assignments on separate lines.

>  	for (i =3D 0; i < CHAR_BIT; i++) {
>  		for (j =3D 6; j <=3D RTE_THASH_RETA_SZ_MAX - i; j++) {
>  			np +=3D (test_adjust_tuple_mb(j, i) =3D=3D 0);
> --
> 2.47.2

