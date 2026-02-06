Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF7BEE20B6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8254140276;
	Fri,  6 Feb 2026 18:04:40 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 47F1940156
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770397478;
 bh=xlCvVbe9T+jsqI9XZs0NHf4HEVCKJ0CUHRTfu6r5D5s=;
 h=From:To:Cc:Subject:Date;
 b=Kc5TEkRxU2liLWxTABQyyr/lVwmNoa/kbtVqkyN2U6OUqPXhagxVJNr5v/CO5lvPR
 1B87ZawyHhyyPZVuhzG5u1FhlySPpiPZNH7s5u242720cn4DBEXYhHR74H/wZCrrtl
 cDf2kUUG4tvYdIEbiAkf/rN1eSItzBtDKfpfGQRgXPr7yVCyC8dwMAKByGyp9jFqh2
 27QAgzVXBrYWStWB5vQCgHVaTvkMrMawsCKvuHzQDSsezsaznTuUBWhlZt2A+cDiJS
 y8OMn0UdcTj9WGtr8/SngSApi45LDt4uC9rMg8vRpoZrlRyg6wnfzE2hOJDiyokakt
 nedWOPRAG3Ztg==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id E9A821180072;
 Fri,  6 Feb 2026 18:04:38 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 0/7] net/nfb: ethernet enhancements
Date: Fri,  6 Feb 2026 18:04:28 +0100
Message-ID: <20260206170435.302184-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Martin Spinler <spinler@cesnet.cz>

This set includes minor enhancements to the Ethernet
configuration and overall usage.

---
Depends-on: series-37261 ("net/nfb: rework to real multiport")

Martin Spinler (7):
  net/nfb: use MAC address assigned to card
  net/nfb: get correct link speed
  net/nfb: support real link-up/down config
  net/nfb: support setting RS-FEC mode
  net/nfb: support setting Rx MTU
  net/nfb: read total stats from macs
  doc/nfb: update release notes for nfb driver

 doc/guides/rel_notes/release_26_03.rst |   3 +-
 drivers/net/nfb/meson.build            |   1 +
 drivers/net/nfb/nfb.h                  |   7 +
 drivers/net/nfb/nfb_ethdev.c           | 228 +++++++++++++++++++++----
 drivers/net/nfb/nfb_mdio.c             |  42 +++++
 drivers/net/nfb/nfb_mdio.h             |  34 ++++
 drivers/net/nfb/nfb_stats.c            |  40 +++--
 7 files changed, 308 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_mdio.c
 create mode 100644 drivers/net/nfb/nfb_mdio.h

-- 
2.53.0

