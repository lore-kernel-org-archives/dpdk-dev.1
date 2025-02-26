Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB393C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:44:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03ABF4029F;
	Wed, 26 Feb 2025 09:44:22 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by mails.dpdk.org (Postfix) with ESMTP id 37EDD4027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:44:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/SiT68SdMlNKqheTKB7KNM7K4XsFlYocyQcH8jsaOyW4d+fonqd21BBRLdmfqvbhYXMCND2MMU5ZoDFIVwPmIHmorZq/nD7EHtM6lu6jTtpLOfssCTJhL1tKvURYvv1Nj7Yv/pBolkNqH7mOwBLqUIwow71F/d4El224jrhc9PSXifSnKXrTb9EJKCSN8g0fAoSFDqW/rc/0wIVNLJHFrsCR9A50CXTSCthq5ep/gOl/UHycIXEWt7g+E6O8HJmY+kgOHJVeW3sJvsnEI5gnAheM5T8JFpsNlQA8fiBvucsUSMx1jn1RuWvDxhOqkh4TEM0rIDW0DpnmDP2JhUH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXCROx6Rl+IX5FZ6pQH0URxEMCavIgP3NR7D3w+Rwuw=;
 b=J3J+iZKqM79jcUJVaBiXFydTqIkJ9r6fWwyqJb5YfroyO5NDyJHobhDphMiUQi7neOVoiEfnh68fRKCm4P9TPXf/tZujVXHkVtZ4SwuNo4G98i6L1gXKm6wT/ox9/19DBXwTxBKOGRd0WhzvxjBy2aeejHKwwvW4+nqzEGEFN87Ds/RVwARblaJQfBfUYlJa3zTbf6yRI8q+UcQpY3Q3iGNmhYX0g3CnXMglKcIGiRQirLN6SqR/SuiCs+oUUY3FbQu9AkGDhMA3AmR82EtJo6/wbg//ZX52/kj8ZOw0cW+tU+8HCG1ZGdcuMD6KBBqJHhVpNlyTJnOUGmrO3hlNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXCROx6Rl+IX5FZ6pQH0URxEMCavIgP3NR7D3w+Rwuw=;
 b=C9gdmt4a7dxvo8nQb+s/pPC2yHAEYN9ZkClVfCDtG+r4N3FLs4TNhCQatWJWVEyEN/ZuGSaThNm2wuep07JinUH4DIMc2Y4DtJiHqYqLbRY2/h+YfqPL3GKq4mmsL4qWnCpkgR6UjT6pL3c4cdLtkIJ3slPckS/+J2uzQLqV6BnLT+ZWZxzh2X2BrfEbqQH610zeB6V+D4NAlGGELQDOYmjShoTT+0rOeGGS6sk7MZfmc0RfVB3heZNiu1uzyPv/+1YDgptMfXyWMxALNA3MDJYN3DWZnn6rzXz7J7kBJEROASP1bPZlGl1tI06DdCuKfr/S8dgpyEz9Op71WSopUA==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 08:44:17 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 08:44:17 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gregory Etelson <getelson@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>, Itamar Gozlan
 <igozlan@nvidia.com>
Subject: RE: [PATCH] net/mlx5/hws: change error flow on matcher disconnect
Thread-Topic: [PATCH] net/mlx5/hws: change error flow on matcher disconnect
Thread-Index: AQHbevlbQfUcifcACEmOyZMyjvo9DrNZXxdw
Date: Wed, 26 Feb 2025 08:44:17 +0000
Message-ID: <CH3PR12MB8460C2DFB17D107690537BCAA4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250209134806.263338-1-getelson@nvidia.com>
In-Reply-To: <20250209134806.263338-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|IA1PR12MB7565:EE_
x-ms-office365-filtering-correlation-id: 249a4a87-eb4a-40e1-89e3-08dd5641c197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?unytxZ/oWOGm6zawCSm+12k2WHls4Fmf+82RKS6sYgE+bLcrpnNelkr1eoFm?=
 =?us-ascii?Q?XksPyshetObOfew907fkPj5n3UPlpoJsIOEoZ1cqnhj/y+9pHEsATu5qwsRG?=
 =?us-ascii?Q?/LIPxYEgviblRk4qwKSSBD+DNyBQnPt4E6BDxMfbqJSidYZBWBYljqABi0kY?=
 =?us-ascii?Q?eFhLd5JEk1nuKml56ji8ykw5NvFtSTL0mNmyG1k5cN+IH4Kksnr9Fr4aGUYc?=
 =?us-ascii?Q?a532bc/oP8nodxmcVABynM63HmSlrF9mABmr7cho3SRelRLXOy9BkUO040+J?=
 =?us-ascii?Q?eDss/6pE8jKW2IdfSvDK4ScTtudMqe5bqNyJPTQq5rBv8AS6xlVYIL2/fihm?=
 =?us-ascii?Q?GBXkReGOeWAjvlgbLl4+dIg/h06sspvxzn61vRbb4rKCabMILkIDYKIrwJX0?=
 =?us-ascii?Q?jMyjtCh1of1hsgYbNgERG3E4DCxttnb8gD3DTw47ev4V69iSU7Aq9RZ6ld5p?=
 =?us-ascii?Q?c3TBSeazQ2VWhKekgEsLDkf/Ox68Y0NmC2KkAuj/J/VoSLyh0Bd6XCyv60Nh?=
 =?us-ascii?Q?i5qA75O/pv6cMmaMu3gJjui9gxi0hPY2OGu8yazVtGAFNkeV/26nw3yQREZ1?=
 =?us-ascii?Q?B+V2WQPtM5emBn92bCoZ0ONSVP6rShDGPMG7gRnSZ9zn/8zIKjP15aDxIY5M?=
 =?us-ascii?Q?r8SxKGDapSCJPgITcUDW/eBVAuuuQW4pIQ/lXORgBB/sQmylOl6uexAVhAFQ?=
 =?us-ascii?Q?Lmgm27Z0AZa/+xPohoyZ95gZFjSpbcEa4AJ24rlF9ZZEBmwNdU7pZz0GybN7?=
 =?us-ascii?Q?hygHq2JgjeDVyHOzrjkkXdzp98DWz3cu5p0O1ZyCCqI4IV83z7YNC7Gb5Rnq?=
 =?us-ascii?Q?UhHJUNITHO1yxeKQfZ7xIBnV+z7W3Lj6RL8fQGfyrlhycsha5azfUrTA+RMM?=
 =?us-ascii?Q?fu1445qpvxsEC0CMHby3k/hF/GAXWvICztix6GyY0Zqrd8gIhX+ZvbjMZCkH?=
 =?us-ascii?Q?w3b2ffbkiaJWeFr/fxgeV0t4TjOZx8Cdi7vobK9r4D8L0pc7LS6hbbXjNZcB?=
 =?us-ascii?Q?lhJXOZfIHzD6tWNeOpuoMEbH4jPairgkkhfE09XxlIvb1u27e7GyeOs+hqcm?=
 =?us-ascii?Q?1KjP8eQ2Eahd5VJPQCew5yiehVLV/Ki0PejY/9OxfvCA4n2O0uPacLu6JChM?=
 =?us-ascii?Q?mpxZC4PdAkzHeMvL2kph0t+ueWM3NL+hORq2CZ8N20ksFVk6DkoA0nypaw7R?=
 =?us-ascii?Q?+HYqehlHGCxMhhV2pE937lVWe4kSOzLg/mhvwq91gTnVSkQobOqMU+dTPeJ0?=
 =?us-ascii?Q?V/I8Q6ULQlhlJzqmygdHj7TxPxYwah+Lg2B1AXgnsr4fXXauMfAGp4r5y9PF?=
 =?us-ascii?Q?t7qRmOVQ5yYZyXNck98+aILutz6+C05dhHOB5e4qFxzYHE6ar9zSgKNpQWAN?=
 =?us-ascii?Q?nAU+BS4l4hxRybYUlj02MGr4rxZaPgbegz5YMfjPERx/bl6tHGcSmSWurFzO?=
 =?us-ascii?Q?00yqXbtdM8ovNGnXLUN6zV9KIL8jLRw0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hxos2fGWY5wSzIXEAn5Pm5OC2Il/QZbXoIvYLS3GOs9FkfRsGy6ZroyAACZb?=
 =?us-ascii?Q?jroNrCY6hTyEGBkHcMnxjjGz7y5esIeQP8GNNt+TXWC+OyMbjkSkEX+LJwC7?=
 =?us-ascii?Q?OVb3L3bifv56TbNHCCMDzVjJqVUz8Q4LlgBfPrmLLz1nINUAWs17Sj3trZ7J?=
 =?us-ascii?Q?a6uMbSROPdbGIijOum4+/ksKL/8rRmcrqyOLeFySiFvDCMB7auAaY9gTJeiA?=
 =?us-ascii?Q?RqQedjrdu9jQSk9GgkK0JplUSNqCJY9Tts7ToZimJ9+dcEAEwo+X0Vz6+LRB?=
 =?us-ascii?Q?z8rKF9RrxDAs1tl6H0qZzCfm8GTPnh3l+HsJCVSZB3A388hXA2GQgrjWXZQX?=
 =?us-ascii?Q?8/BGGMaGefYxWhr/sd9O9CS5wqPkXWQdw2GYmhJHcAmugnBRv6uSap0cEtxJ?=
 =?us-ascii?Q?FY/S0VSf5lDBK4VdYSZ2+OiAV1NgdLsMjhqn5UBYPE2Xg7KbrHrdhs9ttZR2?=
 =?us-ascii?Q?BRLCngDErX2RlAOU/V3j3/odEBJUEvpP3nxsEbmph08WO9hqSjq5SNTV/Ee4?=
 =?us-ascii?Q?EMrRXvz2GY0StC5lamVKNNSsF8QMINNB7oXk4fOYR6OVcXOt7BjhwZGGlTpX?=
 =?us-ascii?Q?Vk5REZGYBho8BondoLr8d81I5elbkZPjOjqB96IREfACPk7VnjQSJ1zmgakI?=
 =?us-ascii?Q?EHqyEJyplLcDk4P4IOv2u60doI9McWSKQVn/ijMfH637mcJL2Bv+03XoLQC/?=
 =?us-ascii?Q?mMccrO457f5E8W/VfgVKxkkLQgPajjmSHQ01iZG2bJ6f0ILYmq6DFvhFFSBR?=
 =?us-ascii?Q?jmv6QL5GGNmTD0BgRmsjGj7TpMag98eZxhEJYnjYJln/hWaotOiMJrseyi2+?=
 =?us-ascii?Q?dDR58qLGqkhMImShKwI8zIyKoaiFzRRdghymCHO3SQnvr5ZWt7Paomwe9Jl2?=
 =?us-ascii?Q?RDlaXwT6YtgG9yEwfNqomon69l9cyGtpb7u8DvMyri4EOsstl3sV/0lgtICj?=
 =?us-ascii?Q?0bMTDtqKpqMthnHaGyBPctDCPT8SsX4jeBybOvqFzAk6X8TyZbYXFT6vAxTY?=
 =?us-ascii?Q?BR8a0FHq3QiwHIJJgEskvWBkXOAM3KMkRarbsquXrDOd68eOCEV64r6NqQ0X?=
 =?us-ascii?Q?qW4AGGXmF04zgVlwt9PLBWY9syyoquttsR/B6yJgI1yk1+rJzLhmcnQCpwGL?=
 =?us-ascii?Q?PUF+XP1gZX8zJGxO86R1QMSSuzvDwUF3B8eEeSe7BlbyrVZhvjYhbquDIRID?=
 =?us-ascii?Q?NLHvZe6IXGMqK6QK33YqR0/ttgr5SxLwfQi96NwoWRAF8kutX95glzGcGMY9?=
 =?us-ascii?Q?BQkbrihWIy+IYywjCK7j3YnPqKJBRAjdkm9/RIOY127J+k+xJc4baur3aOHs?=
 =?us-ascii?Q?x4wwecLbYCt9kEfg7V5opUy66ya4XKqXh4jXNhsw8mtw8SnwMFYoRh2oO1cX?=
 =?us-ascii?Q?pcwdUd2F2Z0JL6ota04IRQovlKaaFF0ynr6Vqh4fvg+UcuZqHnn0TUx/OrdS?=
 =?us-ascii?Q?/dLjeMP2MoDycAeJPlGvUSiGWWazKVEzzi9hAw8aipiQH+4SAVm8CE0cmcWv?=
 =?us-ascii?Q?hecEZFs9AEHD1eG57fFZTdYPLr7Rn4/yPh6kzd/2M0M6XVjlyfCiMe+4ZqC8?=
 =?us-ascii?Q?+YlNYR4GYJoEEAR1pl0RNyrtVUuCF+Us7Tvngcjc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249a4a87-eb4a-40e1-89e3-08dd5641c197
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 08:44:17.7229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKFoPXAYIf9hZBQs7M157/cuOkmLLI9fXseLkwl4VHsb1MOY4wj1peOy+MTo4W7ThZqgGepJwZScnkYTAq+86A==
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
> Sent: Sunday, February 9, 2025 2:48 PM
> To: dev@dpdk.org
> Cc: Gregory Etelson <getelson@nvidia.com>; Maayan Kashani
> <mkashani@nvidia.com>; Raslan Darawsheh <rasland@nvidia.com>; Itamar
> Gozlan <igozlan@nvidia.com>
> Subject: [PATCH] net/mlx5/hws: change error flow on matcher disconnect
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> From: Itamar Gozlan <igozlan@nvidia.com>
>=20
> Currently, when a firmware (FW) failure occurs during matcher error flow,=
 the
> system attempts to reconnect the matcher, leading to a segmentation fault=
. This
> happens because the matcher is freed but remains in the list.
>=20
> Example scenario:
> Given matchers M1->M2->M3, if a FW failure occurs:
> 1. System tries to destroy M1 and fails
> 2. M1 remains in the list but is freed
> 3. When destroying M2, it attempts to remove itself and create M1->M3 4. =
This
> results in a segmentation fault as M1 is already freed
>=20
> Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
