Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB5606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UVdU77Kv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D205740E20;
	Thu,  5 Nov 2026 08:37:39 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 1242B40E20
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:37:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqkbafP2ZdkxTTf1418HD7ByLxU8RlaGJu78VBEFXMA9o2cznhWJBwYgY921ztKhNTOrRChdzZoOEYNBTbyKvyw2dO1KS7YwSxQVhU7/50xxbcUIqJB0oZUtWD+K9CXZiHNyBMuzFk3Fy0jbTAPlu29Uwuyehrh41Wv/5atBc6waLidS9+/gslzhwsHXlvCJeqRUUgZM50/cYfapcGqyb1MCU9ugDIpI2CzpZA8jHpp1gpvdgxMASymcZo1Tak0Ysw6WgVAsAFzoWpPbe4uhqfLbYwd08tps+KVReVuNR7TZZOy4d7tHoP1O9GNsfaVE9eDoK8HMncdkerMBsS6Hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=H+WrAXEoVzhRIRKaehRp+vXMiS7GZo0hXoeQ75as1WnDNbhT4RSTnluxZoVUv/8FxhHWOlnRTEVaB+X/Ka75P7uHIQcHufrd0rdKFmcdLeMYMn/8YbnQVQBQnUc+j4w3/fMbO9RU9pN1YSfTFXbKmvcVgCoR5a7bzCIicFv88JetRdde+n01Z7CTyy7ZfLW2a6aAoY8hkS48k3kl7jcVG0c2u4BRzaH1QcQYupaN2H1SUZr7GVtShRel4S4F3jL+e+95YNUTkOx6dkgrdcB/6o5X0cg9NKNMYp9XXRfanQEGAj3Xq67PPguS3krNs5Vias/xw+fUJX3K4qNNsdfdvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=UVdU77KvHiC8v259rS7oOOXK+BRJYcF73UtbIOpT75gOAq12W1xAyZW74JXmZXnvquPCI/z6siBH5XPXb/UKBKLzyNZFc39w2nq4lLZm77MIM8c1PxqJ7OPjB3gqff2+/wSWrBh2tS6DEeO28Gc1ENbs9uNyHQpUVGyuD9rMptZml+EM0ld48LUKdoGlT44C1H+aBdtcIFNKco7mBfKv+NA/QsS+DZetfbElC1rcOA7V4Mkuz8JtW6BfAxhrUjySx0ABgHX56yHoTndLIn8jKfCbCrnP240pOTyrgWNIx/4rzJ501MwJL8U1frfr3V2smD6tIp43pc6y3ddjVGG8DA==
Received: from CY5PR18CA0053.namprd18.prod.outlook.com (2603:10b6:930:13::29)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 07:37:35 +0000
Received: from PH3PEPF00059616.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::90) by CY5PR18CA0053.outlook.office365.com
 (2603:10b6:930:13::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:37:34 +0000
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
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 07:37:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:18 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:37:17 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] net/mlx5: fix link status query
Date: Thu, 5 Nov 2026 09:37:07 +0200
Message-ID: <20261105073708.20364-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030172843.2304296-2-dsosnowski@nvidia.com>
References: <20261030172843.2304296-2-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059616:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9050b2-9091-4b11-d5c0-08df3b0fa85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FXyY2VPjPcZ1B9ztNZB/8HlWajiscpsERBoONM31caHqxES/HBbGA5kyNk2bdjAjjZIBz2jzrENuCXUaUPm8Iye9QEj37EbRDgAGjFkh1MeLQ7UdmdmIZqurSAZEO0XfM6kepwztx+EC3/fqqRrR5INria9Vf8u7PmFowOLVngZyb5Z3KOEMWP5u72SYWga27r0Z1GfHYZYR8UUc11mFJOXVs7PiEIzvRrnf2FQcupsZKPE5r9P4ni/OF/VE/dEaFMnU07rYMTxFxFDOw4NA8NNewqeeeoXyDcpGRMKwDoNBj5nZgjckUqLro7f8sNARgN0JHe1lNfwNXYkyvUFYx7/L8iQ0lQYcBYuSnPYwp8DyI1a1U/YflNk6gADh1wYdweEaMOY0FdkryN868JtKUpWxSvzr6mWwyKArWgODVt2EhOMfj/alxiNsMc7X5RcEt61bwdT030TaThV+bhisoZHe5s3hw7r3b/HuYwW0Y+EbQQu2tISgWU4/UiodSMuf9l1seRJa8Cnzp44igUsNciZvZjNzvBo9wF8yZLeZJizZsJZ9ei22ONlVWA8ZWeRlBB07/TaKAwE5tPfDYWZjQUaFHAsaMobFAerJNOmop1YCxne+CuPyDlOa66owGFnV+2AELVnyfsX1oVXW4ltMm4hhYl6yzGRVcWa77Wxt8hPalxsvnxRD+4Ypn4COrbCrArceAWvTQrAHPeKtxDOowA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rpruWmdhu+6gEjNEdQpbXcACtFCsWvD7wZnaDIi0Uub4LCzL5JoSSkckBgYv3NfqjL6dWRAIVpMrjppqC6y9tPzBWJoo+iYQaXDGsSOD6UwQ0cRO6tGsCZPr6OH8e/lWrhzc6Xa06TW1XJ7QlQoRAKd8cHLxw6JCuw2Y86D+2pkXqcy8ZyztHcPIwpVPaDKRvHmcwOWxaCnLamSuFsaFIugzkUxpp2KUUNKiUH8GMsJk/UzhVABIacrXBezJ+XXvaX1IY4i3xt+HVBm7VRuiKSLMm3L21lu0NiJ8ybiIvxLs9CU5su02Vtobdzc2CJ7vLDx34wdUYNSAurr2KU7G3mYGvM5Xz3JKStiDypz0a5StDrfBwbcXHkuIxlSMhOy321/rbqLoDGfN28dimS0c1YkGvFrICPzF4hpFw2YRe/2VxyMzNZN42JXLi0v1FOLo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:37:34.3501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9050b2-9091-4b11-d5c0-08df3b0fa85b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059616.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
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
