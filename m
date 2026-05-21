Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE84CD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 16:25:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E234060A;
	Thu, 21 May 2026 18:25:26 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by mails.dpdk.org (Postfix) with ESMTP id 69702400D5;
 Thu, 21 May 2026 18:25:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKtqxdvVacI41vQs/WgPCe2lOgkQgQDFjnIzb5FVhHCRSRP0h4xWHxgPeov0aJ1Yc4AQHwia7241Hz8r8Mr/GQh6IvjErHYkYgNYxPNYtu0IMDjURsDUaQv31wU1h8jaeNziud4DW+mznkt1WaqbS6Df5rE+m60KFzlWk1v/zsOIXRntL8xZ+Z0PlGoe/+au3+RTTqPPJzLK9dfNolaYyPZEPxF3pbNaSOeytRIPHZa1V4NE8yCQXjofNs9LDo7aIs8g6kONS1VeeMJB8PLwF9xe9s5V9xjogZthJJCGrRf88VfqFbQbMDo3T0PozfX/tLv4yXh7MyGwg6RjUOTIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t3PsU5ryI52vkrKgIneIfVfqPKkxT1Bu6vwa6vngno=;
 b=WXUDmalDUKXxM+RuIqf/s6SmUKnvaaCmDTYZKIBOUgS1GpzEBYWD4gXYzk3bRYGdwVRzR5aieEvOKoFPPr2xs4/WxiVOYoVvSjfJpAC4YDJKKpRyzq3jZJUZuHjxcUeoDsVMv0AyzdGAIblggrcVxRpNXKI17eOZp51joOoPlYkiuzqMdYAxCUOe3y7zf6Z317E/8QL5Fs+cjX/N8uVUyBbuBcr6qJTnOoewqUvPOqXwrlsFccNKyztlI2sNgzIWIiVMNGFUAKX9spd0pCj4TgbThBOvqL69xbwsHWGRXyzttCfe3eRswFXyeKd7NbwOGHrARve6wZHiVpBjgnSVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=syseleven.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t3PsU5ryI52vkrKgIneIfVfqPKkxT1Bu6vwa6vngno=;
 b=FsMeoEt1NgiD78XogDQdxbYEwclvBWLOUC2/YpyNBfPsdkmpd7dpmacuFTigQENIeHKg2azCMO9FE1nLmqLjo2+XjODhy/rIP8dSbYz+7+76Vhg5zNkA5uhWpoc6sAnMn2DSn19QUA+pkZS9C++DCY6JS4+pucBOLmiBMtG6KhVa51KZ815xAvorjLcmMz1nsqPvgVSRraBg2QVckaxyvu8ZEwu6wLBUSilRXNB1T7R/nLVvIbObsDwSVsauS9p06tOPaEEyeNuAH7eNVBS8CI3DKbAXuSrBSaYTL05UDB+EbeWU7bScSCHVfKUcWWJy4EtChhuQkR4wcPBkTUqmag==
Received: from DSZP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::13) by
 MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:25:11 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:5:280:cafe::75) by DSZP220CA0003.outlook.office365.com
 (2603:10b6:5:280::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 16:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 16:25:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 09:24:49 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 09:23:39 -0700
Date: Thu, 21 May 2026 18:23:38 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Michael Baum
 <michaelba@nvidia.com>, <dev@dpdk.org>, Michael Pfeiffer
 <m.pfeiffer@syseleven.de>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: remove nonsensical flow action class_id checks
Message-ID: <wblirxtiggfysi2qk2ppsrbuvgp5ufweevhxjpnykgbdingxv5@pdl4r5olppg7>
References: <20260520132533.159996-1-a.schollmeyer@syseleven.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520132533.159996-1-a.schollmeyer@syseleven.de>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 392ef2bd-50f3-4d32-4a8f-08deb755873b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|5023799004|11063799006|6133799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: LiUCTsGS3UZpsraKeoPZNPwuuBStwrEOZ9NeNUeEDv1COQKOqZhrVGsDRjBD5SPalh0coEEfhH7BHozz+rcuzoGvZm2+IefADDiXm5qcC+FdJsuR2tGVNSDswod4NyBKMNOVjSKUPR8i5p/HffLwISr/D5a+9C5cfgrHLlzk/aUOuGCfRaOyNNhikVrCtBgBQQ35rNzFjJsM0ri4joDdcwS+0DJh1+vhTcVQH2cNamvIbSEVOA27Yq3jknqpaYRz5pXbUW0a7+6K1/mwHQfFKhyssz+7PhDJ8alEnJNne11VijfhSTK+jQ49tAMOzLH7fKmRpIwukC0rkbr5KppGcDaAbbGotVuSYGu4NT5F1WYQfNZyZ/uCy+vBfywu8roLBWtLyBHoAr0xsYa4wqupzH+AKplJd531UpkFOmyqqSSCI2LVFjIP+KdzrT8O6uHY7ZNuc7g+Byb6TCgp4edLrUclHZCuzGyfSe5rA4LfKSsVPFTBMI7L9cyX2aqKIm9v6WMaOS7gbLWU7FOmj6ZZ6CF+LvA365Qr1SY6D2Cyb+nc8oMjA8DRi+JqZ2rUY+MIFiTNo2tscUk1T9hz1vFUj2vbNKaE5Ilie+BOpPGUwcgXUKESdrMWIbHMuc5B1TiSyNoIWdzsmmvmWUL0T90HkqquPx0qXXfKaIGAPwEBpeYa1BFBQkys1otRrr/JXIeI+AaNS5s23zQ+5iApsZoKaPGlX4IOiM5xU9cqSfDDGog=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x12Vxg1AWhVl46ZLv9Zzs3gsATVFBnX+xkV4+LsEGdt18g8Wv0iS6YaEcwfvvpSfpPmQqC6JxgAcMa2WMzNfDRhSXgGEEhqj92dgwKaIxsLd1iwhdg0YP+V+mJR6MXeGFO24WcPhHuTjb7RixCK6SFL3GkxNjFUnSNKM9XcLC5IeBQudKq0RIafhNJ9lhBapdOAk/0ihIOWGE0cYBe2mOnohPlno7dzaer+P9iRFXXv5FuRo2ckFoR9SOlssngzel9d8IMvyMz35h0k/rmRVMuvWkQHVeUP1Qg1uEdCLLFWn2nxxV9Z3uOSgx/LiLj9cOwermx+q7qRFh3/V9tXC8gIkYpgsvAs8r5+haiAQEx6quupWMV5ud2R/goCVkbVArda6XVnZ8GlOpJTIjZ7Rc0FLLbytdxGO3DLZHu9ZYcxCq6ruBzxRDwoa4bMYcgHF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:25:10.1282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392ef2bd-50f3-4d32-4a8f-08deb755873b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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

On Wed, May 20, 2026 at 03:25:32PM +0200, Adrian Schollmeyer wrote:
> From: Michael Pfeiffer <m.pfeiffer@syseleven.de>
> 
> For a MODIFY_FIELD action, flow_hw_validate_action_modify_field() is
> invoked and enforces class_id == 0 in the action's source and
> destination, if the modified field is none of
> RTE_FLOW_FIELD_GENEVE_OPT_*, as the value is used solely for GENEVE
> fields.
> 
> However, this check is flawed due to the way rte_flow_field_data is
> initialized. As it consists of unions and anonymous structs as members,
> empty initialization of this struct or initializing just the tag_index
> only guarantees initialization of the first union member, while the
> remaining member's default initialization behavior is unspecified.
> Therefore, depending on the compiler type, version and configuration,
> the remaining members may either be default-initialized as well or
> contain bytes from uninitialized memory. This causes the check to fail
> depending on how the struct is initialized wherever it is used.
> 
> For example, rte_flow_configure() sometimes fails on mlx5 under these
> circumstances with an error "destination class id is not supported"
> during creation of representor tagging rules, as these internally use
> MODIFY_FIELD actions in the following call stack:
> 
>   1. rte_flow_configure
>   2. mlx5_flow_port_configure
>   3. flow_hw_configure
>   4. __flow_hw_configure
>   5. flow_hw_setup_tx_repr_tagging
>   6. flow_hw_create_tx_repr_tag_jump_acts_tmpl
>      --> various rte_flow_action_modify_field are initialized here, but
>          class_id remains uninitialized
>   7. __flow_hw_actions_template_create
>   8. mlx5_flow_hw_actions_validate
>   9. flow_hw_validate_action_modify_field
>      --> invoked with class_id containing uninitialized bytes and
>          non-GENEVE field type
> 
> Remove the two checks for class_id in the non-GENEVE case, as this field
> is unused for these actions and avoids additional implicit dependencies
> on the correct ordering of union members.
> 
> Fixes: 1caa89ec1891 ("net/mlx5: support GENEVE options modification")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Michael Pfeiffer <m.pfeiffer@syseleven.de>
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Thank you for the contribution.

Best regards,
Dariusz Sosnowski
