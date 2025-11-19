Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FD4CF3187
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 10:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50DA7402EB;
	Wed, 19 Nov 2025 11:35:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id DFA7240262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 11:35:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763548543; x=1795084543;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Xjvls6fULvkTZRFDOdfWC5Txu4jWT15Qkz2bCJYPrKE=;
 b=blDpugXcaY7KUl3thboX70ev6cul++HL3Bs69AulGep9ZQnVgwCA8+uh
 FSPm/5Zc6p/wbphDy1IvLLMtjXASfPP20T+DzkerPtqkr3fX2uaSNBfVL
 XMc9UitqMkZ2gEla/P2zSTl33eRS8ISXPBHw3w7L69QycxDTJqByAhCcq
 0WHLYb2/c9cifGGukt3ypDppbcRD5w6DqZ9693WSgzY4AxFwdQ7KwA1mg
 VLaVohAebNvMd0D4A0fjNC7B4ERhbShhAG7B086vDOceZYHG3sSlZxGkn
 YlAiXVUBs3oV/hsY6Mf+62lNvpz5k1jW7flkvC9aksvzPLxki2Ccrj0HE A==;
X-CSE-ConnectionGUID: xKZi7/EJQeyVn619YI5CIQ==
X-CSE-MsgGUID: 5yock8ZsRyyQeeZ6yD1Sag==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="91060584"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="91060584"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 02:35:43 -0800
X-CSE-ConnectionGUID: c2LhA9u2Snqp0RoYVPSP9Q==
X-CSE-MsgGUID: KKa9ZdzcQPCuqdJ3IEXsrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="190816850"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 02:35:42 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 2/2] doc: add deprecation notice for vDPA driver API
Date: Wed, 19 Nov 2025 10:35:38 +0000
Message-ID: <a816720dff092ddc02ff9fcf734a353505fbcd6d.1763548356.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763548356.git.anatoly.burakov@intel.com>
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
index 55d3837150..b63dc8b715 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -151,3 +151,6 @@ Deprecation Notices
 * eal: The entire VFIO API (``rte_vfio_*``) will be made internal only, and will only be available to EAL and drivers.
   Group-based API (``rte_vfio_*_group_*``) will be removed and replaced with unified container device assignment API.
   This change will be made in 26.11 release.
+
+* vdpa: vDPA driver API will no longer offer ``get_vfio_group_fd`` as part of its internal API.
+  All drivers will be adjusted to use the new unified VFIO container device assignment API.
-- 
2.47.3

