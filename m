Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1653AC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:59:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2A14427E3;
	Thu, 17 Sep 2026 16:59:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 06313427B2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789657172; x=1821193172;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:mime-version;
 bh=UQ9Aw1PDRbJ3LG1llkFFQefxfiSVjr+gjb05uyYOzh8=;
 b=DEyqYk4UlkrbxwyNxx642gdb4mb4DpxHizYbjqBuYitBDAgx3AkiJoJq
 y0vgVXQQE+5zaGRBMUWZohCJRmsztU1JEYS9LulRQEi/PERDZscgxQwnY
 AqyzIZlMPTPq5tc6DUmS4qEAraKiKea8JlYthgPMdqziGSJKmEq+hMPwc
 kWOYXgGb8dBClq90T90mI5iQZcY+cwWLoBVa/tkAwrScubkJ0BXk1HRDV
 NeKgBsPO395+vRYiRBxkXBLDFmhfRU6Shu+YxieevOmiUKpeIDXG9680s
 MP4WcsP30FvwRr3OicX6+IlO0844PEcM1EjToFMO7eJ1HQZOY/hXdKaA2 A==;
X-CSE-ConnectionGUID: S4UPbGcpQfyx9n0Owl3FzA==
X-CSE-MsgGUID: fNmD+jFeR6yXyaFqANTNpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100682801"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
 d="scan'208,217";a="100682801"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 07:59:31 -0700
X-CSE-ConnectionGUID: sVzC7EHdS9SDJt6aTbyyEQ==
X-CSE-MsgGUID: JdwDiQ+UReGbSKRCWzDZZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208,217";a="2258992"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 07:59:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 07:59:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 07:59:30 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 07:59:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ8i6sWPdWBqQZRE9VcBQicRHN00Bot97BlRaNpPIIr9+w+KpVzAmJynWpJ+L4US5zVQR1jB8NaQ2I3UDe21+VQ3C5Ngtn97lWOLgjZWq4MJjwc+YmimY1/+s3vS3ALHQ5XtfJ65NIqXcMk8ol7hZMac3g02JMo8FVl2pUwMvmDbAtQNjJGrsRZKxq/+QwkQiwywXu/gRTocUI/Fv31vhSmKZ8Vs6Z0Ge2w2vblzJezkaWTqOmEfeYE18+eyvtuZHrHcAKQQVmeaAs7+9w1tKvatFO4wSslTYQZkoNq6G52xBq+uUGDf4PiTfUCP+OtojhbLE1evH7j0jO2LKCqGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fmc91EVwVMQJGugun85NwrzC9z+jjaoklVPKjkcEWUA=;
 b=jlS8og2O9S+Ha82h8PuHRvHVOzrjC4/9mm6VTb975QJkUNdZvEbfi6JPvCgghdfPIe/RoqqmNVl1UvC3GZDhSsl485PTSrbfvXobFwGC/du8sDIUAl+yAWEq1uwLeWA39+Hax27EWzF0yB0QFdi+QI1VfGS3kDz3NW0wQg5DhnVqdP8clbd+U16cfyZXW4pxHzvpdZm1Ttb5eoNlfESoAVSaNSqG5ztE3yxqgQhmEyXgqwYkYKT9w86a/RsViM+s1IsihflR0hcUlKVwhVdAc6VG4askC4s7ykUCO3GIYCORPh9nVl1h36ML5Gm0TiDGyBRttn7eNlhrdRmZ99c1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 14:59:28 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 14:59:27 +0000
Content-Type: multipart/alternative;
 boundary="------------uz78Xbqbw4bv8O3MF8UkRM3W"
Message-ID: <29a23773-d16f-4065-859f-f85646442cbf@intel.com>
Date: Thu, 17 Sep 2026 15:59:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
From: Radu Nicolau <radu.nicolau@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Pratik Senapati <psenapati@marvell.com>
References: <20260917101641.335926-1-radu.nicolau@intel.com>
 <SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com>
 <5ac0b690-b340-4cfa-90e6-33cac4c30eac@intel.com>
Content-Language: en-US
In-Reply-To: <5ac0b690-b340-4cfa-90e6-33cac4c30eac@intel.com>
X-ClientProxiedBy: DU2PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:10:234::11) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SJ0PR11MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 93df9025-5e5d-4541-b4d0-08df14cc4527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|8096899003|13003099007|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 7YUqH3UISQ9lBhuzVdkyhBdKELtPvABhCtOUp1qsSbCi+4vMfxJOVCNezG0ZFUBAa333cWLj2xBsoptH4z+soOq7aDFTSHHoQp/oDwM5G1if9v8iD3nXyjc2WcIJotfn7vDRR3iugELieF/BB3xhqBQU1MiLiRF3PggWaVUk7KcrVX1Nm2zJj9NdIqAZmwGnvE2LaU8WxOGeAn2cvUq5O2z6sIdsFTms6PTmwPX3SSBuJ7dWhrj+JmLqclcnOPL6SAZ+pWWt7t3lltzmadfGx2O40aZhKYc8G+WCMoNS/93OEbhjq3Kybe3OLtFtHcp6X/qiUAjlMZSk9lYoCcV59yc1rq0wk7IL2ml2kI8860LFZWfeWSo9kXGIZCujtmBm4iUNY6I+lw2r6FdTX/YXxkeu5BZKr5vBuOmGtde8W8/T/jIBNlwkWoDJuuQ619JRfbRoY/hB/Bmx6NNbg21RLhz6V3zxk7KviC8Ynh+fTZYtcxBGglQg2MiBc7gH9eP5LCh7zyzPjerYdyyce+JyD3LqJGBFPmRoIDZYrSfcJqfbcBqzXUuMXYHtGBsl8HFtTXjmfmcyqS6V791+Wq+91eyV28++3UpoWv7FqE9NoR2jy2PdVlJmyEKCm81Edvl5scdx7gG1TuyEu+tchdH18m6Shb5YNevu8oCpr1mFWY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(8096899003)(13003099007)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmlmV0t3SnZiVXFSSVpQSHU0dkpDOFVpMDc5NUlVc2NDVi8vZHdEQkhrWSsz?=
 =?utf-8?B?NEpFUW5qbWNTMzR3K3RxblVySlRvb1lKTVV3YW8yKzJzK2UzNERWQUpLSjht?=
 =?utf-8?B?NmNjYTl5cGZDbnVzNU5xVnRtZ3NMVW5XaEJuNDcycmloQXFvRmZ6SnFYdmlt?=
 =?utf-8?B?czc1RnljVXU4Y2ZMalRIRGQzU0VJZElUSm1NVjlta2RwVG5sbTJ6NXRJVGxM?=
 =?utf-8?B?Qm9UbmUrdXptNnBYRXkxdkdlK3ZkTVJkVkZLL2VTN3R3SS9KbFFtbjBLaEtG?=
 =?utf-8?B?dlB5cXA1N3pWYTNobUdYQ3NzNEFPaTZSZitqRndWTmlDcTJQVnZvYTlFemtB?=
 =?utf-8?B?MjhwV3ZHTHpFT2tkK2ZNY2kzTC9oeml4N3BDRENuSndtblZRQXFFbTJRdVJZ?=
 =?utf-8?B?V2k0Q3lwU3Nta0ZyTnpuMG9YRGNUNCtUYyt3L0xnSXo5WTlqZEFiTllHRDdz?=
 =?utf-8?B?RXNYUVNIRmE4eFRRL2llMzNtU2V5aFZ2QVJ6SUFmWVczWlRzcGpxQXNlU1hV?=
 =?utf-8?B?MnFEVXZkRDFlc3ZmNlNKVks4TFRqbHN5RENhQmZkY1A5QmgvZUJOdjU2a1Nv?=
 =?utf-8?B?NHJMYTIvNStSb3MrdmhWTk1XSHdYVjZVWHQ1RyttTGZ0Z1BSMDI1ejc4a2po?=
 =?utf-8?B?Uk0rajM4eGhpVGQ2VUVaendRU0kxbHlyb0JWUXN5VWR5dUhFS1RzNm50Qlcw?=
 =?utf-8?B?UDVqUGR4VW9DUmxidjl5S3RPTkpvOVVKbXhJaWZCUzFVcE0xenNXQjJUYjB3?=
 =?utf-8?B?eVRzZXBqQ2hDSTN2cURHMEMxNE5TVmd1NEpOS2VHSG42UGhrNmxaSE1GQjVs?=
 =?utf-8?B?c1lMZDVGZzh5SnozV3R4UTdCc3RrcE4waFBDL2IwREpzbjJ2TjBkS3l5NjlY?=
 =?utf-8?B?ci9JdDdxcHQvWGVTa2JxYkFBMW1MTy9KS3Q1TnhjemgwNzh5RU93T3NYQVBT?=
 =?utf-8?B?YzhUcmR6SjFiRDJjVFl1enlwaGNqWjc3VkQ1ZmlBazFWZXk1eUo5c21xN0lQ?=
 =?utf-8?B?c29pSEpsV1hOdDkvQkFncWsrS1B4eEU0eFpEdVRTZzhkci8zWFRPYnBHUWRH?=
 =?utf-8?B?TVlvZUxSM1BTYk80RnVOemJLWWhyWjdRWHJkem9Fc3lrYmQ1ZmRXdTRxRUpi?=
 =?utf-8?B?TUk2ZWNlU1hYQ2tCellEZitaVXFYbTNzNXg1c3RTM214a2pwbExSdnhRY0Rj?=
 =?utf-8?B?THhHVUl0dFBxTkN3cUd5NFBwV2RpUE1rNlhiZW9nRENyM0N0QXp0aktJVDBE?=
 =?utf-8?B?U2NOMm83NVA3bGpoc1BzOVZ1UzI5cVpJTk1jOFpkdTRYUmoxTVRvZ3lWOUJ5?=
 =?utf-8?B?N3BxWjlRNU5Bbzl1LzNocFRHOHVmTHFBV1lURDh4K0laTm0rZnFiSUdrdGh1?=
 =?utf-8?B?MkRSQmQxMitQbGxRaE5kMEkxTi9aeTNHODRjS3FkU2EzVjk3eUxUSHZtSlVN?=
 =?utf-8?B?MmRCUUR3UjJYcE1YL3RQdzY3cUozazNiVXZHZW5CU09pZlg5VWl6Tld3MTN4?=
 =?utf-8?B?ZG9ianJmZXlSNHRUWmRsbndiN2JWQUZNbHpySTY4blFxTEdYZVMyQzlaVCtl?=
 =?utf-8?B?S0Y3c1h5aTFjY0NKUEhIQ0xSY1ZabG5FRFBXcFZaS3BoL0pja1hjQjRUR2hT?=
 =?utf-8?B?Z0Z2R1RXTTJoc0cvRTVVamJmVU9lTlh6VFBxSko1cTJ6ZVpxNFhrN25WRVdN?=
 =?utf-8?B?NnFaU29WSUFmS2lBREtMSVJNam9ZdGN4S3JoRURzZENxaW4vZDNtSnFNWGFN?=
 =?utf-8?B?SmtIWTNtSXhzRW5uQVZBTjJycVdzeWFiNTZIekxVUU1TUVRHQktzZWFvS2I5?=
 =?utf-8?B?amV4clBJaGtBWXFDTU15TXl5SFhhZzVjU3lkaXlSb1lSQlh2N1BOUWQ1MVRl?=
 =?utf-8?B?YngzZG5rcFFOQStrQXpGeG9sZ01ya0M2NUtkSzZ3aFprMjk5QmhYNE1IZmxm?=
 =?utf-8?B?blZzb2lGVGs3UnJRRzAxbHUvS2VUSkdLNUVqTVR0WUJpaUpBVVJSbk5mTEV0?=
 =?utf-8?B?SnNneHpJN2puVDdLUVdKVE1QbHdGYXNaSEROT052c0k4SzVpdTJFTnlXbjhF?=
 =?utf-8?B?OVdNdnVWcDQxNkpBSERpSEpWcUdQeUh1T0VNdlJXRnhCQzQzaXdMbEpkU1Bo?=
 =?utf-8?B?YXRDMkxERzJxQU1vVEd2QitXN29XZEhGREZTVEQrbFBPVjdsRFdlc1lRczUr?=
 =?utf-8?B?SW5BdVNiY1JXemhwamRKaUxadDcwWE9MK0RSbU9Dc1lpeXY2M3dhRnZkVHI2?=
 =?utf-8?B?N09WTmlxeE1SaTZ3UDMxK0EyNXVHaWFGM3Y5bDliaER3WFVZZVBuMEJhQ0s3?=
 =?utf-8?B?MDlqc3pYbnRWL1lqZUg3cUlGR0tCWkNaU3FTN1BqN3dWUnEzQmRDQT09?=
X-Exchange-RoutingPolicyChecked: kUeT2y5kiPLXeA7+5D8Px0FxPWPP60OIeEVHTEGBznx+uOSZG7kLG1kDOAEcv6mlf0LFXbortaQG+VTSvm/CFOt5IieRV7LUMGWl5/MIkh9ey1DiB+12n8SRFsefEBLlgoqtaGkCP5ko0vjeJ4KigbcSUWWnE/6A/dUSTVODnJ4BSM0/jjKxjcmZK66pPOkwiEpJTYlMpkpwwMBxhLymS94IPNe6w4ry92AhkltrCGBNdDDF/KZNfki/5HcnLy8bivr5yqSKN8PCwkC2+JGmlUoNSOKg3GoeP+EYrOXprmkPepU0RWT/hjdf7jnH52k8etHTCbPhLgt3VszpC5/74w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93df9025-5e5d-4541-b4d0-08df14cc4527
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:59:27.9247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIu+pRFNiilzWTgXO+Ppy7MsM0RyTwnd/A4KbJHc2t5/R2C/jLELkJ4rlm5hvZfQ93yxV48ROrUithKZqTDfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
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

--------------uz78Xbqbw4bv8O3MF8UkRM3W
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 17-Sep-26 12:14 PM, Radu Nicolau wrote:
>
>
> On 17-Sep-26 11:57 AM, Gowrishankar Muthukrishnan wrote:
>>
>> Hi,
>>
>> There is a series already proposed for extending the autotest :
>>
>> https://patches.dpdk.org/project/dpdk/list/?series=39137
>>
>> Can you please check if that helps ?.
>>
>> Regards,
>>
>> Gowrishankar M
>>
> Hi, I will have a look at all the patches, they look indeed that the 
> already cover what I did – I will pull mine down.
>
> Thanks,
> Radu
>
Hi,

I tried to test the patchsets - the one for cryptoperf cannot be merged, 
and the one for the test app doesn't have all the test cases (e.g. there 
is no mldsa_65_verify(deterministic) test case).


--------------uz78Xbqbw4bv8O3MF8UkRM3W
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 17-Sep-26 12:14 PM, Radu Nicolau
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:5ac0b690-b340-4cfa-90e6-33cac4c30eac@intel.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 17-Sep-26 11:57 AM, Gowrishankar
        Muthukrishnan wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com">
        <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
        <style>@scope {  }</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
        <div class="WordSection1">
          <p class="MsoPlainText">Hi,<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">There is a series already proposed for
            extending the autotest :<o:p></o:p></p>
          <p class="MsoPlainText"><a href="https://patches.dpdk.org/project/dpdk/list/?series=39137" moz-do-not-send="true" class="moz-txt-link-freetext">https://patches.dpdk.org/project/dpdk/list/?series=39137</a><o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">Can you please check if that helps ?.<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">Regards,<o:p></o:p></p>
          <p class="MsoPlainText">Gowrishankar M<o:p></o:p></p>
          <p class="MsoNormal"><span style="font-size:11.0pt"><o:p>&nbsp;</o:p></span></p>
        </div>
      </blockquote>
      Hi, I will have a look at all the patches, they look indeed that
      the already cover what I did – I will pull mine down.<br>
      <br>
      Thanks,<br>
      Radu<br>
      <br>
    </blockquote>
    <p>Hi,</p>
    <p>I tried to test the patchsets - the one for cryptoperf cannot be
      merged, and the one for the test app doesn't have all the test
      cases (e.g. there is no mldsa_65_verify(deterministic) test case).</p>
    <p><br>
    </p>
  </body>
</html>

--------------uz78Xbqbw4bv8O3MF8UkRM3W--
