Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F160DEA811C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ACED400D7;
	Tue, 10 Feb 2026 15:11:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1B9B3400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:11:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770732689; x=1802268689;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DmxrihHoQig3UIZDvsL8o5ax5ERHLPvprcpR0PKUeqw=;
 b=nes9s6ZwrLRHVkBY+CXaGfwkEnBDvQ10afVKCQsIRNLyyzC777S2inUL
 f2W6u1w/AhwQw6tZ4qshu45amKfy2uIuARRjwNsW9/H5QyG3GN9tDwkBi
 C4GECexan9UcCpnXDLFyZPlJB3zpS9Ihlkpmveis3eKFF8Obre8KGdNZr
 Rd44JOSfky3729/rHVQoL1gAB/TTAe1owWpg+VdH9TjR8QRi2ZRJWMAFB
 2PKZxY6o3q62vuoSZ9YdMd8bIBxktmTVuq2dnPoF66u3CUfx5n6u1XWsX
 r67w9jlG45mdfTZZQuMwmHQ96nj7k+Hx5UnMdFJGMvOaCwfo36/8Cm2+4 Q==;
X-CSE-ConnectionGUID: UZPaSNjmRnK7WCLL39PavA==
X-CSE-MsgGUID: kG7atgFwQOuwRXolyB+0VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89448631"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89448631"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:11:28 -0800
X-CSE-ConnectionGUID: 8lgaugeaQ+qbtTchYzVFMA==
X-CSE-MsgGUID: GVuUsCClSWKFO4d5Q47MBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211006103"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:11:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:11:26 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:11:26 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:11:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKDuV87L15NBSiV4rv1rfHX8dH06H3YFmgebrEcygvHrf4mLhiIzHzcA18A0GldUPaLv+Qtr9ciROFyN90ScvgVxWDEexjwmZcRkkFhAcnNaZFt5l9GxRY/0pCHxrtYcLvz3IgzQ45vaGbnT5HkZmhY/VlpZQbNyHKU6SKehZjGTJ27UYlQJ9BKT5xFYumoZko7mwJxg9ESwbmOn6esyiq++x/i1n0cBPF9aM9Ywmgqjf45dt3+Pu/OQPl68Leg/1Iu7MnraafZKvif2XYJIAyvpBDqWK5mecZAKWjlzOgD5Mf635mq3ZSW0hR36+XDLs+GQtrDNnFrpDdSJdKetNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ORtk9FDymfwXeEEA89QfMMNaizjPRq1ZfSwhW5tdoE=;
 b=nBzAnzIWWYARxiKVfMDCLUM5YrqPElkGmEB5xZksh5w/hqhw8g2HPu318e36/qbL/n2FNA5S9i3dy6dTkr2CgNfXHI3rEVNcPF+9J1h+UDSSzUrdppjMjLF+2j3rPuxYBwIBJar8PymDZHyncKrRHKQKEEuJixe4rsTBpN0QLe+0oPwQM8eV5m6KGXasrV0eF8unqJAZJNQ4B+FAYXHscZk494Qf1xtCo48NsEUo0l3x10xvzWfrBKkkjvHtpxhjO33D7w/+LrLbN1FpXKqd8wKUUPHNTZMH1fNEOcn6iMlpGC96HcKb85Hbf6zsc7QYfZjtiRPKJC+NXHNYkvVb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 14:11:24 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:11:24 +0000
Message-ID: <1747d88c-8501-44cb-b933-490f957b7516@intel.com>
Date: Tue, 10 Feb 2026 15:11:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/35] net/intel: use separate array for desc status
 tracking
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Praveen Shetty <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-25-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-25-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0312.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::17) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: f822752a-2d70-4fb4-943e-08de68ae458e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUoxNnhCSW5iRmZCQmMvRU8yc0tnVkg5SGNYY2VqSnhYdjdpbVo2OHpPZWh1?=
 =?utf-8?B?ZUZzMk1ZSmk1Y0swakltQWpJdmpwWGF0cFAxamdMU3hUejNVOXBRZmR1d3VZ?=
 =?utf-8?B?YzduOURqNCtPb2JDNHYyaDFiUXNtMHpGVnMydE1nbU9rVkt0Nkk5RFpWbGpR?=
 =?utf-8?B?OTIybERWSHdLNjFhUFpMUSt3MkNxTnNmd2grYnF5RlI3RVVVRHozWUtpNDll?=
 =?utf-8?B?L3lwb0NySlRSNTFFMEZxZytEbmM2cHlZWVE1cDl3c2ViM011a0FaT2hGSVV1?=
 =?utf-8?B?SkZMR1dYN2wwcCtRcE5xck4wUkFXTlFkU2xySm1saWNsRStVWVc1SmNsVkpv?=
 =?utf-8?B?c2hQT25QUVRpa2x6aXYzZ0gxMXdqV2kxNnRSQU1aMitYTjg0RncwWFRJMGxW?=
 =?utf-8?B?bFRmb01KM0dRWHRrU0JqUXQyb0RrTmRKMDVlWCsxdzV1eTNDMEhBQkU0UkRj?=
 =?utf-8?B?U1lwWWFYbEVHKzNYcTFaQ0xRZDE5NWdydUJFVkFiSDlvYUtCK3czT3ZSOUNP?=
 =?utf-8?B?MFdWT3JxVEdNd0dJU1hmQkdiVE0yTCtNZGh1REVaTWNZM3EzTHMyS2IrbnI5?=
 =?utf-8?B?djFScGR5RENOSWVSR2h3OGpOeEQxSXVwMHc0Q1NrM2dqbW1SZ09hQUxrajA3?=
 =?utf-8?B?K1BDa2dZL3VMZ1pvamJHWnI2U2VLaUVJTUFEYThDUnJTV202eU9kZDFMRFI5?=
 =?utf-8?B?aXJlcUNPYnhhZzJUOXc3NHRra04vU2NDRnZ6QlJKeE04Z2Z2SkZsMTVSL1Ex?=
 =?utf-8?B?QlRNY3lMYldXQXZVYVdValpYOHdvRlRya1pUeDQycDV3bTliR0wrSS9ERkY5?=
 =?utf-8?B?dmNrcUZ2UU1CK2F5eXJYZFc3dnA2cm9BYklyaXJYQ2pYTHIxcmtNUmxsZCt4?=
 =?utf-8?B?dVM3NXQ5eHFCVkNLZmUwWms2ZnhSWlJzNm80ZDRUaVhkT1ljMzNhQ2hEdkVr?=
 =?utf-8?B?eGx4ZENQYUY4cEdsTERGcndYVUZNTzYzYmJTOU1SNGNCT05ONFlKbkJ1djgr?=
 =?utf-8?B?ZkJSOWxMb2pEWXkwMjZFeFZVL0xFYjNMUzlHRXpoUXlyR0k5RGN0VDFMakpx?=
 =?utf-8?B?Nll3UUQyQk5PbGh5Zjh2TjlaaURSUzN6Mm1zWlFudlRJSjF5ZDJ0SGlCbzlD?=
 =?utf-8?B?bGpJRXZnTXFQcGQrNzRkTVBoTzNEdWZyTTZkSVVvc3pCTndyU09GNUMxaWw3?=
 =?utf-8?B?VDcwNnpxUko5SkpwbTRQaTNjMGhmQSt6S3V5TkZJbFhTMVU5OHlKbTMyY0p0?=
 =?utf-8?B?aExJVHRtNjZ5QUtZZmtra3NoUndIeDFNWmM5UENYZ0ZHMzFVajNsZHdxVXRI?=
 =?utf-8?B?bS84MHltejJFSzdVd2FUdGgrenl3OHB1QXRpMzJ2eWcxV1R3T1JuKzZxNVlk?=
 =?utf-8?B?OWZtSnA3Q0xmaGZIY09pRGNoZXQ3SUhZOEN6OFdkNklBOUoxM3pGbjJKMTJw?=
 =?utf-8?B?YSsvbldQbUxNaW4xQk1yWVpweThOdVE3ZTR2cGpiT0V1OE1SODhPY2NNQ2lH?=
 =?utf-8?B?YnFEcUtqbjVMZkR3RjJnY2hkSzFxYTlLV0hhZXU5ZFB1WTdWWm5DdGdQaU4x?=
 =?utf-8?B?eGhjSkd6Qm1CSERBK1RzemZ4YlVoTDdMcXZPcVNBdkRtbHdNbCswa01HbzdF?=
 =?utf-8?B?em1SZ0RLMHY1cWp2SDhyOXMxSXR6dGlqN0djVzJPRHRYdWZ1VnM4bkdoakFw?=
 =?utf-8?B?L1R1UkNnYnZoZGZqMGw3RG9KdkJXYllRSmFPQmtlS2IybWx3TmsvZkdCa0Jt?=
 =?utf-8?B?dmdxSEpVUjVlM3lhbVRUajI1cXA2K280c0Iwa29ZcCtobGx2bW90bjBzdzNa?=
 =?utf-8?B?UlU3ODJVSTR0OVVVVjFMQTIrcVpNN20rM0pHNXFETUtsSXhZMnlGZldZWGdy?=
 =?utf-8?B?MXd5NVRqOUZ5bzdEZFFMWXBzc3ZQSWdhcEdVdDNYT1IwMEdYNUlrNExrdG1I?=
 =?utf-8?B?VWVlak83QjVmRWRVdi80MWNGN2Rkb0ZqaVoyaEdOQ0QzL1pOQVBaZUpqZ3BF?=
 =?utf-8?B?NlBPbFZESTkzSEc2L1Raa1ZYU1pPbW1ySkRhdThyVGtMbmZUR1dzYTlRWURG?=
 =?utf-8?B?dWNkUUNYbDVKVWJwbzlJUEwvWkVjTUwwenFzMzVoNEptMGsrcGhzQ1VxNGp0?=
 =?utf-8?Q?s0gM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXdYV3JNZlltbExaMVZDVk1nN0VuaXRKQkM4T1JhZ1E0eG9NYVF3RHZQTWll?=
 =?utf-8?B?TnZBTDkvUVhqd25BZVZLTDR4R0d6MnFUNU44dTMwZmQ0NDJLY0RHb1d5NTd1?=
 =?utf-8?B?UlRWS3hFYjd4WGZxOVhHK3ZKTFR5UGdPUk5aUk1BdkhETzNDL2tkWFBDMWph?=
 =?utf-8?B?bDM5WGE1VzJtRTU5cXEvdmJUZEtUeDh1aTkwQVVONHpRMkRlSHJTUHBkdkxh?=
 =?utf-8?B?d2pxdWhOcjZFVjFORENMK2k4ZjM5MS9tYk4yU05SUXFVeGwzOHBxNmg3M2Za?=
 =?utf-8?B?UURQMDVKSUxEV1U1Y3ZucDFrRFFGamhFUUFtS09VeU9rT2RoSnhCSDF2MHdi?=
 =?utf-8?B?ZnZpZkhiQ1dXVjdiMlBqMVI4NWxMYVljSjRKL01kWm1DaEJNOGVmaW01OGF1?=
 =?utf-8?B?TExpV09vTmsveVZtcE9RMHduYk5OT1RtWHVKZnB4VVdwNHh5Y0RRYVZwYjYr?=
 =?utf-8?B?QkZMbEl2aTlPUXAraUs5NmM0K0IrM2ZzOEdIUVBpdVV6cVRobmlEUmh3WWV1?=
 =?utf-8?B?bmg4RVEzUVZLNWVZMUtEcVdkbXlzeUkvbkdOM1FPTnBYREtPbktpN1VvVHlC?=
 =?utf-8?B?bzYrZzFzRTFDMm1TcENqUXUxU2M5YStBL25ncU4xbndlRjI5QStZVUlFeFFZ?=
 =?utf-8?B?Q0hSLy80RE9ySGpjQ1R2N2xmWFVkR083bmhqb3NTYXcrTmFNMzIxeXMvUzA2?=
 =?utf-8?B?UVV1SFc0SENQckFNMDNGVWZDdlJpQkNHYS8wZUZBUEpvZExpOXRTNlhGUUVl?=
 =?utf-8?B?bmhGell2Qkw4TGMwMi9RZjdRQ1dGS2t2bkljS2UrSFRMc0p6ZU80M0c2cUxq?=
 =?utf-8?B?RzhIQWtWZDVZc1ZNM2ZkOHo1eEhOMStuVE9OcXo2R1Y3L0tveGw5LzdVa0cx?=
 =?utf-8?B?ZWJlZHNvVkR3NnlTVGM4MzJGYjJKQU9udlM3RDJ2OVB6SHc4RUFDUlJKUlVC?=
 =?utf-8?B?cHcwVitFcUpERTFKZE8rRUNYZWlYZTBQLzM2RGdIMnk0bGFub245cWRZLzNK?=
 =?utf-8?B?Z0pMNEh4bEpWRkhET2tSSnY2UmUxT1ZUZjBNMWI4MkpUdjhXVk5vUGpodzRU?=
 =?utf-8?B?dHhVL0k2UVpsWjhhbEZETk5nd2RsdzVPSVc3ckF5MnNmdk5kTGxLNU1HWkM5?=
 =?utf-8?B?L3hGNmZFbElzSHJkVjFuL2tIM2lVRy82a0lXTStobGZuWVgxTW1GTnljeGtm?=
 =?utf-8?B?YzdxdU9BTVNXQzhoVVF0N2VIcGFTS25WbEdEREkzNHEvcU1ZOGpkdHlsUEhT?=
 =?utf-8?B?ZkM3bjgyTWZhRzJ1UzFsYmtKbzNVUGw1SFdneUJPYTFuSVdiNjdmZmRKOXdM?=
 =?utf-8?B?eXh2YVZWZVEvTGNNQ1BYQWdDamlnU1lBRzFrekoxT00ySzNKYnBBRHhMVzho?=
 =?utf-8?B?Z1luU1RBdUhKWjliSitsK00ybURvSmZFMGFJU1Nrd2oxQ3FGOTRyY3RtKzdh?=
 =?utf-8?B?Y3U3cGRxUlAyY2pjWUg3RVRCdWlZeTUvd0NMM1ZRY2h1YkQ5WE5zL3NJZFQ1?=
 =?utf-8?B?WEkwdk5wdTIwUzJ3Ykdva1RNcEhYSm41TWJwYXlIaGV0NzA1cCt4Mlc1OFM0?=
 =?utf-8?B?RE1EVEFOK2wzUEw1SDhNTkY2ZUc2VjAxQUg3NlhJckJCS1RTMGlBSkFZSDRH?=
 =?utf-8?B?MVVaTHp3ZmlSdzNhT1RjUzN6S1NnZ1FPZmtoYlVxZE02bHFhRW1tMmYyTlFh?=
 =?utf-8?B?dW5laTJGSFI5ZkxFQktFbzFaUjdwQmVzRUoya3dXeXpjWjZSRWU1M0loYXRF?=
 =?utf-8?B?UEdSVW9UdGhJRkZuY3VrZHFWSWJ3K2J6ZDVZdVkwazMzbmNzc0VKQ0lGZ1Bu?=
 =?utf-8?B?Zlo5Z1hCak1VdWVjVC9CZS9rSDEvS20wSFBjWGxpMmFVT3dncWI2NUg0dFBW?=
 =?utf-8?B?d0dSK3Z2aU9oMlkyeVNaSzQ0TnJCbWxqRTlrenkxWlFWdUxzZEd0ZCtVK21s?=
 =?utf-8?B?eFY5YzI2M21JZDhCSjJoZUdVSE5YbmFzdWZVVnJHUTlYeWJyUUpMS2lyODlD?=
 =?utf-8?B?S1ZtUzlQa1M3M096bUJ2OGtSUXg3amtzTVZhWUtpcTdWS0lrbk1Kczc5d0Jt?=
 =?utf-8?B?cGxkTGhuUkdMMVZsM3lEalAyYTAvQkEvdEUybE92VXRsY3dlKzR3YUpIbXFI?=
 =?utf-8?B?aWFwcFJ4NXMzakRoQXBzdU5CcUtJeVczNE5JVitYaFNXRTdFQ1J3aTgybVpI?=
 =?utf-8?B?bWhGRTIxVWRTMEhPdWE4QlR0QVZIR1VWcGQrbDd1TUVXOEkxZTl0d3JkK1Jr?=
 =?utf-8?B?bzk4cUYwVHp0UTkyd21BQ3FyQ0VuLzdRbWRjTlh1Q1J4SnNOYVpCN3pnYkZC?=
 =?utf-8?B?clJMZVVXMW1KU3lhQWRIQkt4WEluYmZranVQMUJmZFlaUXpCRjE4N1VndjNw?=
 =?utf-8?Q?yc/UWAukjFMWW+2w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f822752a-2d70-4fb4-943e-08de68ae458e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:11:23.8392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExmckzOJmCF98qoTaPZLwcL0HOHNGqJsBJlHjN803QfTTUlF3tHM5sEudgpFKIWwPrM+sEi0mMdgItzX3lhyujn/+ccJ//nYtQRuzj8y2Ec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
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
> Rather than writing a last_id for each individual descriptor, we can
> write one only for places where the "report status" (RS) bit is set,
> i.e. the descriptors which will be written back when done. The method
> used for marking what descriptors are free is also changed in the
> process, even if the last descriptor with the "done" bits set is past
> the expected point, we only track up to the expected point, and leave
> the rest to be counted as freed next time. This means that we always
> have the RS/DD bits set at fixed intervals, and we always track free
> slots in units of the same tx_free_thresh intervals.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---


>   	if (!is_splitq) {
>   		txq->ci_tx_ring = mz->addr;
>   		idpf_qc_single_tx_queue_reset(txq);
> @@ -628,6 +642,9 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>   	return 0;
>   
>   err_complq_setup:
> +	rte_free(txq->rs_last_id);
> +err_rs_last_id_alloc:
> +	rte_free(txq->sw_ring);

This looks like this free wasn't there before and it should've been. 
Separate it out as a bugfix to stable?

<snip>

>   		txq->ci_tx_ring = mz->addr;
>   		idpf_qc_single_tx_queue_reset(txq);
> @@ -502,6 +512,9 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
>   	return 0;
>   
>   err_complq_setup:
> +	rte_free(txq->rs_last_id);
> +err_rs_last_id_alloc:
> +	rte_free(txq->sw_ring);

Same, bugfix to stable?

>   err_sw_ring_alloc:
>   	idpf_dma_zone_release(mz);
>   err_mz_reserve:

Otherwise LGTM

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
