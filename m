Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728B8CEE339
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4807C402E7;
	Tue, 18 Nov 2025 17:29:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B511A4027D
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483370; x=1795019370;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=idh/xhzeG3asr41E/uoa0dln/1WOsR6FrNZ4FNEnsb4=;
 b=a2TpIAPMK7l7cbJwoWZ9YpI0+pILDL2T8w++0z9dhhej2kI0XgysMnY2
 dyBRM/L+eWlh88E0QJ3LBltqMNV0UMsApgVNxRUCTLRFODZ7WHRuA99gG
 TtmyMr+LG4Ezq5OAoP++HuswNM4+Jma5Ql4IuRVpZJ8VCSi953n8bqBru
 eKpt85GWeptLsA7t16JwtILeN1Sh5fPnzUmWQhP3EP+cRM6IGys4fqqRi
 mQEiceCrhoNv6ce44crf1sEjq64loOqi3AyMpKee+ymzgR66R5f5NN/cF
 FBZqjy8Hq1z3rNHNsmNdPesRUCN0v4+dxnhxliFTmhofageHG23SBkr3C w==;
X-CSE-ConnectionGUID: j7vmDaZ+Rz2XPpHSXclSlw==
X-CSE-MsgGUID: EMGbzxYcTd2hrkJhwiptHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550583"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550583"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:29 -0800
X-CSE-ConnectionGUID: KG0pGNKEQGOKJ+j7e+NHJg==
X-CSE-MsgGUID: qxJiWmYlSjm1zAueCqrBhw==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:28 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 02/20] doc: add deprecation notice for vDPA driver API
Date: Tue, 18 Nov 2025 16:29:03 +0000
Message-ID: <d68cf614a2a4294ad91c5407235efb521be3abc5.1763483253.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763483253.git.anatoly.burakov@intel.com>
 <cover.1763483253.git.anatoly.burakov@intel.com>
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

