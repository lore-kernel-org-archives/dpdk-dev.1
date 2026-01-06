Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82758C47BE2
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 10:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 807FB402DC;
	Tue,  6 Jan 2026 11:59:54 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 00720400EF
 for <dev@dpdk.org>; Tue,  6 Jan 2026 11:59:52 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 145AA20445;
 Tue,  6 Jan 2026 11:59:52 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net: optimize raw checksum computation
Date: Tue, 6 Jan 2026 11:59:49 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6562B@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260105232754.34404-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net: optimize raw checksum computation
Thread-Index: Adx+8a4/2NW+T91pQXWJd0RcRT3R0wAAokbg
References: <20260105232754.34404-1-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Scott Mitchell" <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
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
> Optimize __rte_raw_cksum() by processing data in larger unrolled loops
> instead of iterating word-by-word. The new implementation processes
> 64-byte blocks (32 x uint16_t) in the hot path, followed by smaller
> 32/16/8/4/2-byte chunks.

Good idea processing in 64-byte blocks!

I wonder if there would be further gain by 64-byte aligning the 64-byte =
chunks, so the compiler can use vector instructions for summing the 32 =
2-byte words of each 64-byte chunk.
This would require a 3-step algorithm:
1. Process the first 0..63 bytes preceding the first 64-byte aligned =
address. (These bytes are unaligned; nothing new here.)
2. Process 64-byte chunks, if any. These are now 64-byte aligned, and =
you should ensure that the compiler knows it.
3. Process the last 32/16/8/4/2/1-byte chunks. These are now aligned, =
which eliminates the need for unaligned_uint16_t in this step. =
Specifically, the 32-byte chunk will be 64-byte aligned, allowing the =
compiler to use vector instructions. The 16-byte chunk will be 32-byte =
aligned. Etc.

<random idea>
Step 1 may be performed in reverse order of step 3, i.e. process in =
chunks of 1/2/4/8/16/32 bytes (using the lowest bits of the address as =
condition) - which will cause the alignment to increase accordingly.
</random idea>

<feature creep>
Checking the alignment at runtime has a non-zero cost, so a an =
alternative (simpler) code path might be beneficial for small lengths =
(when the alignment is unknown at runtime).
</feature creep>

>=20
> Uses uint64_t accumulator to reduce carry propagation overhead

You return (uint32_t)sum64 at the end, so why replace the existing =
32-bit "sum" with a 64-bit "sum64" accumulator?

> and
> leverages unaligned_uint16_t for safe unaligned access on all
> platforms.
>=20
> Performance results from cksum_perf_autotest (TSC cycles/byte):
>   Block size    Before    After    Improvement
>          100  0.40-0.64  0.13-0.14    ~3-4x
>         1500  0.49-0.51  0.10-0.11    ~4-5x
>         9000  0.48-0.51  0.11-0.12    ~4x
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

