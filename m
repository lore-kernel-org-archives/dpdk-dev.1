Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A3AC88E53
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 18:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76357402B2;
	Fri, 11 Sep 2026 20:30:45 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by mails.dpdk.org (Postfix) with ESMTP id B68294026D
 for <dev@dpdk.org>; Fri, 11 Sep 2026 20:30:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULY4cFtnnLoNd7FNvfVtfE4rBKJqcmOR18iUhVTmC0nOHCrYRx76aB2y/i5un0nYHnCsnQsKYIBjHSiw0gC1x9xRgiy2MCvSu5VJLmIc+DCyA0k92mRVKxExYjhwx3fQOsOdByu/yK7WGXNcuBPDTAK9hLgxoSyEu+7oz3iFl+orwC2deK1bypLM7+kHOnpQVovdkywpV12pqXGd7QBlJ1ezP8mErS5O/O6p8RwRltG744zDHiiUdE7RYonR5aTmprm1l7IYmTYk0HpUy2ph/f6adbizoV8j1L2+aT3RqFBB53Mfb8C2+caYlCWcY1SNzUXQdaM0/WcPdmwKRclzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KirB0YntyjiMYe+sld1s5U+JaMemEanTYyGXRW/QPk=;
 b=WM+kbKnVrcrMFcF+aN4O+E3IeTlRWFb+iF9OwKgL8D0UaQbVoNWwJwyG34xMuS7ZbFjRUglUY8qf6pvVF0l/buRBlJrD7+ncBqwdXHJlAwhdLBGM2OAomOcWWOycldnMg8U7XopT1aHS40bcv+XnTxL8fEiug20xNFCiizzbbOUaO1Twy3AgC84FAgBKWrsJjTzFRR8qQAAFMYuwleLDsln71puQx6wyiqFlxV86ASBxf7h4vNSDem6906xVrv/w7VoMbp14i/wSYz0QhsjAuTaOrOO06zyR4++kuSaDb42sqIYjs1KmKVvFy6WhaVqBwMBECkz5U8zomOJVSqdwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KirB0YntyjiMYe+sld1s5U+JaMemEanTYyGXRW/QPk=;
 b=DxY0Lnz8h7xr+ifHdId4ifi48wR16MrlRbXYyKIKvbHHHwf7RkXS0CAbiwyPnsgiHDJwvDfB0QQmw5KJint5oY5dnuV+FRyRXE4QfYNkFJlGXzlbmJkXJq/AYBK3ClHgrLmhaB+EEeQqHwk0Kh4/MywFZ39c9XHiQsHUUClzQHA=
Received: from SA1P222CA0179.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::9)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 18:30:30 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::c) by SA1P222CA0179.outlook.office365.com
 (2603:10b6:806:3c4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 18:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 18:30:29 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 13:30:26 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Sachin Saxena
 <sachin.saxena@oss.nxp.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jingjing Wu <jingjing.wu@intel.com>, 
 Selwin Sebastian <Selwin.Sebastian@amd.com>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH v1 0/3] raw/ntb: add AMD NTB support
Date: Sat, 12 Sep 2026 00:00:08 +0530
Message-ID: <20260911183008.1646215-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
References: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa22ccf-f53e-4751-2989-08df1032c1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: miUUt4VNf5VoiYRaCjvn+tCT4F25skQ2ATJV6sJ0kANsv2LInTVZhv0BaFojSdggHAM/GeSr22nG8oVRNduTzvLLcHUsey6cRUMueB2/qOMQR/3E2gPEWw8L7qD/m+YWHdyvIJN/hxz/UWxkVWdUrU0kTP8ZbunKbfIhWvNaBwurauH89qJFR50hyKrVZObAICRpZ6HYnvh1RGZxRHnhiug/VSARB/5oc8GyXWDMB/u8cTGhcn723HxX0NqUwuwz2yISO9TmUC07ftMIL5e0EFWNJhN50cJzzHLtHTmhdCWiJcJQdDkSpwcKfTsa/fzhMekIdrpp3EKVqkcMdvWwnv3n4yYcVxBi8QAYfLBzi9Al/gOdyjVepFv7BuTEuZ8h+QYHIHkhT5SRmsUHiIeZd+JBXUivQuX3wlNFsYQmMm53CVI/4srzg0/Dqg6zdM7/IEQUsbiHj5MSvzlB/lWARQubI0pzfATQI3PI4CNKdo1ok2nups7xbduchrGPK5shKC6U0fj6XW03j5hrTwGR9JBjhZ7juPpgXA7uX67IEKa+ahpSPPtENaG2pGP0jbOlR+uBDBM99e6gffE9bqMlYugmtWJpOE48M6kS7LGBF9p+en6v+of9ZRokx/AJByIDT9gjwAx4YX9WH0VqAwiWqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aNOS9wDaovWoXwc+2a0MiG5joor8dBUWZMNFnjCe1YiAzUf/0ozuXUaarcqs/d/yOSYy6cysp+JIkwgNpcoSU7wrIqZHP4l2N20fjWCM6//XKaFi0a99UCjok11qtUY5aBHR3v3uHlAiIIkbqzOkVVVeJO1xoUzDNXIiapVgLNJpIt6klZ6+zLB5xG5f0f5RU/n50MVUDeZVbnRd8S3AHAWghAXgRP1INias2tv5SjomxEnFFOf++ROTmrMsKSpwe9V955BaqCaCZW95p1b1VyOW/MW5v4Z2Tx8gjy5dUlr5ZFce3vbXa0BjoDl6q/V+XEB+3F5SSsYWZx2IZEhgmnbip/mdaOOgPUjZCAlQK7miWFyVpg1szsbDALuNWk5pN7vir6y/5FnFPiouZayI7KkkeuaN7MVDV3t9Gs9TSeG4Nyv7HClod1EguCGLFA1+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 18:30:29.5027 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa22ccf-f53e-4751-2989-08df1032c1cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
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

Hi all,

Adding David, Bruce, Sachin, Hemant  to Cc for visibility on this series.

The full series is on the list here:
https://inbox.dpdk.org/dev/?q=raw%2Fntb%3A+add+AMD+NTB+support

Thanks,
Raghavendra
