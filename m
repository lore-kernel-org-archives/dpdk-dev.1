Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CA8C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 08:29:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 452FD42E7B;
	Fri, 13 Jun 2025 10:29:48 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 97F36402E2
 for <dev@dpdk.org>; Fri, 13 Jun 2025 10:29:46 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CNXlQ3007486
 for <dev@dpdk.org>; Fri, 13 Jun 2025 01:29:45 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2116.outbound.protection.outlook.com [40.107.244.116])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4788ns0uk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 13 Jun 2025 01:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EasiLdiTDV/VBKv+0E1lB7E563rhqQRTFNEjKmYF8FLlVjV2wmqeVLORs163mGLlC+QFEuOd7ZhBzz+EFSK0KTKy5ohYzabcbu+Kod4CKVwrGFMThp38aOZAKG90Jod3jF5T96/aWKfwjg2yAwr6WmZP8oAdlknH87qlCUm/Q/CnDcDjIkzOINsY4/5tdxOi+a/8z9bADgLtl0a3ow9JPEnl0gF5pnnEijAON4iz+/sH/x4ogcPSKflAsu2CthnwoXowvLn4uvQD9JcxOK9MKTmuitNABM2C0MMrkjFdVduS7ZXekll/QjUKQp9tVwW7htPRu2U28rjoTlHnHqjJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygosYuLDvKAye8NQmMGOWBzdxoSFmdiNOq+cCXEpFUk=;
 b=tnGaBYPREygc4/Rn7tjiNdPCIIg1HONqfO76ydNvbXtq022wM3i7XuzJ5oWVVLPZtvupNVG7u9p3Xxl7k+YXEw7ISheBTwWjnUbWVLWjG7Na3KvChlwCngSXmv0xEk5neJ1/d3oVjlSweOy7EztS3tPdOeMDg1QOljudhHMrW8RxelLiQziGvhSpZvV9peB9uMhIKwC7vgX7wqxvdBYyuc4gKVkzcpwSTV7+ObItqBoJOhbhEFtQ8PCd96nI1AomnkfJYENym8Y9oMyWS053iCMqLiRF3n3Tzlc1ss3G5JxX9eftbaDy8PH6489gweNzQctrnim9B7G5Bym0HTVsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygosYuLDvKAye8NQmMGOWBzdxoSFmdiNOq+cCXEpFUk=;
 b=c2vUFNQF1peqDtrugo0KT+g7PvqyV/Heqk/sB8ficjRSupurG3JkJP56hkNNa58CZvMA/2eng+Nkn/NQBWyK98+f8t+BIkDdOFDTswm57YJPoWoXkFymNmwiP4iu8R6+U3i0ZF7p1JHQ1bvdE1a5LIwaDXzMFiLTPwsYPCABxU4=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by DM6PR18MB3667.namprd18.prod.outlook.com (2603:10b6:5:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 08:29:42 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%7]) with mapi id 15.20.8835.025; Fri, 13 Jun 2025
 08:29:42 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: dev <dev@dpdk.org>
Subject: Minutes of Technical Board Meeting, 2025-May-28
Thread-Topic: Minutes of Technical Board Meeting, 2025-May-28
Thread-Index: AdvcPPz/2ordgM1mSTOFCF/I2FGfow==
Date: Fri, 13 Jun 2025 08:29:42 +0000
Message-ID: <BY3PR18MB47853E2B0132CF340294A2E2C877A@BY3PR18MB4785.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|DM6PR18MB3667:EE_
x-ms-office365-filtering-correlation-id: 510b7795-bc62-45c4-bc5a-08ddaa5471e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rk02ThnTb7EojgyqynlWHfo8MFmNwWc4OP6uV5KcjL2MfFUSJ6WhpewP+t?=
 =?iso-8859-1?Q?jVNtrA5uyIeQ4lz8beUBHaL27Wu/D9tanajh+ksEuudcae5et88XwX4Xjc?=
 =?iso-8859-1?Q?jAsh4yIOumYmdijXWeg8m0eUh3WGsqOlWbhFRI3B91MIqDF8ZTQCg3yiHT?=
 =?iso-8859-1?Q?0n9ZkSUDPEWKhlcfbskd82Vgy48X+NVtCXJISeazAsvm/KShVTrfuGnjpD?=
 =?iso-8859-1?Q?hFnRkiQooPRQHW1BiEDFM4RDyry+BqbyY4deQg0w0UgZV4B3aWeTRIemSr?=
 =?iso-8859-1?Q?SmRE9GiDcLHzsdXDmsSgUuRyqO4D6k63A6uDurmXnvc0sWTv4INtDYW5Jo?=
 =?iso-8859-1?Q?Kumr5i9rjgfNI+Qh5ugDhsdhSqO9htX9ASlIDHio3qocGvizX+5gj0DUk3?=
 =?iso-8859-1?Q?frpYnZH7Kc8hadfyIgdkJfCOWC8qVbI3Yx9U0GSC9HLasUtFTCXSK9fP2Y?=
 =?iso-8859-1?Q?mlrlXPpB566tWVaqKX9g6pxeNXAGamAIY9/hqWT1jAbmkXHrIVJ0Q362WO?=
 =?iso-8859-1?Q?VYhBMfW67MSZeJWNoZ8/YIJAfB9g+itzUmFtIPmlWYyxunTQn9pLxDuvEU?=
 =?iso-8859-1?Q?KF8eseHBY3ItY2KkNE/AB1LaXm3x1sj7BiqyFDvGsTSwiEVUygLG8bJADi?=
 =?iso-8859-1?Q?RPMd1uTuDjo0bt/sqGKdSN/ckfoSLKBzI9381+cQ1J6DKxGn/Y/lbPUAY2?=
 =?iso-8859-1?Q?D5S/AeoTc5sSow9qMWo7lVp37Rz8Irgz83zOCxpdljJUoU3TXINVnAZxrV?=
 =?iso-8859-1?Q?mvFmb/FgYTKKdDgEdICrLCkqeCLMpSDi2XW5NVEp9DiKTPNpuRZoUsb6/z?=
 =?iso-8859-1?Q?QmwbEMHpRbp10LU+VHDxYh4KWDOpzm4OPvDupC72mexoslAqvvFY8XRv0g?=
 =?iso-8859-1?Q?ozg5G1u12+vd4pEgyIqqXEstNUtSgmvE7U7ZIIHM7E11GqAxz5pwzQ96si?=
 =?iso-8859-1?Q?xQcvoIieGE/FHzRcVcz5rmwneqSQSfVc2FdGvPun3gsXsLNq+d2XqXR7Y+?=
 =?iso-8859-1?Q?JOHLQfYcwO9KhkBKtMbCJvDoOK12poWt0m5UNBIMo6O1JfjnraxzKYmKhJ?=
 =?iso-8859-1?Q?ImLlyCpmP8JJJcwuVW5jctnmKzHeyJK29LRQZIjw0+kvSDJC37lyv7H8Nz?=
 =?iso-8859-1?Q?e4EkOBR76gefYziSxWClrOqNjGMtiGJdyDpNjro56sNnX037fWAUL919bb?=
 =?iso-8859-1?Q?OZ0sNM0IHyE8VgIqJCse7t8fto2/6QWeAsvtSzL1TL6qOMdtn40Je98RAO?=
 =?iso-8859-1?Q?qhEkJe6NwV3LDVpWSLI5TMrCfBJNNRERGsxz3feuw/pRDVWGO6vDHLR3tH?=
 =?iso-8859-1?Q?2+AG8nyEcxe2VTTdwgefcW8k9mVYnfQHG1Rn27xTysV8LTdVCDUyzpw41m?=
 =?iso-8859-1?Q?8dl/dFsUv1FYeLOjopnxfWiUTQewkWIJr9KlCD5IK+S62t75ODwIPy8r87?=
 =?iso-8859-1?Q?bW4AWFjlgCD44gvldv0kVzRfvbAxBaETgey+ImBh77IeqE4cFQhaUkWzjx?=
 =?iso-8859-1?Q?Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b9bx9j4+o22g5kH+2PuHmHIPTY0XBTvkZ8y9bm1h2Un8HxX4r7mKc1NodF?=
 =?iso-8859-1?Q?lfoRgzauCAv+WJwkqJac8cSY6pfqgczdff4I7WbrMNupwL85hSCIqSiKng?=
 =?iso-8859-1?Q?De/zBsRxDtmAMxh2B6ZcvqxVIqOX5oo6mTevlc4I4ewyhQEImGLa8A00WS?=
 =?iso-8859-1?Q?9nRqMwmcdM3bGAavugEuocjabldpcy0YljXePzM/xpbvQUDtG/EDVhaS7C?=
 =?iso-8859-1?Q?BanbJcRX7SNHqWFwqRqSB/2NjwKbdBw1E3lS9Fpn4HO1siXMszzF3RqvH5?=
 =?iso-8859-1?Q?7Kvgvna8z4k+WNIJwCMldXmB7DmJVRmL0uKEqwYZXu8QbkmLJ1BxC8shce?=
 =?iso-8859-1?Q?fhVfuVIuRz+owunSVVELpocZaP6vn699nvPeGDh1MsxilmNtAAe2KR5K0c?=
 =?iso-8859-1?Q?7SvFh8UAhdthk5A8zcjcksabXoU2rz2bPq2Z6keM179q0oxq6jes8bTm+l?=
 =?iso-8859-1?Q?YLRuheevakzsBK2KkDKgR9DdLcaV6PHNBbpY3gVBn/oFW+H17b20GOXevH?=
 =?iso-8859-1?Q?ObIL+5wpGFTp1cdK7qBgj1i4vxtpVG7WhX7ZhU1F6oQoas9KIx6bLGxILd?=
 =?iso-8859-1?Q?+okMPE96rE4l44H+FsTYyg9ka+Gy3jaOYdfkSCi1M/7lSrFzGt4sDHZuKb?=
 =?iso-8859-1?Q?MehrIB+vWdd/Gn2GTGDHLmPT5CDAoRn716pHTNf3d/grbwlRNePJbiSv/Q?=
 =?iso-8859-1?Q?sGfsYEpy7E8cO9pyr010R1LQtnFTRCH35uHYDJKcTbVS7rC2xWR6ehC/vf?=
 =?iso-8859-1?Q?mMbK4jNDe4it1WcOXPbzBJCGQlotgvTai0v98zy3kMeTwMuLr0rTFHVMs8?=
 =?iso-8859-1?Q?1I3V0avqcQalom6TLV4xERxkd/r1j2z7YgfLliU6mUfF0WuV9NJXlxY5oq?=
 =?iso-8859-1?Q?e/JZGeFCZ8LDJkI8RoYC9Pg3QZVtenrIXvhkLS0tDwXBmcilbx+Mv3v5dp?=
 =?iso-8859-1?Q?OUHQZ8QeD0I4O1p7YNl30LF+HdR9arqcmnHiwEfPQZ+KnFL5PDQ/eWtGUn?=
 =?iso-8859-1?Q?MSUf/0/W5iitRXYiwcYogRP9FGyAaBQ8rRnOvAhlXIveP4eRNrtWOlL2Sf?=
 =?iso-8859-1?Q?vIZXnIbZUfQFiLWJI7QoOEzwC27NR5L2xKRDBwULieFyWlDa2HbMIv4Jns?=
 =?iso-8859-1?Q?9K8O9KKgNpFJDRbGZJCdfFUfC2ju+HmPMjaDYqto+oFGa9xdCZe0hGo4RC?=
 =?iso-8859-1?Q?F1j3CGIB44DFWkVz0ItabhX7mUfvTuyOXHYH4cvw8o38XvTqzeyKsvXXNv?=
 =?iso-8859-1?Q?k2Yq3j1IulaA2G4mm97eTBoIZxVoTePiu7eWZzWDGFBMd+l+gW6GS7yDvC?=
 =?iso-8859-1?Q?LT/qNl9mFWNI7+Zes7jzMTzL7UKfE427qLMUqevxcGmunL5iqXn8mcOiRa?=
 =?iso-8859-1?Q?lN01S+Y+NiipxWcjR6Ty+T6YXkr1IH0alIQvUczhNicuWdQjoMajx0c0hO?=
 =?iso-8859-1?Q?X1tYv4N1bhqrH4FQuiA9N/FZgUB90sPfp2p0wEAyqBwa8v849RR/No3f2q?=
 =?iso-8859-1?Q?gerE14tTK8fpHH+DIEhFh6wjLmrL8jmSN3M/Y/O117aaZcieihnO53K0wn?=
 =?iso-8859-1?Q?FYfdie6PSajbS+BnSLoHih24i1fJfdI51/KGjJQLtaQwIfg8sCwpRD1WG0?=
 =?iso-8859-1?Q?Mb3FlEASiHNzZxCZpV1bxlTIGN5a3cK2uC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510b7795-bc62-45c4-bc5a-08ddaa5471e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 08:29:42.1224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TeHODi4JOgN2C9+bDwu0L5z8JGLND9IsSl3HYXpXXzc/1s3YbzotRlqBnirM8b7yf3npXReYosYLQLAWzttDsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3667
X-Proofpoint-GUID: 4b8ksi_FLVbntuotz0A_WYZe9JV2XaWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA2MiBTYWx0ZWRfXzXMEE49v8ycr
 J2ty8LKqqmJM/7qde2bABNdZRwO+ZxFKIM7FaQou9wXJPJAiDt2WhgLsT/81vdOBnzdN0C9Fs+T
 6iXODhmy29wKEVASo83ZaZ76pdjaL2YR7Nkv2ZZh6KFV+PQ0s4psXqFcx1JTLZeA+x4gYY9JEqf
 EQbl8LiiGN8ZRbznFcdB2k+IvgGkLk7fTZlGPv0Iqhnyk4tGzUIT1gVl5d2wwilodf2ZAP/Zl+/
 8/ZxpnR9ZGjOfWvqYkRpjA86OioogNGmbL4brZFLJo9Uk00TlXQ7eiIWvZhOQvo6QNOrxjJ3DRl
 4OdutFnR636Tn1PpUvaNjcw5f43K04GK5xdfB+qc3VGG0fPlOHa6JQllsgcYn/2dK8srg0oGGK9
 D+NuDQkciAsVVLM0+k8dswzs9hW9Ah7CaRFcOfUalNWJufSKCX6mzfNFGAsFJmzDP12e/FLb
X-Proofpoint-ORIG-GUID: 4b8ksi_FLVbntuotz0A_WYZe9JV2XaWO
X-Authority-Analysis: v=2.4 cv=G7ocE8k5 c=1 sm=1 tr=0 ts=684be179 cx=c_pps
 a=QxEc4wFvC0dhPryvSPYUew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=ag1SF4gXAAAA:8 a=cTP4V9fRfeBEuSAnH8UA:9
 a=wPNLvfGTeEIA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
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

Minutes of Technical Board Meeting, 2025-May-28
=A0
Members Attending
-----------------
-Aaron
-Bruce
-Hemant
-Jerin
-Kevin (Next Chair)
-Konstantin
-Maxime
-Morten
-Stephen
-Thomas
=A0=A0=A0=A0=A0=A0
=A0
NOTE: The technical board meetings every second Wednesday at
https://zoom-lfx.platform.linuxfoundation.org/meeting/96459488340?password=
=3Dd808f1f6-0a28-4165-929e-5a5bcae7efebat 3 pm UTC.
Meetings are public, and DPDK community members are welcome to attend.
NOTE: Next meeting will be on Wednesday 2025- June - 11th @3pm UTC, and wil=
l be chaired by Kevin
=A0
=A0
=A0
1) License Exception for getline() Function in Windows EAL
a) Stephen to communicate the license exception request to the Governing Bo=
ard.
b) The Technical Board agreed to grant an exception for the use of getline(=
) in Windows EAL.
c) The Governing Board subsequently approved the exception in a later meeti=
ng.
=A0
2) ABI Stability - Key Considerations
The board had a detailed discussion on ABI stability. No final decisions we=
re made, and the topic will continue to be explored. Key discussion points =
included:
a) Proposal to extend the ABI compatibility window from 1 year to 2 years.
b) Evaluated the feasibility of making asymmetric crypto device functions n=
on-inline.
c) Encouraged use of initialization functions for public structures, acknow=
ledging that full coverage may not be achievable.
d) Concerns from consumers (e.g., OVS) regarding delays caused by ABI chang=
e restrictions; suggestion to consider multiple LTS streams as a potential =
solution.
e) Observed that product owners prefer LTS, regardless of ABI/API changes.
f) Suggested that ABI changes be limited to non-LTS versions.
g) Agreed to continue discussions at the upcoming U.S. Summit and via the D=
PDK mailing list on above suggestion.
h) Topic to remain on the agenda for the next Technical Board meeting.
=A0
3) MACB Driver Enablement
a) Scheduled for discussion in the next Technical Board meeting

