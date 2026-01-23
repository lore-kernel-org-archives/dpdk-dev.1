Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6369CD72379
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 11:28:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E4144026F;
	Fri, 23 Jan 2026 12:28:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 3EA9340269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 12:28:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769167706; x=1800703706;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vN27/0Eh5NxurhpmLNrO0A2OvHIq66Zp/O0VjoAd/5A=;
 b=B7o5oJxp3H5Y+dwwBuVmBTHoqWlpp5fx8R7cCNLBzEORiUZG1H4BJ7fN
 P8JPwXTtq4j6NPm/FK1vR1GYkUEvvN5knAcBzEX7kkEouFRlgO9IJqR2A
 m+4DXdpvXCy6gLlGmNP8jKeM1M4K/NFEOYSq71JvFNeOpHgUn6xBi0fdN
 CdKbDWE8C35vTikH/tNHMEqJdSCIWD+wycvZGM9G2V9jmeVlIBOI/w4nP
 jWAi9ex9oGosujZM7qbcFVyEvz8FNPhqoqBPWdda5KT4O2Pjo4h9fuxVT
 zKMTZSjMFj17UHtWvDjuoBf5ALLUcjd53k9lPkvyPqzsF+xoeZwWSQUIa A==;
X-CSE-ConnectionGUID: NnGNexnzT8yOp6lnlRyZYA==
X-CSE-MsgGUID: mQ0E88HKTsiyFxfoOs8BtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81050083"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="81050083"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 03:28:25 -0800
X-CSE-ConnectionGUID: 1rkyN8inT/mZl2QeUFDxow==
X-CSE-MsgGUID: vME/ykOlRVS/6L+d3nyGjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="207346131"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 03:28:25 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 03:28:24 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 03:28:24 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.22)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 03:28:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsAhBJT/+Rw4zn6reQCe4u/jbwG6ZuYsMXAMKtXAzGTu6v7RfhtyydYAAasIOZxIwdFS3XayNNYxsVCZi/h3JAoZczQUnBayIwoYIY5JPCu8xhZE7Jx8F0iIXxB3jLx5XgifY8Tc3SSiTbjnElGfbOITnGKSwYZedTD0PlfGq6qULafOvCGfSOevDQh3La4b4SN+BrPrDGIll5zY3GgGqNtlJA9oA/cIdJQvnLpuc8eaY8ftdXmajBXacIKmA33KUI6FniAqKsmLWAVsgzNzO798JJMPiGR9H5znzP5IeZqjJDq7WbPenO5rthOyqEy1EYzwTQAjrfaFj6q8lZJ6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdOHyzBOKANVukUCwIdNl6ZXEp+Va1QKOluCqkLQQ7g=;
 b=Eze4uwRgJ0jkjA8Y3FvnEQRVg2i3VxkRjls9QdMnXO72Onbk6MBQIC94icYzlNbZY/HDPC+smBXC55HCXTEFRkMkX1cTaQnFrlqws9nOAEXyOaG3GQ9O9MrqBcOUA3R1GXwMPiOMi5cGGgqx6+mJGeHIJ/zHYZQtApYnWt2Fnq9Ahw3YRRZe85b9YLdDA+ZZc7438qkv4dE/5D1oR8HfzGSHESl+ZGjAftMBPZfgr4eHRo+bVah8+TF7IBTg6ZoDOdFXxqdIhe+4iWL8DYqgaoWS9++VWzfe4EEbMJO5+S0+yRiNg7PRi8+2vCfOb/6lZGAfkPLQcKV9UIswf3RFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA1PR11MB6944.namprd11.prod.outlook.com (2603:10b6:806:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 11:28:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 11:28:21 +0000
Date: Fri, 23 Jan 2026 11:28:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 0/3] improve debug output for EAL flags unit tests
Message-ID: <aXNbTxYoSnzCrklu@bricha3-mobl1.ger.corp.intel.com>
References: <20260120112552.921243-1-bruce.richardson@intel.com>
 <CAJFAV8waN3mZeSd=KX7C_N-DR_SpnR3afo=UwcOUeZy1+bP5hQ@mail.gmail.com>
 <CAJFAV8woYXc-UC6UZYjpYZRSV5_mruXZfxYUBhXui2TcLSNLiw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8woYXc-UC6UZYjpYZRSV5_mruXZfxYUBhXui2TcLSNLiw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA1PR11MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fd6a36-b3db-410b-b3c3-08de5a728373
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkN6eDVyWFk3Z1BXMW1FQmlXUXZPMml0bGZPQkgwdE53SXY5Q0Y2Yzc1N0Mw?=
 =?utf-8?B?K05IUS9SVTNCa0VqZGRpMzNUelBhNzFscmhjVGZhSnczckowNVluR0YwVCtk?=
 =?utf-8?B?N3FHRVhGQ0Y0bzVFY2xjV1l2bVV4NlZERzVGL2JISjYwQVNKNnNzdGhYdWZW?=
 =?utf-8?B?ZGZZaW9QRHdGajJRVVozMjNuTWNWU0o0TGVDeUpZMVc2NEwxanFrWkdvVitK?=
 =?utf-8?B?cmhUWEVwNVhzYXFVck5JZGEzUG1WdWNKN0tFQ2RFUWV0aHVsOXRnVGVjem1m?=
 =?utf-8?B?S0tybVJLNjNaeW0zbUM0QlZKMkhabUJVUndBQ0sxT25vOTNLeDMvWldpc1Uz?=
 =?utf-8?B?ZjdqWUprRWdXMFFHUjh1aHBQb1hGTEhwcy9oRzhwcXdjMkRtMHUxSENNSlln?=
 =?utf-8?B?Z0ZPT1JRTXUxR1B1ZzBvOGtINjFzMUhwYVZyeEVKSktuSUE1TzZKRFFQNzRR?=
 =?utf-8?B?UlUxaTJGRzBHOEpRaHphY21zaGRYUjROY0RrNGtnaytYSHN0TEEweHZhY0ho?=
 =?utf-8?B?b1ZSeHBRSlgxajBwWjhlLzhCQ0tFcUk5TGVNRFV1S0cyUUwvS0crVVlWMjJq?=
 =?utf-8?B?ZE8yL0VOUisya3BDQ1NZeFJRNDZzT3loWng3UVlwNENTMWdEeDcrMGVNVzdF?=
 =?utf-8?B?TzluVU1ibWRCODRHOHJMNzRrMDZWcktPSzBsdmdIOGV6TzlGTVZ5YkxQY2t4?=
 =?utf-8?B?a2JXWFByUGJwUklmWi9rT0dSdzdLTm5idTZJMXZyRlVJYmVwN2E3SWlZNzhs?=
 =?utf-8?B?N1NlNzRWTVU3VGRZZHRwOXQxVFlQbUgxVVVydmt5VzlEbFV4N1ZWUHpIVytw?=
 =?utf-8?B?QkVTTFRiNWRTTkEzMEh0NmlRTFVGVTNPSDNzRjMzY0JFSm9jdzl1dDdCaWRp?=
 =?utf-8?B?U3UxeWxndlhQbVN6T3lQcm5jVGZ0NmMzVmh4SGQwOTVqZWxnQnZFUXBIQU5o?=
 =?utf-8?B?bGNjTUhONG9TYkxyVFJ6RENSTTlxTGRaR3J6bkRxTXdGMCtnejJneDRQQlN2?=
 =?utf-8?B?OW9lN2NNdTZGc1hkaVoweUJ5MHRqL2gwVEI5cGVOUzdDNlc2eHgzNXduS2x6?=
 =?utf-8?B?L3VxZ2J1T2NyVHFNTGZHZlp0a1dCVEp0ZEduMjZ3aEpFTE9Ga3lMWXQrUUhR?=
 =?utf-8?B?dDVWdmJ4R3FLNEYrZ2dETCtEZER0azNFUGRyajlOQW1NTTNvVXVoVVFNeHpt?=
 =?utf-8?B?TEZzdzJEUlBBcEdrQVZvSTNjajVFY04zMG01OCs4dTN6Nk94cVRSK3JmaUZH?=
 =?utf-8?B?VXhMRUx3eS9aN1RCSUJITE0wRU5HZmZ6b09BcjB2MFFFbkh5OHRMaXAvTGJu?=
 =?utf-8?B?MFVBL2h6dWcwUk1xczNsb2xiT3JycGRqZ0tMem9DYkkyNWtuZGdtMGFTN0lI?=
 =?utf-8?B?dXlrS01EWmkzdWlzRTRxVjZmY1BLUmZoYWdxeWdoZ2JVaGdmTzExK09mVnBX?=
 =?utf-8?B?WmFHQU5HZnBIRHNoTVpmcXg2NDhheDlMaEduN3pDdXFlTHZNUHdUTnV0enJP?=
 =?utf-8?B?UW5PRDhCMXd1Z1IzeGNxTkNJVXRPa0F5MWI4ZndUbXZKVHdxcTJiSjllQ2g4?=
 =?utf-8?B?ejBWNndFbHB0TDZIMHU5b1E4WVJLQ2hzYjExdEhJSW1CY21BN0lPK3BvOC80?=
 =?utf-8?B?RlZkemMyUmdxa05HaU9DcVlYMzVvQmdyVDRjeEQ4S05LcGpHbXRtSUFtd1I0?=
 =?utf-8?B?YnJ6NGx6dU1tM3FLaUd6YzdpbkRsUXBsYjdwVS91M0NTbHd5ekRMVE4yaWNF?=
 =?utf-8?B?ZDh2bE1DS2oycHBSdEMxOEErMlpxRkR0d25YSjV1eHI1c0g1bTVDSVc2SnR4?=
 =?utf-8?B?M3pPU2tZM2I2TDFpckgxQzVVQVZ0S3RPajRRMVVlenlPcEQzOWtWVk01V0VI?=
 =?utf-8?B?TjNLUmZpOFI5WlE1NjBVZUplekxXYmdUTUY0eXdydUlsZFVZcC9adXRSUkNk?=
 =?utf-8?B?aERNZURpRWJQWTI2RFVvcHg1SStsaS9DYW1zazRsU1grbHNNaGxUWTNKTzBq?=
 =?utf-8?B?RUxuNDhmeFB4OThlMlRPMVdkUGNjalVNVXl6c1BraVlpMWFRem53dzUySU1H?=
 =?utf-8?B?VXJZYVRqaytWSzh2ZTlpbGhzMHV2aEpCZjBKTTN1TUx6aWp4cXQ5TEFQM3pJ?=
 =?utf-8?Q?f78Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1lBNWNkaFo1VDY3dGxBZ3ozWEVFUUZuMFY4ZGZaZ3V3YzF4RUpOYzdUZ1pE?=
 =?utf-8?B?NU5GbElMTXMxWUVMZTVQQ0RSMnZLa0cxQUFzZTBpRmRSNE5IS2dCbTZWMktz?=
 =?utf-8?B?TVhLdTBSMWlJUExjcTZ1d0FrTGhEYjQwRlNTdTVHaEN1aHZiREoxYVIrRlVx?=
 =?utf-8?B?VWhOU2diTzBhdDRhOGMxVWVtNWM1OFpHeGovQjZ2SUJhYzdxSXhUNzRIV096?=
 =?utf-8?B?Y1g4ZnVabkdqVG1jemFRV1BUUG5vNGw0QVA2QW0yaExDbjFDS0kzWk44ODBO?=
 =?utf-8?B?Q2xQVWhteHV0Tm8xSG9Ecm1EcnNTV1VZQkRSNFA1K3ZENlZIZVJDb1lmUW95?=
 =?utf-8?B?cDZJWWJhejR4UHh1T1JaZy9jWFBqU2VMNjZZUUxRY2VQTWpOUlFManhzMCtQ?=
 =?utf-8?B?RzlPb2NaL2RQZUZ5dnNhK056d1RwbDMzMk94WnVzNmlrMkhuby9ld3U0bEJm?=
 =?utf-8?B?TUVjUThsYTJ3TVlWd1FXTWQ0RHpFUnpja0YwWlhxRTJKQ1pVdjNsaHZXUXdW?=
 =?utf-8?B?QVdydnYzd0VhM2phKzlMTVNKY3RwYjQrQmM3VTcvTzZHbE1LdXNZWVE3dmdj?=
 =?utf-8?B?MGEyZzBSNy9WbzlXUm5RWFcvbk1jd05DZzlxenZiVTk5aHBMdC9PTjc5dWlE?=
 =?utf-8?B?bmhEaGZBNkRNNVVyYVZYa0xUVVh5RzRielQ4ekpoU0o2N0RITEdzcHMwZFk1?=
 =?utf-8?B?dm5vQVUwV28rTzdWWE13TUgyQ3VRODRJVkgzY1NxVUpjMFdDMmRDWWV5VzhJ?=
 =?utf-8?B?UkRuTStFb2dNMTJ3WStuZjNJUkVxQUZ5YWIxMjZMek11eTZUMHNQU3JYUHds?=
 =?utf-8?B?ampSQVZ4M3NaUjc4aU9iaUwyZk9NaHhCazRJcE9Bb0EydzF6S08xVkFxcHJt?=
 =?utf-8?B?OU0wb2JWRnp1MUhvTndha1VPRi9QcGYyeTZBUHpOZ2l0V1grdC96QzVPNVpa?=
 =?utf-8?B?UEt6MmxYZHRMa2VBUHpoWGNwTi9PWU15Vy9DN2hBenVsN1VXSmE2WFViYUlZ?=
 =?utf-8?B?WU1uQWdFYWkxbGZ0M2RLRjhTQzVkTFJiWUJvaWp3MXNHbysyZXp3N1BqV2lp?=
 =?utf-8?B?QURpWmoycWtsM1VZdk1ZTFRwcTE2b0xVbUxtcnczdDYrT1M4VGxGTWJxVVZ5?=
 =?utf-8?B?YThWaHg0ZUVIUTM4ZS9ScmViOEVXUEh6Y0tzYVBZOVE4Rkl3UzN3ZHFUTGl5?=
 =?utf-8?B?WTdXWHJ5R0M0N2gzd2ROQjVocSs5K2J6WmZRS05UNUliTkwyNDdkeU9OVzNP?=
 =?utf-8?B?S0tWNTVORjFCODN3Y1ZtSDRNSkZTNzN1eWUvMWlGMEhqNG9vWU1OSVBweVQz?=
 =?utf-8?B?Q3dZbUFIWmo3TjA0ZEtvdXMzSVY3cWFvZ0NTOEt3dmdMZHRaTFpQcHlYbEJQ?=
 =?utf-8?B?a2FHSmg5ZS9pNTU3Mm1nM21IK1Z2U1Eya0pZNTNOSVpRdzMza1N2Ky92L1VR?=
 =?utf-8?B?d2gyLzdZUDBqSzA1UzBhT2kvcVNFekRoY2F4VWJYWW9wQmRqcEVOTTdzMGJo?=
 =?utf-8?B?UW51TzNVaDZSc1hkL0s5UUJxTVRNeEJvWk1IMDBDK1dZVEt4bk51VTBZYXcy?=
 =?utf-8?B?YUowdjdyaWNmSlNXaytvSlNMalM4ckg0TFFTV0pzUzRPYXBqYWpqQk1nMzRL?=
 =?utf-8?B?bjdyZ0NaYW1Yd09RcXM5SHY5cnorT3Y3aGtIWmZheXZDQVRabE5XbzNPcUdY?=
 =?utf-8?B?MnNzbU84ZVgzcjRHL0ViWGpTM3dKR1U0c1haWDUxWDIrWHNTZHluN3Eydlk3?=
 =?utf-8?B?N0hvYzErV2RvWHhZYjFWTmNQbVBTNHVQN3A3MEJ4a0RSU2U1UzF3MjVzeGdn?=
 =?utf-8?B?Z1g4Skg2TUplbzQyK2hWejEzNllzNUNDbUh2a2tsSWEzSmJLZG42SWp2aVpT?=
 =?utf-8?B?V1RONXl5K0dWYkE4YzhCb3F3NHJaTmlXeDA5ZUdGcFlmbm9wTXVEajVNNVBO?=
 =?utf-8?B?aE1HeUFNYWJyQ2lzbWJaSXQyODdwTk1TNjFCOFptTFZ6S0lEV1c5NnBXTUNM?=
 =?utf-8?B?UEpCVkJyWENVQTM4MGVQUFR2WGVRek9SWUVzZkdJc3grQW83ZW1EaVlxdzlt?=
 =?utf-8?B?Y0F1WkVPZzVVdmJUOEJsb0F4c3dUSll2WktkdEFZdHhRODdIbEloUzJ0SEo2?=
 =?utf-8?B?Q3ArN0dMMnlEVWpSUzFYc3E5ZjRnZyt3QzYyakRxSVFRTTRDbkwzRVJ3OEpn?=
 =?utf-8?B?cGF2NTRQTGFRQWtFdVU1RDY5eC9tM3VtS2FIYlhUaUVsT3V2MnRTUE5TWUxl?=
 =?utf-8?B?VXI4eDNPYW1vZzM5SWt0c1FMSzNHSnhCSGZWVkUrdlpaMFNVcDRDVlZoM0F6?=
 =?utf-8?B?R1VRTDhsN1ZxYklZNERwVWVXL0N3aGlxNTYrZTBQQmMrMk9DNG1DY2RCZXkw?=
 =?utf-8?Q?ok0GuNjgu07jngAg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fd6a36-b3db-410b-b3c3-08de5a728373
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 11:28:21.3729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuIz9rSH/d7pooi7OccseUE5ZbJtGjPPm4cATDkK0sfXCV+Rw6hTapH53oTMD4MaTJ7Vu3oDXGfwxSMw4iBspLA9r7KYDTM8+UR0oPTOvto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6944
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

On Fri, Jan 23, 2026 at 12:08:15PM +0100, David Marchand wrote:
> Hello Bruce,
> 
> On Wed, 21 Jan 2026 at 10:14, David Marchand <david.marchand@redhat.com> wrote:
> >
> > On Tue, 20 Jan 2026 at 12:26, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > If issues arise in the EAL flags unit tests they can be trick to debug
> > > due to the lack of debugging output when running recursive instances of
> > > the test binary with different EAL flags. Try to improve this situation
> > > by adding extra debug output for recursive dpdk-test calls in general,
> > > and to some of the EAL flags tests in particular that are proving
> > > problematic.
> > >
> > > NOTE: there are intermittent failures seen in github actions with the
> > > file-prefix EAL unit tests. The problems seem less frequent, or possibly
> > > "gone", with this set applied, but even if it masks the problem, this
> > > set does give us greater visibility to debug if they do re-occur.
> > >
> > > Bruce Richardson (3):
> > >   app/test: add extra logging for recursive calls
> > >   test/eal_flags: add line numbers to error messages
> > >   test/eal_flags: add extra logging for file prefix tests
> > >
> > >  app/test/test.c           |  14 +-
> > >  app/test/test_eal_flags.c | 373 ++++++++++++++++++++++----------------
> > >  2 files changed, 224 insertions(+), 163 deletions(-)
> >
> > Series applied, thanks Bruce for looking into this.
> 
> We got one occurence in the CI.
> https://github.com/DPDK/dpdk/actions/runs/21214407393/job/61031333760
> 
> Here are the logs:
> 
> 2026-01-21T15:18:20.4304709Z  33/125 DPDK:fast-tests /
> eal_flags_vdev_opt_autotest    FAIL            0.92s   (exit status
> 255 or signal 127 SIGinvalid)
> 2026-01-21T15:18:20.4307907Z >>> DPDK_TEST=eal_flags_vdev_opt_autotest
> MALLOC_PERTURB_=42 /home/runner/work/dpdk/dpdk/build/app/dpdk-test -d
> /home/runner/work/dpdk/dpdk/build/drivers
> 2026-01-21T15:18:20.4309736Z ――――――――――――――――――――――――――――――――――――― ✀
> ―――――――――――――――――――――――――――――――――――――
> 2026-01-21T15:18:20.4310450Z EAL: Detected CPU lcores: 4
> 2026-01-21T15:18:20.4310882Z EAL: Detected NUMA nodes: 1
> 2026-01-21T15:18:20.4311249Z EAL: Detected shared linkage of DPDK
> 2026-01-21T15:18:20.4311730Z EAL: Multi-process socket
> /var/run/dpdk/rte/mp_socket
> 2026-01-21T15:18:20.4312208Z EAL: Selected IOVA mode 'PA'
> 2026-01-21T15:18:20.4312639Z APP: HPET is not enabled, using TSC as
> default timer
> 2026-01-21T15:18:20.4313094Z RTE>>eal_flags_vdev_opt_autotest
> 2026-01-21T15:18:20.4314397Z Running binary with
> argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
> '--file-prefix=vdev' '--no-huge' '--vdev' 'eth_dummy'
> '--driver-path=/home/runner/work/dpdk/dpdk/build/drivers'
> 2026-01-21T15:18:20.4315613Z EAL: Detected CPU lcores: 4
> 2026-01-21T15:18:20.4316012Z EAL: Detected NUMA nodes: 1
> 2026-01-21T15:18:20.4316432Z EAL: Detected shared linkage of DPDK
> 2026-01-21T15:18:20.4316872Z EAL: failed to parse device "eth_dummy"
> 2026-01-21T15:18:20.4317298Z EAL: Unable to parse device 'eth_dummy'
> 2026-01-21T15:18:20.4317770Z EAL: Unregistering with invalid input parameter
> 2026-01-21T15:18:20.4318225Z Error with EAL initialization, ret = -1
> 2026-01-21T15:18:20.4319381Z Running binary with
> argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
> '--file-prefix=vdev' '--no-huge' '--vdev' 'net_ring0'
> '--driver-path=/home/runner/work/dpdk/dpdk/build/drivers'
> 2026-01-21T15:18:20.4320519Z EAL: Detected CPU lcores: 4
> 2026-01-21T15:18:20.4320904Z EAL: Detected NUMA nodes: 1
> 2026-01-21T15:18:20.4321312Z EAL: Detected shared linkage of DPDK
> 2026-01-21T15:18:20.4321831Z EAL: Multi-process socket
> /var/run/dpdk/vdev/mp_socket
> 2026-01-21T15:18:20.4322354Z EAL: Selected IOVA mode 'VA'
> 2026-01-21T15:18:20.4322817Z Calling recursive action for test_invalid_vdev_flag
> 2026-01-21T15:18:20.4323483Z Returned from recursive action for
> test_invalid_vdev_flag with 0
> 2026-01-21T15:18:20.4324455Z Cleaning up
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
> 2026-01-21T15:18:20.4325093Z
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
> returning 0
> 2026-01-21T15:18:20.4326091Z Running binary with
> argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
> '--file-prefix=vdev' '--no-huge' '--vdev' 'net_ring0,args=test'
> '--driver-path=/home/runner/work/dpdk/dpdk/build/drivers'
> 2026-01-21T15:18:20.4326783Z EAL: Detected CPU lcores: 4
> 2026-01-21T15:18:20.4327017Z EAL: Detected NUMA nodes: 1
> 2026-01-21T15:18:20.4327252Z EAL: Detected shared linkage of DPDK
> 2026-01-21T15:18:20.4327550Z EAL: Multi-process socket
> /var/run/dpdk/vdev/mp_socket
> 2026-01-21T15:18:20.4327845Z EAL: Selected IOVA mode 'VA'
> 2026-01-21T15:18:20.4328110Z Calling recursive action for test_invalid_vdev_flag
> 2026-01-21T15:18:20.4328475Z Returned from recursive action for
> test_invalid_vdev_flag with 0
> 2026-01-21T15:18:20.4328998Z Cleaning up
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
> 2026-01-21T15:18:20.4329492Z
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
> returning 0
> 2026-01-21T15:18:20.4330341Z Running binary with
> argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
> '--file-prefix=vdev' '--no-huge' '--vdev'
> 'net_ring0,nodeaction=r1:0:CREATE'
> '--driver-path=/home/runner/work/dpdk/dpdk/build/drivers'
> 2026-01-21T15:18:20.4331077Z EAL: Detected CPU lcores: 4
> 2026-01-21T15:18:20.4331303Z EAL: Detected NUMA nodes: 1
> 2026-01-21T15:18:20.4331530Z EAL: Detected shared linkage of DPDK
> 2026-01-21T15:18:20.4331832Z EAL: Multi-process socket
> /var/run/dpdk/vdev/mp_socket
> 2026-01-21T15:18:20.4332134Z EAL: Selected IOVA mode 'VA'

Looks like the secondary process silently crashes here. No indication why
though. :-(

> 2026-01-21T15:18:20.4332468Z Error (line 490) - process did not run ok
> with valid vdev value with valid args
> 2026-01-21T15:18:20.4332815Z Test Failed
> 2026-01-21T15:18:20.4333029Z RTE>>
> 2026-01-21T15:18:20.4333385Z
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 2026-01-21T15:18:20.4333623Z
> 
> And:
> 
> 2026-01-21T15:18:22.3440177Z  36/125 DPDK:fast-tests /
> eal_flags_file_prefix_autotest FAIL            0.50s   (exit status
> 255 or signal 127 SIGinvalid)
> 2026-01-21T15:18:22.3442376Z >>>
> DPDK_TEST=eal_flags_file_prefix_autotest MALLOC_PERTURB_=162
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test -d
> /home/runner/work/dpdk/dpdk/build/drivers
> 2026-01-21T15:18:22.3443273Z ――――――――――――――――――――――――――――――――――――― ✀
> ―――――――――――――――――――――――――――――――――――――
> 2026-01-21T15:18:22.3443617Z EAL: Detected CPU lcores: 4
> 2026-01-21T15:18:22.3443875Z EAL: Detected NUMA nodes: 1
> 2026-01-21T15:18:22.3444115Z EAL: Detected shared linkage of DPDK
> 2026-01-21T15:18:22.3444453Z EAL: Multi-process socket
> /var/run/dpdk/rte/mp_socket
> 2026-01-21T15:18:22.3444751Z EAL: Selected IOVA mode 'PA'
> 2026-01-21T15:18:22.3445036Z APP: HPET is not enabled, using TSC as
> default timer
> 2026-01-21T15:18:22.3445333Z RTE>>eal_flags_file_prefix_autotest
> 2026-01-21T15:18:22.3445927Z Hugepage file /dev/hugepages/rtemap_2
> exists, matching prefix rtemap_
> 2026-01-21T15:18:22.3446300Z Hugepage file /dev/hugepages/rtemap_2 is locked
> 2026-01-21T15:18:22.3446599Z Hugepage file /dev/hugepages/rtemap_1 is locked
> 2026-01-21T15:18:22.3446897Z Hugepage file /dev/hugepages/rtemap_0 is locked
> 2026-01-21T15:18:22.3447615Z Running binary with
> argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test'
> '--proc-type=secondary' '-m' '18' '--file-prefix=memtest'
> '--driver-path=/home/runner/work/dpdk/dpdk/build/drivers'
> 2026-01-21T15:18:22.3448304Z EAL: Detected CPU lcores: 4
> 2026-01-21T15:18:22.3448532Z EAL: Detected NUMA nodes: 1
> 2026-01-21T15:18:22.3448758Z EAL: Detected shared linkage of DPDK
> 2026-01-21T15:18:22.3449106Z EAL: Multi-process socket
> /var/run/dpdk/memtest/mp_socket_59707_2a8a22b91bd
> 2026-01-21T15:18:22.3449778Z EAL: failed to send to
> (/var/run/dpdk/memtest/mp_socket) due to No such file or directory
> 2026-01-21T15:18:22.3450297Z EAL: Fail to send request
> /var/run/dpdk/memtest/mp_socket:bus_vdev_mp
> 2026-01-21T15:18:22.3450673Z VDEV_BUS: vdev_scan(): Failed to request
> vdev from primary
> 2026-01-21T15:18:22.3450972Z EAL: Selected IOVA mode 'PA'
> 2026-01-21T15:18:22.3451326Z EAL: failed to send to
> (/var/run/dpdk/memtest/mp_socket) due to No such file or directory
> 2026-01-21T15:18:22.3451706Z EAL: Cannot send message to primary
> 2026-01-21T15:18:22.3451967Z EAL: error allocating rte services array
> 2026-01-21T15:18:22.3452224Z EAL: rte_service_init() failed
> 2026-01-21T15:18:22.3452473Z Error with EAL initialization, ret = -1
> 2026-01-21T15:18:22.3452809Z Hugepage file /dev/hugepages/rtemap_2
> exists, matching prefix rtemap_
> 2026-01-21T15:18:22.3453173Z Hugepage file /dev/hugepages/rtemap_2 is locked
> 2026-01-21T15:18:22.3453470Z Hugepage file /dev/hugepages/rtemap_1 is locked
> 2026-01-21T15:18:22.3453764Z Hugepage file /dev/hugepages/rtemap_0 is locked
> 2026-01-21T15:18:22.3454168Z Hugepage file /dev/hugepages/rtemap_2
> exists, matching prefix rtemap_
> 2026-01-21T15:18:22.3454524Z Hugepage file /dev/hugepages/rtemap_2 is locked
> 2026-01-21T15:18:22.3454816Z Hugepage file /dev/hugepages/rtemap_1 is locked
> 2026-01-21T15:18:22.3455110Z Hugepage file /dev/hugepages/rtemap_0 is locked
> 2026-01-21T15:18:22.3455938Z Running binary with
> argv[]:'/home/runner/work/dpdk/dpdk/build/app/dpdk-test' '-m' '18'
> '--file-prefix=memtest1'
> '--driver-path=/home/runner/work/dpdk/dpdk/build/drivers'
> 2026-01-21T15:18:22.3456554Z EAL: Detected CPU lcores: 4
> 2026-01-21T15:18:22.3456775Z EAL: Detected NUMA nodes: 1
> 2026-01-21T15:18:22.3457003Z EAL: Detected shared linkage of DPDK
> 2026-01-21T15:18:22.3457319Z EAL: Multi-process socket
> /var/run/dpdk/memtest1/mp_socket
> 2026-01-21T15:18:22.3457625Z EAL: Selected IOVA mode 'PA'
> 2026-01-21T15:18:22.3457959Z Calling recursive action for test_file_prefix
> 2026-01-21T15:18:22.3458291Z Returned from recursive action for
> test_file_prefix with 0
> 2026-01-21T15:18:22.3458715Z Cleaning up
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
> 2026-01-21T15:18:22.3459202Z
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test recursive instance
> returning 0

So process cleanup ok before returning. All hugepage files should be
automatically deleted.

> 2026-01-21T15:18:22.3459656Z Hugepage file /dev/hugepages/rtemap_2
> exists, matching prefix rtemap_
> 2026-01-21T15:18:22.3460017Z Hugepage file /dev/hugepages/rtemap_2 is locked
> 2026-01-21T15:18:22.3460310Z Hugepage file /dev/hugepages/rtemap_1 is locked
> 2026-01-21T15:18:22.3460608Z Hugepage file /dev/hugepages/rtemap_0 is locked
> 2026-01-21T15:18:22.3460975Z Hugepage file /dev/hugepages/rtemap_2
> exists, matching prefix rtemap_
> 2026-01-21T15:18:22.3461339Z Hugepage file /dev/hugepages/rtemap_2 is locked
> 2026-01-21T15:18:22.3461640Z Hugepage file /dev/hugepages/rtemap_1 is locked
> 2026-01-21T15:18:22.3461933Z Hugepage file /dev/hugepages/rtemap_0 is locked
> 2026-01-21T15:18:22.3462316Z Hugepage file
> /dev/hugepages/memtest1map_8 exists, matching prefix memtest1map_
> 2026-01-21T15:18:22.3462788Z Error (line 1396) - hugepage files for
> memtest1 were not deleted!
> 2026-01-21T15:18:22.3463100Z Test Failed
> 2026-01-21T15:18:22.3463268Z RTE>>
> 2026-01-21T15:18:22.3463597Z
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 2026-01-21T15:18:22.3463824Z
> 
> For the latter, I suspect that now passing --driver-path exposes some
> driver leak.

Even if there was a leak, I would have thought all files would be unlinked
anyway. I will dig into this, and discuss with Anatoly too, see if he has
suggestions or ideas...

> But strange that it is not systematic...
> 
> --log-level=*:debug could help...
>
Yes. I will have to see if I can reproduce in a GHA run with that flag
added.

/Bruce 
