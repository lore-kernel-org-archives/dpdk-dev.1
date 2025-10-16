Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E96CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:19:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 773FD40A77;
	Thu, 16 Oct 2025 13:19:22 +0200 (CEST)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id DA7E240BA5
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:19:19 +0200 (CEST)
X-QQ-mid: esmtpsz17t1760613553tdd65fb07
X-QQ-Originating-IP: 1U4oiS56thLShRYEixFCkzFbmSphmiwoV/XBG9GP4hY=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.206.160.146])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 16 Oct 2025 19:19:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14747554848895732516
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v5 00/21] Wangxun new NIC support
Date: Thu, 16 Oct 2025 19:17:14 +0800
Message-Id: <20251016111736.25372-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MbbI5maliJ7oNdLG+mFah1+UqPB5K9+vQdWp4nQ8XxWy95Fe9Sv2yitb
 cJJQ1EOcJVWqTnuZkEXqd9pdycrNtr8T29+mdKP8I4YJlgWIhdZ+LG20iYBQy2nJeeq09M+
 9jX1a2O8+dqRIkWf7XFInolQmtlANycj5geo8Ke33tjJ7vA5CnzwIvkIJdPDu633/taDw6b
 4NMYr0zSufLuOMEwIZobVOv6LcC3pJRffgct9Tmlyul+SWOC6WcRZap/oK5Y0npCJ25jeIF
 DxdgSSJU7avTn2uAApKcNBEDdzzW0IEZzrfJfMgWCiWPhZ0fKxsoBQ+uwnfCGXGdJMV2Y9S
 HZgCToQTbhBuRDUFIgVNhB9W1dKKckHPtsZkpVmIHYTb84lcyb+RrKVlqnIe1i+Vr3/xO2i
 UtuODZJ/RcQ1U4HQbQA01ruLGoHfJq/+UU+LSU3XJv6OdACZANXSVvNUm1qKtPkotjDCmbX
 vLnRtRW3f4Tyvc35PwFWzmt3z+wQfOcyx4FKEnWojaiqsqcPCeQ54xktJuzqq2NYzjipheL
 Q6esOJcyq0mynfh0DshdhJugJNjzPG4yeq7A1QNoBey877bexPLbUsUHM1ujUoklafJIGFS
 DNXyA7U9FzWtKmqcWO0zTnQPtJs1CUJzGdc6NxuNt0AhUsBvgJOOswHLUuwb0UCpDEE1O5J
 2BESST4MhQLBlRSJ5QaY7FckN7uh5XzjQwNA7w+MzYTFX0nSE2csPAunWWXBR+qDOojkTUR
 7FIHxaEzkln/i/ScnV/bC/Kz4ZWm9zXpxg6zPp8bKatUYzY6cBFxn1eoT0LXRVZne4QcNFH
 /DP0jLIO2mfplbtjtbfy57Kkduzf2HbgIPcfxbHeCK9E55YhkJn2wgTW9ah1RCmEId1GoRJ
 IwNg3+SMoxfhmsGIyI2xznqszH+XupYLab7UAWmFEUxHXJBHyKvvlVG8GMDQQ3GxRwV2d7k
 C3tpoypz8yRI6KLAY4+GgPOlIMnl4bZkA+VA9I/U7CviXWCRcNeG7PN6jasfXaj+NsyLT3z
 XQS/yEK8BhkskwEzJjXHxwsjIPeEgXY5B2KG+jDRyHUI/yvEGKoEBa5p/hpRorqRKkWCEaa
 g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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

We have released a new NIC series: Amber-Lite, with two models
supporting 10G/25G and 40G rates. Due to minimal hardware differences
from existing 10G NICs, it remains supported within the txgbe driver.

---
v5:
 - update txgbe guides, add more usage instructions
 - add a short summary into 25.11 release notes
---

Zaiyu Wang (21):
  net/txgbe: add basic information for Amber-Lite 25G/40G NICs
  net/txgbe: add new SW-FW mailbox interface
  net/txgbe: add identification support for new SFP/QSFP modules
  net/txgbe: rename raptor to sp for Sapphire-specific code
  net/txgbe: add basic link configuration for Amber-Lite NICs
  net/txgbe: add support for PHY configuration via SW-FW mailbox
  net/txgbe: add RX&TX support for Amber-Lite NICs
  net/txgbe: add hardware reset change for Amber-Lite NICs
  net/txgbe: add MAC reconfiguration to avoid packet loss
  net/txgbe: add TX head Write-Back mode for Amber-Lite NICs
  net/txgbe: add RX desc merge mode for Amber-Lite NICs
  net/txgbe: add FEC support for Amber-Lite 25G NICs
  net/txgbe: add GPIO configuration
  net/txgbe: disable unstable features
  net/txgbe: add support for TX laser enable/disable
  net/txgbe: add support for TX queue rate limiting
  net/txgbe: add support for getting PHY ID
  net/txgbe: add thermal sensor configuration for Amber-Lite NICs
  net/txgbe: add RSS for Amber-Lite NICs
  doc: update for txgbe guides
  doc: update release notes for Wangxun txgbe driver

 doc/guides/nics/txgbe.rst                 |  31 +-
 doc/guides/rel_notes/release_25_11.rst    |   7 +
 drivers/net/txgbe/base/meson.build        |   2 +
 drivers/net/txgbe/base/txgbe_aml.c        | 354 ++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_aml.h        |  22 ++
 drivers/net/txgbe/base/txgbe_aml40.c      | 160 +++++++++
 drivers/net/txgbe/base/txgbe_aml40.h      |  20 ++
 drivers/net/txgbe/base/txgbe_devids.h     |   9 +
 drivers/net/txgbe/base/txgbe_eeprom.c     |   7 +-
 drivers/net/txgbe/base/txgbe_eeprom.h     |   2 +
 drivers/net/txgbe/base/txgbe_hw.c         | 365 ++++++++++++++++----
 drivers/net/txgbe/base/txgbe_hw.h         |  15 +-
 drivers/net/txgbe/base/txgbe_mng.c        | 184 +++++++++-
 drivers/net/txgbe/base/txgbe_mng.h        |  34 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |   2 +
 drivers/net/txgbe/base/txgbe_phy.c        | 127 ++++++-
 drivers/net/txgbe/base/txgbe_phy.h        |  24 ++
 drivers/net/txgbe/base/txgbe_regs.h       | 103 +++++-
 drivers/net/txgbe/base/txgbe_type.h       |  70 +++-
 drivers/net/txgbe/base/txgbe_vf.c         |   2 +-
 drivers/net/txgbe/txgbe_ethdev.c          | 390 ++++++++++++++++++++--
 drivers/net/txgbe/txgbe_ethdev.h          |   2 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c       |   2 +-
 drivers/net/txgbe/txgbe_flow.c            |   2 +-
 drivers/net/txgbe/txgbe_rxtx.c            | 203 ++++++++---
 drivers/net/txgbe/txgbe_rxtx.h            |   3 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |  27 +-
 27 files changed, 1967 insertions(+), 202 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h

-- 
2.21.0.windows.1

