Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC51C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 11:01:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BF7B40289;
	Tue, 14 Jul 2026 13:01:22 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by mails.dpdk.org (Postfix) with ESMTP id 520184026E
 for <dev@dpdk.org>; Tue, 14 Jul 2026 13:01:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRHp9tfK/PndFOBq+ka4lOvEw4Y/sK1iC8SyLNNNAfBToTEEuoj4+CYWdTZ58LupyeY/AnID69Ypb3ObzjfLBc54lzEpXf5owcdIXJCy/7ywRvSEI2SCmuOoFt5JJK/AGuqDg9lnKWdiVtmgGlc0F+zhslDDZrnUw54N10bJ0/z1J6KMoQgTH+NIp4a+PlTpb6MsdpfZ1iTEW63pP/fOisR2k3+NIeW+7gBhmb79YH2Q4vf401xJVKiN3BCrm+Jx7oSgUe3o1yiaI7mfuyUdwJpYrDzBQc6wwxSaXclDrVzk3wbDKTIhytxfqy+W0ZbaUMk3Ev0pAzRTguzv0t88nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG9LtOxIwNtZ2PZKP/wnGm9NsxMD6PKn3EY1tWgcNIU=;
 b=qk6DtZrYEid39OV9+NLpeJXZISwHDvP1vSXQfnRlW9HTrnEyD9S5HTG0YjIoVBNrEj4lhJu8l2W4f1z8+iQ2PJM3W/JtAGy5/ZeYAXyhle/BN3oc7vKhEiB1w6ktEIOUfpNUru2xOp35BGbHqYZPXGDzeDvSDvK4wjl286YPYwDkmKcmU9j72Nb/ld9U3e18sRrgbwuxnG+Tk0i0lWvTw3Jx0zFZvsGoamAIcPoVuqz+kQ0bTDVQUm1vfLZCCHNlhmxINeGnWwAuxbMRc6RfGSeYtnf44J3tKOq2gz54Zg9oUmrShQUVVQDOgruWtNEn36EaF/6IRGl95tnM0Pqkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG9LtOxIwNtZ2PZKP/wnGm9NsxMD6PKn3EY1tWgcNIU=;
 b=qC8w4IP0QMDkGNHs1jA3SdiHsCfdXMLqCt6BvUEAogpgYeThcPIgNDF2nqBdiFWSOFJmnUfmyhl1OWEmOsJhe0uRakspMtixT++zOHSTn+3oyT8JnVhH38riJCZe/3F2NMnbx60fCo2RSEheP8JV22tB1YEd33Z0ZJSSrxnobGs=
Received: from CH0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:610:e7::26)
 by CHAPR12MB999249.namprd12.prod.outlook.com (2603:10b6:610:300::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 11:01:16 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::ae) by CH0PR03CA0231.outlook.office365.com
 (2603:10b6:610:e7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Tue,
 14 Jul 2026 11:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Tue, 14 Jul 2026 11:01:16 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 14 Jul
 2026 06:01:13 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, fengchengwen
 <fengchengwen@huawei.com>, Kevin Laatz <kevin.laatz@intel.com>, "David
 Marchand" <david.marchand@redhat.com>, Thomas Monjalon <thomas@monjalon.net>, 
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>
Subject: Re: [PATCH] dmadev: clarify last_idx documentation for completion APIs
Date: Tue, 14 Jul 2026 16:30:43 +0530
Message-ID: <20260714110043.3424477-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <alXt5X6MsOEy_5IX@bricha3-mobl1.ger.corp.intel.com>
References: <alXt5X6MsOEy_5IX@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CHAPR12MB999249:EE_
X-MS-Office365-Filtering-Correlation-Id: bf693da2-d748-4655-824f-08dee19739f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WUQsfEBSPT/P4bJnnrE80zunAB0ZbW5xCGzT9YW3yvGJdzIGgiUPD8NxYnoXs5LFX47BVszr5fKXbdQN6EmsX+F6cTFSlbyEiyT2er8y2lHS2UVIF36WqUegBNJsifteta16Fh2zBN8fEaAF3y5O52GHqqY3Ps+MoRP3ayNALfDpBxm8yTNoq05UY/jwGSyqMLhxR8HaRdDfZeEvluqer7aHAiadY1GtVWEsG4uOulP3LBVn8MXgYbYlNejW2x7/ykjQoeF5Uxyfsvin3ds+wo8ARTPa3VrRcgVq9oHd27Wa98JGYy5SwbWDrNwV3lMMrqj5q69+VLUFWMwtICAnoOgDUcCW1SIaqiAVw6T8PUX4EN+eOZtf9HBZMH4BPSCQbIkHt5xm4CR3wJpNITb8fXQMMFlUdbsQe9ocT1ktAUPfhbjdXWRrNQ5u9ckIPuh6olFOwOAMTYr1W4oRADUAYO61sDAqaJdfayGUflwduA1e36UfDPQJv/Kq9BrA8dy1QwKXBV1/uWhg0EMngl4PYN8S1rnawPGocO5/2/WX0vnewpiDYuUhsdQiwXdccOD/hlkIKRXwh1UF7VMBz6aeKY0CpyiPT0Ljyp7kflcQ+2jDsFWeWZlZo6wjZmY5oGCz3vJGXsALaM7uOCT84cK79NRr86132rQjorpb5/QNY3lblBCdrgZ/LUd9O7v421DrRvihiCpZDGeqX6kzKgt7aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2CE8Q8pvvL3sh9A41iBHXnf9lXvfkZkDbpFxWGtitHqtrkOYiRQxrwjqbIVcob4cl1qCPLJeW/LpT6322o4VGQ8at+CA6e0W7fEHr3UYgRqUkNFK2JibU6ntfNkRJ4EyioYT+gzCA49hAPSDzq6sxwHkPTYf6zi66IJLdHDXyGkYlSsbetDhB0q61PULea0w5Hi1G2INw4Z7hyBMw1jZqDfabdcYvdSb6Y97i15lIeF6IAfLNI3pN1qRaiH794mGCrcCw3kZBvfkE+jH+LfoKNqxv9RCmlKpFeBQ4xoMw7kQX6nViKUUU+Y4aJZ5+65uqbgp8SVXoTH7p1Bg23JyTmRhc4xp4ROvX3BS1z7IlG6WKyxWPdzBtUm0WYU05Te5ex+wS2hymfVAUOUVBoQKr7qzX2aQyLGiiWqw3BArDHRYhnnkzv+/qUX3Dw/0BuJR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:01:16.1831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf693da2-d748-4655-824f-08dee19739f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999249
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

On Tue, 14 Jul 2026, Bruce Richardson <bruce.richardson@intel.com> wrote:
>
> Just wondering if completed is ambiguous here. The index is that of the
> last reported operation, right? So if we request completed status of e.g.
> 32 operations, but 64 are actually completed, we only get returned the
> index of the 32nd op AFAIK.

Right, that's correct - last_idx is the ring_idx of the last operation
*reported by the call*, which is bounded by nb_cpls, not necessarily the
last operation the device has completed. And as you point out this applies
to both APIs. How about making that explicit, e.g. for completed_status():

    @param[out] last_idx
      The ring_idx of the last operation reported by this call, regardless
      of whether it completed successfully or with an error (at most nb_cpls
      operations are reported, so this may not be the last operation the
      device has actually completed).

and the equivalent (with the "successfully completed" wording) for
rte_dma_completed()? If that reads well I'll send it as v2.

Thanks,
Raghavendra
