Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB2ECE8D5F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:40:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 501A7410ED;
	Fri, 14 Nov 2025 18:40:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 423E840288
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142037; x=1794678037;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=idh/xhzeG3asr41E/uoa0dln/1WOsR6FrNZ4FNEnsb4=;
 b=Lm9XBPHSsCiyGx6hkDfELbJaN7yo9WTPGPkPNFg23VGJwsWxRjX1Iwcl
 Uwc29Z2G12ZlFYqGeUUqBPtWqEtP3D1c6whjQfO9UnNylaFD+0vmg6yWt
 hcu8rzbEeKAfP3DHJ+Ba32Y2mWuplINv1Cil2cJU3ZrqAr7K1537NccjB
 3nnlY2+852ZEh+nkTMBWPppuZvpuK3rMAELR6TLU62wveJw247NXcp3kh
 14SfPMECor6IRGUraHNm9kpF/A/3hL/Vq65VebZQmCjCT10AZah1TS4Cx
 GJ1Xwq0lB00Vq6et8sEp5D1OCgsyFBwSZq8hnp4NFU+jFYLMdUbl+2inn g==;
X-CSE-ConnectionGUID: jaieGU1tRgim9BKzeOOWaw==
X-CSE-MsgGUID: LhX7Ilc0SWmDFJeNUfaxWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864253"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864253"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:36 -0800
X-CSE-ConnectionGUID: 4ySTs89UT2a7CRA9V/kUWA==
X-CSE-MsgGUID: QW2+rz7YREaH0iHRXBSu9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650720"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:36 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 02/19] doc: add deprecation notice for vDPA driver API
Date: Fri, 14 Nov 2025 17:40:12 +0000
Message-ID: <232e6e2f059b254e6953911ed869f3accb2da175.1763142007.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
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

Currently, vDPA driver API is partly built around VFIO group API, which
will be removed in a future release and replaced with a device container
assignment API. Make this know in deprecation notice.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 5e3df71048..e2c08387fe 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -162,3 +162,6 @@ Deprecation Notices
 * eal: The entire VFIO API (``rte_vfio_*``) will be made internal only, and will only be available to EAL and drivers.
   Group-based API (``rte_vfio_*_group_*``) will be removed and replaced with unified container device assignment API.
   This change will be made in 26.11 release.
+
+* vdpa: vDPA driver API will no longer offer ``get_vfio_group_fd`` as part of its internal API.
+  All drivers will be adjusted to use the new unified VFIO container device assignment API.
-- 
2.47.3

