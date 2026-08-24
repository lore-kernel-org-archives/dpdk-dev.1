Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CDC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:13:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 300F740270;
	Mon, 24 Aug 2026 18:13:23 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 857F8400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:13:22 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ncgbbsLl3ynOhnfBahztIvfqFbFF9oL5W317Kn1gvvE=;
 b=n67fjdMBJP4eUbmrMDih0hoiTnC/qP+MNHCdmoBX7cm4GcHy2VtmH2NK+OE2FkIuJWRMJ87JZ
 qS+eVOtwhlOaM3T6nOSOy1ebW9tJjSD9ln9ypAsdKsk9fC5bx08vzPcntCQr4jN3YWv7dou02Lg
 ANwOEhn84qBupF+eb/7jWdg=
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hTGCw4bcVzJ4683;
 Tue, 25 Aug 2026 00:13:00 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 41CFD4058B;
 Tue, 25 Aug 2026 00:13:17 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 18:13:17 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.2562.045;
 Mon, 24 Aug 2026 18:13:17 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Yang Xiaoliang <xiaoliangyang69@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "bruce.richardson@intel.com" <bruce.richardson@intel.com>,
 "john.mcnamara@intel.com" <john.mcnamara@intel.com>
Subject: RE: [PATCH] examples/skeleton: fix typo in initialization comment
Thread-Topic: [PATCH] examples/skeleton: fix typo in initialization comment
Thread-Index: AQHdKm70mWsTFdaDAEqtOEZiXCGAZ7atcMRg
Date: Mon, 24 Aug 2026 16:13:16 +0000
Message-ID: <3127ca2c2be14896af8014c4b95704e0@huawei.com>
References: <20260812152555.32070-1-xiaoliangyang69@gmail.com>
In-Reply-To: <20260812152555.32070-1-xiaoliangyang69@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.78]
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
> From: Yang Xiaoliang <xiaoliangyang69@gmail.com>
> Sent: Wednesday 12 August 2026 16:26
> To: dev@dpdk.org
> Cc: bruce.richardson@intel.com; john.mcnamara@intel.com; Yang Xiaoliang <=
xiaoliangyang69@gmail.com>
> Subject: [PATCH] examples/skeleton: fix typo in initialization comment
>=20
> Fix "Initializion" typo, should be "Initialization".
>=20
> The sample app guide includes the comment via literalinclude with :start-=
after: anchored on the same
> string, so update both files together to keep the snippet extraction work=
ing.
>=20
> Signed-off-by: Yang Xiaoliang <xiaoliangyang69@gmail.com>
> ---
>  doc/guides/sample_app_ug/skeleton.rst | 2 +-
>  examples/skeleton/basicfwd.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/guides/sample_app_ug/skeleton.rst b/doc/guides/sample_ap=
p_ug/skeleton.rst
> index c4a29033fe..8a436b1182 100644
> --- a/doc/guides/sample_app_ug/skeleton.rst
> +++ b/doc/guides/sample_app_ug/skeleton.rst
> @@ -55,7 +55,7 @@ function. The value returned is the number of parsed ar=
guments:
>=20
>  .. literalinclude:: ../../../examples/skeleton/basicfwd.c
>      :language: c
> -    :start-after: Initializion the Environment Abstraction Layer (EAL). =
8<
> +    :start-after: Initialization the Environment Abstraction Layer (EAL)=
. 8<
>      :end-before: >8 End of initialization the Environment Abstraction La=
yer (EAL).
>      :dedent: 1
>=20
> diff --git a/examples/skeleton/basicfwd.c b/examples/skeleton/basicfwd.c
> index e8c18d5b87..3fdb83519f 100644
> --- a/examples/skeleton/basicfwd.c
> +++ b/examples/skeleton/basicfwd.c
> @@ -176,7 +176,7 @@ main(int argc, char *argv[])
>  	unsigned nb_ports;
>  	uint16_t portid;
>=20
> -	/* Initializion the Environment Abstraction Layer (EAL). 8< */
> +	/* Initialization the Environment Abstraction Layer (EAL). 8< */
>  	int ret =3D rte_eal_init(argc, argv);
>  	if (ret < 0)
>  		rte_exit(EXIT_FAILURE, "Error with EAL initialization\n");
> --
> 2.43.0

Even with the fix the phrase is still incorrect, nouns do not take direct o=
bject.
Should probably be `Initializing` or `Initialization of`. Consider using an=
 LLM.
