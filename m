Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348BAD30CF5
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 01:17:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FA9F40431;
	Wed, 14 Jan 2026 02:17:45 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 551DF402A7
 for <dev@dpdk.org>; Wed, 14 Jan 2026 02:17:43 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-432d2670932so3876909f8f.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 17:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768353462;
 x=1768958262; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSVKxd6+L9+EEBrSNS2sLmf9gq0ZJVg3Af9YcPPPzTQ=;
 b=AhnQ8bJBcaLJIY92swZemfzYKX5L1icHuciCwKlnlm94TNVk+3ifPypvk6KL2JtnMj
 trP59CrlL66Cq2SykxXOVBh707oellYkfOyXX8IgOzSxnhP/MC68QHBUSXoByqc2fuf/
 /Ooj/nfwHtxZABMY3kFj8T2G94AqIyCWpce/gHmzJ1AasuWRM5pmdcCwic478mQ6nkfm
 PEyJ8l6H5oopga19FAJ3zPVN4PRofNfuIZZzDOzXPADejV3Zjo3sxx8y+oUde8ond35/
 NBLCBWfcMfZRD/MJqUC/ivzOC37WNoPubiy5vxn3eidFew/CHiNteMty0K39/mEuag5a
 ArPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768353462; x=1768958262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xSVKxd6+L9+EEBrSNS2sLmf9gq0ZJVg3Af9YcPPPzTQ=;
 b=CbYfBGWM3pUcUdqS5r20a63DhV0P7ysnRwvVR6DRQFVsftHmcT3r2HL7pfAUffaP9c
 DQakiuMUvJfyQaUr11+kUXjJrvGaeH2xNlhxoLitiWNY3THBDfvMh/R4XpwLQ3vYoRRY
 Bjwvql9gWRkJeWmTxjy7eD5OOpqtTP6qxH/mvUEvMZDqNu3NNFQgMvI0/xy9ZIbvmR5D
 z/qrRiYdplL79dx4lBfm0mwR592QSQtg9ErassfYMWrLqUPjCNzqP66rT8VKYI9S35eu
 /RU6Gzc9LfAVdvJkUcLuyrzFzEm7pw4mKabFFq1YZ1Y/uHjbQiOP+PE5o5UgJFRks6xm
 vAmQ==
X-Gm-Message-State: AOJu0YzZ95azMF2y6l7F8BcnW76HPSQ+0VLABmXRqfILXNd1n0Af0/zZ
 TEehOIgxuDW2pEZyeKnNfIzr5pi533FsplfAVP56VTOBurtMllUHQlQOKp31X5V6DJM=
X-Gm-Gg: AY/fxX6L0sVdEHJrkk/t5W9ZSvDjnrV0VSKl34/F80fq+aGE0Qc2FwxgS3wXX2ykPRM
 hXCaVUWNzhNYPrhTgoyrQ5g9jyfKBqK9kotZ7rJdeVuwj5lbeaJYT6g6Myp+qTPZ9BmJuA8zIoN
 VLBQsYdoK4nJM7b1EjXGBoPC7EvKcstB9+ICdfLK0ajOoi8POt0ZiWIVR58H6nXsJg1hW/+a6SB
 O1aYLkHfm/QOWOjJvAhYtqKeBdPI0d1maGo1SvpJGyqnH9zxrEaZW3/WAKbdTiB817P0WAgC+i4
 z+w4pxLkFmK+0w9x3npARvGJcZ0LepwzBhfrOuLwlKr9n3hLth3DLY/TrpqF8yERUKeotvAPLpJ
 XjjXmm2OSZl3XsX4P1Uof/qa8p07hEZa1rWx555etSWUnyKcxmpx9RwhElMxxcWBVSpWw2rnjIh
 2ey9I0KaLNUyftlOpQXwFYc9AoMMGk8aLtBoHsdPxccreDdcDORteT
X-Received: by 2002:a05:6000:2584:b0:434:24ae:f687 with SMTP id
 ffacd0b85a97d-4342d389800mr353779f8f.6.1768353461979; 
 Tue, 13 Jan 2026 17:17:41 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432dfa6dc4esm25213326f8f.23.2026.01.13.17.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:17:41 -0800 (PST)
Date: Tue, 13 Jan 2026 17:17:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ariel Otilibili <otilibil@eurecom.fr>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Sunil
 Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman
 Kalra <hkalra@marvell.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Chas Williams <chas3@att.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav
 Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Potnuri Bharat Teja <bharat@chelsio.com>, Andrew Boyer
 <andrew.boyer@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: Re: [PATCH v4 00/11] devtools, lib, test, net, common: remove
 unused rte_bitmap_free() and plt_bitmap_free()
Message-ID: <20260113171733.288017f5@phoenix.local>
In-Reply-To: <20241222125725.1532157-1-otilibil@eurecom.fr>
References: <20241222125725.1532157-1-otilibil@eurecom.fr>
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

On Sun, 22 Dec 2024 13:49:20 +0100
Ariel Otilibili <otilibil@eurecom.fr> wrote:

> Hello,
>=20
> The first version  was about the clearing of Coverity IDs 357712 & 357737=
; now this series is about the removal of rte_bitmap_free() and its alias p=
lt_bitmap_free().
>=20
> As of commit 07604f2644 ("maintainers: update for next-net tree"):
>=20
> * rte_bitmap_free() returns an integer, and does nothing else
> * all functions that call rte_bitmap_free() do not use this return value.
>=20
> Details are in d5941e7269 ("devtools/cocci,lib/eal: remove unused rte_bit=
map_free()").
>=20
> Looking forward your feedback,

Not sure why this got ignored. Probably because it hit at the wrong time in=
 the development cycle.

Since it ends up being an ABI change, it would need to happen on the next .=
11 release (ie 26.11)
and would need to have a deprecation step. Ideally do a patch to remove all=
 uses of the function
in an earlier release like 26.03 or 26.07 and add a release note, then drop=
 it in 26.11

Would also need to be rebased, since code base has changed.
Automated patch review also raised some concerns.


## Patch Series Review: Remove unused rte_bitmap_free()

**Series Author:** Ariel Otilibili <otilibil@eurecom.fr> =20
**Version:** v4 =20
**Patches:** 11

### Series Overview

This series removes the no-op `rte_bitmap_free()` function and all its call=
ers across the DPDK codebase. The function only performed a NULL check and =
returned, making it functionally useless and causing Coverity warnings abou=
t unused return values.

---

### Patch 1/11: `devtools/cocci, lib/eal: remove unused rte_bitmap_free()`

**Subject Line Analysis:**
| Check | Status | Notes |
|-------|--------|-------|
| Length =E2=89=A460 chars | =E2=9D=8C **ERROR** | Subject is 53 chars but =
contains a comma |
| Punctuation | =E2=9D=8C **ERROR** | Contains comma (`,`) which is forbidd=
en per AGENTS.md |
| Format | =E2=9A=A0=EF=B8=8F **WARNING** | Dual-component subjects should =
typically be separate patches |

**Commit Body:**
| Check | Status |
|-------|--------|
| Line wrap =E2=89=A475 chars | =E2=9C=85 OK |
| Doesn't start with "It" | =E2=9C=85 OK |
| Signed-off-by present | =E2=9C=85 OK |
| Coverity issue tag | =E2=9C=85 OK (properly formatted: `Coverity issue: 3=
57712, 357737`) |

**Tag Order:**
| Check | Status | Notes |
|-------|--------|-------|
| Coverity before Fixes | =E2=9C=85 OK | N/A - no Fixes tag in this patch |
| Cc: stable@dpdk.org | =E2=9C=85 OK | Present (in commit notes after `---`=
) |

**Code Review:**
- =E2=9C=85 Removes the no-op function correctly
- =E2=9C=85 Removes the cocci rule that references this function
- =E2=9A=A0=EF=B8=8F **WARNING**: This is an ABI-breaking change (removes a=
 public API). Should have release notes in `doc/guides/rel_notes/`.

---

### Patch 2/11: `app/test: remove unused rte_bitmap_free()`

**Subject Line Analysis:**
| Check | Status |
|-------|--------|
| Length =E2=89=A460 chars | =E2=9C=85 OK (42 chars) |
| Lowercase after colon | =E2=9C=85 OK |
| No trailing period | =E2=9C=85 OK |
| No forbidden punctuation | =E2=9C=85 OK |
| Correct prefix | =E2=9C=85 OK (`app/test:`) |

**Commit Body:**
| Check | Status | Notes |
|-------|--------|-------|
| Line wrap =E2=89=A475 chars | =E2=9C=85 OK | |
| Doesn't start with "It" | =E2=9C=85 OK | |
| Signed-off-by | =E2=9C=85 OK | |
| Coverity issue tag | =E2=9C=85 OK | |
| Fixes tag format | =E2=9C=85 OK | 12-char SHA with exact subject |
| Cc: stable@dpdk.org | =E2=9C=85 OK | |

**Dependency Note:**
- Uses informal `Depends on` format in commit body. DPDK guidelines suggest=
 `Depends-on: series-NNNNN ("Title")` in commit notes after `---`.

---

### Patch 3/11: `net/sfc: remove unused rte_bitmap_free()`

**Subject Line:** =E2=9C=85 OK

**Commit Body Issues:**
| Check | Status | Notes |
|-------|--------|-------|
| Cc: stable@dpdk.org | =E2=9A=A0=EF=B8=8F **WARNING** | Has Fixes tag but =
`Cc: stable@dpdk.org` is only in commit notes, not the commit message body =
proper |
| Signed-off-by | =E2=9C=85 OK | |
| Fixes tag | =E2=9C=85 OK | |

---

### Patch 4/11: `crypto/ionic: remove unused rte_bitmap_free()`

**Subject Line:** =E2=9C=85 OK

**Commit Body:** =E2=9C=85 OK - All required elements present.

---

### Patch 5/11: `net/cxgbe: remove unused rte_bitmap_free()`

**Subject Line:** =E2=9C=85 OK

**Commit Body:** =E2=9C=85 OK

---

### Patch 6/11: `net/mlx4: remove unused rte_bitmap_free()`

**Subject Line:** =E2=9C=85 OK

**Commit Body:** =E2=9C=85 OK

---

### Patch 7/11: `common/mlx5: remove unused rte_bitmap_free()`

**Subject Line:** =E2=9C=85 OK

**Commit Body:** =E2=9C=85 OK

---

### Patch 8/11: `net/bonding: remove unused rte_bitmap_free()`

**Subject Line:** =E2=9C=85 OK

**Commit Body:** =E2=9C=85 OK

---

### Patch 9/11: `net/netvsc: remove unused rte_bitmap_free()`

**Subject Line:** =E2=9C=85 OK

**Commit Body:** =E2=9C=85 OK

---

### Patch 10/11: `common/cnxk: remove unused plt_bitmap_free()`

**Subject Line:** =E2=9C=85 OK

**Commit Body:** =E2=9C=85 OK - Good explanation of why `plt_bitmap_free` i=
s being removed (it's an alias).

---

### Patch 11/11: `{common,net}/cnxk: remove unused plt_bitmap_free()`

**Subject Line Analysis:**
| Check | Status | Notes |
|-------|--------|-------|
| Length =E2=89=A460 chars | =E2=9C=85 OK (54 chars) |
| Punctuation | =E2=9D=8C **ERROR** | Contains comma (`,`) inside braces, w=
hich is forbidden |

**Commit Body:**
| Check | Status | Notes |
|-------|--------|-------|
| Depends-on format | =E2=9A=A0=EF=B8=8F **WARNING** | Uses informal `Depen=
ds on commits:` format instead of proper `Depends-on: series-NNNNN` |
| Multiple Fixes tags | =E2=9C=85 OK | Multiple Fixes tags are acceptable |
| Signed-off-by | =E2=9C=85 OK | |

**Code Review:**
- =E2=9A=A0=EF=B8=8F **WARNING** (Patch 11, `roc_npa.c`): Removing the `got=
o bmap_free` label and associated code creates a situation where if `plt_zm=
alloc` fails, the function falls through without returning an error. The er=
ror handling path looks broken:

```c
if (lf->npa_qint_mem =3D=3D NULL) {
    rc =3D NPA_ERR_ALLOC;
-   goto bmap_free;
}
```

After this change, `rc` is set but execution continues to the next allocati=
on. This appears to be a **bug**.

---

## Summary

### Errors (Must Fix)

1. **Patch 1/11**: Subject line contains forbidden comma punctuation
2. **Patch 11/11**: Subject line contains forbidden comma punctuation =20
3. **Patch 11/11**: Potential bug in `roc_npa.c` - error handling path appe=
ars broken after removing the `goto bmap_free` label

### Warnings (Should Fix)

1. **Patch 1/11**: Missing release notes for ABI-breaking change (removal o=
f public API `rte_bitmap_free`)
2. **Patches 2-11**: Informal dependency notation; consider using `Depends-=
on: series-NNNNN ("Title")` format in commit notes
3. **All patches with Fixes tags**: `Cc: stable@dpdk.org` appears in commit=
 notes after `---` rather than in the commit message body (though this is a=
 common practice and may be acceptable)

### Info (Consider)

- The series is well-structured with clear progression: first remove the fu=
nction definition, then remove all callers
- Good use of Coverity issue tags where applicable
- Thorough identification of all callers across the codebase

### Recommended Actions

1. Fix subject lines in patches 1 and 11 to avoid commas:
   - Patch 1: Split into two patches, or use `devtools/cocci: remove rte_bi=
tmap_free cocci rule` and a separate patch for EAL
   - Patch 11: Use `common/cnxk: remove unused plt_bitmap_free()` and inclu=
de net/cnxk changes with it (or split into two patches)

2. Verify the error handling in `roc_npa.c` (patch 11) - the removal of `go=
to bmap_free` appears to break error handling when `plt_zmalloc` fails.

3. Add release notes for the removal of `rte_bitmap_free()` API.
