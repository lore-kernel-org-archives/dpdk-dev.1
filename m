Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA21606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lCkYbnth
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3539A410ED;
	Wed, 11 Nov 2026 14:12:25 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by mails.dpdk.org (Postfix) with ESMTPS id 979BF410ED
 for <dev@dpdk.org>; Wed, 11 Nov 2026 14:12:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4/bQEpNKVwCAgfjrERrecCVeCH66IAoDCWPPq+IJwZZDGpbJe09MQ4uE9SngqvV9S1YzeuKPOOa6O4UpJORwdz3gUvuzve2Yw3QjLHZU78zO/e8jvjCF1gKrMFWPHiR/KurByFuPd6oc4S8yuokYx+mdUwvnG7KvimrfXXb9VzHjndOixG7vnFAPAwu3RnWn1iuzboqpgYe4noM4PguimTBnmUEuU/ZrjwFw2ejlybEK/geWJVQogRnD1Mu86ftbPSi1pUqM6NNTCfCOFCQdeEjzHvPN+aGS4UthhfQ+ExCSkvql0+12GWMgtuUsa0VhX9B/zyKZC8jsdcc158uPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=CjY3jzm4MAgfvUZNPK2abtO/qX0Z1+ocdMEobsHAd3r2gAfKfrdlXprxjCfw3L4+kl4f6PjyeLH6Fp5/NshJAHrwufEKU3oPueMT4N4+BkhK4ah9f7bPW9XTga2YQE6Byr7EcJdtEomICHNtGNKZ1uE1lyGjQGEI9vLa84M0P723W1qBXXvk7Qzb3Mq3o8c9jpjaR8gzhp9VVgqMSmUocFU6ENNyNyPKFJkhaZ5VKJP+iaXyym79ZSRYC/9r+KoKKjPvZrG7intOsViXHrGMsecjCrsBg2x/m1opzurqK+YfVQPg6RRFkS0HPCfIxoBZczNSx4ito7vaA3FW4SiCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BhzYI68ScumVBR9UFCGRAfDdyG22ilsI9qdgssduqM=;
 b=lCkYbnth7TWSSAZn19xWUxDiSSJvn9GOfHR6iYA/4p98bGzWJ/AYAFqTXDNyzr/AeU96l2vdpaALIR19hOBmB+zaONN7Tr0FjTLsK45UgD0i82M72pQRd/zkwpeju6Q9gfqLua/eRsqnnBMMkXQIiX6gwdHy2NbsB5rEtJhOVYTT8l2TU6bdR7nv38/D1BbY1rAwFr2rmmzOpZUHrl35alCwQ7EPWTDbjGPxCb19M4K13PkIpuYke5wcTGgNmHAn+Kj1h2PcdXEaw4hKCov3voygjriELpR1SNj/XcryIJ3mWc0rKOLd6kzQ9hJUImEZO6Rets0vb4R7u41yuRZg3A==
Received: from CH2PR14CA0052.namprd14.prod.outlook.com (2603:10b6:610:56::32)
 by CY0PR12MB276190.namprd12.prod.outlook.com (2603:10b6:930:138::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:11:44 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::32) by CH2PR14CA0052.outlook.office365.com
 (2603:10b6:610:56::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 13:11:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:11:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:11:23 -0800
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:11:22 -0800
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/mlx5: embed HWS counter pool name in the pool
Date: Wed, 11 Nov 2026 15:11:07 +0200
Message-ID: <20261111131108.14355-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109125740.4034743-1-mkashani@nvidia.com>
References: <20261109125740.4034743-1-mkashani@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CY0PR12MB276190:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d91c54a-286b-4fdd-a652-08df3ff554ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FVKwzH6MqUbz4iZLDaBY7q96K4uwbMYKmp1m9rA+KeIcyda4A+FpnlkfRdEbUzMNBYSY6tLeXt4Zgi1B7NAgPhmXBt3bNMkvmUZkgyf6eYVvcFcAAEn21RfidOcA5kNGunoc4GcYxoqojemTMwJRKDw8GME05/nlqY+NZvgw9HoZrQceczfgn9AfCdToGvgeOp8ligihHZTSBKDBZIKkh3Wgxjz5uw08m44DcSlWrJoHRp8JcOoi5a2x3cfOASV3EUeLw7WLPTiSHI+w2DEcc42+D6pKMwK5lbmh4Eu5qDCkKjUHc/UT+1LPn3J/uqkptOewr/W8BHf8se9LT1RtPX7mtA0I/XPC/VVlnCV2Nd7Qdc2DHPYFF4ZdcLbu97h6ap2jTKkbF6qX7vnnqOqW17EUHIxAoGoaLwo74VywZ+M2W4bdncxj5m3wVBsRsyzR7Us3CYwz24Fiec4lXqtEf2zUtjW3OPOYOojczxhOxpUZJ2H+2gMGv/Sy7vpYZwUin8eI/kmCuP5zJhcNKd2adw/y18PUl5PPtgPVLtW85z40Kz7xilpWs5KyHyXad9TRU9P4Ovwsmy+CUSHjGaY+fmMNzhhfw1Mbk+PaREwodXp+PxGJIITBY1rJ3aSiCITsB0y69szxGJmRzdIyQfkgDMtwXc8SszBBWVwIenkd95ArQ/YsRgBiAAeFZ2tXzb5RdisaHiutv4nLtOUoPqKsLQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ctlpDi72jnYCvnqPDUB7qQA2bcCcUgbjWvIDxQD0YwIclniVEdXVQNkxo7ijSgEjvlPdaS65u78+RjTZYNmySlG05ol8hMemeywAQ8/Whz20bkCkGzoqIzwBnCz8M1udBJnTjuluuGOeDlp0mlJ8xtu3SijZiyW+MK9AWFZNPPu/XpY104NzHtWlQCreJxvlGFBuYUxJZX30XK3tLTlP3C9GWPf/FTkG1oVNo4m7MKF0BldCqQLCpXuWOZSJAvkIpuBZwaAbiSaPE6vUneu+NQKyErqIfSe94TAzK5V9oOSoKg4T+G+Zj85REScLgqfi9s+Mv5U2mhFxnqr1+TqWH+y14K8mLd14elRGxL4sa5XvfYZEXZ1wXtgOcX86uCIawX7qH7qT0YpGymf+fytVdTkBXlyzsWKyxT/kQYxEC3N7XcJgXTqnS8cUtaBaRuuK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:11:42.7911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d91c54a-286b-4fdd-a652-08df3ff554ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB276190
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
