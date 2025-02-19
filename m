Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81063C021AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 08:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D080540B92;
	Wed, 19 Feb 2025 09:16:33 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id A09F34025A
 for <dev@dpdk.org>; Wed, 19 Feb 2025 09:16:32 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IJaVkp007058;
 Wed, 19 Feb 2025 00:16:31 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44vyyuhexq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 00:16:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBg6bUSinpgOLwDuZXuOXpPtBxjRZOjFAO+DXUMwUBNMQ3vPNzP36sTgESAMzpe/Ey4UfkbsmvcUqZtdvvdb/veIPY9sec3cIEZjFJWvcFOu2Q8iMiZrF1tZ7op4v5NFQBSa8911HzwTOGswf62+ow9KKV0Lwd5EUNM5qDC5P8fo66+mycTMaGq8tu+QN48qoINnmRLqIlbfrsAaOzPRWq2m/THoKoDCrlJiPnoXHqiXTETHOXPkyK6qXlLNvtGbkPBfx3j8uEd9DyW+sB7kTztdrtmBJ5slautS77fUlWqucMS4Vb6U6vu4/DHeLbhPHqfE/fRtBZg04NnT/417vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHKeswbfKu4XtMEq4YZPmyH1Si/kvirKDPslGRmCEZs=;
 b=nB5S02EcAM375YsCfYy/++S+DZLOVP2qqziJ9HlHfp17VMAApWNlI5bkSn7M6PwgzZsah3BqZVwWTFOZAAVY4i1/VHL26wi6yYN977FqnW/TmqEBKPljm5b6tiU7HbpQwBW6K3sITKvI6PU2Z6qjm78/cRkPzNd61norimEf8CxmS4akPhdY2dZ281EzCb3/tvZ8+c0VUkjT7aCBsk/buwMmA7fLoaPXTkxR+nOIp0jPyv43mwSNFvrKxdXAgxV37Bx8S8DwbBxx02OzWoNeOfByXvURNDcpHrF5BFs+kk2J3LF7HWrC5koNbXm1Z67jRjY8EB5qiKcVGJxT6ydLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHKeswbfKu4XtMEq4YZPmyH1Si/kvirKDPslGRmCEZs=;
 b=JBGcV3MoyhPD7nPNK80fz4KzXlm4DbxUO51W4kCsYdJ40gNarrZ2/F+ib3HSHtg5h1wMqSsCDHxVBK5cTwXxsYZyJV2paWD11Q1xIRT9hZEGJ6TfDzKvcYeOWPIR1T35ZNe3/2pDuirfw1ThsMnXesDSqU+spuTVSy8r/KC32Q8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3498.namprd18.prod.outlook.com (2603:10b6:303:5f::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.20; Wed, 19 Feb 2025 08:16:29 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::3c98:dd36:4897:a51d%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 08:16:29 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: David Marchand <david.marchand@redhat.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Sunil Kumar Kori
 <skori@marvell.com>, Rakesh Kudurumalla <rkudurumalla@marvell.com>, Brian
 Dooley <brian.dooley@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Konstantin Ananyev
 <konstantin.v.ananyev@yandex.ru>
Subject: RE: [EXTERNAL] Re: [PATCH v6 7/8] app: reduce app dependencies
Thread-Topic: [EXTERNAL] Re: [PATCH v6 7/8] app: reduce app dependencies
Thread-Index: AQHbgqUIJtqemb75i0OJSSs1KGJaRrNORacg
Date: Wed, 19 Feb 2025 08:16:29 +0000
Message-ID: <CO6PR18MB44846826FEEA15C90FCFA837D8C52@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <cover.1725462264.git.anatoly.burakov@intel.com>
 <cover.1739877265.git.anatoly.burakov@intel.com>
 <4fef69922f2220f57ea32cb4a31e015622590237.1739877266.git.anatoly.burakov@intel.com>
 <CAJFAV8xGGW9bTvBXKA9Q90etQv97sW29hVC=ptkGPY2EUVMEJw@mail.gmail.com>
In-Reply-To: <CAJFAV8xGGW9bTvBXKA9Q90etQv97sW29hVC=ptkGPY2EUVMEJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3498:EE_
x-ms-office365-filtering-correlation-id: 6655134d-d554-4f02-b3f3-08dd50bdb658
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVh1L2RGK2JDU3hkaU9nanBTajN6cXY3NXBod08wQVExQXh3UFllem52bVZH?=
 =?utf-8?B?NGNVK3BCYlVkaWhxMGtVaTVxOTU5N0NZVFlBTitKcFRnSUNGaXVldnJ4UmVi?=
 =?utf-8?B?UTVUUENtd3ZtelA1L1UrVU1MZzR3SUNudU5BMFBaWjFtV2xtWG5SaXlWM3lo?=
 =?utf-8?B?b0tOem0wOVp4cm54Y3gyNTVwNU55Q1F6djFNaHB6d3lBeEtTWkhyc2pPVE9p?=
 =?utf-8?B?eUthRXo0YlJ4VVVaQXVSU2ZLeVYzNlFyQS81U2RwLzI2RGJLeG1MMC9rOUll?=
 =?utf-8?B?Tkt3NUFVRWk5dG1kcG10TmJ1VXJUcWNvYkJhaUN6UlJrNmJvSnFhYTlPVGV1?=
 =?utf-8?B?aDBvdjZhZXVXb1M5c3FZbWRuNWRvaCtSbTMzZVB3Zm1wekpoV2ZqMjZWZHA4?=
 =?utf-8?B?NXRPU1kvTHpJV21nZ3lQSDl1Z3NJZ21HQ3RDYlZCdjBRaURVL3pPaHVlWlJX?=
 =?utf-8?B?cDg2MVBPYkIxVmwzVW1EU2kzQVRWWU95bEt0K09ZOSt3UjI5SzFjNmNrYVJH?=
 =?utf-8?B?d0h4eUZEdGVKL1V5VzFlbldVNVRPNllTbWNzaWNRNU1ibTVJdEE1bEpLbStk?=
 =?utf-8?B?NDlxSktyeE9GTnlpdnhERHkwZmpqbVBOdVNwUHVHMW9IamNjcU5IRlRsY0pY?=
 =?utf-8?B?SDdhVUQvMWgxSGtEenZldFgzWkFtNVJFRjA1d2ZIcXQxYS80ZEhmZVRmVVFs?=
 =?utf-8?B?bmNWNHZyTzZsWFNycFoxYlMwaGhUeGEwVHhjdjZLS3pxOW1SN2o5cTZobjRX?=
 =?utf-8?B?UHVqWU5pbEdkREpiaUVWSndjaGRXeXBpbytnR0ZIckVvUThaWk5JU3B6bVRV?=
 =?utf-8?B?MDlOUHlrcER1NjZQSGhMNnlsZ1JaSWMyVEliclJ3TlRPUlgxaHdtWHo4Y3JO?=
 =?utf-8?B?bEZGQ2JRUTlPSWZVekd1eWlKTzdLSVkxL29mT09SaGxrczdxK2I5bXhibXpL?=
 =?utf-8?B?RThOK1NtbXpsN0Ura2pvQ3Z1Zy83Vnl5bWsxaUR2Vy9sSnZoT1pEdXdvY2hm?=
 =?utf-8?B?VDQ2Ymp0OFZTRjFCOS9MV3NEeW0zZ2wwdkgyQjMyY3I2M2dxQ2t4Mk1VV2Zk?=
 =?utf-8?B?K0Z1OE1GdDRHMU9Za2ZPQXlJS3J6SjJlT2xoWkZoWUlISzB2MWs1N2RhTmo0?=
 =?utf-8?B?Tmk1Wng5L1BkTjJJWkU0ci9LRE1OV3pSZGM1YlpTTlk3TWpQRG1zRWJvdzBN?=
 =?utf-8?B?bDBBTTlxN1REQ2JWL3RWT1k2Zm5zdlE4ZlIvZjM2TE5BR3dDTFZpMnlJSEFh?=
 =?utf-8?B?bnpZU21wdW9iSmkzME9OeXhXYXJua0xyenJkRDgwRndCMDIxcTlHRzg1M0ly?=
 =?utf-8?B?U1piSi9zQWszM2E4eXdXeWhSV1F2ZG9TMXVyWFozT0tWZmVVV0pCV3NMZ0ky?=
 =?utf-8?B?U3kzaVk4RUJyQU4yMlZIODMwUHFtZkZlTTd1Y3BnQWZFb2ZxWDZsYUdFWTM3?=
 =?utf-8?B?N29DdVBoYVMzYWJ5RXVOZkxZOEl3RnQyRzZLMHJrT1Rhd0hVcG4xTHI1RHdo?=
 =?utf-8?B?NG1YMDRyenJ4R1JkOCtXdUNjdnVadFprYWw5WVFDL2x4MVJxNHcxTGVHVzJ3?=
 =?utf-8?B?RGxpNWRuQXYzUE5aQTJaOXo1VjVkalFmc1Jxc3RDTVZwdHpZWUxzOVg0SFUy?=
 =?utf-8?B?UFJEK05ySW1xdE5jMENmQVNQZmE3dVdPSlZnM1phVXhlbGd2Q0tLelB1enNm?=
 =?utf-8?B?L3BqRjRJeERTZlJWRjdoRk5EWVptOG9hbnR6cmdYM0V3K2NiNFRKekdxbWJO?=
 =?utf-8?B?VkNRRnRiSm14aVI4MlMwbFpLVVFPL3FQQTlWY1BJZVEwaTBTTXJFaWRSUDRh?=
 =?utf-8?B?MUZNd1gvcnY2S0hrUkc1aTg0STlzelArdTJZUnBGVTFTdU1ORzIybWNlVnpY?=
 =?utf-8?B?a2tJMzNySWRSY3NQQ1QzYlYxMngzRmZSdTVvWWF6OVloekZaNWF6c3g0bUpi?=
 =?utf-8?Q?SC0EpKbHuv2yBe/3meAZjzURmG46Ce5h?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzRwS1p4NUFwTjFUbW9za2NxV0xOdHZhazl3WUNSaVlDNFRQby9tNHJzQTRs?=
 =?utf-8?B?UnkrY1A5ZEdZRzdhQUIrbUZyTnhiWWVra25KUlVPUVJjY0lOdE5pL0hOMlMy?=
 =?utf-8?B?UENVN1hhVHhGcHM3MzVqeVVUS1ZEK3Q0SlJGOUNGYkNnb0h1NHF3UDFFaFMv?=
 =?utf-8?B?VEU2cVVxTDJESFRzbFNjTUZ5TGpsMmxBRktsYTJkUk5URE5ERVFsUG9JazNj?=
 =?utf-8?B?U0paeFY0aGU2VUJjZmZ2SWZJbUlqbWFjWnVGTzhveGNiWmVtNklZb3V5ZTBX?=
 =?utf-8?B?MitXaDQzWXJhZTlhNmhxUW9SZGlzbllxT0hja3Y1b3ZOSjNHMkg3dTVsZHFj?=
 =?utf-8?B?Z3htVHpzT2E2RERjTGh5cVZqTGtubnh1NUxjSmdBcTZwZUlKRm9iU1lqeWRv?=
 =?utf-8?B?TzM1M1JHM083YW5GMUpyYXI0REVneVFOYnRmZjlBUkFJbTBwdWZ6WFRtdnFV?=
 =?utf-8?B?UkhPWWw5UXdJZjJFUzBwbGlwWUpmTXY4VUMyakVISy9xdjJYY1RJNm5TRVM5?=
 =?utf-8?B?NGRVK2pEM3Q0Yk1reHBIOVB3TkR2NmZjclZKUkN1dGFUTnFCY0lQdjFqbWIy?=
 =?utf-8?B?N0dEWHN0RStoVzdlcnJmZjR5UTVXa2dpOHBqajJoOGcrVGRncmg0cFpYMjRT?=
 =?utf-8?B?eUZ5czdINnpYOVFlanVsMWtJT3l5UmpWRURTanlrQTFRMHRJTENGZDlQVWJY?=
 =?utf-8?B?YjNEQTkrV0VkUjJWM3gvbUpOMkJGOWR2OGtDNS9XdkplOGFTVzBwWlM0UTRK?=
 =?utf-8?B?VDgrcE95b1htVnR0cks5OWlXUEFjcTlud0hFUDNnU2czNkNuc2ppN3FjakZY?=
 =?utf-8?B?UUdrK1gwcWV1QllYZXNTNGJYS3RYMXN1TDUveTREaFNuZ0NRZjFSbkhRUzdr?=
 =?utf-8?B?OFRUUm53ak5TRUVjTGlnZGlQK0o1Qk0zdlp1Yjk2ZGdIL2dqYVQ5bFZNZzJ1?=
 =?utf-8?B?V0JOUUZOL1FCUUNjVXlrcnh1dXdZeUhRMkt6VkFtS01aT1ZkdGpHRTJ1MDNL?=
 =?utf-8?B?RnJNaEVJejBpZUJxMjVNaENyTnZmS1RrV3A3c0d3Q0ZNeW40N09xKzlKUlhj?=
 =?utf-8?B?ZWpHQWdxSHcxZUdzOTZ6V0ttS2lTdng2bllvbjk2dlFaTEpGMllqcjhXZEdz?=
 =?utf-8?B?MVJBa0FRWVN5dEVOU1E5dXl4cmFCTWhCeGkxVW5BVW50K1ZqaGR4cEgyaTY0?=
 =?utf-8?B?NlZ2MUtkVkIxUi9sdW5FYTBrR08ySHR4dlB6anlRTDZ2QVNLOXVZVG12YmZV?=
 =?utf-8?B?aHQwMUc5ZERBTHQ5OWl4NVVHNWVvbnk0bGRkazBwZEpTZDVTYUlyRklGQWRu?=
 =?utf-8?B?RDZrVXYrdjY0TzZvTzVJRlhlZG82bU9FZVdDZmFGc2FEbGxIQU1YNTZVY2h3?=
 =?utf-8?B?Zy8vSEhneHB3U3lCUFBRKytZbW81ZUVObmdjM0tNZHhmMER1VXBjSUc0U202?=
 =?utf-8?B?NUN0WkkvU3F2RGR1dWpEZVorYldwbEdLUytiL2cvYk5la01oV2pvTUwyVS96?=
 =?utf-8?B?VktOcXNjSXJUSjdPRDVqL2ZOKzZOK3hhLzY1ZW9RU1JMMXNjWUc2WFd4VW9P?=
 =?utf-8?B?SFVkYUl1cE5CSWNIU3prejZDajhVWDNLVC9OUVdpTng0Tzd1UlV1Nk5Jd1gy?=
 =?utf-8?B?eC9EUnVhNkl0aDlIL2FiSXNlaElUMm0wajdnTmlmbk02ZVozYXpENXA1aW5k?=
 =?utf-8?B?TzlJN0ViRmpjUHJEUUxibDRhRmp6Ykt4NHpZNlpXWHFLdnFyOVg5VWZXVElB?=
 =?utf-8?B?a1diNjRWdldZQXhOVjhzbFl6NXcxN3JwRVlNbnNjT0xSMGFFd3JsZWg2enU0?=
 =?utf-8?B?cUFWUU5NOVU1ZlN6R2c3b0NML2lCM1BtZm8vUnE5WnZxQnVYK0Y5YXhMZTJV?=
 =?utf-8?B?UmVBbXlBMGRsTFpFVTdMQkE2M1o4eHBaZVowMnpsZFlzcDE4TmZLUUZNZ1VO?=
 =?utf-8?B?NUdLaDZRMXhsYmYyK1JVRlRVbTlFUy9iRUptWTdLMHh1Z05tdHdqK1NqcURk?=
 =?utf-8?B?VHhhcHNjMWl1OGJmU0lleTZ6Wkc5TS9vN1pQTmVUaFlSQWVUb29BbzBRRmJh?=
 =?utf-8?B?WlRlQVZ2eXg2YjRvVWNBQllkeGt4RnkrM2lsZi9sU3lUdmt0Nml2dEpnU3hV?=
 =?utf-8?Q?ZoYY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6655134d-d554-4f02-b3f3-08dd50bdb658
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 08:16:29.4371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IDphznLsbQxvdzckDm1FepmKZY4aprPNDy7NKVBHpPF3zqOp4fPyL3LVR5lsH7UY9/DIhs3HP0zQGrrsHdvvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3498
X-Proofpoint-GUID: HapgueSrjoq_RbTjUK-BZqGINDc8aZsw
X-Proofpoint-ORIG-GUID: HapgueSrjoq_RbTjUK-BZqGINDc8aZsw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
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

SGkgRGF2aWQsDQo+IEhlbGxvLA0KPiANCj4gQ2M6IEFraGlsLg0KPiANCj4gT24gVHVlLCBGZWIg
MTgsIDIwMjUgYXQgMTI6MTbigK9QTSBBbmF0b2x5IEJ1cmFrb3YNCj4gPGFuYXRvbHkuYnVyYWtv
dkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9hcHAvdGVzdC1jcnlwdG8tcGVy
Zi9tZXNvbi5idWlsZCBiL2FwcC90ZXN0LWNyeXB0by0NCj4gcGVyZi9tZXNvbi5idWlsZA0KPiA+
IGluZGV4IGZiNDhkOWVjMjkuLmYwNTY0MzFiZjQgMTAwNjQ0DQo+ID4gLS0tIGEvYXBwL3Rlc3Qt
Y3J5cHRvLXBlcmYvbWVzb24uYnVpbGQNCj4gPiArKysgYi9hcHAvdGVzdC1jcnlwdG8tcGVyZi9t
ZXNvbi5idWlsZA0KPiA+IEBAIC0xOSw3ICsxOSw3IEBAIHNvdXJjZXMgPSBmaWxlcygNCj4gPiAg
ICAgICAgICAnY3BlcmZfdGVzdF92ZXJpZnkuYycsDQo+ID4gICAgICAgICAgJ21haW4uYycsDQo+
ID4gICkNCj4gPiAtZGVwcyArPSBbJ2NyeXB0b2RldicsICduZXQnLCAnc2VjdXJpdHknXQ0KPiA+
ICtkZXBzICs9IFsnY3J5cHRvZGV2J10NCj4gPiAgb3B0aW9uYWxfZGVwcyArPSAnY3J5cHRvX3Nj
aGVkdWxlcicNCj4gPg0KPiA+ICBjZmxhZ3MgKz0gbm9fd3ZsYV9jZmxhZw0KPiANCj4gLSBUaGlz
IGFwcCBkb2VzIHNlZW0gdG8gcmVseSBvbiBsaWIvbmV0Lg0KPiANCj4gWzk4OS8xMjY2XSBDb21w
aWxpbmcgQyBvYmplY3QNCj4gYXBwL2RwZGstdGVzdC1jcnlwdG8tcGVyZi5wL3Rlc3QtY3J5cHRv
LXBlcmZfY3BlcmZfb3BzLmMubw0KPiBGQUlMRUQ6IGFwcC9kcGRrLXRlc3QtY3J5cHRvLXBlcmYu
cC90ZXN0LWNyeXB0by1wZXJmX2NwZXJmX29wcy5jLm8NCj4gY2NhY2hlIGFhcmNoNjQtbGludXgt
Z251LWdjYyAtSWFwcC9kcGRrLXRlc3QtY3J5cHRvLXBlcmYucCAtSWFwcA0KPiAtSS4uL2FwcCAt
SWxpYi9jcnlwdG9kZXYgLUkuLi9saWIvY3J5cHRvZGV2IC1JbGliL21idWYgLUkuLi9saWIvbWJ1
Zg0KPiAtSWxpYi9tZW1wb29sIC1JLi4vbGliL21lbXBvb2wgLUlsaWIvcmluZyAtSS4uL2xpYi9y
aW5nIC1JLiAtSS4uDQo+IC1JY29uZmlnIC1JLi4vY29uZmlnIC1JbGliL2VhbC9pbmNsdWRlIC1J
Li4vbGliL2VhbC9pbmNsdWRlDQo+IC1JbGliL2VhbC9saW51eC9pbmNsdWRlIC1JLi4vbGliL2Vh
bC9saW51eC9pbmNsdWRlDQo+IC1JbGliL2VhbC9hcm0vaW5jbHVkZSAtSS4uL2xpYi9lYWwvYXJt
L2luY2x1ZGUgLUkuLi9rZXJuZWwvbGludXgNCj4gLUlsaWIvZWFsL2NvbW1vbiAtSS4uL2xpYi9l
YWwvY29tbW9uIC1JbGliL2VhbCAtSS4uL2xpYi9lYWwNCj4gLUlsaWIva3ZhcmdzIC1JLi4vbGli
L2t2YXJncyAtSWxpYi9sb2cgLUkuLi9saWIvbG9nIC1JbGliL21ldHJpY3MNCj4gLUkuLi9saWIv
bWV0cmljcyAtSWxpYi90ZWxlbWV0cnkgLUkuLi9saWIvdGVsZW1ldHJ5IC1JbGliL3JjdQ0KPiAt
SS4uL2xpYi9yY3UgLWZkaWFnbm9zdGljcy1jb2xvcj1hbHdheXMgLXBpcGUgLURfRklMRV9PRkZT
RVRfQklUUz02NA0KPiAtV2FsbCAtV2ludmFsaWQtcGNoIC1XZXh0cmEgLVdlcnJvciAtc3RkPWMx
MSAtTzMgLWluY2x1ZGUgcnRlX2NvbmZpZy5oDQo+IC1XdmxhIC1XY2FzdC1xdWFsIC1XZGVwcmVj
YXRlZCAtV2Zvcm1hdCAtV2Zvcm1hdC1ub25saXRlcmFsDQo+IC1XZm9ybWF0LXNlY3VyaXR5IC1X
bWlzc2luZy1kZWNsYXJhdGlvbnMgLVdtaXNzaW5nLXByb3RvdHlwZXMNCj4gLVduZXN0ZWQtZXh0
ZXJucyAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1XcG9pbnRlci1hcml0aCAtV3NpZ24tY29tcGFy
ZQ0KPiAtV3N0cmljdC1wcm90b3R5cGVzIC1XdW5kZWYgLVd3cml0ZS1zdHJpbmdzIC1Xbm8tcGFj
a2VkLW5vdC1hbGlnbmVkDQo+IC1Xbm8tbWlzc2luZy1maWVsZC1pbml0aWFsaXplcnMgLURfR05V
X1NPVVJDRSAtbWNwdT1jb3J0ZXgtYTcyDQo+IC1EQUxMT1dfRVhQRVJJTUVOVEFMX0FQSSAtV25v
LXZsYSAtTUQgLU1RDQo+IGFwcC9kcGRrLXRlc3QtY3J5cHRvLXBlcmYucC90ZXN0LWNyeXB0by1w
ZXJmX2NwZXJmX29wcy5jLm8gLU1GDQo+IGFwcC9kcGRrLXRlc3QtY3J5cHRvLXBlcmYucC90ZXN0
LWNyeXB0by1wZXJmX2NwZXJmX29wcy5jLm8uZCAtbw0KPiBhcHAvZHBkay10ZXN0LWNyeXB0by1w
ZXJmLnAvdGVzdC1jcnlwdG8tcGVyZl9jcGVyZl9vcHMuYy5vIC1jDQo+IC4uL2FwcC90ZXN0LWNy
eXB0by1wZXJmL2NwZXJmX29wcy5jDQo+IC4uL2FwcC90ZXN0LWNyeXB0by1wZXJmL2NwZXJmX29w
cy5jOjY6MTA6IGZhdGFsIGVycm9yOiBydGVfZXRoZXIuaDogTm8NCj4gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeQ0KPiAgICAgNiB8ICNpbmNsdWRlIDxydGVfZXRoZXIuaD4NCj4gICAgICAgfCAgICAg
ICAgICBefn5+fn5+fn5+fn5+DQo+IGNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuDQo+IG5pbmphOiBi
dWlsZCBzdG9wcGVkOiBzdWJjb21tYW5kIGZhaWxlZC4NCj4gDQo+IA0KPiAtIEJ0dywgcnRlX3Nl
Y3VyaXR5LmggaXMgaW5jbHVkZWQgaW4gYXBwL3Rlc3QtY3J5cHRvLXBlcmYvY3BlcmZfb3BzLmMu
DQo+IEhvd2V2ZXIsIGdpdmVuIHRoZXJlIGlzIGEgI2lmZGVmLCBJIHN1c3BlY3QgdGhlIGludGVu
dGlvbiB3YXMgdG8gaGF2ZQ0KPiBsaWIvc2VjdXJpdHkgYXMgYW4gb3B0aW9uYWwgZGVwLg0KDQpZ
ZXMgaXQgd2FzIGluaXRpYWxseSBtZWFudCB0byBiZSBvcHRpb25hbCB3aGVuIHJ0ZV9zZWN1cml0
eSB3YXMgZXhwZXJpbWVudGFsLg0KQnV0IG5vdywgaXQgaXMga2luZCBvZiBtYW5kYXRvcnkgbGli
cmFyeS4gSSBhbSBub3Qgc3VyZSBpZiBpdCB3aWxsIGNvbXBpbGUgd2l0aG91dCBydGVfc2VjdXJp
dHkuDQpXZSBjYW4gcmVtb3ZlIHRoZSBpZmRlZnMgb3ZlciBydGVfc2VjdXJpdHkgYW5kDQp3ZSBz
aG91bGQgbm90IHJlbW92ZSBzZWN1cml0eSBkZXBlbmRlbmN5IGZyb20gY3J5cHRvLXBlcmYuDQoN
Ci1Ba2hpbA0KDQo=
