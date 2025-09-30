Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E43CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 12:46:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02625400EF;
	Tue, 30 Sep 2025 14:46:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 90756400D7
 for <dev@dpdk.org>; Tue, 30 Sep 2025 14:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759236366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16cuNArr8vObKkz74QAhoe0dkCwfIciJujbjDMkiqcI=;
 b=IZctghGlDV42xMAnnOejCnkXN1FyzNlyHbwQ/1BzLNWvDEL81NDgGVMcpWqmHgTTCVX2IS
 l/nLBOsKkHOpg45FcWSVfxzKxRHXd8JlLS0qpUSVnNWGLLfKUZwzRpufofOWKgifiXI/qh
 mOYGvIdXao7PxAILZZPBQjffe1kY/Bg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-75HVAeQkM-u6Oa8W5abDFg-1; Tue, 30 Sep 2025 08:46:03 -0400
X-MC-Unique: 75HVAeQkM-u6Oa8W5abDFg-1
X-Mimecast-MFC-AGG-ID: 75HVAeQkM-u6Oa8W5abDFg_1759236362
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-36ac8376af1so23986071fa.3
 for <dev@dpdk.org>; Tue, 30 Sep 2025 05:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759236362; x=1759841162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=16cuNArr8vObKkz74QAhoe0dkCwfIciJujbjDMkiqcI=;
 b=jaeQE7Xg3KwXPGDXrUTJwfWci3LiW5BF8agZ+hPuodAwIIpaPm/odVUq1qHPRTqzdU
 DcrjoIJC496kTURoWaPtVcu+HyxDpKmUbB3T6USCFYtWnmOGliJGTebF7DNplWcu/mFH
 cnktuhxycniew3U5Ht97hBsSAgXIbiGY56XC4cLJkvxtlJmzsfLx7fIOVaVX4CAxvsGN
 vWm2yIcYArVd9EAYPRqTdtfwKhcuh89ITDVFFpK6NSExSd9T5eO2TxRtDy+iI+j76kkb
 Fg99GIpXhHQQ8Eg2IJnbV2nfrtlY2+9gdYRka4cCuuSaH6N/X4hupzprgy4GUrw1+vb7
 rBxA==
X-Gm-Message-State: AOJu0Yx2gc53R0KWUvIm6XW6gzoBoB57pkrupy3SRoz3/pq7rRfKsgDl
 uY289LJ8HBhLmECWJ9vpFW2/TCtn70o/0yxuofMuJcsU2nF3i2d2wCtJbLw+kVB2MvENkHNRFOZ
 dvTUp9UKYsUaGJ7yhtiwWmW8ib3JRFNUikGZHQZBBgr7rEAUfdEqxAtpy4yzR+URvWCjTe7WwKH
 YWL1ZGD6NX9HauvaW4x2Q=
X-Gm-Gg: ASbGncspMjJt4bVXyXnEfmhyrSVzBUowPixRSveKZdNITHfqoHZYFOq8ObQdPBFkP8D
 LK02CKKJ9JwpPQ0o4oxb+VCm9pwHZGS72Pe5bM6N6hPcXhTSphtz4/+0yP3FysU65k78hvswJPT
 JKo3Ku1gO2Np56vK5ZyHbZne5FIHO/
X-Received: by 2002:a2e:bd84:0:b0:372:89a5:c550 with SMTP id
 38308e7fff4ca-37289a5c9a9mr30725391fa.45.1759236362274; 
 Tue, 30 Sep 2025 05:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSfpXpxzybgpn7XR9zGEdn5RGGewyXOVaKFaUp1eZhC/QgWyDou9dFqiGOxFhJpsVAGFXuCiv1N49KwwQrsPM=
X-Received: by 2002:a2e:bd84:0:b0:372:89a5:c550 with SMTP id
 38308e7fff4ca-37289a5c9a9mr30725301fa.45.1759236361785; Tue, 30 Sep 2025
 05:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250723162013.2392-1-bruce.richardson@intel.com>
 <20250723162013.2392-7-bruce.richardson@intel.com>
In-Reply-To: <20250723162013.2392-7-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 30 Sep 2025 14:45:49 +0200
X-Gm-Features: AS18NWADPwMq8lT7zczQi4zluJU4EjdhbsNvTEZ_nNYWQ3oRRqnbGrxfU6oLxDc
Message-ID: <CAJFAV8ymGTU2tDzQoy-jk-bN6uigV1f2oh0TAwiHBzsc8nZNbg@mail.gmail.com>
Subject: Re: [PATCH v7 06/13] eal: define the EAL parameters in argparse format
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NvfUeeu1bXrH1S03aicvQMhN7e8VWfuGHZ5H9ozvaqU_1759236362
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

On Wed, 23 Jul 2025 at 18:21, Bruce Richardson
<bruce.richardson@intel.com> wrote:
> +/*
> + * list of EAL arguments as struct rte_argparse_arg.
> + * Format of each entry: long name, short name, help string, struct member name.
> + */
> +/* (Alphabetical) List of common options first */
> +LIST_ARG("--allow", "-a", "Add device to allow-list, causing DPDK to only use specified devices", allow)
> +STR_ARG("--base-virtaddr", NULL, "Base virtual address to reserve memory", base_virtaddr)
> +LIST_ARG("--block", "-b", "Add device to block-list, preventing DPDK from using the device", block)
> +STR_ARG("--coremask", "-c", "Hexadecimal bitmask of cores to use", coremask)
> +LIST_ARG("--driver-path", "-d", "Path to external driver shared object, or directory of drivers", driver_path)
> +STR_ARG("--force-max-simd-bitwidth", NULL, "Set max SIMD bitwidth to use in vector code paths", force_max_simd_bitwidth)
> +OPT_STR_ARG("--huge-unlink", NULL, "Unlink hugetlbfs files on exit (existing|always|never)", huge_unlink)
> +BOOL_ARG("--in-memory", NULL, "DPDK should not create shared mmap files in filesystem  (disables secondary process support)", in_memory)
> +STR_ARG("--iova-mode", NULL, "IOVA mapping mode, physical (pa)/virtual (va)", iova_mode)
> +STR_ARG("--lcores", "-l", "List of CPU cores to use", lcores)
> +BOOL_ARG("--legacy-mem", NULL, "Enable legacy memory behavior", legacy_mem)
> +OPT_STR_ARG("--log-color", NULL, "Enable/disable color in log output", log_color)
> +STR_ARG("--log-level", NULL, "Log level for loggers; use log-level=help for list of log types and levels", log_level)

Previously, we could have multiple --log-level options.
While here, I think we will keep only the last value.

Should it be a LIST_ARG?

> +OPT_STR_ARG("--log-timestamp", NULL, "Enable/disable timestamp in log output", log_timestamp)
> +STR_ARG("--main-lcore", NULL, "Select which core to use for the main thread", main_lcore)
> +STR_ARG("--mbuf-pool-ops-name", NULL, "User defined mbuf default pool ops name", mbuf_pool_ops_name)
> +STR_ARG("--memory-channels", "-n", "Number of memory channels per socket", memory_channels)
> +STR_ARG("--memory-ranks", "-r", "Force number of memory ranks (don't detect)", memory_ranks)
> +STR_ARG("--memory-size", "-m", "Total size of memory to allocate initially", memory_size)
> +BOOL_ARG("--no-hpet", NULL, "Disable HPET timer", no_hpet)
> +BOOL_ARG("--no-huge", NULL, "Disable hugetlbfs support", no_huge)
> +BOOL_ARG("--no-pci", NULL, "Disable all PCI devices", no_pci)
> +BOOL_ARG("--no-shconf", NULL, "Disable shared config file generation", no_shconf)
> +BOOL_ARG("--no-telemetry", NULL, "Disable telemetry", no_telemetry)
> +STR_ARG("--proc-type", NULL, "Type of process (primary|secondary|auto)", proc_type)
> +STR_ARG("--service-corelist", "-S", "List of cores to use for service threads", service_corelist)
> +STR_ARG("--service-coremask", "-s", "Hexadecimal bitmask of cores to use for service threads", service_coremask)
> +BOOL_ARG("--single-file-segments", NULL, "Store all pages within single files (per-page-size, per-node)", single_file_segments)
> +BOOL_ARG("--telemetry", NULL, "Enable telemetry", telemetry)
> +LIST_ARG("--vdev", NULL, "Add a virtual device to the system; format=<driver><id>[,key=val,...]", vdev)
> +BOOL_ARG("--vmware-tsc-map", NULL, "Use VMware TSC mapping instead of native RDTSC", vmware_tsc_map)
> +BOOL_ARG("--version", "-v", "Show version", version)
> +
> +#if defined(INCLUDE_ALL_ARG) || !defined(RTE_EXEC_ENV_WINDOWS)
> +/* Linux and FreeBSD options*/
> +OPT_STR_ARG("--syslog", NULL, "Log to syslog (and optionally set facility)", syslog)
> +STR_ARG("--trace", NULL, "Enable trace based on regular expression trace name", trace)

Same comment for --trace.


> +STR_ARG("--trace-bufsz", NULL, "Trace buffer size", trace_bufsz)
> +STR_ARG("--trace-dir", NULL, "Trace directory", trace_dir)
> +STR_ARG("--trace-mode", NULL, "Trace mode", trace_mode)
> +#endif
> +
> +#if defined(INCLUDE_ALL_ARG) || defined(RTE_EXEC_ENV_LINUX)
> +/* Linux-only options */
> +BOOL_ARG("--create-uio-dev", NULL, "Create /dev/uioX devices", create_uio_dev)
> +STR_ARG("--file-prefix", NULL, "Base filename of hugetlbfs files", file_prefix)
> +STR_ARG("--huge-dir", NULL, "Directory for hugepage files", huge_dir)
> +OPT_STR_ARG("--huge-worker-stack", NULL, "Allocate worker thread stacks from hugepage memory, with optional size (kB)", huge_worker_stack)
> +BOOL_ARG("--match-allocations", NULL, "Free hugepages exactly as allocated", match_allocations)
> +STR_ARG("--numa-mem", NULL, "Memory to allocate on NUMA nodes (comma separated values)", numa_mem)
> +STR_ARG("--numa-limit", NULL, "Limit memory allocation on NUMA nodes (comma separated values)", numa_limit)
> +STR_ALIAS("--socket-mem", NULL, "Alias for --numa-mem", numa_mem)
> +STR_ALIAS("--socket-limit", NULL, "Alias for --numa-limit", numa_limit)
> +STR_ARG("--vfio-intr", NULL, "VFIO interrupt mode (legacy|msi|msix)", vfio_intr)
> +STR_ARG("--vfio-vf-token", NULL, "VF token (UUID) shared between SR-IOV PF and VFs", vfio_vf_token)
> +#endif


-- 
David Marchand

