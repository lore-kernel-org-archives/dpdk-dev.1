Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03704CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 06:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B23FD4065A;
	Thu, 16 Oct 2025 08:56:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5D50240269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 08:56:46 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FHvTqd024824;
 Wed, 15 Oct 2025 23:56:45 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022143.outbound.protection.outlook.com
 [40.93.195.143])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49t5pfb5t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 23:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgYI+3pDO6VLInPzASo8pYCIY314hOmellWyLWAieJuB006xX2RkHBuFC7tgDoQ4DfyJk2NW6CcZ0zeU0B8DhxHC72cki6x7DFyA2RGkSexarNFwHcVigggHq6XWlJh2X+3MUV4CVxBgW4ilPYlrNLK31LtoAH/vK8xMb5tgwdDE2LE5gfDAmXV1bPUazYwEAOLMC0cMrcNUbyIZFYxAhoVc6fy/NwHyHukJ8nlIcORtvd2qtcMnsznO5lqp/xDaRfnwaaE/b7h7OX1/7E7XT+CvxYsiRmhLwsZFRi7u+FR30cBRXY4+dgn2JBqHrvngCXaogA7XvlFmMF4GI34mCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEIerr0oC1XaFTOSBKPjLMRyCEljWyf4FgBsiYriqPY=;
 b=VgiBbQs9WcdXh5iQAMeQxa8ZmBC8DROekGtSL8tOZ4/V6F3JkR5NYuKeeBEJUQuGXoBkHrszsZwSO7m5EJVDRqlUAgwy4mrKhpLJTT0P4JrelaaMjINgENc/8vEI6BCk8KYnG52AtVZ4a4z50bvxMwyyHT+HtVY51jPEdp0IMtFRMhwVQlS4W993VgR0it9WZGsTpWpVjmDaE/bPYELZnFa0Cb2qjk4t6uSuDKzJAD32EPa92IXKLB+wVQi0qci6TL7wsbrBK0uztxrgM7eSaZ6YXplPrPBe9ErO4pCpPUZ1RmpckoMsS/J6WKNi2H9ia6TrrUoSK9ToyBbECADRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEIerr0oC1XaFTOSBKPjLMRyCEljWyf4FgBsiYriqPY=;
 b=TLYIwqXooO1Tv2/mcgg1kS3vaOBO/kl1Ra7SyKlFq2cJTjN7mT9VPAaEF+4X1PEv9a+IsCpuJVCazsb5zHR7U8qGIEyc4zAeTKcU7oRJvEFF6PtDeMkUmkki8lBUdDTqwuxmwLsYZX1t4Daspu6DsEVK6FzGiz3ieSKIs8vVHOA=
Received: from DS0PR18MB5270.namprd18.prod.outlook.com (2603:10b6:8:121::22)
 by BY3PR18MB4641.namprd18.prod.outlook.com (2603:10b6:a03:3c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 06:56:42 +0000
Received: from DS0PR18MB5270.namprd18.prod.outlook.com
 ([fe80::dcd7:929b:416e:2425]) by DS0PR18MB5270.namprd18.prod.outlook.com
 ([fe80::dcd7:929b:416e:2425%4]) with mapi id 15.20.9203.015; Thu, 16 Oct 2025
 06:56:42 +0000
From: Nawal Kishor <nkishor@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Shreyansh Jain
 <shreyansh.jain@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>
Subject: Re: [PATCH] rawdev: fix device ID retrieval function prototype
Thread-Topic: [PATCH] rawdev: fix device ID retrieval function prototype
Thread-Index: AQHcPmoHnELC7cB02EWjW4P3KUc1EQ==
Date: Thu, 16 Oct 2025 06:56:42 +0000
Message-ID: <DS0PR18MB52705A2144204E371DDC6EC4B2E9A@DS0PR18MB5270.namprd18.prod.outlook.com>
References: <20250924055654.1986682-1-nkishor@marvell.com>
 <2509677.g5d078U9FE@thomas>
In-Reply-To: <2509677.g5d078U9FE@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR18MB5270:EE_|BY3PR18MB4641:EE_
x-ms-office365-filtering-correlation-id: ea536665-ed48-4be2-3784-08de0c8129f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BMX7drVZqiFjANM3fBzPDIiRB4ugkaTusuCwSqEhcxfajkjMgkdzQfuyTB?=
 =?iso-8859-1?Q?0pu0mSh2bz0/Bzj30iViiAGu4zwrvxC59kGJlY57Ghulm4d2BHJhVN4MPh?=
 =?iso-8859-1?Q?P7uz9lwE+gAvHHeQdbyEbgxjO08ZrSghm4P9cjw2ch1Kc7gY/PBNCScLqZ?=
 =?iso-8859-1?Q?nRTun45qB5MZkFK4qcZlH1MbimCiHM9hFaTrs1lx81ZM5EL+CMiHKEN1jN?=
 =?iso-8859-1?Q?uf08gDtMqmcmtEfm2+/zPAdLEZPmKNci8aPHDpA++qTbyX7uAxR9mtGC81?=
 =?iso-8859-1?Q?BMrWNz+sUzl6n4zJFrxczwDHyHiJA1ViMwe+GH3PcKIQf92OEgUCREMyy/?=
 =?iso-8859-1?Q?m6EK/B8gDkiafmHGAZgoLQXgsPQPJA0MY7UC/NSighRv3CsLTLaEIzo0WF?=
 =?iso-8859-1?Q?qrRikCmARVKojHeYh+Y3gXCT0obS2COeuKzkqaCENt3aEP46Zo0q+1akQ3?=
 =?iso-8859-1?Q?qoGTIcZECt27D0hWCdC7hX6CDjA2LvZaDAl8NLJ1E8ridp2O6j3Ay4q6Ks?=
 =?iso-8859-1?Q?Dt7FgTofegH4Kjwtzw7X+DMBCQqkxuRegeRtTeAHGb9ARKwPpCsclPxY0b?=
 =?iso-8859-1?Q?U15wcSeEaSo9zsnUvuZ1iJRgzlgR2+AEEIG4KJtM6vUv87QDIY+Hpu450h?=
 =?iso-8859-1?Q?5QRlecaNmX+8iZTcfpOZhHT82OJ61kYJkAmo5Dj8E3f3QW2hmlTU4TmYHD?=
 =?iso-8859-1?Q?C1l7umJ5a8SAMQ/nQI/YRDR91QOOp8N9xB2XeM3rq7ebVJUyQpbmmbaud4?=
 =?iso-8859-1?Q?H5wKC2JsGyT/+Inc3KLL9s0wf5jxNRT0D+9RFFeCkAGzrDs+pI38FEUu8r?=
 =?iso-8859-1?Q?i7+8L4nTDFCbqXxh2yseu6D4tgWusFuy6L5N8OHy8MPqR0hygT4UaqcnRd?=
 =?iso-8859-1?Q?PO+5DtSlU0Bzpgylc5SbIq5S0eWKyj/fwiwrYSrSResyZnDSxF3RBYwp04?=
 =?iso-8859-1?Q?kwrzIYR4075QuGFsBbFsV+EIAZDNfqTwVz9perlQTVbTqJQAj1yMOCX7yA?=
 =?iso-8859-1?Q?t8YU5nto3Zqmb+Zlz5kAq4dY2ETFzez6XMd9RBOw/j/rl07ToBjC4cMg49?=
 =?iso-8859-1?Q?aI+S0pj1FdIy5RhuYNaJ1XDtQaY0j1ivZQpzRnFQg+kDimoox+fcMaVmNl?=
 =?iso-8859-1?Q?uQ2EL9sP7O3MjXAjiFwv4WED2MFqfDfUlEJOH0tYpOLFOjLqYUd/h0cFkc?=
 =?iso-8859-1?Q?B8Bg79tyUWupDPBnSu8g/Zkfbtih+kVJaRDzGW0VNkzpkKISgMqsaJtbgo?=
 =?iso-8859-1?Q?AQoA2uOQOMYP3ikRuv2fokHACaMb0sX3JGFB+JZsiuAN0Sp/1vmqfu80kP?=
 =?iso-8859-1?Q?Z6IeWoPlZcD89s5icGYz+f+5vyv2wLZ7qmZ5ho8W+tOzwhvnV6cHBdMnyN?=
 =?iso-8859-1?Q?1svZzOdEUPOA+MSxs5aX6/chilxFMaYqRRWvYctONAbHczobyCCov3Jpty?=
 =?iso-8859-1?Q?T5TRm4/ACYjRZi72GuHvUBDGZlHv5Y/x5H8677+jhu05ykNUdE/JE6D4aZ?=
 =?iso-8859-1?Q?gBoDZe53M0tBJ9uATdlP+z24MqZsUiUgxd+KpkhEyitRpmsGM+Ctqz3cp2?=
 =?iso-8859-1?Q?Ga/p6G8F7AKFHSBlyX337hj2FtwE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR18MB5270.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+4oawlBxywKRT93TZOggonTCTLRHdDeB+hGOlqpnc7efwfPeeBq9Po5xT1?=
 =?iso-8859-1?Q?Kd8nk6KGS7BeJd8BxGr+NcISCS1tWXU75ekWFoL9jClyg4n9LV7Dd9GBBB?=
 =?iso-8859-1?Q?LhV/hEgmQRtHl3mIzQQ5o1oQSbspEVWQjsEVwgyRFq15Z/kBGV2XDEafG6?=
 =?iso-8859-1?Q?V55aHOe1JLmCYLJ/FHqk7MB1HO4i/1u/Kj5VYjhO3F3CawSzt/SnuEX+3X?=
 =?iso-8859-1?Q?n+QmwYlKpkHBb0LgKda9XdWVLR+NZmkZbHvoIFU60RXqLlptrmGbTNP+Uw?=
 =?iso-8859-1?Q?KHFOO1n6YUcdkrtek+hCV5mgyhy2s6xUWW95kONG2kPE57CBI3R6Cq5RuO?=
 =?iso-8859-1?Q?tLbMPkkEev7DB8q+l9a/v45mnZX4GmIcsRZHqhqxohdC9M9qqO2c1KCZya?=
 =?iso-8859-1?Q?F80YXw6eRdxSO3V6k1hWSZNjk1WfsrNrWISNO45PYG2SXKkMcqB09icim6?=
 =?iso-8859-1?Q?ejpCnBsAmT+AcUe7anq0RdK+llamv3KRZkGtEby9p5IbAOLt7hQkrZFdMz?=
 =?iso-8859-1?Q?oF3N99NOODN5xaLkqOfK6RXI38/Yj7A0grdT/8RtGYMhVN13LZb+7ZP8iB?=
 =?iso-8859-1?Q?yv2Ob+WY82eU5Gz8bwpN0ZgvkuvzBusSdEO7AMAdtY9GYgaaLUt8wxf3po?=
 =?iso-8859-1?Q?S9neR/dgAbsjsY8YQjN/GcFBu/vSfxx105NvQIOEYGZjSFKSIkSoJ85ShZ?=
 =?iso-8859-1?Q?QAhd3OCfasbTdfp+QBWmwy/563g1pJnKjg7TZwl02+YaWHZA/T+oUmHH8Y?=
 =?iso-8859-1?Q?+Cum68epojeevU0vzNw7OnTlEew81XnmQj9AWVOqAy3hgktotPqyOp7B16?=
 =?iso-8859-1?Q?FhBOry/vf1cJyVYxPyFW+8WaDJl4eBPVTYTot7mLz1QaMoCGmutyxNVWeu?=
 =?iso-8859-1?Q?cD/j9BFVc9dsDXFJfmjF1YIOf4oTKsXOg5sKzg+U1Ejs7dvO/lqN53/4Z0?=
 =?iso-8859-1?Q?sUkKhqqY5XfFnUZTaugSMPeoeL1SvcYZcQUaKhVRsX98XMwnDDaQr41upy?=
 =?iso-8859-1?Q?mh6DysVhfSEtdf7xAc9BNho6yXZCiMynyart25blHi1miGCPpSeLDHdbgw?=
 =?iso-8859-1?Q?su0QJm7hyxzTJyHvKB5Cf17JcDOFmrgGaTijOKjs2xVAsBt4MoGMTbLHmi?=
 =?iso-8859-1?Q?Sq4lEpNrX+5ixZnzU0LKyjuXv848pHqWUCqmz4odVU45vI4u+3iY3jp05D?=
 =?iso-8859-1?Q?p0tjg7aUV8alfR/BGomVeMpHKS29aEb7ZPz+xki6ZPOxL0c0Z+V5fgMYg6?=
 =?iso-8859-1?Q?0mbkCESL95G4fZUp/JEiN1iyU0/YGw5dgSMCSEjM0UHL9Tkpa980Zd05T2?=
 =?iso-8859-1?Q?yRF7xRee36m8Fz1JOAxZhG5wEdpdDs+nkZaa2F3OrQkb7G9J9h85jCfZ5z?=
 =?iso-8859-1?Q?hP339mKGJdpSBtOlggtCIYK8XJ1/+aik1FU+6rZhF8PuZOxck3HEW64YNN?=
 =?iso-8859-1?Q?M/7+6NMnbzFPQT/41mFid5crAyUE3FP9lNNMs1Syhs0b/1XrVe0Hxwg1I5?=
 =?iso-8859-1?Q?goYS8XCWsh5oFiyG/YWRn7fcmTOp+S/wkL1FayxoAFzn6EJCnbWuhMYh9X?=
 =?iso-8859-1?Q?DOjA3efQTMpcImNqfqKS0J7FDi7J6QzEOniciMiLR5kwNqQTx3BNPpSWG9?=
 =?iso-8859-1?Q?wlXn2yJ2029vE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR18MB5270.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea536665-ed48-4be2-3784-08de0c8129f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 06:56:42.7518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbZUuUqPuBuwrXPmtdIHtLv+gzyCBrLS0cLi2tLbaZeoYVXPKCOTrOwuevFXGRT9k7Os+KTKN0WfUMcuTPIAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4641
X-Proofpoint-GUID: zA86MkShuIdWj5IwQp-D1i_R2KYryeP-
X-Proofpoint-ORIG-GUID: zA86MkShuIdWj5IwQp-D1i_R2KYryeP-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE1MDA0MCBTYWx0ZWRfXwiGpDEj4P3nj
 8qhWapdafYNis9yWEwtZFwN+iDG3322+6IHSHDmvmdYILVxvgcRwb6o5Hg5EObiSuAjCmqqnHDL
 ltfm2VTNXIli29yb7cmM1Jrwo8X5yHuWUHHR0icjC/sYRXmnFyE+o3LRfwi6HNyFJe3XgttoAq+
 hc2Jaq4/hWF4obBQ3RpXxiRheKUyyG3myGCU+iu1WS0bpfT3qLy4WqBwgGftTm36+lXaingpnoF
 Swvod2rFVYUAHhFoiOXoeP6M5mmD6IzsvRf+W6dc7qLoBlOswX+kCN/hwXUX39pH4OWyv5lm83m
 xXmzcHhE18JlohoxoGEhmjmkuuuLfaQioKjdSfzntGS1iH9TQecwgTqhK+MspEUKfcunS/wPV6h
 ocri/eZ0TXzTULXHGkHjUa2ZpRCSiQ==
X-Authority-Analysis: v=2.4 cv=Juj8bc4C c=1 sm=1 tr=0 ts=68f0972d cx=c_pps
 a=ZgU9I8B0O1PKiENeC86Haw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jG3QfLYGZn9O_5ORLNgA:9 a=wPNLvfGTeEIA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
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
>> Fixed rte_rawdev_get_dev_id() function prototype and its usage.=0A=
>=0A=
>What? Why?=0A=
=0A=
>[...]=0A=
>> -uint16_t=0A=
>> +int=0A=
>> =A0rte_rawdev_get_dev_id(const char *name);=0A=
=0A=
>Other functions handle dev_id as uint16_t, so why changing this function?=
=0A=
=0A=
The spec says that rte_rawdev_get_dev_id() returns negative number in case =
of failure.=0A=
But in the definition it is returning uint16_t which will never be negative=
, hence changed it to int.=0A=
=0A=
If this is not acceptable, what fix will you suggest?=0A=
=0A=
