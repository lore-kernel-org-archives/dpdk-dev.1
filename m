Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CACE74906
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 03:09:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C08A140262;
	Wed, 24 Dec 2025 04:09:07 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26]) by mails.dpdk.org (Postfix) with ESMTP id 971544025A;
 Wed, 24 Dec 2025 04:09:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggeMQ+euqX5cb2pZDx9Z1ZVH+OMBZ5fusZT7Y75x4icOGp1xp6I6U6wWKTEvxnAuxfcgpWqv405wbIgKwqlSc2uqMzInJnpyj1n1uZInqfhyIWvjPulrEOlGKJHLdSSfgzCT/99yz6mcWDVA+zXOfQTY23Nz6AiBg+IYzLy/KTUv4xLVlukcW4Ypbm4wfkK/6tCrEm8NEqWhtA5hsmta7uESxZHFhG3DxiA5UKiOq49L4da0ozm8kVZ6rA+QJXT52OsCOqJPzGDkMzSd/3gVaUuNIN4rmsc7rXIYL876UOpfGBXfP0NWGC4EoxnjlUVzdMO8diZ4eDuX+AYWLUOFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6Is1ssYtPlyWdJz474C/mgypoEzhhxOZJWTpJFu28Y=;
 b=wcnQ9bfIDSAngarQezqky5zmU3pcvErcfuMNjj6eoyQ0qFchOJsOTcM8NlzgXrZAgrSoCjQ6Q5NK3YET+rU+ieCriGeDjIn+ww1vxT8Wd90TLSLwOWsOafWZ7UyanN5h1LOzypw70GwSgMaYUZvk26cKW8qAZNhirzWEepHuD0bhgskFiRG+F/SD4VuexG/SRAq6HNVdPQcDctoHeLc2Gib98Mnm76YPF3/KuVnMJuSRiuXVG4yVvHXJZWnW7F/tybe2BZ6f0J1YW6J/N3eyhyhtXXaQLLMCuENn33LrGRj70YCrw0GZ9sXkQXRE1aNmFdHfAL3WA2ZnKqEswWyhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6Is1ssYtPlyWdJz474C/mgypoEzhhxOZJWTpJFu28Y=;
 b=bxSv3a85zMmYtDA2XV1a5qliyuCchiHi9KZEse59hRywLD9U6mfq/a6eLYPFDEpstpTvnLxp4IsIZOPXMWtXIeJRpirRpX413Ulp4foqwFBsQWO8HD+DWtZtUQWtCKe9wJYuMiarTk2uabw/WmD4/TWY/MRunfxPoVmDw6R2sp8x+lbcIXjhR8dO1xqpWv+mfAYNRRxvk5HQfL08anFixoqs/Ui0vnwxy2th9kbuFZVM5nfMyrJTrJ4duoQV0W7ba7QF2QtxE0Ni0/USJ9uN725EnZGYgZDAk3lBqmjtaCedwW021LhfGLDdhQ6qYl1n8BiLPsH0bWV3mYcSvdkvwg==
Received: from IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 03:09:03 +0000
Received: from IA1PR12MB6628.namprd12.prod.outlook.com
 ([fe80::ca04:6b1f:7abf:3409]) by IA1PR12MB6628.namprd12.prod.outlook.com
 ([fe80::ca04:6b1f:7abf:3409%4]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 03:09:03 +0000
From: "Minggang(Gavin) Li" <gavinl@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, Luca Boccassi
 <luca.boccassi@gmail.com>, Ali Alnubani <alialnu@nvidia.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, John
 McNamara <john.mcnamara@intel.com>, Raslan Darawsheh <rasland@nvidia.com>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>, Salaheddin
 Badawi <sbadawi@nvidia.com>, Wael Abualrub <waela@nvidia.com>
Subject: RE: 22.11.11 patches review and test
Thread-Topic: 22.11.11 patches review and test
Thread-Index: AQHcZLjPdWp6Eq8EF06PevT7dufUdbUnzUgAgAABGQCAAAiiAIAAAnMAgAXI1QCAAb+3AIAA1X6Q
Date: Wed, 24 Dec 2025 03:09:03 +0000
Message-ID: <IA1PR12MB662825D68B439AA92B0D249EB3B2A@IA1PR12MB6628.namprd12.prod.outlook.com>
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <18458ac8-1c0d-4bc9-bf4b-97ee06c1eef0@nvidia.com>
 <CAMw=ZnRXeX+UxekNOFtkeTbWYyBm-WosWqOi3MtkQ+4Ot3mFpg@mail.gmail.com>
 <4132b192-db18-4df2-a755-44405501330d@nvidia.com>
 <CAMw=ZnQwf8cH_cO9CK3Y--XmzYU+cfCNJ3YWe8qjNZbuCfSe6Q@mail.gmail.com>
 <CAMw=ZnRPba=cPc1waWhmzkkSK_+iKpdhuFf8u9QZZqDjmScUYA@mail.gmail.com>
 <CH3PR12MB8074149AF08F3DDE53EB3F7FB2B5A@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8074149AF08F3DDE53EB3F7FB2B5A@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6628:EE_|PH7PR12MB5927:EE_
x-ms-office365-filtering-correlation-id: b5da3b26-77cc-414e-59a5-08de4299cab3
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MDVJeG9kUCtvbS8zN0E3aTVIdTV2SzJJa3JlcFJZdThpaHZIbHdSQ0N6U3hz?=
 =?utf-8?B?UkIrc0R2RTZSTEdPd3c3ZVhmNnBpQU9tSHczQ3VGNmJBQm4zV1dRYTZSdkpP?=
 =?utf-8?B?MVk2WVFRMzRrRlNPalExbTcxOEprbWNlV3ZIRVZJSDIyODk1ZVhXQ0ZINzhP?=
 =?utf-8?B?aHNhalkzd3dqdEFKaXVQc3ZBelFBWEh3T1R6TlBsVVlEZURYZzFRaklNT0lX?=
 =?utf-8?B?UnU2TXVMWW5TbWV3Rk5VbmFYN254NG9yTEl1dzZ1YkFSRUk3elMvSTFNUGpv?=
 =?utf-8?B?UDZNRlFQVk9IRnhqbzlSVUFOYmxIZTRhUXFMdUdtSVZUQ09FUE9iV203QWJ3?=
 =?utf-8?B?UWpCZkMzYjU3TFFwM1YvYUk3T0ZpY2dlYXZ3YzRITFRPL3M4ZHdRalBZd0tK?=
 =?utf-8?B?OVJrTUxoblVtZ1NJekRPWm1qQW8rWHlPVVdtd0pkamo1c2R4RTFSOVpKd3hE?=
 =?utf-8?B?MVh5Um5LMG9qNUkrZGdnUllsQ1pvTVdPaktpZGorV2ZFWXE5TmpaS2YzalV1?=
 =?utf-8?B?MytvUnpOYXVheTBzL1dtVy8yMmJtcC85WkhVZkhYSlJ4dDlZd3pTZ0pDek5F?=
 =?utf-8?B?WHMvcFRLN2tSd0xJRWJzNjRYMW5MSHRBeGdHYkJhdDVtbnlrNEZoU1AxRGIw?=
 =?utf-8?B?M3VVMHNVZHR5cll6eVZROEJvTXRCM2VCRWd4aWg2dVRCTEVTcHFKcml5NENJ?=
 =?utf-8?B?QTByc0xwZEsyUnRSOWtmQ2JQbTZjenVQYWs4YUw4eUtJS1FlcWRzSmh5bEli?=
 =?utf-8?B?djEzQy9PdDJLZ3hYb2JrMUV0L2xxYmIxOThsVitaeitWTW9KZmc1MjR1VkR2?=
 =?utf-8?B?Q1grTTF1N3pZYjBQRGJ4UjhjM1NpZUdYNFNMU2pveUFROWl4aW1wU3gwS3RZ?=
 =?utf-8?B?TzdmSTdJbjBncnZRak9DYVdUdXl2KzZYTkdUQkk0VmYzdTJRUW5mM1FUTmd0?=
 =?utf-8?B?NHJQbkpNU1hLK2JWbXhpWlpVMmlLTnRsNWVaQ0gzWTF0NVhOZFk1dEMxT0pj?=
 =?utf-8?B?M0tHeHRBVERXY1psNWVYcTRpaTBwb2ZxUjNVaE9yb3d3bHl1UGtPWGdDQTlj?=
 =?utf-8?B?UUVDb3Y4K25XR0dJSWlGdkpJTVFreDQ2Wm9XUlcvVEY1Y1poaWd4Z05xRGtY?=
 =?utf-8?B?V3RYY0ZZM3BYSFFldDl3WHdhSFppUnY2TzJ0S2ZKZS8wOGsyUUthajJ4ZlN6?=
 =?utf-8?B?Sk9YeWZDY1A5M1NTYnZqVWErUWpQN3VlWVFuYnJRRURBUkFqTHlxRzRNOWNT?=
 =?utf-8?B?eVBySmNsQzdtd3lNOHRVYVhuOThEL2s3MGVjektVTXRqTCtmT1R2Ti8xdjl0?=
 =?utf-8?B?WHE1Y3dMUElRNm1uR1pKL3ZRbEZHK1JPNGx1dVVuS05FMmtOekVDNzMyU0Zl?=
 =?utf-8?B?eEpnOFRCLzBTRmV6NHg2YUUzMitQQ2JwaDBJbUhleThFdUNQWmwxQW1lanZa?=
 =?utf-8?B?VUtUQmNJdHZJcGxXMFpkSkVFNmpJU29oL3cyT1g1UTc0VkR2SHRiQ2lDS1dE?=
 =?utf-8?B?SDZNNzEyU21pU2xpNWh3OG1mZ3p6UXhvTlhGWXZFb1p5Ynl1T2VTSkx5c1Ny?=
 =?utf-8?B?TVovOEYzaUV3aHU5a0ZJeklPdDU4RTRxN2k4UEN0MTNJNHVyNFJTMnVyV0Yr?=
 =?utf-8?B?RnNrclIrMUMwN3pGZkxsSFhUbUlHeCtyT3lMVVVWdHUrZ0VFVGNRY3FWR3pO?=
 =?utf-8?B?bzZiSTZhNWMvM2dPODdvaDV1Sk52NzFvU1BCdE1VZDlkZ0xSL0l2YW9VZDZS?=
 =?utf-8?B?TmdLVi9qOXJLalhGa1N1a2R4RENoOFVPZjZBekI0TUNBRGtxdXVlY3M0UXZi?=
 =?utf-8?B?WXpYRXFUMStVYVdqdnZRbHpjUHpQKzV0VC9tdXRjcDdTZ1UrNjhLM0g1RnFm?=
 =?utf-8?B?YW9NZDRHVHVUV1J5bGtVcWNzVEdLVW5VQjZtckk0WXVVK0daMGVjclk0Wmtl?=
 =?utf-8?B?YVE2aGk5QUx3cEFDV0E0NTRuRmRsaWVrbStic3UzK0tvSmhXbmY0UmllTlRS?=
 =?utf-8?B?M0RBWEtUZVBWZEVyOE8ydnFhT1RVNmxGN1NBcWhmNlpPTmdEVTFEeEhTalho?=
 =?utf-8?Q?ViMnyH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6628.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3ZwR05qNmdQUDUrOTdmTjZZRHBjTE1lWGFHWG8rN3gydGhXOVZRTGNDaElu?=
 =?utf-8?B?bkkrZklUYU44SThNTGQ4bjZnd2pJTmFBZlZ2bDJ2QUE5ZXVFRUljNzVJaTYw?=
 =?utf-8?B?aisvYTFMbFpPN2pSMUZvd2o4NXFjRFlwT1o0c2hhQ3ZEd2Z1SzE1ZGxUM1FE?=
 =?utf-8?B?OWlYbFptY0VIeHNpY0pIazRtTGFQMitpamNxSldGbVIrUUV0TmtSRmZNSXB3?=
 =?utf-8?B?RFVqQkFmK3FhMkdNT3BVb0o2b3ZpSFNwdEVJUFo5VFQwTXd5djRxSHduUFdU?=
 =?utf-8?B?WEM5ZFpTVVY5clBKWnpQQnNqT1RSYUdYcWZIbEllRithZXpZS0xpUFVneUFj?=
 =?utf-8?B?NVluay8yNTdsd2N5YUQvVVJmK0dLWmV5UEY5UXRlVlE4S0xVWm5JTjBCL3Bi?=
 =?utf-8?B?dGZrYzNoUzBwVHFPQkNuMWR3M3JKdmtycC9Qb2RxQjZkZndGUXBTVy90MkEr?=
 =?utf-8?B?TmRlekhFMHVSbHlXSmd0U01hUHo1RWQyRzBoS2dEcnFRRTJLNGoxWm9kYzRt?=
 =?utf-8?B?a1pONFdWZkI0RFRkQVEyaGhaSlBKNkkwOEJRNUphYVFRSnd3aDI1OVhHNEFz?=
 =?utf-8?B?bm1XY3NMcVdFUitzcERZWjNuV1Myd0tQM0tzQ1k5NDhKbWcvNk40RWhPTGVT?=
 =?utf-8?B?Z1ErN3J5N0ZBVVVGcUV6TDJnY0xnWE9CMlVjS2NpdHRXNk9WL2YvZkc4aWlq?=
 =?utf-8?B?cnV1TllNRS9QMW1pSm50TFU4REdhMHNZYU04YStWVVNRU01meUxzN3VTc3p3?=
 =?utf-8?B?U0hPdmoySWYyU1oyU3JqcWhQVEJHZTFEcXR3NHN4ajRXeEx6c2JMRUFmdFpX?=
 =?utf-8?B?V3IzV05ma0xQUThsWFo0eXpzczNFR2gxY0x5WS91Y2t1dDdGR1cvZnpzSmhU?=
 =?utf-8?B?ZE1vWU9ZVGplNVE2R0Q5VUY5b3VkUWdnbUpiWWZ1NEU0aE9PSyt2Mm1uU013?=
 =?utf-8?B?cGlxT1lTZC9pSVVscmRKV3g4ZXo0aWpMQW0rUDMrVXF6aFA3SkZIZlYwa0py?=
 =?utf-8?B?RU1jNXFDemFyZkt0eTJYelRkSlJaK1FSZU5xcU8wU1B4aG5RelNodHJqZTZ1?=
 =?utf-8?B?c05vU2NCZ2wzN1UyeXVPMCtPLytEUnF2bEQ3WVZibGJ5UWxvRGFBMWJxZU1y?=
 =?utf-8?B?MWh6Rjk0aWtDRnpwTUdTWFFxTldMbHNxV0cvYVJabTk3bmlPQWp5RWFxSGVn?=
 =?utf-8?B?WDdXdGhvRHBJSVIvY2NhZ1N6clM2UGhPbUsycER3MzJDMHNVZ2M4TU9wU2cw?=
 =?utf-8?B?UStXemJWTWwwVDJxTHdpbG90bERoTlJzWHBnaGtTKzh0dzlML3RIeEMyd3BS?=
 =?utf-8?B?QjZqVWJhMWUra08rNXZGYXBlVmh4N1oxS0RtUlpic1QvVEUvbHd6eUV0K1pk?=
 =?utf-8?B?aWxYZXRBR3o2UW8vRHF4aUdSd0tITkpZZnpwQmJ0NmxoSklkMHBXcmNHcVZh?=
 =?utf-8?B?ME1CR3k4YjdkTEV0UUFGeDBoaVRhSDgzbm1lbk9tZE9mUlMyeGFqZFdySWQz?=
 =?utf-8?B?S09mUk8vZDJlZVdHQklSSWhML0MwYWRqNW95MkhHMmtNNWZOSlRqSmNJWnhp?=
 =?utf-8?B?bll1VjJmeFZsWFhyZjFtZUJOUExCQUtWVHBWb2ZGQmlhYUFicytKOFprZXNn?=
 =?utf-8?B?MEh5QWlERCttY1ExYlJzd0xvZlhGN3l4dXFWOWg2VkE2ZzhDOHJxY2RNbEQ2?=
 =?utf-8?B?K0tkODRzNmhIRHB1OUt2OGI3V2RNNGVMQjFhVHAwZzJFWEpnYmFBUS8yakdP?=
 =?utf-8?B?OUhZZHB6ZnIwdWlTbGVSRi9TTVkyR2h3TForakIzYkYyRzZrTmZKQ3NxQlNK?=
 =?utf-8?B?cnJMSmkxYU9ZdUxzeVRPWThrdzFQYjdXc0Rnb3BoSWdMVjljdE1kbkFYaEdt?=
 =?utf-8?B?bzFwdFNaS0NtWDhVYkdxZkFEaUZjZktOUFhhcFdoMVZqV0dZc2hYTlh4U3dq?=
 =?utf-8?B?akVDK2F6c0w5VnV1Z3c5RjMyZmQ3ZUwxNmtjUk9GZVkrN3k5UzRMdzhTKzNs?=
 =?utf-8?B?Vi9QWjA2MHNPRytsdUZpbVBMdXVRenpWVWt3Y0hjcUV0VUJHYXR1Q25ZNm44?=
 =?utf-8?B?UEs2dmtxY3k0d1BzdzF3Wm9jbkU4ZFBtY2VCRTVSR1VyQ3pEWGlIVnczd05E?=
 =?utf-8?B?ZEdiVFV4bGZXVXAxVHkzMkY3QWJ3OVZ1OFdCNEdhSUVUVHJvVXVuZjY2UHRF?=
 =?utf-8?B?TG12aTdGbTNOQzhkdTh4MFFkL3p6dis2djRkd0ZsZFBHS29WYXJNL25qNWFZ?=
 =?utf-8?B?Y2lUZjRGQVF4VmZPM0FsdlZVbldiaWpva2NaUDN6MHM0eUdVWGdPcUtHb2Za?=
 =?utf-8?Q?oV8RFAPJxJ8ZAtmM7G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6628.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5da3b26-77cc-414e-59a5-08de4299cab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 03:09:03.0797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EtKB/QE6/uYCdoHQ8+VCW67JXT2T2R77qnMy3B0eAKM0gmsCn8FPsA4OeV8kKfKxf2hse0fJMRwR3g1s5PaA7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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

SGkgTHVjYSwNCg0KVGhlIGlzc3VlKGh0dHBzOi8vYnVncy5kcGRrLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MTg1MSkgd2FzIGludHJvZHVjZWQgYnkgY2hlcnJ5LXBpY2tpbmcgc29tZSBvZiB0aGUgMyBy
ZWxhdGVkIGNvbW1pdHMgb2YgcmVmYWN0b3JpbmcgbXVsdGljYXN0IGhhbmRsaW5nIG9mIFBGIGlu
IE5WIHBtZC4gSSBkb24ndCB1bmRlcnN0YW5kIHdoeSBpdC90aGV5IHdlcmUgY2hvc2VuIGJlY2F1
c2UgdGhleSBpbmNsdWRlZCBiZWhhdmlvciBjaGFuZ2UgaW4gUEYuIFRoZXkgc2hvdWxkIG5vdCBi
ZSBiYWNrcG9ydGVkIHRvIHN0YWJsZSBvbmVzIGZyb20gbXkgcG9pbnQgb2Ygdmlldy4NCg0KVGhl
IGNvbW1pdChzKSBwb2xsdXRlZCAyMi4xMSwgMjMuMTEgYW5kIDI0LjExIHNvIGZhci4gUGxlYXNl
IHJldmVydCBiZWxvdyBjb21taXRzIHRvIGZpeCB0aGUgaXNzdWUuDQoNCjI0LjExDQpkZGNhYTE2
NzFmIG5ldC9tbHg1OiBmaXggbXVsdGljYXN0DQphZGNlNmQxMzBiIG5ldC9tbHg1OiBhbGlnbiBQ
RiBhbmQgVkYvU0YgTUFDIGFkZHJlc3MgaGFuZGxpbmcNCg0KMjMuMTENCmMwNzA0NTVlOGIgbmV0
L21seDU6IGFsaWduIFBGIGFuZCBWRi9TRiBNQUMgYWRkcmVzcyBoYW5kbGluZw0KDQoyMi4xMQ0K
NThhNjQyMWJjMyBuZXQvbWx4NTogZml4IG11bHRpY2FzdA0KZWQzNDExMjE3YiBuZXQvbWx4NTog
YWxpZ24gUEYgYW5kIFZGL1NGIE1BQyBhZGRyZXNzIGhhbmRsaW5nDQoNClJlZ2FyZHMuDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFheWFuIEthc2hhbmkgPG1rYXNo
YW5pQG52aWRpYS5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDIzLCAyMDI1IDEwOjA5
IFBNDQo+IFRvOiBMdWNhIEJvY2Nhc3NpIDxsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbT47IEFsaSBB
bG51YmFuaQ0KPiA8YWxpYWxudUBudmlkaWEuY29tPjsgTWluZ2dhbmcoR2F2aW4pIExpIDxnYXZp
bmxAbnZpZGlhLmNvbT4NCj4gQ2M6IHN0YWJsZUBkcGRrLm9yZzsgZGV2QGRwZGsub3JnOyBKb2hu
IE1jTmFtYXJhDQo+IDxqb2huLm1jbmFtYXJhQGludGVsLmNvbT47IFJhc2xhbiBEYXJhd3NoZWgg
PHJhc2xhbmRAbnZpZGlhLmNvbT47IE5CVS0NCj4gQ29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVY
VEVSTkFMKSA8dGhvbWFzQG1vbmphbG9uLm5ldD47IFNhbGFoZWRkaW4NCj4gQmFkYXdpIDxzYmFk
YXdpQG52aWRpYS5jb20+OyBXYWVsIEFidWFscnViIDx3YWVsYUBudmlkaWEuY29tPg0KPiBTdWJq
ZWN0OiBSRTogMjIuMTEuMTEgcGF0Y2hlcyByZXZpZXcgYW5kIHRlc3QNCj4gDQo+ICsrQE1pbmdn
YW5nKEdhdmluKSBMaQ0KPiANCj4gUmVnYXJkcywNCj4gTWFheWFuIEthc2hhbmkNCj4gDQo+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBMdWNhIEJvY2Nhc3NpIDxsdWNh
LmJvY2Nhc3NpQGdtYWlsLmNvbT4NCj4gPiBTZW50OiBNb25kYXksIDIyIERlY2VtYmVyIDIwMjUg
MTM6MjcNCj4gPiBUbzogQWxpIEFsbnViYW5pIDxhbGlhbG51QG52aWRpYS5jb20+DQo+ID4gQ2M6
IHN0YWJsZUBkcGRrLm9yZzsgZGV2QGRwZGsub3JnOyBKb2huIE1jTmFtYXJhDQo+ID4gPGpvaG4u
bWNuYW1hcmFAaW50ZWwuY29tPjsgUmFzbGFuIERhcmF3c2hlaCA8cmFzbGFuZEBudmlkaWEuY29t
PjsNCj4gPiBOQlUtQ29udGFjdC1UaG9tYXMgTW9uamFsb24gKEVYVEVSTkFMKSA8dGhvbWFzQG1v
bmphbG9uLm5ldD47DQo+ID4gU2FsYWhlZGRpbiBCYWRhd2kgPHNiYWRhd2lAbnZpZGlhLmNvbT47
IFdhZWwgQWJ1YWxydWINCj4gPiA8d2FlbGFAbnZpZGlhLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTog
MjIuMTEuMTEgcGF0Y2hlcyByZXZpZXcgYW5kIHRlc3QNCj4gPg0KPiA+IEV4dGVybmFsIGVtYWls
OiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4NCj4gPg0KPiA+
IE9uIFRodSwgMTggRGVjIDIwMjUgYXQgMTk6MDYsIEx1Y2EgQm9jY2Fzc2kgPGx1Y2EuYm9jY2Fz
c2lAZ21haWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFRodSwgMTggRGVjIDIw
MjUgYXQgMTg6NTgsIEFsaSBBbG51YmFuaSA8YWxpYWxudUBudmlkaWEuY29tPiB3cm90ZToNCj4g
PiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gT24gMTIvMTgvMjUgODoyNyBQTSwgTHVjYSBCb2NjYXNz
aSB3cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUsIDE4IERlYyAyMDI1IGF0IDE4OjI0LCBBbGkgQWxu
dWJhbmkgPGFsaWFsbnVAbnZpZGlhLmNvbT4NCj4gPiB3cm90ZToNCj4gPiA+ID4gPj4gT24gMTIv
NC8yNSAyOjU2IEFNLCBsdWNhLmJvY2Nhc3NpQGdtYWlsLmNvbSB3cm90ZToNCj4gPiA+ID4gPj4N
Cj4gPiA+ID4gPj4+IEhpIGFsbCwNCj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiBIZXJlIGlzIGEg
bGlzdCBvZiBwYXRjaGVzIHRhcmdldGVkIGZvciBzdGFibGUgcmVsZWFzZSAyMi4xMS4xMS4NCj4g
PiA+ID4gPj4+DQo+ID4gPiA+ID4+PiBUaGUgcGxhbm5lZCBkYXRlIGZvciB0aGUgZmluYWwgcmVs
ZWFzZSBpcyBEZWNlbWJlciAxOHRoLg0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+IFBsZWFzZSBo
ZWxwIHdpdGggdGVzdGluZyBhbmQgdmFsaWRhdGlvbiBvZiB5b3VyIHVzZSBjYXNlcyBhbmQNCj4g
PiA+ID4gPj4+IHJlcG9ydCBhbnkgaXNzdWVzL3Jlc3VsdHMgd2l0aCByZXBseS1hbGwgdG8gdGhp
cyBtYWlsLiBGb3IgdGhlDQo+ID4gPiA+ID4+PiBmaW5hbCByZWxlYXNlIHRoZSBmaXhlcyBhbmQg
cmVwb3J0ZWQgdmFsaWRhdGlvbnMgd2lsbCBiZSBhZGRlZA0KPiA+ID4gPiA+Pj4gdG8gdGhlDQo+
ID4gcmVsZWFzZSBub3Rlcy4NCj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiBBIHJlbGVhc2UgY2Fu
ZGlkYXRlIHRhcmJhbGwgY2FuIGJlIGZvdW5kIGF0Og0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+
DQo+ID4gPiA+ID4+PiBodHRwczovL2RwZGsub3JnL2Jyb3dzZS9kcGRrLXN0YWJsZS90YWcvP2lk
PXYyMi4xMS4xMS1yYzENCj4gPiA+ID4gPj4+DQo+ID4gPiA+ID4+PiBUaGVzZSBwYXRjaGVzIGFy
ZSBsb2NhdGVkIGF0IGJyYW5jaCAyMi4xMSBvZiBkcGRrLXN0YWJsZSByZXBvOg0KPiA+ID4gPiA+
Pj4gICAgICAgaHR0cHM6Ly9kcGRrLm9yZy9icm93c2UvZHBkay1zdGFibGUvDQo+ID4gPiA+ID4+
Pg0KPiA+ID4gPiA+Pj4gVGhhbmtzLg0KPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPj4+IEx1Y2EgQm9j
Y2Fzc2kNCj4gPiA+ID4gPj4gSGVsbG8sDQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IFdlIHJhbiB0
aGUgZm9sbG93aW5nIGZ1bmN0aW9uYWwgdGVzdHMgd2l0aCBOdmlkaWEgaGFyZHdhcmUgb24NCj4g
PiB2MjIuMTEuMTEtcmMxOg0KPiA+ID4gPiA+PiAtIEJhc2ljIGZ1bmN0aW9uYWxpdHk6DQo+ID4g
PiA+ID4+ICAgICBTZW5kIGFuZCByZWNlaXZlIG11bHRpcGxlIHR5cGVzIG9mIHRyYWZmaWMuDQo+
ID4gPiA+ID4+IC0gdGVzdHBtZCB4c3RhdHMgY291bnRlciB0ZXN0Lg0KPiA+ID4gPiA+PiAtIHRl
c3RwbWQgdGltZXN0YW1wIHRlc3QuDQo+ID4gPiA+ID4+IC0gQ2hhbmdpbmcvY2hlY2tpbmcgbGlu
ayBzdGF0dXMgdGhyb3VnaCB0ZXN0cG1kLg0KPiA+ID4gPiA+PiAtIHJ0ZV9mbG93IHRlc3RzDQo+
ID4gPiA+ID4+IChodHRwczovL2RvYy5kcGRrLm9yZy9ndWlkZXMvbmljcy9tbHg1Lmh0bWwjc3Vw
cG9ydGVkLWhhcmR3YXJlLQ0KPiA+ID4gPiA+PiBvZg0KPiA+ID4gPiA+PiBmbG9hZHMpDQo+ID4g
PiA+ID4+IC0gUlNTIHRlc3RzLg0KPiA+ID4gPiA+PiAtIFZMQU4gZmlsdGVyaW5nLCBzdHJpcHBp
bmcsIGFuZCBpbnNlcnRpb24gdGVzdHMuDQo+ID4gPiA+ID4+IC0gQ2hlY2tzdW0gYW5kIFRTTyB0
ZXN0cy4NCj4gPiA+ID4gPj4gLSBwdHlwZSB0ZXN0cy4NCj4gPiA+ID4gPj4gLSBsaW5rX3N0YXR1
c19pbnRlcnJ1cHQgZXhhbXBsZSBhcHBsaWNhdGlvbiB0ZXN0cy4NCj4gPiA+ID4gPj4gLSBsM2Z3
ZC1wb3dlciBleGFtcGxlIGFwcGxpY2F0aW9uIHRlc3RzLg0KPiA+ID4gPiA+PiAtIE11bHRpLXBy
b2Nlc3MgZXhhbXBsZSBhcHBsaWNhdGlvbnMgdGVzdHMuDQo+ID4gPiA+ID4+IC0gSGFyZHdhcmUg
TFJPIHRlc3RzLg0KPiA+ID4gPiA+PiAtIEJ1ZmZlciBTcGxpdCB0ZXN0cy4NCj4gPiA+ID4gPj4g
LSBUeCBzY2hlZHVsaW5nIHRlc3RzLg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBGdW5jdGlvbmFs
IHRlc3RzIHJhbiBvbiBDb25uZWN0WC02IER4IChPUzogVWJ1bnR1IDIyLjA0IHwgRHJpdmVyOg0K
PiA+ID4gPiA+PiBNTE5YX09GRURfTElOVVgtNS44LTcuMC42LjEgfCBGaXJtd2FyZTogMjIuMzUu
ODAwMikuDQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IEFuIGVuZ2luZWVyIGZyb20gbXkgdGVhbSBy
ZXBvcnRlZCAyIGlzc3VlczoNCj4gPiA+ID4gPj4NCj4gPiA+ID4gPj4gaHR0cHM6Ly9idWdzLmRw
ZGsub3JnL3Nob3dfYnVnLmNnaT9pZD0xODUxDQo+ID4gPiA+ID4+IERpZCBub3QgcmVwcm9kdWNl
IGluIDIyLjExLjEwLCBnaXQtYmlzZWN0IHBvaW50cyB0bw0KPiA+ID4gPiA+PiA1OGE2NDIxYmMz
OTYNCj4gPiA+ID4gPj4gKCJuZXQvbWx4NTogZml4IG11bHRpY2FzdCIpLi4NCj4gPiA+ID4gPiBU
aGFua3MsIGFyZSB5b3UgcGxhbm5pbmcgdG8gc2VuZCBhIGZpeCwgb3Igc2hvdWxkIEkganVzdCBy
ZXZlcnQNCj4gPiA+ID4gPiB0aGF0DQo+ID4gY29tbWl0Pw0KPiA+ID4gPg0KPiA+ID4gPiBJIHJl
YWNoZWQgb3V0IHRvIHRoZSBlbmdpbmVlciB3aG8gYXV0aG9yZWQgdGhlIHBhdGNoIGFuZCBhbQ0K
PiA+ID4gPiB3YWl0aW5nIGZvciB0aGVpciByZXNwb25zZS4gSSBtYXkgbm90IGJlIGFibGUgdG8g
Z2V0IGJhY2sgdG8geW91DQo+ID4gPiA+IHdpdGggYW4gYW5zd2VyIHRvZGF5LCB0aG91Z2guDQo+
ID4gPg0KPiA+ID4gVGhhbmsgeW91LCBubyBwcm9ibGVtIGl0IGNhbiB3YWl0IGEgd2hpbGUNCj4g
Pg0KPiA+IEhpLA0KPiA+DQo+ID4gQW55IHVwZGF0ZT8NCj4gPg0KPiA+IFRoYW5rcw0K
