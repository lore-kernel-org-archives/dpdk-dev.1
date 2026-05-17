Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C73CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 23:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DA644064A;
	Mon, 18 May 2026 01:56:21 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 092C7402EA
 for <dev@dpdk.org>; Mon, 18 May 2026 01:56:20 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-134fe980658so1963772c88.1
 for <dev@dpdk.org>; Sun, 17 May 2026 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779062179;
 x=1779666979; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lskQTDmmZi+ibD4np1hVGB+S+pXvemfohJCu9Lecpg=;
 b=hc6XEqX12Al1n/c4uid9ohHfFkmuOCIidhVOhUi1BnBqPgpv74Z9rzY1ejY+JMigTw
 kK8x+HfN8iWcN/5b1aXOPjHq+GYcfbXnls7/TseAKDtr5kvGvlUTGMVGDDJ96Au2L0yA
 aqQZ43e8vpYSZMqtL1duZ4ubD/X+BjnvyHRSR0mtMwHpuA8Zp6OLF7nUSWjz31qwCvBt
 55nQ0S1klo30AJUhtQ9oSDg/K9xwJ4llwnj2f21eHn7OhGTpjbjMlW6dti4b/Qw7HK2h
 SRI8SzkEevxFtXAGXeHTf7ncxsW3rbpEHsgTv00hcXSC5n4vXOU/+rsvTONAPhJZU6Ym
 fNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779062179; x=1779666979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7lskQTDmmZi+ibD4np1hVGB+S+pXvemfohJCu9Lecpg=;
 b=IjtwUoYDCXoHUCJJk1aTTNzP/9gmi+lcAqNg9wQEaMHVE9hs7zJKgw00BeXkJB/mAg
 BFm4OUxRnOGWOzeVgscM8uccXCEyLY8n1CE3rkKnKTRMtby65q3iGKX3f8Pnmtl6JkLS
 bDhJHbiEjGbN4CJQO2Vji/y8k2+Vu2l5osnc9OxxLqJI3rlQCkInek/qjcVq0hpPdNdK
 5iIOxTEHtHNln2IgyBMsJp1uBK/xy7OprU7OwqIoG3JV211nDlNvvXzamxTf2vUKXlxB
 Yj1DKzi5y2kwKRuWED4OveM8xeRCSMFu/h/9WmZ8sfol3m7HaRsVoU+Q1RWwGbjWhUzp
 mQvQ==
X-Gm-Message-State: AOJu0YyBW6sAWzCjqCpAIS/NS9aUfIwx6x27Vn9d4AuSt00y1uHVu/s9
 ds+IgMjFNahwIjZHcNQMOGQLu0bk0MKxgKnjya2IZcogoUjocfSt/H7Dp8nG1ASt0Ow=
X-Gm-Gg: Acq92OHjcZRfD3DLYGNNSUDvZCyYSbJFH8OjoT4kVDLRd7GEkXrhcfslMqqWOsVo3RL
 uwxEF+1c0q8VXT8xwE76UJLnngUSOKMdRdqfUoJuzHgZ4vvRbSE/RKtdLRQStjEssRIX9saTa7j
 hTPRjNB058bQPyyQ8sBouooO/IYBjihYoECvZlBuY+YRYPhY5rXUTtjCr2QB9cPhWJJXDsahyVD
 nmm0blD3JcK6QS0DZqm+HF0YCpeKkYnb3iJueo5Vw64Lg2yfPQy1opQvHhKQ7lodvsFJ+yRiW3Q
 +ZHUswOABypkTqa9i4N1+RibsLodGsaKZoj4CRFdygPpRYtri8w2Jtkgitph1FChOj6XcIeV5re
 dD+ytwKK6KypXoooXsKQoPqv3RaBThDZyrm5lQPODuLrX9I/5jWT+AvqLD3Sb46fBKJ4rsruia1
 sgKlzQT9+/7YJYydo/vrezONPLWB3O0pPsQ7U=
X-Received: by 2002:a05:7300:cc15:b0:2f8:1f2b:bb5d with SMTP id
 5a478bee46e88-3039867e93emr5062102eec.25.1779062179014; 
 Sun, 17 May 2026 16:56:19 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bc8ddsm12189379eec.21.2026.05.17.16.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:56:18 -0700 (PDT)
Date: Sun, 17 May 2026 16:39:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v4 04/20] net/ngbe: fix VF promiscuous and allmulticast
Message-ID: <20260517163901.744df0fc@phoenix.local>
In-Reply-To: <20260511103604.19724-5-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-1-zaiyuwang@trustnetic.com>
 <20260511103604.19724-5-zaiyuwang@trustnetic.com>
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

On Mon, 11 May 2026 18:35:46 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> The configuration of allmulti and promiscuous modes conflicts
> together. For instance, if we enable promiscuous mode, then enable and
> disable allmulti, then the promiscuous mode is wrongly disabled.
>=20
> To resolve this, the following changes are made:
> - do nothing when we set/unset allmulti if promiscuous mode is on
> - restore the proper mode (none or allmulti) when we disable
>   promiscuous mode
>=20
> Fixes: 7744e90805b5 ("net/ngbe: add promiscuous and allmulticast ops for =
VF device")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

Worth mentioning, but IMHO this is case of AI being overly pedantic.
Patch is OK as is.


# Review of DPDK Patch: net/ngbe: fix VF promiscuous and allmulticast

## Summary

This patch fixes a mode conflict issue in the ngbe VF driver between promis=
cuous and allmulticast modes. The overall approach is correct: it prevents =
mode conflicts by making allmulticast operations no-ops when promiscuous mo=
de is active, and restores the appropriate mode when disabling promiscuous.

## Errors

None identified.

## Warnings

### 1. Implicit comparison in existing code (line 1226)

**Issue:** The existing code uses `if (dev->data->promiscuous =3D=3D 1)` wh=
ich mixes explicit and implicit styles. The patch changes this to `if (dev-=
>data->promiscuous)` which is implicit.

**Why it matters:** DPDK coding standards require explicit comparisons for =
integers (`!=3D 0` or `=3D=3D 0`).

**Suggested fix:**
```c
/* Line 1226 - be consistent with explicit comparison */
if (dev->data->promiscuous !=3D 0)
    return 0;

/* Line 1250 - same issue */
if (dev->data->promiscuous !=3D 0)
    return 0;
```

Note: While the patch changes `=3D=3D 1` to implicit, the proper fix is to =
use `!=3D 0` since `promiscuous` is an integer field, not a boolean type.

### 2. Error propagation pattern inconsistency

**Issue:** The function `ngbevf_dev_promiscuous_disable()` returns 0 early =
when allmulticast check causes mode selection, but this early return bypass=
es the switch statement's error handling for the actual mode update call.

**Context:** This is not a bug in the patch itself=E2=80=94the early return=
s in `ngbevf_dev_allmulticast_enable()` and `ngbevf_dev_allmulticast_disabl=
e()` when promiscuous mode is active are correct (those are intentional no-=
ops). The mode variable change in `ngbevf_dev_promiscuous_disable()` correc=
tly passes through to the existing switch statement for error handling.

No change needed=E2=80=94this comment is for clarity only.

## Info

### Code structure observation

The logic correctly handles the mode transitions:
- When disabling promiscuous mode, it checks `all_multicast` flag and sets =
the appropriate target mode (ALLMULTI if enabled, NONE otherwise)
- When enabling/disabling allmulticast while promiscuous is active, it retu=
rns early as a no-op (correct, since promiscuous overrides allmulticast)

This is a clean fix for the mode conflict issue described in the commit mes=
sage.

---

## Final Recommendation

Address the implicit comparison style issue (Warning #1) to comply with DPD=
K coding standards. Change `if (dev->data->promiscuous)` to `if (dev->data-=
>promiscuous !=3D 0)` in both locations (lines 1226 and 1250).
