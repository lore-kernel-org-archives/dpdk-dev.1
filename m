Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED1C02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 735D9427B8;
	Fri,  7 Feb 2025 09:44:08 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2117.outbound.protection.outlook.com [40.107.243.117])
 by mails.dpdk.org (Postfix) with ESMTP id 41E06427B5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:44:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSFo1M8hPtvwlihUuJagOC+c6vaREg+a7Au92P8Qfhe6emLlN/0LTO87WlBVRSyg9ktRdUhNeexPN6G/kI4m2f/N+THWmereZGjSxmhEgkFLROCeDukYkrTdi0r8Vbsm62Crm/eH2+19NB8QUwVhTBH1ursjoEDUQkE5TKx/3UK9VKhu1+6FyOfiizvs+5cZy6OOHGCR6qcdJj9Y2t31cwaKwLt5yYEDQB1VFEkUcgcA2/XX3ylrN935l/8hIWr5KZTFaampyi7+7F2rzqBxavaSHctQSYyuhryQtLGODpn7I2qzcT2//yk2eXGsKyrQbswWBUzb+i3aSl2kqUbm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84qH9WfMupD9FRLV76Kjlx1NsTu5cG++9rb79t65FYo=;
 b=jUWKkHaheF/PtCKHaHEbSVsY97dbgGwyppeWnYtPCnPIofPdS72VJnv1lONiG2rECNoBC09/F4Ppw7OGdi64/uyTkL+nSSMQfPhgpY6+G9jszen21f1MA9O/0eHQapy6mnP5CgafPWa/Z4u4S0yIyIXF3hG6EUrXHN48gX7gb6nmGkk1sl1CbIAzrSYF5lzBJ7rT3kdsPVp1PwT9UpxcRe8OTu49siXaZiNrN/n4nauRXRDm8VyXBen2ZLY+u2jw+Ir1ry9G/FrWkMkhQtfAFor0Qe5Vv9QSNlVGuxkJqxOq4x2JR5veBGHGeyDn1T8OaVarrIhuV+gcjiJqWuSgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84qH9WfMupD9FRLV76Kjlx1NsTu5cG++9rb79t65FYo=;
 b=Djdr7OxM3inPX1Hz5hF54ASrE67wjkjXIAKuhiRfJD58qTA6Z/Nz4K6i7B/w9RWC8Ty4UHD19A8beXm2fb5oqu6HYR5EGoPyZnE5MWEadKGI1pBsXCRVWkaSj1HsicCR5d8eWY0nRYMVdd6Jy3gv46fHvUbYq73HTw0HrC5RAQk=
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by DM8PR13MB5238.namprd13.prod.outlook.com (2603:10b6:8:9::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Fri, 7 Feb 2025 08:44:03 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 08:44:02 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "andremue@linux.microsoft.com"
 <andremue@linux.microsoft.com>
Subject: RE: [RFC 07/10] net/nfp: remove weak symbols
Thread-Topic: [RFC 07/10] net/nfp: remove weak symbols
Thread-Index: AQHbeTr9s9ezkwFE9Ui1UyCoAcWC4LM7hbNw
Date: Fri, 7 Feb 2025 08:44:02 +0000
Message-ID: <SJ0PR13MB5545B30129EB2C8D5E6922489EF12@SJ0PR13MB5545.namprd13.prod.outlook.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250207083252.3131588-8-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-8-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR13MB5545:EE_|DM8PR13MB5238:EE_
x-ms-office365-filtering-correlation-id: af1f3f2e-3ef5-4eee-0549-08dd475392e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LMcx9p4+bWly4V4f58TZvnXvhJJc+bqTtvk7YpIfF1knzNDr8+cKAqgiAxr4?=
 =?us-ascii?Q?eAUvQqwjUODnjcu6XFASfksuAqmerX2zwWwbekT0WMi4MMnXAM9Vv0O9wg+M?=
 =?us-ascii?Q?puRXQPOlG7eTdrjU8pPCuNY1VYASAYqEfUdmNw75g/qKaHu5mqKPeaqjBflm?=
 =?us-ascii?Q?OFX4zWkYzNgQpzL25fqBScBL7D7CYuvTjSWRFE/aB4Zf3IQsW9kwouCGEl2V?=
 =?us-ascii?Q?KWCR128+uikzO3Phy7u0AVtJVwLvoiUUoosRmlxhCn5wXNjaCh4Lnh5ZWMog?=
 =?us-ascii?Q?sq2s3/jM5LNGozTuoLthFc/5W5M7w2iXtV+eIu7TmARCEunSl/RNEFE2kpuE?=
 =?us-ascii?Q?REBaWWdPrKagItKdQR/QiSrWuQJ96vhalnQeetLJvURdSut3l5xSOnLnda7U?=
 =?us-ascii?Q?5iBJkejnNas59m89kDJiiEb0W2Rl4AsUmCOSoZAz5ENr+XpzVP3T6HRa4h56?=
 =?us-ascii?Q?BIsiaEwD+rqbzgWT1S4AruIKdy8FQIIfbspuQJGyu1ZuFpoP/84EUb7BrVhJ?=
 =?us-ascii?Q?MdNejyVL0MIxnuY54763dioQCfhdZCAxT3D+jmg2Oc0Jyfqp5otUfbxJj/l3?=
 =?us-ascii?Q?TzKAtocD4M7SvnBkPnMQyJLE9QufVVPgZ+/AY3y2If/EyLtKb+MlYDISfV/s?=
 =?us-ascii?Q?xg8Z8Je2Vw71M82i2mDfamVOpFIR+seY6HWXhft96xdS3MWI5VBF7A30dNsG?=
 =?us-ascii?Q?rzNYtlT/U5cVXgjIJP1YcxJFY9hLDnXK0Y+X6CfQJLPxd50j2vF4aHGT2+jO?=
 =?us-ascii?Q?QdGebTDQ8Ib63jjcAjz0LyU9L1auoUVWCwRr7aqAGnbV3xNOoSkhrpDyQWDf?=
 =?us-ascii?Q?zOLR10+tqZP9ZsXE7QAdI2lcQo8XdJQfhcOLzW9rMlVFffvXZXJowrwJvV5w?=
 =?us-ascii?Q?WCLmHiGN3wYf33RioVdR5Mah9Mre/BWELnw6snBG2KvRR1ZhPKdFwLW+Nc02?=
 =?us-ascii?Q?ef9GomMA9MWBqUI7lSwjVxDAaimZwgksmJAX0CP84cKHew9PlUnT7OxtYDVY?=
 =?us-ascii?Q?M20l1AJAgtupu7cfPEK0YqVHQX7t9dIbj26kb8r+wtjroDlMrMLSgFh9gPW2?=
 =?us-ascii?Q?a1XXZiK+uzMZ8O9yfw1RAU4Fmg8lhbVLpS7F9oi7wORLDpLQR2lIEqH3cpti?=
 =?us-ascii?Q?uU/zuVcpVkV+NIkFwX43MZuayJhlwiA1fYqNgqbvf30W5HF1uiMN2GQtwgWN?=
 =?us-ascii?Q?IpFFWh1ptdTdrwgMl9PiSqE1hmf/y+3x6gzXkkdWF5u8qHUxFopuLKdP6Fvd?=
 =?us-ascii?Q?I/2hl2V+Ggv+KUETWX+vTHrRPoz02y8qgt6qiFkBh2LKBsJo8y9NzDLSVL9o?=
 =?us-ascii?Q?Mpoyg+5TyWqbTnlFzMLE/4SfhhwjtvxAz/N2/dfEnVqfPzqTK4fYfFaz1UFg?=
 =?us-ascii?Q?mpylvHKZy6JDk+R8CsvKwnJyH4PkW/DCZxTvO3pA0Jv+LEUqeJpCdDt0ulA0?=
 =?us-ascii?Q?88lTHKHrdqs2xq9NwXi2gyq+3CelxbGc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gBlVjt5zIDBlhWdRc3D6hMlLFfn6V+xjOzxmQx+/VIH9XahLcnnb/sMinFkx?=
 =?us-ascii?Q?RBMwGI4WlzZO4OpVmb/fEFXNWoHk2HrJ2dVeaqnPiKGy1fpQ/hYapHjwGfvW?=
 =?us-ascii?Q?yunCzNe/nAuxMo/HJQlJB6aLiKUGKoubXIhcPqS+k8+Joeusf/RYh+zSWyto?=
 =?us-ascii?Q?e1QVWDxrGvVG19oimyyYYvNN7P4KZWcICnByB9PBnRqmPIAk1ggUi/JP8rgX?=
 =?us-ascii?Q?HOheSYUEMOgIaZcAI0quO5cBT3IZsNk8l9CPUGnX+ZTarGlM70xzrggSCZoY?=
 =?us-ascii?Q?fM/5l18Cy3dI6TKyZIAK/jy5B+i5ngXLO6vbeHEpW6QhnccW8lnSqI0sAFtu?=
 =?us-ascii?Q?4CZdtwd2QO105vF4eOVp7DaHu7O+GZFrSe5tDjGoNzdQfRml8zhO82RnjSCD?=
 =?us-ascii?Q?WIll6Xz0ApSaHJ4togLY7Vbgj8foCzn2yLspTRVKuZEOshAs16ShLjc8cIrS?=
 =?us-ascii?Q?V3ASCaKnvPZqjvKwh2h/nBoulSPG6qg5J1rHSqxJhvUAq52nlyr9wcRuOP12?=
 =?us-ascii?Q?XcNEywBydrSpXY89dk1w4XUqaARb9xRXAbOvKCjJQyT9S3qhkj8gqAOaunXi?=
 =?us-ascii?Q?/j4jGTuFw7Ep5GbPtsUTXBow76FY2joAe9eZcu6XdO3eDiYUL+fhn+dKd2i8?=
 =?us-ascii?Q?GDufWsNB9JTrj6WRwuZBgv9B0t946F+T8MNNbqbPZzWtyg+5eme0K48EtMnl?=
 =?us-ascii?Q?5zJhDl52TqIk1BL/6TnXeNqF4NDwW1VPekfgjMeYy/igROOUH18+BZybj7Ye?=
 =?us-ascii?Q?3aJ+Z3OmELiu8ZIMMc/Z6F4kdRVRSwP7N3ovb6AFkabggasgk2yIa256uTNg?=
 =?us-ascii?Q?5qqlzmEbKDcosz7DcnVKEbWkzsH9vsVYvasxSqcs5E+ukq/k/URAmMqPkUAT?=
 =?us-ascii?Q?P+pOy6ZYyJ5WmsbsJQWxXq7d3yeuQ75V//ARj+NBDcXIzZMXk2RNNA1KAllH?=
 =?us-ascii?Q?xrLmwlp7Wz3CkqHumK2IfyeXeKc5VvOaO72lagIox9sBF7C/MyVTzpafTYWr?=
 =?us-ascii?Q?arNWWawwWyV6hLYVyWPfeiEc5zi4bm+vp6No8++gfdVzzKD1XECA7QTQZ9xI?=
 =?us-ascii?Q?pGqAjTxCLg7HZ/ndt7yM/ElU5BxLHJScfNMSCu2MKVUPXZbwlN/d36yT1U/r?=
 =?us-ascii?Q?bm3bCfwn0eMabBiQuhPpng6sWXC8djxVvzLkcBlYUq+IQUFR485lDTaPYKEQ?=
 =?us-ascii?Q?IpdV7tIsbq1sAkmCtjA6ru/7/W5tG/JOLMl+lVZZi0IoIouy2QBGKl43eIA1?=
 =?us-ascii?Q?Xj1Pq7jqbNEIl48NmgnX5vTk9mR2CjyUghqbMsQL8Rf8DW6hw2HYBSKSg3NG?=
 =?us-ascii?Q?nbLxOmGhDl9L/mwoDQf63PbzI7IPzgxPuTzBxQ3DDTfNP+mg1JNprw++TtDO?=
 =?us-ascii?Q?MTMV06KNv7xcpTzRYBZ2DePO6fthBGkY6ZtdNcsKmCMnQWaiH5ZUc5qGSkna?=
 =?us-ascii?Q?8AtUrXUuY6bk3lHptUpNlZ7s8TXUDvwztjklb5g7S5k6RVs65+iDFSYg3FWj?=
 =?us-ascii?Q?PhV6yn47UbfZ+wUiTid74NXpiEKb9jAQUXg+3kxBo+JKk+o7SDaDFTw8HKJL?=
 =?us-ascii?Q?/OjEY0J9cRYKv5Vo5aAHJoSdT2IF4hzZXPw5k6JA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af1f3f2e-3ef5-4eee-0549-08dd475392e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 08:44:02.8384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SSjb8o3vPwd45CUkZ6V8/60IMlzEvuuCHN9xoaXKknAISTtt4PFSSGUPm12JZI5zIoMttgz6FdoikksqPUUKcpWuUa3f0gwXUwDVlyfLKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR13MB5238
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

Seems ok for me.

Acked-by: Chaoyong He <chaoyong.he@corigine.com>

> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Friday, February 7, 2025 4:33 PM
> To: dev@dpdk.org
> Cc: thomas@monjalon.net; bruce.richardson@intel.com;
> andremue@linux.microsoft.com; Chaoyong He <chaoyong.he@corigine.com>
> Subject: [RFC 07/10] net/nfp: remove weak symbols
>=20
> Rather than use weak symbols, link stubs code when needed.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/nfp/meson.build              | 7 +++++--
>  drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c | 2 +-
>  drivers/net/nfp/nfp_rxtx_vec_stub.c      | 4 ++--
>  3 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/nfp/meson.build b/drivers/net/nfp/meson.build in=
dex
> 4052846dc2..39762bd45a 100644
> --- a/drivers/net/nfp/meson.build
> +++ b/drivers/net/nfp/meson.build
> @@ -17,7 +17,6 @@ sources =3D files(
>          'flower/nfp_flower_service.c',
>          'nfd3/nfp_nfd3_dp.c',
>          'nfdk/nfp_nfdk_dp.c',
> -        'nfdk/nfp_nfdk_vec_stub.c',
>          'nfpcore/nfp_cppcore.c',
>          'nfpcore/nfp_crc.c',
>          'nfpcore/nfp_elf.c',
> @@ -45,7 +44,6 @@ sources =3D files(
>          'nfp_net_flow.c',
>          'nfp_net_meta.c',
>          'nfp_rxtx.c',
> -        'nfp_rxtx_vec_stub.c',
>          'nfp_service.c',
>  )
>=20
> @@ -67,6 +65,11 @@ if arch_subdir =3D=3D 'x86'
>          )
>=20
>          objs +=3D nfp_avx2_lib.extract_all_objects(recursive: true)
> +else
> +        sources +=3D files(
> +                'nfp_rxtx_vec_stub.c',
> +                'nfdk/nfp_nfdk_vec_stub.c',
> +        )
>  endif
>=20
>  deps +=3D ['hash', 'security', 'common_nfp'] diff --git
> a/drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c
> b/drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c
> index 146ec21d51..4f905bce6b 100644
> --- a/drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c
> +++ b/drivers/net/nfp/nfdk/nfp_nfdk_vec_stub.c
> @@ -5,7 +5,7 @@
>=20
>  #include "nfp_nfdk_vec.h"
>=20
> -uint16_t __rte_weak
> +uint16_t
>  nfp_net_nfdk_vec_avx2_xmit_pkts(__rte_unused void *tx_queue,
>  		__rte_unused struct rte_mbuf **tx_pkts,
>  		__rte_unused uint16_t nb_pkts)
> diff --git a/drivers/net/nfp/nfp_rxtx_vec_stub.c
> b/drivers/net/nfp/nfp_rxtx_vec_stub.c
> index c480f61ef0..201965afbe 100644
> --- a/drivers/net/nfp/nfp_rxtx_vec_stub.c
> +++ b/drivers/net/nfp/nfp_rxtx_vec_stub.c
> @@ -10,13 +10,13 @@
>=20
>  #include "nfp_rxtx_vec.h"
>=20
> -bool __rte_weak
> +bool
>  nfp_net_get_avx2_supported(void)
>  {
>  	return false;
>  }
>=20
> -uint16_t __rte_weak
> +uint16_t
>  nfp_net_vec_avx2_recv_pkts(__rte_unused void *rx_queue,
>  		__rte_unused struct rte_mbuf **rx_pkts,
>  		__rte_unused uint16_t nb_pkts)
> --
> 2.48.1

