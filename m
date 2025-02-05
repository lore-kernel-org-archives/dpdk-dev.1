Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F2C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AABA240C35;
	Wed,  5 Feb 2025 11:46:33 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id CD95640696
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:20 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrnDvsc/jKK+aa52HfPxGyOzod8dWpKKeKpK1UfQQxWuGX4ns9Pc6xO1arakuCiVUYacn8O282IUXBgXiHR+PlRPNfOSZE6WyR7seADzLICQedh5uf6d6tdnWulRQxm2uKkkK0nSFMGMffLPyiM4H7W5jF1a7YXZpEb7D1lM0U5TfCovw4OvFONNUaTmRs4ZmpnEJxcB+wcxiNPI/MG8PUhP2j94KUtlZJYsUf5vUXjVzvNUAlm0KONMBhO/rH0nTgiLx9KtvTRic6GCzjVZFOsuk2sIaNePXjn4gmCN3cQuu1Lar+XUtRQhP6d+nvGAUrNvAoEMIdzQWV/9ojTwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYyL9R9sPGygpa/NxvqSe6oWl71KcHilqvSMrjye0rg=;
 b=jHq5dq6QryoSF30WF4QQ3IKLjNIapH/gbmvidUkOGDzBlfYr+r55wiwLEkKkmPFNGSThYlS4m31ZTY0S2qcfYJKMXI7e6HpwJoDKc5ARxRNJHfbyWJtzfd0IAP2jjht2qRu8nvjg97YJlKXN+SY2ApZ2wrZGBtdo9Cthd+kxVGeyRY0lvO4VTxZZ6A4fXEmN/eZFpalgmPSwL4HyrX8PaLcBoLGQlE/3ocV372XuRcPWLVnkX3ewaIYyg/YV/pzShF7pYvIit7PU5IJ2ubvHtTHlbe50NEnIkBud12TEEMn1csb24o+bGeDeKQSm7tiPs2adgJ13rK9S0NFzSmFO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYyL9R9sPGygpa/NxvqSe6oWl71KcHilqvSMrjye0rg=;
 b=RjdoDLZnkMoXC9i/ZSlvEeXBcp7fSVcfadClYvT0e6IWUMpfgpPc8chWmCWDceqXFS4o0fFsmUcA1Aso3ZILvuV9dPvMjTKsxVLaRnBwpqnm8FDdc6vUNbpzWxpMnITxLrIK02l0Bk8CmzrvYFUnmkh+I6V+jWGSfpk5l70GvNw=
Received: from CWLP265CA0337.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::13)
 by DU0P190MB1978.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 10:46:18 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::ba) by CWLP265CA0337.outlook.office365.com
 (2603:10a6:401:5a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:17
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 24/34] net/ntnic: remove unused code
Date: Wed,  5 Feb 2025 11:45:33 +0100
Message-ID: <20250205104548.1533554-25-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DU0P190MB1978:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 020c9c1f-f27e-4994-d9d9-08dd45d25227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CBQ4mGwj01Iy2k9nc4WTHOzDZ5MFguwC9QBtpkmNLqjdHQGGncPuJ14Bkaz0?=
 =?us-ascii?Q?ZEu0lLkbyXKqMhE5ZODMFNrfTPAexq8EwQfOQ97jiRFyCWZL07qudxSrcSGu?=
 =?us-ascii?Q?jPyUmSIjJxLRm45vy8M98m1dW712ltZsZ5sPZXUIJ3z8XjBB00XCC4w9Mokf?=
 =?us-ascii?Q?mCKMYAB8xvvb2TNKfjwmAwot/3oJOWSAUiz4rucIZJukSKK9VdPin7c8wa3O?=
 =?us-ascii?Q?pEbDFHvjhAQKUE7XO05YUcv7NQiET2nJgD6G0aiK9tkTTnpSJaH9NtFX3OKQ?=
 =?us-ascii?Q?go5QnbbezJftTTxLXKWkVc5L7x1/C5z9aP8i4SI2PRSLx73xzeVUOZrtHgMl?=
 =?us-ascii?Q?vnezVW40NRLLCgvaPhHBjcXytOxs8sZckF8ePv4UyMsTArFtexK+vdyQHWtK?=
 =?us-ascii?Q?UQiCcRNevby3xivWE1KEwYMf084bN6TGBo4Vx9+IasQPEa8xEMYzagXMmya5?=
 =?us-ascii?Q?Wwhv+zXkOx/j+qnmPbwXMBOmhSPSNebpwJjedVf5dbb4Ni0+DCRN2cH65Opp?=
 =?us-ascii?Q?S8eEDrGvBLYjgJsJkBdvDOtbKcxeFBs3tbyKMQPyNYrethkOrejkfMUObTXp?=
 =?us-ascii?Q?6j05oBvdb9jtkPdeOLQloGOpTbPb/63evWaWjw/ANuA4muoTwYg98btAoK4i?=
 =?us-ascii?Q?FDAsTcnIY376diCdD233FUfcogEKYvRmOVkvXo9L9HvkTOLqHbAsXUBrg8lw?=
 =?us-ascii?Q?w0OrBW+iofADgxXW5UOQRLfrvYklq+ml9E/nSu741kvtQrXAivh+Lx8ab1YS?=
 =?us-ascii?Q?B9FALypEIkrpefQzaTctRBLfuNdKvGlk8RYx8O7bD3K0A2Xpd0AHAkuZplTE?=
 =?us-ascii?Q?0Ygsg6ywAdGPTkogjOzq6aH8TnfjqSZ0j7tXDmn1Dfs5dAAeJ90pL0ADmUjX?=
 =?us-ascii?Q?iwmHYD4gP6FC0G55ZzvAamt6QTvSYuMNsJCiu/doe312hqA0y5S8PlR+D8Ng?=
 =?us-ascii?Q?dM2BdjzqeN2DDHzlPnCE352LFAlmdEnU+OBHWII7UWRRWa/F/qVl+5jQYEyK?=
 =?us-ascii?Q?TTBy6UNIsZi5qBHVwP9p/U5UDmV7ZAXYTlIZZAjn4fBt4LEF2iJNiWbk6ijR?=
 =?us-ascii?Q?bqZQOzv5QdHktWA7b/KVNvxVol2Qb2MbV4wzO6e6qpIo28tU6iSyoRsh1kBG?=
 =?us-ascii?Q?bDWTeqYejmsIx6PtS21e0B3RLN9ucdrKE2bBsWM3PuyZ+ew6aX6/hQvJIKfX?=
 =?us-ascii?Q?zcZ9oFU8JGNZgcglRhiXNtlqXDB4Z71DCZMqjDNM84QffeG+0sPK5WEEILn2?=
 =?us-ascii?Q?5wkh/8adLzPD4poPF9oSL5mMHqoA6/5IKmKhnrNpOEZW5tgiis86VlF8JYzP?=
 =?us-ascii?Q?lOVz6sRzF4KT+OWH3f5RYZNkYjZW8MW9ck5RgUORWWywnPBCMZ70+sCjDExd?=
 =?us-ascii?Q?wKbgSZKGTI0CNIbPMOoIISleLqiNrGxMWlcwM+bpyjnEbXpU6SlO3WbNDDTN?=
 =?us-ascii?Q?KXIdF2k9etg9aepr5C5W71EZz/ZQNnH4Vf0JjSVTK0KikIHreynZf+CO4RUJ?=
 =?us-ascii?Q?Zo/UUxIlI9twVCQ=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wTqI2gXJ4AVeGHdC09pcqxvrJoPkrSA3bRZImmxyfeG9RC34Vbo6/7laxqwZFtBcR1ZIfpi5ADgn1/dfNkMg9wyuwLK5xkUoqrhEzGkdgGoc6MgZ8+I/n17iwlPAAlGkU2/edup8VnKorhMfL+9xIvvmx8g3WFuZfUHGwmMSg7wo5k6ZATtCkbmYVNUcWz3S4L+1U9mOk7kZU6Cj8SAc30X47pkdnJM7rWMKfhoBb4ldrTx7yUpx4aWaHL2OlgZMQO+3x0aNTe10OJZULgORX4lMGp7vCI5c+leZKNR+pRxvTzNcSingSCpar7//k0FGC+etNHDA3ajsis7f3kiWr1fxHJWw8AD7dSgE/bRwCJoI1cjNLTjEiLzviHobtwOjgfioioWLuppa31pz3r4ZzySm5ZxyJOMCX4lVulHTr1J7VYOkb7LeGY8Gmuru//NKjz2QlfXSSFiYtfr7SjxDNlBdprCAUaUAEZGZNQz6fFvhDrBSprKniPET2GLUBPfYZjzUrjj9tSahTG7msl7aSUXIDi5ZtHsTxvsP8GkREq6Z+npjvD9XIh9kIj61oEnEhSYhG2bwZwqjdpEmsws5BkTtXhc6SMadxwTM9yBjF8beB8/8agVTNWg4j8tQJ0nCC9rCILdKfDFC+rDj24sRdw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:17.8708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020c9c1f-f27e-4994-d9d9-08dd45d25227
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1978
X-BESS-ID: 1738752379-302364-7586-672-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.18.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGJgZAVgZQ0NQkOSXFwtjS0M
 IsydLAPM0kyTjZMtEsJc0ozdjCMslcqTYWAJIM21lBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan16-182.eu-central-1b.ess.aws.cudaops.com]
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

NTNIC currently cupport only 100G link.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index 8fedfdcd04..2add43639a 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -215,16 +215,7 @@ static int nt4ga_stat_setup(struct adapter_info_s *p_adapter_info)
 		return -1;
 	}
 
-#ifdef NIM_TRIGGER
-	uint64_t max_bps_speed = nt_get_max_link_speed(p_adapter_info->nt4ga_link.speed_capa);
-
-	if (max_bps_speed == 0)
-		max_bps_speed = DEFAULT_MAX_BPS_SPEED;
-
-#else
 	uint64_t max_bps_speed = DEFAULT_MAX_BPS_SPEED;
-	NT_LOG(ERR, NTNIC, "NIM module not included");
-#endif
 
 	for (int p = 0; p < NUM_ADAPTER_PORTS_MAX; p++) {
 		p_nt4ga_stat->mp_port_load[p].rx_bps_max = max_bps_speed;
-- 
2.45.0

