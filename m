Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27ACCD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 18:38:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 963214025A;
	Sat, 20 Jun 2026 20:37:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EF57A40151
 for <dev@dpdk.org>; Sat, 20 Jun 2026 20:37:57 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65KIErEN2221919; Sat, 20 Jun 2026 11:37:57 -0700
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020141.outbound.protection.outlook.com [52.101.85.141])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ewtchgmph-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 20 Jun 2026 11:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iz9IOrBPoyFSq9G2YuFaPIgvtie2nNQ5LKDF1iQMgBEfLHAE8+NiEgZE6fIWtJ/ljV1WNH/ug4MuPRSJvZ+Ee7Yg/hDDkvJotvhH5j0MEkVAkJ/kTsMRXFWRHFklgugujgIZXC7e4aDozTWQj9opD+9QeByzHIhTPag/TLCBMHK+U94biI8hQormGinDcXXY9x36biywQ+iRf3bgOY9GMdTdbKLCQII6FAySiy/Oz++EXuchfActEi0zfP0Eeol2750xkm0Zcfje1Y5kbsD/0gwXo/HZKuTLB788mnPZyIwfsE09jrbaOSGxFuqS213GAliYgG/dBMl58luItsdJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdkEYMAmgxjhVNCZkbagpWW5YyBVjFh+CQrOsQBXfX4=;
 b=xhRRUG+CfCBnvxARTu0lY1iKF5O94cFa8M8ZWYDwi9rzFta4ozzSEfnDF9LmfdEFsNv0c/E7JAP+c+/bWhsHwQgPScSCpiaOaDowExHKq8Y314YO/X+2GBha1WzijOkL9a+TwWmEy42ZcMgknFiZTwz6V7uAk0H6j5hXleM2NBMziQq7cxmieuNVWBGhC9mIZVa2aulntat4M71ruDXylniUFuWZ1jBixv4jE4X1YWDyXM9syqt+0+m/yxY0ZOKz7msJw+b1qwy3WhD7yfOiOp4PyT7JP1EWh49UniyScfis8xrqlo6wnhRGPfmC94Y+LsVertztInfe3LeprdanEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdkEYMAmgxjhVNCZkbagpWW5YyBVjFh+CQrOsQBXfX4=;
 b=vAbggKCuk7pv0h0wMa1n7oKdEVHi3N7xmg++A0ejbkZ+2FrCnVz8dPKVnPuPnjdYY/898bYGt23vf6h9n98qlPG4ry7JtJnbYnuO5dcy4GBVQRe9Q5y3O9kWA2mmA0nWdDzwlrKbU9Ef8vfvpvk7BVwk4l4SiGzJyCRc1GLL0i8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3660.namprd18.prod.outlook.com (2603:10b6:303:55::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sat, 20 Jun 2026 18:37:55 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 18:37:54 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [EXTERNAL] [v2] crypto/qat: require IPsec MB for HMAC precomputes
Thread-Topic: [EXTERNAL] [v2] crypto/qat: require IPsec MB for HMAC precomputes
Thread-Index: AQHc//MMUz3fWtx2LkGITobHjsYeebZHx5CQ
Date: Sat, 20 Jun 2026 18:37:54 +0000
Message-ID: <CO6PR18MB4484BD4C2427D350C902A8E8D8E12@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260611085237.1459286-1-emma.finn@intel.com>
 <20260619135330.1821985-1-emma.finn@intel.com>
In-Reply-To: <20260619135330.1821985-1-emma.finn@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3660:EE_
x-ms-office365-filtering-correlation-id: 8a0aadac-a88f-4bea-d897-08decefb0af1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|3023799007|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: VWx722fLN2nUitozwF5m13gTyijV8BKkz1J9XdvBHQVgbAyGA4dsaw80g2Mo5jtH1HilU7cupkREGsRa7ufbQ3oqTP1XbO7z/wS2pbZoNn26TsEmJptjZHm5CAz0Q9hW+FY9ggcbv+9bh+kG3lBQXQP0A/fZmce+Wl49XRcXSYTqua3IlOptK03oqygzc2yWQ5EYBHjJ2N6PGyp6xzuv7jSCSW5At//0BuxeumodAJZ1yRwS4Wz/SUKdsp4fjk49kl/b2OoNq5JJ9HzA5MhkC+KbAjwdKbyhtX5hV3BRLHhTLuNa4xFx2l0Db+pav5TCn+Y+B7xSwGlwAAs/8OT5QYxTIuaK7oIYeMhCTQMa2gTsBB6frzjc4jYwu4IBCX+8PRnWliDz/9EQfiEy6DD2vN22QdA0BOxU5ldQe3ecRWQylk9wuB5bpUMBK7iIThLf7bP5a4xoUbPSsl/wifS/5XABbYQ5gYoChG3Y0LiyeV/syt7+H2E3FkUhtZ4rgRwiVaHIq8elBUoX7e5LJ4PlcvHYvjiIk9OmiCgh29Vh7sOL9bgT/HbSI4paQVJiqS5aMAtoGBzeVFeGwAWzoEOnM71FYbt2+a7G4+TpdwrCe5CAJOFknBmODauMh6JvaY/Qgobg2F2zrKnZoa3g6qj40992xLNeGtj49xQvlL5Fwc83iJlXl2t8+WBu+t12ovR65KOhcK7lHRk9sCW4MOPEDkMU37ViWmkGpBvqBiwn46g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUlkdVhBbmRKYktRdEY5SS82QkN2U0RUN203YU5nQ2dOK3ZpRURhWUE2MEtT?=
 =?utf-8?B?eVJnRTQybkl4M3BsMXFNb0hKdGoxclVEMFpmdTNmemxZVG9vZEdmSlpWcVlD?=
 =?utf-8?B?bU01WlJqd2JPVHdLVk80K2dBWkQ0NklRZmdkL0pzR3VQVmMrTnhpK3ovSTRG?=
 =?utf-8?B?TWl2YVljcDZrVnRBb3RqMU9SbG9EWjZ6M3MxQlgzajU5OHV5UXR6bWN2U1BP?=
 =?utf-8?B?d1BkTUFhMVIxdFRHU214SWlqNWREaWg0Zlc1WE8wVnFTSTgySUF3M1dzS2FM?=
 =?utf-8?B?eHhXcnJ4Z1J2NGFqUk9pTE8xWmlxR3psVjVvaTZmNkwwWWg3VFhYZlVwbVNn?=
 =?utf-8?B?WmJ3RW1NYlZQcUZIcWY3Rmh5OGNoSENIcTNiVFgzdTNrTlZOSHhzc09NQUYy?=
 =?utf-8?B?Tnp3RjF6bGdVak51aFliSmJlSm9OekczazlqOWJGU2g4a2JKeXV0cTlEM0Ix?=
 =?utf-8?B?ZDRVVkNieGEydWRBcVI5RTd2alNvNENORml0Z0UzRjZiTUtWTjhrSGxObU93?=
 =?utf-8?B?cGlIZ0tQQWNUdWNYa0d5ZzhHbDlpWGVTM0MrcEJ0OHpRYlVLVHpFRlIxMnpI?=
 =?utf-8?B?Y0liaDFkcnlCYkovRWhVQ0IrSFNENTdEVnVTVVZBczRsZFp1b2hpYm5jNkxj?=
 =?utf-8?B?YjdkSjFBOUhmcTJNS2FjUysxMjA0eHB6L1dNUjZoTUtaN3JtUlpwV1hqRHNJ?=
 =?utf-8?B?YWVveFNkSmhpQzJSOTdmSWlOZlpITml1K3E5WE0yVGdJR0NPTEdnd2RhMGJm?=
 =?utf-8?B?Smp2OTZKU2JOL251UTVaRkpRd0ExQ1hBbHhab0tZZnZCcWZXaWVwZkxOQVIz?=
 =?utf-8?B?KzJRM25qbmlnZWZ0RzZjMmNMMWFRUXp1MDkyNWZLYWRKQkl6eWhpSm82bE5B?=
 =?utf-8?B?MThrWnFjSVp4L3RvZFdHNmd6NXBtSDlHbE1KYktWenprOXZ1alVuVUtsL2NQ?=
 =?utf-8?B?ZS9lV0NqajNnQmJ1REhWOTdNblRXQlVoUDJKaU0xMFlpWElHajk5L056ZTNZ?=
 =?utf-8?B?czZ5NXdMOWthNmlnSTRubXVWbzRBQ3UxaE5QMmJ4RGNESm03RFluZVVzOEdR?=
 =?utf-8?B?b05QSXZCdUZheGFKd2NqL2ZTcS9xVkRWbnpLL0hPVi96T2h5U2dKTXlGQllS?=
 =?utf-8?B?amE3SXkxdWV3Y0gvQkNZQmZHZVB4bGNiaEtVbkxwb29JWDFDSG9KQlNJSmha?=
 =?utf-8?B?VS91bkIrRzhIOWFkbFJrR3JVcmVWek55VXo3OUxmTlRDaktkaWpwSytQdHpQ?=
 =?utf-8?B?YVFJVlM0UGdKeklwTC96QjNYbTVaQ3R1bzVLb2crVk93WEFRUGU2MTV1THd0?=
 =?utf-8?B?YWVsVWJQVGRQcGpIYlVBRi9HalpER25UN1BNSVFld204WDROSDZlR2RVdTcv?=
 =?utf-8?B?cERYSWN4SlBrdFNIdkVtRis4Y3owcS9na2xHV1JrSlZPdmlBQ3l6YjZXWUVV?=
 =?utf-8?B?Uk9pZkUrZm92RXpGWnc5dVVjMmJ4bHJETnJQdjNaZE9tdDltNldJR1h3RGN4?=
 =?utf-8?B?c256V2Qvd0JydlZ3akRjci8yWmhxZVhiYlJabFhoRE82cmM3TUE1YW1IMXlj?=
 =?utf-8?B?eE9tWmpJSjBQelZXaGVZNnlLLzhobnk2U1RjYUNQOHp3MXlZd1JPV0NZVkpL?=
 =?utf-8?B?aWprQzRTcWhXVWYrUU8xTkFtWnRHck0ya1JEbGlwMCttOTJxZ3E4T2lRR3RW?=
 =?utf-8?B?OGVtbnJjME44dFhNRVljNExORUs4ajVrZ0tLN2prUC96KzFQWmtoZDVhM0dV?=
 =?utf-8?B?RGU4ejhzQ0E1VEVwelV0Um1oRDNXQjJZcUNMRFN4QzIyb2c1Z0x5Z0VwYlA3?=
 =?utf-8?B?WjFpRCtrTzRHYzhLQTJuTHpYV0NsZlFQU2d3TTV5QmZlSm5DZXA5N0tYcjRs?=
 =?utf-8?B?NEhYdGVjUFhmTkdhNkxSS3g3QUttT05GcmRLTnBIMEhXNzJYS3R0QldJYjRI?=
 =?utf-8?B?VFNjQXpNZDR0TG1qU2grRFUvL2NoQlJKdnZtZEhzaFYyNEJ1MDRmMy9RMGli?=
 =?utf-8?B?RE5TTmh5UkgxMHZUTXROMW0vOVhSUkJmS2JGSWFJVzk2ZXZoa0xTWUttU2lD?=
 =?utf-8?B?dzRLeW5WNTg1SzB4MCtubWx2dDh6VUx4NnFCOUh5Q2pLdm92MkxOSFhxZlZ3?=
 =?utf-8?B?MS9SMkdHOU9KQlFaaGRGMTdOUlJWUW01Q1ZHRUs2T1lQSC9tZVNueTg2TVNq?=
 =?utf-8?B?cnF3MmIvN25oT1pIdmhJYml3b1hiQnEwcC9ZRW1jNVdKK1IvQkptS0pZdHNO?=
 =?utf-8?B?bE1vdmlndG1UNStyS0xWUjNNeVRib3B4MnJ6dEM5eG1iVXNvSEVPNDhqaEx5?=
 =?utf-8?Q?LDa/L8PGc3NPqdHxpT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MEDaYT/49yHlXPm85Xc4fUWea+TWXabd1oHCwoaR7bBDQ6fOW2nuCZ2KsPSlVDv8TPfxaZqIIpCCYU6eh2nGi33iqmrzGsaiNVL6O3+cV8bM0ZKyD+NC+KLT9fexeCQ9061NZsjkoCDN8WOQdRRqZ1ygfZA0oR3AtZqUtqIAJY+JRftCcwDPwpDFbv8K0LAc/JQ39uqko3rTNgOvbWpY54qx6eYTz+VIktPOBaTGGlpfZIM3ON/QrU8ApW6vTmgXO3xwpN+NI/MiwEw3qMsJOA9aTCTElEXadjYd4LtPBkMLORjCFA/OmfPmRqQVV4Du0FxWn9TpKE3QuNdg8ckGCA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0aadac-a88f-4bea-d897-08decefb0af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2026 18:37:54.8724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Umc4B9IYfhwrfu5MNnvq1xit3sX6JGqt4U6HRNN6eRFdJVjDhYK8okqxX2DFpYepHOOtNV9OxnE7A+99y58WGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3660
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDE4OCBTYWx0ZWRfX1kT5qra5AR3R
 EpewmEFbqUBpq/Rjia1rzmJia2TTiZXrz9tg6/QfbK2/LICa2huNn/XUNK/Q6zWyX6OjLpO2YBn
 x7BjxusQkjw926wYHwnmtx/clPajPV+eIu4uvUHiV9v1ckd8N+zVDwnszSk3XpqOYBvv/Gg30as
 wX8JGJk3nuAe9hbINxVLv+E861NjMTsCyL5aiM2psxKTxFMcjO57fnJZF+QmePrqcbSkuOTqWum
 cOz9XdPfD9l3hjVmNRLY+9SunBlsIUlxLyo585Vhqj2t3SM6MKnEH3RvF2+mo5g+70K+YtzV3KW
 3j8iTo6Xpa34r992Nwgd7a5cS3j9DMPIj4THxb/DaRULBIJM1vWpp9ZNSB9Fv8Ky8t+bb99Me1D
 cC6GaWqW9VaWPd7qxwpm90TtwSsG7V1EYOC04N+xsYXcM7NN1zAOC4uXYiraCPAQOj0DOWmPhVP
 76W5V6JSHhOoGgPzPIA==
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a36de05 cx=c_pps
 a=g/OBtAqTw1pRpVLcEUWRsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=SRd8ZzaE51nQne8klxkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: c5iDtEbDyskHQWe6cPq_-AuIJdt8K6dR
X-Proofpoint-GUID: c5iDtEbDyskHQWe6cPq_-AuIJdt8K6dR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDE4OCBTYWx0ZWRfX9PeJI004rX4J
 xflFqeUQvQvG0fz0Mx1nyRYi3RHDb7Fs9Z05uQVOJCKO6XVy8Cai8o3BcGERSTOjY5rBKNtAguS
 bEXyBV4XJgPPbjDVaFQ6/Z1M/7J7A34=
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

PiAgCQlpZiAocmV0KSB7DQo+ICAJCQlRQVRfTE9HKEVSUiwgIihNRDUpcHJlY29tcHV0ZSBmYWls
ZWQiKTsNCj4gIAkJCXJldHVybiAtRUZBVUxUOw0KPiBAQCAtMzE5Nyw2ICsyODI4LDExIEBAIHFh
dF9zZWN1cml0eV9zZXNzaW9uX2NyZWF0ZSh2b2lkICpkZXYsDQo+ICAJCQlzZXNzX3ByaXZhdGVf
ZGF0YSwNCj4gU0VDVVJJVFlfR0VUX1NFU1NfUFJJVl9JT1ZBKHNlc3MpKTsNCj4gIAlpZiAocmV0
ICE9IDApIHsNCj4gIAkJUUFUX0xPRyhFUlIsICJGYWlsZWQgdG8gY29uZmlndXJlIHNlc3Npb24g
cGFyYW1ldGVycyIpOw0KPiArI2lmZGVmIFJURV9RQVRfT1BFTlNTTA0KPiArI2lmIChPUEVOU1NM
X1ZFUlNJT05fTlVNQkVSID49IDB4MzAwMDAwMDBMKQ0KPiArCQlvc3NsX2xlZ2FjeV9wcm92aWRl
cl91bmxvYWQoKTsNCj4gKyNlbmRpZg0KPiArI2VuZGlmDQpXaHkgaXMgdGhpcyBvcGVuc3NsIHZl
cnNpb24gY2hlY2sgcmVxdWlyZWQgbm93Pw0KVmVyc2lvbiA8IDMuMCBpcyBub3Qgc3VwcG9ydGVk
IGluIGRwZGsuDQo=
