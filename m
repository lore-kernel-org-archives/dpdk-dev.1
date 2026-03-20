Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5E3109879E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 16:13:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25DAF402BB;
	Fri, 20 Mar 2026 17:13:07 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010009.outbound.protection.outlook.com
 [52.101.193.9]) by mails.dpdk.org (Postfix) with ESMTP id 07EEE402B2;
 Fri, 20 Mar 2026 17:13:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elFduBxicUddQbsPNh2KYCTO9xqpLLHv0x/7mmwFjhF6MgTNC7M3jtqPK2wA8R2k4neQvKadfkKpdozSIyT/XBEoyhZx7LceTfYZOSsCybZlHfP0UDP1EPzXeUhN8wtpsGcojmtm7MNnC5jAUAPCTuFQgp4cyVf+D157j2CoPpdznHX+9U7VCqLmLEws+XTCWKZbZ4z+Rtg/L2pnptLn4yiB4FtPoIhpF3JMIhRyAX44TyiWoqS6IUhgVvC6Co6LVXDDSkSMVAMq6tvq4pcgvWaVpEeg5/+uU7JLZikvsFcByhRuT2IjmASg64iWTObxcysp6AyavILXsrN+A6Jd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozkGWqXPmsFIIAMIOr8qWCvd6OTVnL08fXesbuUl2A4=;
 b=CQbBAxW85WEc+uy7XZDH1AXf0O6f7XjtqtHLPEYOexG//gB0lhl7ymnGbooC5lNS1jrpipQoXT35OWMwaEaB0JGlvQlJhJh1G9Em0XSrYPcB+HiH0g8Gn5lx/ZIaVa8/LeczU57K+KlO8Y7SK40P4rN3WUxgluNOzpidzG8bcAXv0BRmYXJbzvZFWxswp7mIQEOcr2SQMHGrnmkc6J21BLmHSLJlCDWuAkWUpcVxRBWMirhE6NHjAlX8QDyrXlVdBZt/sszmriFdAMVasMmksFZCxApE2gy4yA8japSeRDC+BHiWZkg/MUUHnIAJQTP+Zxfb5MZ/r9bKg/dqg4V5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozkGWqXPmsFIIAMIOr8qWCvd6OTVnL08fXesbuUl2A4=;
 b=XWwmycHGGPfmQxBRkbT/e/1dY7kqteb+/u8XOhygPa7ryvbsqHF3Rg7DO2q+/CjTNNlGo5r4DYyMGCqO/46WODDTtH67iex4593s6xd07bPFHcK5NiDYZLqsBGP5ddAxOj7WImnzp4f9Be3vw2v4alpJFmDKsOdRso7vg+LJhxaT8b7exk6sD3j7tVcE1BMNAFxKep2ViIWDAEaw9ZXbAI7oz908q4UTfvnwSJvTnIbUiIjnTpSsJFHv9/BLGA2UQG7OL4kYcdAobS3NZnDk/YmRbVyIZ0kiYLamWji3XFH5yEqXxZBdJwzG4Y+LmYxDnkNDdiG4jBZMgiyJNzaMfA==
Received: from CH2PR14CA0059.namprd14.prod.outlook.com (2603:10b6:610:56::39)
 by SA1PR12MB8885.namprd12.prod.outlook.com (2603:10b6:806:376::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 16:13:00 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::a7) by CH2PR14CA0059.outlook.office365.com
 (2603:10b6:610:56::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 16:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:12:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 09:12:33 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 09:12:32 -0700
Date: Fri, 20 Mar 2026 17:12:29 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Nelio Laranjeiro <nelio.laranjeiro@6wind.com>, "Adrien
 Mazarguil" <adrien.mazarguil@6wind.com>
Subject: Re: [PATCH v2] common/mlx5: fix mac deletion on Linux
Message-ID: <infzjfbtlv4ivqhlrqgyvxvyey3shgwraxae5qxpkcmyomn72k@aijdj5n7n7xw>
References: <20260318163628.609968-1-david.marchand@redhat.com>
 <20260320141417.1024543-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260320141417.1024543-1-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SA1PR12MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ddf39e-928c-4310-db2f-08de869b8e51
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KjE2TlDdoF43/Bojt+dsyQUhfOdBZ4pqO9h88KTi0Sxg+hkX+Sla3G0NnysroSJX2b9/B2mphv/HbjyaheJ9do9dYrmVnGdHo2tXvw+gHbPCEz7t1/4o1Rk3+aWNO9SdkQ0T/7T0X1YnB4jOMcmQu2PCas173Ad/6gi2o828UxI70I5nGTgkwSc56HSpUmIrgkEnVtUzJbaCEh1Yc+zSHUeRqcsjLHFJakyMB8/8OGhVwCDFG92pzTdkbNsheFNCNDZxLBi7FGAV0mTPcoDnxNIEVRpkXS1fyfOCAy9a6S5YwcAPHzdAFzMPl7G9Iys0oJGpE3gKgmxaT+jveT15NAlAeB+DFWWLMyeYG9nGOF4tbgtLZEUGw4hZdK4kw+3RwWsI/cghQnPPQDHjwq7W+8U9b+x8apldNgX5/fSXYnxeaEjeQip3q+smmze5hriex1gmCcusCs53mql2DsdUIHJh0kKrf+EKpDufB1QU4qbig9UHgG4NY5HKqHpoVD8HwUqjqkt32xTyscNEiCtxhvXb37ak67jgbRS0usr59I3GsdNCMHs/SsLWw1GIsLIidA25xWkI5oYfA8V1VxN5y8Yjg1nJJNDr3F3LXnxL7THaiRsxN4vZOmjdInIGdZrVwjgQMyzNI/oYT63Fka6dz46p7hp9dPawsjfH8VcNqsOg/9+MZyMQbfK/f5ttneiIr4yzPuuQ7sBQbsd6adLOxbOILSdEF9aWCXyelQVkOSEHfQyxKDnk2t0uwo96YsWEY0wZAlmG2dfiHyywrtRNSg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rugpVBpgRwumiGFqRBBYFWBiQjEApaGHSA6Qd48Dq0fdm1Z71ti/ijIC+8NLVtS9HgVgomYAj9aMTczTTy3xf2aBM8XYJAqBQXTe7TFlz03SbUx7AsZthBRSuPM7h8ctY7qDSLRHRM1ujs2UINuNGn+yxUoGiODUHWcJnArkXus3acUxh7RMPm/JA+TPOPvkV8rn2qgzThpTzo0DXWwM+bw/0AnLHkMVv+ncpT5djO3Vx2/c+fHCak3H7Hr5SIM43lN2JLf8Su4YmNz680Ms5SliCMVleH24mEZpvmeJVNc0KY2vDtQqSuX77ReVDXKMiXKo1haOH3CHql8xeCoxWKTPiCL+LH7TeyF99VySgAfiwelSYZnNtcGj2ZL/G6yYgkejbqb+ECmlqY7d9tnXc5ZwYeuT4oO7sNULcDRU2RjyUxutLihd3tsJRHknNKxf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:12:59.7426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ddf39e-928c-4310-db2f-08de869b8e51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8885
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

On Fri, Mar 20, 2026 at 03:14:17PM +0100, David Marchand wrote:
> Re-enable debug logs unconditionally, this helps understanding why mac
> deletions were silently failing (while a bridge fdb del command was
> working fine).
> 
> testpmd> mac_addr add 0 FA:35:44:3F:58:31
> testpmd> mac_addr remove 0 FA:35:44:3F:58:31
> mlx5_common: Interface 35 cannot remove MAC address FA:35:44:3F:58:31
> 	Operation not supported
> 
> Then, fix mac deletion as the NLM_F_CREATE == 0x200 flag is relevant
> with a RTM_NEWNEIGH op.
> 
> Since kernel v5.19 though, for a RTM_DELNEIGH op, 0x200 == NLM_F_BULK
> and passing this flag makes the deletion fail miserably for a single mac.
> 
> Fixes: ccdcba53a3f4 ("net/mlx5: use Netlink to add/remove MAC addresses")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
