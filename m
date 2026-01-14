Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193CDD39003
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 18:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6760840BA2;
	Wed, 14 Jan 2026 19:05:47 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id CC1A54027D;
 Wed, 14 Jan 2026 19:05:46 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F3185229AD;
 Wed, 14 Jan 2026 19:05:45 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: mbuf fast-free requirements analysis
Date: Wed, 14 Jan 2026 19:05:44 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6565E@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aWfGCglFfkpOAxgh@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mbuf fast-free requirements analysis
Thread-Index: AdyFc/iH98766/BeS1GkdpWC00fYNQACPvcg
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <aT_1J0If92bxkLG0@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
 <aWfGCglFfkpOAxgh@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <techboard@dpdk.org>,
 <dev@dpdk.org>
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
> Sent: Wednesday, 14 January 2026 17.36
>=20
> On Wed, Jan 14, 2026 at 04:31:31PM +0100, Morten Br=F8rup wrote:
> > > > If I'm not mistaken, the mbuf library is not a barrier for fast-
> > > freeing
> > > > segmented packet mbufs, and thus fast-free of jumbo frames is
> > > possible.
> > > >
> > > > We need a driver developer to confirm that my suggested approach
> -
> > > > resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', =
when
> > > > preparing the Tx descriptor - is viable.
> > > >
> > > Excellent analysis, Morten. If I get a chance some time this
> release
> > > cycle,
> > > I will try implementing this change in our drivers, see if any
> > > difference
> > > is made.
> >
> > Bruce,
> >
> > Have you had a chance to look into the driver change requirements?
> > If not, could you please try scratching the surface, to build a gut
> feeling.
>=20
> I'll try and take a look this week. Juggling a few things at the
> moment, so
> I had forgotten about this. Sorry.
>=20
> More comments inline below.
>=20
> /Bruce
>=20
> >
> > I wonder if the vector implementations have strong requirements that
> packets are not segmented...
> >
> > The i40 driver only sets "tx_simple_allowed" and "tx_vec_allowed"
> flags when MBUF_FAST_FREE is set:
> >
> =
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i4
> 0e_rxtx.c#L3502
> >
>=20
> Actually, it allows but does not require FAST_FREE. The check is just
> verifying that the flags with everything *but* FAST_FREE masked out is
> the
> same as the original flags, i.e. FAST_FREE is just ignored.

That's not how I read the code:
ad->tx_simple_allowed =3D
	(txq->offloads =3D=3D
	 (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
	 txq->tx_rs_thresh >=3D I40E_TX_MAX_BURST);

Look at it with offloads=3D(MULTI_SEGS|FAST_FREE):
simple_allowed =3D (MULTI_SEGS|FAST_FREE) =3D=3D (MULTI_SEGS|FAST_FREE) =
& FAST_FREE
i.e.:
simple_allowed =3D (MULTI_SEGS|FAST_FREE) =3D=3D FAST_FREE
i.e.: false

>=20
> > And only when these two flags are set, it uses a vector Tx function:
> >
> =
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i4
> 0e_rxtx.c#L3550
> > And a special Tx Prep function:
> >
> =
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i4
> 0e_rxtx.c#L3584
> > Which fails if nb_segs !=3D 1:
> >
> =
https://elixir.bootlin.com/dpdk/v25.11/source/drivers/net/intel/i40e/i4
> 0e_rxtx.c#L1675
> >
> > So currently it does.
> > But does it need to?... That is the question.
> > Paraphrasing:
> > Can the Tx function only be vectorized when the code path doesn't
> have branches depending on the number of segments?
> > If so, then this may be the main reason for not supporting segmented
> packets with FAST_FREE.
> >
> > In that case, we cannot remove the single-segment requirement from
> FAST_FREE without sacrificing the performance boost from vectorizing.
>=20
> No, based on what I state above, this should not be a blocker. The
> vector
> paths do require us to guarantee only one segment per packet - without
> additional context descriptors - so only one descriptor per packet
> (generally, or always one + ctx, in one code-path case). FAST_FREE can
> be
> used in conjunction with that but should not be a requirement. See [1]
> where in vector cleanup we explicitly check for FAST_FREE.
>=20
> Similarly for scalar code path, in my latest rework, I am attempting =
to
> standardize the use of FAST_FREE optimizations even when we have a
> slightly
> slower Tx path [2].

Good point:
The Tx path has two steps:
1) Pre-transmission Tx descriptor setup.
2) Post-transmission mbuf free.

FAST_FREE requirements for optimizing each of these two steps might =
differ.

As suggested in my other email, hopefully the post-transmission step can =
be vectorized (also for multi-segment packets) by assisting it in the =
pre-transmission step - i.e. by preparing the FAST_FREE segments for =
direct release to the mempool.

Then we can consider single-segment requirements for the =
pre-transmission step.

>=20
> [1]
> https://github.com/DPDK/dpdk/blob/main/drivers/net/intel/common/tx.h
> [2] =
https://patches.dpdk.org/project/dpdk/patch/20260113151505.1871271-
> 31-bruce.richardson@intel.com/
>=20
> >
> > But then we can proceed pursuing alternative optimizations, as
> suggested by Konstantin.
> >
> > Here's another idea:
> > The Tx function could pre-scan each Tx burst for multi-segment
> packets, to decide if the burst should be processed by the vector code
> path or a fallback code path (which can also handle multi-segment
> packets).
> >
> >
> > -Morten
> >
