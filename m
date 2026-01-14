Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE6D31A09
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 04:59:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD3F14028F;
	Wed, 14 Jan 2026 05:59:40 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id 3559C40289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 05:59:39 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-477bf34f5f5so66471645e9.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768366778;
 x=1768971578; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrN4xZ23pqSjptLNsw8z3KsrYeJrE5Je4wo8bRJk+Js=;
 b=jLnBPQBD1c37jUMx9zw1N1Zkl8qemeqALCq9WU3UZdO01OkCFcW8x6hEs4UvJtqKq3
 +vtnBRyR01wfeOgzzf3h+p5cPhBz6BniVivO3Y+ZoewfzNUAy0rP2+nFx2JZ7xa/9yAl
 VX27XLUciNeuXVrgF1sUCUj3XvEJG/TG0In9wGo4RHDdIVXFySXB8/WvRsY+ynILHdLr
 yijczJNnH2n0N4mz704LtnIt1semhQh3QRGk6Pga6X808WqNBo2Jm86ZmtqxMzJrVwbE
 xL7c8pNXX7KKYnc0h+vUJGRGnXYymdZPFEnkdp/5VCBEDs0rPOvhN+rm7iPuYAgpDFd8
 OTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366778; x=1768971578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BrN4xZ23pqSjptLNsw8z3KsrYeJrE5Je4wo8bRJk+Js=;
 b=ngATJyjyjdiNwWusS6xD9XrZh7U6xMnPhK22Bai7y58L6qGKBtS8IKVbdanue7yeCH
 s9e95+E2wbWbscYZu+m115/FszonG6PynW3FgS3YUjvcpwUtIfbArmY+ecii71ZIi5ql
 FPba2U3rR7rAiJtX+jm2U0iYHSAjK5S8UYhW8rXOGrTOoyfJeObTX3WhXUMOM5h10tjB
 XzTxKZG4MNdR14MmGl0SlRaaxU+tphxMxwtqX6omhY5Lh2N7fuUMFHAFi9GQv+Oadbgr
 y11mNEefWkvK3si+YYqEWq7jsugWsFkI3YOhA+BpW2fyFqpzGmlZzbJz40jfxVyvwCSZ
 4ylQ==
X-Gm-Message-State: AOJu0Yzun58f6rE3g/LnYmh4kEqOff9b/AXnXYltrdsR1YR1Cq/LhKVX
 vLWzgdraWgUQUo6t7bE/0y2vZQ1zby6jqHe05WVGDw5P25SZdhEPnqBCkd7cpoOEek0=
X-Gm-Gg: AY/fxX6FztP5Ge/Z9e6qGf6wq1xkdWk71ksGE75WMmdFFKAwsLo+zp4TzMNSjbJXk92
 uIp3RyjGJL2N02ElMzoE9aW7kIrN/OXnHg/9TDNJdJkXtecJvTGluJ31zYnfxVFbsMTog6olyK9
 ZGJLUPNVr0aWILyzto7GHG2EFaes1Lr0vVi5juaEIsHpcJo7lxNGpIgZGkLu8luTTM9pBX+/wCP
 Si0A1Mx1I8TC0Rnp2eLMhQ1DMEiAvu2XUZpA5gSr8V7HSv25hy8aZEJzFjpqo21hZc3VUqwShdX
 n6/zxHH4m6Tl8gVj5fPEGoUr9cYRzUJb48Vx9B85V2XwwUgV3AxnikuxZ8AZ9Vm5AS14IaSABEV
 yzd3uU/l6Ar9lZhMnDs5QgNe4fAQYODKaXvJzwi26URDavZjAQyBCgyHNSA0ARoO40VAToZR/Ls
 mk9ze8WWgjfOs7E6w2T2knva2v12MDNeCQv8odgNBP48dznx09CSBC
X-Received: by 2002:a05:600d:6450:10b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-47ee3371a2amr10649865e9.24.1768366778178; 
 Tue, 13 Jan 2026 20:59:38 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee27ee45bsm12442645e9.7.2026.01.13.20.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:59:37 -0800 (PST)
Date: Tue, 13 Jan 2026 20:59:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alex Kiselev <alex@bisonrouter.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, vladimir.medvedkin@intel.com
Subject: Re: [PATCH] lpm: add new LPM v6 implementation (lpm6c)
Message-ID: <20260113205925.7afb7fc0@phoenix.local>
In-Reply-To: <20251103132433.38627-1-alex@bisonrouter.com>
References: <20251103132433.38627-1-alex@bisonrouter.com>
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

On Mon,  3 Nov 2025 14:24:33 +0100
Alex Kiselev <alex@bisonrouter.com> wrote:

> lpm6c is a new implementation of the IPv6 LPM algorithm, based on
> the existing lpm module. It utilizes a trie path compression technique to
> optimize lookup operations.
>=20
> The implementation offers a performance improvement over the lpm
> module starting from /64 and longer prefixes. This makes it beneficial
> for use cases like BNG routers, whose FIB tables contain numerous /64
> prefixes and primarily handle traffic targeting them.
>=20
> Performance comparison results against the original LPM6 for lookups
> at AMD Ryzen 9 5900XT CPU:
>=20
> prefix /48 tests:
> Speedup vs LPM6: LPM6c 0.991x, LPM6c VEC 0.921x, FIB 1.000x, FIB VEC 1.04=
8x
>=20
> prefix /64 tests:
> Speedup vs LPM6: LPM6c 1.399x, LPM6c VEC 1.302x, FIB 1.145x, FIB VEC 1.29=
2x
>=20
> prefix /80 tests:
> Speedup vs LPM6: LPM6c 1.620x, LPM6c VEC 1.558x, FIB 1.096x, FIB VEC 1.22=
6x
>=20
> prefix /128 tests:
> Speedup vs LPM6: LPM6c 2.497x, LPM6c VEC 2.369x, FIB 1.255x, FIB VEC 1.34=
9x
>=20
> Signed-off-by: Alex Kiselev <alex@bisonrouter.com>
> ---

AI code review against AGENTS.md


## DPDK Patch Review: lpm: add new LPM v6 implementation (lpm6c)

### Summary
This patch adds a new path-compressed IPv6 LPM implementation with compelli=
ng performance improvements for /64+ prefixes. However, there are several c=
ompliance issues that need to be addressed before this can be merged.

---

### Errors (Must Fix)

**1. SPDX License Format Issues**

Multiple files have the SPDX identifier on line 2 instead of line 1:

- `lib/lpm/rte_lpm6c.c` (lines 2498-2501):
  ```c
  /*
   * SPDX-License-Identifier: BSD-3-Clause    =E2=86=90 Wrong: SPDX on line=
 2
  ```

- `lib/lpm/rte_lpm6c.h` (lines 3824-3827): Same issue

- `app/test/test_lpm6c_perf.c` (lines 1901-1904): Same issue =20

- `app/test/test_lpm6c_perf_cmp.c` (lines 2068-2071): Same issue

Should be:
```c
/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(c) 2016-2025 Alex Kiselev, alex at BisonRouter.com
 */
```

**2. Missing Blank Line After Copyright**

All new files are missing the required blank line between the copyright blo=
ck and the first `#include`:

Example from `rte_lpm6c.c`:
```c
 */
#include <string.h>   =E2=86=90 Should have blank line before this
```

**3. Missing `__rte_experimental` Markers**

New APIs must be marked as `__rte_experimental`. None of the public functio=
ns in `rte_lpm6c.h` have this marker:

```c
/* Should be: */
__rte_experimental
struct rte_lpm6c *
rte_lpm6c_create(const char *name, int socket_id,
        const struct rte_lpm6c_config *config);
```

This applies to all public functions: `rte_lpm6c_create`, `rte_lpm6c_find_e=
xisting`, `rte_lpm6c_free`, `rte_lpm6c_add`, `rte_lpm6c_delete`, `rte_lpm6c=
_delete_all`, `rte_lpm6c_lookup`, `rte_lpm6c_lookup_bulk`, etc.

**4. Include Order Violation**

In `rte_lpm6c.c`, system header `<assert.h>` appears after DPDK headers:
```c
#include <rte_rwlock.h>
#include <rte_spinlock.h>
#include <rte_hash.h>
#include <assert.h>        =E2=86=90 System header after DPDK headers
#include <rte_jhash.h>
```

System headers must come before DPDK headers.

---

### Warnings (Should Fix)

**1. Missing Release Notes**

This is a significant new feature (new LPM6 algorithm) and requires an entr=
y in `doc/guides/rel_notes/release_XX_XX.rst`. Per guidelines: "New drivers=
 or subsystems must have release notes."

**2. Missing MAINTAINERS Update**

No update to the `MAINTAINERS` file to add ownership of the new `lpm6c` com=
ponent.

**3. Missing Doxygen Documentation**

Several public functions lack Doxygen comments:
- `rte_lpm6c_rules_iterate()` (line 4124)
- `rte_lpm6c_rules_iterate_cb()` (line 4129) =20
- `rte_lpm6c_pool_pos()` (line 4376)
- `rte_lpm6c_used_rules()` (line 4379)

**4. Inconsistent Copyright Format**

`test_lpm6c_perf_cmp.c` has inconsistent copyright:
```c
Copyright(c) 2016-2025 Alex Kiselev BisonRouter.com
```
vs other files:
```c
Copyright(c) 2016-2025 Alex Kiselev, alex at BisonRouter.com
```

**5. Use of `assert()` Instead of RTE Equivalents**

Multiple uses of standard `assert()` in `rte_lpm6c.c` (lines 3564, 3569, 36=
01, 3609, 3680, 3694-3698). Consider using `RTE_ASSERT()` or proper error h=
andling for production code.

**6. Test Registration Style**

The patch uses `REGISTER_FAST_TEST` and `REGISTER_PERF_TEST`. Verify these =
are the current preferred macros vs. the older `REGISTER_TEST_COMMAND`.

---

### Info (Consider)

**1. Struct Alignment Syntax**

The pattern used:
```c
struct rte_lpm6c_tbl8 {
    ...
}
__rte_cache_aligned;
```
While this compiles, the more common DPDK style is:
```c
struct __rte_cache_aligned rte_lpm6c_tbl8 {
    ...
};
```

**2. Public Structure Exposure**

The full `struct rte_lpm6c` is exposed in the public header (necessary for =
inline lookup functions). This is a design tradeoff=E2=80=94consider docume=
nting that the struct layout is not ABI-stable while experimental.

**3. Performance Benchmarks**

The commit message includes good performance data. Consider adding this to =
documentation as well.

---

### Checklist Summary

| Category | Status |
|----------|--------|
| Subject line =E2=89=A460 chars | =E2=9C=93 |
| Correct component prefix (`lpm:`) | =E2=9C=93 |
| Signed-off-by present | =E2=9C=93 |
| SPDX on first line | =E2=9C=97 |
| Blank line after copyright | =E2=9C=97 |
| `__rte_experimental` on new APIs | =E2=9C=97 |
| Include order correct | =E2=9C=97 |
| Release notes updated | =E2=9C=97 |
| MAINTAINERS updated | =E2=9C=97 |
| Tests provided | =E2=9C=93 |
| Doxygen documentation | Partial |

---

### Verdict

**Needs revision.** The algorithm and implementation look solid with good t=
est coverage and compelling performance numbers. However, there are mandato=
ry compliance issues (SPDX format, missing experimental markers, include or=
der) that must be fixed before this can be accepted. A v2 addressing the er=
rors above would be welcome.
