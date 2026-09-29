Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F313ECA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:06:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 966BF427BC;
	Tue, 29 Sep 2026 15:06:22 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 6F9CB402F2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:06:18 +0200 (CEST)
X-QQ-mid: zesmtpgz9t1790687174ta4d46842
X-QQ-Originating-IP: HbuEioEzZhYLZuyVbFK6qxZJDtnAyC7WzDj5twp5z6c=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.227.112.38])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 29 Sep 2026 21:06:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1967595296023563391
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v6 00/15] Wangxun fixes and new features
Date: Tue, 29 Sep 2026 21:04:31 +0800
Message-ID: <EEDC8610526E7CAD+20260929130611.4871-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.55.0.windows.2
In-Reply-To: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
References: <20260827114309.10530-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N7MSp95pYuqV39NYdyeRtwVuJL6bfMbN3Iaaw++NSJLmAb5v59UzlmaK
 HJd5H2FqeYPPHha5ycuZznsyn/q2SrPi1edEfXw8ycQL+nOcQCReFJ6ACHMqb/98qVhrRKN
 Z7yjk5f8hoLZsF+D0QSSUta9QrDzXzhW7UG15y97cD8Z7pic2DXvRp5sOJFr87NYY8l2Oqk
 pH1pD9X5tBjn7u2gFMBrNNPx9xi0KEKRJTNYdHCRHS4ovOfB8+7Fv0JBP+OqeahFxPKN7QY
 dCnEMmp0QaAubrerfLvPyLEg+vVDjK2vyHfM/l0pyyYndY25Nl1YbVSYJhqpyXc33hmI7uy
 r94lNO7NWCjA0A8a339X6Gs5ym9IDMuRPHqiZThnSk9hdBGoOjzH1Ul+fSO5eTQ0vqmxxBH
 HKHeZ4mbI56ESRLOrMQ8d0+my7DcR1NNAlSppKafnPhLIw8qTRmp+jCzAx57Zv6v8/9jDVc
 zwvc0Kjrj6nsvSVXsbmqzvN4iI/iuW1dccRAv0AglgIaL+cbjQPVzCCmZY5grCyXYQ07d3U
 LHJFVLoo4TnJobHWi8hZ2VZ+dNXh12SawhqIk1QZwFNR7lgjS6kN5H8XN4EBv6aBXXYVJtv
 qJ458Qi+A4g78LMXNqKMuHI+JF+cUyJRVTzD5nb6cTHo1Gi97oEDebnRi1rWNlWurFjBkpJ
 eM2AbfvlBJpNhvJzQisR6K+SvzH9W3KiJj7LWDQjfdaEhWqmDR4zf5ZFlaY5D0x6JwJf7Ju
 kIaI9cWzAZAd6KjMF0PPdztKVAfixTqclC2YyrPq0cpDTcDMeWYAdZ5md5NHQaEIObHzeUx
 ngRhlyHSpkzAs2oljW/WNJYzPot3Vk9/Su46cChhKw1NyEBObstStZXNjub7TUfVlDDC+/Y
 Yl/zpCLI6Bs2/Cp+vLlPXhpgfHr6RjNkR3cgbD7cMheR7zDBSCBn18NHSJTuuJIa9sOsH1Z
 EI4g+0UGrZ4IlZ8KG+p1jfOh/+pG+OMtY7iyJZiGlLjCEKT65m0A9LxjwbFYdrnZJB1f2pw
 klkrRa4hguv50dA3GF4j+1ZIN5xFccPxR1AAbels2sdZmxdTdGZ9rjnMwJeOnWocm+kVSWN
 v5boE5oh4C52ZvJ2LzGKTxmnajROYXLWA==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

