Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD85CF3187
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 10:35:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4506A402E3;
	Wed, 19 Nov 2025 11:35:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 50F9540262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 11:35:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763548543; x=1795084543;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=wmw1PBcaFC2IZuzJgWW2eOM7ISzcfdsAhqTUdvRQbu8=;
 b=fZud/C7LDYCNZKRJdedVC7iVPzIKy00mjj0lF7YAb/pyU87txEpTVyXC
 1d06KkCYaLNpbeN74FbCPiZ4weIJJuBF+iMv6m6jatL6w/E/c6kHi8E1S
 cyHprgqpNCjpjcbrGvXIGQAph4ZgFS/6BMG06gvDqtHs7qgafU+nl0NDD
 /6P+H0ABMSfvD8k36qdbCe5GNAWe0WYhcyCmQI5MQiqXqtyJeKJBytefv
 feKyvbCXSVfTJCfT9qxYLWw0xugtDvk+7EC4R/eLd8OzBm9Wwe6xK4JBx
 bC4O3v0/GsJMoTnd94upy7fLTo7ELtHV8I53Mw1AyZc5vXCXR4prJIgip A==;
X-CSE-ConnectionGUID: m/aOo+bsR6yJUSCCGNL5JQ==
X-CSE-MsgGUID: Rl51BjlNTwu/3ubCtoO9JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="91060581"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="91060581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 02:35:42 -0800
X-CSE-ConnectionGUID: 3dB7KzkCREWUr3H5RwFRnw==
X-CSE-MsgGUID: 9WjioN7RSQePU989Valr7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="190816845"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 02:35:41 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/2] doc: add deprecation notice for VFIO API
Date: Wed, 19 Nov 2025 10:35:37 +0000
Message-ID: <3c36c80d14d463815c6f09e58fd45638831e82d8.1763548356.git.anatoly.burakov@intel.com>
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

The entirety of VFIO API will be either made internal and only available to
drivers, or will be removed. Add upcoming changes to deprecation notices.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 doc/guides/rel_notes/deprecation.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 8653d6ca03..55d3837150 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -147,3 +147,7 @@ Deprecation Notices
   This change will not result in any feature loss,
   as the fallback scalar paths which have feature parity with SSE
   will be used in the cases where the SSE paths would have been used.
+
+* eal: The entire VFIO API (``rte_vfio_*``) will be made internal only, and will only be available to EAL and drivers.
+  Group-based API (``rte_vfio_*_group_*``) will be removed and replaced with unified container device assignment API.
+  This change will be made in 26.11 release.
-- 
2.47.3

