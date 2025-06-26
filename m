Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BC1C7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 09:31:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 395BB40156;
	Thu, 26 Jun 2025 11:31:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 702C5400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 11:31:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750930302; x=1782466302;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AWt7dflWPzGAb7FXBvzFKv2p00SOvjG78FL/EzOfAPg=;
 b=USq5iLSqGt4AHZn6HR2E+FgXsICLFjP0O2+F2g3PNumxCLsOMRg132Ql
 biSdtzj8foDnJkJSMbSX5ULY+AsEaPbF6lQjnzyLCvidSXEyW8e0d5X+g
 tNK9oNq1Fdkh/iKldZNNoJYCqOjNblWeJ9Wf6v+U0VUOLE9WK+IUPUhF4
 bKDBW+n2RgHWsi/HNU/HTH1kocym9o7ij5yk7Mkb+9Ca8EIs5zOhORKfr
 JMXsS7BAe1Itg7lzgRD9B+eCWkVBC0ww1gJ0vK7dLYt19rlCZ8Tweep+P
 hv++gD3IwDXXne/gnyFD3Hmu11+ZGZj/7z4Erh3E6tHnrxDMO/5yIHsMD A==;
X-CSE-ConnectionGUID: 4CFxudnrQyCK88ng6egXEg==
X-CSE-MsgGUID: IIii0hLLQyqiaRqXGHA9Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53351640"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="53351640"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 02:31:41 -0700
X-CSE-ConnectionGUID: 2lXhD7OcSze1GSD5Nfotzg==
X-CSE-MsgGUID: Oj063qHxQn64RY5+wDRR7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="152587258"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 02:31:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 02:31:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 02:31:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.80)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 02:31:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4P7fyjACBf017LWk8Lryw8QHdkzDsKS8NLE1xVOeR0ml9Ey5HagSVfQAtrwvxPPSHjpPbp0T4QK2E9iyLQ1NPvo7FfNYYPSVxUDbP8Vjgk5RkTwll+AHmXU3L/6/r0hQEGaN/s07wmrxooC97uaemgOtcKHUlD9stMdTehRq3iyUrJnDYw42snZ16cWevt163TlkiXTJPmolMsWx5zevPqLdm4xWOicrlSLugOdfN1QXV57pc9HnjN8QbdFWK3H7YyUz0kMp3JUjNAW4y3XqeDDYf/D8JcEfkwobMtD8riCMQfbqGjh0uyV10eSUpD2IoOzOk0vfdZM1bAcEwJ38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWt7dflWPzGAb7FXBvzFKv2p00SOvjG78FL/EzOfAPg=;
 b=YdntN10ntD+T6fpQ3CHFihuXYpVsAOYMMYbEe4p/ytCH7Fy9ubR1YlmBGlCr+a6LvhUkV2OLRKe7zevPznmSAuDR6GmvHTDUj910bOq3K9BIn50juqPSZRBbVLUfoAcbX2dfyp41Qn2QTQJvyCngMqg7q+AiOZLA4R0Wcpp/4PQur4hisYMC515sSNlAPOOtzm+EOVF/KIq2yuZ7KkcaO8xpZKz2xVguHpH+4Q19cqFxEVQ3BQL6x6HCnGtxDx0WK++HrK8woieLS7g6kg0mpTWQ89pIJcQEss5RfyaPH6BK/ORLy+cXcj+tQZnLwiIw8VypwULZmJFF5JOG0R//dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com (2603:10b6:f:fc02::5)
 by SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 09:31:30 +0000
Received: from DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::ebe9:c1c9:bd2c:7051]) by DS4PPF00BBED10C.namprd11.prod.outlook.com
 ([fe80::ebe9:c1c9:bd2c:7051%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 09:31:30 +0000
From: "Xu, HailinX" <hailinx.xu@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>, dpdk-dev <dev@dpdk.org>
CC: "Mcnamara, John" <john.mcnamara@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, Ferruh Yigit <ferruh.yigit@xilinx.com>
Subject: RE: release candidate 25.07-rc1
Thread-Topic: release candidate 25.07-rc1
Thread-Index: AQHb2z1ZnZRpiTzij0uW9/jdz1eKSrQVEIjQ
Date: Thu, 26 Jun 2025 09:31:30 +0000
Message-ID: <DS4PPF00BBED10C0A1937CEE1A0947261909F7AA@DS4PPF00BBED10C.namprd11.prod.outlook.com>
References: <5554581.qSoW2BAyJ8@thomas>
In-Reply-To: <5554581.qSoW2BAyJ8@thomas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF00BBED10C:EE_|SA1PR11MB6733:EE_
x-ms-office365-filtering-correlation-id: 85aa4bdc-f6a9-4c4c-2c4f-08ddb4943b73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TlhqNkhmSWp6dFRZUGdWVU02NmhqVENKUDNSZk15UExBYkZNU1JYclRmOVFZ?=
 =?utf-8?B?bWt2TlRqWkxZRXdwUDkxdXFGeTlIeUdJWDZYM3NjcFR5SG4rZjh0YzlBZ21W?=
 =?utf-8?B?K09vV0xUOWxaVzNVOXZ3elpCemliMUdsU1NSV0MvVGVGazJwbUtkN292NjlQ?=
 =?utf-8?B?NXpRTEFFYURxNE1oUjFYUmIrQ2Z2YUc2bzJUaXRQYjdaSlF1Y0hJRmk3RUo1?=
 =?utf-8?B?K0lkTzJiV3JSZFpOdTZZNGFSWUlJc1Y4NkJRREExRlNoMVVUbHM1VDd5SkJx?=
 =?utf-8?B?WmJGOUs4NzNXVkNCbHF3MWhoYjczZnVSYU1wWEZFSlQyUmVmeTAzMVFlY2Jw?=
 =?utf-8?B?VzQ0bHI0c0srQUdPUHI3ejFuck9QVDNXSEZaWEpxL0xucGxoZ2JoTXY0TGRY?=
 =?utf-8?B?cTJsRmhYVTRVclZKc0pSK2tiWER0L0ZrekxKZ29KRCt6RDAySTI5OVlNZmp2?=
 =?utf-8?B?amZCNHFpRTNWb3BYejFYYWl0ZmU3dEMxbWo3RFZ0NzcxbDlTbkhkR2dLWTA4?=
 =?utf-8?B?amV1cGFXNDRmS3FtSktUM3F3eFowRVorL1ZBb0JZTjJUTTc4d0IzdDNSS2I4?=
 =?utf-8?B?aFVYVnM1eWsyQXA5N0hlN0VCNlkzSGRlclhLQVVTbEdqRFdLU1cwUmhmRzNZ?=
 =?utf-8?B?N3FKNWpsZlh1WGcvYWZPMExOVndjQ1NobUxlZE4vSEEvblRBRWw3MkJ4Ui9m?=
 =?utf-8?B?NmhScGpSUGtIaEh4Tk8va0NDeE0xTVZkZHBoRXF3eGE0M0NhVitSMHdUSWxS?=
 =?utf-8?B?djFneVFZdzB5SWVnUVRyUU9CSEFSbnpWd1dOdk9TNTRLVGJUNDZMVkNRWWNy?=
 =?utf-8?B?NlVEdlczMm5vaEFJdEV0WFNmbUt0SWliKzc3dzc2TTQ4TGxyK3VpWGJlOTdI?=
 =?utf-8?B?VTVndGJ6eFQ0eW13MkJmN3dRSWF1VVNZWVBsb3g3SWRrYzVNOUw0V2Rkb0dX?=
 =?utf-8?B?T2dqUjF5aUZndWdyTld5MWdxUUNka1RtSXFlaG9KRFo3VjVhWGVZN2dYd05s?=
 =?utf-8?B?UnB6cDYvRVhqWHFHeHp5NGx1K2RvdFc0WldHVkFqWjVUcEJXUS9CR3FiTEwr?=
 =?utf-8?B?eUE0UlhlM0hmYmpGbmdKMlRkMGdZcXZzd2paYm1HUDdLQlZXaEFBaEphWFN1?=
 =?utf-8?B?Nm51ak9lSWExZDFYUVhzUlh1Rk1TOU8wN0lEZHEwU2w5NzNrMXAvOWpjNXcy?=
 =?utf-8?B?d2lxanZ2RDZTdzg2UVMyQWJjTkQxMTZ6bExPclpuL2crVjM4cEdCazZ2U08v?=
 =?utf-8?B?U3hTVTZ0eGVoTFlhS09IUm8vK1IwUFVmYjQ5NGduYnorOTdPY0VqU2RjeTBw?=
 =?utf-8?B?MGZ5OFRNeEw3VkNvS0hEOXB3Z0JTcEIwamJqa2JxREM5S0dhem8yMVVaN0tj?=
 =?utf-8?B?WXJoQlVnckNPUUVGZjV3SzZISEYzZHZpTW1FdVdRZmk3N1NwVVZMQ2RTdUpP?=
 =?utf-8?B?ZTJmbVd2TmhpUkVzcitMUFMvZGRtaW43Ylo0cVR4dGpUTzJVUUFYYWIvd3hS?=
 =?utf-8?B?alg0OVBEWTRmc2pqNHJ4SzVPdzQ3Ukl4THFpQUlKK09oYmwwcGVYYWRMeG1H?=
 =?utf-8?B?N1hyREhnbjQ2UlJLTDVOdFBZZm9zSUxYaTkyUi9pa09LSEVTUHNHK2lpZllo?=
 =?utf-8?B?cTVzbExhVTJ2blF6aHpXT0lnaUVuWEttemx1MXB5QnUyNHczOFNsY0IyMU5l?=
 =?utf-8?B?N29FZHVHUHF4Y1VZbk00cmx5WTZibFR5YzV5TmNXaDJOZjZkSHdKNWg4dE1z?=
 =?utf-8?B?b3piTUhSMkZCWTBzSnZkUVpXYVFVaFcwK0JHREZtSkgyZkZ3dVlOQUhJelZh?=
 =?utf-8?B?eVBCY0xnMDV3RHZYMkFUekhVcUNpT0JlZEYvWGNLSHNKQlJubWNXd0RMVTBq?=
 =?utf-8?B?dnFzVTF4ZzRXQ0laSkJDSk1LREtTKzl5UkRvL1lWZ0tTTXIxTDJidjNWaUpo?=
 =?utf-8?Q?XKGD8i9q9L5sExSAPI8KqtHrB692e00I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF00BBED10C.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFdPSkpFc0swVlZsVzF5Yk1maEF4UVdWTWhEYk1BZHNHNnhuc2xoaEJDVjNQ?=
 =?utf-8?B?ckM4SUpUdU13Q0E3alQzNXZ2VlZUbTc5dGpFYVpBaDJ4MmNla1JXWXNwcGRy?=
 =?utf-8?B?LzJnVUZCM3gzdE9sZkUrSlVjMSt6REtBY1h1djBwS1ZiQTFGczEzYitLRFFv?=
 =?utf-8?B?TjhoQjFKSUFsQW96NzRNNld3Q2kvcUNSNnorMUx3NmRjaVZ6Ymo0bklsS3kx?=
 =?utf-8?B?a2puZ1RoT2V6UGpKRjNCVDVWRU41emVJYjJYU3hjZC90R295R3pmVGV3eUMy?=
 =?utf-8?B?aVM4SWhYMmZwWWViYWVuTFlRRzA3L0xyTVZEdTlHdVhpTFpqYUZHVUJ5MC9I?=
 =?utf-8?B?dXY5UVQ5WHQwUEFHamowWGx5UEFMcUlhMEdOM09YdlVOeG1WYkJST21XQTlE?=
 =?utf-8?B?RnZYOHVMT2VJSU54TXU5bmNDRDdvUnYycFZlclE5QXh6UWxJU2pGMVVYQXNE?=
 =?utf-8?B?dFNnM1Vsb3ptVkZaeHpPOHJ0SFp0ZFI1V3AwTnRNcXNPcFdVVHptd3pML2Ru?=
 =?utf-8?B?VWhCYXpJNjh4MHIvN3oza3BKZTZ0UTRFL0grZThLUVo5TXl4RWp2WFJvMDFm?=
 =?utf-8?B?N2FUK20wWGFmamJ6Vk9xLzF0akVXSTFFWnpOS3I4MnMwR1ZGKytQNUlwMTVJ?=
 =?utf-8?B?VEM0YTQzZ3c5MzZaZWs0SmFWcjdzYnlQYlEvN1drZ0tCc3NXS2NIWURxTHNB?=
 =?utf-8?B?Vlloamd1dHZoaFpNVjdiQVhsVDZrK2xuK08vNTQzZVdqL1VKUkkwRmpSbC9D?=
 =?utf-8?B?UmpMVnhwQ2pCQUhna0JLakIzSm0xbjJoaW5YdzlDLzYrdkQxYnVIT05tQ05r?=
 =?utf-8?B?akNxQ2FmWHhRTlpCNGhiYzMwK2szVkphTyt5YmtjSFd0Q24wbEJndmtLL1dQ?=
 =?utf-8?B?T1NPTmFBakQ1TEEzMURRUGlwVHEvR2ljMDJsNEpZUzBON1ByNjVwNlFpWit6?=
 =?utf-8?B?T3luY055S0lvYU1Ld2hZcFJMcWVmR0pGdTkwb3FTLzZtSFRlVk5UWW1kSnRV?=
 =?utf-8?B?ZTh3TzY0NFc4dVJIQTR6RWg3c2RnVVplRmwrN2lFNCtyWEI2bG5EUVVELzUr?=
 =?utf-8?B?VGtCVU13LzNKOTArNjVTWXFXczZuMlNwdGFTZVRUYk5QTE1WNmFqM1F1d0hD?=
 =?utf-8?B?N2Z6ZlN6L0NRTXRjOXBGOGIzVEFtQXlqU0dxNVdiOWlYVWpUMUNRZVE5TXYy?=
 =?utf-8?B?SEVEbXg4ck5Nb2ttSFdGdFJmazRnMHJTaml4TlhzY2dnZm9iTEhzazlxZXdz?=
 =?utf-8?B?SzdWYVdDTkk1VGxCb1ZqWnNEMFdheXd3aG9sMEM2MnZrS25vZW8xdStMb3R3?=
 =?utf-8?B?RnF6QnRJYjZqZ0lKQm9vcG1IY1pON2tGazhNanVBVklTdmFLYXdnM3J1UWJs?=
 =?utf-8?B?cHRwMFFreFFJN0RKWTQ4azJqbWJuMGluTXY1Qld4Yko1VW9sVERkdFFnZlFJ?=
 =?utf-8?B?N3NHWlZjL1dmWlAySzQwRGR4ZVNzdVNabEhuZmlKRzVJZlBzbm9nK0MxTE1j?=
 =?utf-8?B?bW5tMWtzTWM2RkRrdG1NUW9NUGFLbVIyRzUxd3NHNTZrcmVtWDkzSzV1aXd1?=
 =?utf-8?B?Z1UzZVFnU0dvZWVEUlhTVjFWRm0vemxhZDk1dXIra2p1TExWeldleWxhRUUr?=
 =?utf-8?B?N2kyQVBwa1YzR2FFMDFUVndyWjRkbVRhT0tHZ0FlTkM1MUNoY1puZTVRTCtO?=
 =?utf-8?B?Y0kzMFZXc0RJaFdvdHUrY0FiOEQzY254RVB1dVN0d1VrcTJEL0dzclZzNGU2?=
 =?utf-8?B?RytQNUUwSElPSXp4ZmIwbnNWWExTU1EvT3krSDZ2bDRtWjBUMGZGb1JlSThR?=
 =?utf-8?B?dW0wM1JjT3VidG1wMm1QcGE0amU1NUx6MzZlaDl6aWM3VU05KzJwSzZNQjNB?=
 =?utf-8?B?bTVrOGgySkJUOURTS0JFbUhseFhJTUx0cVc0SWJNYml3aXBLLzcyN21BSDV5?=
 =?utf-8?B?ajJSZDczQkcrY0IyVmlEMUpmRkQwcWpMR0lNRzNtM2hOamMzUVJmYytiZXps?=
 =?utf-8?B?a3MrZ2xTZHkyS0xDcjdBNWN1TUt4cjBab1RYOXhmYlFWMGV6Z3BWQ2JzUGs4?=
 =?utf-8?B?eGpDZ1lSaS9UQnpiODE5Y3JwSHAxSnNqNVNMNnIxRjF6cFVEc0J0WDlXUTJ1?=
 =?utf-8?Q?ODbdeYUo7sn7Elp5C3aaVEjPD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF00BBED10C.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aa4bdc-f6a9-4c4c-2c4f-08ddb4943b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 09:31:30.1886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3PBhRczodCgN9B+dgT1JvzBQN5CRacn8HSzlJu2zd7WTcYV0X08Mas2OwOaN/qY27ZL1vOr9htlqaNjUqlkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6733
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEyLCAyMDI1IDk6NTcg
QU0NCj4gVG86IGFubm91bmNlQGRwZGsub3JnDQo+IFN1YmplY3Q6IHJlbGVhc2UgY2FuZGlkYXRl
IDI1LjA3LXJjMQ0KPiANCj4gQSBuZXcgRFBESyByZWxlYXNlIGNhbmRpZGF0ZSBpcyByZWFkeSBm
b3IgdGVzdGluZzoNCj4gCWh0dHBzOi8vZ2l0LmRwZGsub3JnL2RwZGsvdGFnLz9pZD12MjUuMDct
cmMxDQo+IA0KPiBUaGVyZSBhcmUgNTQyIG5ldyBwYXRjaGVzIGluIHRoaXMgc25hcHNob3QuDQo+
IA0KPiBSZWxlYXNlIG5vdGVzOg0KPiAJaHR0cHM6Ly9kb2MuZHBkay5vcmcvZ3VpZGVzL3JlbF9u
b3Rlcy9yZWxlYXNlXzI1XzA3Lmh0bWwNCj4gDQo+IEhpZ2hsaWdodHMgb2YgMjUuMDctcmMxOg0K
PiAJLSBNdWNzZSBSTlAgZHJpdmVyDQo+IAktIFpURSBTdG9yYWdlIERhdGEgQWNjZWxlcmF0b3Ig
KFpTREEpIGNyeXB0byBkcml2ZXINCj4gCS0gUGVyZm9ybWFuY2UgTW9uaXRvcmluZyBVbml0IChQ
TVUpIGxpYnJhcnkNCj4gCS0gbWVtcG9vbCBvcHRpbWl6YXRpb24NCj4gCS0gemVyb2luZyBvZiBz
ZW5zaXRpdmUgbWVtb3J5DQo+IAktIFJTUyB0eXBlIGZvciBSb0NFIHYyDQo+IAktIGdyYXBoIGZl
YXR1cmUgYXJjIGFuZCBub2RlcyBmb3IgRklCDQo+IAktIGV2ZW50ZGV2IHZlY3RvciBhZGFwdGVy
DQo+IAktIGFyZ3BhcnNlIGVuaGFuY2VkDQo+IAktIG1vcmUgbGlicmFyaWVzIGVuYWJsZWQgd2l0
aCBXaW5kb3dzIE1TVkMNCj4gCS0gZXhwb3J0IHN5bWJvbHMgd2l0aCBtYWNyb3MgaW5zdGVhZCBv
ZiAubWFwIGZpbGUNCj4gDQo+IFBsZWFzZSB0ZXN0IGFuZCByZXBvcnQgaXNzdWVzIG9uIGJ1Z3Mu
ZHBkay5vcmcuDQo+IA0KPiBEUERLIDI1LjA3LXJjMiBpcyBleHBlY3RlZCBpbiB0d28gd2Vla3Mu
DQo+IA0KPiBUaGFuayB5b3UgZXZlcnlvbmUNCj4gDQpVcGRhdGUgdGhlIHRlc3Qgc3RhdHVzIGZv
ciBJbnRlbCBwYXJ0LiBkcGRrMjUuMDctcmMxIGFsbCB0ZXN0IGlzIGRvbmUuIGZvdW5kIHRocmVl
IG5ldyBpc3N1ZXMuDQoNCk5ldyBpc3N1ZXM6DQoxLiBbZHBkay0yNS4wN10gZ2VuZXJpY19mbG93
X2FwaS9mZGlyX2Zvcl9pcHY0OiB0aGUgbWF0Y2ggcnVsZSBwYWNrZXQgY2Fubm90IG1hdGNoIHRo
ZSBydWxlICAgIC0+IEludGVsIGRldiBpcyB1bmRlciBpbnZlc3RpZ2F0aW5nDQoyLiBbZHBkay0y
NS4wN10gRENGIFJTUyBoYXNoIHVwZGF0ZSBmYWlsZWQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0+IGhhcyBmaXggcGF0Y2gNCjMuIFtkcGRrLTI1
LjA3XSB2aXJ0aW9faXBzZWNfY3J5cHRvZGV2X2Z1bmMvdGVzdF9hZXNuaV9tYl9hZXNfY2JjX3No
YTFfaG1hYyAmIHRlc3RfdmlydGlvX2Flc19jYmNfc2hhMV9obWFjOiBib3RoIHRlc3QgZmFpbGVk
ICAgIC0+IEludGVsIGRldiBpcyB1bmRlciBpbnZlc3RpZ2F0aW5nDQoNCiMgQmFzaWMgSW50ZWwo
UikgTklDIHRlc3RpbmcNCiogQnVpbGQgb3IgY29tcGlsZTogIA0KICAgICpCdWlsZDogY292ZXIg
dGhlIGJ1aWxkIHRlc3QgY29tYmluYXRpb24gd2l0aCBsYXRlc3QgR0NDL0NsYW5nIHZlcnNpb24g
YW5kIHRoZSBwb3B1bGFyIE9TIHJldmlzaW9uIHN1Y2ggYXMgVWJ1bnR1MjUuMDQsIFVidW50dTI0
LjA0LjIsIEZlZG9yYTQyLCBSSEVMMTAsIFJIRUw5LjYsIFJIRUw5LjYtUlQsIEZyZWVCU0QxNC4y
LCBTVVNFMTUuNiwgT3BlbkFub2xpczguMTAsIEF6dXJlTGludXgzLjAgZXRjLg0KICAgICAgCS0g
QWxsIHRlc3QgcGFzc2VkLg0KICAgKkNvbXBpbGU6IGNvdmVyIHRoZSBDRkxBR0VTKE8wL08xL08y
L08zKSB3aXRoIHBvcHVsYXIgT1Mgc3VjaCBhcyBVYnVudHUyNC4wNC4yIGFuZCBSSEVMOS42Lg0K
ICAgICAgCS0gQWxsIHRlc3QgcGFzc2VkIHdpdGggbGF0ZXN0IGRwZGsuDQoqIFBGL1ZGKGk0MGUs
IGl4Z2JlKTogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIFBGL1ZGLVJURV9GTE9XL1RTTy9KdW1i
b2ZyYW1lL2NoZWNrc3VtIG9mZmxvYWQvVkxBTi9WWExBTiwgZXRjLiANCgktIEFsbCB0ZXN0IGNh
c2UgaXMgZG9uZS4gZm91bmQgdGhlIDEgaXNzdWUuDQoqIFBGL1ZGKGljZSk6IHRlc3Qgc2NlbmFy
aW9zIGluY2x1ZGluZyBTd2l0Y2ggZmVhdHVyZXMvUGFja2FnZSBNYW5hZ2VtZW50L0Zsb3cgRGly
ZWN0b3IvQWR2YW5jZWQgVHgvQWR2YW5jZWQgUlNTL0FDTC9EQ0YvRmxleGlibGUgRGVzY3JpcHRv
ciwgZXRjLg0KCS0gRXhlY3V0aW9uIHJhdGUgaXMgZG9uZS4gZm91bmQgdGhlIDIgaXNzdWUuDQoq
IFBGL1ZGKGFwZmkvY3BmaSk6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBjcGZpX3J0ZV9mbG93
L1RTTy9NVFUvSnVtYm9mcmFtZS9jaGVja3N1bSBvZmZsb2FkLCBldGMuDQoJLSBFeGVjdXRpb24g
cmF0ZSBpcyBkb25lLiBObyBuZXcgaXNzdWUgaXMgZm91bmQuDQoqIEludGVsIE5JQyBzaW5nbGUg
Y29yZS9OSUMgcGVyZm9ybWFuY2U6IHRlc3Qgc2NlbmFyaW9zIGluY2x1ZGluZyBQRi9WRiBzaW5n
bGUgY29yZSBwZXJmb3JtYW5jZSB0ZXN0LCBSRkMyNTQ0IFplcm8gcGFja2V0IGxvc3MgcGVyZm9y
bWFuY2UgdGVzdCwgZXRjLg0KCS0gRXhlY3V0aW9uIHJhdGUgaXMgZG9uZS4gTm8gbmV3IGlzc3Vl
IGlzIGZvdW5kLg0KKiBQb3dlciBhbmQgSVBzZWM6IA0KICAgKiBQb3dlcjogdGVzdCBzY2VuYXJp
b3MgaW5jbHVkaW5nIGJpLWRpcmVjdGlvbi9UZWxlbWV0cnkvRW1wdHkgUG9sbCBMaWIvUHJpb3Jp
dHkgQmFzZSBGcmVxdWVuY3ksIGV0Yy4gDQoJLSBFeGVjdXRpb24gcmF0ZSBpcyBkb25lLiBObyBu
ZXcgaXNzdWUgaXMgZm91bmQuDQogICAqIElQc2VjOiB0ZXN0IHNjZW5hcmlvcyBpbmNsdWRpbmcg
aXBzZWMvaXBzZWMtZ3cvaXBzZWMgbGlicmFyeSBiYXNpYyB0ZXN0IC0gUUFUJlNXL0ZJQiBsaWJy
YXJ5LCBldGMuDQoJLSBFeGVjdXRpb24gcmF0ZSBpcyBkb25lLiBObyBuZXcgaXNzdWUgaXMgZm91
bmQuIA0KIyBCYXNpYyBjcnlwdG9kZXYgYW5kIHZpcnRpbyB0ZXN0aW5nDQogICAqIFZpcnRpbzog
Ym90aCBmdW5jdGlvbiBhbmQgcGVyZm9ybWFuY2UgdGVzdCBhcmUgY292ZXJlZC4gU3VjaCBhcyBQ
VlAvVmlydGlvX2xvb3BiYWNrL3ZpcnRpby11c2VyIGxvb3BiYWNrL3ZpcnRpby1uZXQgVk0yVk0g
cGVyZiB0ZXN0aW5nL1ZNQVdBUkUgRVNYSSA4LjBVMSwgZXRjLg0KCS0gRXhlY3V0aW9uIHJhdGUg
aXMgZG9uZS4gZm91bmQgdGhlIDMgaXNzdWUuDQoqIENyeXB0b2RldjogDQogICAqRnVuY3Rpb24g
dGVzdDogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIENyeXB0b2RldiBBUEkgdGVzdGluZy9Db21w
cmVzc0RldiBJU0EtTC9RQVQvWkxJQiBQTUQgVGVzdGluZy9GSVBTLCBldGMuDQoJLSBFeGVjdXRp
b24gcmF0ZSBpcyBkb25lLiBObyBuZXcgaXNzdWUgaXMgZm91bmQuDQogICAqUGVyZm9ybWFuY2Ug
dGVzdDogdGVzdCBzY2VuYXJpb3MgaW5jbHVkaW5nIFRocm91Z2hwdXQgUGVyZm9ybWFuY2UgL0Ny
eXB0b2RldiBMYXRlbmN5LCBldGMuDQoJLSBFeGVjdXRpb24gcmF0ZSBpcyBkb25lLiBObyBwZXJm
b3JtYW5jZSBkcm9wLg0KDQpSZWdhcmRzLA0KWHUsIEhhaWxpbg0K
