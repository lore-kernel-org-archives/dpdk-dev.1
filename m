Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD7C021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 09:13:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B177740651;
	Wed, 26 Feb 2025 10:13:24 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by mails.dpdk.org (Postfix) with ESMTP id 25C2B40651
 for <dev@dpdk.org>; Wed, 26 Feb 2025 10:13:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExiW0AlIgOfyDjMbG6+6ZoTmmrCrtaMYcJ3m/2Z50s0WOl2t9LSqWe/xzJT8Uw0tZjMAXghtPZFUKVH/lE0AapGAN+wGhluzr9K+AWkE/F1OBmzwWLooXbV1HzsDK4oIJVgeFIoUlez1lloclv1XzOCaHtww2vl4f6ePLOr+5JwRpZq3JftSIQYdQW5Vp6stuIsCG5Nev1Ft0mBuQSJn4lSSFk5Q6eiTCSYcYjHGOQPVJIuw2gEzuo9kEQcMmIYGNE1LuQgKz1CRHU56fdsi5jNQqQYuZ9FoQkTSS+jQ6F6qgB+jwtyrheVW/D1VjXGehQWomxGN4WVxWoaW8jgDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi9upOkVuzPVcacX41hJb4hocDwOEKLJ7T939L7RmfE=;
 b=b89djy3VXdcoWEB3NylUhg0jTKTuyUP+asLOYtcx7Q4NmT07jvVOfADxb7Db/S57Tqt6DVBDTQSUWDCw6LpUkN9WFawj/dj+3YntENxyQDjHAEVHoI40/8+HUUTesZ907VhfCIPDLE/lfvKwtZgYSwbumsLqbemsnhA82zGO5cbDio7r1aCNU16K54SSiqdhh8Geelc54j4fb6sFcN5GJifXOHBfw7hgprmM3Ul5N1ceru6lhykaBPceutSkVgxe7mv2EcpwZt0mHrYNBfhYff6q3r/KqK28BFy31O1hMX/i63Q4cWmG/thj/IyoLFtAOCUIo/kdNTRNwPdzNGz0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi9upOkVuzPVcacX41hJb4hocDwOEKLJ7T939L7RmfE=;
 b=VN0zShmLzdljqko9oHWZyjbewVeeem0vy/R4SAPJ2Wex1AO/+GgGKBTikNAG130S1t8b7zVyTIBfqva7VFi7vfq4OuGwIohrnRRLxNRazFK8yv5Jeu4CrPomp2HzmhHiJbvPZwcMGvUHF+hYuW/3JnJgtlv9VJTgyrhR5ntOdaj2RmUev4IUTIV+g0033u3T3z3FoSG7t41gqiF4XZOatSoZXTaaUJakYYA+WOB7XzW6RE9iFH7Ycq+mKPyX/Ghpib+zqzuV6MsDozyG5KrxE/kb/jmdgypdq76gFLTHZX6OLSGR8UmS76T35FtwYzItLJ5/c5InePzqfJxmFc7dKg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 09:13:20 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 09:13:20 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Ophir Munk <ophirmu@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>,
 "Jiawei(Jonny) Wang" <jiaweiw@nvidia.com>
Subject: RE: [PATCH V2 3/4] net/mlx5: remove unneeded FDB flag on representor
 action
Thread-Topic: [PATCH V2 3/4] net/mlx5: remove unneeded FDB flag on representor
 action
Thread-Index: AQHbiCoF1MfZz4PYYUyRC6gEgDzOzrNZTM1Q
Date: Wed, 26 Feb 2025 09:13:20 +0000
Message-ID: <CH3PR12MB84600DB6465F6DC6FFC4B644A4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
 <20250226083846.4023622-1-ophirmu@nvidia.com>
 <20250226083846.4023622-4-ophirmu@nvidia.com>
In-Reply-To: <20250226083846.4023622-4-ophirmu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|CH2PR12MB9520:EE_
x-ms-office365-filtering-correlation-id: 545aa0f0-dc9e-4ac8-1c4d-08dd5645d097
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GnNZdGqzNFTd2TFUjxFj10SJMTWyeHK2EvvEu3vXfIFQ4KjtCPZdtWjBSxyr?=
 =?us-ascii?Q?bAgDU9pIS/6eqdWha6eidUcOsnnsxIEvg4PQMH2Rt+yIkGqFE9nvaLB5SVGE?=
 =?us-ascii?Q?rfcuIriy7eJ8QBpEc+M8HZ/lv6VtsljkQRMURVr3mzuvS+UWi/QlJd7FT0Nk?=
 =?us-ascii?Q?JaNlMp/R20s6hpmISrTOYs29bcRNVKjY2uNMSVGKTP3V7U8cxttyYGXHnj0y?=
 =?us-ascii?Q?/VWUzzUDkE9RKxQ9TMcyOpY7UeH5NQSPXgc5I8rH7JQwTQJlcrh/yLWbfOjr?=
 =?us-ascii?Q?C5HRlxjh2Ff5KFMCihFGAO25RLyy7hynbXO3k7jAXAi6GNuosPH8ESja+DaB?=
 =?us-ascii?Q?vTQ5tBEzV50NezpXBaDd2qtKJmwwBwiHYnshHNfQafp0rJkA3HsZYYE1Sktb?=
 =?us-ascii?Q?YU2YvMHfMpoV819lMw+VVEeRfrpQ2sXx1R8Q1/Gq5DC1L5Y1y4hIy0+8HeWB?=
 =?us-ascii?Q?cce0Fcp4b5vX18Gy3oJ80n7BlzDhtQ331qacp6NaUUK8yJIzfVfrKHkypHgA?=
 =?us-ascii?Q?3bM5jqHVBCyYVM1Sk9FEQe98zXXa66yWXtBvdytlJUrK1UbTuwvhGs6tSZOw?=
 =?us-ascii?Q?FCHwx6BOZkIiWX2m4/+5A2sSnoHtNbR99lfd/7XfRjEYtIbkgpzFZ1oZSZmt?=
 =?us-ascii?Q?G0BNGyCZ54tOQac9ADwpWvDtqYuGCFW+jKlatgoDWXunb6Wg0aTnbTR0QsXp?=
 =?us-ascii?Q?soWqkHLeor/RPcBRltFdv5mW//NgMY4cGWuvzKwZcxLohksmVnikm46+AnZD?=
 =?us-ascii?Q?wSTrAz6lo0aGLwu/67LBd4TsXxYuG4bUX9TNLhRcm51Lniy0P878+yE36lbA?=
 =?us-ascii?Q?DLElM9BqOBrWgh8rd11PPpJZfhEg0E7Gys6M4MaDUFPai7FJ9vS+GRP9ge3b?=
 =?us-ascii?Q?yCfxmxYaRpFrC2w90/AWNtRbCvCEyl78+X2gt3/jQljApq2DDljr8nZE+//g?=
 =?us-ascii?Q?DKXF5QPBXVsyPhPFtzY021oqjQ+Hp9ty9juYJswdCGghKDLmtKHlwj0jjVIs?=
 =?us-ascii?Q?/EIqE8BjsdT7c5Lf6u3x9N+d5NQg3Uo61jXOhu5oPQq+/0tv/u3ifFtSBjkQ?=
 =?us-ascii?Q?+pRxMZ+SWnEt10Zd64Vr3D8ZsEqsPeZnoOMC5Iz8WiO2khu+jQmgkXx5PiQs?=
 =?us-ascii?Q?HHYCpSa66XHwoTncIwhA0GzmROeFAf6Y2a8lO0IKuMjWQloDt1Y3S5LOopKI?=
 =?us-ascii?Q?nVq95kzshiPPot3OghDOiFfkEmjkPyi3WgE2xJmVhofghqhxuO9md1LJzLqT?=
 =?us-ascii?Q?vxWzDETmXm0SlIThE9V2xzJmNNn2N34Pq7lnmOHondAXiaYq0/IQ0TCGtlOb?=
 =?us-ascii?Q?/wZ8inrIkTmJvazlNrDlYGoyKhAX9+gGugzlDKGA80ePfeQV6GDchPvf+5JV?=
 =?us-ascii?Q?S59NafjtCZXjHbYM6JpPYV4EyODfFXTcxCRnGm3eMR0pbQrwykHgzY11sW4D?=
 =?us-ascii?Q?G0vwlcDBIzSgZTc7PJHp+4zRLk080oTA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qwHGi8XUlr+J8Nvw0M/w0+l7uqquPmke4TcmMgAVlmHQLzMuVjoEr8E0khHw?=
 =?us-ascii?Q?5iyuMIkZGM6OT+oxdTq8r4+TYGlb1+9OUB1070TJjQwzu4YmXkw9ZXw/UvTu?=
 =?us-ascii?Q?cPELFOuBT2rWawLpRfWqCHqXwxDvyBKdUS7Zx+VbWlc0WyLk1hR7uZzkNS8V?=
 =?us-ascii?Q?ml27SYvvisd0dgJFAPU2a1ky1/IfPXabI+ksIwumnnMFW9QxWDyNjcZ4NeFr?=
 =?us-ascii?Q?3xjVER3vFRu7YJvdQZIflWNPNQ66LySUyAJSHPZX+uR+hUuxGYXX1SLMaofT?=
 =?us-ascii?Q?v3L1XtvAQhlC3Ib4XFJzUWD9XuiExkmGtAjAPS9x0eGzvk5be2ITjM4rqimW?=
 =?us-ascii?Q?EPNApfPBvqMNwhXy88oSM/Y9eKnXINFV5tsgxdfuM4E/6ECyE44dHVrxnqEx?=
 =?us-ascii?Q?xEv7PMumSv2XX8bk/FfXG+nbNI7LzfqVjNwwW065nslKsaXnqPUj7RkEnnzz?=
 =?us-ascii?Q?7XCSjYe0sFFugoIpi7dKhHdvKmRvqxWKmaU5cnD9B/WzEDrZgWqcSwwMq5BS?=
 =?us-ascii?Q?PvnYzUX257LWbpn8IJOOflQ9JZJg+Ipqd4mwbDI9bfh8RrqBJefEo0nAKwpt?=
 =?us-ascii?Q?CqywMckyXidzuUpwO0g+jLisDEQp6qJNm7oki1WgQFKFc/krXtzL5ULOdt7V?=
 =?us-ascii?Q?czb4uDM5gsAvIXzUm7TPzxHTsBnxN8KX/LobuvaSlVMdSk5YuyStM5V7LPHS?=
 =?us-ascii?Q?XmXBeEsbM2d15Z1+EAOoWrhaifqBx/Q6pvRb6/3u0xQCJrYFTQRRHAVp998r?=
 =?us-ascii?Q?vMNWOFA6BwNAV1apu0k/34+fRuVLNJWxlxpWPeGXwGP2kR3EIchZG0E88h56?=
 =?us-ascii?Q?V1WVwShsLuYzDN9+rTUaNL9CaLZ3h8DFvLY1IPl4GLOoyeGi9PKzVu9gv5/E?=
 =?us-ascii?Q?nive8doimxdJXvEhoMwGRLxshnNffbWg3qJDMZGXWVZSfl7CcolNO9sCilwO?=
 =?us-ascii?Q?uxyxt4hwrEaZYm6uSehtjg8f4rLqVsi5shdR8AOT4KCEDFWj/ddgp85PfME2?=
 =?us-ascii?Q?MHKnhQB0ev5CZzW4Z6jh2U0EBsnU+/Gj4AjObXZCCco5JHrqn3nMKPQfyCSs?=
 =?us-ascii?Q?sT3laII1i5HIpv3nFk5Q3XIUBh1CDdMaeKO6JjHasThKZpgsTN/Y3ifDuoOi?=
 =?us-ascii?Q?ircymftQZ0CqQLuvJngDkD25bRl+5MWkNGxYFuaRKbkMOq/ezvQp0twvpSkb?=
 =?us-ascii?Q?4ihC7CsgVH1cQEgMccbVBT/B4eZfOAutsX84BCoQew0WXLd7JbWYeQKJoa1v?=
 =?us-ascii?Q?SZZut3mXpYrFSCFFNAk15lzvn7aGcRrhPFbdDPr1jk3UG5WiP2SdaC9mnQZk?=
 =?us-ascii?Q?znWX05ciKmVKYXZHoxwC7MTH6Ove2O9qUeEiMYqUhFy8Ij4XyL0zKMOPCmuJ?=
 =?us-ascii?Q?DWG8gsjIjKV/+yhczZv8c+qQuBb8KPDz96bQp56IR2zqt3EUqT8RLcgZlUtZ?=
 =?us-ascii?Q?octJkhVqPmjCQxevgWgBWf4UDu2joYkEWG2NKFJcjugl00YX9TUCIxqLJ/GI?=
 =?us-ascii?Q?lZgE+PJ78abiekFFzGo7sriXFC98Ggho5Tt70j7Zp02wGy3rqFG9O1vDV4ri?=
 =?us-ascii?Q?vgsDHEDmeQ+aqIhVAE+fGz8gLAR7ueJX2DbcSoJB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545aa0f0-dc9e-4ac8-1c4d-08dd5645d097
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 09:13:20.8663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ee27A3w+jSV6rJFMcLmOG6w/DJnlrQgrVh58U/INT5xDYOVzgrQW/wxrf8ZNMtR8BFA14mg/zxs/Adv97NTuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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
> From: Ophir Munk <ophirmu@nvidia.com>
> Sent: Wednesday, February 26, 2025 9:39 AM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Raslan Darawsheh <rasland@nvidia.com>; Jiawei(Jonny)
> Wang <jiaweiw@nvidia.com>
> Subject: [PATCH V2 3/4] net/mlx5: remove unneeded FDB flag on representor
> action
>=20
> From: Bing Zhao <bingz@nvidia.com>
>=20
> The "send_to_kernel" action is shared and created during the HWS configur=
ation
> stage. By default, the NIC Rx and Tx flags are needed.
>=20
> There is only one case that the FDB* flags are needed when creating the a=
ction,
> the same as other shared actions. Only the transfer proxy port needs the =
FDB*
> flags for shared actions.
>=20
> Removing the unneeded FDB flags will help to save the resources of memory=
 and
> STCs.
>=20
> Fixes: 07836ba156cb ("net/mlx5: fix device checking for send to kernel ac=
tion")
> Cc: jiaweiw@nvidia.com
>=20
> Signed-off-by: Bing Zhao <bingz@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
