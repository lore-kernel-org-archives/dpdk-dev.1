Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BB10A62FF
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 14:55:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3A8840297;
	Thu, 26 Mar 2026 15:55:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 708C240274
 for <dev@dpdk.org>; Thu, 26 Mar 2026 15:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774536955; x=1806072955;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Pp2njOxnnEqqzkNX+//cNbFyy6gpuwZgcvsuUvANZow=;
 b=bpt0QSj1Ewk1KDWAX2KogGk+UI3xdk4qXxMxRb6PozBp1CT6k66db6ge
 z2WTUpr2tYADJYzf84VewGkWTuf37GxNcQI5RICmFYZUvdu003odVkngX
 A8kDGA5JbSE2eMuHKzX+u3x5NqbsxvozpM291rP7BPziuej+0bJV547Xk
 /Dv4+O95BaLPk6Qi81Kd3BLz9OwIIUi1TUQXW6W+f/+OrgdV2TdqAFiIe
 5nhaK1GJl3Hmkqj5YUUGe0DDGesWySTgWh9PubKbiEPXQ3+6JAzEIeb50
 /qMB1fI6ohT7ZSvFDJku6t4d9ReYCo14eMGgLOchmfZ8x9TtQ1GLud4Du Q==;
X-CSE-ConnectionGUID: 8g32YJY/Qomkr3HbgLeeoA==
X-CSE-MsgGUID: isFys09fT1GgtnNKA8A9Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75500063"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="75500063"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 07:55:54 -0700
X-CSE-ConnectionGUID: TD6QV9MwRqmVmZDiobrDQg==
X-CSE-MsgGUID: bfM45J55So6PyPjbTBNVPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="248073184"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 07:55:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 07:55:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 07:55:53 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 07:55:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahD3uManThxKID3L561w6v/kQEvLP1c1E22W7Sgl1RNJziQnyru4XrTYRaJ3ye5fu71ssFLl9lVlRq3p/8mNQdCGytF/EcrMBb4n3MXqeUxGVO4Rk7RPvsf3LZbm4UmYgh3MQkSyRmmICI71zwTJHAw6M8xxpRQXAURcaDii9SkWLENZL0FJzvt7xeymMAW6wnLkqcjzDyyFlFoRFQTNsiBq5x6g/H/xjgT09CbBQkd9uQOrCcin8gTmv6IWe/WwLlCqJrriJmwkU1cGuFQX0EZdah7mpoyOokITEKJwupF/XTqyxhTI081hhnEoPMxX/qLFL08yqOydw1FiVzTujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7trx6a43u7a+t1KmtTkKebEPVAPQj97UlTpJOVlJK1w=;
 b=U6d4gZj1TrZvyCVbTE+uXXlu0oWUarxEV3MMY9HccGkZCZw5dtV+Qift9mgXdEfycsjzistv/gzK80w7Dr2Ns83YAtDJF/30fO8fTdXnKm5XMLY7sYo8WZGXOtGRSpXPs/NvUlxVNqbxamCr7y8z3QchBeMXbPrKfGFkNQCi0xn7im7u5bPzwuxVe+Ib3rMsbqbQcnHMTu6Uqa2lo1jPYbIdBPuY1zmzD6/qn3oIyArDW14F7K53SjjgdmZSX2WYf3GznORnGQFxKJ5KnMAa3KYZKxa9HtXQV9P9RDTWHgosvab0yltvmioEWwZ/ru4oBwJ2MoiMy84BvMzQRN1fpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 14:55:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 14:55:50 +0000
Date: Thu, 26 Mar 2026 14:55:45 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: hailinxx <hailinx.xu@intel.com>
CC: <dev@dpdk.org>, <john.mcnamara@intel.com>
Subject: Re: [PATCH v1 1/3] net/ice: updated ice latest recommended matching
 list
Message-ID: <acVI8Xk46nYnZw4o@bricha3-mobl1.ger.corp.intel.com>
References: <20260326005407.623302-1-hailinx.xu@intel.com>
 <20260326005407.623302-2-hailinx.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326005407.623302-2-hailinx.xu@intel.com>
X-ClientProxiedBy: DU2PR04CA0194.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: ffde7258-fff7-4e6d-1244-08de8b47c53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: JDZTHP9aiB9o5wsHjgtnnT6YHxbYtLZ+ue8dXVxzkDYmEeaeDFeLpNzFK6FsYpu6YDa9pHiQpmLGCXa/wdW0whuueU0gCOGafP/kieje3cnGDPaIuY3YkeXCoRf73MH6geUWtmFJMnCwIZWLVaLXTDQmjFpzlRDnHjpE1lL8P68PrfPD+snEY4HLoj99zzfUDaNnj3LddwUPb03/YkcgeOjt4eayzGsfVdRw1ApHSfCy02TdV8tQnIuP2ym0bnNEhMC0fEKgiiVNzAASviwqEGutSeb7nJqcVIDd//mIw+3KtK0kNiKTYR1CvNN19HVSQV7X7DzDNkV5EK6gWmYztaAUyytTLzjx+hbIDin3nxewkfY3Upsi5Q+TfiHyZ0nxryYlne9upgpldEZoPeCNFDp12twAfb+oiVAw/UnOxuKsipR1UI07phZneJlFMgq3Mljm/l15MwP+h1rUm0BuW3PNgxsrQi0dftkPKiwbqlfp9iJ6DPJgqU0rZ54cQDGR6YeJKAD+K+PpGCk4QmZb5QL0JTpf6PBpWf0ElqKEZ5Ndy0RVmT+2J3M97KUsoP3qNRASQOLNxFawQsSDkEb1COZDuRC4nC/Y+3k0UiOLKYJlw/vqsJs6UPpb3n/EgUj5MJMWnQNXg0gM24j3rgR5X1jW63vOvHgrmsY1QMdwr9ap16KlsYDjJtS5tzPQ8+FRnv8Ta1/wf7NoOvKeNUbXGchGUK4fUwYKKwS/RoeSRa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+r3mu1eRMJ4/dBcUou3fik1/Y/ZAFVa48WeBJdGVtXSHSK0XGKUsB0mRZXZF?=
 =?us-ascii?Q?EATilRJHxm5hOxszkap800S8cOlWmzJT07k6MaJGYOBXQ81xP3I+ZdwWjddK?=
 =?us-ascii?Q?Q/nK6Yol8b/qLvy/UcFYiXvB3414A8OefQ5qNiR3nKDhuWZQgfT6aRLGwjoy?=
 =?us-ascii?Q?XdaYezIF6T72XTz8gVHNfdSy2qQ72sT0aL0l93fcu7K2mJHpVRi8P6Py+KsN?=
 =?us-ascii?Q?yidFVSMBQ0CVXhsxm5AAewMRPhdxbF8zCLT19Pv+scpUJNyl3EkUJJFQCM7v?=
 =?us-ascii?Q?ab8ELBJjntdxTVWMsc8NcfwBZ5WUXAgd5NSjujzqf443zxUXkBW8COdCq4hB?=
 =?us-ascii?Q?GGFwpWSVBq9qpJ44iIbaFBPwkD+uGvLbVHlQRA0XB00K1uLYCRjJ8+h1UzBh?=
 =?us-ascii?Q?LZWsah/qr3DyxP1KDVW3fceT0IPHq35/NS6n3cmzaobbRyOLPLuibmSxLJYW?=
 =?us-ascii?Q?u2hjHtnTfWxCMeqy1F8RXP6So31zYKMbHz2ttDy977erO0CC2P2/3YZVg4cP?=
 =?us-ascii?Q?GIhnmhLBEt/WfB/1Hbddw6N1vQ8oRqp4RGHvkOHeclQtaoCl7PJFyb1jkRVB?=
 =?us-ascii?Q?x+Q2zC6u1kRBU/dErBWiqzVQ/B1n0S16ElLtPkp78PO/serD4pPrRt8b0ylI?=
 =?us-ascii?Q?wlpeGwJnazgS3Sk0AEwyjHgJ9ZfbdHFabaRTtWfhOBaNGOy4IPYfSbv6nvra?=
 =?us-ascii?Q?Dad0lQNJn3pgtEV7Nl9OC4tUVS8glStI70dYvObH+m5dKR1fMOvUokBttG/V?=
 =?us-ascii?Q?QggMkb5YSJOBKmYxomVWK8yteLEz8yhgSiFnFAKCCiLLs7TMIDTHRIIM44Bz?=
 =?us-ascii?Q?1zzItPUYGAwoPBoCMJHo+3WQkcCflV9JLFDWv1nqiJDuyKgdoenRfrStnwuZ?=
 =?us-ascii?Q?r1cl422z0n0RbEdQGqR6sJYmgfH3R1PFqH5rNUkJc+Ry89ORtLoeiu8P/ET2?=
 =?us-ascii?Q?Il8nBp/Vr4QvzF4vayLY063alaKedz5VgAe9aofmDQLFwa0/UG5jeFRaiAJ1?=
 =?us-ascii?Q?fl0fmjYtsDNaRPJZjRWH9Vr0imy+C+5pV6TOXbuT/U2aqcM4Ddc/AsZCXQPu?=
 =?us-ascii?Q?si4b1FAJBGukr0E2Ti2nBHqvWViDbJ/2BU9YEkjq5Xp0M4i9l0Xe0xcpUZ7W?=
 =?us-ascii?Q?Xtoz9p8O2CW9GAhmXry3NeH+alaPTl3LQm9ok0DV+3dPIJtbSESjr0/zZAAz?=
 =?us-ascii?Q?VUWfY+FlFoRE69T5BWUYN3UuseJPDOYMLQyUBkXeLa0NvKe0cRTMCQVRayP1?=
 =?us-ascii?Q?dwC4qAcRhjM+qleMhDnSNq13mWJIW29tKBBpClhZuJLbhNCETuK/tZiFL0fD?=
 =?us-ascii?Q?qupTbg+ACm5Ro7vy+M/sIgixL1FO0x1+XzlpX9iVBENDGQNfc6WUZZDJ2xOO?=
 =?us-ascii?Q?zOD0t2pWEmw80q8BDfJmwedWWElfcUbA/YUe63R9UvYQiPLJt6VwzW7gfT/g?=
 =?us-ascii?Q?rslNFSSKlmtZufJQ/ud1zHOuztpdEfgaZ4DRQHKAjEy4PfSDA4n1Q3Yp+U50?=
 =?us-ascii?Q?crZcaeQgRA08U2gppa6jRCrronyO4kx1yWok5IzVCEtiVo6kyMqbYF0DACLB?=
 =?us-ascii?Q?jAda1Pp1CMa7aeD+QSLDy6K2y4s5V8k7oIrOxz/V3JPSKuKLH5/vR65ckjAs?=
 =?us-ascii?Q?0GgUtCrdaVb8jO7ZEZOPL8qgrPRRhQwqR/t6VEe14pivvUfas8xo/wMRv+sP?=
 =?us-ascii?Q?GpY5BgvnrieexzoAWWJfp6fjYbDvOsUvcLG0TM3mt2SaNdEydMmviIjI3spY?=
 =?us-ascii?Q?P1wiy7WFkhX2aWpRIu5Vv0qs1XcJVSk=3D?=
X-Exchange-RoutingPolicyChecked: tupd/8ol7jCqQwom0yBE8jPOAOmOnSUYGT00l8nBtzCdyU9tI+37l2Qz0ixXi3BRDpKOVFVhThgDhnzOcK11IthcVROlmJI3DnVp3aWgPf2YBoDZhLYA3YRLh2PGyHJaQIpsWt41j2ghw8bO4+blVySepgm3bMJ0/wOiMyjM36YOv2youdJXfAXQv6Zpvy/EvAAlFFHD9mT1iL1oShos4k0QXwYY9dloOh6d9d13w0e5MbnULpYL1ig7Nf/f+cluCB8pU7fWNqK5USBZK0AkWYffRitTF3LglApn3C4WB4NlnlJiZJlP8zaQhiU1BvBhDPWd6F5Hn/f2tjpiPBfPLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffde7258-fff7-4e6d-1244-08de8b47c53e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:55:50.4463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWXmSlSPbWFN/FxpQ47PfVbHkJl7URadDnZIhN+zq6+Ydq8Y/1tFEkqUz9sXmab1CmWjSW6ERpqKcrSi4VOrVMMxVWSPnE/lLOMWFbo1XFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
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

On Thu, Mar 26, 2026 at 12:54:05AM +0000, hailinxx wrote:
> Signed-off-by: hailinxx <hailinx.xu@intel.com>
> ---

For this patch, I'd have the same comment about merging the tables as I
suggested for the i40e driver.

/Bruce

>  doc/guides/nics/ice.rst | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
> index 216c79b6f2..ea73f26b00 100644
> --- a/doc/guides/nics/ice.rst
> +++ b/doc/guides/nics/ice.rst
> @@ -89,6 +89,8 @@ For E810,
>     +-----------+---------------+-----------------+-----------+--------------+-----------+
>     |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    4.9    |
>     +-----------+---------------+-----------------+-----------+--------------+-----------+
> +   |    26.03  |     2.4.5     |      1.3.53     |  1.3.61   |    1.3.25    |    4.91   |
> +   +-----------+---------------+-----------------+-----------+--------------+-----------+
>  
>  For E830,
>  
> @@ -99,6 +101,8 @@ For E830,
>     +-----------+---------------+-----------------+-----------+--------------+-----------+
>     |    25.11  |     2.3.14    |      1.3.43     |  1.3.55   |    1.3.25    |    1.11   |
>     +-----------+---------------+-----------------+-----------+--------------+-----------+
> +   |    26.03  |     2.4.5     |      1.3.53     |  1.3.61   |    1.3.25    |    1.20   |
> +   +-----------+---------------+-----------------+-----------+--------------+-----------+
>  
>  Dynamic Device Personalization (DDP) package loading
>  ----------------------------------------------------
> -- 
> 2.34.1
> 
