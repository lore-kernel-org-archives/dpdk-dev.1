Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EDC02194
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80BA240665;
	Wed,  5 Feb 2025 11:46:20 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 7CA5A4060F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:10 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCx8f2O6obHI/bOXzL1fOgk4bfhWgwls3ZamWLQF8x2hh45kwu5dPQxg3Gc5xfiG/9NrR/XKo/5Dx7X/Jxop7LL8tdTEKy+xYg7eaPq6VaruFoGbFA+RqV5Z6JJWM+5jMGimMayJiycprltWpl3iYcxPHKDTOqjUuCUJRRCsN7GV/xZvwBCato3ieclJek7WwagYUM6SCQi1ic2rGz8OMnXt2QDJ+tNOAIwdulQQ37MqHkaE7HWczAVMHGE3+soEJDhP+TxIhMbX24P1bOYBsOcddEKJB/VnZNFxZjovXc4t2DMldCCkiunGSo1w4WP8n+PItPSlrP7G37lW3yUtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DPBLE/ulgBNa9kGWwpKE9HpQti7GT8fm2dwBMXfO6Y=;
 b=KR1lcSYcpBRfwF0BGgftae1jN7jr+g0dsk8AByESTOkYOIlMuPgNkFHJ/HlA/NzSM9A4joZhkq5D85XcSdR31Cr0oA773A+SFbv0PEPMbqWM3Tck82dQ6PRwT5lUKDCcIpheAGg33xQ6ppIGd/vm04noZbrl0EXvCCXH2QkUJtjx5skou5DEWSTZLb7zOfFFAu8VTZU8ilri+aaIfMKomUFNZX4scnbbT5nY3irQfl5Fr5fUjDZcaU4z90X42EVje7fqoQsrJTPbz25BbyFbi0LqvFo+6gE39ps1ZQaafODok/SRpTifAQ3qWBSLvzAozp1kzT0fzpPUXdj9WchkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DPBLE/ulgBNa9kGWwpKE9HpQti7GT8fm2dwBMXfO6Y=;
 b=h/K5l8U8gx5JQK7vV8t2Se9yJDGIJRSusi/XSfybNEhHa98WsIQZeh/wwr0qQrNWEXQafRYjS2FxV8XShFgH1rVb0yqduPeUoLXXzTfcdymMrgH0Nrj0GAW+ouJs5aTVZwiITBzZnsJu1XdVlgVmOheIhLOZanJyY0cYMhrxnVk=
Received: from CWLP265CA0350.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::26)
 by DU0P190MB2028.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:46:03 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::b9) by CWLP265CA0350.outlook.office365.com
 (2603:10a6:401:5a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 10:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:03
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v2 08/34] net/ntnic: add proper var freed
Date: Wed,  5 Feb 2025 11:45:17 +0100
Message-ID: <20250205104548.1533554-9-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DU0P190MB2028:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 23f4078f-d820-470b-41f2-08dd45d24951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wEvwl//0Tiu/XabF9kHPMIPBrjkC/wR3cLUkipS8mu6PtgTttgf9VEQn3mHo?=
 =?us-ascii?Q?ZRZlE/R7SI6S/JbEnh340GSP7k6gq7UYIMe9KNztFxhRal759Jjw1zHGHUO2?=
 =?us-ascii?Q?AfTAIjwLxXKM8SFXY5146JU8g1+HCbTrIOwgzlJnXCN0/sjzAR/Pde5LiIsP?=
 =?us-ascii?Q?L3q+OpkzSY+kkF+feB6I1e2f+v5kk8N07I1xG8zCRyo6k7VJMPhl3csaIRqU?=
 =?us-ascii?Q?X46vURxgTxwlpFuRhnA0MRC/1NbbshXxO13fZP9Ru2Kp3/bHIKHxFQC6feRd?=
 =?us-ascii?Q?TrwZPa+5YvU1wQkp4GCaAesm3pRDZZ1BTa10/W9jR+l95LLXYdExFhYJPuxU?=
 =?us-ascii?Q?D0ZUDhIPhmLwXLYeYV2VzJ+ZN6Ab8W4j8j3m1y/NuiMmCN18e0JXT4RizC2H?=
 =?us-ascii?Q?gZTZyJv2Z9pH8lz0TQO82qUikWovsSaAmy2gpoxEA25/aIlwpIJ3G3LYK0rt?=
 =?us-ascii?Q?t5VeKSp9RTCeUmTDngLTHvntX68lomdCP5WaHuieo3XTG412To6xsSU3M8CD?=
 =?us-ascii?Q?QCAe0qyR9wBqxAQF71HDtFSVuFhuC2/bGTUWhshMRmH7XA2UTZzaOzjYozVc?=
 =?us-ascii?Q?qJBISSLF4Osnkfbal1jUlKnPZ4rFUncxWkKgwnPuNzEwNRrKbnLR6BDfrwAx?=
 =?us-ascii?Q?RgC0WPR8V70hQ2CPg5rTKXzDVVdhm74tqvnBNcZXjuQgSB6eFg+lbIpdnCrk?=
 =?us-ascii?Q?6f/Fl2s9tysdmgWU0ZW61/7Sw3O75F7ejbt3Kx9J+ML7QnVvTyu2dMWXKxAu?=
 =?us-ascii?Q?8Fr2dMCGbj6WlW8icVe0wu0tz+3vScXmLJylVeRzPJj7TL5lG7OIIJDhMCXB?=
 =?us-ascii?Q?lQh7njliWKcZYZSLvMYMtMe6IuINUY3lIUJCmyfdLqYLkgd9EGWDO+z6uiBT?=
 =?us-ascii?Q?ye0syNjmgUuyF95fFfEuWXst6x9pzHjQG/YxRMUZNxC0sGfzUD0xISpJ2hk7?=
 =?us-ascii?Q?Vp6xKDEMjq9qIoTAyrYqsOloeFGzxSTLJj7cg+xz6pQaVNIgfsSI0xccPaZF?=
 =?us-ascii?Q?71kqQkayBzMk3iH6G4r0I67MANB0Si97ckSIm3s3+QpOrfUqpOPpJc37zcCz?=
 =?us-ascii?Q?gXf1EIMEZOxYX4y0Sv8qQJFWCG2z9rp1EnuILJxyqN46YZPb84xYji6i8cia?=
 =?us-ascii?Q?lgpEn5nFa1UIARWOcirv6BAxbEB73jJ7nsmwGfcLuzIxo+AvHrd2uYxe5Ui5?=
 =?us-ascii?Q?fLE0SkTQLUBG/sPSg7eqPgtdqboJC014bOmlVrVXgjk2BL+avROaX30x0/a4?=
 =?us-ascii?Q?u94/7LXDW+P1It00a/TxGzfQFim+Nvvs8LneszyHHONuePx828Zb2rbzQh6v?=
 =?us-ascii?Q?NUYbtBKDOBLtGA5+fj62jtMCGOpdQpLPokdKfiG4PMHVMv6JlusHRdx9IFqg?=
 =?us-ascii?Q?qDqUPECBvNid7TxTcLUzG7iR29buHc0ObXGGQG/bIFu4lyQTZpGkXlvuQsHN?=
 =?us-ascii?Q?vukEoW53dSJQ9Flajm8XtdAjCgf6girXaWa74Pi0baRaF+uOsN7M0W8CE8Xw?=
 =?us-ascii?Q?Z8KHLLkxCLfxrZ4=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kNlKdchVLwnGJYJecEG1MWn1pv7XvMhTAZ6Xq+dScppB2HyxwQpWo+zhqccNxEBs8466vyr/5I9GxeOcWme0T8LphrJbKa6ax+FxIiNjyWg9ws61XEDSsnWm2q+9M5cQDYrBpgrSv4tNgwDIbxrj9WApK7xaUny2q1RYYnSpCFWKf9nfEbYg0AABJ1FgIJtf6PYeiylFV5r+OdDvsPk4sVozbJDx/Yx2kRh2uekyzY8adBl5zPnlrDMCmj3/MGwdi/64oky3hvJx49xeTgcniUyfvFO8oOGewu+QGXu171YfLouox/n8HW2BB7csy6R4BDMmpz9sI2mtNOzOqae9lRzljtFh+H29trIAdNy5zl+74pku6EIBRXt0LEgJ4QAAE8+oMsh1RpUBD9OKNLV7uSXNC/6Z5OenRoQuSP1gA2L/s5zhu9RhE9w/zL39iUyDu8aJvt2q10+n1/bZm9MKTYgHmtivGthbCg3wLvGLXkb3sCTq7rCFDs8fAFJiyJ11du67gugivLGeDf9W9VGrNiCCyN3c/q8kzkavHwxJ2KR1QrOhMjLd2QMJTjvIxrecJ8q19l0nBKSZL7z7bVzyfqoxckOgwho2fb+N34r+D7p9vHIhlf7UWRrQKjdc018BlP3fQCfVVYmZEifms0jyEw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:03.0270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f4078f-d820-470b-41f2-08dd45d24951
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB2028
X-BESS-ID: 1738752365-302364-7587-644-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.105
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYGRkBGBlDMOM3EKC0pOcXM0N
 zM1DjFwijFPMk8NdnAMjU10SzJMEWpNhYAexpfk0AAAAA=
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

p_fpga_mgr is properly freed when it's no longer needed

CID 440546: Resource leak (RESOURCE_LEAK)
Fixes: ddf184d0b6c2 ("net/ntnic: add FPGA initialization")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/core/nthw_fpga.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index ca69a9d5b1..88641145ec 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -230,6 +230,8 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 		if (p_fpga == NULL) {
 			NT_LOG(ERR, NTHW, "%s: Unsupported FPGA: %s (%08X)", p_adapter_id_str,
 				s_fpga_prod_ver_rev_str, p_fpga_info->n_fpga_build_time);
+			nthw_fpga_mgr_delete(p_fpga_mgr);
+			p_fpga_mgr = NULL;
 			return -1;
 		}
 
-- 
2.45.0

