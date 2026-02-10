Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771EEA8113
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FC9C4065B;
	Tue, 10 Feb 2026 14:17:41 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 53B89400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:17:39 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619NTHvn2971954 for <dev@dpdk.org>; Tue, 10 Feb 2026 05:17:38 -0800
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020105.outbound.protection.outlook.com
 [40.93.198.105])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9q9fkb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 10 Feb 2026 05:17:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/5d8oRB3RfSSDT93omcqNiWuie13CP5UJIAr21b6phoQvsWUquED1dPMEzDJ+NcP4+bu8XRD7SmRAupv+ueif0bhfyftp7nx4pLuRXl+kbWvR/4NQoeguJhEVpB5+20sxAKp9bk2NNrSSSoQs0I96EixuiCKjGXmWZALWSRqybe2ZsUiBW0cispp8Re5QhKmWTDGj5aybHFmXHQ2LVQrbxoZlz5FObT6WUW6IeIhkLqBgNkmzS9yAAg39im0szWdl78xzhGupkzLOsHA+TqD1L+GxLdhSyj61uqeUhaZ1UBqJywkKRGEuvDz7A9fjaBXUcP29cu5MACq1mpw+w1og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ0I+8hx6e0TQDntVEGwmBSJLvYhwO9TVhE0ZDLfclw=;
 b=P7MTyWHITfV7y+crG6CQSgPulx/LftG0DdvLpq8ni4kq5fDarDOqQtKSqZSUsYyJP7V/hmclfJeE23Bg+o2VPbUZNkifCM52qL4CCpzAtKubsFw23Q/p+OmhPlBnIVqqyfRZvdam/JgXmhxgxJ5lPfUA36E0WKUjZbPikFregMwSdfrJJC9bNgwKKW7v9yYfNMGxqRhnY7/0MokVtLL7LLRk/qEl2Vbl48iXtpitoc0VD0mf4rt9j8zu6khqIiwyOgPRIIqFcrzOW8Csu+iBZLc5IHFXmN9fDbxGzrUeeGfYt4lFILLZ2+XljvniBKkv2TSx2bfxNPDMDqfd6k7e6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ0I+8hx6e0TQDntVEGwmBSJLvYhwO9TVhE0ZDLfclw=;
 b=N6BR/2FLxRlm2NwCfMArARfOqHy3c7IDkMucnGGf5DUKBxSvlxZxogT5JE8LqCkIrWq3+sD4ackRbSrpMkeMqw/57soRoszPG6tMMgWeVdag9jkwockocacN46lv0+RjvZFF4Ld00C990wyd9usxX0oP2k5JV4k9cmiejV/ax9E=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH3PR18MB5617.namprd18.prod.outlook.com (2603:10b6:610:1a0::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8; Tue, 10 Feb 2026 13:17:32 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:17:32 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Tejasree Kondoj <ktejasree@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, Nithinsen Kaithakadan
 <nkaithakadan@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 0/2] align crypto CPTR as per platform
Thread-Topic: [PATCH 0/2] align crypto CPTR as per platform
Thread-Index: AQHcg747MbW92zoYzkyK/BUekHBSkLV8F7nQ
Date: Tue, 10 Feb 2026 13:17:32 +0000
Message-ID: <CO6PR18MB4484DC1437A27E7F3EDC153CD862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260112122309.2448535-1-ktejasree@marvell.com>
In-Reply-To: <20260112122309.2448535-1-ktejasree@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH3PR18MB5617:EE_
x-ms-office365-filtering-correlation-id: 63b4e8d1-e273-4292-7c26-08de68a6bfde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kLZJOonsQvIFFe/YMaHQIhBHcv3AlO28D3Ymuwyolzvpzt+Z9lFmeGg8u/xn?=
 =?us-ascii?Q?EpCnw9eBKDZIzGw9NEuFmlAPp/JlS8+LqXE2zSKtgjsL3rfLsFA5pkEfRays?=
 =?us-ascii?Q?5RZfmjuqVuEsiBvV72Yx26mrOhIYrqFmIEnusGvTAQC20UjoOJJkYRfjwtpp?=
 =?us-ascii?Q?1CDnzPEo0SAfg3P6+r4Kc/7szljaLYTHG5w5LmxU69jokNQ4HEJAt4H9b6jW?=
 =?us-ascii?Q?T/37sgvQMdPQiWQCm/HxkFj+TOGvZz+yALSIz60E4N2faqdYxrwYi93u9WdW?=
 =?us-ascii?Q?Rlkp/oe8ReO59fd7HyQhmowP5enNooXWUaq7THl+2mhdN+VKV7WZyPc7KtNz?=
 =?us-ascii?Q?jsu27eVqoWLQH1+PfhBrLLJ9NABW6GtcQvdM41XgKeuO2XBo5d+XBMwbKYCL?=
 =?us-ascii?Q?aRSmf/vOKftWoo5xbbCWlEnr5J+4VlewWHT41h1PcVBt7Yv5k3tOkqkhRlXW?=
 =?us-ascii?Q?xXb2V0ZtoYWL4QVPT+v4J/xlzBg3VJQZ8C+ynEEeS4NpNPqJwKI1lBgs9UnZ?=
 =?us-ascii?Q?WV5KaRYQQzUllVYALsKTKtCijrxUSjfYCDdd+YmIW28BbZjF5oVrR+urDxiX?=
 =?us-ascii?Q?rNKJV0djQ54Seht4vtioCb9+TDpEAR8RCu++XuztlMiPId8ybpgiOPaH1i6f?=
 =?us-ascii?Q?exqb/jelPiLIH19UOfpppmbtCLhyQ1puKf/6IThdhMB5ias9LYiuaR6cGTlx?=
 =?us-ascii?Q?OYUhgXfkDww40QW43xN1Eneytng00AStoCsNxm9WYsQHQtbYv2ep2oebCn+f?=
 =?us-ascii?Q?ZEJwDAe1UW7defkKNXY42ll5fi1jnNLevxOyqSaKR6Cz2mkIuPqb7F/Y0Smw?=
 =?us-ascii?Q?lu/EfbWLmx7WGw6pQZMdSNp9hdbO2/03Z4Kjq1KHlTBDg6s+wVHiovjNIkl0?=
 =?us-ascii?Q?LGKid8foFiMnwx/w6jloRxsfzpz5uPL/LCYn2Wm6hvtAkJbywcf7VAtJCQa3?=
 =?us-ascii?Q?sW0aAltwHY1ma0ZLyDOgiA3wACc+BLKl4gGcvwt81aM/Z68RlQ+nZ1ftsx+K?=
 =?us-ascii?Q?Jj7fSKOAWKKZTixsWvOA5vuQ0oRYJSyWUx8sTY+SS3/x904VJAwwmGf1kSBs?=
 =?us-ascii?Q?bkLt3mVFvtFgp2+0i3n1AdHn64RoQfi1CUiFNWwd4xNWhybqzOXq3MVJ9ZhQ?=
 =?us-ascii?Q?qay7nv5X09ua6OgxvmPl9ybjQfzkAubU4+dp4qfQIgwfpwhrCneGEnQGH9cT?=
 =?us-ascii?Q?espNTzEucNK8NnvL5W65uxM77niB0lNe1G4abSNG8uiugVbmwBv7wRu3MD0D?=
 =?us-ascii?Q?4Wn0ctHquhe7etiyH6g6bSSm2yrsV5Kka8eXNL6KnoBMaim+xyZoYz5FxwQx?=
 =?us-ascii?Q?8BpgrwWjDE3PK6vPt+QQag8ZSqoxbxFN4fHUXwAhTQ1IudM8rJ5GPByxlWiG?=
 =?us-ascii?Q?bDwZrW3kJ+ZiM0mffLRc4Tbcz0GzCPOLMJgMA3K+Kzstv/YY/1s7lkHmfGD+?=
 =?us-ascii?Q?vOnaOZG0Bk6XZXbG24/aDmfBQLG6SYNHoUyLazSd+Eq/ftawRoVrKvgBVI2A?=
 =?us-ascii?Q?M2Tdd3WJLq8YjtVZ3KANOijJDJjb+ypns9xfL5EhkJH0lhUzr9XqyEGtk7H5?=
 =?us-ascii?Q?AHnRAisO0S20qLSI0gK3I9dS2l2bRhCZTnEBhYbx1Qtn9fC7xSVWfjhAGgdw?=
 =?us-ascii?Q?Cq+plwR/pQuJzad+y2qdBT8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eHQXSAZZ8sz4KS6pbSJYeCVo65mGlOo+/noUD1HBkEuUJq4H0wWR8EY0mqoW?=
 =?us-ascii?Q?knx4MIab+wbTXPNHtgWGFudnFNrdAeLoIzyOXhcdoQHS95BooEsxGNZmCxr2?=
 =?us-ascii?Q?9xDDyLgAhfs1aQMLJZMbuJtuiiMJCDSdw41tOoBx4ycipE1e18ZLq7UVBiAd?=
 =?us-ascii?Q?MVjWP9sjZCt41sTpmN+WNvPL68UaZ89cPsowIo7U5c2hFPqipL+AkezU1IMg?=
 =?us-ascii?Q?3kf8QMNzyxrZ62/q/0hWZM1yO50phXAjmXGmt7+GaCnCecgFm7412zBPJdRt?=
 =?us-ascii?Q?GdtmHH1TmlxnXsPBYh2gDeewTshYawYwqzcim4pA9OjhSio8qm+2R2Rl+aO+?=
 =?us-ascii?Q?c87f1eRcytjeGBwWQHa+bjv9XZK4vb1tnHXMlsN0JY/P+NvTz6lg4McZivPw?=
 =?us-ascii?Q?WQUwWZ3UI/Mi7e4D0n3f2j4rrOtGcYhbmmK/VhdEDjaOIacZARAkN92QCIrj?=
 =?us-ascii?Q?1h+bj8aWG6CtLoM82SkPAtYDRxAHrYk4tMY8WkIK+yxHJaaii28dY8q+vpDs?=
 =?us-ascii?Q?9wWGWbPsSei2b1lbeDvf0Hz4+PXJ57oinAP0q57N51nRxaIBaKjOX8gGkGTz?=
 =?us-ascii?Q?9YnjwD1RqIOAFRwBZb1dLi48tA3+X5qFeE8SQ1mGNTRs9xvcgJ7WA9Ckeh1L?=
 =?us-ascii?Q?Kq6Y8dOd9OMPUJbU13zF9cJCm4GZvUIjyeldYrED9CeFXZu341YS9tO0IeqM?=
 =?us-ascii?Q?IYjbEbamaf1spZ4t+TkbkuyXL7XpcuStZLXs/GMvG3SMJkHJ84tujy1XqEUr?=
 =?us-ascii?Q?63OoYX5j7LSyF87hBjCCLL+exc5hzu+5AGO42erXAF6JYeQvlQZehz/Nj5wC?=
 =?us-ascii?Q?GuJcY8EO1UXR6axa5IGkw+KPTJxPUjbKtp6eB8PNq+bKPDu+SyuCrhhH/H1q?=
 =?us-ascii?Q?vRHBUBTu1CriLm4hSdbBeLl2rBqiyG4T80sHQdf7MbpkX+4z8Q3p1KOdSszJ?=
 =?us-ascii?Q?4dL6uamYRnKoT6eIi3aYkkREO7wrkhYWveFXkji6QMff94TEgxr7QRq/DP41?=
 =?us-ascii?Q?cEQCXhb4+p/+SpKFIQqY2dwRfNZgN8HWl8rGppR545GPSatITydm3w5l5j7x?=
 =?us-ascii?Q?bVVzTSS915gsp0UGW9L5wNdMSrG9BGEr8doaF04NTo4PpUcwfWCQbN/A/sXG?=
 =?us-ascii?Q?Qf9UwrY3MCY0YOcziWsKz5dKXN0HWd6GyA5rAq+vGD79lb6XjgujIRvl+B+d?=
 =?us-ascii?Q?qbTRHrCHbmx3NTEWKVdXo5fLA+B1eqNunvU6gSHT3s2qS3cef/0Vp5+sZ3nG?=
 =?us-ascii?Q?c/OUiLWpNfvkzN0ovzzytXS1w/5B0J7ol82JPmQuO5gez8LvuvaGVOsXJZk+?=
 =?us-ascii?Q?KSDoAyDB4lZwEAApXxjwvNGRnVjVVa78k9BPqm59WCX9HSHEG+phKJA6l5Wj?=
 =?us-ascii?Q?UfGHgFmOscOtt9hMs6gnL3ATdrkpFr8g0eT31jv+uPX/tX4NuHUnxCN/zBNE?=
 =?us-ascii?Q?gUvO1mvjIVtZcRV9w+KDNd//5SO0aDqq1EE1frJF6YrUB8bJFCLsltR9jfnm?=
 =?us-ascii?Q?iSCMju3E2gemfHIyCMtn490MN0zAg37Gh0VzsUdvfCyVlOGuHVyuVebyFlJY?=
 =?us-ascii?Q?0G87hs6wbhryhNycr2SM8K6PP6sFL8pfwErovmB/6zoTyzDadPzf6dGJdpzp?=
 =?us-ascii?Q?9fdZ10ddkOROykk42x/yrLbVVfUP9JI8/TaHyeT7ANfc0+Zh0ghyEq4w9UvA?=
 =?us-ascii?Q?lMnE9FurQR2D6WeniyY+XwZxNtGK0KcWeqhLFXb04N63DLrm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4e8d1-e273-4292-7c26-08de68a6bfde
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 13:17:32.5780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjVeDJ7bPgmvYNvhLFZ3FrUSPryWiQxKcPlXeETfAPV3UGct6UcELZta3iw6who/XTETgm5cR9VEiatiGgjuCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5617
X-Authority-Analysis: v=2.4 cv=a/g9NESF c=1 sm=1 tr=0 ts=698b2ff2 cx=c_pps
 a=URhychnWC9B1Vwa060GvLQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=L3BmNTkYM1w_gBknlysA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMSBTYWx0ZWRfX2nsMkCs4Y3Df
 NrTk5VwV5BZjUKQVPa7BKwbN7/TqGJOOIy1LfHu/ukN6ZTsM2ggHnqSrSrvFBdjfPT/4t+4IW5G
 FnLe1QXnEnp5tiuR+p3Lw/CAxRWlmqr3PISRktN1T8SYwrzHUUG0CrOr2hmPJwaJAE9fBk7nHta
 73oXVf9ZPAcbLORoN8k9yysO+jyZ8TCDK2vgRL4fqctv6RycG9/gCmmjeoCF4DzbUM44MripcUo
 15wzhVmn2H/Cl8pTbveeqn27rHxVC6CQcXglVXdUTpqlGxJE+AFs68mgmr52apoHzvr7Pb33vdV
 mVSg0zo4GBwt+sct8ygU9EK7oJSqrh0FkFE7QcgslXdsWclBhptahrA6grqGWe3TJxGmm43uZ9q
 2DkYldvIaQkveES2e633aP4sleC0EeJDbeVdCyb/ptbYTNywGVRbd2+syTNon/sKRGiPw+rV2SN
 QLq0l/KeyXS4YPvI23Q==
X-Proofpoint-GUID: S8lqf7nmlWOthrQl0f39l1oyHqgoh4Hq
X-Proofpoint-ORIG-GUID: S8lqf7nmlWOthrQl0f39l1oyHqgoh4Hq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
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



> -----Original Message-----
> From: Tejasree Kondoj <ktejasree@marvell.com>
> Sent: Monday, January 12, 2026 5:53 PM
> To: Akhil Goyal <gakhil@marvell.com>
> Cc: Anoob Joseph <anoobj@marvell.com>; Nithinsen Kaithakadan
> <nkaithakadan@marvell.com>; dev@dpdk.org
> Subject: [PATCH 0/2] align crypto CPTR as per platform
>=20
> Aligning CPTR as per HW requirements for
> cnxk crypto PMD.
>=20
> Nithinsen Kaithakadan (1):
>   common/cnxk: set CPT cache line size per platform
>=20
> Tejasree Kondoj (1):
>   crypto/cnxk: align TLS CPTR to 256B
>=20
>  drivers/common/cnxk/roc_cpt.c       |  4 +--
>  drivers/common/cnxk/roc_cpt.h       |  5 +++
>  drivers/crypto/cnxk/cn20k_tls.c     | 47 +++++++++++++++++++++++------
>  drivers/crypto/cnxk/cn20k_tls.h     | 15 ++++++---
>  drivers/crypto/cnxk/cn20k_tls_ops.h |  6 +++-
>  5 files changed, 60 insertions(+), 17 deletions(-)
>=20
Series applied to dpdk-next-crypto

