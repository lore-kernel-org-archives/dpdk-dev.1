Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3809CCA476
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 14:56:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D170C402DD;
	Tue,  7 Oct 2025 16:56:35 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 515C1402D1
 for <dev@dpdk.org>; Tue,  7 Oct 2025 16:56:32 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021091.outbound.protection.outlook.com [52.101.65.91])
 by mx-outbound15-149.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 07 Oct 2025 14:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K965YRUE5I0Nkw2tkKRO5m27FjpyLKOL2T1zvWrT7RPDvAEotZmY4idnE0Al+8mRowzrdCDBspsHtfdM2WrkBJlPiHe4PrXbOPV8b5lynaz/9A/tEAzxgZMg0L+4PPEl3Yw83ehPthb71KdyqHonR0mdH3Le4mZPP7QwBB8N3RBaVeidir/wkPtUJL1lKLYxZz4yY1yxo2/4e9aXs5aPQ52MMY4+3aKT5JMpuz6m0d0+yP+DMNIz3ksMryT3LhILpUnSyO3ZXoFRhar3xsEx+w2GIcpLlzMLcAqhVGHS0RS6OcQW7z4c1QLbEgAQx+alNj5xD/bZuCVnYb7RlS7t9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nkr/rBmUUtf8LyCrDZ8egXISjlz/Y5irnm0RZfG9e6o=;
 b=bDmnL80/sLhfngWDBOfvsGbt3bCRDGcByPdrmS6XQp/AlChOH2Hn1J1TgXgYZ7YGGoikRLNYnVNlCb9ns39Bw2pkH6c1LowTX84QShoiFakNAReFvF6XiCWFS7vmVLcMHOZRDkwQ17t1VBcHt9CseamVme/JnS+YLN4hVIvraSEqC85uEtVkWQ74kEhaHtszoOsssrYpZ9WzNuXFlJH0NxfD7I1D2DKDSX2l2Pkb/kYtK5HIf1/Jnpj1ymMvw9CBFvNqZJ9Sr0y3FIOA3/Wj8y0HHG0QBSHFmEnG9fYwVe/MuoUtUSrBC4NHAH0/WpsC6rSHZUJhBX5SWaF8yCh36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nkr/rBmUUtf8LyCrDZ8egXISjlz/Y5irnm0RZfG9e6o=;
 b=CKgEnBvrIqTp+5SXuFeWHz7od+KcQXwQ9XF35vUyjzdIvpr4AGBe6xevKZuSUN0kpBF1teFQz37CL1YEgK61BsxVCRrGi5NBd8UwTHYXm6698OMqXSOvCU0GiazrzSwm60Nw7LdOFZHnT01XJg5iHkkXLJ5efGzQWJLrmSQVZlM=
Received: from AM8P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::14)
 by AS8P190MB1111.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 7 Oct
 2025 14:56:21 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::d2) by AM8P251CA0009.outlook.office365.com
 (2603:10a6:20b:21b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Tue,
 7 Oct 2025 14:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server id 15.20.9203.9 via Frontend Transport; Tue, 7 Oct 2025 14:56:20
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 maxime.coquelin@redhat.com, Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v1] vhost: always lock all qp if handlers request it
Date: Tue,  7 Oct 2025 16:56:16 +0200
Message-ID: <20251007145617.2888818-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <108a1a35-b8ed-4b1f-b232-d0e01c9c9609@redhat.com>
References: <108a1a35-b8ed-4b1f-b232-d0e01c9c9609@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|AS8P190MB1111:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 209f2ae3-7b60-4b8c-06e0-08de05b1ad4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aH5TyegkhH67qV/ygDCjo8eUlXzw6S899NmgiH50M3hb6z0ybgJw1ZChU4Yt?=
 =?us-ascii?Q?20XXt2ehdtzFbxIMfALiYGpfroEpLx+k8rTPydAQy0YKOnQcA0ic4scSrvoD?=
 =?us-ascii?Q?IMjr4PQgOvfbUQLYVElThuGFuRA+lw2FqyOtq3Il6AYa1rGwsDDxyTocHF3S?=
 =?us-ascii?Q?CZws4aNtX6DqNFPUKh9zhHnqCOQQ0p0Ljecu0xBgm5HlbG5UH1MSgp9M7B5H?=
 =?us-ascii?Q?ICjDdtJCLvUy/qRa4jY7L6wIOoI5jJfScxiYrNkLX6oNmlbjv+d0Y70jUKVU?=
 =?us-ascii?Q?IvOHBop6qtIlHgXbbpYg+zHk416SSYs7U1xHIdin9fFbKWIT1luphddgMQL2?=
 =?us-ascii?Q?oUDy8p4utlfjJTvuYuQTGIyBnddZsyOBNJfw5iPilovNcEl5in2ORMk0ITVh?=
 =?us-ascii?Q?zmAoFOvemwKQB+5qtKCs+uLPtcg71wJW/3dntzKKMrpTQT/eAw4LTpFWdQVN?=
 =?us-ascii?Q?2Qv5MFBDNnxPJud/aIZrqhXeVHumTpsX+TU+tNv/dWLTrYDTWR6IQRv4DMoV?=
 =?us-ascii?Q?U6G7JA9UsxkB0AWfvK5Z7hmTYx/D9IgHFW6x8jmEnNjhY9cz9vAhSrJ2D9/C?=
 =?us-ascii?Q?l+Etat0nEFfbAhGDDdQrVhoFnmgSfyQSuqczE0X72DyxtL6dwz0lnxpsJLlV?=
 =?us-ascii?Q?9xuD++Q4jSJgFe6pbS4SmTeSyHyBZ/AU/SffggWw4GzYV8CRFBvhfTumqFzR?=
 =?us-ascii?Q?kZFORfCSe+7vsY7p8S2sLSKc4Z7CaubVfDqHuudoBJNaaRnsOlBZVyETmWIg?=
 =?us-ascii?Q?UPXHuiKmj1h2FDFotd2av7kvBYIBjOlENoxUvXL6uf9Rr/I6ByMrC10smo54?=
 =?us-ascii?Q?lwJNsifc5miai5yNZuyxWcEH1fl8poj6EWKVAoxPMA5HQnWMzaGXnHL6lwI8?=
 =?us-ascii?Q?elODa9WGOEEiXve+uyKMMkHW+xIj54KaWek26VMD45ErRKwnCmL85kC1cHGp?=
 =?us-ascii?Q?hFjEwIv6gDrfS+3ekfTWWAIFn/5lUqaSNW5Kd5bQWyaWYiNbSrkkQPbfuQjH?=
 =?us-ascii?Q?f7tuIt4yizQH3rJA+ektLM8HZyRUXrj4AgOiLr8iWetWy1gsDuA31Vbc8XQq?=
 =?us-ascii?Q?lvkGGWKEMXE02KAo3ZOU1ZWr3LOeEij7ZWG8QPzgDRt+/hDgY8CjBQ7LPu4O?=
 =?us-ascii?Q?/mAbgrOIOIsRf1fjUz9h7h87XLlVbvAviZfoU+D0suTR1vzB9RGtrvb6ldRn?=
 =?us-ascii?Q?A9rwyXshleP15CGOFQgrp3eOCN2YjYovBcg5hzvHOK5j+VjFnuo5w1ytVVYO?=
 =?us-ascii?Q?/LBY205YZzbYCbRIgO2UYgJ/GBILUfFNM7nA2e/vkYeJTiCXDBzZVaPyKfyZ?=
 =?us-ascii?Q?0SYVsT7qBOyjoMEbizZOVABGMLYLYq4EWgoKSGyG2bDrTjrPpTp4UTRtMi+u?=
 =?us-ascii?Q?Tdp6htn+pG01p58AuXHbM1a3NGqEFafG1Ee7JRSi917yeFvKdjxJmsDUd3Dw?=
 =?us-ascii?Q?UWDzJNapbHrqDVrkKVD/l4NPnqTiOc/4YcPzRBJjhiTYTEdQIFnZ9/rKjgvm?=
 =?us-ascii?Q?Qjioz8EDKOOHNtsdlp2aXcZmxPbm7UfJXwJpcXVnfjHmxrfaQRbH7e0c66DT?=
 =?us-ascii?Q?ChQteVYrmz6+/U5hMU0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TC6FlCuClQF6tVyJR0S/E2hauWw4HCBZFiGdegka/Nfr3g/UDNtgApnc4qELvBgbIOtmj7VIamR5/EK4yewbn/HxftR5gt4JFdf64OhNTRywcM34EOzwzKc1mE6JKj66UCgRGFPNMTfYOm2/n5gbTo5m+rZB8hmpAF+Gj4wvpdYv+2X41g7M0OPFCkK7WbbgOz/sjG3sM3TKR/mwSbJE44+c8aamaHGZPTZqs9YOJOiZ87fgfed/fQGbFhk9Q+aiMN8FYrRy3wdMStso+2aLoa/AdfLl7O1uBJkPrTzMCqqQQ4TfoZ70E3aO5YA6uj6Le78WdDR4qd7y+aoDqSXiTXbJgbJl8Ax9DLGzxNHoYkGSMB92s7CsYsWHDj6XH8LSqg2XfaBFYBr5C7isoJ1f/Wx1hK3aJJELL/25Sm+Z/u4jIRnSiO6fUe2Qnmn9yxA5skQZa1+yWiccyuF5a8vlbO21lw7TTkE54qwvOQCBmA/nKUjtrXSuvtoiIlaQdClzoPB5Zb/JyjdzKJea+xQDlZuM7pQGQMHgjECA+XuXMiuBmRz9zW/7kNt39Hwh/o3eWEV8/+lEdDNtr5aWOhmDovRZyD3JSc4K/9Rdj5wM+Roy+fTBWbUBo2t8InCflldQHyBahSi/tprQvy/tLRlKig==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 14:56:20.6687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209f2ae3-7b60-4b8c-06e0-08de05b1ad4b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1111
X-BESS-ID: 1759848986-303989-7661-3692-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.65.91
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGxhZAVgZQ0MQs1TzVKNEwNc
 0g2cLI3CTZwDwx2djc3MgsOc3cxDxFqTYWAPLQMtpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268036 [from 
 cloudscan17-248.eu-central-1b.ess.aws.cudaops.com]
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

The check for VIRTIO_DEV_VDPA_CONFIGURED flag is not neede
since each handler has its own lock_all_qps flag
to indicate whether it needs all queue pairs.

Checking the VIRTIO_DEV_VDPA_CONFIGURED flag caused certain handlers
(for example SET_MEM_TABLE for memory hot plug) to run without holding
the per-vq access_lock and trigger vq_assert_lock failures.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 lib/vhost/vhost_user.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..9288da9322 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -3171,10 +3171,8 @@ vhost_user_msg_handler(int vid, int fd)
 	 * would cause a dead lock.
 	 */
 	if (msg_handler != NULL && msg_handler->lock_all_qps) {
-		if (!(dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
-			vhost_user_lock_all_queue_pairs(dev);
-			unlock_required = 1;
-		}
+		vhost_user_lock_all_queue_pairs(dev);
+		unlock_required = 1;
 	}
 
 	handled = false;
-- 
2.47.3

