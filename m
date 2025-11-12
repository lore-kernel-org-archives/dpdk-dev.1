Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB3BCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:41:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F4D5402E1;
	Wed, 12 Nov 2025 10:41:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 92B8C402B0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:41:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762940515; x=1794476515;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WlURfVbyD9a4qGA3e49M+vmwhqn2AKgirsGrG5bFQfA=;
 b=HXCP87iKdSYuTNAXFo/6zY5p4CqrQuIgTLhAXujW/F+hZ8JIf7vlKOdp
 cEYZMvrIUTk5ZJ97jTiqtA1z9VU0rzu29Y3xPbrGnTeVR3C1Yv0QeVm1q
 91PsDcfWp234FDhqwG6NavuDGz9oPXUbNlSTD0X0EGZLn8W+f6mBQgvs/
 nhWqYU9RNsFtqmRf0oOaRTdQVacHj5RnSLwg1515hScwys07y9a52OTfn
 +NZklulmAyzpCBLDB/8gzaml2WDJu3Swk0HGQskKFqhm9JD1IHO5n4PyS
 5yXZLLPt+kwHurbiCPCiAOBBJpW+kmAK9sMjHVBCcUpVbAeZazLmbhvV3 Q==;
X-CSE-ConnectionGUID: WA62aCLYQDG36wsCVQTY0A==
X-CSE-MsgGUID: IImOe3tiQoq6gugGxbHG1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64880998"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="64880998"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 01:41:54 -0800
X-CSE-ConnectionGUID: BRuiyt8xT1Wl/jFM+t5nuw==
X-CSE-MsgGUID: IsaB2zHCTgOSyr1he5TZtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="193303820"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 01:41:53 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 01:41:52 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 01:41:51 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 01:41:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GB0GDCsCMh8tG9O/jLQFfwpaJew0XQgmGaTOi9dbspUosiR5kaxfYxSMLt24KgNx2FlkHwONqdWv9dfakysbzNDNTx9hperP2KnW9TDnMMX9pxS01Thuy4DmOuuWUK83Kltjr2OjQPiQG9zjuo8ZPtMdCLvN6VRYINAAfH9F/OpfWx6cQOAIfUGZkZGt83uTbwzRUkS/5+DWnnSQQ/8+IXa+kV4AGxzQh+KhD+Ui1OeupVmbcLez9ji/7Xpd+A7HmOog2tfM/csFylVX/YecUCdoUbtRDoTuuzL0N9DS+OATbNdcNzqvlVlvprrxW62Wm74WFuOtmqwkYBoo8YTW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21BXui9dZj6AzL4SUr9CpSNEQz66esVkRZ45MDwU+Pk=;
 b=GiY7pGMnL/+jZKVK5eW2uSO0+SvT92elOqXnR0ZwrIxTecOY6xaLPB5B7cKUXCDYmpxDigSlkZ0T9z2XKmRl05Bpg6oe2WjQ6CNFXzkDSTcrGDDRui9m6bxfB2CkMFc+IgFT2elzXppIHtclDYd0i2MuTWcL81Gm62SZkQu0QGlrH2vTTGbDf1LFnH4XLeYHwpB0K+4lwVSklwqKmlApY5cGk/GYjRbvzNWRS7OmvxnQ5lcRHNtB8s1tZocq2sye35SCJA4a0HdIRNnaQyVJDBtYZ2rwfYTAISSzrFI9BUyDMkf1/YsiavMgS6rZGcuRH8OLAQc0jdCUfg/hO7IapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8466.namprd11.prod.outlook.com (2603:10b6:610:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 09:41:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:41:49 +0000
Date: Wed, 12 Nov 2025 09:41:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] license: standardize SPDX tag for 3-Clause BSD
Message-ID: <aRRWWdQjWTodkYxG@bricha3-mobl1.ger.corp.intel.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <aRRT31JDkFl1hpsI@bricha3-mobl1.ger.corp.intel.com>
 <7067595.Whz1cUOskA@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7067595.Whz1cUOskA@thomas>
X-ClientProxiedBy: DU2PR04CA0245.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 3639afb2-249f-4d66-b425-08de21cfb3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r6PNEM/KdS4pvA2JClhrdejwO7uJLnrLQTvKL7t31Q2cHNAgoRgw7HhoYywT?=
 =?us-ascii?Q?MUhgNDQO6THTCRyfS0tBnpWFBLYZ6NXMFCnrhZ1W6M6+AJx6YAOnw9tT7rGb?=
 =?us-ascii?Q?HxrDkIrDyx3MiKTaMbp3KIJ7l2Cgl3d1/f8KP2Rk/35XpVNNteqHnngbS6Qz?=
 =?us-ascii?Q?pYPZTA2FAiDbzRDc1RdEur3cS1C5kQEN3seKanXoR7BBhio/rS4UGQg3AtcN?=
 =?us-ascii?Q?w0u9tYDBGwB9m5cCqFLj08a7A5+dxWTeULjFECvfW/pWmencIQNZmbB9ATsU?=
 =?us-ascii?Q?Ff9W+f13q1XQHL5bmL8D9wqVdcQ2m5YL2wFSU8c3yeRHF0/Lqlt2OfhbOMmJ?=
 =?us-ascii?Q?a4tpJLCdIKQcTg2K34KBNSf/bPGbyRguG+jxL8MGP72RqN/iogQYKO7ftcFB?=
 =?us-ascii?Q?bugxXSWVPsWrYbQ3lEpRprEQzCEIoMKmFk61msLX7+LWqn+73QC+iEtm9y5t?=
 =?us-ascii?Q?QeNWlPPYqWWuH4O4fuu4mO1OsdYq10alSVTIB/h7Tjn4M+kTRJL8QOU7jadL?=
 =?us-ascii?Q?Bu0vpTbvpoxND8U9BzELds9pIwQlfSujxDoeNCkeyK5212QzIq3FYlaHgK/R?=
 =?us-ascii?Q?7ud796gTdpzMMLNtF+tlzOXchXm2/q+9CW0prphbnIu4qPy4CxHPwLLgo3tK?=
 =?us-ascii?Q?ruwy1C/1ArMiDWh7ZDV5kPj07fLmGCdNQSdTE/Hg0xJGfmlHM06zGKNpw0bH?=
 =?us-ascii?Q?mub2UhFHsERGzeHCv07QF+1BRYqbHBzVVf6/VLcboW/XwICXEClkXaoTn6a2?=
 =?us-ascii?Q?LBpk3ahX13Dudp7+7AXAH9JBBnz1MlPxBXPPZq1mscBKAIhG4DlEYeaebaqW?=
 =?us-ascii?Q?71s3MWbRDqmmJj2qj/wwaTCQmTVEtIinh/H2w0KKRvB/tGarDiGD592KWuA+?=
 =?us-ascii?Q?B5UEBlnlhZFLfxEvE5LM3n2Pzpm02GSRHhSXI6dEd2vVL+hHxNmg8RVli0SE?=
 =?us-ascii?Q?Gx6Q5rn2SylqeUl1ZxWCKh2rFlKgNbNUR9PjfN247gPpw8pO7Rrk6foQr+1a?=
 =?us-ascii?Q?VX8/nGMBZl6jQz3LTTME+u2dZyv+4S69N6h61lchvThGVOpDGv1zuuVvvslX?=
 =?us-ascii?Q?FuKHJqfqxN1jzxSlEL2hFaPRkvWwzCoC5FVnChlaXrO32aFUHuvGsbwjltLw?=
 =?us-ascii?Q?V4HlyMtNR5Gq4htQ7wsy7bCZyiVUkoYLmMNm8YlmaWtfGkAVBY2WN0j4cKgM?=
 =?us-ascii?Q?fsZvSmp/GzpyapEvBT3BE/9KaN+g/mSWtdsnOxvFaL1uxzQb1tYFVbpF22pE?=
 =?us-ascii?Q?axr6wsjJAeQVeyVV+uz0jjEVFQAyA25bFBTspFmxp6u8ljsLNvacQV88psA0?=
 =?us-ascii?Q?Wrx8SaiUshUFdZlKEkF2DdfIooxrGXucIjO9O6Iy96nPN2evf4DySvt2QFeO?=
 =?us-ascii?Q?4pW0EQAk84Ki7fSH5meujL61vvWsLzgLjlo/KPeG7aQWwdZlPZ7NGoGwG5A8?=
 =?us-ascii?Q?LDje1InhyU4kxN57mM5xhaCvkZvf7DWV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oDWYaFWi4Jf5MuG/8ILM9IgGAy98UICt1M7B11OUKMY3S76GJ9CpYf4I7xPv?=
 =?us-ascii?Q?U2Kzyu3508mErw93ekhEUig0EYhzo8TQGHwWMoV5ZQEShkkRbgYK7hNsZoFp?=
 =?us-ascii?Q?n79a9hJhtDwL4CdK42u8I2/9J0uQMZ/8LaCvtv3mx/L9Nzl2ga7t9Zs1taou?=
 =?us-ascii?Q?q8mOuQd1deghwbeRsy6U0XKqZEdDwDulc2T+g7u+/G/hsg3L4whXIZa8KtMH?=
 =?us-ascii?Q?IO6ayB7iDvzB5lcakFYHF8B1GbHC4xAiUHu4q+/L0WfTiMkMv7XqvvwunF4d?=
 =?us-ascii?Q?ukgRpL3DwtwybEXZTKFGz7zrgAvo28a4al942bHl7/KBQBVO6Y4A77Oq34KB?=
 =?us-ascii?Q?FoGmRzHujgBSfQWJlWms03mT2zRV77rOjeFRyRYnjA7qXpjhymbAARtMaQJX?=
 =?us-ascii?Q?Pi2eZbPXAKEDpmpEsF1KBNFq2pPLTAcEqTbNcMGC4VlwYSu1S70VJFjvDwos?=
 =?us-ascii?Q?rrAFNYcXwtThRNsHhXb+P2FqIEs3CPMP0KNQNxQGX91EvY77DcFBg9cZZrQn?=
 =?us-ascii?Q?geYwAXeqq8A6esYIbb9q/qMMpOZnfMQdOVhV5u/sdafN8eniocXrNAqVHTEb?=
 =?us-ascii?Q?tZu/dMzREwyXEMRuleH33OA2/TZWSG/AYDy3/zXFVLSDuQOVO/7JtUkw1iih?=
 =?us-ascii?Q?Pupqm8zHuC+1il5+8y0AIjESznufoELyJ4zIUSHKq5docsS2aet6CL0T8Rft?=
 =?us-ascii?Q?zjCBInWIzKKzA6zuNlsujoTKYE6pOJYquZbNFop9w8Je+f2yIZdmPwk2Uxos?=
 =?us-ascii?Q?tunbHMlT2/uC5ly0s+Gyz1bx6nhYfJhyVKHUqmdBzyrL8CsNtjMDIEL3cFtQ?=
 =?us-ascii?Q?Uo4XS27n3/HMCxV5ch05miVwW18DhguYBm/t37AfM2XGbT8Cx1Y7ohGIsVtx?=
 =?us-ascii?Q?s1hUR/KWjlxhKrGrWXxN37o+X9pTsgGvU9wiLarcpkIuAsneFiKH0VxnzjVV?=
 =?us-ascii?Q?3i5fteXWwukBqVAVaB11kOFPLYEZFAt1DMzA+oaplbqk6doNL1BAAoyDYoWC?=
 =?us-ascii?Q?H+M7vdFxEdg19ZoqCcG2G5LXUWNB7caHFu+OVOFEsWUPvGhlX9ikD3JUPocb?=
 =?us-ascii?Q?1K63Ev2ZGTl9IAm5UmSoIBuR7fcHs5vj8tTCvt+Ug2915z7kzDtJXLaExC7f?=
 =?us-ascii?Q?cZT+a0j5GqfGzuArxucW1H30k2AoPnD7biPSqpRrzZKoQbr0uDqEYo9MEix5?=
 =?us-ascii?Q?QxhrN2bfeYEh+DeWLPZDrQmopmd5AWLVVPXQ4P3ouM6/HHfxyG+kbELBGMZz?=
 =?us-ascii?Q?ufnm9dyBIq9CGxyeDEmBcccF+gKIuPHD0q85Jr5jwB8a6ER3q2rKdt2GbJhM?=
 =?us-ascii?Q?773tVPPAutPhiQd+9GuyPne7QuP/CTvUhzMm2h9gU4/0cvxWtDPV1UKTO73R?=
 =?us-ascii?Q?Ydq1a/TYAz4QEHrN+w6ojLKrlY0bRTnS9Un378RFEnBgzaVDkU22+0kdkc6b?=
 =?us-ascii?Q?WbLNhVhV0BrzSBQ/NbKIn19MRurFZ34kmNENq8+iDV/gry/xsBKZloPbOTYP?=
 =?us-ascii?Q?Zlyyf4a5Fbdyl3Hqczm/olxXoc0TiW8Axhely/coYiFV1dFIjNBSV6IR0HRS?=
 =?us-ascii?Q?EBE5/NjcfanlmXWGNHEBUNliw3RD6daOkTOAUEvUAkO3FKTGZDkwscUda7K2?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3639afb2-249f-4d66-b425-08de21cfb3f3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:41:49.5388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiZ0AtS4DocMnp8uCHelZRHOyyUql0a4LG8IwWNhbInxdB07pCWFkvJPanxg+iR0wZtsofI6OP2TRWuKqlaPcpaYmB8ks215C3pdgC4kxOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8466
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

On Wed, Nov 12, 2025 at 10:38:44AM +0100, Thomas Monjalon wrote:
> 12/11/2025 10:31, Bruce Richardson:
> > On Wed, Nov 12, 2025 at 10:13:35AM +0100, Thomas Monjalon wrote:
> > > Make sure the SPDX tag is used as defined in license/README.
> > > Reduce separator to single space.
> > > Use parenthesis and uppercased "OR" when a second license is applied.
> > 
> > Upper-case or is fine, I suppose, but I'm not convinced we need the
> > parentheses. However, I see other drivers tend to have it, so let's
> > standardize on that.
> 
> I'm not convinced as well.
> 
> Looking at https://spdx.dev/learn/handling-license-info/
> it seems we don't need parentheses in general.
> 
Shall we just avoid fixing the parens until we definitively decide on that.
Just standardize on spacing and upper case "OR"? Whatever approach you
decide for this release, you can keep my ack.

/Bruce
