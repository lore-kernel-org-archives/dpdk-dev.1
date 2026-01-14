Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABEED31A09
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 05:25:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 208494028F;
	Wed, 14 Jan 2026 06:25:34 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id EB10840289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 06:25:32 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so79115115e9.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768368332;
 x=1768973132; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjk2T34L+OjPtL8CuiyaVVKp0yXT4j4d/CHAi6ns+/g=;
 b=u/GBuKvfismuAEIbLXYdVUftFibv/NVkFO/9JqpoOU710dfZQAPbqBTS3plaBEmS1L
 xsOA+K+dAB8anrnZk78LPCaKjqpyNDLIT9Jhs4j6dUyW58IYZcPjjP527XYg0QggeIk2
 R5zc/DlNLq7gMohUqVufFQAjUUwnwjqMUhcethqsapTO5l/hAlUpZMXKp4y2ruHVzlP4
 61tboQcYVGMimnamJAKF7wek/c78pJwDlSFVSYKOKLoeNd0m8ZAQPX4T728muFJfLXU0
 DqEXkJ4bMx28aszxB+g0YYdscGZrplldIeWw0d+izMm3Lq7xrjpHKh3i+NvjjZpSNa7w
 RSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768368332; x=1768973132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjk2T34L+OjPtL8CuiyaVVKp0yXT4j4d/CHAi6ns+/g=;
 b=tgT1sjgza8GzpI+vu3U023JZ8fqZ8qqgpwRnftVClJN54LgoIxf+MrdS7GNIIx80S1
 t6OtIYzBBN1q1avKUdRYeACFLd6gEUbHLo9XvnjIUiWaPykfymGV6LLrqqvtzKKHUAw7
 mxENLKZTxPSkpDvFtGyKyNgdRlBV0IntEgSG+yhbKw3HreC7t1nl5zRVBUSzP2Z7AXPV
 jBCPLqFWujvVUvISMBns8I1s7cRqe02m9CZdpr3px681xWt2WxVh6pBas2SKt+wp7en8
 ASTINb+iw9RotgoUQTjiQ4uIdLi9efjYf/A2lRf8joj2Az/D2ckxa5mrTSCCMOwgnFJC
 HASw==
X-Gm-Message-State: AOJu0Yxq78QabLx+A3doD65s7Yl4c7xE+DiABiTtb8ekJVyKpB0nMMPn
 ROAQHjxd0z1PQjc+hpCyVOeamYBB8Fq3pq0LVEySErrk6MDp9jGIqTOZSccob8XQt8w=
X-Gm-Gg: AY/fxX6Hxh7Xyd/pMCGYIujBx8RhUiyVkLyDlmfQxL8MevtpgwXHwPDb0PPEFL/wc0L
 bWA6l2ub/QfcHZni2VwL7cRWz4fEgh3aqCKJVJiT6azCzdQagFh62XLSPycEVvqE0alcT4AIW4M
 d13SaMJB0rgGcK15juN+gtfVuDjYSDtDMyVrvf5cNCLK8BqEWti3RBMcIo3hz1sd/IjoiLbepXp
 27aWoJKrgwh8maUR+Pnq3JZdZV26Q6e9E/VnQaIylTfrMPw0g1gHD/VwvEZCUGOSU85yrwfcj2J
 E8Nwj3vuaqbkPjf6qyQHSPgt8kcRgLQKVj9bQrZXv/uVO1eQYeavyV6b7EFkFYuFS3hnpibkl+5
 z7i36O3KOzO7zsho4KDD3Fy4CQLqyv3zXa7ziNR/F9l8BaH09mFRxy8vPc/V2PE+Ec+8Ojgkktb
 6Xwun1aUHMFgcX8VnenTJ0JzIgAF+zLA/j2XR0dj1mFQKkgDU/EaNN
X-Received: by 2002:a05:600c:6218:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-47ee33997fcmr13577865e9.33.1768368332519; 
 Tue, 13 Jan 2026 21:25:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee578d1b2sm9369045e9.2.2026.01.13.21.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 21:25:31 -0800 (PST)
Date: Tue, 13 Jan 2026 21:25:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Congjie Zhou <zcjie0802@qq.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com
Subject: Re: [PATCH v3] eal/linux: fix fbarray name with multiple secondary
 processes
Message-ID: <20260113212526.0d2a5eae@phoenix.local>
In-Reply-To: <tencent_C757C0BA2AC7438F65C6522E700005F53605@qq.com>
References: <tencent_B09D0FCCA142E4AE5ABFE584E92DCED8CB0A@qq.com>
 <tencent_C757C0BA2AC7438F65C6522E700005F53605@qq.com>
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

On Sat, 16 Nov 2024 12:07:41 +0800
Congjie Zhou <zcjie0802@qq.com> wrote:

> add the tsc into the name.
>=20
> Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
> ---

This patch seems to have gotten stuck in the unreviewed dead pile.
Looking at it, it addresses a potential problem but there are issues.
Please consider what this AI review feedback had to say and resubmit

Now let me analyze this patch against the AGENTS.md criteria and evaluate t=
he technical correctness.

## Evaluation Against AGENTS.md

### Commit Message Issues

| Check | Status | Details |
|-------|--------|---------|
| Subject =E2=89=A460 chars | =E2=9C=85 | 56 characters |
| Correct prefix | =E2=9C=85 | `eal/linux:` is correct |
| Lowercase after colon | =E2=9C=85 | "fix fbarray..." |
| Imperative mood | =E2=9C=85 | "fix" |
| No trailing period | =E2=9C=85 | |
| Signed-off-by present | =E2=9C=85 | |
| Body lines =E2=89=A475 chars | =E2=9C=85 | |

**Warning**: The commit body is weak - "add the tsc into the name." is very=
 terse and doesn't explain the *problem* being solved. The actual explanati=
on is after `---` which won't appear in git history. The body should explai=
n the container PID namespace issue before the Signed-off-by.

### Code Style

| Check | Status | Details |
|-------|--------|---------|
| Include order | =E2=9C=85 | `inttypes.h` with system includes, `rte_cycle=
s.h` with DPDK includes |
| PRIx64 format | =E2=9C=85 | Correct portable format specifier |
| Line length | =E2=9C=85 | Within 100 chars |

---

## Technical Correctness Analysis

### The Problem
In Linux containers with separate PID namespaces, each container's PID numb=
ering starts from 1. If multiple secondary DPDK processes in different cont=
ainers share the same hugetlbfs mount, the fbarray names (which include PID=
) can collide.

### Issues with the TSC Solution

1. **TSC is not reliably unique**: Two containers starting at nearly the sa=
me instant on the same CPU could get very close or identical TSC values. Th=
e TSC counter increments at GHz frequencies, but container startup can be s=
ynchronized at millisecond granularity.

2. **TSC synchronization issues**: On multi-socket systems, TSC may not be =
synchronized across sockets/CPUs. While modern CPUs have `constant_tsc` and=
 `nonstop_tsc`, this isn't universal.

3. **Overhead**: `rte_get_tsc_cycles()` is very cheap, but it adds a depend=
ency on the cycles subsystem being initialized.

4. **Name length**: Adding a 16-character hex value to an already length-li=
mited name (RTE_FBARRAY_NAME_LEN) could cause truncation issues.

---

## Simpler Alternative Solutions

### Option 1: Use `rte_rand()` (Recommended)

```c
#include <rte_random.h>

snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%x",
    primary_msl->memseg_arr.name, rte_rand());
```

**Advantages**:
- Cryptographically random, much lower collision probability
- Already seeded during EAL init
- No timing dependencies
- Simpler code (no PID needed at all)

### Option 2: Use the runtime directory uniqueness

The **proper solution** for containers is to use `--file-prefix` which alre=
ady exists. Each container should specify a unique file prefix, making this=
 problem disappear entirely. This is a documentation/deployment issue, not =
a code issue.

### Option 3: Combine with monotonic clock nanoseconds

```c
struct timespec ts;
clock_gettime(CLOCK_MONOTONIC, &ts);
snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%lx",
    primary_msl->memseg_arr.name,=20
    (unsigned long)(ts.tv_sec * 1000000000UL + ts.tv_nsec));
```

This was v1 of the patch and is actually fine - CLOCK_MONOTONIC with nanose=
cond resolution within a container's lifetime is effectively unique.

---

## Verdict

**The patch is technically functional but the solution is suboptimal.**=20

The TSC approach works in practice but has theoretical collision risks. A c=
leaner approach would be:

1. **Best**: Document that containers sharing hugetlbfs should use `--file-=
prefix`
2. **Code fix if needed**: Use `rte_rand()` instead of TSC - it's simpler a=
nd provides stronger uniqueness guarantees

Would you like me to draft an alternative patch using `rte_rand()`?
