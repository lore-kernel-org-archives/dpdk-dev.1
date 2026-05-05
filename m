Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01A4FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 16:31:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF5B14064E;
	Tue,  5 May 2026 18:31:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 91F274027F
 for <dev@dpdk.org>; Tue,  5 May 2026 18:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777998671; x=1809534671;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fpKU00RMvwcxVE1mBHmvCzbw2BqWzio3HFQ3YHY5Ct8=;
 b=Q6xJL4qx5B2O7jqKTktC9JmZzawztyTKzr9w9sgDchpBO9EzvLGczidK
 33IxkXwkbULWW9oV1TZjeLmy8RvW61n4zu0M1NuUruse3ASp/+obfel/p
 GSIJZBfZPEy4yqARESfUuecaYi5sXxiy4FvlEFYqezrqt9fV8hD9/Kvi8
 sMMzAwvkMuGUU4n1GS6H+PvuPr6ypU0pCio4Gn1Wx6GIZLR6S7oafofnH
 yPDlPWmeD1Ml3qMRB+8dzQs7PZ3kSeqPzsbgd7lruG7EbPMCWHZV7TJLo
 S8IvxIuWpQSxjA9b39+ge5hjbs/3o8TFgufasdWYBAzF0bdkgHgfn7OMC Q==;
X-CSE-ConnectionGUID: 83CmAPTwRqm2LNNuPI5gqQ==
X-CSE-MsgGUID: pUvnFgCvQC+5xdqI0QvSww==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82744098"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="82744098"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:31:06 -0700
X-CSE-ConnectionGUID: lmLy583WQzGZlt6UaYx43Q==
X-CSE-MsgGUID: rWjm17GrQhyi+h0YLSMoPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="237636306"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:31:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:31:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:31:05 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5i8XMJQqvUEM8+IgJmN2kORN0IhFh494453r3HMByhy+kPMX99KSo4R49a8Drl1IGoktPWmZjnq/pydKIPKZxp0Sr5rU6lqf7vaSCl1VTAxJWAke/rtNTh871/WD+gQqKMw0y2AyHPkI93WI/1U968vDBLm6JPsCknyZdE3urzJTGz5VIwiMck97yf3wFybaQw3uAtA6Z4SFyDNzf8WLE9NyQAckG0wGlhCW8mjNQmLp4v6wHvzk6PGctOuCmZMHWgk0o3HgQN2nqLu9hdrctE758GpVhyg4QcFl1w9ljsaICPv2gSziftWeStV7zJq9M3Fd3C36ygVfyB3M3kouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6M5sklhFgITwu+PCyiMzk7K3DH11kIBrLuLvJredGxM=;
 b=Nk/TSlmjtXMJ+GvK/7/2NEEzCknae/6T4pihvVhaZLAJWEQVj2+wJEQCd9ZIPJugtAW8zORKYhOTlfNTSk6YDmR1hnqb2iKo+tK0F0ZPOF3qAyx9G9OJZAbSIkIYu36V9t8+6yX1d7kdkTPVR+tlM8x0cs0W5JzIcKPXSh8L8Sb41Fm3/3y2/59qXkB3viq6oy0ZAIUnC66wOBJ7uAG4NtDD1hlvgACFjfL+uSbOm/+H/Fl9hyv+sOha3EuAIDuedbht7lxRXMUzmT8Wd6Fo/Aeh5xmPkKi8ehJN6v+wV8azaPSZ+yBqVU84WS0BmU+kj85cUWbfm4dzZSSIJq1saA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB7706.namprd11.prod.outlook.com (2603:10b6:806:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 16:31:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:31:01 +0000
Date: Tue, 5 May 2026 17:30:56 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 2/4] net/i40e: implement flow dump
Message-ID: <afobQE3igBhOsZHg@bricha3-mobl1.ger.corp.intel.com>
References: <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
 <0eeac8e3162368f3448f9f300eb5120f4b978a54.1777546834.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0eeac8e3162368f3448f9f300eb5120f4b978a54.1777546834.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0079.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5b5037-98ca-423c-a3c0-08deaac3b1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: sE3a/gJFxbdML6klHmDPXk+1OXeCnttqTMHv5GNGr10/wpMyUEMR00vNFODC11lA3e9bPMCwgeyPho3WDWiR+BhLg3JxdxeZYikfRO5AOzUc+2lRQS/K6clbNUSP1T/HyZySVyyfKO7EWTALFduD46AMoAPcF31hxgIvbxgDmNqYVeBSHOjqUMUKDSbUSP0NPwDKaDjajnvJnItGitFEetK7fh3G9KLfCcHJKRu4MZUP0eUMVOYlM1/UGxeC4nSUwbd/2/OnoZ17AZz4xi8jDWBSa1+1PnxalmJOW8Zzoi3kZefYJdX4+5Kusn9icfjms+iuG3u8ckEnZNYejcM/0REgzObztt9ZiTGqUvuo//1LnmG984u6ucJ/wGQleSwuSOFm2QSbecesFo3HQEN5D5tSt57dhYlAeVdhH3yGG9+J8u5E61e/xF2hdqtca5Y1QfiKvh96OlAOfgKKJ3ZRPqVVPLlEzIqbN20cWIBWCLs8j/TCp6LHhZg58kqJdxuKzRthc3b4WiqJ+Tn2Cas/RFMIx45hqOfCctlsDw0AhA+2C0wav2uzRtCKBH8MtSDMp84mJQ2C0WvqK3RVyhLnwpr+GREzGogCYeV/mWBI3P4ZhzOSwxvMPBDkfyvcZ32JeU4z94C6LksKtQhRBLyZOFh7xa/2WCgCeVxj1+W/26IFAxBwjhPBTE2Ypq98fbU2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CSWlhgZNxftM9lPrdCMbxKA/tPtqySMVNbBQPn3Z8T9RL/iZy7IDwkn9qHZW?=
 =?us-ascii?Q?sILxROAThUkvWZYWMealqqmOo1jYY7oxb4rWhWHCObh+UXSUMtfYuRPELsRp?=
 =?us-ascii?Q?pSzSBPL8eQTxJWoYhCPQW7E/MmNQjxH1UH/vhlymsBPx/tgoUC89LQ1IRQ5c?=
 =?us-ascii?Q?Cio8fKTRsAX0wwtKIdwc9Dk5MrjgqYYuCTwqdF4g5L+GHnKPtDz6G1yiWu03?=
 =?us-ascii?Q?n88GQyLJImtwjhjyZE6qNRHsHS3RPuvVEixdLoVU/ijDCGPpTccUWfDLfe/a?=
 =?us-ascii?Q?8bbGdJDYLg83lPTWMxpFIv4rtY81f+P2XX+Igb5BeTQDkW3T9vtsssxz1yL2?=
 =?us-ascii?Q?RrhHzflUx5BS3iPIsfg8KfLU9Fb+ffhJViR4xJkEJ0yxOrYdIVN4gD+557fS?=
 =?us-ascii?Q?dC1OiSLSD/d2ySqUJE2pcgP9/Wcxc7hjWl7K//V0g4d5A0lqtQi5GOn6hj4G?=
 =?us-ascii?Q?wBiYqOhIGaHMrFyG4adUcgMiiwREVltoITwd6d80AqWHLKi/siLdm8Cy2Rru?=
 =?us-ascii?Q?Ck7gPoVZyYjklRiW6J9sbdL4rWVVoFrfWoZ5UTUKLWDG1jfpOB7CxODpn8X9?=
 =?us-ascii?Q?4WGqstCQRMU7ZtmpLIwA9Fy7PRcnlmIsojn4gK5jVtF/MOQaItmqX76Vos7g?=
 =?us-ascii?Q?VPoRdN8C06KBaabSS7AbFfHsuKr0z7Uo15VoCO1yp4pSKYS+JADlUdEUDit2?=
 =?us-ascii?Q?S1BGhGltJkOqrHBapvNY8EvQaWUE2qDi6hT+XUq/rsnfLo6plfyvvQU+TbKH?=
 =?us-ascii?Q?vez97doVZLNbfVx48Wq4GRWZn1TNN2VdY2DG8NawWxNH0veU98KaZ2vaNxVs?=
 =?us-ascii?Q?b5RyHaJgwPdxREP4bqgToyuqBS2na5N2gQcmyXgPzZVES6b+5hkszC4CHnBu?=
 =?us-ascii?Q?HUuMkxXjS9ILyDwnuRa6+uUXWpQsPjFHKRyE02YNN2g/J0Vv22IX8a9kU5a4?=
 =?us-ascii?Q?blNCzjH9nqPPc73frwZNn96FN36QPT9m5PJOCfyp8E/jlxghbCbE/0Z3yyu+?=
 =?us-ascii?Q?969+B+Qo51uHsEjt1hbPpTUTLPTHjY1fZFz9+m+quYmhFX24D+810RQH4Yaf?=
 =?us-ascii?Q?ejeg4ZdmSG7/q6M6Dm2zRz15aIh1HBs1wbudEt2E7WtirriizyozWRRPuMlx?=
 =?us-ascii?Q?p9HlD47u+M0D9Ya82hVNgt6Djntaq0Ns2WP0T8wJIHqjPr+hDGGLDryXEII5?=
 =?us-ascii?Q?WzU5Gw5KOscja9oPsqK+qdUAbHNZEvIs8olbCdJ3AMh7d1GHSICd368ORtYG?=
 =?us-ascii?Q?swEDE5PsZ+8kzU4x3EOutqMTWTGDHAZZHz1OEi4ZVDgwdH/HwPxJaKuUaHXL?=
 =?us-ascii?Q?/+lnIXXn3Qe3iH00plrk7uY/Mwa/nx0Eai1LLWrGLwdp6b6ZhMVDTcd/uhWT?=
 =?us-ascii?Q?WgohxcEKqFbBXN2tZPYy/QjlyVh2uoRYnuz/nqVB6ZgfPUEzSHnArUnRxKz5?=
 =?us-ascii?Q?H+OyyJ/XX9JWvcW1qXXhNp1pMYasl24BAJDkErCwdBB2KEnUwTeQSbJj9mPM?=
 =?us-ascii?Q?yAuIUues1COW17WPdn/ovnwUrlrK4Yk94UxPT0w9MuJQn+pQYwilUcCPOd8A?=
 =?us-ascii?Q?mmIBNrzQunIyiJ50AjSgxL/EmJcjiEWjhI3KutXzp/0qUfJUeOxzeJErHQUa?=
 =?us-ascii?Q?IMl2RB1Dm8FC4TQ3AVhLFn1++RUYZX298dmIcl+SxyMWDVzUcPeuiLBzUt9K?=
 =?us-ascii?Q?oyHodr55NW84ZxkEqvTKCMwGdHfejrbi/gUCzdBLVb2PAMh+V5vsGHE6QD3k?=
 =?us-ascii?Q?EymVahp4Y2w6KnbkH1eYaHCSmeVZnx8=3D?=
X-Exchange-RoutingPolicyChecked: bg3TgsPQpo8NWgaMnItwtICh95zyRH+FylYKjqa9wTH8JzLahJUwd7l2Xw5AoZxwjjOgK0Z3AcgCS/v7CDz+NCZn8WgdV5Oqx/9gGH0BKyte2D+YCPqhhxk93LVITYZ8E3lK8f2FofdCsdbfQjk1VPVBZOXncQhJmA3SZr+oGqJVis0LLQMvlSUAG7hZ3yY51ycGCiGGO24qn3AvIQbpz8c9Kw5VxsRS3mlftqbnhsYJJ+I7i5aBVgkvdXExzAlEEfIxCfk7f/NHp6lDfk7kPDkWJiNQ9lohcBKzzgKb9AHAqx0jmfqGKRiY9wNG3DlF8K6J02Xu9zqq9aCAmz61ew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5b5037-98ca-423c-a3c0-08deaac3b1aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:31:01.1899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/9TWd1d3ETaSwLX7aRKvhfKdwl7yV/uQg17l20deYMZmlNsnKfyWLLMJi4sW/vN3xLpinL71L85lYaIn84UHgwo2l8XX/MuyrU526iNUC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7706
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

On Thu, Apr 30, 2026 at 12:00:45PM +0100, Anatoly Burakov wrote:
> Implement flow dumping API.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_flow.c | 103 +++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
