Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D964CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 17:12:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DE31402A0;
	Thu,  9 Oct 2025 19:12:14 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2C26D40267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 19:12:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B33F0202CC;
 Thu,  9 Oct 2025 19:12:12 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v8 1/3] mbuf: de-inline sanity checking a reinitialized
 mbuf
Date: Thu, 9 Oct 2025 19:12:10 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654B6@smartserver.smartshare.dk>
In-Reply-To: <aOfnq0bx0py_XTQz@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v8 1/3] mbuf: de-inline sanity checking a reinitialized
 mbuf
Thread-Index: Adw5PMQahNvfulSnShSw3MmEk1TAuwAAQnKA
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-2-mb@smartsharesystems.com>
 <aOfnq0bx0py_XTQz@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>,
 "Stephen Hemminger" <stephen@networkplumber.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 "Ivan Malov" <ivan.malov@arknetworks.am>,
 "Chengwen Feng" <fengchengwen@huawei.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Thursday, 9 October 2025 18.50
>=20
> On Sat, Aug 23, 2025 at 06:30:00AM +0000, Morten Br=F8rup wrote:
> > Sanity checking a reinitialized mbuf (a.k.a. raw mbuf) has been
> refactored
> > to follow the same design pattern as sanity checking a normal mbuf,
> and
> > now depends on RTE_LIBRTE_MBUF_DEBUG instead of RTE_ENABLE_ASSERT.
> >
> > The details of the changes are as follows:
> >
> > Non-inlined functions rte_mbuf_raw_sanity_check() and
> rte_mbuf_raw_check()
> > have been added.
> > They do for a reinitialized mbuf what rte_mbuf_sanity_check() and
> > rte_mbuf_check() do for a normal mbuf.
> > They basically check the same conditions as
> __rte_mbuf_raw_sanity_check()
> > previously did, but use "if (!condition) rte_panic(message)" instead
> of
> > RTE_ASSERT(), so they don't depend on RTE_ENABLE_ASSERT.
> >
> > The inline function __rte_mbuf_raw_sanity_check() has been replaced
> > by the new macro __rte_mbuf_raw_sanity_check_mp(), which either =
calls
> > rte_mbuf_raw_sanity_check() or does nothing, depending on
> > RTE_LIBRTE_MBUF_DEBUG, just like the __rte_mbuf_sanity_check() macro
> does
> > for a normal mbuf.
> >
> > Note that the new macro __rte_mbuf_raw_sanity_check_mp() takes an
> optional
> > mempool parameter to verify that the mbuf belongs to the expected
> mbuf
> > pool.
> > This addition is mainly relevant for sanity checking reinitialized
> mbufs
> > freed directly into a given mempool by a PMD when using
> > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE.
> >
> > The macro __rte_mbuf_raw_sanity_check() has been kept for backwards
> API
> > compatibility.
> > It simply calls __rte_mbuf_raw_sanity_check_mp() without specifying =
a
> > mempool.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> > Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> > ---
>=20
> Looks ok to me, one comment inline below.

Thank you for reviewing, Bruce.
Comment replied to inline below. :-)

>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> > v3:
> > * Removed experimental status for the new functions.
> >   Experimental is optional for new symbols, to allow for future API
> >   changes. But this has been around for a long time. (Stephen
> Hemminger)
> > * Consequentially, the added build check for ALLOW_EXPERIMENTAL_API
> with
> >   RTE_LIBRTE_MBUF_DEBUG is no longer needed, and was removed.
> > v2:
> > * Added explicit build check for ALLOW_EXPERIMENTAL_API being =
enabled
> when
> >   RTE_LIBRTE_MBUF_DEBUG is enabled, with descriptive error message =
if
> not
> >   so. (Ivan Malov)
> > * Fixed typo in patch description.
> > ---
> >  lib/mbuf/rte_mbuf.c | 61 ++++++++++++++++++++++++++++
> >  lib/mbuf/rte_mbuf.h | 96 =
+++++++++++++++++++++++++++----------------
> --
> >  2 files changed, 119 insertions(+), 38 deletions(-)
> >
> > diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
> > index 9e7731a8a2..af39c13cf7 100644
> > --- a/lib/mbuf/rte_mbuf.c
> > +++ b/lib/mbuf/rte_mbuf.c
> > @@ -373,6 +373,67 @@ rte_pktmbuf_pool_create_extbuf(const char =
*name,
> unsigned int n,
> >  	return mp;
> >  }
> >
> > +/* do some sanity checks on a reinitialized mbuf: panic if it fails
> */
> > +RTE_EXPORT_SYMBOL(rte_mbuf_raw_sanity_check)
> > +void
> > +rte_mbuf_raw_sanity_check(const struct rte_mbuf *m, const struct
> rte_mempool *mp)
> > +{
> > +	const char *reason;
> > +
> > +	if (rte_mbuf_raw_check(m, mp, &reason))
> > +		rte_panic("%s\n", reason);
> > +}
> > +
> > +RTE_EXPORT_SYMBOL(rte_mbuf_raw_check)
> > +int rte_mbuf_raw_check(const struct rte_mbuf *m, const struct
> rte_mempool *mp,
> > +		   const char **reason)
> > +{
> > +	/* check sanity */
> > +	if (rte_mbuf_check(m, 0, reason) =3D=3D -1)
> > +		return -1;
> > +
> > +	/* check initialized */
> > +	if (rte_mbuf_refcnt_read(m) !=3D 1) {
> > +		*reason =3D "uninitialized ref cnt";
> > +		return -1;
> > +	}
> > +	if (m->next !=3D NULL) {
> > +		*reason =3D "uninitialized next ptr";
> > +		return -1;
> > +	}
> > +	if (m->nb_segs !=3D 1) {
> > +		*reason =3D "uninitialized nb_segs";
> > +		return -1;
> > +	}
> > +	if (RTE_MBUF_CLONED(m)) {
> > +		*reason =3D "cloned";
> > +		return -1;
> > +	}
> > +	if (RTE_MBUF_HAS_EXTBUF(m)) {
> > +		if (!RTE_MBUF_HAS_PINNED_EXTBUF(m)) {
> > +			*reason =3D "external buffer not pinned";
> > +			return -1;
> > +		}
> > +
> > +		uint16_t cnt =3D rte_mbuf_ext_refcnt_read(m->shinfo);
> > +		if ((cnt =3D=3D 0) || (cnt =3D=3D UINT16_MAX)) {
> > +			*reason =3D "pinned external buffer bad ref cnt";
> > +			return -1;
> > +		}
> > +		if (cnt !=3D 1) {
> > +			*reason =3D "pinned external buffer uninitialized ref
> cnt";
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	if (mp !=3D NULL && m->pool !=3D mp) {
> > +		*reason =3D "wrong mbuf pool";
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /* do some sanity checks on a mbuf: panic if it fails */
> >  RTE_EXPORT_SYMBOL(rte_mbuf_sanity_check)
> >  void
> > diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> > index 06ab7502a5..552cda1ae5 100644
> > --- a/lib/mbuf/rte_mbuf.h
> > +++ b/lib/mbuf/rte_mbuf.h
> > @@ -339,11 +339,17 @@ rte_pktmbuf_priv_flags(struct rte_mempool *mp)
> >
> >  #ifdef RTE_LIBRTE_MBUF_DEBUG
> >
> > +/**  check reinitialized mbuf type in debug mode */
> > +#define __rte_mbuf_raw_sanity_check_mp(m, mp)
> rte_mbuf_raw_sanity_check(m, mp)
> > +
> >  /**  check mbuf type in debug mode */
> >  #define __rte_mbuf_sanity_check(m, is_h) rte_mbuf_sanity_check(m,
> is_h)
> >
> >  #else /*  RTE_LIBRTE_MBUF_DEBUG */
> >
> > +/**  check reinitialized mbuf type in debug mode */
>=20
> This is in release mode, not debug mode. Comment below seems wrong =
too.

Yes, I noticed the comment was present in both debug and release mode, =
which I couldn't understand. So I guessed it was for Doxygen or some =
other parser.
I have seen weird stuff for Doxygen, e.g. "#ifdef __DOXYGEN__" for =
documenting a function [1], so I didn't attempt to understand the reason =
for it, but just followed the same pattern.

Also, the comment says that the macro does something in debug mode, so I =
guess that the comment is not incorrect (but misleading) when describing =
a release mode macro.
Again, I didn't understand it, so I left it as is.

[1]: =
https://elixir.bootlin.com/dpdk/v25.07/source/lib/eal/include/generic/rte=
_memcpy.h#L94

>=20
> > +#define __rte_mbuf_raw_sanity_check_mp(m, mp) do { } while (0)
> > +
> >  /**  check mbuf type in debug mode */
> >  #define __rte_mbuf_sanity_check(m, is_h) do { } while (0)
> >
> > @@ -513,6 +519,46 @@ rte_mbuf_ext_refcnt_update(struct
> rte_mbuf_ext_shared_info *shinfo,
> >  } while (0)
>=20
> <snip>
