Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657D0D2F34B
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 17:27:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C6E3402DE;
	Tue, 13 Jan 2026 18:27:18 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 97859402D6
 for <dev@dpdk.org>; Tue, 13 Jan 2026 18:27:16 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so4099929f8f.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 09:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768325236;
 x=1768930036; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=reAAbYRo5kuwScAyAXsGJmWpzY0zsrs11z5+hHTUKJg=;
 b=wcAIpoJP8BH7GoVJ/Aw/5y/160cWlZEopBGE7/oYtGxMvXBpgJQ/PqCvWYTZxyoa3S
 Dowd+k1bG3XXU+szhAJx6i9MG+LWgU6Fsu3ClxUxUFC8l2Cbi+oK7l7LDWZMHVxL8ty6
 7mC7sP5D9qcIcyc+vtXrB+azfrpjeca7/2ev2augFm1Znp1XAHhorkpC6/oPG6FFtVpU
 DOHtzIIJl3VIkiojSUWxb64NxMlJxO5aVVPoPjvTQ8Lg2ZTq07Yzqt0TAGzvkCWr+deS
 0r/GV74sROsMCU8iV/um9FlvuXHE1Z9ybfVrAuc5ffeDue9zqjHbn3lfWg1Oqe9bxFN+
 M4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768325236; x=1768930036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=reAAbYRo5kuwScAyAXsGJmWpzY0zsrs11z5+hHTUKJg=;
 b=jQsniKvclE2z8hgWBIb+FZTNBPpR6WMIRuPp/JLl8vgPwunSOvsE6cO4RjxtjoGA9Q
 Fhvf5ZiwjyOWNg0pRx+NA6llMUs/6cVSUSzdllAzJD2Z5Z5twzc72EK9THgo5v0HRiPb
 /CwcFSECUC873GHICRTjyzO98UGRVkSsbgvYHqQyONRLvwBARrbCG53ltbhS4ixJO7Fs
 fqx60fibZllEm6SpBkrSsG2vZv2lCB0xCyIwkoxCUmtzIj2kgFDxLqUF/Gvn4mch4sWW
 vxCe6x5q1rnW/o2yyeN8ALAcnBgrIfEnoT5etd8FMqPubHA4zr+oiSItedX5Ev+Of9FT
 Nu6w==
X-Gm-Message-State: AOJu0YwRmusynV0+426lK000Da1Vo1C1AdqjocxgyseRXrLxJYjnwQUu
 lBAxnL1+C3+fSv4m4POULYW0GxyK4c3IMqtqpNgQ2PwAA2yMELkFnkC356PF1hXp8kA=
X-Gm-Gg: AY/fxX7u5KVpUxuFAyjha2yDs6lPjmutxJY1I032PB+zTVOQtUlueqjusQYlsMG1SCJ
 PhnqZlbxrnswaTI/cnmu7SQNnSqb8haV8FYsH7yKL7WFYLYXysvllkguGUSI8+yXznKXi01zzjI
 0d/v+3szhDfXdztx7guzukew8kGkEdRDY0f+ESGcsPsQ5gnAOD2Jtj4I+vCxJnEUIHI194ozCFB
 ySt9/ME8GxOkQUU9/lbGQmEnfrjgVrZS45vaJANQqZNntdOu086El0h7Z1JRT2bEE7g9IaOeyDR
 dRxhkOfYWSEz6ujEWVjCe1O9NkAES+x0bJr3MIDK8j/Ne1y2UAI7UdNp2eLyiC68FvFHPgbOt48
 oQWQIZHFD9W/YlUmyLv7uWgEwom4QJIMt0RLMF/wj/fBrCgG4nzY4bTBnQ0GMeebriMY5s2IOtj
 MlzCNa7js6q6cUls/rnetqQN3tjh3IeBvc/n8JpFwCrEu+0H/peBPF
X-Google-Smtp-Source: AGHT+IEhCoEF6FV5/yn3gJnJsUByx5D113oan4ziaWuUdnLN2Q2QT5ILJMYuCofOtEgplHkPcAQk+w==
X-Received: by 2002:a5d:5c89:0:b0:431:5ca:c1a9 with SMTP id
 ffacd0b85a97d-432c3632a04mr24927157f8f.23.1768325236086; 
 Tue, 13 Jan 2026 09:27:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm45254752f8f.42.2026.01.13.09.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 09:27:15 -0800 (PST)
Date: Tue, 13 Jan 2026 09:27:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Hai <haijie1@huawei.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <huangdengdui@huawei.com>
Subject: Re: [PATCH v6 00/25] replace strtok with strtok_r
Message-ID: <20260113092710.5b5c95f5@phoenix.local>
In-Reply-To: <20241122110458.2156907-1-haijie1@huawei.com>
References: <20231113104550.2138654-1-haijie1@huawei.com>
 <20241122110458.2156907-1-haijie1@huawei.com>
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

On Fri, 22 Nov 2024 19:04:32 +0800
Jie Hai <haijie1@huawei.com> wrote:

> Multiple threads calling the same function may cause condition
> race issues, which often leads to abnormal behavior and can cause
> more serious vulnerabilities such as abnormal termination, denial
> of service, and compromised data integrity.
>=20
> This patchset replaces strtok with strtok_r in app, example, lib
> and drivers. And adds check for use of strtok in checkpatches.sh.
>=20
> --
> v6:
> 1. adapt to the newest codes.
> 2. fix compile error.
>=20
> v5:
> 1. remove CC stable for some patch.
> 2. replace strtok for all files.
>=20
> v4:
> 1. fix mispellings.
> 2. add Acked-bys and Reviewd-bys.
> 3. remove some patch and add new.=20
> v3:
> 1. fix compile error.
> 2. use strtok_r instead.
> v2:
> 1. fix commit log.
> 2. add check in checkpatches.sh.
> 3. replace strtok_r with strtok_s.
> 4. add Acked-by.
> --
>=20
> Jie Hai (25):
>   app/bbdev: replace strtok with reentrant version
>   app/compress-perf: replace strtok with reentrant version
>   app/crypto-perf: replace strtok with reentrant version
>   app/dma-perf: replace strtok with reentrant version
>   app/flow-perf: replace strtok with reentrant version
>   app/test-mldev: replace strtok with reentrant version
>   app/test-fib: replace strtok with reentrant version
>   dmadev: replace strtok with reentrant version
>   eal: replace strtok with reentrant version
>   ethdev: replace strtok with reentrant version
>   eventdev: replace strtok with reentrant version
>   security: replace strtok with reentrant version
>   telemetry: replace strtok with reentrant version
>   bus/fslmc: replace strtok with reentrant version
>   common/cnxk: replace strtok with reentrant version
>   event/cnxk: replace strtok with reentrant version
>   net/ark: replace strtok with reentrant version
>   raw/cnxk_gpio: replace strtok with reentrant version
>   net/cnxk: replace strtok with reentrant version
>   common/qat: replace strtok with reentrant version
>   net/mlx5: replace strtok with reentrant version
>   examples/l2fwd-crypto: replace strtok with reentrant version
>   examples/vhost: replace strtok with reentrant version
>   devtools: check for some reentrant function
>   eal/linux: install rte_os_shim.h file
>=20
>  app/test-bbdev/test_bbdev_vector.c            | 42 +++++++++++--------
>  .../comp_perf_options_parse.c                 | 17 ++++----
>  app/test-crypto-perf/cperf_options_parsing.c  | 17 ++++----
>  .../cperf_test_vector_parsing.c               | 11 +++--
>  app/test-dma-perf/main.c                      |  9 ++--
>  app/test-fib/main.c                           | 11 ++---
>  app/test-flow-perf/main.c                     | 23 +++++-----
>  app/test-mldev/ml_options.c                   | 19 +++++----
>  devtools/checkpatches.sh                      |  8 ++++
>  drivers/bus/fslmc/fslmc_bus.c                 |  6 ++-
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  5 ++-
>  drivers/common/cnxk/cnxk_telemetry_nix.c      | 13 +++---
>  drivers/common/qat/qat_device.c               |  6 ++-
>  drivers/event/cnxk/cnxk_eventdev.c            | 12 ++++--
>  drivers/event/cnxk/cnxk_tim_evdev.c           | 12 +++---
>  drivers/net/ark/ark_pktchkr.c                 | 11 ++---
>  drivers/net/ark/ark_pktgen.c                  | 11 ++---
>  drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c  |  6 ++-
>  drivers/net/mlx5/mlx5_testpmd.c               |  5 ++-
>  drivers/raw/cnxk_gpio/cnxk_gpio.c             |  7 ++--
>  examples/l2fwd-crypto/main.c                  |  7 ++--
>  examples/vhost/main.c                         |  4 +-
>  lib/dmadev/rte_dmadev.c                       |  5 ++-
>  lib/eal/common/eal_common_memory.c            |  8 ++--
>  lib/eal/linux/include/meson.build             |  1 +
>  lib/ethdev/rte_ethdev_telemetry.c             | 10 +++--
>  lib/eventdev/rte_event_eth_rx_adapter.c       | 39 ++++++++---------
>  lib/eventdev/rte_eventdev.c                   | 18 ++++----
>  lib/security/rte_security.c                   |  4 +-
>  lib/telemetry/telemetry.c                     |  6 ++-
>  30 files changed, 208 insertions(+), 145 deletions(-)
>=20


This patch series seems to have gotten lost or stalled.
Still worth fixing strtok. But it no longer merges with latest code base.
Also AI code review sees a bug that needs fixing.


## DPDK Patch Evaluation Report

**Series**: v6 strtok =E2=86=92 strtok_r conversion (patches 1/25, 24/25, 2=
5/25 from bundle)

---

### Patch 1/25: `app/bbdev: replace strtok with reentrant version`

#### Commit Message Analysis

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 47 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | "replace" is imperative |
| No trailing period | =E2=9C=85 PASS | |
| Correct prefix | =E2=9A=A0=EF=B8=8F INFO | Uses `app/bbdev:` for `app/tes=
t-bbdev/` =E2=80=94 acceptable shorthand |
| Body =E2=89=A475 chars/line | =E2=9C=85 PASS | |
| Body doesn't start with "It" | =E2=9C=85 PASS | Starts with "Multiple" |
| Signed-off-by present | =E2=9C=85 PASS | Real name, valid email |
| Fixes: tag format | =E2=9C=85 PASS | 12-char SHA with quoted subject |
| Tag order | =E2=9C=85 PASS | Fixes =E2=86=92 blank line =E2=86=92 Signed-=
off-by =E2=86=92 Acked-by |

#### Warnings

| Issue | Severity | Recommendation |
|-------|----------|----------------|
| Missing `Cc: stable@dpdk.org` | =E2=9A=A0=EF=B8=8F WARNING | Bug fix with=
 `Fixes:` tags should include stable backport CC |

#### Code Quality =E2=80=94 **CRITICAL BUG FOUND**

**Error**: Incorrect `strtok_r()` usage in multiple locations.

The patch incorrectly replaces `strtok(NULL, ...)` with `strtok_r(token, ..=
.)` instead of `strtok_r(NULL, ...)` for continuation calls:

```c
/* Lines 187-188: BUG - should be NULL, not token */
-               tok =3D strtok(NULL, VALUE_DELIMITER);
+               tok =3D strtok_r(token, VALUE_DELIMITER, &sp);  // WRONG!
                                ^^^^^ should be NULL
```

This error appears in at least 4 locations:
- Line 188: `cs_theta_0` parsing loop
- Line 203: `cs_theta_d` parsing loop =20
- Line 218: `time_offset` parsing loop
- Line 234: `fft_window_width` parsing loop

**Correct pattern**:
```c
tok =3D strtok_r(token, VALUE_DELIMITER, &sp);  /* Initial call: pass strin=
g */
/* ... */
tok =3D strtok_r(NULL, VALUE_DELIMITER, &sp);   /* Subsequent calls: pass N=
ULL */
```

This bug would cause the parser to restart from the beginning of `token` on=
 each iteration instead of continuing through the string, likely resulting =
in infinite loops or incorrect data parsing.

#### Other Code Observations

| Check | Status |
|-------|--------|
| `#include <rte_os_shim.h>` added | =E2=9C=85 Correct |
| State variable `char *sp =3D NULL` declared | =E2=9C=85 Correct |
| First strtok_r calls pass string | =E2=9C=85 Correct |

---

### Patch 24/25: `devtools: check for some reentrant function`

#### Commit Message Analysis

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 42 characters |
| Correct prefix | =E2=9C=85 PASS | `devtools:` |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| No trailing period | =E2=9C=85 PASS | |
| Signed-off-by | =E2=9C=85 PASS | |
| Cc: stable@dpdk.org | =E2=9C=85 PASS | Present |
| Tag order | =E2=9C=85 PASS | Cc =E2=86=92 blank =E2=86=92 Signed-off-by =
=E2=86=92 Acked-by |

#### Code Review

| Check | Status |
|-------|--------|
| Shell script syntax | =E2=9C=85 Correct |
| awk pattern for `strtok\(` | =E2=9C=85 Correct |
| Consistent with existing checks | =E2=9C=85 Follows established pattern |

**No issues found** =E2=80=94 this patch looks correct.

---

### Patch 25/25: `eal/linux: install rte_os_shim.h file`

#### Commit Message Analysis

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 35 characters |
| Correct prefix | =E2=9C=85 PASS | `eal/linux:` for `lib/eal/linux/` |
| Imperative mood | =E2=9C=85 PASS | |
| Signed-off-by | =E2=9C=85 PASS | |

#### Warnings

| Issue | Severity | Notes |
|-------|----------|-------|
| Missing `Cc: stable@dpdk.org` | =E2=9A=A0=EF=B8=8F WARNING | This is a bu=
ild fix; if backporting the strtok_r changes, this would also be needed |
| No `Fixes:` tag | =E2=84=B9=EF=B8=8F INFO | Could reference the commit th=
at exposed the missing header |

#### Code Review

| Check | Status |
|-------|--------|
| Meson file syntax | =E2=9C=85 Correct |
| Alphabetical ordering | =E2=9C=85 Maintained (rte_os.h =E2=86=92 rte_os_s=
him.h) |
| Trailing comma | =E2=9C=85 Correct for multi-line list |

---

## Summary

| Patch | Verdict | Blocking Issues |
|-------|---------|-----------------|
| 01/25 app/bbdev | =E2=9D=8C **NEEDS REVISION** | Critical bug: `strtok_r(=
token,...)` should be `strtok_r(NULL,...)` for continuation calls |
| 24/25 devtools | =E2=9C=85 **ACCEPTABLE** | None |
| 25/25 eal/linux | =E2=9C=85 **ACCEPTABLE** | Minor: consider adding `Cc: =
stable` |

### Required Actions

1. **Patch 1/25**: Fix all `strtok_r()` continuation calls to pass `NULL` i=
nstead of `token`:
   ```c
   /* Wrong */
   tok =3D strtok_r(token, VALUE_DELIMITER, &sp);
  =20
   /* Correct */
   tok =3D strtok_r(NULL, VALUE_DELIMITER, &sp);
   ```

2. **Patch 1/25**: Consider adding `Cc: stable@dpdk.org` since this is a bu=
g fix.
