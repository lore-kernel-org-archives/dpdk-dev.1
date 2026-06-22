Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5DBCD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 11:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D2FF40150;
	Mon, 22 Jun 2026 13:11:34 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 5120E4003C
 for <dev@dpdk.org>; Mon, 22 Jun 2026 13:11:31 +0200 (CEST)
X-QQ-mid: esmtpsz18t1782126686t8245015a
X-QQ-Originating-IP: fIT1Lg96KBNEUDJfptofRCgw58iOJd59kiV9K3G5RK8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.248.247])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 22 Jun 2026 19:11:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1458676141102125332
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v9 00/21] Wangxun Fixes
Date: Mon, 22 Jun 2026 19:10:48 +0800
Message-Id: <20260622111111.21024-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nlk+mlzF7d0MxNwvdkNWdbgQyyHmW3XvPOJGigcLeVLc05XS1oaEJ2bA
 0j8ee0v5mUxgqpPECMJdd7qGb6tkI1jW3iTkLUPFV9Vr//UddOVBKg4Cav7NWYETvVuCSAP
 wQ7Hq2X26WCSe5UfM+zIl+bQho6qDmPZ9dzs43lIV8DqDOohmV5hkerUnunzolGgwqceS5u
 naK8W1ntXpri7BeHgjIZ0IRXLyJuqW20beARmgVaBKmRj74rz+AYUgYpxCF0ERXXfQslZ/A
 bBvdjMAoG6mYOunQEZUN80yoDgpA2JD2jptelMR259ajRLe3DniJ0ChlzFf/doUgLnsXgNt
 gWbnplGkycGJ/fY8mRMWJGGyG79c9i59DtFL3CIGfPTczWHbr19jB5IIPsMVmVhqBz2rjF2
 dWkr3l4LogIArpw06JdnM/HP4lyRhW9PEmjGiQp7KrB8sPTi6yCw42ZCMiPKJRL/ggSwh+S
 nnynuTYiCISfLLKGLQKimV8JMAWC6tiRk/BgbVte73/tXaMbF8KEz043KpBq1wiMkpb6W4b
 z71JjG108J+nPp9OwmJfY1fmZbdVBB3wpI3Qm65XXlTrzYxLqCWTy6Q29Ftr9oODzKWi5Ll
 yZOKvULr708XhAvMphYx83HiWSeirevLets4NMxXHY0fZkVV+WAE/AV6000cMwJPYZnBalm
 U4MTCqimLi94DDQ8B8NQZ+tdoQyS17wW26cLPEj4kfEYrNggrsSTn8JzdS++BM3u/Alxsgb
 UuVPTdqRrLSRg2K56QscsmO3/4eBNYHq/hiMDYheWv25zznOVOWkp+mBDi5kCYq7lIuXgRY
 JkHqgYb6x4pNd2FO3EalK16BW7hx9fiiAFnwVHvnbynoV4F12nyNtx7gN4U2pbRZUoqBgLk
 C9ALT3e6/IBWiF72tFcKdECS3eIMYT0vsMtfPvCaqnP8zTsmRBwea8I4/x1PzvVPrRIWKMG
 6JId7lGyEOAe46YXK39MCWmz4X2Wnmc4zXrji5Q9AJF2dLFQSG9KWfp3vp84ivxJUrTdlWK
 B/VknKcDSy93+OGUA1BkL14PFfdbOMCXbiv12NzQQo0FVyob4cv3teRlD7ocA=
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
 drivers/net/txgbe/base/txgbe_e56.c        | 3773 +++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h        | 1753 ++++++++++
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
 drivers/net/txgbe/txgbe_rxtx.c            |  109 +-
 drivers/net/txgbe/txgbe_rxtx.h            |   36 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |   17 +-
 26 files changed, 9464 insertions(+), 444 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

