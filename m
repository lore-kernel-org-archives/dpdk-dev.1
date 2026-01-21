Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4638BC44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C79D42DA3;
	Wed, 21 Jan 2026 18:36:06 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 3D3C240261
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:36:05 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso1176075e9.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769016965;
 x=1769621765; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCs+5pMEdDGGgeHoI3dMny/rB7ryWkMBdxUzWbfEMDQ=;
 b=0GrgZqCIdIM3Q1bfNZKrFyqD6vpCEa5TETe9SUF5zIP026fRFb/+8wTpDJo+YqXszL
 w72xZcnsqLujqcYmkeHtAlkfcX1xb3fUMArQZPBwsmQ2L8UvQF31Sy6wxK5QAw8hBlm8
 cO/dUaWz0RLHmNtOvL49gpT3b50ERJ0X+NgJQfvDmZ/oQODlvSejj2ut63zXRGFrXmQp
 rBkNfrRy+5WQj9JW4TGvgsKsf0Elav6PZiRlQGiocHqSVlBbkhQ2Sk5tuT0Iu8vs5PGN
 tlWtmHFCnLzVRu7DJihpEc5YNa189d03AD5pNmYgX9A74fW6NvxSiN+myrfGLC2FnAyv
 K8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769016965; x=1769621765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zCs+5pMEdDGGgeHoI3dMny/rB7ryWkMBdxUzWbfEMDQ=;
 b=OXX1/O9jRMqPmmENhAy1s3k306ki/TnKgmiITkfFFtbG91E1UBzhxzjo+dtI8AI/jF
 dMS7NXeo0G+L409YZFipximpq4eph+66I/Jbk8whbuHy0Fw+SxeOXDiaNM5nuyd6YpcD
 v2T7A+zBtuV86nCsXeYxBd9GyFSIDUUKQRJTrQeSUVGm6UgCZxGAEQ0cH9aOm2Dp82ac
 RziTmvJyEWME82jFPhZffeulC8+BAvvgGJ/7Gf8GRI37CvjeDORuhd2DmufR2cs0ViMN
 orMKDj5Kk2/izErLT9wIN0XUnrIsTcAgZRsiDK7mu2VXUnOv3sZe9xmXe+Q/59j4hly2
 6V5Q==
X-Gm-Message-State: AOJu0YyM9M6B1i5phWNz8ifXeZ9TLoYbVWqLh8PnBpsUSDEpcJVt3ul7
 obXqw/gBQBFlUmGhVx9rphTY72EVqptKDzLJ1l3bFGOaNdKCNy6X3UibMj1UmZa6qqs=
X-Gm-Gg: AZuq6aJ/8GdAxA/40YO/gQO7NlFtRE9zVLpSy0zEROns2pwI43bOs5IgEKTmjCEM36T
 oTpdHSt4qScDssiT256VlxyrTtW15Bo+UahA1ffOcGBmcCqBAUla1mpr7M95CJMD+CK+r9FAJFs
 DPSVd4mpZOEddhIrl9j3arPmaNdMk3AstDmFPL4O/+/B7t/Txm2OqUESu898a/TteOPsr050CT3
 ljmFAaHh2rWpgBkIV6PB7SIutCwz4N6GAgSJJdpxU1vQELd3BgIuJnXZPrmS53qj9TSZUwdqtrZ
 WioNt6Apm8qyuI8vJQeI/OOconIvWerCVL2vUQldB7Jlp+ya0ClxHuS6tFE51OFfVC49C/BE2Cv
 y0cF1ZNQ1v2pwOk4iB3AZ9BmZOAAsRQO84MkeHbRe3IDcSINlfAjHOK5jTM7BgoUpB2dQd+vdSQ
 /61UBMBEyMPhEibmzKIOgjDIFvuIziChFPdhsxD/jlds1YKn7DHRUH
X-Received: by 2002:a05:600c:4e4e:b0:477:7725:c16a with SMTP id
 5b1f17b1804b1-4801e30b74emr276872255e9.10.1769016964692; 
 Wed, 21 Jan 2026 09:36:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cf385sm2774605e9.13.2026.01.21.09.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:36:04 -0800 (PST)
Date: Wed, 21 Jan 2026 09:35:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/6] net/nfb: code cleanup
Message-ID: <20260121093559.6547add0@phoenix.local>
In-Reply-To: <20260121170120.268553-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260121170120.268553-1-spinler@cesnet.cz>
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

On Wed, 21 Jan 2026 18:01:14 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This patchset mainly cleans up the code and prepare it for another
> quite large rework. Also it resolves some unpleasant behavior.
>=20
> ---
> v4:
> * Added comment for process private/shared data.
> * Added Fixes+Cc tag for patch 4,5,6
> * Moved shared data assignments to RTE_PROC_PRIMARY block
>=20
> v3:
> * Changed type of queue count variable to uint16_t.
> * Fixed wrong queue count variable usage in log.
> * Fixed another coding style issues.
>=20
> v2:
> * Fixed coding style issues.
>=20
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
>  drivers/net/nfb/nfb.h        |  14 ++-
>  drivers/net/nfb/nfb_ethdev.c | 166 +++++++++++++++++++++--------------
>  drivers/net/nfb/nfb_rx.c     |   2 +-
>  drivers/net/nfb/nfb_rx.h     |  13 +--
>  drivers/net/nfb/nfb_rxmode.c |  12 +--
>  drivers/net/nfb/nfb_stats.c  |  46 +++++-----
>  drivers/net/nfb/nfb_tx.c     |   2 +-
>  8 files changed, 152 insertions(+), 109 deletions(-)
>=20
> --
> 2.52.0
>=20

Queued to next-net

Verbose AI patch review (if you care) mostly it wants more Fixes: tags.


## NFB Driver Patch Series v4 Review

### Series Overview

This is a 6-patch series fixing multiple bugs in the NFB driver:
1. Use constant values for max Rx/Tx queues count
2. Fix bad pointer access in queue stats =20
3. Update timestamp calculation to meaningful value
4. Use process private variable for internal data
5. Release allocated resources correctly
6. Stop only started queues in fail path

---

### Patch 1/6: `net/nfb: use constant values for max Rx/Tx queues count`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 54 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Correct prefix (`net/nfb:`) | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| No trailing period | =E2=9C=85 PASS | |
| Body =E2=89=A475 chars/line | =E2=9C=85 PASS | |
| Body doesn't start with "It" | =E2=9A=A0=EF=B8=8F WARNING | Starts with "=
The" - acceptable but close |
| `Signed-off-by:` present | =E2=9C=85 PASS | Valid name and email |
| `Fixes:` tag present | =E2=9C=85 PASS | 12-char SHA with quoted subject |
| `Cc: stable@dpdk.org` | =E2=9C=85 PASS | |
| Tag order | =E2=9C=85 PASS | Fixes, then Cc, then blank, then Signed-off-=
by |

**Code Review:**
- Clean change, stores max queue counts in the `pmd_internals` structure
- Properly uses the hardware-reported counts instead of the dynamic `data->=
nb_*_queues` values
- No style issues detected

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 2/6: `net/nfb: fix bad pointer access in queue stats`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 46 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| `Signed-off-by:` present | =E2=9C=85 PASS | |
| `Fixes:` tag | =E2=9C=85 PASS | |
| `Cc: stable@dpdk.org` | =E2=9C=85 PASS | |

**Code Review:**
- Fixes incorrect array-of-structures vs array-of-pointers dereference
- The fix correctly iterates through the queue pointers
- Moves queue pointer fetching inside the loop

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 3/6: `net/nfb: update timestamp calculation to meaningful value`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 53 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| `Signed-off-by:` present | =E2=9C=85 PASS | |
| `Fixes:` tag | =E2=9D=8C MISSING | This changes timestamp semantics - is =
it a bug fix? |
| `Cc: stable@dpdk.org` | =E2=9D=8C MISSING | If this is a behavioral fix, =
it should have these |

**Code Review:**
- Changes timestamp from packed seconds:nanoseconds format to nanoseconds s=
ince epoch
- Documentation updated atomically - good
- Uses `NSEC_PER_SEC` from `<rte_time.h>` - appropriate

**Issue:** The commit body states "The resulting timestamp wasn't monotonic=
ally increasing value" which suggests this IS a bug fix. If so, it should h=
ave:
```
Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
Cc: stable@dpdk.org
```

**Verdict: =E2=9A=A0=EF=B8=8F Needs revision** - Missing Fixes/Cc tags if t=
his is indeed a bug fix

---

### Patch 4/6: `net/nfb: use process private variable for internal data`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 56 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| Body =E2=89=A475 chars/line | =E2=9C=85 PASS | |
| `Signed-off-by:` present | =E2=9C=85 PASS | |
| `Fixes:` tag | =E2=9C=85 PASS | |
| `Cc: stable@dpdk.org` | =E2=9C=85 PASS | |

**Code Review:**
- Properly separates process-private (libnfb handles) from shared data
- Introduces new `struct pmd_priv` for shared data (`max_rx_queues`, `max_t=
x_queues`)
- `struct pmd_internals` now contains process-local handles
- Comments added explaining the purpose of each structure - good

**Style note:** The new struct comment style is good:
```c
/*
 * Handles obtained from the libnfb: each process must use own instance.
 * Stored inside dev->process_private.
 */
```

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 5/6: `net/nfb: release allocated resources correctly`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 47 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| `Signed-off-by:` present | =E2=9C=85 PASS | |
| `Fixes:` tag | =E2=9C=85 PASS | |
| `Cc: stable@dpdk.org` | =E2=9C=85 PASS | |

**Code Review:**
- Refactors error handling in `nfb_eth_dev_init()` to use goto-style cleanup
- Properly sequences resource cleanup:
  - `err_ts_register` =E2=86=92 calls `nfb_eth_dev_uninit()`
  - `err_malloc_mac_addrs` =E2=86=92 deinits rxmac/txmac, closes nfb
  - `err_nfb_open` =E2=86=92 frees internals
  - `err_alloc_internals` =E2=86=92 returns error
- Moves rxmac/txmac deinit and nfb_close from `close()` to `uninit()`
- Adds forward declaration for `nfb_eth_dev_uninit()`

**Minor observation:** The refactored `nfb_eth_dev_close()` properly handle=
s queue cleanup with NULL checks, which is good defensive programming.

**Verdict: =E2=9C=85 Ready for merge**

---

### Patch 6/6: `net/nfb: stop only started queues in fail path`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 48 characters |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | |
| `Signed-off-by:` present | =E2=9C=85 PASS | |
| `Fixes:` tag | =E2=9C=85 PASS | |
| `Cc: stable@dpdk.org` | =E2=9C=85 PASS | |

**Code Review:**
```c
err_tx:
-	for (i =3D 0; i < nb_tx; i++)
-		nfb_eth_tx_queue_stop(dev, i);
+	for (; i > 0; i--)
+		nfb_eth_tx_queue_stop(dev, i - 1);
+	i =3D nb_rx;
err_rx:
-	for (i =3D 0; i < nb_rx; i++)
-		nfb_eth_rx_queue_stop(dev, i);
+	for (; i > 0; i--)
+		nfb_eth_rx_queue_stop(dev, i - 1);
```

- Properly stops only the queues that were successfully started
- Uses the loop counter `i` which indicates where the failure occurred
- The `i =3D nb_rx` assignment before `err_rx` ensures all Rx queues are st=
opped when coming from `err_tx`

**Verdict: =E2=9C=85 Ready for merge**

---

## Summary

| Patch | Status | Action Required |
|-------|--------|-----------------|
| 1/6 | =E2=9C=85 Ready | None |
| 2/6 | =E2=9C=85 Ready | None |
| 3/6 | =E2=9A=A0=EF=B8=8F Warning | Add `Fixes:` and `Cc: stable@dpdk.org`=
 if this is a bug fix |
| 4/6 | =E2=9C=85 Ready | None |
| 5/6 | =E2=9C=85 Ready | None |
| 6/6 | =E2=9C=85 Ready | None |

### Recommendation

The series is well-structured with proper inter-patch dependencies. The v4 =
revision addresses the issue from earlier reviews by properly separating pr=
ocess-private and shared data.

**For patch 3/6:** The commit message describes non-monotonic timestamp beh=
avior as a defect. Please either add the `Fixes:` and `Cc: stable@dpdk.org`=
 tags, or clarify in the commit message that this is an intentional behavio=
ral change rather than a bug fix.

With that clarification/fix, this series is ready for merge.
