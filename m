Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556AACD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:20:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BCC840289;
	Tue, 16 Jun 2026 14:20:48 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id D66A84026A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:20:46 +0200 (CEST)
X-QQ-mid: esmtpsz20t1781612441t58fafa58
X-QQ-Originating-IP: 6B8ymhQIvpNL60+vgTT7TXaajm9Tp4ZPoJyuaq6jAPI=
Received: from DSK-zaiyuwang.trustnetic.com ( [183.157.22.210])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 16 Jun 2026 20:20:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5004394259853962890
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v6 00/21] Wangxun Fixes
Date: Tue, 16 Jun 2026 20:20:08 +0800
Message-Id: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mvu/+zcoa74xeg4Moi5/kYkE5kY+W/YdOLOWyIKSxNk4i6YrIdV8oyC4
 Hzollt1g3oD3OFfh9OJlY3neiGD2ymV89d7qlyvTMUFOFzkgkFMnSxvPvtLglkIHvimA/fh
 y9KN4cZpfiw+SoG6pKNMcsJ/gDzUVBrULs1Ip9LavGy4nZ2epGjrwAOknPitud0Hv1vy/kd
 CFr/7aPB6MjVhX3gErOvhNCAjR8AsmGUCWJ+Z5pYmRlwk4cfpqcFSwW42J2YKX7z340WvtM
 FYhORz3gPbKHve6/21uzr11bq6ENTD6iSveXXEp5irzfERJACh4ooNYMMkZ1gHciMZpjLAD
 dDGdheZq/FcIap44QskOeG0QSden7IDFQoR5h3mOAYv5N8W1jalxy57JTiz8c8soMkTN+/f
 9I+sll/NAesnMG6nN4axzLh/xDg7pMTLq9TfyeulvuTx5a2jAm00gRnQ8rXi0VMwjf+6OPW
 IG8XwRapP40+WOZhEZW5zs+bDqgwxO7lUYSsuLGvILW4gNKlMmcTH8cCFr1O3Dk6E/KfBNz
 LA8WEeaXzmPmlMdWl13nSgCGtYuW3lKDoKaIl+hJXsEZ1e4hlqtnt6nQlGRaley6hAelpIA
 RvmMxmhiDPiDjAnZo/m+b3d5qPsuWxqc/E6hp3I5mJ5xAJRKNzylG1phH2RNvZx+OFYUcM3
 WFmz8VSSUGbMa8wcObsdTu/vbWxi3TKtZSlAUy4+WwFMT01CQEJKvbgASz6tMVN1foq7gjk
 Vorlz6FqCk2cH1JZesZ1ds2mj5vHcqR8/94LstNMhlh8Lb1EUIu49mldHhoUSAGUCV6ktTq
 HCPxyZ+8/jC4kydk5Jvc++kOJD9WRCeH+ZiOTIBT6TzKlA4iBBnJ0yXuGWBkbEKW/1/nAO0
 d8C9yaNAkS3g+7oumWqYQJ+rHC0UJVmJvzVrHBzRlkS5us9bBsUdGN3X/7eM2wzBq0H+q5+
 7r4UBNpJKgaKKE0QTSuGHY1A4ujyGBkmvObEN16pC09SWummiIalE+PbEicW62okbRydDcb
 +85AElKYvxRy2fRkeRwu1TxhTqJHIsOwrQz064nr3onqsEcQc+OL75UgumGhAGRXVhxg+1N
 w==
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

