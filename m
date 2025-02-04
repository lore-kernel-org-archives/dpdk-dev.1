Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1516C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:42:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06E9F42788;
	Tue,  4 Feb 2025 16:42:05 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 60F2F4278D
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:42:03 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so10020224a91.3
 for <dev@dpdk.org>; Tue, 04 Feb 2025 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738683722; x=1739288522; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vU34EuQgWyKhc6vcXy52T4ub29j6gKi22cDOYVrVB2A=;
 b=e5QBF8/os4tOKi5p7xWNNUuQYkTPV6mAlmhSW3Cw/Tv1YMow7GqfzNn/QUhJW3j3JQ
 0wpfy4JVGWbZm+/yA6SIXdKw9KjTf7JGyG0yQwfzcDrMpz1u64EenEJJi9N+Tf7wSeXA
 5MCZCEaob1C0kO9m/siDyr3rhPJyPtwVO4fiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738683722; x=1739288522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vU34EuQgWyKhc6vcXy52T4ub29j6gKi22cDOYVrVB2A=;
 b=S6UMheqykgihlLZo2AZyLHgbg5AedBdkeUeECpjQHgiRzsql3i/iY6NSEo4QoNaRpQ
 RMuctqzLPcCPSTQhr5+t+9vnulbcKRmgTrcEyaofLt9FpT3M985QDV3AbsZpTHlUeA2V
 9QwW6YlvTbHDou1Fbkvqcp6fq3q2LGR8PAHAkpKI+jSwbMQoK+8uhK7ZHQmtfmsW/Bxs
 yMQ0rcFIebRfuc8G64Z+kc46jPnYR94zA+Q7YoJU+7R6zb2XWu5mdpoZxfGDD5jiwgbG
 qfN824fJB3Q9pK6rgJcTL5b2NhmjRdPUPDFqXH98gon8dqAeaosZ0VoX0Wu1JFshRBsY
 0MWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY+gqxFq1qMEQgMHpwMcrl8qXifJ8P9sioLPvOa1rUCPNTqn4hRJR7hEWxUkVx1sIIWQ4=@dpdk.org
X-Gm-Message-State: AOJu0YzE3R5WMiBHdSODF87DgLni5q/K15BlKdNihBkBHoCfQdgErzGp
 qe+Hkl1MByA8pc8GkNm8KCgybpl0gR5V54gYMVfpgps5uYPTd7GMWlpD9pXvvT3knVmGZJGlqH/
 KLZO5BTszvWgyQbWF5q1bc5Z1aoBdR+cK5Wqr/g==
X-Gm-Gg: ASbGncvqwI09BOiw4avpvUZvkv/pvAR+oANKpLVijcwPzeKx7cfV4FFL02aOKEGku2O
 OZ66CQ0C59AHyHBu32+zyYBCTm1B+SQSY0ml1IYtuXLlMCifLwZ3FwFh/tfeJ7RCe9yMwHuJXKS
 R91D9y/uFMUOcyUUjGiZwK7wKDj+1rDQ==
X-Google-Smtp-Source: AGHT+IHSLvzWM9z+jZI9AXui9uPLYrpKp7Myc1aALS5C3nSI+DNltR1CCwI0gWmQhIt+pWoB1U1yCT2n9I5Kp0Btm3o=
X-Received: by 2002:a17:90b:51cc:b0:2ee:9902:18b4 with SMTP id
 98e67ed59e1d1-2f83ac5c222mr37622683a91.27.1738683722298; Tue, 04 Feb 2025
 07:42:02 -0800 (PST)
MIME-Version: 1.0
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8z+aLY+etV+0knb0ZJMyocDZMYWStSBLiVZyeW1ZAVFsw@mail.gmail.com>
In-Reply-To: <CAJFAV8z+aLY+etV+0knb0ZJMyocDZMYWStSBLiVZyeW1ZAVFsw@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 4 Feb 2025 10:38:55 -0500
X-Gm-Features: AWEUYZl1senskk8MOzRmpukFjDHi-xYsJ9VHRf0qaaZkgCB25kWL6rWGN_n8E74
Message-ID: <CAJvnSUASYqe39J3MTXqfEPSVWi6=z95TdN7z6e20QyJLeSNGug@mail.gmail.com>
Subject: Re: [PATCH v19 00/27] remove use of VLAs for Windows
To: David Marchand <david.marchand@redhat.com>
Cc: Andre Muezerie <andremue@linux.microsoft.com>, dev@dpdk.org, 
 konstantin.ananyev@huawei.com, thomas@monjalon.net, ci@dpdk.org, 
 Aaron Conole <aconole@redhat.com>, Cody Cheng <ccheng@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000a51173062d52d935"
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

--000000000000a51173062d52d935
Content-Type: text/plain; charset="UTF-8"

It looks like this failed the check-meson script which we incorporated into
our apply/build pipeline recently, which is why this series got a "build
failure." It is indicating there are issues with lib/vhost/meson.build
and app/test/meson.build.

Obviously we need to provide an email body which makes clear that
check-meson was the source of the failure, and I have a UNH Lab ticket for
this.

Running Check Meson
 Processing meson.build
 Processing usertools/meson.build
 Processing kernel/meson.build
 Processing kernel/freebsd/meson.build
 Processing kernel/freebsd/contigmem/meson.build
 Processing kernel/freebsd/nic_uio/meson.build
 Processing app/meson.build
 Processing app/dumpcap/meson.build
 Processing app/test-security-perf/meson.build
 Processing app/test-acl/meson.build
 Processing app/test-regex/meson.build
 Processing app/test-fib/meson.build
 Processing app/test-compress-perf/meson.build
 Processing app/test-pmd/meson.build
 Processing app/test-gpudev/meson.build
 Processing app/test-mldev/meson.build
 Processing app/test-crypto-perf/meson.build
 Processing app/test-bbdev/meson.build
 Processing app/test/meson.build
 Error: Incorrect indent at app/test/meson.build:257
 Error: Incorrect indent at app/test/meson.build:258
 Processing app/test/suites/meson.build
 Processing app/test/test_cfgfiles/meson.build
 Processing app/test-dma-perf/meson.build
 Processing app/proc-info/meson.build
 Processing app/test-pipeline/meson.build
 Processing app/graph/meson.build
 Processing app/test-eventdev/meson.build
 Processing app/test-cmdline/meson.build
 Processing app/test-sad/meson.build
 Processing app/test-flow-perf/meson.build
 Processing app/pdump/meson.build
 Processing config/meson.build
 Processing config/arm/meson.build
 Processing config/riscv/meson.build
 Processing config/ppc/meson.build
 Processing config/x86/meson.build
 Processing config/loongarch/meson.build
 Processing buildtools/meson.build
 Processing buildtools/pkg-config/meson.build
 Processing buildtools/subproject/meson.build
 Processing buildtools/chkincs/meson.build
 Processing examples/meson.build
 Processing examples/distributor/meson.build
 Processing examples/fips_validation/meson.build
 Processing examples/l3fwd-power/meson.build
 Processing examples/vhost_crypto/meson.build
 Processing examples/l2fwd-cat/meson.build
 Processing examples/ipsec-secgw/meson.build
 Processing examples/bbdev_app/meson.build
 Processing examples/l2fwd-event/meson.build
 Processing examples/vdpa/meson.build
 Processing examples/dma/meson.build
 Processing examples/vhost/meson.build
 Processing examples/l2fwd/meson.build
 Processing examples/ethtool/meson.build
 Processing examples/vhost_blk/meson.build
 Processing examples/packet_ordering/meson.build
 Processing examples/bond/meson.build
 Processing examples/l2fwd-macsec/meson.build
 Processing examples/eventdev_pipeline/meson.build
 Processing examples/ipv4_multicast/meson.build
 Processing examples/l3fwd/meson.build
 Processing examples/pipeline/meson.build
 Processing examples/vmdq/meson.build
 Processing examples/cmdline/meson.build
 Processing examples/ip_fragmentation/meson.build
 Processing examples/helloworld/meson.build
 Processing examples/flow_filtering/meson.build
 Processing examples/link_status_interrupt/meson.build
 Processing examples/l2fwd-keepalive/meson.build
 Processing examples/service_cores/meson.build
 Processing examples/l2fwd-jobstats/meson.build
 Processing examples/qos_meter/meson.build
 Processing examples/ptpclient/meson.build
 Processing examples/qos_sched/meson.build
 Processing examples/multi_process/symmetric_mp/meson.build
 Processing examples/multi_process/hotplug_mp/meson.build
 Processing examples/multi_process/client_server_mp/mp_server/meson.build
 Processing examples/multi_process/client_server_mp/mp_client/meson.build
 Processing examples/multi_process/simple_mp/meson.build
 Processing examples/timer/meson.build
 Processing examples/vmdq_dcb/meson.build
 Processing examples/rxtx_callbacks/meson.build
 Processing examples/ntb/meson.build
 Processing examples/l2fwd-crypto/meson.build
 Processing examples/skeleton/meson.build
 Processing examples/server_node_efd/efd_node/meson.build
 Processing examples/server_node_efd/efd_server/meson.build
 Processing examples/ip_reassembly/meson.build
 Processing examples/l3fwd-graph/meson.build
 Processing examples/vm_power_manager/meson.build
 Processing examples/vm_power_manager/guest_cli/meson.build
 Processing examples/ip_pipeline/meson.build
 Processing doc/meson.build
 Processing doc/api/meson.build
 Processing doc/api/dts/meson.build
 Processing doc/guides/meson.build
 Processing drivers/meson.build
 Processing drivers/crypto/meson.build
 Processing drivers/crypto/uadk/meson.build
 Processing drivers/crypto/scheduler/meson.build
 Processing drivers/crypto/nitrox/meson.build
 Processing drivers/crypto/ipsec_mb/meson.build
 Processing drivers/crypto/openssl/meson.build
 Processing drivers/crypto/bcmfs/meson.build
 Processing drivers/crypto/cnxk/meson.build
 Processing drivers/crypto/mvsam/meson.build
 Processing drivers/crypto/ionic/meson.build
 Processing drivers/crypto/ccp/meson.build
 Processing drivers/crypto/dpaa_sec/meson.build
 Processing drivers/crypto/dpaa2_sec/meson.build
 Processing drivers/crypto/octeontx/meson.build
 Processing drivers/crypto/mlx5/meson.build
 Processing drivers/crypto/armv8/meson.build
 Processing drivers/crypto/null/meson.build
 Processing drivers/crypto/caam_jr/meson.build
 Processing drivers/crypto/virtio/meson.build
 Processing drivers/vdpa/meson.build
 Processing drivers/vdpa/sfc/meson.build
 Processing drivers/vdpa/nfp/meson.build
 Processing drivers/vdpa/ifc/meson.build
 Processing drivers/vdpa/mlx5/meson.build
 Processing drivers/dma/meson.build
 Processing drivers/dma/idxd/meson.build
 Processing drivers/dma/odm/meson.build
 Processing drivers/dma/dpaa2/meson.build
 Processing drivers/dma/cnxk/meson.build
 Processing drivers/dma/dpaa/meson.build
 Processing drivers/dma/hisilicon/meson.build
 Processing drivers/dma/ioat/meson.build
 Processing drivers/dma/skeleton/meson.build
 Processing drivers/common/meson.build
 Processing drivers/common/iavf/meson.build
 Processing drivers/common/nitrox/meson.build
 Processing drivers/common/nfp/meson.build
 Processing drivers/common/dpaax/meson.build
 Processing drivers/common/cnxk/meson.build
 Processing drivers/common/sfc_efx/meson.build
 Processing drivers/common/sfc_efx/base/meson.build
 Processing drivers/common/ionic/meson.build
 Processing drivers/common/octeontx/meson.build
 Processing drivers/common/mlx5/meson.build
 Processing drivers/common/mlx5/linux/meson.build
 Processing drivers/common/mlx5/windows/meson.build
 Processing drivers/common/idpf/meson.build
 Processing drivers/common/idpf/base/meson.build
 Processing drivers/common/mvep/meson.build
 Processing drivers/common/cpt/meson.build
 Processing drivers/common/qat/meson.build
 Processing drivers/mempool/meson.build
 Processing drivers/mempool/bucket/meson.build
 Processing drivers/mempool/dpaa2/meson.build
 Processing drivers/mempool/cnxk/meson.build
 Processing drivers/mempool/octeontx/meson.build
 Processing drivers/mempool/dpaa/meson.build
 Processing drivers/mempool/ring/meson.build
 Processing drivers/mempool/stack/meson.build
 Processing drivers/ml/meson.build
 Processing drivers/ml/cnxk/meson.build
 Processing drivers/event/meson.build
 Processing drivers/event/opdl/meson.build
 Processing drivers/event/dpaa2/meson.build
 Processing drivers/event/cnxk/meson.build
 Processing drivers/event/sw/meson.build
 Processing drivers/event/octeontx/meson.build
 Processing drivers/event/dpaa/meson.build
 Processing drivers/event/dsw/meson.build
 Processing drivers/event/dlb2/meson.build
 Processing drivers/event/skeleton/meson.build
 Processing drivers/compress/meson.build
 Processing drivers/compress/uadk/meson.build
 Processing drivers/compress/nitrox/meson.build
 Processing drivers/compress/octeontx/meson.build
 Processing drivers/compress/mlx5/meson.build
 Processing drivers/compress/isal/meson.build
 Processing drivers/compress/zlib/meson.build
 Processing drivers/bus/meson.build
 Processing drivers/bus/fslmc/meson.build
 Processing drivers/bus/ifpga/meson.build
 Processing drivers/bus/platform/meson.build
 Processing drivers/bus/auxiliary/meson.build
 Processing drivers/bus/dpaa/meson.build
 Processing drivers/bus/uacce/meson.build
 Processing drivers/bus/pci/meson.build
 Processing drivers/bus/cdx/meson.build
 Processing drivers/bus/vdev/meson.build
 Processing drivers/bus/vmbus/meson.build
 Processing drivers/regex/meson.build
 Processing drivers/regex/mlx5/meson.build
 Processing drivers/regex/cn9k/meson.build
 Processing drivers/gpu/meson.build
 Processing drivers/gpu/cuda/meson.build
 Processing drivers/net/meson.build
 Processing drivers/net/zxdh/meson.build
 Processing drivers/net/sfc/meson.build
 Processing drivers/net/bnx2x/meson.build
 Processing drivers/net/ngbe/meson.build
 Processing drivers/net/ngbe/base/meson.build
 Processing drivers/net/netvsc/meson.build
 Processing drivers/net/failsafe/meson.build
 Processing drivers/net/qede/meson.build
 Processing drivers/net/qede/base/meson.build
 Processing drivers/net/gve/meson.build
 Processing drivers/net/intel/i40e/meson.build
 Processing drivers/net/intel/i40e/base/meson.build
 Processing drivers/net/intel/ice/meson.build
 Processing drivers/net/intel/ice/base/meson.build
 Processing drivers/net/intel/iavf/meson.build
 Processing drivers/net/intel/fm10k/meson.build
 Processing drivers/net/intel/fm10k/base/meson.build
 Processing drivers/net/intel/igc/meson.build
 Processing drivers/net/intel/igc/base/meson.build
 Processing drivers/net/intel/cpfl/meson.build
 Processing drivers/net/intel/e1000/meson.build
 Processing drivers/net/intel/e1000/base/meson.build
 Processing drivers/net/intel/ipn3ke/meson.build
 Processing drivers/net/intel/ixgbe/meson.build
 Processing drivers/net/intel/ixgbe/base/meson.build
 Processing drivers/net/intel/idpf/meson.build
 Processing drivers/net/txgbe/meson.build
 Processing drivers/net/txgbe/base/meson.build
 Processing drivers/net/r8169/meson.build
 Processing drivers/net/vhost/meson.build
 Processing drivers/net/hinic/meson.build
 Processing drivers/net/hinic/base/meson.build
 Processing drivers/net/nfp/meson.build
 Processing drivers/net/mana/meson.build
 Processing drivers/net/af_packet/meson.build
 Processing drivers/net/axgbe/meson.build
 Processing drivers/net/thunderx/meson.build
 Processing drivers/net/thunderx/base/meson.build
 Processing drivers/net/dpaa2/meson.build
 Processing drivers/net/cnxk/meson.build
 Processing drivers/net/enetc/meson.build
 Processing drivers/net/ionic/meson.build
 Processing drivers/net/mlx4/meson.build
 Processing drivers/net/avp/meson.build
 Processing drivers/net/af_xdp/meson.build
 Processing drivers/net/mvpp2/meson.build
 Processing drivers/net/octeontx/meson.build
 Processing drivers/net/octeontx/base/meson.build
 Processing drivers/net/tap/meson.build
 Processing drivers/net/tap/bpf/meson.build
 Processing drivers/net/memif/meson.build
 Processing drivers/net/mlx5/meson.build
 Processing drivers/net/mlx5/hws/meson.build
 Processing drivers/net/mlx5/linux/meson.build
 Processing drivers/net/mlx5/windows/meson.build
 Processing drivers/net/ena/meson.build
 Processing drivers/net/cxgbe/meson.build
 Processing drivers/net/enic/meson.build
 Processing drivers/net/ntnic/meson.build
 Processing drivers/net/dpaa/meson.build
 Processing drivers/net/nfb/meson.build
 Processing drivers/net/softnic/meson.build
 Processing drivers/net/bnxt/meson.build
 Processing drivers/net/bnxt/tf_ulp/meson.build
 Processing drivers/net/bnxt/tf_ulp/generic_templates/meson.build
 Processing drivers/net/bnxt/hcapi/cfa_v3/meson.build
 Processing drivers/net/bnxt/hcapi/cfa/meson.build
 Processing drivers/net/bnxt/tf_core/meson.build
 Processing drivers/net/bnxt/tf_core/v3/meson.build
 Processing drivers/net/ring/meson.build
 Processing drivers/net/enetfec/meson.build
 Processing drivers/net/null/meson.build
 Processing drivers/net/octeon_ep/meson.build
 Processing drivers/net/vdev_netvsc/meson.build
 Processing drivers/net/pfe/meson.build
 Processing drivers/net/pcap/meson.build
 Processing drivers/net/hns3/meson.build
 Processing drivers/net/mvneta/meson.build
 Processing drivers/net/atlantic/meson.build
 Processing drivers/net/virtio/meson.build
 Processing drivers/net/bonding/meson.build
 Processing drivers/net/ark/meson.build
 Processing drivers/net/vmxnet3/meson.build
 Processing drivers/power/meson.build
 Processing drivers/power/acpi/meson.build
 Processing drivers/power/intel_pstate/meson.build
 Processing drivers/power/amd_uncore/meson.build
 Processing drivers/power/amd_pstate/meson.build
 Processing drivers/power/kvm_vm/meson.build
 Processing drivers/power/cppc/meson.build
 Processing drivers/power/intel_uncore/meson.build
 Processing drivers/raw/meson.build
 Processing drivers/raw/cnxk_bphy/meson.build
 Processing drivers/raw/gdtc/meson.build
 Processing drivers/raw/ifpga/meson.build
 Processing drivers/raw/ifpga/base/meson.build
 Processing drivers/raw/dpaa2_cmdif/meson.build
 Processing drivers/raw/cnxk_gpio/meson.build
 Processing drivers/raw/cnxk_rvu_lf/meson.build
 Processing drivers/raw/ntb/meson.build
 Processing drivers/raw/skeleton/meson.build
 Processing drivers/baseband/meson.build
 Processing drivers/baseband/fpga_5gnr_fec/meson.build
 Processing drivers/baseband/fpga_lte_fec/meson.build
 Processing drivers/baseband/la12xx/meson.build
 Processing drivers/baseband/acc/meson.build
 Processing drivers/baseband/null/meson.build
 Processing drivers/baseband/turbo_sw/meson.build
 Processing lib/meson.build
 Processing lib/bpf/meson.build
 Processing lib/latencystats/meson.build
 Processing lib/bbdev/meson.build
 Processing lib/distributor/meson.build
 Processing lib/eal/meson.build
 Processing lib/eal/arm/meson.build
 Processing lib/eal/arm/include/meson.build
 Processing lib/eal/freebsd/meson.build
 Processing lib/eal/freebsd/include/meson.build
 Processing lib/eal/common/meson.build
 Processing lib/eal/include/meson.build
 Processing lib/eal/linux/meson.build
 Processing lib/eal/linux/include/meson.build
 Processing lib/eal/riscv/meson.build
 Processing lib/eal/riscv/include/meson.build
 Processing lib/eal/unix/meson.build
 Processing lib/eal/windows/meson.build
 Processing lib/eal/windows/include/meson.build
 Processing lib/eal/ppc/meson.build
 Processing lib/eal/ppc/include/meson.build
 Processing lib/eal/x86/meson.build
 Processing lib/eal/x86/include/meson.build
 Processing lib/eal/loongarch/meson.build
 Processing lib/eal/loongarch/include/meson.build
 Processing lib/member/meson.build
 Processing lib/rawdev/meson.build
 Processing lib/gro/meson.build
 Processing lib/fib/meson.build
 Processing lib/vhost/meson.build
 Error: Incorrect indent at lib/vhost/meson.build:23
 Error: Incorrect indent at lib/vhost/meson.build:24
 Processing lib/argparse/meson.build
 Processing lib/node/meson.build
 Processing lib/kvargs/meson.build
 Processing lib/mempool/meson.build
 Processing lib/pdcp/meson.build
 Processing lib/ptr_compress/meson.build
 Processing lib/mldev/meson.build
 Processing lib/rib/meson.build
 Processing lib/regexdev/meson.build
 Processing lib/ip_frag/meson.build
 Processing lib/bitratestats/meson.build
 Processing lib/hash/meson.build
 Processing lib/sched/meson.build
 Processing lib/eventdev/meson.build
 Processing lib/efd/meson.build
 Processing lib/meter/meson.build
 Processing lib/rcu/meson.build
 Processing lib/pipeline/meson.build
 Processing lib/cmdline/meson.build
 Processing lib/acl/meson.build
 Processing lib/jobstats/meson.build
 Processing lib/log/meson.build
 Processing lib/table/meson.build
 Processing lib/pcapng/meson.build
 Processing lib/port/meson.build
 Processing lib/ethdev/meson.build
 Processing lib/dmadev/meson.build
 Processing lib/ipsec/meson.build
 Processing lib/ring/meson.build
 Processing lib/gpudev/meson.build
 Processing lib/cryptodev/meson.build
 Processing lib/pci/meson.build
 Processing lib/cfgfile/meson.build
 Processing lib/net/meson.build
 Processing lib/dispatcher/meson.build
 Processing lib/reorder/meson.build
 Processing lib/power/meson.build
 Processing lib/graph/meson.build
 Processing lib/timer/meson.build
 Processing lib/stack/meson.build
 Processing lib/compressdev/meson.build
 Processing lib/metrics/meson.build
 Processing lib/telemetry/meson.build
 Processing lib/gso/meson.build
 Processing lib/lpm/meson.build
 Processing lib/security/meson.build
 Processing lib/pdump/meson.build
 Processing lib/mbuf/meson.build

--000000000000a51173062d52d935
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">It looks like this failed the check-meson script which we =
incorporated into our apply/build pipeline recently, which is why this seri=
es got a &quot;build failure.&quot; It is indicating there are issues with=
=C2=A0lib/vhost/meson.build and=C2=A0app/test/meson.build.<div><br></div><d=
iv><div>Obviously we need to provide an email body which makes clear that c=
heck-meson was the source of the failure, and I have a UNH Lab ticket for t=
his.</div><div><br></div><div>Running Check Meson<br>=C2=A0Processing meson=
.build<br>=C2=A0Processing usertools/meson.build<br>=C2=A0Processing kernel=
/meson.build<br>=C2=A0Processing kernel/freebsd/meson.build<br>=C2=A0Proces=
sing kernel/freebsd/contigmem/meson.build<br>=C2=A0Processing kernel/freebs=
d/nic_uio/meson.build<br>=C2=A0Processing app/meson.build<br>=C2=A0Processi=
ng app/dumpcap/meson.build<br>=C2=A0Processing app/test-security-perf/meson=
.build<br>=C2=A0Processing app/test-acl/meson.build<br>=C2=A0Processing app=
/test-regex/meson.build<br>=C2=A0Processing app/test-fib/meson.build<br>=C2=
=A0Processing app/test-compress-perf/meson.build<br>=C2=A0Processing app/te=
st-pmd/meson.build<br>=C2=A0Processing app/test-gpudev/meson.build<br>=C2=
=A0Processing app/test-mldev/meson.build<br>=C2=A0Processing app/test-crypt=
o-perf/meson.build<br>=C2=A0Processing app/test-bbdev/meson.build<br>=C2=A0=
Processing app/test/meson.build<br>=C2=A0Error: Incorrect indent at app/tes=
t/meson.build:257<br>=C2=A0Error: Incorrect indent at app/test/meson.build:=
258<br>=C2=A0Processing app/test/suites/meson.build<br>=C2=A0Processing app=
/test/test_cfgfiles/meson.build<br>=C2=A0Processing app/test-dma-perf/meson=
.build<br>=C2=A0Processing app/proc-info/meson.build<br>=C2=A0Processing ap=
p/test-pipeline/meson.build<br>=C2=A0Processing app/graph/meson.build<br>=
=C2=A0Processing app/test-eventdev/meson.build<br>=C2=A0Processing app/test=
-cmdline/meson.build<br>=C2=A0Processing app/test-sad/meson.build<br>=C2=A0=
Processing app/test-flow-perf/meson.build<br>=C2=A0Processing app/pdump/mes=
on.build<br>=C2=A0Processing config/meson.build<br>=C2=A0Processing config/=
arm/meson.build<br>=C2=A0Processing config/riscv/meson.build<br>=C2=A0Proce=
ssing config/ppc/meson.build<br>=C2=A0Processing config/x86/meson.build<br>=
=C2=A0Processing config/loongarch/meson.build<br>=C2=A0Processing buildtool=
s/meson.build<br>=C2=A0Processing buildtools/pkg-config/meson.build<br>=C2=
=A0Processing buildtools/subproject/meson.build<br>=C2=A0Processing buildto=
ols/chkincs/meson.build<br>=C2=A0Processing examples/meson.build<br>=C2=A0P=
rocessing examples/distributor/meson.build<br>=C2=A0Processing examples/fip=
s_validation/meson.build<br>=C2=A0Processing examples/l3fwd-power/meson.bui=
ld<br>=C2=A0Processing examples/vhost_crypto/meson.build<br>=C2=A0Processin=
g examples/l2fwd-cat/meson.build<br>=C2=A0Processing examples/ipsec-secgw/m=
eson.build<br>=C2=A0Processing examples/bbdev_app/meson.build<br>=C2=A0Proc=
essing examples/l2fwd-event/meson.build<br>=C2=A0Processing examples/vdpa/m=
eson.build<br>=C2=A0Processing examples/dma/meson.build<br>=C2=A0Processing=
 examples/vhost/meson.build<br>=C2=A0Processing examples/l2fwd/meson.build<=
br>=C2=A0Processing examples/ethtool/meson.build<br>=C2=A0Processing exampl=
es/vhost_blk/meson.build<br>=C2=A0Processing examples/packet_ordering/meson=
.build<br>=C2=A0Processing examples/bond/meson.build<br>=C2=A0Processing ex=
amples/l2fwd-macsec/meson.build<br>=C2=A0Processing examples/eventdev_pipel=
ine/meson.build<br>=C2=A0Processing examples/ipv4_multicast/meson.build<br>=
=C2=A0Processing examples/l3fwd/meson.build<br>=C2=A0Processing examples/pi=
peline/meson.build<br>=C2=A0Processing examples/vmdq/meson.build<br>=C2=A0P=
rocessing examples/cmdline/meson.build<br>=C2=A0Processing examples/ip_frag=
mentation/meson.build<br>=C2=A0Processing examples/helloworld/meson.build<b=
r>=C2=A0Processing examples/flow_filtering/meson.build<br>=C2=A0Processing =
examples/link_status_interrupt/meson.build<br>=C2=A0Processing examples/l2f=
wd-keepalive/meson.build<br>=C2=A0Processing examples/service_cores/meson.b=
uild<br>=C2=A0Processing examples/l2fwd-jobstats/meson.build<br>=C2=A0Proce=
ssing examples/qos_meter/meson.build<br>=C2=A0Processing examples/ptpclient=
/meson.build<br>=C2=A0Processing examples/qos_sched/meson.build<br>=C2=A0Pr=
ocessing examples/multi_process/symmetric_mp/meson.build<br>=C2=A0Processin=
g examples/multi_process/hotplug_mp/meson.build<br>=C2=A0Processing example=
s/multi_process/client_server_mp/mp_server/meson.build<br>=C2=A0Processing =
examples/multi_process/client_server_mp/mp_client/meson.build<br>=C2=A0Proc=
essing examples/multi_process/simple_mp/meson.build<br>=C2=A0Processing exa=
mples/timer/meson.build<br>=C2=A0Processing examples/vmdq_dcb/meson.build<b=
r>=C2=A0Processing examples/rxtx_callbacks/meson.build<br>=C2=A0Processing =
examples/ntb/meson.build<br>=C2=A0Processing examples/l2fwd-crypto/meson.bu=
ild<br>=C2=A0Processing examples/skeleton/meson.build<br>=C2=A0Processing e=
xamples/server_node_efd/efd_node/meson.build<br>=C2=A0Processing examples/s=
erver_node_efd/efd_server/meson.build<br>=C2=A0Processing examples/ip_reass=
embly/meson.build<br>=C2=A0Processing examples/l3fwd-graph/meson.build<br>=
=C2=A0Processing examples/vm_power_manager/meson.build<br>=C2=A0Processing =
examples/vm_power_manager/guest_cli/meson.build<br>=C2=A0Processing example=
s/ip_pipeline/meson.build<br>=C2=A0Processing doc/meson.build<br>=C2=A0Proc=
essing doc/api/meson.build<br>=C2=A0Processing doc/api/dts/meson.build<br>=
=C2=A0Processing doc/guides/meson.build<br>=C2=A0Processing drivers/meson.b=
uild<br>=C2=A0Processing drivers/crypto/meson.build<br>=C2=A0Processing dri=
vers/crypto/uadk/meson.build<br>=C2=A0Processing drivers/crypto/scheduler/m=
eson.build<br>=C2=A0Processing drivers/crypto/nitrox/meson.build<br>=C2=A0P=
rocessing drivers/crypto/ipsec_mb/meson.build<br>=C2=A0Processing drivers/c=
rypto/openssl/meson.build<br>=C2=A0Processing drivers/crypto/bcmfs/meson.bu=
ild<br>=C2=A0Processing drivers/crypto/cnxk/meson.build<br>=C2=A0Processing=
 drivers/crypto/mvsam/meson.build<br>=C2=A0Processing drivers/crypto/ionic/=
meson.build<br>=C2=A0Processing drivers/crypto/ccp/meson.build<br>=C2=A0Pro=
cessing drivers/crypto/dpaa_sec/meson.build<br>=C2=A0Processing drivers/cry=
pto/dpaa2_sec/meson.build<br>=C2=A0Processing drivers/crypto/octeontx/meson=
.build<br>=C2=A0Processing drivers/crypto/mlx5/meson.build<br>=C2=A0Process=
ing drivers/crypto/armv8/meson.build<br>=C2=A0Processing drivers/crypto/nul=
l/meson.build<br>=C2=A0Processing drivers/crypto/caam_jr/meson.build<br>=C2=
=A0Processing drivers/crypto/virtio/meson.build<br>=C2=A0Processing drivers=
/vdpa/meson.build<br>=C2=A0Processing drivers/vdpa/sfc/meson.build<br>=C2=
=A0Processing drivers/vdpa/nfp/meson.build<br>=C2=A0Processing drivers/vdpa=
/ifc/meson.build<br>=C2=A0Processing drivers/vdpa/mlx5/meson.build<br>=C2=
=A0Processing drivers/dma/meson.build<br>=C2=A0Processing drivers/dma/idxd/=
meson.build<br>=C2=A0Processing drivers/dma/odm/meson.build<br>=C2=A0Proces=
sing drivers/dma/dpaa2/meson.build<br>=C2=A0Processing drivers/dma/cnxk/mes=
on.build<br>=C2=A0Processing drivers/dma/dpaa/meson.build<br>=C2=A0Processi=
ng drivers/dma/hisilicon/meson.build<br>=C2=A0Processing drivers/dma/ioat/m=
eson.build<br>=C2=A0Processing drivers/dma/skeleton/meson.build<br>=C2=A0Pr=
ocessing drivers/common/meson.build<br>=C2=A0Processing drivers/common/iavf=
/meson.build<br>=C2=A0Processing drivers/common/nitrox/meson.build<br>=C2=
=A0Processing drivers/common/nfp/meson.build<br>=C2=A0Processing drivers/co=
mmon/dpaax/meson.build<br>=C2=A0Processing drivers/common/cnxk/meson.build<=
br>=C2=A0Processing drivers/common/sfc_efx/meson.build<br>=C2=A0Processing =
drivers/common/sfc_efx/base/meson.build<br>=C2=A0Processing drivers/common/=
ionic/meson.build<br>=C2=A0Processing drivers/common/octeontx/meson.build<b=
r>=C2=A0Processing drivers/common/mlx5/meson.build<br>=C2=A0Processing driv=
ers/common/mlx5/linux/meson.build<br>=C2=A0Processing drivers/common/mlx5/w=
indows/meson.build<br>=C2=A0Processing drivers/common/idpf/meson.build<br>=
=C2=A0Processing drivers/common/idpf/base/meson.build<br>=C2=A0Processing d=
rivers/common/mvep/meson.build<br>=C2=A0Processing drivers/common/cpt/meson=
.build<br>=C2=A0Processing drivers/common/qat/meson.build<br>=C2=A0Processi=
ng drivers/mempool/meson.build<br>=C2=A0Processing drivers/mempool/bucket/m=
eson.build<br>=C2=A0Processing drivers/mempool/dpaa2/meson.build<br>=C2=A0P=
rocessing drivers/mempool/cnxk/meson.build<br>=C2=A0Processing drivers/memp=
ool/octeontx/meson.build<br>=C2=A0Processing drivers/mempool/dpaa/meson.bui=
ld<br>=C2=A0Processing drivers/mempool/ring/meson.build<br>=C2=A0Processing=
 drivers/mempool/stack/meson.build<br>=C2=A0Processing drivers/ml/meson.bui=
ld<br>=C2=A0Processing drivers/ml/cnxk/meson.build<br>=C2=A0Processing driv=
ers/event/meson.build<br>=C2=A0Processing drivers/event/opdl/meson.build<br=
>=C2=A0Processing drivers/event/dpaa2/meson.build<br>=C2=A0Processing drive=
rs/event/cnxk/meson.build<br>=C2=A0Processing drivers/event/sw/meson.build<=
br>=C2=A0Processing drivers/event/octeontx/meson.build<br>=C2=A0Processing =
drivers/event/dpaa/meson.build<br>=C2=A0Processing drivers/event/dsw/meson.=
build<br>=C2=A0Processing drivers/event/dlb2/meson.build<br>=C2=A0Processin=
g drivers/event/skeleton/meson.build<br>=C2=A0Processing drivers/compress/m=
eson.build<br>=C2=A0Processing drivers/compress/uadk/meson.build<br>=C2=A0P=
rocessing drivers/compress/nitrox/meson.build<br>=C2=A0Processing drivers/c=
ompress/octeontx/meson.build<br>=C2=A0Processing drivers/compress/mlx5/meso=
n.build<br>=C2=A0Processing drivers/compress/isal/meson.build<br>=C2=A0Proc=
essing drivers/compress/zlib/meson.build<br>=C2=A0Processing drivers/bus/me=
son.build<br>=C2=A0Processing drivers/bus/fslmc/meson.build<br>=C2=A0Proces=
sing drivers/bus/ifpga/meson.build<br>=C2=A0Processing drivers/bus/platform=
/meson.build<br>=C2=A0Processing drivers/bus/auxiliary/meson.build<br>=C2=
=A0Processing drivers/bus/dpaa/meson.build<br>=C2=A0Processing drivers/bus/=
uacce/meson.build<br>=C2=A0Processing drivers/bus/pci/meson.build<br>=C2=A0=
Processing drivers/bus/cdx/meson.build<br>=C2=A0Processing drivers/bus/vdev=
/meson.build<br>=C2=A0Processing drivers/bus/vmbus/meson.build<br>=C2=A0Pro=
cessing drivers/regex/meson.build<br>=C2=A0Processing drivers/regex/mlx5/me=
son.build<br>=C2=A0Processing drivers/regex/cn9k/meson.build<br>=C2=A0Proce=
ssing drivers/gpu/meson.build<br>=C2=A0Processing drivers/gpu/cuda/meson.bu=
ild<br>=C2=A0Processing drivers/net/meson.build<br>=C2=A0Processing drivers=
/net/zxdh/meson.build<br>=C2=A0Processing drivers/net/sfc/meson.build<br>=
=C2=A0Processing drivers/net/bnx2x/meson.build<br>=C2=A0Processing drivers/=
net/ngbe/meson.build<br>=C2=A0Processing drivers/net/ngbe/base/meson.build<=
br>=C2=A0Processing drivers/net/netvsc/meson.build<br>=C2=A0Processing driv=
ers/net/failsafe/meson.build<br>=C2=A0Processing drivers/net/qede/meson.bui=
ld<br>=C2=A0Processing drivers/net/qede/base/meson.build<br>=C2=A0Processin=
g drivers/net/gve/meson.build<br>=C2=A0Processing drivers/net/intel/i40e/me=
son.build<br>=C2=A0Processing drivers/net/intel/i40e/base/meson.build<br>=
=C2=A0Processing drivers/net/intel/ice/meson.build<br>=C2=A0Processing driv=
ers/net/intel/ice/base/meson.build<br>=C2=A0Processing drivers/net/intel/ia=
vf/meson.build<br>=C2=A0Processing drivers/net/intel/fm10k/meson.build<br>=
=C2=A0Processing drivers/net/intel/fm10k/base/meson.build<br>=C2=A0Processi=
ng drivers/net/intel/igc/meson.build<br>=C2=A0Processing drivers/net/intel/=
igc/base/meson.build<br>=C2=A0Processing drivers/net/intel/cpfl/meson.build=
<br>=C2=A0Processing drivers/net/intel/e1000/meson.build<br>=C2=A0Processin=
g drivers/net/intel/e1000/base/meson.build<br>=C2=A0Processing drivers/net/=
intel/ipn3ke/meson.build<br>=C2=A0Processing drivers/net/intel/ixgbe/meson.=
build<br>=C2=A0Processing drivers/net/intel/ixgbe/base/meson.build<br>=C2=
=A0Processing drivers/net/intel/idpf/meson.build<br>=C2=A0Processing driver=
s/net/txgbe/meson.build<br>=C2=A0Processing drivers/net/txgbe/base/meson.bu=
ild<br>=C2=A0Processing drivers/net/r8169/meson.build<br>=C2=A0Processing d=
rivers/net/vhost/meson.build<br>=C2=A0Processing drivers/net/hinic/meson.bu=
ild<br>=C2=A0Processing drivers/net/hinic/base/meson.build<br>=C2=A0Process=
ing drivers/net/nfp/meson.build<br>=C2=A0Processing drivers/net/mana/meson.=
build<br>=C2=A0Processing drivers/net/af_packet/meson.build<br>=C2=A0Proces=
sing drivers/net/axgbe/meson.build<br>=C2=A0Processing drivers/net/thunderx=
/meson.build<br>=C2=A0Processing drivers/net/thunderx/base/meson.build<br>=
=C2=A0Processing drivers/net/dpaa2/meson.build<br>=C2=A0Processing drivers/=
net/cnxk/meson.build<br>=C2=A0Processing drivers/net/enetc/meson.build<br>=
=C2=A0Processing drivers/net/ionic/meson.build<br>=C2=A0Processing drivers/=
net/mlx4/meson.build<br>=C2=A0Processing drivers/net/avp/meson.build<br>=C2=
=A0Processing drivers/net/af_xdp/meson.build<br>=C2=A0Processing drivers/ne=
t/mvpp2/meson.build<br>=C2=A0Processing drivers/net/octeontx/meson.build<br=
>=C2=A0Processing drivers/net/octeontx/base/meson.build<br>=C2=A0Processing=
 drivers/net/tap/meson.build<br>=C2=A0Processing drivers/net/tap/bpf/meson.=
build<br>=C2=A0Processing drivers/net/memif/meson.build<br>=C2=A0Processing=
 drivers/net/mlx5/meson.build<br>=C2=A0Processing drivers/net/mlx5/hws/meso=
n.build<br>=C2=A0Processing drivers/net/mlx5/linux/meson.build<br>=C2=A0Pro=
cessing drivers/net/mlx5/windows/meson.build<br>=C2=A0Processing drivers/ne=
t/ena/meson.build<br>=C2=A0Processing drivers/net/cxgbe/meson.build<br>=C2=
=A0Processing drivers/net/enic/meson.build<br>=C2=A0Processing drivers/net/=
ntnic/meson.build<br>=C2=A0Processing drivers/net/dpaa/meson.build<br>=C2=
=A0Processing drivers/net/nfb/meson.build<br>=C2=A0Processing drivers/net/s=
oftnic/meson.build<br>=C2=A0Processing drivers/net/bnxt/meson.build<br>=C2=
=A0Processing drivers/net/bnxt/tf_ulp/meson.build<br>=C2=A0Processing drive=
rs/net/bnxt/tf_ulp/generic_templates/meson.build<br>=C2=A0Processing driver=
s/net/bnxt/hcapi/cfa_v3/meson.build<br>=C2=A0Processing drivers/net/bnxt/hc=
api/cfa/meson.build<br>=C2=A0Processing drivers/net/bnxt/tf_core/meson.buil=
d<br>=C2=A0Processing drivers/net/bnxt/tf_core/v3/meson.build<br>=C2=A0Proc=
essing drivers/net/ring/meson.build<br>=C2=A0Processing drivers/net/enetfec=
/meson.build<br>=C2=A0Processing drivers/net/null/meson.build<br>=C2=A0Proc=
essing drivers/net/octeon_ep/meson.build<br>=C2=A0Processing drivers/net/vd=
ev_netvsc/meson.build<br>=C2=A0Processing drivers/net/pfe/meson.build<br>=
=C2=A0Processing drivers/net/pcap/meson.build<br>=C2=A0Processing drivers/n=
et/hns3/meson.build<br>=C2=A0Processing drivers/net/mvneta/meson.build<br>=
=C2=A0Processing drivers/net/atlantic/meson.build<br>=C2=A0Processing drive=
rs/net/virtio/meson.build<br>=C2=A0Processing drivers/net/bonding/meson.bui=
ld<br>=C2=A0Processing drivers/net/ark/meson.build<br>=C2=A0Processing driv=
ers/net/vmxnet3/meson.build<br>=C2=A0Processing drivers/power/meson.build<b=
r>=C2=A0Processing drivers/power/acpi/meson.build<br>=C2=A0Processing drive=
rs/power/intel_pstate/meson.build<br>=C2=A0Processing drivers/power/amd_unc=
ore/meson.build<br>=C2=A0Processing drivers/power/amd_pstate/meson.build<br=
>=C2=A0Processing drivers/power/kvm_vm/meson.build<br>=C2=A0Processing driv=
ers/power/cppc/meson.build<br>=C2=A0Processing drivers/power/intel_uncore/m=
eson.build<br>=C2=A0Processing drivers/raw/meson.build<br>=C2=A0Processing =
drivers/raw/cnxk_bphy/meson.build<br>=C2=A0Processing drivers/raw/gdtc/meso=
n.build<br>=C2=A0Processing drivers/raw/ifpga/meson.build<br>=C2=A0Processi=
ng drivers/raw/ifpga/base/meson.build<br>=C2=A0Processing drivers/raw/dpaa2=
_cmdif/meson.build<br>=C2=A0Processing drivers/raw/cnxk_gpio/meson.build<br=
>=C2=A0Processing drivers/raw/cnxk_rvu_lf/meson.build<br>=C2=A0Processing d=
rivers/raw/ntb/meson.build<br>=C2=A0Processing drivers/raw/skeleton/meson.b=
uild<br>=C2=A0Processing drivers/baseband/meson.build<br>=C2=A0Processing d=
rivers/baseband/fpga_5gnr_fec/meson.build<br>=C2=A0Processing drivers/baseb=
and/fpga_lte_fec/meson.build<br>=C2=A0Processing drivers/baseband/la12xx/me=
son.build<br>=C2=A0Processing drivers/baseband/acc/meson.build<br>=C2=A0Pro=
cessing drivers/baseband/null/meson.build<br>=C2=A0Processing drivers/baseb=
and/turbo_sw/meson.build<br>=C2=A0Processing lib/meson.build<br>=C2=A0Proce=
ssing lib/bpf/meson.build<br>=C2=A0Processing lib/latencystats/meson.build<=
br>=C2=A0Processing lib/bbdev/meson.build<br>=C2=A0Processing lib/distribut=
or/meson.build<br>=C2=A0Processing lib/eal/meson.build<br>=C2=A0Processing =
lib/eal/arm/meson.build<br>=C2=A0Processing lib/eal/arm/include/meson.build=
<br>=C2=A0Processing lib/eal/freebsd/meson.build<br>=C2=A0Processing lib/ea=
l/freebsd/include/meson.build<br>=C2=A0Processing lib/eal/common/meson.buil=
d<br>=C2=A0Processing lib/eal/include/meson.build<br>=C2=A0Processing lib/e=
al/linux/meson.build<br>=C2=A0Processing lib/eal/linux/include/meson.build<=
br>=C2=A0Processing lib/eal/riscv/meson.build<br>=C2=A0Processing lib/eal/r=
iscv/include/meson.build<br>=C2=A0Processing lib/eal/unix/meson.build<br>=
=C2=A0Processing lib/eal/windows/meson.build<br>=C2=A0Processing lib/eal/wi=
ndows/include/meson.build<br>=C2=A0Processing lib/eal/ppc/meson.build<br>=
=C2=A0Processing lib/eal/ppc/include/meson.build<br>=C2=A0Processing lib/ea=
l/x86/meson.build<br>=C2=A0Processing lib/eal/x86/include/meson.build<br>=
=C2=A0Processing lib/eal/loongarch/meson.build<br>=C2=A0Processing lib/eal/=
loongarch/include/meson.build<br>=C2=A0Processing lib/member/meson.build<br=
>=C2=A0Processing lib/rawdev/meson.build<br>=C2=A0Processing lib/gro/meson.=
build<br>=C2=A0Processing lib/fib/meson.build<br>=C2=A0Processing lib/vhost=
/meson.build<br>=C2=A0Error: Incorrect indent at lib/vhost/meson.build:23<b=
r>=C2=A0Error: Incorrect indent at lib/vhost/meson.build:24<br>=C2=A0Proces=
sing lib/argparse/meson.build<br>=C2=A0Processing lib/node/meson.build<br>=
=C2=A0Processing lib/kvargs/meson.build<br>=C2=A0Processing lib/mempool/mes=
on.build<br>=C2=A0Processing lib/pdcp/meson.build<br>=C2=A0Processing lib/p=
tr_compress/meson.build<br>=C2=A0Processing lib/mldev/meson.build<br>=C2=A0=
Processing lib/rib/meson.build<br>=C2=A0Processing lib/regexdev/meson.build=
<br>=C2=A0Processing lib/ip_frag/meson.build<br>=C2=A0Processing lib/bitrat=
estats/meson.build<br>=C2=A0Processing lib/hash/meson.build<br>=C2=A0Proces=
sing lib/sched/meson.build<br>=C2=A0Processing lib/eventdev/meson.build<br>=
=C2=A0Processing lib/efd/meson.build<br>=C2=A0Processing lib/meter/meson.bu=
ild<br>=C2=A0Processing lib/rcu/meson.build<br>=C2=A0Processing lib/pipelin=
e/meson.build<br>=C2=A0Processing lib/cmdline/meson.build<br>=C2=A0Processi=
ng lib/acl/meson.build<br>=C2=A0Processing lib/jobstats/meson.build<br>=C2=
=A0Processing lib/log/meson.build<br>=C2=A0Processing lib/table/meson.build=
<br>=C2=A0Processing lib/pcapng/meson.build<br>=C2=A0Processing lib/port/me=
son.build<br>=C2=A0Processing lib/ethdev/meson.build<br>=C2=A0Processing li=
b/dmadev/meson.build<br>=C2=A0Processing lib/ipsec/meson.build<br>=C2=A0Pro=
cessing lib/ring/meson.build<br>=C2=A0Processing lib/gpudev/meson.build<br>=
=C2=A0Processing lib/cryptodev/meson.build<br>=C2=A0Processing lib/pci/meso=
n.build<br>=C2=A0Processing lib/cfgfile/meson.build<br>=C2=A0Processing lib=
/net/meson.build<br>=C2=A0Processing lib/dispatcher/meson.build<br>=C2=A0Pr=
ocessing lib/reorder/meson.build<br>=C2=A0Processing lib/power/meson.build<=
br>=C2=A0Processing lib/graph/meson.build<br>=C2=A0Processing lib/timer/mes=
on.build<br>=C2=A0Processing lib/stack/meson.build<br>=C2=A0Processing lib/=
compressdev/meson.build<br>=C2=A0Processing lib/metrics/meson.build<br>=C2=
=A0Processing lib/telemetry/meson.build<br>=C2=A0Processing lib/gso/meson.b=
uild<br>=C2=A0Processing lib/lpm/meson.build<br>=C2=A0Processing lib/securi=
ty/meson.build<br>=C2=A0Processing lib/pdump/meson.build<br>=C2=A0Processin=
g lib/mbuf/meson.build</div></div></div>

--000000000000a51173062d52d935--
