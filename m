Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A136CDB471
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 11:53:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9E734025E;
	Wed, 24 Jun 2026 13:53:05 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 7F0DF400EF
 for <dev@dpdk.org>; Wed, 24 Jun 2026 13:53:03 +0200 (CEST)
X-QQ-mid: esmtpgz10t1782301978t87644a27
X-QQ-Originating-IP: krK3BbXmVApgYmonqgWs1p8ayU5w1gqrqybV50zHXKU=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 24 Jun 2026 19:52:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2076769200693753340
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v10 00/21] Wangxun Fixes
Date: Wed, 24 Jun 2026 19:52:32 +0800
Message-Id: <20260624115254.20348-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NRkWGnbnkwTmFYh4AMAuH+pK/y9hipphO+lh9FBfbdy0KjHoejzIchrh
 CGFumOw7N0GO05NxwQtWM65dxz/ZrB40D9QgR4nIFwe+tc8NGWU9i3rjmPoBJ6ajTtPu/RR
 wYUPsuwsYzlP/JmV3LDVW/8g/z9tOtjSgaPlIYcP1FJSDFesj3hr5d5F9m0zjEP0VSqHSAL
 GLioaKB8yYoQz0Q/OHOsiSfgshSa+1Q82gKgzu4CVicQsEioqMhnpbvjjhaqzyCUQLFzOgf
 BE2RxtnXfcwTFt5ea+yEoW49xvMNPa4dDh467+j5u6VtO8IUEMe5aAFKcEwMezOntS88z4q
 BbCmBLZsprr2YnMni/i6ctIauil6Wf0+o1KyMX+TdoFvyCyWYh+yYcWBoIgrVI2rq58udA5
 uXOutAu5bALQn1nfMMKx6/dxlxY2fj4z+MscdhD7654lIamZFss5504UVJAd1XzBBwgIF4j
 wtQfWEL5V4zYyLUIoh8siTWKySJKGZHwntak2yu8mAYRMrtkq6qKpo84KUEM1LTQBYLZApR
 E2gm5SDNZZN12bP7KQWwbQgKusUwNT1O62ZSlc4cT9cQaWq4c3P6mWRT+MxFcFQ8aMvnGwS
 cFb2zUPHDFI9NGXUhgvvOJ9S+c6MV0WBHFj2eJDt9IoY6lZpIkThY7useS8YU1qjpwMsJjK
 bgyLyPrv5JNe8EuOSwCX2kht5yMMQFzuMU1hwRJfuiGQeTwO8ECjGPt2kRh3kyngYzcVQt6
 HE/RQKlsA76Oom+A4Y74wRKJqrkiuXClvpHrxzf37hUrSOsDP8RA1vV0MdPN/lWLdoOQxH5
 0T7b02geMSVMmicSJR6UszPMjP65l9ZgI2MlycJeKbiVtVqilvhyXuPTqb1fdsazF+nqS4Y
 R4OPiNkBAMAbYpr/Tjf2gFco/LIMstE+7WE32l68riaS6dPDwqqJ8zVwhR9cKnQPZtmuSKr
 cEFeFXLRFItPbGRyU0VTes+mn+2Pkv76tZ/eIaZM6cpPn16FV/m1097Xqg0g8L3wnI9QC1L
 NnEci8TlQgyJGZKRx9z+f4K759YBNsQDQ6SAz7F1J+mvwGis4TtZ8piG3z7+SuUC7Bjm5RZ
 mdWhikO5AaB
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

This series fixes several issues found on Wangxun Emerald, Sapphire and
Amber-lite NICs, with a focus on link-related problems.
---
v10:
- Fixed compilation error on clang
- Renamed unprefixed symbols
---
v9:
- Fixed several checkpatch errors
---
v8:
- Fixed compilation error by replacing RTE_ETH_DEV_TO_PCI with RTE_CLASS_TO_BUS_DEVICE
---
v7:
- Fixed inverted semantics of is_flat_mem to match SFF8636
---
v6:
- Fixed more issues identified by AI review
---
v5:
- Fixed issues identified by AI review
---
v4:
- Fixed issues identified by devtools scripts
---
v3:
- Addressed Stephen's comments
---
v2:
- Fixed compilation error and code style issues
---

Zaiyu Wang (21):
  net/txgbe: remove duplicate xstats counters
  net/ngbe: remove duplicate xstats counters
  net/ngbe: add missing CDR config for YT PHY
  net/ngbe: fix VF promiscuous and allmulticast
  net/txgbe: fix inaccuracy in Tx rate limiting
  net/txgbe: fix link status check condition
  net/txgbe: fix Tx desc free logic
  net/txgbe: fix link flow control registers for Amber-Lite
  net/txgbe: fix link flow control config for Sapphire
  net/txgbe: fix a mass of unknown interrupts
  net/txgbe: fix traffic class priority configuration
  net/txgbe: fix link stability for 25G NIC
  net/txgbe: fix link stability for 40G NIC
  net/txgbe: fix link stability for Amber-Lite backplane mode
  net/txgbe: fix FEC mode configuration on 25G NIC
  net/txgbe: fix SFP module identification
  net/txgbe: fix get module info operation
  net/txgbe: fix get EEPROM operation
  net/txgbe: fix to reset Tx write-back pointer
  net/txgbe: fix to enable Tx desc check
  net/txgbe: fix temperature track for AML NIC

 drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
 drivers/net/ngbe/ngbe_ethdev.c            |    5 -
 drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
 drivers/net/txgbe/base/meson.build        |    2 +
 drivers/net/txgbe/base/txgbe.h            |    2 +
 drivers/net/txgbe/base/txgbe_aml.c        |  185 +-
 drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
 drivers/net/txgbe/base/txgbe_aml40.c      |  114 +-
 drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
 drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
 drivers/net/txgbe/base/txgbe_e56.c        | 3746 +++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h        | 1778 ++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
 drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
 drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
 drivers/net/txgbe/base/txgbe_phy.c        |  362 +-
 drivers/net/txgbe/base/txgbe_phy.h        |   46 +-
 drivers/net/txgbe/base/txgbe_regs.h       |   13 +-
 drivers/net/txgbe/base/txgbe_type.h       |   43 +-
 drivers/net/txgbe/txgbe_ethdev.c          |  472 ++-
 drivers/net/txgbe/txgbe_ethdev.h          |    7 +-
 drivers/net/txgbe/txgbe_rxtx.c            |  111 +-
 drivers/net/txgbe/txgbe_rxtx.h            |   38 +-
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |   17 +-
 26 files changed, 9464 insertions(+), 446 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

