Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8702C44536
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:27:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DCB94013F;
	Thu, 22 Jan 2026 08:27:30 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 489F6400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:27:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769066849;
 bh=N0uR1Hp0nAr9run4Wr9IMkS7Q9OmVfWQ2FoV3tyT/3g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S6ZdNkdIo1Ggg3CUXKhQ6ZYqY4wc+4mMqLzIa/FdcONERHSkeQ0p3CAmY08cyABIL
 Bpgy4DWF6i6h4ezt1IEd7mgtwBpMBWOCg0Y0K4vghaCQnFcJJCrZE0ysowG+g8r9Ev
 5SH2RczQW5WZhSJv54GBqb9ngX+MPn+p8/ct7mo44eOioVjfZFC0a3UcEygN4cMjPm
 odtT0mhUWRphbLPccWz2h6lQoVK1xPxN1N4YAUAaLOGE/u0LxFRU9BugTFKCog7IWi
 s6zIEVK8CrDMm4V5mb5HSqcuhWxh4E34y4J7lzBolw24goQHn+OBodwKX7mu1W1bEH
 2ws86h06u4Vvw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 05885118007E;
 Thu, 22 Jan 2026 08:27:28 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v4 0/8] net/nfb: rework to real multiport
Date: Thu, 22 Jan 2026 08:27:11 +0100
Message-ID: <20260122072719.505185-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
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
v4:
* Cleaned usage of sprintf
* Updated commit message for doc cleanup

v3:
* Polished int type usage of QueueID for libnfb API.
* Used rte_calloc instead of rte_malloc.
* Moved queue_map_*x from pmd_internals to pmd_priv.
* Removed RTE_ASSERT for error checking.
* Used RTE_BIT for mask and interger limit constants.
* Added check of return value of nfb_nc_*xmac_init.
* Added release notes entry.

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

 doc/guides/nics/features/nfb.ini       |   4 +
 doc/guides/nics/nfb.rst                | 187 +++++------
 doc/guides/rel_notes/release_26_03.rst |   9 +
 drivers/net/nfb/meson.build            |   1 +
 drivers/net/nfb/nfb.h                  |  46 ++-
 drivers/net/nfb/nfb_ethdev.c           | 415 +++++++++++++++++++------
 drivers/net/nfb/nfb_rx.c               |  30 +-
 drivers/net/nfb/nfb_rx.h               |   9 +-
 drivers/net/nfb/nfb_tx.c               |  27 +-
 drivers/net/nfb/nfb_tx.h               |   7 +-
 drivers/net/nfb/nfb_vdev.c             | 103 ++++++
 11 files changed, 592 insertions(+), 246 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_vdev.c

--
2.52.0

