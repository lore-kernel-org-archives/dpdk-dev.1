Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F3C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8439E40678;
	Wed, 30 Apr 2025 15:49:31 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 5ABF5402D8
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:20 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 mx-outbound42-181.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1Oc9Jmtrjr6tFX5bepf2Xn/HZMmr2PpaRCoju/P463o27fCnmbBuIj4YbbV4a1O97o8UcpjHpFAGgFn5x/1tOAmgy7wYv3nMtOdLnuLzNWxITEnuPwbDQf6A+lwHz3YXhPn/Oi4ORbV9BcPtqyIhGQPscx2hEgtFa9BpnU4b4Ca/zSYY8Dt7HgfYTBL9Kkb7MmdeET2gqwK6DIjTcZiltftj5CYl72qX22cBatrkH390z1rvYX7ALrODGVLp4tOCPk/+R6t7D/qK8qLMg+dCs5REZ+YSo1j1vyuA9u/8AJIeACXJuIBaq0Zdu3DK7Bii/euP7d45LsBsqVtuzTyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7mwpOOnALiOSJCrcbk3NdAsTT9y3RNN9ddfjM7PEdQ=;
 b=NOzeRflugwdozRFuSRNTYt1zls1uqLrLMblF6HflZtIUBdWCns218v323Z1BJejLu1AGxei6PAmiGlqhvWr8aVTYbtmUDJ3g8mXXFOQOEq3nmOaOpPweojwH531gm4tC3iBAcTuD3uLMFAgntRzhBAP6idio/q0pZaQCcfAEcmkGcxvJbRaFf91MWVem+7GX87WJb9Uuee4dSUmDdVAV8RmIqpIkoD1FLy4alLpj22Ot38478BUwoWmWVhdPwiIJEswBMQmBhIEDyKNxwCHQR3irYTpn+45xWjAJozUmAvog49I49kgMDEqni7LOxhFhxc0+/tvRBsdW+odE95hkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7mwpOOnALiOSJCrcbk3NdAsTT9y3RNN9ddfjM7PEdQ=;
 b=hfWJH7dMlVlxMNx5kbL3TvigX/pMlxIi3mpmigSchlYmJqj3k+UFnDEMiN710y0sPjKYhNDR8H6qhFvruxhhnrgzSNHIMDXCrSU1lyLN7YfQ8fh9Ih34cPBL8a7k9kFQ8Q3rsJXE4cVWuhfyZBqFvTZidbYBqWrBFrRyY/b4wXA=
Received: from AM9P193CA0020.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::25)
 by DU0P190MB1803.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 13:49:14 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e::4) by AM9P193CA0020.outlook.office365.com
 (2603:10a6:20b:21e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 13:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:14 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 14/25] net/ntnic: add handle memory allocation failures
Date: Wed, 30 Apr 2025 15:48:26 +0200
Message-ID: <20250430134840.402553-15-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DU0P190MB1803:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88fdcb64-8c0c-4f02-c203-08dd87edcb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ihCAsiQ58KTIAKb/deMBfOvCVtB36mDOoWo/2x5tCDDZome1fZk9HSRJc1DI?=
 =?us-ascii?Q?KLzpA+7Oi0R+Y19x67nYvH0CkwzIDq3YCNyA6DrRdmQiE5M2Ncz5HwdruBrq?=
 =?us-ascii?Q?d3c4ysGkHMVe8rX1HspNTuyRj66Bio33oOmEH1lUtvVRhGMLlssNWunVOlHF?=
 =?us-ascii?Q?dxXLfmwgGI2hREWFKlV0Cv61a5hRkZvNoluEZbF6UPRwUAXGD6XY+nqlA992?=
 =?us-ascii?Q?9wvWyPrhk1O44jVypE/6SaF9ZW1LdNUVuN55jwTz80HT0uzZaOGcbSB6xBGh?=
 =?us-ascii?Q?rSXi8WYtI/auqHla/dmUF0x2MlyMkPOIidxWS8kbeWOFvM0MXiHwNySvnt/K?=
 =?us-ascii?Q?LBxOwVkl5T7Pd628Apc4qaP9JrpFG36zJL4cO2v5ErdrI8HSImfrAEM7bHJ6?=
 =?us-ascii?Q?gs0HXYRhY6hsiE1PnDKRRY5ULMJovOfQu0VQ5RmYgRTotivcLfbGejX82b5N?=
 =?us-ascii?Q?QxxUrvpS7UpiqY1ApLe8TAIecHdOmIARfLj267PskCDVYSSJp0KSq/0idYRE?=
 =?us-ascii?Q?NTc8bqRpWpk6jmuww8XBLlbmRqDLjVKX70GzsaL3EGbteDkrnQ2UsggfQHQb?=
 =?us-ascii?Q?So1v4JR0OOWskvlRwcsFCgQiK1PRkf2QHIeosc3htybAWd4Q+xMoWUPdXNfa?=
 =?us-ascii?Q?J0Vtf0R8gd+HlHMxZrUddgGy0TpmBFiMZ3dbQaQPJKlsAUu76kurUrHyVB0y?=
 =?us-ascii?Q?doS5XceKaU5DXGGWaFsKQbyiiq5PPcVwvMoxy539j1mE4B/+AjjOZJjnIM6o?=
 =?us-ascii?Q?AO9theq6tXsuq97KTR733nFqZZeSlRfOcw8EDQXJV1ISskKPEGgGuIsKjJxb?=
 =?us-ascii?Q?UJqqcEKfxRVpeWgB1+Jo3UzzCcwWDYTqX0liwtJompFMk6FHaPn4a6XA/G+e?=
 =?us-ascii?Q?nn35VfbciAVJ/jDJbCwRB2JVo7ihAXHRK6fegRXZnpndwqhUIXNHgFRYPdta?=
 =?us-ascii?Q?w8ykOy0/3YQX5tbsQwCI2LbRPuQS0Z3naAFuWxz/ePteBK3AtIhtq0/vVhYM?=
 =?us-ascii?Q?VgheZsRUQLwrYPKoRVjCcV+SBTx4rYff0eoDhK0+bc/0mLJERw5I7REQM+rA?=
 =?us-ascii?Q?4IqYkpQs0ZaQKgkugtjPvLBZHNUwY1pWVW+qGj6W6od3penMay2oQYjPee2J?=
 =?us-ascii?Q?yuEOlrh2e3shl9sMIVVb0OHtpW9bs6QgH3TvK08H6rOnpxJ0DryH9MDxp0Pz?=
 =?us-ascii?Q?8sT8nWrcFP6WpGU0ds7dd58cRwQzMyVxCLcytm5X8rDHr9i+/YTux6BvVgFq?=
 =?us-ascii?Q?LVk+y9iaS26QdvSR5FSa5tnkkmmtnonr3LV1/OJGGReTTNml3cqg4CDeh2Ra?=
 =?us-ascii?Q?vIDG3VETW/1PCYWjYudE65EYbZnpuh7GyIa3BYl4HWamxswAoiSLSrpqtOFe?=
 =?us-ascii?Q?wmLjiv9hGmr1fqN71slYUt5EqBePCRAhvlEip3YlgP4jW0lCinV17V9iyDcs?=
 =?us-ascii?Q?ETLSPB9Op71PKDB4edu+4Qk3S1QLQPxPq6UpGlimE4YHSHau1TGPdSzt9/o/?=
 =?us-ascii?Q?Kra+1cj/0B42q1C5QR+XANWmc7tyN3xrmGH1?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uLWnW0IhixCOjObus6rg4YlxzyT7fPyCUMRFbIilevPLR+ENF9lBYqd88P7KrQWF7K5j4/ogHn6HzbI9N4arJKL4GD4uJL3W01zseGOoF1Joxjdw3h2etTKvskq2YThqFf6zZnIM0ZSLnwCWAoEjuouYz+l39aqGKVgyp5AZVqkSgjX5FG9x/6ZWMKUWHIT9FBtwM1H5E1JkSZQMlsZfwzyOplkQoU/aK7c+xMEVB84EFgDnQzrj5zSYK9OZJaDldin8VkJ00h652KrcbCtPCjEi7ypqSQS+gw+j0NqXnRqeegjGWdxvidxaa/cIQRNaZo2ShcTV7712dbt2fr6RI0rGbY/np446dB/Tthvhc/CG1JfdloaI2UF8UVomCEoOj3vtuT9PFQ1FlloCst9ok7zBRaCWTbSQ+aFLmh1g2ALNl29Z1MYujLXUIISpY3VRaiEkUJTnyefrp+h6bNzWHX5o3+3KDW7KJtM75PyreHTnzocDJJFXHAFFqia0j1D2koG2ccyF0/HRc/iPS2a3lewlIkltZf74m9bD4CKah1iK0w5ZwMVjsGAwym3yk/tXPd4Y3mH2Q/wQd95rPELSLJgsBC53Fu/E7qPxsZyO0dFh8dXShe2h2/kRPR7qdmcpl/sZHmIARBbjfwlOCq5QOg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:14.7119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fdcb64-8c0c-4f02-c203-08dd87edcb8d
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1803
X-BESS-ID: 1746020956-310933-8000-573-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbGRhZAVgZQ0DQ11dTc3MLcIs
 XAMsUyJS0l0TwpxTg52TTZMikp0chYqTYWAL7g3jFBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan11-154.eu-central-1a.ess.aws.cudaops.com]
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

Added checks for `calloc` return values to handle memory
allocation failures.
Check for null in rpp_lr_nthw_init

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/flow_api/flow_group.c  | 17 ++++++++++--
 drivers/net/ntnic/nthw/flow_api/flow_km.c     |  4 +++
 .../profile_inline/flow_api_profile_inline.c  | 26 +++++++++++++++++++
 .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |  3 ++-
 4 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/flow_group.c b/drivers/net/ntnic/nthw/flow_api/flow_group.c
index 6e010c1b9e..f2c9bcaaa5 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_group.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_group.c
@@ -30,14 +30,27 @@ int nthw_flow_group_handle_create(void **handle, uint32_t group_count)
 	struct group_handle_s *group_handle;
 
 	*handle = calloc(1, sizeof(struct group_handle_s));
+	if (*handle == NULL)
+		return -1;
+
 	group_handle = *handle;
 
-	group_handle->group_count = group_count;
 	group_handle->translation_table =
 		calloc((uint32_t)(group_count * PORT_COUNT * OWNER_ID_COUNT), sizeof(uint32_t));
 	group_handle->lookup_entries = calloc(group_count, sizeof(struct group_lookup_entry_s));
 
-	return *handle != NULL ? 0 : -1;
+	if (group_handle->lookup_entries == NULL ||
+		group_handle->translation_table == NULL) {
+		free(group_handle->lookup_entries);
+		free(group_handle->translation_table);
+		free(*handle);
+		*handle = NULL;
+		return -1;
+	}
+
+	group_handle->group_count = group_count;
+
+	return 0;
 }
 
 int nthw_flow_group_handle_destroy(void **handle)
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_km.c b/drivers/net/ntnic/nthw/flow_api/flow_km.c
index 7b0fdddeea..9c76e8639c 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_km.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_km.c
@@ -84,6 +84,10 @@ void km_attach_ndev_resource_management(struct km_flow_def_s *km, void **handle)
 		*handle = calloc(1,
 			(size_t)CAM_ENTRIES + sizeof(uint32_t) + (size_t)TCAM_ENTRIES +
 			sizeof(struct hasher_s));
+		if (!*handle) {
+			NT_LOG(ERR, FILTER, "Failed to allocate CAM and TCAM record manager");
+			return;
+		}
 		NT_LOG(DBG, FILTER, "Allocate NIC DEV CAM and TCAM record manager");
 	}
 
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 3fb867c993..5bf8a9a3ea 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -3476,6 +3476,12 @@ static struct flow_handle *create_flow_filter(struct flow_eth_dev *dev, struct n
 {
 	struct flow_handle *fh = calloc(1, sizeof(struct flow_handle));
 
+	if (fh == NULL) {
+		error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		error->message = "Failed to allocate flow_handle";
+		goto error_out;
+	}
+
 	fh->type = FLOW_HANDLE_TYPE_FLOW;
 	fh->port_id = port_id;
 	fh->dev = dev;
@@ -4929,6 +4935,13 @@ struct flow_pattern_template *flow_pattern_template_create_profile_inline(struct
 
 	struct flow_pattern_template *template = calloc(1, sizeof(struct flow_pattern_template));
 
+	if (template == NULL) {
+		error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		error->message = "Failed to allocate actions_template";
+		free(fd);
+		return NULL;
+	}
+
 	template->fd = fd;
 
 	return template;
@@ -4994,6 +5007,13 @@ flow_actions_template_create_profile_inline(struct flow_eth_dev *dev,
 
 	struct flow_actions_template *template = calloc(1, sizeof(struct flow_actions_template));
 
+	if (template == NULL) {
+		error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		error->message = "Failed to allocate actions_template";
+		free(fd);
+		return NULL;
+	}
+
 	template->fd = fd;
 	template->num_dest_port = num_dest_port;
 	template->num_queues = num_queues;
@@ -5266,6 +5286,12 @@ struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
 	if (fh == NULL && status == CELL_STATUS_INITIALIZED_TYPE_FLM) {
 		fh = calloc(1, sizeof(struct flow_handle));
 
+		if (fh == NULL) {
+			error->type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			error->message = "Failed to allocate flow_handle";
+			goto err_exit;
+		}
+
 		fh->type = FLOW_HANDLE_TYPE_FLM;
 		fh->dev = dev;
 		fh->caller_id = template_table->caller_id;
diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
index 12d9f27e20..99245bddaf 100644
--- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
+++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c
@@ -62,7 +62,8 @@ int rpp_lr_nthw_init(struct rpp_lr_nthw *p, nthw_fpga_t *p_fpga, int n_instance)
 		p->mp_rcp_data = nthw_module_get_register(p->m_rpp_lr, RPP_LR_RCP_DATA);
 	p->mp_rcp_data_exp = nthw_register_get_field(p->mp_rcp_data, RPP_LR_RCP_DATA_EXP);
 
-	p->mp_ifr_rcp_ctrl = nthw_module_query_register(p->m_rpp_lr, RPP_LR_IFR_RCP_CTRL);
+	if (p->m_rpp_lr)
+		p->mp_ifr_rcp_ctrl = nthw_module_query_register(p->m_rpp_lr, RPP_LR_IFR_RCP_CTRL);
 	p->mp_ifr_rcp_addr =
 		nthw_register_query_field(p->mp_ifr_rcp_ctrl, RPP_LR_IFR_RCP_CTRL_ADR);
 	p->mp_ifr_rcp_cnt = nthw_register_query_field(p->mp_ifr_rcp_ctrl, RPP_LR_IFR_RCP_CTRL_CNT);
-- 
2.47.1

