Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B34D38FFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:49:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6733140B91;
	Wed, 14 Jan 2026 18:49:34 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 5E7BE40677
 for <dev@dpdk.org>; Wed, 14 Jan 2026 18:49:33 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-64bea6c5819so16626a12.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 09:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768412973;
 x=1769017773; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7iFMHHoVtkzxa2Iz2usfYZjPixs5ihLMnqi7A4RuUI=;
 b=r554q8A0QGiiXJLqxgQAI9Mcbv41uTq6Xi72I+xnobe6i7YEelnHe6M3SwYLyn94zp
 wK+Glpf3yC7ZRd0lvY03zdvqv+M5+ynLOGsfaPM91iR5x+A1aO7BxudDPWHXEhIMmmMr
 bYKsZKJbfX0lcssJPUhlgBFZgMDRz2cjE4y5gAOBvWej0coq7RwhNeNKqNlVBih5Fqim
 TpOxUT/dsdmLO4o47Ed2DZR8zlU1sycDUsO+4mmnPUZW66EX6vfsh3eIuT3JMl2Tkg6r
 oYjA+dshiv/Bb9LqtijtGhnX+eh9bz9ChRdluDunA2on6bR9jGGQTy8Xu1UrwSCctFCb
 UiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768412973; x=1769017773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y7iFMHHoVtkzxa2Iz2usfYZjPixs5ihLMnqi7A4RuUI=;
 b=OQRyrKPrUH0P4R1w5wbeg/ONb29nodM2RpsZxMfpkOSEOvyUvuDSqUeSvsR350X6ca
 HxVGTZoDdfacE3fo2brsQeYmNIXHbKrLhSPlzpOBbOb6f3j1Q/HTqwKIp1XV1rmtdfRt
 dnGrroR3+KHRVslHMJ3Vd13uQ8VQBFFIsZRf4Meylhsu1OvQwfTmK9+gI43sV3qhWERE
 ECesoqtJRJXVIcFkpmDCjuKd/U8+CkbgenpCnQMxVPL3A+K/7vLFVL3s6prqR1mJ3r0Q
 KpOxptS3mX9Q9qmTU/cni8C/zEwsHcCsNWp7D5J3tHyvbcVYGXxNG8HoR6qdXfc5hZi6
 jNag==
X-Gm-Message-State: AOJu0Ywgzuxdc5jznqmlSV32Haa0cB1YHNj3/x7xwkGC8lpWB7S82kcq
 EOZLhPWKgP2am1CozFVNiYck1X81sVRlMsm+NRIYjlCBPxxVPIAPgfrA6iS9Xx+r9X0=
X-Gm-Gg: AY/fxX7Jcc4Vo5pa7d+H9XN866wpnNIGsxglA4dQpgJ7GWLB0Ukqg/eYWq8lweOssmZ
 9XJgdrMrPw+JuK+wEZ69pGV8CbD3jU3lnUy+sj1S3y/QmEj8jzZ99tysyEmm2yz/rh1nJVPR9AM
 rAJGmzbAzl/jSKoOuZSK6aNpf/dmZwusg2vDhWnPMk3yVH3U2hYQcS/PLnFGZOm20kv9qRt8XbU
 gWS+vbiTlKbTPMIZL2aDwB4pRuuZqvvySsqCjU9KfTvM/HgSWhv/iuV7qWy6MmK7p0kjf/sZgGx
 jORYAyZvVzlu1n0SLmJ0wY1irT+D9x7Y77Mu36LaB++NGKV83+amrApg8D+XR9yhwreaC0kdycJ
 PZBTsZ4sDwIeOZJDtTCFJDtnOr+OsHUzl7wzUYA7aU9jg9PYrPy4RHIX0BGlD2O+Ef721UeVCAt
 0fNwFeK4mmr1IHpAzibpuFni9fV9H/oBXEDsCxdbSq2NDh2j8w7Umx
X-Received: by 2002:a05:6402:440a:b0:649:6a2e:9bbb with SMTP id
 4fb4d7f45d1cf-653ec102c69mr2822330a12.2.1768412972818; 
 Wed, 14 Jan 2026 09:49:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65412082ba8sm232590a12.23.2026.01.14.09.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 09:49:32 -0800 (PST)
Date: Wed, 14 Jan 2026 09:49:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, <stable@dpdk.org>
Subject: Re: [PATCH] bpf: fix x86 call stack alignment, add tests
Message-ID: <20260114094927.3d4e9a77@phoenix.local>
In-Reply-To: <20251219182624.19557-1-marat.khalili@huawei.com>
References: <20251219182624.19557-1-marat.khalili@huawei.com>
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

On Fri, 19 Dec 2025 18:26:23 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Correctly align stack pointer on x86 JIT if external calls are present.
>=20
> Add tests for external calls from BPF program demonstrating the problem:
> * direct verification of a local variable alignment;
> * operations with 128-bit integers;
> * aligned and unaligned SSE2 instructions;
> * memcpy and rte_memcpy (may use vector instructions in their code).
>=20
> (Such variety is needed because not all of these tests are available or
> reproduce the problem on all targets even when the problem exists.)
>=20
> Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

AI code review of the test spotted some minor stuff.
## DPDK Patch Review: BPF x86 Call Stack Alignment Fix



### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 | 43 characters |
| Lowercase after colon | =E2=9C=85 | Correct |
| Imperative mood | =E2=9C=85 | "fix" is imperative |
| No trailing period | =E2=9C=85 | Correct |
| **Forbidden punctuation** | =E2=9D=8C **ERROR** | Subject contains comma =
(`,`): "fix x86 call stack alignment**,** add tests" |
| Body wrapped =E2=89=A475 chars | =E2=9C=85 | All lines within limit |
| Body doesn't start with "It" | =E2=9C=85 | Starts with "Correctly" |
| Signed-off-by present | =E2=9C=85 | Real name and email |
| Fixes: tag format | =E2=9C=85 | 12-char SHA, quoted subject |
| Cc: stable@dpdk.org | =E2=9C=85 | Present in headers for backport |
| Tag order | =E2=9C=85 | Blank line between Fixes: and Signed-off-by |

**Suggested subject fix:**
```
bpf: fix x86 call stack alignment and add tests
```
or split into two patches.

---

### Code Quality

**JIT Fix (`lib/bpf/bpf_jit_x86.c`):**

| Check | Status | Notes |
|-------|--------|-------|
| Lines =E2=89=A4100 chars | =E2=9C=85 | All within limit |
| Comment style | =E2=9C=85 | Proper `/* */` multi-line format |
| Logic correctness | =E2=9C=85 | Stack alignment via `AND RSP, -alignof(ma=
x_align_t)` is correct |
| Side effect: blank line removal | =E2=9A=A0=EF=B8=8F **INFO** | Line 1217=
 removes unrelated blank line - minor cleanup mixed with fix |

The alignment approach is sound: using `-(uint32_t)alignof(max_align_t)` cr=
eates mask `0xFFFFFFF0` for 16-byte alignment.

**Tests (`app/test/test_bpf.c`):**

| Check | Status | Notes |
|-------|--------|-------|
| Test registration macro | =E2=9C=85 | Uses `REGISTER_FAST_TEST` (correct =
per guidelines) |
| NULL comparisons | =E2=9C=85 | Uses `=3D=3D NULL` explicitly |
| Format specifiers | =E2=9C=85 | Uses `%ju`/`%zu` correctly with casts |
| **Missing NULL check** | =E2=9A=A0=EF=B8=8F **WARNING** | Lines 410, 414:=
 `malloc()` return not checked |
| Conditional compilation | =E2=9C=85 | `__SIZEOF_INT128__`, `__SSE2__` gua=
rds appropriate |

---

### Specific Code Observations

**Minor warning - malloc without NULL check:**
```c
char *const src_buffer =3D malloc(size + src_offset);  // line 410
// ... no NULL check
char *const dst_buffer =3D malloc(size + dst_offset);  // line 414
// ... no NULL check
```

While test code is more tolerant, adding a check would be cleaner:
```c
if (src_buffer =3D=3D NULL || dst_buffer =3D=3D NULL) {
    free(src_buffer);
    return TEST_FAILED;
}
```

**Good practices observed:**
- Thorough test coverage: direct alignment verification, uint128, SSE2 alig=
ned/unaligned, memcpy variants
- Proper volatile usage to prevent optimization interfering with tests
- Good inline documentation explaining the ABI requirement and fix rationale
- Appropriate use of `alignof(max_align_t)` rather than hardcoding 16

---

### Summary

| Severity | Count | Items |
|----------|-------|-------|
| **Error** | 1 | Subject contains forbidden comma |
| **Warning** | 1 | malloc() without NULL checks in test |
| **Info** | 1 | Unrelated blank line removal mixed with fix |

**Recommendation:** Request v3 with subject line fixed. The technical conte=
nt is solid - the fix correctly addresses the x86-64 ABI stack alignment re=
quirement for external calls, and the tests comprehensively validate the fi=
x across multiple scenarios.
