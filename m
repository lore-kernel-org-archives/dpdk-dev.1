Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA3CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 06:21:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 871C34013F;
	Mon, 18 Aug 2025 08:21:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1933E4003C
 for <dev@dpdk.org>; Mon, 18 Aug 2025 08:21:38 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I4tBnL019045;
 Sun, 17 Aug 2025 23:21:37 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48kwjb0426-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 17 Aug 2025 23:21:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dco2of5yxsNLSoMYXG4YgL2bLwnbZ85w7O/6d1t+eAeoBcN9xl7hZ/wQjL1PhgXQB7GECwhOQtiCiBaCvdnjHJW+/FZxMoPsvzQpf+ZttRQyJEk5Ss3V+XSEr5Tnv7wmEHklutjw/KC2l6NyMbX1R1trFNFqIY502G2G6TRrQtO2Rpfsm1tALbJpOwkSrDZcq5ssFdbDLPsuC4m50saLhSlI2D061PcZFwY2X6H98AQwQObRhCo2B7k/pDXGTzTJG2wZ+33dAuKwvcwwtGRnnJbwl+wt+SuiYPT2i05soyMvYsjyi/c/lhsFiw8r9NTvZaACdxIZ9Ogdo4A3c3g8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH+1sEKyHh87DzGxF5kxQW21hfr6YW45ANe0BbDwOok=;
 b=UOu6QoqJvZj79+1093IfANWFKHOQIiuap9+q2PPQ5gxXBffBh0a4fuqfsTBXYXZoD7nNaJ7LbYm4O4JWiKdquKf/i/s6BohJ1KOXAAY5DNV5jMOYtY444ZArtpXb3Ewu1gu3gO018om3G6antgxXdDeQfDjbXbPC7HRWK722np/kDQ+trEbH+LbN8mpWwGr9utKRzllVlsIn9o1a6nL7yzJj3VTxZ0+eXVrMAI8GQZrIyRBsA3EDIM5FLz+9OYlC1BCUbCV7z8ceKtBooWdZkU6YE+8ZbKP6OKXJiUlFraoEZRwO3HvCkevQ26lH3/0MwEope5WA1943WT/5YA45Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH+1sEKyHh87DzGxF5kxQW21hfr6YW45ANe0BbDwOok=;
 b=uyDsl8pyGKiCuUuZtZS21zPuxBqrAD5qkONQfSPqgq2slTY1SqARpKjIfmH6hX4ib5BmNsrdlx6DhVZ8kgBou151Km8fRzFzUU1QSuN824I7ZtXlodEo2GGd0XAfulZrtb77st4PlvtKEeOtTAt0kqAZqZx1RjSfA2hH8hKzDS4=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by DM6PR18MB3651.namprd18.prod.outlook.com (2603:10b6:5:2a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:21:34 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%3]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:21:34 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org" <dev@dpdk.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcDPMrF3HoVpw6hkmGZb8+hkiii7Rh2u4AgAB4mQCABaMJgA==
Date: Mon, 18 Aug 2025 06:21:34 +0000
Message-ID: <CO6PR18MB3860FCC393EF51C8664B364BB431A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250813084508.1446318-1-skori@marvell.com>
 <20250814081215.1904078-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FE35@smartserver.smartshare.dk>
 <20250814091556.6db159d0@hermes.local>
In-Reply-To: <20250814091556.6db159d0@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|DM6PR18MB3651:EE_
x-ms-office365-filtering-correlation-id: 38f010d3-75ea-473f-5385-08ddde1f7b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SXFLejFXU0dPUjJCRm1xUHpEK3ExdnpKK2JjV3gyTkZPUGVvVXYyMmZyQ21k?=
 =?utf-8?B?elYvcFhldHYydUNlK0pJNHBFNHNHTjhtT3BBR25kU0l2dHZvc2xqeXM5NjVq?=
 =?utf-8?B?bmxGT3Fpc3FMcFpKM0V6Ri9JNEQxaERVc0dqbE1PaC81LzNMWGJkdUhZRjdU?=
 =?utf-8?B?ejlGRGdFelR1cHJkdC90aGZEY2lrM2JhNlJuYS9sUVFNT3RuMlBoRm9IeXAv?=
 =?utf-8?B?dmY2L0V3V2JsTWk1ajJHc0JORUcrQjZJdDVvVjdjOGtWa2RmYmN3UitPMlRD?=
 =?utf-8?B?Mkt4VU5EZUZTWEQvK1dBTmtjZ29GNWdUeWh3bk5ycGVFTkhBQ3hTakVxeW96?=
 =?utf-8?B?eTRaeVNIZ3ArWlJaKzZ2ZmZOQVpLRlhzaDQ3aG5wWmUzWXE2RFZlcHBFazMz?=
 =?utf-8?B?eGozam9BV2lGZUVqckQwV0pLZVRRRnp0UWJTa1daS2dzeTh3K3U5cGMweHow?=
 =?utf-8?B?VW5qU0FERll4eGFUYWlpNDJmN0tDaFhlR2J5TlR2anozTUF5bXpITHVtU0ZR?=
 =?utf-8?B?S05GUVZqQXYzY2srWkhidmlzWGdHaWxiVmVwZTVYcmxHQ2FBQitjeHhPcmVn?=
 =?utf-8?B?TFQvWU5iVS9SQWQ2engzZ2RkRk0rWmhHakRUZXBBNmZOQ00xN2R1NTJ4cTNm?=
 =?utf-8?B?N0hNUUVWLzBscjlkTHZ3ZHZYdWpicFA0T1dpaExrRnkxaUtFbCtNMTVIMklr?=
 =?utf-8?B?UnpjM0I2MnFsd1V0QytwUXBnNG90WWsrZ2hWUVNHajB0R1ovenRhZDNZMmUw?=
 =?utf-8?B?bHR3MytXQlZlMzVuWFBZeFZiRUwrMU1TWFJHaVkySUdscXZNakgrbS9kMkVF?=
 =?utf-8?B?dllIK2g1MllTSTBZZzExVy9XbXJiZCtKYjVYcFh1SjlhS0ExMW9IbjJuVjJQ?=
 =?utf-8?B?RmYvWUJzL0U2SmxqV09QUWxpNW4vdWpYSVZaUWpIV3plWm1KcENwWkdlQnFB?=
 =?utf-8?B?STlNVHZaZHFvK0N1UWFBRjFLOWxTMnBNUnozZXBCK2NFR3VMVnZLKzY5YW1n?=
 =?utf-8?B?MDc0SjVaSVBlTm5qSWw2K0FLWDdydURWTkk1MnhHaE9sV2c0eGpnMnFpbDVs?=
 =?utf-8?B?Q0JQcWZscS8yNjhqV1BFNlI1OUlsemo4VXhCcE4xZWFYanVFWnYwL2o3OTVR?=
 =?utf-8?B?Q2g1dkFuMXJ2d3hBZVdLeUp1Q3liREN2K1J3WXpHMGNNVjFOUlhKZU11MlNR?=
 =?utf-8?B?ck9ydUYya3JqNkx2bUlCdEsxRmlxN3EzbGhUNDlLY3FGKzFTZDhIQUFUcXNZ?=
 =?utf-8?B?VVVPVDNlRzlSMVVkZkgvR2VzWFZBdDFRVE1Rc1J2UUFtbTJLdlVhY3ZOZXpC?=
 =?utf-8?B?eVQweWhrVEw0Z2ZDQ2pQV2N2SktsRVZtSjZYYjdOamsrRXpibUZkTTg4M2ln?=
 =?utf-8?B?SC92RHNjRUxLcllyNTZVdGo5NUtMUlFubFh5YlNGU0VTNWVZSU5qMzVDbHAy?=
 =?utf-8?B?d1dNM0VOOFE1dlBoOUFjRG1uOFZmVjhLaGZqblFQekQrZ1ROblFLWUpMK1By?=
 =?utf-8?B?OXRwTnozQjZyZitVTTAxVFJIejQ2MUNsNC9ia3pkU2pGa0dJanduOXlUdkRl?=
 =?utf-8?B?UlBCUk9wdGVQSW5DYlBraWJTUCtvQmFKMzRIY3pFY015bDRWNlh1T1ovQjVH?=
 =?utf-8?B?eEs5RWxoMVg5WVpBZDBWZnJ1MVdWbFpMQWJZVU1vTGpDQUFSZGgza0tjR3NM?=
 =?utf-8?B?Nmpmc2VyMTlLYXh5ZmxybVVUTVJQVFhpS1U5MDhBWjdkMUxTWUFVdGo4V2lR?=
 =?utf-8?B?ZUUxQkdoSkxvUzI0VXBpMWg3ZDdjMG9IM0NyVW1qRkNuc2lYVCt1UkFxbHE3?=
 =?utf-8?B?a1FBQlZhMGRYUlJ3eWtqamJUMUNjYUVSeGhKdHNBMHY0RVdMY1J2NGtFNTFj?=
 =?utf-8?B?enByM3hiWnZEVGovUnovUzhualE5NGFaeWRtczdneE1Eb0lnWGVUemNWR1hY?=
 =?utf-8?B?TkVkZFRLRHZJWWFBTktFM2JzTzIvSHMzTTBwWER5YVdob09uQjZyOExuaS8v?=
 =?utf-8?Q?L6WEf5YIzZQzo4q20GLzbbZyFYnvDM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1oxNzVYQ1Fsb3FPbUE2eit4eUZtb2xib3A3N2Q1L0N4L1ZmcWVFaEYxeERZ?=
 =?utf-8?B?dmFMSm9IRkhHYVhzRSt1cUtXK05NRWNHTVZDWXVGZVpPbDdyZHJXTTZPbEJJ?=
 =?utf-8?B?L1JodFhiT3ZQbHhZUUlrT2hwSHhLYWxYU0FNalphMHhvMEYvd29BM2Z6am9Z?=
 =?utf-8?B?b0lQVzlwREpkTGJ4b2d3OGF5ZGk4VXBnRTlsd3owRjFualU5eGxobnZnTFlH?=
 =?utf-8?B?QjRZc0pEV0lxVTNtUnlSaVl6SGNzcmtYMlNFNWxZQllERUwxcFgxbmZubXRJ?=
 =?utf-8?B?YWliM3F5SEI3bGpNdkNHZmtWWHhucUZpM2VjbFhBRmE2OWRCZW1na05vZ2U4?=
 =?utf-8?B?NnNoN1RxcnZOWXB2dzA5WHpjRGhTQzdGdUVVZUpKempUSGJEOXV4RzJnbWVq?=
 =?utf-8?B?UUxDdVdCanA4ejlWaHcwelFPNWVSMzBIZEh3U1h0TXFaYXRRTUpPbi8ySFF6?=
 =?utf-8?B?VVNqYkdyaEdSWGpsemx3N1ZUeW81WFhXZmY4Ykt5RmZmcHZsNXp6OTc2YXYx?=
 =?utf-8?B?c24rVGlZeStwVHZzdTF2d2U4R2toMDU4UlpkMWtubUJaTUdnaXBlaWhSL3RH?=
 =?utf-8?B?M3hEdUcrSWtUUGxjcHFiR1BsdFdPeVpzY1krcFFhaXorZ3dKS3hxUFNUWUI4?=
 =?utf-8?B?a2cwcW85cU9YWWNSQlhId1EvZ3V6NXlmWUxVNy9PN1JkZldJTzA2SHVJNHBX?=
 =?utf-8?B?SW9NSlZuRGFtVC9pMmk3MEhJVmtOdSsvQ3FYU0ZWM0x6NVlKMzNyWDllejA0?=
 =?utf-8?B?blM1SXV0WXZaOGZvTjRjTDBVbXVJLzBSbEc0VnNGSXFoQTZ1S3ovTVQzU3dm?=
 =?utf-8?B?TDVpdUI1a3BYaTYwdjh3cXFjUWEwbzhoRElrTzBqWVQzVFhpK1Q5SEZGem1U?=
 =?utf-8?B?WkdsSWRoazJQMzdWNkh3c2t3T1JqTFlxdkowM0dzeGtuV1hza2dGS1ViOXJr?=
 =?utf-8?B?Nm9QaWd2VnE0NnpjdlhlQnVTVTJ1Q2w0RVJscXdXM09nQ29YRDNlZHI0QTJS?=
 =?utf-8?B?S3ltbEpLRmZQZ09WYXZZSW5vN1BLeXh2cmpkeXBMclJnbEhSNEM2cG5sU29Q?=
 =?utf-8?B?L0E0cFMwd0poN3IzdHdZa3lmNVNnVW5rQlRsT3hmOEtOTjVnblY5SEpiTkN1?=
 =?utf-8?B?VDVjS29kT1Zjbm8rV1NKSDBhWWNCR2EvMFh6VDhXOXZRVlIyamdDT3J1OGRh?=
 =?utf-8?B?MFNGRmkyTjlMbTY3aTdVaUtKUHJSS0VnNWk5R0ZJV1YvTWdKODUzSXkyb1VD?=
 =?utf-8?B?dzQ0ZmdlYXMvQnZsTnZnQnJlMWt4bEV2aThuTnFOQlB1N2lERWVrM0RGL2hE?=
 =?utf-8?B?SWhXM29jZjlJWkJXcDNBY2twVkJGUXkrSUpSWVZzOHNHMTRNMmdJQ0N6QnI0?=
 =?utf-8?B?OHBYRjBFM0lKSXM2TXh4ODZBckpZc0oxRHA0TnVKN2tCbSs3blBURWJJeTJV?=
 =?utf-8?B?dTZCMDMwQTdIc2N6L0VNYzE0dldLTC9tam9uSkMxVDcrY29oVEtTdUNtTnZn?=
 =?utf-8?B?WndGWGFKSHE2OThVQWZwK1dLZG1OaEFCV3h4b20zZWl2NWZSUmUyRjIweHM5?=
 =?utf-8?B?N0VZUHNnaHV4YlQ5bkRudTNnamkveERTWGxDNUViWVU4RDE5dENDa2Yxa3dN?=
 =?utf-8?B?Qlh1WDVZTnAzZ2IxN3JhQ0kxYmg1a1hVSG42cm9ERklIMjJ5Z2NkTnI4ZE9v?=
 =?utf-8?B?Um00ZGVhQ3I5S0RsS1k1OXg5d3ZvOVB1Vm1qUDVHR0I3bUpZOUptcU1jUCtm?=
 =?utf-8?B?YXpOelAzWU1kc3NQYnRPTjY2YzhLNDg1RFRFNU5QRDJlNndMSzBNZ3pKV2tY?=
 =?utf-8?B?SllyeFp4cXAyeHd6a1BlMUhnVnNuci92a1dqSjNGbW1od1BmalA4UXFaWkJl?=
 =?utf-8?B?MVNFaEVPV1c3MWVJY3VoNjBVYmRlMm0wQTJUQ2w1V1dud1lzY1Zham1LK2lj?=
 =?utf-8?B?YXc3a1EwOGR0eTNzTFNoUysvY3NZWDJhWURRQUNyNnpVaUVraURBTStoWmJI?=
 =?utf-8?B?MExaMkk1YWJBcU5LL1I3aGc1akNPc1oxeGI3eU85OFIzdnRhekZobEliM0tq?=
 =?utf-8?B?dllBNGkxamUvL0lCdTdtK3d5ZE1NTWNvZWdscFoyWFJodG1YRDExekRMdW5Q?=
 =?utf-8?Q?sKwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f010d3-75ea-473f-5385-08ddde1f7b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 06:21:34.6218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6BQAaUDXnV+4cHoRjijTajEDSU2C+WeidZCwATDcwJOqDIHb7Ck75gye1+Q3FRxMIltLtyw9dMntCB5+c0bgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3651
X-Authority-Analysis: v=2.4 cv=SO9CVPvH c=1 sm=1 tr=0 ts=68a2c671 cx=c_pps
 a=Gqw+4yJV85EtGHpvYtJK2w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=n02bokGJAAAA:8 a=M5GUcnROAAAA:8 a=GbiLbAsw58S_lnZTUkQA:9 a=QEXdDO2ut3YA:10
 a=rszdq1ld3peujIA30KyE:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: aGZQdXrs92zXMIJIgSdwZZvv5IqL0l9I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA1OSBTYWx0ZWRfX+74+uGayHl1n
 rsPoVDg0Mtwo++jekzFoUaQc1D2Ax/UG+ikkbsD5lYPMZMmDRlKsgWkSsY4G+7cruFt74d8+5O2
 QDhkqFww/uvHXiZpLQdhyHW6atDmhovMB3d6f8U5VvWzQI3zrQGcxx7Vsax0fLfKxSlFbt3wfpF
 TUu51+afOLprZaqQ1WKny1R4u7fhTbOMoSVjIwD003ipmtJebtS4y92ggKwjNRUul6jUViIcbtF
 /6U/Zs4iq97jVfiHGkJuvmxO88QrgbiWwHuQIYT/WSvx8OcyTGo+Z7DHe9YR0OEserpnD978CuA
 sRCdFqG1RpJ2Fg5x6lD1ep3TqUOXVs2up7E2eDWoqSyHs/G9cg5WMALDWnpAjd1CANA/04bW71I
 PZqZhubZdGE8rBxocGXAbE8TQ7RBS5gzyW1JHAY/PX/bAlsxCmrg/DwvBQLTDhxJOimdzxHY
X-Proofpoint-ORIG-GUID: aGZQdXrs92zXMIJIgSdwZZvv5IqL0l9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_02,2025-08-14_01,2025-03-28_01
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

PiBPbiBUaHUsIDE0IEF1ZyAyMDI1IDExOjA0OjE4ICswMjAwDQo+IE1vcnRlbiBCcsO4cnVwIDxt
YkBzbWFydHNoYXJlc3lzdGVtcy5jb20+IHdyb3RlOg0KPiANCj4gPiA+IEZyb206IHNrb3JpQG1h
cnZlbGwuY29tIFttYWlsdG86c2tvcmlAbWFydmVsbC5jb21dDQo+ID4gPiBTZW50OiBUaHVyc2Rh
eSwgMTQgQXVndXN0IDIwMjUgMTAuMTANCj4gPiA+DQo+ID4gPiBBZGRpbmcgbGluayB0eXBlIHBh
cmFtZXRlciB0byBwcm92aWRlIHRoZSB0eXBlIG9mIHBvcnQgbGlrZSB0d2lzdGVkDQo+ID4gPiBw
YWlyLCBmaWJyZSBldGMuDQo+ID4gPg0KPiA+ID4gQWxzbyBhZGRlZCBhbiBBUEkgdG8gY29udmVy
dCB0aGUgUlRFX0VUSF9MSU5LX1RZUEVfWFhYIHRvIGEgcmVhZGFibGUNCj4gPiA+IHN0cmluZy4N
Cj4gPg0KPiA+IFBsZWFzZSBjb25zaWRlciBpZiAiY29ubmVjdG9yIiBpcyBhIGJldHRlciBuYW1l
IHRoYW4gImxpbmsgdHlwZSIsIGlmIHRoaXMgaXMgcmVsYXRlZA0KPiB0byBwaHlzaWNhbCBpbnRl
cmZhY2VzIG9ubHkuDQo+ID4gRS5nLiBpcyB0aGVyZSBhbiAiTEFDUCIgbGluayB0eXBlIGZvciBs
aW5rIGFnZ3JlZ2F0ZXMgKGJvbmRlZCBsaW5rcyk/DQo+ID4NCj4gPiBBbHNvLCBzaG91bGQgYSAi
dmlydHVhbCIgbGluayB0eXBlIChvciBjb25uZWN0b3IpIGJlIGFkZGVkIGZvcg0KPiBUQVAvVmly
dGlvL1ZNWE5FVDMvcmluZyBhbmQgc2ltaWxhciBub24tcGh5c2ljYWwgaW50ZXJmYWNlcz8NCj4g
Pg0KPiA+IE1vcmUgY29tbWVudHMgaW5saW5lIGJlbG93Lg0KPiANCj4gTXkgcHJlZmVyZW5jZSBp
cyB0aGF0IGEgbmV3IGZlYXR1cmUgbGlrZSB0aGlzIGZvbGxvdyB3aGF0IG90aGVyIGNvbW1hbmRz
IGFuZA0KPiBzdGFuZGFyZHMgZG8uDQo+IFRoZXJlIGlzIExpbnV4IGV0aHRvb2wgYXMgdGhlIG1v
c3QgY29tbW9uIGV4YW1wbGUuDQo+IEFsc28sIHRoZXJlIGlzIHByb2JhYmx5IHNvbWV0aGluZyBJ
RUVFIHN0YW5kYXJkIGJ1dCB0aGF0IGlzIGJlaGluZCBzdHVwaWQNCj4gcGF5d2FsbC4NCj4gDQo+
IEV0aHRvb2wgb24gcmVhbCBOSUMuDQo+ICMgZXRodG9vbCBlbnA4N3MwDQo+IFNldHRpbmdzIGZv
ciBlbnA4N3MwOg0KPiAJU3VwcG9ydGVkIHBvcnRzOiBbIFRQIF0NCj4gCVN1cHBvcnRlZCBsaW5r
IG1vZGVzOiAgIDEwYmFzZVQvSGFsZiAxMGJhc2VUL0Z1bGwNCj4gCSAgICAgICAgICAgICAgICAg
ICAgICAgIDEwMGJhc2VUL0hhbGYgMTAwYmFzZVQvRnVsbA0KPiAJICAgICAgICAgICAgICAgICAg
ICAgICAgMTAwMGJhc2VUL0Z1bGwNCj4gCSAgICAgICAgICAgICAgICAgICAgICAgIDI1MDBiYXNl
VC9GdWxsDQo+IAlTdXBwb3J0ZWQgcGF1c2UgZnJhbWUgdXNlOiBTeW1tZXRyaWMNCj4gCVN1cHBv
cnRzIGF1dG8tbmVnb3RpYXRpb246IFllcw0KPiAJU3VwcG9ydGVkIEZFQyBtb2RlczogTm90IHJl
cG9ydGVkDQo+IAlBZHZlcnRpc2VkIGxpbmsgbW9kZXM6ICAxMGJhc2VUL0hhbGYgMTBiYXNlVC9G
dWxsDQo+IAkgICAgICAgICAgICAgICAgICAgICAgICAxMDBiYXNlVC9IYWxmIDEwMGJhc2VUL0Z1
bGwNCj4gCSAgICAgICAgICAgICAgICAgICAgICAgIDEwMDBiYXNlVC9GdWxsDQo+IAkgICAgICAg
ICAgICAgICAgICAgICAgICAyNTAwYmFzZVQvRnVsbA0KPiAJQWR2ZXJ0aXNlZCBwYXVzZSBmcmFt
ZSB1c2U6IFN5bW1ldHJpYw0KPiAJQWR2ZXJ0aXNlZCBhdXRvLW5lZ290aWF0aW9uOiBZZXMNCj4g
CUFkdmVydGlzZWQgRkVDIG1vZGVzOiBOb3QgcmVwb3J0ZWQNCj4gCVNwZWVkOiAyNTAwTWIvcw0K
PiAJRHVwbGV4OiBGdWxsDQo+IAlBdXRvLW5lZ290aWF0aW9uOiBvbg0KPiAJUG9ydDogVHdpc3Rl
ZCBQYWlyDQo+IAlQSFlBRDogMA0KPiAJVHJhbnNjZWl2ZXI6IGludGVybmFsDQo+IAlNREktWDog
b2ZmIChhdXRvKQ0KPiAJU3VwcG9ydHMgV2FrZS1vbjogcHVtYmcNCj4gCVdha2Utb246IGcNCj4g
ICAgICAgICBDdXJyZW50IG1lc3NhZ2UgbGV2ZWw6IDB4MDAwMDAwMDcgKDcpDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkcnYgcHJvYmUgbGluaw0KPiAJTGluayBkZXRlY3RlZDog
eWVzDQo+IA0KPiBBbmQgb24gdmlydGlvDQo+ICMgZXRodG9vbCBlbnAxczANCj4gU2V0dGluZ3Mg
Zm9yIGVucDFzMDoNCj4gCVN1cHBvcnRlZCBwb3J0czogWyAgXQ0KPiAJU3VwcG9ydGVkIGxpbmsg
bW9kZXM6ICAgTm90IHJlcG9ydGVkDQo+IAlTdXBwb3J0ZWQgcGF1c2UgZnJhbWUgdXNlOiBObw0K
PiAJU3VwcG9ydHMgYXV0by1uZWdvdGlhdGlvbjogTm8NCj4gCVN1cHBvcnRlZCBGRUMgbW9kZXM6
IE5vdCByZXBvcnRlZA0KPiAJQWR2ZXJ0aXNlZCBsaW5rIG1vZGVzOiAgTm90IHJlcG9ydGVkDQo+
IAlBZHZlcnRpc2VkIHBhdXNlIGZyYW1lIHVzZTogTm8NCj4gCUFkdmVydGlzZWQgYXV0by1uZWdv
dGlhdGlvbjogTm8NCj4gCUFkdmVydGlzZWQgRkVDIG1vZGVzOiBOb3QgcmVwb3J0ZWQNCj4gCVNw
ZWVkOiBVbmtub3duIQ0KPiAJRHVwbGV4OiBVbmtub3duISAoMjU1KQ0KPiAJQXV0by1uZWdvdGlh
dGlvbjogb2ZmDQo+IAlQb3J0OiBPdGhlcg0KPiAJUEhZQUQ6IDANCj4gCVRyYW5zY2VpdmVyOiBp
bnRlcm5hbA0KPiAJTGluayBkZXRlY3RlZDogeWVzDQoNCkFncmVlZCwgaGVuY2UgYWRkaW5nIG9u
ZSBtb3JlIHR5cGUgUlRFX0VUSF9MSU5LX1RZUEVfT1RIRVIgdG8gYWxpZ24uDQo=
