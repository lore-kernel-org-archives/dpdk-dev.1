Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66C6E81BA6
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:59:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0F5C40689;
	Mon,  9 Feb 2026 12:58:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6470340669
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:58:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770638313; x=1802174313;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YOD1W7TzjxbFdWHCWnh6lhTFvBMOv3+/us8v/3PAdYU=;
 b=fz7K3D+t12r4MgvXP8uiMrEDB5iP2hAz/m1kLaIsGT2j1sHxTF/L6XA2
 DtI3rhqUkmcFDdFpPD+d9jchNNccbFTQbbyuDG+X83phTMqurehMU/3qB
 Ad44YBegiwIBWlLzdkEDxq0vgeKFg2M5DYHqzU1pnld05WbrX56bVM16Z
 FsGB+1rWUnACO7GlcHqzNbFa3gg1GelUBwkHT7JY7/L9SndDihWnA3J3l
 AXlvtLBZ939ilmEmf7L4SHnIN/rfJ/CWpn4B1tzquRqdFkz0BWnHGAGKP
 GwTr+KmDyrHkgTJjSeFmUHY6ISlyhMZaLec71UGXzZIL/6WzqlQhiLvj/ g==;
X-CSE-ConnectionGUID: mnOEeB1ZTcm7PkjiDviZQg==
X-CSE-MsgGUID: e/YheCEpScipP4BGUV99pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71640982"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71640982"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:58:32 -0800
X-CSE-ConnectionGUID: IgnqtVGNTrmrGOfjq68t8w==
X-CSE-MsgGUID: u20n7kmbRd+YzbRq4VVUOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211627119"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 03:58:31 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2 7/7] doc: update release notes
Date: Mon,  9 Feb 2026 17:26:57 +0530
Message-Id: <20260209115657.636525-8-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209115657.636525-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20260209115657.636525-1-shaiq.wani@intel.com>
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

Documented the new ice driver FDIR support for
L2TPv2 over UDP in the 26.03 release notes.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 doc/guides/rel_notes/release_26_03.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 031eaa657e..5e955a3ec4 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -63,6 +63,10 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
+* **Updated Intel ice driver.**
+
+  * Added Flow Director (FDIR) support for L2TPv2 over UDP.
+
 
 Removed Items
 -------------
-- 
2.34.1

