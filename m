Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA319CC6B3C
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 08:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE66A4025A;
	Thu, 15 Oct 2026 10:21:56 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010007.outbound.protection.outlook.com [52.101.85.7])
 by mails.dpdk.org (Postfix) with ESMTP id A2DF040041;
 Thu, 15 Oct 2026 10:21:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZ1IIGaHAU0Mo8lqAKERZSKForyPAxiHmB68YVAyfRi/VVfqKT0D48Eayz9PRLM8hx/pLok0P/4jgG4rwUp03Z4H5tpjUoH9VnewkIqr4A5XvZjXHnbNQY4gBn2lReLt/2Vp8i9tHFXNkMkPX/L9n+l1dMcJptuOlXzqYDR6Sf6WjtmjqbsDW1pu/nfSnw5MgxZxFkGre7o9FChBX4C89YI5/0UrCbzFAjgA1BPOHy9OOdWw21azF0qlsvIGOnw4J+CY6tg0f5pxaILirJBGAVW48Z0bVypfQhub6PkD7heeQxltGHcQZapcKbCYSLyUUVq2C86TZV9SDZTExHr0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qsqd7ZYQxVFwASI9aZh4e5Qj0vyc7sXCYyMt99CDwVQ=;
 b=faZENbUw7kIUdk4Sg0UGZ+jSfB8/Fjb23NYEep4iRr7bacMoRm4c1t01qb/pQrF7P65na77F7Jd7fLRlxRlTaKRmckDj4Aj+45B0vRzDXFnjYi4JfvcxsnZiMll/+UQSVXhNQu8UjMFUiWLtANTfSW7QYMteuCtYWC5CePfaZUmAiN9z0ed42k+cRlJINHDYWeMv19Vdc6qSLH6fDqqB/fbRnNoSU4S67qecly3uuF7MhXJgLl98TzE/xrCnLiSFq/H5gv8hzPTKSWm3wlvFBoem78xpTN27Q9hUPe9FCPdWiI9OfDvvjrmrPrUAjPgy0/5syo5O5eSUDUYGyhuOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qsqd7ZYQxVFwASI9aZh4e5Qj0vyc7sXCYyMt99CDwVQ=;
 b=YkZvg9JuUHb3WaoSh8pbGW3+/S414Ii2wT425Kw6s2iIzfHZbzgITlebAGq2ZjCuCAMIiLTp5C2YaRTdf7E1d3MNMm6oZwKUyu29evIObsfj0ysaGo5XE0LwoG9H4wgx27SZqTxZw4q4nD3sZ7OZdhiB1BUQxfT+h7De5pe9FazP7dzqxTEUJSFTJn7hKfimbkPTdLoFh8eNRxC8sv481vu+Wa97ydOkruhGwk4ruglefy/vzb3eVSipHSbue3fQ+nwJOreiJIMBbT8zaRenQoJ9YPSoz0PHyzWmQbAMJCJa94qnUUQwpvWn8youzmzPc/r1gzNFrTnQYy92Dxcolg==
Received: from MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:21:51 +0000
Received: from MW6PR12MB7070.namprd12.prod.outlook.com
 ([fe80::4fc6:295e:d915:3efc]) by MW6PR12MB7070.namprd12.prod.outlook.com
 ([fe80::4fc6:295e:d915:3efc%4]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 08:21:51 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Pavel Ivashchenko <pivashchenko@nfware.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, "mb@smartsharesystems.com" <mb@smartsharesystems.com>,
 "andrew.rybchenko@oktetlabs.ru" <andrew.rybchenko@oktetlabs.ru>,
 "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 "mmamatov@nfware.com" <mmamatov@nfware.com>
Subject: RE: [PATCH] net/mlx5: restore fake mbuf guards on Rx replenish failure
Thread-Topic: [PATCH] net/mlx5: restore fake mbuf guards on Rx replenish
 failure
Thread-Index: AQHdTFjRZ0xnDIcJ0kehFva9VappC7b+Y4YA
Date: Thu, 15 Oct 2026 08:21:50 +0000
Message-ID: <MW6PR12MB707053B7EB052D1DA973B5EFA49C2@MW6PR12MB7070.namprd12.prod.outlook.com>
References: <20260924191303.18938-1-pivashchenko@nfware.com>
In-Reply-To: <20260924191303.18938-1-pivashchenko@nfware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7070:EE_|SA1PR12MB8162:EE_
x-ms-office365-filtering-correlation-id: 00005b9d-0c1d-47d4-f37a-08df2a955d20
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|10067099003|3023799007|11063799006|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: z3DAekYxNUcjjBFfDEgNCGiCE9FFpmJMis6Gtqp9BeO6Vu63Ep6hnbMV/WnPOadYzmuRvbb1rr+2iCcoM2dAtD8W03Q29U6GWdStBhhRT94TfNIdYOLGepHc6WSb1mJoh7WL/xk021rygVG7YNaC8iGUs+gGy6jfRYk6tRj3gRh/ZRqvjYwRnkXGZ2oK6TeTFHoGtVL8HOxmab4TFaNDzZM3OTtJU7LCWGYdJBJXUTylWTWCYKUBsivb66PpKdrbRSWjh96RT3BGnfH3eN0h67qduHFC45iC5Ya8Dw52lK+l5ik0Pd4NwH4ROmhPPP8D1O2Ro/pvoKbD1NmWljTMO7722OpSH+hbzyWRGf4X7W/KxHkP0johQEJW5p1vMou5R2A4OO+bCdsFKF+m1nhGa/s5RH3Rrv70/NVIpZsrpqPzZ75akgisf+Nk7j9glyNzbM2BR0fzzcCQuu/GscwamgfklnGV5bKi00bPdIHXx/c1H4qbfKSTW3EjijHENVWa2pBZ5qejkdvsxReoUT8KTre4htmE5lmOnzG3G1hqEZhr0/JlVimBqiGyzL/+gE0Udy2LjKKjp1oyyBzCdLPYE6VnPov630+JAN/r9l9+2+XG+kLlyfHreA8VEolyCpXenuEBbtlUvw6klNC2c1V29FSO7pk5ljbZcGpAu7uZHsrYJgV5QlS4c+5H08VJ+RrM5ZCQXOWL8tkEmQqWMuu9qomc7BUiJpj4QDY7a0CdZ6A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hjYrjDrqPJcF6dcHq+Y06NoWdXVxEYQ1KkWOELlXB9vZTY287daFh5dY/lU3?=
 =?us-ascii?Q?u/BiEa8A17NNGN7RiXH5JjTpAgS4Mn9BDlHAUYuKG3VoSFDBdUDoPjCJxUz7?=
 =?us-ascii?Q?NRwjFWCPk3FcxwI0QA+J+AMaXZ+VI3WH2kguky+Pthmktf3EBPurWUfRSQdN?=
 =?us-ascii?Q?ONT3CBVkti/Tk4/T8tUqUvucFIUA07FDpI7sLniKldVX80WCMWUuXmCOlERG?=
 =?us-ascii?Q?BUi0sT1LKKazFv6Ls5RulBfeNMTjz89043a5gsb4rLYGbdl952L4Z27dNNfH?=
 =?us-ascii?Q?rj8IDFUJvf+oZVq14s+j0VH2HP+nJJC4kGcd6qXJD0Dy0Oszn12QPUossH/s?=
 =?us-ascii?Q?5sJAroOBb4hIxpWTchOxKXhlcMOukQEq/dg8g4yCVLa/+Ra45vfVxIXqG8Tu?=
 =?us-ascii?Q?tesYEYmOx7IPb4276NXxNaLt/oi6YXuYkkFYhtuPv1jbB0gDAgvU6hS1yyNN?=
 =?us-ascii?Q?FY4ooPijDdScBmY/47RHAJrWd14KmDO9DhH9GCCZfsT+2JZoWPLjAjqFJYbV?=
 =?us-ascii?Q?flbq0sQ7u7vSk8WZN6Z5mI6pkVTHM2xjcgHDeQzYPpJAg/uIhykNJqn3ymeW?=
 =?us-ascii?Q?98CZsrRfY4tXGXEQEAb5Jnil4DHFxis56CW1a2aG6ki+vHmlZD8RrAyiYsSx?=
 =?us-ascii?Q?KUbHWOjV9/b7ctOxqH5MxQw2D1DLeCstRVqeEKEG6JmeeRGn2ralZ5rG8QmZ?=
 =?us-ascii?Q?O3J0SMEV8OSViaLp/xWLTFc9za9xJ+Gb42zanMClXc4ZHt2vGB9k3byyqYZ3?=
 =?us-ascii?Q?abJ96DgZ2rvxOI/4plL/cBO5PHG3KnoEMNLOQh/HyO0HWpk8NDZW/MmeqQWT?=
 =?us-ascii?Q?DNnSjjkP0WCKXrSexi+4xz73SaeZLRNBiJ+DjkupaoF2laDnoM8R93XySXx+?=
 =?us-ascii?Q?LUgjur7F0BhTgSlrp1KoUIRUX8Re91AuUHaqLhCgg25oqJt2njskZnEnsl5z?=
 =?us-ascii?Q?8slke5yJYZ8ytWtpfhGz+S8nddJlZb9FMvMjd4ah6qYkxGIKi2j77LZ0fwkH?=
 =?us-ascii?Q?Z/vZo9ybIYLfYlLiEoHjs+YKW/Gru9xL727YkAYU5T9HzdH2sPWHun0X5IZ1?=
 =?us-ascii?Q?0tW7G52Ez1grB+OI2Ctq8G5ukDu5E5+JLLL97y2rFCABzwagVbX4kpzWugfR?=
 =?us-ascii?Q?GebouWyFH3RegiLwnZXOlbs2gkG8RZYqxeFtvZMd9Ydw3FMTHMWQVh0A/jJu?=
 =?us-ascii?Q?xAFtVZSS59akmiLbFVcGHdq7Sjd22D8RswtwRHzKGUyWO7jmfXIi+yYIe4wL?=
 =?us-ascii?Q?RyduTQ/ZCGTTzCPgFyPLKfn8HAGopvhAYReFE8rdK4ZxBtjtDZkgu8QJcJ7R?=
 =?us-ascii?Q?06zjjOvzDGUccCQVG9Z9+2gPqVKUudnumjgNJx5wBbxLAXzXhKGxFWYJSwB/?=
 =?us-ascii?Q?ywgaqXJHRcU3FJFTq4bZM9qmTJ8TOcjT3hHN34gekhhmn4d6ZMWHsX1jDKDN?=
 =?us-ascii?Q?9n1ecaQ93FiMcNGDABhUphb6fUN2Pn+yrdd7BitZix8PKEPOwIZUMzvBNjT3?=
 =?us-ascii?Q?mnT+B5dOwv8QkPhZRlNFFjM7th1i7rPuJv9YXsxuolZr077nlO6JljdOp10n?=
 =?us-ascii?Q?YQx9WHW6FtFqcilG/YksiQDvFe1R8q8pNkm30k7K/PzUVX24lgVSgtlq1NqI?=
 =?us-ascii?Q?sS283vy5Ra1raps+Fyxe1RG90BV/2vAxn5AhxN5paEyPfimKSAbRd4lN1cmd?=
 =?us-ascii?Q?pi1meHLGXhMPxA0FljnuJwBprLvcgEaiM0QI1Ocw/o+6pwRN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00005b9d-0c1d-47d4-f37a-08df2a955d20
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 08:21:51.0381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdSOqM0eFl6AUhRgxOEZze2XrKM5kOw1lWfQxDKSCQ/j55Z4Y2l8gAQPuJbY+1C3R3PjlKJd4ecLqtzUUwg1vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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
> From: Pavel Ivashchenko <pivashchenko@nfware.com>
> Sent: Thursday, September 24, 2026 9:13 PM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava
> Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>; mb@smartsharesystems.com;
> andrew.rybchenko@oktetlabs.ru; NBU-Contact-Thomas Monjalon (EXTERNAL)
> <thomas@monjalon.net>; mmamatov@nfware.com; Pavel Ivashchenko
> <pivashchenko@nfware.com>
> Subject: [PATCH] net/mlx5: restore fake mbuf guards on Rx replenish failu=
re
>=20
> From: Mikhail Mamatov <mmamatov@nfware.com>
>=20
> Vectorized Rx keeps MLX5_VPMD_DESCS_PER_LOOP entries of elts[] pointing t=
o
> rxq->fake_mbuf after the allocated mbufs. Both rxq_cq_process_v() and
> rxq_cq_decompress_v() write mbuf metadata for full SIMD groups. In partic=
ular,
> CQE decompression may write through these guard entries when processing a
> partial trailing group.
>=20
> Both mlx5_rx_replenish_bulk_mbuf() and
> mlx5_rx_mprq_replenish_bulk_mbuf() pass the guard slots directly to
> rte_mempool_get_bulk(). Since a2833ecc5ea4, the mempool get path copies
> available objects from the per-lcore cache to the output array before fet=
ching
> the remaining objects from the backend. If the cache contains fewer objec=
ts
> than requested and the backend cannot supply the rest, the operation rest=
ores
> the cache length but leaves the output array partially overwritten.
>=20
> Returning from replenishment without restoring the guards therefore leave=
s
> them pointing to mbufs still owned by the mempool. A later allocation can=
 hand
> these mbufs to the application, after which CQE decompression may corrupt
> their metadata through the stale pointers.
>=20
> Restore the four fake mbuf pointers on allocation failure in both the reg=
ular and
> MPRQ vector Rx paths. The producer index does not advance on failure, so
> restoring the guards at the original allocation position is sufficient. T=
his adds
> work only on the allocation failure path.
>=20
> Fixes: a2833ecc5ea4 ("mempool: fix get objects from mempool with cache")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Mikhail Mamatov <mmamatov@nfware.com>
> Signed-off-by: Pavel Ivashchenko <pivashchenko@nfware.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Thank you for the contribution

Best regards,
Dariusz Sosnowski
