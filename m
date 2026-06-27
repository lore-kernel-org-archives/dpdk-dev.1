Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B2EC43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 27 Jun 2026 16:24:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97406402D5;
	Sat, 27 Jun 2026 18:24:32 +0200 (CEST)
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com
 [205.220.165.71])
 by mails.dpdk.org (Postfix) with ESMTP id 1857C40144;
 Sat, 27 Jun 2026 18:24:30 +0200 (CEST)
Received: from pps.filterd (m0316041.ppops.net [127.0.0.1])
 by mx0a-007b0c01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RDYnJp1504739; Sat, 27 Jun 2026 11:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisc.edu; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pps1; bh=WuGOJVjBULPynv7QrvBha6OBSy/Dj
 m92G2TAyQNiuXo=; b=onFQWSN80lfyto9wqz86B8h0GHTjOS5f4rEheywiBc5Ww
 gObQkP3KWLSyiq4vxlKXgYwatMQF2OHUCKNSlNoKNBIXOsX/9ZBcrzcZnCJJ7VmU
 xAVnOOcSVEHrFj2iVSqm1KuxVODfdmE8uZyIxVE9UefoVI0GyOzbuQq9NPTmStdo
 +r9xIBSrD6+jWNRrZHRFIiJvXoAEANaZfYSRFJqE1l3R8R/sVWlYFLzGrFQPFBvD
 J7Ks8mrAOwZyrYqwz4cJcP+Tnx9y/USE5gZ1out5K4ghQP8ltHjT+DeG/uUqSY6g
 yU+53VzUINNsbejmWqIWQXnGXEi76o+0LQ+ydiWLw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013036.outbound.protection.outlook.com
 [40.107.201.36])
 by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 4f26h7ak1r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 27 Jun 2026 11:24:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7HFicwa+QqWlU+WT+3hh9UzuXnfM6wIi7MUhEP285RyedN7jEisIZ8mNrJ/Syx2CMpLkfWHlMKSGCizRNS6abXzFGJA0RCorLDYvgFOo44FFlj/0Rx2qGbl3CDidY0qNIaFl+qPu7+ipDG4Hcmg9srsjIl+dnDb5/gXq1OsGCmuGwS+jfQ/gLJ83pcOys8u01DC8sQ5elyt8bntkZD7J9iPiO0Ha27VhXPmeI3vYIqTD4bZEoJLzXpO1MHSl2NwVDsua3uBK5ptSftf98JmgbbwcvPMoIbdErEt43OrYsXcx2ETdwUqJ0xxsYhGz8w4pnyFu6BUbWzOcds03Dof9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuGOJVjBULPynv7QrvBha6OBSy/Djm92G2TAyQNiuXo=;
 b=jp93TT1fi6pDolE7SQ/lzNLtxYeRkv3y5ENzu7FydLVxZ0tb04JNVchkjP1hj3KTVK8c4PR0b/GNRywXpGEZ9hytRESHkWzFqvLYpPyndPxEe7KI7ohR0oe31L3undIHJS6M/L6Cb7IMInrdBg0VbtBi7Al4S7+hJ2bALkphCJQaAgfqoCzFDCTq8TfmNTumR7VXCYvaTtRqsH1B3BFAq1qQyl+NWr2e9mvYbmKDC4VS1MJW8JplW+w6i/S83xGsmG+ZEqf6skZnWK+OxHA338VYYiAxsYm7FweHxCjV1ct9S3BUrYx9ewBJjwoE0nL50FvV2t35+2JsUxg/PFK9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wisc.edu; dmarc=pass action=none header.from=wisc.edu;
 dkim=pass header.d=wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wisc.edu; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuGOJVjBULPynv7QrvBha6OBSy/Djm92G2TAyQNiuXo=;
 b=kxbhBIGxsnZMjNrCG3LLZ06EP2+b9GAgphw8HH9OsSq1Sd40fd+eXvvi42+juAUa0/rQi7r3DBs9qkP7QPr8WbUNb88WqQs6uuKSrV/ZoJVHBaCE8BOD/v/5TWefuPVIb4EuSsOsUcSgZCSMoSicS98CegAwCQCPbzsAkfhf0DgyCBlUJNXErM+GrA2uEtb5SgXQ1pRYsyvBTx8vadDhYOoyFKazeMNq3puo9rFTPmDTz5Me3ndaPDUwIoqBggw78Zki/fKocroCcJHtSXok7SHk4Bb6ZWxKQ6/GVg9qYNUnBP+sOuZ8Bax7G18m2WzrV7BHwkUql/QlW52w5msSQw==
Received: from SJ0PR06MB7520.namprd06.prod.outlook.com (2603:10b6:a03:322::10)
 by SN7PR06MB7167.namprd06.prod.outlook.com (2603:10b6:806:10f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 16:24:25 +0000
Received: from SJ0PR06MB7520.namprd06.prod.outlook.com
 ([fe80::7939:c6c2:1587:2e54]) by SJ0PR06MB7520.namprd06.prod.outlook.com
 ([fe80::7939:c6c2:1587:2e54%4]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 16:24:25 +0000
From: Weijun Pan <wpan36@wisc.edu>
To: Thomas Monjalon <thomas@monjalon.net>, Hemant Agrawal
 <hemant.agrawal@nxp.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>, Jun
 Yang <jun.yang@nxp.com>, "stable@dpdk.org" <stable@dpdk.org>, Stephen
 Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
Thread-Topic: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
Thread-Index: AQHcxFc646lmTXcaqU+Ob27NXLcLZbXTp7WAgGSW5ICAGtthTw==
Date: Sat, 27 Jun 2026 16:24:25 +0000
Message-ID: <SJ0PR06MB7520F391592C5D90C5DDA5FCA3EA2@SJ0PR06MB7520.namprd06.prod.outlook.com>
References: <20260404171912.48947-1-wpan36@wisc.edu>
 <20260407070940.225de771@phoenix.local> <2S2V_VmSTBa7oGRJ0YAQqg@monjalon.net>
In-Reply-To: <2S2V_VmSTBa7oGRJ0YAQqg@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR06MB7520:EE_|SN7PR06MB7167:EE_
x-ms-office365-filtering-correlation-id: 7c039d20-0d93-4cc5-95cb-08ded4688de4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|786006|41320700013|366016|1800799024|38070700021|6133799003|56012099006|4143699003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: i8R5vJu+VwyTUaiiSiyxo6KFQlHRzJ28eNFhmgD4Sxr3ijieeAdZAXlixvj/bnuK24kButyVeRiN0JgJk7D0r2OP4rg9EAP1Ucas9lGkMCOZ0GPt4AAyGKYYN6DWUwB1FeTJYZjFJlrto/DRa3LF0oPthKGRHeu21gyXm6gY/qbHor3/woKdkfsQBPsEzQJtNgcpXdO2tPuge/qsy9WHdQcEFJl24Xy/W+3LfNuTth7qzOgBZVTDYyz8h9zJEEySSusuqJfITdS0bbZpSlzk8Y/fiMhpq4XecHf1ZJAsn3Q/nTFzmNZnbaLZogZfDxoOa1W63oLmA/6apCMh+3tplmqYpWiIqKaqZKSZ1xsSkd9v7yK29dASp8Jqp6UiEepSVnFo0GvI8DBaD2TkMTUhUAKDNwU/P65pYpcGERwoN9JjyqveIPlvVgChOF4kbqT8n1h5DmT7j5HL7pNddHi4S5HICFpRQjtjDHez32+FMwRrUIT2dn5HZ7XRu0HbVBu0L6wAYbcIu50WffiF6UJaP5R2+OpsRY6tMmzLHgwEUmTnsCZzt9bN0EM6UOSna+K+hVITon7deazTZEYxQXXjV7gCT+RMO85wBo5H5Sb6I9TcAAYaY2qmwQbgobjgkLgBudXrmF9z/WVUkMT2e+u0qXe/TpfUTmzRNX1qcYeG+46t/XQu2W/LcnOA2EXt1VQ3gEMHNaywwl2PzLOIrEsn8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR06MB7520.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(786006)(41320700013)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fCkenN97x5X+IeUWst6/1yxknFi43OHc77XeLL9Su79VgA5c3dSXnwJcflk5?=
 =?us-ascii?Q?ys7ZMHaQyqoITpl8vNfDy/rEVVksOxkuMFyy4EBGhtL4QGuCcC9TpO/IFzwZ?=
 =?us-ascii?Q?8k1LiqnmxmbqdHKP3fdYGWT4PiHJwVcWxbinGU9uGSEDpHJ2pOfSkRa86slV?=
 =?us-ascii?Q?KcJxsZOJQxeLnYpfA48xxFa2aAfPOszZLz+fUYgsvKWSqrGOGRJHMw/Fx7p9?=
 =?us-ascii?Q?qYuJWp1x2ZL5brZhk7NHj6n7G9bJQYeo5Q48BrL4p0yLgBwnXk8SXlf/zuvK?=
 =?us-ascii?Q?+jJqT1Bx4AV5IP1SiNlDYy16BCXX9g52NxLaOjJ2DdxjLPnGWNCv+X9nmr+B?=
 =?us-ascii?Q?iej96LREaYxlZR/T2x/fpIAQT7NdLmd3ruEloN0JGsrwJP1y0Rgw/ns+N0DX?=
 =?us-ascii?Q?XVPaHvrRxOlNw2O1t8lbLe0Tkh6sk4f8OL+m35WaR8XovhwcK3ReUHKlzmiQ?=
 =?us-ascii?Q?zHDOTdcByGyVQWKgGV0mh2Bar/Y0uItOIF1FbmPwdtQJzl0ZptLS7VbF5sp7?=
 =?us-ascii?Q?6cleR5NNqs0sFAAWvPVchOvY9gWpPlYtsULQTGIXp283uvu5lcHucxHYdTPR?=
 =?us-ascii?Q?+a/fPaVgnAtrUNIKUTMrrI1lpK5oGy5uFrc7+MsFKzOGw+iWTQ0geWdB7/WF?=
 =?us-ascii?Q?pazF4p3USp+Z4543Q0mAAHIz5ZAb5vr559iMC+HY37KJ/XHAbynmM2WSojSs?=
 =?us-ascii?Q?25cVVmR/jCzGLBkVU6J4etx0uUqA6qzaD4mvd5fy7kzlbZR6InITbdBF5bLU?=
 =?us-ascii?Q?ePxnimw33WtC8hMHlC585IvH3FoJFPijJi4no99PBVRtjrgRkpo9pwNWR3F8?=
 =?us-ascii?Q?eARAzFgV3twJUet4WAdStHnKbFJ92g0orHynjjGymdustoJv1CClZMBsuh4K?=
 =?us-ascii?Q?90zxtFWPrqnolwt5ngwjw8OuMCoGBMt27A5/rPHBz8313/6+WrS5EVjx+jUV?=
 =?us-ascii?Q?C5+WUMwsGCJOa8NOBVelJEEvKQwH6Sxl7p7bBS97t7i1o3r7d1DffZWVIjKj?=
 =?us-ascii?Q?JqDVSwUVGDVaKX9FoZzeFiQ8xkKPwaEVs7nUYIFepb6Gd1OUGdRopWulMkPL?=
 =?us-ascii?Q?KZgWCZ2EmhHuCjOkooMcGwkpra+TaQHA3MdJ5TNhHnFtC0PQL/AVjc8wqwQ+?=
 =?us-ascii?Q?Tzc7n4Fk6Esl8pYS4cvg2pisdiMPhzjm1g2BhlMOdsd/GNYFejGlrPCNVaga?=
 =?us-ascii?Q?Nu1TyoXdsjsdqg2s997xPV9XhO/oZiECa1W/hXciXlWMwNGKKbHyRGd3XjsQ?=
 =?us-ascii?Q?9GUi77dd64AlOQ/Jpc3a0gj9IF+VaTA3LdCYsDwvPLum1MDG2J73ZpB/0E+n?=
 =?us-ascii?Q?7B6sxRQtg9qt+TBO6affhJICez+rvCWebhuW31iGC4Wc3x1iWJEDYzPhN8Ur?=
 =?us-ascii?Q?bUDTQxqJ32Y/1JAM1E7nTHhr5Z8t7ytHKYzQ1rK1fj+nDXei6J4y+SKhn/ZF?=
 =?us-ascii?Q?8dncHZ935U0337T5Z7XX4ahoWhchTZ7ev/cEfJwm+CKLVAW3oCvbvGfcF5OW?=
 =?us-ascii?Q?7cvX3oFC0clmw7Ue2f8pmIEaFCB5tOtr6Hf3KB15EdPFtovjt7sWQJqZC0Ki?=
 =?us-ascii?Q?VEElkk7izZfdkfrwI/WBT7ABfcnmuUcHDxIodb+UY4xmr7o0JrZxHIN8Quif?=
 =?us-ascii?Q?wbhyv0kKt68A24X1NNk6Pv8RaCZnD1nvdjlsaX1eDKLENwryVCVqvwcPz3s3?=
 =?us-ascii?Q?EnuBY/jMGIu4l2l8SzVlj+zFX1I=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR06MB7520F391592C5D90C5DDA5FCA3EA2SJ0PR06MB7520namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PV3ZR1go97TGiLjsWmquVptYvzhILDuQhXsOSPK2T3WK33+hntNVmEBW9sAyjriQAB0XiWILmMLJE9w+SzymaGjt5SVZ88XxEAjpdRLl4tCWbZn1vfd7h2R6JuzEBHAber3LyleKllVEIFIlxYuUFCH0pu50mbLj5prMPTdq4q5kz2sf0BGmFKrJCWyEfgw/x4xVAkoU4OKeHopZNNSGtsDH3dbPKbUtyCbjY0GZ+y9Di37Xjv0n4XlwalqdwcX299RyuH/YL69Ar7Y5ivNSk4Yl9wtv0xspLKjqX1GrjQjwj6rNLyKyZ0DNUxzKfxxhOOn8qPduwrIPPr47JA+N7w==
X-OriginatorOrg: wisc.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR06MB7520.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c039d20-0d93-4cc5-95cb-08ded4688de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2026 16:24:25.4831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uz+sniFlaghfK8GBemXbJ0g8pfixR9vr5mdJUJZnMJX5bSc5L4AoPAqVSA7O+RhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR06MB7167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE0MyBTYWx0ZWRfX6RAYm1RHEKrp
 lneLy2HLzX/oHNAo+vAVbRwZ6/cuWRrYx8uZLuN6xHdOxgcrFQCefZR67RZvQsvtAZI8lNWQkPt
 HqMobAZMWrXoz2WVFSs/0eC2t8PKp5d9AvYQTESDkCf4pF/mWMkf9ltkp9YPDl74ZGl0ZTi46d2
 jQ0eN3GfInkjPTAtR7/MXvoaN2bsEJpT4djOg766hnlZtWSS9rVhYxyJ2XqNJ8VZa57yTTtGToE
 gOICYF5WCnR5AsJEhRM2RQV+dNKtVVAdA7/F1mzxJ2/DUGCa1AvqgHbphG4uoz8Q8VNgywR/Rbb
 MuDylJ5SOk0ugkPkC07htigNM4xetUFuubP8LiRWvKKejhlhXZepbVZF0EhX/z8M3GNjKho/Y90
 TLKrhAf/AMxXGSzj83J5ZXx6l7oY98N2AoVMl+EmXHahwDoAnFrmxG8Qiw50T2s+re1laIBD96M
 dWxkbghbtHRiSILsgdg==
X-Proofpoint-ORIG-GUID: aE8RHz3apo-IPCE_arOIsKvoAcL1gF4r
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE0MyBTYWx0ZWRfX9618iR3b15cR
 3fIttqW+7QgtynyzrhcLBGla9d9RWyYRcOzj9VyqVz1pozFvEpzpBcnMbLT3QcEtCNVK+HvENXN
 ptHcOpIqMirahUzcO7yeFC9kuNTa9HI=
X-Authority-Analysis: v=2.4 cv=HbokiCE8 c=1 sm=1 tr=0 ts=6a3ff93d cx=c_pps
 a=0RQO2klDQ5fyV1VIsLBujQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=x7bEGLp0ZPQA:10 a=U-hppK1rdbEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZyELlZqCvD1aXIDzc3I-:22 a=V1W4X-Ggv1dYrz-VoV9h:22 a=bt5KbKNvAAAA:8
 a=pGLkceISAAAA:8 a=8AirrxEcAAAA:8 a=8rWy6zfcAAAA:8 a=jZVsG21pAAAA:8
 a=-sF5885x1Q3Y4D_gKFoA:9 a=CjuIK1q_8ugA:10 a=BahOTcCT51kjrIqT:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=a-zEBD5cKgE7DNtTSb7C:22
 a=ST-jHhOKWsTCqRlWije3:22 a=YjdVzJdQTyZRADMV7wFX:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-GUID: aE8RHz3apo-IPCE_arOIsKvoAcL1gF4r
X-Wisc_ValidFrom: true
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270143
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

--_000_SJ0PR06MB7520F391592C5D90C5DDA5FCA3EA2SJ0PR06MB7520namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.
I will prepare a v2 for this patch. For the queue storage helpers, I will r=
eplace the macros with static inline functions, based on Stephen's suggesti=
on.
Thanks,
Weijun

________________________________
From: Thomas Monjalon <thomas@monjalon.net>
Sent: Wednesday, June 10, 2026 9:15 AM
To: Weijun Pan <wpan3636@gmail.com>; Hemant Agrawal <hemant.agrawal@nxp.com=
>; Weijun Pan <wpan36@wisc.edu>
Cc: dev@dpdk.org <dev@dpdk.org>; Sachin Saxena <sachin.saxena@nxp.com>; Jun=
 Yang <jun.yang@nxp.com>; stable@dpdk.org <stable@dpdk.org>; Stephen Hemmin=
ger <stephen@networkplumber.org>
Subject: Re: [PATCH] bus/fslmc: fix shadowed variables in queue storage mac=
ros

07/04/2026 16:09, Stephen Hemminger:
> Why are these not inline functions.
> Macros with lower case names are likely place fore confusion like this?

Hemant, Sachin, Weijun, please could you consider this comment?



--_000_SJ0PR06MB7520F391592C5D90C5DDA5FCA3EA2SJ0PR06MB7520namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks for the feedback.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I will prepare a v2 for this patch. For the queue storage helpers, I will r=
eplace the macros with static inline functions, based on Stephen's suggesti=
on.</div>
<div class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom: 1em;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks,<br>
Weijun</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Thomas Monjalon &lt;t=
homas@monjalon.net&gt;<br>
<b>Sent:</b> Wednesday, June 10, 2026 9:15 AM<br>
<b>To:</b> Weijun Pan &lt;wpan3636@gmail.com&gt;; Hemant Agrawal &lt;hemant=
.agrawal@nxp.com&gt;; Weijun Pan &lt;wpan36@wisc.edu&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Sachin Saxena &lt;sachin.saxe=
na@nxp.com&gt;; Jun Yang &lt;jun.yang@nxp.com&gt;; stable@dpdk.org &lt;stab=
le@dpdk.org&gt;; Stephen Hemminger &lt;stephen@networkplumber.org&gt;<br>
<b>Subject:</b> Re: [PATCH] bus/fslmc: fix shadowed variables in queue stor=
age macros</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">07/04/2026 16:09, Stephen Hemminger:<br>
&gt; Why are these not inline functions.<br>
&gt; Macros with lower case names are likely place fore confusion like this=
?<br>
<br>
Hemant, Sachin, Weijun, please could you consider this comment?<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR06MB7520F391592C5D90C5DDA5FCA3EA2SJ0PR06MB7520namp_--
