Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E7C83F25
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 10:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E04E40283;
	Tue, 22 Jul 2025 12:29:36 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 00E6E40265;
 Tue, 22 Jul 2025 12:29:34 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BBB3C20446;
 Tue, 22 Jul 2025 12:29:34 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] bitops: improve power of 2 alignment function
 documentation
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 22 Jul 2025 12:29:31 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FDBF@smartserver.smartshare.dk>
In-Reply-To: <aH9Ob8sReOBJw-yv@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bitops: improve power of 2 alignment function
 documentation
Thread-Index: Adv65GWE9M2tHHz3SuGulXVXwGSXOAADxCuw
References: <20250722075321.121254-1-mattias.ronnblom@ericsson.com>
 <aH9Ob8sReOBJw-yv@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
 =?iso-8859-1?Q?Mattias_R=F6nnblom?= <mattias.ronnblom@ericsson.com>
Cc: <dev@dpdk.org>, "Jack Bond-Preston" <jack.bond-preston@foss.arm.com>,
 =?iso-8859-1?Q?Mattias_R=F6nnblom?= <hofors@lysator.liu.se>,
 <stable@dpdk.org>
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
> Sent: Tuesday, 22 July 2025 10.40
>=20
> On Tue, Jul 22, 2025 at 09:53:21AM +0200, Mattias R=F6nnblom wrote:
> > In the documentation, make clear
> > rte_align(32|64)prevpow2(<n>) -> <n>, provided <n> is a power of 2.
> >
> > The original documentation stated the "previous" power of 2 would be
> > returned, potentially leaving the user to erroneously conclude that,
> > for example, rte_align32prevpow2(32) -> 16.
> >
> > The rte_align(32|64)pow2(<n>) documentation, suffering from a =
similar
> > issue, is reworded in the same manner.
> >
> > Fixes: 08f683174e94 ("eal: add functions for previous power of 2
> alignment")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Mattias R=F6nnblom <mattias.ronnblom@ericsson.com>
> > ---
> >  lib/eal/include/rte_bitops.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/eal/include/rte_bitops.h
> b/lib/eal/include/rte_bitops.h
> > index b9a6af381b..2d1b9d281c 100644
> > --- a/lib/eal/include/rte_bitops.h
> > +++ b/lib/eal/include/rte_bitops.h
> > @@ -1320,7 +1320,7 @@ rte_is_power_of_2(uint32_t n)
> >   *   The integer value to align
> >   *
> >   * @return
> > - *   Input parameter aligned to the next power of 2
> > + *   The smallest power of 2 which is greater than or equal to @c =
x.
> >   */
>=20
> Much clearer, thanks.
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

