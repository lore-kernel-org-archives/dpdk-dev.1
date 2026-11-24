Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA28606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WplmiNIK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37B4940612;
	Wed, 25 Nov 2026 11:26:16 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012067.outbound.protection.outlook.com [52.101.53.67])
 by mails.dpdk.org (Postfix) with ESMTPS id 2087B4027A
 for <dev@dpdk.org>; Tue, 24 Nov 2026 18:25:49 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY1OL58R3PRmhuezFjQzAdQ8GOCgKz3W6tmHJ4KAc1NiyXTC25/u2jR5TNdrkvlPFR5T0qtEut5jKPkzX2NqzirPTtHAQlit41fKKdfhPZXwnRIh7iakzleBsJmXXbhD7gcNDcWmC55mZhsEgfRJmglMHfixctAHlGWVIutKu3xfkeHbn4qxd/eAbmIbo74KIyWJHRWKEbsV7ZiIUIbT7j+BAggBWZ++9ydFxo0uHur0j/3XlRJEtDYOg6CapcsShez6Uk3ssaXHcPyk3X3IsGPcAlaLnqyzJu/ymMrMQk+HI2k0A9fvT/OP9NfYi5kbpS3W4IXx7RgypXh6vrl0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKfmeKf6XwWZ+uCiJvlbJ6wJaq8lD6WI0gEaNrqcLrc=;
 b=BaCL4mx1ooivFsJr3789sZEmwaab2955w2TkEX/axwvLT5/weGFfSTX7keZied9k9kjDXAHuRXpl8nuL74+r0GeFZf3t5gKHLs/Qu5a+V27mr93xI7BmSYzans4nWl65vKtUX9RYEHdum5Sx4+kdpbIxfMH2Si9Xn5Qz3wWN+m1jNTXLb+5iPRdEx/34jERTRX3DfsV5aGJR8hitXu8YotmJMTWCSbla2FoK7DRuQ8nudSkOhh04S1x1nvwv1QnN4wlCFIRVSmbsCzkm49/HnVTsKi+W4dz+7NrWk5fl9k/IMFyq9Kw+j2VpVgPH1XlwzDYsGDg7GT6VIpS1FuNbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKfmeKf6XwWZ+uCiJvlbJ6wJaq8lD6WI0gEaNrqcLrc=;
 b=WplmiNIKNzMAljSmsBICBR0Q4zeZTP5gIGdfEHj3/3MqWGRXiR/Mo9V8nBs3HR86VZZESghV05DgC1Lc170L2n7EDe6TBIJoBgnmx/rTC3a9AZI0vDpYQNW8jr68xHTpBp8rN7Ut9fEXTs1lokjtHrUupS+J0lh7yDpuV0tCNkI=
Received: from CH0PR03CA0104.namprd03.prod.outlook.com (2603:10b6:610:cd::19)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 17:22:27 +0000
Received: from CH3PEPF0002457E.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::8c) by CH0PR03CA0104.outlook.office365.com
 (2603:10b6:610:cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 17:22:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0002457E.mail.protection.outlook.com (10.167.252.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 17:22:26 +0000
Received: from cae.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 24 Nov
 2026 11:22:20 -0600
From: Ajit Kumar <Ajit.Kumar@amd.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>
Subject: Re: [PATCH v3] net/axgbe: wait for SFP cage I2C readiness on first
 probe
Date: Tue, 24 Nov 2026 22:52:06 +0530
Message-ID: <20261124172206.664512-1-Ajit.Kumar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123115224.2199549-1-Ajit.Kumar@amd.com>
References: <20261123115224.2199549-1-Ajit.Kumar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457E:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae72372-9176-4f7d-f110-08df4a4f82e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|22082099003|18002099003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|56012099006|261022075727099003|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 32neYVB6Bi8GAKqug14vGEXzHef6mW4M6K9HMSqUXBTGChJ1ojxhfd+B+vDW18ae4npAJqlactPyG7geb/Npq26D8cnRnpkG8YoWCVTTg/7C/ssU6LzXhbFJjHX1BsDemnzyLMGk8w9GytzKx/q/pdwBlWLkXu3hO6FSLwNRsMtR34bZut/tSsbjh9i/2UodFfJwiJ13g+bsOOdyiz1ZxziXgoGTJY/gZ0GrXZgKqWNaI3CYRcFd+PKStTuBideYJhMSJFGLew2S7OzqeXqoOtP7//CP1xraAIHxCX5GGpk9ShEH4AOaQ65BP5P2OniV84y6plTBvSxqfnb9ksN419Ust7q+s0tw48+1kjdvLsrHPy/JM4NCGa+2X3NS6kxqKnLAp4dZknmUowDdCo8szwx2g4odoaalVg//NNCKew/zowlsBFAITmkyKXgh5Z56P0GtO5KfL+rq46/LeRdF2bFs20bN8k0Quhi7qSpv60TE9xUlHX2QkIEVRXo6RsqjjLVz+szy5oBjk50dYvbUw4QejJpAMPupLFQT+7A1bRDvZDtOcLhLZ/JPmBzilBPTUlR/7JbO9TF5RzcrvWRd2JOSd4yuRAVeHmqdPRFVhy+MdrHzttVaWWEkAIZP6yD6z1mF4mab5LcvvubMgJP2XlSf6q3RYpdB6XeHOBkCjqT1s96BGY28gArvGixIEYDMkJzJ1w5e8xOv19ISnNNIVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(56012099006)(261022075727099003)(10067099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CaB2RDCZDM2H0t4EPcxXrXp72mlp5u934QUSFX3v1LxJZLUTqimaPTwmwMU1UTBwEIYl4hXJ00rDOkxaMDxePfdDeZ7M0Up5tWTy5rDkNsHJUm8DdV+YPK19I7NE7D4fuH/STgUOUBGxhzJgKUDb6E2oKOH1RFy6XzneiY9v5Aw8z3G2Ksg0G1ilFLUdxCMVcXMyQ568AZW6BanqovsD4BSCCtSFNwq9ewmefJE8MMlUSvU8b1paVeHZjHXMABZZvcGz2OZxgMdeEHTREturs1ucCnroWi9xuYUcS3AVsCn0oNsNlfg9bsrGgZTwvCAMlnGjJiIPcmlY76D0VASC/GhI1UhLdtjn9iqEDhqkLXlysiBw7oNoFIuJuYwkYUdETr3f+6E6Nb93Af8o6h7s9JfaA6aEI9Eh0kGivvuVU6j6ZasA5ebrtMfp+OU/7ETG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 17:22:26.8195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae72372-9176-4f7d-f110-08df4a4f82e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0002457E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
X-Mailman-Approved-At: Wed, 25 Nov 2026 11:26:12 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ajit Kumar <ajit.kumar@amd.com>

Follow-up on this one.

We had the customer retest the exact scenario this patch targets, but
with only the already-merged bus-mutex patch applied, no retry logic
at all. 30 iterations on their hardware (Advantech FWA-1081), full
driver debug logging on: zero I2C errors, zero NACKs, zero timeouts,
either port, every run. Link confirmed up on the switch side too.

So the condition this patch exists to catch doesn't reproduce once
the cross-port race is fixed. Withdrawing it. The bus-mutex fix
already in next-net is sufficient; nothing more to add here.

Thanks for pushing back on the earlier versions. Better to find this
out than ship a fix resting on a delay value that was never actually
justified.

Ajit
