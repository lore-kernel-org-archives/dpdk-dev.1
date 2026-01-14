Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF59D38FF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E981340A71;
	Wed, 14 Jan 2026 18:31:29 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 932534027D;
 Wed, 14 Jan 2026 18:31:28 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E327E229AD;
 Wed, 14 Jan 2026 18:31:27 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: mbuf fast-free requirements analysis
Date: Wed, 14 Jan 2026 18:31:24 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6565D@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <aWfL0un-qWa1vGCT@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mbuf fast-free requirements analysis
Thread-Index: AdyFd2g8mEBHGarwSpm1kELgEtyPcAAA151Q
References: <98CBD80474FA8B44BF855DF32C47DC35F655E0@smartserver.smartshare.dk>
 <aWfL0un-qWa1vGCT@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>,
	<techboard@dpdk.org>
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
> Sent: Wednesday, 14 January 2026 18.01
>=20
> On Mon, Dec 15, 2025 at 12:06:38PM +0100, Morten Br=F8rup wrote:
> > Executive Summary:
> >
> > My analysis shows that the mbuf library is not a barrier for fast-
> freeing
> > segmented packet mbufs, and thus fast-free of jumbo frames is
> possible.
> >
> >
> > Detailed Analysis:
> >
> > The purpose of the mbuf fast-free Tx optimization is to reduce
> > rte_pktmbuf_free_seg() to something much simpler in the ethdev
> drivers, by
> > eliminating the code path related to indirect mbufs.
> > Optimally, we want to simplify the ethdev driver's function that
> frees the
> > transmitted mbufs, so it can free them directly to their mempool
> without
> > accessing the mbufs themselves.
> >
> > If the driver cannot access the mbuf itself, it cannot determine
> which
> > mempool it belongs to.
> > We don't want the driver to access every mbuf being freed; but if =
all
> > mbufs of a Tx queue belong to the same mempool, the driver can
> determine
> > which mempool by looking into just one of the mbufs.
> >
>=20
> <snip>
>=20
> >
> > If I'm not mistaken, the mbuf library is not a barrier for fast-
> freeing
> > segmented packet mbufs, and thus fast-free of jumbo frames is
> possible.
> >
> > We need a driver developer to confirm that my suggested approach -
> > resetting the mbuf fields, incl. 'm->nb_segs' and 'm->next', when
> > preparing the Tx descriptor - is viable.
> >
>=20
> Just to make sure I understand things correctly here, the suggestion =
to
> prototype is:
>=20
> - When FAST_FREE flag is set:
>   - reset the m->nb_segs and m->next fields (if necessary) when
> accessing
>     the mbuf to write the descriptor
>   - skip calling pre-free seg on cleanup and instead
>   - just free all buffers directly to the mempool
>=20
> Is that correct?

Yes.
If this can be done with multi-segment packets, we should be able to =
eliminate the single-segment requirement to FAST_FREE.
(Unless something in the code that writes the descriptor requires =
single-segment to be super performant, as I suspected of vectorization.)

