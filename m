Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619D1D715D6
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 08:23:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9521B40293;
	Sat, 24 Jan 2026 09:23:51 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 883AC4026F
 for <dev@dpdk.org>; Sat, 24 Jan 2026 09:23:50 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A792F2071A;
 Sat, 24 Jan 2026 09:23:49 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v16 0/2] net: optimize __rte_raw_cksum
Date: Sat, 24 Jan 2026 09:23:47 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656B2@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260123160244.57335-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v16 0/2] net: optimize __rte_raw_cksum
Thread-Index: AdyMgcLdzdITt2cVQwmDJ1UHtrZ5wAAh2R+A
References: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
 <20260123160244.57335-1-scott.k.mitch1@gmail.com>
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
> This series optimizes __rte_raw_cksum by replacing memcpy with direct
> pointer access, enabling compiler vectorization on both GCC and Clang.
>=20
> Patch 1 adds __rte_may_alias to unaligned typedefs to prevent a GCC
> strict-aliasing bug where struct initialization is incorrectly elided.
>=20
> Patch 2 uses the improved unaligned_uint16_t type in __rte_raw_cksum
> to enable compiler optimizations while maintaining correctness across
> all architectures (including strict-alignment platforms).
>=20
> Performance results show significant improvements (40% for small
> buffers,
> up to 8x for larger buffers) on Intel Xeon with Clang 18.1.

It's usually allowed to carry forward ACKs from previous versions.
With major changes between versions, the author should consider if =
previous ACKs can remain or not.

Carrying forward from v15 of the series,
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

