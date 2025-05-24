Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C462C54E71
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 May 2025 03:29:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BEA4402DB;
	Sat, 24 May 2025 05:29:02 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by mails.dpdk.org (Postfix) with ESMTP id B50BA402D3
 for <dev@dpdk.org>; Sat, 24 May 2025 05:29:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coUlt1tpFH8qE6s5KYTVEEyz2figbujJx/LbgRgHP2gY/J43XoA53yg89lIikr4trfNf1YVNP6Z4nI3CVZR9lCyIkcPxXIq5PlTOFStNKjk96BK4CXpmt/iWK5S+SqwD8kwHa+yM7SVfS4DvTIpjukH//+zuf2vzxkLYrrf7BnR4tj+ZGBr+2my+iq1H/eIyyXgQpYy4Eu1+9FLaN5MAUh4sG8QXf2WGkEApUQpMgHuAPsRf/E4/BWSmD6WAk6PX7LrZvEVugc6M70nzQvvrmW2bFeiLmYp/eteBepzY6TGDPqfPdwdiwyjc+OScfsGzIvgJUTGj0x6T3Ma1xm83yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfQ3SeavTLqoT69V6qlEI3xeEo/17WHAKS8iqJHk4DA=;
 b=rXGxkMxy8L1+cGAyaLiWqhN57DFmdamzZh/X/e8KKF5Rr8lWnithsk3X6IV3+50Dj5S7gCneXubH27yAq5Iptkyxdz95a0ZhWespuGkMwqCW4scv6BOgndIrMkmh21C2/u2KrEgGZT7soEy5pdn/z94zxLBq2V1gHO91jH9aZXF/+HjnmE1Xj4XoNFi0sg3+u9AP4c8GvUKm7MPIoy1rDfMIJKSf/eXAsL+wNXKj0DhyCaYsMLdo1aKiYrx2pRJGMKg9uofBdC2SKDpYTa5esQmm2o9RzJvhLyy9AoC0Mr7fInSuCBZzsgHy+DxGjP2Xc7ZPVee7HOBqahTTxTSRoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfQ3SeavTLqoT69V6qlEI3xeEo/17WHAKS8iqJHk4DA=;
 b=oAW2ILOX1Jh/4pfNLNsFcQtZWmkGsGXuAHmUM/0W8WnrIQxrCtvo8hEk7phsvce1R6eDmpDpVR4HBCUtmy5U71uGP5eCteg9RSUKP01p/d6jWdiTIa0jPYYJgGs7M0CX7K5yz0db1ubrqP7YRHEdh8ZcMPEjGDOzqZVtNqh2ZuXv2aeMt1mJLFWO5MuUMQHU14UDKj75JBBt+CjDgM8heX+2egUtdPv1gPEa+fD24CfVjC+9soM5tDEps5tjzfbmTSNT1MNWEug9jBzSXlnoNhQebxoB7+EphGUXUoWrgzIEj+JgYJLQ1QlilXFFKpd7Pt21iPzBIA4/N6jHoHeMbw==
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by BL1PR12MB5756.namprd12.prod.outlook.com (2603:10b6:208:393::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sat, 24 May
 2025 03:28:57 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%7]) with mapi id 15.20.8769.019; Sat, 24 May 2025
 03:28:57 +0000
From: Xueming Li <xuemingl@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, Luca Boccassi
 <bluca@debian.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>, Michael
 Santana <maicolgabriel@hotmail.com>, Kevin Traynor <ktraynor@redhat.com>
Subject: Re: [PATCH 1/2] ci: bump tested distributions in GHA
Thread-Topic: [PATCH 1/2] ci: bump tested distributions in GHA
Thread-Index: AQHaVG0z6qPF4StH+0WLV1+ZN9yDrrPhh5uAgAKHX24=
Date: Sat, 24 May 2025 03:28:56 +0000
Message-ID: <CH3PR12MB86589E86625C1077418F1AFCA19BA@CH3PR12MB8658.namprd12.prod.outlook.com>
References: <20240131174437.2494815-1-david.marchand@redhat.com>
 <CAJFAV8yAfPZ8XrerzCj1ihGSgBLrsdQNS5D1USCEfOu+jjcEjg@mail.gmail.com>
In-Reply-To: <CAJFAV8yAfPZ8XrerzCj1ihGSgBLrsdQNS5D1USCEfOu+jjcEjg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8658:EE_|BL1PR12MB5756:EE_
x-ms-office365-filtering-correlation-id: ff7c6027-56c1-40b4-2ce4-08dd9a731de3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MTY0amJXQlJ2Vi85b3FFZlNBanoyVkkyQVBpY3NGM0J6TzhzZmFnb1hVTkZ4?=
 =?utf-8?B?djdWelpraWsyZ3NNMTRsSENIVDM2bXZKNDZXaGd6LzBhb2NvY2hrRW9ubWts?=
 =?utf-8?B?emkrNTFSQmpSRmFDMmljTTNuU0lMVVlwa05iL0dYWjQwUmhiNHIwTks4aFky?=
 =?utf-8?B?azJPWmV0NS91QnhvaEt3U3BMMEEvWERhM3NHUlVNcWs5YXJxc1B5TGZERkpK?=
 =?utf-8?B?cHV0MXpGMUpwdmVES2tuS2tOYXZBT3M4ZXJGSWtnWHZwNjM2UzNOSC9Hc2lm?=
 =?utf-8?B?K2QwNjQwQTE5NnkwL0dHV2EvS3VIY0JCeHpsYVk3dngwQmZkSXZPUllYQlZk?=
 =?utf-8?B?a2R2YU9VOVBMV1FyYW9Zdy90SCt3NVRsQ0hUWTVxeEREVUJhcGlzU3FxZkFp?=
 =?utf-8?B?ejRPM3NVbUlETjdkS28veStxMm5XMDhUQlJqQy9MMEpkZnJpWll1YlBoN3NS?=
 =?utf-8?B?eUZsUzhBNjY4MXptSG5EWm02Q2V4Q2FGTHRLRVNvWjVYQzFYZ092SW5lNXVm?=
 =?utf-8?B?amQyemVRU1pwbUhOd3F6aTh0dTJCT2FBOW5OMUxPSVpTVW1wZHlMRFUzTmU2?=
 =?utf-8?B?Rnp3VFhlVEdKc3VGTVE0SVFwazg5SjlzYmR4ZUZkcm1FQ2ZRMXhzbS9JMkFD?=
 =?utf-8?B?L0RqdE9WRVl3UmJXUTd4K0NKbTNyQkNNQjFFOXY1NnBJcmJrSFh6SHpBaDRr?=
 =?utf-8?B?K1Vid0ZKOVNpbkpsS3ErTE0rR3Y0Y1h1NlhibzZ1Y09HRGdaOG5jRVpqdE5E?=
 =?utf-8?B?QjVwV21tdHl3cTVYMm90YU1oSFI4YmlZQmtYenZhM0JxNlAwdldnbm4wTzlk?=
 =?utf-8?B?SHc4MkRBS1hTRDRGL2Ntd1VpejNXY0VIOXpDQktPUXRETjBZdzdtRGFNc2kx?=
 =?utf-8?B?RCtZbXoyTERoRVZLWkVxa01rNzhETjJGTjNsdVNTVG9GdVRVdEVvVEE1U3Rt?=
 =?utf-8?B?NndlU1FlRU9lOG9NalpEM1dpaTZTcEpBbUdVbXViWDNBZ3FCbUFNQ3FOUGVt?=
 =?utf-8?B?VE5TV2dTdkRsckRvVHRtQjJIRmd2M2JFRmd5K1o0RHpCVGx3WjdmYlBlaWdR?=
 =?utf-8?B?V3BFMHZFVFhiZ3lPV3VCYlNLUXpvYkxRZFZ2Z3RvL0NCME5uZTNUanZTRzJh?=
 =?utf-8?B?N1M1ZXFUNysyRXorMy9tT1lEU0VscHFpeFR3eXNYWEU5SWFHMW01QWJsckFz?=
 =?utf-8?B?VFRPODRMMjJaeFc0VzBsYitPaEdRa1RORSt4cm5DdXd2UmhiSlUzQzhFM2pv?=
 =?utf-8?B?TW5mL2JIdEdwVEtKMGJXZS9rMHB1amtVRVE2dy9ER2pmSnEvMXVkTCtLeUJC?=
 =?utf-8?B?K3RhOTR3RHJ0SXg4dW5UTnE2Mk5seTR5VWhFWUJEU2tIQUNiUVRKdHc1MU5J?=
 =?utf-8?B?UXRVN3NUc3ZJU1JUaDUxWmh6dUVvazc2SUt3K3pDZDhPS3pVNU8wOVJ5ZzhS?=
 =?utf-8?B?UnZaNHA0NHBMb0hBcXlOU3Y4OEZEVlpwdGt0S05pcDNPMkZMUzd0NnphTHRM?=
 =?utf-8?B?MzMvaXh1MmVvYVF3LzVqd2tEVnZxY1FwcG5LNnBhMXJieDFZNUR5R00wOTFG?=
 =?utf-8?B?QjFraDJBRFJmbGhoenE0QnUzRkkzU0dtbkVSMFp2dHdtemtFSDFnOVBrSzcy?=
 =?utf-8?B?WjJGOWZETm1KaDhzNGEzN2RDNnJJbUxmV3lvdWNmeC9FRGRyWDNSaWl4UlBj?=
 =?utf-8?B?akswd1lkaUVCZ1paK2hhYU1pcndvRS9WY1NFS2hzcXFKUWh0VlBiaDFzYUJM?=
 =?utf-8?B?WjRNcURVWlYwMjZIR2l6SnZTTm9OeGpYSEZ5TURyNzVHL3hIQ0tsWXl6RS8x?=
 =?utf-8?B?WjQwaUN5aitLM1lPZkFXTE9TWWEyeUlxbXZITkJJUmdqUi91YlE1QWJWaGRo?=
 =?utf-8?B?SEVBTVJTbDE3NFlxdDIyeVIrTU1qcnVNUGhOYjVJUStZejlNZVkza3JoMFRR?=
 =?utf-8?B?OGlQZlhGdUVWbUFxZGlQVllUbE5DY2RkYkthVWtnSThyM2Y0NzFETEVJQXRV?=
 =?utf-8?Q?wTNeIKsJhrubh0jr5durtbcQucluPw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8658.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2F0TjN0SDA3QnAxZGRpY2NLbnVzWmtJemk1UHJyVkFKblBDd3QvZWxsUDh6?=
 =?utf-8?B?V3VsSmxNaVgza05Bb2dRcUFRaGEweEk1ejZnK2NPZGVjZkZ5TlJidFdiZEU0?=
 =?utf-8?B?RHlxSTVBcnRKRkEzTU1pK3lOZEpJTDlUdnREK21TalFDRXlzYVZGdEd0d2J2?=
 =?utf-8?B?REQ0UVRaWmwvNXdReVZSeXp6VlhFaDU0cXZYNTFSK0NSYW9pcE82T1FyNDVL?=
 =?utf-8?B?aEVOcm9PQlQrV3p4M1lkbW1rN0tFVTRVL3lqVzZYelZYa2dFejl0ZUd1Qzc3?=
 =?utf-8?B?c0oyL29qVHdiVDJkNW12bHBFanhDMG9rT2xTUElDV1VUVDYrZWZ4TTVGN09F?=
 =?utf-8?B?dzdTMzlzTFNaOURrb3FiWWowSDNBT3lQWWQ3SW1BdW1JWlZHUC82S0lwbEdo?=
 =?utf-8?B?bVJ5eVhCRW9XSkM1a1pFZFYxbU5oTW1SLzQvWlV1MXZXY0JlSjV1WGRoeC9S?=
 =?utf-8?B?eC9xclJqamJEclZWT251UGx5ZWk1cTlRVHp0UmtrYU5lbmRGdWRUTW43Z3Fm?=
 =?utf-8?B?Y2VCekI3SnVaVi9GaVh4VzhIUlRqYkExOFQ5WFlwOVZBR0FYajhEc1JKd3Q5?=
 =?utf-8?B?Z0dabzdGY0Fpa2NwSlpZeWZWcXBoUUQ4ZkwrZ3o5VCt1RjJwb2c3cjhhcXNZ?=
 =?utf-8?B?UmxmWlNqVnBBQWRGckhXalB3YTd5Q1hoY0xGTGp6Z1ZpeEVOb3lacGd6Um12?=
 =?utf-8?B?eDd6bjlFc1YzWE9xNXAzS1o2RzF1d2JyR0xaZ3JOOXJWM0pJZzB1ZDM3RE9Y?=
 =?utf-8?B?R0luRXJqQTJ5T3FHNnl3M2h4eGFBbWJkY2NJcXlUVWM0LzJpWFltMVVKeFFV?=
 =?utf-8?B?UWkzVnZPNHlHYTFjekdmRnlNZUI0Q3lJNE1Tak1tazdYb3ViallIeGJHd202?=
 =?utf-8?B?ekkzbVdZTk4vWW9OQzYwOEdPejNoMEJmTVk2UFlPVThSdmVyRk5jT1pDRjYv?=
 =?utf-8?B?b0xseUM5dHduQjUwMEU3ZXEza2pQekkzamUzNVdtWXFCNFhwOHIzZjVoTkFD?=
 =?utf-8?B?Slk3MGd1aFFOM3hnSmRJU24rL1R5eUpUMTNCS09HQlpJLzBvTzVCc084U3Nm?=
 =?utf-8?B?b0pMNFhXNzNWU1duL1dmUk1IZTdZVWlXODBLNFdIUGVqdm5ybUxpOXpDNEJD?=
 =?utf-8?B?ZnR1UzZIMkZWdzZNWko5WVlhdzA1QXZVaXhPZ0w1RWk5VmxOOUVDOEk0MXh2?=
 =?utf-8?B?TTNXQTB4RjVmSEE4SkFTN0RHN0pBR0N4RWZ5ZlFSYTliRGUvNWRCK0ZqWlJW?=
 =?utf-8?B?cWFvNEx4aFovL1JLZ2hYZ3hHaHoyU0NQS005TlpsV2gwempwNkNvcExjamgv?=
 =?utf-8?B?ZEh5MWk3YmptUUtlTkJoelpGTk1EWFkzMXZIeWxORHVhODYrdVBrZUt0UHpJ?=
 =?utf-8?B?V3R3aVk3eWdtYUVWRDRQdytKSGp5MzErbi9rK0dHQUE0SHZiWGJldVRHSkU2?=
 =?utf-8?B?NlIxNFlGUFVJby85aEZLcjg3NVMxYjMyZGp5ZEJvK0tmRkYrVFNWRXNFbTF1?=
 =?utf-8?B?dm0wMVVmaE95L2VqS2t1SUpVM3JTU0c1MnJPSVY3NURuTThtWkdMRlUxbk9J?=
 =?utf-8?B?NTZUYkhtT2l5Y3RUb2g4TktPZnZnUWJwT2R6ZHRBTnJCYjNSUWhNd0JYNGh2?=
 =?utf-8?B?NkplNURZN1BXNDVCMHA1R3NUY1pDY1JtWGlqNGg1bFV4dXgwckJpSU9zNVYy?=
 =?utf-8?B?eUFHR2t6UnpTU0dLSkZmWFRDU2NNYXZmZEJxYWI1bitJQm81K1VvemkxVS82?=
 =?utf-8?B?clR4empHTTVkRUFJWTh1WlJYYXcvT0sxT2JUemh1aDhWaC9MQ05jb1R0SVJY?=
 =?utf-8?B?V05PSjlEOS96K3BGTHVlREZ3dTJCemJ6c25jY211UlpoaCtON2VZcmRCYjFk?=
 =?utf-8?B?Y1lYU2FrcVk1dWF6V05SYmprSnZOVXNVYzI2QjBmaEIwdjJHbVNLRVcreFhu?=
 =?utf-8?B?VTJubCt5N21QbHkzU2RGa0FobVBzVjdGWE1IYVJGZlRpVnBMeHJWd3RnK0Js?=
 =?utf-8?B?TmlFZThLWDg2Wmp2ZzFoRG5xOHZaYjBHS2hlNzVpc1g3VXZQRVN4cHpHaXhv?=
 =?utf-8?B?OFhnQ3VhMnJrd1hDbUswNzFvQkVCSGxrK0xKQXpKZTNLWXdpTXlZd3FhbW1B?=
 =?utf-8?Q?QyUA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB86589E86625C1077418F1AFCA19BACH3PR12MB8658namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7c6027-56c1-40b4-2ce4-08dd9a731de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 03:28:56.9466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iVKpzZIg9/JrgFcHJx3iLUXyuVbvToAi8AjTdMGHbEGgVhVQ0hKYcy1tlj1/hJK3XSL4PVkPlK21TXaBVgRU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5756
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

--_000_CH3PR12MB86589E86625C1077418F1AFCA19BACH3PR12MB8658namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SXQncyBmaW5lIGZvciBtZSwgdGhhbmtzIGZvciB0aGUgaGVhZHMgdXAuDQoNClJlZ2FyZHMsDQpY
dWVtaW5nDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogRGF2aWQgTWFy
Y2hhbmQgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQpTZW50OiBUaHVyc2RheSwgTWF5IDIy
LCAyMDI1IDg6NTEgUE0NClRvOiBMdWNhIEJvY2Nhc3NpIDxibHVjYUBkZWJpYW4ub3JnPjsgWHVl
bWluZyBMaSA8eHVlbWluZ2xAbnZpZGlhLmNvbT4NCkNjOiBkZXZAZHBkay5vcmcgPGRldkBkcGRr
Lm9yZz47IEFhcm9uIENvbm9sZSA8YWNvbm9sZUByZWRoYXQuY29tPjsgTWljaGFlbCBTYW50YW5h
IDxtYWljb2xnYWJyaWVsQGhvdG1haWwuY29tPjsgS2V2aW4gVHJheW5vciA8a3RyYXlub3JAcmVk
aGF0LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBjaTogYnVtcCB0ZXN0ZWQgZGlzdHJp
YnV0aW9ucyBpbiBHSEENCg0KSGVsbG8gTHVjYSwgWHVlbWluZywNCg0KT24gV2VkLCBKYW4gMzEs
IDIwMjQgYXQgNjo0NOKAr1BNIERhdmlkIE1hcmNoYW5kDQo8ZGF2aWQubWFyY2hhbmRAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+DQo+IEZlZG9yYSAzNyBoYXMgcmVhY2hlZCBlbmQgb2YgbGlmZSBpbiBE
ZWNlbWJlciAyMDIzLg0KPiBVYnVudHUgMjAuMDQgaXMgZ2V0dGluZyBxdWl0ZSBvbGQuDQo+DQo+
IFN3aXRjaCB0byBtb3JlIHJlY2VudCB2ZXJzaW9ucy4NCj4NCj4gV2l0aCB0aGlzIG1vdmUsIHNv
bWUgcGFja2FnZXMgcHJvdmlkZWQgYnkgdGhvc2UgZGlzdHJpYnV0aW9ucyBhcmUgbm93DQo+IHJl
Y2VudCBlbm91Z2ggdG8gZXh0ZW5kIG91ciBidWlsZCBjb3ZlcmFnZS4NCj4gSW5zdGFsbCBhZGRp
dGlvbmFsIGRlcGVuZGVuY2llcyBsaWtlIGlwc2VjLW1iLCBpc2FsIGFuZCBvdGhlcg0KPiBsaWJi
cGYvbGlieGRwIGRldmVsIHBhY2thZ2VzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJj
aGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbT4NCg0KVGhlIFVidW50dSAyMC4wNCBpbWFn
ZSBoYXMgYmVlbiByZW1vdmVkIGZyb20gR0hBIHdoaWNoIG1lYW5zIHRoYXQgR0hBDQp0ZXN0aW5n
IGluIGdpdGh1YiBpcyBLTyBmb3IgMjIuMTEgYW5kIDIzLjExIGJyYW5jaGVzLg0KSWYgeW91IGRv
IGNhcmUgYWJvdXQgR0hBLCBJIHN1Z2dlc3QgYmFja3BvcnRpbmcgdGhpcyBjdXJyZW50IHBhdGNo
IHRvDQp0aG9zZSBMVFMgYnJhbmNoZXMgKCsgZml4IGVmMjUzNWQwMjJiOSAoImNpOiBmaXggY2Nh
Y2hlIGZvciBVYnVudHUNCjIyLjA0IikpLg0KSXQgc2hvdWxkIGFwcGx5IGNsZWFubHkgKG9yIGF0
IGxlYXN0IGVhc2lseSksIGJ1dCBJIGNhbiBoZWxwIG90aGVyd2lzZS4NCg0KDQotLQ0KRGF2aWQg
TWFyY2hhbmQNCg0K

--_000_CH3PR12MB86589E86625C1077418F1AFCA19BACH3PR12MB8658namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
IiBzdHlsZT0iZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01T
Rm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAx
MnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQpJdCdzIGZpbmUgZm9yIG1lLCB0aGFua3MgZm9y
IHRoZSBoZWFkcyZuYnNwO3VwLjwvZGl2Pg0KPGRpdiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiIHN0
eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250
U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7
IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0iZWxlbWVu
dFRvUHJvb2YiIHN0eWxlPSJmb250LWZhbWlseTogQXB0b3MsIEFwdG9zX0VtYmVkZGVkRm9udCwg
QXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250
LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4NClJlZ2FyZHMsPC9kaXY+DQo8ZGl2
IGNsYXNzPSJlbGVtZW50VG9Qcm9vZiIgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3Nf
RW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNh
bnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KWHVlbWlu
ZzwvZGl2Pg0KPGRpdiBpZD0iYXBwZW5kb25zZW5kIj48L2Rpdj4NCjxociBzdHlsZT0iZGlzcGxh
eTppbmxpbmUtYmxvY2s7d2lkdGg6OTglIiB0YWJpbmRleD0iLTEiPg0KPGRpdiBpZD0iZGl2UnBs
eUZ3ZE1zZyIgZGlyPSJsdHIiPjxmb250IGZhY2U9IkNhbGlicmksIHNhbnMtc2VyaWYiIHN0eWxl
PSJmb250LXNpemU6MTFwdCIgY29sb3I9IiMwMDAwMDAiPjxiPkZyb206PC9iPiBEYXZpZCBNYXJj
aGFuZCAmbHQ7ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNvbSZndDs8YnI+DQo8Yj5TZW50OjwvYj4g
VGh1cnNkYXksIE1heSAyMiwgMjAyNSA4OjUxIFBNPGJyPg0KPGI+VG86PC9iPiBMdWNhIEJvY2Nh
c3NpICZsdDtibHVjYUBkZWJpYW4ub3JnJmd0OzsgWHVlbWluZyBMaSAmbHQ7eHVlbWluZ2xAbnZp
ZGlhLmNvbSZndDs8YnI+DQo8Yj5DYzo8L2I+IGRldkBkcGRrLm9yZyAmbHQ7ZGV2QGRwZGsub3Jn
Jmd0OzsgQWFyb24gQ29ub2xlICZsdDthY29ub2xlQHJlZGhhdC5jb20mZ3Q7OyBNaWNoYWVsIFNh
bnRhbmEgJmx0O21haWNvbGdhYnJpZWxAaG90bWFpbC5jb20mZ3Q7OyBLZXZpbiBUcmF5bm9yICZs
dDtrdHJheW5vckByZWRoYXQuY29tJmd0Ozxicj4NCjxiPlN1YmplY3Q6PC9iPiBSZTogW1BBVENI
IDEvMl0gY2k6IGJ1bXAgdGVzdGVkIGRpc3RyaWJ1dGlvbnMgaW4gR0hBPC9mb250Pg0KPGRpdj4m
bmJzcDs8L2Rpdj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0iQm9keUZyYWdtZW50Ij48Zm9udCBzaXpl
PSIyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjExcHQ7Ij4NCjxkaXYgY2xhc3M9IlBsYWluVGV4
dCI+SGVsbG8gTHVjYSwgWHVlbWluZyw8YnI+DQo8YnI+DQpPbiBXZWQsIEphbiAzMSwgMjAyNCBh
dCA2OjQ04oCvUE0gRGF2aWQgTWFyY2hhbmQ8YnI+DQombHQ7ZGF2aWQubWFyY2hhbmRAcmVkaGF0
LmNvbSZndDsgd3JvdGU6PGJyPg0KJmd0Ozxicj4NCiZndDsgRmVkb3JhIDM3IGhhcyByZWFjaGVk
IGVuZCBvZiBsaWZlIGluIERlY2VtYmVyIDIwMjMuPGJyPg0KJmd0OyBVYnVudHUgMjAuMDQgaXMg
Z2V0dGluZyBxdWl0ZSBvbGQuPGJyPg0KJmd0Ozxicj4NCiZndDsgU3dpdGNoIHRvIG1vcmUgcmVj
ZW50IHZlcnNpb25zLjxicj4NCiZndDs8YnI+DQomZ3Q7IFdpdGggdGhpcyBtb3ZlLCBzb21lIHBh
Y2thZ2VzIHByb3ZpZGVkIGJ5IHRob3NlIGRpc3RyaWJ1dGlvbnMgYXJlIG5vdzxicj4NCiZndDsg
cmVjZW50IGVub3VnaCB0byBleHRlbmQgb3VyIGJ1aWxkIGNvdmVyYWdlLjxicj4NCiZndDsgSW5z
dGFsbCBhZGRpdGlvbmFsIGRlcGVuZGVuY2llcyBsaWtlIGlwc2VjLW1iLCBpc2FsIGFuZCBvdGhl
cjxicj4NCiZndDsgbGliYnBmL2xpYnhkcCBkZXZlbCBwYWNrYWdlcy48YnI+DQomZ3Q7PGJyPg0K
Jmd0OyBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNYXJjaGFuZCAmbHQ7ZGF2aWQubWFyY2hhbmRAcmVk
aGF0LmNvbSZndDs8YnI+DQo8YnI+DQpUaGUgVWJ1bnR1IDIwLjA0IGltYWdlIGhhcyBiZWVuIHJl
bW92ZWQgZnJvbSBHSEEgd2hpY2ggbWVhbnMgdGhhdCBHSEE8YnI+DQp0ZXN0aW5nIGluIGdpdGh1
YiBpcyBLTyBmb3IgMjIuMTEgYW5kIDIzLjExIGJyYW5jaGVzLjxicj4NCklmIHlvdSBkbyBjYXJl
IGFib3V0IEdIQSwgSSBzdWdnZXN0IGJhY2twb3J0aW5nIHRoaXMgY3VycmVudCBwYXRjaCB0bzxi
cj4NCnRob3NlIExUUyBicmFuY2hlcyAoKyBmaXggZWYyNTM1ZDAyMmI5ICgmcXVvdDtjaTogZml4
IGNjYWNoZSBmb3IgVWJ1bnR1PGJyPg0KMjIuMDQmcXVvdDspKS48YnI+DQpJdCBzaG91bGQgYXBw
bHkgY2xlYW5seSAob3IgYXQgbGVhc3QgZWFzaWx5KSwgYnV0IEkgY2FuIGhlbHAgb3RoZXJ3aXNl
Ljxicj4NCjxicj4NCjxicj4NCi0tIDxicj4NCkRhdmlkIE1hcmNoYW5kPGJyPg0KPGJyPg0KPC9k
aXY+DQo8L3NwYW4+PC9mb250PjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_CH3PR12MB86589E86625C1077418F1AFCA19BACH3PR12MB8658namp_--
