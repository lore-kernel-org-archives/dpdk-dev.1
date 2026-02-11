Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A820ECD6C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 16:06:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79D1F402AB;
	Wed, 11 Feb 2026 17:06:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id BE33640297
 for <dev@dpdk.org>; Wed, 11 Feb 2026 17:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770826009; x=1802362009;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=6k4szBZW28uQPwW+AHJUJdGrEj+0xS8VV50tJIFuSss=;
 b=A2p8f/0HQpZLxojic9+lP5vrkYIwdh+bg/qMYcqHFOkJUJgi3Mcn1mtH
 c8rSKd+7MGvIw6BkRSB7w9q6x+KzhtvF0Lxs55Eh1LfTFC0T8BYYl7E/V
 uJd4Aeq+K/ZyhNpmX3kKJ1/qUsJ1rTyQU4Sf1zimAFrwQxZiPUylzROFU
 MO8a3N23IaJ2kjkPnanPFI3ow9b++8YGLizn+J0ckOe4/U4WVZh9N2qAE
 IrFFFdVk1s4LQXej1xzU2NpFpw+F4mLd5v7QLCVQwhGiaO+pUqkB6tex/
 U4UOW3NMs81PP5gURA7gW3Z5cdAPnj71eZgSpO070lAI4GfWtAJY3MHPs Q==;
X-CSE-ConnectionGUID: ym3mPzzbSdejkoGydsZsyQ==
X-CSE-MsgGUID: n5upkkvSQHyXC71xWuYNCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83421123"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="83421123"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 08:06:47 -0800
X-CSE-ConnectionGUID: MQRlcZE/SIy99OrUC6JhzQ==
X-CSE-MsgGUID: JD9yNiN7QLOVU7poEiqyEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="216797336"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 08:06:46 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 08:06:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 08:06:45 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 08:06:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nweb3gxYvtK5lEPSnU6aDhBtQnJKLezrq3f4e+gmMKajGtduIbVlLKn1v1k2Ajxc6w+DYVJGVNcsyiqKVffn1pvJyaUPx837byK8yCXPJNG5g55hgwkk80C5dNhFwnPT+ytbKTIW6CxKDkUEfrMydiLE5xtuExwz/+RffgrKxxLWfg4y0/scZlI868eu6gOk/p7VoXtz7uJR+93QiTlwbTVUvucb/Mens0ZQXOcxAibtOaFR2ABNYSczkiQ69SnZjtjmI2iE91Y22rNXoCOIBjRZ9XXO3r/y4JspbdSjhnxFNWMwfTzy47Ytl3GD4fuZ6NF10z/xMHQdOgBeI3HsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipc81XW30hNjcFJuOlwZeRfSu3ZzVwsmRT+YbYjxAH4=;
 b=nAqo3WLHrpvae4AlSJRvL2OKrQ9eMYrI6AwpbI+3AjpQhgXizEgFma3w7FGdWamTiIZ0IaKTV+UdKy9p8LqgpkYqtYAgzhmkcJcfwJo5luQ2OfCigZUOBJ/zreP72UibQNvJ8Y1WVZZ3eODxCNxVpWhj2hE4gscQiIXxS8RnZhE59SpjKnxH3/psKIrF3Aq5Dimr1amqmCTp7peTX3K+f2XIPeZ95sUgKmAGUwLU6l3RTnwqC6iRbm8TGhi20AU5PEHUIJunc83r5wESmO0pTmWL61rqpZdRjbTumJPai72Em0vSnz9KtZkgFHRuQwrFLCO0pjTDKJqIX4LEb+PGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH7PR11MB8570.namprd11.prod.outlook.com (2603:10b6:510:2ff::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 16:06:43 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 16:06:43 +0000
Message-ID: <af459cc2-2fbe-43ce-9d62-881ec6a11cde@intel.com>
Date: Wed, 11 Feb 2026 16:06:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] net/ice: fix memory leak in FDIR flow parsing
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Junfeng Guo <junfengg@nvidia.com>,
 Qi Zhang <qi.z.zhang@intel.com>
References: <cefd2925e79387e684ddf08eb154f2fd7ad39b5b.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <cefd2925e79387e684ddf08eb154f2fd7ad39b5b.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0230.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::25) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH7PR11MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ffda99e-b3f6-4384-02cf-08de69878c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkM0T3RYNEZISEtzdHJmZUhJM1N1QUwwa1BTN2tDRTNwWFBlMkcwcWZ3WXAw?=
 =?utf-8?B?ZTJSdTN3Wk8vZlhiU1pBTUJjTDg4dHBiN290R1VWV2t0TUVsTkxTcWIzS1Bo?=
 =?utf-8?B?ODhPQXc5cWJwaTRqbS85RStYaE5WNlZvdVF4dUdabGRIZVJzeUpxQXl2REhG?=
 =?utf-8?B?WU9LZklWTGpGVFlSTzNrdVFscHBqMFRtMXZrZ1pub29HN25tOHJmNXBBUExZ?=
 =?utf-8?B?bXJXOEJoVlROV3dhT3ZrNzQvR3UvMTlValhvQW1pYkRNcW5CQnQ2OEFVZWhY?=
 =?utf-8?B?R1NtWDUwY0lBNFFpQzRiTHNNNmd0YkhTeTIrK1FlTGEvV09hUUZ5N2UzYmpE?=
 =?utf-8?B?REYvZmYyVW5mOCs5cGpONER2MmNjNE5hTUM5OWg0UzYxYUxrRjd0UStrTmdI?=
 =?utf-8?B?cDRZRDZ5LzdtQWN1YVkrR05ia2EwVWV6OG5VVFRYUEMzeFhmSTc4WEJmRld1?=
 =?utf-8?B?SHZqVkdLWVFUb1JyVG1IMDdCaUNCS3ZvYlRvRndnV0MxN3VTUU5WdG04czJt?=
 =?utf-8?B?ekxPUThyOWtWY2FoRjV2RXFkS0tBbTI5Wm1SV2RjMW5yWXdzSyswYnpRcFJt?=
 =?utf-8?B?ck50SXJQL3NWT0N6NGUrUmR6d3RQeEZMaWZVQ2NSaGJhMWZ6QU96Q0pGV0pE?=
 =?utf-8?B?RXhrYUhyZndBQVFMRXZkajZ2dG84SlNZdDlhOHJpVUdxWTBVcUprVGdWaDR5?=
 =?utf-8?B?cW9BcU1RVXE2NWMvbG9MdXliUElTYnJkWmFRdkE4QmVwVkJSOTFBRzk2STNh?=
 =?utf-8?B?YUs1aW03T3ZTdytDbWRwUHY1VFI4Q3BZK1Rnb3dWU0laSEU2akx6WDhHYmpu?=
 =?utf-8?B?VG9hSTg2cUcyTjdyZFkxOGhIVkRlajFhUG45WFdtYldGU1dZeU5uQVZBOW8y?=
 =?utf-8?B?Q2lwR2FOOWRJOHkyT2U4SnkweVdMSmRudFd5RXplNUpuMFk0UERYK0cvOWtv?=
 =?utf-8?B?RnFqS2oybWYvMVhUZ0xjbUVwdm1lQVc3bUVDMU0vY0JINkw4aTg3UnVaNCtS?=
 =?utf-8?B?MXk1M3ZHWHRVM0NVa0pXbXNwRmhwMlY3aGJOVGsxZHA1cEF2Um1Pd2lkaG9j?=
 =?utf-8?B?TTYzQlVObVhHeWdkN2NZMWd4SjcxZ3o5MTdaOWpUa2hOSXo1ZlVRWm5GWnBW?=
 =?utf-8?B?NUh0bkNRNkdjb2ZqcEUwdTFHUWpnU2FXRUJXWEtvRlJvM29PZDZEWnNVWDkr?=
 =?utf-8?B?dEE2K1Uvb1ZpTW00R0N5KzdFRHo2WEh1b0FCd1dqQ2hNMTR6Y3F5Y0RsMXg3?=
 =?utf-8?B?Skt1ZC80bloyendiMExGR1JMdzdmOGFtRFpOUGJUNGRXVGRJNVpxc2hITHkr?=
 =?utf-8?B?MnhhOFphSU14TnNFWWhaNHdRQk1mdFp2d1dkSnJDTnJXZU1QeTY4WDlheEw2?=
 =?utf-8?B?THJkRG1UakIwS1EzVHlQYkNjd01QTDcyNlcwZEdLelBkWnNxV0M0UmRFb2gz?=
 =?utf-8?B?TWo4OWh3dFpSclpNYXVtK1lGS0lOUWZlVUJBUkRhVUZCbDVQRW1YOFV2aG9a?=
 =?utf-8?B?M283dnFaZTM1ZXVJWXZoMlNYL09rU21ZYXJXVytWYVRBbVUycUlhdXVZWmdv?=
 =?utf-8?B?ZXREc2NWaFJoUldJWEZJeHFnNE01SVh6UmhwSTFmUXhMR2t0dmpMYUtlMHRa?=
 =?utf-8?B?SmVGZHBvRW85RmxLR1puckpwd293VHB6QVBYM3NqYkdTMEdYZmtvRitjR2Qy?=
 =?utf-8?B?b2poVkVVc05tRDVoSlZDcHBNZXREZ0RkRmhObWJoYllwSUZDNStGUzMxcXV4?=
 =?utf-8?B?TXpOWFpoNEk3WUFlTTBzWk9XTXNCYkh2c29KWGxCMENEMHVkNmNjTHZtbkN3?=
 =?utf-8?B?WHY1ZnJrY08veWZaNXpGcmRYbGVWejNXek9DN1U4UTN3Z3h0ZldXaysvRkpO?=
 =?utf-8?B?L05kWnN5clNGK010TmR5Um4xS1R0UDAyM2dHMGN2amo3R1UzTUNEeHN4M2tp?=
 =?utf-8?B?Y29la2c0V2R5Z005T3lvazhDeEpqU2h5UXdYRWEybmQ0QzZlUUZVMFdtMWZZ?=
 =?utf-8?B?ZGIrR1czSHNzTVlrSHB4cE41QmlxN0FIZDlHSlB5cm8wNERuaTZycVA0aWtU?=
 =?utf-8?B?NVdwZ0tVQ0JacXArc0xCTVBYTS96NDArSTVjdzRFaUhvcER1R0tReTZkekg2?=
 =?utf-8?Q?XJTM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTNOTFdMSDVjR2tFdUtjT2twcGRzUnZIait0QnVwMVFSVVdYYlUyZEliVFZn?=
 =?utf-8?B?SnpSQ2pMd29UMU14aW8vck00L3hnTDZramp0cGg5VnNpSGQrczRpRy9PdGN1?=
 =?utf-8?B?blBiYWcwcUJORnpYREV0aFYrd3dLcExBZzdaaHJ6RjI0YmtuLzIwNStZU3NP?=
 =?utf-8?B?OEVrMGdEMW1UTWJlMDBqemxqNHJTNkRUTGdQcnVTblNOM2tDemlmKy9EMjVM?=
 =?utf-8?B?ZjNCSWFEZWZJVmgxd1lENm1QTFVRVXJrT2l5VUNQMlpuWU9wY2c2a2xmQW0z?=
 =?utf-8?B?MVVmL2RDaVRVam1tS00zeWdNNHhORlVBS2xEMU91QXJoUDJZRVkvT0NEQ2Nj?=
 =?utf-8?B?akozRHVxK3R3OHp2UVJFQkFrdHB6U2h6WjZQTFZKelltbTBpK2VmZ2w1TmlT?=
 =?utf-8?B?OXZGZHd0azdVd0l4Q0R4NW0rM3l1UXVTM3puUDVvbHhUV2dZbDJOdjdkZVpq?=
 =?utf-8?B?ZTlTVTVOY3RKQUt2NTVldTBRREp6RmRTRGF2bmM0OTEyWUFSQVl0bllTVFFI?=
 =?utf-8?B?bk83UFh2LzF2UFNSS0xDZk1IS0lOUmlzSDdPc2U5WTB4MlF6YTBDY21aNVQw?=
 =?utf-8?B?dXk3T0xsalBkeUc5OXVDTzErS2hTUHlqdUtIMG1sbTVRTkZ4Qm5PQ2c3V2l2?=
 =?utf-8?B?aEdTRjRaUEF5bTZDUW5sRnREY2pBOC91aVBaWUpjTVdwbzZKb3dGRXJMQWVU?=
 =?utf-8?B?eTA1Q21YREZSZytuSHhsMUZLWWpJWnN0aXhiN2tLQStwQWxZdlpWdTdVT2c2?=
 =?utf-8?B?aStaUWlaMUdwNThWdXAyYSsvQTcvbm02cVI4by9YYm5UQlN0UnAwcEt0STlv?=
 =?utf-8?B?Wll1bnFFbWdXQzhOQjEvTEhEUUx6WEU4VVFCUlZKNHN5WFIxM0xwSk56dVFE?=
 =?utf-8?B?K3RRLzZMUHoyZ2hkNnFyWGFaMzlTTjdoYjdmWHNQUy9iWUFFb3p3djB6a1FR?=
 =?utf-8?B?Q2lvMmFzRFdOMGh1b0RRQkQwQi9vSHczczFoYTJFbitqb0NCaXFZb1pkeEZs?=
 =?utf-8?B?M0xjd3pkblFNQ0hLMWN3cVRmR3hQR1BtWkhTampuRCsvY1pvQThHY0xVV3VS?=
 =?utf-8?B?Ukt5VnlKK2hNaUxUbHViU1NLMGpHZkMzVDlwYjlZdDI3aVdLNXY4RVhybDlR?=
 =?utf-8?B?SWk1UktlRDRZb1hvdzFtbDdLR08vOE14MWpQK2dBTzdEQUovcnl6RnZHdVEz?=
 =?utf-8?B?Z3RwenUxbGlOc3BsYkdIaXZjVHBWMXJLT2lUeEVBbDlDM0M5T2ZDQWNMS3pu?=
 =?utf-8?B?akpKQ1pRRElmbHA2S3lQMDJjNzVHYXV4NlBNdXYwd3lEa3B3VThQLy8zMDVG?=
 =?utf-8?B?NHZqdlBKdTdQT281YjJScGM1ZmRzc29Xb1Zxczc0Tkw3Ykp2R0t0cmJhUFFI?=
 =?utf-8?B?QnBzbWJJQzBPcnc0NkxnanlnZ0JMZmpOdjlHc2V5dUhCK3J0ckZid2pSN0JK?=
 =?utf-8?B?OUlxbWFuRldrZjRWZzcwNGdDbWlNUXZyQnhRSC9Wd0dsZHQrQ2RMNHBBRndP?=
 =?utf-8?B?S2J2UEhKcExOTEhPZVdMOHFaaGpRYjJZeUpaNmozRUlHdmZEQVRMbjV1bWF3?=
 =?utf-8?B?NzJCOVFXRElib3dPYzlxb0FOazA2UGNHb3dsSDF6bXZySUhrTDVxZ2xmYmJ0?=
 =?utf-8?B?OWFUMHRIeENoV0I4NTdtMVVEMDZFMVZtWW9INjhWZnVGdzZ1a1BzM0tobmto?=
 =?utf-8?B?OXFLUGZIY29qTUdldUdFMVRLSkNRNm9qcHVEZW5ER2oxd3ZWR1dqNHM5NDBD?=
 =?utf-8?B?YTVpZnlTTlkxbFNJRC9OYkVvTkFlUnFybnZYbFZ4REk3NmNQWnJBTTVUUmd0?=
 =?utf-8?B?cnRaRmppMEpoUm4yekR2cVNBUDArYkJuUzljQzJhTC9CR0N1YVF0dUx5MlV0?=
 =?utf-8?B?eWFRcGlHWGtSYW92ZkxYNGkyblUwanZaWU9uMEFMOWZ3WHBLc3Q0WjlSalR4?=
 =?utf-8?B?eTRYUHBIUUg3NkxlQWRrZkJjdWRJSG1Bb29ENGk3c0g4bkhGRTN3M0cyQld1?=
 =?utf-8?B?MU93VGlWV0xUT0pnSElzUFh2Q2pyWkM3M2VyVVR2Y2lUUDBUWjQzWTMxK0VI?=
 =?utf-8?B?amdYbDM4RStiOUR6WVh6bmhFZ0tNcTdYYVVKbGtaTnF4SkxjMXFlNFBxa3pM?=
 =?utf-8?B?MCtIbnZ5eURCSlNVY20zcncxQlJoQzliQ3pBbDVJT250SEUrd3BHWVVrRGVN?=
 =?utf-8?B?dFk2UXNSajZUMlhDMGFiYjZGdVVBMnVjdXNQaWFlOEFBZzZxREl5dHBYdXBC?=
 =?utf-8?B?T3d6OWkwQ2M2Y0JBWHlnVjlCV3VESWc2MHRWNCtOMGdvZGNpMnZRWEFKNnJq?=
 =?utf-8?B?anZDSkh2ZFViUzJHTHFSVXVzNlFwYWZ1a0UyRXdaWDBaQXI3UjRJVjY5SUlR?=
 =?utf-8?Q?KvbGMGpwDI+RXY1g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffda99e-b3f6-4384-02cf-08de69878c34
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:06:42.9090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cp77ChRWJgUwabtkBzR1f6boFHME1ggHaKzf8SHvNbAKb1l5pmcH3yTpAeVsp1a6j5Q6KeT+AwAv6sAT2onbLZYCyhv0HdekUDwee5kOvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8570
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

On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> Currently, RAW pattern parsing will cause a `pkt_buf` buffer to be
> allocated to store parsed RAW pattern bytes. All error paths handle the
> deallocation correctly, and the buffer will then be passed to FDIR filter
> create function which also handles the presence of the buffer correctly,
> and it is also freed correctly in destroy function.
>
> However, rte_flow_validate will go through the same code path, but will not
> call FDIR create/destroy nor even store the pointer, because `meta`
> variable inside the flow parsing function will be set to NULL, which will
> cause this memory to be leaked (and memset(0)-ed next time we try to
> create/validate another flow).
>
> Fix it by freeing the `pkt_buf` when `meta` is NULL.
>
> Fixes: 25be39cc1760 ("net/ice: enable protocol agnostic flow offloading in FDIR")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ice/ice_fdir_filter.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
> index f7730ec6ab..5abdcbac7f 100644
> --- a/drivers/net/intel/ice/ice_fdir_filter.c
> +++ b/drivers/net/intel/ice/ice_fdir_filter.c
> @@ -2497,8 +2497,12 @@ ice_fdir_parse(struct ice_adapter *ad,
>   	if (ret)
>   		goto error;
>   
> -	if (meta)
> +	/* if meta is NULL we're validating so the flow won't be stored */
> +	if (meta) {
>   		*meta = filter;
> +	} else if (filter->pkt_buf != NULL) {
> +		rte_free(filter->pkt_buf);
> +	}
>   
>   	rte_free(item);
>   	return ret;

-- 
Regards,
Vladimir

