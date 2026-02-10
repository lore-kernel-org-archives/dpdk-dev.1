Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2B8EA8121
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:19:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6F73400D7;
	Tue, 10 Feb 2026 15:19:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 86D61400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:19:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770733175; x=1802269175;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FAzgedqqFAOq9pEdMmMtLIKW8k51i3rvX5wtofo0FzU=;
 b=KCIgla+8+cNXkMn4Q+s/rKWp9CghM5MdAAjyxrF87SBQ3RQ5xYFnCsdb
 oDZE98GbpImY0YJf9WP3qx6/spqGoUFdnN9s2Yq7q1kpdpCLWBVia0Lcn
 VhtRhTte2iGETeRpYQbN8TwLsMiZilhc5V91ouDHdtD5uomp4+aQrH9fE
 7xFGM5LIstsyVIzJvk5SCOLmpNuOH8ZBpSJqKR5nKor1JOFgOIywVgi62
 VBqI57kwHJLQ378NPo++QgnRv5lZeWT7lti3/kWc44lF5AlMxptbLnGEO
 Omko1Gl4WrQdMVsMy8kDXbtmjaGxMpI3uAtbFU2cBZmKFS9IciYkrRzxr w==;
X-CSE-ConnectionGUID: d4q87dXPQuatx8xYS36gSA==
X-CSE-MsgGUID: 8JuTg99sRmmRf9djDoS0ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71964814"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71964814"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:19:34 -0800
X-CSE-ConnectionGUID: kYGpJgpISkW/cNlg+t+v2A==
X-CSE-MsgGUID: Uk7M0G5zRzGpkdWJydvGPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216887101"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:19:34 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:19:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:19:34 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:19:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkXGwFZHBNs6am5xG6VxQzq4SqblQR1I2+dKXN/tZ4Zt2wM9FY8LtJ25Y68FnBdpRmSOaf/c/urB2+LK8NcuCt910DoThLomRr6HYsundU+ksMbEhk1bBiidRr0Ku6jSM1mOEIg+z9cFEfqu4MzPfJ08HE1Z1mT8tfndogmGp7tiYBzu76+fE0Js/pSv8zWgXo0MnZwAIWk3RbSZ3FdGCA59lxM/xNWLdxty31CzlHBzgTmBZKDavIG7eKo6i9DQfSyTBGF+qSM91bSL++1acJDwncJ00K8qZiWuDTmx/hmBlFutJ+aCiAaIr9ai/b/NDnVT5XIvHnPGPBAdTPrsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y/VTyIdEk6M1vnm1dBY1hsXLU8kJt/4RVtrJmXITcg=;
 b=mr8sggOirYZBECDgoUxlPX9Z1MJVDzVRNp703Wf2kXEVbbQ+6qcZvuVPYN2wDIXaJc+hgQ5PkClEGfSguEwm+IoveKS8aV1jMaNQ5Qbj9PiLi1m31oFGXYd/fLj5jTc/ih2LU71wVfC0TRtrCWHrbr6U1p+w43MhMlzivIoC2f7FCo8gFnBMJpTe7YpJj42IzcKUwm3Y5vyDHJ72ZrtCKTJhcGY8+I+nfSXlYaonlS8bF6naGXR3ywphsbPe6C05YH9sfcDL98CNHwuX7KWTmEHd4m6apFlSQAXvxucVyLw8NdvnBrr/aEOFLy7N/gf4mUQghBvNHugE9wW3hU2Sag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS7PR11MB8783.namprd11.prod.outlook.com (2603:10b6:8:254::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Tue, 10 Feb 2026 14:19:32 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:19:32 +0000
Message-ID: <648f5f1b-a19b-43b6-963d-3add913e1f93@intel.com>
Date: Tue, 10 Feb 2026 15:19:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/35] net/i40e: refactor context descriptor handling
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-8-bruce.richardson@intel.com>
 <abad013f-0a13-490e-9443-0441233684c0@intel.com>
 <aYs8WvDxV84HohAu@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aYs8WvDxV84HohAu@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0123.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::8) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS7PR11MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d194f41-930b-4710-2132-08de68af68ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVpGMlV1QXdQVzV5WnlPcVczcjZOTUVqSzRmcTM3RWZTYzl3a1ZPWVpLUlZZ?=
 =?utf-8?B?bVV0M29ScFpsZE5MK21HK3owaW5JenBpcmhMR3RJUHJGWlhtNUxpUjZ2TzBC?=
 =?utf-8?B?Y0Q5SFBlYnBPcHJvYnZUcEpud0xYMVQ3V09rd0ZjT2NEbllTNHgraTZEU2E1?=
 =?utf-8?B?c2FjS1cza29SQXBLR2pjOXVDYmVkenErVmszK0pWNEVrR1BtU3ZYazgreFNa?=
 =?utf-8?B?RDh3cnd3ZGRIeWRvUWxsWVJuN0gxRllhSjJTSDVIUTZBTDBEUENtcVNCWHVM?=
 =?utf-8?B?aDJVOUIrayt4SzZaZEE5TjZrNzg2ckJhcFE4NldNM1k4dE00ZUg5SUM2Vkh4?=
 =?utf-8?B?UGZkdWFheW9rYjVPbDJCUDVidHdadEJmbnA0VE5rQVl2YUcyMG5nMnBObjcv?=
 =?utf-8?B?RVB3UXpPZ3NuZHhTZTMwL0phVWFRemY5KzNvMndsQ3ExRDc2SEpBMHMwQXNy?=
 =?utf-8?B?K0Jsby9ZSkZ2M0tSNnhrRlBXaFNzOUYyU3N0eVdhUG1wR2kyTnhyU0x4NGs0?=
 =?utf-8?B?RVBPcHlCejRFMm5YZ2FmTThhc3JNZlF2WkVrMTBtMkZyKzNqTmhZMzE3Q21N?=
 =?utf-8?B?WmFRQ0tvbVcvSXc0SkR0R2hUTUVYRVdkVXpHMTJKMnBvZVFVYnpQWnZhUGp0?=
 =?utf-8?B?NWtFRXRFMmk2UHN2d0lQZVJvZVRxT0wyZHF0YStHZlFQcFdxZlJYd21ZQUFV?=
 =?utf-8?B?K2Zjdld4MCtnMVB2ME5yWFViLzNsb2EzemVYcTB6STh3cTZ2Sjgvd2hkY1pF?=
 =?utf-8?B?eVpJT2NvN01DVldRUlZpaS9QYndEa3kyVkpkU2RKN1NjbE02dGRWY3d6YURt?=
 =?utf-8?B?bXhuamhYVVZvYm9rRnpuTHpjYnB1eHE5NTRibUoxREM3QmwvcFdOczRPSytB?=
 =?utf-8?B?UlI5ZG9CWHpOUi9XVmlBak44RjhpdWxuNXFTN3ZJTWJjbjdHM0VNUWx0Yktx?=
 =?utf-8?B?Ykw4cDB3MzFIMkh0SW9aNnhzOS9rbldnbCtSZEhtMUk2b1FQQ0c4MlNqRktO?=
 =?utf-8?B?QkJVRloxSXp2NnkzZHo4dkI5RkZQS1pLa0F0TjdrZXZYV1U0ZHdLdTJzeCt5?=
 =?utf-8?B?eDB6L0xJSlNVNGp5Ums1MHlVcnBzM2N1VnVqWVBONWNuL3JxVzJMcTlpVFBs?=
 =?utf-8?B?RU9wSGJsYjI1VnNZVll5TWxLZDczaGR3Zldjbk91c0dZUVg0N2g5UXZqc3Ns?=
 =?utf-8?B?dFcrRUF4dWZVVnpqL2lLWnRTK3BMN1E5a2VRTEgzd0FJbWtuaDJDalhsbW9a?=
 =?utf-8?B?SVRVZ0IwdWF1RlNydTN1T2prL1dJV01kT1Z6RGVlWTZac1FSRzNvQWV6dys4?=
 =?utf-8?B?aStUYkxhMWNRVnBsRlRyNFRFekRzRDFMZGkzWHR2UlRObEk5WWcyQkxLdzRQ?=
 =?utf-8?B?Y3ZoQjcvbHEvdTlZdjU3bTMzcmhidHE0ejdpaUZEQzdjTnJ6NUozcjJVR0dq?=
 =?utf-8?B?SGlFazU3WUN4WktnYU96N0hNUFJJdEVweVZCY3RqMXY0ZkZCcVlOWE8xdWxq?=
 =?utf-8?B?dG9acW53MEdkT29ySEpQdHRDd2xxaEt6VG9WMjdKNjVlY1YwVlY2RHp6b1V3?=
 =?utf-8?B?bzNuMjhlSDdHZDFyajh6blBmTi91UjVjdUR2TVkwZ3kzbEpnTWxFWXMxaFF6?=
 =?utf-8?B?eDlEM0RVWGRDY3YzTTZaWlBmMXJqeldLTUJ4V0dndmFoNG16eUJMUW44SEZK?=
 =?utf-8?B?MHN5dksvNmlhWmpxbWMxNW83RVAxMVRqYVBRbkdiRnJ6ajlqVzRlS2k2UDN2?=
 =?utf-8?B?TjhvN3pYZlpIVUxtQ241SFpMdWw5aDJFWVBRU1JQUUZ4aHpVU1Uwd0VPWWRY?=
 =?utf-8?B?TVcvRnFOQjdDUE02TWNtaTNkem9VUWU4dWl0aGtadFNGdGRGdjZKdmtrMzVx?=
 =?utf-8?B?YTV5ZURVQ2FmcDFpa1ZZU2xhSkJlRkVsLzhGWVRTU1RqZC9RUDVzdnB2Q1E2?=
 =?utf-8?B?VXNJeERna1VsSG5WbWZsOEZ6Z2syQ2N1ck5aazRWMHAvM1lxbVpkYjdlSERl?=
 =?utf-8?B?STR4citON2Q0dlNqcjZ1VmNSOWxscCtINllOSEtnSVlUNW1iNmZPcmI0T2xi?=
 =?utf-8?B?c3U0TktCNUJvTlFaMk41UU5uTHQrZUF2SlNCOExHL2tQWEtHY3hmMzloaGE1?=
 =?utf-8?Q?5ucw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1Y5MVd3Q1VpRU8vOXZOMVplMGpUOVZzRnlwY0xmcllLb0gxbzAvR0p3eGt0?=
 =?utf-8?B?T3ZUaFNlNDB1YU9GTkFWN0J1VXZHRHFlemtrczhDcnJwTEo5THFXcGpkcTZv?=
 =?utf-8?B?ckhUb0laN2IxZ2ZLWDRFRXpLNHVVY2RzNXNwc3p5ZGUzYzRqNUcrd1lIMjJm?=
 =?utf-8?B?azNTcGtIcnhDTzdiWmhzeFVXMXBnUEdBV0MrOUFaQjNhWXdMTEp5YVVkWUFV?=
 =?utf-8?B?Z3Q2c3U0cWpVVU5Bc1R0eGNrcjg0RlpkdEI0WGpWa3VKTFUzTlVDajJ2a0Vk?=
 =?utf-8?B?S0wxYUdYZE1hTHYyeDVaRkovTWtaaG1GYUhnWUxSSTQrYitlRGFKb2dCWXFC?=
 =?utf-8?B?VWpHYXMvcjZMVHgySHRnN05JQXJ1eW81MzJ0KzBWVWtqZ0pCMmI3ZUlyNXVa?=
 =?utf-8?B?K083aTNQZjVVRWRnUENzcUZCam1Dbzc0OFNiZ2pscjFjOTZVWDl3bE5kNE02?=
 =?utf-8?B?S1owOGRxMFhIWGVtZ1Z2bU1jeVVyRUx4RURxYUpwekJNNFNBUzRoSkdMYUkx?=
 =?utf-8?B?UjNQUmF2UjIvOTFVVE9IbkdSWmEwd3praEk4dmlXRWdieGpGWjFYOWRiUjgv?=
 =?utf-8?B?eFk1RllSMVBvdmx0dlhqaUNzdkgxU0dISGtUYUh3d3F5UHJuTklvRGg4MmZ1?=
 =?utf-8?B?RGtPL29ia3k5emdIQ2RiYUtUUXptUmpzVHB6RVlhVWRuTWFVMEdzQ25vOXp5?=
 =?utf-8?B?bHFJU0g1MW56bkdqM1h6dlRKSzRtamliSzlnRFBKRUw1UWlsQmNENU5ES1pa?=
 =?utf-8?B?K0NtUFNFakdpeWZZY09IYmZ4d21nRjRGWnMxVVdrVlViOGJDZ1U5djVobkRs?=
 =?utf-8?B?MXNVN09nMW40TTQ5NWtsNnl2T1g2QUg0Tk5LU3RSLzBLdUpSWlhrQjNVQkRu?=
 =?utf-8?B?UjBObXhzUTRUNVc5SGkvZEUvNXc3WElSdllpa1h3a282Q3lkL1dXT1NYLzJH?=
 =?utf-8?B?azVNSVg4R1pzanl4R0puMllZWVA2bjR6aHNCU2dwb2dqYmQ1OU1UbWthNHNs?=
 =?utf-8?B?OHExcDZGSHhpK3JBejF2RzdRRkpuc3lVeWV6bCs5c0xsWTNGWmFvTHhBS0Q2?=
 =?utf-8?B?NVJYME9WbDBTOEZkd2tpUjVsSlJHRXZhVEFDRmZwc3ZNVU5kdmZsa2pKS01W?=
 =?utf-8?B?V3ZxUUNmVTFJYzBFdXR0d2tsWmhTSExaYUxZL0ViVStoSStNUGd2UkpBTFpQ?=
 =?utf-8?B?SUNWZDI2SVR6c2lQZ040YTd6WEIzODNrU3RZcUZUaVZhTjhudjRBNXI4d1Rm?=
 =?utf-8?B?Q1dzWUVrYWhkLzZXbFltYWNyRG4vYzJNNmtLdjc5YWZraW5mL3pGU0NZWkJ4?=
 =?utf-8?B?eDFwKzRNeEprL3ZnSWNmNHJ3TzNvU1ZvSzRxS0ZZSzBDcDRuWWI0MDBvWVRW?=
 =?utf-8?B?WSt3eEFKYWk3ckFKdXoxMFY0NEpLc2NzeUZtWDJuUkhzd1NKWG9hbE5CMG1q?=
 =?utf-8?B?QVA5R090S2pGOHN6Um9XcU5SMm5SS2ttd3IvUFYzWkt2cUJ1cVFITk5zR3pm?=
 =?utf-8?B?MHdxZVRKaUZ1YlNva05LdnhyTVFjTW5RRi9veWlSVWE3c0c3bzl3elVnTmRG?=
 =?utf-8?B?Z3BJZ0FRM1hTYSsxeVBBa0hnOUJRNThyb2N1VklIREFBbEttL2V3ZzNDSkI3?=
 =?utf-8?B?dCtZZjVyVmt0SXlLN0Fqbkk5UURVQXlWM1V1WXhncFFvS0poeEVsTW9wei9Z?=
 =?utf-8?B?NUVTYmorOFNjd2NzeS9sT3hYV0FCUk1VWFNudW0rOUhna3hHSm9oWHhUd3A1?=
 =?utf-8?B?TEZ5M2IxdDJoS3ZNK0kxUmt6WmRYNlNibjRjT0ljbGdvMDY0eFZYOE51M1hV?=
 =?utf-8?B?YjZjOTVzc0JvVnZpanp1YkNuZ1dlNTN1TnRFbHZCUTlNQVlydWpjRU1RdVh5?=
 =?utf-8?B?U3ljWDN4M1IwM1FPY2NGUUdkeE0xb3R6Z2JrZFFBb0l0ZU42dmJvLzQ1QTRG?=
 =?utf-8?B?MkE2c0oxS092S2taaFNBbTVDY0xGRGZ0MDEzU2tCRUxjS09yZU5xcGRySVFY?=
 =?utf-8?B?cVBFTUtydjdQaU1HQi90dkdTVXNGY1ZIWWZvQmVpcTRKZzFjZTNkYmtKM1NF?=
 =?utf-8?B?WFlzOC80UXV1c3YwdHJjamVPTzRpeDRncStLNmsrUTQ4SElCaGFJVDdTWUxs?=
 =?utf-8?B?L3dHYkRvNlJQcEZycVhQRkRkNE9mb1I5SUNxdUdkZE94R1VSbWptTDlSMGhD?=
 =?utf-8?B?aHJSYnVHZ01Mem5SQzkwbkdPY2FhQ2tVUHdFcWZDR1lrS0dSK1BlSHdKODhS?=
 =?utf-8?B?VXFiY29LNkxRQnJEUnhTUExCN1hzV2dvakhjS3czcmtBcUxNcUk3UWxJU1Bl?=
 =?utf-8?B?K3NDZVRlLzJWNVFqWEE1V1c5WnNWQXJQSnpzTThTcmduLytuZndQWFZKZkxn?=
 =?utf-8?Q?7hbyIYEBOxezD2XA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d194f41-930b-4710-2132-08de68af68ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:19:31.9842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i60ZqjTsOw/DSkXYVJ1pGB6xwmWBX80D7Vue2BGzrQWqHBlu2E/a8ssBEjqrgtBzz8RLZeZxG+0tKE/ZJEwQciFWswXv6o59DJNLqeyVzOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8783
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

On 2/10/2026 3:10 PM, Bruce Richardson wrote:
> On Tue, Feb 10, 2026 at 01:48:20PM +0100, Burakov, Anatoly wrote:
>> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
>>> Move all context descriptor handling to a single function, as with the
>>> ice driver, and use the same function signature as that driver.
>>>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>> ---
>>
>> <snip>
>>
>>> +static __rte_always_inline uint16_t
>>> +get_context_desc(uint64_t ol_flags, const struct rte_mbuf *tx_pkt,
>>> +		 const union ci_tx_offload *tx_offload,
>>> +		 const struct ci_tx_queue *txq __rte_unused,
>>> +		 uint64_t *qw0, uint64_t *qw1)
>>> +{
>>> +	uint16_t cd_l2tag2 = 0;
>>> +	uint64_t cd_type_cmd_tso_mss = I40E_TX_DESC_DTYPE_CONTEXT;
>>> +	uint32_t cd_tunneling_params = 0;
>>> +
>>> +	if (i40e_calc_context_desc(ol_flags) == 0)
>>> +		return 0;
>>> +
>>> +	if (ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
>>> +		i40e_parse_tunneling_params(ol_flags, *tx_offload, &cd_tunneling_params);
>>> +
>>> +	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
>>> +		cd_type_cmd_tso_mss |= i40e_set_tso_ctx(ol_flags, tx_pkt, *tx_offload);
>>> +	} else {
>>> +#ifdef RTE_LIBRTE_IEEE1588
>>> +		if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
>>> +			cd_type_cmd_tso_mss |=
>>> +				((uint64_t)I40E_TX_CTX_DESC_TSYN << I40E_TXD_CTX_QW1_CMD_SHIFT);
>>> +#endif
>>
>> I couldn't find any places where we define this, it appears to be some sort
>> of legacy define, making this basically dead code?
>>
> 
> It is legacy, and does need to be fixed, but across all of DPDK I think.
> Testpmd, for example, has IEEE1588 ifdefs also.
> 
> However, for this patch, it's probably harmless enough to remove the ifdef
> here and always allow this code path to execute.
> 
> /Bruce

Sure, but I would've preferred this to be a separate patch as it's 
semantically different from what you're doing here. Perhaps it can be 
fixed as one of the early patches in the series as "preparatory work" 
for this one.

-- 
Thanks,
Anatoly
