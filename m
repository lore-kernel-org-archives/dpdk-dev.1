Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0F5C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 15:14:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 725D9402DC;
	Tue, 15 Jul 2025 17:14:34 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 7F6254028C
 for <dev@dpdk.org>; Tue, 15 Jul 2025 17:14:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhN444R5tz6L5GF;
 Tue, 15 Jul 2025 23:13:24 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D4F114038F;
 Tue, 15 Jul 2025 23:14:32 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Jul 2025 17:14:32 +0200
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 15 Jul 2025 17:14:32 +0200
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Ciara Loftus <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "bruce.richardson@intel.com" <bruce.richardson@intel.com>
Subject: RE: [PATCH v2] net/intel: deprecate some SSE paths
Thread-Topic: [PATCH v2] net/intel: deprecate some SSE paths
Thread-Index: AQHb7Cf8Yj1nJ5GeMkikBTB7pX2bx7QzXd7w
Date: Tue, 15 Jul 2025 15:14:32 +0000
Message-ID: <1e42646f1362423981eef0ae0efb34b9@huawei.com>
References: <20250703121624.1050845-1-ciara.loftus@intel.com>
 <20250703143119.1140097-1-ciara.loftus@intel.com>
In-Reply-To: <20250703143119.1140097-1-ciara.loftus@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.73]
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



> The SSE rx and tx paths will be removed from the i40e, iavf and ice
> drivers in the 25.11 release. Each of these drivers have faster vector
> paths (AVX2 and AVX-512) which have feature parity with the soon to be
> removed SSE paths. In environments where AVX2 or AVX-512 are not
> supported, the scalar path will still be used, which also has feature
> parity.
>=20
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/rel_notes/deprecation.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/=
deprecation.rst
> index e2d4125308..0d020c9c1f 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -80,6 +80,13 @@ Deprecation Notices
>    and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER=
_VXLAN_GPE_HLEN``
>    will be removed in DPDK 25.11.
>=20
> +* net/intel: drivers that have an SSE vector path alongside other vector=
 paths,
> +  namely i40e, iavf and ice, will have their SSE vector paths removed in=
 DPDK 25.11.
> +  Modern x86 systems all support AVX2, if not AVX-512, so the SSE path i=
s no longer
> +  widely used. This change will not result in any feature loss, as the f=
allback
> +  scalar paths which have feature parity with SSE will be used in the ca=
ses where
> +  the SSE paths would have been used.
> +
>  * ethdev: The flow API matching pattern structures, ``struct rte_flow_it=
em_*``,
>    should start with relevant protocol header structure from lib/net/.
>    The individual protocol header fields and the protocol header struct
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>=20

> 2.34.1

