Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D501FC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 08:40:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBFEA402C5;
	Thu,  2 Jul 2026 10:40:28 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 97B3140265
 for <dev@dpdk.org>; Thu,  2 Jul 2026 10:40:27 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4grVgC6VWCzJ46Ds;
 Thu,  2 Jul 2026 16:39:35 +0800 (CST)
Received: from frapema500001.china.huawei.com (unknown [7.182.19.243])
 by mail.maildlp.com (Postfix) with ESMTPS id 7D96D40575;
 Thu,  2 Jul 2026 16:40:25 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500001.china.huawei.com (7.182.19.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Jul 2026 10:40:25 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Thu, 2 Jul 2026 10:40:25 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: RE: [PATCH 1/2] bpf: default log level should be NOTICE
Thread-Topic: [PATCH 1/2] bpf: default log level should be NOTICE
Thread-Index: AQHdCancMEL+f4tXQU6VitF++wThYLZZ6Gkw
Date: Thu, 2 Jul 2026 08:40:25 +0000
Message-ID: <35e932e0908a4326bc4430ad947fbcfb@huawei.com>
References: <20260701223453.104660-1-stephen@networkplumber.org>
In-Reply-To: <20260701223453.104660-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.148]
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Wednesday 1 July 2026 23:35
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Konstantin Ananyev <k=
onstantin.ananyev@huawei.com>;
> Marat Khalili <marat.khalili@huawei.com>
> Subject: [PATCH 1/2] bpf: default log level should be NOTICE
>=20
> BPF is used by other services now and the default log
> level should match other libraries.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/bpf/bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bpf/bpf.c b/lib/bpf/bpf.c
> index 740c080591..695454a2d4 100644
> --- a/lib/bpf/bpf.c
> +++ b/lib/bpf/bpf.c
> @@ -78,4 +78,4 @@ __rte_bpf_jit(struct rte_bpf *bpf)
>  	return rc;
>  }
>=20
> -RTE_LOG_REGISTER_DEFAULT(rte_bpf_logtype, INFO);
> +RTE_LOG_REGISTER_DEFAULT(rte_bpf_logtype, NOTICE);
> --
> 2.53.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>

(I wonder if this default should have a name like LIB_DEFAULT.)
