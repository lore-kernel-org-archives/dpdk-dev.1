Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F68C5AD44
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:49:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDD8D402AA;
	Fri, 20 Feb 2026 18:49:34 +0100 (CET)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41]) by mails.dpdk.org (Postfix) with ESMTP id B68FF4026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:49:33 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7d1890f5cafso799309a34.1
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771609773;
 x=1772214573; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBrwT6rspKLMS1GMuG8l3M2Rhp7ySEGrU6+htfcU3KQ=;
 b=aAQhxpbvKoE+igRmlpS8szOQiPoNLQM0ZGxcq68enqDEBlBDRIilKiHapp96Hhlfmx
 qMnyhCHYOx3tiF1qbxhX+Hlou7tjE3oinXnbJhQ2lOeZsjFDS9gqf7wIo4G4pXOW/kJW
 hBWQsQ5QNZdA1vwCWGXh8rgQS44UjuGXTZPrUf/9WRZWA7R713ZRudocTbFCOCiE/E/r
 4uXwHT/LnST4AXqsuaDZenOQfZR5CguDiQWr7ZVZmL2MsJMjx3Z771rskF2rpjVo7Vzc
 hS4oZhhTyi1PWCLbqx9xnQPHI8xSdfiDAORDecC4DpiyPpVF2a8f+7pPpg6tBLrAPIwO
 w5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771609773; x=1772214573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tBrwT6rspKLMS1GMuG8l3M2Rhp7ySEGrU6+htfcU3KQ=;
 b=RkyGuc/5+icFr9DugjyLAWfQWfBeuriB1v4bCK8ZWuM30AxNwDxfwH0wUr93pFDUi2
 fN9haFHz8IiHIfrhXHVUeZH5gwr1XcSt6mgXKgYqT6Dey99yucJ0YOxf0GBEAyDC+TqC
 sSbCIZuhJXVpf+65LVR6nnVccydd7h1eypitM9h76v+xdef48TW92n94McISCSfDdvnm
 npXfkuna8I5rQchmQaRCcyHrOP6rOFQmFZXtimMuu4PaDZen8QLZzw2gl5WV4zu3txKU
 Kqw6KIE59RZ/oewi1WISdHbbIgfZVSkn8L1SMBY7mqWUevJRxOvAjMTGeqpNsUbZm4BE
 NkTA==
X-Gm-Message-State: AOJu0YxZYh1ymWDaUXsPvQU04ItpH5zj5dF46M9L6saHrxUuppYt1pcb
 b8nTiyNDBmDqvO4dgPeOFTo6z3hsmxEbClSErb20c3Iphkwxm9R+EI7iwESX66NvM9M=
X-Gm-Gg: AZuq6aL4h25zt0R8jcnPVU+oi1LGiyLGIaT119lXaaIgYLj84wgMbBXZQm+GmdZ7heV
 d35Iw4uEugq4Eh5J1Y3l76yQ+zExJ6prsrPp1gj6ni8FU1i/ZUIJHTxBYWwndWT9ZO9mDPPYm+S
 XDB1nBALHvf2vIcYA3Fn5RAhiEtEpDDDsu/lxPOtlYEfmMfYRaiuCGz37Vasw7aDPECgsuZobsY
 +nZ8kfD1cJntxB+O1A0FYPCA1EX4g+Z3PtgUrx9dqlRusB0XJnwXVMwtyIAcyggFyHO39C9W3ax
 Bf2R82B90cy79hg+lGr+Mle0xp3QGYQ4tzPw3nHyh/6g1dhBO3EnYPxgS3PCIPme26LHbD1UiG3
 T0tA0lAgu508xBtmGeG/ImZlDP/0T7sGXsM1ls5rzKiyzGoMJWk8ln2hqAY97BLFWps8RbKdJs3
 uov7aZhe112qbEqfUTFAiu+7jCNgnQN2oKOYZNVeAXxwKXHrUkWJA/b/JZnpUgt9qEdvNQ2U+lS
 HU=
X-Received: by 2002:a05:6830:6ade:b0:7d1:91c9:9e70 with SMTP id
 46e09a7af769-7d52be80fa8mr517944a34.6.1771609772564; 
 Fri, 20 Feb 2026 09:49:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0725c4sm111666a34.25.2026.02.20.09.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:49:32 -0800 (PST)
Date: Fri, 20 Feb 2026 09:49:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Su Sai <spiderdetective.ss@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
Message-ID: <20260220094929.37661daf@phoenix.local>
In-Reply-To: <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
References: <20250803090837.15589edd@hermes.local>
 <20250804035430.4058391-1-spiderdetective.ss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon,  4 Aug 2025 11:54:30 +0800
Su Sai <spiderdetective.ss@gmail.com> wrote:

> The rte_raw_cksum_mbuf function is used to compute
> the raw checksum of a packet.
> If the packet payload stored in multi mbuf, the function
> will goto the hard case. In hard case,
> the variable 'tmp' is a type of uint32_t,
> so rte_bswap16 will drop high 16 bit.
> Meanwhile, the variable 'sum' is a type of uint32_t,
> so 'sum +=3D tmp' will drop the carry when overflow.
> Both drop will make cksum incorrect.
> This commit fixes the above bug.
>=20
> Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>
> ---

AI review found some issues.

Summary of Findings
Severity	Issue
Error	Double-free of chained mbuf segments in test_l4_cksum_multi_mbufs() =
=E2=80=94 success path frees m[0] (the whole chain) then also frees m[1], m=
[2]
Error	Missing Fixes: tag referencing the commit that introduced rte_raw_cks=
um_mbuf()
Warning	Missing Cc: stable@dpdk.org for backport
Warning	Double-free in the fail: error path if some segments were already c=
hained


---

## Deep Dive Review: `[v3] net/cksum: compute raw cksum for several segment=
s`

### Summary

This patch fixes a real bug in `rte_raw_cksum_mbuf()` where multi-segment c=
hecksum computation loses data due to two issues: (1) `rte_bswap16()` on a =
`uint32_t` drops the upper 16 bits, and (2) a `uint32_t` accumulator `sum` =
can overflow and lose carries. The fix widens `sum` to `uint64_t`, uses `rt=
e_bswap32()` instead of `rte_bswap16()`, and adds a new `__rte_raw_cksum_re=
duce_u64()` reduction function. A test case is also added.

---

### Correctness Analysis

**The core fix is correct.** The original code had two bugs in the "hard ca=
se" (multi-segment path):

1. **`rte_bswap16((uint16_t)tmp)`** =E2=80=94 `tmp` is the result of `__rte=
_raw_cksum()` which returns a value in the range [0, 0x1FFFE] (a folded-onc=
e 32-bit sum). Casting to `uint16_t` before byte-swapping silently drops th=
e carry bit. The fix to use `rte_bswap32(tmp)` preserves all bits.

2. **`uint32_t sum` overflow** =E2=80=94 After the `bswap32`, `tmp` can be =
up to 0xFFFF0000. Accumulating multiple such values in a `uint32_t` can ove=
rflow and lose carries. Widening `sum` to `uint64_t` prevents this.

**`__rte_raw_cksum_reduce_u64()` correctness check:** The function folds a =
64-bit sum into 16 bits by first reducing the low 32 bits, then reducing th=
e high 32 bits, adding them, and reducing again. This is correct =E2=80=94 =
it handles the full range of a 64-bit accumulator. The intermediate `tmp` i=
s `uint32_t`, and the sum of two `uint16_t` values fits in `uint32_t`, so t=
he final `__rte_raw_cksum_reduce(tmp)` correctly folds any carry.

**No correctness bugs found in the fix itself.**

---

### Potential Issues

**Error: Missing `Fixes:` tag and `Cc: stable@dpdk.org`**

This patch fixes a real bug in existing code (`rte_raw_cksum_mbuf` producin=
g incorrect checksums for multi-segment mbufs). Per DPDK process, bug fixes=
 should include a `Fixes:` tag referencing the commit that introduced the b=
ug, and `Cc: stable@dpdk.org` for backport consideration. Both are missing.

**Warning: Commit message body starts with "The"**

While the guidelines specifically forbid starting with "It", the commit mes=
sage could be improved. More importantly, the body could more clearly descr=
ibe the *impact* =E2=80=94 that multi-segment packets get incorrect checksu=
ms, potentially causing packet drops or silent data corruption. The current=
 description is somewhat mechanical ("drop high 16 bit") without stating th=
e user-visible consequence.

**Warning: Double-free risk in `test_l4_cksum_multi_mbufs()` error path**

Lines 228-229 (the success path) and lines 234-237 (the `fail:` path) both =
iterate and free `m[i]`. However, after a successful `rte_pktmbuf_chain(m_h=
dr, m[i])` call, `m[i]` becomes a segment of the chained mbuf `m_hdr` (whic=
h is `m[0]`). Freeing `m[0]` via `rte_pktmbuf_free()` will walk the chain a=
nd free all chained segments. Then freeing `m[1]`, `m[2]`, etc. individuall=
y would be a **double-free**.

On the **success path** (lines 228-229): `rte_pktmbuf_free(m[0])` frees the=
 entire chain including `m[1]` and `m[2]`. Then `rte_pktmbuf_free(m[1])` an=
d `rte_pktmbuf_free(m[2])` double-free those segments. This is a bug.

On the **error path** (lines 234-237): The same double-free occurs if `rte_=
pktmbuf_chain` succeeded for some segments before a later failure.

**Suggested fix for the success path:**
```c
rte_pktmbuf_free(m_hdr);  /* frees entire chain */
return 0;
```

**Suggested fix for the error path:**
```c
fail:
	if (m_hdr)
		rte_pktmbuf_free(m_hdr);  /* frees chained segments */
	/* Free any remaining unchained segments */
	for (i =3D (m_hdr ? 1 : 0); i < segs_len; i++) {
		/* Only free if not yet chained */
		if (m[i] && m[i] !=3D m_hdr && m[i]->next =3D=3D NULL)
			rte_pktmbuf_free(m[i]);
	}
```

Or more simply, since chain failures are unlikely, set `m[i] =3D NULL` afte=
r a successful chain:
```c
	if (rte_pktmbuf_chain(m_hdr, m[i]) =3D=3D 0)
		m[i] =3D NULL;  /* now owned by chain */
	else
		GOTO_FAIL("Cannot chain mbuf");
```

Then both the success and error cleanup paths can safely iterate and free a=
ll non-NULL `m[i]`.

**Warning: `off` variable type mismatch**

`off` is declared as `size_t` on line 186 but is later reused on line 218 a=
s `off =3D hdr_lens.l2_len + hdr_lens.l3_len` for a different purpose (L4 o=
ffset passed to the cksum verify functions). This reuse is not a bug per se=
, but a different variable name (e.g., `l4_off`) would improve clarity and =
avoid confusion. Minor style point.

**Info: Test coverage is good**

The test data uses three segments with an odd-length middle segment (61 byt=
es), which exercises the byte-swap alignment correction. This is exactly th=
e scenario that triggers the bug. The test validates via `rte_ipv4_udptcp_c=
ksum_mbuf_verify()`, confirming the checksum matches end-to-end.

---

### Summary of Findings

| Severity | Issue |
|----------|-------|
| **Error** | Double-free of chained mbuf segments in `test_l4_cksum_multi_=
mbufs()` =E2=80=94 success path frees `m[0]` (the whole chain) then also fr=
ees `m[1]`, `m[2]` |
| **Error** | Missing `Fixes:` tag referencing the commit that introduced `=
rte_raw_cksum_mbuf()` |
| **Warning** | Missing `Cc: stable@dpdk.org` for backport |
| **Warning** | Double-free in the `fail:` error path if some segments were=
 already chained |

