Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEA5606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=h4WIzFRw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3749340264;
	Thu, 22 Oct 2026 20:58:00 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 356EC4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 20:57:58 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHuoIT1382414; Thu, 22 Oct 2026 11:57:57 -0700
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022099.outbound.protection.outlook.com [52.101.43.99])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hf94b5mxy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 11:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy+ayX+uGbM4q2lUCM9ePGRvKpOutSuclMJDho7s/1NBsJB0wXZbrj2TCe6Yx8QfnjbfEgqT/jANJ5eqH/Wl3/bcvuKe0feOeldRYdgy1cI2UN0ZvVwSslQTtH85icLNcIPEli5bLQwuOJIXopScvYgUrw8E0QyKGa2Tioi9Grm6tv/PHsOwyAU8NX8Ubt96rvpjYTZx6y/XHiNASHDthEnc7fsIbI2wWTYmWVvVMS8Z19ImjujGMdIHNnVNM3YdYL8jE7Tuwcj4kEQAd77hAz5wpnmgPXEUK/4tQ5wN02DdVgBrYLik3apSqI7XY0ze5ohNb7+nM17oDhZSEeB2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ED25V4OjQM1FAgfwr1fz7th29vf2Zr3lgCSBjIvBHo=;
 b=W0gGd78F3MsUVe6lVk/D9ygh/9rXT/olIlCrcBzCkdqtpMXX4xu9nzQSzllvS3FC+QPZsE3VKxqmt4rH6g+ybffe+KXyjN4MxhimcYEbN7lvBc+d6SssCLX4EoosN5yU4vfDcZz25OyeCM+w2h6t+xu3AJGAzhBRs498LcrcJbwVxJgcCU3gfA1YU6mSMatWP0BR6+RjOkgA3O6TnbCR6DXSe5XecRWbOZwNcePwJGfXT0kENtKr+iGk+8yDYajYZ097/0BkqPz8/SAvmdZLvFXym0+irD0U2TVZ+p/jmz9o5rR/zaoneyMhba6yvmGv03k5jGocV+YI7jKYJF1kqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ED25V4OjQM1FAgfwr1fz7th29vf2Zr3lgCSBjIvBHo=;
 b=h4WIzFRwP6TyGkZxJNnZuKfXVjReO/0sehVj6YU7FTCa9ZrB+Bt67FKQtHEiTvXoYJVuXS1HlfolbgZogzwKXKyQ2Vchrv6xZ4CDgQnN29kOB6w2rD1Q+BmI0DihTMdT0rWMB6mtBDPXG5HlmGfVoVg7UgFrCZFsEkv8ZcvamZE=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MWHPR18MB988534.namprd18.prod.outlook.com (2603:10b6:303:2a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 22 Oct
 2026 18:57:54 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:57:54 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: "Ji, Kai" <kai.ji@intel.com>, "Nicolau, Radu" <radu.nicolau@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [PATCH v2] crypto/qat: add Gen 6 support
Thread-Topic: [PATCH v2] crypto/qat: add Gen 6 support
Thread-Index: AQHdYJoRXKFRQB8I9kGFxq+9dkWOvbcJ7K5A
Date: Thu, 22 Oct 2026 18:57:54 +0000
Message-ID: <CO6PR18MB448466B30C3F5347D83DA6F5D8652@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261016131152.2298192-1-radu.nicolau@intel.com>
 <20261020114412.2353140-2-radu.nicolau@intel.com>
 <LV2PR11MB60451368E05BA6CBA9E212D781672@LV2PR11MB6045.namprd11.prod.outlook.com>
In-Reply-To: <LV2PR11MB60451368E05BA6CBA9E212D781672@LV2PR11MB6045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MWHPR18MB988534:EE_
x-ms-office365-filtering-correlation-id: aedd6c77-b426-4043-1d01-08df306e60f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|261022105027099003|261022075727099003|38070700021|11063799006|56012099006|4143699003|261021135927099003|10067099003;
x-microsoft-antispam-message-info: NDTuHQFi6ZiiLhKh+u50iL8V1ld04QzOqEaTJasZHow1xBs2lCNyh2mze92WxUMdkCTQqYynIc4rwFMvE4MlwOu3CvxLBbNV9rLdULB+d+VM+qAQWikdeoovbBwA7AU8ErfH+qZke1ZPHE3zqYkD9fcH2gzR5LmTThnE/rV6NLPEXoCqMtLGCZOE5tQ3aBvsRYTBUzDvZAilGsFXkNr9sUIbeKNF7xpCrnE8yAet2CBfQ25tJLHY5xuC+09Xzg+UBRhyw1GunUfxEaBitZluVhTF+5fDS+uxmug3d+d8N+WLLwEQmg5irO6Np19MxRmOHlSB3wuUX4Uk/6FSke7zvK/CqDw3MUUAkCmu39hmOlpXMNEP1OKAVG+RAzZbiFHHAyykV+/3HG8OICfZcPwED+RyS5dUnRycCLJGJKsXnVRB47lw+zXMlSMdvFbtUaXPqcThIasKuOnkIl8klH1cjl57HJtYWwpEmenILix49FXZflc8NV5aYbzDMk7ogFOVge9JdFsnRZbWSf8xsn+U0LyufGp/J197ptk+3EIFSwWTnHJaPhw458hIJ42s8vwBoV/y07no234z0r3OkojnSU+Hg6H5fWb7LVDdyBFqHtd3T2pd8k7/3x6q+t8RsfTRWC79XercUDuTi4LvNUYMENMB9nIxjveWfTYEguU6odm/J5waiK3nmgSoY4k/qh+nRRLM7LTJqDFLA5r40YZ6LQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(261022105027099003)(261022075727099003)(38070700021)(11063799006)(56012099006)(4143699003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2JER0hwbHhyTXVmcFVjdSsrNnZaYXNydVJkUXZiaHI1QkZnS245a2lTalJ2?=
 =?utf-8?B?dHhmTDVpczhVV1FjeFg4c2NnTmVCV2R0dU02a0IyUGZnUWJuN0JjdCt1NlNP?=
 =?utf-8?B?OVdrRGlLdnNrN3R3bnJNUm96OC9Ob1JqNlJCZWlGb0FSRW9WYkhJNTh3cTJu?=
 =?utf-8?B?TnN2Y3lSQ1ZLNkR5QTNDWEtmZGh2NVluNUg3eWFhczRNRkg1U05HVm9Ldk0v?=
 =?utf-8?B?eVM0TkRuY09IYWUxRHZTelc5ZlJnQXM4WWpqeWhVcTlTdDNwTWNkNFlTeHRJ?=
 =?utf-8?B?blorQWhIdHpkNDUwNkVEb1Q5NUFabU9uS3kzNUdNZHB3ZkpiYkxlcXQ5UWNh?=
 =?utf-8?B?VHZ3Q3F6dzRoSW5oUkhmYmRFQjVWOFd3L29kN29xdVgzd2RUNURyRHJLR2dT?=
 =?utf-8?B?QUQ2ckM0b054SHNKYVJzNHBLVUJVUFNKVjZyNHhTMk5mMW9LdFpjbmsvL01D?=
 =?utf-8?B?alV3TkhGK3ZaRUlNeUVXaERWNU1TQTB4RHphYkhvZDh1VGM0OEJWY2owbVk2?=
 =?utf-8?B?dkQrdDZrR3JYTERSVitUc3NWOWVEWTVtNU5hWXd2bU9PL0JPSFZsbGF4NnJh?=
 =?utf-8?B?NXQxbVRRYUNNaVUvR3I4SU5EMjFjUTBnQ3hFeDZzaXlUT255bkZzaDEwY3N3?=
 =?utf-8?B?akxFcXhKRUxpUllsdHQ5OWh0M2YzL0xNWnNNTWxOMWFyY2c3Z2ZCSWl1aWJL?=
 =?utf-8?B?VmtyU2J5MU9FOG1IcS81a0c3YkN3S0RFUEhiTWdLZkJoSGV4eEtiNU1USWlB?=
 =?utf-8?B?VHN2M0J1b09SWHdxc1YzemZVLzRMbmI2Sml5bUVsQ1lZNE9aajZkL3Y5SWZr?=
 =?utf-8?B?YUxDbjFuWFdmdHFRUFdjQ2IwVEJKb2tHdnpBWU1jdXlxSDh6eWR2NzIxbWdr?=
 =?utf-8?B?SjNTbjJsV092ak96Rld1YjVpV3RlOVNEd3F5a0duajZINWx1aDhsK3NROHhK?=
 =?utf-8?B?S2VBcUd0aVBKMmJucWVVLzBYbGVKQmZndFh6WDdtUnZscFhJSFJrN3AzTzht?=
 =?utf-8?B?UWhzVjk3OG9aNlM5TjA3RmMzK01XeVRFaENWaG9uOW9RRE53RlMwaEFocUk0?=
 =?utf-8?B?YjdZbEpOdHlDNStSMlJaMVdFbGpEQzBwWE5GWWlyUTJYR0dRMk13ckNQdjBH?=
 =?utf-8?B?MUVzWlozcDFnODVZWGdtK3BWQ29SNklLUjk1cE1XZy9YMjJOamlPQkMxV0Fu?=
 =?utf-8?B?QWZHZUU0NkEzQVdLWmZ2U1Y2S3duTlJkMHpBZVBGVVdUZ1Z1bmIrQ1gwRnp1?=
 =?utf-8?B?Z1lMK3JLUlpMZHcreGlVeWJyK3V0dzhsa3Jrd3piRHJpMUN3aGQzemRLNC8x?=
 =?utf-8?B?V1E3MEUyWmFpaGZhMkUvekxHWThMUmhnNjhIcXRpeFcrSUlEQllMa21zdWtU?=
 =?utf-8?B?eXh2aDFSYnBOMERHNlh6RmhSWTZDK0dVOVZFVEhzYVhoc2tDT2RhanUydFRy?=
 =?utf-8?B?Vk9sd2IyL3dKZ0x6N0prRjlMY2c2WGtQa1c2MmtNMjVjdUo2S0RoS1lNTXJt?=
 =?utf-8?B?M3o1a3A3QnA1ZHcxNVNkZVZ2RXdxaDQ4VEE4b1g5SVB5SWRZdm90eXRLL3F0?=
 =?utf-8?B?UUY1WXRSUlN0ZmtCdEdIQlNOaFVRTnhXOGdNcWdrTk9xTFBNK0ZFbGo3by8x?=
 =?utf-8?B?bFloeUNaaWlyU0NQa28xcmswdzVYbTh6N3dZSU9reUF6ZzJVa3h6OHlCMTFi?=
 =?utf-8?B?aE02eHhYZG5qNDJjeXVSYlRTZHVxTDVDR0xST3BDVElORGJScFYrZ1dWKy9E?=
 =?utf-8?B?bTZ5YzhnSzV0V0d1MStqM2hqdGd5bThaYmEwMjRVeE9vVFFBOFFqbTViL3R6?=
 =?utf-8?B?SEFsODk5OGJodG8yYVlraTJjMXArSlZra29RNzNUWW5XeFRpTk83c1RDTVIx?=
 =?utf-8?B?R2xmZHZtaXZQejFScXRNVElnMDRqV052ejFkNTMwcm11ZHdMOEQ3M2tOcVBD?=
 =?utf-8?B?dFFBNnRvTTZOQjdJOTd6RjNpY01JQUhqaThpb2tUektGRlRGZ25aa28xZkox?=
 =?utf-8?B?SUhHQ2lQR3ZtYldTRVBuRkV2N21LbmFwN0RESmJTa2t4OXhrVlBQN2QvemRR?=
 =?utf-8?B?cytaUitDZUZuMGxKMG45azFDZWRCTWF1ajk3dGNIUzFiNDNJZmdpOG5RdGQ1?=
 =?utf-8?B?MWFTaGx1OHF6TFNDcDlFR3hneERUNzZQN2JqNmE0eEw0Sm9QS1J5OEV3cHZr?=
 =?utf-8?B?Vy9odUNDWEw5WG9pd005eEh5NjJoazh0cExuWVh6K2VXaDV1VXYwS09laWFL?=
 =?utf-8?B?cDR6TkV5ZURVbDJSZWVrY3libUsvNkk2UUo2VTBQM0wyODlnbHRESmZNT3I5?=
 =?utf-8?Q?Ei6igZVH+mTrMZ+k9B?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1uDPdgqnt07T4S4l1bJCrvwiW0v/XpC1KLvYYXROfN4Jip7jjkL0Y918yhhFjRuuqW10fXT1x3UTNa9bQzUEPVdCM+/otBIF+5xoV4fU8mGHH0m0goLtxLb1mDwE16U4APHvIA/DUpHu4uaIOtnudHqN0IRDObxIHHgZ7M400QL3usgO/LIWX0g0o0NPJY30AUyvPWRyC/EmIajR+ggV3MfKy+ItL6XYZS8CbQmCZZDvgHTAnIVPmc0KShrvkpfZ6XT6rV9tutYJ7ZBoDt0R4Zi/RhDCof9GrRjXjv+iW5bL7TaFnjri4VzjFRdylgS5nfLmXFW2neeZR7KAv6gQ1w==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedd6c77-b426-4043-1d01-08df306e60f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 18:57:54.0886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AG06nYl3VHpWQJO6MdanPuRpavyA2Xk7TztO5pjutgkVGVyeIo8J3hdX5ZW+XL9DurAHOEio0esXFA/alCdpnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR18MB988534
X-Proofpoint-GUID: MR4PrAgLChi8ThRWTiqWk95YXWPA9iej
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfX64NCTHd6S+ir
 N+fbLCBKMWHZzBTPrE9y6/XJ3jX76viJxUiNVXTzATG3WI2OwmtmiO1efftkbJ8CLJ9i+ZwlvM9
 gB2uGVGlKq15DvWTVQjKfhs0bhUXN3AGdoBYsY+wS5YYZwNeZ66USK4Rw7WrJnDpqUgeJs9A5AD
 md3SA0MMJC6nFJ3O0fMJADhwWvIeZGRRuZ/+aDFCfFnYFH9n19uuiVMaUCRP417xul/mBM1/8SN
 qt8D3Ry610dfh5Y6F9uhdS8vWnmLFGlzDFCkfJawK8JKIvXIpyvatz/MH8E2k44k0CoBG6MLaCA
 Ogk9QLz0iKGJCOqXpc04BnntxdrJrzkn2lRpGliGXPIHrQHV0hECrYnZ3CT+mWGAbXeUFMZOYxg
 Niao1xIgsn3nk7FYO5KXkI/wcWrs+BtjhZsAIorelHO4wg7DoBEpUvD9LA3EfaBiFp/hEgd9MYa
 8j1+o5mkrGoVmk8M5cw==
X-Proofpoint-ORIG-GUID: MR4PrAgLChi8ThRWTiqWk95YXWPA9iej
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfXw/nKWaT1NVuf
 3J29GPo3XIMy3iSHt08AGvk/JuhChkbA3hUznAydgpt0ZK98eM6zdHAj69re1H6kW0gDP1J/w4e
 lHkI1eMPAJOtFTf8ey8Q7KZA7yZ5ipo=
X-Authority-Analysis: v=2.4 cv=OrDaWC/t c=1 sm=1 tr=0 ts=6ada5cb5 cx=c_pps
 a=MyZQQtGQDv4zT9mHdzB88A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=QyXUC8HyAAAA:8
 a=8rWy6zfcAAAA:8 a=kjieFmHZY2pzukC6T2wA:9 a=QEXdDO2ut3YA:10
 a=YjdVzJdQTyZRADMV7wFX:22
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQo+IEZyb206IE5pY29sYXUsIFJhZHUgPHJhZHUubmljb2xhdUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIE9jdG9iZXIgMjAsIDIwMjYgMTI6NDQNCj4gVG86IGRldkBkcGRrLm9yZyA8ZGV2
QGRwZGsub3JnPg0KPiBDYzogTmljb2xhdSwgUmFkdSA8cmFkdS5uaWNvbGF1QGludGVsLmNvbT47
IEppLCBLYWkgPGthaS5qaUBpbnRlbC5jb20+OyBCdXJha292LA0KPiBBbmF0b2x5IDxhbmF0b2x5
LmJ1cmFrb3ZAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjJdIGNyeXB0by9xYXQ6IGFk
ZCBHZW4gNiBzdXBwb3J0DQo+IA0KPiBBZGQgc3VwcG9ydCBmb3IgR2VuIDYgUUFUIGRldmljZXMN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhZHUgTmljb2xhdSA8cmFkdS5uaWNvbGF1QGludGVsLmNv
bT4NCj4gLS0tDQo+IEFja2VkLWJ5OiBLYWkgSmkgPGthaS5qaUBpbnRlbC5jb20+DQpBcHBsaWVk
IHRvIGRwZGstbmV4dC1jcnlwdG8NCg==
