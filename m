Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C9C5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 15:40:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B09B40272;
	Mon, 10 Aug 2026 17:40:44 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id AC46340144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 17:40:43 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso2085732a91.3
 for <dev@dpdk.org>; Mon, 10 Aug 2026 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786376443;
 x=1786981243; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VL2xuGqmJ9UMw9FTvDcZLhbmkFe1LZjbhT9/nHjZKS8=;
 b=F2uB9NKK01smZbHrEPMeT5HFccAl6k5n1VY3L7b6/Fg5YrscYWgLWb7+AOgWJ9pAOY
 aMVQtXChjWSOoeN1vCm7NR5SvXxZYzAF99UznfiKDqorMKcIx0Yr0ZCp9hThhfN2zAOt
 3H/Xlqdyl5AmIFl1drrJvTpPWmpLX12/uIM+jbjJn7oZ68eX1i3HqKrO5jfT2yN958r4
 Oumku1oV+jDGWWhsfwGT0K+49Z6vhV4A21A4mv4SZyge9rqxpx1EtxG4MYHvQQgnuQjY
 oTC31vl7U+Bur5ESBd6GJX8l2czarZUtDDQT2nmU9YtyBXyf5dKDtR9alWkDvlPXKU5o
 gmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786376443; x=1786981243;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VL2xuGqmJ9UMw9FTvDcZLhbmkFe1LZjbhT9/nHjZKS8=;
 b=onuku8Znq4jgdnOXRJFm04Iq/ORNvKxE3DBKhif8qFkbgbK4G6bekMfoqn0Fh2px3V
 lN+Cd3WAlgu+s0n2PZY+vtWB02F9T5kUVlf1IDD1ijUhHJDUbZdyW0+fLD1HXSL7zEuk
 qa/9XFlcvey3Fn7dzcflVRI6gOhmtGj3dx+Fi/oSgFGInjYoWGY0jvsCM0O0BMELT4P2
 IwTz8AN7MK9BuCzRDmd6vNXfnrvg14jGDeWk10LmV8ncU0aRZ9fXdFmERoSsL+WbEhA/
 uNyYiE0Npr3pksAqsxSh+XRV4KFZ9eZK+VU0UlWHN1+xDQpmm+VYIYgzAYM0D5O0hRIr
 HLyw==
X-Gm-Message-State: AOJu0YweGYSkN3Khj4/SBCE0c4zibyWnJ2wgRS5sXvnkNSryu8yZA1rM
 WEZo/HPvtYsQa6eLUf6Es0fqV0Wkr5mFVlLPY/q4Vs8qoW4EJOzr6QCESeSql58GF78=
X-Gm-Gg: AR+sD13xCfwzKkc78BjFZQPe4hrBDhDvExRR2/vydky8Zthf+oNyLZw5gxwa00cKHQk
 0TKL34NY/bCk5jR7OHOaRxqu9F8McagzwGJcuaDiQwSWY+DADbXCzS+cH43zKGrBujyHih95wzp
 P+Ia08EPNuevC6W2eXbV5blltq5VsMSBHSxKSjJTEkOdNYJkhGPclXgVNbm9q3j9DDK1+5BL5nn
 eeOfiJBbgy/DwsFwImufhWlGRBj4GNMHbqtR9Ggod1qnaTn0pnoKot8dIeEudS9mqa0SZMtN854
 HvYnAckm78Sm9ZgoxUOjn9g05L1Qgu4rZgXk5tHqM/yFJfBtegXNNLxYSMG4uzkZKzr9YrWz6eL
 lMUoKOZfbqmmxWmXEwuSvjry4DfPpgp0mjJnQeLK1i8exIchqpLrxEMx1k6r+k6Sq8I7N/GQD+h
 CIBc+iSuzWTf9ymCcsdDedQGlN2sTTiQrjOtwVdXe2GwUTW2Z0lmSstyxUe0eZLdLdWPfcbHy2m
 cyiPNC8mx7sAfgMW3qy6qAVfmKcvYYiWK7ZnLv7ng==
X-Received: by 2002:a17:90b:2788:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-39262309a8bmr26129166a91.20.1786376442588; 
 Mon, 10 Aug 2026 08:40:42 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec2ec20sm52617671eec.28.2026.08.10.08.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:40:42 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:40:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v5 00/14] net/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260810084038.6b574d7f@phoenix.local>
In-Reply-To: <20260810104815.2827703-1-g.singh@nxp.com>
References: <20260807112623.1402493-1-g.singh@nxp.com>
 <20260810104815.2827703-1-g.singh@nxp.com>
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

On Mon, 10 Aug 2026 16:18:01 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V4-changes:
>  - fix doc build issue: WARNING: undefined label: pmd_build_and_test
> 
> v3-changes:
>  - fix doc build issue.
>  - fix compilation issue on fedore:43-gcc-minsize
> 
> V2-changes:
>  - compilation fixes.
> 
> V1-changes:
> This series adds new PMD features to the ENETC4 driver targeting the
> NXP i.MX95 NETC IP.
> 
> The series covers:
> 
>  - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer.
>  - TSO: TCP Segmentation Offload for the VF Tx path.
>  - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
>  - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
>    8-bit to support speeds beyond 10G.
>  - Firmware version: report the NETC IP version via fw_version_get.
>  - Register dump: dump SI, port (PF) and BD ring registers.
>  - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
>  - Link-up interrupt: refresh the cached link speed on each VF link-up
>    interrupt so that link_update returns the current speed immediately.
>  - Stats reset: software snapshot/delta approach for VF counter reset.
>  - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
>    enabling interrupt-driven receive with l3fwd-power.
>  - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
>  - VF link status bitmask: switch VF link status to bitmask encoding
>    to align with the PF and newer kernel driver conventions.
>  - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
>    negotiated on the wire; adds Flow control = Y to enetc4.ini.
>  - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.
> 
> Gagandeep Singh (14):
>   net/enetc: add keep-CRC Rx offload for ENETC4
>   net/enetc: add TSO support for ENETC4 VF
>   net/enetc: add RSC (hardware LRO) support for ENETC4
>   net/enetc: extend PF-VF link speed field to 8 bits
>   net/enetc: support firmware version get for VF
>   net/enetc: support registers dump
>   net/enetc: support ethtool ring parameters
>   net/enetc: refresh link speed on VF link-up interrupt
>   net/enetc: support stats reset for VF
>   net/enetc4: add per-queue Rx interrupt support for VF
>   net/enetc4: add SI-based port VLAN insertion and removal
>   net/enetc4: update VF link status to bitmask encoding
>   net/enetc4: enable Tx PAUSE via VF Rx congestion mode
>   net/enetc4: add WRR Tx scheduler devarg for VF rings
> 
>  doc/guides/nics/enetc4.rst             | 100 +++
>  doc/guides/nics/features/enetc4.ini    |   8 +
>  doc/guides/rel_notes/release_26_11.rst |  21 +
>  drivers/net/enetc/base/enetc4_hw.h     | 129 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 134 ++++-
>  drivers/net/enetc/enetc4_ethdev.c      | 413 +++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 801 ++++++++++++++++++++++---
>  drivers/net/enetc/enetc_rxtx.c         | 531 +++++++++++++++-
>  9 files changed, 1998 insertions(+), 145 deletions(-)
> 

More AI review feedback.
ENETC4 v5 series review - 14 patches

No Reviewed-by; two errors remain.

Build status is now correct.  All 14 commits build clean individually
on top of c1a46b9 with gcc 13.3 and -Dwerror=true:

  [0] d657b18 01/14 add keep-CRC Rx offload for ENETC4
  [0] 410e8f0 02/14 add TSO support for ENETC4 VF
  [0] 1dc5e61 03/14 add RSC (hardware LRO) support for ENETC4
  [0] 3dc3726 04/14 extend PF-VF link speed field to 8 bits
  [0] e1ba634 05/14 support firmware version get for VF
  [0] f3772c4 06/14 support registers dump
  [0] 4c51974 07/14 support ethtool ring parameters
  [0] 663e4ac 08/14 refresh link speed on VF link-up interrupt
  [0] d9c0dfa 09/14 support stats reset for VF
  [0] 3b7ef0c 10/14 add per-queue Rx interrupt support for VF
  [0] 131a052 11/14 add SI-based port VLAN insertion and removal
  [0] ea47dc2 12/14 update VF link status to bitmask encoding
  [0] ffaa8a6 13/14 enable Tx PAUSE via VF Rx congestion mode
  [0] 57ac69c 14/14 add WRR Tx scheduler devarg for VF rings

check-git-log.sh: 14/14 valid patches.  No trailing whitespace.

Confirmed fixed from v4: prev_seg declaration moved to patch 01; the
duplicate offload arrays and duplicate rx_enable removed at the point
of introduction; SCATTER and MULTI_SEGS restored to the PF capability
lists; both LSO validation paths now free the mbuf before start++; the
rte_cpu_to_le_16() on the uint8_t flags field dropped; Tx ring doubling
validated post-multiply; mailbox-dependent ops removed from the no-VSI
table; link speed decode bounded to defined RTE_ETH_SPEED_NUM_* values;
duplicate rte_kvargs.h include removed; RSC now explicitly rejects nc=1
rather than silently overriding the burst selection; vf_link_legacy and
enetc4_txq_wrr documented, and the release note calls out the 6.18.37
PF requirement.

This round I read patches 05-14 in full, which I had deferred.


Patch 14

Error: free() on memory allocated with rte_zmalloc().

parse_txq_prior() was converted from calloc() to rte_zmalloc(), and
enetc4_dev_close() was updated to rte_free().  enetc4_dev_uninit() was
not:

  static int
  enetc4_dev_uninit(struct rte_eth_dev *eth_dev)
  {
        ...
        if (hw->txq_prior) {
                free(hw->txq_prior);        /* rte_zmalloc'd */
                hw->txq_prior = NULL;
        }

        return enetc4_dev_close(eth_dev);
  }

uninit runs before close, so on any port using enetc4_txq_prior the
pointer is still non-NULL here and libc free() is handed a pointer from
the DPDK heap.  txq_wrr is not freed on this path at all.  Both
allocations are already released correctly in enetc4_dev_close(), so
the simplest fix is to delete the block from enetc4_dev_uninit().


Patch 10

Error: eventfd and vector-list leak on interrupt teardown.

enetc4_vf_dev_intr(dev, true) calls rte_intr_efd_enable() and
rte_intr_vec_list_alloc().  The disable path clears rxq_intr_en, calls
rte_intr_disable() and unregisters the callback, but never calls
rte_intr_efd_disable() or rte_intr_vec_list_free().  The eventfds and
the vector list survive dev_close, and a subsequent configure/close
cycle allocates a new set each time.

The intr_enable_fail: label has the same gap: if rte_intr_enable()
fails after efd_enable() succeeded, both resources are dropped.

  disable:
        enetc_vf_enable_mr_int(enetc_hw, false);
        hw->rxq_intr_en = 0;
  +     rte_intr_vec_list_free(intr_handle);
  +     rte_intr_efd_disable(intr_handle);
        ret = rte_intr_disable(intr_handle);


Patch 03

Warning: Rx ring doubling still bypasses MAX_BD_COUNT.

The Tx side now validates after the multiply, but enetc4_alloc_rxbdr()
does not:

  ring_desc = rxr->rsc_enable ? (uint32_t)nb_desc * 2 : (uint32_t)nb_desc;

  size = ring_desc * sizeof(struct enetc_swbd);

The only bound is nb_rx_desc > MAX_BD_COUNT in enetc4_rx_queue_setup(),
checked before the doubling, so an RSC ring can reach 128000 entries.
ENETC_RTBLENR_LEN(n) is ((n) & ~0x7) with no upper clamp.  Mirror the
check that enetc4_alloc_txbdr() already has.


Patch 08

Warning: VSI-PSI transaction issued from the interrupt handler.

enetc4_process_psi_msg() runs from enetc4_dev_interrupt_handler(), and
now issues a fresh mailbox round trip:

        rte_free(msg);
        msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
        if (msg) {
                if (!enetc4_vf_get_link_speed(eth_dev, msg) && ...

There are eleven enetc4_msg_vsi_send() call sites and no lock anywhere
in the file.  Until this patch every one of them ran on the control
thread, so they were serialized by convention.  This is the first that
runs on the interrupt thread, so it can interleave with a concurrent
mac_addr_set, vlan_pvid_set, mtu_set or link_update: both writers touch
VSIMSGSNDAR/VSIMSGSR and one consumes the other's reply.

A mutex around the send/poll sequence in enetc4_msg_vsi_send() would
cover all callers at once.  Note it would need to be a sleeping lock,
not rte_spinlock_t, since the poll loop waits up to vsi_timeout.

Info: the free-and-reallocate of msg is unnecessary churn; memset of
the existing buffer would do, and would remove the NULL branch.


Patch 13

Warning: unsynchronized access to tx_pause_active and RBMR.

hw->tx_pause_active is written by enetc4_vf_set_congestion_mode() on
the interrupt thread and read by enetc4_rx_queue_setup() and
enetc4_rx_queue_start() on the control thread as a plain uint8_t.  Use
rte_atomic_store_explicit()/rte_atomic_load_explicit() with
rte_memory_order_release/acquire; relaxed is not enough here because
the flag publishes the RBMR writes that precede it.

The RBMR read-modify-write is the larger half of the same problem:

        rbmr = enetc4_rxbdr_rd(enetc_hw, i, ENETC_RBMR);
        if (enable)
                rbmr |= ENETC_RBMR_CM;
        ...
        enetc4_rxbdr_wr(enetc_hw, i, ENETC_RBMR, rbmr);

enetc4_rx_queue_start() and _stop() perform the same read-modify-write
on ENETC_RBMR_EN from the control thread.  A link-status interrupt
arriving mid-sequence can lose either update, leaving a ring enabled
without congestion mode or disabled with it.


Patch 06

Warning: signed shift overflow in the register-dump version field.

  regs->version = hw->device_id << 16 | hw->revision_id;

device_id is uint16_t, so it promotes to int before the shift.  Both
ENETC4_DEV_ID (0xe101) and ENETC4_DEV_ID_VF (0xef00) have bit 15 set,
so the shift result is not representable in int -- undefined behaviour,
and UBSan will flag it.  The same line appears in both
enetc4_get_regs() and enetc4_vf_get_regs().

  regs->version = (uint32_t)hw->device_id << 16 | hw->revision_id;

Info: enetc4_txbdr_regs[] and enetc4_rxbdr_regs[] are static const
arrays defined in enetc.h, so every translation unit that includes the
header gets its own copy.  Moving them to one .c file with an extern
declaration, or making them macros, avoids the duplication.


Patch 05

Info: the fw_size == 0 early return reports the length of "0.0" rather
than of the real version string, since ip_mj and ip_mn are still zero
at that point.  Callers using the query-then-allocate idiom get a
buffer that is too small, though the second call returns the correct
size so it does self-correct.


Series-wide

Info: four new consecutive-blank-line pairs -- enetc.h:464,
enetc4_ethdev.c:36 and :164, enetc_rxtx.c:1144.

Info: the release note entry uses "TX PAUSE" and "RX congestion mode";
the commit subjects were corrected to Tx/Rx in this revision but the
note was not.

Info: parse_txq_prior() returns -1 for strdup failure but -ENOMEM for
the rte_zmalloc failure; parse_txq_wrr() returns -1 for both.  Worth
making consistent.
