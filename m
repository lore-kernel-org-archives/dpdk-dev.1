Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F31C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Aug 2026 15:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24DD340278;
	Sat, 15 Aug 2026 17:38:51 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 4869940272
 for <dev@dpdk.org>; Sat, 15 Aug 2026 17:38:49 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2865665a91.3
 for <dev@dpdk.org>; Sat, 15 Aug 2026 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786808328;
 x=1787413128; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N3GX7gz6ow2P32y2ez/4bxJdIzc//hDRnGW2zd/SnLQ=;
 b=FmWkrf9g0PI0OY1PQLjNfNqbqdU3RN1kffzRACQcPLQwQcL7PSN1SkvwmVjlE+Gn4w
 jY4VQwWOMBpJBcP3GNj5lv8znRDHZpYdQxu2atBZXNlRdpPoRZEpnr1nAUGC+vtzbyk+
 GODWhDWCMnBmbRfXS8Zw9yvrBU5uhAGMtzBEBN9efW0BH1b+tbYsjZWDHm6US11kW+c6
 krBrxV5USPZLDnmxR48/KTlpm9MFVSmHT7oDoCZyH5OEFhYcTQHs2MRPppc/WnT+lUnm
 uQfnSE43KT0czXVI3XwVZ/9CRxMmuFeSRvude1Q/ynwoEUjc5EbUfqdR5IBW5WnMvMOF
 sK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786808328; x=1787413128;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N3GX7gz6ow2P32y2ez/4bxJdIzc//hDRnGW2zd/SnLQ=;
 b=JA1v2n3RBT8E4ulcO4xxX+sI3bkm8Fgtm/lCl1ifauk9d4BunPo+sL55cknxleWEJ3
 S72LbaxGYWtmR3oRifdqzUhXjYDmIjiuyBgxlXzPIfmbLV+Tmn2fFJIeFin3yY44mPwU
 Ehdq2YY/ccjKk2qNVfiRTfEaPPqAg3QBzhzH2g6Otu4OAiiXuZOQZqXdZgUHcEWF8ghC
 kv/IxM3Ke10d5fkgjJWVQM7x9HjP2krFxJevYsDQugjc/py4knGt2t+TeLOtfKW2aVC4
 EVW48vRwiaYAiLjRBcVNL8+GblKOx/dLG+Oo/+Azxq7oeDrU1wcbrR8zkZK0wPWKm7Pc
 qdAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBK9aN7rKrvFbcFWDE8FxLtRN+FfrJVfgo9J6haPAXqeq2aZcMBT2UXuvUF+ChNhggDpw=@dpdk.org
X-Gm-Message-State: AOJu0Yz5TmLyeW0HPJNI1+FzmHlo01P0yzy2Sa7Afitznbw+aSKSDKTm
 /BGYZ2VkPOOjzGte5dfhJA0EtnHFOB0tS03ePncZvoiWDELjstisxMhc2x1XhYMrYbE=
X-Gm-Gg: AR+sD11PCj5kNeggdGg12pQyTF+6B4oW6wnd0kpfcirqgbMe/MvNpqk1riR0NK2ex6l
 PAu/vZ+GOTuv1Lll3gy/9j8K0oPVUjV3HBv9XmChy/+8ygHy++t8bMYVke1IqpzyUPYobzVV/c3
 Tgfn3dj248XPqbW08WFbncC5cGyJ09OCaV6P1+bl5IDd6dbm4q3JjBrZC8BOdtJQlwBgjMtD2Ha
 FRb2iT7XRpom4O64W6tvC1oG9P4q18kFkMLcrUnjUg6LzBVwRgcWqhY1aBYGMs+un6qEeB08JL6
 hQajUp5QuqspkiD2AcnCuasVZVk7qzEmS7qDGDdrusMDkfHVoCPLmf+dd7XJHpU4h9+U6tmODL/
 Ez7/lrreHmBFDpHeRJNgGRAhrSoS0Niai/mESobuzh9nbg7IvztN4baTZ97u8aaJgqZm+wrdQO/
 tLkBdOSDot0yRWAoP3ONdh7QzCAr67SMvab7FeFbCcmdTWLxy0kmkO/v8KBkFR7nytPRw0nGZGT
 M+xQXaszqUJJELm6teS7m+QsOAoOg==
X-Received: by 2002:a17:90b:1dcc:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-3933b77c874mr16591141a91.3.1786808327992; 
 Sat, 15 Aug 2026 08:38:47 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ea302649sm15252119eec.24.2026.08.15.08.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 08:38:47 -0700 (PDT)
Date: Sat, 15 Aug 2026 08:38:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v11 00/25] DPAA driver fixes and improvements
Message-ID: <20260815083839.42040cce@phoenix.local>
In-Reply-To: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
References: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
 <20260813144205.2505031-1-hemant.agrawal@nxp.com>
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

On Thu, 13 Aug 2026 20:11:40 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> v11: address AI review comments; skipping false positive ones.
>   - net/dpaa: fix lost close error in rte_dpaa_remove()
>   - net/dpaa: fix NULL dereference on rte_dpaa_bpid_info in oldev rx
>     queue setup
>   - net/dpaa: fix error logging in oldev tx queue setup to include
>     return code and return proper -EINVAL
> 
> v10: address further AI review comments
>   - dma/dpaa: expose compile-time static flags (sg_enable,
>     data_validation, pci_read) as probe-time devargs with corrected
>     logic and updated documentation
>   - bus/dpaa: fix pool-channel FQ shutdown always returning -EINVAL
>     (wrong affinity check; dedicated and pool channel ranges never
>     overlap)
>   - mempool/dpaa: fix double-free of bpid_info on pool release
> 
> v9: fix bissect issue and other AI review comments
> 
> This series collects a set of correctness fixes, cleanups and feature
> additions across the NXP DPAA bus, net, mempool and DMA drivers.
> 
> 1. Bus/fman infrastructure cleanups (patches 01, 02, 12)
>    - bus/dpaa: refine fman naming and fix global scope
>    - bus/dpaa: scan max BPID from DTS
>    - bus/dpaa: improve log macro and fix bus detection
> 
> 2. Process-type guards (patch 03)
>    - drivers: add process-type guards to prevent segfaults in secondary
> 
> 3. FQ shutdown hardening (patches 04-08)
>    - bus/dpaa: shutdown DPAA FQ by fq descriptor
>    - bus/dpaa: improve FQ shutdown with channel validation
>    - bus/dpaa: add DPAA cgrid cleanup support
> 
> 4. net/dpaa improvements (patches 09, 11, 13)
>    - net/dpaa: optimize FM deconfig
>    - net/dpaa: optimize FMC MAC type parsing
> 
> 5. Statistics (patch 10)
>    - drivers: add BMI Tx statistics
> 
> 6. mempool/dpaa (patch 14)
>    - drivers: release DPAA bpid on driver destructor
> 
> 7. dma/dpaa (patches 15-16)
>    - dma/dpaa: add SG data validation and ERR050757 fix
>    - dma/dpaa: expose static flags as probe-time devargs
> 
> 8. net/dpaa features (patches 17-22)
>    - net/dpaa: support Rx/Tx taildrop threshold devarg
>    - net/dpaa: add Tx rate limiting API
>    - bus/dpaa: orp queue create and burst enqueue
>    - net/dpaa: support fmcless rxq number as devargs
>    - net/dpaa: support non fmX-macY type of shared Ethernet name
>    - bus/dpaa: optimize DPAA multi-entry buffer pool operations
> 
> 9. Shutdown and cleanup (patches 23-24)
>    - drivers: improve shutdown fq with channel
>    - drivers: improve crypto fq resource handling
>    - net/dpaa: enhance VSP port support
>    - drivers: add offline (O/H) port device support
>    - drivers: add dpaax enter destructor to gate EAL memory frees
> 
> 10. Documentation and release notes (patch 25)
>     - doc: update release notes with NXP DPAA changes
> 
> Gagandeep Singh (3):
>   net/dpaa: fix device remove
>   dma/dpaa: add SG data validation and ERR050757
>   drivers: add offline (O/H) port device support
> 
> Hemant Agrawal (6):
>   net/dpaa: optimize FM deconfig
>   net/dpaa: support Rx/Tx taildrop threshold devarg
>   net/dpaa: add Tx rate limiting API
>   net/dpaa: support non fmX-macY type of shared Ethernet name
>   bus/dpaa: improve log macro and fix bus detection
>   doc: update release notes with NXP DPAA changes
> 
> Jun Yang (14):
>   bus/dpaa: refine fman naming and fix global scope
>   bus/dpaa: scan max BPID from DTS
>   drivers: shutdown DPAA FQ by fq descriptor
>   bus/dpaa: improve FQ shutdown with channel validation
>   bus/dpaa: add DPAA cgrid cleanup support
>   drivers: add BMI Tx statistics
>   net/dpaa: optimize FMC MAC type parsing
>   drivers: release DPAA bpid on driver destructor
>   bus/dpaa: orp queue create and burst enqueue
>   net/dpaa: support fmcless rxq number as devargs
>   bus/dpaa: optimize DPAA multi-entry buffer pool operations
>   drivers: improve shutdown fq with channel
>   drivers: improve  crypto fq resource handling
>   drivers: add dpaax enter destructor to gate EAL memory frees
> 
> Prashant Gupta (1):
>   drivers: add process-type guards for secondary process
> 
> Vanshika Shukla (1):
>   net/dpaa: enhance VSP port support
> 
>  doc/guides/dmadevs/dpaa.rst               |  29 +-
>  doc/guides/nics/dpaa.rst                  |  39 +-
>  doc/guides/rel_notes/release_26_11.rst    |  29 +
>  drivers/bus/dpaa/base/fman/fman.c         |  23 +-
>  drivers/bus/dpaa/base/fman/fman_hw.c      | 111 ++--
>  drivers/bus/dpaa/base/qbman/bman.c        |  59 +-
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  51 +-
>  drivers/bus/dpaa/base/qbman/qman.c        | 207 +++++--
>  drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
>  drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
>  drivers/bus/dpaa/dpaa_bus.c               | 164 +++--
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
>  drivers/bus/dpaa/include/fman.h           |  20 +-
>  drivers/bus/dpaa/include/fsl_bman.h       |  49 +-
>  drivers/bus/dpaa/include/fsl_qman.h       |  54 +-
>  drivers/common/dpaax/compat.h             |  22 +-
>  drivers/common/dpaax/dpaax_iova_table.c   |  25 +-
>  drivers/crypto/dpaa_sec/dpaa_sec.c        | 109 +++-
>  drivers/dma/dpaa/dpaa_qdma.c              | 110 +++-
>  drivers/mempool/dpaa/dpaa_mempool.c       |  64 +-
>  drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 310 ++++++++--
>  drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
>  drivers/net/dpaa/dpaa_flow.c              | 221 +++++--
>  drivers/net/dpaa/dpaa_flow.h              |   7 +-
>  drivers/net/dpaa/dpaa_fmc.c               |  73 ++-
>  drivers/net/dpaa/dpaa_oldev.c             | 705 ++++++++++++++++++++++
>  drivers/net/dpaa/fmlib/fm_lib.c           |  32 +-
>  drivers/net/dpaa/fmlib/fm_port_ext.h      |   4 +-
>  drivers/net/dpaa/meson.build              |  11 +-
>  drivers/net/dpaa/rte_pmd_dpaa.h           |  23 +-
>  drivers/net/dpaa/rte_pmd_dpaa_oldev.h     |  93 +++
>  33 files changed, 2282 insertions(+), 457 deletions(-)
>  create mode 100644 drivers/net/dpaa/dpaa_oldev.c
>  create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h
> 

Ran this through Claude Opus 5 with current AGENTS.md

Errors

Patch 21/25: net/dpaa: enhance VSP port support

  Two NULL derefs from the vsp_bpid[] -> vsp[].vsp_bp[] conversion.
  vsp_bp[] is an array of "struct dpaa_bp_info *", and dev_private is
  rte_zmalloc'd, so the pointers are NULL until a queue is set up.

  1. dpaa_eth_rx_queue_setup(), non-VSP branch:

       dpaa_intf->vsp[0].vsp_bp[0]->bpid =
               DPAA_MEMPOOL_TO_POOL_INFO(mp)->bpid;

     Nothing ever assigns vsp[0].vsp_bp[0], so this writes through
     NULL on the first rte_eth_rx_queue_setup() of any plain
     (num_profiles == 0) port.  The old line was a plain array store,
     "vsp_bpid[0] = ...".  The correct conversion is
     "vsp[0].vsp_bp[0] = DPAA_MEMPOOL_TO_POOL_INFO(mp);".

  2. dpaa_eth_rx_queue_bp_check() reads
     "dpaa_intf->vsp[vsp_id].vsp_bp[0]->bpid" at line 1138.  It is
     called from rx_queue_setup at line 1187, before the vsp_bp[0]
     assignment at ~1230, so the first Rx queue setup on a VSP port
     dereferences NULL too.  The old code read vsp_bpid[vsp_id], a
     uint32_t that is simply 0 when unset.

  Array bound removed.  dpaa_port_vsp_configure() lost

       if (vsp_id >= DPAA_VSP_PROFILE_MAX_NUM)
               return -1;

  and dpaa_port_vsp_update() replaced it with

       if (vsp_id >= (fif->base_profile_id + fif->num_profiles))

  but dpaa_intf->vsp[] is sized DPAA_VSP_PROFILE_MAX_NUM (8), and
  base_profile_id + num_profiles comes from the DTS with no relation
  to that.  The check that bounded the array is gone.  rx_queue_setup
  also indexes vsp[fif->base_profile_id] unbounded.  Keep the
  DPAA_VSP_PROFILE_MAX_NUM check in addition to the new one.

  The commit message's lead claim -- "Add fman_onic MAC type handling
  to get_rx_port_type()" -- is not in this patch.  get_rx_port_type()
  is untouched.

Patch 15/25: bus/dpaa: orp queue create and burst enqueue

  Missing store barrier before the verb write in
  qman_enqueue_multi_orp().  The loop is:

       eq->fqid = ...; eq->fd.* = ...; eq->orp = ...; eq->seqnum = ...;
       eq->__dont_write_directly__verb = eq_verbs;   /* publishes */
       dcbf(eq);
       lwsync();

  The verb byte is what makes the EQCR entry valid to QMan, and the
  lwsync() lands after it.  On arm64/ppc the verb store can become
  visible before the FD stores.  qman_enqueue_multi() in the same file
  gets this right: it writes all FDs, then lwsync(), then the verbs in
  a second pass, then dcbf in a third.  Follow that shape.

  Also: qman_enqueue_multi_orp() has no callers, and force_ooo is only
  ever set false in qman_create_fq() and read in two places -- nothing
  sets it true.  The whole patch is unreachable.  Either land it with
  its consumer or hold it.

Patch 22/25: drivers: add offline (O/H) port device support

  dpaa_create_device_list() returns before creating the OL device:

       dpaa_bus.device_count = 0;
       if (!dpaa_netcfg && dpaa_bus.oldev_enabled)
               return 0;
       /* Creating OL Device */
       if (dpaa_bus.oldev_enabled) { ... }

  rte_dpaa_bus_dev_build() was changed in this same patch to tolerate
  a NULL netcfg when oldev_enabled, so the configuration the feature
  exists for creates no devices at all.  Move the early return below
  the OL block, or drop it.

  rte_dpaa_remove() in dpaa_oldev.c is "return 0" -- no
  rte_eth_dev_release_port(), no dev_private free, no rx/tx queue
  free, no FQ shutdown.  dpaa_ol_dev_close() is likewise a no-op.
  The port and all rte_zmalloc'd memory leak, and the FQs stay live in
  hardware.

  dpaa_oldev_init() sets nb_rx_queues = nb_tx_queues =
  DPAA_DEFAULT_NUM_PCD_QUEUES but only initializes index 0
  (dpaa_ol_rx_queue_init(&rx_queues[0], 0), same for tx).  dev_info
  advertises the full count, so an app configuring queue 1 gets a
  zeroed qman_fq with fqid 0, and tx_queue_setup passes
  "fq_info.tx_fq_id = 0" to the kernel ioctl.

  RTE_EXPORT_EXPERIMENTAL_SYMBOL(..., 25.11) on all four
  rte_pmd_dpaa_ol_* functions.  The series targets 26.11 -- patch 14
  uses 26.11 correctly.

  rte_pmd_dpaa_oldev.h is installed as public API (added to headers in
  meson.build) and violates the namespace rules throughout:
  MAX_NUM_PORTS, MAX_NUM_SUBNETS, struct ip_addr_s, struct ip_pair_s,
  struct lgw_subnet_s, DPA_ISC_*, and DPDK_CLASSIF_* / DPDK_TELECOM_*.
  MAX_NUM_PORTS and "struct ip_addr_s" in a header an application
  includes will collide.  There is also no Doxygen anywhere in the
  file -- no @file, no @param/@return on any of the four functions,
  and no experimental warning block.

Patch 14/25: net/dpaa: add Tx rate limiting API

  rte_pmd_dpaa_port_set_rate_limit() applies the limit to the Rx port
  handle when one exists.  dpaa_intf->port_handle is set by
  set_fm_port_handle() using get_rx_port_type(); only the
  "!dpaa_intf->port_handle" branch opens a Tx port via
  get_tx_port_type().  So in FMC-less mode with PCD configured, a
  *Tx* rate-limit API programs the Rx port.  Always open the Tx port.

  No driver check.  The function does
  RTE_ETH_VALID_PORTID_OR_ERR_RET() and then casts dev_private to
  struct dpaa_if * and process_private to struct fman_if *.  Called
  with a valid non-DPAA port id it prints dpaa_intf->name and reads
  fif->mac_type / fif->mac_idx from a type-confused pointer.  The
  existing rte_pmd_dpaa_set_tx_loopback() in the same driver guards
  with is_dpaa_supported(dev); do the same.

Patch 20/25: drivers: improve shutdown fq with channel

  CGR use-after-free on the dev_init error paths.  qman_create_cgr()
  ends with "list_add(&cgr->node, &p->cgr_cbs)", so every created CGR
  is linked into the portal list.  The free_rx label does

       rte_free(dpaa_intf->cgr_rx);
       rte_free(dpaa_intf->cgr_tx);

  with no qman_delete_cgr() and no qman_release_cgrid_range(), leaving
  freed memory on p->cgr_cbs and leaking the CGRIDs.  This predates
  the series, but this patch is the one that adds
  qman_release_cgrid_range() to the success path, so the error path
  should be fixed in the same commit.

Warnings

Patch 12/25: dma/dpaa: add SG data validation and ERR050757

  The doc for dpaa_dma_pci_read_disable describes something the code
  does not do: "The workaround inserts a PCI read-back after each DMA
  write to flush posted writes."  The code sets srttype =
  FSL_QDMA_CMD_RWTTYPE and the source stride (ssen/sss/ssd) to bound
  read transaction length.  Nothing to do with write flushing.

  The commit message says the patch "adds scatter-gather support" and
  "adds a workaround for ERR050757".  Both already existed; the patch
  adds devargs to *disable* them.

  s_sg_enable / s_data_validation / s_pci_read are file-static but set
  per-device in dpaa_qdma_init(), so with more than one qdma device
  the last probe wins for all of them.  They are also int where
  s_hw_err_check next to them is bool.

  In the new !s_sg_enable loop, a mid-burst
  fsl_qdma_enqueue_desc_single() failure returns a hardcoded -EIO,
  discarding the real code.  The pending_num == 1 path above it
  propagates ret properly; a ring-full is transient and shouldn't be
  reported as -EIO.

Patch 13/25: net/dpaa: support Rx/Tx taildrop threshold devarg

  RTE_PMD_REGISTER_PARAM_STRING has no separators between the keys:

       DRIVER_RECV_ERR_PKTS "=<int>"
       DRIVER_RX_TAILDROP "=<int>"
       DRIVER_TX_TAILDROP "=<int>"

  concatenates to "recv_err_pkts=<int>drv_rx_taildrop=<int>...".
  Patch 12 gets this right with trailing spaces; patches 16 and 17 add
  to the same broken string.

  td_threshold / td_tx_threshold are file-static and never reset.
  They are consumed within the same dpaa_dev_init() call so a
  port's own devarg works, but a port probed *without* the devarg
  inherits whatever the previously probed port set, rather than the
  CGR_RX_PERFQ_THRESH default.

  The DPAA_TX_TAILDROP_THRESHOLD getenv fallback is retained now that
  a devarg exists.  Worth a deprecation note.

Patch 16/25: net/dpaa: support fmcless rxq number as devargs

  num_rx_fqs = (int)fmcless_rxq with only an upper clamp.
  drv_fmcless_rxq=0 or a negative value flows into
  dpaa_intf->nb_rx_queues (uint16_t), so -1 becomes 65535 in
  dev_info.max_rx_queues.  Reject anything < 1.

  The FMCLESS default changes from rte_lcore_count() to
  DPAA_MAX_NUM_PCD_QUEUES (8).  That is user-visible and belongs in
  the release notes.

Patch 18/25: bus/dpaa: optimize DPAA multi-entry buffer pool operations

  BIT_SIZE, MAX_U48, HI16_OF_U48, LO32_OF_U48 and U48_BY_HI16_LO32
  move from bman.c file scope into fsl_bman.h, which net/dpaa,
  mempool/dpaa, crypto/dpaa_sec and dma/dpaa all include.  Only
  BIT_SIZE is #ifndef-guarded.  These need a dpaa_/bm_ prefix.

  U48_BY_HI16_LO32(hi, lo) does "(hi) << 32".  It is safe at the one
  call site because hi is a local uint64_t, but as a header macro any
  caller passing a 32-bit hi gets undefined behaviour.

  bman_hw_extract_addr() was a static inline with type checking;
  it is replaced by bm_buffer_get64_from_be(), a statement-expression
  macro.  That is a step backwards -- keep it an inline function.

  Commit message says the patch uses "a single bm_hw_buf_desc
  structure for HW initialization of the first entry and copy it to
  remaining entries."  The code sets each entry's address individually.

Patch 23/25: drivers: improve crypto fq resource handling

  RTE_DPAA_MAX_RX_QUEUE is MAX_DPAA_CORES * 1024 = 4096, so
  "uint32_t fqids[RTE_DPAA_MAX_RX_QUEUE]" is a 16 KB stack frame in
  dpaa_sec_dev_init().  Consider rte_malloc or splitting the two
  allocations.

  Switching the Rx FQs from QMAN_FQ_FLAG_DYNAMIC_FQID to a single
  qman_alloc_fqid_range(fqids, 4096, 0, 0) now requires 4096
  *contiguous* FQIDs at probe (8192 with two SEC devices).  That is a
  much stronger constraint than per-FQ dynamic allocation and can fail
  on a fragmented allocator.  It's a real boot-time win, but the
  contiguity requirement should be called out.

  dpaa_sec_uninit() calls qman_shutdown_fq() for all
  max_nb_queue_pairs and RTE_DPAA_MAX_RX_QUEUE entries regardless of
  whether dev_init got that far, so a partially-initialized device
  shuts down FQs with fqid 0.

Patch 24/25: drivers: add dpaax enter destructor to gate EAL memory frees

  kfree() becomes a statement expression "({ if ... else ...; })".
  Use do { } while (0) -- it is the idiom and avoids compilers that
  warn on a void-valued statement expression.

  is_dpaax_in_destructor() is an installed __rte_internal symbol with
  a generic is_* name, unlike its dpaax_enter_destructor() sibling.
  Rename to dpaax_is_in_destructor(). Both are declared in compat.h,
  a Linux-compat shim; dpaax_iova_table.h is the right home.

  The gate is process-global and one-way, so whichever destructor runs
  first (dpaa_cleanup 102, dpaa_finish 103, dpaa_mpool_finish 104)
  disables kfree() for all the rest.  That is presumably intended, but
  it makes the RTE_FINI_PRIO ordering load-bearing and converts a
  use-after-free into a deliberate exit-time leak.  Say so in the
  commit message.

Patch 25/25: doc: update release notes with NXP DPAA changes

  Missing entries for user-visible additions in this series:
  - the four experimental rte_pmd_dpaa_ol_* functions and the new
    installed header rte_pmd_dpaa_oldev.h (patch 22) -- new public API
    needs a release note
  - drv_sh_if_name (patch 17) and drv_bh_port (patch 22)
  - dpaa_dma_sg_disable / dpaa_dma_data_validation /
    dpaa_dma_pci_read_disable (patch 12)
  - the four new BMI Tx xstats (patch 08)
  - the FMCLESS Rx queue count default change (patch 16)

  The commit message lists qman_enqueue_multi_orp as a documented
  feature; it is __rte_internal and correctly absent from the .rst.
  Drop it from the message.

Info

Patch 17/25: dpaa_get_devargs_str() is forward-declared at the top of
  dpaa_ethdev.c rather than defined before use; moving the definition
  would be cleaner.  The devarg is re-parsed on every dev_configure().

Patch 19/25: the subject says "and fix bus detection" but the body and
  the diff are only the log-macro conversion plus moving
  DPAA_DEV_PATH1/2 to the top of the file -- where they now sit under
  the "we allow up to 4 push mode queues" comment, which belongs to
  DPAA_MAX_PUSH_MODE_QUEUE.  Seven DPAA_BUS_LOG() call sites remain
  (dpaa_bus.c 695/754/773, netcfg_layer.c 98/109/118/134).  Two
  continuation lines were left at their old alignment.

Patch 22/25: dpaa_oldev.c defines its own static rte_dpaa_probe() and
  rte_dpaa_remove(), duplicating the names in dpaa_ethdev.c and using
  the rte_ prefix on static functions.  Both are marked __rte_unused
  on dpaa_dev, which is used.  dpaa_poll_queue_default_config() is
  copied verbatim from dpaa_ethdev.c.  assert() is used without
  including <assert.h>.  DPAA_OL_* and DPA_ISC_WQ_ID are #defined
  mid-function.  fq_info is passed to an ioctl without a memset, so
  padding bytes are uninitialized stack.  "rxq == NULL" after
  "rxq = &dpaa_intf->rx_queues[queue_idx]" is dead -- test the array
  pointer instead.  The fd opened by check_fd() is never closed.

Patch 10/25: DPAA_PMD_INFO("MAC index of %s is %d") fires once per
  port entry per interface during FMC parse; DEBUG is the right level.

Consecutive blank lines: dpaa_oldev.c:114,
  rte_pmd_dpaa_oldev.h:8 and :47, dpaax_iova_table.c:37,
  dpaa_bus.c:739, dpaa_ethdev.c:2602.

No lines over 100 chars and no trailing whitespace in the series.
check-git-log flagged the Fixes: tag in patch 01, but that is an
artifact of my shallow clone -- the format is correct.
