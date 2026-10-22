Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14C8606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mDUh/gGu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0206A40A8A;
	Thu, 22 Oct 2026 18:52:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1343F4069F
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687939; x=1824223939;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pmq9BqNJoSE2wLvSZLFzq91qJSiwakl/Y1SfY2DG4Jg=;
 b=mDUh/gGuWC+VVo+dKc21JxDOEHHgeWyqoVlwFi3OqWahshWQTi2NZvVf
 wkilDDyTEzDS8d8GdPUrg9/BMhsiYsuqBJMPUNgyvcJ1honvh8JTRJYv6
 Gh6ZRccb2PKaoLju9WSduXOyLliiSREu+So2RnwH7P2GEtUG6iYAKTaf9
 JBqTI0mxkKuckPSHVgn9EhstAHMHXsr26iUf57uc8PEfJgvRddIZEuYnB
 HeHCrIdgMlQykn6gNgWl+++z7B6TqgyhOMeyn96eZf5MaX2AoXs243dLi
 OKuvtrr/sn66SeOlAZKBYPFu9JTukHLGc94lf2AIlrdIw9kfNFIPBLF6j A==;
X-CSE-ConnectionGUID: hEDaAyRjTMaoK/9nqBTj9A==
X-CSE-MsgGUID: +7aYl/X9QCi0Bl2qNzPUNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341049"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341049"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:18 -0700
X-CSE-ConnectionGUID: W3boPC8qR2K3rwC4Rj28lA==
X-CSE-MsgGUID: h0fxYiaLSA+Us/qo32Dn7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507849"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:16 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Przemyslaw Gierszynski <przemyslaw.gierszynski@intel.com>
Subject: [PATCH 7/9] net/ice/base: add RDE WoL override capability bit
Date: Thu, 22 Oct 2026 16:52:03 +0000
Message-ID: <20261022165205.1830735-8-vladimir.medvedkin@intel.com>
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

From: Przemyslaw Gierszynski <przemyslaw.gierszynski@intel.com>

Add the RDE WoL override bit of the WoL and proxy support capability,
and the corresponding capability field.

Signed-off-by: Przemyslaw Gierszynski <przemyslaw.gierszynski@intel.com>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_type.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index 28d0387608..066141b656 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -723,9 +723,11 @@ struct ice_hw_common_caps {
 #define ICE_WOL_SUPPORT_M		BIT(0)
 #define ICE_ACPI_PROG_MTHD_M		BIT(1)
 #define ICE_PROXY_SUPPORT_M		BIT(2)
+#define ICE_RDE_WOL_OVERRIDE_M		BIT(3)
 	u8 apm_wol_support;
 	u8 acpi_prog_mthd;
 	u8 proxy_support;
+	u8 rde_wol_override_support;
 	bool sec_rev_disabled;
 	bool update_disabled;
 	bool nvm_unified_update;
-- 
2.43.0

