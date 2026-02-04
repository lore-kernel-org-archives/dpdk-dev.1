Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845ACE95394
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 12:32:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C6A8402EE;
	Wed,  4 Feb 2026 13:32:04 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 99767402DE
 for <dev@dpdk.org>; Wed,  4 Feb 2026 13:32:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770208322;
 bh=kABBpCp78JzRVQc6cnzWdnqJct1iLeGY50/yTCT/oL0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VVfLtAJxzMm+H5JGWLyKWAiKR/KnPwCHO9m/GofZtl7AEvN8Iobe4so8gLqXMatQ6
 Qcs//dsTS8BJbx0Y2XYhRoqpoT9sy1gShGsyHo4iziIoTsoKs13TAzAT0LHQYbmoLp
 1HyDxgyfSkyQUarme5B4kVRguLz9hybOuV1m+NXQ1d4CmxO4P4p7Vsh138HIz06rch
 TKYZuOPfOuxoXvr/b6fj4S4ukYaC+I8KRRXP6U2ROVewkNDNn4FH6eKm8bO5bFYa5l
 Aawsq1C215WDPkRO5O77/J8IalIbbJyPTQ4a0xL1+qRy1xmVnuPlBQVTPO3rHzyasn
 hV2e0R8TPtNxA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 4CA6F1180072;
 Wed,  4 Feb 2026 13:32:02 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v7 0/8] net/nfb: rework to real multiport
Date: Wed,  4 Feb 2026 13:31:29 +0100
Message-ID: <20260204123137.123171-1-spinler@cesnet.cz>
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

v7:
* Rebased to patch-37245
* Removed timestamp update info from release notes
* Added missing ctype include for isdigit()
* Updated style: removed extra brackets

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
 doc/guides/nics/nfb.rst                | 187 +++++------
 doc/guides/rel_notes/release_26_03.rst |   6 +
 drivers/net/nfb/meson.build            |   1 +
 drivers/net/nfb/nfb.h                  |  56 +++-
 drivers/net/nfb/nfb_ethdev.c           | 445 +++++++++++++++++++------
 drivers/net/nfb/nfb_rx.c               |  30 +-
 drivers/net/nfb/nfb_rx.h               |   9 +-
 drivers/net/nfb/nfb_tx.c               |  27 +-
 drivers/net/nfb/nfb_tx.h               |   7 +-
 drivers/net/nfb/nfb_vdev.c             | 107 ++++++
 11 files changed, 622 insertions(+), 257 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_vdev.c

-- 
2.53.0

