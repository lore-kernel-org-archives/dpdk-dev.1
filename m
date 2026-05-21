Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0064ECD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 09:30:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2C69402B0;
	Thu, 21 May 2026 11:30:39 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49]) by mails.dpdk.org (Postfix) with ESMTP id AB1D540290
 for <dev@dpdk.org>; Thu, 21 May 2026 11:30:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G621lHDDlUB/bXBnjO+ObNiQigsj2sd+4msYUBJoiM7QTK5n4fYt7tBFrkfjYCLtnzfX4/cKn2APMLfn1d1ub/Pdbz06nBMBW1sBPYa+8uvdRz4gRDteqb1PbxsnwVHVmwGS1qlZZW3CunXy4d+H4A3/UdvFGBtGhvKzyMD52XgPR7EVQ4EFoKM8ofLV2b5ozBQC2Qaxx3ThcKnNxngX1BMP3Y29B4fpbSzlojVdA1XCBFcNIaZ8lhWkvvKqGLjgOpXb9UlOuFohIERGsw4CDCnwlcy06B2t2bGcXNk2peDYH9UsCAwmVXlFqvF5UN6/Qnyr+m4lYlrxjECycFActA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbc8NVWQGeAtaNYeOM1UcZ4ckeH+FoG6gmJNbwlXTvw=;
 b=L5HsqD3wpUTTnBfnS12mi+cGrRxn6wDlomgljIPSi+9gCfDQPULun7oR9LQESDWfULgkaIyaVWAaON+h+vYTgXB6rj4HFGiphk8aIx1bUssyQ0WzocvoBv2wwI4FYQkJ5i4JNRZo1acEhG6Xyfstz5Fe8h29a6h52JSyXzwvGS0+HTnURyVK72Ef3/mF94VT3JDJRlWSrTFRtzc/d3YDNcssy5rirE7q7Yt8ICmUgDyMywHSp6RwQJK8XrCYus3BfdxsXXAEL/H7iUclEP5CrEqTrCqQCBR+4aWagqpwiHC1otxkIIHDwX+3D3K6kcFw0R8PnrsfOcO3qpSURqPOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbc8NVWQGeAtaNYeOM1UcZ4ckeH+FoG6gmJNbwlXTvw=;
 b=V+n1mZQzNVKU5LijbWsoo8uPXs/0/9zmHdikRWFWP/S16Ui/SA9HyNccoD9jp7u5HBRbckBANjfsO+l3VLB0iMoRmITxlpB0cZS2j/GvGwTvd/oqti4TxOc0FBtAiMysKV3wvMs6yrrmV6aw0XWn6G/0KZxFAqmWYTJjg2VDcZbS9bnIOaFkUkEzk/bfnoqFs3feGXa2usbo7AkX40CEBDgNfkwoa49rXe59rhGavUWvZBuPPrw+VXouuQHKFCo/m62QxkIjUXuxxq9tHuRaeLW8ZwRRIgNoSODWem7npa3iJ6muKIcyE2dmNlb2EVdt2Nsw7g1tyflvyzdNwaQ7UA==
Received: from CY8PR19CA0011.namprd19.prod.outlook.com (2603:10b6:930:44::23)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 09:30:28 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:930:44:cafe::c) by CY8PR19CA0011.outlook.office365.com
 (2603:10b6:930:44::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 09:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 09:30:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 02:30:06 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 02:30:04 -0700
Date: Thu, 21 May 2026 11:30:04 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maxime Peim <maxime.peim@gmail.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: Re: [PATCH v4] net/mlx5: prepend implicit items in sync flow
 creation path
Message-ID: <aatlgcelggrpcf2qdroaiieibkijnnpkd3jcpvazyjkjkyjm7h@47qkydf3ihre>
References: <20260427123217.510662-1-maxime.peim@gmail.com>
 <20260511150854.1398044-1-maxime.peim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511150854.1398044-1-maxime.peim@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 7458adc2-9ff2-41d9-ecb6-08deb71b9812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: KssjBXHlR6urw+05+cKJJRAKFLSASSQbI7JLkjzRZfUsH09sjH+PSHEz7cpex366gu+8YP5FlKHGpC8ipYvZ1mmMbahCTMSpLdR8NX/AcIfnFt9GuULvhQFZ2hFM3Zgvspx/kd9ZPmKF+ePO3RIy5NfcEqm4wUQRdM8PTdlhruNcXUu4JZLRXMslzNPeTcu4cao/tAiYW0McKIHi0t8p2Jxb4QCkUfq4abqRZFh+Dnvbhp/jhGDds3WRnrgsPOvXgQxt1BGfYS0gs7k1PeJaIZTS9Z385s+DtfFR6wT7/rgzmexXA99KRi3H0IJlIRMFxo/gBGibVuHUmJyc/Rmo3WPooeVT4wdXknCpQql1ZIXbMR2uFR7r26LzbcE4WyTPiq8dt0J+CH2gPD6VN8fvaEXp4/m0G02MF6V9tHcxhoqkl8lNDRFnuxfEC5gfTw7Sg/+aQ9awmcn08A5mFmr5LUnLUH43cAkdSw5KTjAvdR/fZtihWRAbDlZWC+HLiWjMFCKuYYXHZ5uZ6PoVm4HTX7uqkuOWENz/l/u1xKojno2QhgoFjyg0dAp/LlFvm59xhVfBGl2pe3fQwDh+TScpuSx2fzT7ZvrfUEdyPGU93ab579Ez8xcLjjYYCQ0SFQY26RpCljlJL2dxxZfICE0MQx/GQ9NsUAnsUPxfQi+4zARKnAQgdxl/APKWtJ1ZSGUMTdKF6I8TOKbFef0KdqOcPuRjRJwC9cnI4+ErVDSw72M=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QnzmU2VDOXxgrkPRrBlq6uxC4SF8B0LlDXI1AUFodA7/7s9ev5DIAYzFJ8CjEcuOmaqZDMinHWCV12FDTkudDpLmDhtoyMHFUqHLFrKGvqJdu20UNNZW1jrRmpJBxKAKOG29tAEForRHDd4/6zhhVi6EgpEU461+UW1ruGZtbdlIw25TNtOjvhHQrZpU3AGw0aQgHvIRmTpbI3xgv//m/ECVajle0TiHD5pjdzIUzyygwcdOe4rajpa7KhiO0TC4jBLrqhQOh/wMyWoKc9o9lxN6CMSlTlhNVx7napdfllU7j2m8IZ0aLfV6evn1AN569P+PA6CVhyVhvmW0s+cOEoeaY37iWSu4DbIaTuw8ErfMncv20wjjqu8b8klR+Obfv/mrTbgElzPkGOxwtIeGjOKx7hXMcwP4aRxAbsuPyJCgkPW5EE0p4VulOoQXO5R8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:30:27.5061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7458adc2-9ff2-41d9-ecb6-08deb71b9812
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
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

On Mon, May 11, 2026 at 05:08:50PM +0200, Maxime Peim wrote:
> In eSwitch mode, the async (template) flow creation path automatically
> prepends implicit match items to scope flow rules to the correct
> representor port:
>   - Ingress: REPRESENTED_PORT item matching dev->data->port_id
>   - Egress: REG_C_0 TAG item matching the port's tx tag value
> 
> The sync path (flow_hw_list_create) was missing this logic, causing all
> flow rules created via the non-template API to match traffic from all
> ports rather than being scoped to the specific representor.
> 
> Add the same implicit item prepending to flow_hw_list_create, right
> after pattern validation and before any branching (sample/RSS/single/
> prefix), mirroring the behavior of flow_hw_pattern_template_create
> and flow_hw_get_rule_items. The ingress case prepends
> REPRESENTED_PORT with the current port_id; the egress case prepends
> MLX5_RTE_FLOW_ITEM_TYPE_TAG with REG_C_0 value/mask (skipped when
> user provides an explicit SQ item).
> 
> Also fix a pre-existing bug where 'return split' on metadata split
> failure returned a negative int cast to uintptr_t, which callers
> would treat as a valid flow handle instead of an error.
> 
> Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
> Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
> ---
> v3:
>   - Factor the implicit-item prepend logic out of
>     flow_hw_pattern_template_create() into a new helper
>     flow_hw_adjust_pattern() and reuse it from flow_hw_list_create(),
>     instead of duplicating the prepend logic inline in the sync path.
>   - Zero-initialize item_flags in both callers. The validator is
>     read-modify-write on item_flags (reads MLX5_FLOW_LAYER_TUNNEL on
>     the first iteration), so leaving it uninitialized was UB.
>   - Call __flow_hw_pattern_validate() with nt_flow=true from the sync
>     path (was effectively nt_flow=false via the wrapper), restoring the
>     previous behavior that skips GENEVE_OPT TLV parser validation on
>     the non-template path.
>   - Document flow_hw_adjust_pattern(): the dual role of the nt_flow
>     parameter (template spec-left-zero vs. sync spec-filled + validator
>     flag), the three-way return, and the caller's ownership of
>     *copied_items across every exit path.
>   - Clarify the "omitting implicit REG_C_0 match" debug log now that
>     the helper runs on both the template and sync paths.
>   - Add Fixes: tags for the two original commits.
> 
> v4:
>   - Fix items in case splitted metadata are not needed.
> 
>  drivers/net/mlx5/mlx5_flow_hw.c | 194 ++++++++++++++++++++++----------
>  1 file changed, 132 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
> index bca5b2769e..6b3fcb43a7 100644
> --- a/drivers/net/mlx5/mlx5_flow_hw.c
> +++ b/drivers/net/mlx5/mlx5_flow_hw.c
> @@ -9255,33 +9255,40 @@ pattern_template_validate(struct rte_eth_dev *dev,
>  	return -ret;
>  }
>  
> -/**
> - * Create flow item template.
> +/*
> + * Validate the user-supplied items and, in eSwitch mode, prepend the implicit
> + * scoping item so the rule/template is bound to the current representor port:
> + *   - ingress -> RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT (dev->data->port_id)
> + *   - egress  -> MLX5_RTE_FLOW_ITEM_TYPE_TAG on REG_C_0 (tx vport tag),
> + *                skipped when the user already supplied an SQ item.
>   *
> - * @param[in] dev
> - *   Pointer to the rte_eth_dev structure.
> - * @param[in] attr
> - *   Pointer to the item template attributes.
> - * @param[in] items
> - *   The template item pattern.
> - * @param[out] error
> - *   Pointer to error structure.
> + * @param nt_flow
> + *   Selects between the two call paths that share this helper:
> + *     false -> pattern template creation (async API). The prepended item's
> + *              spec is left zeroed so mlx5dr matches any value; the live
> + *              port_id / tx-tag value is substituted later by
> + *              flow_hw_get_rule_items() at rule-create time.
> + *     true  -> sync (non-template) flow creation. The prepended item's spec
> + *              is filled immediately with the live values, and the flag is
> + *              forwarded to __flow_hw_pattern_validate() so that validation
> + *              paths gated on nt_flow (e.g. GENEVE_OPT TLV parser creation)
> + *              take the non-template branch.
>   *
> - * @return
> - *  Item template pointer on success, NULL otherwise and rte_errno is set.
> + * Return / ownership:
> + *   - NULL on validation or allocation failure (error populated).
> + *   - `items` unchanged when no prepending is required; *copied_items == NULL.
> + *   - A newly-allocated array otherwise; also stored in *copied_items. The
> + *     caller must mlx5_free(*copied_items) on every path (it is safe to call
> + *     with NULL). Do not free the returned pointer directly.
>   */
> -static struct rte_flow_pattern_template *
> -flow_hw_pattern_template_create(struct rte_eth_dev *dev,
> -			     const struct rte_flow_pattern_template_attr *attr,
> -			     const struct rte_flow_item items[],
> -			     bool external,
> -			     struct rte_flow_error *error)
> +static const struct rte_flow_item *
> +flow_hw_adjust_pattern(struct rte_eth_dev *dev, const struct rte_flow_pattern_template_attr *attr,
> +		       bool nt_flow, const struct rte_flow_item *items, uint64_t *item_flags,
> +		       uint64_t *nb_items, struct rte_flow_item **copied_items,
> +		       struct rte_flow_error *error)

It seems that there's an issue with dangling pointer in flow_hw_adjust_pattern():

- flow_hw_adjust_pattern() defines TAG/REPRESENTED_PORT item spec/mask on
  its local stack frame,
- If prepending is needed, then flow_hw_prepend_item() will copy only
  the rte_flow_item struct. spec/mask is not copied.
- After flow_hw_adjust_pattern() finishes,
  "copied_items" will have an item with spec/mask pointing to invalid stack data.

This wasn't previously a problem in flow_hw_pattern_template_create(),
because items' spec/mask were only needed during the duration of that
function.

Could you please fix the above? It'll require extending amount of memory
allocated by flow_hw_prepend_item(), ideally everything should be done
in single allocation, so freeing copied_items would still require
single call to mlx5_free().

ASAN, with detect_stack_use_after_return enabled, report is below.

	# repro steps

	meson setup build -Dbuildtype=debug -Db_sanitize=address -Denable_drivers=bus/auxiliary,common/mlx5,net/mlx5 -Denable_apps=test-pmd
	meson compile -C build -j $(nproc --ignore 1)

	env ASAN_OPTIONS=detect_stack_use_after_return=1 ./build/app/dpdk-testpmd -a 08:00.0,dv_flow_en=2,representor=vf0-1 -- --flow-isolate-all -i

	testpmd> flow create 0 group 0 priority 0 ingress pattern end actions jump group 1 / end

	# ASAN report

	=================================================================
	==59105==ERROR: AddressSanitizer: stack-use-after-return on address 0x71e744675730 at pc 0x5d70bed42c6d bp 0x7fff52519b40 sp 0x7fff52519b30
	READ of size 2 at 0x71e744675730 thread T0
	    #0 0x5d70bed42c6c in flow_dv_translate_item_represented_port ../drivers/net/mlx5/mlx5_flow_dv.c:11059
	    #1 0x5d70bed5c9b1 in flow_dv_translate_items ../drivers/net/mlx5/mlx5_flow_dv.c:14301
	    #2 0x5d70bed60620 in flow_dv_translate_items_nta ../drivers/net/mlx5/mlx5_flow_dv.c:14646
	    #3 0x5d70bed60fb5 in mlx5_flow_dv_translate_items_hws_impl ../drivers/net/mlx5/mlx5_flow_dv.c:14714
	    #4 0x5d70c1288ea2 in mlx5_flow_hw_create_flow ../drivers/net/mlx5/mlx5_flow_hw.c:14134
	    #5 0x5d70c128e45c in flow_hw_list_create ../drivers/net/mlx5/mlx5_flow_hw.c:14394
	    #6 0x5d70beca71b9 in mlx5_flow_list_create ../drivers/net/mlx5/mlx5_flow.c:8068
	    #7 0x5d70beca6e33 in mlx5_flow_create ../drivers/net/mlx5/mlx5_flow.c:8044
	    #8 0x5d70be95670e in rte_flow_create ../lib/ethdev/rte_flow.c:426
	    #9 0x5d70bdcaf19a in port_flow_create ../app/test-pmd/config.c:3869
	    #10 0x5d70bdc3983d in cmd_flow_parsed ../app/test-pmd/cmdline_flow.c:13564
	    #11 0x5d70bdc3a376 in cmd_flow_cb ../app/test-pmd/cmdline_flow.c:13634
	    #12 0x5d70be8ad00a in __cmdline_parse ../lib/cmdline/cmdline_parse.c:296
	    #13 0x5d70be8ad0b8 in cmdline_parse ../lib/cmdline/cmdline_parse.c:305
	    #14 0x5d70be8a87ef in cmdline_valid_buffer ../lib/cmdline/cmdline.c:25
	    #15 0x5d70be8b405e in rdline_char_in ../lib/cmdline/cmdline_rdline.c:470
	    #16 0x5d70be8a9097 in cmdline_in ../lib/cmdline/cmdline.c:154
	    #17 0x5d70be8a932f in cmdline_interact ../lib/cmdline/cmdline.c:202
	    #18 0x5d70bdc12af6 in prompt ../app/test-pmd/cmdline.c:14586
	    #19 0x5d70bdd5d636 in main ../app/test-pmd/testpmd.c:4792
	    #20 0x71e746c2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
	    #21 0x71e746c2a28a in __libc_start_main_impl ../csu/libc-start.c:360
	    #22 0x5d70bdbc0944 in _start (/auto/swgwork9/dsosnowski/code/nvidia/dpdk/build/app/dpdk-testpmd+0x358944) (BuildId: 04ff6d26a7ff0a65637cb32f087bae007e00c965)

	Address 0x71e744675730 is located in stack of thread T0 at offset 48 in frame
	    #0 0x5d70c115c601 in flow_hw_adjust_pattern ../drivers/net/mlx5/mlx5_flow_hw.c:9289

	  This frame has 5 object(s):
	    [48, 50) 'port_spec' (line 9291) <== Memory access at offset 48 is inside this variable
	    [64, 72) 'tag_v' (line 9296)
	    [96, 104) 'tag_m' (line 9300)
	    [128, 160) 'port' (line 9292)
	    [192, 224) 'tag' (line 9304)
	HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
	      (longjmp and C++ exceptions *are* supported)
	SUMMARY: AddressSanitizer: stack-use-after-return ../drivers/net/mlx5/mlx5_flow_dv.c:11059 in flow_dv_translate_item_represented_port
	Shadow bytes around the buggy address:
	  0x71e744675480: f5 f5 f5 f5 00 00 00 00 00 00 00 00 00 00 00 00
	  0x71e744675500: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
	  0x71e744675580: f5 f5 f5 f5 f5 f5 f5 f5 00 00 00 00 00 00 00 00
	  0x71e744675600: f1 f1 f1 f1 f1 f1 02 f2 00 f2 f2 f2 00 f2 f2 f2
	  0x71e744675680: 00 f2 f2 f2 00 f3 f3 f3 00 00 00 00 00 00 00 00
	=>0x71e744675700: f5 f5 f5 f5 f5 f5[f5]f5 f5 f5 f5 f5 f5 f5 f5 f5
	  0x71e744675780: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
	  0x71e744675800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	  0x71e744675880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	  0x71e744675900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	  0x71e744675980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
	Shadow byte legend (one shadow byte represents 8 application bytes):
	  Addressable:           00
	  Partially addressable: 01 02 03 04 05 06 07
	  Heap left redzone:       fa
	  Freed heap region:       fd
	  Stack left redzone:      f1
	  Stack mid redzone:       f2
	  Stack right redzone:     f3
	  Stack after return:      f5
	  Stack use after scope:   f8
	  Global redzone:          f9
	  Global init order:       f6
	  Poisoned by user:        f7
	  Container overflow:      fc
	  Array cookie:            ac
	  Intra object redzone:    bb
	  ASan internal:           fe
	  Left alloca redzone:     ca
	  Right alloca redzone:    cb
	==59105==ABORTING

>  {
>  	struct mlx5_priv *priv = dev->data->dev_private;
> -	struct rte_flow_pattern_template *it;
> -	struct rte_flow_item *copied_items = NULL;
> -	const struct rte_flow_item *tmpl_items;
> -	uint64_t orig_item_nb, item_flags = 0;
> +	struct rte_flow_item_ethdev port_spec = {.port_id = dev->data->port_id};
>  	struct rte_flow_item port = {
>  		.type = RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT,
>  		.mask = &rte_flow_item_ethdev_mask,
> @@ -9298,39 +9305,89 @@ flow_hw_pattern_template_create(struct rte_eth_dev *dev,
>  		.type = (enum rte_flow_item_type)MLX5_RTE_FLOW_ITEM_TYPE_TAG,
>  		.spec = &tag_v,
>  		.mask = &tag_m,
> -		.last = NULL
> +		.last = NULL,
>  	};
> -	int it_items_size;
> -	unsigned int i = 0;
>  	int rc;
>  
> +	if (!copied_items || !item_flags || !nb_items)
> +		return NULL;
> +
> +	if (nt_flow) {
> +		port.spec = &port_spec;
> +		tag_v.data = flow_hw_tx_tag_regc_value(dev);
> +	}
> +
> +	/*
> +	 * item_flags must be zero-initialized: __flow_hw_pattern_validate()
> +	 * OR-accumulates bits into it and reads it (MLX5_FLOW_LAYER_TUNNEL)
> +	 * on the first iteration.
> +	 */
> +	*item_flags = 0;
> +
>  	/* Validate application items only */
> -	rc = flow_hw_pattern_validate(dev, attr, items, &item_flags, error);
> +	rc = __flow_hw_pattern_validate(dev, attr, items, item_flags, nt_flow, error);
>  	if (rc < 0)
>  		return NULL;
> -	orig_item_nb = rc;
> -	if (priv->sh->config.dv_esw_en &&
> -	    attr->ingress && !attr->egress && !attr->transfer) {
> -		copied_items = flow_hw_prepend_item(items, orig_item_nb, &port, error);
> -		if (!copied_items)
> +	*nb_items = rc;
> +
> +	if (priv->sh->config.dv_esw_en && attr->ingress && !attr->egress && !attr->transfer) {
> +		*copied_items = flow_hw_prepend_item(items, *nb_items, &port, error);
> +		if (!*copied_items)
>  			return NULL;
> -		tmpl_items = copied_items;
> -	} else if (priv->sh->config.dv_esw_en &&
> -		   !attr->ingress && attr->egress && !attr->transfer) {
> -		if (item_flags & MLX5_FLOW_ITEM_SQ) {
> -			DRV_LOG(DEBUG, "Port %u omitting implicit REG_C_0 match for egress "
> -				       "pattern template", dev->data->port_id);
> -			tmpl_items = items;
> -			goto setup_pattern_template;
> +		return *copied_items;
> +	} else if (priv->sh->config.dv_esw_en && !attr->ingress && attr->egress &&
> +		   !attr->transfer) {
> +		if (*item_flags & MLX5_FLOW_ITEM_SQ) {
> +			DRV_LOG(DEBUG,
> +				"Port %u: explicit SQ item present, omitting implicit "
> +				"REG_C_0 match for egress pattern",
> +				dev->data->port_id);
> +			return items;
>  		}
> -		copied_items = flow_hw_prepend_item(items, orig_item_nb, &tag, error);
> -		if (!copied_items)
> +		*copied_items = flow_hw_prepend_item(items, *nb_items, &tag, error);
> +		if (!*copied_items)
>  			return NULL;
> -		tmpl_items = copied_items;
> -	} else {
> -		tmpl_items = items;
> +		return *copied_items;
>  	}
> -setup_pattern_template:
> +	return items;
> +}
> +
> +/**
> + * Create flow item template.
> + *
> + * @param[in] dev
> + *   Pointer to the rte_eth_dev structure.
> + * @param[in] attr
> + *   Pointer to the item template attributes.
> + * @param[in] items
> + *   The template item pattern.
> + * @param[out] error
> + *   Pointer to error structure.
> + *
> + * @return
> + *  Item template pointer on success, NULL otherwise and rte_errno is set.
> + */
> +static struct rte_flow_pattern_template *
> +flow_hw_pattern_template_create(struct rte_eth_dev *dev,
> +			     const struct rte_flow_pattern_template_attr *attr,
> +			     const struct rte_flow_item items[],
> +			     bool external,
> +			     struct rte_flow_error *error)
> +{
> +	struct mlx5_priv *priv = dev->data->dev_private;
> +	struct rte_flow_pattern_template *it;
> +	struct rte_flow_item *copied_items = NULL;
> +	const struct rte_flow_item *tmpl_items;
> +	int it_items_size;
> +	uint64_t orig_item_nb, item_flags;
> +	unsigned int i = 0;
> +	int rc;
> +
> +	tmpl_items = flow_hw_adjust_pattern(dev, attr, false, items, &orig_item_nb, &item_flags,
> +					    &copied_items, error);

This is something I missed on v3, sorry about that.
flow_hw_adjust_pattern() takes:

- "item_flags" as 5th argument,
- "nb_items" as 6th argument.

But both call sites of flow_hw_adjust_pattern() pass them
in reverse order.
Please rearrange the call sites.

> +	if (!tmpl_items)
> +		return NULL;
> +
>  	it = mlx5_malloc(MLX5_MEM_ZERO, sizeof(*it), 0, SOCKET_ID_ANY);
>  	if (!it) {
>  		rte_flow_error_set(error, ENOMEM,
> @@ -14272,7 +14329,6 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  	struct rte_flow_hw *prfx_flow = NULL;
>  	const struct rte_flow_action *qrss = NULL;
>  	const struct rte_flow_action *mark = NULL;
> -	uint64_t item_flags = 0;
>  	uint64_t action_flags = mlx5_flow_hw_action_flags_get(actions, &qrss, &mark,
>  							 &encap_idx, &actions_n, error);
>  	struct mlx5_flow_hw_split_resource resource = {
> @@ -14289,20 +14345,27 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  		.egress = attr->egress,
>  		.transfer = attr->transfer,
>  	};
> -
> -	/* Validate application items only */
> -	ret = __flow_hw_pattern_validate(dev, &pattern_template_attr, items,
> -						&item_flags, true, error);
> -	if (ret < 0)
> -		return 0;
> +	struct rte_flow_item *copied_items = NULL;
> +	const struct rte_flow_item *prepend_items;
> +	uint64_t orig_item_nb, item_flags;
>  
>  	RTE_SET_USED(encap_idx);
>  	if (!error)
>  		error = &shadow_error;
> +
> +	prepend_items = flow_hw_adjust_pattern(dev, &pattern_template_attr, true, items,
> +					       &orig_item_nb, &item_flags, &copied_items, error);
> +	if (!prepend_items)
> +		return 0;
> +
>  	split = mlx5_flow_nta_split_metadata(dev, attr, actions, qrss, action_flags,
>  					     actions_n, external, &resource, error);
> -	if (split < 0)
> -		return split;
> +	if (split < 0) {
> +		mlx5_free(copied_items);
> +		return 0;
> +	} else if (!split) {
> +		resource.suffix.items = prepend_items;
> +	}
>  
>  	/* Update the metadata copy table - MLX5_FLOW_MREG_CP_TABLE_GROUP */
>  	if (((attr->ingress && attr->group != MLX5_FLOW_MREG_CP_TABLE_GROUP) ||
> @@ -14313,23 +14376,26 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  			goto free;
>  	}
>  	if (action_flags & MLX5_FLOW_ACTION_SAMPLE) {
> -		flow = mlx5_nta_sample_flow_list_create(dev, type, attr, items, actions,
> +		flow = mlx5_nta_sample_flow_list_create(dev, type, attr, prepend_items, actions,
>  							item_flags, action_flags, error);
> -		if (flow != NULL)
> +		if (flow != NULL) {
> +			mlx5_free(copied_items);
>  			return (uintptr_t)flow;
> +		}
>  		goto free;
>  	}
>  	if (action_flags & MLX5_FLOW_ACTION_RSS) {
>  		const struct rte_flow_action_rss
>  			*rss_conf = mlx5_flow_nta_locate_rss(dev, actions, error);
> -		flow = mlx5_flow_nta_handle_rss(dev, attr, items, actions, rss_conf,
> -						item_flags, action_flags, external,
> -						type, error);
> +		flow = mlx5_flow_nta_handle_rss(dev, attr, prepend_items, actions, rss_conf,
> +						item_flags, action_flags, external, type, error);
>  		if (flow) {
>  			flow->nt2hws->rix_mreg_copy = cpy_idx;
>  			cpy_idx = 0;
> -			if (!split)
> +			if (!split) {
> +				mlx5_free(copied_items);
>  				return (uintptr_t)flow;
> +			}
>  			goto prefix_flow;
>  		}
>  		goto free;
> @@ -14343,12 +14409,14 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  	if (flow) {
>  		flow->nt2hws->rix_mreg_copy = cpy_idx;
>  		cpy_idx = 0;
> -		if (!split)
> +		if (!split) {
> +			mlx5_free(copied_items);
>  			return (uintptr_t)flow;
> +		}
>  		/* Fall Through to prefix flow creation. */
>  	}
>  prefix_flow:
> -	ret = mlx5_flow_hw_create_flow(dev, type, attr, items, resource.prefix.actions,
> +	ret = mlx5_flow_hw_create_flow(dev, type, attr, prepend_items, resource.prefix.actions,
>  				       item_flags, action_flags, external, &prfx_flow, error);
>  	if (ret)
>  		goto free;
> @@ -14357,6 +14425,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  		flow->nt2hws->chaned_flow = 1;
>  		SLIST_INSERT_AFTER(prfx_flow, flow, nt2hws->next);
>  		mlx5_flow_nta_split_resource_free(dev, &resource);
> +		mlx5_free(copied_items);
>  		return (uintptr_t)prfx_flow;
>  	}
>  free:
> @@ -14368,6 +14437,7 @@ static uintptr_t flow_hw_list_create(struct rte_eth_dev *dev,
>  		mlx5_flow_nta_del_copy_action(dev, cpy_idx);
>  	if (split > 0)
>  		mlx5_flow_nta_split_resource_free(dev, &resource);
> +	mlx5_free(copied_items);
>  	return 0;
>  }
>  
