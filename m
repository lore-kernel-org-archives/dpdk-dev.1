Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A9CE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 20:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AE3D402A0;
	Mon, 17 Nov 2025 21:05:23 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2AF444028B;
 Mon, 17 Nov 2025 21:05:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBh7EjUIKwAa5DHkaZapW/MAPzxeZnMqjjg2uzUdEWPsTzxSBlWMYV9nLFRdw/6buKAnwXUx0l5TAp+nm66HyaCJxCc59lKyhwTY5BCxtZcId7/ggsRCRi5Vodb++CIcg/lS9z7oAZEan9Y74R3tAFT0SfNwRG+hvxE9Od32r+PwGNVprpjnUCo0PfIhy/9FnjLQ1tJgEdd3eu0oSQye9q/vqlbgQP1sTuulHE6cP0pmij9z1KVq7li5HdSgRMO7Z/wIA3Mvp8R9h985QGwOoEla6TkZxc5MAiVJ4CGOgV2hf+km2f91AAp3JL6XvfZX7hcl0Cq8TM9TsiOLAfQ/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsddOSHnAPYiuHpRWeaUOBlII7nfN9xCMcPGBwPpklY=;
 b=B4MPr9oTGFoxyYPE4c7lVMnIvfw3mytL1/DCkBS0kqzhjqkHRnm2d50geJ4cGVOK7ehwgV4swuhthdDAUrJ3bctgTxlHW5FYRobdjY6zeXvmnAIj7Z5DNKiSM/eUPoaMmfsPn2cRau57A8IQCA2Bghvny6U5FwomqT9BfzsvrIKJvqyZgSf0e6rjlnwA6dhG3bV/eCKWuIAkQhw5OWrXLVtlK/rQwJhFK7T3fo8U9PzfDo7IbsADZwO0h4Axu6kRy149b0b9gWz2tPkNxncAmpBa0rjop/p7G6YNXq93xmSDLxZ1CrN7rm2YQsR9NgsJunjy8suvHuD3xKOGugAvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsddOSHnAPYiuHpRWeaUOBlII7nfN9xCMcPGBwPpklY=;
 b=Kq2mR/CvbXh76fR51j+2kdnET4ckcx5R2w3xmYauahH50jhhqkfc+j/LqUl6VsmJqtTU3G6HL/RUSHOwvrX5mfH1gXXjlM6DG01Wlw+lWnK2NeegaUZAZC4lhwzf5SWz5oNRkvAZAuRw4x7kUnVUgoUnfRgBilI3eG0hvdTM8cDb/8nSlUGwKBR5Jl3ca+dUDUxymjFk7euhpV/G5NaL0DERIqYJ4iYvqEjoXYnH+AuwkkTqycrPG4bwBkF2jwd7Y+0G4d+ZSogMmFo3grLV7L8M63rQrnRs3u3n8J403BqF2jiCZUrhjdYNllpTEBytQ6IhRRVaBhGVOLyoye8tEg==
Received: from DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 20:05:18 +0000
Received: from DM4PR12MB7501.namprd12.prod.outlook.com
 ([fe80::70dc:609d:fad1:379c]) by DM4PR12MB7501.namprd12.prod.outlook.com
 ([fe80::70dc:609d:fad1:379c%3]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 20:05:18 +0000
From: Alexander Kozyrev <akozyrev@nvidia.com>
To: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>
CC: "jerinj@marvell.com" <jerinj@marvell.com>, "kirankumark@marvell.com"
 <kirankumark@marvell.com>, "ndabilpuram@marvell.com"
 <ndabilpuram@marvell.com>, "yanzhirun_163@163.com" <yanzhirun_163@163.com>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "ktraynor@redhat.com" <ktraynor@redhat.com>, "NBU-Contact-Thomas Monjalon
 (EXTERNAL)" <thomas@monjalon.net>, "konstantin.ananyev@huawei.com"
 <konstantin.ananyev@huawei.com>, "konstantin.v.ananyev@yandex.ru"
 <konstantin.v.ananyev@yandex.ru>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "aconole@redhat.com" <aconole@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Thread-Topic: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Thread-Index: AQHcPdk+bH7yXUKMEkaMwTrM1QCFpbTnpNwAgAQoZYCAC7C/CA==
Date: Mon, 17 Nov 2025 20:05:18 +0000
Message-ID: <DM4PR12MB75014E5717803AB195001082AFC9A@DM4PR12MB7501.namprd12.prod.outlook.com>
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
 <20251107175936.4yr2quzngd5gnp2l@ds-vm-debian.local>
 <CH3PR12MB8233444042288DA4196F222A86CEA@CH3PR12MB8233.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8233444042288DA4196F222A86CEA@CH3PR12MB8233.namprd12.prod.outlook.com>
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
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7501:EE_|IA0PR12MB8645:EE_
x-ms-office365-filtering-correlation-id: 8178094d-0bf9-4ea5-62dc-08de2614a176
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|13003099007|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Hw8cf387Aji1u6EMFSlS/a0t3ay6qI7+PM9BohouqfEL36EwqKiwpfhMG/?=
 =?iso-8859-1?Q?1cB2fA0gcozvEaapWL0rkkaDD4+39JG0nQILjoKjaC3n9Jw/5bYv3Xo2Bq?=
 =?iso-8859-1?Q?s6LXOYvhT2OCobnvJ1yVN5u6j/TMyiU4P/DCk15G7xkXpvtYDI2XvLuZjr?=
 =?iso-8859-1?Q?SWOB/Sr2kf5X1/Nzpkp6ogQyb9cF+mlx2kg2lE7SdyBB6Ins+j038P6jPS?=
 =?iso-8859-1?Q?+VEc8pN99osEJL1RH2xAq52T7j4FFLQLbuUlenSZ5O9Aioilqli/9M4Bxf?=
 =?iso-8859-1?Q?UIf5IdHJNlHL/jCATnkhXoZ3EAE0JazbpogH1TFuyWkOjI2LHs/d21Vyi0?=
 =?iso-8859-1?Q?WDTASk8hiHJTdcLPeHxpmHK8AH0zE3gVyrHhV0g/CGPV09bAQkggZWOyh0?=
 =?iso-8859-1?Q?VfhugLuiGCU7Aag4ZM+RSbwoSNYIbgV9VR6+Tc9wHEySg9kk13vquO+j3w?=
 =?iso-8859-1?Q?93ZxGmoi+nJCspCT1cLTBuHInIkr96ZCFVGW8XKKEPvfA41CYhfNjyLirD?=
 =?iso-8859-1?Q?Sh+e7DVUtPD0vBVXs/NzzWvXLddaEkkO6rIJBZ6LjZg35PFtMP+1XLKbXk?=
 =?iso-8859-1?Q?8gOTr+2XwLqRAz9yhufpj2rr3VZI+X4NqKpgpkios2hP5vyzXtwqjndA/B?=
 =?iso-8859-1?Q?FINZ+c27n6GiwTz6utnOYq62m6DcBwkxAop2CpT+KpmrRGe/ygoBDXbz1w?=
 =?iso-8859-1?Q?jWVIfGBqBwLVwKbdDTl4MytVOUZjDrhahRtjd1uKHFBfpBMV1a+XMKoNAj?=
 =?iso-8859-1?Q?ngOFY16tDHmtR290VZ+o2Vft1tbqp3KxvlAffyivyMrEliFzrvocdm4E50?=
 =?iso-8859-1?Q?P30D6pFFz60edwqESQrJY7+Sbw3cSAYn4ySZ7y9NRFW9Wv8KwSOvk7Ziht?=
 =?iso-8859-1?Q?0r+UoIL/NmUnWYlaV3sejpxucHhLnCLn/SA+bQaHUhOVw1M6gEpHkmmtdD?=
 =?iso-8859-1?Q?e5z5e3NJ53JGkereAR0wrdKWS1Qwx34ZQs6fw/TLiAWq/lqR4XNqvMlnqQ?=
 =?iso-8859-1?Q?lxcpRh5vlqVIireMVaP2UDuFxttNsnn/cWbWHYuGKWIzlVvc6bWT6cyks7?=
 =?iso-8859-1?Q?IHRl/UQDsKgD10ltng5Tlfo8zSRD5cSP6/jRtRQW3WpyMAY2bDkIFr+mXy?=
 =?iso-8859-1?Q?VyEpdwXyedSEvangE8L7jUyBODiPJ4YB/aPrVwzWMqr3gaApiNen1LtptE?=
 =?iso-8859-1?Q?db1uoI/DffbX2KiB8BUKiCl+cRivvJtgEz3zOzzmQneUIpSU81a3l9WFzh?=
 =?iso-8859-1?Q?NK9mG4lMh25fQq/ehShSsc3BZeeWb7CdQF0mbFB0c15DzskyqmJazSHSRB?=
 =?iso-8859-1?Q?31Ib+w4hgLvxajzUZZPMx9zEYQvtDAgU2vrFm61eW/jowUVjLgFwKw9AWU?=
 =?iso-8859-1?Q?eHmwFprqKdXQ8z9vGu1vSnSlZpO0KhbatO5e61MPu0dxUU12PzoV6iiFCD?=
 =?iso-8859-1?Q?lJSAFe6bExYcF3RfmWnKRG8BhUqmmgJwVxDAq3096wdTJw0AiaJBUXgM/r?=
 =?iso-8859-1?Q?so7C7oX9fuxidhtOv7wiITdnG9Qy13lvEgPWRjz/ZIPTwUw0zw6pZP1LDj?=
 =?iso-8859-1?Q?iRsP1nJWdeisQznrm2sbPgw5SNfR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB7501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CHuekbwWMBh2yy+QJiTnUrDLJwS6GxbybwariIUcZqFR4DaZk8ORbpO97V?=
 =?iso-8859-1?Q?XobNu5WWP+IrCScc1JW/YtzqRHnzO/FKDBZnQdrJTPgwrEzkdVoE2mK/wx?=
 =?iso-8859-1?Q?mb0WKZdYc5cQ+H+3MhLw2AKAGUKWne+i3KDoFM3+3ZCMTrX2dQrCkQI7tr?=
 =?iso-8859-1?Q?ANwXjT4D/0/BNDfvtS4OzqpSEfzsGXTl2bGfoSab6RSYH4vE4/26YplG4p?=
 =?iso-8859-1?Q?txbeYDX3B/l/GVjNJIpOLEVxerFdQKIlUn5M/wnG99V2Pso3hIRi1sYuNH?=
 =?iso-8859-1?Q?TWvnxFNh0cl1cE+pX27IfpVvJMNI+xs9XJskfZHgbYgZVvkKKqV9MuSy4u?=
 =?iso-8859-1?Q?0oAVt8STlOLehgC5hVXiM+cJ/NKGhUtmK4OVZwAwz9Q5IzAhTXT2nTWMnQ?=
 =?iso-8859-1?Q?U1GMBjY/QqtKQS/nOLUoS2St1iGPq/gV5G83SZFGoqt5lnzkWGn3EPooM5?=
 =?iso-8859-1?Q?eJ8Zr0Z0VLcwk05DkoD5APRhitsrTkT0JtvEvUkgVZ1QLLjDZng+RKE6RM?=
 =?iso-8859-1?Q?QXnBtuBrPUtCNUSJL3PhrTkR8l0kH1iRmq45HPDWIkqalwz+c4ySEnvI8L?=
 =?iso-8859-1?Q?vp9xcB3o7SsZubpEHmT7UXXbYczk9ZDGkHb2CEpZWHYx6kTdkl+JX+4E+C?=
 =?iso-8859-1?Q?SzHxFLkrVjnyC26FVvo8OBHXWw1nnWVIRJW4lN1fDiM6pcW6oC0enM7F8n?=
 =?iso-8859-1?Q?FrAE6qaFhwEXnag7O1RtMHREd9ieoCZff4IlDruSZfHKTLHuQn8iGlCu9w?=
 =?iso-8859-1?Q?LdzdqGJV6u3jhNmI+C7gSKZlL2fgHY2Pahc7LlkSRb3Zv1s5wvsLz2Dyug?=
 =?iso-8859-1?Q?oowCOgP9USU+9uqgpXtN+is+EjiRI3cmHUQeTTP4sq6MvjpFkQ1XY+O5Ft?=
 =?iso-8859-1?Q?qfmoWWoPAyYQTxOp/sz5/wKmYO67BZQi9gC77dS8vVRpHcWzD718tR3sug?=
 =?iso-8859-1?Q?XpTd0ljBzaOGSjroPrH+3KZWrnlWCDz1ApoeryzpgWwF/zI3FvCRg5ynpa?=
 =?iso-8859-1?Q?q7xGbT44b2B5mwKdOgTO/Ft7CCcGH2wbtuf/X3Q8I3l2JtetErsLmniIoR?=
 =?iso-8859-1?Q?ETEndXwP8SjEEk6XHQ5HrvsI9AiCQyR3YCspwbDwJ9qX94PE8Oi5fsnrqY?=
 =?iso-8859-1?Q?UCx8evztpT3o6S2w44uomVacfIQDJkjnE7DJMZMKg1QaVfCD6mQ1U6M5k5?=
 =?iso-8859-1?Q?qXQ+g3wHmH4HIySjPDItO1lUf00clzHHAMW2T3lw0QJc96OWCa2dpbT9Fx?=
 =?iso-8859-1?Q?dHfQ+fnkpH93A4lXocYOUGgVHjsKVLPf8q2TllHRLnqa+o4j/yez2srEZq?=
 =?iso-8859-1?Q?k+34C9aCAQUBX4RFgxUN5exDpHSjc30BPWuvNNiv02No8FVzimwQb9JNn8?=
 =?iso-8859-1?Q?+Rw2pTzi2JQcPTGlsss6u0E74nuHwcAKJwoVLIghnVFksrWljD0XD8BSW9?=
 =?iso-8859-1?Q?GYKA/lvIrfCT0uUQdMGQZCj7MmN5koNSH9y1EKoFYbIFpvH0A59/MTxOW+?=
 =?iso-8859-1?Q?xuuTytWKr9B4xkiVf+qGshjoGpaS0wzUL/9jmUnCI/scpKarOr7N0u8p4a?=
 =?iso-8859-1?Q?FuMsEnoWvR4/CNh9Xz48MfA6ZOix3Dyf69dDilMODQSDU2TX4aioolPfnl?=
 =?iso-8859-1?Q?ds9vvNKMPFPWo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB75014E5717803AB195001082AFC9ADM4PR12MB7501namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8178094d-0bf9-4ea5-62dc-08de2614a176
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 20:05:18.2708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +n82ow4KEVq0a/TOu3IwVLdI6hXdbphjs3txf9JGOiDp95xB5sYUafiiunVDscxVOrJpbaDmhbuRwUszjr2T3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
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

--_000_DM4PR12MB75014E5717803AB195001082AFC9ADM4PR12MB7501namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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

Sorry for the late reply. I think we should check opcode in both cases.
mlx5_monitor_callback can be updated with the opcode check for enhanced CQE=
 compression layout,
instead of having 2 separate callback functions. Could you please prepare a=
 follow-up patch for that?

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

--_000_DM4PR12MB75014E5717803AB195001082AFC9ADM4PR12MB7501namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
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
<div style=3D"direction: ltr; font-size: 11pt;">&gt;<br>
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
<div style=3D"direction: ltr; font-size: 11pt; color: black;">ACK! Will upd=
ate this in v2.</div>
<div style=3D"direction: ltr; font-size: 11pt;" class=3D"elementToProof">&g=
t;<br>
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
<div style=3D"direction: ltr; font-size: 11pt;">&gt;<a data-auth=3D"NotAppl=
icable" class=3D"OWAAutoLink" id=3D"OWA9a0f3ebf-fbf5-a7c1-a2ee-b68156978848=
" href=3D"https://github.com/DPDK/dpdk/blob/main/drivers/common/mlx5/mlx5_c=
ommon.h#L277">https://github.com/DPDK/dpdk/blob/main/drivers/common/mlx5/ml=
x5_common.h#L277</a></div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
Sorry for the late reply. I think we should check opcode in both cases.</di=
v>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
mlx5_monitor_callback can be updated with the opcode check for enhanced CQE=
 compression layout,</div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
instead of having 2 separate callback functions. Could you please prepare a=
 follow-up patch for that?</div>
<div style=3D"direction: ltr; font-size: 11pt; color: rgb(0, 0, 0);" class=
=3D"elementToProof">
<br>
</div>
<div style=3D"direction: ltr; font-size: 11pt;">&gt;<br>
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
</div>
</body>
</html>

--_000_DM4PR12MB75014E5717803AB195001082AFC9ADM4PR12MB7501namp_--
