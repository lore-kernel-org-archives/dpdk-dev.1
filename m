Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28D5CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 13:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD88040285;
	Wed, 27 May 2026 15:03:05 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id BE30E4026C
 for <dev@dpdk.org>; Wed, 27 May 2026 15:03:03 +0200 (CEST)
X-QQ-mid: esmtpsz19t1779886979ta20d7ede
X-QQ-Originating-IP: 7SKQXOg0sob36Ku39/z4uHTyHcTFdQtAInJhKxlXYPs=
Received: from DSK-zaiyuwang.trustnetic.com ( [122.231.28.113])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 27 May 2026 21:02:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10933326157804742149
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v5 00/21] Wangxun Fixes
Date: Wed, 27 May 2026 21:02:00 +0800
Message-Id: <20260527130222.24348-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NWujniBqiFoN1jkHvqNT458V4yK61NNw7d8WJm3fBQycCzIPP8cPM42o
 forpitTOAKhaeD5uFmHzrrfiMMfwh8s3ne4BEQC1hUZ9Pn7QT8fXBZ/D07w09gYsiTb30ct
 UMnV/chHO/64dieoYOX8uD4+w1UqldIK36LX1OjEN0r/XsZBcddYLJYENZzLYodhHac7qSU
 lffxPWaVV6fiGVBJ49J1uRjm7KP9ZrCI3qgcLUZzaHYx8VmkysVHNUhip8V1Q4bAXiJy5j/
 Esj7hEzv+zM6L5kMi/cEeB4FQ+7O0lZErq7oog55CIU33YtgUbPt3v01TJx7kfn1UEnrZes
 O+t9MuH2PLncT38yUIN9vSSTyX8zXUZBWrfHaOaNx1Ueh5P6XZFQBy9RsN3t5SZJdP7ccyl
 TwGSMHObcBn1h8g4RrE/BqBjdNyqaTqgX6QPnJge5qfnvItndpLdIVNETZJ/h2WRpzCpE/Z
 +BJGeBcVzjI3qE1H+AJlSUrwUTXbkc2SuGqDcq54suA3OTsnPV+w5Tldk75WSnL0fgpumB/
 4ccg39OC5kK6myypCjKu8Ko/FvXQs9O1V8CztXa+Lj1UVFs2wGImwRJAOGWi62RjFZ9rpE+
 nBcEdGvYb1tF/7M4tQ4kHWQlnSISMbQmMFP5eqku2hlocX4LhX8hhi+akfDMN4fLSkgmbON
 i5kO0jBVmzTh10gDhigI6wyFPlNtQAQK5DVPH9FCQxHdEleWVnecTXEaGOPlP2cWoQYzav9
 SfYGhy1zFStbTjxY5+Wke9LP5IWutYnVq6BQmAYQIVCupvDVmIUbKD+xq34nx3JZyN2Tumh
 oDh4Gx8dvcQvu8qWt34G9lTjRwyN6cmoUBuKLVV68jyTYn9eCFWi/g8kdS55S5VfHI1rhfB
 6Cu7umvuQ16TKiVsfv9Qs519J3NLxjdX4IrtsiTrEXDqx0ucbMws5vP5OeCQuC6OBdvYAnX
 Ns+oUKgCmXgADxSSoewy/CqVMfFzwLPy0ppTu6gUEo2sfxl4/PurgHdB/Jr9+fi4uuL54Kk
 w63DQJRV8GGhHx64eADoJRdfyM+wBIOfzoZ5eoYeiIZ5TCpYbpifMX9ngcCwaiGDtGjx6dm
 g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
 drivers/net/txgbe/base/txgbe_e56.c        | 3773 +++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h        | 1753 ++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
 drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
 drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
 drivers/net/txgbe/base/txgbe_phy.c        |  362 +-
 drivers/net/txgbe/base/txgbe_phy.h        |   45 +-
 drivers/net/txgbe/base/txgbe_regs.h       |   13 +-
 drivers/net/txgbe/base/txgbe_type.h       |   43 +-
 drivers/net/txgbe/txgbe_ethdev.c          |  458 ++-
 drivers/net/txgbe/txgbe_ethdev.h          |    7 +-
 drivers/net/txgbe/txgbe_rxtx.c            |  107 +-
 drivers/net/txgbe/txgbe_rxtx.h            |   36 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |   16 +-
 26 files changed, 9445 insertions(+), 445 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

