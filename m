Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB33EEA810A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 12:52:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC525400D7;
	Tue, 10 Feb 2026 13:52:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D02F7400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:52:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770727936; x=1802263936;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=27O5a7XHWbSrWYKj+6K/UZPMn7X8Y8EwA5azYSFpLUQ=;
 b=G1vb/lcfDTOEzkXwEDYJCtd6pc7IrrYH0fVeskj8MxmqUcdez4MWUiHb
 wAKKZx6Cc7Yw54jvpUBzmONjBaOetz2Hds+rjiwVQZZDZVjCVQJpY/JzJ
 8HjnMwcwW6BfHWnw5gkVuiF0u1aSq4Pc7EFwiXT4n0gW4xwQ+rtkfEoif
 xsGG7jS+WUAVOHXZrKT/SwWHGBUJGES8nVga2UFvxwtLBW2HBopn/3uZr
 uzO0GcEPvhJx7EEwOBK/OQCfUJuMpWUBRyMHawsL01u3JHKwkeG0/uvCx
 T1e0SYMidiWPvUAUsX/vpVPQKEOnsR1eQyW3gDa1wfdV1Vj7RXujkiIB+ Q==;
X-CSE-ConnectionGUID: 0KKTyHQ6RC+j67GKCF/sbw==
X-CSE-MsgGUID: KcrWhr5KTcmXMAB6bEhIYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82958341"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="82958341"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:52:15 -0800
X-CSE-ConnectionGUID: qobsf8vETJe2bbrkCKNqVw==
X-CSE-MsgGUID: Q3ClK+12R3+giBFYIzzWTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216083215"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:52:15 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:52:14 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 04:52:14 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:52:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnvlSWAiJ0/XIyVR/DWK5VJ8tYtCPAw4mvUbmJLoTpfGZ0G8CXPkT+D4JYZQfvLngO+dKTRE1LTskcgzPOIWhE6f3mtF1ydMGe3SIblcZiHnjdVd2TyG/EDxXC+V0ps6HIw6qLa9laVb7bg/0ggFdT93B9vYb9wpAyPiZvX2Mxjf0TXFzJRP9OujoC8kPe9CMquaQMgxnoEPJCGehlbt/XaVYp+gg9tSq2U6rAFF23Cf0v6eslicbpfrFXkYed0jVt6R3v/ilSZgFHOncHqqMps4q8Z+2Y1gelgbIpQsBwmQE4+3EscG/cpkFKhWe78lO86IS85Tc86bR1v+2ySOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwpIY+4ZlMTiTUvj9ctu1rn24uuI73qjvI2LXnWCxNY=;
 b=Ao9s6wdnXYWxy88twXTM524P5ECN67bZM9l/FLuHN3Lm/jgRCLO14Nz4nGOXTybGwN9kb7oDk89JbRjitcu5tpHRtBVDoJaQxFpPBTh1FJQKPc4lQ9z0HArOkimda+ByxrTafFZEYrrkoGBaoiCrnrrKgeYTexDCCFu3BtiV4XukK5wKWeSnwY/WNqCVOfzV5IBM/boEJBdf7B4AD2Cw2OvxYU6NhwBD9Od7X0QYdkhNJYswdWDX4OOynNEffkSaFy04+QzU5tmA8ZpjishZN4IF1Cg3mKyVwlwABefSaR8EUCQD1IeE1kxG33ut2FYxGKuY5Peh8AOR4GQQK69qZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB7086.namprd11.prod.outlook.com (2603:10b6:806:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 12:52:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 12:52:05 +0000
Message-ID: <74012252-cf83-4d80-99d8-aad42366ac10@intel.com>
Date: Tue, 10 Feb 2026 13:52:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/35] net/idpf: refactor context descriptor handling
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Ciara Loftus <ciara.loftus@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-9-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-9-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0114.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::18) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2f2941-a8fa-425e-eb83-08de68a331ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3RRMWlVSGVvdU9DS1hmdDFra0ZLck02a3VneitpenpmR3kyREpkbElmdmxl?=
 =?utf-8?B?MWd3ZEdSd1pTN25vdExUbVlJTzEvSHlIWmNEaGpYVm9HMzR4ME4zaWc5bVRH?=
 =?utf-8?B?bEVybXZHRXhISEVTcVMydnlQZXRYUTVMLzcvZ1hmcjQrWjhJbURZbm1udnJr?=
 =?utf-8?B?N1NWM3V4Y1Z3cmVOUHlRQXp6YWN0OFBtcktMWVlrOWlDYm0zSzVBODBrM2JL?=
 =?utf-8?B?a1c3NkJ1bVI3dSt1TW1uUmNzeGxJNk9jUlNrUGNzUXgzMFVzSlAyZkVQTk1B?=
 =?utf-8?B?dktzL3VQd2hIV1lueS9FUjB2M3lidENjRmh3Y2JuQ0FGUjJKTDdJeEFlNk03?=
 =?utf-8?B?VVRrcmN5VVJBUCtaWnBEU1JpNDBHeHdWdTF5R0V3KzA3dXE3TlBBdW1yMWdk?=
 =?utf-8?B?YzBJTG12QnVBTGxHWk9xS3pRUXF3WkVRMXY0QUdmcHpVaVJqalZ3N1padVJT?=
 =?utf-8?B?QXpwcDhSMmZKbm9vRkJKSXIvVW91cHk5V0xRTnU1ZkxsVnZKc0szQTMzZWRT?=
 =?utf-8?B?bUxaZ2dvYklmbjJZZDdlRnZwbFhlMThUKytISHZVNFBjOHNNbHpCMVJQa3Nr?=
 =?utf-8?B?M1lGZGo3N215UktpdHhVc2ZJR0V3dlp3WjlsbUM3UitYUERJZE1SbVM2dDU1?=
 =?utf-8?B?bGVtemJBeDl3Zy9ac0FLWDJ3Rmo5WFFwMWd1YzE4eWhucW5hS203ak9xbnh6?=
 =?utf-8?B?aWJWVnhmVE9RSTlYREYyMnpJaXA0NnRMMVFidlJVUWNUbTMrSEZsMG0vKzUx?=
 =?utf-8?B?bnA0QnVGVks1MnREbnBUQVpCdng1WEpGeFQ5RlZkNFBlWlovVkFvd0Z1NkV6?=
 =?utf-8?B?TE9BbEh0ZE91SHpITUNPY3h4c3ZsZWYwZGR4UXEwMGJ0TTVKVU5iV210OVhq?=
 =?utf-8?B?emlTTGM4Q3MxMWVxWW1oSXg4TGF2bXJLV01PTFp2RWtjbCtJdzd5SXlDVERK?=
 =?utf-8?B?SFNQU2pGUEtkck1seW0wU0E4SzRXcmtNdzFmYmRwK2I2R3loaHBZdTIyeHl1?=
 =?utf-8?B?ekpnOFFRZzZuaXpNaTM2azlERWNmWER5MHZRbG9lUTJQNVZIQmt4c1l6ekhx?=
 =?utf-8?B?NjdzZEJrK2E5Q2JkT0toVFBaWHYvZjBQSkJ1Y3NkVjREaG5halpkWFNqWW9Z?=
 =?utf-8?B?QjIweS8zL3JkWUZzK1B1aHd1NFZZY0o5Q2JqcDJ5c2s1NDFVSHFhRWFzd1V5?=
 =?utf-8?B?MkhPcnJ1WWRwaXNJeHoxbU1OaGFRNEErelM4R1VoWmFFVmd6U3ZzQS8xaVJL?=
 =?utf-8?B?YXNtMmZPL0E0cDBVd0ViWHYxUFQ0eWQ0ay9zL2U5TUpsbnE0czg0VzlBbjVW?=
 =?utf-8?B?R1dYbDFpeExNNjhSYjVPQzJGbnpOUnhFU3hGaGhoMGV6cWkzQmE4QlU2SDQ0?=
 =?utf-8?B?ODFrYnVLVm5LSzlvSHFJM2hrZE84aUs1cCtQL1Vxci9GdzdteGsrTGpXU0lB?=
 =?utf-8?B?dG1pbEtpVU5XZnlhd1hEUkgwekRhOUtKTGU4NWpGTTJkMlRwelRzc0EvbCt0?=
 =?utf-8?B?ZThLYytmR3pTem9aWjNpSTdySisyVEkra3duendWbVBmV2hGandZVUg2UnNO?=
 =?utf-8?B?Z0RBTWRvRlJ1UE0xT2VxYmZnL3FBdlYwTVg0SEZubHV0TlY1QlI5bW13blcx?=
 =?utf-8?B?OCt2K1pnK0lqanVhcUpmMzFtMEpHZzEvNEdqbVVTdVlCNjZlZTdwQnR6SDVU?=
 =?utf-8?B?YisvWkR1MUZycHVkaVdFUm4vL0JVQWpVNktuWnhMNHpmb1BxOUdTZFl3Wmo1?=
 =?utf-8?B?THY5VnBUbjlHQTY2cFllOFBvS2tpMWNpdTA2QkdQQjhFTkgyRDVsMmpKYnlN?=
 =?utf-8?B?czliR0VtcGNMTU8rQ1lIeFBJcDdDcWVzTzQwalp1K3Y1VDZiUE13dEQ2R0o0?=
 =?utf-8?B?T2d2Zjk5Mk9WUkNtOW5IaCt3QlJTL2M4enV4MFIreHhtbVptbFdRa3AzbzFx?=
 =?utf-8?B?bmZiTXFJU2pNajZOYVRTZmJUaG53djZEdWF1RjIvYkswU2dMbElPV0U0UGJp?=
 =?utf-8?B?TlducHZQS2xvUUptdU5sY01Ra2tleEpjWkk2UURyb0RRZ2hmajZQZStDR09Q?=
 =?utf-8?B?UXo0emhscWJwU3hLeFlYV3JrRHdIbitqdXlKZEZKbjF5MWNrWVJneGtqZU54?=
 =?utf-8?Q?dYtA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFsYUw4Mk9nN2hLQjJEMVJqWlZPMTd1T1NVMitFbUNNRGx5NHZSTzlLa25n?=
 =?utf-8?B?QTBobTBtQ2hOSGpudWd2eTBLNlNCeExVQ21jRWlkb1hMMkF6dldrbUtKVkM0?=
 =?utf-8?B?Znl0UXdxRmxUcTdONXlBM2tNcGt1T3Vrc1FjU2RFdVVENDlYWGNOa1BhWkMv?=
 =?utf-8?B?ZUs5aHRkNlNyRWtXa080a1VTVWl1RlFUYmIxR1hCbWFmSWxtdSsxMXZlNmJL?=
 =?utf-8?B?S2lqMFBubm9DdTFScHJITCtWbWxVY1hTNG8vU3ZKV3NrbmFDcXR0K0ExWXc2?=
 =?utf-8?B?NTVOS0FpSnE4U3hpazZVWm54VUxLNW5IZkJpSGFJL1U2TWUxeXdYeS8ydXBD?=
 =?utf-8?B?dFJQUVdsTlAzTVRwRXYyZWQxY0VnL29icFcvSG1aKzc3ODhoUlpRUldjck04?=
 =?utf-8?B?RGtYeG0xRk1mNlVvbEREME9qNnJNMEg3Zk0vakNVRWRqQ3ZBV2VHVXdUbHdV?=
 =?utf-8?B?SWdzd3dTdW5EK2ZIYjNlZnBJTlhhQmZyek5uQWFlVldXOGROL1RJYlc5ZHRx?=
 =?utf-8?B?WHJBRzJHTW0zV2pxR041YUdGbmxlSnhUNm8wcXZCUlZiNGY0SERlSkwvWjBK?=
 =?utf-8?B?RlFPTzRTMVFLOHRCMExFQTkrTmNwZjg3WWsrRTZQUzcxb3E0ZmU0UkVBYS9o?=
 =?utf-8?B?SnFCZWVTRnRGUG5zUDNHWnZCVmptaVhJNHltZ2IwWFJWd3JtSm1jR3h1bXJD?=
 =?utf-8?B?N0NJQm5HMHVmc3VHOThQNXhHRjlhd3JkM2N3dFlCdm1FSWRUbFZwWXBHVmw2?=
 =?utf-8?B?bitGeFVvU2YwS1duVXFvZTVzYkllUGdKcGpGQXhOb0ZBZUhaajZ1Zi8zL2g3?=
 =?utf-8?B?VUFvZDBxVFgwbktpZXgzNHBVS2dDaVVpRW1uMXVFYTFZdEpwTFUrbjVOb2dk?=
 =?utf-8?B?VEZ6RUJ2dkg0T2F6Q1RtZGovOXR2N0VkdFZuOWN1ZFRUZXVZbnhvRSt5U3E0?=
 =?utf-8?B?ZnRnK2VpaHdydzRpdytQV25VSGQ3MHhObFV1UmZEUWZCOFRnaG9mZkxKWTh3?=
 =?utf-8?B?UzhEVC9iMVNaaElETTZsNUUyYmJqNDIyMENEN0JteEtROExEUE5hV1ZEb2sx?=
 =?utf-8?B?dHNEdnpOdUxpU1RnNGxFbXpzWGtHREhJSzRSS1U1SkdkdTBpc1h5OXdhZzhH?=
 =?utf-8?B?YlJPVnNlWm5zMlBmcGpKdFBLSDhwOTVoZE13VEJpcUpxTFJvTEdVakc1YmxY?=
 =?utf-8?B?S2svK3JSZ2NYK2VsQmttR09JTTJwMzZQLy9iV1NGaXR6TWdBeTE2LzI5UWI3?=
 =?utf-8?B?UjFDV0Q3ckJxYjJzYzZxa29adjZndE5LUG92dWs0TktjS0l1MmpYVUx6ZnpJ?=
 =?utf-8?B?b2JSa0pYTEIrSEVPK2dhdnAyWk5vMEtuOWVyVE02bnNKT3ZCZ1d3aldObzR2?=
 =?utf-8?B?QXlZR3Z0VDZvcHJVN1V6WHdEajZPcTBUSmdod3QveXgvbjN6RVFqTHhSY0ZN?=
 =?utf-8?B?SWt1SFZyRmJrSHRkQ2ZZRHZua1EySUxLdTFzSHk3aWtMTnVZend5VFFZQ2Zz?=
 =?utf-8?B?RkdmdzcyZmlnV0M0UTNrS013djNOdm1GOFllVlNhdldjUWNFeUM1UVh2T3I0?=
 =?utf-8?B?b1U3VVZkRDBsSWp2TThrb3FWK29PZ0E1V0c0SGl6enJ3Rm5VakN6ajU0ejQx?=
 =?utf-8?B?bkxRUVNhenVPakt2eXBFWU84TGFvczJWbGpFa0pGTkxqRTVPVk42ZTVyanRC?=
 =?utf-8?B?NWphTEM1QngwMWN4eGlDZlpsc085S2FQcXBuYmtOVm54ZENndENyVDNXeUVB?=
 =?utf-8?B?clAxZVk4cmNKTmx0a1JXRFU2dGZlRHZMUUNVYjRVOC9KRzJ1UW5pbVJMODhL?=
 =?utf-8?B?Z09WZVpWRk5qWlJENGJIYXVpbk9oUmJwTGMweHhETWV6Z2d3Q3l4TGk1NnJt?=
 =?utf-8?B?QlhUSmJhdlVPaVZLR2FPUjNRazVDZjcwUXM4dGZEckFtVkRzcFpJK293QWF4?=
 =?utf-8?B?bUJBMkNDYlAyQnNUV2N0NkR4U2xmSW40a3dsamU4MnZNWTNqUEpGdURIZmpJ?=
 =?utf-8?B?QjhiUUF5U1pyQ3FrUDdOWEpNaE9ZMTVDeFBQMlBCTi9XWjVjNmpFREZjRWZI?=
 =?utf-8?B?dm8wNXJUbW5vdXNwa0oxcFFaWmpNQ3FBMW9MeU9GaUJlVW1hSzRHR2RhTUVI?=
 =?utf-8?B?OFMrYS9rSUNhN2tJQzN3bUZzZ3hxdXBWQ1hLN0FSQW5lZ21nckw0bDdIQk8r?=
 =?utf-8?B?YWdTNUp4a3FHVTAxUnZRdG05WjBwbzJMRkg0Q0dwZWlaV1lPTUtvcERtOW16?=
 =?utf-8?B?SEhmRWx5U24yTXRRelBmN2VGN2NXa1hoZUZENUd2R3R5MnZ5dTdYZnJ4R0NB?=
 =?utf-8?B?THNwOUxHQ25Pby9YV2tpNFlzNXlhdngvb050c2FMME0ydUo3OUFVOFlWV2Nt?=
 =?utf-8?Q?hGuJpKZI5R78pZ7Y=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2f2941-a8fa-425e-eb83-08de68a331ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 12:52:05.8060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrJZWqovtdjtri4BrrTo+li3sQ7aS2fehYf+0orUszDVG48GDY5mKKf3b4lJy2zcbeBUEH+N3nReYJdsIdSyfdLqbpzFvoTgtOObA1MVSGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7086
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

On 2/9/2026 5:45 PM, Bruce Richardson wrote:
> Move all context descriptor handling to a single function, as with the
> ice and i40e drivers.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>   drivers/net/intel/idpf/idpf_common_rxtx.c | 61 +++++++++++------------
>   1 file changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index 11d6848430..9219ad9047 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -845,37 +845,36 @@ idpf_calc_context_desc(uint64_t flags)
>   	return 0;
>   }
>   
> -/* set TSO context descriptor
> +/* set TSO context descriptor, returns 0 if no context needed, 1 if context set
>    */
> -static inline void
> -idpf_set_splitq_tso_ctx(struct rte_mbuf *mbuf,
> +static inline uint16_t
> +idpf_set_tso_ctx(uint64_t ol_flags, struct rte_mbuf *mbuf,
>   			union ci_tx_offload tx_offload,
> -			volatile union idpf_flex_tx_ctx_desc *ctx_desc)
> +			uint64_t *qw0, uint64_t *qw1)
>   {
> -	uint16_t cmd_dtype;
> +	uint16_t cmd_dtype = IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX | IDPF_TX_FLEX_CTX_DESC_CMD_TSO;
> +	uint16_t tso_segsz = mbuf->tso_segsz;
>   	uint32_t tso_len;
>   	uint8_t hdr_len;
>   
> +	if (idpf_calc_context_desc(ol_flags) == 0)
> +		return 0;
> +
> +	/* TSO context descriptor setup */
>   	if (tx_offload.l4_len == 0) {
>   		TX_LOG(DEBUG, "L4 length set to 0");
> -		return;
> +		return 0;
>   	}
>   
> -	hdr_len = tx_offload.l2_len +
> -		tx_offload.l3_len +
> -		tx_offload.l4_len;
> -	cmd_dtype = IDPF_TX_DESC_DTYPE_FLEX_TSO_CTX |
> -		IDPF_TX_FLEX_CTX_DESC_CMD_TSO;
> +	hdr_len = tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len;
>   	tso_len = mbuf->pkt_len - hdr_len;
>   
> -	ctx_desc->tso.qw1.cmd_dtype = rte_cpu_to_le_16(cmd_dtype);
> -	ctx_desc->tso.qw0.hdr_len = hdr_len;
> -	ctx_desc->tso.qw0.mss_rt =
> -		rte_cpu_to_le_16((uint16_t)mbuf->tso_segsz &
> -				 IDPF_TXD_FLEX_CTX_MSS_RT_M);
> -	ctx_desc->tso.qw0.flex_tlen =
> -		rte_cpu_to_le_32(tso_len &
> -				 IDPF_TXD_FLEX_CTX_MSS_RT_M);
> +	*qw0 = rte_cpu_to_le_32(tso_len & IDPF_TXD_FLEX_CTX_MSS_RT_M) |
> +	       ((uint64_t)rte_cpu_to_le_16(tso_segsz & IDPF_TXD_FLEX_CTX_MSS_RT_M) << 32) |
> +	       ((uint64_t)hdr_len << 48);
> +	*qw1 = rte_cpu_to_le_16(cmd_dtype);
> +
> +	return 1;
>   }
>   
>   RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts)
> @@ -933,7 +932,8 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   		tx_offload.l4_len = tx_pkt->l4_len;
>   		tx_offload.tso_segsz = tx_pkt->tso_segsz;
>   		/* Calculate the number of context descriptors needed. */
> -		nb_ctx = idpf_calc_context_desc(ol_flags);
> +		uint64_t cd_qw0, cd_qw1;
> +		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, tx_offload, &cd_qw0, &cd_qw1);
>   
>   		/* Calculate the number of TX descriptors needed for
>   		 * each packet. For TSO packets, use ci_calc_pkt_desc as
> @@ -950,12 +950,10 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   
>   		/* context descriptor */
>   		if (nb_ctx != 0) {
> -			volatile union idpf_flex_tx_ctx_desc *ctx_desc =
> -				(volatile union idpf_flex_tx_ctx_desc *)&txr[tx_id];
> +			uint64_t *ctx_desc = RTE_CAST_PTR(uint64_t *, &txr[tx_id]);
>   
> -			if ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) != 0)
> -				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
> -							ctx_desc);
> +			ctx_desc[0] = cd_qw0;
> +			ctx_desc[1] = cd_qw1;
>   
>   			tx_id++;
>   			if (tx_id == txq->nb_tx_desc)
> @@ -1388,7 +1386,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   		tx_offload.l4_len = tx_pkt->l4_len;
>   		tx_offload.tso_segsz = tx_pkt->tso_segsz;
>   		/* Calculate the number of context descriptors needed. */
> -		nb_ctx = idpf_calc_context_desc(ol_flags);
> +		uint64_t cd_qw0, cd_qw1;
> +		nb_ctx = idpf_set_tso_ctx(ol_flags, tx_pkt, tx_offload, &cd_qw0, &cd_qw1);
>   
>   		/* The number of descriptors that must be allocated for
>   		 * a packet. For TSO packets, use ci_calc_pkt_desc as
> @@ -1431,9 +1430,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   
>   		if (nb_ctx != 0) {
>   			/* Setup TX context descriptor if required */
> -			volatile union idpf_flex_tx_ctx_desc *ctx_txd =
> -				(volatile union idpf_flex_tx_ctx_desc *)
> -				&txr[tx_id];
> +			uint64_t *ctx_txd = RTE_CAST_PTR(uint64_t *, &txr[tx_id]);
>   
>   			txn = &sw_ring[txe->next_id];
>   			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
> @@ -1442,10 +1439,8 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
>   				txe->mbuf = NULL;
>   			}
>   
> -			/* TSO enabled */
> -			if ((ol_flags & RTE_MBUF_F_TX_TCP_SEG) != 0)
> -				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
> -							ctx_txd);
> +			ctx_txd[0] = cd_qw0;
> +			ctx_txd[1] = cd_qw1;
>   
>   			txe->last_id = tx_last;
>   			tx_id = txe->next_id;

Yay type safety! :D Gotta love C

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
