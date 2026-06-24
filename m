Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59016CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:37:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EA8040698;
	Wed, 24 Jun 2026 12:37:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 959644066D;
 Wed, 24 Jun 2026 12:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782297436; x=1813833436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ARFScWF1SpsR5RK5gRktBKOXfw/aZYJlk7N+Rz0uTIs=;
 b=NFtRJL+QnxUIRFxdEoFzzrTGgGS7ns9PxidzKSaR0COTfw6gYQqWDxoK
 0YP0fAe1gjQvguLEkNoprice68aduraRr+stXmFnxVfWqBraxisx/2bTm
 DqNRqXNFm6PWGunTOenbyJNacpgIstNGPX4tlufpiVuRh9CL8gwTwP0PI
 QtQKVDuap/LlUpY2QhI7T8bqZ02HR4d7PQMDW28WwAid9qD5rFV2Qrhwl
 vrlWLOIkFQZuZLhQxuey+GoIWSy4ZTsVxD1BJ4jdNZGXh7GwWVeaHd8TT
 SG1OpotdlUATzdbvSa/w4m34BgnBK54W/2jkpL4OvAjF1NobFe9oDif2F w==;
X-CSE-ConnectionGUID: SsMudEkESbS6bVi51kwTuA==
X-CSE-MsgGUID: 8X/MCg3URXum3uN7YE/ZWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93652352"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93652352"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:37:15 -0700
X-CSE-ConnectionGUID: C8Gf64yGROOGd6rYPMTGKQ==
X-CSE-MsgGUID: 57utykWDShadplU5q9OPTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245460045"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2026 03:37:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Julien Aube <julien_dpdk@jaube.fr>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Harish Patil <harish.patil@cavium.com>
Subject: [PATCH v2 07/17] net/bnx2x: replace strncpy with strlcpy
Date: Wed, 24 Jun 2026 11:36:46 +0100
Message-ID: <20260624103658.792750-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624103658.792750-1-bruce.richardson@intel.com>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260624103658.792750-1-bruce.richardson@intel.com>
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

