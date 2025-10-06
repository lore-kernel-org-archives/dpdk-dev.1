Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB8CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 14:40:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A6F3402B1;
	Mon,  6 Oct 2025 16:40:32 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 60836402B1;
 Mon,  6 Oct 2025 16:40:30 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 25F88202CC;
 Mon,  6 Oct 2025 16:40:29 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: Minutes of techboard meeting, 2025-10-01
Date: Mon, 6 Oct 2025 16:40:27 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6549F@smartserver.smartshare.dk>
In-Reply-To: <aN-Use5rigF3tQc9@bricha3-mobl1.ger.corp.intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Minutes of techboard meeting, 2025-10-01
Thread-Index: Adw0Rp0aNcBqsJnpSuinX2U7NfkFnAChp3KQ
References: <aN-Use5rigF3tQc9@bricha3-mobl1.ger.corp.intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <dev@dpdk.org>, <techboard@dpdk.org>, <stephen@networkplumber.org>,
 "Thomas Monjalon" <thomas@monjalon.net>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Cc: "Patrick Robb" <probb@iol.unh.edu>
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
> Sent: Friday, 3 October 2025 11.18
> Subject: Minutes of techboard meeting, 2025-10-01

> * Use of FAST_FREE and multi-buffer/scattered mbuf flags
>   - The flags for enabling fast-free and supporting multi-mbuf packets
> are
>     now documented incompatible
>   - Previously they were not defined as incompatible, but that seems =
to
>     have been assumed for some usages.
>   - Techboard discussed how best to resolve this incompatibility with
>     regards to:
>     - ensuring correctness
>     - avoiding major churn to DPDK code
>     - avoiding churn to end-user code
>   - Options discussed:
>     1 change definition back to not have the settings incompatible:
> this
>       necessitates checking drivers for correctness
>     2 keep as explicitly incompatible and report error if both
> specified:
>       this could break end-user apps, and requires changes to example
> apps
>     3 drop the fast-free flag if multi-segment mbufs are also
> specified:
>       "hides" the issue, but probably minimises changes. Would need to
>       decide whether the dropping of flag done in drivers vs ethdev
> level.
>       Pros and cons to both options. Needs clear documenting.
>   - No firm decision reached, will discuss more over email.

IMO, the patch [1] making MBUF_FAST_FREE and MULTI_SEGS explicitly =
incompatible should be reverted, at least for RC1.
That will take the project back to the state it was in before we started =
this discussion.
And all the examples broken by the patch (because they use both TX =
offloads) will not need fixing.

[1]: =
https://patchwork.dpdk.org/project/dpdk/patch/20250803194218.683318-3-mb@=
smartsharesystems.com/

