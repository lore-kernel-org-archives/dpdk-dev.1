Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC464EF99C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 18:53:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4E0E402C0;
	Fri, 13 Feb 2026 19:53:32 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 23112402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 19:53:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771008810;
 bh=CGJ6QlClW6a+jL3lONMxPU8lMh8gopZbp0FdOIH2Mpk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MlA4b+kFu/zBwCl1PFgZkwk5UNT1yXtXya9t0JMltISBvOLt49nTV2qJzBDRcygya
 BJH13tzfVlApbqR/ACHvuglJVYrLelI1BESglAORs+77LjEFemLMPoQnRRA9kwsEmA
 +R4hHSfvsVwRiEh1yZlL19vk6em8SdY6UUWD7A5THOLVJoDNw1VY4UBB9/D7gq8Le/
 nSYZ0f8wv75zH3pwhdcSkjmrnrZqxC1eXkvKSCboOi4z91XwQKPvuWewTei9taCnl5
 F2wDOQNs3nItQr7pUuhdfMH1CCn0VbZuvyhEbyaMZMml9acUjOmoC8g+jj9/Pf5ZtO
 KZmz0bapOH13Q==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id D09131180078;
 Fri, 13 Feb 2026 19:53:30 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v8 0/8] net/nfb: rework to real multiport
Date: Fri, 13 Feb 2026 19:53:09 +0100
Message-ID: <20260213185317.1893353-1-spinler@cesnet.cz>
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

v8:
* removed double usage of TAILQ_REMOVE
* added "ready" bit to private struct for syncing of the data
  shared with secondary processes on init
* added "ret" to nfb_ifc_create_params for use in failed
  nfb_eth_dev_create_for_ifc() called from rte_kvargs_process();
  now returns the right error value
* added bounds check on queue and MAC indexes in mapping
* added bounds check on queue index in queue setup
* added NULL check after rte_eth_dev_get_by_name()
* added errno check after strtoul()
* added integer overflow check in port validation
* added comment with usage of separate nfb handles 
* used base 10 for port number as strtoul() param

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
 drivers/net/nfb/nfb.h                  |  57 ++-
 drivers/net/nfb/nfb_ethdev.c           | 487 +++++++++++++++++++------
 drivers/net/nfb/nfb_rx.c               |  33 +-
 drivers/net/nfb/nfb_rx.h               |   9 +-
 drivers/net/nfb/nfb_tx.c               |  30 +-
 drivers/net/nfb/nfb_tx.h               |   7 +-
 drivers/net/nfb/nfb_vdev.c             | 107 ++++++
 11 files changed, 672 insertions(+), 256 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_vdev.c

-- 
2.53.0

