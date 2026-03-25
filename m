Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F0FFEA83C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:36:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 223D4402CE;
	Wed, 25 Mar 2026 10:36:58 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 156C34028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:36:56 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D5D9021353;
 Wed, 25 Mar 2026 10:36:55 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Date: Wed, 25 Mar 2026 10:36:56 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
In-Reply-To: <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Thread-Index: Ady8N499HzqgIpJsTSS3TrQWRu+JaAAAJABA
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
 <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <dev@dpdk.org>,
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
> Sent: Wednesday, 25 March 2026 10.13
>=20
> On Wed, Mar 25, 2026 at 08:41:39AM +0100, Morten Br=F8rup wrote:
> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Tuesday, 24 March 2026 18.12
> > >
> > > On Mon, 16 Mar 2026 16:55:29 +0100
> > > Morten Br=F8rup <mb@smartsharesystems.com> wrote:
> > >
> > > > >
> > > > > This is an example of something I previously flagged. Like =
with
> > > real
> > > > > hardware, I think the PMD should be inserting the VLAN tag =
into
> the
> > > > > packet
> > > > > as part of the Tx function, not the prepare function.
> > > >
> > > > Agree with Bruce on this.
> > > > For simple stuff like VLAN offload, applications should not be
> > > required to call tx_prep first.
> > > >
> > > > However, the Tx function is supposed to not modify the packets;
> > > relevant when refcnt > 1.
> > > >
> > > > Instead of modifying the packet data to insert/strip the VLAN
> tag,
> > > > perhaps the driver can split the write/read operation into
> multiple
> > > write/read operations:
> > > > 1. the Ethernet header
> > > > 2. the VLAN tag
> > > > 3. the remaining packet data
> > > >
> > > > I haven't really followed the pcap driver, so maybe my =
suggestion
> > > doesn't make sense.
> > >
> > > The prepare code and VLAN was copied from virtio.
> > > I assume virtio is widely used already.
> >
> > OK, that makes it harder to object to.
> >
>=20
> Yes, but I also believe that the topic was not previously discussed =
and
> that the virtio driver may be wrong in how it behaves.
>=20
> I still think, for consistency with HW drivers, SW drivers should do
> the
> tagging in the Tx function.

+1

>=20
> I also think that we should provide a DPDK-lib level helper function
> (be it in
> ethdev or elsewhere) for doing this sort of thing for all drivers. =
That
> way
> we can put in the necessary copying of packets with refcnt > 1 and =
have
> it
> apply globally.

If an application clones packets instead of copying them, it is probably =
for performance reasons.
If the drivers start copying those clones, it may defeat the performance =
purpose.

<brainstorming>
Maybe segmentation can be used instead of copying the full packet:
Make the "copy" packet of two (or more) segments, where the header is =
copied into a new mbuf (where the VLAN tag is added), and the remaining =
part of the packet uses an indirect mbuf referring to the "original" =
packet at the offset after the header.
</brainstorming>

Furthermore...
If drivers start copying packets in the Tx function, the Tx queue should =
have its own mbuf pool to allocate these mbufs from.
Drivers should not steal mbufs from the pools used by the packets being =
transmitted.
E.g. if a segmented packet has a small mbuf for the first few bytes, =
followed by a large mbuf (from another pool) for the remaining bytes.
Or if the "original" mbuf comes from a mempool allocated on different =
CPU socket, the "copy" would too.

>=20
> /Bruce
