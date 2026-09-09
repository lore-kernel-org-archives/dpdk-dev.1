Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29329C79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 11:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48FDD40A76;
	Wed,  9 Sep 2026 13:23:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1321240684
 for <dev@dpdk.org>; Wed,  9 Sep 2026 13:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788952982; x=1820488982;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=CxFFW9QV6JKZGFHTCoMgIYDy8zXDix5RJnHyK+QIG0A=;
 b=fn/ZB5fuwFTBE+2jv+WvI081rv8zNxSq5xSxsd4hbx+0HK5j8Jra6J1x
 la21qZyZB4baZ02c81vXh75AnGn7I2RtIAk87i2gP601dJHZjXkij4kOF
 XRz0vSYT6hKuzDVzrxeMmLT/D8khE7Tt6lZZ066SZ6UE5CBHIYfVVxPTi
 ktveP/yzXXnxt+Gj29VqqWgXq8KFPMxeDIdv4TE7bMydmBPQifYmc91cs
 HqfvGizA+wc5giR6GTyf0I74mnegGVzU2vGDBcxWXekkZJeUnC9XcN0f9
 q35KXJeuoocWlwKg8O4eRhiilvt6PLd38vtG2aOnaE+sVHEBHWRatuU4r A==;
X-CSE-ConnectionGUID: ymb0zE7+S9m2NgiAq0edJg==
X-CSE-MsgGUID: 3f1o21S0SXaWRwjZ/bGBBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89243820"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89243820"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 04:23:00 -0700
X-CSE-ConnectionGUID: 1jqey1U9Sq+T1vn0ye5j6g==
X-CSE-MsgGUID: DPoe/hIRRQ2q2snVK9hS/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="269959845"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 04:23:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 04:22:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 04:22:59 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 04:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8+XmfJay+AnzCludZHyc99Uij28a29sFpdX2CrBUrlEu2P4YkcXBNGvqRVST1E3ErF5YG50Z8sDh0Ds0dmWqP346KdNYbwvAKqi9Uv1i4RrXueukeEVGaio8d/lyRaD69Wr+is95QVWFCjB4Z0FjNmKQL8JOlg4tEkjqZzmti8h8+hMGk96tyAeWwEf/O5ra8GGVC8r514n/hQCPwuax5KO8z1NG31pz1OQfm1RDojt2b9ALp9Uqv5Sy4qmPKnGJ3e54GekS1BFcbrL6dE6aCMFyjMBFUxOaCZcXN/6kRa3hpE524ip95+QJ2wsygvHuufXutft2azO1FsL2x335Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p0R3F9R9zScp/JgsHDNWvOkjmZYX7ZqrIyhZS2gyC0=;
 b=Ja+TiFW7zBVaetcTpyiHG1Dwc2UqUGeEHIIZHq8KaKc0aXB6qnJBi+ceVUCm8kRggmxmBW2ClYt1Xe3c7yQilgC7YMWrVO/IoFaqxJAfRzu0jKvazW/iqscO9GkZMKtYi7O58E70JSsv1uHp/WQnm7jrVLxaeGZxWOglJeMQMK8zSPbDFd9fZoJzSeu50wuUUGENanXohWzGvkGD9n3VzrY/d4xaTE0wpQfD6n5rStdyRKf+JzrNkZrR7AIphOuREl1V+J2f5gxfQoZm38yRntOOxOUzrdJoN8PAN2mutZXM5zzBmqRVSId7A8f8qECg6f7YDCTLpmeM4MKr5mb3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 BY1PR11MB7981.namprd11.prod.outlook.com (2603:10b6:a03:52f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 11:22:56 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 11:22:56 +0000
Message-ID: <e72b083e-d21a-4011-b044-ab4eba93dd32@intel.com>
Date: Wed, 9 Sep 2026 13:22:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 12/26] net/nbl: do not use VFIO group bind API
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Dimon Zhao <dimon.zhao@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
References: <4f9c9b5df6ce0b8404465c8e6ac68b2bc1f5e5c5.1788947938.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <4f9c9b5df6ce0b8404465c8e6ac68b2bc1f5e5c5.1788947938.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0509.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::16) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|BY1PR11MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 393ddeeb-6aa9-4105-9e78-08df0e64b1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|56012099006|10067099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pbvv6muzWabKE+rxfdK6j7/Io7STu+8u2+rvlwZRz1+u0JmB1EycEZzrY52IXJOCzRDOfP7GNOFo7lpc2uBbM5PO0T2et5yl5ePnFnm+O9mrxjKZgu+i1QYv/e9fzXGn6PnKJm+bS5goYeWoMeLwc2tEKI+yUtMibKRUCY9/PdZ7UbAoqs11nPLImNlDYXJ90f37MNm9A7gQrh+3wB/Vz21V0fC9xOWPtUzG8KuRHxkNSlo5IeX9csFNSSjKiXzkpFpwPpUhREMVXWh07EgzQB4wUFk9sKq5ZgTHnsftm1FKVvAxqs1cxyCicLZnEQvUM8cwDQzZVxbiVJNgbhAHpe6lWscCe1BUnAtIY8z4KnLOyIg0ZzW2b0Cumtj/gXDvwERHE2+v/A7AB8NV+0TLoXLLSoXkGY9nBehHbCybHvhMq1PDma2oG/D0qshElnjd1tXdQ27dfCuZ5VGcX3HpxstyiHcHdvkbkoK8Xdrvk/A4zlbdShot6cJHxyqTYSL4EXoONUBkFtghVfelPRdZlFX9G7kFz2u4CTzF7l1uduKGCVJFoMNV8vmPOJwXqXFYTZ0RrYxdm5CQiowdcFgPVtQNtPm8lXkY6ypzkKCqldoQtPLGK8wGHjf+sOi6U8qz+VcoNNFHtTQP/7vPFl22k7u6TBT5GLxf8nY3Y40UrLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2g2aXB4NG9ENms2QnJhbFEvYmFIWnlMenJ2K0cyUDhiR0lOWUMrR1VhTElP?=
 =?utf-8?B?bG9WUWJXNUN3eVdmZkttZEpvSlBqZk9SNHpYaEVCRjRXM0E4VTk5UWxGWGR4?=
 =?utf-8?B?NG9zSVJRc3plZFRXSnlIOTMzaE4yQk1ZOHh4SU1odlFSTGUwVXJ2TmYzUVZl?=
 =?utf-8?B?QkhyUEMwS1lia2lNQ3VFL0hCZDhwQlNKVXM4Ym5Nb3ZMSlEyVXVXeTVIQVZL?=
 =?utf-8?B?Ly9aNFFyUkpqc3ZCRy83NjhXQi8zZ01oK1RkdUl3VkhVZGg0TGZNWnFWM3N4?=
 =?utf-8?B?d0hlOXJJZE0rKzVZUmdVTUNpN1RYQ2c1cUtsR3IvVDkxVVdzYy8vOXV2akM3?=
 =?utf-8?B?Yy9YMWczb1lRL0lyTVdwRXcvcDFMMzJHRmZOc3YvRDVrS2lKcEdqSmZPeFNT?=
 =?utf-8?B?U2lLWm5meWRIYi9OL3N0dThVRXJNcVhBdGlsQ0FDZzl6MXhXWnNuRXVxbkRP?=
 =?utf-8?B?dHQrdllJVHJuS0ZIcDNsSEdXdWZqUGN3ZEw5WXZpRUdmbytybmtkYmZLV0gz?=
 =?utf-8?B?cVQ2T2gvZHFFemdXZ3NrSTR5eFpnTlQzRFYrQUdnNkJEVUNCZzRyRlUza1h5?=
 =?utf-8?B?OWlsRFBPcUhOamtQKzZXS3Vybk1PZ1hvT245Q2gyekRJbHYzdnhzNm9hTzNr?=
 =?utf-8?B?QUlQWlF4amRVQ2hyMlJ0YVl2VGxXQ09RQUFkVHZzZnNuZkVOVnppT2FWTzFK?=
 =?utf-8?B?QVQxZkR1T1FpTmR5a0lRdjhDblYxMjFHbmtaaEpZQjRmTHJHMCsvT3MvckNW?=
 =?utf-8?B?Z2V4WFp3Q2hPN1RQcyttMmlUVS9JaGJqV2tNVHF5aFpqQjZUTTVIa2RBRzly?=
 =?utf-8?B?N3RVamdWSWFJdVNycUc4QTlheTdKb3JwdG52WTRkTGIxTFpYR202RVdFcjFU?=
 =?utf-8?B?SEdlMGxGdGVVUy9rT1N0a3pXRlRsMTNoZ3I0S1J6elhpZUhpbE0vTEFSaVRr?=
 =?utf-8?B?bXh1ZzJ1aGJMd2kzbnZxangvelVXT3hnSUpzNnlHWGdOMGw5NG0vdC9lLzJj?=
 =?utf-8?B?R2xaYk5UZWFQSHFuUGI3dUtvc1FPb3BPaHhORktpblFqUFdHcCtOdHkyN0pC?=
 =?utf-8?B?bnU0WjQxWTVFL21CZFh1SWdJbDhCVU9xK0NWaDk3ZEFDMkkyMVpFaDJtMXZI?=
 =?utf-8?B?RUpjbmQ1WGMvdjk3YklTekZjOEdaSHNJVWhoWGhFNmlVWWZieXN4TnNSRDdP?=
 =?utf-8?B?aXdETlZ4R0l0MHBobkk0dThuMkIxcTBQUVg0TmRFazB6TDdKZVBTWi9FZmRv?=
 =?utf-8?B?ZllCL1lpN0tCaWZiYmFOdHBieE9PRFdQU3pBWXYza2grSXU5Mng1bjJmQ1ZG?=
 =?utf-8?B?SXU5dVkrMmU5WTZiNG0raUJKNkt1SVNvOWpDWjdlQkZNMDJjcVRSSHV0TFU0?=
 =?utf-8?B?bFlUSGpQMlhueHZ0dzVqUEtocnBFQTRNK0hRQ0w3NEtOVm5HUXNzUTQxTEE3?=
 =?utf-8?B?L0J1MGM0RGl3eFUrUjU2U2twbVNNcXlWVnJ1aGM2WXZJcktHVGhqamNFbitx?=
 =?utf-8?B?TTVkYUZGYWRmeGExT1NXT043STRKOXc2UGNoNUV2Q3JhRWoyQlpGR3BmUDQ5?=
 =?utf-8?B?SnhnUU4rUnpyVXl1d1V6U3E1Q3lzQkF2aVgrUFhoRGZ1dWVGd3BMUElKdGNp?=
 =?utf-8?B?cWJiSjJQb2RvYTFPZnJPRFdZRDU0MWYwRU52UHl1S1FXUEhob2o0TVFvT1JN?=
 =?utf-8?B?cDhYUmFxTlRUcWIzbzNYN1NrMXM0RVpZditlSUYwUktkYkRJWjl3dmxqN1ZT?=
 =?utf-8?B?WllSZDZ5QVdSVFpjUlNQQTRFaUlrUy9sN2FqMTBvL3ZNeGZNdWhRQjBTa0F6?=
 =?utf-8?B?bE04bEowUGdlNzhLVm9iV3ZuaWpWbG1zUURhRU1XUHRQRGRMUVIxdU0wbWRv?=
 =?utf-8?B?Q3R0Zkp3VFZ1SDNURnNEK2hIbytabXBjb3BFaWN6ZzJNc3dWKzU5ekprQkZV?=
 =?utf-8?B?MkVZR3FDL05FRlVLUjNoQnJYZmRiMGtKSGZSUEMyNWlQczRreVZiVEdmRks2?=
 =?utf-8?B?aFI1WFdiZkJ2cTRzdUFYK1NaM0sxVEthVitsaFBkcWJvYTBhQXhqZldTbDUz?=
 =?utf-8?B?cUVpQVMvMzMzQ3NNRG8zOHVyNm5IWWFOSkFNWFJLWlNFSUwrYTlERVo5N2d1?=
 =?utf-8?B?c2JoSUxuZ3FwRzBNMkRpNzdmR0ZUelY5UEF6a1NUcThkczAxeWpnQnBXUGVT?=
 =?utf-8?B?S29kamJpbkEydDhZbVhKdGpVSHk2ak5YT25nM2VJTW9XYlJsMDgxQkRPUmQy?=
 =?utf-8?B?THJobHM0VVBuZk5ETnUwb2oxZWt5YlpqMGVtMkcyU3NDclJLN3pNdVFLdUlD?=
 =?utf-8?B?K0NyMjBMa0dXK3p6R3hqNnZYR2tjMWxVUVN2UThXR2NOSFRVTGZkY3BXTVRn?=
 =?utf-8?Q?a/OsnszT357PF1rU=3D?=
X-Exchange-RoutingPolicyChecked: fD4YJ1B26Us1SNc+i0z562auAmHx7/1YZ++OUUDXMijC3FEGitl+R2b/8qzmLzoorN12w2tPfaQaRb6UTAXglMuHzcqffHqYmdXLVFhTnzO7lFO0aaF+4BEvla5Z4jTDXbNwRsqRJ1KE131dR4O4Cloyb0uYYoHLih5WCC3Fi2AMCoksoU7kE1ggM1LR39H6Vbj63eZpKM1BoIG4UiZKuYmzDmdvUq1XErd11zUQgc6rFWP5Mk1Lj95wJ6nrt/bnE35NMTL0MVk7b5je7r4CbqTZrkJ4RoeoSfI+lw5tveemeiSmK4rma0OKU1fHZUdfDoDFjVEOD6zuTqexYSzhSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 393ddeeb-6aa9-4105-9e78-08df0e64b1f3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:22:55.9592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xldsplW5t60RTlaJBZ6bg2o5j8lRwtqAIG+2Gz5QmOfLe+CjQWu1PT3Tfsb2Mr/KYfBwbNMJ2JXzAHxTSl9en/asIfY6oDCbL/3s6T0AiaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7981
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

On 9/9/2026 12:02 PM, Anatoly Burakov wrote:
> The NBL driver currently uses group bind API, but it is using it only to
> get group fd and nothing else. In context of NBL driver, this is the only
> usage of VFIO API's in the driver, and it is not necessary to use it for
> what NBL driver is trying to accomplish.
> 
> Use a direct `open()` call instead, and store the group fd in common
> structure.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/nbl/nbl_common/nbl_userdev.c  | 24 ++++++++++++++++-------
>   drivers/net/nbl/nbl_include/nbl_include.h |  1 +
>   2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
> index f1522772f5..b3b6548bb8 100644
> --- a/drivers/net/nbl/nbl_common/nbl_userdev.c
> +++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
> @@ -387,6 +387,15 @@ nbl_userdev_mem_event_callback(enum rte_mem_event type, const void *addr, size_t
>   	}
>   }
>   
> +static int
> +nbl_open_group_fd(int iommu_group_num)
> +{
> +	char path[PATH_MAX];
> +
> +	snprintf(path, sizeof(path), DEV_VFIO_GROUP_FMT, iommu_group_num);
> +	return open(path, O_RDWR);
> +}
> +
>   static int nbl_mdev_map_device(struct nbl_adapter *adapter)
>   {
>   	const struct rte_pci_device *pci_dev = adapter->pci_dev;
> @@ -424,11 +433,16 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
>   	}
>   
>   	NBL_LOG(DEBUG, "nbl vfio container %d", container);
> -	vfio_group_fd = dev_vfio_container_group_bind(container, common->iommu_group_num);
> +	/*
> +	 * This assumes one device per group, as kernel will return -EBUSY on
> +	 * attempting to open the same group fd for a different device.
> +	 */
> +	vfio_group_fd = nbl_open_group_fd(common->iommu_group_num);
>   	if (vfio_group_fd < 0) {
>   		NBL_LOG(ERR, "nbl vfio group bind failed, %d", vfio_group_fd);
>   		goto free_container;
>   	}
> +	common->groupfd = vfio_group_fd;

This is indeed making an assumption that there can be only one device 
per group, while original implementation didn't make such an assumption. 
I have an implementation that addresses this issue, so a new revision 
will be sent. I'll wait for more feedback before respinning.

-- 
Thanks,
Anatoly
