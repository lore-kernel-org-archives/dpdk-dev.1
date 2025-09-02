Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEABCA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:28:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BCAE406BB;
	Tue,  2 Sep 2025 19:27:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 536444066E
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834047; x=1788370047;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cMjRHQ4aCVgMuen84hdZCMrFYV7NH+ucfQkiUIxzPt4=;
 b=oIerrgSGbOweGZfe+qP05298EGgI4qmScNT19b9l6CuqStl6D5St3mcN
 HfrMaptA3g6fSYOVGVSislewbjsQmZI8CfB0DpHq6oiGDq0L7yPZ8qHKB
 Mo5N+2sYG3W9uWaNLEIOCKVfne5kkpTDgkuUEUXOd8fa0gsU4ddACI9hj
 cskQhL0fhp0ytCsLTFKMCxkEQNr868HNOj3wpyIQnAqY4ndQpfnqXfN1S
 9fsaEG38pf1l/QX8u7nadlsbJ9RjZNYK/SqTtb+UdzKahxcUA3FVsfWBv
 yqvTI8a6wba9eMJHgMqm5TXyBSEs+4vVow1ZIj0xKcVP9/Y7NPe9FpxBZ Q==;
X-CSE-ConnectionGUID: TgIWUlMFTE2SnBQoTvuQZQ==
X-CSE-MsgGUID: 9VQ1ktuYSbiIv7h+vFwhfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69732011"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69732011"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:24 -0700
X-CSE-ConnectionGUID: a3EDFUH2Ql+yM8aqZ4YemA==
X-CSE-MsgGUID: qD9PppAmT3Of1E6CYARmAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229127"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:24 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 08/12] net/ice/base: add missing health status defines
Date: Tue,  2 Sep 2025 18:26:58 +0100
Message-ID: <34878b40937a7b6bddaae1467e307ea52341a3bc.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
References: 
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

From: Stefan Wegrzyn <stefan.wegrzyn@intel.com>

Added missing defines for commands related to health status.

Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_adminq_cmd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_adminq_cmd.h b/drivers/net/intel/ice/base/ice_adminq_cmd.h
index 34b008f5fd..36656b0aad 100644
--- a/drivers/net/intel/ice/base/ice_adminq_cmd.h
+++ b/drivers/net/intel/ice/base/ice_adminq_cmd.h
@@ -3184,6 +3184,7 @@ struct ice_aqc_set_health_status_config {
 #define ICE_AQC_HEALTH_STATUS_SET_PF_SPECIFIC_MASK	BIT(0)
 #define ICE_AQC_HEALTH_STATUS_SET_ALL_PF_MASK		BIT(1)
 #define ICE_AQC_HEALTH_STATUS_SET_GLOBAL_MASK		BIT(2)
+#define ICE_AQC_HEALTH_STATUS_DISABLE_HISTORY_MASK	BIT(3)
 	u8 reserved[15];
 };
 
@@ -3224,6 +3225,7 @@ struct ice_aqc_set_health_status_config {
 #define ICE_AQC_HEALTH_STATUS_ERR_BMC_RESET			0x50B
 #define ICE_AQC_HEALTH_STATUS_ERR_LAST_MNG_FAIL			0x50C
 #define ICE_AQC_HEALTH_STATUS_ERR_RESOURCE_ALLOC_FAIL		0x50D
+#define ICE_AQC_HEALTH_STATUS_INFO_DPLL_LOCK			0x601
 #define ICE_AQC_HEALTH_STATUS_ERR_FW_LOOP			0x1000
 #define ICE_AQC_HEALTH_STATUS_ERR_FW_PFR_FAIL			0x1001
 #define ICE_AQC_HEALTH_STATUS_ERR_LAST_FAIL_AQ			0x1002
-- 
2.47.3

