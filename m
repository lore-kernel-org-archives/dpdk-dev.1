Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF8ACCA464
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 19:57:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2F074027C;
	Thu, 15 Oct 2026 21:57:33 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 0E1E9400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 21:57:31 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so602144a91.3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792094251;
 x=1792699051; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1YBYJELbz3J86IFXFYoMDgckRRCo2gnBNVqiWbPXX7A=;
 b=knmeujHUCuBmbTjtPplsb2Hk8Knxlu8oL8MUxMcRdOJQaB5RdJIpXjUFNOSkpZ9peb
 MRP2Q8X0FisY3kFJqASusjTYx/SJ0z9mFWkQUOaE/FfzrGkWXLUr5UuXCGcGu/lc5Poe
 qLjQUZOHy0Jj+JRvV4jC5bkFZlC03Ikql8LQP0jrQ6eWxLxRjrI7fYJRIoUsJqhH1DHy
 L8035YLhk69JV75YEBdw3IjIwkNH6GQcmwA9d5JaXqKtF8cmZHZYVWovn4YLFcC/zTkk
 gIlk7AKs4GdzaP0PNsNfzWInQlfRThIGeYdqJIibCLZ5XMYOdWVjFqxSFgtmWhwwpvhG
 899Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792094251; x=1792699051;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1YBYJELbz3J86IFXFYoMDgckRRCo2gnBNVqiWbPXX7A=;
 b=JGKdIUCXVFeI34eQW6BjzR/a95Z0XMoLohPHCqS4jyQ5z6PNV+Aqc/x3ffO6gScQey
 X8WGazB4v/xId349jdDJUpSExFf/Qyt4uIsXeP5L8j/E8UxxXXWnp82qs/LYm4h6OKZe
 c2tbCXWtYsrsdsQ8MqlMR5hBt43owOMsIEnkgRyNFZl7tfh8fgZckVZoeWEuetOzRnr2
 yPsmId67E5oL4bgd5k1+C6xTCN2oNF/pe6dF94x6y6GJqTPMvraRbWJxa1hINrElFylx
 haPayhXMPFvAU4+wusC0y6Yrt8AG6zWqpuw2IveH6NsxsIZPcrEyGqP4qW4BD6fVaiMU
 0oXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAxVwUwEsXHAlWnVHSGg6D1nMNbkQRXNmpfxemJGbBg3vuP9lklKlYGsKwmSObITizyQo=@dpdk.org
X-Gm-Message-State: AFq9FYKmHs+P3UjBmOCFZDwBjZbOcx2sX3bGBZCYyhY06uInyTURFj+T
 2krCMh5hT1ckVfSNZJVbCme4EHxF/ibmtjuXH57OohvrxIh+amxj5Mojf9X8dS5T86U=
X-Gm-Gg: AYBFou3A9ew1QZCJyRk36xoUrJV4SSwmFR4bfT7oghJM2RBAqpzr5cCoRFreIuC/AXb
 JWgU0HA6btZOoAidmN5jZ4ML2EiZXrnBnSIFd6ifVA7KeZWRXUh/tl3AVzokXhB66hjj1XxsvS1
 6Vb5ISloZGcUlJChibpy0Uhuw/NfMuT4oELDMyyspm/YNDdsDmnh6T/sUUZjzsszQvePof/P6C4
 Pq0w8qgmlMfR3kLvOjY/nCChGVF0OVfM8stkaWdF+lY57H3X9HCNH6vkK9xPooj/N/tvfYPSNCH
 hjHzYWjZlRsgKqHMc+5SRuXtMRm6zsfS2IiJL2OGq8KdijulEZ4wXrh+ZYxBgF+JdDnKSjXW2R4
 lV3PPFh1ytNC2eEJtBeih/W99rL3a2zLld1hOdj0HiSvG114ayfeKAZTYyVFj2jCAqTGiO896qI
 Kq49dtEh7T1nmkUQRA+MPuU2harWXoUBMs3k3Wao64oLo8VrV4WFbQVmOfwvred6pcAir6EEnyI
 Ki1u+01vTOQAhNLz0DT00aRY9LdiRYjxvTqfYYn
X-Received: by 2002:a17:90b:58cb:b0:3ac:e6a:1b2b with SMTP id
 98e67ed59e1d1-3ac0e6a4ed3mr10493237a91.0.1792094250776; 
 Thu, 15 Oct 2026 12:57:30 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac945e7311sm5788431a91.4.2026.10.15.12.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:57:30 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:57:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v26 00/26] NXP DPAA driver enhancements and fixes
Message-ID: <20261015125727.04f0b4ac@phoenix.local>
In-Reply-To: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
References: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
 <20261015141144.3140281-1-hemant.agrawal@nxp.com>
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

On Thu, 15 Oct 2026 19:41:18 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue shutdown, secondary-process
> safety guards, BPID lifecycle handling, and several new features:
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration, non fmX-macY shared Ethernet naming, and DMA
> scatter-gather and errata-workaround devargs. Documentation and release
> notes are updated accordingly.
> 
> v26:
> * bus/dpaa: split the FQ shutdown hang fix out as its own patch with
>   Fixes/Cc: stable, and keep the DTS pool-channel-range scan as a
>   separate feature patch.
> * dma/dpaa: split the data-validation gating out as its own fix with
>   Fixes/Cc: stable, ahead of the SG/errata devargs feature patch.
> * bus/dpaa: fixed "scan max BPID from DTS" commit message to describe
>   the bman_ip_rev removal and the now-fatal missing-node/CCSR-map
>   paths, and moved the BPID range log from pr_info() to
>   DPAA_BUS_DEBUG() so it no longer prints to stdout on every start.
> * net/dpaa: fixed use-after-free in VSP: the per-profile buffer pool
>   is now stored by BPID and size instead of a dpaa_bp_info pointer,
>   which could be freed by dpaa_mbuf_free_pool() while the port was
>   still around.
> * bus/dpaa: stopped bman_release_fast() from writing the verb byte of
>   a multi-entry release command before the rest of the entry is
>   built.
> * dma/dpaa: propagated the enqueue status instead of forcing -EIO on
>   a transient ring-full condition in the non-SG path.
> * crypto/dpaa_sec: affined a portal in dpaa_sec_uninit() before
>   calling qman_shutdown_fq(), and stopped releasing the FQID of a
>   queue that failed to shut down on the probe error paths, matching
>   the rule the normal uninit path already follows.
> * drivers: made the DPAA QDMA secondary-process probe return a
>   positive value instead of -ENOTSUP, so the bus skips the device
>   quietly instead of logging three errors.
> * net/dpaa: dropped the drv_fmcless_rxq devarg; FMCLESS mode now
>   always creates the maximum number of queues and lets
>   rte_eth_dev_configure() decide how many are used.
> * net/dpaa: renamed the global fmlib create_device() and
>   get_device_id() helpers to fm_create_device() and
>   fm_get_device_id(), the only two global symbols in the driver
>   without the fm_/dpaa_ prefix.
> * doc: updated the release notes to match the bullets above instead
>   of the devargs from the previous version.


Semi-automated AI review is still seeing some issues, don't feel it is ready to merge.

Review of [PATCH v26 00/26] NXP DPAA fixes and enhancements

Series applies cleanly to main and every commit builds with
-Dwerror=true.

v25 Error (VSP use after free) and the v25 Warnings on 11, 17, 19,
20, 23 and 24 are addressed. Dropping the drv_sh_if_name and
drv_fmcless_rxq devargs is the right call.


Warning
=======

[PATCH v26 12/26] bus/dpaa: scan pool channel range from DTS

qm_channel_pool_num now comes straight from the DTS and bounds the
pool channel test in qman_shutdown_fq():

  qm_channel_pool_num = rte_be_to_cpu_32(chanid[1]);

The SDQCR pool field is 15 bits, and QM_SDQCR_CHANNELS_POOL_CONV()
computes 0x00008000 >> (channel + 1 - pool1). A count of 16 selects no
channel at all, so the drain never sees the FQRN; a count of 32 or more
is an undefined shift. A count of 0 makes every pool channel FQ fail
as a DCP channel. The old code hardcoded 15. Clamp it the same way 08
clamps the BPID range:

  if (qm_channel_pool_num == 0)
          return -EINVAL;
  if (qm_channel_pool_num > 15) {
          pr_warn("pool-channel-range count %u > 15, clamping\n",
                  qm_channel_pool_num);
          qm_channel_pool_num = 15;
  }

[PATCH v26 20/26] net/dpaa: support fmcless rxq number as devargs

The devarg is gone but the subject and commit message still describe
it ("configured per port through the 'drv_fmcless_rxq' device
argument", "a malformed value fails the probe"). The patch only
changes the FMCLESS default. Suggested message:

  net/dpaa: create max Rx queues in FMCLESS mode

  In FMCLESS mode, create DPAA_MAX_NUM_PCD_QUEUES Rx frame queues
  instead of one per lcore, since several queues may be polled from
  the same core. configure() selects how many are used.

[PATCH v26 24/26] drivers: improve DPAA crypto fq resource handling

The new teardown in dpaa_sec_uninit() and in the init_error paths
shuts down the FQs and releases the FQIDs, but never frees the
qman_fq_lookup_table slot that qman_create_fq() took:

  if (unlikely(find_empty_fq_table_entry(&fq->key, fq))) {

The table has CONFIG_FSL_QMAN_FQ_LOOKUP_MAX (32K) entries and each
probe takes RTE_DPAA_MAX_RX_QUEUE + max_nb_queue_pairs (4098). About
eight remove/probe cycles exhaust it and qman_create_fq() returns
-ENOMEM. Every leaked slot also points into dev_private, which
rte_cryptodev_pmd_destroy() frees.

qman_destroy_fq() clears the slot, but it is not exported and only
does so for an FQ in the oos state, which qman_shutdown_fq() does not
set. Export it with RTE_EXPORT_INTERNAL_SYMBOL, and after each
successful shutdown:

  fq->state = qman_fq_state_oos;
  qman_destroy_fq(fq, 0);

(The FQs are created without QMAN_FQ_FLAG_DYNAMIC_FQID, so this does
not release the FQID a second time.) The same applies to the TXQ in
init_error1 when qman_init_fq() fails after qman_create_fq()
succeeded.


Info
====

[PATCH v26 11/26] bus/dpaa: fix hang on FQ shutdown

Does not cherry-pick onto main without 10, which is not a fix and will
not go to stable. Move it ahead of 10 so stable gets it as-is.

[PATCH v26 25/26] net/dpaa: prefix fmlib device helpers

Two unprefixed globals are still left in net/dpaa:

  drivers/net/dpaa/dpaa_flow.c:37:
    const uint8_t mac_idx[] = {-1, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1};
  drivers/net/dpaa/dpaa_fmc.c:205:
    struct fmc_model_t *g_fmc_model;

mac_idx[] has no users; remove it. g_fmc_model is only used in
dpaa_fmc.c; make it static. Renaming internal symbols does not need a
release note, and "every global symbol of the driver carries a prefix"
does not hold yet. Drop that bullet from 26.

Still open from v25, unchanged, optional:
  04  pre-existing: dpaa_dev_init() error path frees cgr_rx/cgr_tx
      without qman_delete_cgr(); the portal cgr_cbs list keeps the
      freed nodes
  12  QMAN_MAX_FQID, QMAN_CHANNEL_PME and QMAN_CHANNEL_PME_REV3 unused;
      dpaa_get_qm_channel_pool_num() is bus-internal and needs no
      export
  15  FMC_PORT_NAME_OFFLINE branch unreachable; offline/ONIC fifs log
      "Unknown mac_type" at ERR
  21  bm_buffer_get64_from_be() should be a static inline function
  24  fqids[RTE_DPAA_MAX_RX_QUEUE] is 16 KB on the probe stack
