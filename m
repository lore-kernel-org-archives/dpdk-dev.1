Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211F6C9830C
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 02:44:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D918427E9;
	Sat, 17 Jan 2026 03:44:36 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id ED45C402DA
 for <dev@dpdk.org>; Sat, 17 Jan 2026 03:44:34 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-480142406b3so12722215e9.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768617874;
 x=1769222674; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSdIMMaub4EBJK4Xbi54SMfZ3U4iM4FZ6l+SNUq1fMc=;
 b=LZr5MjUHFwfhWpR5DPd6ojuSo09aF4Nd8JGsTLKsd+JSwFohQuY4elELrwBHstOsma
 SiNZo1srJEuaUaxcVkaG0IL1otC7dW0xQeUpaSj25MgqPrQY8N1hq1hD2witiD48l8uO
 aTdcZFr8P83mW7IfBrmTn7+w0kk/9Rp+YwWSgWqm7x0IbW/W5l95COjEmnzymRj8lOsV
 FjbPo7j/hOJULaHtjSvVwK5/NkzGvMCMv1z5oTybkBort42n014YjQcmixn7IBA8tALg
 LnCdRpOReBpSkqZGrXd85EO+pUd4khMG+Q/TLnqLRIfhiebNOdE4/dAY56vVfklQb8bP
 7aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768617874; x=1769222674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HSdIMMaub4EBJK4Xbi54SMfZ3U4iM4FZ6l+SNUq1fMc=;
 b=aTW67CXECPqSFmTjbXVubnCG8VEoUdBwsYDYyV1oqPLFOE3ezBcnBIPheQu5guojDD
 mjLcAE7meNkSM334liC1JiF7hY2Bu8Cqn18+E4MQbYMqAB8gl+xgcsI/auSKoaetpEr3
 H3zIiA66QmdiPX7pzXlJkXrV9cj1iNyDclmDyiQO/7JiViyDmrbGYZnEt4a/sf2vu/iq
 uGUU33H5nkuEObpSoowwSsGHVJsphgbG9NVlJDN7rZEqENN/Qh3pIE0DauqXHob1r8Zn
 IH7c2H0RXBZ5am6/mGI62Bz0EukyWQIEGMM/XY738wcpe1336VmSsxFCD8gACgwcBpVV
 tdZA==
X-Gm-Message-State: AOJu0YzZI91q9YQG+FxtPQF2WsDaeQ3jX5n/ImshBqwM31AIqWhSy/CZ
 f5BUTIv8frDuJamsrT/T8EAWv9jPvVySqzvmIY4z5LH/QS4FoEx9u8C8vJLHmMW932U=
X-Gm-Gg: AY/fxX4RCxr54cvFVknlxMO1tAHhADqVWCrZwDrGkH+l+7tvVaQMpImmnN2+ncogwBa
 oksh5VIIZRajk5ytdWtSyWo03yVJ+/7lwQi/BoicYOogpNaHQeBJAPxKMQUjggphToM+Xg9UkMW
 rRBO2f5hO6z6NxxYhDQoxjGd3L6/7fWCVSJ28ehO5ELKedlqIdstXeppJpSuOdb5FH6VsCzjhvk
 FGRMP+etrcs747uYUr7LB9vHT6bftoB40q3DECCFzvapy1JsKp+z06+cMzV2MmS2RRzi40XqZSI
 nswVrqbHiLjjXu3Qx2wuZY3r4kDDtvedTF0mszxa+dfU9tkALkjVnDPz35lrPDAQGtjdBxoLcBT
 JbapBRPq1CjiybjXAGBjRGSAgecoPiDxYnBC6Y0IqYXCUtYxUjMQwMHhfhtk/BSGc9OrnG12QjY
 tAEdX9yfoUQ5KtwfJFK3CWo488PyKwinsQPAgxqLxqZxdnNwi3GdUC
X-Received: by 2002:a05:600c:638f:b0:480:25ae:9993 with SMTP id
 5b1f17b1804b1-48025aea67fmr24135315e9.20.1768617874399; 
 Fri, 16 Jan 2026 18:44:34 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e664sm7681864f8f.30.2026.01.16.18.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 18:44:34 -0800 (PST)
Date: Fri, 16 Jan 2026 18:44:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org, mb@smartsharesystems.com, bruce.richardson@intel.com
Subject: Re: [PATCH v8] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Message-ID: <20260116184428.49e45dd4@phoenix.local>
In-Reply-To: <20260116231907.13895-1-scott.k.mitch1@gmail.com>
References: <20260114215648.47820-1-scott.k.mitch1@gmail.com>
 <20260116231907.13895-1-scott.k.mitch1@gmail.com>
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

On Fri, 16 Jan 2026 15:19:07 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> Modify RTE_PTR_ADD and RTE_PTR_SUB to use char* pointer arithmetic
> on Clang instead of uintptr_t casts. Benefits of this approach:
> - API compatibility: works for both integer and pointer inputs
> - Retains simple macros: no pragmas, no _Generic
> - Enables Clang optimizations: Clang can now unroll and vectorize
>   pointer loops. GCC uses uintptr_t to avoid false positive warnings.
>=20
> Example use case which benefits is __rte_raw_cksum. Performance
> results from cksum_perf_autotest on Intel Xeon (Cascade Lake,
> AVX-512) built with Clang 18.1 (TSC cycles/byte):
>   Block size    Before    After    Improvement
>          100      0.40     0.24        ~40%
>         1500      0.50     0.06        ~8x
>         9000      0.49     0.06        ~8x
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> ---

Looks good to me and not too complex.

AI code review had some additional comments.


## Patch Review: eal: RTE_PTR_ADD/SUB char* for compiler optimizations (v8)

### =E2=9C=85 PASS Items

**Commit Message - Subject Line:**
- Length: ~52 characters (=E2=9C=93 under 60 limit)
- Prefix: `eal:` is correct for EAL changes
- No trailing period
- Imperative mood

**Commit Message - Body:**
- Well-documented rationale with clear performance data
- Does NOT start with "It" =E2=9C=93
- Performance table shows concrete improvements (~40% to ~8x)
- Line wrapping appears within 75-character limit

**Tags:**
- `Signed-off-by:` present with real name and valid email =E2=9C=93
- Tag order is correct

**SPDX/License (new file `test_ptr_add_sub.c`):**
- SPDX identifier on first line =E2=9C=93
- Copyright follows SPDX =E2=9C=93
- Blank line after copyright =E2=9C=93
- BSD-3-Clause appropriate for `app/test` =E2=9C=93

**Tests:**
- Comprehensive test coverage for integer and pointer types =E2=9C=93
- Uses `TEST_ASSERT_EQUAL` macros =E2=9C=93
- Uses `REGISTER_FAST_TEST` infrastructure =E2=9C=93
- Tests both ADD and SUB with round-trip verification =E2=9C=93
- Named constants (`TEST_INITVAL`, `TEST_INCREMENT`) instead of magic numbe=
rs =E2=9C=93

**Code Quality:**
- Macro implementation is well-documented with explanatory comment
- Conditional compilation (`#ifdef RTE_CC_CLANG`) is clean
- No forbidden terminology

---

### =E2=9A=A0=EF=B8=8F WARNING Items

**1. Include Order (test_ptr_add_sub.c lines 161-164):**
```c
#include "test.h"
#include <stdint.h>

#include <rte_common.h>
```
Per AGENTS.md, order should be: (1) system includes, (2) EAL includes, (3) =
misc DPDK includes, (4) application-specific. Should be:
```c
#include <stdint.h>

#include <rte_common.h>

#include "test.h"
```

**2. Subject Line Contains Underscores:**
The subject `eal: RTE_PTR_ADD/SUB char* for compiler optimizations` include=
s underscores (code identifiers after the colon). Per AGENTS.md: "Underscor=
es after the colon (indicates code in subject)" is flagged. Consider:
```
eal: use char pointer arithmetic for Clang optimizations
```

**3. Missing Release Notes:**
This is a notable performance optimization (~8x improvement in some cases).=
 Per AGENTS.md, "significant changes" should update release notes in `doc/g=
uides/rel_notes/`. Consider adding a note about the checksum performance im=
provement.

**4. Doxygen Documentation:**
The existing Doxygen comments for `RTE_PTR_ADD` and `RTE_PTR_SUB` remain mi=
nimal:
```c
/**
 * add a byte-value offset to a pointer
 */
```
Consider adding `@param` and `@return` documentation, especially noting tha=
t `ptr` can be either a pointer or integer type.

---

### =E2=84=B9=EF=B8=8F INFO Items (Minor Suggestions)

**1. Variable Declaration Style:**
In `test_ptr_add_sub_integer_types()`, variables are declared at point-of-u=
se (C99 style), which is acceptable per AGENTS.md. However, `void *result` =
is declared at function start while type-specific variables are inline=E2=
=80=94this mixing is fine but slightly inconsistent.

**2. Test Structure:**
The tests don't use `unit_test_suite_runner` infrastructure (they use direc=
t function calls in `test_ptr_add_sub()`). While functional, AGENTS.md sugg=
ests using `unit_test_suite_runner` for "proper integration with the DPDK t=
est framework." This is optional since `REGISTER_FAST_TEST` is used correct=
ly.

**3. Comment Placement:**
The implementation comment explaining Clang vs GCC behavior is placed betwe=
en the Doxygen comment and the macro. This works, but having implementation=
 notes inside a `/* ... */` block separate from Doxygen is good practice (w=
hich this patch does correctly).

---

### Summary

| Category | Status |
|----------|--------|
| Commit message format | =E2=9C=85 Pass (minor subject line concern) |
| SPDX/License | =E2=9C=85 Pass |
| Code style | =E2=9A=A0=EF=B8=8F Include order should be fixed |
| Tests | =E2=9C=85 Pass - comprehensive |
| Documentation | =E2=9A=A0=EF=B8=8F Consider release notes |
| Compilation | Should verify independently |

**Overall Assessment:** This is a well-crafted v8 patch with solid test cov=
erage and clear performance benefits. The main actionable items are fixing =
the include order and considering release notes for this optimization. The =
subject line concern about underscores is minor since `RTE_PTR_ADD/SUB` are=
 canonical macro names in DPDK.
