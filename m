Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC4ACD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 20:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2007740264;
	Fri, 29 May 2026 22:45:13 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 17B9240262
 for <dev@dpdk.org>; Fri, 29 May 2026 22:45:12 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F21912098F;
 Fri, 29 May 2026 22:45:10 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] app/test: use memcpy in ipsec test
Date: Fri, 29 May 2026 22:45:00 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658B7@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <cd2886ccd3134ab0a712e739bad4da5e@huawei.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] app/test: use memcpy in ipsec test
Thread-Index: AQHc74JlHZWIoo7LLEyDxwIDBiAuqrYlNPHwgABBIWA=
References: <20260529154651.128372-1-stephen@networkplumber.org>
 <cd2886ccd3134ab0a712e739bad4da5e@huawei.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>
Cc: "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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

> > This test has tables of data that get copied with rte_memcpy.
> > But when compiled without always inline the compiler gets confused
> > by the inlining of rte_memcpy and thinks that it is possible for AVX
> > code to reference past the input data.
> >
> > Workaround is to use memcpy() which is better for this test anyway
> > since regular memcpy has more static checking from compiler and
> > analyzers.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test/test_ipsec.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/app/test/test_ipsec.c b/app/test/test_ipsec.c
> > index 139c1e8dec..b5a430996d 100644
> > --- a/app/test/test_ipsec.c
> > +++ b/app/test/test_ipsec.c
> > @@ -10,7 +10,6 @@
> >  #include <rte_hexdump.h>
> >  #include <rte_mbuf.h>
> >  #include <rte_malloc.h>
> > -#include <rte_memcpy.h>
> >  #include <rte_cycles.h>
> >  #include <rte_bus_vdev.h>
> >  #include <rte_ip.h>
> > @@ -559,7 +558,7 @@ setup_test_string(struct rte_mempool *mpool,
> const
> > char *string,
> >  			return NULL;
> >  		}
> >  		if (string !=3D NULL)
> > -			rte_memcpy(dst, string, t_len);
> > +			memcpy(dst, string, t_len);
> >  		else
> >  			memset(dst, 0, t_len);
> >  	}
> > @@ -604,22 +603,22 @@ setup_test_string_tunneled(struct rte_mempool
> > *mpool, const char *string,
> >  	/* copy outer IP and ESP header */
> >  	ipv4_outer.total_length =3D rte_cpu_to_be_16(t_len);
> >  	ipv4_outer.packet_id =3D rte_cpu_to_be_16(seq);
> > -	rte_memcpy(dst, &ipv4_outer, sizeof(ipv4_outer));
> > +	memcpy(dst, &ipv4_outer, sizeof(ipv4_outer));

How about:
*dst =3D ipv4_outer;

Don't know if it applies here.

> >  	dst +=3D sizeof(ipv4_outer);
> >  	m->l3_len =3D sizeof(ipv4_outer);
> > -	rte_memcpy(dst, &esph, sizeof(esph));
> > +	memcpy(dst, &esph, sizeof(esph));
> >  	dst +=3D sizeof(esph);
> >
> >  	if (string !=3D NULL) {
> >  		/* copy payload */
> > -		rte_memcpy(dst, string, len);
> > +		memcpy(dst, string, len);
> >  		dst +=3D len;
> >  		/* copy pad bytes */
> > -		rte_memcpy(dst, esp_pad_bytes, RTE_MIN(padlen,
> > +		memcpy(dst, esp_pad_bytes, RTE_MIN(padlen,
> >  			sizeof(esp_pad_bytes)));
> >  		dst +=3D padlen;
> >  		/* copy ESP tail header */
> > -		rte_memcpy(dst, &espt, sizeof(espt));
> > +		memcpy(dst, &espt, sizeof(espt));

Also here:
*dst =3D espt;

Also don't know if it applies here.

> >  	} else
> >  		memset(dst, 0, t_len);
> >
> > --
>=20
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
>=20
> > 2.53.0

With or without suggested changes:
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

If you are curious too...
Does the compiler still get confused about AVX rte_memcpy (without this =
patch), if applying the rte_memcpy patch?
https://patchwork.dpdk.org/project/dpdk/patch/20260521185631.116046-1-mb@=
smartsharesystems.com/

