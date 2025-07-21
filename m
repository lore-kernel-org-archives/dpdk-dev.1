Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC43C87FC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 08:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B19EA4021E;
	Mon, 21 Jul 2025 10:41:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id ABD9D4014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 10:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753087309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEc3zrU3Wr7eUVj8PWmohkt9pN8YTnvmH5N4nQev254=;
 b=NQAYJb54lwyZ/rG3dyDRBQmYoaJ4aZJ5TjGkKZtvZajSONDc0IkD667PjXaBroWsTICxYx
 /CBMkUiDyslt2gpQR82WRpJfjV1jvNxLTKPbR/7VlpfZOn86rPVxYWTpk/GgDZqHiwaZaN
 RADCwPFVLWhfReURDMBfD5P0Rh4hoog=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-2VHVxSXfMEOtp4-UGBDecA-1; Mon, 21 Jul 2025 04:41:47 -0400
X-MC-Unique: 2VHVxSXfMEOtp4-UGBDecA-1
X-Mimecast-MFC-AGG-ID: 2VHVxSXfMEOtp4-UGBDecA_1753087306
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-32b4a06b780so17332921fa.0
 for <dev@dpdk.org>; Mon, 21 Jul 2025 01:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753087306; x=1753692106;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEc3zrU3Wr7eUVj8PWmohkt9pN8YTnvmH5N4nQev254=;
 b=wo46zH75JJQ9ZlggzXyXdtacddTDDcfg+iHjCyMEiJkbtWnchR3EcjOC5GqGdsmsu/
 E0+zqfLXoWegL7F8nwFXS63sxB2Y/CvqDRuj5HcSikfnk9fTyaLwB0DQjhUFY+QTxTxt
 Cc02p+724tEGyBCjXw/n024L6SNDoxNlpYq35agczV03sWw1Ig5W00bJWCldJjfLhtWq
 HNn4DwNM6jOU4tAHBiSQqchCPTwWtNOUi+OEp7v0sqTtnb242fuXM72BWeQDlauZ4aIt
 heIy//QalEQfTpv5pUhkwN4VnMMMvNUB411/zYpzk9K6RdgVu3k0/fPkGrAiU0OexuSH
 SBuQ==
X-Gm-Message-State: AOJu0YwBPcRgg5qXf3AvrA2w8cRFZV66KST4ypTeR0C8KJ8uCgU6O6XC
 Fn2tcsCtL96fZ5XtDanmW4Y1j0kR2MLYRm6LhX0O6LT/nNbknJeh2JU8+bVdGxOZgTDNQijaMvy
 uWHMIWGh2EWntT0Qf/Riq2R/4TWs1dmYIrHQT07gOdbmRA9/ICWBCpOT9NApNIrxOPrvg87rFYc
 frlLcaoaYHWC6+026JB1w=
X-Gm-Gg: ASbGncvaZS8pcW1f12yuWW2FJCz3WBj5g/q1xjOe+hMF6yOXE7hnc+Omhf+A2W0qIUP
 CMIixeUUgS84QUcrvG+/bAQ2OJr3eHGvC0hX7c6DgQfpcAOZoZHgkiYmSluJyKnl7yafGoRQDvb
 18D4X1UoGtrckExokkZcRlNmo=
X-Received: by 2002:a05:651c:4181:b0:32c:a006:2a1d with SMTP id
 38308e7fff4ca-3308e1ce1bbmr44730571fa.4.1753087306105; 
 Mon, 21 Jul 2025 01:41:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSZjLCv0GX0TBUUW4cuyeQkDPTtU1KLrCTAsTv3+h9tH0Dnsm7Wx/bzX8aYxBRdF9WEXW1zwMWOUAL0lyiqRI=
X-Received: by 2002:a05:651c:4181:b0:32c:a006:2a1d with SMTP id
 38308e7fff4ca-3308e1ce1bbmr44730501fa.4.1753087305569; Mon, 21 Jul 2025
 01:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250718143356.1578988-1-bruce.richardson@intel.com>
 <20250718143356.1578988-6-bruce.richardson@intel.com>
In-Reply-To: <20250718143356.1578988-6-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 21 Jul 2025 10:41:33 +0200
X-Gm-Features: Ac12FXzp94rrdGnzU3qABJ5kfhrYUYwkGFe1vh8tqj6kPZDJTEbtF9CQFCy1Jck
Message-ID: <CAJFAV8y5_O3T6hLbZov0LqhXyAu2s_n0P3C3Y+WSGVUjd8gbtg@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] eal: define the EAL parameters in argparse format
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yeWoPvp6pMfdzPQUxddzKihA_41-Blj_2esPPo5r9-Y_1753087306
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

On Fri, Jul 18, 2025 at 4:34=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> +struct eal_init_args {
> +       /* define a struct member for each EAL option, member name is the=
 same as option name.
> +        * Parameters that take an argument e.g. -l, are char *,
> +        * parameters that take no options e.g. --no-huge, are bool.
> +        * parameters that can be given multiple times e.g. -a, are arg_l=
ists,
> +        * parameters that are optional e.g. --huge-unlink,
> +        *   are char * but are set to (void *)1 if the parameter is not =
given.
> +        * NOTE: List is to be kept alphabetically by option name
> +        */

We will have to be careful to keep this struct below, in sync with the
options list.
Could we construct (at build time) this structure via the options list?

The rules above would be enforced at the same time.

(macros + #ifdef for Linux/FreeBSD may be an issue for MSVC though...)

> +       struct arg_list allow;
> +       char *base_virtaddr;
> +       struct arg_list block;
> +       char *coremask;
> +       bool create_uio_dev;
> +       struct arg_list driver_path;
> +       char *file_prefix;
> +       char *force_max_simd_bitwidth;
> +       char *huge_dir;
> +       char *huge_unlink;   /* parameter optional */
> +       char *huge_worker_stack;  /* parameter optional */
> +       bool in_memory;
> +       char *iova_mode;
> +       char *lcores;
> +       bool legacy_mem;
> +       char *log_color;   /* parameter optional */
> +       char *log_level;
> +       char *log_timestamp;  /* parameter optional */
> +       char *main_lcore;
> +       bool match_allocations;
> +       char *mbuf_pool_ops_name;
> +       char *memory_channels;
> +       char *memory_ranks;
> +       char *memory_size;
> +       bool no_hpet;
> +       bool no_huge;
> +       bool no_pci;
> +       bool no_shconf;
> +       bool no_telemetry;
> +       char *numa_mem;
> +       char *numa_limit;
> +       char *proc_type;
> +       char *service_coremask;
> +       char *service_corelist;
> +       bool single_file_segments;
> +       char *syslog;   /* parameter optional */
> +       bool telemetry;
> +       char *trace;
> +       char *trace_bufsz;
> +       char *trace_dir;
> +       char *trace_mode;
> +       struct arg_list vdev;
> +       bool version;
> +       char *vfio_intr;
> +       char *vfio_vf_token;
> +       bool vmware_tsc_map;
> +};
> +struct eal_init_args args;
> +

[snip]

> +
> +struct rte_argparse eal_argparse  =3D {
> +       .prog_name =3D "",
> +       .usage =3D "<DPDK EAL options>",
> +       .epilog =3D "For more information on EAL options, see the DPDK do=
cumentation at: \n"
> +                       "\thttps://doc.dpdk.org/guides/" RTE_EXEC_ENV_NAM=
E "_gsg/",

Options don't change that often, but I would prefer we point at the
right release doc, rather than origin/main.

diff --git a/config/meson.build b/config/meson.build
index 40f33816aa..c3c054bae9 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -70,6 +70,7 @@ abi_version =3D run_command(find_program('cat',
'more'), abi_version_file,
 so_version =3D abi_version.split('.')[0]

 # extract all version information into the build configuration
+dpdk_conf.set('RTE_VER_MAJOR', major_version)
 dpdk_conf.set('RTE_VER_YEAR', pver.get(0).to_int())
 dpdk_conf.set('RTE_VER_MONTH', pver.get(1).to_int())
 if pver.get(2).contains('-rc')
diff --git a/lib/eal/common/eal_common_options.c
b/lib/eal/common/eal_common_options.c
index 787f759196..e11d76589f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -196,7 +196,11 @@ struct rte_argparse eal_argparse  =3D {
        .prog_name =3D "",
        .usage =3D "<DPDK EAL options>",
        .epilog =3D "For more information on EAL options, see the DPDK
documentation at: \n"
+#ifdef RTE_VER_RELEASE =3D=3D 99
+
"\thttps://doc.dpdk.org/guides-"RTE_STR(RTE_VER_MAJOR)"/"
RTE_EXEC_ENV_NAME "_gsg/",
+#else
                        "\thttps://doc.dpdk.org/guides/"
RTE_EXEC_ENV_NAME "_gsg/",
+#endif
        .exit_on_error =3D true,
        .callback =3D arg_list_callback,
        .print_help =3D eal_usage,


--=20
David Marchand

