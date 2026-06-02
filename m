Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193E9CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 06:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4691A402C4;
	Tue,  2 Jun 2026 08:07:08 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67]) by mails.dpdk.org (Postfix) with ESMTP id 9C32940150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 08:07:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5l/uM9rHjcr69y5Xvkjsm70ZpRnPWgS3BTIdhBi5vI9Q2lZNr87IF8rvHzU5lNXIXsLE93bD8hmiXnooP0b9X4Sk9oOQdzYY6PnlzJG/bGy+OJHulvywHO0xQiBuKFTkdTWI0Sl3WASymm/70C0TBVudEt1A7dXce76M2llW9WhXu0IkTOb6n3GZupGtQyvLNyCBfhw6UcasZg793NVcfNFmY/Mn2sRYQz5Sgd6ZnDwpWovis4Ear73VkjmUHVBsT4xXHSCFGwJ8a8JhcG0iDiTHaGzmtRQbi/kiFOxSRAYmY1o29YfXDcKicOLS5Hfd3WDe7vqMgHA+1tVWkqdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8VYfwV47xfFOctXSrWsC9NcTBcGdptoCUqLP5U6pDg=;
 b=JUR0F413EJp5calRrNpexVoZebXxUFrysvBQuWwI5BrXon/iqk0hPquFcsrwPzE1bEhKtHZhbqnZbgSTjMRnxGP+z1iXpsBiino0KA2d0FvJ68XEUGSofYeJYJ7OTAo8taVUR2dSZwAZ7LbRsGtGygjufEfYFB54LP5sUCQAMfwBGAhO8iL5Xe7Ddn0ZAujQOrVMCHsXArokHD/gEqqnVelToMVh7N4/9gy/G8d8P36FyVRYG+zv06uMZvg7U0vObqjDveYmLbagR4Y4fPnKoVk9nsqb3iy9qQlxFvPpkWj/SEE8YqPbiUZ9H4nJvjWaJ3U0pFZg9IY0HErf4V1aBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8VYfwV47xfFOctXSrWsC9NcTBcGdptoCUqLP5U6pDg=;
 b=K1xFMPbuYJYBAmLjibTIeSxMaoU0UmhARBUHiR8IfwmERzNHeb04bfKgN6J3NIi9iuRLXrMFth3R8JxaweIpt9NjUllRLbzEtbPmNrH/satp90apHvEE0w6xW6mZoZQoAlL+BofO9sNssw16BLBHJdkBE+7MfslRSxZiWR9lX1ceqQck68xnocgQzQlzM0UWOY4kZOHTKgXdhLk1r4PH4xPtN3L8a6sGANoewm8Z8Oeuw1IvVssyj40tYf+57RCb1LHPYGvMfx+2/SjprbaeXdHjU7dUptuHaxmYrtwwLnHYOi3HME3ZMoMPyPfiY5dh2/JWcVxoN/QihbXKFPUEOA==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 06:07:02 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 06:07:02 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] net/mlx5: promote private API to stable
Thread-Topic: [PATCH v2] net/mlx5: promote private API to stable
Thread-Index: AQHc7z10UMM73VHTAEC4y8+yxOzJcbYqzWOQ
Date: Tue, 2 Jun 2026 06:07:02 +0000
Message-ID: <BN9PR12MB53382148AED34F87AC368E0CD0122@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260527103357.633429-1-dsosnowski@nvidia.com>
 <20260529073255.689808-1-dsosnowski@nvidia.com>
In-Reply-To: <20260529073255.689808-1-dsosnowski@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|MW4PR12MB7030:EE_
x-ms-office365-filtering-correlation-id: 7b19b949-a070-48cb-aa42-08dec06d29f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|4143699003|56012099006|11063799006|22082099003|6133799003|18002099003;
x-microsoft-antispam-message-info: u5WbbXpEqDmVCe/GFh7riz/5hRYgB8bW129eE1X89lFXJZs8z5Ubnm0CUz8TwlKU/Nzf0Bkqv+4TkCAEonX6r6ZMuTjZBZz+jbKOTboaKmgbyk+aYZXlWnjDIOsBoD5QThOd34iDn/mdoEXoI9AtuMU5p5TXVWkg0sx8dgNei2Ocv+7LuLdALrzy8z1gORyPXXjKmnwovpBOqDKA/1ed15taGHTSPTD+eri9TnhHq34wObBjSJWtoPVqKVYXvm4Z5voVqo7BQp3VG3y/IezGIy6XOYumEYy+Ua4pFHKWKLYfShbozVDn8+2Q/gqwfzCb7SjOT/XB4bXno/kJd0oWh3TCWkLFN37M8eesPWnuefPrqzgVNdAvfJOc2xp+yD+AZyQgFEoIXoIIN4ngEC7iCfCe2cQpZioMRrK1rKgv+5R61qIRNWhW4euBt1iLSmFyJ77OE8HBcOsLfWgR0M45ZYYEJ79q16K1fJGBGZfKS3yCfj1hvLI4zKXUfD4tboPm42Un3Bl8thBc9CrT7M7V4lOBgC10f8lprFkHGRH1AXUcWiKyOnZkDH4SNNpW1KuGS8poAKd03id7g6g0R9vYUmy75FzpWL+yKSae0W9zOi4VrW3MN4l2W94T5nkGW9zVARbiZiThmNLtrpD737sMU95VFdeGgLkUGNV5dTN9iXR+KEw18NT3B4durHLct5DmNsIWL1jCPFGHmAWR5YTTsjKlIKwPmUn2XI8aN6KWogdIkDy8hLUKTMbdjdr3G/t4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KBsQHDV+/RZbURQVlSeFzw9EXm4hE4gGvTzkHrbWtpt2zDzsVk10OiNVXDut?=
 =?us-ascii?Q?WwU1ky8JnwDl9L/xfOQiQKp5Ab+y9F3mPQa2UlCEup5oZ+uaJiCtA67BM08p?=
 =?us-ascii?Q?4HMpJty5PMYJxU9nbV3IxPRS5JhHUDXJcXtFiI54DXxKuelno4sZ+/LbGCRb?=
 =?us-ascii?Q?NIoOb6lXBCvoFjZF9x9e7k9MosCSFQdjtatp5iVi7JY+QpiaFSu1oDaHhpqi?=
 =?us-ascii?Q?HmFtFkyJbj/hRDGcLjtr9fsFlTPtUyOcJITEQjHmr3Q0GWKkpvTM+05zKwbG?=
 =?us-ascii?Q?ULlLU+chzQoR1f43RphfH1UViZ0wQHSH/x6B3kQPBq1qJWvO7EajHZVeHbNi?=
 =?us-ascii?Q?OL2SScvSOei4hJ4PFQ8U2/FzRMqZykPG70wLbucEFiBP/s68xPcGY4P+3MJl?=
 =?us-ascii?Q?nOJvFT9bhuNSn1zfV8Pj+c3hBrCI0NFCl9p/+Ty9ypX+h9r21adzNWNByd+E?=
 =?us-ascii?Q?+q+TSnhC2z/rQwaUYR1TqDCOSeRyrgcBk+NB6HyYLxP07ZEBYPL4OTNV+lew?=
 =?us-ascii?Q?ELQ30dR7yZPB00DbbbSdpSojlDP3tIggNpnRWizsiZSvu7lrdcmxRAEiDB5M?=
 =?us-ascii?Q?gubo/wdXTzVxJ5W/T3IdD60yoLKdSnFNN5RMixpgwC+dsmiCpPj/RUk5oHE8?=
 =?us-ascii?Q?ttHzTQbZp5LTj/90g28YYp9g2MPIat6yBKeHMG/I6VDZ3n80mTolSpp7xe7G?=
 =?us-ascii?Q?LLAHjsCcO1Bg7i3of1JEZFnZjUMii99oFay+UUl80HlwR2YQcjUaZ6hWBwFD?=
 =?us-ascii?Q?/5x69KvQmI26ytaBAdfrq5oZaJiAbbTft8r/0T04Io8a8Rfjs9aPAhOihUO8?=
 =?us-ascii?Q?4HdxkF8atNqLy/Kf8piSvvYb1mGkrhbmtoGXCD+ud2Vk9/kczwKHOj8wbQeI?=
 =?us-ascii?Q?Kk6hj7qQBjBU1e6Uum16KM3Rmb6ZgLtmyV2OiE7yNGYFXO/DMKcaYIvi0ydu?=
 =?us-ascii?Q?Ou+gkaaBJcyyamwkyu9VDHVqtPk37C56uhawp3w0DB7289hBIrVToaFFp5/9?=
 =?us-ascii?Q?k8h55Q6b2quuz7a7o6moM3BjwgYrmx8awRqi49Cop+Hm8v8iOuulmCugrdv7?=
 =?us-ascii?Q?loHyZGPA7+pDBV9HTorrqquC8BlBdDNiiirqHQu/60iBzBfxUysfG2W7GMeS?=
 =?us-ascii?Q?gWdbQyuC1Sg0tYLROx0gEXKWKxk7zvUYPLurbSqNNTc9twiaPBMmd8OI4Qkk?=
 =?us-ascii?Q?H2m0dITzwibsadRwe1e5qOLO98OLnDDKGUlFtRVz0wIf+LNThZVVhEFKbDxH?=
 =?us-ascii?Q?/NGpyCtif0mCTIsNN7mvYjhPEHULniC7S5rwqP7LWujWBGuCqnervKw7cfJD?=
 =?us-ascii?Q?tNMpO57fzwCKygY3J6wypHD8EsLbg6SI+5TX/n8ZJXb86OJC0ef95sH0TpsC?=
 =?us-ascii?Q?niAT/ExEZm88FpxOLWwcZRK/GWYUBIFznRg3xzCOs8RsVaWg3YEB+iTxm+5X?=
 =?us-ascii?Q?UmUaDiKANRuFlJSVVQarTItn3pmEbXLCEYfb4A8dZM/XIRv3pdO7jGdK6MJl?=
 =?us-ascii?Q?DerRuR7vseJ4L4/TuDOPntRxfiJWEJ1TyonwgIAVYwtGCrQc5NkTw7WTiq2z?=
 =?us-ascii?Q?PoqAosXenTYmDC93F9tuswRfX7bM81Pvo0cRx0OcTUsabBgezzZgxBdemPCI?=
 =?us-ascii?Q?Cr1i61CH7aCAcAoOLJ6eZF2VBj2ONByGn1cvFHy28c0M0cTgIQzG/nL71+EQ?=
 =?us-ascii?Q?y8vMggZnlzOuBZuynq8UujzTpEiELnb02WzmTN208eGyztGh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b19b949-a070-48cb-aa42-08dec06d29f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 06:07:02.1038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcybTFfngBG1x24uMQaIPO+I8Fzo/Nm1OqH3EXI7VgdUDcTjQFFqTCz5eHw9NqaXzcdlLdbHtI/IMwemaxbO/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
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

Thanks

> -----Original Message-----
> From: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Sent: Friday, May 29, 2026 3:33 PM
> To: Slava Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao
> <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Cc: dev@dpdk.org
> Subject: [PATCH v2] net/mlx5: promote private API to stable
>=20
> Following experimental functions are exposed by mlx5 PMD since 25.11
> release:
>=20
> - rte_pmd_mlx5_driver_event_cb_register
> - rte_pmd_mlx5_driver_event_cb_unregister
> - rte_pmd_mlx5_enable_steering
> - rte_pmd_mlx5_disable_steering
>=20
> First two are used to register callbacks for driver events (when Rx/Tx
> queues are created or destroyed).
> Other two are used to enable/disable flow steering in mlx5 PMD.
> No changes were made and no changes are planned to these symbols.
>=20
> These are currently used by NVIDIA DOCA SDK since version 3.3, which
> started depending on upstream DPDK releases [1].
> Purpose of their use is to:
>=20
> - expose HW identifiers of Rx/Tx mlx5 queues managed by DPDK and
> - allow flow steering to happen outside of DPDK.
>=20
> Also, some of these symbols will be used by netdev-doca backend in Open
> vSwitch [2].
> Whenever a DOCA netdev would be added/removed in Open vSwitch, it will
> have to disable/enable steering for mlx5 driver.
> Stabilizing these symbols is required by current OVS policy to remove the
> need for ALLOW_EXPERIMENTAL_API [3].
>=20
> This patch promotes aforementioned symbols to stable.
>=20
> [1]: https://docs.nvidia.com/doca/sdk/customer-affecting-
> changes/index.html
> [2]:
> https://patchwork.ozlabs.org/project/openvswitch/list/?series=3D504726&st=
ate
> =3D%2A&archive=3Dboth
> [3]: https://mail.openvswitch.org/pipermail/ovs-dev/2026-May/432066.html
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---
> v2:
> - Updated 26.07 release notes.
>=20
>  doc/guides/rel_notes/release_26_07.rst | 9 +++++++++
>  drivers/net/mlx5/mlx5_driver_event.c   | 4 ++--
>  drivers/net/mlx5/mlx5_flow.c           | 4 ++--
>  drivers/net/mlx5/rte_pmd_mlx5.h        | 4 ----
>  4 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index 6eba91a5e9..2af24d40a0 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -127,6 +127,15 @@ API Changes
>    - ``rte_flow_dynf_metadata_get``
>    - ``rte_flow_dynf_metadata_set``
>=20
> +* **mlx5: promoted driver event and steering management APIs from
> +experimental to stable.**
> +
> +  The following mlx5 APIs are no longer marked experimental:
> +
> +  - ``rte_pmd_mlx5_driver_event_cb_register``
> +  - ``rte_pmd_mlx5_driver_event_cb_unregister``
> +  - ``rte_pmd_mlx5_enable_steering``
> +  - ``rte_pmd_mlx5_disable_steering``
> +
>=20
>  ABI Changes
>  -----------
> diff --git a/drivers/net/mlx5/mlx5_driver_event.c
> b/drivers/net/mlx5/mlx5_driver_event.c
> index 1dc8029ee5..89e49331c8 100644
> --- a/drivers/net/mlx5/mlx5_driver_event.c
> +++ b/drivers/net/mlx5/mlx5_driver_event.c
> @@ -236,7 +236,7 @@
> notify_existing_devices(rte_pmd_mlx5_driver_event_callback_t cb, void
> *opaque)
>  		notify_existing_queues(port_id, cb, opaque);  }
>=20
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_driver_event_cb_register,
> 25.11)
> +RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_register)
>  int
>=20
> rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_=
t
> cb, void *opaque)  { @@ -264,7 +264,7 @@
> rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_=
t
> cb, v
>  	return 0;
>  }
>=20
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_driver_event_cb_unregister,
> 25.11)
> +RTE_EXPORT_SYMBOL(rte_pmd_mlx5_driver_event_cb_unregister)
>  int
>=20
> rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callbac=
k
> _t cb)  { diff --git a/drivers/net/mlx5/mlx5_flow.c
> b/drivers/net/mlx5/mlx5_flow.c index 915ea29a5a..a95dd9dc94 100644
> --- a/drivers/net/mlx5/mlx5_flow.c
> +++ b/drivers/net/mlx5/mlx5_flow.c
> @@ -12506,7 +12506,7 @@ flow_disable_steering_run_on_related(struct
> rte_eth_dev *dev,
>  	}
>  }
>=20
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_disable_steering, 25.11)
> +RTE_EXPORT_SYMBOL(rte_pmd_mlx5_disable_steering)
>  void
>  rte_pmd_mlx5_disable_steering(void)
>  {
> @@ -12532,7 +12532,7 @@ rte_pmd_mlx5_disable_steering(void)
>  	mlx5_steering_disabled =3D true;
>  }
>=20
> -RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_enable_steering, 25.11)
> +RTE_EXPORT_SYMBOL(rte_pmd_mlx5_enable_steering)
>  int
>  rte_pmd_mlx5_enable_steering(void)
>  {
> diff --git a/drivers/net/mlx5/rte_pmd_mlx5.h
> b/drivers/net/mlx5/rte_pmd_mlx5.h index 55a26cb067..f482875434 100644
> --- a/drivers/net/mlx5/rte_pmd_mlx5.h
> +++ b/drivers/net/mlx5/rte_pmd_mlx5.h
> @@ -620,7 +620,6 @@ int rte_pmd_mlx5_external_sq_disable(uint16_t port_id=
,
> uint32_t sq_num);
>   *   - (-EEXIST) if @p cb was already registered.
>   *   - (-ENOMEM) if failed to allocate memory for callback entry.
>   */
> -__rte_experimental
>  int
>=20
> rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_=
t
> cb, void *opaque);
>=20
> @@ -641,7 +640,6 @@
> rte_pmd_mlx5_driver_event_cb_register(rte_pmd_mlx5_driver_event_callback_=
t
> cb, v
>   *   - 0 if callback was successfully unregistered or if no such callbac=
k
> was registered.
>   *   - (-EINVAL) if @p cb is NULL.
>   */
> -__rte_experimental
>  int
>=20
> rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callbac=
k
> _t cb);
>=20
> @@ -679,7 +677,6 @@
> rte_pmd_mlx5_driver_event_cb_unregister(rte_pmd_mlx5_driver_event_callbac=
k
> _t cb)
>   * with other functions from ethdev API used to configure any of the mlx=
5
> ports.
>   * It is the responsibility of the application to enforce this.
>   */
> -__rte_experimental
>  void
>  rte_pmd_mlx5_disable_steering(void);
>=20
> @@ -697,7 +694,6 @@ rte_pmd_mlx5_disable_steering(void);
>   *   - 0 - Flow steering was successfully enabled or it flow steering wa=
s
> never disabled.
>   *   - (-EBUSY) - There are mlx5 ports probed and re-enabling steering
> cannot be done safely.
>   */
> -__rte_experimental
>  int
>  rte_pmd_mlx5_enable_steering(void);
>=20
> --
> 2.47.3

Acked-by: Bing Zhao <bingz@nvidia.com>
