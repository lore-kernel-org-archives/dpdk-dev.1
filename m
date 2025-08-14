Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1421ACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 13:32:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39CA5410E4;
	Thu, 14 Aug 2025 15:32:54 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by mails.dpdk.org (Postfix) with ESMTP id 4CEF7402CA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 15:32:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcn1/RSUQqgjtg7opdTbakDRqDlYFZG5t5/nD9kfR+3lBoxQgsuenWUI385DNeTN53Lk7i2yAqLsOYpAVJFNBjQbyQRuaVFFJjSsb/neqS3v6y3Vyz9xItElcVusDRqqisbf1ksWF1J6wLdH6AZYtErSi0x6zV3Vaw8hLmtakZ6CV+8AoR+IdmRfl1N6nQJd0NZLiFYoko38rh3unnzUhpxHJ6ytF10xk6TVxsERXpI3Rx0cO8AeN3QvXncPByCoMM51z0Jw2XyO3IHN/50mfeZtdaIS9uD653eCNEva83TowY4axOKKyTuJlu+IeKZnJSdNaHSEWi82H5M4sO+AGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwmfu+193gL5BPJ6GfL6OPHGOR5xrmhoj9d+113t0+Q=;
 b=BGFm8nFL9C3W/FSi1oav0z6eUBrRcDVGwKPXK69X1ujHYRlD4jpkeiGuNDNB6f7KtpS5CN3A4N6l/9Ni/A1JFFg5t2SdKeFo0bc9SJzGYSvBc+TaFCv1BurBDNjsiDpMV/rrOMqOTdP1NtOzOtp4CNdY1do8OaD4MAK/gs4EROD9kppI7VHr5YxM/inOwNf2KR0XiHWESDwuzoy+HJ9MNkt2zPXxuJGdC6A0DLFwkpWclIpWFQ1YaUR+nV99LwXlqlIL6TdzukknAP+tPsLyPibGS4l+1PgzrEiDrtcVeVzyIRlXLbMDY+CukQ6bN76CLJs7A00WmiXo/JXV2y0OCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=syseleven.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwmfu+193gL5BPJ6GfL6OPHGOR5xrmhoj9d+113t0+Q=;
 b=t5LpdEk6i1/ugoLXIbgci9HR0QiRggNzQlJ0XC83+CmBI3v1AlPOlwGHbT2QXioKRwX3g8kXphqfC+sAlMbkh+0lvJzuQ2GRshS6EoC/gOrv50odXXzbhDOSfEzgPFeGwHkA8j7U8HwdyzOY5gjj/pqsxLPL1iiLxmVRNTRnjGKPal61waUHhf/6Wlqy7BtuxO3RyUZlLW6E+ylYDZXWmaL6omRhs5dg44gw51vk6BubNufu7OC40igEWlShatHEs5CpmDudMIyc57b3fxX4vSkE1ZmjylWa47UkYbRDwkNs2mLW2JncmuQmn2b09eWD9BNl6zc1AQJV+0aGguMx9w==
Received: from MW4PR04CA0057.namprd04.prod.outlook.com (2603:10b6:303:6a::32)
 by DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Thu, 14 Aug
 2025 13:32:48 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::5f) by MW4PR04CA0057.outlook.office365.com
 (2603:10b6:303:6a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Thu,
 14 Aug 2025 13:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:32:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:32:25 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:32:24 -0700
Date: Thu, 14 Aug 2025 15:31:01 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Michael Rossberg
 <michael.rossberg@tu-ilmenau.de>, Michael Pfeiffer <m.pfeiffer@syseleven.de>
Subject: Re: [PATCH] net/mlx5: deprecate representor matching devarg
Message-ID: <20250814133101.r4htfeid7tbt4lt2@ds-vm-debian.local>
References: <20250716093846.1117794-1-dsosnowski@nvidia.com>
 <871879d3-b34c-4cea-9ae0-4715fb1c45fe@syseleven.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <871879d3-b34c-4cea-9ae0-4715fb1c45fe@syseleven.de>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd209ef-0598-48f7-0d11-08dddb370db3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qUu448xg0+K9q/U4Jo4AHSnx3DWvSiiLuEWyNpRaV/rH9ClinTFGUdQ3O6e7?=
 =?us-ascii?Q?H/lZV0Wi1mg1Xdg3X0HGrN+hgu190gh9/XHOXuDZq6jpy+RaZpuYf1R3G0p7?=
 =?us-ascii?Q?G+DwVIh70xS/6hRuecKCFw6SOsRRDFks/vsxNeKXgDUmRrXXczZ7594vdVZI?=
 =?us-ascii?Q?Wp6HbKJWYHG6a74jOfIAL/mq4FchQ52x2+8CBGy9i6yC4xXeMAeOjKhmYPze?=
 =?us-ascii?Q?05KqBtbcA37yy6PBUzpX5VSgNFGkE0N/pvFmlgcloyCwL+rIjnKIaVQCiORW?=
 =?us-ascii?Q?nHmS/BeJgP3Niq+ueML7kl8BNAVZQh/pOf0zoNH51WbSIyPMPik/41SPr8Q7?=
 =?us-ascii?Q?noln1gwltD9TGNhyrBnJqbGhvhlf0fOwgerXW6YfmwN76JhE6L6iYQeXRvYW?=
 =?us-ascii?Q?9KjXzGyqdjxH4+yG5wcG5aEvM0r+irAFWBPPIYEn7YOebRbN0EDHsXXYXY/o?=
 =?us-ascii?Q?5lCwy3DLVVWab6KpYqxOrtmVtyIW7EBX0y2zo9wsyYcpwIwuYcymleGLhbux?=
 =?us-ascii?Q?iXiXgVlg26NjvIx/aN87x48vyPQVjlPMjJTFKxQ0LzfN7+8SOAakjV2up3d4?=
 =?us-ascii?Q?s8yGxTdLrp/PbpU9AwudmWBNnz9s4iv9qieHab6uromdzdIg+JiiT6c6UzGF?=
 =?us-ascii?Q?o+ruW407ewWe6o3xRjw+gnmaCyqQ54agT9X9MdODitgFC8ErMwIvrkyYIP++?=
 =?us-ascii?Q?YT53k8Zl+qp9A+1nqCqBLl0VYWpn4ef0qO1uNhv9prsNvzsv3ov0c7Egvn62?=
 =?us-ascii?Q?UfnKIWo2AKuSSFJZYS+Ym0kbe0tBpEVhFN9252sMeyz7x4zf5cmOO6VG0D3X?=
 =?us-ascii?Q?Ft/tfENCToyzhecUYAWZmkVXFEnxNJ5wC5TmkJXPXPvW2r+yN1Nw1Khs4092?=
 =?us-ascii?Q?lt1cB2eS8Mbg1c6Ive4eF/89bGD1dRTSEHupZtc0POs49h8Qprgrhr2txDMs?=
 =?us-ascii?Q?EcwJD+VrCH0jppvQbIat2KAvMNS3byEM/5o48eiDNtFCnjVyttR5bUTTdv2B?=
 =?us-ascii?Q?rG18sLkWJw3QzG9UeONeUGxCixiYZxmEmpCfivZGqRvbb5lngT06vLgRoKOf?=
 =?us-ascii?Q?RM/ei2t1SshQdx8PGxxCkuzc4oAfn/IpWQ3I+LOa0MCpnC5wmzXprx1rCiSl?=
 =?us-ascii?Q?HBR3/AfJ1n13auAXQj9WB7YVqxviVzmryYiEj1IUSD1Da4skWz10NentgTuN?=
 =?us-ascii?Q?trENvnTzCiClvmByWR70drTmfdb7zqw11Sls3yYqPidfZtvidIthvdkiKlWj?=
 =?us-ascii?Q?i6YzIgRYX9CG/lrvQj8EA89mUt6dMGhekiyxYYHuGqxGRWpDQ6dlKsu+Y7TV?=
 =?us-ascii?Q?mcHZZ4HphopSvGB39iR2UbdebyVVJDM6asgxbtsYT9w9PlhTWbqNAqWyf3NM?=
 =?us-ascii?Q?i5iel+bR6/EXNV3mjYhecveZYRAoCw6t/bRwuHN4H2TNvbcTLAqCadmx5lkS?=
 =?us-ascii?Q?Uuk3Aev0dUz0q224Wp0pDP4gq01yuxYTs7Yv5c/NvZXsIPneRmny+FnioikR?=
 =?us-ascii?Q?P0HWkhbhVqi36X8IT48nazh5aeu8N6k7K6b3GrLyXjP/r5BvQdhejmR2tQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:32:45.5468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd209ef-0598-48f7-0d11-08dddb370db3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592
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

On Wed, Jul 23, 2025 at 11:07:20AM +0200, Adrian Schollmeyer wrote:
> Hi,
> 
> On 16.07.25 11:38, Dariusz Sosnowski wrote:
> 
> > Mark repr_matching_en device argument exposed by mlx5 PMD
> > as deprecated and schedule its removal in 25.11 release.
> > 
> > [...]
> > 
> > A new unified representor model, described in
> > https://fast.dpdk.org/events/slides/DPDK-2024-07-unified_representor.pdf
> > should be developed.
> 
> The unified representor model seems to only address aggregation of traffic
> of all ports to a single representor (the e-switch manager port).
> In our use case with BlueField DPUs, however, traffic is always intercepted
> by the DPU and handled differently depending on whether the traffic came
> from one of the host representors (i.e. the host system or a VM) or one of
> the physical port representors (i.e. the the network fabric).
> These two traffic groups are usually processed by disjoint sets of CPUs
> processing disjoint sets of DPDK ports.
> With repr_matching_en=0, we can flexibly steer traffic from many represented
> ports to different representors (e.g. dummy SF representors) to aggregate
> traffic by port group on the receive path.
> To do this, we create flow rules that tag packets received from the
> represented ports accordingly and match traffic by this tag in ingress flow
> rules for the aggregation representors. This is only possible with
> repr_matching_en=0, since only then traffic coming from arbitrary ports can
> be matched.
> 
> Hence my question: Can such a flexible mapping still be achieved without
> repr_matching_en=0? Otherwise, removal of this devarg would break our use
> case.

Sorry for the delayed response.

You can replace the usage of repr_matching_en=0 with RSS flow action
executed directly from transfer flow rules.
This is allowed since FW version xx.43.1014 (LTS version, released last
October).

The overall flow would be similar to what you have currently,
but now all rules must be created in transfer template tables.
For example, the logic would look like this:

- Create a table with transfer attribute set,
  with WIRE_ORIG specialization in group 1.
    - Create 2 rules in that table:
        - If tag == A, then execute RSS on queues dedicated for network fabric.
        - If tag == B, then execute RSS on queues dedicated for host traffic.
- Create a table in group 0 with transfer attribute set:
    - Create transfer rules for matching ports:
        - If port is a physical port, tag packet with A
        - If port is a host representor, tag packet with B.

I attached the example testpmd commands below [1] to try out this approach.
Please also note that when testing you would have to apply the following
patches (these are bug fixes):

- https://patches.dpdk.org/project/dpdk/patch/20250814132002.799724-1-dsosnowski@nvidia.com/
- https://patches.dpdk.org/project/dpdk/patch/20250814132411.799853-1-dsosnowski@nvidia.com/

Please let us know if this alternative solution would be suitable
for your use case or if you have any questions.

Best regards,
Dariusz Sosnowski

[1] testpmd example of RSS in transfer rules:

command line:

sudo ./build/app/dpdk-testpmd -a 08:00.1,dv_flow_en=2,representor=pf0vf0-1 -- --rxq=4 --txq=4 -i

commands:

# Configure flow engine on all ports
port stop 2
port stop 1
port stop 0
flow configure 0 queues_number 4 queues_size 64
flow configure 1 queues_number 4 queues_size 64
flow configure 2 queues_number 4 queues_size 64
port start 0
port start 1
port start 2

# Create a WIRE_ORIG transfer table doing RSS
# If tag == 0x11111111 -> mark 0x1111, send to queues 0 and 1
# If tag == 0x22222222 -> mark 0x2222, send to queues 2 and 3
flow pattern_template 0 create transfer relaxed yes pattern_template_id 20000 template tag data mask 0xffffffff index is 0 / end
flow actions_template 0 create transfer actions_template_id 20000 template mark / rss queues 0 1 end types ipv4 end / end mask mark / rss queues 0 1 end types ipv4 end / end
flow actions_template 0 create transfer actions_template_id 20001 template mark / rss queues 2 3 end types ipv4 end / end mask mark / rss queues 2 3 end types ipv4 end / end
flow template_table 0 create group 1 priority 0 transfer table_id 20000 rules_number 2 wire_orig pattern_template 20000 actions_template 20000 actions_template 20001

flow queue 0 create 0 template_table 20000 pattern_template 0 actions_template 0 postpone yes pattern tag data spec 0x11111111 / end actions mark id 0x1111 / rss / end
flow queue 0 create 0 template_table 20000 pattern_template 0 actions_template 1 postpone yes pattern tag data spec 0x22222222 / end actions mark id 0x2222 / rss / end
flow push 0 queue 0
flow pull 0 queue 0

# Create a transfer table for direction classification
flow pattern_template 0 create transfer relaxed yes pattern_template_id 10000 template represented_port ethdev_port_id mask 0xffff / end
flow actions_template 0 create transfer actions_template_id 10000
	template modify_field op set dst_type tag dst_tag_index 0 src_type value src_value 00000000 width 32 / jump group 1 / end
	mask modify_field op set dst_type tag dst_offset 0xffffffff dst_level 0xff dst_tag_index 0xff src_type value src_value 00000000 width 0xffffffff / jump group 0xffffffff / end 
flow template_table 0 create group 0 priority 0 transfer table_id 10000 rules_number 64 pattern_template 10000 actions_template 10000

# If packet came from wire, tag with 0x11111111
flow queue 0 create 0 template_table 10000 pattern_template 0 actions_template 0 postpone yes pattern represented_port ethdev_port_id spec 0 / end
	actions modify_field op set dst_type tag dst_tag_index 0 src_type value src_value 11111111 width 32 / jump group 1 / end
# If packet came from VF0 or VF1, tag with 0x22222222
flow queue 0 create 0 template_table 10000 pattern_template 0 actions_template 0 postpone yes pattern represented_port ethdev_port_id spec 1 / end
	actions modify_field op set dst_type tag dst_tag_index 0 src_type value src_value 22222222 width 32 / jump group 1 / end
flow queue 0 create 0 template_table 10000 pattern_template 0 actions_template 0 postpone yes pattern represented_port ethdev_port_id spec 2 / end
	actions modify_field op set dst_type tag dst_tag_index 0 src_type value src_value 22222222 width 32 / jump group 1 / end
flow push 0 queue 0
flow pull 0 queue 0

