Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEE9606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 11:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E7E240658;
	Tue, 27 Oct 2026 12:42:27 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTPS id 513EA400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 12:42:24 +0100 (CET)
X-QQ-mid: esmtpsz17t1793101335tdc56bed6
X-QQ-Originating-IP: 5i+0U5dVuT6vQddI67wlNvvRDWGs93YDz9rT7Fs0xt8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.25])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 27 Oct 2026 19:42:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11146231481677314982
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v12 00/17] Wangxun fixes and new features
Date: Tue, 27 Oct 2026 19:38:16 +0800
Message-ID: <37BE95FD3C16A889+20261027114218.9724-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MzNwb/pqyJTksdJc5kce6JSdTrXgCwR4DtnR1ynHXs/HQStP57xZBQ/i
 rP37y/skyMwICLULlrscR86JHVH3Gxb5UqJHfIVxjwF+3tTdQJb5sd6k21ZYCD7BkqY7wm1
 Dezc08HrkGfH0z+y/kvQ8J7cD4P64chSsmDaqE/A3O5Mv4se1xN/QUkSUNaxz83JFiwdJGL
 4YstgXLXsq8rdGX51Qhk2wGOUhYz4mdGzQDCvdbA4grHDeWH0kuopAlzEnt7oT11BwXopON
 UbLNs+C5OlYy9JrtaZMuqbAsCEva82rBsgKUTa9L/K2di4hxVFehWyU8Rzq8h2lmVSAOwgS
 61Lu9A3IP5UThXqnQMmIXZUGXOnYFO8DgVXkQL7Za7rT5xhZ3U7q+7f+9HIS0FvrU9urbqB
 gGuUwJS7ikjA2YdKOO8J4B5SztG8hdJ5jQzxqOHuMPWzQLkzgvIeUvKy/JqkRdPG5b0yxu5
 k+nHkRzSHeeOZakMP+2DYdFbZbk3RoAn6rYLaVoiRNnkV5MMngLOLLnZt4YQd6s3RbD9c+A
 TarXqt2n2YXIXoCu8/CPO0m6NzEjDDf3q5BS4/pfLCMy3pShQPRJlWGhUgZWHGMaVO03Rbu
 TcZnX2XMKSTT1VCdr0xpx4s0FBr0nkQRhdhL/6A3LrcTgjtdgGhUDbiQunHvnjiwEYpovf/
 y04LGeRSclxP2Auebz4ysfki1rvpJz/UwVn3dZYvPbbr+FTsfa13AiHQAhy82Q7OtsUkZvC
 c53uv1XsCn/dzSrRzpzLnbXAgLQmLjsnxpKVgo5WdXFagNrSC0kX58IhcYLRZfmfOLdrrlZ
 X0ZFkH9WszCRIblU7GPwlFAfZNSj77jL7OjlI1Uir5jZlx6WYPKn51FaqiTOjykpfVAkMlU
 z+oYNJ3ZBbfojYwrf2s7gDnQUQWLmE7x5B6g9TLaW8xEgRbi4396Ip3RYYWmaB5d4jnmc/H
 S/nFrV+MxTg1jl6+3cGSCCg/ahhDizJJUW+5LNrjo5txVdoV5dYq9nwQeatUYcYLiwol5RC
 RobCTkND3PNJyKqieh5v/tpU9wtp51Cndn88hMTAhdHtDM3Xee+elvL+DY3nw75czXfDO/D
 RMj3hC1Cl9P
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
v10:
 - P12: check the FFE taps against the register field width of the MAC in
        use, instead of only for the 40G one. On the Sapphire the main and
        pre taps are six-bit fields and the post tap is seven-bit, so a
        larger value spills into the neighbouring field rather than being
        truncated.
 - P12/P13: say "Amber-Lite 40G NIC" for bp_capa and laser_off, the only
        MAC that implements either.
 - P17: add a new patch to rename fiber_suppport_speed to fiber_support_speed.
        The field was added with the misspelling in 234ce0d1fa, copied from the
        out-of-tree base driver.
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
 drivers/net/txgbe/txgbe_ethdev.c       | 272 +++++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h       |   2 +
 drivers/net/txgbe/txgbe_rxtx.c         |   1 -
 17 files changed, 572 insertions(+), 143 deletions(-)

-- 
2.55.0.windows.2

