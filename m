Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343FEEC01A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 09:01:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 733B240268;
	Mon, 23 Mar 2026 10:01:49 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EA3F24025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 10:01:47 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BF3BC2045F;
 Mon, 23 Mar 2026 10:01:47 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 0/4] VRF support in FIB library
Date: Mon, 23 Mar 2026 10:01:46 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657B2@smartserver.smartshare.dk>
In-Reply-To: <20260322094346.52a87b29@phoenix.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Topic: [RFC PATCH 0/4] VRF support in FIB library
Thread-Index: Ady6GxCSEy/jjQbeSTq1e+cAikQnRQAh2dzg
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20260322094346.52a87b29@phoenix.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
Cc: <dev@dpdk.org>, <rjarry@redhat.com>, <nsaxena16@gmail.com>,
 <adwivedi@marvell.com>, <jerinjacobk@gmail.com>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Sunday, 22 March 2026 17.44
>=20
> On Sun, 22 Mar 2026 15:42:11 +0000
> Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:
>=20
> > This series adds multi-VRF support to both IPv4 and IPv6 FIB paths =
by
> > allowing a single FIB instance to host multiple isolated routing
> domains.
> >
> > Currently FIB instance represents one routing instance. For =
workloads
> that
> > need multiple VRFs, the only option is to create multiple FIB
> objects. In a
> > burst oriented datapath, packets in the same batch can belong to
> different VRFs, so
> > the application either does per-packet lookup in different FIB
> instances or
> > regroups packets by VRF before lookup. Both approaches are =
expensive.
> >
> > To remove that cost, this series keeps all VRFs inside one FIB
> instance and
> > extends lookup input with per-packet VRF IDs.
> >
> > The design follows the existing fast-path structure for both
> families. IPv4 and
> > IPv6 use multi-ary trees with a 2^24 associativity on a first level
> (tbl24). The
> > first-level table scales per configured VRF. This increases memory
> usage, but
> > keeps performance and lookup complexity on par with non-VRF
> implementation.
> >

I noticed the suggested API uses separate parameters for the VRF and IP.
How about using one parameter, a structure containing the {VRF, IP} =
tuple, instead?
I'm mainly thinking about the bulk operations, where passing one array =
seems more intuitive than passing two arrays.

>=20
>=20
> Not sure at all if this the right way to do VRF.
> There are multiple ways to do VRF, the Linux way, the Cisco way, ...

I think a shared table operating on the {VRF, IP} tuple makes sense.
If a table instance per VRF is preferred, that is still supported.

Can you elaborate what Linux and Cisco does differently than this?

>=20
>=20
>=20
> This needs way more documentation and also an example.

+1

> Like an option to l3fwd. And also an implementation in testpmd.
