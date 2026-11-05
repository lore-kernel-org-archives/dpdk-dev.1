Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF941606A31B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LoAj/Dn1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A93E40296;
	Thu,  5 Nov 2026 08:37:05 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63]) by mails.dpdk.org (Postfix) with ESMTPS id 1BCE240288
 for <dev@dpdk.org>; Thu,  5 Nov 2026 08:37:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWe1CHaCdo6iQhZ51DsC40cmhoKeioVos/jLXh83lKNEWVGRMcJUdhCNJyko6HXg1nz38xA1LNU4f72tj14jgjchN5IGBs4t+m+ckbJ+auBuPSv5BxRhsQt+XlBNM56XmY0qpG+lv5/xtZYpqlkpe8JHkN03dTtJd0RcA7cISybR/gcAQYA5P0uyPyyk098TcPD95kB+nSKQIRxnSCzC8dPNNZOdtj8K3BUyBdLBjWyfxXTv8RQBSWtTktitU9u9zTRHmo5KLxtn84nxkGOyz1wbRKlCgGrwDU43gy6ZfryM1yYqQCOR3hlIhtoS9ddNCjh5AUXV5kDHR0bJgsuVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=PYIJCk9LKP67lP2v0jnfVcBOW5IMV2Z5ocCsR25S6bNBIQ7CxVHqiAtzGAco0ry/XlSfopvGabcr2J5chVZCRPvo+fYvryoDHsKcuTg2N7z+SroDNXICppVkPMxOmQFAb50jJkA61RIOFUD+ZAMi+LiHkQhDZsw7xeb4FlF6h2OGo5aDVA16I6ngbMPcOcvV1Ud8BYIBlqoC6uxsUTQhW8+P1q7O15XAH5crXT/iwGvtQJ7/puq9zXhOid7CYxmYKaopSZfIp3seFDVlofdQSOb4ej39gamaO4XZMFcqcOBlcyKe4wMjyb/fizA9zlacJakO6sx102K+qc6f1C6U8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=LoAj/Dn1p0usoKEqRHO5WwqA3ySzpb/5W1EUol+XHx3cp+1mWKqrT3eDP17EwGvaaiGqga9xWtfXDSw8otC2t0puMDT3dQHwtmDTW2p4ZKwHrhigG3PHGqRS9reH766UGIvsr3sENMaX8JfFrYNJvYeX7KOgqQuvR/k1xToJ7xbpYzfwEAY1TPRWGLJ5o9dMyvu++cHuDPu/aybVjqSSlZ4LcZHZPdT9ml0lJMml6A868e4rSztZten+d6sl99HB73Va15wTZ9ur+rDP3oGECavRQLosOIoKP8hfD64xtZcskLbc5PUTfAdQFaUodvvqxhxSji3/JGCHH8iwryf7Lg==
Received: from MN0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::16)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:36:59 +0000
Received: from MN7PEPF0000014A.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::1f) by MN0P220CA0018.outlook.office365.com
 (2603:10b6:208:52e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 07:36:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN7PEPF0000014A.mail.protection.outlook.com (10.167.254.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 07:36:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:36:42 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 23:36:41 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3] common/mlx5: fix mkey ordering enum
Date: Thu, 5 Nov 2026 09:36:26 +0200
Message-ID: <20261105073631.20277-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026125411.2973829-1-mkashani@nvidia.com>
References: <20261026125411.2973829-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014A:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e7bd8f-9eba-4bf5-9435-08df3b0f9366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|18002099003|10067099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 69uEZFUhgeAfnn9x29T77M+I5eeBdPeOwHFSmJTLZGeUlK4AKOmGRbVu1waHJaqFuJOY98sps/JpzjwcIaHFaAwn7ZG1wak+flHXtQRuYGOSKsh7cA379LjuuGs6Zwv5YjnonG4ApwvHRdeEkiEM29tIysNnR4tlAmz+Z13alm7CPlhla3bW6QY6L/qwJ0GxdhAex3ycN772DnIYIXdjTFyGZOzMylPpo8BPviOY5AITRsDqkmm45EcAz6VYS6uy5GSDMJVjg4Q88SDU2EN4vevKThToNVkvM1lSWekB2TWTEwE99ts6DxE598BuS4dhTKLZSTDz1trnRX1lRlaSx9K2fThvSMUuOUjPs8b74XxcUQ/J/mWWLbJEz6pxRQEd/GE2QncCWejLCO70gIlKgdW4St8A9rcaOgC7sXpou06Bgeo/3jJ3qyZN3zOt3yq/GmmTgHsfY/04xlvsGV80rRXfPjpbnpfC6T10lfOqz976vLMPYEyyWEqF3lmzcKOn60mGCYTa6My+ilJFrz0Tph+d1tNpTWsjDyiwCbRx9IJ/4gTPIJ22sGfVwaLMcggkBmb1YsteIelfiDbQundjkEM7t6117nwqMTQTIqwGM9TiPUpCMhIwiBvqawA5lJGznizA6+hBsqko6JdN6VqIWLb4o+iLBici3DFycwhnz3IrdtGbcWmOkN+OE8SumLd/4LnhkXvd3SZ3D3/DtI9M8w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fAJ5WxQoxJOyBdvORch+t9iHnNWC5hYvuN/fUbWSQLTKP171GMcdV/euLRHMeL+yo4r/lf672rhD7ompS7KAHcU3s/bI+VT4czTLzeXq7ueGPMkCPglEBjDyAWxAXQkCMd++fSRhEDyK9/CqVZBuAqxpYmvwiYoFEX1ii08/TSXZejc8G2RJ7lraQvuSnFKVeu8XjpiBihOtQ3yUpNh8y7sGJs8FMoWlpqdHlsV/Pkd5B2pQA8oWj9wwPICOxO/8jxDIIX+EzqUE1TN1mySAMd2+lCWgD+bsBu+ru7nA923N7oILm9vCfvZtZYJBK8jiU8f2p+9GfJ2/eGdalwgZ6h7QsXvgLydTw0i4btqpZHVXuQq5qhBMy9G5ctPGHZXEL6fI0UydPfWvpy4ro7pnXMmjBxBp1pp16lVLKCSTJWMOST+RXKg6Ppy+pbUv/9Rg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:36:59.0557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e7bd8f-9eba-4bf5-9435-08df3b0f9366
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN7PEPF0000014A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
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
