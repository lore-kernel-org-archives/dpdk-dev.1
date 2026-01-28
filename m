Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C12ED25B48
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 11:55:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3B0D40274;
	Wed, 28 Jan 2026 12:55:11 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1CEF7400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 12:55:11 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f1LKV5KHYzHnHBC;
 Wed, 28 Jan 2026 19:54:22 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 3A2BF40584;
 Wed, 28 Jan 2026 19:55:10 +0800 (CST)
Received: from frapema500003.china.huawei.com (7.182.19.114) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Jan 2026 12:55:10 +0100
Received: from frapema500003.china.huawei.com ([7.182.19.114]) by
 frapema500003.china.huawei.com ([7.182.19.114]) with mapi id 15.02.1544.011;
 Wed, 28 Jan 2026 12:55:10 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "scott.k.mitch1@gmail.com" <scott.k.mitch1@gmail.com>, Aaron Conole
 <aconole@redhat.com>
Subject: RE: [PATCH] ci: display UBSan stack trace
Thread-Topic: [PATCH] ci: display UBSan stack trace
Thread-Index: AQHckEX/rWx7+vBmbEqXDvMdTGikTbVnczlg
Date: Wed, 28 Jan 2026 11:55:09 +0000
Message-ID: <fdf5710e785c48c08cdd42e95aa56895@huawei.com>
References: <20260128110438.3003192-1-david.marchand@redhat.com>
In-Reply-To: <20260128110438.3003192-1-david.marchand@redhat.com>
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
> From: David Marchand <david.marchand@redhat.com>
> Sent: Wednesday 28 January 2026 11:05
> To: dev@dpdk.org
> Cc: scott.k.mitch1@gmail.com; Aaron Conole <aconole@redhat.com>
> Subject: [PATCH] ci: display UBSan stack trace
>=20
> When UBSan raises an error, we get really few context.
>=20
> Example, on a recently submitted patch:
>=20
> RTE>>cksum_fuzz_autotest
> ../lib/net/rte_cksum.h:49:10: runtime error: load of misaligned address
> 	0x0001816c2e81 for type 'const unaligned_uint16_t' (aka 'const
> 	unsigned short'), which requires 2 byte alignment
> 0x0001816c2e81: note: pointer points here
>  00 00 00  00 70 f2 00 00 00 00 00  00 00 00 00 00 00 00 00
>               ^
> 	00 00 00 00 00 00 00 00  00 00 00 00 00
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> 	../lib/net/rte_cksum.h:49:10 in
>=20
> Ask for the full stack.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  .ci/linux-build.sh | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> index 084d9642fc..091d239fae 100755
> --- a/.ci/linux-build.sh
> +++ b/.ci/linux-build.sh
> @@ -7,7 +7,11 @@ if [ -z "${DEF_LIB:-}" ]; then
>  fi
>=20
>  # Builds are run as root in containers, no need for sudo
> -[ "$(id -u)" !=3D '0' ] || alias sudo=3D
> +if [ "$(id -u)" =3D '0' ]; then
> +    run_as_root=3D""
> +else
> +    run_as_root=3D"sudo -E"

Just out of general principles, can we have --preserve-env=3DUBSAN_OPTIONS =
(or
necessary list) instead?

And/or, do we need to preserve environment for all commands below?

> +fi
>=20
>  install_libabigail() {
>      version=3D$1
> @@ -28,15 +32,15 @@ configure_coredump() {
>      # No point in configuring coredump without gdb
>      which gdb >/dev/null || return 0
>      ulimit -c unlimited
> -    sudo sysctl -w kernel.core_pattern=3D/tmp/dpdk-core.%e.%p
> +    $run_as_root sysctl -w kernel.core_pattern=3D/tmp/dpdk-core.%e.%p
>  }
>=20
>  catch_coredump() {
>      ls /tmp/dpdk-core.*.* 2>/dev/null || return 0
>      for core in /tmp/dpdk-core.*.*; do
> -        binary=3D$(sudo readelf -n $core |grep $(pwd)/build/ 2>/dev/null=
 |head -n1)
> +        binary=3D$($run_as_root readelf -n $core |grep $(pwd)/build/ 2>/=
dev/null |head -n1)
>          [ -x $binary ] || binary=3D
> -        sudo gdb $binary -c $core \
> +        $run_as_root gdb $binary -c $core \
>              -ex 'info threads' \
>              -ex 'thread apply all bt full' \
>              -ex 'quit'
> @@ -53,9 +57,9 @@ catch_ubsan() {
>=20
>  check_traces() {
>      which babeltrace >/dev/null || return 0
> -    for file in $(sudo find $HOME -name metadata); do
> -        ! sudo babeltrace $(dirname $file) >/dev/null 2>&1 || continue
> -        sudo babeltrace $(dirname $file)
> +    for file in $($run_as_root find $HOME -name metadata); do
> +        ! $run_as_root babeltrace $(dirname $file) >/dev/null 2>&1 || co=
ntinue
> +        $run_as_root babeltrace $(dirname $file)
>      done
>  }
>=20
> @@ -136,6 +140,7 @@ fi
>=20
>  if [ "$UBSAN" =3D "true" ]; then
>      sanitizer=3D${sanitizer:+$sanitizer,}undefined
> +    export UBSAN_OPTIONS=3Dprint_stacktrace=3D1

Won't it replace options meson sets by default? I actually see
print_stacktrace=3D1 among them, although maybe depends on version and
environment.

Also, do we care only about UBSAN_OPTIONS, or also ASAN_OPTIONS and
LSAN_OPTIONS here?

I will share ones we are using in case you find some of them interesting:

ASAN_OPTIONS=3Dabort_on_error=3Dtrue:color=3Dnever:halt_on_error=3Dtrue:pri=
nt_summary=3Dtrue:strict_string_checks=3Dtrue:check_initialization_order=3D=
true:detect_stack_use_after_return=3Dtrue:heap_profile=3Dfalse:print_scarin=
ess=3Dtrue:strict_init_order=3Dtrue:verify_asan_link_order=3Dfalse
LSAN_OPTIONS=3Dabort_on_error=3Dtrue:color=3Dnever:halt_on_error=3Dtrue:pri=
nt_summary=3Dtrue:strict_string_checks=3Dtrue
UBSAN_OPTIONS=3Dabort_on_error=3Dtrue:color=3Dnever:halt_on_error=3Dtrue:pr=
int_summary=3Dtrue:strict_string_checks=3Dtrue:print_stacktrace=3Dtrue:repo=
rt_error_type=3Dtrue

(Admittedly some of them might be unnecessary or nonsensical, they depend o=
n
compiler and it's not easy to find documentation.)

>      if [ "$RUN_TESTS" =3D "true" ]; then
>          # UBSan takes too much memory with -O2
>          buildtype=3Dplain
> @@ -218,7 +223,8 @@ fi
>  if [ "$RUN_TESTS" =3D "true" ]; then
>      failed=3D
>      configure_coredump
> -    sudo meson test -C build --suite fast-tests -t 3 --no-stdsplit --pri=
nt-errorlogs || failed=3D"true"
> +    $run_as_root meson test -C build --suite fast-tests -t 3 --no-stdspl=
it --print-errorlogs ||
> +        failed=3D"true"
>      catch_coredump
>      catch_ubsan DPDK:fast-tests build/meson-logs/testlog.txt
>      check_traces
> --
> 2.52.0

With or without comments above addressed,

Acked-by: Marat Khalili <marat.khalili@huawei.com>

