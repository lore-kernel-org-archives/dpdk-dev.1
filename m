Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5241D1098787
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 14:03:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 741E940650;
	Fri, 20 Mar 2026 15:03:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A6BA440430
 for <dev@dpdk.org>; Fri, 20 Mar 2026 15:03:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774015392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBYcAtSf7GHQlm6urSsqwz4fZmewvL6QMtEcBu6FPuY=;
 b=fd9jm8QhBdG57fddPA3WxKnzzB9580mMudZoCJSkR4zPDl4loXw7ID3sLhYppd0VerU5dM
 wK3O0Ds1Qy7f9xtzjlvC2GQNrzH4nE5LB9HnigBayp79wnGXFG/swW8khhYSt5a2CB98o9
 XaSPWFQAG17W5+G4VkNHTv9zDExyJOY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-jP1l8B0gMZCab9_Hu7BbkA-1; Fri, 20 Mar 2026 10:03:10 -0400
X-MC-Unique: jP1l8B0gMZCab9_Hu7BbkA-1
X-Mimecast-MFC-AGG-ID: jP1l8B0gMZCab9_Hu7BbkA_1774015389
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a2832515f6so431910e87.0
 for <dev@dpdk.org>; Fri, 20 Mar 2026 07:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774015389; x=1774620189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBYcAtSf7GHQlm6urSsqwz4fZmewvL6QMtEcBu6FPuY=;
 b=FDYM2hp4QCD4W+bRMIIC+MPwWtYODKcNCKKkep1CLWy8eJlihCp7droaYtlN89sWqH
 3sSB39qeYkteY4VtiOjdBKHvQJDWBZoGVVJzXIk/z9dlHJTdeIBgHdrTMu1nk3CvgvPK
 Mn5x4pavZPqlUfHNzVCkOJa61a7wQStPJ9Ns7B5VrpowKofo3pmlyeYFlhAZ7rqVlzRw
 8SbkMDwHYAU0S5QM2bWhxaluMAa3IdOar/WcAjmpPwz1DPQhWgzqT7Zj+nlplZveZ0SH
 6Jljn1VGyd93ZpkLd+awALvjghiF4XOWp2rBTtRVE0jjPdeDm2oj3W1d49+XJklRYcDE
 8+kA==
X-Gm-Message-State: AOJu0YwsIw3ktG5x+yfeiHUHtLEdBy0TMFc2w/PVGWhzDThEZ7PZs5wV
 Mebz02WXqb64zCvAuhO28yO7liu70M3QPHu6NrH1WYL+gG4/zcdQ2clnZwikWJYqg4AhxsynFJj
 h5XbHjiodbBPg7POTejSyfWMsZHP1YgvNkGl21gf39TE0fCVGxyjNB2F2tcMl6RyLlJaaEpyWZI
 f2ugAsB8VOC4Nrpe4lLYk=
X-Gm-Gg: ATEYQzygtGY0N9pjFad4XG6v+HVfQ1vVnrX7irqOU267NvuQbosZTAqv2fgbtPDlEvb
 tlyFiCOR67cZyyyUYL42aizoEZXBNsuc8za+edgTx4G++c+5rDeP2xZ0zlwDLtgbZzc9QE5VUzt
 jRGUzvH+i6Vijgy+QnwVPnrA35NFsPPzedcojmLeloiFKKen46GUg1xEJ1QOic2za7vQKMchT8A
 z228Y+ip6FyWA3tv8Q/temZRtBO1bZAt0IvXUF8rvQ+1QwI97SJLRDJ04NbbSkVw8cNig==
X-Received: by 2002:a05:6512:2384:b0:5a1:3e55:8990 with SMTP id
 2adb3069b0e04-5a285af8d62mr1019318e87.15.1774015388419; 
 Fri, 20 Mar 2026 07:03:08 -0700 (PDT)
X-Received: by 2002:a05:6512:2384:b0:5a1:3e55:8990 with SMTP id
 2adb3069b0e04-5a285af8d62mr1019275e87.15.1774015386457; Fri, 20 Mar 2026
 07:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260319171334.1151425-8-bruce.richardson@intel.com>
In-Reply-To: <20260319171334.1151425-8-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 20 Mar 2026 15:02:54 +0100
X-Gm-Features: AaiRm52lSrAmbDl0E5RYHJXnzBYLdwsksimSP9OII35EUtio0poDzDEIAT1JBT4
Message-ID: <CAJFAV8ztqM2i3QTWQV7E_fo=N3DRJpvxUBvT3ykJtXyRwQ+bEA@mail.gmail.com>
Subject: Re: [PATCH 7/7] test/debug: fix unit test on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, lylavoie@iol.unh.edu, probb@iol.unh.edu, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q8hkosvruxM-Sg8trqEvOuOW72RKNwv7gmKlSg-W42E_1774015389
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 19 Mar 2026 at 18:14, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Fix the test_debug unit test on FreeBSD by:
> * passing no-telemetry to the additional process calls
> * ensuring that we always use the no-huge and no-shconf params
> * removing the dependency on procfs to get the exe and using argv[0]
>   instead
>
> Bugzilla ID: 761 (partial fix)
> Fixes: 764bf26873b9 ("add FreeBSD support")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  app/test/process.h    | 11 ++++++++---
>  app/test/test_debug.c |  6 +++---
>  2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/app/test/process.h b/app/test/process.h
> index df43966a2a..46b69ce330 100644
> --- a/app/test/process.h
> +++ b/app/test/process.h
> @@ -96,7 +96,7 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
>         int driver_path_num;
>         int argv_num;
>         int i, status;
> -       char path[32];
> +       char *path;
>  #ifdef RTE_LIB_PDUMP
>  #ifdef RTE_NET_RING
>         rte_thread_t thread;
> @@ -188,8 +188,13 @@ process_dup(const char *const argv[], int numargs, const char *env_value)
>                 /* set the environment variable */
>                 if (setenv(RECURSIVE_ENV_VAR, env_value, 1) != 0)
>                         rte_panic("Cannot export environment variable\n");
> -
> -               strlcpy(path, "/proc/" self "/" exe, sizeof(path));
> +#ifdef RTE_EXEC_ENV_LINUX
> +               char path_buf[32];
> +               strlcpy(path_buf, "/proc/" self "/" exe, sizeof(path_buf));
> +               path = path_buf;
> +#else
> +               path = argv_cpy[0];
> +#endif

You can remove the self and exe macros that makes no sense anymore
(the only left users are Linux only).


>                 if (execv(path, argv_cpy) < 0) {

IIRC, all callers pass an array with args[0] == prgname == original
argv[0] from main.

To convince myself, I ran unit tests in GHA with a dumb change:
diff --git a/app/test/process.h b/app/test/process.h
index df43966a2a..c9205992d2 100644
--- a/app/test/process.h
+++ b/app/test/process.h
@@ -104,6 +104,9 @@ process_dup(const char *const argv[], int numargs,
const char *env_value)
 #endif
 #endif

+       if (argv[0] != prgname)
+               return -1;
+
        pid_t pid = fork();
        if (pid < 0)
                return -1;

So it seems that we can remove this whole exe path discovery and just
pass argv_cpy[0].


>                         if (errno == ENOENT) {
>                                 printf("Could not find '%s', is procfs mounted?\n",

Mention of procfs makes no sense for FreeBSD.


> diff --git a/app/test/test_debug.c b/app/test/test_debug.c
> index bfda4d1aa3..eda9c3e0e1 100644
> --- a/app/test/test_debug.c
> +++ b/app/test/test_debug.c
> @@ -154,15 +154,15 @@ test_debug(void)
>         test_args[2] = "-l";
>         test_args[3] = core;
>
> -       if (rte_eal_has_hugepages()) {
> +       if (rte_eal_has_hugepages() && RTE_EXEC_ENV_IS_LINUX) {

I miss the reason.
Why can't we run with hugepages on FreeBSD?


>                 test_args[4] = "";
>                 test_args[5] = "";
>                 test_args[6] = "";
>                 test_args[7] = "";
>         } else {
>                 test_args[4] = "--no-huge";
> -               test_args[5] = "-m";
> -               test_args[6] = "2048";
> +               test_args[5] = "-m2048";
> +               test_args[6] = "--no-telemetry";
>  #ifdef RTE_ARCH_PPC_64
>                 /* iova=pa is the default, but fails on ppc64 with --no-huge */
>                 test_args[7] = "--iova-mode=va";
> --
> 2.51.0
>


-- 
David Marchand

