Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D9D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 10:53:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E11B740261;
	Mon,  1 Dec 2025 11:53:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id D72BB4013F;
 Mon,  1 Dec 2025 11:53:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764586382; x=1796122382;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ELMt/53ukMBfw4EOSE11ezcJbPkIb6U2Y5hrbEzInTs=;
 b=fSo7LSAX2LxzdJj6UxVzLLuK79epmnLnI6YZqsQ45EeWs5g69zyTOjtx
 g39bhJ3SkxsFJs44mceVgx2jRHVPT59zkG/W274LHALYIr6iFrqeouDtS
 bAPRl1YVCGk7wmj84jlSt3EW665PFCacoMw87vkKmR5Wz9kqp/g1b2cb0
 nJJkw5wfTTgVSCA35+hy3QFOeWJvYXfd/GzxDaDbvWNdlGc+xNQ+8pozh
 tdbnyDgwD5DdPm0xm0jaXvcE4wcKWHyn8cu5lTcDmFhZgqpXomtluAnAz
 20xubIT9z5CgDhZ1vlLyKjxIupaSnOdGp5ODKluu3NNzDJIW/yrzLCTyb Q==;
X-CSE-ConnectionGUID: Fjr23qkWQI6ZUHBT6qlLYQ==
X-CSE-MsgGUID: lpgC5973RJ6L0nONIZjlVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="54073936"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="54073936"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 02:53:01 -0800
X-CSE-ConnectionGUID: 1tgR0cgdQSa3T79pRSKIrg==
X-CSE-MsgGUID: kE+hCEj/TdKDgK83R3xYXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="193155596"
Received: from client-08.iind.intel.com ([10.190.203.57])
 by orviesa006.jf.intel.com with ESMTP; 01 Dec 2025 02:52:59 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH] app/testpmd: fix incorrect function names in logs
Date: Mon,  1 Dec 2025 10:08:36 +0000
Message-ID: <20251201100837.422764-1-anurag.mandal@intel.com>
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

VLAN extend and tpid setting functions have wrong function names
mentioned in the error logs causing confusion as functions are
not found in code using those names.

Replaced static names with dynamic "__func__" predefined identifier.

Fixes: 61a3b0e5e79f ("app/testpmd: send failure logs to stderr")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 app/test-pmd/config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 6ea506254b..afaf9194ba 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6502,8 +6502,8 @@ vlan_extend_set(portid_t port_id, int on)
 	diag = rte_eth_dev_set_vlan_offload(port_id, vlan_offload);
 	if (diag < 0) {
 		fprintf(stderr,
-			"rx_vlan_extend_set(port_pi=%d, on=%d) failed diag=%d\n",
-			port_id, on, diag);
+			"%s(port_pi=%d, on=%d) failed diag=%d\n",
+			__func__, port_id, on, diag);
 		return;
 	}
 	ports[port_id].dev_conf.rxmode.offloads = port_rx_offloads;
@@ -6729,8 +6729,8 @@ vlan_tpid_set(portid_t port_id, enum rte_vlan_type vlan_type, uint16_t tp_id)
 		return;
 
 	fprintf(stderr,
-		"tx_vlan_tpid_set(port_pi=%d, vlan_type=%d, tpid=%d) failed diag=%d\n",
-		port_id, vlan_type, tp_id, diag);
+		"%s(port_pi=%d, vlan_type=%d, tpid=%d) failed diag=%d\n",
+		__func__, port_id, vlan_type, tp_id, diag);
 }
 
 void
-- 
2.43.0

