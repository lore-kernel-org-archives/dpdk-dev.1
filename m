Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90412C982FA
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 09:22:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB621402BE;
	Wed, 23 Sep 2026 11:22:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id CACCE40262
 for <dev@dpdk.org>; Wed, 23 Sep 2026 11:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790155366; x=1821691366;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oBvakYIfi6xpNwkHR1z1HbyrfBMmh+wrExjyhgA1K0Y=;
 b=kbsSjfTJKbisAVMiUTJgNGJl4IQfIKPdlKjUrKBRvcwamLbP1tJvreG/
 1MfBd+VGPOBCFe+Mf85wj4Gswa4NcFbcWg52NneF77vPMClV0Oi5UBp2c
 aUKxivaJzKjU0orqg7R1E7Ke45AwrC5OME7ITEUNZ5KnjGqWloPJCuasJ
 ySolwj+uowEyvesz+TExLQfuTaUlpIVv6ag7uN0JnW8gKNkZxeldOaeUF
 wiStBXm7cOETg/UU8aOtTmYCiYv7yf+Rcg0qRJxMaax8MZwWr2XY84n4T
 s3k6+bhiQzEIelbtEW9fZt2cQ/opjBGLH/q5dDaBjvoXVwtfgXMAV7qoa g==;
X-CSE-ConnectionGUID: VCIvpH74TwiyreAG2E1cRQ==
X-CSE-MsgGUID: weMMM8G+TzK8PHfKP0Axow==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1346682"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="1346682"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 02:22:42 -0700
X-CSE-ConnectionGUID: M0x8riBbRISodCM8TRavcA==
X-CSE-MsgGUID: jzxWJAeXQcencGuogyP51g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="301451117"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 02:22:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 02:22:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 02:22:41 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 02:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1cZZpdyxxSlPg5AKrxJu56lAvV43caFVsd7nO+6Sb+5FLNLel9YyFV9HeQHKVmciWtproNzEwCkeEd0YzVAtANNc+zlVJtztjfwHA5NKR5ikFgnHOb5b6UltpKfjHZD4V4Iv35v1Zi+NbRcN1G+m49UyfqBPs5K3Um4nw2jyXShhyHaK/Sb0aNPzAFS5vIrk5FClPDPhxgMSTAcUW/eXSpG8YdqhGZkf5qaXp9pcyMgLvJXUn31rY8AWqDU07AIdeYaAFbJz2qHdIixE7Wz/okL1hYcPFjeWtgStPDVw/zFvHFCOaqdKlcedq8mR5NT3m6dV3ftjodcHCocLNy3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kLl4w74DWWt90PgsaWRzzWf8KXowiiU77r+2qlsyns=;
 b=zW4y/IxPj7M+Otx+kvCNuXStVnuDdbWvRuh7gxPV+KhECnlgtwUP6Sx4slp4eQehFnJVx6MZP3P1QqxP421CmluugmYWhBIeAagzYBuoeLq2zB+VSXsZIgKYMZa4pcFOhLQeWsB5aRzfnlO09J0+Gt78hUkfgWfPoYP68iEAT9/fdCSTwpj35H4PnQc9Q59e0oNaSivO17NERWDq0Z7m/lEHb2hWG8ixMX+0vOuVPJfWHpfRZ2YJNBQD9sRBgb4ASaIV3cqLL5sQcxchaxxKCu1NfMglkukQRwf6n1h472tYePJHj5hrJqvXa1T4NhjKkXfXAbHf6NskQN64TkLwuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB6620.namprd11.prod.outlook.com (2603:10b6:303:1ea::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.13; Wed, 23 Sep 2026 09:22:36 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 09:22:36 +0000
Message-ID: <83ebea21-2e24-4e02-aeda-403ce86842a5@intel.com>
Date: Wed, 23 Sep 2026 11:22:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 20/26] vfio: cleanup and refactor
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Nipun Gupta <nipun.gupta@amd.com>,
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia
 <chenbox@nvidia.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>, Dimon Zhao <dimon.zhao@nebula-matrix.com>, "Leon
 Yu" <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <cdedc9f8885ef46eb5a903c907c3b2bfeef0704b.1789044747.git.anatoly.burakov@intel.com>
 <CAJFAV8w8GbvBRQ+O5LkL=jJ0f57Y4XaKJbqXJjxpgk94Ane6Wg@mail.gmail.com>
 <03fd0cad-30d8-4754-8065-0216ec8328b4@intel.com>
 <CAJFAV8wVwuBsqiq-8ez6Ohg+vkwSh1Wsg=1aL3qpNnOSE3a1YA@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8wVwuBsqiq-8ez6Ohg+vkwSh1Wsg=1aL3qpNnOSE3a1YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 32dce752-6fc9-4d65-da61-08df19543483
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TAejTTPTShcVDhLzZ4fxuNcoXd+KvrWemxKCiR2nnt4SiIxxYWF2TvNyDJ9JStHry/iXzerh75CV+cVySXV/LqasykcSOmg5Mj/CkPVoIdEGHBzS6E69iXU5KHYrknkNQ8NnftqdUnB5WlrEJ4oUfcQC2KrSI4ZoIM2JvnvubZZFN2xhxhqz+nS7IkGMCz7vPkFdrsGwGzpHXYzUGi2XAMSRDXf4dGk8Zzb33Ej7M3xoksrpkdSXXPhOwOhZRFJigHtbX2ECKNSeODw4+IACG8dcdmAM6NaAm3NG5TQMU+15DCWbigwQTsDlXbd50YY0FsYIw27xoMar+R5CzC4UrWIYsjc+HaJCd4MOE95lTkXD7u5I39uIjaprI6xbaLqwaQdGw8kwqpRgdtZrW1473TOyzjpTSIRe/rryc/IvO5uBaSj5lGEloBBXYmb5n89revY7JQsSKFs8BJFL276zucfNoHR8r2+flOFMDn924ATscrH1/ncM8kaB8VViNcljkOD3EmqwDDuhfRwGVEVP/G2CGkFG0Tom2OBnjwllEvhZHb7HRdDH0J6Z3CKKzRwylkKN58oXAZJpxAMBZ8O+z8ioJV2V3CmhXZ+vdKblmdgWqO64C090aOFoDzCMskQB+uMlmguxCIwzP7QYPjBvV+uPXfU6sW6qaD/K+/K7ya0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhBbHBFS3Zqb3dld2FlV1FDdGtTR2o2Rkd0OGtqYXdTMmU3VHNCaXJkQTJC?=
 =?utf-8?B?MThLSTdaamV2S1ZvNyt5Z1QxZEtya21za091TnRiRUJYZkVIdkJ4WGNUVC9h?=
 =?utf-8?B?ZytZQUhXOXRIWkdIaWJyODgyZ3JwbnBHNkFKYVhIcmFYZWdNSm1qNVE4TjN3?=
 =?utf-8?B?Qm13dWV6MXg1ZEJ2WDM4NitvZVNZeS9RdWhlb0NDSzNBMXUvT2VBUVBUR21s?=
 =?utf-8?B?NmVSSDU1Sk8vZTZ5cmIrZUtkdWdkNzcwVGxNS3BWM3crTDEzY21nTElRU00z?=
 =?utf-8?B?RjNtMTRiUFduSjRESktBbzd6Vk91eWFQM29iUVFuZ0ZYUTR2SFlEMFpGWVAr?=
 =?utf-8?B?UjBlZ2lqcmNnaXZQOXZ5c211amxlcTNGRXBvTnd6am9jQTZWQ2swTHpxVGxT?=
 =?utf-8?B?OWE1YXZOa2w1NHN3VW56Ritjbzg2cEV2QWQvVWVJOEFJYnAzL2czcWY4VCtW?=
 =?utf-8?B?VjdiZHRCazE0SkpLSENKQXp6NzJUQWw3bXNPNHltVDJkUnF4UG1ZdU1EbU02?=
 =?utf-8?B?MjQyeUN3WXhRYWdlYzBiLzBCVVd2aFBvL3hUdjQ0ZG00bHlUZHV0NzZRa0s5?=
 =?utf-8?B?YU54TWZYVVFoTkY0WUV3bTVQRzJsZk5MdXJxMUNJcG5MODE4TE5qZEYxN3dP?=
 =?utf-8?B?YnpoR0oybnMzMXRsRWVmWkF2M3VWZmlUOGIwYTZhWWZETUVwT1RtRWY2NU5H?=
 =?utf-8?B?Qm5EdnB2QllJbU5heUhrUS9FRGpVNDNiU1hlMTNDL2pyOE5hanpnWkorMkEx?=
 =?utf-8?B?Z1ZrbUtoL0hHc2E2dS9VYXR2bzRPcUIvOURHL3lyN1BuWjJkRDhWY1BwbWli?=
 =?utf-8?B?cHU4d20vaFpjaGkzUkU1YllVaU85cmVXTFhLcHdzRDVZeFB6SStJdmkwV2ZR?=
 =?utf-8?B?RkFIL09ibk0zVE5rMk84NVB3dkhhMGFiWGhGakdXcHorRm1rYnpYVGhhZ0pR?=
 =?utf-8?B?T0tocVVPZTVaeFNsditudzhTVVdoMVh3WTZ1d3N6T2lqRjlDcEJNU1YxNks2?=
 =?utf-8?B?b2JDUDlYU2RoMExVRzltVkVFS2R3cUZyWTZETkY1YTVHWWtIVTREdHJibERm?=
 =?utf-8?B?RmhkTVZROHErM1lrSzRIbndkWmNQY3NoeTdVcFAvRDBNc3Voa3cvWGNPOHZK?=
 =?utf-8?B?TjlGTndXajljdUg1dHM2NzJnb2xMT0ExclVScE5BT3BtcDhValZwM0dRaXQ5?=
 =?utf-8?B?SjdwNGpBUS9hU25UMktZTk93cWhSWkdOOEVkRHdrZlRHdzRyM2FPd1lLamg0?=
 =?utf-8?B?Q2NVOXJ1REdqUnp4a2VUVldJZGU1dC9rYTlnby9hQnFmRm9XTjRHR3M5U1Uv?=
 =?utf-8?B?R0NFdVNuZUlRajVCMXBBdDc1bHhnU0RVaDJ4NWJFTldpeXg3TC9ZWEFnSnBk?=
 =?utf-8?B?MWN6RDZTckRQQytIRk83N01XRDlmVWdWWWl1eFRYODErRlZWdld5N00zQ2hR?=
 =?utf-8?B?U2hJbmsvcjkwNVFLUHlNaERjcU84R0ZzS2VSWFlyTGZEM2pmV1BQeWNROVc4?=
 =?utf-8?B?MGVWTXhueisrYlZiVzgyQjVhbmttcTNodldNVjc5a1dUK3JQQWt6UzU4cFZL?=
 =?utf-8?B?U3YyRThzKysxMk9mZWZUelBhMENxY0RvT0N6cFpsQjlnMHdibGVnRFlDM3Aw?=
 =?utf-8?B?ZlhTQS9lTlFjMGJyV1AyV0pNWlpjN0IxSzJnT201UGF6T0FnQXdjNmNQTi95?=
 =?utf-8?B?bGtXdDl2Y05DYzh1NW40S1IzZEZRWTg0Q1JvWFdOaUhhZkRMbTBlL2t3VVcw?=
 =?utf-8?B?dHc2MExJcGdFRjRvZkhyUUVqODhISlZnME9NSWZadVNVZUxtY1RkNG0xeGl0?=
 =?utf-8?B?SElzOG1JUFV1cmFsQW1acWdCQTE5S1pJaFZQbEJXTkJJdlBHWURuR001OWlR?=
 =?utf-8?B?a1B0NElham52RVV6ZnM1SHkvQUFMTmUvNnNsVVJlTTRwU0pYcWUzdW1veWZW?=
 =?utf-8?B?S2xyQTEzanJPN0plM0w2akxLeHk5V09nNDV1djJXdzM5QzJFVDN0bEFJZDNl?=
 =?utf-8?B?TTRjLy9oNXJYUmtrdWR6RldoQ1NRUktsMjJSdElDblBKZG5PcnZ5T0g5dVdQ?=
 =?utf-8?B?dTZ4NnYzU1M0akZoZEdWbytrYTZVTW5zaDZPU3RhSzE2SHNZYnNGZ01Wc0pK?=
 =?utf-8?B?VEVGMkVNZVBzbGJ3NzM0UnVybXlkQVZHU21TMEdaSEJCUlcxcndDc25RRTJI?=
 =?utf-8?B?SDYrRGNNbkVBWDZYU1JSSmRlVkpxLzFHV2w1b0VaeXNvQm9ISWY5V0NsS1Y4?=
 =?utf-8?B?ZnN3bFdJOEV4L01XUmhWK0RWb1E3WEZkaVJHYS9EZTl3WGs3R0pNRDRNR0Zt?=
 =?utf-8?B?RGR2cGM3a0dnVUN5LzlKN0E4ZzhiemdzRnUxb2lQMGk1eWs2aEhlc2RGMDdK?=
 =?utf-8?Q?FVLAe0wPkHvsBric=3D?=
X-Exchange-RoutingPolicyChecked: 4zN9DX8+lK4iff4ss9AUkEhTHaWJP6f2R+77VtYacehxK+CwMcRP7CKe6wFTOzRwnM7gx4kTI8j+lXD+WL1BWY4pSQWUjop4BGZdOOEUMuQpJjZjCFkENLGPRtLmTGpc5EfvwZ5WEWM++AMDHGpa2HXmrRDZ1z7vIN7ORK+GtR90L+uUoaC5zOWsO90Q37CXHo52Hz7n8XaQgXD+GCoL854jU8OIisMNMNSnNMZ8QcbWd9/GLHJ7NnaHxyhc2436qg+myIZvuJ2SZCjkCHeGupcO+RCa0xFQ/IBNccdJd9wd3qKUqrS9dHVShfbkYtjZb06cTXZZ9AnqtuNgP31cBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dce752-6fc9-4d65-da61-08df19543483
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:22:36.0817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zAqHxpUFQ8Q1VmFUr+wWmkvdIwtfSl3fYJx/iBl3ZBSRvHYAuIGXh+9M0G77NdEtG5B96XHEsOqcQ1bugOEoTlytEOVbtasbe9UAsYB4ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6620
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

On 9/22/2026 10:02 AM, David Marchand wrote:
> On Wed, 16 Sept 2026 at 13:20, Burakov, Anatoly
> <anatoly.burakov@intel.com> wrote:
>>>
>>> The main concern for drivers is the "class" (physical, virtual) of addresses.
>>> The noiommu notion was simple in that drivers understood they had to
>>> handle physical addresses.
>>
>> That is arguably still the case. It is the same semantic meaning, just
>> wrapped under a different name because I wanted to signal that using
>> no-iommu mode is bad practice. It's still effectively IOMMU vs no-IOMMU.
> 
> Drivers do not care about this "bad practice".
> No user will ever see this.
> 
> Most of the code now is generated by AI.
> If you mix concerns in API, I am pretty sure the original intent will
> be lost/distorted and we will just see some funny claims like "such
> code is unsafe".
> 

Fair enough. I will pick a better name.

> 
>>>
>>> There is some other concern about iommu capability that is not
>>> captured in the new API.
>>> Take a look at the PCI bus for example, where some decision is taken
>>> on a DMA mask.
>>
>> Arguably this is not *VFIO* related (it's rather the property of IOMMU)
>> so there is little place for that notion in this API except to group all
>> IOMMU stuff under the same roof, which may or may not be semantically
>> coherent depending on your view of what this API should be.
> 
> Well, yes, but drivers do not care about VFIO in the first place.
> 
> We may have a cleaner VFIO API now, but then drivers need to understand it.
> I just want to preach for a simple API for the drivers, and maybe we
> are missing an abstraction...
> 
> 

We really do miss a generic IOMMU abstraction but the problem is I don't 
like building abstractions that only have one user (VFIO) and that mix 
different subsystems into one blob. The one saving grace of such an 
approach is that this API is no longer public so we're allowed to do 
whatever and experiment.

I agree that a simpler API is a valid goal, and in fact this 
refactor/rework is in large part *about* simplifying the container 
assignment API. The IOMMU stuff really was tacked on at the last minute 
because I noticed that despite earlier talk about how cdev mode is not 
going to provide no-IOMMU support, that actually did end up happening, 
so I added another axis to my API.

We can't make drivers *not care about VFIO* unless we replace the 
terminology wholesale (containers, cdev/group modes, etc), and arguably 
while drivers don't care about *internals* of VFIO, some drivers *do* 
care about VFIO specifically, and the extra stuff in the API is for 
them. DMA mask isn't really about VFIO because it affects physical 
addressing ranges too, not just IOVA. So if there is an abstraction here 
that maps well onto VFIO API *and* the DMA mask, I'm not quite seeing it.

(not saying it's not there, maybe I'm just tunnel visioning on this 
after having spent so much work on VFIO! I'm all for good suggestions on 
this front)

-- 
Thanks,
Anatoly
