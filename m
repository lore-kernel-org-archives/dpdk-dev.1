Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942ABD58CBF
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 23:10:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C96AC402D6;
	Tue, 24 Mar 2026 00:10:11 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id E29CE4027C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 00:10:09 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-35a094cc3e9so3222911a91.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774307408;
 x=1774912208; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/eAe//zmDTADyovXeWdjnqh+VXj/u8CdcAPi7Up7lM=;
 b=yY93qDsuVeV1gUl/wRylpnuuKm+vPPZdzvbclp492Fr1SLAo5N4jy9jEbz8mtVIzds
 M6h7BomuQbnTQB5Y5+38Vz8gDfsEFZHOIW+FpRk84QrXGBErLkLjAg4gZ2e7oKmT8hPW
 Ma/hbfs1+r2sJ0YAO9LRH4yuGiYJdG7eySn+S3Munl7gKyNmj4eaWX668dHdNh7FY0XV
 PnoJ9mxfZsJ2jBZ4IY2G9+y5lX9RIfx+gHnV03aILU0Hpb4Qn1/9zckUhN9cRHyBh+9v
 WSd/lumT2LsP8ZyEJa3WVIJLNgqO/XFWyLbVeLGe+jhb+wPbgb4yYcmmdxW8r+AstOes
 iJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774307408; x=1774912208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/eAe//zmDTADyovXeWdjnqh+VXj/u8CdcAPi7Up7lM=;
 b=JDb+n9YqrHsTT35md8ioE0OCe4Uirx5TAbagSnXkBe0ls0gB/cXidAQU3NbtkmyFVk
 Y/pDf1wmeD26hzZklVwAkhiXfIfbZ+4hN8cVmQjR8b7H377BikMUgRcQtjpA2V3xnVyj
 BUko11bcUE6Uv3UFuTteXbJWwwfvs6iaaPXW9NBwh/jlXSA/zh8wJRDLUDmHvUm9gG3D
 USSu/c88CPVv3ktneDHdwnAdelnR5c9pCwLGK3OHfB911/76veyCNPwLbAz3MJKHhlM2
 geEMuX6FdPLF4QvtJdujzmIfWu99udEg05gbTIrw4/ApYlZNJ4D3Qtl0nrmsEKWNI1yH
 mkBg==
X-Gm-Message-State: AOJu0YzTUEFngHLK7gsJogKzMnYBk9VF/lTv8hP8hIkq29F14Fl+LYBm
 e4RxdOoP4ScclrmDPigtgoLd0fIb0cwsvUithabDqw8rK1nZQrLCo/s7M7uOB8xsyeQ=
X-Gm-Gg: ATEYQzwZnkC/OPUN03+cZ9KshE0WC8+fh/kUt7tuC1Kn9covmzjF8YmsdhU43OEhTi9
 YoBQhP+BUGHL5jqZBN4bLBxmAyot71mraegAZQATbeVQdPwCYAozF0xVVHQsZNCn1teUgEPALRi
 +f9D/WkHDN7Abemc22aa0XRAKSn+3OANhqFVlH+bpx3GwHBcqcVDVzJX00U4PwSnzUPkgO9acGs
 Hsg2ZtCVmX0+RNVNVavYG+0Lt0PAcjK2AvkZXR1sR/O9pdJ2I6tYi853R0AJoAXC/BAU243LSE9
 +dC4CCVQNZWevOGmDmqfzI+9ir/MzXhGBGZnNRJpsFW6bcvuGQAHf2jC7ChVSwb0veoYSUHhdES
 tEaE4ju0RBCGyrVOwZtb+fZPIUx0KCzJVDjdo4zQPvCFykkBFEtNhLZx0UgIsuYEWyTRo0Lb5Pe
 mbtS790uMFFjlP8Li1FZageDV/BofqzDE1rTU=
X-Received: by 2002:a17:90b:4e8d:b0:35b:e5cf:20fc with SMTP id
 98e67ed59e1d1-35be5cf22b5mr6563926a91.26.1774307408032; 
 Mon, 23 Mar 2026 16:10:08 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c031354f3sm174262a91.6.2026.03.23.16.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 16:10:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:09:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com, aman.deep.singh@intel.com
Subject: Re: [PATCH v4 00/10] net/mlx5: per-queue Tx rate limiting via
 packet pacing
Message-ID: <20260323160955.5379adfe@phoenix.local>
In-Reply-To: <20260322134629.94633-1-vjardin@free.fr>
References: <20260312220120.3256755-1-vjardin@free.fr>
 <20260322134629.94633-1-vjardin@free.fr>
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

On Sun, 22 Mar 2026 14:46:19 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> This series adds per-queue Tx data-rate limiting to the mlx5 PMD using
> hardware packet pacing (PP), and a symmetric rte_eth_get_queue_rate_limit=
()
> ethdev API to read back the configured rate.
>=20
> Each Tx queue can be assigned an individual rate (in Mbps) at runtime via
> rte_eth_set_queue_rate_limit(). The mlx5 implementation allocates a PP
> context per queue from the HW rate table, programs the PP index into the
> SQ via modify_sq, and relies on the kernel to share identical rates
> across PP contexts to conserve table entries. A PMD-specific API exposes
> per-queue PP diagnostics and rate table capacity.
>=20
> Patch breakdown:
>=20
>   01/10 doc/nics/mlx5: fix stale packet pacing documentation
>   02/10 common/mlx5: query packet pacing rate table capabilities
>   03/10 common/mlx5: extend SQ modify to support rate limit update
>   04/10 net/mlx5: add per-queue packet pacing infrastructure
>   05/10 net/mlx5: support per-queue rate limiting
>   06/10 net/mlx5: add burst pacing devargs
>   07/10 net/mlx5: add testpmd command to query per-queue rate limit
>   08/10 ethdev: add getter for per-queue Tx rate limit
>   09/10 net/mlx5: implement per-queue Tx rate limit getter
>   10/10 net/mlx5: add rate table capacity query API
>=20
> Release notes for the new ethdev API and mlx5 per-queue rate
> limiting can be added to a release_26_07.rst once the file is
> created at the start of the 26.07 development cycle.
>=20
> Changes since v3:
>=20
>   Addressed review feedback from Stephen and Slava (nvidia/Mellanox).
>=20
>   Patch 02/10 (query caps):
>   - Added Acked-by: Viacheslav Ovsiienko
>=20
>   Patch 03/10 (SQ modify):
>   - Define MLX5_MODIFY_SQ_IN_MODIFY_BITMASK_PACKET_PACING_RATE_LIMIT_INDEX
>     enum in mlx5_prm.h, following the MLX5_MODIFY_RQ_IN_MODIFY_xxx pattern
>   - Use read-modify-write for modify_bitmask (MLX5_GET64 | OR | MLX5_SET6=
4)
>     instead of direct overwrite, for forward compatibility
>=20
>   Patch 04/10 (PP infrastructure):
>   - Rename struct member and parameters from "rl" to "rate_limit"
>     for consistency with codebase naming style
>   - Replace MLX5_ASSERT(rate_mbps > 0) with runtime check returning
>     -EINVAL in non-debug builds
>   - Move mlx5_txq_free_pp_rate_limit() to after txq_obj_release() in
>     mlx5_txq_release() =E2=80=94 destroy the SQ before freeing the PP ind=
ex
>     it references
>   - Clarify commit message: distinct PP handle per queue (for cleanup)
>     but kernel shares the same pp_id for identical rate parameters
>=20
>   Patch 05/10 (set rate):
>   - Fix obj->sq vs obj->sq_obj.sq: use obj->sq_obj.sq from the start
>     for non-hairpin queues (was introduced in patch 07 in v3, breaking
>     git bisect)
>   - Move all variable declarations to block top (sq_devx,
>     new_rate_limit)
>   - Add queue state check: reject set_queue_rate_limit if queue is not
>     STARTED (SQ not in RDY state)
>   - Update mlx5 feature matrix: Rate limitation =3D Y
>   - Add Per-Queue Tx Rate Limiting documentation section in mlx5.rst
>     covering DevX requirement, hardware support, rate table sharing,
>     and testpmd usage
>=20
>   Patch 06/10 (burst devargs):
>   - Remove burst_upper_bound/typical_packet_size from Clock Queue
>     path (mlx5_txpp_alloc_pp_index) =E2=80=94 Clock Queue uses WQE rate
>     pacing and does not need these parameters
>   - Update commit message and documentation accordingly
>=20
>   Patch 07/10 (testpmd + PMD query):
>   - sq_obj.sq accessor change moved to patch 05 (see above)
>   - sq_devx declaration moved to block top
>=20
>   Patch 08/10 (ethdev getter) =E2=80=94 split from v3 patch 08:
>   - Split into ethdev API (this patch) and mlx5 driver (patch 09)
>   - Add rte_eth_trace_get_queue_rate_limit() trace point matching
>     the existing setter pattern
>=20
>   Patch 09/10 =E2=80=94 NEW (was part of v3 patch 08):
>   - mlx5 driver implementation of get_queue_rate_limit callback,
>     split out per Slava's request
>=20
>   Patch 10/10 (rate table query):
>   - Rename struct field "used" to "port_used" to clarify per-port
>     scope
>   - Strengthen Doxygen: rate table is a global shared HW resource
>     (firmware, kernel, other DPDK instances may consume entries);
>     port_used is a lower bound
>   - Document PP sharing behavior with flags=3D0
>   - Note that applications should aggregate across ports for
>     device-wide visibility
>=20
> Changes since v2:
>=20
>   Addressed review feedback from Stephen Hemminger:
>=20
>   Patch 04: cleaned redundant cast parentheses on (struct mlx5dv_pp *)
>   Patch 04: consolidated dv_alloc_pp call onto one line
>   Patch 05+08: removed redundant queue_idx bounds checks from driver
>     callbacks =E2=80=94 ethdev layer is the single validation point
>   Patch 07: added generic testpmd command: show port <id> queue <id> rate
>   Patch 08+10: removed release notes from release_26_03.rst (targets 26.0=
7)
>   Patch 10: use MLX5_MEM_SYS | MLX5_MEM_ZERO for heap allocation
>   Patch 10: consolidated packet_pacing_rate_table_size onto one line
>=20
> Changes since v1:
>=20
>   Patch 01: Acked-by Viacheslav Ovsiienko
>   Patch 04: rate bounds validation, uint64_t overflow fix, remove
>     early PP free
>   Patch 05: PP leak fix (temp struct pattern), rte_errno in error paths
>   Patch 07: inverted rte_eth_tx_queue_is_valid() check
>   Patch 10: stack array replaced with heap, per-port scope documented
>=20
> Testing:
>=20
>   - Build: GCC, no warnings
>   - Hardware: ConnectX-6 Dx
>   - DevX path (default): set/get/disable rate limiting verified
>   - Verbs path (dv_flow_en=3D0): returns -EINVAL cleanly (SQ DevX
>     object not available), no crash
>=20
> Vincent Jardin (10):
>   doc/nics/mlx5: fix stale packet pacing documentation
>   common/mlx5: query packet pacing rate table capabilities
>   common/mlx5: extend SQ modify to support rate limit update
>   net/mlx5: add per-queue packet pacing infrastructure
>   net/mlx5: support per-queue rate limiting
>   net/mlx5: add burst pacing devargs
>   net/mlx5: add testpmd command to query per-queue rate limit
>   ethdev: add getter for per-queue Tx rate limit
>   net/mlx5: implement per-queue Tx rate limit getter
>   net/mlx5: add rate table capacity query API
>=20
> Vincent Jardin (10):
>   doc/nics/mlx5: fix stale packet pacing documentation
>   common/mlx5: query packet pacing rate table capabilities
>   common/mlx5: extend SQ modify to support rate limit update
>   net/mlx5: add per-queue packet pacing infrastructure
>   net/mlx5: support per-queue rate limiting
>   net/mlx5: add burst pacing devargs
>   net/mlx5: add testpmd command to query per-queue rate limit
>   ethdev: add getter for per-queue Tx rate limit
>   net/mlx5: implement per-queue Tx rate limit getter
>   net/mlx5: add rate table capacity query API
>=20
>  app/test-pmd/cmdline.c               |  69 ++++++++++
>  doc/guides/nics/features/mlx5.ini    |   1 +
>  doc/guides/nics/mlx5.rst             | 180 ++++++++++++++++++++++-----
>  drivers/common/mlx5/mlx5_devx_cmds.c |  23 ++++
>  drivers/common/mlx5/mlx5_devx_cmds.h |  14 ++-
>  drivers/common/mlx5/mlx5_prm.h       |   7 ++
>  drivers/net/mlx5/mlx5.c              |  46 +++++++
>  drivers/net/mlx5/mlx5.h              |  13 ++
>  drivers/net/mlx5/mlx5_testpmd.c      |  93 ++++++++++++++
>  drivers/net/mlx5/mlx5_tx.c           | 104 +++++++++++++++-
>  drivers/net/mlx5/mlx5_tx.h           |   5 +
>  drivers/net/mlx5/mlx5_txpp.c         |  84 +++++++++++++
>  drivers/net/mlx5/mlx5_txq.c          | 149 ++++++++++++++++++++++
>  drivers/net/mlx5/rte_pmd_mlx5.h      |  74 +++++++++++
>  lib/ethdev/ethdev_driver.h           |   7 ++
>  lib/ethdev/ethdev_trace.h            |   9 ++
>  lib/ethdev/ethdev_trace_points.c     |   3 +
>  lib/ethdev/rte_ethdev.c              |  35 ++++++
>  lib/ethdev/rte_ethdev.h              |  24 ++++
>  19 files changed, 906 insertions(+), 33 deletions(-)
>=20


I didn't see anything wrong, but AI nit picking did.



---

## Review: [PATCH v4 01-10/10] mlx5 per-queue rate limiting

### Patch 05/10 =E2=80=94 `net/mlx5: support per-queue rate limiting`

**Error (Correctness): Data truncation in `rate_kbps` =E2=86=92 PRM `rate_l=
imit` field**

In `mlx5_txq_alloc_pp_rate_limit()`, `rate_kbps` is computed as `(uint64_t)=
rate_mbps * 1000` and then stored with `MLX5_SET(..., rate_limit, (uint32_t=
)rate_kbps)`. When `qos->packet_pacing_max_rate` is zero (HW doesn't report=
 a maximum), the range check is skipped, and any `rate_mbps` value above ~4=
,294,967 will silently overflow the `uint32_t` cast, programming a complete=
ly wrong rate into the hardware.

For example, `rate_mbps =3D 5000000` (5 Tbps =E2=80=94 unlikely but allowed=
 by the `uint32_t` parameter type) yields `rate_kbps =3D 5,000,000,000` whi=
ch truncates to `705,032,704` kbps.

Suggested fix: add an explicit check that `rate_kbps` fits in `uint32_t` be=
fore the cast, or cap it:

```c
if (rate_kbps > UINT32_MAX) {
    DRV_LOG(ERR, "Rate %u Mbps overflows PRM rate_limit field.", rate_mbps);
    rte_errno =3D ERANGE;
    return -ERANGE;
}
```

**Warning (Correctness): Missing NULL check on `txq_data` in `rte_pmd_mlx5_=
txq_rate_limit_query()` (patch 07)**

After `rte_eth_tx_queue_is_valid()` confirms the index is in range, the cod=
e does:

```c
txq_data =3D (*priv->txqs)[queue_id];
txq_ctrl =3D container_of(txq_data, struct mlx5_txq_ctrl, txq);
```

If the queue index is valid but the queue has been released (entry is NULL)=
, `container_of` on a NULL pointer produces an invalid pointer, and subsequ=
ent dereferences are undefined behavior. The setter in patch 05 checks `(*p=
riv->txqs)[queue_idx] =3D=3D NULL` but the query function does not.

Suggested fix: add a NULL check on `txq_data` before the `container_of`, si=
milar to what the setter does.

The same issue exists in `rte_pmd_mlx5_pp_rate_table_query()` (patch 10) bu=
t there the loop body does check `(*priv->txqs)[i] =3D=3D NULL` and skips, =
so that one is fine.

### Patch 09/10 =E2=80=94 `net/mlx5: implement per-queue Tx rate limit gett=
er`

**Warning (Correctness): Missing NULL check on queue data in `mlx5_get_queu=
e_rate_limit()`**

The getter checks `priv->txqs =3D=3D NULL || (*priv->txqs)[queue_idx] =3D=
=3D NULL` which is good. However, the ethdev layer (`rte_eth_get_queue_rate=
_limit()` in patch 08) only checks `queue_idx >=3D dev->data->nb_tx_queues`=
, not whether `priv->txqs` is allocated. The driver-side check handles this=
, so this is actually fine =E2=80=94 noting for completeness.

### Patch 01/10 =E2=80=94 `doc/nics/mlx5: fix stale packet pacing documenta=
tion`

**Warning: Missing `Cc: stable@dpdk.org`**

The patch has a `Fixes:` tag referencing a previous commit but is missing `=
Cc: stable@dpdk.org` for backport consideration, even though it's a documen=
tation-only fix.

### Patches 02, 03, 04, 06, 08, 10

No correctness issues found. The code is well-structured with proper error =
handling, resource cleanup on failure paths, and appropriate validation.

### General observations

The series is well organized with clean separation of concerns across patch=
es. Error paths in `mlx5_set_queue_rate_limit()` properly clean up the temp=
orary `new_rate_limit` PP allocation on modify-SQ failure, and `mlx5_txq_re=
lease()` correctly frees the rate limit context on queue teardown. The `rte=
_errno =3D -ret` pattern after `mlx5_devx_cmd_modify_sq()` is consistent wi=
th how other mlx5 callers handle that function's negative errno return conv=
ention.
