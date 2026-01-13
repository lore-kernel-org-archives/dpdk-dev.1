Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B249CF45DB
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 01:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61F7C402E8;
	Tue, 13 Jan 2026 02:09:26 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id 4EB78402E0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 02:09:25 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-64d30dc4ed7so13760117a12.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 17:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768266565;
 x=1768871365; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwJ1JXr1rXFLBoc1UAn7svocwy8aW7rPvil0YpcaVHw=;
 b=T2o9ceE79hgu5ZChXhhmL72v3CLt4lr0NQX0AvkSRgaYsnwbaMEFw6Tu0C1ur9pFgb
 WOp0qhAgLAamW37WcGp+OsVEEN0nVW2mmPTb/4MrnYSqYlh5TfeT6ROa18WRGSbD/ADK
 V/VEoPANdb9htshNyhkCKyoMUOA2rrtHZOzrIQ4iGD+MZUS7BGQufgK/TYPmsm0W30EE
 VYoUUFRWr9wGI7beJ5SQCv4kAKl1jHKubqi1B5+7OP7FmdTcfO7NLQfTKpZDoZqTTJhN
 EdfNge6WP80FTSqqMsQlhFCWW18+TrgkddmDpKoo9lpSHaM5N9uQRUcHBgGBio7/HRsR
 BmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768266565; x=1768871365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rwJ1JXr1rXFLBoc1UAn7svocwy8aW7rPvil0YpcaVHw=;
 b=EnzLOtHpzb5sxcL6TUrDVKPlyJS+q4RLr3EG5ZiTQD24tQgxdm+NhK4Yb4qi9xZotd
 yjUikL/RpVI1POylBso8MQymBmjBDX+9MIEEkY9M5KEiiIIMSIdUTK+owSLKicP7DZyb
 szEoP6tlimO7OG6nVFoxa91VyABiebaXXK3HQ2PzoBhQth4Ik+shn34FUDCifs/fHQBN
 4qs6Qh1YF8E1jelMgobdYoy0YwduMzvCm/6ZvFFw0ndKdqqx6B+HKWQ/qjWioIExOL6+
 5hxNpWVjNKiK8rBwlmWPYWlVG+fHekcmwjq0lY97X72M6V+AJDGVmZO4dC0JV7y6Rdo5
 sLvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV8Zh8AzuYwtOUHu+dojjOhmaXKQURLdgllUF9t/do2/IAuw2IDmSCXLBRg+Hh1WoAVy4=@dpdk.org
X-Gm-Message-State: AOJu0Yy+3XIrVyqW0KIdfmCjN2o3s1K30cjQESpsqV3+Gz/NET4cQgCC
 Se4pREC21kM9roph7mfD8rliiCkNopnA95S7C62fxzoqKro7R6hCNh0qekfMWUc2kXA=
X-Gm-Gg: AY/fxX7MPKiKD9xgJojRUB/ePuf6DxluS5+JYMzkdm6k/0LdHsWfyEPjIxSukO0nmJ3
 JjaWzoVQd6pMBLGrGY3Q4xh5zmqerMzVdt02jUU+jmUrXQtxwTtsybHSJbpYYssOnJ+0I1y7E4N
 RJPBD21YrZSzviE8kYuFMbdDL3fh6m29YWGp+SSp6azDN2sbr/TkVamdHBBVd4Dw6aNCfV8QUAW
 LwSAxJg/GyxUE5loqTeo68Qw6JLDKOUi6w1xKzBCow6kwdRDBGz92i0yDJQFmsW8hSTY2+Nhidx
 ej+uo5krvfbganzN5f9cXXKauBSvhjlqIPVOJQG1v58Y7b0ZbNu1ViW9fTUJZSqepGNBL3SdQnu
 i584P52aQ1X34zIOIlNAUz5xM2Sa1j8VWZyHlDGRNO4/+ocoY5NGUoUDfs6WdT7LgWLrpWi+RmH
 rOMCKPz3fqyvccP9MAZC2561sB6IPVMYpPIxZRk3Vz4n78lWiAg6f7
X-Google-Smtp-Source: AGHT+IFy59Axiell/GWV502hHracSN7EQCCv7BmgOWqM5PPx6qUER51HhPtYc6b3tNdZSS9oTijBzQ==
X-Received: by 2002:a05:6402:3593:b0:649:79a8:8b4f with SMTP id
 4fb4d7f45d1cf-65097df5bf5mr18655746a12.11.1768266564779; 
 Mon, 12 Jan 2026 17:09:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507be651a4sm18540765a12.16.2026.01.12.17.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 17:09:23 -0800 (PST)
Date: Mon, 12 Jan 2026 17:09:18 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>, Bing
 Zhao <bingz@nvidia.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v3] app/testpmd: fix flow queue job leaks
Message-ID: <20260112170918.4802853a@phoenix.local>
In-Reply-To: <20260112173648.1528180-1-dsosnowski@nvidia.com>
References: <20260109152607.206389-1-dsosnowski@nvidia.com>
 <20260112173648.1528180-1-dsosnowski@nvidia.com>
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

On Mon, 12 Jan 2026 18:36:47 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> Each enqueued async flow operation in testpmd has an associated
> queue_job struct. It is passed in user data and used to determine
> the type of operation when operation results are pulled on a given
> queue. This information informs the necessary additional handling
> (e.g., freeing flow struct or dumping the queried action state).
>=20
> If async flow operations were enqueued and results were not pulled
> before quitting testpmd, these queue_job structs were leaked as reported
> by ASAN:
>=20
> Direct leak of 88 byte(s) in 1 object(s) allocated from:
>     #0 0x7f7539084a37 in __interceptor_calloc
>         ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
>     #1 0x55a872c8e512 in port_queue_flow_create
>         (/download/dpdk/install/bin/dpdk-testpmd+0x4cd512)
>     #2 0x55a872c28414 in cmd_flow_cb
>         (/download/dpdk/install/bin/dpdk-testpmd+0x467414)
>     #3 0x55a8734fa6a3 in __cmdline_parse
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd396a3)
>     #4 0x55a8734f6130 in cmdline_valid_buffer
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd35130)
>     #5 0x55a873503b4f in rdline_char_in
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd42b4f)
>     #6 0x55a8734f62ba in cmdline_in
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd352ba)
>     #7 0x55a8734f65eb in cmdline_interact
>         (/download/dpdk/install/bin/dpdk-testpmd+0xd355eb)
>     #8 0x55a872c19b8e in prompt
>         (/download/dpdk/install/bin/dpdk-testpmd+0x458b8e)
>     #9 0x55a872be425a in main
>         (/download/dpdk/install/bin/dpdk-testpmd+0x42325a)
>     #10 0x7f7538756d8f in __libc_start_call_main
>         ../sysdeps/nptl/libc_start_call_main.h:58
>=20
> This patch addresses that by registering all queue_job structs, for a
> given queue, on a linked list. Whenever operation results are pulled
> and result is handled, queue_job struct will be removed from that list
> and freed.
> Before port is closed, during flow flush, testpmd will pull
> all of the expected results
> (based on the number of queue_job on the list).
>=20
> Fixes: c9dc03840873 ("ethdev: add indirect action async query")
> Fixes: 99231e480b69 ("ethdev: add template table resize")
> Fixes: 77e7939acf1f ("app/testpmd: add flow rule update command")
> Fixes: 3e3edab530a1 ("ethdev: add flow quota")
> Fixes: 966eb55e9a00 ("ethdev: add queue-based API to report aged flow rul=
es")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Much better, but there some suggestions.
Yes this AI "bikeshedding" which is a first...

## Patch Review: app/testpmd: fix flow queue job leaks

### Summary
This patch fixes memory leaks in testpmd's async flow API by tracking `queu=
e_job` structs in a linked list and ensuring proper cleanup when flushing f=
low queues or closing ports.

---

### =E2=9C=85 Commit Message Analysis

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | `app/testpmd: fix flow queue=
 job leaks` =3D 37 chars |
| Correct prefix | =E2=9C=85 Pass | `app/testpmd:` is correct |
| Lowercase after colon | =E2=9C=85 Pass | |
| Imperative mood | =E2=9C=85 Pass | "fix" is imperative |
| No trailing period | =E2=9C=85 Pass | |
| No forbidden punctuation | =E2=9C=85 Pass | |
| Body doesn't start with "It" | =E2=9C=85 Pass | Starts with "Each enqueue=
d..." |
| `Signed-off-by:` present | =E2=9C=85 Pass | Real name with valid email |
| `Fixes:` tags present | =E2=9C=85 Pass | 5 Fixes tags with 12-char SHAs |
| `Cc: stable@dpdk.org` present | =E2=9C=85 Pass | Correctly included for b=
ug fix |
| Blank line before Signed-off-by | =E2=9C=85 Pass | |
| Tag order | =E2=9C=85 Pass | Fixes =E2=86=92 Cc =E2=86=92 blank =E2=86=92=
 Signed-off-by |

---

### =E2=9A=A0=EF=B8=8F Warnings

**1. Unnecessary cast of `void *` (line ~420)**
```c
job =3D (struct queue_job *)res[i].user_data;
```
If `user_data` is `void *`, this cast is unnecessary in C and should be rem=
oved:
```c
job =3D res[i].user_data;
```

---

### =E2=84=B9=EF=B8=8F Informational Notes

**1. Function naming could be clearer**

The function `port_alloc_queue_job()` doesn't actually allocate anything=E2=
=80=94it inserts a job into a linked list. A clearer name might be `port_re=
gister_queue_job()` or `port_track_queue_job()`.

**2. Commit body line lengths**

The ASAN stack trace in the commit message appears to have lines that may a=
pproach or exceed 75 characters due to indentation. While the content itsel=
f is useful, you may want to verify line lengths or consider trimming the s=
tack trace to the most relevant frames.

---

### =E2=9C=85 Code Style Verification

| Check | Status |
|-------|--------|
| Lines =E2=89=A4100 characters | =E2=9C=85 Pass |
| Explicit NULL comparisons | =E2=9C=85 Pass |
| Explicit zero comparisons | =E2=9C=85 Pass |
| No forbidden APIs | =E2=9C=85 Pass |
| Function return type on own line | =E2=9C=85 Pass |
| Proper comment style | =E2=9C=85 Pass |
| No trailing whitespace (visible) | =E2=9C=85 Pass |
| Uses DPDK list macros correctly | =E2=9C=85 Pass |

---

### Code Quality Notes

The implementation is sound:
- Properly tracks jobs per queue using `LIST_HEAD`/`LIST_ENTRY` macros
- Bounded iteration count (`FLOW_QUEUE_FLUSH_MAX_ITERS`) prevents infinite =
loops
- Graceful error handling with cleanup on failure paths
- Memory is freed both on normal completion and timeout conditions
- Uses `RTE_ASSERT` with explicit NULL comparison for debugging

---

### Verdict

**Acceptable with minor suggestions.** The patch follows DPDK coding standa=
rds correctly. The only actionable item is the unnecessary `void *` cast, w=
hich is a warning-level issue. The naming suggestion is purely stylistic.
