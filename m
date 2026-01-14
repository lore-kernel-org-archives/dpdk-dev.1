Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B0ED30CFD
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 01:32:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 869E7402A7;
	Wed, 14 Jan 2026 02:32:43 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id C6E104029D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 02:32:42 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47d5e021a53so60835725e9.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 17:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768354362;
 x=1768959162; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gj/WRg1bXyqwbxGNccDHpuucVfVHnKyfUVrNQnkayw=;
 b=jOcVRTeHCZ9Di4ONd5WfSsrK2RpiWzhA2CvMT+blPz5rjM9jaBeUqjRWzXAU0wQLJ2
 d3aeoxZ8mErpPAQfEH95IWYgYuVeRXDRAz6JG1xjsdGY5qLhrusSdBtjBzbpCxkmY9Pb
 VDSnDALLcGEaQSe1BzlgTuaYuQpCfXRlzwq2fkJbZMFh3vJWuWJ81NrlNVHmUDiNp0y2
 x7zkGEjAOnk7v/xCkOkHVJjRnGElQWij6uBmeEBglGxO06dmB5yJP6LVGHlY3U3g1u5s
 GKutIVERl7aiqruykekYMwvCKfQ2rHAcPqZL7VBpGeB53c2snG8anhvCVoS6fbe/8bZC
 hmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768354362; x=1768959162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3gj/WRg1bXyqwbxGNccDHpuucVfVHnKyfUVrNQnkayw=;
 b=saC6R1yCLai6T3puo3p9n31qwUuhefd795Dmz7vomrHwlE0Rm2rFTbjSTOfKrEf+kw
 IMsEVKABLOBjLjYEBezxQmBTa95RPRW8FPS/XvWxdGrq8nzjVA3lLP4mlYpcS2Zg7d5j
 C3sqRPERcO9QFnJ0dbEyhAK+IJIy2FcEB98IC7nZJHRSkIyff4goOD07S5iZ6ix+wL9C
 hLAnn/gx42emo40VE9eZZfGzjJ8juQF8I7eG3ZL89FpMP2OWbHOz1IwL/AZM2Kqod7Mw
 4GuEKOraXJut36LeZ4l6ZtotyN0jAn07HV5fsG5/cmZaoKXIdzcKjFV3h++5/E1BmaI6
 npdQ==
X-Gm-Message-State: AOJu0Yy3+55NXc1ILy8StO9tISKzrz7aTNixuFCVRkTyiRPlK3vLt3SM
 VF/duwt98+guSFgBkTZqsKTWDI6FmZy/3v1mhIisuxUW46en2Uent+q8mqX4WKjyF6M=
X-Gm-Gg: AY/fxX4eoezI3bGB0vWNRunptBU3sj0Haf6DWbXdUSjxwsa6oNQ/L9ZVdhbEc9yRcdf
 R03ivXfBlP6f9MG94sc4UQgxwLrKK5pzmthJChuI9durMF1lqsgc0fmRurBSzgMnF5aeyQ6ykWw
 lUBQJFwbiv6vPeNHbQWeD4ZpZT0JULBiMJixh7Kp8QsyunmMbONeNF5g1HiLuooXl3eVNoXcWnI
 XqFPgyWtX/w2cYk5USi2fjvaPgrTQO1r5b4G3Cf9bj5W4dCRDb5sJlCvdmO17a6yLi4cihdeYLK
 y+sSg8/zitdn+wlZ8tSMJExuKg7ZW8QLT2OJlJ1914Dtx60rUKGeWKc565dqV8UkltQdjOx7VCe
 CeTCLghupXRmP5urDjNzOQqg/Nog3Ys7kno3JJqiTTyztyaNwxiOi7s90wWuA8sFSt4KSgjKGaH
 f6vghzVeJ856BqRMafTK2M1e88U0E1jynUWEfW72grYadBs7yDriSc
X-Received: by 2002:a05:600c:5298:b0:477:a21c:2066 with SMTP id
 5b1f17b1804b1-47ee47be3a7mr3697395e9.5.1768354362100; 
 Tue, 13 Jan 2026 17:32:42 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee117e607sm12103185e9.3.2026.01.13.17.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:32:41 -0800 (PST)
Date: Tue, 13 Jan 2026 17:32:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v3 31/31] build: enable shadowed variable warnings
Message-ID: <20260113173236.4923cadd@phoenix.local>
In-Reply-To: <20251201114448.1441377-32-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
 <20251201114448.1441377-32-bruce.richardson@intel.com>
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

On Mon,  1 Dec 2025 11:44:48 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> Enable -Wshadow globally for DPDK builds.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Since this was a big series and hard for humans to review;
ran AI code review on it.

I'll review this DPDK patch series for fixing shadow variable warnings acco=
rding to the AGENTS.md criteria. This is a 31-patch series from Bruce Richa=
rdson that enables `-Wshadow` warnings globally for DPDK.

---

## Patch Series Summary

This series adds helper macros (`RTE_MIN3`/`RTE_MAX3`), fixes shadow variab=
le warnings across libraries, drivers, and apps, then enables `-Wshadow` gl=
obally. Components that don't build cleanly are explicitly excluded.

---

## Patch-by-Patch Review

### Patch 1/31: `eal: add more min/max helpers`

**Subject Line:** =E2=9C=85 Good - 30 characters, correct prefix, lowercase=
, imperative

**Commit Message:**
- =E2=9C=85 Describes the change well
- =E2=9C=85 Proper Signed-off-by tags
- =E2=9C=85 Has Acked-by tags

**Code Review:**
```c
#define RTE_MIN3(a, b, c)                      \
	__extension__ ({                        \
		typeof (a) _a =3D (a);            \
		typeof (b) _b =3D (b);            \
		typeof (c) _c =3D (c);            \
```

=E2=9A=A0=EF=B8=8F **Warning (style):** There's inconsistent spacing. The `=
RTE_MAX` macro is modified to use `_ax`/`_bx`, but `RTE_MIN3` and `RTE_MAX3=
` still use `_a`/`_b`/`_c`. This inconsistency could still cause shadowing =
if `RTE_MIN3(RTE_MIN(...))` is used. Consider using unique names like `_a3`=
/`_b3`/`_c3` for the triple variants.

=E2=9A=A0=EF=B8=8F **Warning (style):** Extra blank line between `RTE_MIN3`=
 and the `RTE_MAX` definition comment:
```c
	})

                   <-- extra blank line
/**
 * Macro to return the minimum of two numbers
```
DPDK style generally avoids double blank lines.

**Missing:** No `Cc: stable@dpdk.org` - this is a new feature, not a bug fi=
x, so that's correct.

---

### Patch 2/31: `eal: fix variable shadowing`

**Subject Line:** =E2=9C=85 Good - 27 characters

**Commit Message:**
- =E2=9C=85 Has multiple `Bugzilla ID:` tags (correct format)
- =E2=9C=85 Has `Fixes:` tags with 12-char SHA
- =E2=9C=85 Has `Cc: stable@dpdk.org`
- =E2=9C=85 Proper tag order

**Code Changes:**
- Renaming `trace` to `t` in tracing code - =E2=9C=85 Reasonable
- Renaming `args` to `out_args` - =E2=9C=85 Clear intent
- Renaming `optarg` to `arg` and `optlen` to `arglen` - =E2=9C=85 Avoids co=
nflict with getopt global

**Issue in `drivers/bus/pci/windows/pci.c`:**
```c
	} else {
		struct rte_pci_device *dev2 =3D NULL;
-		int ret;
```
This removes `ret` but it's used later in the block. Let me verify... Looki=
ng at the patch context, `ret` is already defined at the outer scope, so th=
is is correct.

=E2=9C=85 **Good patch**

---

### Patch 3/31: `ethdev: fix variable shadowing issues`

**Subject Line:** =E2=9C=85 37 characters, correct prefix (`ethdev:` not `l=
ib/ethdev:`)

**Code:**
```c
-	ethdev_bus_specific_init ethdev_bus_specific_init,
+	ethdev_bus_specific_init bus_specific_init,
```
=E2=9C=85 Renames parameter to avoid shadowing the type name - good practic=
e.

=E2=9C=85 **Good patch**

---

### Patch 4/31: `eventdev: fix variable shadowing issues`

**Subject Line:** =E2=9C=85 Good

**Code Review:**
```c
#define TXA_CHECK_OR_ERR_RET(id) \
do {\
-	int ret; \
+	int _ret; \
```
=E2=9C=85 Using `_ret` prefix for macro-local variables is the correct patt=
ern.

```c
-	uint32_t n;
...
+			uint32_t n =3D rxa_eth_rx(rx_adapter, port, queue, nb_rx,
```
=E2=9C=85 Reduced scope by moving declaration to initialization point.

=E2=9C=85 **Good patch**

---

### Patch 5/31: `net: remove shadowed variable`

**Subject Line:** =E2=9C=85 30 characters

**Code:**
```c
-	__mmask16 mask;
...
-		mask =3D byte_len_to_mask_table[data_len];
-		d =3D _mm_maskz_loadu_epi8(mask, data);
+		d =3D _mm_maskz_loadu_epi8(byte_len_to_mask_table[data_len], data);
```
=E2=9C=85 Cleanly eliminates unnecessary variable.

=E2=9C=85 **Good patch**

---

### Patch 6/31: `pipeline: fix variable shadowing`

**Subject Line:** =E2=9C=85 Good

Multiple good fixes:
- Loop counter `i` shadowing =E2=86=92 use inline `for (uint32_t j =3D ...)=
` =20
- Local `n_bytes` renamed to `total_bytes`
- Local `name` renamed contextually (`action_name`, `pipeline_name`)

=E2=9C=85 **Good patch**

---

### Patch 7/31: `table: fix issues with variable shadowing`

**Subject Line:** =E2=9C=85 Good

**Macro variables renamed with underscore prefix:**
```c
-	uint64_t x, pos, x0, x1, x2, mask;
+	uint64_t _x, _pos, _x0, _x1, _x2, _mask;
```
=E2=9C=85 Correct pattern for macro-local variables.

=E2=9C=85 **Good patch**

---

### Patches 8-10: `power`, `pcapng`, `bbdev` fixes

All =E2=9C=85 **Good patches** - simple renames, proper format.

---

### Patch 11/31: `bus/pci: remove shadowed variables`

**Subject Line:** =E2=9C=85 Good

Both fixes are correct - removing duplicate `ret` declarations.

=E2=9C=85 **Good patch**

---

### Patches 12-17: Intel driver fixes (e1000, i40e, ice, cpfl, ixgbe)

All have proper format. Notable:

**Patch 14 (i40e):**
```c
-	struct rte_eth_dev *dev;
+	struct rte_eth_dev *_dev;
```
=E2=9C=85 Underscore prefix in macros is correct.

**Patch 15 (ice):**
```c
-	vsi->nb_qps =3D RTE_MIN
-		((uint16_t)vsi->adapter->hw.func_caps.common_cap.num_msix_vectors - 2,
-		RTE_MIN(vsi->nb_qps, ICE_MAX_Q_PER_TC));
+	vsi->nb_qps =3D RTE_MIN(vsi->nb_qps, ICE_MAX_Q_PER_TC);
+	vsi->nb_qps =3D RTE_MIN(vsi->nb_qps,
+		(uint16_t)vsi->adapter->hw.func_caps.common_cap.num_msix_vectors - 2);
```
=E2=9C=85 Good - avoids nested `RTE_MIN` which causes shadowing.

---

### Patch 18/31: `app/testpmd: fix build with shadow warnings enabled`

**Subject Line:** =E2=9C=85 47 characters

Multiple good fixes including:
- `geneve_opt` vs generic `opt`
- `event_arg` vs `optarg` (getopt global)
- Removing unnecessary `rss_hf` variable

=E2=9C=85 **Good patch**

---

### Patches 19-27: Various app fixes

All =E2=9C=85 **Good patches** with proper format and reasonable changes.

---

### Patch 28/31: `drivers: disable variable shadowing warnings for drivers`

**Subject Line:** =E2=9C=85 Good

**Code:**
```python
no_shadow_cflag =3D []
if cc.has_argument('-Wno-shadow')
        no_shadow_cflag =3D '-Wno-shadow'
endif
```

=E2=9A=A0=EF=B8=8F **Info:** This pattern is correct but many drivers are e=
xcluded. The list is quite long (33 drivers/components). This is acceptable=
 as a pragmatic approach to enable the warning incrementally.

=E2=9C=85 **Good patch**

---

### Patches 29-30: app/test and examples exclusions

=E2=9C=85 **Good patches** - correctly excludes code that hasn't been fixed=
 yet.

---

### Patch 31/31: `build: enable shadowed variable warnings`

**Subject Line:** =E2=9C=85 Good

```python
global_cflags =3D [
        ...
+        '-Wshadow',
```

=E2=9C=85 **Good patch** - final enablement.

---

## Overall Assessment

### Errors (must fix):
None identified.

### Warnings (should fix):

1. **Patch 1:** Inconsistent variable naming between `RTE_MIN`/`RTE_MAX` (`=
_ax`/`_bx`) and `RTE_MIN3`/`RTE_MAX3` (`_a`/`_b`/`_c`). Using `RTE_MIN3(RTE=
_MIN(...))` could still cause shadowing. Consider making variable names mor=
e unique.

2. **Patch 1:** Extra blank line between macros (minor style issue).

### Info (consider):

1. The series excludes a significant number of drivers and examples from `-=
Wshadow`. This is a pragmatic approach but creates technical debt. Consider=
 documenting which components need fixing in a TODO or tracking bug.

2. Some patches fix code in areas unrelated to the commit message scope (e.=
g., patch 2 modifies `drivers/bus/pci/windows/pci.c` but is titled as "eal"=
 fix). This is acceptable since the changes are necessary for clean compila=
tion.

---

## Summary

This is a **well-structured patch series** that methodically enables `-Wsha=
dow` for DPDK. The patches:
- Follow DPDK commit message conventions
- Have proper `Fixes:` and `Cc: stable@dpdk.org` tags where appropriate
- Use reasonable renaming strategies
- Correctly employ underscore prefixes for macro-local variables

**Recommendation:** The series is ready for merge with minor style consider=
ations on patch 1. The approach of enabling the warning globally while excl=
uding problematic components is pragmatic and allows incremental improvemen=
t.
