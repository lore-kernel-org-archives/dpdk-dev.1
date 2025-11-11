Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66586CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 00:40:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 425C94026D;
	Tue, 11 Nov 2025 01:40:34 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7C8CF4026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 01:40:32 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 32E4E206DC;
 Tue, 11 Nov 2025 01:40:32 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] lib/ring: do not allow zero size ring
Date: Tue, 11 Nov 2025 01:40:29 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65555@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251110231546.576516-1-iboukris@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] lib/ring: do not allow zero size ring
Thread-Index: AdxSmBoUSnIufZhHTGm5wWMK5PGGdQAClkXQ
References: <20251110222827.575488-1-iboukris@gmail.com>
 <20251110231546.576516-1-iboukris@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Isaac Boukris" <iboukris@gmail.com>,
 "Honnappa Nagarahalli" <honnappa.nagarahalli@arm.com>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>
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

> diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
> index edd63aa535..0a9fc31530 100644
> --- a/lib/ring/rte_ring.c
> +++ b/lib/ring/rte_ring.c
> @@ -47,7 +47,7 @@ EAL_REGISTER_TAILQ(rte_ring_tailq)
>  		     RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ)
>=20
>  /* true if x is a power of 2 */
> -#define POWEROF2(x) ((((x)-1) & (x)) =3D=3D 0)
> +#define POWEROF2(x) ((x !=3D 0) && (((x)-1) & (x)) =3D=3D 0)

Please remove this private macro and use the RTE_IS_POWER_OF_2() macro =
from rte_bitops.h instead.
With such modification,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

<feature creep>
app/pdump/main.c also defines a POWEROF2() macro, which could be =
replaced by RTE_IS_POWER_OF_2().
But changing that is unrelated to your improvement in this patch, and =
should be an independent patch.
Not your responsibility to fix that; just mentioning it for someone to =
pick it up.
</feature creep>

