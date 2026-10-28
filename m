Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F9606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:40:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6F7402D4;
	Wed, 28 Oct 2026 11:40:08 +0100 (CET)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTPS id 4B9F0400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 11:40:04 +0100 (CET)
X-QQ-mid: esmtpgz13t1793183996t74875985
X-QQ-Originating-IP: kdo1qewovU412KWafC+PhPH9NjgoGEtj1Q1H7KTBU4w=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.223])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 28 Oct 2026 18:39:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12094392079990596239
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v13 00/17] Wangxun fixes and new features
Date: Wed, 28 Oct 2026 18:33:49 +0800
Message-ID: <7BA93C5EF438D3BF+20261028103913.10188-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MCg5+ArSTX6cbWEPlG9h0e9xyAz1o6cEJEO72D7VDffccxcEubAXnrS6
 E8zInDHTN0ntz5kmSG8nYcyNWLkdgSefKO4M6jMUcHU9hjVgUrtHX/TGX2iE4bmbCaekrLL
 XX8TgwZvX/ev5fStigJ5wt7859gvf1nwDUjfROWLJcNaT/gz2SLdYPxjBmnxcha8TJtQz1O
 EQFmbUrd0Y5qpXLNKHkFaDf7dx5froUWDHz4NvKZAUr+puxW7kOyhvk3GqE6DgDoAdmLskO
 J6/ehWdYbOwwX26o4XtOSjE0p5T6Iv/0XTIOA8WiEX4PFEpESbOeHlMtcs2vNDsX47cR1nJ
 gW98IgzriP4vUDYNtS9myLmLzqUo2K78ZmFOvzQmJpqaziVlsfd5iS5wDiXDFTC+HafMsY/
 d6B8YV0hrfLX5FVBvKBspZUgr9bIbdrPfaYkgHB0VzUNp28jSJK7xEwSkri7ZAFsHjT4gLF
 AMqecb1riwYFh/KKJFxN/s7N45BDYC8GBzfhbQzvQMThGEqIHEhKZrV+mKXCkVaWP6p3zju
 nEqKm5OodeDTN9G5g6NOC9QDfJnH2HjZThuT1i9CoaOXZnGLNOvW0/S4+87I+OpOZYZpzp5
 UjAS4RynE2ElVw7kEEpdNt3aMq5uuXar6LY6Qln7p/z6cwT0PudAuGCU/XbxvthTqkBOlIe
 toTFCCsRjVg+H891sowPNL18IuTzwwetuJMyKNu3NMNLVzZGQw1EYpkxXkN58i/Ws0DUJ5G
 c+48S0G31kT71MY8WWzRoZ4aUKnZjCNpR4MjL/Owaq4liIctBYM0pAvNIUlamZRP1M8D06f
 /McHtPF8TVQhstqg+cgjESWeSIzVqOVPFl8gv3UPfEFgHNGwrUau8npDlNPdNZ8Pc41/Wpn
 HGZmNMRww5qWgltk0z3tBQWV/rY92ZHVZx/Jji1Z9oXlNkyKYFg62S4o+SUoxVu8GVwOEIq
 9LfJrQ54hqqs4hc0judX2+6391mBxIQoceJJz4jd7DDLsQ39GqPjSO72GAiPvpDG45VngHT
 eGa8GEN1RIXLDmQ2BoHBPeSyKyBetd+PiFIGRyMm7qOu/eFyXk
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series addresses link-related issues on Wangxun Amber-lite 25G/40G NICs (CR/KR training, hot-plug, 10G link state).

---
v13:
 - P16: gate the module poll on dev_start as well, so a module inserted
        while the port is administratively down is identified but not
        configured;
        run the link setup on link-up for both Amber-Lite MACs, which
        the 25G path did not do before.
---
v12:
 - P05: pass true as the restart argument to txgbe_e56_set_phy_link_mode()
        instead of deriving it from the link and AN state.
 - P12: declare the per-MAC default copies where they are taken, instead of
        initialising them to 0 and overwriting them.
 - P13: limit the enable_tx_laser() call in the PHY init failure path of
        txgbe_set_link_to_amlite() to the 25G MAC.
 - P15: drop txgbe_is_40g_fiber_qsfp(); its branch was identical to the
        else branch that follows it.
 - P16: cancel the AN73 watchdog before arming it again on link-up.
---
v11:
 - P12: fall back to the default value when an FFE tap does not fit the
        register field, instead of only logging it.
 - P13: change the patch from a new feature to a fix:
        take the transmitter down on AML40 link down. Clearing GPIO bit 1,
        which holds the module in reset, does not stop the transmitter for
        every DAC cable and QSFP module. The laser_off devarg and its
        documentation are dropped; link setup runs again on link-up to
        restore what link-down disabled.
 - P17: fix warnings in check-git-log, and add the Cc: stable tag that
        belongs with the Fixes line.
---

Zaiyu Wang (17):
  net/txgbe: fix failure to configure 10G on dual-speed DAC
  net/txgbe: use the requested speed in E56 AN setup
  net/txgbe: fix E56 PHY configuration error
  net/txgbe: fix incorrect link state in 10G forced mode
  net/txgbe: do not force reconfig on link retry
  net/txgbe: set i2c sda hold time
  net/txgbe: fix link speed display info for 10G mode
  net/txgbe: remove stale outer UDP checksum offload flag
  net/txgbe: fix SFP hot-plug when auto-negotiation is on
  net/txgbe: fix DAC hot-plug on AML40 with auto-negotiation
  net/txgbe: fix 40G FFE tuning applied to first lane only
  net/txgbe: add pre2 FFE tap and backplane capability devargs
  net/txgbe: fix Tx laser left on at AML40 link down
  net/txgbe: fix CR/KR link training and recovery
  net/txgbe: align link capabilities and DAC classification
  net/txgbe: respect manual link-down on Amber-Lite
  net/txgbe: fix typo in the fiber support speed field

 doc/guides/nics/txgbe.rst              |  25 ++-
 doc/guides/rel_notes/release_26_11.rst |   8 +
 drivers/net/txgbe/base/txgbe_aml.c     |  11 +-
 drivers/net/txgbe/base/txgbe_aml40.c   |  62 ++++--
 drivers/net/txgbe/base/txgbe_e56.c     |  19 +-
 drivers/net/txgbe/base/txgbe_e56.h     |   4 +
 drivers/net/txgbe/base/txgbe_e56_bp.c  | 196 +++++++++++-------
 drivers/net/txgbe/base/txgbe_e56_bp.h  |   4 +-
 drivers/net/txgbe/base/txgbe_hw.c      |  31 +++
 drivers/net/txgbe/base/txgbe_osdep.h   |  12 +-
 drivers/net/txgbe/base/txgbe_phy.c     |  42 +++-
 drivers/net/txgbe/base/txgbe_phy.h     |   7 +
 drivers/net/txgbe/base/txgbe_regs.h    |   3 +
 drivers/net/txgbe/base/txgbe_type.h    |  16 +-
 drivers/net/txgbe/txgbe_ethdev.c       | 276 +++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h       |   2 +
 drivers/net/txgbe/txgbe_rxtx.c         |   1 -
 17 files changed, 575 insertions(+), 144 deletions(-)

-- 
2.55.0.windows.2

