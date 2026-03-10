Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F70CFCC9C4
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 05:46:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63953402B8;
	Tue, 10 Mar 2026 06:46:13 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B2F234014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 06:46:11 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A4BqN6462267; Mon, 9 Mar 2026 22:46:05 -0700
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022101.outbound.protection.outlook.com
 [40.93.195.101])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ctc28g4wb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 22:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhOoUY/w5MtHjai2WNS1fFxiHUChm/KYndwnzcRaoHqG0wykWNpDTfpqTEGbipk+kvazVpXlTGfrX9qf3ro1yLjMz9c3bJJMISeFHfgMkCTw+Nc6/Ucxdn7ZN6DN4jqbHJWIxfiu3blPZ7fd7V57iH7XmzNldwe+wDa25mM7UtWe2rUaYSD2ZDAu8MYqMdKZ0CT4Eu89ZeYY9KNGce8S5TT67R9KqYdCs+U64uHI+ithtVhGGRbjrmPclhHvHjRMfGR8VzMTZY0VfUGxe9KvRN/1fm5tk5V1AmKBXI/Z1ns1agF7KZZ7eBqnoV6qV9xDj3hSknyGFSt2+HeME7aDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYKZ/kvJhxmDntIRsh+655TTF68UrhGjaoYRtn26PW0=;
 b=PrYZ9uTjfZOEdrKTD8TYw0/pYChCL6pfpgMy0oS9UMVlPb25MTHu8ICe3F9h6ZkQWi4wd1x6VJ8kVEeLjnFzWBN6UcVU0iTdAHfJNgDEF3CWyM6A76OPim/aZ1hjfY4Y7MXabYwqhR4oeL4uf1bmibPI02e8O+c+lcP6AYnG4JelG2xjy11Jj+iLToNU+vyCi6Xbzu0iJa3P0VEBSv0clH0HxFWcGqxy/7lgr3QCR49pINohAfDDNhOE3tICMadmfpy+72shkGoNMW2dlU/kc4/pSUQH4+y7+hCCGspueax9jju5IhyBe7+627zk0MKbaqHqOPNOqgBEZ7CmImGc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYKZ/kvJhxmDntIRsh+655TTF68UrhGjaoYRtn26PW0=;
 b=bh90HwuZuw+F4sexJv7V1nLcxZMHsYyb7H+zUpH3E86VAbRgeEzwIiT+x+XB546AyRL4Y+9Pnz1lef7hRZXwoyh4XI8ot0o2tbMxGRdYt7vlDleV4tkQw8HylAITEe4XVzzOuuPmvEIRcORWtODrhuGX+S3lxyfPPrcc0gS/1HQ=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 DS0PR18MB927495.namprd18.prod.outlook.com (2603:10b6:8:315::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 10 Mar
 2026 05:46:02 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 05:46:02 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: Robin Jarry <rjarry@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, Jerin
 Jacob <jerinj@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [EXTERNAL] [RFC PATCH dpdk 1/3] graph: optimize
 rte_node_enqueue_next to batch by edge
Thread-Topic: [EXTERNAL] [RFC PATCH dpdk 1/3] graph: optimize
 rte_node_enqueue_next to batch by edge
Thread-Index: AQHcloGhqs8VuVeFm0+iFUEpjY2CL7Wnc/WG
Date: Tue, 10 Mar 2026 05:46:02 +0000
Message-ID: <PH0PR18MB40862D42368EBCE517034B01DE46A@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20260205092630.100488-6-rjarry@redhat.com>
 <20260205092630.100488-8-rjarry@redhat.com>
In-Reply-To: <20260205092630.100488-8-rjarry@redhat.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|DS0PR18MB927495:EE_
x-ms-office365-filtering-correlation-id: fa9d9816-d0a7-459f-482c-08de7e6850ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: +MPWQt1reMKoanpEpV9gy2i2cPBOaiUo3IC49Co38TrDy2v9RkAvMkvhPSuUZ3neQwZaVHAeD5MAsDgfQnixs3axev68Rv2nIRj0LqViBsVaE60xiM8BNlWLmVdoCn/p/uv/FlCyTluyVJPrUWwQrR+13r++bof9WNgUPBSwxQe2EQzO+oW5Irk5BDINMH3Qkugrvc27Bz+cf/pd6efNJubhNTOMAYX0gndIgvVlptIQMM2ada91usPYMWzg1un7BixlVk7bkSJAZ5OvTd5NV2/hQJfb7t9Ww94EQs4Y+m2VNpEWtx977r1RMrKOmR473MUYiISuTysP187hpyWh9+RLB0648Ve+dlHHMbfeE9byf57pRSfFdxykNdJM8WIQCU7ZBOfIPXBo4Pwdx81PW4PEvtUUN3joaowW+FheGeGrhrUTb4b5Oqkt3zs9MfpX6oMuD9wWmIXrg1Y5MvO9D8ze0V/85TfIxQS1AGQS6vNiwNKriuVAoltlqw4PENZiKDE4mGJmwUmuoblI9Yurk7CDGfN2FTECT4bTc91/wp+s+WC1pw0hfUynN8lMG3nJnXjuMFoAXRf3SBZOdWOd70cBzPir2gDJ4nE98/b9+VYj31oJqHY0e1kX5K9wLyk98jXpiQdbz8dZCJfoa9txf5rSmlQANLqvugfDhY1n0SaVA5vPZORJ72vlf23lksPBCNX8WOU8Efjr32PNOoPQCAlWNGHQnYy86XG2qjNB44W3JSANLPTUdv34nquJbzp0KLfM9ZJhY8y7mOAm0r8kDdP8hEbSGlYNP5d5FBVoTZw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3duKboEsV+0O+5gO0uHIJCEigi0h94P+0oxrPTTfBBGm0BTbhqD8ZYRU30?=
 =?iso-8859-1?Q?F6VRK6UjBfDyFWrxfm+Qn5iH94V85ouJsJmpaamm9K7LNNpVddk05lKoaV?=
 =?iso-8859-1?Q?cvjm2Dq/P0FhL/VX+9e2cD3nVvdFyzE7IXOLSqSlKZSU4AARVnWKHDPWzB?=
 =?iso-8859-1?Q?1N0+zrGiUxgPYpmjTuvcJdWNhrPimqMu7Jm83z2uITifq0hxFS0jreT5tE?=
 =?iso-8859-1?Q?UdRmDI25ymp6n8FzH0euEMj+mihH2JqEXNOvb5FqezyZdgbFiqP0iJHEhc?=
 =?iso-8859-1?Q?wrgMjVcTw0kRtgXC6xH4b9w15K9oyA3VIdwMDoFS4YojPf4jGWPNHHu+5P?=
 =?iso-8859-1?Q?yGVMtrN6R5c7in28JbM83NuAGylnrpWN/akZey5h67TP4dKHe0bn/2CvWD?=
 =?iso-8859-1?Q?XTicr9/90OyhrqY3huYbDdPEqNz8kbfSHHJyNZJGNHe8Z6COIj6bgUpsrw?=
 =?iso-8859-1?Q?oFLIVMeZ4ZUESLNfYswYfVdlPDtz34MvpUak3NYHHPwIdw0Y6Pbm3pHwef?=
 =?iso-8859-1?Q?QETC+R3E92jcodd/1vklbWfBhyXNTkIaE8IF0eVoljKwM9pqHfPUgt+qEU?=
 =?iso-8859-1?Q?K/yh1H9BXulxeMnuZGmcBCUuRy34EGl4XWb8cmRgP0BJmdQuijLrU5FMGR?=
 =?iso-8859-1?Q?p3OAjaNVAoeest7t2wBjoJRv1Pzj7orpdJ85v/4BY+nktPj0/DnIDbWaY+?=
 =?iso-8859-1?Q?yNt7OMZJqvW1tNkWcXgrDss9OKsW5letLEXTJ3taj2+hfevrl7Ey+yPghJ?=
 =?iso-8859-1?Q?mpBXGu4t2DkWL9Sk/neClMwxI4Z45/1SM83OHtb++FsQVvC4bkypZu3gik?=
 =?iso-8859-1?Q?CQUut8zUFoYHhBwCZzC7MeZ7DWajyQYYhDHW+eifw0tLc/9s+WiwGxQuwd?=
 =?iso-8859-1?Q?NT7j+LUCVxi7pVtgCW7rI9bzavb0HvcG4kwCaoN3FpKWE24S0YTJgYG7qe?=
 =?iso-8859-1?Q?bR5PYIPTtqCwbjy7gJV3aMaY6PnKywmCxlTeikshunrQwg4ID6ZG/8MrxV?=
 =?iso-8859-1?Q?oqhW1LSS8BYRtq2lo5gc6D1le1Ft4/vzSliTPy37MlBGYiyWD2UtbCu1/P?=
 =?iso-8859-1?Q?JspSuVtmXZvz/xh1Ru1HLvry63hlYnbGhTQdq1zTHMtoc955MquGLU7o9z?=
 =?iso-8859-1?Q?/duLMmV4vrV6CoJV8+92I3vrqLmdJyXaWQX7B37+gb3RtGz5VWFXRn1ntD?=
 =?iso-8859-1?Q?ewq7JPA9NnO0RpQyrGVAXSKlZd/o/RqmS/UUpNj4fnN6GbObzdCZoGSIcU?=
 =?iso-8859-1?Q?n9sT+vP627zkB4LVcernKkLCuKjmpIEC2SHQomjsBvVYFc97h/ifVp0HOL?=
 =?iso-8859-1?Q?5bjLueZtbSTYBY8uLTjAm16b1hszh8dm7GN+4BHVbCt8hXuiC0IwS4n8Nf?=
 =?iso-8859-1?Q?YhpgqIOJpR5wTpQ5bOhn0ofAp00Y+7uQ5v6ruaCi6nOKINEsunZM1A9LJZ?=
 =?iso-8859-1?Q?2xAxJz8vkpXJhKEhyehQ4TTcHak5fyotEul2WiyX4HeVLwTkNgKi7ePRgM?=
 =?iso-8859-1?Q?5kmC7N9k1eHvZkQhhcArNRsJNNgg9lNZ6CZt315aQ5BAtYp/fbFAdGqrsn?=
 =?iso-8859-1?Q?DYgDJJtWFZQdsuckxiT9bxXbM8Y6P4ZCmr8NeNZcp+mCYhbvVGofqk7QXJ?=
 =?iso-8859-1?Q?wjsif5lioqmbYnU1R8/eP/KGeBtP/oq7GEnFSx1RtyVP5wZSalnTTELA5l?=
 =?iso-8859-1?Q?a9Gi4RiBeyqgOQ5jXAnTvVsvGih+tXF48qIOpwn04bmb8Z8K/T5ql9sq/u?=
 =?iso-8859-1?Q?/Do/Sj6sSAMm2M4+1OTfepXL3Jbj/IseRrtC4tG9mb3l5+jUeNe77bTndv?=
 =?iso-8859-1?Q?lAONTVvzPQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9d9816-d0a7-459f-482c-08de7e6850ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:46:02.8293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10SouXQcyDImdkLi/mbNYOegm3TXL4sTlcQhHZbDpHOeiHtaQQWsVzWSfqndhc8V3US7XxUgCEGT0h2IQjlZMOMMEAYpYE1pJjN3WSLg6Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR18MB927495
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA0NiBTYWx0ZWRfX5KlBXyAVv6jZ
 MTudbOn/oJNz5rQ5otJYJVRUXIstHHd0XwcomcLSEq4UyrWoRDhpaqZDVaGQlYY51qxdsgP5ptz
 arZxKh130vIAnPFfVnFxNLo4GGDkcXvJuxQtty63w2OuBRPR+erfA6gMtYe/c5Kd/HJ5JHv+5DM
 Gkkvs6664iXU8w5rKcJAmefjbqkBuxzN91JAL69mHuTFtoo3yr15g3n3B6qQMrVphXR0deunO+U
 vVOyY/6Z3u0pOSAbVaEhg0InoD3MVTc3orDVKxBMZ8xoOeMcpb4jvQSq6goNFDiE1DZM0HR7Spq
 e1b7JDYIgWVv50rBuNO2OMAmtYWIZRGBJnTJtopZ6GPfDbzyhmqn2BP5oLRabeEPdUlmmzmHbrm
 dCfBFK5BK7blGmHp3Ghrw4ufc5fmasWrlx13lwqNHnSnMPWmq761yMZ3zJU5vz9pbC+BmPyW7GI
 3MYhIlQSXUaRQJ+W0UA==
X-Proofpoint-ORIG-GUID: HzSWK7E9QpCYMYm1J0dtgFY0edsoSHCF
X-Proofpoint-GUID: HzSWK7E9QpCYMYm1J0dtgFY0edsoSHCF
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=69afb01c cx=c_pps
 a=qdGNMY5putnn3dTEtBI8ag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=20KFwNOVAAAA:8
 a=WMejxQGEr740LaQuyHAA:9 a=wPNLvfGTeEIA:10
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

>Replace the per-object rte_node_enqueue_x1() calls with batched=0A=
>rte_node_enqueue() calls. The function now tracks runs of consecutive=0A=
>objects going to the same edge and flushes them in bulk.=0A=
>=0A=
>When all objects go to the same edge and come from the node's own=0A=
>buffer (objs =3D=3D node->objs), use rte_node_next_stream_move() which=0A=
>swaps pointers instead of copying.=0A=
>=0A=
>Signed-off-by: Robin Jarry <rjarry@redhat.com>=0A=
>---=0A=
> lib/graph/rte_graph_worker_common.h | 15 +++++++++++++--=0A=
> 1 file changed, 13 insertions(+), 2 deletions(-)=0A=
>=0A=
>diff --git a/lib/graph/rte_graph_worker_common.h b/lib/graph/rte_graph_wor=
ker_common.h=0A=
>index 4ab53a533e4c..7fda67c07169 100644=0A=
>--- a/lib/graph/rte_graph_worker_common.h=0A=
>+++ b/lib/graph/rte_graph_worker_common.h=0A=
>@@ -432,10 +432,21 @@ static inline void=0A=
> rte_node_enqueue_next(struct rte_graph *graph, struct rte_node *node,=0A=
>                      rte_edge_t *nexts, void **objs, uint16_t nb_objs)=0A=
> {=0A=
>+       rte_edge_t last =3D nexts[0];=0A=
>+       uint16_t run_start =3D 0;=0A=
>        uint16_t i;=0A=
>=0A=
>-       for (i =3D 0; i < nb_objs; i++)=0A=
>-               rte_node_enqueue_x1(graph, node, nexts[i], objs[i]);=0A=
>+       for (i =3D 1; i < nb_objs; i++) {=0A=
>+               if (nexts[i] !=3D last) {=0A=
=0A=
We can probably use SIMD here for comparision, 128b would process 8 nexts a=
t a time.=0A=
But might not be worth it if nexts are too unique.=0A=
=0A=
>+                       rte_node_enqueue(graph, node, last, &objs[run_star=
t], i - run_start);=0A=
>+                       run_start =3D i;=0A=
>+                       last =3D nexts[i];=0A=
>+               }=0A=
>+       }=0A=
>+       if (run_start =3D=3D 0 && objs =3D=3D node->objs)=0A=
>+               rte_node_next_stream_move(graph, node, last);=0A=
>+       else=0A=
>+               rte_node_enqueue(graph, node, last, &objs[run_start], nb_o=
bjs - run_start);=0A=
> }=0A=
>=0A=
> /**=0A=
--=0A=
2.52.0=0A=
=0A=
=0A=
