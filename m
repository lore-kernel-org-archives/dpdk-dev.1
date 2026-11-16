Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB2606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XwpYsBK7;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DGnMJYHa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F4B840150;
	Mon, 16 Nov 2026 11:21:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id AD61E400EF
 for <dev@dpdk.org>; Mon, 16 Nov 2026 11:21:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794824497; x=1826360497;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OY0l8WEI4eGKORxBk7jxmqjx4x8odseT7qtUHJrawsM=;
 b=XwpYsBK7P2Z2fcjgPpYATSzypX2zBQikUXkehXz+s0DQovPGVnp+hWL3
 QMZefsMivnJaJbYI7RtGHU9AqLlYNR2iyxlOkgUg6xRZLssGcLxKMsxRV
 JduGdV1CxeL5ULIyh4QY5Aem4pODJpzKzg2IssEYQzoVD3cyNwSjFXxEr
 fesmw9/rqKbfpIAzeKE8FJ1qjxo3lmtKAisYQRPWqDHoB4E+BjXtUFRTD
 WwGCu9vGB8ap9WSGRDR+B0zP3AQemvwjwfSiwzwgWqvROwh80E0xkkURO
 b9Hv5iDfXPM4IAJ8zbMqbsAy64KhQ+M8vBtCNTzWspX59NKIbB95mwOiS Q==;
X-CSE-ConnectionGUID: i5mBo+qPRFSG3PkF145MXA==
X-CSE-MsgGUID: t3Vjcc4jRdqpPiO1idRSfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3418415"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3418415"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:21:35 -0800
X-CSE-ConnectionGUID: NzWuQZjBRNCVDq9uw/kPHg==
X-CSE-MsgGUID: 6ucJX8NERJuwDmFAxO11UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9841594"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:21:35 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 02:21:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 02:21:34 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 02:21:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwc1RSVxdkkPn1rvKNAbK472c3dypF+cnlbUqwOhz79cQK3vLcH0fHVPBlZzzNV9BNDMKmH4m7zGLrD1HnyiGFvVUkn3HDosB0EZZ7mT6H7QRabZStvUSsnm6XVrD7U5x7hVx5RliiJqsxNFXuwaN5DRzHpZHqr8ggkLG6IhZyuXwO+O8JCl2B40ySg0DNW9iaBRZpfQfrZHNNcBQ9vzji7jB30pRwaVojTiYbEp/y4/JVA7PSggkQzJd0vQJ2YHTMndnIGdtW9bkiZeke/uoKhbe8P87Xfq3xXwkTjyU9ZNaPCRzjAKVYOH396Bn+ihvdqiZ903rZnHpfqGMvhtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czM5+UJtzjjN8NjVdPqtsO+ynfWBJTM+i3njS11JmB8=;
 b=Coyu/NBXq7ctdYJAcesT/7hfJWwDpnWVdA4PsTpywIRUv98PW7tZdnAzWMXilUUBbW1PeyhAPRvKnjR8OY3WWQ3cGXnTOWDHwHoBb5AzsWUhnjowLGvPDdJOOd+Wn0IdU6imoyBSCLg9a2gNTx4Qebf29Onf+lJdB+igBeTOGjiDhZACvIzvnD86nzczpGo4ssv+c5q+WEh1iUgVm6aerAlZklMuGNXI1L9OMoR6GT+lQkfKyK2Uv69MvAD8nbNsv+F2Jg++vO59rGoG07d8VSVmUYHPPej8Tikt6Vg+C9R3nA5HQG0wvcGlbhrXWMoTv2EJOxqB6hW06DU36surLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czM5+UJtzjjN8NjVdPqtsO+ynfWBJTM+i3njS11JmB8=;
 b=DGnMJYHa36xjhCb/7iQPgn1yJh+qAW2YKosWUq4a5sRadXkDnhSG40dKjYIJ1KQfJeWexissqSQmmpd1acvaVQK9qYdezhC1pyR2uQtlDI0OMU+yIaLe41hZxO7xUkX7QyB7YdH20FtFy+M4rC96FbLqMD7ZXgfRQDGpip75TvU=
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by BY1PR11MB8030.namprd11.prod.outlook.com (2603:10b6:a03:522::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:20:31 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 10:20:30 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [PATCH] eal: ignore errors from sendmsg on cleanup
Thread-Topic: [PATCH] eal: ignore errors from sendmsg on cleanup
Thread-Index: AQHddTNJ6Vn4QihVR0K/DPXjDlTa5rcwfakw
Date: Mon, 16 Nov 2026 10:20:30 +0000
Message-ID: <IA4PR11MB92781D220A4E25257BC1D3BB8E7C2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20261115185803.347504-1-stephen@networkplumber.org>
In-Reply-To: <20261115185803.347504-1-stephen@networkplumber.org>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|BY1PR11MB8030:EE_
x-ms-office365-filtering-correlation-id: eb3450df-3cbc-4617-c59f-08df43cb3e01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|11063799006|56012099006|261022075727099003|261022113327099003|261022115727099003|261022105027099003|261021133027099003|261021130227099003|261021121427099003|261021135927099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261026135527099003|261026130827099003|261028144727099003|18002099003|22082099003;
x-microsoft-antispam-message-info: ZPOMMK+8FVBpYEmc8ACZl7suaj466Dq5rVB9NbxmjDlj68f4GNwjkhjct28Gm+fzU2ED/8cpw0+k10vTxaWOizi2lWou+Qu8HFul76dHwAKbWY+VYF+8q+VJYrjYwmX3W5wmWIkJGl9Oay4kBjvDV3QPKWUkgHyf9GwzGaqY0uhB7GtOJvTuxN4wPJVeWF9TOWDAWuAQ35TXd919jKcmbbfu2knKzM+WwMBnAM2x4Wu6rbmWm1FZCRvO71xJfbmoXnaEw5fuhZiSgKovx3tgvdzrJTpbrz6UqYncpZzhKc9waAZyoM6dVwRAsFJySVdLTbEaVszCuGLnuoqwUj02CfQUvScnzaLbnT/eHZIrLXciMrUi9guFsJifpzlNxqRMsJDl+IBW7GhcTH3/WchPGpqBjYiqH9rsecaWlSvw7q3X4mwTEg8wO9708cKYJzzw63QgrP0hRrRKuSDEhntx6qNhGV4gaIWPYRulbCIFKxKE+k13UK45qRdn/i8RbpWpr+8N3XDZOG7qYDm+YqclUh3xPEsJMbGyDKrGcCfnM8z7Xe63PXyZKddKFASXNeqkdHZJjjWpMkRUWys5WeqzQTtkzGkjJz8VwdXcC4jdYclp87feG20hLrx83WGk7kTp0mMxdGa7r0J4p983u41/u6ajJ1JOEFppCtYifpqJpc8kfWdTUnvCSZby/vgcTgfvjNVXpy2ArqxB2cQY21aqRW2u4f/EHHth3MwTZownAVQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022113327099003)(261022115727099003)(261022105027099003)(261021133027099003)(261021130227099003)(261021121427099003)(261021135927099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261026135527099003)(261026130827099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?27L6MAxWEGn902FdmMviQWP/Q+LW3LLu7lBKtNnddiikrjI0cQvffeJ0Ca3r?=
 =?us-ascii?Q?lNpR1JQ0vUMS4TvnLHuMjWoZPI4lDEbSLE0uAUhIBt6kX9BRqlzAsE1XgSRw?=
 =?us-ascii?Q?naATXJrCBH4t7HsEdQm9MDZBrzlTrU2E/z1V9FBoNBoQWfFUC9L8sxuWq87+?=
 =?us-ascii?Q?kmHpHCRxM+kjl687vnpoTqVVuS7gRaYnzILrdttJzNl7KICxDRqE4pm0KnZq?=
 =?us-ascii?Q?KezY2/Cxy5PthlT2Uqn64e9AuhM/xA6g6/rNSgMNta1UgKvJ6tqzaklgaI/5?=
 =?us-ascii?Q?mXPAjd+eyLXT+ByE8MSLvCbauV5aOgyt7m/AjoqIYwPBcLuwkP5sIIJ13dop?=
 =?us-ascii?Q?Bm22xr/cvvJ3Bp7uJWzyCeBii86VsCsQtfRDiRYQoMw1ovJsZYQjIRi8zaNI?=
 =?us-ascii?Q?WIEsOLl+0ofUi57/L+Gcxs4dQtU+C1THGEMqHOfwE9HLRqtaYAHJKtWQnbSq?=
 =?us-ascii?Q?ASVxPqmFM9/4fpbt0F0pct+aidq582kpA6Ny8qrz9B7fsnshD5+XwpSHlFla?=
 =?us-ascii?Q?tfTbcSmfMjq/zmMSCb7E9q/fdI4PNXei+LdvUXejfTzcTvaJZ/5NBmndK/hV?=
 =?us-ascii?Q?E3/wjerR2ILOWiCp1gQKEBYxK8MOgkUcTzZtnfxcX9YOGqgQSSuQ1YGA3aZE?=
 =?us-ascii?Q?DHDMmB7hVtvNR3mYHjiDqyFuHybIpErnPcbHTE1dg82ocKrXu+Nlg4PPArC2?=
 =?us-ascii?Q?VYxH4uNrKMNNTP+GI+jO9yAzfGC3A3iLGhoPm6KDHF6YKofKlrjRN7nnGdsz?=
 =?us-ascii?Q?oJOF0u2FTEUIZGy9WmbhruYZCFmroyUZh07DNkmyZr/zCr4VEpGqhtFiD56A?=
 =?us-ascii?Q?ONH6Ur1UzXJi3UK3F8Af/QGtPTTrF6IN4BSGUKWabVA1fAzU41THatum1kTI?=
 =?us-ascii?Q?ycCvIv/MmQfYjvOLdCrU5hiu3jXkyxSQLsv4l3SyeuoZls8qYSBP2IIpWtR9?=
 =?us-ascii?Q?xM7ZyS3Oma61p8rzpm4iugafj25yYIZ4ErUcPFPjz7N0D9RE+jWgPEApcFuF?=
 =?us-ascii?Q?zCYuaA9UAkUzwQX8pAgpAjjcZ0eZqZRdoj7BRFiElYo/hPzmWAeCkQkdY3mg?=
 =?us-ascii?Q?+npaN5vy/PX2h4qqRzY2cna9JJojfattH2cgaEX3JJUMOGYtKn3CJvi10r+0?=
 =?us-ascii?Q?Rk562KHqJhtQsFruSWm4e2WHdfndyiHcQ8tJfK8t6dWpGLS8Vuz66t1xlYDp?=
 =?us-ascii?Q?5wgB2eZzWx28Z7dnhUW8vI3KPPHAyNXWCgcsCVdx4NU+poQwbrq8gZ7tKqMd?=
 =?us-ascii?Q?zYw5wh3O6i9kdGX6079FGDLywjA4aeG24eeQesFSTwS2Vzj8ZLy/WszcC6MK?=
 =?us-ascii?Q?+wjGL6Oy1Y5rktL83AuoHNXXQKdcXtlyO5xTH4f1cq2RH47j4llBsW/7PVoE?=
 =?us-ascii?Q?8ber9IqkH9pLrmwVjkJGc4H7Iehk2CAyv/SwoJoi03ewX8eKTn9q65cCX59l?=
 =?us-ascii?Q?5yL48WKoWSj7molt236JIc+UZj9KRadfvJ0mPuRXNYoIOaq0EFex39WO9Dhj?=
 =?us-ascii?Q?3ofGAWJeveLIaQbQGMljSNF7MlHRmnEl9DN/lcE4V7t5N1c6uNsA5dHPUHp2?=
 =?us-ascii?Q?B8sTh2ps2rO+mGUjlDQzFQx01+IKWHzyiQcXyPQQVeaICZwVnoVTN+qNn33J?=
 =?us-ascii?Q?DTC9gxVIgFMD3+SwBZVDMULSgGniGmJcpupYzBK335epuL1PE5m6JN9K2Cut?=
 =?us-ascii?Q?dvkNFHYxUwHcHSwP+cvJmbsNHTdDwcMGuTYD/qN9EyXdlvW2+7nHpvu2DNwq?=
 =?us-ascii?Q?PstXeHuy0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yJ3i8kshDX3VumhVD1dB/J8uz10Wa5xhuPoId+PXcbaeuKdTJPOLaiuIo7LSk0/9oA/HrFBi5niKcpsLaLidy2tNi1oX5iw2dRP/ZDy14JTwmNGi4+PTyTHkskV9ZsW8lDZjMyxji6uHwI7+5HYTJA25zGRT5uQXaBPccP+HhecDRrUWXhM98RNifuWuS6dLgu64TRLjIIOEZUvXYfmOUo2Td0b5eHvhIMJOBEiyptbnhpaNSBtipK8T28ia2Qm3JMDHj+cizK17/UPqZ4OPMBhh9l4TBsHWF2/fhYtxRzRn5cY+kjqaY5MCxlH62jpo4wcGwf+6ITSfzAPhe/RLDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3450df-3cbc-4617-c59f-08df43cb3e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2026 10:20:30.7430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYkhA+rFvp8GiVyZIsZB2aO9wxLu6cBFBdSq8jLj1e8pmP9cXtDiFhBd46iuhV+1fnuX288vn7acMU0Cj0WJsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Subject: [PATCH] eal: ignore errors from sendmsg on cleanup
>=20
> Silence a warning from Coverity.
> The call to rte_mp_sendmsg here is best effort during cleanup,
> no need to add additional error checking.
>=20
> Coverity ID: 507471
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  lib/eal/common/eal_common_proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/eal/common/eal_common_proc.c
> b/lib/eal/common/eal_common_proc.c
> index b70e9189a4..3e1af1325b 100644
> --- a/lib/eal/common/eal_common_proc.c
> +++ b/lib/eal/common/eal_common_proc.c
> @@ -717,7 +717,7 @@ rte_mp_channel_cleanup(void)
>  		memcpy(&msg.param, &req, sizeof(req));
>  		msg.len_param =3D sizeof(req);
>=20
> -		rte_mp_sendmsg(&msg);
> +		(void)rte_mp_sendmsg(&msg);
>  	} else {
>  		rte_mp_action_unregister(EAL_MP);
>  	}
> --
> 2.53.0

