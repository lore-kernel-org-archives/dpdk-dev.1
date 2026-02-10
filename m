Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A89EA3F2A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 09:28:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31E4A400D7;
	Tue, 10 Feb 2026 10:28:15 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 72064400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 10:28:13 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 40B4F208FB;
 Tue, 10 Feb 2026 10:28:13 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 20/35] net/intel: write descriptors using non-volatile
 pointers
Date: Tue, 10 Feb 2026 10:28:10 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656F9@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aYr0bDamNTwyDl9D@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 20/35] net/intel: write descriptors using non-volatile
 pointers
Thread-Index: AdyabC5k7cVYs9VwQzyejkeBJh1rJwAAomsA
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-21-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656F6@smartserver.smartshare.dk>
 <aYr0bDamNTwyDl9D@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Tuesday, 10 February 2026 10.04
>=20
> On Tue, Feb 10, 2026 at 12:08:44AM +0100, Morten Br=F8rup wrote:
> > > +static inline void
> > > +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> > > +{
> > > +	uint64_t *txd_qw =3D __rte_assume_aligned(RTE_CAST_PTR(void *,
> > > txd), 16);
> > > +
> > > +	txd_qw[0] =3D rte_cpu_to_le_64(qw0);
> > > +	txd_qw[1] =3D rte_cpu_to_le_64(qw1);
> > > +}
> >
> > How about using __rte_aligned() instead, something like this
> (untested):
> >
> > struct __rte_aligned(16) txd_t {
> > 	uint64_t	qw0;
> > 	uint64_t	qw1;
> > };
>=20
> I can see if this works for us...
>=20
> >
> > *RTE_CAST_PTR(volatile struct txd_t *, txd) =3D {
> rte_cpu_to_le_64(qw0),
> > rte_cpu_to_le_64(qw1) };
> >
> >
> > And why strip the "volatile"?
> >
>=20
> For the descriptor writes, it doesn't matter the order in which the
> descriptors and the descriptor fields are actually written, since the
> NIC
> relies upon the tail pointer update - which includes a fence - to
> inform it
> of when the descriptors are ready. The volatile is necessary for =
reads,
> though, which is why the ring is marked as such, but for Tx it =
prevents
> the
> compiler from opportunistically e.g. converting two 64-byte writes =
into
> a
> 128-byte write.

Makes sense.
Suggest that you spread out a few comments about this at the relevant =
locations in the source code.


