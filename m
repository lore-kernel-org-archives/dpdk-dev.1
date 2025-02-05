Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65339C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D00840E0F;
	Wed,  5 Feb 2025 11:46:40 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 9628440A6C
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:28 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2174.outbound.protection.outlook.com [104.47.51.174]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lK3yQk0+XaAZ5uPAq69xWO6if92tfgPfF9Z5qUl8+YRbyS3zBBO4B2Yt9oG57u1OCXmME5C1Aq+pUCi2u7kpvnRvK2fW1i3+4rapr6tVd8QMpI/7Ry9Xr9lA/N/3sqao2AkKBKENi3ihQ4/Y2/3oSP3q2B6t0qeg2LTEfzCqCOD8F3cYgkDkGhZJZAv2S89j40hHq++kcnDNRBWwPOy/hTGD1js3RFSkKhA2ztUOYOLX6DLy6/9xTO1U4rsSqIW8AHLFhLb/OD9wqMf/jwMNP37vN77LB7023wwYgMSlfsP176vl7/1Pc8/7tbdpeHDRMeVlOp0ASv4Y+yHJiv/puA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlBUzR/DMKNvuSvDqFx4bgWM0Sb0DSVMUj+OSjokHCQ=;
 b=QaOO5O/67S4aTRtD+2UabNuGK+Hs2WXNnvxj0xUO2A3cgCMXZixHm7rjlkMwO57Shryp/qPShGvjfb/4Yp9+8Cr687LoZxQ61qMOqDAEtbgngmspkL0VFnmz0SSkIWGaBvhsXHbdsFKrZgRi+f1+vq0Lz8x/dhSmRvHOizyrKW4jf3e72TNhKnXEibXnICWv8fX6EP06oRl17c3uFqxE08stPVq+OrF+QBRnPZuygB27BK3oYlioIjWvrgA+QrAQ5qcshyIvf26b8ZZW+DG0/+3kVgopLKN2vLXO4rsiU1KtxCgzzcR84sPhFUcDV7WYPQ32/cZy1Rb3pS0QsMGIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlBUzR/DMKNvuSvDqFx4bgWM0Sb0DSVMUj+OSjokHCQ=;
 b=Ywe7R6auqkW2dpGq4OypX6OFGOLAy4q9+qj+COdM/JsliREeEnCFpatuQjOWISRsCIHoFNqJ5D2VpXKqkNUKDRKWYKPwyGly8HFjb9W6cj/czsL4LLgkvqM/otLQwc7vWsx8r6VpnI4nvlPVouKQTEkYzNJ2oLg8QnBTb37kXJg=
Received: from CWLP265CA0360.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::36)
 by VI0P190MB2046.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 10:46:24 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::f6) by CWLP265CA0360.outlook.office365.com
 (2603:10a6:401:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 10:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:23
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 30/34] net/ntnic: refactoring of the FPGA initialization
Date: Wed,  5 Feb 2025 11:45:39 +0100
Message-ID: <20250205104548.1533554-31-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|VI0P190MB2046:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3eed3f4e-80bb-4b5b-4f21-08dd45d25589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nBJykv1eLzScgzg+RFHNtbsZCPE5O5F79mcCgSNi7P8S6xbeHjPl0vjx1LRf?=
 =?us-ascii?Q?l9MlcK5nqZaF1R9tURR2dk2tI7tuJxCEw54hlejBCLCHVFCDUs1ocFiM7HtG?=
 =?us-ascii?Q?I5yzomMVuiuNd49203lenV4Nq0HLyGfk6z2nGqE2eTvQMqkZS4eqjeBPKltb?=
 =?us-ascii?Q?wGBF49+34zHP3wyHicainbFx3tIuxbdOPxHYxpTzLkUPihmo4ywemN8ucXAj?=
 =?us-ascii?Q?jyYqC60nwjVWLY7QIc6AOb4USBO9Tliima77FsjDi61x4db9cDOA5hlaWOYI?=
 =?us-ascii?Q?icphC5xE+MakuemGVM4GT7XX24TMTqoEIJn+4FghHzccuKI9jVBp18/wLHdp?=
 =?us-ascii?Q?73l1AuqiSdeaH8iL2+sYXOiP2AX6fR5uQl1qRTDr/k+KLszOs+cUaTtcy9dU?=
 =?us-ascii?Q?e7MrJwjIYR5EwmQMuG8WsZoxYJ4naR2N6VvG8YzfVy77BMQBzAdnQbYeiMbc?=
 =?us-ascii?Q?3sPqvR6BEmnXMiCECTXH4PIfGu1BJG02rm406VeC/3bcj6irQFbpkIkUSr8u?=
 =?us-ascii?Q?TUmAK7i++JgdCEUHKwLHbRV6O6txfFzATZZ2J11EY6HjAl2y7KiO1wPNgJwd?=
 =?us-ascii?Q?GHr3xehiUmj9pbT4FphUkYm/chmzPN1jw3rJ89+3wGWhv5MKECJjyfFW26cA?=
 =?us-ascii?Q?5q9AgJV37QhAR8lpO6XWeUGCKHnNZwkNaNtrj8O4Hrj4jh4uGVftzjHrP+yW?=
 =?us-ascii?Q?WbQOEO73rYeC2okfxYeehgOo6ymwqJD+8nhVmnkf8oa4qAqyry9HA3/XXgiJ?=
 =?us-ascii?Q?CeuGB2j1YWQXUcvriCaFR4m9HTAYqX/lMm9DkQi2zXpXqQasq1AG4r60nDO1?=
 =?us-ascii?Q?C+rfF68zVEaLH42Ghf+9r+mXNFtA0uP1qiN7fIbQ03A83D4tZSNtVGgKy+w5?=
 =?us-ascii?Q?e2aR5dp0o0rOhXVF8xgoaDzpAK3k6SttsAt+CNGWuo9fG1Eh9BgtXDzSqUh2?=
 =?us-ascii?Q?Z1oM3tXO3B2pGRkz/0tjqgufqsoxzO+bkv9jYwFkz/c6yY+GfdnMeL4Kvnb0?=
 =?us-ascii?Q?52qn0AcPuSPoc/pBUGRsGH2GC1tQG+/rkDdmlGNUYWb/Cuuq6E7buTaNb37F?=
 =?us-ascii?Q?FMaChB92dGllxMclsCdWsC6q3Anftej+AASKkTWU7XJOxGf0yoSc/Xk8hMpu?=
 =?us-ascii?Q?0CMtu+uvg7EMTatxqc8le4Q//yA/ER0dM8+bF4YvuxH/w9EligLc1vgZ/xNh?=
 =?us-ascii?Q?G+yloO5OPI+3s9vwxeA5UxQcHZjGabh6UAzyE8zv/xGwpAwkkRdZ5acTnsIj?=
 =?us-ascii?Q?Z3p4VmVSDg/wYdpr/As/3Au99VwuIWpWlaAUCYnzME8OovgIhq9GFw6C/fWr?=
 =?us-ascii?Q?zg0UJGF/YdQWeDe2xogPBcOLJIc5eRIPssBn2KE9pye0ppwbugnxJprucQUY?=
 =?us-ascii?Q?uCUSYn+NJ7km9ZuSIPwYezMY9mpmMbyTqGqyPwGjShlVG3a/UkFWt9u+buzz?=
 =?us-ascii?Q?MnLsN67xzmudugS8SBP6s2V9qfEqYhicWf74dKtC7gnwUQ3fQHiBlD4EOOVP?=
 =?us-ascii?Q?eyvuYQ746kWckds=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9J60hEpE+9p4JFfkOplL1TCoAyRJmWe9NXRxpNi3wGvrzgdAh8tc7ak9xoD9QsBNofFjY7UIgptzqIP5a6CBGvNgMPTUceJgST5nR+c313yDvkkG3qmBz+FU5qNyBmQL81J56uOYi1eaF+4AuGHApkQ4blxvht7PobGnkS4Rg0jZI7yi7pdGt3Hh/Tk2ra/naTkUh6gjMXlBf5tXhyRQAOlc+IcZ1fuuzy1gpyy4F9gcB8ryMuLFadd6E+2utR1ykSeFYNfbBurdB5mkG0gJsvMAEf+X3WpW4c+zbcX9OuXS7IqiQkRDgFbk2CK9v6szEgnoaB5jrbyfcsUByPjy3ESNDMtzkOthyk++Pa/QTS6zZ5duekUCUf1hSToA5z1BMYob7dLWXg+ohXBwfcGpMDojk11u3a0CMBmS1uKulCtrYxxulIwMc7bfLCkVAm73PPqx8A/3LKMiLyZieYv8i4+81gejTbXUhAVSgmMmQmADTRN3Qp4tYhJq+rWp1FMzKZcUvcCRjcfRXGIGe4JyrGAD6d4ObJxsflAYd8iglkTkaSJVq24CdftAMcRNle73V4AjbO5fAU0AHM88hKRR+4v5GjYj2Vj2kwgAd2C2XwtdVkPx8QYI3uxubsQpLuN4sp0Tzze6r5EARt95AVeeBg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:23.5739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed3f4e-80bb-4b5b-4f21-08dd45d25589
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2046
X-BESS-ID: 1738752387-311016-7905-653-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.51.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobGJmZAVgZQMC0xxdAizSw52c
 jQyCAxLdU4Oc3S1NTYMtEwJdXSxNJCqTYWAHxAtF1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan14-159.eu-central-1a.ess.aws.cudaops.com]
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

Remove unnecessary checks and logs.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/nthw/core/nthw_fpga.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 88641145ec..5ca186209a 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -265,18 +265,14 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 	nthw_rac_rab_flush(p_nthw_rac);
 	p_fpga_info->mp_nthw_rac = p_nthw_rac;
 
-	bool included = true;
 	struct nt200a0x_ops *nt200a0x_ops = get_nt200a0x_ops();
 
 	switch (p_fpga_info->n_nthw_adapter_id) {
 	case NT_HW_ADAPTER_ID_NT200A02:
 		if (nt200a0x_ops != NULL)
 			res = nt200a0x_ops->nthw_fpga_nt200a0x_init(p_fpga_info);
-
-		else
-			included = false;
-
 		break;
+
 	default:
 		NT_LOG(ERR, NTHW, "%s: Unsupported HW product id: %d", p_adapter_id_str,
 			p_fpga_info->n_nthw_adapter_id);
@@ -284,12 +280,6 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 		break;
 	}
 
-	if (!included) {
-		NT_LOG(ERR, NTHW, "%s: NOT INCLUDED HW product: %d", p_adapter_id_str,
-			p_fpga_info->n_nthw_adapter_id);
-		res = -1;
-	}
-
 	if (res) {
 		NT_LOG(ERR, NTHW, "%s: status: 0x%08X", p_adapter_id_str, res);
 		return res;
-- 
2.45.0

