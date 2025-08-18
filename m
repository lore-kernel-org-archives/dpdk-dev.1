Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7F0CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 08:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EBDE40267;
	Mon, 18 Aug 2025 10:14:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 2D5DB4013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 10:14:55 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F18B4206AF;
 Mon, 18 Aug 2025 10:14:54 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2 2/6] ipsec: replace unnecessary comma operator
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Mon, 18 Aug 2025 10:14:51 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE43@smartserver.smartshare.dk>
In-Reply-To: <aKLdtBllWu1DkeF6@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 2/6] ipsec: replace unnecessary comma operator
Thread-Index: AdwQFkigHo2C+scMSnm3fV0JrYVJEwAAadLQ
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
 <20250814212901.88863-3-stephen@networkplumber.org>
 <aKLdtBllWu1DkeF6@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>
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
> Sent: Monday, 18 August 2025 10.01
>=20
> On Thu, Aug 14, 2025 at 02:28:48PM -0700, Stephen Hemminger wrote:
> > Use of comma as statement separator is discouraged and
> > reported as warning by clang with -Wcomma
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---

> > -	j =3D 0, n =3D 0;
> > +	j =3D 0;
> > +	n =3D 0;
> >  	vofs =3D 0;
> >  	for (i =3D 0; i !=3D num; i++) {
> >
>=20
> A better fix here is to move the assignments up to where the variables =
are
> defined just 9 lines earlier, rather than wasting code lines by =
assigning
> to zero later on!

+1

