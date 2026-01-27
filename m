Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D13D2F034
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 14:02:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4988B40E0C;
	Tue, 27 Jan 2026 15:02:55 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 1F74A40297
 for <dev@dpdk.org>; Tue, 27 Jan 2026 15:02:54 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so47903895e9.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 06:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769522573;
 x=1770127373; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+US6WMcrhdhQWYbXVDbNThx1gr1QYL0bwTq3kYXEqKY=;
 b=2qNcwTGOmzcgVotRB2NsHETlNHOK6Ym/qU/OXMVvIOuIC15j5GIYXJIJ1o788f9aZG
 mGyov4ztxxw+L31VFGqE0SlCEyIVbuN1G0n0g8VG4mq/W0eV+nd2xAZ5qJKUwMcZEsqk
 HmPsps3SMq2uUrZnpi8CDzRUEQLwxVv6MTUq3Pq76ABelaqSUzrd9xqrDj/84I0Oepyk
 6aqcq8XqUUYSTLyX8sciPVD+ib3V+NdnPn19sKRwJic05QRQ06cK0NLAHkVFtaJK8EhP
 v/oYYZDT8jmnl4EfIxBT/g3fPNVMDwN7RJw80r9oUBEoDXSsp6C5HRMyVjHspb+qlbKj
 bCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769522573; x=1770127373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+US6WMcrhdhQWYbXVDbNThx1gr1QYL0bwTq3kYXEqKY=;
 b=qfbnWyZLc/zG/2JepDkUNsALR1dZ5B6XNwwRfdxLt+MmweS4qf975ir/g/KLZqLb+H
 u0aG8lpCXU9ukzCyqf9BsjTaPFA3PTIgxMPtBHY3xgXrB3zzr8BoLDgVkHT7TgXqTmRc
 fxxtLJlzhWLvwqQHGPSVBeJioPxOeas6vPJ3FtjKBuC9HgaYUbe9Q3KMD5ZGsMyJmE2i
 Kietah1zAPxef/V5CfTv7VCjJjvEp+pQP83FvJp7V1OMIzzxlJa/BGwY5FHBtvaZgna0
 0n4R6ZpZyDdArx7K0J90ec2JJYkxolKbxbHW8tAVHz6JEMqAmzQ/Yd5Q7r0vY+JZxXGa
 1xlA==
X-Gm-Message-State: AOJu0YzxIJl1vaz3cbmb2oDFKoDbPtx9Ub8pfEnlkoVl5OVaQVgXsELp
 SUfePqCwjRgXC8Gmm8NU8SQM9+39OFxfMNEeJmqusAjITjeew3I4b8qNz9tdNjYxmi8=
X-Gm-Gg: AZuq6aJMLYOTCY8aTEnEFQO384PXC2AWAcjEgBuEIkbCRptjRNUqYiuYY6K3iGca9Sa
 bE9S68zeuklBm5PqMA+pQ5pBt9cZrKfHzFLZpXykV2daQGEFQJwhZvnjyEFbee+VYBYGKlw4vsg
 qsw3/YrmM/z5KBMXfXuJvNPcLaaB7/LVd2jbYbasRkEDA4vCzi4RBcXNi9RlGtl9ZYGZYsRpedb
 Z+HqHKrl/oKNT669grgPAnGOKb5EZ4UMj1xpVrD3LzH0y4eutGsJvzDnuuntNV4Bmr1bZZ7pBBc
 ivN5Z6cywCzVXiWq9LavpGdKdtNEOpPOL9JeNEP5F0X3N97QrljVosjJmzPZg1IIPUqnJRKRj0H
 m4CCWX+2iKn4BMHUAvGpwVAh2DsinNXyoi3tPw9dj2ELxENQoQWGly82TUBv3lLnrwcaGINe6cY
 Au5p8YX24xh6t9qS6FgcRiR47eKH5q6FGkBwKimK4/MZQ8eXdMaXxX
X-Received: by 2002:a05:600c:4689:b0:480:6941:d38b with SMTP id
 5b1f17b1804b1-48069c92bd8mr24918825e9.30.1769522573268; 
 Tue, 27 Jan 2026 06:02:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24bf8sm37612360f8f.11.2026.01.27.06.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:02:52 -0800 (PST)
Date: Tue, 27 Jan 2026 06:02:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <dev@dpdk.org>, <jerinjacobk@gmail.com>,
 <konstantin.ananyev@huawei.com>, <mb@smartsharesystems.com>
Subject: Re: [PATCH v4 0/6] bpf: simple tests and fixes
Message-ID: <20260127060244.46b2cee6@phoenix.local>
In-Reply-To: <20260127114944.35993-1-marat.khalili@huawei.com>
References: <20251217180141.60227-1-marat.khalili@huawei.com>
 <20260127114944.35993-1-marat.khalili@huawei.com>
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

On Tue, 27 Jan 2026 11:49:36 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Add simple unit-style tests for rte_bpf_load, and fix some minor
> discovered bugs.
>=20
> v4:
> * Add Fixes: and Cc: stable@dpdk.org tags to all patches except 3. Try
>   to make sure stable@dpdk.org does not receive patch 3.
> * Ensure no (possibly hallucinated) trailing whitespace after Acked-by.
> * Improve subject line for the "conditional jump first" patch.
> * Update REGISTER_FAST_TEST() calls in app/test/test_bpf.c to use new
>   constants (NOHUGE_OK, ASAN_OK) instead of old boolean values.
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
>   bpf: fix validation when conditional jump is first instruction
>=20
>  app/test/test_bpf.c          | 254 +++++++++++++++++++++++++++++++++++
>  lib/bpf/bpf_jit_arm64.c      | 184 ++++++++++++-------------
>  lib/bpf/bpf_load.c           |   2 +-
>  lib/bpf/bpf_validate.c       |  48 ++++---
>  lib/eal/include/rte_bitops.h |   4 +-
>  5 files changed, 375 insertions(+), 117 deletions(-)
>=20

This is what an automated review looks like when everything is good:

# DPDK BPF Patch Series Review (6 patches, v4)

**Author:** Marat Khalili =20
**Series:** BPF fixes addressing sanitizer-detected issues and validation b=
ugs

## Summary

| Severity | Count |
|----------|-------|
| Error    | 0     |
| Warning  | 0     |
| Info     | 2     |

**Overall Assessment:** This is a well-crafted patch series. All patches fo=
llow DPDK guidelines correctly with proper commit message formatting, appro=
priate Fixes/Cc:stable tags, and good test coverage.

---

## Patch 1/6: eal: variable first arguments of RTE_SHIFT_VALxx
**Status:** =E2=9C=93 OK

Good fix to allow variable arguments in `RTE_SHIFT_VAL32` and `RTE_SHIFT_VA=
L64` macros by replacing `UINT32_C`/`UINT64_C` with casts. The commit messa=
ge explains the rationale clearly, including the technical note about `uint=
_least64_t` vs `uint64_t`.

Proper tags: `Fixes:`, `Cc: stable@dpdk.org`, `Signed-off-by`, multiple `Ac=
ked-by`.

---

## Patch 2/6: bpf: fix signed shift overflows in ARM JIT
**Status:** =E2=9C=93 OK

Addresses undefined behavior when left-shifting into the sign bit (e.g., `(=
!!is64) << 31`). Correctly replaces problematic patterns with `RTE_SHIFT_VA=
L32()` and `RTE_BIT32()` macros.

The commit message includes the actual sanitizer diagnostic, which is excel=
lent for documenting the issue.

Proper tags present. Depends on patch 1/6 for `RTE_SHIFT_VAL32` to accept v=
ariable arguments.

---

## Patch 3/6: bpf: mark ARM opcodes with UINT32_C
**Status:** =E2=9C=93 OK

Stylistic improvement to explicitly mark ARM opcode constants with `UINT32_=
C()` for clarity about signedness and width.=20

**Note:** No `Fixes:` or `Cc: stable@dpdk.org` tags, which is correct since=
 this is a cleanup/improvement rather than a bug fix.

---

## Patch 4/6: bpf: disallow empty program
**Status:** =E2=9C=93 OK

Excellent defensive fix that:
1. Rejects programs with zero instructions
2. Fixes out-of-bounds read when no EXIT instruction present
3. Adds comprehensive test cases for edge cases

Test coverage includes:
- Empty program (no instructions)
- EXIT-only program (undefined return value) =20
- No EXIT instruction
- Minimal valid program

Proper `Fixes:` and `Cc: stable@dpdk.org` tags.

---

## Patch 5/6: bpf: make add/subtract one program validate
**Status:** =E2=9C=93 OK

Fixes signed integer overflow undefined behavior in `eval_add()` and `eval_=
sub()` by casting to `uint64_t` before arithmetic. The fix is minimal and c=
orrect:

```c
// Before (UB when overflow occurs):
rv.s.min =3D (rd->s.min + rs->s.min) & msk;

// After (well-defined wraparound):
rv.s.min =3D ((uint64_t)rd->s.min + (uint64_t)rs->s.min) & msk;
```

Includes test cases that trigger the issue. Proper tags present.

---

## Patch 6/6: bpf: fix validation when conditional jump is first instruction
**Status:** =E2=9C=93 OK

Fixes a security-relevant validation bug where a conditional jump at instru=
ction 0 would skip validation of the false branch. The root cause (using in=
dex 0 as sentinel) is well-explained.

The fix changes from tracking previous instruction index to tracking previo=
us instruction pointer, which elegantly solves the problem since the first =
instruction will have `prev_node =3D NULL`.

Test cases demonstrate both the bug (jump-over-invalid at position 0) and a=
 control case (same pattern at position 1 to confirm it was always invalid).

Proper tags present.

---

## Series-Level Observations

**Info (minor observations):**

1. **Patch ordering is correct** - Patch 1 must come before Patch 2 since p=
atch 2 uses `RTE_SHIFT_VAL32()` with variable arguments. Good dependency ha=
ndling.

2. **Test infrastructure** - The `bpf_load_test()` helper function introduc=
ed in patch 4 is reused effectively in patches 5 and 6. Consider whether th=
is helper could be useful in the existing BPF test infrastructure beyond th=
is series.

**Code Quality:**
- All patches compile independently (can be verified)
- Tests are added alongside fixes
- No forbidden tokens or style violations detected
- Proper use of `RTE_` prefixed macros

**Tags Verification:**
- All bug fixes have `Fixes:` with 12-char SHA and exact subject
- All bug fixes have `Cc: stable@dpdk.org` =20
- All patches have `Signed-off-by:`
- Tag order is correct throughout

---

## Verdict

**Ready to merge.** No blocking issues found. The series addresses real bug=
s found by sanitizers and adds valuable test coverage for edge cases in BPF=
 validation.
