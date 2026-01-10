Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778BCD277EB
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 14:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 863FE4028E;
	Sat, 10 Jan 2026 15:47:09 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DE26940144
 for <dev@dpdk.org>; Sat, 10 Jan 2026 15:47:07 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 292F920679;
 Sat, 10 Jan 2026 15:47:06 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v12 1/3] net: optimize __rte_raw_cksum and add tests
Date: Sat, 10 Jan 2026 15:47:04 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65646@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260110015651.26201-2-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v12 1/3] net: optimize __rte_raw_cksum and add tests
Thread-Index: AdyB1HHqqI6/HPruSK2a3WRrm26oWgAanbvg
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
 <20260110015651.26201-2-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>,
	"Scott" <scott_mitchell@apple.com>
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

> From: Scott <scott_mitchell@apple.com>
>=20
> __rte_raw_cksum uses a loop with memcpy on each iteration.
> GCC 15+ is able to vectorize the loop but Clang 18.1 is not.
> Replacing the memcpy with unaligned_uint16_t pointer access enables
> both GCC and Clang to vectorize with SSE/AVX/AVX-512.
>=20
> This patch adds comprehensive fuzz testing and updates the performance
> test to measure the optimization impact.
>=20
> Performance results from cksum_perf_autotest on Intel Xeon
> (Cascade Lake, AVX-512) built with Clang 18.1 (TSC cycles/byte):
>=20
>   Block size    Before    After    Improvement
>          100      0.40     0.24        ~40%
>         1500      0.50     0.06        ~8x
>         9000      0.49     0.06        ~8x
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---

Probably makes no practical difference, but consider marking the =
__rte_raw_cksum() function __rte_pure:
https://elixir.bootlin.com/dpdk/v25.11/source/lib/eal/include/rte_common.=
h#L228

With or without __rte_pure marking,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

