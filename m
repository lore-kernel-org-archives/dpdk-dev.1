Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523D5C982D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 16:44:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24C4442DF1;
	Fri, 16 Jan 2026 17:44:47 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 2C44D4026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 17:44:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1768581884;
 bh=lV2AdPTKGlXMSmF1FX9UufnU29+nVBi+LUdpiDC+FHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AkwjACbepdmSIRJe1b0PFfpDC7EKDJq5kJywIRwyIyL0JJiImr39sEV9cZHNVYdL+
 hk1KHHDgHVQBj97jjug6J+AAdKAr2Uul3bM+kgpI0GJdgbQuLv+8VCgFwZ/4ISJ2pg
 Rs3hoJdEFUVrW+YIMbZZ/krLA5M9jxSpctDldhrsU1348MWU4O3dvhnoiZc9j9Q16t
 9v6hHXdrc+UFIeVD92a2+3nH1F/IzvQmFh8BNnYD21Q9gvLJ5YoGKYw3003NDoP2QZ
 nTe9AeZUL3oOypiTter1GjUzRzfnCk+s+qAerCJBA0TKOcnqpgnSzSPEFSbNvlhpjG
 bgfVQSMBq/GPw==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id D30B2118007E;
 Fri, 16 Jan 2026 17:44:44 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 0/8] net/nfb: rework to real multiport
Date: Fri, 16 Jan 2026 17:44:28 +0100
Message-ID: <20260116164436.1649047-1-spinler@cesnet.cz>
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
v2:
* Changed strcpy to strlcpy.
* Moved static array VALID_KEYS from header file.
* Fixed hex base number parsing for port argument.
* The strlcpy is used instead of strcpy.
* Used __rte_internal tag for nfb_eth_common_{probe,remove}.
* Fixed coding style and spelling issues.


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
 doc/guides/nics/nfb.rst          | 187 +++++++-------
 drivers/net/nfb/meson.build      |   1 +
 drivers/net/nfb/nfb.h            |  46 +++-
 drivers/net/nfb/nfb_ethdev.c     | 407 +++++++++++++++++++++++--------
 drivers/net/nfb/nfb_rx.c         |  21 +-
 drivers/net/nfb/nfb_tx.c         |  21 +-
 drivers/net/nfb/nfb_vdev.c       |  96 ++++++++
 8 files changed, 554 insertions(+), 229 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_vdev.c

--
2.52.0

