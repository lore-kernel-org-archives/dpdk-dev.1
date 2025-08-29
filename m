Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D02CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 12:16:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A8D340263;
	Fri, 29 Aug 2025 14:16:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CFDF14025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 14:16:42 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TBnsYG025118;
 Fri, 29 Aug 2025 05:16:42 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2134.outbound.protection.outlook.com [40.107.244.134])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48ubp1r1dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Aug 2025 05:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9cxOOjyYyg4KQQsYvthkJIbHlV6N4i78BpDHjGTZHPMM9pVQb4iDH0rCXVtJYSVgZYQMZ5VFll3vIibAFxjvxcetoa6JN4bpV6+QKWAlq1wZWPhV6A1OfTAWJM6kZtE5F6kjESGmzewliPYxHT81s56q2+k/z/bCy4cHxBI07+LQ3fJkAck6+CRwwqj7JUsbBsG/oxT3w7F/4EBk6PbaKosvVK/YIzOYuACoxGc2bMri8smNjbOJFX0K1SAmSmVIyxCEtOBIkPK1Qsa+cuc/GerSc/rMSJxzI9mLJMr0qkGbiZqxJEGFMdYMPQ3lZm9w2wJYgyZoeaupJAzSlO2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQn0IUFI7lzy2uyn9XqElcIiHtdZwk8oVbkwLtvlzHY=;
 b=kSH9NE6h5EL5gunh8apSzQ2a0aW4Ze9y8EsOKY/MliostpH/HnleGMyhOFuOidA/d7T7i2BXNesbfBRLiF35MEcsbVtWmXVIduawR+kbF0lYlfTFvf4ZroJQVTVyzM6YdcSUG1ds+xLnkjy2VQ2FJ/CCyiUWa5uESrGXPeVN0y6/3C2tFaBqVXk1s97bdxZCwzYnFejALkRjVuJNXGEDTa61AS2eyPajxWxP7v1iTtrCGNMQ+p7rusvzYwGuueP/tIjqC3P5bvD0gkkcPuZjUQsqpbVzXU4u+vi/120TD7KLj17tOiKwDlv9scMh2I+7tbp+qYPD0ThLdHtX52CC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQn0IUFI7lzy2uyn9XqElcIiHtdZwk8oVbkwLtvlzHY=;
 b=FQ1Ugtlul3upSGqmHEZ668dRQIg6SG2r/UFqBzdDDLccM/LYb7v/ZQoJJ0RIbSnXjF8PGJO++uRYV8wwnKaddwrUKNBYDR0poCO9uKb2gDRKm4DBxhyvb3i44/rFqrlCyRS+teT3e9ahxhc2iCxYixr5YPudWaAUpHeNs/Y6ddo=
Received: from BY3PR18MB4705.namprd18.prod.outlook.com (2603:10b6:a03:3c8::12)
 by PH0PR18MB3799.namprd18.prod.outlook.com (2603:10b6:510:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 12:16:36 +0000
Received: from BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::3c75:4e85:e83d:4ac]) by BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::3c75:4e85:e83d:4ac%6]) with mapi id 15.20.9073.016; Fri, 29 Aug 2025
 12:16:36 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: "Finn, Emma" <emma.finn@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>
Subject: RE: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling pointer
 for SHA test
Thread-Topic: [EXTERNAL] [PATCH] examples/fips_validation: fix dangling
 pointer for SHA test
Thread-Index: AQHcF/4n1AirPyIQZ0eW5+X0CURUuLR3zazwgAGexICAAACsQIAABaYAgAAaOVA=
Date: Fri, 29 Aug 2025 12:16:36 +0000
Message-ID: <BY3PR18MB4705890AC3B3EC7AD3E89F3CCB3AA@BY3PR18MB4705.namprd18.prod.outlook.com>
References: <20250828092822.2791101-1-emma.finn@intel.com>
 <CO1PR18MB471416C114E8D59E97EEBE2FCB3BA@CO1PR18MB4714.namprd18.prod.outlook.com>
 <CY8PR11MB784530D82EB6D7A7D4EF1F99EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
 <CO1PR18MB4714A60A5FEED89BA023628CCB3AA@CO1PR18MB4714.namprd18.prod.outlook.com>
 <CY8PR11MB78457F3C1B8380E1903391D8EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB78457F3C1B8380E1903391D8EA3AA@CY8PR11MB7845.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4705:EE_|PH0PR18MB3799:EE_
x-ms-office365-filtering-correlation-id: 99caa531-16f5-4239-095d-08dde6f5e6a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qkrxQDg3PZNVGZ8Ds2b9gc/j21e4IYo/kZj+nvMAs7YbmjymOXTD3pl662cF?=
 =?us-ascii?Q?ANjV18cbZyPyNo2sjjdYFYTRTqIm+APk+henDyI9Glg/nr1LzE+rW8HOHnrw?=
 =?us-ascii?Q?LcJfLrrqgGRmdhjd6O8uzwpb6uxVp0T20C9qO6h4hWeDn4xzs9xO+xasSHtA?=
 =?us-ascii?Q?dWcDPv2Tm5owAiHGFoxuX5qpJcBsgZQ+hmr9AW97EnYc9HgZSql/nvZ31TRZ?=
 =?us-ascii?Q?96Q2F0ZP519U7dWQjQmH82wNrzQWso9miMppuF5OJvrL2Rnb2ph+d/qOEtCh?=
 =?us-ascii?Q?bO0S8tc/7ITuUulP0JQqYoAe2EI7fNj9QrayH56th60Xx+i61bqQ+mK7Xoq4?=
 =?us-ascii?Q?575ihgCVQVwLpGN1wKlR9lDQKNPTtVgFvP1vNIYZqWWqVMX2mEt7Mkp+NReF?=
 =?us-ascii?Q?XL+2u7ub9qd6hRr+dGcxUR+RCq0rEidjkqgGE7SQlQ7livu4lNJE+sus15LY?=
 =?us-ascii?Q?XzV1Vo3V5BD3D3s9PmpG/y3cQQGsi6lT5dAmNY4jkqIVaZhdhrnRQsuR/Hqb?=
 =?us-ascii?Q?U3wPjpEb0PMtb9mOHKhLuNmY1TT2GWGv4oIMqOGPtlQhn0qITYZA56S5ObIN?=
 =?us-ascii?Q?vaP0nfngk9/uumqIeU0Ilx6iWCqXz0et1n4DnAcG33tq7r7FU9ZeFRDkECr7?=
 =?us-ascii?Q?uCfnrg90NU8+bsUVheDbR7tFlr0ekz7oJ3fg4BueZbOvcRgCqfnu+bIboG3r?=
 =?us-ascii?Q?CYp0VZo95a61SmjKRwkXUNSJG31SuOt9rMD/HZPm+AwwcNNduYlAvKu/KnZ2?=
 =?us-ascii?Q?8z9/dpYVk634A6e4zg+N1BBacelmFX6WAhK5+1C/GXIsSauNDCD+fXoFG6gA?=
 =?us-ascii?Q?6sZg1FF6sP5/anZRA3VOmPNgSFbVcbF59PvCUULPWce7In1HRRpH7xbiw89n?=
 =?us-ascii?Q?OnEBn1zu+AepgstMVYwkq81jWUjJmZQzM2t5AA3K9qI4IMyMVSfpd6oTnl8r?=
 =?us-ascii?Q?U++bH4HyjAb7+Ax8iEFxhYxlilEH+dtlt7nMHAkampY2kSpVqiScarOsZc7S?=
 =?us-ascii?Q?zRmnON8An1kjftkUuE9z5lbr//iWuEfHWZa5fbTdV1U7fG1XzTWXPpL8cGjd?=
 =?us-ascii?Q?BeRz0VAHZEpB80hlqtMlcs4/Cr2AIgaDUZU2MBWrkQyLdkIpvMygYn9Y+SFB?=
 =?us-ascii?Q?yUnUGIKZI2EU7DAz/EHnoJujxj1efiSyAsonAn+0WCe9YNcty2wVc6QFIDdu?=
 =?us-ascii?Q?T0kYg73OdvIef8YxFPvNbvDVTmsWzHIZ+DFlo7cu+nm2t+8T4Nah+BlanClp?=
 =?us-ascii?Q?WAiDINy7D+ZFp+clBwhNFQxoaVz0n0Opo+Mz0RnAGfChdfoQ+pwhbZCif+h3?=
 =?us-ascii?Q?Etn5hyqbwnS5LkaA2EZOg9hDn6d5JkzYwi7QAYe8p336pI6uhqq11hIFCYVG?=
 =?us-ascii?Q?ay7QnJkQ60CxNli3338hUM2dxGL5KCSRuJsjAAZUMFfr1zAW+VTviLT1b3Q7?=
 =?us-ascii?Q?lPSYXkcpYFZ62FoOYwUOTV6QfNrjlmfb5XH74OEtGES0XW7JJNSaXA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4705.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cy4xK7rPdLrDvG+b90BnXwVatMJtRwUE0u7XKevJx9/9Y+DMUJ/MfBbCsZap?=
 =?us-ascii?Q?9M1nDDlnqSLwsVkOlFvzSyUHT1hXpQAVWK4GQkrqMIVmYA/8Fj5w1yOL0xG4?=
 =?us-ascii?Q?6dy+74+kMQe4rjdyFFJRGSaOU1dZJwuur3h517BksSQjqiaQJDzmA/THvw9k?=
 =?us-ascii?Q?qQaxea9Mp05Ek2NEu7SUNA44Af/3XMdKT5w9gjaPqrHbb3sdQ8IIqf5KSS1e?=
 =?us-ascii?Q?iAnzoDiGXykmSAusKM3SlXsZ+v2ArewFo0pDPK0Qsz8EKSez78thcY0RJl03?=
 =?us-ascii?Q?aHzxrbNSam78JlXV5dyQDzAhmedU/Bn0LaETapzm9sH6Me7h+unAU2wSHvm5?=
 =?us-ascii?Q?9CPYwAxSa8RC6JAARNblB3M26fxZS8RnlAux/ZAgeq6M6mk0v4RytyG3CsPx?=
 =?us-ascii?Q?nndxorXwhi8dky5rBZV/E8FPCBgeSxxvXVld1P/qXgXVh8kFlnD3Iwckh0kq?=
 =?us-ascii?Q?t5Kfu1sLqfmblAqh5ifCG9VcC6eB+skMx4MAytKL/akhs1Z1qLh2t/jS+a8q?=
 =?us-ascii?Q?+TkrTLiqzFSzraUQrTmaOVEgl4Z5VN2LPxS31TUsYxurcOsNC8xtnP9eR1Gb?=
 =?us-ascii?Q?QzgwW8dDOIsX6pcnlrtq5o/rPdOKElI3IKfVdLNosWBjxOjwHhjvUGWGWweu?=
 =?us-ascii?Q?qTX0QdkyB66MUaWTZEae1Q8P0Twxub2eMEzXjU2Gn2/oc6eyb+r0QP/pKxP/?=
 =?us-ascii?Q?wAn2mI4t+O7yHIONr6xqWjR0hJroNG40EHrEl6vh8StUBvaFnkJzXBDrULnJ?=
 =?us-ascii?Q?HtroVgzSlcXqaud9s3XP+r1e72SOAw8sqyFKWF0LakUBYySrPBC6AIr8b7GX?=
 =?us-ascii?Q?bz9gsZJGYW3P8+ItAXlSS51aP/GBB5Eb+p7BFru8+UNh3TPjvkl1eqSliHhQ?=
 =?us-ascii?Q?/BO4YlsQXZjJdmNoch90N5em5oolKmmipu6HOXMAph9qcPglI/pHNCltfKbL?=
 =?us-ascii?Q?ZUq5vY+ywrjhG/dE6MqmARhB4pblKmqQo+8D161gTzWtZlmqBfB8tVc0IAyF?=
 =?us-ascii?Q?yydAP26bkNMgntaBjSbvcIiUHEl7X79Llq6gr43dQ2Jdyjx8lwzM/Hby3Rs1?=
 =?us-ascii?Q?gk+Z80qECNXVolUn0XNcjxKmjNmjHq+h6l+kQCXI3WMFyalrX+J1u71xTFtb?=
 =?us-ascii?Q?eaKm9YptU7HpFVYSL//EHlEJchq+/KHeWiJalOytYRQFnRLEPXwPjGi7ZCST?=
 =?us-ascii?Q?qCqpjzFuSDMud08FcXwjbh6LCHmNyuHF7bTFybtf4rJRZhaCIPxseBscp2CM?=
 =?us-ascii?Q?k0RpeiSzViz58mLCwn3AfUNYPpmInPYYvOLvtSGtFzyVVcAluUTldHOlTsQP?=
 =?us-ascii?Q?d9XnBzdp3ETQPM3e02jX1jfhISyBL2Mn9JqXVzevZcsJLiWpZisBe1B0H9fE?=
 =?us-ascii?Q?in+WZTRTnKX508+RUrkSA/1OFHZlfAVUaG3Ewp6e62T7ys6Se9KocSx+ksXp?=
 =?us-ascii?Q?rqBID1iHKBv8Ewvit35V6qpayslPo6DrjeoaOOfx4w9DYTVwSGdNd905NJmk?=
 =?us-ascii?Q?ZIm6NQxmH/5YiJNfpvjp+9tT4dCzgqdVDGl88a/2j47eIbAX4zJobQepuWqr?=
 =?us-ascii?Q?aVZYTFvOF6TT/lptbVC7KmSaocKDSRIcgxDmDbeo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4705.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99caa531-16f5-4239-095d-08dde6f5e6a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 12:16:36.6877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6x4gsODo3euSxfrE4OTKZCteNddjeHmU/snZWD2ykofAXZae++vUF/W4RoPcKbj7ywypR+uvTrSS3UW9fXTGQsj14278yjXMZ/KSvD3mv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3799
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA5OSBTYWx0ZWRfX+gQVB4mjKr/V
 mdGlgNdg/vs6FuhbK1DgrWBWK21PQv5THEKdVcuQVRPB/jHFb1H7uLO1NtiEC87mMa4ebuhdUNp
 doBlBJpyvW7E14ydyip/ZWbrxHvGwZJ+EDVWGpmAliB87UEedU/hiE+dhzCyPyxtOGHtd6rE9oD
 dI2f7k3oG8swXEZ6ESHUw3QZZSo5+wqQlnQoypLk00gJHBC0E25WEfMWMxhi3V1bFiuIakqbgxo
 yjia/D7y80LlDF/X8yrFb798dxzl/IhDiUZn+lkbM3chHt/DFRU3arj5khN82PyijeLN+RSbFVd
 Ye5EKgm2D4I+L8+Ti9cBDmC2H5T+jL8HT1vzVWeD8njHLMMN6pqvgkoBfVBtcjWXARy+Xv0dxpO
 w/grhvh2
X-Authority-Analysis: v=2.4 cv=RaOQC0tv c=1 sm=1 tr=0 ts=68b19a29 cx=c_pps
 a=GDrhuTzPiPrUrIysEZmwqw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=-AAbraWEqlQA:10
 a=2GDeVe5DF5P5GUMtER8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3lU7vmCfqoUwkx9IKteGJzRcBSJaDrZp
X-Proofpoint-GUID: 3lU7vmCfqoUwkx9IKteGJzRcBSJaDrZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_04,2025-08-28_01,2025-03-28_01
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

> SHAKE is not supported by these hence I did not catch it.

OpenSSL PMD supports SHA and SHAKE. Could that help verifying both lines of=
 fix ?.

Thanks,
Gowrishankar.
