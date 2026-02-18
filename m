Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B227EE9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:45:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFC3E402C5;
	Wed, 18 Feb 2026 11:45:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 64EDC402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771411513; x=1802947513;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ddJuzJK69iyNukC30gV5om12O6iKefR1pv8dFg8859M=;
 b=ItwqZWz5PZn+zmJyyuvYngUrvQE06CaQ5I10zw9lwcecPkBhkud4gG9a
 a4MEN9iuDqh5Oce7XxcCiXL9nO5KVf4zUqw/BkqCBo93DhVbf9RfN4KBq
 oVD8kIuh9ELFNoJmHN4ONIq5Z/FY33cWnCt3QYsgDw40FA1ju8tSFuNQg
 VM0uw8CU5dAtsSHZ1q2SlK4+UJMnUQ3ZT3FMK5Ed6RA+O1x6Q6HfjJDqr
 96WBZbdulyaj9rB/Rb0Ct0hqqTaiJWBo+jJmSu8/NDOT0zJ2oPDOpFyPg
 WD9g/QfMgSJhNiDd+0Dh+uvbKc6uH8EnkVCYhZhq6X8BvUL18brFBV8Iu A==;
X-CSE-ConnectionGUID: Zg3+owsdTmOPU6bbzl9ZNg==
X-CSE-MsgGUID: IwpQmMO0Rli/PXUBhnDAVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="97946964"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="97946964"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:45:12 -0800
X-CSE-ConnectionGUID: JCgW8V1/R4Shk/+Ng9xzrA==
X-CSE-MsgGUID: 7BPa6YqNQou3FANDM1hvZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; d="scan'208";a="213248121"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2026 02:45:12 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:45:11 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 18 Feb 2026 02:45:11 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 18 Feb 2026 02:45:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aliaitLqNmcuFuMI/06KwaDOOhgI7URRMd6rr2pY7ABqBTscrYG6RPhhGStJuhEBsXJipsguLikqjhq8T1+LITj6LOr6PVVdTcR/NUUjpkzsa0G02uvxyXF4FTcaDIln9MaI/pQG5caW9y2aETjVLV0HWCXZeo84AnXd2Tu3+f7QgDuUS6ePU5JYBdakUosxuJWyznLadNa7IiEbsqJaEuZ5DrRHxIr8EvNBeO1iqslJrRd35OM0AY6ByCdlyP2weaYKL+l7xTGd+bmsVhVy0kUQ0EuMp2Z4NXZg64LRi/KHXelsp1PfrCRPM0ClSSKbKCRpMC6Dxd7LYlmeq5ttrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EliDxUBQq4rQj7YLHkyUMzyRZtCbJZuSnFPsPojV0hQ=;
 b=Gw3FGEUjagEyUu52BV4e0l0LcjHXoEW1gPu/Ua7mPBLEIT4WTSA9dJLMBRd5PLiQuutOgYqcyImNHphlqISbxuyctKULfPjHPLZowHtR3co6Xsg+VmhcZz9I7Ri45mAs1G+5NN8z/lpRmacLcy4hqcvP4ApGHs+ny9Xr9WjJKkywXwZwSB9tJ79tJDTGL0pUyJfFamPewk5N+4EL2PBVTWVUXitHL+SiKIPcKMdHODxnpx1RcMBCHHfWeFWeMJYO/FVD1DkXDCDth+RTMiZa4/ogao6INN/OMapiH123cvAY5V9PjIphy7ZeKUyqxacVwxO3FtmKo24LGdFCUghsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.15; Wed, 18 Feb 2026 10:45:09 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:45:09 +0000
Message-ID: <3a9e9d97-b27a-4a41-976d-6ef892bcf6c6@intel.com>
Date: Wed, 18 Feb 2026 11:45:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/27] net/iavf: avoid rte malloc in RSS configuration
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <e69a82ff71fb3cf38056a3882c915c73cd84a7d3.1770978324.git.anatoly.burakov@intel.com>
 <aZNS2ZbtUvL1nYk1@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZNS2ZbtUvL1nYk1@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::25) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e72ad6-b140-4c69-e39a-08de6edac931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFUvaDZ6SHM1aFVyK005WXZseGllV0dyOThkSlJKV3k5bGQ1aGRNdXJSdHQ1?=
 =?utf-8?B?eGUvbUZwM1JtdURHMU9UVnlhNUtVZXV4dCs4NFoyNXFGL0hvUmlaUnVGdnZj?=
 =?utf-8?B?cFJZclBnMVp4YUJUKzhTSlNyMXAyN1puYnJaeThVYXo5R2k4dlBtWmNmWUFI?=
 =?utf-8?B?eE9KUUdDUVRJZ2JNd1lndlluSEhOTEZ5NVRkcFZITURsQkRDamZoVm9SbHV6?=
 =?utf-8?B?U3RhRHRrMjJidnMxWDRidmVkaFFOVE1hT1ZDKzFtQ0NuRDNkMWF2R1RkeSt5?=
 =?utf-8?B?M2ZmUW0xZ0hQbnlaM2VTQnlOU1YzMFVJWUNVNEhaak8zOVR2Tis3S0ZHZEla?=
 =?utf-8?B?ejBMd29zV0NZR1VOc1h1Y0EzTnhJMUZrMHN5VUdXYzdtNHJ4UDl6K3cvZmFq?=
 =?utf-8?B?dDUva1I0UG45Q1lqUnhwSTl4UlF3TnlYaGxNZHl0T1g3T2JHcHlMR1NReFVy?=
 =?utf-8?B?NC9tNkczZHhycHRGdTVKc3JCdFZiRkRhWHBJTXlpZXZ5eU9lZmFzZlBDdjVn?=
 =?utf-8?B?THlXK3I3OHBsazZrbFovSVRQcG96WnhlRGdTaVFNMndkTUdodTBtYjY1NUZS?=
 =?utf-8?B?RHRuN1lZbTJNNkFTUCtuY2dJK0ZTdmc5aVEyeVhqbVZlWFpkTjV2Vnkzc0hJ?=
 =?utf-8?B?anlPWUtNVnpNYXcwVnYveWgwZGhJTFBOU2pVN0RteDFuMGJDUVpYckd4bGoz?=
 =?utf-8?B?TTBkRkV1ai9hV2VBNVFNY3doenQrTkNidDZ5WW50V1VMNlhpM0ZGYWpJdTd2?=
 =?utf-8?B?Y0xEQ1owK2VoNytxNDNublhDOVRZajBpSnRRam1HOWVHSHRyaTRrSmtEVlda?=
 =?utf-8?B?UHo3REpHTDlaamM4YWxycFp3ekVYd3QwUHRQd2UwNjNwcFhaVlpvWU1qSzRk?=
 =?utf-8?B?WUVQM3FNbXIzdFhvZkkxY2tKVHFiUWNheUR0T09uc0VBRVZxRllaYTVidDhv?=
 =?utf-8?B?YytoVGU4TnJPdjNZT0llZEVrNVpzc2lycUpvNUg0WlhYcGNTK3NFZ0NqaWdB?=
 =?utf-8?B?VTVTc3RBcjcrNTBxN0JYQU5ReWZWWXJ2VXRqLzUvOTBFYTBxM3VsbTBhTUpQ?=
 =?utf-8?B?Yy9BUEVvNS9BaW5QdWdzQ2c3c3RyelpQb3hYM01acFVURFgwYkdjVUpDUzlz?=
 =?utf-8?B?UGtXakNZT3lmNXFNSHN2ZG1Ub2RETUtEWWsyZVpKUmRGTFBOY1ZnOFNwMERJ?=
 =?utf-8?B?Wk5hQ3FPdU10VG1BRUpIYmMwei9PdXhwOUk3VDNPWStoMDY0YlpScmVyd0VZ?=
 =?utf-8?B?ZFlDS0pYdnFjdVZOU2dGTmNOTkdXa0RyekJaZGtIWWdTb3hML3RPNFZkZUo4?=
 =?utf-8?B?VVlPYnZZVVhDaGovNGpadGVmYzhNQnMzZG1OWTFIMjhsYTRpZkJBR1FRVXBh?=
 =?utf-8?B?SVBwNUJ4ODBIK2pXQWdtV0hoYnBXWWJ4N3JyR09KdnR1T2VTRHMzb0x5LzE0?=
 =?utf-8?B?NUFXOW5VSjRoZkduZ2hKbUo1WW9jTkNHeHk3RnQ3RTQrV0VqendNUjhTTDd4?=
 =?utf-8?B?SkxST2FTRzgwUHFkRG9nYmdqTnRKSW9lSzAwWTBrOUtib0d4QStqd2dCb0ZB?=
 =?utf-8?B?NTNQVGxSN2dkdk5TcCtrNGt5SU1qbWxoY3ZFK3RKNFlXcmY3K1hZdkxwcGdx?=
 =?utf-8?B?eFQ3d3hMYlY0SlBNU3REeURSS2xBWndKTUtzU1cyMXlneGxGYTQydGo5R1M0?=
 =?utf-8?B?UElNeVNBemZKbngvL0dKcFRzL1d4SWlRb0dOVkRpNHNmZ0drUXJTc0ZlMlRU?=
 =?utf-8?B?T1VLRWNGV2trMEFrZnNoUHNFcDhRMFBLd1JCUkYxbzFqRDBTWG9ldzZQalN2?=
 =?utf-8?B?RGNPa2VxVmFHYmFVdE1tbDJuKzgwNG9EeWNwaW5xZkZIdkVoT2wvdHIrdFgr?=
 =?utf-8?B?SHpqTnJldzV6ekJ5eXMyTU5jeUpRYW04UXdVaVYrdy9qWFZ2ejQrUmNyRFRn?=
 =?utf-8?B?TkRJVysrcy8zcGhPeHJ4SklIMEVzSDJnRWxzR0dCM2pKaEQ2R0M0akgrOTJW?=
 =?utf-8?B?eVNZa0xOS2twaDBtcEo3Zy83cXdlNEN4S1lZdUt6NGs4bStxZ3liRkxHd3lW?=
 =?utf-8?B?enhNZm9UbnBJWGtDQnJNS3loUlQrN1JPR3k3cjd4b1p3UDhEOEpHS0cxUUlk?=
 =?utf-8?Q?OTPM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckU4ZTVlQVl5Tmw4QlYvUTdRNlQyZUNNbFJmZERXVjNVVWpjdGFtUmsrVzBv?=
 =?utf-8?B?a0htam8rL1M5cmZaQnQ5T3A2V1I4Vmlqb1hhSkZKZGFrNWZJd0xrZVpzNXVw?=
 =?utf-8?B?bTkyWC9ieGlycE5oNjVOUS9ZbndVV0Fybnp2V3NMNnU5YlNQWnNVcWZHTlFw?=
 =?utf-8?B?bHRGSWF2Z29FVVlsZyttZ1UvcUdnNk5TdEpMQkJiT2ttTUtEWGU5K1A2TDF1?=
 =?utf-8?B?VHM5dDlQQVdFcCtnemhOR0Npd3pLMER4UzN6cGtObUxQeFREOS9HVXFnTGN2?=
 =?utf-8?B?MTRyMzlUOTZVeVduZS8yYnFFSUYxUlBHSjJubStHOFZUWERYdzNxb254ZSt0?=
 =?utf-8?B?dk92MGh5Z2FSdFVpSmZ3bTk3M0ZiT0wyT2dTSjJBcDJPV0RvZzI5Q2hQN3VW?=
 =?utf-8?B?eEVJVjhUaVRtc2tWbUgwQ21YYnVXWkxuRlg2Uy9wQ21ycEp5R2tENUVPWi9W?=
 =?utf-8?B?WHJORlZFNXNsUDBYalQ0SU10U3RSZHptZ1dRdlJJVmJjeEhGMWg5dWtpdFhw?=
 =?utf-8?B?QklMZnVpWEU3K2sxNDliQzZJaG12cmNudEFERzgwL0Y4bFR0WlhZdzA5a05a?=
 =?utf-8?B?dTlEQkFkaE02bC9BdTZBUnUrTmEwWG1sTS9LS1pjNEp0bFhwVEFUOW5RYjdN?=
 =?utf-8?B?M2x1VmN1UU4wOXAvZE5xRlVPVGtHY3Nlc0Fwc0treW81QUVkTG14eVJPSHNw?=
 =?utf-8?B?aGlqNUVEd25LMHRzWnBBSFpGNTVZMXhOa0tSK3BHSHJRNU5VR29hcXFpdWJm?=
 =?utf-8?B?VENQUGxPSnZqdXR6RWFBVHdSY2pOL0s1SCthMlN6bWpreldOdjJlTGxENER0?=
 =?utf-8?B?SnRsS1dUOXJ4RlFQcERCNkdZOUJZbnJ2UG8xVWd2eG9ETHlzdUxDMXdGU3k5?=
 =?utf-8?B?SkZ1eXlsbTJTV3RHSG4ySU5HSG83UDlMWUFzN05JN0M1NHUwLzM0cUdHa3U2?=
 =?utf-8?B?NTB2WFptVVg1V2ZhWDJ0YzMvV2s5eDV1cWFnOVlwTWIrSHJpZnFPSlRvbGRs?=
 =?utf-8?B?T1NCOFhVS2ZiRXF4VDYyenhWWWxBODJJZ1h2cHFsUldZbXJjMTc0cGYrVWt3?=
 =?utf-8?B?ZTczZEhZV09LZ0ZUZ1MvQUp0eVpkWUwwZ2pIMmxRcFBIV1hhNmhIOW9GSSs2?=
 =?utf-8?B?aDJlNzRETTIzUU9EY25CVlY2NDlLY0ErZlRsNVdFWkFMMnFKTHJvQm5vaFRO?=
 =?utf-8?B?NWdCQ2RESHRqSW9Da0FGdkxGZDIxSWUyYWVSSk9keFE2Tk05bUtoZndoQThK?=
 =?utf-8?B?ZmVjRWdCODlTWS8wSWdRYlRubDV4YWNQWHJtSzg3eGdPeU85WUNDa3pjSExS?=
 =?utf-8?B?M3pYTVF3Ym94emgrT0xTdFl4bmREeFRXMHFCM3RlMW12UU9iQ2QxdjYxbmcx?=
 =?utf-8?B?Q1RPZC9BTnZzRk4xd01RN0NRcjNGRkcvSXhRcjc4TVppb0FpOEFDSzh1N0ZU?=
 =?utf-8?B?QzNDV3dYSVpzSUhlUldXaTg4TXRoMFhqUE1VZ2xHSzhnR29FcWRiU2tSa0FQ?=
 =?utf-8?B?TG0yUGFFN2lhSFRCZlNTbGJGOEc5QUFqTTNMdnRqMWZoTVdoakdZTzNObENp?=
 =?utf-8?B?L084c2I0MjRPTXgxN240bFMzNlZQMEptd3YyM0pTblNFWDBJcFdBWUMrSitx?=
 =?utf-8?B?K09HRFdveWJiZlVJQnlWWXExdG5CYy94a205dTNGd0pMZjVvZWRMZU14dzVB?=
 =?utf-8?B?bHFKalAxdHlScnhZMldNVG1ZZnIwZTVrZm1SUHc4TUNIbEN0bXVyYjB3c3Vv?=
 =?utf-8?B?Y1hkaE53RFhuMXFmdnVxbkdja2pKWVF4bWJqV0NhQXZOT0QzSDNoTzZJVGdE?=
 =?utf-8?B?Y25jQzVFOS9SVE0vYXlMbkF6RmpzdldXMzIyS0hzdnBVYnNXLzFPdEVzQWNL?=
 =?utf-8?B?UncydkxkNVJvV0UxNHBabXV2OFRRaXJLY1lmYnBtb2JUdTRYNzdtOElRc2Mw?=
 =?utf-8?B?ckJjaEJtd3JDWXF3RWx5TSs5N2N0MU9CWEZYb2s4UHhjd1c3RVhMYzd2KzIz?=
 =?utf-8?B?eEFGZ0o2bURrVW4yYm05cGcxaFBFemF2NXVqVC80T1dPVTZVemxwTURNbG9Y?=
 =?utf-8?B?ellPbmNwYkNHUU9XL0QwaDI1ekZramhJaURsYXRXdUVkWkFBTGhjZ1dVakx5?=
 =?utf-8?B?ajBmZERDVlRERGJTVFRPSzcvd0pEU2c2N3VjRFQxMGVETkdNc05remNaRVpm?=
 =?utf-8?B?UW8xTzdDbXVOK2dWL3Nucm1GQTlEZ0g0V3AyOEJXZDc4S24wUkk5UW9iRnRZ?=
 =?utf-8?B?NC9JYWZxZjFjNFI3YVZFeVZaRFZuVU9qZXZzcXZ4ZUJGTTlOanM2SnZ3cUdG?=
 =?utf-8?B?cHRBMWx0VEdDY3VIZ3dpNE1JT2tXNEJrUEtVU25BZlRQSzZDWEVpRHdEQWV2?=
 =?utf-8?Q?Z5KJR+kezNOWqLx8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e72ad6-b140-4c69-e39a-08de6edac931
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:45:09.2787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELAa9MPaGgUm6pvfGgHTLcbN0pSOyHKKHK6dge6Emc7BwYQuY8uhtnnPvCW7aJ2B1sbrGHUy86OM6xIqSGjMAq8NcGLqy4ccLIku8ieOwAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
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

On 2/16/2026 6:24 PM, Bruce Richardson wrote:
> On Fri, Feb 13, 2026 at 10:26:30AM +0000, Anatoly Burakov wrote:
>> Currently, when configuring RSS (redirection table, lookup table, and
>> hash key), we are using rte_zmalloc followed by an immediate rte_free.
>> This is not needed as this memory is not being stored anywhere, so
>> replace it with regular malloc/free.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/iavf/iavf_ethdev.c | 4 ++--
>>   drivers/net/intel/iavf/iavf_vchnl.c  | 8 ++++----
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
>> index 70eb7e7ec5..d3fa47fd5e 100644
>> --- a/drivers/net/intel/iavf/iavf_ethdev.c
>> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
>> @@ -1554,7 +1554,7 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
>>   		return -EINVAL;
>>   	}
>>   
>> -	lut = rte_zmalloc("rss_lut", reta_size, 0);
>> +	lut = calloc(1, reta_size);
> 
> As with i40e, can we make this (and the key allocation below) static based
> on max sizes supported?
> 

It depends. Technically, IAVF does not specify "max size", it is 
whatever PF reports. In practice, the biggest we're going to get (i.e. 
the biggest supported by i40e and ice) is 512, so we could hardcode that.

Similarly for RSS key, technically we don't know how big an RSS key we 
can support. In practice, both ice and i40e only support 52-byte keys, 
so we could hardcode that.

So, on the one hand, hardcoding this goes against every fiber of my 
being because "IAVF doesn't know", but on the other we *know* these 
values in practice. Which voice should I be listening to? :)

-- 
Thanks,
Anatoly
