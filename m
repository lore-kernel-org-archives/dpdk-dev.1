Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE19C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 07:40:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27F2E42E37;
	Tue, 10 Jun 2025 09:40:50 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 7CAB940299
 for <dev@dpdk.org>; Tue, 10 Jun 2025 09:40:48 +0200 (CEST)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A7ehTkB2458242,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1749541244;
 bh=9SCCo6hhmLkNrDza723s0BH4BBJRJ4LSzwORCTlYXYY=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=t92hcseDr1JjkFy/fKr3zu06NWZZqVIJYlq+DRBhXekaWJD+s3iyp1z8DFF8myXND
 cg1QKw/Fnw0XfFYcDxkM8pfxFLaEmtxwglDoG+ffQgL5dQ0tbIhuFzGGuKrhYlvIyb
 fOS3r6Evp+bDAsMIWtJOQ7NOE9YrwM/ni7lCCqSjQrJMWuno+RmEA955Zg1ls/HWR8
 anivesH3s9odWgCXxaWoIFkS8KQTaMJhzc80i2qieNoATnK7Zi7EZ7pVdBEYM+Lr6j
 u6fX4CUajJOPEjgQ+z5FNVeM9GKGdW4fX+QdySFAURAid3xNk9Zde0NkOyb3GBW803
 4Odv+sORnHbMw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A7ehTkB2458242
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Jun 2025 15:40:44 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Jun 2025 15:40:44 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 10 Jun 2025 15:40:44 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v2 0/8] net/r8169: support more cards
Date: Tue, 10 Jun 2025 15:40:29 +0800
Message-ID: <20250610074037.5288-1-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This patch series includes the following updates:

Add support for the RTL8168 1G NIC series.
Add support for the RTL8127 10G NIC.
Add support for the RTL8125CP NIC.
Update hardware configuration for RTL8125 and RTL8126.

Howard Wang (8):
  net/r8169: add support for RTL8168 series
  net/r8169: update HW configurations for 8125 and 8126
  net/r8169: add support for RTL8127
  net/r8169: remove cmac feature for RTL8125AP
  net/r8169: add RTL8127AP dash support
  net/r8169: add support for RTL8125CP
  net/r8169: add support for RTL8127ATF serdes interface
  net/r8169: update HW configuration for 8127

 doc/guides/nics/r8169.rst              |    9 +-
 drivers/net/r8169/base/rtl8125a.c      |    8 +-
 drivers/net/r8169/base/rtl8125a.h      |    1 -
 drivers/net/r8169/base/rtl8125a_mcu.c  |   24 +-
 drivers/net/r8169/base/rtl8125b.c      |    9 +-
 drivers/net/r8169/base/rtl8125b.h      |    1 -
 drivers/net/r8169/base/rtl8125b_mcu.c  |    8 -
 drivers/net/r8169/base/rtl8125bp.c     |    5 +
 drivers/net/r8169/base/rtl8125bp_mcu.c |  200 +--
 drivers/net/r8169/base/rtl8125cp.c     |   73 +
 drivers/net/r8169/base/rtl8125cp_mcu.c |   78 +
 drivers/net/r8169/base/rtl8125cp_mcu.h |   10 +
 drivers/net/r8169/base/rtl8125d.c      |  104 +-
 drivers/net/r8169/base/rtl8125d_mcu.c  | 1479 +++++++++++++-----
 drivers/net/r8169/base/rtl8125d_mcu.h  |    2 +-
 drivers/net/r8169/base/rtl8126a.c      |   17 +-
 drivers/net/r8169/base/rtl8126a_mcu.c  |  900 ++++++-----
 drivers/net/r8169/base/rtl8127.c       |  385 +++++
 drivers/net/r8169/base/rtl8127_mcu.c   |  601 ++++++++
 drivers/net/r8169/base/rtl8127_mcu.h   |   12 +
 drivers/net/r8169/base/rtl8168ep.c     |  221 +++
 drivers/net/r8169/base/rtl8168ep.h     |   15 +
 drivers/net/r8169/base/rtl8168ep_mcu.c |  177 +++
 drivers/net/r8169/base/rtl8168fp.c     |  195 +++
 drivers/net/r8169/base/rtl8168fp.h     |   14 +
 drivers/net/r8169/base/rtl8168fp_mcu.c |  270 ++++
 drivers/net/r8169/base/rtl8168g.c      |  297 ++++
 drivers/net/r8169/base/rtl8168g.h      |   15 +
 drivers/net/r8169/base/rtl8168g_mcu.c  | 1936 ++++++++++++++++++++++++
 drivers/net/r8169/base/rtl8168h.c      |  447 ++++++
 drivers/net/r8169/base/rtl8168h.h      |   21 +
 drivers/net/r8169/base/rtl8168h_mcu.c  | 1186 +++++++++++++++
 drivers/net/r8169/base/rtl8168kb.c     |    5 +
 drivers/net/r8169/base/rtl8168m.c      |   19 +
 drivers/net/r8169/meson.build          |   14 +
 drivers/net/r8169/r8169_compat.h       |   78 +-
 drivers/net/r8169/r8169_dash.c         |  447 +++++-
 drivers/net/r8169/r8169_dash.h         |    9 +-
 drivers/net/r8169/r8169_ethdev.c       |  122 +-
 drivers/net/r8169/r8169_ethdev.h       |   39 +-
 drivers/net/r8169/r8169_fiber.c        |  201 +++
 drivers/net/r8169/r8169_fiber.h        |   42 +
 drivers/net/r8169/r8169_hw.c           | 1841 +++++++++++++++++-----
 drivers/net/r8169/r8169_hw.h           |   74 +-
 drivers/net/r8169/r8169_phy.c          | 1018 ++++++++++---
 drivers/net/r8169/r8169_phy.h          |   16 +-
 drivers/net/r8169/r8169_rxtx.c         |  275 +++-
 47 files changed, 11315 insertions(+), 1605 deletions(-)
 create mode 100644 drivers/net/r8169/base/rtl8125cp.c
 create mode 100644 drivers/net/r8169/base/rtl8125cp_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8125cp_mcu.h
 create mode 100644 drivers/net/r8169/base/rtl8127.c
 create mode 100644 drivers/net/r8169/base/rtl8127_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8127_mcu.h
 create mode 100644 drivers/net/r8169/base/rtl8168ep.c
 create mode 100644 drivers/net/r8169/base/rtl8168ep.h
 create mode 100644 drivers/net/r8169/base/rtl8168ep_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8168fp.c
 create mode 100644 drivers/net/r8169/base/rtl8168fp.h
 create mode 100644 drivers/net/r8169/base/rtl8168fp_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8168g.c
 create mode 100644 drivers/net/r8169/base/rtl8168g.h
 create mode 100644 drivers/net/r8169/base/rtl8168g_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8168h.c
 create mode 100644 drivers/net/r8169/base/rtl8168h.h
 create mode 100644 drivers/net/r8169/base/rtl8168h_mcu.c
 create mode 100644 drivers/net/r8169/base/rtl8168m.c
 create mode 100644 drivers/net/r8169/r8169_fiber.c
 create mode 100644 drivers/net/r8169/r8169_fiber.h

-- 
2.34.1

