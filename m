Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3659B606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A11IWG1L
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ACCC40A76;
	Thu, 22 Oct 2026 18:52:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 09E0F40664
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687938; x=1824223938;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8zTrKAPT/Lmd1P8kuOFwltqJTTkpDePl6zEW8iGSJg8=;
 b=A11IWG1LvXP5JqK8+hVdHnSQ0yOCoDE2JRdlL6Ac+ytcxzhf/yg2uk+d
 ryLjwaVLUnH9IDAYq6hRc5BgBS+Fffr4iYKbwEjpaWOJBhHwwkxJYa6QO
 HYWg+oY90imJTeM0Aqi/gxPQw95AxFJRZvqImOZw2DVIPk/OJjK8Yeb1e
 ug4iXFQ5EQF8mJncstNVUumdHDoxLNwruCar4oYN8z8Hl+7Xdz2QmCxuV
 VVhwTr/FA7sPumHmhp9SV7ArDmHvzlE86yT8H6b5SpSsGl9s4pjYc1nJl
 55w6c98mSSpfD6B5O8qemVXfYTAl5oJwkeszBQAWyiz0aJ9oxFZ2mCNg5 g==;
X-CSE-ConnectionGUID: uaxDOfkpSsms5vJ8odO/TQ==
X-CSE-MsgGUID: Lxo/Ta+4QI+dnjnuhLqWzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341041"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341041"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:17 -0700
X-CSE-ConnectionGUID: 4+qXWBkpQdi2PsJ17ik+Ew==
X-CSE-MsgGUID: 9lDhRBZ8T6uGGckEnoTlKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507843"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:15 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Subject: [PATCH 6/9] net/ice/base: add NVM write flags for eRoT minSREV update
Date: Thu, 22 Oct 2026 16:52:02 +0000
Message-ID: <20261022165205.1830735-7-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefan Wegrzyn <stefan.wegrzyn@intel.com>

Add NVM write command flags for the opt-in mode, and for updating the
minimum security revision of the external Root of Trust (eRoT).

Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_adminq_cmd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_adminq_cmd.h b/drivers/net/intel/ice/base/ice_adminq_cmd.h
index 7b318b0a1b..473501a6b2 100644
--- a/drivers/net/intel/ice/base/ice_adminq_cmd.h
+++ b/drivers/net/intel/ice/base/ice_adminq_cmd.h
@@ -2019,6 +2019,11 @@ struct ice_aqc_nvm {
 #define ICE_AQC_NVM_PRESERVE_ALL	BIT(1)
 #define ICE_AQC_NVM_FACTORY_DEFAULT	(2 << ICE_AQC_NVM_PRESERVATION_S)
 #define ICE_AQC_NVM_PRESERVE_SELECTED	(3 << ICE_AQC_NVM_PRESERVATION_S)
+#define ICE_AQC_NVM_OPT_IN_MODE_S		4 /* Used by NVM Write only */
+#define ICE_AQC_NVM_OPT_IN_MODE_M		(1 << ICE_AQC_NVM_OPT_IN_MODE_S)
+#define ICE_AQC_NVM_OPT_IN_MODE_ASYNC	0
+#define ICE_AQC_NVM_OPT_IN_MODE_SYNC	1
+#define ICE_AQC_NVM_EROT_MINSREV_UPDATE	BIT(5) /* Used by NVM Write only */
 #define ICE_AQC_NVM_ACTIV_SEL_NVM	BIT(3) /* Write Activate/SR Dump only */
 #define ICE_AQC_NVM_ACTIV_SEL_OROM	BIT(4)
 #define ICE_AQC_NVM_ACTIV_SEL_NETLIST	BIT(5)
-- 
2.43.0

