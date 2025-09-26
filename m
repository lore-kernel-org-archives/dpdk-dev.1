Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9F2CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 08:14:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 786D540262;
	Fri, 26 Sep 2025 10:14:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 183AA4025D
 for <dev@dpdk.org>; Fri, 26 Sep 2025 10:14:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758874487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmG5IUsIFQiusBS8mDVPbOTwD9lWwH45lUOqRXDuplU=;
 b=IKMjOeymwWmf3a3uwoXwoApZZ/Dq+Isu+BalySp5+qV5DYIz7cxmLY5GF60nUs465KHWYA
 MqkPx35GkHDLCMnr0T48EiCJmMZBt2o3Ee17aWVX7vHolBOQetdPwICafOB6ksmYufDce4
 kY0qFfZWMp5H4YEaLAQMl5XM/tqrC3I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-ehqh2DfTP-ypdGGkGZXUzw-1; Fri, 26 Sep 2025 04:14:45 -0400
X-MC-Unique: ehqh2DfTP-ypdGGkGZXUzw-1
X-Mimecast-MFC-AGG-ID: ehqh2DfTP-ypdGGkGZXUzw_1758874484
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-57b9c463726so1044951e87.1
 for <dev@dpdk.org>; Fri, 26 Sep 2025 01:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758874484; x=1759479284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kmG5IUsIFQiusBS8mDVPbOTwD9lWwH45lUOqRXDuplU=;
 b=btebeC528oAEghSE90mPrlpWw7AG6wPibzvKNqVrG2iJakcHgV0VIzytm9JUXvxV/D
 60z8ORGy2KqIwE692BIBdrkojuRGOYI6syM7ZS1+LZM9nOtK45u2XeLKtNzLUC1zhBDM
 umoWyhUUjyv6ZAwrIntnTlvQefSf77cW4jk/2b+fJdR+3EdfggpU8rZZgUCBLMmPxHAU
 AiQc0y0pUjY0fe6oRadSNw19ZmSJFoqTeuOlkIKg0dlpx/TLJycLwHf87v8vRpWM21UD
 M5ZWc2qZjvLPyzhu3g2lODPliZ+qrSx5Jg8ecSAwMDypNB8tTYKfPUDCPFTf7Epttqtb
 KBKQ==
X-Gm-Message-State: AOJu0YzPZM+h6lRIjjmYll1xdPtPjQrl8VyyTWLizCQphZ5Dypk98Hb7
 ByPfElisBExtAzvslE6+Yiwk2ta4GAFQIAG4HYkX6szl5jY55BSHUEZ4Y1tSPXFhDqiOr3AXCKP
 4XdXHLiMMRUUyFkDo1GbM7XflYJ+kTqakFqyO+0W/1rU8+VUfmo7WW5AYn64Q6Xf09w6LoRAJCp
 MEspuB+PX7sgp+GKMY1QY=
X-Gm-Gg: ASbGncvMk6K5BbSLTpQ9l+shX26dMDOnpxtUNXOZF/yfGU8KskS5En1afb4I0a6tk6T
 4UoTmFY+JP7P8lUiBUurG39pYFACq7f+RoF9EqVs0kbXqC3SRuFNXpAgNbW2ts0fnB8x1Bc1wd5
 er+qXD2Dhu6IgpVVKjGvyd1xU=
X-Received: by 2002:a05:6512:400c:b0:581:f381:4ebe with SMTP id
 2adb3069b0e04-582d2299168mr1951719e87.22.1758874483947; 
 Fri, 26 Sep 2025 01:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGErXUOIOYcIDD8DNVzfReBE8tZptg0voRC07+fyaeo1JdJ96NssmtRVz43v7HW+wTYxZtnXUp2UUkzLXZTERk=
X-Received: by 2002:a05:6512:400c:b0:581:f381:4ebe with SMTP id
 2adb3069b0e04-582d2299168mr1951709e87.22.1758874483395; Fri, 26 Sep 2025
 01:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
 <20250925123150.3063298-7-david.marchand@redhat.com>
 <aNVV3PwL39sY-W80@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNVV3PwL39sY-W80@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 26 Sep 2025 10:14:31 +0200
X-Gm-Features: AS18NWDESMBi6lVZiKXUEpQgPaXl9Y3Vn_BgqRHKGuYhKrNNId8eBb3rvhH5LyE
Message-ID: <CAJFAV8zjD5M7DDapTZfjCzusm-w5ufBJq+0C3wkFeKt5o79rGQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] buildtools/chkincs: use a staging directory for
 headers
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j4VEYHJW8UC2OVZGpLMPgeRHZTFDC7ZgaG5m_OwA570_1758874484
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

On Thu, 25 Sept 2025 at 16:47, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > diff --git a/buildtools/chkincs/meson.build b/buildtools/chkincs/meson.build
> > index 49dbc55254..376556f5f4 100644
> > --- a/buildtools/chkincs/meson.build
> > +++ b/buildtools/chkincs/meson.build
> > @@ -12,38 +12,47 @@ gen_c_files = generator(gen_c_file_for_header,
> >          arguments: ['@INPUT@', '@OUTPUT@'])
> >
> >  cflags = machine_args
> > +cflags += '-Wno-missing-field-initializers'
> >  cflags += no_wvla_cflag
> > +cflags += '-I' + dpdk_source_root + '/config'
> > +cflags += '-I' + dpdk_build_root
> > +cflags += '-I' + dpdk_chkinc_staging_dir
> >
>
> Two minor suggestions, 1) should we not use "include_directories()" here to
> pass these properly? and 2) would using the existing "global_inc" value as
> include path not work ok? Is the reason for not using the latter the fact
> it includes too many source dirs?

1) include_directories() requires a source directory to exist, so I
would need to keep almost empty directories with minimal meson.build
in them.

2) Indeed, global_inc is not usable as is.

meson.build:global_inc = [include_directories('.', 'config',
meson.build-    'lib/eal/include',
meson.build-    'lib/eal/@0@/include'.format(host_machine.system()),
meson.build-    'lib/eal/@0@/include'.format(arch_subdir),
meson.build-)]

global_inc refers to the EAL sources, so anything in those directories
is reachable.
There are a number of non exported headers in there, like
lib/eal/include/rte_eal_paging.h or Windows specific/internal headers
in lib/eal/windows/include.

I can split it as two variables.

>
> >  sources = files('main.c')
> >  sources += gen_c_files.process(dpdk_chkinc_headers)
> >
> > -# some driver SDK headers depend on these two buses, which are mandatory in build
> > -# so we always include them in deps list
> > -deps = [get_variable('shared_rte_bus_vdev'), get_variable('shared_rte_bus_pci')]
> > -if dpdk_conf.has('RTE_BUS_VMBUS')
> > -    deps += get_variable('shared_rte_bus_vmbus')
> > -endif

[snip]

> > diff --git a/drivers/meson.build b/drivers/meson.build
> > index f25f425565..dae1e83ca4 100644
> > --- a/drivers/meson.build
> > +++ b/drivers/meson.build
> > @@ -245,7 +245,31 @@ foreach subpath:subdirs
> >          if get_option('enable_driver_sdk')
> >              install_headers(driver_sdk_headers)
> >          endif
> > -        dpdk_chkinc_headers += driver_sdk_headers
> > +        dpdk_chkinc_headers += headers
> > +        dpdk_chkinc_drivers_headers += driver_sdk_headers
> > +
> > +        if get_option('check_includes')
> > +            if headers.length() > 0
> > +                dpdk_chkinc_staging_deps += declare_dependency(sources:
> > +                        custom_target(lib_name + '_header_staging',
> > +                                output: lib_name + '_header_staging.stamp',
> > +                                command: [stage_headers_cmd, dpdk_chkinc_staging_dir, '@OUTPUT@',
> > +                                    headers],
> > +                                install: false,
> > +                        )
> > +                )
>
> Rather than using an external script and custom target for this, would the
> configure_file() meson function, with "copy" set to true also work for us?
> https://mesonbuild.com/Reference-manual_functions.html#configure_file

I don't like configure_file().
Touching any of those headers will trigger a meson reconfigure, right?
I think I am not the only one who dislike meson reconfigurations that
pollutes your terminal a lot when you do many compilations (Thomas?).

But let's say this is acceptable.

I had tried but configure_file() won't accept outputting to a specific
directory, or I am doing it wrong?
Trying again as an example in lib/meson.build:
        foreach header: headers + indirect_headers
            configure_file(input: header,
                output: 'staging/@BASENAME@.h',
                copy: true,
                install: false,
            )
        endforeach

Gives:
../lib/meson.build:221:12: ERROR: configure_file keyword argument
"output" Output 'staging/@BASENAME@.h' must not contain a path
segment.


Relooking *again* at all this (la nuit porte conseil), if we tracked
headers in global variables, for "normal" headers, arch headers,
generic headers and drivers headers, all of the changes could be
isolated in the buildtools/chkincs directory.
This would also make it possible to factorize install_headers() calls,
and avoid drivers doing it behind drivers/meson.build back (I spotted
one).

I just pushed an experiment:
- single headers install:
https://github.com/david-marchand/dpdk/commit/headers_rework~2
- chkincs rework (still not using configure_file):
https://github.com/david-marchand/dpdk/commit/headers_rework~1

WDYT?

>
> > +            endif
> > +            if driver_sdk_headers.length() > 0
> > +                dpdk_chkinc_drivers_staging_deps += declare_dependency(sources:
> > +                        custom_target(lib_name + '_driver_header_staging',
> > +                                output: lib_name + '_driver_header_staging.stamp',
> > +                                command: [stage_headers_cmd, dpdk_chkinc_drivers_staging_dir,
> > +                                    '@OUTPUT@', driver_sdk_headers],
> > +                                install: false,
> > +                        )
> > +                )
> > +            endif
> > +        endif
> >
> >          if headers.length() > 0
> >              dpdk_includes += include_directories(drv_path)



-- 
David Marchand

