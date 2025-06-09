Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7CCC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 07:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C92E340661;
	Mon,  9 Jun 2025 09:51:43 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by mails.dpdk.org (Postfix) with ESMTP id EBA1D402E3
 for <dev@dpdk.org>; Mon,  9 Jun 2025 09:51:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeB9NHOoOsse6wfeJP9wWnl7EM7Iz6L+AMfak5Zqw7RAEjRXzpwpfxPlluhFIIFwsKCLwlhFleSOUXUZXCjggtKacMrFGoRVG7Gt+vBjO2Wo+fBDk1qUEInWJN1kWi+0DzryYHOczoJ+g0AsssdpQVI2ty1Gsoitcs9d78yK6kN0nQSihwdHGt8jVUSJ2SraOVO+o3r3Da2fWCUpK48rJKfGUtidA33Cf16uT55MHjc/UMN95zbku7xbod2wwm8GsnOXXTyNL9jfUKkqFZ64NxBDa1aYwIAcJvMlWBolZjzDGmyuGSfVydshN5r9+larWQtdSt1uWRzo952H03Fi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=769n/tZmLbM3qIbj1MRt+16x2MJTDTNMWE3bVNK1K+c=;
 b=IFlVPTo2ZFfjwL02kySGEf84QlmIzY2Xjqti1cnsodAbvRSJhbNIMOvxAjcH3SmmA2dEOe7K/hZXAYwCiDnlGa47Qi3jc8j5qpBFEeVcgIq5W/aEjBEZXb8Lcb/wwA4ugOdR8uir1huVdXeZXMfzdUfD1Vpd1h2hHOmVsJVEB8DMRyXJ/WqTTWxL1Y9G43wGAsx7f922j1RzwbmifSmgeyuDL3fa2R36BAeFVy45opqsAScnlKMSlyltB4VHFRaP3hDV0OAl52gMORhNDTBc5d92yLbYvfA//ZJsrR7WfQtkShnr5c7msMaONNJidp51jBct5352RzdU4lCvNO2rZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=769n/tZmLbM3qIbj1MRt+16x2MJTDTNMWE3bVNK1K+c=;
 b=FdazQjZL3uhFJbPPQK8p3A0zUcVM3YRxgY96pNr/obWRaIVKRejvSY5aQuPJjAEy9sYnrI5W7uEjaLp6cReCU72qlafbv7fA1RKhzUtEG3+nZbe1s3CuVVs7oE0zz30cSNwTuDExP4DBCMrBOD7CjcMCiKuSAFrDmMkObM87Xy4=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Mon, 9 Jun
 2025 07:51:39 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%5]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 07:51:39 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>, Pavan
 Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
CC: dev <dev@dpdk.org>
Subject: RE: rte_lcore_has_role() return value
Thread-Topic: rte_lcore_has_role() return value
Thread-Index: AdvIpLZJaWj+3Hu4QLKxOy27D7eK3AAIZ8owAAB9vyAC4Vs18AAA58egATB5l2A=
Date: Mon, 9 Jun 2025 07:51:39 +0000
Message-ID: <PH7PR12MB85967291FE92FCDBDF57B153826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC69@smartserver.smartshare.dk>
 <PH0PR18MB40869A3A3B6E5F0C4D7F02CFDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <PH0PR18MB40867CA69B24733163400ADCDE9CA@PH0PR18MB4086.namprd18.prod.outlook.com>
 <PH7PR12MB859673BB32BC7B05B6ACD55E826DA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCAE@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCAE@smartserver.smartshare.dk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=36e173fc-2003-4d04-9f3b-ede22251fad1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-09T07:51:10Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|SJ0PR12MB6686:EE_
x-ms-office365-filtering-correlation-id: c36538a0-574a-4db5-0896-08dda72a7793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OS9yTFRyUytBWjc4SjRDeS8xNlFnWGh3WFExTDNtM2FBbm9uNWZ4TW92dlZK?=
 =?utf-8?B?U3ZnUnYxbWlPRmFlR2pXejFzb0lCcENvM1A4Mzlsek53RlBLeWpGYnNaODZz?=
 =?utf-8?B?dW8wL1g0MUpmRUcvaFlHL3NqcmpwOXdVdk5maFB5NXB6QnpTU2JFTkhIYlhO?=
 =?utf-8?B?Z3FJQVFhV2tSczlBdm01akpRUHBMNWtGbzFvRXdkRXp3MHgzazM5UUdMeVYz?=
 =?utf-8?B?N0lQSUw4RXZoNVBjOU5rQ1A2c3lBeFd2ektXVHEwMFdBYmtYZEluK2hFZnNn?=
 =?utf-8?B?ZzkxcFJLYkZDMHFSZUIzbk1CZC9VaWoyR0dwTFp3RnVMZUNKQXk5OW1TNWJi?=
 =?utf-8?B?UXZRZ1NZNUFrWmlwWVNKcUVFNnlMTkxZWHdkSno5OW1NT1dqMDJ2OFBLUGxp?=
 =?utf-8?B?bW9Gb0tUcnhRSytmODFVZTdNVWVqU1FQeklJNWxKTEVyVGZpaXdEcjBNTFNl?=
 =?utf-8?B?bU4xcm92eUo3aE11UU1wVFgwN3VQMUEvdUdJMzhvdUk0aGdoNThibWZvQjVW?=
 =?utf-8?B?NTVrNWt2ZjgycE1kaklHSEg5di93K1k4VUFNeDVHSVg4MktOZFBHaXZEOE1G?=
 =?utf-8?B?K1AyR25Sb252dmI1VEFqb1pVSUE3NFQwL1h2N3NFQUFTWHNBZXBPZ3ZRb3l5?=
 =?utf-8?B?VGZDYXNocVdPSFY0RFpJMjRBQys4SWNsZmNUdGY3ZlNqU0YwVjQvdHBSdzk5?=
 =?utf-8?B?bjlob2F0bUxqZGM0aFl3eGY0UlYva2ozT3FuV3ZibmRtb0ZvRTRBVExHMXJu?=
 =?utf-8?B?UFF3VFVTSkdvNUppa2RSek5RSGlleWlVVDlMUHlMWHpMaFBJUEFPbkloQ2o4?=
 =?utf-8?B?eTMzcjdURUUreG9VdWlra2xIamRTTi9XZWY4T1ZQVDdvek9hYzdpL0RYdHRE?=
 =?utf-8?B?K1ZQUlQ1cXR0VGxrUVRkcmowanBRbllXU3ZlK1gvZk1walZjb0VVN1NwdmVZ?=
 =?utf-8?B?YXA4Ym9xZWJSREhlNW5CSkhLbUVUdTMrQ085TkQwZW1MUWIxbGJXYWNsYVdB?=
 =?utf-8?B?VFpkMlZaYTN1TmhyOHpNYXNvVStrVFpnNm16Q3hFWThRZ2hoS0hvR01nWTUv?=
 =?utf-8?B?dFM2clg3UjBnMXpWVkZ4RFlxZmN4ZGxHd2tHTG5FS05CdXI1Z216ZjlabW1F?=
 =?utf-8?B?aFBlcGIrd2lKTHE5S3VEZzFwVEM1M3IrZmxDTVlqZWVmc0JoNWdsNExKZDZx?=
 =?utf-8?B?UEZyWklhaXNhOHR4Wmc4dkVWYis3RDZTMjlTcWsrckU5cUxuZUNkQVlRaFBw?=
 =?utf-8?B?dS9oajhSbzFKVnY3WTF1LzdFOHU0c0d1dUV3aVZtOHhMenNza0pFM2pJcy9B?=
 =?utf-8?B?MDBIQnljamJxVDMzdDZ0YnYvVE1ic2JXMGo2ZndqRHd4Y0tZRE9kV1JMM3pk?=
 =?utf-8?B?UWRXbkZoUjBwaUlIVXBrM2dnQWxTYVAyOWcxd1pJdWxEekhobGhrbUtlR2s0?=
 =?utf-8?B?bklhbzJnWUpycTdJdnlLZEpzRXhSRzg5MVAzOEc2MlJLRGJxb0RoRFRpQTh5?=
 =?utf-8?B?N0tNQ3J0MWhjZHUybzhCZ3dqMTdVc3Zkc0h6SlpzajFrd3JYOFI5bmdTYmRq?=
 =?utf-8?B?RGZvZnJVVHJFVjhzTTFQWUg3ZHlFSFpmM21xUWpyQ1NIdzJxWm41dGFhY0FT?=
 =?utf-8?B?Y2JONG42ZXNUQjE4cWZmS0h2dmVNblZBczdDSDk4WnBzQjM1M0JyMWcvQ1pa?=
 =?utf-8?B?K0pxczMvVnZsTURBZTB5dzYyalU3dXE0NExqRy8wOWJocm5Pb1Nrekc2MUVx?=
 =?utf-8?B?T2tQcUV4cFJjTTEvSnljMWxzb2tna2NMTksyYkd0K0hqb3RRN3dBQzZpKzBG?=
 =?utf-8?B?QSszODhOTmxBZWRkNE9RcXZKUE00N09JTzhydU9KeXh0Szh0M0E4Z2NkSFc2?=
 =?utf-8?B?TU03U3JNSDRvNEQva2l3M0NoMldpR0xwcGJjRnJqS1gwSXN5SjZxRkFkVWt2?=
 =?utf-8?Q?kDJ3pKmxnDo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmtEUWo2clQwcFQyL1AwRjVIcjZWeXJtdUZEYjNUUUlMdHE3cThQOHMzYm01?=
 =?utf-8?B?cFVHT0k4VFh2NzZENnh6MzlkMlJUSHJjTzZJL2NhU2JaWkkxV1JqL2RnUTMy?=
 =?utf-8?B?ZmhMV1UyUlpGdXFyYjd4WW04ckIyZkRLTGQyWXR5NnV6TTRpdUtveFk4YnF6?=
 =?utf-8?B?eXdWak5DMWNrNERoWmNUemhrU2dRQ0VRSmdQQlZIdXhBSkxYMlJlWUdTRkpK?=
 =?utf-8?B?Q2t3YnRyaEtOc292RXVjVVBVZVFKem5KbHZaREtEWUxBbGlQOUJaZE1jRDFG?=
 =?utf-8?B?NFc5d3RxVGQrMFMyRjc5K1Zvb0pIN0xNRnRHVXd1VnVRN2pubXZSTWovaW9B?=
 =?utf-8?B?a0kyeDdpTytXTnA3UzArUkVVbHZ5Nlg5TFcrNGFITlBSVEUzVkRmbEpJbnVt?=
 =?utf-8?B?NU1zT3Rsc0FFY1FubVQ4WDhnL0w2MXJ2OFBVVW9BSnBva2laWGQ3QlpSQ3lw?=
 =?utf-8?B?bXNFdmp4QTNoM2RTZlg5OVpXU3U0YktOMkwrbmdNRUtGQnZDK09IcHVRR2lh?=
 =?utf-8?B?WlY4eVFpYk5WYXJLM3NDN2tSNXRLdkJ4T0tDalRLWjNMclFXMkxJMzVWNU5V?=
 =?utf-8?B?RXlPa09LWnN0NGR4TWVYazJXbnFwb2hCazFxcitIU0FBRUN0bjVXYmttYmty?=
 =?utf-8?B?NnJZWUkwSkM5ZkNWazdKYXZaaEdXVXozZzNSaXJDSVl1Z1lZdCtkb0ZYamdS?=
 =?utf-8?B?dURUQURwc1JHYU5kWDU1cVVQVjNkYmhGaGhrZGN6NHk1S1FIanhMNndJNjY5?=
 =?utf-8?B?ZC9Kam8wcWZBMHFtb3U2bDYvMm9YalpWbUxNSC9pY29Bakc5ZFVjNWpML1Za?=
 =?utf-8?B?UmZZb0JmRlF2U3E4L1U1SUhFU2RWUE9NTGhCdWFBazJ3NkhzSk16TXVsLzJU?=
 =?utf-8?B?NmRlR09RY09rcjlEdFdHTzZmRTZXdUZDbm5xL2RFeE5ySk1FSHloTXdTNkdi?=
 =?utf-8?B?NUxxVitVaStFQzhDZ1pvNGRwR3M3TWhCN1ZuU1VnSkErOXQ0aFIwTjV2d2Rz?=
 =?utf-8?B?ZmlVb3NEOUxVMUY2TENGR3Z1NVRjcWg3MWZ1aHBadEoxOEdUTW44K0Fobm9m?=
 =?utf-8?B?YUhPY0NKcm11WXdGT25wczBJNFl1bkxSbHh4Ym8vZUQ0d0lXMzhFYXppS2VG?=
 =?utf-8?B?Zk92Z3U4djB4NkVObXpFNzNkM2pGRDlBbVJBc1FJUXFBK3VKSGFLeko5V1pL?=
 =?utf-8?B?WWZNY2pIcThKRVNlNXoyVDNVQ2FzbGtzMGdEbUxLUklERUYxSXFqNDkvZ0xs?=
 =?utf-8?B?M3N2aGdKK2NsMFh0bEFoU0VyMzhuMTF5bGZROFZTR0g2NC82Y3RoeWVpZ2Zh?=
 =?utf-8?B?MjZZOE9DNHhOZitlWWhUamNIdEVJdTJvOEpMdjJWdXpjVkJvWExqaDFvZndn?=
 =?utf-8?B?U3pBZW1KaEhPYTQwaEtlMHJVNmU0ckJqNi9ESlZBVDBWTFl0eERHNkxqVVE3?=
 =?utf-8?B?SFl3ZG0vK21VZ1hGT1g4YmxpdGRvWk9kUjYrcXBxYXhRRW1pOHVLTVNPcXRs?=
 =?utf-8?B?a2QvSmdwdXVVU2gyZGZIS1VqT1phck9IYW45dWpxSmkrKzJhL0ZrU0Jpc2Jx?=
 =?utf-8?B?dXMwMVMvMnFZYXIwd2gwUEYwN01OdDkzWG5XWDdkdUlwdkp6UjFkWWNTQ2tV?=
 =?utf-8?B?VVlXOGV5ODI2Ry9sR2pOUG1mRUgrSnJBa09FdGFEb1NsQVA2bVVNR2JJQkc0?=
 =?utf-8?B?SEd5MkcxV1AwelJJNjZxM0pQM1VSdE44Z1hqNytSTjRxTldURWFsTkZYZXBC?=
 =?utf-8?B?dGQrd1cwdEFZR1Y2UDBEajJ6ajI1QVlLSXVqOEQ1NElnRFVxUDdpRnNKeTFU?=
 =?utf-8?B?bTN4TktCOENSWVpaM0Z1WG9VSHNSS0QyQzVTeU5jYlJQUTl3SzJlTUZkMG1L?=
 =?utf-8?B?bFZiNlBJUjY3dmptbjZxejhaN1NLUmthWTYxVExJUjFjVlp0TnA4YVRtTXlt?=
 =?utf-8?B?RzB0QTBNQXA1ZHp2NDNkanFZeTBJaU91UWFMY1BEaDBWYjh6VDFWclZMd3p5?=
 =?utf-8?B?ajJBSTJDSVJ4WEFyQXRHZGsyeWxYcGhkM1JXbW94NTNMZk11aVRKQXF5NjJh?=
 =?utf-8?B?cXFUbDJRM05pVmVkMmxFbysvUW1RZGhXanhNekJ4Q1BER0lQcFcyeUpqZWhW?=
 =?utf-8?Q?xuGk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36538a0-574a-4db5-0896-08dda72a7793
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 07:51:39.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkmRGSO/KP0XCdCLaaQdY3hTQPyWKYulfpJZWOPjnPYXrlNU++JVNQrbh3mZAcaeMT0ukvpotnqdrXO6iyAMrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

W1B1YmxpY10NCg0KU25pcHBlZA0KDQo+DQo+DQo+IEhpIFZpcGluLA0KPg0KPiBObyBuZWVkLiBQ
YXZhbiBmaXhlZCBpdCBhbHJlYWR5Og0KPiBodHRwczovL3BhdGNod29yay5kcGRrLm9yZy9wcm9q
ZWN0L2RwZGsvcGF0Y2gvMjAyNTA1MjAyMDE3MjYuNzQyMC0xLQ0KPiBwYmhhZ2F2YXR1bGFAbWFy
dmVsbC5jb20vDQoNClRoYW5rIHlvdQ0KDQo+DQo+IC1Nb3J0ZW4NCj4NCj4gPiBGcm9tOiBWYXJn
aGVzZSwgVmlwaW4gW21haWx0bzpWaXBpbi5WYXJnaGVzZUBhbWQuY29tXQ0KPiA+IFNlbnQ6IFR1
ZXNkYXksIDMgSnVuZSAyMDI1IDA4LjA4DQo+ID4NCj4gPiBbUHVibGljXQ0KPiA+DQo+ID4gSGkg
QE1vcnRlbiBCcsO4cnVwDQo+ID4NCj4gPiBXb3VsZCB5b3UgbmVlZCBtZSB0byBjaGVjayB0aGlz
IHVuZGVyIGBydGVfdG9wb2xvZ3lgIHBjb21pbmcgcGF0Y2hlcz8NCj4gPg0KPiA+ID4gRnJvbTog
UGF2YW4gTmlraGlsZXNoIEJoYWdhdmF0dWxhIDxwYmhhZ2F2YXR1bGFAbWFydmVsbC5jb20+DQo+
ID4gPiBTZW50OiBNb25kYXksIE1heSAxOSwgMjAyNSA3OjQ2IFBNDQo+ID4gPg0KPiA+ID4gQ2F1
dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVz
ZSBwcm9wZXINCj4gPiBjYXV0aW9uDQo+ID4gPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNs
aWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBNeSBiYWQs
IEkgZ290IGl0IGNvbmZ1c2VkIHdpdGggbGNvcmUgdG9wb2xvZ3kgcGF0Y2hlcy4NCj4gPiA+DQo+
ID4gPiBJIHdpbGwgbG9vayBpbnRvIHRoaXMuDQo+ID4gPg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4g
UGF2YW4uDQo+ID4gPg0KPiA+ID4gPiBGcm9tOiBQYXZhbiBOaWtoaWxlc2ggQmhhZ2F2YXR1bGEN
Cj4gPiA+ID4gU2VudDogTW9uZGF5LCBNYXkgMTksIDIwMjUgNzozMiBQTQ0KPiA+ID4gPg0KPiA+
ID4gPiBIaSBNb3J0ZW4sDQo+ID4gPiA+DQo+ID4gPiA+IExvb2tzIGxpa2UgdGhpcyBpcyBtZWFu
dCBmb3IgVmlwaW4uDQo+ID4gPiA+DQo+ID4gPiA+ICtWaXBpbg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGFua3MsDQo+ID4gPiA+IFBhdmFuLg0KPiA+ID4gPg0KPiA+ID4gPiA+IFBhdmFuLA0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gVGhlIHJ0ZV9sY29yZV9oYXNfcm9sZSgpIGRvY3VtZW50YXRpb24gc2F5
cyBpdCByZXR1cm5zIGJvb2wuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJdHMgaW1wbGVtZW50YXRp
b24gcmV0dXJucyBhIHRydWUgdmFsdWUgKC0xKSBpZiBnaXZlbiBhDQo+ID4gPiA+ID4gbm9uLWNv
bXBsaWFudA0KPiA+ID4gPiBsY29yZV9pZCwNCj4gPiA+ID4gPiBlLmcuIExDT1JFX0lEX0FOWS4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IEkgdGhpbmsgaXQgc2hvdWxkIGJlaGF2ZSBsaWtlIHJ0ZV9s
Y29yZV9pc19lbmFibGVkKCksIGkuZS4NCj4gPiA+ID4gPiByZXR1cm4gZmFsc2UgaWYgZ2l2ZW4g
YSBub24tY29tcGxpYW50IGxjb3JlX2lkLCBlLmcuIExDT1JFX0lEX0FOWS4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IFVzZSBjYXNlOg0KPiA+ID4gPiA+IEEgY29udHJvbCB0aHJlYWQgaW4gYW4gYXBw
bGljYXRpb24gbWlnaHQgb3IgbWlnaHQgbm90IHJlZ2lzdGVyDQo+ID4gPiA+ID4gaXRzZWxmLCBh
bmQgdGhlIHJlZ2lzdHJhdGlvbiBtaWdodCBub3Qgc3VjY2VlZC4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IEF0IGV4aXQgb2YgdGhpcyBjb250cm9sIHRocmVhZCwgaXQgc2hvdWxkIHVucmVnaXN0ZXIg
aXRzZWxmIGlmDQo+ID4gcmVnaXN0ZXJlZC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEZpeGluZyBy
dGVfbGNvcmVfaGFzX3JvbGUoKSBhcyBzdWdnZXN0ZWQgd291bGQgc2ltcGxpZnkgdGhlDQo+ID4g
PiA+ID4gYXBwbGljYXRpb24gZnJvbQ0KPiA+ID4gPiA+IHRoaXM6DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiAgICAgaWYgKHJ0ZV9sY29yZV9pZCgpICE9IExDT1JFX0lEX0FOWSAmJg0KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgcnRlX2VhbF9sY29yZV9yb2xlKHJ0ZV9sY29yZV9pZCgpKSA9
PQ0KPiA+IFJPTEVfTk9OX0VBTCkNCj4gPiA+ID4gPiAgICAgICAgICAgICBydGVfdGhyZWFkX3Vu
cmVnaXN0ZXIoKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRvIHRoaXM6DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiAgICAgaWYgKHJ0ZV9sY29yZV9oYXNfcm9sZShydGVfbGNvcmVfaWQoKSwgUk9MRV9O
T05fRUFMKSkNCj4gPiA+ID4gPiAgICAgICAgICAgICBydGVfdGhyZWFkX3VucmVnaXN0ZXIoKTsN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IC1Nb3J0ZW4NCg0K
