Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640FDCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 10:25:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D3A340431;
	Wed, 29 Apr 2026 12:25:49 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 5A408402A3
 for <dev@dpdk.org>; Wed, 29 Apr 2026 12:25:45 +0200 (CEST)
X-QQ-mid: esmtpgz10t1777458338tce67d099
X-QQ-Originating-IP: VXYl0IY9s699k8K/857WICqJKdwko6yBC5AUFKBrlyc=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.191.108])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 29 Apr 2026 18:25:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17119186854674467426
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 00/20] Wangxun Fixes
Date: Wed, 29 Apr 2026 18:24:54 +0800
Message-Id: <20260429102515.58880-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Ns4o82esMDegAgRB1NtUGl31x6MdcYr/mCgAOb1In6r/NbbS/k+aG+Hg
 huUNpQBcivv1VRXqwdzvt2Ko2mw9weDY4JsT8qd4vYJ9eTaRkFiG8Q+Eiu+322t426bj9+c
 VPWENJu7zPBrC4TMud4VYqX6pp390YopvBmyboMQ418x3TEDPMtpPuilMQ8WRzLIsuqHqt3
 jx5Um0lSzID6WqSMZ2EkJtrtFi06XZ5V9nXVzKUteruPzeSfGkuE3syz2qbApEdzShuB++S
 XGVHH7LO0sB+UegDtPpZpaEzCm4RgEnAklETvc9DIDTRgECot9rY+bes6/PdvxnRea5eWw8
 FocFykkZ/wY6hulqPkoz/DrW7xM0bczLypFnXN1fkFpfwG60/dpkNJDxj3PPh3zAesClN9i
 8mYaoEGthOsrHU982YFwsMtW9sM9jFNBisP3JyejEi4/bn5TtZ4P0PaCxiVYvKymXx5YZtC
 KlPT0KDVt4xnyLvnouNlU4DINty2IPH8o2tLm2j0rFwRxd8Hx8KbrH8XA5Kc75Yl8+cso/d
 MtqnVrHzKdfUisdDpo2eUk9q9ClRvsReepeetmhhnAHpvTGs7wgEI4Em8JQ0Bl4yTKotXf6
 1Bydy9oleBwbF90q7jdYm1a82wO/2btdtzEVKEbzgHHAaw8zFh6g8/mgzSHxtxXepaXa69A
 y1avhOVgjs9tFr2k8TA40Lc2voCoMh0MkrQRlaBnd3vEuzXHH7ngjTAu+7SitXWb5LC5v1i
 BORafK1oO/DJBgh//rC/FAJwAI8c7rUV+WTjMZg5lqMUgvMijkx33dkHSm1ybMliuuv9R3s
 nZZgN6cDkWHbLvf8GM+zYwRWWpdOZzFxcoyu8ZntRpkjvPJduQJ5oQO0n4tkW2cSdvL+tui
 oU+P4s9o/i/tMprt4jRY02VW/ub5rC+JMyNMeZlVhzML7NQtTdkoRmZG3lxfVZl+al7D9B3
 Q4PCyPHPfcyV0/jzaKwTfJ/SGEOFapaNW9LsQ2bkE4vWUkQJqDGk02NswsxtpRT9Ro/0OlU
 qnf+u9MQUW4dpXk/wS7n56oYJXcRgOPwvcBAWSgg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

Zaiyu Wang (20):
  net/txgbe: remove duplicate xstats counters
  net/ngbe: remove duplicate xstats counters
  net/ngbe: add missing CDR config for YT PHY
  net/ngbe: fix VF promiscuous and allmulticast
  net/txgbe: fix inaccuracy in TX rate limiting
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
  net/txgbe: fix get eeprom operation
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
 drivers/net/txgbe/base/txgbe_e56.c        | 3774 +++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h        | 1744 ++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.c     | 2593 ++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h     |  278 ++
 drivers/net/txgbe/base/txgbe_hw.c         |   52 +-
 drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
 drivers/net/txgbe/base/txgbe_phy.c        |  360 +-
 drivers/net/txgbe/base/txgbe_phy.h        |   45 +-
 drivers/net/txgbe/base/txgbe_regs.h       |   10 +-
 drivers/net/txgbe/base/txgbe_type.h       |   39 +-
 drivers/net/txgbe/txgbe_ethdev.c          |  390 ++-
 drivers/net/txgbe/txgbe_ethdev.h          |    6 +-
 drivers/net/txgbe/txgbe_rxtx.c            |   95 +-
 drivers/net/txgbe/txgbe_rxtx.h            |    1 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |   14 +-
 26 files changed, 9327 insertions(+), 419 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

