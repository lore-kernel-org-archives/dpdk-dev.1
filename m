Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD44C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 12:51:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C340440A4B;
	Wed, 25 Jun 2025 14:51:32 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 2CA65402AB
 for <dev@dpdk.org>; Wed, 25 Jun 2025 14:51:29 +0200 (CEST)
X-QQ-mid: esmtpsz21t1750855883tc36d0629
X-QQ-Originating-IP: 82pd9dacRrdXe4Tuk1VdHtLgNsl7817YRjhwxcjjVgk=
Received: from DSK-zaiyuwang.trustnetic.com ( [60.186.80.242])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 25 Jun 2025 20:51:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4319747307065763528
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 00/15] Wangxun new NIC support
Date: Wed, 25 Jun 2025 20:50:32 +0800
Message-Id: <20250625125047.18072-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MfQnJH+7WKv6bRn/snllrg9bM5hEFIZa+eXlTITOPOoYy4cdzIF/phHv
 yzk5RxNmz2Cn1jgN0ysA9b/hVSbC+jt14PeQr73SMAeErG5uHpy9WAE+5nCwtEF+QPYhAnf
 /+c2mmSbMl4JTpmKdZ1fak9sTQYvFpoBwLi2C45hjHHrt+n6YXsIwea+kjFETjjO5YP8mrO
 +XmiNQULt7Og09JdGCDPqTu3JeDC1hN9RUIxSZg2GibBD2JJ5iwj1Kb+Hf/dx0bzUTdqDEC
 4mtqrm4XpTH+l1nR/Q6Dgwsu6A9qYZsawFuyh0hXNOgbe+Q0Isy+uyY7usDXVvUHKjrHsrN
 LVwGQMhPkWMyF6z+wzuaahW3n/qimXx8kjKfURSyaZuPZzLR7WsKW/3Knyxa2fEgcI7XYu4
 BELx9/DisqEEtHILgma6slcDOrQKHRR21QmrnA7S+elkExLiRJooxCh+2k75TTo5S5dJsCU
 TR66DesWFQIFjpMq9vRH3lDQYQTr166JzO8XKHv4JgeDhaNrwXwOVsShUSmSVo+MeRN+Tl/
 /U72ecdQvIcyKCUVUYJSmI3/PosFpCvRiKbpWmS/pyUmskr8YtQcgwg6yxblrE/JbP0bKLn
 brn5WkegDKmEdEafJNIoDo7vpw1ckdKADC0Gx8mQ3fbjix/vnL8t9t39x7dZNBNOZ0XL5a9
 bpwPOPSx9zZhN7DUjl7W4reRBM+qSa1Di3TSJF6AsPLeGZybKqYKQcgejApJyjFC/q/qxxl
 TkhaQODn2IaM8VoqeDFw74g+/URpi1e76qReDhAiJqJPy8WsuguJhk4Ss870IGO+vcCTwLj
 1Oyn/1RD2YsU6HP6vu+UIrOGeow4ylZsuWafuCpRbrXvGhTBj9KDI5am+rUhHA6wBVDRrwP
 O55SJ0DwCfKbk18TRquZwD/GLDpUKIHWDY/6FSpn/GOi7QVYdodUCMQIhHlwjRVnwEBcHhM
 wrOX9mwObvP6HJ2iClaoJdaSq5fzVJ4eDP7YJkbb+gpYb+E7G8CoozDM1A2u+Nz8W01vVq6
 0iyvaI/wrbVhZHqHdPvJzTIjWptzU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
supporting 10G/25G and 40G rates. Due to minimal hardware 
differences from existing 10G NICs, it remains supported within
the txgbe driver.

Zaiyu Wang (15):
  net/txgbe: add basic information for Amber-Lite 25G/40G NICs
  net/txgbe: add new SW-FW mailbox interface
  net/txgbe: add identification support for new SFP/QSFP modules
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
  net/txgbe: add other hardware-related changes
  doc: update for txgbe

 doc/guides/nics/txgbe.rst                 |   8 +-
 drivers/net/txgbe/base/meson.build        |   2 +
 drivers/net/txgbe/base/txgbe_aml.c        | 355 ++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_aml.h        |  22 ++
 drivers/net/txgbe/base/txgbe_aml40.c      | 159 +++++++++
 drivers/net/txgbe/base/txgbe_aml40.h      |  20 ++
 drivers/net/txgbe/base/txgbe_devids.h     |   9 +
 drivers/net/txgbe/base/txgbe_eeprom.c     |   7 +-
 drivers/net/txgbe/base/txgbe_eeprom.h     |   2 +
 drivers/net/txgbe/base/txgbe_hw.c         | 355 +++++++++++++++++---
 drivers/net/txgbe/base/txgbe_hw.h         |  16 +-
 drivers/net/txgbe/base/txgbe_mng.c        | 252 +++++++++++----
 drivers/net/txgbe/base/txgbe_mng.h        |  34 +-
 drivers/net/txgbe/base/txgbe_osdep.h      |   2 +
 drivers/net/txgbe/base/txgbe_phy.c        | 127 +++++++-
 drivers/net/txgbe/base/txgbe_phy.h        |  24 ++
 drivers/net/txgbe/base/txgbe_regs.h       |  95 +++++-
 drivers/net/txgbe/base/txgbe_type.h       |  66 ++++
 drivers/net/txgbe/txgbe_ethdev.c          | 373 ++++++++++++++++++++--
 drivers/net/txgbe/txgbe_rxtx.c            | 201 +++++++++---
 drivers/net/txgbe/txgbe_rxtx.h            |   3 +
 drivers/net/txgbe/txgbe_rxtx_vec_common.h |  27 +-
 22 files changed, 1945 insertions(+), 214 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h

-- 
2.21.0.windows.1

