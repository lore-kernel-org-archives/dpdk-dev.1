Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F388BC02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7A8140B97;
	Wed,  5 Feb 2025 11:46:30 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id F3A0D40689
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:18 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYpNqTM9GOzEPFn2KCaKKTYenckQeF6zgx3q8sLCSV29GmGLYJ2xMf72lo64LcjeGQ6DqbLdlIoeKoKeQXJ9ikn5Ahga8N2+mrI/arqRAzVr+MCgRiS8oJZQZf9VPnJShrlkX/kTAZiulXL3JT1yG1QAm10so0kEPK0Ea1GQd3T5Ej48nHG7C4lhDNgCEHyZkV/15DhoMmnq1GGpjPQaFgZpH2m+/4cme8aDfnow967yXrdqaRRGRxuRzVKKeUfsNeKOnpBvCebAFevG2bjVwAUc0qHgmd+Em293C6Toz9w0Homx28UXoNrLmNK8DRpOTPP2GXqXyoLvyBKvfOIBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7SnjMMIz4ZZUg1jwORWTo/4rhuC599yEsBp0fF9f64=;
 b=SVPkhBYupVIWU6YwawnhMCL+BemzlH0aGsihfnsXabeVcSOpVlK1R0lZyi4JkG50rDgZBL3HmUKPKoKuEIUPTACRWRHR7t6RYieCeDxNY4jELOx3ZRldaxiqBTO2qmmzwKfDVG6NsooxDgjdbDntI0R/L0fmUue4+fWPGl5XzlVNm3t1T9mBoeAl4joHnuNyse9dCZ2ElAw/M3C9A98s3Ji85CaBMClW2ZSiepCdm3duQh18/ZmodCWLmZIIuyvcZKYvh8yErGi5vUecg86leoWSKDfjjylDGDcep+QqKOEJx3mfP9ElDfzTH0R8LDZuV695ZAo5CRmCNOk0z6nSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7SnjMMIz4ZZUg1jwORWTo/4rhuC599yEsBp0fF9f64=;
 b=VkLcarDfUdxkMBPT9koParMNGr4Z0qCscvgs1099gKqU7m+nqBYD5c4ViVN2ReaUDbYRd1nFcgUcTKCzOabygBMaTY5GCcTTeffvJh4LBLgBjEIX2qrBuNkRBOQQFQDbebWg6Nxh0vTTgogfyTufYqHqENavu1c87PeJ5I7P0gI=
Received: from CWLP265CA0340.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::16)
 by PA4P190MB1088.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 10:46:16 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::ea) by CWLP265CA0340.outlook.office365.com
 (2603:10a6:401:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:15
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Oleksandr Kolomeiets <okl-plv@napatech.com>
Subject: [PATCH v2 22/34] net/ntnic: remove extra address-of operator
Date: Wed,  5 Feb 2025 11:45:31 +0100
Message-ID: <20250205104548.1533554-23-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PA4P190MB1088:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e44aa851-1c71-4c19-362d-08dd45d25100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zAHwi9F7ZAHVTbOIVn06YjyjRCv1uUJDlj9MSyCBuC7XEM5kVibXYu5/kcGx?=
 =?us-ascii?Q?QWMNhkTQ1N0Cf3E2m6Ll+emiYiRQXIorqqJXezodF973zk7087FdneT3CsA1?=
 =?us-ascii?Q?VfoRH9gW5jMivbISSsCmEku2JGYlj8//jgZgFXCaosVkd9IQkXzKvYMyFyYd?=
 =?us-ascii?Q?j6N81XJuzO+IDtcEsazHo/36mZmxQCB3/N6a3YYcRa88fxkZ59hRtMT1xOpY?=
 =?us-ascii?Q?qU2kJfOw6sHEnMFcbOOyc3GG5fOAjHhcxJC59Yh8xd+J3Z9nzCO7yfYJTvnN?=
 =?us-ascii?Q?AxjFKbp5NI96i7Y6pjBlw/KOiF3LynmcNN4UYxANdbfJyLaY5Xecxx13McBB?=
 =?us-ascii?Q?OEuR40E3k5fm+C8sUqitEXBqNptqieD5/fxUIuh+ercgCMvhZTEE5jFkf8gd?=
 =?us-ascii?Q?eCCvC0c18YTyLwiQqIubh7s54hDAHRKx/FTBOW1av4KbI2ofxghtoGxF3pkB?=
 =?us-ascii?Q?0PI6cLVh14vEWygSCNhfQ/BdFlL1yHL/FZ8Ang58ZyhqvMMOOJQb+sWUFJ+V?=
 =?us-ascii?Q?AqAoLWElhkRAHT30xfbXtJlySMVAngH8B71IfpEDCfcD1z+kru//2srGhQIh?=
 =?us-ascii?Q?E1F6wZ+njwWlPXn90pTgjKgqN1im53a7HP/lCxjMWrBnMP4yrCJ4A4SmUpDk?=
 =?us-ascii?Q?jDY2p4VSldSZ9uRaGmZtbF8bHmaiSgDiU5C6BpyNNEKj2dvkf9hIRXQJ7Ziu?=
 =?us-ascii?Q?px8hvgiDzax7YpPYdACAY0nALxiywhVtnVBtI0cBxPe9OuU7QzRGawv3d6LP?=
 =?us-ascii?Q?l4g/JT4PdsBsh3y4AQ+WUgS4TlPF6PiXCIMxSE68cb/bQqeMqqnkTop3QkUZ?=
 =?us-ascii?Q?HotVs7hVWI2+sm6kBWJKgk07f+o06aMQvhD9+LBnqO7jfpw+yl2BqE1LUqkp?=
 =?us-ascii?Q?5VFjxqQ2oQHtgTXYJ4IHODvBtpzk88dZOE2KRNnBHz9coMqvmiJ5fphIHBJF?=
 =?us-ascii?Q?53yJ5yXSnmmoYlOLsf8T+t6YXZi0vPADJMxb0S3JSYva5m0KBGkGTX+3mwt4?=
 =?us-ascii?Q?7qzv2/gOAHfehBq6+drMjsq3GHQkkGTfx5u0LckMXCTki1fLgzpIbAIZOu6o?=
 =?us-ascii?Q?7KCwvMrlWvwNdrnz3ixu082FxT8ikjD65o8DcvkFEb+xNMsSTAQL4/S6dCpz?=
 =?us-ascii?Q?cx6uJ7a8DEGitd7bSGs1NBHRmeL79P79Oh84tgj6N4R9w+80X0VWYnP33m5L?=
 =?us-ascii?Q?4PwoVTxAmHXRX6D1ChQXJiRrkcQ604opHpYY5NJrNdek4clmUGSIEikblTNE?=
 =?us-ascii?Q?IKuzUxhhG2gQadF0/lwGfnnzgqt1I2BgaTEAt26q74IOnxbhBMvOMuCAix0w?=
 =?us-ascii?Q?nuWIHH080k8EXDtrYVAzpPPvysr+Jgwfl0jiuKb6FGg9RGPRki9zzf0U0o6c?=
 =?us-ascii?Q?D+ojdxSP8W5XeZvbfh9hEZSCE8MmyKm0DcKXQgIIri5Pfz9fFd+gfAVvnE8o?=
 =?us-ascii?Q?72hDkbV5v4Vxp30wIT8B+Oj4dHzq2u85cNoULh+D6a414XCqpTmrWLy47na2?=
 =?us-ascii?Q?ZIu2dwWCGYgPvdk=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p3N6x0dp51yIac6w52i7DYz7xTrB52arVYP8sOjtKXjMke1BGwjuBYy/XSD9gHdR/szRvWeMzDJ+7aeRTPo/GldXATFjIRWe/n277ZpZT4Box0NEQJXThssg4RFl2rlIuDIW7cfGI98cwj6yPjZ7STVPyoKQMPj8h5X3Q9tr+Ch7IV9I6tJvRlUjqMUQcBRd/6+sgF4iwK9V/FzV8g4APbv/0dwjPUsRw8nyQlxDYxVs/KcJ7ZDWOf8mgiL5jdbIDkfd6c+BThY+qGEsco1kKM806j8KxZ8CjpPwQ68fZ+rQ4vsVzhP2lEMBkFpQNy+t2Zcmt7QIwqvqV3oA3tuJjJZequFmsjUD5c3TCwIgzacIscO8MuOFLIpWGsL5JNImJcHz2T6pFH/+xkjiK3mMIkrMLnERr0acwghsUGQE5wDV+umdIIp0NAySxCc1Xi33ff0eMt70HHDodVkx0+AHJZnb50MfumndQU6XzxHNQBtsFFb4NVdNhZ2XJCatUVplmxsvTV+G4h+qrwxMipvvZTdcFveafBBAK+K1J1kP/Ve1QhCrUSQjB9lsP+95RwxGfFy9mE8uBBP3SKdHVk3ME09nnUYFkGCKQRcr6hfQXTKsRyax0DeM6kw5BtpWcs2Ah0vnTZplmYl+0bRPAaJVmQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:15.9489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44aa851-1c71-4c19-362d-08dd45d25100
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1088
X-BESS-ID: 1738752377-311016-7902-636-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmRoZAVgZQ0CzZ2DLNJDXVON
 kgMSnJ3NIkLTHV2MLSwCDVwtzUwMhAqTYWALSkCZpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan13-199.eu-central-1a.ess.aws.cudaops.com]
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

From: Oleksandr Kolomeiets <okl-plv@napatech.com>

Macro DO_COMPARE_INDEXS expects pointer to array.
If condition is true, one of array's elements get overwritten.
Misinterpreting pointer to pointer as pointer to array
may result in out-of-bounds access.

Coverity issue: 448966, 448970, 448971, 448972
Fixes: 6e8b7f11205f ("net/ntnic: add categorizer (CAT) FPGA module")

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/include/hw_mod_backend.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/include/hw_mod_backend.h b/drivers/net/ntnic/include/hw_mod_backend.h
index 544962751a..1941692ddf 100644
--- a/drivers/net/ntnic/include/hw_mod_backend.h
+++ b/drivers/net/ntnic/include/hw_mod_backend.h
@@ -111,7 +111,7 @@ enum {
 
 #define DO_COMPARE_INDEXS(be_module_reg, type, idx, cmp_idx)                                      \
 	do {                                                                                      \
-		typeof(be_module_reg) *temp_be_module = &(be_module_reg);                     \
+		typeof(be_module_reg) temp_be_module = (be_module_reg);                     \
 		typeof(idx) tmp_idx = (idx);                                                  \
 		typeof(cmp_idx) tmp_cmp_idx = (cmp_idx);                                      \
 		if ((unsigned int)(tmp_idx) != (unsigned int)(tmp_cmp_idx))                     \
-- 
2.45.0

