Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35923CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 18:50:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9B62402EB;
	Mon,  1 Jun 2026 20:50:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 05A0A402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 20:50:16 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E5162208EE;
 Mon,  1 Jun 2026 20:50:15 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] doc, eal, devtools: discourage new __rte_always_inline
Date: Mon, 1 Jun 2026 20:50:13 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658CF@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260601172104.311909-1-stephen@networkplumber.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] doc, eal, devtools: discourage new __rte_always_inline
Thread-Index: Adzx6w1j6gjnTtK0SJi7a6s8TjpRmAADF39w
References: <20260527163734.599602-1-stephen@networkplumber.org>
 <20260601172104.311909-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Thomas Monjalon" <thomas@monjalon.net>
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
> Sent: Monday, 1 June 2026 19.21
>=20
> Modern compilers at -O2 make good inlining decisions for small
> static inline functions; forced inlining via __rte_always_inline
> should be reserved for cases where it is required for correctness
> or for documented measured performance reasons.
>=20
> Document the policy in the coding style guide and add a
> checkpatches.sh entry that flags when new uses of the attribute
> are introduced. Checkpatches is not an absolute blocker to
> acceptance, only an indicator that more review is needed.
>=20
> Add additional comments about use of __rte_always_inline,
> __rte_noinline, __rte_hot, and __rte_cold to the rte_common.h
> to aid developers.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Reviewed-by: Morten Br=F8rup <mb@smartsharesystems.com>

