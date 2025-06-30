Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5065DC83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 14:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 118864065B;
	Mon, 30 Jun 2025 16:33:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id A8DB2402A5
 for <dev@dpdk.org>; Mon, 30 Jun 2025 16:33:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751294016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kpop0MGp5kopJNRdlugc4YWZQUH3yOCkudJoyHr4Okw=;
 b=KRYG8ljAFxBVZMTCriyEN5Jolf6Re5N/rQi+R8Uh99R1jHAjNnpwzM40EfD0yb0XhENf48
 hqQTj+85O5hAEhlVhOhdmWEG4EE2CnraPd2ocz4sv49/Md4nLpxTNo0Uwk6mNZluCh+c64
 as9XsrIBIYKfdYOanA3bFQibmiUa2fc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-suALQc-tOOiVFFR4eKYAmw-1; Mon, 30 Jun 2025 10:33:34 -0400
X-MC-Unique: suALQc-tOOiVFFR4eKYAmw-1
X-Mimecast-MFC-AGG-ID: suALQc-tOOiVFFR4eKYAmw_1751294013
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-553cd66fbd8so2409920e87.2
 for <dev@dpdk.org>; Mon, 30 Jun 2025 07:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751294013; x=1751898813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kpop0MGp5kopJNRdlugc4YWZQUH3yOCkudJoyHr4Okw=;
 b=R6r1oweiBpIfiwhmBy92kK/Q4v6QhEkFlZtr8oIPfa9cDD/kU/eR8wsHj3XKVEKNzr
 1VMojbDWhrxwIJykU/7l9KFPF8f6qQW6nr853k+dIx1w+sFhDKVyyIDKHDa+N/gYermp
 4awhEABeirheu1rhweiYj8B6QjLmXo2S73A033qdAdD6Oo0K2uMnNF/8DRVyGF4pUyq7
 +drpirIcZac9QobrIo1AzTnWdixGhBxQUj3WhjW+nK9nIDwW/x/ovosm3Po5YFAERLDe
 5NN4b5imY3f2HIBsv4b1TXV8FJTxouLUPD4eJfKyPUccwO5FEg2zz9P9GbSpNiBm6QD1
 87GA==
X-Gm-Message-State: AOJu0YxB4+poV0XVrBBQFmxto7eWd1t4ASit/xAHVSebdJl8EBDOK7kM
 nLpbggzDMojxd88ZObwFR2hIjfwN0/yDk2TiqMlVxIQfgEc2dSDU4lw8YVkCNUDi8jP8C6LqIVD
 GqtHmQG9vZnL7vVa07REX2SE6t2BSEx7xx4DGnpOmHQ2pFlAjWzohl6NWOL8uprPV0o7HnPr5xe
 EowQgYdqTb4mvwGSW9XVc=
X-Gm-Gg: ASbGncucmpVZpLCSnyRS/Rz60uc58WjgLpxmTHeYkhp+WlN4tZhv5QykRdKWikoeVuI
 jQXnRNJR6SPRArMVlbe+LphNWqtIAsTq9zQX3feewI85XWG2R5FwuOQGhkni4zOUwFtNhk0avVW
 JYgVHbwQ==
X-Received: by 2002:a05:6512:b1e:b0:553:d910:9344 with SMTP id
 2adb3069b0e04-5550ba2b25dmr4058176e87.45.1751294012491; 
 Mon, 30 Jun 2025 07:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET2uCp0/E3EoowqzlR+ZBJvZhU5STlSd1Rg1Eg17QrPdaz0Zn5xj9XzGUCRgVbv4OZo6aZduZ6/7AqfoL9Z3E=
X-Received: by 2002:a05:6512:b1e:b0:553:d910:9344 with SMTP id
 2adb3069b0e04-5550ba2b25dmr4058160e87.45.1751294011970; Mon, 30 Jun 2025
 07:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250624134139.552315-1-bruce.richardson@intel.com>
In-Reply-To: <20250624134139.552315-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 30 Jun 2025 16:33:20 +0200
X-Gm-Features: Ac12FXzPsg0skrZovSkXILZgxO9UeaP0tHRypiZW6Ox_gzQAY5mM_ILPoc_SO5E
Message-ID: <CAJFAV8wAKZTUikY4kxQW-kYqKa8KX1_PAVwVsR=9XQRL64ik2A@mail.gmail.com>
Subject: Re: [PATCH] eal: deprecate old coremask-based EAL parameters
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, techboard@dpdk.org, 
 Vipin Varghese <vipin.varghese@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HOpPqmI2Ifz-1muFkELRdnB3v_d2KR-EyODx9T-n460_1751294013
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

On Tue, Jun 24, 2025 at 3:41=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> As the number of cores/cpus on platforms has increased over the years,
> the use of coremasks rather than core-lists for identifying DPDK cores
> has become more and more unwieldy. At this point, let's deprecate the
> coremask-based EAL parameters for future removal, and point users to the
> core-list based versions instead.
>
> Depends-on: series-35540 ("use core lists not masks in documentation")
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Vipin Varghese <vipin.varghese@amd.com>
> ---
>  doc/guides/linux_gsg/build_sample_apps.rst |  7 +++----
>  doc/guides/linux_gsg/eal_args.include.rst  |  9 ---------

Please update FreeBSD docs too.


>  doc/guides/rel_notes/deprecation.rst       | 10 ++++++++++
>  lib/eal/common/eal_common_options.c        |  6 ++++++
>  lib/eal/include/rte_lcore.h                |  1 -
>  5 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linu=
x_gsg/build_sample_apps.rst
> index 8b8026705b..9ce564e881 100644
> --- a/doc/guides/linux_gsg/build_sample_apps.rst
> +++ b/doc/guides/linux_gsg/build_sample_apps.rst
> @@ -126,10 +126,9 @@ and that cores 0-3 are present and are to be used fo=
r running the application)::
>  Logical Core Use by Applications
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -The coremask (-c 0x0f) or corelist (-l 0-3) parameter is always mandator=
y for DPDK applications.
> -Each bit of the mask corresponds to the equivalent logical core number a=
s reported by Linux. The preferred corelist option is a cleaner method to d=
efine cores to be used.
> +The corelist (-l/--lcores 0-3) parameter is always mandatory for DPDK ap=
plications.

Not directly related to this patch, the -l/-c options are optional
since 2eba8d21f3c9 ("eal: restrict cores auto detection").


>  Since these logical core numbers, and their mapping to specific cores on=
 specific NUMA sockets, can vary from platform to platform,
> -it is recommended that the core layout for each platform be considered w=
hen choosing the coremask/corelist to use in each case.
> +it is recommended that the core layout for each platform be considered w=
hen choosing the corelist to use in each case.
>
>  On initialization of the EAL layer by a DPDK application, the logical co=
res to be used and their socket location are displayed.
>  This information can also be determined for all cores on the system by e=
xamining the ``/proc/cpuinfo`` file, for example, by running cat ``/proc/cp=
uinfo``.
> @@ -151,7 +150,7 @@ This can be useful when using other processors to und=
erstand the mapping of the
>
>  .. warning::
>
> -    The logical core layout can change between different board layouts a=
nd should be checked before selecting an application coremask/corelist.
> +    The logical core layout can change between different board layouts a=
nd should be checked before selecting an application corelist.
>
>  Hugepage Memory Use by Applications
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/doc/guides/linux_gsg/eal_args.include.rst b/doc/guides/linux=
_gsg/eal_args.include.rst
> index 6ee79877c1..b0cd757569 100644
> --- a/doc/guides/linux_gsg/eal_args.include.rst
> +++ b/doc/guides/linux_gsg/eal_args.include.rst
> @@ -4,10 +4,6 @@
>  Lcore-related options
>  ~~~~~~~~~~~~~~~~~~~~~
>
> -*   ``-c <core mask>``
> -
> -    Set the hexadecimal bitmask of the cores to run on.
> -
>  *   ``-l/--lcores <core list>``
>
>      List of cores to run on
> @@ -75,15 +71,10 @@ Lcore-related options
>
>      Core ID that is used as main.
>
> -*   ``-s <service core mask>``
> -
> -    Hexadecimal bitmask of cores to be used as service cores.
> -
>  *   ``-S <service core list>``
>
>      List of cores to be used as service cores.
>
> -
>  Device-related options
>  ~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/=
deprecation.rst
> index 36489f6e68..2ea898ff8a 100644
> --- a/doc/guides/rel_notes/deprecation.rst
> +++ b/doc/guides/rel_notes/deprecation.rst
> @@ -17,6 +17,16 @@ Other API and ABI deprecation notices are to be posted=
 below.
>  Deprecation Notices
>  -------------------
>
> +* EAL: The ``-c <coremask>`` commandline parameter is deprecated
> +  and will be removed in a future release.
> +  Use the ``-l <corelist>`` or ``--lcores=3D<corelist>`` parameters inst=
ead
> +  to specify the cores to be used when running a DPDK application.
> +

Prefix is usually lower case, so eal:.

> +* EAL: The ``-s <service-coremask>`` commandline parameter is deprecated
> +  and will be removed in a future release.
> +  Use the ``-S <service-corelist>`` parameter instead
> +  to specify the cores to be used for background services in DPDK.
> +
>  * build: The ``enable_kmods`` option is deprecated and will be removed i=
n a future release.
>    Setting/clearing the option has no impact on the build.
>    Instead, kernel modules will be always built for OS's where out-of-tre=
e kernel modules
> diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_com=
mon_options.c
> index 83b6fc7e89..f0a9ddeeb7 100644
> --- a/lib/eal/common/eal_common_options.c
> +++ b/lib/eal/common/eal_common_options.c
> @@ -616,6 +616,9 @@ eal_parse_service_coremask(const char *coremask)
>         int val;
>         uint32_t taken_lcore_count =3D 0;
>
> +       EAL_LOG(WARNING, "'-s <service-coremask>' is deprecated, and will=
 be removed in a future release.");
> +       EAL_LOG(WARNING, "\tUse '-S <service-corelist>' option instead.")=
;
> +
>         if (coremask =3D=3D NULL)
>                 return -1;
>         /* Remove all blank characters ahead and after .
> @@ -779,6 +782,9 @@ rte_eal_parse_coremask(const char *coremask, int *cor=
es)
>                 cores[idx] =3D -1;
>         idx =3D 0;
>
> +       EAL_LOG(WARNING, "'-c <coremask>' option is deprecated, and will =
be removed in a future release");
> +       EAL_LOG(WARNING, "\tUse '-l <corelist>' or '--lcores=3D<corelist>=
' option instead");
> +
>         /* Remove all blank characters ahead and after .
>          * Remove 0x/0X if exists.
>          */
> diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
> index 44959779a1..10f965b4f0 100644
> --- a/lib/eal/include/rte_lcore.h
> +++ b/lib/eal/include/rte_lcore.h
> @@ -102,7 +102,6 @@ unsigned int rte_lcore_count(void);
>   * When option -c or -l is given, the index corresponds
>   * to the order in the list.
>   * For example:
> - * -c 0x30, lcore 4 has index 0, and 5 has index 1.
>   * -l 22,18 lcore 22 has index 0, and 18 has index 1.
>   *
>   * @param lcore_id
> --
> 2.48.1
>

Otherwise this lgtm.


--=20
David Marchand

