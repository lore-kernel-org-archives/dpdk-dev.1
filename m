Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1431C98317
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 11:53:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B603E400EF;
	Thu, 24 Sep 2026 13:53:07 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DA208400D7;
 Thu, 24 Sep 2026 13:53:05 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5eUGH2060990; Thu, 24 Sep 2026 04:53:05 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020110.outbound.protection.outlook.com
 [52.101.193.110])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gvkhhbk09-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 04:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wgbv82JiYWAplVhDpTlUcIRUVa7uGJGrbYbOYon/0r1l6aimTG+qfZh+9G1V3a4Drp/o/cGHpE53Xj2p9KOtINd3WaZeQA9ZO8s0rSjX1SueEtjJ5JRTEKmbxKNORPhrJt0VH7yzeCtF0HM3zPleHoDJZOKHKJSTqyzIGkV/h5EzHuPgSMJBkP7Q/rktkX0bO3HKFQ33m0gqtMDcezsNHvUPJQk31EnzOJNLfJRQSDq37OYjfuKCxfXtHP4ToTcnt90cmnkolnvGCCS9q1EkG5LqZB4XNACpFK/cShh3BZK3MQwKnAVy5eclHxpUaVSDQjXUsXhtW7rEhdzMF/g75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cteGo7cSfk26Xkzbq8jUZ3CoJno2LI0vk40xnUqCJ+s=;
 b=UDzKW72A5ivHtbbPBo/N44/0XFNCZPA3WSLPT0r9M/+yvFPTvL202RAGa6eib3EtfvQ1ULMsWZHqCkbrUr0m+cx58vX+7ESjAKrj8lepmggLiBLwVXZzozwmSUwQ3hAMVFsOXTn1UWYORkVwXCpslWOc/902n6DMN7e1pXjWLBJdRF/Ynr9iHws9XE2keFKq07RBRiAgOL1ZUo8JbqgkmCaBfG9QFW0qBEJf03zU15sJa86XUbz8Jqhc1wPlZsZ6xeMAP5UgYm8sZ9vrQwQLFacUDD/HWdjhl39AxEq1VNJ6JQFr/clpDKGCsaJffBTMgq1f5Np3oirQ2L/e130N3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cteGo7cSfk26Xkzbq8jUZ3CoJno2LI0vk40xnUqCJ+s=;
 b=g9iletsboNbUX9SIT1nPXbb/ajnmQoQycilWeOc1fLIRo3nE7r12Q9TR07fvT9bUy6/njZctcw4hwtURxLweSpXm6f/Pjhcfmpb2YbO1rBSQcAIcJp5wiU77RvLLmV7TR3hJ7ApwO8KGpXzUhfvzZmT9aWGNpTVBswGpN/fMZZU=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB6325.namprd18.prod.outlook.com (2603:10b6:408:271::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:53:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 11:53:01 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Aarnav JP <ajp@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, Anoob Joseph
 <anoobj@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Jerin Jacob <jerinj@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>,
 Rahul Bhansali <rbhansali@marvell.com>, Aarnav JP <ajp@marvell.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] test: fix 5-fragment IP reassembly test vectors
Thread-Topic: [PATCH] test: fix 5-fragment IP reassembly test vectors
Thread-Index: AQHdRmygYtZRSqYEm06PT7b0m9SkzrbdqY7g
Date: Thu, 24 Sep 2026 11:53:01 +0000
Message-ID: <CO6PR18MB44844BA8DF74295F7846369FD8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260917061902.1299400-1-ajp@marvell.com>
In-Reply-To: <20260917061902.1299400-1-ajp@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB6325:EE_
x-ms-office365-filtering-correlation-id: 7580da56-f185-4c06-ef6c-08df1a326266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: MMq+eaWfres3goTfM2SztPwEqREsGa7LdjYaVFmYVRkV4U/y8kmCxFj5chazsJbnaJwtA/+HBIqE/KiEXFeZqql79ZEYmVFfJvg3zxSJrHvcoSTnU8oWsBgNL6BBVtUs3MfJggCgUr8watYFq2r9yFlT3ASx3GRrutM/zEIeXBjCU7+MHejucUxXDvIz9RLA4ntKcqSo0/5tZACWoOYOm3ETyDDfBISuaWsx5o0S8JcdlFHXhfW7yZZCvsiFYyJ2j3Z9Oin40P7WndLY3JjBxFhyqyRGvrB7ajxi9jWqC4lOjLyJyoZbX/5LBEVDUFkGXC8CL+FNc3hGR+PjzsvGm846P3BZ1ZmI/tNTM26mjgqPt+xZhqllAy2YQjUbKIwdCO8xlIyZi/R+U6MBl+sr+6m/yGHp15X2SyQDwvvh5IQtTfl/Wzsj9XVLTe1jUswCNXIH8XDkn6ho4mXx1xeTcY9+iHXjLkZwPTCkDdAGvh6x1rLdCYj4PvFWBflfl7xF6zjguyom8IWxDTfY5z2beE5LjYNPkmltFh9fIBgeNAax+4j6mnaDumvOJumaO4j0W45DAUtbl+sp5VYp8xmrh0SerFa/V/BWttqB/qlOFoA56tMLbJ49Ip6YON3RhseNyDTZConA6Ic+RcznGV8IN6ogWxKqsLFMkXzcpigjP5E6wWDpLCub0E7C9d0w0za6MPcM9z/+R240XVhEGj7CQFc8jIE3kU4jPkVKTQ+bb3Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9m5e5fRO7ruyYhe0lLrmR8lwif7eMoJPoDvd83Z7FS/svxpKqVj6FoFpax/f?=
 =?us-ascii?Q?V3eTCTeKHnmRNyayhV6qPPTV8VrhBgRSOJjmOlUxM5EVkn3VJaU+DZVV7Xd3?=
 =?us-ascii?Q?LWbXeNoIPbgrRBZykONvNVspE+AZHLxzZd2KcBo2UnEens0hNreVKMDCdGGG?=
 =?us-ascii?Q?pIUW3n0PIlX3b0SzqdIWWirZdt/QpHPXVi3XTvrgyxmYbVpSIQBTivCw32am?=
 =?us-ascii?Q?btUstVyVoO/K/IaNjmAR4j882rtDEEqsWNmZK6rhuNNOXoZhGjkQQlacB+LM?=
 =?us-ascii?Q?5hJ8dRegeu5UhxSJDj91Eu4RpkutEfvE6yzejatQxF81hp5JCCWIWUlfzfXA?=
 =?us-ascii?Q?fTZ1OPEocsk3pK4U3YvebLUhO0Q1PrLT1dsDiMv4a/ma/9ihPATdXfXcmOil?=
 =?us-ascii?Q?hU+qaWfIg1msjW8vafOWM1j22HS9vnTo72PhVZ+/NJVrQ15ULsZJ6P6lPmlb?=
 =?us-ascii?Q?1JE4jz2bpR+ZM8VktNyjMMLtuBwBJLjppl3GSi4RsvpEbArumF9T43ivNqFd?=
 =?us-ascii?Q?X5s/LWN7PnPZK2qXSZdEa9qCAdAVCkepzrQaQbqrO4zGsWMgzfrWEnJYzJL4?=
 =?us-ascii?Q?/FdY3ZFm5ywU9/UdjdmOyxSOK7AX0AKwFkrKM2DKSMPTBx0VTomaC066BjQt?=
 =?us-ascii?Q?v2blSFhRNiSjKxlmtIgrKlKDpL32ZUDPElaw9vfChCg0VMLb/I5RFmXdAQin?=
 =?us-ascii?Q?VC9DNeAlxZKPf4Kpsj1q/1fgPiWkKhAKIzyFqdcdSGmUFbHUdVrwJi7iuq4v?=
 =?us-ascii?Q?jCQ6phWSh/qnVhlTacoTxXhnvtQ1tukAy9APf5AD8ZUMHdXI7R4eKiXAIBMB?=
 =?us-ascii?Q?4w4QKD8Vhbf8C3xT+v7FIpTvXu+aIFmDHS4gfqypWLwpPkMcD1AC1IQ0Xtsp?=
 =?us-ascii?Q?bU8aSLkXOCX9GlDnKKEVrp61+JtgxfX0UH7kAUTHHXZORoiS1wV8Oqr7/Zfh?=
 =?us-ascii?Q?+25Qz7QFZNkHQq6tOUtC4+d/8wWA9Eb/GuhM7bNmvRs/WMeOiTHYdST+J+eA?=
 =?us-ascii?Q?LP8FzcfWpDqdugFapMkKaxjEYBhYiERtDngtj4GOm3eX2alZHru35rjvtC3b?=
 =?us-ascii?Q?g2v5ltUWcOA9V2KhCx9WlGRsv4nDw2XGqHaKPyq3ls92be1pYQryeDvvHJPx?=
 =?us-ascii?Q?fX+RyB5erTg4Rkdn5Cqscqf4PO5ISJ1YordE4soD8sVYxZRCnJc4RP1abtFm?=
 =?us-ascii?Q?oL5DioDY8Q0C1tzmjsj5qCEo3Foxle2XklGhyqwdajOYLjtMbg+RRbPc1g1N?=
 =?us-ascii?Q?OvIgF9a0+qUR9NTjApaZN859Hj+4OfjEULKUPhp18X4uPDAvGGnR1K/SkDb7?=
 =?us-ascii?Q?8K3NjfTBdcQALCR2TnlhNN7I2nqFfbai5B5vi4p18WfVDTlTxgArB8sJfpY6?=
 =?us-ascii?Q?iP2HSh83FNI1z8tuRrZf7uWdvS5tfUue0/Uxupph2dTYftof+eIntZhP2dpp?=
 =?us-ascii?Q?PrXeR4O+MCxRFYfsAX1ZkOUfyjk05fvzgDj54m+vVEcI9OqMwbQnjhGj8+9N?=
 =?us-ascii?Q?gey4DfHX9MGtpTJi5UJnWwL0BhVVJwImJzbO8nhpoZ6WFlRVdWf3ZqTMU3Rc?=
 =?us-ascii?Q?IkdTltMAO2XrodPeDpKdp4Kxi/SDP6R4it7V/FTuYXWVL0aBZvcfMRgnqKq8?=
 =?us-ascii?Q?fTbbfKXQ/CLoY2RfpSOL7cCTPdACCoTHzMCFV/0a7ybopJx1JiiR5q3rSlZP?=
 =?us-ascii?Q?Eepfa2T5IpvRbBTbGnk19iUW82bV6NULdK0FWppcFNOwrhFE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kvlSgQJDzd3IKY7UJ+n2PT/DsGdVcfwB2zJhZ3HilYvVaFS/w0rvsePjzrX4RxkhSfJXiDRjdBGwrzkt3ulAYWdryAjf6pTtQPRrh1hqA8oLDnVsq5XuZ5c837TN4pwjQk4NxUbr8odcQMGyAspth0A0Gmd/ZbKSQYIqoMg2lx6s2taWRK3bTsxCMzk7z0KzyzxqXrq+QDYO+bhzYouCwjDW/DrEYgVr79+vPy4MpmmYQdaTKpVZU8+Ga7858hgGDDfDuqK7HieM4v3SBwSFje/pfLCmvwpvHNlT1QZYf07dBL3tkEh/qMhf0IBXKdizeec1rUPOU1A39ScTrN7U0A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7580da56-f185-4c06-ef6c-08df1a326266
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 11:53:01.1392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mFpccfaM+AS4WaV9TV2zzKNIX7uMjclkqGAu9LgoGMiSTIHYD/hj5+RcLQgUBS71DAKCkHjdOadTHsXbDmrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6325
X-Authority-Analysis: v=2.4 cv=ePyGH3p1 c=1 sm=1 tr=0 ts=6ab50f21 cx=c_pps
 a=pY+kOdcf8RAo0+yonGAjpg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=pGLkceISAAAA:8 a=jXA9ix91lS0jXkGZk2AA:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: Ceb9NeJjArdJR-otWy8ujB9uQSWK26mp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0OCBTYWx0ZWRfXyaTsNpcw7D46
 4Q8ftZa/6vGuZz38pjRwTOwlnQzZvjlASYZjDbN7jS+cYUGBkDuHM7dKSzNezqGD4Fibrg5HLzv
 JVHphiHwDduTBtucl9DUKzP80Ar4Uko=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0OCBTYWx0ZWRfXy0BnwQp9wL23
 1uWltTYszqnB9JUd4utb0TaL1G2ufTs2tp9UiZ/IkKc5OO/bUfq2BNjKJmG/DCr9gkIv90j/wcq
 fPa0YzJSqTV2qt63tDN9vcjp3eshmT6K1tBxPr3fzk0aAptAyCDuP565qvIOftmr0aHeWxnKEVE
 WwGs1c/bBUgSmZD5w/DWLc8GBrcQLzGRgL6U1oNOVs1FD+hJRHaEiusqcq07usXza7ZDRo8sfph
 kb2yLbpMPCca9x0L4KQ8gzIkeuhUiA0Z4/T40/l/cS0YuLLKdU0yfv76v/W1BD1i5gIr5UovV10
 aEmeAw/Xj8s6GZOStBbfSjxH9lRftM9nQyFHCaRDgzfFhlbZkF5yfCps50Oxo5bkfCn7nN2K58g
 6ANQYuQfQlhQzwbMmXhBRemItNCkMzhw4kX4TAvLaknhkh8yUxIcc7Zi4JxhWMK0L+/mbSoCQq/
 mwRBth3rm/XXLkshwpQ==
X-Proofpoint-GUID: Ceb9NeJjArdJR-otWy8ujB9uQSWK26mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
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
> From: Aarnav JP <ajp@marvell.com>
> Sent: Thursday, September 17, 2026 11:49 AM
> To: dev@dpdk.org; Akhil Goyal <gakhil@marvell.com>; Anoob Joseph
> <anoobj@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>
> Cc: Jerin Jacob <jerinj@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Rahul Bhansali <rbhansali@marvell.com>; Aarnav
> JP <ajp@marvell.com>; stable@dpdk.org
> Subject: [PATCH] test: fix 5-fragment IP reassembly test vectors
>=20
> Fix UDP source port bytes (0x80 -> 0x08) in IPv4
> and IPv6 first fragments, and fix IPv6 full packet
> next_header field (0x2c -> 0x11) to indicate UDP
> instead of Fragment header.
>=20
> Fixes: a310577766d6 ("test/security: add inline IPsec reassembly cases")
>=20
> Cc: stable@dpdk.org
> Signed-off-by: Aarnav JP <ajp@marvell.com>
Applied to dpdk-next-crypto
Thanks.
