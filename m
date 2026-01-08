Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E939ED1D47D
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 15:56:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E91F402D3;
	Thu,  8 Jan 2026 16:56:05 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8]) by mails.dpdk.org (Postfix) with ESMTP id 2084C4027A;
 Thu,  8 Jan 2026 16:56:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOcYTSfHHa+huewvgCf/2ITTJDwOekdSIRj+uJsJU3BT8Rq6Cv/f/WpitiVEGL+M+mH6cbzm28J9rRqWWY839BStgnH6GzJdlvDobmdECx0ygfAau/F8TDQPTF6B8HIrdU5b6IRkwhlNdfcGb9qqNU0q2jEgooTgx/0EmFYLYBFzFgegxIfeTt14MIty3qE6jBEV5BILxlrhmI8e/CDAP56pKD8p0IQKoMnei1v9sfzSvJB0IhzfnZ6ckBvXSZkpz7MNv+x3onxppY0Ps1K1FvBoJnrKANIB2Qm7JHmmpM4RvvnW50GBtsrG+yxAQdYCBuk/P7yHH+te7pnJJrS5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX3uToN5n3mdO9blQFcHfVwhEnjR6pWFtdMiX6VY7Dk=;
 b=CZGmwa1nPQFcUeuIVGMGU3qQw4t16zHtv26mlDYvEf4WsTZ/g5hHXdWd2nlE3fUU/73mZgKyBOi33xi6NIXKekjXWAWa5/Hf33NQCLT2bY66/eU8m3OXdEumekxMJtNMto12y6SSeICD5PsSrokFbYrgNqgFw5h1VTHAHXgjmuGoSP14cU8Jjx42rW//3I7cpe5djqR1vMX5RagMZEgMlAAXWHCkAnZvkBJkeMu9E+D/stH8jmG7+Kki35qYZpHqFmJRE4hrjOiA44PMQYtxWePPTdCCaTgmfX7mkrsez5Jtg4DfxZki+8Q4VZ3Bhiu20lljqwuIBpzC9xISE5XzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX3uToN5n3mdO9blQFcHfVwhEnjR6pWFtdMiX6VY7Dk=;
 b=AM9BukEnIgLjWSKZEtiLkeJ2X0AT2CPYoj2EwfVbPefYRABOHkvzK0WgzRn5TWpFA/B0AHJAjcHHkpjCK5AwlwvLWdyIS2Glakv0yzf0YltjBYbDd68U4KgzgES23Gntod8TEtI5nYPhI4m1JmYyg5u6XCtDXCYMBKGmZ3TAWMkULxcLs9Ogxk+vquMHq/5i3x7ye9z1bsRBu3YKWoWdvv9jC9h6cVeAbZWeiOup/Yh8QJpt6MixrFdXQF+Qs7PxhOr1HSYnuGbsCmwTqohFVyu1K/d4DqH/64YzQEC+cWq3Y0U3+D8kTrjG4ByZ6oPsXHfa7nJS3WEsmu+O8HiHXg==
Received: from CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::7)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 15:55:59 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::27) by CH5P222CA0012.outlook.office365.com
 (2603:10b6:610:1ee::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Thu, 8
 Jan 2026 15:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 15:55:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 07:55:42 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 8 Jan
 2026 07:55:41 -0800
Date: Thu, 8 Jan 2026 16:54:51 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Aman Singh <aman.deep.singh@intel.com>, Ori Kam <orika@nvidia.com>,
 <dev@dpdk.org>, Bing Zhao <bingz@nvidia.com>, <stable@dpdk.org>
Subject: Re: [PATCH] app/testpmd: fix flow queue job leaks
Message-ID: <nor7njfsxbxngnpsxrccsfm65j7q5kqic2qbulyyjd37xd4msv@d2tixwd737fu>
References: <20251118104518.1714166-1-dsosnowski@nvidia.com>
 <20251202160406.2b166c90@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251202160406.2b166c90@phoenix.local>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: df61f5a4-b2dd-40c3-2883-08de4ece6a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DLzoc6tbvfvczv//opCJOkyziw1ZTrd9Xe8uyg5QrDue8Fz8BlSdFA1FJztC?=
 =?us-ascii?Q?eAyAdJdxYzTaVLVYrw9eRhECIdAy+LTbpyVqh8ua361QuCLhlZeZMnltJbmu?=
 =?us-ascii?Q?9oD/QMjtogW6Y4I4SYUPttVCfi/z7dkF7bXN8GBfhHCR+CVWB52iX2GVl9Ki?=
 =?us-ascii?Q?S+0nOZiid3+tYV8Ps3NZeUzJoighqaLpHSpmP+xIBP43bsXsz2+ahyMdDMW2?=
 =?us-ascii?Q?NT97+3Yt7I/pVff8AGheWNzYfoE7kfqp4ESW2RYnarzuzsHu+PFEeRNlMMLg?=
 =?us-ascii?Q?so8QesS2NIY2/5ONMBRfLGTbLUEKq8Bz2jqsBazSKGiwQ4nehMY+myOZZt+1?=
 =?us-ascii?Q?FfDD6CPvzVe09JJs+vLc8OHNPzec9/3CChmmSxc9PfyZQOQjvcrCHuYZZLfd?=
 =?us-ascii?Q?LuumflHoevfHxEs7P3xGC894pEtjtks0T5ztDV/oeveg4sphmAeKpM8k+XWC?=
 =?us-ascii?Q?VJor/v3Fx4yJDBvT5tvxdiBXVckLtWw13FxtfPIsplUfP0rcv0rgytz1n2W4?=
 =?us-ascii?Q?lRMCEF0SFiGi7Or8fAXFif02NAyov2qD96pWJv+sOZrxkU3qV4Zxq1+Gq+Yt?=
 =?us-ascii?Q?3M2yk+DvR+EJNuXeAr5Vqggk3G9CFHTe2Zxq9zmdWIdwZn8JLKVaoMSi2eZT?=
 =?us-ascii?Q?e2Jl5tQwQFxyIziH3CgcbijdGfmfex6+Y3JBnYPJpw5OmGLclBEVfRcj84gD?=
 =?us-ascii?Q?YN7c3FwqXl80uLvmjS/BsKRwEcKNjPzlAyFgxZwJkYkaxr5hXXxB7t0hS7lH?=
 =?us-ascii?Q?96UJ+cl4FcA1pqmfDvn6ZmadHlyeDSK4NDC140PuG3Xbvig5qaNhGh/nV+Rq?=
 =?us-ascii?Q?juLjP85qwe73FYYxAR4fUfJ4QOnftwDC3+4/eZoSzYNiNT40yejJXhWwOLf/?=
 =?us-ascii?Q?of4YdsLuNGPEYzxIidRNA3wC/SRDmZGfSLeftabFRCknHt4oeQ/2ABlpeEES?=
 =?us-ascii?Q?jtqX+Xukpg14FC/lRbzuG9cw8p8ZKW3chuuY8nbwekcsdTk5n9sKG+c10Uda?=
 =?us-ascii?Q?yEm8xgNcjEeaXQSjAluVuRmsoQgM+WD0STy4txEt+RyuvqJfLZ4ZssYNb1zd?=
 =?us-ascii?Q?M2Vh4CukaOgObcvfh103pmAjHNNX15hgn8Hn+6kKuBvzmMWzT0VWWJnD8Rpd?=
 =?us-ascii?Q?jsrtVJnZzTZHQR2E4eWWX1gTZV1yGMCkLsjEzAWRqsisuc/YywJbSwphd6ka?=
 =?us-ascii?Q?l0deaf0Gr6PeynXQkor2eYk6YgWwBcyatKkRlxuPQ5QJldDQg//Op5CjEmdC?=
 =?us-ascii?Q?XueIkxDRKjpJg0HUEUlZqVM3PmYEeqcq8chAiemYd++Dul1nevgGwyIibWbv?=
 =?us-ascii?Q?mDYXuYZDdXiOgLw+RX4pWqnuWizngJ8tTkVuSiACT3ioNM8NNfBPHOdtvfLD?=
 =?us-ascii?Q?hstuC5rCnVXxusTDBavqHiSXUEehQKGFU6+sIc47YnvnEspvHNCLhoPHxyl8?=
 =?us-ascii?Q?a7AhwO40AQKuF8seXHL6ywm+WnvaFTMaphShzCWYSZveQWAKbwBtPdTh9E+x?=
 =?us-ascii?Q?2f+7Mo19CWIUTIN6+HjGnsyh7Ut0OtpjgnKHLYRcIsN/9G/4W7c3J9hvV4yc?=
 =?us-ascii?Q?YB51nfVhoq76pyoa1dE=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:55:58.1147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df61f5a4-b2dd-40c3-2883-08de4ece6a0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

On Tue, Dec 02, 2025 at 04:04:06PM -0800, Stephen Hemminger wrote:
> On Tue, 18 Nov 2025 11:45:18 +0100
> Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> 
> > +	polled = 0;
> > +	success = 0;
> > +	while (expected_ops > 0) {
> > +		/* Poisoning to make sure PMDs update it in case of error. */
> > +		memset(&error, 0x55, sizeof(error));
> > +		ret = rte_flow_pull(port_id, queue_id, res, expected_ops, &error);
> > +		if (ret < 0) {
> > +			port_flow_complain(&error);
> > +			free(res);
> > +			return ret;
> > +		}
> > +		if (ret == 0) {
> > +			rte_delay_us_sleep(FLOW_QUEUE_FLUSH_SLEEP_US);
> > +			continue;
> > +		}
> 
> Infinite loops with sleep are bad. The poisoning seems unnecessary and not done
> elsewhere. Sleeping for 10 us is just unlikely to help much.

Regarding poisoning, it's not exactly true.
At least in most other cases in testpmd where flow API is used
(e.g. in port_flow_create() or port_flow_destroy()),
the error struct is poisoned.
It's not a perfect mechanism, but it allows catching bugs where
driver does not populate error struct on failure.
Due to lack of other mechanism and for consistency with rest of the code,
I'd keep the poisoning in this patch.

What do you think?

Regarding the loop logic, I agree.
I'll fix it in v2.
