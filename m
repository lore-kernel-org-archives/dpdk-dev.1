Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B01CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 19:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92325402A2;
	Thu, 21 May 2026 21:48:56 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 262A6400D5
 for <dev@dpdk.org>; Thu, 21 May 2026 21:48:55 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-134fe980658so8404818c88.1
 for <dev@dpdk.org>; Thu, 21 May 2026 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779392934;
 x=1779997734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lACepZBTUC5lE6f1JOR7v4YtSb74afCvC5/Y3dVH6bs=;
 b=AJKjEtiBZAqEuvdnWrUB2tACJjkNb9IEdJdeNuSQKMEz3yLrNx5n2MS8ZzQq7EMLGO
 jfQmUP7ge+lNDsjcFX1N+jqf9szVMK7yOYnOCH6+0HSGDmiKGEY0Gqmct1EiEQS9zJIQ
 6sFfIqOx3x/OOkIHLTElEB/a886w2XauGFovNtFIPfIFGwH8KsiW4H08nRb6TGMs7uDb
 FyHpQBCDTt2QGM+d6qR5y9EUDaNk3bWsXZVV37PwyAKLQrbInAGfJk31KMqJgZGsNSdA
 RH0q/uov4sK6mfCfC501G8lMRh+RCUFU+koUiKEOPONTd59GJ/oXLe5J6hCPpQktyP2w
 XnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779392934; x=1779997734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lACepZBTUC5lE6f1JOR7v4YtSb74afCvC5/Y3dVH6bs=;
 b=oGst8UTEj+tlCmhDWEcYwRPmsXzbvdhg6DPYOcyyxSSbow7gjwecbOK1KUO7Nx4aEL
 vamBAze/dab1iwXqx+0EYsgzdaceaRvQDJG1OeTV4/q2LWsxAzlNb+b8DCRj7JeoxndF
 C8d/5f5Bi6tsX5i7cmfmiu0bazvPVoHzpuIlIKA4IbTi0n7qnerjVBIgXEmMizp2xsCR
 CSBFrNJi3+q4F01jjxEgMtzt7OmTD0UobJFWLpW+TkLcpjLMENwehyZMKcXK0jcgr6nL
 3x623fPTd/69de93Ezl5+9R4JxX5iVwYsbyRwP8WYyO7hsaPDyBNb6nfor49NE049+s3
 pJeg==
X-Gm-Message-State: AOJu0YxuSX/EgzX9OQB4G+ZmZ0dMDFs4tiQiwJjnHz9JFoqbnMV0hBt/
 fESsbFW55yZieQ96+NNFn7GAxyh/CyGArdZyFk7Zf2WCGQVeHIxmgSuEXmZdCg1Gapg=
X-Gm-Gg: Acq92OGmONBYlJQKZROFzVEesngXkXtlnVdAaOKFH9vaa51xb0aGRVVHc9Sc4WTsc7K
 B7qlvJ7s1ozJrl/UOKtjn6fPxz7X76yWdeN6jThNZuUYQpcy6/RH5ziCECTCDn33/y6AFViyftz
 viM9CQe6CL/Q0XamKdAwHnJiy4ATDy93dXGto2vMJWHiLU1hae0glIrkUoQqGOz5MrmpweNQm36
 uOzQGQN/NpGvQliY2A6NUcaz+YU8YLRpAtOqfnDGbfVhx49a1f1JtB4ocYId9N/X2m+j3L+P6QJ
 P5rwtiH4W+cNQYJ5dUp3hwN/K6MGjv7bNChocwDBopX+MvO5F48FuLLdroMVUB8a2rm1T3Rw3t5
 95zQjXivw4PHFYK2TdduosPY/8TSYe9y12BibXM+IwPG5h0716Gbg8RuP+IMVGH2wDpXJE+A3hh
 39DrDTBbpU+7WfNvMyhnzCLx28iqpXdPYIhGLppt6rP9Nl+bdSQhfaitq9PnzJL6kr4+zGpEPj8
 SFkOe1BP+3pdQ==
X-Received: by 2002:a05:7023:b8b:b0:135:262f:f6d5 with SMTP id
 a92af1059eb24-1365fc62225mr214014c88.40.1779392933698; 
 Thu, 21 May 2026 12:48:53 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13662755b25sm59542c88.9.2026.05.21.12.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 12:48:53 -0700 (PDT)
Date: Thu, 21 May 2026 12:48:48 -0700
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
Message-ID: <20260521124848.62b69a7e@phoenix.local>
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

Used this as test case for comparing AI reviews.

Anthropic saw:

## Warnings

### 1. Missing rte_mov48() test coverage

**Issue:** The patch adds a new `rte_mov48()` function but does not mention=
 adding tests for it.

**Why it matters:** New utility functions should have test coverage to veri=
fy correctness, especially for low-level copy operations that could silentl=
y corrupt data if implemented incorrectly.

**Suggested fix:** Add a test case in `app/test/test_memcpy.c` (or equivale=
nt) that verifies `rte_mov48()` copies 48 bytes correctly and preserves dat=
a beyond the copy range.

### 2. Documentation comment inconsistency

**Issue:** The main `rte_memcpy()` function description comment was removed=
 (lines 37-39 of original), but the opening documentation text about overla=
pping locations remains inconsistent across helper functions.

The original stated:
```c
/**
 * Copy bytes from one location to another. The locations must not overlap.
 *
 * @note This is implemented as a macro, so it's address should not be taken
 * and care is needed as parameter expressions may be evaluated multiple ti=
mes.
```

The new version removes the `@note` about macro implementation (which is co=
rrect since it's now a function), but does not update the main function com=
ment to include the same `@param` / `@return` documentation that other memo=
ry functions have.

**Suggested fix:** Add complete Doxygen documentation to `rte_memcpy()`:
```c
/**
 * Copy bytes from one location to another. The locations must not overlap.
 *
 * @param dst
 *   Pointer to the destination of the data.
 * @param src
 *   Pointer to the source data.
 * @param n
 *   Number of bytes to copy.
 * @return
 *   Pointer to the destination data.
 */
```

xAI (Grok) saw:
**Error**

- `rte_mov48()` implementation casts away `__rte_restrict` qualifiers (line=
s 137-140 and 143-147). =20
  Casting a restrict-qualified pointer to a non-restrict pointer is undefin=
ed behavior under the C standard and can break compiler alias analysis. =20
  Fix: either make the callees (`rte_mov32`/`rte_mov16`) accept the restric=
t qualifiers, or use a local non-restrict pointer only inside `rte_mov48` a=
fter proper validation.

**Error**

- Multiple functions (`rte_mov16`, `rte_mov32`, `rte_mov48`, `rte_mov64`, `=
rte_mov128`, `rte_mov256`, `rte_mov128blocks`, `rte_mov512blocks`, `rte_mem=
cpy_generic_more_than_64`, etc.) now take `uint8_t *__rte_restrict` paramet=
ers, but their callers inside the same file (e.g., the new `rte_memcpy` imp=
lementation and the various block-copy macros) pass `uint8_t *` without the=
 restrict qualifier. =20
  This creates implicit non-restrict paths that defeat the purpose of addin=
g `__rte_restrict` and may trigger compiler warnings or incorrect optimizat=
ions. =20
  Recommended fix: either propagate `__rte_restrict` consistently through a=
ll internal call sites or keep internal helpers non-restrict and only expos=
e restrict at the public `rte_memcpy` boundary.

**Warning**

- `rte_memcpy_generic_more_than_64` and `rte_memcpy_aligned_more_than_64` a=
re now the only implementations for >64-byte copies, but the old `rte_memcp=
y_generic` and `rte_memcpy_aligned` names have been removed. =20
  Any external code (or test) that took the address of the old functions wi=
ll break. =20
  The patch should either keep the old names as aliases or document the rem=
oval in release notes.

**Warning**

- The new `rte_memcpy` implementation for 17=E2=80=9364 bytes contains a co=
mpile-time constant check (`if (__rte_constant(n) && n =3D=3D 64)`) followe=
d by a fallback path that still executes `rte_mov16` three times for SSE wh=
en `n > 48`. =20
  This path is correct but duplicates logic that already exists in `rte_mov=
48`. =20
  Consider calling `rte_mov48` for the AVX case and a single `rte_mov48` + =
tail for SSE to reduce code duplication.

**Info**

- The removal of the `#pragma GCC diagnostic` block for `-Wstringop-overflo=
w` is correct per the patch description (drivers were updated). No further =
action needed.

**Info**

- All other style, API-tag, and documentation requirements appear satisfied=
. No additional correctness bugs (leaks, use-after-free, races, or forbidde=
n tokens) were identified.



