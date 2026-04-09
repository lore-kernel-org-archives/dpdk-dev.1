Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D29EA3C59
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 13:04:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A6B24028F;
	Thu,  9 Apr 2026 15:04:55 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 28C6240276
 for <dev@dpdk.org>; Thu,  9 Apr 2026 15:04:53 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fs0WR4ZZZzJ46C9;
 Thu,  9 Apr 2026 21:04:19 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id E75BB40570;
 Thu,  9 Apr 2026 21:04:52 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Apr 2026 14:04:52 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Thu, 9 Apr 2026 14:04:52 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: DPDK ip_frag security analyis
Thread-Topic: DPDK ip_frag security analyis
Thread-Index: AQHcxu6OwPWYwelGwEyDNrAcMAAZcLXWoTxg
Date: Thu, 9 Apr 2026 13:04:52 +0000
Message-ID: <282c899d27cb40b292d199c7490f3ede@huawei.com>
References: <20260407172750.34e1aaf0@phoenix.local>
In-Reply-To: <20260407172750.34e1aaf0@phoenix.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.152]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> Subject: Security analysis of lib/ip_frag (fragmentation & reassembly)
>=20
> Hi,
>=20
> Below is a security-focused review of the DPDK ip_frag library
> covering ip_frag_common.h, ip_frag_internal.c, ip_reassembly.h,
> rte_ip_frag.h, rte_ip_frag_common.c, rte_ipv4_fragmentation.c,
> rte_ipv4_reassembly.c, rte_ipv6_fragmentation.c, and
> rte_ipv6_reassembly.c.
>=20
> Findings are grouped by severity.
>=20
>=20
> ERRORS
> =3D=3D=3D=3D=3D=3D
>=20
> 1. TAILQ_FOREACH modification during iteration in
>    rte_ip_frag_table_del_expired_entries()
>=20
>    File: rte_ip_frag_common.c, lines 142-151
>=20
>    TAILQ_FOREACH(fp, &tbl->lru, lru) iterates the LRU list while
>    ip_frag_tbl_del() calls TAILQ_REMOVE() on the current element
>    inside the loop body. TAILQ_FOREACH reads fp->lru.tqe_next in
>    the loop-advance step *after* the body executes. After
>    TAILQ_REMOVE, the removed element's tqe_next is stale.
>=20
>    On glibc/BSD this happens to work because TAILQ_REMOVE does not
>    zero tqe_next, but this violates the TAILQ API contract. If the
>    implementation ever changes, or if a debug TAILQ that poisons
>    removed entries is used, this becomes a use-after-remove bug.
>=20
>    Fix: use TAILQ_FOREACH_SAFE, or save TAILQ_NEXT(fp, lru) before
>    calling ip_frag_tbl_del().

ACK, that looks like a valid one to me.

>=20
> 2. No overlapping fragment detection (teardrop-class attacks,
>    RFC 5722 violation for IPv6)
>=20
>    File: ip_frag_internal.c, ip_frag_process()
>=20
>    ip_frag_process() does not check whether a newly arrived fragment
>    overlaps with any previously stored fragment. It only detects
>    duplicate first/last fragments. For middle fragments, it blindly
>    increments last_idx and stores the fragment.
>=20
>    The reassembly functions happen to fail on overlapping fragments
>    because the offset-matching chain walk cannot find a match, so
>    the hole-detection fires. The mitigation is accidental rather
>    than intentional.

Nope, it is not accidental, it was intentional design choice.
Checking for each incoming fragment that there is no overlaps might be
quite expensive. So, we postpone that check till we have all fragments
arrive and start re-assemble process.
It is sort of trade-off speed vs keeping mbuf with overlapping fragment
for a bit longer. =20
Looks like a false positive to me.

>    For IPv6, RFC 5722 mandates that overlapping fragments MUST
>    cause the entire datagram to be silently dropped. The current
>    code does eventually drop them, but only after accumulating
>    fragments and burning table slots until timeout. An attacker can
>    exhaust fragment table entries by sending overlapping fragments.
>=20
>    Fix: check new fragment offset/length against existing entries
>    in frags[] before storing. For IPv6, drop immediately per
>    RFC 5722.
>=20
>=20
> 3. Death row buffer overflow -- IP_FRAG_MBUF2DR has no bounds check
>=20
>    File: ip_frag_common.h, line 38
>=20
>    The IP_FRAG_MBUF2DR(dr, mb) macro writes to dr->row[dr->cnt++]
>    with no bounds check. Similarly, ip_frag_free() adds up to
>    IP_MAX_FRAG_NUM (8) entries without checking capacity.
>=20
>    The death row is sized for RTE_IP_FRAG_DEATH_ROW_LEN *
>    (MAX_FRAG + 1) =3D 288 entries. The del_expired_entries() function
>    does check capacity, but the hot-path reassembly functions call
>    ip_frag_find() -> ip_frag_tbl_del() and ip_frag_process() ->
>    ip_frag_free() + IP_FRAG_MBUF2DR() without any capacity check.
>=20
>    If an application calls reassembly in a tight loop without
>    draining the death row between calls, dr->cnt can exceed
>    RTE_IP_FRAG_DEATH_ROW_MBUF_LEN, causing an out-of-bounds write.
>    The death row is typically stack-allocated, so this is a potential
>    stack buffer overflow.
>=20
>    ip_frag_find() can evict a stale entry AND an LRU entry in a
>    single call (up to 16 mbufs), then ip_frag_process() can add 9
>    more on error.A burst of 32 bad fragments hitting different
>    stale entries could overflow.

That seems not entirely correct, as we just remove stale entry from
the table and the LRU list, so max  IP_MAX_FRAG_NUM (8) can be deleted
in one go.
But overall, yes it is a potential problem, as we assume that user will
always operate in bursts of 32 packes, and call free_death_row()
after each such burst is processed.
Which might not be the always the case.
Needs to be addressed.

>    Fix: add a bounds check in IP_FRAG_MBUF2DR and ip_frag_free(),
>    or document the maximum number of reassembly calls permitted
>    between death row drains.
>=20
>=20
> WARNINGS
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 4. IPv6 move_len underflow in ipv6_frag_reassemble()
>=20
>    File: rte_ipv6_reassembly.c, line 104
>=20
>    move_len =3D m->l2_len + m->l3_len - sizeof(*frag_hdr);
>=20
>    move_len is uint32_t. If a buggy caller sets l2_len + l3_len < 8,
>    move_len wraps to ~4 billion. The subsequent ip_frag_memmove()
>    would attempt to copy gigabytes of data, causing a segfault or
>    memory corruption.
>=20
>    The API documents that callers must set l2_len/l3_len correctly,
>    and for a valid IPv6 fragment l3_len alone should be >=3D 48 bytes.
>    But there is no defensive validation.
>=20
>    Fix: add a sanity check that l2_len + l3_len >=3D sizeof(*frag_hdr)
>    before computing move_len.

I don't think we need to do anything here.
It should be safe to assume that input mbuf fields are valid,
specially if it is already documented. =20

>=20
>=20
> 5. rte_ipv6_frag_get_ipv6_fragment_header() only inspects the
>    first extension header
>=20
>    File: rte_ip_frag.h, line 143
>=20
>    This function checks only hdr->proto =3D=3D IPPROTO_FRAGMENT. If any
>    other extension header (hop-by-hop, routing, destination options)
>    precedes the fragment header, this function returns NULL and the
>    packet is treated as non-fragmented.
>=20
>    An attacker can evade reassembly by inserting a preceding
>    extension header, causing fragments to be forwarded as-is. This
>    can bypass firewall rules that rely on seeing reassembled traffic.
>=20
>    The limitation is documented but is a security-relevant design
>    gap for applications using this library.

Yep, it is a well-known and long-standing  limitation that needs to be addr=
essed.
I think it was even attempt to fix it, but for whatever reason it wasn't ac=
cepted.=20

>    Fix: walk the extension header chain to find the fragment header,
>    or clearly document the security implications in the API header.
>=20
>=20
> INFORMATIONAL
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 6. Hash collision DoS via fixed seed
>=20
>    Both ipv4_frag_hash() and ipv6_frag_hash() use CRC32 (x86/ARM)
>    or jhash with a fixed, publicly known prime seed (0xeaad8405).
>    An attacker who can send crafted IP fragments can precompute hash
>    collisions, causing all fragments to land in the same bucket.
>    After bucket_entries concurrent flows collide, new flows are
>    dropped.
>=20
>    Fix: randomize the hash seed at table creation time.

ACK, seems valid - needs to be fixed.
=20
>=20
> 7. max_cycles + fp->start wraparound
>=20
>    The timeout comparison (max_cycles + fp->start < tms) at multiple
>    locations uses uint64_t arithmetic. If the sum wraps past 2^64,
>    entries appear timed out when they are not. With rdtsc-based
>    timestamps this requires running for hundreds of years, so it is
>    not practically exploitable. Worth noting for alternative time
>    sources with faster-incrementing values.

False positive.

>=20
> 8. No total reassembled size limit before table insertion
>=20
>    The library accepts and stores fragments up to IP_MAX_FRAG_NUM
>    per datagram, but there is no explicit limit on total reassembled
>    size. An attacker can claim total_size =3D 65535 via a crafted last
>    fragment, then send middle fragments that consume table entries
>    and death row capacity during the attack window, even though
>    reassembly will ultimately fail when frag_size exceeds
>    total_size.

We do have max number of frags perf packet.
Honestly I don't think there is a need for such extra check.=20

