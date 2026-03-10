Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC9BEB1058
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 14:20:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BADDF402DC;
	Tue, 10 Mar 2026 15:20:09 +0100 (CET)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by mails.dpdk.org (Postfix) with ESMTP id E9181402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 15:20:08 +0100 (CET)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-467161c4b89so1018565b6e.3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773152408;
 x=1773757208; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrr6nDLk6yT3fWYoekBeOliMkxxf6TlozhTL7YX3xB4=;
 b=0NyJnWhThlAUrhGp7ITRFSxpW8ULyt/5mtXpVlVQsfoQTrQJWmtOsZ+Q69meW4DzFk
 24LGWBXaYLrikeGiKpPn0jWtYDfAHAjrr3nrsF8wUzGTXjbG59s36Cl16V32OgQD5pa4
 e8f75lCFB0k4FtdktJs9IxOVSNvOcxMfK8/0E2ugKvArrxRdK+UlA7h0OLDYtbF5Mf+B
 /O6eTZHTWNs188QSKHgW9vudy9fqEUVeU5cfdSwaeSEG0g1dv7XV3VwvLpx8rwzWH4T1
 HVwU0s0ajfnfaf5xMZyMR/nt5MjF4NeRdtxIg8voiHRNWLEdOvK1CJ34biSc9sQdCDJo
 b00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773152408; x=1773757208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jrr6nDLk6yT3fWYoekBeOliMkxxf6TlozhTL7YX3xB4=;
 b=cuEzkXCjOcR5vBZFQ08hNjW1M/f/zeIggcC8EceJKOIdD95aEsOUdheRDxOPEYp0AR
 g6+5uk/5FptMtkxJ5/mBECIVQlkL34rjUzcMI6HYA4NqJcVJ98tnASs0eu/sme4yDTCo
 /9BnanbIxQfJ266Qb+u92G01S6iOEvL9/g/Uvy1nLjH6lPFKMfh6LMrg7I9Rz14d2qjA
 q8eLvZQlGiQYNN61ex9oXSMGEDh/OM9iJvPeIluDf6fnRultU6qWXO0YQEVFS2dkqF7a
 Xqtq4P6wYKka0cdap46C2ztG/85bMazbtjqyFUGPBniD890rd00ETA7cRTuC32eAtNTf
 tZ4Q==
X-Gm-Message-State: AOJu0Yz0HpeV3etFUai/ApxDonTKju/DKlpydeEKhHSjSpIj1eyRuBrM
 HLtOxhOhNsZDzsCZXvQGs10SglHrheGDefmP3kULeW0lLRftybeoYQEMyuv84BqXYvk=
X-Gm-Gg: ATEYQzwGwBVx3XSOnAjWMCzbG5qSobuy1WCZSNOMFRXVkPAjewtoE/TGldwbKARIYU2
 3EsPInedhw26KtgLeRNtyjY7cty81nxmhWejr/Mj7U1f4AodwUnGOINDVpOf4yti2XNH8bEHp8i
 4TcJtSBPv9Q/8KcwT2GJfpxHoH8KtQo2f9H2N4f8vpL5PrY/ubhmdl4COdC+CsV7pESJUbC4+/B
 dTnXPeFGV5LvfVTI8UTg23WJy7KwjfX2psxZL86XopSXj+vOz8pIhWk3eXGKdenPqsmJbGlf5w5
 IfSqF7N3Ex3z7e2nj6DLfsyy41KsrcKrSXOWSbHe5PO7LvOUFKw3oK2sackVCYrEIExAwL3KCZj
 tW4uKfXxWW9D+0btdSijAoQb6xHqdXeltrnPVXcOUuYAWHah8MRxwKMgaqBG/tho7DH21hvLHl+
 KEjq8v3yCs+ijSsSvKLaOiH4BSHJSErNl95Vg=
X-Received: by 2002:a05:6808:f10:b0:463:4196:3d3f with SMTP id
 5614622812f47-466dc9ee337mr7683292b6e.7.1773152407345; 
 Tue, 10 Mar 2026 07:20:07 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466ebbd7243sm6591577b6e.3.2026.03.10.07.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:20:07 -0700 (PDT)
Date: Tue, 10 Mar 2026 07:20:04 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Jardin <vjardin@free.fr>
Cc: dev@dpdk.org, rasland@nvidia.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, dsosnowski@nvidia.com,
 viacheslavo@nvidia.com, bingz@nvidia.com, orika@nvidia.com,
 suanmingm@nvidia.com, matan@nvidia.com
Subject: Re: [PATCH v1 00/10] net/mlx5: per-queue Tx rate limiting via
 packet pacing
Message-ID: <20260310072004.4ae14ef3@phoenix.local>
In-Reply-To: <20260310092014.2762894-1-vjardin@free.fr>
References: <20260310092014.2762894-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 10 Mar 2026 10:20:04 +0100
Vincent Jardin <vjardin@free.fr> wrote:

> This series adds per-queue Tx rate limiting to the mlx5 PMD using
> the HW packet pacing (PP) rate table.
> 
> The ConnectX-6 Dx and later NICs expose a per-SQ
> packet_pacing_rate_limit_index that can be changed on a live SQ
> via modify_bitmask without queue teardown. The kernel mlx5 driver
> refcounts PP contexts internally, so queues configured at the same
> rate share a single HW rate table entry.
> 
> The series is structured as follows:
> 
>   1. Doc fix for stale packet pacing documentation
>   2-3. common/mlx5: query PP capabilities and extend SQ modify
>   4-6. net/mlx5: per-queue PP infrastructure, rate_limit callback,
>        burst pacing devargs (tx_burst_bound, tx_typical_pkt_sz)
>   7. net/mlx5: testpmd command to query per-queue rate state
>   8. ethdev: add rte_eth_get_queue_rate_limit() symmetric getter
>   9. net/mlx5: share PP rate table entries across queues
>   10. net/mlx5: rate table capacity query API
> 
> Usage with testpmd:
>   set port 0 queue 0 rate 1000
>   set port 0 queue 1 rate 5000
>   set port 0 queue 0 rate 0      # disable
>   mlx5 port 0 txq 0 rate show    # query
> 
> Tested on ConnectX-6 Dx only.
> 
> Vincent Jardin (11):
>   doc/nics/mlx5: fix stale packet pacing documentation
>   common/mlx5: query packet pacing rate table capabilities
>   common/mlx5: extend SQ modify to support rate limit update
>   net/mlx5: add per-queue packet pacing infrastructure
>   net/mlx5: support per-queue rate limiting
>   net/mlx5: add burst pacing devargs
>   net/mlx5: add testpmd command to query per-queue rate limit
>   ethdev: add getter for per-queue Tx rate limit
>   mailmap: update Vincent Jardin email address
>   net/mlx5: share pacing rate table entries across queues
>   net/mlx5: add rate table capacity query API
> 
>  .mailmap                             |   3 +-
>  doc/guides/nics/mlx5.rst             | 125 +++++++++++++++++------
>  drivers/common/mlx5/mlx5_devx_cmds.c |  20 ++++
>  drivers/common/mlx5/mlx5_devx_cmds.h |  14 ++-
>  drivers/net/mlx5/mlx5.c              |  46 +++++++++
>  drivers/net/mlx5/mlx5.h              |  13 +++
>  drivers/net/mlx5/mlx5_testpmd.c      |  93 +++++++++++++++++
>  drivers/net/mlx5/mlx5_tx.c           |  89 +++++++++++++++++
>  drivers/net/mlx5/mlx5_tx.h           |   5 +
>  drivers/net/mlx5/mlx5_txpp.c         |  75 ++++++++++++++
>  drivers/net/mlx5/mlx5_txq.c          | 144 +++++++++++++++++++++++++++
>  drivers/net/mlx5/rte_pmd_mlx5.h      |  57 +++++++++++
>  lib/ethdev/ethdev_driver.h           |   7 ++
>  lib/ethdev/rte_ethdev.c              |  28 ++++++
>  lib/ethdev/rte_ethdev.h              |  24 +++++
>  15 files changed, 710 insertions(+), 33 deletions(-)
> 

Lots to digest here, so did a first pass review using AI.

Review: [PATCH v1 00/10] mlx5 per-queue packet pacing rate limiting
Submitter: Vincent Jardin <vjardin@free.fr>

================================================================
Patch 4/10: net/mlx5: add per-queue packet pacing infrastructure
================================================================

Error: Integer overflow in Mbps-to-kbps conversion
  mlx5_txq_alloc_pp_rate_limit() computes:
    rate_kbps = rate_mbps * 1000;
  Both rate_mbps and rate_kbps are uint32_t. If rate_mbps > 4,294,967
  (roughly 4.3 Tbps), the multiplication overflows and silently wraps,
  programming a wrong rate into the HW rate table. While 4 Tbps is
  beyond current HW, the function has no upper-bound validation against
  hca_attr.qos.packet_pacing_max_rate. At minimum, validate rate_mbps
  against the HCA max rate before the multiply, or widen to uint64_t:
    uint64_t rate_kbps = (uint64_t)rate_mbps * 1000;
  and check it fits in the 32-bit PRM field.

Warning: No validation of rate_mbps against HCA min/max rate
  The HCA reports packet_pacing_min_rate and packet_pacing_max_rate
  (queried in patch 2). mlx5_txq_alloc_pp_rate_limit() does not check
  the requested rate against these bounds. A rate below the HW minimum
  will likely be silently rounded or rejected by FW with an opaque
  error. Validating early with a clear log message would be more
  helpful.

================================================================
Patch 5/10: net/mlx5: support per-queue rate limiting
================================================================

Error: PP index leaked when mlx5_devx_cmd_modify_sq() fails on rate set
  In mlx5_set_queue_rate_limit() for the tx_rate > 0 path:
    ret = mlx5_txq_alloc_pp_rate_limit(sh, &txq_ctrl->rl, tx_rate);
    if (ret)
        return ret;
    ...
    ret = mlx5_devx_cmd_modify_sq(sq_devx, &sq_attr);
    if (ret) {
        ...
        mlx5_txq_free_pp_rate_limit(&txq_ctrl->rl);
        return ret;
    }
  This looks correct on error -- good. However, note that
  mlx5_txq_alloc_pp_rate_limit() calls mlx5_txq_free_pp_rate_limit()
  internally at the top ("Free previous allocation if any"), meaning
  the OLD PP index is freed BEFORE the new one is allocated, and before
  the SQ is modified. If the new allocation succeeds but modify_sq
  fails, the SQ still has the OLD pp_id programmed, but that old PP
  context was already freed. The SQ is now referencing a freed PP index
  until the next successful set or queue teardown.

  Suggested fix: Do not free the old PP context inside
  mlx5_txq_alloc_pp_rate_limit(). Instead, allocate the new PP into a
  temporary mlx5_txq_rate_limit, modify the SQ, and only on success
  free the old PP and swap in the new one. On failure, free the new PP
  and leave the old one intact.

Warning: mlx5_set_queue_rate_limit return value inconsistency
  The disable path (tx_rate == 0) returns the raw ret from
  mlx5_devx_cmd_modify_sq() without setting rte_errno, while the
  capability-check and validation paths return -rte_errno. The ethdev
  layer expects negative errno values. Verify that
  mlx5_devx_cmd_modify_sq() returns negative errno consistently.

================================================================
Patch 7/10: net/mlx5: add testpmd command to query per-queue rate
================================================================

Error: Inverted return value check for rte_eth_tx_queue_is_valid()
  In rte_pmd_mlx5_txq_rate_limit_query():
    if (rte_eth_tx_queue_is_valid(port_id, queue_id))
        return -EINVAL;
  rte_eth_tx_queue_is_valid() returns 0 on success (valid queue) and
  non-zero on error. This check returns -EINVAL when the queue IS
  valid, and proceeds when it is NOT valid -- the logic is inverted.
  Should be:
    if (!rte_eth_tx_queue_is_valid(port_id, queue_id))
  or:
    if (rte_eth_tx_queue_is_valid(port_id, queue_id) != 0)

  Without this fix, the query always fails on valid queues and may
  dereference invalid memory on invalid queues.

Warning: SQ object field mismatch between set and query paths
  In mlx5_set_queue_rate_limit() (patch 7 update), the code uses
  txq_ctrl->obj->sq_obj.sq for modify_sq. But in
  rte_pmd_mlx5_txq_rate_limit_query(), the query uses
  txq_ctrl->obj->sq_obj.sq as well (via sq_out). Make sure
  mlx5_devx_cmd_query_sq() exists and accepts this object -- the
  existing codebase has mlx5_devx_cmd_query_sq() but verify the
  parameter is the same sq_obj.sq vs sq distinction.

================================================================
Patch 8/10: ethdev: add getter for per-queue Tx rate limit
================================================================

Warning: New ethdev API needs broader discussion
  Adding a new eth_dev_ops callback (get_queue_rate_limit) changes the
  ethdev driver interface. This typically requires:
  - An RFC or discussion on the mailing list before the patch
  - Agreement from ethdev maintainers (Thomas, Andrew, Ferruh)
  - Consideration of whether this belongs as a generic ethdev API or
    should remain PMD-specific
  The patch adds it only to mlx5; other PMDs that support
  set_queue_rate_limit (ixgbe, i40e, ice) would need implementations
  too, or applications will get inconsistent -ENOTSUP.

Warning: Missing release notes for new ethdev API
  rte_eth_get_queue_rate_limit() is a new public experimental API in
  lib/ethdev. This needs an entry in doc/guides/rel_notes/ for the
  26.07 release.

Warning: Missing RTE_EXPORT_EXPERIMENTAL_SYMBOL for mlx5 PMD functions
  rte_pmd_mlx5_txq_rate_limit_query (patch 7) has the export macro.
  Verify rte_pmd_mlx5_pp_rate_table_query (patch 10) does too -- it
  appears to, which is good.

================================================================
Patch 10/10: net/mlx5: add rate table capacity query API
================================================================

Warning: VLA-sized stack array in rte_pmd_mlx5_pp_rate_table_query()
  The function declares:
    uint16_t seen[RTE_MAX_QUEUES_PER_PORT];
  RTE_MAX_QUEUES_PER_PORT is typically 1024, so this is a 2KB stack
  allocation. While not enormous, this is inside a function that could
  be called from any context. The O(n*m) dedup loop (for each queue,
  scan seen[] for duplicates) is also inefficient for large queue
  counts. Consider using a bitmap or a small hash set, or just
  counting unique pp_ids from the shared context rather than scanning
  all queues.

Warning: "used" count only reflects this port's queues
  The function counts unique PP indices across priv->txqs_n queues
  for one port, but the HW rate table is shared across all ports on
  the same device (shared context). If multiple ports share the same
  PCI device, the "used" count will underreport. Consider iterating
  over all ports on the same sh, or documenting that the count is
  per-port only.

================================================================
General series observations
================================================================

Info: Patch 1 (doc fix) has a Fixes tag referencing the original
  scheduling devargs commit, which is appropriate. However, patches
  2-10 are new features and should not have Fixes tags (they don't,
  which is correct).

Info: The series adds three new experimental PMD APIs and one new
  ethdev API. All new APIs in headers have __rte_experimental on
  their own line, which is correct. The export macros use the 26.07
  version tag.

Info: The series lacks a cover letter in this bundle. For a 10-patch
  series adding a significant new feature, a cover letter explaining
  the overall design and testing would be expected by reviewers.
