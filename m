Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EADC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 21:21:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0D61402E7;
	Wed,  5 Feb 2025 22:21:01 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8A56F402B3
 for <dev@dpdk.org>; Wed,  5 Feb 2025 22:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738790460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=65wgbHHwBJ28mxr99LZJLkbiGsrW4h6kpQ7M9GTSqkk=;
 b=Fphs7LXdFub/bx1nq6JviMbUTNqfkbhihzM9BPfsokSY5FJ/YGpJeDkUBKPRJDpOsbrNd+
 3gVbqRapR6j7e2GWGUs9FyuoPXEENJka4qbNIqSq4ZJnEZ5LXY+8KO1oLdYzlSTdM7+YXV
 Nl5mbY66ChdzbnMu15KgkVDtrl0mElY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588--ZJQDwX_MWueK5YwFpmZSQ-1; Wed,
 05 Feb 2025 16:20:59 -0500
X-MC-Unique: -ZJQDwX_MWueK5YwFpmZSQ-1
X-Mimecast-MFC-AGG-ID: -ZJQDwX_MWueK5YwFpmZSQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A905E1800873; Wed,  5 Feb 2025 21:20:57 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.80.197])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B96B9195608D; Wed,  5 Feb 2025 21:20:55 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org,  David Marchand <david.marchand@redhat.com>,  Bruce
 Richardson <bruce.richardson@intel.com>,  Anatoly Burakov
 <anatoly.burakov@intel.com>,  Michael Santana <maicolgabriel@hotmail.com>
Subject: Re: [RFC] ci: Add support for Cirrus-CI service to test FreeBSD.
In-Reply-To: <CAJvnSUC0gSQ10P-Ddy0zjxzUPjD_+2PXO1WBESR5PUCm3KASkQ@mail.gmail.com>
 (Patrick Robb's message of "Tue, 4 Feb 2025 12:33:44 -0500")
References: <20250204160739.1603197-1-aconole@redhat.com>
 <CAJvnSUC0gSQ10P-Ddy0zjxzUPjD_+2PXO1WBESR5PUCm3KASkQ@mail.gmail.com>
Date: Wed, 05 Feb 2025 16:20:53 -0500
Message-ID: <f7ta5b0f5qi.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xGKi6Vi4MrxPFoy1my4Zkz0QAnnJhiYM5daxQ_k7Doo_1738790457
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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

Patrick Robb <probb@iol.unh.edu> writes:

> On Tue, Feb 4, 2025 at 11:07=E2=80=AFAM Aaron Conole <aconole@redhat.com>=
 wrote:
>
>  This commit adds preliminary support for developer driven FreeBSD testin=
g
>  via the Cirrus-CI cloud continuous integration system.
>
>  NOTE: Currently, this does not successfully execute.  See the following
>  build result:
>    https://cirrus-ci.com/task/5626189961756672
>
>  Full Logs:
>    https://api.cirrus-ci.com/v1/task/5626189961756672/logs/check.log
>
>  The tests themselves may need to be run as root.
>
>  Signed-off-by: Aaron Conole <aconole@redhat.com>
>  ---
>   .ci/freebsd-build.sh |  5 +++++
>   .ci/freebsd-setup.sh |  3 +++
>   .cirrus.yml          | 33 +++++++++++++++++++++++++++++++++
>   MAINTAINERS          |  1 +
>   4 files changed, 42 insertions(+)
>   create mode 100755 .ci/freebsd-build.sh
>   create mode 100755 .ci/freebsd-setup.sh
>   create mode 100644 .cirrus.yml
>
>  diff --git a/.ci/freebsd-build.sh b/.ci/freebsd-build.sh
>  new file mode 100755
>  index 0000000000..099f9fd448
>  --- /dev/null
>  +++ b/.ci/freebsd-build.sh
>  @@ -0,0 +1,5 @@
>  +#!/bin/sh
>  +
>  +cd build
>  +ninja
>  +meson install
>  diff --git a/.ci/freebsd-setup.sh b/.ci/freebsd-setup.sh
>  new file mode 100755
>  index 0000000000..762a8383c3
>  --- /dev/null
>  +++ b/.ci/freebsd-setup.sh
>  @@ -0,0 +1,3 @@
>  +#!/bin/sh
>  +
>  +meson setup build
>  diff --git a/.cirrus.yml b/.cirrus.yml
>  new file mode 100644
>  index 0000000000..727dcb14f4
>  --- /dev/null
>  +++ b/.cirrus.yml
>  @@ -0,0 +1,33 @@
>  +freebsd_build_task:
>  +
>  +  freebsd_instance:
>  +    matrix:
>  +      image_family: freebsd-15-0-snap
>  +      image_family: freebsd-14-2-snap
>  +    cpu: 4
>  +    memory: 4G
>  +
>  +  env:
>  +    DEPENDENCIES: git gcc wget openssl python3 meson pkgconf
>  +    PY_DEPS:      pyelftools
>  +    matrix:
>  +      COMPILER: gcc
>  +      COMPILER: clang
>  +
>  +  prepare_script:
>  +    - sysctl -w kern.coredump=3D0
>  +    - pkg update -f
>  +    - pkg install -y ${DEPENDENCIES}
>  +        $(pkg search -xq "^py3[0-9]+-(${PY_DEPS})-[0-9]+" | xargs)
>  +    - mkdir -p /usr/src
>  +    - git clone --depth 1 https://git.freebsd.org/src.git /usr/src
>
> Sorry, do you mind explaining why this is needed? And should it be clonin=
g to main or to the latest LTS tag? I think I am ignorant of what is
> required for your build process.

[1933/1938] Generating kernel/freebsd/contigmem with a custom command
FAILED: kernel/freebsd/contigmem.ko=20
/usr/bin/make -f ../kernel/freebsd/BSDmakefile.meson KMOD_OBJDIR=3Dkernel/f=
reebsd KMOD_SRC=3D../kernel/freebsd/contigmem/contigmem.c KMOD=3Dcontigmem =
'KMOD_CFLAGS=3D-I/tmp/cirrus-ci-build/build -I/tmp/cirrus-ci-build/config -=
include rte_config.h' CC=3Dclang
make: "/usr/share/mk/bsd.sysdir.mk" line 16: Unable to locate the kernel so=
urce tree. Set SYSDIR to override.
=09in /usr/share/mk/bsd.kmod.mk:4
=09in ../kernel/freebsd/BSDmakefile.meson:18

without this, no contigmem support.

>  +
>  +  configure_script:
>  +    - ./.ci/freebsd-setup.sh
>  +
>  +  build_script:
>  +    - ./.ci/freebsd-build.sh
>  +
>  +  check_script:
>  +    - meson test -C build --suite fast-tests -t 3
>
> You might be interested in this thread: https://bugs.dpdk.org/show_bug.cg=
i?id=3D761
>
> See Cody's comment from last April about unit tests being broken on FreeB=
SD 13.0 and 14.0. My recollection is that there is no volunteer to
> resolve these issues currently, which is why we are not targeting unit te=
sts for FreeBSD at the Community Lab - only build tests.

Hrrm... that's an interesting issue.  We probably do need some eyeballs
on the FreeBSD support side.

Thanks for taking a look.

>  +            || { cat ./build/meson-logs/testlog.txt; exit 1; }
>  diff --git a/MAINTAINERS b/MAINTAINERS
>  index b86cdd266b..ed1df17f3c 100644
>  --- a/MAINTAINERS
>  +++ b/MAINTAINERS
>  @@ -142,6 +142,7 @@ M: Aaron Conole <aconole@redhat.com>
>   M: Michael Santana <maicolgabriel@hotmail.com>
>   F: .github/workflows/build.yml
>   F: .ci/
>  +F: .cirrus.yml
>
>   Driver information
>   M: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
>  --=20
>  2.47.1
>
> Looks like it makes sense overall, thanks.
>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>=20

