Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F25EC4452B
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 17:24:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FF73402A7;
	Tue, 21 Jul 2026 19:24:29 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BA46540294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 19:24:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 71FA52109C;
 Tue, 21 Jul 2026 19:24:27 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH 0/6] doc/rel_notes: updates to 26.07 doc
Date: Tue, 21 Jul 2026 19:24:25 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65992@smartserver.smartshare.dk>
In-Reply-To: <20260721151325.2698283-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/6] doc/rel_notes: updates to 26.07 doc
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: Ad0ZI38tPbtrcLiETgmlAmAHHyfargAEjX+Q
References: <20260721151325.2698283-1-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: <thomas@monjalon.net>
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

> A collection of miscellaneous updates and fixes for the 26.07 release
> notes.
>=20
> Bruce Richardson (6):
>   doc/rel_notes: remove bullets for single items
>   doc/rel_notes: move mempool change to first item
>   doc/rel_notes: keep library updates together
>   doc/rel_notes: fix driver ordering
>   doc/rel_notes: fix style of API changes section
>   doc/rel_notes: minor style fixes
>=20
>  doc/guides/rel_notes/release_26_07.rst | 143 =
++++++++++++-------------
>  1 file changed, 69 insertions(+), 74 deletions(-)

Series-acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

