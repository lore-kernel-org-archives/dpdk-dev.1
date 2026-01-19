Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054CC98315
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 05:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EC244025D;
	Mon, 19 Jan 2026 06:21:08 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 28D544025A
 for <dev@dpdk.org>; Mon, 19 Jan 2026 06:21:06 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60INrRB23145618; Sun, 18 Jan 2026 21:21:06 -0800
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023087.outbound.protection.outlook.com
 [40.93.201.87])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4br8nnam92-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 18 Jan 2026 21:21:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tu5UrLvOMctIwA8keZnbzcj3e0sPVyJo05guXg1RgmC4i3VHmpbxz25rc4KL2CQfATAbsO6AK/FX6IoYXAjDW7JG+WilhjO8wbP16JOMLdfLGnnF0Ki4z3B9WRjIUTl5fJYM62N/HtYuZf1LZNINut+cf6LZbHO7xTe11nIdTDa8Ud/ZZwNXF3dO13BMKKYKpsdQn7ZIjR6s2NmdMpYYoFnuehkTNbm4k2x4O+07Hd4uLlG0z1m4PYUPhw1eMZOHHJhSs6CWSVDWaKT0736vfIrrhVRsj9/3efujx9oVXMCUrXusc/qKEf2R62Hxy0hoI52ZQd4ICrVC5WDZ1ehMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXDxf6OPGwT3w2M3Imso1paJlt5BtFJl0742QXhR6I8=;
 b=MTGAqUpkG9M4AR0LDPLTp1Y/lQ6vGQUS4Nj7RFd9abRMC1DYHeMtneeg+r22TfeBfwQCBPdSZD8RMuuUJLyVNjzLWBPVLbvEb1JL5XLoYpJ3p/Wh8QwxU7Qtfe7FFGwmfVLeVQtG+u3abjYFXe7ZtwWXPZt439uLanvGFFyTgMYT1KVgAz5E3VCFiOlL57Oz9mPYvoNZ39U5bSsh34YeTMTIqPtoRtNJ+kmaJ38a+YLiR3ymXcsqJHO+a+YsHbWSz2oHOUarA4TgHhTuXvzpjZYJDPehZFXzTbaCcSdciaRnV7PpgzCtUGQUDikBD990ertbZf87iEWxTF+vdNXJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXDxf6OPGwT3w2M3Imso1paJlt5BtFJl0742QXhR6I8=;
 b=hWXB4f/PjJlVXzIfJvdkDx574hiN9rPgjuJ5cw+pWoSgvdDOJEU8JsftkKbqHBop2yEguSA3w/uNLMGRAxmtLMf/fE0ABID1y3B6lP6vcitPbmaifDw2FPhV+EBGCV3GXg9dYRHePj4bsraSV3HVfvwYfqkDqdO1gZJWy3nIlDY=
Received: from DS0PR18MB5270.namprd18.prod.outlook.com (2603:10b6:8:121::22)
 by MW3PR18MB3450.namprd18.prod.outlook.com (2603:10b6:303:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.7; Mon, 19 Jan
 2026 05:21:03 +0000
Received: from DS0PR18MB5270.namprd18.prod.outlook.com
 ([fe80::c600:8d39:803d:d08c]) by DS0PR18MB5270.namprd18.prod.outlook.com
 ([fe80::c600:8d39:803d:d08c%3]) with mapi id 15.20.9542.006; Mon, 19 Jan 2026
 05:21:03 +0000
From: Nawal Kishor <nkishor@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>, Ashwin
 Sekhar T K <asekhar@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/2] cnxk: add HALO support for CN20K
 mempool
Thread-Topic: [EXTERNAL] Re: [PATCH v2 0/2] cnxk: add HALO support for CN20K
 mempool
Thread-Index: AQHcZatDpp1nqzpEF0GQLhMYvHFG87VRbAkAgAfPPkM=
Date: Mon, 19 Jan 2026 05:21:03 +0000
Message-ID: <DS0PR18MB5270F868B400C9C7D2E30DC8B288A@DS0PR18MB5270.namprd18.prod.outlook.com>
References: <20251204065203.1866809-2-nkishor@marvell.com>
 <20251205055140.2395369-1-nkishor@marvell.com>
 <20260113220448.56f44b5e@phoenix.local>
In-Reply-To: <20260113220448.56f44b5e@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5270:EE_|MW3PR18MB3450:EE_
x-ms-office365-filtering-correlation-id: 0098120b-1440-42cf-8db8-08de571a8a2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?windows-1256?Q?4x3UdG/5VeFXD8iTGmjiYjjZBx1/jA5PO2cHLX0IY+n74K3INhEquYdj?=
 =?windows-1256?Q?qIKXTGaGacxIoBYWEztui+e0NyFMXz3eETaPpCK8mGf3nXOO4XaOTdow?=
 =?windows-1256?Q?dKrd+GHPIXk7y5wYz4z3OAyD1Xs+TTkQVkKbakQgOKCzi9sub9ZMAoxY?=
 =?windows-1256?Q?I3MNGPaN+mOxw6iAsvHCUyRzl4AyFllEJ5BjfkfQHUUmU/BaWkUkfCTH?=
 =?windows-1256?Q?CBcqd2AXtbmpWn1glQdSd0ipCMezkd3SR1Q50EZDO8YNyX7jVDibO+/V?=
 =?windows-1256?Q?6OcLlIBnHhQMnnZj7PbMS28d7P4SiyJ/uvPUfUEIrS+g8a6P4r4rIfxa?=
 =?windows-1256?Q?XrpEFIbYjM4Rai85VvpjUZS5+xIQaz6AyB+njZaEeVaQyYQYYgRlkozm?=
 =?windows-1256?Q?n57KErXqHZpUr+0Qm9xxFZZU3So2VH9IZAqw5FtaeTCVtxz1tMfv7+uL?=
 =?windows-1256?Q?iPr8OKTe6lI4jUgKwlAZc9eKS9LmyIooW30C0VLgPw63ptAIvBt43sKh?=
 =?windows-1256?Q?V7FAeHiRuESP+ZtPzl78oCk9eizHvjpXn7h6Cj2Ctt1N4Y/1L1XfM1/l?=
 =?windows-1256?Q?U37fmaWz/GswLL2HK0c2sYfrWV24K7VNshLFfbXEcfuwCInRq3uWaAtd?=
 =?windows-1256?Q?lSgbwkPpfrvAOv9PBNsdNceNdnDShZaoJn8j+28HsnpWoTQl6ww6i38K?=
 =?windows-1256?Q?AYxVTpfs4LXe9bMUrrQLq0MfSpEuh+4eCVZS/XRTjnz+ppwJXfrcxEaN?=
 =?windows-1256?Q?MTu6i23r3GOhB8b5vvCrsoun2kmqK3d81hBWGuh6PYPzEbPRJsDjaD8s?=
 =?windows-1256?Q?UHsplMhYHegreAlEA8VcOKQ7q0r5jSmye8lfflFFezW/XX4qHEyMXmLW?=
 =?windows-1256?Q?lhJVJjqx2H+c70T5WDT9wzsjShTjv9KEnXZuMvWEuyoEejpJRX21hsn9?=
 =?windows-1256?Q?JXQ3D+IKhgBCL6ah/GWv1GUJNgWFYToO1PgHdy7Il9GvPwjYpeG4YmAF?=
 =?windows-1256?Q?iIkWcrP+tBLUa2+BcPI+3QSmuVOISR2PBh3Ci/fgbAJD8JXYLCwZvoep?=
 =?windows-1256?Q?ArEEhuRlZdRejazu1vBtxKBSFA17qgZ38HtXyZ8Td6Xcm76A5TDZrQ4g?=
 =?windows-1256?Q?Bqz+MQL1vJYjwLoWVyCXkbl9icwnHSnRliOC5JsPxQSWEh4uyed6MoxB?=
 =?windows-1256?Q?Lbhwkab/WtPIsrPryxZG/JEb5GMNu02MmESKuFeIC6/1A7WD0V9K0yzR?=
 =?windows-1256?Q?O/TGHcEiwpVgKMIDvPdedKtcK1ZmID+xUjUYc8zeiJR20tuc3PfXaxFJ?=
 =?windows-1256?Q?B5OCwFwOkd5OWFxd6za0l1t1yL5EEnZWX84/9dYjwBan4EP9l7toLxPG?=
 =?windows-1256?Q?676oFqCKQvZ6WSZ3nsSuozXnjV0DDuO4m+x3knhSGR0LMBywmWt7wzA7?=
 =?windows-1256?Q?Kgql9VBWAYlukbP9ppE2+tKaM6YF0FU3t8SKEXBNN4yP0iSlTcK0mcgX?=
 =?windows-1256?Q?nWuAzgjFzqknNsrXtEnlL5/8dIZEKa2AYYXtJwhgvUDTufIhY7Grs8PW?=
 =?windows-1256?Q?bfZ8zIdbsjDTdT/3bZgB7XNURYqdWdZWtcfbABFAX9E0gdT5Ud2oWWGW?=
 =?windows-1256?Q?yamRyk4KllslRiajWMzDvtVDpJwph6PMvoDST1w4Q9htOQfKvHnwGDEb?=
 =?windows-1256?Q?T4WTNiMvxzFMITdtMqsfXozTLPg3OoxhX0venUq1lW4hM0vjzCgf/Enz?=
 =?windows-1256?Q?/dNvkABswPDti1eAyDo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5270.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1256?Q?GN01EBLEfOLmdSVRRMwmzgY8vRAoXhlzt1ogXCbvH+KeOnGBq73W81oD?=
 =?windows-1256?Q?3LpQflYe9OFEUbWsJ5lTUO40pcXaG6L1o1iwx5rNBFBZpCKQioft88xN?=
 =?windows-1256?Q?U7fqoW7AQgEPCd+RsSQEmxLgWrDSpGd13gFJmRS9OvfJRbhExOeYmWSq?=
 =?windows-1256?Q?XtJdDFrAmyrwMt7yh6XaTgAD62+4/GwwE1iY4CiCBd9qp+bn1bs+eUK3?=
 =?windows-1256?Q?tBRI3JL2Q3713DgtIdmJmTPcL9MRV55/X9XWchuYi/NXmPBml0PEU1lB?=
 =?windows-1256?Q?yPcuOiXWR0hwjFXq1FS4yoRfnlQioHfFLn2BJM0sEmyOZvrRZaUSubhk?=
 =?windows-1256?Q?BmUxa4J7H6xKO+9edk/Wj3uIr85605wOObqdxZ2mj10sykzqu4Cy7jcn?=
 =?windows-1256?Q?5YnawxPMEalJpQuZ7oZiRPVc+zixclfWUjvY/1oUb0IaWM3ZfSZtBGD8?=
 =?windows-1256?Q?vPOiSsMlrZRfxcEK4uhOAEPLhOllU0bDswwOcoQqdrfYDebjaxRzip+Z?=
 =?windows-1256?Q?7rploqDKqoXAOaQFLpDF7iqoEG/sqnnxpwe2RunLGPti2XgzFRKhqDY5?=
 =?windows-1256?Q?/h9gugs9VxrQXAt7wv4rFcF7oJ1dSAENdScZpAcHIQlE731k97qGMkVR?=
 =?windows-1256?Q?SScJLoy5XSsnS3E15YJGJPsKReJmFV9fjdTXPJfu6RKUzhV+teiP2FBr?=
 =?windows-1256?Q?Z79+C8QwX4MHKPrh7Y0RXM2xk/3vzFldpl3A/XLpJL8jqf7ssf2TSwfV?=
 =?windows-1256?Q?QH5flK3rcGx7a7f+1e9e0/O45Bcm7760QNUquq5KgigaaQKCoNRjAVQc?=
 =?windows-1256?Q?DaL2UE/aLnAASpInEsWn99+E9f1x4OpFztMh8A+ChvS2+f95NALvAo7i?=
 =?windows-1256?Q?CfQFYayKA3nfgh8ljRw/JaToRCyKFW3knYVJGQcIwIIVMp3CtcO1XJqs?=
 =?windows-1256?Q?1XNhq5h6pGrg7FdRAiKoCu47sRFUiuJhEHb13UAe6pTL11Og0KLW/R+r?=
 =?windows-1256?Q?35aTQiy5RMkwILS39DMtL2nwIV6D1gvHfLgXeMZqBAJ8bptNWdKQuiqH?=
 =?windows-1256?Q?L+ZP6iDvf1XDMd3PDe5OkYNCP2x9GdABnIs9CDLZ3K7G0qQ6eBlX84Wb?=
 =?windows-1256?Q?Lj0NJOCl06CiAdGAzWKT5x8EAWl67LTcrXgcGmeDCCcxOmZr3Lwji7/q?=
 =?windows-1256?Q?pJlPZlAmGN9AhzT0Cl20AIk3IFUEPMl5s1TLRBeZeBPTfFtdnmKSVz73?=
 =?windows-1256?Q?pL6ym85PVOJ/KQADvzvvfDhAkaBIkqBf8Itr2ZnrgQ5ybrQNSBhOxhFe?=
 =?windows-1256?Q?rDxPLaS8EuLApOjtlhueI116JgcpiELpmb/U3UCiBamR+4qEn15nlJnc?=
 =?windows-1256?Q?8ieQl18fgNn8xiSMHslJ4Ehi5N5F2GxWOoZyoj7mDEstblmB6TEc8+zD?=
 =?windows-1256?Q?UU1wVguVma3S3kYyMW6+XfCxkqmO96hWQnQsnFNBphktdI32pJUInc+S?=
 =?windows-1256?Q?oTBBWTQOAP6wL+8u6gPGLuGzLSHx8XXnabp+9V1jSFO2Nqtx4A79tUj8?=
 =?windows-1256?Q?oF6G9q6e3yT/WchjoGIJWzhevfqHjpTaol7azzkQ90bnj+mA3Q5zKv49?=
 =?windows-1256?Q?mxtXSp8kvOxhwm69wqjGtG6yYzWK+EyfQ4GuzOkekpTSUpj3PC8xieZ9?=
 =?windows-1256?Q?Mpb0pn6ar62KmwWxCLTN3jt1v8o3MUcwcsgilEXE9UssTNpeo+c0JQEP?=
 =?windows-1256?Q?TL1ka5AJaLALOY31YSN/acC8JR3qdEwrkSXUgelR83kacr4QWc5CoRiJ?=
 =?windows-1256?Q?+4B/d/k4vks2oCKMa1FB9oUIEFLByJPOqCBEZ2AlZR3oRjGH?=
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5270.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0098120b-1440-42cf-8db8-08de571a8a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 05:21:03.1142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QJyy2P1tUbmgx3bu3BkJ6HqFNdVlUS14QvEDI4uPpYGI7wSvj1WNmAo3oXi1BWAzaj/Ux//mNWIyR0icHFGng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3450
X-Proofpoint-ORIG-GUID: nvYFdw9e10VV5TJy9kP4MgjA1_YxErwM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA0MiBTYWx0ZWRfXxnqARtH7k5JN
 5BQ2gEO0rAh/xGXYGjPCCYho3nuqwReMFeZMYl6rmcdQJHR4WmjVK0x7LXmuIyXaNuN/xxkI3bC
 SzBQIhRdaOR0pkqVAmc74gLI/o0OcPNPDAtBVW6rHBuJx1razt9tBYghP413lGtcaKWgjQt523Y
 8Xpaj5B2G/YQemAAfCShqNWis7i8Zts1przE9XbOZIzK9NG7tUwHswW/IXKCEzCgSvIHVaI0mbB
 OiMVxXMZgcVssaRXtTjDVaBDHAjMKxRyv1QMXKzoZUGUIEBRG+PgGhqtH8QcjPFGurMA4iQsPmY
 3MOk6+x9osENlBNxzFBdazs38GtuooSgiN79LbqJFdqHMRAEs1K0niWYvXcTue4Tnwyeuyl6MyU
 VA0qWEk/UAyRcnSmePc9SAc8Ar+PDa8Y+0cU8NbBHu/O6AsLnUKo3lURxbpwyBPrESA7c8ZjoFd
 vjvajapIE1Rjlg7Sn+A==
X-Proofpoint-GUID: nvYFdw9e10VV5TJy9kP4MgjA1_YxErwM
X-Authority-Analysis: v=2.4 cv=FcM6BZ+6 c=1 sm=1 tr=0 ts=696dbf41 cx=c_pps
 a=HuVJw3QhhfiwkO6XV87yIQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=eoNxP8pz9j0A:10
 a=vUbySO9Y5rIA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=E2EVwKWWsfXrR9Yu0poA:9 a=RFXaeJp-pwgA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
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

Hi Stephen,=0A=
=0A=
> =FDThis patch never got merged because of CI build failures.=0A=
> Fix and resubmit.=0A=
=0A=
Acknowledged, I will fix and push v3.=0A=
=0A=
Thanks=0A=
Nawal Kishor=0A=
