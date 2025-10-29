Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8BBCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 15:46:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA0614042F;
	Wed, 29 Oct 2025 16:46:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 476B240150;
 Wed, 29 Oct 2025 16:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761752763; x=1793288763;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=yzNyga5dGnjDbcSuaLWyjEkiY39e5zpIFoYVtSDwWQw=;
 b=cLR4HbqntdKELOwVzKeAOlh40Nly8qO2RrC6fG80Ux3eV1wMe+RPyaDG
 Noz1e6haZ3rKBXnkO+NGDT8yPu0l2IR/G8slbCz2vrqQfVnroOIG+jIUJ
 R+Vt/YKx2axwb95qLSgY4YQefJDQD7O1hD4odnnunHq2RRh+qEpJjmSDO
 7bTNZdoNtx45PJSH6AMHycKDlxdIRyV6E+9MrRYVhiuGoT8JGpE+9BQYm
 k4uQ8zBQnrMsDlhYUewupFTIPfQ8v9CDIXz4FLtY6qC4YKwW5FOPxHAyq
 sszNa7nMinQxPWalMm6ed1tkDgFYanKod/XqX6COQXhgCqxNIV5RyxjDc A==;
X-CSE-ConnectionGUID: oUqVSRf1Ql+1uERDVgadnw==
X-CSE-MsgGUID: UlETxVusTPG3YEBcGfkV+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63787346"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="63787346"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 08:46:02 -0700
X-CSE-ConnectionGUID: rQLwmV9tSG6XUM8lpig6Yg==
X-CSE-MsgGUID: +WdlFPcfRHKUMJEfk4yfoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="190057074"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 08:46:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:46:01 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 08:46:01 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 08:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjPaN2mJqIJUQyFVvhlDV7tU8ig2yfNMp5ESbVNnLA3lKPwPk6l51zEjyoMpN7WzcBp0vovLPXWDb8u5iVkE8LVQVClAU16n/t5T9aO5E2nemB9vP/bPax/5E9kp4DZ9EdbXdFPl5TG1zN0EvS95wRajn6dCpJn4ZtTBAd1jvQ9YJ3ipvmF0qvugQ4yH5uprlLQWFq0nJ4ACCZVlhH/3cA8NzU5lkRuasF4CXC7ChVpoe57t/p8RM5HB4/KzdMMuSCys/eS+VN6rLe5FdmNKM4Bh7XxWjq8uRyykwhDj3d2NZSzV5fYnv9+WrXcqtuUbRq81VkzLPYk0q5+CCaGqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2wmZIeYgsedIynIfVL2rLZPBXVRhGGGDy3HDYADjFo=;
 b=NEh7r9Gjs3PU7MJjLGkQwKuXgsOJYRJ9ElRAHf01BM56pZPlI9mMntq//JJ3uv8nvDOqYNFA+W0mDAEh8PUw2MHiw1Hs2fmEBSxixon+7DyCKWPxo5z91K70E+uXVbcFzhkgkv3ug7wv3f3vPgkKxGUAlAHAxDuTsX/5AD0modyriLuVIMs8WzqsDXFzyBtly/MNNxpLtpuJFlYFefRhERYSkoGoXSCyX9GzxJPrbjSQ8iBdw2drP1IXsEq3sCk8UqGSTIUBxRPVLAg2hTDbdeUYLLp09ExRJ/8MhreRc+bmgUnqOHftIF71qsxZoceVofcIytyVP6sl5uUsV0q9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA1PR11MB8151.namprd11.prod.outlook.com (2603:10b6:208:44d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:45:53 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:45:53 +0000
Date: Wed, 29 Oct 2025 15:45:43 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, "Harman
 Kalra" <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, "Sachin
 Saxena" <sachin.saxena@oss.nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>,
 "Amit Bernstein" <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 "Gaetan Rivet" <grive@u256.net>, yangxingui <yangxingui@h-partners.com>,
 Fengchengwen <fengchengwen@huawei.com>, Praveen Shetty
 <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Rosen Xu <rosen.xu@altera.com>, Andrew
 Boyer <andrew.boyer@amd.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing Zhao"
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Wenbo Cao
 <caowenbo@mucse.com>, Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj
 <mczekaj@marvell.com>, <dev@dpdk.org>, <techboard@dpdk.org>, Ivan Malov
 <ivan.malov@arknetworks.am>
Subject: Re: Fixing MBUF_FAST_FREE TX offload requirements?
Message-ID: <aQI2p-ODpm8oxTMy@bricha3-mobl1.ger.corp.intel.com>
References: <98CBD80474FA8B44BF855DF32C47DC35F65442@smartserver.smartshare.dk>
 <aQHdDf7DnAIyIzR4@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65513@smartserver.smartshare.dk>
 <5090512.QZNE9M9tJY@thomas>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5090512.QZNE9M9tJY@thomas>
X-ClientProxiedBy: DB3PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:8:1::22)
 To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA1PR11MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c15054-c5f4-49b8-3de0-08de17023df5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?c/jV/z45XmMOSJmb2JpXX3U8giZGYmHf+8vKAGXbePWiESIccvCXopnFPG?=
 =?iso-8859-1?Q?VA2Gft1eQ47akopXLXcxWnuoEf6+Ag/veRKjZWpneVwkJO6nMHohEG9vdO?=
 =?iso-8859-1?Q?31B6aDm3D3BanhFRf1PfBK7z9xSkg/+CuhTe5Ho0EdvXt5XknRD7TN79e9?=
 =?iso-8859-1?Q?Ce51WelhwPnfF5dYhWHgeYNMZA9yKSbJwLhQEAzUohnFgNAMgd3zex957E?=
 =?iso-8859-1?Q?ENBnivyUOrF/DvYuMP8yi2+ptGc4xX++4nkLdfTrBYGPMSJTfZtod4WtYL?=
 =?iso-8859-1?Q?2ZyyPHw72XwtfTpQS1ZWLnd9BnnWSh2deoXjwGwK/yZ+SNBc1JjgZOngvh?=
 =?iso-8859-1?Q?Lk2CNOiVmZMmfUueCl3aTIM0F067kVI/8nBf5TPOTgr7A+JWUsdGzBUw2I?=
 =?iso-8859-1?Q?L/BPZUpN6zMHI4u5u4L1oFIjrbaYFa4vdlHraVUtL4jnS9gEQe+DYHUlxC?=
 =?iso-8859-1?Q?1V3QLX56Ffvr6RITu4qVjF3SDvwyhil5uh13tUDu3hb00UJjtExv/PZvBf?=
 =?iso-8859-1?Q?iwwXVxGJBqevbZZscMpv5lWZRT+ehYUQRkxZFNK8K79VEfpG4pl9n6j7La?=
 =?iso-8859-1?Q?nZ2nM3w9RapZNabVhMrWJjSUdlh0lZdW5Bn1e1xdSS4D0ouNGOpYBaKJ0r?=
 =?iso-8859-1?Q?HsU1QXN2ANzxBEh+c5fjkla2RAkhSN0whgQZ9vZa1BUqusGo233DqGgRlv?=
 =?iso-8859-1?Q?xxTuuhWYu66cCDyUVT5UssPp3LG1rq7ZSsJqy+qvIWrwDtlqdRwBxrBoSD?=
 =?iso-8859-1?Q?Qe3wsTLFOXKj2iHsSHf4Hz/w0gq2yYpKMuixFsU9Dd/pNKA/XsZvuCrVI2?=
 =?iso-8859-1?Q?trgdyhk6mrRgonuHr71qU+So3FT25iKj7ODU3pdEWMH37YvDtPibxYN1jh?=
 =?iso-8859-1?Q?Ns39wDBJSWtShsWttTSwTaZ32uD59mN6mqHJG+ytWt+5BASSCA7TBLx4dr?=
 =?iso-8859-1?Q?tBjcWp8lzxZ4tnTfLZNMdCDLKxeXI4Z+wgVpcIeAbbe7FxsoPF8WtGU5fU?=
 =?iso-8859-1?Q?OEf7TG0ImUDXU3b0hrwt9eLEbA4x8OzqY6h1yE3nlf3afTrJNRGyPoC9D5?=
 =?iso-8859-1?Q?FA3N7P01u6nob/S+B/wj6KQKdpcCeHEgpzqlJmqkXuWOd68SmjElb/E7eh?=
 =?iso-8859-1?Q?fIhR23GiDaDaN2KMzRLt6EaSrOCSSfyqF8I1lD4p+7hKL+OrXDTbwaN1YI?=
 =?iso-8859-1?Q?L90LPafsGrrGWl1CdCAOFlBMRqLEj8IqQoZ35FBBVrQ2n2+sNMJ8beyaRG?=
 =?iso-8859-1?Q?0mRWNu3XoPnrXTouHm6G2mRSYVLuORjMYvynCLUwwpcqN3G1+YnnrKadnj?=
 =?iso-8859-1?Q?1dw1848uJDOgJamVSkpCKX76b/k3Imhdef+2lXHjR3Le+LZms25wLQzupK?=
 =?iso-8859-1?Q?4uoYC61JOAOzxbhvqjN4jnJiXxpigsgcVTTyK3cWkykayiab+syEpx+K+g?=
 =?iso-8859-1?Q?MGQvbanLJOwhDgGjjinKqATkK4yf2YTXirN0vs2aEkH+wCGqJJmyy7DIwb?=
 =?iso-8859-1?Q?XnytUT+ygXYyPBLrqM7O4/2pwK0oOc3csLkOMYS6YdMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wLsC6uhCl2Wah/lEYr9s82/qt5PVlmA/g6bfSEBFW8c82peSR6yG8eiX/4?=
 =?iso-8859-1?Q?H3gKDu8ntLdJfsCOzo3xR2Etwrd0RaPW7fDI2DPN13vuAKGpUw3ZNmqeF8?=
 =?iso-8859-1?Q?buX/S0CRuyCgY8B58I6LHBajbmLnA6vZbb6ePlQoasHzLN4bj+OmDc6DWT?=
 =?iso-8859-1?Q?tW+aLsojsOitVzQEs9c4R//QN3SWN0JRUSnqLI5GWMfTBwYMGs2RSMBGTs?=
 =?iso-8859-1?Q?wO64Pf6FvDAP2/1FLuYNZYgS8yUYVqMn5OQ2UoWsA4M3Aw+Jj4F1GYaebx?=
 =?iso-8859-1?Q?AJpC1Y/J1SSa65lSuBQE4NeWg7O0fIoqjb2LIW3BUlVbR6RzciDku7jb28?=
 =?iso-8859-1?Q?0sORaRMbZCNd54Hs9zdw9qSwYHw+hnoWkfKlSW3laneDiy7hdT/VqV6Y1E?=
 =?iso-8859-1?Q?Tz2j+GqlECmuSldwouZuefjqicuaHEMmEX1JmXS/8mSYejY8Nnj4BOBB8M?=
 =?iso-8859-1?Q?qBDZokb6RxSD7LBZtrx41AG9OvFHR1YnQa8rbhHd7f+1YSpc02soDo5Roe?=
 =?iso-8859-1?Q?vIW1csJxQWJMgFsTZZuGJ3hOviykKjWJ29u8xClCegVj7Do9cHoiKJBepy?=
 =?iso-8859-1?Q?yXg+2viwWnRmDfKGSr63gqwHr8n9oT2BiwqgSgKV9SnmZ8v81PBwm65Eo/?=
 =?iso-8859-1?Q?CP1k52/szCM4f+s4bOm5uS0Bw+OY+u6QF3U1alg9JHaEM876EKaqy9XZcp?=
 =?iso-8859-1?Q?IqD2EYp8JLS+VkyA8zpcvm5rlsLvzYleuV8FTrGmDdrcaAqFPot1yzmuzq?=
 =?iso-8859-1?Q?qXG5/YNsBtV3ebsL7ZRbxgXy1N19PPDK8vhZzI7i1dC48+unUnpD2AbFTe?=
 =?iso-8859-1?Q?UJyxoZ/fj6ZvOixipnnKMqplIUf44yKeKt6Z43ybmDJkQBvKCSmyZzCqC7?=
 =?iso-8859-1?Q?Zn8DanKYVSD9Wrl+PvYU/IgOWtyk/tEgo8MFWqAEiZYup5EEHImV4Hl1/s?=
 =?iso-8859-1?Q?3xbizLZKxJNksvvnYWHjlLLmcbuq3AUZA0AP/T8674J+GLqD/IQR6ay+P6?=
 =?iso-8859-1?Q?Fg2g0LpLIC0wcvBj2IXEJmg/edNQDTZrCMI4UlGjw+sZyMbJkSmX/dfXv4?=
 =?iso-8859-1?Q?1LgAgFQPO2jqb5azgh7NqtFe7ixZ2mAldi7VQd3M0K+pA+6yTG/PTW6W2e?=
 =?iso-8859-1?Q?StlYD6Ql8tmesXhAl8sMI6Zc/gquxMhacBHoIA9HTiDn9WdT8BDMzmdUYr?=
 =?iso-8859-1?Q?zNVs0Lp0ePpYtURzQvn0yAB/Nlnii/NMz6KmfJB17cCAxPZO2o17rTL+7d?=
 =?iso-8859-1?Q?8zTW4uBu7gqtdxjzMwdrTnCdYYuW6Cp5pyRV4IsQbup09h3IY7qE20Scx6?=
 =?iso-8859-1?Q?GM204XZgarjKPSgCXbOtIn08VZZIARRHd9E26hsUJESYG273ozMRImoXT4?=
 =?iso-8859-1?Q?z90qWLflL5BorlSB4B3Y5XruvUAwoyc8j7JNMU3WA2bTgYr7UErjNwUyJD?=
 =?iso-8859-1?Q?kYCOKINJ3dw96COz1PQ4sfLqxKa6bPlmCLcgiruzV3hTIM3GG7Pn2AobI4?=
 =?iso-8859-1?Q?PdDQmIfoFW6fxVu8hMY84LWNOVzgjv2Crj9mUMK2PR/HhuXfBKIn7frui2?=
 =?iso-8859-1?Q?izB16r8lSp+t24NZ3vzEU/tlNV+VXEjHss5BxNSufzJD8kaBpSo7AbrSA0?=
 =?iso-8859-1?Q?a+gqihD5zb9a5r2jbU/e7BtByWzwYeZbz4iyli/R2HRMbPCAtobMZ9XA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c15054-c5f4-49b8-3de0-08de17023df5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:45:53.3245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTVjVhGNC1fj4KrdNmEdbAchfUtNPcstjk16EiiOfSSsgdeXv/CRCn2aKwlI5sBlkGeS78huZypksveMOSg3LJX8URCnDNWJtDQOwy85coA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8151
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

On Wed, Oct 29, 2025 at 03:57:40PM +0100, Thomas Monjalon wrote:
> 29/10/2025 13:23, Morten Brørup:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > On Wed, Oct 29, 2025 at 12:16:37PM +0300, Andrew Rybchenko wrote:
> > > > On 9/18/25 5:12 PM, Konstantin Ananyev wrote:
> > > > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > > > > On Thu, Sep 18, 2025 at 10:50:11AM +0200, Morten Brørup wrote:
> > > > > > > > Dear NIC driver maintainers (CC: DPDK Tech Board),
> > > > > > > >
> > > > > > > > The DPDK Tech Board has discussed that patch [1] (included in
> > > DPDK
> > > > > > > 25.07) extended the documented requirements to the
> > > > > > > RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE offload.
> > > > > > > > These changes put additional limitations on applications' use
> > > of the
> > > > > > > MBUF_FAST_FREE TX offload, and made MBUF_FAST_FREE mutually
> > > exclusive
> > > > > > > with MULTI_SEGS (which is typically used for jumbo frame
> > > support).
> > > > > > > > The Tech Board discussed that these changes do not reflect
> > > the
> > > > > > > intention of the MBUF_FAST_FREE TX offload, and wants to fix
> > > it.
> > > > > > > > Mainly, MBUF_FAST_FREE and MULTI_SEGS should not be mutually
> > > > > > > exclusive.
> > > > > > > >
> > > > > > > > The original RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE requirements
> > > were:
> > > > > > > > When set, application must guarantee that
> > > > > > > > 1) per-queue all mbufs come from the same mempool, and
> > > > > > > > 2) mbufs have refcnt = 1.
> > > > > > > >
> > > > > > > > The patch added the following requirements to the
> > > MBUF_FAST_FREE
> > > > > > > offload, reflecting rte_pktmbuf_prefree_seg() postconditions:
> > > > > > > > 3) mbufs are direct,
> > > > > > > > 4) mbufs have next = NULL and nb_segs = 1.
> > > > > > > >
> > > > > > > > Now, the key question is:
> > > > > > > > Can we roll back to the original two requirements?
> > > > > > > > Or do the drivers also depend on the third and/or fourth
> > > > > > > requirements?
> > > > > > > >
> > > > > > > > <advertisement>
> > > > > > > > Drivers freeing mbufs directly to a mempool should use the
> > > new
> > > > > > > rte_mbuf_raw_free_bulk() instead of rte_mempool_put_bulk(), so
> > > the
> > > > > > > preconditions for freeing mbufs directly into a mempool are
> > > validated
> > > > > > > in mbuf debug mode (with RTE_LIBRTE_MBUF_DEBUG enabled).
> > > > > > > > Similarly, rte_mbuf_raw_alloc_bulk() should be used instead
> > > of
> > > > > > > rte_mempool_get_bulk().
> > > > > > > > </advertisement>
> > > > > > > >
> > > > > > > > PS: The feature documentation [2] still reflects the original
> > > > > > > requirements.
> > > > > > > >
> > > > > > > > [1]:
> > > > > > >
> > > > > >
> > > https://github.com/DPDK/dpdk/commit/55624173bacb2becaa67793b7139188487
> > > > > > 6
> > > > > > > 673c1
> > > > > > > > [2]:
> > > > > > >
> > > https://elixir.bootlin.com/dpdk/v25.07/source/doc/guides/nics/features.
> > > > > > > rst#L125
> > > > > > > >
> > > > > > > >
> > > > > > > > Venlig hilsen / Kind regards,
> > > > > > > > -Morten Brørup
> > > > > > > >
> > > > > > > I'm a little torn on this question, because I can see benefits
> > > for both
> > > > > > > approaches. Firstly, it would be nice if we made FAST_FREE as
> > > > > > > accessible
> > > > > > > for driver use as it was originally, with minimal requirements.
> > > > > > > However, on
> > > > > > > looking at the code, I believe that many drivers actually took
> > > it to
> > > > > > > mean
> > > > > > > that scattered packets couldn't occur in that case either, so
> > > the use
> > > > > > > was
> > > > > > > incorrect.
> > > > > >
> > > > > > I primarily look at Intel drivers, and that's how I read the
> > > driver code too.
> > > > > >
> > > > > > > Similarly, and secondly, if we do have the extra
> > > > > > > requirements
> > > > > > > for FAST_FREE, it does mean that any use of it can be very,
> > > very
> > > > > > > minimal
> > > > > > > and efficient, since we don't need to check anything before
> > > freeing the
> > > > > > > buffers.
> > > > > > >
> > > > > > > Given where we are now, I think keeping the more restrictive
> > > definition
> > > > > > > of
> > > > > > > FAST_FREE is the way to go - keeping it exclusive with
> > > MULTI_SEGS -
> > > > > > > because
> > > > > > > it means that we are less likely to have bugs. If we look to
> > > change it
> > > > > > > back, I think we'd have to check all drivers to ensure they are
> > > using
> > > > > > > the
> > > > > > > flag safely.
> > > > > >
> > > > > > However, those driver bugs are not new.
> > > > > > If we haven't received bug reports from users affected by them,
> > > maybe we can
> > > > > > disregard them (in this discussion about pros and cons).
> > > > > > I prefer we register them as driver bugs, instead of changing the
> > > API to
> > > > > > accommodate bugs in the drivers.
> > > > > >
> > > > > >  From an application perspective, here's an idea for
> > > consideration:
> > > > > > Assuming that indirect mbufs are uncommon, we keep requirement
> > > #3.
> > > > > > To allow MULTI_SEGS (jumbo frames) with FAST_FREE, we get rid of
> > > requirement
> > > > > > #4.
> > > > >
> > > > > Do we really need to enable FAST_FREE for jumbo-frames?
> > > > > Jumbo-frames usually means much smaller PPS number and actual RX/TX
> > > overhead
> > > > > becomes really tiny.
> > > >
> > > > +1
> > > > > > Since the driver knows that refcnt == 1, the driver can set next
> > > = NULL and
> > > > > > nb_segs = 1 at any time, either when writing the TX descriptor
> > > (when it reads the
> > > > > > mbuf anyway), or when freeing the mbuf.
> > > > > > Regarding performance, this means that the driver's TX code path
> > > has to write to
> > > > > > the mbufs (i.e. adding the performance cost of memory store
> > > operations) when
> > > > > > segmented - but that is a universal requirement when freeing
> > > segmented mbufs
> > > > > > to the mempool.
> > > > >
> > > > > It might work, but I think it will become way too complicated.
> > > > > Again I don't know who is going to inspect/fix all the drivers.
> > > > > Just not allowing FAST_FREE for mulsti-seg seems like a much more
> > > simpler and safer approach.
> > > > > > For even more optimized driver performance, as Bruce mentions...
> > > > > > If a port is configured for FAST_FREE and not MULTI_SEGS, the
> > > driver can use a
> > > > > > super lean transmit function.
> > > > > > Since the driver's transmit function pointer is per port (not per
> > > queue), this would
> > > > > > require the driver to provide the MULTI_SEGS capability only per
> > > port, and not
> > > > > > per queue. (Or we would have to add a NOT_MULTI_SEGS offload
> > > flag, to ensure
> > > > > > that no queue is configured for MULTI_SEGS.)
> > > >
> > > >
> > > > FAST_FREE is not a real Tx offload, since there is no promise from
> > > > driver to do something (like other Tx offloads, e.g. checksumming or
> > > > TSO). Is it a promise to ignore refcount or take a look at memory
> > > pool
> > > > of some packets only? I guess no. If so, basically any driver may
> > > > advertise it and simply ignore if the offload is requested, but
> > > > driver can do nothing with these limitations on input data.
> > > >
> > > > It is a performance hint in fact and promise from application to
> > > > follow specified limitations on Tx mbufs.
> > > >
> > > > So, if application specifies both FAST_FREE and MULTI_SEG, but driver
> > > > code can't FAST_FREE with MULTI_SEG, it should just ignore FAST_FREE.
> > > > That's it. The performance hint is simply useless in this case.
> > > > There is no point to make FAST_FREE and MULTI_SEG mutual exclusive.
> > > > If some drivers can really support both - great. If no, just ignore
> > > > FAST_FREE and support MULTI_SEG.
> > > >
> > > > "mbufs are direct" must be FAST_FREE requirement. Since otherwise
> > > > freeing is not simple. I guess is was simply lost in the original
> > > > definition of FAST_FREE.
> > 
> > Agree about the "mbufs are direct" statement being lost in the original definition.
> > It can be extended to include mbufs using "pinned external buffer with refcnt==1", because freeing those is just as simple as freeing "direct" mbufs.
> > 
> > > >
> > > That's a good point and expanation of things. Perhaps we are better to
> > > deprecate FAST_FREE and replace it with a couple of explicit hints that
> > > better explain what they are?
> > > 
> > > - RTE_ETH_TX_HINT_DIRECT_MBUFS
> > 
> > In the FAST_FREE case, this hint would be TX_HINT_MBUF_DIRECT_OR_SINGLE_OWNER_PINNED_EXTBUF.
> > 
> > > - RTE_ETH_TX_HINT_SINGLE_MEMPOOL
> > 
> > Prefer TX_HINT_SINGLE_MEMPOOL -> TX_HINT_SAME_MEMPOOL, so we can add a globally scoped TX_HINT_SINGLE_MEMPOOL later.
> > 
> > Also, RTE_ETH_TX_HINT_NON_SEGMENTED can be added later.
> > 
> > I strongly agree with the finer granularity for the hints; the optimization of freeing to one mempool instead of a variety of mempools is orthogonal to the optimization of not having to consider indirect mbufs.
> > And the drivers are free to only optimize if multiple hints are present; so there is no downside to using a finer granularity for hints.
> 
> Yes we can have finer granularity.
> 
> 
> > Although we are reusing "offload" fields for hints, there's no need for drivers to announce capability for such hints, including FAST_FREE; since the drivers can freely ignore any hints, hint capability doesn't contain any information about the driver's ability to do anything useful with the hints.
> 
> Capability does not need to be announced,
> but it would be useful to have debug logs when an optimization is enabled.
> I'm not sure how we can enforce such logs in drivers.
> 
> 
> > Regarding naming, we should use "promise" instead of "hint",
> > to emphasize that the "hint" is not allowed to be violated.
> 
> I'm not sure why but I'm not confortable with the word "promise".
> To me, a "hint" is already something strong.
> 

Agree. Also, promise is too long a word. Hint is shorter.
