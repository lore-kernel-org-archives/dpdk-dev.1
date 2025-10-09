Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B3CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 17:35:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C80F402A0;
	Thu,  9 Oct 2025 19:35:58 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B4F4840267
 for <dev@dpdk.org>; Thu,  9 Oct 2025 19:35:56 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6E0A6202CC;
 Thu,  9 Oct 2025 19:35:56 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Date: Thu, 9 Oct 2025 19:35:54 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654B7@smartserver.smartshare.dk>
In-Reply-To: <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Thread-Index: Adw5QE2yB3b0wyYmQ2aHfpMPWHyYMQAAEbWg
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-4-mb@smartsharesystems.com>
 <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
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
> Sent: Thursday, 9 October 2025 19.15
>=20
> On Sat, Aug 23, 2025 at 06:30:02AM +0000, Morten Br=F8rup wrote:
> > An optimized function for resetting a bulk of newly allocated
> > reinitialized mbufs (a.k.a. raw mbufs) was added.
> >
> > Compared to the normal packet mbuf reset function, it takes =
advantage
> of
> > the following two details:
> > 1. The 'next' and 'nb_segs' fields are already reset, so resetting
> them
> > has been omitted.
> > 2. When resetting the mbuf, the 'ol_flags' field must indicate
> whether the
> > mbuf uses an external buffer, and the 'data_off' field must not
> exceed the
> > data room size when resetting the data offset to include the default
> > headroom.
> > Unlike the normal packet mbuf reset function, which reads the mbuf
> itself
> > to get the information required for resetting these two fields, this
> > function gets the information from the mempool.
> >
> > This makes the function write-only of the mbuf, unlike the normal
> packet
> > mbuf reset function, which is read-modify-write of the mbuf.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
> >  lib/mbuf/rte_mbuf.h | 74 =
++++++++++++++++++++++++++++---------------
> --
> >  1 file changed, 46 insertions(+), 28 deletions(-)
> >
> > diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> > index 49c93ab356..6f37a2e91e 100644
> > --- a/lib/mbuf/rte_mbuf.h
> > +++ b/lib/mbuf/rte_mbuf.h
> > @@ -954,6 +954,50 @@ static inline void
> rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
> >  					(uint16_t)m->buf_len);
> >  }
> >
> > +/**
> > + * Reset the fields of a bulk of packet mbufs to their default
> values.
> > + *
> > + * The caller must ensure that the mbufs come from the specified
> mempool,
> > + * are direct and properly reinitialized (refcnt=3D1, next=3DNULL,
> nb_segs=3D1),
> > + * as done by rte_pktmbuf_prefree_seg().
> > + *
> > + * This function should be used with care, when optimization is
> required.
> > + * For standard needs, prefer rte_pktmbuf_reset().
> > + *
> > + * @param mp
> > + *   The mempool to which the mbuf belongs.
> > + * @param mbufs
> > + *   Array of pointers to packet mbufs.
> > + *   The array must not contain NULL pointers.
> > + * @param count
> > + *   Array size.
> > + */
> > +static inline void
> > +rte_mbuf_raw_reset_bulk(struct rte_mempool *mp, struct rte_mbuf
> **mbufs, unsigned int count)
> > +{
> > +	uint64_t ol_flags =3D (rte_pktmbuf_priv_flags(mp) &
> RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) ?
> > +			RTE_MBUF_F_EXTERNAL : 0;
> > +	uint16_t data_off =3D RTE_MIN_T(RTE_PKTMBUF_HEADROOM,
> rte_pktmbuf_data_room_size(mp),
> > +			uint16_t);
> > +
> > +	for (unsigned int idx =3D 0; idx < count; idx++) {
> > +		struct rte_mbuf *m =3D mbufs[idx];
> > +
> > +		m->pkt_len =3D 0;
> > +		m->tx_offload =3D 0;
> > +		m->vlan_tci =3D 0;
> > +		m->vlan_tci_outer =3D 0;
> > +		m->port =3D RTE_MBUF_PORT_INVALID;
>=20
> Have you considered doing all initialization using 64-bit stores? It's
> generally cheaper to do a single 64-bit store than e.g. set of 16-bit
> ones.

The code is basically copy-paste from rte_pktmbuf_reset().
I kept it the same way for readability.

> This also means that we could remove the restriction on having refcnt
> and
> nb_segs already set. As in PMDs, a single store can init data_off,
> ref_cnt,
> nb_segs and port.

Yes, I have given the concept a lot of thought already.
If we didn't require mbufs residing in the mempool to have any fields =
initialized, specifically "next" and "nb_segs", it would improve =
performance for drivers freeing mbufs back to the mempool, because =
writing to the mbufs would no longer be required at that point; the =
mbufs could simply be freed back to the mempool. Instead, we would =
require the driver to initialize these fields - which it probably does =
on RX anyway, if it supports segmented packets.
But I consider this concept a major API change, also affecting =
applications assuming that these fields are initialized when allocating =
raw mbufs from the mempool. So I haven't pursued it.

>=20
> Similarly for packet_type and pkt_len, and data_len/vlan_tci and rss
> fields
> etc. For max performance, the whole of the mbuf cleared here can be
> done in
> 40 bytes, or 5 64-bit stores. If we do the stores in order, possibly
> the
> compiler can even opportunistically coalesce more stores, so we could
> even
> end up getting 128-bit or larger stores depending on the ISA compiled
> for.
> [Maybe the compiler will do this even if they are not in order, but =
I'd
> like to maximize my chances here! :-)]
>=20
> /Bruce
>=20
> > +
> > +		m->ol_flags =3D ol_flags;
> > +		m->packet_type =3D 0;
> > +		m->data_off =3D data_off;
> > +
> > +		m->data_len =3D 0;
> > +		__rte_mbuf_sanity_check(m, 1);
> > +	}
> > +}
> > +
> <snip>
