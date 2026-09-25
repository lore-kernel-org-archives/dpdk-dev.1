Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67637C9830D
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C6EE4327E;
	Fri, 25 Sep 2026 12:13:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E8CE140DD3
 for <dev@dpdk.org>; Fri, 25 Sep 2026 12:13:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790331236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApV8U4HpO95/YcJgshE6Ra0e3wL+79yDoU+hREzxbs4=;
 b=XE4w5fTBEEupusKxO6IbTb0x/rg/XBCvXlskcQqCLb/rUicqfhMMNEA4GqkHHgWf2rTuBw
 5W6ZVcXwOGouN0Q7GHCgxDsHKBOK/FlbrTITlMmdvq60ej61HmpAuhImutEeUj2G6FxvFv
 K3Tqy2lDLexHCRGmld43ehQztZxgfLU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-8A4sxh7jMzq7QIFtj4geaw-1; Fri, 25 Sep 2026 06:13:55 -0400
X-MC-Unique: 8A4sxh7jMzq7QIFtj4geaw-1
X-Mimecast-MFC-AGG-ID: 8A4sxh7jMzq7QIFtj4geaw_1790331234
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5b74cdd0182so508190e87.0
 for <dev@dpdk.org>; Fri, 25 Sep 2026 03:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331233; x=1790936033;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ApV8U4HpO95/YcJgshE6Ra0e3wL+79yDoU+hREzxbs4=;
 b=1VNs5WmKXBH/DrcERvoa0uaEUP2kzW0nB4SHHd8FYElrOG43BgMAvyK9NidfBKLvFJ
 rVi2rlenYCo3tFd9O+to3LARq2L6sRB8hOlrzNQ+oOvEP/RSYWqIJXdd/hpSABdrkrYB
 AXHntzhWKk1InZR1Z6av7Tz4RDvInxC3wf7kfTvwS5S2iHf5ZL7nL9o6kzE8nu5ws3O5
 /NtSmxWJ3C9eftotykgX8cBTRGy6B4cJH6HlYi67ki/ao+U6eP+soxLNYEtr472zji1d
 O9cGsO2UzRfSSufId1NM8ZypwSUXCK0TC4+XpsNrWCPEKYJU1Q1364NEjG01VHNOzyrg
 9Afw==
X-Gm-Message-State: AFuF++l2IGUxbKTjiBeUGFB15pHUCoq66NU3apVa0XzvNWQlIZlyFcwP
 Mcc14/BpDVPKMuPOGwm20J05jvsZShw5BZLY8OQvH4zG+Coy/MSI6GyLcnQrdEHvmwTBhvanq5y
 nleeshOM5fCxgWJEP1oXyQN+fIq2SQMJUGC7XXLwjyzmuvg7OqTrgL9+hevlFVJ7U7DoJ1WgIoF
 RNUAtlFVItC5bN6yVX7Vk=
X-Gm-Gg: AYBFou3BAn9hpGow7m1MnB9AOiei7JedcamyG0pQJhVLYpgztUQhcPZNCygz1yOuj77
 flfTG3ERNILASR/+UEjMNXq0jXgPnBLl88YGLEaCideIFa3qVbn+meEauPH+Qv8O0WRmwMshe1z
 WDVdiBXIPLDt8EY0q3lgxGmTQLko9ZQHF3ONCU+ajXp+pTAYbTu6CWetzWHXxo5mRB+HlPDpWeg
 TC/yfTSeRi9MzZpffqQ1VxmEcU5iVG4+DIjtEe5f3BPkEOE
X-Received: by 2002:a05:6512:12c6:b0:5b6:183c:5ca1 with SMTP id
 2adb3069b0e04-5b8e0a37bc3mr1765798e87.63.1790331233437; 
 Fri, 25 Sep 2026 03:13:53 -0700 (PDT)
X-Received: by 2002:a05:6512:12c6:b0:5b6:183c:5ca1 with SMTP id
 2adb3069b0e04-5b8e0a37bc3mr1765789e87.63.1790331232851; Fri, 25 Sep 2026
 03:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260924141246.4037433-1-bruce.richardson@intel.com>
In-Reply-To: <20260924141246.4037433-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 25 Sep 2026 12:13:41 +0200
X-Gm-Features: AclHuK8HU3HKHk-plgBc-2ROt1-NMSzL3_BxPlZmlBcu1fE_Y2wGqoLrgix3dfo
Message-ID: <CAJFAV8x2qg7x_g=fQq3odv8cmrP_a=Ax4_HYZVpg-jwXVAujJA@mail.gmail.com>
Subject: Re: [PATCH] eal: fix C++ builds when stdatomics is set
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9BMg-Dn06ZEEsK0s8Jr_cxNz71GRmn_jikb5t4nXKNg_1790331234
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

On Thu, 24 Sept 2026 at 16:13, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> When the DPDK build is configured to use stdatomics rather than compiler
> builtin atomics, the C++ chkincs builds were failing
>
> In file included from buildtools/chkincs/staging/generic/rte_atomic.h:18,
>                  from /home/morten/upstreaming/dpdk-stack-std/lib/eal/x86=
/include/rte_atomic.h:12,
>                  from buildtools/chkincs/chkincs-cpp.p/rte_atomic.cpp:1:
> buildtools/chkincs/staging/rte_stdatomic.h:30:9: error: =E2=80=98memory_o=
rder=E2=80=99 does not name a type
>    30 | typedef memory_order rte_memory_order;
>       |         ^~~~~~~~~~~~
>
> The cause is differences in atomics in C (C11) and C++ (e.g. C++17 as
> supported by current GCC). As explained by AI analysis:
>
> " _Atomic(T) is a C11 feature. In C++ mode, GCC 15 does not support it as
>  a type specifier, and <stdatomic.h> in C++17 doesn't expose
>  memory_order in the global namespace (that's only in C++23). DPDK
>  headers also use _Atomic in anonymous unions and under extern "C",
>  which are incompatible with C++'s std::atomic<T> mapping."
>
> To fix this in a resilient manner we need to go from two blocks in
> rte_atomic.h to three. We have the existing non-standard/builtin
> atomics path, but the standard atomic path now needs to be split into C
> compatible and C++ compatible blocks. This fixes the build issues with
> C++ while keeping existing C builds unchanged.
>
> Bugzilla ID: 1985
> Fixes: 5c381a3587d1 ("eal: provide stdatomic API")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Probably worth squashing this in (I tested in GHA):

$ git diff
diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
index e0b914a142..b09d72dd87 100755
--- a/.ci/linux-build.sh
+++ b/.ci/linux-build.sh
@@ -111,13 +111,12 @@ OPTS=3D"$OPTS -Dplatform=3Dgeneric"
 OPTS=3D"$OPTS -Ddefault_library=3D$DEF_LIB"
 if [ "$STDATOMIC" =3D "true" ]; then
     OPTS=3D"$OPTS -Denable_stdatomic=3Dtrue"
+fi
+OPTS=3D"$OPTS -Dcheck_includes=3Dtrue"
+if [ "${CC%%clang}" !=3D "$CC" ]; then
+    export CXX=3Dclang++
 else
-    OPTS=3D"$OPTS -Dcheck_includes=3Dtrue"
-    if [ "${CC%%clang}" !=3D "$CC" ]; then
-        export CXX=3Dclang++
-    else
-        export CXX=3Dg++
-    fi
+    export CXX=3Dg++
 fi
 if [ "$MINI" =3D "true" ]; then
     OPTS=3D"$OPTS -Denable_drivers=3Dnet/null"


Compilation passes fine in my env and GHA.


--=20
David Marchand

