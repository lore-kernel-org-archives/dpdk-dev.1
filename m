Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94063D44C63
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 15:17:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB7C240BA6;
	Thu, 15 Jan 2026 16:17:04 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 8836B4003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 16:17:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768490223;
 bh=mc6Nl7yU/I9cabKvkt59HgrjYMYdj18ekWPe4y6iS/0=;
 h=From:To:Cc:Subject:Date;
 b=K2DLxiQkFmla0bhsC0B3xHud+EB+zlgnyYxJpngp0iTegKLRw19hR6S52FqTwG744
 xMVrFh8RRERbBOq37C+Jz2kEaC6/AgZ212k546M59UrmfAFBQEclJO58fC9Ogdj08U
 4YDD0QQ59mfetjw2yBgVSBGz4sY96Xehd2HbxXn8o9vH4ydt08u6X5I9LfjYDHnJZF
 nFRf2TGyKtHwboPZvkgcM3kGJRQF5KVPzUlc8acK4GwGt4igcEmVqE3lokuZeMazEW
 iSd+fppcRgv/fIK2nHO4cyzhiBqy/mlokoJl/XOcGjuhHdWD0GSJ6he8x6v9Ofi8cV
 YOciZRXbr+k9Q==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 31CBC1180082;
 Thu, 15 Jan 2026 16:17:03 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 0/8] net/nfb: rework to real multiport
Date: Thu, 15 Jan 2026 16:16:48 +0100
Message-ID: <20260115151656.393106-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
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
Depends-on: series-37064 ("net/nfb: code cleanup")

Martin Spinler (8):
  net/nfb: prepare for indirect queue mapping scheme
  net/nfb: create ethdev for every eth port/channel
  net/nfb: add vdev as alternative device probe method
  net/nfb: add device argument "port" to limit used ports
  net/nfb: init only MACs associated with device
  net/nfb: add compatible cards to driver PCI ID table
  net/nfb: report firmware version
  doc/nfb: cleanup and update guide

 doc/guides/nics/features/nfb.ini |   4 +
 doc/guides/nics/nfb.rst          | 187 +++++++--------
 drivers/net/nfb/meson.build      |   1 +
 drivers/net/nfb/nfb.h            |  48 +++-
 drivers/net/nfb/nfb_ethdev.c     | 399 +++++++++++++++++++++++--------
 drivers/net/nfb/nfb_rx.c         |  21 +-
 drivers/net/nfb/nfb_tx.c         |  21 +-
 drivers/net/nfb/nfb_vdev.c       |  97 ++++++++
 8 files changed, 551 insertions(+), 227 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_vdev.c

--
2.52.0

