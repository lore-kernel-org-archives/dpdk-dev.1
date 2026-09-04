Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452F0C624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 11:28:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58E9E42F3F;
	Fri,  4 Sep 2026 13:28:49 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6BEA342F35
 for <dev@dpdk.org>; Fri,  4 Sep 2026 13:28:47 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2798D20910;
 Fri,  4 Sep 2026 13:28:47 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] eal/x86: fix memcpy alignment mask definition
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Fri, 4 Sep 2026 13:28:45 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65A30@smartserver.smartshare.dk>
In-Reply-To: <apqqoMEC2AUBTYoL@bricha3-mobl1.ger.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] eal/x86: fix memcpy alignment mask definition
Thread-Index: Ad08YBxGxquhe5cuTBqTxhaOK3tCkQAAEz7A
References: <20260904092028.856816-1-mb@smartsharesystems.com>
 <20260904111912.857547-1-mb@smartsharesystems.com>
 <apqqoMEC2AUBTYoL@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, "Konstantin Ananyev" <konstantin.ananyev@huawei.com>,
 "Vipin Varghese" <vipin.varghese@amd.com>,
 "Stephen Hemminger" <stephen@networkplumber.org>
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
> Sent: Friday, 4 September 2026 13.25
>=20
> On Fri, Sep 04, 2026 at 11:19:12AM +0000, Morten Br=F8rup wrote:
> > An alignment mask (ALIGNMENT_MASK) is temporarily defined for
> internal
> > purposes, but it is publicly exposed when including the header file,
> > potentially colliding with existing definitions with the same name.
> > Fixed this potential issue by adding the RTE_MEMCPY_ prefix to the
> > definition.
> >
> > Furthermore, the superfluous function declaration at the top of the
> file
> > was removed, and its description was moved to the function
> definition,
> > to improve search results with source code browsers.
> >
> > Also, changed "!(addrs & MASK)" to "(addrs & MASK) =3D=3D 0" to =
follow
> DPDK
> > coding style.
> >
> > None of these changes should have any practical effect.
> >
> > Fixes: f5472703c0bd ("eal: optimize aligned memcpy on x86")
> >
> > Signed-off-by: Morten Br=F8rup <mb@smartsharesystems.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> > v2:
> > * Changed "!(addrs & MASK)" to "(addrs & MASK) =3D=3D 0". (AI)
>=20
> Did you miss this change in v2? I still see the "!" below.

Thank you, yes.
It's in my editor, but not on disk. :-\

Will send v3 shortly.

