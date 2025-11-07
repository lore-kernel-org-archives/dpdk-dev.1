Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D833CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B399440E26;
	Fri,  7 Nov 2025 16:51:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 8C6B940B98;
 Fri,  7 Nov 2025 16:51:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530683; x=1794066683;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EVdbxFK6HEc5wDTogLOdgeedrKEgIljhbj3FUPV3Iho=;
 b=ZxUCJvkWkyl/b1Yg+XaHlwVEaudeXGJojAEX3MtwRbZxyRgOy21DwExF
 CrjL7tPlde5ElF4PAfP1tdSW2gcx7uzsQCHpVVllYXYZHzVQ8TUMAaxj4
 dobaM6QoWR/jOIpPIi3F2stOFVwnhdeQTP4Oc2lIHOTyx7TmkUTRajGBW
 LABeKERZK3NSmbTzxJLaxYTcqydeaRfKAEcpUavTnDihfMOm7XFQeBvJw
 n/UTndJIwDnHKeKD3zFArMVgRKYGC0gMEHTnCob/FQhTx2vTBB9IZ+GgG
 ngkguzZRRF/sX1ZYiaho5csX7vn2lRkLaHVYuFFBrTF/3YRPVZyNL1wSh Q==;
X-CSE-ConnectionGUID: logBk2SPS+mnhJGSDt7S9g==
X-CSE-MsgGUID: XgtKWMdXSLWEi6ZVOo2o+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151855"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151855"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:22 -0800
X-CSE-ConnectionGUID: g6KWHCwrSJ2G56i2tfZV6A==
X-CSE-MsgGUID: Y79iP2JVQtaAPmMP0LJgdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321714"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Praveen Shetty <praveen.shetty@intel.com>,
 Yuying Zhang <yuying.zhang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Wenjing Qiao <wenjing.qiao@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [RFC PATCH v2 17/33] net/cpfl: fix build with shadow warnings enabled
Date: Fri,  7 Nov 2025 15:50:13 +0000
Message-ID: <20251107155034.436809-18-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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

Remove unnecessary variable definitions to ensure compiling with
-Wshadow enabled.

Fixes: db042ef09d26 ("net/cpfl: implement FXP rule creation and destroying")
Fixes: 41f20298ee8c ("net/cpfl: parse flow offloading hint from JSON")
Fixes: 3ca8f6b55435 ("net/cpfl: remove devargs from adapter structure")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c | 2 --
 drivers/net/intel/cpfl/cpfl_flow_parser.c     | 6 +++---
 drivers/net/intel/cpfl/cpfl_fxp_rule.h        | 2 --
 drivers/net/intel/cpfl/cpfl_representor.h     | 2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
index 689ed82f18..361827cb10 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
@@ -386,8 +386,6 @@ cpfl_fxp_parse_action(struct cpfl_itf *itf,
 	}
 
 	if (mr_action) {
-		uint32_t i;
-
 		for (i = 0; i < rim->mr_num; i++)
 			if (cpfl_parse_mod_content(itf->adapter, rinfo,
 						   &rim->rules[rim->pr_num + i],
diff --git a/drivers/net/intel/cpfl/cpfl_flow_parser.c b/drivers/net/intel/cpfl/cpfl_flow_parser.c
index a67c773d18..e7deb619ee 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_parser.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_parser.c
@@ -1098,12 +1098,12 @@ cpfl_parse_fieldvectors(struct cpfl_itf *itf, struct cpfl_flow_js_fv *js_fvs, in
 			fv[2 * offset] = (uint8_t)(temp_fv >> 8);
 			fv[2 * offset + 1] = (uint8_t)(temp_fv & 0x00ff);
 		} else if (type == CPFL_FV_TYPE_METADATA) {
-			uint16_t type, v_offset, mask;
+			uint16_t v_offset, mask;
 
-			type = js_fv->meta.type;
 			v_offset = js_fv->meta.offset;
 			mask = js_fv->meta.mask;
-			temp_fv = cpfl_metadata_read16(&itf->adapter->meta, type, v_offset) & mask;
+			temp_fv = cpfl_metadata_read16(&itf->adapter->meta, js_fv->meta.type,
+					v_offset) & mask;
 			fv[2 * offset] = (uint8_t)(temp_fv & 0x00ff);
 			fv[2 * offset + 1] = (uint8_t)(temp_fv >> 8);
 		} else if (type == CPFL_FV_TYPE_PROTOCOL) {
diff --git a/drivers/net/intel/cpfl/cpfl_fxp_rule.h b/drivers/net/intel/cpfl/cpfl_fxp_rule.h
index ed757b80b1..94eab6808c 100644
--- a/drivers/net/intel/cpfl/cpfl_fxp_rule.h
+++ b/drivers/net/intel/cpfl/cpfl_fxp_rule.h
@@ -53,8 +53,6 @@ struct cpfl_rule_info {
 	};
 };
 
-extern struct cpfl_vport_ext *vport;
-
 int cpfl_rule_process(struct cpfl_itf *itf,
 		      struct idpf_ctlq_info *tx_cq,
 		      struct idpf_ctlq_info *rx_cq,
diff --git a/drivers/net/intel/cpfl/cpfl_representor.h b/drivers/net/intel/cpfl/cpfl_representor.h
index d7f6e186f8..5c3d3aa3f6 100644
--- a/drivers/net/intel/cpfl/cpfl_representor.h
+++ b/drivers/net/intel/cpfl/cpfl_representor.h
@@ -21,7 +21,7 @@ struct cpfl_repr_param {
 	struct cpfl_vport_info *vport_info;
 };
 
-extern struct cpfl_devargs *devargs;
+struct cpfl_devargs;
 
 int cpfl_repr_devargs_process(struct cpfl_adapter_ext *adapter, struct cpfl_devargs *devargs);
 int cpfl_repr_create(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adapter);
-- 
2.48.1

