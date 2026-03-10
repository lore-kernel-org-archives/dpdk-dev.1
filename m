Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D60FCC9C2
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 05:49:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2233402B8;
	Tue, 10 Mar 2026 06:49:46 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 899A74014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 06:49:45 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A36wIC3464312; Mon, 9 Mar 2026 22:49:41 -0700
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023091.outbound.protection.outlook.com
 [40.93.201.91])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4crj8qwrps-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 22:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsK6z4EttP6Rrg5i2lGzBQn6tbfs80lAU6vM1YwwfQiX80LjRtHgFykPTg9m1b34VFWZkcFoU7DBST9QXJS4kDovTqsZNk4TEmEenN0krE5FCTwvIkuYkvyrSkGyiAGiFJKj0WbZJr8+i4ecp9tocap+rsk7H3sVBBjLoofyKrkGmM72IBPlJOmedVkGSLECQlCbzt58iOhNqL+aQiMeHPNJw48XkR79Jje1sLiGObxZK+55MXbOxfv9fFoh5+ZzDjz3cXJKKjXg32nuB3fxbwwkVZCwUxvcGzpQZ9k/bIwcTN1PrWgkMuL9oeVM/L/RztQSlTTgW3+k4clNBF8z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTxIRBYG3aA5xxIo/yPgsiZ80wDQAtMMM9vXjkYpL3w=;
 b=yAAG7GQ4EXHLtOb7RfDS33lqDGhrEnHE0I5cuGm9X1QsLlUQom4W8kGHq4Yd3YPacbks0SFzG+8s6IXrm4h4qa5SvzZ/MINvPNVtPvfY8sHmtkewz8uXflehdMsu/wgIBUEOlkNvX1N6Ly9fJBOiQg9VanQBjIKFfw5feV6QPEkNCShUrwT7Hgb5HHa8s9Uvv+CetrNPkuvtCjA/7TMokCsebEbJw4NDPx7KNtTC4KqvBdjGcVMkKCtF9cu97kmuO3X2Qyc/cmzfsREkrlvoJXvCGzx3ekGfo0WWT3IrfahH9D2sqm1hBoDK05P3osqzAo+TXZUy2Ebei9nw9iiSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTxIRBYG3aA5xxIo/yPgsiZ80wDQAtMMM9vXjkYpL3w=;
 b=ku2vP0aXABdK4y+KXi/usfgkv4g3ZZbWFq3esBRh2ozRgmg1G82yG4xksuitCZSNmibHeeCLaQlC41P3kUS6gvLNSed4Cjm9odYT+PDtLojyyTtgCNDapAnvxz+q8zCDr8Ps+o4OElpiqWcVLV5U2HQSFVxoRvk9CFbhXLWMxQs=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 MN0PR18MB5973.namprd18.prod.outlook.com (2603:10b6:208:4c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 05:49:39 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 05:49:38 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, Jerin
 Jacob <jerinj@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [EXTERNAL] [RFC PATCH dpdk 2/3] graph: add deferred enqueue API
 for batch processing
Thread-Topic: [EXTERNAL] [RFC PATCH dpdk 2/3] graph: add deferred enqueue API
 for batch processing
Thread-Index: AQHcloGlHl7aDWZO70iwienbG2jXerWndV+c
Date: Tue, 10 Mar 2026 05:49:38 +0000
Message-ID: <PH0PR18MB40866DD3B357CFB24F086963DE46A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260205092630.100488-6-rjarry@redhat.com>
 <20260205092630.100488-9-rjarry@redhat.com>
In-Reply-To: <20260205092630.100488-9-rjarry@redhat.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|MN0PR18MB5973:EE_
x-ms-office365-filtering-correlation-id: 8c68d437-6a8a-4ed4-df2e-08de7e68d16b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: rqZ+PNfyEyd/rdKMo0tFP8SmF5hvyEg68outcABw3SCBZZTFYal77M7M5xS1LWx7Z0dGK6taXLzgaCQb/WkZjbNlM4x8/QUeR3Z9A4fFe10XEWaGjSj81UZpSJGvIzB2rrOXJjbfR7C+htBDGGxQD/vYxpVJsvDteDyz00suwxAPoJPvKpY9bvcgt0waewULPUlQs6T4OW19cs+SnJ6774319N9sKiIOOVsgFETTh6tpirAQOIcdz7A/WIH63rl6e6qzUahDFC7P9q/c39XnYyMDWXYg1dMS9oAPIFwfyjhuTyQTUTttqMinlkxXp4XngkxfD9THxgDDs48LfKhTIfp+dGoBMZS6OmFoqLiUvq3SWGrWLmsKVrOXSGIuHwzZLKzcyEslsu7T1srNi5Ykrcyvcm3IOk0A4ecqBcePEOmxqOMf4MCUnUgqvSRVRgR4n8+EO/a6yvav8s1cPvsvUI17iFWZdvupAx2aObz8ob4jzNWnu234k0yq9RhZSX32l1/CEh1NM8Ya4NmNcm97RrBLpHd1dxUJ9Zk2Hb3a+fjeR7zQi+sXoe54tV0xi7gQk4XwPHZ/+CKmwDZ8X3vl3QxlFRTjNOr8NML6o4BK1lCUN6qCqA8B7JN/g8ljxcFavBMihHOipShAXSIeR0rR5G/g8ZQzVCJEBRXlmTUlKgQR2b9OMCfiPj/bsy8oGQg2QNFuMhI3iZCionDciMDgWPR+MGG+gAYYGgHZpR48T+HVAB8Ns8R0PjjGKtWBJ+GQy+ny7BZctR+K01IJW3zClLWe5iog8VfXe3KF6VXsrkQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+AnlgHKjBtVtu+e5SgLrzRwcFCJAd5h9CHF5pnzBDamy2AH9VXNQlep14t?=
 =?iso-8859-1?Q?9l/o87P74FlwQqqB4eryDaDU+ttJZ/1+A8hLxW/3Uds98GrAGBwHk8l5Xc?=
 =?iso-8859-1?Q?Ma/bOjo8L/nFCG/ML4avqhQDYMOonEo4vmqXGHcfcKGKHnSob+QZX6WlPU?=
 =?iso-8859-1?Q?Pa231ouERDtozNJtv2j1ukxPehcDMzeLWsnKHqGD1RlSxL4h+rb1YDLOS/?=
 =?iso-8859-1?Q?epl/7KN8I87xrajDQvlF98odsXSsBVknPeMjedAjK47T02lVFh6581Eaug?=
 =?iso-8859-1?Q?j30IbPNCGEVeiFQyu4cyLQgENGUgEoNfpjy5zFq9UyFfb/lzMYjCI5nie6?=
 =?iso-8859-1?Q?oKFplEpYC+n46I367NVc3HCEahywdsMakQmo/DH33F9OAhQgDCepK7zaVk?=
 =?iso-8859-1?Q?QsjvseJs2RaCtjrZPeeC05HBRxUkUdQyk1UXcxsvEH+lcfMqAvwN7ypjVz?=
 =?iso-8859-1?Q?TVj79vjXSjmvkhaKyBr7SFwNLh2QjJOGNh1C3DQcKXZ9i19y2AG2zZ9+JE?=
 =?iso-8859-1?Q?bvtSLOdeTm2XNb5WA2YcA5Q3/6AA7SAmGp5ixsS83vkHZ9Jn4B9any2Lfy?=
 =?iso-8859-1?Q?C2Jd7Aq67tPNW2Ehx+fCMWG/IC2FqdKmiNu3VFyWWrHB123pHHcoc5MW8A?=
 =?iso-8859-1?Q?825554kmjQbHzB/dPn6cpMGUx3BT7o3IXZJSIrEVdw2/EPzU2LjBU+hW0f?=
 =?iso-8859-1?Q?SCjkeCjaCF/R/N9qFs9WuMoA865XwEbEC/XNZLTMuGYjdA0OcvX0Vtfk7s?=
 =?iso-8859-1?Q?cZ4y29/PUGCpoYPoEpvJ4bzAqd5kT6D6h9Dm8E3siKww5x+bpcGymcQp9o?=
 =?iso-8859-1?Q?0FYcFO4ExEobzjmsLKz4W/kctdo1nGv7NTyx5J8Oh3YGh8+XeqwPADwZHS?=
 =?iso-8859-1?Q?p6Z41Qd7YHv2kAkesYa5qUsSU38cG+J4XVsX5g9xzQJR+9c1FXaMXm/Ip6?=
 =?iso-8859-1?Q?2NgaKFUf4KBpaTRf2sK7YWGMwTzO3Pce1+3IWK/wfInEuteVYQ/GqViJKh?=
 =?iso-8859-1?Q?vn7TnLjjJ7xqS+O7SBkvMSS6pG3Mzp5x4OFPlqN3+IlpbSPPg8JUiJbiF1?=
 =?iso-8859-1?Q?F96y64hjdwQL+7AFO5ep1coXsf1H4j5DqhCTrQZlEtOibHug5ltMj0Lf0Z?=
 =?iso-8859-1?Q?fXmggi7fJzTb9IR+SpOjmvCszGffsb9m5o2ih25TzpZYpoXdjHfPoVGJ3b?=
 =?iso-8859-1?Q?fpgT/lBX+wkDO2nm+BPVzWaYicO9lianmjb/lSvkC17TyzAd/UF7kMr03p?=
 =?iso-8859-1?Q?U3l+XJ6U2OFtjMAlvrOEFBr88WpV7bGkdz6Oz2wKbWI1GGOCoErgOVpx43?=
 =?iso-8859-1?Q?6Q1qUSEWgdQhEH+7R0gnYN2yZaJnlKColuKFjdWFej6UfwJuN8WP6zCkO4?=
 =?iso-8859-1?Q?MPSEGe/qVDdiV88rS3i8duoOEYAW2hP0a15eSvf7BO++hY8tm9a1W9DA8L?=
 =?iso-8859-1?Q?0pMuNe6DKbw189JD5LtV0xw4M3eSvzaCxymWR4N1JjMxFLkPu79M++G+DX?=
 =?iso-8859-1?Q?5I//Ajmrsj5pD+VhQj0ufNbKhoppNNjn8CNXYZhPGBk70ljEDRc6IJn6Jx?=
 =?iso-8859-1?Q?hhhmYhW8We3R4vRIFTsI7/i41YAkf+WX2Nw9WzH9UK/SEfw6yDWFKgMaSj?=
 =?iso-8859-1?Q?q5eHPIE5QXM7lAh8uarp9t4wp4gauMCS3Ojbx7KBYgceu11vYqQ4T78ebd?=
 =?iso-8859-1?Q?sVLrsbZr/dv/nafaBaxzfq28EB3XP//ves9XtBAp8pprWaner0JnRPLK5w?=
 =?iso-8859-1?Q?51CulVfdnn6tpYp52UWtG4v+G35c+raF2tNwb1F4sEC+orzBn1xvwoPqTz?=
 =?iso-8859-1?Q?23YTyHVhjQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pR2a8NJNTtiP8lJFHSuemYdm95x4gHu5z78J0xTnlcE34nEu7XjWLL3G/o/LMf0tuiiw4tQVHpgwV23qC15HuNMGcDxHq4TG5FLI/kYR2TAzklvoDvdN/f1oQksqfLphqkn5jSnfMvJAbg4t6q3lkz/v9cPRRQYPU9T3uRENdZNf/2oeqLe0Gt5MUFCPV09VnlS7jlrDFTSbs6Flxfstkgo3LD334ryvtuCJdTUxtfp20vM+e5QPGu++dsr+QxzpL1Ie0ROAwQS3Z2u5iUOLS8TBssCJrhND4fP1VADjiG8SF5tQ6WVJgxRZVnfBQ8spxCa0eqH0EdAG/uAbMSQC7g==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c68d437-6a8a-4ed4-df2e-08de7e68d16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:49:38.8321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOINEPhdvgWYziCcKYXOc7ZpSWn/7Fu1ZwO4ArKnGjWTBuRgoUBhn6yRJNYFsgagMg4/LvfsSRWubot46ffPr+TD5z0bwvmQ0ewsRryjTwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR18MB5973
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA0NiBTYWx0ZWRfXykCudknDoNnz
 LsYoZ/HJOCG8cOIgOLnvMueA9pnGKp0d8Ps1xvUk3lU0F7+BcUmj9SopuI5LE7jDC03s4pt3sPd
 0cPEmM0jW3/YTWA539k2Bs6SH8j+XedcWEL0/jCBe2vE3PVGlGJBPGQWdVDX8UNUg52O7RSlr6Z
 PrZNzd9BiPC4+xBOuH+CMS/n8V7rCaAIwSajcaizn2UySjaIIzbqyWhFsfyJ0zZWWekJMEwlgaw
 rRa7CvmadiU0ZYk83Z50SyFWnMYHwTkh8LB9gVAkcs9r/S/tdaXJJj27mc2jcyy6DQfxH8HH4io
 wIyj7j+AHRle2hFoyCnCCBOEjrBwHllhgJt7wZ+0OCIWqylZDv6JYXcop+aaFx80A1oLx6wNXVS
 FCiSbTqP/9+V4decYN1YAxZKArH5fZb3W7nYZXL8WEUhUfiBtqIjknD40IAwXssQelvjbgIa9YU
 SHvdOTg9+DjkZ3IvzoA==
X-Proofpoint-GUID: n3u3W4UCU99IwBrahcVtaHbZEKl8eMUE
X-Proofpoint-ORIG-GUID: n3u3W4UCU99IwBrahcVtaHbZEKl8eMUE
X-Authority-Analysis: v=2.4 cv=WbwBqkhX c=1 sm=1 tr=0 ts=69afb0f5 cx=c_pps
 a=ASZrmc5qRKQ8mersbOLYOw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=20KFwNOVAAAA:8
 a=H5rnxWzQq3sNb9eP07kA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
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

>Add rte_node_enqueue_deferred() which tracks runs of consecutive=0A=
>objects going to the same edge and flushes them efficiently in bulk.=0A=
>When all objects go to the same edge (the common case), the function=0A=
>uses rte_node_next_stream_move() which swaps pointers instead of=0A=
>copying data.=0A=
>=0A=
>The deferred state (run_start and last_edge) is stored in the node=0A=
>fast-path cache line 1, keeping it close to other frequently accessed=0A=
>node data. The last_edge is preserved across node invocations,=0A=
>allowing speculation: if traffic continues to the same destination,=0A=
>no action is needed until the edge changes.=0A=
>=0A=
>The flush is performed automatically at the end of node processing=0A=
>by __rte_node_process().=0A=
>=0A=
>Signed-off-by: Robin Jarry <rjarry@redhat.com>=0A=
>---=0A=
> lib/graph/graph_populate.c          |  1 +=0A=
> lib/graph/rte_graph_worker_common.h | 75 +++++++++++++++++++++++++++++=0A=
> 2 files changed, 76 insertions(+)=0A=
>=0A=
=0A=
<snip>=0A=
=0A=
>+/**=0A=
>+ * Enqueue objects to a next node in a cache-efficient deferred manner.=
=0A=
>+ *=0A=
>+ * This function tracks runs of objects going to the same edge. When the =
edge=0A=
>+ * changes, the previous run is flushed using bulk enqueue. At the end of=
 node=0A=
>+ * processing, any remaining objects are flushed automatically. When all=
=0A=
>+ * objects go to the same edge (the common case), rte_node_next_stream_mo=
ve()=0A=
>+ * is used which swaps pointers instead of copying.=0A=
>+ *=0A=
>+ * The function does not require consecutive idx values. It can be called=
 with=0A=
>+ * any stride (e.g., 0, 4, 8, ... to process batches of 4). All objects f=
rom=0A=
>+ * the previous idx up to the current one are considered part of the curr=
ent=0A=
>+ * run until the edge changes.=0A=
>+ *=0A=
>+ * For homogeneous traffic, the destination node structure is touched onc=
e=0A=
>+ * per batch instead of once per object, reducing cache line bouncing.=0A=
>+ *=0A=
>+ * @param graph=0A=
>+ *   Graph pointer returned from rte_graph_lookup().=0A=
>+ * @param node=0A=
>+ *   Current node pointer.=0A=
>+ * @param next=0A=
>+ *   Next node edge index.=0A=
>+ * @param idx=0A=
>+ *   Index of the current object being processed in node->objs[].=0A=
>+ *=0A=
>+ * @see rte_node_next_stream_move().=0A=
>+ */=0A=
>+static inline void=0A=
>+rte_node_enqueue_deferred(struct rte_graph *graph, struct rte_node *node,=
=0A=
>+                         rte_edge_t next, uint16_t idx)=0A=
>+{=0A=
>+       if (next !=3D node->deferred_last_edge) {=0A=
>+               /* edge changed, flush previous run if not empty */=0A=
>+               if (idx > node->deferred_run_start)=0A=
>+                       rte_node_enqueue(graph, node, node->deferred_last_=
edge,=0A=
>+                                        &node->objs[node->deferred_run_st=
art],=0A=
>+                                        idx - node->deferred_run_start);=
=0A=
>+               node->deferred_run_start =3D idx;=0A=
>+               node->deferred_last_edge =3D next;=0A=
>+       }=0A=
>+}=0A=
>+=0A=
=0A=
Can we add a deferredx4 variant too? It need not have SIMD but would reduce=
 LoC=0A=
further.=0A=
=0A=
Thanks,=0A=
Pavan.=
