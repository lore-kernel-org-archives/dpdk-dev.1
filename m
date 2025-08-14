Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671DDCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 05:09:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5657F402A8;
	Thu, 14 Aug 2025 07:09:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0C8C74026D
 for <dev@dpdk.org>; Thu, 14 Aug 2025 07:09:56 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E4sPIQ006837;
 Wed, 13 Aug 2025 22:09:56 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2127.outbound.protection.outlook.com [40.107.95.127])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48h96e80kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 22:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kM5bQs6LztkYAGkMXOiSLgcypbRvPnh0wtICPn2/VSPTybo0jVu1PNr7oKmY5GL2a4jxgMDukz8FOlpEKwHsImWn8C0i8xNg2IRM3ZEe6DZ0YeWW9LhnyY2EYJQ9QxhnrqXytWFKK71mdtyeJqXcwPY3mCa6VpS8x6Jr6Ibg0kYvmbfj7+/lNhUA1HH9acREao4yl5sw8iajm2AlAmQUH7vEM1uAyTQqD1cAABLOC++VQw6ThzirtK/PQmlilxJhkCX2dgAqddjakl7Hm+T2I4btHnSo5Do9zPqPtu0rs8/GIguvUio0yNB9D5QDopVS39tlmfMVUvMLDmzOj8MGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkxiRzjHU1xiWThb1qgeNS3+2rYIM4S2hCIJXU6CpzI=;
 b=bkQpHAr4QQD047DHGLJd6rr10bNmUA0aWm+POpF7Sl4yhwM73lDXv1HYajnrENYRa5n/0/bUybCZD5vXfI60Z2i+uKuKHciShzeYYPHZ3h6N+2oAkvRKMwJhk/Z9LL3VgIndTtYMiIevcIZ3R41bigROlg8OJzW3cwi3qak+05nEGNVWfHn19Ord7lTPgsXf+hN3qd98Za2essNUck9mOkDn5R39BE+wOflMywqMp4vG9MM8LvQ6ORdMHJA1fxDKIpG4UdqzQoYzYQS5MP2WvJ/nMs67IOEV3ld4qaOyXHh4qNEZBc3nPi5cu9xtaCwERzVPk+2L+CadT+kTJizuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkxiRzjHU1xiWThb1qgeNS3+2rYIM4S2hCIJXU6CpzI=;
 b=daegw6RGdTw7XPBUxsM/6P/NAikNi2n6yHLbi4bMdr8yXLIHyArd6yS2HB0wC4H9LSebkULgdxioMeyjsx/EislKKoPMTtCiIgDiLmS/px6iyD1hFJD1CFsvBqLKNb0pFeyLC32tnQ4QnSGDJRNbBYyYKkGfMhZYMDLvfx6xHsg=
Received: from CO6PR18MB3860.namprd18.prod.outlook.com (2603:10b6:5:34d::12)
 by PH3PPF712D081B7.namprd18.prod.outlook.com (2603:10b6:518:1::ca4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 14 Aug
 2025 05:09:51 +0000
Received: from CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba]) by CO6PR18MB3860.namprd18.prod.outlook.com
 ([fe80::7a27:a7e4:65d5:7eba%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 05:09:51 +0000
From: Sunil Kumar Kori <skori@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, "dev@dpdk.org"
 <dev@dpdk.org>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Stephen
 Hemminger <stephen@networkplumber.org>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 1/1] ethdev: add support to provide link
 type
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/1] ethdev: add support to provide
 link type
Thread-Index: AQHcDC6YIPSKVNgKYkOfxF0JwYLKsbRgYOuAgAE3hYA=
Date: Thu, 14 Aug 2025 05:09:50 +0000
Message-ID: <CO6PR18MB386034432836E3AFA6C992FDB435A@CO6PR18MB3860.namprd18.prod.outlook.com>
References: <20250606092904.3145608-1-skori@marvell.com>
 <20250813084508.1446318-1-skori@marvell.com> <1975832.6tgchFWduM@thomas>
In-Reply-To: <1975832.6tgchFWduM@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3860:EE_|PH3PPF712D081B7:EE_
x-ms-office365-filtering-correlation-id: 106d3c0a-5a33-4851-e779-08dddaf0cc65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NTlNYU4vc1EvYWhCKzFGRFRpaXBBQSsvTHJiZDFuTlo1L1duQ3JwZ2o2VzZP?=
 =?utf-8?B?dUlnTzcwMVNVNWRpa0JPRGQ3eHB5SWhtRWRSNU13bWxZaURVKzNmT0E3ZDFV?=
 =?utf-8?B?bktCMTVCOEJUMGRFUDFaLzVZNWhibDRqb3JqZUxUS2tZd3pRejJBSldhdk9U?=
 =?utf-8?B?ZHVHSnFSVkF0cjVYVFRYdHF3YjRjRmpKdllZbDFCNmhjWk4ydkhtQ1o1SEpk?=
 =?utf-8?B?TFBBM1U5VjRmazJHYTc4a1Y5elJyNFg4cERrMXUyYmFMd1hNNDFPeThnUllI?=
 =?utf-8?B?UjdITWtnNFptOG9iNTdMZEQvVHY0NWU1d0pSayt3Ty9jbTJWS1Q5QzBNUll5?=
 =?utf-8?B?U1Z1OER3TGpnMTlOdnlIa2NNUzlXR01peXA2VmluWEY3QnAvL2tXV1lxTWNB?=
 =?utf-8?B?TENBR0lLY0p5RjI4ZUdSZmpKZTEvVjFXWnA0d2Iwb01aVTUxR1hlZ1lkT0sy?=
 =?utf-8?B?R1lzNDZZSjFwQVNGODcxcWVaZXpVdGtLRnpuS3h6Mk5BSjNhbVZ1enhoY1l1?=
 =?utf-8?B?R1hnWmJMamdya1FDY0dDUHk4WEJsWVhYejRKVjM2Q0ovOEdGNFNueFpJQWJF?=
 =?utf-8?B?MUl5TzZ5Rmd0dVRyWXpOcHZGTnF6ajVGOWV2RjJ3dkZrQ0QyS21LWU9SSUQ4?=
 =?utf-8?B?Q1Fqd0QrSlFLSXFzSWJwa3pXRHUrSXdsWExCRjJxTUpHeUJROUdLa3NXaHNH?=
 =?utf-8?B?aFEyZC9lUEZuN1FuRk96M3hhaEVQcTFPNSszQTNUTXVRRnlOc3VMNnJ5dWp5?=
 =?utf-8?B?MnJickxOSjBBNktDaEV3L2Q4QU5vKzBXQjhPWVdMTmh0ZnhDVlBEM3pzVHNl?=
 =?utf-8?B?bm4wSXBkUUI2L1U5OWg2Ui9YSjR5ckkrdE1HWm9oeEE2cGlnaTBweTlUeFVl?=
 =?utf-8?B?cSsvaWFRbk1HZWRBTHNGS01ZT1Q3Z2pCcUR1dC9qZ2VsTHJWYk0wbUFIMVJo?=
 =?utf-8?B?SThsV0gzTEM4SlcxWWhTUHdxOTVuQWFTZkNSbGNNODRSTGY4bjBiVDM2dDY4?=
 =?utf-8?B?TVdScDRaVDRDQ0dRd3dGbHZ5eXhJeEh0cjVJTnZDdFQ4REVpZUF4WjRBRndQ?=
 =?utf-8?B?RGliSEF4R240ZFdvbWJ1eDh5QklzeVgxVFhIQWtVZUpLclJYUGRGMm9EUnFk?=
 =?utf-8?B?aWwxQVA4azdQU0U2VEFGaXY3d1FsQldFTTVuVzhPYndNU3o3WWtkVlppR2tC?=
 =?utf-8?B?ZWlpUUliSktBRlExUERmVEJKWVVsck56TGhDV1RnTi9NL2VWMTRXMHNRR2VE?=
 =?utf-8?B?dDRBSlBvWmppczh2MzVtdkM0NlFDS0tnZ2lkSm54T2dNUjNLV25XV2FuN2Jp?=
 =?utf-8?B?YjNTYWFONHQwQW00QUNBaHlJOVBiTnJuenNwZWNvdUNxZ1VLc1A5RjNacENt?=
 =?utf-8?B?dmRVdUxaVnVYMk9sN09qK2JyMFkwa0E2QnNJTUpaRTNuMTduK3RNYTFKM0Y2?=
 =?utf-8?B?MWRYL2RUakdMSXhDOVk2T2JObDNaVTFFek5wTXI2RTlWcW5VZzIrM2tEenp1?=
 =?utf-8?B?Ry9ubmZYM3JIL0ljUEg5NlJieWhKOTZ3bW9jT29YdWNOT3hLUFhzSVdJNUVO?=
 =?utf-8?B?NUFPQTdGdkZ5YW5aUUdLMzJSajlhZUw0b2FkODZuQjNnQWx6dS9hVDEzenpv?=
 =?utf-8?B?c1ZFVlpWTGJmbWJ3SFVmNmJRa3A5L3N4aUt0UStORmk1L29meUxpMW5SV3Zv?=
 =?utf-8?B?QUphNE5VUFZOL0dQQThEVDR0WFY3dm9kcW9weEgrMUFCd3VUY284WDkzNHBS?=
 =?utf-8?B?RlNXZjdld1FlUGF6NU8ycTY0U1lmWWQ2VzVaeUwzWk9EMEwvTExHMUZqVVg5?=
 =?utf-8?B?cFc3N0xkeU9VVnpnQndrejg2Vkt5SGpZb2pJU1RlSVZqYVhKVlRmVWhINGFq?=
 =?utf-8?B?TUM5aGJUR1BRZWl4cHA0eDN6dTNxdnVwd052R0szelNyZ1BJOEMwMmJ6SFlx?=
 =?utf-8?B?YkFJTEtOUlc5UldKcGpsamplc1pKZkVHTEhNZ0ZSY29BbWprQXIyS2l0cXpE?=
 =?utf-8?Q?HqvJuYOWwDcXy6F68/BnN8ckoi/nUk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3860.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXR1ajdhZm1Tc2VzRytDanFROUNZWEhXL1A1S2pJVkZqYVJlVW0xaFNOdmhp?=
 =?utf-8?B?YlFzdW9wbFBSOHBCaGJMUUdmc3pJRTR6Qk1aT2dlTkQyZUtkMnZ4QnJoSitp?=
 =?utf-8?B?OGJuZWxCLzF2Sk1NTHV1UnFkWTh4alRneUcyVjRTTFdWMGZvNzBNTDFGN0Y1?=
 =?utf-8?B?K0FIdEQxR3lyTEM1dld6VkdnYjJiWGpQVnhzUTZnbWpsWGZjSTJRbENKV1A3?=
 =?utf-8?B?cTVQMm1RMGFQaWFxanh2aFVDc21VSzdLeTBGWkV6N1djZ2dWL01pdDdlc1ZB?=
 =?utf-8?B?bjFBdXdaa1JjakwyVGltL2NVbTNEdXlsaTl1S3F5cGVSQ2tWMy9aS0lLbGJF?=
 =?utf-8?B?M1J2MlFiM2lMM3BJN0VaRWJjUXdqR0RabWNvbi9USWwzRll2VlB0c1ZEb1hw?=
 =?utf-8?B?a1dGZXp6WmlJU1FhRjAvd0Z6VzVoeEd6RW1MeWltOVExQ1ptRHJPVzNSbVZY?=
 =?utf-8?B?RS9ra3JvY1BnMkQ0ekh4WmxxN1lEK0t2dEl1MnRnbFpJRk04RlNKQ0dJVW1W?=
 =?utf-8?B?dDJXMUc2RDU3VCt6RWxRN1VHVFptaUZFVXE1aGVLaVd6enpmMi9rQmZlUnd6?=
 =?utf-8?B?RFlhVXJlemdJVmhoMWZVS0RVYWQyVElFZElidXRXd1RCbVhzM08zZUEwS0JV?=
 =?utf-8?B?aXNsSDkxaFV6WWQrOWx1WEpBK2JxMlYwYkZNbkpVMVpBY29TWDlYa1hETkJC?=
 =?utf-8?B?UXVIWDVvNmVGcDdFRkpEK2ZJSmpRYVRYbzdTSnBYNmFXR0pOMWtJYTd4dW1C?=
 =?utf-8?B?VWhNQWJUMi9vRnFmTWxDbGZveVk3aDVyYlp2aVhMdEpjNGZzdHcxWFAvRnRO?=
 =?utf-8?B?OXdzSDVSVCtGZkZrYXAvVnJtdWdxUlcwR3hSQlk4aUlrVk5GM0lOV1QrbkhY?=
 =?utf-8?B?TldEM1hBZWVtWXR1RS8xNVNiZEJUVHJkN0xIMjVKWWtqb2JHdnF2eE81ME1F?=
 =?utf-8?B?cTM4NVIrbHYrMXFjTzVWbnlVdjFLY09rTll1VXozbVdBSFpOSkJRNUhxQjFZ?=
 =?utf-8?B?OFBIbm11TDBWc2tJVWtuVmh3VlMrOXZjTXhvWEtQenZKdmI2MC9OQ214QTBq?=
 =?utf-8?B?Rm5Hcmd5bnQ4SFR0YjgxU0lUNTQ3bE0vNHRPbWlOd0JNWWlpaEpSQjZNN1Yy?=
 =?utf-8?B?b2hramNkMm9VQWZNOFZZbHNaUWxtWm91YWJWUTRLRHY0VDYvbVhVWXo3c3ZI?=
 =?utf-8?B?MTRodG82SXhsQ2RvYkVwT3Zsak84MVFjQTByNjNYVEdiV2tyMXpqWHRYVzkr?=
 =?utf-8?B?V1VJWXp2d1Ywd0NlRU53NndIeEM4QnpwcVlOUE9mWEoxSGh4b2dmQmNvZVlh?=
 =?utf-8?B?YnU1eHZLVG5QWHc0bjhITDhLMTVneWE4NnVXSjRqdGNLZUYxUEVnSzRMaFZJ?=
 =?utf-8?B?S3ZhN2tJeGpaYm8ybmR6U1dSUEgzMnBkV081bWpYRHgyQzlPM0M4bXBISjlP?=
 =?utf-8?B?OFREMndEcTFXQnBTZjE1YWloZkJqNlBJcUF6d1Q3NElNZ3BHbE45d0RpSXFC?=
 =?utf-8?B?VnovSXZKNE80WTg5U3NkcklPYm1wZDlDU0pzWitsNzltTTdZbGpQR2R1YkVh?=
 =?utf-8?B?aFZ4dHZqaFcrcnphd2ZWZTZ6MExHbVlMN2daQzM3cmdVbzNLeE15bGcvTloy?=
 =?utf-8?B?cmpWMllsM0NVcEZ0WVg3cFh6VER0dHpUWU9XTmFUSGlDUjhkaWt4VW5OWExa?=
 =?utf-8?B?eWlDd0dTYndhU1NzaG5HY1hRWE8vWThRZnBDUmRUMGlhdVVWc0VoMktkcU5I?=
 =?utf-8?B?bXNzUURzRUFvd0N0cmlkUjB1SS8zSTE0eDZFUkwzeFBpV0N4NkNCLzY0WHJY?=
 =?utf-8?B?c2hSQmY3ZWp6cHJyTXRiR2JzbXpTYWV6dmJoWG0rMk9aTTAzWWJpL21qa2Ju?=
 =?utf-8?B?NER3aU5ib2Rob2tsMndqQWtyeGhPMk1QWGR4ZjdyREpYTVJtNFdWRkVhdEhw?=
 =?utf-8?B?VnZIM1p2WnVaM2lBendIT2YvNmJqT0Znd1pLejVnZ0sxYmNiSjZrekhZWGZi?=
 =?utf-8?B?TUp5aHRJT1lzNC9nNjZLUHZOVkNoREs3M0VrbTlEZUdTMnZjazFBSEViS240?=
 =?utf-8?B?R05pUXhFUWt6dnRuMHlQRVNpZ1ZsRDBiS1lZc0ZjQzU3b2U3SWQzTG03dzI5?=
 =?utf-8?Q?TrZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3860.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106d3c0a-5a33-4851-e779-08dddaf0cc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 05:09:51.2332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90CMJj/df0fySWSeb/ioimaKYosDHVvDA5vpi4AIArN3YWB+ZvLP1P0PHmaohcmBKr/KQK8e9FTVyKlzO5XOjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF712D081B7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAzOSBTYWx0ZWRfX3TCzPDnZ1uUn
 nOxFi+6UJb2WyjNcyIcCvcW+nfUTvCxxyP90T6xfun1TTvYcER7wxa/FkTk6Xp+dd458fQvj1v8
 kjxqlgGHckXfmSIhBACczi14Ohd4JvYQmayBhBVI/K6ap3qNNsVkx/x3nvwi4exWqGnTdQYYgnj
 7S5/PlIOQo39zN6efzVg2kpMYUBzHWUKG8T4wwh796Hi2x4DXt39Ehi4cbflpgJERYKBLE0nzK/
 y71nXrsHN/UTEZDAfbKh+ybGwqa4n08OhUyPuia/YyRZN8+R4hO06MzgGnnAgqNJfyEeXkOOqzw
 I685W2CMWhf6ncpH8Df7zfpmTDiRahwhevxxwcgNDzxxTmlYSgbre7JgKC46ziF6wlTN58VojQF
 UgmjpPYfrpvuREKPMx5IM8HQ7zjzoHPvELm62SQX6Z840KlXCDsySzJUh87nBjEL7rzBEwrn
X-Proofpoint-GUID: _Yml7jOyW25M4fyqC4ZJ72-_hi-l8oWJ
X-Authority-Analysis: v=2.4 cv=RuLFLDmK c=1 sm=1 tr=0 ts=689d6fa3 cx=c_pps
 a=5blPGaBx5mfX2KlEFLyEIg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=flkULnUKOYwDf7W_UPcA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: _Yml7jOyW25M4fyqC4ZJ72-_hi-l8oWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
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

PiAxMy8wOC8yMDI1IDEwOjQzLCBza29yaUBtYXJ2ZWxsLmNvbToNCj4gPiArICogRXRoZXJuZXQg
cG9ydCB0eXBlDQo+IA0KPiBZb3UgbWVhbiAibGluayBwb3J0IHR5cGUiDQo+IA0KQWNrLg0KDQo+
ID4gKyAqLw0KPiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX05PTkUgICAgIDAgIC8qKjwg
Tm90IGRlZmluZWQgKi8NCj4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9UUCAgICAgICAx
ICAvKio8IFR3aXN0ZWQgUGFpciAqLw0KPiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX0FV
SSAgICAgIDIgIC8qKjwgQXR0YWNobWVudCBVbml0IEludGVyZmFjZSAqLw0KPiA+ICsjZGVmaW5l
IFJURV9FVEhfTElOS19UWVBFX01JSSAgICAgIDMgIC8qKjwgTWVkaWEgSW5kZXBlbmRlbnQgSW50
ZXJmYWNlICovDQo+ID4gKyNkZWZpbmUgUlRFX0VUSF9MSU5LX1RZUEVfRklCUkUgICAgNCAgLyoq
PCBGaWJyZSAqLw0KPiANCj4gSW4gZ2VuZXJhbCB3ZSB1c2UgdGhlIFVTIHdvcmQgImZpYmVyIiwN
Cj4gYnV0IHdlIGFyZSBub3QgdmVyeSBjb25zaXN0ZW50LCBzbyBpdCBpcyBub3QgYSBzdHJvbmcg
b3Bpbmlvbi4NCj4gDQpBY2suIEkgd2lsbCBjaGFuZ2UgaXQuDQoNCj4gPiArI2RlZmluZSBSVEVf
RVRIX0xJTktfVFlQRV9CTkMgICAgICA1ICAvKio8IEJOQyAqLw0KPiA+ICsjZGVmaW5lIFJURV9F
VEhfTElOS19UWVBFX0RBICAgICAgIDYgIC8qKjwgRGlyZWN0IEF0dGFjaCBjb3BwZXIgKi8NCj4g
PiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9TR01JSSAgICA3ICAvKio8IFNHTUlJICovDQo+
ID4gKyNkZWZpbmUgUlRFX0VUSF9MSU5LX1RZUEVfUVNHTUlJICAgOCAgLyoqPCBRU0dNSUkgKi8N
Cj4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9YRkkgICAgICA5ICAvKio8IFhGSSAqLw0K
PiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX1NGSSAgICAgMTAgIC8qKjwgU0ZJICovDQo+
ID4gKyNkZWZpbmUgUlRFX0VUSF9MSU5LX1RZUEVfWExBVUkgICAxMSAgLyoqPCBYTEFVSSAqLw0K
PiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX0dBVUkgICAgMTIgIC8qKjwgR0FVSSAqLw0K
PiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX1hBVUkgICAgMTMgIC8qKjwgWEFVSSAqLw0K
PiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX0dCQVNFICAgMTQgIC8qKjwgR0JBU0UgKi8N
Cj4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9DQVVJICAgIDE1ICAvKio8IENBVUkgKi8N
Cj4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9MQVVJICAgIDE2ICAvKio8IExBVUkgKi8N
Cj4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQRV9TRlAgICAgIDE3ICAvKio8IFNGUCAqLw0K
PiA+ICsjZGVmaW5lIFJURV9FVEhfTElOS19UWVBFX1NGUF9ERCAgMTggIC8qKjwgU0ZQX0REICov
DQo+IA0KPiBZb3Ugc2hvdWxkIHVzZSBtb3JlIGZ1bGwgd29yZHMgaW4gY29tbWVudHMsIGF0IGxl
YXN0IGZvciBERC4NCkkgdGhvdWdodCB0aGF0IHRoZXNlIGFyZSBzdGFuZGFyZCBhbmQgd2VsbCBr
bm93bi4gU28gZGlkbid0IGFkZCBidXQgdGhlcmUgaXMgbm8gaGFybSBpbiBhZGRpbmcgY29tbWVu
dHMuIEkgd2lsbCBhZGQgdGhhdC4NCg0KPiANCj4gPiArI2RlZmluZSBSVEVfRVRIX0xJTktfVFlQ
RV9TRlBfUExVUyAxOSAgLyoqPCBTRlBfUExVUyAqLw0KPiANCj4gUGxlYXNlIGFkZCBtb3JlIHNw
YWNlcyB0byBhbGxvdyBhIGNvcnJlY3QgYWxpZ25tZW50Lg0KPiANCkFjay4NCg0KPiA+ICsjZGVm
aW5lIFJURV9FVEhfTElOS19UWVBFX1NGUDI4ICAgMjAgIC8qKjwgU0ZQMjggKi8NCj4gPiArI2Rl
ZmluZSBSVEVfRVRIX0xJTktfVFlQRV9RU0ZQICAgIDIxICAvKio8IFFTRlAgKi8NCj4gPiArI2Rl
ZmluZSBSVEVfRVRIX0xJTktfVFlQRV9RU0ZQX1BMVVMgMjIgIC8qKjwgUVNGUF9QTFVTICovICNk
ZWZpbmUNCj4gPiArUlRFX0VUSF9MSU5LX1RZUEVfUVNGUDI4ICAyMyAgLyoqPCBRU0ZQMjggKi8g
I2RlZmluZQ0KPiA+ICtSVEVfRVRIX0xJTktfVFlQRV9RU0ZQNTYgIDI0ICAvKio8IFFTRlA1NiAq
LyAjZGVmaW5lDQo+ID4gK1JURV9FVEhfTElOS19UWVBFX1FTRlBfREQgMjUgIC8qKjwgUVNGUF9E
RCAqLyAjZGVmaW5lDQo+ID4gK1JURV9FVEhfTElOS19UWVBFX09USEVSICAweDFGIC8qKjwgT3Ro
ZXIgdHlwZSAqLw0KPiANCj4gV2h5IHRoZSBsYXN0IG9uZSBpcyBpbiBoZXhhZGVjaW1hbD8gYW5k
IHdoeSAxRj8NCj4gDQo+IElzIHRoZXJlIGEgbG9naWMgaW4gdGhlIG9yZGVyIGFuZCBudW1iZXJp
bmcgZm9yIHRoaXMgbGlzdD8NCj4gDQo+IFdoeSBub3QgdXNpbmcgYW4gZW51bT8NCj4gDQotIEFz
IHN0cnVjdCBydGVfZXRoX2xpbms6OiBsaW5rX3R5cGUgaXMgYSA1IGJpdHMgZmllbGQuIEhlbmNl
IHVzZWQgdGhlIGxhc3QgdmFsdWUgYXMgb3RoZXIvdW5rbm93biBsaW5rIHR5cGUuIFdlIGNhbiBj
aGFuZ2UgaXQgdG8gZGVjaW1hbCB2YWx1ZS4NCi0gSSBoYXZlIG5vIHJlYXNvbmluZyBmb3IgbnVt
YmVyaW5nLg0KLSBZZXMsIEl0IGJlIGtlcHQgaW4gZW51bS4gTm8gc3Ryb25nIG9waW5pb24gb24g
dGhpcy4NCg0KPiBUaGFua3MNCj4gDQo+IA0KPiANCj4gDQoNCg==
