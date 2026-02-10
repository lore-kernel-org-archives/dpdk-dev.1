Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DFAEA3F0D
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 05:55:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38BA340664;
	Tue, 10 Feb 2026 06:55:27 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 412DA4042F
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:55:19 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61A5tG3D13127159,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1770702917;
 bh=Z1c7UXXktAaVPS0fC8JO7n9wsYllduDzB7ZcSUjncGI=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=TNBc6JG11gb/8ao1edBkyZOM4INhnCIv1XYy1jmiqUyHyOi40Yl2S0rOhcNflCXK7
 DFekg5n9UMoliPDhn78/22TQ+KsroBrtyybuSnGhEn4Ka/Tidz3ObYzbNyYDGFywsf
 GjXbYKnWHESTNpuhMPo9eDNTzqH67KIMYY+SGiI38ZVV1pCRcAJG1TjJQALIBKFUnd
 Tid0xuRkDVNJJjQY8zuixvL1qbBtITxKdpyus9gSU3KfKotT1C6pbw5e7voi6W1+wv
 ifypxoSDdBLQz0hWssi+HDSzngU7QaE80MQgpaE/UVEl/09OugXh4CHrnyRQL+QXgi
 adHZCksPUVE+g==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61A5tG3D13127159
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:55:16 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Tue, 10 Feb 2026 13:55:16 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 10 Feb 2026 13:55:16 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v2 00/12] net/r8169: update driver with new HW support and
 fixes
Date: Tue, 10 Feb 2026 13:54:59 +0800
Message-ID: <20260210055511.62382-1-howard_wang@realsil.com.cn>
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

This patch set updates the r8169 pmd driver to include support for new
Realtek hardware revisions and provides several bug fixes and improvements.

The main changes include:

1. New Hardware Support:
   - Add support for RTL8125K, RTL9151 and RTL8168KD.

2. Bug Fixes:
   - Fix a bug related to RTL8168KB.
   - Fix a potential NULL pointer dereference in rtl8168fp_ops.
   - Fix the incorrect link status reported when binding the PMD after
     the NIC has been initialized by the vendor driver.

3. Configuration & Optimization:
   - Update hardware configurations for 8125, 8126, and 8127 series.
   - Adjust jumbo frame size limits for non-1G cards.
   - Tune RX descriptor fetch number for 8126 and 8127 to improve performance.
   - Remove support for legacy CFG_METHOD_69.

Howard Wang (12):
  net/r8169: fix NULL pointer dereference in rtl8168fp_ops
  net/r8169: tune RX desc fetch num for 8126 and 8127
  net/r8169: add support for RTL8168KD
  net/r8169: update hardware configurations for 8127
  net/r8169: adjust jumbo frame size limit for non-1G cards
  net/r8169: remove support for CFG_METHOD_69
  net/r8169: update hardware configurations for 8126
  net/r8169: update hardware configurations for 8125
  net/r8169: add support for RTL9151
  net/r8169: add support for RTL8125K
  net/r8169: fix one bug about RTL8168KB
  net/r8169: ensure the old mapping is used

 drivers/net/r8169/base/rtl8125a_mcu.c  |  128 +--
 drivers/net/r8169/base/rtl8125b_mcu.c  |   56 +-
 drivers/net/r8169/base/rtl8125bp_mcu.c |   17 +-
 drivers/net/r8169/base/rtl8125cp.c     |   36 +
 drivers/net/r8169/base/rtl8125cp_mcu.c |   87 +-
 drivers/net/r8169/base/rtl8125cp_mcu.h |    1 +
 drivers/net/r8169/base/rtl8125d.c      |   31 +-
 drivers/net/r8169/base/rtl8125d_mcu.c  |  605 +++++++----
 drivers/net/r8169/base/rtl8125d_mcu.h  |    1 +
 drivers/net/r8169/base/rtl8126a.c      |   32 +-
 drivers/net/r8169/base/rtl8126a_mcu.c  |  689 +-----------
 drivers/net/r8169/base/rtl8126a_mcu.h  |    2 -
 drivers/net/r8169/base/rtl8127.c       |   15 +-
 drivers/net/r8169/base/rtl8127_mcu.c   | 1332 +++++++++++++++++-------
 drivers/net/r8169/base/rtl8168fp.c     |    1 +
 drivers/net/r8169/base/rtl8168fp.h     |    1 +
 drivers/net/r8169/base/rtl8168fp_mcu.c |    6 +
 drivers/net/r8169/base/rtl9151a.c      |   87 ++
 drivers/net/r8169/base/rtl9151a.h      |   10 +
 drivers/net/r8169/base/rtl9151a_mcu.c  |   53 +
 drivers/net/r8169/meson.build          |    2 +
 drivers/net/r8169/r8169_compat.h       |   10 +-
 drivers/net/r8169/r8169_ethdev.c       |   36 +-
 drivers/net/r8169/r8169_ethdev.h       |    3 +
 drivers/net/r8169/r8169_fiber.c        |   15 +-
 drivers/net/r8169/r8169_hw.c           |  239 +++--
 drivers/net/r8169/r8169_hw.h           |   11 +-
 drivers/net/r8169/r8169_phy.c          |   54 +-
 drivers/net/r8169/r8169_rxtx.c         |    1 -
 29 files changed, 2058 insertions(+), 1503 deletions(-)
 create mode 100644 drivers/net/r8169/base/rtl9151a.c
 create mode 100644 drivers/net/r8169/base/rtl9151a.h
 create mode 100644 drivers/net/r8169/base/rtl9151a_mcu.c

-- 
2.34.1

