Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D22FEFB4B
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 13:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A24C402C5;
	Fri, 27 Feb 2026 14:03:53 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1A0054027F
 for <dev@dpdk.org>; Fri, 27 Feb 2026 14:03:50 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61R7YPAX1535122; Fri, 27 Feb 2026 05:03:50 -0800
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021127.outbound.protection.outlook.com
 [40.93.194.127])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cjtndab0a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Feb 2026 05:03:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svQM2TNHriMgpG+Ww/rrtUJ0WGX02/Ew9dHO1inj55qtnS+BlM0cByMWesWAm7DgAoczHXAa2JRPYUZ3tk6pcQPWSu4JLN8dH1q3mRFNBUmvCo4g4dCaZ1bQIqba+anFlBETBkJXordSqQegs/frbRovfdAoxn47ujrvmR4tOOpEUhvurh7lzUaiqK43iqYn+VPUffvvZYtc1EveDUNZz+W+vU9W/rEBwunAUKnT8+HCex7OlnVGo72cZOEkBBoER1k0xJp4O4MwIOzo465bvLxJn7oGCN8OyZqV7BvB6YliDQHkbuel3X3pBq3fyq7iOnakTUyBm+3qfd1B9c2kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPgYAznvc1j3yYXDFoFONQS54ZrcZWNHyUC6u54Xwac=;
 b=d+hQHzMhHbV5RLCVtt4SSFVGl8No1SaYTaOfQ/fC5zcEPfWBK0VuQITqUa1OtPb/hJB604p0czvuZavZQusoyJ7ouGlyOaT7Pf6kh0fS7pgrAsTsBkJK5TJkv+sPwiTlZctt3iMe35hIktNM/6qooRQaevkDkllCQMaZBJwh63W1NnCu7MWN5fVgIHvB4Skt0icXgHioWWC5BrSN7AHEvEf8zUQEajG8t5Vt9ihnyvykPmym12CYd0Mo0NS0BqFC2g8WsCcA/TI/CaNZq5RjLxP9xP2fDsjTGF65TU/up8iOgLSCOVxfJ88iOiCDP1t++tNGR2md4wCvPeuYn+cm/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPgYAznvc1j3yYXDFoFONQS54ZrcZWNHyUC6u54Xwac=;
 b=uVQv1IlufgQLMEbOgcAPmzy/t/iQfSFcwrcIg433q/iOhc59Xq7bmOuAsurdMFlbn1qtb6ABWzhOKigs/XYQ3uUR2Ypu7Ayl+SPxwwcGKY6jPDY/atDQ1s3IDNADXJa2dCaTWhj3b+3kLnZ5Hj3t3YZSoNGXqxLQlGvz8OqvQmg=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 DS0PR18MB5271.namprd18.prod.outlook.com (2603:10b6:8:124::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Fri, 27 Feb 2026 13:03:44 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%4]) with mapi id 15.20.9654.015; Fri, 27 Feb 2026
 13:03:44 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
Subject: Re: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Thread-Topic: [EXTERNAL] [RFC] net/cnxk: only build if platform is specified
Thread-Index: AQHcpc1jpvvtk8CaqEm1+ZmUQ/c2TrWTDb6zgACjMgCAAB042oAAMAQAgABroEqAARURAIABCDhZ
Date: Fri, 27 Feb 2026 13:03:44 +0000
Message-ID: <PH0PR18MB408623281947DC8C4700ACE0DE73A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260224203709.27696-1-stephen@networkplumber.org>
 <PH0PR18MB4086434B58662DA7BF5F5F00DE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260225094338.5f0641a5@phoenix.local>
 <PH0PR18MB40860D76EA53C8DC495E81CFDE75A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260225142004.07954fd2@phoenix.local>
 <PH0PR18MB40866F9E996747CAF9CA5443DE72A@PH0PR18MB4086.namprd18.prod.outlook.com>
 <20260226131656.455bc76f@phoenix.local>
In-Reply-To: <20260226131656.455bc76f@phoenix.local>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|DS0PR18MB5271:EE_
x-ms-office365-filtering-correlation-id: c0a3bfce-46f7-4ffc-d1fb-08de7600a30f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: L287E+JojnYRgP6cv0gS+Wgt9KC+BSAK0RbpdqOqyEoI9/JgD2BKBcEuqDem2eZlpAIzOwMrmZ3DYkNmbR/7AuigcfH1YlTezTSiXdiYX04Eb1gahPxZcXlgIQbLf0j2i7Ram/8y2lVAvvIl2+MZaEk9+zpHwjKQPZWDi9aHFR/qhsQYIaURWsYT7odDmwoxa5Cd4emqDwRgHTGJIRPB62MiMINivxMYFzvl+rspdjtY09oXUQBzumLqu0v/WMDTRy2gOxw9i0XIrfcr+pbHnYqFmzvFCzWGhCICBtmvlTqIM+OPSoN9nsHDeW+jYYRTyFELDOpdR2eCgZ8mly7x2Y98TGV7BDoc1QlBx81cZ82eR8zyjNMCtRYFGfBx6295Bl3fGWmEDr5h1lTx7e+ej1u+0VPNqdL0msF8gMRKGpj7IYcbJEIp/7Ul2q/ph8QVlEhcaZrA5VSoirdBaBuYgCNVyx7gOjuAX1S/vRHNwf3XL7+jCMuzVf67GXaPv+9QNAzzU1j1qBOPTUrYdVqhxAULk2yUTWHYfpo1TwzQR0xse5JXxS2FsbiWkV8Td9PMUqLNy4O4o3vsbdb0gGv1+xw4RKkxFm3he7PgNTXpaQPVy449m0QxeihGYflpsAe4M8yDR1CI1EdvGrCqKKe4oo8ZPGORc7oYs/TqAAup8jfGcED4BFSmStTj+SCfNcka0heW81ul4njo+shZ/YW199Uva5ao/kYhI+LRlWn6XWAKIi/Px+P3C5WmQGL556BMZhCO/T2XTOQt5FTeRRmemGi/SYiNry00kRZXvPKNHOc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?lmq8R6mWwEIOHJ55g77qWECLZ4qfGFR14DbSRw0z5lu8D5Wo6RUTaHH9?=
 =?Windows-1252?Q?GeVuHDvzx+isINKvcAul8XzsxinYqLbswfzZok6vm9Dk5Eb+meXTx/Po?=
 =?Windows-1252?Q?g4m6Bo9EkmBYOtKvrncdxkRBNm8FLqlvxfJaQx+86oFljjec3/1OoAs6?=
 =?Windows-1252?Q?8zM69UPqc8JybqenPXN7cr3zfwCkxA2wv6JuP9o+ZAyUhOB43Wts3yFN?=
 =?Windows-1252?Q?RHdy81JMr4QHUZQ+RsyPkSswQ+gPhPYYPXwg9jcgBlxwc09e9dLfWMMd?=
 =?Windows-1252?Q?qU4I7fHQ97gw1t8vBEzzouT1AxABelcUJR8uieFLKbQHWZwRG8R8pQv9?=
 =?Windows-1252?Q?sjtOX7aFD3ItPgmj/vBAeiiYKhKRnAFKs/iCg6CKh6Bcjxs2rkDtrP5n?=
 =?Windows-1252?Q?rctjN0aLOLO0wMNfTFDQBIuqGHY9yavHzNRO63M/+ovoZL5q4xNspvNb?=
 =?Windows-1252?Q?LK+m6UWKd8IEDNYb0+O3A2scAnCfVAwoi9lElvU/LWEGeac3b3aOXGAB?=
 =?Windows-1252?Q?AklSM/zt/4Qqcy+yjZk1lliluddPJRZ7/HrLeA50d+ZuiS90wtbFGEi2?=
 =?Windows-1252?Q?vkK/ZftzXEIAsnY7p8HKmiE+UUJleCk8hVJwceoLF0VTx/z0o7gri/qA?=
 =?Windows-1252?Q?9NDamNfRyorjrQFUPLKrkqqxcqK8gDU9uupvI696IGrqUki2VzVsTltR?=
 =?Windows-1252?Q?Ez5BCZgOhZEb+tZt/eOX76MUC/eEI7ypN3ajMZPbjJURRIdVC8EOVsWx?=
 =?Windows-1252?Q?N9vr9zUZ4DCYcwTFroPjZLkXJT50vOEPWCNRwXZh/Q2QZORzc1zwC77g?=
 =?Windows-1252?Q?bcBib4B+0fcLT7goyEKvI5ZaWafRit+Gon24byzyQDg4r8qlEYQVmpyt?=
 =?Windows-1252?Q?Qbvp8+XmFca5oI8eGZlZA+c+Hc+RRzxcyQ2A/l3NRZJNVa+RM9db/1wZ?=
 =?Windows-1252?Q?JfkIyQ2nzXYfMq3ACAHkbZFr9xRaUdkifdtWT6OuBq0sVxxwYvheS7pB?=
 =?Windows-1252?Q?LenK2jru98kj7Wp0Ticj6z0rcZT+dxJf5EboI0dpMIK3Ov+f+w9R8Lt6?=
 =?Windows-1252?Q?2m5HDLGwLV0K3rcZ7alCsGgKul9YzxcLbRZKUV5SbsM9TqJPq3gbQrYN?=
 =?Windows-1252?Q?GPfCiilrXVdadhehf0kcCs4t17eqQvtjXZKcNhm2lLESMZ1iSzcHqldH?=
 =?Windows-1252?Q?GxbNkywhPjxcDxrzK4a5KPQ4MoSL8EJu9zcoxzHBGgnuPMJTHI5JJBaT?=
 =?Windows-1252?Q?LVTyhWlcw/s56WcZbqabIIr2UXEJB02/ABP+FvtiOisdCW7IVBrHU877?=
 =?Windows-1252?Q?JBcKNIaCeYcSHVIcLz6EWLLCRApJIGiauA2E/Fvx7zara4ZpPpqddLpV?=
 =?Windows-1252?Q?eDnUS3T+j4Sl1BxVS1ZNJp+vIxtkqfbww5HZG2MwGjaIIV4t0AXcHges?=
 =?Windows-1252?Q?/DZyNv9FFPIkBHz/6hiKF+10yEegf1RuO4LzXqqcHtokqA2OJOZJUhYe?=
 =?Windows-1252?Q?13fG9sAguIlqzFltbdrFh3K/g6sgxxzIXOAW1ahGc4ak73HMYwM1Xq5u?=
 =?Windows-1252?Q?ONYkkuyOIElfhbcGjcLMtnZoOqt86D6o1986WZtt5w2xm8Wdnj/8Bx8Y?=
 =?Windows-1252?Q?4TM7xilNSoqBmJOI7FICSMeFPcqQrOkXhDur3GogHTXBS03MhgAJAx6k?=
 =?Windows-1252?Q?iUcWEg6+zFAhcIkmD2GupHiBBpPDLSgfTQfqatcx0ldaAx//iaJEx1h9?=
 =?Windows-1252?Q?bMT0JEzWujc2fJFVgdCeLdZnUuCmeKqKZL40jH126gzqajlR2IgKaYSB?=
 =?Windows-1252?Q?IIg7ibfXuGgAeqzkfsw72O5InubCqJ6T1pUJO7WAukSXluyxvfgjbr9O?=
 =?Windows-1252?Q?+scKi8/ZKQZ6cw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a3bfce-46f7-4ffc-d1fb-08de7600a30f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 13:03:44.0912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYqN7kBD+V0PlarszsZVngfdw7nIo6koYKLyhAQbO3Ot9e1UeRuiIDIKkSZ8vOGvxh97npQE16hjESI3c6UJzROHNe8Gyssv29kbAgezHZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB5271
X-Proofpoint-GUID: J3o6-D73gDGhpg5PrjC_ndS4Vs86BvjB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDExNSBTYWx0ZWRfX89rdERyBj1Y5
 JxFiXLHt76h/JXgUToCjBsWONHSfH14EFdG1EEZXevb1Lm+CiVJsvt1avB8iNAp4SxfnFSwNvRI
 0Ck07G5L+ZZ+CQWY9L7yMBlBxvPklL2Po/ZR/mYXJj8xgDXxeWObxdN0Hk2vQawxvmpd9E0cldT
 0yO4vC9a75k61+jz07iFQbxf2kvf49b7pmvz23NK1HNa+bBwzNOGS1YULBLb3NdAB5gnbMpivCx
 SCVNAs0S2j5TsC6E/zXWeGUoylpz6yMHv5Hqigba/hiZvf4WllpbeEOFOpwhWph4Ir9F5CySTt5
 irxmTYJg6px5yf5QDRyKsq85Hhb+vd5XWbXbbs6JDThY0n2UAodcY2y+cIKQXBGHp8krzGiJ4eF
 GinNJWpKGPK696hVui+kXrAvsA4UsFWFYl+oT2hGvKdpVhNXLfj1KKJ1hgy2TYOAzHE2wG/815i
 lDIzuWxhw4cuGuYS5bw==
X-Proofpoint-ORIG-GUID: J3o6-D73gDGhpg5PrjC_ndS4Vs86BvjB
X-Authority-Analysis: v=2.4 cv=WYMBqkhX c=1 sm=1 tr=0 ts=69a19636 cx=c_pps
 a=wuCIV2M2hcCPwYkL8T+rjw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=N659UExz7-8A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=G__-7vQMq_tgYpXnReMA:9
 a=pILNOxqGKmIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
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

=0A=
>> >> >Good idea, but fails miserably.=0A=
>> >>=0A=
>> >> My bad, here is the full fix, verified on our arm64 machine with=0A=
>> >> meson setup build -Dplatform=3Dgeneric=0A=
>> >=0A=
>> >=0A=
>> >Ok but other than getting more build coverage, is there any point in=0A=
>> >building this code on a generic platform?=0A=
>>=0A=
>> The driver can be used with distro packages, though it won=92t be optimi=
zed for performance.=0A=
>=0A=
>=0A=
>With some defuzzing of the diff, got it to build.=0A=
>The old build time was 11 minutes, now down to 2:33.=0A=
>=0A=
>Here is what was needed to get rid of uninit warnings:=0A=
=0A=
Would you update the patch to include these changes? Or should I send a new=
 one?=0A=
=0A=
Thanks,=0A=
Pavan.=0A=
