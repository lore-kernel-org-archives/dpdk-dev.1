Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F738C369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76FAF406A2;
	Wed, 30 Apr 2025 15:49:38 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id DB9F74065F
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:25 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233]) by
 mx-outbound12-177.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJKAlHHTqtSSnVji5smL7p+K+iqwV5ZNY2TlYFksU7/RRBu8VdKdtG/YVU2sFxp4Jd0UVYOfO3Xenu5IfH3bRan/YLbQT0dbCFfFR5+jjT676e2ST1SMaZc4dXx96BkKXYxrskWt7fqRrPUk8dJmbHJPa+I1Jhx1caxUHj4fdZ4pFol/BJY0wuSBQVIajlXIfD2mQPYw5scKyZVXbgfn0fByC2SvREQ20r1Z3ndK7Noi9k65fPRSwZzbfPs9TgN+JwJPmVPP2X4DZ/M6g1am6nHsoF1R45peAF1seyM0A5I28bc98tEB1BwRzO3oIEEqX6Z02PgA92lXQHMogNYnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0MUiSxuB4W0fI034a+KbuK01Y6Ig3Jf56H8CMXnKJk=;
 b=Rz081YAvyUg4sNYd4Y/JydHcye91CThxDVTb9AJSbBGFMLA/L+zPtF6JWlA6jVFl19+SvNxXWS6zAf9YHx7AuXW5ibSDUuhfnlyLMsJ8hbCHyvgPARNQm5o4k3wKo3kxHY4t5JtS3nGsPjzYKBpELcGOI7lht7/PrkedbzdlH+4iwgbioIMmy996qdlMgP33hkCorebzfRn/uwKMaNNbxdnmPTLS5ZQmyUnSi8cyZL62QB/RScqq2nbndVdG+UYLcZPl1p3s1JIoTGqC/GoUcHc2eri15FJWFeVGYyIxTi3Hj7R3bAE8hfu8BrP7pkcwoVzsUb9Bof0dEemnxmuWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0MUiSxuB4W0fI034a+KbuK01Y6Ig3Jf56H8CMXnKJk=;
 b=cjbMQdnGApM73v133yp4KCQRqIxWo1PHiot2UmBADjyhLscoSgNOmfwxyoWSGLyACRdtuEsYGywqnnkoTyZNq0YKp14uNTFIHBLuYTMjKqb5fM2JbZTo1l3DiyjdYvt9wPsL8VhSSNsTekoCAAlRf9ZKtg/c1r/XmrQ2lz4BusQ=
Received: from AM9P193CA0008.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::13)
 by GVXP190MB2154.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1fc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:15 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::52) by AM9P193CA0008.outlook.office365.com
 (2603:10a6:20b:21e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 13:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:15 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 15/25] net/ntnic: remove redundant initialization
Date: Wed, 30 Apr 2025 15:48:27 +0200
Message-ID: <20250430134840.402553-16-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|GVXP190MB2154:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4cf074c4-dc46-420f-a475-08dd87edcc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dERTjPYDp/wkgHHgW4JpUbzkIt9P3gp3on+ldl9ioMr8jqghleHEo2YMFPaE?=
 =?us-ascii?Q?68j3p9h8/IyRyiygufMzav60MMt3KMMkukwRmvWugqGBVYokBLlpYkUTCfYN?=
 =?us-ascii?Q?oxw1g7IqYyOj3diOzcVK1mo5hwUuSQQ/1xyqJuzdpOnP0o/L36EgYYWSV/5I?=
 =?us-ascii?Q?QlUzSs51bjhnJNOo2n9jErQGnBNhw8rLQcn+flLWXdP/evE+CtuPESbAMDjh?=
 =?us-ascii?Q?QP1G7jviLQHP2pz5gEtF9KZ0Obb6FXzGQxfzPU9sxV1vQKQHm69y0BRrx2Qp?=
 =?us-ascii?Q?YjW+NwIR1X4O9G76gDziIVNedzv5dQ4sP3JCDnJMnmIUPOeoZ453eL7OrojJ?=
 =?us-ascii?Q?PffQXpLUFD0IQ35gCMGPVHw/I/Plsc9yzBRgjrAT/nloGTezWXOb6RtXr0dm?=
 =?us-ascii?Q?HLSjBhsWd49ULJdtzWZT9XZKmt0AVHyDcItKcxAUqxWuL6YUf4RyOmEFx9iC?=
 =?us-ascii?Q?9OdJ5LXsgKMKEhiALFeglA1MoXtYcC7/HrJWtABBK0K6hwxXTOaLEUhx0hXU?=
 =?us-ascii?Q?J2HXM1AEcRdI39e0LSLN0Zwfx0v5YNasm0lDtLSfFxQvip5QVUBEhgDGru0u?=
 =?us-ascii?Q?aV43ORhPzZfJCSWNuBDc5Fg5uFLl9+G10X5jiRL/xlfVkELuhACPpaUkMPP5?=
 =?us-ascii?Q?Q6dDkD6i3HSboN4cAhf6I0+4MtgnQ8pP5QoiF/y25I0csjERcNK9iOQy/wqb?=
 =?us-ascii?Q?ICdsfbXGQ/PpbD/YIcZNke0+C+PlSIVdhSXHI4QWIHPsQGt6rEn7mojr4UWM?=
 =?us-ascii?Q?lCgZPKeLIFDl9b1Pw4jmxX7auEuzZSdJlBRVfyYGoJ3B4dqI8G0zNX1f4T3U?=
 =?us-ascii?Q?EFBVupbwMFlWdaqtbI7pnjNA7Jz6CW9aipUcwgyVT9iDAwEcvxOqKxGShwbU?=
 =?us-ascii?Q?rUcrF57GsJmDU2WVXbf/YFpz5+400FOc6h0xIKS2BvHpS5XLhcH1XORW058/?=
 =?us-ascii?Q?5dQOw6OUyWhad8DCPXoAr+a7pQLcwCWMR85ghx9ksLxYBVZfgP+eTIBiJoVv?=
 =?us-ascii?Q?54Yy6PBEZoLKfe5tkGFflRR/8a8ff37mf+i/c2zCFZIw3MgQsoRuuKuYdgnP?=
 =?us-ascii?Q?0QVJn81aAfvKev2U0qyu6dGTjT+YRjK9sBBMsd3v7WgD2cffmjTwEnT7UDQn?=
 =?us-ascii?Q?4ZWN/9QykRRwmNZ6ZpGIYGux/FSNN4ai29+9UGetSafy3VVNdTWXBE9dBnel?=
 =?us-ascii?Q?vju7ZFb69t55h/hb7hVf+L4aCbOjyP5KEG7qYGAGWkwjDYfkRRuxXs7seTN3?=
 =?us-ascii?Q?uPNNE8nkOyEzYxaScDiS1Uu2qpDHT9XaclXfCbOGOl2lX4+rf+LsHPSW71hG?=
 =?us-ascii?Q?tDAz/cCt+htgFv3TNqkQQknnWEOdAtwrYGiW1LZxiOKB0Hauxv/qIgEWVgpG?=
 =?us-ascii?Q?A6gsw1u2hwXCe5n7mjbmvHJYrzf0Zg4KbzTwYcZYO9xVoqnaVtZBg50MH3xw?=
 =?us-ascii?Q?pSd0lX0YIUZeNrx3MEiu/rBv8fR7lAkoL+5wwY3SqaMkHb7/a/k4c9fxo88v?=
 =?us-ascii?Q?AKNWuCjomVzwvftcWOe1I4I7U+3FfWp+Qp4r?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p5YvV6qDN+Guj8Tp8s3B+qUNysD8h9rqJ3UihbhZQnC7jEp8SJ+Yv3GZRwd3SHHoB3+sckP/7KAX30AjteHjg6J7X6wKNQdUikj4WX5MxDgNM56EbmOQyK2ul5ybcr4qSasVD4zCA7VC4Pf9kOXzEBSMPuNd+FjDs0/AMDLA3DJ06Ghg0B1EvDPwNFgVNe2TYZdFTIZ7yAYUxDFKT4u20VXWFik2yXYLDFOmmGAatcpCmvFjnCtuJDoYumRhzHrO3sOCTHWjNX29X3KZUu7TP6o/KDCG+ixDIlBHihPliVLnZLx0pybd7GSAH/g41ysD5N0xvQxIjlIKmb3p62PQ29UYqsgpkL1BxCVn0Dr3qhs7EGXVGrz9hdEsiLhLdggs6dMduS2bwXzcCsTvAW8EUwLt17+jVOVmezYOn1jb6BvF646FffksCEmTCc3voy218jySYFgJjNlA9M/72lYX801Ixfky27xzyVF3yKejl2otH2uNJz+y8nW2dd8yCxwo4XqyYZjcXlsUd7Zq3KHZqU1BPKve+UCbvvMf9u03Q08mg6zl/+duecE0ps8XFJs6NFDXrzSDj8ujmQqVKif4BukvP4IlnpA6KKQh44cteQuUNAia8xRR9oWw60KD8tWDabv/lMCMXQu2qtRCj4KZ2A==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:15.5621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf074c4-dc46-420f-a475-08dd87edcc0f
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2154
X-BESS-ID: 1746020962-303249-7653-581-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.233
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaWlqZAVgZQ0DjJxMzEyNLExN
 QwMcnQ3Mwo1dDAxMDcyDjJyMLY0NBIqTYWAFw4IAVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan18-12.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

Some variables set twice in the code.
Fix host side FEC enablement

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nim/i2c_nim.c             | 2 +-
 drivers/net/ntnic/nthw/core/nthw_phy_tile.c | 1 -
 drivers/net/ntnic/ntnic_vfio.c              | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index 5e8eeb16a7..c6fa75e13a 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -877,7 +877,7 @@ bool nthw_qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool hos
 
 	write_data_lin(ctx, addr, sizeof(data), &data);
 	ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena = media_side_fec;
-	ctx->specific_u.qsfp.specific_u.qsfp28.media_side_fec_ena = host_side_fec;
+	ctx->specific_u.qsfp.specific_u.qsfp28.host_side_fec_ena = host_side_fec;
 	return true;
 }
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
index 77400d2514..5b2af77f7d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
+++ b/drivers/net/ntnic/nthw/core/nthw_phy_tile.c
@@ -797,7 +797,6 @@ static uint32_t nthw_phy_tile_cpi_request(nthw_phy_tile_t *p, uint8_t intf_no, u
 	/* Find quad lane */
 	quad_lane = nthw_phy_tile_read_xcvr(p, intf_no, lane, 0xFFFFC) & 0x3;
 
-	xcvr_instance = lane;
 	lane_offset = (uint32_t)(lane << 20);
 
 	cpi_cmd = (data << 16) | cpi_assert | cpi_set_get | (quad_lane << 8) | op_code;
diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index a62234353b..8d955e8342 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -68,7 +68,6 @@ nt_vfio_setup(struct rte_pci_device *dev)
 
 	vfio->dev_fd = -1;
 	vfio->group_fd = -1;
-	vfio->container_fd = -1;
 	vfio->iova_addr = START_VF_IOVA;
 
 	rte_pci_device_name(&dev->addr, devname, RTE_DEV_NAME_MAX_LEN);
-- 
2.47.1

