Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B78606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=jeAv2ywJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3212C402A4;
	Tue, 17 Nov 2026 16:51:39 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id EB1A04029E
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:51:37 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFSTBT4117229; Tue, 17 Nov 2026 07:51:36 -0800
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020128.outbound.protection.outlook.com [52.101.61.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4j0kq1hn2w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 07:51:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5hNs+Iz+PrzJozHPt8FJxgO4aYuWkhtPd+/70147Yi2ajgJr8t6NrC85eCTXnqfFAVd/wed6Rmmbt0VxKVoBjMNgq+BfAfyeZF2GqZvzhJ0n9AboGBRJQa0vOoJaWuU8O2/feb+Xlg4RXJIS/rcWV+sL89zJM7HkFIvc2c3lzMryf9tvgEYsMainGJXPyDzK8fNfuPt5KpcaqXIv/N4/YffYPGu2mbR/dPG7VUknDfKdUNih+rNyPY3Xw++o7048kl+NsjVt3H3fmFqmY+K/rt7soe1h5CbXijndMd21tyPf+/TUhtm+y9DOBLpuZmDeLwWxQGpzOblOGbgzkmzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHxVDsOuL/jd3fdLy3cwXeE1tJki0P6XMcxROxGi+eE=;
 b=HLX9H5ah0HJiXZQaCGjU7zfy/WiIWaKhMkS2qnoxER8b/HkvmJdXDQ/ZDWr1ooF/Ph8J/pilTSbRo6qbMPvT+J7f3ma+nZEoqiSWK8tZ7C8Ogmck0xxB7sICc79DAq0UqL89gQPHjHcYxt0qCSKVqEt98K6c/KEJBfBxZXypwfuqAv4gAWQOwmUCCTbPRMn0tg27HzWr07u2d3Vo6+87XUBoz1NT+OIFJAJTSdh4o6rO1pOgPcc91FjpKEf+zQAj3yhxY12ivTTpOGod+/Jy/NLmDjIwpfd8smyp4i49Ok3tBcHMyvwQzEjmDD3owZK+d7kjgusAUwB9TUEhybblvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHxVDsOuL/jd3fdLy3cwXeE1tJki0P6XMcxROxGi+eE=;
 b=jeAv2ywJfjAHNjNg4GAOEZhLCYTQwme6Qze9hmxYjykbt2Ak2sv08re1maoSx1cCuuTBK2GkVkbkOunOJ3S6B6N80aSLrt8SQj50mFBvCKLuMeekP9NLDyxCcoRqETRaQDgEsqMaYimDnRxf9EEmw5iEvFVbOCWkzx8+IHqZtIw=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SN7PR18MB3822.namprd18.prod.outlook.com (2603:10b6:806:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:50:24 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 15:50:24 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [PATCH] test/crypto: add check for device capability flag
Thread-Topic: [PATCH] test/crypto: add check for device capability flag
Thread-Index: AQHdcfhf8JlMc/ADAEKHLdDGRamuMLcycp3Q
Date: Tue, 17 Nov 2026 15:50:23 +0000
Message-ID: <CO6PR18MB44847F448AA34B1ED8F66535D87B2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261111111412.3031042-1-radu.nicolau@intel.com>
 <LV2PR11MB6045A9F356B3E7C81B5B821981712@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB6045A9F356B3E7C81B5B821981712@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SN7PR18MB3822:EE_
x-ms-office365-filtering-correlation-id: f9d2ef1c-2ef8-4afe-0700-08df44c27e11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|11063799006|56012099006|4143699003|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261021135927099003|38070700021;
x-microsoft-antispam-message-info: vzuWfaxvdldzJlPpxbCnk8LdIWO2SqUCEwiYGt9FGNRDcUhB1Z9AH0T46w7uUcr8lt7XDhZDBwaHAQQQMW1Q5HUA5Dep/QSVrhJKjOLtEFW5qyExEgRmsi8FVr4HvVB4d/WsUZM2pMpmgJO4M9Yjk3d5KkKa0mJlWslvoBddW98KSbI+CTjY1xc9v8D0Rstdmwy+oPNjDW1RVo9jqh/sIszPIIqj+ZTFhNyWydh3EbET8Kn3LrIowqhx/KS87ZrY4Nr02U9zlVWkVHjrIM6F5fy2o7Xm3j2uzF7v/zpVjTG5aFL8fFkJwW+7E9YsxETZpDRaUey0uM3O3I3Tk0pz4BzphnE7Iv7GEeLanNLXeiLe3LTuPLBv09KpVh6QZK7kQrGV6TV1iP0+U9JO0/3NvSNXirnYweA/rNR7zDQPO1S83PKe1kEgMZpjBcXrKzqQ3ruNblRt1cMAvk1tdljRmXrxBw1vwbomGD65m5c2BV4SfgEUi1Y95Iw7IBRZKsxTkOPDI9puySUarI4a83KOPSXi/nFu96mpHyvfdfofUjzL9Lcs/8LyBzeGlTr+dMlsB1yCzqu/EKpV3oHbtZFiyRpl29/u6Jz2TKbXCOodWuaamJmizLelGx2Vaxq1/R+qBOSlnSP0WR6acmcf3fRB0OufVIyTJxC6jPaIs9tiwb+yxxemkM9SkdTPUHOAzHUlZ8BlSvRPjU3UiuTMc440hOnE8EODJLLolKVDHtrHpOw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(4143699003)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021135927099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE9NTkhKUkpDYWduajNwckZvcTJaT3A5M0lkdUYwWVd0ZmR3bTJWZ2xtam1y?=
 =?utf-8?B?dU81NkVNMEQxSk9UQkRza0xEMDVQdmJwTGtrcGt1aE12SGFhQUpqcllHVnNW?=
 =?utf-8?B?WWVKT0hOM0Y5a0VIWWd3VjFjQzRsTTBRSnUyZWZwWkphZTRPYUplVVZCdnpZ?=
 =?utf-8?B?dXBFU3ZISHcyZTBsRDJiQjhZQUQ0bERtQUM5UWc3STBONkxBcmlLWEdmeWNE?=
 =?utf-8?B?RndIWlZsdHc5c09BSS9NU3d6d1ljcWM4aEZWODA5YVpwMVdFeTNaVldpaElX?=
 =?utf-8?B?WGhOdEpadlVSRDRjckp1bCtPU2VTN3pQSXFHaXpnU2Z2b0pwNDQ4aXN6aXJ1?=
 =?utf-8?B?N3RlVHl4MGF1SkhmeEhHOHplTURsVU1qL1ZjeWx1WUxLN1NQTXUrM29vQ0RP?=
 =?utf-8?B?amtsUC9hb3ZBSkV6akZ5S3FnaXhwVEcxemVjcGQrbS9TNG9NOE1tYzRTcTFB?=
 =?utf-8?B?emExbzl2TjJ3Z3ZvSHdpZkZMQzNiVXJ5YTNiNUJvZmlrK3owOVY0QW43Q2tG?=
 =?utf-8?B?WCsvZFIwd0ZxTmUzbkV1cDBJajhtTHpJTUtiL3BvcGkvQVBLUkFrTzVndFhX?=
 =?utf-8?B?MW0wQUttamJRVnRDMjE5b2dPWUpoUFlHNnlmRmNuRVJLODhuVnRlZlViSUVv?=
 =?utf-8?B?ZnUrQlNhdkVvRFRJUm1sMlhjWElFREVtYi9vQ20xNXV5R0ExY2E3b3BuNEhJ?=
 =?utf-8?B?THdqR1dDNmVHODFEUFBBdUMxOE1YWjNYTlZNUHV2emVnQStScmpxM3JkS0Iy?=
 =?utf-8?B?RUY3aHpsTGowTjcwQ3FZVlpSUDJkSlhoZG1xNG5lYUFiN3hQUGNuc054ZWta?=
 =?utf-8?B?cEFoRVBoR2o2U2VnTnNpMUNYbTAzaVBaTDVyeEJtMWhUNkZhSEJ6TUxmR1c1?=
 =?utf-8?B?dTRNZEI3cTJiSXV2bWVySXN3UEVPd2F4NzlaUUZyVWp1Q05UV3ZyT0VsSk5k?=
 =?utf-8?B?SytLWWNpL1hPTmtpV3lkYm4rQ3Jpd2JoNGFXT0xuRjNBaG05QjFlakk4VEJx?=
 =?utf-8?B?WHNnZnNxZlFXUzJqZWQxUHRpbEVEQ1VpcXFUUTJjSWRRY3o2cWVDTEJOKzFo?=
 =?utf-8?B?K3kva1JVOWFBeHdUeWdZSTd3K3daU1doOHpab2t5bko3NUxvUWI5Y1d2eXRZ?=
 =?utf-8?B?R2FCOG8xUmhIOUkrV0M1S3ZxaUN4dFoyVmNmdHJXREladGdvNlJWNGgxaEFs?=
 =?utf-8?B?SEhtWmN3VUw0SEFZMlM1Q2tuT2xkWk8weXpncXEwUWwxTEJxUXlNU2d3U0ps?=
 =?utf-8?B?K295c0NCcURoOFRWTXZVVTJFZkFhQTJ5V0dma1FJRFM0bCs1cC9icTU3cUUz?=
 =?utf-8?B?Y1Q0ZVg0cGZhdzAzeEhCVDNKUjdtU1U4TDcvZThMMFpHWDV2WVZEbk9yVzEr?=
 =?utf-8?B?VmJaK05iRk1NVUF6WHBYTkkzSjNCajhLWWZQQkpOM2xHeFFKM0xsNjZFOTdn?=
 =?utf-8?B?TUhhaUxwbEhvWUxDSWxHTkx4enlEQlIvZGk0UDdhSW81dGtMeXBWNGp3aWFU?=
 =?utf-8?B?ZUZnOUw3UnhJK2QyZERRWlNaaEc1TWR5ZCtnemRmUXlWdDhuMGJURDhLQlRq?=
 =?utf-8?B?anBBczZPdmxUYmY3bytrRkhQNjlVREF2MWdWMkNBWjBUazh5dlBlUmVqNTdt?=
 =?utf-8?B?d25vUkRhdk0ycUVvcE50dzFrY25TbVpSWEdEMGpKTnUxQy85Sy8yWUJ4UHFo?=
 =?utf-8?B?cHdneEltT21wVy96TEtid0hWZEtRRFMvTTRHcWc1ZWcxNmUvaWtMeHRjV05Q?=
 =?utf-8?B?OStSY1RrNUZ2b0dpelM1OTk1T3hyOE42VzhaYUdiVkhvb3MzY0s3cndMOXhM?=
 =?utf-8?B?eWxId3BDZmRQcTZVQm1zTDBGb01oODFhU0liUmZvdXlRV1hXREVxamdRN1NS?=
 =?utf-8?B?WTFRWXVuRXpRcEpDbTEzakp5ODg2WXpVVTNUdHk4ZTFwR0dqRXRHMm5vN1Ev?=
 =?utf-8?B?bDBsY2I3V2V4Mm1KM1pJNXUwSVl3L3ptNWdFWGtrTlJtbnY4Z09iNVBKTTdr?=
 =?utf-8?B?NFJ4eDlmczYxM05YQ29tY29BR1UraHp4ZVQ3UXFPUVJBNDBXWHR5L0ozbThC?=
 =?utf-8?B?MnNudTFlT0cxMEZHT2ZjVkR4TGdCVzZVWFNFSXd0UmtBd1d2VTVKV3JUSGhh?=
 =?utf-8?B?Zk5oK1hHTFNuMzhtM1dEQXNaeHEzTVB0QnVGZUdhNk5nMUlJMjV4L0MrYUZm?=
 =?utf-8?B?Mi81OTRLZHhWendKYTY1bDE2S0lHQ3FKQit0cDhsc1k5c1VyVlVWWU9SWkQz?=
 =?utf-8?B?M09zeHI1REZEV0V1cEYwODFtUXpCTUhQZzdlQ2dxWEhaWVVielZqMW1XdVZ1?=
 =?utf-8?Q?ZGnDzs4l4zQ/eq65EK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UA6sPMXFBLcoaYEsx7YNhYAxeFjanDjernWLb8Y5AmIwgqepsHN5vQDl18HRGZ3+UHxzNDbC/ku9nY2JKlXeKFnHW8So9UEAHYft8ZFRVam3qnws92VJwvKTCHihAENYIqVNKxqsNnUAWpFvdFJ8I17GHLWBJspgsBZyZ+HHLmFVIzyAWPO5zc8qajKgmeuLtNvTE6w9tg4buNBZikbkmSONo86vjgGNND4rYER4RgzFoFhmbI6TZDFIIFlN+ii72o1NgT9sR9GQ9ePaZ8+aFWlmDbRUrFYOzOvEUwLiBrT0U9mKo0Jh8BDZcsr0Rm41fpvSFjiVl6fu+siASTtTjg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d2ef1c-2ef8-4afe-0700-08df44c27e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 15:50:23.9188 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDbRjC6BbGD6pdqCjBKf0pM32PiYYuoAxeqxyB/OFHVzpqFstJdwAmG/DecuomwNqPrNgGienWmPir8PQTdxcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3822
X-Authority-Analysis: v=2.4 cv=WrK+otfv c=1 sm=1 tr=0 ts=6afc7808 cx=c_pps
 a=8h7WK4dQWB09CNKj11a7yw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8 a=BYSIkjZ4tEzapRSysqEA:9
 a=QEXdDO2ut3YA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: sGJN6vNBdT9X3i_6iJoDJLadSVuZDQeu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX+Ma2oApMeoUU
 tT5o4+MkDtiPS7qGNUgT6tT/J6J7mKeW4dNvXKdabK/wscXyfJWak+nZ6Nd+ByKYfwcQS8eXHZ5
 tFb59d38kehybKB6zWBpncTW/7rIlLA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX6bv5BRUB1kvY
 hZdxjiMyB8Us+kwBBT726mc0cucjAYt6+bUUs0rZ33hGMq+mu3/WlY9POsE4koIic/IaxImpnE7
 3V+baRl9dfmW4Gv/Nwx8EA+0RwQ2s8ptGRGiWWpdmCL9sf3wwbHgIx96JRFxxCMVZlv7Jv9N0sI
 Ddpwvb5jWCkEjxosrwMFy8zJ0ZtlXrsuwjvwWVT6mRDo7U61/pamGbG94J/48BGCaAypBUweUvp
 FR8DVbc/zc04MCDo4WnIb23hqFwPFexxVE15oHgVZTLItXBsfACRrsOy10fdxD487MyRkON52V8
 teFt+9bit3xlvUONE8OtREo5NVX08bmLWo2aE7YLSHUdfEntazLXTXD5bohX92b2zuU9sx4Ndg+
 Q43K98oXlWOioV4tRwhC2gZuik5hfkZ4xlMt4hswaDuEbQ7CaY+YEVsvhSsZOONGEi4NgY8qDFE
 L77LvA9bMjxnN1qYngw==
X-Proofpoint-GUID: sGJN6vNBdT9X3i_6iJoDJLadSVuZDQeu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBBY2tlZC1ieTogS2FpIEppIDxrYWkuamlAaW50ZWwuY29tPg0KPiANCj4gRnJvbTogUmFkdSBO
aWNvbGF1IDxyYWR1Lm5pY29sYXVAaW50ZWwuY29tPg0KPiBTZW50OiAxMSBOb3ZlbWJlciAyMDI2
IDExOjE0DQo+IFRvOiBkZXZAZHBkay5vcmcgPGRldkBkcGRrLm9yZz4NCj4gQ2M6IE5pY29sYXUs
IFJhZHUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+OyBBa2hpbCBHb3lhbCA8Z2FraGlsQG1hcnZl
bGwuY29tPjsNCj4gRmFuIFpoYW5nIDxmYW56aGFuZy5vc3NAZ21haWwuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0hdIHRlc3QvY3J5cHRvOiBhZGQgY2hlY2sgZm9yIGRldmljZSBjYXBhYmlsaXR5IGZs
YWcNCj4gDQo+IFRlc3QgY3J5cHRvZGV2IGZlYXR1cmUgZmxhZ3MgZm9yIG9wZXJhdGlvbiBjaGFp
bmluZyBzdXBwb3J0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBOaWNvbGF1IDxyYWR1Lm5p
Y29sYXVAaW50ZWwuY29tPg0KPiAtLS0NCj4gIGFwcC90ZXN0L3Rlc3RfY3J5cHRvZGV2LmMgfCA0
ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9hcHAvdGVzdC90ZXN0X2NyeXB0b2Rldi5jIGIvYXBwL3Rlc3QvdGVzdF9jcnlwdG9kZXYu
Yw0KPiBpbmRleCBkOGM2NGExM2FlLi41MDUxZWU3ZmFlIDEwMDY0NA0KPiAtLS0gYS9hcHAvdGVz
dC90ZXN0X2NyeXB0b2Rldi5jDQo+ICsrKyBiL2FwcC90ZXN0L3Rlc3RfY3J5cHRvZGV2LmMNCj4g
QEAgLTgzNjAsNiArODM2MCwxMCBAQCB0ZXN0X21peGVkX2F1dGhfY2lwaGVyKGNvbnN0IHN0cnVj
dA0KPiBtaXhlZF9jaXBoZXJfYXV0aF90ZXN0X2RhdGEgKnRkYXRhLA0KPiANCj4gICAgICAgICAg
dWludDY0X3QgZmVhdF9mbGFncyA9IGRldl9pbmZvLmZlYXR1cmVfZmxhZ3M7DQo+IA0KPiArICAg
ICAgIGlmICghKGZlYXRfZmxhZ3MgJiBSVEVfQ1JZUFRPREVWX0ZGX1NZTV9PUEVSQVRJT05fQ0hB
SU5JTkcpKSB7DQo+ICsgICAgICAgICAgICAgICBwcmludGYoIkRldmljZSBkb2Vzbid0IHN1cHBv
cnQgb3BlcmF0aW9uIGNoYWluaW5nLlxuIik7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4gVEVT
VF9TS0lQUEVEOw0KPiArICAgICAgIH0NCj4gICAgICAgICAgaWYgKCEoZmVhdF9mbGFncyAmIFJU
RV9DUllQVE9ERVZfRkZfRElHRVNUX0VOQ1JZUFRFRCkpIHsNCj4gICAgICAgICAgICAgICAgICBw
cmludGYoIkRldmljZSBkb2Vzbid0IHN1cHBvcnQgZGlnZXN0IGVuY3J5cHRlZC5cbiIpOw0KPiAg
ICAgICAgICAgICAgICAgIHJldHVybiBURVNUX1NLSVBQRUQ7DQo+IC0tDQpBcHBsaWVkIHRvIGRw
ZGstbmV4dC1jcnlwdG8NClRoYW5rcy4NCg==
