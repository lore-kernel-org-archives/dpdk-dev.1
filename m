Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF06C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 15:40:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02415406B8;
	Tue, 11 Aug 2026 17:40:04 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id D4D7B4027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 17:40:02 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso2171509a12.2
 for <dev@dpdk.org>; Tue, 11 Aug 2026 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786462802;
 x=1787067602; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pOFq3SRdiLZ4UtKK8vg6OD3Nw0/IY4Zi422p1Rie9xE=;
 b=j6yuiiavhw7tLvyNVbDz9rtfAFnVPXLz3Ay0+p2MfyBff79j+M3MpbxH6neZzu927x
 AWTZjdbf1BRGWpqP0o2MptfDAfo1nV9dvHIvw//VQgkZsUC2VHDDRwyezvjOFCWbcPml
 VwQXJRFelKHnmCpy1Ul48xGn6zfMuOPE2w/kARN9nHeufa2me8kIEU+1x7vU6O8l0Ifi
 mLZntPcs0KMl5qZeeiEB8AQKeL2MgJckcxgfRqiE0hRmPDjbW50lQkRTuqORJJ78Z3J7
 kH+YysIcLccp8SN0nvmQy89bB5wpjTHkuB5m6LRs1LGxCPNBpbWjHWPFgWTE9ZyEmTXo
 uzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786462802; x=1787067602;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pOFq3SRdiLZ4UtKK8vg6OD3Nw0/IY4Zi422p1Rie9xE=;
 b=dZt8N9yqS2x5V79c7EdGErDCE5SaEqNADFjh8e1tI2xFQtSFhlJjMDpsfUfC3apU4Q
 dG7ZK5O4ujVtTZBni1Ytun3+xW/6Rw375uPYb56XXyEhoNb96WqgKm5Id1EwyvS4YAr8
 ybsQurO4iimLu9mr88+HwAS/OmeSmMZISdmMEV3rC9nVSDG1kIXb5HNGI/siIHYrFFLo
 +5ixRjeDku6oisN7OGC5Gcmo4AT/I1t8Jx2nqTe8QfF+DH1q1NWtuRA3JTQCs04tD6BH
 G90Jq5DCgBT5eVr88bzB+lfnDaYlSZlmbh4mIgHu04aUu/1rwg8i+qg06kxZtTICWSLH
 LBNA==
X-Gm-Message-State: AOJu0YwH9ShCspw4xtu2AJpVjKTazgxO94ghiVO4gladZNOfQl+jD2nC
 svaaZImAReoAWYqKTEqbLYAdVAh5KEWGNR1titCveoz0ObDJJkElOvICNhiApiDEBSA=
X-Gm-Gg: AR+sD139kvPN2Q4+AywY7jvdNxr/ePGMS0DfvWcT4CU2OFEPJIxa2arcBdfPp3J75jg
 Ps1xQQ5MjT5yrx5lljs22RobGlvyZYBd3RPOWtPy6qgD2RVsEKe/RR/bj5FNNlin9Ja2mKUTB69
 mk73FeBIwStZYWpnscLOTj19Q0c0Ilmdn5ccJdIzo4zhf7xUsLaEptAljOv63beAirb4Pk/N4NW
 TtOiLGfZuhti3c/nW7Jk6SSbixWCu4QTaJK4VZOFb6WqmZOU97Xf3gXd07MOKlb225+A4odLi7F
 hV3oZ4z81AFPphYPJD/hab/0137VbZoWqovqqZ4KoZc92PZv3vJSw8eo0Hyi0HhqsM+d04FYHaP
 GCU/mr0JE1ZLAivX6yuj/1dGPwryk2ir24Hml14QMwi6m8zB6qsTvcAWb2IBOmUv0GvAxqKCk8m
 q+cT/+2YKIU/puspxavXW0lyZOifJHthUOkIw3lKCOWmF+U5ux57+3ppvL08cK/kib1BlsJY1oV
 NCM4Bb2eh0WrGdjK6yQHhNdbLA/rw==
X-Received: by 2002:a05:6a21:460e:b0:3c3:8315:80b7 with SMTP id
 adf61e73a8af0-3cc2b94a7c5mr6205837637.9.1786462801603; 
 Tue, 11 Aug 2026 08:40:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141245540fesm881399c88.9.2026.08.11.08.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:40:01 -0700 (PDT)
Date: Tue, 11 Aug 2026 08:39:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v7 00/14] net/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260811083958.1e65877d@phoenix.local>
In-Reply-To: <20260811074745.3655334-1-g.singh@nxp.com>
References: <20260811074032.3646324-1-g.singh@nxp.com>
 <20260811074745.3655334-1-g.singh@nxp.com>
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

On Tue, 11 Aug 2026 13:17:31 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V7-changes:
>  - added missing 14th patch.
> 
> V6-changes:
>  - fixed free() on memory allocated with rte_zmalloc().
>  - fixed eventfd and vector-list leak on interrupt teardown
>  - fixed Rx ring doubling still bypasses
>  - fixed VSI-PSI transaction issued from the interrupt handler
>  - fixed the free-and-reallocate of msg is unnecessary churn
>  - fixed unsynchronized access to tx_pause_active and RBMR
>  - fixed signed shift overflow in the register-dump version field
>  - fixed the fw_size == 0 early return reports the length of "0.0"
>  - unwanted blank lines removed.
>  - parse_txq_prior() returns updated.
> 
> V5-changes:
>  - Patch 1 Build fixes which includes:
>     'prev_seg' undeclared fixed.
>     redefinition of 'dev_rx_offloads_sup' fixed.
>     Error: duplicate rx_enable declaration fixed.
>    PF loses Scattered Rx and Multi-segment Tx
>  - mbuf leak in enetc_xmit_pkts_lso() fixed.
>  - fixed conversion on ENETC4_TXBD_FLAGS_F issue.
>  - fixed link speed decode has no upper bound.
>  - fixed mailbox ops added to the no-VSI ops table.
>  - new devargs documented.
> 
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
>  drivers/net/enetc/base/enetc4_hw.h     | 128 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 136 ++++-
>  drivers/net/enetc/enetc4_ethdev.c      | 428 +++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 807 ++++++++++++++++++++++---
>  drivers/net/enetc/enetc_rxtx.c         | 530 +++++++++++++++-
>  9 files changed, 2011 insertions(+), 153 deletions(-)
> 

Still lots of issues found by AI review

ENETC4 v7 series review - 14 patches

No Reviewed-by; one error and two warnings remain.

All 14 commits build clean individually on top of c1a46b9 with gcc 13.3
and -Dwerror=true. check-git-log.sh: 14/14 valid. No trailing
whitespace. Consecutive-blank-line counts are back to the upstream
values in all four touched files.

Confirmed fixed from v5: the free()/rte_free() mismatch is gone --
enetc4_dev_uninit() no longer touches txq_prior at all and both arrays
are released in enetc4_dev_close(); rte_intr_vec_list_free() and
rte_intr_efd_disable() added at the intr_enable_fail: label so both the
teardown and the error path are covered; enetc4_alloc_rxbdr() now
validates ring_desc against MAX_BD_COUNT the same way the Tx side does;
tx_pause_active is RTE_ATOMIC with acquire/release accessors; the
register-dump version field is cast before the shift in both
enetc4_get_regs() and enetc4_vf_get_regs(); fw_version_get() computes
the fw_size == 0 length from the real values; release note reads "Tx
PAUSE ... Rx congestion mode"; parse_txq_prior() and parse_txq_wrr()
both return -ENOMEM consistently.

Patch 08

Error: pthread mutex in shared memory without PTHREAD_PROCESS_SHARED.

The new vsi_lock lives in struct enetc_eth_hw, which sits in
eth_dev->data->dev_private. ethdev allocates that with
rte_zmalloc_socket(), so it is hugepage memory visible to secondary
processes:

drivers/net/enetc/enetc.h:145
pthread_mutex_t vsi_lock; /* serializes all VSI-PSI mailbox ... */

drivers/net/enetc/enetc4_vf.c:1985
pthread_mutex_init(&hw->vsi_lock, NULL);

Two problems follow. A mutex initialized with NULL attributes is
undefined behaviour if it is ever locked from a second process. And
enetc4_vf_dev_init() has no primary-process guard -- enetc4_dev_close()
is the only place in the driver that checks rte_eal_process_type() --
so a secondary attaching to the same VF re-runs pthread_mutex_init() on
a mutex the primary may be holding.

pthread_mutexattr_t attr;

pthread_mutexattr_init(&attr);
pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
pthread_mutex_init(&hw->vsi_lock, &attr);
pthread_mutexattr_destroy(&attr);

rte_spinlock_t would sidestep the initialization problem but is the
wrong primitive here, since the poll loop under the lock waits up to
vsi_timeout iterations.

Warning: the reply status is still read outside the lock.

enetc4_msg_vsi_send() now holds vsi_lock across the write, the MB poll
and the completion-status check, which closes most of the window. But
every caller re-reads ENETC4_VSIMSGSR after the function has returned
and dropped the lock:

err = enetc4_msg_vsi_send(hw, msg);
if (err) {
ENETC_PMD_ERR("VSI message send error");
goto end;
}

enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg); /* lock released */

Six call sites go through enetc4_msg_vsi_reply_msg() (lines 727, 973,
1019, 1404, 1504, 1637) and enetc4_vf_get_ip_minor_revision() reads the
register directly at line 1081. A second thread -- in particular the
interrupt thread doing the patch 08 speed re-query -- can take the lock
and start a new transaction between the unlock and that read, so the
caller parses someone else's reply.

enetc4_msg_vsi_send() already has the value in its local vsimsgsr.
Returning it through an out-parameter, and having callers parse from
that instead of re-reading the register, removes the window entirely.

Patch 13

Warning: RBMR read-modify-write still races between threads.

The atomic on tx_pause_active covers the flag but not the register.
enetc4_vf_set_congestion_mode() runs on the interrupt thread:

rbmr = enetc4_rxbdr_rd(enetc_hw, i, ENETC_RBMR);
if (enable)
rbmr |= ENETC_RBMR_CM;
else
rbmr &= ~(uint32_t)ENETC_RBMR_CM;
enetc4_rxbdr_wr(enetc_hw, i, ENETC_RBMR, rbmr);

enetc4_rx_queue_start() and enetc4_rx_queue_stop() perform the same
unguarded read-modify-write on ENETC_RBMR_EN from the control thread.
A link-status interrupt landing mid-sequence still loses one of the two
updates, leaving a ring enabled without congestion mode or stopped with
it set. Serializing the RBMR accesses -- vsi_lock would do, or a
dedicated per-device lock -- is what is missing.

Info: the release store on tx_pause_active is placed before the RBMR
writes it is described as publishing, so the ordering does not do what
the comment implies. Nothing else is published through this flag, so
rte_memory_order_relaxed on both sides would be correct and clearer.

Patch 06

Info: enetc4_txbdr_regs[] and enetc4_rxbdr_regs[] are still static const
arrays defined in enetc.h, so every translation unit including the
header gets a private copy. Moving them into one .c file with an extern
declaration avoids the duplication.
