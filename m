Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA6CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 18:43:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FCBD402C6;
	Thu, 25 Jun 2026 20:43:23 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5348C402BC
 for <dev@dpdk.org>; Thu, 25 Jun 2026 20:43:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm7rp8rpwStdGXLIyvPs4EfGaj5OCNurvLKJ6dYqaM2DQkAEbFkJVGo0I6muqT2oWqSkfoemrxS0HbQfajU6+Z43IKuWWR8fKHp2Dnh/Geo3njbPo0MzrfNSldNi8+h/YfxCsWvLPH6ZQWoo1JQsrAKPezRF+yevDDxi6nTYk65IFczfig9Grhe4GSERglIeLC1qH8VlY2IQxasrLiDbN0bMjjGgiuDM1MHAX0p2ZidhGNLoTRvdpybtHRPVlEMUXo7iaL2X1SJDTe9dtznbqoK4e/3uROb36OOZ/MljULw4PVCDi/LuXak+u8u47n/NrIrMMbxEdA5RJcpm3qXpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO/Djb1z4E1YQnHAEatACeK9bY1gmJOL+dv68gmztoY=;
 b=oDfQlC+BNggEN03AylWzWiTn2gUDY89FrDgC6UydmPhPNWCbeczlZhm2ed5z/PBJ2oeZbSweFdycMXsdlRige+CdlHpD3R6gPbeI4oVJKyIhcNvD3DqQwmxC98sAn6EkvF5Mz3B0borI4shPSRD7qLHFcf2KsSLYtGk4xcpFQTl/mZRYqZoFIT3gJNt+WhtiN4k+eTtRaWsuuAZY+5tbwYAbQUDty9cbRGGROwvB/+TdaMxLYC0bpMlT9Pz9HIt0lqwUE7VFLmPMW7812UXDQUU4P9BaoXl1oyqfLULsnhJD7KYvulWQnc6JGvA0/KyG8H5fRxAncOgCXy0frqD8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO/Djb1z4E1YQnHAEatACeK9bY1gmJOL+dv68gmztoY=;
 b=Q/NDwoCczVoto76b/rEppiMcAqUxEJRQwjViZQ/mAEP8AYmbqegXI5imBemonIkHLISEnUmTf5HykLuh3GbjP3Fu/oxBPc1TZh5ibWnBo0XKNYN3k39zvdd/AhITJ6E8plke/802gootHUi+1m7XKtBhNz+J9WmdVATwaOwG3Rs=
Received: from DS7PR06CA0025.namprd06.prod.outlook.com (2603:10b6:8:54::31) by
 DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Thu, 25 Jun 2026 18:43:13 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com (2603:10b6:8:54::4)
 by DS7PR06CA0025.outlook.office365.com (2603:10b6:8:54::31) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16
 via Frontend Transport; Thu, 25 Jun 2026 18:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 18:43:13 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 13:43:11 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 <Selwin.Sebastian@amd.com>
Subject: Re: [PATCH v2 2/3] dma/ae4dma: add control path operations
Date: Fri, 26 Jun 2026 00:12:56 +0530
Message-ID: <20260625184256.1677873-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJFAV8w6YVzh6QEThWAq50SccApMtAzC=okPV7Hph5EvD7cYgA@mail.gmail.com>
References: <CAJFAV8w6YVzh6QEThWAq50SccApMtAzC=okPV7Hph5EvD7cYgA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: cf713b7a-6396-464a-41d8-08ded2e99d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A0ePr7yw6oDpR+xL4G8zrM60MGx42JnmHY3bvK/LXj2EDblWb8YcqSbiEYmZZQf5qJav/kDLQyEHm3W9yWHsQJ2IFXHtaTfjHr6xWtraSP58m10nPP88VztvJ1QrgTuE65yLSmfEBkktuINNEQ6v6EV+1uruY3tWmiJM4Vz6BlMN3ucGuBmQNMuwUWJXe08GNA9Ihg0VSZJu+5wLYrgsA3DWjFq5i3J5Frn3Eo7wMjliTUmqF80Z66SqPzIsCbyfg2MkgZbYyHXustcwwKODdIb5B1CMhJDRayf4WITV4Xxs4xliwOsd2mowCwlxtF0ySnoii3fjH382OYo9csxMeB7w6H6PXZtTo3BkHyfN6Fm5kp+pnB9AfkLiBImwLCXKWHtQwLI8fp7ThoE4r3eiuCG8hCfpZ+mg+D+oSQPdchInc9EmLhAtkfX+++Zu0x6iLqmfMpbF12RpRc5quAfxuSI7SOoDg+IueqMp5M9GRGv0rFBdFzofhMqzD5KoAY4NXn9zzIx2lAM8ONVzmytUe71MJwqO1MJ0H8O8fuUxwizbIrYpaFGCi6TiB8DtG0DNQXh8daicLjYwQnJQ/Xn3uJ44q92cPblZW9TueLCDeJxeL2lsRxqURBMK1SRniJ/OBN+jOwu1EkDiqKYGsFcNpiK7KXfLYmGfFrN34BrnRknQ0wy44EulNLOZmPjfDJ3MR0Rilv4oBEOIExAoue+9oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y3tVrsl7pStzhWo6R2r+4tonFkedLcT75LB14pUZbCfGGkM0bYcK1yMzg0I9HCuMAz//DOUK1wZagopMMviXMiilIBoqenHisU+q9IWR6kOMIaHqmm4DZCU6fMnAy3r/vYMSLHwxOm4hUCOaFheNW1Y/uAoTpWqAcm6v3KlwjiG+ysP+26CgHdWLwS8ZIgWIdLQSq0kexDd7r6h8uVlB7BFiRyZnE7YECWRlteG2VsW37AGdKpXguuLC+ZUKJoOjNHGtfzG24u47zp9CYsw7NvI+altY1643AYihKmPeXd08lC2eMX0YidDB4B+t+M+6JBVG+ysDnnPfcJBbQ9GuVSelA0UZDaoePLMynEOqy0GFLS9ujbQoirpN3+PbzmfRO1ogcym4co45CH6YqVq6GAmXGxbyAeumsbOPc68JO4ouD1jyo7UiYrqXrojUkGQl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:43:13.6039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf713b7a-6396-464a-41d8-08ded2e99d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801
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

On Mon, 22 Jun 2026 at 14:15, David Marchand <david.marchand@redhat.com> wrote:
>
> > +       info->dev_name = dev->device->name;
>
> The dmadev library sets this field in rte_dma_info_get().
> Please remove.

Removed.

> > +               const struct rte_memzone *mz = rte_memzone_lookup(cmd_q->memz_name);
>
> Rather than resolve again, can't you store the reference to the
> memzone in the priv pointer at probe time?

Done. The memzone reference is stored in cmd_q->mz at probe time (in
patch 1/3) and dev_close() now frees cmd_q->mz directly without a
lookup.

> > +               if (mz != NULL)
> > +                       rte_memzone_free(mz);
>
> No need to test for NULL.

Removed; rte_memzone_free(cmd_q->mz) is called unconditionally.

Sent as v3.

Thanks,
Raghavendra
