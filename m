Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE1CC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 18:00:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F1AC4114B;
	Thu, 13 Mar 2025 19:00:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E8F8141141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 19:00:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741888820; x=1773424820;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=162RtKUrLHYScnaGJUe/Z/pfaVCRp2Qfa5erOrW7DlE=;
 b=cLGMaawVSsJVU6m75zOgDYrVvEe5+n9avmC+O0MSYPpSLy3vdmPVXcO5
 6L3iCLjjsZP3GAwTEfSX2sCZzMo4U9qFwmqmhwzynLtunnL3eFytNoRsn
 91IsihWSIswHuekdrkDkMFa9RitYik5bRkeea5Zw7o1jGdIjXb0+Lz8p6
 ZOaK0lc71yPYNM5pj5ZrAmTduV0BFIeSs/CzH2p9eJLBl5MhmpGIpnSbe
 q9VML//V3muUQHSseYs0sqCv0eAvCpb/0YLqRtFAFsKqPLnhPoiur/ll5
 lCQod1u0DWJfOKgsMlWOxNBszrc2vIyhMC+TvzlvICEzqFoMJQ+tekMlo w==;
X-CSE-ConnectionGUID: 6zLtJcU6REOq2C0Tw8+Ymg==
X-CSE-MsgGUID: rT33Y4NlRuWGztqT59ZeEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60561697"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="60561697"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 11:00:18 -0700
X-CSE-ConnectionGUID: vsVcFivlR4u5SxQHkaAitA==
X-CSE-MsgGUID: UdvVu3WNTAyWupdi5yp3pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; d="scan'208";a="125656535"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2025 11:00:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 11:00:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 11:00:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 11:00:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKbkSc1MYZAhOmsSTFke+JORSWubp5Up/MUrKlCAqgJimk08uB+PCgknAXcfAXZrgQWGnEHGUAfcWc2sbe2xe4VIDDAnozAgxkT6ZowYT5Eh3srz2uGnjJxRflgmIjLN1WQcqSRf3HKdWxVjRL7nkoINUjiDNrxAjvlO18V0djqXMoM0q3647afzJEB4URRXYUfgflCf+p/pJa+sjt0KM3n/GHoUcyjXdDA1f8CBRD9iIx0r/qiCpYr5g3XEo7eHh2zhwEhxzjdmltjg9tAv0dUjKVRCx4T1Qspd4c57B8ymg1rKgsl69m7ceC553jMBYvXyQIqcVt7Nv95jl91TRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBZTqTW4vKOloXK9wuDjGJ4teP6ji5Ng5Rje0fd77Dk=;
 b=CSM26aiBb0JL4hMYbjuuTWER+ijRtc9iLSkXrOuhc0p4Z9+X+exkqXbhZ+6HRL+hnqenLgo98CWRScZGRH08jnYiwDtWdIDgBmX3pJyn9YxFa5T5ll08lM7uY0XqWaiQJI56zzn5FPUo1zPl5b32WfpWICev2nsiz52ChTzkvEEtfs+uPh2xNY9u3f92qHnngNMZ8/ENDMcH1DOyVO4TMs683ZgpqR9YpoVZ1uTtUZo6Pm1N4Vry5IxSeZNOst18orvNh4OosONMyNkzn3NO/bzgrsYgbGH1HMfjDlGevvl6xRNqa1h99//J4qig1RfY+bXEAz87Dbj+iXQrLOL91A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by MW4PR11MB7031.namprd11.prod.outlook.com (2603:10b6:303:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 18:00:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 18:00:12 +0000
Date: Thu, 13 Mar 2025 18:00:08 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
Subject: Re: [PATCH] net/intel: remove unused reassembly functions
Message-ID: <Z9MdKLmSs_B_SMdu@bricha3-mobl1.ger.corp.intel.com>
References: <20250307160711.747754-1-bruce.richardson@intel.com>
 <3053dd6b-c0c8-4ec2-b945-ad9be50b3337@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3053dd6b-c0c8-4ec2-b945-ad9be50b3337@intel.com>
X-ClientProxiedBy: DB8PR04CA0008.eurprd04.prod.outlook.com
 (2603:10a6:10:110::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|MW4PR11MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 76227d61-d3f9-4352-fde8-08dd6258e6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aUeDcrpPwO56cbbLffw2+Jwl8OqIaft+iBxdkY0abG6sZknMa00By9xe95bk?=
 =?us-ascii?Q?eUypRYnr9R7HaWiNmhBlRO0nGUVepi/35uUG8q7NCpfH4vlgFvd7wNXm+jgY?=
 =?us-ascii?Q?n7xQNpivWmY6I8I6c6RL2S1aljpBJ1BIioy0YWjrI+o3bJ15NVa6Lw2OPeuR?=
 =?us-ascii?Q?ZlmUSVUaRCDPa8/fS8P6+sICEj1EM2kysWlhZwHNcjjOat9yqG0nCKHvHThs?=
 =?us-ascii?Q?eJ4RBM4OzFl3B9P4B+ZH+XmQA3LEO/3EAN64BTF2ocBH+NT74V38mr2qSyuO?=
 =?us-ascii?Q?DGoBQdlbrHyQTqCbqvOjUaQsE5B0PEJxVHFAQuc03AKNnwc9cYsueDGwz4M5?=
 =?us-ascii?Q?PeyEntO6lgbGmRUK+Q1Att/YV1F2nT0vGeytvw56N57bP39urqviUfdUf9OT?=
 =?us-ascii?Q?QUpuYtoRREFJCeKefdp3Czdp4ywJQB/er1l6x5Vvo/qYjjw4rXgCXIBxJ8mY?=
 =?us-ascii?Q?f4qD2lSceMFkJm6s2SbUTczoWnXBWrCfmzgJu2sCnRW+tRCzu+6wkjzFzv8l?=
 =?us-ascii?Q?YCIGKN4DsR9+ORbVWOBmQ/GQHeFosy3XanqcXO7UE+MP2ATI2i+cRySsuxWK?=
 =?us-ascii?Q?dRUeMp8cPltGxL0Cy0amz4kuMCuZWHwZ2XJpB99VA/2MQrL42IFdq/AeogHJ?=
 =?us-ascii?Q?YPEUVJkdp+P/Yr4dsA9rRUgU92b+ir6oz//cyOI82AC5Zr+y/siIZKc9e2tI?=
 =?us-ascii?Q?//XYiBuEanLJc7JBqsdgVZazoYaWJgqYmJX0iQsTTPHHWj6x/PTVGnKWx2VK?=
 =?us-ascii?Q?kL2vbIi810+Vd8jSBdSFaATwe/Qbro8v9zuK5gjmuAmA2SrBD23Z6EGqZB59?=
 =?us-ascii?Q?qNum8RBVyU3hqLS5ID49sXnJzkhfqM2PsQChHrjPW0vN3KWtqEfjU2Z0Kpbr?=
 =?us-ascii?Q?Xg+rKUMFYrTvQ1CZsSjqdoPtIoULYHFpYYl/T76jUpsaNprZjwvbzdybWh4a?=
 =?us-ascii?Q?3iH1BN3Lh111y4QK+kcA4fXTCueO0CBgKH2EXKag5vlhl8J0VWpSC/yBiEib?=
 =?us-ascii?Q?fpHGnfDAt//pFEDMsE9WiH+sCIYDT9QAUU7UDZvBSCNm5Xb720r2az2Ftb9Y?=
 =?us-ascii?Q?rZ10DjFIyH1yhMCRfVycog49hD3S5BuoAymeAjN8waF617fGgM+E9skl0KtA?=
 =?us-ascii?Q?vf9zfKyvLPJKNdWURtcCXodU/VUZQjcVjlJxLzchpEIZmIoc7Nds0ZsfnX/z?=
 =?us-ascii?Q?13zBho1jJhvfQVFVDF0m7giwIpcoycAAaIFcB46QIdVpXCA8+wwagvGplOTp?=
 =?us-ascii?Q?6mVDj5YSXNCQMKcfGME61ExI7OGsUeGmbMuptASNxAYReDQg/0asfLIbCrxu?=
 =?us-ascii?Q?dOVmAfbl8xTpZVdaNqanN1HuJnUsqHETYiLRE2WarddZ0KfBDxGgF38ldJyk?=
 =?us-ascii?Q?vTSlD4cmxxXzB5tHBfSukrkkMRaa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LAeUMBIs04M4r3qcsYQ7KasLic9S+L3sRvYBNMS8hSgIhTPGLbdcClb8UmMi?=
 =?us-ascii?Q?2SLuzn2c1lKB6D5XxgsSihShSpIEuwGMjxOhWsQvkr4kD5AjpqORKAu2cDmC?=
 =?us-ascii?Q?On3ivG8NtxAl6iaGVa8zb0g2SL0qCGv+0aoByf1Brm407JpXoS4ntMcOAS3R?=
 =?us-ascii?Q?KtksqgwYrPNSC06+2kbL+wx19c7geq1AHQFDy2EiJN1t1xlQxDNFQbYorR4m?=
 =?us-ascii?Q?NVQLCE8cA1SIaL15VfKtNPxdrVv4DDJfFd967BgXtsNF1CezzYlKeFCCfdez?=
 =?us-ascii?Q?8A4BYnWtuUI1HT8SK/qcJuVXCu52oSKJPtEmr8sGpFOJzMJUd++jKWTla/5o?=
 =?us-ascii?Q?roC0mXkXYV9Q4JDmnu6ApAMpRubXxiVnRf8hSTLK7znxtUbP0+pv24M6Q14j?=
 =?us-ascii?Q?GH2iDxkUEY3MnTcoAFvstjtXCnKatMhdaQAL24WjWNC3gcJw6HKVkwjmxYYN?=
 =?us-ascii?Q?nFDZem7GYezuIrSO47uEL+nk8KFJAm66R2OZBwwuvm1HGPRGvtASyVDVziVV?=
 =?us-ascii?Q?DKEvq+tZE2sQQzrNH3ggBN2xfLWGHhS8Q4gd4Q0ytMOiEGQQkK5eQXGtuZmc?=
 =?us-ascii?Q?+3vBbZgMMqqM4JD9O5I0j3ehPeDVNpvlZUOWjOARs2oclfJb44dva9H+Sl9i?=
 =?us-ascii?Q?OdrFTfLySawQt5IZUQO0QYkD8O/R6ZH8VSS3akOVqN+Noe3KTKNOUbeRgPHs?=
 =?us-ascii?Q?ewqNvDQ+d6QHdzgLjr1jGMOwm/ZVFiPZku7Kwl/klzH7h9aam1uRZlwlunWz?=
 =?us-ascii?Q?SHBT7TcZ5PbPDV6XxiH3XUo15UEF0i5c1yaZS2eTSqapxuqEGJxu4/7n4188?=
 =?us-ascii?Q?/1XKID8Uh9IULmHO6ybv8Q+XbNo2oMjZJEdDu4OOosnhsbQhj7y/0DWvwi2j?=
 =?us-ascii?Q?spA7MiH3fWKEzV/r+/d0d0aVz+j9NjFVYz0MIuM/Ywjb7E3XB08/623z9n1n?=
 =?us-ascii?Q?ZEN0hYlE7++B4b4/KdGEaIIHrVsgPTDjmVoeftlmKVdfQz5j44d8hcYDRbzI?=
 =?us-ascii?Q?7HZhiB4JHcx+Mu7teMMtpUxI3WFGFpkaW9DYfh/2d+EZU3BeUys4Rw4aA86Y?=
 =?us-ascii?Q?KgwVM0MN0rmfgf1CEzIUMUzWl6FWdTDiwkDNlTGAjlhzj/KWDVl5Q3Fgm/HZ?=
 =?us-ascii?Q?vEjbrcXd1TX72ygSOIgMm5W0DcNbyCKNbWxUx6sZ+sJz9QFinulEtaWZLoRh?=
 =?us-ascii?Q?sslDzhZQeBgCC01fIUfz/mx7PtBJfokjh/2yTstKkVfkP0q3CK/j2KqjCrQ/?=
 =?us-ascii?Q?zYKieD2XGKV1t2vRzAt2cnvlynrzzOcMJH3qg3rAwS1GMtlg8/htSH1ArwuR?=
 =?us-ascii?Q?TYZm0FUMpVaz8Sw7LYgt/82VPDKszG4AbVOnweXgWUuwSb+mJjUJOuLsGTwD?=
 =?us-ascii?Q?bYswmewuuDG+LSoU2WS4cd+ED/kwz0+0dHm1izKGMwzS8SK5dv5m8dAvhN+E?=
 =?us-ascii?Q?lkzcXtiDfVzgRCZIoC340re6D8FRyNdgFBINht+eI1HE7yD1es7E40Re4wL5?=
 =?us-ascii?Q?l1Hzck7/BFbU6bIvAC82rF/nGX5EeYa6kUZ1JHiRG4ldQ3OoivKfy1Za05uC?=
 =?us-ascii?Q?ukPWC7dUKhAhvvMEvwTuCQady0asUEDtvzU4I7KlkF7ao2NdtRBbxAPupusk?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76227d61-d3f9-4352-fde8-08dd6258e6cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:00:12.7807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPEEUSo2ixfv4b7jTlCyDJYWPwCIGaV87dGRJrANJ8TzNYmqhbDuiy5UEtbxAQ2Ypkllo+fbUTxNnBVLABLn+C0GlZvJeGKXNmAXkLBvj3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7031
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

On Thu, Mar 13, 2025 at 05:48:28PM +0000, Medvedkin, Vladimir wrote:
>    Acked-by: Vladimir Medvedkin [1]<vladimir.medvedkin@intel.com>
> 
>    On 07/03/2025 16:07, Bruce Richardson wrote:
> 
> When creating a common pkt reassembly function for common driver Rx
> re-use, not all original copies of the function were removed. Fix this
> omission.
> 
> Fixes: 82fbc4a4479c ("net/intel: create common packet reassembly")
> 
> Signed-off-by: Bruce Richardson [2]<bruce.richardson@intel.com>
> ---
>  drivers/net/intel/i40e/i40e_rxtx_vec_common.h | 63 ------------------
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 64 ------------------
>  drivers/net/intel/ice/ice_rxtx_vec_common.h   | 65 -------------------
>  3 files changed, 192 deletions(-)
> 
> 
Applied to dpdk-next-net-intel


/Bruce
