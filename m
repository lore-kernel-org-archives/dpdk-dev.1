Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B6C0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 13:38:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54D9842670;
	Mon, 10 Feb 2025 14:38:48 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C36F940268
 for <dev@dpdk.org>; Mon, 10 Feb 2025 14:38:46 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519NhZ9k013756;
 Mon, 10 Feb 2025 05:38:45 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44pw2r1ve2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Feb 2025 05:38:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMeS2vuHPe5BZ1z5ltddaYIqUWQoo87Fgb/NtesOYcMpggiXBvk+x/MvnD4kJkn/d/yIqA6w8EG9/HTENypqoHjYSnr3AhR7pZIqAj6NB/HJuFD6wflsL7BAcrnRnf4pEGgps/YmIARyh7yQTTWT/8oPfvu5D1xKfXCJPEnLGr5TQAikLeHzixn0Wjs5k1WqunP262hZaxr50/Aam9JfccSXo6uCdF3C/wEpQ4ADwa1CUmyBr1ACYmn1idg/MblEyJuvSlqN67124FPAjR25E4+uJ0E4RMicCVJZixU8N+NvAECyzhU/PuJfpM4xG+1s+LNgYm2pMtgrp9Nqb2NuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9ZR3FGchJQjn03VmQj/cL45CA046iybl12aYCjlu24=;
 b=MLzJA0ly4Tlgnbbn3NkB2nRIpNrBAP0I7cQtbIVH7m01hrYjFg3oOSg+fywKgKSNrVgZXYqfVQgNr512Z2rPBUz3hz7DwyW6rorEX/CvEj3bgDtai/xbxxLC9pYqtikQ79hG0clLpqP+j3A22SDRzKmyhfnGDB023xhNNIZKEV9VV7I8FnhMcmqM9oHZ/N+L4guRCqZLiPMvOONDDDK41YEjHV24WEiyE5e7B34blD5+TB6yMfiSHzu1rukZ22eKNOQJmEudtAR2Glp6rBPBiq4y/uV5wF4JTalgtSoYP1wC114dD+MvMeiK6II8klDCUGWeAi8NrXHhfAbF/3t5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9ZR3FGchJQjn03VmQj/cL45CA046iybl12aYCjlu24=;
 b=oX0JnkKzm9f2VOvSm3LYznqmDhx+CenD0LkZeUR0oBewOm68X88+U2gfdVOX4Mux81gs/iDXMGiLeLwKagJqd+GBjjrsLo8iBOq8qX6CRY3C7pJAvv4sMS7bZHPbV7SOtG6db141/bS/C8h/bjePv7eq7K8rmdToO28rn2jbpIY=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by SJ2PR18MB5737.namprd18.prod.outlook.com (2603:10b6:a03:570::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 13:38:43 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 13:38:42 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Sunil Kumar Kori <skori@marvell.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Thomas Monjalon <thomas@monjalon.net>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: RE: [EXTERNAL] [PATCH v2 1/3] trace: support expression for blob
 length
Thread-Topic: [EXTERNAL] [PATCH v2 1/3] trace: support expression for blob
 length
Thread-Index: AQHbcyeGsC3F/pVl1UyPMi1n7qtrJbNAm8ug
Date: Mon, 10 Feb 2025 13:38:42 +0000
Message-ID: <BY3PR18MB4785B4FBE71071AF25DC70A1C8F22@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250124161408.310581-1-david.marchand@redhat.com>
 <20250130145849.82003-1-david.marchand@redhat.com>
In-Reply-To: <20250130145849.82003-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|SJ2PR18MB5737:EE_
x-ms-office365-filtering-correlation-id: 86fc94eb-72ca-4020-1a22-08dd49d83c44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkMvcmVzMTNyMWxZb012VnptRkZQc0JQZWkyejh1S2lxMVlranVzc1lhL0l3?=
 =?utf-8?B?enFJMEpOU2prYUFKaU50L2pnbTRhZFhPdHdZdDYrTEVXRUkxZW4xc2tSU3B3?=
 =?utf-8?B?YlJ4YzVVYXlWWEF5Z1FkVTZtcVVzNUFNR0EvMkRnazNkanZKeDV0MjNhRk16?=
 =?utf-8?B?YzhqM05yV0RHcDRSREZ3eGIyK0hFYms2WUlRVmlqNnQ2N2cyZlErQnFsK1ls?=
 =?utf-8?B?anZCQ25XZ3VTREIwdVFJd0ZIMXNoZGx5UDRwQWJCSTBmWFd2bUlKRWpPd3hW?=
 =?utf-8?B?L2JXUk9IVVIwQ1NWTFd5L1dpb01TQlkwYm5BM2V0MFl5MmV1STZFYjlmS3p5?=
 =?utf-8?B?Z2FuQ2xDeG5ua0hOc0ZyTWtmaGpGcklMR3NkYlJkYnBGNWE4c252QkhyV3V4?=
 =?utf-8?B?aWdDd2k4TGtpMHpNSTZWRGx4RnFJaE9zRUpHYmlJcTR1YmZzdGFYV0o5WDl5?=
 =?utf-8?B?dzE3Y3dVOXNXRjdvK2ZXYTNHMjdmQWlreTdzL0VCUVFwTXJQRHlTL1p2NnI0?=
 =?utf-8?B?WlJ2SEVIVmJtYzdJa05qSlZPMGpCZjdHcWNqS0ljVWQ2d25rMjM5aVRJL2NO?=
 =?utf-8?B?YlB2UHk5WU4xQUxkODk5L1BCNWxTMGs0UWRQNUtnSVZscS9jMnRoZXorSUFB?=
 =?utf-8?B?VWlJTC9ZWVVMKzB5Ty9aV1RlN3J6Q3IxUXYzR0I1cFFKSjVnbFhXYms0VjFY?=
 =?utf-8?B?TEdmRC9zRzJaS0Z1SnU3ZFVhbWRsYnhvdUo3MTMyYTc4aldyaFhLRHJFT21w?=
 =?utf-8?B?ZU55L0ZOWUZSS2hpcDhER3dSbUd5c3QyemZpczNsUW05WWo1aVpRUnBHcy85?=
 =?utf-8?B?TVZ4K25HMXBwaWxOSFpaNjZFUzRidkVmVjRER3lVbEd1UEFINnc4enpIQW5j?=
 =?utf-8?B?Qm1xdWU2NE9QQzIwZEttZ29pQW9oVlE2ODQranJhc01kVk9jRHlrR1NCMGhz?=
 =?utf-8?B?R01QSXkyRkNwcEtTZHN2TWFhUlpRMEVRS0JMd3JOOWdjR0E5YXh2K0JKRFdY?=
 =?utf-8?B?NkZER2tUd1V0Qmx3Nm5mcWlKZlFuUTdoTlJXSDlZUEhRMTR3L0lodVpZWm5M?=
 =?utf-8?B?UmFyMjNqaDhtWkUwUWJRTWhpaVBjL2lacmZxeDRZUWJTTnpmaHJxZWIrQzk1?=
 =?utf-8?B?Tk5leDF0UTU0U2xtOTJIbUJCbjA0VHhRaE0raGRtTWxrUmJaV3p4VE81aEQv?=
 =?utf-8?B?dG8yWlgwRlNEU3BPdC90NjdiYlhzTm9XOFBVd3B5UXdOKzBkTVZ3cGtlaExG?=
 =?utf-8?B?NGVTVnJYTHVHallyMHdkVkVlZGhjT1JmODRHS2hrNVV3Tlc1R29IRXprSlpm?=
 =?utf-8?B?US8vaGFBS21GQzF3YXBjT3pGUFVOVEpTTVMwYWVxSTBzV3Y1b3BJTUtpY3BW?=
 =?utf-8?B?Mk1aTzdPYUpQQ2lMbis5d1c2MVlHRHplR3U0Y0Q2YmtHMEtzbGVZSVVKeDZh?=
 =?utf-8?B?cm1zSHppSmEvcktmc0R6elpnem9SM3lVaTE4ZHR5V05HU0dSVEFuaDliaXl0?=
 =?utf-8?B?Ynp4V05FclVpUGsydnp6SlkzdjVHb2hobHFxSVlHUENHU0J5aVVRMU9Eamlv?=
 =?utf-8?B?RU8xek1iZUg0VmlBR2I4NVhhN2lBcEZRVVpHM3ZqUHg1Nk04aFhtMWxGbHd4?=
 =?utf-8?B?NnNwWGkycmQwSENoZ0RtaEl2c1B3a2M3QlFBMTNBTlBmV1dyUTBvbW5rZTZq?=
 =?utf-8?B?Q2xGMWFlNlpMS0RoTlFsNWZYVU80OWYyYVluQ21FSFBBMHRLNTR3N2ZndkVn?=
 =?utf-8?B?Vzk5cUtVS3JONG1PNzU1OHZyei9NR1o5ellZRitqbU0wVjV1ZXczYlIzME90?=
 =?utf-8?B?cjNJN01mVUpUeEhyejFJek1VMmx4K1lVU2swZ0xQa0NiUXlpMkZCK1dGaDEw?=
 =?utf-8?B?MlJmSXN2Q3ovbGwxNmtWM2kxSHBaZC80ZENqcXlENDBLbUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME9EbmhaQjBJM1NIRGxndEovVy9pL1U5cmVvYVA1YThXZjF4bE4zT2FxSXVl?=
 =?utf-8?B?YkxaR1EvczJMaFl0dWg1MGJPaFBnVFpLVEhWa0duYXRTckF6VC9MUmdzUVM1?=
 =?utf-8?B?VHZXMjRKcEpZTXVUcElaMzJDdGxwMGoxd2tOODJ2T2dQOHI1eVdZVThWdk80?=
 =?utf-8?B?VXEwWlFtUWJqWDZJekJ2WFo4bDYxMFU3Y0hrZEx3UVF5L1dqZWFieURiV3h5?=
 =?utf-8?B?bHl5d1BkdWsxbndwWGdSMHpUOEhwaWZUWEpET256NEJwYlloNDFYLzVRV05i?=
 =?utf-8?B?QnRxR2J3U25KMytYNm9POW90c1hmd1NMc0t6K3hLNVVldGprckdjajNVTU1U?=
 =?utf-8?B?N044MlV3N0dkR3dhdUxHbFplektZQ29zS2NXL0FmamJHdVlmZ3BCTitOSG5B?=
 =?utf-8?B?OVlYWjM3RnE5QlNnY3FrYmdNQ3g2ekNvZ0ZqcWsxRTIzd0w0aXU0TitZYXpC?=
 =?utf-8?B?MXVwL29vSmhtaUR6OUhKN1VnV1M2ZkEvalZEamlqdlNpb0dQYnFtZmdIcERp?=
 =?utf-8?B?OXJNTjVLdzVzUkpjOVhQWDNURmZHQ21LeEtaNlFqWnZVRUFHL0JtajdxU0VR?=
 =?utf-8?B?OHJjUHJXMzhJVnFHV2RqS0NmUytHQUxwZ0tDN0ZsSE1QTllpeU5FOGVKaytI?=
 =?utf-8?B?aERtOHJRS1NzYmoxSVZRK2MzQjRockRUQVh0UWxLRmF1YUNYRnYxbExDOEZQ?=
 =?utf-8?B?ZDkralV6dzJ5UEt2NkJnNk5NNUJZcEFWRGZ4ZUQ5NU1tMlQ2akNnVFZOTEZ6?=
 =?utf-8?B?WWtseUphWHJwU3dNNkEzWitGaXFtNWVPQ3AranFhSlR5aVA4Z1NtSm52UHVL?=
 =?utf-8?B?SHZ1NWJ3cmZVeDh2VnBLUVF4a3c3SURkZlZjL1pxN3JnOWorckZJei83S2dr?=
 =?utf-8?B?eWhpR05hSTdvUVB3NVRpeUxSNys0U0E3eW1waCtmNlBlb1VWT2JITlRuRzZG?=
 =?utf-8?B?NU1VV3lhZWpCR0g0VytSa0dFTTFkbCtBcHJaRU54TmppVzFwd0QrMUpOd01w?=
 =?utf-8?B?UXIrei9vNlFVZ0xWWEhXaWpDODhoblVOLzhUTG1ickwyanE2ZWlLV1ZZcXZE?=
 =?utf-8?B?Z3Q2VFFLZHZMU2srSjZWOG9HL3BJOWpZb0ZacFE5N1BDWkZjR3V6cUUzTlNs?=
 =?utf-8?B?YWtVaE8zRmZ0NW1MTEFCOHNJNmZhbXI1N2ZDVm9ZVGJETmJ0dTdmRlNJblBj?=
 =?utf-8?B?elJtT0RiMVhBaVlHSVd2cSsyYkljaUlGcStNRE9JemdxQ2VFNFcyWk14QnFE?=
 =?utf-8?B?WXM2QWdwMHNIZUJwVUVnaytjWWlXWVFVTzN2dGtoZ25rL0ttdUl3RlFRZ0ww?=
 =?utf-8?B?TUlQdW44YzVnNUdVS1hDRU5UUzljSzM3TlRJbXo2dnlYTktYbGN4aW1DRGpP?=
 =?utf-8?B?eTB6cjZrV1hMMElFY3NEckZpdzJHUDV0eGtWNDBITFhCK3JIUURtcTNiWUVF?=
 =?utf-8?B?TEVrM3h5bmhCbzVNQnJBMzBENmtqV3A3R2ZxMXpXSVVKVytmWlhDcTN6Rmw5?=
 =?utf-8?B?TlJBQmh5d21tNWJPQlg3M0l0SUpXYkR0b1NJL0hJbnNzekJRK2llWnRjbW91?=
 =?utf-8?B?S01CZmhzLzJiSytNcEw1d3FiWWs0cHFtV0xaZGdpbTdHK3pDT2R2MkpLWWtn?=
 =?utf-8?B?cjNEeUlIekwvcHZHaERlenJVRVV5VThGSVRQbnNuZ1lmTmN4ZGUvWE5rN1l4?=
 =?utf-8?B?WTZ4R3pZQXpjR1NaUVFBZC9SUzZQVmZuZU4zKzN3V0hKSDFhdHFEYmFVM29N?=
 =?utf-8?B?WDMwcFdlYzgwbHFYUnJ1eStnMGtEYW4xcmlMa3JGNlZrTW00ZFQ5UGt0M3dl?=
 =?utf-8?B?UkFoSkJ0REpGRG8xM1NKZnlPRlNsVzIyRjNwT092a2VHZzhCWk5DVDZuNm1u?=
 =?utf-8?B?V2dpY0cwaU56ZkVtcVJLMG5lcGJHL3ZIMHl4ME8wRytHZ2laVWg0cHZFZU93?=
 =?utf-8?B?RHNmbFB1MFZxMFVlV2lmeFo0Y25wQVFtdWpxZkxXK3E1WjNwdDE4YmlpN2hE?=
 =?utf-8?B?ZDE0eS90Yy9zNDdvYjFpUzRXMkx6TUZSbTV4Vm9HVWJROHUxQ1VUSDJodnhS?=
 =?utf-8?B?a1ZNR3BRYWo1REFsODh1c0U2bjAxQ2hsOVU4WnVUZXZsOW9SU0ZqSjE1MmNa?=
 =?utf-8?Q?CNwiHCRaGwHfnWTeYHpK1BB07?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fc94eb-72ca-4020-1a22-08dd49d83c44
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 13:38:42.9059 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37KZpSM4+kmJ9znzoKjR8U8/D7EYyR86tBuAojb9EFKHBYqNrkTzeMwNOMehzSzetGya4pQeL5Be8zZRV6+V+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5737
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 7YqujPCZxSnWGINIQul0XiGS-gpf5Rh2
X-Proofpoint-ORIG-GUID: 7YqujPCZxSnWGINIQul0XiGS-gpf5Rh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
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



> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Thursday, January 30, 2025 8:29 PM
> To: dev@dpdk.org
> Cc: Jerin Jacob <jerinj@marvell.com>; Sunil Kumar Kori <skori@marvell.com=
>;
> Tyler Retzlaff <roretzla@linux.microsoft.com>; Thomas Monjalon
> <thomas@monjalon.net>; Ferruh Yigit <ferruh.yigit@amd.com>; Andrew
> Rybchenko <andrew.rybchenko@oktetlabs.ru>
> Subject: [EXTERNAL] [PATCH v2 1/3] trace: support expression for blob len=
gth
>=20
> Support any expression as a blob length by using an intermediate variable=
 in
> the trace point emitter itself. This also avoids any side effect on the p=
assed
> variable. Signed-off-by: David Marchand <david.=E2=80=8Amarchand@=E2=80=
=8Aredhat.=E2=80=8Acom> ---
> Changes=20
> Support any expression as a blob length by using an intermediate variable=
 in
> the trace point emitter itself.
>=20
> This also avoids any side effect on the passed variable.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>
