Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ECCCCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 16:29:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68C2B40285;
	Fri, 10 Oct 2025 18:29:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B964D4003C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 18:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760113762; x=1791649762;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zx+sIlPGZvyj7DtqnqCo+5iPbNIS1Ng5Yyl6xharZxc=;
 b=dED7E3glUDPZ1IzuEqU78KrlMOdfpr4vYaqy6qgRmCjadVS/oR4Hc7nS
 T+k26pn2NovTyhUbjPGBdmeR2IsdNtLXhDrqQcT/wJWbV8yUjURaSBoAE
 lLRulR0vjSwKz7qX2Bu9VA5Ka4xqANoDbic6BIxSs8b8Hbx4fWi1gtERP
 T2bn4DvtA3Te4X0BC9cKMBaGH9XOste9ISI+G8nAK8hWNzhGl173rC9Wh
 xTP3nj9haLSfLdHzHMKuowBdsofPwqAqwHbjgEdxmFTFmNkInDySDEMQ9
 SSsER0GjJYfCQtictK67Ko/0AAHaEV13S2dsX4tabFxwTE6PXhIkm0uTM g==;
X-CSE-ConnectionGUID: oTXBgTa1T2eqGYmo/u2HtA==
X-CSE-MsgGUID: GKGq74slSE+9jaRwKO7AiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62039276"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="62039276"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 09:29:21 -0700
X-CSE-ConnectionGUID: kBV9cVpTRhSQRj+KhDbWWw==
X-CSE-MsgGUID: 4v/SUzFQRH67vHTDemQv7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; d="scan'208";a="181025745"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2025 09:29:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 09:29:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 09:29:19 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 09:29:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeVsrT3CNcTRteS++ov29Lt5/ymuPuMNjA8wJeg9mMI3ZE5IVwuDAg++Gm9tPPtkham9omIRFDGCOKZIsvA5o6BrYy+PRSVcoSmM8N25Jx3XakbZURQ/S5uBnhDEjyNZonQ3SCpI4k8kWx6KXvHBYo51c6Ztfn0BAM5K8YMZkcZGbdY58zooJkeHH682OCQ3VgmCJkpoy9QTp+xbURvELKlk3Xe/3Vny25UuB3bO0157/o8lFdA+VeRNl16101nm1o9/6ZVOVlIBT4eQVOzsS00FDlY8R02piT10kmkSTF5gbmQ7DHzo7kWmOn3bXrwMPzlmifE1QLzFBtiwV2B9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3cjfZi9DS+zKF1eqM36MKI91x8HrqHsBxPWwBO9rUg=;
 b=N9EUWE+Uxz4cpi3j+yirVypZQDZXuLcWS/DpRR8lsuGsqKAPznz0MfmDKbOyJii4c15G6bgx0R5DyMOh3ZRS3LKxeeEdD93kiRHmS39gPt/oCKxwBqozDLVaJOPr6tfsqu80rjh7UA8qfe2xi8ked4oKnxE8Cy9+6N9f6znmBlUAnLkSg+YGimpHn9VjjFbv7AgEIweZrksJz/hmz9+kvsWpju83MxpFFRngcOEdTFLplIVnePw09GDF52WfwEFGvNtwMOljhlQ1yQzVbOoweZQCxIfDS3AcgFcMiWfR/ouObg4bKXqRXrCCkkfyZRy/Do6Hm/bUzLf9yGas2JoNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 16:29:17 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 16:29:17 +0000
Date: Fri, 10 Oct 2025 17:29:12 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, Timothy Miskell <timothy.miskell@intel.com>
Subject: Re: [PATCH v3 1/2] net/iavf: support VF initiated resets
Message-ID: <aOk0WFgTTVeVWGby@bricha3-mobl1.ger.corp.intel.com>
References: <20251003102359.823028-1-ciara.loftus@intel.com>
 <20251009102835.926479-1-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251009102835.926479-1-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZPR01CA0218.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7c724b-bd54-4c47-3cbc-08de081a2887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ugYscbltgmPHjE1En0JjA2eXdqaqpranbqvRplECHkN1pys4DKb7wrqyCfmt?=
 =?us-ascii?Q?UKdFrLrFFKj5rYGkcGGUaJrnQ8MXNoc0dnZDFFQNzWjvOYiRedy89xuPerXJ?=
 =?us-ascii?Q?lfUDhYe9Qd7W5dAAwxtb1r5rEZCT1T5faPGhTFGeGAZducBzZy7tpQazYFfK?=
 =?us-ascii?Q?vPk3tzkD/n12UPiJ9DYhZwQ2/EcV+ZK+I/YV/ZL3el8ZxmmbdeeFbal8acPq?=
 =?us-ascii?Q?RYKpoLsTPV2Kt+9uuyKLx6iiIT6iJ6ngxrMXWMmS1/7/p6JEGKzRrLcpE32s?=
 =?us-ascii?Q?C1dTcVx9kXrmsNqizqOt9DVKYJLSr49G37u0hNYvxOddCgIVona6fzuMuzsq?=
 =?us-ascii?Q?42jUicmAaUOPwx4TUmiWQaE/3FfPx1zCyEKY6aAlsllFGQbW0bcNshnnRRfZ?=
 =?us-ascii?Q?QGTHLYe2vBiDggMRbOK9OHYNUQbEVFraDpN8r+57Vw2tPqfsG7kODEVQjkQw?=
 =?us-ascii?Q?5az1TSFMCFZJf5yjS5+3gxLbXKhS0scJki7MHpVD0+O4xnKRtdkZxQySxniU?=
 =?us-ascii?Q?wPTA42wbToF9C/HIN8nOdTVO3+kD0l2JdaCjnIWsRmm6uBw+asEd95QhKSW3?=
 =?us-ascii?Q?KP2e/s4k/wYc0tBDDB7vvzkRX7MZIY4ZaPDF7if8OfY7NQ3Nq14QqTBuTDtS?=
 =?us-ascii?Q?NNszNFP95grV1w+KL03U/9HjA6HE1bhBJMwjTK8v+eNdIr+V+SjRKa3S4Aex?=
 =?us-ascii?Q?p7UVjoQkD/XOjhs5uSieeHRd0UW4z1EU+amh/yxwe2l8YWS+qqZExAeumge1?=
 =?us-ascii?Q?/LZJ6gqrd+x44+Dse7UMqMQMFHJCcWiEPhJuulhzzrnqyPLOo/QSF39qQRdc?=
 =?us-ascii?Q?y+vOVxYm+WprNWXLxxX9YgvFEItai2l2MGUOUyvgOHDYpbr174rzx72isdfl?=
 =?us-ascii?Q?TsCAwbkf/7D0J/rAHKyxW+fhNsuxcVAF546pLOkMX/l1nk4YIr8VlKYiAuBH?=
 =?us-ascii?Q?KxNY6YfUDylzepgi6Vzq8Jw5Z2LX8MHkfS0falRXDDXKQ9rJmSXRofN8lb7d?=
 =?us-ascii?Q?I/cunc7Xr64xVOfqdptim/vzZCsfNVHdnXc+5EHiW8I6OWQWTNC1l9V8LS2k?=
 =?us-ascii?Q?je0eDvQ7+3rYzB4JqH3OnD1hm1g9IP6yvUXbqxwh1Ova4UuJco8Xk0rfhUvf?=
 =?us-ascii?Q?RKr5Hwy4jLCYOXqJNoMuHVB5TlK80g8oDMp38NDRvPDV8fss2bbMF4EE16Xa?=
 =?us-ascii?Q?EK4ip9eQh9MqjWQEbQZSFkozl6cX2MOKY1dZNEw8OFA/pPn3a7rSk7RW3F4x?=
 =?us-ascii?Q?2jgYZd980wemjJ53Ld4EzIIKRTwXcZU9FOHw1SWxlaMLZnFsrRhP3rjsxIVV?=
 =?us-ascii?Q?DQu9XWPPuRgn+1DyAs7gbp8YHHKUZOTo9ESy4lb4Gc01w5uBz1HoZmXptDM4?=
 =?us-ascii?Q?rZShHyp7lPhrKl+xI4njcrbzQ/76MUuSmIFUN8hk8uOHzcNNC6bPl7oJi0j0?=
 =?us-ascii?Q?28yNzttOqV7jQlSed9TdgjrHSQfY4k2l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+BSPas8xlsHYOeX2W/lQfm9g+5QtLivoE/8ychN0kH/UnIH+ZOYRka+crGkT?=
 =?us-ascii?Q?jk5pFFTuuqJ8ZaRryPgJJdAVYlvkZq9LRT3Nl70IT859y1PLH66Fyz6LVdK9?=
 =?us-ascii?Q?hHQ/eDcjxuQm51M3qBo21S1h4gJK2gQp06YmHYus0vhGUmdUsymgBNpsNA7G?=
 =?us-ascii?Q?vgUWrdFUI2aNp5nE/Vwivepu0gVxuaS6gOC85Amt1MOsBmzldRVbEXogWuCK?=
 =?us-ascii?Q?KE16IItp6+gA6l+clF5rgB+1uQgNcnFyPVnlodAl//F/NTtHV8bZeVNIoMlv?=
 =?us-ascii?Q?V+DJABafjbURitPuHo8KxAHpDDQMGIAaVdNNd4fsriie3DYpZteSZcTzbwxG?=
 =?us-ascii?Q?aCb20RxBsqgP3bL3GFfgT5j9ENXdlSbejUZcEDgv3aqWJKcVvu/NE4GymB0i?=
 =?us-ascii?Q?qmiO0kTRnusiTCHUQfh6fUud7ZLo/VvMQYDpGHDbZTBJy2rx35eiyML3RZIG?=
 =?us-ascii?Q?4sHK6pi5W2+3XLmaQAHHbEsosTx7Ff9v83lqrhu+kq3JDzeV7QckvW2fE80u?=
 =?us-ascii?Q?NDM4CIkDNZv1BMZAAVyyue4A7c2fvD9LsXqWtyQXgKddJxQbyfn+TXCTfIik?=
 =?us-ascii?Q?L3nTVYy9JP8mJDf8VBZqVA3tGEMIbWnVu+ShrRWfHege0EXLflMOH4sClYRI?=
 =?us-ascii?Q?7bHMJDPrTxgd1Bxd0jAfYr4ahhiAskidi7ZT2ZilcMHumhyaST8Y5e9fQfAN?=
 =?us-ascii?Q?L7KWLl8tXgALztD2WITpl/SJawQ9XTs37vP4c3pL3/sAIyoUYELZxVDVtBWI?=
 =?us-ascii?Q?8ZxObBSy9NtHvXYUzU5awEmZ+iqdYVRWTHd04rjR/ds0fd3B4FjIqFPjhsf9?=
 =?us-ascii?Q?HvR6J//q7G28KdwA2DPNemAHU4rUFqxybJNgYcj+2x/l9m28UmHh4tDwz+/2?=
 =?us-ascii?Q?i6pcUPfzRYk9ifdzY4eBPgA+byinIy9bJK0o9nqXJMtYW10xbkFb+hkhtRrN?=
 =?us-ascii?Q?ynnaJdUC9EpQ96Y4O0w36tV8ecLNrFqz+op5VJPo3cK71hI4tiLK2GViHC/d?=
 =?us-ascii?Q?CjQvU8LWdU02oGLx0uFHTOxSux/nTCoOzEuhfUEBp6GF4XE7vGkp7/iXls+c?=
 =?us-ascii?Q?W0Of/Umixmcv4CX7/3KFyFPxf2MSQnsJ4xxykkmTU3/RfMVqiIO2+XRWY37x?=
 =?us-ascii?Q?jDi38d7KivTWLk3yytY0UUnMc3b1VL3VYBC4CLymPd91iFkBc35m1jltbfRX?=
 =?us-ascii?Q?tFYnl0nhbNV59yjoFjGFLcUaNRD8Nr4oOLDeAea4f2vS+WoRNSprY0LJnidR?=
 =?us-ascii?Q?mQM7KzlHEStZNi30rbKtTsOfC4BF1P+kfTLLUc2lXAVW9ET0yYMHxVdHVz8Q?=
 =?us-ascii?Q?hWqP8hLiVy6/NMGB32xO+pkas0WfQNwedcZ7BbIgctM70JIaucAiXNSqSke4?=
 =?us-ascii?Q?EmQCxJHrx35QSMDww73qmj3FyMzfHXgFaspqC3fKwsHE9AAf4iBB4CTQ7tz+?=
 =?us-ascii?Q?Fre6P6gCnwY0uxMwSoPNiGtI2IwlNNWgriFZC2NrUc7hrCSYA63JSZOWIlvi?=
 =?us-ascii?Q?C5Y9J0BLf3fvj3Kk9nIHCxbX2vVRafLwDOMLSZM2mLtD8HL/cAcIa/uHzNvp?=
 =?us-ascii?Q?wqPWlfosy3VIrieMvtn+poDKmkLx5ppXgl/AGrw6gG2vhiTsjUdZf3T8RgjP?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7c724b-bd54-4c47-3cbc-08de081a2887
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:29:17.8266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7ae9KTDY9lWR4V1g/RaHMtNEDrtUaYTGYqckPTcUTjiamXpEo2+Mi+7XAzQM0IjsZhGMFx/81kn1VgDNP4YZLXdVlLimKMDekC90kSR2sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
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

On Thu, Oct 09, 2025 at 10:28:34AM +0000, Ciara Loftus wrote:
> Introduce a function that allows a VF to request the PF to reset the VF
> and then subsequently reinitialise and restart the VF transparently.
> This is useful for example when the application detects that one of the
> queues have hung or any event where a reset is required and the PF is
> unlikely to trigger it.
> 
> This commit leverages the existing graceful reset recovery path that was
> introduced in commit 3e6a5d2d310a ("net/iavf: add devargs to enable VF
> auto-reset").
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
> ---

Couple of comments inline below.

/Bruce

> v3:
> * Don't set the "vf_reset" flag before iavf_handle_hw_reset. It is only
> for cases when the PF has initiated the reset.
> 
> v2:
> * Always perform the requested reset, regardless of whether the
> auto_reset devarg is set or not.
> * Don't use the event handler to call iavf_handle_hw_reset. Call it
> inline in the rte_pmd_iavf_reset function call.
> * Do not send VIRTCHNL_OP_RESET_VF to the adminq before the
> iavf_handle_hw_reset sequence. That message is already sent within the
> iavf_handle_hw_reset function during iavf_dev_reset.
> * Rename the function to rte_pmd_iavf_restore to reflect that it's not
> just a reset being performed, but a restoration afterwards too.
> ---
>  drivers/net/intel/iavf/iavf.h         |  3 ++-
>  drivers/net/intel/iavf/iavf_ethdev.c  |  9 +++++++--
>  drivers/net/intel/iavf/iavf_vchnl.c   |  2 +-
>  drivers/net/intel/iavf/meson.build    |  1 +
>  drivers/net/intel/iavf/rte_pmd_iavf.c | 28 +++++++++++++++++++++++++++
>  drivers/net/intel/iavf/rte_pmd_iavf.h | 13 +++++++++++++
>  6 files changed, 52 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/net/intel/iavf/rte_pmd_iavf.c
> 
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
> index 435902fbc2..3552db7e06 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -563,6 +563,7 @@ int iavf_flow_sub_check(struct iavf_adapter *adapter,
>  			struct iavf_fsub_conf *filter);
>  void iavf_dev_watchdog_enable(struct iavf_adapter *adapter);
>  void iavf_dev_watchdog_disable(struct iavf_adapter *adapter);
> -void iavf_handle_hw_reset(struct rte_eth_dev *dev);
> +void iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset);
>  void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
> +bool is_iavf_supported(struct rte_eth_dev *dev);
>  #endif /* _IAVF_ETHDEV_H_ */
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 08c814725d..8fd7d39c6b 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3096,7 +3096,7 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
>   * Handle hardware reset
>   */
>  void
> -iavf_handle_hw_reset(struct rte_eth_dev *dev)
> +iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
>  {
>  	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
>  	struct iavf_adapter *adapter = dev->data->dev_private;
> @@ -3105,7 +3105,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev)
>  	if (!dev->data->dev_started)
>  		return;
>  
> -	if (!iavf_is_reset_detected(adapter)) {
> +	if (!vf_initiated_reset && !iavf_is_reset_detected(adapter)) {
>  		PMD_DRV_LOG(DEBUG, "reset not start");
>  		return;
>  	}
> @@ -3212,6 +3212,11 @@ static struct rte_pci_driver rte_iavf_pmd = {
>  	.remove = eth_iavf_pci_remove,
>  };
>  
> +bool is_iavf_supported(struct rte_eth_dev *dev)
> +{
> +	return !strcmp(dev->device->driver->name, rte_iavf_pmd.driver.name);
> +}
> +
>  RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
>  RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
>  RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
> index b1b7a5bf94..460035d772 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -83,7 +83,7 @@ iavf_dev_event_handle(void *param __rte_unused)
>  			struct iavf_adapter *adapter = pos->dev->data->dev_private;
>  			if (pos->event == RTE_ETH_EVENT_INTR_RESET &&
>  			    adapter->devargs.auto_reset) {
> -				iavf_handle_hw_reset(pos->dev);
> +				iavf_handle_hw_reset(pos->dev, false);
>  				rte_free(pos);
>  				continue;
>  			}
> diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
> index 0db94d6fe6..b39337733f 100644
> --- a/drivers/net/intel/iavf/meson.build
> +++ b/drivers/net/intel/iavf/meson.build
> @@ -24,6 +24,7 @@ sources = files(
>          'iavf_tm.c',
>          'iavf_ipsec_crypto.c',
>          'iavf_fsub.c',
> +        'rte_pmd_iavf.c',
>  )
>  
>  if arch_subdir == 'x86'
> diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.c b/drivers/net/intel/iavf/rte_pmd_iavf.c
> new file mode 100644
> index 0000000000..2a04f9ddba
> --- /dev/null
> +++ b/drivers/net/intel/iavf/rte_pmd_iavf.c
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2010-2025 Intel Corporation
> + */
> +
> +#include <eal_export.h>
> +
> +#include "iavf.h"
> +#include "rte_pmd_iavf.h"
> +
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_iavf_restore, 25.11)
> +int
> +rte_pmd_iavf_restore(uint16_t port)
> +{
> +	struct rte_eth_dev *dev;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port, -ENODEV);
> +
> +	dev = &rte_eth_devices[port];
> +
> +	if (!is_iavf_supported(dev)) {
> +		PMD_DRV_LOG(ERR, "Cannot restore VF, port %u is not an IAVF device.", port);
> +		return -ENOTSUP;
> +	}
> +
> +	iavf_handle_hw_reset(dev, true);
> +
> +	return 0;
> +}

I don't think we need a brand new file for this. Can it not go in an
existing iavf C file?

> diff --git a/drivers/net/intel/iavf/rte_pmd_iavf.h b/drivers/net/intel/iavf/rte_pmd_iavf.h
> index 04b86a5dd7..50a8cd0070 100644
> --- a/drivers/net/intel/iavf/rte_pmd_iavf.h
> +++ b/drivers/net/intel/iavf/rte_pmd_iavf.h
> @@ -96,6 +96,19 @@ extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_tcp_mask;
>  extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask;
>  extern uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
>  
> +/**
> + * Request PF driver to initiate a PF-to-VF RESET and restore the device
> + * following the reset by reconfiguring and restarting the device. The
> + * port must be started before calling this function.
> + *
> + * @param port
> + *   The port identifier of the Ethernet device.
> + * @return
> + *   0 if successful, otherwise if a failure occurs
> + */
> +__rte_experimental
> +int rte_pmd_iavf_restore(uint16_t port);
> +

I wonder if "reinitialize" or "reinit" is a better name for this function.
After all, it does a reset and then a restore - more like a reboot!

>  /**
>   * The mbuf dynamic field pointer for flexible descriptor's extraction metadata.
>   */
> -- 
> 2.34.1
> 
