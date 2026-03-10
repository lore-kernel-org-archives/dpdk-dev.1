Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18086EB1043
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E68D14060A;
	Tue, 10 Mar 2026 11:50:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 9D851402DC;
 Tue, 10 Mar 2026 11:49:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773139800; x=1804675800;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qojtGjyu23H3Kup0iq49a7+mcBbF+DjhR4syQlBbxyY=;
 b=j29A3yO5FhWm++nZ9xPhh9dPMoFHXN+xzre0DTrPxmUuQ9WfRNBIRFqw
 hbQvIhA17cpugaqKGVew5AgMKI93fUxUefhuaCUoAHkE7r0P+WHNatMaQ
 ca7AUwt33qxPCQuRo12AjQ38iRCq916WAWFRzI6yVrIRvAYlI3MHmb79D
 L4f9seeiBPpUJkeaUktPMJi5ft8gAFG6edVpjKKOH116qokK9SQIOvEPg
 jrdBT5bbrl4ykLRIuj+0sH0CrftsaIp5LI03TzDJWrlnVEokcEjz4cxB8
 Z/jXlxa/RxnPEUNPnUlDbGME1sJLq/bXoDKHO4lOeQMGSSbv0Jxs35Ijr A==;
X-CSE-ConnectionGUID: 5uhM7V3MRReiVi1TdcWo4A==
X-CSE-MsgGUID: eJnjYhz/QFWWfbMH/0OIqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74224053"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="74224053"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 03:49:57 -0700
X-CSE-ConnectionGUID: QdhY+wD7RH2zR7QuLrr1Mw==
X-CSE-MsgGUID: Jcz5wga+SmaGT9QC8a5xWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; d="scan'208";a="224759557"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 10 Mar 2026 03:49:56 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] doc: remove references to obsolete testpmd flag
Date: Tue, 10 Mar 2026 10:49:45 +0000
Message-ID: <20260310104945.3271920-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

The packet-filter-mode flag was removed in a previous commit. Remove
references to it in the documentation.

Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/i40e.rst | 4 ++--
 doc/guides/nics/igc.rst  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 0b6527b4ed..0c52807f26 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -436,12 +436,12 @@ The default input set of each flow type is::
 
 The flex payload is selected from offset 0 to 15 of packet's payload by default, while it is masked out from matching.
 
-Start ``testpmd`` with ``--disable-rss`` and ``--pkt-filter-mode=perfect``:
+Start ``testpmd`` with ``--disable-rss``:
 
 .. code-block:: console
 
    ./<build_dir>/app/dpdk-testpmd -l 0-15 -- -i --disable-rss \
-                 --pkt-filter-mode=perfect --rxq=8 --txq=8 --nb-cores=8 \
+                 --rxq=8 --txq=8 --nb-cores=8 \
                  --nb-ports=1
 
 Add a rule to direct ``ipv4-udp`` packet whose ``dst_ip=2.2.2.5, src_ip=2.2.2.3, src_port=32, dst_port=32`` to queue 1:
diff --git a/doc/guides/nics/igc.rst b/doc/guides/nics/igc.rst
index 9790b58102..d19a572b83 100644
--- a/doc/guides/nics/igc.rst
+++ b/doc/guides/nics/igc.rst
@@ -79,7 +79,7 @@ Start ``testpmd``:
 
 .. code-block:: console
 
-   ./dpdk-testpmd -l 4-8 -- i --rxq=4 --txq=4 --pkt-filter-mode=perfect --disable-rss
+   ./dpdk-testpmd -l 4-8 -- i --rxq=4 --txq=4 --disable-rss
 
 Add a rule to direct packet whose ``ether-type=0x801`` to queue 1:
 
-- 
2.43.0

