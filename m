Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146DE606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a/73UVE4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CEB840A82;
	Thu, 22 Oct 2026 18:52:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0E80040A6C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687941; x=1824223941;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/uKghI42qOikZEDd7fa0V9ipKDj7yvNU0v77mKuJrSg=;
 b=a/73UVE4pmQ59tGl7JqQHJvSOauHcbuNiMhedtR0fw1RcEgf2g5o9Aab
 5ebo20t10oIrR2sTIxQFnzkDzoKAmp6oJK87KJEz0sqiofjzAMLiTdi8G
 XZ43VCiQaX7j13fGb/yDNlC9CgmXh0+oct01Fhl/O57Quqw28fVFSSF7y
 jWl776TAEbK6OQbwkBX+zVvFHI36jo8ZeefQnt9Kz60qEgEuQmlbmZj2H
 4zufMvNj3JIOQxYFv2Tj/BzsCZRZnjKwcJkWXc7fQpSe21K7gWUt2ayKA
 5IvRhp8qkRhuchR7/bP+1uktg/bG2HYCxALjRJ1EQLQPPw/11D0fMYhZY A==;
X-CSE-ConnectionGUID: S7EBAj3dR7KGXqKaGNT2Tg==
X-CSE-MsgGUID: lNeITigLRVWE9niuOHfEPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341054"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341054"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:20 -0700
X-CSE-ConnectionGUID: tD3JyECdRJ+MoVVjcrg2rQ==
X-CSE-MsgGUID: xPMp1ECAQsiyKoDxGYNuBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507862"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:19 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH 9/9] net/ice/base: update version info
Date: Thu, 22 Oct 2026 16:52:05 +0000
Message-ID: <20261022165205.1830735-10-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update version to indicate when last driver snapshot was generated.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/README b/drivers/net/intel/ice/base/README
index 6e17debcb2..97236b80ac 100644
--- a/drivers/net/intel/ice/base/README
+++ b/drivers/net/intel/ice/base/README
@@ -6,7 +6,7 @@ Intel® ICE driver
 ==================
 
 This directory contains source code of ice base driver generated on
-2025-10-01 released by the team which develops
+2026-10-21 released by the team which develops
 basic drivers for any ice NIC. The directory of base/ contains the
 original source package.
 This driver is valid for the product(s) listed below
-- 
2.43.0

