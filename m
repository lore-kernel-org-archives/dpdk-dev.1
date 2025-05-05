Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88103C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BDA640DD1;
	Mon,  5 May 2025 09:13:52 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id A6AC040DCE
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:50 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2177.outbound.protection.outlook.com [104.47.51.177]) by
 mx-outbound10-142.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDH9qoxlVj3yAjqWHor6w5xSMrL6HhlclgRn3cRAYCdceFwp3DQfCEw7vin66hpEma8MqGEyDvB+uhZyzp5FWcF+zUJ1sDKiGSmZag4bRx7S5lcbZgiI0gDw7jx0cnxW/bzjUCgtotaOPCyIHP7XuAGHBD9u8rnLFGBpCM/TH69BvRiz51ISLJ4qhQMRtdtsGVi746+tyxT52Epgec/kdmD79EokJzvaf3Vzyv0HwAYDfOtMwuJ1ffUvgOQoVbT7iG2RLRDjqIzySStVgYo9Kgp9dpYAOQ4JjHnkTG7HxChtlw4N7OvUlQjcKrcA7tmMfar89kstSEQtb5HfGDrMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7mwpOOnALiOSJCrcbk3NdAsTT9y3RNN9ddfjM7PEdQ=;
 b=eqypDkG+XavQngBYc8oiGgAOXjmK/xSdKLMh3YhonvJtLigEegZU+V2fJPkACz6vjO33O5/jKjST0CYfw8MDP+iyLSeoJ0ngpxFlv1WSmK9QOodm497KpUQSXLmRV9xkxll5wsqeoCUlG2bRq4mbT+t77O/sW1GqJYjZJtMg3KldaurrNf7dWyJURanecRdrOoBCqbsNiU10+RSyEl8zn/1hj2F2lVQQX+at/rRpzmNdfIcWmHntzmSNOr4UqsDknX+cVFkayOqTnEzxAhO7s3VKF7xhPspTcMEgiDW1SEcpBzjlJ5Nfq1D80oJ+pa6zXODvapZDiKGtj9rB9flf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7mwpOOnALiOSJCrcbk3NdAsTT9y3RNN9ddfjM7PEdQ=;
 b=ZtS9dWyIow6AfoKHwL78wWCUzBzMFJfWNt4BvGM88BRhlD+Hs6VzOnETtRD8RgSVMMZKj04BW5eFwpYcgkah79/m/Wo74vcM92wo7cGrLU6QyP3nCLy7s1vgqGh8d1LKRXI/enpuEerWV1mchmIxntIUnqs6xNOhQGCc0dsFY0U=
Received: from DU7P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::31)
 by GVXP190MB2073.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:157::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 07:13:23 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::9b) by DU7P191CA0002.outlook.office365.com
 (2603:10a6:10:54e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 5 May 2025 07:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:23
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 15/26] net/ntnic: add handle memory allocation failures
Date: Mon,  5 May 2025 09:12:55 +0200
Message-ID: <20250505071309.586015-16-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|GVXP190MB2073:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e811bd67-0361-40fb-9d79-08dd8ba452b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g1ELl8TA8QJ76PPIwQP9SgiKtojVrHNM3DVWyJH9UDLWNxbz+PN7aecg+2ej?=
 =?us-ascii?Q?VaGmgarb13TCbdGqg1/i5LK60722E5StJ2cAxbajE9jc5MMz+mLuJRCeA873?=
 =?us-ascii?Q?PGwQCHM0vJhg9bDSS51M/yjRd/Guz79nXTyh3HiRwywYGiuOuCdkUkYJZgbG?=
 =?us-ascii?Q?4DCvUlXjo8inhfYuh8CxU2xltgbHBOsGSDGJaB+Yx0DLbN/0PgQowx96W548?=
 =?us-ascii?Q?+CSlwPOlrqw3TgMrJly0PvXEjg8oJkG0M1DP7NBEpm4G3N0t2e5KAYGQhQMV?=
 =?us-ascii?Q?+EbfnLdUQsqRcs6/5mEh0PVOCt9ULjJDPU99QVCvfHljEWqX5gamP9KiWosw?=
 =?us-ascii?Q?D3MCHnbyzu2uWYn5Y2dWoDLJJUarGrUVO8LMyngNGbz4kduGzWCzpSQXNCmX?=
 =?us-ascii?Q?qpOnoV1qv+iLINR8fccAIWjHnnb1+B4H1BXE5Un7dX37KXQgcrUFI1oA1VmG?=
 =?us-ascii?Q?dFiWswbvCGCVwnQ5dAjl6WLzrrivGQuBRqYYXbogP8y3D0oRbniQBPUxy9CH?=
 =?us-ascii?Q?YTh1mUBsvJs57yQj41jtUNvgDyYmf+/m2ckNsNJ7nZxoRGn2D+C2uVucarli?=
 =?us-ascii?Q?L9OkoNXwD7VI0HMYaiLFzP5F3kWeyShh6kSfh3Olbegx/PoQIetKCC4MIym/?=
 =?us-ascii?Q?O0iwGD3N/1kusrem35J86I19Voo+llEeiVSr87wsJdtnQJtT0o03yKCmHUPI?=
 =?us-ascii?Q?YCaFqZwJIYYFIsfJDFLaoU0aY7nVumBRIW65Z8RLdSz0NjEZmjM9RXPEiW83?=
 =?us-ascii?Q?eTH3dRg22rjzgcjCZMVw2KivHXXPAPNw5GveEzWZD8DQWZ3TiDzX8iUhLG0Q?=
 =?us-ascii?Q?szdeccUs5UoYvhvib5qWX8l2GqsEKy9arN8b8e47BtL8jh9VlSmzoHgZ6fUP?=
 =?us-ascii?Q?51F1hoLrljHfzkPVPNVBpVtE//cU2qbTSSh+QFXFWmM10jNSeLtTIi8APp9H?=
 =?us-ascii?Q?bHI8J1Dh2YK39fXzxprVJQKUpf73d+2o6Y3c2AwxSKmY/zSCoeG5fpy+nDXp?=
 =?us-ascii?Q?l6X6ACFc8W/38IKenbrvQM/JhXrImaXoIGc2OFpz92mlH7imYkvm5bARD4KQ?=
 =?us-ascii?Q?R1Jh4lWm4SAV+FtWiuLTZkHg9RPJ4z3TQZWX1BIJAvGfYTKP/B2ztw4bnkA4?=
 =?us-ascii?Q?oo71UQ27XVu6GIndcFHrlxxYIOT5tINuSUd/HZFJl5a3aEvHhRMNqF5oLbyb?=
 =?us-ascii?Q?uHEAvrs3HUJeyOjSHWM2t/XO119jygYTuHS1p6k1MV5LakcrkRWs2PwtqKuC?=
 =?us-ascii?Q?TJf6Cae6x02sLPCEHqngUtqMwUVngEtTjTcnwHpvDY/0ngFDMZqroxiyWZT8?=
 =?us-ascii?Q?6NDt2yX63zIeK7TXZyQfCP5HqeW60ZvfywbP27Y4JfeQotXC0DEHf3J1ee/H?=
 =?us-ascii?Q?8Ob0hskhwIwkmM4hJcMc6ynbeCOuG4i6qqmh4iCbXD99dYDTC3oJUS2Lt6vB?=
 =?us-ascii?Q?4XDoyewJLuBfa8sms99+Zs5IJP/Qw4vPsl/zRyklxmozNx7G/UHHtV6R4tcR?=
 =?us-ascii?Q?V5fktW4Y1KbWO5wbRmJ45TCEq/rXBI7ileB8?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xl3RgpZnXgT+J8zvRVJCFftw7kSOEmkOR80LfxcqfemId4MbwTyVTRGoqDd8LSqkJsBvejq8SZs7weq4uoD02Oa3udCMzTbw6AxShwh+D9RzR63Mmisl3HiZLx9w1k6TGoB3lUkpQAhE2BVSB6PF/U6vQFZB6V9+WVRcrux5jOkqpl4GQrwceNWBiz+9AgJEjnEW4e27S3NKKG7MW4akw9io01vxMHI+RQI0Kb5DgCfGhdOxG5ob6nNATpbRicBnD6TEBmrDTUGU3zeBFC7fPc6cYRihbtMNe8F7tK0WIAqFKmdtsRtuGAbU5aJvHSrTAZnog2bu0pn4AUxIXjd3v0O/sQBUSyVcfoT4oaT4Y9BnumJzCA++VFomKh0/uzExb6r+OK9DsKtu12C/63s2Fp79Utd19ReGYOWo26XzAugDCfQ49Zch18NE9Q4zpSzzJ0bnTgBVExiGRgEqrjR6QYdzsbgNTt/kKJkWUnLBJj+H0IDoqXG+qzxuQGGkV3IPwMK+E8v57dIPbkOd1lwNo7bSkKjLLba3uAlzpIWsPO1nBrLQ4PteyoGZ9roL49JMa33w+gtbegc+FD7LYtKHaZq7432/aW2Vz9vIcExaXTqvPcJATach20AD6vEoUMydtekEj0Ey/4RzUzhi/G/8AQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:23.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e811bd67-0361-40fb-9d79-08dd8ba452b7
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2073
X-BESS-ID: 1746429207-302702-10161-5015-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.177
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqbGRhZAVgZQ0DQ11dTc3MLcIs
 XAMsUyJS0l0TwpxTg52TTZMikp0chYqTYWAL7g3jFBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan17-209.eu-central-1b.ess.aws.cudaops.com]
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

