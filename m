Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC21C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:16:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CDB2406B6;
	Wed, 25 Jun 2025 13:16:01 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1AC7640677
 for <dev@dpdk.org>; Wed, 25 Jun 2025 13:16:01 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B691820789;
 Wed, 25 Jun 2025 13:16:00 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/i40e: Fast release optimizations
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 25 Jun 2025 13:15:57 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD3B@smartserver.smartshare.dk>
In-Reply-To: <aFvT2qlUuS9_Tgcc@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/i40e: Fast release optimizations
Thread-Index: AdvlvqKL4ckl+l8cRxqSJcj1XB2BFAAAxErw
References: <20250624061238.89259-1-mb@smartsharesystems.com>
 <aFvT2qlUuS9_Tgcc@bricha3-mobl1.ger.corp.intel.com>
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
> Sent: Wednesday, 25 June 2025 12.48
>=20
> On Tue, Jun 24, 2025 at 06:12:38AM +0000, Morten Br=F8rup wrote:
> > When fast releasing mbufs, the mbufs are not accessed, so do not
> prefetch
> > them.
> > This saves a mbuf load operation for each fast released TX mbuf.
> >
> > When fast release of mbufs is enabled for a TX queue, cache the mbuf
> > mempool pointer in the TX queue structure.
> > This saves one mbuf load operation for each burst of fast released =
TX
> > mbufs.
> >
> > The txep->mbuf pointer is not used after the mbuf has been freed, so
> do
> > not reset the pointer.
> > This saves a txep store operation for each TX mbuf freed.
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> > ---
> >  drivers/net/intel/common/tx.h                 |  5 +++
> >  .../i40e/i40e_recycle_mbufs_vec_common.c      |  4 +-
> >  drivers/net/intel/i40e/i40e_rxtx.c            | 39 =
++++++++++--------
> -
> >  3 files changed, 28 insertions(+), 20 deletions(-)
> >
> Thanks, Morten. This optimization probably applies other places in our
> drivers too. I'll look at this patch - and where else it can apply - =
for
> 25.11, since we are nearing the end of the 25.07 release cycle.

Agreed. Also about waiting until 25.11.

Note when reviewing...

I also considered replacing:
	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
with:
	if (txq->fast_free_mp !=3D NULL)

However, I assume txq->offloads is hot in the cache, while =
txq->fast_free_mp is only relevant if using fast free, and thus not as =
hot.
So I chose not to.

