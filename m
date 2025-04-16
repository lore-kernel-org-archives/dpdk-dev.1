Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635D6C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:00:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EC6540655;
	Wed, 16 Apr 2025 16:00:27 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 493EC40B97
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:00:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id EFCEEE0872;
 Wed, 16 Apr 2025 18:00:24 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am EFCEEE0872
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812025;
 bh=leDFt/ke+Qq3kbE+yLzkt8BSJsngKlq6J3Hi/LDRCro=;
 h=From:To:Cc:Subject:Date:From;
 b=X/gJd0kfg0bZm2ZbNDtlfWuEBh2ibFB/UEXSSaUe3ROgK2B2ttIBepQpNUccAoZfG
 R6vCKui9taz//DrkojMecmgcZr3vQdfqJQI/CxhD4g0ajlN8QXSVmogs8wzUqe2u+s
 CVAe2+315ndfvWcEhe1bdoNxh3eNtpurzZCWBhqJcnAd8m3wwT3s3jG2r26Oak6hue
 d3gA6sLC7DZImpZ5roDA9JWZxwy2s1G1iwYPIr0CB68rj9XM5TVc/Vv2wPl2sxHOp4
 znaX34pFfnvfpnhp4hG1+sNCAdKkQZNE8kRH9sPdFhzOhm5BJbEeo3oMzEt525OWk2
 c/uetxnoId7CQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 00/46] Support AMD Solarflare X45xx adaptors
Date: Wed, 16 Apr 2025 17:59:30 +0400
Message-Id: <20250416140016.36127-1-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
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

New X4522 (dual port SFP56) and X4542 (dual port QSFP56) adaptors are
Medford4 (X4) chips that are based on EF10 architecture. An X4 NIC
supports multiple network engine types. This series provides support
only for the Medford2-alike, 'full-feature' (FF) network engine. This
shall not be confused with the concept of 'datapath FW variants': the
FF network engine supports both 'full-feature' and 'ultra-low-latency'
datapath FW variants, with corresponding Medford2-alike feature sets.

The first part of the series provides general support for the adaptors,
whilst the second one adds support for the new management controller
interface for configuration of network port features (netport MCDI).

For now, only support for physical functions (PFs) is concerned. There
is a small number of TODO and FIXME markings in the code. Those are
normal at this development stage and will be removed by future patches
when VF support has fleshed out.


Andy Moreton (3):
  common/sfc_efx/base: update X4 BAR layout and PCI IDs
  net/sfc: add Medford4 with only full feature datapath engine
  common/sfc_efx/base: add port mode for 8 port hardware

Denis Pryazhennikov (15):
  common/sfc_efx/base: add Medford4 PCI IDs to common code
  common/sfc_efx/base: add efsys option for Medford4
  common/sfc_efx/base: add Medford4 support to NIC module
  common/sfc_efx/base: add Medford4 support to EV module
  common/sfc_efx/base: add Medford4 support to FILTER module
  common/sfc_efx/base: add Medford4 support to INTR module
  common/sfc_efx/base: add Medford4 support to MAC module
  common/sfc_efx/base: add Medford4 support to PHY module
  common/sfc_efx/base: add Medford4 support to TUNNEL module
  common/sfc_efx/base: add Medford4 support to MCDI module
  common/sfc_efx/base: add Medford4 support to Rx module
  common/sfc_efx/base: add Medford4 support to Tx module
  drivers: enable support for AMD Solarflare X4 adapter family
  common/sfc_efx/base: add new X4 port mode
  common/sfc_efx/base: extend list of supported X4 port modes

Ivan Malov (28):
  common/sfc_efx/base: update MCDI headers
  common/sfc_efx/base: provide a stub for basic netport attach
  common/sfc_efx/base: provide defaults on netport attach path
  common/sfc_efx/base: obtain assigned netport handle from NIC
  common/sfc_efx/base: allow for const in MCDI struct accessor
  common/sfc_efx/base: get netport fixed capabilities on probe
  common/sfc_efx/base: decode netport link state on probe path
  common/sfc_efx/base: fill in loopback modes on netport probe
  common/sfc_efx/base: introduce Medford4 stub for PHY methods
  common/sfc_efx/base: refactor EF10 link mode decoding helper
  common/sfc_efx/base: provide PHY link get method on Medford4
  common/sfc_efx/base: implement PHY link control for Medford4
  common/sfc_efx/base: introduce Medford4 stub for MAC methods
  common/sfc_efx/base: add MAC reconfigure method for Medford4
  common/sfc_efx/base: fill in software LUT for MAC statistics
  common/sfc_efx/base: fill in MAC statistics mask on Medford4
  common/sfc_efx/base: support MAC statistics on Medford4 NICs
  common/sfc_efx/base: implement MAC PDU controls for Medford4
  common/sfc_efx/base: correct MAC PDU calculation on Medford4
  net/sfc: make use of generic EFX MAC PDU calculation helpers
  common/sfc_efx/base: ignore legacy link events on new boards
  common/sfc_efx/base: add link event processing on new boards
  net/sfc: query link status on link change events on new NICs
  common/sfc_efx/base: subscribe to netport link change events
  net/sfc: offer support for 200G link ability on new adaptors
  common/sfc_efx/base: support controls for netport lane count
  net/sfc: add support for control of physical port lane count
  doc: advertise support for AMD Solarflare X45xx adapters

 .mailmap                                      |    3 +-
 doc/guides/nics/sfc_efx.rst                   |    9 +-
 doc/guides/rel_notes/release_25_07.rst        |    4 +
 drivers/common/sfc_efx/base/ef10_ev.c         |   39 +
 drivers/common/sfc_efx/base/ef10_impl.h       |   19 +
 drivers/common/sfc_efx/base/ef10_nic.c        |   98 +-
 drivers/common/sfc_efx/base/ef10_phy.c        |   43 +-
 drivers/common/sfc_efx/base/ef10_tlv_layout.h |    9 +-
 drivers/common/sfc_efx/base/efx.h             |   98 +-
 drivers/common/sfc_efx/base/efx_check.h       |   24 +-
 drivers/common/sfc_efx/base/efx_ev.c          |    6 +
 drivers/common/sfc_efx/base/efx_filter.c      |    6 +
 drivers/common/sfc_efx/base/efx_impl.h        |  115 +-
 drivers/common/sfc_efx/base/efx_intr.c        |    6 +
 drivers/common/sfc_efx/base/efx_mac.c         |   56 +-
 drivers/common/sfc_efx/base/efx_mcdi.c        |   18 +-
 drivers/common/sfc_efx/base/efx_mcdi.h        |    2 +-
 drivers/common/sfc_efx/base/efx_nic.c         |   60 +
 drivers/common/sfc_efx/base/efx_np.c          | 1625 +++++
 drivers/common/sfc_efx/base/efx_phy.c         |   88 +-
 drivers/common/sfc_efx/base/efx_port.c        |    1 +
 drivers/common/sfc_efx/base/efx_regs_mcdi.h   | 5868 ++++++++++++++++-
 drivers/common/sfc_efx/base/efx_rx.c          |    6 +
 drivers/common/sfc_efx/base/efx_tunnel.c      |   18 +-
 drivers/common/sfc_efx/base/efx_tx.c          |   33 +
 drivers/common/sfc_efx/base/medford4_impl.h   |  110 +
 drivers/common/sfc_efx/base/medford4_mac.c    |  299 +
 drivers/common/sfc_efx/base/medford4_phy.c    |  156 +
 drivers/common/sfc_efx/base/meson.build       |    3 +
 drivers/common/sfc_efx/efsys.h                |    2 +
 drivers/common/sfc_efx/sfc_base_symbols.c     |    2 +
 drivers/net/sfc/sfc.c                         |    5 +-
 drivers/net/sfc/sfc.h                         |    4 +
 drivers/net/sfc/sfc_dp_tx.h                   |    3 +
 drivers/net/sfc/sfc_ef10_tx.c                 |   13 +-
 drivers/net/sfc/sfc_ethdev.c                  |  186 +-
 drivers/net/sfc/sfc_ev.c                      |   51 +-
 drivers/net/sfc/sfc_port.c                    |   27 +-
 drivers/net/sfc/sfc_repr.c                    |    7 +-
 drivers/net/sfc/sfc_repr.h                    |    1 +
 drivers/net/sfc/sfc_tx.c                      |    2 +
 41 files changed, 9000 insertions(+), 125 deletions(-)
 create mode 100644 drivers/common/sfc_efx/base/efx_np.c
 create mode 100644 drivers/common/sfc_efx/base/medford4_impl.h
 create mode 100644 drivers/common/sfc_efx/base/medford4_mac.c
 create mode 100644 drivers/common/sfc_efx/base/medford4_phy.c

-- 
2.39.5

