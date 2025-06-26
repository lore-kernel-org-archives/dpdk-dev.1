Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77441C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:08:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2CA740E34;
	Thu, 26 Jun 2025 10:08:46 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 5FE1640A84
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:08:45 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925319t35aead3f
X-QQ-Originating-IP: aWWLwAibfLMed7DoavUM4bcNwdCOkVJZkUypkMhX/mw=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:08:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11578374532678376439
EX-QQ-RecipientCnt: 2
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 00/15] Wangxun new NIC support
Date: Thu, 26 Jun 2025 16:02:05 +0800
Message-Id: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OWhN4QRntHSGWiX9pQB5MFdgKrFd1OZ82SoabuWfhK6WvJs1EBVK8nz+
 XzXNDr0vAZpN46yWPzHOxwawezYUUk40ArcgKjnTihd/IxayERAItdKY/q7xQyUzd292uZO
 IN+RXDewuWLi5E8bSLBm774t4j6yjuwkrcclDXYmecu6jgdMHzy6o+PrLu9RzAYmFOYcigt
 nEeJVmptACMhgC9vUgi/73UVPJIwq6JfHtKybEICV/gVDVtX0uh46/Ak4EQO/T0lPaQhlBK
 aT1/C9ULvH90Ks05c4Dgh3xLKKLuecYX/l+HOSk66M/nlIr08Lfd/bHLsAZ3C4vRoNbpzbW
 BR8+3kuho9sRAo7XyppQ6PctCdoCNT68c4ittvkAdh1RzpjSx3K4uM2w9Cof/VXVAmi9aim
 3y1/CMhYW3Dkt/VWXyz2wy5hskARYo5gdyjyJArcE+9L0q2YqDGQV6I4iujBT8FtWVLzdHf
 w4oMEsMtCcAG3cO/R3SLMWJ2N2v7HLrINQ6ClM/1tkpGkEc3QkfZaZlV5Jtz3qg32nJWkLx
 UZyllV5CILSNQYX9ZlTY+fJRfuNh4slCohCNuu0Lw6wo3XFs5xyecQ/pwIl182TlhTPT72p
 fpaR7JmoPQZ4v62JrSUW1hnCOVMDWT5gFzMbJMHvl9CXfZ4IK1UbQTknsr4lLex+FFY7nYt
 XUQyYnn5FtyfSx4PC9k1E9J2ol+RkMTUm+cdk6eR7uXwFSPcyBCuSsEIXkjRmpMWXmSvIDW
 wdTJhhc7vgRcqmlIK4WjKV919IkGDfN/DrJhkC0QA6yv13WwZmrH0D//jG5UzFv8NP3Ixhq
 uYIL0u2lDtUzQ/xcxNFb8PaKvxTKjojUgcXELrBJ7qt3l1wfHPHuM62Y09h2FxGgR+s1aWp
 bvvstufzp34vXISdfCT0h2DD68OpplK7L0almQelrg1m4k91AL76kltULbpwP20Q/i+jfkg
 k6nS0WKdJ/nKCi4sVNrX9Vm0hsAWRBSSxqyE0VuIWStSD6A0MRDj/cKQINFN976v0fBHhl2
 r+X76Nd6Ma6uPtrATeK0LVdsqgcnJnA2uBwXjeYabEJjTNCCM/
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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

---
v2:
- split patch into 15 functional subpatches
- replace PHY configuration with mailbox cmd to firmware
---
v3:
- fix compilation errors and documentation formatting
---

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
 drivers/net/txgbe/base/txgbe_aml.c        | 354 ++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_aml.h        |  22 ++
 drivers/net/txgbe/base/txgbe_aml40.c      | 160 ++++++++++
 drivers/net/txgbe/base/txgbe_aml40.h      |  20 ++
 drivers/net/txgbe/base/txgbe_devids.h     |   9 +
 drivers/net/txgbe/base/txgbe_eeprom.c     |   7 +-
 drivers/net/txgbe/base/txgbe_eeprom.h     |   2 +
 drivers/net/txgbe/base/txgbe_hw.c         | 357 ++++++++++++++++++---
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
 22 files changed, 1946 insertions(+), 215 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h

-- 
2.21.0.windows.1

