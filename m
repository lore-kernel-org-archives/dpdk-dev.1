Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD58CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 14:22:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67BB840A77;
	Tue, 16 Sep 2025 16:21:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 494DE4069D;
 Tue, 16 Sep 2025 16:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758032486; x=1789568486;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0hGKqLKIyD40Vwy7mulTWI+POcsXVysLRE9iXE5Izdc=;
 b=hUHRmYAgHZ4sQVJ5+jZc3MR+oD3ykWlfQj+mct4aZQKfFxr/Q9p0nJ5w
 MoFPa80muPUTdtY2uCZa94yTiQvqKBlzohk4rVRn75K3Nz0MbLNOjQ6Bo
 n7MHOkiG8YGHVfgi4zzaHAYGM0j+21KsJSQcvynNdVABKJHGXj2LmUbXz
 BrfA3FU7j7Sj45zQ0uBxMeEjC9KvMc3TFuJzbgddWmKAxFely9azPe7dF
 N7ydiuFIRfPCfqsfZXT+K9r0d5jd8KII957VJXZV0V0484AsMTIXY894C
 UDTaH44u/ao62KQjLIHFPAc3kF+SXS4NOvR4tQUXuKKEIvBqb++JNgjt3 Q==;
X-CSE-ConnectionGUID: 9YpXcCwXT+2krgkDj318Ow==
X-CSE-MsgGUID: 9nWSn0m4RSyKAWASbrVI+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71681344"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="71681344"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 07:21:25 -0700
X-CSE-ConnectionGUID: F00YML4ZTGyd0NiQcC9UHQ==
X-CSE-MsgGUID: as4YEYRvQt2RQhOTAhtsHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; d="scan'208";a="212115246"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 07:21:25 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 8/8] net/iavf: document support for extended statistics
Date: Tue, 16 Sep 2025 14:21:13 +0000
Message-Id: <20250916142113.3485738-9-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916142113.3485738-1-ciara.loftus@intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
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

The extended statistics feature has been implemented since commit
d38a06bf4367 ("net/iavf: add extended stats"). Update the list of
supported features to reflect this.

Fixes: d38a06bf4367 ("net/iavf: add extended stats")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/features/iavf.ini | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/guides/nics/features/iavf.ini b/doc/guides/nics/features/iavf.ini
index 63c89ee28f..74c1910ca3 100644
--- a/doc/guides/nics/features/iavf.ini
+++ b/doc/guides/nics/features/iavf.ini
@@ -41,6 +41,7 @@ Packet type parsing  = Y
 Rx descriptor status = Y
 Tx descriptor status = Y
 Basic stats          = Y
+Extended stats       = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
-- 
2.34.1

