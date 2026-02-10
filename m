Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D83EA8114
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:23:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E17AC4066E;
	Tue, 10 Feb 2026 14:23:40 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6E340400D6;
 Tue, 10 Feb 2026 14:23:39 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619NTALF2971901; Tue, 10 Feb 2026 05:23:38 -0800
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022093.outbound.protection.outlook.com [52.101.43.93])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9q9g0x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 05:23:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBANnE2Jq6cz+VLm1VjYIo8vKkNApumZvQgKLNqI5bWqlxPSSLHZkhqMYhevTIomGPrXzWtwe7AGFwhYO6OhagK8L7CB6uM7rOWIAnYv3KaFOZyuoZwYdpBXX3j+wWNYsvJ29fJEyO9evJ8tG7m+xfglxfd4ol47miiucdTKyPZcJzgf91jvW0sokrXc/X8YiWFxTtIinu7dp8LUY+EJbW5VMSR2B4M28JAzJs/RExtGE0sm8suqBWFbKJ7s6kWob27MvgeIhTsZoZjGuvmZB0AGuP1LfGJ2d42+OK0qMf2t1M8Dh4GhnG1Fkkl8vHAOTLOMmNtlV+Uv06m/2LuwiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II7vneJxQYE0XssjfkyuJgkr6oXgdUTPRb1mmIOvpKc=;
 b=jCa4MM4tvOAH3VfKk6nC4f7TJIWDmJX2tJ+XKSbtYVPXQiaUIYscUlkhr6TN19ow5tp3gAQmxWdNrv9TOix6WXm8VKHZEAA+R27skbFtxeEBYXKu6RKcphlVvBF5H+FEP+uHYNmpH4p+vLvcKJGiPiabNAGgurOaUgo8hhNW2ErJPOJ2DIMeFpcEzOqsZ45xmBjbsmCD90fY2vNR/YKzkU2ihhxhBl5WxU/XTUqtV37EWCzb1a1awITB8chong6XS4JmKpkzIbqmIvwBU6aCJbpGdzztVWJ5sayFtymrvffim4LxBw6zzPwZ3XKDEnim10VIscWHep6afVG7mMehYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II7vneJxQYE0XssjfkyuJgkr6oXgdUTPRb1mmIOvpKc=;
 b=JRjO/VDdALcO90kqY5z/RzCdQGjGuq418OWkEsHtnn8LzAeIJ7g9my9rSOLLY/kBVo4dCY/SkFTXDKM2OZ2099yNnTfjwkuSYCN4GAwAW3O9ZvFWBw1hO5aAqnwRKDdjjEiMYV9sljpDVE4GBXFZB3Dvu2sBmgzzn2XmZqxVoOo=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 CH0PR18MB5461.namprd18.prod.outlook.com (2603:10b6:610:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 13:23:36 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:23:36 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>,
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] test/crypto: fix rsa sign data length
Thread-Topic: [PATCH] test/crypto: fix rsa sign data length
Thread-Index: AQHcjFb+Bt6BTDD6oUS2z97vVzA/2LV8CBeg
Date: Tue, 10 Feb 2026 13:23:36 +0000
Message-ID: <CO6PR18MB44845AABF95E09D5E9472971D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260123105650.3764031-1-nkaithakadan@marvell.com>
In-Reply-To: <20260123105650.3764031-1-nkaithakadan@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|CH0PR18MB5461:EE_
x-ms-office365-filtering-correlation-id: d4830f2e-5b0d-4a57-80ce-08de68a798ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?QqEZuEDmVeFZLs19StqqzC0fUDgB/aymo/d354uytuRCERu/buoFdc5mGk9N?=
 =?us-ascii?Q?KjEzXochDKeJgXj81PDx+CJi3nP+FzZUysCgUxSkTAR9SOoXEvQgl5oU8tbj?=
 =?us-ascii?Q?MxC5WeZ2Lr+XR4i/p1leFT/ZhzPf3sgp+f6TG4ucBePJolzHRLo8IdDdeujH?=
 =?us-ascii?Q?kkx3xeNZvTEle3SArV4W8FDFW276xl6EnDVqepZexKfoR4pPUkLuRx4L9xpq?=
 =?us-ascii?Q?BVtDKIepVUINBbFrLt/a2paDS/rOSK0aKZrETs1KSkDzC2+bY9j7TIO4pz46?=
 =?us-ascii?Q?muXv/6SSpPs3zCgKwevjSmu7wGhVJyl+wlJoNS9NeyTZXiADos7Cu1ppEHZX?=
 =?us-ascii?Q?5cBaCYvgq/MSp86Qn/UFuIMQKC3D3NEh2lbCcLEL6lasRm+7mbAkrvxD4faU?=
 =?us-ascii?Q?te9r+BRt47hjavu0aCns9LK8ie1Ioujoi01TGc71/Lw3isn1U3UuTfbuCLH9?=
 =?us-ascii?Q?ule4k4q+GGpQfa63ovEWiTBNKM8IFalNKDjRsM0S4wlQ8yFm0bCxgJHzszGQ?=
 =?us-ascii?Q?slg6umz4p9qY8XF3N6kRkwMCDRm0xmr/hrZ7pyaHjKJaSgayMfnWsx7YySg5?=
 =?us-ascii?Q?6EZBIzKzHrwFfupEGhf3rUgsvaZqBztffPg2uCKvI4BHz5FSjJYE9nk633GE?=
 =?us-ascii?Q?DfmFpaQfUNoinw3SE6U5M+RGbYaoF/lKt8e53JHYLVHmXsC49r1L6Oot32CM?=
 =?us-ascii?Q?LeewJam2zwGKVbCWMfYJjxWLEzFVmTjkRn351Fb0JhlGP8n5kWD8xGqLWx9H?=
 =?us-ascii?Q?62rSADRj1K315mZsmKbR/Un/8yWvMwORphAnHF91Ss2nt4fmJTqVOvFBuGZN?=
 =?us-ascii?Q?LaCvqFsYxTuJkyadSZCpO5bW5Te9ltp0cEe5zo97gD+7z9Dp05PRw19lggBO?=
 =?us-ascii?Q?DyF72z6pWylie6TMVZVT+p1kXN47R9F6CXg8oZ9NzjsQBnqNp/3XQwqrTUlc?=
 =?us-ascii?Q?CCtlCpoZB+bVvYORRfBYJjUIx2BBi/1MXyEaEpR0UOkvkyGcMqxvF8mbERc1?=
 =?us-ascii?Q?hb1gjLDLRWwPo9lz9CPRk5Dazu8SLnj+GBeDPw9qcLsJm1d52qgtshR29uMT?=
 =?us-ascii?Q?AQagA46fVqvbNbDputBpisvrqjK347ew1fUMocFQgieRUfjpWgKZGrsMgoOv?=
 =?us-ascii?Q?zOzvuQcy7Pm3HI+mOel2rdjs+O9ezGBNim6pGPM7bU5IqCL7Yd6eCgli/s9a?=
 =?us-ascii?Q?+ZwCW2ZCr14QZ5mtzgx4BROWO/P2BcF0zjkZ34/dLiu0rN8ZpebzXQvCr6hn?=
 =?us-ascii?Q?RdW8qbubmg/JbELy56dN+qs2NBIP4W6Q0q3Huj1NjCPJYrlu4hp5URwA1882?=
 =?us-ascii?Q?LoTYlkwj/BYN/0mbOEPYbCm5iWhBlEvdoqzQO8e85NgpkfMGMWbL0ETaAnPE?=
 =?us-ascii?Q?LLSVhwtKY4qn2yvI5I7txwmfkOsL/qwK39d2zb0YyCg11fkFRuWM/pWFlpW3?=
 =?us-ascii?Q?NmEPzJVyDxQh6eIKVRTi8eVZrfp/BKm7pjJp/H7EOFIOjZB+dz1dC8zLJKtv?=
 =?us-ascii?Q?uI1A6Yo59kme/dP7PJVT707IJ7+yWSAbygGph/Z7SgKu5S44oW2+HPEShYM0?=
 =?us-ascii?Q?DWqg1XMib59btrZNe7tN8WzO3GPZPGXDATpPH8LczvSnPPSL9kOhB7PKucvl?=
 =?us-ascii?Q?z1YpLekfljI12zG3gdA7YCE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SHzXCzHCnah7fXEtuDIp7oQ3/0fCQ7N7aGGfGVs5lGFr9p2reVZjwP/6YyzA?=
 =?us-ascii?Q?5QmrQ3tI0bFwmIck4N48BiuTZGf2ry7qATs262D9tJbfjVopwKEO9Lx2P+Do?=
 =?us-ascii?Q?uBhafKffvgSLAE7z1Y6JiE7EC9zShYBx5vgNWGjg9p13gPKFPiTChnFJRFHY?=
 =?us-ascii?Q?EWh+gAfKNM3I2lp0N0BWg8NCVX1dHHOOUaYyhv4vPMrCyZlWht+8z/dgVf4P?=
 =?us-ascii?Q?af9GI9prp+FPFby+Nu4I0AFgYnpuS+CP30xJAb9byNd9aqhzk7h8ZLLqC3lp?=
 =?us-ascii?Q?y1caoN0U8vRUEuGRwPookn8R/PHDFwBmJCZ9XIDFpXhxXq0pQoYWQLDGNY3K?=
 =?us-ascii?Q?rn4fRYLB2suYqDNcLSY3iDsnpVk/DWKpplK9BSjKOT4/kd1h6tu38qucmPzc?=
 =?us-ascii?Q?NjwDzzBwuDCxL3M9C59B7UrrIssyr7t8UzAN0iY8VPIcbEE7R+3Aw5IZTuXu?=
 =?us-ascii?Q?3GLpANdAQb6/R6HG5lW+D9aI/oQ3ABkzHUUV/qaNdtriJ3FZuFaq32UR3445?=
 =?us-ascii?Q?k79uuT2FfYhsd1Kt/UVbsVtdDZ9I+SNo949m0AgQzqddso12ePNzcPxTOa/e?=
 =?us-ascii?Q?AfT5S38eXwwwHq/vpIjyU2WcxbHGitqR8FVcEvYiCMC/u9yoGVw1JPJhv7Di?=
 =?us-ascii?Q?5q/2xNf0+fdrlr+LCGIPoIEkCrlAQU7O5ZMSugo2FkTG8V13wQkG8WabLX7I?=
 =?us-ascii?Q?BhAakiTVBjJpQUMHq8FcHJhHzbO6vqqd0ROx/GVklqP0vQmvWOhWcIVOiFJb?=
 =?us-ascii?Q?ffwPfOjSPOLXv8v7wxwhzA9FrgcFULTaEC9jTUepMxpCtGfu4SMEqeByyKL2?=
 =?us-ascii?Q?amqk2whg5vtjzxgmD4ZggFRmtB/Bt0rfyc1NtbJZB4oW3rNptxgRHLgTOKZK?=
 =?us-ascii?Q?MZyMNcam1G2hj/jAWPKG1ouwcSyzPGxw25IBfzPzV3j856bgLzAH42l+JRDs?=
 =?us-ascii?Q?/9ktWwDh399bo3CRK1TXvJAUeQOGsIXWvyiS65DewCELGLML88WP6TPBYxUT?=
 =?us-ascii?Q?NiKeJBLDr8p/p1tSWF9ATQKJLr4xglG4DwnRDDVUuty+fCvOfH9Nv90Qk/sP?=
 =?us-ascii?Q?alw00OOxVPLDA7FX9xrym/TWDH1u6BjedaaCG6b20zZ+C/CRN1Fwl9WXrUBx?=
 =?us-ascii?Q?lsP/3Qx+rr0w1LO+gbbFKslqffHSPV2R3oPaNjJvVQjRvQmrn7Y4eVB+skLy?=
 =?us-ascii?Q?QHvjKPM92TC2sggFFjT8LlRLt1JLR819E9Yf+wYO9pw2CirLTrpbdzvwFGS6?=
 =?us-ascii?Q?+T/BoXLtz7kAg/gJ/wGrYAcrBgZq2ntGVcw+rU/ie42hrp6LEkB5Ng0yNBpB?=
 =?us-ascii?Q?57KSxUkfCiWwbtvP2HIh0EIJ5M18fSyW5BozGRw0jLkqkuDA04g4SFfmF5A3?=
 =?us-ascii?Q?yjlAezKQ3odDyMFflq9zQUH+wu1YsITdecm/v1wy5VR5KHN8KJIymBWRscji?=
 =?us-ascii?Q?WkCUjxGE9fbjTOcO/wtM5o6HSU85MJdE8aSS9XuGRQ6wU9k1CIXJEQRbh41u?=
 =?us-ascii?Q?JLPWbuhwknqq9Ehs1xlryr9ec+Ky4CXn09g6/Fc6FINdSgAE5wTsfHQIxODK?=
 =?us-ascii?Q?FPscDlESeHK4xCthjhdkZofW/wCrGvhmFGpqXOMZ7ag/jW98wDLAUUDBtAJt?=
 =?us-ascii?Q?xuTcICG8Q/cu/gcuB0PmfylSnxFFehKhQwsnj1TzKZ1eyF7b3qowW8pIKsRh?=
 =?us-ascii?Q?kCImnyPWyTpYS3NO/ZWJ9bJgscsn3KldbV9tSNxz6FyuXd+t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4830f2e-5b0d-4a57-80ce-08de68a798ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 13:23:36.4835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qWnKMutj+cyJhoI8KU17E5ofr/OQ1T+1qT7jNbIwGIgGwvrJo4oNVbwFQC7gy8IiVkjUmXIdtfzGLeUQgbFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB5461
X-Authority-Analysis: v=2.4 cv=a/g9NESF c=1 sm=1 tr=0 ts=698b315a cx=c_pps
 a=+CKpLqsC5QamL8vULJ+FWg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8
 a=M5GUcnROAAAA:8 a=cDJrVQsr7XqyOF9N-0UA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMyBTYWx0ZWRfX70iwUrPL477K
 yMg3+rkwrH5M7K7LiErVXVuVQ2/vg9cvI9VYcWAdIPJdyzPiFx2OK58BLh9aV8NdvDepfRhxA5K
 A2xDN6BuWaKT3o2JoxIuBsL5ReM/HjPlmodj/xinBzN1X/Z0pBHjOFXx7j8noggZp+lttVUthiG
 z3X0kgPOgdrqIXlIemEL8sl9xEpej1E8aFI3sJJYpuSdhmYw7UO/uHRQAvAe3NsKVoov8NFEOkD
 SyK0gT/bZ7Z4ti6D9bnvmy5IDAY0uviA80Xihw6rBp4pCL4PrO3Xswx4PsVuyFuLG5IMhxuCDz2
 tE8ojCM/B4u9EPQ18JeCj6ksriXrjngIQbENvD7QxVmCiowoKM7w5r4/e0qZrDU9mg+LdEchl1n
 /B+PVbvY1NuGR1YaCKfJIJi5NFWEzpEUMGUziKEl4E/G+vQ2zKwJqiS34+5QzbqGh1127Q/VONy
 AOefzBU0biSanO0dmwQ==
X-Proofpoint-GUID: PdsjQfCIsT29vZ35H-VaN7QLl8O6XC50
X-Proofpoint-ORIG-GUID: PdsjQfCIsT29vZ35H-VaN7QLl8O6XC50
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

> Subject: [PATCH] test/crypto: fix rsa sign data length
>=20
> This patch fixes RSA sign data length assignment to correct value.
> The length was previously altered during a test scenario and is
> now restored to the proper value.
>=20
> Fixes: 9682e8246ae2 ("test/crypto: add negative case for RSA verification=
")
Cc: stable@dpdk.org

>=20
> Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
Acked-by: Akhil Goyal <gakhil@marvell.com>
