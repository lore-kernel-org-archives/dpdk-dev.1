Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7793FCDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 16:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2003B406BC;
	Tue, 23 Jun 2026 18:52:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 7F0724066D;
 Tue, 23 Jun 2026 18:52:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233529; x=1813769529;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ARFScWF1SpsR5RK5gRktBKOXfw/aZYJlk7N+Rz0uTIs=;
 b=SbQyPUVnmo6BNLis00z57zWjVhRgkkLM8F2d4gKMi3/2JTKf/hZTBdZ0
 bzOjieUCv5NIaJrYALEt0qmVwXD32hNQsI5V8HeelQlNWQdfmV7az59Gx
 PLITKaOPfjQfcnxcbM6jFOdR/0C3bf3PTIgrGkoGHeAEzTqUOtEVfZhug
 f4hiqP27J3/sHl7wxLxdfudJ+JUl1SGN/yfFnjc0C9aSQpwwbK4z+r5BY
 KDqiIAy5GvJaPKOIgIkS9EAZMPtszn67gHoOcfsaCBwJcPEMz69b1VVV/
 1BJBIdou8V9/uTcBVsEjLTiIITFyi+DtBhjkdaf7cXEoc2vWmJHPwH34w Q==;
X-CSE-ConnectionGUID: ITkSXiK/Re6yyMojjsrM4A==
X-CSE-MsgGUID: LjJo4lulTf22jWcqG8bpiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100534642"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="100534642"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:52:08 -0700
X-CSE-ConnectionGUID: yeOWJL2cR0KibebQ9xs3sw==
X-CSE-MsgGUID: FHvlB8TjT1+IY8rWyGPIKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="253928321"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 23 Jun 2026 09:52:06 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Julien Aube <julien_dpdk@jaube.fr>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Harish Patil <harish.patil@cavium.com>
Subject: [PATCH 07/17] net/bnx2x: replace strncpy with strlcpy
Date: Tue, 23 Jun 2026 17:51:37 +0100
Message-ID: <20260623165150.765443-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623165150.765443-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
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

Replace strncpy() with safer strlcpy() which always null-terminates.

Fixes: 540a211084a7 ("bnx2x: driver core")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/bnx2x/bnx2x.c      | 2 +-
 drivers/net/bnx2x/bnx2x_vfpf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 8790c858d5..1a3956b224 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -3596,7 +3596,7 @@ static void bnx2x_drv_info_ether_stat(struct bnx2x_softc *sc)
 {
 	struct eth_stats_info *ether_stat = &sc->sp->drv_info_to_mcp.ether_stat;
 
-	strncpy(ether_stat->version, BNX2X_DRIVER_VERSION,
+	strlcpy(ether_stat->version, BNX2X_DRIVER_VERSION,
 		ETH_STAT_INFO_VERSION_LEN);
 
 	sc->sp_objs[0].mac_obj.get_n_elements(sc, &sc->sp_objs[0].mac_obj,
diff --git a/drivers/net/bnx2x/bnx2x_vfpf.c b/drivers/net/bnx2x/bnx2x_vfpf.c
index 5411df3a38..23f576877f 100644
--- a/drivers/net/bnx2x/bnx2x_vfpf.c
+++ b/drivers/net/bnx2x/bnx2x_vfpf.c
@@ -303,7 +303,7 @@ int bnx2x_vf_get_resources(struct bnx2x_softc *sc, uint8_t tx_count, uint8_t rx_
 
 	PMD_DRV_LOG(DEBUG, sc, "status block count = %d, base status block = %x",
 		sc->igu_sb_cnt, sc->igu_base_sb);
-	strncpy(sc->fw_ver, sc_resp.fw_ver, sizeof(sc->fw_ver));
+	strlcpy(sc->fw_ver, sc_resp.fw_ver, sizeof(sc->fw_ver));
 
 	if (rte_is_valid_assigned_ether_addr(&sc_resp.resc.current_mac_addr))
 		rte_ether_addr_copy(&sc_resp.resc.current_mac_addr,
-- 
2.53.0

