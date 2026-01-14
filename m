Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00907D31A0F
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 06:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 354284064C;
	Wed, 14 Jan 2026 07:04:55 +0100 (CET)
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67]) by mails.dpdk.org (Postfix) with ESMTP id 0ACA44028F
 for <dev@dpdk.org>; Wed, 14 Jan 2026 07:04:53 +0100 (CET)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b8765be29d6so34411566b.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 22:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768370693;
 x=1768975493; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdoxCm7clwoKN8xdaTTUjaKse2llN15AgXuaeaIRec8=;
 b=XTPfg5YWmHrGGSeeuYO0aF1psIKSdEnPY0seYGFPrcO6GMyLYYsnQsKvxQYukC49V4
 /i18fd4BvSxqgccGtGG87nxY+Llvl2UjFVl31wvfXaLSKggeA7AXFrJ8KoTk/i1dlAo/
 pDd1CQdf9zSltEWYpNYy8qfaQ12lP0+tJp0tA458mqSWCnlceyMMSDQO2iwf7qjEquRP
 NvTSdD6QjZ6ze0AF1QpsU8iNy9LdiH/PUR8vaLFpKToy6rDg8CbKLv0tr6o2lGs8j29P
 b6SQAi3z41kNZzVl3EWhewPDBlYnS7PYUww4B7iUiagoh9krLN9+C2sjl8i1yRcx4xm/
 9LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768370693; x=1768975493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WdoxCm7clwoKN8xdaTTUjaKse2llN15AgXuaeaIRec8=;
 b=EnHeOmI9jsfRFWncDi1QI2nnQHW4a6uhIJMyLEKxFJ9cgtsXgtMLPZKqppyQmm+lJs
 l6B3aWPYrnre60FPuUjmWdsr9O1JButQqNval0CmiKMOG++vGk3zWx5ron1YbiJ35K/w
 4NEaw569ocOL1DgL5MIbOMOcAfa/yUNIwlc3Tyyv3laJQP/DUBK5Epp+1EFGs72hsfz0
 VFB1p6mlbOsZgSlTHc0/3wFtrz+bxZ6njExs9a0yFahdsDdOLznNsQ0nG8vOqtlDqCg1
 SxubH2Fh9oQ+Jdpf2GudN0L0KxWJaHG9iI2Q0wWH9E/tOHsnie5W47cZQs4A8RNxI4I+
 BGPA==
X-Gm-Message-State: AOJu0Yw+FWau9Lzw3LDDAzmIAoURcTQxumXIhbfml1Cjg6/xG0FGLHPv
 cC+qJRg1yMbwcz68Ga9BS3WCVxSOlM21rn9eQz4TnomkeUfGs7ZEKXeBJMy2249VsxQ=
X-Gm-Gg: AY/fxX7keikHhhEn+fHHOexpJ1P52K+XpjN9sxjVHSgRFt7kV7yu5ieF/esPBE3a1lV
 fK4ocRqXijUYFQxziFHBK2cXoe8XhSdGcibYVTaAbjYeCYhtneYog4O0/3pN7Ls9I1J3299CreL
 ZWoRNxuLPYGOaFEk6c/xxSrhIpuFpb7m27e9a/ByNNnSq+YhRbIqMFgS/datG4A1if+rzCNyOdv
 qHeYF0y8SrjMUUgGSd6kx/g4L2nX4uhTP1Iwsuk3coCrqUbsye6nH3VCqxDRaVPBA5dYYU4xzCY
 Wo2TyJhjoj0HPYCSuf2jlaaAdQPGe2AymVVIwAxkJQRnJke4g7xrmKY9zapMezgX9WcqM1kh0s4
 RsK6CrdUfz6fWEMlFW/Vdc8JfAnLCeWrOIl9mL+ebHU6aIp6m63gYObIGctmKNvoHzNSG6n4XhH
 7t9UFrb98lOo5FTWafgBqRmyrJovcJ5vZECeKi7VS8OClnIWu8mF+6
X-Received: by 2002:a17:906:c110:b0:b76:bcf5:a38a with SMTP id
 a640c23a62f3a-b876743fb85mr58445966b.0.1768370693138; 
 Tue, 13 Jan 2026 22:04:53 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b876b6865desm42745666b.12.2026.01.13.22.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 22:04:52 -0800 (PST)
Date: Tue, 13 Jan 2026 22:04:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nawal Kishor <nkishor@marvell.com>
Cc: <dev@dpdk.org>, <jerinj@marvell.com>, <asekhar@marvell.com>
Subject: Re: [PATCH v2 0/2] cnxk: add HALO support for CN20K mempool
Message-ID: <20260113220448.56f44b5e@phoenix.local>
In-Reply-To: <20251205055140.2395369-1-nkishor@marvell.com>
References: <20251204065203.1866809-2-nkishor@marvell.com>
 <20251205055140.2395369-1-nkishor@marvell.com>
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

On Fri, 5 Dec 2025 11:21:32 +0530
Nawal Kishor <nkishor@marvell.com> wrote:

> This series of patches adds support for HALO in CNXK mempool driver.
>=20
> Changes in v2:
>  * Fixed compilation warnings.
>=20
> Nawal Kishor (2):
>   common/cnxk: add support for halos
>   mempool/cnxk: add halo support in mempool
>=20
>  drivers/common/cnxk/hw/npa.h                  |  81 ++++++
>  drivers/common/cnxk/roc_idev.c                |  25 ++
>  drivers/common/cnxk/roc_idev.h                |   3 +
>  drivers/common/cnxk/roc_idev_priv.h           |   1 +
>  drivers/common/cnxk/roc_mbox.h                |   6 +
>  drivers/common/cnxk/roc_nix.h                 |   1 +
>  drivers/common/cnxk/roc_nix_queue.c           |  46 ++-
>  drivers/common/cnxk/roc_npa.c                 | 268 ++++++++++++++++--
>  drivers/common/cnxk/roc_npa.h                 |  20 +-
>  drivers/common/cnxk/roc_npa_debug.c           | 201 ++++++++++++-
>  drivers/common/cnxk/roc_npa_priv.h            |   3 +
>  .../common/cnxk/roc_platform_base_symbols.c   |   2 +
>  drivers/common/cnxk/roc_sso.c                 |  35 ++-
>  drivers/common/cnxk/roc_sso.h                 |   1 +
>  drivers/mempool/cnxk/cn10k_mempool_ops.c      |  19 +-
>  drivers/mempool/cnxk/cn20k_mempool_ops.c      |  60 ++++
>  drivers/mempool/cnxk/cn9k_mempool_ops.c       |   2 +-
>  drivers/mempool/cnxk/cnxk_mempool.c           |  40 ++-
>  drivers/mempool/cnxk/cnxk_mempool.h           |  16 +-
>  drivers/mempool/cnxk/cnxk_mempool_ops.c       |  11 +-
>  drivers/mempool/cnxk/meson.build              |   1 +
>  21 files changed, 750 insertions(+), 92 deletions(-)
>  create mode 100644 drivers/mempool/cnxk/cn20k_mempool_ops.c
>=20

This patch never got merged because of CI build failures.
Fix and resubmit.

AI review also says:


## Patch Review: cnxk halo support (2-patch series)

### Patch 1/2: `common/cnxk: add support for halos`

#### Commit Message =E2=9C=93

| Criterion | Status | Notes |
|-----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | 33 characters |
| Correct prefix | =E2=9C=93 | `common/cnxk:` is appropriate |
| Lowercase after colon | =E2=9C=93 | |
| Imperative mood | =E2=9C=93 | "add support" |
| No trailing period | =E2=9C=93 | |
| Body wrapped =E2=89=A475 chars | =E2=9C=93 | |
| Body not starting with "It" | =E2=9C=93 | Starts with "In cn9k/cn10k..." |
| Signed-off-by present | =E2=9C=93 | Real name and valid email |

#### Code Issues

**Warning: Implicit pointer comparison (multiple locations)**

The AGENTS.md specifies:
> `if (!p)             /* Bad - don't use ! on pointers */`

Several instances use `!ptr` style:

```c
// roc_npa.c - npa_halo_alloc()
if (!lf || !halo || !aura_handle)
    return NPA_ERR_PARAM;

// roc_npa.c - npa_halo_free() =20
if (!lf || !aura_handle)
    return NPA_ERR_PARAM;
```

**Suggested fix:**
```c
if (lf =3D=3D NULL || halo =3D=3D NULL || aura_handle =3D=3D NULL)
    return NPA_ERR_PARAM;
```

---

**Warning: Non-portable format specifier**

In `roc_npa_debug.c`, function `npa_halo_dump()`:
```c
npa_dump("W9: thresh \t\t%lu\nW9: fc_msh_dst \t\t%d",
         (unsigned long)halo->thresh, halo->fc_msh_dst);
```

The AGENTS.md specifies:
> Forbidden: `%lld`, `%llu`, `%llx` =E2=86=92 Preferred: `%PRId64`, `%PRIu6=
4`, `%PRIx64`

While `%lu` with an explicit cast is technically different, for consistency=
 with the rest of the file (which uses `%"PRIx64"` patterns), this should u=
se:
```c
npa_dump("W9: thresh \t\t%" PRIu64 "\nW9: fc_msh_dst \t\t%d",
         (uint64_t)halo->thresh, halo->fc_msh_dst);
```

---

**Warning: New API functions not marked `__rte_experimental`**

New public APIs added to `roc_idev.h`:
```c
int __roc_api roc_idev_npa_halo_ena_get(void);
void __roc_api roc_idev_npa_halo_ena_set(int halo_ena);
```

And new inline function in `roc_npa.h`:
```c
static inline uint32_t
roc_npa_max_block_size(void)
```

Per AGENTS.md:
> New APIs must be marked as `__rte_experimental`

**Note:** These are internal (`__roc_api`) functions in the ROC layer, so `=
__rte_experimental` may not strictly apply - this depends on whether the RO=
C API is considered public. However, the pattern in other ROC files should =
be followed.

---

**Info: Good practices observed**
- Proper error code additions (`NPA_ERR_HALO_INIT`, `NPA_ERR_HALO_FINI`)
- Symbol exports added via `RTE_EXPORT_INTERNAL_SYMBOL`
- Hardware structure properly defined with bitfields
- Consistent use of `mbox_get()`/`mbox_put()` patterns

---

### Patch 2/2: `mempool/cnxk: add halo support in mempool`

#### Commit Message =E2=9C=93

| Criterion | Status | Notes |
|-----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | 40 characters |
| Correct prefix | =E2=9C=93 | `mempool/cnxk:` is appropriate |
| Lowercase after colon | =E2=9C=93 | |
| Imperative mood | =E2=9C=93 | "add" |
| No trailing period | =E2=9C=93 | |
| Body wrapped =E2=89=A475 chars | =E2=9C=93 | |
| Body not starting with "It" | =E2=9C=93 | Starts with "This patch..." |
| Signed-off-by present | =E2=9C=93 | |

#### License =E2=9C=93

New file `cn20k_mempool_ops.c`:
```c
/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(C) 2025 Marvell.
 */
```
- SPDX on first line =E2=9C=93
- Copyright follows =E2=9C=93
- Blank line before includes =E2=9C=93
- BSD-3-Clause appropriate for driver =E2=9C=93

#### Code Issues

**Warning: Devargs parameter string formatting**

In `cnxk_mempool.c`:
```c
RTE_PMD_REGISTER_PARAM_STRING(mempool_cnxk,
                  CNXK_NPA_MAX_POOLS_PARAM "=3D<128-1048576>"
                  CNXK_NPA_HALO_ENA_PARAM "=3D<0-1>");
```

The two parameter strings will concatenate without a space separator, resul=
ting in:
`max_pools=3D<128-1048576>halo_ena=3D<0-1>`

**Suggested fix:**
```c
RTE_PMD_REGISTER_PARAM_STRING(mempool_cnxk,
                  CNXK_NPA_MAX_POOLS_PARAM "=3D<128-1048576> "
                  CNXK_NPA_HALO_ENA_PARAM "=3D<0-1>");
```

---

**Info: meson.build ordering**

The file list in `meson.build` is not alphabetically ordered:
```python
sources =3D files(
        ...
        'cn9k_mempool_ops.c',
        'cn10k_mempool_ops.c',
        'cn20k_mempool_ops.c',
        'cn10k_hwpool_ops.c',
)
```

Per AGENTS.md: "Lists alphabetically ordered". However, this follows the ex=
isting convention in the file (which was already non-alphabetical), so this=
 is an existing technical debt rather than a new issue introduced by this p=
atch.

---

**Info: Documentation consideration**

The new `halo_ena` devargs parameter should ideally be documented in the dr=
iver documentation (`doc/guides/mempool/cnxk.rst` or similar) so users unde=
rstand what it does and when to use it.

---

### Summary

| Severity | Count | Items |
|----------|-------|-------|
| **Error** | 0 | None |
| **Warning** | 4 | Implicit pointer checks, format specifier, experimental=
 marking, devargs spacing |
| **Info** | 2 | meson.build ordering (pre-existing), documentation gap |

#### Recommended Actions

1. **Should fix:** Change `!ptr` to `ptr =3D=3D NULL` for pointer compariso=
ns
2. **Should fix:** Use `PRIu64` format specifier in `npa_halo_dump()`
3. **Should fix:** Add space between devargs parameter strings
4. **Consider:** Add documentation for the new `halo_ena` parameter
5. **Consider:** Verify `__rte_experimental` policy for internal ROC APIs

The patches are generally well-structured and follow DPDK conventions. The =
issues identified are relatively minor style/consistency items rather than =
functional problems.
