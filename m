Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BD7C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 17:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6632D4013F;
	Thu, 17 Jul 2025 19:45:59 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2598E400EF;
 Thu, 17 Jul 2025 19:45:57 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BB47620653;
 Thu, 17 Jul 2025 19:45:56 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 17 Jul 2025 19:45:55 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDB8@smartserver.smartshare.dk>
In-Reply-To: <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] doc: clarify VLAN and QinQ stripping behaviour
Thread-Index: Adv2inD1w4FEbAbPR2CZWrEhTRJ/5gAsg5ig
References: <20250714133014.44597-1-bruce.richardson@intel.com>
 <CABD7UXPVg56UwvmtOsssBwV2HzmgV4ZJZCb=FrnVQKkggtD2+Q@mail.gmail.com>
 <aHd6x3kT053EvX2g@bricha3-mobl1.ger.corp.intel.com>
 <CABD7UXPtChUUOdz3gfiyKqY4Rn2_0F8Ck4O6ypq9woATD7hfCw@mail.gmail.com>
 <aHgBs5DGU48mTnwz@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Dean Marx" <dmarx@iol.unh.edu>
Cc: <dev@dpdk.org>, "Dengdui Huang" <huangdengdui@huawei.com>,
 "Vladimir Medvedkin" <medvedkinv@gmail.com>, <techboard@dpdk.org>,
 "Patrick Robb" <probb@iol.unh.edu>,
 "fengchengwen" <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <jasvinder.singh@intel.com>, <thomas@monjalon.net>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>
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
> Sent: Wednesday, 16 July 2025 21.47
>=20
> On Wed, Jul 16, 2025 at 03:24:55PM -0400, Dean Marx wrote:
> > I've created a list of test cases which I'm planning on implementing
> > in future QinQ testing. After talking with Bruce about some Intel =
test
> > results earlier, I've got a solid idea of what the expected =
behaviors
> > are in five of these, but I'm unsure about the other three. If =
anyone
> > is able to provide some insight as to what they believe these =
expected
> > behaviors should be, please let me know as it would be immensely
> > helpful. Thanks!
> >
> > Vlan Strip ON and QinQ Strip OFF:
> > 1. Single VLAN:
> >     Expected result: VLAN Stripped
> > 2. Double VLAN:
> >     Expected result: Should strip outer VLAN
> > 3. Single 0x88a8 tag only:
> >     Expected result: 0x88a8 tag stripped
> > 4. Single VLAN + 1 0x88a8 tag:
> >     Expected result: 0x88a8 tag stripped, inner VLAN untouched
>=20
> Technically, the result goes for the test case of "0x88a8 tag +
> Single VLAN", since the 88a8 tag is first. :-)

Agree.

> The "Single VLAN + 0x88a8 Tag" would be a 5th test case if you
> want to try it. Expected result should be again that outer tag is
> stripped.

NB: The 5th case would be an extremely weird packet, either due to a bug =
swapping the two tags, or it could be a packet in a VLAN tunnel carrying =
a QinQ packet with no S-TAG. In the latter case, triple-tagged packets =
(VLAN + S-TAG (0x88a8) + C-TAG (VLAN)) could occur on such a VLAN tunnel =
too.

Assuming we treat EtherType 0x8100 and 0x88a8 as being the same on RX, =
then yes to the above.

However, if we treat them differently, the results would be:

QinQ Strip OFF, Vlan Strip ON:
1. Single VLAN:
    Expected result: VLAN Stripped
2. Double VLAN:
    Expected result: Should strip outer VLAN
3. Single 0x88a8 tag only (S-TAG, no C-TAG):
    Expected result: Nothing stripped
4 (corrected). Outer 0x88a8 tag + inner VLAN (S-TAG + C-TAG):
    Expected result: 0x88a8 tag untouched! inner VLAN untouched or =
stripped?
5. Outer VLAN + inner 0x88a8 tag (weird packet):
    Expected result: Outer VLAN stripped, inner 0x88a8 tag untouched

>=20
> As for the expected results you quote, those may or may not be =
expected
> depending on whether hardware supports multiple VLAN tag eth-types or
> configurable VLAN tag eth-types. From my testing, in at least some of
> our
> NICs by default, they ONLY strip VLAN tags if they have a 0x8100 tag.
> However, I would be surprised if that is not configurable.
>=20
> >
> > Vlan Strip ON and QinQ Strip ON:
> > 1. Single VLAN:
> >     Expected result: VLAN stripped
> > 2. Double VLAN:
> >     Expected result: Unknown (Outer VLAN stripped?)
> > 3. Single 0x88a8 tag only:
> >     Expected result: Unknown (0x88a8 tag stripped?)
> > 4. Single VLAN + 1 0x88a8 tag:
> >     Expected result: Unknown (0x88a8 tag stripped and VLAN tag
> stripped?)
>=20
> Again, the expected result would likely depend on what are configured
> ethtypes for recognised VLANs.

If we are considering application breakage as a decision parameter for =
this doc update, it would be better to log the results of the various =
test cases with the various NICs, to compare their behaviors, rather =
than pass/fail some "expected result".

>=20
> /Bruce

I think we need to discuss VLAN/QinQ stripping in a broader context.

QinQ and VLAN stripping/insertion is very simple to implement in =
software, so the value of this feature itself (in an isolated context) =
is relatively low.

Hardware based QinQ and VLAN stripping/insertion has higher value when =
combined with other hardware offloads, such as GRO/TSO and IP =
defragmentation/fragmentation.

E.g. for GRO, the NIC might only be able to merge a bunch of received =
QinQ tagged TCP packets into one larger TCP packet if the NIC hardware =
has the ability to parse (and possibly strip) the QinQ tags.

Similarly, for TSO, the NIC must add the correct tag(s) to all the =
smaller TCP packets it transmits when splitting a large TCP packet. (And =
"correct" includes the EtherType of those tags. Inserting a VLAN tag =
instead of an S-TAG (0x88a8) and no C-TAG (VLAN) is not correct.)

The same goes for IP fragmentation/defragmentation. I don't know how =
well the IP fragmentation library supports VLAN/QinQ tagged packets.

