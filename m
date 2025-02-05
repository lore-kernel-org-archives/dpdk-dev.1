Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65594C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF48E40DDE;
	Wed,  5 Feb 2025 11:46:37 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 7AF0C406BB
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:24 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2168.outbound.protection.outlook.com [104.47.51.168]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fljbqo900DXflvwy6PDRGlRwU+EV9fHurEj2VrVb8h8iy50+tE5bxx1Ubykv62raivNopGtBDV2c5OUFitnKbKEJnjGI8Wfr8OQtbYrhDw5/JwfRxvXN98/rjwxh8U3EvZdx0xeraBOsJhdChV52WaCwNV3JsV0xb04UzJMXVTlVrpWI8xYtJeYFtfzbD0Q5Sv5DaJDis4U4H1Evhr3CnpMnbuDS6/ttXSkDLsbqWlJvp0UKEiu6QmFNF9zO0ZGIz/lwy4EahL6eTyrimUDVIZAkN41mim6EXHgI5o35BJoEAbKW5woMfPlXN59ryXmXu5TFFL2OTbjg7Hm6baLaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2wax9YajM+oK7FsXicTvEjAPRPmgjdkjxHI+UEyut8=;
 b=dfrCIIKtNshQdc4M/SN4GNVa+MlMwg3ciMKhhkjR+xsUKVPgjnROCKsBEaVUH90XOxH3hduv2VD5CO4bJQ5spA75QqPJR3i+sqVy0v9/mnqYixBTUxuiDKRYn0EJBw84XzQHrqWNdBXs2NagoEl26aCK5GMLwj4d+vLnnFjs+xOFDCVKFBTJX0H+vlpFLT9C1rm0e45KP9aGry/xLqJvEEFNUqVu5JmMLs+ac5pCTecEFBLHnkrLl90AzRPdBHJZxbtq+sKX7nhkghxghSs5ctGXkdE4yVe5EWJ5CWPNRnQiJt6J7nfnVlrK3a5PkOdQCKYYlqOGNJkNyOmgI2WvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2wax9YajM+oK7FsXicTvEjAPRPmgjdkjxHI+UEyut8=;
 b=JRSQCoVtxTSPxB/JG2OUYYx1MeNEg3AeG2SYWrc3sZge9TlGBObErVUjyOdPC3F3/qPk5RMzvZdxGJH/yDyDzgUfjHQrW8sMCihf8o8ciXDehE7l4umLf4PTrUeCsOeOdytwfepY99jA8kg4zA1x+OVUXUJ6TfAnOCQLCwZLjzc=
Received: from CWLP265CA0358.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::34)
 by AM7P190MB0599.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:120::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:46:22 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::a8) by CWLP265CA0358.outlook.office365.com
 (2603:10a6:401:5a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 10:46:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:21
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>,
 Oleksandr Kolomeiets <okl-plv@napatech.com>
Subject: [PATCH v2 28/34] net/ntnic: fix group print
Date: Wed,  5 Feb 2025 11:45:37 +0100
Message-ID: <20250205104548.1533554-29-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|AM7P190MB0599:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9933026d-f4ee-46a1-0dd7-08dd45d25464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CTMK5c/JPym4hejpaKKFJ3qimO6YBfrADzEyOpmWxVLCNB5aeQHo54kJXKnE?=
 =?us-ascii?Q?dJ+1MQ2zcYsmjcQO9gZ3Gx9pGWvbS/Cm8DurUlUOzWUYvuaJhOmx0OcP+fXM?=
 =?us-ascii?Q?/ACrd7mtMSKnp5g/aehlalZ0W5lA7ts3G4sA6RnrNdkVjQ0jZKMflZtKvnbR?=
 =?us-ascii?Q?03cKBsh5DsNmpcsevbyyEpvCCzdFhCG/wru1b5yvgZaQ9gF41pNjXBCW2zG2?=
 =?us-ascii?Q?COOrvG7TwPQ8iicMgTN4WeXOBaYWDRcNJfYGOhOHlEWsUhoVwjN8Hsu9UFJe?=
 =?us-ascii?Q?WeTS+l2jwOuELMkeR4MgSnzgKZPuE32zbB68noYSWSe5NMfDQN2vtNQ+so3Y?=
 =?us-ascii?Q?k1o2tUsEeOE9FVSu+cHudzU2aygSoOgFxKtEPcn5sZV1dlqV4ZcBnxEN0zEK?=
 =?us-ascii?Q?xB70diAY3vzYBUdukybdD3r4YgeCG27c3i5S2FHrZ/eeu8G2C2ARbwiNIXbb?=
 =?us-ascii?Q?7R2FrpnOiRRKSPlJTC3nBqy4+Z71KQELsyx41rZrj+Uml2j75VSdLS7W+YnN?=
 =?us-ascii?Q?25xeiAcTvaWQKlwkTK8hEoCS5Zsxre8ZHql9aTMrtjQPTZakM30OklQ5TPWG?=
 =?us-ascii?Q?ZnIzO/8B2ieONB4eCdrA3LuEmjthsr0YrbQRxxCqCSWm3Onqr3vRpUdm6hfT?=
 =?us-ascii?Q?a2Iryjtt58TQC47mxQdr/h1vdCA0d5Goqt+5AKHJ/N04Mp/HQ5vuw5fPKGoJ?=
 =?us-ascii?Q?I/PRujgHbm02fJW1oMnpibGRp4tK3g5F6APBsNDePmUJzrOdiWiMv7yBGkiv?=
 =?us-ascii?Q?AjfXWMqQd7PPSlf2fSPViO7Kx8VuE02aKGllvZL6UxqfqY6XiT/DK4Lo4qYA?=
 =?us-ascii?Q?ia0f1IeetYIQ1ROuYplCxLB1YcVkHYxWxT7Sggc+qcsc0JqP0h4GZlv/3wEU?=
 =?us-ascii?Q?UhL8Z0oYS/qkXP+Gzu+Yo82eWZVFqhxsy5n1937/zBsJ6toZ6vFMiT4Hsw9m?=
 =?us-ascii?Q?PG9qlyY603GMd1L2dzXWA8sFs0/Ve4P8SHwfvrAN9ffGu5nA5GkQDY3lzoV2?=
 =?us-ascii?Q?KpIaoKNZzaQGCYMVmHBReIw5moI7ytlOzfCjz4HCPjHsj06DwXI7xoqZO/th?=
 =?us-ascii?Q?Gk29wOrZoDW12G5wMA6NsHCFQ3LVZ5EP+sSf39Zmgr0uboXfJtF1QMlPD9Qn?=
 =?us-ascii?Q?dTqJ2rYiEnnAICXI/qadG7Gv1RFFFKOJ2/PIirF4iGyvh9w5pqCv13CK8hgg?=
 =?us-ascii?Q?L82hLRRfk4vF80XpWw/031xRMRx6AcG08SsllHYndn094x3aCe92UudL+sX8?=
 =?us-ascii?Q?65vvhBIgrHatR/oQujI+meNkB31GHxj6SUMWOpfhj+pA/S7jb15k0qrzg9KY?=
 =?us-ascii?Q?VCHoyjALiPqooDVBRIEFziQI8yF/cqQwlaFcwZXR9GH/V5Zlqg7gkImkRbkJ?=
 =?us-ascii?Q?8xgYrSGyD5IXD3k7ONF+98mX8lABidLFiruiDWzA4uS2owztR9to9xkFza6Y?=
 =?us-ascii?Q?gY2dvpuabaENziMHGd2CEuzn8VCOBIaBKhC+DX4/vtpE60oBdfKoANXH7t4G?=
 =?us-ascii?Q?g/46NOZP4f63EvY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b853wP+fzv0Tv0RTvye7t2Gmk8q+f4vvI3ODS6KPymw+qD2uBAju+VMp41C/r5RsWcCSWYI6NtV5QJjZSdsODwqOqShSqbGG+4TeMNz92a0vR5XjdWjPBuPRXe6xoBlvvYambtzlMpqVxwC2YUulezFUc/J1Kx3paPsKPRzgOO6KGbNw9yleuz7OnEFnPwHfLP85XEorxjRAp+2E2FpW6ginIGpPVEFxy1unX3m94+ABw5NY1HN6XK6a5AMShL8N/Xhs18A8I3YgtSIIWpGux1Qrz3oBXHF2/xGyerQp+R4gM7fx8UxqvcJVZHVw2T2a4DiKahmXjNtMIwGc3tcUNWFCeuMbiwzp6JeaIdS/J9LG8li3swy9DZHwsLKEQJunIKiTxFB8nkabBOjzFm2LQe1rEXyQoWEeQ/a58I+opgN+rUIsFY6hQPAQxg6nvW2egeuy65EKwgIqONEreoG+Z1BOEE6Uem99BMA/J+lJVkdrEJDW/m3HcpW2BtL7+bFdmYMytFRoCR0BzWuLyex0gmpLO7ItkvNM/TPW2qDsmbMYUBDRmSBhdZqbYTZUhJy7NEOSJMhzclT0Y+wNEBTSv7drh/3emenN6k7jT8dAkQenv6eaOh4cFwxIywFTdTsqfT0U/h0mFsJq2oMvkHMA7g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:21.5270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9933026d-f4ee-46a1-0dd7-08dd45d25464
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0599
X-BESS-ID: 1738752383-311016-7904-647-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.51.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVibGJhZAVgZQ0CDJLNEszcQo1c
 TMLNnYLCXVyNLUEsg3T0o2TDJMNlSqjQUAx82QtEEAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan20-147.eu-central-1b.ess.aws.cudaops.com]
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

Flow dump output was fixed to show original group
number for `jumps` stored in action and match sets.

Fixes: 6f0fe142caed ("net/ntnic: add flow dump")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api_engine.h   |  2 ++
 drivers/net/ntnic/nthw/flow_api/flow_group.c  | 26 +++++++++++++++++++
 .../profile_inline/flow_api_hw_db_inline.c    | 24 ++++++++++++-----
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ntnic/include/flow_api_engine.h b/drivers/net/ntnic/include/flow_api_engine.h
index 636c53b260..262317002f 100644
--- a/drivers/net/ntnic/include/flow_api_engine.h
+++ b/drivers/net/ntnic/include/flow_api_engine.h
@@ -425,5 +425,7 @@ int flow_group_handle_destroy(void **handle);
 
 int flow_group_translate_get(void *handle, uint8_t owner_id, uint8_t port_id, uint32_t group_in,
 	uint32_t *group_out);
+int flow_group_translate_get_orig_group(void *handle, uint32_t translated_group,
+	uint32_t *group_orig);
 
 #endif  /* _FLOW_API_ENGINE_H_ */
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_group.c b/drivers/net/ntnic/nthw/flow_api/flow_group.c
index f76986b178..d1fa0193e1 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_group.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_group.c
@@ -14,6 +14,7 @@
 struct group_lookup_entry_s {
 	uint64_t ref_counter;
 	uint32_t *reverse_lookup;
+	uint32_t group_orig;
 };
 
 struct group_handle_s {
@@ -83,6 +84,7 @@ int flow_group_translate_get(void *handle, uint8_t owner_id, uint8_t port_id, ui
 		if (lookup < group_handle->group_count) {
 			group_handle->lookup_entries[lookup].reverse_lookup = table_ptr;
 			group_handle->lookup_entries[lookup].ref_counter += 1;
+			group_handle->lookup_entries[lookup].group_orig = group_in;
 
 			*table_ptr = lookup;
 
@@ -97,3 +99,27 @@ int flow_group_translate_get(void *handle, uint8_t owner_id, uint8_t port_id, ui
 	*group_out = lookup;
 	return 0;
 }
+
+int flow_group_translate_get_orig_group(void *handle, uint32_t translated_group,
+	uint32_t *group_orig)
+{
+	struct group_handle_s *group_handle = (struct group_handle_s *)handle;
+	struct group_lookup_entry_s *lookup;
+
+	if (group_handle == NULL || translated_group >= group_handle->group_count)
+		return -1;
+
+	/* Don't translate group 0 */
+	if (translated_group == 0) {
+		*group_orig = 0;
+		return 0;
+	}
+
+	lookup = &group_handle->lookup_entries[translated_group];
+
+	if (lookup->reverse_lookup && lookup->ref_counter > 0) {
+		*group_orig = lookup->group_orig;
+		return 0;
+	}
+	return -1;
+}
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
index 22cbf61b60..278be8b180 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_hw_db_inline.c
@@ -429,9 +429,14 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 				data->cat.ids, data->km.id1, data->km_ft.id1,
 				data->action_set.ids);
 
-			if (data->jump)
-				fprintf(file, "    Jumps to %d\n", data->jump);
-
+			if (data->jump) {
+				uint32_t group_orig = 0;
+				if (flow_group_translate_get_orig_group(ndev->group_handle,
+					data->jump, &group_orig) < 0)
+					fprintf(file, "    Jumps to %d (encoded)\n", data->jump);
+				else
+					fprintf(file, "    Jumps to %d\n", group_orig);
+			}
 			break;
 		}
 
@@ -440,15 +445,20 @@ void hw_db_inline_dump(struct flow_nic_dev *ndev, void *db_handle, const struct
 					&db->action_set[idxs[i].ids].data;
 			fprintf(file, "  ACTION_SET %d\n", idxs[i].ids);
 
-			if (data->contains_jump)
-				fprintf(file, "    Jumps to %d\n", data->jump);
+			if (data->contains_jump) {
+				uint32_t group_orig = 0;
+				if (flow_group_translate_get_orig_group(ndev->group_handle,
+					data->jump, &group_orig) < 0)
+					fprintf(file, "    Jumps to %d (encoded)\n", data->jump);
 
-			else
+				else
+					fprintf(file, "    Jumps to %d\n", group_orig);
+			} else {
 				fprintf(file,
 					"    COT id %d, QSL id %d, SLC_LR id %d, TPE id %d, HSH id %d, SCRUB id %d\n",
 					data->cot.ids, data->qsl.ids, data->slc_lr.ids,
 					data->tpe.ids, data->hsh.ids, data->scrub.ids);
-
+			}
 			break;
 		}
 
-- 
2.45.0

