Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F85606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I+Be3c3h
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58BCD40DD7;
	Thu,  5 Nov 2026 08:39:02 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51]) by mails.dpdk.org (Postfix) with ESMTPS id C8A2640296
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:39:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3FK8wu5XzkO+t1cC3SUlwjmhK3aUTwY23iiZLeb9Aq4ZFKiU7gIYLXYQbPf8S8sABkilKKRrRP8CEfn1dH+ek2bCZiNyIWpcX0VfYxpV0OEvPaWaCe/ysZG2mrWt6dcgrI+VaqN7/yMtCPOPfAOdS8E4J/FmWfl0pKI3tKKK5FOxPsA3hS5NFAbAxR5TfVVcVEYst4S69Brg716ly4B4e2NlQ3helcgsVuzwelhMQjpIh7ZGEPeBNHeo5IvX+x3pCnDcoG9Ex7OjljCFjLlyJDv+k75bB1ozvenVCdp7c5bR+u5ez3dT3Dg/UF+NQN16D2UEo8D+Pahg8KBSJyMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=u8x+v1Qc9+L5ooxdO+FUCBbViT86svwDEzZX0MYtYBF4fANPAl5eOjOikfGIu3FWvcNEUCyvVoR4PHiKOt2xuy/JEIcXTR/WssCkLpSpJfQai7cF2gP2WafkvpqVa7LSBd5LdwJyUOmIsxSkRUxx4zeeO/SuAoY+7PQgOK0kgbo2bHoSfXw2uYJOEi2Si1rF1O1+PnprcvV9wsKx74JZnchbJGrDTWv/xnUsDKI/aBmYRiCjA/MFVDWQQ7QUFgVcPiyIfi5Wx6zZcCq1TBs4QYKlaVumxPWqIlWNnNkSo6F/aRkqa+sfLkPUnvbEu2It2+FYGPxoCDmZ0Hc3gXtxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=I+Be3c3hIQPuwG6QJDv8WwvnPVaux8YaeshLh37z2vVnLFr5XydFM+lsyEtpLgU+K2bZS8IY8Ctcttk9GMd9GXtCFLE+gMkuBRnzdvz9j1r4lV1njWIqusn4iiTUIAli4hIaQA0MemYLIylsoZkcfaBltEw426wXlheeT3E2phfCAHPaBE8Zl615EdCkR62oI1XQbyGsBjUCKB/dERpaFkYA4c/yNdPn48QyABMftbBfIo1bpR4Ho+ip2nGgqJp8Aom5q8oOfPowsp70J15vUAq9vty0VeuLzASmo9FXdm3B4D2nxNX5F40GLVUz2spxkT7W4o4KERC4t4l9lO4xdA==
Received: from CY5PR18CA0060.namprd18.prod.outlook.com (2603:10b6:930:13::18)
 by DSVPR12MB999259.namprd12.prod.outlook.com (2603:10b6:8:423::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:38:56 +0000
Received: from PH3PEPF00059616.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::6f) by CY5PR18CA0060.outlook.office365.com
 (2603:10b6:930:13::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:38:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 PH3PEPF00059616.mail.protection.outlook.com (10.167.243.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 07:38:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:38:39 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:38:38 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 2/2] common/mlx5: fix errno clobber on interrupt FD clear
Date: Thu, 5 Nov 2026 09:38:23 +0200
Message-ID: <20261105073824.20540-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103112525.3432332-2-mkashani@nvidia.com>
References: <20261103112525.3432332-2-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059616:EE_|DSVPR12MB999259:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7c975b-eefa-4d8f-8107-08df3b0fd928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: slLdPr3CW94/FnM7z5SAbUY4Ts3I1egPPZdUkJccrn9/0VqI/kBrcY42ioqZPKByG1OZXi3U5Kgu8uwEegGRBfJqg4TMiEr227EbJtCr0pRRakgSsFIqd5E0kYUrMfq6/AzdhiMc76algTCduK5XaXD8IJTFVJG7N1Dfk8ku012fy+Ne5NtHWDxzK76rr3KJj8sezmElPC/OgyVVHPyq6eQrrjRnqvNRyifP9hZNEWMgRQT4TF8pQdoA7eKmO8rCBWNcS4ULpyG9JiT4nK2Xo0+Y/NGrsY7Ndrx6ojqsPfvpK8zOrgYb6XtEeZrca7wjtIFf9XCOmLTZHM5yobyRPs2qfOWHcFxglcH4/e4+z5TT4tBaGHePbGCvnL6SxMHtx2AV6KXcoCH/OdmeVoobH7/o3B/2O59LUTRkM+/qB/P5zaIiLc+wKTGt9aYwstHJettKZm9A7WrbKAxNt8EqwfTLy1l3iBeJXmWcTRlgMOjyyk4GpOpk/4fhaNL6SPR2TBcFRJKfS1/h2+/Pq/1+h1oyqpE12ynQ2c8+rPJw3XpwnOrcWOvLFeqsFbIr2Gl9tm5uBTpAGKBpyq/npvKUyeCPCJhcaYhzLXbzNx+hBAcczqjPxqN96W0tjFQ8PuU5jG6HeCDHPM+rD9aX121f+E6A8htGlJ8rnzcfAmrbwUrlz8KvcrLJK05SybpVR/faF4yI4NJ4+VSRTU+FUHg13g==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S1vJRJp0s1TtZlzPYzHSranVgnPGtFO+32Ar6GJ2zcjt5v8ubduDaDIuGZR6f6m2M0dAK2fgWltH4PMNkVofiH7XZP5Rex1H7MMq98+HShfzwxmIQtzehofuwuIQhfGUPUImJplEPmgt3d2CEorEXMKfkOS4ISRDusYQiJMjlxvqnUGnAejNNk470BhiGsblQmTYC5qZVGBoLvIo63jiDv0lGOfNNWKI2bb7MlLz7y/1RpJH7o4Xoo6xN++WX38FNltyAy1pNCSGNsOgxx1ebVqRA71bN+63HmR46XMbkJuixWPHzA+NChViLW+ds6UwVkdTsFvwFdJk/FDXI02BWHRwuMtB+G28Z1MAdQNwnMoVgPGbF3pOZtaRL6meZqYqshp5S8DngUsirQU80CzzikNymDNVcXR96cnEbm5TyjVcMpI7ay6RFgAZ12j2fpN0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:38:56.1895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7c975b-eefa-4d8f-8107-08df3b0fd928
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059616.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999259
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

Patch applied to next-net-mlx.

Thanks,
Raslan Darawsheh
