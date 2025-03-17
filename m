Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF5C35FF8
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 20:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0983C402EB;
	Mon, 17 Mar 2025 21:10:16 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11022105.outbound.protection.outlook.com
 [40.93.200.105]) by mails.dpdk.org (Postfix) with ESMTP id 89D8A402D0
 for <dev@dpdk.org>; Mon, 17 Mar 2025 21:10:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeJgE2/HUEIJ4bFkWYUlaNtETQS2QstuCWUs/tsALUhAGH43unKvrdxhNp/jiw+s+ujSVkCdwtucpUXP9UlHeULThT7YM5fCee6yKS2Fts4vz6pEtu4ydYnmeyZk6lRgB2+erzXtirSC9wmao6NYTYOiOafRTpTKw+bLjA2CBS0pBWriRrdM48tMptJyLj8D5lRTFQwkTtv7MbDh2Aq1XXONw4sdoK+VnwbUUVQ3L35baOMC29lxULzmyOeaajrIURmNtwbnLoGF6jQHMCiyRA3WQ6K/G4A0zI3rENqRtQewj5YfxWJ4wqLyLp5RsL7C74nM5K5b4XoZH3rOpoeXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUfxtThzRck9UiLonXjYGItWYZs7A/3+sXNp2gpA1Vk=;
 b=tgV6iiigDIaqlqKk+T1c8AuVuwHt+X2oCIEwhiW9t/gZNKV3aA3P4F5aNlw8k+9wXVXd0U8FNXcNecbZccNXfsGhVaevfagM6lg2mFDGRw3BpjUO9cNBIubO/O1jqRSUvWbpKIAiWMtm5oPuidWVfYeQZI1FCzG2MGWj2JbOa0MOGQGIHIiJhRZ9zgatKFO3GJw6hPGps56HlA5gD3vlm7rr2CAdoVn/OvH0I9lGlKGwpSE+zZENV09qVvojH5+E7Dci44PCPbEDizPdOp9qOfOyzqyyzpbKAxOG78B64Oq4uD19KQ4eV7a210kTb/GXw62/m1Eq6JlsPkbgyiWZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUfxtThzRck9UiLonXjYGItWYZs7A/3+sXNp2gpA1Vk=;
 b=dlRo27k3OBbOpp4S3qOqhcKjfksk1+VB6UecFtvK2UQZQx/2L6LAxrUA/KVyRc5zh3iz09K1mRwGA2qB7FqBf3s0kLJyYVEL/7zgzEvAEP8Z6hw9ZexGbmg2C2gAiMA1AdYD5mz8L/R1jvXtOGlo8ESB38w9VoZedDk1nNm27A4=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4261.namprd21.prod.outlook.com (2603:10b6:806:417::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.8; Mon, 17 Mar
 2025 20:10:11 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::ebfa:8e51:9b6f:f94a%6]) with mapi id 15.20.8558.016; Mon, 17 Mar 2025
 20:10:11 +0000
From: Long Li <longli@microsoft.com>
To: David Marchand <david.marchand@redhat.com>, "longli@linuxonhyperv.com"
 <longli@linuxonhyperv.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu
 <weh@microsoft.com>, Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [EXTERNAL] Re: [Patch v2] doc: announce bus/vmbus API changes
Thread-Topic: [EXTERNAL] Re: [Patch v2] doc: announce bus/vmbus API changes
Thread-Index: AQHblyGCcqvBfe5ZK06MKWQt+pFEYLN3wtJA
Date: Mon, 17 Mar 2025 20:10:10 +0000
Message-ID: <SA6PR21MB42318BD6FD51F94A43E9C26ACEDF2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741998895-31065-1-git-send-email-longli@linuxonhyperv.com>
 <CAJFAV8zbV=YY+_mLs-+ZJquhzfkw_RJi2sSGrz4RcSqh8k3hjQ@mail.gmail.com>
In-Reply-To: <CAJFAV8zbV=YY+_mLs-+ZJquhzfkw_RJi2sSGrz4RcSqh8k3hjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=28fe51d7-a716-4841-bafa-337141492143;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-17T20:09:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4261:EE_
x-ms-office365-filtering-correlation-id: ffca70a7-b140-4fae-f1e0-08dd658fb8b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YWZ2UGNFRXZrUnk0SGx1am9pRkVkNnE1UVpOQ3hpZnBkeFUzMS9YSVZMUDZq?=
 =?utf-8?B?Zm1yQit6ckNoa09oUW9PRVZwLzVxWWZEM242MUlETzEybkp2RnpCMFFDVGJa?=
 =?utf-8?B?TFI5ek5WRHBGNjdhY0pBd21heDNpQTFjY0NLajRKK1dXRGxvNWdOM0poSmlx?=
 =?utf-8?B?VG5Ednk1TXA0VFBzeXJ5WTRqU0pDV0lVKzR5d0h2OW5md1dDZmQrZ2F1K084?=
 =?utf-8?B?RVhiRm5RRUUyMjNLMkNLcnhnaC8vVHZ0UnBkREdWeHhwbGYxb21DUGpTbEZq?=
 =?utf-8?B?cGZ3OVU3N1BGaS94eTlGZk1hdGtyWFFBdVh0bXB5LzlrR24xTXBucFNaak9v?=
 =?utf-8?B?SFlmZ3IrL1dFaUdGZmNGaFBMYUs4dXgzR0ludHhoQW5oQ2U4c25wZ21ORUF4?=
 =?utf-8?B?U1JWRXVDd2NVMk1MczYrUjVYUjFiU1RMN2NzNEFnYjEwdFEvbjFpZTZDOEZh?=
 =?utf-8?B?YmJnVXU4TVdKYW5yQW5TKzBabERQeHFDZE1mOEh4bXFqOFY4TWhYSTBKVXEr?=
 =?utf-8?B?OXFIQUU1dFBDM3dPdjIvMkxucXhLSm1PbHd4TGtWK3g0dkRkZUlNN1Z3M2Vj?=
 =?utf-8?B?dDgwem5ndVlpeE5FNy81SE11WHhKR0p2Vkc2Rk1ldmVYNDcyZHlOVUZqVW1k?=
 =?utf-8?B?TlRBRU9FTkJ2VlJkdXVCZ2pad0RBcDhyNnBRdGUzSm0vR2Y4WnZ0TUFjMnJt?=
 =?utf-8?B?czh6SlJWeXQ0VCtNNzZ6a3dXTFRTZTc2QWExTitnT1BtdnZMTVlmYWFZYTQz?=
 =?utf-8?B?KzNCRENDYUs2aGU0RXhRazhVVFNnalZpazlRSHJRS3VWbE8xaTVwVkl3TE5k?=
 =?utf-8?B?TFJEUzJwUUlrNFJBaTdUMjcxUEZUb0xpSWxTWHovV2drYlhudlAzdEp6YXlH?=
 =?utf-8?B?MEJmZkM0OHBUQjJyb3RSQUsrbGlwRmJrK0lLQVduN1JDTm8vdTVEUXNOSkNQ?=
 =?utf-8?B?bFpYK05PVXRBcDJmMmhDc00zaWdDdTZuUkZCMUxsYXJBT3NOTEdiS0lDeXF1?=
 =?utf-8?B?UVYwWFlnRURDRHVEZVlEZFhpYzJiOHpmd0VSUmpZMEtkWmxEMTltNmNUSVRk?=
 =?utf-8?B?VDFkMUdGM00xbU8ycmptSjdZQUtqOTdxNTZxYW9iczN6cjFxT0pGODlGTWlW?=
 =?utf-8?B?NnVEbHd5a28wcWlHaVVDQ3N2M0NaU2FudmF6WXZSVzVFbTZYN3dCYXUxeFlt?=
 =?utf-8?B?aXQ1c2lOdnFud1pvQi9SV0NJTkZqM2t5STFCdGh2MWJlSng2S2dPT3JGb01v?=
 =?utf-8?B?UXdhZjcxVk85STM5NHFtMEpjT2JXSWZXcTdvekpwQm1OTERkeGtjSjZsMnVD?=
 =?utf-8?B?UlNJQ2JoRkJNOUdReTl6RGdxbEdmcXgxVEo3MkJQV3VCUE9HOG1WSTZ3TzF0?=
 =?utf-8?B?eE84QkVYSmkxZW1seWpWRWZpNzhiQkhFaWIvR1J4djdGUUxiNUhaWms4aXhL?=
 =?utf-8?B?SmZ3LzdJODh5Nzdhekp5ejBUYTBackViVmJvMXFOeCtZU1lNTzhUNXpQL0Jz?=
 =?utf-8?B?SVUvM1Q4SjV0UkU3RWlxYUd6dFBJVVQ0R0ovK1RoNk1PaWtjQzBvVnJBV1Vj?=
 =?utf-8?B?MXlHYkxIa0pQbzM1VHNSQTNVTXdUQzN0dVRkdXEzeTRVRngzWlNac25NSEVW?=
 =?utf-8?B?QjIvSWVEREJpa3U4TUtZNVliRXBTU0w1bGJvVmVNczZNR2ppS1RHa3hBNTQr?=
 =?utf-8?B?RWU1N25jRDFXLzUwV3JqOWRieWNGenBKb3RHVE1ObFIycUhVMmVxbFE4emJr?=
 =?utf-8?B?dElHa2RoTVpXSDRPWjExOUpoSk85b3NNWFJ0ZWh5eVpsdHBneXEyaWp0RFJM?=
 =?utf-8?B?dHpaWXJnNWpqREU3bUsvdFFQTTNXNTlpdzYrVXNzYkZtOGNZTXZvUlBjMDh6?=
 =?utf-8?B?NjRsMHY4NjBBN1IzZVdtQlRoODBJcXRtQTJHeHEyQnc0TnRCY1VhU2JXSitS?=
 =?utf-8?Q?srFUEVxu2zMz+eE5P3cOBCwRY38VfDL6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR21MB4231.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amlDM0twOWROeEowNXI3aklyakZXR3VQRDNVN1JENE5nQ0tmSFZ2SUVEbnZn?=
 =?utf-8?B?NThFdDB5RGhrL2xQdTBVZHNjTmdwelR5QWxBS3hNQVIzUlBLSGV1dE9aQlk2?=
 =?utf-8?B?RXRvQUdpcElmMlIxakE4TFp1SjRBbk02QVJFTFRGeFdQZ2Ryd1N0L0wzQ0kw?=
 =?utf-8?B?dEdCTlNGeFlJWCtPTHp2NndEay9wSDJFbEJ4T1p0cURsTlZLYUhXZ2p6b2xp?=
 =?utf-8?B?ckdHOFRIN3JNWlZwcU1WVjJWSElwUHZROWhPeHc0V0l2K1Q5OUlvaVRjaVhw?=
 =?utf-8?B?d0hXQjhyWDh4emkxdndRYU5vamFwcW4raHkzUG1DcFlwQzk4KzIrTVZoUXZm?=
 =?utf-8?B?SzZEN2hPMHN0a1FwU2o3S3RiMUpKQUdrWVE5N25qa0xsSFRRTGFFclcxeVJU?=
 =?utf-8?B?d0FLdDFOZ1VEdjM0cFZsNzNLeEZzZ3JkVTNTOUhhb3lraEFJbVF5UW5tMTdu?=
 =?utf-8?B?RFNvdkl0NWpDdjgwc1A2U0F0YjVkYkhVUGw4RFMzZDgvU2JuOUpLQlNXT0ZH?=
 =?utf-8?B?enlMZFQ1WVFZVXY1cDBZY3JwdWVpSWJEdC8rVFlsb2laTTVhZWdpWmt1QUxK?=
 =?utf-8?B?WDdGQ2g3SEVuV3dnS1JReVFhTnhqUjUxYkgwbnlUQW04NkVtWVRsZmRnQWZX?=
 =?utf-8?B?L3NYRSt0eFA5L0FUbzUwbW0rbTZyNTYxZ0N3bS9nSDNodk5QRHBvZUhITFZ3?=
 =?utf-8?B?MXBJK25sQkRDdmRnVk5WNlU1ZE1ncHkvN2hSWVpGQzJBZC9ETmUrQ2l2Uzl3?=
 =?utf-8?B?WmVHMGlkRlJvKytMOTNnMy9FWVIyZ0ZRSVhsOGpSTTJtdjErcS9YRnBvcFA4?=
 =?utf-8?B?UU5iaUozMVk1R2YxTmJQUGU0VFFDRmM5ZU12OFJ4N1lxQUo1RlFWRGVqV2Iv?=
 =?utf-8?B?azgzR0hERkxSaCt3aUlWUTFMSjNmR3YvNWp6eDk5RXM3WHozNnNrbW5pQ1ZP?=
 =?utf-8?B?RzA2ako4ZVNYdU00N2Z3WDdIaENwUXVFdnpsb2IwWE5YNElPTmxvMm9IazNy?=
 =?utf-8?B?Njk0SDFjZ2kzUUFsc0RkbmJvZlZjWW5FRDBpQndFZ0pUWjNDZGhjSDVLa3Ni?=
 =?utf-8?B?Vmd1dUlrQjFmbk5NRVd3S1NzYThFWG5TRmg5aytRSGFvWUZ2bmc3blFOUzFG?=
 =?utf-8?B?SEg3UzFyVXhQdDhoU1MraFJaNVI5c0FlYmpaNnUxZHZiWnl3Q1U2T0lXcktG?=
 =?utf-8?B?NkFGajlub0pXMzU3ZC9yUjBLMG5qK3ZkMXNUWmduSjVXczh3aXZSMkpBQ052?=
 =?utf-8?B?L004ZGx5TENVOHVlRWlhUk1vcjQxZTJjeFQxUE9Oc0duck5KRkp6ZlAvamUz?=
 =?utf-8?B?YS9JOXRaVEVqMTFHOVcreGoxNVdFTmVNK2tYQm5nOTVBK3piVkRNT1c5N1NO?=
 =?utf-8?B?RWlZR2haVXV6Ykx0dU9TRElHbFVDd0NwSHE5QS9STnNLZXQ5bkNEeElCNFY2?=
 =?utf-8?B?MjdjZ3lLMzcrZEN5YUJjNVdTSUlOTHpWaXJaNURyU3FVQUl0UFcwaUhBREhN?=
 =?utf-8?B?QkEyemRzUG1YTWorRWpQbEEvNG1GU1k1djA4VEM5cHdPalJFNHpWYm50Ky9q?=
 =?utf-8?B?eDRaellVRXE3b1JOcVNHdjRTU0k0Um1tczlBZTFtdEpQWHExMGI1dGl0MFZo?=
 =?utf-8?B?ZEVyWFJLR0xHL1N0bFhmbUE2TmcvcGxuWnBBQUNobnlnRGFPVFNsRzV5K21U?=
 =?utf-8?B?ZkMxb1JmZGRBM3kwSkJuMzNUd0JGQ3dQdmJ1SjdRTEVBMzZHZGxQVFVocU52?=
 =?utf-8?B?anhDalpJeDJ6SE1UUEJpUnlrMmFKQlVTZ0syVDc3UnkwSVJhS1hGVitiVW5v?=
 =?utf-8?B?akxNQUdKUXN3U2hmeWFSc0FnWWgzTmF2SFJQY1Z2ZFMrdU80cHp5b2p5eUlB?=
 =?utf-8?B?bjQwOGhXYTY3TUJVK0VLNVZnTFdFWmM3Q2d6SGJXUWpnRlY3azlSWjVFVXlF?=
 =?utf-8?B?cFhLRjNHV3hnUGFaUUVGNDI3ODRJVlk3YUZLWjE4dFVYZE1QZnJxRmpnaEdt?=
 =?utf-8?B?Q0dObUJ5S0ZmbTc1RmJ3TWdzc29yVFdFSllhMzd1a01tcnE5VTdoS2IyRW9r?=
 =?utf-8?B?QkFhVzhjQXlIVUNaenprRlc5UUdvdGR5czlVaUhCdi8vODlTdzNSVE9YQ0Fu?=
 =?utf-8?Q?nRKH63BTlGmfdTu/NP9DeRkCh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffca70a7-b140-4fae-f1e0-08dd658fb8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 20:10:10.9372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xR9nfTWBvusoL62YsaVVeeN8ZAkJ33eCmu4hZMZJ/8Q6nWHYp9RB74mRi96fu8Uao30qdfT/TMkOcaLbi7A2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4261
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTWFyY2hhbmQg
PGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTcsIDIw
MjUgMjo0NyBBTQ0KPiBUbzogbG9uZ2xpQGxpbnV4b25oeXBlcnYuY29tDQo+IENjOiBTdGVwaGVu
IEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+OyBXZWkgSHUNCj4gPHdlaEBt
aWNyb3NvZnQuY29tPjsgVGhvbWFzIE1vbmphbG9uIDx0aG9tYXNAbW9uamFsb24ubmV0PjsNCj4g
ZGV2QGRwZGsub3JnOyBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDog
W0VYVEVSTkFMXSBSZTogW1BhdGNoIHYyXSBkb2M6IGFubm91bmNlIGJ1cy92bWJ1cyBBUEkgY2hh
bmdlcw0KPiANCj4gT24gU2F0LCBNYXIgMTUsIDIwMjUgYXQgMTozNeKAr0FNIDxsb25nbGlAbGlu
dXhvbmh5cGVydi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1p
Y3Jvc29mdC5jb20+DQo+ID4NCj4gPiBBbGwgdm1idXMgQVBJcyBhcmUgdXNlZCBpbnRlcm5hbGx5
IGJ5IERQREsgY29yZSBhbmQgbmV0L25ldHZzYyBQTUQuDQo+ID4gSXQncyBub3QgZmVhc2libGUg
b3IgcHJhY3RpY2FsIHRvIHVzZSB0aG9zZSBBUElzIGJ5IHRoZSBhcHBsaWNhdGlvbi4NCj4gPiBU
aG9zZSBBUElzIHdpbGwgYmUgbW92ZWQgZnJvbSAiRFBESyIgdG8gIkludGVybmFsIiBpbiBEUERL
IDI1LjExLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29m
dC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlIGluIHYyOg0KPiA+IGFkZCBkZXRhaWxzIG9uIHdo
YXQgQVBJcyB3aWxsIGJlIGNoYW5nZWQNCj4gPg0KPiA+ICBkb2MvZ3VpZGVzL3JlbF9ub3Rlcy9k
ZXByZWNhdGlvbi5yc3QgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kb2MvZ3Vp
ZGVzL3JlbF9ub3Rlcy9kZXByZWNhdGlvbi5yc3QNCj4gPiBiL2RvYy9ndWlkZXMvcmVsX25vdGVz
L2RlcHJlY2F0aW9uLnJzdA0KPiA+IGluZGV4IDNmNWYwZTk0OWMuLjBmZjdkZDY5Y2QgMTAwNjQ0
DQo+ID4gLS0tIGEvZG9jL2d1aWRlcy9yZWxfbm90ZXMvZGVwcmVjYXRpb24ucnN0DQo+ID4gKysr
IGIvZG9jL2d1aWRlcy9yZWxfbm90ZXMvZGVwcmVjYXRpb24ucnN0DQo+ID4gQEAgLTEzOCwzICsx
MzgsMjcgQEAgRGVwcmVjYXRpb24gTm90aWNlcw0KPiA+ICAgIHdpbGwgYmUgZGVwcmVjYXRlZCBh
bmQgc3Vic2VxdWVudGx5IHJlbW92ZWQgaW4gRFBESyAyNC4xMSByZWxlYXNlLg0KPiA+ICAgIEJl
Zm9yZSB0aGlzLCB0aGUgbmV3IHBvcnQgbGlicmFyeSBBUEkgKGZ1bmN0aW9ucyBydGVfc3d4X3Bv
cnRfKikNCj4gPiAgICB3aWxsIGdyYWR1YWxseSB0cmFuc2l0aW9uIGZyb20gZXhwZXJpbWVudGFs
IHRvIHN0YWJsZSBzdGF0dXMuDQo+ID4gKw0KPiA+ICsqIGJ1cy92bWJ1czogU3RhcnRpbmcgRFBE
SyAyNS4xMSwgYWxsIHRoZSB2bWJ1cyBBUElzIHdpbGwgYmUgbW92ZWQNCj4gPiArICBmcm9tICJE
UERLIiB0byAiSU5URVJOQUwiIGluIGRyaXZlcnMvYnVzL3ZtYnVzL3ZlcnNpb24ubWFwLg0KPiAN
Cj4gTml0OiBJIHdvdWxkIG5vdCBtZW50aW9uIHZlcnNpb24ubWFwOiBpdCBpcyBqdXN0IGFuIGlt
cGxlbWVudGF0aW9uIGRldGFpbCAob2YNCj4gc3ltYm9sIGV4cG9ydHMvdmVyc2lvbmluZykgdGhh
dCB3aWxsIGJlY29tZSBvYnNvbGV0ZSBpZi93aGVuIG15IHJld29yayBnZXRzDQo+IG1lcmdlZC4N
Cj4gaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGcGF0Y2h3b3INCj4gay5kcGRrLm9yZyUyRnByb2plY3QlMkZkcGRrJTJGbGlz
dCUyRiUzRnNlcmllcyUzRDM0ODI4JTI2c3RhdGUlM0QqJmQNCj4gYXRhPTA1JTdDMDIlN0Nsb25n
bGklNDBtaWNyb3NvZnQuY29tJTdDOWEzNDdjZmZlNjg2NGUwZWQzYTMwOGRkNjUzOGENCj4gMjJj
JTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCU3QzYzODc3ODAxNjEx
Mzc1MzMNCj4gNjMlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlk
V1VzSWxZaU9pSXdMakF1TQ0KPiBEQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJD
SXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyUNCj4gN0Mmc2RhdGE9RmxWWHhPVkU0JTJCUkRM
WDROaG4wbTNJZ3UlMkIlMkJsWE1seTdPTVphZmhBaGdZRSUzRCYNCj4gcmVzZXJ2ZWQ9MA0KPiAN
Cj4gDQo+ID4gKyAgVGhvc2UgQVBJcyBhcmUgdXNlZCBvbmx5IGJ5IERQREsgY29yZSBhbmQgbmV0
L25ldHZzYyBQTUQuDQo+ID4gKyAgVGhlIGZvbGxvd2luZyBBUElzIHdpbCBiZSBtb3ZlZDoNCj4g
PiArICBydGVfdm1idXNfY2hhbl9jbG9zZQ0KPiA+ICsgIHJ0ZV92bWJ1c19jaGFuX29wZW4NCj4g
PiArICBydGVfdm1idXNfY2hhbl9yZWN2DQo+ID4gKyAgcnRlX3ZtYnVzX2NoYW5fcmVjdl9yYXcN
Cj4gPiArICBydGVfdm1idXNfY2hhbl9yeF9lbXB0eQ0KPiA+ICsgIHJ0ZV92bWJ1c19jaGFuX3Nl
bmQNCj4gPiArICBydGVfdm1idXNfY2hhbl9zZW5kX3NnbGlzdA0KPiA+ICsgIHJ0ZV92bWJ1c19j
aGFuX3NpZ25hbF9yZWFkDQo+ID4gKyAgcnRlX3ZtYnVzX2NoYW5fc2lnbmFsX3R4DQo+ID4gKyAg
cnRlX3ZtYnVzX2lycV9tYXNrDQo+ID4gKyAgcnRlX3ZtYnVzX2lycV9yZWFkDQo+ID4gKyAgcnRl
X3ZtYnVzX2lycV91bm1hc2sNCj4gPiArICBydGVfdm1idXNfbWFwX2RldmljZQ0KPiA+ICsgIHJ0
ZV92bWJ1c19tYXhfY2hhbm5lbHMNCj4gPiArICBydGVfdm1idXNfcHJvYmUNCj4gPiArICBydGVf
dm1idXNfc2Nhbg0KPiA+ICsgIHJ0ZV92bWJ1c19zZXRfbGF0ZW5jeQ0KPiA+ICsgIHJ0ZV92bWJ1
c19zdWJfY2hhbm5lbF9pbmRleA0KPiA+ICsgIHJ0ZV92bWJ1c19zdWJjaGFuX29wZW4NCj4gDQo+
IFNvIGFsbCBzeW1ib2xzIGZyb20gcnRlX2J1c192bWJ1cy5oIGhlYWRlciBiZWNvbWUgaW50ZXJu
YWwuDQo+IA0KPiBBcyBwYXJ0IG9mIHRoZSBtb3ZlIGR1cmluZyAyNS4xMSwgdGhpcyBoZWFkZXIg
d2lsbCBoYXZlIHRvIGJlIHJlbmFtZWQsIGFuZA0KPiBtb3ZlZCB0byB0aGUgZHJpdmVyX3Nka19o
ZWFkZXJzIGxpc3QgbGlrZSBvdGhlciBidXNlcyAoc2VlIGJ1c19wY2lfZHJpdmVyLmgsIGZvcg0K
PiBleGFtcGxlKS4NCj4gS2VlcCB0aGlzIGluIG1pbmQgd2hlbiBkb2luZyB0aGUgQVBJIGNoYW5n
ZSBkdXJpbmcgMjUuMTEuDQo+ICh0aGlzIGlzIGp1c3QgYSBoZWFkcyB1cCwgd2UgZG9uJ3QgbmVl
ZCB0byBtZW50aW9uIHRoaXMgcG9pbnQgaW4gdGhlIGRlcHJlY2F0aW9uDQo+IG5vdGljZXMpDQo+
IA0KPiANCj4gT3RoZXJ3aXNlLCB0aGlzIGNsZWFudXAgbGd0bS4NCj4gVGhhbmtzLg0KPiANCj4g
LS0NCj4gRGF2aWQgTWFyY2hhbmQNCg0KVGhhbmsgeW91Lg0KDQpTZW50IHYzLg0KDQpMb25nDQo=
