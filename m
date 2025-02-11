Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524FFC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:05:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6077E402DA;
	Tue, 11 Feb 2025 17:05:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6386C402C9;
 Tue, 11 Feb 2025 17:05:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739289931; x=1770825931;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=aLARl4l4AqIT4tn7hZmLEwihlodAeCkoMAmMugJqg7Q=;
 b=BRir+0PY40cF1gUUAqXglqCxeAYtBn5ZrJsEn8njmk6/QfZVSvQVKU8y
 SgOK7wdPEcMM9SEHbyrt7KRpodOng4ZNkTNBQcj5tXstHSUy0G0UsGJpm
 dZgIdKXrq2sFlQuEsiA69N/0qq15NDETv6iphPHBaUV2vjNywssuXJzsn
 z2DI88yj66p6irPJMKkuMgnSMN9PAKSLgP0OmSPOPGxsCd7t5HN/15NhX
 hBz07JZ1fGTQ7fK7dXIpXyqDXF7uDy0adIUGWqW/q43fvO9l7ehFpUnD3
 tHpwzTmLZxqKnyTP3mFlg99aSd6V5JxKeKanD8wm+Jini6H8Yr5yi8yN8 Q==;
X-CSE-ConnectionGUID: N7/vYT1gSciEs/oHpORE5w==
X-CSE-MsgGUID: qluJ+glNR/Wxu+/SjQxb9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39779082"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="39779082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 08:05:30 -0800
X-CSE-ConnectionGUID: 76SyjOjyTFO3KBzmQEbDqg==
X-CSE-MsgGUID: RBMhkpvNRsixQgnKQtVhiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; d="scan'208";a="112315015"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Feb 2025 08:05:29 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 08:05:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 08:05:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 08:05:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkQtBy+pbh5vs51U+67+z3Mm7f/keCM0CBefU+Y3hax4EEvwkOTqdrbY240xPreGVLSoERe1gOGqaVf2FGQpDsQvKW3ydIBQijqBCaE8bXB9YT0vgFxTQKn0sAFiVNXb9TddiWoLmbYi9fjVXT4/i5wwZwypmu6+RLnJtLhrtsmnnCRm424GvsxKUMdPgQJvLu4koh1FgcyNqOH/0vf7ql5lQqhl4Zt0tG2qa4pPi3N8f3IIm6qyuaHWhVwP/pB6vM4hS5Fs9IWK2/GPAV/CRWgQfyQ2TpmtKIuV+HlTmRvD5tH52gFfQHIUAPkWdY53oIR6DUTHLvbFgHs5zdq7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qsU8XrM4rIUFI1Y0X3aWZTdrE7LdMPPUahF1cPexI4=;
 b=bQ5v0aZJMHxJEikCcU6Io+/HoAQVLurSFeqZO6KuqMJNX5aaRkMj0EZo2BzYyy3jwNe9vg9Ps3LIENWD6DDjnahot4+c6RXS/4q2IEeSRn0uzru4llrN17Yy7WiLQRtejVGuiD9n2Zt+xwmdKFdXSIL/KCHu9qcUS9AbOqFkQyLXv30WUGZ/lfUX+SIjEQg18eMHL9jhKe1BCkiIfcUMATOevIhOXIc2uSvk8MgmquwU54No3sNl9CwANEU/mmTnjbN1HsEB49m4uGs1Sls0RmONpQr0dNkUae+yOA0jh1Qw2ajOtEtl9NrY2jCbKRuzV/O7CS54rhys7crPdYt5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 16:04:56 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 16:04:55 +0000
Date: Tue, 11 Feb 2025 16:04:50 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Ian Stokes <ian.stokes@intel.com>
Subject: Re: [PATCH] drivers: fix build warnings when using icx
Message-ID: <Z6t1ImPGPF3kpIpW@bricha3-mobl1.ger.corp.intel.com>
References: <20250210171957.1670913-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250210171957.1670913-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DB9PR06CA0011.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 228e7bae-6955-478b-98d3-08dd4ab5d3a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4VIDr3ndWGxBgDckTp88CEabn/KggMTktNWTxouJDPnhHx6qv9Mlev4DyyY6?=
 =?us-ascii?Q?cdOiKqd733phwIyyq1TqE8ytphD5EbjR8Jkq/JvmnB1oAPkvLsbxkT98Rxya?=
 =?us-ascii?Q?ztNQk1Ho/VhDJyQX76DJQEa8Br0VMa8VRgH0fybrtahZbBH1kH8NuqwUIw26?=
 =?us-ascii?Q?FTt6wlP0LdGeSIj5GXiQk9ULGklv9LWWRYdssSpqMHr0ONbC/Aamb1H64kEB?=
 =?us-ascii?Q?yyjxA5HOsdMeaACj8SAud1ig3yWqy6GTPcT4zWgHCiOHY/CJYMrzl88vCxBj?=
 =?us-ascii?Q?mt+XuS4Riv88kIkw8QWZPD3sXoOv4VQ7WAhE5H8cPSZuWw3Y4gzTKbQ8/4cO?=
 =?us-ascii?Q?QbZft2xO1dxYLBd5MBFPiQho7EoY7SbZJdNnXjHwWFsYBlbBESrI1po6UR1H?=
 =?us-ascii?Q?VgucTX0x6/I4IB/hLRyIAgXlh6cPG+iB2b7EH6cgVxNEmhsHaQX6XTACTtc4?=
 =?us-ascii?Q?aF/qmg8pRTqwOfaeebmpmF1ZpUlbt+nMg8KV+DhwqSikkzw8t5+8Xcj2v1rb?=
 =?us-ascii?Q?nMRjlt6mVVSP2/EZfxBRxb6padgp7rJDVMynm8AH0QNWm2qQ92p1uTtY/Vfk?=
 =?us-ascii?Q?dez1k8Qco+lyB/vb3yXZNDbEcEVCoPmuaGYMlFuuEDYKk3USDEcXtCawRUag?=
 =?us-ascii?Q?EV/BLnzvSGX868iAfTICOj0rauTdTQxts8xEk+eLxVq7+a49djd145barNvt?=
 =?us-ascii?Q?ssJIZFxInosfwRCAsuUdqoANDdvYQWv/Lwg2d/nzgFjyxznRW0sjoZ6EghQ4?=
 =?us-ascii?Q?N+AbwJN/vHXF77FoOgShHbVpFWBpz2uStirzbOhe2u0ECGKDxTONNmnAmLaD?=
 =?us-ascii?Q?mC6HlvkS5kSWKR7aa4F+RmdRAY3Lq8X1Uhmb3b8mJlvICC1lJtR8H8lNu6f3?=
 =?us-ascii?Q?DiwtSR8HHh4rYCp+vaWHrUBtYid3WlljeE23JjgB2PhmQJ0CtwB2xHDKxa2X?=
 =?us-ascii?Q?LNrSpRmLlnyt/dHJ4u7acQw4D2ToGNKJHxt3QxYTTyK2JJQ2hFu2+fYdKuoZ?=
 =?us-ascii?Q?H6I1NAykMAF4LyTBP7x7KSWOumqezvgC/Ka50Mj3HP+pExfR3Yntbg/+TBwL?=
 =?us-ascii?Q?xxR9w3xiuC1AjGi1bSbU3X+BXmzaWHBMpPZ2Oe5WEXGspZL4GJMW/E3sJ1gF?=
 =?us-ascii?Q?kY/xek7XB9RIvLvIxgkEpflSEgS7BOWXIVlnjAtMVF8kfGakM6l5ksxpzXE7?=
 =?us-ascii?Q?XNs/hPj9bFkgfNibkSWtaLpQP9NOSNK+6pKnKXNDTUxsupDklWlzqa+HoXi0?=
 =?us-ascii?Q?iISW/3xzWQVlTeRQ3dN8tZu5DM0mX1E41nnghMj+NuhLgB9VOrUEE9un7QMw?=
 =?us-ascii?Q?pZ9C/h08gDeV12cEasy94PEYw85nAsqbQDvPVManqwVR18SyPq7zi/X6wT9q?=
 =?us-ascii?Q?y7FnK1wPF2EYSQ/X8O0qyNsCHZGh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?URSMkus1AnVnx1HMbnoBuLGIBXfYSzBwxEVxNCaA3mKZ7dldRCzqvXwejn6L?=
 =?us-ascii?Q?qnECwIS+qMaxmKf6EIa+pFagwGw7kDrjUSNFQkHC6pxBDMt/3YMRZmIbWfPH?=
 =?us-ascii?Q?Bsl+fTBUNTFWL+LPZi5VR/o1+ZqhQVsveTP/bVxvxt8rahB0Umjf9YdayCi9?=
 =?us-ascii?Q?k4iTGtXo3rjG6YF9JopTJ6ine4Po3E5YL533xYoxX3FMNqx9uM5yZKMEVolt?=
 =?us-ascii?Q?9SXW3bIs32O8sQfluRn1TSdTy1jiGmSfp2PC6qz7qPiWrprrgwdzF2vkDv+7?=
 =?us-ascii?Q?p216LGeWjkWa2KVCk/B9r26vb70KMkJbGTNQZix3A4K9iXiAxP2MzpGBYE0q?=
 =?us-ascii?Q?s8xEsmFEni45f4JFt+7gfWc9pHiUT3hOUVTZzGM40DtWWUK4LU5fp5yvpvb/?=
 =?us-ascii?Q?lAIZ4moS9Bqz0xody8Qx1UEZIr4IY+pbmNTKnYt3xSOm8TqbiMPKjjjune0j?=
 =?us-ascii?Q?O2jiXaBzzt0RxC2SOcjfZsUZJAoBOkt0Sxk6OlKnA+b5leeJssxBoJDOGQ3f?=
 =?us-ascii?Q?eQwyNotxJ1TEW5z1znLOVzgQXR0HhDMLVNQi6iOf4rYzKlqfTN7uuw+UfvzI?=
 =?us-ascii?Q?iN76SH0NtUeGQ+7hI8VJ+cjHSDXaYhtjUMgcLK6Q4Z39sx1Nt30GKjR0WFbM?=
 =?us-ascii?Q?DtLqr7Ydso/rU0RfLkCHLie55R5uBBAtJQoK9Z7ddgYFED7AKAg8q+R1W3Gh?=
 =?us-ascii?Q?q6eggAix5sZdPbRFabdjAhak2fPuiX1hxBnNAol1wcmDy8MKYgcg9pE37KGe?=
 =?us-ascii?Q?/7d7z7z0iVpb+AA/OLgf+RT9UmcUSqMXwtHttHxzCzHk+UYvv9MGy5cfXwdU?=
 =?us-ascii?Q?sU3V6q/RVsVIdMDA+Qf3Jh+44hAtcifWNKh+tpZAkxPTV2jrhuRRk1Q1Mbn8?=
 =?us-ascii?Q?hWzU5SypOmsxWcqZ21LmCKGQFbUuIZAOgTm8QOLJZ3VnGOh5wjclJeMYVGeH?=
 =?us-ascii?Q?87pGGq7qTpkgsmcIL2KFw6ySYsMW9AAL6h0w+sH8WLzIdMgn4fRI6zrpE64h?=
 =?us-ascii?Q?Onh0VqHPbpY51snJNYAw3kDpVnGoMBucCOYDA3tfzKV0I38cedfRYnM63TUm?=
 =?us-ascii?Q?e7oR3DpmEZ21/Y8/Ij43siCUcnSHRAC6igvqrT+nsdnTjnZOVm3ts9ZnRzBG?=
 =?us-ascii?Q?Qq7ZtsVlnNEnbubW7/HwDphDzSnDr3I9qrJISeAPpM9iyUt81v1+66ifCwLM?=
 =?us-ascii?Q?5/iyz2OQk0EyEbDTvZWCDKnxElyX/ylnyoO0u/Mt2TsV06upvhCuXbcb0s6F?=
 =?us-ascii?Q?ujI5jSROypMc2pWgA400nRuaUjzSxt5Y3byZnSS04qIF3dwSmMT6lMlKAjA5?=
 =?us-ascii?Q?QHX/4Vez+p4rQYWQPHyNHNfC/fNC6YF0aJQOUA5BMk6rXmlbPumptHUOqW8c?=
 =?us-ascii?Q?McoUcQwK6gF4BIHFv9zAczxpCDuhLvXSbGPjJ61TVrTOyFCC5Z2QBwcAaaKY?=
 =?us-ascii?Q?tfw4pTQjUN8eDq2SKi0q/6lXtSepK1871WApSEofGFeMTAm8womCWWKA3RmC?=
 =?us-ascii?Q?x8UBVcL3WAq8rLN6VxsMjW6uiK84Qxt9lFzsfIURPfmc525JXSPPbUyDTYyW?=
 =?us-ascii?Q?5qwUvO4mhvPooa0RTP+sOk/S3i0RkX3HMp5gqbLLbC3yzGL3suILk9Kg5evi?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 228e7bae-6955-478b-98d3-08dd4ab5d3a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 16:04:55.8197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aeKN0OOpwJKIMJ7JkGAtst79FjE84rLl+SyWBfYdWtpj1pBFTEXO52zI2UJjm0RjxspmBdVJnlxQkAETS/7thF+E8MawHwgVV2FB4z396Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
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

On Mon, Feb 10, 2025 at 05:19:57PM +0000, Bruce Richardson wrote:
> The Intel oneAPI DPC++/C++ Compiler (icx), issues warnings on build when
> the "-march=native", or other configured global "-march" flag, is
> overridden to "skylake-avx512", when compiling AVX-512 code.
> 
> Allow building with icx with warnings-as-errors flag (werror) enabled by
> disabling the warning for the cases where we pass that extra "-march"
> flag.
> 
> Fixes: e6a6a138919f ("net/i40e: add AVX512 vector path")
> Fixes: 31737f2b66fb ("net/iavf: enable AVX512 for legacy Rx")
> Fixes: 7f85d5ebcfe1 ("net/ice: add AVX512 vector path")
> Fixes: 0fac6a1c44d5 ("common/idpf: add AVX512 for single queue model")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Ian Stokes <ian.stokes@intel.com>
> ---
Rebased and applied to dpdk-next-net-intel with new prefix "net/intel"
since "common/idpf" has been merged into "net/idpf".

/Bruce
