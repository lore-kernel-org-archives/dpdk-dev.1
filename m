Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E1CD29C28
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 13:21:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 294E14029A;
	Mon, 19 Jan 2026 14:21:02 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 0C13540299
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:21:00 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvrg862sXzJ46ZL;
 Mon, 19 Jan 2026 21:20:36 +0800 (CST)
Received: from frapema100004.china.huawei.com (unknown [7.182.19.128])
 by mail.maildlp.com (Postfix) with ESMTPS id B69F540570;
 Mon, 19 Jan 2026 21:20:59 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema100004.china.huawei.com (7.182.19.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 19 Jan 2026 14:20:59 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Mon, 19 Jan 2026 14:20:59 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Aaron Conole <aconole@redhat.com>
Subject: RE: [PATCH v2] ci: improve logging of unit tests runs
Thread-Topic: [PATCH v2] ci: improve logging of unit tests runs
Thread-Index: AQHciTqz7IAt9qcs+Uaf7O8Jd2bI3bVZeeJw
Date: Mon, 19 Jan 2026 13:20:59 +0000
Message-ID: <c45f79ce16944a3daa0fa45aba830a1c@huawei.com>
References: <20260119104147.219027-1-bruce.richardson@intel.com>
 <20260119115607.225929-1-bruce.richardson@intel.com>
In-Reply-To: <20260119115607.225929-1-bruce.richardson@intel.com>
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
> Sent: Monday 19 January 2026 11:56
> To: dev@dpdk.org
> Cc: Bruce Richardson <bruce.richardson@intel.com>; Aaron Conole <aconole@=
redhat.com>
> Subject: [PATCH v2] ci: improve logging of unit tests runs
>=20
> To help track down issues reported by CI test runs, add some additional
> meson flags to the run of the fast-tests:
>=20
> --no-stdsplit:
>   keep the stdout and stderr output interleaved, rather
>   than separated in the logs, to make following what is happening during
>   a test run easier.
> --print-errorlogs:
>   when an error with a unit test does occur, output to the terminal the
>   last N lines of output. This allows us to see inline what may have
>   failed without always needing to check log files.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
> V2: Drop max-lines flag, since it's only introduced in very recent meson
>     versions.
> ---
>  .ci/linux-build.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> index ceead259f3..084d9642fc 100755
> --- a/.ci/linux-build.sh
> +++ b/.ci/linux-build.sh
> @@ -218,7 +218,7 @@ fi
>  if [ "$RUN_TESTS" =3D "true" ]; then
>      failed=3D
>      configure_coredump
> -    sudo meson test -C build --suite fast-tests -t 3 || failed=3D"true"
> +    sudo meson test -C build --suite fast-tests -t 3 --no-stdsplit --pri=
nt-errorlogs || failed=3D"true"
>      catch_coredump
>      catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
>      check_traces
> --
> 2.51.0

Acked-by: Marat Khalili <marat.khalili@huawei.com>

(Using both flags in our local CI for long time.)
