Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958DAD1F9D3
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 12:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 868E54021F;
	Thu,  4 Dec 2025 13:30:15 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0B75040144;
 Thu,  4 Dec 2025 13:30:13 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B48HExQ1157579; Thu, 4 Dec 2025 04:30:13 -0800
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023101.outbound.protection.outlook.com
 [40.107.201.101])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4au6n18eys-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 04 Dec 2025 04:30:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+todFDpcIwwus7CvQaQFMzUIjCvX97Hv4nVseuqmU3gAwjMvpH+1rBDdIsj9sTvnXGcYqwlbb1zekBAWzKuCzKSmTvuKt0EY2OU707AlELtHyehuI/WY29Wm+jt8vqaKzhhpfWuGaiQChma3jgANg+6cZmEmuFPvxCwvhHoXSl7o90fEm7Op4VnZjFC5+fmtnye0O2YBJ+ibG+oJvuBFKhT/3ztlxPPI8jtJ3rqO+90iDKQiWCfOlzhAwRUAi2wJIbz/bZQGfxeExLKBGZCOWzCcurN5XJH3TDYtAE4Ewc+dpduqTdv/ArOPqrafyqb41PnzkaLqhfIf3xCBfcN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9phJIqtaEkg8P9rn9MqAabiSOPBMhdFun8aUVqD+jc=;
 b=F2vUlM7TLK1p8McQyfry8vY+bQmV+PFyn7i2bPc0PPo1AIuH6elxRHddiywSYXDfHO3VvPbUSz41XWRh5z1/sEQw6qTR7g2lLkgAeDRvgLeS6/nA05NJ1jr7vYNnG3mRaXrzwOsDw6Z/W/ZYC9/Ln1si/j3ar00GqevqyTDScytNQxZ3Zl+0C2SvAf1YGnITMkCJ6Bo62d2yCwpWd7MFTycMGF80Pc8wp3NPNNoG2TIe3Ei5GIx6CnKcZHgdkq1i++PofDJvJ3AAlhWPgf7m5IXknQmCMeo/JqJJOJF8Bp88rgYHqTgYZg2OJ4MYVGEiL0UTw7TVwMGkcV6a7bo28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9phJIqtaEkg8P9rn9MqAabiSOPBMhdFun8aUVqD+jc=;
 b=ah5JnAN7aT+Ib96ggsalwAAJQy8xjDY9+Fbu0WodNSL1SIeun0ob0Yp7TaHMHol//nN4+bq1LLnhE/vPnfD4ZjlITvIIp7nLSIE16TTeaWyK02cgDae+ohsdFm+TXIF8lkLnNL/p6sDyy4bRIzRQYTDruzVwmTgGVpoR2dcumDg=
Received: from PH0PR18MB4672.namprd18.prod.outlook.com (2603:10b6:510:c9::16)
 by LV3PR18MB5592.namprd18.prod.outlook.com (2603:10b6:408:19e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 12:30:10 +0000
Received: from PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c]) by PH0PR18MB4672.namprd18.prod.outlook.com
 ([fe80::10cc:503b:935f:f61c%6]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 12:30:10 +0000
From: Anoob Joseph <anoobj@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Volodymyr Fialko
 <vfialko@marvell.com>, Akhil Goyal <gakhil@marvell.com>, Kiran Kumar
 Kokkilagadda <kirankumark@marvell.com>
Subject: Re: [EXTERNAL] [PATCH 1/2] pdcp: add digest physical address
Thread-Topic: [EXTERNAL] [PATCH 1/2] pdcp: add digest physical address
Thread-Index: AQHcY3jhsLaKu+0Vrkyh0RsI274C17URa/bZ
Date: Thu, 4 Dec 2025 12:30:10 +0000
Message-ID: <PH0PR18MB46728F2A4AFA7F76F6B53724DFA6A@PH0PR18MB4672.namprd18.prod.outlook.com>
References: <20251202104550.849311-1-radu.nicolau@intel.com>
In-Reply-To: <20251202104550.849311-1-radu.nicolau@intel.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4672:EE_|LV3PR18MB5592:EE_
x-ms-office365-filtering-correlation-id: b5e71c00-f116-49e4-ba80-08de3330ddb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/Fr/r7m8wqLLLFSt5eke3uVwQ0oDsiGvQ6pYurMuMv9zQEgEmpRg57eUrt?=
 =?iso-8859-1?Q?/OBEbIdOz1uYuqBThyljHvwsGwsvUYPjYDcQbpt7MdtJy8Bq7dkb/GDOSH?=
 =?iso-8859-1?Q?W14A99VZigUGZQ/+NV/wfmQmsKg/SvgKYpq8/QmDe+9ZiTs/dwzP8Iv2Ug?=
 =?iso-8859-1?Q?CwQ0aXpd8wuvsqvZhe4Bmgr/sBtLl+VocFdkOWW07HIbJWUdlxgzAJ3fQG?=
 =?iso-8859-1?Q?Lt0vmrzP9qoTypycC83EGA/YiSbmeL7MC9c3oT9YuPv8e208zsBTLm0wco?=
 =?iso-8859-1?Q?EpaAVsxgLLoemRNnt4oBXXDd9NF1f204ZRB8LXrWJM9Bz4qQlXfSYL8UgS?=
 =?iso-8859-1?Q?yOkhqvMjcBe3R4xPuiBLrGigTlU2o8ptaUZlh8zjjyAFxu+NoxL5UED0Gm?=
 =?iso-8859-1?Q?G+eNLCt+3NuvT1PIwW+T3EmG9iXFQfeVLROp2PEsm90ARS36jfla/hd7kF?=
 =?iso-8859-1?Q?GSVuU4a3apiIavvz9vSndmyiHigjGM8XPub2M2gcOGedSa1pG9bhj3vf2x?=
 =?iso-8859-1?Q?Sqn47NZn6g8h0uhMgZoggtq3qh70LsOse4OaS+wYrFQlOEH16fRWZ12GL8?=
 =?iso-8859-1?Q?mj+k+g/eIUHWy7dScGX6ZhFBBxW1h/vGrGT5b8czkYUff4oPhLOVlF91GE?=
 =?iso-8859-1?Q?pfcxcXnqBAkB5Fcb36PNde17ZS4PWzl+2JieG4qr66aP6q8Zz/NeISYOGZ?=
 =?iso-8859-1?Q?iBxI4svmKl9Xd5z4CgM5tD4QNi5syVUIMcyDUYL2dGuONqmLEHhc5BlTaB?=
 =?iso-8859-1?Q?h4FJeuiWMQfOOxfc5q0VjmcSwBEnOxr5UbA5f0cV/ZYpK9KqxJZIOeEryi?=
 =?iso-8859-1?Q?ssMGbzsHZ+lk6V7HqvRJyKQfhJkAR1wQVzgV1R+lcjyVJqth0AxtjrQ2e7?=
 =?iso-8859-1?Q?5C+JjW4inWtHGiPenMZDwmkACGFIlOeDapWjVlHmqxa9BZ1ulPhx3MvTvV?=
 =?iso-8859-1?Q?oKWpn/uj4zTsgujQI549ebGMpkERTRt7tP98/Yq/2PEFuLJyURcGNTKAvt?=
 =?iso-8859-1?Q?HkMoPYUgUQJ3DE5MXrhA4WRWqcbNXPNn2q9WnBFJr6LWvQP9JEruKvoNRv?=
 =?iso-8859-1?Q?sSy4a9jsQjeNonALEb25i6hi49oYQ27czgiCLByGorFmrybvDvzfkuE9ku?=
 =?iso-8859-1?Q?j4SMvh/NX2poflKDGJcauKp53QY1pfy+1pLgkgyP5vNI/YpKQJ+kjjuvtH?=
 =?iso-8859-1?Q?LaLibD4VaTCIzM+rMTLWqzsFgaC3npghs3CAB1F++Ms6vVZFUkLRm0NUSh?=
 =?iso-8859-1?Q?mKxTja9JOso8uh0fBANzoI2b5kM9amIDEsheTJ/DrJpIuohlYYfVHqko3T?=
 =?iso-8859-1?Q?XSGBiNQw/p0GoF61IuDS5cz78ctfvryPqnnwvm0oPfbS/ZA9Uu87k3z6+H?=
 =?iso-8859-1?Q?yW3ZefqU1h2AC517EABBlezhKpZkc8BeQIh3/u/3CUtol/pAwndgGcAunQ?=
 =?iso-8859-1?Q?riLSs1zjPATXji6VNm4NbOmsjBXD+XiIF1vO9mIpNjCm7rkuiJVWLa3S+x?=
 =?iso-8859-1?Q?dGCtHIcoaZCiI95k58T478L2EkfzviMsfRCdUsLfRyOHdA6S43/KmnXZr3?=
 =?iso-8859-1?Q?w997BUWayKsMRtjK3Oewa5elGMHk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4672.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fjEZAecOc1EbOvsCNE+lCYufZmHsI7+44eCSPdugpbENL/d2XxJ79aE5GJ?=
 =?iso-8859-1?Q?P1wv2Q3hRFJx+1oJ2B6QdoYkr1uCOmR78/Xv1vBXuiP5ocSl+eZ+ld8PB1?=
 =?iso-8859-1?Q?pwPb1ldPWgYtsEoZPpByW/a0wAGhHmisOR9VpzUmgu36/BS0XbC1OVPoc8?=
 =?iso-8859-1?Q?hzIdE2emF2BU3TFzMzJzzUsF/o219fqwIBs7aVb3U7OqFNNtPXzFUUw0Cb?=
 =?iso-8859-1?Q?yzI119m21vE7zmt+0nF6f4zHqI8ZcTIp3Y59dveijwIsuGmlr16z6ZepkC?=
 =?iso-8859-1?Q?iEMaTJGdAoDkmhsDs3dNqVnrwvxPJO1r8r8ejXPJRBSsUAoJcfY/C0ozVT?=
 =?iso-8859-1?Q?tA5iemZHjqXJ58teWilJq4uu89jxGmXAxAyaNVu1/z1N/C0MmVGb6pc7yU?=
 =?iso-8859-1?Q?VRgMNXqDuGJyij3rS93/xxWYlpuPub8Xid7OaqNzJWo4KNNTWiUgw5FPI7?=
 =?iso-8859-1?Q?Dz9kE1M+xhDQRiN36Wkkmu68Ca6KFcnCAhDl+hNgngXpskuoLWPL0JSdFw?=
 =?iso-8859-1?Q?J3Ohn8Oi03UKPWWI717HNPd9+7liABJyEC7KLiv8o0yafgI5fqXTm0L5aX?=
 =?iso-8859-1?Q?YA8vmp/0Mg9kIqPWZlUSPl+8OrVGY1w9FFAaRemEmjhETkUZ/00FiSNfJP?=
 =?iso-8859-1?Q?vP2x3Jziv/BqOx8Yvq1GI9YLZYYJg5XbzM5ayQKr/Bt3K38boS8GVJS8dU?=
 =?iso-8859-1?Q?LbxsyiXjej9hXPK0qMuAsjIfx+76DrV35t1JxDH+HZFKE6bJwbL+Gky1eE?=
 =?iso-8859-1?Q?4SP0S7962eqljB6SuRA82oG6GvEjKhPEtUmk0W56+yOY2qfmwxec11CpSZ?=
 =?iso-8859-1?Q?JNCKbVAuVdhQMvDOGdKcS6hA0yB2SxGKGpvZ9FtyKZaCLr5AuSoOKhYA6l?=
 =?iso-8859-1?Q?mTzZm80bguOjnCW2G4gIWyUcGJLrgjeMqEhOqctTRj3VVvYhVlZRQk1IG/?=
 =?iso-8859-1?Q?xb7HAQSihJEShDvtUaBg1uEXdE14ynS2Ga/Hp3l45nMEyCHlsTsbUzb6IS?=
 =?iso-8859-1?Q?Vru2M80SnoQcyIiOP2E4hh96CmRHgTQ/IT5CjP09hWJiolBoSOn+xe8mEe?=
 =?iso-8859-1?Q?+lkO2pr3m268FoLN40tnQruUxXqG1axNjgaJr5e/bXJgFi94ZX3nMoBY2i?=
 =?iso-8859-1?Q?4CJtzkjUJGbqDv0vfKV9O7zj9CkHYSDbfqudrRDTMTuqDUROkYFekIUEAA?=
 =?iso-8859-1?Q?fQLwa4fW8SToBuh5e6mRtqsFYJi5ASr4Fh2qs9z+My86QoGASgbcF2AgCy?=
 =?iso-8859-1?Q?eyBMkrwuemLyp1bURJMlQntKbyZedz4WSUnM4Zmp9ZykJNrE/pllxKA+8P?=
 =?iso-8859-1?Q?YnlkAA95lmtKr5uoQV3/ynJ5dRqEM1Rs+5HgmugLgLjr13ALq5+CeNAltq?=
 =?iso-8859-1?Q?w2l2OJ4Osh1pbinjWDt7W32Hz/jLWEB5mgYgeQMQGWg7L4N63NLPmBZyUy?=
 =?iso-8859-1?Q?aFcPrH/jlPLSn+5VqcZMjwpphh8D+JOhst+/KrOI7AdN1g9ss3dJkqmXh4?=
 =?iso-8859-1?Q?Pa6/zlFRGiyXSPrDlTqw0EcTL1lP0+JmPAgiN94hayfhvw8FcnhcE2Dpo8?=
 =?iso-8859-1?Q?uRnq36xo8EuUS2gvPqAp+ldV+ygVsf+cPgacLSrdEBZGQD8K1xJdfq/qL6?=
 =?iso-8859-1?Q?Lsk5FUH+h/Nwk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4672.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e71c00-f116-49e4-ba80-08de3330ddb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 12:30:10.3934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHJjOidTAtTGSsamcWEF88xfBwnUNiLQiUInewXKTkPxx+3kOVVzO9AXmoEenIuEJgBfDtruHXPbDAG37M7OCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5592
X-Proofpoint-ORIG-GUID: L52H7vsdO5MggUbxyfc92PVHp2kNTdjj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDEwMSBTYWx0ZWRfX/5I/7ClJ60jC
 0xC+Hxg59JG/4MK4KdRaLs8i3ftFe0eL6HyBQ1G62cMgt7lOki8WI7oUT/bknVS0sjl2+htyE8z
 HzYjbNvAmXqg5/4VQ5r4tVKwk55LiQGfNiKtT7z++E8QBq3+Iwe5CRnl0fTIKEVCpKOgZ2Kh0HJ
 Isc2spN2htjspjTsMPUmkUU7qp3aHdLD72TBZJMbi2zo3lohr4mlr676n0TXcn2NVkBL3atN0sa
 JHXeCwNCFXAwK5QrPGqG2iXRDIP2FehQo6I//pmRnBxRQxpBR7iHLSrDBDyLOZQ8KfSFmjvd7iK
 A0ZpGQ0Twzpzjsg0UVoFONXxTdBWMhwci0XDujqVFCRGqqarYe6alRyYjKK80sgXv4s1BnylfI2
 bBKSgDDdxPscguzbS9+peIgJBqJDFQ==
X-Authority-Analysis: v=2.4 cv=b/O/I9Gx c=1 sm=1 tr=0 ts=69317ed4 cx=c_pps
 a=fEtlOdDQS7EBvc2olrXP4A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=aODpQnNUpq0SFS2R-8oA:9
 a=wPNLvfGTeEIA:10 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: L52H7vsdO5MggUbxyfc92PVHp2kNTdjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_03,2025-12-03_02,2025-10-01_01
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

=0A=
> Subject:=A0[EXTERNAL] [PATCH 1/2] pdcp: add digest physical address=0A=
> =0A=
> Set the physical address for digest buffer.=0A=
> =0A=
> Fixes: a785af14ff79 ("pdcp: add pre and post process for UL")=0A=
> Cc: stable@dpdk.org=0A=
> =0A=
> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>=0A=
=0A=
Acked-by: Anoob Joseph <anoobj@marvell.com>=0A=
