Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB72C5ACD1
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 16:12:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92EBC4026D;
	Fri, 20 Feb 2026 17:12:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B68774027B;
 Fri, 20 Feb 2026 17:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771603926; x=1803139926;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=hjRnnh8mM+GO7AyGe5SE3a6vi5vauwPNrOxShm0vsTM=;
 b=hinptfdU9a6qjYGxBZsFSLNBdj8GITsB9rRT/dJZiyQW/tNTVZil7s5O
 7rXzfhsWhN2+i0BOZ5DaAn8FXfwI+3n3Y4kxx9gVgnnGRDn7ZusB6lqa4
 4F/M5uPNZxnT3gCOkrWiCKYZikg/u3D+L2GtVq2AoRm2imNwVW0DCQ08B
 XoUPSpK0eOS7ymnGftXIXkMhWv7pKzbQNGTTa1zYg0aS82DI/av6a5tMX
 iMaZSHDdmMXF0VQrlEHEEgpf4dGRVLcUXa8lhZeaL1MINvndPlw1cfA1j
 FG4pzZmPiT2JUejUvzi8clkpbylRwDwFP7TAVkKLd3vCJY4QGYQEIIYcY A==;
X-CSE-ConnectionGUID: a++OaV12RL+yIabh/t6BjQ==
X-CSE-MsgGUID: eJss+IM8QpW2on/wYpq4Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83412841"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; d="scan'208";a="83412841"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 08:12:05 -0800
X-CSE-ConnectionGUID: Nrngs5vqQz6vnTF0WG9OwQ==
X-CSE-MsgGUID: VEQVgvICRZe25ZzYEZSFOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; d="scan'208";a="219886071"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 08:12:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 08:12:04 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 08:12:04 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 08:12:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzYCE1qIqIdHCs3KmYr/vDhhzSUM1W8vskqZiMUBWA7eZSJhlwG4aCp/mOXOTq0k3XODStDD1bUUV9dZluppG4iVuhorbutaO5LGFBcdUfgwmGmQTIL89AAIoz0m2YXpd2XC/DbNWiAPba+UQK+wlnGGPVEQCZKPj+xihh+XUHgmNBOju8uTAdsCHcJJatVTnvruJchuSRA57P0aqL7H6cTf/v/y1aK9cRgPTsR8B3z0fDBH5YM4Dgy598qtyloegk/RFttpTLObkxIhXOxagE7JuDLA628OJHey511IF5IC+C2DcmwebIXDRyk77gKd9ARQi8BF1cvDZTH1u+3KXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hhevm56p8owj7AL9NuInOvWibn7ptHXXKDf7mWLA8y4=;
 b=S67LAiQDKN9tMHl/uYokNJVpzSQ1RRM0R1sBRN/9mLEJX44EZjO97T+ixESCP/PeLawa5mEw74/k0aVNiZqc9cpog54+zcEsD5X429ppPgu2W6fPPP6j7ZRiD5+rjzhQ6R/l8oFnAHgrJGrlI76/NC0DvGZMKJyheVOapXyKpbnTPreAcsNmVRnPvjyhWmmHuXYL3vKtxcuTshngi6eK32LmuTw+EpZg+ORWUsMTFolquwX+A3GflEDUC0+Bji39NyAyX9rISVhpD4gx17Dwxj6+27anXKlv9ygcUXYtMP+F+vSxd6kLphfr4Xu2tmo38Nvc43OhfTCb6rudZiZRSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4790.namprd11.prod.outlook.com (2603:10b6:510:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 16:12:01 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 16:12:01 +0000
Date: Fri, 20 Feb 2026 16:11:56 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>,
 <oleksandrn@interfacemasters.com>, <stable@dpdk.org>
Subject: Re: [PATCH] hash: fix overflow of 32-bit offsets
Message-ID: <aZiHzHsEyMH1gLxi@bricha3-mobl1.ger.corp.intel.com>
References: <20260220143933.2553112-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65735@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65735@smartserver.smartshare.dk>
X-ClientProxiedBy: DB9PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4790:EE_
X-MS-Office365-Filtering-Correlation-Id: d26c1f8d-1e16-4374-f9e2-08de709ac795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wDDlg5SHx9GEoJI2tgU7uYl/cBCihLL0yVILaCQMQzK6Za7PG3Q0D/dW4N?=
 =?iso-8859-1?Q?MOHxDsmMIu9qf0yfUjB143quh1xjkCMIrIpCYDRItOxbNybXszXFMtuI8l?=
 =?iso-8859-1?Q?vqmprHqopkhOqUOx63EaH2pv1PjBRDbvM78UUwYpN6EmgMCQe9A5mrBWoV?=
 =?iso-8859-1?Q?+9DaWjuBddDU+PClvA26TnHR2wt9ZHF60tljrNrG/yeCkWhKVSFVBOmUqb?=
 =?iso-8859-1?Q?sqPjhVsMADdQFk29FrBBTgbXGin5voYJgUAymN22e8oaoaPb0zgUf7H54d?=
 =?iso-8859-1?Q?TxGR3VIWjlBfNN4KAulV1ofxAj3yGsC73PnTXn2ubVFkHyt/RyPeM4hn88?=
 =?iso-8859-1?Q?+u29aeV0CB2AjKfwcbvwPrD/73uLBQv4Xfz1hUhNsxIlyHrhsgIocqysxZ?=
 =?iso-8859-1?Q?+yIQSFNOuyuSGUkaq9JvKBmC8GewJegmNvf9fjX9D4dBil3I0s3/bIMl9R?=
 =?iso-8859-1?Q?iuyUjq+sWzkX9WK920MrfD86YVwTYbS20LX09HmlxLXQ89xCwBdQV/XiZJ?=
 =?iso-8859-1?Q?OJ02SjsJE4XqQSID5K92cCUfljY6LXIETvi5J5Sd+DvuiGhvEFv9KB95fn?=
 =?iso-8859-1?Q?cH6SkqHJS73isciIcj9jystymRkUiCQ1kZ/G1j6TGL5grdjFptpnD4ALui?=
 =?iso-8859-1?Q?om7dlClk0ac89elGSgZQaMfxV21DFmucfLTS+F9HCOB2foqzJPrk23k+ni?=
 =?iso-8859-1?Q?uRQEtiEwOS6dxg2hQOvFdpO0pIZ4EckpSmRVuwBFocHfn/pX5r43jClQlB?=
 =?iso-8859-1?Q?HG3J/nE/xAX9kdXSyt7VTEs8o1knHEQW3xYFnjrSZF2mdTAOVy5sYQ1/7D?=
 =?iso-8859-1?Q?xy/Amhpe4ZNFsux7rS4PIKv/QBPVRHR739vijy7Tizt5FPIjWMhyu6hN3B?=
 =?iso-8859-1?Q?54gihu0mJCw4fpuQLTonSy+ohZtP5lCGjMi9WuKIZBlAALRV47EpnkdG+L?=
 =?iso-8859-1?Q?hjKtNB6L4HDmuxtbviXl22CerBwHjAqO+qEidbYZK8t+XD7wdWAIJjvACV?=
 =?iso-8859-1?Q?9oN1UXPXNc6pq2BsH7idRRtWbGbs5YGKUMjAz+BMWusIaRz4cksFrS+vnu?=
 =?iso-8859-1?Q?lYBh5603XHwxADYEFTcjyygPl+ydXKypp4aaAhyxrpEsPXqvbzsLf+Jzlb?=
 =?iso-8859-1?Q?iwcYnM8X+CH+qCTgr7HEaeNhI5/FFvtcgXr6MNG9TOGJFkoVZUO85dLjtM?=
 =?iso-8859-1?Q?aPTkw9+iqdpqgoKQ9lx3mIR5BRbo/AZIj48oLpugSzLcg9GERtjBnGaudX?=
 =?iso-8859-1?Q?HSx5tgIC0AzI+rdBRZiwjKTjP4ee4CZOF7koO/yt3LDtgmDqLGAgpmu6ms?=
 =?iso-8859-1?Q?lbCX4QtSzc7I8HBwONEIpbdmh5X5VTytPBSXChUG7mwsx8Xp2oQDfOsc5X?=
 =?iso-8859-1?Q?6mJ1wTBSiZ8snhQAo9eUkasSDAOG1Kq9tvvO7im0OhKqQTV/br6J6NuvEV?=
 =?iso-8859-1?Q?tqBDOd1+4J/n5H3XWq0OEFmkU8zmVo0o/7G+1H5XguuS1qYVrVHCeB9F6F?=
 =?iso-8859-1?Q?skhzQrbbU3w16UjOjtpGF/WX0LZJCrggHZlKtyDTWZyMFK6W16ckAlKBHh?=
 =?iso-8859-1?Q?Tp7RRw6K3B60uuU+TRdfRvTfSJO9SCYcK17z31brrprQE9MRNQ6PnTWKr4?=
 =?iso-8859-1?Q?k5k5JVE96o9HQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Cb2oy3bDHl3mZOdgxxcjIqPc/oLbKDkNLip/Q3ThDBbWQPCWRfL5xfZoDd?=
 =?iso-8859-1?Q?H+FpBrmDu16sjaQIbyXU15ipQ0RgGW50g+dyQCnIlAjKFW9z1qz17mG74e?=
 =?iso-8859-1?Q?XYyuR1CoJoUdznk3P8yJpTP/CXK5h7N54TYycCF+7ms9z2il5sJ0UD1rh/?=
 =?iso-8859-1?Q?6ouErsyDLZduwfUOw1r66xB/CP8CW8cVBlr/8HFafyac8TI7HVadBrmggX?=
 =?iso-8859-1?Q?iOU0CvO3eU2gEeUoKzTuCTywmfwCyvzR9LfYGhzDJ5dciBg/j10zpzkact?=
 =?iso-8859-1?Q?QFd2v0LOZcQ91uqA9GRJxxRhwZezLooQzuOW8JP9SX+6F84YNy2j9PU3/w?=
 =?iso-8859-1?Q?IRFWSTIfgKuOHo8Me5CBbO76opU8LDUtYmgzLCUzqoQIdMAWWDzLH4LLzQ?=
 =?iso-8859-1?Q?RWqRe9PTqm+g9NkFfaEH3Huq0ZJ5R1L/suFbalePuv7u2l/EwnNDiVkN+j?=
 =?iso-8859-1?Q?U+goasi/OwnL+/qrzSq7ikcEI072hS3VJSnXhCyTKfFSYiujQiFq0D6nIx?=
 =?iso-8859-1?Q?u3tfviR198kcXZmE4XBIZtBTxgF6f6Pj7gF/j4eC1GKPTrrz2xBCfqnDIJ?=
 =?iso-8859-1?Q?pl2n1LE4o8ozFu9+tOttnPvRvS8yhfGyUAwBKCDpVby7BEdC1eXyTm7a18?=
 =?iso-8859-1?Q?4pKYxl2i35F8QcgySnbIVBogUzrrBcFbO1zxfyjPZvJUpKwQKmGFvUg+Ei?=
 =?iso-8859-1?Q?7kVEGNNikeWGWYRvV9Ne/h2MOCkjCbsWgYuXEDCm+0yoyZdKdFAiQhgdwD?=
 =?iso-8859-1?Q?JIXL+qpSpjSyCJaQvgRZzniliAc4HKxcAwObMXuCPHqUSdYKfD54LvUOvj?=
 =?iso-8859-1?Q?L0FlvCiF5lOsoOTdlmj5MlBTheD/GzFK9ra2tn1C/Y4UyvzPPeXs+JpgaL?=
 =?iso-8859-1?Q?VDd/eDvmfA13+JlSm2xsxJ21RYjjkRb/grwtwDWY+aZOvUmsd+sElMWqjU?=
 =?iso-8859-1?Q?2kxO6jV0cutkWS7LzsZ2Zj7gxcX6M3BhtWoCE0pZ+0u3YaduhGGz2YK/mA?=
 =?iso-8859-1?Q?UKLp5vJg3dhzVW57TnU0TsjRynwKd+rua93oqVH9Ytw7i87NdRYlAomYYQ?=
 =?iso-8859-1?Q?1PylE7q1ZgE7AI5DDezCGhjaQSFMd7P6sbyTwgwXkhWYfIBamiCXBPfCTQ?=
 =?iso-8859-1?Q?BELPvskpRXZl079AOLM2Wjc2acwttGl4JK3AN9kqauXva4fUrGKZVdevLQ?=
 =?iso-8859-1?Q?Ol0rlrITeQsHi5vsJHGXPAxYzV2OJqXQX1FwIiiTVYE2JCYMlBygtShSrQ?=
 =?iso-8859-1?Q?dFRwnCJ1rK5VobFO1wtagQenWIa+NfzyIPdhHT238Sd6/EKTw4eqEJhiup?=
 =?iso-8859-1?Q?NuOd6Vijr/MK9iEn1btwkdA6XVH7ZdXpryDuqdENgNbq5Ah4Xb6GYlPiG/?=
 =?iso-8859-1?Q?wA4CvvqmpghROo7o7AxO4rmRbC4MVhrCE7Fgd5DjwR7qY2VHLkJIyMSwT7?=
 =?iso-8859-1?Q?T6kq49RjvwpVLZckMV/J8yYSOanYIh9TdmVDRKjCcGcIpNwfgY5p2UEZ8G?=
 =?iso-8859-1?Q?LfCzohSMpIzVyiPMcW9NMtYD0x1jzy/r9FnBUhuohgJ8Z1+FMyUvdHeILC?=
 =?iso-8859-1?Q?/fC0BjPvudWVfDNWVPB1tYv1od0SpLDSeRW890Ti7ymddQcRTyVSGJ6km1?=
 =?iso-8859-1?Q?OPT89CBMHIpRLp8jyS+EunynsKuxy3fNXd1KqXFiYazClknE5HTwn12Xnn?=
 =?iso-8859-1?Q?NtmeiHgfXZRDdyHg2evIXIEXu4LzEWgpuunZ9WjMV6EpmRHf5G7WVGpqfb?=
 =?iso-8859-1?Q?JrOdWX5xEgQebt4HUz43JzzzvQRpnfl7km/dhNXkBfZeLg9cM9ALNarCKk?=
 =?iso-8859-1?Q?C2FfyrvXL+7CkYmyR24kry0KQfek0ZQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d26c1f8d-1e16-4374-f9e2-08de709ac795
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 16:12:01.1197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4w2tRkuDUoE6EnUrJ4FVrDTZmhyYhERbOGP6sMOjoTt8Q0uGyI2TtXnkdV2pp4qFxXPre72RxskbuimDklpxwnoE/4IDficanBIh0OsIKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4790
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

On Fri, Feb 20, 2026 at 04:09:14PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 20 February 2026 15.40
> > 
> > When computing the offset inside the overall hash structure by adding
> > an
> > offset to a base pointer, the offset was generally calculated by
> > multiplying two 32-bit values, which could then overflow. Prevent
> > overflow by using (uintptr_t) casts on the elements being multiplied to
> > ensure they are 64-bit on 64-bit systems.
> > 
> > Fixes: b26473ff8f4a ("hash: add reset function")
> > Fixes: 406da3dfb3b5 ("hash: move duplicated code into functions")
> > Fixes: 9eca8bd7a61c ("hash: separate lock-free and r/w lock lookup")
> > Fixes: 4d9ca3ed2133 ("hash: use ordered loads only if signature
> > matches")
> > Fixes: 769b2de7fb52 ("hash: implement RCU resources reclamation")
> > Fixes: e605a1d36ca7 ("hash: add lock-free r/w concurrency")
> > Fixes: 6dc34e0afe7a ("hash: retrieve a key given its position")
> > Fixes: f9edbc9bb6bc ("hash: add iterate function")
> > Fixes: 75706568a7eb ("hash: add extendable bucket feature")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  lib/hash/rte_cuckoo_hash.c | 36 ++++++++++++++++++------------------
> >  1 file changed, 18 insertions(+), 18 deletions(-)
> > 
> > diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
> > index da12825c6e..f2478d5286 100644
> > --- a/lib/hash/rte_cuckoo_hash.c
> > +++ b/lib/hash/rte_cuckoo_hash.c
> > @@ -705,7 +705,7 @@ rte_hash_reset(struct rte_hash *h)
> >  	}
> > 
> >  	memset(h->buckets, 0, h->num_buckets * sizeof(struct
> > rte_hash_bucket));
> > -	memset(h->key_store, 0, h->key_entry_size * (h->entries + 1));
> > +	memset(h->key_store, 0, (size_t)h->key_entry_size * (h->entries +
> > 1));
> 
> Agree.
> 
> >  	*h->tbl_chng_cnt = 0;
> > 
> >  	/* reset the free ring */
> > @@ -774,7 +774,7 @@ search_and_update(const struct rte_hash *h, void
> > *data, const void *key,
> >  	for (i = 0; i < RTE_HASH_BUCKET_ENTRIES; i++) {
> >  		if (bkt->sig_current[i] == sig) {
> >  			k = (struct rte_hash_key *) ((char *)keys +
> > -					bkt->key_idx[i] * h->key_entry_size);
> > +					(uintptr_t)bkt->key_idx[i] * h-
> > >key_entry_size);
> 
> The fix is technically correct.
> However, for source code readability purposes:
> 
> Please don't cast bkt->key_idx[i] (and similar below) to uintptr_t; it's not a pointer type.
> It might be reasonable casting it to ptrdiff_t, but I'm not sure about that.
> 
> The natural type for h->key_entry_size is size_t; it's only smaller to save memory or something.
> So, please cast the type that naturally would be wider, i.e. use: (size_t)h->key_entry_size
> 
> PS: If you change the casting as suggested, remember to update the patch description accordingly.
> 
> With or without above suggestion for readability,
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
>
Ok to use size_t instead. Let me respin.

/Bruce 
