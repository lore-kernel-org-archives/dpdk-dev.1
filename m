Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E67CD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 14:06:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3994F4021E;
	Fri, 29 May 2026 16:06:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 07000400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 16:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780063582; x=1811599582;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g4ekwdiJa71AvZqSFMPws+a0VJ/ZF+nEwx4jQ1IwN0s=;
 b=MrSkjwUqSlDsm0Pukg3twFx8NA9wfBoOH3LPoEyI6QrG+7rT0T5Wz6MI
 9NpwtmzAF7gGMBwR32r7Hab0BA5NcnXKbIlpYV/qiCpf6sNPxH8z03wK0
 HC6eYGeV6hZNPMLLLX972FLA8ba1PSko9MBprklA74qVsehLnWE6Jorp5
 yq/90OALrTCs0RhavyqK/3pke6j4VrFoV/Eu1LxkqKYrXtHy0A/ef+8v3
 I32MWfxhbuv5riyySuSSPNquBgD98zOOzfmVunUtEmOgv/nUKKxneXWw+
 qB8VrILEB0KwomQ7yhYmTaM1SOEdiW9lboEFC0MoBLGTZIGN8Fo4CXo/y w==;
X-CSE-ConnectionGUID: jOwpJlFcSLCCzyMpsJr2mQ==
X-CSE-MsgGUID: UKm+eAEfRpet2n28EJM/0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91225346"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91225346"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 07:06:20 -0700
X-CSE-ConnectionGUID: /pjkYDLkS5mwRsQl/tSeng==
X-CSE-MsgGUID: Z3UJm/GlR5OuBIypSULdmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="238463970"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 07:06:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 07:06:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 07:06:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.48) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 07:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPj+aBaOIiSko5sRqiDtxGJnWYItvnNMyHU1kKX3hNLt5Y+nn60r0A5F4BHfD/HnH5kqaePLTvh9Us2m8VozD0H58fNgqqCf0/bnlR5EZdSoq6S0IuZhlVOQoSUKZgSP60lpcRML2BP3jJRqZ54y57nFoPIPfRmYMlAXqQ995Hy/qtFfdtsHzZJpKz3Segyzne81qrm/YtxqWYlaOwIw88kooLZELCF5URY6NWxA9QiwGTXQStaumcc28FJwz7Ce/xRpnU+PZSN7lFVWxDpC5/PSS9Nxut/+Mzn0AxApq+LkAgsLZGu/gBG4IKefWeSS45/wC/errorQngf0Zs86Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+RcYX1BGTNzF8X13s2UC46rzw8qqjjB7stTkap61BU=;
 b=sl3kgQ5b6XyCsP2aaX3SSxNOXDzydDAmkPuYZPs8neo2+Z1zK300NhjFOr1Jr9ZiiWfRFcIk5EViP3DDDvngQ8wI/twEv+bBKX7BSkmPtdHJq4K0fxcqLLjN9bWujjYxy1ewzjbe9NzCV+LNzoLk8bVsTHzlgeYF3r+NN/bGQTglw19BWfC+3iusFwIFJNrpCJ9IFQMtlF0s7n9xH/8d4+dbzz8gOR6DcVCAfqppp96CXjlaWD6BY6R8KVlz4iDtCDqHMFSrRAZt3LCnV5pBbbj8Nr2OnQJteZtHLHEjDiMUU6xzbpJS57XKsFl4+S4yuMNquzvWLF+VjD0PInvgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB7543.namprd11.prod.outlook.com (2603:10b6:510:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 14:06:15 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 14:06:15 +0000
Message-ID: <dd11f8e3-4f5a-47dc-9e94-e0e9d4948985@intel.com>
Date: Fri, 29 May 2026 16:06:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/29] net/ixgbe: use common checks in FDIR filters
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1775826526.git.anatoly.burakov@intel.com>
 <f7545b6d624d42ff490c4e37b73dd5008dd695d8.1775826526.git.anatoly.burakov@intel.com>
 <20260419084221.64f25ce1@phoenix.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260419084221.64f25ce1@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0264.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0980fb-6fbd-44ff-9e9c-08debd8b7250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: a3JNwNr4GKBLu0NtpcpE6wJJmjybhToYJVa8DTTtZvcFtrCzjzeWOiDp2X9dY0tNfygd+JFXnTlO/jtxNEzgYBqs6vnmS5nETHUAbCKpI5YJz7zgEIkVgXgZFLa/+g0bs2DhilQHyCro/FdxXVpLbvo4++TZQpIfZvDc4gasRnsFIL9ECVVtBZhAZxNg0sMvzwET7ytU/M8y91+lMBiojzBJ+z4KcVJP7RHo8S9PkMvzaadp4zeQGLdxmV6VSDmvufx99XzEmZTe5Vd/6y2DYo4FyhI9vY8ByZCH51AoVJfbXXDrEO+JECN0Cv0QzbwECmU/gerZTuvr3Y/fIRnt7IE9SIn0DlTT8FTekmswrS7TRTlQ9ZBVT4bf7ByAYF1Lh3Lt8rA6H+t0IKkjEiCMsicpMktrB4BwINV1ISJso3sRyfbqS87BgzMj/luWr1S2zL/tyqNMBa9+jVZZDznWbjb78lqbs/qTQuvvNObdmC2mbmdOi0wi9mXJ9gn2eoxUwtQenrsGXkuUMuEsT1jOrITZ4JXd0GSAE9vPHoTiUlRv1OyOzaC2YipeaqItHdv0qLA5q5k015UAU/SDmdEpqJcoLYzbXuC6IaoNjQOaLtwI19U1Zm3BjpcSu6q4n2iL7V7QEmuDCxAgp+b5SsKQ4VrWx8yd9T3NIvzLtmMjsSEX2rmP0PTWerXePf22+V27
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3BuS2NNTU9OZnBvKys0eWhpaTZHNU5wNjVvczI5UjdkbXhOMFFyNTY4Vi9J?=
 =?utf-8?B?cXJNYzRpa3d1Y2VYUGtpOEF1QThnNTg2ZFdFU0kvemh3NXkzNk9TOVJEZ3VC?=
 =?utf-8?B?TDVWcEFsZHM4M1FZQzBYVnhxc09xczJoeWhCZGZkLzFoeEZaUnpBSlNjUHFD?=
 =?utf-8?B?L1BmWFdBT0VxRldNZEFNWG40a1oyOUZjUVRTV3RsaGhUa3B3UytRMGh0Z0s5?=
 =?utf-8?B?NTU1MWNTd3VyZllkaWdRM1MzbFNkWWlzWXVpQ0NwU2xjZk5CZzErZzBMVHdp?=
 =?utf-8?B?UzJnTDBES2Y2TisxQVk1SldxTmRHN3RJL0tYMUpOcnpjU0tJcWhUc1RnYWl6?=
 =?utf-8?B?TEp2NEV5Vjh2Z3lFZkdXYXRRbzVxUEdoTDlkMjhCS09DNEh0N3p6cmxRRFQ0?=
 =?utf-8?B?TjdpcjMrWENmRDh5b0V4MElSeGV1VElpRk5sS2Z5TXBCRjJSMTVxYmRXY1NK?=
 =?utf-8?B?SWNFR25pQ0hjMitRTzhUNnBVcytHSFh1ZlUxNHNHZ05ITHRSakEvajNIRU9G?=
 =?utf-8?B?emZ6ZDdQaVdvUzJrdnRSZTgyakJDcloxVERvMTZGa29KdTdxK2taTmhsU3Za?=
 =?utf-8?B?enJFZXVvWTB6TGtiQ3NTNFh3d1Rjeks3Ry9aeXFPT1o1eHN0Y2g3Z0krenVY?=
 =?utf-8?B?TmxjQmRmbmUzSm9adWFYQVNYSVV5Q0gyUzZDeFUzRHVnWGRHNU1TU3M2TUdF?=
 =?utf-8?B?RlkrUTB1SlozMWFJNUxwTkU0VzdXTkw0S2piMDhrWjA5OVNMU0UyWmtlcS9H?=
 =?utf-8?B?VEtGWWxKWEJmeGdycWRmVTFuQmt1b1A0L1AxaHJNYVBVb2I3N2lFWGtHZjdX?=
 =?utf-8?B?azRVVUNBT2tCUUFIQVRGbTBwc0lGbmRtNnpTQTNCdGs1Rm5IVzVLVlpacndQ?=
 =?utf-8?B?TjNZU3k3aVFDbG5pWHdsaElZdXFtUS9LVzZGYndQOFpYSzdPcVNMbXovbVdG?=
 =?utf-8?B?NFJsb2F5Vmc2UHdEMTE0L2pLaXFIUnFJdXhjVGRUbUcwWHJTbjlxcE9BMlkz?=
 =?utf-8?B?dkNOR29OT2dZakEyU09YOHVWWm9pQ2dWQ0ROMVhmWmtQQXdpd1pmdEZWUWlV?=
 =?utf-8?B?NG1EczlFa094dGFCdHpmRDk3TmRHREQ4YjV4bzhUaTZsYUdvc0JKLzF1bGNB?=
 =?utf-8?B?Q0l2NGpQNEdzY2FRbnN1eTZCYXlsN0lGcU1GbEE5bzN3Mks5WS9OUm9JVm1S?=
 =?utf-8?B?clNmbmdJcis5WFJTOXhBaWRZUmpQYzFWc3NRcUEyYmZRTjYxeFZtZDUrMmZ6?=
 =?utf-8?B?bnVkWXgvR0ZDL3o4ZGVJNk5QVkdGcFl6cjAyNVZ5YytDNXc0RmNyU1RSK3Rt?=
 =?utf-8?B?QUluMGdQOGI4Wm14YXBsQklVQmV0QTlvRk5jUGFBUWhOWURUTXFlYmo0dS9k?=
 =?utf-8?B?Vk4vWmM0YUt0cGltYnVlbDhYc0RJSmo1Z2tQT09OZU9jOElwazNtMmVtTVZ0?=
 =?utf-8?B?cFB6YUp5bjV5V3F0NmdydFAxNzRFMU5aci9GdzdYNTRhYU5zaHRlcTd2cmZQ?=
 =?utf-8?B?Skg2MCsySWd0OGtSbkRFZWJUdWViLy8yOEYyY3J6OVRRVkwwWGJZSXgzYVlF?=
 =?utf-8?B?WmdCVDdDYVdsUW9GMUFRZEVFRkVMcnVNU2VML0J3WjFzekNqMDRIeVpqTTNz?=
 =?utf-8?B?SVpsTG9QR0hnUVdPWGxTM1FxRk9Qa1hlVTd3em53WG5XQnFxVnl5a2RZcEpR?=
 =?utf-8?B?T0xNU1J3MnZ6M1NlUHRzQ1hqdVBuMnJSME1uRVpWQ20yZnF1VHRpTk8rdXcr?=
 =?utf-8?B?eVdkdERoTUtSZkVJbEpOL2dmdWdqY1cybUN1TS9neXJjbFZuRzgrMkV4Y1NJ?=
 =?utf-8?B?dWp2eWkvR2t1RWR0WDY0dHN0ZkQ2M0F5bmJSQ09tK05TL0JYdFJhTGk4b1dm?=
 =?utf-8?B?N2tvejNvUlBCOURMaG0yajdGN2w2RENuZkQ5eG5GVHp1LzJWbVFtblViWDAx?=
 =?utf-8?B?Uk8rdWNQS2ttblJuK212clhSTnMyY3o5ajg5aGU3RGtlQWdHd1NHR09mVTRs?=
 =?utf-8?B?YXlxRUp6c2twOVR0djJLRmxSNDBjL2VUUHR2UFJ3SFIweGF4d1pGOW1jcHZy?=
 =?utf-8?B?Qi9uYUVQcWQyMmhuUjhSeWRlcG44NUdoV1dFSEh4QXdqZnBwMXZtS1dUb0xY?=
 =?utf-8?B?b2hiMkc1bjFEemtIelJyTk9ia2I2UXcraG9NNXVva1I0SCt0dDcwOXB3Q2x6?=
 =?utf-8?B?L3ZwbkVMRGVQbjAxQ3gzazFOOElQd21FeHJ0OThwTUoyMGNubSt5dW50Z0Jt?=
 =?utf-8?B?WXVtYkZTRVA4dVcyT1lKeTRRZG0rZWNJYUNqeE5JMVBoMmFhd04wLzIwQk5l?=
 =?utf-8?B?SzcxMzRJNXdYNWN4a3I0SzNMZFZ0cjdJdGdhSjVQa2E3YTVqUzVVWnpXalpN?=
 =?utf-8?Q?L0ZIHl0gucaT1eO0=3D?=
X-Exchange-RoutingPolicyChecked: cOgdbQicdS9/EennaQ0qRrfaLvzErW3o5vqdaqPV4qlfrOZdPP+ZibeKEuXrQskKMflz3E0KJoxQwxvU4UgsbCEIBLOBpzaaI8fwuTrXx2ytq3K/xsh7CbbXdGeip95KjfR+1ojVNptKvZ4Ud7AdpTk1jQbE855faXekQl2YvAdQA0kJiU/lPVFIIjnyp7OeNZFvoTFUme+DWA3R/jR0s7cSD8JVt9U0HTdGcVd2kHeLUQWBsGQ0pkgeyznBwG0DVbQ+IeR4bcJWMDI1ifL44LvKJAl1MA0JYZeYEzbet83kFCL1muXgV6F/8O6YGnwKeht6C3YvTfdlP7R/u1K93Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0980fb-6fbd-44ff-9e9c-08debd8b7250
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 14:06:15.3227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4ZU3KuIx9pf+qyhaRv7Wgm81aa/ju0F7HzYf2stb3SG1s0fprVI/pDWTGOhLmGLl4t2mu6OKDMoz4DhdXxk61vUEfNFgRNQRKw23003lQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7543
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

On 4/19/2026 5:42 PM, Stephen Hemminger wrote:
> On Fri, 10 Apr 2026 14:13:06 +0100
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 
>> Use the common attr and action parsing infrastructure in flow director
>> filters (both tunnel and normal). As a result, some checks have become
>> more stringent, in particular group attribute is now explicitly rejected
>> instead of being ignored.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/ixgbe/ixgbe_flow.c | 292 ++++++++++++---------------
>>   1 file changed, 129 insertions(+), 163 deletions(-)
> ---------------------------------------------------------------------
> Patch 12/29: net/ixgbe: use common checks in FDIR filters
> ----------------------------------------------------------------------
> 
> Warning: ixgbe_fdir_actions_check() rejects DROP+MARK via the check:
> 
>    if (drop_action != NULL && action != NULL) {
>        return rte_flow_error_set(..., "Conflicting actions");
>    }
> 
> The old ixgbe_parse_fdir_act_attr() allowed DROP+MARK (set fdirflags
> and soft_id together). The new parse functions still contain code to
> handle DROP+MARK (setting rule->soft_id from aux_action), but it is
> now dead code because the check function rejects the combination
> before parsing.
> 
> If DROP+MARK was intentionally disallowed, the dead aux_action
> handling should be removed from ixgbe_parse_fdir_filter_normal() and
> ixgbe_parse_fdir_filter_tunnel(). If it should still be allowed, the
> check needs to permit a MARK alongside DROP.
> 
> Also, this block in ixgbe_fdir_actions_check() is dead code:
> 
>    if (drop_action == NULL && action != NULL &&
>        action->type == RTE_FLOW_ACTION_TYPE_DROP) {
>        drop_action = action;
>    }
> 
> DROP is in fwd_actions[], so a DROP as the second action is already
> rejected by the preceding "must not be a forwarding action" check.

It could've been argued that mark + drop isn't a meaningful combination, 
but I checked against the datasheet and you're right, this is not correct.

-- 
Thanks,
Anatoly
