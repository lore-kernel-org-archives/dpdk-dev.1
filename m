Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59883CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 09:56:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8820440DD3;
	Thu, 13 Nov 2025 10:55:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 5EBED40151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 10:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763027758; x=1794563758;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sWqpy3Nv2uhqU6zpMwYGaW4PPp7lWpk7LlcenlyZxsk=;
 b=W+bRkYOK7JrSAF4OoFZx+YCahkPaPrsZByJC/oI86sLmafYkQGXZDgPj
 44AMqHTRxdH6gGI2JM6yJE2IYwFSWifcB8oIHnSVElGS6nWV8B+ipoimP
 Lc9UJwMVMs32ED7QyM4hIPm/6DDWFJu8mfM1Sl1iew8YUBT59DObn4r9Y
 H4309lzQkQ+RvXpzirNASiOdjcDC7vGhw2jsteJJeMaX48LDYVZeh4OqS
 c0GKk1I8pj6J5UUwlB2mG8+R44pjPFN9Q+kSrSJXYv7d50iDEPPN9k3GI
 6duLlP83HcQA0R4kjE55ppnp4BJ8DLudlrSufh+eAgXt7N2S5PRLNMpsM A==;
X-CSE-ConnectionGUID: NKtIz2/6QzyvLmHwYaDHwQ==
X-CSE-MsgGUID: iurU8B61QzyVc7gBBt+WtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64110278"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="64110278"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 01:55:57 -0800
X-CSE-ConnectionGUID: nQpTQljAS+Kp0XdzaPC+cw==
X-CSE-MsgGUID: fD6428KbR4epVwmuG0ae0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193710501"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 01:55:56 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 01:55:56 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 01:55:56 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.45) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 01:55:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riqKcLG3KN7SNEvIxIWMIUAsXevN7tFnqNpLtsIr0W9UPIsx6lP0+qqWFL6IcmN+8z4I/olRltwGtE1aoewkGAxb0cRODYe5WGs5oCoNZZxGAy3pB/qlAbqMqY07PpWElDhmdZfruOqOQE6Exnx2Z46Ne95gkdWMSp5HYAug1Rs4DirMGjzrGNKKzRE0kr1TJCTIv9Q+Om9CaWLkC90OZrR+b74iICiLfu+TaE7j5cK5X4TISMNzZLt9uyigd561CnDnp/3uR540rsVnrcXSkLRvHNOXuxjCD+H7ZEty4eGWJq+4tKBOmPbdDS3vuV1myz8kzK//ucruuZMmjXWtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to1aT/fIKOLwQIrdNnZAofAhVqbv5c0TopOUkHgokHs=;
 b=r1pHnyBU87QUMAZusEYOTd2QPc9mqEDCSywW4HOG0Mqee/+YeXDrkHcPFm0ARqt5bPT+7hsmVOUPQES8bafo1Gksyvmf1/I1RHVWbwUBqV8YkyggWC6tEqN1ibA+rv2X0ISkndTJu4yWNzpe8Ux7SNa9j+S/jjIdcU5olBkO5fYIzya4au5hqC1KDhcI0LHxsiTSwGqm+dOZ9HnwgCMliC2afCjXYkSutWpHZIPBfwpoYvuoETYkw8wDfo4/PWy44jzYF2Tu/d/owZTNQyxlUSPKUehYI+JlNRpDl2LniwhJqxflCiq5v6vCVlLEHJo2Vu1Q+2Zyot+Uho0MFMEwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 IA0PR11MB7862.namprd11.prod.outlook.com (2603:10b6:208:3dc::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Thu, 13 Nov 2025 09:55:54 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:55:54 +0000
Message-ID: <a3d380e1-cd2f-4953-99f4-f3634accc675@intel.com>
Date: Thu, 13 Nov 2025 10:55:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] doc/ice: document protocol agnostic filtering
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <vladimir.medvedkin@intel.com>
References: <f2bf17ce5b8f64dade7a5505ed0aaf30343e3888.1761751024.git.anatoly.burakov@intel.com>
 <5d6aa3eed2827e1f7c8e07c1e344e232f010f0e4.1762947241.git.anatoly.burakov@intel.com>
 <aRS-Fk088_bRM3gB@bricha3-mobl1.ger.corp.intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <aRS-Fk088_bRM3gB@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0113.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::6) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|IA0PR11MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: c39c4f31-1aa4-448c-bf93-08de229ad599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sm1TMmg4MkRLenlsejdna2pMaWlweVJBVjhhOWtKYVpUVDAyWEZ3RUwrckwx?=
 =?utf-8?B?UDEvaGZjekJkSG5EdTNXSmVPYjdmZjR4K0tKUlU5dnBGUzFBZThHMmFSWCtk?=
 =?utf-8?B?Z0tvSS9idy9XZVIzQmJkd3o0MmxBVzRoQVo2RDlmVzZDYyt1U0RjNmg4dGdw?=
 =?utf-8?B?VWZiek1xbXVJZ01pUWc1N1IzY21rbi9FL3BOY2xpeGdYNUJ5KysySmxSVUN1?=
 =?utf-8?B?QWllbGFaRmo4WHl2ZkpWREZpNGJUN1VvblZVRjB3b0JMT1E2QXBQRVFoTUs4?=
 =?utf-8?B?WTZuSzR0S3ZSTkNkS204NHdnRG9mVm44bjlCcDFsWHpjblBTWWJmY2tvdThw?=
 =?utf-8?B?WGs4ajYrZEpxNVJLajg3dkZpczg5a1BDTE82TGpLRFl6QUdoU3dpZ2htUlNJ?=
 =?utf-8?B?WDZ1Mlh5eSsrTjdOc0pJOTd1bzBwQXM3QktaZW9BYzgvbWRCc3hicjhLdS9M?=
 =?utf-8?B?YzF6MFh4ZlN3WEQwTFVwRmdkY2ZUM093a2RPeTU3QzBvU25sWVNUYVgxT1J2?=
 =?utf-8?B?M0UyY0U2emJjeG1ndDRYOHRjM0VaRjlHWFMzamJWQk16UEI2YytBOVZzWFlZ?=
 =?utf-8?B?YUlqcGJPUWgyd2hhT25TUlBkZWlraG4xYTZNUWZBeVVJVHZ6U3BKUHB0U2ZH?=
 =?utf-8?B?Ykt2WndlZDNkaVlPbGNFWnE4RnRqQzJUbUZtMHRMaitKYmZHYTk0WWsxRFQ3?=
 =?utf-8?B?RGxoWDBVZ1JTTU80T2NGMEt6UkM4VEZtM0ZuL3RRdWZnM1FXZWNZbUpZRlQ0?=
 =?utf-8?B?WUpYL3pTT09yK2V2RUpHOE1TTE5acUplRmhLeGF4dXNESXVXamhTOGIzRVo3?=
 =?utf-8?B?ZktFN1loRWFhejNpZC9PYXROSHozTkN6TGxUOE5ob2x3ZnIwL3JERGdVUEhx?=
 =?utf-8?B?bENmcXVWeWwza1ZKRGNPZkVuK0kxdDJKU1ltR0FPc1R2aVRkY1NjR0FNakJI?=
 =?utf-8?B?cUNrZU5yTzRGUEFwdFU4Q2FRYWQ4aDlpMVVaWXpRbHJsY2dSRjdpNCtnWksx?=
 =?utf-8?B?aGRlUlZBS1A4dGRadFFQZ25hbWdsNENCMkxuQURUVTFKSmVYMWFmbnBrTVp0?=
 =?utf-8?B?QWxOdWk5VkJncStoSWxZSFNId1VnMEU0eHBodURBWUZYaFBaakRYNE1Tc3VG?=
 =?utf-8?B?TjZERzQxbjBKQ1RhMSs5dW1oelZGMktPaG02UHlrRVZRY1RRdDVaNnJhaHlx?=
 =?utf-8?B?czRRSDRsRkJ3MTdMSEw3a0dOR1IyYXZ4ei9kb25GQ1FtcVBrT1ZCQ3FjYzgr?=
 =?utf-8?B?NmFRcWlpa3o3aFU0a3BUOU1uemdBdnlYR05zdXFSR2FEenhzUUlzcEZ6bHd5?=
 =?utf-8?B?NHUzVjdKNWUvdlZ4Z1M5OVdKLy9kQWNReFRuRG11MWZxaE4zbDBXeS9JOFZK?=
 =?utf-8?B?VlpyN1BKL2JXWVgySU9tZEk5NEd0MWNKTTI2ZFlGUnFFLzk3ZE0zSXB2MCs5?=
 =?utf-8?B?WkRyYUROWEpKdnhRa3BxTjcvSm1BR3dQeWVhMGlqMllxWm1uMEhXY2lpUHpC?=
 =?utf-8?B?bmgyWlBMWnhUemNQSTNNTXlGS3d5YWw4TUFVU0hWT3dINnp1K01ZV2tLMDBt?=
 =?utf-8?B?c0ZiTlF5WkVCSEJiWXQvVlhOOU9TNzhjL3BTdmZNdHozbU5Pcmw3cGxlWEo3?=
 =?utf-8?B?M2FsTUd0VjZNM2JUQjRKd2phV3hWTHJzWEFLUGtoMTROaVAyMnA0azBmZjJ2?=
 =?utf-8?B?VEwrcjFwblV0bWtyVHJiOHR1R08rVm9FY2Mwa3N3bFlhUnZaNUNNT3BHNi9h?=
 =?utf-8?B?ek13Z3dBQjMzUmUrWEpXSnBDQys5azFKbnp3V0xDczdJSjRQdkFrdnkveGtE?=
 =?utf-8?B?OEVSUWFYRW1xanZMbVNhcWZTdjB5clJHYXFiVHZETUdycjc2WUtQMFhaVWw0?=
 =?utf-8?B?aitxYWlLekxUcVRJWVJvc1ljRUYyeVUxUjNyM3RwbktUdXB0alZNc3FNUWo1?=
 =?utf-8?Q?TYV9pogOisWavOJdlowr0rhRN8Qkrmv+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZrTkUwVFRtUXBPcmhJVG5jcFZXd1JDRy84ZkNqdkN2TTVoYWZka05SOUY4?=
 =?utf-8?B?a2dIdUducTJ2Vy9WMUFuOTVEeFA1eTVjeDFIUFJ4VktRREp1Qks2clhJb0Ex?=
 =?utf-8?B?eEIrUnBhT0NFbXpMQ0Frc3BXMjF4Rm1qaUxpVUtERUJ1dU1kUkEvbm1MTWtN?=
 =?utf-8?B?QmhjNmFPa2tkZXZhSVR2WC9FYThLUDdqR0JONGNlMXdQOE42QUhnUXRsb0hT?=
 =?utf-8?B?R0lQeXZ6Tjk2U0lFNnNWd0NURWtNZlZFNnEzY1A2LzRMMlpIVDdsYjJJMlBH?=
 =?utf-8?B?ZkNDeHM0WXVJYkIwYmFtVUdJYVZya2ZVVU4vUXdHQnVLYVhFR0VhSVdwUzQ3?=
 =?utf-8?B?Y3l0d0hGWnBDZmFVZ2tVaW5uUkwvWnhSMzdVWitKRkNqYW9ON3hNRFBGNUhS?=
 =?utf-8?B?TVJnSU9iSEkxZXAvZ1Jkek5VVXp5WDZCNGloZzBZOExhZTdWU2NHcW9yTDN2?=
 =?utf-8?B?TFFiVkJSUUc1cnNYTG1CU0hpVEJtWjB5Tmk1b0d5Wkk0Z3VzTHpDMHQvOTkw?=
 =?utf-8?B?SHNZV1pkbmZNUElNdnVnSmpXdE85Y1E1YmtWN2p5MklZakxzR3h6L1phV2dN?=
 =?utf-8?B?WWdlQ1BzQjZyaENkRXk1NDdLK0FubXRkNlNKVFI5Ti9TVjBCVVE5Z0tQZXVs?=
 =?utf-8?B?bStvU0x4c0g5RncvOTdnL0JlYzQ1YVMrbUgvNmNxWUgxWmNsaVZUWElReU80?=
 =?utf-8?B?QjBEVm9JNTdnMU1yL1M1VVVSOFVCSGVqS2NHZmVob1NBOTFNUmdhcFF3ZFZW?=
 =?utf-8?B?cXBKekNURmF2OFZxc3ZNVWhqQzFrSk01dldSbE11RVdMZ3lHZ1lPZ2ZETkhG?=
 =?utf-8?B?OWxuQU9ZYUVHdng5WGFPc0xMQjF2ZWVkQVdNNVBVNklGUE5ucHNuODBOSEF5?=
 =?utf-8?B?N3NXTlYvV0NnenJUU05oSFptSVgrZXpDelBUVVAwS0Rhdmh4YjlRNVpna0Nu?=
 =?utf-8?B?cWpobTlFM2sxVXpBWUpqa1pmV2ozQjd6RTkrd21ZSGpFenhJN1JKTnh0aEl0?=
 =?utf-8?B?ZXNpbGNUK3lQSVZ2SGQ1SEV6WnVlSmkxeSsweHhOSHBTeVVPclYvc2g1OVlU?=
 =?utf-8?B?WTdnWjkvSHgrcVpqdm8xWlZabi9CM3JMY0ZWTHg3YjdjemRBRk5rS0U2TE4z?=
 =?utf-8?B?ZDVpc0dTSFF0dU1FZVRCTHNMQVpaRU1nQmtCM01rYXIxcFFLbnlOMys4QWRE?=
 =?utf-8?B?YllvY3ZZU25NRmdJYyt4U0ZEODdCamgrbS91a0lEMDJzamxOb0VyZ2JRQTVN?=
 =?utf-8?B?Z2FsS2N5U3JzbDlUZkZHdytScEtlT1RlRldYcTVZM2loV1pCdUFWbDZDQW5M?=
 =?utf-8?B?VHBvQy9Bay9HK2FGRW1hSkZOSVM1b1pmcE9sVkVuOFZqYkVtb0plcU9nY2dX?=
 =?utf-8?B?dUg1VEt0MFpHQ1NBWDVEVHN0SEp2TzRqa2lxVGF6d2NZdVkvYWRVdkNJM01q?=
 =?utf-8?B?QTRSMzJ5dVc0SEcwYUxnQ1hrbVJPS0dHVVBNTXZGUEtVMis5M2J3MW1CVVRq?=
 =?utf-8?B?dUhqMlFtc3NYakg3QWRxUmsyZ2VMYXlZSTN3UzNlSVQ1US9WbWVJVHdCRXMv?=
 =?utf-8?B?WnNLVzZpN2FJaWtRdjZqQldMeFd6d1RaWWYxeEF5b1ZrTEJVYjZWK2dMWHFr?=
 =?utf-8?B?SitHeGJzdTRDR0g2UERIa2xYR0JybXVIM3ovR3pteDFsWnRlZzZDYm5sWEIv?=
 =?utf-8?B?Z0t4TzV4NWQ4dTlWNjkxeUljMHRZbCtCUm1uTmppR1IrTUh0SDJrd2tIcktl?=
 =?utf-8?B?RFo5aTZCdE5hYXcxc1QzYU5iL3U3ZmhGMkIwOVozbFd5N3dDaER4RW10K1M4?=
 =?utf-8?B?M2ZhNWhuWFpsT2JwZXlQZzRaYnJrT0JUZ0FxNjk2b2F3WnFoM1MwOTAyVmg2?=
 =?utf-8?B?UzltcWNIOVplSDRpUVc5LzBmTnkwcUN0ZUYxU3RRTDZnYndKcDYxVFlGeTln?=
 =?utf-8?B?NlVWdFl1YjNKejJPRW5hTVZrblpkUEtJVUdjSjBzUTZTYWZzM29UM1M1dG5H?=
 =?utf-8?B?Yi9yNm1DcEZZakhHZS81WjUyc2dlOFhJdmN1b292bGJiek9aWDNVRFgyOUFC?=
 =?utf-8?B?UmxOQm9BQWhuL2E1Q2NJdURudlN0RFRsL256cExiTC9KSnRIOFRaajRXc2lj?=
 =?utf-8?B?clRLVWh4Q0JkMllBblo4aTZTVzZhLzdEcFRWR20wc0VxcDBFNVV0c2tCb2Jw?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c39c4f31-1aa4-448c-bf93-08de229ad599
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:55:53.9629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpVz4iaL05rZu3Swf69X9/ma5isDK/dXCUQSqkJjDylRmF8SnW0UBQFbNImKXrKa2EW334SeGf7yCtnIcjkM36QC35tOR58ot0HIiJssOw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7862
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

On 11/12/2025 6:04 PM, Bruce Richardson wrote:
> On Wed, Nov 12, 2025 at 11:34:12AM +0000, Anatoly Burakov wrote:
>> Current documentation for protocol agnostic filtering for ICE driver is a
>> bit terse and relies on a lot of assumed knowledge. Document the feature
>> better and make all of the assumptions explicit.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
>> ---


>> +
>> +.. code-block:: console
>> +
>> +   python3 flow_parse.py --show -p "mac()/ipv4(src=1.1.1.1,dst=2.2.2.2)/udp()"
>> +
>> +Output:
>> +
>> +   {'flow': {'generic': {'pattern': {'spec': b'00000000000100000000000208004500001c000000000011000001010101020202020000000000080000',
>> +   'mask': b'0000000000000000000000000000000000000000000000000000ffffffffffffffff0000000000000000'}}}}
>> +
> 
> This looks like it should have a code-block tag on it too. Was that a
> deliberate omission? If it should be there, I'll add it on apply.
> 

<snip>

>> +
>> +Spec (packet template):
>> +  000000000001              Destination MAC (6 bytes)
>> +  000000000002              Source MAC (6 bytes)
>> +  0800                      EtherType = IPv4
>> +  4500001c0000000000110000  IPv4 header, protocol = UDP
>> +  01010101                  Source IP = 1.1.1.1
>> +  02020202                  Destination IP = 2.2.2.2
>> +  0000000000080000          UDP header
>> +
> 
> The format of the output in the HTML here is not as above. Again, should
> this have a code-block tag on it?

Yes on both, they were meant to be monospace formatted (not necessarily 
a *code* block but a monospaced block at least).

> 
>> +Mask:
>> +  000000000000              Destination MAC (ignored)
>> +  000000000000              Source MAC (ignored)
>> +  0000                      EtherType (ignored)
>> +  000000000000000000000000  IPv4/UDP header (ignored)
>> +  ffffffff                  Source IP (match all 32 bits)
>> +  ffffffff                  Destination IP (match all 32 bits)
>> +  0000000000000000          UDP header (ignored)
>> +
> <snip>


-- 
Thanks,
Anatoly
