Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CE5C79FA1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 10:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A1AF4069D;
	Tue,  8 Sep 2026 12:18:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0270B40374
 for <dev@dpdk.org>; Tue,  8 Sep 2026 12:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788862724; x=1820398724;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Xdsojk1cs8Yjgkbs9IDXeU8+ObE41sEQY3zQJQmemW8=;
 b=FYOUdnRvCSiUVjJKZrEYTp/1qvKTeZ+G0KmkcaJrjQ8dTTyMOFu8SNNs
 5FTxAuJCH3vCJMidaS9PscndE6BdzcsvlCDamyInGd5n9qN6ItlJYK6ew
 +baJDs2v68fy0MhQl30oypyrwiIY4vjyJ/00wf4zhxCn5wKMpNV5unmGS
 yt/KCoEV25Ss+j6lnXQ2GYpBATZ9ACslx7x1+efIWV/zgvHYZyjIyZOhR
 lp9jLDOLNsLMUwzqwIMJyT8pp9qp881bNUlS1xAs9oOgQQ9O/oJFAEb3+
 GzoFAxjipJbcWoHcsg/1i3bSsXIx/Ft8wOhX/G23tlGa2nsB1bU4r/s90 w==;
X-CSE-ConnectionGUID: Zb6A+yAsTFKQHjVXXCL5aQ==
X-CSE-MsgGUID: 4KPqJ6lhRfupXWKehRd6FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="112038385"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="112038385"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 03:18:42 -0700
X-CSE-ConnectionGUID: S3SrOSyJTdWLwU3+aU1m5w==
X-CSE-MsgGUID: rIbs5/eETVuhGqhN/jD9tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="295851686"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 03:18:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 03:18:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 03:18:38 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 03:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVrCWX0y0YhB/7xIvJtzDLp8WGHi9Emdz5dreVo7lfWKbhJvdLde4BAmNIeIewnQFXBMvguo6EVJ932QLR0OezNtQp+pcfLiuiP6AmNYDZufrKoT09gBMegX+cXP8e9fKSrmkC6gJNHI1uNmeveXctuFl9gesWPCkiu64Kx8nWdXEMNF/uHnGvTu99coSOQrTuuYEZqH0bZNjit0HO2fSs9nbn9OVJ2iv4gojSQhOhimtHghY8i4aE1xs4lbalZEt0alJ9dy9n1Z56uz6cFnLijTqLQh+U76DHl7y7M6WIkX1aWY+FZTXamRvr/Yju5GzwqxMDYuZXeMX8pHM3UE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO2OSU1ODs9nv1T85zpLt+do6oLsiu/nqS472Tw8CEk=;
 b=sDw9UieC6AyQ5DHcsft8a3GZ7nDAWKwo8Eb8wmW7C8yFw5P1wLWcHe5/2gIb71EA6xER4YIomTejuF2UPWRIJrZKmFfLmXLLCyASiHRYriUvsecI9S8SQR64eHzAJU2fUG7wyDKd1u0UAa4imJgt409fJ2/izk7dQV4F6BQn292k25aN+T/Tt8I+P/21H5hGs/92SE7hRdahWF1qozxVWV62ZAFvt4GIYJU+O+gn7G8IjHpg4lWdg+tTvPD1SjaFTQbC/bQhxV25SMwcJ35LtcQqh8Xsm17cwFBnD5Lkr2Fzdw+mWDyn9nx6aSMzsR2pLGaA6zR8KSmQccTVAQYdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:18:31 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:18:31 +0000
Date: Tue, 8 Sep 2026 11:18:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] cmdline: add cmdline_ prefix to dprintf
Message-ID: <ap_g8oAzdlRSd3d6@bricha3-mobl1.ger.corp.intel.com>
References: <20260908101534.71961-1-marat.khalili@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908101534.71961-1-marat.khalili@huawei.com>
X-ClientProxiedBy: DB9PR05CA0011.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::16) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|LV3PR11MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 6291ae30-e72d-4748-10db-08df0d9287fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1VyOYLaGJ/XUDKaxIsnBl75xi/m0mlqSYLrfTEi6fhjuYHk4RhK6rN5e8UAB37HNPolsm8r30e8mytU0v95g9U95mH8H6VOO9lQGv5M7W4PQxvzmHaTKCqEGmfEFEXyiXPU3iYk1vyQzzxsqP6t8rUOJCzNR1KK1JS7E6psFMZAKqnefIV+kVlPP3cUNITlJs3j2U1dDdy0STIX2R0wk5kIya5HVGZIDpsIkFf9xpYL3LVi4gRgXJhFerVNVfW28zosFcwtLl8OQulVuq7DdJeMoR26T15dbQVmmNWPewExWIvlU64jZSnxvOIT09GuInCsKgO7dKPgsPV2Hp50sE0zZg9/U91STBv8R7Em36ByHHXMcAgAs8zBMlOZc31ELBhzCsVdcVSROslCRMKEPl28wVo2P+v3qG59SsXipPduD3tS7YZXMYp2zs8oCgVjkusG015zVYElD/FlOQ8ec8PJ4vfQT9WXaWvPIcs/8GcvFlfmIc8MWV9Px5Tf/f4S2dzlwLD0IhAqAeIUY5lmmiZVwCRPlI5UsuJX0ABcNv0YCnTUjrm4LrIbNsxWWGHsTN3YyS2h9wAJGqOXKy7IVCrBgCPLdyeZPX6/kGp5GzORhj1bA8tCdlxV5JLz5l4xNCDt9kwkeoIpWosTlQ9CMK+n3fVKe6Y5PHvaeh8ENAjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Frk/QgU2fuP2RRTNjo28xPsWR5Uc65OaKak7AUCv9CwFZDYhw9IjKk17oT2h?=
 =?us-ascii?Q?kDBNVOze1XkxEjXPW1jfPHxW8rQ7oS18OaDYKalgITf6nBE3imD/jo1pTlBw?=
 =?us-ascii?Q?v1iahy3RSkocwWNDRoFIqwvGy4W3qtq02EdEnSIOKLtjZ5lfYyQkova48WiK?=
 =?us-ascii?Q?L0mG+chQxZ42VvjH69Pjq4zfACGqPIORDsp1NlyzcFhdVTRnkMaFCWKoikLS?=
 =?us-ascii?Q?bGpJa9y0hrhng/pwqN3rag8K1lt3VjnKyl3coq0aPFK368LrPAP82PWKHw1H?=
 =?us-ascii?Q?3euT2Zik5lLbc/zJfw/tQGLEsKIhdTtLz0aA/TYSPFhdA57pyhsxVDnmIzAi?=
 =?us-ascii?Q?KnVA6+ZsShB/c4oAG4cd2oTEz05WCipAMqR/VzBV91HakiAaFdOOf1oFwM+e?=
 =?us-ascii?Q?udj+AVUx4K5LrLBtPB76LEn3uEhP66GKw1umFtfPgt0ATOeKtGN9kEDY/W+D?=
 =?us-ascii?Q?uO4/+kAG7PJejtwG9uyTsAAWzgsnPsqO+snIHX3ologNK8mk20m0o1GiAIc7?=
 =?us-ascii?Q?0MkgzMCcLCziGJD/rX2xiy/Vok6veSAQIq/yJhoOfutva5rZAe3jSUHbYa+f?=
 =?us-ascii?Q?nvDacnsrl3+eNSGVCZyP2di9vjySykRp2rTvNG76hX3Yj2bLbePEeXDzktdd?=
 =?us-ascii?Q?3Q/P6gTlNdhbIvX4mHyEKUsY6Se/TRHe+c3mU0taXWtyAFpLiBWy/Jer4zrb?=
 =?us-ascii?Q?UstZVCIPzskN5a0CQwMP1vPOxmEw2I+u+d+/VIf6amG98wFAZwrNiKIOYqiA?=
 =?us-ascii?Q?gF6lszYEtYugrVz0KlAK6gvZK5ScB4j0Nhb4nNNvScvVm8IlgGB+rNPuqNCF?=
 =?us-ascii?Q?jENNVNPClCbCEk7uniuiFEIFdPWSi+DhZ3tZoncwaLw9whOmt9wnOH9JuAvm?=
 =?us-ascii?Q?jzVA4Zjz203zvnUG/8fPJ8Dzhd0guVqATB0O6MyC6tKXLrWNumaF7T0YhIHw?=
 =?us-ascii?Q?n/3TpbrOd5lCEX/i2saX2cKeE1YXOjDykji7OFbau9B0OEXVTH9iE+5T5m2m?=
 =?us-ascii?Q?POIez1UjjlioDw1Hi8opSgRQikRt+ZGcxAlka8HSPnofIokO26x4yW4qMH5Z?=
 =?us-ascii?Q?UwpgAx1eBcHGUM2ukVRS8jh8hChS6R8spb7b2Z4SCRPs+TK2Tkcr0B5h2LwT?=
 =?us-ascii?Q?bDxfqEHdGBfXOMNlGBBGUegcoW9+Akx1cvSPuGtShKruZubJFsMwSc+gPk9K?=
 =?us-ascii?Q?Y3SKfAgJCYxLzlLRyKFBxJMvl/WItAR/9rUt91Q+5y+9rUEagiLnzsvSYMV+?=
 =?us-ascii?Q?Q4m9UAG34cGObErY5uJ4zA1oa6G+aTI4Bx3wox4Tz24ca293XTfbVmWvQTTP?=
 =?us-ascii?Q?ZccjAGlzjbz5cNDh+xmj2RQBeK2u0MlQ+pZe2GKqPmAgO4VbDriPeavb6cfl?=
 =?us-ascii?Q?C3ZvbrLbCX4ApknesVm2dbDMYJLCiFLu+gw6WQ7NsDpg2VwgpjVmR8HOnsob?=
 =?us-ascii?Q?PwpKXtLwjsdT/Z3oleyuxQsWk/6Mh8CI/IYQIT4zTjqV6nJS6BfcHMwF3wPn?=
 =?us-ascii?Q?hLpCQDphjotfw7W2vetSJjoibMSRwTHQ9/cU5Gk3MAi8BvZQuwsSU5eCig+m?=
 =?us-ascii?Q?XtV4U9qji8IEXj3YkvN8K+E3JY1ACQ7mgnp3yKPMJVXGAnwHwlN6CQ1p1wDc?=
 =?us-ascii?Q?A0KUzMqPsY6euqFHvhpz/fRH/J8smv5PzSizkUeuMOuKDu6XxT3B7zKU03g6?=
 =?us-ascii?Q?8uMXsyAKRlKvabro/LOKBxOlq6Huqww1U6kbGXN/OGYOQQt2mjm+exhZj4xl?=
 =?us-ascii?Q?hDglUBLaXMG7vwIGqk+9NBU2X992Rks=3D?=
X-Exchange-RoutingPolicyChecked: dBnWCbElQQTqesOdssTlwecFuvrN28t6bsWqdbL+V9qPaUMZW2FmnT7E5J30szpLyzpPvmZlMRwVpeBBvsOnKoA2U+ij+Hray+n2I0jPmEza5Yyu+Yk7zAqH+H36lGOX+aylavqDudhuRw+D4Q8/vuR1hR86MN6xy18dRwWEuIQbWNy5ScR/t8GHIj5rtNvyuFGenEtzLEf3OYp7vXs37i+sxaku3sRtQOwYygqYPwuQGQhEKl7J2viQ6A6YyefnpBTMmEJLMWbwNW0mq+aXbOyaYrvJBhw2AltDFgxbOZ8Fis0IpHD9qziA6mdNt9ojYUK00+AxPJTuAdwsNC+HCw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6291ae30-e72d-4748-10db-08df0d9287fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:18:31.0208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW4JeQ38iNz36SA26yEQ08kxk+1XpdYsuwzs6KAdauzpqrZDxWlcNbN28852sRJh8H27AQcu0/19SqoicynjKf8VCmlXLstRREh1nwiPVvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8742
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

On Tue, Sep 08, 2026 at 11:15:34AM +0100, Marat Khalili wrote:
> Macro `dprintf` defined in `cmdline_cirbuf.h` may clash with eponymous
> glibc macro. Add `cmdline_` prefix to the one defined by DPDK.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---
>  lib/cmdline/cmdline.c        |  2 +-
>  lib/cmdline/cmdline_cirbuf.c | 28 ++++++++++++++--------------
>  lib/cmdline/cmdline_cirbuf.h |  6 +++---
>  lib/cmdline/cmdline_socket.c |  2 +-
>  4 files changed, 19 insertions(+), 19 deletions(-)
> 
Strange that we have never hit this issue before, but good fix.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

