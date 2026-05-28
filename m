Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F049CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 15:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E2494021F;
	Thu, 28 May 2026 17:09:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id DFC694003C
 for <dev@dpdk.org>; Thu, 28 May 2026 17:09:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779980963; x=1811516963;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ICOQrPwAeLabG4bF8MFisDZlX9SS/LE4UpdIlan066o=;
 b=GzM8GioLEMcjK06Ixvt/3J8Wa2iexl8SHqgt1x1nmCPPNlgogWgHbgNI
 NpJGT3IkP56nYM77QR3+1I+vWUrcB+zvWoKMoK2GV9iNy0adgZvQIzsuW
 p5SJ2LeCwyW7flgl6B2BTV2tMJsYCFo48VI9EpgKAWo22g5IROBEGRH/p
 x6NzeHEAhzPTsKj5hyyuBBPiYtnf9uhvaxvb9ZWZ9Ns3rvW4HVZG8OW1l
 k8uFoypw4w7J77VQDopKkHrIvhVYSdUOIN/AijwEbdYcAc3K1ix4cXFx3
 1vA7FnBsRDCcV1NNIuS2jfTRqLi7Rp96Q/zVo+gShpJ2HJLaEBCW663Cr g==;
X-CSE-ConnectionGUID: c8NyKlA8S0yNVmWLzK1cmg==
X-CSE-MsgGUID: RyVAHFWSQvOibhjdgmxf8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80795273"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="80795273"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 08:09:21 -0700
X-CSE-ConnectionGUID: QE5vtLv1TM6/2FjbZwVCzw==
X-CSE-MsgGUID: pLXDi1bTTvuh1EGzZcnWfw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 08:09:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 08:09:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 08:09:19 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.64)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 08:09:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLV6C0tf0UmCYQ3wYtQILhdL495WIcJ7syLXRIiuaUq8R97n6p/kWPSXhu+WpYDVHAnNwj3uO6CYaXIiHpAqYjTlWdqIivPcv4zTMyixsmmmbi4kDodirSWmx1CnygkW0kzxovFAjktscmEKYL4cY5yGZPuBDZs0eempwayNAN2eHRHV6YTAPx0TntDF80xN/NlBepXbzqE3M3zf/SADrpnDbaeystLoYOBHC2Bg7kjd/NBmPeldVGbelsVX2xYCgHlHB8PLng3VXyYKOnirF7nQAgMy2Nqzgnihis/J2Yxd5T7nTofiGbXAyecPGhA3+9m8zNTPp8G0/jNPfrTZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3vIGoydTIplbasP4X0eovpdAzrRUoxU3GRHgq2tTz4=;
 b=K3iQLAw0WCi9FKkI6/NU9X2J/uriyU+893KPO8q57+0IarBiMtWWV2IlQVTQC2GZS2BIiqRQCpNBtpnoxTGijvWMwQcoqcu7+Kf7bMcQ45NtKKwiZemgKy0ITXPal5NSQyojZ2K8CwbSBUJZPFT/G667oEr8CX9QqBqEPtozeaAtmOxFql4U2FtqjD91mfDcNTh9l3siJ8m+8bTkgssL94ugj/8YWFHFCtRjOb6OZojRv00N9G1vb+yoHuV0exopDdk94m2GeY+Dpz5J13OW6IGvB329nm2YjtXm7O/diIJM81xsCenQMy4ART29EO7iLpC6oJIUx9TGEf3krPJZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB6268.namprd11.prod.outlook.com (2603:10b6:208:3e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 15:09:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 15:09:16 +0000
Date: Thu, 28 May 2026 16:09:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 04/27] net/intel/common: add common flow attr validation
Message-ID: <ahhalkVIyoa9MaE3@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1779717943.git.anatoly.burakov@intel.com>
 <cover.1779717943.git.anatoly.burakov@intel.com>
 <d75e9a02b40ccfe8fd2e00977ee99e9be95ca9ad.1779717944.git.anatoly.burakov@intel.com>
 <ahbxgjoGdAEm99kj@bricha3-mobl1.ger.corp.intel.com>
 <9dbc8a94-ceca-41f0-b759-a23cbae76902@intel.com>
 <ahg_hFvDIpwzYEyQ@bricha3-mobl1.ger.corp.intel.com>
 <a98ae9f0-fce3-49b9-a4df-d76e08696c2c@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a98ae9f0-fce3-49b9-a4df-d76e08696c2c@intel.com>
X-ClientProxiedBy: DU2PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9b9cc2-1522-4594-fee4-08debccb1573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099006|3023799007|18002099003|5023799004|11063799006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: LCrRa8OxIPI3K06Pf8ZahYou6T6YSVFKPicZ+I0aSc4s7CZtyMXPjfqh3gqLPH4rHB/POizGUjj3+7F0Vh/LmWAuhEVcWm0D3Sg1d1rNld0zwSmG8dGLZUV4QgfEqqlGhpt59ur7YyG8LolpEWWzNPTbUFQQiKJcPQ2hl5HnOGUILPRy1FwLHbf5vGJNAOVZ6vQw65xtZFvFoBUifRe4Zv32xFZcQhZilCmLyjcTKDhxD2oqho1dEWW2nzUYANMuHl+iTUP92AacQIrTx4xA8UP9qiFKbObUL5T7L20sQkyqB4FEuY5ejYA7Z+OyvbIPTH0iyW9CjBVUdD0xmCLVb/jZ4TNH/RSaaJ0qQudyTbo+Hw2WCDQGACpvi0CkijjY8IPPTC0kqWmF3py3Hztb/P1Qec7UGf+1HQhHGqI63pjc6WqHlXLDUhTf8PhhVTtiAIy1nogI8jBUPKRwhdHCQf6yE8F70y0ZaMQo+9/BUM8V4KI2MptNnc4VVivcJiD5DYr8zPiFCtj59HpN5GGT45niiZkTxnUQ2g2PQ2XNuBhXmqROK7fq3kXgTihLWtEmnk5QpPIoHgDZv/zC+nePYY2NM0mzeg4fhr8DsPlgoOKgJYjnW98hdVW+4LX0GYjdb+zTcj1VM+aVwNUB0DsJXZvfcYqgQu/XgtSRW/S+Rl1W/gA020y4uFyeC/Xbyd3J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099006)(3023799007)(18002099003)(5023799004)(11063799006)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pd/+6kMUddKo+t6ND5iz9KRMaojUhzB27iYCB1n0jfkRaDPkZb78aQTz4GzF?=
 =?us-ascii?Q?c5z3RHK8q9EOPsqpC9CzMmq7BU7NeMO/JO0mvj159BNY7rljjXG4lgKgE3Y+?=
 =?us-ascii?Q?lkX3wumfIJKXt5epk3QtaQdrfVW8Ixr7NN8v/2WVnRYOkBTM3PP445j+6MJ9?=
 =?us-ascii?Q?WUPNSNhTTGpVH5Cc6v1EnWdI58NjSZIkzBcg5WFXpg8SJb/BbUSGRNj5cl7b?=
 =?us-ascii?Q?R3QY1xWKmIHsoi06WQi2bSEuUmn8G/2klAbyPh0PAYQ2+bCIAFSPtOiHU6Jt?=
 =?us-ascii?Q?spT2I79GTsShHRsBSpph2hXVm8PuzPmsbvbAdoWO6/GJeh5ogZwZnX5J7tWo?=
 =?us-ascii?Q?gVY16rK1FyFGmV1LhjwuP65E3pLV5FQfSGhl3ZUAsAesWIwDd/pRITtlLt9e?=
 =?us-ascii?Q?KgEsyKFbgqy22Z1k0Svg2NVNTtx0Kq7HHOmA+sx05n3Ah9Ujpj94yYwCVt4x?=
 =?us-ascii?Q?ZXJEyQKmpJk8x0ChVYloPx7B69So34m7x5iO/JnMmJ7pOajUaJIbrHsKEUAH?=
 =?us-ascii?Q?Sme3MEMyOb4gnOPIbJnPJXos4/G4R20zHl1WnP2ckOx2D8RwahB2iLXXPft/?=
 =?us-ascii?Q?hBgvh+IEUBAOHDTOZOjql7v/Ci/1TqOZ5zJr35iEcP9B/C5a+tqALmi19nQO?=
 =?us-ascii?Q?NZOHEgxGBFi4X47bZmwQw9RDmtt0GbKJEKMQmo7D0DRNPygETPprJeSmUxTd?=
 =?us-ascii?Q?yPkeKJRdF2FDT+I6poFboZieyaGeJlejlMru6PXf81HoTPnzxdWVo0lRJv5R?=
 =?us-ascii?Q?8Nyd369F5Xt1LkAPulrwBkmco025bXv1nkHev4EJ5BL5+0BPM2X3qchQIZv6?=
 =?us-ascii?Q?t7BekVEW6Pmpij1Z5kwteqlQ1/b2qMkPk4mPR971joeklH8nc0BXq+Z8u6n0?=
 =?us-ascii?Q?DWFKPdLJZIXgyS74An0PQTgHAQy1q2Q7JYftHG5kNk9xhO5uHTIXYwxCwVCI?=
 =?us-ascii?Q?AnVUL/JgEr53gEoyAZbfQrYycER5jv6q5JS1fznazMCq0EgoABZu7KQeV3Fv?=
 =?us-ascii?Q?eUnvH6z09syW14BVHgJ18MPNFmSPuRah8sKv43cAhjO3cwj5XgkGY1loasRk?=
 =?us-ascii?Q?k34WSN/oo7VALBlW580Spy6dil287NIDNlVUtbtufRFF0yO/afUMKFWDQY44?=
 =?us-ascii?Q?OyxoBjes4C9kU+CSA3irZ1iBHZiIYOyN6V/AI6cwPlSn1dHeLBb24Fv+5bXJ?=
 =?us-ascii?Q?mc8r1M1b/zrz5T6FsYEfRqJHk2QsKr8lrEFJlw8jYBUTCHEdEw8yrOSjcjiO?=
 =?us-ascii?Q?uKA3/cALJLKuCL8iA5vfLnpplqsCY8cgYnv8kB9ZpraUYpOswnJtmqZ4c5LL?=
 =?us-ascii?Q?JkA7VrBaxQ9JNyH9qeF8Jj2Gc2Qrkoh06znfIQ5uAgtftSZUYATdeGx5UCxs?=
 =?us-ascii?Q?9Qv0mKQuHcUUoMO3237IkvHdhLuqX+QfIJ+biMx8QMYBcgjTJeiPIgTw9PF+?=
 =?us-ascii?Q?qbFxVGzyDVkJ2eQPMurMxZsp97gQ1ATCuQEOzDGKKmw3xXmH5wGoM4DXJX02?=
 =?us-ascii?Q?z0KeICQ1UCYjO09Qx7sCBaU1AR0Hihijry+BRqoioiM3lZw8WIiY2ZTCYjkF?=
 =?us-ascii?Q?28u2tmvmwG1O6tMH9+X/ei1aFT7bqlnn+BZ6IKIQ4aUkKTmjtvgCGcUMMDSu?=
 =?us-ascii?Q?ES5oDvYSb6CDFqddWRsm4KRROJCViEoQOSmSx+ULM6YHiKb5ejxUQtomkZBE?=
 =?us-ascii?Q?kBaLBP+W+c7KZbRkv2WkwnXVQZACsyFSoNYIW0L/jOY89NWJGd0+HBBfS1ai?=
 =?us-ascii?Q?vdUwzSsaqN7raIR2DkXLdYX/1mqUUNw=3D?=
X-Exchange-RoutingPolicyChecked: Eqp4X5f7VVtsKsT7TQqVM26OwAEx+gaj5Vqh8rO++WUiLM0vLZ448PL2jPObY+hmtWtc3mXPBrltaqQb3E1454vwA9A4bLjCUbeJDh+195DgTZ4TSL+QLm6PLfpnA5unUIeMUfmXp6n/yRGAxcluDQi9VRchmE6I+d88B2/4o0MHlRKcEXJpkR6SULd6XenVE3EMVQ8t70utDkkw+uixco3DQRDCSjdf4vPNCr65sGtKOL0YtW+Unnuy4aph5EK7D6uDaK3dkyiYziTO9zQOlOYL3T/B/kknMYnsm+XdzLlZ++Wxnw9cJ0dSO+4zml2ME5OZpHnQmLEMRlTWkLigWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9b9cc2-1522-4594-fee4-08debccb1573
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 15:09:16.0402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWb5yeCBGq0XkMKJffdUHKYTc9hvwhuP819Y9Ev7h+3rurWjNJLS84emxy73XpjElWcIikRtU5C/PCagBRi7/hEvq9T8/GBbbQnQ7BVx8tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6268
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

On Thu, May 28, 2026 at 04:13:59PM +0200, Burakov, Anatoly wrote:
> On 5/28/2026 3:13 PM, Bruce Richardson wrote:
> > On Thu, May 28, 2026 at 02:39:47PM +0200, Burakov, Anatoly wrote:
> > > On 5/27/2026 3:28 PM, Bruce Richardson wrote:
> > > > On Mon, May 25, 2026 at 03:06:23PM +0100, Anatoly Burakov wrote:
> > > > > There are a lot of commonalities between what kinds of flow attr each Intel
> > > > > driver supports. Add a helper function that will validate attr based on
> > > > > common requirements and (optional) parameter checks.
> > > > > 
> > > > > Things we check for:
> > > > > - Rejecting NULL attr (obviously)
> > > > > - Default to ingress flows
> > > > > - Transfer, group, priority, and egress are not allowed unless requested
> > > > > 
> > > > > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > > > > ---
> > > > >    drivers/net/intel/common/flow_check.h | 69 +++++++++++++++++++++++++++
> > > > >    1 file changed, 69 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
> > > > > index 74fb28ae3d..0572028664 100644
> > > > > --- a/drivers/net/intel/common/flow_check.h
> > > > > +++ b/drivers/net/intel/common/flow_check.h
> > > > > @@ -54,6 +54,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
> > > > >    /* Forward declarations */
> > > > >    struct ci_flow_actions;
> > > > >    struct ci_flow_actions_check_param;
> > > > > +struct ci_flow_attr_check_param;
> > > > >    static inline const char *
> > > > >    ci_flow_action_type_to_str(enum rte_flow_action_type type)
> > > > > @@ -271,6 +272,74 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
> > > > >    	return parsed_actions->count == 0 ? -EINVAL : 0;
> > > > >    }
> > > > > +/**
> > > > > + * Parameter structure for attr check.
> > > > > + */
> > > > > +struct ci_flow_attr_check_param {
> > > > > +	bool allow_priority; /**< True if priority attribute is allowed. */
> > > > > +	bool allow_transfer; /**< True if transfer attribute is allowed. */
> > > > > +	bool allow_group;    /**< True if group attribute is allowed. */
> > > > > +	bool expect_egress;  /**< True if egress attribute is expected. */
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * Validate rte_flow_attr structure against specified constraints.
> > > > > + *
> > > > > + * @param attr Pointer to rte_flow_attr structure to validate.
> > > > > + * @param attr_param Pointer to ci_flow_attr_check_param structure specifying constraints.
> > > > > + * @param error Pointer to rte_flow_error structure for error reporting.
> > > > > + *
> > > > > + * @return 0 on success, negative errno on failure.
> > > > > + */
> > > > > +static inline int
> > > > > +ci_flow_check_attr(const struct rte_flow_attr *attr,
> > > > > +		const struct ci_flow_attr_check_param *attr_param,
> > > > > +		struct rte_flow_error *error)
> > > > > +{
> > > > > +	if (attr == NULL) {
> > > > > +		return rte_flow_error_set(error, EINVAL,
> > > > > +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
> > > > > +					  "NULL attribute");
> > > > > +	}
> > > > > +
> > > > > +	/* Direction must be either ingress or egress */
> > > > > +	if (attr->ingress == attr->egress) {
> > > > > +		return rte_flow_error_set(error, EINVAL,
> > > > > +					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
> > > > > +					  "Either ingress or egress must be set");
> > > > > +	}
> > > > > +
> > > > > +	/* Expect ingress by default */
> > > > > +	if (attr->egress && (attr_param == NULL || !attr_param->expect_egress)) {
> > > > > +		return rte_flow_error_set(error, EINVAL,
> > > > > +					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, attr,
> > > > > +					  "Egress not supported");
> > > > > +	}
> > > > 
> > > > I think "allow_egress" is possibly a better name here. "expect_egress"
> > > > implies that egress must be present, but the logic here seems to be only
> > > > allowing egress if the flag is provided.
> > > 
> > > No, the check right above this prevents unspecified egress *if* ingress is
> > > also specified.
> > 
> > So the error message above should be "Either ingress or egress must be set,
> > but not both"?
> 
> Sure, yes, a rulle cannot be both egress and ingress.
> 
> > 
> > > Meaning, one of egress/ingress *must* be specified, and if
> > > it's egress, it is only allowed when we are expecting egress.
> > > 
> > Yes, so it's either ingress or egress but egress is only allowed in some
> > cases. But nothing in this check prevents ingress alone when expect_egress
> > is set, so egress is allowed but not required, so I still think
> > "allow_egress" is a better name. "expect_egress" is a bit ambivilent, in
> > that it's unclear how strong that expectation is - is it an error, or just
> > a warning if the expectation is not met, for example?
> 
> Rules cannot be both ingress and egress, and they cannot be neither ingress
> and egress. That leaves two options: either the rule is ingress, or the rule
> is egress.
> 
> If the rule isn't ingress, it by definition will be egress in order to pass
> earlier checks. The intent is also that a rule that is "expected to be
> egress" must be egress to be accepted.
> 
> However, now that I think of it, you're right in that the condition is
> subtly wrong. By default, we expect the rule to be ingress (i.e. not setting
> "expect egress" implies we are expecting ingress), but we only *check* if
> the rule is egress - we would *not* check if the rule is egress. I think the
> condition should be replaced with:
> 
> 1) if attr_param == NULL, rule *cannot* ever be expected to be egress
> because we specify egress expectations in attr_param - so, rule being egress
> when attr_param == NULL is an error
> 2) if attr_param != NULL, egress *must* match expect_egress
> 
> So, basically:
> 
> if ((attr_param == NULL && attr->egress) || (attr->egress !=
> attr_param->expect_egress)
> 
> this should better match the intent.
> 

Yes, that is clearer. In this case, is "expect_egress" better renamed to
"egress_only" or "require_egress" to make it clear it's an absolute
requirement?

Also, just a suggestion for readability's sake, maybe merge the conditions
for checking ingress and egress but not both or neither into explicit check
branches for each case for clarity.

  if (attr_param != NULL && attr_param->require_egress) {
      /* this must be an egress rule, ingress unset, egress set */
      if (attr->ingress != 0 || attr->egress != 1)
          ....
  } else {
      /* this must be an ingress rule, ingress set, egress unset */
      if (attr->ingress != 1 || attr->egress != 0)
          ....
  }


/Bruce
