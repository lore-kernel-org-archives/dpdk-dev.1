Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C05DCD37B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:36:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 571F84060C;
	Mon, 11 May 2026 12:36:31 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id A468B402D5
 for <dev@dpdk.org>; Mon, 11 May 2026 12:36:27 +0200 (CEST)
X-QQ-mid: zesmtpsz3t1778495780tb849f27a
X-QQ-Originating-IP: emc/757vuouv1dbxYtSe5WpYJiP5b/wYL72m1rtE7Ew=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 11 May 2026 18:36:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14071234786604857276
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v4 00/20] Wangxun Fixes
Date: Mon, 11 May 2026 18:35:42 +0800
Message-Id: <20260511103604.19724-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M4uvd3qm0eAY3eGpUt9A/f//RErZCMvE169Esajzqgx6aIIz7LYf+j3H
 eycOpBewSWKXDzooR5P0qt/allzUD71oLA9S4cX8R74FsuRi27cacBIj5TTL+nw+Pco74hY
 ZNhBV5A4udsCGwmaTGfEDHNpJakVHeNxnvzHpStBPzAQxyQS/m25QfBpsLDzptPoPKG1bzm
 kHbmdejiDOwOUWnd0dLwYqRpafQjPQlguTXUDZy1HAeXYPKLiz0o+MAfqjcWrxaLT3J6F8l
 5KrH5wh7VflCCjTu+9B5l3T0vCxWcsEm1JheSc9FWlK/fnoYQikV6J19ZhZNLpc8GkjQ8Lv
 +VkY50boD0BWhPADoFATT0lIY3Xwo8vGacxkT0PEUwAxjEhkMJCK6vcgs05c7+gzbgPeiV9
 AvJmpREQqx7MHB9Nls/gI9gfrlNblD7id4puvjQmPzK9ci/2ihQUYo0/MppXL/OicAj5TvZ
 yI/eJLKMVP/Hcm6sOe49Ef8aEPkNN+d82zlsoj4TmX/chm99fdciUWPEPNvhBk2nT668Ng9
 RIRcjLEXfIxVHwP00ZXnNjdJ6+Z5f2JJZCkMwzOCRG+SA9DkI0J6QOZ82/Rz3b7YtREHIdO
 nRhdEb5WfHkbgGr3dun7NpGGAyzTBZcwLVpu1ftNFd/KhENTBgmpQi8C3lg7qUJ7B6lBTFX
 qwaT8I0gWuPo0kfYlqoVrlQqY6SW8V6douTWJS2M422WntysQ13qgep1LP9VOLWMtPHH5Ue
 SBbHN/lUz86rUTEyj6SfbEwgNeK3z+B3fRzZdVQ/vjLHuxIY40/9sBlS7DG8KTzome8o+al
 JBBeMz9vh/GchIqysw/+RDyF5JiM+0zhJG8nsLLFSB0Y8+MPZOROPNb5OmIeznO76N3/wlp
 Ie9DOzSKqtmhNhHZ4377zMbsj1lywN+oevB4d4mJYJ4RJd2dyTv+qZB3tPRZfw0MKfE+gbf
 qDJpbZ62ES4QrbhDhRX4hDkI6zVrOmUQmQbyfutGynbz7gZRNOXU17D+A+Zxz4tl2FIyM52
 mI9ae0HU4TZ3e+7NwAsmSqGGZydxX+lQQcpWNyIJC8+hAiYnX/kzQDpRsDHwQ=
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

This series fixes several issues found on Wangxun Emerald, Sapphire and
Amber-lite NICs, with a focus on link-related problems.
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

Zaiyu Wang (20):
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

 drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
 drivers/net/ngbe/ngbe_ethdev.c            |    5 -
 drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
 drivers/net/txgbe/base/meson.build        |    2 +
 drivers/net/txgbe/base/txgbe.h            |    2 +
 drivers/net/txgbe/base/txgbe_aml.c        |  187 +-
 drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
 drivers/net/txgbe/base/txgbe_aml40.c      |  113 +-
 drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
 drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
 drivers/net/txgbe/base/txgbe_e56.c        | 3778 +++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h        | 1748 ++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
 drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
 drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
 drivers/net/txgbe/base/txgbe_phy.c        |  360 +-
 drivers/net/txgbe/base/txgbe_phy.h        |   45 +-
 drivers/net/txgbe/base/txgbe_regs.h       |   11 +-
 drivers/net/txgbe/base/txgbe_type.h       |   43 +-
 drivers/net/txgbe/txgbe_ethdev.c          |  414 ++-
 drivers/net/txgbe/txgbe_ethdev.h          |    6 +-
 drivers/net/txgbe/txgbe_rxtx.c            |  102 +-
 drivers/net/txgbe/txgbe_rxtx.h            |    1 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |   14 +-
 26 files changed, 9366 insertions(+), 434 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

