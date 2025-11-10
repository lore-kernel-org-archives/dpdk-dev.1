Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E1CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 09:29:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 274A0400D6;
	Mon, 10 Nov 2025 10:29:18 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2CCD2400D5;
 Mon, 10 Nov 2025 10:29:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk8aThU/f9HWH3kq5RCrUSEnFDUUXo0u5UkJUBGnDdw8WNUO4VQJDtauJjkzlTKIZ8bDq3/Eb3tjUwN/G2Xj6U9lNK9TQK2OgTF26NXYqpL4scDOa5Fcoch7k+VfmWSE0irJSw+pdv6a0txQGDoFtu4iyIzEuQkItoRmNeYAtyNlPNtNwdlhLTBjfFerKScrBbHoVB/EeRg+sdA/EkKCNVrl6NdmliD6+8UwxuEOvcCglhtrNZcz5OgS0VQWTT0IR7gr60lmOMdLMCLPxCnWTmEOP0qBY7hmXMBpEu6JSnYrKV0GgWPZO0VXl+otH7A1g5jdJtGJwh4VqW+BTWa9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkd33QOsD7WZ2OJgRBLczIE9MTr2dNkTt59WX1lTQmQ=;
 b=uA8viHPSMWc1QkCQVdqKU4vK7M8XYxbGLJObBGJx1owntwjtW8BA9SO0Mfhlm4aILgeczVVYWkmwpY+HIZVwlEeUN5APU971fUDf6gJDfscm0BdkC7gNKN6A5fodjQUr+iajoEJ5sQifQqjeJf/DPBf+9xLQDnk0Ny0b7dTZzJBOuplLAJz6I4oeAiSMm5MPFVbm5Zf2u7PvNrT8uWS7/AFUhmonhiEK6gbpk0zcoK2HXSAuFl8eMI+8VcS0V2cfNpc5nQsYVo8L/Pb5FI+L06X9oXWdvY8wKfXQQVCD/prPD78RsESI/P1dHRKAqGgTqPlXZ+48rvZi4GM0FJYPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkd33QOsD7WZ2OJgRBLczIE9MTr2dNkTt59WX1lTQmQ=;
 b=0GjfpO9viSj/FXpyfPRx6vzY2YLzr1heZGJm7Nre2ivjl1ICISBln4SwP7bFxmsM+wPxv27nRTFNtXzIwr5rgho427wpkKTpxfs30GhFgtz92BrM86g5Voy917/jYIgSsLyF3/ynU9DX6/VsZa4J1KdFeuy/7eDrwrKpSK9TfuE=
Received: from CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:29:14 +0000
Received: from CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515]) by CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 09:29:13 +0000
From: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Alexander Kozyrev
 <akozyrev@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>
CC: "jerinj@marvell.com" <jerinj@marvell.com>, "kirankumark@marvell.com"
 <kirankumark@marvell.com>, "ndabilpuram@marvell.com"
 <ndabilpuram@marvell.com>, "yanzhirun_163@163.com" <yanzhirun_163@163.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "ktraynor@redhat.com" <ktraynor@redhat.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "aconole@redhat.com" <aconole@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Thread-Topic: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Thread-Index: AQHcPdlB9K02x4aBhkyabObrZChQDLTnpNwAgAQmlsI=
Date: Mon, 10 Nov 2025 09:29:13 +0000
Message-ID: <CH3PR12MB8233444042288DA4196F222A86CEA@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
 <20251107175936.4yr2quzngd5gnp2l@ds-vm-debian.local>
In-Reply-To: <20251107175936.4yr2quzngd5gnp2l@ds-vm-debian.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-10T09:29:12.993Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8233:EE_|DS0PR12MB8319:EE_
x-ms-office365-filtering-correlation-id: 7d7269a6-f1fe-4baf-09e0-08de203b9c9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dItErPiclA8En3rMvz8GcdB1rpVRkv3bDBT9zCpUc17LU0sIoAJPVt8MDI?=
 =?iso-8859-1?Q?JEmrJFOwWWtOtx8tZcjg+XG/TNwWce9peA+KAAumqWR7aGgOfsARgeNtLi?=
 =?iso-8859-1?Q?45GOaSdJjDLvCRY/tXI8V1vJuWuPxaTX+agfQ9kWIPM4sWTo1TIL9oIaU/?=
 =?iso-8859-1?Q?LGS7MGYM1NkU36K1XoilNnoOrUeEpwLPny1at33n1CAjwy6b3j3EIpaLEy?=
 =?iso-8859-1?Q?rEvfDqa4pt15unL8IDUTsh7BEdMHjKBLMeeGOaCXrQjTdfNr5aCW+4Y3ax?=
 =?iso-8859-1?Q?tt0ndrXSdXx447fsQzgoA6gWp+9zIg7VREnX3+Zi4Vfp0cgEZIQG996DJk?=
 =?iso-8859-1?Q?SmuJ67i4nH5g6aV3dXLyPYoABT8fcxE9B6LhCZ7XlCh7ZaBC+hmN38T1KU?=
 =?iso-8859-1?Q?FTveFeRDwZZdxMlUtATytjVleGzp6N4XZStt4KTDjuCjTS3bgFqVwkWIwu?=
 =?iso-8859-1?Q?c//8Ea3mJBI+Arm2H+PVUvXyjcYT3Cb8JZOnJy4EVCJ2R9PFQZsyzoxzws?=
 =?iso-8859-1?Q?iwNVreWgbvqunvBlKu8593c6j5RjhrMtLEIuCKfg5u6O8Lcfrcln3moXO1?=
 =?iso-8859-1?Q?ep0V56VQ8ZtHPzir96R1SY/nS7Z5HYfFr9tsCl/1yHNELA1OxDd/FBUGOE?=
 =?iso-8859-1?Q?lxCL8PplzZ+p1ThH1IeTsroDTRHvGG/XTey00u+YxjUnW4r0m9+GUMuXP9?=
 =?iso-8859-1?Q?rYkVlOVNN3mXcWs/3t5+6HoxugrR0Xrjl/AyQ9J5/aqyIknBHTrtv6wB9C?=
 =?iso-8859-1?Q?M6iF/l0/zmp+g++cUN3lwu1Zx3cNh/55tM61OGfcdNm0tYe4hOl8ccDZnN?=
 =?iso-8859-1?Q?RIAjZN5YjbNz/Yk26gdtfwg7DgxpCOOdGwFbOXV31yrCIbgJfVGY87nwx5?=
 =?iso-8859-1?Q?WV+Ymwy4Xnj/Ff2VatNq59sTQ0QB92Up1mNKkS1PxPIrBQbBLuHBr4VxwQ?=
 =?iso-8859-1?Q?6U+FnV64x/laEHTTkbyz0T4ONrrW39SzaiO4o0J3DutYwbRabAFdJQrEDB?=
 =?iso-8859-1?Q?tblGmfKcmCFRye3D2ZCu+dYa5VqeRYzvXwjtl+6DriDY8//jwDIOuJGn4W?=
 =?iso-8859-1?Q?I5GHv/L1BNSTE60GWVUmYZDz9ucO54eNB0hUn8T02+W6G/2ru3x/1Mtyy+?=
 =?iso-8859-1?Q?psx52y+O02SHRpfqtaBY75yKwv/X36NGicIpYCcO2goejCRWAkJaD5D23e?=
 =?iso-8859-1?Q?q5au7lJKGkU/FGKLABZVoObetbFAmQ+lKvFaFfZs3vy4xnAkSY2NpyIxQb?=
 =?iso-8859-1?Q?zCsZJKXAmdgbgIUUBuNfhBlO9Ma80CKidav9JsQiAIKh+wg5G+JEV1Yqbs?=
 =?iso-8859-1?Q?2DNcZ7w7U6ev9kFIFGtlhFlsH4BTu9zpVc6RvUmDaioVd676Pwm6E82C6R?=
 =?iso-8859-1?Q?27D1YcinaWs8ivEaYbKBi99C0PdZH9jEXMacVkQ2Nk/B4FaAR28R4Cw61X?=
 =?iso-8859-1?Q?LmTdzBPZ86o//mT/NRD1w5F6OaZqEtoN0Ah/1sK4wZKa6JrB0DnrwsiBNd?=
 =?iso-8859-1?Q?p87f7hONvKMOAFM4bCh3/D7iOaq4+OOWKXXF4igHEC/w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8233.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xfBjGQpfcqCkBgIp7o8h5ZIy1mDP7q+NuTm6OULCAkoD4+9shbqNF6Rnow?=
 =?iso-8859-1?Q?Prbi7poux0SxtJLI9yvTNEDuQhJjCDXrxfyRMk3/AcRMzwCIzaRHwSTCF4?=
 =?iso-8859-1?Q?IkJYY2iUmbI43kxqqwsiwny6JHPcmECcwK4bySZjHdAZ1Jj1JpafWn9odu?=
 =?iso-8859-1?Q?i27OxtXJeFQPbgAMFE4oz0fNMt55jxssQUXgg8Bq7VB6VwKcQeNOUjCRel?=
 =?iso-8859-1?Q?K6A890Z0fV5XRswGCAYR1grUPYaiYFEL25eoMhpwhj6P7vflbwopfI/HBV?=
 =?iso-8859-1?Q?B6oQn8NxHGTYdJEbmK1zsyk4zUZfeZK5BnPXIYmVgR3JrU/ynvo1E/xzl/?=
 =?iso-8859-1?Q?Au8nvAtdLJVdt5VXTKsrwS7KOT33OCf+IC+YioCZYmGkirSoXV0B98is/s?=
 =?iso-8859-1?Q?p4QMJ3MkkW9VWTc8g3Z1giLaPfsi+Efgk35UzsxN9aN+RTAfbT0CA+lC2N?=
 =?iso-8859-1?Q?GE+EPEseOlR6T5rHnuD/GvXMFFbo+WQLfwkIKTivEmU0ikV2Mxd1t3Xh1z?=
 =?iso-8859-1?Q?n0icAI3jOmW2yjOVmGtuvGxi58S27JlkF1PW2z/XqpsVbq5AydNs+m0tTV?=
 =?iso-8859-1?Q?ztTPB+u/4jLK2i4UeuvYHJ8Bi8Tcep+UJ+YL1n6xXrz8ugKYKHd9jXrGBe?=
 =?iso-8859-1?Q?jjHZO6DsN6q3/aEqGvJnBH6s9iselXemyA4xWLRQaRhGg5Y7IP3six/i7d?=
 =?iso-8859-1?Q?7FW0wIitMyso64A0VWtilNoji8a4OK8UG5okgYMCLl0FZTed9/nkd0XM3S?=
 =?iso-8859-1?Q?FpIatUDjxyFCaIm4TJRl9RywPRYb/PVNig9d7c5UH5ff8Gn7pIh81JdOWp?=
 =?iso-8859-1?Q?QGaMYU9yhBxbEpwdgMqlTLEuuZCh0Sn4qFqIPDShp/hh9Tig09Pc66JWsZ?=
 =?iso-8859-1?Q?GXh+pPXDUnFD0gITh6N1PuzND/wpgAMUbkbzKRPzbH4NpVQPSLAE+IP7Kq?=
 =?iso-8859-1?Q?qBaVv0UgX7gyytFNNUlXlvM36EvmSRo0X391j4Ai3jSATm0sC7qcT+PXix?=
 =?iso-8859-1?Q?0rAzC4rvoNfjkRn+INWcazm/PTSFnL1sXm3AifSBVpkVh8nfxtdXQ6G1NM?=
 =?iso-8859-1?Q?Bw+Cby2Z7cDelRM5agXKzpUbBis7/zrnNpBy9I+jUj2mDbdmLUbIfm+7eO?=
 =?iso-8859-1?Q?e9KVSttF24GRhBvYjOATyK/mZgIi725zTgC4H4yg/iKiABBKjhiaGK9WfY?=
 =?iso-8859-1?Q?O0nLA+kuLk2f65HVPtwtM2wWhJGPwzdSEFf/ErETL582N+fNvco1S/UYq6?=
 =?iso-8859-1?Q?cAP/LLZfCZ1F2JfvMsVcPdQ2eVR2yQIe7kUDAizVBEWLTVCluwi6J+LAgI?=
 =?iso-8859-1?Q?qBAdc74y7G87JTe2S5xLPP9XzLRP1TCOJ4MH0A/fhmeLg5Rc+kP4bfOMFI?=
 =?iso-8859-1?Q?N4wFKCMQj7MIGKS5ysTf0aExEL1slnSwC0e4ELaUQSuUA9rl/NgN1+jJUN?=
 =?iso-8859-1?Q?hmkWwPaFHTIbSH0FGpj+5J4zFJRQVxCn7yCGGkmfOQGdzabsEgerueDC1G?=
 =?iso-8859-1?Q?8EkrrlwB1yA6Z/vPoPW0o+emwlgL3LOLwhYUMZo2e3Vs8AUizzPaVK+8hD?=
 =?iso-8859-1?Q?Tgo0BX7y2C0BakMv4WwG0ObXoPf2KH9sCe+vpf5MYklZC5GnTDQ9QIUkXb?=
 =?iso-8859-1?Q?KyilxdhoxK1eM=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8233444042288DA4196F222A86CEACH3PR12MB8233namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8233.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7269a6-f1fe-4baf-09e0-08de203b9c9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 09:29:13.5228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIsMjV+2/KYK8HJfKjiGezl/GGL8iB2gTJOADGw6y/nore3biadPGlq7yV31bE32YhVDFlxu1KgkpzVoui+s7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

--_000_CH3PR12MB8233444042288DA4196F222A86CEACH3PR12MB8233namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Dariusz,

________________________________
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
Sent: Friday, November 07, 2025 11:29 PM
To: Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>; Alexander Kozyrev <ak=
ozyrev@nvidia.com>; Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Cc: jerinj@marvell.com <jerinj@marvell.com>; kirankumark@marvell.com <kiran=
kumark@marvell.com>; ndabilpuram@marvell.com <ndabilpuram@marvell.com>; yan=
zhirun_163@163.com <yanzhirun_163@163.com>; david.marchand@redhat.com <davi=
d.marchand@redhat.com>; ktraynor@redhat.com <ktraynor@redhat.com>; thomas@m=
onjalon.net <thomas@monjalon.net>; konstantin.ananyev@huawei.com <konstanti=
n.ananyev@huawei.com>; konstantin.v.ananyev@yandex.ru <konstantin.v.ananyev=
@yandex.ru>; bruce.richardson@intel.com <bruce.richardson@intel.com>; maxim=
e.coquelin@redhat.com <maxime.coquelin@redhat.com>; anatoly.burakov@intel.c=
om <anatoly.burakov@intel.com>; aconole@redhat.com <aconole@redhat.com>; de=
v@dpdk.org <dev@dpdk.org>; stable@dpdk.org <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid C=
QE

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


> Hi,
>
> Thank you for the contribution. Please see comments below.
>
> On Wed, Oct 15, 2025 at 01:39:57PM +0000, Sivaprasad Tummala wrote:
>> Previously, the PMD used a common monitor callback to determine
>> CQE ownership for power-aware polling. However, when a CQE contained
>> an invalid opcode(MLX5_CQE_INVALID), ownership bit was not reliable.
>> As a result, the monitor condition could falsely indicate CQE
>> availability and cause the CPU to wake up unnecessarily during
>> low traffic periods.
>>
>> This resulted in spurious wakeups in monitor-wait mode and reduced
>> the expected power savings, as cores exited the sleep state even
>> when no valid CQEs were available.
>>
>> This patch introduces a dedicated callback that skips invalid CQEs
>> and optimizes power efficiency by preventing false wakeups caused
>> by hardware-owned or invalid entries.
>>
>> Fixes: a8f0df6bf98d ("net/mlx5: support power monitoring")
>> Cc: akozyrev@nvidia.com
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
>> ---
>>  drivers/net/mlx5/mlx5_rx.c | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
>> index 420a03068d..2765b4b730 100644
>> --- a/drivers/net/mlx5/mlx5_rx.c
>> +++ b/drivers/net/mlx5/mlx5_rx.c
>> @@ -295,6 +295,20 @@ mlx5_monitor_callback(const uint64_t value,
>>       return (value & m) =3D=3D v ? -1 : 0;
>>  }
>>
>> +static int
>> +mlx5_monitor_cqe_own_callback(const uint64_t value,
>> +             const uint64_t opaque[RTE_POWER_MONITOR_OPAQUE_SZ])
>> +{
>> +     const uint64_t m =3D opaque[CLB_MSK_IDX];
>> +     const uint64_t v =3D opaque[CLB_VAL_IDX];
>> +     const uint64_t match =3D ((value & m) =3D=3D v);
>
> Could you please rename "match" variable to "sw_owned"?
> This name would better relay the meaning of the checked condition that
> CQE owner bit value signifies that CQE is SW owned.
ACK! Will update this in v2.
>
>> +     const uint64_t opcode =3D MLX5_CQE_OPCODE(value);
>> +     const uint64_t valid_op =3D (opcode ^ MLX5_CQE_INVALID);
>
>IMO the usage of bit operations here (although logic is correct) is a bit =
confusing.
>Could you rewrite it in terms of logical operations so it's easier to
>follow? For example like this:
>
>        const uint64_t valid_op =3D opcode !=3D MLX5_CQE_INVALID
>
>        return (sw_owned && valid_op) ? -1 : 0;
>
>This also would properly describe in code the required condition:
>CQE can be parsed by SW if and only if owner bit is "SW owned" and CQE
>opcode is valid.
ACK! Will update this in v2.
>
>> +
>> +     /* ownership bit is not valid for invalid opcode; CQE is HW owned =
*/
>> +     return -(match & valid_op);
>> +}
>> +
>> int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond =
*pmc)
>>  {
>>       struct mlx5_rxq_data *rxq =3D rx_queue;
>> @@ -312,12 +326,13 @@ int mlx5_get_monitor_addr(void *rx_queue, struct r=
te_power_monitor_cond *pmc)
>>               pmc->addr =3D &cqe->validity_iteration_count;
>>               pmc->opaque[CLB_VAL_IDX] =3D vic;
>>               pmc->opaque[CLB_MSK_IDX] =3D MLX5_CQE_VIC_INIT;
>> +             pmc->fn =3D mlx5_monitor_callback;
>
>Alex, Slava: Just to double check - in case of enhanced CQE compression
>layout, should both CQE opcode and vic be checked?
>Right now only vic is checked in power monitor callback for that case.
>In Rx datapath both are checked to determine CQE ownership:
>https://github.com/DPDK/dpdk/blob/main/drivers/common/mlx5/mlx5_common.h#L=
277
>
>>       } else {
>>               pmc->addr =3D &cqe->op_own;
>>               pmc->opaque[CLB_VAL_IDX] =3D !!idx;
>>               pmc->opaque[CLB_MSK_IDX] =3D MLX5_CQE_OWNER_MASK;
>> +             pmc->fn =3D mlx5_monitor_cqe_own_callback;
>>       }
>> -     pmc->fn =3D mlx5_monitor_callback;
>>       pmc->size =3D sizeof(uint8_t);
>>       return 0;
>>  }
>> --
>> 2.43.0
>>
>
>Best regards,
>Dariusz Sosnowski

Thanks & Regards,
Sivaprasad

--_000_CH3PR12MB8233444042288DA4196F222A86CEACH3PR12MB8233namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Dariusz, </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Dariusz Sosnowski &lt;dsosnowski@nvidia.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, November 07, 2025 11:29 PM<br>
<b>To:</b>&nbsp;Tummala, Sivaprasad &lt;Sivaprasad.Tummala@amd.com&gt;; Ale=
xander Kozyrev &lt;akozyrev@nvidia.com&gt;; Viacheslav Ovsiienko &lt;viache=
slavo@nvidia.com&gt;<br>
<b>Cc:</b>&nbsp;jerinj@marvell.com &lt;jerinj@marvell.com&gt;; kirankumark@=
marvell.com &lt;kirankumark@marvell.com&gt;; ndabilpuram@marvell.com &lt;nd=
abilpuram@marvell.com&gt;; yanzhirun_163@163.com &lt;yanzhirun_163@163.com&=
gt;; david.marchand@redhat.com &lt;david.marchand@redhat.com&gt;; ktraynor@=
redhat.com
 &lt;ktraynor@redhat.com&gt;; thomas@monjalon.net &lt;thomas@monjalon.net&g=
t;; konstantin.ananyev@huawei.com &lt;konstantin.ananyev@huawei.com&gt;; ko=
nstantin.v.ananyev@yandex.ru &lt;konstantin.v.ananyev@yandex.ru&gt;; bruce.=
richardson@intel.com &lt;bruce.richardson@intel.com&gt;; maxime.coquelin@re=
dhat.com
 &lt;maxime.coquelin@redhat.com&gt;; anatoly.burakov@intel.com &lt;anatoly.=
burakov@intel.com&gt;; aconole@redhat.com &lt;aconole@redhat.com&gt;; dev@d=
pdk.org &lt;dev@dpdk.org&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused =
by invalid CQE
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">Caution: This mess=
age originated from an External Source. Use proper caution when opening att=
achments, clicking links, or responding.<br>
<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; Thank you for the contribution. Please see comments below.<br>
&gt;<br>
&gt; On Wed, Oct 15, 2025 at 01:39:57PM +0000, Sivaprasad Tummala wrote:<br=
>
&gt;&gt; Previously, the PMD used a common monitor callback to determine<br=
>
&gt;&gt; CQE ownership for power-aware polling. However, when a CQE contain=
ed<br>
&gt;&gt; an invalid opcode(MLX5_CQE_INVALID), ownership bit was not reliabl=
e.<br>
&gt;&gt; As a result, the monitor condition could falsely indicate CQE<br>
&gt;&gt; availability and cause the CPU to wake up unnecessarily during<br>
&gt;&gt; low traffic periods.<br>
&gt;&gt;<br>
&gt;&gt; This resulted in spurious wakeups in monitor-wait mode and reduced=
<br>
&gt;&gt; the expected power savings, as cores exited the sleep state even<b=
r>
&gt;&gt; when no valid CQEs were available.<br>
&gt;&gt;<br>
&gt;&gt; This patch introduces a dedicated callback that skips invalid CQEs=
<br>
&gt;&gt; and optimizes power efficiency by preventing false wakeups caused<=
br>
&gt;&gt; by hardware-owned or invalid entries.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: a8f0df6bf98d (&quot;net/mlx5: support power monitoring&quot=
;)<br>
&gt;&gt; Cc: akozyrev@nvidia.com<br>
&gt;&gt; Cc: stable@dpdk.org<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Sivaprasad Tummala &lt;sivaprasad.tummala@amd.com&g=
t;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; drivers/net/mlx5/mlx5_rx.c | 17 ++++++++++++++++-<br>
&gt;&gt;&nbsp; 1 file changed, 16 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx=
.c<br>
&gt;&gt; index 420a03068d..2765b4b730 100644<br>
&gt;&gt; --- a/drivers/net/mlx5/mlx5_rx.c<br>
&gt;&gt; +++ b/drivers/net/mlx5/mlx5_rx.c<br>
&gt;&gt; @@ -295,6 +295,20 @@ mlx5_monitor_callback(const uint64_t value,<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (value &amp; m) =3D=3D =
v ? -1 : 0;<br>
&gt;&gt;&nbsp; }<br>
&gt;&gt;<br>
&gt;&gt; +static int<br>
&gt;&gt; +mlx5_monitor_cqe_own_callback(const uint64_t value,<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; const uint64_t opaque[RTE_POWER_MONITOR_OPAQUE_SZ])<br>
&gt;&gt; +{<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t m =3D opaque[CLB_MSK_IDX]=
;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t v =3D opaque[CLB_VAL_IDX]=
;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t match =3D ((value &amp; m=
) =3D=3D v);<br>
&gt;<br>
&gt; Could you please rename &quot;match&quot; variable to &quot;sw_owned&q=
uot;?<br>
&gt; This name would better relay the meaning of the checked condition that=
<br>
&gt; CQE owner bit value signifies that CQE is SW owned.<br>
ACK! Will update this in v2.</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">&gt;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t opcode =3D MLX5_CQE_OPCOD=
E(value);<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t valid_op =3D (opcode ^ ML=
X5_CQE_INVALID);<br>
&gt;<br>
&gt;IMO the usage of bit operations here (although logic is correct) is a b=
it confusing.<br>
&gt;Could you rewrite it in terms of logical operations so it's easier to<b=
r>
&gt;follow? For example like this:<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; const uint64_t valid_op =3D opcode !=3D MLX=
5_CQE_INVALID<br>
&gt;<br>
&gt;&nbsp; &nbsp; &nbsp; &nbsp; return (sw_owned &amp;&amp; valid_op) ? -1 =
: 0;<br>
&gt;<br>
&gt;This also would properly describe in code the required condition:<br>
&gt;CQE can be parsed by SW if and only if owner bit is &quot;SW owned&quot=
; and CQE<br>
&gt;opcode is valid.</div>
<div style=3D"font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProo=
f">ACK! Will update this in v2.</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">&gt;<br>
&gt;&gt; +<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* ownership bit is not valid for invali=
d opcode; CQE is HW owned */<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return -(match &amp; valid_op);<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt; int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor=
_cond *pmc)<br>
&gt;&gt;&nbsp; {<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;struct mlx5_rxq_data *rxq =3D rx_queue;<=
br>
&gt;&gt; @@ -312,12 +326,13 @@ int mlx5_get_monitor_addr(void *rx_queue, st=
ruct rte_power_monitor_cond *pmc)<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pmc-&gt;addr=
 =3D &amp;cqe-&gt;validity_iteration_count;<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pmc-&gt;opaq=
ue[CLB_VAL_IDX] =3D vic;<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pmc-&gt;opaq=
ue[CLB_MSK_IDX] =3D MLX5_CQE_VIC_INIT;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pmc-&gt;fn =3D mlx5_monitor_callback;<br>
&gt;<br>
&gt;Alex, Slava: Just to double check - in case of enhanced CQE compression=
<br>
&gt;layout, should both CQE opcode and vic be checked?<br>
&gt;Right now only vic is checked in power monitor callback for that case.<=
br>
&gt;In Rx datapath both are checked to determine CQE ownership:</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">&gt;<a data-auth=
=3D"NotApplicable" class=3D"OWAAutoLink" id=3D"OWAf645a71b-7320-788e-63a9-a=
91c9479b8b4" href=3D"https://github.com/DPDK/dpdk/blob/main/drivers/common/=
mlx5/mlx5_common.h#L277">https://github.com/DPDK/dpdk/blob/main/drivers/com=
mon/mlx5/mlx5_common.h#L277</a></div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">&gt;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pmc-&gt;addr =3D &amp;cqe-&gt;op_own;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pmc-&gt;opaque[CLB_VAL_IDX] =3D !!idx;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pmc-&gt;opaque[CLB_MSK_IDX] =3D MLX5_CQE_OWNER_MASK;<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pmc-&gt;fn =3D mlx5_monitor_cqe_own_callback;<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; pmc-&gt;fn =3D mlx5_monitor_callback;<br=
>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;pmc-&gt;size =3D sizeof(uint8_t);<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
&gt;&gt;&nbsp; }<br>
&gt;&gt; --<br>
&gt;&gt; 2.43.0<br>
&gt;&gt;<br>
&gt;<br>
&gt;Best regards,<br>
&gt;Dariusz Sosnowski<br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProo=
f">Thanks &amp; Regards,</div>
<div style=3D"font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProo=
f">Sivaprasad</div>
</body>
</html>

--_000_CH3PR12MB8233444042288DA4196F222A86CEACH3PR12MB8233namp_--
