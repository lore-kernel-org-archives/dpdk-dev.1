Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D5CC44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 12:51:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9726A40290;
	Mon, 20 Jul 2026 14:51:12 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0DBFB4028E
 for <dev@dpdk.org>; Mon, 20 Jul 2026 14:51:11 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D608120534;
 Mon, 20 Jul 2026 14:51:10 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] doc: drop recommendation against bool in structures
Date: Mon, 20 Jul 2026 14:51:09 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65980@smartserver.smartshare.dk>
In-Reply-To: <al4Q3f3Lfbv8i8V-@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] doc: drop recommendation against bool in structures
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: Ad0YQTGERcZOYIVKTX+VKty0cpAM/wAA9HSw
References: <20260720114602.787429-1-maxime@leroys.fr>
 <al4Q3f3Lfbv8i8V-@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Maxime Leroy" <maxime@leroys.fr>
Cc: <dev@dpdk.org>, "Stephen Hemminger" <stephen@networkplumber.org>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "David Marchand" <david.marchand@redhat.com>
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
> Sent: Monday, 20 July 2026 14.13
>=20
> On Mon, Jul 20, 2026 at 01:46:02PM +0200, Maxime Leroy wrote:
> > The coding style advised against bool in structures, citing space =
and
> > type-size concerns inherited from the Linux kernel. That does not
> match
> > DPDK practice: bool is already used in over 1400 structure fields
> across
> > the tree, including core APIs such as rte_flow. Drop the note so the
> > style guide reflects actual usage.

The note is still valid, although massively violated.
Could we paraphrase the note as an advice/recommendation, instead of =
completely removing it?
The intention is to make developers consider alternatives when adding a =
Boolean field to a structure.
Maybe it could be expanded with a few example alternatives:
uint8_t value, or
uintN_t value:1 (bitfield).

> >
> > Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> > ---
>=20
> Definite +1
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> >  doc/guides/contributing/coding_style.rst | 9 ---------
> >  1 file changed, 9 deletions(-)
> >
> > diff --git a/doc/guides/contributing/coding_style.rst
> b/doc/guides/contributing/coding_style.rst
> > index 976a1e1de3..11de3bb39a 100644
> > --- a/doc/guides/contributing/coding_style.rst
> > +++ b/doc/guides/contributing/coding_style.rst
> > @@ -313,15 +313,6 @@ Structure Declarations
> >  * Use of the structures should be by separate variable declarations
> and those declarations must be extern if they are declared in a header
> file.
> >  * Externally visible structure definitions should have the =
structure
> name prefixed by ``rte_`` to avoid namespace collisions.
> >
> > -.. note::
> > -
> > -    Avoid using ``bool`` in structures because it wastes space and
> > -    the type size is unclear. A preferred use of
> > -    ``bool`` is mainly as a return type from functions that return
> true/false,
> > -    and maybe local variable functions.
> > -
> > -    Ref: `LKML <https://lkml.org/lkml/2017/11/21/384>`_
> > -
> >  Queues
> >  ~~~~~~
> >
> > --
> > 2.43.0
> >
