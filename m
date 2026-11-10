Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B58606A321
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=XPAGiSsA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AB3240EF1;
	Tue, 10 Nov 2026 21:39:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 53CFA40281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 21:39:24 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAIowRr2435882; Tue, 10 Nov 2026 12:39:18 -0800
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020093.outbound.protection.outlook.com [52.101.56.93])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hv8k88p1h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Nov 2026 12:39:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPb2vFSP0/GHfSPQV/nJqTf1frvaZoxTAf0AuMwQ0MMK9BnaABhFutMcEdv+Qi36CWqP6GJQI7tVx4i6MhEWrG0LhlNIwhEKWMnirtPbkNmWqGdeBM38XgdVSrB3tFV4SkRGM02ifVXGRP0zUhspIPfkdGnTZgToylvJG8k1cZkaz0qXx9oqbE4axf/baO5IKzkrUQ8LvqhV4gvoVt3D4SzSYMDgQQtUEccQM8zrWuRwLDhGysrK5AaYu40RRsVc0XG3F/4GychZY7cj19h2yrXNlhx7e8sU2HCJAohMv7f/mUYLZxN7rRhBDLkgY9hbxrBE8tFmAiIRcFRvJoNWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6+J13GWt0NnuVQOC5dnsiuYobOVDQ84aN+YTRYfVHc=;
 b=v5DPsurVfJe7nHrNVh7Hr84PVAZxXgTRzf5IZ+ZEw0kD0WX/PlwVRIAgWa3tj6g6OAx9r7WbJreRT0W5934YaNfHQP3hUh7yrfYQK6a2MSOJwLCh0p1d1+S2NeBTwHNx7gS1wlrWNB3ZkZdtxpU/AAySszpJL2mYJT1AA+UzCn1a4GF1kj45cYyn8L1z39wyfssgNwV709we1jrAI7CcB2ISHeGgvhizlaPTFC//7OvWroXI9JM+WnOmrGAhcljs+8VBkqt9Wp10ta3PBU6o8HB9AzUWGzWuTO7DFlRTRVLZWiQB6vb5xqw6GGo8JutcJ1BnOkHHamYfWoIp5Aj4YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6+J13GWt0NnuVQOC5dnsiuYobOVDQ84aN+YTRYfVHc=;
 b=XPAGiSsAMn2/CW0NsRElgcQ41gjH6SpRrq0QtKZcUwsvqFjjK46ypv/meLhBvkm2xvn1AECqD3TNDZdaZjRXN5YCmIMiZfpBtHoIatcwqjDhKTiHadZEp/9MdgTgAk3xmfn+izQu+pdJ7IAsJtRKB0FekL7UfRtVikY1/ihJxK0=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 FT1PR18MB605616.namprd18.prod.outlook.com (2603:10b6:170:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:39:14 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:39:14 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Kai Ji <kai.ji@intel.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: RE: [EXTERNAL] [PATCH v6 4/4] test/crypto: add asym test suite for
 AESNI_MB
Thread-Topic: [EXTERNAL] [PATCH v6 4/4] test/crypto: add asym test suite for
 AESNI_MB
Thread-Index: AQHdcQsV8ZdgMwTbVky/yFD1lDOYsrcnxOdg
Date: Tue, 10 Nov 2026 20:39:14 +0000
Message-ID: <CO6PR18MB4484ACA524A695AC835E0F66D8722@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261110120015.2937289-1-radu.nicolau@intel.com>
 <20261110120015.2937289-4-radu.nicolau@intel.com>
In-Reply-To: <20261110120015.2937289-4-radu.nicolau@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|FT1PR18MB605616:EE_
x-ms-office365-filtering-correlation-id: 7714051d-7c35-4c45-5a90-08df3f6aaed7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|4143699003|11063799006|56012099006|38070700021|18002099003|22082099003|261022105027099003|10067099003|261021135927099003|261028144727099003|261026140227099003|261022075727099003;
x-microsoft-antispam-message-info: flFHobxbpHDhMpNu+i8Plf2ke+DxQTP/z+rtlA1jbstYL9P6EQ3N9Jb3MuZaWlbXGnB1MrdF4qIdOwWWwNlBlqx0Sr4tQ8vgXmtRr+jRp7/iMz2M+ohbkMEByyCeqgcQYd7/HwMUpVHBvMm63w2i5dFAdPJsRNZiYA0W26rlht22FmN+QTWnhF7PDbIVfi7GVsTQKJkD/cGAUsI9gQJ2sIluDZ63AYbTNZrB1xEsbvBkkSqRQ+oJ8Tk8RUaQISpyJNKbij/aNMMCJtRn6gdm1rwiWYkp3zy/aYEzYy+1njUVYdrzqXMWlDX5Bsn/W2NHoOc+LgU+zHXzoRXQ6CPxhDMiIXvlf890EkN+J0s4KySstv+6jCjj/BTdy1P3Npw11+u3ZgAg8hxQ0Mha2j0LE8CCBIYIHgnAgTDYajCOboU0FgK1O6Ymsz0NaFTTExrVvmv7YL3Q4tsjsXqSq2jsbEBm9WrVC7R/PUTIvjRtCfS55rvpifMjabgcPcaeFkuHmSQY+0ldhe7DgwFztJB0OkNFNcqOozXTINXm3G7aO4MK+Vys2oIHQKje/aYZ+mhajARmnOmG2WvhcjYPbA5RO8V/w9kjcoixdOEIZu87oPCrEyp3V3dU0nu4ODjrVOEk5Ji/mE3CHhgyfpiDRWUGnWtgIJihWriaV27FodYY8mcv4NHMmaAYceQxbY40epb3nkBNxMkubwsSBRrL4p+fdQvmCHvmW1OdNtEcWnsHsCM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003)(261022105027099003)(10067099003)(261021135927099003)(261028144727099003)(261026140227099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjF3UlZPVVJ6SEo2WEM3TVBCV0Y5SmNDTFlpVmdUN3lDY3VwMGJacGg0OFpS?=
 =?utf-8?B?aWFpTU53MnpHVHVQdmNtcU9ma01aclJxQXdYQlZxeEdiT3k3S1NPWnE3M1hQ?=
 =?utf-8?B?TmdKNUJWQ3k1RTZyaUYybGRsMFNtVDRJNHMvbXlmNStLYXJsWDk4NkdEZXRo?=
 =?utf-8?B?WjRoWWdMNk5LdTRLYzc5YVRoRGF0WmpSQmFrMVQvQW4wT2FhUDdSOTBHbUhY?=
 =?utf-8?B?eWMvSkQvNDN4WHNQcVdtZ09VN2Q2YXR2aENHNERSZm5Pd2UxUHhxdkEySnNK?=
 =?utf-8?B?TldVWE1jRndGdG16ZTdVbVlOMGk5Z0xJT3MzRHFCME9uYnhPWm8xOFJ2K3dB?=
 =?utf-8?B?VE5CbFJwMnh5M1JwT3Ardks5OXlUZXhGeTlZQ3B6UVp2OStOa1ZNNkFmaDln?=
 =?utf-8?B?NkYxM2FldE5Sc0lONy95ZGZCTEdVaWt5MHlYWFVUV0JpYzZ5V3dQR2J5Z0Ux?=
 =?utf-8?B?elZ0NFREWVRXS04zRy9ldkZtclBJR0dUa0xnVVhENzExTFBtRmtCMG5OQmN2?=
 =?utf-8?B?V2pCcGhlS1pQby9RSXhaYzNNKy9LOE9nb1FIRk9RREJ2dTZSekZFL3dvakFu?=
 =?utf-8?B?Ly9sNms2Vzl5dHY5Nm9iQmxTelhxNStEeDFtaVZsZ0UyTTRXWnJTTElydlRJ?=
 =?utf-8?B?aVUyQ3pZNUE4RVhSL0UveXo5VnJkZlpIdElBL2RYR1dVYUhkUytNYWhJNmRV?=
 =?utf-8?B?ajZLZnh4ODFORlBvWFY3QklpUEJSK1Z6aUtrOUt3VFJLV0RyRldFLzVQL0Q5?=
 =?utf-8?B?WDZIelNVZjU0L0ZPbnVzZmxKUmw4VTMxckFGaERLN1hpU01zdVBGQzJ1Nys1?=
 =?utf-8?B?cXlzWUFHZGVLYkkwUHJqbzlaSGdLVzdGMDJoMnlmMDh1MXhGQnk5TDFKM3Q2?=
 =?utf-8?B?VGtYV2d5WWNnVlRua2M3TFdDUFl2VnJJSVBxL09Nb3VuYTVpYVJIS1dJdGNz?=
 =?utf-8?B?SlFyUXRodGdBR0FoVWZnTHNoOTM0WUtHMmxoelJ1My9jNWxUR2pPZmdvc1dB?=
 =?utf-8?B?a1AvYkUxTitrZVZ6Q0g4dUtSa1FKdTFWbjZWdXBzdVJ1a3JUbSt0eTM0WUtB?=
 =?utf-8?B?cUVtVjA2N0xUUk9DcXFSNElPaHVFVzF3M2tJbFMvTklWMmVKdU5Fd1AzK3pI?=
 =?utf-8?B?cE9KclBzZEV2S2tMeFhFZmdhNDdVd0Qwdkk2anVpNDlTZVlFaDhmZGNNdnp2?=
 =?utf-8?B?OGJWcE1zYllEcVZ6d2FyamxEcjB1d1dhcDZMOEwreGhBWERjZ1Ivc2lFQU9q?=
 =?utf-8?B?cVJCamNySVYzZmR5TkJmSU54czZGVUtzL0JqOXBzSm5zRFNhblJhakd5a0hp?=
 =?utf-8?B?VE0vMjF2dXMwTjJILzYzK1ZaR09pRVdiWnZTR0owSkRDS3hmK0JnY1ZsWVpZ?=
 =?utf-8?B?SUx1ekdGWnZMdjNUeDBXTU5ENis5U216MjNoc3NvOXJPVEtJSERmWGh1eGN1?=
 =?utf-8?B?RDBIbE1aTDBmaEYxZDJldjd6cm5uaHdmVjU1OVVmMTFNdW5FK3BvcVZJYUVt?=
 =?utf-8?B?Q1c0bXZRVE9KaWk2TkJ5TmFvbWIrZ09BeGkrbWgwNWV4T2V1c0pWaEM4RnFC?=
 =?utf-8?B?YmNYNDIvKzRram9zM2ZLa0oxU29UNHBEdFM3YmVtK0U2VVRKN1U0a202ZFZC?=
 =?utf-8?B?blROMEpUTGhOMzRqMlFTTFJoL21raFd4eVFqNGNPTnVxV2hWSVJtOHl4czhL?=
 =?utf-8?B?c1U4dGpzTTdiLzJjbzhnVkFNQ2h0djRzOHliQTIzOXZYVXB0NExueVVEQ0Ni?=
 =?utf-8?B?WENYYkhuV0RjOHZOVkJOME5TK29yVUU4em9hRmlwWldXM2FkclV3SDhCSTg0?=
 =?utf-8?B?QzRlbjlwR3NNRzlabmY5R1RhdWJ1VzVPSDl4ZkVuQU1uOFBaMUtkUUtyREUy?=
 =?utf-8?B?MzFPM0M5QUpIb2ZzRTZYamJ4SERXZkNZKy9WWlArS0tPRUJ5TUd3Zm0ramc4?=
 =?utf-8?B?bDFqNDNrMmthNnBZbXBUNnBQVXVaVU0wbWFCaHlSaVNiQmI4OW5Eekk2dUdS?=
 =?utf-8?B?aHF4Y25ZbUF3c0dST3YwRGJ2anU3QytVTElEL2hhQzE3Mm5rd2dBU0grNmls?=
 =?utf-8?B?NnBpZU5ST3hQbEExVlJTeFBFb0NWREJ6aERNSjlTbnVOL2xaRzRDMXFqeERV?=
 =?utf-8?B?VGpQQmQ3NjBDRmE0QnRja0MxM1QzRkU2eUlxNHBmTEcxV1dLZjRabjdoSStR?=
 =?utf-8?B?NXhIa3pRRXlXQ2pVeUtmTWVwT3dHc1RCeWJkK25SbTdEY3dLVUc5RC9VWS9N?=
 =?utf-8?B?eWlUV0hDQ0FJSlF0THhiZVlMY0pCeFhyRCtkSUwxODJLcTYwZHI1eXNRZmUy?=
 =?utf-8?Q?IRAhRGIHDiur2A3sNa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pafB9wQKdIgRD69NCvLGuwowbSZtzH2Dzw2Pzhiwz65u3mWIgsbaAzgejWUy0j+tZguTiQ/nuxi261lwe4cTUYMb7dNXPZ4r2sQhCeTKVw0lvPXQA09oA/pVBtE7t+vH6lrZ8Burfp31yvSlMAEm0KJWZjyc9PMm+typYKNNHN1DLkTCZ2Z1jZcR0rjI+wEbOL1tygzEDbqK+FPm0UnhvfvWTrwXqKgjYM6dso9SbmTwmcQqr2o1RQBSB7nNeuzybsyS2rkrimQJ9ZwdQE+3FXP01g7/M9aMURoJcL59+M/sTYfZWN7y1RQdmiq7PGJrf3TnjrJ0fQpsz2dRH70n4Q==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7714051d-7c35-4c45-5a90-08df3f6aaed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:39:14.2077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6K8L+ytDCtsMRNeXK1BBYQ8IMJy1wW2yjnh5+cZrYz3ptVg+ODxdEeoHw0u9J1JHPJo5CCgEkTwOrspAMRXHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR18MB605616
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4MiBTYWx0ZWRfX1Kr6Uj8Wyhvv
 gZFq/raCMJrFUcdRo1vaogKsIh9akI7+ADdHnHD5PIVgwYh2nIqlv6+V2cC+p2uurHYWWPy5GhD
 /s+IXlP4nzZmSjk+N9i/uvUgwfbqFEM=
X-Proofpoint-ORIG-GUID: AQTA7PX19bT_qMyfHIKkyBlKvgREUzQh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4MiBTYWx0ZWRfX3TsuGE4esa4z
 BS9nd065vh6mAJxWh4spZCj+zKYfHFeorbuLGmUA35KhCdYIPm+nDYqEQx6PAD4vz2XlSEuHwKy
 mNbPq2sO4mFVg6ysE/2MKpOdg7mmoWHJxVbVzJWMAbKlDuxgAU6LE2yhKgAXBgqAfMPc6w5iFlc
 tY6tX0bAuk2Dn3fY5YiZLBWgbKrvjYj8Nlg+U6lhfDuXGpaW+AL3ztHolvrbeoIoo8KLphYu5f3
 Nu1nW3wlmqp9k2AASn3RXZMa+k12L+WrX6DLoTmJsYehTLG2BxW8hV7CRSuhvUGq+9RAMIATgAv
 3MQdWfiuoP2UdN+VbspIMKkQLN9xy61GTrgbrG5OnHjeMghb7vh8Ztuf52SyMlNUB4odyEiIRfP
 lu+zkqF1Eo0YsOBDR8w9ib18gf2e/wE8nxpIvJlTSVotw6Ov/sZo0xwvWBIfYMuNV6txyxnZyNY
 F7/yFfke8n7GxMP/d2Q==
X-Proofpoint-GUID: AQTA7PX19bT_qMyfHIKkyBlKvgREUzQh
X-Authority-Analysis: v=2.4 cv=ZIlCCn7b c=1 sm=1 tr=0 ts=6af380f6 cx=c_pps
 a=BVZXAR9urkJIT3zY0dPXyQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=QyXUC8HyAAAA:8
 a=7CQSdrXTAAAA:8 a=RqrhL3iitKFM3F7pOV8A:9 a=QEXdDO2ut3YA:10 a=U7BLxpm3AvUA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
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

PiBFbmFibGUgYXN5bW1ldHJpYyBjcnlwdG8gdW5pdCB0ZXN0IHN1aXRlIGZvciBBRVNOSV9NQiBQ
TUQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWR1IE5pY29sYXUgPHJhZHUubmljb2xhdUBpbnRl
bC5jb20+DQo+IEFja2VkLWJ5OiBLYWkgSmkgPGthaS5qaUBpbnRlbC5jb20+DQo+IEFja2VkLWJ5
OiBXYXRoc2FsYSBWaXRoYW5hZ2UgPHdhdGhzYWxhLnZpdGhhbmFnZUBhcm0uY29tPg0KPiAtLS0N
ClNlcmllcyBhcHBsaWVkIHRvIGRwZGstbmV4dC1jcnlwdG8NCg==
