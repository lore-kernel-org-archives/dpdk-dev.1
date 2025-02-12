Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC427C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 05:14:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98C4B402A7;
	Wed, 12 Feb 2025 06:14:05 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B831540269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 06:14:03 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C59KZw014233;
 Tue, 11 Feb 2025 21:14:03 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44rn8c80bd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Feb 2025 21:14:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qemBaXTKISbXhdYPFG5ftWrZ+gzZOjl2N6SbeyCGZiH0iQdIDLbLAJkjaONYiHj+EVAWyTTgj2JwkL6neZpK7BGJwcjlm18on7+z0Vd+GW1pDaJzhMXuxBhTN8llPX2ibwcngnoxNBVW7j+SawOZEq+/G4K43kMpQ3Arz1ttOCmSDSFIenD8+nTqapplDSiwRTims+VXLK0EJhjFDCW3cG2b9p40luKegUO6gUEW8ltlw3LafyjnP7a4+fZwgcQhEKOJhJfOjeGB0w4satq7DWFY2aPr8bYt9cBubQVbCqIOjYjPabpiwAohHPoU/GdKXALAVbmZ9gxzDxQD7XyAfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czP11jkuck+yOUzD9fwYGa4NjS662WGBeDT9HhjTi2g=;
 b=h7Ipq91g9FwEzX/g5q5iiUGhdN87FcCdltW44OGaaiZUWA7C5Vxv1kWqgIrIwh2NV2qVpCFe7/bz0Ds/Su2+uYLufpRzDtpoRdQCxP8Ix9BzdxjxFOxuTzOAx9pWBVebxo5rFTrL+e8GcKtUk1Dqmwa8z/E5TtBOEdShkWjVgnJ1btLn/Ep/gusBUe0ft0uvEizVxZfmcs9A9//tSLJtLhaY9LlF5fhuqsKG1Y1gWlz8HRnMdLSbitRSLWLD9udTedxzS3kZ85Do5RV6vuho0+JsazMPBOphQa67sFwbvK80KNg5zW1nM1jIxbJOP5mar1PzNtkAboE8d4EbEzVrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czP11jkuck+yOUzD9fwYGa4NjS662WGBeDT9HhjTi2g=;
 b=u6bwD6+oB9PtIbplrhhIlb+JhYSmVT5lLBq5TE7BDKeCkEKEznQqqZywd+FFmc7l6rV0+XACDaABrMqPoiJhqqeXOP5091mBrVqgpZqU46BoZgawfML0UMQE10hVQwMUsbAwCcdG9CG3opLSWGt28Bz8OVjSfSqxOS4MaAghOlU=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by DM8PR18MB4487.namprd18.prod.outlook.com (2603:10b6:8:37::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Wed, 12 Feb 2025 05:14:01 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%6]) with mapi id 15.20.8422.021; Wed, 12 Feb 2025
 05:14:00 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: RE: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary inside a
 struct
Thread-Topic: [EXTERNAL] [PATCH v3 4/6] trace: support dumping binary inside a
 struct
Thread-Index: AQHbe+OKm8hg65o+IkuRjxYAWqduELNByw9wgAAS/gCAAT8ncA==
Date: Wed, 12 Feb 2025 05:14:00 +0000
Message-ID: <CO6PR18MB386067633D5066F40955C023B4FC2@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250210174424.3364021-1-david.marchand@redhat.com>
 <20250210174424.3364021-5-david.marchand@redhat.com>
 <CO6PR18MB38608A210D1A7ED6477A0700B4FD2@CO6PR18MB3860.namprd18.prod.outlook.com>
 <CAJFAV8zKFXFG9_HXzOToPvh1feVi8h5F2BBHDkHEN2_BuQwDVQ@mail.gmail.com>
In-Reply-To: <CAJFAV8zKFXFG9_HXzOToPvh1feVi8h5F2BBHDkHEN2_BuQwDVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|DM8PR18MB4487:EE_
x-ms-office365-filtering-correlation-id: 2e1cc69f-e514-45e3-3455-08dd4b240f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UlZLU1RKU0V4alNpWlVadDFhS3Z5NWM5bVhJWmJZSzIreUtLcktGV0lKTjN4?=
 =?utf-8?B?aVliMko0N3RLOXdLMmtuVVBWRUFmRDVONFhLdks0ZWRtcGhibmtKUHBKbTVo?=
 =?utf-8?B?a0VldUVvWGJXNURCU1ErRnRUUjdpV2pMTWl3ajRzdWd4VUVNQ2cva0hSMzhD?=
 =?utf-8?B?ejliZjBSOWhDVkh3TWlxSm1PbElEUjV0TlFvNUlqcVRndkhCSnAzZ2s3VHNQ?=
 =?utf-8?B?aGk0VUpzWk5aNk5KOFlyWE9GdGhFaDh0MWhvTzVNMXpMMkUxd1VHcmE1QVFE?=
 =?utf-8?B?b1ltR2dzZ0hCY0Jqa3N4ODkyMmNmanhTQU12V2l0LzVQc01Fb2pWaTdOUkZw?=
 =?utf-8?B?MUt2cmJReHRCVlBIU083eDhQV0VGZ2JXVGlkN3BpdHVvMi9Na21vUUxVNE1o?=
 =?utf-8?B?STE0WUZJMlRKOGtNaFlaQTFiTjlMWUszRU51azBLajR1VllBMTN3WU1qcFl2?=
 =?utf-8?B?dEZFTjI3OWxhZnVpWUdxYXdTRm51OUlldDlpS1plMUdPamJHdTVERHZFTmdR?=
 =?utf-8?B?WWhaTG92dVdhbnRmNlI0VlZkWmlBbHoxRm5VOHB2N1dwR1BucnQxVEswVG1s?=
 =?utf-8?B?K1duck5MS2prL29tSUtQa0JMMnhpVDZ3bjNmTXBNME9peWN3UEU3amJtc0Fr?=
 =?utf-8?B?bU1uWi9abmZGRFNWOFlRTUtndnhQMXFpUE52MXFCRjRCSi9TbFJKcXFoV0Ux?=
 =?utf-8?B?TllNcm43bUI3MFFMcG51UTFjWS8vQXc5cmhSUmlyYnc0TFJZRHlJVjFSaDRG?=
 =?utf-8?B?WHA0cGxoZVh5Tk4yT1pteTdLTXdrYWNmSTNodXZXVEVPbzdYUndUYXJsaTVH?=
 =?utf-8?B?V3E3dXVCb2JmcDFHR1JZUkdtTFdTWTljMUJqWFVzamdZYUY1SjlJaFF3eWRy?=
 =?utf-8?B?MTJTU1NXSzVyck5FMUcvc2MzVTRTc1RKNmJNdkFsS0xYRE9VOTBmcVlaYnJE?=
 =?utf-8?B?N1BkMkxXN3ZuUk9NVDVhTXh4aXd0R05oVHhBRTd2c2lKMTI0WkxPUXpTWXlw?=
 =?utf-8?B?aEh1ZURJQndwdzExUkFiTTZJSlNKOC9BT1BSbXV2ZWI2RU9Canl0OC8rclJu?=
 =?utf-8?B?ZGp5a3RXL2x5eUxaQjl6YllwM0Z2VlNpWGthZ0dZb1ZDeWxyWEhkM1NIUkp3?=
 =?utf-8?B?VFRPS2RzcklzRzh0V3MzeC9OVktOaHNxb1dsTjJ3Y1Job3RJeUxhNjR1RFBQ?=
 =?utf-8?B?bE1la1F5Q2U3OE1VR3gzTnlFeFBFeWF0TTIyQWl6U3pmb0VLeE1LalI0MCtH?=
 =?utf-8?B?anYrUEJLSVRaRmxXdTNlZGdnSjR0TytwcktKMDdsMERNQVVpb01iTVhSNVpj?=
 =?utf-8?B?U0VCcWJiZE84c0g5SWM5TGxML0hSZGhMM2l2WU5wcmw4RDZMN2MwWUxQOWVp?=
 =?utf-8?B?OUg3RGgrOVBlQ01KYXBoS3lNR1loU1J1UytaUnVtc2YwVmJBNmNFMnVwZ3Np?=
 =?utf-8?B?d21HbzVuMWR0bXUvWGd5Tkp6RTcweXd5alhFT1dQUlRVS3hVK210c3hLSjJl?=
 =?utf-8?B?emNGUU1wdmFWQ2cxQy9kdUdCS2dqZXVGU1VWOFhxckl0ejJDYVVPUXBLWHNa?=
 =?utf-8?B?b3NteFlZRk44NW1IL1d2MWR1dlg0U0IxVitGRjZXd3lYditpckwxY2pEY3dK?=
 =?utf-8?B?VEwxRVFrRllFYlBXUk9iRW5mVTJmUjdPcjIyd0o1dW9NbTVENjI1VVJoK3FV?=
 =?utf-8?B?RW0vaW9Ea2F2VExkT1N0VGl3bmxNK1pOSWFlM1Q5c0p4UWZobHYxOC8wczNU?=
 =?utf-8?B?N09vS2N6K09JdFI5U2lnUElrVGZVWUdDMTh4K2VFdDR4cW82dWNzSDZsalgr?=
 =?utf-8?B?ajlFa0tLMFcxMUl6NjlYeFlLMGpPYzVhQkFVRU12Z29tWmJpcW8rUnhKQTJp?=
 =?utf-8?B?dUl2RUV2TDY0YWdtM1NQcWNxS0U1dlpXMDIrbkJMZmZEeFJOcWZZK0ZNdE9z?=
 =?utf-8?Q?a6c42ydIUBjJ4eJzGzOiW4kczd4R9yLw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHoyNFJQTUhSS05GNWFxVEp0OE80eEMzeldRczNhSHA4Y3ZUVmIyQ1RETGN4?=
 =?utf-8?B?RVFJMk9qeFdGbzBJdVVGQzJpaUhsTjRMQTFEK2x3RzBtUEU2NVNxMzNJYmVv?=
 =?utf-8?B?ZnpNWHRWSzRBTkVwc3JYcE1VOGdKa2VjNGMzUFh1ck5zSmY4cWZLVldXNlZ0?=
 =?utf-8?B?MVlvSEM3Q08rMHVqRkRHWHVEMmJUWVVCa3EyaWhFbE0xYjJkLzJCK2FSbml3?=
 =?utf-8?B?a2VSWHhZcFpFZmMxVm1RRk9WMTFnQWlwRFhUcFUxUzgvbEJ0ZW9UT0xXem5a?=
 =?utf-8?B?T2EyS2hmSll1S3k1NjVyMEh1eElWbVBXYzVYNmM5MWtIL3c2Tk4zMmdDUFQ5?=
 =?utf-8?B?V3dYcVp0ak9obzh3VkZtWDczNE5ibFZvdHZvZGxrdkcrdUFJT3hKZ1NXWEhm?=
 =?utf-8?B?Y01xOFI3Mm5zbnBOR3pBcEtRN1ViY05qVU1iYUp2S2ZHT25uS0xTZ2JBZWVx?=
 =?utf-8?B?WFBUU2RxSEh1SWgzMXcwNitnOCszL3MrN3ZoRjBjazFkNXA5VlpscVB6eTli?=
 =?utf-8?B?b3duemRXdUE4Y2JoZzVyWmlvSFZGRnFCdGcvUUxYVlRxMW9TSit2R1RmMy93?=
 =?utf-8?B?WTBKRU5HRGRyNENKS3I0ZTRZUHpNM2psRHlHZkNlWmVyL0NZSzVMNVBLSXAw?=
 =?utf-8?B?UmFLWXk5R3lHNEpaRDgxdUUxYUs3dS8rYWRJL3JwMVlUdUx1c0oyT0dNejZB?=
 =?utf-8?B?VDkzV3VNTGlKTW9HZzhhLzZVb2dKSU12OXcwWTcvSlFKcmh6dk1xZy8rczZ0?=
 =?utf-8?B?MW9mU051NWlZYTh4WThaazFVU09aQ3JUS1o5emhWK25vOUR2Y2RMa0hPZjZz?=
 =?utf-8?B?ODBjajBudFUvRjdoZ1htZ1ZUcTNHRUswMUdqWW1tMnFYTFZRM05uQWZnbnFT?=
 =?utf-8?B?cVZhNDBrRE9sb0FiWCtZeWJNWVMvSWFLWDR1cHJ1cjYzdXd4VFBjd3d4S21t?=
 =?utf-8?B?aE5tYkIxL1FnMG1qR0diS0NtejBxQ0YvekwyYkhiMHNEMkF2VktxTWppM1Qx?=
 =?utf-8?B?MGxVUCszLzNkOVV3bUtvS2tLZkVvZzE0d1BlSU90WmtUUHpUdzFSNDluMDlo?=
 =?utf-8?B?cDQvNGcxTEYwMjR2SGR1TWdEM2RTaVFlMU9SbS9qcUVPV2hzRlA2MytmbUNC?=
 =?utf-8?B?RHFvQ21OT1VVdWZ0RENXYTJkTmFiK1JsZW5Xa0RmYUpUNml5MVZuTDQzMzdX?=
 =?utf-8?B?Q2ROeUtOLytNdUgwenE4c3dBWXFDSmp4SDI5Q25RMlhEazFOUzNiVkl4MTJv?=
 =?utf-8?B?YmFQbjdGaTJTc09WcFFIL3l6WThORTNjUnVSSytvbmVSOEtVbnB5UlJWazc4?=
 =?utf-8?B?N3RweHVNRFg3RGF5b09yZktxYVY1UVFhOVBQOHBhUTNUUTdmN1U4VzA3elZS?=
 =?utf-8?B?Rms1Yyt2b081NTJiTG41Rjg0VW01UmRXTmNkZUlONlpFNjhVZWJ6SkRFZWR1?=
 =?utf-8?B?eHJzemV1OXRJV1o5bmIrZmlWWDg4RkV1WmhUUlBLVTViMUJjdGl2dTdHUHBt?=
 =?utf-8?B?ZlBoN3FHTlpsYVhzTWpvVGJjZzRmMkR3T2VnV2phRU45aS9YZFZvbDlvMk1l?=
 =?utf-8?B?YTZzVzRyNmRjMWtIQ0t5Yi8yRElTOWJTVmc5Tm50ajRwanFhOXltQmwybnBI?=
 =?utf-8?B?a0tEZytIRTJQeG5ieU1BaVREU1MzeVFKR0VZRDhvNHI5SDROcnJKazdDQ2Y4?=
 =?utf-8?B?RDdTa1hjdnFYc0hQK0JwOS9HS2tsNFFad1ZlVFFiTDQvZG9lZ1VFam1RU1Mx?=
 =?utf-8?B?ZTJ2eDhLcDFvZk9nYlU1WFJQcWxLL205M0FLMk5UeEZTcFh3bU5aOVQrZEtz?=
 =?utf-8?B?VzJ4bitDNkRXalorbjY1bkdOZlZpWTVpaFdoUUtCNlF4RVArMFVneFczQTNs?=
 =?utf-8?B?OEtqWXFxak52WlJKcWFGOGgzOGl1S0VzRXBxTnB0L3UrbktHbFlVTVc1aC9a?=
 =?utf-8?B?WGh2d09hMkNhY3NUa0JRWWJPWjJiQ0RUb3JnZi9yKzhHbW1FVFJiMTJUaUor?=
 =?utf-8?B?ZDAwOHl3MTlDbkt0cFRFamNEaCtONWlzWlNkaEM2a1JLLzVUbk9Kak56QWlv?=
 =?utf-8?B?d3RTOVROK2VHRUZyUXJINkpiTVJxWWlkak5YengzVGpqWmxlUG1ZdHhXd2R4?=
 =?utf-8?B?U2V4cm9HMVNBVmNvbklZbHNaZVlrQlFxenZBbXZYR0RCMGM4MjN3a3NBUHNs?=
 =?utf-8?Q?+Ue/K3ofQBfWK9PiXXYyvIg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1cc69f-e514-45e3-3455-08dd4b240f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 05:14:00.8509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgJfKqaMrM5n/IiKbVlaTFjrZvgcsmaDcBVpvzjPSs7GzENdbXCJvk9oE8lo3hyyf10WBrVRdhmpHbl1mD9paQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4487
X-Proofpoint-ORIG-GUID: Xbw8x_aoMwcLNc3JV2hdzYNoAj2_n14_
X-Proofpoint-GUID: Xbw8x_aoMwcLNc3JV2hdzYNoAj2_n14_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_01,2025-02-11_01,2024-11-22_01
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

PiBPbiBUdWUsIEZlYiAxMSwgMjAyNSBhdCA5OjUz4oCvQU0gU3VuaWwgS3VtYXIgS29yaSA8c2tv
cmlAbWFydmVsbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbGliL2Vh
bC9jb21tb24vZWFsX2NvbW1vbl90cmFjZV9jdGYuYw0KPiA+ID4gYi9saWIvZWFsL2NvbW1vbi9l
YWxfY29tbW9uX3RyYWNlX2N0Zi5jDQo+ID4gPiBpbmRleCA2YmM4YmI5MDM2Li5kOWIzMDdlMDc2
IDEwMDY0NA0KPiA+ID4gLS0tIGEvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl90cmFjZV9jdGYu
Yw0KPiA+ID4gKysrIGIvbGliL2VhbC9jb21tb24vZWFsX2NvbW1vbl90cmFjZV9jdGYuYw0KPiA+
ID4gQEAgLTM3OCw2ICszNzgsOSBAQCBjaGFyICp0cmFjZV9tZXRhZGF0YV9maXh1cF9maWVsZChj
b25zdCBjaGFyDQo+ICpmaWVsZCkNCj4gPiA+ICAgICAgICAgICAgICAgIi0+IiwNCj4gPiA+ICAg
ICAgICAgICAgICAgIioiLA0KPiA+ID4gICAgICAgICAgICAgICAiICIsDQo+ID4gPiArICAgICAg
ICAgICAgICImIiwNCj4gPiA+ICsgICAgICAgICAgICAgIigiLA0KPiA+ID4gKyAgICAgICAgICAg
ICAiKSIsDQo+ID4gQWRkaW5nIGJyYWNrZXRzIG1ha2VzIHRva2VuIG5hbWVzIGEgYml0IGNvbXBs
ZXguIFNhbWUgbmFtZSBpcyB1c2VkIGluDQo+ID4gbWV0YWRhdGEgZmlsZSB0byBkdW1wIHRoZSB0
cmFjZXMgdG8gdGhlIHVzZXIuIFdpdGggdGhpcyBjb21wbGV4IG5hbWUsDQo+ID4gdXNlciBtaWdo
dCBub3QgdW5kZXJzdGFuZCB0aGUgcHVycG9zZSBvZiB0aGF0IGluZm9ybWF0aW9uLg0KPiA+DQo+
ID4gRm9yIGV4YW1wbGUsIF9jb25mX3NyY19wb3J0X3BjaWVfc2l6ZW9mX3VpbnQ2NF90XyBpcyBj
cmVhdGVkIGluDQo+ID4gbWV0YWZpbGUgYW5kIHNhbWUgd2lsbCBiZSBkdW1wZWQuIEJ1dCB3aXRo
IHRoaXMgVXNlciBtaWdodCBub3QgZ2V0IHRoYXQNCj4gd2hpY2ggaW5mb3JtYXRpb24gaXMgcHJv
dmlkZWQuDQo+IA0KPiBJbiBwcmFjdGljZSwgYXMgdGhlcmUgaXMgbm8gb3RoZXIgZG9jdW1lbnRh
dGlvbiBmb3IgYSB0cmFjZSBwb2ludCBhcmd1bWVudHMsIGENCj4gdXNlciBuZWVkcyB0byByZWFk
IHRoZSB0cmFjZSBwb2ludCBkZWZpbml0aW9ucy4NCj4gU28gaXQgc2VlbXMgdHJpdmlhbCB0byBt
ZSB0byBsaW5rIGEgdmFyaWFibGUgbmFtZSBpbiB0aGUgdHJhY2UgcG9pbnQgZW1pdHRlciwgYW5k
DQo+IHRoZSBtZXRhZGF0YSBpbiB0aGUgdHJhY2UgZmlsZXMuDQo+IA0KPiA+DQo+ID4gVGhpcyBp
cyB0aGUgcmVhc29uOyB3ZSBmb2xsb3dlZCB0aGUgZXhpc3RpbmcgbmFtaW5nIGNvbnZlbnRpb24g
d2hpY2ggaXMgdXNlcg0KPiBmcmllbmRseS4NCj4gDQo+IFVzZXIgZnJpZW5kbHk/IEkgZG9uJ3Qg
c2VlIGhvdyB0aGlzIGlzIGRpZmZlcmVudCB3aXRoICcuJyBhbmQgJy0+Jy4NCkluIGdlbmVyYWws
IHN0cnVjdHVyZSBmaWVsZHMgYXJlIGdpdmVuIGEgcHJvcGVyIG5hbWUgdG8gcmVwcmVzZW50IHRo
ZSBwdXJwb3NlLg0KV2hlbiB3ZSB1c2UgaXQgZGlyZWN0bHkgaW4gdHJhY2UgcG9pbnQgdXNpbmcg
Jy4nIG9yICctPicgdGhlbiBpdCByZW1haW5zIGEgbWVhbmluZ2Z1bCBuYW1lLg0KQWRkaW5nIG1v
cmUgdG9rZW5zIGluIG5hbWUsIGlzIG1ha2luZyB0aGVtIGNvbXBsZXggYW5kIGRldmlhdGluZyBm
cm9tIHRoZXJlIG1lYW5pbmcuIA0KDQpJIGFtIG5vdCBzYXlpbmcgdGhhdCB0aGUgbWVudGlvbmVk
IHN1cHBvcnQgc2hvdWxkIG5vdCBiZSB0aGVyZS4gSSBhbSBqdXN0IHRyeWluZyB0byBjb252ZXkN
CnRoYXQgSWYgaXQgaXMgcG9zc2libGUgdG8gbWFrZSBtZWFuaW5nZnVsIG5hbWVzLCB0aGVuIHRo
YXQgd2lsbCBiZSBtb3JlIGhlbHBmdWwuIA0KDQo+IFdoYXQgaXMgbWlzc2luZyBpcyBkb2N1bWVu
dGF0aW9uLCBhcyBub3RoaW5nIGRlc2NyaWJlcyB0aGlzIHNhbml0aXNhdGlvbiBpbiB0aGUNCj4g
Zmlyc3QgcGxhY2UgKGV2ZW4gYmVmb3JlIHRoaXMgc2VyaWVzKS4NCj4gDQo+IA0KPiAtLQ0KPiBE
YXZpZCBNYXJjaGFuZA0KDQo=
