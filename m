Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B115AC61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 12:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DE7B402EB;
	Tue, 25 Aug 2026 14:18:42 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by mails.dpdk.org (Postfix) with ESMTP id 4C4BF402D1;
 Tue, 25 Aug 2026 14:18:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsH2cyPhic9KX6+y5YNPKSlMOjCDYwH9ZuQEn7Spo28NV1S4oKVwEEdM9yUJNYhMUVJfojltkQFvx5AtCZPFShGI4JqPpNdfzk0YAL9J8CVMmi3rysHXKXxRzztAiQSqyx1elveOE5hc1rr94LWufoBBvbU0ymAdC8GR5lzTB5HPMILlW0Yv6r3HqY5+kTD7o+3J89hCxS4Kg+32MHF+0Ni6+9yYzA/PnK+egOk6060T0bA7fdQWOrhDvVwNi38hg0IjPf3p1y+L9EMZumSEwZ6GtfA2/BBKxbWQkGiqSH2DejT3meOCI8XaquMfLjalAX/Vy/qEzho0GyD5IKkUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SK+iPA3SnTGJuUWI96B82pGfbb8MqYgz6+s4CCbMgU=;
 b=Ss8UoD9U2Gx68eKVwwqNeByMc1oQuO/c3NtEEWvhSgOAgD9Ztof3bwXDd0boHrfS01CCfMaLHGlNUXKdoYRWp6ZHvXJ/3JcuLn7SKH7v7QVgJpHdU+CitPqa70GI3p7N606M+8Blh3rW2zpWyFwYYoDSHftrZollxwkOaCL40uKe7UCg0fyNxFXXrndNG/dvzS2dCDDxhABx+sW1Y8Rye7h1wT/r9E+J9fdf0FPN5nNJu7ntgiyZz6LdOUFhiYNd94n/YjQL5Ss1OpUbFTrkzZLuUbbPYNJava5vNY2qN8i/zsQx+tbxTtvVXoLDC8S2UYFFXhfSr86b1Mc+PJswXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SK+iPA3SnTGJuUWI96B82pGfbb8MqYgz6+s4CCbMgU=;
 b=ivpXlJGa6UgAlKwlLATE5E/30xrdCZYmv1bKx632xRsghdTwQXtWlDzP4tyQ1w0Uzy+fUGib3ae3o4zlVVwAgITnQ4h3Fd1VgVc0ocxKN3AzgujQ5BKa0TVYLj9qPD4zykGZROi7LWWiWgjEzmIypfiAtt4SLaRk6sQQUQg99iScK5AUqx0MGU4DBKzaUxh4GynuJQaqE0RxFCyXIUeY33edIPa3M0VwQbEgaI7NWuYaQuUcjKvjogo+dckONQf+B6Auz53OfluZ5BlZ34ra/uG8od5rxfjWrZ0IGPNMSLBO69txEu4JrB+I0xEkT3qBaCN7VILmZoFJd/miqe7owQ==
Received: from BY3PR04CA0011.namprd04.prod.outlook.com (2603:10b6:a03:217::16)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 12:18:34 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::72) by BY3PR04CA0011.outlook.office365.com
 (2603:10b6:a03:217::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 12:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 12:18:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:18:07 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 05:18:07 -0700
Date: Tue, 25 Aug 2026 14:17:59 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Adrien Mazarguil
 <adrien.mazarguil@6wind.com>
Subject: Re: [PATCH 11/17] net/mlx4: replace strncpy with strlcpy
Message-ID: <46rzzxtx3xq3bd333wlvbqeehu4kvssul4zp6u7qxglfgalsle@mapplwlszugs>
References: <20260623165150.765443-1-bruce.richardson@intel.com>
 <20260623165150.765443-12-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260623165150.765443-12-bruce.richardson@intel.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: bb558097-c2aa-4e8e-8c41-08df02a2fb2e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: UCWbm5i/6fMb6e9WUkVa0FmGkO54cl6muBVPIWHGBSTVrIuqvcShTWN2NAa5PKmLVCL/wqx4jbb+U+dYWjgB+s3ZaLl4P/9L1yP5GKe9wMiZlhIIRtaOPT9xi8pBbUPiXMYIZhCX41X5sdCR4ZlBVIBv0xeXS9BO7bNdwXvTmEru1Te7PldP1QWSnBFOU21BGzX3gBhcIuAeF1Q3GGpLWs5M+3pBThy42ypKq+5fObqIqCg+abBywc1OTNbd2w3HjLT8heaqrYUZQel66EC3W2Da39jVAfRvLU6MrIdOZcUy9Bsja9RPOT31Ix5PZ3QDjdl/QMzlIgq/6BrenV1XmP0rZiUHXRyYZn9HjqFnjtnfoy6jTQCDFrWMKvt5KGg/2CSy6AOLY1sSfDF7K4U8+KgpVUBIoSBviaTZBIwwFTva3fVuwHOu9qtNYO01OjVw7Z3yo9ZC0wI6t9IKaTUZNTsHFBKWCpfChTQ5nWead2BDnlGHj9DWyQlYLMtx2KBNzTlQmparQ6qHbTDv+l5JVs+40Frv6pfC1qCsHBI9xnUxgooAl8XivKkuWoKpP9pM3WH2gI5cqcynXs6IpFE+6KvKGftQ82K1gajJWOaLKfMyu3QdVNCE/y/ebhxorf9SnVtOnVXJqHWMIRggTKuzjMQs5FoQMXm0ixzIV21/VkytFxDI08vx7VyDmZRohd9vN3QW1x0DALXUIbrgYRUKYQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hj5zJxW81hQV0xBJknucxpc1zJNRU0b/wubB40JAOIjawprk9nNOORY9hppECqcNRpqvjKYcLzjpOW9/7IsjogUlZn5W0Hq6So6Uort2pi+cDbH5KwdjFB8mT/rcnT/83x5z7GKN170w9TZu7oW+2HRhsoZxbN6ansJAv4ds8dyTpqCgHFdZAux+ss+OfhlpFMZHqlRXjAzydFNRpn3hgQ7aQKNdB3LLc9He5XXjTpge1wv2xLKqcSvqVK7GrYOPaH9Drjd9RlhEzt93rNY9yvTux41MjHFXIsUUlWmMBwGX5rr/qyvFoVVUIBcUOmmEn6Dbw0w44kt8TuRwbIdJfua6v4xACzscK0NgwbY+AjHAhu4Ej/nrTCCDhuHa4SReZBIqu7LOCLb1bjagaUcliAKzA6/0UjQ2up96dbamO5U2sMw3c5kMGWIe1/xzkoQ7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:18:33.0993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb558097-c2aa-4e8e-8c41-08df02a2fb2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

On Tue, Jun 23, 2026 at 05:51:41PM +0100, Bruce Richardson wrote:
> Replace strncpy() with safer strlcpy() which always null-terminates.
> 
> Fixes: 61cbdd419478 ("net/mlx4: separate device control functions")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
