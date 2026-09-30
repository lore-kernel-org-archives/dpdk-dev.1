Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E77CA5FB1
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 10:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3838840BA0;
	Wed, 30 Sep 2026 12:20:53 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id B8A4A40278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 12:20:51 +0200 (CEST)
X-QQ-mid: zesmtpgz3t1790763647t36c9e054
X-QQ-Originating-IP: auUQsuXNhFHg9vZROZj2nrFogpi1oNAKeBJQ5xV0YbU=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.241.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 18:20:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4852022028234559461
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v7 00/15] Wangxun fixes and new features
Date: Wed, 30 Sep 2026 18:17:47 +0800
Message-ID: <481A5713EEB8C431+20260930102042.2214-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OL/6RyBS/f6QMMvIyVbMUOrmR1s+b7OiPjuP2YlclCzsnCAcwQ4g8RxT
 /edB6tz2kv/pRSfkWDnnX/wvOFX+6ivikgM0Vnwtk4TIPfLuTtenG43fszsRnug7n716Juk
 9T3H4/LSFO9jXEm5PnutpffbTMeM2/FxiI5USJwCWoddoj4Q4p2Gq5St9iU05EPGyKIHigi
 AEVaQEkQp2Pcd3iR0u3cPYmZIeGdjYYBpnNO0EcYV6wl8k+6QTTtCZLg/txefnP/afPhseB
 0506AaqtzsmUlPH+Wc9PQl6eZwb27aGw6DLzyvZtiu+qVIT23aDv5JG3XjHAfYKSq8bCIuk
 a2jmqc2L1JQg750OXllA49KYw0NhL7LVFzSk3ofShd67crqCMt+H2/GGrbtIn8Tc4epq2sY
 /uol3+FYdiXPzOJR/7Zqq7YGVyrQ50mnnIYk96xQTZmZDg6q1z/2MFXNv9+lLipkFSRISxW
 qUQ2gdXcUsfEDxCJz9xTyyV5eJ6MsNQHIgIDuwEInZm+9n1lcRsx4WUCOW802qfNp4udrBs
 o8Foq9nUxs/1d6yPryxPMasyVg2K0jDQpN9phDIfO7Bud7dyBEpNRQflMOjgwQMH/159q2A
 8knekfk1v5oVnmVEZEVBOpcTcN84FZpQEXq1DxBJfD4lWC8BYfDjEbKv5zj0+9qUIRd6STi
 DFgsthC+ngcT1uwULYD6t8dogNfDHz1Slcc2xAOm2XK0WXGAOnIaHNIENHnsH2Yn0eq8PW3
 hDMdKa4eCFLUpF0jaVn+CsIFRSoYHg9hC4C/cnKLCMEda0LTZQmGPK34l0DrxaesQpocEyH
 kVfr/nGVqBoACsaGsjHvmVOD/G2l38Z8xu2EEJ0VT+oTi09Bhq/MN40ctLW5maYZjGWdYVM
 2HWklgEFWmfBl1LW+Y3QQdwmpsiCVamFYXdIme+v0OitMPI7xGeEflROVJfZuAwncB2BOWJ
 rYhZBRtpVEec/RQe/6ZTbAVagFd5rfM8nYywjtyCpB1B/10sQvs6Uk8AXeGHJhK+Ksy5Uf0
 MoXAHh7Yq5Tvq2tIY+rwN9BGS15uZJVWbYo6BRYaT6hk6r7izT
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
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

This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs
(CR/KR training, hot-plug, 10G link state).

---
v7:
 - P14: fix a TRAINING log-string typo.
        move the variable declarations in txgbe_e56_get_txffe().
        clarify the comment of page-exchange timeout budget.
---
v6:
  - fix the apply failure.
---
v5:
 - drop the UDP tunnel patch: the generic UDP tunnel flag covers any UDP
   tunnel, so the tunnel type cannot be resolved from the destination port.
 - P02: advertise 10G, 25G, and 40G from the requested speed mask instead
        of the device ID, so the 25G and 40G parts advertise 10G by
        default as well.
 - P07: keep the patch limited to decoding the 10G link speed from PORTSTAT;
        the AML40 default 10G|40G advertisement change is now in P02.
 - P09: gate the SFP detection alarm and the AN73 watchdog on a new per-port
        flag that dev_stop clears before the first cancel.
        cancel SFP detection before the watchdog.
 - P10: re-arm the 40G module poll only while the SFP/AN73 alarm flag is set.
 - P12: treat the ffe_pre2 and bp_capa devargs as a feature rather than a fix;
        drop the Fixes tags and stable Cc, and document the 25G/40G Amber-Lite
        FFE defaults.
 - P14: bound the AN page exchange, propagate its timeout to the watchdog h
        andler, and avoid register reads used only by disabled BP debug logs.
 - P15: stop clearing the auto_neg devarg when a 10G-only DAC disables AN;
        derive the effective AN73 state from the current module capabilities
        instead. Classify 40G active cables through the optical path, unify
        DAC checks on txgbe_is_dac_cable().

Not handled in this revision:

 - P12: bp_capa is not range-checked. Devarg validation will be added in a
        separate change so all txgbe devargs can be handled consistently.
 - P14: the AN page exchange still busy-waits on the alarm thread and can
        delay handling for other ports. A later change will decouple negotiation
        from the alarm callback and run per-port negotiations in parallel.
---

Zaiyu Wang (15):
  net/txgbe: fix failure to configure 10G on dual-speed DAC
  net/txgbe: use the requested speed in E56 AN setup
  net/txgbe: fix e56 PHY configuration error
  net/txgbe: fix incorrect link state in 10G forced mode
  net/txgbe: do not force reconfig on link retry
  net/txgbe: set i2c sda hold time
  net/txgbe: fix link speed display info for 10G mode
  net/txgbe: remove stale outer UDP checksum offload flag
  net/txgbe: fix SFP hot-plug when auto-negotiation is on
  net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation
  net/txgbe: fix 40G FFE tuning applied to first lane only
  net/txgbe: add pre2 FFE tap and backplane capability devargs
  net/txgbe: add devarg to turn off Tx laser for 40G NIC
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification

 doc/guides/nics/txgbe.rst              |  25 +++-
 doc/guides/rel_notes/release_26_11.rst |  11 ++
 drivers/net/txgbe/base/txgbe_aml.c     |   4 +-
 drivers/net/txgbe/base/txgbe_aml40.c   |  92 ++++++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  14 +-
 drivers/net/txgbe/base/txgbe_e56.h     |   6 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 196 +++++++++++++++----------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c      |  33 +++++
 drivers/net/txgbe/base/txgbe_osdep.h   |  12 +-
 drivers/net/txgbe/base/txgbe_phy.c     |  25 +++-
 drivers/net/txgbe/base/txgbe_phy.h     |   7 +
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  17 ++-
 drivers/net/txgbe/txgbe_ethdev.c       | 178 ++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h       |   2 +
 drivers/net/txgbe/txgbe_rxtx.c         |   1 -
 17 files changed, 502 insertions(+), 128 deletions(-)

-- 
2.55.0.windows.2

