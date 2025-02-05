Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA3FC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B09340A87;
	Wed,  5 Feb 2025 11:46:28 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1484C4067C
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:18 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 mx-outbound23-121.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hH7wBKZWKGkoy6OBMhBu07rRwk2HGyhjA0olgv/MIVQYqqXox7TWXMnOOAuPXZB92nUl7+ufVCuVXgaZroprUnePEX7NuxToA6oOK91EkcQGqGdtv195hxKrUD+OwoojFR30SVF1jxUpgNkHMssOvXxCgyLDEP3IMKA+KD2at/8/F/4MIapSw1oP6vDT8jmlpn1ax96hPaPyZAMK6iKQZX6NZZKqCi2IL0XiiZGDNLXrqUIHD3CBiyFYctVHidFFM14iFq0sk0FI75Pot7OTtJHL/HTsFhEWJJlAXcHx359QIvtrIDWt+m5Z1Pr8zgeQnLprL67zy1IyVJUU5iuiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUdU/e+TIQ2Gtag9GbB90j1lCus4XUDlz56NGixrcKE=;
 b=tOXQX60oeIVOTr9mjXKEmB4RBUyugUbgEDzShMzRx0l/7kJTVoG6OD2BBHqsTZSME4iA0WAw/JVGlx2mJ4HBlwQ7LN+sIAJFX6NoQmf2O2QWE7A50qX23cj6QxWvy79KOhQb6hF+vG6zocF0ZmHo5tCfZxNsHvD6yx7oyl7B8ED+Xg/f/RZA6/1bR+P7lXfYkGYNPEOh4WqWU95IGiqSoqhnf0/lMiFh0V5TamKhTEaxDpLgM6hMJ/7Z5ujFUBHdnFlIH84UuxkXHRtcf+L3uHhY/FnQD/AbId2QuV7Od0cmGL/GayK9Hp2++x3rk8INEPUEHHJcu3ZVFOD0vlDGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUdU/e+TIQ2Gtag9GbB90j1lCus4XUDlz56NGixrcKE=;
 b=Mhj6kVxBiisLI99uzAW56F8IY/LxaGC2X+ddsX4bDHSU/t19GqDeMyFVmU+Mc+rqSUmI5eAyeFXtQZny7z4hiroptdghcqugBwlxUEQqJ3U0cM+Wir/MCQ7aeeG71JwdcQkyAhRJ6uErG6KvtM4MO0NSTVc0AZLB+f3/DpD1Yeo=
Received: from CWLP265CA0344.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::20)
 by GV1P190MB1875.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:46:13 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::8) by CWLP265CA0344.outlook.office365.com
 (2603:10a6:401:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 10:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:12
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 19/34] net/ntnic: remove convert error func
Date: Wed,  5 Feb 2025 11:45:28 +0100
Message-ID: <20250205104548.1533554-20-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|GV1P190MB1875:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b65e1060-a76a-45a6-c21f-08dd45d24f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t2dvltsnaFkK8FLVv2yqYSdmPfUdfN11E7ZfT42muxiTGed4ARHXMuJkazlb?=
 =?us-ascii?Q?Kzh0GJ2RLRh5dgLhIzy+sme1tbVuOHQghPl7XAJ7SvLrPF4sriAton1ieotd?=
 =?us-ascii?Q?OwTcTeLWpL1royz01Ux1oP5IpnP97Na+TZZzfh3UxkxuDg4KCosy0XWdgdGG?=
 =?us-ascii?Q?jGabLfIzT87p2FGzpy67Vp2NrLxIN5WTgwiZyaq1UaktuwXygBNr6wNs222R?=
 =?us-ascii?Q?OQZm3bdU/73CYdyoUntSUu2E3C2OHrIpnUFojZjBoz3WPH3V/aJUGrVPKatG?=
 =?us-ascii?Q?Mknr2ax196hLnXm2Bo/Y9myoBBBjK2i653HG3VSI6Q3ih0LPGbuwza2/ANdw?=
 =?us-ascii?Q?vuteLXzhRIl4Ha/UAyc+gjubbEJqklal6kdHO5cL5ePpZDISffMvEUcJGm/I?=
 =?us-ascii?Q?+wgtoeXiM409JnKYQHH5sHwAntJoJ6qTfBME7HBm6JZUO0GIRpzlV/JoI5u8?=
 =?us-ascii?Q?7bDoG3smuNuByTo6G16MnTlQMuFUV89ezq2T1zp42LgjBdG8duLf/fFF82iJ?=
 =?us-ascii?Q?lNWXJcqv0jdNVvsQAzk2+O0df5Z3Hmi+neOUPrInsstyQblsUpWKSNaFtcx2?=
 =?us-ascii?Q?SX8G4rDrmcVAX/iAS4MCgcw4a0ZqfyD7JsQM8BeDeMgfhbxnSDb6xDw10gTF?=
 =?us-ascii?Q?NdcImYFPsOyk76DOi3a2+e6xgLLzslrnBBjUpCUx/eZhikWuzWnPVLru8bsv?=
 =?us-ascii?Q?adPh7ihKyLozOzsrvah2oHj++y6hq+i6+3lMTPfWaWZVM87rMmg/S7Wuy0Kw?=
 =?us-ascii?Q?rjoXfsZb8cJ2psiuIonBS35KdKzTCDWbTrOKlzkyzTVPmHHcAlu1FtOdDagS?=
 =?us-ascii?Q?/lYWb4uf8Dqv3ckmHMLXT8cAR50e/ZRs74EFrZMsaZV+sSUUse8QI467f8bx?=
 =?us-ascii?Q?JitpiwEQsO0IGdcujcWCRW/jYSsEKYXeJ4RuQaaDu/yh3NxUv/taEdAjrxlR?=
 =?us-ascii?Q?lRw1AGG6ZIoGigcGr7CeogXjHEfrwWlGc+pm4YOVGGe5qwAhvyRjv9ypUzjR?=
 =?us-ascii?Q?GX1UwK5aSGlpfrNee+nFxyawDTjvlqe5+6OLAfKvSQRFvgxnRfwmqKrR1/GH?=
 =?us-ascii?Q?uuErb3hMmfS1gb362nFSCrkVxslwnDIOKN+KgD+mx9deeqEs535dG17RemVl?=
 =?us-ascii?Q?Uy0qjb/upmiVEg4Tytovr6O4+FJmW7P9DNM7YH6zH9ETBSFK0XEpuIMVumfp?=
 =?us-ascii?Q?wqQn6hhCdTFRmwl01ghF7wtK1OY/Xcc9Mh24Hl7LFCk8WQYXSop5DSoioldy?=
 =?us-ascii?Q?NSp7e/PsjywMPFYRxV2cchI6ycjDyKCact5rQ9wRMPSrx1KeZd6Ev2F5+9G3?=
 =?us-ascii?Q?10LZdNxyFpZxgMq06SjD6+l0RUpX38+Z+RtdvGuFEYvsW2JJQtEVRTP1GyBM?=
 =?us-ascii?Q?x3mzleeEyXry9hoBRWCN4AHAzdeCnZuqu9jWCFWLytArrlCjfctzEM8ySF/5?=
 =?us-ascii?Q?z/ZmikCAmnRmW8/RuxdI12zwkp7t6KhwJvXkVGTbY9Cc3kfk7GFGiIItjxh+?=
 =?us-ascii?Q?LwxUtWLkIIR+3wk=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: buYGIWxJLsnMFEuzVbIeOXfYaNgC/QKu6u29WryF+iFaGUi+LEP67qCIr5a7P/o77DfA6fwenlGaMdClHKkJris55LHHqFEUXRVWT+GOS/uq5gCCue1vRkWrtodVV7dq9PX44vSvtYh8+ZupvUdhvU63hxNVzfMIfM8eY6KnZwxKL7uZ6d7nhBotlkZb1tAvjzVIy3lLTAR1qtPOlJYaHev7goPGg1nO6qJ20nltqLCPO/qYMy3OWNFGZ32mSXWg3+WeSC/BvqMlLXmwywrkmIy/FBm7MkwIU+GAAJcKaSkoEowXZidJFqeYtJ8EONraGZM6pJwiT3+0VTBB/Ju7FLIfD5V0PsFOAjG8FWfdi4C34+w+QyK6VijWRvppCNAMe9LzYKJuYexv7AjUMVix6o+yChMQ7eVr7adgr4DbQdg+QPrWl5VgYkbGz1pi6i2v/ZIl6GBW4bdwM4X1eAGV8OGQ75UK4Lk8NIMcKHXeb6awBxEusWqoj/J5Olwxi9VK2E09guhBWqE6eYmWi5SVEFdzpzKH93QtJC79aFwfTMODiFC3cchmoKpR56z39GqbkKwU0jmVIMKbT7NUtYC8Pe43Ces6Vtx316fgCXtW3gtg2PpkQ5JZK2EJXfBjuMwXMUti/KsBa+qnaB5d+PL3YA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:12.8239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65e1060-a76a-45a6-c21f-08dd45d24f25
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB1875
X-BESS-ID: 1738752376-306009-7776-618-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmFpbmQGYGUNTEwsTINDHJyM
 DCMs3YxNzA1NjA0sLSKMXYLDUxMTktTak2FgClcjC4QgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan12-59.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

convert_error func was removed as far as this approach was deprecated.

Coverity issue: 448973
Fixes: e526adf1fdef ("net/ntnic: add minimal create/destroy flow operations")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/include/create_elements.h   |   1 -
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c | 151 ++++++------------
 2 files changed, 53 insertions(+), 99 deletions(-)

diff --git a/drivers/net/ntnic/include/create_elements.h b/drivers/net/ntnic/include/create_elements.h
index 1456977837..f0b9410cb9 100644
--- a/drivers/net/ntnic/include/create_elements.h
+++ b/drivers/net/ntnic/include/create_elements.h
@@ -61,7 +61,6 @@ enum nt_rte_flow_item_type {
 extern rte_spinlock_t flow_lock;
 
 int interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_flow_item *out);
-int convert_error(struct rte_flow_error *error, struct rte_flow_error *rte_flow_error);
 int create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr);
 int create_match_elements(struct cnv_match_s *match, const struct rte_flow_item items[],
 	int max_elem);
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index b07e16c1d3..70bff776be 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -246,23 +246,6 @@ int interpret_raw_data(uint8_t *data, uint8_t *preserve, int size, struct rte_fl
 	return hdri + 1;
 }
 
-int convert_error(struct rte_flow_error *error, struct rte_flow_error *rte_flow_error)
-{
-	if (error) {
-		error->cause = NULL;
-		error->message = rte_flow_error->message;
-
-		if (rte_flow_error->type == RTE_FLOW_ERROR_TYPE_NONE ||
-			rte_flow_error->type == RTE_FLOW_ERROR_TYPE_NONE)
-			error->type = RTE_FLOW_ERROR_TYPE_NONE;
-
-		else
-			error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
-	}
-
-	return 0;
-}
-
 int create_attr(struct cnv_attr_s *attribute, const struct rte_flow_attr *attr)
 {
 	memset(&attribute->attr, 0x0, sizeof(struct rte_flow_attr));
@@ -497,13 +480,10 @@ static int convert_flow(struct rte_eth_dev *eth_dev,
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 	struct fpga_info_s *fpga_info = &internals->p_drv->ntdrv.adapter_info.fpga_info;
 
-	static struct rte_flow_error flow_error = {
-		.type = RTE_FLOW_ERROR_TYPE_NONE, .message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 	uint32_t queue_offset = 0;
 
-	/* Set initial error */
-	convert_error(error, &flow_error);
-
 	if (!internals) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 			"Missing eth_dev");
@@ -559,23 +539,19 @@ eth_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *flow, struct rte_
 
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
-	static struct rte_flow_error flow_error = {
-		.type = RTE_FLOW_ERROR_TYPE_NONE, .message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 	int res = 0;
-	/* Set initial error */
-	convert_error(error, &flow_error);
 
 	if (!flow)
 		return 0;
 
 	if (is_flow_handle_typecast(flow)) {
-		res = flow_filter_ops->flow_destroy(internals->flw_dev, (void *)flow, &flow_error);
-		convert_error(error, &flow_error);
+		res = flow_filter_ops->flow_destroy(internals->flw_dev, (void *)flow, error);
 
 	} else {
 		res = flow_filter_ops->flow_destroy(internals->flw_dev, flow->flw_hdl,
-			&flow_error);
-		convert_error(error, &flow_error);
+			error);
 
 		rte_spinlock_lock(&flow_lock);
 		flow->used = 0;
@@ -606,8 +582,8 @@ static struct rte_flow *eth_flow_create(struct rte_eth_dev *eth_dev,
 	struct cnv_match_s match = { 0 };
 	struct cnv_action_s action = { 0 };
 
-	static struct rte_flow_error flow_error = {
-		.type = RTE_FLOW_ERROR_TYPE_NONE, .message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 	uint32_t flow_stat_id = 0;
 
 	if (convert_flow(eth_dev, attr, items, actions, &attribute, &match, &action, error) < 0)
@@ -620,8 +596,7 @@ static struct rte_flow *eth_flow_create(struct rte_eth_dev *eth_dev,
 		void *flw_hdl = flow_filter_ops->flow_create(internals->flw_dev, &attribute.attr,
 			attribute.forced_vlan_vid, attribute.caller_id,
 			match.rte_flow_item, action.flow_actions,
-			&flow_error);
-		convert_error(error, &flow_error);
+			error);
 		return (struct rte_flow *)flw_hdl;
 	}
 
@@ -648,8 +623,7 @@ static struct rte_flow *eth_flow_create(struct rte_eth_dev *eth_dev,
 		flow->flw_hdl = flow_filter_ops->flow_create(internals->flw_dev, &attribute.attr,
 			attribute.forced_vlan_vid, attribute.caller_id,
 			match.rte_flow_item, action.flow_actions,
-			&flow_error);
-		convert_error(error, &flow_error);
+			error);
 
 		if (!flow->flw_hdl) {
 			rte_spinlock_lock(&flow_lock);
@@ -678,14 +652,14 @@ static int eth_flow_flush(struct rte_eth_dev *eth_dev, struct rte_flow_error *er
 
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
-	static struct rte_flow_error flow_error = {
-		.type = RTE_FLOW_ERROR_TYPE_NONE, .message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 	int res = 0;
 	/* Main application caller_id is port_id shifted above VDPA ports */
 	uint16_t caller_id = get_caller_id(eth_dev->data->port_id);
 
 	if (internals->flw_dev) {
-		res = flow_filter_ops->flow_flush(internals->flw_dev, caller_id, &flow_error);
+		res = flow_filter_ops->flow_flush(internals->flw_dev, caller_id, error);
 		rte_spinlock_lock(&flow_lock);
 
 		for (int flow = 0; flow < MAX_RTE_FLOWS; flow++) {
@@ -702,8 +676,6 @@ static int eth_flow_flush(struct rte_eth_dev *eth_dev, struct rte_flow_error *er
 		rte_spinlock_unlock(&flow_lock);
 	}
 
-	convert_error(error, &flow_error);
-
 	return res;
 }
 
@@ -721,8 +693,8 @@ static int eth_flow_actions_update(struct rte_eth_dev *eth_dev,
 
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
-	static struct rte_flow_error flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 	int res = -1;
 
 	if (internals->flw_dev) {
@@ -756,18 +728,16 @@ static int eth_flow_actions_update(struct rte_eth_dev *eth_dev,
 			res = flow_filter_ops->flow_actions_update(internals->flw_dev,
 					(void *)flow,
 					action.flow_actions,
-					&flow_error);
+					error);
 
 		} else {
 			res = flow_filter_ops->flow_actions_update(internals->flw_dev,
 					flow->flw_hdl,
 					action.flow_actions,
-					&flow_error);
+					error);
 		}
 	}
 
-	convert_error(error, &flow_error);
-
 	return res;
 }
 
@@ -785,17 +755,16 @@ static int eth_flow_dev_dump(struct rte_eth_dev *eth_dev,
 
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
-	static struct rte_flow_error flow_error = {
-		.type = RTE_FLOW_ERROR_TYPE_NONE, .message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	uint16_t caller_id = get_caller_id(eth_dev->data->port_id);
 
 	int res = flow_filter_ops->flow_dev_dump(internals->flw_dev,
 			is_flow_handle_typecast(flow) ? (void *)flow
 			: flow->flw_hdl,
-			caller_id, file, &flow_error);
+			caller_id, file, error);
 
-	convert_error(error, &flow_error);
 	return res;
 }
 
@@ -813,16 +782,14 @@ static int eth_flow_get_aged_flows(struct rte_eth_dev *eth_dev,
 
 	struct pmd_internals *internals = eth_dev->data->dev_private;
 
-	static struct rte_flow_error flow_error = {
-		.type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	uint16_t caller_id = get_caller_id(eth_dev->data->port_id);
 
 	int res = flow_filter_ops->flow_get_aged_flows(internals->flw_dev, caller_id, context,
-			nb_contexts, &flow_error);
+			nb_contexts, error);
 
-	convert_error(error, &flow_error);
 	return res;
 }
 
@@ -842,17 +809,15 @@ static int eth_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info
 
 	struct pmd_internals *internals = dev->data->dev_private;
 
-	static struct rte_flow_error flow_error = {
-		.type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	int res = flow_filter_ops->flow_info_get(internals->flw_dev,
 			get_caller_id(dev->data->port_id),
 			(struct rte_flow_port_info *)port_info,
 			(struct rte_flow_queue_info *)queue_info,
-			&flow_error);
+			error);
 
-	convert_error(error, &flow_error);
 	return res;
 }
 
@@ -869,18 +834,16 @@ static int eth_flow_configure(struct rte_eth_dev *dev, const struct rte_flow_por
 
 	struct pmd_internals *internals = dev->data->dev_private;
 
-	static struct rte_flow_error flow_error = {
-		.type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	int res = flow_filter_ops->flow_configure(internals->flw_dev,
 			get_caller_id(dev->data->port_id),
 			(const struct rte_flow_port_attr *)port_attr,
 			nb_queue,
 			(const struct rte_flow_queue_attr **)queue_attr,
-			&flow_error);
+			error);
 
-	convert_error(error, &flow_error);
 	return res;
 }
 
@@ -897,8 +860,8 @@ static struct rte_flow_pattern_template *eth_flow_pattern_template_create(struct
 
 	struct pmd_internals *internals = dev->data->dev_private;
 
-	static struct rte_flow_error flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	struct cnv_match_s match = { 0 };
 	struct rte_flow_pattern_template_attr attr = {
@@ -918,9 +881,8 @@ static struct rte_flow_pattern_template *eth_flow_pattern_template_create(struct
 
 	struct flow_pattern_template *res =
 		flow_filter_ops->flow_pattern_template_create(internals->flw_dev, &attr, caller_id,
-			match.rte_flow_item, &flow_error);
+			match.rte_flow_item, error);
 
-	convert_error(error, &flow_error);
 	return (struct rte_flow_pattern_template *)res;
 }
 
@@ -937,15 +899,14 @@ static int eth_flow_pattern_template_destroy(struct rte_eth_dev *dev,
 
 	struct pmd_internals *internals = dev->data->dev_private;
 
-	static struct rte_flow_error rte_flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	int res = flow_filter_ops->flow_pattern_template_destroy(internals->flw_dev,
 			(struct flow_pattern_template *)
 			pattern_template,
-			&rte_flow_error);
+			error);
 
-	convert_error(error, &rte_flow_error);
 	return res;
 }
 
@@ -964,8 +925,8 @@ static struct rte_flow_actions_template *eth_flow_actions_template_create(struct
 	struct pmd_internals *internals = dev->data->dev_private;
 
 	struct fpga_info_s *fpga_info = &internals->p_drv->ntdrv.adapter_info.fpga_info;
-	static struct rte_flow_error rte_flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	struct cnv_action_s action = { 0 };
 	struct cnv_action_s mask = { 0 };
@@ -1004,9 +965,8 @@ static struct rte_flow_actions_template *eth_flow_actions_template_create(struct
 	struct flow_actions_template *res =
 		flow_filter_ops->flow_actions_template_create(internals->flw_dev, &attr, caller_id,
 			action.flow_actions,
-			mask.flow_actions, &rte_flow_error);
+			mask.flow_actions, error);
 
-	convert_error(error, &rte_flow_error);
 	return (struct rte_flow_actions_template *)res;
 }
 
@@ -1023,15 +983,14 @@ static int eth_flow_actions_template_destroy(struct rte_eth_dev *dev,
 
 	struct pmd_internals *internals = dev->data->dev_private;
 
-	static struct rte_flow_error rte_flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	int res = flow_filter_ops->flow_actions_template_destroy(internals->flw_dev,
 			(struct flow_actions_template *)
 			actions_template,
-			&rte_flow_error);
+			error);
 
-	convert_error(error, &rte_flow_error);
 	return res;
 }
 
@@ -1050,8 +1009,8 @@ static struct rte_flow_template_table *eth_flow_template_table_create(struct rte
 
 	struct pmd_internals *internals = dev->data->dev_private;
 
-	static struct rte_flow_error rte_flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	struct rte_flow_template_table_attr attr = {
 		.flow_attr = {
@@ -1071,9 +1030,8 @@ static struct rte_flow_template_table *eth_flow_template_table_create(struct rte
 			forced_vlan_vid, caller_id,
 			(struct flow_pattern_template **)pattern_templates,
 			nb_pattern_templates, (struct flow_actions_template **)actions_templates,
-			nb_actions_templates, &rte_flow_error);
+			nb_actions_templates, error);
 
-	convert_error(error, &rte_flow_error);
 	return (struct rte_flow_template_table *)res;
 }
 
@@ -1090,15 +1048,14 @@ static int eth_flow_template_table_destroy(struct rte_eth_dev *dev,
 
 	struct pmd_internals *internals = dev->data->dev_private;
 
-	static struct rte_flow_error rte_flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	int res = flow_filter_ops->flow_template_table_destroy(internals->flw_dev,
 			(struct flow_template_table *)
 			template_table,
-			&rte_flow_error);
+			error);
 
-	convert_error(error, &rte_flow_error);
 	return res;
 }
 
@@ -1118,8 +1075,8 @@ static struct rte_flow *eth_flow_async_create(struct rte_eth_dev *dev, uint32_t
 	struct pmd_internals *internals = dev->data->dev_private;
 
 	struct fpga_info_s *fpga_info = &internals->p_drv->ntdrv.adapter_info.fpga_info;
-	static struct rte_flow_error rte_flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	struct cnv_action_s action = { 0 };
 	struct cnv_match_s match = { 0 };
@@ -1159,9 +1116,8 @@ static struct rte_flow *eth_flow_async_create(struct rte_eth_dev *dev, uint32_t
 			action.flow_actions,
 			actions_template_index,
 			user_data,
-			&rte_flow_error);
+			error);
 
-	convert_error(error, &rte_flow_error);
 	return (struct rte_flow *)res;
 }
 
@@ -1178,17 +1134,16 @@ static int eth_flow_async_destroy(struct rte_eth_dev *dev, uint32_t queue_id,
 
 	struct pmd_internals *internals = dev->data->dev_private;
 
-	static struct rte_flow_error rte_flow_error = { .type = RTE_FLOW_ERROR_TYPE_NONE,
-		.message = "none" };
+	error->type = RTE_FLOW_ERROR_TYPE_NONE;
+	error->message = "none";
 
 	int res = flow_filter_ops->flow_async_destroy(internals->flw_dev,
 			queue_id,
 			(const struct rte_flow_op_attr *)op_attr,
 			(struct flow_handle *)flow,
 			user_data,
-			&rte_flow_error);
+			error);
 
-	convert_error(error, &rte_flow_error);
 	return res;
 }
 
-- 
2.45.0

