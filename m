Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC1DCD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 11:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5AA84026D;
	Sat,  9 May 2026 13:28:41 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id B359940269
 for <dev@dpdk.org>; Sat,  9 May 2026 13:28:39 +0200 (CEST)
X-QQ-mid: zesmtpgz1t1778326113tad27ee93
X-QQ-Originating-IP: Xmm64AQtdpX6HgI/sSSQV0QPkM5FqrK1QVt8WCx/sD8=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.204.251.157])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 09 May 2026 19:28:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11337703613186777736
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 00/20] Wangxun Fixes
Date: Sat,  9 May 2026 19:28:02 +0800
Message-Id: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M2OfKeMHoPgxsPAhTgxEybAfT++2x3EdVz6phkdXzWtqorU2aq7NkZ9r
 kAZkYWJdyzf5D9rOIrYWjhEr7VmtbvZqjJJ0oJgE7zgWclCgRKn0ftt01/qn0y7+oZFVKXZ
 cjhRUq0d6VQ23ASmhYQ1pXGqrJRMYOf8P1QDSdHYAYZVC61AVndAH2FPVFviVM7KEKcoUql
 KvrF4U6BUDW59KNagrLTkTz8Pb7vKRfBwjGS2mQ7TXIOQDqkFcXnAymfKnXpzLeZIarIm3G
 661E0BkIX5EJx8hDhMzLb6H9K1IYNwUwfhFjgUQ4WIBd7wqiMnLru8k5XpT1qykwSYc0ggP
 RycsPc/NzZWfpIx6x8K8Z1kTLvJg238BsgpzR60xxMjJtpPctUuR9VsgnUlZh86WWekCpar
 rQGFOlG/6QrbJqvKYPafWxlSNSlXwFZTPx+w40lleV89OhrTHBVtCAcN3RcufFpDkAlEl7t
 v4yGSqjO2ML15CziwupF7MEaUri3sEdHV6+j0YEwkjKDCGk6kvBeaZN2pMdJw68xc5UbbI+
 NodfymydWgUTkYIBmCmN4d9TRp5bYTAOZZeGKmvAQ3Y+9Nw53MW/CI6uWoh2wUYd8wEt2vn
 Kjyk9Puk/UVC0PSiN4UklJbTU6pBtzqtFiFUlT+3wzKJbjwwpFOWb8XlpGoJIMA47uPyQ6u
 XkNCBwLUXi5pXprDJJiaBsbjN5JAk+aym73WpDXgau5T/OlLZ4h0y1wJMSTSWxauqRgGWEQ
 qFfyhtaVpRF/LkzN3AzZeVytNCYq1rlgH0QNpGlb3ircpkNg0g2Qcsq0Qp/GOBpk/QGmfa3
 UYnsKDIs3zhKCwrzweZqwULBVnB5g/8vh0NtPvnjetqUqPtQzwBwh17xTFZflgpRfVZiU5v
 IIAaueGWO5opt6pVKL6IiFtYaTpjvRTv/fNwRAUhQCvy9wlvQmyJODHuqtiNJ3NBij2XO/N
 f6FAzJkKLvTWy0WYEudwaO/6gUMlcoe7JKT+mo/GRITY+/hv5Y90UzHGM5fJ9BKpEAyfD1e
 t7JN6eHs+BhSvhVd2uSnZ+KvSi/6woK7vnnTt6eYL6G1Us8dOClTmjjf/gaAsBOmmpV6dV0
 rnbwazJAbN+Af1H7OeWgks=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
 26 files changed, 9350 insertions(+), 434 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

