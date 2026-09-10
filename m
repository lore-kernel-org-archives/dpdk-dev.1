Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B799C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 07:47:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03ADC406A2;
	Thu, 10 Sep 2026 09:47:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0D6914028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 09:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789026463; x=1820562463;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=7wbtEcJYsyodsNudCHNm7YqiPva9fi/+GjitFjTKDJg=;
 b=hWrDfzvSGb5D9w6bTbHUo3o7y3simzeNayN0cC55v1FGvnkza1nRfVLs
 NeJHatwqLe6OhMr2GofcHLFTKEQt+BaScSq7lnmJ9gWuP36Pg0nOIoFMv
 WR9zkYrOy8P34UvP7+27MCxF/mN6PXxYIth/MnuihGt7O3StcAzDElh4M
 NBvka2imGwbZ47miRtuJmXvhmnRVctQenDQveRXkFQ4kFvz0k9ocg6H1T
 0TGrQgmNhGyRUKfZNLhbqG3Yz5upQDo3S5ACb+ZYAXxbdXwKzIuRFHg7g
 sl/Ed5VAUCBAhleA90V+oNaFHyiNopJ3xvt871htEvS0TaJTpzW0T+la4 g==;
X-CSE-ConnectionGUID: kNojJbtITEqEmGxYdXAcRw==
X-CSE-MsgGUID: 7zRLkTHpRXSFheb2ROtxKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="77026442"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="77026442"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 00:47:42 -0700
X-CSE-ConnectionGUID: A2bKlliNTIeRfJEk4dcPKA==
X-CSE-MsgGUID: NbB4BYNwTdav23uH7SAkSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="273522962"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 00:47:42 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 00:47:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 00:47:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 00:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J//KYWospwvl+uVt6k6Wh6l9lE+r/1QYubSd70X6U56VsV2gNmE+nfmxRpPHSbMa6dwi+Nn5mpcnast1fPeOSdQgAlaUJQ/AVMNaqXtSlUQTVGNOBX+Fc+TJ0CfFR8eTfjZZGY5IeMLLXTL/LYAzYki0XqC20dCwaU9nDicGEL6BYyNXkvLB6v9V+tW1iH1D/jJTH5TwtJ/sA/RnNhpGpKkzTB+lsLSZXjGMlJLq5Q9RZxXb/ZrxUVeUArm3dcuVqTP3f78huLIaK36S48/Bu+NR9EG6XZTaUcCu29pJAWDcskjW6TQ5xG5dPTDr6vItuwK4KDQql6A/TI1/kErk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeVIr5d/WabdWkV3PXefHd1YIY9Qwure0O3S3O9sa10=;
 b=jiUd4+9XZCcfRFcu7urCr99CXZotvQDTtWEekuBav29Jbjp7Bnuv+hWkj62Itcd7CKkwmHGWr2MD7rj1xG+CYcx+Mws1doF/rz5cH2UU5fQ88BPpjVuPG2e8QDjb75CvkRu25PEf0QGqdYFTEKEndqKO/AsqWbF+rCM8GNvWLkapUt63cBeBWsqaJCtP7zWatfGoSnA5C2Qs+Nu1HwplUNDVFgMTzHweA7zeZ/zQQKQlBunsmBFdclTSl1Am1gtVgn8WTIKFLx/uZRrHUeDL5QWYkK4kcs7jCZYoFcOKATLEBl+EuYevOSnAtvUN9+Jr5IEOycztH0fCQOA7KqZZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:47:31 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:47:31 +0000
Date: Thu, 10 Sep 2026 08:47:26 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Patel, Atul" <atul.patel@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Shetty, Praveen" <praveen.shetty@intel.com>, "Shukla,
 Dhananjay" <dhananjay.shukla@intel.com>
Subject: Re: [PATCH] net/cpfl: fix VF ID calculation for vCPF
Message-ID: <aqJgjk1DHxMoejUp@bricha3-mobl1.ger.corp.intel.com>
References: <20260827212216.765057-1-atul.patel@intel.com>
 <apqfA2kvaIIW11qQ@bricha3-mobl1.ger.corp.intel.com>
 <DM8PR11MB5670FB19F3D640761679CC1281BF2@DM8PR11MB5670.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5670FB19F3D640761679CC1281BF2@DM8PR11MB5670.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0226.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::21) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|CO1PR11MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6a8ab6-9d3b-461a-f615-08df0f0fc4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|3023799007|56012099006|6133799003|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vwcJNpcOf7Ohg69l/WBPkb1/4ACir/qd6BHDd23klYnQAwRn914jSEyHoLvTJHnBSUt5XaHXwdxlOmnpSmSU5vWjqdl07QZQEBszl+k9qwsT5wkk2Sz5k8akjs20/6OwLzq12WaZYnp53dqHdUZ32xrKm4QIagNyWqQ2R6mZo73+e/6yufy8ZT49TwgAeh005dVHFxa2rLXX+TR8+Cg4aXRD/EFddtc5dEpyyDFIJwpcPWs3G8k/4YKcbvte8wwkaoLYbTcNzIsxQd8YcEvSDJeG8On4nxEGFSj96NsLDKfR0BCQ56amvl3zM68rDU1csq3CR2uOMUJXeDLtWlD0H7+4GaN8rmV1+wrF1Kzpyp2OlkdSYghJL95uUqYR6koNaGnNMro3WPiaRkZmBI0tzXCoDDvP9DptbQCZ0RQ0D54ejdyOWfQ99xIgzAEMn6eTUnOfoOhsV1lkrcYfmfV7R6Z3Tk2noW+0xWBMXffPEbN7M+JXzKdrvk3FzEH0nh8Do0npclwJn+UVRaEyAR1Xs+CmMMlW78YCS/7XgsxCKem/RHayFN1SUFkN3/BhyuTA4nMrG5WbkwBo2/9BkV7m1zghzVQBH8SumEsb5eKZ5+hehtOtOT/jLTp7JvsiRq2DPUshxoB/hswWRxG25yzbCS2fkX1mf6tI0RtfPmjmR48=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(3023799007)(56012099006)(6133799003)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nHHrL/OlwtumPgJbiDk5EKhOzW3hmKtD8VpjsYTurB+1Leg4lDen0yRZj6qe?=
 =?us-ascii?Q?GFTWdIutMSpSrSKQlUg0SNLAO2epXs8dBrxdGwBIEXa7EP9SaTPfLNOxG7/d?=
 =?us-ascii?Q?9VthTKPi/2GMLJZs9v+acOlneyNmhf8Pa8cPaqeLT9XGKVC7tPUHAC+13wpQ?=
 =?us-ascii?Q?sTBx2iLHKgnCL9XaLl35sRL57SeG98yRNkXMrFQ+O4XKhQncpqvW+Jqh6ODH?=
 =?us-ascii?Q?lrYMbNsMH1c1eKphIl/C6IF5Ha4MqyIe5m2zJn6fAAjXTllrs6x5eTHVP7Ti?=
 =?us-ascii?Q?UqSYPYhngN7rqApAhgorIUV1OoQUzivhUUumW2HylDpNHOsJjy5EvvNtVZg1?=
 =?us-ascii?Q?GYw8Y/YPt54kSqFdC+w9kGHiQrK93qiEfjuyhUAOhAVy/+5nsm1bsLoGSEL9?=
 =?us-ascii?Q?6Uu6BxTU+HXp3jDzQ4QjM0mLnfh4PCyTneSRseYSqC29xZmBw7jKNvllnM0m?=
 =?us-ascii?Q?CrIbv0u61OWiRG0EGSzzG2WzUkdX6eGKkcR2B6VMiJEkCUfNbgdjA2+/sW+0?=
 =?us-ascii?Q?kPboM/s0DA1cvvl6m/eWDflX6761yXfJOw+52n5Evv8Td9JKJUGJlONbKR3e?=
 =?us-ascii?Q?MZlF++Ka9cOZb+0h+9Ktb6gWOufZFfy5JP4zg0glpHIUuX7EWzw/1F7y/l1a?=
 =?us-ascii?Q?aJyK1qtXiWU/sxrF6E0d6gJbB4h8oFUWXpbROG2dlYVl9aPyyVJGT/Gxs8go?=
 =?us-ascii?Q?uS4znZxVmRa9kJXoTKIV+CdHBinAzjnChy3FbSJ4oefwyXtsD3YVTptI2yGV?=
 =?us-ascii?Q?m1HX/RZF4XLwCIt9eaQkSV43R/j3yCh8P7w9KtQE3fmMlv7dpazYqXDp0P+a?=
 =?us-ascii?Q?z24CgYnZNY8W+Sgtqx+Zrq6GteMPYOQG8MEfF87MqpDgKAElwhZzjtnQah9o?=
 =?us-ascii?Q?V6P6VUozbkNHURgy+OaQx6HOTFMJzyzlAn3Gi+tIqV4WQf3tc1opAMlWVqHy?=
 =?us-ascii?Q?ADwCAg3ajBEIivstTw+l474u9qsC8M5ihijPbBlA52sKk6VuTykakWIVAV+V?=
 =?us-ascii?Q?QU6/emKl0LMFL88kFQ5R14jXUgjr65ejh45/YjwrNJils9fh8eJKZEHtYjDE?=
 =?us-ascii?Q?cQA0qC3irCW/JFYiIxzuV+SxtCOXBfUCHcEWRYUf4i86isAyLGg7w9ICrM7K?=
 =?us-ascii?Q?yNeXTMgRtNEeT4w9Ztx5vFFdzKOMVwmIuuxgEBROEyErxqyLx3WtSQfmwnrx?=
 =?us-ascii?Q?jSLQlFhzYnoVEf8km+PtrpDGFV7RBvwWerD3AEO90zWXbrmjdbrlu3v2BwRn?=
 =?us-ascii?Q?vCTb1kGzBtwEGVTaSyoH0tYsjpGDIEWVM1jhStBoXRjS6+w4GCRMiTZLxjLF?=
 =?us-ascii?Q?BCTgyHE/OHq5U4A9CA2yjcQJmKX41wqcve7ixTCKDnBDkovzqhSzG24yrq07?=
 =?us-ascii?Q?yk4YQGaok2h/t6i5Mz63X3vz+AZhPEZxcSNYcEqO9mfnWJc5ffIHM871RsJA?=
 =?us-ascii?Q?j5VpqQ610xqIKrCYyzx6PVJK47ABO9U4Go+gKmdfgb+Cz+pHmO22lW2zDXW9?=
 =?us-ascii?Q?7+L/kwPx2G+hL4j7cTwVP3+cZJYzVSqk8+6d7KJcRSOkDcZuoT1Qz3J1dIW2?=
 =?us-ascii?Q?+0IO9ZLEIIYYwlVJYedReyNb1zZsr2p4oBLaCX5gBZYDY3W9MKx/Y22KkWdC?=
 =?us-ascii?Q?MAaNPhQQTrIWg5J74l56AeOuO7RtyyiB4M9KWrcHNmchL4zyLGbdKdhlFJ7b?=
 =?us-ascii?Q?MXgqySMpaNpT1hWD8n0RGfA4PjWP8ZeqLsVUtpSwr5vTDemRsntNjbQZWOSd?=
 =?us-ascii?Q?xilZdacGyR1cuaoN9RCAk2KTBniaXNE=3D?=
X-Exchange-RoutingPolicyChecked: jtTpArowiBF3sfzaDhRW9m4cLH+FEMK6HofanqOGEkUuThQd110vmH0NoD74ODmls6P9W4VQ9XADYlspWnm0nekDD40u8L6k72/E/LXGcKp8HSUa6sVk/vHiwdUt6+zb+Y2p5mJFiXyjc86bM84mUzK1vvviOPdvQ+ii/l9jgxFcmdXy23y3D+ZXWe+Vt+70Q1ZB44gZmzQWxQs6FwROmnHZaZsN+QxD5mvuxlRXEOKWirL2sCA3ZoVzT5ynLc2UJh9yMTZbQf7Va2nVFbIYBp8t0ndy7QWF3ZCPoTN9Ho9GmRMk6bPwHh1G+yTM3jsXMq7XT5T/cfCyVpWv2/zwcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6a8ab6-9d3b-461a-f615-08df0f0fc4e7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:47:31.5274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxozllxsWTF97fMAdOboSmfQ/imj8mbq/h2Kspqwrt13Ay2m7i0E/6c9pPvN6nuhhrReiMO+oCstHBXS4Pdl/JXbBz8y0bN5+hFU/V0L+KA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
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

On Thu, Sep 10, 2026 at 04:13:07AM +0100, Patel, Atul wrote:
> Hi Bruce,
> 
> Thanks for the review,
> No, the vf_id is not meant to be globally unique across the system - it stays local to the PF, same as other devices. The pf_id here is fixed to a single CPF (CPFL_HOST0_CPF_ID), and the control plane expects the vf_id in struct cpchnl2_func_id to be relative to that PF (the header even documents it as "indexing is relative to PF specified above").
> 
> The subtlety is purely in how those VFs are presented on the host side in the vCPF model. The VFs belonging to that one PF are exposed to the host spread across multiple PCI devices, with 8 functions each. So the PCI function number alone isn't enough to recover the PF-relative vf_id - it wraps every 8 functions.
> 
> For example, with VFs enumerated on bus 0000:af:
> PCI BDF        device  function   ->  vf_id
> 0000:af:00.0     0        0             0
> 0000:af:00.1     0        1             1
> ...
> 0000:af:00.7     0        7             7
> 0000:af:01.0     1        0             8
> 0000:af:01.1     1        1             9
> ...
> 0000:af:01.7     1        7            15
> 0000:af:02.0     2        0            16
> 
> The macro just reconstructs that PF-relative index from the PCI address:
> 	vf_id = device * 8 + function
> 
> The previous code used pci_dev->addr.function directly, so it only worked for the first device (VF 0-7) and collided for every VF on a subsequent device - e.g. 0000:af:01.0 (VF 8) was incorrectly reported as VF 0.
>
Thanks, that is clear now.

/Bruce 
