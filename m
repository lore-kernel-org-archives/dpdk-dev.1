Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6856EC83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 11:50:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FBD840285;
	Thu, 24 Jul 2025 13:50:10 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id B2B1D40262
 for <dev@dpdk.org>; Thu, 24 Jul 2025 13:50:08 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bnq5W3wyvz6L5HJ;
 Thu, 24 Jul 2025 19:48:31 +0800 (CST)
Received: from frapeml500002.china.huawei.com (unknown [7.182.85.205])
 by mail.maildlp.com (Postfix) with ESMTPS id A833B1400C8;
 Thu, 24 Jul 2025 19:50:07 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Jul 2025 13:50:07 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Thu, 24 Jul 2025 13:50:07 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Bruce Richardson <bruce.richardson@intel.com>
Subject: RE: [PATCH v5 11/22] test/telemetry: catch errors in subshell
Thread-Topic: [PATCH v5 11/22] test/telemetry: catch errors in subshell
Thread-Index: AQHb+9aGTJtc8JqF+UmOqzVGPeGedrRBKRSQ
Date: Thu, 24 Jul 2025 11:50:07 +0000
Message-ID: <f20d8904fd014846b6096551b445be40@huawei.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
 <20250723133157.159825-12-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-12-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Wednesday 23 July 2025 14:32
> To: dev@dpdk.org
> Cc: Bruce Richardson <bruce.richardson@intel.com>
> Subject: [PATCH v5 11/22] test/telemetry: catch errors in subshell
>=20
> This script relies on subshell and pipes to prepare a list of commands
> to pass to the telemetry script.
>=20
> However, errors are not propagated to the parent process and the test
> may still pass when an error occurs.
> There is no POSIX option to cleanly catch all errors, so rely on bash
> options (as some CI envs run with bash).
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/suites/test_telemetry.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/app/test/suites/test_telemetry.sh
> b/app/test/suites/test_telemetry.sh
> index 20806b43e4..3c5b629b63 100755
> --- a/app/test/suites/test_telemetry.sh
> +++ b/app/test/suites/test_telemetry.sh
> @@ -15,7 +15,7 @@ call_all_telemetry() {
>      telemetry_script=3D$rootdir/usertools/dpdk-telemetry.py
>      echo >$tmpoutput
>      echo "Telemetry commands log:" >>$tmpoutput
> -    for cmd in $(echo / | $telemetry_script | jq -r '.["/"][]')
> +    echo / | $telemetry_script | jq -r '.["/"][]' | while read cmd
>      do
>          for input in $cmd $cmd,0 $cmd,z
>          do
> @@ -25,4 +25,6 @@ call_all_telemetry() {
>      done
>  }
>=20
> +! set -o | grep -q errtrace || set -o errtrace
> +! set -o | grep -q pipefail || set -o pipefail
>  (sleep 1 && call_all_telemetry && echo quit) | $@
> --
> 2.50.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>
