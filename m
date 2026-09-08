Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E61C79F99
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:27:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56CDF40691;
	Tue,  8 Sep 2026 15:27:51 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id EC9A1402DF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 15:27:49 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1788874065t216f46b8
X-QQ-Originating-IP: o8PPu4Q+HYCt7Pv1WjqCi/R5CccQluH/de5jIWQEBe8=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.66.61])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 08 Sep 2026 21:27:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2906970519092398505
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 00/15] Wangxun fixes and new features
Date: Tue,  8 Sep 2026 21:25:45 +0800
Message-ID: <7A2945F19DE3AC03+20260908132742.2661-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OZ2oArlhewUp+JH4UlM/ih9P+bdbFV7tChQX1CCAs8HB7ZTT8vmFtLSv
 NXSBdLzULc92VmZ7CNzz5L3yzsXzmupjLFQANO0eb5c3NwocVWkt5jL6UCREsEopSyBEgOU
 ncTD5gADJMDiqFHQpTKhoDY1Tlci12U+GeYGatUop8QATpp4oYRypXi1KXoC1Yz7jr0ki19
 XM2I9cMAEkThVLiFZvUG1FzNKmHubIt7Ht7uKAlwXBQ4pEzqAyVfxOF91Pfm8niWK8YpZXZ
 dfEkH8YtwsjQ5Y/ZSNT6/zGC4zezD6hGJHyo+T1rVOKYwzUwd+NWCJAse0V6dEHhYp5Epzk
 swjMehqB1Za6QLWw7RkO7FEQG7MyIXbufNp8Pnbg0TDG7VRemV4Lx1u/6iG7G/OIOe27AT+
 B27Wn43VQbtKTly+yHDp0teT9zv4eCxSSyqVyL7tGnb10f31OBPW9ozGXfB5a6S6m9VoXGO
 x/jIT16sisX/ZzXnBwHh/zUpxi5nQIr/5RH8ZHsJaIt+qeY4iRykMJO3lXsmKNj4+jflvpR
 ZyueQcBU6qey+MRostNOjj36YXrk4QVFwOk1cpgYp1ienq+vQPLIf4kQX7ooaDKbpVy4OUR
 ghhL9hPJEYuZYFNUmgwGvJHrzO9zTgOeEGEG/7GV03Cr2Juz0XBldjVU1y7DGejsHx2ESts
 3NvL4iL8lU4IIhMHHWouOp1/K+FuY0GMhTp4+wnhD/nk1X3eobnXAc+yWLMj/MfOhWcchak
 3hOq+hOXB0K6qmrEhnsBNN/YwqdL72FBxjCW03KK1DLr4Vc0n8O0yJUpzSiymrAf+OSv6w/
 LlJvmSlotNVlVWLfv2lK6tgSi4gXcwof5CULd29UWV8XVO/mjezzoCQ1ZeOCyogzhMpZP7g
 BH8uWfcdZVxXi4VqRbqyvM52dZHwwQ466eHvEMH++eT+5rFEqrogA7MLfuUmsj3CoKBswT/
 UnCtwmMXbz1tzx7XahCC1TBpOeG+wxA49qMivHWrgvGMt8TP+cblXFTyWlKUB+zhzL/KvJC
 TVfjXLF/2fJyKpHxDEpxxzLaWdv+O/zgrdNTaF6zkmnx6FnR4e1DseuX9HLpe4VKs1KaYfo
 iJlUxqINSzuG6p/F7aK+5m0uVWO7UxyTW3UcpZX6+jvneeD/VxKCy5OkWGltjWIoQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
(CR/KR training, hot-plug, 10G link state), and additionally refines UDP
offload handling.

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
 doc/guides/rel_notes/release_26_11.rst |  11 ++
 drivers/net/txgbe/base/txgbe_aml.c     |   3 +-
 drivers/net/txgbe/base/txgbe_aml40.c   | 100 +++++++++++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  14 +--
 drivers/net/txgbe/base/txgbe_e56.h     |   6 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 161 +++++++++++++++----------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   2 +
 drivers/net/txgbe/base/txgbe_hw.c      |  29 +++++
 drivers/net/txgbe/base/txgbe_phy.c     |  13 ++
 drivers/net/txgbe/base/txgbe_phy.h     |   7 ++
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  17 ++-
 drivers/net/txgbe/txgbe_ethdev.c       | 120 ++++++++++++++++--
 drivers/net/txgbe/txgbe_rxtx.c         |  29 ++++-
 15 files changed, 432 insertions(+), 101 deletions(-)

-- 
2.55.0.windows.2

