Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22332EF99D0
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:50:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43058402D8;
	Fri, 13 Feb 2026 20:50:51 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 1A925402C0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:50:49 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so10899315e9.2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771012249;
 x=1771617049; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=poRdPWTG5xY3NmNS92EIojUaPQvFSXiDq5pws/6NNMM=;
 b=Vy/vS58OOfA77TSNnxpwVsvw4BX6cHsov7r1KPSk4Buv6pTKPeWe0bYX0ytKZXxWic
 vlheyAoG2/JF8NbVi/mW6NKE69Spu0y7IJprpuYbgmH7px5nd7WUFuTdZAgHx/s46q66
 JQ7nRO1/GHZAaF00zKo3+bTIitPXLHZU8KWEKe7BS+Tvmrb0srTMZjWteWbcbQ/iOxuq
 PssWz/pHemsdUYx7jTD8StwaCwbcDQxAVuwzapO+DOCClktOTf5b+e0V8Yx/gFUqD37L
 UZREw9ohk5mzlFb7/pa2ujbD8oYc7p++GnH2ZHRUjrU/2cJq6NjSDmbLLMNSx3+7Rg+C
 kKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771012249; x=1771617049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=poRdPWTG5xY3NmNS92EIojUaPQvFSXiDq5pws/6NNMM=;
 b=DZExBCCKlRMVtylKZZDkgv3zLNpFN6a+g+UuS2RsLWm3UcFUJZC+LlRPrBOIXoJppl
 MwAn4OHiJSx1KGWVv8WcgXT2pbxU66S5Nshpl/3Zg0D/EtP8Z0opjHbcZhu99eWbLTn9
 Ct2DpyXfGyvAUwCNEYHpcAtDVaVaHEXqQbQFK3kMjknoHolNgTW0+ubJ2mQPIoLiAR0J
 +O2Jhny9GkheihbzR08+mbyOu/hKB1HqvZhFUh2J6RkZMHb4a7jH5SbX8v/rsM023in9
 tS1fBQhsPGidG3dSRNupjBOXWSN9Uz/9mIxaNgI4tXT6nIY7HiIKc07FNafxLxDoP5w/
 6I7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYTCBY6FQhlPW5QnZCBKz1UnumFtpgVTYeqUYxqfGbd7iqpAAV/MMA0a/Kqj9e7rvuMe4=@dpdk.org
X-Gm-Message-State: AOJu0YxJoecaI7nO6OTsxG7p9YjFWlATlQm+qAcZmPN/Sg/O4SgsDY+I
 xXC8/Zz1v0wC7mP7evJLQl6dg7CuuJn0aW1QAZqTIqDl1DJxg0fAQY/qZaiOtWcEkoY=
X-Gm-Gg: AZuq6aJO9OsIlkEA5wfGy98m0+vjIV9lrQc4eGZA7f9Gv8cArrGuXU0PaUWxEw+i84B
 h3LJD95pVeSTPq+VId+lnBn2g7iuFKPw9AG3/YqYlAwHOayj3ZQpDmjuaq2rv3K02A1OKT1x7aF
 oAVcvcVoO6DGptOxc2vzUq8hn0/Pha5yfGL7Wlr4e8a1TFc57GlfN/DmfKqpPfLELn2W95CFD/4
 pqG4r+2nHHBdh723pVrKsFqRNUp0RpQYiTIztFVbIbOajepngo8e5JCOriBu6B91GD3aX+1RSQt
 A5KbUph6Qtq9PJJWkmuNsB5z39csFJqb0fkub2Kb++oslaKhC6Ohs5/moCiOApN+nti3M/CdfYt
 BT5ChZVORIqmVxujY3mIVpzfQT9VZSerk07UfRIW8w80q0+9aQFJjr9tjUMAezTEcGEku532Brn
 +9v0xPV0aexmShnFLs8fbpn+DImWeLjQltEB0AJyyoWiO1vb3sovlc50PzIcX3dVLR
X-Received: by 2002:a05:600c:474e:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-48371095fa6mr75918165e9.31.1771012248553; 
 Fri, 13 Feb 2026 11:50:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm8602752f8f.28.2026.02.13.11.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:50:48 -0800 (PST)
Date: Fri, 13 Feb 2026 11:50:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v2] lib/ethdev: support inline calculating masked item
 value
Message-ID: <20260213115042.00da2530@phoenix.local>
In-Reply-To: <20260213133143.22120-1-bingz@nvidia.com>
References: <20251117075407.9632-1-bingz@nvidia.com>
 <20260213133143.22120-1-bingz@nvidia.com>
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

On Fri, 13 Feb 2026 15:31:43 +0200
Bing Zhao <bingz@nvidia.com> wrote:

> In the asynchronous API definition and some drivers, the
> rte_flow_item spec value may not be calculated by the driver due to the
> reason of speed of light rule insertion rate and sometimes the input
> parameters will be copied and changed internally.
>=20
> After copying, the spec and last will be protected by the keyword
> const and cannot be changed in the code itself. And also the driver
> needs some extra memory to do the calculation and extra conditions
> to understand the length of each item spec. This is not efficient.
>=20
> To solve the issue and support usage of the following fix, a new OP
> was introduced to calculate the spec and last values after applying
> the mask inline.
>=20
> Signed-off-by: Bing Zhao <bingz@nvidia.com>
> Reviewed-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

I didn't see any direct issue, but AI deep dive did.
Please consider these and resubmit (or say why they are false positives).

PS: I would just pull the Doxygen comment, this is internal and never gets
processed for inclusion in doc.

Summary
Severity	Finding
Error	Stale c_spec/c_last pointers across loop iterations =E2=80=94 can cor=
rupt previously copied item data
Error	Potential out-of-bounds read on src->mask when ret exceeds actual mas=
k size
Error	Wrong component prefix (lib/ethdev: =E2=86=92 ethdev:)
Error	Broken Doxygen comment (missing * prefix) and typo (spec =E2=86=92 la=
st)
Warning	New enum value not marked experimental
Warning	Missing release notes for API change
Warning	Missing functional tests
Info	Pointer arithmetic vs array indexing style


---

## Deep Dive Review: `[PATCH v2] lib/ethdev: support inline calculating mas=
ked item value`

### Commit Message Analysis

**Subject line:** `lib/ethdev: support inline calculating masked item value`

**Error =E2=80=94 Wrong component prefix.** The subject uses `lib/ethdev:` =
but per AGENTS.md =C2=A7Common Prefix Mistakes, the correct prefix for ethd=
ev is `ethdev:` (without `lib/`). Should be:
```
ethdev: support inline calculating masked item value
```

Let me verify the character count of the current subject: `lib/ethdev: supp=
ort inline calculating masked item value` =3D 56 characters =E2=80=94 withi=
n the 60-character limit, but after fixing the prefix to `ethdev:` it would=
 be shorter still.

**Commit body** =E2=80=94 the description is functional but uses somewhat u=
nclear phrasing: "the reason of speed of light rule insertion rate" is vagu=
e and would benefit from clearer technical justification. However, per AGEN=
TS.md guidance, I'll only flag clarity issues if genuinely confusing =E2=80=
=94 this is borderline but understandable in context to a flow API develope=
r.

**Tags:** Signed-off-by and Reviewed-by are present and in correct order (G=
roup 2 tags only, no Group 1 tags needed). No issues there.

---

### Correctness Bugs (Highest Priority)

**1. Error =E2=80=94 `c_spec` / `c_last` not reset per loop iteration: stal=
e pointer may cause masking wrong item's data (~80% confidence)**

The variables `c_spec` and `c_last` are declared outside the `for` loop and=
 initialized to `NULL`, but they are **never reset to `NULL`** at the start=
 of each iteration. Consider this scenario:

- Iteration N: `src->spec` exists, `size` is sufficient, so `c_spec` is set=
 to a valid pointer. The masking is applied correctly.
- Iteration N+1: `src->spec` exists, but `size` is *not* sufficient (the `s=
ize && size >=3D off + ret` check fails). `c_spec` retains the pointer from=
 iteration N. Then the `with_mask && c_spec && src->mask` check passes, and=
 the masking loop applies the **new item's mask** to the **previous item's =
already-copied spec data**, corrupting it.

The same issue applies to `c_last`.

**Suggested fix:** Reset both pointers at the top of each loop iteration, o=
r (better) scope them inside the relevant `if` blocks:

```c
for (i =3D 0, off =3D 0; !num || i !=3D num; ++i, ++src, ++dst) {
    uint8_t *c_spec =3D NULL, *c_last =3D NULL;
    /* ... rest of loop body ... */
```

**2. Error =E2=80=94 Masking applied to converted data using `ret` as lengt=
h, but `ret` includes alignment padding (~60% confidence)**

The return value `ret` from `rte_flow_conv_pattern` internal call via `rte_=
flow_conv_item_spec` may include padding from `RTE_ALIGN_CEIL`. The masking=
 loop uses `ret` as the byte count:
```c
for (j =3D 0; j < ret; j++)
    *(c_spec + j) &=3D *((const uint8_t *)src->mask + j);
```

If `ret` is larger than the actual item spec size, this reads past the end =
of `src->mask`, which may only be `sizeof(struct rte_flow_item_<type>)` byt=
es. This is a potential **out-of-bounds read** on `src->mask`.

The mask is user-provided via `src->mask` and its actual size corresponds t=
o the item type, not the aligned/padded conversion size. If `ret` exceeds t=
he true item spec size, the extra bytes of `src->mask` are being read from =
unknown memory.

**Suggested fix:** The masking should use the actual item spec size rather =
than the conversion return value, or at minimum clamp the loop to `min(ret,=
 item_spec_size)`.

**3. Warning =E2=80=94 No bounds validation between `ret` and mask size (~5=
0% confidence)**

Related to the above: there's no assertion or runtime check that `src->mask=
` points to at least `ret` bytes of valid data. The `rte_flow_conv` infrast=
ructure knows the item type sizes, but this masking code makes an assumptio=
n that the mask buffer is at least as large as the converted spec. If a cal=
ler provides a shorter mask, this is undefined behavior.

---

### API / Process Issues

**4. Warning =E2=80=94 New public enum value `RTE_FLOW_CONV_OP_PATTERN_MASK=
ED` not marked experimental.**

A new value is added to the public `enum rte_flow_conv_op` in `rte_flow.h`.=
 Per AGENTS.md, new APIs must be marked as `__rte_experimental`. While enum=
 values can't directly carry the `__rte_experimental` tag, this is a new pu=
blic API feature exposed through `rte_flow_conv()` and should be documented=
 as experimental, or the corresponding code path should have experimental g=
ating.

**5. Warning =E2=80=94 Missing release notes.**

This patch adds a new conversion operation (`RTE_FLOW_CONV_OP_PATTERN_MASKE=
D`) to the public `rte_flow_conv()` API. Per AGENTS.md, API changes require=
 release notes updates in `doc/guides/rel_notes/`.

**6. Warning =E2=80=94 Missing tests.**

No test code is included for the new `RTE_FLOW_CONV_OP_PATTERN_MASKED` oper=
ation. Per AGENTS.md, new API functions/operations should have functional t=
ests.

---

### Documentation Issues

**7. Error =E2=80=94 Doxygen comment has broken formatting and a typo.**

In `rte_flow.h`, the new enum doc block:
```c
/**
 * Convert an entire pattern.
 *
 Duplicates all pattern items at once, applying @p mask to @p spec and @p s=
pec.
```

Two problems:
- The line `Duplicates all pattern items at once...` is missing the leading=
 ` *` comment continuation prefix =E2=80=94 this will break Doxygen parsing.
- The text says "applying @p mask to @p spec and @p spec" =E2=80=94 the sec=
ond `@p spec` should be `@p last`.

**Suggested fix:**
```c
/**
 * Convert an entire pattern.
 *
 * Duplicates all pattern items at once, applying @p mask to @p spec and @p=
 last.
```

---

### Style Observations

**8. Info =E2=80=94 Pointer arithmetic style.**

The masking uses `*(c_spec + j)` rather than the more idiomatic `c_spec[j]`=
, and `*((const uint8_t *)src->mask + j)` rather than `((const uint8_t *)sr=
c->mask)[j]`. Array indexing notation would be clearer and more consistent =
with typical DPDK style.

---

### Summary

| Severity | Finding |
|----------|---------|
| **Error** | Stale `c_spec`/`c_last` pointers across loop iterations =E2=
=80=94 can corrupt previously copied item data |
| **Error** | Potential out-of-bounds read on `src->mask` when `ret` exceed=
s actual mask size |
| **Error** | Wrong component prefix (`lib/ethdev:` =E2=86=92 `ethdev:`) |
| **Error** | Broken Doxygen comment (missing `*` prefix) and typo (`spec` =
=E2=86=92 `last`) |
| **Warning** | New enum value not marked experimental |
| **Warning** | Missing release notes for API change |
| **Warning** | Missing functional tests |
| **Info** | Pointer arithmetic vs array indexing style |

The most critical finding is #1 =E2=80=94 the stale pointer bug. It's a log=
ic error that would cause data corruption whenever `rte_flow_conv` is calle=
d with `RTE_FLOW_CONV_OP_PATTERN_MASKED` on a pattern containing multiple i=
tems where the output buffer is too small for some but not all items.
