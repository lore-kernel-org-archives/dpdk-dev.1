Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37348CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 10:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F409402DD;
	Wed, 20 Aug 2025 12:02:20 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by mails.dpdk.org (Postfix) with ESMTP id 836C540292;
 Wed, 20 Aug 2025 12:02:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ4Q52bEFnItHS70Qz/YX4PXx1zBGJNurJ1wvBp8+PqQNJ3ZA8AMdidJSgbDf77+CNxaHlJTk3fxLVkG+wGc+0PzKVMESyNGkExmxk7GToaeXlmmujbJqGbH9XRAzQzeZhuX36z+JHca2JoS14e7WQ+lH49yViVBt4eENDUqXE7j+aZci+205FkQtSjkfuLULsUxmJRD5teEInZ8g4F4SJPiEduikZW4pq6f/xvP9OQz1sD2S90+urJaSHvbgiMKr416nD9bvY8wHIebUM8l95wCCBmm0moZM4aDOmj2hVeajQO8/6WH/u6VeslSpxSXc2O4cc26vDE7mGmeqHJyQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZY6gFF1phXD2LRJpK5P52HERO+uQrzR4N1Fomalv1cs=;
 b=niJZxt3uFKB/PdKujsy4j9YM7k7iFv0Vuz+mVtyekl0uykCTjq+mmEBjrWyAzNe4nIW2doTBXXKLSIbXb8fq4iiC18xgFqBnCQOS/rHcqz6AHS7Ogrdr5ucKvIfdUqfyT53TZOeG6OnIwpb3nRRl7QM8ErSGLCpv66BNzIoPfY4c2qUI+SFZrjjvauYd1oJ/LPdS6DXiEUoUhoc9x8/dtpzxlkpQLyi7LkCZKItX8rY1XtJopVHuWvhdAjx0HYDo0JW6HC2lVIP5XZ2wdGLWNzs5D+soqVXN7wWnF7UU1Aa43VWd73drFJoLRT9lp9339kXTDw0gP7ml+gd/+3Frgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY6gFF1phXD2LRJpK5P52HERO+uQrzR4N1Fomalv1cs=;
 b=h5di2ARao9dowTGpUNWp2Nn2gCjNP7dpbHf1txLVMSJwHiAwFZjP+GAwyxtxtoWU2mMpUkUUyYpTFNNCbqTx9FB7CdrrRH23BlVpz+m+yoinX/+HwFQVuXFSlH8qlvl4e9vJIekvuAK7qDktI0OpyDANiMurrCkoPHxB+HkmkgA85VvS+DWyTDzveMCe0ZwW4Jed23/f1rXf5atljVfxurFxlsJSuNmcYWf2COWDK3TCQ4ViRoNu2MyXWyydURd65yAxXxndIQYn5UXmJgLUQJ2c10vr0rYrXUWnkwqsw9L86eFHpSy5epFQSjOzUIZi8fTklL/gO1KHx4uIUPdrtA==
Received: from CH5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:610:1f0::18)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 10:02:15 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::7c) by CH5PR05CA0021.outlook.office365.com
 (2603:10b6:610:1f0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.6 via Frontend Transport; Wed,
 20 Aug 2025 10:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 10:02:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 03:02:01 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 03:02:01 -0700
Date: Wed, 20 Aug 2025 12:00:59 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: David Marchand <david.marchand@redhat.com>, Ali Alnubani
 <alialnu@nvidia.com>, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 <dev@dpdk.org>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: fix connection tracking state item validation
Message-ID: <20250820100059.eatqpwvglkvzg3ad@ds-vm-debian.local>
References: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250812124630.2916225-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250813141614.yiwou5lbd4exybnv@ds-vm-debian.local>
 <2610138.4XsnlVU6TS@thomas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2610138.4XsnlVU6TS@thomas>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0c8431-6bd0-4f2c-a886-08dddfd0a404
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RwMVb5rNwkQt5GYhwz9i3leolq5n1p1QKK6HSxQHaYSBOQrjk2bAVicOXkdC?=
 =?us-ascii?Q?m5NtH6O5oH5niJnR6GNj/DDBZzgvkf7VJIrPv55qeq1o3tIFM446rUINTkZ8?=
 =?us-ascii?Q?0PlFkt31x9yfIzlR+cYA0pl0EhJ0i/0u1DH+z5sbcflxFdtm4Y2fZaW15VrS?=
 =?us-ascii?Q?bgc+sRYsZDMe0gM6xmJWfWaoiiV7MDyCdGyd47QlcpEp9SokvBYLhmxmzzkK?=
 =?us-ascii?Q?DDhT83BGB09NN+wLVlsgVcA2xokLzALYHfuSE9oQIAD5y3r29+g4A3ZIXHOR?=
 =?us-ascii?Q?KjysT2tjZUuIllbBnG8xf05LH7DcM06hEQVtkDtdzblxX86jFN67GayH6z6U?=
 =?us-ascii?Q?YAKmTuLrFtg8DxMe1amVjt5GgHOM84K7ISIxPMfvBlPU83G7RYgdjCg+GVg7?=
 =?us-ascii?Q?uB1K250Itbt/w3wv/PSzwx2Cb5EPpXv7HmuMI3+Z8y9tbr3ZUxKQROXv1zUX?=
 =?us-ascii?Q?Lgn2oj0ccbYIrKEx0WgL/mVAhh6qGlwOckFCPzakirJ5tXctNbXysvAGIQEj?=
 =?us-ascii?Q?1KOr8yfLPtj+YCJH/SeSVbnYCgx0Y+VAgPWja4ROiAh+DMsEBVTSiSWl9oUA?=
 =?us-ascii?Q?Wn0o3XIUN+ewlEfzg7tewRWogVsfOEm7KPATVgTt9cHpRZajmFgplZ7vP04q?=
 =?us-ascii?Q?nEc8p6no8y5zRqVVcIjgAntt9gGZeJhDFT5yjECkk6CMuzfhbkSPaHHr/NPu?=
 =?us-ascii?Q?34ar6F2mWrGt+fyJrEXtoxeFfHg7GOHYIigTS13o5DVMllID36Ri2hNNikNf?=
 =?us-ascii?Q?C9KQhH0plfoIuDIiDPQcD0EN002Xcv+NAZboiLfFQtDHV6HXGnuz7XKiFd2c?=
 =?us-ascii?Q?xLL5Uu4/TBFSLJGPTQ1BMd1hkPyR14oVGHs6+f8j4zPQOsy49RUiGjlGX4wu?=
 =?us-ascii?Q?yFcgLbK0bptIedrcLesv6rX0DAq2nbj4I1cA5cjoTbmfoVrXHdX6ZNHezPr4?=
 =?us-ascii?Q?/sQ7fidwkbo/5ogTIbmkmLFyrgBHSU8LO4a3khO/lULrHC4qDwILrwiXa+SD?=
 =?us-ascii?Q?KOd+njPpCYfjgdOgDcpMugQ0Ezm17qPfg69nzDeblz+PI9kW4PfgmaseYh4f?=
 =?us-ascii?Q?GzI5V+vTs0yuFzciqPMRLsOsjuv5KXDaYzBGQG6X5U8qTF6yudarSMnKo9Bo?=
 =?us-ascii?Q?8e1NM/iZ9X5tFGj+9xl8frcv/ZMa0g0Q07PFgWj72C9dHSSvnwtXjgZKpujR?=
 =?us-ascii?Q?8dkYcEiognOU6GqW88hYKDt7pFoohvqXssfhymjmwgHRgUmpVg8P+isrV17q?=
 =?us-ascii?Q?cqEw67uUgnAau781XJM4DWT6vG9R+4MV2p7F7r9YT5sYspQ9sz8/sbzFbw+8?=
 =?us-ascii?Q?Vn81Mkk+xFdzShuHCB/1sFPngfrQ5c3j/M0Mo1pCh+Ika1vYjlmKdploZQIo?=
 =?us-ascii?Q?wbOuGjbIzpTxJjlHIIJk8984CHwskkNBPZBxMJE1ImDjNnJUT36/KiJn3JsD?=
 =?us-ascii?Q?LDENHI/m/9OAR+0uutyQDCqGM5bMe50vtXpviAH67C6snOVMPCl9SoXAsEUf?=
 =?us-ascii?Q?3uTdNdMTEYm/1OJu7g3Fpy/FtQsMv1igUB+/Q0zX7LwXv7TPIYcRf4q3kg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 10:02:15.2795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0c8431-6bd0-4f2c-a886-08dddfd0a404
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
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

On Mon, Aug 18, 2025 at 07:20:19PM +0200, Thomas Monjalon wrote:
> 13/08/2025 16:16, Dariusz Sosnowski:
> > Hi,
> > 
> > Thank you for the patch. Please see comments inline.
> > 
> > On Tue, Aug 12, 2025 at 08:46:30AM -0400, Khadem Ullah wrote:
> > > This patch validate a connection tracking state when matching
> > > 'conntrack is' in rte_flow rules. Since conntrack item flags
> > > is a bitmap, then any combination of RTE_FLOW_CONNTRACK_PKT_STATE_*
> > > flags is a valid value to match on.
> > > 
> > > This patch validate the CT state item.
> > > Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')
> > 
> > When used locally ./devtool/checkpatches.sh reports the following:
> > 
> > 	WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: aca19061e4b9 ("net/mlx5: validate connection tracking item")'
> > 	#12:
> > 	Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')
> > 
> > but it's not reported in "ci/checkpatch" job in Patchwork.
> > This check was added in Linux 6.1: https://github.com/torvalds/linux/commit/bd17e036b495bebbf07a5fc814c868e30e1dc131
> > so it appears that checkpatch.pl version used in CI is older than that.
> > Locally, I have a version from Linux 6.16.
> > 
> > Ali, Thomas, David: What do you think about updating the version of
> > checkpatch.pl used in community CI?
> 
> I've updated the checkpatch script used in the CI.
> It's the latest version from Linux minus few non-relevant checks.

Thank you Thomas
