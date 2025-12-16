Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD5CD5CCB7
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 10:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97CB5402EA;
	Tue, 16 Dec 2025 11:35:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9768B4026C
 for <dev@dpdk.org>; Tue, 16 Dec 2025 11:35:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765881313; x=1797417313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cWp2z7WVV8oLhJxZue4kgqwYlpvtbfaqJ/SlO1noa6M=;
 b=FMSEyMyAghfs7LYeqfh/ppznyadM24gzRkV4BulPPbzR6xnUcP/pwy6m
 ICclts7upipDG28AWC4tn6derNO8HvrwNmSWl3NlI60hUJecjGkJS4yuW
 UkMyp6/rnB2yKaQdhsvZpEr1f09yAzJj6w/cdyVxiorfrFloQsK9ZMKbr
 M3mAF+kQGtdXZTVbzKABP13tW6dfZ4OYqrfxHHcQviWG/YC1KYFlXmXwL
 761+h/wjIHsPezedOomPZGn+VN0IYd7IlohQeXdfXUlEAjjqQ4d77Tys4
 hiX6pmRl9td5FQPR5vzvZvuDc4BL5eYrOa49UNxu/bt63Bp1TUn678pNg Q==;
X-CSE-ConnectionGUID: ruWeyUoFTNW/w4zEUriHEg==
X-CSE-MsgGUID: oPn7anORRe+ZcaG1azE/dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79250830"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="79250830"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 02:35:12 -0800
X-CSE-ConnectionGUID: 4P3EVyKoRfy/ZbnNT/1bGQ==
X-CSE-MsgGUID: vOJkwnU8RNqom1FMRf2vXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="197259831"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 16 Dec 2025 02:35:11 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 1/3] net/intel: prevent selection of a null Tx burst
 function
Date: Tue, 16 Dec 2025 10:35:02 +0000
Message-ID: <20251216103504.2624535-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216103504.2624535-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
 <20251216103504.2624535-1-ciara.loftus@intel.com>
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

Depending on the underlying architecture and CPU flags available, a
different set of Tx paths may be defined by a driver using the common
path selection infrastructure. However the Tx path selection function
iterates through the entire array of potential Tx paths, regardless of
whether they are available for selection by that platform. This could
result in a null Tx burst function being selected. Fix this by
discarding paths with a null Tx burst function from selection.

Fixes: 336374d8454c ("net/intel: introduce infrastructure for Tx path selection")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 24fcfbe225..b259d98904 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -307,6 +307,10 @@ ci_tx_path_select(const struct ci_tx_path_features *req_features,
 	for (unsigned int i = 0; i < num_paths; i++) {
 		const struct ci_tx_path_features *path_features = &infos[i].features;
 
+		/* Do not select a path with a NULL pkt_burst function. */
+		if (infos[i].pkt_burst == NULL)
+			continue;
+
 		/* Do not select a disabled tx path. */
 		if (path_features->disabled)
 			continue;
-- 
2.43.0

