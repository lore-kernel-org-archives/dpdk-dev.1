Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5338EC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 03:19:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79E3B402D5;
	Fri,  7 Feb 2025 04:19:10 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 31FE9402A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 04:19:07 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5173J5jK4211729,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realsil.com.cn;
 s=dkim; t=1738898345;
 bh=ud7Q9RT4CMvdRLLWsdJ2t2OONBKrTrTXNB13DLEftic=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=LF4BcLXE0yxvL32WC+3uBgGqMj6S9WpP3ra2sIdc5rjA16k9xW+/tCk6tHmdJfxB7
 XaKLDXS4JWPioew/ygu6y7g9zYKk535hwwb8ohZAt0wUtyqBSzLo8K8QbOH/lBMN27
 bfkOw155P7WYcIrxpx488RlxpoDC8+L3GVpCBg53MjSbWUChVvjOpLax+gYxSUWb9K
 xBE+BL0Duqa1mTwmWkd6253LLQXbofhNuJy9FSmiIw6wzB62jA0wBJdbqV9wkZCjfz
 o6HKPbY1nSCIclyQRy5ERA8KZVSFVC30g4PQAWMcLgju9A8rBRNvbZdsHvXiRjVQyc
 L5wFHhKMGqIfg==
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
 by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5173J5jK4211729
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL)
 for <dev@dpdk.org>; Fri, 7 Feb 2025 11:19:05 +0800
Received: from RSEXDAG02.realsil.com.cn (172.29.17.196) by
 RSEXMBS01.realsil.com.cn (172.29.17.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Feb 2025 11:19:05 +0800
Received: from RSEXH36502.realsil.com.cn (172.29.17.3) by
 RSEXDAG02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 7 Feb 2025 11:19:05 +0800
Received: from 172.29.32.27 (172.29.32.27) by RSEXH36502.realsil.com.cn
 (172.29.17.3) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 7 Feb 2025 11:19:05 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 0/2] March update for r8169 pmd
Date: Fri, 7 Feb 2025 11:18:43 +0800
Message-ID: <20250207031845.22168-1-howard_wang@realsil.com.cn>
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

Howard Wang (2):
  net/r8169: replace rte_smp_rmb with atomic read
  net/r8169: add support for RTL8168KB

 doc/guides/nics/r8169.rst                     |   5 +-
 drivers/net/r8169/base/rtl8125a.c             |   4 +-
 .../r8169/base/{rtl8125a_mcu.h => rtl8125a.h} |   8 +-
 drivers/net/r8169/base/rtl8125a_mcu.c         |   2 +-
 drivers/net/r8169/base/rtl8125b.c             |   4 +-
 .../r8169/base/{rtl8125b_mcu.h => rtl8125b.h} |   8 +-
 drivers/net/r8169/base/rtl8125b_mcu.c         |   2 +-
 drivers/net/r8169/base/rtl8168kb.c            | 123 ++++++++++++++++++
 drivers/net/r8169/meson.build                 |   3 +-
 drivers/net/r8169/r8169_ethdev.c              |   2 +
 drivers/net/r8169/r8169_hw.c                  |  16 ++-
 drivers/net/r8169/r8169_hw.h                  |   1 +
 drivers/net/r8169/r8169_rxtx.c                |   6 +-
 13 files changed, 162 insertions(+), 22 deletions(-)
 rename drivers/net/r8169/base/{rtl8125a_mcu.h => rtl8125a.h} (72%)
 rename drivers/net/r8169/base/{rtl8125b_mcu.h => rtl8125b.h} (72%)
 create mode 100644 drivers/net/r8169/base/rtl8168kb.c

-- 
2.34.1

