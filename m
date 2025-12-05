Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C5D2F7C6
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 09:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A0B94027D;
	Fri,  5 Dec 2025 10:32:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id BB06740156
 for <dev@dpdk.org>; Fri,  5 Dec 2025 10:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764927137; x=1796463137;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=9zHPW747XsQOh0NAgLyf6plxju4dzLcTXfnLhZTDAlk=;
 b=EbYkYaMj27Zb8ZAxQtqMcxHlIlKHttLLcxiCt9d3B3BmFi6zoWcDyFK/
 oVbVBIXYbYNbK9Gg3ERXlWHfLsa6mAUsOFBlQvXT1Ab1aQvPatluLFTgV
 xIImyxaX4q4Q6cB5j9KS5t6MbhigUmqXiNrRLf/xSVCEXFz+mFHHNMoYS
 IS2/O1adqceI7CXMGe9JsB0TXKqldReJgZBomrYeDSilzP4PwZgIQ0fXT
 NDbzealfpt525asXgTpmdvpL1KN2nE30zgaprWgYtc/AOmDIcwJEAfVUG
 xJG9o+alwyhymKe3eVOm7W+HXX7BeGzBMhRf9iQYIFnEdGOwlA+195Dgv w==;
X-CSE-ConnectionGUID: 7IxiJkbkQb2WwTxxlAiTNA==
X-CSE-MsgGUID: vnm7BBeSQdaCFMGu/Q9LOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="69553140"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="69553140"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 01:32:15 -0800
X-CSE-ConnectionGUID: j83/dnAQQMqsIQxS3+h5Ig==
X-CSE-MsgGUID: TNuw9qOOS1yXaZooH9mxeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; d="scan'208";a="226232483"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 01:32:16 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 01:32:15 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 01:32:15 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 01:32:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFpqrDgW5htSGRZsW+qed956N3QAmeGIlnxvf+U7LFworRJIWk3MhCZuc0zP2Eb20Zacw2wUiUywsW3v5RYZbbF3HuTW/xwIsNzZ6xBXemTV6HNa6hSPx/SCHvDg9mj1Xac2RH1+oRRwl+mBD7wlDOgNV2+NvprDc4QaMprKITF3bemC5p4dMjDg8Bg5wDF95SD0VnPq5AMHfAu7RdO6UNj0Z57wpD40TpA4lYpCKWyW2L0FKGV/cqX5fwmgVcN7SrGnpep9mmArQvBOeRje0yRZNsaTKkDkGlsWSMdqW+op9p4Esy3oMAxLsWHB2kJUCRk3dlWJIq6A951ITVVHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGxuzoeejBtcohLOl+MnpX8Q3mQzUn21A+A0xSBBwkw=;
 b=sqdRax4CsWcNTQTLIk45QiMbtOBQIpVNqUQssxnNA00VIaDfV0Cv6R2hHDJW0QNiNHZCCTIba6WLt9KVl16bSodOB61gv9hfCdDhP41mX5F4xKoBj8KUpt68FDKa0Qdj7hdJja9STxzeulqiiv3kZ+zPjPdi5Vw49GawtMcxqazjaGmoSyLvUN8e0pJzLPBqllsreo9MBmbYAITvq//3UnqS+FaUltjc28JM1spwxrs61m0MOnZjW02I1UrW1WjPzDGlzlnv7H8Bxq7Bya2NUVTPeyQ/kRRDC8DuJeYdraCRrtNOGcBvZ2vSWr427QpEE0FGPCM56h+JfU2ZhY7Tpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB6936.namprd11.prod.outlook.com (2603:10b6:303:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 09:32:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 09:32:13 +0000
Date: Fri, 5 Dec 2025 09:32:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH] app/test: remove use of coremasks
Message-ID: <aTKmmOvmg5Bao32Y@bricha3-mobl1.ger.corp.intel.com>
References: <20251201181024.1583767-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251201181024.1583767-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 527a52fd-9af3-4928-7a32-08de33e12bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9V4sDvXG+9R7j2EWwj4JfI4CDDQ2Hvv1838UKf+KAnfgwg+xkdmgIAwgPJfM?=
 =?us-ascii?Q?/Q8VrDb9l2SNCt9yu9j1Hq0+3IhP08JLK0O29OKEH7qbP/DFICG7F9UNrdFi?=
 =?us-ascii?Q?4+vcXv2MOS7Jo6OxNDgTt15fv9JqgEmZT1/fAO8ZDsdLAkRF7uGaG0d9r2Rq?=
 =?us-ascii?Q?pplhL2eCec1N5agtnDfalLIjR9nWtRKhijsAyhVTePE38ArgCMstNMryCiPn?=
 =?us-ascii?Q?I8PZ/QyMJkGcNbse7Zayb9/s/AnY8RKkQ5l0yZoV9H2llO+wJIQXTefBLGDD?=
 =?us-ascii?Q?IWmrrvZGlLSLJ8cmW5svh3uum4jyHAzcWLtRc/hlW/hFsWU6IeZ/TRPN1AU7?=
 =?us-ascii?Q?l9VJrc1rrsgzMrxzW2mAoynimj7fIveB5LPIjzHp0YeqNhVCmFk+a5nBQqFa?=
 =?us-ascii?Q?KrjP6hPqvXeUY9xS0aUNIXBu7prSWjd/9kT1voAIajBPwk93mcSaYZGLEgcS?=
 =?us-ascii?Q?OpcVCx1r8+XEpb9Tg5Q7W+OQKqdTSJTAXTuxYRdzTOqi6IZEhMdN1PdvO0Jl?=
 =?us-ascii?Q?fLqL45b+NnSPxp+6Smw7Le4DKLq61wAiW/9Ek6/aPtlZHnQxEBjJlsBROqOY?=
 =?us-ascii?Q?hOwzjx4Mjb9kHp/P6/MON2QUZa7yJS5477AfknehigB8vQfDUEXmP4wBDIHR?=
 =?us-ascii?Q?mXVccAjrfNGvu3PgXQx4znlVxbd1y4H0F022z72N3Ptga586UJSUEMWYFqvm?=
 =?us-ascii?Q?addSHNR2zCFS46AzR0imb4PYiGMKMiu39IsrEbxn2yBSlrivAkOvkrFDiMhL?=
 =?us-ascii?Q?ap9mUKRh83+vmWwNLJBwuxv04ZkCzVVqm7Nu4MPwizAaHzdT0C98hr+n7TeU?=
 =?us-ascii?Q?oax8FAYUJIC9t7tmteiNuOgxoc1wvAv8qHxZaQuMG1kui9fqkXTKr3zDA2WD?=
 =?us-ascii?Q?If93PV+vNZb2voydI3LgWFBDA2JEz/mZ/qa1XIwDhhBk2PevC1DZR55BSBW/?=
 =?us-ascii?Q?aVpxFH1+NIAmU5nGg+dh+EfoF7ZJF17CpAW2KNiMJyl8EaXz3hCza9cXN+Z9?=
 =?us-ascii?Q?ImjgaiB5j78zU0tHEvHL/hEijOE816B13OGmt3pEIi9qw5lEwZNyYV8St/nk?=
 =?us-ascii?Q?js/PieIuiD+NYg8v2mMw+XasuVrifiZEU0u6nssqIYwmcRnrlj1FzA4ILsyp?=
 =?us-ascii?Q?6vKl5eEN2BNPj8Uk6+dCcikdwThWhAWyKGbqqTkZOp4mgAxZw/s2qdrJnfv6?=
 =?us-ascii?Q?B0oNq1TCrYlp9e+kMKaTSEhDOzs6wPW0BvikRh0utoiAUfQm3Q+KfTDxx7UJ?=
 =?us-ascii?Q?3/PuaWf4E1TDQfXJ5BEkIrhI6jbTtSLw2Dpq8cMYdyiI7bwIBHeYDRJczkTF?=
 =?us-ascii?Q?Kdv3/diupKrOmg4GMw7dCLxb+7rG+azWZ+jM0SXIDWpWZq6zLfITO89KMl9B?=
 =?us-ascii?Q?y7DKxyRwquhlQJvkYiTWdUB3E7ohBrJMLPvtG2eiG2iz6mg/6Lxbeqk0cLlU?=
 =?us-ascii?Q?CJfRphMYjSSLrJMFprBWLdn7splxHLh3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kFD40yUV0LuSeCWvKSV9Z1K74azZHAvgeZi5bivIdw8Se6S58cKWNeMVYwxB?=
 =?us-ascii?Q?ABSPheMr3vJ71vSCoyvgIGvDjcYoZgTDBVCVt3YK2roBjaENn9ADFllGOMty?=
 =?us-ascii?Q?djm+QJ6CX/oygiAAVQM/JEg45NHL1JEBDueomAGzbVFoqv2h/yr9nfXx2Ji6?=
 =?us-ascii?Q?gjf6Fxwr0jIl3ShWchj25z+4TgGqN07Gq8g8qRBNVsCbmn2JJ0AHjM/DZLCJ?=
 =?us-ascii?Q?RUXiUtOuFJi7F0zd8udarVhdlGmXX4td/94GMvcJIM2U5hVmR24N7pKwePq6?=
 =?us-ascii?Q?HHK23qV2QZH9P5nbBfV5cLULsvMB0F7lAVDZly7Bo4jP1aXDa3WB4eFG1oj5?=
 =?us-ascii?Q?WoRek5UZdgTgEJxoWmla4Manxlakm8pj4niM0z2GdLqaFBAf9pOKJ7iQNU9M?=
 =?us-ascii?Q?sHpCMauLYM688Kx41NU3IhTZQ0MtIAfC4NHVOj7JWQ9OTI4CF/qL93wDF1UY?=
 =?us-ascii?Q?ejUS9SzGA6amg40yhZP+jZthgMfEnnmpxbqnY6shEXgkfGW4zNENEMeH8eu4?=
 =?us-ascii?Q?3vV5vloJIhH+OuNlkhysgkYB1D0yzUmwFn5YaYkyXvogNOGqf/rd2PWu6G7O?=
 =?us-ascii?Q?xgBnKIT3giDc5ypEyqqEeKZoyaug44qrkRY7H2m64DzEphxjOVfXDMpL+dy4?=
 =?us-ascii?Q?aOea7C+NbvDmVfOvJbx7AkfprVD72kydFF/ksiJm87k6k7jpbIHV/O3J7KvW?=
 =?us-ascii?Q?r2kgPemO+P6qg74/mfQyZqZE4bzBUwWjufZzNgAFdeHS/h19vvaBFnDFoadr?=
 =?us-ascii?Q?rpoUtxXFVBHA58tazzft5ChWreF/u9LgK8abP1Dxh4AxnGuupg1HUzsUQGP1?=
 =?us-ascii?Q?WBWQyARDvbxNWGCp1RIBkobrA3gKJNQTIff62E0uXdJEhQGjG/vJI8Nsllx3?=
 =?us-ascii?Q?oxqrDW1Z4WBJ2vpEU/Kp6AzcnfcWPrxqZZwQmjufYMQo/IfR+AjNwi/icQR8?=
 =?us-ascii?Q?6gEXf8HEGUkubtjNmpls97j2UBQ80ZERyKtbCMGg9QtdxY9imZVJ4SZVBWFo?=
 =?us-ascii?Q?rxNNVwCPcIo3hr7ZrvxeghHOAYdqfUuAl784hsnDHNc7zEqa83MQqdLYfovL?=
 =?us-ascii?Q?cUHJk7pIL6WUqpvU/a34P4lWyGVRATyEulOY970cCg2AVIJSCsa9X5G3ugKs?=
 =?us-ascii?Q?Hg/IPeOamSxCapc06jC5LzeEbqZVEREWp1AMSD4hEoNYHY3MnG4GB+XSHx+3?=
 =?us-ascii?Q?/T7uj7KBVlwNTpJv/5ekuBzgczY5rfxTbicnIoYOyv8oldLhNUte3Ah9cNXM?=
 =?us-ascii?Q?FnxA6yNEOPI7APxRm2s6p/OXQCP2Uv1luFkQtDC4VZqkh/wiUaIgpr/tGC4Q?=
 =?us-ascii?Q?x1Xr7GQ3NKWiMOwgt+Rapjc6arNHuRRtUGTwDVOz/mJsuSAJLlb+AulmRZoB?=
 =?us-ascii?Q?ojLgIbpwBymo23PIJU0FaUJTfnTHVnx5QC22XQuTVPWf8i1+/XOz0PKkjMjP?=
 =?us-ascii?Q?CNoPSXaTC8FSfaNoDxpnwkJzOIi6SFyzgJjswVGlwdQRltU5aH/43IkHiJ7B?=
 =?us-ascii?Q?hsnpnq9+XaK6EHh+DJQTjE37QG2KqBPDOmCtOPZs5VBclD+I8w6bra1cdTkZ?=
 =?us-ascii?Q?8y+ldH+HiB2JOC4ywuqqWV7WWorrHoto/SzIi203TDTR6Uezp0AiySSwas1D?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 527a52fd-9af3-4928-7a32-08de33e12bc6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 09:32:13.0948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFaRabsHxAX2lZC1iULTm4N2tx7w5rJ1AKDrMmr8bmEEcdx1e6PiRpKlUDNSpzC1aVkZLPoqerzxUFK+yDqGSceI0tWpA3cCICffUB/bz90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6936
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

On Mon, Dec 01, 2025 at 06:10:24PM +0000, Bruce Richardson wrote:
> A number of test cases spawned off secondary processes and used the
> "-c", or coremask, EAL option to do so. This option is deprecated, so
> replace it with "-l" in tests.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/test_mp_secondary.c    | 13 ++++++-------
>  app/test/test_pdump.c           |  7 +++----
>  app/test/test_timer_secondary.c |  6 +++---
>  3 files changed, 12 insertions(+), 14 deletions(-)
> 
Recheck-request: iol-intel-Performance
