Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A762CCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 09:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D62940285;
	Fri, 10 Oct 2025 11:22:03 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5F83C4027A
 for <dev@dpdk.org>; Fri, 10 Oct 2025 11:22:02 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 25023202CC;
 Fri, 10 Oct 2025 11:22:02 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Date: Fri, 10 Oct 2025 11:22:00 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F654BB@smartserver.smartshare.dk>
In-Reply-To: <aOi5PIYXMPBrZLx2@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Thread-Index: Adw5ua3Jn6gHnR1IROyRbbQ9bOe6swADE1Yw
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-4-mb@smartsharesystems.com>
 <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654B7@smartserver.smartshare.dk>
 <aOi5PIYXMPBrZLx2@bricha3-mobl1.ger.corp.intel.com>
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
> Sent: Friday, 10 October 2025 09.44
>=20
> On Thu, Oct 09, 2025 at 07:35:54PM +0200, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Thursday, 9 October 2025 19.15
> > >
> > > On Sat, Aug 23, 2025 at 06:30:02AM +0000, Morten Br=F8rup wrote:
> > > > An optimized function for resetting a bulk of newly allocated
> > > > reinitialized mbufs (a.k.a. raw mbufs) was added.
> > > >
> > > > Compared to the normal packet mbuf reset function, it takes
> advantage
> > > of
> > > > the following two details:
> > > > 1. The 'next' and 'nb_segs' fields are already reset, so
> resetting
> > > them
> > > > has been omitted.
> > > > 2. When resetting the mbuf, the 'ol_flags' field must indicate
> > > whether the
> > > > mbuf uses an external buffer, and the 'data_off' field must not
> > > exceed the
> > > > data room size when resetting the data offset to include the
> default
> > > > headroom.
> > > > Unlike the normal packet mbuf reset function, which reads the
> mbuf
> > > itself
> > > > to get the information required for resetting these two fields,
> this
> > > > function gets the information from the mempool.
> > > >
> > > > This makes the function write-only of the mbuf, unlike the =
normal
> > > packet
> > > > mbuf reset function, which is read-modify-write of the mbuf.
> > > >
> > > > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > > > ---
> > > >  lib/mbuf/rte_mbuf.h | 74 =
++++++++++++++++++++++++++++-----------
> ----
> > > --
> > > >  1 file changed, 46 insertions(+), 28 deletions(-)
> > > >
> > > > diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
> > > > index 49c93ab356..6f37a2e91e 100644
> > > > --- a/lib/mbuf/rte_mbuf.h
> > > > +++ b/lib/mbuf/rte_mbuf.h
> > > > @@ -954,6 +954,50 @@ static inline void
> > > rte_pktmbuf_reset_headroom(struct rte_mbuf *m)
> > > >  					(uint16_t)m->buf_len);
> > > >  }
> > > >
> > > > +/**
> > > > + * Reset the fields of a bulk of packet mbufs to their default
> > > values.
> > > > + *
> > > > + * The caller must ensure that the mbufs come from the =
specified
> > > mempool,
> > > > + * are direct and properly reinitialized (refcnt=3D1, =
next=3DNULL,
> > > nb_segs=3D1),
> > > > + * as done by rte_pktmbuf_prefree_seg().
> > > > + *
> > > > + * This function should be used with care, when optimization is
> > > required.
> > > > + * For standard needs, prefer rte_pktmbuf_reset().
> > > > + *
> > > > + * @param mp
> > > > + *   The mempool to which the mbuf belongs.
> > > > + * @param mbufs
> > > > + *   Array of pointers to packet mbufs.
> > > > + *   The array must not contain NULL pointers.
> > > > + * @param count
> > > > + *   Array size.
> > > > + */
> > > > +static inline void
> > > > +rte_mbuf_raw_reset_bulk(struct rte_mempool *mp, struct rte_mbuf
> > > **mbufs, unsigned int count)
> > > > +{
> > > > +	uint64_t ol_flags =3D (rte_pktmbuf_priv_flags(mp) &
> > > RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) ?
> > > > +			RTE_MBUF_F_EXTERNAL : 0;
> > > > +	uint16_t data_off =3D RTE_MIN_T(RTE_PKTMBUF_HEADROOM,
> > > rte_pktmbuf_data_room_size(mp),
> > > > +			uint16_t);
> > > > +
> > > > +	for (unsigned int idx =3D 0; idx < count; idx++) {
> > > > +		struct rte_mbuf *m =3D mbufs[idx];
> > > > +
> > > > +		m->pkt_len =3D 0;
> > > > +		m->tx_offload =3D 0;
> > > > +		m->vlan_tci =3D 0;
> > > > +		m->vlan_tci_outer =3D 0;
> > > > +		m->port =3D RTE_MBUF_PORT_INVALID;
> > >
> > > Have you considered doing all initialization using 64-bit stores?
> It's
> > > generally cheaper to do a single 64-bit store than e.g. set of 16-
> bit
> > > ones.
> >
> > The code is basically copy-paste from rte_pktmbuf_reset().
> > I kept it the same way for readability.
> >
>=20
> I'd think using 64-bit stores should be fine for readability so long =
as
> there is a comment on each one (maybe with compile-time checks for
> field
> layout).

OK. I'll put this additional optimization on my TODO list for later, and =
will do it for both rte_mbuf_raw_reset_bulk() and rte_pktmbuf_reset(). =
I'm too busy with another project to do it now.

>=20
> > > This also means that we could remove the restriction on having
> refcnt
> > > and
> > > nb_segs already set. As in PMDs, a single store can init data_off,
> > > ref_cnt,
> > > nb_segs and port.
> >
> > Yes, I have given the concept a lot of thought already.
> > If we didn't require mbufs residing in the mempool to have any =
fields
> initialized, specifically "next" and "nb_segs", it would improve
> performance for drivers freeing mbufs back to the mempool, because
> writing to the mbufs would no longer be required at that point; the
> mbufs could simply be freed back to the mempool. Instead, we would
> require the driver to initialize these fields - which it probably does
> on RX anyway, if it supports segmented packets.
> > But I consider this concept a major API change, also affecting
> applications assuming that these fields are initialized when =
allocating
> raw mbufs from the mempool. So I haven't pursued it.
> >
> Yes, agreed. Let's not change anything in those restrictions.

Maybe later, if the tech board agrees to such a change.

>=20
> /Bruce
