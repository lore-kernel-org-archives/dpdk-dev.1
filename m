Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0B3EC1EB9
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 13:44:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48A2640ED9;
	Thu,  5 Feb 2026 14:43:59 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by mails.dpdk.org (Postfix) with ESMTP id 88BE840E09;
 Thu,  5 Feb 2026 14:43:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+ymclxS+mF7BqPq+LOq5XN6I6ASFD68CZgXo2ZrG88jki5kbCt5y9H/F43flbvx5JL1YGVsszITA3ExvoV1zY8h4mMoV00QL1PaNFtWYfpMVQP1re4QT2lfNI3S8v7zpoa5mQYbrBPd5PRIf3vkq0DsCe8qEhD4KrK9QOIHxr0+2BcmQpGWlhmsugL9618kQrbPfWsh9gItqY/zkwDrPwcmW8Fk6U6GX5FS6u/+yb2mR1nroiwTBgeYsGRtB22C2h9agIjGREjfKHcc9QsM5/yyMdU9RttDuysjKauJbqgIvjOKyKwjeh9OIdLXhK4DkZiwpX4roOwj7P76EuZfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GlPOasRrailuzQliE/f9I49TsfBkfS/1UmcvC1bbt4=;
 b=ozGFK5zvGaaA1JUWE9SkVF4l6k6OPNfRfowrOKWXOR4cDwY91NV7NOli/jTa8hT0cBoRv2S6gIZUZUMRD52wDVzVzKSlbbxsYBpYsS4S9WdHJhCTFUZEHdwRcMTiDn4foodA27El4BAaZgPwZDi6RCNYNJ4chroWiuZqIvdVWXv3gNvM0uzQkGmI4l7gqIenMGrtWaypOTIxGTSiUWUe93x+i6/yQiny05nK1zYApr+oRIvxGoUmQ+13uXutkQs+dCmFo/SeHz/McDJahgRNuFi38ehHwejWgtGqeCIQWZ3IhVzj3fpKYwznM59QXuUfBPsLYz5Jr7ii6LfMSVWR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GlPOasRrailuzQliE/f9I49TsfBkfS/1UmcvC1bbt4=;
 b=Tw8HOGB4BUhVQcc0IHvVK0SdfBgwmrT4dSQrOUAxQM/iRqh+3CWmZyH/aIW+RjIhYBH3jEhkZyoKYQBr8lVelvTfQI4SYQ2MCysbkT30sV4MV6sdF2eHWPONwlkwMZgs+XwmruWJ47lAVycoaQPvrvgTq3t6/FEGfY3JFmXGiUND+c0fc1KbpLNWmI2DiSrkYSjMeSTnX/fEqAtL0lXx6dTN3ZLS7HtBFHSjpYvGFZrPPzqLPPYFm89CCFyUpjaaqsO1fCnKqVq5DhLMr+nM1qJYVxhQ9a9TsNIZvq8uajNAFo462rzVXDfRZRLxVYYlFl1qs1UgpCwhEh3+plwTTQ==
Received: from BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 13:43:53 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::4a) by BL1PR13CA0180.outlook.office365.com
 (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 13:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 13:43:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 05:43:36 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 05:43:35 -0800
Date: Thu, 5 Feb 2026 14:43:35 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>, Alex Vesker
 <valex@nvidia.com>
Subject: Re: [PATCH v5 5/6] net/mlx5: fix LTO stringop-overflow warning
Message-ID: <fn3ooyikqw7dwka3kmwz2mtpigukakvwyema44othruighbmjn@ye5xqkfbnzm7>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
 <20260120195418.466318-6-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260120195418.466318-6-stephen@networkplumber.org>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4df5f0-16c6-4e32-bec0-08de64bc9a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X7XGUfJVqq3n0E3OBqNnijVekcwOyxpnfXYUxJUDpaichI4Y0bmv8Cy8rLl7?=
 =?us-ascii?Q?+mMjWz3eG+PhMW6vZVigaXLnar89acRD6XHS5yIeSSBoQpmSw8hpHK4+oKn6?=
 =?us-ascii?Q?2ShqfDpvx9dY+Fx8NMDRk1+VHLEjhU9JsTVZx1reAzkV1mtG6Sr8nudliaMx?=
 =?us-ascii?Q?ffTfGhqFFVroN73XByrtX4a5lbxZw22Z2NUS3QhpnrDrG8E3HmvqgbrK1Y4d?=
 =?us-ascii?Q?rmE99U6WuEMhUfPD00/McYU/49OnzAAdVAbGMr5HP6NBpdV1jvWVOVoXx7fP?=
 =?us-ascii?Q?OjK/qHjhVZ/M0IGR/CWCRF+f448SSL8aSg/e8t/58g+U9Es6n3I8MzafQRK2?=
 =?us-ascii?Q?lAf6leA/z8DInmH4I8dPS7oYJvlIF4a9WoDoFlQ/pSYvZ2almX9s2i5atXhx?=
 =?us-ascii?Q?4y4cFiCNGjARSMpg3435gz4YY7MJHGqMgKHBklC3zYbAqJLI66IJp9riuXzU?=
 =?us-ascii?Q?B/OXNsqcb55ZEks87IQNGQGJIpVMO5XAmdj1BVDc6OI8c0HH+sDbJclck8hx?=
 =?us-ascii?Q?Me96ledYA/+cTi2H09at+7CUmUiIVZt9ua7pE9LTXNEtfmeIoHVOAvO09X6/?=
 =?us-ascii?Q?nSt/kzlkNyG25/7OBYc2Q4Bn7FGkFd0nVW9BTpDrIdQqJTeBq4wiAGZuBwbd?=
 =?us-ascii?Q?eGvLUwCUqNzLldfoEBprzUxfzolw+/fmZ88u7uUohoLooFFIbFO03PXucf0p?=
 =?us-ascii?Q?tHQFKe6ebIzleGSdQNTpmwzZ25HcKrYDFOghHagbXvfZcc31bw4G3015oKB1?=
 =?us-ascii?Q?gwhovOv8zI78oPDVy0kst79+W6e6jXB0IUrcgJx4Ei1Akf/vV4N3raNR5M9c?=
 =?us-ascii?Q?TXfbBN4++69GTebv8qSQvg3rOEnl6g9XuTDXiOPILbO2I/y0fRiYAH5ms8di?=
 =?us-ascii?Q?mrdcQBIxMKHS4EIgj1klEeWYrmL3+8i6G3fzr3hEMtGr6z8zL382R9J/uqUj?=
 =?us-ascii?Q?jvDQNKqplbLSe94BLK/aX3F/W/D7LCMTLRB8WC1bEvGCMhiYIyr2GXGWHQyY?=
 =?us-ascii?Q?wzcy0vM0HxJPPzN+9awE6jWyJeEIgbqnJgscB2gELOXsdWxFZpHuJIUYdnb8?=
 =?us-ascii?Q?NHM3S0WUrJGID3Eba2Myf98KJQcxoXFlTh+fJlOHs5cTBthVRnnmez2Kpjtl?=
 =?us-ascii?Q?Hzm2vjd3NJFUI4amQPNbldJOdQK8xd47BO7gsOPKOlN8ROl69r0bVAkBjcU1?=
 =?us-ascii?Q?pZon/mdtcsejUOy9vgAZnzuR+j59sP76fcC0WVrEsPXgWgzGlc2EsAkbPBrr?=
 =?us-ascii?Q?IBaxBdk9UHD0DHsVbtT+ls3eyUb5T1Ul4aph8gR2VClLopXRi4lTPeTRg7J8?=
 =?us-ascii?Q?c29RFwA/UoFnp6D79fbcO+aU8UjrUWr8D1a1Yjuez0FqLnN3XhJlqHtnCRTm?=
 =?us-ascii?Q?2XTBX2XsFoLNC54LuIPbYy46wuvNIUI+hZIdiWJZFS4n+dAXyxJJPecrDPHi?=
 =?us-ascii?Q?DSDCwh464Qm5A4t7mneCe4v5J9PPt/9IKhjgJ7N1lY66oXATAXCVFCBY08Jt?=
 =?us-ascii?Q?dxKKx3mTi/iVgYodjGCpm12I7L44b910G+tSuPtXrkFAGDfdD3fT8IpgSa4Q?=
 =?us-ascii?Q?LglVyRhd1+7SguCydEXRLI8A9zLR96agNCffP4sdGenq/DdIc187be0FiHLo?=
 =?us-ascii?Q?KP7PJ4KE0iuQ1/MYCTRUjTZEcUX5MpJCT3K0vRf+xv2WjtdkEdMoLWOTEKJm?=
 =?us-ascii?Q?MaILiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZufwTYlXwtyDrJsn2/IjigIkLUzO9bL9U9ddIrc5gE43cmzmklQGiZp6Z3G6Ko//BV28knZHGMzeuKxYcKBNfWaIL03hCHNmdT3tGBcRW9THloomLsml0gHiZqCOF76zDqi/ljXuHZIPS5O+PFmqn+U+pwLIGA9hHjkar4W2D2KFCgk2J0UYpgC2XcPh8sQXzEYUutOQMjzjsEKqxX/fQhSAXOrL16tAYCR/9DBaOsuNCI+UI5t07eqAmHY9sk1aaAzjO0+7KJjW4PFhyxkAaUotipsj5Bf4IpGyrbA6leUbbP15/3zstyY42mQELhxSux91ShTeVOYpJbTo/VgCGilMo7jBrOeG8Yw+ruyarnt9uVVdPBUkB5aebKv02HUQzQ1lwkOTTOoV1DFegmgr4llYGbV2WOtvSre77mg79+5CSGslzWAiVR3RpiUiRinw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:43:53.1918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4df5f0-16c6-4e32-bec0-08de64bc9a03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

On Tue, Jan 20, 2026 at 11:52:10AM -0800, Stephen Hemminger wrote:
> When compiling with LTO (Link Time Optimization) enabled, GCC's
> interprocedural analysis produces false positive warnings about
> potential buffer overflow in mlx5dr_action_prepare_decap_l3_data():
> 
>   In function 'mlx5dr_action_prepare_decap_l3_data',
>       inlined from 'mlx5dr_action_handle_tunnel_l3_to_l2',
>       inlined from 'mlx5dr_action_create_reformat_hws':
>   warning: writing 4 bytes into a region of size 0 [-Wstringop-overflow=]
>     memcpy(dst, e_src, MLX5DR_ACTION_INLINE_DATA_SIZE);
>   note: at offset [140, 524248] into destination object 'mh_data' of size 64
> 
> With LTO, the function chain is fully inlined, giving GCC visibility
> into the 64-byte stack buffer 'mh_data'. However, GCC's static analysis
> cannot determine that num_of_actions is constrained to either
> DECAP_L3_NUM_ACTIONS_W_NO_VLAN (6) or DECAP_L3_NUM_ACTIONS_W_VLAN (7)
> by the callers. It assumes worst-case bounds that greatly exceed the
> buffer size.
> 
> Fix this by adding an explicit bounds check at function entry. The
> valid values for num_of_actions are 6 (no VLAN) or 7 (with VLAN),
> which produce maximum buffer usage well under 64 bytes:
>   - offset 12 + (num_of_actions-3) * 8 + 2 = max 46 bytes for 7 actions
> 
> This provides GCC with the proof it needs that subsequent memcpy
> operations are safe.
> 
> This is not a data path function - it executes only during flow rule
> creation, so the additional check has no performance impact.
> 
> Bugzilla ID: 1710
> Fixes: f8c8a6d8440d ("net/mlx5/hws: add action object")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/mlx5/hws/mlx5dr_action.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
> index b35bf07c3c..3b12506577 100644
> --- a/drivers/net/mlx5/hws/mlx5dr_action.c
> +++ b/drivers/net/mlx5/hws/mlx5dr_action.c
> @@ -3620,6 +3620,20 @@ mlx5dr_action_prepare_decap_l3_data(uint8_t *src, uint8_t *dst,
>  	uint8_t *e_src;
>  	int i;
>  
> +	/*
> +	 * Bounds check to help GCC LTO static analysis.
> +	 *
> +	 * When LTO inlines this into mlx5dr_action_handle_tunnel_l3_to_l2(),
> +	 * GCC sees the 64-byte mh_data buffer but cannot prove num_of_actions
> +	 * is bounded, causing false -Wstringop-overflow warnings.
> +	 *
> +	 * Valid num_of_actions values are DECAP_L3_NUM_ACTIONS_W_NO_VLAN (6)
> +	 * or DECAP_L3_NUM_ACTIONS_W_VLAN (7). This check gives GCC the proof
> +	 * it needs that the loop iterations stay within buffer bounds.
> +	 */
> +	if (unlikely(num_of_actions > DECAP_L3_NUM_ACTIONS_W_VLAN))
> +		return;

This function can be executed as part of fast path
in async flow creation, so if possible
I would avoid adding such a condition.

I tested locally with GCC 14.2.0 and it looks like
if this condition is changed to equivalent __rte_assume(),
then this condition is removed from generated code
(https://godbolt.org/z/afx8jjr6Y as an example,
code generated by LTO also optimizes the relevant code).
__rte_assume() also fixes the LTO warning.

Could you please change the condition to equivalent __rte_assume()?

> +
>  	/* num_of_actions = remove l3l2 + 4/5 inserts + remove extra 2 bytes
>  	 * copy from end of src to the start of dst.
>  	 * move to the end, 2 is the leftover from 14B or 18B
> -- 
> 2.51.0
> 
