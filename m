Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D21C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 503EF40E0A;
	Tue, 29 Sep 2026 18:06:02 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id EAFB94026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:06:00 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so3084675a91.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790697960;
 x=1791302760; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nGRXurcTyXyKE4JL8WlYap+yLyxbKxLfoeMcZR3FZlE=;
 b=c9vVMga72fBGsbC0Vy7Qgmnc5w8QBPcN+Q5ta8wB6pGsj7G0APaetRbhFux9L4f/UN
 hJZpew0KRoFOzdR5xEI4bWnE6219cAT5tEGK8q4pmH/KkfLW3AH8NZ4W3jgZJR0Hm2+N
 tl3LWWvEbbvR3jSCZpAyu+HCPgSHZi2wJaHuZZNsrYQ6ktUduuIe7PqMS2+c2wdd2A7D
 5ywXgPQXy2g0FC+vQLHwd6Kai28Pi9baEDFzApm6aznhP60lPE/f9AkJddb1qkQdR6xy
 HQJrcoEq04M3+I+gKe1HepRk3EtbZ5sH4QEqCwuGA9+tdwWvIYjLUbgP6Rog++1kNQ7r
 Iogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697960; x=1791302760;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nGRXurcTyXyKE4JL8WlYap+yLyxbKxLfoeMcZR3FZlE=;
 b=bJJ1Rwl5vbcSUe5skYIDI1oE2Hxm4th9UBrytgYCux1Bvtag6oIWcHbpvJ+zxZPHhJ
 3+ejomy9IkEceCaEha5ryc9tXXFTNXsX4HBC5aTKVI48syekeb69V2m5zdOrcVBYW0em
 mDSDlHbucLlo0/AEaWWhqa9wmAMMHhhmIsBeKLcelssY6AJyUlV6cDhdUgSB+4JUjkzV
 YvpO+FcAdAc/xr8tiNODwD6an84RuPRkuISK9TzOFZTjtGeNDR0RDIpYv34EGI4YIUlY
 A1wKuT+kW+DcIKw6tAg1oA6D4/im7Bx60yD0ztsGAptqsUX1Cwnh8mlQ8fWCTaCOCNge
 hSVg==
X-Gm-Message-State: AFq9FYKsOLI7m1T1Z8hBg7LmdqWNOsJRmqt1BcfGhBTltmFPiU/t9a0R
 cHKh4CqAT/r0d38mLPXqecdyxO9KTSgdlpnoQP9d0JKZmE772j1NUGOqnBd2r4YGd5RDCRuu+D5
 gvEq79/0=
X-Gm-Gg: AYBFou1t5ahJhNWXl2j+RWT03xr3Cf5aHF5jyMm8YoEylSL9tqK4bb9Sxl2bCIrdmq1
 yiV5Urm4izDztDLGhR3cFRs2DSbr9IBEv3OeYPuEJCtHpg9Kzdet6eeNzxHAttJsaWpxFQufGuO
 RQHCw6j/Fp0KsBu25JK7HafZQA2FUuXNZDGfL+JltUAhPbhsnksccTKQsKsYEmnXUIegXnxWxkP
 KE36d/y8azWAFVQmyW8fIIgH04pNUMcIeL6Dg8MJEX2EbQzDMsr01Oi9lylGDJ6m9mBVAmgzKzo
 TaMizdNk/JWZtTStp4feK5t2OfQK+3QmsZNjahxSkXzeatwibcSox2KC4gc0qQeeWuJRM2fMLgI
 wgDJpqzVdttsAW/jeePmTJyKrUD2ZyyeOSHlcUBkRVR/yOMq6XfMM1AdSlvliO9xALUuHo1/hxp
 oXNbV4PM4B9h9/mqnOSzwpPE50hG8rzk/EMrHu6xVNFxgIvu+FF8S3vNlXgtMgBzcB+gUTr57+H
 jZOq0xWpufkv+h1wwVViyfNndFMtx9mYboZTd6Z
X-Received: by 2002:a17:90b:48d0:b0:3a4:b9de:87a1 with SMTP id
 98e67ed59e1d1-3a4b9de9765mr311052a91.45.1790697959737; 
 Tue, 29 Sep 2026 09:05:59 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4986e964asm6516212a91.15.2026.09.29.09.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:05:59 -0700 (PDT)
Date: Tue, 29 Sep 2026 09:05:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 00/15] Wangxun fixes and new features
Message-ID: <20260929090556.7878a2d0@phoenix.local>
In-Reply-To: <EEDC8610526E7CAD+20260929130611.4871-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <EEDC8610526E7CAD+20260929130611.4871-1-zaiyuwang@trustnetic.com>
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

On Tue, 29 Sep 2026 21:04:31 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs
> (CR/KR training, hot-plug, 10G link state).
> 
> ---
> v6:
>  - fix the apply failure.
> ---
> v5:
>  - drop the UDP tunnel patch: the generic UDP tunnel flag covers any UDP
>    tunnel, so the tunnel type cannot be resolved from the destination port.
>  - P02: advertise 10G, 25G, and 40G from the requested speed mask instead
>         of the device ID, so the 25G and 40G parts advertise 10G by
>         default as well.
>  - P07: keep the patch limited to decoding the 10G link speed from PORTSTAT;
>         the AML40 default 10G|40G advertisement change is now in P02.
>  - P09: gate the SFP detection alarm and the AN73 watchdog on a new per-port
>         flag that dev_stop clears before the first cancel.
>         cancel SFP detection before the watchdog.
>  - P10: re-arm the 40G module poll only while the SFP/AN73 alarm flag is set.
>  - P12: treat the ffe_pre2 and bp_capa devargs as a feature rather than a fix;
>         drop the Fixes tags and stable Cc, and document the 25G/40G Amber-Lite
>         FFE defaults.
>  - P14: bound the AN page exchange, propagate its timeout to the watchdog h
>         andler, and avoid register reads used only by disabled BP debug logs.
>  - P15: stop clearing the auto_neg devarg when a 10G-only DAC disables AN;
>         derive the effective AN73 state from the current module capabilities
>         instead. Classify 40G active cables through the optical path, unify
>         DAC checks on txgbe_is_dac_cable().
> 
> Not handled in this revision:
> 
>  - P12: bp_capa is not range-checked. Devarg validation will be added in a
>         separate change so all txgbe devargs can be handled consistently.
>  - P14: the AN page exchange still busy-waits on the alarm thread and can
>         delay handling for other ports. A later change will decouple negotiation
>         from the alarm callback and run per-port negotiations in parallel.
> ---
> 
> 
> Zaiyu Wang (15):
>   net/txgbe: fix failure to configure 10G on dual-speed DAC
>   net/txgbe: use the requested speed in E56 AN setup
>   net/txgbe: fix e56 PHY configuration error
>   net/txgbe: fix incorrect link state in 10G forced mode
>   net/txgbe: do not force reconfig on link retry
>   net/txgbe: set i2c sda hold time
>   net/txgbe: fix link speed display info for 10G mode
>   net/txgbe: remove stale outer UDP checksum offload flag
>   net/txgbe: fix SFP hot-plug when auto-negotiation is on
>   net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation
>   net/txgbe: fix 40G FFE tuning applied to first lane only
>   net/txgbe: add pre2 FFE tap and backplane capability devargs
>   net/txgbe: add devarg to turn off Tx laser for 40G NIC
>   net/txgbe: fix CR/KR link training and recovery
>   net/txgbe: align link capabilities and DAC classification
> 
>  doc/guides/nics/txgbe.rst              |  25 +++-
>  doc/guides/rel_notes/release_26_11.rst |  11 ++
>  drivers/net/txgbe/base/txgbe_aml.c     |   4 +-
>  drivers/net/txgbe/base/txgbe_aml40.c   |  92 ++++++++++--
>  drivers/net/txgbe/base/txgbe_e56.c     |  14 +-
>  drivers/net/txgbe/base/txgbe_e56.h     |   6 +
>  drivers/net/txgbe/base/txgbe_e56_bp.c  | 196 +++++++++++++++----------
>  drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
>  drivers/net/txgbe/base/txgbe_hw.c      |  33 +++++
>  drivers/net/txgbe/base/txgbe_osdep.h   |  12 +-
>  drivers/net/txgbe/base/txgbe_phy.c     |  25 +++-
>  drivers/net/txgbe/base/txgbe_phy.h     |   7 +
>  drivers/net/txgbe/base/txgbe_regs.h    |   3 +
>  drivers/net/txgbe/base/txgbe_type.h    |  17 ++-
>  drivers/net/txgbe/txgbe_ethdev.c       | 178 ++++++++++++++++++++--
>  drivers/net/txgbe/txgbe_ethdev.h       |   2 +
>  drivers/net/txgbe/txgbe_rxtx.c         |   1 -
>  17 files changed, 502 insertions(+), 128 deletions(-)

Looks OK to me, AI did find a couple typos that you should fix:


Reviewed the whole v6 series applied on top of main.  All 15 patches apply
cleanly, net/txgbe builds with no new warnings, and I found no correctness
bugs.  Three Info-level nits below, all in 14/15.

14/15 net/txgbe: fix CR/KR link training and recovery

A typo regression in a log string the patch rewrites:

	BP_LOG("KR TRAINNING CHECK = %x. pmd_ctrl:%lx-%lx-%lx-%lx\n",

"TRAINNING" should be "TRAINING".  The line it replaces spelled it
correctly ("KR TRAINING CHECK = %x, %s. ..."), so this loses the old string
for anyone grepping logs.  checkpatch flags it as TYPO_SPELLING.

Declarations after a statement in the new txgbe_e56_get_txffe():

	if (!rte_log_can_log(RTE_LOGTYPE_TXGBE_BP, RTE_LOG_DEBUG))
		return;

	/* 21. read txffe to check kr training status */
	u32 rdata = 0, pmd_ctrl = 0, lane_idx = 0, lane_num = 0, txffe = 0;

This compiles, but the rest of txgbe_e56_bp.c declares at the top of the
block.  Hoisting the declaration above the early return would match the
file.

Stale comment on the page-exchange loop:

	/* 50ms timeout */
	for (count = 0; count < 50; count++) {

count is reset to 0 each time a next page arrives, so the loop is really
bounded by count2 against AN_PAGE_EXCHANGE_TIMEOUT_MS (200).  The comment
describes the per-round budget, not the loop bound.

Review-Result: CLEAN

---
Notes on things that looked suspicious but check out, recorded so they do
not get re-reviewed:

- 02/15: the "readers fall back to get_link_capabilities() when the field
  is zero" claim in the commit message is accurate -- both readers do
  "speed = hw->phy.autoneg_advertised; if (!speed) ...get_link_capabilities()".

- 06/15: wr32m(hw, TXGBE_I2C_SDA_HOLD, ..., 0x640064) against masks
  0xff0000 / 0xffff places 0x64 correctly in both the RX and TX fields.

- 08/15: no remaining RTE_MBUF_F_TX_OUTER_UDP_CKSUM reference anywhere in
  the driver, so dropping it from TXGBE_TX_OFFLOAD_MASK is complete.

- 11/15: moving txgbe_parse_devargs() after txgbe_init_shared_code() is
  safe -- the latter only sets the MAC type and the ops tables and reads no
  devarg.  The four-lane FFE value reaches the register whole through
  wr32_ephy(), so widening the fields to u32 is what makes the replication
  work.

- 14/15: removing the "if (status) return status;" after
  txgbe_e56_cl72_training() does not swallow the error -- status is not
  reassigned through the idle-detect writes and is still returned, and the
  caller checks ret.  The commit message says the non-abort is deliberate.

- 15/15: txgbe_xpcs_an_enabled() calling get_link_capabilities() does not
  recurse (no capability function calls back into it), and the
  !hw->devarg.auto_neg early return keeps the 25G path's unconditional
  *autoneg = true from re-enabling AN against the devarg.

- 09/15 and 14/15 are the two patches checkpatch rejects, both on false
  positives: "no space after cast" on RTE_ATOMIC(uint32_t), and
  COMPLEX_MACRO on "#define ...CFG_0 1, 0", which is the bitfield-pair
  convention used throughout the e56 headers.

One design point worth a second opinion rather than a fix: in 10/15,
txgbe_dev_detect_sfp() re-arms itself at the "rearm:" label, which the two
sfp_an_alarm_enabled == 0 early returns deliberately skip.  That is how the
poll stops on dev_stop, and it is correct, but it does make that gate the
only thing terminating the 2-second poll that 40G hot-plug detection now
depends on.
