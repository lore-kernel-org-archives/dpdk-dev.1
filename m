Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F9C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:23:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 161AA4042E;
	Fri, 10 Jul 2026 09:23:20 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16]) by mails.dpdk.org (Postfix) with ESMTP id BE7254026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:23:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMDMaS/vnln39nCmpHQwicKZj/xWxODHdgWJsrV3Nkndm7amPiP5QpBEQX59PaK6TRG9AnYRCPv59kthUJbVxNxpXpCGIVaP6TaX6w1Vh4jl4CHGnvgU1Skv/yZF/ClsoK7lnr8KK9hjeYFStqnU803FcYrRBsAE9o+y/vIeBr/AXZliZXgm1RJTjAkGHN2RlU0MrB1bxwV7JefP8FGnp4xyqIGizu6HihDoOrssWQGanMtVRQXP0XnaYIYoSu01nFeiyRAI7fd+sjIW4q5nreYz+yszdK+H3UtIKarGRhTO8JUdOKMhLdywxNMKIUAIWqxnZ2qXK/VpCO4bC5Z9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyUHC1E3/m+ZDOduauJRkfPQFTihrrA7nUhRX1yCIJM=;
 b=Hx55GwFuW27VVI1pRWZFQBsEbuAFomwSE7Y7XroxMJ4vBhdSsyJXB0S+ZpQa/6yoShBEomHC3qTaoBkI15k5Loh92F4ZBWW+H6/PlJuFs29gqfUMBLtjaQgmLKQ/ppmllOJM4Ideb4mqhxit0rvvk9jySPTux603tJUe8L6dde3Zq0oSYHl77fakonmAsEontatsNiEVKevpFMxEYJEUebeMOwevBW/ZjmkuuLhQKLAaL4zz4xFEPqioBnoRxUMhXqYp0vfGwRQBhd7q21+oJ4VD80r10fQuNndWtnX4X0UqqX4kgVrOhh3FlAuL3ShLVNXnuVYrtxy92DThzyn0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyUHC1E3/m+ZDOduauJRkfPQFTihrrA7nUhRX1yCIJM=;
 b=zn9oqEYNTrwMgduEIkWqNIf1AZY5IKvEc321Sy3f8Y+dB+hFYFWx4eh2mx6ISYBvE8M6FVcZC8M/jXmE9Mtvs3tDQZKbCbcX3D8JcxSOX/xRPENnKcH3j+S/VvPxMUG4jxZclCbRDe2TWJ4xap0HfgOLNbDer9pSTLqjFz3tMUc=
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by IA5PR12MB999302.namprd12.prod.outlook.com (2603:10b6:208:605::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 07:23:15 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7c) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend
 Transport; Fri, 10 Jul 2026 07:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:23:13 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:23:11 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>, "Robin
 Jarry" <rjarry@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v4 3/4] dma/ae4dma: add data path operations
Date: Fri, 10 Jul 2026 12:52:49 +0530
Message-ID: <20260710072250.3034265-2-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aa1b5a05-976f-4dfa-89bc-4cea18b56d33@huawei.com>
References: <aa1b5a05-976f-4dfa-89bc-4cea18b56d33@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA5PR12MB999302:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f60288-9a0a-4ff1-a6ad-08dede541ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wVQ51tgHZ/k+919p/Pqjc573ZIsMzanMJrTr2ZWYZjV5YrTQeVvUJRP4whHVlLF6j37M04EjDdR4grDz2yfDVmN95gnBOqZMRuMdG8a09+M2aU30XAjbqq0DVkM6NJuCyXGNFcDct8W6kH2dovxDi+uGJqyg4zhajlvQdov/qnsUQJ2d7iKtXEnNytl/t7f/490DzyRXkqSY0f4I9+3RX0fGPMXTh+KCot+SoLaz29rSF1znJLw8I4qQQMXZ0XX1I44jwJi+VODvCg6+I/7YaqhueNS56wdLgMLUbxe/v7uKDY5m84OaBZCJ+5+pFzE22S9eovDrkwo6eb3fUIIW6LFElXq16IW8NeUqZK7hDfcMR7DVf/OxQqQXZuvTrKjOuUL30bjyu58fsQk+ERaUmYaSWwAWNhWrdaTqL7GCq+M0z7VlQzQzvRppXa+selxp7gFLzXJKmhknl42MNX8sRd6dAO8bhQ9aWIJPuhgNN4ZhJTszt6qikPJ1RvUzelTJtMUHHUxfhhJUzaOFgJUrGCuXV7KOwvWMV5I/hBuscMLtSpssykFyEuTvQUj7Y8j1fW+8vqxtdjvXNkirYpU1o6AqlJ3WY+UylRUFqcE+MaJsbQUoghkMPqpVMHZeNn2wkL813evrN8tsgdIG6iQsT5u4yGuxrgY1DBj9ojTIILYpUIP9Yg6sUaqNYi1eF6N6OBnCoNkgRRAD4uXCRezEJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CBmdbQGNnk3XyDQDz15X3LZI2qjemu3Hkpr6j255674baYu89G/isnHI0BIr1LA+cw8J80dRJL02prH1ptJTTbSLDEIKaFtUmzB7DIaRNMJsRATOOenS9zkVJLOinKwLbSZe27eo9asbXlDXqo8CcZ2BvTjKcTlrK48EWjhSTPNBcWWgZjJJRdF9nMNx0g8CxKHmABqrJF0BJTA+IsBENbN2cRBzeZ5/BD6gC/hX3A+VRHyPlvgKQMYmUzR0hXk6OB8kR3wkD2UBxq5+hU0ClayyoMkyVy7LNclNSGQFSAqsWFCcRoXcFDlLeI68wsaiyXc20GJ6bCGt1RZdSQklXCF6bf/Wh56FHZH6VOrnDq8+b507etHcLW6IezUGtq91S9nIS6jjNSOtczkyzCeam7KeEp1KcTZCU5PWhyKDeqLxoZrdM0wl4fp7OxF/Caym
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:23:13.9443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f60288-9a0a-4ff1-a6ad-08dede541ab6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999302
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

On Mon, 7 Jul 2026 at 06:49, fengchengwen <fengchengwen@huawei.com> wrote:
>
> > +	if (last_idx != NULL)
> > +		*last_idx = (uint16_t)(cmd_q->next_read - 1);
>
> 1\ the last_idx always non-NULL for driver, so no need for
>    'if (last_idx != NULL)'
> 2\ last_idx should be the last success completed index

Both fixed in v5. The NULL check is dropped, and last_idx now reports
the ring_idx of the last *successfully* completed op.

> Consider four reqests, the hardware mark each request as following:
>     req1   success
>     req2   err
>     req3   success
>     req4   err
> the cpl_count will be 4, and err_count will be 2
> It will return 2 in current impl, and last_idx will be the req4's
> But in this function, it should return 1, and last_idx should be req1's

Agreed - thanks for the clear example. rte_dma_completed() is reworked
in v5 to stop at the first failed descriptor: it returns only the run of
successful ops preceding the error (1 in your example), sets *has_error,
and leaves the failed op in place with last_idx pointing at the last
success (req1). The failed op and everything after it are then drained
and reported by rte_dma_completed_status().

On a related note, while implementing the above I found the last_idx
documentation for rte_dma_completed() and rte_dma_completed_status()
to be identical:

    @param[out] last_idx
      The last completed operation's ring_idx.

Since rte_dma_completed() only reports operations that completed
*successfully* (it stops at the first error), its last_idx is really the
last successfully completed operation's ring_idx, whereas for
rte_dma_completed_status() it is the last completed operation regardless
of status. Would a small doc clarification along these lines be welcome
(as a separate patch)?

    rte_dma_completed():
    @param[out] last_idx
      The last successfully completed operation's ring_idx.

I'm happy to send that as a separate dmadev doc patch if you agree.

Thanks,
Raghavendra
