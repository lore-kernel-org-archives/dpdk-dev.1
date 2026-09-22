Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEC9C98302
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 19:42:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F90142ED6;
	Tue, 22 Sep 2026 21:41:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id 501AE42EC4
 for <dev@dpdk.org>; Tue, 22 Sep 2026 21:41:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790106111; x=1821642111;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f4cmEMfL919YUVcv82fttulmko4GX39hc1LTpZZZGaA=;
 b=PYeR6ZAJykZO7Or80m60OP/fyauOJvqo2w8YYbO/zHEbpAsTBU5c7a+O
 rnbc6jDQ41fhhrj30bKag8yVg5C5g93Ry0XaKicpcMRDH8unt8nL3Ve3r
 YfHu987a8NHjFjXVaR2lbDm32S3uvd5N8Ua7SaDuZrl7339CSKzblmfMu
 6qR5tNXg1OnjlTQYRgfe3asjABjUUXblPTz1bohVwyeau2Vg8oYdH1v4t
 FreJVkF7qL74IRIR0RQwTz/lnsVu1hfFwENpY/MI7maMYmSXqughqiwB0
 383+PE4qcVZCbNAfbSx9FfDAvdP7AbSwHDKj2vhF3JhjiQrz5tik4U+0+ A==;
X-CSE-ConnectionGUID: Gag1iu2sRaOjptx+yWrS/A==
X-CSE-MsgGUID: 5srX4Ls6Qw23b7MwVox/XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="1253481"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="1253481"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 12:41:50 -0700
X-CSE-ConnectionGUID: naAXSLS/Reqw1vSRk7+tnQ==
X-CSE-MsgGUID: E7GLbpwdSviGi5EFd77a8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="281356771"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 12:41:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 12:41:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 12:41:48 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 12:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJnqwdx9soP1B85qbeLyet2k1uTi2tk/32wMypMkx8A1jzaILaojes89bVOS8Ya6LpddHc0o0yrfYIOT6pCrFw6REOp+pRrthmpeocD7f7zFo3PaUKUysAXfL8WEkuMeRSklPmS7WGBrOSRxL38ztnQQmp90XVUmV07ZybS5g1BB62i33vwRSheNn0nH/PvZbfclNP+/KzmhSIjm26QYdKEFCqL7t+8mul7rp8IrGASisYRESkWlIcZHZUV3UzuSr1Bs9Xahmzav8oaQA7R2aU66qd8qEhObcu0EjwaySUEKRwnsrCk7rw30b0GvwMbJiLMOCRLlPStrkkWw+3SzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Iy/KEH5iXiQ5Peal82XOd5VoQN9q7NqoEf7KJvD0bA=;
 b=wwnTmr0pzwo9adSVTFVKXmYs19xJDZagJ/eqRqLpo7q3eRUa1xlSQEIyQrLKOfDHToNH+Sfh0VF4mgf+PBRkfKRsb23YJk/TAgaB7bYOARseodTBvGYT9HFKv01OakdeCIW/Ua2phUCS2NX1mMh0QlvOgAnZJRnZDkcR9hLE0oAAZ6NP9MRDpKh+H9RjkJ7fwK/2UJ/v5p70G2vLeBOU4iCUV2k1JX+2n/UZ/YR1HMsVc8iZ8+N6QE/hp+cHPJWFeFWHy/hfp+5nxq3g5YXhDyrAYOsAmzHdWV9/YWk7LByYSuRsR0N4e6RxZz49iaWj7PcQVp2Xsk/tn4ItQm8kXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 19:41:46 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 19:41:46 +0000
Message-ID: <e7e35af9-b6b3-451a-a0fd-0dd826f625b5@intel.com>
Date: Tue, 22 Sep 2026 20:41:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/ice: support link flow control
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
References: <20260901151233.1110607-1-vladimir.medvedkin@intel.com>
 <20260910112524.1547156-1-vladimir.medvedkin@intel.com>
 <aqrF-QLwNCA_91NU@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <aqrF-QLwNCA_91NU@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::22) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|DM4PR11MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 156f7aed-2507-4675-ad55-08df18e18977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|18092099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: /+EFoa+oY+MwvYGMJVIVbefPNN8B+K5hY62o3BqAFYuF0wdXAYrS2aOleX8MxmbouQjRwhvn9vLl8trromlBIRnG42vMLOwobg5eUWxKuhuq2+8gOhyNpl3PWo5sWJ9XQcNmrbSZIpGaEuE+eCPWeaglADFoqWBnhY4KAUcgu74jVfR1qy2tawwW/idm9iDIKxQhBpsTq5yGJFNrGTssKt0mGQLG5pCQtchhFFBwdyo56IdfBlbKT8sjeCrJr4bc9ZNib7m2reKsc06P+6nmSFiciG9ZOxB/eVmM42547DkfynxMSH2AgTUYzS+TdCHNSj0Omx5/XckqvN1AHtW2zBEcwvXv2iE5PfY3cOJvGX0sP/7hRDDRCRvz8mSAPxnBD38sUBnpTbq9jh9kaWQQwsyvXU55jGdtoiwH6tM0Iu/LGaijG6APftffCLCo0VtLo8Bz6moQVwTi+C43GMso/zk3V29519v1mPgQFqaOXEEa1z0fqety6XzSndH7VjNq7lXGR6e43G+Thdpdh9c+kNCxTscQ4L/XCjSHOvSCnuz8PttKCkN8nxVobzvuaBukne9yMEe67zb7Do1Uk/QPa8SRgV3uYjElkyjSdLe16K2553v72PvCwpwEeq4T7te1mtV8tPz23AXljAm+Gi9AAmNhMGHVhbtbeLK2f0ijTn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(18092099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytpTkg1VVdCZHBBTU9vMUwvY1JoRWhlRmVpM2FpYUhCTHFBUVZnSjI5cm1i?=
 =?utf-8?B?cldnY1cyOWV0R2Y0OEtEMXVNRFNMTjdHYjAzbTFRSCt2dFAxSUs0VC9UK0F3?=
 =?utf-8?B?M3p4OHZIY0FRNUFDKytvQnVZcWluYy9WZU1wQTE3Q29UV1FZMktnZ3RFd3N0?=
 =?utf-8?B?ZWFhYjlqclk5K3lzeVJieXZQcTV2VXJSSXllTnhmUXZHQ3VJRDBadkRCOW55?=
 =?utf-8?B?c1lMTEVZQ1NzOTZhK3FNOFJ0cGFCT3JDNW0vOXdZTmt1YlBacTdtaXFBbEZR?=
 =?utf-8?B?ZjliemVxYnJDUUQwUGZxVXorbnVvWjVGemsxeTJ2d0hUOTF0TEhFdWQ1ak9J?=
 =?utf-8?B?RENWT1FKM0tRVVdoRjlBU3B6MHJtQ0c2ZmdMOXJGdWxvRDRYdXphNGRLY3NW?=
 =?utf-8?B?Y2FyOWpDMTkxREtjV0NvY1g4Mmo0L1I3MXRSSzF0TTRNRWFERnViVWZLSzNm?=
 =?utf-8?B?OGFUQVdBN1JXS3F0VG1wcVE1cG84K1RRN08zVHltUGd5R3IyYWxCUkdxOThF?=
 =?utf-8?B?K092Z1FSWDlqTlZEMnZiSEMrelRQbDY5MmplR1hIWEJXaXgvYXRTdFJvOHFO?=
 =?utf-8?B?czk1eE40N3BEdDkwL2UrTzcybmIweE5zWkF6blVNbGIrT2VvZ0Q1R0Qyckxv?=
 =?utf-8?B?WWVrZjhJbVBjRzJzUlp4ZzJXVEdqVnZsTTdxTWJHQ3E5VW9IT1U4N1dFR0Q1?=
 =?utf-8?B?T2tGWEJXOTUxWE9GMTYyRWRIUSszN2NxWE1KcGRUSTBnOC9lVDBDeDJHODRz?=
 =?utf-8?B?clJvb0RJUTZtRmhRR2EyUzgxY3dHNkNvcjN2RktBd0lUOU5ldGVBbHR5VGU3?=
 =?utf-8?B?MWorRzAxd2hEcHB3Um9LYWtNbE1OM0RPazFOUzFqMjN3NGtrWHk1a3V5UnNu?=
 =?utf-8?B?WXZDM29oUk1GS3FUOWVIY25iMWJXc3NjU3ZzYVNYWFBma1lqZHpUU3NPV0Mr?=
 =?utf-8?B?a1dWZmphaVExSzZ5NXVxSkFGcmM4OHB0a0dIT1dyVjNzeEY3RG5YdVVVRFFN?=
 =?utf-8?B?WVdINHcxbWVPUFNPdFV0VUdFVlYvd1JrYkUwRzB6MDdTKzhHVWFlSWxIZmpS?=
 =?utf-8?B?RWRyR21NZndYUU1jTjJYLzFFdlFmeTY2cVh3Ykl1THk5eEpBbVBpeCtydlYx?=
 =?utf-8?B?cTQ2eDRQNWtULzA3bnBPaEpZWXBSTGsyMFI0bDVQdmRUNk12b3JsU0Vwb3Vv?=
 =?utf-8?B?VFJVakN4a0ZKbG1VeVZpT1NIT1BrWEhadUxRek8zWUZyQkZ6ckVWQkhhM1Fy?=
 =?utf-8?B?SkVsTU9rWDVmYWpBZjQ5Y0NLamNtREt1ZWRONmhoVlA0U2xUSlNGMC9FVVpj?=
 =?utf-8?B?SzdIR3dUYkUrOHkrQXd5VkhhVG9ybG1DY0hqMGd4ZE8yRnJHZjE1TjNWZ0xQ?=
 =?utf-8?B?L1RTWkkvTGlQSW1hR2l5cElGRkpzZThJejNkY1FMZDVlQXFnT0ozYllwOUly?=
 =?utf-8?B?TFVsdWRtU2VKWWJGWWtLZk5GWFI2VkZMbmNOK2I5cXpmbXhTaGdMeExBODBW?=
 =?utf-8?B?MUdFOFppK2JnZVdndUEzN0NmL1NrcTYySUM4NmkvcVJyY0tQU3VhdjhHWE0z?=
 =?utf-8?B?RDlVb05XWmFWcTMvV3pFODRtVWpvUW5hdVQrNVFoa2NTNi9rd3FoK3ltcDNS?=
 =?utf-8?B?SkdWWXVCaFFLUm5SUytEZk9SNEpTRXJlaSs2N1dDeTBUN09ZTkFMVVNvcDAw?=
 =?utf-8?B?bDBramRNTDNYSWtJd294dVhicE5jbStjcWRPSjhYZld6Y1MwbVNiL054UnNw?=
 =?utf-8?B?WVBDbGhzZy85SkRxd0VLNUhJMUZXNHkxSG9SakNQcDlRTEZydWtHb3FmRzFS?=
 =?utf-8?B?bXZrSTZFT2MvUkVJSEZtbHY1a1Yva1llaDl2VW4xd3pMWjBqMUJoUFFuNGds?=
 =?utf-8?B?QlRENFZBVFFjMkR6dGJtaHI4TUtiOTJaVVNOdnFrcGVRNkkrU1gwMkwycVY0?=
 =?utf-8?B?SzV1Um16SGQrd1B2NytISm5sekV4dVNpMnNITkY1TWtER1pFeXBmbGt4elBh?=
 =?utf-8?B?YW5tZ3dURDN6TmlPZzBqU0lMNThWaFExSGZLS3BoTXRoQmNLd1RUYjJBMDZ0?=
 =?utf-8?B?aHFua3pYd25talZycTR3Z0hyQTR1Y0szYjYxWXJBTEpkSy9Ka0Q0L0lCT043?=
 =?utf-8?B?WHI5TDFsYWExbG13ZEhQYjd6bzFhUlorTVRxTDBGVU9jNEtxa1I0TWZEZllH?=
 =?utf-8?B?NWN2c0thbjJac1A2TDBUajVIN3lRZ093TlFOKytueUV5L3hSWUhDbWNRbnhP?=
 =?utf-8?B?MzlkZ3JJY2FZWlQ2RTc3bFhqNWxqSE9pbEprTkhJQWdMN3l6cFZIUHUwOXln?=
 =?utf-8?B?a1h1T2tqeFBnaDlJTTlQU1JFSXlrOFQzWTk5Y3dMS3NaS0pSMDZWKy8rdGMx?=
 =?utf-8?Q?Nut4MGKyBPL16I9M=3D?=
X-Exchange-RoutingPolicyChecked: MZMcDEB7++aYNgSRWAg6rxLQWN8EnSy0S2CMjJxJ3MKdn+UtIHrnEejUB7nD/WL3aI9aKEcAbJQQN62GC7Azb7EDKgkYotsgBNzDCJBdEkQl9jSdUU0NjqlMoo1Rzz85b+Qg7Q3JO67BJ6BLMprPXovRirC7jwi4dmYr3VhSEI+EqhoIFr4ilkIBsJTyUwErIz++pkYy4Q8VjuL0Y7fcf1k4IcHw3QkLZyG4zfM1cBc7B2fuL0FMZvufbnLIdaYTXRT/2kfiKFOwSCgqhhTM9tRNjvF8GXMbAYv/j8d4hw7BfnUYxo0ac3CSzdEKfdeiYNFL9/20Mx2S1quYCrfMyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 156f7aed-2507-4675-ad55-08df18e18977
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 19:41:46.4031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDwvDBGm4rUhnJ0KZNGfUftEpHkXsYPBzGIwqH87yhacHRvwizHDMCa/zf6LmIwRruli27PhisEAdgGMnzqo626WP4qm/oQzI7Tv6ErpOzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
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

Hi Bruce,


On 9/16/2026 5:38 PM, Bruce Richardson wrote:
> On Thu, Sep 10, 2026 at 11:25:24AM +0000, Vladimir Medvedkin wrote:
>> Add get and set functions for link flow control (802.3x).
>>
>> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>> ---
> A few minor comments inline below.
>
> /Bruce
>
>>   doc/guides/nics/features/ice.ini       |   1 +
>>   doc/guides/rel_notes/release_26_11.rst |   4 +
>>   drivers/net/intel/ice/ice_ethdev.c     | 271 +++++++++++++++++++------
>>   drivers/net/intel/ice/ice_ethdev.h     |   1 +
>>   4 files changed, 217 insertions(+), 60 deletions(-)
>>
>> diff --git a/doc/guides/nics/features/ice.ini b/doc/guides/nics/features/ice.ini
>> index 893d09e9ec..309f691f32 100644
>> --- a/doc/guides/nics/features/ice.ini
>> +++ b/doc/guides/nics/features/ice.ini
>> @@ -30,6 +30,7 @@ RSS hash             = Y
>>   RSS key update       = Y
>>   RSS reta update      = Y
>>   VLAN filter          = Y
>> +Flow control         = Y
>>   Traffic manager      = Y
>>   CRC offload          = Y
>>   VLAN offload         = Y
>> diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
>> index c8cc86295d..5c4cd8a6df 100644
>> --- a/doc/guides/rel_notes/release_26_11.rst
>> +++ b/doc/guides/rel_notes/release_26_11.rst
>> @@ -55,6 +55,10 @@ New Features
>>        Also, make sure to start the actual text at the margin.
>>        =======================================================
>>   
>> +* **Updated Intel ice driver.**
>> +
>> +  * Added support for getting and setting link (802.3x) flow control.
>> +
>>   
>>   Removed Items
>>   -------------
>> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
>> index 76b8ff0a72..909b3ef963 100644
>> --- a/drivers/net/intel/ice/ice_ethdev.c
>> +++ b/drivers/net/intel/ice/ice_ethdev.c
>> @@ -211,7 +211,12 @@ static int ice_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa);
>>   static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev,
>>   						size_t *no_of_elements);
>>   static int ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
>> +static void ice_set_dflt_mib(struct rte_eth_dev *dev);
>> +static int ice_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf);
>> +static int ice_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf);
>>   static int ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf);
>> +static int ice_cfg_fc_params(struct rte_eth_dev *dev, uint8_t tc, uint8_t tc_bitmap,
>> +			     const struct rte_eth_fc_conf *fc_conf);
>>   
>>   static const struct rte_pci_id pci_id_ice_map[] = {
>>   	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
>> @@ -352,6 +357,8 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
>>   	.fec_set                      = ice_fec_set,
>>   	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
>>   	.get_dcb_info                 =	ice_get_dcb_info,
>> +	.flow_ctrl_get                = ice_flow_ctrl_get,
>> +	.flow_ctrl_set                = ice_flow_ctrl_set,
>>   	.priority_flow_ctrl_set       = ice_priority_flow_ctrl_set,
>>   };
>>   
>> @@ -1468,9 +1475,16 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
>>   		switch (opcode) {
>>   		case ice_aqc_opc_get_link_status:
>>   			ret = ice_link_update(dev, 0);
>> -			if (!ret)
>> +			if (!ret) {
>> +				/* On link-up, reapply the default single-TC configuration. */
>> +				if ((hw->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
>> +						!(dev->data->dev_conf.rxmode.mq_mode &
>> +							RTE_ETH_MQ_RX_DCB_FLAG))
>> +					ice_set_dflt_mib(dev);
>> +
>>   				rte_eth_dev_callback_process
>>   					(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
>> +			}
>>   			break;
>>   		default:
>>   			PMD_DRV_LOG(DEBUG, "Request %u is not supported yet",
>> @@ -4073,6 +4087,22 @@ ice_dev_configure(struct rte_eth_dev *dev)
>>   	return 0;
>>   }
>>   
>> +static int
>> +ice_get_link_info_safe(struct ice_pf *pf, bool ena_lse,
>> +		       struct ice_link_status *link)
>> +{
>> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
>> +	int ret;
>> +
>> +	rte_spinlock_lock(&pf->link_lock);
>> +
>> +	ret = ice_aq_get_link_info(hw->port_info, ena_lse, link, NULL);
>> +
>> +	rte_spinlock_unlock(&pf->link_lock);
>> +
>> +	return ret;
>> +}
>> +
> Rather than moving this function up, why not just put a prototype
> declaration for it at the top of the file with all the other static
> functions? It would make the diff smaller.
>
>>   static int
>>   ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
>>   {
>> @@ -4105,6 +4135,182 @@ ice_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * Program a default single-TC local LLDP MIB configuration. All user priorities
>> + * map to TC0 at 100% bandwidth.
>> + */
>> +static void
>> +ice_set_dflt_mib(struct rte_eth_dev *dev)
>> +{
>> +	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
>> +	struct ice_dcbx_cfg dcbcfg = { 0 };
>> +	uint8_t lldpmib[ICE_LLDPDU_SIZE] = { 0 };
>> +	uint16_t miblen;
>> +
>> +	dcbcfg.etscfg.willing = 1;
>> +	dcbcfg.etscfg.maxtcs = hw->func_caps.common_cap.maxtc;
>> +	dcbcfg.etscfg.tcbwtable[0] = 100;
>> +	dcbcfg.etscfg.tsatable[0] = ICE_IEEE_TSA_ETS;
>> +	dcbcfg.etsrec = dcbcfg.etscfg;
>> +	dcbcfg.etsrec.willing = 0;
>> +	dcbcfg.pfc.willing = 1;
>> +	dcbcfg.pfc.pfccap = hw->func_caps.common_cap.maxtc;
>> +
>> +	ice_dcb_cfg_to_lldp(lldpmib, &miblen, &dcbcfg, ICE_SET_PFC_SYM);
>> +
>> +	if (ice_aq_set_lldp_mib(hw, SET_LOCAL_MIB_TYPE_LOCAL_MIB, lldpmib, miblen, NULL))
>> +		PMD_DRV_LOG(ERR, "Failed to set default LLDP MIB");
>> +}
>> +
>> +static int
>> +ice_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
>> +{
>> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
>> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
>> +	struct ice_port_info *pi = hw->port_info;
>> +	bool enable_lse = dev->data->dev_conf.intr_conf.lsc ? true : false;
>> +	struct ice_link_status link_status;
>> +	int ret;
>> +
>> +	/* Refresh the negotiated flow control mode from the link status */
>> +	ret = ice_get_link_info_safe(pf, enable_lse, &link_status);
>> +	if (ret != ICE_SUCCESS) {
>> +		PMD_DRV_LOG(ERR, "Failed to get link info");
>> +		return -EIO;
>> +	}
>> +
>> +	*fc_conf = pf->fc_conf;
>> +
>> +	/* report the link flow control mode currently in effect */
>> +	switch (pi->fc.current_mode) {
>> +	case ICE_FC_FULL:
>> +		fc_conf->mode = RTE_ETH_FC_FULL;
>> +		break;
>> +	case ICE_FC_TX_PAUSE:
>> +		fc_conf->mode = RTE_ETH_FC_TX_PAUSE;
>> +		break;
>> +	case ICE_FC_RX_PAUSE:
>> +		fc_conf->mode = RTE_ETH_FC_RX_PAUSE;
>> +		break;
>> +	default:
>> +		fc_conf->mode = RTE_ETH_FC_NONE;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Program the Rx buffer watermarks, pause quanta and MAC control frame
>> + * forwarding shared by link flow control and priority flow control.
>> + * A tc_bitmap of 0 selects link flow control; a single bit selects a PFC
>> + * traffic class. Watermark or quanta values of 0 leave the current setting.
>> + */
>> +static int
>> +ice_cfg_fc_params(struct rte_eth_dev *dev, uint8_t tc, uint8_t tc_bitmap,
>> +		  const struct rte_eth_fc_conf *fc_conf)
> Minor nit:
> Looking at how this is used, I don't think you need both a tc_bitmap and a
> tc parameter, since tc_bitmap is passed either as 0, or 1 << tc, so
> therefore the tc is computable from the bitmap.
>
> 	tc = tc_bitmap == 0 ? 0 : rte_ctz32(tc_bitmap);
>
>> +{
>> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
>> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
>> +	struct ice_port_info *port_info = hw->port_info;
>> +	uint32_t high_water = fc_conf->high_water;
>> +	uint32_t low_water = fc_conf->low_water;
>> +	uint16_t max_frame_size;
>> +	int cgd_idx;
>> +	int ret;
>> +
>> +	if (high_water > ICE_MAC_TC_MAX_WATERMARK)
>> +		high_water = ICE_MAC_TC_MAX_WATERMARK;
>> +	if (low_water > ICE_MAC_TC_MAX_WATERMARK)
>> +		low_water = ICE_MAC_TC_MAX_WATERMARK;
>> +
>> +	cgd_idx = ice_get_cgd_idx(hw, tc);
>> +	if (high_water)
>> +		wr32(hw, GLRPB_TCHW(cgd_idx), high_water);
>> +	if (low_water)
>> +		wr32(hw, GLRPB_TCLW(cgd_idx), low_water);
>> +
>> +	/* Update pause quanta and refresh threshold */
>> +	max_frame_size = pf->dev_data->mtu ?
>> +		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
>> +		ICE_FRAME_SIZE_MAX;
>> +	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, tc_bitmap,
>> +			fc_conf->pause_time, ((u32)fc_conf->pause_time + 1) / 2,
>> +			false, NULL);
>> +	if (ret) {
>> +		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
>> +		return ret;
>> +	}
>> +
>> +	/* Update forwarding of the non FC MAC control frames settings */
>> +	if (hw->mac_type == ICE_MAC_E830) {
>> +#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
>> +		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
>> +
>> +		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
>> +
>> +		if (fc_conf->mac_ctrl_frame_fwd)
>> +			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
>> +		else
>> +			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
>> +
>> +		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), mac_config);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +ice_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
>> +{
>> +	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
>> +	struct ice_hw *hw = ICE_PF_TO_HW(pf);
>> +	struct ice_port_info *pi = hw->port_info;
>> +	bool link_up;
>> +	u8 aq_failures;
>> +	int ret;
>> +
>> +	/* Link flow control and priority flow control are mutually exclusive */
>> +	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
>> +		PMD_DRV_LOG(ERR, "Priority flow control is enabled, cannot set link flow control");
>> +		return -ENOTSUP;
>> +	}
>> +
>> +	switch (fc_conf->mode) {
>> +	case RTE_ETH_FC_FULL:
>> +		pi->fc.req_mode = ICE_FC_FULL;
>> +		break;
>> +	case RTE_ETH_FC_TX_PAUSE:
>> +		pi->fc.req_mode = ICE_FC_TX_PAUSE;
>> +		break;
>> +	case RTE_ETH_FC_RX_PAUSE:
>> +		pi->fc.req_mode = ICE_FC_RX_PAUSE;
>> +		break;
>> +	default:
>> +		pi->fc.req_mode = ICE_FC_NONE;
>> +	}
>> +
>> +	/* ice_set_fc() reprograms the PHY pause config and, if auto link update
>> +	 * is enabled, restarts the link so the new mode is renegotiated. The
>> +	 * default MIB that arms the MAC for LFC is reapplied from the link-up
>> +	 * event handler.
>> +	 */
>> +	link_up = pi->phy.link_info.link_info & ICE_AQ_LINK_UP;
> Is it safe to read this outside the lock? For safety should this be a call
> to ice_get_link_info_safe? AI flags that all other instances in this file
> use the function.
>
>> +
>> +	ret = ice_set_fc(pi, &aq_failures, link_up);
>> +	if (ret != 0 && aq_failures != ICE_SET_FC_AQ_FAIL_UPDATE) {
>> +		PMD_DRV_LOG(ERR, "Failed to set flow control mode, ret %d aq_failures 0x%x",
>> +			    ret, aq_failures);
>> +		return -EIO;
>> +	}
>> +
>> +	pf->fc_conf = *fc_conf;
>> +
>> +	/* Apply the Rx buffer watermarks and pause quanta for the link flow
>> +	 * control traffic class (LFC rides user priority 0).
>> +	 */
>> +	return ice_cfg_fc_params(dev, 0, 0, fc_conf);
>> +}
> AI review flags a potential issue here. What happens to pf->fc_conf if the
> application fails? The applied values will not match the stored ones.
agree, but I think we could do even better. Don't fail if setting FC 
parameters returns an error. Instead don't update pause quanta (the only 
place where ice_cfg_fc_params may fail) value in the fc_conf cache.
>
>> +
>>   static int
>>   ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc_conf)
>>   {
>> @@ -4160,49 +4366,10 @@ ice_priority_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_pfc_conf *pfc
>>   		return ret;
>>   	}
>>   
>> -	/* Update high and low watermarks */
>> -	u32 high_watermark = pfc_conf->fc.high_water;
>> -	if (high_watermark > ICE_MAC_TC_MAX_WATERMARK)
>> -		high_watermark = ICE_MAC_TC_MAX_WATERMARK;
>> -
>> -	u32 low_watermark = pfc_conf->fc.low_water;
>> -	if (low_watermark > ICE_MAC_TC_MAX_WATERMARK)
>> -		low_watermark = ICE_MAC_TC_MAX_WATERMARK;
>> -
>> -	int cgd_idx = ice_get_cgd_idx(hw, tc);
>> -
>> -	if (high_watermark)
>> -		wr32(hw, GLRPB_TCHW(cgd_idx), high_watermark);
>> -	if (low_watermark)
>> -		wr32(hw, GLRPB_TCLW(cgd_idx), low_watermark);
>> -
>> -	/* Update pause quanta */
>> -	uint16_t max_frame_size = pf->dev_data->mtu ?
>> -		pf->dev_data->mtu + ICE_ETH_OVERHEAD :
>> -		ICE_FRAME_SIZE_MAX;
>> -	ret = ice_aq_set_mac_pfc_cfg(hw, max_frame_size, 1 << tc, pfc_conf->fc.pause_time,
>> -			((u32)pfc_conf->fc.pause_time + 1) / 2, false, NULL);
>> -	if (ret) {
>> -		PMD_DRV_LOG(ERR, "Can not update MAC configuration");
>> -		return ret;
>> -	}
>> -
>> -	/* Update forwarding of the non FC MAC control frames settings */
>> -	if ((hw)->mac_type == ICE_MAC_E830) {
>> -#define E830_MAC_COMMAND_CONFIG(pi) (((pi)->phy.link_info.link_speed == ICE_AQ_LINK_SPEED_200GB) ? \
>> -		E830_PRTMAC_200G_COMMAND_CONFIG : E830_PRTMAC_COMMAND_CONFIG)
>> -
>> -		u32 mac_config = rd32(hw, E830_MAC_COMMAND_CONFIG(port_info));
>> -
>> -		if (pfc_conf->fc.mac_ctrl_frame_fwd)
>> -			mac_config |= E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
>> -		else
>> -			mac_config &= ~E830_PRTMAC_COMMAND_CONFIG_CNTL_FRM_ENA_M;
>> -
>> -		wr32(hw, E830_MAC_COMMAND_CONFIG(port_info), mac_config);
>> -	}
>> -
>> -	return 0;
>> +	/* Apply the Rx buffer watermarks and pause quanta for the PFC
>> +	 * traffic class selected by the user priority.
>> +	 */
>> +	return ice_cfg_fc_params(dev, tc, 1 << tc, &pfc_conf->fc);
>>   }
>>   
>>   static void
>> @@ -4373,22 +4540,6 @@ ice_rxq_intr_setup(struct rte_eth_dev *dev)
>>   	return 0;
>>   }
>>   
>> -static int
>> -ice_get_link_info_safe(struct ice_pf *pf, bool ena_lse,
>> -		       struct ice_link_status *link)
>> -{
>> -	struct ice_hw *hw = ICE_PF_TO_HW(pf);
>> -	int ret;
>> -
>> -	rte_spinlock_lock(&pf->link_lock);
>> -
>> -	ret = ice_aq_get_link_info(hw->port_info, ena_lse, link, NULL);
>> -
>> -	rte_spinlock_unlock(&pf->link_lock);
>> -
>> -	return ret;
>> -}
>> -
>>   static void
>>   ice_get_init_link_status(struct rte_eth_dev *dev)
>>   {
>> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
>> index 7ee3ea8a70..3143aca74a 100644
>> --- a/drivers/net/intel/ice/ice_ethdev.h
>> +++ b/drivers/net/intel/ice/ice_ethdev.h
>> @@ -613,6 +613,7 @@ struct ice_pf {
>>   	 * and link status update during dev_start.
>>   	 */
>>   	rte_spinlock_t link_lock;
>> +	struct rte_eth_fc_conf fc_conf; /* cached link flow control config */
>>   };
>>   
>>   #define ICE_MAX_QUEUE_NUM  2048
>> -- 
>> 2.43.0
>>
-- 
Regards,
Vladimir

