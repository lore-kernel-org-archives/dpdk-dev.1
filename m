Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A79C021B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Mar 2025 06:23:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FEC240156;
	Tue,  4 Mar 2025 07:23:09 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by mails.dpdk.org (Postfix) with ESMTP id D377940041
 for <dev@dpdk.org>; Tue,  4 Mar 2025 07:23:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6DeRuddxskPSN5txzAJNxLvJBGa6FaFNCLFT6nslOqb5qAzP6TEB9q4j/Rn9AXOG5M6/aPcdoR4lI/ePr7LtCLMo/mTwB5fY9I5uKowQ0hrd80LgWQtd4ytwaoKAa/AxxxNHhbe+UdbUcKCjN89dF9/DVEcRhaf1c173mNponjs4l4ofEodXerxhLExQqb1zwfKoP53VP6DHwgcW9NxbKU80dhALL3NJjopD5wNQFzI+dVBArwW3vHCLqV0r1gGPgeDMx26OqFqASdOfsZjLSuMj5TojdRqgIn9U2ivbIHbU7GtggDjVefBqmW3WdFFfWJgOrYBRDsRGn+KXLMJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pes3hRPduZkQ3v7aKxQrOcZyzpcq+5aBXIDehBKaTPM=;
 b=ehu7IQFLgEdz5tAs4YxO2TPxyONKhBFwd88ZFjBM/BAtMjJnUFl3Ne6Y3jQgeLMMlr7MBszivaYwQhs7FnfP/K3K7ILhNAGGLu5G5Ve7kRC2jK7jAm8AXOA6A7POEqxW4NaTbWzxot6+DiME8lGHJYnu1meFZrU9LQA028d+uP0Qq/oUEFHawoKefA5wSM95DA4baN4lm64vbGpChM+TkUs7arRJJtB7It1rMpXwDiaDqHGaGH1sqWORIe1SbEjzNOzPPpwRcMjT1znH0S7lwsCwv096e7E+h2XSkpLF4gy9hn6cbkdhhAowCQZGjhAs5JUp/mZLIWuHZXitCrqOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pes3hRPduZkQ3v7aKxQrOcZyzpcq+5aBXIDehBKaTPM=;
 b=UlUmqUT/mc9m9aoJxPxNv5BlNldZv27v4zwmrVss9024w6GvDMkHCIDy80gBmRwWx2N+F3bdXqgfBaMCHQjls9BtV5e7I5yUHGhUYhPG4UkleNOHfuvNams01MP3Bq2K7LeVT8YKv3jBvh0wP8FKnLiy+aPddAKIbcm6loR0Vrry147Z2JQl5RdJTEalrgt+q1C/fJa2xGaslUxF+MXlIV0KaqkVgAhBaJ/Y0USQqAO3XUdAqNYp9GHA4+EGRqxqZ0RUXEFuR1YpbCV/qHDkD+NIMt4No8wrFVNEpXNsPqOjpDXHxhWQha+otWkieijxWeBoc0nzHKrJj3UmC/D44g==
Received: from SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 06:23:06 +0000
Received: from SN7PR12MB6909.namprd12.prod.outlook.com
 ([fe80::716f:b388:7768:7525]) by SN7PR12MB6909.namprd12.prod.outlook.com
 ([fe80::716f:b388:7768:7525%3]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 06:23:06 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Yang Ming <ming.1.yang@nokia-sbell.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 2/2] net/mlx5: improve log file path
Thread-Topic: [PATCH 2/2] net/mlx5: improve log file path
Thread-Index: AQHbTUDtWlY/UYCZrEKFHLEb+FG5y7NjAP8g
Date: Tue, 4 Mar 2025 06:23:06 +0000
Message-ID: <SN7PR12MB69096FB0FD4930E9CE8A8F80D0C82@SN7PR12MB6909.namprd12.prod.outlook.com>
References: <20241213092444.2987-1-ming.1.yang@nokia-sbell.com>
 <20241213092444.2987-2-ming.1.yang@nokia-sbell.com>
In-Reply-To: <20241213092444.2987-2-ming.1.yang@nokia-sbell.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6909:EE_|MN0PR12MB6222:EE_
x-ms-office365-filtering-correlation-id: c99f27cf-3449-47e7-d135-08dd5ae506be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HcTUyBBLczYurmwd5RmtGXXhXqgg+YhOS374EhnzcvtsysRMyankjFrK5Ger?=
 =?us-ascii?Q?XOmZNqoqz2IcoPdS0Z989lp91vmKW8E41RSG9/XJKz5T+qi6qzDEZZp1v9D6?=
 =?us-ascii?Q?qWbq56VnZLlmHy35rLdf/kJoZve/3RBKOXQtaKnlbGXtM14E0ZMcxH3SSA7p?=
 =?us-ascii?Q?MY1C+XjRDiaj85pg2O0XAbi/wP8XOk+cV2cJ55UQ3Oz07kS+bJ+poK7uRqHM?=
 =?us-ascii?Q?pqTgW/sTkPFPxp0TJENncZmUKf5ET2sNmFOLLL25bXrPN6qQGwVjqIlkYz4w?=
 =?us-ascii?Q?LU1p1rhsXlwCz83J0hdr53sMqQaqz32sbFELshxDmnhzZicqPoWqbQ8WpdFQ?=
 =?us-ascii?Q?HfA/imnMEy3YrycEW0djvpf7fA2PA4IrzlAxEGSFu/n4zB8ePh+y4KeIeKN/?=
 =?us-ascii?Q?+GZDJRKy8BHrf0pPKSPnGDAoaSAmCbvmi9g2bWMlFbJfCzryqwce9vFtX6Nu?=
 =?us-ascii?Q?LTkza7b4aGdL02qbfshhfoYIYHud9vbrWsH0s0PIo1Zq1Ww0jBCHuMxAAPLv?=
 =?us-ascii?Q?vg6dh7IdQzq48y5r+JWV8MkM2+4yYzcb3v5zcdO8ThZC8R0N76ukxYugNlwM?=
 =?us-ascii?Q?ztO4GUQg9TGEucrCwOTwnK7WCKkOtk3kmdRZRczxdYnHDiUSPI9pWijKcxD6?=
 =?us-ascii?Q?bWEMRM/Vz1d6JHUvi0lQ04CtAAPlFetVlH0lqlwEr2Kjd5T1rCNp0cisfofq?=
 =?us-ascii?Q?uPvDmdcian62nTpXcN92WmDb4B1Tv6IKSoXXFlHwGuTXQajH+ZPx4rHsowp0?=
 =?us-ascii?Q?HSGAicNX/pJ5dTgpHAINf4DEB+1d/fVgTxtKZbsEOxdZPTnCD6pM90dsd2hg?=
 =?us-ascii?Q?xb3ypril6VuWObwKqfaDrNJW1Q+4qdaiyjgcbbSzrMd1Zrw4tPoGRimZJS5S?=
 =?us-ascii?Q?fAdw3PFW56ZYQKB/7d0gU/WXBIs8q6A29zmlEb+UwrxE/hE8SZtugBKMh202?=
 =?us-ascii?Q?Uu4lb0PsJtEUS2lHQJJric2Z9Yubeq1jsOraXOkQOIo+OEE1z9Ay+vyE7Lg7?=
 =?us-ascii?Q?v3Y2Gce90z2kCb30y6tt8GtnCq/43+4NGShiRoT8Rh+SNZMeIOqD1pPz5L2V?=
 =?us-ascii?Q?9D4MdUlHjRUxHcgpnVgBEu0DaQFSqJhfKwytK8/B9p5B7gxdvCDyblxaQmHb?=
 =?us-ascii?Q?VriVrGXY25UMgGj/UMMKb7fMc4ub2l1wrsKZksjOTmwa+LMMlShPp5HdoVb1?=
 =?us-ascii?Q?2FSSWXYcCSy4n1pao4TJjR6IaBudcDo/iC0XiyHyfxCGaTNovbKzs7dHAYFg?=
 =?us-ascii?Q?wr6oUFP89TC/7IeMZqIP+1iX0IBN35tw3H3UVXfTfX1O92rJcBgRCFKtd6bJ?=
 =?us-ascii?Q?w0+9FO0mf6iUszPa3o9jGtsbwqkuYOSumF1+bSnLZsbRnkMFT8G2sLmWVSJi?=
 =?us-ascii?Q?/bW6AMiuK/EzN0CoOEzmByUPOr1lS+O8GWjXMi2GPhsnsWhfeISb9T1GXX1C?=
 =?us-ascii?Q?D1MbDTi0gm4PiZ0hOqS6L1+rzUwrsbbl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6909.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?At+YOxohd3UkaEvKFdHCTZb5KKv+/cTOqayxf5R/w812+B/wZq/XCxgLdRlj?=
 =?us-ascii?Q?F0fcrxm74sgslePLaAE32/u9jGEetFTQHlU5tPfFHqIsm4Aujl7tMBYhKKH3?=
 =?us-ascii?Q?3mDzQ2u8HpzIaSfNWvfrFetYssNsuyXRSN4Ckg/30lt454EhBuzjtzmCiYVQ?=
 =?us-ascii?Q?4olumlnx17i2D+dKAqSVRl9Utm3kmP7yCUhnr1n/j75b9EJvT2KfgAWJrvQP?=
 =?us-ascii?Q?gdFGfrcVok5ZebaFCodi9hPwe6QPVv9cXbc+TRTKWPYUcm5ZdYV7dXCBd2kM?=
 =?us-ascii?Q?6x1N+2psF0X98Svy8TpjVGlmdnH3LWP/jxvc26p9NdHQ7wwbvJ8uqqv5Rzij?=
 =?us-ascii?Q?hrxHz3/icFU5TRxLBIhq2G8ae0dcTyZsB7hUtHc647JSL8DWWWju4ZCevgbZ?=
 =?us-ascii?Q?SvW4aVElVaBklZdV7H5Y3K1FhWxExvH/EcqpsSMkYeNdD8IBJzL/8u7SZL59?=
 =?us-ascii?Q?HLAlTantCScb4+1EclijVOM5d8lNiDGpecydsawmvfAzm6JtCxDJZjAtTRaj?=
 =?us-ascii?Q?D6bDDM0n9MG5i0PhUhIfBG3lYjA153lJ5W183f7WucaJiJeAQTtgGbYrDvPH?=
 =?us-ascii?Q?MFzoSRMImthrfr+LgnN768L7iingEivViEB+Q2tJ1HIJnlJXChS6ZKSGVQ3t?=
 =?us-ascii?Q?6w71x0lylUAHwHmVlzrZ/TT2QWGbGd9PaxENGeJW7aMsH9SecrpLZEQ0syyt?=
 =?us-ascii?Q?IlGwLvRDiq5tlakzr7hy4izZW/Vgc8lskuqQ920poxmPx9REDuU5DTIxR7hm?=
 =?us-ascii?Q?wAAsrMZVMh3xmP1unNhBISG0Xw7isGVNuT675axwjYPLwh33tVgLm8b1YAQ5?=
 =?us-ascii?Q?BaDvE2ZKymKCR4O2zerggXGJMWFU1vy7dlmcSijNwKZLRNooI4la0/dLka2J?=
 =?us-ascii?Q?OTmH7/DoFsRAYW6c4e70gOgS89BD4RKsjJvtEOqVFu7QGHjQAVKvZENv/mox?=
 =?us-ascii?Q?/9p4qv3EuIqd2HZqDHif8kJAnhbwKLeNEC5cibMHquI7LUI+rIozyFq16tKY?=
 =?us-ascii?Q?2WF50qWy2BjMCj+ZP+lEn6N8nNVuOy04X617pDZOTmGO5h42pTO+57O4bHkt?=
 =?us-ascii?Q?4o434wRuivxxMqwpt6eRq7ZXShKNMRpxkwWUprAgFcKIla4mYwd+qN8mN5xp?=
 =?us-ascii?Q?rd8GTW3U8NYaHFgbw8HsdBtx5/LkDkqZllGmokr2zj1rWYbR5Bd7BJGvcx7Q?=
 =?us-ascii?Q?IP78qPTIo+z7z19C/ON0dvPpmb6PP/+azUp/M1q3/w9c0/8eN9DRXkgTfAao?=
 =?us-ascii?Q?dfmnQfVnrZkhg96EmsWmxCL14VY/IXoXACeiU9PD52gBNXGxWoIX2xXOyISR?=
 =?us-ascii?Q?H5oJbHuQSJwTXeeinP/NhfBsYE7erwZO59u5lD1C+91CPcG96pc+biUT2Fz7?=
 =?us-ascii?Q?0Z00MUWkFhfnCWo1ZbdKSO7EAP4wzXb3sVgv9+iONegSMQFndykAj4EwcCm8?=
 =?us-ascii?Q?1uvanI2qhrW+OhssJmQRJIDtFcjzXvGe0/VXV3+dRCTGqK/d9JGmPyvY/g9v?=
 =?us-ascii?Q?CorquVJSq+NOHwOHHJg8ihHjjEPZtmhhSdrOw9VZtEDdYUHKGW5/fAmWTB0o?=
 =?us-ascii?Q?fZxqgLXLFCPbIeDx6t8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f27cf-3449-47e7-d135-08dd5ae506be
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 06:23:06.3178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ebgno5bw/Pz9/fiBzQeZwSyyr9iBMo95QRfe8ntwSkUba+PIJEDr0DRMebNF1CGvLWskaCgRIh+CqKvXL4C/Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
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

Hi Ming,

> -----Original Message-----
> From: Yang Ming <ming.1.yang@nokia-sbell.com>
> Sent: Friday, December 13, 2024 5:25 PM
> To: Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Cc: dev@dpdk.org; Yang Ming <ming.1.yang@nokia-sbell.com>
> Subject: [PATCH 2/2] net/mlx5: improve log file path
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> 1. /var/log is hard code which is not a good coding style.
> 2. /var/log may be not allowed to be written via container's read-only
> mode.
>=20
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> ---
>  drivers/net/mlx5/mlx5_rxtx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/mlx5/mlx5_rxtx.c b/drivers/net/mlx5/mlx5_rxtx.c
> index eadadcdffb..a0da73c9c3 100644
> --- a/drivers/net/mlx5/mlx5_rxtx.c
> +++ b/drivers/net/mlx5/mlx5_rxtx.c
> @@ -12,6 +12,7 @@
>  #include <rte_prefetch.h>
>  #include <rte_common.h>
>  #include <rte_branch_prediction.h>
> +#include <rte_eal.h>
>  #include <rte_ether.h>
>  #include <rte_cycles.h>
>  #include <rte_flow.h>
> @@ -311,7 +312,7 @@ mlx5_set_swp_types_table(void)
>         }
>  }
>=20
> -#define MLX5_SYSTEM_LOG_DIR "/var/log"
> +#define MLX5_SYSTEM_LOG_DIR rte_eal_get_runtime_dir()

I agree that using the fixed PATH is not a good practice. Can you ensure th=
at the runtime DIR is with RW+ permissions?

>  /**
>   * Dump debug information to log file.
>   *
> --
> 2.34.1

