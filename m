Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8464CC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 17:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59E52427BA;
	Thu, 10 Sep 2026 19:45:08 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id C668840274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 19:45:06 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso94948a12.3
 for <dev@dpdk.org>; Thu, 10 Sep 2026 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789062305;
 x=1789667105; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XdVcRwaiCg3ilOv0A4vRKuGWlgvHXHoUHwco588BOlY=;
 b=ZTvWcMbpZ0fXviKrJhGgX8Ywbmt4eeaA1gBXxU401i34jI2+9Nmu5FCsdlfBIS7pX6
 GQ8RmztVtUJoZxeeQ+SxWoHA3vcgQxwMupFoM83Q2ACkHpO2dPT8tO87txBcSrGdxpoS
 1J5VCxDwQyGYkgoBzmEiH4OsWxecPP9l/g6H0Z/UZ+kL26lxM4SpL1us5NgrWrZ5M5FI
 bMjeqxq1Xu4yznJ+4XcpuzcDFOnZAn0Ri1UNYUu1N5KIysv3yZoMDqyJQuEpybYcTCkL
 4OLw9CHP7Te46aArtQDP5Qiw8Lh9yGf5I0012vLgTtYa4geeA0fqwhaufW19DWfAKr6w
 q3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789062305; x=1789667105;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XdVcRwaiCg3ilOv0A4vRKuGWlgvHXHoUHwco588BOlY=;
 b=mGzUNa8BPHjif+a8GCPtN++ncXCvbEXVJDL59vWpZyzke9DAjKemKbJvjgHkeoHdbb
 R3DhPGtHNjj3w2FkvqxHevG/y06x23jAgtxmd7wCgnUoLYnChbt/oUsaZbtucpD4YvR3
 pdf6UUThsWM7MXxWJZtQhVn0o7FPVN33m6NvtnwmOw75Ivx+nDFslQXkMT++K5DnDrZM
 ZCuy3/JhspDZb8XpRa0o4D005vOXzg6dW6kF0lJ6+mFuRH4pSaLiAblspsXeuyaIUvek
 5cNyeFHYUg4H2rVaHOmcUvDgLDSiMhcw/4GtbcXnrhRRFB1KJPHvv3v968/ZCGyttuZz
 iFrw==
X-Gm-Message-State: AFuF++nrSk9iuurlgMv5dyKOfcNNxSe3bzvD0dyBWfKnxEwTDEhJHRwJ
 Cb27a2C7fA4zdbqgMWtRassIkZYKOYFcsDPuOAPf/OAgOYGMaEqANWMGRQwdMmxFN8M=
X-Gm-Gg: AYBFou2AMsmNHqFA94HHrx/uUV8Uw6zg4EORb6Cn5hv1DPGdLN5ZIf+iOtNRJDSTymw
 +OsCCbHCllYh0TYfbkJQtIKOjhOIkt24gdobNT97Js5k4ZuPlspazBopoYgvvERRoGz6zjbGJvY
 sEBk67XwNTQQi4hj+VubmEI4KDEm+xtUvZIcLKV46jfpqtvWZ6Dpd92aKREPcafPwm0cYXVteaW
 jKLqEHkxRsaxTRaLcdz/c5D/7KnTUP3lFra8AGj2I0dGAgGV9bIVSa3KpfEQpiyw2DCIxBhbLvC
 4MfctgewY3eNLb689C52saucYznBK9u2AZ4FbRxLAwlb/FAi4uI9NDqRxe1/Lk9kboYTO/7V7pg
 iUDmJnXMLzuw/YZKTZiZ5/IB2JlBVX7TXBdOTBUciSJTOQzM/MaoPYRK378jML1A6R2NGUJnhrG
 +SadultpwqPLOl9DRZ/2zlrJsoHWrFbLd+BM5OONV90sw/aWr5vFl6spHZ3HPHWiIfjbriGBriW
 qUjVGhtkq4ed621LZzr5uZK26tQIH+oU+xWGKrt
X-Received: by 2002:a17:90b:4fc5:b0:37f:e1b6:4c7d with SMTP id
 98e67ed59e1d1-39b26190c25mr63133345a91.6.1789062305438; 
 Thu, 10 Sep 2026 10:45:05 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d950913a6sm687771a91.6.2026.09.10.10.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 10:45:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:44:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v14 00/15] net/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260910104454.7b805ba6@phoenix.local>
In-Reply-To: <20260909054410.1490944-1-g.singh@nxp.com>
References: <20260908054736.842738-1-g.singh@nxp.com>
 <20260909054410.1490944-1-g.singh@nxp.com>
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

On Wed,  9 Sep 2026 11:13:55 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V14-changes:
>  - revert rte_zmalloc to calloc as suggested by AI.
>  - fixed validation issues.
> 
> V13-changes:
>  - Fixed checkpatch issues reported by new script.
> 
> V12-Changes:
>  - Fixed documentation for:
>    - missing double quotes for enetc4_txq_prior
>    - In accurate comment related to secondary process burst functions.
>    - Added a note related to LRO and its BD size chosen.
>  - Fixed secondary process burst functions selection.
>  - Removed "Unicast MAC filter" from vf, but comment regarding "RSS
>    hash" is false positive as or RSS hash, the only mandatory
>    requirement is `[provides] rte_eth_dev_info: flow_type_rss_offloads
>    , which the VF sets in enetc4_vf_dev_infos_get
>    (`dev_info->flow_type_rss_offloads = ENETC_RSS_OFFLOAD_ALL`).
>  - Fixed lro and scattered_rx configuration by enabling only after
>    rsc_enable branch.
> 
> V11-Changes:
>  - Added enetc4_vf.ini for VF only features.
>  - Fixed the secondary-process guards leave the burst function
>    pointers NULL
>  - Fixed rxq_info_get and txq_info_get report the doubled ring size
>  - Move the VFs only features to enetc4_vf.ini
>  - Setting the dev->data->lro
>  - Added a comment to use devargs to change delay and timeout to process
>    PSI message to avoid any interrupts stall.
>  - Fixed link_update() now rewrites RBMR on every Rx ring.
>  - Regestering - enetc4_txq_wr in VF
>  - Updated enetc4_rd64 with re-read to confirm the correctness.
>  - Removed the dead code and un-used macros.
>  - Added Vlan check for maximum allowed value.
>  - fixed pre-existing ring write function for TX path.
> 
> V10-Changes:
>  - Fixed enetc4_txq_prior and enetc4_txq_wrr have no effect at queue
>    setup issue.
>  - Updated ENETC_CLASS_ID_SI_VLAN_ISO reply check.
>  - Updated enetc4.ini for VLAN offload.
>  - Added else part for burst functions selection for RSC and TSO.
>  - Updated enetc4_rd64()
>  - Fixed RBICR0 issue.
>  - Removed GENMASK.
> 
> V9-Changes:
>  - Mid-body variable declaration moved to top of the function.
>  - ret=0 dead code is removed.
>  - Added check on return value of rte_intr_callback_unregister()
>  - The pre-existing reply_msg leak fixed.
>  - Added primary-process guard in enetc4_vf_dev_init
>  - Removed Flow control from enetc4.ini
>  - Fixed VF stats_reset baseline underflows on counter wrap
>  - Fixed VF vlan_pvid_set fails on every successful command
> 
> V8-changes:
>  - Fixed Warning RBMR RMW races between threads by adding lock
>  - Fixed `static const` arrays in `enetc.h`
>  - Proper pthread_mutexattr_t initialization added as suggested by AI
>  - VSIMSGSR stale re-read race is eliminated
> 
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
> Gagandeep Singh (15):
>   net/enetc: add keep-CRC Rx offload for ENETC4
>   net/enetc: add TSO support for ENETC4 VF
>   net/enetc: add RSC (hardware LRO) support for ENETC4
>   net/enetc: extend PF-VF link speed field to 8 bits
>   net/enetc: add VF supported features file
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
>  MAINTAINERS                            |   1 +
>  doc/guides/nics/enetc4.rst             | 114 ++-
>  doc/guides/nics/features/enetc4.ini    |   4 +
>  doc/guides/nics/features/enetc4_vf.ini |  28 +
>  doc/guides/rel_notes/release_26_11.rst |  21 +
>  drivers/net/enetc/base/enetc4_hw.h     | 148 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 133 +++-
>  drivers/net/enetc/enetc4_ethdev.c      | 560 +++++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 928 ++++++++++++++++++++++---
>  drivers/net/enetc/enetc_rxtx.c         | 530 +++++++++++++-
>  11 files changed, 2286 insertions(+), 187 deletions(-)
>  create mode 100644 doc/guides/nics/features/enetc4_vf.ini
> 


Applied to net-next
