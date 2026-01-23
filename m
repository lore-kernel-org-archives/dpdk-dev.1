Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F4D6CFC6
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 05:22:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A2DE4021F;
	Fri, 23 Jan 2026 06:22:52 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 4FD4F400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 06:22:51 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so24589825e9.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 21:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769145771;
 x=1769750571; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YT+VDyfi/RprxuGowJQ/PAXo+Kd5ieXoPdjkdoDbFKQ=;
 b=qJurtGjMY9XrmX75RdRdku1DF35EHQfZQR+OtDaLMkQAk76GDe5PJ8dHmgCzKCsqGD
 Lar3U11jST79XcUjgp0avsfqZ72K+JRMFFsGJ2iHmZFOIrDWp513//MpR9z1wLmROb3E
 g0vCfkoxGekh9w1vIbWbmQt9kzs/lUbi4wVMt9/ss5nEeytapHO6O7omYZhzTopfmfAd
 Id/uAuXJ6Y5nfZONf90G8ihXl5MO4C05fRD2B0kw5KgSvA0MuuDTXiPRx9miFlLVj7Dh
 fViwaABYEXV9UvkgVw5PhAGlinCGyShN2YY44IVLKUJT36meSQC03lzhsewV4NaXXTAT
 Eh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769145771; x=1769750571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YT+VDyfi/RprxuGowJQ/PAXo+Kd5ieXoPdjkdoDbFKQ=;
 b=KJSm+zRR2TSLa6Eh3o5sOLW2KXo7W0mnP8DXnfGcrea/plA2kVTPo/sUcxVD7cxVDj
 Z5DZfnF2cBZFL31nEHUayZW2FpPNR43stgSUYFs7P1WzEPIyk08ZdUL8MceNZPAoxns1
 Gbdy7sSgt1Mys598wyF480uUZKsZlHQV5okYTxoby0hTWpBa+hlgM3VZR6y7oO8pR9Qh
 6sz4/QoxovB5hB8Wm3cYB/a1fm2Ij/OQG+aILn+rTTHc7LkYust/ubzyP6hVvqwnkc8K
 Y6Frpc8z5RASj4AHyINj/8Q9ClnQNDy2rD+VpIujmd4jmkQH6k+btfZF4DuqGdAOMu8u
 +HCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+77LhKmMStb58VFSrbzgZFS4kuxgFeVpjc0S3TV2n+XtwYyW3kilvfJ63XLGBsiPLnlo=@dpdk.org
X-Gm-Message-State: AOJu0YyJGyo+F4Mlz1VsnmWnQ8eF1Mtn/ZPZhPoOCRHX91AhY19NCDsj
 zC1elXKviU+ZgUTnQzw+7dh2UWsUP8BfCSN/tkQ9qUCvA+ZvPnQM3rgmz1CxtadMr3o=
X-Gm-Gg: AZuq6aITTPOFcizMIjisn+qXKLQmz9cWBc4HF5yq/gt9nl26zqSd/oJvxdd3hH8dtaS
 XvJR+Nscrr6SUgtT9zEvNfLIVWCp49P6zZQRnMfId61Qsb6FkZN/BhxlvOKlSb8fHpRZ0HhWX85
 xb7SE4ByhFqvmocoAsxiJOh5pJyfgE5ciuQ+4HyYifl7Lk3pZ9LEaYrGN1P71sVuk8ERVJeNA5v
 SX8uQK4R7WKfd6wNLPXnWJzHJVRh01VQVY5DXluhPZ7gFOA1+iq6hIq2w3iHTtR4iRqbZ7+ie99
 Z3aDcg1Etg5OZsy+cRqUzu84RC2rVQEN92GdXSo0VfLY/UzwqFX2aS7ywDt3HEvx5JKo39lRJOi
 k5Xth5V1TUDpDKTZ/UM+8AD+ILu27tQojnwneFNUS4qhd/rucYlMvBpN687sojF6TbaFo23CSfR
 WkhSESUQ/UkzLFDtJA1O0XfUbsNz51HeiJziSJudetAwsJX9A4vR2/
X-Received: by 2002:a05:600c:c174:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4804c95872emr30863645e9.10.1769145770806; 
 Thu, 22 Jan 2026 21:22:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c246ecsm3951700f8f.10.2026.01.22.21.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 21:22:50 -0800 (PST)
Date: Thu, 22 Jan 2026 21:22:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <jerinjacobk@gmail.com>, <mb@smartsharesystems.com>, <dev@dpdk.org>,
 <stable@dpdk.org>, <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 0/6] bpf: simple tests and fixes
Message-ID: <20260122212240.3ad5344d@phoenix.local>
In-Reply-To: <20251217180141.60227-1-marat.khalili@huawei.com>
References: <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251217180141.60227-1-marat.khalili@huawei.com>
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

On Wed, 17 Dec 2025 18:01:33 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Add simple unit-style tests for rte_bpf_load, and fix some minor
> discovered bugs.
>=20
> v3:
> * Fixed unfortunate typos in the last patch commit message.
> * Marked all ARM opcodes with UINT32_C for clarity as suggested by
>   Morten Br=C3=B8rup, in a separate commit.
>=20
> v2:
> * Moved new tests back into test_bpf.c
> * Changed library macros RTE_SHIFT_VALxx to handle variable first
>   arguments instead of introducing new macros.
> * Added another test and fix, for conditional jump as first instruction.
>=20
> Marat Khalili (6):
>   eal: variable first arguments of RTE_SHIFT_VALxx
>   bpf: fix signed shift overflows in ARM JIT
>   bpf: mark ARM opcodes with UINT32_C
>   bpf: disallow empty program
>   bpf: make add/subtract one program validate
>   bpf: fix BPF validation w/ conditional jump first
>=20
>  app/test/test_bpf.c          | 254 +++++++++++++++++++++++++++++++++++
>  lib/bpf/bpf_jit_arm64.c      | 184 ++++++++++++-------------
>  lib/bpf/bpf_load.c           |   2 +-
>  lib/bpf/bpf_validate.c       |  48 ++++---
>  lib/eal/include/rte_bitops.h |   4 +-
>  5 files changed, 375 insertions(+), 117 deletions(-)


AI patch review saw some really minor things.
These can be fixed by new version or by maintainer during merge.
It would be good to be consistent about Fixes and Cc: stable.

Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>

=3D=3D=3D Patch Review: bundle-1681-bpf-fixes.mbox (via Claude) =3D=3D=3D
# DPDK Patch Review: bundle-1681-bpf-fixes.mbox

## Overview
This patch series (6 patches) addresses BPF-related fixes including signed =
shift overflows in ARM JIT, validation improvements, and related EAL macro =
changes.

---

## Patch 1/6: eal: variable first arguments of RTE_SHIFT_VALxx

### Errors
None identified.

### Warnings

1. **Missing Cc: stable@dpdk.org in commit message body**
   - The patch CC's `stable@dpdk.org` in email headers but should include `=
Cc: stable@dpdk.org` in the commit message body if this is intended for sta=
ble backport.

### Info

1. **Good practice**: The parenthetical note about `uint_least64_t` vs `uin=
t64_t` is helpful context for reviewers.

2. **Change is appropriate**: Replacing `UINT32_C`/`UINT64_C` with casts al=
lows variable arguments while maintaining the intended type behavior.

---

## Patch 2/6: bpf: fix signed shift overflows in ARM JIT

### Errors
None identified.

### Warnings

1. **Missing Fixes: tag** - This patch fixes a bug (signed shift overflow c=
ausing undefined behavior). It should have a `Fixes:` tag with the 12-chara=
cter SHA of the commit that introduced the problematic code.
   ```
   Fixes: abcdef123456 ("bpf: add JIT support for arm64")
   ```

2. **Missing Cc: stable@dpdk.org in commit body** - If this is a bug fix in=
tended for stable releases, it should have `Cc: stable@dpdk.org` in the com=
mit message.

3. **Trailing whitespace in Acked-by tag** (line with `Acked-by: Konstantin=
 Ananyev`):
   ```
   Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20
   ```
   There appears to be a trailing space after the closing `>`.

### Info

1. **Good use of RTE macros**: Using `RTE_BIT32()` and `RTE_SHIFT_VAL32()` =
is the correct approach to avoid signed integer overflow UB.

2. **Dependency**: This patch depends on Patch 1/6 for `RTE_SHIFT_VAL32` to=
 accept non-constant arguments.

---

## Patch 3/6: bpf: mark ARM opcodes with UINT32_C

### Errors
None identified.

### Warnings

1. **Missing Cc: stable@dpdk.org** - Similar to patch 2, if this is fixing =
potential issues, it may warrant stable backport consideration.

### Info

1. **Good practice**: Explicitly marking opcode constants with `UINT32_C()`=
 clarifies intent and ensures consistent unsigned 32-bit operations.

2. **Minor style observation**: The parentheses around macro definitions li=
ke `#define A64_CMP (UINT32_C(0x6b00000f))` are good defensive practice.

---

## Patch 4/6: bpf: disallow empty program

### Errors
None identified.

### Warnings

1. **Missing Fixes: tag** - The commit message mentions fixing bugs:
   > Fix found bugs:
   > * a program with no instructions was accepted;
   > * a program with no EXIT instruction read outside the buffer.
  =20
   These should have corresponding `Fixes:` tags.

2. **Missing Cc: stable@dpdk.org** - Bug fixes should typically be consider=
ed for stable backport.

3. **Brace style inconsistency** (app/test/test_bpf.c, line 90-93):
   ```c
   if (expected_errno !=3D 0) {
           ...
   } else
           RTE_TEST_ASSERT_NOT_EQUAL(...);
   ```
   While this follows DPDK style for single-statement else, the asymmetry w=
ith the braced if-block could be considered less readable.

### Info

1. **Good test coverage**: Adding tests for edge cases (empty program, EXIT=
-only, no-EXIT, minimal valid) is excellent practice.

2. **Use of RTE_TEST_ASSERT macros**: Good use of the test framework macros.

3. **Comment style**: The function-level comments are well-written and foll=
ow proper multi-line comment format.

---

## Patch 5/6: bpf: make add/subtract one program validate

### Errors
None identified.

### Warnings

1. **Missing Fixes: tag** - This fixes signed integer overflow UB in `bpf_v=
alidate.c`. Should include:
   ```
   Fixes: <sha> ("original commit that introduced the bug")
   ```

2. **Missing Cc: stable@dpdk.org** - Bug fix should be considered for stabl=
e.

### Info

1. **Correct fix approach**: Casting to `uint64_t` before arithmetic is the=
 right way to handle potential signed overflow when the result will be mask=
ed anyway.

2. **Good test additions**: Tests for add/subtract operations validate the =
fix works correctly.

---

## Patch 6/6: bpf: fix BPF validation w/ conditional jump first

### Errors
None identified.

### Warnings

1. **Trailing whitespace in Tested-by tag**:
   ```
   Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20
   ```
   There appears to be trailing space after `>`.

2. **Subject line could be clearer** - "fix BPF validation w/ conditional j=
ump first" is somewhat abbreviated. Consider:
   ```
   bpf: fix validation when conditional jump is first instruction
   ```

### Info

1. **Good Fixes: tag present**: `Fixes: 6e12ec4c4d6d ("bpf: add more checks=
")` - properly formatted.

2. **Excellent commit message**: Clear explanation of the bug (zero index u=
sed as sentinel), the root cause, and the fix approach.

3. **Good test coverage**: Two tests demonstrating the issue - one with jum=
p as first instruction, one with jump as non-first instruction to prevent r=
egression.

4. **Code change is sound**: Switching from index-based to pointer-based tr=
acking for `prev_node` is cleaner and avoids the zero-sentinel problem.

---

## Summary

| Patch | Errors | Warnings | Info |
|-------|--------|----------|------|
| 1/6 (eal) | 0 | 1 | 2 |
| 2/6 (bpf ARM) | 0 | 3 | 2 |
| 3/6 (bpf opcodes) | 0 | 1 | 2 |
| 4/6 (bpf empty) | 0 | 3 | 3 |
| 5/6 (bpf add/sub) | 0 | 2 | 2 |
| 6/6 (bpf jump) | 0 | 2 | 4 |

### Key Issues to Address

1. **Missing Fixes: tags** on patches 2, 3, 4, and 5 - these are bug fixes =
and should reference the original commits.

2. **Missing Cc: stable@dpdk.org** in commit message bodies for bug fix pat=
ches.

3. **Trailing whitespace** in Acked-by/Tested-by lines on patches 2 and 6.

### Positive Aspects

- Good use of DPDK macros (`RTE_BIT32`, `RTE_SHIFT_VAL32`, `UINT32_C`)
- Comprehensive test additions using proper test framework
- Clear commit messages explaining the issues and fixes
- Proper patch ordering (dependencies handled correctly)
- License/copyright compliance (no changes needed)
- Code follows DPDK style guidelines

