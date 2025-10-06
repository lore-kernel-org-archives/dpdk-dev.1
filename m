Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC193CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 18:56:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE249402E2;
	Mon,  6 Oct 2025 20:56:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9776C402D1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 20:56:47 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596AcmLS014972;
 Mon, 6 Oct 2025 11:56:46 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023110.outbound.protection.outlook.com
 [40.93.196.110])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49mc6pgyv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 11:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PICyEruBKiXG2tzbFO2YfY6Nz1RFR3GksfZDt3Vkg5TQ30Ql4/cf6vZ+WqlnvdVYG4mDZMTacBdnMwODr2ffUf9EdIg/+JnlC7rp6wQqFmwwSPu7KZICYKhcGj7xSRm6bcteDoZ2TZhbuQqSUs6q/iPReXKEzHCuR2HZHVVaboGpy81TYs5Kt8IsxUf2vRiDwVqa461Tvfmoz7+YDuS+YZoWAJyN87xsuSG9qm20CyPJ4JjRqL6SeunQvAS1ZqDYmO6iAo2mMf/Ho/0r+LnbtXdOtaHoklp18GRI5xEnogL9mJKs/jAZMwk3pgszc6ujpYJPkR516biFk8Upe/EM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgGnH7rCWh0zfmvGGygafhrCahvEIkaf2+PdfI2vdXM=;
 b=AzYeq6inx2JlsexWxry3sZUaq39NvwzFqoY4pAopDcwBvZTsNosn/Vd4sizNhHugDarRtHj7WYO3yUHp1R/bbv7vOAbMPIoDcqD7zw+ocomq8CORR8p9bSGjc7zqZ65CsYXmxFOknuVKKZKO26jYBLOOchc2TrVuJcR73WNBSJdno8v2aS6wqGBsNgKzAAAW4wj0avq8Mvp2s/FvyvmueapS0HMSEPEnMOKurIq5DqMyJHSEj5MNSmVi/GfkhgA52+mYGf8jW3m0fEhT6ge+LMa4chQpxJou6Udcd4nhMk4PBXnApqtKlFrIt6CA2oMRKOlQ2OJScjmw+0TZ4japGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgGnH7rCWh0zfmvGGygafhrCahvEIkaf2+PdfI2vdXM=;
 b=PiYsCVSXRURZn+N3GbTh+9LivuZDWWnVXu/KM/e8bjdwnC0IqMwvx+zhx0vnQjs24jTGgkXTsMigCtOPy9NxurP1nSxrHGvXVXmBCln4XdCeteyQJZlr4X63703IMVjHsNs9aPbFw+LRTMLHoSnZ629kVW47dLFsd2rUk2a/PVs=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA2PR18MB5887.namprd18.prod.outlook.com (2603:10b6:208:4b2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 18:45:33 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%2]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 18:45:33 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sameer Vaze <svaze@qti.qualcomm.com>, Fan Zhang <fanzhang.oss@gmail.com>, 
 Ashish Gupta <ashishg@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v3 1/4] compressdev: support for dictionaries
 and PDCP checksum
Thread-Topic: [EXTERNAL] [PATCH v3 1/4] compressdev: support for dictionaries
 and PDCP checksum
Thread-Index: AQHcNJ7TTX2UitPS50aY7A+23OSwL7S1eLiA
Date: Mon, 6 Oct 2025 18:45:33 +0000
Message-ID: <CO6PR18MB44847AF519DE26ACD16204DCD8E3A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251003165132.3201643-1-svaze@qti.qualcomm.com>
 <20251003194901.3375364-1-svaze@qti.qualcomm.com>
In-Reply-To: <20251003194901.3375364-1-svaze@qti.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA2PR18MB5887:EE_
x-ms-office365-filtering-correlation-id: 2f344605-e53c-4a40-5c4a-08de05088820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M1M1V0hEbXUvU3ZwQmhIKzJFV2tvS2JuUm5DRmp2dkp6OHZOdDhzWlNabEtF?=
 =?utf-8?B?UFp4NUI1UkZnbnR4aDRuY0xkb01jVk1UMmJsMUxzZzczdjZsaFNTc0F1Tm9S?=
 =?utf-8?B?eldNMjJDMmMvc2FzK1oveDBKWkVTekZtb08yTUxXOUNCanNtNzFFa3R1WDUr?=
 =?utf-8?B?em12ZmVtY24wMjU3UFZrc1RueWVtWFc4RWxneHlPRFNhVFBJbHZoYnp1NWp6?=
 =?utf-8?B?ajNwOUkwVThaTmxwUllsT3piQ055VzJWcjVGeFIzYVdBck9mUHVyejltWkxo?=
 =?utf-8?B?ekFvZDhFb2VBQW5FN1Y1eXJhRTVBRW43ajVCa1RTMGdWSjdQTkY1a2gxVHk2?=
 =?utf-8?B?dGlTTldsMk11K29rREVEQXJqczVrMlE4eUNCQklzN0FOZkhlSytZV1V1Rmxo?=
 =?utf-8?B?OHBTd2VSTTlack5yWCs5WFFmeEo2ZXZjaWFGM29UMDNRUUxYNGZOQmxocUl4?=
 =?utf-8?B?QTJncjl6SVRsSmtVSnBaZHZqWXVFSG5ORzBiZ1RPUk50T2pZa2hQL09ydEdU?=
 =?utf-8?B?UFpaMDNHRkJmaXkySjVxTVROWkI5OVQwM1BMOEtBZmZLZGl5Yk1OdDFkYzF4?=
 =?utf-8?B?QmIyeWVsenNIVnhJb0plYS9GZGhCVXpGM3p4V1pXcUYzR0x0eExvQThDY3k1?=
 =?utf-8?B?ejVBV0V6MytPNVdyK1JhZGhzdFJBSDZ2Sk40MXY5V3BZWFV6ODlOckdVbHk4?=
 =?utf-8?B?Skk4bHhVSElKUS94TGw4c0tZV0xqdnlVTlJyZjlhd1NhcXRVZVpzd2dpVkdY?=
 =?utf-8?B?ZktmeDlEYlUvRGNVbGM3TlB4K1JjWSsxQXBEQVlxd1FMWXYrYkg2RWw2NFlr?=
 =?utf-8?B?VmpkdWFseGNPUUUwWjRJYzg3TUJYYnEzck9zOGRqNzE4NGpVMnhMZkRyOWUz?=
 =?utf-8?B?YnljOFI1WlpGT0NiNFpmN21ud01mR1VkZzBnUzNwbVB0Y2NnTmk2UmtKNCs5?=
 =?utf-8?B?akc5VXZhWXAxb3pQY0RJOXMzM01pQkQ5U0J6TG9HTlZFTkpIRTR4Rm52UWkz?=
 =?utf-8?B?d1FzVHNxVnhSeTVWUXdIMS9waXcwSXlaVEZqcnZFNFdTdWRBRy9OVklJbVd4?=
 =?utf-8?B?R0wyMWdLSW16VlIwVHZ4TUJRajJ4bXdDMzUyOWQreWhta3MzM0Y5UGdQbk9i?=
 =?utf-8?B?ZHpxVGFOWC9nYWFVTURDc3hORkhJQ0ZBbkRzWDdJUmQyTCtRTDEwdGxJNHlp?=
 =?utf-8?B?RGRBVW5ZL09PQ3dDeUVRTDRhZVhFMmQyU2RrempUclN6cGF6ZS9CamEyMXli?=
 =?utf-8?B?cHZ2UHh1WmlVb2VDdk0xbEhUS1R5QnJ5N0NzTU9abS85RlNvZ3VPempTNWNZ?=
 =?utf-8?B?dUFaYTNkUVdSNmVGYU4yQW00aDJxZ1FDNm5EWGh1SnZNU3h2aVZkV2hWcFgv?=
 =?utf-8?B?YWh6clZ4bGh0MXB0OG53cVdKODNIbk5lVlBlaXVVbEovd21PVHl4REN5SUxh?=
 =?utf-8?B?R28rMzFWZUM2eCtsckNINHc4YU9jS2NqbHpXT05KTFNwY3liV1Z2Rm81aEFS?=
 =?utf-8?B?cXhRQ1AvRXhNMEduZzBYMjFkRUtuTUYvMFk0aGNueUVsVld5bWFia1RZWnJ5?=
 =?utf-8?B?UTlQbU51RmZmU2pzc1JnTm03VExaQlhHbjdYRk41ZUIxN1FNVkNOZjhWMTZJ?=
 =?utf-8?B?QU8vbDJzUkRQL2RRbW1YdTV5d3NUdHJRNUgydnlPT0FRbUoxNUpXWmFMTmFp?=
 =?utf-8?B?K0k2aTNnb2ZURGQ3NTF2WVc5RSt3cU0zQ2xEV01NTWJLM0JCcTc3WXdpa01U?=
 =?utf-8?B?Y0FVS2FkdnA1SmJFY2lUSFhOb0gwQXFwOTlkdWorN2FZNHRVMHh2aVpJV1I3?=
 =?utf-8?B?R3NqeVdwTXRWa0Ixa09WT2NyLzBLUnhNdElnK1J3dmVCNHN4anlFQlN6NkxQ?=
 =?utf-8?B?VFNsT0RMb1JIZUpxRCtsWUlrRnoxNmRNS0NmL1p1QU5nRDdxUnN5M0xVZDhj?=
 =?utf-8?B?ZDcxT2ptdHUyekZXZEdZL3ZXd0EvZytQczBQejZ6TW9Tc2NJa21zZTNTamZ6?=
 =?utf-8?B?dE5NWnNmWEl3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmI2ajZFVGp0SWF2V1pkc0pVODNOZGxDMVVzSjN2b21vUGZHY3ExWEhtL0xt?=
 =?utf-8?B?eFdzb0JMUjVRNVlkaThDYiswQXk3V0hqM3JKSGpBWkRhMmNHZmhnbTBnYTNt?=
 =?utf-8?B?K2tGMUdKZHUxRCtWdi9iQmNabWIzdWNuZWNiUHo3MFhPRWo3Q0wwNWJlSE5i?=
 =?utf-8?B?TnBNekE0N2g5SkZiS3p4VDRIWS9XZFlUNU9qR0ljU3JCcGVQNE5UckpFRmZs?=
 =?utf-8?B?bElJaW52WDNKOWpEQWw2K2VTMzF4b0xMdGlYaUdaZ0hZT3N1RkNvbFJYT3RW?=
 =?utf-8?B?bytDdmRTK2JTaTVTSlNoQ01sUnZ6NWhIMU8zWktGU0xGNXgzVzJ2WWlIRGY5?=
 =?utf-8?B?NWE4MFRyLytZakhrUTkxTmtZMmpHdEtsQ3dMampKM2hqRDZ0OW5PRlliRyta?=
 =?utf-8?B?TzlqaG1Kd01oNEcwOStmOWRzNHI3cUM0bXBEMW81akd4T09RWGNFT0xucmZy?=
 =?utf-8?B?T3R5LzRERUMxY3VnaDRJOUJjcmhEb3R6c0NxbzFxWGZBUk5TQzRJamkrVWdu?=
 =?utf-8?B?Rm8wbkpZNlFvc0ZNVGRjei8vVGFjZisxaFdtL1d0Zit1MFFOL0cwU0JOQ0Q1?=
 =?utf-8?B?NmNYZ0lxSElNSHFZd2FqekpOS2VzRU43akFTN3VTNGFXNG41bFJSMzZEMzJW?=
 =?utf-8?B?UCt5TTd5SGdJRm12Zm13MncyYzlPb1ZBa0p2cmdwNnNkNzVPaElPcWJ1VTVO?=
 =?utf-8?B?a0FnbnhLTzF5N09QMHhWMXY2RGx0V3pVY2NveTQ1b2dTTEpyelNaWTg4ZE4z?=
 =?utf-8?B?cHhNemtkRlBmdGNDN2lmU1dxWTJOVTBQQy9Hd0tmcUtmVVdWRmJGRnBHUTU3?=
 =?utf-8?B?ZlZUNXJ5dUdFUlcyTDZiRGdYNWpzRGhDTklMZlMybjdkYXdTb1lER0FnYVk3?=
 =?utf-8?B?Nm1zSGZwK2dJcFo3V0pOU2NrbjdRVk44eWwyc3NKdEJUUVlMUGxXY1B1aDZY?=
 =?utf-8?B?WXV1a1d1ZTlLSGxkZk1xTTN1RDZEcU1NTnFuaTlETzZ0ZXYrT2I2WjI5ejNL?=
 =?utf-8?B?a3FvcDBrdFlNdU5DaDBqSXQwR2JDUHpsQjdjTlJYcjd6NFM3cFBLOU5JRnZS?=
 =?utf-8?B?dDBXejZzaXRNcjdSZjB5djgvZzcrMmtabGVEMGRNR0F1c05XcFVOMDcxRDNu?=
 =?utf-8?B?OGd1VmFqUVV1ck00QkhNdGFYMWtFSHZERkp1R2JOQXR3SWEyTkFDODBoNy9H?=
 =?utf-8?B?TWNxNCtIdXNQelluT2d1TzMydjRoNW5VWDIzWkRCZ3VUdGdHUXQvdlBkUzJy?=
 =?utf-8?B?NVZ2SU13cTNVNDEzNGpDTEFneUxmclBFQlJmV1diZGRScUVsb2tUaWpac1pB?=
 =?utf-8?B?amxlYWVpOWNUSHdicXprYko1bXhmMU1Dd3Q2cVJpMVZZVUJ6ZFhGd0hsWXYv?=
 =?utf-8?B?cXF5UnBPV2p1bS82ZmtEd1BaVDBKb1NxSFl3SXBvck5TNldKSUhkbDBJOVh4?=
 =?utf-8?B?djZMeDE2Kzc2TTVrbnRqdCs0RGpiR1Z4WEdHY1AyQndYYndsV2JUdnFRQjNj?=
 =?utf-8?B?NHNiRlpBemdqRWpYL1ZPNVZtRllLR2pYVUdPUU5wT3g5S0dKZFNoUW9YbUlz?=
 =?utf-8?B?Nng2RXhISy9iL0lOZEgwSUxRT29sbXY0L3ZFTVhOTjFsaVRtbHJHY3FwRENh?=
 =?utf-8?B?Ny9KUkdjcWpXSmlXZVJ0Ym9CNmxtU1FNZEdQOFJaYk4vN20wVDJjQjJoaHE4?=
 =?utf-8?B?L1hzME5Jb1g2SjVhRW42TDAxbjM0eW9FSFpLK2h1cURKMGpRejYvRm9MRytK?=
 =?utf-8?B?d0paQmNOSy92NUQySHdBQWdvV25YaXp5Z2RkY3pEOGlKamoyTURTdGN2Z1dP?=
 =?utf-8?B?dTRuL0NuZWYxdHlMVVIvV3lCS0dLMW1BVk9RWXhYYWtFOWhDaEhLU3I2RTJ1?=
 =?utf-8?B?aEprL2dOaUxFNjVhZ2dKWGZIVmJhcGVpT2hDd2tyc0xkdFBqbGhuUHBKZ2JY?=
 =?utf-8?B?Q2lEUXYxdlo5akwyZXlndXc4SGg2Y2diTDJzVHZpcXpHbjAzc0dWSW03YWQ5?=
 =?utf-8?B?Z1hBTno0STJ0bmdnUEtvWktSeWpGcDhqZEN6d3JVWkxIOUxkN3BnTWZleGlU?=
 =?utf-8?B?dkhoWU83dEJlWGdDUU1rS0szSGh4ejh2dVhra2o3clYzaGx4YkRKd21STFJF?=
 =?utf-8?Q?Jsgr9dL7o/Rr7uxmBPJZj4h69?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f344605-e53c-4a40-5c4a-08de05088820
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 18:45:33.4541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgtrPt9DQ9BpU2F4KdCeXdiJhSHLbXeoxDuYExz6ljIYwWX5XeAOU4R8mX4zOvW0GmylaPsdQhBEdTMOuAqNGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB5887
X-Proofpoint-ORIG-GUID: pcJTl4jvEgRLMjZXS151DfkYZDJPHqaD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDA4NSBTYWx0ZWRfXxgrpouKLsJ0b
 NMmb8XyyDRcX2J8NE8/YSWA4jcV68Zm1wyLMWgrxYp+ky72FMJ+Dj3Rgvskq/uVRB1Ba+B8wRnE
 JW8XsATSassHa2l3wmpSiZ/EfPrykf72F57cBf3HUH1JoFG0zGvGlaW0ZFlIcawwoSkO1YPLaZ9
 sIAKoUlp2p2xD2JmGVJsKMBGN3QfJLne1eD3Rrkszhv6zZRS3cgKDkRoi0n/xWAxzFG8cgT9frR
 4EGn9nam6OkaRGheeDRR8pMbeg6DUH7LcXUfKgH48OCErKIJQmdY+y/lBzLPnNskMsAuNDI+jcY
 XONlCZu50IKdmWfBPAPKGmoAoN51CkVHXxCSsNHeGT0f/IRDS3Z93DfneUW9I3mUc2zBt9e98RQ
 emV6wc1WtzYPv3K6gqmL/w5eCgeFbA==
X-Authority-Analysis: v=2.4 cv=Z+fh3XRA c=1 sm=1 tr=0 ts=68e410ee cx=c_pps
 a=qcps1HI71LguUYAr+x9W0g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=RpNjiQI2AAAA:8 a=EUspDBNiAAAA:8
 a=Tqnzzm0ixNwH0ZBMuzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pcJTl4jvEgRLMjZXS151DfkYZDJPHqaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-06_01,2025-03-28_01
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

PiBBZGRzIGRlZmluaXRpb25zIGZvciBQRENQIGNoZWNrc3VtcyBhbmQgYXBpcyB0byBwYXNzIGlu
DQo+IGRpY3Rpb25hcmllcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2FtZWVyIFZhemUgPHN2YXpl
QHF0aS5xdWFsY29tbS5jb20+DQo+IC0tLQ0KPiB2MzoNCj4gKiBSZW5hbWVkIGNoZWNrc3VtIHZh
bGlkYXRpb24gZW51bQ0KPiAqIEFkZGVkIG1pc3NlZCBjb21tZW50cyBmb3Igd2luZG93IHNpemUg
ZW51bQ0KPiANCj4gIGxpYi9jb21wcmVzc2Rldi9ydGVfY29tcC5oIHwgMjcgKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2xpYi9jb21wcmVzc2Rldi9ydGVfY29tcC5oIGIvbGliL2NvbXByZXNz
ZGV2L3J0ZV9jb21wLmgNCj4gaW5kZXggOTZkOWIyNzZkZC4uYzVmZjcwOGE0YyAxMDA2NDQNCj4g
LS0tIGEvbGliL2NvbXByZXNzZGV2L3J0ZV9jb21wLmgNCj4gKysrIGIvbGliL2NvbXByZXNzZGV2
L3J0ZV9jb21wLmgNCj4gQEAgLTEwMSw2ICsxMDEsMTAgQEAgZW51bSBydGVfY29tcF9vcF9zdGF0
dXMgew0KPiAgCSAqIGlzIG5vdCBhbiBlcnJvciBjYXNlLiBPdXRwdXQgZGF0YSB1cCB0byBvcC5w
cm9kdWNlZCBjYW4gYmUgdXNlZCBhbmQNCj4gIAkgKiBuZXh0IG9wIGluIHRoZSBzdHJlYW0gc2hv
dWxkIGNvbnRpbnVlIG9uIGZyb20gb3AuY29uc3VtZWQrMS4NCj4gIAkgKi8NCj4gKwlSVEVfQ09N
UF9PUF9TVEFUVVNfQ0hFQ0tTVU1fVkFMSURBVElPTl9GQUlMRUQsDQo+ICsJLyoqPCBDaGVja3N1
bSB2YWxpZGF0aW9uIGZhaWxlZC4gRWl0aGVyIGNhbGN1bGF0ZWQgZG9lcyBjaGVja3N1bSBub3QN
Cj4gbWF0Y2gNCj4gKwkgKiB0aGUgb25lIHByb3ZpZGVkIG9yIHRoZXJlIHdhcyBhbiBlcnJvciBj
YWxjdWxhdGluZyB0aGUgY2hlY2tzdW0NCj4gKwkgKi8NCj4gIH07DQo+IA0KPiAgLyoqIENvbXBy
ZXNzaW9uIEFsZ29yaXRobXMgKi8NCj4gQEAgLTE2Niw2ICsxNzAsMTAgQEAgZW51bSBydGVfY29t
cF9jaGVja3N1bV90eXBlIHsNCj4gIAkvKio8IEdlbmVyYXRlcyBhIHh4SGFzaC0zMiBjaGVja3N1
bSwgYXMgdXNlZCBieSBMWjQuDQo+ICAJICogaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQu
Y29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fZ2l0aHViLmNvbV9DeWFuNDk3M194eEhhc2hfYmxv
Yl9kZXZfZG9jX3h4aGFzaC0NCj4gNUZzcGVjLm1kJmQ9RHdJREFnJmM9bktqV2VjMmI2UjBtT3lQ
YXo3eHRmUSZyPURuTDdTaTJ3bF9QUndwWjlUVw0KPiBleTNldTY4Z0J6bjdEa1B3dXFoZDZXTnlv
Jm09SlVCcVJoTy1YU1EtDQo+IG16X2xYRE00VjNZUnJsWGRBTks5cHljaVQ1a2UycDZpRkRxM29E
Nzl6REdXQVd4QkJLZUQmcz1DXzVnNXBaVw0KPiB2TC1mbE02N1Jyd1MxRkNiOTV3bHFaY0hnYXE3
WkpnVmh4WSZlPQ0KPiAgCSAqLw0KPiArCVJURV9DT01QX0NIRUNLU1VNXzNHUFBfUERDUF9VREMs
DQo+ICsJLyoqPCBHZW5lcmF0ZXMgY2hlY2tzdW0gYXMgZGVmaW5lZCB1bmRlciBVcGxpbmsgRGF0
YSBDb21wcmVzc2lvbg0KPiArCSAqIGNoZWNrc3VtIGFzIGRlZmluZWQgaW4gdGhlIDNHUFAgUERD
UCBzcGVjaWZpY2F0aW9uDQo+ICsJICovDQo+ICB9Ow0KPiANCj4gIC8qKiBDb21wcmVzc2lvbiBI
dWZmbWFuIFR5cGUgLSB1c2VkIGJ5IERFRkxBVEUgYWxnb3JpdGhtICovDQo+IEBAIC0yMDEsNiAr
MjA5LDExIEBAIGVudW0gcnRlX2NvbXBfZmx1c2hfZmxhZyB7DQo+ICAJICovDQo+ICB9Ow0KPiAN
Cj4gKyNkZWZpbmUJREVGTEFURV9NQVhfV0lORE9XX1NJWkUJKDFVTEwgPDwgMTUpDQo+ICsvKiog
TWF4IHdpbmRvdyBzaXplIHN1cHBvcnRlZCBieSBkZWZsYXRlLiBVc2VkIHdoZW4gc2V0dGluZyBv
ciBnZXR0aW5nIHByZQ0KPiArICogZGVmaW5lZCBkaWN0aW9uYXJpZXMNCj4gKyAqLw0KDQpJIHNl
ZSB0aGF0IHRoZSBuYW1lc3BhY2Ugb2YgdGhpcyBtYWNybyBpcyBub3QgY29ycmVjdGVkLg0KQnV0
IGRvIHdlIG5lZWQgdGhpcz8gSXNuJ3QgdGhpcyBzcGVjaWZpYyB0byBQTUQgb3IgaXMgaXQgZGVm
aW5lZCBpbiBEZWZsYXRlIHNwZWNpZmljYXRpb24/DQpJZiBpdCBpcyBub3QgZGVmaW5lZCBpbiBz
cGVjaWZpY2F0aW9uLCBzaG91bGRuJ3QgaXQgYmUgY29taW5nIGFzIGNhcGFiaWxpdHkgcGFyYW1l
dGVyPw0KDQo+ICsNCj4gIC8qKiBDb21wcmVzc2lvbiB0cmFuc2Zvcm0gdHlwZXMgKi8NCj4gIGVu
dW0gcnRlX2NvbXBfeGZvcm1fdHlwZSB7DQo+ICAJUlRFX0NPTVBfQ09NUFJFU1MsDQo+IEBAIC0y
MjgsNiArMjQxLDE4IEBAIGVudW0gcnRlX2NvbXBfb3BfdHlwZSB7DQo+ICBzdHJ1Y3QgcnRlX2Nv
bXBfZGVmbGF0ZV9wYXJhbXMgew0KPiAgCWVudW0gcnRlX2NvbXBfaHVmZm1hbiBodWZmbWFuOw0K
PiAgCS8qKjwgQ29tcHJlc3Npb24gaHVmZm1hbiBlbmNvZGluZyB0eXBlICovDQo+ICsJdWludDhf
dCAqZGljdGlvbmFyeTsNCj4gKwkvKio8IFBvaW50ZXIgdG8gbWVtb3J5IGNvbnRhaW5pbmcgZGlj
dGlvbmFyeSB0byBiZSB1c2VkIGZvciBkZWZsYXRlDQo+IG9wZXJhdGlvbnMgKi8NCj4gKwl1aW50
MTZfdCBkaWN0aW9uYXJ5X2xlbjsNCj4gKwkvKio8IExlbmd0aCBvZiBkaWN0aW9uYXJ5IHRvIGJl
IHVzZWQgKi8NCj4gK307DQo+ICsNCj4gKy8qKiBQYXJhbWV0ZXJzIHNwZWNpZmljIHRvIHRoZSBp
bmZsYXRlIGFsZ29yaXRobSAqLw0KPiArc3RydWN0IHJ0ZV9jb21wX2luZmxhdGVfcGFyYW1zIHsN
Cj4gKwl1aW50OF90ICpkaWN0aW9uYXJ5Ow0KPiArCS8qKjwgUG9pbnRlciB0byBtZW1vcnkgY29u
dGFpbmluZyBkaWN0aW9uYXJ5IHRvIGJlIHVzZWQgZm9yIGluZmxhdGUNCj4gb3BlcmF0aW9ucyAq
Lw0KPiArCXVpbnQxNl90IGRpY3Rpb25hcnlfbGVuOw0KPiArCS8qKjwgTGVuZ3RoIG9mIGRpY3Rp
b25hcnkgdG8gYmUgdXNlZCAqLw0KPiAgfTsNCj4gDQo+ICAvKioNCj4gQEAgLTMyMSw2ICszNDYs
OCBAQCBzdHJ1Y3QgcnRlX2NvbXBfZGVjb21wcmVzc194Zm9ybSB7DQo+ICAJICogc2V0dXAgb2Yg
c3RyZWFtIG9yIHByaXZhdGVfeGZvcm0gc2hvdWxkIGZhaWwuDQo+ICAJICovDQo+ICAJdW5pb24g
ew0KPiArCQlzdHJ1Y3QgcnRlX2NvbXBfaW5mbGF0ZV9wYXJhbXMgaW5mbGF0ZTsNCj4gKwkJLyoq
PCBQYXJhbWV0ZXJzIHNwZWNpZmljIHRvIHRoZSBkZWZsYXRlIGFsZ29yaXRobSAqLw0KPiAgCQlz
dHJ1Y3QgcnRlX2NvbXBfbHo0X3BhcmFtcyBsejQ7DQo+ICAJCS8qKjwgUGFyYW1ldGVycyBzcGVj
aWZpYyB0byB0aGUgTFo0IGFsZ29yaXRobSAqLw0KPiAgCX07IC8qKjwgQWxnb3JpdGhtIHNwZWNp
ZmljIHBhcmFtZXRlcnMgKi8NCj4gLS0NCj4gMi4zMS4xDQoNCg==
