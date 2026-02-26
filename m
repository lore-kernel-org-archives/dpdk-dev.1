Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434D3FC5926
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:52:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 669B3402EB;
	Thu, 26 Feb 2026 11:52:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C02974021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772103145; x=1803639145;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2uWcyH/gEAOsj12sVSsA72PUFK+/0DJe/a43ofRMoLQ=;
 b=dFKRWJxWiogwBY0UWnTWXWi0X+rsAnwRQC5fitw3NnraXMJbC4yELudg
 T7BBRUfkakhDrN5oN7JWdoFD+5Mtk1hrQu92PW1CULE+CEaLe2Vyc+RGZ
 nefce02OjkjMaXtqX4OF7pAgTgomoJEgrwveR0dibIzz2LifAeDt+STJB
 P7ayj/GAM37t45BXNRQrzcEoswY21cFoW2XkSPxyT7CEkrc/64WTmbS21
 UzmGNBPiHvFW6oJxW8v7xWWnqqw1PHIf33Qm4XVmVRLmfzFN0xkKjraiC
 ebbtHoByw+M1DkDqUMFT/ZbFC6s99MJSMcM1mjpDu2XKjC6+LQrpSFkDk A==;
X-CSE-ConnectionGUID: m0nMOqReQ4GqOP5HwbWqPg==
X-CSE-MsgGUID: vFaVCQCbRQaQMOC87kd6Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73203469"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73203469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 02:52:24 -0800
X-CSE-ConnectionGUID: oiSnvh/WSR65ltITuJ9wag==
X-CSE-MsgGUID: 2SyFPRpBSHyyZRfV4Suskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="221034457"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 02:52:24 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 02:52:23 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 02:52:23 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 02:52:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRDwEBhNj7UM3Ts7IMrgwTmW9mdcZXCxx9JiQ0OcVUUi0L3BPOYL42V927vnaXpSFjjC7QeqSQgmlq+bGLzOYonr1yiQ3ftdAQpUDmS4621GlQ7VBk239NfywpK2RiXqnsckG4medav8XvZnSoUrNT0Vla1eKEfe08xQjX6eLV0iPwkJrjmpc8W0ffTtKIwY+JUBAUB82FuAwEMiKupBOzbEDAb3DL56mNOdgm8XPeihW6kaF2oJfngQ+eBoT0r7CnFleoP5L1ghEdBEo9Wat8LDBgnqIEnyUQxwGAv2sIXywGmMVXholO3egE5NFZ1InQb4Vqm6C3sUDA7ltj+YYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjo29WOImbs8RGzL94o2D7DpRAOCyM0NUC06MOZgVlI=;
 b=u3qrRJJ1QAkqsrp1HLwM2S/tdmb69/n9HAgGhtoNhvx3g8QK01w+qLRDzNaXaQHfdal9OnDN8nHPpKy4KI2itDC36Iozml7xwUWqZnWDJ5NK00S2JxswGmTthdMn5FVcS1v4GdVEyqrVroR35OVGYIMfWb7WI822JIyKitzhJyhmseP5JP2v72aMV4bF6svLOrwQ+U1CymLwZOvCwodTCFGI45glREwYAVfmjeKr8az5heWCHZwaNMQX/q0FwzHjZb0Lphg7eFj6nWjkynr7Q5bKihXkzirCXIYNHlBbxn2taWQu3bhuf1A6UK7LE1HnQS9fTnJtB4S+zdPKaDAo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Thu, 26 Feb 2026 10:52:21 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 10:52:20 +0000
Message-ID: <399cd79c-a1c5-4699-b67e-8effe5cf73f8@intel.com>
Date: Thu, 26 Feb 2026 11:52:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net/iavf: remove global adminq response buffer
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
To: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <2a3001591642339ecf8f91584c83bf0766e0b66d.1772021348.git.anatoly.burakov@intel.com>
 <ef84dd9e25d0daad648a9b1ba63f8dadf203bdf5.1772102450.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <ef84dd9e25d0daad648a9b1ba63f8dadf203bdf5.1772102450.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0145.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::12) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|MW4PR11MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e974e86-c075-4887-b3d8-08de75251d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: jRL/vSnIepteyHZF1DtmYaZ4QfzmZLKrwNeCTnHooh8jQwXH0zoHPabD81sI0IsOQkVL5CQncGW0F9WkOciIU+ywG32hwIu1FQBW4gyJuQ+VdqPCwcmvN4MR4eM46J6iKYCUag8ac+/CMwWgd8HwFm5v1l2+TXWYEFNbxbKS9HbRe/y/Ydrhq0flozweEdJWy/u+mPmUJz8at9TN6sx3yiojS4PY25t7JrhJSsEfBRgy+dmTYjmI0MNwnvPkjbvMm7Lm1iarhBN07rd380KOIZ+V1VvvYgFdSG89IIBp8HyDd5YLGfr82seSX2nuIfC44CU/o900DeoW9wVMHs899Io75HNuXHpkSmtuwqPKUcI3HS42/u0pYBgOlHcV3bXUONlyZoX9IcW39/f3nKz4Z2fgWGPdmUIDQ6XjpxqsmCCdaiGq+6XUXOoD2JxybwOu7peTaO47UbPB0hCEtchk/ZZis11P4ENzD5a/pM67tmqeqoDb2/AQtpCP9+qlrK2lIVATJqG3OlBrMo8XfP5IE+8dbWi96B6AWUiA9obqzBa+BA2f9pkDcZ/hAcNlVVA0sTwp0PQaLg3dw9C+XhGNt/CaGm4jhwA5la54WXGa77a/Ma2cjR04Qd9F0ODbOZsZBKy99Sl/dCUaTyz/k8RA3ThC0V6WWRl/bMHIQ9Z/JK4WN6AhPhNfYKq+M1tFUl5ma9rvOBla+by6mm6H8lmfOfWAk2TElG973a2hO1RyOYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhsNVRMVkk1OGR4dXd6WlBDSXR5SnlpbmFGL3ZkNzgrLzBTdTlITkNIUjVz?=
 =?utf-8?B?blFnUDFTd1pRcjJBMUxUdkNMdHV6Uk5LNzNXcDhFdjZpdGdjTjRqSzV3Y2p1?=
 =?utf-8?B?ZmZRUGY0anFCMUNNQmtVMEZ1Yjh5QkhqRk1nS1ZqUVVHdWVRR0I5SnpuOVhl?=
 =?utf-8?B?dlBqaHAxWkNTTENoOStkVUJERlQ4T3FMTnhGcU9MUCtRem5CQ2k3TUJEMmpl?=
 =?utf-8?B?aHM1aUVNY2lXakw0V0dCMlQ5d3laVm96ZkVGeWJzSVZGNEFnRzI0NjVaUFVW?=
 =?utf-8?B?U0lkV0NYN0g1STRHQXFnelRzbVFReEZBVlRuYTFSUEVSTDd5R01wT2lMS0Vl?=
 =?utf-8?B?T0dDTUliWERTQVgzcWFIWTk0Vkp3LzJXRUc3cnFXcVRGVkVJZVo4RFdsdE1E?=
 =?utf-8?B?YTVNSG9pazdWNlVKYWVwMGJ6dTRObUYralhQUkp0Sk5MN2FQWjhId3RGOW1i?=
 =?utf-8?B?M2xEZExaRllheGhGZFVFS0ptWXpOYi9SbTkxS1NHdm5Lc2tFVHBGd1hZdUx2?=
 =?utf-8?B?WUVud3l0WUVNWHFxQTl6QkFqN3J0RlVHejByV0ZFWnkrcFhtR0pRY1NicHZJ?=
 =?utf-8?B?QmRrdjVlTzhkenJZUm44cnEweHQvNHZBZUcvVG9ra1VrRlVXYy9OR1cvVGZ1?=
 =?utf-8?B?TDcxTDVYMjRBRXF6L2N5QjJVU0FBZXBJeWJ2MXRnRXJUNTZQUkFFNkJqRUx5?=
 =?utf-8?B?ZXFTQ2NCSmZwTHVqL1lpS0g4QTJjbEVmTmVVTXNCMlBXa2hvUFV3TnRyZ0pC?=
 =?utf-8?B?SzVnWGhzeHR1WGtLWGhIaDJVL1VGTWtjdUQvbjV5TVR2UlNXVldRL0gxbzFj?=
 =?utf-8?B?QWMwVDM0VnlMT3liUnZBVGpKdVBlNmxyTnpYV2E2TUg5VTlWS0IwYndHb1VO?=
 =?utf-8?B?anU2ZWJBSEVJcE9ieTFUS05YRVdFRzFMQ3VtOTM5WDYrVFFrcGpXMlNOdDE2?=
 =?utf-8?B?N253dGVLM3JKZmt0QmNXUTZpZEFNTzR4WTN0eHE3VEFodkVrS25IaEpzVEo1?=
 =?utf-8?B?NndmeHZMcU1WWnBlVnZ0RUFzRkNmTCtKbE9hcVdRc2gyOW0xbFlEdFRqaWtY?=
 =?utf-8?B?L3AzQkt1RmozNGNaUjNvU25YNTVYSGp3Z0VHd0NKdGIvWXU2enc4UHhUMTlq?=
 =?utf-8?B?RzVpclVoM0R6U2pZa1hHU3RRamZOTDg0bnN5UE9nVVB6WFQrSEt3MVFtUGdJ?=
 =?utf-8?B?NEJnRzV4b2RVeng3Nk5FeGhIdDZNL0RqVFlLaVZoWDJqMVBpRk5hSk42YlFw?=
 =?utf-8?B?ejBrRFhjWGhkSWI0Z2tvUDRYTEYwYzc0bHVuRXRQeGZ5LzVJUXpYajlETWlK?=
 =?utf-8?B?dFgxWFVDUUtFUnE4TTNibkhPNkZCc2RuTGRmQkRINjN2M0ZRaXVtU1FFTjM3?=
 =?utf-8?B?S1d5QVV0SkZLLzMrQ2R1RVE5Nit2MXFabm5LMU9COUFhY2FOOURpc1A0dThu?=
 =?utf-8?B?SzF1STFET2pKSnlqNmdUZ2ZSWWk2THV5TlRtUmJ5aEE3VnA0bkgvU0p0RU5h?=
 =?utf-8?B?c2kvTUE0WnpYcTB5TWhQb3hkcURXemZYSHJkNEZKT3l0dDZNdWF2eFJYek5l?=
 =?utf-8?B?MFUrcG0xcERBRkhlZU1GODNHZE1WWnFQbUZQU2JUSllZdTZPbzFMdzFLWUdK?=
 =?utf-8?B?c2NWVVZ4UVVabitZQWJLTnV3ZG1JM0crQUsyWHp6NXYvRGliNS9HWXpSd3lF?=
 =?utf-8?B?TmMxeHVnVDVJck4xUEZtdS9YWjZjc3VNOUo3d3hsM1dRNDV2aDVWWkc4MHNM?=
 =?utf-8?B?STZaZFkwM1l5M3JZdHpPUDFHeVVSZU9YNXZNTDdNUXF0bEZhV3NQRElUemxu?=
 =?utf-8?B?OG0wN3dKdzFnb0xIZ0U2WWRGeGNESDJzUWZRb0J0Skg2ZmJmTGxJV042a2Ni?=
 =?utf-8?B?OG9nUGRyNXBhd2Z3bEhRQXByajc1eGZ5Zm9jTHZoNXJHcU5ZNU40NVR6RElZ?=
 =?utf-8?B?ajh5eG1yMk5VazdsSWh1TkVxQWc2WUY0c243M0FvTG5JZG9uOHh5empjb2hi?=
 =?utf-8?B?b1grQ1hHaC9MK2haV0Ntb0pUSm41eEkzQXNOSDU0ZjJRMWdsellsdHkxOFZq?=
 =?utf-8?B?S3dHc093bEpWcEhnQ1hxVDdPVncreUNhd1RoM1YxcVQ5d0RjUHh4YmZTL1N5?=
 =?utf-8?B?QjVhNUV4VzlhV1NaM2lsZUJwMlhSUmVLNENmOFhlMEV3aG5QekJmUC9LcURG?=
 =?utf-8?B?YkV3amE2Z2c0Mzg4RWdIdHphdysrUWNqSDJJdEZJOWtHUk9ic1h0WE9CTG5n?=
 =?utf-8?B?Q2dMZEZUZzdiUUM0MkUyTmxpWExBMkNrTmNpbnlQKzVML05ZcnJiaHcwU1dF?=
 =?utf-8?B?T1RYcVN6bjZBSzQraURlei82WEpnemkzQ3lQcUVkRWs1enhnRlJzaTdkRnlM?=
 =?utf-8?Q?wunJ0wvesT6v/r+o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e974e86-c075-4887-b3d8-08de75251d0e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:20.8108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mV7dRzihATk09NfpAnhQ2FXXxi//uclsV55qAdCI9LLmfiZmQeZr8OL7wXu/2pRPEN9YnadQSVwVP+pfGGcvzDa4wm00oWVba2TOObWfvUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7164
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

On 2/26/2026 11:41 AM, Anatoly Burakov wrote:
> In many places where we are calling down into virtchnl, we are using a
> globally allocated adminq response buffer. This is unnecessary, so replace
> with adminq buffers allocated on stack.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Changes from v1:

Stats query was passing in a pointer-to-pointer and storing pointer to 
global adminq response buffer as output parameter, so changing that to a 
local buffer resulted in storing a pointer to a buffer that was stack 
allocated (i.e. introduced a use-after-free).

I've changed that to allocate the stats structure on the stack and write 
into that, instead of returning a pointer to output buffer and reading 
from it.

-- 
Thanks,
Anatoly
