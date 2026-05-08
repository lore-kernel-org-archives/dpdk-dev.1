Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD385CD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 17:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B0C40150;
	Fri,  8 May 2026 19:12:29 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
 by mails.dpdk.org (Postfix) with ESMTP id EF8974013F
 for <dev@dpdk.org>; Fri,  8 May 2026 19:12:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1lDbeMGQ/JZN9ylSPz+Y+4l6kDp/ZeSutK5DGpR+5TXf1YGZbrP+B5rtonhoIufMjSCcEvLJSCLOJN8EQ7f13kNNEtY3d06gtNMkepXR5rtNeMxixk3J1MSuUF0pSmcPwr561mkCfnMM8hO0/SxtqHR/uU7RQWCpYmeIl8hUCm0PVyShMZ3iZ7FZ2rkjQPviBnx6mCTiDU1inK/aESWnG2/8a/w1dzzC0xDLpExPwzDlsC5p46q0Dwa+I/IeGtBnvTaNG6hZ3pzC0C4k/QqKwQjN/u168nfN4eYdarDDlgQKlVqFPegsmlnfr4dSCR8J+Eo2Rv4voThq2utsqBOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gBXGPsGgH9ac+9+WKGzfBjsww2dHHD5W6I1jfuYY9A=;
 b=eNZxO9FR+yD4aFJqgNCFiJR9yGJJbedhcBvkEzIdkd1Fc4mbJvO9E5oggHOUfTRzGHM3A/JVZuvzTLh3TawvAs2lbpdTxEYhDBzthYcrBv7/zwSUt5lsGnYioRPTI3Llr9gM3/42zbN+qRGtmq+JJdRa0hlo0FfTZd7BZTii9exMldMbskQ6DzM4hq+IuCpaCnUXQAdewmF/BHmrX3J25ENwgTapmVcF911jKSe+jmeSc2VuLWwuxpBlgymUgQCOos9xThEv1Mj6vmOhQKlHRT9ET2snkzV7Y07kmb2DuqLcz42mTyFXshH5hgW6YqxPX0SO5Xab31zvo6wRF9u7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gBXGPsGgH9ac+9+WKGzfBjsww2dHHD5W6I1jfuYY9A=;
 b=M/L4m0nCrj79aUc+ZThUnsN/qIdpMO4jdjE0kalQF77ToEWu7zImnE8AYKy/mW6XcqTWyB0I5K1vRsyg9iLmYGr6G5SsSk1P6e4/DnQGa/Twy7zCMXfuk/gvgB5AG93ddtBfTg2TccbtHhDsc5TDnP1tpEvXUepoiavDHQtUqqbV3GT6PHSKa8fJZtW2vxSNd3zY643ZpJuUa7jT/AbOpHi8uztTonZ8YyINpRu+YgocFxwXNz/5rUPlHLYEyaMhtdZngR57BMFPmUUSFQcRNYQCR+B++f2p7j5K7xfSjnnF+UNcxIlCLx7v0mwZG5bN17AJ0LDru5dpfjS1ij0wqQ==
Received: from SA0PR11CA0064.namprd11.prod.outlook.com (2603:10b6:806:d2::9)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 17:12:21 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:d2:cafe::b3) by SA0PR11CA0064.outlook.office365.com
 (2603:10b6:806:d2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 17:12:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 17:12:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 8 May
 2026 10:12:02 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 8 May
 2026 10:12:02 -0700
Date: Fri, 8 May 2026 19:11:44 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Rayane Boussanni <rboussanni@gmail.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: add validation for indirect actions
Message-ID: <wr3q6ki6tp4c565ley5vfb5tmzicgawei4wdhscmhnudotktvh@ryxosp37xpod>
References: <20260417150153.63149-1-rboussanni@gmail.com>
 <20260417222104.66543-1-rboussanni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260417222104.66543-1-rboussanni@gmail.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cf0e5e-e218-44b2-cf3e-08dead24f730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i0adKkyjpkUo79GYuHqwgVZQapX0cuO6QYffOG/n9hkuFHZVHk7tqwfpyFrgUxVG52gefFIp3j7/fzu3TgKGczHk2U4QjkR2lE9cBur4jTLL3XR5QddbzRIvClbtvUa5+ylI1ZwdZ8g5eQdBjOWQ3YVXy1uXxD1Cz3p947uyB4Qs+6c33mfhR6AnGnI8zOhlsejRG4i71EsBzyiMc4/w480eJ+aU9xspiRm6g7JkXVr3giJV47dESJ5NicwkZ4oURikFNAtzoPxEQPpDulgkVNHmSgS8oo8EdEL9ZO6db+dXtasBV9Q3DBu6oPKhA0Q31Ku7AqWpThjD/R1qdxnKobugz7iSxgsz7IOOcWDVdjc7pU2eBg4qenxCjjwisEmVckt/EOtMAthhdPNxShDuF9S8/pkG9ysQqe+aRhnpkAi9B78qkftNbgBXAmXwR6DuLnwwa43ILsodJkuGn3KMGEfIdM6fx/iA8Z1TYMpla/tQcP5wjrjmG1AKoVI0lQ6GbRLTcASRYiWIdEhGoc/JVbLbxBfVczp9ZgF5Vd3HeMGSbJHV9rCBWUOoPZtPdbsr4pvLSbKXIGfTH5RyC/V34+g4+mwS6zrJoZjN2pTnHA9CMZlvVdWY2oUpU9sMXi2KcCAtCeEcYpwpfzPpdY2zIfdG9sEFQpVToB8K/bAm/Ly5J68IQ+DxI33pGqGOJwZo46iKYJbF7uyz9qbgcebpZuufs6zkjAbU892NosOOt+o=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(3023799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o2j9rjYdPioKEZUMSC9KUQD/LqVfyXucTSWIH7HYmkJAGvY3kxg1iuEEzAjbqEyh6q4YXzxdb/fwewswDhEKBMFu0LD6D4QydFEN/wgWzBMdsEvm370w2ny2VtG0Oi8HXqDSrP4W3UijxGYRQXCZANhPxx48ctjix77LAxy+sFWkLQB1WH7AubESvxvMd1vuigTNza2bUjn7Fj/wCpRwLufvA0gUFsMrbcwwKDooRtcEUU86MFG2e1L/mNfu8c8CRlT6yOzt/2NW68483oXQud3oUrwwvnR1IxD1LXrkbo0VEj4u0r4GayUplTZWPS7og3qoTh5CHn3O+g0gmcsI57IkkoHxIXC+TNuy7TVTqGPveGflPxR/USuqFc+reF7lC76c4W9bWOz1rbn+B5E+5+Rl5cv34aWwH4PrEBYhxhItSwFNBtP8aKMKKcl7REkM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 17:12:20.9237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cf0e5e-e218-44b2-cf3e-08dead24f730
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
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

Hi,

Please see comments below.

On Fri, Apr 17, 2026 at 06:21:04PM -0400, Rayane Boussanni wrote:
> This patch implements missing validation logic for RSS and Connection
> Tracking (ConnTrack) indirect actions in the Hardware Steering (HWS)
> flow engine.
> 
> Previously, these actions were accepted without being validated
> against hardware capabilities, which could lead to unexpected behavior
> when applying flow rules. The specialist validation functions
> (mlx5_hw_validate_action_rss and mlx5_hw_validate_action_conntrack)
> already existed but were not wired up to the indirect action handler.
> 
> The signature of flow_hw_validate_action_indirect was updated to
> include the actions template attributes (attr), allowing it to pass
> the necessary traffic direction context (ingress/egress/transfer)
> to the underlying validation specialists.
> 
> Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>
> ---
>  drivers/net/mlx5/mlx5_flow_hw.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
> index bca5b2769e..ec1cdbe1fa 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -346,6 +346,21 @@ mlx5_flow_ct_init(struct rte_eth_dev *dev,
>  		  uint32_t nb_conn_tracks,
>  		  uint16_t nb_queue);
>  
> +static int
> +mlx5_hw_validate_action_rss(struct rte_eth_dev *dev,
> +			    const struct rte_flow_action *action,
> +			    const struct rte_flow_action *mask,
> +			    const struct rte_flow_actions_template_attr *attr,
> +			    uint64_t action_flags,
> +			    struct rte_flow_error *error);
> +static int
> +mlx5_hw_validate_action_conntrack(struct rte_eth_dev *dev,
> +				  const struct rte_flow_action *action,
> +				  const struct rte_flow_action *mask,
> +				  const struct rte_flow_actions_template_attr *attr,
> +				  uint64_t action_flags,
> +				  struct rte_flow_error *error);
> +
>  static __rte_always_inline uint32_t flow_hw_tx_tag_regc_mask(struct rte_eth_dev *dev);
>  static __rte_always_inline uint32_t flow_hw_tx_tag_regc_value(struct rte_eth_dev *dev);
>  
> @@ -6604,6 +6619,8 @@ flow_hw_validate_action_meter_mark(struct rte_eth_dev *dev,
>   *   Pointer to the indirect action.
>   * @param[in] mask
>   *   Pointer to the indirect action mask.
> + * @param[in] attr
> + *   Pointer to the action template attributes.
>   * @param[in, out] action_flags
>   *   Holds the actions detected until now.
>   * @param[in, out] fixed_cnt
> @@ -6618,6 +6635,7 @@ static int
>  flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
>  				 const struct rte_flow_action *action,
>  				 const struct rte_flow_action *mask,
> +				 const struct rte_flow_actions_template_attr *attr,
>  				 uint64_t *action_flags, bool *fixed_cnt,
>  				 struct rte_flow_error *error)
>  {
> @@ -6637,11 +6655,17 @@ flow_hw_validate_action_indirect(struct rte_eth_dev *dev,
>  		*action_flags |= MLX5_FLOW_ACTION_METER;
>  		break;
>  	case RTE_FLOW_ACTION_TYPE_RSS:
> -		/* TODO: Validation logic (same as flow_hw_actions_validate) */
> +		ret = mlx5_hw_validate_action_rss(dev, action, mask, attr,
> +						  *action_flags, error);
> +		if (ret < 0)
> +			return ret;
>  		*action_flags |= MLX5_FLOW_ACTION_RSS;
>  		break;

This change causes a segfault (see at [1] below).

mlx5_hw_validate_action_rss() and cannot be used here to validate
indirect RSS.
This function expects action param to contain valid action
configuration i.e., filled in rte_flow_action_rss struct.
For indirect actions, action->conf will contain opaque action handle
(pointer to rte_flow_action_handle).

RSS indirect action will be created before flow_hw_validate_action_indirect() is called
and it will already be validated (see flow_hw_action_handle_validate()).
In this function, it will be enough to check if attributes are good for RSS.

Could you please adjust mlx5_hw_validate_action_rss() to only validate
template's attributes for indirect actions?

>  	case RTE_FLOW_ACTION_TYPE_CONNTRACK:
> -		/* TODO: Validation logic (same as flow_hw_actions_validate) */
> +		ret = mlx5_hw_validate_action_conntrack(dev, action, mask, attr,
> +							*action_flags, error);
> +		if (ret < 0)
> +			return ret;
>  		*action_flags |= MLX5_FLOW_ACTION_CT;
>  		break;
>  	case RTE_FLOW_ACTION_TYPE_COUNT:
> @@ -7352,6 +7376,7 @@ mlx5_flow_hw_actions_validate(struct rte_eth_dev *dev,
>  		case RTE_FLOW_ACTION_TYPE_INDIRECT:
>  			ret = flow_hw_validate_action_indirect(dev, action,
>  							       mask,
> +							       attr,
>  							       &action_flags,
>  							       &fixed_cnt,
>  							       error);

Best regards,
Dariusz Sosnowski

---

[1]: testpmd command line:

	dpdk-testpmd -a 08:00.0,dv_flow_en=2 -- --flow-isolate-all --rxq=4 --txq=4 -i

testpmd commands:

	port stop 0
	flow configure 0 queues_number 4 queues_size 64
	port start 0
	flow queue 0 indirect_action 0 create ingress action_id 10 action rss func toeplitz types ipv4 end queues 0 1 2 3 end / end
	flow push 0 queue 0
	flow pull 0 queue 0
	flow actions_template 0 create ingress actions_template_id 1000 template indirect 10 / end mask rss / end

segfault backtrace:

Thread 1 "dpdk-testpmd" received signal SIGSEGV, Segmentation fault.
0x0000555556aebb0c in mlx5_validate_action_rss (dev=0x55555a436a80 <rte_eth_devices>, action=0x7fffffff8718, error=0x7fffffff8560) at ../drivers/net/mlx5/mlx5_flow.c:2225
2225            if (rss->func == RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) {
(gdb) bt
#0  0x0000555556aebb0c in mlx5_validate_action_rss (dev=0x55555a436a80 <rte_eth_devices>, action=0x7fffffff8718, error=0x7fffffff8560) at ../drivers/net/mlx5/mlx5_flow.c:2225
#1  0x000055555998f553 in mlx5_hw_validate_action_rss (dev=0x55555a436a80 <rte_eth_devices>, template_action=0x7fffffff8718, template_mask=0x7fffffff8738, template_attr=0x7fffffff85b4, action_flags=0, error=0x7fffffff8560) at ../drivers/net/mlx5/mlx5_flow_hw.c:7176
#2  0x000055555998e3ca in flow_hw_validate_action_indirect (dev=0x55555a436a80 <rte_eth_devices>, action=0x7fffffff8718, mask=0x7fffffff8738, attr=0x7fffffff85b4, action_flags=0x7fffffff78e0, fixed_cnt=0x7fffffff78d8, error=0x7fffffff8560)
    at ../drivers/net/mlx5/mlx5_flow_hw.c:6658
#3  0x000055555998fd44 in mlx5_flow_hw_actions_validate (dev=0x55555a436a80 <rte_eth_devices>, attr=0x7fffffff85b4, actions=0x7fffffff8718, masks=0x7fffffff8738, act_flags=0x7fffffff79a8, error=0x7fffffff8560) at ../drivers/net/mlx5/mlx5_flow_hw.c:7377
#4  0x00005555599a0c71 in __flow_hw_actions_template_create (dev=0x55555a436a80 <rte_eth_devices>, attr=0x7fffffff85b4, actions=0x7fffffff8718, masks=0x7fffffff8738, nt_mode=false, error=0x7fffffff8560) at ../drivers/net/mlx5/mlx5_flow_hw.c:8149
#5  0x00005555599a1a48 in flow_hw_actions_template_create (dev=0x55555a436a80 <rte_eth_devices>, attr=0x7fffffff85b4, actions=0x7fffffff8718, masks=0x7fffffff8738, error=0x7fffffff8560) at ../drivers/net/mlx5/mlx5_flow_hw.c:8372
#6  0x0000555556b4e6c1 in mlx5_flow_actions_template_create (dev=0x55555a436a80 <rte_eth_devices>, attr=0x7fffffff85b4, actions=0x7fffffff8718, masks=0x7fffffff8738, error=0x7fffffff8560) at ../drivers/net/mlx5/mlx5_flow.c:9496
#7  0x0000555556890e21 in rte_flow_actions_template_create (port_id=0, template_attr=0x7fffffff85b4, actions=0x7fffffff8718, masks=0x7fffffff8738, error=0x7fffffff8560) at ../lib/ethdev/rte_flow.c:1908
#8  0x00005555557335d6 in port_flow_actions_template_create (port_id=0, id=1000, attr=0x7fffffff85b4, actions=0x7fffffff8718, masks=0x7fffffff8738) at ../app/test-pmd/config.c:2545
#9  0x0000555555681a97 in cmd_flow_parsed (in=0x7fffffff8670) at ../app/test-pmd/cmdline_flow.c:13410
#10 0x00005555556823d5 in cmd_flow_cb (arg0=0x7fffffff8670, cl=0x55555a6f4a50, arg2=0x0) at ../app/test-pmd/cmdline_flow.c:13634
#11 0x00005555567df3ae in __cmdline_parse (cl=0x55555a6f4a50, buf=0x55555a6f4a98 "flow actions_template 0 create ingress actions_template_id 1000 template indirect 10 / end mask rss / end\n", call_fn=true) at ../lib/cmdline/cmdline_parse.c:296
#12 0x00005555567df3f6 in cmdline_parse (cl=0x55555a6f4a50, buf=0x55555a6f4a98 "flow actions_template 0 create ingress actions_template_id 1000 template indirect 10 / end mask rss / end\n") at ../lib/cmdline/cmdline_parse.c:305
#13 0x00005555567dd719 in cmdline_valid_buffer (rdl=0x55555a6f4a60, buf=0x55555a6f4a98 "flow actions_template 0 create ingress actions_template_id 1000 template indirect 10 / end mask rss / end\n", size=107) at ../lib/cmdline/cmdline.c:25
#14 0x00005555567e28f5 in rdline_char_in (rdl=0x55555a6f4a60, c=10 '\n') at ../lib/cmdline/cmdline_rdline.c:470
#15 0x00005555567ddb6f in cmdline_in (cl=0x55555a6f4a50, buf=0x7fffffffe7b7 "\n", size=1) at ../lib/cmdline/cmdline.c:154
#16 0x00005555567ddd24 in cmdline_interact (cl=0x55555a6f4a50) at ../lib/cmdline/cmdline.c:202
#17 0x000055555567469b in cmdline_read_from_file (filename=0x55555a03de00 <cmdline_files> "indirect-rss-segfault.txt", echo=true) at ../app/test-pmd/cmdline.c:14550
#18 0x00005555557bc83c in main (argc=6, argv=0x7fffffffea70) at ../app/test-pmd/testpmd.c:4780
(gdb) p rss
$1 = (const void *) 0x1

