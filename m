Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136CDD2F7D7
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 10:29:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3CB9402DC;
	Fri,  5 Dec 2025 11:29:40 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 69F8D40156;
 Fri,  5 Dec 2025 11:29:39 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dN70T3G5GzJ46Dt;
 Fri,  5 Dec 2025 18:29:29 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 250524056B;
 Fri,  5 Dec 2025 18:29:39 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Dec 2025 11:29:38 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Fri, 5 Dec 2025 11:29:38 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 10/10] buildtools/get-test-suites: suppress empty output
Thread-Topic: [PATCH v2 10/10] buildtools/get-test-suites: suppress empty
 output
Thread-Index: AQHcZUr2MP8ic0d9JkazktTRL0kK47US2V4w
Date: Fri, 5 Dec 2025 10:29:38 +0000
Message-ID: <6ddcbc0a6d6c497ab25629aa40c615d6@huawei.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251204182047.3154429-1-bruce.richardson@intel.com>
 <20251204182047.3154429-11-bruce.richardson@intel.com>
In-Reply-To: <20251204182047.3154429-11-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.138.16]
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
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Thursday 4 December 2025 18:21
> To: dev@dpdk.org
> Cc: Bruce Richardson <bruce.richardson@intel.com>; stable@dpdk.org
> Subject: [PATCH v2 10/10] buildtools/get-test-suites: suppress empty outp=
ut
>=20
> If there are no tests which are not assigned to a test suite, omit the
> line printing the non_suite_tests. This avoid having error messages from
> meson about test "" not being in any test suite.
>=20
> Fixes: 25065ef1f6c0 ("test: emit warning for orphaned tests")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  buildtools/get-test-suites.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/buildtools/get-test-suites.py b/buildtools/get-test-suites.p=
y
> index 73f1d9c9e1..36ed4bedc2 100644
> --- a/buildtools/get-test-suites.py
> +++ b/buildtools/get-test-suites.py
> @@ -38,4 +38,5 @@ def get_fast_test_params(test_name, ln):
>=20
>  for suite in test_suites.keys():
>      print(f"{suite}=3D{','.join(test_suites[suite])}")
> -print(f"non_suite_tests=3D{','.join(non_suite_tests)}")
> +if non_suite_tests:
> +    print(f"non_suite_tests=3D{','.join(non_suite_tests)}")
> --
> 2.51.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
