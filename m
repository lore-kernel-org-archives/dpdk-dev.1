Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B35C3ABAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 10:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8AB04026C;
	Tue, 29 Apr 2025 12:52:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1E4A640263;
 Tue, 29 Apr 2025 12:52:35 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53T75pVZ017828;
 Tue, 29 Apr 2025 03:52:34 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 469g8acjn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 03:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5PwHYaaNo63r4XtQ4hYhEg6G/OWp9hRRRFQDFMXUfsFbg3ej/9oYHe/xbDIrFvCepGCcktGuPcKNwV/UJ1LK2UdsEsT0Uod0NJVkH3y22qqY1tGjH9o8wMLxHPc0FQ0wblGPkYuqP+vxNaIsZagDaQU81L5C8vAdrNU+hEPnwXcxsck86Z69TZh9I+lBohmJGmaxncfJAYOJkRfaqvTHmdcO8NPCOiBJKhyD21LekzFci9whYsv12bRvU6eDPsm9wjMkjF2M+R3wiLZqp94tAd4vb65M1If8m/R+cO9lA2lON16wpbiu2FRexsgMPkZ0/B4Y2jhgnQrYC9GyQcBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl+Xofl0NCfVZiq+wJUdLW+rKm4WAIzjYiP3MEQ6WgM=;
 b=QnSD5baDiM4gZphr8Vba6kCvHF4RbxVDFseyqkBorJhEaZlsbdEX5oMX7lMHE4eOzPDOSE5/O6Hqeb0yqOWyQPfSXwuyX9t4lkQx9VgzQnMuwj1XYyDzqIsWvERLTAVoBK57ssb8Wk3UyKJ/pz6/9njpzDQZcWXPXg2GAYDmcy7vISJKdQLpRPqNAldj+OPPUEoevDlLwRxfz83VtKP5tj2dJioaRuBAZ3nr+MyICGxbRUHupZlHGlNS7p/Avr5JgXXxbSn4esb9JgW4eMhSSqNXjTRpxBfMAg+Xavpq+Gn2QBbFvHpb4IYMOlfQlAO03Peh7Zu9Z1lCqaRey2d74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl+Xofl0NCfVZiq+wJUdLW+rKm4WAIzjYiP3MEQ6WgM=;
 b=V3n7WTAP7JvjvkQAJUq8HcqdBq2QVvIT9jSkl7+xi7SJc1wGV2uFw4Oi1W+dFA9CpQb9Ax4D3/gemWRWc0YRcF+KLV6mTnlNogxPbwiIVQegHLJrNxm9+zQsFPYchJz4a18Imlg39XfdYXIKWPppVI16mKxeIMzpzgYzYRfoklg=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by LV8PR18MB5711.namprd18.prod.outlook.com (2603:10b6:408:1f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 10:52:29 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%7]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 10:52:28 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>, Jerin Jacob
 <jerinj@marvell.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>, David
 Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2] trace: fix out of bounds write in
 __rte_trace_mem_get
Thread-Topic: [EXTERNAL] [PATCH v2] trace: fix out of bounds write in
 __rte_trace_mem_get
Thread-Index: AQHbtTuUVQpvw+DNPUmK0nGrinQj/LO6fvQA
Date: Tue, 29 Apr 2025 10:52:28 +0000
Message-ID: <CO6PR18MB38604A74D8305EA331193DF9B4802@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
 <20250424170818.23970-1-oleksandrn@interfacemasters.com>
In-Reply-To: <20250424170818.23970-1-oleksandrn@interfacemasters.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|LV8PR18MB5711:EE_
x-ms-office365-filtering-correlation-id: d8099c0d-2df1-4051-4e10-08dd870bef24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?amFZTnRDVmxGVkRiNCtTenJCSm1UYXRLb1QwVUdJWW5MTm1hbVNwdVhiSzNX?=
 =?utf-8?B?eTlZTVNJU01NcktGc0pCMWlXU2R4aDU4UVNLblFuWXhjVmlBMklldVNmQ3k0?=
 =?utf-8?B?QWtoaERPdjFpSmFPTlAyMUZqQWthYzZKQjRLbUJWYU14ekZMSzgySmhNZGp0?=
 =?utf-8?B?ODJMWXZFZm8yQkRMQ09oaVhDTXlMVHVHOEdPQXpucDR6UGRDcGJLaXgzQlNu?=
 =?utf-8?B?YUhFWTVNUG9HMUVzeFdiMWlOWjVLMlNkUVphUk1HVWlmd2YxbEwvRE8ySGk0?=
 =?utf-8?B?SHlZZlZOZFIzU2NUWnhaenhlN3dDV3FxclVrOGdBZVRSdzI0UnB5R3JpbVM5?=
 =?utf-8?B?VENCa2NJSDRWVE1Rak5kckZHRVZjM0FlbWJweU1odFNMY1NFY1JPOXNOcGNx?=
 =?utf-8?B?dVRxKzI4RWlzSWRjVnViQnorLzFoVUJ2ekFXZDNnOHNuWkRCS2RMRFJsRjlt?=
 =?utf-8?B?L1hoTkk2eXN2elZlaG4wMExjUGRLcXYxVGlLelh2SnNiUmNkN3ZIYlU2d1BI?=
 =?utf-8?B?U2RjTGdHYzE3TFhoamw2QzlXbVdRMFVvRk8vM1NLYm9qUTdhYUh6YXlWMmRh?=
 =?utf-8?B?SWQwb3EyWUJDbWpBL2l2NVBnTHU0c1h6MXRtaldhWDgvamdHZFp1Z2NWMW53?=
 =?utf-8?B?WUJneFZtZHhwUEZ4Rm93TVFVZURXS2ZBN3d5SWQ3OGlQZ0IwK3lFWFpmQ3FC?=
 =?utf-8?B?ZXMrUXpNV3VFMWE0TmhLREQvVUxWVkJjUUhScnRJOWFGQVY3V1VLTnFmbWxh?=
 =?utf-8?B?R0Vvb2lhb1FINnVKQ1RYTFI3S3o1WkVKM090ZlVLVWFHakZMTXNPL3JNazI3?=
 =?utf-8?B?dTVYSGVUU0UrWWl3YStzM05RY1p1T2pSRUZLR0taS2tXZEdZUHdpNEg3RXpY?=
 =?utf-8?B?bU82OTBmdTI2ZDRXNDlVakw1TDd3Z3lhQ09xYTV2SUJxcEpOK0VwM0ViMTdC?=
 =?utf-8?B?ajZESDdWUExtTEg5R3dUU3RnTFRiK1V5Q3hPZjFJRGE2Z2w2NW9wZHFIUUQz?=
 =?utf-8?B?N3dCaDBwZmpwUVE0ZW1IYk9xK1k3WHEvT0MvZFhoN2VmNnRMWEVtTVVFRjBK?=
 =?utf-8?B?L0Q2bU43cGFjTit4cS9Ra3ZDQ0swM2pjSGhZZFlQdVBWNUhucmJTVy82K2RP?=
 =?utf-8?B?eENkVUwyZ1R3eVVXTGxabHZyK05mZU9WbnVFdUxBZndIQm9aTnF6SE5SQjZJ?=
 =?utf-8?B?YS9aNFRCeE0rREtrVFJCOXRCZXZ6Tjhyckx1eDZYYm1EVU04cFlmbTZZbmkw?=
 =?utf-8?B?KzJsTjZ5U2ZpRVFJamtRV25hWDlnTy83dnIrbTJXbmgvUDNLaEJzbmpLMXFV?=
 =?utf-8?B?U0pldGF0UW9EQ0tjQnU1dTc3QXEzRVU5TkNIQ0U4UmhyaWcwRkVveEYyMStW?=
 =?utf-8?B?UnVkaDJVWmtJYmxQcS9RT0lJM3RETkRVWXVlU2xwbEZXaklEUEdRNmpBL1VN?=
 =?utf-8?B?ejc4SHdCOFRmNEpUWDRrR3E2MWFzNlp2TituYXlrRDcvdk1MYkwyeEs4WVo3?=
 =?utf-8?B?SjNia2NhVytBQjZwR0lGYW5zYUVjSUxGbGFpN2RjeU96U0NpVE1ZeUNKcWxF?=
 =?utf-8?B?RG9RNUlMN3JVWWJqMEVlSnBlbDdMU2NTc08wTTd5RkVXdFhlcHpoTjAwOU1F?=
 =?utf-8?B?Smg2Y3V3aXFlMFZ3dFZObjQ4ZlRHUHZNLzJMUHF3aDY1L2xyVEwrZUczb3Vo?=
 =?utf-8?B?d3ptekxhNGVTTENRRGxUVnMwdVo3bDhwVEtud1g3Mk1kSm5aZWoydG5uN2Js?=
 =?utf-8?B?cjNLMDdkaElGZ294UXh6MjJpNHEzb2tLRUdzOG04UW9lUCsreTF6NEp5b1Fi?=
 =?utf-8?B?aUtzeSsycnB4ZWNlVEd6UFBUSE04aUgxelpTYXBLQStLRGowWVFkSXZPOVFk?=
 =?utf-8?B?S2d5MHYrZk5EZjRaRUhqQ0RacXlreUFiZG92MXVNQytNY1JoK1ZpZTlmam9L?=
 =?utf-8?B?MTJiR0RrZS9sUDg0QmpyTFJrbXh5SWtwN250ZStGWTFKV1pCdldVdkdBYnky?=
 =?utf-8?B?L24zOFN6N3dRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFhRN1ErbnpUV1BwZG85M05IU0pRTjJyNHdFQnRuQStyeDA3VXRVUjVZT2ND?=
 =?utf-8?B?aXRkSmJkbitSb0srelRiUi9ObnI3bWN2YTA2NWhMcUNmbTIySER4OW44ZjFB?=
 =?utf-8?B?cTNYMXlaMU1Yakk1YTRkNzl1NnBJaXdXYWJwaEJFQk5Tc0VaSVY3MndmMmdx?=
 =?utf-8?B?YlJYWTlGRmdXVlNQNmRleDQ0MTU0NlM0U3lUUmx4UHZsS0RQaUxWcXJ1QUFm?=
 =?utf-8?B?WDJxM0p2T3dqNCtxanE4bzhoSVpocHFqTkIrbXBxQWtxa0l2eDAyNFJ5Q2kw?=
 =?utf-8?B?U0JQRjZWakVtYk1QOHdSaURydWg4WXZZSlgwRksyNXY0a3hRcUxlQWZyZHpK?=
 =?utf-8?B?aVYwdER3M2Yxc0NXVTB2VTJHVXRZaXd5aFBKYnFwVkNsSUpTLzVVdDd5eStI?=
 =?utf-8?B?a0hJT1VadUFLY1UzR05YNndHV0wyc09aTTNhSWVWT3lvRjZ5Q0pid0tSNEJa?=
 =?utf-8?B?NXBtOUJIbUJSdU5aVEE3N0x2VDJxMzhTdEQxa2lCNmhJcEpRdFplbmJJQ3dR?=
 =?utf-8?B?elhpTUlacThNSFBXZTQ1b0pmRVlxdnE4MXJZWG1DSnF4by9Kdi9jS2NsVzBG?=
 =?utf-8?B?T1RFcm5aOVppRnM3V0JkaVpGMzZnNkYyQXpadElIaVJ2WFQzRndDTVZEYm9E?=
 =?utf-8?B?OEVJTkZOWHJ0SEc5eDhWN1FQV01xcWVmOHgrRTVtbU1hWHJRZVNyMnE0Qnkv?=
 =?utf-8?B?RHQrbGVQSVNWS2NTYitLVjBMeUFoVVpNVS9icmFoS241Zk1oSFhJZEVtVzJZ?=
 =?utf-8?B?TnVDUVdkUWladDRSRDVjUXJkK2pMcUh5YmpJUGlORlBKb2cyeEFBOXZCWlc4?=
 =?utf-8?B?dnBIeFBpQXJLTi9wa1puMksrSW9XbUZjcG1yK0Z0djRHRmx3dE05OFBWYS9u?=
 =?utf-8?B?L0oxTDBvbys1UW84cDJidkFHODMxM01HQWtRUDJyRTd1Tm4wUWxJWFVtSHRB?=
 =?utf-8?B?QVkrV0NHdjNCV3MzVUJuTVFOSVdDNDFtUmhlYndmajRlaVVUb3ViZU1QYUJB?=
 =?utf-8?B?T1FzcXYvSG1sakpWYTV4alh6aUF1MDZJaGVaWjVQSjR1SXlGNXZKbXhvbUFl?=
 =?utf-8?B?YUdhR2ZIV25OMnVYa1hmYzFnZlFTVTV3SmhPTmVMV2tNZkF1QWJxMVpxRVV2?=
 =?utf-8?B?RlRYNlFmRHlpYVplSmJ1Sk9VekEvL1N2bmJKNHVhelZVWDRXbEZqZnpJWjlz?=
 =?utf-8?B?NzV2c2RXVVg3WDczTndPUmZHMHhmb0d5WGJIZVFONGlkWEJ4Z2RULzZ6VHlQ?=
 =?utf-8?B?ZXRqS1pMc3Nyb1VvVU5abFlMSk1uWitlMW1ZQ0N4bWVVOXNLL1l2WGxBYzJq?=
 =?utf-8?B?c2JtZHhlSWpPbS9rQ1NkTG9zR01hWTh1Sm1FSFVoV1ZxbFdORmVJaFg0K3hG?=
 =?utf-8?B?eVVsMnMvVWdtalRabTJWSDFQZEF5VXZEU2pWNjZtdU15T0Z1cG4xVFRUR3la?=
 =?utf-8?B?eUdickdWUnhoRG03dlpIRHZFUW8yTXkrSXlrWkZVdm83MkcreU50bFh0QUx6?=
 =?utf-8?B?UXcwQ3Evc3dtMmJ0WlY2OFc0THJEU0REcFV2dWVlL3BxTXA4SlJvNjQ4aGY5?=
 =?utf-8?B?Tmh0RHY3WHJ2SnlUVjdEOGRTSjgwRUtEWmRhSmFmbE5kTTVOSXFoOHNWaDZM?=
 =?utf-8?B?ZC9ONkg0YzY2SUdtYnk0M1NjYVlXRTJrYktJSG5jSGRBeHhzbEhpTTlicFM0?=
 =?utf-8?B?Zk90c1dzV0s3TURZQlFMVnhxZDlENFFSVno3SDJyaGpVcWFRUnNZKzJwUU9N?=
 =?utf-8?B?TjBLcXQ0Z1VmRG9FM2NOM1htU3MvM3Rjb3JMU2dsK2kvOWR4eVJzV3JxNi9n?=
 =?utf-8?B?SlRtSlhJendzcnhrVjFQTG8zWEQxbHNBdTFPMkhva3NkSFc5NW5XNnl3b3dK?=
 =?utf-8?B?aWdya1YrTHhQbFNxRGpMSTFzblZkVitLWE94ZTg5NFMvejZJRzdUUnduY3No?=
 =?utf-8?B?MlNEeW9jejVyZVdrQW5Jcy9EdmdicmFET25wdjd1aVlxQzNOaEx6Y2tKcjVY?=
 =?utf-8?B?aE4rdnRoWi90MXYrdHNuSmZHKy9vYzZrSFhsVXh4RUY2VmRMbjFRYzdZTDIr?=
 =?utf-8?B?RnJkYUVOckVUampDb1gwRk13ODV2VndYdCtzUWcxdWozWktNRlNvRC9NOTBT?=
 =?utf-8?Q?yhBg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8099c0d-2df1-4051-4e10-08dd870bef24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 10:52:28.2406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmnCeQ1nk/G39Hz92HNvMMSGGgjx9h5puvkf4qAeGRsNpQavQYWUAhAgc5xKJHnLdwCCkRQCtyfGa5W3xC8USQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5711
X-Authority-Analysis: v=2.4 cv=aeVhnQot c=1 sm=1 tr=0 ts=6810af72 cx=c_pps
 a=yneE0G6ieORTwLKR6pgPXw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=Y8KpScVGsVSBS4ci:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=-AAbraWEqlQA:10 a=47DPPWgoAAAA:8
 a=M5GUcnROAAAA:8 a=whoDos4fjNPE-FvDLDgA:9 a=QEXdDO2ut3YA:10
 a=j_xVGaBrmtlMMe3VQ61W:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: IqPgCzYW-RlhAfSxwJFg41IXn3bQb40_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDA4MSBTYWx0ZWRfXyBs3tvjODOsz
 YhdCfoZ8v+IZqnboU121RRxaFxQEPx5WXDL9xhp1uIA0zoVbvUmsaeo+0ZkC+VC3GCtOmW3ENJ1
 nemWuYjpDwmClAc7O1TU25++tbC9wowJNZuMm6DHVAICd8qlgnFrS98dv3KO5enhXQo2eBVZk70
 wHSXtOmjs13hvDW/WwAliRPYv9EhEbknZMsMa5mSI9Ity9fEdEF6vj5MgJvB16lm1jAxvDkyvdR
 T1GC862l/tcn+SMNDlzON0g8PYKngHI3EBo5dfuD36sbd47jrpcnI/L2mZhw8Q3W+NdzzJOOACI
 /30EC8DeMIO8g9lF3gS3/G/zlFfCQ6xJ2TSjoKTlNqqFeiGLODh3iszWUesL4kL52JveKmhx/gn
 +nBM6xbChJVuSUnv62pbLb8IAvaPoBe9TlcyfTla6D8VZxSKzZxQ5V8asMUHH07fN3SM819i
X-Proofpoint-ORIG-GUID: IqPgCzYW-RlhAfSxwJFg41IXn3bQb40_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_04,2025-04-24_02,2025-02-21_01
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

PiBPZmZzZXQgc2hvdWxkIGJlIGFsaWduZWQgZmlyc3QgYmVmb3JlIGNoZWNraW5nIGlmIHRoZXJl
IGlzIGZyZWUgc3BhY2UgZm9yIGFub3RoZXINCj4gd3JpdGUuDQo+IA0KPiBCdWd6aWxsYSBJRDog
MTY2NQ0KPiBGaXhlczogMDMyYTdlNTQ5OWEwICgidHJhY2U6IGltcGxlbWVudCBwcm92aWRlciBw
YXlsb2FkIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzYW5kciBOYWhueWJpZGEgPG9sZWtz
YW5kcm5AaW50ZXJmYWNlbWFzdGVycy5jb20+DQo+IC0tLQ0KPiBTcGVjaWZpZWQgY29ycmVjdCAi
Rml4ZXMiIGNvbW1pdC4NCj4gDQo+ICBsaWIvZWFsL2luY2x1ZGUvcnRlX3RyYWNlX3BvaW50Lmgg
fCA0ICstLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvZWFsL2luY2x1ZGUvcnRlX3RyYWNlX3BvaW50LmgN
Cj4gYi9saWIvZWFsL2luY2x1ZGUvcnRlX3RyYWNlX3BvaW50LmgNCj4gaW5kZXggOGEzMTdkMzFk
Mi4uMzQzZTAyNzFiMyAxMDA2NDQNCj4gLS0tIGEvbGliL2VhbC9pbmNsdWRlL3J0ZV90cmFjZV9w
b2ludC5oDQo+ICsrKyBiL2xpYi9lYWwvaW5jbHVkZS9ydGVfdHJhY2VfcG9pbnQuaA0KPiBAQCAt
MzI4LDcgKzMyOCw3IEBAIF9fcnRlX3RyYWNlX21lbV9nZXQodWludDY0X3QgaW4pDQo+ICAJCQly
ZXR1cm4gTlVMTDsNCj4gIAl9DQo+ICAJLyogQ2hlY2sgdGhlIHdyYXAgYXJvdW5kIGNhc2UgKi8N
Cj4gLQl1aW50MzJfdCBvZmZzZXQgPSB0cmFjZS0+b2Zmc2V0Ow0KPiArCXVpbnQzMl90IG9mZnNl
dCA9IFJURV9BTElHTl9DRUlMKHRyYWNlLT5vZmZzZXQsDQo+ICtfX1JURV9UUkFDRV9FVkVOVF9I
RUFERVJfU1opOw0KPiAgCWlmICh1bmxpa2VseSgob2Zmc2V0ICsgc3opID49IHRyYWNlLT5sZW4p
KSB7DQo+ICAJCS8qIERpc2FibGUgdGhlIHRyYWNlIGV2ZW50IGlmIGl0IGluIERJU0NBUkQgbW9k
ZSAqLw0KPiAgCQlpZiAodW5saWtlbHkoaW4gJiBfX1JURV9UUkFDRV9GSUVMRF9FTkFCTEVfRElT
Q0FSRCkpDQo+IEBAIC0zMzYsOCArMzM2LDYgQEAgX19ydGVfdHJhY2VfbWVtX2dldCh1aW50NjRf
dCBpbikNCj4gDQo+ICAJCW9mZnNldCA9IDA7DQo+ICAJfQ0KPiAtCS8qIEFsaWduIHRvIGV2ZW50
IGhlYWRlciBzaXplICovDQo+IC0Jb2Zmc2V0ID0gUlRFX0FMSUdOX0NFSUwob2Zmc2V0LCBfX1JU
RV9UUkFDRV9FVkVOVF9IRUFERVJfU1opOw0KPiAgCXZvaWQgKm1lbSA9IFJURV9QVFJfQUREKCZ0
cmFjZS0+bWVtWzBdLCBvZmZzZXQpOw0KPiAgCW9mZnNldCArPSBzejsNCj4gIAl0cmFjZS0+b2Zm
c2V0ID0gb2Zmc2V0Ow0KPiAtLQ0KPiAyLjQ5LjANCkFja2VkLWJ5OiBTdW5pbCBLdW1hciBLb3Jp
IDxza29yaUBtYXJ2ZWxsLmNvbT4NCg==
