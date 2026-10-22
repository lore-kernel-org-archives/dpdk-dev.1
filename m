Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E478F606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=tvwC/ma3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E847640264;
	Thu, 22 Oct 2026 20:47:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7112B4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 20:47:52 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtJ6j1864386; Thu, 22 Oct 2026 11:47:51 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022081.outbound.protection.outlook.com
 [40.107.200.81])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hfmdthjcm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 11:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VybE5HhaqEx0tkPN8p7su7KqIt+HvGh0db84Pu4iayYwgpd7dX6SqAkXnGetTXITpl/Vuw2ErvjBcO58FVSpBQ5rKVn9/We9DE02Qqjgnt3lBPLfpfy9j76OVnF5YtJVF1oj/y7c0tZASBCpbjnrn0pefKFtab73OuGWjb31sD0w6Js43HYiTLKqO0h36l9Mvvr53/VXCbVOaPe7/HZRmCvPJhuPlcM919K65pu0p2veJxr9qSXtcJjLHjhrpyXB5mVu2PD+L/XDLIKrjL3n3XbyBmjp6z3MqYTBEfjPOTa2K2S7BrCTTFAUfFLHAQFi/6NTKMD/5MwkNRkju+s7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pBet+UCj3nPWAe7yk1JWfzXlOOJCNdbOliQJQTN4GY=;
 b=eVHQ8hY0cQIdxBZzP0HMTuMGEgPhnTYfFR4aLM5kER38q5vGSe6H3dVTOXDOI7rEJY5IXaNABylbw9xoy1Kv2s9XM+6EHAG706MFS1tw2CuRYHyQwTrTk+D0VZnskQQUZcjOVU9tTPQbNPkr6fDqyaJkV50w6Li8Zfrfl8M0MiyCUJHK+FZxMm+MXLfuS/jpSbl4YmDPAo8XU+sI4JRCrU/78zV16CtLxc0kl5IOaljTYhX6h26MuA0nllQPxYV2Kb3hl5oyXXmUIbKuXqtbFV0jH8ciIELhd31dC/eWz/pZjsNdEZfrhn/BaTWp9i8GNEfc2ugEaxGbMx7vTx+oJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pBet+UCj3nPWAe7yk1JWfzXlOOJCNdbOliQJQTN4GY=;
 b=tvwC/ma3p8msJcu+85/R2QC4930IiqTFXq8ee84piWn3UHFutfIgIuTTZBhr7/EP8Evou3QS6CkuLiHgopCMJz8c3ULDPSJLwy98XABoZWriapnuXSEeOZDlQkcqhSmge1eeLF/iUsBG8M7DR7p5V9iZFt7oYBpoaK6mCyozeTU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 DS1PR18MB6134.namprd18.prod.outlook.com (2603:10b6:8:1df::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15; Thu, 22 Oct 2026 18:47:49 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:47:49 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Gagandeep Singh <g.singh@nxp.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "hemant.agrawal@nxp.com" <hemant.agrawal@nxp.com>
Subject: RE: [EXTERNAL] [PATCH v3 0/6]  DPAA2 SEC related changes
Thread-Topic: [EXTERNAL] [PATCH v3 0/6]  DPAA2 SEC related changes
Thread-Index: AQHdVYf6fMWGpm4j8EGgOXf3G99JDLcKAIDg
Date: Thu, 22 Oct 2026 18:47:49 +0000
Message-ID: <CO6PR18MB4484E16FCE82FCCA2CFF58D3D8652@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260930070809.1929564-1-g.singh@nxp.com>
 <20261006114346.1229651-1-g.singh@nxp.com>
In-Reply-To: <20261006114346.1229651-1-g.singh@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|DS1PR18MB6134:EE_
x-ms-office365-filtering-correlation-id: 0426a2f4-406e-4ae7-b167-08df306cf86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261021123027099003|261009223027099003|261022105027099003|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|261021121427099003;
x-microsoft-antispam-message-info: beqyUAUWICUGASb/CLy/7E7GRqUEibeFW9xDtuGudlsm0NJTDBggDTY3JvSNOsUr11no8OSLF8pi5Q6UG0ub3k47r96DuoVrlUj9gH1DKCUMtgnWguIg2mll9aGeFHhOC3ySTssvt5pN9eYh11dUJEWTqlh9lkt+N4NVi/XNZ3kEeklFn0j1uggujWvfT1D4nT+pPqvnyz78zjoVza6ockX6cFO1OqK90t3nD0huTZD6taTMQmR4edjXPRZUp4y0fR4ZMvWO+ZUGtuwROsTN+GImyYdnRBprkxCSOHZep+NZvtrHlP2QSlwSUn0WRX3Vc1ZfFv/gGL55TYfsU4T9MBiflhyxS/Xo5josiy/ywvZ8pAfS++xnb0brrnlj6DTyTZvcNIJttRFKPyc6yTi7qxTwMIhMzPjQXbU8b+eK9ss4INr1JgQq6FnzJXRXT/t3SSD6QYR8+wnt6+s9QpFdrR4CgYCEDzLM3Xlv3YmGA9VcraFIYmL6amaInm9Na0teXw4fwQZVQ5ZynfU/VbptEubDvgu9IYW1loS6C+z1TPqboZsFUksMWlmWMebk0XAtvT6w1eFgAUK/zObcPvJmeyPXKhgDYP72DeX8UNyzIpNTJewTR00BmKR16UOnHwn3TzuoaP/wkx14jO/Ma/80hY08sRClvo6r3Ql3oietIq0szAo5ThJQzy3pb4iia3D2lx2vVHcaeDd5dZmnwUBugCxJlNuVqO9KOF2Uc8+sDA8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261021123027099003)(261009223027099003)(261022105027099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXBFYXp5SVorU2xLdXZQSExYMW1KNUlCMFdvTnM4V21PL2s2ZWJKVEdSd0JK?=
 =?utf-8?B?SGEzNVdMeU5sdzFmaTNUdFZhd0wxejl6Nzl1aC9sa21Qb2ZGWktXcHhwcExv?=
 =?utf-8?B?c2o5akVGSzNYSjZoWFhucVI2d2xFQk5hQjI1QmQxWCtVeThEVFpqcDRFRzRy?=
 =?utf-8?B?N2FJcHFPMFovVWVnekw1VUpqVTdMRmJEMzFieE1CVFpVN2pnTTMvR2dEZGRN?=
 =?utf-8?B?UkQwb2NuTG1PSEI3TWpsZ285NytYbTRyODNjK0xLTURCNDVQYUFmbjBvWnlP?=
 =?utf-8?B?ZDc5MEpYVS9JdUxIaVZTWXRzcEFrWTZIZE9wdGFnUitTZUtwVkpXR1VmYno1?=
 =?utf-8?B?bTdRMFNEdUFnRXBkZGc0NFptQlJjRmg3QlFNdmQ1NXFvMXpDN1ZSU1VzUmZ2?=
 =?utf-8?B?Y3J2eml1cFhUR1pSREZWTnJMTzlraUt3VGlXMi9tWW9KaUo2WEZJeFZiRTQ3?=
 =?utf-8?B?dkcxUmJLOGt4ZnBYa0h3dFNFODFwUnVmTG1RQTdhdzA3WllOVzkxbGZzMFc2?=
 =?utf-8?B?ck96T2Y2UGFCa0NCZERjYUNFN2VLMzR1cG05VnJlVjJybk5GMFlPRnVXMjJ2?=
 =?utf-8?B?QkFmVFRrS3FyNTd5SjN4bWFqTFFYQ3RKRTFsWHR6WWdjMUlBeDZoNm1ONktF?=
 =?utf-8?B?TmhIRGVudklNQ0xQZmtpcHM0VHlhSE4xUVM2UURWaW1RejdKOFhIcUxuN29B?=
 =?utf-8?B?TDlXZ2IyWlo0TE1MVHVsbTFhZ1NEYUxWYm41ZmNybmFIaWMzd3VWRElNTm1Y?=
 =?utf-8?B?cFhiaVMxV094Rzh2L1JHQ3ptdHptMnJzZ0pUemlCeitRNTJOYmVKQXV3SDg3?=
 =?utf-8?B?ZG9EdklyOFdHd2pRdzAvQmUyeWcyY2p4TlcvL21RNEFabG5FcEtnRDhyZVBF?=
 =?utf-8?B?TmNQMlpiTko5eUJzbnplNXNqTVZSTWtCSmxyYW9JcGc2SWFmdGN2bDA2em5i?=
 =?utf-8?B?L056dkVtSEVSc0g2Z0FlUzJvRy9ydjRvR2ZqZDR1YjBaSU9vSXl4c2NmZ1Jh?=
 =?utf-8?B?dERpNUs3NTRkeUlDcWo5bFhFUEx0bENzTFJqc1VkcDhRcXc4Vk1YOXF6MWJ1?=
 =?utf-8?B?dXpiSVI4bnFpRmE5amlqdDRNTVQ0Y1FpMjNpcFA3VWdadWovVzhSYnlMMmE3?=
 =?utf-8?B?cjZWNFRXNEM1QTlOY1hGTlM0WEtxd0dnNC9ET1k0YnlWaDFRZEpHeStRRjFz?=
 =?utf-8?B?a1N5RDBQdHFwWDI0TmtSL2dIMHBkRWpIb0NZMndJRmNIL1hhNTNxR3l4ZVNi?=
 =?utf-8?B?L3JaZWVaVGpTaEphS00ySHlOOTdXN3Joc2kzeWNRSXRhQlA2YXdlWTV5SXRU?=
 =?utf-8?B?MmwybVE3M2pFaUNnM01Rdmpvb3cwaGV6VnhLazNoWmtyekdtUWkvUWtUay9o?=
 =?utf-8?B?SzB1WXdFQ3B3dWh0MzNka2NiSU9SMUxOSXgvblIvRkQ2NkQweVJPRGNYS0ZE?=
 =?utf-8?B?N3ZvbGR6RU9pTk9hN1VGWk5EWWJtc2o3N3MrZzZBaHlNL2ljSmxZVXpqLy9R?=
 =?utf-8?B?TDJzOFM5RkdpWmJNMysvZ29YZFdmOXl6Zi93V25QVkNtbUx5Yk04S3czVHVt?=
 =?utf-8?B?RUkxOGplN1ZsUTA1VDdPblBVYlptSHF1YSsvS0xXNGhMR2JDZk1YMXZ6QUV0?=
 =?utf-8?B?b0M4VGwvZUZoL3E3b1BhVTVSaG5LOXkrMmpvb3pVbnVJTElmUkZHZTRxeDVp?=
 =?utf-8?B?MHFNajl3OGpBK0RPRHYxMFFrdUhVQ0xITDBCK2NrTUpXcEg1U1FmeXJtN3Zl?=
 =?utf-8?B?QXUrWnpqT2l4TU1LOWZOS1ZrZ0ZTd1JrcUNCRlR4ZWxsUitXcWpCbTFQN21D?=
 =?utf-8?B?MHJJd1Q5ajlHVUV1QS83RFF6RmtQWmtQYTBxb3hOVEtUOU5aamxlM0Y5L3hr?=
 =?utf-8?B?ZHhSN0Mrc2x1aEFTc3h5TjhJNmVYQnZkVFcxQXlsWkFjN2hIV0FjbEYxdmtW?=
 =?utf-8?B?QTByekt3cXVTZk5US0U0ZlB0RGRHK1I0Z00rbGp5bmpSWEdWUDdhd3E5ZEZV?=
 =?utf-8?B?VVJ4eTdjZ3ZOVVVxVi83ZC9zdnY5ZXZucmtsMTN2c0Y2R0tZMHZXeGRQOEFC?=
 =?utf-8?B?bElmTDY3OURRL1RDd3JPT0QyQTY5T0J4eVRUZTgvSnB6ZFdBdThXZVpLaFVi?=
 =?utf-8?B?MmtRbDNRS21NQ21Sb21lRzFVMWxRTnY5VTFNdDNwVGV4Wnp3azFZdDB3bmJa?=
 =?utf-8?B?OG80MW5EaC9POHJRYWN4cVNxRDRrNG5KMm4xN3lBYW1wTUh6RTRVY3NzdEhX?=
 =?utf-8?B?Vms1c01NUWt5bk84OVpBNTBSVUVTR1JpblNuMW9KTURJTm5SbUNEbnJWbkp2?=
 =?utf-8?Q?Ye1JO8UVhuX2zdLZ7m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PF+sUGkOFovovkwrwVxf88onONv1Gb+QUHxEt+715Rl+phQ1fRewwce8sPVt74hF7n6bMwQn/2anYQ66MENUE4nLHEs0snbdEsoAO0XKhhiTMnq1dsZfENctBY8tHt6dmjtzEdXf6pro708bXqD98RlSx1/W5z2N/a/KlJ0wL5tmrNbjqJitlSGs3nAPCoLKQo5kJ15alZ7Bzl3qcLzAc2purK0sKUF6rXhfHVqiBl+LShBIhAeIdm7SOR8YpOP/Luj2A5dbbThRt6sLPyIEqmEkqFwGN5YajgIyr/fL5iarFGqISJF9NC+lDzx6WkfrZQKsgvOBXKpRpV/kXOn0Bw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0426a2f4-406e-4ae7-b167-08df306cf86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 18:47:49.2340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pp3gpAP39Y+bFa1z+kvBVQvZ1Fi1Lh+YmmFmaWvw6bx+uI8OXBxHGWMraS0ulbA4WYNWBiO94lOTBfZqYM4usA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6134
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NCBTYWx0ZWRfX7mlKlF6sgJM2
 GVnPEjcJWiWCI6nne2JV7GLgbiDueHOt9QLbqfWO5dr5yxzp3TKnrXf0jruxJ4d7z/7pQp2y2If
 aDnCv26t1RoQYL5iv3QhlERdleaQtVI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NCBTYWx0ZWRfXwzpBTlmVilsm
 g3LqT6mG/EUIUVHba1NVtyu58FfrmKaFONer2MdWyLS9rSL2/7QscMW04vi0SPqz0ogvUE8x1hH
 9kP+9Gys8R8JPiEOk2UBqGO3XNsd2YlINlJpRH4UwLm1a2amuO6pRdg6ITv2kN1LcgBXOq6FfFf
 ojWUToNzw2MUnZdwBViE5IXOyZksWEn3Dr7OD8eMgJOh6q+Q9NxlFiIWKPYjWPGXyGirmRyUNN6
 2eQjjAK6Imm/UkpYzPhi8sMtvoLY678xN3BrCSoVpMIMTHi6xEUWn53UxEeNArXM+evpP145WSi
 L7cjS8pLdI8D6OfZhSsj65HlXOBPi31GnNID1mhJbbaXuOBv21tfU+mr2VgQRTo88IST52vhHN5
 8J0/A/yVdknUC4H47CfftJKX2VWNqTF3ZiE8u1u+0UkfqdUT5bN5Bq52vUxPEsUtOHnvE8c+TwF
 QqPQ7Elih3AINRt4lXA==
X-Proofpoint-GUID: 6uz5SRj64FPreCR1kI_oiLMSvGKdwSqr
X-Proofpoint-ORIG-GUID: 6uz5SRj64FPreCR1kI_oiLMSvGKdwSqr
X-Authority-Analysis: v=2.4 cv=PalqFShd c=1 sm=1 tr=0 ts=6ada5a57 cx=c_pps
 a=W2lJqvwlxpc/IP2FXjrMFw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=SMN5E2KFuazxXanEwq0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
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

PiBWMy1jaGFuZ2VzOg0KPiAgLSB1cGRhdGVkIGRwYWEzX3NlYy5pbmkgd2l0aCBjb3JyZWN0IGZl
YXR1cmUgbmFtZS4NCj4gDQo+IFYyLWNoYW5nZXM6DQo+ICAtIFN1cHBvcnQgQUVTLUdNQUMgYXMg
QVVUSCBhbGdvcml0aG0gaW5zdGVhZCBvZiBhcyBBRUFELg0KPiANCj4gVGhpcyBzZXJpZXMgaW5j
bHVkZSBidWcgZml4ZXMsIGVuaGFuY2VtZW50IGFuZCBBRVMtR01BQyBzdXBwb3J0DQo+IA0KPiBH
YWdhbmRlZXAgU2luZ2ggKDYpOg0KPiAgIGNyeXB0by9kcGFhMl9zZWM6IGZpeCBidWZmZXIgb3Zl
cmZsb3cgaW4gR0NNIGRlY3J5cHQNCj4gICBjcnlwdG8vZHBhYTJfc2VjOiBmaXggRkxFIHBvb2wg
bGVhayBvbiBzZWMgRkQgYnVpbGQgZmFpbHVyZQ0KPiAgIGNyeXB0by9kcGFhMl9zZWM6IGluY3Jl
YXNlIGl2c2l6ZSByYW5nZSBmb3IgQUVTLUNUUg0KPiAgIGNyeXB0by9kcGFhMl9zZWM6IGFkZCBt
aXNzaW5nIEVDTiBjYXBhYmlsaXR5DQo+ICAgY3J5cHRvL2RwYWEyX3NlYzogYWRkIHN1cHBvcnQg
Zm9yIGVudiB2YXJpYWJsZXMNCj4gICBjcnlwdG8vZHBhYTJfc2VjOiBzdXBwb3J0IEFFUy1HTUFD
DQo+IA0KPiAgZG9jL2d1aWRlcy9jcnlwdG9kZXZzL2RwYWEyX3NlYy5yc3QgICAgICAgICAgfCAx
MyArKystDQo+ICBkb2MvZ3VpZGVzL2NyeXB0b2RldnMvZmVhdHVyZXMvZHBhYTJfc2VjLmluaSB8
ICAxICsNCj4gIGRyaXZlcnMvY3J5cHRvL2RwYWEyX3NlYy9kcGFhMl9zZWNfZHBzZWNpLmMgIHwg
NzggKysrKysrKysrKysrKysrKysrLS0NCj4gIGRyaXZlcnMvY3J5cHRvL2RwYWEyX3NlYy9kcGFh
Ml9zZWNfcHJpdi5oICAgIHwgNDAgKysrKysrKystLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMjAg
aW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQpTZXJpZXMgQXBwbGllZCB0byBkcGRrLW5l
eHQtY3J5cHRvDQpUaGFua3MuDQo=
