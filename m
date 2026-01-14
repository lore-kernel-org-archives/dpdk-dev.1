Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBE6D31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 06:37:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E17F94028F;
	Wed, 14 Jan 2026 07:37:34 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 0140D40289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 07:37:33 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso41454415e9.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 22:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768372653;
 x=1768977453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmtCwlRIG5qaQKCrTYtDPWf9qB1jUMctH1/IHMTEC2E=;
 b=WCFaS0bJp/0rXoPYZn3tR4dx/n4I5QSTrKOi7NGvKajByfKyKz+hgoIcll6ftW9jZa
 k7WxuQnCw3O1PpPEiAIx7Ml54B6O0u4+07F+WFic3KgCeyhoXP9+ODfYph/ATl3HLuBz
 ga2GrARunRBsItjM0ABel8Yczhr30dkyzZDXLZbgPSG+pxph2OY0tgX1OwWT3RhAy9Ir
 X2mjFLgQ9pDcFWBeBdG1S1rchFrSbyTU30hDtkM4AhYeuc/fuYNWuvbdDUkEt2eXqxAY
 Ny5Ur1cYHI/nUNHZVl7MB8xyYWdAmK9PZmtQXRBGhzKDt46yQLQKZZi6UHi/eLc8oMdF
 /gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768372653; x=1768977453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fmtCwlRIG5qaQKCrTYtDPWf9qB1jUMctH1/IHMTEC2E=;
 b=APOEmx3nYipK0WML/4GvRvST22ZwUeGce9N9NWXy8dXWhuBqOq7rPE3BwCvY+DW3/V
 QRTBXztTbcmO7bLZMw7bbUEXTeR/0JZCJ90bWB5k9govP+NfhTo5R8apE0xHAurW3CQF
 HYoPDqCnBPBty6fbvHLY0R3JtsetYeZw2yvy7OZDJhFoo5JxtqwdH1j/e7lD1s67SZhj
 UFOsgUQ1S6XVRMeiz14nfzLW7U4v/s2+ZXPKtyeAAzhpjOD5knUWUHxnvOKFTozWYI7p
 qHeQpjApgIj4M/eslR4hS7FTBvWwiws/tu3jVGDBqumTGGazFBNCMz4uQ1S1mnvS4e8E
 /zug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlw3rcTJI5cmqkBuQVTm6C8zum/8twHAhF40cDm/oh2k4SfyTahkca6+YRG0I3umQqZY8=@dpdk.org
X-Gm-Message-State: AOJu0YyPTGAKm6QTWxxFvU+1xLV4VLJ6aZKjoTzzaQehlFpIC6kXK5TW
 OyIxPxR0C85UHA2/mKOnNneegdyvCfIXuUb7CyDvwaZmgiE2hVDQV4hEvt4eD1O88kI=
X-Gm-Gg: AY/fxX6gBFk0No5GmqFeCPyee9L31EosVT8mIL60vCrvCeIojdTiU1K655IncBSpK+u
 y6LKVPQkctG6Tyxrg4eski5iEN2MxoeGcQ8YIr8XJLx2wr1HoZplFG9Pklwyr6mNz6OEyz3r1M9
 FLeuCrDRDND2cR0S9y1SF1ai8aIKNWRd7QTN/6LdZ90EOpX6+C0IkE4A0Y1i55vXUN8uNlONmQ3
 tDqIGERzEeYNpVfsW2zRaZmvf/Zy6ix2vNqSQeCaDfLyTEWkwgkr0HrFutdXscBgQ0Henqnswyt
 GLv1kAFjwLbX4B64SsWTja/yffyaapf1E5eW0B8Yv8MIxoObX511f6ACVyX6HY2l20DcLI2iLHq
 HxrGWJUGJc4R048d7+lFS3fl6qerakPtuBpj6Oghwwy7m59gs8QzDgGEQ64F4D4ZSABDIzPnpMw
 1vPDerQBoXca7zcdH0OLideSnPxFAoTB1lZACSW0t2GgExML6Ge/+8
X-Received: by 2002:a05:600c:c490:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-47ee338bd38mr12693485e9.33.1768372653343; 
 Tue, 13 Jan 2026 22:37:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee591933bsm11303975e9.15.2026.01.13.22.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 22:37:33 -0800 (PST)
Date: Tue, 13 Jan 2026 22:37:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jake Freeland <jfree@FreeBSD.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, dev@dpdk.org
Subject: Re: [PATCH v2 0/3] EAL memory fixes
Message-ID: <20260113223728.7a7402cf@phoenix.local>
In-Reply-To: <20250814213246.4141803-1-jfree@FreeBSD.org>
References: <20250814213246.4141803-1-jfree@FreeBSD.org>
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

On Thu, 14 Aug 2025 16:32:42 -0500
Jake Freeland <jfree@FreeBSD.org> wrote:

> Hi there,
>=20
> This patchset contains a number of EAL-specific memory fixes that I've
> made over the last year. Two pertain to FreeBSD, one pertains to Linux.
>=20
> v2:
> * Log messages are no longer split across multiple lines.
> * The patch titled "Do not index out of bounds in memseg list" has been
>   removed since there was no indexing out of bounds happening.
> * A new patch has been added per Anatoly's recommendation that starts
>   searching for memseg entries after the last used entry.
>=20
> Jake Freeland (3):
>   eal/freebsd: Do not use prev_ms_idx for hole detection
>   eal/freebsd: Avoid claiming memseg holes
>   eal/linux: Check hugepage access permissions
>=20
>  lib/eal/freebsd/eal_memory.c      | 24 +++++++++++++++++++-----
>  lib/eal/linux/eal_hugepage_info.c |  7 +++++++
>  2 files changed, 26 insertions(+), 5 deletions(-)
>=20

Makes sense. I noticed that AI spotted same dead code as Anatoly.
You might want to fix that before Coverity complains.



## DPDK Patch Review: FreeBSD/Linux Memory Setup Fixes (v2)

**Series:** [PATCH v2 1-3/3] Memory segment and hugepage fixes =20
**Author:** Jake Freeland <jfree@FreeBSD.org> =20
**Acked-by:** Anatoly Burakov <anatoly.burakov@intel.com>

---

### Patch 1/3: eal/freebsd: Do not use prev_ms_idx for hole detection

**Subject Analysis:**
| Check | Status | Notes |
|-------|--------|-------|
| Length =E2=89=A460 chars | =E2=9C=85 Pass | 55 characters |
| Format | =E2=9C=85 Pass | `component: description` |
| Case after colon | =E2=9A=A0=EF=B8=8F Warning | "Do" should be "do" =E2=
=80=94 lowercase required |
| No trailing period | =E2=9C=85 Pass | |
| Signed-off-by | =E2=9C=85 Pass | Present with real name |

**Commit Message Body:**
- =E2=9C=85 Lines within 75 characters
- =E2=9C=85 Does not start with "It"
- =E2=9C=85 Clear explanation of the bug and fix

**Code Review:**
```c
-			if (need_hole && prev_ms_idx =3D=3D ms_idx - 1)
+			if (need_hole &&
+			    rte_fbarray_is_used(arr, ms_idx - 1))
 				ms_idx++;
-			prev_ms_idx =3D ms_idx;
```

- =E2=9C=85 Correctly uses `rte_fbarray_is_used()` API instead of fragile i=
ndex tracking
- =E2=9C=85 Fixes cross-memseg-list logic error
- =E2=9C=85 Clean removal of now-unnecessary variable

**Verdict:** =E2=9C=85 Acceptable =E2=80=94 minor subject case warning

---

### Patch 2/3: eal/freebsd: Avoid claiming memseg holes

**Subject Analysis:**
| Check | Status | Notes |
|-------|--------|-------|
| Length =E2=89=A460 chars | =E2=9C=85 Pass | 42 characters |
| Format | =E2=9C=85 Pass | `component: description` |
| Case after colon | =E2=9A=A0=EF=B8=8F Warning | "Avoid" should be "avoid"=
 |
| No trailing period | =E2=9C=85 Pass | |
| Signed-off-by | =E2=9C=85 Pass | |

**Commit Message Body:**
- =E2=9C=85 Lines within 75 characters
- =E2=9C=85 Does not start with "It"
- =E2=9C=85 Clear problem/solution description

**Code Review:**

```c
start_idx =3D rte_fbarray_find_prev_n_used(
        arr, arr->len - 1, 1) + 1;
if (start_idx < 0)
    start_idx =3D 0;
```

=E2=9A=A0=EF=B8=8F **Warning =E2=80=94 Dead Code:** The condition `if (star=
t_idx < 0)` can never be true. When `rte_fbarray_find_prev_n_used()` return=
s -1 (not found), adding 1 yields 0, which is not < 0. The check is ineffec=
tive. Consider either:
- Removing the dead check (since starting at 0 when nothing found is correc=
t behavior), or
- Checking the return value before adding 1

```c
/* Multi-line comment style is correct */
/* begin our search after the last used
 * element in the list, skipping over
 * any previously placed holes
 */
```
- =E2=9C=85 Comment formatting follows DPDK style

**Verdict:** =E2=9A=A0=EF=B8=8F Minor issues =E2=80=94 dead code check, sub=
ject case

---

### Patch 3/3: eal/linux: Check hugepage access permissions

**Subject Analysis:**
| Check | Status | Notes |
|-------|--------|-------|
| Length =E2=89=A460 chars | =E2=9C=85 Pass | 43 characters |
| Format | =E2=9C=85 Pass | `component: description` |
| Case after colon | =E2=9A=A0=EF=B8=8F Warning | "Check" should be "check"=
 |
| No trailing period | =E2=9C=85 Pass | |
| Signed-off-by | =E2=9C=85 Pass | |

**Commit Message Body:**
- =E2=9C=85 Lines within 75 characters
- =E2=9C=85 Does not start with "It"
- =E2=9C=85 Clear description of the permission issue and fix

**Code Review:**
```c
+	if (access(splitstr[MOUNTPT], R_OK | W_OK) < 0) {
+		EAL_LOG(NOTICE,
+			"Skipping hugepage dir '%s': missing r/w perms",
+			splitstr[MOUNTPT]);
+		continue;
+	}
```

- =E2=9C=85 Correct use of `access()` with R_OK | W_OK
- =E2=9C=85 Appropriate NOTICE log level for skipping mountpoints
- =E2=9C=85 Good defensive programming =E2=80=94 fail gracefully rather tha=
n EACCES later
- =E2=9C=85 Explicit comparison with `< 0` (not implicit boolean)

**Verdict:** =E2=9C=85 Acceptable =E2=80=94 minor subject case warning

---

## Summary

| Patch | Errors | Warnings | Info |
|-------|--------|----------|------|
| 1/3 | 0 | 1 (subject case) | 0 |
| 2/3 | 0 | 2 (subject case, dead code) | 0 |
| 3/3 | 0 | 1 (subject case) | 0 |

### Recommended Actions

**Should fix (Warnings):**

1. **All patches:** Fix subject line capitalization. Per DPDK guidelines, t=
ext after the colon should be lowercase except for acronyms:
   - `eal/freebsd: do not use prev_ms_idx for hole detection`
   - `eal/freebsd: avoid claiming memseg holes`
   - `eal/linux: check hugepage access permissions`

2. **Patch 2/3:** Remove or fix the dead `if (start_idx < 0)` check =E2=80=
=94 it serves no purpose as written.

**Consider (Info):**

3. These appear to be bug fixes. If they fix regressions introduced by spec=
ific commits, consider adding `Fixes:` tags with the 12-character SHA and o=
riginal subject.

4. If these are candidates for stable backport, consider adding `Cc: stable=
@dpdk.org`.

---

**Overall Assessment:** The series is technically sound and addresses real =
bugs in memory segment management. The fixes are well-designed and the comm=
it messages explain the issues clearly. With the minor subject line case fi=
xes and the dead code cleanup in patch 2, this series should be ready for m=
erge.
