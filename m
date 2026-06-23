Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F1CDB479
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 11:22:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F95B40648;
	Tue, 23 Jun 2026 13:22:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 27E9740611;
 Tue, 23 Jun 2026 13:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782213760; x=1813749760;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8dDS9/7nKE+j6EQi/UXi9y9vI+9CkiTrhiRSl/QzVO4=;
 b=HUuk0q5LCZbVZSECm5ccaod5v8R7aRhCnyw/xWgeqAemjZOZOx44Q0Ft
 /N7iePL2D4Yyqn2jlxQWyDxPS+qyy0bg+NS06mBIc8azyOch4Hud4Mkzz
 x1ZKzeDR9hzDfFKDJvUlGC+LTUvBs3C3P/Dtfpiw2xknIh4qDXiiT7JiO
 T0OWxhnjxS7Sw3JL18YqAAdtQXPlh+unHXT9KoXPwlWNbyy9rmUWoCBjU
 A7MkLNuxO15j2naFhgFo8sTlcWp/CntrwSxv/6zlGUXAYn6OH4bnZZvFW
 S76IzhbdhekVfuE8uyLqaaT/T+EJmvGeck5I7jOi/h3FXoPIpQmhr5V65 Q==;
X-CSE-ConnectionGUID: 3k8Ie1uHQEaPi6Er3xA+iw==
X-CSE-MsgGUID: XR4a+a1aTP2Ax/coBQ2mYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="85509465"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="85509465"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 04:22:39 -0700
X-CSE-ConnectionGUID: +EqUCEspQb6rBjdiXCFojg==
X-CSE-MsgGUID: M8o8/X1RRcGy86cMGXHGlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="273546215"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.224.226])
 by fmviesa001.fm.intel.com with ESMTP; 23 Jun 2026 04:22:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Praveen Shetty <praveen.shetty@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Shaiq Wani <shaiq.wani@intel.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH] net/intel: fix use of non-recommended string functions
Date: Tue, 23 Jun 2026 12:22:21 +0100
Message-ID: <20260623112221.677931-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
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

Replace use of the strncpy and strcpy functions with the safer strlcpy
alternative, which both bounds-checks and guarantees null termination.
In the process also replace instances of strcat with strlcat where
appropriate.

Fixes: 2d823ecd671c ("net/cpfl: support device initialization")
Fixes: c4c59ae62793 ("net/cpfl: refactor flow parser")
Fixes: c10881d3ee74 ("net/cpfl: support flow prog action")
Fixes: 9481b0902efe ("net/ice: send driver version to firmware")
Fixes: 7f7cbf80bdb7 ("net/ice: factorize firmware loading")
Fixes: 549343c25db8 ("net/idpf: support device initialization")
Fixes: 484f8e407a94 ("net/igb: support xstats by ID")
Fixes: fca82a8accf9 ("net/ixgbe: support xstats by ID")
Fixes: e163c18a15b0 ("net/i40e: update ptype and pctype info")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c      |  2 +-
 drivers/net/intel/cpfl/cpfl_flow_parser.c | 16 +++++++---------
 drivers/net/intel/e1000/igb_ethdev.c      |  5 +++--
 drivers/net/intel/i40e/i40e_ethdev.c      |  3 +--
 drivers/net/intel/ice/ice_ethdev.c        | 16 +++++++---------
 drivers/net/intel/idpf/idpf_ethdev.c      |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c    |  5 +++--
 7 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 7ac8797490..4315adb68c 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -2534,7 +2534,7 @@ cpfl_adapter_ext_init(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *a
 	hw->subsystem_vendor_id = pci_dev->id.subsystem_vendor_id;
 	adapter->host_id = get_running_host_id();
 
-	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
+	strlcpy(adapter->name, pci_dev->device.name, sizeof(adapter->name));
 
 	memcpy(&base->caps, &req_caps, sizeof(struct virtchnl2_get_capabilities));
 
diff --git a/drivers/net/intel/cpfl/cpfl_flow_parser.c b/drivers/net/intel/cpfl/cpfl_flow_parser.c
index dfaddc9ec5..b1d06725e9 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_parser.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_parser.c
@@ -211,7 +211,7 @@ cpfl_flow_js_pattern_key_proto_field(json_t *ob_fields,
 			PMD_DRV_LOG(ERR, "The 'name' is too long.");
 			goto err;
 		}
-		strncpy(js_field->fields[i].name, name, CPFL_JS_STR_SIZE - 1);
+		strlcpy(js_field->fields[i].name, name, CPFL_JS_STR_SIZE);
 
 		if (js_field->type == RTE_FLOW_ITEM_TYPE_ETH ||
 		    js_field->type == RTE_FLOW_ITEM_TYPE_IPV4) {
@@ -716,8 +716,7 @@ cpfl_flow_js_mr_key(json_t *ob_mr_keys, struct cpfl_flow_js_mr_key *js_mr_key)
 					PMD_DRV_LOG(ERR, "The 'name' is too long.");
 					goto err;
 				}
-				strncpy(js_mr_key->actions[i].prog.name, name,
-					CPFL_JS_STR_SIZE - 1);
+				strlcpy(js_mr_key->actions[i].prog.name, name, CPFL_JS_STR_SIZE);
 			}
 
 			ob_param = json_object_get(object, "parameters");
@@ -742,8 +741,8 @@ cpfl_flow_js_mr_key(json_t *ob_mr_keys, struct cpfl_flow_js_mr_key *js_mr_key)
 						PMD_DRV_LOG(ERR, "The 'name' is too long.");
 						goto err;
 					}
-					strncpy(js_mr_key->actions[i].prog.params[j].name, name,
-						CPFL_JS_STR_SIZE - 1);
+					strlcpy(js_mr_key->actions[i].prog.params[j].name, name,
+						CPFL_JS_STR_SIZE);
 				}
 				ret = cpfl_json_t_to_uint16(subobject, "size", &value);
 				if (ret < 0) {
@@ -810,7 +809,7 @@ cpfl_flow_js_mr_layout(json_t *ob_layouts, struct cpfl_flow_js_mr_action_mod *js
 			PMD_DRV_LOG(ERR, "The 'hint' is too long.");
 			goto err;
 		}
-		strncpy(js_mod->layout[i].hint, hint, CPFL_JS_STR_SIZE - 1);
+		strlcpy(js_mod->layout[i].hint, hint, CPFL_JS_STR_SIZE);
 	}
 
 	return 0;
@@ -856,7 +855,7 @@ cpfl_flow_js_mr_content(json_t *ob_content, struct cpfl_flow_js_mr_action_mod *j
 			PMD_DRV_LOG(ERR, "The 'type' is too long.");
 			goto err;
 		}
-		strncpy(js_mod->content.fields[i].type, type, CPFL_JS_STR_SIZE - 1);
+		strlcpy(js_mod->content.fields[i].type, type, CPFL_JS_STR_SIZE);
 		ret = cpfl_json_t_to_uint16(object, "start", &start);
 		if (ret < 0) {
 			PMD_DRV_LOG(ERR, "Can not parse 'start'.");
@@ -1806,8 +1805,7 @@ cpfl_parse_check_prog_action(struct cpfl_flow_js_mr_key_action *key_act,
 			return -EINVAL;
 		if (param->has_name) {
 			mr_key_prog->has_name = TRUE;
-			strncpy(mr_key_prog->name[param->index], param->name,
-				CPFL_JS_STR_SIZE - 1);
+			strlcpy(mr_key_prog->name[param->index], param->name, CPFL_JS_STR_SIZE);
 		}
 	}
 
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index a4370fe32b..524c030be6 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -2047,8 +2047,9 @@ static int eth_igb_xstats_get_names_by_id(struct rte_eth_dev *dev,
 				PMD_INIT_LOG(ERR, "id value isn't valid");
 				return -1;
 			}
-			strcpy(xstats_names[i].name,
-					xstats_names_copy[ids[i]].name);
+			strlcpy(xstats_names[i].name,
+					xstats_names_copy[ids[i]].name,
+					sizeof(xstats_names[i].name));
 		}
 		return limit;
 	}
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 1370db68f3..b2694cd33a 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -11916,8 +11916,7 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 			for (n = 0; n < proto_num; n++) {
 				if (proto[n].proto_id != proto_id)
 					continue;
-				memset(name, 0, sizeof(name));
-				strcpy(name, proto[n].name);
+				strlcpy(name, proto[n].name, sizeof(name));
 				PMD_DRV_LOG(INFO, "name = %s", name);
 				if (!strncasecmp(name, "PPPOE", 5))
 					ptype_mapping[i].sw_ptype |=
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index ad9c49b339..99305b604b 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1897,7 +1897,7 @@ ice_send_driver_ver(struct ice_hw *hw)
 	dv.minor_ver = 0;
 	dv.build_ver = 0;
 	dv.subbuild_ver = 0;
-	strncpy((char *)dv.driver_string, "dpdk", sizeof(dv.driver_string));
+	strlcpy((char *)dv.driver_string, "dpdk", sizeof(dv.driver_string));
 
 	return ice_aq_send_driver_ver(hw, &dv, NULL);
 }
@@ -2054,24 +2054,22 @@ int ice_load_pkg(struct ice_adapter *adapter, bool use_dsn, uint64_t dsn)
 	if (!use_dsn)
 		goto no_dsn;
 
-	strncpy(pkg_file, ICE_PKG_FILE_SEARCH_PATH_UPDATES,
-		ICE_MAX_PKG_FILENAME_SIZE);
-	strcat(pkg_file, opt_ddp_filename);
+	strlcpy(pkg_file, ICE_PKG_FILE_SEARCH_PATH_UPDATES, ICE_MAX_PKG_FILENAME_SIZE);
+	strlcat(pkg_file, opt_ddp_filename, ICE_MAX_PKG_FILENAME_SIZE);
 	if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
 		goto load_fw;
 
-	strncpy(pkg_file, ICE_PKG_FILE_SEARCH_PATH_DEFAULT,
-		ICE_MAX_PKG_FILENAME_SIZE);
-	strcat(pkg_file, opt_ddp_filename);
+	strlcpy(pkg_file, ICE_PKG_FILE_SEARCH_PATH_DEFAULT, ICE_MAX_PKG_FILENAME_SIZE);
+	strlcat(pkg_file, opt_ddp_filename, ICE_MAX_PKG_FILENAME_SIZE);
 	if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
 		goto load_fw;
 
 no_dsn:
-	strncpy(pkg_file, ICE_PKG_FILE_UPDATES, ICE_MAX_PKG_FILENAME_SIZE);
+	strlcpy(pkg_file, ICE_PKG_FILE_UPDATES, ICE_MAX_PKG_FILENAME_SIZE);
 	if (ice_firmware_read(pkg_file, &buf, &bufsz) == 0)
 		goto load_fw;
 
-	strncpy(pkg_file, ICE_PKG_FILE_DEFAULT, ICE_MAX_PKG_FILENAME_SIZE);
+	strlcpy(pkg_file, ICE_PKG_FILE_DEFAULT, ICE_MAX_PKG_FILENAME_SIZE);
 	if (ice_firmware_read(pkg_file, &buf, &bufsz) < 0) {
 		PMD_INIT_LOG(ERR, "Failed to load default DDP package " ICE_PKG_FILE_DEFAULT);
 		return -1;
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index fc761c6094..c13505416a 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1497,7 +1497,7 @@ idpf_adapter_ext_init(struct rte_pci_device *pci_dev, struct idpf_adapter_ext *a
 	hw->device_id = pci_dev->id.device_id;
 	hw->subsystem_vendor_id = pci_dev->id.subsystem_vendor_id;
 
-	strncpy(adapter->name, pci_dev->device.name, PCI_PRI_STR_SIZE);
+	strlcpy(adapter->name, pci_dev->device.name, sizeof(adapter->name));
 
 	memcpy(&base->caps, &req_caps, sizeof(struct virtchnl2_get_capabilities));
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index f9de95e4fc..b36867d18d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3635,8 +3635,9 @@ static int ixgbe_dev_xstats_get_names_by_id(
 			PMD_INIT_LOG(ERR, "id value isn't valid");
 			return -1;
 		}
-		strcpy(xstats_names[i].name,
-				xstats_names_copy[ids[i]].name);
+		strlcpy(xstats_names[i].name,
+				xstats_names_copy[ids[i]].name,
+				sizeof(xstats_names[i].name));
 	}
 	return limit;
 }
-- 
2.53.0

