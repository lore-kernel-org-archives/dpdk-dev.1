Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE50BC55174
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 19:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EE9B40285;
	Sun,  2 Aug 2026 21:37:14 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id C6F9C40272
 for <dev@dpdk.org>; Sun,  2 Aug 2026 21:37:12 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=DhwF53xI5o7n87B10jSutUcDEYpMIxaaHfxtCL/DgPk=;
 b=QvKsJEktvtYuko6Jyk7oz4PPb1LxzJEvjbOVIs002Bbj4yUOfzQf7pPk5lRS4fJa85LeMrBJK
 zy7VfFqd7DpUSrQewHGtj5xObXNzDa1PQOEkUXOUbULNBPy1VTBs+cdrbThv5sz8RauIg4PrG0N
 IGC8kSEUsnLiONDnQzIAaew=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hCqmc49lQzHnHCK;
 Mon,  3 Aug 2026 03:36:16 +0800 (CST)
Received: from frapema100001.china.huawei.com (unknown [7.182.19.23])
 by mail.maildlp.com (Postfix) with ESMTPS id 501B640575;
 Mon,  3 Aug 2026 03:37:05 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100001.china.huawei.com (7.182.19.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 2 Aug 2026 21:37:04 +0200
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Sun, 2 Aug 2026 21:37:04 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Jerin Jacob <jerinj@marvell.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Akhil Goyal <gakhil@marvell.com>, "Anoob
 Joseph" <anoobj@marvell.com>
Subject: RE: [RFC 11/21] test: include headers directly
Thread-Topic: [RFC 11/21] test: include headers directly
Thread-Index: AQHdIqtieNN7JL3cvEu+FjTbf/L76LaLIOMg
Date: Sun, 2 Aug 2026 19:37:04 +0000
Message-ID: <4a00ff617234470da636f5b1915eb663@huawei.com>
References: <20260802181835.476887-1-stephen@networkplumber.org>
 <20260802181835.476887-12-stephen@networkplumber.org>
In-Reply-To: <20260802181835.476887-12-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.72.147]
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

> diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
> index 3205afaa63..32389c803a 100644
> --- a/app/test/test_bpf.c
> +++ b/app/test/test_bpf.c
> @@ -15,6 +15,9 @@
>  #include <rte_random.h>
>  #include <rte_byteorder.h>
>  #include <rte_errno.h>
> +#include <rte_ip.h>
> +#include <rte_udp.h>
> +#include <rte_tcp.h>
>=20
>  #include "test.h"
>=20

This file has another group of includes guarded by RTE_LIB_BPF several line=
s
below, with `#include <rte_ip.h>` already there. It also seems that the gua=
rd
is redundant since `meson.build` already declares same dependency. We proba=
bly
should avoid adding duplicates, and optionally also do a cleanup here.

With test_pipeline_common.h I could not find what uses the newly added head=
er.
Other changed files have guards against MSVC which are not redundant. If th=
e
new includes were added under this guard I could probably ack the change as
harmless, but as is the opinion of other maintainers is needed. So maybe
splitting the commit per-file would accelerate the process.

Obvious question is if we could have some general policy and tools.
Explicit includes are good, but whack-a-mole approach can only go so far.

