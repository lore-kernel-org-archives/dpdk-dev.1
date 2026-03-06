Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3EEF01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 12:19:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D11940A80;
	Fri,  6 Mar 2026 13:19:16 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1CFF9402D3
 for <dev@dpdk.org>; Fri,  6 Mar 2026 13:19:13 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 626BJ8633384088; Fri, 6 Mar 2026 04:19:04 -0800
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020099.outbound.protection.outlook.com [52.101.46.99])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cqh60ssx1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 04:19:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lcta4Dqbm174UW3T1oj/Ud0UN4oFEBG5dJ6F4lSIsXNzy2dPznwJI8g/n2vTj0yWbLZNwKuOh8SV9+xMaIwYluLx9ZoHbw9E3TBHlFF+ZWWBVrRSAJuoRsq8tpxgErH/azaHhqW5dNNHpU2ez1YH7G30Kjzv2u3M1Lnx5yphoCt67Ls2rnxZnsARKEdHG8Cl747PlqEsNq9idAJ9UsDuH3t1faNdBOR5m4N2IBfJQd64st88BtGjuCqLvANFuOD/0Q4NaZyq7heivDSS5NaHUPz7HvapnLFw7Vyind+hDtaJcyYyEw+nAJfthAfWpVlcLcqi5KHVVctrt0VJIKJb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOU7zX34am0zCQxXfMVlWNA+dKzDbVNnRhAmZg8eAeQ=;
 b=N0K1fZyEsIFCyM2ChCF+YovPDC+PHYma6Qdk3hzXfAC5SeLpYFHL1Nnnqvz92amx3W7N2+HHnLyvQOjHVq+MmJKmagfrJnaBdS2EMoowOug3KbWm6Jn80msFPXqnINSiX0TqC+p7278hnWmleURbb6C4cyOAFA3f2dS2EMt1TeA2WccoQAiJ+4axEdz8LBHQhgof8+mNZ7wWeScPfwz31ZAKL90fqHDEIOJcuRooXNjQhXCQ2I+Q6/GQTuLce0h/18NceN4A8A7ijJAB1HgUr+wfuor8jRwba83n5FhjVy1L2EQUY6xs6HoBAZq5KFpLbEZ2YkYCclVKfJa71QLPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOU7zX34am0zCQxXfMVlWNA+dKzDbVNnRhAmZg8eAeQ=;
 b=BE1H7peu3ctEN0QfYNEc6GRKJBJy7JOLQ4E4+la3+RgWbXS/CepOC5SGgPETxQGBXtvIKzc36c3PUuXd6qpOygNVvXa2q22F7EG0PsENJblC72TCG0PVYF3S5LruXla6SjUemx66QI3aB/Om3N1lRJahn6z9HTMgqgDSRqkvT2c=
Received: from CO6PR18MB3844.namprd18.prod.outlook.com (2603:10b6:5:340::7) by
 DM4PR18MB5428.namprd18.prod.outlook.com (2603:10b6:8:18d::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.19; Fri, 6 Mar 2026 12:19:01 +0000
Received: from CO6PR18MB3844.namprd18.prod.outlook.com
 ([fe80::1d71:536:67f:7aaf]) by CO6PR18MB3844.namprd18.prod.outlook.com
 ([fe80::1d71:536:67f:7aaf%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 12:19:01 +0000
From: Rahul Bhansali <rbhansali@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: =?utf-8?B?TW9ydGVuIEJyw7hydXA=?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>, Jerin Jacob <jerinj@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Ashwin Sekhar T K
 <asekhar@marvell.com>
Subject: Re: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Thread-Topic: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Thread-Index: AdytYffR9gpoKOZiTN+m6V5/PoZ1fQ==
Date: Fri, 6 Mar 2026 12:19:01 +0000
Message-ID: <CO6PR18MB384426DC59281E2B4D46A3E8B87AA@CO6PR18MB3844.namprd18.prod.outlook.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-4-mb@smartsharesystems.com>
 <aOftoMl0edarmSGB@bricha3-mobl1.ger.corp.intel.com>
 <20251019134545.203741d9@phoenix.lan>
 <aPX29qp0AcY4fzmL@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aPX29qp0AcY4fzmL@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB3844:EE_|DM4PR18MB5428:EE_
x-ms-office365-filtering-correlation-id: ce649a44-63ed-431c-d581-08de7b7a8cdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: MxWw19zC6X7aG9yQc++Vz6NjHslNLlRoLtNrgVxilp3mfEYAZt1n2eJbnY5oLbceyn1o+131sARsgjfpIr/lsl0q7zqlrk/Rpv0tWU04pg9GQVVRnU35ydnzqcGzv95rgrFJRkgmwjKIZvwOxuw9D4+9z89sjXSLuc6vAvS58AMTISWMUyefP41Xx+ZMCj089Jj7lI2NHywwPCR0d+cI9j1GI8qeRcz+HqGeNEFXFzqfcBAdcoIjdRvUri305hHZ96bDSK3UPD5LESnLY+bfUvjCgBo3zpOtMvZ8N/QUxALhML+nyfxWIGjezlq7VMTKhUKf0Uo4g2pvTZcJyAtTKqB8Te4n9FedBxnhaTgQB7eBCaGw50RKYzlKbopQDF5cc6f0hkFKQDoIWLG0fnZv3/mXN1tDOE9ntMaHqyaQoNcbIiY1+6tVflRucp7Q6mmToBoySKk/nnxLmKt9HEGsm5VZGv2QO928IQbvUP7qThhZC1W9fWC1Hf/kqCvViniJUnkJxeamZ1eA/t+446dJI1PqBqOGdUmF3YM5o4wbb3qMJwuGUS0kpZ08JgGo4k84gT1/c4mzYHhgeyFUWRETvS4S6fH18KNwPuV3Iw2YsPMWqee6fIEynGdRA4ajDUFwNa/SdgMW2EUIWT7j/NLDBVHr8jNIH6Ve/sHYp6DW2ZEAirxUnG9+UFhdkVmSXiPlQa4E2ZGM3YqhFqnToUXknCYjradImXJK/BBKnz03SFRVgvVEfEcXK72awpND9yYi8nbt94kI5uAWZ9lqV5rBugcoSHk+kFne1vs2ELd+01o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB3844.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRsR21FZkJINzhBTUU4ZUg5VHhLQ3kzTTNPVFcvOTVEVGZHQS9hVkJubWVr?=
 =?utf-8?B?TmtZOVp0YWlCQXJHaFJuSHRmWUQ4OWhqbzlQUmxxbUZHckg2bFlXZHVvZ0dD?=
 =?utf-8?B?aldqYldWVnRpZ0w4TUlDNEgwODhUV3RBc2JXNjU5bHFKa1hmNk1yOXdsSHRY?=
 =?utf-8?B?QzRzenRhUm14bTdLUUtZTnVLa0QxSER1MStOUW9LYmExTlN2cDVWUzErRmQv?=
 =?utf-8?B?NDcyK2JEZ3F2V2hjRml0S3BCL2pBcXlZNHBYbmYwUFdwSUNKYlBrZUNiaFRu?=
 =?utf-8?B?S2tESGNTNXM3Zkk4OWYwM0V3aVlIaVY2RXRmNXltb21mZ0tQZ1JDSXhiRjlT?=
 =?utf-8?B?eE1JYlorMUVyTjg5bDZLeUF0U1B5UU9FS2J0UUVrZTBoOGEzSXVNRTgxNzdW?=
 =?utf-8?B?ckxyRWk3R1lnR00raHBPZDdVZWl5VEFwSHpNN3RLTTlmU21xaWlwdk9zamM3?=
 =?utf-8?B?RWVnWVRzajJrRWU1elVRWGFmMlZFL0lpWGo4dE1EY3JkOUZybzZ2M0VxT1gr?=
 =?utf-8?B?eUl5WXIvN0MrTmxSSjZpN3ZLNUtYelBvM3FwU25TZHEzTmlsaTNHR0FCcFd0?=
 =?utf-8?B?elBvdFVjMDBrOUZxN0NiNHNwQXoyQjJLWUthdWEzNDJMWHNzVy8xaHRMNWFu?=
 =?utf-8?B?OHpNVEtFSW9LeERaaW5XbEI1b3U5NDNvNFZPZjNFSVJGYVJTUld3MytwUklh?=
 =?utf-8?B?eUw0TWJYTW9nbUlUSi9PV1hUSVVEcGxja0JOcHRxd3pYVzlGSVFLMnl5OWVm?=
 =?utf-8?B?Vmw5WlBpYUpwWFl6b0k1U2d6eC9oV3dJQjNPN3lCeTgzRExrOHVOWlFNZGow?=
 =?utf-8?B?eWIya2VldG00dENJY0JrN0QzYVZacmhkeHVBby9YS0ZLZ1JmSzRCbkZ6VEJY?=
 =?utf-8?B?U3RWTnNBRFBJa084bW85Szh5N0xqck9ic1A4bk9nOHhaZDNKZU80dHZJalY0?=
 =?utf-8?B?MFZBRnkxeWVYdHBKVnRqUFg1Z1I5L3VWU2NndGNzdjNVbXFyTkVycnNzdVlD?=
 =?utf-8?B?OWVlYUJFQUNJUGk5UEQxVjNkaUFKQTlmRys1dm5tRVVlT1QrS0FnTmNNaGlm?=
 =?utf-8?B?YisvTXBZRFpndWtNd3RUeVJ5Y0UrVlVxa3ltdXJtdHJybzBqcXdUVGlYbEVQ?=
 =?utf-8?B?RVJERGtQd1YwR01Hb2pDVDJQOENuV0I1bUVXQ0NjdVk5aG5GcXk3enNLUFR2?=
 =?utf-8?B?dTBSMjZsdHpucHBxZWRJek83bkFtNVdyQi9PcS92cDhHL2xOVG9TajdJdXlD?=
 =?utf-8?B?V1JWa1ErMUZZby9TbW5EcWluMjY4bXRNT213cTZRcm0zRWl3SmpqdHEza0dK?=
 =?utf-8?B?L0tnNXQ5VVB5MVdINFdtaElRd2NTaUFEMXAvb0x5Mkl2dUovamVTM21sb0NU?=
 =?utf-8?B?dW9FQVo2OFpwb3phSmVYeHB3TWo4a1JxYUdwWDVGd0JGeDl4U284bUttb2ZE?=
 =?utf-8?B?NnI1M3BEcHdKTWZGR3QxUUFERkNSNGJPOUljdml5TzVoTkpLVy9FN0dEdnRq?=
 =?utf-8?B?MUJqb1ozeXJzbUVUWGp0TkVpOFUxZEIyTUxzdVNERDlTVkRWNVhoRmpLOCt3?=
 =?utf-8?B?Sjgycnk5eDBreWR6dmxUSDhwQm1MUjRnYnFVNTBWMzMzVDRaeE9kOG5PZ1Vn?=
 =?utf-8?B?SVZ6Z2NGdC85QlZRNUJWVldEcXBJSnlIY29IQlYyd2pqZWlsWi94OTBDK0RQ?=
 =?utf-8?B?ZlJBZThvZ2VpSGwrVTErTmc0QzVxSXJURlFqdXFwQWxySlBtVHRjeFlmS0xl?=
 =?utf-8?B?b2wzNFMranlSMU1SOEkzQnNFK0ptVUxmaDIycTJFZEd4bDhMc1YvM1VnWGw4?=
 =?utf-8?B?OUtvcGttNnVQa2NrT1I0VTFSZWcxSWFkbXUxc2h2Z1pkWlZQMC9LOHdsWTdv?=
 =?utf-8?B?YmZUUnArQWV0WWlrcVJKRjhFR0VvbnJ5Yno1MG5hU3AzVmVqdHJOdmpxcGxI?=
 =?utf-8?B?aXV2ZVhSSWxkcDAzTXpyTEVmSklYQlhtUS80blJwQXo1WjFuVHo1aVUreVUy?=
 =?utf-8?B?NWZQWkMxblJVVkI5RjR4cmZJMkdsNXRxTWgrc0lBeTdkNUNxcDEwUDBHeldm?=
 =?utf-8?B?Q3VSVkp3aktBWGlqWlpNVTM5ZFhxUzZLWEZsck5yS2QvSHhmRmVJQkRIV1N4?=
 =?utf-8?B?c1JBVU1YUG1TbGRDSU9LK2RBV2dTdGp2T2xkQnNTR3ZlaktSRlhrSWJSU1c1?=
 =?utf-8?B?aGpBTXNpaTY1cXlkQmlSQ3JNQnV4WDFsbWVmcnFaNjNOU3lZYndXSlVLY0hp?=
 =?utf-8?B?M0R0UzI2eXA5bEY4U1NPdnk4bUhicWpRUlYzcFhOTHYxVTIydldLbTJRcFFM?=
 =?utf-8?B?T2hKNTM5NUdyeTlGaE92bWJwYlEzL2xiczNLTTMvSklaUVQwWjNudz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB3844.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce649a44-63ed-431c-d581-08de7b7a8cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 12:19:01.2119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3+vPLpj7N8mce/SeZ0GKjWQcTbj9aUhB8X/bQaVoDYTakXBmzIpZpPx4h5XQQ9DY/mqMXMslw4G25gLjOF/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5428
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExNSBTYWx0ZWRfXyr2NL2VFzj2x
 +2965Xhpli1HHqJk4hRsHKOLWWSxn0W2GXa6mBLoQyFWMWRzfHeYwlayKQTO7V3WcdlIoKGPmxD
 NDeWI8WcXAKEoIXtdjfvQ4jsiXvMVyYby1V2uRJ1SZujtNAIBf4MI7M6z80Tl7jiSTxyoEi4hbX
 /l/yj9xF0F4byU2ovE9/oT54zuEeb89/6O38vnNH9HaiXF2/PntCCTor7Q7tBrEIF4PJcnGrik0
 rLFotJ3gLAW9N/+h3oLBSwHMgk/SMd6ll0IuiVRx2m1hfg4Lf47yVkgy/jg6az+A/NVdzPMXW2F
 lpoOFgFvemu8hOEZCI0V3P/XhmizRo+Vo4RhGNs9im7wL5PJgvlFH9VqDpL/IcQQVvr7DJVM0ZH
 Xg5Fz+75p35/l47++9eaTWsp09sI93xignGBN62Fgf9PPD92rwAlGvk9SFWJzfkwcof84J+cFKs
 EU2LPpGw4DzNCr18KwA==
X-Authority-Analysis: v=2.4 cv=TcGbdBQh c=1 sm=1 tr=0 ts=69aac638 cx=c_pps
 a=s8W5O/SPP/itI6RUWNtt8g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=QyXUC8HyAAAA:8
 a=n02bokGJAAAA:8 a=jZVsG21pAAAA:8 a=8rWy6zfcAAAA:8 a=bt5KbKNvAAAA:8
 a=i0EeH86SAAAA:8 a=pK7X0mNQAAAA:8 a=iVI-LLPXuc2RUPFcoTMA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=rszdq1ld3peujIA30KyE:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22 a=5HA-qpC1VU4iIGLgRoNS:22
X-Proofpoint-ORIG-GUID: N7zJZtaR6sQP3jbMVcLXcP8sht37AoJ3
X-Proofpoint-GUID: N7zJZtaR6sQP3jbMVcLXcP8sht37AoJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_01,2025-10-01_01
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

UGxlYXNlIHNlZSBpbmxpbmUuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQnJ1Y2UgUmljaGFyZHNvbiA8YnJ1Y2UucmljaGFyZHNvbkBpbnRlbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgT2N0b2JlciAyMCwgMjAyNSAyOjE3IFBNDQo+IFRvOiBTdGVwaGVuIEhlbW1pbmdl
ciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IENjOiBNb3J0ZW4gQnLDuHJ1cCA8bWJA
c21hcnRzaGFyZXN5c3RlbXMuY29tPjsgZGV2QGRwZGsub3JnOyBUaG9tYXMgTW9uamFsb24gPHRo
b21hc0Btb25qYWxvbi5uZXQ+OyBLb25zdGFudGluIEFuYW55ZXYNCj4gPGtvbnN0YW50aW4uYW5h
bnlldkBodWF3ZWkuY29tPjsgQW5kcmV3IFJ5YmNoZW5rbyA8YW5kcmV3LnJ5YmNoZW5rb0Bva3Rl
dGxhYnMucnU+OyBJdmFuIE1hbG92DQo+IDxpdmFuLm1hbG92QGFya25ldHdvcmtzLmFtPjsgQ2hl
bmd3ZW4gRmVuZyA8ZmVuZ2NoZW5nd2VuQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjggMy8zXSBtYnVmOiBvcHRpbWl6ZSByZXNldCBvZiByZWluaXRpYWxpemVkIG1idWZzDQo+
IA0KPiBPbiBTdW4sIE9jdCAxOSwgMjAyNSBhdCAwMTrigIo0NTrigIo0NVBNIC0wNzAwLCBTdGVw
aGVuIEhlbW1pbmdlciB3cm90ZTogPiBPbiBUaHUsIDkgT2N0IDIwMjUgMTg64oCKMTU64oCKMTIg
KzAxMDAgPiBCcnVjZSBSaWNoYXJkc29uDQo+IDxicnVjZS7igIpyaWNoYXJkc29uQOKAimludGVs
LuKAimNvbT4gd3JvdGU6ID4gPiA+IE9uIFNhdCwgQXVnIDIzLCAyMDI1IGF0IDA2OuKAijMwOuKA
ijAyQU0gKzAwMDAsIE1vcnRlbiBCcsO4cnVwDQo+IE9uIFN1biwgT2N0IDE5LCAyMDI1IGF0IDAx
OjQ1OjQ1UE0gLTA3MDAsIFN0ZXBoZW4gSGVtbWluZ2VyIHdyb3RlOg0KPiA+IE9uIFRodSwgOSBP
Y3QgMjAyNSAxODoxNToxMiArMDEwMA0KPiA+IEJydWNlIFJpY2hhcmRzb24gPG1haWx0bzpicnVj
ZS5yaWNoYXJkc29uQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IE9uIFNhdCwgQXVnIDIz
LCAyMDI1IGF0IDA2OjMwOjAyQU0gKzAwMDAsIE1vcnRlbiBCcsO4cnVwIHdyb3RlOg0KPiA+ID4g
PiBBbiBvcHRpbWl6ZWQgZnVuY3Rpb24gZm9yIHJlc2V0dGluZyBhIGJ1bGsgb2YgbmV3bHkgYWxs
b2NhdGVkDQo+ID4gPiA+IHJlaW5pdGlhbGl6ZWQgbWJ1ZnMgKGEuay5hLiByYXcgbWJ1ZnMpIHdh
cyBhZGRlZC4NCj4gPiA+ID4NCj4gPiA+ID4gQ29tcGFyZWQgdG8gdGhlIG5vcm1hbCBwYWNrZXQg
bWJ1ZiByZXNldCBmdW5jdGlvbiwgaXQgdGFrZXMgYWR2YW50YWdlIG9mDQo+ID4gPiA+IHRoZSBm
b2xsb3dpbmcgdHdvIGRldGFpbHM6DQo+ID4gPiA+IDEuIFRoZSAnbmV4dCcgYW5kICduYl9zZWdz
JyBmaWVsZHMgYXJlIGFscmVhZHkgcmVzZXQsIHNvIHJlc2V0dGluZyB0aGVtDQo+ID4gPiA+IGhh
cyBiZWVuIG9taXR0ZWQuDQo+ID4gPiA+IDIuIFdoZW4gcmVzZXR0aW5nIHRoZSBtYnVmLCB0aGUg
J29sX2ZsYWdzJyBmaWVsZCBtdXN0IGluZGljYXRlIHdoZXRoZXIgdGhlDQo+ID4gPiA+IG1idWYg
dXNlcyBhbiBleHRlcm5hbCBidWZmZXIsIGFuZCB0aGUgJ2RhdGFfb2ZmJyBmaWVsZCBtdXN0IG5v
dCBleGNlZWQgdGhlDQo+ID4gPiA+IGRhdGEgcm9vbSBzaXplIHdoZW4gcmVzZXR0aW5nIHRoZSBk
YXRhIG9mZnNldCB0byBpbmNsdWRlIHRoZSBkZWZhdWx0DQo+ID4gPiA+IGhlYWRyb29tLg0KPiA+
ID4gPiBVbmxpa2UgdGhlIG5vcm1hbCBwYWNrZXQgbWJ1ZiByZXNldCBmdW5jdGlvbiwgd2hpY2gg
cmVhZHMgdGhlIG1idWYgaXRzZWxmDQo+ID4gPiA+IHRvIGdldCB0aGUgaW5mb3JtYXRpb24gcmVx
dWlyZWQgZm9yIHJlc2V0dGluZyB0aGVzZSB0d28gZmllbGRzLCB0aGlzDQo+ID4gPiA+IGZ1bmN0
aW9uIGdldHMgdGhlIGluZm9ybWF0aW9uIGZyb20gdGhlIG1lbXBvb2wuDQo+ID4gPiA+DQo+ID4g
PiA+IFRoaXMgbWFrZXMgdGhlIGZ1bmN0aW9uIHdyaXRlLW9ubHkgb2YgdGhlIG1idWYsIHVubGlr
ZSB0aGUgbm9ybWFsIHBhY2tldA0KPiA+ID4gPiBtYnVmIHJlc2V0IGZ1bmN0aW9uLCB3aGljaCBp
cyByZWFkLW1vZGlmeS13cml0ZSBvZiB0aGUgbWJ1Zi4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogTW9ydGVuIEJyw7hydXAgPG1haWx0bzptYkBzbWFydHNoYXJlc3lzdGVtcy5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgbGliL21idWYvcnRlX21idWYuaCB8IDc0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDQ2IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvbGliL21idWYvcnRlX21idWYuaCBiL2xpYi9tYnVmL3J0ZV9tYnVmLmgN
Cj4gPiA+ID4gaW5kZXggNDljOTNhYjM1Ni4uNmYzN2EyZTkxZSAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvbGliL21idWYvcnRlX21idWYuaA0KPiA+ID4gPiArKysgYi9saWIvbWJ1Zi9ydGVfbWJ1Zi5o
DQo+ID4gPiA+IEBAIC05NTQsNiArOTU0LDUwIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBydGVfcGt0
bWJ1Zl9yZXNldF9oZWFkcm9vbShzdHJ1Y3QgcnRlX21idWYgKm0pDQo+ID4gPiA+ICAJCQkJCSh1
aW50MTZfdCltLT5idWZfbGVuKTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4NCj4gPiA+ID4gKy8qKg0K
PiA+ID4gPiArICogUmVzZXQgdGhlIGZpZWxkcyBvZiBhIGJ1bGsgb2YgcGFja2V0IG1idWZzIHRv
IHRoZWlyIGRlZmF1bHQgdmFsdWVzLg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIFRoZSBjYWxs
ZXIgbXVzdCBlbnN1cmUgdGhhdCB0aGUgbWJ1ZnMgY29tZSBmcm9tIHRoZSBzcGVjaWZpZWQgbWVt
cG9vbCwNCj4gPiA+ID4gKyAqIGFyZSBkaXJlY3QgYW5kIHByb3Blcmx5IHJlaW5pdGlhbGl6ZWQg
KHJlZmNudD0xLCBuZXh0PU5VTEwsIG5iX3NlZ3M9MSksDQoNCltSYWh1bF0gRm9yIE1hcnZlbGwn
cyBDTnh4IFNvQ3MsIG1idWYgcG9pbnRlcnMgYWxsb2MgYW5kIGZyZWUgYXJlIG9mZmxvYWRlZCB0
byBIVyBmb3IgUngvVHgsIHNvIHRoZXNlIGZpZWxkcyAibmV4dCBhbmQgbmJfc2VncyIgd2lsbCBu
b3QgYmUgcmVzZXQgdG8gZGVmYXVsdCB2YWx1ZXMgYnkgSFcuIA0KV2hlbiBwYWNrZXRzIGFyZSBj
b21pbmcgZnJvbSB3aXJlLCB3ZSByZXNldCB0aGVzZSBmaWVsZHMgaW4gUnggZmFzdHBhdGgsIGJ1
dCBpbiBjYXNlIG9mIFNXIGFsbG9jYXRlZCBtYnVmLCB3ZSBjYW5ub3QgZG8gaXQgaW4gTWFydmVs
bCdzIG1lbXBvb2wgZHJpdmVyIGFzIHRoYXQgaXMgdW5hd2FyZSBvZiBtYnVmLg0KSXMgaXQgcG9z
c2libGUgdG8gcmVzZXQgdGhlc2UgYWxzbyBpbiBydGVfbWJ1Zl9yYXdfcmVzZXRfYnVsaygpIGl0
c2VsZiBmb3IgbWJ1ZiBhbGxvYyByZXF1ZXN0cyA/DQoNCj4gPiA+ID4gKyAqIGFzIGRvbmUgYnkg
cnRlX3BrdG1idWZfcHJlZnJlZV9zZWcoKS4NCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBUaGlz
IGZ1bmN0aW9uIHNob3VsZCBiZSB1c2VkIHdpdGggY2FyZSwgd2hlbiBvcHRpbWl6YXRpb24gaXMg
cmVxdWlyZWQuDQo+ID4gPiA+ICsgKiBGb3Igc3RhbmRhcmQgbmVlZHMsIHByZWZlciBydGVfcGt0
bWJ1Zl9yZXNldCgpLg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIEBwYXJhbSBtcA0KPiA+ID4g
PiArICogICBUaGUgbWVtcG9vbCB0byB3aGljaCB0aGUgbWJ1ZiBiZWxvbmdzLg0KPiA+ID4gPiAr
ICogQHBhcmFtIG1idWZzDQo+ID4gPiA+ICsgKiAgIEFycmF5IG9mIHBvaW50ZXJzIHRvIHBhY2tl
dCBtYnVmcy4NCj4gPiA+ID4gKyAqICAgVGhlIGFycmF5IG11c3Qgbm90IGNvbnRhaW4gTlVMTCBw
b2ludGVycy4NCj4gPiA+ID4gKyAqIEBwYXJhbSBjb3VudA0KPiA+ID4gPiArICogICBBcnJheSBz
aXplLg0KPiA+ID4gPiArICovDQo+ID4gPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQNCj4gPiA+ID4g
K3J0ZV9tYnVmX3Jhd19yZXNldF9idWxrKHN0cnVjdCBydGVfbWVtcG9vbCAqbXAsIHN0cnVjdCBy
dGVfbWJ1ZiAqKm1idWZzLCB1bnNpZ25lZCBpbnQgY291bnQpDQo+ID4gPiA+ICt7DQo+ID4gPiA+
ICsJdWludDY0X3Qgb2xfZmxhZ3MgPSAocnRlX3BrdG1idWZfcHJpdl9mbGFncyhtcCkgJiBSVEVf
UEtUTUJVRl9QT09MX0ZfUElOTkVEX0VYVF9CVUYpID8NCj4gPiA+ID4gKwkJCVJURV9NQlVGX0Zf
RVhURVJOQUwgOiAwOw0KPiA+ID4gPiArCXVpbnQxNl90IGRhdGFfb2ZmID0gUlRFX01JTl9UKFJU
RV9QS1RNQlVGX0hFQURST09NLCBydGVfcGt0bWJ1Zl9kYXRhX3Jvb21fc2l6ZShtcCksDQo+ID4g
PiA+ICsJCQl1aW50MTZfdCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlmb3IgKHVuc2lnbmVkIGlu
dCBpZHggPSAwOyBpZHggPCBjb3VudDsgaWR4KyspIHsNCj4gPiA+ID4gKwkJc3RydWN0IHJ0ZV9t
YnVmICptID0gbWJ1ZnNbaWR4XTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQltLT5wa3RfbGVuID0g
MDsNCj4gPiA+ID4gKwkJbS0+dHhfb2ZmbG9hZCA9IDA7DQo+ID4gPiA+ICsJCW0tPnZsYW5fdGNp
ID0gMDsNCj4gPiA+ID4gKwkJbS0+dmxhbl90Y2lfb3V0ZXIgPSAwOw0KPiA+ID4gPiArCQltLT5w
b3J0ID0gUlRFX01CVUZfUE9SVF9JTlZBTElEOw0KPiA+ID4NCj4gPiA+IEhhdmUgeW91IGNvbnNp
ZGVyZWQgZG9pbmcgYWxsIGluaXRpYWxpemF0aW9uIHVzaW5nIDY0LWJpdCBzdG9yZXM/IEl0J3MN
Cj4gPiA+IGdlbmVyYWxseSBjaGVhcGVyIHRvIGRvIGEgc2luZ2xlIDY0LWJpdCBzdG9yZSB0aGFu
IGUuZy4gc2V0IG9mIDE2LWJpdCBvbmVzLg0KPiA+ID4gVGhpcyBhbHNvIG1lYW5zIHRoYXQgd2Ug
Y291bGQgcmVtb3ZlIHRoZSByZXN0cmljdGlvbiBvbiBoYXZpbmcgcmVmY250IGFuZA0KPiA+ID4g
bmJfc2VncyBhbHJlYWR5IHNldC4gQXMgaW4gUE1EcywgYSBzaW5nbGUgc3RvcmUgY2FuIGluaXQg
ZGF0YV9vZmYsIHJlZl9jbnQsDQo+ID4gPiBuYl9zZWdzIGFuZCBwb3J0Lg0KPiA+ID4NCj4gPiA+
IFNpbWlsYXJseSBmb3IgcGFja2V0X3R5cGUgYW5kIHBrdF9sZW4sIGFuZCBkYXRhX2xlbi92bGFu
X3RjaSBhbmQgcnNzIGZpZWxkcw0KPiA+ID4gZXRjLiBGb3IgbWF4IHBlcmZvcm1hbmNlLCB0aGUg
d2hvbGUgb2YgdGhlIG1idWYgY2xlYXJlZCBoZXJlIGNhbiBiZSBkb25lIGluDQo+ID4gPiA0MCBi
eXRlcywgb3IgNSA2NC1iaXQgc3RvcmVzLiBJZiB3ZSBkbyB0aGUgc3RvcmVzIGluIG9yZGVyLCBw
b3NzaWJseSB0aGUNCj4gPiA+IGNvbXBpbGVyIGNhbiBldmVuIG9wcG9ydHVuaXN0aWNhbGx5IGNv
YWxlc2NlIG1vcmUgc3RvcmVzLCBzbyB3ZSBjb3VsZCBldmVuDQo+ID4gPiBlbmQgdXAgZ2V0dGlu
ZyAxMjgtYml0IG9yIGxhcmdlciBzdG9yZXMgZGVwZW5kaW5nIG9uIHRoZSBJU0EgY29tcGlsZWQg
Zm9yLg0KPiA+ID4gW01heWJlIHRoZSBjb21waWxlciB3aWxsIGRvIHRoaXMgZXZlbiBpZiB0aGV5
IGFyZSBub3QgaW4gb3JkZXIsIGJ1dCBJJ2QNCj4gPiA+IGxpa2UgdG8gbWF4aW1pemUgbXkgY2hh
bmNlcyBoZXJlISA6LSldDQo+ID4gPg0KPiA+ID4gL0JydWNlDQo+ID4NCj4gPiBBbHRob3VnaCBp
dCBpcyBwb3NzaWJsZSB0byB1c2UgbGVzcyBDUFUgaW5zdHJ1Y3Rpb25zLCB0aGUgcGVyZm9ybWFu
Y2UNCj4gPiBsaW1pdGluZyBmYWN0b3IgaXMgd2hpY2ggZmllbGRzIGFyZSBpbiBjYWNoZS4NCj4g
DQo+IFllcywgdGhlIGNhY2hlIHByZXNlbmNlIG9mIHRoZSB0YXJnZXQgb2YgdGhlIHN0b3JlcyBo
YXMgYSBtYXNzaXZlIGVmZmVjdCBvbg0KPiBob3cgd2VsbCB0aGUgY29kZSB3aWxsIHBlcmZvcm0u
IEhvd2V2ZXIsIHRoZSBudW1iZXIgb2Ygc3RvcmVzIGNhbiBtYWtlIGENCj4gZGlmZmVyZW5jZSB0
b28gLSBlc3BlY2lhbGx5IGlmIHlvdSBhcmUgaW4gc3RvcmUtaGVhdnkgY29kZS4gQ29uc2lkZXIg
dGhlDQo+IG51bWJlciBvZiBzdG9yZSBvcGVyYXRpb25zIHdoaWNoIHdvdWxkIGJlIGdlbmVyYXRl
ZCBieSBzdG9yaW5nDQo+IGZpZWxkLWJ5LWZpZWxkIHRvIGEgYnVyc3Qgb2YgMzIgcGFja2V0cy4g
V2l0aCB0aGUgcHJldmlvdXMgd29yayB3ZSBoYXZlDQo+IGRvbmUgb24gb3VyIFBNRHMsIGFuZCB2
ZWN0b3JpemluZyB0aGVtLCB3ZSBnb3QgYSBub3RpY2libGUgYmVuZWZpdCBmcm9tDQo+IGRvaW5n
IGxhcmdlciB2ZWN0b3Igc3RvcmVzIGNvbXBhcmVkIHRvIHNtYWxsZXIgb25lcyENCj4gDQo+IC9C
cnVjZQ0K
