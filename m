Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A30E9A048
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFB564042E;
	Thu, 19 Feb 2026 17:53:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EFDBA4042C
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771519981; x=1803055981;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=K+f5Nqp4MEHmjJ1PzVux0Drlcp7RyUa69kIxyf/V5K8=;
 b=Zvt6YF4wJW10ppWfHbmhDJCvprph87143VU5dmqlISKfBm8bSkxw02TL
 XM+9rtcSnhU78b9iXkJScT7w49RXxdqN19wx5FCK1hcndXZHjSqxPijqu
 8g5a9VvPiRnAkpgJkskb4SMvvL+m8sRtlXfqag48APX7yR5cTRztk255r
 J1ID2f4Ubum+7nexu03yeVOXRThlDqqGMCNTxoJQVsDIiP2mL8d5dA9la
 PaJ+KL3uuDZLNBJoHBc2YN9PKwzFZsUbPGPDSIimrTjIKsl82pvfc74rx
 A6ElQwhjFbTF3kVnB3uM+McIfwK+h9PVKS8FY45gQgjxNJSHwjo3XPan4 Q==;
X-CSE-ConnectionGUID: ACPWPPlvQLCrhzk7sLtOtw==
X-CSE-MsgGUID: WMoY0pMyRMyVwwT+30qjaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="60186214"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="60186214"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:52:57 -0800
X-CSE-ConnectionGUID: 7GcC1Qk+SXeiJ48zWsQ1WA==
X-CSE-MsgGUID: gNFajWBDRPGb2h2FZ/X3Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="213657858"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:52:56 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 08:52:55 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 08:52:55 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 08:52:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfcIrwcieL8LIJv3WFuRFlea8hnTDaU9iiJwFI3p59SIz/OufQRZX5EMEX8Nx1bRiWRO4xtvK1IepFbQj6xm50MmKkpbeYHhAqBTVL6N7XBpOsQ95chMg7qjhRCrolt5SUmOZGsA3JapSmRMo7k6kBFS1kXqPkVudUGtB8PICgxpbxbRY2lkSD5kxWBpc14pZnY49tWkaJ8EIeNvwyxRZOniLD9f8J6oRfn9xIij0NfHPsUiVHKDDwfPZiv0Caa0i4xK6Y6supQLsy9DhAooQKAK+FUUE/K2rf4EeqkTuoTi9MBS0E8gXzxtnFL8v9WNRw6/SRGlewSEHJW7BGxDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdfDHieqPVBjmgw9keH7sPDfC5G1VkQpAJhG5m3GWzM=;
 b=OqGMVBfSRxy96XxfMkBimc9wGDHB8dDwn1fLIP3F+1rfaEuu1/OiyfbLCgYcMoQCVgNeYTQaCxRRCZ0izWvXn26PjqaEV+AGaKT5HQ8fluINbI52NqEK029MCj6jOpYVBlvUef95MSQwuGoox+y82tKjX9lbXIxopdwQGYn+A6QYWNEjb4GLOlVlBS4+NicVj3AVguPETpis7WIs2Rl965HptDuvQljzGKenFYqytJ2AZ4LmtcUqHc0balaFyL0hR66vkNBXgYcGqw+Bz1eXovCTWONOpUtGG7mhG4SsJjU7wa0HXF4r5NQcKX/ltIVqle9ipIo099aYIcgD3PP6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB5171.namprd11.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 16:52:46 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 16:52:46 +0000
Date: Thu, 19 Feb 2026 16:52:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Shaiq Wani <shaiq.wani@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v7 0/7] Add support for L2TPV2 over UDP to ICE PMD
Message-ID: <aZc_2vLFZbtIXyM7@bricha3-mobl1.ger.corp.intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
 <20260219112103.2370766-1-shaiq.wani@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260219112103.2370766-1-shaiq.wani@intel.com>
X-ClientProxiedBy: DU6P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 675c54fb-1c93-47da-e064-08de6fd74ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qEi/Pf8dUWb6WRTQlSjT2KcQVKPDo3qmaE3yx6GMfW+ED9lHMnPd+eKIZc+W?=
 =?us-ascii?Q?y1knyBin//hqexnUttbEcD8ERUSvsTx8Cq/cF0fuGZsEKLkecGBU2RUa3/dJ?=
 =?us-ascii?Q?LyiHneG+d9gTwI04z26kNQsIJ/U8yU5oSG2EJ9vxJOdz/L9qGrRXWcWYjNxa?=
 =?us-ascii?Q?/O+G2Bwe5s0kF/S110wZKjC1xBA8ENo7D0c0Drfw1JWznTtcbJ3Cf2PXyrg0?=
 =?us-ascii?Q?epuVncsPv8X9CUWOK7jgWYc1Psw/cB/Xn5GlagOA6UB6P7RTSKQX5O7+v4rt?=
 =?us-ascii?Q?ei7OwwlhEFOTfw8v8P93SKY8T4f+mSULVsJzHjCs3QtRLmCaqH1KUUnAo0P7?=
 =?us-ascii?Q?ffjkYPsJh4Ui1IC3C7HaRxSMQfv591guolF0DIeXclOW431Rj0xxb8onNiL4?=
 =?us-ascii?Q?gRE5CUcPo7ueELNh6ekQcLnAk6GxVe4lC5Lm8G0TOj6JKC0P1Zd/EhEPwQD9?=
 =?us-ascii?Q?mGOBmqDt1kmkRhgR0/Mow6+5LJWihnUU8ygthxDEz82aBPRBwk/MVdlp8aC9?=
 =?us-ascii?Q?daN5pS4JZ4JVWHqS1yINfSQ4fWxqAdqyG5RfQLzSIoDfMc7bX0/jFPRGISj4?=
 =?us-ascii?Q?vr9DR9t57eBg+Li1oM8fYucIfAXVfzCHgy83oL1MBqjuaoIeDNvKMz8emx+b?=
 =?us-ascii?Q?ApRatT41OGMv0yB1y45MMRmvyxRKQMMa0PBeQ1wGWcEijaX4Gj63wz0slOMk?=
 =?us-ascii?Q?nw7MSrwZfTViuge90mumtoURi1OUhbQMr0sEzjJg6GUDei7BKmvquEYYs26K?=
 =?us-ascii?Q?eET71ghLOaS3RkXSG/hayZIYR0PVwSFfli104v/rUBjQSKzSNwueSBEp8Svi?=
 =?us-ascii?Q?vCHTN0bMG19VZMUDtp6uWH3HiG30xGZ7FhANguOLjEMkhT5VAv4y4G+2nFju?=
 =?us-ascii?Q?6LjXyewKRXuuq1bt9sfNIb6dLZid+i03XfHRV2tFGvB3P/SAPxYuihilrOz0?=
 =?us-ascii?Q?A2akiqILLyfRq2bNRaw9McD+aF5DOM9bOhDl5LaFWUf7Dk7ugc9p47MOCWnz?=
 =?us-ascii?Q?kbm0hPZcpVJY+eJzzqERDXpXi87Yf5zSPblUEvz47GRCoIPhJbdIZ09uXxtS?=
 =?us-ascii?Q?GizrJwRg3S4QCWfWJbuvOmam9repyTDlVUFG0TdRJMniUkKODDO5aV+9hIHn?=
 =?us-ascii?Q?Y2RcwnQJwAk8RoNBqznyetWCwPcL35xNN37cwCWeGJq/bBOhWYwh7fjArm8a?=
 =?us-ascii?Q?ipUF2bA1aubIy9wkM4H/eMgt1zjTEE4vM0VzoRAMEF4fGXmCthKJEdt/KP9t?=
 =?us-ascii?Q?Z1ESpmBF64UI+/eLJABcHu95Jqh1w/nltFxJwiHr0zqCYmXorAHlX0GO+o7p?=
 =?us-ascii?Q?tQbZSzfYldLRrudOrL8ZiIMU6YeDTrR2rEd/2UgTuvR1l2GcCScrykqIu60X?=
 =?us-ascii?Q?UA/2Tb3oSVRYL9NP8aJftJRzI2Vj8soauc+hGamOk/r6x+7jeWf5CzWLypK7?=
 =?us-ascii?Q?qdHARHVs3JuhmdTjCMRzBMCA9rXYPhb88+QSkFDwNURYQgP0Q0s/qBkkXNMD?=
 =?us-ascii?Q?0+ddxc326lppchgBjc4Lev6ed3mR6267IiggZWglsgtXGflKwGLGMu0/bsht?=
 =?us-ascii?Q?UELaf/zszdqB5K0QdA8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nH5eeBH+yfm4jKlBW3mNkQF3V0+QzCkBsZ8Wr4KQkZPiXuM242zuur2tLwsn?=
 =?us-ascii?Q?2f2WU3nfMTOHRLUxL2nqzAJDuo4xWjz9wdXCToaz4K5POGSJbOWgqzyqFvtX?=
 =?us-ascii?Q?SSK+WpVnY23Vim4mEFZJXX38ffwAwxjsALR1xmRDabYvnyQmZ+g3q7FjEPw6?=
 =?us-ascii?Q?c2apPX2PNULoU8PLMK6ARgfXi4bAHUUomrNR5t9OLQFlmg1OB2o2CrkHrTQq?=
 =?us-ascii?Q?bzetui8ficrdvnpWyeifWsyo6qbXyz3ApLMx9vMGjaLlSXrdm0p3ivj2wCAF?=
 =?us-ascii?Q?8/OZ44rJQ0Hq1X9q0cEDckheLUv82XgJLsGQ6EWT6VTV1GBBQ3TRYL9LbZ/5?=
 =?us-ascii?Q?63BaskT0euk3e+zg0T0j5b4zjW6bd55iP4WWFheegbCXGIwE7LgDaRY2JMO/?=
 =?us-ascii?Q?/TVnby8tMoQRlBrv0p8CHrPfrlbrE6dMxjbEIAgBEwLb+bwjIr6wgVDa8M3W?=
 =?us-ascii?Q?ZUjZRoU+oInfIwHmQWDZqGHQoMNXz9Rr+8OQn1gossM+kPWLIoadinJMa636?=
 =?us-ascii?Q?Nh1I33mEL0D1rEnoVnxUrLnyGAFek7s9dl424CNnIzOnj4dFNMY3I1bFpAUS?=
 =?us-ascii?Q?YbLlcz8Q1wthwD5dL9tbKkb1aDPJSBy4/eUAV6HCch8jKrcE0jJ8hwWs4BnM?=
 =?us-ascii?Q?vS1dp9OANECHkjeciNnzt9keLB/D1/6U4JTbHSsBcmr2BU2d7AtQfCY3mYP9?=
 =?us-ascii?Q?jr+xqW1ON4BcxshssxTGbdI2Y4S9ROkseWViTyEBQ0Gz0rp+zPoZplNCIDiL?=
 =?us-ascii?Q?gYEaofHGkx9zqgSSjTOSHkOxQ1p9vbhd6pgf10jBL7hxpkSO5LA+3Ag2vBTM?=
 =?us-ascii?Q?ZNbuNXcPY75ux5XriD+MulhN4CtacWinaOGxoqywOGLasw5VtHrm6mh2BNL0?=
 =?us-ascii?Q?JxjDnaiP30YAkeIAmSJHeb4ThPt9GRPFeBFsKzawO5XUJTvqS9jydoiRhnQG?=
 =?us-ascii?Q?6IEeRJTacGM5/NmXT1AD4c4Ta6xVFbT6XKwpwDT5IpbgQ9srx0ePk4cooHfe?=
 =?us-ascii?Q?1xJQgK5tp8vku+LSA4r+zujo6rtpNm1eRF1OB4pdyw7akgdMPSga9Y1W9+v/?=
 =?us-ascii?Q?a1meIftG0zM05sZNMA6n1okvCYoKxq3aaRlKuQDY1EX+TCKOpIffU6yWsVnG?=
 =?us-ascii?Q?M5oQg1YjsL1+k8iXcXenJLrUNIP3TCM5e9Lj8nvdE+1UK0TpSDWmOntCZOeT?=
 =?us-ascii?Q?8Xqa9WEjDK/GJw/FLePoKrud/m5A20+AI/UiSGabzn7ZbhZMxtqWvqme8V97?=
 =?us-ascii?Q?38OkW9Y/K61cA/gr6Zk4DjVxZBnJCC9v3lkFMZ7TWTUuyqbbm9lsl/PURND9?=
 =?us-ascii?Q?41uZOQlePaXN025auggRgNqfv8TuCgsqkhLOuqvJa89C/PUCfdjvMfmchCZk?=
 =?us-ascii?Q?Y+ja4MXjvLiyOLdzZzM8Nw7rlILft6QBz9fTxJU6a6/e7Cs8cqJeVpqNcM+5?=
 =?us-ascii?Q?M/m4bCi3wQxSUx4uNrAzm4hsbGo86p5NorVZpnadvBiAWi1+I/M08dB/kIem?=
 =?us-ascii?Q?CGyi3ZiPrOcZwvWRkSwtzHwaQFBojTsGOdMhtQEETxRMpE9MqbpFWndwvhIp?=
 =?us-ascii?Q?G/vDf/ENIrwpya1AV7Y0rLRZVvsC0TPkrJSYgZEiZbAaoxcaljI+6cCUPjNH?=
 =?us-ascii?Q?e2CBGmHggUvirTnXr48/ynuKiq9ksHb/toDSGw5h6yNjrJWD0Z7EYe2OlvxY?=
 =?us-ascii?Q?A8NltTUwnLsjUpe7LGKHGy1AReptK2gHaHF6dhwqPDxUtwza15Y+ilx3bQ8i?=
 =?us-ascii?Q?GB4X3vxv9/dMwAxbShUR0RhpTXv++is=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 675c54fb-1c93-47da-e064-08de6fd74ed6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 16:52:46.6179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDb0BxDknzC4A4/acUGBIXeqfQkGFsu4IBY2bIpF9660oVErLNZgXXs85XKf72bEYtBl4t8HxFNPOK8J3xa7M1JsguL+6NRgLot/IxWwh/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5171
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

On Thu, Feb 19, 2026 at 04:50:56PM +0530, Shaiq Wani wrote:
> This patchset enables L2TPv2 over UDP support in the ice PMD via rte_flow,
> allowing flow classification and RSS hashing for L2TPv2 traffic.
>   
> v7: removed FDIR in doc and commit log titles.
> 
> v6: split patch 3 into 2 separate patches.
> 
> v5: Resending v4 patches with correct cover letter and threading.
>   
> v4: *Version 3 patchset was incomplete due to a server reboot.
>     *V4 includes all patches for review.
>  
> v3: Fixed compilation issues.
> v2: Addressed AI generated comments.
> 
> 
Patchset applied to dpdk-next-net-intel,

Thanks,
/Bruce
