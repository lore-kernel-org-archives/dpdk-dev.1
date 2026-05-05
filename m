Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8121CCD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 11:13:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11BF240674;
	Tue,  5 May 2026 13:13:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 80CE840673
 for <dev@dpdk.org>; Tue,  5 May 2026 13:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777979598; x=1809515598;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BXDMiGdbQGb3yh/ppvJiYuGsAgTJ0N2a/AB+aS+Frn8=;
 b=hL5HGRcLBA794jpQGWJRrGzTnpKv00REYhH3y5IpVAuQVXvZ4OEMjonF
 VS7GKvGEuXOGw/bqy+/lNL5NfrTYwEHcNipRAdfZjwJMu7CcbaP9wk9Tf
 5ovjiUNaW9Fk/eqvVEyF7YMNsEAjQJTI7+jryaHz+eB1UzWdd40wsyujf
 GnHCDHufc+FDu/3kz4uq1IUI12Ll5WlP2t6mtVlNHPS3Mifuu+Igv1yfG
 aBuxRA/MlFDoyxFIbtbfiCzT60tHYBhQnQmO+qsAdPy3/cHqS4d8cwoNB
 h16K6vQHS2iaaunS7oGzB1znJOrBJ68LjB469kF+VFaTw2SAF9nrIictY g==;
X-CSE-ConnectionGUID: N2oGBkxjRDe0K98mSysmHQ==
X-CSE-MsgGUID: pDTvVcz7RdWm0rbtDyLaLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89152692"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="89152692"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 04:13:17 -0700
X-CSE-ConnectionGUID: 5c49bHvXQXOU1KZfgbbWJg==
X-CSE-MsgGUID: O38rtaI/SmWFCn95QrQ3hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="239780413"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 04:13:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 04:13:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 04:13:17 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 04:13:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds+RQDWyDL/x+7T74TRUvqGdAqpxvIZoB0ab59doH8UE7qn4dVnljIpXXm7coHSpcn8vVtePo5OfOo+Wx6aeDfJleSi9aQf9kbyBKCRBGcG44v6OvdJkOGEHTMNej1AcW8AcqWfnHvv/y69P2rVP1Ob2OKTEdPHHk008ipOnWOJDbSVnOI3HLOj1A8My0QgfVDcTVcVyQIS+oFVJuk57JRfHGVU88gvdLNjeObvheRtDivi+qtnCK52Zt9x+7grbeovoFNiFzMqpj330cb2VSa4UQ9IfMWzmgc6w8945WD/3490UK1pnPOId+XHtHg2rXhbeSL1EZdNoyhH9jpGN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFqu0yiiibxC8tcbsnwicb5R5K6ZwYC7ck1idkc6rHQ=;
 b=OP1KT/wuFFCFYCdZOgvnZjjBMgU2ZQnCGoYV/YAvhnpv3xKOtehfIhxcWisVJMkMj+hI22Rt+O/5d1rF+kBIWZjAMr57nx1WKwbUdX72hjhIYcSHYGI9T4Gx/MXlAwT6lfGuZSKZlmnSY6RJxnmf6x6Vjkf20yUn/zZfaZLvMDM3CEvaA4NDR1aNM1XXhEUefcQ8qh05NNnHzV/qVHc/RezJy5zdtbB2TJ6YZgR1h+18cgszIiz9zWosH3mkfC21W6VxIJ1U1VqWrV6cMwHZy1iEG/ZgrM2Wm88EbtfDfnyiQXelBjlkaeu42loejjMrLwOxpO21t/uzqqrECDSXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ1PR11MB6226.namprd11.prod.outlook.com (2603:10b6:a03:45b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:13:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 11:13:14 +0000
Date: Tue, 5 May 2026 12:13:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v5 0/3] iavf: LLDP ptype and AVX2 ctx paths
Message-ID: <afnQxcEOzabE3nZz@bricha3-mobl1.ger.corp.intel.com>
References: <20260417105610.1161242-4-ciara.loftus@intel.com>
 <20260422091609.1797686-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422091609.1797686-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0334.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ1PR11MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 475463a2-2982-4779-4170-08deaa974ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WpXoixrBSoauaotEe0CParQf1r/jM6POZgHn1c9vy3/Ud5FQE6K8D5naQt3eX2igO21utAoyRVCyBF9/ySqYq+DgUcd7kIsWP8p7wqmzgjpYTTYxOp9EdSnHCGnhhuEJh/frIZ5J9JJ/Zdkgclp587gv8I3GZxkGp5xAvNgrObTPBCaU8Fh+RuAhZzsAj7fr3u43ChgF40xSaMpzP6WTBtQwkUPV4zwt4IMAzBEgGEffWllQAFkrtq78KIDISEbwncGSLCs73kohrgOLcL4S1d/1Jv30+hzjSvO239xZpwhUQglPTvfHrhBPxLQ5oTH0Sgqti/B83XQchd1hGiNABxZexrUAQHRtAVn0pOFUjb/w+zTXiz0hvcXEokMOAEnGXn1NvYHUwbV4wO19vgaIjef75H7C1SMQTrWi7V8dfQTpDFVo5ySvjBtuaczseJuDVVTJZeGuJuiRQF0ZYEJY1mAQuTxX2sNMVjN08KvziTO2EwW5UspWY1uxzif/Ha0QdU8IoGMBY+fLDMYAvpdDdhhQa6TqDIHa47m2VTBgP96DW29tRAVZ3PQ2kFz9B0jOIQ7BE8x0RW7fqaylu+N9QLXtOdUuV/sKYdogsgpmtlBj7l3swpSjlfmkYdBErINcx8TSIoVTVxAtMiA1celtOuUMcN96TXRW05IbnFwTqTjNmku8StK0dXO1s61Remj1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rc1vhKmjWXCXARXQHqnrGGvEWbwV92f7yqXAAbH44MjdDxK9YI9FYHaxtc2H?=
 =?us-ascii?Q?hsuSAi0yu3H2h1CmU/eypnqpYaPmNXENuhAbvvsawUir9guWT7LjJGS8GzfF?=
 =?us-ascii?Q?4MUKBg5Xb9z7X5KPqE1+fDZth40xr1J3+xtsgTEcgOPw/HXtaRSrn+HPyAXm?=
 =?us-ascii?Q?Hi7ZMpJF4ehyKMpUq+ix0pTRtPkGAvlFjUlspzTFBa4822M6uwNGBoiPQ0XB?=
 =?us-ascii?Q?OyKtU22aJW+X4qMN2OpGbJF5yOm7ICFdaCNJ/LC0PVR+JnDJhyOft59fBbEF?=
 =?us-ascii?Q?CkNfbc3XGmaiA0c/gygOCwup5kDpquwHBkywRfXdf6noQ9wRgFjwU2KSb6cT?=
 =?us-ascii?Q?1EJ7RoOGlTmzBx3xPCH09X6S6EqYxVZ72/7wJZa0xnGW/EqwspSS6FwzZUJ4?=
 =?us-ascii?Q?u1X9zYVHfKbu2kxcAp4kNwLhYy+gNnfuaGKz4/PUchVW6nChjnvdCNzKbRWM?=
 =?us-ascii?Q?FUQKUm6VN3ZnhSNDMWY61Xfo2P6pNojv8OIgJ+QOVHYWscnp9k/ls58gxeNz?=
 =?us-ascii?Q?9Unv45a4w5JqOBecysq0Trt1XPXuAE6pRrXw1wnV7cBT51NEOEmMWW8XOd+4?=
 =?us-ascii?Q?o7A3HoPwe6V9USZvS3zPZKTr8Mk+2ij7KkqyAZ3hlil/eeAIQBvG22G+p/t2?=
 =?us-ascii?Q?INMUy9o/JTXx0bm3qLhM+kmZMf5RcQJ82NcBMziYRWMRTfHZ5kBS7kd6VXBN?=
 =?us-ascii?Q?RvIewv4K+ugODZDK1r63TX3m2WeBPySvKInX8LA2RV9siwL8gEOaSH+S28a5?=
 =?us-ascii?Q?R0bfw/b2xXOJRq0geSELCiuCk2cmY5WsS1Rrcl0U0pBSgjOllh9FXvgEASGa?=
 =?us-ascii?Q?iNYA9MdHDkGs17GJaSCnha2Vo8HPtPXDCqDAE6abSHXzBquKlSB2EEIKGXNu?=
 =?us-ascii?Q?8aLlYYI3fupQbhJgd8TSnweTmg2LPh+v53Zx5on/AN/glk5SVQyAZs3dz7uL?=
 =?us-ascii?Q?8lS+Hfzt0pj6I5oFbk/31Ja/zdLlUcj7rXBeZvbwtqJoMGp3ZgYSAB59e+lQ?=
 =?us-ascii?Q?zdidrD7BbIixRcmH1vHCWsQvt2voxExqMHvN+n8mDdAllE5/5ZuyY8Ob9wqk?=
 =?us-ascii?Q?F2b087KcvxKbEercyNgWmCSWzJFNj+PF2Z1jGwBH1AJADZd4CRCG4pD5e0OO?=
 =?us-ascii?Q?i3xFB4eoNjFlUB0hD5K58GYOe/10BVwTvHQN4yOkissEsGtvdlRKk8OZju4a?=
 =?us-ascii?Q?ty983oJSRToaB+WamLe0r0pzGrfOeL2y4/UY9dnmimdV6t3CIcngVmhEWyNw?=
 =?us-ascii?Q?+rUyQFbbKuRz+IYV8BALWOAC7510SxK9UOuHm1ueloGXrQSeKjM44KjQzGG5?=
 =?us-ascii?Q?I5DP+ja+mE/XkIFHDtixjt5UrEqpW4Q+eZT2o0AZAnhW3DuO7dRcU6mwzPbT?=
 =?us-ascii?Q?EYQi5Xpy37h6rzI8QZfjiLdznhm0vtbyYdM4U12g24dvmd9CSJTK8+dAqaRE?=
 =?us-ascii?Q?nEUpcTqa944GXUodL52ST/jfaAs0D+3mGZRcKZUgNU/QyozS3f+/5b9uKbKo?=
 =?us-ascii?Q?R9wnzHnvThm8sSjTqxzkKi7daepEDCh/0etb0DQiRb6dV3h15VbINyRDBBs+?=
 =?us-ascii?Q?UgtwrDTbJL/qSfV2d0bAYaxIxoVP/63uZbRx78F9krfqerPKhhJj8t9aOS69?=
 =?us-ascii?Q?iUt7DUZhIvZ+I7ELKBiVYUjCjjGdcGV/Ol/U4OIrhuRKfdGOvVuXUl6/tkJH?=
 =?us-ascii?Q?JWXYq1jNGzjvRhVRdWIattclgyD6Z56klhad9roV4PslhrRrGnj0b2l9TTh3?=
 =?us-ascii?Q?4SkJ2rCAm2BkLPrS6K0ANzU1vZnHA6Y=3D?=
X-Exchange-RoutingPolicyChecked: gYd+5jH3IlA42t60kclFk/zZr159C30r1GIjdbrwa9nia3Zf2gUHWY+19TfLIc61RlkvHS3zD8OFgf+JK2c3qrqJeNZCYt2mcLFmjMsBoN1JLWDtQiAmWAtisq3VqGkTS52vZPdBrTFPLBOXQ/3RWxXMfX6iLUqmki/eqGQPa0/gyccfsLzTOVVjXIMVCIxrBKX374KoNcVp9HEQeeoYGmcwcCSSNfwtGRp81XyILCJ3VWIphqTM5XpZTOrcjk2w7v050BsDtTDQGE8V0WswsY6l6mncept/9cIvUG6wB3XEzDBwrElCpYOwkNxbWQDXfWlgwkvQbPbMksjsxlOqRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 475463a2-2982-4779-4170-08deaa974ce3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:13:14.1410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or6OnAwRblyJYuwzK/OsRP5C7QrOSJSEZRn4icLYfsFyymOKisrEirT/FoqQdx7SA1jg0IeUn9DjjjSYuBHORGEypsttRbzCkLYi35hE17A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6226
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

On Wed, Apr 22, 2026 at 09:16:06AM +0000, Ciara Loftus wrote:
> This series adds another way to detect LLDP packets in the Tx paths
> of the iavf PMD, which is based on the mbuf packet type field. This is
> in addition to the existing method of using a dynamic field. The series
> also adds new AVX2 context descriptor Tx paths that support LLDP. Finally,
> a deprecation notice is added to the documentation to flag that the
> dynamic mbuf field method of LLDP packet detection will be removed in a
> future release.
> 
> Patch 1 flags "CHECK:MACRO_ARG_REUSE" in checkpatch for the
> IAVF_CHECK_TX_LLDP macro. This is a false positive because the inputs to
> the macro are not reused in a way that would cause issues.
> 
> v5:
> * Updated the documentation
> * Made the "lldp mode" per-device rather than a global value. This is
> necessary because the devarg is per-device unlike the global dynfield.
> The mode is added to the iavf-specific flags in the ci_tx_queue struct
> so that it can be read for each device on the datapath.
> 
> Ciara Loftus (3):
>   net/iavf: support LLDP Tx via mbuf ptype or dynfield
>   net/iavf: add AVX2 context descriptor Tx paths
>   doc: announce change to LLDP packet detection in iavf PMD
> 
Series-Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied to dpdk-next-net-intel.

Thanks,
/Bruce

