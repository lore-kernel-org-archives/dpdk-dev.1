Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D3C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 14:48:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64E93409FA;
	Wed, 11 Jun 2025 16:48:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4269B402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 16:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749653280; x=1781189280;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YSlWifdouqduT76zHyCuPjP968Aao54Y2eOTIczrzYI=;
 b=knqZh2RQ7sqqvQdZxZSRRF7uWefmPFExxisVM1Hyx55d8FAT52RgAvLC
 sMFQ6Wu2x/h3HbM51KqTTpOyHzkwv7L/U1jOT7G/mNSWQmNsQhnNgmacF
 lwRQia8zsEvt9Gmv9pmVQpOimqwDITNSojc7c75qf4XXluKaomToiEBjp
 5MzLif93yj6kihWt+HlsE4ixQv9fJft6WtoN8/SouUugtaDt+sAOxRCRP
 G5VE+oSvp9XKeNcy4hIncsMLb/Ult4E4lXUZ2g0fbD5YplwD9T5q2XDWa
 jKd2MoxH8XekFEcown8HcTY+YPVmzv1mKXyctiDaoATIiEf2cLytn93KL Q==;
X-CSE-ConnectionGUID: 50DhssYNQAqL4zLJ5HJ2pw==
X-CSE-MsgGUID: 0/sn893QSDe2em1SqZYWyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="55594939"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; d="scan'208";a="55594939"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 07:47:59 -0700
X-CSE-ConnectionGUID: mwjetaxGTOSrMGPu/ILnQA==
X-CSE-MsgGUID: wJzr4a9DTHeAXRsyF8KRyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; d="scan'208";a="178129386"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2025 07:47:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 07:47:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 11 Jun 2025 07:47:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 11 Jun 2025 07:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/GdvL2Yqe3/FZmOEipZ3UweR3KDju3kLAB0o2gp+PyPKL2dyAx+Y38xigNMUiaQzBrTYIvNx16WcXrI6w9eNxYkJqXI0MoDvwJnH/aGAjTlNGG5VFTvZrkOkQmulhYnw6KoZSRJIey87vv4ohySfnK9svNQgdScry4iJux+u1OsZ9ZfU0TqqBOJjApmXJl3+OrnmqyOOhl6ryl4hX4VQmrRncT81tEDkuUcYVzBo/dgVGIDCysTVtStzUmXL0lzfelqb0DAgcvQNxFh558290D5e5InnRSYh1rCik+5ibPR0vTiYhIXmL7uZALxOAJvCmBqJNH4XyWc3eZ6IR+FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jVEjGtWoPno2WycBprTJ8zEj0jwK9KeGFMecQ99x+w=;
 b=cMY4m0bhiKCxUeNn6xN3bJGpO5Y8rjUaR6L3LpD9wIElz7gQDXlv64qYa7Js3hNauLPad/gZRyPT8hcEAkfsyorROwJ1MuyBcPTA6VD41TezDr/xpMacOPmxq+Eae+/nF/d7fIiB1f3GBFApQs5qs7pH1cmz3XWGuDx7TKLy7X5YDDB3+UbtJ7zNKb5dIEM3tx+BU45wa/HClSlkzjZ/WNdvxS4IFbX2RSvG8GD9ivcV94uMq4IXemxugY5i9yMzq7DlLW3FuepzgkuUEPQjqLGwSmMmtxbPJXHlMFx9u8Qx/1HfNyiucpu01XTQVRGRWPeK9W6AlLq58hKfDIareA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8466.namprd11.prod.outlook.com (2603:10b6:610:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 14:47:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 14:47:56 +0000
Date: Wed, 11 Jun 2025 15:47:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v6 18/33] net/ixgbe: add a desc done function
Message-ID: <aEmXFk-GHFZXfRu9@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
 <cb13643e6682346bf470c773c5eda7a77fb5bbb5.1749483382.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb13643e6682346bf470c773c5eda7a77fb5bbb5.1749483382.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DBBPR09CA0048.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::36) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 755ffca7-cc68-4fd4-7c28-08dda8f6f3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QlpGaZREbwaBcop89Ax/3G7Yw5obSBttTpTYIDN6V9mgLWRKX4HTlFQEdE4X?=
 =?us-ascii?Q?jKpdOxMM6oo3Mvj5s9rL/qqUr2KNHW24HsVZ/L9YNHW4c4yLo9U5fLVyYDUn?=
 =?us-ascii?Q?4KkRDTWWUKCFg45oy6d2FjGr68psQI440X/OGBqC4JATd7/4sWIuvIH1873M?=
 =?us-ascii?Q?WnmVjrobm2YjQxoqNcfXg8YovcxyT+ITSPRYaN2xVsWqdFgN3sn0kFxlmulW?=
 =?us-ascii?Q?lv/RNc6QBcVN7MvORofqNqat7LWzpQ6OBx4MDzoQBMvnJdze14mt0mFLm7xu?=
 =?us-ascii?Q?Jt5A3wwh98uzZYfzeT5K76KE5T5hxqTrOSmqadDqn/xbZDIiOdPUD0+x/lQA?=
 =?us-ascii?Q?khP1aRH29ZNcJVRVJBF3cBf2L7mvidN+IwibfZArgh+jFovQnTmGI/EiOEKT?=
 =?us-ascii?Q?YOcYuRgYlJHsPOqfBTkEVWdAWlXGeJryHAMi2N9HirmDQAqPeYXmx8FGZCp1?=
 =?us-ascii?Q?clSg0epPgScdOYobL0vR4EivGMTLCNJfUGqzqpXcXRao2GEn8A0FfofVwyWk?=
 =?us-ascii?Q?vo/dem1hRBccwtTqqTWqfEGd9l7PIevRfukuDpoyRAWYPsom1SvMAZ1UD9O2?=
 =?us-ascii?Q?UBGhkGKrGocHoBhT0lRBR2gMI1ZoGn6jzjy5pQ9mmXr5CxJa6rkGFjzCUw+8?=
 =?us-ascii?Q?w/QjWHvkZNtlkw6DlEGNLuddq8EzM3cp+D3mpV7Kkf5RbeRvEFS0hGH/34ET?=
 =?us-ascii?Q?eNRKvJH4jPUJsYi9Yj7foOidEKi6nUBaljBcR/aJOTg0OKtCAKBlRIP27cPk?=
 =?us-ascii?Q?0hZF1aLsVkvKnoxPY6jPOVdKY3UmG9DNEMdlF6EETHCwiet5hCZgaB/+vZYw?=
 =?us-ascii?Q?11qKdcLvzsvIFlxkTS0tN0QalTTlc+1kn2IfuVzBgbwsFLOy6ncPZhihmVBG?=
 =?us-ascii?Q?Wvbr0jVPIt4u9G562o5j8vlbXNLjYaCvQoekI/12UeYtlxfSOvoaXQSPjtvm?=
 =?us-ascii?Q?eARLQEOoIIq/bdCTMIFQwSuu4Bo3QglvjCoMc6zFQmvSxuCCUnga5UppVjpp?=
 =?us-ascii?Q?6Eh4xATHAtzELT2HB/yhfqdOieCA+/a9tNDjXALdQSvn9DO+bgoPuSaLemPS?=
 =?us-ascii?Q?m0QhyqxAwovCg2uDOayNnuWDE9b3t+BhVEGmg4ILPlYqfuCXl0I+h2Lp6dmW?=
 =?us-ascii?Q?skcgHGZk4YK3YIwV1gk/eykh9k8Z6QE0iBB4g98di0ngaf7RF/gWangPwmAw?=
 =?us-ascii?Q?nLgi6W0Vohd610ODhbZHRz3x7Ow7tc6bL1FlRn+PcSKuk6tpwtFjZoKz85JF?=
 =?us-ascii?Q?SE6kutgxBKedKGJMYQC84kS6EWk4f9prgJVvgZk0xcpo36q+Z/iH/y9aBRQD?=
 =?us-ascii?Q?gwqyYJK3V4+BtkhyhHIzdxMHOBqRmd5gXFnz9lt4CQ+2681xtvAmDdajiAiV?=
 =?us-ascii?Q?vMjWGkdnxTRI62Hk6NY7a8zk18nd8A6kG9wE23miK396K8Trug=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/iF1WMvsMhenqDzQLMZCBqJ3+Jr+/HKx6jSCflZPicw1K07dTKAv4FdSdXO?=
 =?us-ascii?Q?yPTU5QcJV+yZjPByyR0MbNeN8F0lH1WHCQYleD1gNOCc3rc1JLC5TmqrDn5h?=
 =?us-ascii?Q?y9Di0CgoNpM4efpnJL38yI0lcR/fG74AXQpfNZmB0x8ToewdYdxoTksneA00?=
 =?us-ascii?Q?kxxiqmosddUIwJsYJU7B/2Ma4X6hAKqemuK3InkFz0S6CPyE46vMPREwfMrJ?=
 =?us-ascii?Q?2cYhEADYmZgg/qikw8bcgs9uOh7t99arJzZYHoWrSOPym0f7WZJFHC+P5JmQ?=
 =?us-ascii?Q?9sn6o5T8nGM9iu+V3hKZzRGt/W0oxunyLHeqPuyXVoMacTDJUHhcSmHfuy7H?=
 =?us-ascii?Q?p/JPBT+mcGBMcIfQPkKHgnbzNOf4/Gy5x7NK5FXM3nWtmxshGEu+Hx+yFUE/?=
 =?us-ascii?Q?QrOrBJBo71ZVQyzDYfo5eZ/ld0gH+mprsV1N9K9RsBMiAIQMFxYxidxqX2BZ?=
 =?us-ascii?Q?uny02ppK9jLifBuPojtZFaqYRN6LMoVjmJIsbhwBG9CpqhbpWQZg+aBp6W8T?=
 =?us-ascii?Q?JAcvEWv8qh2aOXQkuufwOk8SY9wlToSR80CRdNtGuFYDPve2sPF1k4vx8GQ8?=
 =?us-ascii?Q?Yquwti1ynvpivWef+8uYgfj6oBZeu8yNhVPgHqFj/LGox7f+1upYNe/G0+CF?=
 =?us-ascii?Q?PigcgOrN308LQFX7jL64EKeF8kWpYfbiXa3AALvIGoiFr0sgxqwFF10pUlRP?=
 =?us-ascii?Q?YyhtAm2cIg5Ry6jqbxbxvBcEASsOGkHn3Zpe8UK92KTbcfYqpa6dEhMzejqU?=
 =?us-ascii?Q?2U8JT1qZcPmwW6HXEYJ66kZB6Lx22+Q0Bqx9iSU+Va4fzSr75mp2vFuawoD3?=
 =?us-ascii?Q?t6q/h9vhnzRfHEUsJE9vTUI3eXWfuyOFZsun4FvIFMWNKtJI3O0huSQhgcuA?=
 =?us-ascii?Q?9Hiyzn4nn08+lFeR5jfkB7huDU5aIbd8YbGjDo2W+mzbLSwmVbsEZwQaUlmZ?=
 =?us-ascii?Q?FPLQo2HoHhA4Y7Ln+NIc2HFXCGMouXuhovfpl0Xi1ZJiTxSiQtSeDJKkW7jh?=
 =?us-ascii?Q?grmotbeM7D7Y5eFM78AYcKR+TTtR/KLPxNgmaQNX9p0X0LqczgHLsRGbAR+Q?=
 =?us-ascii?Q?+BvE0epd5+HVWW0/ml4mib0krC57nHj+VzyKVTVtkLj2Q7zkV89geI9YlUpT?=
 =?us-ascii?Q?ASGPIxplsQh9QYuivbnpyzOszhCAzmITvYItSOzJahfAdMqK/+iYs5BWRrw3?=
 =?us-ascii?Q?H19gvXUe3Y16zDtxajApcqEJyTv5W7WD4AwRXgy+7wYyDGe+7HBFWNjCR5J7?=
 =?us-ascii?Q?9Dp1bN3gdc1ljCuTrnbShcYJbcBnypKefM6yjgK5MyJEp+8FfJxW68nl92en?=
 =?us-ascii?Q?SmvEwjK7Hl1uq5RstR8VEpUNk9YNYqGBesnyYV+/2oGtIod8PPr5T3PBTk0l?=
 =?us-ascii?Q?Fw6wdJ4Ukv3DO3nU2zfLAYzX0VSwcs9WBr0UXYDfEI5cBwWC486Qi9RTQa9N?=
 =?us-ascii?Q?RVruAEzW7IFZKDOvUXlB4T7kQ9g3xVCAssN/d8dDB/19bxbB1P5E4IP8TrcE?=
 =?us-ascii?Q?h1kMzhoDVDMKWBMikUXScoUG/tnpdTUqV5l6H01GOfFVO8zQ1pg4beWt1RAZ?=
 =?us-ascii?Q?UzxwbMUuJlHRV2/Gt2uhTgeu4hB4LCer2XKts7Kdt2+/ksw4YEo3I3a0K1dv?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 755ffca7-cc68-4fd4-7c28-08dda8f6f3da
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:47:56.5043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpFTyV4cbsBlNXZUkn/ALlLJ93+0b6OftNQIiI5seyGsOsY5voIg0HVYJMfadolFnfY1zM4B2y2F0uxsfOfYxCz+Sq9Hxv8bCF68TgCviBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8466
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

On Mon, Jun 09, 2025 at 04:37:16PM +0100, Anatoly Burakov wrote:
> Add a function to check DD bit status, and use it everywhere we do these
> checks.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
