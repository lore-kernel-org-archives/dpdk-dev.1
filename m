Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9ADD3900B
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 19:42:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB7CC40DCA;
	Wed, 14 Jan 2026 20:42:09 +0100 (CET)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65]) by mails.dpdk.org (Postfix) with ESMTP id 744344027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 20:42:08 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so236369a12.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 11:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768419728;
 x=1769024528; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ncz4k9AbWzdsXYn/yhNcXSUN0T4bVnNOjBnWRUk0Xs=;
 b=1M+kHS5Q8DkacRXdnW0ODkwz202de//ZakfHm+1llnVQNeocZtAcPa0gdCAgN8RS2u
 sGMDMjSid9LeltmUlSC88SYocsQEtmwyGWVBwKThf3w9BQwKUZllYYEq9uef5gTZtcbu
 NHvnvD4oVQi6+r+R1IV/rnJQ70BM8jeoxJOXI+x/14LEstTxxaFYCm54X/8bRUTp70gM
 G7nIJR+TNIS0RoU2Dm0j+zUYoMfoSjatrdmFAJm0+hJJupH98f3jTPve5VNT4NzPxdsm
 ENnspxRoQOgk1dbbmssI+9pZuZeFU9Wpd6bYUf4FHVJ1gCIYqkj4dqKd7n/RzMw5gD6q
 pqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768419728; x=1769024528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ncz4k9AbWzdsXYn/yhNcXSUN0T4bVnNOjBnWRUk0Xs=;
 b=gVNwCWxYxt1GufFsL9qbWZS/Zb2jyOae/TFJROGgEfknjDrnuWHoLRHJ6oylIDmrp/
 jZbvtiacZyMkr705QypzQuX25OeoLpZu933uElWL6r8HkXKFZUBEOEgXw9I93RuzAAe5
 yXihq10Fm8hZtsDrpnIPwucDbkLRlI77P9mD4Gjxft18i9qGrjFE3BTEHVCV9BjrcwTR
 sYCHgjvpgRoQOsQXMLRkKZ+F6G5cVpR7g/qtFOHhcVU82FeM9SSPWUAhKQXHWOjlc/PK
 sAhMGyIsMfFzolG2aB71HsJZfr/hdOTrHCo2BMwwlOwWSjOBUZFvfWsIPyrWxlVSCfc9
 JeHg==
X-Gm-Message-State: AOJu0Yy4JmT5HFrkkmgK1B8WmPruOyqGzK9TMYwbHDcGNLWPLypflY3A
 7I5cBsXGS40kvDPMD7ER2d7ZuppU3iOVMeZt/Fgvrog6kCOzQ5rsIioOFHRonvPzqD8=
X-Gm-Gg: AY/fxX5lQucyj5PVjEYQOgT1wKc8EMoO9TN8WQEhzcMNWZTASnWsICGTTLJWr89Cxp1
 o8Ycih20FRELDqlLgig4hZ7wRda6Mux3Tk7UGrmW1w3yiZzW3a/IXOpSilve4yhqhPBD8r78RpV
 NaUBb4467n8mxGHL5WFwD+4VrisVGCvcDnYHkI/67SH9oErbUQBNcYKzvPWjgoK1eTGNwRzkJ3n
 7PGC7ErBuXibPi9uqKhyZ98tR6ewD+nxvp/0JqOSz7SSF4f241YKFakbED+agMlxzwRRMGZacIe
 /zn+SKo/Y6vrN8CacaP0awLoGBGJmyOfk+95FvXWTeZ5d0Pys35N1paFA+74LSq+SajIK8DR+AV
 351eRpI/spuifahOU4mNdufT+tBzsE7l7e8Z3gXjWDTgmjgwuiVUDk/Kx5pbUekMnxVapRsYjgj
 jDn1zN3l+ysAY2oXgtdjiOyUwEgYmf3NyWfwxyPrIfCrVod09ys+PB
X-Received: by 2002:a05:6402:40ca:b0:64b:a1e6:8018 with SMTP id
 4fb4d7f45d1cf-653ec46db02mr2774593a12.31.1768419727905; 
 Wed, 14 Jan 2026 11:42:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65411882303sm471149a12.10.2026.01.14.11.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 11:42:07 -0800 (PST)
Date: Wed, 14 Jan 2026 11:42:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>, <honnappa.nagarahalli@arm.com>, <jerinj@marvell.com>,
 <hemant.agrawal@nxp.com>, <drc@linux.ibm.com>
Subject: Re: [PATCH v1 0/4] ring: some fixes and improvements
Message-ID: <20260114114201.31b08d73@phoenix.local>
In-Reply-To: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
References: <20250521111432.207936-1-konstantin.ananyev@huawei.com>
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

On Wed, 21 May 2025 12:14:28 +0100
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> First two patches are =E2=80=98low risk=E2=80=99 ones.
> Third one touches some core functions within rte_ring library and
> would probably requires extra reviews/testing from different vendors.
> 4th one enables C11 based code on all x86 platforms by default.
> The stretch goal for it =E2=80=93 make all supported platforms to use C11
> based code and get rid of legacy code in rte_ring_generic_pvt.h.
> If there would be some issues with latest two patches =E2=80=93 we can li=
mit
> ourselves with just first two to apply.
>=20
> Konstantin Ananyev (4):
>   ring: introduce extra run-time checks
>   ring/soring: fix head-tail synchronization issue
>   ring: fix potential sync issue between head and tail values
>   config/x86: enable RTE_USE_C11_MEM_MODEL by default
>=20
>  config/x86/meson.build           |  1 +
>  lib/ring/rte_ring_c11_pvt.h      | 29 ++++++++++++++++++-----------
>  lib/ring/rte_ring_elem_pvt.h     |  8 ++++++--
>  lib/ring/rte_ring_hts_elem_pvt.h | 14 ++++++++++----
>  lib/ring/rte_ring_rts_elem_pvt.h | 14 ++++++++++----
>  lib/ring/soring.c                |  2 ++
>  6 files changed, 47 insertions(+), 21 deletions(-)
>=20
> --=20

This patch seems to have gotten stuck and never reviewed thoroughly or merg=
ed.
Turned to AI for insight. It found minor things that could be fixed up
when merged. But would be good to have a release note.
Also concerning that the test did not pass CI cleanly.


## DPDK Ring Patchset Review

**Series:** ring head/tail synchronization fixes and C11 memory model enabl=
ement =20
**Author:** Konstantin Ananyev (Huawei) =20
**Patches:** 4

---

### Patch 1/4: `ring: introduce extra run-time checks`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | 44 characters |
| Lowercase after colon | =E2=9C=93 | |
| Component prefix | =E2=9C=93 | `ring:` is correct |
| Imperative mood | =E2=9C=93 | |
| No trailing period | =E2=9C=93 | |
| Signed-off-by | =E2=9C=93 | |

**Code Review:**

The patch adds `RTE_ASSERT()` calls to verify `*entries` and `*free_entries=
` remain =E2=89=A4 `r->capacity` after `move_head()` calls. This is a sensi=
ble defensive check.

**Issue (Warning):** In `rte_ring_c11_pvt.h`, the code reordering moves `*n=
ew_head =3D *old_head + n;` before the `n =3D=3D 0` check:

```c
+		*new_head =3D *old_head + n;
 		if (n =3D=3D 0)
 			return 0;
-		*new_head =3D *old_head + n;
```

This is functionally correct (setting `*new_head` even when returning 0 is =
harmless), but the change seems unrelated to adding asserts. If intentional=
, the commit message should explain why.

**Verdict:** =E2=9C=93 Acceptable with minor observation

---

### Patch 2/4: `ring/soring: fix head-tail synchronization issue`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | 47 characters |
| Lowercase after colon | =E2=9C=93 | |
| Component prefix | =E2=9C=93 | `ring/soring:` correct |
| Fixes tag | =E2=9C=93 | `Fixes: b5458e2cc483` present |
| Signed-off-by | =E2=9C=93 | |
| Body =E2=89=A475 chars | =E2=9C=93 | Lines properly wrapped |

**Technical Analysis:**

Excellent, detailed commit message explaining the race condition discovered=
 on Ampere Altra Max. The fix adds `rte_atomic_thread_fence(rte_memory_orde=
r_release)` after `store(&tail)` operations.

**Code Review:**

```c
+	/* make sure that new tail value is visible */
+	rte_atomic_thread_fence(rte_memory_order_release);
```

This ensures the tail update is visible before any subsequent head updates.=
 However, I note this is described as a workaround=E2=80=94patch 3/4 provid=
es the "better" fix at the CAS level.

**Question:** If patch 3/4 provides the comprehensive fix, why is patch 2/4=
 kept separate? The comment mentions observing on Ampere Altra Max=E2=80=94=
should `Cc: stable@dpdk.org` be added since this is a real bug fix?

**Verdict:** =E2=9C=93 Acceptable (consider adding `Cc: stable@dpdk.org`)

---

### Patch 3/4: `ring: fix potential sync issue between head and tail values`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=97 **ERROR** | **63 characters** (limi=
t is 60) |
| Fixes tags | =E2=9C=93 | Multiple Fixes present |
| Signed-off-by | =E2=9C=93 | |

**Error:** Subject line exceeds 60-character limit:
```
ring: fix potential sync issue between head and tail values
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        63 characters
```

**Suggested fix:**
```
ring: fix head-tail sync in C11 memory model
```

**Technical Analysis:**

This is the core fix=E2=80=94changing CAS memory ordering from RELAXED to A=
CQ_REL:

```c
-			rte_memory_order_relaxed,
-			rte_memory_order_relaxed);
+			rte_memory_order_acq_rel,
+			rte_memory_order_acquire);
```

The comments explaining the change are well-written:
```c
+			 * this CAS(ACQ_REL, ACQUIRE) serves as a hoist
+			 * barrier to prevent:
+			 *  - OOO reads of cons tail value
+			 *  - OOO copy of elems from the ring
+			 *  Also RELEASE guarantees that latest tail value
+			 *  will become visible before the new head value.
```

**Code Review Issues:**

1. **Redundant fences in soring.c removed:** The patch removes the fences a=
dded in patch 2/4. This creates a forward dependency=E2=80=94patch 2/4 adds=
 them, patch 3/4 removes them. This violates the "each commit must compile =
independently" guideline. Consider squashing patches 2 and 3, or reordering=
 so patch 3's ACQ_REL fix comes first.

2. **Missing `Cc: stable@dpdk.org`:** This fixes real bugs that could affec=
t production systems.

3. The d->head load changes from RELAXED to ACQUIRE:
```c
 	*old_head =3D rte_atomic_load_explicit(&d->head,
-			rte_memory_order_relaxed);
+			rte_memory_order_acquire);
```
Combined with removing the explicit thread fence, this is cleaner but chang=
es the synchronization model significantly. The comment update is appropria=
te.

**Verdict:** =E2=9C=97 Needs revision (subject too long, patch ordering con=
cern)

---

### Patch 4/4: `config/x86: enable RTE_USE_C11_MEM_MODEL by default`

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | 52 characters |
| Component prefix | =E2=9C=93 | `config/x86:` correct |
| Signed-off-by | =E2=9C=93 | |

**Code Review:**

Simple config change:
```c
+dpdk_conf.set('RTE_USE_C11_MEM_MODEL', true)
```

**Concerns:**

1. **Missing release notes:** Enabling C11 memory model by default on x86 i=
s a significant behavioral change. Per AGENTS.md, API/config changes warran=
t release notes updates.

2. **Documentation:** Should document this change in programmer's guide or =
platform notes.

3. **Dependency on patch 3:** This change depends on the memory ordering fi=
xes in patch 3/4 being correct. The commit message acknowledges this ("step=
 towards unification...removing rte_ring_generic_pvt.h") but the series sho=
uld ensure the fixes are validated before enabling C11 model by default.

**Verdict:** =E2=9A=A0 Acceptable with warning (needs release notes)

---

## Summary

| Patch | Status | Issues |
|-------|--------|--------|
| 1/4 | =E2=9C=93 OK | Minor: unexplained code reorder |
| 2/4 | =E2=9A=A0 Warning | Missing `Cc: stable@dpdk.org` |
| 3/4 | =E2=9C=97 **ERROR** | Subject 63 chars (max 60), patch ordering iss=
ue |
| 4/4 | =E2=9A=A0 Warning | Missing release notes |

## Recommendations

1. **Fix patch 3/4 subject line** =E2=80=94 shorten to under 60 characters
2. **Consider squashing patches 2+3** =E2=80=94 patch 2 adds fences, patch =
3 removes them; this creates odd bisect behavior
3. **Add `Cc: stable@dpdk.org`** to patches 2 and 3 as they fix real bugs
4. **Add release notes** for patch 4/4 documenting the C11 memory model ena=
blement on x86
5. The technical analysis of the memory ordering issue is thorough and the =
fix approach (ACQ_REL on CAS) is sound for weakly-ordered architectures
