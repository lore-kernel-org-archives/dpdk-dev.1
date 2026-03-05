Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CF2F47CA9
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 18:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8836402CC;
	Thu,  5 Mar 2026 19:11:35 +0100 (CET)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48]) by mails.dpdk.org (Postfix) with ESMTP id 6EF474029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 19:11:34 +0100 (CET)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-5fded42aa7cso5692955137.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 10:11:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772734294; cv=none;
 d=google.com; s=arc-20240605;
 b=huf87HrCjPJaKCyNCooAREYZsx4tEo6IeDZqOHEGMrE1uyP4V0rb2e7U/CpWdQD5hp
 CLe7sVBLMbaxTcvtE7xe2qYlrib18JEblid4w/BJTftsy3fu7CuheaPPyXcEfnGenqXZ
 wNjKRN3894dy0oMbh23yg4ZlQEOkU/ngiAfYLT9Crq2dCOCNnSkjfP4iO83dJp0y1jZf
 UnClknz3GNHL1j/1DRJxzonruqK6TbJxjHFBIxL3/PF6LIUflXRFd6tx8seG9WBub5kG
 lAEhQUvVwtrOQow0saKAYTe2ffR2Q7O2lFRR3LolcVue1WDMhwB4Tv5IupyrzR1F7sFX
 uUcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=73712NigVqKgwO9tuzSW26oPPHBPdBlXoebMttRdx6o=;
 fh=pE4KXaU+3fn80qsPh4r+h/XTHIt3brqajewJLCEb3rM=;
 b=hTAD9ZlV1WF79RelN2g5R8LBLx7G5TyCCIGJNIM/VLEYrwPtx7mYTHOaORyLT9+KZx
 g686CrdTZmDKgT6xGGhkasOs/mszKecv7YJ1fi9+bXGOobkxV5HkKe/oVdtxVeP+BUrV
 56COQNJP5/vQkAFQJ+E+A06CofaQLh53enNfXAqldcXNeo/YioSkWCpDpuh39EOzdKhc
 /K6jjtmoiCy/XcCoSGyFBIQf3ghuvY7UrbzWARW4VjgXAc0zGwuDJ4+Dl2KgS5oPxBbP
 inJP1UTi8pBoTWZhR2lmd4TsTd7qnHGGuXIhjhBgSgu94XhQE7MTzKwi/ik1f6MNQFPG
 7wyQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772734294; x=1773339094; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73712NigVqKgwO9tuzSW26oPPHBPdBlXoebMttRdx6o=;
 b=Dpno4uRcp1Hs2SKi86UsYEWExvP/v/VDusRmz4PT4v8aaOl9uLSdb51YgN8vZW83vU
 N/wBgzgMBK8TUW72Tmo+jURA5Js0o6TkEXCuAKk8jsQbSFAeBqoXhu77qLyqiJHY3giA
 NpHYraHKCuyXZYbgbFT1wsLDzNV4NOZnsLROc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772734294; x=1773339094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=73712NigVqKgwO9tuzSW26oPPHBPdBlXoebMttRdx6o=;
 b=seDU4nhl+cL3YXiFFzrxy0H50KjPznIW5t6omXVGKD2A3X2e1g8sjw1Ugzo5us0rqn
 7AaYl/GCEV8gtm0DzkIwfpbpODsWg2+mp1j4wO7Fzv3zfze8bnsxt7B1bRjrs/wNTmfy
 oySGj+ggTNeJffR0c87HzefHXRm1Q+9KIeleL/LK9aBJ59pwqzJTZ9EX8jXEGm69YmPy
 3lw4n5h1hG7CiJYI31YfXyVBNwt8b1REm2A6EL3wez4V0Nmn52T9ZVpsDl9AQbi0Dp6L
 6dswTKtJPBm+49HcyaubgNMkVQjYZl93U0o4gf8/CFk2uJ7b6dVix3QUj0ukGh6CBSfH
 nQXg==
X-Gm-Message-State: AOJu0Yx8IBIv34xm37urUtgTMX+CmvxAneiwVa9HeojydDotbKgNwmQg
 of1EDsuMfg9yetzp9RwBZZaRhvM7TjQdaDchph7aK/FsohLCcTprqCRONQ60ua48a6z9sAhdH9F
 M8x49tZncpKivc3aG+D0wdSFqMdUqySBlWbBteL4Aig==
X-Gm-Gg: ATEYQzy5pNVhi1UI02FfM3yrTDV+5fIoMC4f+PP6784mIc5LvZHBIUFqd9w0nY0s7YL
 Vevr0WXUmiWlViruE2IyxJPO9O1BSLAPtyZKShTqZCxTyLCbjGQpM5b090yD4zZRIFnmQGPX5E0
 JdUYnI6wq8EALwy56QAS4P4kpMYkUaREReWJCAAZH9wbK74pohb5JtSBU+Ebld6IhCQYHaIStJl
 eSEjztGmLNEezrhHiMcHsITwxGh8fzqfMO29VNQIXoEGQvYe/qLfYVyNq8wuEQajFXQAUsI8l4X
 4WjyyPxYIQYdQECLhj/BwLCGDEv+DsOUHKzdCeQwoR6qhPXcYbwTkBX7xIhZBJpKqyMrzMTN
X-Received: by 2002:a05:6102:6cb:b0:5db:23d0:65e7 with SMTP id
 ada2fe7eead31-5ffaaf66738mr2924211137.27.1772734293619; Thu, 05 Mar 2026
 10:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20260226204322.87944-1-abailey@iol.unh.edu>
In-Reply-To: <20260226204322.87944-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 5 Mar 2026 13:08:36 -0500
X-Gm-Features: AaiRm53UTGrG1GQhjqepvGjojlggSp7dK5UCNNd8N55Xqhobz7M_yM5yntaFjNg
Message-ID: <CAJvnSUCBpO5jm64Bs3epkc3rwj8bPhgRQCzPt5g4+YLQagk+JA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: update yaml configs
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu
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

On Thu, Feb 26, 2026 at 3:43=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
>
> +# Optional Fields:
> +#   `dpdk_tree` & `tarball`:
> +#       Either `dpdk_tree` or `tarball` can be defined, but not both.

I know it seems obvious but can you add 1 line which explains
dpdk_tree is if your dpdk source is an uncompressed dir, tarball is
for a compressed DPDK?

> +#   `remote`:
> +#       Defaults to false. If it's true, the `dpdk_tree` or `tarball`
> +#       is located on the SUT node, instead of the execution host.

No need to mention defaults (there is actually no default in this case
i.e. when if a value is not set x happens. This field must be set so
there isn't really a "default"). Just say If false, the `dpdk_tree` or
`tarball` is located on the DTS execution host. If true, the
`dpdk_tree` or `tarball` is located on the SUT node.

> +#   `precompiled_build_dir` & `build_options`:
> +#       If `precompiled_build_dir` is defined, DPDK has been pre-built
> +#       and the build directory is in a subdirectory of DPDK tree root d=
irectory.
> +#       Otherwise, will be using the `build_options` to build the DPDK f=
rom source. Either
> +#       `precompiled_build_dir` or `build_options` can be defined, but n=
ot both.
> +#   `compiler_wrapper`:
> +#       Optional, adds a compiler wrapper if present.
> +#   `func_traffic_generator` & `perf_traffic_generator`:
> +#       Define `func_traffic_generator` when `func` set to true.
> +#       Define `perf_traffic_generator` when `perf` set to true.
> +#   `skip_smoke_tests`:
> +#       Defaults to true. If it's false, smoke tests will run.
> +#   `test_suites`:
> +#       By removing the `test_suites` field, this test run will run ever=
y test suite available.
> +#   `vdevs`:
> +#       Uncomment to use virtual devices in execution.

Uncomment to add a specific virtual device to run on the SUT node.

> +
>  # Define the test run environment
>  dpdk:
>    lcores: "" # use all available logical cores (Skips first core)
>    memory_channels: 4 # tells DPDK to use 4 memory channels
>    build:
>      dpdk_location:
> -      # dpdk_tree: Commented out because `tarball` is defined.
> +      # dpdk_tree: see `Optional Fields`
>        tarball: dpdk-tarball.tar.xz
> -      # Either `dpdk_tree` or `tarball` can be defined, but not both.
> -      remote: false # Optional, defaults to false. If it's true, the `dp=
dk_tree` or `tarball`
> -                    # is located on the SUT node, instead of the executi=
on host.
> -
> -    # precompiled_build_dir: Commented out because `build_options` is de=
fined.
> +      remote: false # see `Optional Fields`
> +    # precompiled_build_dir: see `Optional Fields`
>      build_options:
>        # the combination of the following two makes CC=3D"ccache gcc"
>        compiler: gcc
> -      compiler_wrapper: ccache # Optional.
> -    # If `precompiled_build_dir` is defined, DPDK has been pre-built and=
 the build directory is
> -    # in a subdirectory of DPDK tree root directory. Otherwise, will be =
using the `build_options`
> -    # to build the DPDK from source. Either `precompiled_build_dir` or `=
build_options` can be
> -    # defined, but not both.
> +      compiler_wrapper: ccache # see `Optional Fields`
>  func_traffic_generator:
>    type: SCAPY
>  # perf_traffic_generator:
> @@ -32,12 +48,11 @@ func_traffic_generator:
>  perf: false # disable performance testing
>  func: true # enable functional testing
>  use_virtual_functions: false # use virtual functions (VFs) instead of ph=
ysical functions
> -skip_smoke_tests: true # optional
> -# by removing the `test_suites` field, this test run will run every test=
 suite available
> -test_suites: # the following test suites will be run in their entirety
> +skip_smoke_tests: true # see `Optional Fields`
> +test_suites: # see `Optional Fields`; the following test suites will be =
run in their entirety
>    - hello_world
> -vdevs: # optional; if removed, vdevs won't be used in the execution
> -  - "crypto_openssl"
> +# vdevs: # see `Optional Fields`
> +#   - "crypto_openssl"
>  # The machine running the DPDK test executable
>  system_under_test_node: "SUT 1"
>  # Traffic generator node to use for this execution environment
> diff --git a/dts/configurations/tests_config.example.yaml b/dts/configura=
tions/tests_config.example.yaml
> index 64fa630aa0..451fc8827d 100644
> --- a/dts/configurations/tests_config.example.yaml
> +++ b/dts/configurations/tests_config.example.yaml
> @@ -1,5 +1,8 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>
> +# Optional Fields:
> +#   All fields are optional, uncomment a test suite to run it with a spe=
cific configuration.
> +

Can you add a commented out section for any other suites which can
take in optional params i.e. the RSS testsuite does but I don't think
it's included in tests_config.example.yaml

>  # Define the custom test suite configurations
>  hello_world:
>    msg: A custom hello world to you!
> --
> 2.50.1
>

Thanks.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
