Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0EC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 223794029F;
	Wed, 26 Feb 2025 09:38:09 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by mails.dpdk.org (Postfix) with ESMTP id 1BADF4027C;
 Wed, 26 Feb 2025 09:38:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESiYu7iZnxqU9jhGycSoSoGh1hV/Stpf6fDmCyukd2mM/Eq1sB/sHY/pbveo76ylKBpw8MHQyWJJeizaUZQt1EvMkx2nbS4tOC61KMMrqslH5Y5cefyU8szYOAdMVWTB449VOIzEya+bltlC9apYqkEtZ+R40Rv59CBZFcTzbCPGjpIfKkzgnIu2/aOp5yjOIonbX8I1JYoJBxLJNgU2lTOsQ2JrhXxObuIlWitfWVKTdgNneWg+ur9nMgX/k6od2enj/TE9sFD7dPE6CXHxI/FXbdTFiq3kFrDll9JbalPjHK3nyfHboDHxnKgzzfjx+yB6JRzByQRcbPgTch/qAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7ch/b6t1jmUKTs/gOOCxttdELVkdeoKdJXRtlmew5c=;
 b=EdUw6miIWRf6WRCrmwq+a0tCmFqrC/ZV+YPqXJyGd1A4A8ZjnHt7DIH7Cf84luKF9aTz+xj1Wk0wKsa8khVU9nPuxB21ibgBpGJtA9nHVbPVO9SPTCygxvBZWFhBnl3tNP2bKnwreJcW4OMEHmmZU22jMaSBE6esK25rZWh9dBpE7xlhxB+7ZeL/a2eOW+uy4VSOm+eAUxLdQXsmpMXji5lHhv+HhNnObeySYD08fIVPHczKZDxxoooRqjBGyK0R09wh6AQdN9A9un/dr9SaFGMs0dehBWCz+LUodYvEsG0BkyMEIm3at6FjI5w5pGicsAb/QEeP7pGmJpwFXAYkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7ch/b6t1jmUKTs/gOOCxttdELVkdeoKdJXRtlmew5c=;
 b=Pa+bLMGW5CH1L9XdskzBUbPvZTGH0pbCpFTE2m6xXOoKUrlCK13J4h4o/+vGkPpZ2NX7BTI2cAokb2Qr7/C2gRc/zisumvgLZK/MI27lbln0B+SzN0byYCFl/EnYeBZXOjaBZ43GyZYwSe/FjkayIWzytYnnYfAPSK3EluHX4wSAtAPlu4TKnnkYY1ZGxwZScDHT2Vt1r6DjGrnutawPxht3d42BW7I5uYdx5OOtpz+mekHmg2aQs9rslZkpI2H3pHYeeqnL15VH1dzADvDVyNuDWbgtnZMAgGogDPqWyRDeox4y2cIM8aYjXzVEJmUGm+bgTFwaLb9LxP2t9fh6nw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 08:38:05 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 08:38:05 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gregory Etelson <getelson@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>, Tamar Mashiah
 <tmashiah@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 1/2] net/mlx5: add DROP destination to mirror clone actions
Thread-Topic: [PATCH 1/2] net/mlx5: add DROP destination to mirror clone
 actions
Thread-Index: AQHbffH0zsHXr9hCeEOf7Kl0sBb6Y7NZV3vw
Date: Wed, 26 Feb 2025 08:38:05 +0000
Message-ID: <CH3PR12MB846019EF78C7CE59248B5B48A4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250213083239.94360-1-getelson@nvidia.com>
In-Reply-To: <20250213083239.94360-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|IA1PR12MB7565:EE_
x-ms-office365-filtering-correlation-id: c15c7e3d-77ea-42cb-7b25-08dd5640e3cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Xu/ukQwLeOwzHm5Ghgzi+v/qLAooVAoDqMxamKsydYhqRcrJdci58tXBym6l?=
 =?us-ascii?Q?BhlU56SxwSHlYyNp8dqkTB70jEnbXL2zFUf4ZLbusjTsd673s7LFOufYPDJH?=
 =?us-ascii?Q?EVMq/WUFrmLmZHYjfmD7w6R1dMNNCh5u7t7exDKwT7wPQhUEbNbEB2vbXK3L?=
 =?us-ascii?Q?+1li1PEYnSztu+W2yLE41zBPpv3QuvzW5q2Fl4G7oz4RP2GwBzQBavmRXaDA?=
 =?us-ascii?Q?ytOmQfABQtHxfIbaBJXkBOjvDl/BkoDOjTO4POX37XTdy8CdgWFb8gayQMq+?=
 =?us-ascii?Q?zdP26ApKWQKUVjETX1L+SD5kxetqhGAac4+c0fhfvVs1NLX6stJQ9avKvHz0?=
 =?us-ascii?Q?qycTLt69ohZbFYD3gug1hQVtgfWxUSwupP9AADrld0akelGHGwn/73WPbYmv?=
 =?us-ascii?Q?NKJ8Xv/XhWFQO1eU7qV8S+aLBLAMus0hMdVo6t/a47wZGNBzrPBp8aRKQX9k?=
 =?us-ascii?Q?qBRw+Vc2GNxoYDI7g7Eu2iWRpTvdXFli0HAEDOMBiGeRXXrie04i8kYlP6X/?=
 =?us-ascii?Q?YYg9/Qy2nrQ8AAnTlMDdCS8RBF9Mh5VPyyI9IvPD8P5+EEKHef3TJYtWxAES?=
 =?us-ascii?Q?8qDDakoqkVwVVeDGJGWe8h3i8bdgGxJRQvtvOLTaIx3Dz/k8As9A1XDunmDr?=
 =?us-ascii?Q?NVgHkv77SsrnJvu0+fAloYBJw7qnFrjWy+f8WRmnn5Zeud2KsR/O5lZeEncM?=
 =?us-ascii?Q?jP68rNwZspR/sQLtwpvyz+NhIu7WRxpmKV6zDoZOtxKJEObpzWFFxiUKwTpF?=
 =?us-ascii?Q?Gzwz5yzJAnOkLV3a+ziGRbTXeodzOYwf8/O7mafZgy2LkZo3D/XJF3JzzJTU?=
 =?us-ascii?Q?Pyat6AC+P1qE0MakjaTFxTBBaPqwfrVNZeGG1X4FGggQpP2tQcWiadIYdJ9d?=
 =?us-ascii?Q?TvXnrvTGa5TRGJsZgk/z7nB5F4s9opvyHE5eiPLvH2UOwkR/okCZNTUH70wY?=
 =?us-ascii?Q?p+KeToOQHMmBn7r2zoUSzge8VmkLEw/8LpnB49w3YsM8vFPMPWY2kYLOny75?=
 =?us-ascii?Q?N6YaVwuxVb1FmTv3XChnnlQIpnQEJ5dkXOJG8Xi95jkcVaeDPLwmZhNnATe1?=
 =?us-ascii?Q?C2WLleCk1E94bD1rGNTV8rPBeh4iZwZbFUX0PyMtP2gYM/TESNCqgAp3vjXb?=
 =?us-ascii?Q?6Wq9nzWLqWialqLna8tCkd4cKp4QdXVk959jgfD2MLx/DoyxwDrg4CNwAOnz?=
 =?us-ascii?Q?gwMteNgvCqLD+rxrLvexgXXNyqtsb6eE/IjexR0JK+qg6lWU51NsAdSw0AeV?=
 =?us-ascii?Q?fkb6Xin02y8MxLfwmtBq+DImMVR14bGhnTOWCL8DXmTAZP4lbLftbMRPq6bz?=
 =?us-ascii?Q?9V+N3d4y6L/k+h2wXAGrV5QwH/fDeKp6J0+kU7T/ZunluHkbO8eJpuO28CPT?=
 =?us-ascii?Q?P9oGAsw17qU0C7zBIReklU2uehxjkxQJFaCJrSMYU1/Kz+5CWHKe54oP/zOk?=
 =?us-ascii?Q?7w1ZWjo73ZtONReBx2D0JbUcqWj/glre?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?guWzqGfWDCAJmGuqB675teCzpWdwMw79yr8ninUcL1+aG35J/oegmVHQR9sW?=
 =?us-ascii?Q?fOf7Ma/NTGRv8LfkZa6QURDzDdEgS3HC11ivaI/PlQsI/kXNcvD4DBxvpDnG?=
 =?us-ascii?Q?WE8LDjs77cYS5gG16RUpZKPEHtHEhk7jAEjh+K3ERfyKuphm/Rmuj69iDm5K?=
 =?us-ascii?Q?Cnwsv5877NGm3Glm/yo7AC+Sg749j8CnUGcc6C+LXbn8TnYfj1XYYtjwlFB5?=
 =?us-ascii?Q?WkU5OSikz0qB+ioZSOXP3iLkl8eBWpewhGE9o0UqzXklM/3ipKkcKTnquqU4?=
 =?us-ascii?Q?ixtPHS26+WE8BFzjhcxakx/pKfWkFP+71N5UY6BH2L8P/iNTuIJ1Mwh/dOoV?=
 =?us-ascii?Q?Uha2aIk6LwAxNomlg84bHREtwkWwfKuEXm+x5WtpmfluANmXOyz7jZJXazKT?=
 =?us-ascii?Q?aHnbG8HSLZcNUjN98qHvUMhTO+Jnhe8BfpxK5jbUhYgaUPGTSwQs4P2+Jrdg?=
 =?us-ascii?Q?bPbXWjeEMzIUqQRcqgqYKShxEooSGh4NPPRgbuzhLYRhTui/bClRWcFm1syS?=
 =?us-ascii?Q?KXg6AODw0STQNlAk1CBywLStESrWZZGrhSS/qXWfdUWsQAzqBBrW+XhsnHqH?=
 =?us-ascii?Q?YVlNF9qi3HfCGQq3xKHrIcHtmkBebBmMpQXoOijW0ihPslG2XbLbu4gECjcF?=
 =?us-ascii?Q?bhNjFGnXDldHFIHkvLEpCv1FDRQ7bz8xb/zoxHpSq3hOTXq0Im3SekTo7ThU?=
 =?us-ascii?Q?idjQtxpmWv7iIVDSI8MSzsNp1B+jPiHiTS6w2x2NMcGgyMEEoP0OOPZDlkRZ?=
 =?us-ascii?Q?2KAzYoYWy4+vA2ERSQS34jKR57G9TpYPoJE/YW1rEGPoX0u4tjZiraN8FVOr?=
 =?us-ascii?Q?acp6/CdrbV6dmR9BFRPmQ3B4uLEVSF6HWK8oHREwUNUT7+3ZkeZw2MfdWz6w?=
 =?us-ascii?Q?Ef3+GfIwbo8a3H3pEmgDIu5duErGnOs+nvDLs5UjE0VgQS6+GHcsu9XLuYio?=
 =?us-ascii?Q?U0SgSJB+238hr0oovtWCFqDw3cUTTT1U+ZQYfr+PBheAiIu5gTCpreyETkvx?=
 =?us-ascii?Q?3RaAO9tg3/A5JIEXVMkvMIpTZ/aSEi1LX3a1nLO6pBwJpSZA5I89oBf/FYi1?=
 =?us-ascii?Q?8ejKNG2a/ljF7RRs3IDBj6PZTh/EF5cgkeC664gh70JqHtTHXqRKzl/8ogwO?=
 =?us-ascii?Q?aEOhsW3dEQriLF6VhI3fzxkobso9xRMMcfmiEm57VH7EWu2J/5WjvyDSgJ3E?=
 =?us-ascii?Q?C0JwuEtVld+FK+WE3fSCgU3xbvLNl1177+eoZ4c9Vas2BX5q0iUKoNdUGyqq?=
 =?us-ascii?Q?0pHTUvRqnZQ3iRrQq84DRWwBlJDwqTuwsfU/fCqIwpIxywVdmrgd+MDL4aTe?=
 =?us-ascii?Q?i+Bxoo28ZN5rOcVF14QiYC3uXYvy6Q9tHJW7dXwb0LhJz+l8A/6O+xmp8QUk?=
 =?us-ascii?Q?MxwBPgCVzTiKfgL/2N4WJ3AJHBoDM5eXmZzpGWCKuzpXpnAX25BGU+OyfpbV?=
 =?us-ascii?Q?Rogs3NS/jQlx5Uu75dK+HoSMcUT2XBCJqFcXsFLtbSK6dZblCtv4YN7wu6rw?=
 =?us-ascii?Q?Knzc0Rh+qKblXXGTlHOcp1XKIVBanw4IFwwyrV0+OEanPDcur/PWtG1oDVpe?=
 =?us-ascii?Q?r/z0ooCY7EOs1eUhhjdkSljfzOLRNHo5VNm4GTii?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15c7e3d-77ea-42cb-7b25-08dd5640e3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 08:38:05.5964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e61U7qgymPE46F+u4RkchrhaPaYtS7CQlbyWJjXNnXKY+kU2sUG8NmvXeEmkE+PLbo8UyYMRkcbKSRudAppabQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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
> From: Gregory Etelson <getelson@nvidia.com>
> Sent: Thursday, February 13, 2025 9:33 AM
> To: dev@dpdk.org
> Cc: Gregory Etelson <getelson@nvidia.com>; Maayan Kashani
> <mkashani@nvidia.com>; Raslan Darawsheh <rasland@nvidia.com>; Tamar
> Mashiah <tmashiah@nvidia.com>; stable@dpdk.org
> Subject: [PATCH 1/2] net/mlx5: add DROP destination to mirror clone actio=
ns
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> From: Tamar Mashiah <tmashiah@nvidia.com>
>=20
> Add DROP destination to mirror clone actions.
>=20
> cc: stable@dpdk.org
>=20
> Signed-off-by: Tamar Mashiah <tmashiah@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
