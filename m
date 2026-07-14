Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20624C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 07:54:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D7834028A;
	Tue, 14 Jul 2026 09:54:22 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
 by mails.dpdk.org (Postfix) with ESMTP id 8E6CC40289
 for <dev@dpdk.org>; Tue, 14 Jul 2026 09:54:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihDRGSREiWqyyEx7V3BOvGsEPtIR73W2A1RaztnC+QOYqTvvCsAXvWuYwe21yXDx2QJR+apZmAp7/rVBoDNosWWAN8S0fhsQtjrJxKIW+TYUH2yP/0VPgFaxAfjjznOaacwjB5tuF0GCySPobUKMjKEAxxOB/VzZESe5Hkd2kwlYu2hctUQSe45SdBsdS6ayKOOpMaxls5XtPK/MTqNyhkifUCWhm1mYMVtEZNNOECHRlQrevpsEATNIoSpsKue6OXRx7Mzgu0mXYbxacOlGd9+fhN7nAVC5Mal+zpgsuMZgu+AkkZhFfG2vd9iBqYA8Hi7pGP9ZvAYrIGP0FmqUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E33w52Q3Mf7ezXzhLnS7EKr4X3M1hRcVp7pGvB4BPvk=;
 b=ebLKdjoDKc6+KgJxgJsD5Mv3J8lMPnNwhSlrewTd+TxFTXFbnY9285TNAD8DOY4vbzfwGAgw8U2TPnaJlQb1lcBSt/y6slAlh4/jg4mAPh+fav0YaY7YjuXQENoOpJVmBUvTZlxUWTJLN61orT7nwo6NGy4tq8BQ1Xrfc5BOLJLSNNw9zvLWE4OJFRr0n1lLZPIZMxfX5oPA/8QswljRbhv2VupnZ8abzrkMvieotEhTuXnWtCw1x0ySxyW7JpmwfbXgsdXVzW1K7mzAspDS5rVhJ5yU6t2+L/QjR0jXMbhCz9WKALL6LxC37h9yoyCl9jGA+Z1nx8UVcOjVAmw2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E33w52Q3Mf7ezXzhLnS7EKr4X3M1hRcVp7pGvB4BPvk=;
 b=DYf/2gcLmfofuyXBU6BPoyJyHy508bV7EELpQCw/fBH6pMJgr11859xGsFBhGuu/GNeLAuLmRxjf2+UFdp9T69uPgWW3TT0hZzbsQW694Gty2bcuh+a/nSlqEtL3J2t7KNdXi0JAfzh28rpuCFXWlyJZbWILscmT968AjkoCfZs=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:54:16 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::15) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 07:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 07:54:14 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 02:54:08 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>, "Robin
 Jarry" <rjarry@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v5 3/4] dma/ae4dma: add data path operations
Date: Tue, 14 Jul 2026 13:23:53 +0530
Message-ID: <20260714075353.3412568-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c5331090-0d39-4479-8de5-44b95d364b55>
References: <c5331090-0d39-4479-8de5-44b95d364b55>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 528cc5fb-d745-4148-49be-08dee17d1998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wndWBY7cUiVLZdO2ZuU2Jp4SMBNyBdrcFFQGl6DrhUF8BHw62OE7WbgGuSl5Kr0BbJbYnGhKCy9yX32fpo/ibHjduDPro5X7gkbH1pn1yvMi1FUPFKvauZ/D7SJxK2N2GXqZcaWVzB4vT0BSw5hfAv+5+zFmkfe/ceZm+Qsz6H8uj+sPcMFMaKRNHvWvKPqScAc16pPtTogj91VnB5OkD6tFazEfDZ4vS6XQhWNpYb12xZAPhHnTAaYKf5eZeevK6SQE0vLk6ibliSJxavPdNbUFNmUfGr722bn8IqqNLcfXlv8Gj8yTa3MY3DDkyACuRxwrU/yp1D1CYpquUp4uiLcrFMCaiFtdO8jxDY6yOTdYH/lv+AoomyNGqIR9d5zFhqA706v1XObQt+8FGJ6Bc8r5oREHwfqtEkFyt9Mh4rGu0G8Vm/Q/a/qI5tfBQ90s6ipWLlPldUiuq2eLcqoqSjkGIzkKGbjMz64Vho2iQOsowKjmyaBPv5w5+M8ZbIy1ocVoaahl5jnDVU2nT5Kh/kpKgIQRDBqBmkzhj0fHIOhRWLtt4/6nRQgPpemwTofXeu1+b8kP77/cYe7GwpeFjcaNS/i1jVpRqd4y8ydEV9Ps1Q0l3RX3CxfUP1ZI/fgFvbqKCz31B6DYSy666BdPv6uwNartOqHx6bJP1iovq8DJ4yz6+TdXmsTuwzlAag9hDDoUm8SSk6wtlmJnMaGL4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Kf2OJwey3OtknZ6y+0gqSUAeehVa66p6EVQYwGs2pSuw8Kafj6pz0C3wBZjyOhuPRaQI9iRbnIgCQ0J5G32wtJYhNHajfdVaTPXMKxmpfViGFH3mYJ9q1Pl5GrzKfIXbNKX5Og0xCQPSchGCGioULL807A9oEuli4CrE722kytI0bVVNAPipjxlpXANZubedukmkFChzuAG8gnqs7snsUYnjSRN9UiWFPtZh7D0e7OScZOHZXmBnXFa0BW8Tzd1ja7WCcM8pixJ5PtT4WqNtDnnzrR5Lw0iXHWIAW6JDQxLRVrB2WZrvjhXJA8XRuahAs1DYlVh/yOzT54hsaB/jj2/ETznMsV8Fic9aTxBzrCjjSfZlgbo1AMhewU79ClG2MRMOz3TT/B7mPShfCTorD7ZMTzA4YmwkiD/oPIbf4k1Lejbji4LEto0qQWPSxJCL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:54:14.8664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528cc5fb-d745-4148-49be-08dee17d1998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
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

On Fri, 10 Jul 2026, fengchengwen <fengchengwen@huawei.com> wrote:
>
> I think it is necessary to update.
> Please also update rte_dma_completed_status, both in a separate patch

Done - sent as a separate patch updating both rte_dma_completed() and
rte_dma_completed_status():

  [PATCH] dmadev: clarify last_idx documentation for completion APIs

Thanks,
Raghavendra
