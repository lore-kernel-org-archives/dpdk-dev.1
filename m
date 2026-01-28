Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05412D3F079
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 14:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFCFE402AF;
	Wed, 28 Jan 2026 15:57:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6EE204003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 15:57:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769612240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W687yHDBBvHNcHpqm5hsDwN4RxWp4SOxp+IWRNP09po=;
 b=XbXlBD4tab38KYf5CojhSBUOOMm0JrPTjYkGt9/PIHRmRTg81KQBqEbEyelXj16/+RMRS6
 eUfRFU0BozqHVbsWhiZi2myk+oZXDryp5p5hKn6hI2n3IpLpffYnmFXDsdskVhrC+OGDOv
 JZRairFwWh/q0JtuNr4yuVd83iKJyWc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-EcuEhuRqPZ6po7Yb_XBvRw-1; Wed, 28 Jan 2026 09:57:18 -0500
X-MC-Unique: EcuEhuRqPZ6po7Yb_XBvRw-1
X-Mimecast-MFC-AGG-ID: EcuEhuRqPZ6po7Yb_XBvRw_1769612237
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59b70088327so4575117e87.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 06:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769612237; x=1770217037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W687yHDBBvHNcHpqm5hsDwN4RxWp4SOxp+IWRNP09po=;
 b=QdaPtnoa1dS84FqBC+zb+uNWOsE4eUWi0kFxaJHB9v7Y+cwru6CPgTljABI4o/pqUR
 2vBMqbZVdl91qs9V6FQPtLtF77XqDNQitkxnrrT3OaLINiPYy51zTquVGYNySEEEWaji
 tB3EKK0VUzme06QN0LuJarzVseGRTBfUBREXMbSbuz5WeMCqSLA3KaN5wPe4WuH0L3WE
 +hcyINeBXS3Q0v6q2f+JBaVDfh3UEgNRP7zN5GUAWiBe0FBZKgbTDsFhZsNxC3EW9zTK
 BcWJRXGJxgP+GPSKewmJTxvOqCKli0UEy2S5H4nOkWVsYbUUUjAL9G6dF4qf5i8LkPJ7
 qGmQ==
X-Gm-Message-State: AOJu0Yy/HCXxF3jMu2cxmFO2/LWsGUzPZNWQvuEDt8gjVE2zH+EZS2fn
 /w1YDtGj+4NgwDHHG+SLYxF4rTGGMurgNP9imsTQGCSp7aCJU0DJfWw7VivfPp/EKWvc1kK+xpZ
 j9/s14tQ1GWGXKTmKeUCct2aniWcCCE6OcxRlnnXJ7LIlirK3O+eA0+RwQcBqkSBTsRSnwW7igD
 +J28inlS75TC/VF5zkJ3o=
X-Gm-Gg: AZuq6aIxEPyV0jHf/IUnleAiqboJi72Do1/wCfoqsP8mI2KBQR46p3vZ4YyJTwttLr+
 lfD6Ia8hrrHivaTh+ouFl7rPfB74D+FF8zM9Z+SjBsmH50R3FKFH6SWusNlZGu+naQMvN/c73tg
 N7Hl71Y2MM87FIuM4ZSZHzpfPLXIMw9wL/PsIeffUtvqDOL3HgbPdPBb9BsHuJvqUwkE+hcsGi/
 nMvsePZ6hObCtMEUjWAGynRo1QSX/It/5P705hXAZFff8YQqnWPSdD46w==
X-Received: by 2002:a05:6512:3b90:b0:59c:ba13:f12c with SMTP id
 2adb3069b0e04-59e04030873mr2000270e87.35.1769612237182; 
 Wed, 28 Jan 2026 06:57:17 -0800 (PST)
X-Received: by 2002:a05:6512:3b90:b0:59c:ba13:f12c with SMTP id
 2adb3069b0e04-59e04030873mr2000255e87.35.1769612236661; Wed, 28 Jan 2026
 06:57:16 -0800 (PST)
MIME-Version: 1.0
References: <20260128110438.3003192-1-david.marchand@redhat.com>
 <fdf5710e785c48c08cdd42e95aa56895@huawei.com>
In-Reply-To: <fdf5710e785c48c08cdd42e95aa56895@huawei.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 28 Jan 2026 15:57:04 +0100
X-Gm-Features: AZwV_Qj9sfZEIs7kTXtXsqEq7lanSSaKVGWAltitQQpIkJdYO04twDCgh48OcA8
Message-ID: <CAJFAV8ytz4CJh8msWU354J3cbPU0r94-kg_3DWCDh5pvnbfXTQ@mail.gmail.com>
Subject: Re: [PATCH] ci: display UBSan stack trace
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>,
 "scott.k.mitch1@gmail.com" <scott.k.mitch1@gmail.com>, 
 Aaron Conole <aconole@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vegE9PwlBIRqT-3_XdCSfXw_69yRWa-_CIckURdIxfw_1769612237
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello,

On Wed, 28 Jan 2026 at 12:55, Marat Khalili <marat.khalili@huawei.com> wrot=
e:
> > Subject: [PATCH] ci: display UBSan stack trace
> >
> > When UBSan raises an error, we get really few context.
> >
> > Example, on a recently submitted patch:
> >
> > RTE>>cksum_fuzz_autotest
> > ../lib/net/rte_cksum.h:49:10: runtime error: load of misaligned address
> >       0x0001816c2e81 for type 'const unaligned_uint16_t' (aka 'const
> >       unsigned short'), which requires 2 byte alignment
> > 0x0001816c2e81: note: pointer points here
> >  00 00 00  00 70 f2 00 00 00 00 00  00 00 00 00 00 00 00 00
> >               ^
> >       00 00 00 00 00 00 00 00  00 00 00 00 00
> > SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> >       ../lib/net/rte_cksum.h:49:10 in
> >
> > Ask for the full stack.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  .ci/linux-build.sh | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> > index 084d9642fc..091d239fae 100755
> > --- a/.ci/linux-build.sh
> > +++ b/.ci/linux-build.sh
> > @@ -7,7 +7,11 @@ if [ -z "${DEF_LIB:-}" ]; then
> >  fi
> >
> >  # Builds are run as root in containers, no need for sudo
> > -[ "$(id -u)" !=3D '0' ] || alias sudo=3D
> > +if [ "$(id -u)" =3D '0' ]; then
> > +    run_as_root=3D""
> > +else
> > +    run_as_root=3D"sudo -E"
>
> Just out of general principles, can we have --preserve-env=3DUBSAN_OPTION=
S (or
> necessary list) instead?
>
> And/or, do we need to preserve environment for all commands below?

We could, but I wanted to keep the change simple.

In this patch, a single point in this script is used to trigger use of
sudo or not.
Otherwise, I would have to keep two separate variable/alias for
calling simple sudo, and running the unit tests.

And like this, there is no question about which variable must be preserved.


>
> > +fi
> >
> >  install_libabigail() {
> >      version=3D$1
> > @@ -28,15 +32,15 @@ configure_coredump() {
> >      # No point in configuring coredump without gdb
> >      which gdb >/dev/null || return 0
> >      ulimit -c unlimited
> > -    sudo sysctl -w kernel.core_pattern=3D/tmp/dpdk-core.%e.%p
> > +    $run_as_root sysctl -w kernel.core_pattern=3D/tmp/dpdk-core.%e.%p
> >  }
> >
> >  catch_coredump() {
> >      ls /tmp/dpdk-core.*.* 2>/dev/null || return 0
> >      for core in /tmp/dpdk-core.*.*; do
> > -        binary=3D$(sudo readelf -n $core |grep $(pwd)/build/ 2>/dev/nu=
ll |head -n1)
> > +        binary=3D$($run_as_root readelf -n $core |grep $(pwd)/build/ 2=
>/dev/null |head -n1)
> >          [ -x $binary ] || binary=3D
> > -        sudo gdb $binary -c $core \
> > +        $run_as_root gdb $binary -c $core \
> >              -ex 'info threads' \
> >              -ex 'thread apply all bt full' \
> >              -ex 'quit'
> > @@ -53,9 +57,9 @@ catch_ubsan() {
> >
> >  check_traces() {
> >      which babeltrace >/dev/null || return 0
> > -    for file in $(sudo find $HOME -name metadata); do
> > -        ! sudo babeltrace $(dirname $file) >/dev/null 2>&1 || continue
> > -        sudo babeltrace $(dirname $file)
> > +    for file in $($run_as_root find $HOME -name metadata); do
> > +        ! $run_as_root babeltrace $(dirname $file) >/dev/null 2>&1 || =
continue
> > +        $run_as_root babeltrace $(dirname $file)
> >      done
> >  }
> >
> > @@ -136,6 +140,7 @@ fi
> >
> >  if [ "$UBSAN" =3D "true" ]; then
> >      sanitizer=3D${sanitizer:+$sanitizer,}undefined
> > +    export UBSAN_OPTIONS=3Dprint_stacktrace=3D1
>
> Won't it replace options meson sets by default? I actually see
> print_stacktrace=3D1 among them, although maybe depends on version and
> environment.

This change may overwrite anything that meson sets, but on the other
hand, we need it with the current meson version used in the CI.


>
> Also, do we care only about UBSAN_OPTIONS, or also ASAN_OPTIONS and
> LSAN_OPTIONS here?
>
> I will share ones we are using in case you find some of them interesting:
>
> ASAN_OPTIONS=3Dabort_on_error=3Dtrue:color=3Dnever:halt_on_error=3Dtrue:p=
rint_summary=3Dtrue:strict_string_checks=3Dtrue:check_initialization_order=
=3Dtrue:detect_stack_use_after_return=3Dtrue:heap_profile=3Dfalse:print_sca=
riness=3Dtrue:strict_init_order=3Dtrue:verify_asan_link_order=3Dfalse
> LSAN_OPTIONS=3Dabort_on_error=3Dtrue:color=3Dnever:halt_on_error=3Dtrue:p=
rint_summary=3Dtrue:strict_string_checks=3Dtrue
> UBSAN_OPTIONS=3Dabort_on_error=3Dtrue:color=3Dnever:halt_on_error=3Dtrue:=
print_summary=3Dtrue:strict_string_checks=3Dtrue:print_stacktrace=3Dtrue:re=
port_error_type=3Dtrue
>
> (Admittedly some of them might be unnecessary or nonsensical, they depend=
 on
> compiler and it's not easy to find documentation.)

Did those options help with understanding failures in unit tests?
I see "abort" or "halt" options in this list, does it stop execution
of all the tests?


Overall, the current script does everything, from detecting it needs
to run parts with sudo, to configuring ubsan stuff (for example here).
Maybe it could be interesting to better split the scripts, isolate
what needs special permissions, but that's a different topic.


--=20
David Marchand

