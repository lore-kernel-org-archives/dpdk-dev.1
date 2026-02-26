Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D6EFC591D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:58:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33747402EB;
	Thu, 26 Feb 2026 10:58:57 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6F65E400D6;
 Thu, 26 Feb 2026 10:58:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVf6ZSSn/AShSaZpNAe7lJDl1pxA6lKfsjC2fCZQmaWgfFrTLMDqv86JBlf7uyBLa+b1ZvI/sJjpf1h0y8zY5aBcv+wQUm256XG2yqy/DVsduo6LsrFRG3yLy09LcBlo1oLmk0KEsfPmh7Ak6H055XIK42dqpgchu7Nbjq97OPMZ8wqqw1C+Kz5j5I9oWcDG7V+erB/Vv4TPgctsd+Ykr1KdZqEN/yqL2mTvKaHEEChnvzEdWoBPWGkCuytIJxP6CwWzbHzAqeC9t5KjvKvQwpSpRekMYz8oyeBKlvic8WHdPsbXx/XwvAmbf/NePuQFddgQYmqhXiOZ1I3V0hoZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvavs5dYPulgAw2sh3pwIpo9yWtRVsrXzA2bYyk97k0=;
 b=Gx4EgvkI0YkuJOPWDZtNt7ROIxn+4J1NHoN/RQ/9YUneUipKOnharR4ZUctE1mAJdZpJg0znK6v4ICFLrKsZ9jPBOnkMeTp+11UEqPSr4mA2t+gIg3Wnvrgqs1rqMwO/xwx3QmjP6UOmeIoW4mM5WGLABjTOCbatOCBtb7MktES0F5jP0fk2gRXXpYGO8S3AriE2dCNF0EF09PujPqEm99NScNN2pqFrfvbRvsFxPcarjHV4ulLxxk6Gn8AnA8jG7KaVjZuDZGnEWmkum+1eauH7v5s/Yrf39enqsUk+mI51lkM7ePf3DZEUNtHd6XoRh+O4WcpVoefELO7N9n7Y3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvavs5dYPulgAw2sh3pwIpo9yWtRVsrXzA2bYyk97k0=;
 b=CautI9ilIPEB5ukO4xZDasPr14mEXm+QLD8ewR80mGtItDulvLtuB4nBW822g3wqMN5JBCmj4Nx7WrI/3eYnMN0cPBZk5z7zwR9s2/0JF94GlWy+GUayvjwhEKp4yoLs1LtjILGwjCg6RB32bbJlFKGGNreWCM4ADeCCVGP8WmXkdhmFz63WrGFk0gDDQ8GleyfjDI4EIjl2FKEucra3x7WFBb2uRdbWn4ImP//6Plm7hnP1O1I6BPk+adXtUsn4CRBWMNfRrIPoe85OYEl5Bhu+eaZMhDwY2ppgtE/NeMopHKBMQFaqSit0pfZ9q0ymR5LsH6nRPVoHozAbyZ7OHQ==
Received: from BY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:a03:1b8::16)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 09:58:50 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::8d) by BY5PR17CA0003.outlook.office365.com
 (2603:10b6:a03:1b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 09:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:58:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:58:35 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:58:34 -0800
Date: Thu, 26 Feb 2026 10:58:29 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFT 4/4] net/mlx5: fix counter truncation in queue counter read
Message-ID: <iazseopy6kt67zmlzn4z3aifhsnj7pvyuz7jek3b5ik3gw4kvl@m7lc7yfn2p2w>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
 <20260217150635.134031-5-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217150635.134031-5-stephen@networkplumber.org>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: b36cc0ed-4df1-4925-841b-08de751da3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: 3dd3L/f5/v5Ke1EuZmGmtC7vxRbycg7pLfxUDLBYVTCcy74jH7ufd5Qk6Hw+sXCXhPH4Vbmkkuk7cCx8AGWimjNRVvDQk/Owj484AfgeC9HHip80kXPTL67atDv2fFeCgaNXIvmcnlmJ/rfSxEYd0gAnwmdYiah0ei24GA70+yrfSg04hJ3tF6F6Nd5GCQC0KcwYhNhemZdIsUZWdF9smBa2y8bDfvuFmcZbiDA8Tb/FdMs8Q40Y4Tk2DOj6CdRJ8GuC6OfYceGN+Hjg0KLZNAJ/7YVw/4WW68AJSrA+wFMAgP9OIYzzkUfdLgfDz1Ee2joY3/cTxz1i05P3IAk81K8TgdxWukecSiK5+b1IgSucmZxSVnXFrgkvjwbkvJCdX+36d4R79lwjrDWYZrtkTaEyWnYLgRrE3W6aNwKkA3apM7WP2LpDOF/gH5N1E0rwF0Yjw6KWh8Dvj94bXdHIk+BaRz0OmyPRMWyzgay0JJUesNGo+bzdHM0SnW7sRtDNfdVuqhRUmy7aSg3RiaTcWvMn0Iuyyksr/smRdFdIVaDZIWC5cr7MMkhNhU+SIAWBQGuZsJ6zhdxfpN2A2BrEs+UeHpUh6DO2Fl0AztlMIF257fjIDTAWEs5iyKsSzoap6Md9SDETiIckbTCCAoIDeo5GC2Di7n3MNfIHzRKw81z+dezoTecSR7HBUFd/OGwKC6ai0eeiNwmOjGDRoS+G+n9WPzh0xJ5Bx7HS5ZD0aY6hVMDOYwZPCQqE8fSvTOS1q3jpyL9INFnXkYqSX152YdusXuVuFqaAWVw2yXCRlTsY8k1JT2kPyWB2aaMj31q0T+IFd9Y5525IhN5457vJxQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qQjdOJpWFJ63+H1HLzX5h9gm0pwXWSNdjUp6HWgZN6tgLVpKcdlhKgCj2QtlKJFxyaaQ6EpbqT6joKK84+j22WoZsR/LzBEpV+IxxwLX3jORHa1uiupN6XdAYhNp37wCB70O2hh9o77V92VZi5AMVKrVI3q7JXcX5Xl3XiHlh+764kuQUMJCheBHHQ8mMPOhMD8e28b+K4b0KWYv4Gl0VyXVfHMCw7Qq7XdncUdt8STumfcMchLcK3HtIuDRABsfj7OpHhrE195SNRH2QzPv7e7hAeLkrE+a9Vd/BqldZqDw6tUrbfHNefmbPcWqmfsv/y8cqVkL8ejMxKmz2rp6IGbFR6J19M0+QqykNvD68moEONp5hAEbJnOH1fvRATPFcnRX2e7/AREG+rdAQIfdj/KghGYPLss9OpRjRtatanVboWfbtFTnTfDXjIcaPpMM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:58:49.7629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36cc0ed-4df1-4925-841b-08de751da3f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

On Tue, Feb 17, 2026 at 07:05:02AM -0800, Stephen Hemminger wrote:
> mlx5_read_queue_counter() casts its uint64_t *stat argument to
> uint32_t * before passing it to mlx5_devx_cmd_queue_counter_query().
> The query function writes a single uint32_t, so:
> 
>   - On little-endian (x86): only the low 32 bits of *stat are
>     written; the upper 32 bits retain whatever value they had
>     before the call (stack garbage or a stale value).
>   - On big-endian (PowerPC): the write hits the wrong half of the
>     64-bit word entirely.
> 
> Use a local uint32_t for the query and widen to uint64_t on
> assignment.
> 
> Fixes: f0c0731b6d40 ("net/mlx5: add counters for hairpin drop")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
