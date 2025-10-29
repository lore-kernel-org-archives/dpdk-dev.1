Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F030CCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 13:26:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9F0F4028E;
	Wed, 29 Oct 2025 14:26:36 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by mails.dpdk.org (Postfix) with ESMTP id A4ADD40288;
 Wed, 29 Oct 2025 14:26:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMH2sTsBXIEeDEkdVFXrOr9mOqeQ2thdbp/d6KoGdLY5H740SupLkel0PlQrLU+kQJz08mk9E/yGVAmMwhtDofjS9E/20Z79HPU6cUNoupiTB7CPHY/JDY7chOtq/J8UyN1HIAqCOYYalMP0TYjymqfCuYaDtIravmnqM1unt/o2dNC5GR7mn5R+9npTM/hrchboY8D3jzzFzo6jvf7ELm9ZU3AU2cRo9lN8MlrKgF8y9WLAGUB21PO8+sLWQeh6/EY0skGAlp2NrG2RRSKx6iPk/jkjPWMpRma+hw3XdeORLl/GHl+DwZocE5RFQrmxRsBZqfUwRZA79g83GslqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePr/vjohnzjPo9t0nUDIaV9z2Z2JdKEbk1ha6MuAOXQ=;
 b=ZBLyJ0IXUCqIiqvZFoi7nAhZX5dcwkNDyHomACynyIRDGjX9+5+mTtB+XpW/LmwlM0ptrqprgMZfbl+IwA4i/HVW8Xx6HM7q45IjnQm/ssCqoQmSRQH4oYXsv/A7Mc3RbGudXazPMJHIQw1XUp++joSp6HaKiY6+WF4zzW8we1zoTmnOZbRbDPZ06p7V6KqqJYjISkmgP/w7CqyD5BzFM3IjpFB6J628m2h0zC1lycsaik5FHVQ6ZzWTbbXvNoRuBmUzQxvOd98ZgveFndc+ZTl7s/ngbkc2sjpL94eLSQxDGZ2wsKWkCz7CkQzLI7einnn+fqvCjZuXGme2bA8oFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePr/vjohnzjPo9t0nUDIaV9z2Z2JdKEbk1ha6MuAOXQ=;
 b=geoG7FEnAnmIw3vvbFNoLusXXhWpscoauN3mp05Vjh4lu1jUYqjL+TZ0eh4l6kPbeb7pSURFOjMmnoXMSXSn3Xd/qmxq7xlp4RBhpe0yXKAgLrusCNS4t7GoQls66SXwVA7wz5Pz4wsJmfV8rbRVJgaWr19RA+9jDSDsiBqDcYUB30kLEw1fUSE1ku3NRz0p2YZH6RrT6/KyhGA6DBMC/yxRa1jv0qLHIiewhGiLJPQn0xpo+mpB2QQEC/JuJyqiLYFYkEZyVdzxRCUlYbiO6crNWag0aqfjpE63LP2xXQOaveOjJ6r6OLjy6yovT0YBEmffxVMQy5krs4lHWKB2XA==
Received: from CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::27)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 13:26:29 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::1e) by CH3P221CA0026.outlook.office365.com
 (2603:10b6:610:1e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 13:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 13:26:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 29 Oct
 2025 06:26:14 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 06:26:13 -0700
Date: Wed, 29 Oct 2025 14:25:00 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Moti Haimovsky <motih@mellanox.com>
Subject: Re: [PATCH 1/2] net/mlx4: fix unnecessary comma compilation warnings
Message-ID: <20251029132500.w5zekhrgcasadgxv@ds-vm-debian.local>
References: <20251029095505.100582-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251029095505.100582-1-getelson@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8136c11c-4b8e-47d3-fcb8-08de16eec4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lWFf72FJ5n4CT2aPj0hqEqsaEKDxiqBGaLU3wYMFYYLTs3VsaesnO2kjnpvv?=
 =?us-ascii?Q?5odhwG2gLNe/EzkpEN3Qe9F3R87+CGDCeVIxFpSSgnSh6swAS8JuRtNdQliO?=
 =?us-ascii?Q?PnywtT1WW/URf0kdYz6Z1XwzrVC8oFCAaGuQLBvUVOoQJSuiP9xdxSCJZu+j?=
 =?us-ascii?Q?4vo9lOnOEeMVgubbIjEhBr2kFMblrH4mgIfjoBBMWPAswzZRsFnMhJn51l79?=
 =?us-ascii?Q?eO8nkEonAabgUrDlVh2/0fvctLU90OxtfNSm1kgYy0A5oItPHebIR1KWUkWx?=
 =?us-ascii?Q?ZN3GOk0TT2UeU514N7BV7hMljPzEBvXBM8VM1GnxISho0vC/TsATamkokQp4?=
 =?us-ascii?Q?6NYdhsEZECHZ9rdmovtrDjk+e3sm5DzQQXOdVj4xou7wIScZfJ6yoO+6ZbZM?=
 =?us-ascii?Q?LjWJjYTCIL8yULTaYdGpb/+aOZzO18R01Nb+kYDGTuL3KiqXJOcubx6Noj9N?=
 =?us-ascii?Q?mFFbORhGfv4bc/Fz9GvKujYhwYWbcfk5OScuzxu7HJCsegL1LTWyh6n8dU62?=
 =?us-ascii?Q?UbKT3ddurrnM1FqpegqX6EEPYtf9VvbNwfl9xPfPy3AJ0zQ+I1+FmNuYYAVe?=
 =?us-ascii?Q?8mj8zm0X4JsD3lzaH6VuJFRlKjFTXN/+W+Tx3+fiJOus08j8Um04jV3QQDE8?=
 =?us-ascii?Q?2+6u7WODXQkvzOrBxROaST6kqUmAViZ9Njse9oCnxuG9qWgJ6r9/5jagQ2gX?=
 =?us-ascii?Q?thL5sbHcecVb52GnaU1PjXtJM1GbnXiFBe3KSIeOJmYDLYYA3XOhYoChXWsJ?=
 =?us-ascii?Q?X17sRrd5zW0YSxex2P5HSgiKH/njyglmrr/MyudusCarqXKAG+RgLSy5igxW?=
 =?us-ascii?Q?LHxaVZT3jfOAg0wHZd5OyfqaMQ2pFvBT21kfu+yl3Bwrm5DlO2fQUFmkrdRR?=
 =?us-ascii?Q?/i2nJQE9D9NNRkNUMRRoW49xkm7py74sclNrI4BsxRkmzn3sfOhTIyt/7vmk?=
 =?us-ascii?Q?tFmTCcNX+tT3ZW/BZxn7W38cHcfS1GxL5wDTWl00Tus9iAAzkaLNOGKHJC1O?=
 =?us-ascii?Q?y60dPmh9QR2eSzDhIkAiWTVjIZ3J+Aa+yjjbrLpUrSI9bt11Zlj8fbyJYRIW?=
 =?us-ascii?Q?ljkqdbC4BcH/jOg057+IrYrQWj8G1CS90FjKX48NClkdB48udx1PSdXVKiIW?=
 =?us-ascii?Q?Fk6z8PNVk1bSADdbPl/WZ7UHP7nHg7LqNWxCnApdCZ3jRV5iQZNA7bHNU/dk?=
 =?us-ascii?Q?Y3RnNMys212JCscnXoGVt7ia1m4Nh2tGtX7QtCZN+i+dtdSSzENTbBrefsCX?=
 =?us-ascii?Q?JWCZRXfxNu3gzMfwGIW7q7PyLYov5l4DMOu6VeDDdYbsMQB/Qq1WnHceGXgC?=
 =?us-ascii?Q?T/h/hwy2S9Ww/8894bf2mNaIboPSYwYfKPHxeZ+UXuVEEesPsGaDd4vshJv6?=
 =?us-ascii?Q?1REajS2qjMCkvFGdkj3lSuMEcwIyPh2XPBk1qKbxSUq9CIM6f7bi1xwK1u3x?=
 =?us-ascii?Q?q/MQKbKJrA51uPek6NeFPvIzzPKY7x2JYlV/q3p06skbQkiG4Yv1B7Bw8+BB?=
 =?us-ascii?Q?/UtMCQBTECS+ItPuNrJpTH3MJNm66VI/diUNaK+Ph5TO8NWx6YRh5vGKwTdv?=
 =?us-ascii?Q?Pm2ko9Txw/n1eU/BsUo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:26:29.1959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8136c11c-4b8e-47d3-fcb8-08de16eec4d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
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

On Wed, Oct 29, 2025 at 11:55:03AM +0200, Gregory Etelson wrote:
> The patch fixes compilation warnings produced by clang -Wcomma option.
> 
> Bugzilla ID: 1810
> Fixes: ba576975a89b ("net/mlx4: support hardware TSO")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
