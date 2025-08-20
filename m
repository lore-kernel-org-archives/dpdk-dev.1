Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B164ACA0EED
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 09:56:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6746402DD;
	Wed, 20 Aug 2025 11:56:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1D35340292
 for <dev@dpdk.org>; Wed, 20 Aug 2025 11:56:01 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K6xSO0025321;
 Wed, 20 Aug 2025 02:56:00 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48n0vk1acv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 02:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrIO8e+Lrsj5OyUVWci6H0KFw5oisZYrDGuPuuA8Qf+JVr/qDGH0b6Mbhei+vSrbHGJaZwC1L+ooaxuazDm/Vj4dgwwi6WfUWECzUmQ0gR6N70URvQXrCccqLCLs4xYQAt7N5/+jqFIJiUtORUg9ilBJ21+4aZaluHagLs30ZkiLDjsS1gc8bU6kqNMZ9dYvCYEL1EWhp4K2Cu2cjHqrImhHnaSNTY6AIiA7NtHnIM9+p1hX4G+pscoWfQiNfh/cIoLPzl/o6FIE0vHd/4795OxZE3dHkfck44gVTUB/1NX8ckMqnJ8ihqSU66/DimMuxxpz308mVfDomH8vtiplVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe+7Tzd9EUtHeKUMJDX42i7znv4RS0sbvoQ2RfiQ5d8=;
 b=xJd0pTXl7TSx8Qxbc2Z0cmiOnl/CdnkVHr84YXsf0nUYY9hXCZL0Dptmjuwb5WAK5FJmDeM+sUX8+bFk1KcXMidivsDGXi5JwumHkmwlJZuoeZHakuaZL6hMcQ9Ks16IFtiDl+15hRRIg6KCEMDLOMyzX+0EeXPZYwojGkYb++oiUOym9dGNbhF5fk4VweyYxJvRjiMgrpBYZgmjMBpJeeoSkeY/9OyWWEPrZZvrHJMt+jkqh3dckHbroJVSlPgGuNaUCm/uAVF3V/uAqYes4qEy1D/fp+ZjLUFIsurg+3cYgEii5+Zh8hu1EYil+EO+f7Vo0XT0qVVbLRB/WqulAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe+7Tzd9EUtHeKUMJDX42i7znv4RS0sbvoQ2RfiQ5d8=;
 b=W6gLZ83L4Qol4wgdwjceQTTbMVJkJEljjRSawhJNmzuo54nBBLaL7pLSzNnzwJHNYdqyVD/6BcPRQ33AdSHOMw0irbDumOy4GbHButk0f6X7eGtEXLr3whi4lS96oVZzq3T1vxFG4fVYsFDfEl4s24W2C3NSziTz/FO05z6Y5V0=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by CO1PR18MB4667.namprd18.prod.outlook.com (2603:10b6:303:e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 09:55:57 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%3]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 09:55:56 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcEM1T1BAlqfLKoE+wGUJ6lcGd0LRqK0GAgAEkJtA=
Date: Wed, 20 Aug 2025 09:55:56 +0000
Message-ID: <CO6PR18MB38601A277170C0571CF9107AB433A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250814081215.1904078-1-skori@marvell.com>
 <20250819055126.2745262-1-skori@marvell.com>
 <20250819092927.739f64ec@hermes.local>
In-Reply-To: <20250819092927.739f64ec@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|CO1PR18MB4667:EE_
x-ms-office365-filtering-correlation-id: 0b064fb8-597b-4feb-9537-08dddfcfc267
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aG0rNU4wU25sVHAzWWRVdVJlQTBqWmMxNThEVUZOWkhROTg0RTFvWTJzZzVB?=
 =?utf-8?B?TEpLNVFqVXBWZ2dsOHgwenJOV3ZqTDh0R1prQVhnbVhzUmF4RlZpNTNnZXRX?=
 =?utf-8?B?UCtISnFsWURSRll3K1VJVGMwZXNzTlJheHoxWkxpWjRHZXNtcE5BbFhya1JH?=
 =?utf-8?B?Q1hNV1h5cFZXR2VqWC91MXRPMEo3K09ZY2h6eE9SSE1yaHZkbkJGVXpYZUVF?=
 =?utf-8?B?QjVqeUtLK1hoRnV6NDlaMFpRdWU2RVpmYUpRaUZNOGdsQ3Jhd1huUVE2clhC?=
 =?utf-8?B?a3d0Rmp6a29STm9LYm9taTR0a21BSVRLdWtZMW43WmpuVUJXcUw2R0VkbmVI?=
 =?utf-8?B?ZGlWN3Ird2k5QWFSRGUzT1c2cGpRbzdPdGFTZzFqMnRqRWQyOC9wR3BzZlpO?=
 =?utf-8?B?SnBWcGpsUGl5dDM1QW9mYy82a0ZQYkdvYmFJTGpiSEs3QUdjeGM1LzVzZG5E?=
 =?utf-8?B?NEhOYzVsRTlxNzA1Q1R0Qk9obWk5d2hoazJsRjFzK1B4UCtqb2R2c3NXNllz?=
 =?utf-8?B?cnNVN05aUldtRVpRY29JYzBrQk9mTktwdmdwL1VTVnFhOGZ6ZXB2UnVxWTRy?=
 =?utf-8?B?ZzBlZWlIMFJ2dEY4TDhNangvZkZUMElReUZCdTJTV0M0cWRxVFRVMEZjMkY3?=
 =?utf-8?B?S0FsaVF6aE5IN2szVk1Da2phT0ZkVm56b0tJVjNwZVdpaC8vNHprNWJpTUJP?=
 =?utf-8?B?OGZUOGIvK1BVcFdQSXF1cytFdk5JSS90aXNSSWRlYmdrcWFUMzZhelhkVkMy?=
 =?utf-8?B?MTRBV2NxNlE2cStRM2g3aW5oc1RnbnBNWjh5Uk5ud0tQY2YrQ2tnczJhbWIw?=
 =?utf-8?B?dFhBNk9Sc1loRnFvakI1L2luUHV5ZUEycEJKYjVjdmJKRUFyZVpqVnQxU1Vj?=
 =?utf-8?B?cU9VcXBEVE44UjgvYjRtcHdRVDhXaEZ4VURCREZDTGNHRWgveHJlOE10S1Rm?=
 =?utf-8?B?ZVVoRXRmU2k4NlV6WGc2UWJJRmN4WE5sRngyakRhbXRoU054K2duRUw2Z283?=
 =?utf-8?B?MnNGclJpc2tPWTBwSjJSNTRjTC9jWnpHUmZmSkdQR1pXY2ZkRUtkTWxzRkFE?=
 =?utf-8?B?RHJQeGtEOGZCbC9yRno0dEJ2eGxYc0YxVXpFdjZIamRQeEdTM1RHTzkrZ3FO?=
 =?utf-8?B?VjFScFZNcUlQWUtZQjRMOGpsc2d6Y3RueGNBNkdJOVNuVEZjaGpVa01VU0Qv?=
 =?utf-8?B?NTBJbldud09UbGo2dmRadDRvcFRLSFNyZ25vN2dTSFFiVno1SFljTzJsK1Vn?=
 =?utf-8?B?ZVpoS0lYeFFnQVdGbUE0RUtIQWcxd1ptQWt1bGVsdHhUZGFYQ3UxUndQTC80?=
 =?utf-8?B?WDZIa29jZlU1TzdkY1ZDN1lONXJpMVhCdzVQSS8wWlV2UzBySGVqWXBsM3Q2?=
 =?utf-8?B?dUUzaE5mODZIQ0xyUkNLdVk2YTM5eGFTZXh5MGM1blpaTktJdC9WalBmZWo4?=
 =?utf-8?B?WlMwc0Jpa1c2N3dPZm4xZTQvOCtvU2ZUS1R2OXJReWhpb3dmSVQ4a3pjU0xK?=
 =?utf-8?B?ZENodE9hRC95RCtFNXNMa2RSa2wwOW5MMnJTSzdxZUhyUTBQQ1ZuNS9FZUZP?=
 =?utf-8?B?cW8wMTNlTEt4SFZkUjJvcUZ3QjlEQ2JnbEsyZEVyOXgyTlNNZ3MxS3MzZ0xt?=
 =?utf-8?B?MGtqTm1JT1lLRmRwcitkR2dqUVNyUnU0cDRCRGNBMVUzRkUrTFFXTS9iUy9i?=
 =?utf-8?B?WjVJNnhIMS83M0ROc1B4UCthalVPZXA1dUlXQmcvbjM4cVBteHhLeFRtVjJC?=
 =?utf-8?B?djBmVW5tZExFZ2R5eFdIZEVHQjNHRDluTjdYbmVXV2JmYzJoeG0zLy9PNTMy?=
 =?utf-8?B?ODhkNFJJa3huOElxZGx0bHJPcFo3MkIxcXJjUlR0VlhCbDdxS0Ywc2xibjVH?=
 =?utf-8?B?RGRocmU3NzFHeDMxT3Z1RzVmd0taZFZjV0JjQm5FSVQ0UWIwc1VxTzhZZktP?=
 =?utf-8?B?Sy96OWs1eTZpekZtNHBLYXl6MDFKU2JyaWN3bXZVUDRzYkVPVEl0MHJFb3hr?=
 =?utf-8?B?ZG5nQkRpUmNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXcvVEM1cDFQVkhYaGRXN1VoY1NaYWxMaHpyaXhjcDVOV003WXpaSy9KRHFh?=
 =?utf-8?B?bVhzbVlTVFAvVmROVTdFT0Y5bXNHZ2xJVi9hVUFSR29rNm1YMXI4QjZodHBR?=
 =?utf-8?B?WndyblNSNCtjZGtKc0xybCtkNXJIZ3RPN2FGVGhYaDBZQjBLb3pDUm5UVktF?=
 =?utf-8?B?ZUdPMnhicHVGZTNCT2Y4UXJHK3haZEd2dVdxT3VFcXM1R044eXc5RGNFM1Mv?=
 =?utf-8?B?TTc2MDBxeldLbStWSC9GL3cxZXF3NDhXRGRoaDI1SzU3OTh3NURYYjVyelVI?=
 =?utf-8?B?SmhYeFBLTEhkdmtZd3VrV1ArZERvc3hEUVgxVFpzVlc2Rjc1b3lKa2J4UUg5?=
 =?utf-8?B?bzFFZ0hWQVJKR2F0L2lzd3lleFBuMWF1OUV0OGZUeTUwdXUrc1hxdTZpb1l6?=
 =?utf-8?B?RnloV2NTYTdYUE8xckN4QkZlVkpuZXR4WFZWUWNQZ2FsTTA1MnpsbVl4TDdh?=
 =?utf-8?B?allsMkgvb2I5ZlQwVGNQSGtvTlUvVHpiT0RYbkVXeWkzK2YyWjh0d2F5ODJE?=
 =?utf-8?B?VW9Hek1lNVg1Rmh6ZFNuc3dJNHJIMDhOTndGLzlURGcyRHBaK2FBUDdJSmRV?=
 =?utf-8?B?Q2RHVWNUZU1GR1RxZjNLd0FZalZMR2wzNy9aUzVOZUhpWU5BMnlwbHdNUldy?=
 =?utf-8?B?bUVFb0Yrc0Mrc2VGTU0xd3U2MTBjRG5yMHJBYUNqaDZzL1U5aE9uZTV1Zzd2?=
 =?utf-8?B?ZDZUR3ZNV1dZdW16U0pqb09sN3VkMkNUTlRqTk9BV1VLdjROMERVaWRBcGxN?=
 =?utf-8?B?aE5nbFV6SDVZUGtVVS81bVNjMUd0TlhxMTVTRVNUWGNmbUdiRmcwSUozUHQr?=
 =?utf-8?B?RVdUU2d5c2l2VXVXL1hjcXJRWW41M1pBQzlEMGhqL25PMTM3UU94K1UySmhv?=
 =?utf-8?B?bkZrN2VUWXBpelVMdXppUy9hQ0JTQ2tYZHc4T3Q2dUVmaGRGUVFHdmgyU0tU?=
 =?utf-8?B?RFNYOXVTWFFDUmprSEwzRlZmK0NvRitMV2J0ek5PQjBnNFJVVGZWc1pWTTVR?=
 =?utf-8?B?TGxjaXZiWUt5NjhBYmVBb0pUZkFycDVkRG9XdStjanpxMGJkNkZzSVBuZ2N4?=
 =?utf-8?B?MDYwRlltczVTUnNHWTV0MUEzS3ZTRFl1RWRlRitSTjVsT1cwRHFsNThDUXZX?=
 =?utf-8?B?K2ZoSVdhalFqcjZSNjVMVEgzSUxYNEtjN2tPek96NDVoVlFwNDNibFJPNnhx?=
 =?utf-8?B?MFRVdU1NNUNUdzFiMExOYUE3Nyt2Ym5acGFBT0Q2NEk5d3p4aTVkM3g0MzFw?=
 =?utf-8?B?N1htY0NJd20xdkYyMUlsWC9KV3JjVXZXaGNTdWJUeHQvdnNicE14eXJmbmsv?=
 =?utf-8?B?Y2ZJQlFnWVBnbkRNOHlVelVBdXNaWlJaOUdsNjVpbUV2MzArSWx4d2FLZ09p?=
 =?utf-8?B?NXFoZ3I0Qm43THpZNDBBQy8yUi81SXY4dDlDRWtCeU1pQ01LTUlTU2w0dXdV?=
 =?utf-8?B?cnRmMW1IeXhpT1NXWFFOdTI0Vlppa2ZydVE2enFqTHcyU0xjeFIvL0JZTHZw?=
 =?utf-8?B?cS9QWlNZTGhMNDg2VVhkRjJIZHoyU2w0WU9lQlFIcUNCS1VIWFplZGtWSWVC?=
 =?utf-8?B?Mm5HYVVBV1RCR203YmwxTTg1R3hFRHlTZDB2VjZXbkxsRjlBYkpTWHk4OXlh?=
 =?utf-8?B?UGdpVEF3VzZnemw4cDdIWmxnSlpaL1pnVFpaRWFOUndTY21tSEoxcDc3MzlL?=
 =?utf-8?B?K2tsb3dJdHhUVTFIM0lmeXdDZnVrQWgveTRnbmxlK01WTDZnV2VqaU92MkFB?=
 =?utf-8?B?d3I1VVJJblpsWVp6Zk5BWGhyeXlVZ1FQRHBVRUQvSHRkeVZVUkQ1K3lTblNz?=
 =?utf-8?B?UXozWHNiQjhjOFd6c2p0ZkxEbzA4ZUF6NVJzcFNsalhBeTdlb2Y0dXdDa0JM?=
 =?utf-8?B?Mk5jckQ1bUxjS2hqMEFISWJVMUJqTGtOako4ZEprcDNLQjdZZ3hDTE8yMlQx?=
 =?utf-8?B?UjhNMWtxTHlzcnVDT3htTEdJdXlvQ0NjME03NEwxRmozYzNVRU1lMzZSa2cv?=
 =?utf-8?B?MUdlRGVYZUpxM1JVbWg1dkFFalN4cy83ZmJEcHZ5aWlaalpIejJxbGsyRDFQ?=
 =?utf-8?B?ZTZTbU9jVnltWXEzck5WV2dVRmlmRmlLS3RobFdrbGl0ckR4dlpyZ3p2cUZy?=
 =?utf-8?Q?eMFg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b064fb8-597b-4feb-9537-08dddfcfc267
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 09:55:56.9121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjiZCQws3CXl+Thgu+aPGPOW2e3gn1F8P+fR1+/4TwouH+UCtgtTot8H0yp6s96ayzrXaqu5dhfAjDI9siJjog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4667
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDA4NyBTYWx0ZWRfX69Cs3lb3GZuw
 aborF+Kc7BfnDh3+DwDcHO9aGSiinJ0CpsHrMvdE7sqXKnc6RL4qgS9I0bfyQeuAckzZptnV2/s
 hqC99W94WnPNopBks/GX87xl+Xz0xUS13knmDZiR8moJDITsIlQug9Me4eCqB2NCQgUGOPthENN
 rNpN55ZoBQu3+rt4JXJMreoduLZQIdwt1XEcWqRL0BUnv3RN6cJQJE4kComQX/6YvYaJhosyEHB
 GCzejHXzkwIvc3w7ahEyF4fdg50Z7t4EyFQ7iO8UPqHQvDCOroxzUAfZiFijsQE13NZLk+ycxXR
 mD0Tp5ooumCwBoPS1Q22yoo1woz/V5JfK/JsydnKS7eFp8Z3653GJ1Dih0yfn0YAYFuPA9LBHaI
 awhxFmtflwPhz0k2tGvgeEA1jraFZjEt1AaTnStPs2seAUyc9k+qYD1dzlwmJ7n2G5G7IUdQ
X-Proofpoint-ORIG-GUID: TnlsuB3FItPgxSxiu9yaF4yT-_LT-Aq2
X-Proofpoint-GUID: TnlsuB3FItPgxSxiu9yaF4yT-_LT-Aq2
X-Authority-Analysis: v=2.4 cv=A8w1/6WG c=1 sm=1 tr=0 ts=68a59baf cx=c_pps
 a=u2yiik+OH6Wxblq00xKCnQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=AgAr5jpThScR_qU0UTQA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
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

PiBPbiBUdWUsIDE5IEF1ZyAyMDI1IDExOjIxOjA2ICswNTMwDQo+IDxza29yaUBtYXJ2ZWxsLmNv
bT4gd3JvdGU6DQo+IA0KPiA+ICsvKipAe0BuYW1lIFBPUlQgdHlwZQ0KPiA+ICsgKiBFdGhlcm5l
dCBwb3J0IGxpbmsgY29ubmVjdG9yIHR5cGUNCj4gPiArICovDQo+ID4gK2VudW0gcnRlX2V0aF9s
aW5rX2Nvbm5lY3RvciB7DQo+ID4gKwlSVEVfRVRIX0xJTktfQ09OTkVDVE9SX05PTkUgPSAwLCAg
ICAgLyoqPCBOb3QgZGVmaW5lZCAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9UUCwg
ICAgICAgICAgIC8qKjwgVHdpc3RlZCBQYWlyICovDQo+ID4gKwlSVEVfRVRIX0xJTktfQ09OTkVD
VE9SX0FVSSwgICAgICAgICAgLyoqPCBBdHRhY2htZW50IFVuaXQgSW50ZXJmYWNlICovDQo+ID4g
KwlSVEVfRVRIX0xJTktfQ09OTkVDVE9SX01JSSwgICAgICAgICAgLyoqPCBNZWRpYSBJbmRlcGVu
ZGVudCBJbnRlcmZhY2UNCj4gKi8NCj4gPiArCVJURV9FVEhfTElOS19DT05ORUNUT1JfRklCRVIs
ICAgICAgICAvKio8IE9wdGljYWwgRmliZXIgTGluayAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NP
Tk5FQ1RPUl9CTkMsICAgICAgICAgIC8qKjwgQk5DIExpbmsgdHlwZSBmb3IgUkYNCj4gY29ubmVj
dGlvbiAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9EQUMsICAgICAgICAgIC8qKjwg
RGlyZWN0IEF0dGFjaCBjb3BwZXIgKi8NCj4gPiArCVJURV9FVEhfTElOS19DT05ORUNUT1JfU0dN
SUksICAgICAgICAvKio8IFNlcmlhbCBHaWdhYml0IE1lZGlhDQo+IEluZGVwZW5kZW50IEludGVy
ZmFjZSAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9RU0dNSUksICAgICAgIC8qKjwg
TGluayB0byBtdWx0aXBsZXggNCBTR01JSQ0KPiBvdmVyIG9uZSBzZXJpYWwgbGluayAqLw0KPiA+
ICsJUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9YRkksICAgICAgICAgIC8qKjwgMTAgR2lnYWJpdCBB
dHRhY2htZW50IFVuaXQNCj4gSW50ZXJmYWNlICovDQo+ID4gKwlSVEVfRVRIX0xJTktfQ09OTkVD
VE9SX1NGSSwgICAgICAgICAgLyoqPCAxMCBHaWdhYml0IFNlcmlhbCBJbnRlcmZhY2UgZm9yDQo+
IG9wdGljYWwgbmV0d29yayAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9YTEFVSSwg
ICAgICAgIC8qKjwgNDAgR2lnYWJpdCBBdHRhY2htZW50IFVuaXQNCj4gSW50ZXJmYWNlICovDQo+
ID4gKwlSVEVfRVRIX0xJTktfQ09OTkVDVE9SX0dBVUksICAgICAgICAgLyoqPCBHaWdhYml0IElu
dGVyZmFjZSBmb3INCj4gNTAvMTAwLzIwMCBHYnBzICovDQo+ID4gKwlSVEVfRVRIX0xJTktfQ09O
TkVDVE9SX1hBVUksICAgICAgICAgLyoqPCAxMCBHaWdhYml0IEF0dGFjaG1lbnQgVW5pdA0KPiBJ
bnRlcmZhY2UgKi8NCj4gPiArCVJURV9FVEhfTElOS19DT05ORUNUT1JfQ0FVSSwgICAgICAgICAv
Kio8IDEwMCBHaWdhYml0IEF0dGFjaG1lbnQgVW5pdA0KPiBJbnRlcmZhY2UgKi8NCj4gPiArCVJU
RV9FVEhfTElOS19DT05ORUNUT1JfTEFVSSwgICAgICAgICAvKio8IDUwIEdpZ2FiaXQgQXR0YWNo
bWVudCBVbml0DQo+IEludGVyZmFjZSAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9T
RlAsICAgICAgICAgIC8qKjwgUGx1Z2dhYmxlIG1vZHVsZSBmb3IgMQ0KPiBHaWdhYml0ICovDQo+
ID4gKwlSVEVfRVRIX0xJTktfQ09OTkVDVE9SX1NGUF9QTFVTLCAgICAgLyoqPCBQbHVnZ2FibGUg
bW9kdWxlIGZvciAxMA0KPiBHaWdhYml0ICovDQo+ID4gKwlSVEVfRVRIX0xJTktfQ09OTkVDVE9S
X1NGUDI4LCAgICAgICAgLyoqPCBQbHVnZ2FibGUgbW9kdWxlIGZvciAyNQ0KPiBHaWdhYml0ICov
DQo+ID4gKwlSVEVfRVRIX0xJTktfQ09OTkVDVE9SX1NGUF9ERCwgICAgICAgLyoqPCBQbHVnZ2Fi
bGUgbW9kdWxlIGZvciAxMDANCj4gR2lnYWJpdCAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NPTk5F
Q1RPUl9RU0ZQLCAgICAgICAgIC8qKjwgTW9kdWxlIHRvIG11dGlwbGV4IDQgU0ZQIGkuZS4NCj4g
NCoxPTQgR2JwcyAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9RU0ZQX1BMVVMsICAg
IC8qKjwgTW9kdWxlIHRvIG11dGlwbGV4IDQNCj4gU0ZQX1BMVVMgaS5lLiA0KjEwPTQwIEdicHMg
Ki8NCj4gPiArCVJURV9FVEhfTElOS19DT05ORUNUT1JfUVNGUDI4LCAgICAgICAvKio8IE1vZHVs
ZSB0byBtdXRpcGxleCA0IFNGUDI4DQo+IGkuZS4gNCoyNT0xMDAgR2JwcyAqLw0KPiA+ICsJUlRF
X0VUSF9MSU5LX0NPTk5FQ1RPUl9RU0ZQNTYsICAgICAgIC8qKjwgTW9kdWxlIHRvIG11dGlwbGV4
IDQgU0ZQNTYNCj4gaS5lLiA0KjUwPTIwMCBHYnBzICovDQo+ID4gKwlSVEVfRVRIX0xJTktfQ09O
TkVDVE9SX1FTRlBfREQsICAgICAgLyoqPCBNb2R1bGUgdG8gbXV0aXBsZXggNA0KPiBTRlBfREQg
aS5lLiA0KjEwMD00MDAgR2JwcyAqLw0KPiA+ICsJUlRFX0VUSF9MSU5LX0NPTk5FQ1RPUl9PVEhF
UiA9IDMxLCAgIC8qKjwgbm9uLXBoeXNpY2FsIGludGVyZmFjZXMNCj4gbGlrZSB2aXJ0aW8sIHJp
bmcgZXRjICovDQo+ID4gK307DQo+ID4gKy8qKkB9Ki8NCj4gPiArDQo+IA0KPiBkb2MgYnVpbGQg
ZmFpbHMgd2hlbiB5b3UgYWRkIHRoaXMuDQo+IA0KPiBQbGVhc2UgdGVzdC4NCj4gDQo+IFszMC8x
OTk2XSBHZW5lcmF0aW5nIGRveHlnZW4taHRtbCB3aXRoIGEgY3VzdG9tIGNvbW1hbmQNCj4gRkFJ
TEVEOiBbY29kZT0xXSBkb2MvYXBpL2h0bWwNCj4gL3Vzci9iaW4vcHl0aG9uMyAuLi9kb2MvYXBp
L2dlbmVyYXRlX2RveHlnZW4ucHkgZG9jL2FwaS9odG1sDQo+IC91c3IvYmluL2RveHlnZW4gZG9j
L2FwaS9kb3h5LWFwaS1odG1sLmNvbmYNCj4gL2hvbWUvcnVubmVyL3dvcmsvZHBkay9kcGRrL2xp
Yi9ldGhkZXYvcnRlX2V0aGRldi5oOjMzNTogZXJyb3I6IE1lbWJlcg0KPiBydGVfZXRoX2xpbmtf
Y29ubmVjdG9yIChlbnVtZXJhdGlvbikgb2YgZmlsZSBydGVfZXRoZGV2LmggaXMgbm90IGRvY3Vt
ZW50ZWQuDQo+ICh3YXJuaW5nIHRyZWF0ZWQgYXMgZXJyb3IsIGFib3J0aW5nIG5vdykgVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0KPiAgIEZpbGUgIi9ob21lL3J1bm5lci93b3Jr
L2RwZGsvZHBkay9idWlsZC8uLi9kb2MvYXBpL2dlbmVyYXRlX2RveHlnZW4ucHkiLA0KPiBsaW5l
IDEzLCBpbiA8bW9kdWxlPg0KPiAgICAgc3VicHJvY2Vzcy5ydW4oZG94eWdlbl9jb21tYW5kLCBj
aGVjaz1UcnVlLCBzdGRvdXQ9b3V0KQ0KPiAgIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuMTAvc3Vi
cHJvY2Vzcy5weSIsIGxpbmUgNTI2LCBpbiBydW4NCj4gICAgIHJhaXNlIENhbGxlZFByb2Nlc3NF
cnJvcihyZXRjb2RlLCBwcm9jZXNzLmFyZ3MsDQo+IHN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vy
cm9yOiBDb21tYW5kICdbJy91c3IvYmluL2RveHlnDQoNCk15IGJhZCwgSSBkaWRu4oCZdCBub3Rp
Y2UgdGhpcy4gVGhhbmtzIGZvciBwb2ludGluZyBpdC4gDQo=
