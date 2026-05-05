Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26D4CD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 16:34:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B9FA4064E;
	Tue,  5 May 2026 18:34:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 76D4E4027F
 for <dev@dpdk.org>; Tue,  5 May 2026 18:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777998862; x=1809534862;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bXPKv6Pi+HMPyqW6P5jNjMXv2woswjqxyDrPKqmto7g=;
 b=NAiyGgNfgHyp1EgzkrkIWPF2/3o1f1oTrbUqjDP5P1M7YUVj4kVWXLlf
 FF10DXqospofjQUtG/v48qOSkaZhsCBaYQg3gHhBjuS0dOk6aLYB2c2oV
 oNQQLpRF7uJmx23+seBb1Gtbf7jJNta8M6MdJwOFPfyWMVooxWb40/VN9
 5t1fBxg1FUrhsMEV1fGLlibWAo1Q2WExfhnpsLY/GMfKJa22RVnRn07ch
 fnC7KUn+JhCmz/jvRPB/QIrB4NU17BXG6zwUxNawwKFScAAZ/hi0ttfYW
 g21BNdg/OBEyQ902OciW7zWlGoEOCk5yf7VyjhhT6VVrS+KVKC42Koc7f A==;
X-CSE-ConnectionGUID: DGPERV3cT0y+UMsRQK6MfQ==
X-CSE-MsgGUID: qI3tK1ALT6SVYyCzNvWn4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78974647"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="78974647"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:34:21 -0700
X-CSE-ConnectionGUID: baqRTokuRgiU02s9DixNuQ==
X-CSE-MsgGUID: xlLXJLIMSxyby0SqjqbIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="239848835"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 09:34:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:34:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 09:34:20 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.52)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 09:34:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSk214U2cPf6eS6L+sFKAh8y7SmvTbVXmk2mfRmuvScc1OVnJ+NY/eGpMiOpA6vGhwo4WZA4peRHcDPZSNy1AvpijVP3qi1xkW1EvI4HXALAgkInxr06liQAEQRMTxAURwrL3prdHqh3pbp6BZu2UXk7RPP+la7BJKGMXCrRhQJMf3Hf9Q/Kh5KNI2fb5MTezkQCY8dZ+ep+yTiZasxcV6AQcLoiDuNetX4QQ7ClD57HWawdGXx5nlb0zqGZ793ObLuxOTkbeRP8tcl0AAcwjKay3GWN/ussQRu0rZrsYJjThwLRexDPILy/o8fhnzwS4BDNBWiSrDuDSsBPCoIJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qtZWzR5Whn0sAjpfMMnCe/rDZDw4Q08mI2P8JGL8DA=;
 b=XvI5LoFEWI2UBlOB0L7jIdjhJDseBzfOLguOJFi369FKPBRRlYLTbzAYgFUJoTcehsEPFRkPLoSsZIQT3CcUZfhwWofjhev3QONcw5E33+EsCnV2egEQ8FwLYGm8qBf0GcrSpJXWRi53EEkoGuzdb6yMp1ILjZPGWCivphtrCOMLaOu0LwPf8FVNXglQsuIka9JZ/xIG0IVQLvn2t99uwykVMH69NQW3MafK/RF0Wz7/t0JCES1RWQfIvIDnlIuAY1/oEn3R/DsRjHClpC12vR2+RhV2wVUbButfvUS98XDsmm9wr0T59X/dlwVMClMyTQJJPtBXvu/4VaednBTKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 16:34:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 16:34:18 +0000
Date: Tue, 5 May 2026 17:34:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2 4/4] net/ice: implement flow dump
Message-ID: <afob_B5hg0z1DKuJ@bricha3-mobl1.ger.corp.intel.com>
References: <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
 <fd0d1c9d3436942e842e5ce81d5ae26c5bd58bca.1777546834.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd0d1c9d3436942e842e5ce81d5ae26c5bd58bca.1777546834.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0264.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CO1PR11MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 3129c4e1-c58e-4ab8-d4d3-08deaac42718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 318msN3/ZD8XNKRAPrGFb1GPbBLgJ7tgh2ZYHNDYw8bWBu8SrgH/0/j0inIBqNOI49VjuLrfGaA5geMwi4bw8QpKuK6hLG8V9p/Se3/XeMwwUKrIotpVJPaI8LN6HwL5lINY11TF7hnea6tRZHhzYqdtzHK2k++StN8Y3LvSLrlNsitMAScCfm2jYCVt0ZALKa+gxACFweCC4CirAJLsw7n2yJ2TN9soa/7Dluhf9EtbiqaHIOr8y0rZiB6PmtiVmVSWVo31s5YeXG49vywintxDcuofnTPY/+4dYszBaXb+QmunAo7490ZZgO8QrdUJIiIbB2GYWeWExB/XLL/6cA3l/lt1rceS+VDzIfVxOHjpLgNztiANZ4CAmxJV7ztY+SdfDA2XllPyMVcNY290Pvj2dnY0t3ibdmSJVIluG4GCDHkLnk7/Upw68GWSpKQ6p5gYVYXaH8FsMLAXYzj/3Sl6aD5ojvNxe96bOs6quN8gf1iNQDCOcuvv6FVE6vMTCpYLGWy2fTdPw08ALyfR7ISTXczX7oDI9uOoeWEQ6bbo1sxG0MaXTrJd73e8KnA8cbOaDa4mclAf55gvFvE0idf7uE+Ykc4OvNpOMI+FRD3HucOqdkJToR1JOaz74JcTDLEfYI9eGmLVdG4OyXiIX4LR7oWGAbAhYaEUntlcve+NA/tKuvdjiKXIIXwLbG5t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TF7JacSInXS2TnqoIHzZhIQAon5Ya7hIpfqOgvsbVuVNvd61KcGSWj6x46cp?=
 =?us-ascii?Q?Ip4UbO78dv7Nz7bz4ECjoJQpp4Gcui4e1Esoz+WgR3zE/alnYkpFjbdbsBX5?=
 =?us-ascii?Q?In5QZOF890i/XL5kP8nr/Zf2cJnv/IKU2a5nxxxrwPwAGgZgLY9q2L3w1+AM?=
 =?us-ascii?Q?2Dezc7yVH3VNh6kxM4hoYUE+dBf+WkQ7TfqCObaZOyr9Cb9JujU8F8CbA6Tw?=
 =?us-ascii?Q?Z7C32PI9niW8bhiReRdCovd+uNRExJ15q70cPg86aXMjuupQ38eGc3rjAmrZ?=
 =?us-ascii?Q?J3iaeImdjoxEHH4SYZaEGkZjY/GRGd1HL9GGnMvqlN1hBC2aGRUzb61xwyxa?=
 =?us-ascii?Q?BHvW5DdWYxd5ok2IukFYK9plnuscMm7e8b0OY8jJEECsassvkEdVN3/bSuph?=
 =?us-ascii?Q?++q/sppEDsqBp9Pdg3fS6gKHzB6et6SSpl5JZtBFrdR4vZRqUIAptGugd6b3?=
 =?us-ascii?Q?fYGcg1vZfFPMc3RagGjSRCGxbM57bkbpf/wvRMDGOJfbKa/boSv2qCPofmA1?=
 =?us-ascii?Q?CiAqZ3pX16N6d1LxEpvPOnWonnZfu07Sm/tLWXiwSueabzEX4cvEX7su3cSA?=
 =?us-ascii?Q?k6oAp/L5LmDOdyVT4Yw6x+RgFnrWiEfQdkGZ021kkn2bxker9kNMUQTQ/GkG?=
 =?us-ascii?Q?6HFInDCbOwkhc5wrwiACU53xMKAoCwVprukqkT89WRAGgyJgL1Ycph6RysK9?=
 =?us-ascii?Q?Vi/t2kjhd516bgfvd9Bj4s0JSyjBvotXKuKmplxxN8CG/0eRIQA9ayFqqlnZ?=
 =?us-ascii?Q?HBS4wsVbnJIfyCK06jLcb6aLk8DDkKhnlrTnZhDkvfS7egml0uSDu0OV3uPS?=
 =?us-ascii?Q?0itNwTD2F2TRAuTL/lVsV2UZ5xuQ+rLTNpEcQbeUjUoZb1L0Xe3Gr95X7WBH?=
 =?us-ascii?Q?3GOLlSe3y3nraSoJJ/edNxtHWzCHkEdeivWM4Lvhs9e7oHV7rpClfJkM1Oj5?=
 =?us-ascii?Q?3RLcDHmxAVt1iCimPaRNscgeVFVwtkzm8UT8Qe+BFhdeOGMQlwrDlswP83ka?=
 =?us-ascii?Q?iSV8vpXp1f1rvATRk7ejH9OQ9rw01i2fHgvKRNfSkDcFLWLFyMJVMfTjH11J?=
 =?us-ascii?Q?GMenJwXIikGtaQHxEg3j+ML3O+6jwpy6BO5+p14/UgEi63yzsJWK6HZQIQ4i?=
 =?us-ascii?Q?Vxoah6nD1KoyHchXyF4EIvneKKxVGRDAjfc9cNf+IlXSZGM6ob8qpoPdyqzk?=
 =?us-ascii?Q?sGx7MsL8lkQtPoklUSpWxpKCgk76ZLuDWZU9dy4P2QZ7/jbqMQUSFXQYazJ3?=
 =?us-ascii?Q?v6eiJ97xkKQi73q6hvWmtL6rQYNdZlh1V4AswQmR9ss0V3mpb4gs+nw0vbkn?=
 =?us-ascii?Q?0L1zl5a+Q4tVWWwz06stDmwscU04bW1Cp7lu3rzvO3WLfwJu1rbjq/MOSwg9?=
 =?us-ascii?Q?ToGtZETRUdvIIAmT9fIs0EpFjyx+ZIjGgOHIlwKdF4QrtnMIKhSz3WEWPlOP?=
 =?us-ascii?Q?cj8mh0ctFU742JgCaiYvIa/ud2zsHc2dpFo6G3RX17DQooj6vQkreXpdTAc5?=
 =?us-ascii?Q?J/UJUoYen9ZjzyvtP8fBt5e4GrHtHa1imFzRuReDjV6BTrPsXzVp3wUom0Ir?=
 =?us-ascii?Q?K8Y4NJO8R2Sa4onvR6zFC9aXfwpRcbJMsMfI3ZwAQDg7KXwopbLaa0bWF6H6?=
 =?us-ascii?Q?u0U9gDXTeWFA6elNTGZEjP1A4VODAkQRlCOZ45OBVS1EPr5vwaVex43YKurX?=
 =?us-ascii?Q?fMj1cVxxebqi/uAuHksOg7tAsNiXJhEzGzmzMoObGAijHPJ93XL3aiESvgP/?=
 =?us-ascii?Q?kmcDlBB/uvqVCaYPIKw79M8zvT0BJ/A=3D?=
X-Exchange-RoutingPolicyChecked: Aw9uqZ1Y7dZrAkYkhHkkBQUdeOg7KvwppfZ970W/1kjzzaHnRFvC6TiUBHm6oCXzHg5cnMS6buns2/YARSSWEf3IRGQbZWkB+X2RTS0y4JlzoXuWYGXIhz+2py7dSMBM0ZrhYCWySuZLZ1Z++mOqgzoBcS+IxynG1KL5ke/OEPE7rXI3fgdlc0aszX28mZNsanj3pjz9ThftxBfDgnotPZ7o4OxhzBQbTdqugA1aI0dpBXe5slH+yNS97g1buymv2B98FLd/XuU5brk0l9kMYD0TRU4BHpYx8CCXCVjLUgQOsz2wnXljZvFiPsUEE2Q7w7j9oLn/t2BpKyyQ8rnq7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3129c4e1-c58e-4ab8-d4d3-08deaac42718
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:34:18.1084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKW0Noz0yAMBCz9ZHNdcS0gZyhPR4SHF6UBi2yJ43VQlpj3a/lPCzjrNlwOXhqNRnZ8a/x8UXwFAlgt9qCImucKMEAcwhWLUsnrRe6uYMSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
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

On Thu, Apr 30, 2026 at 12:00:47PM +0100, Anatoly Burakov wrote:
> Implement flow dumping API.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
