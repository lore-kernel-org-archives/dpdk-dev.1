Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F19D4A603
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 05:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E325140664;
	Fri, 16 Jan 2026 06:48:57 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 55B774014F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 06:48:56 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso10866795e9.1
 for <dev@dpdk.org>; Thu, 15 Jan 2026 21:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768542536;
 x=1769147336; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0yv6AUo60qkjQMptjQWwum5oM3qWDIYjfwTLeSIAeQ=;
 b=PIZPh5f/oFsouxfl6QXGQPeU2AF0ka7CbVHjGBYDKix6d6sjMSTpRIbfUMtSyNCBSy
 ik1BwfpzuT4OQccl3vYrk76DrPD4pVz6mH3pRyRPznQELgky+Fo+hMz2P5MxHOs0fGMP
 3kH6eJFvK5nmBRtq2q5N3mZ1lL4JO939mKWNX+cRLrk4Xg6qLKI2dBC+wk8bYnHqFUI7
 v2CBYxJNOU+p8unrJko87Ys1In2h1b6p4RhvhL6IXGmJDt8Ui7nUD2SjCYTCpUnO9m/A
 unWrfxu+Rr+yAm3c6n1ifSZ5NxWSgHKvRqMnkItRDGCtN5sE8khjjuLrtoFdSWhQfp4V
 n5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768542536; x=1769147336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J0yv6AUo60qkjQMptjQWwum5oM3qWDIYjfwTLeSIAeQ=;
 b=dBHUmdqU45/e4Moq0XJif2sd+WL5oYBOyhoH989T700dwzVhFzGp9G0Qp/FDWIbQm7
 EOourOoj/N5BvJGYkOKHFVYLIFiNChUBzmJWdZZRpCNpwUsEibzz1N4RuOfcjGWYU816
 ztgArhVmZHZdwobvsgX4TYS7Q7t0UDbtslhF3U3qVIXMwhuhOOZUjejlbA/Cp/ZOO5UU
 FjhfGOGCOEavwut7P6nYXag77/N/gt2iDDYDp+F1Mk9p4+NL0yBAHXwrLvKr2Z1zCGID
 X9F5dHQ8NxLGK3pafnFbQfqwMRGSYcZedIf9UxB5BQTAHedfgqk0LkU/D0rlMJ8rY3Q8
 4AiA==
X-Gm-Message-State: AOJu0YwhMnP7c5c13UofTW6oFM02ZY6jxAPlY752ubGrMd2vwa4S7GQp
 2HABvhC9KwFyHVmN1FBY9Vq1XRXp54PfucaVP/+7sq7p2TsHdx1ZO4BSv6bjB2As9cGVJAzN8jN
 h4jBK
X-Gm-Gg: AY/fxX4g1fejhO9TzMfqcg5ZmiNuLNdA8J6/NFGOKVBIGNMqSzT1uu0JVNERrW9a9co
 U0FhN7J7l7xVbJbs0noZKyt+ZXAhl/GFqrPHG8skQF52YGZZvDDht/4fiOyIv/fm0iiF6WKrU96
 5sZ6V1SF8lTeJrmmpSnxPqPYG9btH18+R7tBXXAPP8uClyr4Gw3S3Kvh2rA8hMsAadPJLAWp+NR
 FRmglOVnPYlVgvaGI11fuZ08C5ic49eBW4YtZ4HLQ+KiDRv2BuJYP996xXZjU39tZ3v8sxbLq1o
 4HbYr3Kaxuw2q6J8nBX2dDt+I/mDgY75IDgdmMDMBN4UN2id+SvjeY/dPtj0sdPtSP6XK5c1oBw
 rkHzDykcofvoCMAwOEOWM9FjlhYF32WINGeg+mWfN7QasPuHoF0iciADh5M9to/2pBY16rEFaIY
 lwlw2OU9itcIkoRxqqNi6SFvcE+3PAG/Q4xxdvQyGsqM5JOJK1iDvh
X-Received: by 2002:a05:600c:4094:b0:47a:8383:f2b2 with SMTP id
 5b1f17b1804b1-47f44d4dfb4mr41611345e9.17.1768542535332; 
 Thu, 15 Jan 2026 21:48:55 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428b954esm80347445e9.7.2026.01.15.21.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 21:48:54 -0800 (PST)
Date: Thu, 15 Jan 2026 21:48:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/6] net/nfb: code cleanup
Message-ID: <20260115214849.623db82c@phoenix.local>
In-Reply-To: <20260115144040.345873-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260115144040.345873-1-spinler@cesnet.cz>
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

On Thu, 15 Jan 2026 15:40:34 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This patchset mainly cleans up the code and prepare it for another
> quite large rework. Also it resolves some unpleasant behavior.
>=20
> ---
> v2:
> * Fixed coding style issues
>=20
> Martin Spinler (6):
>   net/nfb: use constant values for max Rx/Tx queues count
>   net/nfb: fix bad pointer access in queue stats
>   net/nfb: update timestamp calculation to meaningful value
>   net/nfb: use process private variable for internal data
>   net/nfb: release allocated resources correctly
>   net/nfb: stop only started queues in fail path
>=20
>  doc/guides/nics/nfb.rst      |   6 +-
>  drivers/net/nfb/nfb.h        |   5 ++
>  drivers/net/nfb/nfb_ethdev.c | 165 ++++++++++++++++++++---------------
>  drivers/net/nfb/nfb_rx.c     |   2 +-
>  drivers/net/nfb/nfb_rx.h     |  13 +--
>  drivers/net/nfb/nfb_rxmode.c |  12 +--
>  drivers/net/nfb/nfb_stats.c  |  46 +++++-----
>  drivers/net/nfb/nfb_tx.c     |   2 +-
>  8 files changed, 142 insertions(+), 109 deletions(-)
>=20
> --
> 2.52.0
>=20

Looks ok but AI code review spotted somethings that need to be addressed.


---

## DPDK NFB Driver Patchset Review

**Series:** net/nfb cleanup (6 patches, v2)
**Submitter:** Martin Spinler <spinler@cesnet.cz>

---

### Patch 1/6: `net/nfb: use constant values for max Rx/Tx queues count`

| Check | Status | Notes |
|-------|--------|-------|
| Subject length | =E2=9C=85 PASS | 51 chars (=E2=89=A460) |
| Subject format | =E2=9C=85 PASS | Lowercase after colon, no trailing peri=
od |
| Component prefix | =E2=9C=85 PASS | `net/nfb:` is correct |
| Signed-off-by | =E2=9C=85 PASS | Present with valid name/email |
| Fixes tag | =E2=9C=85 PASS | `Fixes: 6435f9a0ac22` (12-char SHA) |
| Cc: stable | =E2=9C=85 PASS | Present |
| Tag order | =E2=9C=85 PASS | Fixes before Cc, blank line before Signed-of=
f-by |
| Body doesn't start with "It" | =E2=9C=85 PASS | Starts with "The" |

**Code Review:**
- Clean addition of `max_rx_queues` and `max_tx_queues` to `pmd_internals` =
structure
- Proper initialization from hardware counts instead of mutable `nb_*_queue=
s`

**Issue (Warning):** The log message at line 543 still references `data->nb=
_rx_queues` / `data->nb_tx_queues` which will be 0 at that point since they=
're no longer initialized. Should log `internals->max_rx_queues` and `inter=
nals->max_tx_queues` instead.

---

### Patch 2/6: `net/nfb: fix bad pointer access in queue stats`

| Check | Status | Notes |
|-------|--------|-------|
| Subject length | =E2=9C=85 PASS | 47 chars |
| Subject format | =E2=9C=85 PASS | Correct format |
| Signed-off-by | =E2=9C=85 PASS | Present |
| Fixes tag | =E2=9C=85 PASS | Present with 12-char SHA |
| Cc: stable | =E2=9C=85 PASS | Present |
| Body doesn't start with "It" | =E2=9C=85 PASS | Starts with "The" |

**Code Review:**
- Correctly fixes the pointer dereference pattern from `rx_queue[i].rx_pkts=
` to `rx_queue->rx_pkts`
- The original code treated an array of pointers as an array of structures =
=E2=80=94 this is a legitimate bug fix

**Issue (Warning):** Still missing NULL pointer checks before dereferencing=
 `dev->data->rx_queues[i]` and `dev->data->tx_queues[i]`. The commit messag=
e mentions the pointer can be NULL, but the fix doesn't add the NULL check.

---

### Patch 3/6: `net/nfb: update timestamp calculation to meaningful value`

| Check | Status | Notes |
|-------|--------|-------|
| Subject length | =E2=9C=85 PASS | 55 chars |
| Subject format | =E2=9C=85 PASS | Correct format |
| Signed-off-by | =E2=9C=85 PASS | Present |
| Fixes tag | =E2=9A=A0=EF=B8=8F **MISSING** | This is a bug fix (non-monot=
onic timestamp) |
| Cc: stable | =E2=9A=A0=EF=B8=8F **MISSING** | Should be present for bug f=
ixes |
| Body doesn't start with "It" | =E2=9C=85 PASS | Starts with "The" |
| Doc + code atomic | =E2=9C=85 PASS | Both `nfb.rst` and `nfb_rx.h` update=
d together |

**Recommendation:** Add:
```
Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
Cc: stable@dpdk.org
```

---

### Patch 4/6: `net/nfb: use process private variable for internal data`

| Check | Status | Notes |
|-------|--------|-------|
| Subject length | =E2=9C=85 PASS | 56 chars |
| Subject format | =E2=9C=85 PASS | Correct format |
| Signed-off-by | =E2=9C=85 PASS | Present |
| Fixes tag | =E2=9A=A0=EF=B8=8F **MISSING** | This fixes multi-process sup=
port |
| Cc: stable | =E2=9A=A0=EF=B8=8F **MISSING** | Should be present for fixes=
 |

**Code Issues:**

1. **Error (Style):** Line 148 changes a Doxygen comment to broken format:
   ```c
   -/**
   +/* *
   ```
   This breaks Doxygen documentation parsing. Should remain `/**` or be cha=
nged to `/*` (without the space after asterisk).

2. **Warning:** The new `struct pmd_priv` only contains `max_rx_queues` and=
 `max_tx_queues` as `int` types. These should likely be `uint16_t` to match=
 the DPDK convention for queue counts.

---

### Patch 5/6: `net/nfb: release allocated resources correctly`

| Check | Status | Notes |
|-------|--------|-------|
| Subject length | =E2=9C=85 PASS | 49 chars |
| Subject format | =E2=9C=85 PASS | Correct format |
| Signed-off-by | =E2=9C=85 PASS | Present |
| Fixes tag | =E2=9A=A0=EF=B8=8F **MISSING** | This fixes resource leaks |
| Cc: stable | =E2=9A=A0=EF=B8=8F **MISSING** | Should be present |

**Code Review:**
- Good refactoring of cleanup paths using `goto` error handling
- Properly separates primary vs secondary process cleanup

**Issue (Warning):** Forward declaration added at line 21:
```c
static int nfb_eth_dev_uninit(struct rte_eth_dev *dev);
```
This is fine, but the blank line before it creates two consecutive blank li=
nes which is non-standard.

---

### Patch 6/6: `net/nfb: stop only started queues in fail path`

| Check | Status | Notes |
|-------|--------|-------|
| Subject length | =E2=9C=85 PASS | 47 chars |
| Subject format | =E2=9C=85 PASS | Correct format |
| Signed-off-by | =E2=9C=85 PASS | Present |
| Fixes tag | =E2=9A=A0=EF=B8=8F **MISSING** | This is a bug fix |
| Cc: stable | =E2=9A=A0=EF=B8=8F **MISSING** | Should be present |

**Code Review:**
- Correctly uses reverse iteration to only stop queues that were successful=
ly started
- Loop logic is correct: `for (; i > 0; i--)` then `stop(dev, i - 1)`

---

## Summary

### Errors (Must Fix)

| Patch | Issue |
|-------|-------|
| 4/6 | Broken Doxygen comment: `/* *` should be `/**` or `/*` |

### Warnings (Should Fix)

| Patch | Issue |
|-------|-------|
| 1/6 | Log message references uninitialized `data->nb_*_queues` |
| 2/6 | Missing NULL checks for queue pointers (mentioned in commit but not=
 implemented) |
| 3/6 | Missing `Fixes:` tag and `Cc: stable@dpdk.org` |
| 4/6 | Missing `Fixes:` tag and `Cc: stable@dpdk.org`; consider `uint16_t`=
 for queue counts |
| 5/6 | Missing `Fixes:` tag and `Cc: stable@dpdk.org`; extra blank line be=
fore forward declaration |
| 6/6 | Missing `Fixes:` tag and `Cc: stable@dpdk.org` |

### Info (Consider)

- The series is well-structured with logical patch ordering
- Good that patches 1 and 2 have proper `Fixes:` tags =E2=80=94 patches 3-6=
 should follow the same pattern
- Documentation is updated atomically with code in patch 3

### Verdict

**Needs revision.** The main blocker is the broken Doxygen comment in patch=
 4/6. Additionally, patches 3-6 should have `Fixes:` tags and `Cc: stable@d=
pdk.org` since they all fix bugs in the original driver.
