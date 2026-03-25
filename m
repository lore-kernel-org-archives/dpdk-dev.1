Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA13103A99A
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:25:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA5E5402AA;
	Wed, 25 Mar 2026 03:25:05 +0100 (CET)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id DC82F4027A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:25:04 +0100 (CET)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2c160308a54so842854eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774405504;
 x=1775010304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmijwdaKKmYhjoU+CCsWB50lSvP87GoPUnVB9InUQmc=;
 b=T1Qsga02oUYDo/D8vWKeQQZTwm7/tedPepARJh4GquYaiRC9DxnXYcq1agSJpTeyCE
 TPgc7F07o3HnY5PCCXiwKVJ+9P+jYljO0XjLIr22QhUX56x7cOC5PKJK9tZlzA3tMTRA
 WuKFUqC4AmzOaEa4BlzqMfG9hhyDRQhx8tkxlQ9BK/sveuaUHPozg0b2QAGan+NLg8Mj
 m8NYWmTqfln3Vq0T5I/jVu2+Es/osRGd/HMa6m8Ve2Q7++2BXf0kBQwkF+VwyeMqKO9A
 U2XrLVjn/Xdzon8Sf7WO/N+FoFKZNfG7Bx6Hv9FSPr2fLgFtheOb/pA74XiRO1cixndM
 OUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405504; x=1775010304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bmijwdaKKmYhjoU+CCsWB50lSvP87GoPUnVB9InUQmc=;
 b=pMlf9VI7/0FnIRu1PNJBGWN2tkPKJnI3MtwZc7qughsTUycp2UxJhTOkEoLXe14uQv
 iQ3UQg7Qj8vldfF5qaNUyFRNoU/Y449srO5/CyMkUoOU2ZeqCq/hhHLgPpgvxMqQktc4
 pvlUp9h4ORvBkHV0JzXpduD9wTgx1aVLkToiH7EMS6vITYgglgzyvSMcedsDKBbIT3VU
 7puLqEuM7w3Hg4KHeXu98iiCaf1SmMcDzJbPzDIPWsDO83cRxJLwSj22AgSMsrwbugtE
 ++0w6BFZ53072lVLlg4H87f2bsRAGKoTRsLzOIptO59j695mSAoWxi6HfqiA95Qa8niG
 pkug==
X-Gm-Message-State: AOJu0Yz0Dpy69bVqFnLHYRINgDzKDFmgNRl6nmP9Q6tGWfSQJa8W3pPZ
 nJy6H6yaAoS2VEeoS+DLEdA0xAb8eEueRKt5QywPNNaH/v8EwB71IT046OcEibqS8bE=
X-Gm-Gg: ATEYQzwMYujw28NAWhS8jc5lqYTu4L8kscSKV7pksy51P46c4c47bne8zalJgsj2h0/
 RH9dxa5s8a0duedr/3hoWFQsCIauB23fYgKQSWgWWMrUACzHLSXExkvPzPY9AymBROn1E0s6Bx9
 AYSYCG2W+P9XkPVeTV2uud7XRydv4IFifXwtmIcy02ugrNSlbWdlRj8hAQKe88fmdSG+bECW3bD
 3xw+X8MI/o4WW8PBUw/uxraEVzaYc9HpT0UkM6IhPDfSiSgcrSq0FlTIkbhEnMh9b0DFrYruBdL
 4G7XV6srOcR2loD1aoNZTAJnDA0o9Zoa9EJBe91l+vPC09ZuKInKBp+80h4wK0VPBuiNDPrK9Vk
 D3gSVvLJAKIA28LCnhEh5wkYHRK671x7MuQvtZokc2PCOPJCg+SR6EBros+uf6q3bUbvXqhSLyR
 1pm6pbMrb+7bPSps8mBmIChJQAKMlC6Du3iCs=
X-Received: by 2002:a05:7300:72cc:b0:2c0:fec3:fcff with SMTP id
 5a478bee46e88-2c15d3809fcmr1000289eec.17.1774405503826; 
 Tue, 24 Mar 2026 19:25:03 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b14c99bsm17025241eec.1.2026.03.24.19.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:25:03 -0700 (PDT)
Date: Tue, 24 Mar 2026 19:25:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com, aman.deep.singh@intel.com
Subject: Re: [PATCH v5 00/10] net/mlx5: per-queue Tx rate limiting via
 packet pacing
Message-ID: <20260324192500.158b78dd@phoenix.local>
In-Reply-To: <20260324165047.391137-1-vjardin@free.fr>
References: <20260322134629.94633-1-vjardin@free.fr>
 <20260324165047.391137-1-vjardin@free.fr>
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

On Tue, 24 Mar 2026 17:50:37 +0100
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
> Changes since v4:
>=20
>   Addressed review feedback from Stephen Hemminger and added
>   Acked-by from Viacheslav Ovsiienko on patches 03-10.
>=20
>   Patch 05/10 (set rate):
>   - Add rate_kbps > UINT32_MAX bounds check before truncating to
>     the PRM rate_limit field, preventing silent overflow when HW
>     reports no maximum rate
>=20
>   Patch 07/10 (testpmd + PMD query):
>   - Add NULL check on (*priv->txqs)[queue_id] before container_of()
>     in rte_pmd_mlx5_txq_rate_limit_query(), matching the pattern
>     in the setter
>=20
>   Patches 03-10:
>   - Added Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
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
>  drivers/net/mlx5/mlx5_tx.c           | 106 +++++++++++++++-
>  drivers/net/mlx5/mlx5_tx.h           |   5 +
>  drivers/net/mlx5/mlx5_txpp.c         |  90 ++++++++++++++
>  drivers/net/mlx5/mlx5_txq.c          | 149 ++++++++++++++++++++++
>  drivers/net/mlx5/rte_pmd_mlx5.h      |  74 +++++++++++
>  lib/ethdev/ethdev_driver.h           |   7 ++
>  lib/ethdev/ethdev_trace.h            |   9 ++
>  lib/ethdev/ethdev_trace_points.c     |   3 +
>  lib/ethdev/rte_ethdev.c              |  35 ++++++
>  lib/ethdev/rte_ethdev.h              |  24 ++++
>  19 files changed, 914 insertions(+), 33 deletions(-)
>=20

I acked the ethdev changes. Since the bulk of the changes are
to mlx5, this should go through next-net-mlx5 tree.
