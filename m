Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16F1CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 15:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9D3340276;
	Mon, 25 May 2026 17:47:37 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8B60840144
 for <dev@dpdk.org>; Mon, 25 May 2026 17:47:36 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6A30E20A2F;
 Mon, 25 May 2026 17:47:36 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v3 03/27] ring: use compare-and-swap wrapper
Date: Mon, 25 May 2026 17:47:34 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65897@smartserver.smartshare.dk>
In-Reply-To: <20260525083509.00cf76a1@phoenix.local>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v3 03/27] ring: use compare-and-swap wrapper
Thread-Index: AdzsXBi5qrtIgbaDRSKZ4irxZpH7pQAAWPhg
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
 <20260523195604.441947-4-stephen@networkplumber.org>
 <b827bdd2f5994f24b9806e5cbae82cd3@huawei.com>
 <20260525083509.00cf76a1@phoenix.local>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
 "Konstantin Ananyev" <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>
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
> Sent: Monday, 25 May 2026 17.35
>=20
> On Mon, 25 May 2026 07:41:13 +0000
> Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:
>=20
> > Hi Stephen,
> >
> > > The rte_atomic32_cmpset is deprecated. Initial attempts at
> > > changing this with direct conversion to
> > > rte_atomic_compare_exchange_weak_explicit()
> > > regressed MP/MC contended performance on x86 by 10-30%,
> > > because the C11 builtin's failure-writeback semantic forces
> > > GCC to emit extra instructions on the CAS critical path.
> > >
> > > Add an internal __rte_ring_compare_and_swap() wrapper that calls
> > > __sync_bool_compare_and_swap() directly, which keeps the original
> > > instruction sequence. Add equivalent function for MSVC.
> >
> > In fact, in rte_ring we do have 2 implementations of the same core
> functions:
> > lib/ring/rte_ring_c11_pvt.h  - uses C11 atomics
> > lib/ring/rte_ring_generic_pvt.h - uses legacy instructions (smp_mb,
> extra),
> > If we going remove these legacy instructions anyway (or
> reimplementing them using C11 atomics),
> > then there is probably no point to keep rte_ring_generic_pvt.h.
> > Konstantin
>=20
> Have been deep diving into why C11 atomics give 20-30% performance
> drop versus atomic32 version. So far it comes down to GCC optimizer
> not doing as well with C11 versus assembly. The C11 form with the
> excessive use of always_inline consumes more registers.

Just an idea:
Perhaps adding "const" and/or "restrict" to relevant parameters will =
give the optimizer the information it needs?

