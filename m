Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD40EA8105
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 12:29:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EAA3400D7;
	Tue, 10 Feb 2026 13:29:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id EC2EB400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 13:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770726597; x=1802262597;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U4pQ1uDROhIEHcx1L2M9UmPAiVN8rIu85Rio42mS7Yo=;
 b=TOA2P6H7801YYDUuLTtwV9ZWtBnrYVzEWQzQLa5oeEt6qjHu0jy/jRJc
 CwmV1meUwiPJNnU5WPmDYwn/Wn+3g25TkPPI+xmkptUO80emDT1f+IP/+
 yyfCFROPRn75g29Cv2AGwNZN1cBxdrxm6MV5IJs331jZ+qRQWSbi9bCHE
 OdYNre+EpxFMRSPqWEgJUiUzNFTjPg4K2qz6KposwIcy+MbId3PFoLd1y
 gLj9TyY5FrJ5NUIqr2LYoMo/rnKyZHgywq34KdVO4wiZvYS+IjW67S+4O
 QLhJLq5gMoWl7wAlohuzL4vH02p9/5OV1/ARjAsCYKoMoCEiUFX0eGQEw w==;
X-CSE-ConnectionGUID: md6+5DKPTEKCk8a2tAMkOA==
X-CSE-MsgGUID: mZ6eZGg5SDGBLjNf+vblYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71923422"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71923422"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:29:56 -0800
X-CSE-ConnectionGUID: z+AYmWhnSrKk5/ucT4cYdQ==
X-CSE-MsgGUID: g0nPJeMTRFOuEqabzIJYvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216422362"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 04:29:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:29:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 04:29:55 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 04:29:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcHqkISslNjWinnLhQIqzVH0tQt70FUft8tHVE9eQ5jsBRY05HC+jTLb9mBr59y64yP3v7ht3bK+rTcjVoJ507dzZHdNZCtFvbV6BaDEFx/S4FSyhM3DDz01/RZYjf0T9U4msPI77gIp8Z2uOd77qcnY8Q3miuqQW0tecHHhqosdd814UV8SwuzJc+srsCYcnowEoyN1lz2YSs4o8LtGJ+X3d5lPOEhulif+8lQ4QcG3zAPgF1YFF4m2EyaWoFhcvIT2agst8nPYAd6QWIfCld+2lN6uz1LiLTM1wlUB/EepHZqh8yPM5IoWHrFwhtal9c33HR3sus9CZESdU8l04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn1i26PyBGkF/deBGTNforyVNe9I98592Ir/jaGUVU8=;
 b=usQuGuOGQYi+buACgDr3pc7yUXI6uk0W1gwTsQ4F5ZeogQ3a/fMR5oUmKrG2N9xFOltchMN5M8bz4xpqhBq13X8MWiWzitskm7nK6toi7jMslzWGyv1/bcWSw+cJHrcSQ1LgQtZiCYWnQUAN9s+iNsR6pcR/RgAxk5IBtth2dQl1aK7G7Bd5dyd8LxGmaXMf6fd+mH61wRmQu8DtzKmgDneki3XFyqUea5QNiA3wVVloqg1meeyMZLkPDQjhIPH5VZmTajtpuwXr7QaCwl4qQu4Pu5C5or87iLALt/hUkqtnof9aYLxOtQFMeFl3b76WmntGRwTM3QbEUrUMxm60zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Tue, 10 Feb 2026 12:29:53 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 12:29:53 +0000
Message-ID: <cab7ff8b-b260-4339-b0d7-8a139b617ba7@intel.com>
Date: Tue, 10 Feb 2026 13:29:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/35] net/intel: add common fn to calculate needed
 descriptors
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, Jingjing Wu
 <jingjing.wu@intel.com>, Praveen Shetty <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-6-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260209164538.1428499-6-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0184.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: b2231c54-6ae3-40b7-a834-08de68a017a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnhBTzhYTG5uRm40d3I5Z25rMFpiUEdlNFFpZmF6MjJtM2xUa0RNRHRoQy9v?=
 =?utf-8?B?WHRJVjNVODN0c0J5M0ZnZ0laM1Bad1ZraG1iL3pNTWY1THpoYmkxMThZUHZ5?=
 =?utf-8?B?VDhwV3hnZ1ZHNWZEemNJejB2OUpJVCtteGtpWCsyYzUrTzVabjZpZTdYaXo0?=
 =?utf-8?B?NXJoeUtDbHl5MFEwczlPM1hzMWJIMU5SVFVEVGR0akVYQ2FaZnZsUFRlN09s?=
 =?utf-8?B?QSt1anhCS0lURitvZ0FVZEVudGZMYVNYSzF3ZjVHVndaUFNOeU12TzhBMnV1?=
 =?utf-8?B?SXdxNmN4T0dwSXQra2cyV2ZSaUdKUkY1b3hocFd5bmJ5VWlxQzRhUDV0NWM1?=
 =?utf-8?B?dUZqbUpwTGVRMTVEcFBnOFNmeHlicUppa3Fqdk10VmxmU3FZUnFrYUh3bmV4?=
 =?utf-8?B?ckZTY0xKdEtGa0NOT052T1pMRkNwSmtNZ2lDR3A0WTNsS0U4RGN6R2loZFFB?=
 =?utf-8?B?K0xZWCsvWWdUOFN3THdtMVNZVWV2RXk3cjFaa25UdGFpdHlCRkJSRTVPY3NR?=
 =?utf-8?B?K0ZqaVRVbnN0M1NoVko0Z2VoRlNvN2NQVjhJTUJEb3ZibHpUOVBrZFZXNkly?=
 =?utf-8?B?U1ZGZi9UUkhnL05BbHB3R1VJa1htU09BOHhaR3d0UU9ZclBYeUVnTkI5MEpu?=
 =?utf-8?B?MFJwQUxMRjZ5cGR2RUIxNC96cXI3SnFmMHRXdUsyVGlzYXFwS0ZwLzJ2WDRX?=
 =?utf-8?B?dkdyRnVGcGlocENlNUsrMkdFMGl2Z2xUWHlYQm1Yc0lORG51eHFVTGNWTm12?=
 =?utf-8?B?c3hZTHBncFVUK29sanJtVk0vTEY0OVBkUWhKTTFFTlBtODJENzArR3B4MDVQ?=
 =?utf-8?B?N1NQWThQWkFoUjBpRXJwa08rNkF3TXRKdVU0cFA1a0RSVkJta0tBNFd1clYx?=
 =?utf-8?B?MnVra0VnSFZ6aElibTAyalFDemp0TENTRDZHM2gzZFZQNDVlU2hKWmRTQUJk?=
 =?utf-8?B?ZDhmZVppVHV6R2ROUE1vNUpUVUE4N1hEMzJhTUIyei9scDBUakFxSFhpWE94?=
 =?utf-8?B?L1NhSWJGZGpzVFFrbW9CbTR1Qk1nc0ZDQ0FGRm1FNzRVbUZnNHdyTFVvZ3My?=
 =?utf-8?B?TVArbXVXYjJnSU95YUxhb2JYdVdWUWhzanI0K3EwWFFNOVZ1aDFVNDZ6eXJN?=
 =?utf-8?B?TVlzV3hjY3lXM2M5ZVJ6WGNlQmxOTjlVaS9MRjNrZkt1aDJwQVlYUFNLTUhy?=
 =?utf-8?B?cHRXU1NNbzdxSlRDMWd2S1ZLYzJCTXhCRjF5b1BVSFpRZW1lc0tBeFlZNTkz?=
 =?utf-8?B?NHdCa1Jkenl1bWdOcUFPMUxuU2hpRzJISGhwM3A4bm1wOVNtZVUwOU8xYnZW?=
 =?utf-8?B?VlF4ZEF3Y2RPQWNiKzZCaEFXMDk3SFk5dGlCMFEza3BlTU1HYWhRbnpiSFZM?=
 =?utf-8?B?eHFYcHdYdzdrbHJwQ0ZiZXNVR3VsRTB6bnBRVjFxcmE0NWlKYzQ2Z1MxQ2oz?=
 =?utf-8?B?YXZ6QWpTUlE0RTFUeHBxVG5YVGxBR3JVNE5UbERmZzRPQkUzNjBkdVVrelFp?=
 =?utf-8?B?R1ZtL0FqengvSUZGaUFHc3hpaHdnN0wvZnFwMytLRE1rN29MNndSVW9SeW5M?=
 =?utf-8?B?bm8zT2Y1VXF3VXRFTjRtM095cUNmeko3YloyTEFLa1M2M2JPakxJdFEyNUp4?=
 =?utf-8?B?bGsxSUZubFczNTQva1BTKzVHQnNKZm1MWWxCU24xeWpOOTJTdFdTMFpIZ1Ro?=
 =?utf-8?B?OTRGNUdSODQ2NDBwZ21HclBmVnJ6c2MxVGU1RGp4b01qczBsQWNFOUUraVhX?=
 =?utf-8?B?SlVJcGpYQjJBTEhoUGVsZ3VqMndnRE9VMVowN3EyNDBXc3BpYmkzT2RvNW5C?=
 =?utf-8?B?d0FoMmdabFhWMlpYRFRwNDZvQ1VoUGE3d2NpSXA0RENickMwbEpCbTkwaWdk?=
 =?utf-8?B?TzhqTnh5UGxyK0Q3VUVOb3FGN0lpNEROenhLYmMzN2lMR0xhM2liRUg5U1A3?=
 =?utf-8?B?b3o0Q2FsYUpMRmlyNXdza2RLcXRYZmZ0ZzdNWG9vUVpkSTU5R1RkOEovUmYw?=
 =?utf-8?B?WnltcFpSbCtQZFlzZVNOWHM5YVNnVlFIdHFxelFVa2w2Y1pYd2dvaTk2VlRR?=
 =?utf-8?B?MW5KeU1vMGtTTjd3WTRZdHBYbWs2Qk1HTTlQbk5vT1BxNTltcGtBb2dTMUdj?=
 =?utf-8?Q?TzKA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUdXb1RqcnVwZkw4TFYyU2dJTkR3WU9sNHZmQkgrOU1JdldJRyt5a3pRUkpM?=
 =?utf-8?B?dHVOR0JjbElXbWw2NnlmTHVxNC9WM2p1Ym1NdXE5VGZFVlJrTnZXOGFQdTMx?=
 =?utf-8?B?R05EMDJteXVnMFRzQ0JuV2tmYzdJUjdOZkJBcHIydFRQVFNhZDdqcy9pOCto?=
 =?utf-8?B?U1NTRGdxeFlhakNTcnVMUkFsenVlRWp1YUFYeisxcUlMUk9QT0tLeVRsWW9t?=
 =?utf-8?B?c2N0aTRSdktEa2R2ZmFDZGQ3eFBFeDRDQVJ5QlphR0JIQWtUYWEwa2N2NjI1?=
 =?utf-8?B?R0xxTVFHdG1Od01kUHVLaUc0SXZiQVpBSUNRMTFmOXo5c21WbTh5dXN6Ulk0?=
 =?utf-8?B?cndyb29GWmdKcnFKYWVxc2dEeWFwdmNMaE9iQmVQclMreGZRNTIvaG1jQzND?=
 =?utf-8?B?emh0V3VaTEZYODRqdEl1eEFzbVd2SW5wYzh3QjY3cmxPU1FQb1hMMFl0S2RH?=
 =?utf-8?B?MCtjalZpYWR6QjZyT1daVzAxSFBpTEJrbExVU3ljSnlUZmVhQ2oxNkxQK0FZ?=
 =?utf-8?B?VnFoRGYrYmt0RGhHeEZuckxCdnVWNXoyZ0o0U2NaWCs5cjlnc2FWdHhaWURC?=
 =?utf-8?B?dkl1cHpodTdpQXlXakZDNzRZYmR5QjkxM3lSRUZFREc2MU9STjZaenp3RjlQ?=
 =?utf-8?B?QTE4NytEZzFFWnF4SDM5RkRvU2syUm1OWWdXMmNmWlh1VlZqVm9DV2VCb0VS?=
 =?utf-8?B?UTFqYjIvcnlKSktTTS91SXdJYzYwZDU2dHNwWTRzczNVOTNhZkRzeXArVDZx?=
 =?utf-8?B?VUZZQ01yNVppSmpYazlEREYraUlvUlVTZlZLbEJtMlZJVndNaTFiTFZDWi9S?=
 =?utf-8?B?eTZFZEZHcWVHOHZJeTFaa05udVBYbmFtSVlhZ0pLZE05NDRYQnVmNTYxZitn?=
 =?utf-8?B?YzJHL3pweFBSYjJwR05ySytORWUydWtISkMwaUpXWkZOUWlCZm1KRGcrSmNk?=
 =?utf-8?B?bWxvMDgzdmZjQ2w3Wkt2cTBPZkJOLzBxZGgzVUJOcTFwclNEM2c5WGhWRjEw?=
 =?utf-8?B?OE1mWVVEdno1RXRvYTVtWUQ1Y08rVHI2WXJDbDl4VmNqbU5Kd1lzUlVFMlho?=
 =?utf-8?B?U3hIOUZrYzlJY082WHRkclBzK2dWR1ZUQnNFNjAya1JzZkQ1d0RmL0NWOElw?=
 =?utf-8?B?NE1UWnFxd09lckE0K0loL3pOTWhoTzN4QmQ1dWdYOG5KejFHL0dSMm9rb3l2?=
 =?utf-8?B?YTFMamJ5S0FqRWw5SysxU2FsbUt4QVFEY1RwQVZZZzdlUVRqMTlnT2RPZ0NC?=
 =?utf-8?B?cTI0YzB3YUVxVWpSYnNpckxFcnVhdmdvVVErWHp6SzBWMDNiSHRnZVdmMzMw?=
 =?utf-8?B?V0pwM3M4anMxbnl4bzBSb2JOV3pueDVGOU55ZituM29TRE1pbFlZZXNKTW1a?=
 =?utf-8?B?WUgwaWZJa3hRcHlXTDFvTXF1bnBWeVRhaUZFZ0JFVko2K3VVTWxzc3VTUFBH?=
 =?utf-8?B?Sm83ZUJPWVRYbmhyWk1WbzJpdEgvYVc4ck9NaHQvLzVGNk5VamhRUnJ3U3Yv?=
 =?utf-8?B?VWhVZ1pDZVhvTFh2RnVIK0dPd1Y4Y0UyZ21iTU5VMi9Rc0lrQ1hhRm5BeGJ6?=
 =?utf-8?B?UGZFWEZuWlBHUUh4ZE1PTGdleEFhMU5MUjlRVTVCWDJxZ3NTamZVY2hyZ2Qz?=
 =?utf-8?B?WTF1NHRvbHRlQ2ZhTWN0bU9MQWs1RmtKS2pieVZXME5XYzRxY2prcmlPQjlo?=
 =?utf-8?B?SEZJSmxYd0NVa3VsWGZ6U2VvTTRic2owMU1BZU4vNE0vektwOTBXV29GZzdz?=
 =?utf-8?B?YjRYS1ZPc3MxSU9zaXhFbVo1WmJaUnZsYXRtZHV1NTVHc1BJZzJ2MloydlE3?=
 =?utf-8?B?K25ZZ2h4SVNad0ZOZ3dHaXRoWGFsalJ3cE1iendiMmRuZmdkMHhkVUFQYzNM?=
 =?utf-8?B?T3E2Z0ZBZUc5R0REM2hLcEg0UzZQdmFRRk4yY0YySEhZYXdSSTZidmI0emh3?=
 =?utf-8?B?QTBJc3BWTGZKL2RCNE9CMWZqZUJDcUtKTTB4cVV6MWphOERvTHZ2NVpvUURu?=
 =?utf-8?B?bGVwaW42ZG5ZaGk4TEZIODcvamRVUXZXbXhCa1IwK1pTYW4xeVIrSGgwWWZU?=
 =?utf-8?B?VjhoRU9uVDNuWVBFS094bDFSOUZrZVI1ZmlQa3k2L1VYWlJVRTZwVjljMHVZ?=
 =?utf-8?B?R2lZUTI5a24rNkFjeEFBSVBwWkFmRmJvb3hxck9LeFl5Q3pydWY2dWZwZUt4?=
 =?utf-8?B?bTdrRGlmTXl0WSt1L0NNakF6YkJIbDR6eTZCVmcydHdIK0ZhcTJrbE5GdElF?=
 =?utf-8?B?bG5lTDZRUUlTUTk0RkdlRURSUytoRzZYYmNzckRRbW9ndVM1VmxHL0orcWZT?=
 =?utf-8?B?YjRPRDlnTDZTcE5FTHNuNTZiaVFCMFVrN3h3aGo3V2VBYVNzV0NRczU0Tkhz?=
 =?utf-8?Q?jtHZBdkVZDkBcTB8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2231c54-6ae3-40b7-a834-08de68a017a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 12:29:53.5551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NSp6qikAYdGlBclT6jxTlQ7yKC9XfRPgysaIaiYpNBtm+eCTD9s4wXORLyWjoyjKCqw76WvlHsNvGE5Kv2R7dl3BpTy6/7vXNjDmEfyYJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
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
> Multiple drivers used the same logic to calculate how many Tx data
> descriptors were needed. Move that calculation to common code. In the
> process of updating drivers, fix idpf driver calculation for the TSO
> case.
> 

"Fix TSO for idpf" sounds like a bugfix? Can it be backported to stable?

Otherwise,

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
