Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977CBC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 09:13:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABAF9402C4;
	Tue, 18 Mar 2025 10:13:07 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by mails.dpdk.org (Postfix) with ESMTP id 61C4640291
 for <dev@dpdk.org>; Tue, 18 Mar 2025 10:13:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZi5F7L7VrN5yBALDSAs6kJYjA/CZSBr8DG5kAXb9XQ9QFeJXmQP4SeXZtigehOS0SztD+9eSNHhO7BY9BP9rU3NpneYiK6uPjagrCv0C26GOdbAeUzcbMK5lx0FJNDBDW2JMZpiNycCCyGZveTmx6cORh9RfH49R3W1CbRiHnGUiTcNflRXoXho1E5+kVI5hiwWJm1Z3S+inLxSLJVhdiBs35A9HqMTctsW9A9ONweJWSWFb10gCNrD1UoWD48rWmZ03EHZo68ZCxOyP9jb740pqSN/16j+ghWx/xgwd6aTPknbp8bxNFxt74LxGXomCbHNDi7+jOmKu5BQ7e0Z1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPtCFSLLCYgccDlfxotDUP5I4+9HdxR4GbeN1+bFEFA=;
 b=I1OHaESJJhFZh+YZ2f46/bAAjERJjXGExGc3qvilLaxz5iLAplQK4d1B3JL3nwPQ7b493aK+PCmwc5eEmgwpWQCKSYjnmlKRh6BIRZ/dQlZSJqYUj97d2VlfwmJeh02ori5qzJw4z25J9xNNmvzAO1cZs+WpTwFxXj659t6BZ5Idv34zbxrDNbBhbclJRAgYIRXEKOv/XZUIyZ4j7VrDo2MQbpIMR5mxmqeaIMUcFMzPj1jh6hnU1Jaug7F9KO02R+XXkXdrf1iScb/9iUqFUlH7Mjjk7gQozUoc/41x4pWxnhxDe4wsJ9HDKaW+iu7rxdclZWDTq564wPPpaK4rqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPtCFSLLCYgccDlfxotDUP5I4+9HdxR4GbeN1+bFEFA=;
 b=V7DGYixNctph1IdeUqcLDHVWYPtyRBg0cMrxEA/NvJYJYdChWlkmlNLKaDe5hUZuvWVvcR1kOlp2PBgoDN0Uh2vzVcZ1Q+JhzYPk0ICFdJv5ha/tkRr2Ma6dKTvaxhnXfug8poIwYUDd5Y+0Ibu30+DZR3lkAuOtzJiNah6kukQYoAUnjR/LjwbgLv1Dnei8XiQOxdASrxOqMV9+z7qtI6B4tQY+n56QA8sOtzlevxGYDUsZPLcBPjHFcw4wBKHy/bwPXhbRg0f1je8HROEfZkY30i3L7uMDznimNMTWMmzAqQfbOiGFjwj8+v73nfh5MzAL0zMrY48JJGgt1Qghyg==
Received: from PH7P220CA0164.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::7)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 09:13:01 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::53) by PH7P220CA0164.outlook.office365.com
 (2603:10b6:510:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 09:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 09:13:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 02:12:46 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 02:12:45 -0700
Date: Tue, 18 Mar 2025 10:12:40 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <mkashani@nvidia.com>,
 <thomas@monjalon.net>, <harry.van.haaren@intel.com>, <igootorov@gmail.com>,
 <stephen@networkplumber.org>
Subject: Re: [PATCH v3] rust: support raw DPDK API
Message-ID: <20250318091240.hou7mwcjexlqlgqi@ds-vm-debian.local>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250314183815.246612-1-getelson@nvidia.com>
 <20250318084723.qb53zqp4yelscdgy@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250318084723.qb53zqp4yelscdgy@ds-vm-debian.local>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 27dfd44c-1685-4e48-a1ac-08dd65fd14f2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FT0gpjLN3Sx63YnTOousRZgM4WrquK1rMPNtxcDq0PLaJI7UJkuVZmlazWgb?=
 =?us-ascii?Q?wMXh7RmD2lOPWLsZnHYLtJlA8e+k/te7eUNoqx9iSmZ2P3+UnL36fHFOvV1p?=
 =?us-ascii?Q?0zfE9XLTCWe0Wh4Zf7XTTDaYYxCzS3Szd8bT0vs0WT4AC89BynDgEdDK51cp?=
 =?us-ascii?Q?wlv8mlS1XO0oCNUCcTSrScXb6CrQIWAMjxcltHUGuXwzrtw6XNPKjZO6h3Vy?=
 =?us-ascii?Q?O7EDZZwxTq1CRjoDdHpH7bbBJrorc1C9oSL3U7sEjkwlbsSOq18Iq8xsO4DA?=
 =?us-ascii?Q?YZgmNFD070sYL26HZxYR/nrAwWD2d/3FqPkJvvHONAPb9Mmc/HYPEUvuEQvw?=
 =?us-ascii?Q?O/GAeMcE4h4C43QuI33iK+33sXfKwoso2r2E9Xg6BkXyl1jH4hqqhfO27JL+?=
 =?us-ascii?Q?Ng+MrjRJGk00BuO56DriHe67ZtrAan+m0Acq6/Hpg0fQXsxFrdVlOxaxTSUV?=
 =?us-ascii?Q?KC2LMdQRPS9RzK6tAN4IOCQKczTLfAlQW4kMYGdoBcDAMoqtvh+guMGwRX+p?=
 =?us-ascii?Q?DS/F16PHa1HrVFC5WYb1K/6I/CSP/g+jJSQRPDfCvSuuLsp9bFjBHFk2Ylcl?=
 =?us-ascii?Q?rJis22RvyPEJW5JElUNlO1FPBwlFR7poujJXMC984QaDxHW3EAvjGezCtY6X?=
 =?us-ascii?Q?tc8bIZYYhFtgMDdesmEA0dkPbkMT5MuUT+eshFrOa4A+Gg8HDCusdpQlTLNy?=
 =?us-ascii?Q?u64AGb4bfsJ2Cxg2ebe6ppgccceKvjtoCUofMQRiLEu2djvXxxXewDTvZgCg?=
 =?us-ascii?Q?JhlKzIn1gFimdu+Cory0UdnOAJEdipFdQPTWKaVAQFw+vfjM5T7rpW09RcYR?=
 =?us-ascii?Q?I2DlMtu4INmJLaHdK9TWxjR1VWfLNGoUcl/sQ3l3U3laCeECUUlyThMeGHGZ?=
 =?us-ascii?Q?NNXbJYA1CqC39sdrsEERr6/RmT931JUiJoEvN52fKma/7DWf9BsHnsJCHC6j?=
 =?us-ascii?Q?mFKIPaPfQhFmdj1JDOBZdmydYo5UpENwpC+ctvDRd2mMGvGzYrQjJBDErlNr?=
 =?us-ascii?Q?MHBOvzG8zuM7UK/a2cwE6TaHm8Hcuk68ijiUeUuIdUPqJBCha5Ec5k+xeWWu?=
 =?us-ascii?Q?PvbNWgWAunZw8DfgTe6Fn4VB4VHCezKLhyWDVfQt01fSm6uuHGcKud6sFaFi?=
 =?us-ascii?Q?bgL7GMsxcv6brAEsHP7JM+NDUKGTCroFQZ3kkGoIyImOxmpTBX1/ggU4et3D?=
 =?us-ascii?Q?hp3+nsCSwMn/HrQYgvvkA8uj/s5oMYX3H5O7qYis8z67zTq9QVW8/1w+oEAQ?=
 =?us-ascii?Q?HWXzwI/uD7FhSzyfW+tFtgZhbb5gNS70dJWA9cRwF7uxtFcZnS3JbyeLHBZa?=
 =?us-ascii?Q?XInqYg+umKGM7Bc8iWnFs1qeysw95+gjiB6cmn9V3SivO63HgCP+vLEl0Rcb?=
 =?us-ascii?Q?nvD4UUg+TS81+TO05iFfRkyMzLvujmHPIZbS8b6r6+AtMQ+GbINd6F5cNSzP?=
 =?us-ascii?Q?xxacpEk1pq2QwE6pBQlFpqC/i9FGakItfNDJ+fVXSd2AeyL/LfZ5qHfISLyB?=
 =?us-ascii?Q?1Q6S2r6yqzejB+Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:13:00.8742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dfd44c-1685-4e48-a1ac-08dd65fd14f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639
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

On Tue, Mar 18, 2025 at 09:51:05AM +0100, Dariusz Sosnowski wrote:
> > +use std::process::Command;
> > +
> > +pub fn main() {
> > +    let mut pkgconfig = Command::new("pkg-config");
> > +
> > +    match pkgconfig.args(["--libs", "libdpdk"]).output() {
> > +        Ok(output) => {
> > +            let stdout = String::from_utf8_lossy(&output.stdout)
> > +                .trim_end()
> > +                .to_string();
> > +            for token in stdout.split_ascii_whitespace().filter(|s| !s.is_empty()) {
> > +                if token.starts_with("-L") {
> > +                    println!("cargo::rustc-link-search=native={}", &token[2..]);
> > +                } else if token.starts_with("-l") {
> > +                    println!("cargo::rustc-link-lib={}", &token[2..]);
> > +                }
> > +            }
> > +            println!("cargo:rerun-if-changed=build.rs");
> > +        }
> > +        Err(error) => {
> > +            panic!("failed to read libdpdk package: {:?}", error);
> > +        }
> > +    }
> > +}
> 
> 
> What do you think about using pkg_config crate in build scripts?
> (https://crates.io/crates/pkg-config)
> 
> This would allow to remove manual command execution and output parsing with the following:
> 
> 	fn main() {
> 	  pkg_config::probe_library("libdpdk").expect("Unable to find libdpdk");
> 	}
> 
> Also, what do you think about moving this logic to dpdk crate?
> This way dependency resolution would be shared by all examples/applications
> which use the dpdk crate.

I just noticed that similar proposal was raised by Harry previously.
Sorry for the duplication :)
