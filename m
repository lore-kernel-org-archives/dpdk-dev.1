Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B744CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 14:15:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5355940292;
	Wed, 27 Aug 2025 16:15:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 19CE040292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756304112; x=1787840112;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OqCKAeD5dNeDUg+8Bt4XU6H9/ogcgbu3Q0l1Jxf7Dxs=;
 b=Hl8wUxf+T1u+y7vVOMpb+osVTCuCDDTOdETJXofJf0bZRyUHq3JgUEo6
 Irizn236+NiVCwiHM4nDO2NSw5oyI3ehh7UIHEjydGFO9FC9vE3Ka+BHe
 TeCtoRj7exUBjNJXMRkfK4bjC+OCggsQltqTkNMpeVpc/JRgUffZ22wYx
 Zt68ZNmZdDbBPJf4ho/PLmSLT/EYQB9xdpW4BgCUZ2urRZrMIAnMeMFEp
 NTwehuboSypBtE4MWi2ZK2zk3ylrlzd2JBhSvc3e+OPOPp8T8b3CAvCPz
 Qfz0jwLkDz32Lx9XyVNaRL1yZ111xsuC6/8oey4jzM4xf4PEcxCo0elNa g==;
X-CSE-ConnectionGUID: LKU759+EQReioocMlwV5MA==
X-CSE-MsgGUID: 4iSCYrD4SsGnGOSND2W+eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58618573"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58618573"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:15:11 -0700
X-CSE-ConnectionGUID: 0EYIDtZGQHmfxrzPXXqUkQ==
X-CSE-MsgGUID: YZBh6wCTR8COSx1xeN5xMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="174185501"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 07:15:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:15:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 07:15:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 07:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx1+jT0SJgvyq8Xo3MVo0g6Sax0O2GkOLMem2mCdoO/bCgXf4pQojAqN5ZEJCJOGBs0tSUudbva4Ch1SbPq2wDDy0A08eQdaaqOQwvnEDVopGmAgtNMQOWusg/oZwwW3Hhqd+7hB1YdH4u6mhVknzQGpVnu0EhdxX/xfVJ1qV2wuSRMSPst9J5fkRPkmtgl1OPmloKa+p+4+TfQmBoxRd708uKbpvYw0fPR72b3lQhI5eihUPBfhNG+L7HQH92kJTGu1yfynhMCb0/+p9n6/Qr4WeMfSj3Z6lCsoHowsfYlLoYkVihrYO4fa6uwcPAl8oFCUkhjORL029rOM1uZ65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ4hdD0T7BESn+Ewuz3Qx2aX3qwxF3AnczvLB8sFcNM=;
 b=PgpYIZB6bS7A4gjIIRc2nJ/HofR1oEKRQFPNAVIIQ+u7CzECBJjk5IYVoJsyrBnBh3kaw7WmMk4JgjwZxnzl2Bl9KY2WhgNfahNQtJtzzBpGLeeFFMJLsg3eLBjsyaTErgZL3ObDCaHufsXu0tZWRn6XUc/8oaf5pd4KBE2UzATKWr6xs0AXIA4TEpp0sYpznlyyy/vcfaqEs0GulQLgxTCFmgBWdOKufSazmP1S17rNyX2hkkQkuSDlnbc8Um/MXfJHQxbK+E88HYZ+YKbv9qfNOn19SJp4YjOWipI7BN5S2Mse7xP2wi+BrZFv3vhTjrJURZqlA9RnIav+OwJ5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 14:15:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 14:15:06 +0000
Message-ID: <c7b839a0-c5d1-4cfa-b5dc-2f8b98b9ff29@intel.com>
Date: Wed, 27 Aug 2025 16:15:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] net/i40e: replace open coded version of
 LIST_FOREACH_SAFE
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Ian Stokes <ian.stokes@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
 <20250312231715.222149-9-stephen@networkplumber.org>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20250312231715.222149-9-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::19) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a959cce-cb41-49fd-b06c-08dde5741f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1BhSnE2a0F5U2FaZ21ObWZoL1VUREphSWwwRVYrQ2FNVzdLUVMzbEpwcmhC?=
 =?utf-8?B?ZFJLV0FLd3RoUzUrZjVIbWc0eEZuWEU5MjZnR3VHWEtZOUx5bE1XRUgyQy9O?=
 =?utf-8?B?WklhZ2RiTGdWM1kvN0pQby9OOGFHSmZDa3NSNGRvVXNlaTVERWFocHlySkNM?=
 =?utf-8?B?MU1yK2hSdmV1dXlobG1zVnB0Skg3cjBYRTF1NG1wdnlkUGsvaHVNWEVSb25v?=
 =?utf-8?B?VnFQY2FGRGxYbGNJeGtzU0hrT3VYakFYZnlmR3VqelJMSkRCbGtkYnRkQmt1?=
 =?utf-8?B?NUd6L01QZmZBSG9VaWFpZzVFbllFenMvV1pDb3NQZmN0SXRxSnNleUxyWm02?=
 =?utf-8?B?NndLNmhqSU9PRC9DM005bGdVVlBkSE0zeWZKQTFSaTFXWGNZYm4rZjNuaGtV?=
 =?utf-8?B?bnh3RU55ZitiaTVpRitWM2VuTEJUZXMxaDRNNmtDVk1aSk5mejFhNmRGU0or?=
 =?utf-8?B?c2tISGY3OGJUUERMdUJxZHk3bVRtaVY1emNhd3kvY2MvaEpsY0xLQlVLNjZ3?=
 =?utf-8?B?US90dU5INEVwNlRkTlZPWEMzTWpaWHJybmRJTUtRbjJNRmNNUmxqbkVnREw3?=
 =?utf-8?B?cCtETmxVQmQ2V2dkdFZCUXlDUlQvNzcycmREK0tnaTB3b1hlUzdlNmxpWWUr?=
 =?utf-8?B?eWo2ellQR0d1MXIvNHVsQVhrQVM1QnBGb3VVTTkvUys5aXVlcXZIek5RS21s?=
 =?utf-8?B?blpJc3VQQWIzaHNUNTNFa2ZUSE9QVUpCTjJ2bjVRem1MUXRxZ0ptTnZGdkNT?=
 =?utf-8?B?WGRua05adFc5U3BDd3pmWlZSQ0F3NSsxMTlTQ1ZqOG41VHEyL1QvaVhlMUox?=
 =?utf-8?B?dURleXFTVlVVYk5hdzFHM1pJUmRQc1FsSTk3d2VLV3FFTFVnekIwUzRnd1ZV?=
 =?utf-8?B?dzFKbGhHczBvRVJuKzg0bkpEL25UUTkvVXd6MnNhZ21PbjNJa3IzR01tVDZz?=
 =?utf-8?B?NXFrYllmTmdqMzZseU9zaHdPRFdiQUVJd0FkWWZpYUVHTjlCUW91a1pFNE94?=
 =?utf-8?B?UFpuZFpkRmZQSXJLU0lqN0ZDRGxSMytKL2JjRWRqaTVSWmUvSFdLbnVyd0tQ?=
 =?utf-8?B?bEFJR0hzMVhBWmwyck9nUXFpV0VUUWt0L1lPZmhHVFVLd3Y4ZnVIQXZMa2FQ?=
 =?utf-8?B?RENKaTJKcFVFTkdQQWFwdWNWSU9PdVZ6M0hZcy90d2U0ZXRaSHVvN2h1NEVa?=
 =?utf-8?B?S3VyNUxGdUpOR0R4UUtxTXhvWFFaT0l1SGVZbmFBbytMNGJqK0dyOW5vOHhy?=
 =?utf-8?B?STAvelZzeFdWRC8xZUVvSno2YmoxL3FRbnQvRGNYa1FHWDgySTJrUlVkUUJH?=
 =?utf-8?B?VUI4dy95eGVycUpLTFNoWkdOQ0FDcC96VkR6bzZaK2UranFpUDVTaGVOUFB2?=
 =?utf-8?B?aDJVaFJkQk14aU5objRxeGdTK0RWd2hhcVpMZS95aFd0eTJyY1p0OFd1S0Jq?=
 =?utf-8?B?N05aaFc3VjVVTkkxZjlhczkwRDV6TnhTdTl4WmJrZUNsNTlNUnVMaFpQeFkx?=
 =?utf-8?B?cGoxTzZrelMvSFlYZXJRQ21DY1l5UldQZHpHK2ZHRE5tMEpnblBtb1VXeGhO?=
 =?utf-8?B?S0NQamtjaTJoaU14Z04vcEFxQm50UkZmdU1nbVcvWklPYjcydk02WERUQ0VW?=
 =?utf-8?B?R05DMzRPZXZlUlNEVGttemlLYktSMTZIMEVJTkpES0FpVnVnUmNadUZSTVdn?=
 =?utf-8?B?STZtZzZhTEg3eko1azNoWWtsSEhrZHFsVUY2ZW1kTXJBTkNhSGd0anhlU1hy?=
 =?utf-8?B?WUF0UU1xUXF0NlFUdWFUNVNGdVJZOWZveE9lY1ZsRFZFS3JHdkNPYkFneFFn?=
 =?utf-8?B?UE5pM1JLVHpzNFF4NU1YeVhkZHdyNUJVd3VqWDc1cGFJQzY1V0Q2MGhDR1kx?=
 =?utf-8?B?R29NMTZBZDVEU2lTM1FaN0RXMW1QVk5hQXQrSiswdXRLZ2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTF4TWc3U2szRlZmaE96QkFjTmxQcDJMNFl6cmNNcUxnTDI1SmIvS3lGdXVF?=
 =?utf-8?B?bzhHenlGWjRSN1YxaDdRMTcyKzdNRmd2SDJ2M0lFR2ZZWHpvRHVubXd2VTRz?=
 =?utf-8?B?ckhld0VsaGlTL0JrcVJveFZxZmlMS0VuS1ZvRWlRT1FkMldHVjdSYzBFbWJX?=
 =?utf-8?B?NHFKbXc2RGNleDdKQ2NvdkRaVUNackd6bjBBZGR5Wjd5ekxTWnR1b21yK3Bi?=
 =?utf-8?B?bjNzSk43MHNMZU1iTE1DQ3c4WE5McFdXOTg2aU5hWWJBdlkrR0d0cklieGt1?=
 =?utf-8?B?ZzF3TFJEWWF5ZTFRa2NJeUdJMzJGMTEvN3BRL0c5UFRiU1VoUC9TZXFobU5i?=
 =?utf-8?B?YUhVdDRDcE1kSExVMTJqRm1xMTFSRzlrUURrZkVoYmtiSUdPTnlYMXlPZHlQ?=
 =?utf-8?B?NFNBMXB6TnRaemVZbWM3T0dzK3dVdzBaVEduZUlkZGFoZE03UDBsN1FqaWMw?=
 =?utf-8?B?YWFYZG1rNjgxS08wOEtyVSt2ZytaUzVmQUYxTDJyOTdCZHZ4emxCL2Q5OFhw?=
 =?utf-8?B?cThOWmE5RDFKV2xXREFPU29HZEI2aG4xY2xNQ1N5ZzFCY0xVQXZtaGRnemRk?=
 =?utf-8?B?UE1zYlVoUmt3ZG1jMUlwUmFGejhaZFl0MXpNSlQyR2ZocTFaQUFyQjF5em9E?=
 =?utf-8?B?SlB3Si9Hd1NlN2lBZ3NXOEpRcTlJUUpPMm9tOTdEWFZ5clg3V0M2REVtK0ZM?=
 =?utf-8?B?cStRRDcyaTBzQ0o2S2Y4bjZRMHJOa25qWmQ5TXRzUzhEUkptMk9WZXFIYkxF?=
 =?utf-8?B?Vmk4QjRXVER4Ui9TdHdrZmpNLzhjQ01Eeklzd2JaaSs4ek5aakV4ZFJFdStj?=
 =?utf-8?B?bHlOUmttdkRYalltM2FUdDNrYjJoaGY0bTVYdGVXRmxmSHZhM1I1aVRvZklj?=
 =?utf-8?B?b0NuT3ExaXhUM3o0QitMWXlRSWNMczdpdkxkTjRkbG1qc3Mvd25aRUtWb1dQ?=
 =?utf-8?B?S0x0QWxzTHg1cDhGYnQxeld0ZW5JZnhjcXZYMkkwQ0pod203Um82YUtyV3U2?=
 =?utf-8?B?RW9VMFA2NjREV1poM0JJU0k5aitHRjEvTWZpcWZkN3JZdUdKcnN2SDFpdDlM?=
 =?utf-8?B?ekxkcDl4TCtmODVzNmZMREdZYWh2ZDhGaDdmWXY2M1Awa1ZnSUEyQ0luVGxG?=
 =?utf-8?B?Q2lEeWtUbXVYaVUxbnVLS0dCVm5tcHBvZnhLcmkwRjdCS0I5am13Y2xYb2dt?=
 =?utf-8?B?YjJsaWpQOWE5M05FWWtBb0pBVXU1YXpmZUszRHRlTUJlOU9YWm0vTzhGbWpH?=
 =?utf-8?B?bmI5L1Z2NFlGWk5MY0ZFeFpnK1M4VVJxWVJjZUJIbWFRNzRrYk1pQjJBZ1Fr?=
 =?utf-8?B?R0ZNVE9HQVgxSFF2SjJua2FYWllqTjVadXlSMEttRHFMVEljc0FxYVBRY3B5?=
 =?utf-8?B?VkpSd1JJU1U0WnlXeXZWUVZYMm5iaWRSTUhqanpUek53QkNrS0VLTU5CM0xp?=
 =?utf-8?B?dWZjS2pUNmN2MlQzdjRNUHpJUktzUEgwNHRHQWQ2SG5qZHdadkNnWU9wK2d0?=
 =?utf-8?B?eDVrOUhUVjZGa08vSkhMNnc0M1lQUDR6NmxhNFNWdVkvM0RHeWVucDhKZGpo?=
 =?utf-8?B?bTlpU2RaQlhDZXREMGx0N1VtdU5LVXlDVUt4Uis2S05aeVovZHlxWW1BNCt1?=
 =?utf-8?B?T05Bc3lacW9wRzJVU21qaWJTeGg5SkIvTWR1Ym5RV0RLNXpqSHR5OUhwUUFF?=
 =?utf-8?B?dkZhNEJHNmkrcU95R1RNaDhjTSsvM1pvSGh4ekdFbDZTa1NxMGNFRkpmYzNW?=
 =?utf-8?B?T3M1NWZKT3M2MFJGUC9UOWw1VXVHZFVoVVZ1K2RuN0RITFZ1OHgzWlBzdDBB?=
 =?utf-8?B?TzBhaWMyVUZoNnFKSjZ1RHdTeWdYZnZUckcvdzdBamQ2Q3JFNHhGd3E1cUpm?=
 =?utf-8?B?NmRuSWxFUXlJOStFdVloRW9xWW1nTlkyUHN4RGtmZncwVkZKUTl2SmJpWWtB?=
 =?utf-8?B?b3hEZS9TZkJOdHJOSVJSczl2bFJGbjAzL2s0eGx4V24wMmEyY0VZd0lFMlpE?=
 =?utf-8?B?TEo2TnZPT0s4NDNFcktNVHNrZC9WMk9JT3RIZzBaTWpFS3JLdzR2WmV5Y0xU?=
 =?utf-8?B?aE5wa2Y2R1NiNGw1VklCSVcrcFFHRlJuMFVudk9mL3Zac1VjOFFzWWVaY3NI?=
 =?utf-8?B?MUF6dCtZMlhOM2dDYTlqUWlnWkN6QmZCQWpwV2dEeUF3Q0tLNStqMFVPTDNB?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a959cce-cb41-49fd-b06c-08dde5741f75
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:15:06.4996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHZKLvHM8Ca71bzpx35KucZcXGHCMXG/6Exn7JJM+/x1PvyBSBsx5iTYEtvqV2xWwrmlmFSZRAvJRG5pfFZPdKiH2UH+773toCEHh+erPoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
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

On 3/13/2025 12:15 AM, Stephen Hemminger wrote:
> Use macro instead.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
-- 
Thanks,
Anatoly
