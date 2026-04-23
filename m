Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922ADFAD3F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:40:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BC1A40270;
	Thu, 23 Apr 2026 05:40:47 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 6F2AB40150
 for <dev@dpdk.org>; Thu, 23 Apr 2026 05:40:45 +0200 (CEST)
X-QQ-mid: zesmtpgz4t1776915641t37f7e0b7
X-QQ-Originating-IP: sUGdCbSenI0yd5kgtCya5YMvw6/iLhH+v32dTOcSVuA=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Apr 2026 11:40:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15479039999767613405
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 00/18] Wangxun Fixes
Date: Thu, 23 Apr 2026 11:40:05 +0800
Message-Id: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ONcd5u+FjiuQGvNQEsXTbCPaQYFJ2/TVIEDMwsTZ/BmBwTLcAQg/yADD
 1MQCCtycwJPyjvZKGLGoV1cbsSsIBcyr3N84pJ8vkypLEof5GQaR/o354BjKIYD5qrP5znW
 k58P6PuRM8v949D4DG0pRA16lMW+ej4VqB0lTyFcwyj/4njylX0uVvwxaXztp59tBjFhbg2
 NxqYqBX2vD90yXdD9kQ9fc8q3hOBSN0zqM5roOuN9ume5DWcRe9BlKx8WuMTpVKT7BEWRVV
 ufIAb0d0LNyf4Pn8aeWIsLM7I9vBAMspekIJ+5Oc6PFT6lF7NF8xW7aJRu7RPPK48mElKju
 CrFMuIgm55KUtLaG29AeeQVWXFSAJka8Gx8kqtEr163teho6AoEW3ebTSILz0kBkIEcSJkp
 N4iwveyS3Hlo7Mdoov2PedOWMh5N8tEthD9c1MmLACMMeVUew9nThjjYOp3fEOuBxZ9rKcA
 VqH7031OHFSnVYT+ieKEt/bzOP7TjywGKcbEIUY8A1QI3ygZ2fyuB6nImVANMuTzISvX5ra
 w0bQsWk/7g2GCadrP/YfpQB7CATIqmZRDLnghK6Yt5xvKI4vqoI5WOoX5aa+uPEpmq+Mmhb
 av2tBmmivvM3864Glx5nf69/X25KMb8qg+S3sYbE3fj2eibxYUc25YydpyBt41iRy8vwB0I
 MApCc+N9AeXJ/MXeHVDOX8aA/y+56O4z86cxWRm2OlRzWr7lAPf7+ZTWElrPlsEq7EMWjUT
 Iv6e8Gx6+BIfM6+GTS4KeI+IXE7t5U/eMcUZtNWUW0FlvtlRRuKL4/xmjF18STpMD+lttTW
 eeHhMQRotXSe+r9BKG8P/eFuYBsTIXS6RWcEB3mlBCsg3bmlfWEBaT/vrfFyssjQ9jaHUvI
 8Ul8IbOJ9yTlfEsQpQk6s+bFtkTl1mwwl3QuqLZyr6gY3adC3vU2l88brBIpiOh2xOEJX6w
 HL2+fA/EDfOSipXkOhoK+qIqXIrlJyBmTGxMVRr1IEWr21B53SrIhKvSYwf/i69gdE9SINz
 PF8piKP1eJG0PoJnEUpQDe/kAfUVbIXtAOTR80Vw==
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

Zaiyu Wang (18):
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
 drivers/net/txgbe/base/txgbe_e56.c        | 3705 +++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h        | 1751 ++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.c     | 2595 +++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h     |  279 ++
 drivers/net/txgbe/base/txgbe_hw.c         |   52 +-
 drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |   12 +-
 drivers/net/txgbe/base/txgbe_phy.c        |  360 +-
 drivers/net/txgbe/base/txgbe_phy.h        |   42 +-
 drivers/net/txgbe/base/txgbe_regs.h       |   10 +-
 drivers/net/txgbe/base/txgbe_type.h       |   39 +-
 drivers/net/txgbe/txgbe_ethdev.c          |  390 ++-
 drivers/net/txgbe/txgbe_ethdev.h          |    6 +-
 drivers/net/txgbe/txgbe_logs.h            |    7 +
 drivers/net/txgbe/txgbe_rxtx.c            |   39 +-
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |    7 +-
 26 files changed, 9233 insertions(+), 402 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

-- 
2.21.0.windows.1

