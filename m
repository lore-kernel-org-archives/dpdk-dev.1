Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DFFE7314A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 09:52:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8010A40A6F;
	Mon,  2 Feb 2026 10:52:12 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id ED8C5402D8
 for <dev@dpdk.org>; Mon,  2 Feb 2026 10:52:10 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6126vXlB905652; Mon, 2 Feb 2026 01:52:06 -0800
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020133.outbound.protection.outlook.com [52.101.56.133])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c2q3q0c4b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 01:52:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eldfkDfNkQoftV0PASciN4tKnom/iD0yei2y1tYuDWNawRaOp+HyTHZ1mflRCQfgHeQu+6nm47laJeWGD2Pc6Of/hJ8bX+5695XGs3qT+0OYHSjy3dWjk8QxPL+LIDMh1HvlvoU+MoLXMcZlxZ+SqnqDT5SV5yEiNtJx4CZOPfNUX7Vnyi5O/XYTTuoWMuBBGzVgj5pFUk4B83mhVonff0QCJFlggZq4LyGThxqSlR88D6T+cPmb+pHi6zSAZR0TK0lx9Ijz7LEZCFFnrM5JYBumeC9vdFVOvmStDhInRbeG2/vR65xzO1z6si+KxRmoWxQ/8hFueletNvh2Knm1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+ryTUyHpQni9+YRlV8a4awzBvoHwmj20kbgmXa2QnU=;
 b=WCYOyy+QLsSa00ZDSC9R4qknowbg5wl+Fc2fviiZ2AECHgssvZOh6NIX/o7WyxClaHv6Gp72VTqUUgttbcgT+gcRmPmmYf/xPZFqOSwfBWP6HyU0qBHu15MSnsdgp9rz8QiAuu5q4k2TkpxYR7GBytAwZMkTndtY8B5oatS/4yZgkUMTBCyILmuYvi2Hi1mh4OBI7J4HYKkrrvNcj+q518neLERUfuJEeMV3tRuvdfOzqoLOa110UldmdJafL1McyIXEqA2KXRFlKsV9I82xhEr9igY+e1JFWhSY9aTdt6LDMWYmUb25AyI+6Ze53pbrZSZfIDG2/gct8w9jlx4/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+ryTUyHpQni9+YRlV8a4awzBvoHwmj20kbgmXa2QnU=;
 b=ezHKCKOL0VqESELA9s+e3XCNJGDSMg83ew30Ewqti2splRulEmnVUxtWgyG2IeJN4BaCIvmuxJSDbIOuFs3ei0Vflu9H2WrcipzI1KvGCvNN0nNhrkgVU3BD7pKuahTIf1jZRuI01efuhU1D50772f0JVdphExBBlkbndPTW4+4=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 MN2PR18MB3512.namprd18.prod.outlook.com (2603:10b6:208:26f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Mon, 2 Feb
 2026 09:52:04 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9587.010; Mon, 2 Feb 2026
 09:52:04 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
CC: Jerin Jacob <jerinj@marvell.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] Re: [RFC 1/2] config: add optimal burst size
 configuration
Thread-Topic: [EXTERNAL] Re: [RFC 1/2] config: add optimal burst size
 configuration
Thread-Index: AQHcXq4VsKPYWcJQ0Eu6wbp/mlvALLUEuLeAgAJczYCAaH/+4Q==
Date: Mon, 2 Feb 2026 09:52:03 +0000
Message-ID: <PH0PR18MB40867E7E8143DC087E43F42FDE9AA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
 <20251127140153.202a38dd@phoenix.local>
In-Reply-To: <20251127140153.202a38dd@phoenix.local>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|MN2PR18MB3512:EE_
x-ms-office365-filtering-correlation-id: d91a8b34-43d2-4efb-f022-08de6240b826
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7142099003|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?YlDlUJERNfH9Q/HkhJWMnujaJehNm/vJvfYOb0gJE8WezLvah3R3Rq/A9H?=
 =?iso-8859-1?Q?BBieIohqbOz0PkXJ8/h1uDBQd3qz6LAJYtpz6lx3hT5rdMWUSoM3U/xsiS?=
 =?iso-8859-1?Q?39zP/w50e5KvhSAPvtQcXP8v5yMI6NQI4Um/PstTTVfGNoNY6M3rxBOMtz?=
 =?iso-8859-1?Q?qNc4qQjDuW377TDb00MdXhPC2RNHjzkUIwAvbY16y5yS5xX0/FwOJGMfuu?=
 =?iso-8859-1?Q?7bdZ8pOykIaw3jKRpGPys2esI5mFlIIcV4qIiLS2LdGxe95ULLjNT3Sfel?=
 =?iso-8859-1?Q?6CrvSaOM2/D42hnxldk5z0aOe2gGdkiS5wYZSkXW6NPRo0rH+ogqSEHI0B?=
 =?iso-8859-1?Q?cD1j3W8G1bBQLrpqBwqf7rlSL262FtYOrYbbvigeTaJo+Gxc2WVwjPkUib?=
 =?iso-8859-1?Q?MCrDg19Eq+OnOk34ITSXjzevgCOqeBtlVKHIn19dIoPmamMYLJ1las+fYP?=
 =?iso-8859-1?Q?T5K8UssPjxFlBdMQj1UPqhGOSWVFXp3Lqq9+q8lp/CpdGiSsyxJh6ZAtnY?=
 =?iso-8859-1?Q?rfvu1IvJRsyHgmMKDWB07KePvC5kr3KgMWqKC5LTX2KZkkJG3QPGJ9JVRZ?=
 =?iso-8859-1?Q?ts8rxBKGM1W3wfm4TWH8HWgLQCK6cxmIqyNp0q+ibmJUGKci7WYqRRZmQ9?=
 =?iso-8859-1?Q?Tv3sV/FO9sMabSFcpSaaB1U3h3LYSN44aG0qT4MpijLOYx2PHvhCVhGfn7?=
 =?iso-8859-1?Q?NizhzUlkPuK4uYySg20Lv4mLvThHGpKi58DV3CeMkqCfh2BxVuNkLHBzcG?=
 =?iso-8859-1?Q?7YheR1y/Q2jUR+CaQ++36DsdfxqI1B/kkUQ72RAFFZlWFtNaOVSGJzOLar?=
 =?iso-8859-1?Q?rGowniiYDC6B/uGbq3aT9nqUuMZIp5rrorjPcHVEKKO7bcD2cr5slvfgTm?=
 =?iso-8859-1?Q?GqD+vvIexEfkXTDo0HgFDq10retNZcGFbxzYgGKwzLFsF4y3pcYO1MDk+D?=
 =?iso-8859-1?Q?W+4wlLuN9h3XxcXcxQghg6fpWfPXW409OlHmNdwdzS2V6j4+MPVlXsAqvu?=
 =?iso-8859-1?Q?tf5V8XzduXBvpCv3hwUpwYwCZHOimuZmpZu7KRpuE5SgEFuUMYq9NC5YN9?=
 =?iso-8859-1?Q?mAQQsNZB/vWC1TBzcmkttBtRurEtSu8uphOQdWsbwJtquwHbQ1QM2OJFvW?=
 =?iso-8859-1?Q?RxqIcbNlcef7cH7KFwcFMMed4unftGrY6T+CAca4rVjndvEdiIVEdBXeBL?=
 =?iso-8859-1?Q?enKLQAel6lkYCDrfWAlNdKMwHm+pHll7YxXXZH8Ky0gbe97pMEWJp4oIkM?=
 =?iso-8859-1?Q?619w5MWQ7bwBoknTbh08t9Kg+lKcEOAboej9hSC4MTB9hmVeqTjRqY5/FH?=
 =?iso-8859-1?Q?Y+9TTbSFCbJGprU1auMawQPotiuoADz7IVxWDe3zzd6CqkBvYhRHwqXUug?=
 =?iso-8859-1?Q?ZYcGJLkUZSN7cFej25BfnfkFS5d3EWB5re5eUK+is8o8stannji4ElEx7n?=
 =?iso-8859-1?Q?LneiDTgUpyTdaIJJZe5y0W+Ph3oGdXRVqCacqWZu86u+VFw7pfugAh8YgK?=
 =?iso-8859-1?Q?XYCQc9q3m2NFtRBaTuC9EhmxVKi7RC6GkNjvz0ZfWoS+cMMRaVZl08RMBN?=
 =?iso-8859-1?Q?yef+gxyjdbL3hSYniOyIroaJWqp1IsujoMx5k8g7YN4kwyiE29ELh1nIGe?=
 =?iso-8859-1?Q?nqPrM+NZOPoAi6S2NLcKxtwQPj1b36Q7rbkOYCPn0MqcpwV9macHenEcGH?=
 =?iso-8859-1?Q?1fpnr+13s1kOIixQmTY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X3bvB66im9Pr+Cvm1DLUgywIxbZHR3BHsnCiFvURp+UahPLwIeyfyU6MCL?=
 =?iso-8859-1?Q?sjvZ8GNM6/W6j7iIWzEjlRV4hcnCebIFDyAylA87k6eCnsrNT32fgBxNu7?=
 =?iso-8859-1?Q?C+mzTdT2gaTUNJtHqAYaefx4CLQJ5sz5wdz9XMPkDt5YnzNdmXMH7RscPy?=
 =?iso-8859-1?Q?5pjk3pzZMKUGOS2ScfpbPf1avplZvScB7P80fokPsNlrdoVvryFoAvTgkQ?=
 =?iso-8859-1?Q?qbebYm42NFRlATe3aSNGlRpBSZpJB2yoPN4ZcmU7+ZgBfBs2+xiqAPrxiY?=
 =?iso-8859-1?Q?kWwM1e7i2Z5XNmqzA0y0bmpqKX71VPGg7NQpwrzQIhaLUOz1y2J2inKqm0?=
 =?iso-8859-1?Q?YJTx/SNEzMOcFysPGwXQ7AepPZnVtLCol+Ii4bNz0k2QLcKIlMIdnPuFSF?=
 =?iso-8859-1?Q?P1VDT6Fg89dDAnaNr5rp3q1VhFVZawTpzGDhQxb1Ti2BaNFEKEHLHp9P2B?=
 =?iso-8859-1?Q?yNYUWZF7tCEQz6/9w0TIrb4QOIoQzAV6RsQ+YMDs/dorANYQ6GK3/SygbX?=
 =?iso-8859-1?Q?vZH/PR2/B9kFYsDAO2QTcDFBwzxs84biaF8mguUpfp+8z1TdUP77ctYNNW?=
 =?iso-8859-1?Q?ArUEVQCIleoPPrCVgo6L+ZwTNsBEUpi5mEunsAVdBapuG4C8g9HN3cF19a?=
 =?iso-8859-1?Q?irSmkuWrJkFQWEwr1TFE4NJuM5MPTPHGPFgitntxF/EzLTz+3ojpov+EPI?=
 =?iso-8859-1?Q?1si1oL7YPwKVptlYfJoLzM2CzwVQdtHtRsuPWxogebG4bnqBzAQ//c0nKG?=
 =?iso-8859-1?Q?ZCV4Lek+uc1nP5lkgORtM8SzIjwGtqEwfRf8w9TnZ9T6sqQiIRXtIGzYXL?=
 =?iso-8859-1?Q?HhUYYYX+RgK1coC0A4dybXnUgwwR8KI4EiKbPJwkKtARCwhIe9EqjkpsPA?=
 =?iso-8859-1?Q?n1jIId6qrRPCeJF6xxROZS6q53x9iLxkqhiMJxaK8BXIG5fWK/0B850Xrf?=
 =?iso-8859-1?Q?vb28UZcOGw583TDUlDuA9edpuHTELWbFR1RIrfE6PjLuMUAho67CrU7vC4?=
 =?iso-8859-1?Q?JV4yCIVO0/4WGQw4/cdt85EgLe7LRO9NCw7mNJ8v7cftq8H13iYrd1sw+y?=
 =?iso-8859-1?Q?zD4ABvoIBb70B9OOfne/JLa2cJI3o4pRPqWSKoRKUrNUzxXBEv2L+9oKsP?=
 =?iso-8859-1?Q?Bm8xjzPKNATdPBXdTUVLXQeNCxncEZjVZPegn0jx5SCya3Xftnv6blDH2Z?=
 =?iso-8859-1?Q?WUATkD4I9gYCD22bKEXNVEUrZvO2KeLLD9S5B3eSWRlKerzpxrJxv89Kl3?=
 =?iso-8859-1?Q?KTLup9Pr7uxBRW0E+CTfdeElIJUm7bmWaH/wdEDcw4kWq7AxiVkGnsNCBj?=
 =?iso-8859-1?Q?d5BW/mLzlBBRcNlOVHl/okmwmr6+B9lh+9bxJq4LZcQygRaZm3CuWiak4h?=
 =?iso-8859-1?Q?eSmkRfi8HZLQQQiQIoS2WJ8f+6pnDWGnIgFhe7qnobBcyQlTuqy7hhfeUN?=
 =?iso-8859-1?Q?JViv2hh4xR9Iwhx7jI1t00PZyzrWQ9svpUP7YJeTNj245d7kLWO4fLNclZ?=
 =?iso-8859-1?Q?ecYSebzjjQ4IEjXSsVMySF9lezWnBWndPnT4qH+R1Fabp6DLB7whPkp03A?=
 =?iso-8859-1?Q?ZNyLVsm99KkKICt7r814KolMYdUnaj66/I7shobkhMv6jNinp70f+DZ84H?=
 =?iso-8859-1?Q?7stPv4H6Ik5//cXKktRUEZTofHX7Emh5Z2P3u1pYYwDnYybxFU76IdCAYS?=
 =?iso-8859-1?Q?lLcV8lLEdBcEP8jMvZWWlPn83Ki6EzI01171lfJcmYY758kH64Wn3RXpLZ?=
 =?iso-8859-1?Q?GhqPnJX/0jJUqMbnWthYvuFYfN9N7IQZ8AiMBLo1Sgsb9bRe1Dsf+ZWgld?=
 =?iso-8859-1?Q?4Hk1n5EkYQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91a8b34-43d2-4efb-f022-08de6240b826
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 09:52:03.9883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAB+bDewKAvpBnQ95iPKr1jaF+soH8UOB8/gFNV+Y+XShxCJKEh2Rsq5FpHP9LYIdcCH4S1ampRZ4QU8dLFsM5bzB+XDRFnXksn93em7o2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3512
X-Authority-Analysis: v=2.4 cv=ZeoQ98VA c=1 sm=1 tr=0 ts=698073c6 cx=c_pps
 a=q7ul7JX4f8a5wKXmg0eXeg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=Mt5I5iToxYBJC2xeZpUA:9 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: SWDTjEHgj4xUkiikyfjo_cpsio0Q_S7j
X-Proofpoint-ORIG-GUID: SWDTjEHgj4xUkiikyfjo_cpsio0Q_S7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA4NCBTYWx0ZWRfX6HsPfSuTwdM9
 L4cPSXpK+oLl3MeLgjoxqHZpVci7TDkmvh1+4/kh7clPW1Miqb77scGj6QPHEkK1tkL23nIKBCx
 l/lHWtWvMqiT/dCRSrtNVlfOrWB01YWbgM0Cng6OlGUqkJ0RNxmIzKKODT4wHluL9DCaL5sKldY
 ast9jlfxioqjz3C4u6XqFi7xcJe32u6ivdZW85SjjFs0ecdb3C55M/Z2dM2Dnx0Dqi89B9la8Yk
 KoVs8Z59RpDz9ZaDKgjNB8mI63vJNeOt/cBb8Uv8DIP8mDOQ+grWuaOUPxH1qcewl9Ewx1K83dC
 XfRV+zFTKC/GI0tX7LE2oGJrm/OqAxwz9Vc7WJgtGwdT+1N51BGRE/ySE28oeBe5oqc743DPT7i
 0K/cKOIcqVr7eJrBICnSVzj+V45MnQw06NCqvynv9WqKjm27ulOFRPWpwDEbdy1FQ6l14e+5Kra
 AalYVdU7QXFQ/DR0TXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
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

>> > From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>> >=0A=
>> > Add RTE_OPTIMAL_BURST_SIZE to allow platforms to configure the=0A=
>> > optimal burst size.=0A=
>> >=0A=
>> > Set default value to 64 for soc_cn10k and 32 generally.=0A=
>> >=0A=
>> > Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>> > ---=0A=
>> > This improves performance by 5% on l2fwd, other examples showed=0A=
>> > negligible difference on CN10K.=0A=
>> >=0A=
>>=0A=
>> I support the concept of having a recommended mbuf burst size, targeting=
 the majority of generic applications.=0A=
>> Making it CPU dependent seems like a good choice.=0A=
>>=0A=
>> It should be named differently.=0A=
>> First of all, "optimal" depends on the use case; if targeting low latenc=
y, shorter bursts are better, so "OPTIMAL" should not be part of the name.=
=0A=
>> Second, I would guess that it only targets mbuf bursts, not also bursts =
of other operations (e.g. hash lookups), so "MBUF" should be part of the na=
me.=0A=
>>=0A=
>> Suggestion:=0A=
>> /* Recommended burst size for generic applications, striking a balance b=
etween throughput and latency. */=0A=
>> dpdk_conf.set('RTE_MBUF_BURST_SIZE_MAX' (or _DEFAULT), 64)=0A=
>>=0A=
>> <feature creep>=0A=
>> /* Recommended burst size for generic applications targeting low latency=
. */=0A=
>> dpdk_conf.set('RTE_MBUF_BURST_SIZE_MIN', 4)=0A=
>> </feature creep>=0A=
>>=0A=
>> Having these standardized will also allow libraries and drivers to optim=
ize for them, e.g. drivers should support bursts sizes all the way down to =
RTE_MBUF_BURST_SIZE_MIN, and can static_assert() that the RTE_MBUF_BURST_SI=
ZE_MIN is not lower than supported by the driver/hardware.=0A=
>>=0A=
>> <more feature creep>=0A=
>> rte_config.h could have "#define RTE_MBUF_BURST_SIZE RTE_MBUF_BURST_SIZE=
_MAX", for the application developer to change to RTE_MBUF_BURST_SIZE_MIN f=
or low latency applications.=0A=
>> This will let the libraries and drivers optimize for the specific burst =
size used by the application.=0A=
>> </more feature creep>=0A=
>>=0A=
>> <rambling>=0A=
>> Intuitively, I would assume that the optimal burst size essentially depe=
nds on the CPU's L1D cache size and the application's number of non-mbuf ca=
che lines accessed per burst.=0A=
>> Let's say a CPU core has 32 KiB cache (=3D 512 cache lines), and each bu=
rst touches 4 cache lines per packet:=0A=
>> 2 cache lines for the mbuf=0A=
>> 1 cache line for the packet data=0A=
>> 1 cache line per packet for some table lookup/forwarding entry=0A=
>>=0A=
>> Then the mbuf burst should be max 512/4 =3D 128.=0A=
>> But local variables also use memory during processing, so using a burst =
of 64 would leave room for that and some more.=0A=
>> </rambling>=0A=
>>=0A=
>> >  config/arm/meson.build | 1 +=0A=
>> >  config/meson.build     | 1 +=0A=
>> >  2 files changed, 2 insertions(+)=0A=
>> >=0A=
>> > diff --git a/config/arm/meson.build b/config/arm/meson.build=0A=
>> > index 523b0fc0ed50..fa64c07016b1 100644=0A=
>> > --- a/config/arm/meson.build=0A=
>> > +++ b/config/arm/meson.build=0A=
>> > @@ -481,6 +481,7 @@ soc_cn10k =3D {=0A=
>> >          ['RTE_MAX_LCORE', 24],=0A=
>> >          ['RTE_MAX_NUMA_NODES', 1],=0A=
>> >          ['RTE_MEMPOOL_ALIGN', 128],=0A=
>> > +        ['RTE_OPTIMAL_BURST_SIZE', 64],=0A=
>> >      ],=0A=
>> >      'part_number': '0xd49',=0A=
>> >      'extra_march_features': ['crypto'],=0A=
>> > diff --git a/config/meson.build b/config/meson.build=0A=
>> > index 0cb074ab95b7..95367ae88e2d 100644=0A=
>> > --- a/config/meson.build=0A=
>> > +++ b/config/meson.build=0A=
>> > @@ -386,6 +386,7 @@ if get_option('mbuf_refcnt_atomic')=0A=
>> >      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)=0A=
>> >  endif=0A=
>> >  dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))=
=0A=
>> > +dpdk_conf.set('RTE_OPTIMAL_BURST_SIZE', 32)=0A=
>> >=0A=
>> >  compile_time_cpuflags =3D []=0A=
>> >  subdir(arch_subdir)=0A=
>> > --=0A=
>> > 2.50.1 (Apple Git-155)=0A=
>=0A=
>I understand the motivation, and it make sense for a pure embedded system.=
=0A=
>But then again on an embedded system the application can just set its burs=
t size;=0A=
>this config option only impacts performance of testpmd and examples. And t=
he=0A=
>performance of testpmd is mostly irrelevant what matters is the real appli=
cation.=0A=
>=0A=
=0A=
True, but generally customer engagements start with benchmarking testpmd/l3=
fwd etc.=0A=
berfore moving to custom apps.=0A=
So, having better performance numbers helps.=0A=
=0A=
>Making it a DPDK config option is a problem for DPDK build in distros.=0A=
>The optimal burst size would be driver dependent etc.=0A=
>=0A=
=0A=
Since we are not modifying the current default burst size (32) it shouldn't=
 be a problem and=0A=
can even benifit SoCs.=0A=
=0A=
>Perhaps better off in the existing rx / tx descriptor hints.=0A=
>Most of those device configs really need to be relooked at=0A=
>since they were inherited from how old Intel drivers worked.=0A=
