Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A92CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 22:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9AC540287;
	Fri, 22 May 2026 00:42:20 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 90839400D5
 for <dev@dpdk.org>; Fri, 22 May 2026 00:42:19 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2f03d6cf77bso6786487eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779403338;
 x=1780008138; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeGWt/Pce3BSGfByeyK7KJm5WxShkLpgdbMLEF5P6+0=;
 b=xXFunNTEudHC3IJHKvqXhI1m5trpfM31GOCljy0ZvqN12l9k1+fuWnz9A0sKt3+vNF
 4HcuQVto70Zd20PWXxmNJWbS5xri0L5iKqGYdk1AFZFby9xJpl03KOpXzFZ+JoKX25wY
 +peG3NG1MiYfMce153QFTRPE4IRdBHk2cvjVrsla80303FF5jpYgPC/oW3CwdgsGA6S6
 dh1/7y9/Q/egntyyduFoq3SAil3Wi5U2XzHtddr9KD151AiOKqG7gOSn8pngGPIgoK1A
 RCyiuQjJxHo1YikhaIMy/KQcTdcfiJLcW+G8lheWeSv1P9bTzdQPYYvucbePuqmWCZ9n
 +UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779403338; x=1780008138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SeGWt/Pce3BSGfByeyK7KJm5WxShkLpgdbMLEF5P6+0=;
 b=LYMgNVIqzVyZryDV4Rt4vRrPGsTwDNvnF6gD7uNknJ/wpcV+WzpHLj/O5RwCIbU+vx
 4ysWEYCFZVxTW+P5yNqJPhSQ5XwHYTMIlktxbWyvkW/jklsXhl1WeZfoOdLxvaYcLSEw
 porCyg7MoO/Q9cu7JknfcASk7C2/0Y6vW0zHYnimuQvRhB7xSgyVEOY9zoF6sL+xrdjD
 lu2asEBjhviyrmp+rEWE82JeUO6ofQ76LEx6f8JT1rGVBRmaHetlYgth++M1s/Zr3zjo
 8u0kAqCXuYfthr7ehLn4h+sNJAwz5LPETpSLfhR4+uSPTiX7leVvGjzI5b5RnYTtpgIg
 jP5g==
X-Gm-Message-State: AOJu0YwCjXEKxCqXFoGvMid+2b84Wx9Hd2baBD0U9bXgzl0/vGFMlAhL
 yVvnpadlgLFkHZQ5f9DCyDjj9N3v0U8rrqIB/ycb5fodGZII4/ChWmozWGFbzb01sYM=
X-Gm-Gg: Acq92OHoBpruzBgfTv9OHTwBmKSlXZX6yWSZreCL3Fi0G9NqMUumkhD+93RcQk5DLiU
 J+3DvqjTHRbwDomleLf5DMdK8+f/orTB7t/n/4LZOEqhP6U2d/84K/9vbVKM6xEP0xJ87FewjG6
 ngnGTqskTKkcv/DhsQ4U1wOwfMxOjZkIU0GLaRUsRmok9Jod4Zs1ICnwjprP47XXtCDteAxvarK
 blRCwPpkdKwXICfQXnOxqkbPEk84rD+c7i7Eji6gLwn8aRMFYkPNrM1SqnciGGLBPwynAQC3a9J
 TrL6CitTLxol3UrhAXgTmHbrgxa7w/mDalPJvNZ61fJEwJrJOAM5EYARxij/A1nXlM9ntjxwNzF
 MLV7kPGCzZbyKDAYf4pMz3A3CVaO+F+U4vsfLtxvYGT9rS175AafUPywWaWqK3N65VRpOEmmnoJ
 QCGv2x601qQVC7LbRH0/4cc4OuVUwn4C6cO6yU3ldLU/i/dqc46ev47/QoTAJrAL/n
X-Received: by 2002:a05:7300:cac8:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-3044924e434mr624230eec.33.1779403338174; 
 Thu, 21 May 2026 15:42:18 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3044b70555bsm348533eec.12.2026.05.21.15.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:42:17 -0700 (PDT)
Date: Thu, 21 May 2026 15:42:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Konstantin
 Ananyev <konstantin.v.ananyev@yandex.ru>, Vipin Varghese
 <vipin.varghese@amd.com>, Liangxing Wang <wangliangxing@hygon.cn>,
 Thiyagarajan P <Thiyagarajan.P@amd.com>, Bala Murali Krishna
 <Bala.MuraliKrishna@amd.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v11] eal/x86: optimize memcpy of small sizes
Message-ID: <20260521154214.1c171a74@phoenix.local>
In-Reply-To: <20260521185631.116046-1-mb@smartsharesystems.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20260521185631.116046-1-mb@smartsharesystems.com>
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

On Thu, 21 May 2026 18:56:31 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> The implementation for copying up to 64 bytes does not depend on address
> alignment with the size of the CPU's vector registers. Nonetheless, the
> exact same code for copying up to 64 bytes was present in both the aligned
> copy function and all the CPU vector register size specific variants of
> the unaligned copy functions.
> With this patch, the implementation for copying up to 64 bytes was
> consolidated into one instance, located in the common copy function,
> before checking alignment requirements.
> This provides three benefits:
> 1. No copy-paste in the source code.
> 2. A performance gain for copying up to 64 bytes, because the
> address alignment check is avoided in this case.
> 3. Reduced instruction memory footprint, because the compiler only
> generates one instance of the function for copying up to 64 bytes, instead
> of two instances (one in the unaligned copy function, and one in the
> aligned copy function).
>=20
> Furthermore, __rte_restrict was added to source and destination addresses.
>=20
> Also, the missing implementation of rte_mov48() was added.
>=20
> Until recently, some drivers required disabling stringop-overflow warnings
> when using rte_memcpy().
> For some strange reason, these warnings were disabled in the rte_memcpy
> header file, instead of in the problematic drivers.
> With series-38174 ("remove use of rte_memcpy from net/intel"), the
> problematic drivers were updated to use memcpy() instead of rte_memcpy(),
> so disabling these warnings is no longer required, and was removed.
>=20
> Regarding performance...
> The memcpy performance test (cache-to-cache copy) shows:
> Copying up to 15 bytes takes ca. 4.5 cycles, versus ca. 6.5 cycles before.
> Copying 8 bytes takes 4 cycles, versus 7 cycles before.
> Copying 16 bytes takes 2 cycles, versus 4 cycles before.
> Copying 64 bytes takes 4 cycles, versus 7 cycles before.
>=20
> Depends-on: series-38174 ("remove use of rte_memcpy from net/intel")
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---

Here is the full wordy all providers reviews.
Mostly this is test to make sure script works.

$ ./devtools/ai/compare-patch-reviews.sh ~/Downloads/v11-eal-x86-optimize-m=
emcpy-of-small-sizes.patch=20
Reviewing patch: v11-eal-x86-optimize-memcpy-of-small-sizes.patch
Providers: anthropic,openai,xai,google
Format: text
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>>> Running review with: anthropic

=3D=3D=3D Patch Review: v11-eal-x86-optimize-memcpy-of-small-sizes.patch (v=
ia Claude) =3D=3D=3D
Review date: 2026-05-21

# Review of v11-eal-x86-optimize-memcpy-of-small-sizes.patch

## Correctness Issues

### Errors

**Use-after-free pattern in overlapping copy optimization (lines 672-673, 6=
84, 704, 707)**

The pattern `(uint8_t *)dst - 16 + n` performs pointer arithmetic that, whe=
n `n < 16`, results in accessing memory before the `dst` pointer. This is u=
sed in an optimization technique (two overlapping stores) that is correct w=
hen `n >=3D 16`, but the code paths in question guarantee `n` is in specifi=
c ranges where this is safe. However, the readability is poor and the inten=
t is not obvious from the code.

**Confidence: 80%** - This pattern is widely used in memcpy implementations=
 and appears intentional, but deserves a comment explaining the technique t=
o avoid confusion in future reviews.

---

## Warnings

**Missing documentation for new function rte_mov48() (line 130)**

The patch adds `rte_mov48()` but does not mention it in the commit message'=
s "Also, the missing implementation of rte_mov48() was added." The implemen=
tation itself is correct, but there's no context about why it was missing o=
r whether it's used elsewhere in DPDK.

**Suggestion:** Verify that `rte_mov48()` is actually used somewhere, or do=
cument why it's being added speculatively.

---

**Inconsistent handling of compile-time constant size (lines 682-683)**

The code checks `__rte_constant(n) && n =3D=3D 16` to avoid a "harmless dup=
licate copy" but does not apply this optimization consistently. For example:
- Line 682: avoids duplicate for `n =3D=3D 16`
- Line 690: avoids duplicate for `n =3D=3D 32`
- Line 693: avoids duplicate for `n =3D=3D 64`

But in the 33-64 byte range (lines 695-707), there's no similar optimizatio=
n. This is not a bug, but the inconsistency in optimization strategy could =
be noted.

**Suggestion:** Add a comment explaining the rationale for when this optimi=
zation matters vs when the "harmless duplicate" is acceptable.

---

**Potential alignment assumption in AVX path (line 699)**

The AVX path at line 699 uses two overlapping `rte_mov32()` calls for sizes=
 33-64 bytes:
```c
rte_mov32((uint8_t *)dst, (const uint8_t *)src);
rte_mov32((uint8_t *)dst - 32 + n, (const uint8_t *)src - 32 + n);
```

For `n =3D 33`, the second call accesses `dst + 1` and `src + 1`, which may=
 be misaligned for the 32-byte `__m256i` operations. However, `_mm256_loadu=
_si256()` and `_mm256_storeu_si256()` are documented as supporting unaligne=
d access, so this is safe.

**Confidence: 90%** - Not a bug, but worth noting that the AVX path relies =
on unaligned load/store support.

---

## Style and Process Issues

### Warnings

**Unconventional comment style in rte_mov15_or_less() (lines 67-72)**

The multi-line comment explaining the rationale for the `rte_uint*_alias` s=
tructures does not follow the standard DPDK comment block format with the `=
*` on each line. However, this may be intentional for a technical explanati=
on.

---

**Return value inconsistency (lines 682, 690-691, 693, 707-708)**

The function returns `dst` in some branches but the original `ret` pointer =
in others:
- Lines 682, 690, 707: return `dst`
- Line 714: return from `rte_memcpy_aligned_more_than_64(dst, src, n)` whic=
h returns `ret =3D dst`
- Line 716: return from `rte_memcpy_generic_more_than_64(dst, src, n)` whic=
h returns `ret =3D dst`

Both `ret` and `dst` point to the same location, so this is harmless, but u=
sing `dst` consistently would be clearer. The patch description states "Poi=
nter to the destination data" is returned, and both satisfy this.

**Confidence: 95%** - Not an error, but inconsistent style within the same =
function.

---

## Documentation Issues

### Warnings

**Missing documentation update for removed warning suppression (lines remov=
ed at top)**

The patch removes:
```c
#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >=3D 100000)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wstringop-overflow"
#endif
```

The commit message explains this is because the problematic drivers were up=
dated, with a `Depends-on: series-38174`. However, there's no comment in th=
e code explaining why the suppression was removed or a note in `doc/guides/=
rel_notes/` documenting this change.

**Suggestion:** Add a release note entry documenting the removal of the war=
ning suppression and the dependency on the driver updates.

---

## Summary

**Priority findings:**

1. **(Info)** The overlapping copy optimization `dst - 16 + n` is correct b=
ut deserves a comment explaining the technique.
2. **(Warning)** Missing documentation for why `rte_mov48()` was added.
3. **(Warning)** Missing release notes entry for removal of stringop-overfl=
ow warning suppression.
4. **(Info)** Return value uses both `dst` and `ret` inconsistently (harmle=
ss but could be unified).

**Overall assessment:** The patch appears functionally correct. The main co=
ncerns are documentation completeness (missing context for `rte_mov48()`, m=
issing release notes for warning removal) and code clarity (overlapping cop=
y pattern could use explanatory comments). No blocking correctness issues w=
ere identified.
(anthropic: review reported errors)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>>> Running review with: openai

=3D=3D=3D Patch Review: v11-eal-x86-optimize-memcpy-of-small-sizes.patch (v=
ia ChatGPT) =3D=3D=3D
Review date: 2026-05-21

**DPDK Patch Review: v11-eal-x86-optimize-memcpy-of-small-sizes.patch**

---

### Errors

None found.

- The patch does not introduce resource leaks, use-after-free, race conditi=
ons, or missing synchronization.
- There are no buffer overflows or out-of-bounds accesses in the memcpy rou=
tines; all copy size calculations and code paths for small copies (<64 byte=
s) are explicit and conservative.
- No uninitialized or stale variable use detected.
- All error paths are clean (these are computational functions; return valu=
es are always valid).

---

### Warnings

1. **Potential inconsistent comment phrasing regarding overlap requirements=
.**

   - Some Doxygen comments use "locations should not overlap" while others =
now correctly say "locations must not overlap".
   - While this isn't a correctness bug, consistent strong wording clarifie=
s requirement for users.

   **Suggested fix:** Standardize all relevant Doxygen comments to use "loc=
ations must not overlap."

   ```c
   /**
    * Copy bytes from one location to another,
    * locations must not overlap.
    */
   ```

2. **Redundant Doxygen param alignment in function headers.**

   - Some parameter descriptions ("Pointer to the destination of the data"/=
"Pointer to the destination data") remain a bit unclear or inconsistent. If=
 updating comments, consider making param descriptions exact and explicit.

   **Suggested fix:** For each `@param` clarify if it's the destination or =
source pointer. For `rte_memcpy`, `"Pointer to the destination."` and `"Poi=
nter to the source."` suffice.

---

### Info

- Use of `__rte_restrict` is correct and improves optimization; matches DPD=
K style for pointer restrict qualifiers.
- Removal of `#pragma GCC diagnostic ignored "-Wstringop-overflow"` is corr=
ect because the problematic drivers now use standard `memcpy()`.
- All new `rte_mov*` functions properly use `static __rte_always_inline` an=
d restrict-qualified pointers.
- Macro duplication is avoided by consolidation, in line with maintainabili=
ty guidelines.
- No forbidden tokens, banned constructs, or use of deprecated APIs/macros =
were added.
- No symbol namespace pollution or missing `rte_`/`RTE_` prefix issues pres=
ent.
- Coding style is maintained in indentation, tabs use, and function/variabl=
e names.
- No API, public header, or C11 atomic/volatile/race issues are present.
- No documentation or API tag requirements are triggered (no public API cha=
nge).
- Patch is self-contained and does not require changes to release notes or =
test infrastructure.
- No RST or external documentation is involved in this patch.

---

### Summary

**No correctness/blocking issues found.**
Minor documentation consistency updates suggested for comment clarity, but =
these do not affect correctness.

**This patch is in good shape and complies with DPDK coding and architectur=
al guidelines.**
(openai: review reported errors)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>>> Running review with: xai

=3D=3D=3D Patch Review: v11-eal-x86-optimize-memcpy-of-small-sizes.patch (v=
ia Grok) =3D=3D=3D
Review date: 2026-05-21

**Review of patch: v11-eal-x86-optimize-memcpy-of-small-sizes.patch**

### Errors

**1. Missing `__rte_restrict` in rte_mov48() implementation (consistency / =
correctness risk)** =20
The new `rte_mov48()` function is declared with `__rte_restrict`, but the i=
mplementation casts away the restrict qualifier when calling `rte_mov32()` =
and `rte_mov16()`:

```c
rte_mov32((uint8_t *)dst, (const uint8_t *)src);
rte_mov16((uint8_t *)dst + 32, (const uint8_t *)src + 32);
```

**Suggested fix**: Keep the restrict-qualified parameters in the implementa=
tion or cast only after documenting the aliasing contract. This is a minor =
style inconsistency but worth fixing for uniformity.

**2. Potential sign-extension issue on 64-bit offset calculations (left-shi=
ft of narrow type)** =20
In `rte_mov15_or_less()`, the expression `(n & 8)` is `size_t` (ok), but th=
e subsequent pointer arithmetic:

```c
*(uint64_t *)((uint8_t *)dst + n - 8) =3D *(const uint64_t *)((const uint8_=
t *)src + n - 8);
```

relies on implicit promotion. While currently safe, the pattern of adding a=
 `uint8_t`/`size_t` value to a pointer after a narrow mask (`n & 7`) could =
trigger Coverity SIGN_EXTENSION warnings on some toolchains. Consider an ex=
plicit cast:

```c
uint8_t *d =3D (uint8_t *)dst + (size_t)(n - 8);
```

**3. Use of `__rte_constant` inside hot path without documented behavior** =
=20
The code repeatedly uses `__rte_constant(n)` to optimize compile-time known=
 sizes. This is a DPDK internal macro. While acceptable for performance-cri=
tical code, it should be documented (or at least noted) that the optimizati=
on only triggers for constant `n`. No correctness bug, but worth a comment.

### Warnings

**1. Duplicate function definitions for AVX/SSE variants** =20
The patch introduces three nearly identical `rte_memcpy_generic_more_than_6=
4()` and `rte_memcpy_aligned_more_than_64()` functions (one per vector size=
). This increases maintenance burden and instruction cache pressure. Consid=
er factoring the common >64-byte logic into a single helper.

**2. Hard-coded cast chains in rte_mov48()** =20
The SSE implementation of `rte_mov48()` uses explicit `(uint8_t *)` casts o=
n restrict-qualified pointers. While functionally correct, it reduces reada=
bility. A cleaner pattern would be:

```c
rte_mov16(dst + 0, src + 0);
rte_mov16(dst + 16, src + 16);
rte_mov16(dst + 32, src + 32);
```

**3. Inconsistent use of `return dst` vs `return ret`** =20
In the new `rte_memcpy()` implementation the fast path returns `dst`, while=
 the old `rte_memcpy_generic()` returned the saved `ret`. Although `dst` an=
d `ret` are identical, using `ret` consistently would avoid any future dive=
rgence.

**4. Missing Doxygen for new rte_mov48()** =20
The new function has a Doxygen comment, but the description is minimal. Con=
sider adding a brief note that it is an internal helper (or mark it `__rte_=
internal` if it should not be public).

### Info

- The removal of the `#pragma GCC diagnostic` block for `-Wstringop-overflo=
w` is correct and aligns with the series that removed `rte_memcpy` usage fr=
om drivers.
- Adding `__rte_restrict` to `rte_memcpy()` and helper functions is a good =
improvement and matches modern DPDK style.
- Performance claims in the commit message are outside the scope of this re=
view (they are not code).

### Summary

No critical correctness bugs (use-after-free, leaks, races, or missing erro=
r checks) were identified. The main issues are minor style/consistency item=
s around restrict qualifiers, pointer arithmetic, and code duplication. The=
 patch is otherwise clean and follows DPDK coding guidelines for the x86 EA=
L memcpy implementation.
(xai: review reported errors)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

>>> Running review with: google

=3D=3D=3D Patch Review: v11-eal-x86-optimize-memcpy-of-small-sizes.patch (v=
ia Gemini) =3D=3D=3D
Review date: 2026-05-21

The following is a review of the patch against DPDK coding standards and gu=
idelines.

### Warnings

**Implicit integer comparison in rte_memcpy.**
DPDK coding style requires explicit comparison against 0 for integer types,=
 rather than using truthiness/logical negation.
```c
/* Current implementation */
if (!(((uintptr_t)dst | (uintptr_t)src) & ALIGNMENT_MASK))

/* Suggested fix */
if ((((uintptr_t)dst | (uintptr_t)src) & ALIGNMENT_MASK) =3D=3D 0)
```

### Info

**Use of bitwise logic in rte_mov15_or_less.**
While this patch only adds `__rte_restrict` to the signature, the existing
(google: review reported warnings)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Review comparison complete.
Summary across 4 provider(s): clean=3D0 warnings=3D1 errors=3D3 failed=3D0

