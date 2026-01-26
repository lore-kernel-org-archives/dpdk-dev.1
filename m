Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E666AD13C1E
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 14:35:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B32E2402B6;
	Mon, 26 Jan 2026 15:35:41 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 02AEA400D7
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:35:39 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 182E82061A;
 Mon, 26 Jan 2026 15:35:39 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v14] eal: RTE_PTR_ADD/SUB API improvements
Date: Mon, 26 Jan 2026 15:35:36 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656B9@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260126080328.11567-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v14] eal: RTE_PTR_ADD/SUB API improvements
Thread-Index: AdyOmkaEJApHFbMCQWGX0wYHseaDcQAMqmtw
References: <20260125223015.69190-1-scott.k.mitch1@gmail.com>
 <20260126080328.11567-1-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>,
	<bruce.richardson@intel.com>
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

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> RTE_PTR_ADD and RTE_PTR_SUB APIs have a few limitations:
> 1. ptr cast to uintptr_t drops pointer provenance and
> prevents compiler optimizations
> 2. return cast discards qualifiers (const, volatile)
> which may hide correctness/concurrency issues.
> 3. Accepts both "pointers" and "integers as pointers" which
> overloads the use case and constrains the implementation
> to address other challenges.
>=20
> This patch splits the API on two dimensions:
> 1. pointer types
> 2. integer types that represent pointers
>=20
> This split allows addressing each of the challenges above
> and provides distinct APIs for the distinct use cases.

First of all, I think it's a huge improvement of the RTE_PTR_ADD/SUB =
macros to not discard qualifiers anymore.
Silently discarding qualifiers will cause bugs (discarding volatile) and =
potentially degrade performance (discarding const).

And I agree with your approach of generally fixing instances where this =
qualifier-discarding property is abused across existing code.
Qualifiers should only be explicitly discarded.

Unfortunately, fixing the macros changes their behavior, which may be =
considered API breakage.
Personally, I consider the qualifier-discarding property of the current =
macros a bug, which makes your patch a bug fix.
I would like the opinion of other community members on this!
It seems a patch can be both a bug fix and an API break. ;-)

Second, I think RTE_INT_PTR_ADD/SUB macros are superfluous.
Just use standard + and - operations when operating on integers, =
including "integers as pointers".

I guess existing instances of RTE_PTR_ADD/SUB operating on "integers as =
pointers" can be fixed across existing code to either use standard +/- =
operators or - probably more correct - use actual pointer types instead =
of integer types.

<feature creep>
If we decide to proceed with the RTE_PTR_ADD/SUB macros not discarding =
qualifiers, similar RTE_PTR_ macros should be updated similarly.
But let's cross that bridge if we go there.
</feature creep>

-Morten

