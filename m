Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD1C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 17:25:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02CEB40268;
	Wed, 26 Aug 2026 19:25:33 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7129F40264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 19:25:32 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca80d708489so98266a12.1
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787765131;
 x=1788369931; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Blc/DjBY0eyWuQBUKuvqpE3Ll/akzAqMA1s/+OU8cmM=;
 b=V7LHqMAkfFNFu0cMIrfT6LVCGtSYz1wfuHtFRehDNMTUU0CMfXED1FO3GVxNwW2Jl8
 19EVGJCYQPhTg4A7CWtN/97I4cnWbahObi1OBh4fIWbgpbjVL09jtrogHLM9By2TGTdu
 bAym4l442n5QvdQb/WsK684srdXlXbQpJMLt4QXTHC3P3/0nh8EMAtJr/SlY9zhniBhP
 2kXkSX4j1jLf7EhjGNI2izif9MD72IHYaI/RumtXSZ9Q5atZ0R4M25GYLHYOgLShyu0e
 hXg5cRJDlyzn8IXvlz+ATTQCXqBFgxlUgfobrCoXhG5eEqVm41R8trfvdAaYR6TI7WEK
 dAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787765131; x=1788369931;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Blc/DjBY0eyWuQBUKuvqpE3Ll/akzAqMA1s/+OU8cmM=;
 b=ZeYcm0zi+69AAmn9Bt1UcKpfJk6b0IuXswotBs9MmF5Ei+TitBOQGbVH/KieWvZuhn
 W4PxsE+xBavUETLjS8el9Av/QV2tI96Tw8PnU+fp/mw1f9zcSoREvp08BjxmHZSYZU4c
 g3yeFiNE3+NPf1PF+P/7kISxWuQz7mLTCWSJLSk2ikBUIo8nvUNtA5o8+bK1GbrUelsS
 GCVPsinsOfuWO2mSfwdfSyxUHLNBiaV49+8Nd3vS6kzieVjVCWbxFmwlAN/JL7akIqbl
 U+rycXNbux0milo2+sogUSMQDrhyTgNRhE9MoCqgSgx4z1nYzTSpXRGppWf2iugC46K6
 p8fQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLs9+6hOU88LQoyqoBthxq22OdPvLDKkvsftIv3QGLLLP3tktwrY2r8uw769GCPEQwqbs=@dpdk.org
X-Gm-Message-State: AFuF++liCsfyr9b9R+cRcfpYHV1qHKrwpSGDYQZyXwL2zQ1cQE0XhGka
 WRLsoXabPrPZOMewduoU3gEAsW2q4Qp4PUb5/hUjHjEuqQRfWKOsfF2xOXOAlSV++/E=
X-Gm-Gg: AR+sD102XLMv0HJduDBy6wD2kxgn/XrZADbSsqw6wTzaEHRqJpLr82VRQshyB67vXne
 mmZ50EZAnwQ/eeZDlTmZf5prZpSkW+bcwk25xemnWmy0QESuyQM+zxbPgciMXcXND/RsmmgFyLu
 rZakKMb36IY+wA9BijZ6YLqEVt/BuilbXc2iHCtBKoUJIIxLje6cIC8D7Ad57OyTQ74ptQ/0bDH
 n0c82Oeg9PMzV/5y5OdBJowd1Yi3t5kPE/KR3n9zYicY37K5Qpq2Yf2Upn2AbJQaPa4UVDUnU3Q
 vYJ8+KKyW/Y+eJb1TzU+XWNYqc2/REVs5tSDm2RNY6A1C7xSJnbf7aSv3k4CPyKL26+m/AFKL98
 l7RU0xRRylr32041uRgnOpiiIe9Bwff5dk0Tjq93WqthHisY6V3hxMrA/376WiZlBDhdj83+EMm
 dY3Wdu/DU9ybTvxQWukFZ2Gw5ZRDCpDwqxeFWMAOsbwYXhtJYUEe4krnybw4Aw2Sw35RFpLSTTP
 BCbqmXvUe8RFz/rF6OyyCJy9Dpp/Q==
X-Received: by 2002:a17:90a:5182:b0:38e:42f5:d096 with SMTP id
 98e67ed59e1d1-3969b7ef2femr657548a91.0.1787765131080; 
 Wed, 26 Aug 2026 10:25:31 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d31e74sm9095224a91.11.2026.08.26.10.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:25:30 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:25:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v14 00/23] NXP DPAA driver enhancements and fixes
Message-ID: <20260826102520.0a6a90f9@phoenix.local>
In-Reply-To: <20260820144312.3922316-1-hemant.agrawal@nxp.com>
References: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
 <20260820144312.3922316-1-hemant.agrawal@nxp.com>
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

On Thu, 20 Aug 2026 20:12:49 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> errata-workaround devargs. Documentation and release notes are updated
> accordingly.
> 
> v14:
> * Dropped the ORP queue create and destructor patch.

Still seeing some issues like double free and unitialized data showing
up on AI review.

Reviewed the v14 series applied on c1a46b9.  All 23 patches apply
cleanly with git am.

Resolved since v13
------------------

Thanks for taking the two structural items off the table:

  - The ORP patch is dropped, so the __rte_internal reachability
    question goes with it.
  - The dpaax enter-destructor patch is dropped, which resolves the
    latch-versus-rte_free() contradiction I raised against v13.

Also confirmed fixed in the applied tree:

  - U48_BY_HI16_LO32() now casts hi to uint64_t before the shift.
  - struct ip_pair_s and struct lgw_subnet_s are prefixed as
    dpa_ip_pair_s and dpa_lgw_subnet_s.
  - The release note for the DMA devargs now describes them as
    controlling existing behaviour ("instead of the default
    scatter-gather batching") rather than claiming SG was added.
  - The devargs section of doc/guides/nics/dpaa.rst is now a proper
    definition list.
  - The offline-port control fd is closed and reset to -1 in
    dpaa_ol_dev_close().

The three Fixes: tags (patches 01, 02, 03) all resolve to real
commits with matching subjects, use 12-character hashes, and carry
Cc: stable@dpdk.org.

Errors
------

Patch 21/23: drivers: add offline (O/H) port device support

  dpaa_ol_remove() double-frees the ethdev private data:

      dpaa_ol_dev_close(eth_dev);
      rte_free(eth_dev->data->dev_private);
      return rte_eth_dev_release_port(eth_dev);

  rte_eth_dev_release_port() already does
  rte_free(eth_dev->data->dev_private) in the primary process (see
  lib/ethdev/ethdev_driver.c), so the pointer is freed twice.  The
  driver does not NULL it in between.

  rte_dpaa_remove() in dpaa_ethdev.c gets this right -- it calls
  rte_eth_dev_release_port() and nothing else -- so the OL path is
  the outlier.  Dropping the rte_free() line is the whole fix.

  Related: unlike rte_dpaa_remove(), which patch 06 gave a
  RTE_PROC_PRIMARY guard, dpaa_ol_remove() has none.  In a secondary
  the explicit rte_free() would also be operating on memory the
  primary owns.

Patch 18/23: bus/dpaa: optimize DPAA multi-entry buffer pool operations

  bman_release_fast() writes uninitialized stack bytes into the BMan
  release ring.

      struct bm_buffer bm_bufs[FSL_BM_BURST_MAX];   /* no initializer */
      ...
      bm_bufs[0].be_desc.bpid = bpid;
      for (i = 0; i < num; i++)
              bm_buffer_set64_to_be(&bm_bufs[i], bufs[i]);

      r->bufs[0].opaque = bm_bufs[0].opaque;
      if (num > 1)
              memcpy(&r->bufs[1], &bm_bufs[1],
                      sizeof(struct bm_buffer) * (num - 1));

  bm_buffer_set64_to_be() only writes be_desc.hi and be_desc.lo.  Of
  the four fields in struct bm_hw_buf_desc:

      be_desc.rsv    never written for any entry
      be_desc.bpid   written for entry 0 only

  Entry 0 reaches the ring through the .opaque read, which picks up
  the uninitialized rsv byte.  Entries 1..num-1 are memcpy'd whole,
  so they carry both uninitialized rsv and uninitialized bpid.

  The function this replaces does not have the problem, because it
  masks the top 16 bits off explicitly:

      r->bufs[i].opaque = cpu_to_be64(bufs[i].opaque & MAX_U48);

  so this is a regression introduced by the rework, not a
  pre-existing issue.  BM_RCR_VERB_CMD_BPID_SINGLE means the garbage
  bpid on entries 1..n-1 is probably ignored by the hardware, but
  rsv is a reserved field and this is stack content being published
  to a device-visible ring on every mbuf free.

  Zeroing the array at declaration is the cheap fix; having
  bm_buffer_set64_to_be() clear .opaque before writing hi/lo would
  also work and keeps the cost on the entries actually used.

Warnings
--------

Patch 10/23: drivers: add BMI Tx statistics

  fmbm_tfrc, the Tx Frame Counter, is declared but never wired up.
  It is present in struct tx_bmi_regs, it is the register the Tx
  stat window is anchored on --

      #define FMAN_IF_BMI_TX_STAT_OFFSET_START \
              BMI_TX_REG_OFFSET(fmbm_tfrc)

  -- and it is mirrored into struct dpaa_if_tx_bmi_stats, but
  fman_if_bmi_stats_get_all() does not read it,
  fman_if_bmi_stats_reset() does not reset it, and it has no entry
  in dpaa_xstats_strings[].

  That omission is what the "- 1" in the static_assert is absorbing:

      static_assert(sizeof(struct dpaa_if_rx_bmi_stats)
                              / sizeof(uint32_t)
                      + sizeof(struct dpaa_if_tx_bmi_stats)
                              / sizeof(uint32_t) - 1
                      == DPAA_BMI_XSTATS_COUNT, ...);

  8 + 5 - 1 == 12.  The assert is a good idea, but as written it
  silently tolerates exactly one unexposed struct member, so it will
  not catch the next one.  Either expose fmbm_tfrc (it is the most
  useful of the four Tx counters) and drop the "- 1", or drop the
  member from the struct.  Carrying it in the struct while hiding it
  from the assert is the worst of the three.

Patch 20/23: net/dpaa: enhance VSP port support

  Two fields added by this patch are never read or written anywhere
  in the tree:

      struct dpaa_if_vsp {
              ...
              uint32_t max_size;      /* no users */
      };

      struct dpaa_if {
              ...
              uint8_t base_vsp;       /* no users */
      };

  bp_num and vsp_bp[] are used; these two are not.  Worth dropping
  until something needs them.

Patch 06/23: drivers: add process-type guards for secondary process

  The dma/dpaa guard fixes a real problem but leaves the secondary
  in a state that will still fault.

  Returning early from dpaa_qdma_init() does stop the secondary from
  re-running the mmap and re-allocating queue resources on top of
  the shared struct fsl_qdma, which is a genuine improvement.  But
  dpaa_qdma_probe() has already installed dev_ops and every
  fp_obj->* handler before calling init, and it goes on to set
  state = RTE_DMA_DEV_READY afterwards.

  fsl_qdma lives in the shared hugepage allocation, so the secondary
  sees the primary's values -- including reg_base, which comes from

      fsl_qdma->reg_base = mmap(NULL, regs_size, ...);

  a process-private mapping only valid in the primary.  So a
  secondary that calls rte_dma_copy() on the device gets a READY
  device whose MMIO pointers are not mapped in its address space.

  Either the secondary needs its own mapping kept in process-private
  storage, or probe should not advertise the device as READY for a
  secondary.

Patch 21/23: drivers: add offline (O/H) port device support

  check_fd() is double-checked locking on a non-atomic int:

      static int fd = -1;

      static int check_fd(void)
      {
              if (fd >= 0)              /* unsynchronized read */
                      return 0;
              ret = pthread_mutex_lock(&fd_init_lock);
              assert(!ret);
              if (fd < 0)
                      fd = open(ASK_PATH, O_RDWR);
              ret = pthread_mutex_unlock(&fd_init_lock);

  The fast-path read of fd races with the store under the lock.  Per
  the atomics section in AGENTS.md this wants
  rte_atomic_load_explicit(&fd, rte_memory_order_acquire) on the
  first check and rte_atomic_store_explicit(..., release) on the
  assignment, with fd declared as RTE_ATOMIC(int).

Info
----

Patch 15/23: net/dpaa: support Rx/Tx taildrop threshold devarg

  Carried over from v13 and still unanswered: now that
  drv_tx_taildrop exists, the DPAA_TX_TAILDROP_THRESHOLD getenv()
  fallback in dpaa_dev_init() is redundant.  It is pre-existing code
  so checkpatch will not flag it, but the patch touches that exact
  block, and the new RST documents only the devarg -- the env var is
  now an undocumented second way to set the same value.  Removing it
  here, or noting the deprecation in the release notes, would close
  it out.

Patch 18/23: bus/dpaa: optimize DPAA multi-entry buffer pool operations

  BIT_SIZE, MAX_U48, HI16_OF_U48 and LO32_OF_U48 are unprefixed in
  fsl_bman.h.  The header is not installed, so this is not an ABI
  concern, but bus/dpaa exports its include directory to net/dpaa,
  crypto/dpaa_sec, mempool/dpaa and dma/dpaa, and BIT_SIZE and
  MAX_U48 in particular are generic enough to collide there.  The
  #ifndef guard on BIT_SIZE suggests this already came up once.

Patch 21/23: drivers: add offline (O/H) port device support

  ask_get_channel_info() is declared uint32_t but returns -ENODEV
  and ioctl's -1:

      static uint32_t
      ask_get_channel_info(struct ask_ctrl_offline_channel *ch_info)

  It happens to work because the only caller assigns to an int and
  tests if (ret), but ask_set_fq_info() right below it is correctly
  static int.  Worth matching.

  DPA_ISC_IPV4_ADDR_TYPE and friends, and the struct tags
  dpa_ip_addr_s / dpa_ip_pair_s / dpa_lgw_subnet_s, are still
  outside the rte_ namespace in rte_pmd_dpaa_oldev.h, which is an
  installed header.  The DPDK_-prefixed macros in the same header
  are arguably worse -- DPDK_ reads as a framework namespace rather
  than a PMD one.  Not a blocker, but this is the header
  applications will include.

  check_fd() uses assert() from <assert.h>; RTE_ASSERT is the DPDK
  spelling and compiles out consistently with the rest of the tree.

Patch 10/23: drivers: add BMI Tx statistics

  The zero-fill fallbacks in fman_if_bmi_stats_get_all() use bare
  literals:

      while (i < 8)  value[i++] = 0;
      ...
      while (i < 12) value[i++] = 0;

  These have to stay in step with DPAA_BMI_XSTATS_COUNT on the
  consumer side, which is derived.  Deriving them the same way, or
  at least naming them, keeps the two ends from drifting.

Patch 06/23: drivers: add process-type guards for secondary process

  Commit message: "net/dpaa rivers" should be "drivers".

Patch 23/23: doc: update release notes with NXP DPAA changes

  The RST body was corrected, but the commit message bullet list
  still says "DMA scatter-gather support and ERR050757 workaround",
  which is the claim patch 14's message was reworded to drop.
