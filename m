Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D913C5DF6D
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 16:29:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D45B840294;
	Sun, 16 Aug 2026 18:29:11 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 2A89140289
 for <dev@dpdk.org>; Sun, 16 Aug 2026 18:29:11 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so2061536a91.2
 for <dev@dpdk.org>; Sun, 16 Aug 2026 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786897750;
 x=1787502550; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E0MDs0ktKig+4qlrn+RA0Cgo3+Xn6QxidYSQWutj/FA=;
 b=rXhFiBxMGtVVmiPcD0UQwoMQsqIwEOJ5J5cJw4hLBP+imYFlkMPY2YIkD4nUKt+Vcj
 zyGf9Bdi3L/J/rkH/CHUFsHoOwSeHl7XafvdNhNXeVZ2OLOAxoP9LnRSHJUaewARjS02
 6OpuRmnGw7FXZJ3JQJhPqZ3k3gcyH7B+9rLpJEHfo0lHSzDFVk32jcdAiUk2/5Qag7n2
 rpHH2CQWmSCNhz742EEWAAiYV0QsmCLgTENmSvzbSnUgZqC0DcdTislStdIenfTDG20J
 PKG50pbFaH5cj9Y5rwdZFzrPy4gC52nVQJd3+q6CkCIu2NJbOXqjMOaP2t0fhaBEYqRX
 o3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786897750; x=1787502550;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E0MDs0ktKig+4qlrn+RA0Cgo3+Xn6QxidYSQWutj/FA=;
 b=r5TKYxmokt8LLSb7qT83m1Zaab06Cfe0EpjDR8Hvs5Li8HiBTl+dzFlDsDaTWoMg35
 3hr5RkejXCS9r/hVyk0jVuxVd9nmM7NIqFKdJmolpRLokyOby+K0t6o3cmclXwUrRF2A
 lAY0+QiJIZE2oGXxOMYUOC8wt0YaWqZIngKpkT2uJVXV0cPcd9gRScXv4kQlhOQv643g
 p6yCpQCYhuI5ajeh/GtAKqUo4O1Dh2D4xTGSQdfikYEqAjz1/+Ma4Mt2P7HT0LIiQRuM
 USifjB4zCiAirJ8QjCWeDr6SArHv/ugvHMpTIsL3TiFRLViGLCfmIFpD0LOiFLlfcH0T
 yl6Q==
X-Gm-Message-State: AOJu0YyDY8teWU3GFfh9Tkhvn0tEe0WHDn5BJ5Jr9Ojmx3Wjn0VsOBHY
 z7qNrm8TnL4UkKetbKq+j2xokzwqCfTdDNuVUdRoC1tk13xIZ85IlOKm5gJX3yrz/5yeaEA4wEr
 jBK3r
X-Gm-Gg: AR+sD10CAFhQRLI7T8hRStwijMrVkOLoJourdo/IxpVxYgruZcmRDmbzsQ1b47jOgDx
 C0WtBHyVcjjHcvuDK5SXOhQPRbM3fOg8Z0Xk8hCLk9o4f4UulVS5IIsE4D7nW+DVas6fV93aQe2
 9OnxaL5oB7RM1+h1R3E2W2oHCgCHBM8+c/35thi2WVhTftptYSn/CtC/KjeOQJPDUd0oioMYhVh
 pdCcS+P4W39Y7vSHeQfm/mSJaD26lx3a1btqsHkKBPDHQ0ke7NI0QghuNoNo9oJZGOFqr/gGC2j
 zN8QOmln96uiRdQj0FauexHUil9j5SOxD3xYHKfc6vvNrtlWLxbev0KFQ1xJBoUJO+Bwa2IOuME
 KDxMkZVnm3Mmx7kcTsFaiWm9VzZnIpIto245cNkOoLaUJca6VT1IPMcgiNK4w3lsWutkR2HEKd3
 VDK1dEIK+15Ln4sGHIV2ogbjND9TSvs12PihxlMfqoNBoYAaOX35AS9KiPOdIKqTDtMmcn2ER47
 jElJe3BzeHSp24TiFo0K1czqZbXHQ==
X-Received: by 2002:a17:90b:1650:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-3933b6f3882mr18707683a91.4.1786897749700; 
 Sun, 16 Aug 2026 09:29:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df2504sm27994212eec.17.2026.08.16.09.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 09:29:09 -0700 (PDT)
Date: Sun, 16 Aug 2026 09:29:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/13] driver/sxe2: fix bugs
Message-ID: <20260816092900.75e27213@phoenix.local>
In-Reply-To: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
References: <20260816025233.2727226-1-liujie5@linkdatatechnology.com>
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

On Sun, 16 Aug 2026 10:52:20 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Jie Liu (13):
>   net/sxe2: add Rx queue buffer split fill support
>   net/sxe2: update switchdev repr VSI ID display format
>   net/sxe2: add ACL engine event statistics support
>   net/sxe2: enhance device cap and res management
>   net/sxe2: improve representor device initialization
>   net/sxe2: refactor flow tunnel port handling
>   net/sxe2: validate IPsec key length against maximum limit
>   net/sxe2: enhance repr event handling and  MP code
>   net/sxe2: optimize vectorized Tx/Rx path
>   common/sxe2: allow munmap during kernel reset
>   net/sxe2: clean up duplicate function declarations
>   net/sxe2: clean up structure definitions
>   doc/sxe2: add acl-stat-type parameter documentation
> 
>  doc/guides/nics/sxe2.rst                   |  33 +--
>  drivers/common/sxe2/sxe2_common.c          |   5 +-
>  drivers/common/sxe2/sxe2_ioctl_chnl.c      |   8 +-
>  drivers/net/sxe2/sxe2_cmd_chnl.c           | 215 +++++++++++++++--
>  drivers/net/sxe2/sxe2_cmd_chnl.h           |  15 +-
>  drivers/net/sxe2/sxe2_drv_cmd.h            |  47 ++--
>  drivers/net/sxe2/sxe2_dump.c               |  10 +-
>  drivers/net/sxe2/sxe2_ethdev.c             | 203 +++++++++-------
>  drivers/net/sxe2/sxe2_ethdev.h             |  38 +--
>  drivers/net/sxe2/sxe2_ethdev_repr.c        |  13 +-
>  drivers/net/sxe2/sxe2_flow.c               | 259 +++++++++++++++++----
>  drivers/net/sxe2/sxe2_flow.h               |   6 +-
>  drivers/net/sxe2/sxe2_flow_define.h        |  13 +-
>  drivers/net/sxe2/sxe2_flow_parse_action.c  |  37 ++-
>  drivers/net/sxe2/sxe2_flow_parse_pattern.c | 113 ---------
>  drivers/net/sxe2/sxe2_flow_parse_pattern.h |   7 -
>  drivers/net/sxe2/sxe2_ipsec.c              |   5 +
>  drivers/net/sxe2/sxe2_irq.c                |  27 ++-
>  drivers/net/sxe2/sxe2_mac.c                |  10 +-
>  drivers/net/sxe2/sxe2_mp.c                 |  59 +++--
>  drivers/net/sxe2/sxe2_queue.c              |   2 +
>  drivers/net/sxe2/sxe2_queue.h              |   7 +-
>  drivers/net/sxe2/sxe2_rx.c                 |   5 +-
>  drivers/net/sxe2/sxe2_security.c           |   1 +
>  drivers/net/sxe2/sxe2_switchdev.c          |  12 +-
>  drivers/net/sxe2/sxe2_tx.c                 |  42 +++-
>  drivers/net/sxe2/sxe2_tx.h                 |   4 +
>  drivers/net/sxe2/sxe2_txrx.c               |  19 +-
>  drivers/net/sxe2/sxe2_txrx_poll.h          |   2 -
>  drivers/net/sxe2/sxe2_txrx_vec.c           |  77 +++---
>  drivers/net/sxe2/sxe2_txrx_vec.h           |   1 +
>  drivers/net/sxe2/sxe2_txrx_vec_avx2.c      |  10 +-
>  drivers/net/sxe2/sxe2_txrx_vec_avx512.c    | 123 +---------
>  drivers/net/sxe2/sxe2_txrx_vec_common.h    |   5 +-
>  drivers/net/sxe2/sxe2_txrx_vec_neon.c      | 215 +++++++++++------
>  drivers/net/sxe2/sxe2_txrx_vec_sse.c       |  10 +-
>  drivers/net/sxe2/sxe2_vsi.c                |   8 +-
>  37 files changed, 984 insertions(+), 682 deletions(-)
> 

The AI review identified that several of these are bugfixes but
no Fixes: given. Not a problem since sxe2 was introduced after
last stable release 25.11; therefore there is no need to backport.

Here is full AI review (I apologize for AI verbosity)

=====================================================================
sxe2 v2 review summary                                    13 patches
=====================================================================

STATUS OF v1 COMMENTS

Only three patches changed between v1 and v2:

  03/13   __le32/__le64 -> uint32_t/uint64_t in the two new ACL structs
  08/13   qstats-removal hunks (sxe2_mp.c/.h, sxe2_stats.c) dropped
  12/13   context churn only

Patches 01, 04, 05, 06, 07, 09, 10, 11, 13 are byte-identical to v1.
No v1 finding was addressed. The cover letter carries no changelog,
so there is no way to tell whether the comments were rejected or
missed.

Totals: 11 Errors, 14 Warnings across 9 of 13 patches.
Clean: 02/13, 05/13, 10/13, 11/13.

---------------------------------------------------------------------
SERIES-LEVEL
---------------------------------------------------------------------

Warning  Nine of thirteen patches mix unrelated changes under a
         subject describing only one of them. Patch 09 is ~1100
         lines spanning six independent changes. One logical change
         per patch.

Warning  Cover letter has no "v2:" changelog section.

---------------------------------------------------------------------
ERRORS
---------------------------------------------------------------------

09/13  Tx vector buffer ring written at 8-byte stride, read at
       16-byte stride. sxe2_tx_buffer is 16 bytes, sxe2_tx_buffer_vec
       is 8, and they alias through a union. The patch converts the
       fill and release paths to buffer_ring_vec but leaves
       sxe2_tx_bufs_free_vec() on buffer_ring. That function is the
       Tx completion path for all four vector bursts (sse, avx2,
       avx512, neon), so buffer[i] resolves to vec slot 2*i: half the
       transmitted mbufs leak, the other half are freed twice.

09/13  NULL checks removed from sxe2_tx_queue_mbufs_release_vec().
       rte_pktmbuf_free_seg() dereferences m->refcnt with no NULL
       test, and queue_reset zeroes the whole ring.

06/13  New PF_BOND block in sxe2_flow_src_split_proc() is immediately
       overwritten -- the two pre-existing unconditional assignments
       to flow_src_vsi[*][0] were not removed. Member 0 is clobbered
       and the else branch is dead.

06/13  adapter->bond_member_cnt is declared but never assigned. On a
       PF_BOND device flow_bond_num is 0, every subsequent loop runs
       zero times, and flow creation always fails with -EINVAL.

04/13  Error-unwind regression in sxe2_dev_init(): init_rss_err: now
       sits below sxe2_security_uinit(), so an sxe2_rss_disable()
       failure leaks the security context. Pre-patch it sat above.
                                                                 [v1]

04/13  sxe2_buffer_split_supported_hdr_ptypes_get() sets
       *no_of_elements = RTE_DIM(ptypes) while the array still ends
       in an RTE_PTYPE_UNKNOWN sentinel. Callers get a bogus entry
       and an inflated count. Compare ice, whose array has no
       terminator.                                               [v1]

03/13  Stale count-manager pointer causes double free. mgr is
       declared once outside the TAILQ_FOREACH_SAFE loop in
       sxe2_flow_rte_list_free() and never reset; query_mgr writes
       *mgr_ptr only on success, but free_mgr is called regardless.
       Iteration N operates on the mgr freed in N-1.              [v1]

03/13  sxe2_flow_free_mgr() falls through to rte_free(mgr) without
       TAILQ_REMOVE when engine_type is neither ACL nor FNAV,
       leaving a freed node on the list.                          [v1]

12/13  sizeof(struct sxe2_tm_res) drops 4 -> 2. The struct is an
       ioctl payload passed with sizeof() as req_len/resp_len from
       four sites in sxe2_cmd_chnl.c. This is a driver/firmware ABI
       change, not a cleanup. (The other six structs in this patch
       are size-neutral -- I checked each.)

07/13  The added key-length check is unreachable: an identical
       "src_key > SXE2_IPSEC_MAX_KEY_LEN" test already exists at the
       top of sxe2_security_valid_key() on upstream.

13/13  Deletes the entire drv-sw-stats documentation section as a
       side effect of adding acl-stat-type. Nothing in this series
       removes that devarg, so docs and code now disagree.

---------------------------------------------------------------------
WARNINGS
---------------------------------------------------------------------

08/13  Blocking firmware commands added to the interrupt handler.
       sxe2_event_irq_common_handler() now loops over every VF
       representor calling sxe2_drv_mac_link_status_get(), which
       reaches pthread_mutex_lock() + blocking ioctl(). One LSC
       interrupt costs 1+N serialized kernel round-trips on the EAL
       interrupt thread.

08/13  vf_id is uint8_t; nb_repr_vf is uint16_t bounded only by
       RTE_MAX_ETHPORTS. Loop never terminates if that exceeds 255.

08/13  Commit message still lists the qstats changes that were
       dropped in v2.

09/13  sxe2_tx_queues_vec_prepare() now calls queue_reset(), which
       zeroes the buffer ring without freeing what it holds. Confirm
       this only runs before first start.

06/13  flow_bond_num is uint8_t, bond_member_cnt is uint16_t, and
       neither is clamped to SXE2_MAX_BOND_MEMBER_CNT (4). Overruns
       flow_src_vsi[][4] on the stack once the field is populated.

06/13  The RSS key_len/queue_num validation fix (adding the missing
       goto l_end) is unrelated to tunnel port handling. Separate
       patch.

07/13  dev->security_ctx = NULL is the only substantive change in
       this patch and is unrelated to its subject. Separate patch
       with a matching subject.

04/13  Duplicate sxe2_switchdev_uninit() and duplicate
       sxe2_dev_pci_map_uinit() removed from sxe2_dev_close(). These
       are double-free fixes unrelated to cap/res management.
       Separate patch.                                           [v1]

03/13  SXE2_PCI_DEVICE_ID_VF_1 0x10b -> 0x10b2 is an unrelated fix
       in an ACL-statistics patch.                               [v1]

03/13  rxq->fnav_enable assignment in sxe2_queues_init() is also
       unrelated to this patch's subject.                        [v1]

03/13  acl-stat-type devarg added here, documented in 13/13. Code
       and docs must land together.                              [v1]

01/13  Subject describes buffer split, but the patch also drops a
       debug log, adds a sxe2_link_update() call, fixes an error
       path in sxe2_drv_udp_tunnel_get(), and rewords a dozen log
       messages. The udp_tunnel_get change is a real fix that wants
       its own patch.                                            [v1]

---------------------------------------------------------------------
INFO
---------------------------------------------------------------------

09/13  NEON DD-count rewrite (popcount -> rte_ctz64(stat)/16) is a
       real fix -- the old popcount counted DD bits past a gap.
       Deserves its own patch.

08/13  Patch 01 adds sxe2_link_update() inside
       sxe2_drv_mac_link_status_get(); this patch removes the now-
       redundant call from sxe2_link_update_init(). Two halves of
       one change split seven patches apart.

03/13  Trailing else in sxe2_flow_query_mgr() is dead -- the
       if/else-if/else at the top already handles it.            [v1]

03/13  sxe2_flow_cid_mgr.stat_index is uint16_t but the FW returns
       uint32_t; the assignment truncates.                       [v1]

04/13  dev_info->nb_rx_queues / nb_tx_queues are dead stores;
       rte_eth_dev_info_get() overwrites both after the PMD op
       returns.                                                  [v1]

04/13  Redundant NULL test on addr_info after the new bounds check;
       port_idx initialized to UINT16_MAX then unconditionally
       overwritten; sxe2_dev_infos_get() returns directly where the
       file uses goto l_end.                                     [v1]

01/13  sxe2_rxq_buf_split_fill() re-tests the BUFFER_SPLIT offload
       the caller already tested, making its else branch dead. [v1]

