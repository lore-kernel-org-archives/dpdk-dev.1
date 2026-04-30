Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C94AFF8873
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 13:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0E39402A0;
	Thu, 30 Apr 2026 15:31:01 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 401244021F;
 Thu, 30 Apr 2026 15:31:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g5w5d3fy9zHnH5j;
 Thu, 30 Apr 2026 21:30:13 +0800 (CST)
Received: from frapema100003.china.huawei.com (unknown [7.182.19.100])
 by mail.maildlp.com (Postfix) with ESMTPS id 6077940569;
 Thu, 30 Apr 2026 21:30:59 +0800 (CST)
Received: from frapema100003.china.huawei.com (7.182.19.100) by
 frapema100003.china.huawei.com (7.182.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 30 Apr 2026 15:30:51 +0200
Received: from frapema100003.china.huawei.com ([7.182.19.100]) by
 frapema100003.china.huawei.com ([7.182.19.100]) with mapi id 15.02.1544.036;
 Thu, 30 Apr 2026 15:30:50 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: RE: [PATCH v2] devtools: fix SPDX tag check
Thread-Topic: [PATCH v2] devtools: fix SPDX tag check
Thread-Index: AQHc2KONqplSkwjYbUecaETF6wkAP7X3lfrQ
Date: Thu, 30 Apr 2026 13:30:50 +0000
Message-ID: <e59b182563e5498ea993d48663d8716a@huawei.com>
References: <20260429130935.3681177-1-thomas@monjalon.net>
 <20260430131600.329636-1-thomas@monjalon.net>
In-Reply-To: <20260430131600.329636-1-thomas@monjalon.net>
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

> diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
> index 2390941c74..41fc1fe01d 100755
> --- a/devtools/check-spdx-tag.sh
> +++ b/devtools/check-spdx-tag.sh
> @@ -39,10 +39,8 @@ check_spdx() {
>      fi
>=20
>      files_without_spdx=3D$(cat $tmpfile)
> -    git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $n=
o_license_list > $tmpfile
> -    for file in $files_without_spdx ; do
> -	sed -i "/^$file$/d" $tmpfile
> -    done
> +    git grep -LE '(/\*|#|;|\.\.) *SPDX-License-Identifier: [A-Z(]' -- $n=
o_license_list |
> +    grep -vF "$files_without_spdx" > $tmpfile
>=20
>      warnings=3D$(($warnings + $(wc -l < $tmpfile)))
>      $quiet || cat $tmpfile
> --
> 2.53.0

Sorry for forgetting to mention it right away, some kind of sentinel or if
condition is needed if $files_without_spdx can be empty, don't know how
realistic it is in practice and whether other parts are ready to handle thi=
s
case. E.g. `files_without_spdx=3D$(echo //sentinel; cat $tmpfile)`. I hope =
it
won't make the whole thing too complicated and not worth it.

Otherwise,

Acked-by: Marat Khalili <marat.khalili@huawei.com>
