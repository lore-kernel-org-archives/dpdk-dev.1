Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0111CA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:08:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC2EE42F1D;
	Sat, 17 Jan 2026 23:08:57 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id F139042F0D
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:08:56 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ee9817a35so16758955e9.1
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687736;
 x=1769292536; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sM0xqxzSGJ2xJ6n81fQxOH4z0SHNzUi6GMamlbWJCs8=;
 b=lw8X9NuqF3peu+ezeTT9D0JGMr3qEb6aYa0khIcPGl1sTXeoF950XkISct5EJo+1Zs
 XuxE9fhJirFdaRTYq+BBjikHYQaIbPSxoA2XvcsXCpmW1+FuPkKjLZQOALKt2weDqP6B
 NMm7tQVzPHp9Mv6D8GE6HezKosFoYfJNxaKczr8JLBTbEK1MP5fFuO4/b4dvE2gOHtUz
 kVdMkXh6J/hefgG19v5rtZW5y/uJ6yhKy2CV+GMPh8VoXyMq/E40cMuY8dNHkBcWE6XK
 zikCp39VBLRkYwBPgSiFcyhtvor3p2bNVYiOD3B7hjZ3XrWfvyHP1YIhK2N0Xqimu6fM
 KLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687736; x=1769292536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sM0xqxzSGJ2xJ6n81fQxOH4z0SHNzUi6GMamlbWJCs8=;
 b=SMOb0J2wydncr01+tqCKfezCeNIP+b4t1QMT8XuW7rZ8xhaFp+au5sGjRbyV1yZ9xC
 iAf1cKKF0wjLeBwn+Owo1ULIUSoMnWYL4guZlclT28TMDYqdah/6ynpW7DCjfkB+vWv+
 BdpXOnHMWnbNVSaGFcRsA2/1pzLVR4l7CJR29yrlRB5ctRa3z8JTFOxHkI2NUdUMfUxr
 539tUg0lHI52bRNKT0mUKpnzRGJOOaVQKSrpZoHpwodMPLZ65tdiA4v1ElCzsM2PPmWF
 Ic2kOuhAwJi+Qoz5K8cfIWtIqjjuhkmxV2Upm1F4rt6QNZCuSkHB3RY4g8qAzWamCyAP
 tWWg==
X-Gm-Message-State: AOJu0YxbwlesQP7q7c2d9eD6oHhUMO0wJI+fncbYxsD+fPvMqrFw/fnp
 gRgCstYpUY0CC6Pu9TeJYnZmx9p1Vx9lzJMhcFjdZPUr4NA5BA3qwlpqU97IoIlioa2+WFDmuSW
 XTxM9
X-Gm-Gg: AY/fxX7teeXnrwL8kRB30PRSGgUbYnWTnzZ+JVk4ebH9vCy6Fs+uRcWRYrY4m9wZZWO
 ajS6Cpa518isIiayWpkayEts/gZDpG2+wFh34jCWws2WsH/ES6U1PNk4C3J+7URF9MB2n8oTXE5
 DmhR403JxKQuy9faNTc4bi9mkzY5WmtVDUXGtUGWOAip8zl+DGe6K8cyORNbkla0/vvd/+zU1XU
 J9YIEigHwSwvb5SpWPqI98TwH4xcXdZMGSk7M7tSv4vcbefKNIvUUK5drzCQuNAglvGEfVemWfY
 H+d03YYekD4/r1I8RzXSn1IYSKiRsxig07sjt5ckHgUh8Z4ilyxVlkLJhp3eYZA1ABxxWrWR0fx
 BE4UuvhhQuvmTQAl65NgUtXANhERxLGJn36+bsrwE00ffHcnLBVjJHo+AW7/5Ztbny8KT64I/w2
 4xSUmhoaLsTvflNSrl7NyQT+F4rrX6wuRfYXV0EVJ2Ql7GGspVTaXd
X-Received: by 2002:a05:600c:5487:b0:46f:d682:3c3d with SMTP id
 5b1f17b1804b1-4801e30d482mr82362145e9.13.1768687736392; 
 Sat, 17 Jan 2026 14:08:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e886829sm112050725e9.8.2026.01.17.14.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:08:56 -0800 (PST)
Date: Sat, 17 Jan 2026 14:08:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com
Subject: Re: [PATCH v15 0/2] net: optimize __rte_raw_cksum
Message-ID: <20260117140848.49104c2b@phoenix.local>
In-Reply-To: <20260117212114.10466-1-scott.k.mitch1@gmail.com>
References: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
 <20260117212114.10466-1-scott.k.mitch1@gmail.com>
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

On Sat, 17 Jan 2026 13:21:12 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
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
> Performance results show significant improvements (40% for small buffers,
> up to 8x for larger buffers) on Intel Xeon with Clang 18.1.
>=20
> Changes in v15:
> - Use NOHUGE_OK and ASAN_OK constants in REGISTER_FAST_TEST
>=20
> Changes in v14:
> - Split into two patches: EAL typedef fix and checksum optimization
> - Use unaligned_uint16_t directly instead of wrapper struct
> - Added __rte_may_alias to unaligned typedefs to prevent GCC bug
>=20
> Scott Mitchell (2):
>   eal: add __rte_may_alias to unaligned typedefs
>   net: __rte_raw_cksum pointers enable compiler optimizations
>=20
>  app/test/meson.build         |   1 +
>  app/test/test_cksum_fuzz.c   | 240 +++++++++++++++++++++++++++++++++++
>  app/test/test_cksum_perf.c   |   2 +-
>  lib/eal/include/rte_common.h |  34 ++---
>  lib/net/rte_cksum.h          |  14 +-
>  5 files changed, 266 insertions(+), 25 deletions(-)
>  create mode 100644 app/test/test_cksum_fuzz.c
>=20
> --
> 2.39.5 (Apple Git-154)
>=20

Looks good now.
Acked-by: Stephen Hemminger <stephen@networkplumber.org>

AI review agrees with me...


## Patch Review: [PATCH v15 1/2] eal: add __rte_may_alias to unaligned type=
defs

### Commit Message Analysis

| Criterion | Status | Notes |
|-----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 47 characters |
| Lowercase after colon | =E2=9C=85 Pass | "add __rte_may_alias..." |
| Imperative mood | =E2=9C=85 Pass | "add" |
| No trailing period | =E2=9C=85 Pass | |
| Correct prefix | =E2=9C=85 Pass | "eal:" for lib/eal/ files |
| Body =E2=89=A475 chars/line | =E2=9C=85 Pass | Lines appear within limit |
| Body doesn't start with "It" | =E2=9C=85 Pass | Starts with "Add" |
| Signed-off-by present | =E2=9C=85 Pass | `Signed-off-by: Scott Mitchell <=
scott.k.mitch1@gmail.com>` |

### Missing Tags (Warning)

**No `Fixes:` tag**: The commit message describes fixing "GCC strict-aliasi=
ng optimization bugs" and "incorrect optimization." This sounds like a bug =
fix that should reference the original commit introducing the unaligned typ=
edefs. Consider adding:
```
Fixes: <12-char-sha> ("original commit introducing unaligned typedefs")
```

**No `Cc: stable@dpdk.org`**: If this fixes a real bug causing reads from u=
ninitialized memory, it's likely a stable backport candidate.

### Code Review

**Positive aspects:**
- Proper Doxygen comment added for `__rte_may_alias` macro
- Good explanation of the GCC bug workaround
- MSVC fallback handled correctly
- Macro moved before its use (necessary for the typedefs)

**Minor observations:**
- The second comment block (lines 121-124 in the diff) is somewhat redundan=
t with the first Doxygen comment. Consider consolidating.

---

## Patch Review: [PATCH v15 2/2] net: use unaligned type for raw checksum

### Commit Message Analysis

The mbox was truncated, but based on what's visible:

| Criterion | Status | Notes |
|-----------|--------|-------|
| Correct prefix | =E2=9C=85 Pass | "net:" for lib/net/ files |

### Code Review - lib/net/rte_cksum.h

**The core change:**
```c
// OLD (memcpy-based):
for (end =3D RTE_PTR_ADD(buf, RTE_ALIGN_FLOOR(len, sizeof(uint16_t)));
     buf !=3D end; buf =3D RTE_PTR_ADD(buf, sizeof(uint16_t))) {
    uint16_t v;
    memcpy(&v, buf, sizeof(uint16_t));
    sum +=3D v;
}

// NEW (direct access via unaligned type):
const unaligned_uint16_t *buf16 =3D (const unaligned_uint16_t *)buf;
const unaligned_uint16_t *end =3D buf16 + (len / sizeof(*buf16));
for (; buf16 !=3D end; buf16++)
    sum +=3D *buf16;
```

**Positive aspects:**
- Cleaner, more readable code
- Relies on the `__rte_may_alias` attribute from patch 1 to prevent aliasin=
g bugs
- Comment explains vectorization benefit: "GCC/Clang vectorize the loop"
- Good dependency ordering (patch 1 must come before patch 2)

**Style observations:**
- =E2=9C=85 Line length within 100 chars
- =E2=9C=85 Proper use of `const`

### Code Review - app/test/test_cksum_fuzz.c (New File)

**Positive aspects:**
- =E2=9C=85 Uses `TEST_SUCCESS`/`TEST_FAILED` correctly
- =E2=9C=85 Uses `REGISTER_FAST_TEST` macro properly
- =E2=9C=85 `printf()` usage is acceptable in test code per AGENTS.md
- =E2=9C=85 `rte_malloc()` usage acceptable in test code
- =E2=9C=85 Comprehensive edge case testing (power-of-2 boundaries, MTU siz=
es, GRO boundaries)
- =E2=9C=85 Tests both aligned and unaligned cases
- =E2=9C=85 Tests with zero and random initial sums

**Issues to verify** (file header not visible in truncated mbox):
- Ensure SPDX license identifier present on first line
- Ensure copyright line follows SPDX
- Ensure blank line before includes

**Style warning (lines 394-396):**
```c
printf("MISMATCH at len=3D%zu aligned=3D'%s' initial_sum=3D0x%08x ref=3D0x%=
08x opt=3D0x%08x\n",
       len, aligned ? "aligned" : "unaligned",
       initial_sum, sum_ref, sum_opt);
```
Line length appears to be ~95 chars which is acceptable (<100).

### Code Review - app/test/test_cksum_perf.c

Minor change extending test coverage - looks fine.

---

## Summary

### Errors (Must Fix)
None identified.

### Warnings (Should Fix)

| Issue | Patch | Recommendation |
|-------|-------|----------------|
| Missing `Fixes:` tag | 1/2 | Add if this fixes a regression from a specif=
ic commit |
| Missing `Cc: stable@dpdk.org` | 1/2 | Consider if this should be backport=
ed |
| Verify SPDX header | 2/2 | Ensure test_cksum_fuzz.c has proper license he=
ader |

### Info (Consider)

1. **Patch 1**: The two comment blocks for `__rte_may_alias` could be conso=
lidated into a single, more comprehensive Doxygen comment.

2. **Patch 2**: The new fuzz test is well-structured and follows DPDK test =
conventions. Good use of the `unit_test_suite_runner`-style approach with `=
REGISTER_FAST_TEST`.

3. **Series overall**: Good logical ordering - patch 1 provides the infrast=
ructure, patch 2 uses it. Each commit should compile independently.

---

**Verdict**: This is a well-structured patch series at v15. The code change=
s are clean and the test coverage is thorough. The main actionable items ar=
e adding appropriate `Fixes:` and `Cc: stable` tags if this is indeed a bug=
 fix worth backporting.

