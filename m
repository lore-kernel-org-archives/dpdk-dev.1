Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A14CA5FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 14:34:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1069440EDD;
	Tue,  6 Oct 2026 16:34:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 4A4024025A;
 Tue,  6 Oct 2026 16:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297265; x=1822833265;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6cKnmGiOP8eFu4FG3E3kX0GVqRNgiBF2rvGSqC1oNQ4=;
 b=Pi3vv2mQ4SH6/UKB6d3xzliutf7fPzZx+mdKGGXuRDwqFvMPgfixnnDE
 +eT0I+VUKHEgl6hNkGWp4mcJpik9OM+dLh6aqf3kUfqt4Z8QGbHPI0632
 VWIKNINEBUwD9hDW4cHu4j5HORPMpYb+JUZawmi9YSlE8YLQTZrzZZEJF
 D1KT3K2W8L8Ns53/VQFIg1hRgWBf0aDg1vWnlI3+6BamJ/mYG+uiCHQg2
 XQ7+2mmU/cXXDrcjW01ODTjaQTEA8YI89xX+FvlEAmXsyNVCj/AP1lziE
 3P/1gzTT58mmPC5/M6vaAkUxNWr4oFEantPKcPIZ3HDYMbQgE30gf72+A g==;
X-CSE-ConnectionGUID: 7PjmVhSHRpeketfXUGAktg==
X-CSE-MsgGUID: Deu/LVZ2Q0KG2yU+bw/l5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="29368"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="29368"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:34:19 -0700
X-CSE-ConnectionGUID: fBCKqPbYTY645dPD0ISz5A==
X-CSE-MsgGUID: /WjxilE5TOaxWpIK+jfWjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276288697"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:34:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:34:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 07:34:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWwdggHPfu3Nv9iS3WK5/xd19qPNkEN+ql7rCBScyAUYk/t3z3pZGhgXDVfrGYGdCCo0ku2+acLisXGn9sfnUcXy5QbOIEIiqaUQ1jheOiJ/5W3qXkTFDcNagLUUQgA849lpPf4l2vwI/4535hcFle5D2urLvoH503uv6UF+xUjU5YKyuJXQbGgHf3ZieSN3fk3tU0frS1CQoAuA7hR9+Er4DJfIf7bKXGq+AF4UxMNkSAmLAYnXzXZXv7+rp2pv4rTEBL5dbJZqzECHxtaFg/I9W3PX8u3WH333hTpZ1C9OqcN63l6astQ3lUbHEd+Y/TAQJKu7Q3XUgeTUxLl7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMGZOp50Lv2dBI6K5s9wRCvkQT4hQZC0Wb2yc/fuX6A=;
 b=fHV1SL4MR5TkDQPA5zJNDejAOPBY7vqUfHKokYRlM5whsI8kg4Gz5lXjZ0KA+ljHUBnqvS+UAeDoUu1QtSlBY6CZgY+H+BLVIwEutO6g95GUQSHVzuTmiwOtLH+NmNgX4glAt1tUMYx8z+JmMsMqtjXncf9ggg6fDBOtiZYp2cuWvqHzEFViH9xiCCaRAzGZvhloHQGE3rPYc9JxjWDeGpvjD0rhX0dzS2ezrQE8g0hSp487Yk3Npo1fb/SAlhECB/MCQq6COyZAq7s7t11b4ybQGscWWukDyJ1yw+ahRodxLXqVjMCDXDyxSH5bS+Ytf73G+MafTHJfNL7jqkZmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Tue, 6 Oct 2026 14:33:55 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 14:33:55 +0000
Message-ID: <80976d36-a074-4124-83c7-003966851277@intel.com>
Date: Tue, 6 Oct 2026 16:33:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix disabling outer VLAN insertion
To: Anurag Mandal <anurag.mandal@intel.com>, <dev@dpdk.org>
CC: <bruce.richardson@intel.com>, <stable@dpdk.org>
References: <20260930024839.337910-1-anurag.mandal@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260930024839.337910-1-anurag.mandal@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0346.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::33) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc88c3f-b431-4b78-fb89-08df23b6d996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: PL0GN1mU7p20KfgyPS/DgjpH0aaHmcZINnkBsXtrKY7qT8Y0TgQ9B2444wFhVb3rfuEVXlwER8UfmZA/d5RQ1y76xAA2Nm1JGB7vN28QbgNMRCcbBGNRTIObe1JvSFBA1XBu+h7z+S0P7AiMN99GRy1R1c108gRCFlb7DJUyUteXTyqeyDqy+nImru1XFT+9mda3DF8UFgEfcfrxHHUNUOdAJ7+XSsBW4VPkluyHqrsT2zsoi2OMbBOTQWJ1k412c9HZYxZJknZxJMkHPr+Gkrcg92hmAeXGnoCj4tY4g4folt8U7q6fBeREWcL7R8yT/CGyI7+vu2wydvu7MKhN0Tq3aHdVI5G4mvhVFYN0WiQ2FO+h3HwpFi4Tjf9DRGyZgPuNj9YlfBBu2Ia3dU3IO+Iqx9rOURmBDslKH14SMtfA6hYZDAmHOalsqsgnZ7ojaQbIs5UwBeb7no8g1Sl0EXVNLu73Y3luJI0+qyFLHGGaOSrDpqLIzO/D0kJHInjp4YwIncEuBFep6tJf7lHiG1QRY0UmT+VUjKKzGmK1glmOvEdSvKEWB6u74NwxhgUMA0yLUmNjlXA8mY13xB+4GGtylNWTb+T/opzwp+nZo4NbtJVCrbkae1rgByDRHdGV/RvA2uSHATWir23baJ5703QVACQ+DxYV7+iCRIkJgdI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG1XenUxNlVtVjlxa0VpRmxhZVZyVEEyeGZSWGJOcFI3UnNkSjE1TVAwSytT?=
 =?utf-8?B?eG16WFA3blBlbGZyS0xaZXg4ckw1TTZCbkJlMVp1SHVWdk1DR1FmaHAvYnBC?=
 =?utf-8?B?OEp2WDkxTkF4Ujh1cTE4WGs3T0pCMlpZWE9Nb1crZjUycFU5bDVlbFhKWktY?=
 =?utf-8?B?T1I3UEhkb3UyMVhEQUorMm5UTjZySjZkM041TUFKUm5Cckc3bkRxWkZ6bllz?=
 =?utf-8?B?MS9kbERwbXEzY3JvMnJ2NmtqdjY2UjFHUVFwWnB1SURqMnRaWDN2U3lPZVZX?=
 =?utf-8?B?SXB1OWN2cU9JM0IvNzdJaDk2bW1sVnNiRk9ib3hPeURldUR6ajRWQlBTMXl2?=
 =?utf-8?B?TUtBcGZvREZiRW45OG50Z0pjRG40SlpHNWErN3BDRGlmc1h5Y0V0ZDFDV0c5?=
 =?utf-8?B?YjlySEVVKzR4eVVYR05NMDAwS1d6cXJHa3NJUlVmNm4wbHBLVW9WRXBtMXg3?=
 =?utf-8?B?WWFyUFAvYTlKSGdnL1pHL2FQUEtVWnRDVnZlOXZXenFjOFNEU2Q1V2p3YU8v?=
 =?utf-8?B?TC9QOGp1Z3BzV0RZSTdZMFdhQ2xreHVZSkFMbXdMSG5uVE9KSDBtdFBLNjV4?=
 =?utf-8?B?UWNML000cWk1b3J0V2JHZUY3NXVQQWtIeER5c3BRL3V2K2V5Y2tlYTFoVWlN?=
 =?utf-8?B?TnFlMzl6dGx1bDM3WWxpSHF2NUwwbnZsNzVSOVpvTGZCcWdZMS9yY0RGZUps?=
 =?utf-8?B?NmVmZkVjaTdlZ29Nc3RnVlRualFFc0dHY2laT1pjWVJ5K1RXQ2ZOdXlNQU1L?=
 =?utf-8?B?L0FBb1lwNlk2bUdiSzRnMUk2T3VXdmpEVjVVRDd0dTlER2FLbjl5ZXc3T2xX?=
 =?utf-8?B?OFdRUENhdkI4OWdWdVZwaU50MFRDek9oRndaLzB1YkJ1dS9qNGlZd1hpcGU0?=
 =?utf-8?B?Wm9Ea0NySEJoZlh0eWxKODVJbUlkb0loMGx6RFdnL1NlSjluWDd3UkE4cU0x?=
 =?utf-8?B?bU9oWUxuNGdzc3kxSVczY1hHZHlvbGM4MlRCYllsdG1PUWVEblZqNXlHYUNE?=
 =?utf-8?B?QUNVK2FhTHNrQjlpN1F0UUJMMS95TXYyTG9MUjR6eGlQczVkRWlvenBkNSsv?=
 =?utf-8?B?MUNsNTZCYk5GSHEvUWl2WURRclNXekFteG13d2JRTzcwREZ0R0xPcUtDcWpR?=
 =?utf-8?B?WTF5blFxcEZjQ2NWbXZiK243NDhra0xCa1lYUnNIWnRNa1lLQlhpQVlTUnJ3?=
 =?utf-8?B?MU5xQlA2d2oxWFZhT3dmQ2dHZWRkajFReGFsdUxSSXdpdGY2YmhxTDBOTHFJ?=
 =?utf-8?B?ZUZMWnVKNEtBQktHeFlmeGo0MjdnRkpxeWU2UGJTRGJ3U1NzRTM0WFhUaGFS?=
 =?utf-8?B?VThqd3JlSU45ZGcxMTR4cGRHN1hwVGxMQlZ3dEszeDdjMlFKZU9uVXB0UndX?=
 =?utf-8?B?Ym56b2U4cDYwbmJ3K0doSmFranVhejJhcnNuQnlvV0FvNWVFeTBwNnlXME9Q?=
 =?utf-8?B?SGwzT3NkQ29vL1RQVk9pdDFPYWJrUi82VXB4VkNLU3VHVXlVcERqMm5ia0s1?=
 =?utf-8?B?TWVpN0drTzgwb3pIMms0dVozQVRpZWdmbDZIdkZPL3krV3RsTVVLdHAvclpt?=
 =?utf-8?B?aXZoeDVicnVBZVlCYlpKWS94dS9qWVR4RXhvNVZQbm9SMUhHKzl6QUtRN0h5?=
 =?utf-8?B?NDZqQ05VcktINUJXMkYwQzl4MGxsbk1ubmVhNW9wZWNyVkFuRk14RE9IMVk5?=
 =?utf-8?B?UWtQdUg1bkh1aXlSVnVzaVUwMXhDQ3V5SzJubHRBZFljbERiQnBwVHNNb0Ro?=
 =?utf-8?B?cHNWZElFM2RTbkpHejZXVWZKa1BldE05SGFzck1lS1ZPbERTSCttcTYrTExS?=
 =?utf-8?B?ZTE5My9LaHdMcDB6c3UxcmN4d21IcDNlRjh0SXR2SzlQVEdzVTB1SE80T0I3?=
 =?utf-8?B?cHloNzdJd0pYeVVtNnp3dGhGNUJmaE9WUHpZeHJCNmNaVEY2ajdMNXNlV0Jx?=
 =?utf-8?B?L0l1cUJPSUpURjlKc2s3WmV4dlVwaXR6cXZYeDhHK2ZhQ0NnamNkZ29PK1Ix?=
 =?utf-8?B?M1F1SmhzWkFmM1N5SU0vOTFvRUgxYmY3NjBVaFppejYvTnZDNWVJYXFJRjZt?=
 =?utf-8?B?N3h6cUtpa1NMVFhsYWJqRnBEMDd5YnU4WWZWWFBVYTEvUHRxamsvcXhYYW50?=
 =?utf-8?B?THl0Z2QrS1UxTUczR204aVdMa241ci9odU80SlM3OFpaY1ZGcEY4R2t3ZWQv?=
 =?utf-8?B?UHlJM3Y3L05wT3Urb1Myams0cWh0TXR5NG1jN2wrdTlZVC9TNnNpR3pUWWFR?=
 =?utf-8?B?WVkwdlZES0JvZWkyT1IyWklYK2dVOFlkenM2T09hS0xsaVVybWdKQmVNbkdk?=
 =?utf-8?B?emZVRzlwT3U1dmFTUFNNVkNISFBIWnNlUkdkNDdndjdzL3JjMVNyYjdhMFUz?=
 =?utf-8?Q?HTnHFH71A6EE8aWM=3D?=
X-Exchange-RoutingPolicyChecked: UaGOo6gTBXBBg1aGGwbMFPjVOLRCBlUiosFCK8UKY9WqSsCVBWN6keGLR379pVHfWJ5546il5y+CYaEfwr/YHjjG+vzKWyrM8+VBN757cjKXQ89fDE9RjB/2pIOG69Ul4TGAdyWrsE15pSfAtMdjs/1erWZL+Q35AZwxfV3bR/EAiFCBmD0U7/MXs3Pqm8tLWMRvP81T7grWTLBazwD2aOQktKagig0FjB2ANXjEnC6j3HOORoJojqFsDdf+64TmA1ukzn8y2xSBmyIW0+ptqdlBYpHJV41Mu2C6jloff5c3Do+KeUISedas87BzXkvLkl7PRWAzfrZiF6XsIJLKfg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc88c3f-b431-4b78-fb89-08df23b6d996
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:33:55.3257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncC0h5VB0fmnILhxl3KwEMhgyeHJ7WXgkeALSqV5mGuFdA2VjcbZucoZnx76urEEoJ/AfbpMSEQv4wgiXmIlSsHwnC7DbbkSq/QkOvX+ND8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631
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

On 9/30/2026 4:48 AM, Anurag Mandal wrote:
> ice_vsi_dis_outer_insertion() treats a 0 return from ice_update_vsi()
> as a failure, but a return value 0 means success, so the error and
> success paths are swapped.
> Removing a port VLAN in double VLAN mode logs an incorrect error,
> returns invalid argument, and leaves a stale
> ICE_AQ_VSI_OUTER_VLAN_PORT_BASED_INSERT bit in the cached
> VSI context that later VSI updates replay into hardware.
> 
> Inverted the check to avoid this bug.
> 
> Fixes: de5da9d16430 ("net/ice: support double VLAN")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>   drivers/net/intel/ice/ice_ethdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
> index 163304ba1e..2c5ffe07f3 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -6447,7 +6447,7 @@ static int ice_vsi_dis_outer_insertion(struct ice_vsi *vsi, struct ice_vsi_vlan_
>   		 ICE_AQ_VSI_OUTER_VLAN_TX_MODE_M);
>   
>   	status = ice_update_vsi(hw, vsi->idx, &ctxt, NULL);
> -	if (!status) {
> +	if (status) {
>   		PMD_DRV_LOG(ERR,
>   			    "update VSI for disabling outer VLAN insertion failed, err %d",
>   			    status);

I'd have preferred we do not treat integer values as booleans. This 
particular function returns the ice status code rather than int so 
perhaps we should check for `if (status != ICE_SUCCESS)` instead.

However, this isn't a big deal and can probably be fixed on apply, so

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
