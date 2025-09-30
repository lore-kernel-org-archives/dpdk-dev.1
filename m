Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F0CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 13:16:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6984C402E1;
	Tue, 30 Sep 2025 15:16:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id AADB84025F
 for <dev@dpdk.org>; Tue, 30 Sep 2025 15:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759238193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BPYI5tjafIotMslU89fRe11NN6YqnvisakR00Wfw5A8=;
 b=IB1RQNo82OQYKgwE7We++HZLzBrxoHObL/6nsJlCxiOl3NzQl4HgmhbMoW0QFBKXzT3+NO
 6QZEN3j2PMmlxsKUklSgEeuV+s5gARDYF89ahLXv9B3T71ULCnHeTVdoP85aEBA2jhk1JY
 R8MW9DR5ncLItGqHoPkLZNU2R96ZQkc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-LnVJi4obPBCQGH6kOaGNmQ-1; Tue, 30 Sep 2025 09:16:31 -0400
X-MC-Unique: LnVJi4obPBCQGH6kOaGNmQ-1
X-Mimecast-MFC-AGG-ID: LnVJi4obPBCQGH6kOaGNmQ_1759238190
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-336a6070642so24893261fa.0
 for <dev@dpdk.org>; Tue, 30 Sep 2025 06:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759238190; x=1759842990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BPYI5tjafIotMslU89fRe11NN6YqnvisakR00Wfw5A8=;
 b=qkIgSMSOniRQCisbfr8Z/beZhyajBe1fUsGFdVE6zRnrU5loeCEAwcSY6Lbi60xTju
 vU5Pold6RunwHBseCW7sZKRPOXutoUeEP5/KMnQnH/CtjLQQoMLQKFY7GqSdmg0nH4rh
 iuEWrqZp8wyuuEOJ+oYll9yiypBf0DBAb2VM0RzDg+d6SKAZyLBl8U6jknleCZ779GSa
 paIz0xPID+HrfyerKRtnkB1gVryeKtadnTY7W6UNMgCT3ggVHwpACdneREXJ6fGudnG3
 51b+HfCBU+ndKS4PLGFrE4gXndTjUwH3gYXuuBA8vxSCznOGt8dEPKJTYextUOyVt5T+
 WxIA==
X-Gm-Message-State: AOJu0YzuhhuEf0R1fjWRYlG8QT5lEDrONCK4eyj3QBg8M7ZO8CiA9BFs
 RphL/vPtgXc3y3I+ZXBdY8r7MSjYeWkIIW6+coPk41lilZUpTXzTBrSWoV9zblJT7IyqllG5CUv
 f2Bk3epJ908e9WY7EGyhblb7TjW/MOBWcs1cm2QnuXzAg3e1sgg/dIlo2dx9Ql/EskaCjMA1IWB
 zIflrNj2Sk/hnpmtgrQMA=
X-Gm-Gg: ASbGncuXSdCQ+fKyUtWzokEOd0ubJukBU/TbqD26vBYrpSx8sdyAttCRaiCggR+5TmE
 E65OfOMxvEBT4C/0Ghm/uVsB8E5Fpz3lqo17JWdNdihoJlw1TfWAgCkZ9PQ9z+Y3Pb4zjL+BMNV
 RWUBvGSFZhHYmr3Ry4jRXu1FVzVVQ4
X-Received: by 2002:a05:6512:e98:b0:57d:d62e:b1fa with SMTP id
 2adb3069b0e04-582d3e8287fmr5341619e87.40.1759238189824; 
 Tue, 30 Sep 2025 06:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/Wf7JxA6Zk0gMdOadqi18TEYd8OJusCh0nFm5+KzqmVkFMRN8N3Rrr9Q7OgXKHS6RFNoQcPvx+gdz/iaxW8=
X-Received: by 2002:a05:6512:e98:b0:57d:d62e:b1fa with SMTP id
 2adb3069b0e04-582d3e8287fmr5341614e87.40.1759238189385; Tue, 30 Sep 2025
 06:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-7-bruce.richardson@intel.com>
 <CAJFAV8ymGTU2tDzQoy-jk-bN6uigV1f2oh0TAwiHBzsc8nZNbg@mail.gmail.com>
 <aNvT8bb7nLUEpzWM@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aNvT8bb7nLUEpzWM@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 30 Sep 2025 15:16:17 +0200
X-Gm-Features: AS18NWBOzCi3X-4uAyCkXlOeXYpvNInj3HPAOaybGMIbiw6Itg2vBIBJsn8-kyw
Message-ID: <CAJFAV8yP5P=mDFK6KvkC8m+Tb1G_qGGio_xgLmRJuywuAJN=_A@mail.gmail.com>
Subject: Re: [PATCH v7 06/13] eal: define the EAL parameters in argparse format
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e5NzQLtSHrHz3tlGd5p3XW2VJcrgcjVpCk6gflK4Sek_1759238190
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

On Tue, 30 Sept 2025 at 14:58, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Sep 30, 2025 at 02:45:49PM +0200, David Marchand wrote:
> > On Wed, 23 Jul 2025 at 18:21, Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > > +/*
> > > + * list of EAL arguments as struct rte_argparse_arg.
> > > + * Format of each entry: long name, short name, help string, struct member name.
> > > + */
> > > +/* (Alphabetical) List of common options first */
> > > +LIST_ARG("--allow", "-a", "Add device to allow-list, causing DPDK to only use specified devices", allow)
> > > +STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory", base_virtaddr)
> > > +LIST_ARG("--block", "-b", "Add device to block-list, preventing DPDK from using the device", block)
> > > +STR_ARG("--coremask", "-c", "Hexadecimal bitmask of cores to use", coremask)
> > > +LIST_ARG("--driver-path", "-d", "Path to external driver shared object, or directory of drivers", driver_path)
> > > +STR_ARG("--force-max-simd-bitwidth", NULL, "Set max SIMD bitwidth to use in vector code paths", force_max_simd_bitwidth)
> > > +OPT_STR_ARG("--huge-unlink", NULL, "Unlink hugetlbfs files on exit (existing|always|never)", huge_unlink)
> > > +BOOL_ARG("--in-memory", NULL, "DPDK should not create shared mmap files in filesystem  (disables secondary process support)", in_memory)
> > > +STR_ARG("--iova-mode", NULL, "IOVA mapping mode, physical (pa)/virtual (va)", iova_mode)
> > > +STR_ARG("--lcores", "-l", "List of CPU cores to use", lcores)
> > > +BOOL_ARG("--legacy-mem", NULL, "Enable legacy memory behavior", legacy_mem)
> > > +OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color)
> > > +STR_ARG("--log-level", NULL, "Log level for loggers; use log-level=help for list of log types and levels", log_level)
> >
> > Previously, we could have multiple --log-level options.
> > While here, I think we will keep only the last value.
> >
> > Should it be a LIST_ARG?
> >
>
> Never thought of that. Will take a look. However, am I right in thinking
> that within a single log-level arg, you can have multiple level specifiers
> for different components?

All I see in eal_parse_log_level() is a difference in treatment
between regex, and pattern:.
Am I missing something?


-- 
David Marchand

