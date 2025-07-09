Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F68C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 16:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 252A7402A3;
	Wed,  9 Jul 2025 18:09:31 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5731B4028C
 for <dev@dpdk.org>; Wed,  9 Jul 2025 18:09:29 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1EC60204A9;
 Wed,  9 Jul 2025 18:09:29 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Intel i40e rx burst API non-conformance?
Content-Transfer-Encoding: quoted-printable
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Wed, 9 Jul 2025 18:09:27 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDAC@smartserver.smartshare.dk>
In-Reply-To: <aG6Kmun_ibhZsL3K@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel i40e rx burst API non-conformance?
Thread-Index: Advw5iiud0Gkz4T6TUKfhPuYInGf/QAAsqbw
References: <98CBD80474FA8B44BF855DF32C47DC35E9FDAB@smartserver.smartshare.dk>
 <aG6Kmun_ibhZsL3K@bricha3-mobl1.ger.corp.intel.com>
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
> Sent: Wednesday, 9 July 2025 17.28
>=20
> On Wed, Jul 09, 2025 at 04:59:51PM +0200, Morten Br=F8rup wrote:
> > Looking at the i40e driver source code, I think it doesn't conform =
to
> the API when requesting small bursts.
> >
> > Let's say the hardware has received 31 packets.
> > rte_eth_rx_burst(...,16) will return 16 packets and leave 15 in the
> driver's staging buffer (which has capacity for 32 packets).
> >
> > Time passes, and more packets are received.
> >
> > Now, rte_eth_rx_burst(...,16) will only return the 15 packets from =
the
> staging buffer, and not proceed to check for more [1].
> > It thereby (according to my interpretation of the API description)
> informs the application that no more packets are ready to be received,
> which is incorrect.
> >
>=20
> Again, the spec is not entirely clear. I would partially agree with =
you
> and
> partially disagree, but overall, it's probably not the best behaviour
> here.

I think that the non-conformant behavior only applies to requests for =
less than 32 packets.
(Maybe also for requests for numbers of packets that are not divisible =
by 32.)
Not for requests for 32, 64 or 128 packets.

>=20
> Rather than informing the app that there are no more packets, I would
> say
> instead that it incorrectly informs the app that the descriptor ring =
is
> not
> potentially overloaded. The reason for the difference is that, even in
> the
> case of a driver correctly returning any number of packets, by the =
time
> the
> function returns there could always be more in the ring. Where the =
real
> risk, IMHO, is that you could miss out on a ring filling up without
> being
> aware of it, because a full burst is a warning sign of overload.

I agree with your clarification of the meaning of the returned value.

This is also how our application interprets the response:
Non-full burst =3D "work done, normal scheduling",
Full burst =3D "more work potentially pending, urgent scheduling".

>=20
> /Bruce
>=20
> > [1]: https://elixir.bootlin.com/dpdk/v25.07-
> rc2/source/drivers/net/intel/i40e/i40e_rxtx.c#L640
> >
> > PS: I stumbled across this while reviewing how the very old 32 =
packet
> limit bugs (where it truncated large rx/tx requests to 32 packets) had
> been fixed.
> >
