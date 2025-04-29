Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC02C369DC
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 13:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BEBF402A3;
	Tue, 29 Apr 2025 15:34:41 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7ACCE40277
 for <dev@dpdk.org>; Tue, 29 Apr 2025 15:34:40 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3D84B20DBD;
 Tue, 29 Apr 2025 15:34:40 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: rte_eth_stats_get seems slow
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 29 Apr 2025 15:34:37 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FC13@smartserver.smartshare.dk>
In-Reply-To: <aBDLk4GKhtJzn6Ye@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: rte_eth_stats_get seems slow
Thread-Index: Adu5BZzjjhp3cxtMTL2Le2XBRgO/cQAALBNA
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC02@smartserver.smartshare.dk>
 <20250426082352.260b9b5d@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC03@smartserver.smartshare.dk>
 <aBDLk4GKhtJzn6Ye@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>,
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
> Sent: Tuesday, 29 April 2025 14.53
>=20
> On Sun, Apr 27, 2025 at 09:00:31AM +0200, Morten Br=F8rup wrote:
> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Saturday, 26 April 2025 17.24
> > >
> > > On Fri, 25 Apr 2025 13:52:55 +0200
> > > Morten Br=F8rup <mb@smartsharesystems.com> wrote:
> > >
> > > > Bruce,
> > > >
> > > > rte_eth_stats_get() on Intel NICs seems slow to me.
> > > >
> > > > E.g. getting the stats on a single port takes ~132 us (~451,000
> CPU
> > > cycles) using the igb driver, and ~50 us using the i40e driver.
> > > >
> > > > Referring to the igb driver source code [1], it's 44 calls to
> > > E1000_READ_REG(), so the math says that each one takes 3 us
> (~10,000
> > > CPU cycles).
> > > >
> > > > Is this expected behavior?
> > > >
> > > > It adds up, e.g. it takes a full millisecond to fetch the stats
> from
> > > eight ports using the igb driver.
> > > >
> > > > [1]:
> > >
> =
https://elixir.bootlin.com/dpdk/v24.11.1/source/drivers/net/e1000/igb_e
> > > thdev.c#L1724
> > > >
> > > >
> > > > Med venlig hilsen / Kind regards,
> > > > -Morten Br=F8rup
> > > >
> > >
> > > Well reading each stat requires a PCI access. And PCI accesses are
> non-
> > > cached.
> >
> > You're right, thank you for reminding me. I was caught by surprise
> that getting 7 counters took so long.
> > Perhaps reading 44 NIC registers over the PCI bus is required to
> calculate those summary counters. Or nobody cared to optimize this
> function to only read the necessary registers.
> >
> > We periodically poll the ethdev stats in a management thread, and I
> noticed the duration because of the jitter it caused in that thread.
> > It's not a real problem. If it was, we could easily move it to a
> separate thread or poll the counters iteratively port by port, instead
> of all ports in one go.
> > A longwinded way of saying: Probably not worth optimizing. ;-)
> >
>=20
> I actually think it is something that we should consider optimizing,
> but I
> also think it needs to be done at the API level. Even if the user is
> only
> interested in e.g. the Rx bytes counter, the only way to get that is =
to
> retrieve the full stats set and use the counter from it. Therefore,
> instead
> of reading (possibly) just one register, you end up reading 44 as in
> the
> case you describe. Maybe we need to add a stats mask to the get call,
> to
> allow a user to indicate that they only want a subset of the stats, in
> order to improve performance.

I think xstats already serves that purpose.

<feature creep>
We could improve xstats by maintaining a repository of standardized =
xstats counter names and definitions. That would also make it possible =
to conformance test these.
</feature creep>

Basic stats in struct rte_eth_stats [2] are 7 counters + the rx_nombuf =
software counter. This should be acceptable. And it makes it very easy =
for an application to implement basic ethdev stats.

For some reason, struct rte_eth_stats also holds the per-queue counters. =
They should be moved out of here.
The documentation for rte_eth_stats_get() even says that it only fills =
the first part, not the per-queue counters, so it should be possible.

The igb driver fetches many registers not required for getting the 7 =
counters asked for. E.g. fetching the packet size range counters is =
certainly not required, but the driver does it anyway.
If other drivers implement a similar design pattern ("fetch all counters =
to update some"), the execution time of an API call supposedly fetching =
7 counters may come as a surprise to other developers too.
So perhaps a warning about execution time should be added to the =
rte_eth_stats_get() documentation, to formally accept this behavior by =
drivers. That would be an easy fix. :-)

[2]: =
https://elixir.bootlin.com/dpdk/v24.11.1/source/lib/ethdev/rte_ethdev.h#L=
262
