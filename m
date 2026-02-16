Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C20AE63F15
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:19:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36ADC40296;
	Mon, 16 Feb 2026 18:19:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3155640289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:19:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262372; x=1802798372;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uYg2heVY8FC/cfuhLQtgSOWssjKlBLlsZh4W71pcniA=;
 b=f0Vb6xuSKxDfzBIDTnI/a3uodmnC7pinLEsIUdKTQxx72zHtg0Oocm+Y
 u9tMoWEBYMES2ufTPbg3XerwZnmgF7oIzT3dnhxDkkkkluAcqBsMtkIws
 j4oLsAGpUelSOwh4eJdlXBGt4ZNWAGpuqtt8PEfn6grnwi1N0VvWHBqXe
 wp7vDHIodjvU4s8zkwAgjVhWGryizgkxXlthLrRabfmWv9NZ0hIeiz9i+
 F9HlxShMi7iuI+K7V7UojPrQUWYheLW0fF2Rw/4i1djLna1GfA6bPHx+v
 TLuOXLYggS5HFxBO2Ih+qLpkLr4/0RSbI1Qm+emCXPUAOOP/aOIfn+mSd g==;
X-CSE-ConnectionGUID: DSa8W3WKSHCVhtiiahyDSA==
X-CSE-MsgGUID: lfDTQ/x9R5Slc2b7RLLnDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83782222"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="83782222"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:19:29 -0800
X-CSE-ConnectionGUID: Eb/KERHmS7OBm6gDyBE+Ig==
X-CSE-MsgGUID: UhjInXIxSO+hERk/QlrRBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="218193309"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:19:30 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:19:28 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:19:28 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.9) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:19:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLq8YpYfI+R+6rKbmeSD7tllKb/KFHcMiC4GBNt2O63y233ehhRgDGY+rhaa60D5Kux5culyLSkVsJrfX2kG289KH+mlry1D20PnhllG5WcTym4Oaxg+set7BgRANgJWCdJ0QTdQjQjTeCYv3yy8mvdRZP8VpgXksSdGAAi/SpaxQTpA69rSZR3W8XFund67ZtjTgCZ/w41v3E7+C2/ZXXsLtQ9rOyDH/8zpAOqI5fZ5fv4aRj2HyvDenhMiz3WCLwZMUMyTcXcyrysOr7MBRc7iPXbXl7lOhQFOPCtYJpluvcTH//BFT5ahIiFSg0X86qDBTnyS3v98CmMK+cGI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwICbVkIDxu5G4Ylb5qFh3Vd3R/gfx+7WwAvi7u+E5k=;
 b=jChqaKPWHrPreWIFmTjR4YWVz7/Z8fDGxr6Q1Rk4z7L24kU8quAeX4PjELkrWLS7H+TdyoFOjM0CJz/LZ+qU46x1zeeyJj0xGob20prWdexKUOuiDbvBtybLVkODtr5KGaR5NTZmTlxrscivOp/NSLuGKbdYc7UjZ+uKmgPAxeX8yYQ6+pG9r49QlqBgQuojpHSfFl+7Hi4WMi5FZb2jsQfbdg/90IO59HlQospkLoFR7ErBTm+HReWxZF2ev0ecG1nz34YbHtO43Ws1tFJWRftcHE1lmy6gUYuiPrZHI1YPCgq828ryixqNG4QmsFXw+nuENulhdX0yNn1VWMfhwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8518.namprd11.prod.outlook.com (2603:10b6:610:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 17:19:24 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:19:24 +0000
Date: Mon, 16 Feb 2026 17:19:19 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 17/27] net/iavf: avoid rte malloc in VF mailbox for
 IPsec
Message-ID: <aZNRl-TpyDzwitGE@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <67e3dfc60d3d5709563cd93810dcc6390090c28b.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <67e3dfc60d3d5709563cd93810dcc6390090c28b.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0091.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::26) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 028e7a85-36e9-4e21-b916-08de6d7f8828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XFT9G3AJILsvFzttpqzO+313njXbojBhY2hA3cleVEjRaaId0kIp9SpG9JDR?=
 =?us-ascii?Q?NQONZWegzwHlD1kLKyVffCWoyjVO/stQM0bH/PIcC/OVnzT5RSONh737Xtib?=
 =?us-ascii?Q?rYgRZuYQjCHjG6td59MvoTDRBZILwRO3O4xN0H1GrF0Ys4P94ziT1vUJDatf?=
 =?us-ascii?Q?J3SkKeme5pJ9NXZWglGpjPVpw1D+1L0x8aEi3J/osO4abMhbe5p9OSZwrSm7?=
 =?us-ascii?Q?OBCiAWEHwyeCjZ4+WgNYh6oRz5Va2D6jkizk25Y4yzLP+aYzw6fLMwTT2ylA?=
 =?us-ascii?Q?6z6iR7U2tstsOc56JoPMEixheX6jX9e6S5ajAPVztT53fmi5ZCDSSjHUe+rV?=
 =?us-ascii?Q?zkvVV3tsd+5X0WOIeVMHlYU5+q8JWcBpeWWDytfIXK5HvOsU0y0k3CCTawd4?=
 =?us-ascii?Q?c2BQxd2oE2z1nnfw5bVM4v/k/rMGCqdR+c4zHORkNmp1q2uDJoQymxYc24MM?=
 =?us-ascii?Q?prUXI5E6TSQ4dehmTsjfvmfnrrNFCMyHAbcRXdeXumNJ03nubqEMZ9vMAmkX?=
 =?us-ascii?Q?4gKr2fx/kIwiis8gJ+7ptgCnJjmAEUh8cxiu7fpalIu9gmLAn2IDLphG4tTQ?=
 =?us-ascii?Q?fdnnytvSgRxZL/Gl3CBmLzGhkaf4mdUQrlMoT/Brh7L5z39t3al+mIH2R6Vg?=
 =?us-ascii?Q?FL3bhM9fQyL/bgbL3dIvwpwp+35gLBNMzO9Ld4EAhZ+8LMJRzzDPXyjg1C2f?=
 =?us-ascii?Q?umAqeGUb5Mz3MY1dYwBbA7bnxpk2/vb1AE+6Z5JefvlItr7m6ddyJQ1/rPxL?=
 =?us-ascii?Q?bq5YWhr6LY8pZETZjuoH3Eapwd82asJ0a11aMJQ3q5wEASTdjEbC1RJ0BjYp?=
 =?us-ascii?Q?6w66xOGGLyZTn4stArEu5BkhUVYabr1BJDxPTBmF+f8DVTE8kgqCKqU0r4z5?=
 =?us-ascii?Q?dbV20zePimAmlUh5CU7QcCQNCbq/SzNBza1fs4WqxOUw1BdhD3RoxTDNUnOy?=
 =?us-ascii?Q?ryJiqN1xFZ11VQAjuGTlIha8Zv+b09n5wOJ4XF7KDNdlgBBpkLp5RaQhN4lg?=
 =?us-ascii?Q?9xUmVjAlE4EV5iMeoQVQYs4vdYmmAzSyp+kjpyyMmeaW+PJhqT3A8JtK37lt?=
 =?us-ascii?Q?SqfM3otjK470jSCkfJGTdZxV5UMhlB0j2LgLxnd4xZE+c33JK3xV3CSzNIUs?=
 =?us-ascii?Q?SGOFmeMQmGaxNpmXUBvmfgNIBh9VlXjwSrEi4rfcqd/Ii0/MEdtHEhR8PEGX?=
 =?us-ascii?Q?F3lAsTgPHUnmTGxJbS3NdLubIvz5XiTV+IXQ9IEpzP91jC6hdi5CqKGbgYJs?=
 =?us-ascii?Q?6jBG8Xr5MBn7QlAOJnarfUIykhLG+JD0EbVBgc+2H9o2LWrJi0uTb45YXdj7?=
 =?us-ascii?Q?YSIrx0JhlRZRkoyjIonUZKVcPQ37KnHH1QFiZ0wQJ0W8szU5KVI1dK1HTnrS?=
 =?us-ascii?Q?12SQQrJtIGSao9awD0L6ffQ2Uvopa4DQ3xWkeyDQGkFfe3L4XxjJanvJMrYf?=
 =?us-ascii?Q?vKmIpBTDN652EEZfRy/9VVu2G1yJXfAzjeu09F4qCj/tm3IMxmwYW1Krf9sd?=
 =?us-ascii?Q?XkhpTd/UhAOdRFfpCWBYEdIpWxsRdVQN56C6aFTa1qoMyNthKmmjjqqkPUhZ?=
 =?us-ascii?Q?Nby4jwt8ElEp3FigVKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WaKZWYefYtA9Xn8M6WyWGPrguxpd7wEMn3qEvbrg+jIUK/2AFUFzUgMHOmQI?=
 =?us-ascii?Q?0aPHtZrP+IpyI9bUu0upv7swTRL2Q/ojnwzhrNbZD4L7JFLVq+2YTP2lm1Pg?=
 =?us-ascii?Q?FD3+5+VmMkF0Ym43wkB4R86qtqYG0Wr4hdRSh76Ed0kMCdk+eUA+9KzK58x7?=
 =?us-ascii?Q?nXdko8ohrilgUfmrluMRNg+WVjeRTkSO6R0tikN/AQHbFgiYiZDNvoPDG668?=
 =?us-ascii?Q?V3yuO4QXjD5sxu47XDQ4LXK/eEDaUnmZYagziLUjxorGMF7oUQREcSx8vTFJ?=
 =?us-ascii?Q?xCmoH27nRPwnsTvxww6DDvrv1iA8/lU7oFg8K+uZYafgPIJvEZY8A2rzT2xq?=
 =?us-ascii?Q?1aB68dzlAdbaqYr3WI+uB+aNEQarl6ZFpUXxYMh+uG91MHlleJyg+VkYgmzZ?=
 =?us-ascii?Q?Vo4FTl3fCIjyQfBzjJhQ2x5+WVsfLjtF7y0GQNq1j3q9q7HGoLb+bUGtQgBT?=
 =?us-ascii?Q?FGyw63o+fwmPlcUz4PZQsGL3YkTMfrSfmnuTq7Z6+WoNoG+9+5VVetDeZXRv?=
 =?us-ascii?Q?/5mmHcLia3Bbbk+s2/Uqz4fIt1OgWycZ4RTvovffdIXISVrpFo+d69vJosbY?=
 =?us-ascii?Q?SAHysHMzJ1gW6OekI7JM2qgVzY7lnoCGMGCyKqWgCuNuGRnEScZ+b9KVVGRw?=
 =?us-ascii?Q?gv+y4BwrBZJ9LeYdAbqX0PZrdIIRWIZTvRXrvBPyrK/QzVv7SzZfai1D+YAb?=
 =?us-ascii?Q?5IEtI7u4sCC72gUW5oMroZBzcxnsoVZIq1nkQitK/CLMouprLW3Qr8IzkJdt?=
 =?us-ascii?Q?M4r4OqK/MaYetxtetrQAPa2gZh+sxjB758JHzDkzM7zUZhMvsYoOxJCyfEXJ?=
 =?us-ascii?Q?rjBnI0Onbde+TlQrB0Chh7Ow45AvdPunII1F4bCPT1SgIIQHBbmf8PKx28aI?=
 =?us-ascii?Q?u92S1vTGca6ENdg54fVSXT8Vwqo8wQpoFz8JVx8u+O5F+JQpXzkOwir9T4GJ?=
 =?us-ascii?Q?ilLjUXLwsQZbGSJWkymr0cbeZSf3D/DOzSlJiye36mxL/Z+qtaKOjmFZz716?=
 =?us-ascii?Q?aYkdpVxKj/NOEV/8BIbF9Vpacj0/5+JjGMGhoszU3V8xhvcFDbXTJ/RjnW9q?=
 =?us-ascii?Q?pyvCTu1ovjwF/3n+c023V+jzYkDrGZTiqnqmjpfWHcGxd8wan5IDRSm0wEhq?=
 =?us-ascii?Q?74fh0ksfOcWho2GlMgBxt4m4GH/25YUpAIeMiydH2AeWlXhObbruHBPPiaYP?=
 =?us-ascii?Q?P48U/j0KUnALzOV8sY4AUNFgJCOC+NO2dZ72GJFNvbfKTOjBmMwmDghcqUqQ?=
 =?us-ascii?Q?lqPBqeWlJIhnzuH+8FIIGKa0V/zL/yFup/b5ktD/+LhUXn2Ew8cHkPcAAFi7?=
 =?us-ascii?Q?aGXwREEsetuf172g9w8gPQD0ZN6nTyj0dLW/fox0LMNh2j5ZemhXJDI80Bzw?=
 =?us-ascii?Q?bvgVdygS2qhtQLhfI9qvflYx//IJMaxKLPs56IMmJupytOGnO8xMKJfyOQxk?=
 =?us-ascii?Q?68bPuid6A3wQEpC77vnGk6MfYovqBXZZjx/LjY3qFkrLK6eBx+4xZnYUytQU?=
 =?us-ascii?Q?KgemaeBxaqTJoxSEj/hFjU28MeCOfNnxzA46fJlLSgY1B7jzk9teE3uba6s+?=
 =?us-ascii?Q?bIYTsnBiZZiEVJTf44NYyI1L2oYF4xOlHQmT6VNrTiEkqz+dMH1G07wfQnWX?=
 =?us-ascii?Q?f8cJ97sELr2kdJ0Jm6fOlKIfcuTFl3a553hKspIUAK0F1YqdJcoKSiMpFJCB?=
 =?us-ascii?Q?8sMsKHdCFl3Doj+gKhuZtChpw6M4o/7p2+fGFy99amBOsNM42ItroyE4X0xs?=
 =?us-ascii?Q?cIU2POENyPvdVEZw65V245XS3cdByAU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 028e7a85-36e9-4e21-b916-08de6d7f8828
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:19:24.7962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9o2yRkT5HdH64D96zTWtKHb3xyOH+ejXlmls4y4vdPSumgdY6vUWuQr8xsQsAKtWW8mGxXdwshUF4rnt5jjn9mldfYZX2q5mnvpb9tCTkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8518
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

On Fri, Feb 13, 2026 at 10:26:28AM +0000, Anatoly Burakov wrote:
> Currently, when calling down into the VF mailbox, IPsec code will use
> dynamic memory allocation (rte_malloc one at that!) to allocate VF message
> structures which are ~40 bytes in size, and then immediately frees them.
> This is wasteful and unnecessary, so use stack allocation instead.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ipsec_crypto.c | 157 +++++++--------------
>  1 file changed, 51 insertions(+), 106 deletions(-)
> 
> diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
> index 66eaea8715..cb437d3212 100644
> --- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
> +++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
> @@ -458,36 +458,24 @@ static uint32_t
>  iavf_ipsec_crypto_security_association_add(struct iavf_adapter *adapter,
>  	struct rte_security_session_conf *conf)
>  {
> -	struct inline_ipsec_msg *request = NULL, *response = NULL;
> -	struct virtchnl_ipsec_sa_cfg *sa_cfg;
> -	size_t request_len, response_len;
> +	struct {
> +		struct inline_ipsec_msg msg;
> +		struct virtchnl_ipsec_sa_cfg sa_cfg;
> +	} sa_req;
> +	struct {
> +		struct inline_ipsec_msg msg;
> +		struct virtchnl_ipsec_sa_cfg_resp sa_cfg_resp;
> +	} sa_resp;
> +	struct inline_ipsec_msg *request = &sa_req.msg, *response = &sa_resp.msg;

Nit: Split these across two lines, since the assignments are a little long.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

