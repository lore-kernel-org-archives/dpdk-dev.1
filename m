Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C3C77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 15:59:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F47F406B4;
	Tue, 24 Jun 2025 17:59:58 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id A449D4026B;
 Tue, 24 Jun 2025 17:59:56 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRV4Z35sjz6GDlV;
 Tue, 24 Jun 2025 23:59:10 +0800 (CST)
Received: from frapeml100002.china.huawei.com (unknown [7.182.85.26])
 by mail.maildlp.com (Postfix) with ESMTPS id CAA6A1402EA;
 Tue, 24 Jun 2025 23:59:54 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100002.china.huawei.com (7.182.85.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 24 Jun 2025 17:59:54 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Tue, 24 Jun 2025 17:59:54 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v2 02/10] test/telemetry: fix test calling all commands
Thread-Topic: [PATCH v2 02/10] test/telemetry: fix test calling all commands
Thread-Index: AQHb5EY4znvM8M6LkkyM82eIHpHGJ7QSdYHg
Date: Tue, 24 Jun 2025 15:59:54 +0000
Message-ID: <08ce2412f18d477199d3e02fdcf9bcd4@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
 <20250623135242.461965-3-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-3-david.marchand@redhat.com>
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

Reviewed-by: Marat Khalili <marat.khalili@huawei.com>

Just an idea, in case you have another iteration: could we maybe add a smal=
l check that $telemetry_script actually exists and executable to avoid simi=
lar situations in the future? Can be as simple as:

test -f "$telemetry_script"
test -x "$telemetry_script"

Due to -e in the first line it should fail the script of any of these tests=
 fail.

> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Monday 23 June 2025 14:53
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Bruce Richardson <bruce.richardson@intel.com>
> Subject: [PATCH v2 02/10] test/telemetry: fix test calling all commands
>=20
> This test was doing nothing as it could not find the telemetry client
> script following the test suite rework.
>=20
> Caught while looking at UNH unit test logs:
>=20
> /root/workspace/Generic-Unit-Test-
> DPDK/dpdk/app/test/suites/test_telemetry.sh:
> 18: /root/workspace/Generic-Unit-Test-DPDK/dpdk/app/usertools/dpdk-
> telemetry.py:
> not found
>=20
> Fixes: 9da71dc4f96e ("test: add test case for scripted telemetry commands=
")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/suites/test_telemetry.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/app/test/suites/test_telemetry.sh
> b/app/test/suites/test_telemetry.sh
> index ca6abe266e..20806b43e4 100755
> --- a/app/test/suites/test_telemetry.sh
> +++ b/app/test/suites/test_telemetry.sh
> @@ -7,7 +7,7 @@ which jq || {
>      exit 77
>  }
>=20
> -rootdir=3D$(readlink -f $(dirname $(readlink -f $0))/../..)
> +rootdir=3D$(readlink -f $(dirname $(readlink -f $0))/../../..)
>  tmpoutput=3D$(mktemp -t dpdk.test_telemetry.XXXXXX)
>  trap "cat $tmpoutput; rm -f $tmpoutput" EXIT
>=20
> --
> 2.49.0

