Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD7CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 09:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DB5840285;
	Mon,  3 Nov 2025 10:43:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5264D40281
 for <dev@dpdk.org>; Mon,  3 Nov 2025 10:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762163030; x=1793699030;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=N/m9KB3/zUknJBwiJFKM9nQ1XVOrHIGOaGaEo/XOSBU=;
 b=AM5ftf69fgZO+uit/nl0kzaWNqCuRMcmv6gyoonhsarBvJm1yXsiRZx1
 UxeMgyNLVaIwm1ewqZuw63t5H13XVCSkjiTMpCaGWBlGZi7h6ZRrlEexx
 26ACV3dLYOI5PDqglQAVmXYJDvdoHsouN1Jq/+RTar13Q5MlDr3LaIwas
 4epV/rqpKWMsN20vG+3gc01eIlvmhSlQyCH52bH6Doof995LyidfUjZOY
 rLYdmzEHwZABKK7UmovJgG5vSOLLNR6Dma0Gs/AXohAQX+7uVSnF4Y5At
 2xPXOhhL0lZiPoQbhQzukgyNimgCLKUc9XUi5a/BrhUAQcGURe/X4CiLR Q==;
X-CSE-ConnectionGUID: /f2WdOwsSpSMJ4KUavPYDQ==
X-CSE-MsgGUID: uobSc26kTOyRiABJkwhbig==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="75344021"
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="75344021"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 01:43:49 -0800
X-CSE-ConnectionGUID: Sg2K8N3RRtu3zM3ddLqIfg==
X-CSE-MsgGUID: ALJQnJ+CRuagEtBsVw0BNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,275,1754982000"; d="scan'208";a="217647935"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 01:43:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 01:43:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 3 Nov 2025 01:43:47 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 3 Nov 2025 01:43:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE4QjHKazPuhYYIYdh1HMpu/zCrbc65flgDBfpkMMzf7Ra6zW4CAtF4mOZVAhqKTErLNmKGguhBvdJOdK5PV3tdLOvGcvTJENkrWxiT3i0bz2G2hGquJB8JgsfZC3B6XEyHq4f6icegPADmEfNgU48SzQsYmoCJxVw06c88kIGStBySUuQ+ocymUUZlgLipt4gAJx13LK9UqoKmnMpV5FrNxSFbCACyjJZn/GG6theKjcZcpyvBCwWL0HvWEhGSjdy/qwCoDqo8vxo2Q9hzxznhPNmrsSG+W8utYlKJ2qVPo1yaQtuBggFeWcW+8E95vs8d1TlqMJ5R+Zeh4B+wF0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjT0fP8dbBc6PEyGtEvBpLaaFeTtox21JbzXVWf7+ys=;
 b=omik+Eli8SRNfgObbuvjWGj003aJZKvSN41hgg/WMyx3LVNZkytlpUYLMDjozReS0yywyW/OLX0W8+6etsb7RoV8uH9jRb6IGooBKwDroswLvZtGVUTGDTXWDH8fNuted6AFnwSftF4+5zki22B9Dqx0uUbw05xo6LUiitID3Hddk7q0w0ImYD0zeov19Tjcy2rs3dFwzxQ31wy6zkTghZAlhddyGIaki53lt4QByiyotHxvpaP0lFlxLhWRTbxJZ/hs4+rhenjOoGdkFEs37Skv1qv0K3B2035880k3NqWLfg+aSZrJYz327RKSzclmjMnkHvui0Zthl+9zxuBzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CYXPR11MB8690.namprd11.prod.outlook.com (2603:10b6:930:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 09:43:45 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 09:43:45 +0000
Date: Mon, 3 Nov 2025 09:43:40 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/1] doc: fix note in FreeBSD guide
Message-ID: <aQh5TKpgj4IjOsOY@bricha3-mobl1.ger.corp.intel.com>
References: <20251031115342.4064625-1-thomas@monjalon.net>
 <2436889.dTVjPilprF@thomas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2436889.dTVjPilprF@thomas>
X-ClientProxiedBy: DUZPR01CA0172.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CYXPR11MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0e9b3c-942f-48ca-2388-08de1abd7b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WxoYtfOalSq2v7ornadsXRpgcqbTmwNRvlTc0TIq/wsWdfNo5MWSrC2NDwmd?=
 =?us-ascii?Q?1G7lrdIQ7Qc06nR2VnuxBic99B/F1J0rQUJ5ub3a5DpkIvqVQ+7BvWiRuLOR?=
 =?us-ascii?Q?MUd6UkiRZI9/bY7sJAIMFzHn17QRiuLT4UNKBpUyoCy3e01TU+22N0HXhs/m?=
 =?us-ascii?Q?4bhxDl04LciE8JAoTdXNJf6uPY+ad5JQBMyDOutvp6VG3zz14fq+IcsIHK3r?=
 =?us-ascii?Q?1eg4I6JRtBB0OzKKemiu7WGuYfQND0f5tMPd8J6eEP5A3bw/kRZUQR6PZ14p?=
 =?us-ascii?Q?XKgJz/xOd8QYVA0QrccuGxtEkWnTJ1h03c27njyVTQS4KNTDSlxRwD8MbOTv?=
 =?us-ascii?Q?PYDPnMAfyFGsGsts02KpnXpJ2PVMYKHLGkvb8ZEa9OAGEE+dBsNqxbTv/Fap?=
 =?us-ascii?Q?HkaulNJmPB4EbKwi505KqNmKoi7nDy2Hp7pg1lNULyaew371C/yglnL723yx?=
 =?us-ascii?Q?Do+XhPK/K+2KM1nScPyQFqrb/8eEM5Unfoq7+MH36OnsAZb3WFoknZmwajsS?=
 =?us-ascii?Q?T8tYhl8hyrv9qXCG1KEPDxwKmYj9gLBqooL7Ddr2r1t97fwTb9oxm37q39nh?=
 =?us-ascii?Q?gHs4b+Bf5mBfa4sPVKqmZ0GN8OObKowx7N4vJInz4H6AiV9kPDGPP2EqiKBN?=
 =?us-ascii?Q?dfD1yTEjd3YWDZs/QCqdf3434shvQoq9qRXem0naYJB8gHMrNAdXpeY6Gy4u?=
 =?us-ascii?Q?ezyK4G8ge+PMoPrTKYT07NcZ4+wKmFwz3OJTCkPTpSbg+Vy0sMBEzsJUYW/T?=
 =?us-ascii?Q?eToFBkFqhC6lA+z0JHSEVOavHQ7fIpsudpfHTJ+jYHb/eeAUfvgLKZmRZ9mD?=
 =?us-ascii?Q?Tx5TFc9gmcAgmCZoYKM3LtoGtAda3WGKljmolkgoJJaztnTmP1kwhG3oY3pQ?=
 =?us-ascii?Q?SpS9nO6RH6R94ZqhVlg1GZyrEU4h1VD6qjVsIV1YSGJn9AnGvq6L1XnnCwga?=
 =?us-ascii?Q?QNlGi2I2MEZQUlp4G/5ZeeIo88HpB+4v/055PlkWS1lYWeOuVtwFFSnbmpE3?=
 =?us-ascii?Q?91NhOnH32MR+QUvv3GsBezOH1rCiyQmRvvDHE/TxsEFK+JOE0IeCGzHND51p?=
 =?us-ascii?Q?36SM4kBVacP4BLRo+p6ETvNvTuda23hY5SCrvIhlBEO0WxAR/Llh/kGxSaGg?=
 =?us-ascii?Q?cuuGJuSut2CTrCtnYRvYRAGTC0hoYcOudNkti1ItPOBUN6cdRGbINmnxCCen?=
 =?us-ascii?Q?XVTJ8XLPrV7E/rko3rRZvRyONbFAbXsyGcP0haF+xtzKzkm7vk8TtuCErE8v?=
 =?us-ascii?Q?3Ra4xKsHhgJM/JHaNk802Nu1CJjA0NEXOUAEFBs0raAuNU2PyO0tqckQDiPE?=
 =?us-ascii?Q?ssFxmCkLSEAvppbrkLpAvSqZ38E7VzLEo0hSpXw5ysYmK5WzRLAI/C9oKjv1?=
 =?us-ascii?Q?1FW0g6iOHOdCP2Ei4M9o8WhyIPZn5ZRMKXYPCl4utzhxOw1IKpgQrp7cYDpy?=
 =?us-ascii?Q?VCWD1ysa7ElJvjU86f6udCYxaXMUIQ7F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NWEwuwfJCmWuXXnoxn5xpxuJigHlbYvK6zHvlMGYi6Z5zUFcsLOVQCv1uQQ6?=
 =?us-ascii?Q?sjHzSMuE5IU6V0I2UBfoShZWrIioH2N+PC8swmvzkPD/aILIwY2HDr77AA+m?=
 =?us-ascii?Q?jhPdZUf/+Nb7K34ykIxm9bX18wq/dCmx92ANL2Cct32EO8Lt9WAbyrrQ6ihS?=
 =?us-ascii?Q?Wx3gtbd4fMSo81/zZIJy3qKOvNKwVCbfOQ6tmBoYpWou8173G0W4Ntp2dAE2?=
 =?us-ascii?Q?UICmBJooIFglGJUAdXHmkn9C7QDFJEmm4Uze8TYcM+pqClxr69/1iz26M1vO?=
 =?us-ascii?Q?+9DvZkJ83QG0jvoBQ4T142lWOTAcyyye9WwANVOj+VuZFLTE1oHFb5KJV2lt?=
 =?us-ascii?Q?idgf6UIygSwPDZDhWZtBl3MP4b3AVeoTtHiSQjst5j+eXrAzT+a/612l79zr?=
 =?us-ascii?Q?kFb8euyGdMggWu0cYUkz4YHvscCTm7pw+wx1ZpKeypXwqBITHjJLTJVOxlPB?=
 =?us-ascii?Q?edPFc2gjl6jVsN8bpTQ3KibbC5wVHAPiXpMkR4N5PkCH5LxcFHQ0YsPWy0Dz?=
 =?us-ascii?Q?7PkQR2jvwasG0LusldVspqUSbH+b3KP1+r/RWwUzA1GhX94pjthDCjEQ0hwN?=
 =?us-ascii?Q?xgV9qQxaWI/TdkZkgSv4R5ellSLASlzmXI4VYrma+fD94KOoLTJLCSNmFYg1?=
 =?us-ascii?Q?d5MEX8SP9DfLkVU1oHiqb+wz7bYc2VzbnKCXlEl+lc8r38uJkMw4KYaMLLma?=
 =?us-ascii?Q?ysOd8vWqgFj/AkVNrtRJfq0nTU+Epn50zThEBDQfaBfKxQvJXup97jfkVLVW?=
 =?us-ascii?Q?jfnD4Hb97POhdzrw7xMEc+5BXAMNNJa5MvfpeA7UAxq4uskvzGXpt8sEb4W0?=
 =?us-ascii?Q?X5WBoWk8AbS68tydGEuRbc/KlFx5u6IeCaVSTH25/yvOghgRKNUSFfdFxSV5?=
 =?us-ascii?Q?ANCDfMNCzJZOeRfj09Ek/YHmMl3WgmlBoFyIiZEpRTCfux6ise6MzGV/XyM+?=
 =?us-ascii?Q?YwXwKEMehVafiBpWLC3cYgEOfLJMDHbFvlxo2HrL8QbYPo0oCBtqd8MnEEmd?=
 =?us-ascii?Q?9oEbESsNtf9jEFSty4XwsbDsHLvw1vbC7pqGlYKqwhCFPdVkpoj6btyOWDzz?=
 =?us-ascii?Q?ytBvAILUJmBPlCHoK8pyg8mUK1zWQ7nQt8bSW6lbMfanV/qp/S7bJ2ImVzTI?=
 =?us-ascii?Q?iMK2TTQg4Acd492/aukpmJGL5u1ZEDtXHXDe2C8+XqiXZHYBAjgtXWgVHBx0?=
 =?us-ascii?Q?uiD4cXcwDYyF+uofK9EWsG3pMPxLJ2Wfa4RCmtf6mYmIA/qMI2Imrk9wbo/t?=
 =?us-ascii?Q?lmLfkB67xtODwaBdHPWIiqors+kcrWjHkbcWw9020K1A9FG+7qrFrr4saODp?=
 =?us-ascii?Q?lU55CmFkChYPnFT+GXx3jxCGrDcN7NrNyjzay+8VKRMdiRjX9Zp1JiGJr1QE?=
 =?us-ascii?Q?nqWGq38MHMvTPOHvWfY1x4myWtPAyRK6XavM6cGr0m//+iMUstgubO4AD9Uf?=
 =?us-ascii?Q?PMfebHHGt79AM/0ZQ2yEQY3ZioJSnar1VIBvNmqOnnCitCgHr3zs1Qn8BNfr?=
 =?us-ascii?Q?DBMFMq7RGzDHNtWIL8J7Oq8tVVMkefnPYXpId1GsSUTd+iMG8+x00UZPlvf+?=
 =?us-ascii?Q?ZBZqIQ+LbNVhy7EiBt6xUHX7FQDg2/DcOz/+sTre92DjSbbnAC8LjlErrzLP?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0e9b3c-942f-48ca-2388-08de1abd7b2c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:43:45.3393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y0QUgPsYwjno6L5yXNq7dr4xdoqUFiRC2Xqd5FDjpZHbpqnu7ZXeeFN1Gxzv5NCCIBn1pkx7HMayiO5mBNCFHahZ/WGjzY2u/iFJnFQ/6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8690
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

On Sat, Nov 01, 2025 at 12:13:31PM +0100, Thomas Monjalon wrote:
> 31/10/2025 12:53, Thomas Monjalon:
> > The note about the prefix of the package pyelftools was not showed
> > in the documentation output because the syntax was missing a colon,
> > so it was considered as a simple comment in the source file.
> > 
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> Fixes: 9e6f75e259a8 ("doc: update build section of FreeBSD guide")
> Cc: stable@dpdk.org
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
