Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDCFCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 13:03:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8673402BC;
	Wed,  3 Jun 2026 15:03:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 37F0A402A9
 for <dev@dpdk.org>; Wed,  3 Jun 2026 15:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780491821; x=1812027821;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+YcPem4jlBeIcGCEnKTd2XEHnJu9mQUY30pDMNQ5fBc=;
 b=TU0KiQ7PmLZbf/hZ4YUxM0Rf7BNUqBaVDfH+tdn/2RIn9U3COmxKniYM
 mA15krc8gGEO9ELcSpckzbOBz3TKkZDxpa5tKRG4r31RqVS7AHMYgSWsQ
 VsiRUB1gB3I1fsQsl3rzCLym1FFbf+rqlzKZ39UpT0n3GwhR+yttIhU2P
 XbnKazg3u9iyQ2YjHvXW90EAVvcwgzREA1QohQ3zbWy2J+6WnT3Mnqs0z
 l07cibGB1zHFXQOo0uNe4/h29V6PWuD0wISDUbcpOOfxTpe0iMa9MGEL6
 AC1vbgUJcEIJT4oHkPh+EvxntBPii7wQI0FpjAQWp+LpzndpDvt51KKxO g==;
X-CSE-ConnectionGUID: utx+dyIbSF2Kk/eFS+qhJw==
X-CSE-MsgGUID: B3hsmIFVRXmZQToCxBWqMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81295095"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="81295095"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 06:03:40 -0700
X-CSE-ConnectionGUID: 8mIghx7XS9WS/06wxbwDCQ==
X-CSE-MsgGUID: ip98sDnJRzi3fiKVsWuQQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; d="scan'208";a="243178188"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 06:03:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:03:38 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 06:03:38 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 06:03:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qwoa3SwSjtQP5w3IpxcIZbt2m3INgltkKobzoPswFPpOHSTfA1wDhg/FJsvpVrkh2IR6gXBgHCN1fqN8PCFltSgvtlSEYL1IDPvNZp9aMb9w6Xtw/Nr2V8xLMm4iyRoH34K6oYLeoSn40UPswMpqnMbiIX/a07pNb47vafmgFgZeHlZYtWu8nN6eOxynxHA7nxuMcuyWPIjCQKi4EkqiTyZ0+H8MZzmJWt59somOauO/NSx8wvVa4ACgy86Yy7COB9cmDY0goYPTBiixeItbc9fVgvc7gfeWY2UStEDbW3u6eTru+fGxulEbOvb6MC/eLDcPHH1Ya+U4WVbzLXENPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/yd8gvLxiUPiQoEGWPh/ffgBQihhmmP3IbGaiWtl6k=;
 b=ovXaJpdCtyVYCW/xdAGFSEkPkwA25xw0XkGwB9pTga7y6x9rXPoJUdimVb/BX++aj5BOZuJgd09nUOWLWKiSKNaaRzfT80cIrtlxV+OMkOiCIn+vMjbM2iNhVvIpeprrYNq7+crQzcJ84hlFnZJZ7uAv8JW7TmLYL68q4JD+N4NJxHco00il+mFf+YItPseF+vJd4Sna1J8zUJr4d9XwLTS2hbBdpLTEs5kHKGjTNFexEJzGQP6gwpMlEQtKIUijw1HD7Xxd0aWr1theX8FN52WrAHQcwWwsfR//uXStnyEPNvC7ycm3hjKXeqU9h8jjrPbr+YUqs4Z4IEonZPCqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 13:03:28 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 13:03:27 +0000
Date: Wed, 3 Jun 2026 14:03:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v6 03/27] net/intel/common: add common flow action parsing
Message-ID: <aiAmGWmhD2n5ZPAc@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1780068633.git.anatoly.burakov@intel.com>
 <cover.1780068633.git.anatoly.burakov@intel.com>
 <6834ddc6a6bc96b18f0078c2b99a58114bda54e7.1780068633.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6834ddc6a6bc96b18f0078c2b99a58114bda54e7.1780068633.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU6P191CA0049.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a6da6c-4b63-45c6-6e4d-08dec17080bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: cCzPYTyQ4wUtk6VlHhB2OtqNJGLAuCf2XzJoDWUrZf1ERducrYtyAeBxep/uA0MLi94yc8gKDhuJPLDbsE31LKu6TvrZodjylV+b7mEI3DdPdC1kZ16UHe5a5IL6C7lDZ8jmxjs1Yc29M2pxBlthT4as4M6L5uQTri4FTRUQ6QS6m4Bq9m7H5pM/XQ45/ElnsBO+h21GaX+v+oZ/MvQ9kwcbbLwhTiH/saUMh9ppEjNXmt3JoZXiktbmxEKu4aninvGx1O72D3Ud/WgHeWVB7zFzH5etNTGRhkDBc57Igxq6tni16yNrYTLXBmNGFRblbPhyj/ZUKzguSktrdKbmz1rvFNMFKKtfd4eahKHltcQbae8Z4KqEHw2DJKlfSqB/P1r53OHNXDmupmFWglxtMM/RLBi76E5xl+ACa00mY16f/WQaKOMDqFbd0hxibSJovOeE+Iz7AlirYmc/uQNTu7mvIQ1o+qhO5sbXk8H7aT6IsQHiw2viQF20uA5GglxAhL1Zp8ryPBNH719mA/1o/Y/XzAN+ccb3PGhctYyxzqZPX8l7IhGdSr34A6ZToT3o0OdjD1x2NKvL3oDTMdzrWmFCldpvvoY/gmikM6d5rQQsXYndHQqvuJM9ePDrLjkSCFYun3K3q+uEuaxJJfN36aZy5xNTtnzhNR8FSjoPyZ1HQDhRbsdMxd8eehpiZTQR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecep9NGG1NR7yMjihaFKbm5sZSBduhfFHnyS3jKLyuj9nxKv68gj2/CGY/Hn?=
 =?us-ascii?Q?kZwI+Lz2QTIKhk1NkeXrolQJb+Hp15Hl+NrUl6+XZ9VFLuT+q07GPOU5wG9c?=
 =?us-ascii?Q?2xIrnaGRQQiZ+afMI6wkC58ZTdjMYOE5MSJ4AA4eznHnDUuXLUm1z88uPutj?=
 =?us-ascii?Q?s8whtJx7OkEhR4HbFVeK0kanIYZZfxlHvNQ5bckxIusYU+4vIzIQ/n63GDPY?=
 =?us-ascii?Q?Mpj+qUy7uxrS26XuZye4VNpOKuZ9rnaYZ4FSNLFbkd9GSxNQkA2MUUuo83Cv?=
 =?us-ascii?Q?b5aQWB0b/+cGgTizlhqHi4TfoAl7MIJGi1+DcBSEslDB8up0TXtSiWzh0ph1?=
 =?us-ascii?Q?O+hnbmV+60DHwYIWntgZD0TvU9jLHqXJh3Zqar3FfFwXdiJ3a/ibY0Jr1Cr0?=
 =?us-ascii?Q?x49G4Uq8eqY+lgtk6dyV1u5LUn7poRZ2ccSQrFyivo9FYWy/zHzA2F9EwtdR?=
 =?us-ascii?Q?/ugdwYA7OgB9r4RiPuAp6zBbt/F60DAvYE4g+WICwV3npUo+8mVpWi+Yc5fl?=
 =?us-ascii?Q?SIfKnaxLNPvhiYaR4cWquA2TGNMdzRfmxY+7NMgg+B+2F+rl0LLgGkFSp+Ws?=
 =?us-ascii?Q?gxV5czgnqjFs4qxKrENHTPnn23oIOzjoPEzJknGYRco8EqOdU2lr00Z2wa2i?=
 =?us-ascii?Q?FRAV7RjrAuh0zNRWroTov3LKZ9IH5tIt26S95F41apZQiDKJxSwY01gOdoKH?=
 =?us-ascii?Q?YKaFSwfRfBGRRvNdIfICsh5j72UiPT9eEa8kyi/r+a/HDE/qzLLPjsKuJ6sB?=
 =?us-ascii?Q?kBJsk59v9AZe1obA07VzLblFyKDqkRffHYDOnW1aQE3+InfQlZLdTmxEtKPl?=
 =?us-ascii?Q?+Ipge/t/BaqwCZEuKl7zWUeztlIMHbwvi26rayvhdlPbIV6JbLcbRyvy6oPR?=
 =?us-ascii?Q?2BYZ4pNKIPmrVp8388iZoBtSXYV9cgugaFyZcgXB2qoTP5kftv5ZbuIBQg0x?=
 =?us-ascii?Q?V0ltud5/Sv3AF/IqMr2duxHCFno1acSGqzpYUpdUOikMZpbqCe7DsPUIebyy?=
 =?us-ascii?Q?6UrnantiARt/BNIVlGc4FUtuguFEkl7C5vhIA2apno9peSAHcmEY1eEwiYqU?=
 =?us-ascii?Q?x2vx/EymNFaMeKuN/AfWJ5G1cbEMAz678kMdKAXfgw5xu0vkSfTPnErEDY+J?=
 =?us-ascii?Q?3+DZxxM+Yxf3fcUL5kq0ohRTbXLxzlIMD0EIl2wB+j4/iJHbxDq+dUE8r793?=
 =?us-ascii?Q?b6mnZq0AkKeU0/wzsEIMFM7VY0QvME5k+X0OwYA6pWNnrQRYP6dcFksBtSyg?=
 =?us-ascii?Q?aVbzfUhVlbDzWYwlsVIetRP7jlS5yTFXYRnr+5tfLiZlDWzwdi94lCVlrPnK?=
 =?us-ascii?Q?IaJvIx35ctdaN5sxuBD8YXW4s6nwoacpq+A3H7VLOI8gmnw46HiYdJQzfJTN?=
 =?us-ascii?Q?mBVJ0XpcPHS8MbUpIh7By8DHtiVJ3KLPEmtGqKy0zLvFVPGStySqvunwBQLZ?=
 =?us-ascii?Q?NdjPASuGl/e4z0a00xg/pdezdwKuW9PaXkWY0VHk90zFuMqWubnZurUXU2lW?=
 =?us-ascii?Q?BB7yytqBJyx28ZO/b6YTuckqEJz4z8RV1MNE/omIzSw4bjjd2GRSqc2aaDsz?=
 =?us-ascii?Q?AKqE1eWaAamAC5g+OToDFHiIOXak52n/UH7LnE5F9E0Sb4S/eBTEBRlH1sV9?=
 =?us-ascii?Q?tkxvOSQFqg5J5tspvk/7/BpxPqKqBMX1pROuISrLNjTFiWwnyrE41xNwpaEZ?=
 =?us-ascii?Q?oqK+fw/HGmo0K4QRrE+0NU6ZFhXq9Uo4as4OjpkBQY65WH8XOhyZNc/4iNWs?=
 =?us-ascii?Q?Ev0FTerARD4YUUpnvjHDfH/NFFQNdmU=3D?=
X-Exchange-RoutingPolicyChecked: Bdh/WYkmjQ4DolnGB5xAR/bNGZzQXnZ7j2Jz6fQ5+R9H2OPjQ53Knhis/bWbNEgnIMplhTktqD/PhkP5u3UVmKMbRQ5Dc/DmizEdHAKqtMV1v9FGKE1sbetsEjwcjgHPSpFF1cUVf3F9H06d+BTycAl9J6xj8PkXNtBEY54kugEfnF2vjBuipDbjm0oBOBDejXp+iU4wG1HKYW7VbP7Ui61vDF1hMT3u1JYPWYr67yFsGIHudlvkE+Msn/AEM2995a2PGlsEFUubpWUPlkn0+ViL1th8bvUF+l0MDwRxGkEIc52Le9d9w5zZj/kezb4Rm1VCXfb7Qv95RXEbqSBr8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a6da6c-4b63-45c6-6e4d-08dec17080bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 13:03:27.7143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGfjxVU0IsbJD+f3Fn3g1n3Wl2ouOlGK+n7Eg+oxHk1mJ3RPL8fRSdOh4a44WAQCa2nyxZumJP6QxxWbp98D7rGmcLsvG3OrA45nskskzz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
X-OriginatorOrg: intel.com
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

On Fri, May 29, 2026 at 04:36:05PM +0100, Anatoly Burakov wrote:
> Currently, each driver has their own code for action parsing, which results
> in a lot of duplication and subtle mismatches in behavior between drivers.
> 
> Add common infrastructure, based on the following assumptions:
> 
> - All drivers support at most 32 actions at once, but usually far less
> - Not every action is supported by all drivers
> - We can check a few common things to filter out obviously wrong actions
> - Driver performs semantic checks on all valid actions
> 
> So, the intention is to reject everything we can reasonably reject at the
> outset without knowing anything about the drivers, parametrize what is
> trivial to parametrize, and leave the rest for the driver to implement.
> 
> While we're at it, also add logging infrastructure for Intel common code,
> using the new component name defines that are automatically passed to each
> DPDK driver as it is being built.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/common/flow_check.h | 279 ++++++++++++++++++++++++++
>  drivers/net/intel/common/log.h        |  40 ++++
>  2 files changed, 319 insertions(+)
>  create mode 100644 drivers/net/intel/common/flow_check.h
>  create mode 100644 drivers/net/intel/common/log.h
> 

<snip>

> +/**
> + * Validate and parse a list of rte_flow_action into a parsed action list.
> + *
> + * @param actions pointer to array of rte_flow_action, terminated by RTE_FLOW_ACTION_TYPE_END
> + * @param param pointer to ci_flow_actions_check_param structure (can be NULL)
> + * @param parsed_actions pointer to ci_flow_actions structure to store parsed actions
> + * @param error pointer to rte_flow_error structure for error reporting
> + *
> + * @return 0 on success, negative errno on failure.
> + */
> +static inline int
> +ci_flow_check_actions(const struct rte_flow_action *actions,
> +	const struct ci_flow_actions_check_param *param,
> +	struct ci_flow_actions *parsed_actions,
> +	struct rte_flow_error *error)
> +{
> +	size_t i = 0;
> +	int ret;
> +
> +	if (actions == NULL) {
> +		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
> +				NULL, "Missing actions");
> +	}
> +
> +	/* reset the list */
> +	*parsed_actions = (struct ci_flow_actions){0};
> +
> +	while (actions[i].type != RTE_FLOW_ACTION_TYPE_END) {
> +		const struct rte_flow_action *action = &actions[i++];
> +
> +		/* skip VOID actions */
> +		if (action->type == RTE_FLOW_ACTION_TYPE_VOID)
> +			continue;
> +
> +		/* generic validation for actions - this will check against param as well */
> +		ret = __flow_action_check_generic(action, param, error);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* check against global maximum number of actions */
> +		if (parsed_actions->count >= RTE_DIM(parsed_actions->actions)) {
> +			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
> +							action, "Too many actions");
> +		}
> +		/* user may have specified a maximum number of actions */
> +		if (param != NULL && param->max_actions != 0 &&
> +		    parsed_actions->count >= param->max_actions) {
> +			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
> +							action, "Too many actions");
> +		}
> +		/* add action to the list */
> +		CI_DRV_LOG(DEBUG, "Parsed action %u: type=%s", parsed_actions->count,
> +			   ci_flow_action_type_to_str(action->type));
> +		parsed_actions->actions[parsed_actions->count++] = action;
> +	}
> +
> +	/* now, call into user validation if specified */
> +	if (param != NULL && param->check != NULL) {
> +		ret = param->check(parsed_actions, param, error);
> +		if (ret < 0)
> +			return ret;
> +	}

Running an AI review on this code myself, it highlights the fact that we
are missing a check for an empty parsed_actions array here, and not all
check handlers verify the length as being >0 before dereferencing. For
example, in patch 10, the callbacks don't explicitly check for empty lists 
I think it would be reasonable to have the return -EINVAL before this
callback check, right?

> +	/* if we didn't parse anything, valid action list is empty */
> +	return parsed_actions->count == 0 ? -EINVAL : 0;
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
<snip>
