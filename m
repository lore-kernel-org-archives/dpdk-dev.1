Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C266CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:51:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 903F7402BE;
	Tue,  9 Jun 2026 11:51:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id E98254025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 11:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780998664; x=1812534664;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=oMxkIYZq3ymFjoJFmSNcxDKr+3wqUGjDQPJbIxmU7w4=;
 b=aBIKUkTJzvfskLbjTozfas8psFKHIhjDymbWwS3KFqbNwHbwcXYtyswe
 WXtlII9gwvK1JrdtyAfbDmJMp5gE+kn+1zRqLt00MgbvHpimgATHzBqZb
 xtDRQOJ8SJFFvi16a2M52s87gc9PPHh653lacHvcLv7x0QAtuHUSHyIgj
 K00n9pUIBcfpFasY2NBZgEorTXioM5+XGejKCov2q+9SICtQr+f5zTi68
 x+FaznV/RVABIF+O+AAmM1aiUr1DDtelxs+o2TOIFIJgbyZnz9XeaU15/
 jkMdtQOJI34I3wPCmOC4hDoVGHNwU7/oRYSXvrKRHTUNo2EXuSNkbVrXR g==;
X-CSE-ConnectionGUID: nArJ80n3QAGsbPIkxRlNvA==
X-CSE-MsgGUID: QP9Q8LF8Tny1u2WFhJ76GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81606614"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="81606614"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 02:51:03 -0700
X-CSE-ConnectionGUID: 3jyL/C3HQuGHAwgXFOjYZg==
X-CSE-MsgGUID: LTP5buxWSEilX75tEV56IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="245853058"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 02:51:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 02:51:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 02:51:02 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 02:51:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHnmpDm5j6GaPqM+IG0FcbP2ldnqLGRLDp3+Ckw4xi4dlLy92IyE554Wjv1cZofVpbqfUHPp+OO3sxc2hPM8pUXc7HCEocYjrSwhbFfHeLHMSzObG2Z4jsv9JmVRn25yVXj2EOrNZMSNMJjHi4biBSqnvymDm1llD+6kMwMKAtboqemHgVhap8h2ZUGvsG4x3GGGEMGXYY78miAOi/39LQuQVF+SK7N8zcp08I02A001PboZOhRVhBpzsd+Ux5ymaje/zfkN0JB82ggzz+0crIxHKFzGhtfIvi/2LjOXMN2pWRrG59R9nKHNeN7pQh4/7/J82tgpY2KZ66TJC1qXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSEA/BYF3HOUE8bbh4+EEgl4ZxUmojs6igP8oMFYDoA=;
 b=hZGnsKbCSPDPIQxvpFr4d755YFfsGr7/zpN+7IetKekgiHNzy5rGkiyYks+VcrLKXFdUmg2LdwXVSqgBxzEflT7+Jc/5uug3BQbbW0qjWkACwygHTAvD92GuOvnLZLGGA9XRPPZxRGO/dhzWSnXjuKDdkoSGR1D85eTMIN0gcx7tCBIoxk2sMZOwSEKFaaEyqzRl3MvrPqRLjkcaTe7ZIZWLXAvLn2aAB3958Fo+vjK6hlRu3iMxAsVFquZUFwrFUayCI+ogg7cMHPvAt/4NCz1KbAaRys67brvGPc8X2OeVWEOLAsjUqt16inhgznNsJFEKVq9li2DnKUnZvZINkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB8860.namprd11.prod.outlook.com (2603:10b6:806:468::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 09:50:59 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 09:50:59 +0000
Date: Tue, 9 Jun 2026 10:50:53 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <aman.deep.singh@intel.com>, 
 <shaiq.wani@intel.com>
Subject: Re: [PATCH v5] doc: improve e1000 driver documentation
Message-ID: <aifh_SRQq2aT5wbl@bricha3-mobl1.ger.corp.intel.com>
References: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
 <20260324230343.1050223-1-chaitanyababux.talluri@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324230343.1050223-1-chaitanyababux.talluri@intel.com>
X-ClientProxiedBy: DUZP191CA0064.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 4132a5a3-b44f-4d51-669a-08dec60c9bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 1QYD2Th9q2ow83k4ChtvEO/r04K+wsxOM6tpcqMVa9tBD2XT0ON/oGpHPHCCjYsduhRmhW72txPbgyuiPFc3XllC+Ft71jMfOf92Ar29UvektUcTRKbufuBidPoeC8X5wMx/JqKCy8PKOJul4zFUqdYt3TFauU8YOVcAZnhOOnFhRhtWToqOfjEJjf1hmHZ0LtAxMRfSBeEKXEd9uMDaOQwvonGidwTtS3RXL86Ti9L1j++l2x2XydMH6qP3FUL+1RXVnNvgWFMSb//6P33l37HiQE3GqdP2EZrKQynKE+xApjzV/alpF1nRExJ9T0s8lC37AZ1agJGs8fLWjkcy9nyxWVNYe9N9KsUpKIs7e72PK7iZTEtvx1nJEFSTi/V9oMtnzBdy5f6oIa3Pi+MvIvOgoJMWFUom4PlseTxBHBgTkzCIlwFGR3JcrSiGgpaJ/P2ptZ0Ru8twNOuOhNy1RowSAUmjbmEKAVgfF46qd3sDwuPa7gg6iP67YcPgWLVwgyVhKlq3ZKSr770s8v409Un7SEaU+NyL2vU8gkr3aVWZKn55BA8j6YJZEMK9RSoGx6jo9HE3EkyDTxdcW8iLagMUMjAppLWHFYh9ejSTYd+FClswBSBSw42+ioMpFOQ+QL4TMWTiFV1ap2+22DagM8LkEL79ZTz0/3HlBqhX6XpoUPJ4DnHzcH3oJ13zVdt0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmJMV0d6R2lidmV6b2k1OFFsNW13Z082MVgyR2VxdmFTejJTbFpUOEZYUUdI?=
 =?utf-8?B?UzdlMzRrUlgyWXlKY0JFVXpxQnRGZXJ6SVdwTnBNMWxLOGJuUHVEdnpPNHZB?=
 =?utf-8?B?QXZESFFlOHdtL2pGMlk5YkFkR3M3NDFsRUNqT0NUUjB5TE1pK3NqNzdsaDA5?=
 =?utf-8?B?TGVycElIeTlvd21pbm1Eam5BcEFLOG85QnNhc2lyWnhORUc4OXhsMklxVXk1?=
 =?utf-8?B?S3YzUjlpcUh3TW9lSTBHbTNuUUVDSFJzTFNLMUNGa09QQWU3OHJyY3VNUWlV?=
 =?utf-8?B?L3phZUJnYlAyR2NvRHU2bytGR1h6ekEwVldWNDdaMno0Mm5SUzdYSVJrQUt2?=
 =?utf-8?B?ZmN1ekRKLzB2a1RwaDB0Ymp1U2M4djRyb1FqUDRDYlNkYUZyN0hsd2k4c2k1?=
 =?utf-8?B?VWdIc3RaR3IzMDY1Y2tZSEV4UkNLZDNzMWcxN2FyZ0d4dmtlRjA5a2xrK0Rk?=
 =?utf-8?B?bXdNUnBVa2hEVmF5ZHJzUnpIb3pLai9lOUxCU3hDcWxrRzF4czZGckoxUFcy?=
 =?utf-8?B?NmtoZDFCdjZBNFk1MWUwYmpYMlBqQ09CWU1WUG1wem9oY2lOVjFYbTI3VThx?=
 =?utf-8?B?bStxeCtPT2cwdlpaSzZVZFNxVGcyWm9vUkxTN1QwSjAzOU1wSEt4eW1ibEZO?=
 =?utf-8?B?bzJ6Nk0yQnNYQXI2aGVQVFZoQzJRRlZNWHA0eHR1MUEzcmJhSUhRNG9hNjNl?=
 =?utf-8?B?MmpsOUdoWEx5djJUOEZDWDcyaUNsc1N4UEFNLzlGUk5WK0QwZ0NpK3Y1MHVp?=
 =?utf-8?B?ZkNQeSt2SGFsdHhON3E1OXpWWDBxZ1MxRjFrUGNieUdZQU80bmdYb1VQbVgv?=
 =?utf-8?B?blRpOEp4bFNFRjJIRVA3QnRUYkNPcmFlQy9MVnJsOWxCMk56ejh3b0NISkVp?=
 =?utf-8?B?NW9FMjMxOFhQSnlacVZZME1ES1h2L0FJR3I4RHYwRkQ4VFpxUENCSHdacElQ?=
 =?utf-8?B?Ykk3UlVTUkw0eGVrUHV4ZGswaGNOeEx1S0xmRThwb0FwR3lPdncyTXVJTUp3?=
 =?utf-8?B?V0xSMGpZL1poVUtaenpXN2xPb3pGN1J1alpOUWplMDVNaS95MlFXdmlCRVB0?=
 =?utf-8?B?SDR4aDYvOFJNa29PNmRzN1RWNVJiWWhIbjFuUTFOVFVtQ3hFRnN0MzZ3S2JZ?=
 =?utf-8?B?NWFvNUVQZWxqV1hNMXVsRFE3a0w5NFlxZWJVS1liSWtrVmlsWmxVL2hUcjk0?=
 =?utf-8?B?bit0S09hUTRaWVZGeGtKNy9QZDVTWGkyVUxXM1ViYlZjS2tOTDRqejZOcVR6?=
 =?utf-8?B?L0ZCSWdqUWVtQnR5aGpsZ1ZqTTIyNlVuNU1mUnVPWFM2dkZSbXFSR0JzNEJw?=
 =?utf-8?B?bUpWeTBnbGF5VUl6SGpRK1NlbTBCL005NTVYLzMxMGk0dEV3ZGNieU0yejVa?=
 =?utf-8?B?RE8xNjRBRHV3QXRwQ2ZhNFVYcUFQR1c4VHk0a0VUVFJoTFU0NmdRbnc3N25w?=
 =?utf-8?B?N1FJbTRPN1QrSmlUeC9uZCtHNXNPZHA0Z0N4bXRTN29qNVRYd3kxRzlFWU9Y?=
 =?utf-8?B?SkNDb1pBM0tmbHNxc0hlWWpKbFM2NmVvMnVSNG9yWXJHZ3IxK25QQjNLd2M0?=
 =?utf-8?B?TUxHT0lBQUdlM0g0U1JzWW1rTEdwYnpmQVA1QmVPTDd1cU5qejhGWmNnU2dl?=
 =?utf-8?B?dGdtMW5kOEhhVkJ2dUxJRXhEZFRBVURkeThHaExpalphMHUxS0lreUdNd3pW?=
 =?utf-8?B?aTd4YWplb3pXemdJMVZTbFc2bEJMaThlZ0pkekpxbTVCaE5NREw1YVlqVGpX?=
 =?utf-8?B?cVBjNFlobFptenJhYkUxR0VRWWhuREZnNFZQS0tLMHJkMk1ySm9DN2RQbDlN?=
 =?utf-8?B?bTFBM0dKL0M4elIxRUEzeHdaWVRabGc2VUZYVklmUnVmdWdzb1ZIRmQ1eHcr?=
 =?utf-8?B?RElLdUZJL20yWnFOUWY1ek1PUTBESnlyeUs2TS9FMWZuYXdCcDk2Yy91NmIx?=
 =?utf-8?B?S1VuL1BjZENmOVc0VnJJbkJvaE5aRitoM2ttZTk1a2tVNWF3QUUxSWdzT0xD?=
 =?utf-8?B?V1ZCYzFkYllWOWRSbHNFa1dSOFg5TUpOSkNpa0I2VUFIUzhpOE5hR2FObUow?=
 =?utf-8?B?WEFLUFNjNElvL0xuNEpudVhrUHpyZitKMHJhYUh4eVBpRVBZZHVJLzB3VmdQ?=
 =?utf-8?B?cm41d25Memx5eEdHNEN1T3ZrSHFMdDEwOXpSUmhKVTEvNXlYeGNiZ2VTcWhW?=
 =?utf-8?B?T0pYUTlNbzBsTCtORnVzRW5kNzN2QU4rcSsxUEdGM05IMm5rSmErV3pNblIr?=
 =?utf-8?B?YmhHL2tWOVB2TTFYcFV6MklzemsrRWpQUitIVU00aHZvZVhKUW92VG1xSExy?=
 =?utf-8?B?bG5CSWxjUENNMDFFMEVMbnk2WEMxSUVwckU5cUpiZ2hOakltU2ZzTnFuWldm?=
 =?utf-8?Q?/WXJuhc8yeDUGnb4=3D?=
X-Exchange-RoutingPolicyChecked: eAO6fbPhMXsPB7MJSQwDje+ZpCd85x9HKh4ITUVWD+5slolY5oPyx628J8sC9MHVAZ8k6LyKz9FSJUgTxykhEIDaQdXvDARkVkCfB38ZDDVeP5rCWScf57x9y3iBRNU1/AHGtHCNPZwhOozRogdnieAp3h9+IqHD922yrHkyAOgPpJg4SwEwuECdvDHPwzdVXedPhqcsanUpiWWehfybDLeWo/IEZ+xzBybfR4YF6xlDDuC74sBhJ8R+Keptr2HxpFbPu7RoYv489bIbH4d20tCxMCnmbsvn1Q6EJhHGqPop4THLacHN13NKqdnOONKnY8FiEk31p+JfogVI6So9uA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4132a5a3-b44f-4d51-669a-08dec60c9bab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:50:58.9692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wlbo6lTvuobDujCE8po8ksqW6DI0VnL+rMisk+VDmjcvcl4PtwSdh9QC8Y6shOUxgsdh2CdzFLU03ZbUMxJHAH+FdL3MgWXFuV9hkiyeYqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8860
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

On Tue, Mar 24, 2026 at 11:03:37PM +0000, Talluri Chaitanyababu wrote:
> Add an overview of the e1000 driver for Intel 1G devices.
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> ---
> 
> v5:
> * Aligned PMD names with code.
> * Fixed wording for clarity.
> 
> v4:
> * Fixed RST structure, single top-level title.
> * Used ASCII "PCIe".
> * Adjusted commit message to match content.
> 
> v3: Resolved apply patch failure.
> 
> v2: Addressed review comments.
> ---

This doc still needs a lot of rework, and possibly merging with the igb and
igc driver docs.

However, this small patch is an improvement, so I think I'll take it into
next-net-intel for this release. One small change I'd suggest below, let me
know if I'm ok to take this on apply.

/Bruce

>  doc/guides/nics/e1000em.rst | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
> index ed4f57e9c6..a101b54020 100644
> --- a/doc/guides/nics/e1000em.rst
> +++ b/doc/guides/nics/e1000em.rst
> @@ -4,7 +4,20 @@
>  Driver for VM Emulated Devices
>  ==============================
>  
> -The DPDK EM poll mode driver supports the following emulated devices:
> +E1000 Poll Mode Driver
> +----------------------
> +
> +DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit ethernet controller families.
> +These include:
> +
> +*   e1000_em – Intel 8254x family devices, including QEMU ``e1000`` emulation.
> +*   e1000_igb – Intel PRO/1000 PCIe family.
> +
> +.. note::
> +
> +    The ``igb`` and ``igc`` PMDs are built from the same driver binary but are documented in separate sections for clarity.

The reference to igc here is strange when it is not mentioned above
alongside igc. Would it be better to put it in brackets with a mention that
it's 2.5G (no not part of the 1G driver list). If you want I can rephrase
this on apply as:

"The ``igb`` (and ``igc`` for 2.5G) PMDs are built from the same e1000 driver binary but are
documented in separate sections for clarity"

> +
> +The e1000_em poll mode driver supports the following emulated devices:
>  
>  *   qemu-kvm emulated Intel® 82540EM Gigabit Ethernet Controller (qemu e1000 device)
>  
> -- 
> 2.43.0
> 
