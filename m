Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64FAC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 15:49:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B5454026F;
	Fri,  3 Jul 2026 17:49:44 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 93F1A4003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 17:49:42 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-380cda7f00cso633765a91.0
 for <dev@dpdk.org>; Fri, 03 Jul 2026 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783093781;
 x=1783698581; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QBej8OCJOwyuOebhssR6JlgOD193q8iu0yJLVVAbuAU=;
 b=l16hxQmz7Zzu9tEal1B7ecJKhCUQ5s4KdXXZBlc/UhRi1WbNQuQEfdZvaUhVmAqKZT
 I34N5xNlGPxfrVTJFiauGSyHmELJH3oKM9AapexfHFCVTkXxnbZ8vtEsMJb5vPQa/G3n
 botlnC8SiOx3wl/Jeq5MoRJ434IFxOwCYkLI9dbjYs1v/3nVkSPHhV2yLg5xFzOFoXJ6
 9CFf6jF3K/7b0nU4bzP4qKupFqfkTbPF/5weyzNwHfoUQMCxSJqHQYjYKjJuFogSr4BL
 SUHnSPD6BVA7sU6z7ovk2WF9neWzXTbmr+2FrqEqxV12rCt0f7DCz9oC3JwpuZK3X4eK
 yvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783093781; x=1783698581;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QBej8OCJOwyuOebhssR6JlgOD193q8iu0yJLVVAbuAU=;
 b=HaLeQRZto06eADReiJ8jSxozZA4gFVQYuXUTTTCSHJcQ3vVG5s2CULJaZ8PYZrqQLN
 3txODQs41RKnx7lLMrrUwz/03NdtkhqkSmI5uDL4Z5ozbo5xc0zPFUvrjHh6bVIoYq5x
 qJNV0himyghDjHk3vansXa97tUXa88r6yt/tUQbkqq2rxnP0aaBIn1A/qUZKRRZ/3eDI
 qa6YIHL3uVetvBBKi1uA2Jk3liySAVCLVHelIRVf2tV/gMB24K/KujvPAV0cbji6SPCe
 cNZL/g6pTh+OnDOSdWYaJGLKDpHwXpQDwc4oYmh2EluPH+Fy7oi7bqjRm4zodf/jJAUX
 2gwQ==
X-Gm-Message-State: AOJu0YwlgsgQmJjbfNkQSRPOnAkyeI57jAGJ6mPc9Hkc6P7GvOUyb7nQ
 j5jYJoH5qeQNJ+cmU+hR9iq4J/WQjkv1sNsrIFMARKZCrZbVsseaJxMj+j+t4sXi82qA+bYT4+Q
 IYpWd
X-Gm-Gg: AfdE7ckH/kAoRqVHVmYbvsSSLokjak7Xs8WlhevMB+LCZ7uvKr+YkYThyz2BLwNHxK2
 6xZLReykJZMIToO5Pk7n8i1eR63seXYKYF8vJG71g65GOY1a3elVsKKi2aXTA6l0ePOm/sE42jC
 jdP9D7cE4JlZO95itADdvB/D9Z0P73bYrd97/aMTZG0MOrvqRX26P5Ib86plrtqBdxxs7GUjGmP
 eZcfETnSn+0pjI3Cq8cVZL8lpKbhlt5o6Dg4qz0q3lCh7kJ4CDJuHOuVgOFLrrt6rwtTdnW+7gS
 MD4iYI57NfqJeqAypiFWdrx7K+fV8kQt4o4yE+sVcoEMNY/V5c/49O35+s7EX4Pe8CqnxcbqsaB
 c3gdWBGeQSBq6Umca++FeF6Nk+5ugfEpZlZdt64RgEOy+BV9hmrGjpk49uPn7bvczl2a6wdrd0C
 SEz+ug1KuwFqHBEZAX3tdfqemhAHFcEVLHewzrZdNkdCYhaOT4YeNIa3g4LEicBjBI
X-Received: by 2002:a17:90a:d40b:b0:381:e93b:f740 with SMTP id
 98e67ed59e1d1-38280d93ab1mr89235a91.15.1783093781510; 
 Fri, 03 Jul 2026 08:49:41 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f1cbfc285sm12849422eec.5.2026.07.03.08.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 08:49:41 -0700 (PDT)
Date: Fri, 3 Jul 2026 08:49:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>
Subject: Re: [PATCH] test/suites: clean up per-test directories
Message-ID: <20260703084939.0a1d0591@phoenix.local>
In-Reply-To: <20260703144216.43804-1-marat.khalili@huawei.com>
References: <20260703144216.43804-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 3 Jul 2026 15:42:16 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> After commit 5ef166838394 ("test: add file-prefix for all fast-tests on
> Linux") each test within a suite has its own --file-prefix filled with
> the test name to enable parallel execution. It brought a couple of
> drawbacks though:
> * Solution only applied to one test suite.
> * Each working directory occupied ~25MB, with hundreds of tests this
>   easily overfilled /run filesystems of small VMs. Currently executing
>   fast-tests suite consumes 2.8GB of RAM, and adding more tests created
>   problems for github CI.
> * While it enabled parallel execution of tests within a single build
>   directory, --file-prefix argument could no longer be specified
>   externally (caused duplicate argument error). Specifying custom
>   --file-prefix was necessary when multiple builds ran in the same
>   environment, so the corresponding workflow became broken.
>=20
> Move --file-prefix logic into a separate shell script, preserving
> existing argument and cleaning the work directory after the test.
> Apply it uniformly to all tests.
>=20
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

AI review run manually shows:



Error =E2=80=94 app/test/suites/meson.build, dump/debug-tests loop

The loop was changed to pass args : test_args, but test_args at that point =
is leftover state from the telemetry block above ([dpdk_test_as_arg] + test=
_no_huge_args + --vdev=3D... + '-a 0000:00:00.0') =E2=80=94 or, if RTE_LIB_=
TELEMETRY is disabled, whatever the last fast-test iteration happened to le=
ave in it. The debug tests previously ran with no extra args. Every other s=
imple loop correctly uses test_args_prefix; this one should as well.

On Linux the effect is worse than just wrong EAL args: test_args begins wit=
h dpdk_test_as_arg (the wrapper's own path), so meson invokes the wrapper w=
ith the wrapper path as its first argument. The wrapper then re-execs itsel=
f before finally running the real binary =E2=80=94 with --no-huge, the skel=
eton --vdev set, and -a 0000:00:00.0 that were only meant for telemetry_all.

Fix:

foreach arg : dump_test_names
    test(arg, dpdk_test,
                args : test_args_prefix,
                env : ['DPDK_TEST=3D' + arg],
                ...

On Windows test_args_prefix is [], which also restores the original no-args=
 behavior there.

Info =E2=80=94 uid check diverges from the algorithm it cites. eal_filesyst=
em.c keys the /var/run vs XDG_RUNTIME_DIR choice on getuid() (real uid); th=
e script tests $EUID (effective). These only differ under setuid / sudo-wit=
h-preserved-ruid, which won't happen in normal CI, but if the goal is to ma=
tch EAL exactly, use $UID (or id -ru).

Info =E2=80=94 mixed indentation in the wrapper: the two runtime_directory=
=3D... assignments inside the root check use tab-plus-spaces, while the res=
t of the script uses hard tabs.
