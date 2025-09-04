Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D8DCA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 16:30:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04F984278F;
	Thu,  4 Sep 2025 18:30:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 16CF940275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 18:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757003404; x=1788539404;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=azDF83t19Y+oq9XXrKPw76VSorwFxwejCXwCqJjQtI0=;
 b=kFqC7o3a0OhZA0WrkfCsN9KkPXmGbR7cgcuVIPNglrlnFtju1XDaH5Qi
 bHqJU1ewOpA6TcyS9td9x7qrHkJQ5zfl7fDQzNvxAw0+vULXDxIWi7mST
 Uzb06x0wTKK4ml2mrU78Y9P7OwaqTuQg6n4aYp9ycnO84Ft6HWqTy7qiU
 llHF2s90uFg6yehsrnjfeGXaWi2+wYgktF2xm9W42QUZnQ7pt0bPqd30a
 n2S1Wvz+j4j3iCfV1SMxZf0ISpGFTuCTtu4lZLxSnLeKTuRBTXoq5josq
 dKK7femNjv3JAb5QByGfAHZ01e9Tmev/GoV3CBQtFCPcqQhFVIdOKFUF1 A==;
X-CSE-ConnectionGUID: UKB2C7gsSj6er1MVMcCNdQ==
X-CSE-MsgGUID: 4t9kn/JHSbKf8DU7Uobgrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="69965555"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="69965555"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:30:02 -0700
X-CSE-ConnectionGUID: QgjCDqVgQbi7usTD+yGqIw==
X-CSE-MsgGUID: lnYloZJITE6VFm7Kq9b6nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="202776541"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:30:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:30:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:30:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.64)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJfmFGaO0V7LpRFifhq6eyXgVuIHmXNQvfcdAodID1wwEE/QRnLmbUmI9P60EG+8eh+Cb2ixxecPWmGhevFt6RW1Jf0p+vCFop/MmPg1MX/0vh6+ogW1FZwNqdIQZ2xi6IWjL086b9oRPiiMyTEynbt1Btrsa4Ar5REmrY2fBmJerjuW5oLxOCm7SpEKZBO3wkokXrVUKtO2Z+j7XLYBZg9DhwzRhCfD++uVUpd0RBW3dzmHXx9y8hsZvyeCgBKK3YTqHkoZllaz5ZNHhW9HzT6NUeZJwsVuzb3a759THI0WLrgh+O9kE/YYcewqOdYAZIuKf3/30KygeF/qnHqQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50B5tC2FOB/OM686S/94Nivlf48N/NEydqzlxSgm4QY=;
 b=WAIcKOhSoSY9JZL5Fd22m7T1jZRYPm4F5j4NqcUp5llOKH6v/oeCzyGJipu+rPP2OS7zHh26YBedAbK+WugflkN5eQpQMOF4g60eUEk5zsTJ+dB0g96SALtKHZsSLfWj2FLkTuZ2U7gKVlofbvbYuSoX0tCksMSfyOKQVOrxS38knZow1bp9LhwprKYVvGcJZnPoSrPL2jZNz3gIuxUAegqBr/2t+wPs/fjdks+qiZFu5Z6J9pTYoi4SB3AsYi9BOuNuo7qgxKzlMfzymGX3QMEEg8ViTM9qICnsJN8wc6UfwrXw5Hu2NjhQWKHL3zEwwK3DVNf/tV8OsTGvMii5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 16:29:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 16:29:53 +0000
Date: Thu, 4 Sep 2025 17:29:48 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 1/4] net/i40e: fix supported offloads for Rx vector path
Message-ID: <aLm-fL9ibTXA6Gsj@bricha3-mobl1.ger.corp.intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
 <20250902104859.2100141-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250902104859.2100141-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DUZP191CA0064.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eadc6d3-a127-4d76-8975-08ddebd046f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BQ2TwoX2FRaPnMoYzi31po2ln8dpnf++1/2xxIyaiA6nQSTCZ/3tTO3tFPV1?=
 =?us-ascii?Q?nOZJiS7hvMOoD4MWP7/bxDpNWcK2IiQw7xF4kcVKzfGmxxyFF6mt5aM864DN?=
 =?us-ascii?Q?+jrdq7UK8bRGUQ5gUgdmrG2+OLpzu1ZJEb9Vlc+ZFVfaUPM1E7kXYWo01pYQ?=
 =?us-ascii?Q?4p6DDr4LLKcJylEYeZobxw4Ve6z153UyPYz4JZDhyZMp36VMhPmHJsD4sDIp?=
 =?us-ascii?Q?djehPBT8bNJgIo4pE+2cupNu7+lDLVGRAE3f+yijWWm8xK7zkVvTU8HsQnyt?=
 =?us-ascii?Q?41K6SamgsjM4dVTrunttsYODygFXKL9KFj2ZhrHG6OjL56BioSwpQMp0pvFP?=
 =?us-ascii?Q?WWlPoa89QxAszeTpcxOPVkI2JSIhRYV0MJmduaLicl+mlI3uussTyYEUYJWk?=
 =?us-ascii?Q?MjrJhoHS2iRqQew2wn0Of7SAewRfPxTIQaJzaet2xgOcowXbbulW8IcQTk1W?=
 =?us-ascii?Q?74GtPf0vcTKyXFS5pXCiBmxF3/hZVzLU4p2/m5Pd2+u9L4GHSButHRnfUu1w?=
 =?us-ascii?Q?s52JSrp9SdCuWIVzQmWwcjbxRkCCsi2uQP/NrMmVET/oFrSTT/8nFXk3rZOu?=
 =?us-ascii?Q?9o9pSuqsHYwDkETsJB+0LVnWVHg8roLeh953UOvOuJYN9OgCIPn1Wu8t9Jju?=
 =?us-ascii?Q?5ctM9dih5AfCjXVGbn+aoX9fgIAL7/4sJoEuZ9hBeEtpkcm9lyUyI9pRVc3R?=
 =?us-ascii?Q?DqWcgaztqfeP8AWHtuZW4UN64+W5e0jys3jfkjuHUln7Q1y2TIylQWKFA5IF?=
 =?us-ascii?Q?FA6mwfUqhtU4Ta7H6NlNAtAnx8D3F5W9XSGe9xUzmxxcaW2e7tFy9qD2nGAe?=
 =?us-ascii?Q?6BynYcgLzSVsN8W/Bpep4+8/8JaGwupLQSCEISnD6T7Ys5NkTGLyMHj8fuQ1?=
 =?us-ascii?Q?gKE4hx+y/LF2tOiYodCiyexrh3taiiPtLxv2jLy0SLejfe6wAYzZZ9YPftDS?=
 =?us-ascii?Q?8AdAaIgPIEXVzHWxrZVw7LNg0G8C/OYLUy7T46SC2gL+8Kpd2zDciVflDvQ1?=
 =?us-ascii?Q?WksGeIVrSMI3yyiy/H/ASEeoX9uGvWUh8Up3VnCyjrRRsg+tmXcj7HhkDARi?=
 =?us-ascii?Q?5nxuYaI8bHy4nSGj7alunxC03Z2nZbMEvkTD6vLb2YqMHv64AjFAZfWyG0zh?=
 =?us-ascii?Q?LGFoZWNo2HZLEwKsfDcQpz6RavLpUMbLCTt9PoC983blauDYC4vWk3/1nyKh?=
 =?us-ascii?Q?ucWJ2kGloH/jkd0cYlgSTH67z0z3poMh3BqgBYWEwa9i4/UYdQqn/HBvuped?=
 =?us-ascii?Q?c4tgflNnqSHaFBCu0Z+I6Hx+P81lsvg/9BF9W0yfiR6JPfSO5UjaFMGmjFOM?=
 =?us-ascii?Q?vbF/BtCPF1xewSzsA3HlFdrKr8xb/tFV9klG/SAF9bcLwiXUQq1CoI6zaLSm?=
 =?us-ascii?Q?IV9KEdXS3qxJ3nhWlAlTSBZzv0U5jFsNzYr7BZz9Ih0vKNmtPXRcMSo+RrKL?=
 =?us-ascii?Q?Ll5Q2fsENl8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JYZFNJF37wz5xtRzdo/gCHqejfYYZdMnVT3oigm69p/CcFwHirPqpRQ5pms?=
 =?us-ascii?Q?4se++25iDWNIiAtFEDtBx0wEjmw8QJmH7TwMFXb5pSBq677udYQKtlhMh3iD?=
 =?us-ascii?Q?ljf5+eoEak986pKoTdpgylNKqsJ4bSvfeXu/CLON1B+CVhxhClEsUeGpojbC?=
 =?us-ascii?Q?EXZacksf8SKq+/iOQY+2IqncRsr0RW41C5lLy0FgQ2+iWDjnBxpNztbTmeij?=
 =?us-ascii?Q?aEdI09hICVqH96M0sguoD3O74Ow/4UL+ctYO5OxmryT6lYVl14DGWdeZRZK4?=
 =?us-ascii?Q?OcuMNAt9T/vV3zaLAVxw3dZoEZrvXcUPJOPh7rlZ8w1qV7i+r488x7kZ5+vq?=
 =?us-ascii?Q?HEEWVR354KeSKQot2BmuGbNZ6uKmF7lIJQ3flXCfZqoR2IWLgsYWVWa3CyLr?=
 =?us-ascii?Q?w1i/sAUoyjV26LXShuASxxzgOeZ8ZxoR2x+AFH171lTZFVlkx0nhM4Nbm6ui?=
 =?us-ascii?Q?ahVkiix9dDqBEnvR09xITjaTWnXmm8zXqBYCKKOwnaKbrz5+yURss1NVsjpd?=
 =?us-ascii?Q?Y/ts0kJDl/Djd+Hoz0cksF4JGKhsezFuds/X1wyaaVeOqxWH96DF0i7NBtn8?=
 =?us-ascii?Q?iEdT8AEhkP0hUrv/biHLQnCIAWNLPYyAGro3S4SaAbjO+7GlCuoP1zWwEpVX?=
 =?us-ascii?Q?GHixIZUnjXl9Q741+Qq3RrxfA6SOT9zIj1ScEsa64Ixten1eK5E4wLPM8hdh?=
 =?us-ascii?Q?s1jo6Ru0YiwFJt3ZtLiDosK7Qc9CmOHHm0qTTlsPrttENuu5cSwr8ba8Ipti?=
 =?us-ascii?Q?tiwzQIJvwy3Wne78qs+2luDkXzxJ3NoMjgFDacJGbJg5RvvfZ2x8pdKLXwEs?=
 =?us-ascii?Q?owNXLaaMCZGF/ItwK12ylbUKfjkJzRRaxX81acGfrFizDQlOT/WEd3UTEERj?=
 =?us-ascii?Q?ibBeCe4fsu3DyKMEdmJK9f97yPjJSu4PLutpfqXvHWvbUeubZIpAiRJBUXtc?=
 =?us-ascii?Q?IdRSZfngI72oyEoJSddQHQV7sHqHZXRZInHrrulPPW52u+CmiFEuq6yG3aJ/?=
 =?us-ascii?Q?dQLlWRN+iLJHX0RGbtKHd/KkHEVbXxZNJhzSzKLmxz0w7vqMl+B7X0iyxUw2?=
 =?us-ascii?Q?7ENg1xMFcGedou0PONcklfhBp8FgVH36l1TlXT2ijuchqRvVyawgbW5Cc+H0?=
 =?us-ascii?Q?qait6svn390qJWhmxV1B43b4cxq2nI4C9P0+f/wMtdwxGOeEyH8QLtBgT7xX?=
 =?us-ascii?Q?OvvYjwe6SDvKvL+51v6NElozafoJKs65XTYHj3lizq5KuTcGwV48QBmw2Ci0?=
 =?us-ascii?Q?pIe6Z7hknJUSpvXr3+6+qPh/TzyBJpeBUHEBXSUzNma9uGTMBHUWyVX7nwp+?=
 =?us-ascii?Q?OxPof0dz0tJW6sw3UPqJ7PKpG6lMiPCYCdRxmL/hGo+bVqSlAdUdMYXpxdU/?=
 =?us-ascii?Q?hqlduK9bHGGO8ZkR3nx9/9awVzoF8fM/nVLFixPDEmga1hjTYjhiyWdD76ku?=
 =?us-ascii?Q?V+79lDrXtWIi09U8R+w1gNQmyQ8bCTNWqSl/D8eKMEibMtWlJiNvM6Ngx7P8?=
 =?us-ascii?Q?eC3gGB/ciG3h99YPHhfvS/pPTPJJkCCSB55dnuSuECWcxgIB/0W88fKoE8TQ?=
 =?us-ascii?Q?e3E/WVj6Evn0tsn4nMgh8csyHGOrLkCwE/Ralvd7b7Q6PAzR+NCcASoQRVbY?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eadc6d3-a127-4d76-8975-08ddebd046f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:29:53.4448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYkZXVnOg04ML6zN3uy75Dlj+DtxQ4ytfwm3tAj425Kv6zDobT44fKLvMc8inX6f5Tmoiw44PwWF/sht15AGWNFy1i7ZnencvSHMA1WnOaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
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

On Tue, Sep 02, 2025 at 10:48:56AM +0000, Ciara Loftus wrote:
> The set of supported Rx offloads in the vector path had been defined as
> those supported by the scalar path. This was incorrect so define a new
> list of supported offloads for the vector path. The list is the same
> as the scalar path except it excludes vlan extend and qinq strip.
> 
> Also, remove a redundant check for the VLAN Extend offload in the
> driver code. This check is now performed in the common rx path
> selection code.
> 
> Fixes: 052ae311091c ("net/i40e: use the common Rx path selection infrastructure")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Will squash this fix into the referenced commit on the next-net-intel tree,
since it hasn't been pulled (and therefore the commit id will be invalid
once it is pulled to main).

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

