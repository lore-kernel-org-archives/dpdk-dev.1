Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4FCCA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 17:01:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 321D44278F;
	Thu,  4 Sep 2025 19:01:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6727140275
 for <dev@dpdk.org>; Thu,  4 Sep 2025 19:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757005279; x=1788541279;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7K8+Pkg0je6UxLAQknWdypRTgcMUbXmSh2cE3VY0y0s=;
 b=hyB/mLFTDbNTIbh6b0yrOp2+X7RphQD6lq6VNovEzL3DuzwqMDN8oFTZ
 P6Fu3jqwu1li6/z+SFGK31TPSRLK8gErkCpWwqdbttTlMaDMOvMifCwaR
 +ovEwtsFom9hfbrr0/0riwpxsAUBxLG9/yONW6sxLrP3p+Gw9BXgfdPgL
 v937E6M0fT2ts2bPkODvHxCPC+Ez4SIAW4FMKlwjwhoBn6lVuYLsLOwB8
 mlvnS3QRPq2twX1wvG/kFmRyhhDfXFlLiB4y8suD58GHI9D0wHSpbzXkA
 B3N9yRJ3iSxubwf+oCiff0kfTSpPYwMKq3Pfu+w214V71/r/FkrVb7fbH A==;
X-CSE-ConnectionGUID: F/dS97OeTs6jWsrzz/2S4A==
X-CSE-MsgGUID: XRDBzD+IQpafqbgMfxdVXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59293042"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="59293042"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:59:53 -0700
X-CSE-ConnectionGUID: QEY04e4cSWyW3ZkmAzGndQ==
X-CSE-MsgGUID: Q5M+5BYjSEaNeIJr9zwRuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; d="scan'208";a="171526358"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 09:59:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:59:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 09:59:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 09:59:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCCY6hXSTk3Ex/XEenAN80U2X64kIE+OQBbkM2itntxo1+V4hDOTjh4EUNZCCn0DjJ+hqVymDvazD+7mSA95RU7UlquGE514qkXbXyfjT8Y2SRYdwzIT5JTxZuAd6DnmnyEQC+gvRFarcoMCZ29s3hw1X0wNnNjuHtnSlpB53suLQhPtzs/1ZSSLGyyADcHdjckU8snfXCoV9zukJc2XyjURRaM55HzHgj+5DgCTI0zpplUFMjfsbQgStHczB1cZYoIQgLUlueV5TYSFX+adoPX9RHhooTiSyH3q2VuL7xXYiTXs25pRgAS2miZMq6eUVjuUQZEG3KHdNCcAZp7ebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zD6SF4nOMoB1g728HRqP1301EEu1C9f1zciDSbTuUl8=;
 b=Wnaqf2EduOR5kHNd4lWludQpLRHuNyx9U5kZrD66wkMzGCyy8l0+l3khvGtJC4QxcWlTGCibF73J/8zozLOPHrcxLL/F4letDqhIzGJEHcEEKJjMVOxf0kj7pUbo3gGGfiVgjOie+dY9AqvZelckCFeK/nuFtaDR0QUDmx4r7Lo0zCR+cCMMhCUGgwbl4VOIx62MlSeg3DBPpcDNe01kRfdyCAgPK2t0JcslLtl8ka8XUtOS1tQRc2XBFGAKTz2CWZk73ltpHXwf7X+XrmHe/hRfVbcN3a6V6V5o0rmu6vnacuWF0e8VuBj0QHoPW4cbVGlBS5q6CTOMhUkN/douBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 16:59:50 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 16:59:50 +0000
Date: Thu, 4 Sep 2025 17:59:45 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/3] net/iavf: fix Tx vector path selection logic again
Message-ID: <aLnFgWYb77VpIiGd@bricha3-mobl1.ger.corp.intel.com>
References: <20250904104440.2167205-1-ciara.loftus@intel.com>
 <20250904104440.2167205-2-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904104440.2167205-2-ciara.loftus@intel.com>
X-ClientProxiedBy: DB9PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4e36f2-34d1-4646-1e73-08ddebd475dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yHz8bOr8md4NVhsG3Jv6A+2lQoVs8BUBla4ojeG3KX2kPq9gqT8ld14n8Y4z?=
 =?us-ascii?Q?/sFjr+AI+RykmrmsDXaoh+uutcp7JLoYgXgjXcmlCJPfMlEl0sD+clDXWEKO?=
 =?us-ascii?Q?mp0xsRzKM3TwUNFSnpQMTeszYEh01/pfKovjdJfTem4Wqn/rRvoBKH07/pD7?=
 =?us-ascii?Q?I1gw+KlFRJzHtC/3fjSC/NDurECD5Kdp7rDy7Q6GkPLc9Y8JuIK0CJa9R4fj?=
 =?us-ascii?Q?GltlZvrAGOEdOqDDCPHuupq40VOX+ZvgiX7khA8d9gbwdamymnGIoKo3geQz?=
 =?us-ascii?Q?VxwrhNYG/tir3f8VCSLsTAQJMPHY6QSqZCBFIXu25QS1Jpis3YI5OIBzvy/P?=
 =?us-ascii?Q?U/kcVFbf6TLmm9mu9bpBVVql3rKMhx7z4xjdnHWE5A1UIP7xDhmLlczP0kR/?=
 =?us-ascii?Q?WTSjSKsOz5AypcjOL6zMaCdjPpJ/6Li+5lpVZByhmnddpoGhlsTjLMC7Pw50?=
 =?us-ascii?Q?Ho7T0VlZIClqk8kVWmRGeCf8vnKrvIZeNB7KyhVeilkp7Do7A73XFA16zCbs?=
 =?us-ascii?Q?+EGaPXQLmLj8YACTtRvHkh9XNoxf8YZ+HVNNs+mZBJKVgutnD/2EkmD6XCV2?=
 =?us-ascii?Q?uiyzgnn/awacAQto3MWyN9pWgdjmlsGHfzdO1L9yLkVx+m1eeibhet1YGdnv?=
 =?us-ascii?Q?4CCjPUn3UDO2X/fTDCwR+LjoCnXLgvXNp/ZCr88ez54b/MXkWEny3E6Ng7w4?=
 =?us-ascii?Q?jbb/YASXc+OLXMmk7Ktjz3ZnH5yui/DH3ffI6ASwDjm5AOQP6fzM78qzQP7v?=
 =?us-ascii?Q?W67XV0KJ0q/2L+P65b428WGw/vnAVGH+VhjOZL1LPaTZSZjhJzjSh0d2s8gL?=
 =?us-ascii?Q?eyYTTkizAxmKJbrd2yHkG1qF6Us+TQ+m2cB71Hew9cpWCdXaLAuFMbvCSoxn?=
 =?us-ascii?Q?rl4PDeKHQuq22MsiHYJZ/uWU3YHiKwwBuL8HWu5W3zzV/RpPJmQPeQ8+MpC8?=
 =?us-ascii?Q?BzGAXaWTsYabWsRIOeZEmTqZBiahm8NgJlPxMXoZhlHZuz1P4YfM4l8JZ7XZ?=
 =?us-ascii?Q?62m2/JsVaaIzwP0H5uHeEwAKYhsT/0uWWqUhM4m7cbF1ITvtc/smMF/9fFKq?=
 =?us-ascii?Q?1cmJ8/wjNR4rRhPnY0uDufQ3Notob/bTIfK3zgZXXp3Y4CtezcGfnzQ5Fu9Q?=
 =?us-ascii?Q?kUthRq29B5Tsxr3uxsh7U1rar84dp1c5tl/5JF7qWki0IC4NxqfWsc/w3+S9?=
 =?us-ascii?Q?AQGLXSh7+ijkPqIHcsmVDdIhEs+ToC+1MiLknPbw/9yvgChLjVOXplYo10M/?=
 =?us-ascii?Q?ZEpn/DLmsY9fUbypoSUmUhihe0yR8NI01RRybkyZ5bXTzQx2J/KGK8W3Vml4?=
 =?us-ascii?Q?aWI7Fv7E7IjanijafbRsWjKuhvqP6Yu5Bl7d736LawsMmQMkZimLtvLngdZ3?=
 =?us-ascii?Q?IjecieDhlhIrysJlXQmeKwEX79gq7vRhHe+7B5IaBdQ37tCGBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vPo6xnDf0oaC8S93a2QhFukvzzdMLcPutRPojqa0Jaaso+F0EboViv4vwjde?=
 =?us-ascii?Q?HKixVfSrikLNL0Bty6+LIei9aQuqw7fEa5M4KAos6/83tx8Za+oDbzDt06JO?=
 =?us-ascii?Q?THxZNBR2G+Tb7ZLGkBCAQz7xP0MMevCmReBFfeHxCEXq7laEbcG/DGV/XOuj?=
 =?us-ascii?Q?0o5DkQMHFz+Ip3hEwBCaDwrMOtH19GnM9C1KwEuW//LEggFVfWVxKItYo/5e?=
 =?us-ascii?Q?dlQ2DcGCh9jBQdhhfpTx7G92GI11RdrU0MH8fnKWxonXnAMcKTL3oVVJsNGI?=
 =?us-ascii?Q?Xmtn+p8EroCXsjasvLQyA3UusD6WmGPuBT6w0yQJVU8g261bLOIr5RGg+u4f?=
 =?us-ascii?Q?cuhKQ2GhDX1YO6V9WU6vjGbVl2/SsViW5e6wtojnWIGdsBuh+VXe9miuhn9M?=
 =?us-ascii?Q?8L7sMJsnAlp+R44O9Oae02lhT2GBRfUGCnZXGRZ6Wo3FCmYOL4g/wBtC9wXz?=
 =?us-ascii?Q?Hznvyk61+dsjS/RPFJEXzXTHKBPnh+pAmR1INPIQ9TDfvzJQY9xoZVk3h486?=
 =?us-ascii?Q?hH8NVVc05BpKyqu5xgdzevccjlXBWZ7JthfXCnvVLzgc4kB/TuZg4zRHR53E?=
 =?us-ascii?Q?uOvl2UKIkKBjfBDx82krBwCtN6bVoPZmRgE4B+oBusqQYM97j0r5lwmUgVZQ?=
 =?us-ascii?Q?mGJgbbNIiTx0tHj3SmLr82styl8xF9OGIWPUWn4VW+mXne5gUJM/JlPp32o1?=
 =?us-ascii?Q?wDTx34k2Vdoaq6palgGLyya5ZLM7oqtpKE62PHDFRQU2w8aQrb5lwY3ZsYL6?=
 =?us-ascii?Q?jvXzY/La5n95PCUK63KqNDpsa3eMyRn888ydh3rHkgSKmJ0GqGnfQqURRGX/?=
 =?us-ascii?Q?Y3AgpowvamQ9OsHw1erAc+frc+3ldBdqSOtds9rmwluGwsAxpzHLukder2yc?=
 =?us-ascii?Q?Rh794cnjuQt9n/lZdkgiuaLJ/9z/sNhu7mjS1tBE2Rv6GjbgiXDGUwcSFmcr?=
 =?us-ascii?Q?ef0/N/e6rDMrNphXp98Xmdp9XYV0XT+LVYpYmNy7pPS9y1X4+rkx17EKqZ3Z?=
 =?us-ascii?Q?SBN90iv4lqHT8YakJXl9OFrVt7SIGM09OlPTUE58bKZe7ZNt5eLB8w2KHL9g?=
 =?us-ascii?Q?LlFsRBPxa6ikLfE2E5wpJJAUscnfjz37xIAIa+EUXBiJr2tXJDtTahrKgt8l?=
 =?us-ascii?Q?PQjGP3batRBaNEETQ+oYNqKE5vwXZeVF2tnk3OBzshgMpC1nWxZURm9l6vJu?=
 =?us-ascii?Q?1nLeJzIOcgusYr99UpCI+5MhcMT7dXtL0X4OiNA0s9hId5lfTqUV5V2T8hGG?=
 =?us-ascii?Q?nMvbCWb/RT6hnGcI6rFeX6mrkRCr6D4PGLVQcq8VR1c7xfXTHEZ2sGZW115W?=
 =?us-ascii?Q?9EdxOsnFInFLjNjvx8sjvj8GHVDJYfdGUaN2cxvVGnDmimvYFbcm4i4JHWr4?=
 =?us-ascii?Q?txXJ4di1ubL1WgLm0jU7Unv6XtImqlj0qReZqp39Hg0LdvHLaN3rDrmKU0Zv?=
 =?us-ascii?Q?Z/w85oSpMOKmItx+CF8NMcpoFQ2U5liv0q+UKnbsJzlJ5A1WtBjMBNsQvutI?=
 =?us-ascii?Q?SliFeB7EwXiMFmqZHg6a7HFA1F8Kwrn7K6NS2xipBMIX466Bkwb5M4vIVArd?=
 =?us-ascii?Q?PMZyyqa3gtXsVrUPYU6lVGdCWeMTgH+eyjR5ea++TkrSwf0Eo6SLRrVBHSJ5?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4e36f2-34d1-4646-1e73-08ddebd475dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:59:50.1172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onm+aWwgEq1JjUUmmbwiWj9cb/TKmgZQjKjOVaouXM9VmD6GP/6GUs8agOSSvGTDOlymTlef5UIgUSPD2g0CRYFVJrTYWh/MgMOGk6mG5aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
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

On Thu, Sep 04, 2025 at 10:44:38AM +0000, Ciara Loftus wrote:
> Commit b39aeea703b8 ("net/iavf: fix Tx vector path selection logic")
> fixed an issue which caused the scalar path to be chosen even when the
> AVX-512 path could have been a viable candidate. The commit
> be1a887b83cd ("net/iavf: use the new common vector capability function")
> accidentally undid this fix, so this commit fixes this again, this time
> in a new way due to the changed code landscape since the last fix.
> 
> Fixes: be1a887b83cd ("net/iavf: use the new common vector capability function")
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Will squash into existing commit on next-net-intel.

