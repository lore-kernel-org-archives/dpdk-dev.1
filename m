Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C06BCC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:44:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7BCF4064C;
	Thu, 15 Oct 2026 16:44:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id AE203402E7
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792075480; x=1823611480;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=rfeRARVx8PW0qN+Xt6FKwrd3QiRtc+4HlFI2M33NDVo=;
 b=IXPUPc34jru6GCnGX0VjMD8pdwbnHKFlbZ7o7fNNp+DxPIt14weNk4/M
 KGTvbhDiyal4OTCpd6Imi95mMqBXRMPUo1b82/KerGZyRSHgTKfzY1ZaK
 XaEkPvUMM2zt9JWKkawYwUf3U5DLQNS2JHC8F+K5h3b4puLSg2GvnCNDC
 x9XvgaCbK6cr+6iHZfTAOA49chW8lGUuyWiuIfvgVjZeertdKXwHLzPTC
 oUGxIW3CybpgdHxDgG+5ee0hQAbQ0Dzy6yqWGDO7SAPQyI2KRaZSj/rZu
 HL9inkH6lQArs/BcNgXkiA2bJWb2sjZkusaa2s3PzvUeSAfi0dRmPmBoc A==;
X-CSE-ConnectionGUID: tb/KZyj9R/yLOoPN+2ZdmQ==
X-CSE-MsgGUID: 9XSbxmqhRaaOtf/85ooQ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="731816"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="731816"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:44:39 -0700
X-CSE-ConnectionGUID: viHvahgFRSS/tLDqhmJ4kQ==
X-CSE-MsgGUID: GgeyprVvRo6emAI8g70CrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2066995"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:44:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:44:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:44:38 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5Kd0gM7nvMFeUgybERo393zM50t6Y/fFqEkPWnhgboIUJdXLdXnEWZVrFb0eEXVN2Pl4KU/QKvarC6OmExvWjMEZS5VQrOvv+9yHBjDuxetsN7FCcVQ7i1j8IN2uodLfTm0TVNNeTATPh0RVOne8IqdWgs5+ILItDuyh+1IjJO097c5vroRDdArjZ4uhiDWlioGIjZA6SaAqdlTW0MzSPLPjiwMMyM6/TlaZAyAB3sRK8rLVn+NZJJ1oGmdK476lvOxHdPB0mrGVIhqqOEGnWApKyIwYTmW87uYRbd/HauiX1yW4HiNcX4xn3zSnUrAMGy7auxXujr6qCx+5CMtdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aNQByhmfO8YNQ7iIwhwPvMDcm4ax6d2lTwEWqLs/7o=;
 b=GA3/IF6308lr1g+FGXbFHMbYDqgkVw+OGdLuvI5Z0Va4AKxf0zSfCZBPGXJ6saMqoPIFVXkKFpuzuJqzwuC1BJv4h1JsQCDf5PcOFHrFZ7Ra9GTWfjHRSHNa9XPU5VrnOthrycgNZQ8LiVknskNvnuf0aVJfY4bQx2ONm2Y6wDLi8b19yGzYmbPGVOjD7rMHbtqh/9jTp3w1ojMBSckmW7ICodLIDiHQGSu6KhnBU3Vu31bxzuj0WwSRnqbV/QE0sXq1YM6ibQDbF3jos7d3ZL5i+EkpdTh0vCQmJjnsP9QQIgEnTLwutUgCMQgX/219q7Xxgtpyjah79Ac4ygoPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by DSVPR11MB9718.namprd11.prod.outlook.com (2603:10b6:8:34d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Thu, 15 Oct
 2026 14:44:36 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:44:36 +0000
Message-ID: <4ee35150-a166-4a6a-9be0-71f4d2fcbac0@intel.com>
Date: Thu, 15 Oct 2026 15:44:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] net/ixgbe: avoid private driver include in testpmd
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <20261014203435.583064-1-thomas@monjalon.net>
 <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <35d9aed797cb433296b1c0d53fbda4b45c38e833.1792074055.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::10) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|DSVPR11MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 62069242-b466-4458-7271-08df2acad556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|5023799004|56012099006|11063799006|4143699003|261009223027099003|18002099003|18092099006|10067099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: PZrGUuLw0X/RCcnkbxhuDiXLYA5jBj+pBR9dq3iIMplukXVGIzH+aOwzEuOhobIT0dAlgb44VYBkxnXgvt5pik2wfQyWQZpl5EH4HxL68CHtsR4bQqaSimGytdvD9ruUtktZI4D9PzrgPeZ2cwUpSLtA+bHdQt75jTNanpGzqyidCdwgEykLbWiLJoQdzZ0Jf+oXdVnhG2gGdCjdvNIVtUzhN3YMVvGyGJIJWcTRuF/0hq7bilhuh/jtMn/xQwezhbwIVl8Mwm1JcINHueAs2nSRe4laRY67CgOPguln2Bc0OL1zRvElrgSnGepU/qT67kQrwFu+p1SbdZFbIqZcmhzaplHy8TPnpPj9BbD+stz0UNOENoBqsBz1g8JT9rVqpUrETg8kY9b+0t468C2Ef2bpyy/9NB69Mfs36znEW9Dq7N5xE9tXZNoqNappN8C0sGRsQcVYULWffOmXCDoKjBVjR88mT23A0EcHeNQsgOVL0V0QzuKscYdArsI1BDyVS7IH1/xHZoILDQgW1GSCdOuJpOxWMl/OOlKoY756lf9R888xXQ+CG7ihBt8yzfMRxETvQq4S/HJqaIh1A7JV+OQZpt1yOkqm60BS01arlaYeyCQofaKPbBtLF8TswuPSUrwBnJFxqumMo4+N5vyTOB40OSS3Rkhp+Ni2deQYy5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(56012099006)(11063799006)(4143699003)(261009223027099003)(18002099003)(18092099006)(10067099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FpekR6WittR1pEQ0dDSm5Fd0NwQmJqSzd4Q1BCb0I5SkNhZE51RjVEK0g2?=
 =?utf-8?B?a2RpcWNzUHRhYlBoZWJWMEdUeis1bTFUYXdaKzVGd3Fram9NTXQwWFBFaTRx?=
 =?utf-8?B?M3l5c0FZaHZUWWc1SnBrSzdvd00yNVRWa2w2Q0h5blRWN1hRL1F5d0ZCZGZU?=
 =?utf-8?B?eGhHV2QyK3FGZHhXWGRnTm4veVE4RUZkMWFKUnQzbmhyRmpMUDVkdW9jaW5Z?=
 =?utf-8?B?TTRFb0JKQVJPL3A4L3V4c1lReGg4SXZZMlRvZE1DQU5iTFp1R2RCRWhzZ1RO?=
 =?utf-8?B?RGRqa0FrMElHK0FUckhkS21iR2xqK0hQZDlsMnpZdFdCRXNUeVU5WWV5bUNl?=
 =?utf-8?B?V3lsWjZIWU1JelZxQkwvMmlhbDQ5NmlhUHdKdUQ4T2YwOFJ6d2hQYWlwUEgz?=
 =?utf-8?B?U1NxQ1M0VjhGVUc2Wnh1SzlCbDNSMVVna2QyN0Fka1g5TmtTL2lBZWhDb2ZP?=
 =?utf-8?B?eGJ4aVRWaVBNSVhFeC91Q0NRMDZVc3BSbXVab1hTYXlwMEEvb3p6YjQrVU5L?=
 =?utf-8?B?UUt3aUI5cUpGeFZMYWtHenhDNkI2ampRUFprU2VPdmM4TDlQTFRNQ1pUaHdk?=
 =?utf-8?B?RWdERERjN1UyWmRFZnFCUGFCTTZnQ3l4TnNsS1cwLzRyNS81WTdZcytsNk41?=
 =?utf-8?B?VlB0bFpmdS9ETzFMTFUvVVRlVWlGTkx5cWs0aDR4REg4cG9yWEtZWVRRYjlQ?=
 =?utf-8?B?M3BZY2I0NTlMM0F0Y3VFem5Lc1QxOFdUelBPdFdrQW1NMDlMR0Z4TUZ5ZDhN?=
 =?utf-8?B?SFBEK0Via2EyazUxdE5EZzRLYWdoZDc3V0s4dzAvbTltaTBMVUNGQW9oekJv?=
 =?utf-8?B?VTc1MFdGWmRhZUlDUWUyOVg5R3BYbUhDZDg1aXpnRGVGRTB3VGxIdG5QLzls?=
 =?utf-8?B?ekxxeU5zT2F4dUszU09OK1hSM2tPZ1BsS3BYQ3QzR1lzOVFYM2VXVGFaeVla?=
 =?utf-8?B?M3NTaStCZnB3WlJVM1pWSExCV2x2Z1F3N0NjWld6RDlVMmhER1BPMHIxa1RF?=
 =?utf-8?B?TWJ0Q2JjS3U0WGsrT2MxT0hZQjREQXVLWDh3OThzMkVrMDFIKy9sNWZrWW9x?=
 =?utf-8?B?NWNJTVVtZkx4RHV0dFBpKzVRMytBVjRzbW9RenNNWkxiSTE3RDU0Rm1vNnJw?=
 =?utf-8?B?OFI1MXp2NkxHNTJneHFxWStPNHlzdE1SRmFPSEIra2lZdlV4R0o2UlcrSyta?=
 =?utf-8?B?ZDZuM3JhT3Q2OFY1UlJibDJuY0c2RmlIT3czQ29jU3kxNjI5c09ZRC80ZHJn?=
 =?utf-8?B?SDlzUUl1VWpBVXJwNUhodFJudHliYi91TUdPQ2Vlb2tRY1RxNFhpSlJrVFpq?=
 =?utf-8?B?UFQ1QmpTa2Z0RlJXMDFVbTkzYVVwc2JZU2gxZlA5TkorQ2JiVXE0cFA4MmFQ?=
 =?utf-8?B?dmxHL1FteGt2b2xKbHZGZUJFQWhIM2c3NnRxM0ZPNUdLNlFXeThXdEV3UkIv?=
 =?utf-8?B?bTFrTGJpdlJhbkg2bTdrc1dFVm9SVGxmYUFNNHNWalViSHFJOFhkeHViamVv?=
 =?utf-8?B?dG9mVUdXODE2R2NmUEpiMGRzMjQ4TTJSbFdJazh4b2dGNytsTkE3KzdTUHND?=
 =?utf-8?B?UzFYN1FuUVlpWlloU1BpSitIWnhrR3ovV0pxd1cyZ1E4c3RWYmlzTmtTWGIz?=
 =?utf-8?B?UkR4V2p2MmxlVUtmSTE1b2VHQzd6VzVDK2xSeW90dFFWR0orcFQ3WEpsSlp0?=
 =?utf-8?B?NkMwMnVrMFdseEhkVURDU3lBSXo4bU9WVmtvRitVT2hDL0oxU0R5VTJIem5m?=
 =?utf-8?B?Ulh5a2hSTmVSOC8remsrcm5JbmFPQmxIbm4vVnlieXlYU3c0aFZBSU5JNXIy?=
 =?utf-8?B?cWtzMkU1TFhvQ29DS3JoUDJEWGhZa1IzRmdRYXZOelNXditwN1BYUzJid0dy?=
 =?utf-8?B?VVFrMlhTV3VYTm41TUZxTXh6OGdBUXM4Z0Q5NHVMUENvblZZdVVVQUI3TDFN?=
 =?utf-8?B?cDJKSDk3MWc5YjFjeFh3aGZSemZzSDVubWJXdmJkOFlPdWRZZ2huWUIxYXFx?=
 =?utf-8?B?a1QxaE5kTS9QcjcrRzRZaU5vNkcrMXBCM1JSMzZvYTc1RzNPVmQ3U091MU4w?=
 =?utf-8?B?UTJldHdwbVNFWnFVNjA3VTZ2WlBOS1J6cEhhOFJWb0dCWTBLNzhybTltRGUv?=
 =?utf-8?B?cUp1TkhTVUVZRjQ2T3lKbCtVNkkrVTNvLzZUanVEWnNPSGs5SzFMUzJxTFEz?=
 =?utf-8?B?QjNSWFcrZkt5ZjZpeDNqbWMwaWVzeHZML1RwT21SZ2VRd0d3MCtVd0RSZTM5?=
 =?utf-8?B?bEJDcWJaU1BsUllRdzZHbkxvNDEwUWtZOWhMc2FVM2xYMllCcm9NZXNnakVJ?=
 =?utf-8?B?QmNSSzgyUXh5UXptdU83OEZCc0F0REljdkFxeCtkRUtBT01zMWltSXArcklM?=
 =?utf-8?Q?9szdYr3ySfW0zr8g=3D?=
X-Exchange-RoutingPolicyChecked: jYYIg/rCKNIlMkPDt7AxnqxQK7bMkC/n3K8YlHijmxEoq100YFkxbn84Jufylxn8Qu5BuHVw0ijhjMQ9+x6Nobs7kRq47qR2IqlnddNL1HHk1ZxHHg2PSjMNJ/XCJNvL3gKhWcsxbmNW2IHNnw/LYx7OlE+c1PHyoHvW96VJ9DtYxrNHslAP1mCJEIHTUpnLxxbJbAFhxMDSv32owX0lDKVoKneV7YMwRNHZjurjG/1o9G8RXqPrk4x/BRSJoOPJX6ulkFaHtJZfsL5TFEaERHMUN3hUB4Ar71kDULx45aMISwGzBobB8CikpL3zQIq93oSo/LU8E+oG1WMj+6LtZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 62069242-b466-4458-7271-08df2acad556
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:44:36.3149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLXp2Pp6uMHqYuF/dp7C43tHj4O4L7ie+6ABjdFEJKMY5boI+7OtTtDd5W5hic3ZizYMyGG18GVSDELYZdbql3navsUdCt12FnYRdQ+tBys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9718
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/15/2026 3:21 PM, Anatoly Burakov wrote:
> From: Thomas Monjalon <thomas@monjalon.net>
>
> Testpmd commands should use the driver's public API
> rather than access its private structures directly.
> Note: ixgbe_testpmd.c should be considered as part of testpmd.
>
> ixgbe_testpmd.c includes ixgbe_ethdev.h only to check whether bypass
> operations are available through the private adapter structure.
>
> Rely on the public bypass API to check availability
> and handle -ENOTSUP in the commands.
> Remove ixgbe_ethdev.h, ethdev_driver.h
> and the now unnecessary RTE_LIBRTE_IXGBE_BYPASS definition.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_testpmd.c | 55 ++++++++++---------------
>   1 file changed, 21 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_testpmd.c b/drivers/net/intel/ixgbe/ixgbe_testpmd.c
> index e0d161eafe..e209093477 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_testpmd.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_testpmd.c
> @@ -2,11 +2,12 @@
>    * Copyright(c) 2010-2016 Intel Corporation.
>    */
>   
> -/* Required for ixgbe internal structures to be aligned with the driver */
> -#define RTE_LIBRTE_IXGBE_BYPASS
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
>   
> -#include <ethdev_driver.h>
> -#include "ixgbe_ethdev.h"
> +#include <rte_string_fns.h>
>   #include "rte_pmd_ixgbe.h"
>   
>   #include <cmdline_parse_etheraddr.h>
> @@ -621,20 +622,6 @@ static cmdline_parse_inst_t cmd_tc_min_bw = {
>   /* The NIC bypass watchdog timeout. */
>   uint32_t bypass_timeout = RTE_PMD_IXGBE_BYPASS_TMT_OFF;
>   
> -static inline bool
> -check_bypass_enabled(portid_t port_id)
> -{
> -	struct ixgbe_adapter *adapter;
> -
> -	adapter = rte_eth_devices[port_id].data->dev_private;
> -	if (adapter->bps.ops.bypass_rw == NULL) {
> -		fprintf(stderr, "Bypass is not enabled on this port.\n");
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>   /* Enable bypass mode */
>   struct cmd_config_bypass_result {
>   	cmdline_fixed_string_t port;
> @@ -704,9 +691,6 @@ cmd_set_bypass_mode_parsed(void *parsed_result,
>   	portid_t port_id = res->port_id;
>   	int32_t rc = -EINVAL;
>   
> -	if (!check_bypass_enabled(port_id))
> -		return;
> -
>   	if (!strcmp(res->value, "bypass"))
>   		bypass_mode = RTE_PMD_IXGBE_BYPASS_MODE_BYPASS;
>   	else if (!strcmp(res->value, "isolate"))
> @@ -716,7 +700,9 @@ cmd_set_bypass_mode_parsed(void *parsed_result,
>   
>   	/* Set the bypass mode for the relevant port. */
>   	rc = rte_pmd_ixgbe_bypass_state_set(port_id, &bypass_mode);
> -	if (rc != 0)
> +	if (rc == -ENOTSUP)
> +		fprintf(stderr, "Bypass is not enabled on this port.\n");
> +	else if (rc != 0)
>   		fprintf(stderr, "\t Failed to set bypass mode for port = %d.\n",
>   			port_id);
>   }
> @@ -773,9 +759,6 @@ cmd_set_bypass_event_parsed(void *parsed_result,
>   	uint32_t bypass_event = RTE_PMD_IXGBE_BYPASS_EVENT_NONE;
>   	uint32_t bypass_mode = RTE_PMD_IXGBE_BYPASS_MODE_NORMAL;
>   
> -	if (!check_bypass_enabled(port_id))
> -		return;
> -
>   	if (!strcmp(res->event_value, "timeout"))
>   		bypass_event = RTE_PMD_IXGBE_BYPASS_EVENT_TIMEOUT;
>   	else if (!strcmp(res->event_value, "os_on"))
> @@ -803,6 +786,10 @@ cmd_set_bypass_event_parsed(void *parsed_result,
>   			rc = rte_pmd_ixgbe_bypass_wd_timeout_store(port_id,
>   				bypass_timeout);
>   		}
> +		if (rc == -ENOTSUP) {
> +			fprintf(stderr, "Bypass is not enabled on this port.\n");
> +			return;
> +		}
>   		if (rc != 0) {
>   			fprintf(stderr,
>   				"Failed to set timeout value %u for port %d, errto code: %d.\n",
> @@ -813,7 +800,9 @@ cmd_set_bypass_event_parsed(void *parsed_result,
>   	/* Set the bypass event to transition to bypass mode. */
>   	rc = rte_pmd_ixgbe_bypass_event_store(port_id, bypass_event,
>   		bypass_mode);
> -	if (rc != 0)
> +	if (rc == -ENOTSUP)
> +		fprintf(stderr, "Bypass is not enabled on this port.\n");
> +	else if (rc != 0)
>   		fprintf(stderr, "\t Failed to set bypass event for port = %d.\n",
>   			port_id);
>   }
> @@ -952,11 +941,13 @@ cmd_show_bypass_config_parsed(void *parsed_result,
>   		"power supply off",
>   		"timeout"};
>   
> -	if (!check_bypass_enabled(port_id))
> -		return;
> -
>   	/* Display the bypass mode.*/
> -	if (rte_pmd_ixgbe_bypass_state_show(port_id, &bypass_mode) != 0) {
> +	rc = rte_pmd_ixgbe_bypass_state_show(port_id, &bypass_mode);
> +	if (rc == -ENOTSUP) {
> +		fprintf(stderr, "Bypass is not enabled on this port.\n");
> +		return;
> +	}
> +	if (rc != 0) {
>   		fprintf(stderr, "\tFailed to get bypass mode for port = %d\n",
>   			port_id);
>   		return;
> @@ -985,10 +976,6 @@ cmd_show_bypass_config_parsed(void *parsed_result,
>   				modes[event_mode]);
>   		}
>   	}
> -	if (rc != 0)
> -		fprintf(stderr,
> -			"\tFailed to get bypass configuration for port = %d\n",
> -			port_id);
>   }
>   
>   static cmdline_parse_token_string_t cmd_showbypass_config_show =

-- 
Regards,
Vladimir

