Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB16CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BD6B4113D;
	Mon, 20 Oct 2025 18:43:57 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id A456E40678
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:47 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
 by mx-outbound16-221.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM5yDNoRYkAF6SWqlNWfIso5fBRrdxYv4rFCfmTxip3bDGdPY1Uw+A6gAN7OokDsSu+vVm1Y1KC3mg/oDfM+AKmhqStNeQmLkiSbgORKMWEvufLih9CSZs94Z254T1/e2y4/R9bxu6CyZCB+Hf3EsmWBdgPmvZ+wAjsszdqmt3baLcyV3BvsuzYDPvvRisOsmsqJO1jXE+2JcUBuDT3F5EvqacvILwfdiheylj6jp+bSdSsSrz2IcKYQsytqbM1CToPgaDVpwMvvN9LmWuKfKY+2tTE76YPXTILToT3016IERBokot1gluDBpYB6EqT02NNgDo94Ezec4qQBoLKXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCJHWB0jxyba3MCD0AeNfx4ynSg6Uo3M8hd3lHkp/Ic=;
 b=yIBN7eUnqySD+pHmtqfDCksmGnqT6LvLTF4XoSUXXju3sTYccRYi9y5NIAFmYsGzTaR7/bobYYKPxhOBBviO2sedffUdO9JrOEwRRFIcejVxPsbMO6JrSVOiUhI2zRd9upfLERjzC8u7H5hE1v4xa1MDs59z1Gxj/2+OUOs5W2KuzN6JdP4ZxZFbIBxP/ac5pNRuo9IbKhWYMU9ld7N3pJwm90wUMI0upb4nh9L0lRCFG72rzuEhQFp7LVb6IApeVc0VnqeFmlfOR0Dsnd7AKY13WkPza7OKKeMUTGTK8u6DNLjmfAC09IevfbeWl+IvU8hP++eOCxKUr5K8vqw4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCJHWB0jxyba3MCD0AeNfx4ynSg6Uo3M8hd3lHkp/Ic=;
 b=Djz1F6ntbg6KZZd2koUEixMnq0dJuctYjqwjMdITzt0vvVxAyMoYWAjCYnbEv6dZkwplJWVGd7Kff6zAu+69AONaXK8K/txXyg+5NtTXWXZP/rTBmiHFIBC+XU3JF5W4AjJApZZwsxegFIuPyvCCTNTij90ngA29uFkl8EI57yA=
Received: from DUZPR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::11) by DU4P190MB2224.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:571::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.8; Mon, 20 Oct
 2025 16:43:45 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::a7) by DUZPR01CA0024.outlook.office365.com
 (2603:10a6:10:46b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:45
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 08/21] net/ntnic: add reset init stage 6 for NT400D11
Date: Mon, 20 Oct 2025 18:43:17 +0200
Message-ID: <20251020164336.283664-9-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DU4P190MB2224:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd2959fe-7864-4479-85b8-08de0ff7d601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0LkFOEbO7rvAGhqyGAOuR1SvpZIYXTCodWYZMEJdD5fr2IQdny8abPgXaAgo?=
 =?us-ascii?Q?HbwfbvrZZbimWQOqQL+8RqKPMnfPMYrHF7J+6Q2OGRjtwv8zbiz1FmQ0Z8Dl?=
 =?us-ascii?Q?hoDDvBXewmbkTbDEttlZp/ECBnWrt88lsnpZhxt29gaMfxmLoksUJbcsyjH6?=
 =?us-ascii?Q?TVYrvDJ0InSdDbYcxqqq6w89Qs8BcxRmO7Qtoj+w4L1Szt9Fmolgu9AKumSZ?=
 =?us-ascii?Q?8WdTPL4tkQwzWLyKPL+tyX+t4R4NB3ujERrKgjovJj9/+NROT+08Td4ienMv?=
 =?us-ascii?Q?XEErl6+V9G0ILOBrmqVPM2CIcNrzJ8xb1D9mehpctRb3dSAb59UIh+lUHaBe?=
 =?us-ascii?Q?o86q86ENYKVAGl0NoKsCyMBpucgelCmhrbxDYjj4UFFViOj6wrwL0G7oN5wc?=
 =?us-ascii?Q?ZmDJBoLkX71I5RbOS0fwVOftRnXkn7zPkh3FMBLDQnQ5yuCXOJrRFclKZQTX?=
 =?us-ascii?Q?yDwe0eMjbEJWt4jFUhdSQ1nJ8zg/D0W2a5lOQTIzcXEHH1Xn+UZ7wOieYEaa?=
 =?us-ascii?Q?4Yz9kMA2TAnNoUhlI39i91W2hutTJfQswoZ5q6vGGRT5BC0t1nmmeh0dTZUN?=
 =?us-ascii?Q?7iQSF+XA7B6qXpMN9Ux2OhSRWAFVfKMPFyx33GRVDtQE1n29JBDmSaJGuosZ?=
 =?us-ascii?Q?OClpACrIanXQgpkHzNgvWyo+Kwx1e1PVzxAAvkHJPgtB79G26Ehgi+aFYksL?=
 =?us-ascii?Q?2V5FLR5XtB4pVrQRFV6jtTNwPBD0sgxJXa4r94PL/RzYDyu2JJKJC9qez5Mb?=
 =?us-ascii?Q?D853A0ei0Jau0zphsaEpNjMGTzwX8EUiUrxeNmkO962S0IUVrSaDcMdftnQB?=
 =?us-ascii?Q?38f87OLDBuimYu6rZfbbkvwqe2P2eou87E1MdoYuNROosgWSNBaf4Iu31Umz?=
 =?us-ascii?Q?nYt6RgTD9Y+jrm+xDn1/jimAV8I8S3budwyqe76ayAVIclkgJNCR4VUzrlyz?=
 =?us-ascii?Q?xWkEcZBpE84YqLZpujjow6jVS89tbuXyhs+xKJhVzs4fGuDBECaWHA0oPA4L?=
 =?us-ascii?Q?1Eo1CfJpmfZgFBbnv9k9CEyvonsFE5dOQGeb+rAxRILUh82E8SV5Vclm6RGu?=
 =?us-ascii?Q?RpQ35tdYquQYlca2stTklKmw3JsY6koubi/Niwq2xjHA8IP4Mtfdq6mQQROC?=
 =?us-ascii?Q?ggMElmT1dxUrLvfJHuHmK4aiEakjR3EdRErUZMjgWHT85OkO/vStlzPRy6o8?=
 =?us-ascii?Q?LLH/s2GC3ekwhCKar7fRpSBK/8Y7dpRLuwp0/o58gFCMpYSKiasPb8Efion4?=
 =?us-ascii?Q?rcEnAo2ljEoHs5aLu6JGswsvsfAdfnnDPtlJC5I9g+SrkAzHlCiRi2awNSCF?=
 =?us-ascii?Q?N9v83W8/W2QrKSIDKP0KVxxbeIt7vk0u8HtfU9aUTTasIhhhDVRx4OeWOXDX?=
 =?us-ascii?Q?MQwUILXo7mJtJsOOG8BI5S3fGDOcq7zJPFmySGVfSWGIWJycO/Yxxpxv89KF?=
 =?us-ascii?Q?E2QuCPiLu3oIbJm13DsQVJARQ2ZAL9hS9EQEtvmgx3XXs2+WfKRp6EdM6fsc?=
 =?us-ascii?Q?IRE4nNQOjNPlwu2NOfs8mv4mzwrBAvWFyslMNz296xD2ZrbZlGDky5DxT+L1?=
 =?us-ascii?Q?KNVmiLskiC1yD+CGYR0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fXq7M9qEiqOULWEpJ2gSGVNjsA30Xt01P6z0qGvoS1RqdjxssJ1ErUpiJjubJYScstHB8QtyJju2pR8VsfHtA2vfluIrnjLVORGmaWwkSsHjm8y0wfSV516UXw9kquuvhkJ3Ikxo998yMNuw4U8AA3BQWKxWRWL0yd9SQ5nLumL2sX5M9znru6Hk+0Y8LWnFpmktmAE1PXoKEZFZ8V4wK3oWtS2u2funfaZuSKzgYcjFdjmpnc6pIGjrGLVXdJ6KG7mSEEiYAsvfdwokNWwSZ3iFCfPh3pfgyZxQIdTWrnD7ptAoefUu1UmoKi9+kQpGIV3zIw4ilqYWGvvXfblOZQUowYzfjY+DJ37CKfw5QFJHQaANyFj99givP9C+OSpVKA8UUxobP7NjR+X4ydSiy0bvUH1Brgye1E33BnSUxQAr9jWHcx9/MaQfJG7YXVdQ1KqRZW/LdBPEOEECseA6WniHwTuTD1UbkzcQWgbHFoOFLwmSw5tUJM4h75aYTU+bKdDuqAdMVOpTUxEUIP0Zqj87YY+E0N6LQ61VDk+eXT3sCtNO4lc0q5D1sp5KF9eONGZgDV9aGylW41mIHllEkMoIApTZYRaVeUkX8KfiMtFRRNef0P6n0LQIZONH95l8tC32Bwnpb8SmwMZFV9vrezyuijoZWDhgHCvKjSq84Q8=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:45.3474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2959fe-7864-4479-85b8-08de0ff7d601
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P190MB2224
X-BESS-ID: 1760978626-304317-25455-11877-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.84.95
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmBmZAVgZQ0DjZwtTCwMAwxd
 IkyTLZLNXS2DzNMNUy1cI4zdAk2dhEqTYWAJCq4HtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-122.eu-central-1b.ess.aws.cudaops.com]
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

add De-assert PHY_FTILE reset.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index d8c1dc4529..5ddf0a093e 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -79,6 +79,12 @@ static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, u
 	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
 }
 
+static void nthw_fpga_rst9569_phy_ftile_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_phy_ftile);
+	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, val);
+}
+
 static bool nthw_fpga_rst9569_get_phy_ftile_rst(struct nthw_fpga_rst_nt400dxx *const p)
 {
 	return nthw_field_get_updated(p->p_fld_rst_phy_ftile) != 0;
@@ -243,6 +249,13 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 			}
 		}
 
+		/* (6) De-assert PHY_FTILE reset: */
+		NT_LOG(DBG, NTHW, "%s: %s: De-asserting PHY_FTILE reset", p_adapter_id_str,
+			__func__);
+		nthw_fpga_rst9569_phy_ftile_rst(p_rst, 0);
+
+		nthw_os_wait_usec(10000);
+
 	} while (!success);
 
 
-- 
2.45.0

