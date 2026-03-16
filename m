Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E80F53D6D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 783654025E;
	Mon, 16 Mar 2026 16:55:32 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 409C4400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:55:31 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0E201208E0;
 Mon, 16 Mar 2026 16:55:31 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Mar 2026 16:55:29 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
In-Reply-To: <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Thread-Index: Ady1Wkq68sX5DesxQmugx17/789bLwAALezw
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	"Reshma Pattan" <reshma.pattan@intel.com>
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
> Sent: Monday, 16 March 2026 16.34
>=20
> On Tue, Mar 10, 2026 at 09:10:03AM -0700, Stephen Hemminger wrote:
> > When the source port has VLAN strip enabled, captured packets have
> > the VLAN tag in mbuf metadata (vlan_tci) but not in the packet data.
> > Similarly, TX captures with pending VLAN insert have the tag only
> > in metadata. The resulting pcap files contain untagged packets.
> >
> > Convert RX_VLAN_STRIPPED metadata to TX_VLAN offload requests on
> > dequeued mbufs and call rte_eth_tx_prepare() before
> rte_eth_tx_burst()
> > so the pcap vdev inserts the tag into the packet data.
> >
>=20
> This is an example of something I previously flagged. Like with real
> hardware, I think the PMD should be inserting the VLAN tag into the
> packet
> as part of the Tx function, not the prepare function.

Agree with Bruce on this.
For simple stuff like VLAN offload, applications should not be required =
to call tx_prep first.

However, the Tx function is supposed to not modify the packets; relevant =
when refcnt > 1.

Instead of modifying the packet data to insert/strip the VLAN tag,
perhaps the driver can split the write/read operation into multiple =
write/read operations:
1. the Ethernet header
2. the VLAN tag
3. the remaining packet data

I haven't really followed the pcap driver, so maybe my suggestion =
doesn't make sense.


Let's say an application adds 1 to the mbufs' refcnt before each Tx, so =
the mbufs still exist after Tx.
Then, the application captures/mirrors the packets consumed by the =
driver, and logs/drops the packets the driver was unable to consume.
If the capture/mirror is filtering by VLAN ID, modifying the packets in =
the driver's Tx function is bad.

-Morten

