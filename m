Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ACBCCD19A
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 07:44:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9194240281;
	Tue, 18 Nov 2025 08:44:43 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by mails.dpdk.org (Postfix) with ESMTP id 9D7A140150;
 Tue, 18 Nov 2025 08:44:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9TNfgVz1iHxjrYlglkr2/GKXg4n07J01J6dBLcg2Zhi1Oi8vDVyQJPD1y0OdLJyvUuXYdomQrzW0a6r7v0DNrPn/PWs2oTy0gCYIbHYs6bAvu8DSqaA5QzC6Fvg8ULlAnCGIxc2LX51HL3UXfxEdv8HnwRUj1hRaKEoyDUUQZrZs+G1M6Lv+Q/EBXzGeXG7RqGCdto99tAbBsTgA08MkXf/jmCmhYe95iMFWYApzq1oQKGWuY2JNWyoHmSYVVuiYUpUdRRv/xCNCGxE/0Kqhs5uIdtJHhjQKrXOszM3tHe0Y93mg9FaU/cFQQIp3xmT0VRzwNcVbfrNnyJPayXoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX1/lrJ4P9Wqbv26bzAzTjhTK9JtycZbovUkDVel12o=;
 b=KNjUyigzEnmZs9RkxjpCzFBMlpyOwOletWQAQxLz6YOsOEPuYplGgdd5UJUhqKEC2Uhx5rubVPO+FM8Irq6PRDTjO83+nolU7Qi+zR/M8j5jbnRaPgOgvs3i33misKgWgovsZaot13/8eBt4LlmGFKgqPIOGfDcD2Pw2fkmKzhlU8/JCB0kVSwqVUfROhQrfQIyUz3KI59xh0DhKhfOh27NVCPtyNwevqNTx075aPO5SbRSU4E3gdztfXI+KFNxIjpb8LVnbEFNLH/BggmqwrX15z2W0UPO+L32G44JeyovgW8cDfMR2f86Zxe+ngQ4EKFqNOVOgKpXak7mROuZHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX1/lrJ4P9Wqbv26bzAzTjhTK9JtycZbovUkDVel12o=;
 b=fWmAZJzsW/5BN9rOXyuTtENE/2sQkbBQnlKqAdgehAzGQ12LDdVNnXsQ0tLtrqSKGvvkKH+CucCe8VL6JqGHnvDuiWYhBXhqJrm6kdXm2JfCuBxueX0tetOXTZZKh21mmhLAcRlfN4dmsoRHWNo0pdMkMIcaV8bUZ78pUtHUlBwsyVdarBiWwNoyFdBrigJ28oDSgttR7rN8XysQYEE7M63kj17IwdfYUxkFDcbNxbWOTqIK1dkvMaH0nB6Sr8UpYTlv/Um/5b69R3B6xUJQ40HDlHRZx+nrLaxz4L6XXPHBS1RUJxfGIvx7Pk3+5xse++L/b2MR71WrCjmuWtf4Vg==
Received: from IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 07:44:38 +0000
Received: from IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7]) by IA4PR12MB9763.namprd12.prod.outlook.com
 ([fe80::b979:500f:1457:eab7%2]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 07:44:37 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Itamar Gozlan
 <igozlan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/mlx5: fix higher flow tag indexes support on root
Thread-Topic: [PATCH] net/mlx5: fix higher flow tag indexes support on root
Thread-Index: AQHcVaPJWmroSbP15UCCFSOv5ZXyRLT4EpoA
Date: Tue, 18 Nov 2025 07:44:37 +0000
Message-ID: <IA4PR12MB9763D2FCFBED63E2F52C7A2CD0D6A@IA4PR12MB9763.namprd12.prod.outlook.com>
References: <20251114201720.1639238-1-dsosnowski@nvidia.com>
In-Reply-To: <20251114201720.1639238-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9763:EE_|CH0PR12MB8580:EE_
x-ms-office365-filtering-correlation-id: b5878daf-972d-4183-1e2b-08de267652d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?K5k+riN8rwzmTl3mktrzBPw2LWvEtCLbfBBoZHxang2dDqNpCD04uFiLjTFt?=
 =?us-ascii?Q?HK3k7wOj6BoxR+aG0PdwcQ/GN1xdbPfc4J4fuEU+rF9wDVZ0s5OI/TI8H6L+?=
 =?us-ascii?Q?M2ArlSdZkxCC3jqMpOdRhHTIWlbXMJo+4hmXQK0AYt7g79nylNvYXpSVOotB?=
 =?us-ascii?Q?IH9Jq8rU3sIyZBznbluUQE39tuRgzLPQLY67b6xvt4cPiHp1VmZ+vR6pLilS?=
 =?us-ascii?Q?Vrisv1oUkN69wT4zH7hkvRJ1HArL2I51/8NXDJ8q4JQXmEKykgSAjMt3LXuB?=
 =?us-ascii?Q?J7LSzZ152mTVLWsIaJfyg0RFz3eNs9MFfgxrsO3tg3CeIlIUAvle6DLDz5Tt?=
 =?us-ascii?Q?S9j/+aNeRnVZQMRFInkVJQaCHqemYVnRkhZRaJlYw3+6/PpyfyGoikWGXdEA?=
 =?us-ascii?Q?rJMjvgTs3QDxJtuozgoXekaWHD4WBncU0kE9tjWz5IgWviVgTi1ff5Yn51jh?=
 =?us-ascii?Q?0CkW/8VpulZMFd9QvOCnrf6EtpDdyAB7vzKCBE+l9gdTwhRluzFOVmDkAOVN?=
 =?us-ascii?Q?wYhcbjOyL3C/vbAHLHTxd8AeeXuhHiCpvPsYBbU19ZrIMWFsYW0gMjWZkJow?=
 =?us-ascii?Q?lDITJRTkuV4qXkZ3sOhjJWLraoi508uDVNMS8zps0VMIJVPOPLOKye03gS2g?=
 =?us-ascii?Q?pOOgFnrU01Z6Yhm+z9TN5XVFFiGq3/RDPqr6TL5oAc/msh+wSTHeM5hDKYkY?=
 =?us-ascii?Q?RTF8/+WmaI5F0GLxJZXEOx1rqC268Kgx05y7APaGUV1pNo+Y0e8/r++7yMiY?=
 =?us-ascii?Q?Hh0/933x4dnTzCLufWV41n2m+rsmW4poAblYOsjJPwUHoKcwRL5Hq6PoWaHt?=
 =?us-ascii?Q?+qZ/fxmwtIyky4xCsJ4V/nZ6TC2FnMLe/Z9IjzuaS/1SFxONjORJUvGdsE+T?=
 =?us-ascii?Q?4scmqx2zJlgkp82XnkfDdMMouQib+HI8SlL1vudHzWfv2hLt3BBOkj7dB1ec?=
 =?us-ascii?Q?gbPkdLifUgKSgnMW2xkTuAkr/LDbGAW3xSGMN40JA3C+dAILyCJ8DV13j7gJ?=
 =?us-ascii?Q?HGpo963lqI7+MhkhNC/snuwtYnySNUOnHac5/oGlxSCN7IdDy8Fyv+kz3FQi?=
 =?us-ascii?Q?wKtG5UYHKgk/BIocdxzttttMRLubyUO7llPQA9ieBA+4nAIyjlWvAmW2U4Al?=
 =?us-ascii?Q?GgLbhZNEr8oZupqhA1zmiVF21Xmny1Ivp0QHcnm2XFDqSyP1yWZTfErk1ABr?=
 =?us-ascii?Q?9/75RPzgeQD+fkztTCGvh1jS1Isc5rzKLkpiSxtRWctO5jO9mEC/0QjMMkBY?=
 =?us-ascii?Q?/L6LOXv+b6uxe8Mw7aSSJ1+RGA9/zZX+enqVa7UwRhgorreyKcdly/gLfiqi?=
 =?us-ascii?Q?fYnyJ+1OL0u4asFPZcMez36M2SfhNtCjEcYyUZxBXkLucdcSqcLPyWn681B+?=
 =?us-ascii?Q?Edb51tYeYHQF/lVJtspcvLhkm+VYRe3GRfjVN3Cd7swJ14WAhDUbb76y32Oz?=
 =?us-ascii?Q?JCV5jLNmpcvGt8ovm+y2p1lTufd5aJ1qpkahlN89kPB64kye6iuRpQLSjSIc?=
 =?us-ascii?Q?LFdjX7ZT4f533uESNjj5+j5VcTX8XuP1C2QD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZ7R8u4C5y8DffAW5SIRxqcQJb2GrPzFxuYPB7v5qhLK3Mq8uwZAgvF6pJSt?=
 =?us-ascii?Q?zODlTnrlc6mDpcFlfhxhqGWz8lqNdq2UDJChOVD+P5eQOlRHQcHbiSSKAWzG?=
 =?us-ascii?Q?4z4poCcZiwT/D1Bi5mz2md6+sVHy8AYi6Mp3IpwkyYq0nh9aqH/gqQoMuzRU?=
 =?us-ascii?Q?SB7gdtAbKIDaLr74/K61AsoFEWquHg8AWYK2UBU3Lk7rRgVoIU0GbLeXGRub?=
 =?us-ascii?Q?abGt4QA65nxYIUrusqrg9MXXq2bjoKzYEt0+q9Z5u+XY0AKbfF2d7SfEFI2q?=
 =?us-ascii?Q?2h9vK33MXWpFC78u6l7C4tdqaNVIotng+mx1UInNTIdRXw7/SGUiEa3wOUtV?=
 =?us-ascii?Q?v+x5/uXpr/knbynCiURPE/Nos8ubAKuVHNjyh+F+faxHfOx+lOIhUbG11TK+?=
 =?us-ascii?Q?PP3VtXeWI+oBf8gThjQz0JbEyzoCbNONt/aZN7SdD/Za/mJahNkiQP9q5qNH?=
 =?us-ascii?Q?hrnYDvXsA4zY8BiIBFt7vm3Bt/L2EhpB6y5cPpX0YlQR8bIqgmQXuGhzx3fH?=
 =?us-ascii?Q?ogYCwLrA503Ll6je4pHa9oWfmNbl0oov5E8OxKGrl5gfVfSTdYJnjSfYyrir?=
 =?us-ascii?Q?Rg4Y1/dnXTWh9V7gVdbGri1AJ5w7uzTGkQyKclLGbohzGwqiaR/LLQ3g8VHP?=
 =?us-ascii?Q?7Ve1L/xp6Jq0u1aJt7S1CIu1xi7HcT3PRuC0czTlP2twApHoyKPEe+8Z0Xpp?=
 =?us-ascii?Q?nR5YOK/Mxr/8wcC3tSFMsORttBJe4JYq8mjJKUGjL1xHPr/g9sNuVQw4QgjP?=
 =?us-ascii?Q?r9tll5RfnaLmuxNoYrslVhvqEL9Y2Yxi8ZBxhi9uaAsvGmCab6buTEzI2Qzm?=
 =?us-ascii?Q?vua4snhBJgPuT1hROCoqDM7w9xfIQIr8y2QNAqxZMPsw0gam77u2NE3AZ+No?=
 =?us-ascii?Q?Tf88tE3GC0iIwFSj7ja+H9AyRYUvlvlgM2MA9WrwA61rxIM6pTQuL2t92DBJ?=
 =?us-ascii?Q?vYUxClOqFoEntdkcyVqaZBDgSm/mCCxcjpwvXoriYTsUgGvOiLtYMXnz/h1b?=
 =?us-ascii?Q?jLciW6F8PDEQ4oxo2JvVEnWY4aLDjkTX0T9Qb1SYlV9VlzZPT49AW/rrElie?=
 =?us-ascii?Q?N3TMLr5xQqGkNbG1VsGVR6ipGpLrONsHEUG6ar66pxgPl4ZG0P6k+VDdlqk6?=
 =?us-ascii?Q?aDUfkvLRV3ZXAEJVhNm0/OfuIAeAPdccawUj+wcirUjHhwGGde0wL71mKmPJ?=
 =?us-ascii?Q?hYUIThqj96ibbuJU8ZTrMcLRjmVWG66jo+rWFs0cNbhaxdoe1SqecdXCZCHI?=
 =?us-ascii?Q?ybtxtDMBfR0SUP9HfDfzAcON46sYb6CX4CdutaqCKQdwNdYEE+sm7/Yhr96q?=
 =?us-ascii?Q?0JpnHH0Cf2fYX5VkkpDLAP/n3gd5xgJ+8qvMA3tbGJUFh6JbmgLhNUKvE609?=
 =?us-ascii?Q?9y797NUW5crkMoa3Mo90wSHTUSS+WC2vcSIU0lx/GYeMfQlNsmyfEBWz9MtS?=
 =?us-ascii?Q?vnUg8oFZ6mVna8AZi2/Eyadr6BFgnvrdZc9afgTko7qzVwBmcH/SEda/nQyU?=
 =?us-ascii?Q?PP5r8lOC8fWCMe840rKKPyc9sDj4ah/UM1+zmZaOT5QUeZDygcTJHW8vGPae?=
 =?us-ascii?Q?7LZOCqjQ6sbHtlelWP4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5878daf-972d-4183-1e2b-08de267652d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 07:44:37.0390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUWJ59Z5oCQnLEuQcJX1/ilB+FHJHZnRI/UuFCJ/nlUNOle0GtRIClrMBNQZgnx2p6FLf3+ByapZThi9+w9XFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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

Hi,

Code LGTM, but I have 1 question. Does the root group really supports so ma=
ny TAG registers?

If not, do we have a need to translate them and pass to the driver to get t=
he return error code from the driver then?

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Saturday, November 15, 2025 4:17 AM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>; Itamar Gozlan
> <igozlan@nvidia.com>
> Cc: dev@dpdk.org; stable@dpdk.org
> Subject: [PATCH] net/mlx5: fix higher flow tag indexes support on root
>=20
> Offending patch introduced support for additional flow tag indexes with H=
W
> Steering flow engine. New tag indexes will be mapped to HW registers
> REG_C_8 to REG_C_11, depending on HW capabilities.
>=20
> That patch only handled tables created on group > 0 (non-root table),
> where mlx5 PMD directly configures the HW.
> Tables and flow rules on group 0 (root table) are handled through kernel
> driver, and new registers were not addressed for that case.
>=20
> Because of that, usage of unsupported tag index in group 0 triggered an
> assertion in flow_dv_match_meta_reg().
>=20
> This patch adds necessary definitions for REG_C_8 to REG_C_11 to make
> these registers usable for flow tag indexes in root table.
> Validation of flow tag to HW register translation is also amended to
> report invalid cases to the user, instead of relying on assertions.
>=20
> Fixes: 7e3a14423c1a ("net/mlx5/hws: support 4 additional C registers")
> Cc: igozlan@nvidia.com
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
>  drivers/common/mlx5/mlx5_prm.h  |  6 ++++-
>  drivers/net/mlx5/mlx5_flow.h    |  3 ++-
>  drivers/net/mlx5/mlx5_flow_dv.c | 40 ++++++++++++++++++++++++++++-----
>  3 files changed, 41 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/common/mlx5/mlx5_prm.h
> b/drivers/common/mlx5/mlx5_prm.h index 5db8d67cfc..ad3cca5bd6 100644
> --- a/drivers/common/mlx5/mlx5_prm.h
> +++ b/drivers/common/mlx5/mlx5_prm.h
> @@ -1205,7 +1205,11 @@ struct mlx5_ifc_fte_match_set_misc5_bits {
>  	u8 tunnel_header_1[0x20];
>  	u8 tunnel_header_2[0x20];
>  	u8 tunnel_header_3[0x20];
> -	u8 reserved[0x100];
> +	u8 reserved[0x80];
> +	u8 metadata_reg_c_8[0x20];
> +	u8 metadata_reg_c_9[0x20];
> +	u8 metadata_reg_c_10[0x20];
> +	u8 metadata_reg_c_11[0x20];
>  };
>=20
>  /* Flow matcher. */
> diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
> index e8b298dd1d..fa2af91d66 100644
> --- a/drivers/net/mlx5/mlx5_flow.h
> +++ b/drivers/net/mlx5/mlx5_flow.h
> @@ -1833,7 +1833,8 @@ flow_hw_get_reg_id_by_domain(struct rte_eth_dev
> *dev,
>  	case RTE_FLOW_ITEM_TYPE_TAG:
>  		if (id =3D=3D RTE_PMD_MLX5_LINEAR_HASH_TAG_INDEX)
>  			return REG_C_3;
> -		MLX5_ASSERT(id < MLX5_FLOW_HW_TAGS_MAX);
> +		if (id >=3D MLX5_FLOW_HW_TAGS_MAX)
> +			return REG_NON;
>  		return reg->hw_avl_tags[id];
>  	default:
>  		return REG_NON;
> diff --git a/drivers/net/mlx5/mlx5_flow_dv.c
> b/drivers/net/mlx5/mlx5_flow_dv.c index 95ca57e8c4..2a8bdd498e 100644
> --- a/drivers/net/mlx5/mlx5_flow_dv.c
> +++ b/drivers/net/mlx5/mlx5_flow_dv.c
> @@ -10560,8 +10560,8 @@ static void
>  flow_dv_match_meta_reg(void *key, enum modify_reg reg_type,
>  		       uint32_t data, uint32_t mask)
>  {
> -	void *misc2_v =3D
> -		MLX5_ADDR_OF(fte_match_param, key, misc_parameters_2);
> +	void *misc2_v =3D MLX5_ADDR_OF(fte_match_param, key,
> misc_parameters_2);
> +	void *misc5_v =3D MLX5_ADDR_OF(fte_match_param, key,
> misc_parameters_5);
>  	uint32_t temp;
>=20
>  	if (!key)
> @@ -10607,6 +10607,18 @@ flow_dv_match_meta_reg(void *key, enum modify_re=
g
> reg_type,
>  	case REG_C_7:
>  		MLX5_SET(fte_match_set_misc2, misc2_v, metadata_reg_c_7,
> data);
>  		break;
> +	case REG_C_8:
> +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_8,
> data);
> +		break;
> +	case REG_C_9:
> +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_9,
> data);
> +		break;
> +	case REG_C_10:
> +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_10,
> data);
> +		break;
> +	case REG_C_11:
> +		MLX5_SET(fte_match_set_misc5, misc5_v, metadata_reg_c_11,
> data);
> +		break;
>  	default:
>  		MLX5_ASSERT(false);
>  		break;
> @@ -10825,8 +10837,11 @@ flow_dv_translate_mlx5_item_tag(struct
> rte_eth_dev *dev, void *key,
>   *   Flow pattern to translate.
>   * @param[in] key_type
>   *   Set flow matcher mask or value.
> + *
> + * @return
> + *   0 on success. Negative errno value otherwise.
>   */
> -static void
> +static int
>  flow_dv_translate_item_tag(struct rte_eth_dev *dev, void *key,
>  			   const struct rte_flow_item *item,
>  			   uint32_t key_type)
> @@ -10838,7 +10853,7 @@ flow_dv_translate_item_tag(struct rte_eth_dev
> *dev, void *key,
>  	uint32_t index;
>=20
>  	if (MLX5_ITEM_VALID(item, key_type))
> -		return;
> +		return 0;
>  	MLX5_ITEM_UPDATE(item, key_type, tag_v, tag_m,
>  		&rte_flow_item_tag_mask);
>  	/* When set mask, the index should be from spec. */ @@ -10848,8
> +10863,18 @@ flow_dv_translate_item_tag(struct rte_eth_dev *dev, void
> *key,
>  		reg =3D mlx5_flow_get_reg_id(dev, MLX5_APP_TAG, index, NULL);
>  	else
>  		reg =3D flow_hw_get_reg_id(dev, RTE_FLOW_ITEM_TYPE_TAG, index);
> -	MLX5_ASSERT(reg > 0);
> +	if (reg < 0) {
> +		DRV_LOG(ERR, "port %u tag index %u does not map to correct
> register",
> +			dev->data->port_id, index);
> +		return -EINVAL;
> +	}
> +	if (reg =3D=3D REG_NON) {
> +		DRV_LOG(ERR, "port %u tag index %u maps to unsupported
> register",
> +			dev->data->port_id, index);
> +		return -ENOTSUP;
> +	}
>  	flow_dv_match_meta_reg(key, (enum modify_reg)reg, tag_v->data,
> tag_m->data);
> +	return 0;
>  }
>=20
>  /**
> @@ -14408,7 +14433,10 @@ flow_dv_translate_items(struct rte_eth_dev *dev,
>  		last_item =3D MLX5_FLOW_LAYER_ICMP6;
>  		break;
>  	case RTE_FLOW_ITEM_TYPE_TAG:
> -		flow_dv_translate_item_tag(dev, key, items, key_type);
> +		ret =3D flow_dv_translate_item_tag(dev, key, items, key_type);
> +		if (ret < 0)
> +			return rte_flow_error_set(error, -ret,
> RTE_FLOW_ERROR_TYPE_ITEM, NULL,
> +						  "invalid flow tag item");
>  		last_item =3D MLX5_FLOW_ITEM_TAG;
>  		break;
>  	case MLX5_RTE_FLOW_ITEM_TYPE_TAG:
> --
> 2.39.5

