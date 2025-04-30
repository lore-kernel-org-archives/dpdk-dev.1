Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF8C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:49:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C148E402EF;
	Wed, 30 Apr 2025 15:49:21 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 652C140280
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:15 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2107.outbound.protection.outlook.com [104.47.11.107]) by
 mx-outbound23-207.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0VcRYqY3qDc2peAeaQ/q7dJe2G5Ht+sx8JhO8O4aH88t9IB4KUeYRPwWwS8pu4xyqjJf+sUZJCUuxL6ZxqvivhhE6aCnwwZkjzHV2PP8cu2L7lRuUvM9c8pTU7wv+TpTI9OF81QFl79uDEOWfcMCmsRpWyEj9DvOW2UkJtfMPG8zTOKLMDF3aSSp4s4pjQPXtRmBjZdNMDKJAmQnniOakg4D5rBgbzHl7Xv8/dK5kbkjjhdSKTuY7Y2MFfqUBynt398TdCxblghQKvvXozgEGG8jCEISKZAQ7O7IenM0u8Fvn+jdhGcgtVgshaDLX/yZJ4zDyUE2+dWewz1H9V4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJDXuO1SgS2YOg04uDgy4O0aNItobi58l4WakWyrug8=;
 b=gtq9ji5OTRvAl49TH6E5Asy4XF6/jnXAvlOrd54z3L4y5ePosOJ3gGCTKQr98k/duYUoIaA/8Lbaz76aLetkOiWfZwdIk+Je3qVUEcHFHeNv0phWJaoupkYI2I4OA/nSPDLDKH15Xo1FPVUGXzaFuS94sBPnDuNOKqckv7CyFdh5gNjP6UdsiCrE1qGDOhcecpqlNlDWb3VX1wIqmfo1dCM6H7XcGwY9M0ATNLlo+fnhuPdToXX5YcUei1aj8HAUYMLSbDCpZcBNMLCNKLD4W62nCcamtGz0ZeAxzwkE986SHzOg8FcDn2fC7Ocd2pfX0dc6Q6TIaHFJ7zTSlb3XvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJDXuO1SgS2YOg04uDgy4O0aNItobi58l4WakWyrug8=;
 b=fpWok0OXfWe238qao96b5A01SO0qRQgrUEPHCjIe52E/CUou4DmaB4IA/Jil9W779bGcakxdt0DSSr5GDms/INlVuxU048pQFQqW8J3Uibb6Qp3kMVgmILIiF0yA5aLk7RvVHrXOjxMiIc0AAO68tKBWKBsfgFm51LknbG6E9H0=
Received: from AM9P193CA0015.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::20)
 by AM0P190MB0596.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:10 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::62) by AM9P193CA0015.outlook.office365.com
 (2603:10a6:20b:21e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 13:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:10 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 07/25] net/ntnic: apply packing to the structure
Date: Wed, 30 Apr 2025 15:48:19 +0200
Message-ID: <20250430134840.402553-8-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AM0P190MB0596:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1b9d44b8-1f82-4767-eb13-08dd87edc92a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?twtcZJfxolf0VSggGLJgku6A65v45k33I7ep/pAId9uEutgzhJU52jJpqtC/?=
 =?us-ascii?Q?fUwY1LOzZCS7F56GPmvHAvfsmo8NQ9VcgzTLTUdnKOHdIYG4c8gJCASi8xGP?=
 =?us-ascii?Q?7fxRWljbPBUThH4Z6BPKsnSr9YcUf7JxqqHtVxPbzLBIum7ZQ9FbDyVDo5MF?=
 =?us-ascii?Q?n+yAemCK5BHf3LWEAK9cjMh09CtP/JwvH49fhGKx2+A1LQhP+b4UanYFNMto?=
 =?us-ascii?Q?ZuB94l+AUanJsmQAUfa15dsdeNUTcnxl5Nvps63qEY0BLUlxhEINanCBewON?=
 =?us-ascii?Q?/+5+obyPgxfEONnO1Lj76l2ReJ+jBI7KZAUaM1rNegpxWzbRrgNXauUI0kcK?=
 =?us-ascii?Q?z4gQoV9/2AqPDJ9ktWe5K47GEEBnCWvD1o7DphvsyYFx9+aH+qMolU6XvIkm?=
 =?us-ascii?Q?vDPu7kntYEHu1K9Q8Zjl9sIxHd8A6l1Z1UCh3hJ8dxVBfxQeRigslaoW3cMJ?=
 =?us-ascii?Q?oMQ2e0IPzoK8euLaIy83GWUgdfXzy8bw82jTMHKOyATLiE+Nj6gE5vVBML4M?=
 =?us-ascii?Q?g6tsaTuQ6TV2wjT/vUScu/bsENpW7ZmsDH2+UcMw0QPiUtPot/Z5I7/B0P7c?=
 =?us-ascii?Q?oIDVODKhF1SNbMynwxW1toziNk+RsqEAlxuM7VML2iYYEkS67ehIhnAaOHXY?=
 =?us-ascii?Q?mTu43oKKYWrPicYMlMUsSuQ1xfJBsagI+KWlHr8dCx02KPfmBDS8sxiaUrG5?=
 =?us-ascii?Q?CRRHVVo/7xanHVTguKkgzOfVlW8A+u8pEVCNU7wW0QZ0zKzuKyEJrcJcoIK7?=
 =?us-ascii?Q?M9tfrc7+RVFHHf6/qKZRGr3A7EShAwl/LevUeyGjCcxDmQYdK9LOg668TRlV?=
 =?us-ascii?Q?iH/n9Jkn1VA4JnGAPNBg/tpGzlvClzsBj29LU2GftWvD+gRx0Cw2A6x48oHh?=
 =?us-ascii?Q?GAHlt+a+EHhAac0s/2aXjFqm1ii8+O+USS1Mu5u6WN3okPlKjFz2fEPQ4DwU?=
 =?us-ascii?Q?Wu7OdZAsycIHnFgnllYqlkxXB8fpGQUfzYXLZeVpFzvKKno9x1BcgQVr2f+9?=
 =?us-ascii?Q?wpy2w2YG5EiK7MtJ0Eb6uhgwCoylWRyxxza8XKsCw1qYy4agfHqlc6WUw7Cm?=
 =?us-ascii?Q?QgTkxs+j5nI79T7ldt83ezovUTWWsCMrd+QxG6iuOTsEf3qOuGdOdnbeg1gT?=
 =?us-ascii?Q?GuAc7ZsxPv6PFk0yK8FRt5sU+sn3zW3DH3V9WRdLns3rh4U+QTCdKgdVpZF3?=
 =?us-ascii?Q?cHST5IMV5QE+mbBCRaATbuwqXUVOEsCdpUpV864kzphJ2W4eqO9YLPr8tFC6?=
 =?us-ascii?Q?XfnG0wGb/IXn7xpeiPe5njMM8Xxb5OZMgLeaqtOs4zEvW6IrH6wXvrO1H780?=
 =?us-ascii?Q?qj4GU/xjcZ+KkipaDtLR7uF5TsMy8+cxlTtJfsZ3klJePXwQtCE2iNMywJGw?=
 =?us-ascii?Q?w6504x+mP/0JGVuE7AEJmUxG3JplRdTCKB3tO9buq58SsY6k7WYj/IP0hcOn?=
 =?us-ascii?Q?UmY57/YbKLLNYEwRf5fG1L75J7yC0kNwt8GTOKVV7fI6/AcarpUuD9EGHitv?=
 =?us-ascii?Q?gjp+RvogtXqq3YLMjjC7DdSVdNwa8PTcQKpm?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pQh1G0bXaWby/iMf2tupl8oqx8RnGFkIXKVfILT8tB+/8W+waIxCi0ZwjA909RtB9xyhMwTVkVrLkQbhYn1LjDRNIADpK2vigWlqin45O3Zsl3uYeQ8VmzsHfL9ldsvBDOfz9FjPsvrjgIb6gA0UHfcfUA/+7q0TRFYMLnR+rzqgut/Xpa8NdMXu3z8h3OXIJj7gYeaZTkoTWIsredPRG5qSblIbdqgtFP0E5bZ62KSy38N6VHn86vAaPiTOHScBcIj5ULZFU9U2IgQriFUYGGAEDa4KkSLlsZS8YaM/7x3n7TlYmZ2FiszsTgMGRVqGf63IfquJHTm0fMYLKroY/VMnZ+yuyXaCanIyT9e2ct9I/ijHZgKKgK+HyWRuDNWyqgXRjIRp0i2HeR+To8vcWaYcRLB5zoZUB601my9LRwBPdC0Nrksbd61mwyzG+1kDK8ihBYvCUGsEAWCA9X8Sj5Y8ANSrG7Jjhqd8uxhcukz9pvx0vZSaUwvQjf07rXkfBaO1eCZe6+oGAnpnlgwLf7xDfZCP6Rf8n6881AUyjRgWzvRwdHcOuZUn5k8K8d9C5wjsBCFqw1wOvrgPqSZgQUJA1lOksyhlPkfdgOUjixIZZfIKifX3hLtjLdcttHYg31fOL9YEZZTIjKew1LA3uA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:10.7255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9d44b8-1f82-4767-eb13-08dd87edc92a
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0596
X-BESS-ID: 1746020952-306095-7600-611-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYmJkBGBlAsydzM0Mgo2czCIM
 0g0cw82SzNMCXJKM3ILMXE1DjRPFWpNhYAILkZ3EAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan10-149.eu-central-1a.ess.aws.cudaops.com]
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

The structure virtq_desc should not contain any paddings,
so it has been wrapped with __rte_packed_begin and __rte_packed_end macros.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/include/ntnic_virt_queue.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/include/ntnic_virt_queue.h b/drivers/net/ntnic/include/ntnic_virt_queue.h
index b95efabf97..072365c946 100644
--- a/drivers/net/ntnic/include/ntnic_virt_queue.h
+++ b/drivers/net/ntnic/include/ntnic_virt_queue.h
@@ -34,7 +34,7 @@ struct nthw_virt_queue;
 /*
  * Split Ring virtq Descriptor
  */
-struct __rte_aligned(8) virtq_desc {
+struct __rte_packed_begin virtq_desc {
 	/* Address (guest-physical). */
 	uint64_t addr;
 	/* Length. */
@@ -43,7 +43,7 @@ struct __rte_aligned(8) virtq_desc {
 	uint16_t flags;
 	/* Next field if flags & NEXT */
 	uint16_t next;
-};
+} __rte_packed_end;
 
 
 /*
-- 
2.47.1

