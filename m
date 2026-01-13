Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A1BD2F338
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA619402D8;
	Tue, 13 Jan 2026 16:33:06 +0100 (CET)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65]) by mails.dpdk.org (Postfix) with ESMTP id 7843640276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:33:05 +0100 (CET)
Received: by mail-ed1-f65.google.com with SMTP id
 4fb4d7f45d1cf-65089cebdb4so10516119a12.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768318385;
 x=1768923185; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t68w/E2X3gbMri6ztnFV3mOS9Dh4QVvojTdgEg1EHpU=;
 b=OUeqCN9SVt4Lo5AlgzqhiJWewsDFiw/z+NRjEpSnz2bpAvDq73EmRWBZzyv6h/5qP6
 uGz7LRosILTwUbc17By28ZvwHpLQ0izl0rA8RYmj+AlUWv9SK1xjKraeKgLwKcZtYkAv
 vtLzh5SlLQ1Ffy9bqAjrBO5O/eiwxBoJIkRW/84nA33ryiyrxzmdESB34bZ5PFcf4zNa
 nKnRI0IQmEZQjUyI8NyvFmBHjcPZy4CRNYZ0kJl+iIX5aLxVWnv26nTHI7ZIyyT6GNQo
 OmgEJsYYvlFcnW4zBeJAURZYfuNQ+eoJJniWXJ327jFZG2d3foCguE+9TTohexR/xaVf
 UJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768318385; x=1768923185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t68w/E2X3gbMri6ztnFV3mOS9Dh4QVvojTdgEg1EHpU=;
 b=VulkmMrnE9SWNw0UzVFGgWwJIDpVPMhYz3So6egn+KSIbQTMpqr/DzYdAwEz19X6VI
 m3aNuFos4GK6S6FhjAReHFw12zvkZFJghCRoHav1X6aXZ4ide2o3ToyV0sWQ8VFE3n4n
 fMrmTILbHpajheQZsbgAzuRpJrc9OnC3QCbBp4oKRmudPPtUs3jicg98Fv9yloNArGW7
 cGO1ESEIvy557u7kTZVse/Qz0cYJQU2OzVDLEGBerua2HzFhfiNBrTd9jLwv6pBPU4sN
 v4ltImplAItVc7k5B+Vns/OnnwAO48UYtBYJHs87qIvUV080COiKNxZEvzKyRdwYnGeM
 iGaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/YmNwGZMoRvEfjpJPrehV4hUGgEpUUvm4lSwzN750mAclyv0kAu01csvy4lsmux4y5/c=@dpdk.org
X-Gm-Message-State: AOJu0YzhyiBWuqbNSF/W67qtqQkdMj1dXFl1mdprinr5MUR2HfyzrZ8M
 FkNl0ET5xsqfV9Oz1q0byUIuIt3jRQaHZs03BR80xtQzLEKpdCEFZh4pcGG1+gBVBfY=
X-Gm-Gg: AY/fxX7oKbyZPYav9zURq1kQg9RLZt3/uCaU9+jwBR+U+DZEFhYy71rMbCfExa1YuFf
 iDLd0uD64P+x4Wq6KEY49JlA0trg9Sjko/DaxqsJ4uFIBv1PJTXnQH0TYO7gmCD1Ff2ojLVKYfz
 sgD5bvj0LB49Id2vn/zlVHTGCAY/6E1GM4mrrQ4ANaa0HLQQmQpYEaF1clZANujpciqS1DH/Agi
 1TLiwDNadyDPNzNDjN8hPGJt85KnyMgsRqVzEpshUI4RNWUDwtMAQ+5iq/2DZAsJahqqBUv/0iT
 cImcUENBk2ughTXEFss3BWr7lLt7Pu7rM48ZhudZt5mKITEPTSnFXLi4cZfJgLbAeWeRv4QS4ka
 mjigKiSsMhypf3c5GJA8+GT5R0bvn9WeJgsudkgeUSCbObVM7ZAJHbs1fLNfkIfaEWI4/stQ7qc
 xC+JVL7H9RPhBKep/gdEb0keI4m9KtGl77DLpgab51g9Qwc7rlHZQG
X-Google-Smtp-Source: AGHT+IHfdvA+Ua4FdnEGBClzvBj+Eq2CIlOU5jWKnK9WBkg4/Mx+h1245auZL7ht6U8JxUoW7IJ1Ig==
X-Received: by 2002:a05:6402:27ca:b0:64c:9e19:9831 with SMTP id
 4fb4d7f45d1cf-65097de5b1fmr19934099a12.12.1768318384966; 
 Tue, 13 Jan 2026 07:33:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c4479sm20638944a12.1.2026.01.13.07.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 07:33:04 -0800 (PST)
Date: Tue, 13 Jan 2026 07:32:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1 0/2] fix bug
Message-ID: <20260113073258.2d67ed02@phoenix.local>
In-Reply-To: <20251222102535.401064-1-zhang.tianhao2@zte.com.cn>
References: <20251209021609.3911854-1-zhang.tianhao2@zte.com.cn>
 <20251222102535.401064-1-zhang.tianhao2@zte.com.cn>
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

On Mon, 22 Dec 2025 18:25:33 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> V1:
>   - Add pcie bar channel check after getting dtb space left.
>   - Delete np soft resource uninstallation from NP online uninit process.
>=20
> Tianhao Zhang (2):
>   net/zxdh: add pcie bar channel check
>   net/zxdh: delete np soft resource uninstallation
>=20
>  drivers/net/zxdh/zxdh_np.c | 11 +++++++----
>  drivers/net/zxdh/zxdh_np.h |  2 ++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>=20

I started using AI to review code in next-net.
It spotted some issues in these patches, please revise and resubmit.

Now let me read the two patches:---

## DPDK Patch Review: ZXDH PMD Patches

### Patch 1: `net/zxdh: add PCIe BAR channel check`

#### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 Pass | 35 characters |
| Correct prefix | =E2=9C=93 Pass | `net/zxdh:` is correct |
| Lowercase after colon | =E2=9C=93 Pass | |
| Imperative mood | =E2=9C=93 Pass | "add" |
| No trailing period | =E2=9C=93 Pass | |
| Body =E2=89=A475 chars/line | =E2=9C=93 Pass | |
| Body doesn't start with "It" | =E2=9C=93 Pass | |
| Signed-off-by present | =E2=9C=93 Pass | Real name and valid email |

#### Code Review

**Style Issues (Warning)**:
1. **Mixed changes**: The patch combines alignment/whitespace fixes with fu=
nctional changes. The parameter alignment changes in `zxdh_np_dtb_queue_unu=
sed_item_num_get()` could be a separate cleanup patch. This makes the funct=
ional change harder to review.

2. **Log message style**: The error message `"pcie bar abnormal."` has a tr=
ailing period. While not strictly forbidden, DPDK log messages typically om=
it trailing periods for consistency.

**Code Quality (Info)**:
```c
if ((*p_item_num & ZXDH_DTB_SPACE_LEFT_MASK) =3D=3D ZXDH_DTB_SPACE_LEFT_MAS=
K) {
```
- The comparison is explicit (good) =E2=9C=93
- Uses named constant (good) =E2=9C=93
- Consider: what condition does `0x3F` represent? A brief comment explainin=
g why this specific bit pattern indicates a BAR abnormality would aid maint=
ainability.

**Commit Message Content (Warning)**:
The body text:
> After obtaining the DTB element register;
> check if the PCIe link is abnormal.

The semicolon makes this read awkwardly as two sentence fragments. Suggeste=
d rewrite:
> Add a check after obtaining the DTB element register to detect
> abnormal PCIe link conditions.

#### Verdict: **Acceptable with minor suggestions**

---

### Patch 2: `net/zxdh: optimize the procedure for NP online uninit`

#### Commit Message

| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 Pass | 52 characters |
| Correct prefix | =E2=9C=93 Pass | `net/zxdh:` |
| Lowercase after colon | =E2=9C=93 Pass | |
| Imperative mood | =E2=9C=93 Pass | "optimize" |
| No trailing period | =E2=9C=93 Pass | |
| Body =E2=89=A475 chars/line | =E2=9C=93 Pass | All lines under 75 |
| Body doesn't start with "It" | =E2=9C=93 Pass | Starts with "Remove" |
| Signed-off-by present | =E2=9C=93 Pass | |

#### Issues Identified

**Warning - Misleading subject line**:
The subject says "optimize" which implies performance improvement, but the =
body describes removing code to "avoid duplicate resource release." This is=
 actually a **bug fix** (preventing double-free or duplicate cleanup), not =
an optimization.

Suggested subject alternatives:
- `net/zxdh: fix duplicate resource release in NP online uninit`
- `net/zxdh: remove redundant resource uninstall from online uninit`

**Warning - Potentially missing `Fixes:` tag**:
If this corrects a bug where resources were being released twice, a `Fixes:=
` tag should reference the commit that introduced the duplicate release. Th=
e AGENTS.md guidelines state:
> `Fixes:` tag present for bug fixes with 12-char SHA and exact subject

**Info - Incomplete context**:
The commit message says the uninstallation "should be called separately wit=
hin NP uninit" but doesn't specify where that happens. A reference to the f=
unction or location where `zxdh_np_soft_res_uninstall()` is properly called=
 would help reviewers verify correctness.

#### Code Review

The code change itself is clean - a straightforward removal of 4 lines. No =
style issues.

#### Verdict: **Needs revision**

---

## Summary

| Patch | Status | Required Actions |
|-------|--------|------------------|
| 0007 (BAR check) | **Acceptable** | Consider separating alignment fixes; =
improve commit message clarity |
| 0008 (uninit optimize) | **Needs revision** | Fix subject line ("fix" not=
 "optimize"); add `Fixes:` tag if applicable; clarify where resource uninst=
all is now called |
