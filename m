Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728FC02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5349B4068A;
	Wed,  5 Feb 2025 11:46:19 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 023AC40668
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:11 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2104.outbound.protection.outlook.com [104.47.11.104]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYGE+r6XDiRZ8b9qvMoTT6DY9cVgWzRbDfPGipZcNHxkwqr7AX54ksiZxRXeOMpprrpfSl2e63u6q+a3oQEiS4c6E1koKLbYdKtvdYForGZyfU9EE87eeCAyylDjXaDqrsUfAx48Hy6/usgbMLfvvLNKrB0JbQvPINqz3aPwBvE/gj80cn4iQoAt8rkWuiPVEgIKJrW+zN7cDSplL36UZgFykkDLrGEvqnkHQQU5FFh1C6uVjzCFJ0XwVZCoXSpJ2KZ5ZXS9Mej1FGn/p2Kn+SMroRgb69Fh9o50+1HXRRlQ1pj4iAmEO9Yn3BHirSneFcEqY7251Dk50Zb+PBUUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCOQ/aZofygXRXj1lf6UCpmFBmrU3Q0tsgG3PMZVrD0=;
 b=PtgBcWiBfF2zMXSYKk3/kNMwVb/I3OR+V/mfUCKizCAawcomdNB3M6Vm8uoIMahmDNRQwj29D9811H9Ss0uaH7uML451iwh6mG/IGn5eJ9cIkSJfZr6/0xHTfiQ422yUrHLiPfxRQYyDqI1viscDBt9xuNRM2W/9fgPXVjT5wLgpb/tCDC53XKQTsvQ/KSrmLzturRFsDazdaIbzMruPI6Qh2obcArqt/HXdrszvIpHjZhR8ggAgYYYo4Xrd89osJAzLg3TC6nCp3uBJq+MNLfOcuMZWPBeoHl6utHZuejx2SocwqZcBxApLfJ+BN0k2Ee4pDd2DCOGb2sjE+AA60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCOQ/aZofygXRXj1lf6UCpmFBmrU3Q0tsgG3PMZVrD0=;
 b=msIxGiIqiQRK8bZGPUqfCiP8KuVBiJa3eivxELGtTQry15B+CkrMN1eAVqVAMQvQ5SokSTJTz9VSavCOsLdS99tULjv3XOsir/J/RghPr1TgLJsHL4nlkRBVsLtSzJnnahcAWlfAU1nZ4RgX33be4m5YRLTmVugaTVwUPixSWBo=
Received: from CWLP265CA0337.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::13)
 by DB9P190MB1051.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:46:09 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::72) by CWLP265CA0337.outlook.office365.com
 (2603:10a6:401:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:09
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 15/34] net/ntnic: move null checking
Date: Wed,  5 Feb 2025 11:45:24 +0100
Message-ID: <20250205104548.1533554-16-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB9P190MB1051:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2299cf2b-59e9-41e3-66bd-08dd45d24ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CYPHAxk6As50Le6dxtR36tka0y76jdeNOwwehiLPECMlmdnNg9iAkAy+UkEE?=
 =?us-ascii?Q?Cw7fic3Ud9mvCWqV7eEfBwwAvdSZhzwv97vBQKCpUcUFN5KR0eFZl+TLhX+u?=
 =?us-ascii?Q?L4KZ8nPW9droolKnYXhYY53yFF5J4yIHRVHI9BZ7SuFSHjoGXQOrR+t8LGCD?=
 =?us-ascii?Q?elo76nQaH6r33hRjCgV36rxcM9wFvm9YzwKCDn+fxxv5+5bP2vI38xWdQ05/?=
 =?us-ascii?Q?KMpJHB++siHKpy7cy6AzqRIizeMI3QPHzBm25BeNZtBWIE19ySI5TvEJ+thM?=
 =?us-ascii?Q?JZd9bHecuNBsmhKhmmoywkuwpxGRcX5UMitxAOAp1+qm16Ec7Wb+Vkb6kLZm?=
 =?us-ascii?Q?lcjDGd6OZbaEoUWPGBlJUKO5eisn3a0/LJKVw3Sk7nPx5r2GUwqKnVhDLIay?=
 =?us-ascii?Q?ZIy6aANM85IrOsfRADZESqtFO61IlQ3HSTnLbuproxv3C8nbAmz9PJdZ5yuR?=
 =?us-ascii?Q?7XHft97TST2L+Uh2bRd7nWWUFZQ+NLFQhbVrJCZv6E893snGG4iBfqKFX8TV?=
 =?us-ascii?Q?+mwRzMWEI4dmofnzSRj23CyrDnoCIAteQo9HCece79d/aRhVXBdhVXdog0R3?=
 =?us-ascii?Q?HVdAqDKkY0FXSqc5mPrOW6jrCwzaYWyGdh0fxQQKdHC06BkOuKrwSwUz3RjK?=
 =?us-ascii?Q?4DNpFk3lMHXd3wWg8ki+UyZEnTQFXtLq/WGqR0g8NRC23bDeCtBa5FwftM4Q?=
 =?us-ascii?Q?yPqkl9oN56WAth35UB/eUtDrOJz1IWGeCwfDf+ZKEGMZlJ/g/CY+NvQt1NIG?=
 =?us-ascii?Q?8VtDIBBun8u0T3da33nKKah2Eu8LVwb+82Oe1kCL1Yfk0gc8VkaGAWW/j7in?=
 =?us-ascii?Q?s6gkmr3HcjHR4lSpilaOp50KLbjurBAmpB+RYqaXyGMzvEc9j00XQ2ePxdSu?=
 =?us-ascii?Q?wappR6xAlIGS8Ltv4yYbGhS67nqWC1lY4h1HsSdCS9w9JVEOeJDl0TSMAz3q?=
 =?us-ascii?Q?bPeqD3qpkJDqEiXNaMW44uQXTHHqhq9Wdknm2hClAFr3hVzIsoxfq+UVB07K?=
 =?us-ascii?Q?t/MJAY5m4dLeW7LmFdQEMHDBZMk+ZmYsUQEscWO541GADNe0VP7Mzt5PRJhS?=
 =?us-ascii?Q?BV57WbcV4lqNMUJ4l2Xc8AZr2dYL1dAVAGAfYoglr3rQIrkY9gjqkmGtd3UF?=
 =?us-ascii?Q?Gg+oRMZUg5EDpGRbVXm5FHSbRmnr1y1n9D15huIk4mypUvzk+SA2laCbYiYw?=
 =?us-ascii?Q?CgAFoq+7BD9bIkrkcBrna9u6UEbBjXcV7A+ucvxkmZqGtj04G+n0svjtuCBf?=
 =?us-ascii?Q?dYFnqUtTQAJjRPaxn41mWoQ1SFnIVOTrXXBWkzVGs0yl7FTuVRyEyYEevS6O?=
 =?us-ascii?Q?VKEG+RYngcEh2hlHDJ0NzXA57/MtCSE+2Weoq73B0l6QKLzqen4+nz1Ji4sx?=
 =?us-ascii?Q?AGimuUXc3BdgKYgJwIjgbtTZRGuG7kCUF8qL6ZCE+aCbKWHKQKJT/W0Xru/O?=
 =?us-ascii?Q?RVd9ut/2qZ+xRmC7S66vK+UNOOmPJDAhap5jQiJoPEV0g6R4azPinQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BhYPEdPBZ8z39DEh4aKamlcGK+THLEUKMaPsM01iAiMUf2wjepGy4OnfYg1brZWS2Y3vwzy600gsFCTIr2ZtgFmUbPzPqh8AEZtX1mpRMbyD43yQ98lLYm5lYe35R8I12WsbVT9JoY3CXe9Ib6f4d9D/ZBftZemDN9jgexmkaa5GCg4ZCKr4vt61kKa2fpSVr6ti/P5xxY+rjmoJmsJ9nBhSmhk3SlBGH3ocq5ntcFQpmzvf0xbwBF/2FgL33PYp5jiDhIUeIqy3syEhksV1ioLKuSHfcnZlWWnzeptYpe5MyHypF48GtEGuecSN+1mg8kyP3lcUfP51QbUN3+yt2EFBb8bSrmipgUQQ66tJ+qoIdRHoMPPYUKoEnjxzgs2G7L4/ytcr6SiEhQq20Qe31GnjXbyWJ33HlS4JfD2bS5PrKIAZC7g2f7Q7gdy63pf3apclfGqffbhJbuf+di6OOQHzQPv9Fe/aPcY3/8aMAXzMAseZayupDu+PH8qgsiwj5WZzVgXxoMbAYKWLGvLV3z5wArtuxVKsEbbtqPybzk675E/o7o72skr7z1RBi9svvpC/jwbELFPLhgdeTfyFksN1HOzwEWhrErDRFgeuPVtTnkARBodiIr9+hRK5ZLmzjedQcbsiUd/8Lif2sMzMVg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:09.0270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2299cf2b-59e9-41e3-66bd-08dd45d24ce2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1051
X-BESS-ID: 1738752371-302364-7587-656-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.11.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpam5kBGBlDMwMAoxTAp0TjVzC
 DJ0DIpycDAJMk8zSAt1STJ0MAo0USpNhYAzKBjOEAAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan14-171.eu-central-1a.ess.aws.cudaops.com]
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

Move null checking before using

Coverity issue: 446759
Fixes: f0fe222ea9cf ("net/ntnic: add releasing virtqueues")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index c178144d42..279a852a1c 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -510,11 +510,11 @@ static int dbs_wait_hw_queue_shutdown(struct nthw_virt_queue *vq, int rx)
 
 static int dbs_internal_release_rx_virt_queue(struct nthw_virt_queue *rxvq)
 {
-	nthw_dbs_t *p_nthw_dbs = rxvq->mp_nthw_dbs;
-
 	if (rxvq == NULL)
 		return -1;
 
+	nthw_dbs_t *p_nthw_dbs = rxvq->mp_nthw_dbs;
+
 	/* Clear UW */
 	rxvq->used_struct_phys_addr = NULL;
 
-- 
2.45.0

