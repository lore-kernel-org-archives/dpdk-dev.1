Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B05AD44176
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Dec 2025 10:34:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E41E40E1D;
	Fri, 12 Dec 2025 11:33:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0AF9F40268;
 Fri, 12 Dec 2025 11:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765535618; x=1797071618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7SXnI01v8nSxh6J6i4Oy8uPLR1HgzVkpebMhtGR7YvU=;
 b=hHK+8X1lR6hYsR52HG+asHFYn4OX7T5Ptw2pMuI12v2Ez/R6T2FDxCMQ
 LusAijm0M+ye2O61P/ndvlSxIBCg9JOATEC6ZVqdbJ5p276n683ZZnrfn
 /xEhjmjCo7KQdyIjWPbx96B+DTE/sBqs/g0qPcU5Y5OAPN/Bjols4Q92u
 AV9mRDfM4ucrbdubm+F7WhN2QjYJkDdnSFndFBhj29rK5SFM1pR0IkZuc
 9nwASIkRzoCzXQXKuF1jv/X4B4N4hk4eLPgz4WMxdWbswXflv3Oe3Au2P
 BFBQFUc+JiM2GOh8tBeYY2Le+AVcX15pobdRozt86Q3u01T0FfVzMG5bB g==;
X-CSE-ConnectionGUID: vWBy2A1ETPGN8zZjXkWQAg==
X-CSE-MsgGUID: TJNScvkpTn2EUTtHzRvLTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="66522885"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; d="scan'208";a="66522885"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2025 02:33:37 -0800
X-CSE-ConnectionGUID: FhKcVeEPRzacqRB5QKA5Kg==
X-CSE-MsgGUID: OayzTNKzQqqK1M6dRJUEcA==
X-ExtLoop1: 1
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa003.fm.intel.com with ESMTP; 12 Dec 2025 02:33:35 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 07/10] docs: fix TSO and checksum offload feature status in
 ice doc
Date: Fri, 12 Dec 2025 10:33:20 +0000
Message-ID: <20251212103323.1481307-8-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212103323.1481307-1-ciara.loftus@intel.com>
References: <20251209112652.963981-1-ciara.loftus@intel.com>
 <20251212103323.1481307-1-ciara.loftus@intel.com>
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

TSO is only supported on the scalar path so change its status to
partially supported. L3 and L4 checksum offload are enabled on scalar
and vector paths so change their statuses from partial to supported.

Fixes: f88de4694d94 ("net/ice: support Tx SSE vector")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/ice.ini | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
index e9796c1eab..893d09e9ec 100644
--- a/doc/guides/nics/features/ice.ini
+++ b/doc/guides/nics/features/ice.ini
@@ -21,7 +21,7 @@ Power mgmt address monitor = Y
 MTU update           = Y
 Buffer split on Rx   = P
 Scattered Rx         = Y
-TSO                  = Y
+TSO                  = P
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 DCB                  = Y
@@ -34,8 +34,8 @@ Traffic manager      = Y
 CRC offload          = Y
 VLAN offload         = Y
 QinQ offload         = P
-L3 checksum offload  = P
-L4 checksum offload  = P
+L3 checksum offload  = Y
+L4 checksum offload  = Y
 Timestamp offload    = P
 Inner L3 checksum    = P
 Inner L4 checksum    = P
-- 
2.43.0

