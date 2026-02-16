Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4AE81A40
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 16:25:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDE9A4042E;
	Mon, 16 Feb 2026 17:25:13 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 1B65540289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 17:25:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771259110;
 bh=GyaetKueYZQZge0nhkkL2v7i4ZiPCp7jIZpWT25Wtng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g09kddgc9725JlRWw70Bk+EMNViRWkg4pgi0ypsv6DxLV0Q7tffDJZkCDNV4ZRQuB
 cnT5RAgyFPgvE8dr+5+HUdUqXn0zsKyIIqKxXIPMtA0qYXi+j1sFKA72gQ78jQIIek
 Mq4iTUDz4H2+eb37vCAcsgEpEhwO/bxNhit5DTnRqthi+Ptk0/ZjOKr5hfZ+VoNg0k
 /xXQj4fOY9b9IpyeWZpnI2krZCGL6kbMJcSSc10fkCEBhbjgseCvvw4IJNuYz/i3Aa
 B5YE21rnw6vUtpnsj7AHMDdESAEFwCZZMYr5LuVIz3hCy3cR9o5f4IKD6CGZPoW7TH
 puFVSB5fjyoNQ==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id B5CA21180078;
 Mon, 16 Feb 2026 17:25:10 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v9 0/8] net/nfb: rework to real multiport
Date: Mon, 16 Feb 2026 17:24:58 +0100
Message-ID: <20260216162506.2702066-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260115151656.393106-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
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

This series implements real multiport for better user experience.

The existing driver creates one ethdev/port for one PCI device.
As the CESNET-NDK based cards aren't capable to represent each
Ethernet port by own PCI device, new driver implementation
processes real port configuration from firmware/card and switches
from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.

---
Depends-on: patch-37245 ("doc/nfb: update release notes for nfb driver")

v9:
* fixed error path in nfb_nc_eth_init() that did not close MAC handles
* fixed wrong variable usage (max_rx_queues instead of max_tx_queues)
* removed __rte_internal + RTE_EXPORT_INTERNAL_SYMBOL for
  driver-internal functions

Martin Spinler (8):
  net/nfb: prepare for indirect queue mapping scheme
  net/nfb: create one ethdev per ethernet port
  net/nfb: add vdev as alternative device probe method
  net/nfb: add device argument "port" to limit used ports
  net/nfb: init only MACs associated with device
  net/nfb: add compatible cards to driver PCI ID table
  net/nfb: report firmware version
  doc/nfb: cleanup and update guide

 doc/guides/nics/features/nfb.ini       |   4 +
 doc/guides/nics/nfb.rst                | 187 +++++-----
 doc/guides/rel_notes/release_26_03.rst |   6 +
 drivers/net/nfb/meson.build            |   1 +
 drivers/net/nfb/nfb.h                  |  55 ++-
 drivers/net/nfb/nfb_ethdev.c           | 489 +++++++++++++++++++------
 drivers/net/nfb/nfb_rx.c               |  33 +-
 drivers/net/nfb/nfb_rx.h               |   9 +-
 drivers/net/nfb/nfb_tx.c               |  30 +-
 drivers/net/nfb/nfb_tx.h               |   7 +-
 drivers/net/nfb/nfb_vdev.c             | 107 ++++++
 11 files changed, 672 insertions(+), 256 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_vdev.c

-- 
2.53.0

