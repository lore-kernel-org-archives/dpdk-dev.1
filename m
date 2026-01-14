Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E3BD39013
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 19:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC497402E1;
	Wed, 14 Jan 2026 20:50:23 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 34C404027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 20:50:22 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64baaa754c6so190087a12.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 11:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768420222;
 x=1769025022; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPt1O455BxpY+rdEhCQ+pDxb6tvuB03OQGCUVzZY6Qc=;
 b=hLCGp7f2TTuYzqM8S4CncGJZGBfL2kl2fP3QwHCgZz/RDQoFSHZDu9EqrLJkKa1yku
 QPqFADZ6WUYa4EpHxe++taJ+Su9eMXmrY83UM0Rf0wBMtIkTSvPX9kQbwdvU1JFxyicc
 u7e3pJCmh8U5SCh1NSQNZiIJxlAbtzavRCGH4SoDQMTJQzM6CNLPq+qjlK5zrPWDXcph
 vpVw727ZTuIRUqUo9lzGzg8NrsaM0mJoUgFTJmXtrbIpKj9ZpMIIGicL/FxoEir8Gz5y
 r7lUWhqR4uqCeoZhSuP9sHb0jvHZ+gvLchfUOl9bQ4RAq/pWOkTUmUCR1uZj0qO08V2Q
 9a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768420222; x=1769025022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lPt1O455BxpY+rdEhCQ+pDxb6tvuB03OQGCUVzZY6Qc=;
 b=u8WS3HA0yoL5PoOhpfbdEVrF+vlUJRckw+TVPwdlYbg0GfAD5a1r45XH/4CooC33M1
 PhYWhlJ2dzFOErk2hwJlpP6teKq33S2RB9rAa/rnLDtLYG6Sf5bqCyEUJO1CrU4htVHy
 tZXrPx8aht1bSGBqOpdogqRVoZeHWkeLEsH7kDeIHv8756DW74bGpy15U70GA6VEVWiG
 S5bZsjC1qU1BOpxswRbqOfj/FZIlDyK0rDLAn3e0L/B7D2qrKtsQm8Fv+o8a/OdhV/uY
 jCy5zkE0bBFfreCFwGewWSSu2XYfvruquJsc4kD+eC91qXp6vRyU0zYVWlQ8pFIuP8tP
 ziYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIvtfOBI9UmUUut3LhcgENRNl6gKhr+429sTIYEs/DEJuu6w3GKK+3zdzGJDPjpMxb154=@dpdk.org
X-Gm-Message-State: AOJu0YxgeMdFskOJ82AhGXn39MHvE3hUpcaQ8Q5biJ/ZUbNILv43bLwG
 m4vAMWSsfI7hNFgyZY+T+VlA9sXBEEjGQa7n7De8gpqF59MdRqf71vBwoupuhqPsLPM=
X-Gm-Gg: AY/fxX4P06PJVdBGJJsezQcj7sJCd/UbeD8PsBG0HnXKs5se6Pue8n9XqThA5rs06Zr
 iEUQdI6NKk9sCqdPiUDP2tZrlMG9qvJXgfPKQtNMh03lXI4lFJ/DfX+ZVnOktHf1oVpmhxRXIA1
 Poi5wcZv54ZdGFF2UzN/wa7UHVj9yrLs71QjzofHUGhZfR4BJ1iGYek8tDHXWMXZ1/ebfxzVXbR
 BOzVzFYuMVYjCKGOJ7mdq9BmUHE2xCsKHl23ffdOSce5JcANg9gGeOqzZpEwZ2KRbE5yaOLoUi7
 lqynyw37inQ/fnP999gBi2tAPI9++wbzrDGBxnSdCKVO8FN+nbhWEU9/7n8npSpVakFNAuLbKY/
 8pa1PdnMdxskNDmgR+dG5uv4SywwFsmUqhaqBkBlAciT8SU7CQs86z0IX4aflB62I8yAExOsnpx
 FE8aus9gOPEjAngFwtlfpI0LQczWjPzchyKQ2mdkcSgVexfGoPrctQ
X-Received: by 2002:a05:6402:26d1:b0:64b:8e19:6f61 with SMTP id
 4fb4d7f45d1cf-653ec117fb3mr3078975a12.11.1768420221665; 
 Wed, 14 Jan 2026 11:50:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65411f70f66sm428917a12.19.2026.01.14.11.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:50:21 -0800 (PST)
Date: Wed, 14 Jan 2026 11:50:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <jerinjacobk@gmail.com>, <mb@smartsharesystems.com>, <dev@dpdk.org>,
 <stable@dpdk.org>, <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v3 0/6] bpf: simple tests and fixes
Message-ID: <20260114115014.758158f1@phoenix.local>
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
>=20

AI review of this patch series identified some minor things.
They could either be addressed by Thomas during merge or you could send a n=
ew version.


## DPDK BPF Test Patchset Review (v3, 6 patches)

**Submitter:** Marat Khalili <marat.khalili@huawei.com> =20
**Series overview:** Fixes various issues in the BPF library including sani=
tizer-detected undefined behaviors (signed shift overflows, integer overflo=
ws), validation bugs, and adds comprehensive test coverage.

---

### Patch 1/6: `eal: variable first arguments of RTE_SHIFT_VALxx`

**Subject line:** =E2=9C=85 48 characters, correct format, lowercase

**Commit message:**
- =E2=9C=85 Signed-off-by present
- =E2=9C=85 Reviewed-by and Acked-by present
- =E2=9C=85 Good explanation of the change and rationale
- =E2=9A=A0=EF=B8=8F **Warning:** Missing `Cc: stable@dpdk.org` - this chan=
ges the behavior of public macros

**Code changes:**
```c
-#define RTE_SHIFT_VAL32(val, nr) (UINT32_C(val) << (nr))
+#define RTE_SHIFT_VAL32(val, nr) ((uint32_t)(val) << (nr))
```
- =E2=9C=85 Clean, minimal change
- =E2=9C=85 Allows variables as arguments (enables patch 2)

**Verdict:** Acceptable. Consider adding `Cc: stable@dpdk.org` if this fixe=
s user-visible limitations.

---

### Patch 2/6: `bpf: fix signed shift overflows in ARM JIT`

**Subject line:** =E2=9C=85 41 characters, correct format

**Commit message:**
- =E2=9C=85 Signed-off-by present
- =E2=9C=85 Acked-by present
- =E2=9C=85 Cc: stable@dpdk.org included
- =E2=9A=A0=EF=B8=8F **Warning:** Missing `Fixes:` tag - sanitizer errors i=
ndicate this is a regression/bug
- =E2=9D=8C **Error:** Trailing whitespace on line 176: `Acked-by: Konstant=
in Ananyev <konstantin.ananyev@huawei.com> ` (space before `---`)

**Code review:**
- =E2=9C=85 Comprehensive fix for UBSan-detected issues
- =E2=9C=85 Correct use of `RTE_BIT32()` and `RTE_SHIFT_VAL32()` macros
- =E2=84=B9=EF=B8=8F **Info:** Some shifts are no-ops (e.g., `RTE_SHIFT_VAL=
32(0, 30)` =3D 0) but kept for consistency - acceptable

**Verdict:** Fix the trailing whitespace error. Should add `Fixes:` tag ide=
ntifying when the UB was introduced.

---

### Patch 3/6: `bpf: mark ARM opcodes with UINT32_C`

**Subject line:** =E2=9C=85 35 characters, correct format

**Commit message:**
- =E2=9C=85 Signed-off-by present
- =E2=9C=85 Acked-by present
- =E2=9A=A0=EF=B8=8F **Warning:** Has `Cc: stable@dpdk.org` but this is a s=
tyle/clarity change, not a bug fix. Consider removing unless there's a func=
tional issue.

**Code changes:**
```c
-#define A64_INVALID_OP_CODE	(0xffffffff)
+#define A64_INVALID_OP_CODE	(UINT32_C(0xffffffff))
```
- =E2=9C=85 Consistent use of UINT32_C for ARM opcode constants
- =E2=9C=85 Improves code clarity about integer types

**Verdict:** Good cleanup. Questionable whether `Cc: stable@dpdk.org` is ap=
propriate for a style change.

---

### Patch 4/6: `bpf: disallow empty program`

**Subject line:** =E2=9C=85 26 characters, correct format

**Commit message:**
- =E2=9C=85 Signed-off-by present
- =E2=9C=85 Acked-by present
- =E2=9C=85 Cc: stable@dpdk.org included (appropriate for bug fixes)
- =E2=9A=A0=EF=B8=8F **Warning:** Missing `Fixes:` tag - this fixes actual =
bugs (empty program accepted, buffer over-read)

**Code review:**
- =E2=9C=85 `bpf_load_test()` helper function is well-documented
- =E2=9C=85 Good test coverage for edge cases
- =E2=9C=85 Boundary check fix: `nidx > bvf->prm->nb_ins` =E2=86=92 `nidx >=
=3D bvf->prm->nb_ins` (correct)
- =E2=9C=85 Empty program check added to `validate()`
- =E2=9C=85 Loop changed from `while` to `do-while` with assertion - good d=
efensive coding

**Minor observations:**
- Line 817-818: Brace style `} else` without braces on else is inconsistent=
 but acceptable per DPDK style

**Verdict:** Good patch. Add `Fixes:` tag to identify when these bugs were =
introduced.

---

### Patch 5/6: `bpf: make add/subtract one program validate`

**Subject line:** =E2=9C=85 42 characters, correct format

**Commit message:**
- =E2=9C=85 Signed-off-by present
- =E2=9C=85 Acked-by present
- =E2=9C=85 Cc: stable@dpdk.org included
- =E2=9C=85 Good documentation of the UBSan errors being fixed
- =E2=9A=A0=EF=B8=8F **Warning:** Missing `Fixes:` tag - this fixes signed =
integer overflow UB

**Code review:**
```c
-	rv.s.min =3D (rd->s.min + rs->s.min) & msk;
+	rv.s.min =3D ((uint64_t)rd->s.min + (uint64_t)rs->s.min) & msk;
```
- =E2=9C=85 Minimal fix for UB by casting to unsigned before arithmetic
- =E2=9C=85 Tests correctly exercise the boundary conditions

**Verdict:** Good minimal fix. Add `Fixes:` tag.

---

### Patch 6/6: `bpf: fix BPF validation w/ conditional jump first`

**Subject line:** =E2=9C=85 48 characters, correct format

**Commit message:**
- =E2=9C=85 Signed-off-by present
- =E2=9C=85 Acked-by and Tested-by present
- =E2=9C=85 Cc: stable@dpdk.org present (from CC header)
- =E2=9C=85 **Correct `Fixes:` tag:** `Fixes: 6e12ec4c4d6d ("bpf: add more =
checks")`
- =E2=9C=85 Excellent description of the root cause and fix

**Code review:**
```c
-	uint32_t prev_node;
+	struct inst_node *prev_node;
```
- =E2=9C=85 Clean refactoring from index to pointer for prev_node tracking
- =E2=9C=85 Fixes the bug where index 0 was used as termination signal
- =E2=9C=85 Two tests covering the exact bug scenario (first vs non-first i=
nstruction)
- =E2=9C=85 `get_prev_node()` function removed as it's no longer needed

**Verdict:** Excellent patch. Good fix with proper testing and documentatio=
n.

---

## Summary

| Patch | Status | Action Required |
|-------|--------|-----------------|
| 1/6 | =E2=9A=A0=EF=B8=8F | Consider adding `Cc: stable@dpdk.org` |
| 2/6 | =E2=9D=8C | Fix trailing whitespace; add `Fixes:` tag |
| 3/6 | =E2=9A=A0=EF=B8=8F | Consider removing `Cc: stable@dpdk.org` (style=
 change) |
| 4/6 | =E2=9A=A0=EF=B8=8F | Add `Fixes:` tag |
| 5/6 | =E2=9A=A0=EF=B8=8F | Add `Fixes:` tag |
| 6/6 | =E2=9C=85 | Ready |

### Required Fixes (Errors)

1. **Patch 2/6, line 176:** Remove trailing whitespace after `konstantin.an=
anyev@huawei.com`

### Recommended Improvements (Warnings)

1. **Patches 2, 4, 5:** Add `Fixes:` tags to identify the commits that intr=
oduced the bugs
2. **Patch 3:** Reconsider `Cc: stable@dpdk.org` - UINT32_C annotation is a=
 style improvement, not a bug fix

### Overall Assessment

This is a high-quality patch series that fixes real bugs (UB detected by sa=
nitizers, validation logic errors) and adds valuable test coverage. The cod=
e changes are well-reasoned and minimal. The series structure properly sepa=
rates enabling changes (patch 1) from fixes (patches 2-6).

**Recommendation:** After fixing the trailing whitespace in patch 2 and add=
ing missing `Fixes:` tags, this series should be ready for merge.
