Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6211606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=dYyx0Sq6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E691402ED;
	Tue, 17 Nov 2026 16:52:41 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 6CBDF402D5
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:52:39 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFSijv4192290; Tue, 17 Nov 2026 07:52:34 -0800
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020091.outbound.protection.outlook.com [52.101.56.91])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4j0ar1bnh4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 07:52:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoaTQpY4RASlvQ2Mw3eUrkdIKFUNKsBI/Ykeqzm44Hv045WUyEWnABcN3DvVFRDSTpkAsYb8EwHVwiAkuIS2Z9roiqPtLGKo+0j1aPcHEzDmn4/Ti2B4pC0KDfn3eO1i/UefAQuIOqK5o1CQ2vKFVcCydFvGtky9rsWCf/I7L5kiIm+0+ZdJ8h4K458AVZtsL7zS9mXrHfIqDczdt1FhapcvqsHr5nth/+QldrbkR/gaiCXBWsico1Z7IAm6l8c41eI7sXrfXxYaFfOjtMcb3RNO4/KItcWP8TH06ftYbcN3qwAfdpjGGr/afHpN+DX59v9kD6tEgJbhjIDpmN62pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+pz+47RPDKgh1+5YxkNN8JomC0BDyWBLyce+4Zvw10=;
 b=YOASxUNX6hhDrIzwC0gcipDvI0jAeOtkuSwnLzemEu+p0QQ9WhxcyGdcPV0FTMH9/UDqGWYYx5sIR0u13/rJXJIFLuj2aaXXyVaI+ohIM0YKT+CHPP5Vg2VZqNOxLtHBOSYIHZ2dXxcAiJrP6b5qrBSu4zjCuPt1Lgd0FDBBcRO7KsACRFSKIPL/GFKnlNGNrSV9GcOTjxTY7OrQvSq4ashW8XAha+EJaANwxGZaplnOwMoE6EObI0pWcb0RgJ0sIrBKgkzl8Pv0SLa6qhO5KJaQ9qI2P5Sa5HvmTgxMd6JeUF3lhfqmLUK9YfPZn5qdHSJdazWW8pWrqUoY33bGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+pz+47RPDKgh1+5YxkNN8JomC0BDyWBLyce+4Zvw10=;
 b=dYyx0Sq6oj3wT96dLMJJo9Bf7hnTEvT1DEkVl033J5uxAnlR34Sc+afMsy+tMOgvjvgW6u/adrUK/nFYXf5keSAQOpJMqIyCmW0uES23tPByh2/Ww77nLU/CJX2KSJMaE8t+A3SO49/dNUO50muqwhrSIP8nbdj5svs/B+ClRso=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS4PPF72E692E73.namprd18.prod.outlook.com (2603:10b6:f:fc00::aa3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 15:52:30 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 15:52:29 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, pengpeng <pengpeng@iscas.ac.cn>, Wathsala
 Vithanage <wathsala.vithanage@arm.com>
Subject: RE: [EXTERNAL] [PATCH] crypto/armv8: validate xform auth key length
Thread-Topic: [EXTERNAL] [PATCH] crypto/armv8: validate xform auth key length
Thread-Index: AQHdWxfTkOWDyiCG8E+vZ8hDapKLprcyoNsA
Date: Tue, 17 Nov 2026 15:52:29 +0000
Message-ID: <CO6PR18MB448423642B11C0DED2CF5088D87B2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261013133559.65758-1-jack.bond-preston@foss.arm.com>
In-Reply-To: <20261013133559.65758-1-jack.bond-preston@foss.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS4PPF72E692E73:EE_
x-ms-office365-filtering-correlation-id: 0ce633d5-5ff9-43a9-4bd8-08df44c2c8aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006|261022075727099003|261022115727099003|261026135527099003|261026121527099003|261022113327099003|261028144727099003|261021121427099003|10067099003|261021123027099003|261026140227099003|261021130227099003|261102123227099003|261021135927099003|261021133027099003|38070700021|261026130827099003|261022105027099003;
x-microsoft-antispam-message-info: eZc0yRHFXsLIWbQJ8guOH9KuvyPy+wf7IfxWa8+M00SuzdoKo3rcVtsnrur+2SkRRkr0qFbeCxMDe04queUdCa7hYG6zi/tlzrVf2cZiBncTiFb6nkncp6k2kB+9I8xc2vboBF47U6Hoz1ClX46kxmabjRPK3395UlxQXLUjwXeJ/miYUQc6wZXIwX7QUN0f+Lphw6AxsGnGf2sXZu6ELEul16hscAJwg9i2tIrw6uYJ/VcGTNfu9ROgZ6smMjN5oNutbSzM21FnOQ+oFLo+dxR9QA/ZyoZU+XfAWAbbRtzM5qS80bUo9eabmDuqKmV7Tb458RCbF8SBKlZFXO9iht6GKSZZbGpXsJvAkJQfZbbrr+wW0gNoQM4bPF39a2RoGDbl9iXDhEyew0LbQDuvQDnnTE2ZViQCDyEVQ+wLWuxPXNiN308MX/vZOOVkN3hQ3/3S15Ms9Lfe7kKiluC8l3hhawK8t5kzJ34LiOKVfeb0NHBUiw4DCO9W+PBUiXJwl7llPO4M9UKHWL5VXyJ/Me8y2lr1QrvkRMCs9nBer29gtLL2fpxidVxF80OwDdhXdJj15z4EzR1PXxHQNCImsUv6GMP441Dvx3M0onRlbcKPH02E97Wcoo5q3CJw2HBPbea/E853jLNfLTZ4bdLG+bhjTLr1/y7MpfRk4qNMvBQn8Y6dIXRLOJ7wOtLBgeMdBFJP1An7tsB8HSzn2KuB7UPnkwDRvidhJoiAsb+EH3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(261022075727099003)(261022115727099003)(261026135527099003)(261026121527099003)(261022113327099003)(261028144727099003)(261021121427099003)(10067099003)(261021123027099003)(261026140227099003)(261021130227099003)(261102123227099003)(261021135927099003)(261021133027099003)(38070700021)(261026130827099003)(261022105027099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzdvZXNhZHBYYWNDNTFSVzJvVTN0UkxjbXZTM2pSR1FjT2tjSWp6R3U2YVph?=
 =?utf-8?B?NklBeVVzcDdqT3FpblQwQVorYTJiOE5NMmg2eFR1aGJRcGV0OHMzQWpnR0Nx?=
 =?utf-8?B?Y0QrYTJlVFJHczh5Zi85NWMyQUVreGl0MjRYRlp3NmVpUU9QWTF2WVlncHlQ?=
 =?utf-8?B?UjBrRWU3R2l4Y2xJSHNGVnFPNWcvbFJJaEhEQ2RjQVczYVZCNXQ2TDZlWG9l?=
 =?utf-8?B?V2Q1ZnVxYjZUdGsrNWtvcGpETmZzd2YydGZqVUNHR2I1cE85N1cvT3lVTXRY?=
 =?utf-8?B?VkxYWDdUaUF0RWJxZUdYcmw3ZVJ0czJjZ1B1eEhoSklRcjFscVB6dEpXNVBP?=
 =?utf-8?B?QlZ4Y3E1RGR3ajAzOFdYV2FXN2QzdCtSbkpGUm1aM2NFdnFKSzF3NjhDbE8z?=
 =?utf-8?B?K1dlVUlVbHdKclYzZkdYMUpiUklGZzMvYmpZNVgxQm05ajhuVTdSRzJ2WHVH?=
 =?utf-8?B?Qjd1YWxzVGhlbHpIcGY0WjFZNDhEaHVpMFdQRUhkVytGUGJRb3lxTU83QkNp?=
 =?utf-8?B?d0tqZ2hjYUc5RGJXYWdzeTZLVm5xWW51RzhsTVR0ZDVRK1BvYkVoT2JWU3d6?=
 =?utf-8?B?YXk4M3dkQnpqVmFydXpnOUd3TEJiRkJFZHBiQkFjaDVVNnVpaXpvTWRnemNa?=
 =?utf-8?B?ZW4rcGdhLzAwNXRiL2xXSmtnM3ZkMk1QblExRVJyeXc3am5iNGIxOFRFdWpt?=
 =?utf-8?B?aGh3NGZEeDdYMm1iV0luY0hGa045N1lpbEdtV01MT2lRZUJpaWZzMldwWkZh?=
 =?utf-8?B?N054eDh5RTdSeUZNTWwxNnVKYzloNDFCbEF0TVpPRDdaWll5V3VoekZ5Qjkx?=
 =?utf-8?B?QWZRbmVQdnQrdUNHbVRNNnJaV1lhWndJaDNuWVdsR1JMcHV6dVlkWm9FeFBO?=
 =?utf-8?B?V0NiSURWMjd4RjVFS2ZWa004N1FuODdyalgrZlRzLzB3NFdhOS9LaXRvaGg5?=
 =?utf-8?B?SkFhQ1Azc3MvMlVFcUM3UGlUZkFnQk5GRHZrQ0RqZUJ6Y1hWZDJPK01pSzhJ?=
 =?utf-8?B?MXpneFhRZ3d6SGZuMXVBYWg0TG9wOTE5eXZHMXhpdy9ZbElzVTNVODhRR0sz?=
 =?utf-8?B?NFFQeFg3YW1QMG9vamRnVnJVRFBDK3JuS3RQVnpjMit1cE5oa0JVUXlQb21L?=
 =?utf-8?B?VHlQd0FpN1RNdDI3by9RSSs5QlFNQzNrSXNRc1ZWMzkvaVZzNm10WE4rejFT?=
 =?utf-8?B?WmdacnJBQlorRXJHbGRHck9mWVo5Z1VoQ1ZmbUR6TkI1NEQvbGdhYURKZ002?=
 =?utf-8?B?bXFkRzhzRWM1RUl6QzlEMGVJRjlRM1A5M25JQXlIS3BLK1hkczlmenNqQW9L?=
 =?utf-8?B?YWU5Ymorc0FYbEYzcitJZHNjRm9yWjNQTnNwOWlia3RoMndqSG5yQWdGakFO?=
 =?utf-8?B?N3U1WisrV25WYlZRRVM1ZzFkWXNEbThzUVdjUHN0VUdHRzhxSDhzL0VVa0tX?=
 =?utf-8?B?MlhpSDBKSHZaWWhYRUplWWtoOEJOWmxDclE3QUZtbmNtTGtGVlNKUlBLMVd3?=
 =?utf-8?B?a0cvK1BUenMwVnRJcGhJeWVnb0htd3hjQ2IwbzVRZTFPdlBNaWk3QTN6WlBE?=
 =?utf-8?B?bDRCU1pmYThXUEFVbHY0dkJJYndzeHhpSVhveVgyU1l6V2FoQkQxdStld3BJ?=
 =?utf-8?B?VlFObVNoRTUyb0xRSHU1eDJESGk5aU9lcTJERUYxYlNjSThlZlh4OUZ6RFM5?=
 =?utf-8?B?eCt1bFREK2tuZ1VOK1lnbkQwV0ZNUUYvbnhVQWZzMzVTSy9FL1hyR3QrQmNn?=
 =?utf-8?B?Tng5RW5qdldqL2JZbXRKb3VXaU9ENGd3blF2R3VEMDhqM29KSjdHeXIyeFli?=
 =?utf-8?B?NDFkZ3RhU2dyYWN6MmlUcXluTHRYRDd3aGJScWR4cEk3RGplb0djM1JaSlVU?=
 =?utf-8?B?Y05sK2duUTVyRVJFVlEyRStnUmtjUnpQdWltNVhabTV0OG1wSWZUZitNUGpn?=
 =?utf-8?B?TDdVUk9vRHdQbGxWZHNnamtMQ3RiVTJ4L2dQcWk2OVlZSkhKU0lKdTBneFZD?=
 =?utf-8?B?UFRUQ1Q1ZEpENGdGaVRDWnplOFU3RWczTHlxMzhSN3dTRmQwdGh1aVgrZ0FO?=
 =?utf-8?B?MmErb0kzcXBtb1VISVpVR055OEg0cExWYW1hQ2QwZU1TTTVWTVAyaE9hRS9S?=
 =?utf-8?B?b3hmWmlDQUZCWXlNWXp3SWV2eUc2VjdjTi9iK2pLMDE0SmhzM2pPRnJxcWhp?=
 =?utf-8?B?eXZDVmlpSkZjZHp5YmxrWDhGZlNPOXg2ODZNRUlxVEZJbnNKZnljb0Z5VFhI?=
 =?utf-8?B?ajY0bmtLV2szNGFLZURlcHdnYkNySEVzWjRSWDF5TlBFWEpna3k1TUc3akZE?=
 =?utf-8?Q?CwSfkmjh/HoVN8fhyg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3YfxjFi2s/W0qODr3A79WAmZWcfabEPQmcOuyoNhW0tXrDNojzDahzp/OkoxUhT4CIoPGVey0yOeQNCoxlAXl4Vrv7HNHT3h5omPJpxbJ7SogBM6eJZiM682Oc0jj1nUlxWSo0sFDrEzg8BTuzav78H9xWVIDoAXaDjr4iyJe24lA4zBIVlPuc85zkSQUHxJ2bqTkHuZ/XFRo6/TFt14jJvzR4HOzxqLV8abHtW4BJE3Em1uvj/BzJz20Arl6NTFK1xd2We1mNQoExk5H+woFTlfVzXdg6WVJJ7gaODPWNyXHdxIuFZ7X6kwOpOB948i5GHNeAmeb9k8ASWql0lBEg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce633d5-5ff9-43a9-4bd8-08df44c2c8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 15:52:29.0691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiPAZF4kISkWh9Bjy9EBOHrbgVXyGzsKVfDd3teXnpH/2DFKBF9XEyq4cHTWCCTb7fsMbdBF5WWAKaTY2iMAvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF72E692E73
X-Proofpoint-GUID: CZo0YaqXvVnRMlnrXSBaohjikPaC0bcG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX6IsBXv8q/Qpy
 VWRNc5gheCAzApScSnfzLjhilZjPsmOvjDm8+tPQeSw7gxBZ9q/IUJUeJvcqSRqkpunKUT6NXlJ
 m9hwlnC80+ROtaCJPqeMetUTmP5Y/JnD0BqZBGEC8y7ETcLDIuZYUjJd0M7Qv5O67FS/1Aw7xA+
 R9/aXdTPra2gmB3fs0Az62J404xWaKTHZAVEbWTWgxo4yQF4Mpm+IGlpPJxhNjjwO8TrvEliiXT
 Ba094cqX5Z2wZhfdFlyNdUz5WdBaxwFYhAkkmDW+8070XafoIu9KJGMYk82hP1W6C545vqDAl1P
 StfbU072eP6luhMEZS1QLoJbDPEY5Y3u9ZegMaGKAz4KCX+5rI861xNjJSxycVFJ+JwikuQl8J1
 x/pgsZTZGlaaZ+U5qzfWBp8q5ar0Ew==
X-Authority-Analysis: v=2.4 cv=a7ulZkSF c=1 sm=1 tr=0 ts=6afc7842 cx=c_pps
 a=DCeSEX+nBJmE/I7rcEuDsA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=7CQSdrXTAAAA:8
 a=8rWy6zfcAAAA:8 a=m_kgP6XE1rsjifPZiW0A:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: CZo0YaqXvVnRMlnrXSBaohjikPaC0bcG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX3THrXaGKg+HO
 SuheK+XvovW0pWAj4qXZmgh67v53ESaLhWxMV6yufucBO9DS+VmMHy5woe0eprZIevA/RLA1l22
 Ba2YCqsT+BqPJo0axr9O7PMriSsF2gg=
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBWYWxpZGF0ZSB0aGF0IHRoZSBwcm92aWRlZCBydGVfY3J5cHRvX2F1dGhfeGZvcm0ncyBrZXkg
bGVuZ3RoIGlzIG5vdA0KPiB0b28gbGFyZ2UsIGFuZCB0aGF0IHRoZSBwcm92aWRlZCBkYXRhIHBv
aW50ZXIgaXMgbm90IE5VTEwuDQo+IA0KPiBQcmV2aW91c2x5LCBwcm92aWRpbmcgYSBrZXkgd2hp
Y2ggaGFzIGEgc2l6ZSA+IFNIQV9CTE9DS19NQVggd2lsbCBjYXVzZQ0KPiB0aGUga2V5IG1lbWNw
eSB0byB3cml0ZSBvdXQgb2YgYm91bmRzLiBTaW5jZSB0aGUgcnRlX2NyeXB0b19hdXRoX3hmb3Jt
DQo+IGRvY3VtZW50YXRpb24gc3RhdGVzIHRoYXQgaXQgaXMgdGhlIHVzZXIncyByZXNwb25zaWJp
bGl0eSB0byB2YWxpZGF0ZQ0KPiB0aGUgYXV0aGVudGljYXRpb24ga2V5IGxlbmd0aCwgdGhpcyBp
cyBub3QgYSBidWcgaW4gRFBESy4gSG93ZXZlciwNCj4gb3RoZXIgUE1EcyBhcmUgdmFsaWRhdGlu
ZyB0aGlzLCBhbmQgaXQgaXMgbW9yZSB1c2VyLWZyaWVuZGx5IHRvIGRvIHNvIC0NCj4gd2l0aCBu
ZWdsaWdpYmxlIHBlcmZvcm1hbmNlIGltcGFjdC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBwZW5ncGVu
ZyA8cGVuZ3BlbmdAaXNjYXMuYWMuY24+DQo+IFNpZ25lZC1vZmYtYnk6IEphY2sgQm9uZC1QcmVz
dG9uIDxqYWNrLmJvbmQtcHJlc3RvbkBmb3NzLmFybS5jb20+DQo+IFJldmlld2VkLWJ5OiBXYXRo
c2FsYSBWaXRoYW5hZ2UgPHdhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPg0KPiAtLS0NCkFwcGxp
ZWQgdG8gZHBkay1uZXh0LWNyeXB0bw0KDQogICAgRml4ZXM6IDE2OWNhM2RiNTUwYyAoImNyeXB0
by9hcm12ODogYWRkIFBNRCBvcHRpbWl6ZWQgZm9yIEFSTXY4IHByb2Nlc3NvcnMiKQ0KICAgIENj
OiBzdGFibGVAZHBkay5vcmcNCg0K
