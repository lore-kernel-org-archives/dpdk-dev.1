Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABD1C982FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 07:31:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82B7C40262;
	Wed, 23 Sep 2026 09:31:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2E72D40041
 for <dev@dpdk.org>; Wed, 23 Sep 2026 09:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790148673; x=1821684673;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=t4Ehv8A0XiohceBXNdFVXKNKF/yFBk1nBTCdT4kaM2U=;
 b=DEj6Q3A1VMUJF/Q9wD/1CEa0MAbNi0nLyk+TsitmWpp0HGO7DAG+shUc
 KXcpw19YDhidinJF7oH+qiCiHoINcCxfF8uVq/34CSX77reudkAi7FDQz
 IErXsJlSoOC+uVEhzp7iS3t3eN49lXE91pYT1xxhX51i/cm54gVSDkrsB
 GlUdVK0fABAMfTWGu5/YWeVj7VjXlqOFmBXZR9qIgQkZSTyChChBOmWFc
 nFNbWPb7GSY/AhWIy55IKBFm2SLzp61YeHvgedXJstin9mIKRmMnsUB2x
 2RuxDYkJDf8cXWuxIyLl2XZ2ZX7qnXZl9k9Ax8a0FosB+UTaF2E34aMHj Q==;
X-CSE-ConnectionGUID: p9Yaey/JS8mzEZ+mP9JRqA==
X-CSE-MsgGUID: YTB9PcWJQ6OUWQ/O0y5lYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="78369696"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="78369696"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:31:11 -0700
X-CSE-ConnectionGUID: 1wz/uZUIS5KFiLNKcuK4aQ==
X-CSE-MsgGUID: qO2gB1FITm2NUDuHL9TFaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4562109"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 00:31:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:31:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 00:31:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 00:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV+M5qttRZJFt4FHS6mF+mjMLTx9WEfNbom3+7eRDjc8fQEl+elaHh6PfEGpzgzZ8k6x2zhC5g5d6UUhy4Zpghrmfkinl7QDaHVyK9PILUZ7E3RWYnabD0Ez0OkrjYg5nSqkIyeOXvtL16WvYUsr25YVWsFM0kMwnPpc0kgUEYbNk+pVC/bREFGeNB9sqFUX/aTpYCljak8/vlJar35r+daaWIhjGEdTifykRYjpoSPx3sNbMiNfQuj4p8DH8fVq5fsp/o7eMpn81zhr4DMVWmzLUxE2ZMEw7AiGet5EaoYfrCGXNqQSMpcEN4HnUZB/xWCMx9l0q/GcSMcatRJRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9Cfw/zzH6QFe7WYG7srbvgXZJWW9ckf76Fk8mcmxX4=;
 b=lyiKd1vEDFBl7lvFhQ5SJrms8fjhdgRQGxiPhvJQr+m6hkuvdnKMxtkLxvKohIZe6zl9KOJrpUUCqwzvN0qUGl4RjqytydkpvNStU9EMltsLQEfnWCW5j9ACXKQ+kVI9K1x17qIQCHECil0dVeIJjoIfCYF09vo6fAOHoeYUnwcb1D51QZlVy9zQCZyov++BHwXF21wSqdiA1fa6BJBkaXrgEoqo83Z3r/FcuxZ+i799OZQQBvuvV3tok3bGjfCIreA3jUcwcv/lj3gw7TjCYnvRhFtOLgXQua6JblGVKHG4BCft04xgVVYPYdoThVZkFNxdIDh3oxnknYqbMI7Ubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW4PR11MB8292.namprd11.prod.outlook.com (2603:10b6:303:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 07:31:06 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Wed, 23 Sep 2026
 07:31:06 +0000
Date: Wed, 23 Sep 2026 08:31:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>, <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: Re: [PATCH v3 03/16] net/idpf: use common division round up macro
Message-ID: <arOANK0AxVwedGPx@bricha3-mobl1.ger.corp.intel.com>
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
 <20260923010742.2468145-4-joshwash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923010742.2468145-4-joshwash@google.com>
X-ClientProxiedBy: DUZPR01CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW4PR11MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: eefb55fb-f4bf-40b4-df0d-08df1944a0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hh403M1/goTYFmHKKUKxkiur9w0JhzoUzCGUDzWzV+rpQ5OEzrJD1OyZUUCsOV19rZquuwq1eLJK2zV1Z8hx4b7MdNT92K8M9SNyzRQEKybjtWm+wfsX+XHKTUSNiSL/pGEXLBS5WzSsIpsxj8Z7atCeqgdgIbioNPVCXKsH4/gp0Oj283kalHK+HuJHDQXi6YP7UCPKk5ws4g8VIK4/t6HPdB53M7lBfs8a7+GmPsonINAX2uHuuebeQb9Xk/Md+N5B2tf70F4H05mj3vU1ARUdBFl23BASaNe0v98+B1+IkxUxw5Gc6m/hHov1qsEZ+w1Mh/99ubzDzsW36qvzhn1InJvuLq4szgS4Kstf0kswrSy3OMN37qGto9fEYQ2YaVPZLFFeW6XJNAErM6/FgsQIsVtMNwmXHf60aqP2SgS/CfdHw+Xq6Q/JdhnByft8QYXrvzg4qBDWoOBdD0Ild78wBoR2nfa5TZ73Ra8Rdbvd3dDuHECBV4kB6Ps2IaZ9zy2MGtKOFQ9diuAMXpLXfvSOxGuLa1jZQ4cpGdWzoaMuj7+CsW8TPyURKh3+B2SPEs8LW2bGMtylBUfzn7iElPR60rCtJz5bZ/M6C0j7SnFAClJ8jSknYb3qYzEhpJmthM9WS1vRrc773vLZYb6W/8oDCnpyrIalxvGa6H8Cjug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzwtlWUaIN8TAd9Sk+4s1/NVcqrk5sLonLOrBufYEsRPp3RZ8ZUhESqEJFSf?=
 =?us-ascii?Q?9ziXGo7S9O5Tqd0w9akoTlla1cbpIYmafZG3/KIGpvYEE3yfJQGloK6+npOd?=
 =?us-ascii?Q?giXnZ1YgA4DYOfiniszGprmLsVEfm7PjSZnNtElG7zk+/VYxuTgw7nzWhJ4K?=
 =?us-ascii?Q?er8vPTTi/EGHKvz3vtmmgV/+dQstgw0iMncGUerDg+Npoq/J5WXNJCa2vBeZ?=
 =?us-ascii?Q?itSjfJj1B6voowPLmw2zxJDELwCmSS4aNGdkF14uhIX1Qa8RvdZ3qnXIWg4g?=
 =?us-ascii?Q?QSQxrQfiBKo6GeJZa6J4jdqYmRZkJXs2UN7g7vXoFR9cXYYRGrTa5VfEhAPb?=
 =?us-ascii?Q?It94xCcoBTBIySzZc8wTudSjuHLSTYP38sqks0fARN5FKDxXB1cHf2Na0xzP?=
 =?us-ascii?Q?XsRSt7QyOXkeyKxOfYjOskbURpFn+hDDHkpqQjkeyMvmnmlrmQzT9QHAR3rv?=
 =?us-ascii?Q?1sEsWF1aGMEZlUldnfWXs84ZJCZqLDc6klSegoPVU7b2Ah3fn8rrFpHqnVIY?=
 =?us-ascii?Q?2UfAqi50UA43+IdIUd4MzFpgVjQkQcbMxS3YyqP7bt5P403hFS2idXLZAZNY?=
 =?us-ascii?Q?43KW9ERQNUTj1K39KtT3tnrpZtE7tHRpDaTBidQeTL6nEkmaGO1voXVbxBLm?=
 =?us-ascii?Q?14WWPNASi8aepCJA1sP5wiqDTyqBPXFvcwn9WvI/Q1pGEnikApvAqOsB872j?=
 =?us-ascii?Q?8u1HdyvsmAuTmoa1NSykUnXTA218dwUDwtKJEy23QKZeQ768DIN76Vj7oT1w?=
 =?us-ascii?Q?tNInCv5ppsbsATKtPzkgwFdGjtEfnRgvGEGxeMT/dVHBG5pMDFyTd9rA4rhB?=
 =?us-ascii?Q?abTKf4KqEPnOpIqU/sziO4mAjJ6Wg3zQKBMexQXzpli7D/+8EDw/4+bqK+8F?=
 =?us-ascii?Q?CBaeBVyzNj1jGZSLhaKN+CVM3gCneZq8hxWYa5k9m61sY3lOFRei9tanuO4v?=
 =?us-ascii?Q?E7iO1kquLQFpCJVZGarvLdeRHStTZEK4ZQgLMEnhTRq4EZOc29jYQ0Y6PWn0?=
 =?us-ascii?Q?RcGPywSRnC+qRF5c5IR2RZbhn15MlqwiNy8H+4fCAFS91fLni+nRsdNgH4zV?=
 =?us-ascii?Q?OHgurt/TmpeM9xFv1tndmaTIRwgESO3PAmpX37uzvF/HrGMGArQQ5zr2rro/?=
 =?us-ascii?Q?6MBRA7YWTtWjZdENf5hf6cJ0moX9Na1gJjn42jW3QJIeogV33VS0HTK5jwHH?=
 =?us-ascii?Q?/AQQ19dPwHSAOv/hE9nPRJvG+yvnK0il/lGVdYeoVwXMGemOjCJlVB8E5xrc?=
 =?us-ascii?Q?H0exnRY6R5XluDoIzbYmsamx5tCjTHZfKkthmWbJexdjlLnVnH5TJ1MxpCra?=
 =?us-ascii?Q?XQxDmHBg5NsufcpnPlWtNlvEjn0thyCetYLfcxzrO8wZ6KMK0n2dBt5Wjh5A?=
 =?us-ascii?Q?NowJzC3Jr55qMiKlueIOh/m5x9K56d30DAUgWCtinQrsow5feuOibnJdMKVM?=
 =?us-ascii?Q?i2g8dIBscOCGgR3oR93Gu1KRglKdaDhdYxbYPEv8sk/kgygBsDg/2Ymy5MYb?=
 =?us-ascii?Q?ytzNpVY/CX7USofp/7hMfT9OWyTBoeoL7XYRIBDC9HsfE0pQZF+U6HeQQAuv?=
 =?us-ascii?Q?Md30yrkDNTpwtNrE/w4sloWk1I6GSb3JSjLYsOBK007ijltinqjlRvnVozbC?=
 =?us-ascii?Q?u4sxG8BcZtDQTPXQK94cCSvmGXtQyWXVWdYSfUS4h6wozekHtzSfhd6hAz2v?=
 =?us-ascii?Q?rPxNmGvw4ntaUMc6nsxTxpRkbVyHVwSjQ2JZteoEa3KPtQjplM7eTDiaDfL3?=
 =?us-ascii?Q?fzk7jqrFdCHHJ+cY3uSSTxg8hfw5dPk=3D?=
X-Exchange-RoutingPolicyChecked: k5jyxsItvwfUTE6lK82JPqR0rJht1JKRlWXVwSCEqRcHNlanEJAeQRAyguclRL8pgnepRoN8WzrfCGS84Y2dDizzv4oikNHSSJEYnxJtyqLXRRCgqu/8pUPL0l6nOhvFfxFwYSP2VazWZnMkKhySoJouTkF4m4HkzgT//93mDbDPIGNSeM0SGyADK7dKoDDnfXzhNqo0AmGRHvm7ki17i9VODJ5SZJflDyidmrdDayKJM/3YIbwc7sJK3wT7CMnW5UEycPTthk0vgLGOC0Aa7o0hQlsQCC+l1aQU4GxCuh7+GlWMDSLZXOZEV/naipTCuDvpTV8Gxyaoz0AbOpJ/lQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eefb55fb-f4bf-40b4-df0d-08df1944a0e3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:31:06.1361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1mBsfhZZhvm9vTnOJCH3HjCMW8z/9M9sAAoXxZznZVPtefHNkJvP2hE2+T9prx/yqluMLwE7kF+Zth2nQXFmJ5RW6VkHSXf+u1xGX4MijU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8292
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

On Tue, Sep 22, 2026 at 06:07:26PM -0700, Joshua Washington wrote:
> The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.
> 
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

>  drivers/net/intel/idpf/base/idpf_osdep.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf/base/idpf_osdep.h
> index 67bc33f2e6..64bbd00eea 100644
> --- a/drivers/net/intel/idpf/base/idpf_osdep.h
> +++ b/drivers/net/intel/idpf/base/idpf_osdep.h
> @@ -291,13 +291,12 @@ idpf_hweight32(u32 num)
>  	return bits;
>  }
>  
> -#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>  #define DELAY(x) rte_delay_us(x)
>  #define idpf_usec_delay(x) rte_delay_us(x)
>  #define idpf_msec_delay(x, y) rte_delay_us(1000 * (x))
>  #define udelay(x) DELAY(x)
>  #define msleep(x) DELAY(1000 * (x))
> -#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
> +#define usleep_range(min, max) msleep(RTE_DIV_ROUND_UP(min, 1000))
>  
>  #ifndef IDPF_DBG_TRACE
>  #define IDPF_DBG_TRACE	  BIT_ULL(0)
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
