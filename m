Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E998FF60CE
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 06:22:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79F96402A9;
	Tue, 31 Mar 2026 08:22:07 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
 by mails.dpdk.org (Postfix) with ESMTP id 6594340269
 for <dev@dpdk.org>; Tue, 31 Mar 2026 08:22:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9Tgc3DIsXt+/KgshFoIJIKq4yHXSmqaTBqLB2FL4XtWNwyNrGeAQQRr90fU7PX3tobzYqFA8Wa3DGtZyEtxTVnP6rovhjtMMMhuwgqEiDw6WKIIjheite7eBmfThboGgvcFf3bpJMCqhqSWqSCF6PR8wiPixL5aOXeqjWKRiwtAHlyts8ydYzG1q8/NaGHGC36oFqp6ZaYCYzmVG7mDseq43VmlwJjNbDo9s/WbUVDnTfrr4nOOUQZ9fyRxF83MVP3pbG0sf00kDuCwr8ki1/n1BeMEWh0EnsE0nooh0yVrCtUo+A4sbIWu4lDQUD7UCMgTmLdNBC6E0ONULOnsQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpgeEsUympQJplZAPZdarTEQTvCK26oTZJgi8H9QUi0=;
 b=vEfxkLFgXZirWQ8bn0OWga5uC/wudIvY2IA24DooS27WaI1XIwH3V1xU03ewR8zJzREa0f0aJD8YAr4lQpv777wJFAfvaSEBFTUdmg/+gKbUa5G4amyxhneuaP1g070+YPFURj/s/35HQVBku/ZscnObW5NFt3Odh00HpIR38utPcfH49vH6whB4VVLgWR+ICtsTA6WZvkhIyHCY6YNDtGtmndkmipo/JuwOvKBOZ8wqcsOJtwBlq6561RcIpQCp/57yhE1Z1rvzVXm50htDXKDd1kMWV0nb4UvDTpEhmwy5I9MK5ukUla97KFS1vVv4M9Z4wcjs8zVDKPOybUlX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpgeEsUympQJplZAPZdarTEQTvCK26oTZJgi8H9QUi0=;
 b=3WXPScrl6pIn470y0Ci3MMwo9dR3zamDE5lLGZQMY9HGSrSjX2C1JhLWVbiwbvXLjEbRrMdLPF4ei6FyXl8p0fWGYw0fbLqBT2XaCqXk4nSoh0r429MPv+g5EWWOyptdLAaZZqy9+KpLkAyhR3R3sqgI5kYdx0aty5uUqhVHI5Q=
Received: from CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 06:22:01 +0000
Received: from CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::9a84:a7c:143:6f7c]) by CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::9a84:a7c:143:6f7c%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 06:22:01 +0000
From: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "david.hunt@intel.com" <david.hunt@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>, "gakhil@marvell.com"
 <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] power/amd_uncore: add e-smi installation instructions
Thread-Topic: [PATCH] power/amd_uncore: add e-smi installation instructions
Thread-Index: AQHbQhfDk1Dh89T/Ak+/8nCKNTqOX7XHpJiAgAOELpA=
Date: Tue, 31 Mar 2026 06:22:01 +0000
Message-ID: <CH3PR12MB82333EC809C55ACDBFADA6138653A@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20231219032826.4814-1-sivaprasad.tummala@amd.com>
 <20241129043207.999912-1-sivaprasad.tummala@amd.com>
 <20260328173841.32b53918@phoenix.local>
In-Reply-To: <20260328173841.32b53918@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-31T06:20:33.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8233:EE_|SJ0PR12MB6941:EE_
x-ms-office365-filtering-correlation-id: 89a04961-5a5a-4da0-b999-08de8eedd221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: i3MBMgAKutwA7Mrev5KGXS8OdJqy7+soXvNRunDBLXBWAxSDIM5qQ3WUaeLVNnHR7/gcRdiXFE2sAAmfQQkdmXXTmnQwN7/4k/1COtdcMZuUmb7Qly0Mjbv9bNLlLdoBCFIapEER87mKfoQJ3R5Y8a0jym7KPwxbkm+mktvmj2I3squjkU1c+dLzV+WUgb+cd7F/1nutt4+2eSpVT0CDjYsiDF3hTs7GbtcCZ298el2zlod+5rNNeoC6XklQeoTmt9Yt8jBYd1l3YDeOteIiUUzliXGmTyxP6cr4M7V1tgL5PjKF1PMXk2o/q/liQO7FUezijg9M0968Wd2kPgRJvCkipy39dAgqG/8PC73w4D1b2yHMnPLCf7TSkyoWoP2tZCATeFw2O/NKerf9ZYOcFA/RoDKYHkX2yaOjbfPP3ZYWTgub+i/50VtF6PG5xHo5xwiUz5h9wIAMdL24ajeOgDUhxQH4QMH6HvsNeI3AzvAinX6Ho05OKYaMWR+CGnKoWdJMjoypDtqAXjhGr4bc8JI9l8Bh9b+ADU7LwMFynuLXFntckNVlHwlhRwF8x64hn8yweQ/4iEvTy2lXtcGSeKKlJMiSFiV3VKbBK7J4LjSjiNTLh53pwJ8cfhb+VawkxbijIY3k5L01QwR9tmUU0mU87qpEIC2Fr95KT+Y/eT+oj6+9s+xk7gMscToE4wdhTNVphEN7rP6NnkxjnBhSuJAXJxnvjx3xUQ/2PEw/UuAbK7wdQNhkPSkisU1h8THDuL2VWYhq5ctgmnA77dMNqYZ8BuHHrOV37U1aYlIAK/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8233.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXN3dVpnbTlvbnorcnRENlRvREVrY0tRTW9DbVg4UURZNDZ5WVROTXhIdnNJ?=
 =?utf-8?B?MUN6cy9tMFBKcFJ4RmR1RFlKTGFNYkhsbGpXcE80WHFsNzJuTURVWll0LzQz?=
 =?utf-8?B?T1B6ZWl5Zzc1THdxQUZnSlowMS91eXJBYlBJKzNtUjdYajhoRW5GYmF6a21B?=
 =?utf-8?B?UFAwQTRTMUdmdVR2aUxISWlETmZGVWxaWUlkT2V6SWh1TFFFb0VBZ3l5amZ0?=
 =?utf-8?B?VVIwdExhdDVHZ2R0Vjc2UmltVWlmb0xLeERuWUJoTEtUQnN4ak9xSHNneHUz?=
 =?utf-8?B?WFZUR05ZYmJwMllaS1VhR0FVdTA5bjNrMFd1cUNoZWlEQm5DZkZJNFRKaXNZ?=
 =?utf-8?B?S1BBclBjSUhVK1NtUUQrTXVwL3piRUczNnBWNXpZV3FLQWlwajlCSFJEckZk?=
 =?utf-8?B?eUtzVXIwYWlzS1N3VTgrZDVvRGsyaExNMU9zZXlhWUR2bDhSbGFqK2ZEb2Mw?=
 =?utf-8?B?U21rZVFNOWxIMTJ3YjI4TzYzOHdmdUtGa2NPbVBJUC9nMEJTREtjOFhyc0Fr?=
 =?utf-8?B?d1pKcEoyVjcrb2h6Zjh5d0FvbDc0SkF0emcrL2dEamRDbmpUemZQUjZhTmhi?=
 =?utf-8?B?MXFteUlzR2JtaDFzYU5IeVAwbTlPYzE2bUFJWkhGNDhCN29qNTRVTHRuSlZ6?=
 =?utf-8?B?NkZ0dFRJZ0VMOTJRWnpXQVc4M1J3VURsam52TmR3SzNDR1kxQXBJaCtzZFhT?=
 =?utf-8?B?YmQrYUpLam4wTzBOREpnT0Y1Q1ZVQWlVcUxEalVnWlUwdVZjNGh4SCtPTTZM?=
 =?utf-8?B?azdvakhuZHJCNzFWZzdQWm1DbGlERGlvSUdSZXdtajRJM0ZwdC9VQVJteERK?=
 =?utf-8?B?ZTkza1R5RDhUOXJFcU5PaGVBWm1iU2cxN2w5WjBPRG0wa2piYlhrVHlRbHRj?=
 =?utf-8?B?Mnh0N1c0TThmeGJRRXNLdGxtTU15V1huZ3p4bXgxVFNZQ05leWNnaFA4WXJt?=
 =?utf-8?B?Rm5LbTBma3MvSVFjY2Jha2VuYWZrdGVnYXhobFhhV0FwK3o3ZjBESTRHWnhE?=
 =?utf-8?B?cFNBeU5ZM25CekRJR0M1WUFONXUwQi9HemhzYnp3TDhZbi9EcWdxUWJzN3V1?=
 =?utf-8?B?M01zQ1ZhYWhDZklwUG1CaHk2dDVUSnU4YzdzSkd2QmpGOG54enE2WHZPalVX?=
 =?utf-8?B?T0liUHdOQldEM3NvR2hndW9YWkVULy9GTE5MVHRZR2xLNkpvc3QveTE2MjZ3?=
 =?utf-8?B?bTJ5SFFJUVVKOU11VlZLOUkxNldTZXM5RUtvbW02ZVZVYzViRnJBMEZCNW5V?=
 =?utf-8?B?RWR1NmhVOHhuOFNmQXFVZ2JPTnUyVDE0S0YrRXR2bFd1NGtjMnBDN2tIRUph?=
 =?utf-8?B?NkhwcXB1T3FIWEJaejdGVzFQZGdFd0JqOGRQYUw0UlJwdU13NFJyVTVRZjNE?=
 =?utf-8?B?MmpRZjRQOXZFSlZqSUdhYm15UUppK3hEbXFLSjB2d0JFQnlCR1djQlpoSTZn?=
 =?utf-8?B?dEMvSnAwaHpFa0NmZDJFZCtLRTVhN0c0K1VuV0pPNHlGWHFKK3VKUGpNL0RG?=
 =?utf-8?B?RHN3dG56QlY2THh4cjFyTzRZTDFORm5NZXA1QVlFcURIL3RtNzZpaXozY2Rv?=
 =?utf-8?B?YzV4dDArZUZCZHNjNDFVSlVJalI5cXZGL0Z3dUpYU1FoVEVNczRRMGYxVDZr?=
 =?utf-8?B?OWY1dzAwMUZCUWhBZmVMMHpOUktxdE5TaXBWdjJqQm1weE5ZbVpsclVGMkVZ?=
 =?utf-8?B?WHJHekEwemxpTnVCWmlodU5Ob2t1K2o4N1FtQUtyOHVxeG83UWV3eUd4aFNY?=
 =?utf-8?B?bThrbmsxa3ovaVJzR2xXVVhvMXU4dGFuVnNSQ29NMG1BSTRpTmlkOTVQSnVD?=
 =?utf-8?B?ZFBEbW1udzU5TDlIcXFxMzkwT3kxMlNGTFloNTFORlNmWjUwOGcvRFlOeUx3?=
 =?utf-8?B?bWdMRnlQeGZoSnZYTnNBaXArZkFyRmlXSlVoVUFkR1FqSTEvQXY2ekZ5dnNa?=
 =?utf-8?B?OGFteFNDbnJ2dlFwYU1Vai84QzRGeVJPM3EzaVFLdlErS1RHaU1mbW9Ob1lM?=
 =?utf-8?B?QmtpeDVSNWRlUTN1YSsvMFpOQnFiYlVMVzdiYkJydmxCVzB5TXFmRkdUR0Vm?=
 =?utf-8?B?aFpsWW5lNjl4NnFsc2RiWTJiRkNFaWk0bFhmYjhKYnJTNzd4QmdsSStic0x4?=
 =?utf-8?B?Q1dvU09nMWRRbjMzUEY2cFlhbDhBaVRqeDR1aEVVanA3WWR3cnE0Rytpb1JW?=
 =?utf-8?B?RnRyeEpLdnE2eWNIU2kxOWNucUovcWdlSDMwVGtEWmZNS2luMDBYYThLbXFT?=
 =?utf-8?B?L3lmQXJ3OHpDMnNscElTMmRZYm9MSkplZStWc2xtaVVQQ2FPTXYyOUxKMTl4?=
 =?utf-8?Q?2eVZGr8jqACJMUDOan?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8233.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a04961-5a5a-4da0-b999-08de8eedd221
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 06:22:01.6965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3SWQPCRWF1jnXN4p295aai7eaQzphV8eU6dB9owsRZDAR7RGzpXnHnSsgTflKV4CZtjEQge7u9AWAQ5NYsOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgU3RlcGhlbiwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBQbGVhc2UgZmluZCBt
eSByZXBseSBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
U3RlcGhlbiBIZW1taW5nZXIgPHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPg0KPiBTZW50OiBT
dW5kYXksIE1hcmNoIDI5LCAyMDI2IDY6MDkgQU0NCj4gVG86IFR1bW1hbGEsIFNpdmFwcmFzYWQg
PFNpdmFwcmFzYWQuVHVtbWFsYUBhbWQuY29tPg0KPiBDYzogZGF2aWQuaHVudEBpbnRlbC5jb207
IGFuYXRvbHkuYnVyYWtvdkBpbnRlbC5jb207IGplcmluakBtYXJ2ZWxsLmNvbTsNCj4gcmFkdS5u
aWNvbGF1QGludGVsLmNvbTsgZ2FraGlsQG1hcnZlbGwuY29tOyBjcmlzdGlhbi5kdW1pdHJlc2N1
QGludGVsLmNvbTsgWWlnaXQsDQo+IEZlcnJ1aCA8RmVycnVoLllpZ2l0QGFtZC5jb20+OyBrb25z
dGFudGluLmFuYW55ZXZAaHVhd2VpLmNvbTsNCj4gdGhvbWFzQG1vbmphbG9uLm5ldDsgZGV2QGRw
ZGsub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHBvd2VyL2FtZF91bmNvcmU6IGFkZCBlLXNt
aSBpbnN0YWxsYXRpb24gaW5zdHJ1Y3Rpb25zDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBv
cmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4g
d2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4N
Cj4NCj4NCj4gT24gRnJpLCAyOSBOb3YgMjAyNCAwNDozMjowNyArMDAwMA0KPiBTaXZhcHJhc2Fk
IFR1bW1hbGEgPHNpdmFwcmFzYWQudHVtbWFsYUBhbWQuY29tPiB3cm90ZToNCj4NCj4gPiBBZGRl
ZCBzZWN0aW9uIGZvciBpbnN0YWxsaW5nIGFuZCBidWlsZGluZyB0aGUgRS1TTUkgbGlicmFyeSBm
b3IgQU1EDQo+ID4gRVBZQyBVbmNvcmUgc3VwcG9ydCBhbmQgdmVyc2lvbiByZXF1aXJlbWVudHMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaXZhcHJhc2FkIFR1bW1hbGEgPHNpdmFwcmFzYWQu
dHVtbWFsYUBhbWQuY29tPg0KPg0KPiBBIGxvdCBoYXMgY2hhbmdlZCBzaW5jZSB0aGlzIHBhdGNo
IHdhcyBvcmlnaW5hbGx5IHN1Ym1pdHRlZCwgYW5kIGFwb2xvZ2llcyBmb3IgdGhlDQo+IGxvbmcg
ZGVsYXkgaW4gZ2V0dGluZyBiYWNrIHRvIGl0LiBUaGUgRS1TTUkgbGlicmFyeSBpcyBpbiBtdWNo
IGJldHRlciBzaGFwZSBub3cg4oCUIGl0J3MNCj4gcGFja2FnZWQgaW4gRmVkb3JhIGFuZCBFUEVM
LCB2NC4yKyBidW5kbGVzIHRoZSBhbWRfaHNtcC5oIGhlYWRlciB0aGF0IHdhcw0KPiBjYXVzaW5n
IGJ1aWxkIGZhaWx1cmVzLCBhbmQgdXBzdHJlYW0gbm93IGhhcyBwa2ctY29uZmlnIHN1cHBvcnQu
DQo+DQo+IFBsZWFzZSByZXZpc2UgdGhlIHBhdGNoIChhbmQgdGhlIG1lc29uLmJ1aWxkKSB0byBt
YXRjaCBjdXJyZW50IEUtU01JIHVwc3RyZWFtLg0KPiBUaGUgZGVwZW5kZW5jeSBjaGVjayBzaG91
bGQgdXNlIGRlcGVuZGVuY3koJ2Vfc21pJywgcmVxdWlyZWQ6IGZhbHNlKSB2aWEgcGtnLQ0KPiBj
b25maWcgcmF0aGVyIHRoYW4gdGhlIGJhcmUgY2MuZmluZF9saWJyYXJ5KCkgdGhhdCdzIHRoZXJl
IG5vdy4NCj4gVGhlIGN1cnJlbnQgRVNNSV9oZWFkZXIgdmFyaWFibGUgaW4gdGhlIGJ1aWxkIGZp
bGUgaXMgZGVmaW5lZCBidXQgbmV2ZXIgdGVzdGVkIOKAlCB0aGF0DQo+IHNob3VsZCBiZSBjbGVh
bmVkIHVwIHRvby4NClVwZGF0ZWQgcGF0Y2g6DQpodHRwczovL3BhdGNoZXMuZHBkay5vcmcvcHJv
amVjdC9kcGRrL3BhdGNoLzIwMjYwMzMxMDQwOTU4LjEyNjg2OS0xLXNpdmFwcmFzYWQudHVtbWFs
YUBhbWQuY29tLw0KPg0KPiBGb3IgdGhlIGRvY3VtZW50YXRpb24sIGp1c3Qgc3RhdGUgdGhlIG1p
bmltdW0gRS1TTUkgdmVyc2lvbiByZXF1aXJlZCBhbmQgbGluayB0bw0KPiB0aGUgdXBzdHJlYW0g
cHJvamVjdC4gTm8gbmVlZCB0byByZXByb2R1Y2UgYnVpbGQgaW5zdHJ1Y3Rpb25zOyB0aGF0J3Mg
dGhlIHVwc3RyZWFtDQo+IHByb2plY3QncyBqb2IsIGFuZCBkaXN0cm8gcGFja2FnZXMgbWFrZSBp
dCBldmVuIGVhc2llci4NCj4NCj4gSXQgd291bGQgYmUgZ3JlYXQgdG8gZ2V0IHRoaXMgdXBkYXRl
ZCBpbiB0aW1lIGZvciB0aGUgMjYuMTEgTFRTIHJlbGVhc2UuDQpUaGFua3MgZm9yIHRoZSBzdWdn
ZXN0aW9uLiBJIHdpbGwgZm9sbG93LXVwIG9uIHRoaXMgYW5kIHNlbmQgYW4gdXBkYXRlZCBwYXRj
aCBmb3IgdGhlIHNhbWUuDQpJdCB3b3VsZCBiZSBncmVhdCB0byBnZXQgdGhpcyB1cGRhdGVkIGlu
IHRpbWUgZm9yIHRoZSAyNi4xMSBMVFMgcmVsZWFzZS4NCg==
