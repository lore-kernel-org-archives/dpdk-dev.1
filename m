Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFD2C02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 08:35:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDD394066D;
	Thu,  6 Feb 2025 09:35:46 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by mails.dpdk.org (Postfix) with ESMTP id 0EC324026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 09:35:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgHIOLVl0hQTm4d9n5VJXqfWb849ZBC/iZxEiETH2eLdYsuCTDtiTViqICBoZPGR7fI5ylHTyHnfdwIYcgcvRsLTelamqYkB5HXSkgEPwP8GQfM1cfX3fBejQtjDIwjSGriHRdhqfQOXLyp+BLjLMf8Jl0uoJ0OW3T5KLBJBWwIaCpAayqfe4BhuPy3yYAB8XuLDtQy5e/8gPquVxSOZ7HRzVReWVcvjJ8/V959CeFSYtsRNYY7ZtyYhVTjAcNfLCeZ9AKMY+V/vffe65OWCFIT0VIF1dJ6cry7AlVHegk6ly2w8MIbmRQloZ3dHFTOe2P2EJtRF8ly99Mfc+lCFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVigslLkY0cntmb75ZPNWWPvdLnTpLYLalcLzEnYUD0=;
 b=UYxTdGOAZhwLW4y3a/tHRAGuwXBJASJzplC4uJ6/ArVr1PStQ7D35gjk7jaMroYEvVB/BpNjHdC1lO82CIieZrnx+A1m8FmDKvvsj5ELlQNTw1ZcMrA1ZeSrALumniOMqzswYYOPYurzqRBWhExVC+RXa+SE6oBIb+a7Zpjhz59UqofShgVineaTL9r/fbwN3wKuoCOibgBlbMEdPWcGQYomiZ9n8qxLGCZwHhTjry6aDWfyQ2XeUR6YNC6RWDee4mthl8IHNU9vLT7IJ+x9HUBXmXBEpng9CSevHgxTDNMvMzMwXMLwrDoN5oBIN+4S43d525Wv28tdbMtG9H+3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVigslLkY0cntmb75ZPNWWPvdLnTpLYLalcLzEnYUD0=;
 b=iIpokHIPkoP9nC87YmIKXnhItYuoYJZVzCkHtxsEL/aOB2hI9XnPEvlTeEUbriqmlLAZhm8fvMWOrmoC7TqzifPwKnTsIThOQ98Ka+OhWDqmIbcBEQq0uHUKbuXDaLENw31JF/r6XD6WzH/t2VcBZKl/GY9Z7dI82f+Tl6S7UTqzoITATMcWnhfGLGIOY7JOoNPhBKQRRWWt8LUJkFLfjAk4owgu53sx2T/RGFsahDiVePKl4kImEX3QuCfA96co2CID3zTb0XU30Yl6ts/MnIQxS9bgI9fzA+X2B+52/03ozcO79ONoQ/uowLzQKpRKs5oBR7y74geHEG+jjiL3Hg==
Received: from MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Thu, 6 Feb
 2025 08:35:42 +0000
Received: from MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8]) by MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 08:35:41 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "otilibil@eurecom.fr"
 <otilibil@eurecom.fr>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>
Subject: Re: [PATCH] vhost: fix VDUSE devices registration
Thread-Topic: [PATCH] vhost: fix VDUSE devices registration
Thread-Index: AQHbc+F0E7b9MwIRKECa4C4BVWUunbM5/G8A
Date: Thu, 6 Feb 2025 08:35:41 +0000
Message-ID: <ABE5D435-146D-4D71-B824-A29A89D02B45@nvidia.com>
References: <20250131130957.293562-1-maxime.coquelin@redhat.com>
In-Reply-To: <20250131130957.293562-1-maxime.coquelin@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6103:EE_|PH7PR12MB5656:EE_
x-ms-office365-filtering-correlation-id: a4ad5ad8-376e-4a17-3103-08dd46893dc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Nxkbxs6sJE/ytCTzYCzYNW34fquxMxcaCGo3N8InSfWHRRIS0oJAcEtjLCaS?=
 =?us-ascii?Q?DWJ2EKbd+MAjZWs2FXaZKD2qx+twlEwi8ZJyqrBjHpVBzxzZiMBw9MTYIKM0?=
 =?us-ascii?Q?CaPlqu6QITS9TflMQ7UpsvXe8cUpFoK4/Hk96ae1EStAN3by615eteV5LnCf?=
 =?us-ascii?Q?i9ZKohjwNhf/vfDXtQ/bupq4nP0DqB19ridMqMeN6jNhWRThE/BfLWClQ6ku?=
 =?us-ascii?Q?Y6Y5MCV/zwoSI7VOEMEsywYoyKnPMhQxenzKKehuhHvKdoOn9/YiMsOUnYzo?=
 =?us-ascii?Q?dlPvpR0pDB4gfe9lxblfnC+b9906NOxpq5ixCvw2V3VbZzdqeOfalLMjoLZH?=
 =?us-ascii?Q?dQIgLu/Kd18X+8CYge1GZxhgtVEVe26LwSZl+A4lWkkehv8IgciX70DmFxP9?=
 =?us-ascii?Q?0D7+kGUX8HB6U8lsw1bD7Fi8RF23hVtweUCHfayyYuOSmP7pQCNql0fOPLRL?=
 =?us-ascii?Q?Z0MYj+jLjcCMU4PE9BAJ9ryEEwNgkxpyFZaMCGPwLK2/NOO0XozuCrEiblbW?=
 =?us-ascii?Q?PnFy+1ETEMI0HOh477sF7O1l15AfpuqNOqD4v4xP4U8PJ0+W0riLgJIlguLC?=
 =?us-ascii?Q?QFzF2LFvjldctvi0rMXHupprIIxm3fsd3RgVJ9nAjEs4UFR2eeejo++fEY/z?=
 =?us-ascii?Q?y8BRtLznhFoUVsefBdWTQmBibZ+kjwJASDibOnVQwfVcFiRenkxhEd6/+Rvl?=
 =?us-ascii?Q?i8Zrm9fk1gnttuQnLeSCQgU0aUB7o21qDDQvYcQiPEY+/jonrSwbFRCZ3irq?=
 =?us-ascii?Q?S7PPt6ZB/dwB3Rs75XvB7KDd+yfUyKKLK/rgF7RWhyLL7qOgjDXGtb+sao5M?=
 =?us-ascii?Q?MfBojlT6QG76uqp3+uVWLyf8FkryfkiHqSs3VwVZCISWgSVaorEYamfnvEhO?=
 =?us-ascii?Q?EIvUiT+/iqFarkE4/eTcR5cPFkuB6H8Lp/cYPO06Dk7D6EttvuulNLvMx83n?=
 =?us-ascii?Q?ft+GqsSIljJ3pPyJ7jUAPQsX/UcFb5Aon5toQkSa8V9koB+egnXQhYKz8rnn?=
 =?us-ascii?Q?EiNZdTjgKfabbBvkRXxHKrcrfq9vDKKWhrdtl3+TdJmW+Ai6SshaF9dFLuA7?=
 =?us-ascii?Q?bG85EbzknzHIkIXRphmrJkvB6YKsQr+rh3ZlH4AFVrJx+xJbJG/kZdjVG3QR?=
 =?us-ascii?Q?mAEpUQzkZwzoYznfmkKJiiTHD1ScSyJ49SwIbNPaCRZD7iuUTNyBCI7d0xKc?=
 =?us-ascii?Q?VK31GKAl2EOVZ98GesjaNx4f13fdM9fLHUFo0g77VmtrdIY7cyZO4raTrzcg?=
 =?us-ascii?Q?JSl+Z6/wKhLWl1tlTO8592CBBchVgClN3Izum/Mfga82+C80AdhGzBtykxJ2?=
 =?us-ascii?Q?RBuQuG/g0n6ZNZBUJvokerWlWCX6HHnfTKeYAF9ripJVxDErtLRnhFXwNOJ4?=
 =?us-ascii?Q?qpKCl4KGAmDcHjf+63/9gzgqE0+GHXMV/vXTpU7b2lNLLcaTLc8tXtv8rEA+?=
 =?us-ascii?Q?7jxPNsiJsX1tpCaGEYwvwX3pPy5Xx9ei?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6103.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I1wxwE67kJo8z5x1S1FCyYBPQ/y+BR+NWkD3vyLr7lfTrRZint1MZWBZe0Ro?=
 =?us-ascii?Q?oRYHZ1OWaThlOpYq8VaEmNRxjjOcgL/q+h6Xv3y1TPaBE8vNiqpr6exWYz67?=
 =?us-ascii?Q?QILcbOJDsSxzwxj8fnDtikFTQRqs6ov1PpgmzN81tCV753eYcBQYSBddFCAy?=
 =?us-ascii?Q?bxP7yIlZbel77n1PA0rwvTdZ3KTUCMWeubS6oQdYg1nJKEdtCpwkAN28QESI?=
 =?us-ascii?Q?qqsNB1JBLOtR8rC23rSu6mNIfI8AA/O7DXw3GNEpFFPXqx6zr8E534+/DQIX?=
 =?us-ascii?Q?YDOoF84bIyYLGP34MFgRJgwDLj9LQxNnRCIax/Z6ItNln3ThxhCtZcY9g6nn?=
 =?us-ascii?Q?SPjhG4gukukdaybPASzKlRgt+8O+QfMvprPF+zY4Krffjp+Sv2OI8tArD+l3?=
 =?us-ascii?Q?m9BDgO/2MIR/nTL2FVhH4B5qiJ2BgUhTpw3KrH482y/eFCUJNEaBwD4fQAi1?=
 =?us-ascii?Q?eptcH3ne/1iI16qWxa3+QXHaNKwedn9aXx4u+nZqd05rKiCGS1qRPBSo/513?=
 =?us-ascii?Q?j/pwvr7VotmHzF9X//aZN/yzjQ7F2WauPFXH7F6i9v/Dbkl8kWTMifDH81EG?=
 =?us-ascii?Q?JGpRQMvtUWrDOYoU91a/FPILJQYDrIQ45/at3tZqA5/K789rE1VFcRVFg9m+?=
 =?us-ascii?Q?/i6L4e0eYZn1Mo1TparxTvs99Kd/Vxyy+6VyxSGNfLULeUliv+t9C+1u0tDJ?=
 =?us-ascii?Q?ozj2o7a/9ODg7rARECFiNUo4a9ke9FBpScVggb4TvMJtr/7WjX9ysW9RpUf9?=
 =?us-ascii?Q?ycS9k7yN7LjKtQNqW4w5xiAWc+WC/kYYiJT08hbtB8cqbgo/biWi14PAuOdm?=
 =?us-ascii?Q?B5zfXwMyK6/gosDW2Gx7ZykrmDdFGpm89vB6CTlqzoRFsVkmoUkzyzrEt/vg?=
 =?us-ascii?Q?osj9TFBKJK7LmxJVfOrKV22iD0IAQuxpmDUQSk1vtRs1GuzMlMBMG9BAmkfb?=
 =?us-ascii?Q?ybFgfz6yQmJvpitqtMgBGU+LACL/yoL+IshPzdurS6HxlzaVwEtaeUf7JgMy?=
 =?us-ascii?Q?rJTzSVrVEoOY8lK/enbRbceK2Iyd5ejIs2DE0IohIOV8X0MewqM6eh0xb+Q7?=
 =?us-ascii?Q?WQ8Qm2n41TjiGEsSXE+Vhagt3Ao70hy4svRqGV65WDST2rltoatqkl/tlX4s?=
 =?us-ascii?Q?PYXpZ9We3yDY+dnwz4T5/vSSn34L9QhbKo3yU8bCNAs2Zhq3/BgCJwVqAmCQ?=
 =?us-ascii?Q?3Eq22uQnZBa5IuzUFQvLzuGmoAXebk/HuRDDRw1H4p9fUrdLqjQy1TpmVsmi?=
 =?us-ascii?Q?ME6nCQW12DkXXaZUkQ8yoXtoB0POxG+qWqov0pygC1W7xkX/K4O1vf/e9m8n?=
 =?us-ascii?Q?UnXI6SXKpJcNuCvo0i0zYIKTz9U1sCIQMRFS2O5nCuAkWP54V/M0/XjEGDh1?=
 =?us-ascii?Q?jEqDG7XhXKb2kpsAEwbSfWnxhYsRrFKrx0Te2MBeSSsIEFEsTMfJXWToZeRR?=
 =?us-ascii?Q?0zQi0/tvG6ss5tjdeB7Vct1RIrh8UejsJtoS2oV+C+alXOe8IvuR9w64LTjc?=
 =?us-ascii?Q?80LtlL1DDtnXTrnTlGiYJxCy1SKWt5sFjST9qly+ePkHkiT8L6BBiImm5PXl?=
 =?us-ascii?Q?MF8b52U+BJ1yt/B5J0XHG5kMM4/a18CzPBW/rhH+?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <540A0D21165EA64D90ABEA08361296AF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ad5ad8-376e-4a17-3103-08dd46893dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 08:35:41.7075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfVDVsRJDqq1xtKff/c6QZWJ4wdOAaln93IrUZyGGDgCYZ+vNpJD7s83mkFE1up0grmx6hOFznWzH1xMIz0ktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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



> On Jan 31, 2025, at 21:09, Maxime Coquelin <maxime.coquelin@redhat.com> w=
rote:
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> This patch fixes a regression in vhost_driver_register()
> causing VDUSE devices registration to fail systematically
> because the return value was initialized to -1 and not
> changed later on for this type of devices.
>=20
> Fixes: 4d2aa150769b ("vhost: remove check around mutex init")
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
> lib/vhost/socket.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
> index 433a42bf80..894a0f0dcb 100644
> --- a/lib/vhost/socket.c
> +++ b/lib/vhost/socket.c
> @@ -893,7 +893,6 @@ vhost_user_socket_mem_free(struct vhost_user_socket *=
vsocket)
> int
> rte_vhost_driver_register(const char *path, uint64_t flags)
> {
> -       int ret =3D -1;
>        struct vhost_user_socket *vsocket;
>=20
>        if (!path)
> @@ -997,7 +996,6 @@ rte_vhost_driver_register(const char *path, uint64_t =
flags)
>        } else {
> #ifndef RTE_LIBRTE_VHOST_POSTCOPY
>                VHOST_CONFIG_LOG(path, ERR, "Postcopy requested but not co=
mpiled");
> -               ret =3D -1;
>                goto out_mutex;
> #endif
>        }
> @@ -1012,15 +1010,14 @@ rte_vhost_driver_register(const char *path, uint6=
4_t flags)
>                } else {
>                        vsocket->is_server =3D true;
>                }
> -               ret =3D create_unix_socket(vsocket);
> -               if (ret < 0)
> +               if (create_unix_socket(vsocket) < 0)
>                        goto out_mutex;
>        }
>=20
>        vhost_user.vsockets[vhost_user.vsocket_cnt++] =3D vsocket;
>=20
>        pthread_mutex_unlock(&vhost_user.mutex);
> -       return ret;
> +       return 0;
>=20
> out_mutex:
>        if (pthread_mutex_destroy(&vsocket->conn_mutex)) {
> @@ -1028,8 +1025,7 @@ rte_vhost_driver_register(const char *path, uint64_=
t flags)
>        }
> out:
>        pthread_mutex_unlock(&vhost_user.mutex);
> -
> -       return ret;
> +       return -1;
> }
>=20
> static bool
> --
> 2.48.1
>=20

Reviewed-by: Chenbo Xia <chenbox@nvidia.com>

