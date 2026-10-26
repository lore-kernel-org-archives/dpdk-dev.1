Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F960A261A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=XLFZrsRn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB9A640151;
	Mon, 26 Oct 2026 10:41:39 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
 by mails.dpdk.org (Postfix) with ESMTPS id E321440150
 for <dev@dpdk.org>; Mon, 26 Oct 2026 10:41:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jawCJTh2T9jGl4TDnfFGOnVU/l+GZoo56/dbCTwGszuJvDXrn1y+7BgpMTUB/yWB9Zl4JKLvpNiRtIhv+kvnwb62QE1zyU7JszcJJyC0/fLu2dbYoJUVIFI6jyuME5uOv5j5GsT71DJvcdulPYv/l9z4QuqdNl4cWvguJmB0dGDIDn/4xtpzrRkXZNwqpMTuvyONCHPSTClfw2iVoDdDdPwlP1Tny2x43lBdCRKR1r3GZaVZTQZz+e48wziQEbVND13P+djuvJwN02uxPwnxUxxC+ovnvu5h5d7xEj3w2ODXL8KPw3EE+hqOAkTLlbqqDi6/R3WCA7djNZizkbbIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MbiJRFdtpX73+og0cKxwNiGCwWKkZvdHQoILLRimSA=;
 b=lIIZ0+P8ufP7sHgxzQeez9K6iwxpyJba9xbG5tvgi1K2qzUP0+My7FR6F3LCaUBDAQ03kqjzw/pGTIb5Dh/dCk+jtnA41f+cJu6pcPlyQtCvKHq0ltSumGDpZClEtNS/9+mPxTZ46iMKkqKzVx2tsosoWFl/REYbt/WE16fXq2FPHYACLfYy2+xFPZmKL69SzRLnjc5ThLCkqXbSPdrUlFds2lRB/vGuHNbwAIT82VR9m5EZdGzRv/G5QVNTxgguMbBiNw1KlxATlxtgIyDFu3HTV/xIXLmkumpekNIGMsOpt8Q9W8CP3XXC8ncINltjvutm0EC+7e/VdeISDZZsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MbiJRFdtpX73+og0cKxwNiGCwWKkZvdHQoILLRimSA=;
 b=XLFZrsRnWhq5IsHVSuLXgRJuaWormpZDiZRALgGFEDFl1MX60Pl8HrKuaeQtiT94VyZAQEXqal/bJdwYXbXJqBWgCHpiDj61vKiY6s5AFnB81tGoiLYzp6/WPWainXvbLDv38OvuS5SBmGSM7BKkwT2GSEYmct+Z2bRu/Q91gOv51tdjZLETCDcEWF30mQWs2JsZTYgg5WufuLciKSKnia80/kyssPBWwtj3PItuFi3ZJH19RyqPPpS9NR/jM1yDkjfd8KhbjH1VXKPcAuH4uWiAV3RkI7fMUHll/aHCznRAgrq1DVAOVif5TH4hnGXGpb75a1M7jGahxxrFuoSZyg==
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19)
 by MI7PR04MB897750.eurprd04.prod.outlook.com (2603:10a6:290:102::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:41:36 +0000
Received: from AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418]) by AS8PR04MB8293.eurprd04.prod.outlook.com
 ([fe80::44ae:6a51:3b80:4418%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:41:36 +0000
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: Hemant Agrawal <hemant.agrawal@nxp.com>, David Marchand
 <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 00/16] Device unplug and bus cleanup refactoring for NXP
Thread-Topic: [PATCH 00/16] Device unplug and bus cleanup refactoring for NXP
Thread-Index: AQHdXAMSNSOrYyw/Ckauj6Ac8xGWwrcDIIOwgAyDayA=
Date: Mon, 26 Oct 2026 09:41:36 +0000
Message-ID: <AS8PR04MB82937F10CD26FDD07AA3AFABE5612@AS8PR04MB8293.eurprd04.prod.outlook.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
 <GV1PR04MB10750AE0102EC1FDDC8E2E0C389992@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB10750AE0102EC1FDDC8E2E0C389992@GV1PR04MB10750.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-18T10:34:34.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8293:EE_|MI7PR04MB897750:EE_
x-ms-office365-filtering-correlation-id: d9b3e53a-aa14-4d18-3cbc-08df334553c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|19092799006|366016|38070700021|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: BKL/1aoUCIlV+rl5QUTUYrco91zTJm44qT5RIgDjnYoPG2zG3olplCTXwTOAPJcSMhOg8j4EGzBlikOQ1Awm1w2j/YB54NNYtynFBzKkaO+uVLVJ6BNt8/6rCfEALu9zrVWICVlM1DArxxNbGzdxU3LWsXdEU1et7PRUemjtpAxh7la5FfUJZYTyLOcti+qYxfxyJC2OMx+1zOLcrYeIZ9/HV9ExuFweRVwOhRM/vKU6U6HVmnq00sYvj7oYT0hmAGlt/T3LWaIgMs0A77WqLyu8HPkqVPXW/YtccSJ8fDYh9hP4fIxEoZzdFSdoa9r6Al44l8+P9wYUvRc465iIHUFj1ojmutWiSuS5JqgMxQdBpYHEQ/vFkzzRnCIwDuyaL8dNg0zLZUzujScxyttA3sEJMx4E8FFivxkLPAF+Xd0fCNVO7em/5skGuYBPj8V52KjC1Lzte5oow/ga3BSSC4688wlbdKhablyuFvdIuqqUVlC6866UcORZNjZHCgQF6UsBcjp76ab9EmWFzB25aKuduujXftt9Y4gUPTgctb8HvrdeUTiQ1lCEBbyWI1n5etlTgFhk3Oo4O1Tq05mIsNGmCZNLjDWWewmqhFCdbLFn2IJ9f0FD49i/i3HQCOHzd9etMQoxydslhtXjfkyHw8f1zak7qGsY/fY6RPUAH1/SHPG8LSeOgWldqVtwvtLWAgD2pVLR7sHuU6eVTZ18K6huPiJJMUCgNa1o4hpLPQU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8293.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGhDK3hSSWdQUUNJYjlhZlRVM1BaVE9FcEw5eG1IYk16cXhrR3pBdVl4TDla?=
 =?utf-8?B?TG1yTk1KaVljZzErdDhhUklvMXg2Qzc1dTM3MjkvdVlrUFM1cUw1ZGpjZitP?=
 =?utf-8?B?THM0T0VOQmRoRUZ0cWNMMkl4SWw5RVJsQ1JOTTBCRGNWMG5FcTFLcUhLS2h0?=
 =?utf-8?B?NHY0OFdYQ1pXckEzdUhGdjJYMk5oUFlvS05WYlMyUFEwYTRpbkVUbFdPUjBB?=
 =?utf-8?B?WWIrMFZFdXVZTk5GQklaWUdIS295bVpaVjQyelpkazBudmdIVit2c3NONVFC?=
 =?utf-8?B?K2daVjBLbEdmSi94STlqSjZ1UkQwR2JLYlU2Q3ZYaDdVMGRwVldDRWt6bTRz?=
 =?utf-8?B?ZnZXRHcraXJKK3VseUxVYjdmY09BY2FGajVuamxLenMxcUd3MXV3eDMwbm9P?=
 =?utf-8?B?MlBVd093aVltY1NNWXpHR0pqZWc5TmVzOVB6c1kxMmYveW1kOUh6YndWWHJx?=
 =?utf-8?B?bG5wQUJ0NzlPVkxnalhPQTFOcTVFNEl5Qm8yYmRBT1JMZHk3TlgyMEdoekFi?=
 =?utf-8?B?dDdxdTNRUitLLzBNa0FUMlBxVzA3WU5IOEd1Wis3K3psSFNLVjhvd2RZUS9y?=
 =?utf-8?B?aHZLeVhTVTduSEFNeWt3T0VKYnM5ck55YVIvN21vWGJJeWg0dVNiSEJwM3VF?=
 =?utf-8?B?SGFZb1h2RnY2OG5HUWs5Mml6RVVlZTYrRFpoTEVyak4wSXovdEpINm43aVFt?=
 =?utf-8?B?dlJZcDBoMGdjR1VFRlpibzhyRndzbVYraFlCMmdjaURQVmcyNE16ZGF1Q1BU?=
 =?utf-8?B?dTlsaG9oT0p2ZFRuVkpsVmxNSUJQa0t1OERNTGQ4U243UzI0TlV0QWQ1eXV2?=
 =?utf-8?B?cjduUkF1Uyt0RVJhWitNcGdLTzBNNFJ4U1ROeUMwK0pmR0tZeU1uTzJTNEd5?=
 =?utf-8?B?U3VuS3F2ZGZZU1lKZytBaGo5M1ZzakVKSXVmQytVa2QwNDVqU2orVE1KYzVw?=
 =?utf-8?B?NkdCenZmWTR6VW1LdGs0RU00UVdSU1Bwc0ZaT01wdnd4SHNvQ2M2czEzSzhm?=
 =?utf-8?B?cmcwc2FOTmFhR1VLYVZNUmN2R3pGTktZMlorbUlJc096NUpDL0lpRUo5Y2tQ?=
 =?utf-8?B?VW5HSmNleDhNMEo2cjQ0WElWNDYrMC82UHAyYTlCQkxqVTFvVis1TWVFSUpQ?=
 =?utf-8?B?eXZidnNBYmdGd05aWGtzRG0zV0hXN3N1ZWJrdmF3VTgzdkdCU2ZmZ3F1NnhX?=
 =?utf-8?B?M2JwSEx2TDJXUG9ia1lkWEFhYitndk05SHZoait1R0tPOS9OWFFqaWlWT0lH?=
 =?utf-8?B?Vkltd2Y5WTZIR2NGVjE4QkVONit3VGgyUDZVYy90R2pnQnNVcHdsbkRmNTEw?=
 =?utf-8?B?QTlzNWV0VzhvVDVKMmpOSCtrcUdrTnNuSC9kdVJiYkNvSzNtOWNZMWxLUnIx?=
 =?utf-8?B?aElBODZVYkxFcVRIc0tEekw4d2RjMlU1SmxucWYvbDRCRGtveDYwWXNLTDNP?=
 =?utf-8?B?Q2pmVmxseDNMaUNXSDlOQkZWSnFScFhNWkhDT0JDOXlFc2F0TmFJWW9Fc0Fz?=
 =?utf-8?B?NWNlcGJvNnY2OFhlQzBsMWMyU2VkQTFqaXB0cWwzQlNrZWlQRndxcG5nc292?=
 =?utf-8?B?TWhuTnh2cW43TVlYVGlDWXU1Z1NneUVwb0ltN3NmRWxvYU9lS0ppck1nMTFi?=
 =?utf-8?B?MEMzVEt1eVE4cktPWFFjZzVJYldDVWQxTlM2Z2hpdENoSlZpTng3Nm1mRDNB?=
 =?utf-8?B?eisya2pCbWp1aUhRUm1GVVBQWmFXbG5ibTZiMGxMTUNQV0NneERYakxndzFs?=
 =?utf-8?B?ckJQeE1XNjV5Z1ozN3BzdlZQMWRXM3MxYnVmT1BPdWlsWWQwUEpDVXhnajkx?=
 =?utf-8?B?bndRWkVxd0lOK2VyTXJwL0ZWWVFncm4vVnZOcnI4QnFDdzF4U1F1b0NmK25a?=
 =?utf-8?B?TC84QkE4d210TXJjZlFEaFRJOG1hOWNYZ3prTUNJamVDcXUzaE1KZXZZdnF2?=
 =?utf-8?B?WVdnMUNTMmZBQ2oxVFdIQWpLYkdXSko0VUtRcFNRdDk3VlFrb1U2cDZGYTBx?=
 =?utf-8?B?NlpVOEEzVlIwRS9iR1VkL2ZHMzRYRVVlQW1KTUZvK0RDMStscUk5dkRJSmxk?=
 =?utf-8?B?aHA4ZnI3VUdFSFNqQUptSlg4bGw3VzZkd1hYcG5JNzFkazBLVzNrTWE4MFRL?=
 =?utf-8?B?bExXaU1iZHdMcUZFZkY4Z0pmM1FWQjFGOGdEbDhtRktNak1UemtlTllhdHNV?=
 =?utf-8?B?NytsQ0pGVDVKbHRLdzVkQ05jaWhYa2EvZHgrN0FCOWJqTnB6bXZveGUyOVZt?=
 =?utf-8?B?cmlSdCtSRkRpTG5nQkF1RkNDRDlCN3hjU2o0bVg3aTlMQUNIM1F5dnQrTXdR?=
 =?utf-8?B?V3pBYitoZlV5QkxLNmhpV3NRRkpPQXpWWGFuenRXUllWRTgzTWRQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8293.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b3e53a-aa14-4d18-3cbc-08df334553c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 09:41:36.0698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDZ7FgCdSSh6S2CNYuOgOez9nP0xwPJz2JmTUXI9UWEZecbvxBtYp8on+PD4dUJ9r+sFowyG2c65TLTOp4SaGiiwsUH3ZccMjUqMB8a7JTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR04MB897750
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgRGF2aWQsDQoNCkkgYW0gbm90IGFibGUgdG8gYXBwbHkgdGhlc2UgcGF0Y2hlcyBvbiBuZXh0
LW5ldC1tYWluLg0KQ291bGQgeW91IHBsZWFzZSBjaGVjayBpZiByZWJhc2UgaXMgcmVxdWlyZWQ/
DQoNClRoYW5rcywNClByYXNoYW50DQoNCg0KTlhQIENvbmZpZGVudGlhbA0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAu
Y29tPg0KU2VudDogMTggT2N0b2JlciAyMDI2IDE2OjA1DQpUbzogRGF2aWQgTWFyY2hhbmQgPGRh
dmlkLm1hcmNoYW5kQHJlZGhhdC5jb20+OyBkZXZAZHBkay5vcmc7IFByYXNoYW50IEd1cHRhIDxw
cmFzaGFudC5ndXB0YV8zQG54cC5jb20+DQpTdWJqZWN0OiBSRTogW1BBVENIIDAwLzE2XSBEZXZp
Y2UgdW5wbHVnIGFuZCBidXMgY2xlYW51cCByZWZhY3RvcmluZyBmb3IgTlhQDQoNCkhpIEBQcmFz
aGFudCBHdXB0YQ0KDQogICAgICAgIFBsZWFzZSBzaGFyZSB5b3VyIHRlc3QgcmVzdWx0cw0KDQpS
ZWdhcmRzDQpIZW1hbnQNCg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQubWFyY2hhbmRAcmVkaGF0LmNv
bT4NCj4gU2VudDogMTQgT2N0b2JlciAyMDI2IDIzOjEwDQo+IFRvOiBIZW1hbnQgQWdyYXdhbCA8
aGVtYW50LmFncmF3YWxAbnhwLmNvbT47IGRldkBkcGRrLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0gg
MDAvMTZdIERldmljZSB1bnBsdWcgYW5kIGJ1cyBjbGVhbnVwIHJlZmFjdG9yaW5nIGZvcg0KPiBO
WFANCj4gSW1wb3J0YW5jZTogSGlnaA0KPg0KPiBIZWxsbyBIZW1hbnQsDQo+DQo+IFRoaXMgaXMg
YSBmb2xsb3d1cCB0byB0aGUgcmVmYWN0b3Jpbmcgc3RhcnRlZCBpbiAyNi4wNy4NCj4NCj4gSSB0
b29rIHNvbWUgdGltZSB3aXRoIG15IGJlc3QgQUkgZnJpZW5kIHRvIGNsZWFudXAgRFBBQSBhbmQg
RlNMTUMgYnVzDQo+IGRyaXZlcnMuDQo+DQo+IExpa2UgdGhlIGxhc3QgdGltZSwgb25seSBjb21w
aWxhdGlvbiBoYXMgYmVlbiBjaGVja2VkLg0KPiBJIGhhdmUgbm8gaGFyZHdhcmUgdG8gdGVzdCBy
dW50aW1lLg0KPg0KPiBPbmUgdGhpbmcgdGhhdCBjb3VsZCBiZSBicm9rZW4gaXMgZWl0aGVyIHRo
ZSBvcmRlciBvZiBkZXZpY2VzDQo+IGluaXRpYWxpc2F0aW9uLCBvciBidWdzIGluIHRoZSBkZXZp
Y2UgZmlsdGVyaW5nIHRoYXQgSSB0cmllZCB0byBzaW1wbGlmeS4NCj4NCj4gSSB3ZW50IHdpdGgg
dGhlIGFwcHJvYWNoIG9mIHNwbGl0dGluZyB0aGUgZGV2aWNlIGxpc3QgYmV0d2VlbiBpbnRlcm5h
bA0KPiBidXMgb2JqZWN0ICh0aGF0IEkgY2FsbGVkICJjb250cm9sIiBkZXZpY2VzLCBtYXliZSBh
IGJldHRlciBuYW1lIGNhbg0KPiBiZSBmb3VuZCksIGFuZCBub3JtYWwgYnVzIGRldmljZSBvYmpl
Y3QgZm9yIHdoaWNoIERQREsgaGFzIGEgZHJpdmVyLg0KPg0KPiBJIHRoaW5rIGl0IGlzIHdvcnRo
IHRlc3RpbmcgYW5kIGZpeGluZywgYXMgaXQgd2lsbCBtYWtlIHRoZSB0d28gTlhQDQo+IGJ1cyBk
cml2ZXJzIHNpbWlsYXIgdG8gb3RoZXIgYnVzIGRyaXZlcnMgKGJ1dCBrZWVwIHRoZSBzcGVjaWFs
IElPDQo+IGRldmljZXMgaGFuZGxpbmcgaW50ZXJuYWwgdG8gdGhlIEZTTE1DIGJ1cyBmb3IgZXhh
bXBsZSkuDQo+DQo+DQo+IC0tDQo+IERhdmlkIE1hcmNoYW5kDQo+DQo+IENoYW5nZXMgc2luY2Ug
UkZDIHYyOg0KPiAtIHJlYmFzZWQsDQo+IC0gZml4ZWQgaW50ZXJydXB0IGNsb3NpbmcsDQo+DQo+
IENoYW5nZXMgc2luY2UgUkZDIHYxOg0KPiAtIGZpeGVkIEZEIGxlYWsgaW4gYnVzL2RwYWEgcHJl
IGV4aXN0aW5nIGNvZGUsDQo+IC0gZml4ZWQgZGV2aWNlIG5hbWUgbGVhayBpbiBidXMvZnNsbWMg
cHJlIGV4aXN0aW5nIGNvZGUsDQo+IC0gZml4ZWQgb3RoZXIgbGVha3MgZm91bmQgYnkgQUkgcmV2
aWV3LA0KPiAtIHNwbGl0IERQQUEyIGRldmljZXMgaW4gdHdvIGxpc3Q6DQo+ICAgLSBvbmUgbGlz
dCBpbiB0aGUgYnVzIG9iamVjdCBmb3IgZGV2aWNlcyBmb3Igd2hpY2ggYSBkcml2ZXIgZXhpc3Rz
LA0KPiAgIC0gb25lIGxpc3QgbG9jYWwgdG8gdGhlIGZzbG1jIGJ1cyBjb2RlIGZvciBpbnRlcm5h
bCByZXNvdXJjZXMgdGhhdA0KPiAgICAgYXJlIGluaXRpYWxpc2VkIG91dCBvZiB0aGUgRUFMIC8g
YnVzIGZyYW1ld29yaywNCj4NCj4gRGF2aWQgTWFyY2hhbmQgKDE2KToNCj4gICBkcml2ZXJzL2J1
czogY2xlYW51cCBkZXZpY2UgZnJlZWluZyBpbiBOWFAgYnVzIHNjYW4NCj4gICBkcml2ZXJzL2J1
czogZml4IEZEIGxlYWsgZHVyaW5nIHNjYW4gaW4gTlhQIGRyaXZlcnMNCj4gICBidXMvZHBhYTog
YWxsb2NhdGUgaW50ZXJydXB0IGR1cmluZyBwcm9iaW5nDQo+ICAgYnVzL2RwYWE6IHN1cHBvcnQg
dW5wbHVnIGFuZCB1c2UgZ2VuZXJpYyBjbGVhbnVwDQo+ICAgYnVzL2ZzbG1jOiBmaXggZGV2aWNl
IG5hbWUgbGVhaw0KPiAgIGJ1cy9mc2xtYzogZml4IG1lbW9yeSBsZWFrcyBpbiBzY2FuDQo+ICAg
YnVzL2ZzbG1jOiBmaXggcGVyIHR5cGUgZGV2aWNlIGNvdW50DQo+ICAgYnVzL2ZzbG1jOiBmaXgg
c29tZSBWRklPIGRldmljZSBGRCBhbmQgbWVtb3J5IGxlYWtzDQo+ICAgYnVzL2ZzbG1jOiBmaXgg
aW50ZXJydXB0IGxlYWsgaW4gRFBJTyBjbGVhbnVwDQo+ICAgYnVzL2ZzbG1jOiBzaW1wbGlmeSBk
ZXZpY2UgcGFyc2luZyBpbiBzY2FuDQo+ICAgYnVzL2ZzbG1jOiByZWxlYXNlIHJlc291cmNlcyBv
biBwcm9iZSBmYWlsdXJlDQo+ICAgYnVzL2ZzbG1jOiByZWZhY3RvciBkZXZpY2UgZmlsdGVyaW5n
IGZvciBtdWx0aXByb2Nlc3MNCj4gICBidXMvZnNsbWM6IG1vdmUgdW5wbHVnIGZvciBzb21lIGRl
dmljZSBvdXQgb2YgVkZJTw0KPiAgIGJ1cy9mc2xtYzogY2FsbCBWRklPIHNldHVwIGZvciBzb21l
IGRldmljZSBmcm9tIGJ1cyBsYXllcg0KPiAgIGJ1cy9mc2xtYzogYWxsb2NhdGUgaW50ZXJydXB0
IGR1cmluZyBwcm9iaW5nDQo+ICAgYnVzL2ZzbG1jOiB1c2UgZ2VuZXJpYyBjbGVhbnVwDQo+DQo+
ICBkb2MvZ3VpZGVzL3JlbF9ub3Rlcy9yZWxlYXNlXzI2XzExLnJzdCAgIHwgICA0ICsNCj4gIGRy
aXZlcnMvYnVzL2RwYWEvZHBhYV9idXMuYyAgICAgICAgICAgICAgfCAxNDkgKysrKystLS0tDQo+
ICBkcml2ZXJzL2J1cy9mc2xtYy9idXNfZnNsbWNfZHJpdmVyLmggICAgIHwgICA0ICstDQo+ICBk
cml2ZXJzL2J1cy9mc2xtYy9mc2xtY19idXMuYyAgICAgICAgICAgIHwgNDA0ICsrKysrKysrKysr
KysrKystLS0tLS0NCj4gIGRyaXZlcnMvYnVzL2ZzbG1jL2ZzbG1jX3ZmaW8uYyAgICAgICAgICAg
fCA0MDcgKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvYnVzL2ZzbG1jL2ZzbG1j
X3ZmaW8uaCAgICAgICAgICAgfCAgIDYgKw0KPiAgZHJpdmVycy9idXMvZnNsbWMvcG9ydGFsL2Rw
YWEyX2h3X2RwaW8uYyB8ICAgMSArDQo+ICBkcml2ZXJzL2J1cy9mc2xtYy9wcml2YXRlLmggICAg
ICAgICAgICAgIHwgICA2ICsNCj4gIDggZmlsZXMgY2hhbmdlZCwgNTkyIGluc2VydGlvbnMoKyks
IDM4OSBkZWxldGlvbnMoLSkNCj4NCj4gLS0NCj4gMi41NC4wDQoNCg0K
