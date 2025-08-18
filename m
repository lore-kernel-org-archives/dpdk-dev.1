Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33986CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:34:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94A0240267;
	Mon, 18 Aug 2025 18:34:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 524BF40262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:34:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755534880; x=1787070880;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZEdkO45S2d1l2lgykMJYiMjgGyG53q4GvcxY2cNPCdA=;
 b=KPap+abj52EgRdzkMBPVhh2pjJWWfITPLuLUqWPoieBvwzNDe5JFmOoC
 RpZUhYd5Ik/jiaD2Wa31wnSdIqLIcyIPG4OywxBG8jlpCjvlWIYZvOreN
 2cOFFaHj0JZA3uVXFWEzITyvnL2627f7pMfh3l6i+1cdRhgeFMr9FNGYW
 Dcx+m25FNAgyhq8zyO0+gX0GQW6t1SDJMSGsHDWzL3Ti1ylchOUk9B4y3
 qCDeS5ltWa5nUjaIqN17xeExWY3SFJPq9kopIIylIfuLBSsNyPdmI/30u
 svo/n5v8dk04Jd9KVZh5XA3jI4+rp+QiX/ZrYNBmUT5PvD2jGejp3Msow w==;
X-CSE-ConnectionGUID: cjfp0kqyRT6HK8lG9UFLrg==
X-CSE-MsgGUID: CyWGEaZ5RaSJjU3DvBaq6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="68860236"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="68860236"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 09:34:39 -0700
X-CSE-ConnectionGUID: G4xdvtMeSm2R3vJdKhWAbw==
X-CSE-MsgGUID: XolWiV9DRUGryRgyM+YgxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; d="scan'208";a="166860063"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 09:34:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:34:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 09:34:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 09:34:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTQcgl3uAiXp/6V+FcvYNezNb3/IOaGtRyi4XZihEvLFz2pkbODc2/mcTSYK4LmFqAIVYeGmnvSXhELLvB8bTpSHqVySt0y5ff3jpTB+CGg68xDQVs6cuTATnu9cZD9hB32nwBlJPjtk0HP9TLH1/SVfstdwlWftHMWRsJdSe9q/GYoI7Km8YyzsWe9B/aTgut0H09weAD3yLCXF6UeNyfieC/CdVDV4N48XMqgbhUduwyFR6RiCElTB0ASffltBPAzSOqoAvntsAQ4F/3rlSDBXdlEduIMHFS7TfaRfXR8sRCEy+8jzNCIrHnd9lZQWHD5DC0wGeGAT0uwKmGA9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+umlTtzuPxmBD8mLQKjDlXxw7m+9EGaO53Bm6NG6ko=;
 b=wAWiANRIbA4JQmD25PZuYMz9nE/fuOuhi/ahqrkgxF/Hl2jTGQ9MVsMVd0ErKhHTVRimlTdKKutzl2jq0x06y2wgwkudfS7QVF24ke2ubR8n60M1cBZUKfR6dksRHZ2tu/SbZA+mg7BwoVbDN6HMcWTbvdSo/SQydjDtWzp5IJdUkhvMj16u7FG1vpc9aynVrkRC6rUmmhs4o7hXlmkxYXdha+MnjVb9sdS4/xtfyyxHHXh+EtRFF8tDTswmvW3k2jb08Lzr/XFr3FgP0XSjoEW0mHj+EanB+Y/ZdRqI6Pe4brUwAGz6aO79nYPfJvdwFozZwkjD2zLb1cU+APQQqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.22; Mon, 18 Aug
 2025 16:34:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 16:34:33 +0000
Date: Mon, 18 Aug 2025 17:34:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Morten =?iso-8859-1?Q?Br=F8rup?=
 <mb@smartsharesystems.com>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 2/9] ipsec: replace unnecessary comma operator
Message-ID: <aKNWFLxkzcdONrc9@bricha3-mobl1.ger.corp.intel.com>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
 <20250818161815.23611-3-stephen@networkplumber.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818161815.23611-3-stephen@networkplumber.org>
X-ClientProxiedBy: DBBPR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcf8374-ad0d-4152-17e3-08ddde751ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?D8FvJNBj5uBu34jC/lJI/PQR8QmwtbB/haQ6LhTUePwz/L1UCZq6Hv+a4d?=
 =?iso-8859-1?Q?DT/DMPIe2ktiGySaaqPXepVn7iso+axvs+8i5zycskmNJP7OZEiOHVzHJl?=
 =?iso-8859-1?Q?bMq38qYRu8V5NW8Z4+7gbtJM7VC1lwNfRmeqblqvayEWPc1NICDN+mn2Ul?=
 =?iso-8859-1?Q?/ZyHXAJDbkvxRteMzUPhFSgzpPb5R0oKI0K1oJ66IAgbV8e/m2kzD+dT7e?=
 =?iso-8859-1?Q?m7sd7LQU4HquWO/jpMf1MP4mYtyQ+Wbk2OC0SVxMUMVDaxav1OppKsB6FB?=
 =?iso-8859-1?Q?CW/JABveNoCzO/UUyKTF/DLJm/k53I0b6Ybn7yCbH9yl708iv9Zbb7f2i6?=
 =?iso-8859-1?Q?FXZ/xuk6Hsg5mGaxkMOtbBQ4ox911PSzcRi4orjps9yiw40xbsp0VohWU7?=
 =?iso-8859-1?Q?2SKIoZHfH593LWW2Hlq5xD7PVkJ17SOHh8dDRIyt4NKU4/UhQE9GdcCrQ1?=
 =?iso-8859-1?Q?d0hYHaqtCzeowUX0nbSsDQpNYUnRb9CNUXy0d8no5LZGhfhFK6LVRBOKDd?=
 =?iso-8859-1?Q?wSXT9Lb8nhWfb7d9Q0uXlt3pYH+YjKBqERdyuLnz9RWPEXFXNqXZ3kjQMx?=
 =?iso-8859-1?Q?B8kpmbzNiLNM/KcAqvxU+pdYazfBZKrsEeZdqhU8XJh0wkgvDakJ5KVBH1?=
 =?iso-8859-1?Q?Q5XxF/j4PJP2nVKRHLCE4PyJcnzCa8kBCbGuRq1e00cljG8RnWRoeV1Abc?=
 =?iso-8859-1?Q?UaWPCFXvO6ogBlZYmOuXnk8ZkTNV9nlia6w5MCIwiaqHnv03u5S18jvhbb?=
 =?iso-8859-1?Q?NTnl12vwFiIINTtjuYBHFVoSCiKQkDjt9Ku8/ytRY49pMJpUwQDFc7uW3E?=
 =?iso-8859-1?Q?JOkt80QlF6OX5v3k2rLSzEeeh38j/ajxq7EnHk3RWYbWNCSWoaKvzcWAC3?=
 =?iso-8859-1?Q?GKnFS5giywXUeGi67+NoMhqS7diyBzMSRZ8luL4iYPgwimeh2Gd4RwmzYX?=
 =?iso-8859-1?Q?IAhJBvJtWHaWwjCosUgFt3o1NMfcJyUMauPtQGo22MQYaDvWqqwGXSOFY0?=
 =?iso-8859-1?Q?NWbMGLr/TG9m3YBTURKip1QUVuIslOf7ZxNJXTUesHLxrT3EZQJA6eMl3j?=
 =?iso-8859-1?Q?quY5dN6BXRf0X6MHSBjrcyLkdcxLgxxSI3PSrDtDgz83XVDy4kKzWvCxuV?=
 =?iso-8859-1?Q?A4t3IItZbm5WZRq/1lq3Dcd0jb7Q8NiJ5lzr83b7hpFsUoNdUMa4hqSfFE?=
 =?iso-8859-1?Q?Ogx8mhhO5uYS+9rEayjsIZJYvLy43HGHMXhc2duYeQ741kjityR4T7R2uA?=
 =?iso-8859-1?Q?jIbwSBP95vKs8wp4ahn7PTonPvvKAqNmAA7dHNxE0y8uVzfLzWVOrNtwr9?=
 =?iso-8859-1?Q?XohXxkT680G9LNhk80UvDSvvrbq319n9FRpUqpqiWqD7w0455zXuiOeEKh?=
 =?iso-8859-1?Q?hjWCTwOV8ez0P0tLeJbWhYcYSQMSpv3MpIepCn3XcZ1djwl3JbRNA8hV2z?=
 =?iso-8859-1?Q?Hvn9iVwfhc/DzkDoJ6m0Vsw9+xsV1q0PX5UT/JOkAigh2JN1wgxa3aLqpJ?=
 =?iso-8859-1?Q?w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Fl1kre6An9Vj2trmRoU0ssSo/JnbtQRp1kOuXnSV81VMPJ7VFfu1xTaCsj?=
 =?iso-8859-1?Q?MBHo8xWmLu+b6NRRjP947jwHNJrbmYijChcV3a4NFJPxqouDs3fDHM5BbF?=
 =?iso-8859-1?Q?VornEnFmdKbF9VHg1RIqR8REDHE2MbQvxlguDYWT4XuRbE2HrPgQwt5m8h?=
 =?iso-8859-1?Q?EHtFwJB3w5gq8gRk2uP5rOA5qXYzV1NBC9gqiYERV0FzT7bhcREp/I8VHe?=
 =?iso-8859-1?Q?49IWEc9zRcSqaBK6PoW9fOqw1nSoE/lo9z5v6mJCm27oK8BMe0aFnZs08u?=
 =?iso-8859-1?Q?46kF6bJVFly0hxH6waIQG61kabWBqoNkBaqLhtfgzU6DKTnHy1AcXnT3te?=
 =?iso-8859-1?Q?MJo/uoJoqUhL1Tz0tvaOMPD4yncVs4CG9LbuoObNatR12rjm0CBpLqevBB?=
 =?iso-8859-1?Q?O/XuNcLiaWAob/po64DO2topP9jO8y9LWCSbjCrReGU7KOEXODOQkqblvq?=
 =?iso-8859-1?Q?/AK6J3qXMhCOKkL4JzPHfv7aYWS0IsDPFewLQiYl6RnH91+UHWjqHUUbji?=
 =?iso-8859-1?Q?yCJrFfIyKYaIaIs1/gcqatjem4Q78svtt9J4CAyvKI9wbCoHAcDyrnxhyR?=
 =?iso-8859-1?Q?ld6jTUiH0lyQ5c7otYE7EfRXfssCtjFQMd9h8UsO9CuFCS90d6CQxYXSFD?=
 =?iso-8859-1?Q?cHeuibiFXkzgg39XCaCftonIwU7mkztSKtH31G+ehnGGzBK7C0Ya1w1BWc?=
 =?iso-8859-1?Q?bjwTsicd+gSCb42LobI82d4v07FjqLOg+ki1qDwhXC37hj4KA5ZfhZW57f?=
 =?iso-8859-1?Q?2HhYu7rqqWN9bqUyw9CccjN4ynqNkETV5CqFnhF2IQkrR20UbxSsL1Jj7N?=
 =?iso-8859-1?Q?h0n3pPLUbu9zmGE1EiBR4vZnX5rrrscfSsSWSqJayc0OPVfMPRmkLT+gEe?=
 =?iso-8859-1?Q?FoaVzk9du76Ug6uTfj2obG+rjFbefLjRI9xfY5eqHYumppD5cHUqRzSsJF?=
 =?iso-8859-1?Q?C/Nuv65Aj9bLEFFLgzjkmnB0fYCTvDZjGrBLCuMduiQ+V1CBcr19wDDMhg?=
 =?iso-8859-1?Q?fyAYhcWCok1gxEjQvjPieC1c/ok1dvhVPF6gbukkiJQ+3emkv2u4pKrw1H?=
 =?iso-8859-1?Q?R5tHJuNBZ9NbWz3ip4P3yQIkulQwQ9X846N3sPxTueG8bBeKswEeuHVbpN?=
 =?iso-8859-1?Q?WG6ppFp9aXd9TrCx2ykDsMam5sn2RDhQcAQCfsa33jLk3IMUpDFJDPQfEY?=
 =?iso-8859-1?Q?gepMdAHmWTm2n3T86yn3fL+bHIP2Z56Ar+PbDNV93Cx1ss0CqIzxYyRstX?=
 =?iso-8859-1?Q?ueJnfo1LT9+VLEODOvO8rep9KIGqFE5d7L5GqsdHYnMQKfT9EJwjXoS1Hx?=
 =?iso-8859-1?Q?kRR8xhQata/6l6wwz/gE8bz+OsyEZA9toxesFPBcdPJHjoJ6PA4vi6VqPs?=
 =?iso-8859-1?Q?dpC14raq7e1Pxf6mNj1n7hTzjE4lPYuLNXSO5G68H7rolIZUCvYXm8I6vg?=
 =?iso-8859-1?Q?RfDJW+xljhJiURJ+g7twybisfQPChWKFP4gqfD9kMHJfTaoHcaJ+8DC+Bi?=
 =?iso-8859-1?Q?dGjjvWtqKmbVRBF8yrvMXMDJuUKeMZM/A2xuShbuI1KiFNWSEXR3LpoCy1?=
 =?iso-8859-1?Q?coiBZB/JCBqXua9SndFubZdreN3j6cFl9nnRwa+285/9xgQ+2Ze+gYeFUx?=
 =?iso-8859-1?Q?lpKuLjLRnnU39Af3xYmz7+xQZUaL8Io26WIiAUXFjQYIpbgnrnDV/p2g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcf8374-ad0d-4152-17e3-08ddde751ca1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:34:33.1128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hanPS4kniQSlZ9aqCubHTxaqSYfX96xAupK3TGQ2Cc4zN/M0scBrV6BMrvdqKs19k3Bi7nIMn3qXZDklBUSvtHBfAMTE4NvsWvbIz8TpDKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
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

On Mon, Aug 18, 2025 at 09:18:07AM -0700, Stephen Hemminger wrote:
> Use of comma as statement separator is discouraged and
> reported as warning by clang with -Wcomma
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
>  lib/ipsec/misc.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/ipsec/misc.h b/lib/ipsec/misc.h
> index fd4d3f5256..eee3bb0c1f 100644
> --- a/lib/ipsec/misc.h
> +++ b/lib/ipsec/misc.h
> @@ -19,12 +19,9 @@ static inline void
>  move_bad_mbufs(struct rte_mbuf *mb[], const uint32_t bad_idx[], uint32_t nb_mb,
>  	uint32_t nb_bad)
>  {
> -	uint32_t i, j, k;
> +	uint32_t i, j = 0, k = 0;
>  	struct rte_mbuf *drb[nb_bad];
>  
> -	j = 0;
> -	k = 0;
> -
>  	/* copy bad ones into a temp place */
>  	for (i = 0; i != nb_mb; i++) {
>  		if (j != nb_bad && i == bad_idx[j])
> @@ -126,7 +123,8 @@ cpu_crypto_bulk(const struct rte_ipsec_session *ss,
>  
>  	const uint32_t vnum = RTE_DIM(vec);
>  
> -	j = 0, n = 0;
> +	j = 0;
> +	n = 0;

Nit: These can also be assigned at definition time.

>  	vofs = 0;
>  	for (i = 0; i != num; i++) {
>  
> -- 
> 2.47.2
> 
