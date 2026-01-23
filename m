Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C8D74EC2
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 13:06:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50AC44026F;
	Fri, 23 Jan 2026 14:06:07 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BDDC140269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 14:06:05 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DDE2A2071A;
 Fri, 23 Jan 2026 14:06:04 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/intel: optimize for fast-free hint
Date: Fri, 23 Jan 2026 14:06:01 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65696@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aXNvZr89NmNuxy9W@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/intel: optimize for fast-free hint
Thread-Index: AdyMZ15LpBP26A28SImOUbkZeYSU4QAAGyzA
References: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
 <20260123112032.2174361-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65694@smartserver.smartshare.dk>
 <aXNk6DRHvzH1WuK7@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65695@smartserver.smartshare.dk>
 <aXNvZr89NmNuxy9W@bricha3-mobl1.ger.corp.intel.com>
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
> Sent: Friday, 23 January 2026 13.54
>=20
> On Fri, Jan 23, 2026 at 01:27:54PM +0100, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Friday, 23 January 2026 13.09
> > >
> > > On Fri, Jan 23, 2026 at 01:05:10PM +0100, Morten Br=F8rup wrote:
> > > > I haven't looked into the details yet, but have a quick question
> > > inline below.
> > > >
> > > > > @@ -345,12 +345,20 @@ ci_txq_release_all_mbufs(struct
> ci_tx_queue
> > > *txq,
> > > > > bool use_ctx)
> > > > >  		return;
> > > > >
> > > > >  	if (!txq->vector_tx) {
> > > > > -		for (uint16_t i =3D 0; i < txq->nb_tx_desc; i++) {
> > > > > -			if (txq->sw_ring[i].mbuf !=3D NULL) {
> > > >
> > > > You changed this loop to only operate on not-yet-cleaned
> descriptors.
> > > >
> > > > Here comes the first part of my question:
> > > > You removed the NULL check for txq->sw_ring[i].mbuf, thereby
> assuming
> > > that it is never NULL for not-yet-cleaned descriptors.
> > > >
> > >
> > > Good point, I was quite focused on making this block and the =
vector
> > > block
> > > the same, I forgot that we can have NULL pointers for context
> > > descriptors.
> > > That was a silly mistake (and AI never caught it for me either.)
> > >
> > > > > +		/* Free mbufs from (last_desc_cleaned + 1) to
> (tx_tail -
> > > > > 1). */
> > > > > +		const uint16_t start =3D (txq->last_desc_cleaned + 1) %
> txq-
> > > > > >nb_tx_desc;
> > > > > +		const uint16_t nb_desc =3D txq->nb_tx_desc;
> > > > > +		const uint16_t end =3D txq->tx_tail;
> > > > > +
> > > > > +		uint16_t i =3D start;
> >
> > Suggest getting rid of "start"; it is only used for initializing =
"i".
> >
>=20
> Not sure it's worth doing. I quite like having an explicit start and
> end
> values for clarity.

I have no preference, and it's a matter of taste, so the choice is =
yours. :-)

>=20
> > > > > +		if (end < i) {
> > > > > +			for (; i < nb_desc; i++)
> > > > >  				rte_pktmbuf_free_seg(txq-
> >sw_ring[i].mbuf);
> > > > > -				txq->sw_ring[i].mbuf =3D NULL;
> > > > > -			}
> > > > > +			i =3D 0;
> > > > >  		}
> > > > > +		for (; i < end; i++)
> > > > > +			rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> > > > > +		memset(txq->sw_ring, 0, sizeof(txq->sw_ring[0]) *
> nb_desc);
> >
> > Consider also splitting this memset() into two, one for each of the
> two for loops.
> > Then you might need to keep "start" and make it non-const. :-)
> >
>=20
> Don't see the point of that. The memset just zeros the whole array,
> ignoring wraparound so no point in doing two memsets when one will do.
>=20
> > > > >  		return; }
> >
> > Or just keep the original version, looping over all descriptors.
> >
>=20
> The reason for this whole change is that after the refactor the old
> code
> was wrong.
>=20
> The original code used the fact that all mbuf pointers were zereod or
> overwritten after being freed, but that no longer applies, because we
> free
> the mbufs in bulk after we check the dd bits, rather than doing so
> individually later immediately before reuse.  Instead, in both the
> datapath
> and this release path, we must use the index values to track what mbuf
> entries are valid or invalid. (We go from having two states, NULL or
> non-NULL, to 3; invalid i.e. freed or NULL, valid-NULL i.e. in slot
> used by
> context descriptor, valid-non-NULL i.e. a pointer to a =
not-yet-cleaned-
> up
> mbuf).

Thank you for clarifying.

I thought of the two for loops as a kind of performance optimization, =
skipping the sub-array of already freed descriptors. In that case, =
memsetting only the two remaining sub-arrays might have been a good =
idea.
That's not the case, so having one memset for the whole array is =
perfectly fine.

