Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B4C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 17:29:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFFB540267;
	Thu,  3 Jul 2025 19:29:33 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id F3B6540264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 19:29:32 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BEA3220636;
 Thu,  3 Jul 2025 19:29:32 +0200 (CEST)
Content-class: urn:content-classes:message
Subject: RE: [RFC] ethdev: TX mbuf fast release optimization
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 3 Jul 2025 19:29:30 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FD8A@smartserver.smartshare.dk>
In-Reply-To: <aGajTksN6fYProxS@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] ethdev: TX mbuf fast release optimization
Thread-Index: AdvsMCkuXmSA/EajSdSuzZP5LNiQdgADnmrw
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD87@smartserver.smartshare.dk>
 <aGaQNxwbTTTF0Al7@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD88@smartserver.smartshare.dk>
 <aGaf3Ii3OxErvYEw@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD89@smartserver.smartshare.dk>
 <aGajTksN6fYProxS@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <thomas@monjalon.net>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
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
> Sent: Thursday, 3 July 2025 17.36
>=20
> On Thu, Jul 03, 2025 at 05:29:26PM +0200, Morten Br=F8rup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Thursday, 3 July 2025 17.21
> > >
> > > On Thu, Jul 03, 2025 at 05:12:46PM +0200, Morten Br=F8rup wrote:
> > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > > Sent: Thursday, 3 July 2025 16.14
> > > > >
> > > > > On Thu, Jul 03, 2025 at 03:59:14PM +0200, Morten Br=F8rup =
wrote:
> > > > > > For TX mbuf fast release offload, I propose to add the mbuf
> > > mempool
> > > > > > pointer to the ethdev tx queue configuration structure,
> > > > > > so the ethdev TX burst operation doesn't need to fetch it =
from
> the
> > > > > > first mbuf of each burst being fast free'd to the mempool.
> > > > > >
> > > > > > This modification of the struct rte_eth_txconf, and the
> > > requirement
> > > > > > to set the mempool pointer if the
> > > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
> > > > > > flag is set, will be an API+ABI change in 25.11.
> > > > > > Should it be announced in the 25.07 release notes?
> > > > > >
> > > > > > Note: We could phase it in softly by letting the ethdev
> drivers
> > > > > > check if the pointer has been set, and fall back to fetching
> it
> > > > > > from mbuf[0] if not.
> > > > > >
> > > > > > /**
> > > > > >  * A structure used to configure a Tx ring of an Ethernet
> port.
> > > > > >  */
> > > > > > struct rte_eth_txconf {
> > > > > > 	struct rte_eth_thresh tx_thresh; /**< Tx ring threshold
> > > registers.
> > > > > */
> > > > > > 	uint16_t tx_rs_thresh; /**< Drives the setting of RS bit on
> > > TXDs.
> > > > > */
> > > > > > 	uint16_t tx_free_thresh; /**< Start freeing Tx buffers if
> > > there
> > > > > are
> > > > > > 				      less free descriptors than this
> > > value. */
> > > > > >
> > > > > > 	uint8_t tx_deferred_start; /**< Do not start queue with
> > > > > rte_eth_dev_start(). */
> > > > > > 	/**
> > > > > > 	 * Per-queue Tx offloads to be set  using
> > > RTE_ETH_TX_OFFLOAD_*
> > > > > flags.
> > > > > > 	 * Only offloads set on tx_queue_offload_capa or
> > > tx_offload_capa
> > > > > > 	 * fields on rte_eth_dev_info structure are allowed to be
> > > set.
> > > > > > 	 */
> > > > > > 	uint64_t offloads;
> > > > > >
> > > > > > +	/**
> > > > > > +	 * Per-queue mempool to release the mbufs to; required for
> > > > > > +	 * RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > > > > > +	 */
> > > > > > +	struct rte_mempool *mp;
> > > > > > +
> > > > >
> > > > > Is this really best put in the txconf struct? Would it not be
> better
> > > > > just
> > > > > stored in the queue structure on free or Tx of the first =
packet?
> > > That
> > > > > would
> > > > > make it not change the ABI.
> > > >
> > > > It seems natural to me to specify the mempool at configuration
> time,
> > > > because it is a configuration parameter.
> > > > The txconf struct seemed like the best place to put it.
> > > >
> > > > Fetching it from the first mbuf of each burst at runtime, and
> possibly
> > > caching it, seems like a workaround for the missing configuration
> > > parameter.
> > > >
> > > Not suggesting from each burst, just the first mbuf seen. One time
> only.
> >
> > That's what I meant by "possibly caching it". :-)
> >
> > The check for the one-time cache update still takes up code space in
> the per-burst fast path. (Although very little.)
> >
> > But I still prefer providing configuration information at
> configuration time, rather than snooping it at runtime.
> >
> Ok, but then are we mandating that all existing apps now are required =
to
> pass in a mempool value on Tx queue config? I'm concerned about how =
many
> apps that may affect. On the other hand, if it is optional, does that
> not
> slow down the fastpath more having to check for this optional value?

Initially, it will be optional, and log a warning if not provided.
And yes, the fast path will incur a performance cost for checking its =
presence.

When its "experimental" status expires, it will be required, and return =
failure if not provided.
Then the fast path no longer needs to consider its non-presence, and the =
performance cost can be eliminated.

