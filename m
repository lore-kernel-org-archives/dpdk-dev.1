Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339B606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FNq9Egl6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A60440296;
	Thu,  5 Nov 2026 09:25:54 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by mails.dpdk.org (Postfix) with ESMTPS id 0578E40281
 for <dev@dpdk.org>; Thu,  5 Nov 2026 09:25:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruLo2cRqVAxCjJXQk04TlZOpaaMdxpJGbN0P5NMC7gS3RPnq/HqCaEbapfwVi46mNVcca/g0q/UJvU/xrx5uNYroqPh1bD2dp+OCsK548BshQmiNu8U/Y/yDf4wz8djFnfo/aXtxWjJEKhPCyAbrNwwtMoTW9kozQ8ZfFgPagsx3iunXQQUuUz1BHjajWK1EX751sVc6plo1PLHRJCPlY1vuqaYIALsoXK6gdDdcgUwWOBdvR8+/xf/LAbei5oGP4pa3ORvGeOFF/J8q4jzM3+0U+NUPTLYq7Mdro76MDP2is7NslVEJihc4EwKKiJlIcQbMFRYQWWOMv4LILgBUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=j+GXsqOox57vRidPOW+b+6X/W6JL3eWyR7FMhx/HSyQiVq0e9vInA2ZAZpLKikLEvLWpD58jxyoCT8+kbkJxLiu+RjemeeV9o2EFqI/F3nfHqr8hUvhcf8z2mG2KdwSbyOFeL4H0aEqodK7g+6p1T60HqvGqnKgRqwWXFlOc5GVnxy9cVDmorlwmKfS7cBzgrjmseIgc4h5dmOWymUfPYoElOf73j2FP7U1kBJP7TjElYuhNtqpyP2YMLhG3WbYLZwggCyqPoSpFLNX1koQ2GoKTJPWpq98DZy2D2rOd6QKtRxSvEFxTgcKg0nkiJo10TuqRcJ8nI357jXC1rebHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=FNq9Egl68sYNZ1RqCAySLHdhiLiXCw+UdJRf/7URxek7rVCXWdTq4dueHf2QRRJkF9/TQijoAE6rpsz4kNAKIIbvvqi4OwLIrJQoEbG+pcRe7L8Fs8Ezh4sNhhzzlcptQDbEj6Yn656OWW7AhWALv2BbcxR79ivONhIXB2nBkBA8od0AdJQ89ggjBqKwW7MnPEOOH6NgNRkm8XjFCCDJRy+Zgn9bhfqA/KXMuTLb2QjSFkNfCNHfJ0Ekl3K4sUhMEM2fbKBAj8a5fgs1IL2mgrCw7Hs+MIl+KOLuHEmH8KrcFdU5OI1owJ2BEMbRUkhZgNlVkOqKGOiYTZOYZIxAXA==
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 08:25:47 +0000
Received: from IA0PEPF0000003A.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::31) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 08:25:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 IA0PEPF0000003A.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 08:25:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 00:25:31 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 00:25:29 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix HWS sample action table leak on quit
Date: Thu, 5 Nov 2026 10:25:18 +0200
Message-ID: <20261105082520.41804-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816081525.166446-1-mkashani@nvidia.com>
References: <20260816081525.166446-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003A:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 744b24e3-fbb9-4aac-5f8c-08df3b16645a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: It96s96t+Xwp6Oj+aGtk6Sn44JKRg5+v81AZAPGbnn8XcBYT62sGJuv/FE99Z3hhwBLnF2bvs195VcD/UH+KQZdigAxFjQx2QrcgQn9WiqB/78uGKylYYge2UdTjk+11O0tnLmBko6FUWUR/vsfi3QrFm6bvcg9ixv/Z/bOtAweZs94UkKSP+1Ammz9izgq+Nh3BMEY0Zs/WrQeCJwEiVAHdkGHIA6QcTJ8nSHnF3qc0lrRBhLV7sJ7aazk5nJgYTj2GMCNEQpvLYOnmDIMqmWx/jpEbQqVs9V2oIAgp3RqNbh0riPuMN0o2Zn+laRoMjR+SZzQd8D8t+KHPG6vVRBurYBy+PQ/9ECenEdwunks0QFmETg+qORsEmsC+XHOWni+4h/TNKiVYqKASN6xLZdDaducTcsMHnm5hb5YFhpeOjkjRtaZumku9nng1ijWG0tg8BgzZaLX6SsAjCexOgrgn1OWACUxByz2PI+GcNIPFUL2xpFWrGZAMrUVKI4Pno2cm7CseCEDVNn86SfvKI7upQkuOGBKgnyfGuWzJSFimEbHbLPtkBZJa0aKeBhp1BbmNYeJEEtmv24VQTE16pca4Eitt6udE6n448B4urnofh8EWAIGwUY2H9gp+bRqdRDdw0OssyYw0YDg3+qoqIZfdgkIjoZPr6XLPo7jQ0XR8LlRWZdj8QIWf+CJEUbFwZMp+MguUgx4MmkwkzrWEfA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oz3YBzayDsLzelaTxwXvTwb2XmBS+Cb63wXyOfVEraCydwki5jr8j9Itu59KUOhci3kkUVLUtL/PTaLsDk1PBjTFxRMbVnMb7SCCGmCvBrJAUZhHcP/OZz0VBXDvbPcFY/IU2wsIFZ7UGQr7OTwQxXEeq2b0lsYy2IWHw5psGOdhaCPS6Uh+jKqs0DFeTtqrenIM1oV7HDXKkNOVNx5yIL/nd1phsBaKu/mhmfZ38w5kRpiX3RAtR5ZLSYUvawC++lKeutVWaRi33FK/efD7yoSd8t+2BeX9i+yx8Z2jmDzOa+aB6KC/kN6Un0cpQU0W5zzHtvHpVtkrUh3FjfyeB9UQWRGYcmEQA2zT0XfppmhbAELh1frkg8qnnaOs7+8wnsaoZjOMfehuSVCf4FymKGuWx5XZ4nX/Gnld7dnzFt2/dZxhjGWlro+Zcr1n6otW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 08:25:46.5897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 744b24e3-fbb9-4aac-5f8c-08df3b16645a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
