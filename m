Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F37CD98F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4A8A40A84;
	Thu, 18 Jun 2026 16:11:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0C990406BC
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781791910; x=1813327910;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hpQP0fCypU5iPkdnpO/KH1J/w6fHsQ4HSmeIKqJHKP4=;
 b=VdHWvJfKRRPefHUvYHKga7xZFukHEHehChBOcwlQwcuZk+vM9ocBo1OP
 LmzhhxcZopeX0JOfuXcTjJxfnOCK8skzbr7uK70+1TEsHxOXo9R/ecAj+
 cKaV/1xr+mIEdJrjYZ68FNyAGadumQrbjGpi4KtME9PWWhA7kzEI8Mknn
 JQmSuYy6aoivim+xePvUmIp4HR8REF8Xyun7zd+4tV+XfnyRwaYWzDc7g
 iB7bD5N5ig085QIn9UDpObMcqvYy0ZVTT53q6AlVF4suzmyX6IP5eAqjY
 nRe0SeULcLdyEUPLnU99LvMgJaWWSCWDO31Wbi5BPkRTqcPd5QwmPKixG A==;
X-CSE-ConnectionGUID: 7JoT5JrSS/S7EjNdu93EIA==
X-CSE-MsgGUID: Zf9tb6HdTR2/uUbeF1MSMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82628755"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82628755"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:11:49 -0700
X-CSE-ConnectionGUID: rmhHVNbhRF+ZA+cUAs1LCw==
X-CSE-MsgGUID: Iheb1/pXS1WjNAxRkO7GuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="244211262"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2026 07:11:48 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v2 6/7] net/iavf: disable runtime queue setup capability
Date: Thu, 18 Jun 2026 10:38:36 -0400
Message-ID: <20260618143837.310156-7-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618143837.310156-1-dawid.wesierski@intel.com>
References: <20260618143837.310156-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

Remove the advertisement of RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP
and RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP capabilities from the
iavf VF driver.

Runtime queue setup on E810 VFs causes queue state corruption when
queues are dynamically reconfigured while the hardware rate limiter
is actively pacing TX queues. Queue configuration messages to the PF
via virtchnl can race with ongoing TX operations, leading to undefined
behavior.

By not advertising these capabilities, all queues are configured at
port start and remain stable throughout the port lifecycle.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index ec1ad02826..ab223e6afd 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1160,9 +1160,6 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->reta_size = vf->vf_res->rss_lut_size;
 	dev_info->flow_type_rss_offloads = IAVF_RSS_OFFLOAD_ALL;
 	dev_info->max_mac_addrs = IAVF_NUM_MACADDR_MAX;
-	dev_info->dev_capa =
-		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
-		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
 	dev_info->rx_offload_capa =
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

