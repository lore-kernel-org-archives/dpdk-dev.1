Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A4CE6E815
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 06:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC5E4402EE;
	Wed,  4 Feb 2026 07:14:44 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 751FF4027F
 for <dev@dpdk.org>; Wed,  4 Feb 2026 07:14:42 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613NRZCn598499; Tue, 3 Feb 2026 22:14:39 -0800
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021123.outbound.protection.outlook.com
 [40.93.194.123])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c3tq98s1d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 22:14:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuqzKurfH8y8NucLsIOdGzM5vl7kJ8Lzj13ddPMacjIMJybiaYlju10/oRJSViS1pQf6RquX2odJ/0HffPjXaWFPh/EhfATnLBNFuIJ7/GtQSTrFLOTjFNTiKM2QImly6zRMlSTNv4oFPbecwLFJ2QjqJ0T4o3HxtjCIcGN8C6suJEqBtuT/satXZ49X18OoEDSlNzqdqgHM/rI+t5gzlbwp75byPNB2GMOo7KpyMod7lW/rt+JyRSi/ljNJ4PCsFBar0cfEAk6C9AziVQg/ob/OmNiv5pKWUrDD9lV9KdkGk7Uh/hB36V8hirpPeccI9+oq6U+X/IVxCoZycADNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjY/ny8RR1vnEFzEehXZEboNqdiRj4OqTAdrD9mUBpE=;
 b=HzyHbZipgK//EPywEpQdZEmvD9k0Ij1kh2E0JtxB5eehy1/jzwRn8IpuQB4qEjXX82A8HExlGocl9NsUTtZlhPCUx+VDKYYs6pynCRKZYLPEfWZrwVM/Yow1+86nkfo/OgUCayNg9+er40stbD3RVrOFU6RUMh5OHgvSxNyASk90alB9+5Ycyso/LFsajzl++YqeseauVlKpjCivPeb0QDZziVC5jpk1MmaGyktqXDI4G7wAeNak/NdXmKhZdmzaK6N0Nybr1ml9M51JOzJBvMR1hOHSpnkbnVOyitjIfbcVdfH0a0dY7vKnNmt1mI5MLZzCDiBOCIHjqX2NZLQc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjY/ny8RR1vnEFzEehXZEboNqdiRj4OqTAdrD9mUBpE=;
 b=FPAFPieHYARGEElb0x4aEdapVXicLMZKWkXomqJwDSjyz9enfZY+ZYoNspGeO2FRE1dL/7O9lhCyqw4QtE2m+gDv1X2iFKT/3LlyBbKkNrIXpfS3oucC9yyoVztdAAJGUE5YS7MFJ0pz5wGVFYxw/F9ywsh4l4dpQe8HQE47P58=
Received: from SJ0PR18MB4494.namprd18.prod.outlook.com (2603:10b6:a03:3ba::15)
 by PH0PR18MB3958.namprd18.prod.outlook.com (2603:10b6:510:2b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 06:14:36 +0000
Received: from SJ0PR18MB4494.namprd18.prod.outlook.com
 ([fe80::d5d1:8a95:7fcc:3ba4]) by SJ0PR18MB4494.namprd18.prod.outlook.com
 ([fe80::d5d1:8a95:7fcc:3ba4%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:14:36 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Andrew Bailey <abailey@iol.unh.edu>
CC: Kai Ji <kai.ji@intel.com>, Patrick Robb <probb@iol.unh.edu>,
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, "luca.vizzarro@arm.com"
 <luca.vizzarro@arm.com>,
 "dmarx@iol.unh.edu" <dmarx@iol.unh.edu>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
Thread-Index: AQHcgCTqX/6JQl1VqUWrr2d9THn8kLVId8GAgAZh0ACAABXcYIAN9dQAgAA0OUCACX/GAIAJLYmAgAJxadA=
Date: Wed, 4 Feb 2026 06:14:36 +0000
Message-ID: <SJ0PR18MB449450BE407BA837E2398294D898A@SJ0PR18MB4494.namprd18.prod.outlook.com>
References: <20260105190647.63244-1-abailey@iol.unh.edu>
 <20260105190647.63244-3-abailey@iol.unh.edu>
 <CAJvnSUBTtGyQ7WtE9GF-gawS=A8rHAqcaqTSo8eWYa+GBkhRwg@mail.gmail.com>
 <CABJ3N2W6QXQ1Aae4QWaZhSMrwMfmDa6oYjHby1YDQJdK2FknvA@mail.gmail.com>
 <CABJ3N2VTZc-73hP=0KG8EPbdrCexYZXToLzhJPAhkN+Eo77DWg@mail.gmail.com>
 <CO6PR18MB4484327639EC118ACFFF3810D881A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABJ3N2Vf=guy5qJmmbTHY76Bnnn-5PTEkmB+FewahHqDzxJLiw@mail.gmail.com>
 <CO6PR18MB4484D1EF6B0BDF1205164276D896A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABJ3N2UzbranA3ZTjm42Vf2UU8ajYh8uNVvttzm_D7z+oqH5uQ@mail.gmail.com>
 <CABJ3N2VbQD=jWqg-UBbe2kuWAJtKsxkXNFy_bK+4imvTLR0+jA@mail.gmail.com>
In-Reply-To: <CABJ3N2VbQD=jWqg-UBbe2kuWAJtKsxkXNFy_bK+4imvTLR0+jA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB4494:EE_|PH0PR18MB3958:EE_
x-ms-office365-filtering-correlation-id: f99e280a-b1a0-4344-fa49-08de63b4abfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VUtEc08zUEN4d3NuVVo4TS9vNFVTb0xSVmJkcUFqZ1lySmU3dkhKVXozbTAw?=
 =?utf-8?B?ZHJNZHViSXBjeGNTOWFKYmVTeXFlMzF6eHdYLy9GOW5YeTlpVnd6ODB5N3dE?=
 =?utf-8?B?VEdsTXBuZmtFbkpkclBUUG40NGlNSi96bnlnTWdUYXlIc1hVUnRkU05sb1B4?=
 =?utf-8?B?YmlwWlkxYW9ZYXozdTlsczc4VDRjYUp2T3pLTDVQSHd5SzJvK2pVOW9lc0o3?=
 =?utf-8?B?cTBHUEtTOHR3c1dhejJvU3RHSmNmZFE2V1BTTlpybnNQNHpJQ3UrR3hyYXN5?=
 =?utf-8?B?dWpuWUpibUVncHorNSt3UjhIdENxY0xEZ3grWTB5OGlIWVloVDBYVmpnZFkz?=
 =?utf-8?B?U3hLSlVuaUZNVlllazc5bUdlY0NQS2NFSFhxaEdSREpDcnFTVElnUC9Nd0VB?=
 =?utf-8?B?bGlZdTMvczFLZVJGc1k2U1l5NDhKNy9IM0NwR1ZIZnhmam1LMnl0U0ZwaUdQ?=
 =?utf-8?B?cGpuck9kQXpQRzczS2N0R1A3NjJ2aFgrcnN5cDVuN2RVWVRNSzRuMG9xZU5t?=
 =?utf-8?B?cjFHaVAycVVHMmVkVnduYnZHTHVmNlhKYjNHWFhxeVNvaWliN2JSRWhrL1Vm?=
 =?utf-8?B?b3VNZmFsZ0xaQm9NSW1SM3VMRzBBak5rcFNqcW5uTVNyODRsZXdQRGIyb2V0?=
 =?utf-8?B?V3JUVUd6cUFBbHFvME9vRkw5Qmt4VlpyR0s0Yzd6YkpYR1BJYWpTN3RtaDR2?=
 =?utf-8?B?SGxsczZvVXhTSWQvUU9uL2NmQjZzS0ZnNlYxdllreldXdWFGL1BmYWF5OWJ1?=
 =?utf-8?B?NC9KT1BtMjZkT2NnU1h5S1VCQVVVSEJyVVRFVXNNTHVJSE94YTZvNmcrTUZw?=
 =?utf-8?B?YnR3RmUvZkU5aENlVk4wOHJxcno1NHNrc0xOaENyM09STkd2cWptMXZIck42?=
 =?utf-8?B?ZjhyRmU5SmFXSC9wMVdDQVR5ZG5XZXRaY3hFU2V0N2Rienk2TjR6em12Q0N0?=
 =?utf-8?B?eTJuUFIwTWw1eC9VY3Z1cEx0TzdFbzlnVVl4d08zNjVRbUU2NWdDQnJBSHQ1?=
 =?utf-8?B?VkVidU0rRHlhRjNoRnpQSVRPN3Y0SjdORWl1UWFyYUViaXBqR3ExOVBnVEtj?=
 =?utf-8?B?cjhxaU0rU3BnZ2w5L0ZWbk90a3VsY1l3TTVCbjR0QUI5U2tXVmZnUDllcUFI?=
 =?utf-8?B?U2djM3Y5OWtzenhQVFRsTXRqNHZHbk5tL1MwaDBCYk9NT1hmaVh0YWpNNHhv?=
 =?utf-8?B?VHBrQ25hRXl5WmtQcngwdHNzQmVLUmZoNXNFcWdsU3NHYXhUa0hKd2cxdGpW?=
 =?utf-8?B?d3Q4SndzVzcvZ2V6bjI0U1cwRGc1RXczbnJGR0hNNnUvdytxUSt3YjUxRElQ?=
 =?utf-8?B?ZFBTcXZESmN0SkFsTWMxWFFEQVd6K0dHY1ZTNDdUMVBXbHNoMEdaNzdtUUNn?=
 =?utf-8?B?dnloNlBrRGlObDJRa1ZhYTdNUVV4VDFEZ3lMNmE5bHdTVGhNdHRpc0FmZllC?=
 =?utf-8?B?Y0tQRVZZenREdTVRNTRPUEFzL2JONEdDMjNNQi9IS1hVZHlHQVhuaGNkWE5n?=
 =?utf-8?B?dm44NmgybWVVR0NrOFc4TXkyV2lFNVZlSjBqSGlFS0xUdGErWVVjVTFzMWFa?=
 =?utf-8?B?dDVyL0tISE93VTZwc2FORTI1UkRheFZkakhOUHk3RjExSWE3VjJtK01RRGwz?=
 =?utf-8?B?dVpFQkIvUFlUQkRsZ0xmaGNYMkloY2ovMEpJeVYyOU84bGZJSDJDeEE2RlMv?=
 =?utf-8?B?RXNpRm1IOVowWGtNUVZhOXM5YUJmTDNUZytHdTBRL0xOSnRMTlAxSFpxSHdo?=
 =?utf-8?B?cTR3SEh2alNMa0VhSjltSURwVGZpVDNRRmg1WXFkVFVkcE9SaUQ4bXVseUd6?=
 =?utf-8?B?YkgzSzlHeW9wS0VOK215MGR0NjZBUkQ1Mm9ZU3VrWDZkYXh4cXI4N3RtZXp4?=
 =?utf-8?B?eGVzSjlLOTFoazlacVdCZFpvQlU0UTc2ZndlNVhyeXBZTUJHWlVBSm5HdnIv?=
 =?utf-8?B?aWd0d0RSV3lpSm5vMnBJWXQ5dS9QVGVBV1ZxclFMdFFaVmxveE5FY3VTVHVw?=
 =?utf-8?B?citYTVRkK3F4aU5QOWJldW9VZHF6bWJiU0tab2p4a1N4R2ZkR2VOR1ZlR01P?=
 =?utf-8?B?WE80MEFCb21lNDlHMzl1U0F6Si80UlZaRHdUcW9XbldUUmZRL2ZqY3N4TS9B?=
 =?utf-8?Q?fZeKN96ArdSn90EirhN+z8AG3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4494.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2dLeHRqVXA0dlMzZVhmOWdJNU9mSGJBM29JeHE4czFhQkM1NnFBUDdtek1I?=
 =?utf-8?B?Y1dqeDlYcTFHVzd0TGtnRWpqVmN0NlhqZGhNOTV6TW1MYjVKSjV3YzcrdVZx?=
 =?utf-8?B?YmhIaU1ERGpFUnpmVEMweENhM3B2eUliWTY3Z25CcDd1Mi8vZEJndHdDRW5o?=
 =?utf-8?B?NDBZcnM2VFExZVRsQWJoSE9CNVBKNm0wczg0a29LQUZqRUF1Z2ZUUEUvUTlz?=
 =?utf-8?B?Y1lEa2xiYUM2ZXpHTmVscDh0bFpxU3JieWxXMWNyZ1BxYmRzUnZZdjJQd25E?=
 =?utf-8?B?SjRnTStLWncySUozNjVQdWxJN2dEcFdQZGE4OForY1I1bTZRQ0pVZWkwdjhS?=
 =?utf-8?B?ZnFkM0lwR2xpM2pVNkd2a1p5N09pSG1FcFFJQlozaTZkRDRJVzNNSWMxOGlz?=
 =?utf-8?B?YXdlS0lhZzRwWGJYZW9YYnFza2pFS015ZzBFeklMUG81YlZjMC9vTlVLUC9Q?=
 =?utf-8?B?R29Pa3ZUNGRkMFVJaEtxb05Zbk5TbEVmMmt1MFlGWmxqWjdOUG54Zm9lUU5O?=
 =?utf-8?B?eldzSWlqSU5NajRvdExuUktoRWhLd0N0c0t5RzNNREtKWXQ2RHRnRS9oREI2?=
 =?utf-8?B?bVg1YlJPSEd1dWgrYWw4emZsZENGd1dLdkhsaUlWeDRSL1dZRXBodWdycTM0?=
 =?utf-8?B?aTdpT2tYR1VSbExXQUtaMkk4RmFSVWdzYUFUOUQ0UEhmd2ZacTZmRnJtNjI5?=
 =?utf-8?B?bW9tVXU4eW1QeEFyNXNmUWhQWmFKQm1ReCtoT1dDRFF6WVlRQmdJN1A4MDcy?=
 =?utf-8?B?dkkrQTNCRzR1eG00djc3dnVidEdhSWE5dmZkQlJyaTR6bTB3SWx6YjdIbkhE?=
 =?utf-8?B?Q05aRzR6ZVluNTZxaW1hS2IyWXBCTHV5eTVEcDVYK3hxNlQ3WVRWellScmRI?=
 =?utf-8?B?RG9rYmtUL2ZaY2hOdCszdDFzWUdNdnFkYjBBVGNqTU42MitIMHBUTHhWSHFx?=
 =?utf-8?B?Zzg2dFdmaXF3QmJtbWhUU3Q0aVBnK09SSlJjbzJPVE9BbFNzbFZWclRPVUJD?=
 =?utf-8?B?elBpait0T0NNaE8vcEJOdmxCZ0xIV3NwMUJ5RTAwWFVPd1ExMC9HUlNjd3ZD?=
 =?utf-8?B?dFRaNy9kZmlmc2dQMTlMeGtodEdtdlRrOTBnUkpYUzYyT0pJeWNHakZ1UmxX?=
 =?utf-8?B?Z2VwVFVlcURDekhpMWhpems0VlJhTGg5dWVrUUlVNzQwdk9BY3QwcVJTWEVu?=
 =?utf-8?B?ZnBqRjUrZUIzYjRxVmx2WjBGY1V1dlErNjUxUVhBMkwzSHlsS28wWHRqaEZw?=
 =?utf-8?B?VHY4ZE5RTWVJTG1pR081cy91eW52bzduM0xWYVRlV2tINlBSZDVPandmc09W?=
 =?utf-8?B?Nm5PaEtPM3ppSXVoUStjSDNVSStMYWhYNUFubXdRRVd3eG15bGd0bE1xNW43?=
 =?utf-8?B?MHUzSkorN2tnSi9TYTNlODBTMDRIZE1sYkM5SGdRelZsT1VlS2xBOUE2dDRU?=
 =?utf-8?B?WjRKcjl1TUVKVzdNU2dxNllkQ0U3ZGw3bjZTNzB5bXdaWXpaYTJMTE5rTzZ5?=
 =?utf-8?B?eGppaUFTSkdxTm5hcmZ6S0RyN3JTK1RFZ0dNT1NJVkQyWGswT3ZTNjVKNnIx?=
 =?utf-8?B?QUpoUzIzNnN5dU9LRlNDcDZXQzJJaTBBc284dVFISTZuT2tkWitHQjRGUmcx?=
 =?utf-8?B?ODlKblZ1cEhTa0VqWHVOcGQrUWNGTTM0VUlJNTAwblFybDZwRXVqcVV3d0g4?=
 =?utf-8?B?YkZMQUxLL2V3eEhHZ3JHcE5acXUzWVBCcVY4MnpNY3BuNERML1VTcnVjM3cr?=
 =?utf-8?B?OGpnenZyR1pRWjMwek9zaU9kbmQ4c1U5L2dSSEJpbUh6S21qRmdCQnlPaTRH?=
 =?utf-8?B?L1JCRUZ0WTh1MXc2dWlTazhHVldDQnZrajM3NmVCSnk4eWRQZ2NjSWR6TEFx?=
 =?utf-8?B?YnFLU0M2UmdxdThlT2VkUURnelFPOGlUWnJRR3NaV25LTEduajNEOGJlRFA3?=
 =?utf-8?B?Y1BpbXpRaWZzeUQxc1d0bXZJNjZqZVZwbmR3V3kxNFZLSS9VR3d1cVJpOTRE?=
 =?utf-8?B?UVpwY08yenFCeXArK3hkdUlOUm12UzF5UGNza0xCclp5TlpMekpqWWFMbC9G?=
 =?utf-8?B?aFo0WG5YeXU4RUpNMFlIQ0liT1BLM1VVMmlHWER6dlNWa2ZSUjhIa0t5MWI2?=
 =?utf-8?B?UFk0RGd0VGtEMm9qUHQ0YzBWZGpjdXNTczROcGRVeXN4UmVmU3UrbHdCU2tZ?=
 =?utf-8?B?bnRaSFljbWtvT0dVU2Z1b010dHlIY0wzWEJDSmtsY2E2aHg1ZTdUSWNtYWlD?=
 =?utf-8?B?aFVzNTZFaFVDdlVwN3dYTWxlRkVwaFVWNk1weTR2MmFTRGswejRhWS96d3Mv?=
 =?utf-8?Q?RHG92GK6BJMJICf1YV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4494.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99e280a-b1a0-4344-fa49-08de63b4abfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:14:36.4039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 134jdsEL5KzliRXTIlwoYIwKHLxpU0oEbaATJQ/N0Xkz5hlAkI0Z9RobTwFpbvmBylJ+7BLFmKrl0AHCMoMOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3958
X-Proofpoint-GUID: 32VDdJKjyxYgSNi5MDupORzYvMsBxOx-
X-Proofpoint-ORIG-GUID: 32VDdJKjyxYgSNi5MDupORzYvMsBxOx-
X-Authority-Analysis: v=2.4 cv=GqtPO01C c=1 sm=1 tr=0 ts=6982e3ce cx=c_pps
 a=1pmWRJemPF16E+bttNzokw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=MvEk6ijGDBHVbNoPsw8A:9 a=QEXdDO2ut3YA:10 a=UmPQYxRnTaMA:10
 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA0MyBTYWx0ZWRfX6rSDGCxw619z
 o5K0EY1Haqsd1y85Pw7hd4y2dORDm8txyBaT28UDGq3mD1BCEg1fmCpsh+oUSAH4g1ORiE0N+nP
 64tO8jzS7z+M9aJGV3dLu5dT6sc783y4+oPKMImBS36+QRxvwa8LPA9eaYkRb08gHEFa8rBam44
 lyAdQlzpgeRWddTJ/T9I2xMxaGruMXpcUwVrDiVSfhZmGb2ucsSgI7LsJCZnKjdFAHRZiXBK9oX
 RJ4paIrcYzmmQ7Db45z28SRXfrVif9aRhIhMGGxMMHHXrHika24LT851gfREj4090Tt1Cg3rnC9
 HDDrBR8pR98FpMdZyFgf3pfmXpl6VQWsKewOVKxgn1H1DtrHK55g4n5wTD2UsWo3L0AL5Nk1dG7
 8x0FuYaJi8qD7EC9RV6oj4tB1986/zyepYgU2Pw6fgyOGnfKbBZXbE3Y2/o7q06SqPa2aGaz1Vh
 qb1dZJ4QhO6D8kz29/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
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

SGkgQW5kcmV3LA0KU29ycnkgdGhlIG1haWwgZ290IG1pc3NlZC4gUGxlYXNlIHNlZSBpbmxpbmUu
DQo+IFRvdWNoaW5nIGJhc2UsDQo+IA0KPiBXaGVuIHlvdSBoYXZlIHRpbWUgdG8gZ2V0IGJhY2sg
dG8gdXMsIGlmIHlvdSBoYXZlIGluc2lnaHQgb24gcXVlc3Rpb24gIzEgaXQgd291bGQNCj4gYmUg
bW9zdCBoZWxwZnVsLiBJbiB0aGUgbWVhbnRpbWUgd2UgYXJlIGdvaW5nIGFoZWFkIHdpdGggdXNp
bmcgYSBzbWFsbGVyIHN1YnNldA0KPiBvZiBjaXBoZXIgYW5kIGF1dGhlbnRpY2F0aW9uIGFsZ29y
aXRobXMuIEFkZGl0aW9uYWxseSB3ZSBwbGFuIG9uIHVzaW5nIDEwLDAwMCwwMDANCj4gdG90YWwg
b3BlcmF0aW9ucyBidXQgdGhpcyBpcyBub3QgZmluYWwgYW5kIGNhbiBiZSBpbmZsdWVuY2VkIGJ5
IHlvdXIgcmVzcG9uc2UgdG8NCj4gcXVlc3Rpb24gIzIuDQo+IA0KPiANCj4gCTEuIFRlc3QgY2Fz
ZSByZXVzYWJpbGl0eTogSWYgYSBjaXBoZXIgYWxnb3JpdGhtIHBhc3NlcyB2YWxpZGF0aW9uIGlu
IGNpcGhlci0NCj4gb25seSBtb2RlLCBjYW4gd2UgcmV1c2UgdGhhdCBjaXBoZXIgYWxnb3JpdGht
IGFjcm9zcyBhbGwgY2lwaGVyLXRoZW4tYXV0aCB0ZXN0DQo+IHJ1bnMgd2hpbGUgdmFyeWluZyBv
bmx5IHRoZSBhdXRoZW50aWNhdGlvbiBhbGdvcml0aG0/DQoNCkZyb20gdGVzdC1jcnlwdG8tcGVy
ZiBwb2ludCBvZiB2aWV3LCB0aGUgdmFsaWRhdGlvbiBpcyBub3QgdGhlIHBvaW50Lg0KVGhlIHZh
bGlkYXRpb24gaXMgcGVyZm9ybWVkIHVzaW5nIHRoZSB1bml0IHRlc3QgYXBwLg0KSW4gc29tZSBv
ZiB0aGUgZHJpdmVycywgY2lwaGVyLW9ubHkgYW5kIGNpcGhlci10aGVuLWF1dGggaGF2ZSBkaWZm
ZXJlbnQgcGF0aCBhbHRvZ2V0aGVyLg0KSSB3b3VsZCBzYXksIHRyZWF0IHRoZSBjYXNlcyBhcyBz
ZXBhcmF0ZSBjYXNlcyB3aXRoIGFsbCBzdXBwb3J0ZWQgbGlzdCBvZiBhbGdvcml0aG1zLg0KSWYg
aXQgdGFrZXMgdG9vIG11Y2ggb2YgdGltZSwgd2UgY2FuIHN0aWNrIHdpdGggdGhlIGNvbW1vbmx5
IHVzZWQgYWxnb3Mgd2hpY2ggYXJlIHN1cHBvcnRlZA0KQnkgYWxsIFBNRHMuDQpZb3UgY2FuIGNo
ZWNrIGh0dHBzOi8vZG9jLmRwZGsub3JnL2d1aWRlcy9jcnlwdG9kZXZzL292ZXJ2aWV3Lmh0bWwN
CkZvciB0aGUgbGlzdCBvZiBzdXBwb3J0ZWQgYWxnb3MuDQoNCg0KPiANCj4gCTIuIE9wZXJhdGlv
bnMgdGhyZXNob2xkOiBXaGF0IGlzIHRoZSByZWNvbW1lbmRlZCBudW1iZXIgb2YgdG90YWwNCj4g
b3BlcmF0aW9ucyBwZXIgdGVzdCB0byBnZW5lcmF0ZSBzdGF0aXN0aWNhbGx5IG1lYW5pbmdmdWwg
cGVyZm9ybWFuY2UgbWV0cmljcz8gV2UNCj4gYXJlIHN0YXJ0aW5nIHdpdGggMzAsMDAwLDAwMCB0
b3RhbCBvcGVyYXRpb25zIHBlciBydW4gb2YgdGhlIGFwcC4gIHNpbmNlIHRlc3QNCj4gZXhlY3V0
aW9uIHRpbWUgaXMgYWx3YXlzIGEgY29uY2VybiBhbmQgd2UgbWF5IHJ1biBkcGRrLWNyeXB0by1w
ZXJmIG1hbnkgdGltZXMNCj4gd2l0aCBhIGJyb2FkIG1hdHJpeCBvZiBjaXBoZXJzL2FsZ29yaXRo
bXMgYmFzZWQgb24geW91ciByZXNwb25zZSB0byBxdWVzdGlvbiAjMSwNCj4gd2UgYXJlIGN1cmlv
dXMgaWYgdGhlcmUgYXJlIHRlc3RzIHdoZXJlIHRoZSB0b3RhbC1vcGVyYXRpb25zIGFyZ3VtZW50
IGNhbiBiZQ0KPiByZWR1Y2VkDQoNCkZvciBTeW1tZXRyaWMgYWxnb3MsIDEwIG1pbGxpb24gaXMg
Z29vZCBhbmQgd291bGQgYmUgY29tcGxldGVkIGZhc3QuDQpCdXQgZm9yIEFzeW1tZXRyaWMsIDEw
MEsgKG9yIDEwSyBmb3Igc29tZSBjYXNlcy4pd291bGQgYmUgZ29vZCBlbm91Z2guDQo=
