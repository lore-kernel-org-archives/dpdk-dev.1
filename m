Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AD6C5DF9B
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 12:10:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77C2D4068A;
	Mon, 24 Aug 2026 14:10:45 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 8872F4028B;
 Mon, 24 Aug 2026 14:10:43 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=oIB1Nvl6D4Z2MACHOiDsW3DBggnv7NCfxN1Fip6KD+A=;
 b=22f43jV+okXeDs+I3uK9ZgpZ4vwYPXB336WNBUPV4zAfWpvI0VCWCoh/Qua26mM+wE9wEFZDf
 FkUTmXn911fuNC9UoqJe47WDqd9CDg6XBnVKSMKZxoar8J7wMDn29NsrJDIz3Bgq+wm1GUDW8Tv
 4TDZToksitAck+OSvFqaeFg=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hT8r05DHHzJ46bD;
 Mon, 24 Aug 2026 20:10:24 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 126C54057E;
 Mon, 24 Aug 2026 20:10:41 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 14:10:40 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Mon, 24 Aug 2026 14:10:40 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Akhil Goyal <gakhil@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "jpalider@marvell.com" <jpalider@marvell.com>, "tduszynski@marvell.com"
 <tduszynski@marvell.com>, "jerinj@marvell.com" <jerinj@marvell.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] raw/cnxk_bphy: fix missing doxygen comments
Thread-Topic: [PATCH] raw/cnxk_bphy: fix missing doxygen comments
Thread-Index: AQHdJlX63+Q6E/AJ0UGnJQHUCHNoLbatJK3g
Date: Mon, 24 Aug 2026 12:10:40 +0000
Message-ID: <d5fa5e8bfb3a4bb18af355ce5a7152c5@huawei.com>
References: <20260807101718.3571504-1-gakhil@marvell.com>
In-Reply-To: <20260807101718.3571504-1-gakhil@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.15]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
> From: Akhil Goyal <gakhil@marvell.com>
> Sent: Friday 7 August 2026 11:17
> To: dev@dpdk.org
> Cc: jpalider@marvell.com; tduszynski@marvell.com; jerinj@marvell.com; tho=
mas@monjalon.net; Akhil Goyal
> <gakhil@marvell.com>; stable@dpdk.org; Marat Khalili <marat.khalili@huawe=
i.com>
> Subject: [PATCH] raw/cnxk_bphy: fix missing doxygen comments
>=20
> Documentation build for raw driver cnxk_bphy,
> if included in `doc/api/doxy-api.conf.in`,
> fails because of missing dozygen comments.
> Added comments to fix the doc build.
>=20
> Bugzilla ID: 1962
> Fixes: 2e8bd307fae3 ("common/cnxk: support switching CPRI/ETH back and fo=
rth")
> Fixes: bd2fd34ab86f ("common/cnxk: sync eth mode change command with firm=
ware")
> Cc: stable@dpdk.org
>=20
> Reported-by: Marat Khalili <marat.khalili@huawei.com>
> Signed-off-by: Akhil Goyal <gakhil@marvell.com>

Thank you for handling this!

Acked-by: Marat Khalili <marat.khalili@huawei.com>
Tested-by: Marat Khalili <marat.khalili@huawei.com>

> ---
>  doc/api/doxy-api.conf.in             | 1 +
>  drivers/raw/cnxk_bphy/rte_pmd_bphy.h | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
> index bedd944681..94096ee710 100644
> --- a/doc/api/doxy-api.conf.in
> +++ b/doc/api/doxy-api.conf.in
> @@ -24,6 +24,7 @@ INPUT                   =3D @TOPDIR@/doc/api/doxy-api-i=
ndex.md \
>                            @TOPDIR@/drivers/net/intel/ixgbe \
>                            @TOPDIR@/drivers/net/mlx5 \
>                            @TOPDIR@/drivers/net/softnic \
> +                          @TOPDIR@/drivers/raw/cnxk_bphy \
>                            @TOPDIR@/drivers/raw/dpaa2_cmdif \
>                            @TOPDIR@/drivers/raw/ifpga \
>                            @TOPDIR@/lib/eal/include \
> diff --git a/drivers/raw/cnxk_bphy/rte_pmd_bphy.h b/drivers/raw/cnxk_bphy=
/rte_pmd_bphy.h
> index f668e6ea82..99504dc496 100644
> --- a/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
> +++ b/drivers/raw/cnxk_bphy/rte_pmd_bphy.h
> @@ -174,6 +174,7 @@ enum cnxk_bphy_cgx_eth_link_mode {
>  	__CNXK_BPHY_CGX_ETH_LINK_MODE_MAX
>  };
>=20
> +/** Available CPRI modes */
>  enum cnxk_bphy_cgx_eth_mode_cpri {
>  	/** 2.4G Lane Rate */
>  	CNXK_BPHY_CGX_ETH_MODE_CPRI_2_4G_BIT,
> @@ -191,6 +192,7 @@ enum cnxk_bphy_cgx_eth_mode_cpri {
>  	CNXK_BPHY_CGX_ETH_MODE_CPRI_24_3G_BIT,
>  };
>=20
> +/** Available mode groups */
>  enum cnxk_bphy_cgx_mode_group {
>  	/** ETH group */
>  	CNXK_BPHY_CGX_MODE_GROUP_ETH,
> --
> 2.43.0
>=20

