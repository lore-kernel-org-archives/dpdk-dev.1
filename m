Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E762CCF9FE
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 09:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A55C7402AB;
	Fri, 31 Oct 2025 10:52:04 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by mails.dpdk.org (Postfix) with ESMTP id 2CE6940270
 for <dev@dpdk.org>; Fri, 31 Oct 2025 10:52:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6lAJZEYr6JFXscChBh2VNF6eBjha+k2kGjD+FsTGGc6dQt6db9aKZ50CgkOIrmU53gX9Lro+0BHfsiF/LWIldQcjMkpl3rWPfJu0x+JHQk6uw5XIVqKursBxvi9syRHT7iCNGJOUoRda+UnNoCziifAbsdvk55NIXJvRrhlBv1gFRUZqxurf0e6VZ4tXr3d9CAkFcbbXhaqk4GyYNQZsY/5Q3HCB9LjZBkBJdsY81RRc8eVYZtX9rwLv2vVOMtJxr76C3fD6w9bSc8m33YVDk6SmPUL3c2vja+V2KS4lpC3S7y4hEHuZ8IsrJnYD+Y4Znn3G4JRyYDHP6dupTxw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAaUrZ/RtGN4lMPGO7FLJXnH5pzLL3fEP8FR/nKH/lw=;
 b=c8Gwu+GUkP8dsJKicHF4+L0HmTHF8Jwr11EMHpQz3+QfknVhQLfMLu/cwd+2U+4B3alzufU5zsluiYS3u2/R3Bcl2Fckeecak8QlOMegrUD3g2HfnHnGdj/XEpDpzqjOyzOeJmJURdcKrFzeBIOju8d1uGx5FImUt7svfrUumTECo7nLeFYdim39Tb2Tq9slcbjd1yWLLlxOxUxGXSd9hzLmB7bgaMU90avYtEqj/zjYnUNEixW9qhl30KsqxEI+CBV5KB9tTIngMxWjOeIBNaH8+FnqNKAsLoxkL71AOcTSLnqg+Ib2rRZx+dYBOmJVRVOEegBpbeOznP5STvkNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAaUrZ/RtGN4lMPGO7FLJXnH5pzLL3fEP8FR/nKH/lw=;
 b=jfvK50eyfykwF8em7DD3DyXJ9kpx5S6/Vuzk/Vh/+QZ/OjzAMyPFr5OuXKlhymhRBUhLqijahpTrwWbnmeFnVp/QYzrnNU3OL7yC5YwTMRCWTiHUJVaS5THZ+ztXBoiA7u4C7/XL11iggy0JRjGyVhPbEOXR9t7Yuy+R69TWu9gaGqzbTgre5wxepHqDLQrVdanm7e+6ORbJmwVoVuhHU+YqjxMw27ytCYzzbRNXkTW5I76iJa/2tePKnApLRkJyHKX24et3VX6Y60drAxFPme5Mr7xQb0lFGxVBqQOWQ4Z/OtODPHw6O8RI1aud3Ysgpbocqb5eHoez0fvY6h7+tg==
Received: from PH8P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::33)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:51:59 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::50) by PH8P221CA0020.outlook.office365.com
 (2603:10b6:510:2d8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 09:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 09:51:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 02:51:43 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:51:43 -0700
Date: Fri, 31 Oct 2025 10:50:40 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Rongwei Liu <rongweil@nvidia.com>
CC: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>, Bing Zhao
 <bingz@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: remove counter alignment
Message-ID: <20251031095040.nvja7nhqe4gos7kr@ds-vm-debian.local>
References: <20251028101427.7swzqvc5o3ofzdxg@ds-vm-debian.local>
 <20251031025038.62100-1-rongweil@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031025038.62100-1-rongweil@nvidia.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeffdee-5321-4c28-4fa5-08de18632104
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kxbvo83ZcDf4XsEGuBAsB/ORRyq14pC/CJ50VVVPWDQylttgjTq7czf/GV0Q?=
 =?us-ascii?Q?UD/hnttO7kuEF//n/+F5HPPTa4cWTSI2cUMe4+/b0auoo+fZdEJD/VVgMYbC?=
 =?us-ascii?Q?+r2ET20pgmzJaoG4gkSwsiA0ljdL+z6fvb196vfNh3Y5VlDzuLenpKRVZ1WQ?=
 =?us-ascii?Q?C6x2yyCu/rjDlbulsbbD3LQ56M3Ma0mmECfTft6lHWvVLi4z0x7UikUyh6AP?=
 =?us-ascii?Q?hkWt6EPnEgW2LKEdRWPilhBEL1wYynXUeFDKEi6/RTkVxup6A1U/+pl8X7QB?=
 =?us-ascii?Q?ZCdlf2mciZInh5F7OUdQMgG46Sx5ZjBLZKne9Y1jOwpQnZZU5SSR0OU9ci2Y?=
 =?us-ascii?Q?NsOWMM2otlGcMVrQgs4FNYSSsRcbnDIW1Wp01Io+ViE5KoIH7z6IG/kIAkDx?=
 =?us-ascii?Q?sU+kURyJ3h1X/HbrCMxhzw/JQyaiwq5bLMoXgeTRsZ5xehu/B8FB+5eVw6K0?=
 =?us-ascii?Q?lzttg7qll9jBQm/FixwVdheoqRffxfkS4XdndKI8AUGJwCCiWxBTw9W44TmM?=
 =?us-ascii?Q?0J+WYD6NtoMdrP5Ti9ef/Gz3ruaLzqlTyRdIp9YdDzc9HnnLkspOHuxL4JMT?=
 =?us-ascii?Q?X/D0LTWP4OpgItSQ/yUjj2ObP1Eguy5ch19PuvPG3Y3Ayxl6mL6AYhXcHst+?=
 =?us-ascii?Q?uTkTEEMi66Xiwvofh7DkDyjS1LMtt9l+9zo7Z1l6RPLp0m7zS+aKRSPVzMvH?=
 =?us-ascii?Q?aJexXlezKBmn5zFeO9QF4fmGPUJ3zNlPintHNvB/Rzr+zh7taBG4x1anoqJa?=
 =?us-ascii?Q?ofmbqpsFfpWjl3b+B6Ai1wJvoM0faO2+LVCb5aNV2ezs7wzyXKlrf34ZTqpp?=
 =?us-ascii?Q?yk9fWQvIuEGNGEvPOToRMQkmHl/AfUhxFS7UfpL0k28selPASO3nF/2LeTbx?=
 =?us-ascii?Q?mXXm7fn05n83u+Y1K6zyBI4Ao0CxbQHImFfRzW120Oo6qHRl4LITrLs2Y5pW?=
 =?us-ascii?Q?IlBYtx//v+nqYst/+kGwwGyXeN62SOr2KryLwk4tsiQcbBptMVznyhtx90cG?=
 =?us-ascii?Q?t0DLtBQLhzZjJBH2lBIqR5nxQz+rqoJnBNvVY5t4e5wrXoU7a4iwS0f3/NZn?=
 =?us-ascii?Q?tPhfNX5HPHs2uPn1FRfpU0NRHIzVIec1YC67AnBX/qEWn5kPX3G4otFAmRBT?=
 =?us-ascii?Q?tSU+6ENAlNdl+mSVbgbRFvrAc6tKgYX1Oo45w8UqNzFUUoOVcFIEvsdlgPWa?=
 =?us-ascii?Q?JBUx4oFhbp5MwA2BIiT4tpXX5/5FRCylamLgGYAWzAOPykt5IyTRSX+tVIPP?=
 =?us-ascii?Q?ecbETaC5CXjlnrNoIlSgV3hZmq9miqaciUdxsjpDr9TR//8U29X8KKiV7R0+?=
 =?us-ascii?Q?+P6RfzCvh9PhLLQQ+LN+fEXP1GO5IkXBbtWnQbdUeMdLc0H4QaPVAbqEanMC?=
 =?us-ascii?Q?C9bEticCltlFVF8O1y/H2GFQEXL2obpqBma9nWpw/OHgA/HFo9rOA0e3TwLE?=
 =?us-ascii?Q?gNegJtL/DfBDgax/QplkAi9hWq4UUxg4qiu+zY7wcggO+mAfT+WExd/VFpTK?=
 =?us-ascii?Q?cnbPAW71D1DSNN2jvfINJHSQ09acq1FjyHi4qYa0vzoTVTvhhdvaiOmlaNyk?=
 =?us-ascii?Q?BqzhCSMB86sz7Xzys2s=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:51:56.6536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeffdee-5321-4c28-4fa5-08de18632104
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
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

On Fri, Oct 31, 2025 at 04:50:38AM +0200, Rongwei Liu wrote:
> The memory footprint was increased due to the alignment.
> 
> Fixes: 820ca7361bb7fa4 ("net/mlx5: fix flow aging race condition")
> Cc: rongweil@nvidia.com
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
