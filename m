Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C8C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:41:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BC9540B94;
	Tue,  8 Sep 2026 14:41:02 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id CC69A402F0
 for <dev@dpdk.org>; Tue,  8 Sep 2026 14:41:00 +0200 (CEST)
X-QQ-mid: esmtpgz10t1788871255t6cdb1610
X-QQ-Originating-IP: VTRZfWrgi5cpZBaOoarVz5v88sbjFJG0m1Mp2kzlpYc=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 20:40:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6949232663274033613
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 00/15] Wangxun fixes and new features
Date: Tue,  8 Sep 2026 20:38:45 +0800
Message-ID: <1D56D388191C405C+20260908124047.2284-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NC8a1JKFOHmWTGu6bEiPvSEXU9pBQHGqqqyU+rmsF2PuVPTGBGOG6Fs6
 Nio42Yk2kSt1nTvZtZq0UnGUmNh62++prDeyMPJEWq49Y6PhJIEIRQouCUZ2dGWxPc10GGY
 RXAIJ+Mxf7FEC+9dfjpbjBynS66yb2OAlPrvgiJvywOYHdChmHglnv+BqayzSkZQ0diOv/k
 uwrFxbadgvaelVburuKKmi5Yvll0VpjQuKDWM/mnDd1U9JV4f2rl8+VCirYAeJdAwxkljcO
 4McPs469MRYiyF4U3FrMykqr5gYUrOglFtPFtr9DV0T7T4q6hhh4pIiwb9RBKtpUQICFES0
 ZRcs1elkUR30oyDB79QEA2WFQRNdqxTWlVhUHKFj8zmwKOt8/VIzJWnDopu576Q12o7/YNy
 q7xOE/QSlzrw2Umj8GZjVXeMa0gh+192VbvylnhGrJf/nLhS2S2lbvU53aVYEJyyn6/IPSI
 HDO3zrtkAlNrgVi3XmCjQx6zFPHeIhIRo4OiiLsYYKT+yJwefD1gbRBlEVrDm0doKnnY7N2
 D88/wg7laTz8hfWFxq3h0frvjNbzFEIk9KCvb0XI5+gE+kiAx4/EQLj73HnvuhlgCXqJZsh
 uAn+1Wa7UpD9tOTckGRQL5rpReTgxHsMd2sBBk4u+jnjenutDVo+bglAmcHNY0THhdACNT9
 Mv+9QHIQwDpvTbxWv632M1gCQRMZ77wKTLH3FzhDtmD1Njdu1QdWDcafFRn9M3OugS5VAin
 JUVevIZHy+rCN7oMHvrS7Q5fHL2hXNdM66ghd7+muqkHEL9MSw3ZYD5vgDzOfzwkrsfbOgb
 6HkTSVyPTtUBDw/GLwE8W4CeklLuIQeoXqtWp11V6xRrV4aPPbOeGYHpys2nU9judRrVFdn
 l33zBDP5HxcFe/dl36stHKYaHkpzAtCPmQCZp4khsj8cDIQh2/pmfuS3R3q3zjlJYhbT+Zt
 FCY8FzOEdveh7/JLmV3h494CaC7JX8MyqTE6WQXDa1gic9oz7JPvBy/IirrIe3y9HAs7fHb
 aY5h4ykgvFWr2a1to+SsempbuJkOAXM7Ow5TQ9OA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state), and additionally refines U
DP offload handling.

---
v2:
 - add a new commit to handle 10G config on dual-speed DAC
 - P02: handle TXGBE_ERR_PHY_INIT_NOT_DONE before the timeout split and leave link_valid untouched.
 - P07: resolve the inner tunnel type in a local variable instead of rewriting mbuf->ol_flags.
        check the rte_pktmbuf_read() result for short or mis-annotated packets.
        use RTE_GENEVE_DEFAULT_PORT instead of the literal 6081.
        add a Fixes: tag pointing to the commit that introduced the tunnel offload handling.
 - P10: split into a bug-fix commit and a feature commit.
        document both devargs in the NIC guide and the release notes.
 - P11: check the acquire_swfw_sync() result and only touch I2C while the semaphore is held.
        replace the magic numbers with named constants.
        add the release notes entry.
 - P12: drop the stray C99 comment on the AN-config flag assignment that checkpatch rejects.
 - P13: reword the message to state that 40G active cables are handled through the optical path.
        use txgbe_is_dac_cable() in the 40G FFE selection to match the 25G path.
---

---
Not changed in this revision:

 - P11: enable_tx_laser() is not gated by laser_off. laser_off only
   controls whether the Tx laser is brought down on port stop, while
   enable_tx_laser() is unconditionally called from dev_start() and
   dev_set_link_up() and must always bring the laser up, otherwise the
   default (laser_off=0) configuration would never bring the link up.

 - P11: no extra restore of PMD_CFG0 bit 1 on the DAC path. Bits 19:12
   are restored by txgbe_e56_set_phy_link_mode() and
   txgbe_set_link_to_amlite(); bit 1 (PMD enable) is also restored by
   txgbe_e56_set_phy_link_mode(), which the xpcs AN path calls on link
   up, so no additional write is required.

 - P12: no total iteration bound was added to txgbe_e56_exchange_page().
   The loop is bounded per page and exits when the AN FSM reaches 0x8,
   so it does not hang in a normal Clause 73 flow. As this is hardware
   related configuration, we leave the current behaviour unchanged for
   now.
---

Zaiyu Wang (15):
  net/txgbe: fix failure to configure 10G on dual-speed DAC
  net/txgbe: fix e56 PHY configuration error
  net/txgbe: fix incorrect link state in 10G forced mode
  net/txgbe: do not force reconfig on link retry
  net/txgbe: set i2c sda hold time
  net/txgbe: fix link speed display info for 10G mode
  net/txgbe: remove stale outer UDP checksum offload flag
  net/txgbe: add offload support for tunnel type UDP
  net/txgbe: fix SFP hot-plug when auto-negotiation is on
  net/txgbe: fix DAC hot-plug on 40G NIC with auto-negotiation
  net/txgbe: fix 40G FFE tuning applied to first lane only
  net/txgbe: add pre2 and backplane capability devargs
  net/txgbe: add devarg to turn off Tx laser for 40G NIC
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification

 doc/guides/nics/txgbe.rst              |  18 +++
 doc/guides/rel_notes/release_26_07.rst |   8 ++
 drivers/net/txgbe/base/txgbe_aml.c     |   3 +-
 drivers/net/txgbe/base/txgbe_aml40.c   | 100 +++++++++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  14 +--
 drivers/net/txgbe/base/txgbe_e56.h     |   6 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 161 +++++++++++++++----------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   2 +
 drivers/net/txgbe/base/txgbe_hw.c      |  37 ++++++
 drivers/net/txgbe/base/txgbe_phy.c     |  13 ++
 drivers/net/txgbe/base/txgbe_phy.h     |   7 ++
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  17 ++-
 drivers/net/txgbe/txgbe_ethdev.c       | 120 ++++++++++++++++--
 drivers/net/txgbe/txgbe_rxtx.c         |  29 ++++-
 15 files changed, 437 insertions(+), 101 deletions(-)

-- 
2.55.0.windows.2

