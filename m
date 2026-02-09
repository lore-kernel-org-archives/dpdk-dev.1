Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C163DE81BC4
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 13:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7460402C6;
	Mon,  9 Feb 2026 14:56:47 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by mails.dpdk.org (Postfix) with ESMTP id 9F775402B0
 for <dev@dpdk.org>; Mon,  9 Feb 2026 14:56:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMkR5G1JNgZHkFt7py/PQWI0RkdBI2ZQKdIG8jLxb0KDnzt8q6039rzNBOkc6pPUtJehfPu6MDcw0cQwXMAdPzqyW49sytHUIlZnWhrt7+iCnu+UL0+omFnRt90wv56iH9I3BjBCEF/iAJAiTmQERzfnghKR/mqfDbGdB7OLWVfBRQN3/iDMvm/VNtZ7P0xr/J+4oZKzz8X7JPbDxZsdlT1inwJ3/swV8r84D7hG85+LoML0ktKwbSVK6IIpc7WhILOrOrAi9jJLMxd3FspkVD1hcRXdImL2vLWrD6EdxXKAP2jfZcALO6hQCOeyMpHLU+7z1vifOMJV3I6jtV+9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGiqZ1CMPhfaV4uu3GOMAJ4dF6eAtUJfJaHyRCRwCqE=;
 b=plsnt0jRPzsOqsETeu3E4XAeopQ9WuarNYxC4mRp65IUn8tVinw+kbtSBKYjbAzOCpZuKXjyKg2uH6s3sFrcIIAlq7IJAPfNQkHO+LzEb/efELLS4DzsxkFQ3jhIX+MQuecQqmP/m82uXjqynyZzPZu5+t+5eXbCV7y4XuWgIxLoLQRGSrq66rtK+pOsTCYnhi6mU4P5YkXeFX3kMLAJ7mWZM6LG/lcYGGrA26m0pdibW00eqeHLBIluVjHEvsdziBjj6BKOGQa9qLdIn6gVfITwKQKtYdeH83R87d+ory3dH9hNnkXWONF3bU+8yJzJOvqeqri+6jHoM0UhqOKVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGiqZ1CMPhfaV4uu3GOMAJ4dF6eAtUJfJaHyRCRwCqE=;
 b=NrDFIaomGIbqHOE8GOPpcK2g8Ec/Sl3ML/bqKtmUSzEZZf7mGgmSzexcKTxwafvn5ys50T1jdKD40IgTGPPlAUilGVj4ga/BEI4t3Je5U0IQeiBdXZ2sqOxPD2ZOqZ3dTtc+nOnx7ZrFpolrgmrNorirgXKIqRrNQAvAMW2Q9ADhKjaUXSqu7hOXGkth2AIKQcP4iOEYiHeOlBpnRLtqFOVJaapKNu/AJl1mxByAVU8ZrlJbjZ07q61/eAGygKb7SFgAFwI0ulHN4yU46upxGGZ1ccSYChmu+kFtSgYfIuzg1BDtbqiSkm4ELbr9ktjfCIzF/C+yKcmknXXk/JqKew==
Received: from BYAPR11CA0100.namprd11.prod.outlook.com (2603:10b6:a03:f4::41)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 13:56:41 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::3f) by BYAPR11CA0100.outlook.office365.com
 (2603:10b6:a03:f4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 13:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:56:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 05:56:35 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Feb 2026 05:56:35 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 05:56:34 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>
Subject: [PATCH 0/2] replace RTE_LIBRTE prefix with RTE_PMD
Date: Mon, 9 Feb 2026 15:56:23 +0200
Message-ID: <20260209135625.165750-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 26db350f-8862-4a90-bf50-08de67e30d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qADH1nZ/s3ki/MiJMQ5pO/WEUQuwozyHp9WOEBrLs357ZARqP06zVx0AWP9V?=
 =?us-ascii?Q?WZIaY2RqBDfKdso+37BXQBeLkscUo/KGBJOQSWvWoj9VhY/CsKFph2b90Xa1?=
 =?us-ascii?Q?IoE/xOXyZzKSgxm0kQ/u6w5Ea3exysfWB54+B39sp6vx/ZqCUfXsZyJtVh5G?=
 =?us-ascii?Q?ZhPs2pyCg7aXkVr/IedLvkQwdAONoDX/srzFwQtRFM9IwfuK+2yH5bNssQPx?=
 =?us-ascii?Q?l7r0DD4X53uYl/rgyLriKl5VJcDE7qTu+8xRT8jVj+ZGHFZ3JahLcxpLsHYh?=
 =?us-ascii?Q?Qcsoe80ffIYNbc0dP+znMAzTfks2B2ZCFj5jbY2T8zLa4CWycZvv0j7+iMt3?=
 =?us-ascii?Q?kpbMKL3sf5tD7Injy4BStOtqFo/41lHWhYezViFoSBXI1KPavqAHK6FFioB3?=
 =?us-ascii?Q?W1+oYfaBeea8Dys/fcwLaze1WPmsez7Mmp5l1JOJfD0r9kHYrH2ohdLLN36u?=
 =?us-ascii?Q?795T+IwdTs1/pjwBzp6EI7Bz5hDxKV7Ishp8Apx+aMjzTV5MdrPTOmpBIzJB?=
 =?us-ascii?Q?rDGd/SVvThzMv9az2bWOpqkaLa0RuMyXjSjM9wizZEmhrYokU0jHRQ2UGrhW?=
 =?us-ascii?Q?Qs5/b7in/Nmv3Lnx7aVPV/m96UU7g0aRE01RnZrZJdkGRN98wqkqe8R7gJWA?=
 =?us-ascii?Q?SJJBtBxjf6zEujfcOnQNoqR1SdAI//qv9VTeKJhLun6Co2OXFWd/r+XfiXL9?=
 =?us-ascii?Q?dXyAcV70GtbfOiwp/t4LYH2QnObv+sWzqnTI2zJxXm3GXDe7nbqxIH03z5S3?=
 =?us-ascii?Q?wHucD3FKXbOHfdBiC3cq+DYOhRI0EQ5OJe1zMDbz6vv+lJ6oVxDeLqje8R9N?=
 =?us-ascii?Q?WVVlqnxuGpQyYy1OHhzpo8PPUIWZ7eZ61nDIPttByUUzJkFzdUYn3RlGakl8?=
 =?us-ascii?Q?k5uwPWZe8rlnDsOmVHFqmDfUe6X37xeCYUys7sLpqCCkxGKFtltQdgxYXbDY?=
 =?us-ascii?Q?+1RQ3L/R9sSL1LsYPSqnIgFnvdZqTHYRpUJG0vdVw3Am8kpSA8c8ldgbJlkZ?=
 =?us-ascii?Q?s5dk3kgdpvzi5MufeKM9z7xfgAbi0kUW28uJBHHj1g+Cjik4jNr2aIgaiisS?=
 =?us-ascii?Q?FUw5/aKOFhYGEbLJnzBBApmpIo9dvf3DRnf19pt3jpi9rd7F7awrQ0sTmC0M?=
 =?us-ascii?Q?EBfvIdg/3r3oZP5NjG85hNFjoW/MJ4Sql2S5hCAXcxHW9ajGXKodB9uLYrsY?=
 =?us-ascii?Q?Xj37fOViUBkDS8kWIrliqr5Yx14ON+j68n4HKoKPB8rGpwuGuWUvew+XfYVN?=
 =?us-ascii?Q?Xr9+INxUlTOBhv+KhM/mxwiJfAgUc1wgcqnK4hkrsMsP2cf7CKcv57cV8mt1?=
 =?us-ascii?Q?ecLoISdSLBKaUvKjDpauw/fgC1IGCaENUFOWDW7pvJq7x0/cdNRbNxQIXNEr?=
 =?us-ascii?Q?zv8UUe7D16IOCq8OyVOysTP6/sTvzrkPdGnxNdAKEoVi3oGHJdKDJpb1UJZA?=
 =?us-ascii?Q?0Ta/AiqPRJ7UMCww20tnSEIenY90cJG763vC0RgH1Bm3r/86sdzjonoBoNor?=
 =?us-ascii?Q?pJAEoW3JXJqKAb8Bj5uCUekbefaQnwYQzK1IftILnpLyArRSEBFv10GuZBjj?=
 =?us-ascii?Q?Es/5jTPpe61vbKhMvGroxW71pQLL0P3rd9eCIfkiX6sTKeNe+kx8seDOHucg?=
 =?us-ascii?Q?/Bu9tqX5NH6jWTCz6caj/Any3/h+6swWkO9qt8q58jn5lm/cPKVBOjH/iGxW?=
 =?us-ascii?Q?5THpkQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EA3VY1N14bFwuQA3syOIEAM1VEwFOfoK4zx5FNNP3Cnqk69HFHxmkFuSdvkGgL33PiEzQUuOVrhpbnzjKMHcCstiDXBIdtCOR7GNfvrthhqAF2YMJFeFAXzDejBAPekPFJVv5q8GSTqIZlOPQ8thyQiE532YdUq8UDxEOOvZG8nPLzFNFAhM3iF8cd89ITwUBccyjRxvtf+EmzfBL1c0cymFpzhj9Oq0+U4rueNPJhHPRJZe/S/fgG2ZrQ74uhW5hDeoRyJiUgQ3hwcewf2oWBiOmzWQnGejw3kcJuXZ/QHfj9yRxrgSR9wv4oIE8e3lQt2REfdfDR4yd+6z1xU9KHt3EtVOqadUjdcWBFEgTM7lZt4+uyvd/lEbJSvd2yk1Si77mSt7e8mRQJFYJsqvC8uyOlSXeiozexvXmWsX3yq0dJyrDcIAfgF3wTxmJoJq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:56:41.2783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26db350f-8862-4a90-bf50-08de67e30d62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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

rename:
RTE_LIBRTE_MLX4_DEBUG -> RTE_PMD_MLX4_DEBUG
RTE_LIBRTE_MLX5_DEBUG -> RTE_PMD_MLX5_DEBUG

Shani Peretz (2):
  drivers: replace LIBRTE prefix with mlx5 PMDs
  net/mlx4: replace LIBRTE prefix with PMD

 doc/guides/nics/mlx5.rst                   |  2 +-
 drivers/common/mlx5/linux/mlx5_common_os.c |  2 +-
 drivers/common/mlx5/linux/mlx5_nl.c        |  4 ++--
 drivers/common/mlx5/mlx5_common.h          | 14 +++++++-------
 drivers/common/mlx5/mlx5_common_mr.c       |  4 ++--
 drivers/common/mlx5/mlx5_malloc.c          | 22 +++++++++++-----------
 drivers/net/mlx4/mlx4.c                    |  4 ++--
 drivers/net/mlx4/mlx4_mr.c                 |  8 ++++----
 drivers/net/mlx4/mlx4_rxtx.c               |  8 ++++----
 drivers/net/mlx4/mlx4_utils.h              |  6 +++---
 drivers/net/mlx5/hws/mlx5dr_internal.h     |  3 ++-
 drivers/net/mlx5/linux/mlx5_os.c           |  2 +-
 drivers/net/mlx5/mlx5.c                    |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c            |  8 ++++----
 drivers/net/mlx5/mlx5_flow_hw.c            |  6 +++---
 drivers/net/mlx5/mlx5_tx.c                 |  2 +-
 drivers/net/mlx5/mlx5_tx.h                 |  6 +++---
 drivers/net/mlx5/mlx5_txq.c                |  2 +-
 drivers/net/mlx5/mlx5_utils.c              |  2 +-
 drivers/net/mlx5/mlx5_utils.h              |  2 +-
 drivers/net/mlx5/windows/mlx5_os.c         |  2 +-
 drivers/regex/mlx5/mlx5_regex_fastpath.c   |  2 +-
 22 files changed, 58 insertions(+), 57 deletions(-)

-- 
2.34.1

