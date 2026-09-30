Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6414CA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 16:18:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF580427B9;
	Wed, 30 Sep 2026 18:18:19 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id E8E5D402D9
 for <dev@dpdk.org>; Wed, 30 Sep 2026 18:18:17 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4b4770191so948141a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790785097;
 x=1791389897; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gLmnWDzLS23WYXdfLIOY1O+AQ0/QxWKHX2cHFPUTKmc=;
 b=ol2Y4jMb5bwb089V3gXlm4IRTP37fhu9Di7HYMaESTe+bzw2AxqLLzn78lXsYuzzmA
 QUaZuVZtkX3+SBIEXyJYpDTvC6UUINgIln+hm9tjlbzOsbd/5Dp5JKotc2nDkA7R4kpV
 9lfPDynq4XPaErFLpKvgXIWiy82W3+CZ92CinN7UdjodGFmf85vBeSPi2Z9XnZ3NpXK8
 e3Bqvb4x9dmdNcco8yT261k+V1Y/wg2g5SfLgIleRblvqVbSzNjVLXO8IQYCMf7v5ERv
 WmBBCL9czljoq0E6zbmnEgoDdq8+6wUg1SjjUsjCRmtzgRQNq+m+MKvtrm0fuUlEVfB+
 ni2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790785097; x=1791389897;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gLmnWDzLS23WYXdfLIOY1O+AQ0/QxWKHX2cHFPUTKmc=;
 b=V9d1sd/MC1AzgOXslnzKu1nnWF1/r2mk7IMZNUoL7uS8yUdlhvi+PX0wpUycp11Fux
 oOwZ0vqtBe9zQLuF8kfiDC7rlU4PIjsQJFSszpp5AUbtQIYvkW+pUuy/+S56m+LoFZKJ
 KW0JcDCeOP2ZnTnOXROb5kTtoUZ7vGmLf2ggWgyHVE8Yu7qWlZHu8dOvdOe+TD4TGfee
 0J+pNspybE4cVyXI1ksmdZ19tGmSf+Bv1fAOz3yfYGnHglEj53CUWRAChtV1K/6lsJhT
 k5AjbpjXysV8TchWIlnBUvwu5iNDgPSLUObmVxZoHDKKC5vNqGwiQUeHSdUCAtF8UmLW
 dR3Q==
X-Gm-Message-State: AFq9FYI6G7eA1P92t9y+iFMYNKcGsDbB9M1yNoKaIOQaEvW98vTdYJrj
 jEpA2LIGfltBdF8YzQpvBlZgG8PMUk1l3ykZLnQ+LsNNZrXJ7HwP+JQjE02NlFHzaojsXg2k7Zy
 rBtUtyGQ=
X-Gm-Gg: AYBFou2mAzCtQHJBzH+yinYaraLF04iw0JNO2V23CRSXPJICDaLb3pkpoDCa3Joa5ki
 LJlOp9rK2OpZIiaVBJmi0hlBjhTPjXLKAcJrH9YboQvj2v/cCNZ+1a57dnE6mqAMVFfhjOhnXj6
 5gyibWk940k+lsCzhKZkx0j6HVVPmcJ2H+1RSmfPeJNmq9eaJmMcZjOs3y+xRjWH7H0NkjwOPAj
 2mViGLu0DdBYMDkwID7ZJdE1N2kiGdA0K/36tFiB8g+Pps6PRXi1v5GRjHg1/xVfF/E1kOl3bAE
 8QiWsQZl0agg13+UI87XA9IzO/j18cOVj3o5If3kyiondjErMkRyrT/Vd0QUNozdZTjc85p8swB
 18uJHU+iiLvvI4pyouUSFTf0t2gfZBGPGeAwGg1jxJFSuKDCYrxsAA9+uBw0vz/+EKbw/phMwCO
 yPoXjabymv222dgjsQx9nD1BwBzIWfPHpRHZ91THFkMFiDwTJYpiNbT1Xmabv7U5ZPlT8hrdhWZ
 Cu5W9njyBryQiGt0y0QbvsU5YM6BXxtA0WX7S08
X-Received: by 2002:a17:90b:3ec2:b0:3a2:b70b:9cc3 with SMTP id
 98e67ed59e1d1-3a4d0f0247dmr1670313a91.8.1790785096645; 
 Wed, 30 Sep 2026 09:18:16 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f3ff67cfsm101587a91.0.2026.09.30.09.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:18:16 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:18:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 00/15] Wangxun fixes and new features
Message-ID: <20260930091814.6c3179d5@phoenix.local>
In-Reply-To: <481A5713EEB8C431+20260930102042.2214-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
 <481A5713EEB8C431+20260930102042.2214-1-zaiyuwang@trustnetic.com>
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

On Wed, 30 Sep 2026 18:17:47 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs
> (CR/KR training, hot-plug, 10G link state).
> 
> ---
> v7:
>  - P14: fix a TRAINING log-string typo.
>         move the variable declarations in txgbe_e56_get_txffe().
>         clarify the comment of page-exchange timeout budget.
> ---
> v6:
>   - fix the apply failure.
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
> 

There are several more things to address:

Review: [PATCH v7 00/15] net/txgbe: Amber-Lite link and offload fixes

The series applies to main (04d091f) except for the release notes
hunks in 12/15 and 13/15. Every commit builds with -Dwerror=true
(gcc 13.3, x86_64). All Fixes: tags resolve; the Amber-Lite commits
are in 25.11 and 26.07, so Cc: stable is appropriate.

Resolved since earlier rounds:
- 09/15: AN73 watchdog can no longer be re-armed after dev_stop
- 12/15: no longer tagged as a fix; the new FFE defaults are
  documented
- 02/15: states the 10GBASE-KR advertisement change
- 15/15: no longer clears devarg.auto_neg
- 14/15: txgbe_e56_exchange_page() is bounded at 200 ms, and
  BP_LOG arguments are only evaluated when the log is enabled
- 13/15: the commit message explains why the SFF-8636 Tx enable
  write is not gated on laser_off. That holds: the byte survives
  across runs while the module stays powered.

The generic UDP tunnel patch is gone.


Patch 15/15: net/txgbe: align link capabilities and DAC
classification

Error: 10G active limiting DAC on the 25G NIC fails to start

  txgbe_is_dac_cable() includes txgbe_sfp_type_da_act_lmt_core0/1.
  get_link_capabilities_aml() now takes the DAC branch for such a
  cable and reports *speed = hw->phy.fiber_suppport_speed.

  txgbe_identify_sfp_module() only assigns that field in the
  passive DA branch (and the QSFP path only for CR4); the DA_ACTIVE
  branch never does. On a fresh port it is 0. setup_phy_link_aml()
  masks the requested speed to nothing and returns
  TXGBE_ERR_LINK_SETUP, so dev_start fails. If a 25G passive DAC
  was in the cage earlier, the field is 25G|10G instead and AN73 is
  enabled on an active limiting cable.

  Before this patch, this cable took the fiber branch (10G|25G, no
  autoneg). Set fiber_suppport_speed to 10G in the DA_ACTIVE
  limiting branch.

  The passive branch has a related problem: it uses |= for the
  10G-only case, which keeps the 25G bit from a previously inserted
  25G DAC. The hot-plug support in 09/15 makes that reachable.
  Assign the value instead of OR-ing it.

Info: txgbe_is_10g_fiber_sfp() cannot match on aml40. The srlr
  types are only set by txgbe_identify_sfp_module(), and aml40
  identifies through txgbe_identify_qsfp_module(). Drop the branch.


Patch 05/15: net/txgbe: do not force reconfig on link retry

Warning: passing false also turns off need_restart

  autoneg_wait_to_complete is passed through to
  txgbe_e56_set_phy_link_mode() as need_restart. That function
  returns early when curbp_link_mode == 10. set_phy_link_mode()
  itself calls txgbe_set_phy_link_mode(hw, 10), so curbp_link_mode
  stays at 10 until training selects 25 or 40.

  As a result, a retry while the link is down and AN73 has not
  trained is now a no-op. The xpcs branch never sets need_reset,
  so the retry is not re-armed either, and recovery is left to the
  check_bp_event watchdog alone. Either say so in the commit
  message, or keep need_restart true when the link is down and
  rely on the link_up && an_done check for the case being fixed.


Patch 10/15: net/txgbe: fix DAC hot-plug on 40G NIC with
auto-negotiation

Warning: the poll repeats identify for modules it cannot classify

  The poll skips identify when sfp_type != not_present. On aml40,
  txgbe_identify_qsfp_module() leaves sfp_type at not_present in
  two cases:

  - the identifier is not QSFP/QSFP+; it returns
    TXGBE_ERR_SFP_NOT_SUPPORTED
  - byte 131 has none of the CR4/SR4/LR4/active bits (extended
    compliance only, e.g. ER4); it returns 0

  Both cases now repeat every 2 seconds on the EAL interrupt
  thread. Each repeat costs a 200 ms msec_delay() busy-wait plus
  I2C traffic.

  In the first case, each poll also logs two ERR lines.

  In the second case, each poll runs setup_sfp() and
  txgbe_dev_setup_link_alarm_handler(), which calls
  setup_link(hw, speed, true). On a down link that reaches
  txgbe_set_link_to_amlite(), with up to 2 s of msleep().

  Without the poll, these paths ran only on a GPIO event. Record
  the last sampled module-present level in the adapter and run
  identify only on an absent-to-present transition. Alternatively,
  set sfp_type to txgbe_sfp_type_unknown when a module cannot be
  classified.

Info: on optical modules, a module swapped between two polls
  keeps the old sfp_type. check_bp_event only samples the present
  pin while AN73 is enabled.


Patch 13/15: net/txgbe: add devarg to turn off Tx laser for 40G NIC

Warning: set_link_up does not undo the DAC disable

  With laser_off=1, txgbe_disable_tx_laser_multispeed_fiber()
  clears RX_EN, the Tx enable bits and PMD enable in PMD_CFG0 for
  DAC, unknown and absent modules. The enable path,
  txgbe_enable_tx_laser_multispeed_fiber(), has no counterpart; it
  only restores the SFF-8636 byte for optical modules.

  dev_start recovers because setup_link reprograms the PHY.
  rte_eth_dev_set_link_down() followed by rte_eth_dev_set_link_up()
  does not: set_link_up only calls enable_tx_laser() and
  link_update. The link thread is only started for
  txgbe_media_type_fiber, and aml40 is fiber_qsfp. With the Rx
  lanes off, check_bp_event sees no AN pages either, so a DAC link
  stays down.

  Either restore PMD_CFG0 in the enable path, or reconfigure the
  link in set_link_up. The documentation also says the laser is
  turned off "on port stop"; it applies to set_link_down as well.


Patch 14/15: net/txgbe: fix CR/KR link training and recovery

Warning: there is a stray "1" line after Signed-off-by, above the
  "---". git am keeps it as the last paragraph of the commit log,
  so git no longer finds any trailers in this commit. Drop it.

Info: the commit message says the poll waits for 0x78010 == 0x9,
  but the code tests (rdata & 0x9) == 0x9, which also matches
  0xb, 0xd and 0xf. If 0x78010[3:0] is an encoded FSM state,
  compare the field instead of masking it.

Info: check_bp_event still busy-waits on the EAL interrupt thread:
  up to 200 ms in the page exchange, plus 400 ms in the CL72 poll,
  plus the RXS sequences (same as v4).


Patch 11/15: net/txgbe: fix 40G FFE tuning applied to first lane
only

Info: S40G_TX_FFE_4LANE() masks the value to 8 bits. On aml40, any
  ffe_* value above 255 is silently truncated, while the parameter
  string still says uint16. Reject such values in
  txgbe_parse_devargs().


Patch 12/15: net/txgbe: add pre2 FFE tap and backplane capability
devargs

Info: bp_capa is still not range checked. On the 40G backplane, a
  value above 2 advertises no 40G ability at all (same as v4).

Info: the release notes hunk no longer applies to main. Put
  "Updated Wangxun txgbe driver" between Solarflare and ZTE.
