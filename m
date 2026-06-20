Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C49BCD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 18:43:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A3BB402AC;
	Sat, 20 Jun 2026 20:43:28 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1ECCF40290
 for <dev@dpdk.org>; Sat, 20 Jun 2026 20:43:26 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KIOCBJ1250984; Sat, 20 Jun 2026 11:43:22 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020105.outbound.protection.outlook.com
 [40.93.198.105])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ew8yfkdqq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 11:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQjVAbQMVcVBrIjosPj1DLAAOiMhJ8xcODCgalqJ75MZGMs5qznyZsWYg7BjormH8eYnv1gRk3YK8cWgSj2AMR+rsaROzAuklHfDYzLhV4P0bN5IvBhZoOKyfZPprCa2Z0onnY0Qha7Y1fwJeXIDpw1PRZjbJpmuXebZSRsiObHcPjUzRmOTAehK4me797WNeaRvktKW3ZAsRnaMiOU9wEEsGYIzhfgHOt+a3mwyTNC9vWDe+eqRCwjbG1dn6YJFDoD/8eSjH9k/vjDAFFJJlbASHyt1/A2BEI4M/fZE5kR+2Oj74/Uoh/jteWn4O0K3d/iA6mV49iBhdFhwAW9qAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpVARwkWe9gedKqi0v5tR3UKR8T2tPLRSCePm1gPIRs=;
 b=BsO5Pbvk92AUWpmReXtUxufxQI+bIIPlOZcWiikVnZExqln0g84IMm9RuQmHslF9inXsWB54KpX2JciGMScR5SU6hgZMzczaBjAf400vkbt6F1nYXkZoLjl+zXBqf895wZ1ty/VMQOSg/Zx2SPJi8PFbhS8Q6yl8CXEkq5fifRcF+9GZIi4Li90wnhE1Ae+6FwXuuq/7kUJeWAMe5C59Boq5qP9+gmiPtxlkFbuWTRRzxMoKb0MfQxPormFZhdCgQtaOS17UhsBlKQy/PZ8rsRiaVVkwwyJPI8cY5guXty0g57qyXvUiuTj4/+6mJJ00TwV7/t5SAlAqV/VyCtYq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpVARwkWe9gedKqi0v5tR3UKR8T2tPLRSCePm1gPIRs=;
 b=cjMgvxjvXlxi8umIVAM8MLFO1ce0bfjNbsyTbJHuVXfjnDZwQNKE1+CXUNWZZyRiq9TmffjD9LCGWoofPRBXkwS9hQB4QN9oyxWfXtUEYWzv+SZ3XpF74QmkU1RHCucaXKNB6yLFu+bDqMmocX5GnOyxkVLwwz7l57/mmpNNvuE=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DM3PPF20196C44C.namprd18.prod.outlook.com (2603:10b6:f:fc00::691)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Sat, 20 Jun
 2026 18:43:19 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 18:43:18 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Hemant Agrawal <hemant.agrawal@nxp.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Kai Ji <kai.ji@intel.com>, Pablo de Lara
 <pablo.de.lara.guarch@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "nd@arm.com" <nd@arm.com>,
 "Paul.Elliott@arm.com" <Paul.Elliott@arm.com>, "Dhruv.Tripathi@arm.com"
 <Dhruv.Tripathi@arm.com>, "Shebu.VargheseKuriakose@arm.com"
 <Shebu.VargheseKuriakose@arm.com>
Subject: RE: [PATCH 1/2] crypto/ipsec_mb: allow aesni_mb and aesni_gcm vdevs
 on Arm
Thread-Topic: [PATCH 1/2] crypto/ipsec_mb: allow aesni_mb and aesni_gcm vdevs
 on Arm
Thread-Index: AQHc8oi9O6HcjqPSEkGpoYAbm0Zp1LZH5ChQ
Date: Sat, 20 Jun 2026 18:43:18 +0000
Message-ID: <CO6PR18MB44843F17F5A386A4FF47CAF3D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260529205512.1985844-1-wathsala.vithanage@arm.com>
 <GV1PR04MB10750F42B67E6112BE4F0466789122@GV1PR04MB10750.eurprd04.prod.outlook.com>
In-Reply-To: <GV1PR04MB10750F42B67E6112BE4F0466789122@GV1PR04MB10750.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DM3PPF20196C44C:EE_
x-ms-office365-filtering-correlation-id: 17d7110c-c8d4-4ec2-8dfd-08decefbcc12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: G89G1LDcssW83kGhDyuErcrgDZlXiA+EnIwC9giXYPQhYv4LH0R4zCjACnIeLNJfHZ5MrwNYwgx61yeajwP/prpkFJnz3ygF1xqydvbgItnVXV0DrPt3P6yOdGiI3938LYU6hF2ZeizKYNW/007iuaTk5xUPlAxREn/662rSLZTIkQjwE2dpWgGemi+QLX8D/pjhFDShU0qQFXRfl/pCBI+ceUfQ12VcaKSe0AqSMDJYVRS9oqf2sbNhuAvTmRiQRj9ujGNMGzMjxXIlAiKdm2YMMg/iwHTUs+YUaZo94fTR9wNS4ValDLzDGjClfh/LFewgfyOxDL4y5B9N2ji/SUPze55xXg0p8zF+3KNa/Q+Bqqt4bjQnM5BlZgsB0wrSTCBRQgz2FNdzVeoyMpwA4JCrYH11KbMeJI7UFkKQ01eit9mLqlClotbjryL2183N+ktGmcZNVxTecvuhgwQb/ghvUeaAUtOKHFLtSwi1tnhmGFThX3pKEu+G5pkzE3sKG9zcO6XfvgDgv4wBje6nWNtP+sZdv6OuPBgtdu1fXPjUFPFoNqAm/iwhIEAtnqx7XwqGDMAMnNg4Qy0UA9ZhfM4Ub29/HtmgAWdYSumaGjjnva16VbHt426rsIWwPBZP5/eAcX2ysQzH45Ogtxm+BUARlewvtLgd+9tVblC3kcIcWP0548u92VJcX1ibHU6aL6K2tDqqjvglVJXC8vizGb2Zi8+F9CocyDWmcykyBt4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlljT3pnTUxBZWRSd05SdDNxRElBWldvWlA5bVFJN2U0NmJrWEdHNkJIa3g2?=
 =?utf-8?B?MDdqd25vZDBlYnVUb0dieURkVTAxTzllWGdkeWRZU1B6UE15TXJkMENRQXl2?=
 =?utf-8?B?TjhrekdmRDgrdkhyRGJpTTZBVTQ1NHhDYXJUbTdqVExPbXMxVWRXeTlsWEtx?=
 =?utf-8?B?NUQyRzgrZ0VKUnhCdHAvR1FrN3o1N0xNeTlDUkhKcnl4dVpmWmdCRDBkYWVz?=
 =?utf-8?B?ZnVOZHNsS2JpZFNqaUJJOU4rYXFyMUp4SGVoYWo4LzBFcnM4VTRNcEtYYng4?=
 =?utf-8?B?bEQwcjgxTFltQXphRVRFOUxTdWxUSmoybDh6ZWI5b1ZNanZQL0xTYjVocXF0?=
 =?utf-8?B?WW51MkxnWmg1RzlFUnF6UVpObmtWZUlrTjNKRDhzQ3RDalpzYjJWSERRNFA4?=
 =?utf-8?B?dDBGYVE0TDdLQmo0QlYvcHFTbFZ2OHJ5MUZWS3RSVEppSlNZZ1pvOHRGc0NI?=
 =?utf-8?B?d1NQVEZPVVhncGlQU05EK0Rqb3JQMzg5ODExeUYvUjVsUGVUb3I1bXRpUjds?=
 =?utf-8?B?enB6VEFIeWVsWkJZYWtNRG1Oc2l4WFp5bzdyWldzSExpR2dQWllYS2xyRFZI?=
 =?utf-8?B?ZmNlM3dkZWVTbVc2WEZ0UEo1NEs4TUJoQzZ6OXFZakg0WEQzWUExSjRRTmNl?=
 =?utf-8?B?ajlyY3A3ZHlGK3kybktMYUkzMzR6dU11RFhMWEdZbGZMcUlmRElBbjg2YW5B?=
 =?utf-8?B?blFSc0lNQTY2NmhKQ0I5ZVo0U1RhaXBwNTAzRnlZZ095WmUvcXMvbWdJWm1E?=
 =?utf-8?B?NDBwZSsxdWFsb0p3UHhaVkYySVdFMlJNLzdvUHQzN0RxRVd4dyttTC9YR2VR?=
 =?utf-8?B?TjZySU95eFNRUHREcDNxN0VkbUtKeWtZZmNMZTE4UFNjQ1paZXRGTStEUXZx?=
 =?utf-8?B?aVpBNEpHZ3FSV0dSSnlFUW9JR1N1TENWaS94Z0R3Mk5sN1VhQUp0M2s4Nmty?=
 =?utf-8?B?UGJDMUNQWEdKUnBqbEhTejNQYm1OSWF2ZTk1MGVjMkhCM3hXZHFyV2UrV2w0?=
 =?utf-8?B?YnlESFUzYmxsMVBmV3N4VDdPTC9ETTlZM1QrYUxCUnd4WElFd0Fsck9aeVQ2?=
 =?utf-8?B?UGxDbE1pMFVQd0xOMVZ2TldWeW1mUlo1WGJsWUgzNTVjbFhqalZpd01kWC9i?=
 =?utf-8?B?OEZ2aHRWeExZdnNLeVpFSlJwWUV1NnFxL2tYeGdFbnp3aEFudTdZMFJzNDdr?=
 =?utf-8?B?bk1SL1ZzNURvTXFpVmZSeVdrYmRCU1VJa21Bcmk1d3N0aDY2dUF5OEQvL2xB?=
 =?utf-8?B?RXliSGI3VUNzN1J3bGc4K2MvNlhWbTljTVlHcm9BWVpiaVgrUTFLa3AzSm9h?=
 =?utf-8?B?eDd5QWs0UFhVT2c4RXEwL3oreEVveXgzRXZJMHhQMVVtUW9Yd1FER0kwbkJN?=
 =?utf-8?B?aE1XL1YwOHQ2SEE5dnBhSHhkKzdVcms1aUc5N0Y0SkN0SDhXb1ZjSnk5cUdn?=
 =?utf-8?B?TkhpRHRXNWFUeGd4U2k1aE9TSzU1cDh3Rm85OWtTcXJmd3VmZFo1UkZvS2Fq?=
 =?utf-8?B?NmNWWm5CWVpLL1JlZExhSzFRM2RkTlNMSkplakx2c0w1MHR6NXh0Q3oxY01E?=
 =?utf-8?B?TFllSTNYSGZ2Zi9KWHA2TjZaTWlseFluTlBaUVdSRUhoa0c5QXAvTHltWk5u?=
 =?utf-8?B?Zlkza0ZPTkhRNGRORE01Q1Zqb3Uvc0F6M1I3R3J3VTdRYThXM3FCd2tNV3U5?=
 =?utf-8?B?MlFPMlNNcjd1MjBKYmpOdlQxV1Eva0VxSi90azFrd1FvaFoxOWVzNkR0MnhN?=
 =?utf-8?B?TXFhY2hpWHA5bVpyZmo3MkNvNWlraUpheXFnNU9tVTdyVGVMWFVxTzh4VW9k?=
 =?utf-8?B?S09odDJwZjFoRVo5Vlg3cUV1MEkydnZZdDNqZnFzM1B4L2N5VHJZNHd1RjI1?=
 =?utf-8?B?elhkS0paZjZOTk9TaldpTEhrZXhvdFZXbTNxUzRibkdSaUdpajRKeHBOTldS?=
 =?utf-8?B?MGtxT0FTbjBVK2JmemF1K1hhRk1ZcFY2WU1vQXkrUThINzc1TjArVnQ5bWJH?=
 =?utf-8?B?dHY3RGVjVFhET0JYNndYSWR6MkVYQXJiTXRmck9TQmpIeDBwc0VpZGJ6T21m?=
 =?utf-8?B?dUp5WXFSYlYyeHZ1alFIKzJpc1lRNXFRcmxROFRFaUJnYUF5cWxsakF2eTRk?=
 =?utf-8?B?Z2dXaUZqcnoyQU9RNDlpNDVmNGwxZDJYQ1pqYmRRYmc5UmpzMkw1Nk03RmY3?=
 =?utf-8?B?dE5FVmJKay9xWnZsUkNrWnlwTzdQMTg3T0V4UkFlRXhpQW0yZzc5OXc1L0Ra?=
 =?utf-8?B?TWF3cWxNcy9sNFFxclRxOU55Nm5hdDJxZ21iV21EVUFWSEpZODVVcmY2Z0Rh?=
 =?utf-8?Q?7TEe9PGQmCehhdFAOG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: APSeKIcVPZupwHkJV2MpyViPAzzka1GOf/jwDQ1I4uQgqbHV8VDsbgB5i5YoBUs/qCZRYZWzm6wc+wQ9CTFdl9P9Yj/lPS2ohKAH/+Js36WbI3qd/xRDimoJFXBQOEdwCB92dcMAqPGUq65pLd5KpRbijH9+5CpfIOW+AORiAnv6xV/OlaM06lNVnrQVLa9Y5cgti9xXkKfMOhjjyaMjQB65OpSxObqi8vFnBr66iJjAncK20Vbkq6XYtpVJW7EFtff9NxsqSn9EC/zhGxu0qL5vfeyNYYkcS//W+39eExQc5jXaBKitHSBZ2rHEaAOM536C6g2VNXSrIUMFqmnM/g==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d7110c-c8d4-4ec2-8dfd-08decefbcc12
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 18:43:18.8591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DbjRKxT/loeOk7Nr3KtfsaFmtJRTzZGE9RsOrbuViYoEuKI9QlGph6PLbNz2jaRvt0xswJXZRJ8nS3sgFjAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF20196C44C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE5MCBTYWx0ZWRfXzQiCGxEYxJrp
 qzeUnd19mo2HIiDGGpcDEGPG3SYUNHvorMk0kinK+tkqxpCzxoRX1tQH2Axh/8TS9VxnGFpbVq7
 ZmTrey3pkzDW5liDYhtDwco5alp6oGg=
X-Proofpoint-GUID: vRREMXZVf3npO2HVZYHyKeMslvI8qhlo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE5MCBTYWx0ZWRfX6m2j/g+4uAtx
 uTRCrYr9yRwL6UGEdj5UNhcCUIl+jmQV/ip9E1CTe1IBDIlbjVeqoVb9I8z9AmyfRs7wa7I5fbn
 cVeu1M0vbjGLVgXi3EYr3qtB+YoenClf0h4pPLs2k4qFNzaPZn2wDa3fms1bcMw0YhhNDKXM7MD
 j1OJS8YiRttOpqTg1t4n5RJGUwjiKySeGvmPIRgSYKsCOMHvZJ1hGopphpK/Vo1EJ0AuOnfEoJb
 aprVv0hdXczmnp/AzORif+7wMuJufdY/mJVDDUNSaeQmk/r+t+xaluePEXtJu6cFuUuD0YO1pt2
 +Zjj6cCHN851f58X1qTJiqhVQa2QY1Y3ggcP7bp7Exgo+Pbq6xfeDSd+x17JbII1gEmRLraXwey
 mh6ZSO7qTp34+llK8+MBX6VCrKDwpUGRRDVQjf0KnOwsKs7fCS4gQEoAM9ZyV2toZjSvGxKIibo
 kShb1W8DXVgs4YcMrBw==
X-Proofpoint-ORIG-GUID: vRREMXZVf3npO2HVZYHyKeMslvI8qhlo
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a36df4a cx=c_pps
 a=URhychnWC9B1Vwa060GvLQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=7CQSdrXTAAAA:8
 a=QyXUC8HyAAAA:8 a=8rWy6zfcAAAA:8 a=8AirrxEcAAAA:8 a=Fjg0EkLl-7YS-mgavI4A:9
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_03,2026-06-18_03,2025-10-01_01
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

PiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBXYXRoc2Fs
YSBWaXRoYW5hZ2UgPHdhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPg0KPiA+IFNlbnQ6IDMwIE1h
eSAyMDI2IDAyOjI1DQo+ID4gVG86IEthaSBKaSA8a2FpLmppQGludGVsLmNvbT47IFBhYmxvIGRl
IExhcmEgPHBhYmxvLmRlLmxhcmEuZ3VhcmNoQGludGVsLmNvbT4NCj4gPiBDYzogZGV2QGRwZGsu
b3JnOyBuZEBhcm0uY29tOyBQYXVsLkVsbGlvdHRAYXJtLmNvbTsNCj4gPiBEaHJ1di5UcmlwYXRo
aUBhcm0uY29tOyBTaGVidS5WYXJnaGVzZUt1cmlha29zZUBhcm0uY29tOyBXYXRoc2FsYQ0KPiA+
IFZpdGhhbmFnZSA8d2F0aHNhbGEudml0aGFuYWdlQGFybS5jb20+DQo+ID4gU3ViamVjdDogW1BB
VENIIDEvMl0gY3J5cHRvL2lwc2VjX21iOiBhbGxvdyBhZXNuaV9tYiBhbmQgYWVzbmlfZ2NtIHZk
ZXZzDQo+ID4gb24gQXJtDQo+ID4NCj4gPiBFeHRlbmQgQXJtIFBNRCBnYXRpbmcgaW4gaXBzZWNf
bWJfY3JlYXRlKCkgdG8gcGVybWl0DQo+ID4gSVBTRUNfTUJfUE1EX1RZUEVfQUVTTklfTUIgYW5k
IElQU0VDX01CX1BNRF9UWVBFX0FFU05JX0dDTSBpbg0KPiA+IGFkZGl0aW9uIHRvIGV4aXN0aW5n
IFNOT1czRyBhbmQgWlVDLg0KPiA+DQo+ID4gVGhpcyByZW1vdmVzIC1FTk9UU1VQIHJlamVjdGlv
biBmb3IgY3J5cHRvX2Flc25pX21iIGFuZCBjcnlwdG9fYWVzbmlfZ2NtDQo+ID4gb24gQXJtLCBl
bmFibGluZyB0aGVzZSB2ZGV2cyB0byBwcm9iZSBhbmQgcnVuIHdoZW4gYmFja2VkIGJ5IGEgY29t
cGF0aWJsZQ0KPiA+IGlwc2VjLW1iIGxpYnJhcnkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
YXRoc2FsYSBWaXRoYW5hZ2UgPHdhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPg0KPiA+IC0tLQ0K
PiAgQWNrZWQtYnk6IEhlbWFudCBBZ3Jhd2FsIDxoZW1hbnQuYWdyYXdhbEBueHAuY29tPg0KDQpT
ZXJpZXMgYXBwbGllZCB0byBkcGRrLW5leHQtY3J5cHRvDQoNCg==
