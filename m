Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA4EA811C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1306400D7;
	Tue, 10 Feb 2026 15:10:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 36DC8400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:10:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770732643; x=1802268643;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eno1AvwE5wsk4UzUpzwPwAn+c0VCqSV+MPNkSpr2B6E=;
 b=cY1Wm1CEzSuCASYNs4cT4rRBV0FjF93N8/cLs6dPpfU1ZbI8PF5FhXbo
 ZMSfK1zlcxUu9x1Z+Lb0K8u2hysA1S3WOScwOteQFMd6e9euqpg2c+84V
 McKZCc9r0OzvDhODe0KwvbFRp2KGi2AftfjPmuCKLeAK+fp6ZpU+Goi7T
 AGhqSY40EfwIgCmz9/+oQAJ4aFG8h3D9J6rLOY+aRUQ/Aj3HtZQ39sIAo
 WdrH4438daxCrChHwpgj5p+ilVzQCk2MS9SXfkXG74TebM3kcjyBgko39
 /+/TV+bL+aapTkJLFvCwPht0sWczcPZ/e3bzU2aTFa/pYoTl3y8mQqEND Q==;
X-CSE-ConnectionGUID: coSwDUAmQHyE/vmf8bL2YA==
X-CSE-MsgGUID: P2IoN7lbTxaG2+b3gvbGoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75707064"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75707064"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:10:42 -0800
X-CSE-ConnectionGUID: 15cwIKvaQaCtUKl6vAlhcg==
X-CSE-MsgGUID: sjPlqSn0QZ+3E+nyQzEMqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216265886"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:10:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:10:42 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:10:42 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:10:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1UoRAQhWN0L0QqNHTDZx6MrDXijGjvxNHh8D4sslAYx3YVgGlmhnR7MyL8WZmQiX2o4AUQJM6bLC/sV79x1lUtKb+JM2vY/dVrr3X+3HqsIHILLbgSw3JFxaEDPvznM6JKSfcCKlOv3vCRTCMScCTD7oGzlOYXiNCwkMYdUf1Y/icvuiUcNNsRsP6+oG/W06BZ2iMGiS5XbQ1QP08ukj1uDznVcNhujp4sL2PIYW0zvm6U3qB/dZOP/3HvKWID0vL20IeJxxMhdE/izPWLp9hblsjT+O5oMoUnNKXE9FLmebrL7RMM9rQsZHzf2gi8OZ6oYStvN23/pMfJ9nyOSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9Kn/2zA+eEgbnv/3uRqs18kRwQANSa1kpFCnRQmMKE=;
 b=jFIVlw0jFfwfWw1FV+dxBYixVAwLBbPPlEi35A9Wxf9ade+ESdwE/Y60cyakhmAPc7vvn26HxryuSqoQ3LCs2P0ACSdG8MpXQo0tSckVWPhquiBxkw0wKrr2aLbDwQfKSTPeUWtJjeJmCSivyeU7ZjWuzb92iVNdyFQBhr0x5IKIrnxuvJ8DmSbBIop12zkfTpqSNzZXtyokHy2i6hPp85shsTJZoC6OpTJRqcOKYtwqVRsDjrDENk1EOK/je8eFol9xxukMdKqJ0DJ2HQhcpeVMQopSa/sq71G7IKHuBe7O8/Uqiwb5WB1S1iSMSRRK/2uD1gDuY+kIOdYZtBifwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH3PPF23335A1E7.namprd11.prod.outlook.com (2603:10b6:518:1::d0e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 14:10:39 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 14:10:39 +0000
Date: Tue, 10 Feb 2026 14:10:34 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 07/35] net/i40e: refactor context descriptor handling
Message-ID: <aYs8WvDxV84HohAu@bricha3-mobl1.ger.corp.intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-8-bruce.richardson@intel.com>
 <abad013f-0a13-490e-9443-0441233684c0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <abad013f-0a13-490e-9443-0441233684c0@intel.com>
X-ClientProxiedBy: DB9PR02CA0027.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::32) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH3PPF23335A1E7:EE_
X-MS-Office365-Filtering-Correlation-Id: d72c02b0-ab2f-4498-b12f-08de68ae2b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mnUy6sPVvIcCrND7zll5r3nMYIXCAjAC9TFcHq+Omv7QoFglYRSYrNE+XXru?=
 =?us-ascii?Q?dHJ1Vg6J4o/y58HJoOjWhlMeIerPqnOoc62QFhp8b7pfMtImiJXliEWMK5SR?=
 =?us-ascii?Q?4AwvP2e/xdYq3NS0Jb49seV2SR4JgWgD/BZNo+XUjVWKd03sfkPhzvJdkiP0?=
 =?us-ascii?Q?wyzRmQLOK5Z9zOgReeDm55QzUaYnAT5M978OJHAYj2o5JCaqf52HJwh9ZoMo?=
 =?us-ascii?Q?Yr0UOGohfFsWBVdW+3kvTX7dLjVd8vfUHZ7r0KKLa4eYRUzisUchHVhfQ9Py?=
 =?us-ascii?Q?RScpCuGZhuie/zZk7p9bClIwlp4MKrNaGzM3uqOIhHFW1GQ4U/8ywSu5s71a?=
 =?us-ascii?Q?2j8wiz6JZD+hcegDOWTGFJdc5v1x5DGY/SVOaTzIFsZHKGGgAYlvwOfLcM/9?=
 =?us-ascii?Q?t82DkxZWwCgpnHQZlgKwUGBVB8qnOHOcLZ5oclXMJ86O0Ix74jTK2QiBWtAK?=
 =?us-ascii?Q?SeFVycdJrVCIpEzBBWpLmeEJSXkPK58JZsfbTkoNHAqiWdX6VV5xrujA0Prt?=
 =?us-ascii?Q?3T4BooKt00wmiDRap3X5+215OKGN/fOOV/zvSLMkNZWz2GrPCS3j+8hKW1Hp?=
 =?us-ascii?Q?VsaeZcbnR/ySIBqPamgGg7uTH0Hmh/1BppWSAxLidCCyEHcokQ+eTWhDed9v?=
 =?us-ascii?Q?hg09Y+VIwDfL4sutvrhlzrD1fKTl8A932VNrvDj5ZKQkeIR6BnC+MoGn5DBM?=
 =?us-ascii?Q?bKj6O+IAEf6X0+dRlS7W5r9oVajtiahZhJR54UefbdoQkTQ52tkSoXgPRs+J?=
 =?us-ascii?Q?mXZmwpxLaglQlHPrZSemtfGgBlKDeEnp8EbYBInBYz+5GAtP8Jxvaqyww+jF?=
 =?us-ascii?Q?/zIQG+Q/K3uaAnXboZ34v4YzZ9jdeMw8Sln/gkM2MRoIymhv9m1Ts/YxQSIa?=
 =?us-ascii?Q?hyOXdAURXAXiMpDghnuLIBOnrhRrKUx4iydOjjiI3hR+CBo7jwjIMKzcMK/W?=
 =?us-ascii?Q?PRIv1eKh95/5sR02iYH6XhFFxTqcyBZzKYd0lwnHMBK4ZZZE9bEHSvH43djl?=
 =?us-ascii?Q?MYesUzJ0NdVrGqfub05nTCxEcbXYP+vGyWOM+tcpAQqrs4LNynG/jK/x74Fp?=
 =?us-ascii?Q?Qj0dNW+fnd/8iCnCAxkvSJ6+azjhplyCPiIBpDZ7zmaAxslPxWRUeTOvuAEu?=
 =?us-ascii?Q?4d7i/FAsD2/v/x0mst158RqeLASOpBcnfqwBkuXbj3SemMKKFpBmwmG76LYS?=
 =?us-ascii?Q?0ws21eemo69zi8ESdqavEQPgPpve92z2FRdoZQ1ceV21CjC2oqOpgdVbSUdK?=
 =?us-ascii?Q?rKW1on6jkVjWvU+11UjLW39HlVX4zzr5gvgNNtpE1iBWoiZAZIYvUcJusZOY?=
 =?us-ascii?Q?4BpwiNBty/IGCbRJ2qnTPVng9UfTLMwvuV9djkVk9ifYRjl4Ftgcm6kbdqDW?=
 =?us-ascii?Q?XnC1XvniuhBNnBBiwkaLKbqLe7lmanrAFCdkDhGrQta8zZU7Z9PYXTlEsDV6?=
 =?us-ascii?Q?8hgHe1YpZAiiu3GZ6uMJbv/HCKck14hPISkd3UgSlJgqaLLDqekSIaz5GYvC?=
 =?us-ascii?Q?5TX71VswYhCb2hV/4jUudjVslB0nsQfndkY866j3z5Fb7CahpBldj1z7zcqk?=
 =?us-ascii?Q?Dnat7GyjpCo7qAmY1/U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DwIDfBXvvqA6ojP9m8oLl6eGB8R9P2ojmQGVmGu+9PaPQKx6tgGfOuX2qs4p?=
 =?us-ascii?Q?PX8zaTR94Yz+DMm3aVGo7qoKi1dNnjrF42BSP0dI1RtNkwOBZRr+OPE6NT/S?=
 =?us-ascii?Q?U/V67AgfgYsIeXoQ9J55TY0rOBoTkp29vldCoz1zH8tKMUFSJGhU6bv2cXGe?=
 =?us-ascii?Q?NRCGG8pZdrcYxCOmCAPdX9ZKLE49qFfaA8GJ/I6MH30ziB1WAJqiUON7MhoB?=
 =?us-ascii?Q?mATbKRWA3ez6NCeAYnq92VSusSqGe+t8V5QbhBXqmV6yLGPbqtaNedogUlJJ?=
 =?us-ascii?Q?MQXmMIcIUY4ropfcQlRvcooua7s7yn/ULdr4EzA/c4IX+NvgyRDqaOkYgrxs?=
 =?us-ascii?Q?eGuiMctBSPNs6Xqsofc/g9zxom2cDJY1YJeH+1rSbsav09yFUm558azNYLbo?=
 =?us-ascii?Q?h/6GZ7KaugVJg7FchbxM/K1oVUrXetlmbiMLDMacEUz26cpBIMSXSbyOlgLI?=
 =?us-ascii?Q?27I5TmywGmpfnXA6m7Czc8FDdvirwTYY2PiORciTTIEIthoWWiScmczzC310?=
 =?us-ascii?Q?W9r1u9xEXZYrSdM59cIRcRivVApcMITc8d314k3sWgYORS6ydZDxcPGckcVC?=
 =?us-ascii?Q?YbOizM5IEQ42is98jeL0yZ2s+/lQTi6bNYDQeo0N9C2bNdRrKDGeTW3kFyAH?=
 =?us-ascii?Q?NlYlP4skzcNUiiMCEdU3jV7DjlQ1dhTgkkhxTRJieOlKlVJs7TNVHOJO8Mhq?=
 =?us-ascii?Q?o99DELHRFPY+UVQnof6QD672T0TPk4jFsZZ9tG7/sTfoOdL9/Y2Mac/sjThY?=
 =?us-ascii?Q?T3dRy8N8OmugfzfabfcP7bivf6jHkCJ/K6vGocj4iY26x5LYDQH1IsZEESvo?=
 =?us-ascii?Q?n/KYg1kF1u/OVRstadWX4iSruO0wF+k8FJ6PAB18GD1PyUd1X/GmiXmhBZHn?=
 =?us-ascii?Q?6Krs2OiB3VUsrA9sElgw1Qx6ziuc+At8q0ZFCLMJKj06Hh529fQs4xWCQ0HK?=
 =?us-ascii?Q?yJHlUv3r4WoMBYfJlMOITMBmwRoufxBScbtYMC0a/3ZwFWl+5fdi2sBBnYUT?=
 =?us-ascii?Q?B2R27L6qqwaL32KO05uJalF6IPN2vwyHDF/YTRjfMaXj+O51j0tgbNmVn30S?=
 =?us-ascii?Q?NRM97f44Un1rMuard419mr5Euy1ZihazWmPk6pBiPAlW2AIn6n+RJH8Wr2Qs?=
 =?us-ascii?Q?CF8hH6bfMeDzoQaTCx7dZIb+zdJaO3E5nDUtO/rtyuaSAvH6WiGh9Ybe8Ch/?=
 =?us-ascii?Q?Rwp4vTq9GM9TzJjwNqBTLDYQjJK0W3FXrXE5wbe9L9OwSR3n4hGXz/V+Roho?=
 =?us-ascii?Q?NgxH84iX3lX5s7WbUyH2BKr6mbPwr1ecoVOs0YR1+JiITn3Zqt7ofXh7iLpK?=
 =?us-ascii?Q?lRAlKOLIJwkr2nuzBxMKI/CNn7zT55FdT3nkUY36nVpAhUTIhI4ey/6nQfzZ?=
 =?us-ascii?Q?CpWIZQh4Kolug6hbbVQ6BOhuY4cGJGzgw69gCscaNGqSBu4KDmdr/Bglr9uc?=
 =?us-ascii?Q?grO5+/qbkwxTPHsXF64FbJn3bQJHynl/uj+hg2FDFoP7Yj2AxN2b0LzCaj9e?=
 =?us-ascii?Q?wnWskEjEzKJtf7gNbtjuW2FYAE7mg0PhKhNpviU82FvWobffcPx7TO1TOlCa?=
 =?us-ascii?Q?aUEsZ6VNdVaTH6M1vX0snx5o5M0D5NnYKsbXKzKGXL9MHbDs+mCddvhZP54z?=
 =?us-ascii?Q?Yc5i9kIRuGs0jpxP3vvV60exfdgeYwfElcbhnmouAJEzmFZfnX4FdC9jWXN/?=
 =?us-ascii?Q?YTR7h8ssWttKnEQQ5S8Keoi9hfo3+j4CEBiLh0BHFuwyZ/xn8PdnEApLfANO?=
 =?us-ascii?Q?JdB/1l2X9TFfrDFbkkuvAbnVCixMxW4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d72c02b0-ab2f-4498-b12f-08de68ae2b4a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:10:39.4319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Vcv00r1uKFtlk6LzDqYCJerFpVKXf3rgCQ1K8QOnW8qc8Xqk6dOU2QYlE7b03uPOXxnk2ESp/I3RhzP4BHiNGMBVyfIfhWVDwz7sQDJTJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF23335A1E7
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

On Tue, Feb 10, 2026 at 01:48:20PM +0100, Burakov, Anatoly wrote:
> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> > Move all context descriptor handling to a single function, as with the
> > ice driver, and use the same function signature as that driver.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> 
> <snip>
> 
> > +static __rte_always_inline uint16_t
> > +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
> > +		 const union ci_tx_offload *tx_offload,
> > +		 const struct ci_tx_queue *txq __rte_unused,
> > +		 uint64_t *qw0, uint64_t *qw1)
> > +{
> > +	uint16_t cd_l2tag2 = 0;
> > +	uint64_t cd_type_cmd_tso_mss = I40E_TX_DESC_DTYPE_CONTEXT;
> > +	uint32_t cd_tunneling_params = 0;
> > +
> > +	if (i40e_calc_context_desc(ol_flags) == 0)
> > +		return 0;
> > +
> > +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
> > +		i40e_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
> > +
> > +	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
> > +		cd_type_cmd_tso_mss |= i40e_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
> > +	} else {
> > +#ifdef RTE_LIBRTE_IEEE1588
> > +		if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
> > +			cd_type_cmd_tso_mss |=
> > +				((uint64_t)I40E_TX_CTX_DESC_TSYN << I40E_TXD_CTX_QW1_CMD_SHIFT);
> > +#endif
> 
> I couldn't find any places where we define this, it appears to be some sort
> of legacy define, making this basically dead code?
> 

It is legacy, and does need to be fixed, but across all of DPDK I think.
Testpmd, for example, has IEEE1588 ifdefs also.

However, for this patch, it's probably harmless enough to remove the ifdef
here and always allow this code path to execute.

/Bruce
