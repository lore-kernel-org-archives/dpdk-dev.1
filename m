Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CF1C5ACAB
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 21:18:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFA07402AC;
	Fri,  7 Aug 2026 23:18:51 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id D009940265;
 Fri,  7 Aug 2026 23:18:50 +0200 (CEST)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677IvN5J3880035; Fri, 7 Aug 2026 17:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=0
 0JkXnc9m4W2Krspb5bmSjMQ6nRBnr5pafcF98DrnJA=; b=a+pbyH0gpo2L8h2vF
 NVc+M46+Z9hRiZ6mvJ/0rQ6beOLRliYaQBeDntiIGslRshcZT4QkhZ0xkJBGApBr
 AU3LfREWhBFgjUCU1z3M1vXv6Qu957/cKy1wu4+qrmcekoNl/Vbrsee5Lu+fQE6S
 0QcZS6+85oKUdPM8fkPy1sXoNopcFgYm+xjdvegRI+oAn3mzGa0sxObD5dB2F1xl
 D6HtEP/jTijEv17ZryiXmckBKB82Nw7Um+QWXFAFZxu6eV7AoVCR9Lpu26S07dl9
 GPPw3uwdxiJli7qG14l4JsyBY9R9mNKiTbAzAAC6/IIlETwT3xkeSf7d5fGtrQd8
 PCojw==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4fsby8wcab-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:18:49 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677KbUb61650134; Fri, 7 Aug 2026 17:18:49 -0400
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4fwpja8dsr-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Fri, 07 Aug 2026 17:18:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4Eb/yg0WtfufQWt++4ABXZucMG8RMSJDFqWXUL1F+w/Sq/n/nz8YyIfIlTN49VgMbq+pNTc0RS62OmI11bgwZ0q0a2ZLofjzkGgyZ8AQTtCc5Bal/icAi/PVh1gvd+i+N4n1l+LjyVsyv3XYPHvb+Z1tClhbMl5Yg765AY3heYHOgYMnMrf/t9fvTIUvDDLKEi2RzPN3MufhiGzS6CmUhkSeEu7A6Kmnl1IpFsQOMw87LB30rZuvsY97HtnqkQQZpRefQf+N7dvCT7NawiXf6Mrj5ZTAiZNkn6lHQadcToU3P/4ckqo1VAwUMe8T0ZszatFmWOPNoCpbbfbqPs6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00JkXnc9m4W2Krspb5bmSjMQ6nRBnr5pafcF98DrnJA=;
 b=Lk5rXSOoqNtHNNJpHgzV21bRTmEmywq9DGeNR1ppGscpj+Lc/fcQJQ4yFAskxLAcrK26W4UWXIYcXIMYqRyRL6+6MQNLvO0DZUkVbzlkoxCykFEXTKLYGtVL6qcyfXeoNUWoVbKn4ucsJfeVVs0XVACshvk6pUjrX+entefZ/odMKC+K86vxvSnYNPZ7ewlXccwx8XyAVswea6WbvlxBZlp5keJScvviw2CyiuqYrinOt9XEDJm0VuOLxSn7OflNIUWwqJewdFcoV1kvkM6GhTaA5u6738fQ5AJ7VTbJo5dMzetpTQ5NDJ+6ONuWUF3C/IghGPimtquvELIEQoBSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 (2603:10b6:20f:fc04::ca9) by SA3PR19MB9503.namprd19.prod.outlook.com
 (2603:10b6:806:49b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 21:18:44 +0000
Received: from IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267]) by IA0PPF659BD4C46.namprd19.prod.outlook.com
 ([fe80::3375:a560:cdb5:4267%8]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 21:18:44 +0000
From: "Bathija, Pravin" <Pravin.Bathija@dell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "thomas@monjalon.net" <thomas@monjalon.net>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Topic: [PATCH v2 1/1] vhost: tolerate file descriptor in REM_MEM_REG msg
Thread-Index: AQHdIJqmnf1/7bON30W14JW0Wc3J87aHKHoAgAAJu2CAAAjrgIAAC/nAgAB6AwCAAB4JQIALQ3Eg
Date: Fri, 7 Aug 2026 21:18:43 +0000
Message-ID: <IA0PPF659BD4C465FE225045F03A10056E2F5D12@IA0PPF659BD4C46.namprd19.prod.outlook.com>
References: <20260731031355.3578236-1-pravin.bathija@dell.com>
 <20260731031355.3578236-2-pravin.bathija@dell.com>
 <CAJFAV8x137vqFU8bptTFhxjusYG1wYHxkvE46iMRif7+84_w9A@mail.gmail.com>
 <IA0PPF659BD4C466F2C7E46C7DF91081BF6F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <CAJFAV8xPCRAerr-goiD5UbxPjmy5ddyb0ew8FK+nZMdu_g1kDQ@mail.gmail.com>
 <IA0PPF659BD4C46C174C843A7FE6C0208C2F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
 <20260731082756.31f7a9d8@phoenix.local>
 <IA0PPF659BD4C4653EA823F77F74FBFEE61F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
In-Reply-To: <IA0PPF659BD4C4653EA823F77F74FBFEE61F5C82@IA0PPF659BD4C46.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2026-07-31T17:15:25.0000000Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=3;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PPF659BD4C46:EE_|SA3PR19MB9503:EE_
x-ms-office365-filtering-correlation-id: bcdaba03-95d3-48d3-2594-08def4c97641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|786006|376014|23010399003|1800799024|366016|38070700021|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: mSrD+nIU/qGCytEKTfuALvmE3F1aLIndKgOmkh1cIOIzYSgPQwNFR6weIZGefUM5SA/utHmvtJmJRbiVqlhomM252jEB+TAspMEwaTKXStmekwBRb53/ifBaEkf9UHuyW03kAFknwoshCiJSt73iUL6ek5LG16tvuHxujnznima7Nv9/Sf5F9G5iWERefI+PYtUJgiqvY6tRDzKBVY40ZhEodrBIkr0LWYJ5V4ipl5oeOaD3pLoPRdWklj6uvPEwV0xh41bY8+sdHFmm7hmbXOtOZLGkzZYfcuU5sQveFLXETAgybLvWM9mLaBcs6bVmNPh3v2Luye6D6wAAKI/aJ5qoBJ3naKQ6FmHpN6aTh8z0HTePP5gcAlFB4f0EETrDItV09qBehs8EvmnqOokXYQTfANboB4TPuKppHou+QgC/1CeCAVmhj6CFrx2ZbTXRKgurpOn7/7iCHeM06S+KgxLIUTwEnb3+JhPqNrVuBXVh7IShoDPXUx1220bI7WAiOVIMu9yIBuWgga8+SD1LNTyl0dltD9mtYxFJDJnZ93CMr0AnveP/7arqE5E3bxrb93t76dz6U0woIEF/5WDgWwcblOUCZtbI2NKReGb39ILZCPTiUv6kXIXQ9Dk9mkXBgPah2ZJvDbpn2ueGKQPfTx4+sv7MQEyi3t/N5u0jtzQ16i6JAPH3DfpzfHeF1rTMXrNdf1nUcJRxOHr4HdPuuEi3gqE1TcpYjGXt1y1q+FE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PPF659BD4C46.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(23010399003)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnZibUdNZEFoU0IxZnVtbUZ6OWF1aGwxK1FtS2phbklTajVFbTVDcitnYXdU?=
 =?utf-8?B?dENLRXl2M1N5Nkp3bUk0aTloNUttZURsU3hUWm1xM0FCZkxXN0twaFk3RFB2?=
 =?utf-8?B?NG02UHZDNkRKcW5uL1FicTEwQVdwUUtCMjdCSnN6QUIrV0xzMVFJWGhPeWha?=
 =?utf-8?B?N1ZpK20rNFp6ekZqSlV4YThjYWNVWElKSDJ2Yks4SmY1aHc1S2d4UkJXaWoy?=
 =?utf-8?B?NGt5NEVhNjU4Zk1tK0VLVVR0aXZLdFdyKzhkbmR5WGJJR0VrVFcrT3FjMEkw?=
 =?utf-8?B?SjFLdjM0UUpzU3N3cnFSNkc2ZnRxTjVLNzBmdDQ2dFBoQ3pNWXJxUS9UTzVa?=
 =?utf-8?B?OWJZMzlKYkFKZTBpU2V0U0RNZzM3NVk4cTQ2d0hNaHRNMi8wc0dMWGlLMWJW?=
 =?utf-8?B?bUFXUzNxTGpKMUJVVmtOeWlqZWw3MERtN0djZ3k5Ym9SMjhzdi9JSGV2dUUw?=
 =?utf-8?B?MG1UNGllZmNVczVtTjZPTHFQMWpNWEVDdjdWcjY2WW13MGVsMWoyWVRGWXVI?=
 =?utf-8?B?bThIaThvcllZYUlUZnJzM2JQbUcyN3dSdk94SkFMZXJIa3h0TUhZbnVuQU56?=
 =?utf-8?B?cmdQU25GOU9aZWRzdSs3OVZrTTNsaVB0QXJIVHN3Y3Y4TVJHY2ppSmhDNnA5?=
 =?utf-8?B?SmVZZkthZ09mTlVVc0gxQ1ZpMHBzb0MveHQyMk1wc2s2S0phNVpydHoyQXpz?=
 =?utf-8?B?bkovaTl3ZWw5b3U3MWhvUWdUYUFoNStWYS84UHR6WnBiM0NiWG1Pdml4NUlU?=
 =?utf-8?B?dld0RmsvVUtzbit4a3VBLzNxWFhXNFdXdndkWVJUOVI0SVEvaGt0MWwxc0cv?=
 =?utf-8?B?Y3ljUmQ0RDJnY3V5Yk5hQ0tNWjFhSVZiQzlxVG1ITXZiUW9PWlA0Tkp0Y2pT?=
 =?utf-8?B?Si9MME05MkF1d1Z4a2R2cTF2ak1oaU9pQ0NlZTM0K1c3TFJ3VzkzMHd0WFN1?=
 =?utf-8?B?Y3h6aS91amtIaTRZQ0loTFhXYktESGJaWThIRndBZ1VZOGFVYUlvdHYrR0Ir?=
 =?utf-8?B?SW1Fd2x6UDR3dXFnQ1VvYlhPRW1UYi9naHRtaVY2RVM3em1xaGN2VXY4a1Qx?=
 =?utf-8?B?NjlVTm9XYjQySGd4T2lGKzZSdnkvUEVSZDJDUWxwUWJkT29uS1NMYXZRUGQ1?=
 =?utf-8?B?V0dJODdLejZ0ZXMzZmQza2J4Sm5VUElzSlZ4QzF6SVRtUzRad0ZHMzY2WXdh?=
 =?utf-8?B?TTliaEIvZjJLdjZiNXFQVDc2V3hpdExyemlvWTFydC9vYUkzS3dpdk5jbnYx?=
 =?utf-8?B?TkNJdTJJb2VzQk12R21taUJsUkIwcTVnRlBlZlNzOXppWk9NVVpqTWYzY0lx?=
 =?utf-8?B?TG02Znd1a0NJaXRPRXZ3N2k2dzJXKy8rb1VSRHZlTFdLUmdKZVY0UFZlR1Nt?=
 =?utf-8?B?UDYrUXd5dUE1WUkyVTB0ZHhtVld4c0xXOVVWUGU2VmExemErdmRGSnhod3Rw?=
 =?utf-8?B?VFdjaXQ1TXZpSUR5ZXRJSWxYNDVCa2hXcjNyRlJpejduOEk2Z0ZiMVZ2L0dK?=
 =?utf-8?B?SlNSRWRtUUpiQXUyL3gzTnVuWUw3V0p2UXlmOHlvTzJDQ2hXTW5IODZ6ZlFj?=
 =?utf-8?B?S3cvU2hyVmpKcU5UYlpqQjhQSzZGREhrVVFqUjljdXlDQXYwSm44MnRTRnJQ?=
 =?utf-8?B?amVKZE9JeE9jM0ZSdHhRTnNtclBCVXFEb3F4cjBxNTdDRzIxdDYzdFlYdVp1?=
 =?utf-8?B?ZGV2T2h3VGNTL2ZCN01CY3h2bWpmZFAzcXFObjU3TVNEYXBodmhWSm5LdXdO?=
 =?utf-8?B?Y1haZGczekxkWXhyYkx3NUVyN3hoalFLTkF3azFLTzdoemxJZTFmd1BQVWxu?=
 =?utf-8?B?TytlaFFsdlZYY2J2L3VOTUZERE1zVlFFNE00Q2lhK1FRNjd5YTV2TFVPMnZx?=
 =?utf-8?B?RERnaEozVnl3Y3YzUU9yMWQxSkhEWks4c0F6RlBmWXU1STVXaEY3NHBvNkxV?=
 =?utf-8?B?UDBOTng0ZUFjRmpkQmlVK3ljV0NMSzlndXdkYTZackhlQ3BEQzgvUlNpL2c3?=
 =?utf-8?B?ZUdOeldmTk4xNE95S1NPS1Y0anIzUjV4N2tpZzlhb09vUVFVZVpaNGtEQ3ZY?=
 =?utf-8?B?M3BYalVtY0ZWcWh3RFptNDFDMFI5QnZuQkVReGxqblFMbUMvTm9OU2g1RTl4?=
 =?utf-8?B?Z0VsbUJ3Rk1hTklWWnBwUHB2MHcvL0IyNVQ3MmVraXV2U2Z4ZnJvakN4ejhJ?=
 =?utf-8?B?alh4aXllM3ZTVHBtdUdIS1FHT2xpb0taMHdtUG95Tjh0NmRCeGVadVZSVmwr?=
 =?utf-8?B?SXdQM1NQVU5wRTFTZXVxSjVpTUZ4QWZnUlpYcEU3T2hCRERldmFGSkkzbkRW?=
 =?utf-8?B?MTg0dVhBUlJuZTZBWnR2cWJhUGxNK0doakcyYWNLS0R0elkraU5pQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YiQXN+qH9HoQwKMOVxrm1hSxex5akaQAstbl8Cw8rhSe5jKKYmgy+Uy+IUnN3UG8fqPg2xhhIsyiJgJhGpUD4PORHAfbeQ1qpmw38zO1wkU9WQJTKgI27+69hJwKSeFZG02ENme0uVh3BItN1l8o0JfeTwDKmuLXlUsyQmYMKlXCwfwzOsYEzLF+lOC4D3xsJD1//n8d8g+g/96Z3yFG2anjd+7OmiZoSj1ghMUcLY1LmcXp9SjcGj3LHh0ekvCcTQyIYUBJTDlOgXg6Rjy1qat9yZ4TcuThX9TmF3EJkCfWJGMrT64VmYcfa6YTb8M9Kvgf+an6B343oDQOOZBUXw==
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF659BD4C46.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdaba03-95d3-48d3-2594-08def4c97641
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 21:18:44.2317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7hnrvwLBKmCdLAVk6jo1rb26rW5Pbl+b2Wv9GFLREARPCAe0Pmj7jR/U/nTe7Q6JWIGkfGUD7PXh4v63yNCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB9503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070166
X-Proofpoint-ORIG-GUID: BNYwCL-7VVYcJ6A9JmBzAMZrKgfwaD3E
X-Proofpoint-GUID: BNYwCL-7VVYcJ6A9JmBzAMZrKgfwaD3E
X-Authority-Analysis: v=2.4 cv=TtjWQjXh c=1 sm=1 tr=0 ts=6a764bb9 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=6gNNCFAoQcIphELLPWWu:22
 a=m3zZTHMLHbwB7Lmtoed2:22 a=jZVsG21pAAAA:8 a=20KFwNOVAAAA:8 a=8rWy6zfcAAAA:8
 a=i0EeH86SAAAA:8 a=bt5KbKNvAAAA:8 a=iLNU1ar6AAAA:8 a=JZDpSyd8ZSOyTjquNfkA:9
 a=QEXdDO2ut3YA:10 a=gbU3OgOOxF9bX48Letew:22 a=3Sh2lD0sZASs_lUdrUhf:22
 a=YjdVzJdQTyZRADMV7wFX:22 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE2NiBTYWx0ZWRfX43RPGzjjVw22
 Jn9vBpcZKA9QCIOCV8gnmavXEdNRACAipEcvx9PypE9VvqGcCN1ZqpHuTKaXl8KFfoFZBj1eO4f
 kXFKJIdX4hcZbu1OQUJoODe1GVKZY10=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE2NiBTYWx0ZWRfXzuec5yuIdkPU
 8Swk0kVbKwzs1OL1ZyvSNQZn1CnFWNZWrX4CwLQ1YuqYfIW9X/dFyBUw5caCrQVt6aBVi613LTc
 V0Q9tA5iIOQGOvUEW6dJScDgUkmwbMD6SGN0W/loq4VJ7wGuVkq7eFobmnnwDC9VX4AAh1bV7K+
 zGtSxNwxrrwB1TJiVDVjL+fAGfQmSMI1hZsa04aQixye+49T1MyZLELU1bx7ZmGvfy6WBpQRvzr
 jRB2PefNJzOVypUmtaKyOaqv/Xdl5d2owVZloqWeCu2JEAq2CORcl4UL1/Ndyu/ROGhNOcStxKW
 2PwAbVTMKZeEYVeJQ4jzTfCKyXzmKvD57mOvzj1bRiZOvudCsIv7O9VfGp7cO6v5lvs6e4pCObb
 5XtkO+6HxngCaXar4A1RQdEXFnZLD4DivRxl4tMKPk0QZkkYH9pvmH+OfIWnSmOZbEUlntkZfCK
 4IPin7kBMBTJBCFJE8g==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070166
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

SGkgTWF4aW1lLA0KDQpJIG5vdGljZWQgdGhpcyBwYXRjaCBpcyBkZWxlZ2F0ZWQgdG8geW91LiBD
b3VsZCB5b3UgcGxlYXNlIGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2ggYW5kIHByb3ZpZGUgZmVlZGJh
Y2sgPw0KDQpJJ20gaG9waW5nIGZvciB0aGlzIG9uZSBsaW5lIGNoYW5nZSB0byBiZSBtZXJnZWQg
c29vbiBpbnRvIG1haW5saW5lIGFuZCB0byAyNi4wNyBzdGFibGUgc28gaXQgd2lsbCBtYWtlIHRo
ZSB1cGNvbWluZyBTUERLIHJlbGVhc2Ugd2hlcmUgaXQgd2lsbCBiZSBjcml0aWNhbCBmZWF0dXJl
IGZvciB0aGUgdmhvc3QvbGliYmxraW8gc3VwcG9ydC4NCg0KTXVjaCBhcHByZWNpYXRlZCENCg0K
UmVnYXJkcywNClByYXZpbg0KDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYXRoaWphLCBQcmF2aW4NCj4gU2VudDog
RnJpZGF5LCBKdWx5IDMxLCAyMDI2IDEwOjE2IEFNDQo+IFRvOiBTdGVwaGVuIEhlbW1pbmdlciA8
c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+IENjOiBEYXZpZCBNYXJjaGFuZCA8ZGF2aWQu
bWFyY2hhbmRAcmVkaGF0LmNvbT47IGRldkBkcGRrLm9yZzsNCj4gbWF4aW1lLmNvcXVlbGluQHJl
ZGhhdC5jb207IGZlbmdjaGVuZ3dlbkBodWF3ZWkuY29tOyBzdGFibGVAZHBkay5vcmc7DQo+IHRo
b21hc0Btb25qYWxvbi5uZXQNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiAxLzFdIHZob3N0OiB0
b2xlcmF0ZSBmaWxlIGRlc2NyaXB0b3IgaW4gUkVNX01FTV9SRUcNCj4gbXNnDQo+DQo+DQo+DQo+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBTdGVwaGVuIEhlbW1pbmdl
ciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc+DQo+ID4gU2VudDogRnJpZGF5LCBKdWx5IDMx
LCAyMDI2IDg6MjggQU0NCj4gPiBUbzogQmF0aGlqYSwgUHJhdmluIDxQcmF2aW4uQmF0aGlqYUBk
ZWxsLmNvbT4NCj4gPiBDYzogRGF2aWQgTWFyY2hhbmQgPGRhdmlkLm1hcmNoYW5kQHJlZGhhdC5j
b20+OyBkZXZAZHBkay5vcmc7DQo+ID4gbWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb207IGZlbmdj
aGVuZ3dlbkBodWF3ZWkuY29tOw0KPiBzdGFibGVAZHBkay5vcmc7DQo+ID4gdGhvbWFzQG1vbmph
bG9uLm5ldA0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8xXSB2aG9zdDogdG9sZXJhdGUg
ZmlsZSBkZXNjcmlwdG9yIGluDQo+ID4gUkVNX01FTV9SRUcgbXNnDQo+ID4NCj4gPg0KPiA+IFtF
WFRFUk5BTCBFTUFJTF0NCj4gPg0KPiA+IE9uIEZyaSwgMzEgSnVsIDIwMjYgMDg6MTk6MDcgKzAw
MDANCj4gPiAiQmF0aGlqYSwgUHJhdmluIiA8UHJhdmluLkJhdGhpamFAZGVsbC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gPiA+ID4gV2hpbGUgdGhlIGltbWVkaWF0ZSBtb3RpdmF0aW9uIHdhcyBsaWJi
bGtpbywgdGhlIHNwZWMncw0KPiA+ID4gPiA+IGNvbXBhdGliaWxpdHkgY2xhdXNlIHdhcyB3cml0
dGVuIGZvciBleGFjdGx5IHRoaXMgc2l0dWF0aW9uIOKAlA0KPiA+ID4gPiA+IGFueSBmcm9udC1l
bmQgY291bGQgbWFrZSB0aGUgc2FtZSBtaXN0YWtlLiBRRU1VJ3MgbGlidmhvc3QtdXNlcg0KPiA+
ID4gPiA+IHJlZmVyZW5jZSBpbXBsZW1lbnRhdGlvbg0KPiA+ID4gPiBhbHJlYWR5IHRvbGVyYXRl
cyBpdCAoc2VlIHZ1X3JlbV9tZW1fcmVnKS4NCj4gPiA+ID4NCj4gPiA+ID4gV2hpY2ggZG9lcyBu
b3QgY2hhbmdlIHRoYXQgSSBkaXNsaWtlIHN1Y2ggY29tcGF0Lg0KPiA+ID4NCj4gPiA+IEkgY291
bGRuJ3QgYWdyZWUgd2l0aCB5b3UgbW9yZS4gIFRoZSBsaWJibGtpbyBmaXggaXMgcmVhZHkgYW5k
IHdpbGwNCj4gPiA+IHN0b3Agc2VuZGluZw0KPiA+IHRoZSBmZC4NCj4gPiA+IEluIGFuIGlkZWFs
IHdvcmxkIHdlJ2QgZml4IGxpYmJsa2lvIGFuZCBtb3ZlIG9uLCAgYnV0IHRoZXJlIGFyZQ0KPiA+
ID4gYWxyZWFkeSBzZXZlcmFsIHJlbGVhc2VkIHZlcnNpb25zIG9mIGxpYmJsa2lvIGluIHRoZSB3
aWxkIHRoYXQNCj4gPiA+IGV4aGliaXQgdGhpcyBiZWhhdmlvci4gIFVzZXJzIHBhaXJpbmcgdGhv
c2Ugd2l0aCBhIGN1cnJlbnQgRFBESyB3aWxsDQo+ID4gPiBoaXQgYSBicm9rZW4NCj4gPiBjb25u
ZWN0aW9uIHdpdGggbm8gb2J2aW91cyB3b3JrYXJvdW5kLg0KPiA+DQo+ID4gSU1ITyBzZWN1cml0
eSBzYWZldHkgdHJ1bXBzIHRoZSBzcGVjaWZpY2F0aW9uIGluIHRoaXMgY2FzZS4NCj4gPiBBbHRo
b3VnaCBpdCBtaWdodCBoZWxwIHRvIGRvY3VtZW50IHRoaXMgc29tZXdoZXJlIGFuZCBhZGQgYSBi
ZXR0ZXINCj4gbWVzc2FnZS4NCj4NCj4gQWdyZWVkIHRoYXQgc2VjdXJpdHkgY29tZXMgZmlyc3Qu
IFRoZSBwYXRjaCBkb2VzIGNsb3NlIHRoZSBmZCBpbW1lZGlhdGVseSB2aWENCj4gY2xvc2VfbXNn
X2ZkcyhjdHgpLCBzbyB0aGVyZSdzIG5vIGxlYWsgcmlzay4gSGFwcHkgdG8gYWRkIGEgbG9nIG1l
c3NhZ2Ugc28gaXQncw0KPiB2aXNpYmxlIHdoZW4gYSBmcm9udC1lbmQgc2VuZHMgYW4gdW5leHBl
Y3RlZCBmZC4gU29tZXRoaW5nIGxpa2U6DQo+DQo+IGlmIChjdHgtPmZkX251bSA+IDApDQo+ICAg
ICBWSE9TVF9DT05GSUdfTE9HKGRldi0+aWZuYW1lLCBXQVJOSU5HLA0KPiAgICAgICAgICJSRU1f
TUVNX1JFRyByZWNlaXZlZCB3aXRoICVkIHVuZXhwZWN0ZWQgZmQocyksIGNsb3NpbmciLA0KPiAg
ICAgICAgIGN0eC0+ZmRfbnVtKTsNCj4gY2xvc2VfbXNnX2ZkcyhjdHgpOw0KPg0KPiBXb3VsZCB0
aGF0IGFkZHJlc3MgeW91ciBjb25jZXJuPyBJJ2xsIGluY2x1ZGUgaXQgaW4gdjQuDQo=
