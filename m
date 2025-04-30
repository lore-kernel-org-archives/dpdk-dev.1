Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7ECC369D9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ABAB40DD7;
	Wed, 30 Apr 2025 15:49:42 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id B224240670
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:29 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2170.outbound.protection.outlook.com [104.47.51.170]) by
 mx-outbound23-207.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRS+yO0g1CWe8+48KQj+SyBSZEVk5HgkT8aUxyS7AbahPzKvpjWNdJbgSluLTPO9i+OSrMPo/Kd3jFoMa8kb60J+f3G2tzRdAJQDyF9OIRInyfufxJA4a1azujUj03rGVxWkRFxpo/DKIT6V3r8Lsh5WVYOuwD2tYMa30TqgPiRlrnd4GMKkBW60M5wUiICrFsgpct1gtcTvW603HNB3hehSn0fN5d+0ZKKn6Qr57NgLVJqsWn7ygEL3/18IsJ0J+5lvgwFtUDgcc5/GF8Uy2d8wFvZg7Zbhm9Cjc0PAB7Y+mOx6nxrwbJs+f3vnWRDvYcs1AGEpavbO1qf6Syp7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niXypSKVv30+xWZezI/Wbm6yE0uf3ctTMNrjf5SY3YE=;
 b=cbaM1pqQjjYH1Z9rzsmF3pLHH4s9qtkGjncPKgu2P4wNQ9WsDoPd70v9AUSEjk9UKTOPqlkZqYELf5C1ZF7Zqs86oXqxR6lXVoaX7xtWD08efb82a7iC0NyTg5bl0Mk/6WdAwLaLu8SOVGgbA0kHqmVzgXAyORuRtx3oPlF6kbBXtlgFy7gnCsvx2fR+dBRKqORytnQN7VPVFDZJHQBgViBNE951LkE5qzuekAvCjEVfQNXIG3q2mKa5KF7tHKaQ5wriBGofD8jYvmphsZmMuoGuVUMyJ96BOCO4WMm2BDqNNnonNz9X7Oij+SPTxqfj+eUnt0+8UcD2au7KYlmoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niXypSKVv30+xWZezI/Wbm6yE0uf3ctTMNrjf5SY3YE=;
 b=RzYtGx5Xq5salPB6voWMmMLWyPFp1RNMFie1lnqGti5jQPEnSqm7NfIaLZFav5vvx2uxD+XuJVhrzA+ADCVeZkdwEnzwKHfMdp0zPQ8u86UfxQ9hV+6gkEl8EfmnhNUI6pxdeIs2g0l+37SwJ5Jcn6yPkA0JepUcsBRNbX9Shkc=
Received: from AM9P193CA0003.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::8)
 by AM9P190MB1202.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:261::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 13:49:25 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::2b) by AM9P193CA0003.outlook.office365.com
 (2603:10a6:20b:21e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 13:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:24 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 24/25] net/ntnic: avoid possible deadlock
Date: Wed, 30 Apr 2025 15:48:36 +0200
Message-ID: <20250430134840.402553-25-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM9P190MB1202:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d7c27243-9b52-4db0-9634-08dd87edd19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NU4DdUemQpWO09p9+HN3inm/9Oz4XjQSPM8Yxkk+6bcybjCUvJMg0J+0OxZz?=
 =?us-ascii?Q?TGMhlm/jj3mUwxA47pW7eWEadesMgr2qpic0v1zgAN1VNZ9OLz9kxbavTnHI?=
 =?us-ascii?Q?/HM8G9auAW6+Cqlf/lqnq4Tvaz2NEk/xwDm0aYcj4O2zaZSUUspdFiA2fvYe?=
 =?us-ascii?Q?YG9HMB2GxwCdZczcQ3lfYqOqWOK1lUuIMfjMcr+sfmY6mLLqe3DggSquZyGj?=
 =?us-ascii?Q?mEpi4spPRZ7O4TLPLGlQWV/KVqdqhraOjHLv1MRVlBxPHaEB6j3IMIlJtJFK?=
 =?us-ascii?Q?iLKqmX78eAL2FQy30foO4z/c8QZJJTW3dpw9kT+jJdEARFJ8Loeime/pzHHR?=
 =?us-ascii?Q?0PZdqUWhOnKg+Bk0xTDbvI5SKtmXNofFeY7cupP8ccraYt2KNWVDjpwIh6S5?=
 =?us-ascii?Q?Jf0NkF2qrd8K48c/DEmdY3cT9AWtWFu8Dcs/40M5uPT+I5cZvSRmR3xN4UPS?=
 =?us-ascii?Q?UOlabZJ2VLj4OYHs5CzAtAboW5O8izXWD7RZEroz6NHNWh1iRgwBhllik3n6?=
 =?us-ascii?Q?NlXK8mEcshvIgtzpLhCRExINjaTEA55tLwB9PN8npQric54RRnYEpzDVWLR0?=
 =?us-ascii?Q?s3BJzKO9jdfarPjUNSObk85LKjpskygWJfn8g8BoQkOGChpcW74IAmio4VXR?=
 =?us-ascii?Q?eE6ot0JyMj/0KsTE442pMHgMDSxRyWVdr67CMDTyFpX2xoP9n4Du8q5wO1s6?=
 =?us-ascii?Q?56uhq8bKsq6+Vrm51IeqnwZpjkdwHywFJx/ieLrryQJUOMCrHfGBYue6vkg3?=
 =?us-ascii?Q?0/kQ1C4mQ50cw9joqtFRR4BXcBZr+yTWiwv4EGEZGUCR7t/t3nQJLZ6WhQpZ?=
 =?us-ascii?Q?HpTnmynhw+c5NOwg4Z6Ntn7R7tOfwd1aHBbFnXpgVgCR1yx8rEVv1EsCBeyZ?=
 =?us-ascii?Q?fnte1oM9a42sfowO7f6s6qyqgLybZIPMwKvAGtGlbGEZoMYm5CV8rvxwlw7n?=
 =?us-ascii?Q?1Wtw8zOIXxVU+oUcMBvStOwILWiQUwXGpJQ9RuXMhpeioz3FNcJjNnnzWoGP?=
 =?us-ascii?Q?YCKzS73Agd6IC7TM7VUldjIzzgVcf0hKG786YyOAYlo9Pd3V3ZzaWouN69Ta?=
 =?us-ascii?Q?stzr5lqU9Wi5LQlpb3YcFFMAROmf1TqidH1nPpXaMk6Do4eF5vNRMhAXt+0u?=
 =?us-ascii?Q?SL1aQn/D6GfN9uvx2YJwxg1cfV8Rs91YMAd05Qysxk5xqGrX89JBpi+Dq2Vt?=
 =?us-ascii?Q?/WndHFOmEE2iDT8il0cu4MwnUuE3HSAyvlV3r5jdahguJlFtxjc824PkQM4Z?=
 =?us-ascii?Q?Wa3Od6LU7ogw1bGXNVO4xF47l03KtI8RM9Nf/xtuJFtYN5rZVrViyXG5QMPC?=
 =?us-ascii?Q?WhTuB3gA4Iv625xrYvprZtnc13ydyTT5VaJE4hg7VZT4eEhRRWsn8HJGE/Z4?=
 =?us-ascii?Q?zn8JYE05DG0bUl7EhZOnhvw/Mb8yL+iYI5Gm7wVYUOpPahbrabDVOeKLoTWK?=
 =?us-ascii?Q?6EcFn2RE37finLueuGxcwxVV8XOtVyKzwvJp3CqDwCBvcxgWpRYgQMz9iSZp?=
 =?us-ascii?Q?1soZaEGu+9MJMfz69h60fu/XCP1obwVxbmo8?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 79vZ2+9m5fe+YjoHtrM07XXhEQMdRSiBmeAtU4s4hgWNeT6fDrAMxLJEFfzvsJ+LUy5kOpjTy1K9Q6g4tlch3DZsJL7WWdkwzW2zIBlh0n94FHXv2dWaOJag4StHLLY/Q/xHX5/gHJT27JnPg8Tw6NZV92t4bLt2MkbKzcZGO/rVHoTyHcPfwhPqutbCCmhPzkztpJ2+DvWnnAuZaRvaGGsbnhPjbdAmScajLNMtCEc60MFqJlmT2mEhXU6zFxsx8t3bP2iAQd/y0dL6RuGdby3LP1kvTlR3L3VWKXsUruvYYWxeo24crFevXq9TvcJHrz3b9bgxyDufBIU7jePuVfPNXY9Lk+Rv44BDklMZx/C59Vv8ZmhDH8XeClty7wz3Ejmnx95W1zf4hRgeQPmzzuj0zOxkJ8HM51FJF1IrNVRlnmKjrBfsiF40trGZ4pmyJnY4CqlkOGIXNekpMs8jddevNd1hpCspTiXs8Lmf7HLWqtAnTpPK5CYmYzqdU6RVPPDJ5ID0WM9sTN9rzqrS1WL3BtR3CUOHyMI0WzPcDW3Hmob6+HqQA4VVm023m/qiRoLmvYkQyGKlBg79ZFdoMwWmM4OITBg4YOvnnZOp4EOU3t4DUm27jhWMrq6hwQd2F+bo3FgleCQZxwHRfBvu6Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:24.8828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c27243-9b52-4db0-9634-08dd87edd19e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1202
X-BESS-ID: 1746020966-306095-8424-586-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.51.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYWpoZAVgZQ0CDR2NLANDUt0T
 QpNcXQwiTNItHEwtjEwNTcKMnAwDhZqTYWAKKAuQ1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan17-92.eu-central-1b.ess.aws.cudaops.com]
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

Sometimes during  high flow learn performance two threads
could cause deadlock using queue and mutex.

learn_ignored variable sets when flow learn and gets
when flow removes. Hence, learn_ignore should not be protected
as far as two thread could not access to the same flow
at the same time.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/include/flow_api_engine.h                     | 2 +-
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/include/flow_api_engine.h b/drivers/net/ntnic/include/flow_api_engine.h
index 859c76656a..10b09f0297 100644
--- a/drivers/net/ntnic/include/flow_api_engine.h
+++ b/drivers/net/ntnic/include/flow_api_engine.h
@@ -297,7 +297,7 @@ struct flow_handle {
 	enum flow_handle_type type;
 	uint32_t flm_id;
 	uint16_t caller_id;
-	uint16_t learn_ignored;
+	RTE_ATOMIC(uint16_t)learn_ignored;
 
 	struct flow_eth_dev *dev;
 	struct flow_handle *next;
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index 3133464675..d12bd5a4af 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -518,9 +518,7 @@ static void flm_mtr_read_sta_records(struct flow_eth_dev *dev, uint32_t *data, u
 			uint8_t port;
 			bool remote_caller = is_remote_caller(caller_id, &port);
 
-			rte_spinlock_lock(&dev->ndev->mtx);
 			((struct flow_handle *)flm_h.p)->learn_ignored = 1;
-			rte_spinlock_unlock(&dev->ndev->mtx);
 			struct flm_status_event_s data = {
 				.flow = flm_h.p,
 				.learn_ignore = sta_data->lis,
-- 
2.47.1

