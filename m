Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF4CCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 17:26:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C5484025D;
	Wed,  1 Oct 2025 19:26:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6A347400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 19:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759339591; x=1790875591;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ul5SXFCJL/Aq/+d2RVU1mOupddeyB9z7deshsKjfRl4=;
 b=YEXCCvT5nAJ19vyQ0mjEg+W6A7Tr/BGPt16XkEwRw8PHhpgPVqGGMXmk
 MZxm7pTuF6UH5lC58BFc6nwf8zSkDm1k6qjEkX7MP0wkzqSEl0z4CRooa
 U/z60mDJMASxf5bbIn7LUGVQnC1hZepvGfOF+gp9XrPH6zr0fgdZ9GkHQ
 ar30e9acTiU3VY5e3fF5Z6uk6PK8hK6aDmBnRk775A2KMYkCeIL2UXV3R
 i0DoMGSAYxAo1aYl4mu7DuXI4pH2wqkNmMdBGdotNnYtJ4jAzHwdf5KoC
 JYtm/MjN+7gGZC6lZJYUSJMMHertmzcEjLvEcYUtHg6Yzwu/aaC/WDSe7 w==;
X-CSE-ConnectionGUID: 7THfXgCQQXG1TF2QlQIq+A==
X-CSE-MsgGUID: ZfLc9IktRLG6d2cYXl3BNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61786176"
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; d="scan'208";a="61786176"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 10:26:30 -0700
X-CSE-ConnectionGUID: +k/Njd40RyGc1v2YIAzooA==
X-CSE-MsgGUID: NKiNHh8rRxmc7eYr3qGQLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,307,1751266800"; d="scan'208";a="202555069"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 10:26:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 10:26:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 10:26:28 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 10:26:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOsVSYmLuGWGVyj/2PrQO2h5k3Qex0vRXqUMHi4AB1zJYoyGdabIythiTP07M8VJZBv5Oj6wkP4XibpjE7/be/XCmE8+dejNhZrTpv/VGEG8MXJQLEYRu1wxEa5mHxYg51nngLIYAo/BeyAb5859QIdrIvXXjxybHwuImJQ7FL6SyGD1XLbHMZSCLZbTsnWmn9bQfl8JvDw0x/biApSGRzsp8at7XTAAIl4YdGzohkhWhnrezzoJB6f5aVU7fXRCjDfM61PH0sjmlFpxb0/jKYMgaWHWgAq03z9SGcmG69PVYYJeKP+0TJBSPw/+WP0WmV75Or36OskFACXlo3LXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzITcop5W8mSpmi73bpofOM7vB/WJ8U7Y861+3wG1PU=;
 b=XIi6boqF86IXmHbJUcB5c1I1epCKym/QgigFIany98VVccux5NDYY2Cx4tWkmq2qDNEt0+n1WTB8Rp0zNO0j+7l386/gaNoqCHvJxuAfuc95/tr1BkwZsAcsOQ+5o6Jke1Zb812LwhKab7QyCp8EUDFwzeLYRbqooRtH04dCtdrx5wzxmqAwl2DT7yD2qAA4+Nsu7Zo8DmolTzqnilYLRaVC0d0yp1fIcazauJK2MUAZ6CwjJpQMAeIW/stRlcn0+YqVVPkyUzn5kmYlh5kHuiBUXhu61p2gP24B9hVL5U04apmrTdK7JsDmjufu/A0hcaeQJcdXdw+6waCF2ev00w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by IA3PR11MB9399.namprd11.prod.outlook.com (2603:10b6:208:577::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Wed, 1 Oct
 2025 17:26:24 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 17:26:23 +0000
Date: Wed, 1 Oct 2025 18:26:18 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Kai Ji <kai.ji@intel.com>
CC: <dev@dpdk.org>, <gakhil@marvell.com>, <konstantin.ananyev@huawei.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <mb@smartsharesystems.com>
Subject: Re: [dpdk-dev v5 1/2] eal: introduce rte_timingsafe_memcmp() based
 on OpenBSD API
Message-ID: <aN1kOkcrpiC3cjj5@bricha3-mobl1.ger.corp.intel.com>
References: <20250929145049.153078-1-kai.ji@intel.com>
 <20251001153242.55987-1-kai.ji@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001153242.55987-1-kai.ji@intel.com>
X-ClientProxiedBy: DUZPR01CA0223.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::10) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|IA3PR11MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa406a1-eef5-4a84-27dc-08de010fa4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C6pV8guRtxfnwu6Ilm+x+UPycATigGbgaK2BuBIJjJp0xqjMdtapL1SQoXA/?=
 =?us-ascii?Q?Jr8jsF5H9zmHlM6U4sjYOkbm1/tjUyc8LI9C3VIAb4ktycvd5cE1zwtcwMrX?=
 =?us-ascii?Q?3wfyO/wPLrtKmPNBzSAEeVQ/oiUa40CaASmEhvFDpRF5AiXN2ygvifUmbnhH?=
 =?us-ascii?Q?Xtzw2SrELrSKL1nHQZ5r1NizQH6XBV1iJcuKoaNZN8J56SQegMXwzXCipKwb?=
 =?us-ascii?Q?KmRhrN2nvdqoHGqlOb35DTsedxtfHEqpNL0evudvPx8XIJIA5QvgCJu/BmVF?=
 =?us-ascii?Q?rU6dWpDob2H7F1hG2XkDZ9sRnxqtVQZJEvwBag7TT2zNap/NnM6SwU95AAwS?=
 =?us-ascii?Q?FbKMoNZVxECkJPEe3G/y81aUaV2jxlggeGT1IkWx4bOzF3hFQa0DT1PZ/D1Y?=
 =?us-ascii?Q?/qYy5xKEJspUEVYVa+SlHJiPaXB28QFO737eOBv5yvnV184QStSWP/h2k8Ys?=
 =?us-ascii?Q?y+zloWRAROZdM9hJOZyO6p0pLP1TxSbx0C5GlaLSlfTBvLP7wejRZ4Rqf8vq?=
 =?us-ascii?Q?v/jTc0LnRk6o5NyXdMzlWwk128smWjhHeop+ZseGd9vb4rNbBGYBwUtgtchT?=
 =?us-ascii?Q?db5ITP3Kbhw9M/VEs4KYCmgsn/gBSeaWMOd7l1GbiIhfvzMu0ofoft2Avvmx?=
 =?us-ascii?Q?9vwbA8e33+swPtUhJ8NLcGCg+rl6ONK7BuyRATiNvU+fuPGBK/JNlUQZWJDl?=
 =?us-ascii?Q?TlGiO6DSqLK4bbNg0qT/6K9ftk40g/bjCaR+HyovZGknmcVaCAAUenQ20SNk?=
 =?us-ascii?Q?rSp9Whyvg/J+ldyefKHWkqbEkRWapApJgv5W8qrz64t1ZxyS2nfulXpuhEt9?=
 =?us-ascii?Q?XTZh+6pQnfTJvE3ZSI6DXxIEayMhOcCWcX8akq7G6WNKZUBGX671GH/PO+kf?=
 =?us-ascii?Q?mwJqsp7S9iM/sLovO5LhKX0fbPQjCat1jS2vhScvbT3znfUV1M2QOcV1ABc0?=
 =?us-ascii?Q?AGmqoGLikXKzLaY5lC2XJLsYPj1gOB8Dvigv1R9PBTj7YOYhHnyEGAkcz+1/?=
 =?us-ascii?Q?e4EgoTzse57zNpYNhQ2iL5IR9vbk+lGDMuovIpiub62axFv2hBgPZhJUL2ZJ?=
 =?us-ascii?Q?X/TjZu+yhWAle3u10XWkxUxrxmdeE19Qns1L77vGWtS8K7sPmVnskC0Qf0Yr?=
 =?us-ascii?Q?b9Nr0YZ0xm3N8H4fGS30tJMyVGFwrRwEYMdyCIjQLJmYEIN4PDaHgghrrbA+?=
 =?us-ascii?Q?WYI+R14ZYJxjqn/kEIWrtGdBneRuQppp7ceMUUdMgXZ9yhiTYB0QeEsQk5gW?=
 =?us-ascii?Q?8Ahb/mPfP5QJfEEu+CF7LsLbnm8aZeqQsMhgGKT8ViltoFpc/ZufZIxd3Dbf?=
 =?us-ascii?Q?PwAGjqFBzm+INY8d8Q4DBfDr5ws8qNV6Let5JLHrC0DJTlvIRgEAUzHgfO8U?=
 =?us-ascii?Q?hUSCefH4RbRMNWchpRBneEujzDqo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aD6TRj/9soDNlwd1NdcF+C2dgKDa3i+H3DARQZIjbfkEfQUcSmg9uiWYN1f/?=
 =?us-ascii?Q?K75bvFRKch/efmG7r2TPijgbdfCXO37YR0qArI3XD0PZPw4xGGDTSHwak+qu?=
 =?us-ascii?Q?lhVoK4w1mvYM6sgAOyfqLKyk6zFLkGpTUn/MS/TvMHepT2tdzC8QZiDzz2S+?=
 =?us-ascii?Q?3c/sWikbWTVXBOm8Mklz+bqW2ya5DcqkPDRAcaXtiB1F2G1fS163yQ91j2ty?=
 =?us-ascii?Q?eE2gZddwsH6dgAJBFB7jKjwUOQyHdpQGrRNEGdzcxAssteCfdZHp4MHkx6US?=
 =?us-ascii?Q?woTQV8xmUi92AETujFlPLN7uZVhrwBfQn0gHA3nqXZ0VJrlISY1KRQMf5m3v?=
 =?us-ascii?Q?vBgZ/E8yCQCIv23snBWwpterAC1Z2mzyv2Pwqs7dDipJtWmnmrLiOYniltsX?=
 =?us-ascii?Q?AESo6d3sbsZg4zl7d2ZYckzzjxZs2ZI1wQx2Ue5AvhgXpnwM6ZRNlQ+5zVfQ?=
 =?us-ascii?Q?aJnpuOuclze+6oZM8P8Kd0Fs1sr1mniVzkC0bw6j1p4iUg5GZzcAf43KUy+x?=
 =?us-ascii?Q?MTjULv10WmqPsAikYmsLQudzSi8syvdIid6A7lPN6j3UVPJ2+hIzp76LeP1t?=
 =?us-ascii?Q?c9s6+vch+R4+JuZOdSfzruUK2mrpUjmXb5gppEs8uWEBtVT9CnBGJKN34dCI?=
 =?us-ascii?Q?9jghCycexuZAGfBS5iffbM4aV0JuQORdF70aGVH8dKpWfQPNjUZYQMWh/hAK?=
 =?us-ascii?Q?u65t8ODy51g9Ag3jjG16m0vnC2RDYJMA9SoxS4OqGrgBYDlQP4clhcn++6nq?=
 =?us-ascii?Q?V997BrIIU0p2TNrlVmi9ukWVykdxinI4rZMIESpkj4P93cAH3cULBajM8urV?=
 =?us-ascii?Q?Wlab8essQ3xWTSC/Yg10DfzOVEfHu8kNQb16imFZElK/68hcb0w03j5eU8M7?=
 =?us-ascii?Q?Oi9v9djgiIIJA4y5SYaMd9FnG2UxFHaCy3KXbltvN9RN0LlQzpE3lawFSC3K?=
 =?us-ascii?Q?4PZZbUzkdnoVwmj7PmmeJoEkOfANYdSjnpBP2VaAuX+gry5U/UprenIIdQYO?=
 =?us-ascii?Q?OMzkf3qmqJ+aFe4Bv36mihFDhz2yT6Lq1kkwpsvIJpLAA0IVPzKanisGrEvy?=
 =?us-ascii?Q?xwQZhPwcsc7SpD2YxPKCUZrFE74cbzxb/uTEK5zIWEUMZlPIDmV6VhDOTkB3?=
 =?us-ascii?Q?SyLdHiuxWUzAKlaG4za7AxixYZppvNjE+fCN5I7OTf6tvc8wqAzS9EY/gunf?=
 =?us-ascii?Q?rqeYISrjA1G/Ye5AgjELYoetKpTqseUY5Vp1es3lJh+SIDZEwkMv1JE/wPyC?=
 =?us-ascii?Q?XPqkfFSthNleApXLL1R0JedOjTg5IMW8QXB8y5u4dJPHDbSL+eODlVL5UtKs?=
 =?us-ascii?Q?j5ZnDu5ehOiurhx30Rnic3caBl5ZdG+kj/k5232SgjaOoDHvzs5dLyezp3Rp?=
 =?us-ascii?Q?ikNJcCIVLxWne84lzofAr6JnH/WbBKaplFEm/jptIeUxMwEalatmVh4zqanE?=
 =?us-ascii?Q?HLJiPM6Jlvd9IGjtrxhV6RvJH2jpivh0Y5jL5tVL1ygljKlLU3g8mtElxgQR?=
 =?us-ascii?Q?YVfe5jo86TYvQsQA64p9UAVLr2R2QpKYLixicqgNSP2r5JUHvLmPWEKlgzvr?=
 =?us-ascii?Q?GUwJOvkmpu1oe7sxhwALyAN56JaEYMqw0arn/9cEzeICGarQK0P3yKiaFYmN?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa406a1-eef5-4a84-27dc-08de010fa4e2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 17:26:23.8574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhDsmhat5Yyc8VEJfLNYzR5W6B8drcU5ecthNh0mOc9c7xe5bZeytLLvxQTjVihHTla2AtkdWBDnX2qigbRsn7L1S4hDMoOq9Q2qkN5TSuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9399
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

On Wed, Oct 01, 2025 at 03:32:41PM +0000, Kai Ji wrote:
> Bugzilla ID: 1773
> https://bugs.dpdk.org/show_bug.cgi?id=1773
> 
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  lib/eal/include/rte_memory.h | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
> index dcc0e69cfe..6939c1caad 100644
> --- a/lib/eal/include/rte_memory.h
> +++ b/lib/eal/include/rte_memory.h
> @@ -746,6 +746,44 @@ __rte_experimental
>  void
>  rte_memzero_explicit(void *dst, size_t sz);
>  
> +/**
> + * @warning
> + * @b EXPERIMENTAL: this API may change without prior notice.
> + *
> + * Constant-time memory comparison.
> + *
> + * This function compares two memory regions in constant time, making it
> + * resistant to timing side-channel attacks. The execution time depends only
> + * on the length parameter, not on the actual data values being compared.
> + *
> + * This is particularly important for cryptographic operations where timing
> + * differences could leak information about secret keys, passwords, or other
> + * sensitive data.
> + *
> + * @param a
> + *   Pointer to the first memory region to compare
> + * @param b
> + *   Pointer to the second memory region to compare
> + * @param n
> + *   Number of bytes to compare
> + * @return
> + *   0 if the memory regions are identical, non-zero if they differ
> + */
> +__rte_experimental
> +static inline int
> +rte_timingsafe_memcmp(const void *a, const void *b, size_t n)
> +{
> +	const volatile uint8_t *pa = (const volatile uint8_t *)a;
> +	const volatile uint8_t *pb = (const volatile uint8_t *)b;
> +	uint8_t result = 0;
> +	size_t i;
> +
> +	for (i = 0; i < n; i++)
> +		result |= pa[i] ^ pb[i];
> +
> +	return result;
> +}
> +

Just wondering if it's worth doing:

#ifdef RTE_EXEC_ENV_FREEBSD
#define rte_timingsafe_memcmp timingsafe_memcmp
#else
...
#endif

to use the OS-provided function where possible.

/Bruce
