Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAC8D39011
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 19:43:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29CF440E19;
	Wed, 14 Jan 2026 20:43:48 +0100 (CET)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43]) by mails.dpdk.org (Postfix) with ESMTP id 61A2E40E0A
 for <dev@dpdk.org>; Wed, 14 Jan 2026 20:43:47 +0100 (CET)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b8719aeebc8so34019966b.3
 for <dev@dpdk.org>; Wed, 14 Jan 2026 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768419827;
 x=1769024627; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lj0skcTRPYcbLXnGX921LPFod+jP9Ex7JLcZzvlrhtI=;
 b=rxvjXDTauxpeM/jQN5sUyuNatdl4Z3vzPBuMnUpXs0D1dy1BKuTQyjlSMeo8zeuTxZ
 simJCQ+vlMlPqGw7nWM8IMDWTNeDDDo1AkRA5oM1A49xQ/Me7Lmb+XmOKh6R9bZCWJDr
 Oro388Hwmf+SdISQ9p4wdik/i2p9zFO4a0EbglcL9z/ZjaBPLh42twt+kGtYSSWcFrFT
 7osW5z5YhrxhKryJLOW8ZQhwTA2T7HlUOeH/BRYaDKbLf/szC+4t06KWfUVx4nGhMr0O
 IEhk1U0Zwkm3fVN2DM5LBU4CUA1vvaPXJL1wG9WAQg6HivRfoLYMMp5QAsgQcMHh7HPt
 Xrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768419827; x=1769024627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lj0skcTRPYcbLXnGX921LPFod+jP9Ex7JLcZzvlrhtI=;
 b=FpmRxWymNeyUS251ey1Czg4SrXSLmWNRrC6A2OTBtc1X7zoyNR+imA19rAklohnv3K
 mVhdGkqab+uaF57enKTiuHHRL7FV1Da/EMdq5mHhixp8PeS7/Gce/I1C37/ChNNCpVb0
 IR+xjmrYle9MrYypa4+TFd0MWgCpph75iefjVcQbo6SoDEZJJALtCpg9n1vIZimn5bxx
 Es84qivsWzmKzTyTAUX0XVMWK6HsEB4ZEkzCUF3K6mGnnymwI6lSm+DguzJzmSNoVGxu
 F235UYnwgysBct2ukcFlhVWIJ4O/H2eYPDJPEBS3G36Pgp5HgFTjRZaN08LJN0p06yX4
 ZfqA==
X-Gm-Message-State: AOJu0Yy1xjEO+QeqFZXr3DtHuf8NPGZkkXmkoyRZ1R3PcEq7bDXzMD3F
 mAinjuO97zLu09ekdNc4zSrcprHJTiWStirj9SWORjM2xhosRChBx9Gr5qbVOunL7HA=
X-Gm-Gg: AY/fxX7oc76WmFJAfZxFr/Vdwb6hIHvAs16CcHV6VYcLtDYKWEEo60xMU7r3a7yGURv
 B3WmUrg1irO+CMFh+b3m2MZ3XyScrd27YgfblJJ3gep3+UddHuxog2lqMT5eKxET5eEvnibXDCr
 tdDyfSRq05PJfNPM/2tSkefbH/ZouT7/lVzejsFPGY4w00Kr5DOJjuJYM615zSTM1SzLE//LzC9
 7LbgcMgvcydSZL8KPcVTS0jSzYcZxQmUuS0zD5rZaK4KStsJfcaJHXd9ySNPJTBsMC5rJgNs9zL
 fNtSrrrFV0Io9opky8fnfzksRfIECH+NCAvf/DISPR9yfxKzP9sgLbLruLUtsQltq3epL7GYqzy
 56sjOCSm+25XtneS3Kwh3JSS3+jmdk0l/3a6he3/U1Gs7FZOzzLxmn9EZjgRZ5BaocIlOiiw0ED
 maFo9w9WPFZwzrIj6Apu9XVfG0qdCM/V5/Lfk9bf1zenTrYGU9lbxg
X-Received: by 2002:a17:907:72c5:b0:b80:3fff:32ea with SMTP id
 a640c23a62f3a-b876783a1b9mr255410666b.57.1768419826783; 
 Wed, 14 Jan 2026 11:43:46 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a4cfe60sm2578795766b.45.2026.01.14.11.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:43:46 -0800 (PST)
Date: Wed, 14 Jan 2026 11:43:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, <stable@dpdk.org>
Subject: Re: [PATCH] bpf: fix x86 call stack alignment, add tests
Message-ID: <20260114114341.1d12f990@phoenix.local>
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

AI code review identifies some shadow declarations in this patch.
Please fix and resubmit.

## DPDK Patch Review: BPF x86 Call Stack Alignment Fix

### Summary
This patch fixes a real x86-64 ABI compliance bug in the BPF JIT compiler w=
here stack alignment wasn't guaranteed to be 16-byte aligned before externa=
l function calls. The fix is elegant and the test coverage is comprehensive.

---

### Commit Message Issues

| Severity | Issue | Details |
|----------|-------|---------|
| **Error** | Comma in subject line | Subject contains `,` which is a forbi=
dden punctuation mark per `check-git-log.sh` |
| **Error** | Missing blank line before Signed-off-by | Per tag order rules=
, blank line required between `Fixes:`/`Cc:` group and `Signed-off-by:` gro=
up |

**Subject line:**
```
bpf: fix x86 call stack alignment, add tests
```
Should be split into two patches, or reworded:
```
bpf: fix x86 call stack alignment for external calls
```
(with tests mentioned in body, or as separate patch)

**Tag ordering should be:**
```
Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
```

---

### Code Review

**lib/bpf/bpf_jit_x86.c** =E2=80=94 The fix is clean and well-documented:

```c
/* Mark RBP as used to trigger stack realignment in prolog. */
USED(st->reguse, RBP);
```

The alignment approach using `alignof(max_align_t)` is portable and correct=
. The comment block explaining the rationale is helpful.

**Minor observation:** Line 1219 removes an extra blank line =E2=80=94 this=
 is unrelated cleanup but acceptable.

**app/test/test_bpf.c** =E2=80=94 Comprehensive test coverage:

| Severity | Issue | Location |
|----------|-------|----------|
| **Warning** | Variable shadowing | Lines 462-464: `src_offset`, `dst_offs=
et`, `test_rc` redeclared in inner loop scope |
| **Info** | Style preference | Consider extracting the common pattern in m=
emcpy subtests |

The shadowed variables at lines 462-464:
```c
for (size_t size =3D 1; size <=3D 1024; size <<=3D 1) {
    const bool src_offset =3D offsets & 1;  /* shadows outer scope */
    const bool dst_offset =3D offsets & 2;  /* shadows outer scope */
    int test_rc;                           /* shadows outer scope */
```

These are unnecessary redeclarations since the outer loop variables can be =
reused.

---

### Technical Assessment

The fix correctly addresses the x86-64 ABI requirement (System V AMD64 ABI =
=C2=A73.2.2) that RSP must be 16-byte aligned before `CALL`. The approach o=
f:

1. Marking RBP as used when external calls exist =E2=86=92 triggers stack f=
rame setup
2. Aligning RSP with `AND` instruction using `-alignof(max_align_t)`=20
3. Restoring original RSP from RBP in epilog

is sound and minimal in its impact on generated code for programs without e=
xternal calls.

The test coverage is thorough, testing:
- Direct stack variable alignment verification
- 128-bit integer operations
- SSE2 aligned/unaligned loads/stores =20
- memcpy/rte_memcpy with various sizes and alignments

---

### Verdict

**Recommended changes before merge:**

1. **Fix subject line** =E2=80=94 Remove comma or split into two patches
2. **Add blank line** before `Signed-off-by:` block
3. **Consider** removing shadowed variable declarations in test (minor)

The technical fix itself is correct and well-implemented. With commit messa=
ge fixes, this should be ready to merge.
