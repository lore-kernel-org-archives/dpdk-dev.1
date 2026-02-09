Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD36AE94623
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:19:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 962FA40677;
	Tue, 10 Feb 2026 00:19:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5BFAE40689
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770679184; x=1802215184;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UoxJdGRaKaEcZHNY05h7nRi6XNThd0fz65ep5NWZptc=;
 b=XYK0nLyPdR1yBTWdipJdmEcUSj/FoYKy3JgeC8H0nnZ7iKtRum/7l1G4
 dKKcDDn0W24VhHqOwrUuCWaU3hRpl+D5BWNJ9gDAy4udcQ18lyZt4cOug
 SxEzh1qqlqi8aO6Zl7znvPVgx6FQoDOPhfsFcBp+bukjkQykRgyEJUdsf
 QPJSpFAOhteykHoo/mcbEBXxA4UbXhY9bfEPpc7cm267hHCi3owkTiMyj
 3QS02eEYTrZvRZDvjvH/xHfBwfp1stqvobXpEKnJ/2hrtljmae0HHyLKc
 7vFeslpMv7O8CQOCOTRxhEbCqtB49tjmUd97YTWz/ls1GlGlczjMFVs4r A==;
X-CSE-ConnectionGUID: 0TPy5+IuTmGDZv7rHPxtQg==
X-CSE-MsgGUID: pMlsFF6RSvOhOlM8ewNWUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71786958"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71786958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:42 -0800
X-CSE-ConnectionGUID: UxhO7ckmQaePvD1oPndCBQ==
X-CSE-MsgGUID: rY91MG1CRZCzNSBB77Hquw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211420350"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:41 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:19:41 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csfYji6JnIzhz7NkquKqWTi9leWTsFeFTCFZ4jo718JUScrbkf9BQTrXq4TOQ9hSMUCaBSOrzEVttPRCLYsPPHylOxnv2Aa90QWywdk5Emsio12y7OINTXSznkrOZw8kVr5v7Ci9EHB1KfOs/CCsvjGNrSkZD2PY9m6mv7ZA0pxv7bj1ltscniO2LeSwc4xmyvIKeZZumJ4RZaQ9w+G0m14vfG1z/YhFa48l419blRQeMEUUt7Q7/KZ+1o4WpKJ2pn0jAAQT2atEtE4nZceZoVhPZJRwET72ybE42C3HIwplmFx9gjZa1eWB8nunel9boHOkI4JWl3/6MzsD30ak2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihM9VjF0oxqAzKHqa/nNCU0m1VRHsFODdivsilcddqg=;
 b=yWOier3CXUTuzzYVEDBoBmHZnTsR2EeGok2hgf39/3UQ9d+xJOudha/A8yItCnBt+RlESTbU8wL1CHnJk+pNXAy5IPHh6huWS/7LwrUZQ2D2x0z75Gr0x1VXFQebv5ucXKBrsDvPgbMDv0unf6CdCetg+8Y/7ZtNr66yktyvfzwfOUUAq+F3QDcypq6i9ph0TMHE0mYvbOvfypwIwMsyu4iiDz7EoJrOZq6VJ+sEFknkZUPbpY+aP9Rj3p3+MJCwx6lPZN5pd1OTOWXGUjN89oIdG+D58rjc4y2wKE/vkbV8LkSZukuLqFOHSdTyAgU37peiLc7GQRsOD0uGZKPy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:19:39 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Mon, 9 Feb 2026
 23:19:39 +0000
Message-ID: <6dc65757-91c8-46ba-8542-63d12cb82469@intel.com>
Date: Mon, 9 Feb 2026 23:19:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 34/35] net/intel: use vector mbuf cleanup from simple
 scalar path
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-35-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260209164538.1428499-35-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0442.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::15) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f047e7-eece-4bd1-bd60-08de6831b2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnVqYkx5SkRINTFLVHczWHR6VDZMMTNuUEQ4b1dObVF1K1pHeDg4TDViRXhY?=
 =?utf-8?B?ZWl0YmRVUXB3U0dURzNiWkVwN0NWazhsUlY3dVA1bEtielJQU0xyOVExWUVp?=
 =?utf-8?B?anVveHZzQnMrQjU3SkZwQWN0NDlQTGFDVWk3blE3RStoK0RnbVNJelBLbS85?=
 =?utf-8?B?eWR5d2xDWS84a1hFeWxsSlE0MnZFR05zNlZ2dHBSZUNKaWVrWThMZWhaYmE3?=
 =?utf-8?B?OC9rdU1DVmVGb05Ybkp3OHFJVTZ2elBMa1RPTlU2R2lZUFgxTE1DTlBxZlcz?=
 =?utf-8?B?Nk8rd1ZvVGNFU2tyRW10NXJZaExzU285NWJjam1FRkFReUYxQnE5WXV5WHNS?=
 =?utf-8?B?VHFGcHNpa25FKzhidWdoZ0FiRUcrdlhLNXNnME5NV1o1WUpwa09kcTBCU1pT?=
 =?utf-8?B?RGZUMjl5NGYxdWRTQ3FIWU5kZFpvTG9WakdHZG9Ld2JBUjVkbTQ5R2hIK3Ry?=
 =?utf-8?B?d09ZRDhMbC9lMjZUVU1LSktxWWY1cGxnSncrcjlMNXQrYnpFZTNzSStRYlVw?=
 =?utf-8?B?YmZWOWNFSHExWG5LWUlldWoxUHZyNVFqa0VIamROOXVGRDVhUDQvU3pUK0Yy?=
 =?utf-8?B?bDRzMk1wK2NVUW1BR2dkeW94K29KUHRtY3ZUeWtFbkc4bnFnaU5kQXR4ZkNj?=
 =?utf-8?B?UkpzN2R5Rkc2VkFMS3pZOERuNHp6bVlkaVY3dG02eXZ6eFNuYjJwWmsyb204?=
 =?utf-8?B?SWJHSUo3TnM2S1NmVUFlYUZlaUVxZWdlR3JCdkNtTERodHJoLytUdm43VXZZ?=
 =?utf-8?B?dVh3ZVdTbVlzSjhZbXRCQ3hUZEpVeUo1c3lNVG9kamE5QWhrb1hPMVVWb2tV?=
 =?utf-8?B?elg5S0c0REpLR1NmSk5waVpyb0tEQUxPeU9RNFZyUFZnY2RNYnZsbll5NWE2?=
 =?utf-8?B?aWJLZHVtWUJIVStqdjF2bWUyWlVweUF3VUQ3eVJDcnF6K0ZaczZBNkRBdEFH?=
 =?utf-8?B?dkpsMFBLamFSOUxiRVJqdzlpRVkxRmNPSmVodDl2UEVxRlV6eFA1VE5yM1Ru?=
 =?utf-8?B?czM1Vmt3aStHSVhGYzZUVWZTSlhZS2owUWRpZFhVTDcyTHUrRTRaNHJMWTFN?=
 =?utf-8?B?SW5VRWJLUWQzdkEydlkvS0RXNGVWR0pBenRzbVFvQXE1OGdyREFuWk80SGFO?=
 =?utf-8?B?T3lJbXlsMDZjNkE4K201SFFhV0VUODZMclpMdnZDOHRxbC9nTDNGT25neTY2?=
 =?utf-8?B?K0twK1pobUw1dy9xQmJkVFRlbC84T3IreHdvSjNaSzdYU3JhdWNCckkvby9P?=
 =?utf-8?B?a0FydWdoMmRCbWtyMXYzaHdJMkZOeC95ZSswVVE0WE9VVWVzNFo0OEZHYTM0?=
 =?utf-8?B?cDR6NTVYaHMvRTBXTndNOGFISzJMYXc2TG9Nc2dkNWJybEtIa0lhdGlVMTdk?=
 =?utf-8?B?NHcxOElJS0U4SWV2a1B2Slh1eG1QVUJhSUpvREZMcnBBN0pnRVBWSkVZMUhv?=
 =?utf-8?B?bXU3VlZIOXhnMXZ5WjVpajJUVG5xQmFOWDI5R1lzQ2pXaS9tYWRMbHJaeDlC?=
 =?utf-8?B?M3pkZUIvTzczS29LSCtiSGtvdlpqK05CekhVdjdNbFd3S2tKTHJ0S3N2STFh?=
 =?utf-8?B?VGduQzNEdVM4SlhKK3RQWHhaWUZhSU1POTkzS0tsOHIzS2JOTGFqQ0JUN3h2?=
 =?utf-8?B?b2FFQ1ZFVmplckNicWFnVWhuK2NLVThMSzlmSzZJUE03c0NadE5NMkVFTVo0?=
 =?utf-8?B?cUlQVlZkdW05MmxlT3lsTDBCZ1NEVWNwZjMvekFSNXMxTWp4a1lXN2w5V0Yz?=
 =?utf-8?B?bTNCQ3FIcjkvQU1UUWJ6ZTR0ZmgzM0x3MDBlWW9iVUxGNVl4L00vczNGQ3Y3?=
 =?utf-8?B?NzNZT0ZjcnFERmFOZnNDNDBuU04xVll1VkNQUisvOURVMEduNmlkVDlFQVFS?=
 =?utf-8?B?SEZ0S1dWanp0SUNoWThQLzlWVkVZWW04ZGJydEo4ckFqMzNKL3Y4Y09XNkJG?=
 =?utf-8?B?U3kwTFhnQVFJRG40Rnh4clExV29IRmtPNjN3QTdsa3pCVXBQTVFRZlRpSGhQ?=
 =?utf-8?B?aEJmbUVQb1RiQkVBOGRkb2w1dHFVak1yZGV0Y3EyVndMZzl2QSs5L0lYTEZx?=
 =?utf-8?B?M3V2QUxaK05QWGF2THVGVDRwZm9NcXpUblhUdmhraUY0RmV5djBoSWlCS0RZ?=
 =?utf-8?Q?S3bk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V29MTVNuRXc4QWZUUU5pVEJrcml3dHRaTXBncG1yY0pudTVlc2VhMHFibW9i?=
 =?utf-8?B?THEwc2FTT3p2K3dTY2tTSk8vWE9pRzFTWDBFQWhJUEpob0lyd3B5MWNIQmww?=
 =?utf-8?B?QlR1MGM3UkRuZ3dsQUNGYnNkRGhtT0NnV2pGVFgrN3ZQMXU5OG5Sc01YcStK?=
 =?utf-8?B?eXFXeWVzSTBaN0krU2txNjA4MlpjZHdIVm12Y0RtY3lQYXdkelNiVWxGVFNm?=
 =?utf-8?B?TUZCZXpvSGpZTjlvU2Q5dytvN3ZkcXBiRVN0MXIrSm5lL2ltMnp2QlRSdVVh?=
 =?utf-8?B?cytnTjk0ZjY3YkdoNThkTmdJVlVLdEtMNnU4ZkoxSXg4ZWhHK0E4SUNHcGh2?=
 =?utf-8?B?OGovRU40aEhUZGFtU3gzdmJnYnVUR1FMUmxMTkcvbVZFM2lmVjE3MlpCS2d6?=
 =?utf-8?B?RFRLUHdXQ21SUG9pQkRzMnp2NUVxQjlsa2VFS25BSzNLZE9BeFYxUGl0WFFB?=
 =?utf-8?B?dnhBQ1VHVWJZNk9oVVlrWUh2OTlMUjJBSzIzcjlCdWRFNEpSR3ArZmZXL2ho?=
 =?utf-8?B?cHU2dEZZTXJ2amZEaTZUa2ZiTU56U0trc1Noc1BhbjVHcUZ4SlBUNDRxTDAw?=
 =?utf-8?B?ZlJSa1QxNVJ6TUVseXhHSTUxMjFzWUF3ZFM5OXl6Sm0rYnlwMmFtT2owelQz?=
 =?utf-8?B?bmEveFprUEtTK0dxMm1VbldFTE9WaXFrOUxsL2c5ZUdncHVYUnNlbFROTDNz?=
 =?utf-8?B?am04cFJvQStGK1ZpMmpzSXhnZlNVU2tsVE44RC9rQ25rNDhyT1RPTzNEQm4z?=
 =?utf-8?B?YTZOZWxBNnpMOHI2NmtCQUh0T0d0K24zdndySkZlanRiTVpXWW5TeTVUUUgw?=
 =?utf-8?B?Z3JIdmtEVHdiSDQ2S1gxaUNVZ3ZZa0NiRGl2L0U2d3ZmVkg3dk9HVlo5ZDlv?=
 =?utf-8?B?QVhWQU9lTFhBRjZkcTM3c055Y3d0UVFzdW1wa1dWTmRjVUw1QjJVRmRHYXJC?=
 =?utf-8?B?OWpFTmRVQU5FWHdadFpycU90TmZPejhkNWxvRkNRU3ExY2ZxWU9FT0tRVDQx?=
 =?utf-8?B?MXY1YjRNdnU0Q3hVWkJEQnRpaU9HY1J3bkZoRlIrQzVuMzVVRWhYRWtaZ3RL?=
 =?utf-8?B?UlZ3bXJldTNFUTZncC9GSUZmVjNQWWh1YnpCTlY2ZkQwZFBlbUZHZUs4RkFs?=
 =?utf-8?B?TE5rUks3UXZJd0ZaYXVQclRyMXFaTGcwNGg5dWVUUStSR3laYmEzUVd0cm1Y?=
 =?utf-8?B?ZU9Kc3R0NUZZRnJHeTRuZXQ4YlU0aUo4TkRDU05QVFcyUTJzRnJBRG9Sb0Jq?=
 =?utf-8?B?d3NIQXpKbm1MNlJzRnpuY0dzUjJ0NVN3dzV6VDVMTEpjek03QVB0YWlhd2hw?=
 =?utf-8?B?VUtyazZYUDhKaVVrRGp3clBKdVBpQXVUaVZaZ0RtZkJ2clQ2d3lYNlg1Vzg3?=
 =?utf-8?B?ZTJ0VnQyKzlrbXNRQ0NUK1pzMERRdnQ3YWhYUW1BTzVvTG1oRFZpQ1gzcWo1?=
 =?utf-8?B?ZWZlQmRZZXFJS240dmZtWkVxSEF0dGE2Sm9Vb0pmc1NwaDBidzhhSnRFWm5X?=
 =?utf-8?B?TjRUTUM0aUptSXg5MlhZSnlOeXdPT2k0NUNwZ1B3TUd4Y0loaUQwbFNZNU9m?=
 =?utf-8?B?Y1dLOS8rZkN5dDlYdnJKK01sUFU1TVRMYUFQNTFoSXRZaGZQWGpycXNPSkZm?=
 =?utf-8?B?MVVaMVpzNmZ3SkJUdFR4d01GQm1IaUMyYzV4QVhyTUVmQ1I4eHR3WVZraG15?=
 =?utf-8?B?SElYWW92TFFuU3UycUZka25aM3dtY0FUekp5VnJHRTJYUHJ4WEF6NnZKRHgz?=
 =?utf-8?B?LzFkaE40VUxjSjl4UTUvWXpFYWRGNy85UnNweFo4eWRvL2FnWjhTTDhTMnh1?=
 =?utf-8?B?dks3TlBFd3hBeDBLa3JRUVBoOFFmWTZhdDJJZnRTUzhrbTRrLzVGdkxtdHI3?=
 =?utf-8?B?VWRTbkpZd1RJaHNsVU1hYm82WVJZWFMxMDJmRnhrMFppYXJYaXhHU2NSR29R?=
 =?utf-8?B?a2xyR1dXdlNjL2RiZlpTZWdITVU4aS96QVRzZmtCWmNoZHJtd04zK3dwSjVn?=
 =?utf-8?B?NnI3UXErM0JVZUFPcTVyMzM4Q0dUL0MwU0k2OEZGYml4TFFiKzh2cDRsY0Za?=
 =?utf-8?B?L3h1Q2ZuVXJ4KzIxMXlYYVAyalQySkRyRUtHNEw2OE9rUWZ4NVIyWkNjaTVX?=
 =?utf-8?B?dk5IdXJuZUo3RTJpMXdYNHRoSmtLWk96bXVkT2FtZkt0ODQ3WXBuZTdwdzNa?=
 =?utf-8?B?c2wydHl0T2YyZWZmL2d6RERQS29ucVNyY2xZa0E1ZlVHRWtPbUJIOXQzU3N1?=
 =?utf-8?B?emxxNDlKR0NkUTBKOTYxamtLTjh3bEZpMC83Sm50cVhxUm5QMk92d1pyQmx0?=
 =?utf-8?B?ZG1YL2JuUUoyYldGczdBMlE3K2twbWQrTEI2d0w1M3c1OEtnWVhXN3Bxclls?=
 =?utf-8?Q?bijRywjlcNKMJ8Rk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f047e7-eece-4bd1-bd60-08de6831b2d1
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:19:39.7499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4nXHsS2dyF2+hi8d4SRtMOQaO/LIBy+0f7aoXl2T5Ywh62hL+XRTAzErNM3x58I790NUz4fnwihkZpR7RUe1yMwOw/ptK673Ma9cg+UAQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/9/2026 4:45 PM, Bruce Richardson wrote:
> Since the simple scalar path now uses the vector Tx entry struct, we can
> leverage the vector mbuf cleanup function from that path and avoid
> having a separate cleanup function for it.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx_scalar.h | 74 ++++++----------------------
>   drivers/net/intel/i40e/i40e_rxtx.c   |  2 +-
>   drivers/net/intel/ice/ice_rxtx.c     |  2 +-
>   3 files changed, 17 insertions(+), 61 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

