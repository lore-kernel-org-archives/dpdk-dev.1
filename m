Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A33D38FF9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2122440A8A;
	Wed, 14 Jan 2026 18:32:01 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id 9398E4027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 18:31:59 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so336915e9.2
 for <dev@dpdk.org>; Wed, 14 Jan 2026 09:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768411919;
 x=1769016719; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gf0ABcddmp3Gdg5Vi+Ia37eet+CeND9MQ69bLDT2NNc=;
 b=Z9+sofJsbjiQ07Lb7MjS50/2VFXKg/pQwaaeYSQ259N+G+rCdIQ5a51xL5nFxXmNpi
 Sj9RBOfZlCCOBMwhXK9gWG4OA3pcSQqS6FzaVwHL3L50dHkYyFYPns6WQ+2j37nbpFZT
 Fkap/KyXZB8WfyDQiTnbRAFvZn7Et6yi4h7d3/cZW2Ync/Yu8RkknCCDfDxdfvU5abzb
 r/m75h4zEGyfiCK96ylfCxbSaXoAd58JQcBmud96F+7tKtQ/BdhpVeF1LoqmY2JoO7c8
 joJkvHIpT9scWLpeyMa1mgFrqOMMyX/wwyKZ327wgyq9qTtganeTJL3lBe7BusHlT7LK
 XGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768411919; x=1769016719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gf0ABcddmp3Gdg5Vi+Ia37eet+CeND9MQ69bLDT2NNc=;
 b=vRva5ZCQWarJ44HVMVy1ee8OZ1fvfU6udBQjc1w7ncvT5lXMQk4nf32F43A+nlZ9WC
 H4RlC8iVavL0sM8Rq15RShjRNjgqURkaVR2WxEYTS0oXsbK00WjB718VLtYcryaxvVCO
 x4KeSeXoQDtQDHAJ6Vx97APZamC31jmdrUcDkJdl1iuJ0VkiBtYp6pU0k06CBXNzWfQx
 wF4L8SMxwO2MqOha4ZvuA6ZHMda+nTAZekVx+EWLXXXtBvS9qH3CrX/kzJSRZh8V8uUQ
 8MazPFyaa5V+4VuLFcuD3Ksn7p1XNlDuPqS6JznCFjJAALPCYHP+tAqotzCZcyXJU6t6
 D/eA==
X-Gm-Message-State: AOJu0YzJIR4E5RQfbL1NX/4ZbxnHKmy395OEdJO72nvqHOarLpsEcBNb
 WKEbAvQX0uOaHB879vN+0A3gWuS/oxLCH5pk/2rJ3xVEChp/KNqxsHoU738PNn74+Bc=
X-Gm-Gg: AY/fxX7RnlsEyB0O4Rhlej0+OsyWZYUc7JeINwrXtI/Y7K/+gb83zbZTphqG0+sg9H6
 /wj9q4WW5C3ZJlE5lmMLoGtWznST1rwG3ucnFRmzeu/rClw9HqjyqyeTgl48NVL4Gj1MwgZBTob
 iIPtWXG8mHC1OWiR9OhoGv1tX3hlRfo8OCTzRuhk19pNjnng0ffXzcDWa+wy5cZdB+YCY6V8KHp
 7nU4bmurUJIMeZLAhltgGk4cECKuKsEYdfvi1PBW7us0iVjyDY6hHpntVR9BEjhGooQP1Nkb85D
 XKHF85nRGgtNY9sGL2bGFpcM3Iwv0+SrXV2gKF/n46vg81bUORZxFqX9LrYf+Pngfj9IDX06HRB
 r0LlO6/dt/YWqMXG3MGWN3LjaZdqHybrHEYYTmd9dxNJYfREvDac4PIkyTCBi8yntRdmVXJZmm+
 VUzxOrBcX5PGphbmHyhSWeeyFTvtkO2e1jddbfeGWOZ55kPMLEkZdN
X-Received: by 2002:a05:600c:3acb:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-47ee33111bbmr44801215e9.15.1768411918699; 
 Wed, 14 Jan 2026 09:31:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee281436fsm23362715e9.8.2026.01.14.09.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 09:31:58 -0800 (PST)
Date: Wed, 14 Jan 2026 09:31:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: Re: [PATCH 0/4] net/mlx5: future HW devargs defaults and fixes
Message-ID: <20260114093150.485abd1a@phoenix.local>
In-Reply-To: <20260112092439.14843-1-mkashani@nvidia.com>
References: <20260112092439.14843-1-mkashani@nvidia.com>
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

On Mon, 12 Jan 2026 11:24:34 +0200
Maayan Kashani <mkashani@nvidia.com> wrote:

> This patch series contains bug fixes for the mlx5 PMD, primarily
> addressing issues with Hardware Steering (HWS) and flow devarg handling.
>=20
> Summary of changes:
>=20
> 1. drivers: fix flow devarg handling for future HW
>    Addresses SWS (Software Steering) deprecation on future hardware
>    generations (e.g., ConnectX-9). Updates default behavior for
>    dv_flow_en and allow_duplicate_pattern devargs based on device
>    capabilities, with proper error handling and user feedback.
>=20
> 2. net/mlx5: fix default memzone requirements in HWS
>    Fixes memzone exhaustion when probing setups with ~1K SFs. The
>    default HWS sync flow API configuration was allocating unnecessary
>    rings (flow_transfer_pending/completed) that are only used with
>    async flow API. This patch removes the unnecessary allocations to
>    stay within memzone limits.
>=20
> 3. net/mlx5: fix internal HWS pattern template creation
>    Improves PMD initialization time by separating pattern templates
>    into internal and external categories. Internal templates (created
>    by PMD) skip expensive validations, while application-provided
>    templates remain fully validated.
>=20
> 4. net/mlx5: fix redundant control rules in promiscuous mode
>    Removes redundant DMAC and multicast/broadcast control flow rules
>    when promiscuous mode is enabled, as the device already receives
>    all traffic in this mode.
>=20
> All patches are targeted for stable backport.
>=20
> Dariusz Sosnowski (1):
>   net/mlx5: fix default memzone requirements in HWS
>=20
> Maayan Kashani (3):
>   drivers: fix flow devarg handling for future HW
>   net/mlx5: fix internal HWS pattern template creation
>   net/mlx5: fix redundant control rules in promiscuous mode
>=20
>  doc/guides/nics/mlx5.rst             |  11 ++-
>  drivers/common/mlx5/mlx5_devx_cmds.c |  18 ++++
>  drivers/common/mlx5/mlx5_devx_cmds.h |   6 ++
>  drivers/common/mlx5/mlx5_prm.h       |  14 +++-
>  drivers/net/mlx5/mlx5.c              |  71 +++++++++++++++-
>  drivers/net/mlx5/mlx5_flow_hw.c      | 121 ++++++++++++++++++++-------
>  drivers/net/mlx5/mlx5_trigger.c      |  16 ++--
>  7 files changed, 214 insertions(+), 43 deletions(-)
>=20

It looks ok to me, AI code review had some useful feedback.
Also, it looks like AGENTS.md doesn't really know what is best for
declaration placement.

# DPDK Patch Review: mlx5 devargs Series

**Series**: [PATCH 1/4] - [PATCH 4/4] mlx5 devargs and flow handling fixes =
=20
**Submitter**: Maayan Kashani <mkashani@nvidia.com> =20
**Date**: Mon, 12 Jan 2026 =20
**Reviewed against**: AGENTS.md criteria

---

## Series Overview

This 4-patch series addresses flow devarg handling for future NVIDIA hardwa=
re generations where SWS (Software Steering) is disabled. The patches updat=
e defaults, fix memory usage issues, optimize initialization performance, a=
nd correct redundant control flow rules.

---

## Patch 1/4: drivers: fix flow devarg handling for future HW

### Commit Message Analysis

| Criterion | Status | Notes |
|-----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 50 chars: "drivers: fix flow=
 devarg handling for future HW" |
| Lowercase after colon | =E2=9C=85 PASS | "fix flow devarg..." |
| Imperative mood | =E2=9C=85 PASS | "fix" |
| No trailing period | =E2=9C=85 PASS | |
| Component prefix | =E2=9A=A0=EF=B8=8F WARNING | Uses "drivers:" but chang=
es span `common/mlx5` and `net/mlx5`. Consider using `common/mlx5` or split=
ting. |
| Body wrap =E2=89=A475 chars | =E2=9C=85 PASS | All lines within limit |
| Body doesn't start with "It" | =E2=9C=85 PASS | Starts with "SWS (softwar=
e steering)..." |
| Signed-off-by present | =E2=9C=85 PASS | `Signed-off-by: Maayan Kashani <=
mkashani@nvidia.com>` |
| Fixes tag format | =E2=9C=85 PASS | `Fixes: 1b55eeb7b76f ("common/mlx5: a=
dd ConnectX-9 SuperNIC")` - 12-char SHA |
| Cc: stable@dpdk.org | =E2=9C=85 PASS | Present |
| Tag order | =E2=9C=85 PASS | Fixes =E2=86=92 Cc =E2=86=92 blank =E2=86=92=
 Signed-off-by =E2=86=92 Acked-by |

### Code Analysis

**New functions added:**

```c
static bool mlx5_hws_is_supported(struct mlx5_dev_ctx_shared *sh)
static bool mlx5_sws_is_any_supported(struct mlx5_dev_ctx_shared *sh)
static bool mlx5_kvargs_is_used(struct mlx5_kvargs_ctrl *mkvlist, const cha=
r *key)
```

| Criterion | Status | Notes |
|-----------|--------|-------|
| Line length =E2=89=A4100 chars | =E2=9A=A0=EF=B8=8F WARNING | Line 295: `=
if (hca_attr->eswitch_manager && (hca_attr->esw_sw_owner_v2 || hca_attr->es=
w_sw_owner))` is ~95 chars - acceptable but borderline |
| Explicit comparisons | =E2=9C=85 PASS | Uses `=3D=3D 0`, `=3D=3D 1`, `=3D=
=3D 2`, `!=3D NULL` appropriately |
| No forbidden tokens | =E2=9C=85 PASS | |
| Naming conventions | =E2=9C=85 PASS | Functions use lowercase with unders=
cores |
| Comment style | =E2=9C=85 PASS | Multi-line comments follow C style |

**Style Issues:**

| Issue | Severity | Location | Description |
|-------|----------|----------|-------------|
| Mixed declaration and code | =E2=9A=A0=EF=B8=8F WARNING | Line 358 | `boo=
l allow_dup_pattern_set =3D ...` declared mid-block after statements. C90 s=
tyle prefers declarations at block start. |
| Duplicate logic | =E2=84=B9=EF=B8=8F INFO | Lines 338-341 vs 360-367 | Th=
e `allow_duplicate_pattern` handling appears in two places with slightly di=
fferent logic. Consider consolidating. |

**Documentation:**

| Criterion | Status | Notes |
|-----------|--------|-------|
| doc/guides updated | =E2=9C=85 PASS | Updates `doc/guides/nics/mlx5.rst` =
for `dv_flow_en` and `allow_duplicate_pattern` |
| Docs match code | =E2=9C=85 PASS | Documentation accurately reflects the =
new default behavior |

### Patch 1 Verdict: **ACCEPTABLE WITH MINOR ISSUES**

- Consider using `net/mlx5:` prefix since that's the primary subsystem bein=
g modified
- Minor C90 style preference for declarations at block start

---

## Patch 2/4: net/mlx5: fix default memzone requirements in HWS

### Commit Message Analysis

| Criterion | Status | Notes |
|-----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 51 chars: "net/mlx5: fix def=
ault memzone requirements in HWS" |
| Component prefix | =E2=9C=85 PASS | `net/mlx5:` correct |
| Lowercase after colon | =E2=9C=85 PASS | |
| Imperative mood | =E2=9C=85 PASS | "fix" |
| Body wrap =E2=89=A475 chars | =E2=9C=85 PASS | |
| Signed-off-by | =E2=9C=85 PASS | |
| Fixes tag | =E2=9C=85 PASS | `Fixes: 27d171b88031 ("net/mlx5: abstract fl=
ow action and enable reconfigure")` |
| Cc: stable | =E2=9C=85 PASS | |
| Tag order | =E2=9C=85 PASS | |
| References commit | =E2=9C=85 PASS | Uses `[1] commit d1ac7b6c64d9` notat=
ion correctly |

**Author note**: Patch is `From: Dariusz Sosnowski` but submitted by Maayan=
 Kashani - this is fine for series coordination.

### Code Analysis

**New function:**

```c
static int flow_hw_queue_setup_rings(struct rte_eth_dev *dev,
                                     uint16_t queue,
                                     uint32_t queue_size,
                                     bool nt_mode)
```

| Criterion | Status | Notes |
|-----------|--------|-------|
| Line length =E2=89=A4100 chars | =E2=9C=85 PASS | |
| NULL checks | =E2=9C=85 PASS | Uses `=3D=3D NULL` and `!=3D NULL` explici=
tly |
| Error handling | =E2=9C=85 PASS | Returns -ENOMEM on allocation failures |
| Assertion usage | =E2=9C=85 PASS | Uses `MLX5_ASSERT()` appropriately |
| Refactoring | =E2=9C=85 PASS | Good refactoring - extracts ring creation =
to separate function |

**Logic review:**

```c
if (ring =3D=3D NULL)
    return 0;
```

This early return in `mlx5_hw_pull_flow_transfer_comp()` is safe since ring=
s may not be allocated in sync flow API mode.

```c
if (hw_q->flow_transfer_pending !=3D NULL && hw_q->flow_transfer_completed =
!=3D NULL)
    mlx5_hw_push_queue(...)
```

Appropriate guard for optional rings.

### Patch 2 Verdict: **GOOD**

Clean, well-structured fix that reduces memzone usage significantly for SF-=
heavy deployments.

---

## Patch 3/4: net/mlx5: skip internal pattern template validation

### Commit Message Analysis

| Criterion | Status | Notes |
|-----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 53 chars |
| Component prefix | =E2=9C=85 PASS | `net/mlx5:` |
| Lowercase | =E2=9C=85 PASS | |
| Signed-off-by | =E2=9C=85 PASS | Two authors: Gregory Etelson and Maayan =
Kashani |
| Fixes tag | =E2=9C=85 PASS | `Fixes: a190f25e6a93 ("net/mlx5: improve pat=
tern template validation")` |
| Cc: stable | =E2=9C=85 PASS | |

### Code Analysis

| Criterion | Status | Notes |
|-----------|--------|-------|
| Function signature change | =E2=9C=85 PASS | Added `bool external` parame=
ter |
| Wrapper function | =E2=9C=85 PASS | `flow_hw_external_pattern_template_cr=
eate()` wraps with `true` |
| Internal calls | =E2=9C=85 PASS | All internal calls use `false` |
| Line length | =E2=9C=85 PASS | |

**Style issue:**

| Issue | Severity | Location | Description |
|-------|----------|----------|-------------|
| Extra blank line | =E2=9A=A0=EF=B8=8F WARNING | Line 925-926 | Double bla=
nk line before `const struct mlx5_flow_driver_ops` |

The optimization approach is sound - internal PMD-created templates are kno=
wn-safe and don't need expensive validation.

### Patch 3 Verdict: **GOOD**

Minor style nit with extra blank line.

---

## Patch 4/4: net/mlx5: fix redundant control rules in promiscuous mode

### Commit Message Analysis

| Criterion | Status | Notes |
|-----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 PASS | 58 chars |
| Component prefix | =E2=9C=85 PASS | `net/mlx5:` |
| Imperative mood | =E2=9C=85 PASS | "fix" |
| Body doesn't start with "It" | =E2=9A=A0=EF=B8=8F WARNING | Body starts w=
ith "When promiscuous..." but third paragraph starts "This patch makes..." =
which is discouraged phrasing |
| Signed-off-by | =E2=9C=85 PASS | |
| Fixes tag | =E2=9C=85 PASS | `Fixes: 9fa7c1cddb85 ("net/mlx5: create cont=
rol flow rules with HWS")` |
| Cc: stable | =E2=9C=85 PASS | |

### Code Analysis

| Criterion | Status | Notes |
|-----------|--------|-------|
| Logic correctness | =E2=9C=85 PASS | Correctly makes DMAC/multicast rules=
 conditional on non-promiscuous mode |
| Brace style | =E2=9C=85 PASS | Correct K&R style |
| Flag handling | =E2=9C=85 PASS | Clean bitwise OR operations |

**Before:**
```c
if (dev->data->promiscuous)
    flags |=3D MLX5_CTRL_PROMISCUOUS;
if (dev->data->all_multicast)
    flags |=3D MLX5_CTRL_ALL_MULTICAST;
else
    flags |=3D MLX5_CTRL_BROADCAST | ...;
flags |=3D MLX5_CTRL_DMAC;
```

**After:**
```c
if (dev->data->promiscuous) {
    flags |=3D MLX5_CTRL_PROMISCUOUS;
} else {
    if (dev->data->all_multicast)
        flags |=3D MLX5_CTRL_ALL_MULTICAST;
    else
        flags |=3D (MLX5_CTRL_BROADCAST | ...);
    flags |=3D MLX5_CTRL_DMAC;
}
```

The refactored logic correctly avoids setting redundant DMAC and multicast =
rules when promiscuous mode already accepts all traffic.

### Patch 4 Verdict: **GOOD**

---

## Series-Level Analysis

### Compilation Independence

Each patch should compile independently. The series has proper ordering:
1. Patch 1 adds capability detection and devarg handling
2. Patch 2 depends on HWS mode changes from patch 1
3. Patch 3 is independent (optimization)
4. Patch 4 is independent (bug fix)

=E2=9A=A0=EF=B8=8F **Potential issue**: Patch 2 references `d1ac7b6c64d9` w=
hich appears to be a different commit than patch 1's `1b55eeb7b76f`. The se=
ries should be self-contained or clearly document the dependency.

### ABI Considerations

| Change | Impact |
|--------|--------|
| New fields in `mlx5_hca_attr` | Internal structure, no ABI impact |
| New static functions | No ABI impact |
| Function signature change (`flow_hw_pattern_template_create`) | Static fu=
nction, no ABI impact |

### Documentation Completeness

| Criterion | Status |
|-----------|--------|
| Release notes needed? | =E2=9A=A0=EF=B8=8F CONSIDER | These are bug fixes=
, but the behavioral changes (default dv_flow_en) may warrant release note =
mention |
| API documentation | =E2=9C=85 N/A | No public API changes |

---

## Summary

| Patch | Verdict | Blocking Issues |
|-------|---------|-----------------|
| 1/4 | =E2=9C=85 Acceptable | Component prefix could be more specific |
| 2/4 | =E2=9C=85 Good | None |
| 3/4 | =E2=9C=85 Good | Extra blank line (minor) |
| 4/4 | =E2=9C=85 Good | None |

### Errors (Must Fix)
None

### Warnings (Should Fix)
1. **Patch 1**: Consider `net/mlx5:` prefix instead of generic `drivers:`
2. **Patch 1**: Mixed declaration and code (C90 style)
3. **Patch 3**: Extra blank line at line 925

### Info (Consider)
1. **Patch 1**: Logic for `allow_duplicate_pattern` appears in two locations
2. **Series**: Consider adding release notes entry for the default behavior=
 change
3. **Patch 2**: Commit reference `[1]` should ideally use Fixes: format or =
be clear it's not in this series

---

## Recommendation

**Series is ready for merge** with optional minor cleanups. The fixes addre=
ss real issues for future hardware support and scalability with large numbe=
rs of SFs. Code quality is good and follows DPDK conventions.
