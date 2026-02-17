Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C096E6816F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 11:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DACF402A2;
	Tue, 17 Feb 2026 12:03:28 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 8A418400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 12:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1771326206;
 bh=Y0xY5I3GQFsAphfCRuq8GZRgB6HftBOtAKSCUXER3VA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CL9uzGcQ0p9vFzWZ2ygbrT6d7Olqbgu0IehP5EgwDX+VVvLMIsj/WS226KCoDKSQq
 rZZX5efuJ++1kag4G2nRkuMlsIRm2QGXgv4x3imOnG5XbTwbuX9+T22ZDtgBX/h/MB
 IyH1ebZdvmMV64D/dhvmrZWaDE7cfmn8HANsmCkgBsvD42Pi2LEdzkZ4TtP3DPS8tv
 VIojeptPpq+DgCijh+61YXlkV9UsuWGWtiB6UWDAXTPtBRuXggQkfVd6NSoFuwVT94
 8fpkoq48c19sxRH7pS+mpRP/ZqWDsMZj+ExtNby/wXDNDYuzfpyghw3MOxvbpqD/vz
 DLCj+WkU87/aA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 41F1E118013D;
 Tue, 17 Feb 2026 12:03:26 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v2 0/6] net/nfb: ethernet enhancements
Date: Tue, 17 Feb 2026 12:03:18 +0100
Message-ID: <20260217110324.3344310-1-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206170435.302184-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
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
Depends-on: series-37385 ("net/nfb: rework to real multiport")

v2:
* P2/7: close MDIO handles in error path of nfb_nc_eth_init
* P2/7: add bounds check for eth_node population
* P2/7: add check for nfb_mdio_if_read_pma() return value
        in nfb_mdio_cl45_pma_get_speed_capa()
* P2/7: add include guard to nfb_mdio.h
* P3/7: move nfb_eth_dev_set_link() (PMA configuration)
        before MAC enable/disable call to avoid inconsistency on failure
* P4/7: add check for nfb_mdio_if_write_pma() return value
* P5/7: set dev_info->max_mtu
* P5/7: add frame_len_max_cap to struct pmd_priv; used in MTU configuration
* P5/7: extract nfb_mac_read_frame_len_max_cap() from nfb_eth_mtu_set()
* P5/7: check for MTU overflow
* P6/7: use direct value for stats->ierrors from rx_cntrs
* P7/7: remove this patch completely and distribute release notes update
        to matching patches

Martin Spinler (6):
  net/nfb: use MAC address assigned to card
  net/nfb: get correct link speed
  net/nfb: support real link-up/down config
  net/nfb: support setting RS-FEC mode
  net/nfb: support setting Rx MTU
  net/nfb: read total stats from macs

 doc/guides/rel_notes/release_26_03.rst |   3 +-
 drivers/net/nfb/meson.build            |   1 +
 drivers/net/nfb/nfb.h                  |   8 +
 drivers/net/nfb/nfb_ethdev.c           | 247 +++++++++++++++++++++----
 drivers/net/nfb/nfb_mdio.c             |  44 +++++
 drivers/net/nfb/nfb_mdio.h             |  39 ++++
 drivers/net/nfb/nfb_stats.c            |  40 ++--
 7 files changed, 335 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/nfb/nfb_mdio.c
 create mode 100644 drivers/net/nfb/nfb_mdio.h

-- 
2.53.0

