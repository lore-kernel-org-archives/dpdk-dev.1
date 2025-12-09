Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9AAD3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 09:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E927F40270;
	Tue,  9 Dec 2025 10:23:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7DC434025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 10:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765272212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2oFWSLnbDo4LnzOPY4dumgNryfDq99iz8pguYtPxySk=;
 b=XqkaOMdUmNLMtM7Z1b0SKe3ZETWZhwLvyZLhk88JM7v1fH8T/FcvFylkNPqdC+pIpn2Pgv
 KE+HxtjBcfYBimqzD+ywCTV1e0aMPH0l4Xo4/Cmu7ysjEjN4WRhhmH9HCz7IMFPZRAYz08
 QvnlFUAIwWaR66tGMRNFTVf4ZmKawYo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-YiiUfV0gOsOpp3uAVe4UiQ-1; Tue, 09 Dec 2025 04:23:20 -0500
X-MC-Unique: YiiUfV0gOsOpp3uAVe4UiQ-1
X-Mimecast-MFC-AGG-ID: YiiUfV0gOsOpp3uAVe4UiQ_1765272200
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-3ec31d72794so11855956fac.0
 for <dev@dpdk.org>; Tue, 09 Dec 2025 01:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765272200; x=1765877000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2oFWSLnbDo4LnzOPY4dumgNryfDq99iz8pguYtPxySk=;
 b=j/bUo5UcfrORywwu8+W3gdV6PQ2SQT0Xq6Kse4IwDJ/ArM4WSwzC5vRp7RCwi/WLeX
 +wF5I+yNkkyi35nyVDImkbayFp5gnqJlm0DazXI9qDD/QXg5ZRnl1SlsMwt9kEB+fGBj
 i9Gkv6SqgzJa4WSRGf8DcPGW9xzuAdgkaGuqFNLfbdbAUNMQeEEtMY/O39ADM4DjxsIj
 q3L6p1CqPKhnFcPX6aVOGN1aXvHcnhkodw+jvuvRR4fsf+bLI709R1okWKG0TsbJLct8
 /mvYtZ5DwIdiEINLZc60j8141mP+AOZQKeAB0+ldzsj9h+xjthHZ3eh7a0taQaxKgpGr
 QltQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj39fvDxGDYbfSyTjlBTSv5lLJP1j2SYO3pvHyEgxMGHnnp4efAzwhj2U3PElYgmIf1zI=@dpdk.org
X-Gm-Message-State: AOJu0Yyy9D7K6+PSLrCbhkNkHvqPCDEHOSe8Bn+5MfGMtbmAHC8gvtOr
 iJh/XozYYF8qHurTr/sORLZF9ViBa3Gvf4+9m4maF66Ra8rtwzCCqI4BNikKPQLj2OkMAivYDci
 9SZp5jIfXWrT8a+GhrUQbjg5jWra+pcr9mTQ3d2w7HzFpA0agxnDlnJvLPgd2uxWgV2LYcbURzi
 08AuYWDMFXfdw6vaDKbtQ=
X-Gm-Gg: ASbGncuG0crLjYXRm6NjDuvJHur4ZvqpADAXeDCBTZH5FkbQhVnyYHdvYBBJYLcy3Yl
 W4v+FPGS+CeVlqi12hmMIlVjdbxxlWfj0HlwYE5Wjdi9vpRx9EaWfRxl3dgoJZDYmVtdcnlOngc
 nHMb6VtX6frjmBNtwYvBciBGkDnnbUpFrANHuAdEqvs7NlFDCtLtMYtROGRGc6n4Xu6tw=
X-Received: by 2002:a05:6820:180b:b0:659:9a49:8edb with SMTP id
 006d021491bc7-65b238330a3mr234139eaf.15.1765272199602; 
 Tue, 09 Dec 2025 01:23:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv+HGE7GIzZr3Mn39knFsYGDejfAsQUziA6Bbhk46MfBPejNeOgmqiE98ZBro1ViEb32cPMD08kMckYlR6tnA=
X-Received: by 2002:a05:6820:180b:b0:659:9a49:8edb with SMTP id
 006d021491bc7-65b238330a3mr234116eaf.15.1765272199020; Tue, 09 Dec 2025
 01:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20251205095931.160577-1-ktraynor@redhat.com>
In-Reply-To: <20251205095931.160577-1-ktraynor@redhat.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Tue, 9 Dec 2025 17:23:07 +0800
X-Gm-Features: AQt7F2rV-8uRa4q04XKyLsb4otzvJWH079IrneWk6z00Nmj28CTP6N8U7-vYirY
Message-ID: <CAGYh1E_NSVmawQ=sWeivv+k_4svT2odeypr9-u_=n4kt=gdcmw@mail.gmail.com>
Subject: Re: 24.11.4 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, 
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>, 
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZfQiW6Vsu3ISFx2UopgM6xTu60Ru43se2J2KMU60c-w_1765272200
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000005ad8470645817646"
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

--0000000000005ad8470645817646
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested below 18 scenarios on RHEL 9.4 host and didn't find any new dpdk
issues.

   - VM with device assignment(PF) throughput testing(1G hugepage size):
   PASS
   - VM with device assignment(PF) throughput testing(2M hugepage size) :
   PASS
   - VM with device assignment(VF) throughput testing: PASS
   - PVP (host dpdk testpmd as vswitch) 1Q: throughput testing: PASS
   - PVP vhost-user 2Q throughput testing: PASS
   - PVP vhost-user 1Q - cross numa node throughput testing: PASS
   - VM with vhost-user 2 queues throughput testing: PASS
   - vhost-user reconnect with dpdk-client, qemu-server(qemu reconnect):
   PASS
   - vhost-user reconnect with dpdk-client, qemu-server(ovs reconnect): PAS=
S
   - PVP  reconnect with dpdk-client, qemu-server: PASS
   - PVP 1Q live migration testing: PASS
   - PVP 1Q cross numa node live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 1Q live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 1Q live migration testing (2M): PASS
   - VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS
   - VM with ovs+dpdk+vhost-user 4Q live migration testing: PASS
   - Host PF + DPDK testing: PASS
   - Host VF + DPDK testing: PASS

Test Versions:

   - qemu-kvm-8.2.0
   - kernel 5.14
   - libvirt 10.0
   - ovs 3.3
   - git describe
      - v24.11.4-rc1


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>

Best Regards,
Yanghang Liu


On Fri, Dec 5, 2025 at 5:59=E2=80=AFPM Kevin Traynor <ktraynor@redhat.com> =
wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.4.
>
> The planned date for the final release is 18th December.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.11.4-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Kevin
>
> ---
> Aarnav JP (4):
>       common/cnxk: fix format specifier for bandwidth profile ID
>       common/cnxk: fix NIX Rx inject enabling
>       net/cnxk: fix Rx inject LF
>       net/cnxk: fix default meter pre-color
>
> Adrian Schollmeyer (1):
>       net/mlx5: store MTU at Rx queue allocation time
>
> Amiya Ranjan Mohakud (1):
>       net/vmxnet3: disable RSS for single queue for ESX8.0+
>
> Anatoly Burakov (5):
>       net/ice: remove indirection for FDIR filters
>       net/ice: fix memory leak in raw pattern parse
>       bus/pci: fix resource leak in secondary process
>       bus/cdx: fix device name in probing error message
>       bus/cdx: fix release in probing for secondary process
>
> Andrew Boyer (1):
>       doc: add Pollara 400 device in ionic guide
>
> Andrzej Wilczynski (1):
>       net/ixgbe/base: fix PF link state request size
>
> Anurag Mandal (1):
>       net/i40e: fix symmetric Toeplitz hashing for SCTP
>
> Ashok Kaladi (1):
>       net/tap: fix BPF with cross-compilation
>
> Bing Zhao (2):
>       app/flow-perf: fix rules array length
>       net/mlx5: move auxiliary data inline
>
> Brick Yang (2):
>       net/dpaa2: fix L3/L4 checksum results
>       net/dpaa2: receive packets with additional parse errors
>
> Bruce Richardson (11):
>       net/intel: fix assumption about tag placement order
>       net/ice: fix VLAN tag reporting on Rx
>       test/func_reentrancy: fix args to EAL init call
>       doc: fix display of commands in cpfl guide
>       net/ice: fix initialization with 8 ports
>       ethdev: fix VLAN filter parameter description
>       net/ice: fix vector Rx VLAN offload flags
>       net/fm10k: fix build with GCC 16
>       app/pdump: remove hard-coded memory channels
>       telemetry: make socket handler typedef private
>       net/ice: fix path selection for QinQ Tx offload
>
> Chengwen Feng (9):
>       dma/hisilicon: fix stop with pending transfers
>       test/dma: fix failure condition
>       net/hns3: fix overwrite mbuf in vector path
>       app/dma-perf: fix use after free
>       app/dma-perf: check buffer size
>       app/testpmd: fix DCB Tx port
>       app/testpmd: fix DCB Rx queues
>       app/dma-perf: fix on-flight DMA when verifying data
>       app/dma-perf: fix stopping device
>
> Chinh Cao (1):
>       net/ice/base: fix integer overflow on NVM init
>
> Christophe Fontaine (2):
>       graph: fix xstats description allocation
>       net: fix IPv6 link local compliance with RFC 4291
>
> Ciara Loftus (6):
>       net/iavf: fix Tx vector path selection logic
>       doc: fix feature list of ice driver
>       doc: fix feature list of iavf driver
>       net/ice: remove unsupported SCTP Rx offload
>       net/e1000/base: fix crash on init with GCC 13
>       net/idpf: fix queue setup with TSO offload
>
> Dariusz Sosnowski (8):
>       app/testpmd: fix conntrack action query
>       net/mlx5/hws: fix TIR action support in FDB
>       net/mlx5: fix indirect flow age action handling
>       net/mlx5: fix Direct Verbs counter offset detection
>       net/mlx5: fix min and max MTU reporting
>       net/mlx5: fix indirect RSS action hash
>       net/mlx5: fix error reporting on masked indirect actions
>       net/mlx5: fix flow tag indexes support on root table
>
> David Marchand (22):
>       test/telemetry: fix test calling all commands
>       eal: fix plugin dir walk
>       cmdline: fix port list parsing
>       tailq: fix lookup macro
>       hash: fix unaligned access in predictable RSS
>       graph: fix unaligned access in stats
>       eventdev: fix listing timer adapters with telemetry
>       eal/arm: fix C++ build for 32-bit memcpy
>       test/debug: fix crash with mlx5 devices
>       net/tap: fix build with LTO
>       cmdline: fix highest bit port list parsing
>       eventdev/crypto: fix build with clang 21
>       rawdev: fix build with clang 21
>       vhost: fix external buffer in VDUSE
>       net/dpaa2: remove ethdev pointer from bus device
>       bus/ifpga: fix const pointer in device name parsing
>       bus/uacce: fix const pointer in device matching
>       common/qat: fix some const pointers
>       crypto/caam_jr: fix const pointer in UIO filename parsing
>       net/enetfec: fix const pointer in UIO filename parsing
>       net/memif: fix const pointer in socket check
>       app/procinfo: fix const pointer in collectd format
>
> Dean Marx (2):
>       dts: fix docstring in checksum suite
>       dts: add reception check to checksum suite
>
> Dengdui Huang (4):
>       app/testpmd: increase size of set cores list command
>       net/hns3: fix inconsistent lock
>       net/hns3: fix VLAN resources freeing
>       net: fix L2 length for GRE packets
>
> Emma Finn (1):
>       crypto/qat: fix CCM request descriptor hash state size
>
> Gagandeep Singh (2):
>       bus/dpaa: improve cleanup
>       net/dpaa2: fix shaper rate
>
> Gavin Li (2):
>       net/mlx5: fix multicast
>       net/mlx5: fix IPv6 DSCP offset in HWS sync API
>
> Gowrishankar Muthukrishnan (1):
>       crypto/virtio: fix cookies leak
>
> Gregory Etelson (7):
>       net/mlx5: fix storage of shared Rx queues
>       net/mlx5: fix non-template RSS expansion
>       net/mlx5: fix interface name parameter definition
>       net/mlx4: fix unnecessary comma
>       net/mlx5: fix unnecessary commas
>       net/mlx5: fix external queues access
>       net/mlx5: fix send to kernel action resources release
>
> Hemant Agrawal (8):
>       net/enetfec: fix file descriptor leak on read error
>       net/enetfec: fix buffer descriptor size configuration
>       net/enetfec: fix Tx queue free
>       net/enetfec: fix checksum flag handling and error return
>       net/enetfec: reject multi-queue configuration
>       net/enetfec: fix memory leak in Rx buffer cleanup
>       net/enetfec: reject Tx deferred queue
>       net/dpaa2: fix duplicate call of close
>
> Itai Sharoni (1):
>       net/mlx5/windows: fix match criteria in flow creation
>
> Itamar Gozlan (1):
>       net/mlx5/hws: fix flow rule hash capability
>
> Jacob Keller (2):
>       net/ice/base: fix memory leak in HW profile handling
>       net/iavf: fix Rx timestamp validity check
>
> Jasper Tran O'Leary (1):
>       net/gve: free device resources on close
>
> Jerin Jacob (4):
>       net/iavf: fix build with clang 21
>       test: fix build with clang 21
>       app/eventdev: fix build with clang 21
>       lib: fix backticks matching in Doxygen comments
>
> Jiawen Wu (16):
>       net/txgbe: fix checksum error counter
>       net/ngbe: fix checksum error counter
>       net/txgbe: reduce memory size of ring descriptors
>       net/ngbe: reduce memory size of ring descriptors
>       net/txgbe: fix VF Rx buffer size in config register
>       net/txgbe: remove duplicate Tx queue assignment
>       net/txgbe: add device arguments for FDIR
>       net/txgbe: fix maximum number of FDIR filters
>       net/txgbe: fix FDIR mode clearing
>       net/txgbe: fix FDIR drop action for L4 match packets
>       net/txgbe: fix FDIR filter for SCTP tunnel
>       net/txgbe: filter FDIR match flex bytes for tunnel
>       net/txgbe: fix FDIR rule raw relative for L3 packets
>       net/txgbe: fix FDIR input mask
>       net/txgbe: switch to FDIR when ntuple filter is full
>       net/txgbe: remove unsupported flow action mark
>
> John Miller (1):
>       net/ark: remove double mbuf free
>
> Joshua Washington (9):
>       net/gve: send whole packet when mbuf is large
>       net/gve: clean when insufficient Tx descriptors
>       net/gve: do not write zero-length descriptors
>       net/gve: validate Tx packet before sending
>       net/gve: add DQO Tx descriptor limit
>       net/gve: fix DQO TSO descriptor limit
>       net/gve: clear DQO Tx descriptors before writing
>       net/gve: fix disabling interrupts on DQ
>       net/gve: free Rx mbufs if allocation fails on ring setup
>
> Jun Yang (3):
>       net/dpaa2: fix extract buffer preparation
>       net/dpaa2: fix error frame dump
>       net/dpaa2: fix flow rule resizing
>
> Junlong Wang (1):
>       net/zxdh: fix Arm build
>
> Kerem Aksu (1):
>       net/af_packet: fix crash in secondary process
>
> Kevin Traynor (1):
>       doc: fix NVIDIA bifurcated driver presentation link
>
> Khadem Ullah (5):
>       app/testpmd: monitor state of primary process
>       doc: add conntrack state inspect command to testpmd guide
>       app/testpmd: validate DSCP and VLAN for meter creation
>       net/mlx5: fix connection tracking state item validation
>       app/testpmd: stop forwarding in secondary process
>
> Luca Boccassi (1):
>       test/debug: fix IOVA mode on PPC64 without huge pages
>
> Maayan Kashani (12):
>       app/testpmd: fix mask in flow random item
>       net/mlx5: fix index-based flow rules
>       net/mlx5: fix default flow rules start
>       net/mlx5: fix use after scope of RSS configuration
>       net/mlx5: fix unsupported flow rule port action
>       net/mlx5: fix double free in non-template flow destroy
>       net/mlx5: fix non-template age rules flush
>       net/mlx5: fix flow encapsulation hash
>       net/mlx5: fix modify field action restriction
>       app/testpmd: fix flex item link parsing
>       net/mlx5: fix crash on flow rule destruction
>       net/mlx5: fix device start error handling
>
> Marat Khalili (1):
>       graph: fix stats query with no node xstats
>
> Mattias R=C3=B6nnblom (1):
>       bitops: improve power of 2 alignment documentation
>
> Maxime Coquelin (3):
>       vhost: add VDUSE virtqueue ready state polling workaround
>       vhost: fix virtqueue info init in VDUSE vring setup
>       net/virtio-user: fix used ring address calculation
>
> Maxime Leroy (1):
>       net/dpaa2: clear active VDQ state when freeing Rx queues
>
> Megha Ajmera (1):
>       sched: fix WRR parameter data type
>
> Michael Baum (1):
>       net/mlx5: fix multi-process Tx default rules
>
> Nithinsen Kaithakadan (1):
>       test/crypto: fix mbuf handling
>
> Nupur Uttarwar (2):
>       net/mlx5/hws: fix buddy memory allocation
>       net/mlx5: skip Rx control flow tables in isolated mode
>
> Pandi Kumar Maharajan (1):
>       net/ice/base: fix memory leak in recipe handling
>
> Prashant Gupta (2):
>       net/dpaa2: fix uninitialized variable
>       net/dpaa2: free buffers from error queue
>
> Radu Nicolau (3):
>       crypto/qat: fix ECDH
>       crypto/qat: fix source buffer alignment
>       test/crypto: fix vector initialization
>
> Robin Jarry (4):
>       net/tap: fix interrupt callback crash after failed start
>       buildtools/pmdinfogen: fix warning with python 3.14
>       graph: fix updating edge with active graph
>       usertools/telemetry: fix exporter default IP binding
>
> Roi Dayan (3):
>       net/mlx5: fix leak of flow indexed pools
>       net/mlx5: release representor interrupt handler
>       common/mlx5: release unused mempool entries
>
> Ronak Doshi (1):
>       net/vmxnet3: fix mapping of mempools to queues
>
> Rongwei Liu (5):
>       net/mlx5: fix indirect flow action memory leak
>       net/mlx5: fix flow aging race condition
>       net/mlx5: remove counter alignment
>       net/mlx5: fix meter mark allocation
>       net/mlx5: fix indirect meter index leak
>
> Satha Rao (1):
>       common/cnxk: fix null SQ access
>
> Serhii Iliushyk (1):
>       net/ntnic: fix potential format overflow
>
> Shai Brandes (2):
>       net/ena: fix PCI BAR mapping on 64K page size
>       net/ena/base: fix unsafe memcpy on invalid memory
>
> Shaiq Wani (1):
>       net/ice/base: fix adding special words
>
> Shani Peretz (6):
>       eal: fix DMA mask validation with IOVA mode option
>       net/mlx5: fix MTU initialization
>       app/crypto-perf: fix plaintext size exceeds buffer size
>       net/bonding: fix MAC address propagation in 802.3ad mode
>       net/mlx5: fix null dereference in modify header
>       net/mlx5: fix Tx metadata pattern template mismatch
>
> Sivaprasad Tummala (4):
>       eal/x86: enable timeout in AMD power monitor
>       examples/l3fwd-power: fix telemetry command registration
>       net/mlx5: fix spurious CPU wakeups
>       examples/l3fwd: add Tx burst size configuration option
>
> Stephen Hemminger (9):
>       net/bnxt: fix free of not allocated object
>       test/argparse: change initialization to workaround LTO
>       dmadev: fix debug build with tracepoints
>       net/nfp: fix metering cleanup
>       pdump: handle primary process exit
>       net/mlx5: fix uninitialized variable
>       examples/server_node_efd: fix format overflow
>       examples/vdpa: fix format overflow
>       bus/fslmc: fix const pointer in device name parsing
>
> Sucharitha Sarananaga (1):
>       crypto/cnxk: refactor RSA verification
>
> Sunil Kumar Kori (1):
>       common/cnxk: fix max number of SQB buffers in clean up
>
> Tathagat Priyadarshi (1):
>       gro: fix payload corruption in coalescing packets
>
> Thierry Herbelot (1):
>       config/arm: enable NUMA for Neoverse N2
>
> Thomas Monjalon (12):
>       efd: fix AVX2 support
>       bus/pci: fix build with MinGW 13
>       net/mlx5: fix build with MinGW 13
>       bbdev: fix build with MinGW 13
>       test/hash: check memory allocation
>       vdpa/mlx5: remove unused constant
>       crypto/mlx5: remove unused constants
>       regex/mlx5: remove useless constants
>       common/mlx5: remove useless constants
>       net/mlx5: remove useless constants
>       net/mlx5: remove unused macros
>       doc: fix note in FreeBSD guide
>
> Tomasz Duszynski (1):
>       common/cnxk: fix async event handling
>
> Vamsi Attunuru (3):
>       net/octeon_ep: handle interrupt enable failure
>       net/octeon_ep: fix mbuf data offset update
>       net/octeon_ep: fix device start
>
> Vanshika Shukla (2):
>       net/enetfec: fix out-of-bounds access in UIO mapping
>       net/dpaa: fix resource leak
>
> Venkat Kumar Ande (1):
>       net/axgbe: fix build with GCC 16
>
> Viacheslav Ovsiienko (4):
>       net/mlx5: fix ESP item validation to match on seqnum
>       net/mlx5: fix ESP header match after UDP for group 0
>       net/mlx5/hws: fix ESP header match in strict mode
>       net/mlx5: fix flex flow item header length
>
> Vladimir Medvedkin (2):
>       fib6: fix memory leak on delete operation
>       fib6: fix tbl8 allocation check logic
>
> Wathsala Vithanage (4):
>       mcslock: fix memory ordering
>       ring: establish safe partial order in default mode
>       ring: establish a safe partial order in hts-ring
>       ring: establish safe partial order in RTS mode
>
> Xingui Yang (1):
>       net/hns3: fix VLAN tag loss for short tunnel frame
>
> Yang Ming (2):
>       eal: fix MP socket cleanup
>       crypto/ipsec_mb: fix QP release in secondary
>
> Yuan Wang (1):
>       net/ixgbe: fix SCTP port filtering on E610
>
> Yunjian Wang (1):
>       vhost: fix double fetch when dequeue offloading
>
> Zhichao Zeng (1):
>       net/ice: fix statistics
>
>

--0000000000005ad8470645817646
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font =
face=3D"arial, sans-serif">I tested below 18 scenarios on RHEL 9.4 host and=
 didn&#39;t find any new dpdk issues.</font></div><div dir=3D"ltr"><ul><li =
style=3D"margin-left:15px">VM with device assignment(PF) throughput testing=
(1G hugepage size): PASS</li><li style=3D"margin-left:15px">VM with device =
assignment(PF) throughput testing(2M hugepage size) : PASS</li><li style=3D=
"margin-left:15px">VM with device assignment(VF) throughput testing: PASS</=
li><li style=3D"margin-left:15px">PVP (host dpdk testpmd as vswitch) 1Q: th=
roughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-user 2Q=
 throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-user=
 1Q - cross numa node throughput testing: PASS</li><li style=3D"margin-left=
:15px">VM with vhost-user 2 queues throughput testing: PASS</li><li style=
=3D"margin-left:15px">vhost-user reconnect with dpdk-client, qemu-server(qe=
mu reconnect): PASS</li><li style=3D"margin-left:15px">vhost-user reconnect=
 with dpdk-client, qemu-server(ovs reconnect): PASS</li><li style=3D"margin=
-left:15px">PVP =C2=A0reconnect with dpdk-client, qemu-server: PASS</li><li=
 style=3D"margin-left:15px">PVP 1Q live migration testing: PASS</li><li sty=
le=3D"margin-left:15px">PVP 1Q cross numa node live migration testing: PASS=
</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1Q live mig=
ration testing: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vh=
ost-user 1Q live migration testing (2M): PASS</li><li style=3D"margin-left:=
15px">VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS</li><li s=
tyle=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 4Q live migration tes=
ting: PASS</li><li style=3D"margin-left:15px">Host PF + DPDK testing: PASS<=
/li><li style=3D"margin-left:15px">Host VF + DPDK testing: PASS</li></ul></=
div><div><font face=3D"arial, sans-serif">Test Versions:<br><ul><li style=
=3D"margin-left:15px">qemu-kvm-8.2.0</li><li style=3D"margin-left:15px">ker=
nel 5.14</li><li style=3D"margin-left:15px">libvirt 10.0</li><li style=3D"m=
argin-left:15px">ovs 3.3</li><li style=3D"margin-left:15px">git describe</l=
i><ul><li style=3D"margin-left:15px">v24.11.4-rc1</li></ul></ul></font></di=
v></div></div></div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"=
ltr"><div dir=3D"ltr" class=3D"gmail_signature"><font face=3D"arial, sans-s=
erif"><ul><li style=3D"margin-left:15px">Test device : X540-AT2 NIC(ixgbe, =
10G)</li></ul></font></div></div></div><div dir=3D"ltr" class=3D"gmail_sign=
ature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div><font face=3D"arial, sans-serif">Tested-by: Yanghang Liu &lt;=
<a href=3D"mailto:yanghliu@redhat.com" target=3D"_blank">yanghliu@redhat.co=
m</a>&gt;</font></div></div></div></div></div></div><div><br></div><div><di=
v dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">=
<div dir=3D"ltr"><div>Best Regards,</div><div>Yanghang Liu<br></div></div><=
/div></div><br></div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 5, 2025 at 5:59=E2=80=AFPM=
 Kevin Traynor &lt;<a href=3D"mailto:ktraynor@redhat.com">ktraynor@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Hi all,<br>
<br>
Here is a list of patches targeted for stable release 24.11.4.<br>
<br>
The planned date for the final release is 18th December.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.=
11.4-rc1" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpdk=
-stable/tag/?id=3Dv24.11.4-rc1</a><br>
<br>
These patches are located at branch 24.11 of dpdk-stable repo:<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/" rel=3D"noref=
errer" target=3D"_blank">https://dpdk.org/browse/dpdk-stable/</a><br>
<br>
Thanks.<br>
<br>
Kevin<br>
<br>
---<br>
Aarnav JP (4):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix format specifier for bandwidth profil=
e ID<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix NIX Rx inject enabling<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix Rx inject LF<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix default meter pre-color<br>
<br>
Adrian Schollmeyer (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: store MTU at Rx queue allocation time<br>
<br>
Amiya Ranjan Mohakud (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/vmxnet3: disable RSS for single queue for ESX8.0+<=
br>
<br>
Anatoly Burakov (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: remove indirection for FDIR filters<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix memory leak in raw pattern parse<br>
=C2=A0 =C2=A0 =C2=A0 bus/pci: fix resource leak in secondary process<br>
=C2=A0 =C2=A0 =C2=A0 bus/cdx: fix device name in probing error message<br>
=C2=A0 =C2=A0 =C2=A0 bus/cdx: fix release in probing for secondary process<=
br>
<br>
Andrew Boyer (1):<br>
=C2=A0 =C2=A0 =C2=A0 doc: add Pollara 400 device in ionic guide<br>
<br>
Andrzej Wilczynski (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: fix PF link state request size<br>
<br>
Anurag Mandal (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e: fix symmetric Toeplitz hashing for SCTP<br>
<br>
Ashok Kaladi (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/tap: fix BPF with cross-compilation<br>
<br>
Bing Zhao (2):<br>
=C2=A0 =C2=A0 =C2=A0 app/flow-perf: fix rules array length<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: move auxiliary data inline<br>
<br>
Brick Yang (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix L3/L4 checksum results<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: receive packets with additional parse error=
s<br>
<br>
Bruce Richardson (11):<br>
=C2=A0 =C2=A0 =C2=A0 net/intel: fix assumption about tag placement order<br=
>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix VLAN tag reporting on Rx<br>
=C2=A0 =C2=A0 =C2=A0 test/func_reentrancy: fix args to EAL init call<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix display of commands in cpfl guide<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix initialization with 8 ports<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix VLAN filter parameter description<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix vector Rx VLAN offload flags<br>
=C2=A0 =C2=A0 =C2=A0 net/fm10k: fix build with GCC 16<br>
=C2=A0 =C2=A0 =C2=A0 app/pdump: remove hard-coded memory channels<br>
=C2=A0 =C2=A0 =C2=A0 telemetry: make socket handler typedef private<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix path selection for QinQ Tx offload<br>
<br>
Chengwen Feng (9):<br>
=C2=A0 =C2=A0 =C2=A0 dma/hisilicon: fix stop with pending transfers<br>
=C2=A0 =C2=A0 =C2=A0 test/dma: fix failure condition<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix overwrite mbuf in vector path<br>
=C2=A0 =C2=A0 =C2=A0 app/dma-perf: fix use after free<br>
=C2=A0 =C2=A0 =C2=A0 app/dma-perf: check buffer size<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix DCB Tx port<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix DCB Rx queues<br>
=C2=A0 =C2=A0 =C2=A0 app/dma-perf: fix on-flight DMA when verifying data<br=
>
=C2=A0 =C2=A0 =C2=A0 app/dma-perf: fix stopping device<br>
<br>
Chinh Cao (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix integer overflow on NVM init<br>
<br>
Christophe Fontaine (2):<br>
=C2=A0 =C2=A0 =C2=A0 graph: fix xstats description allocation<br>
=C2=A0 =C2=A0 =C2=A0 net: fix IPv6 link local compliance with RFC 4291<br>
<br>
Ciara Loftus (6):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix Tx vector path selection logic<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature list of ice driver<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature list of iavf driver<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: remove unsupported SCTP Rx offload<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix crash on init with GCC 13<br>
=C2=A0 =C2=A0 =C2=A0 net/idpf: fix queue setup with TSO offload<br>
<br>
Dariusz Sosnowski (8):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix conntrack action query<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix TIR action support in FDB<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect flow age action handling<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix Direct Verbs counter offset detection<br=
>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix min and max MTU reporting<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect RSS action hash<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix error reporting on masked indirect actio=
ns<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flow tag indexes support on root table<b=
r>
<br>
David Marchand (22):<br>
=C2=A0 =C2=A0 =C2=A0 test/telemetry: fix test calling all commands<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix plugin dir walk<br>
=C2=A0 =C2=A0 =C2=A0 cmdline: fix port list parsing<br>
=C2=A0 =C2=A0 =C2=A0 tailq: fix lookup macro<br>
=C2=A0 =C2=A0 =C2=A0 hash: fix unaligned access in predictable RSS<br>
=C2=A0 =C2=A0 =C2=A0 graph: fix unaligned access in stats<br>
=C2=A0 =C2=A0 =C2=A0 eventdev: fix listing timer adapters with telemetry<br=
>
=C2=A0 =C2=A0 =C2=A0 eal/arm: fix C++ build for 32-bit memcpy<br>
=C2=A0 =C2=A0 =C2=A0 test/debug: fix crash with mlx5 devices<br>
=C2=A0 =C2=A0 =C2=A0 net/tap: fix build with LTO<br>
=C2=A0 =C2=A0 =C2=A0 cmdline: fix highest bit port list parsing<br>
=C2=A0 =C2=A0 =C2=A0 eventdev/crypto: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 rawdev: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix external buffer in VDUSE<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: remove ethdev pointer from bus device<br>
=C2=A0 =C2=A0 =C2=A0 bus/ifpga: fix const pointer in device name parsing<br=
>
=C2=A0 =C2=A0 =C2=A0 bus/uacce: fix const pointer in device matching<br>
=C2=A0 =C2=A0 =C2=A0 common/qat: fix some const pointers<br>
=C2=A0 =C2=A0 =C2=A0 crypto/caam_jr: fix const pointer in UIO filename pars=
ing<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix const pointer in UIO filename parsing=
<br>
=C2=A0 =C2=A0 =C2=A0 net/memif: fix const pointer in socket check<br>
=C2=A0 =C2=A0 =C2=A0 app/procinfo: fix const pointer in collectd format<br>
<br>
Dean Marx (2):<br>
=C2=A0 =C2=A0 =C2=A0 dts: fix docstring in checksum suite<br>
=C2=A0 =C2=A0 =C2=A0 dts: add reception check to checksum suite<br>
<br>
Dengdui Huang (4):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: increase size of set cores list command<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix inconsistent lock<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix VLAN resources freeing<br>
=C2=A0 =C2=A0 =C2=A0 net: fix L2 length for GRE packets<br>
<br>
Emma Finn (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix CCM request descriptor hash state size=
<br>
<br>
Gagandeep Singh (2):<br>
=C2=A0 =C2=A0 =C2=A0 bus/dpaa: improve cleanup<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix shaper rate<br>
<br>
Gavin Li (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix multicast<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix IPv6 DSCP offset in HWS sync API<br>
<br>
Gowrishankar Muthukrishnan (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix cookies leak<br>
<br>
Gregory Etelson (7):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix storage of shared Rx queues<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix non-template RSS expansion<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix interface name parameter definition<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx4: fix unnecessary comma<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix unnecessary commas<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix external queues access<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix send to kernel action resources release<=
br>
<br>
Hemant Agrawal (8):<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix file descriptor leak on read error<br=
>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix buffer descriptor size configuration<=
br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix Tx queue free<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix checksum flag handling and error retu=
rn<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: reject multi-queue configuration<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix memory leak in Rx buffer cleanup<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: reject Tx deferred queue<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix duplicate call of close<br>
<br>
Itai Sharoni (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/windows: fix match criteria in flow creation<=
br>
<br>
Itamar Gozlan (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix flow rule hash capability<br>
<br>
Jacob Keller (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix memory leak in HW profile handling<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix Rx timestamp validity check<br>
<br>
Jasper Tran O&#39;Leary (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: free device resources on close<br>
<br>
Jerin Jacob (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 test: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 app/eventdev: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 lib: fix backticks matching in Doxygen comments<br>
<br>
Jiawen Wu (16):<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix checksum error counter<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix checksum error counter<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: reduce memory size of ring descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: reduce memory size of ring descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix VF Rx buffer size in config register<br=
>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: remove duplicate Tx queue assignment<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: add device arguments for FDIR<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix maximum number of FDIR filters<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR mode clearing<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR drop action for L4 match packets<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR filter for SCTP tunnel<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: filter FDIR match flex bytes for tunnel<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR rule raw relative for L3 packets<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR input mask<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: switch to FDIR when ntuple filter is full<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: remove unsupported flow action mark<br>
<br>
John Miller (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ark: remove double mbuf free<br>
<br>
Joshua Washington (9):<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: send whole packet when mbuf is large<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: clean when insufficient Tx descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: do not write zero-length descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: validate Tx packet before sending<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: add DQO Tx descriptor limit<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: fix DQO TSO descriptor limit<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: clear DQO Tx descriptors before writing<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: fix disabling interrupts on DQ<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: free Rx mbufs if allocation fails on ring set=
up<br>
<br>
Jun Yang (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix extract buffer preparation<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix error frame dump<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix flow rule resizing<br>
<br>
Junlong Wang (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/zxdh: fix Arm build<br>
<br>
Kerem Aksu (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/af_packet: fix crash in secondary process<br>
<br>
Kevin Traynor (1):<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix NVIDIA bifurcated driver presentation link<br=
>
<br>
Khadem Ullah (5):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: monitor state of primary process<br>
=C2=A0 =C2=A0 =C2=A0 doc: add conntrack state inspect command to testpmd gu=
ide<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: validate DSCP and VLAN for meter creation=
<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix connection tracking state item validatio=
n<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: stop forwarding in secondary process<br>
<br>
Luca Boccassi (1):<br>
=C2=A0 =C2=A0 =C2=A0 test/debug: fix IOVA mode on PPC64 without huge pages<=
br>
<br>
Maayan Kashani (12):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix mask in flow random item<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix index-based flow rules<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix default flow rules start<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix use after scope of RSS configuration<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix unsupported flow rule port action<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix double free in non-template flow destroy=
<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix non-template age rules flush<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flow encapsulation hash<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix modify field action restriction<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix flex item link parsing<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix crash on flow rule destruction<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix device start error handling<br>
<br>
Marat Khalili (1):<br>
=C2=A0 =C2=A0 =C2=A0 graph: fix stats query with no node xstats<br>
<br>
Mattias R=C3=B6nnblom (1):<br>
=C2=A0 =C2=A0 =C2=A0 bitops: improve power of 2 alignment documentation<br>
<br>
Maxime Coquelin (3):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: add VDUSE virtqueue ready state polling workaro=
und<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix virtqueue info init in VDUSE vring setup<br=
>
=C2=A0 =C2=A0 =C2=A0 net/virtio-user: fix used ring address calculation<br>
<br>
Maxime Leroy (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: clear active VDQ state when freeing Rx queu=
es<br>
<br>
Megha Ajmera (1):<br>
=C2=A0 =C2=A0 =C2=A0 sched: fix WRR parameter data type<br>
<br>
Michael Baum (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix multi-process Tx default rules<br>
<br>
Nithinsen Kaithakadan (1):<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix mbuf handling<br>
<br>
Nupur Uttarwar (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix buddy memory allocation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: skip Rx control flow tables in isolated mode=
<br>
<br>
Pandi Kumar Maharajan (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix memory leak in recipe handling<br>
<br>
Prashant Gupta (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix uninitialized variable<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: free buffers from error queue<br>
<br>
Radu Nicolau (3):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix ECDH<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix source buffer alignment<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix vector initialization<br>
<br>
Robin Jarry (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/tap: fix interrupt callback crash after failed sta=
rt<br>
=C2=A0 =C2=A0 =C2=A0 buildtools/pmdinfogen: fix warning with python 3.14<br=
>
=C2=A0 =C2=A0 =C2=A0 graph: fix updating edge with active graph<br>
=C2=A0 =C2=A0 =C2=A0 usertools/telemetry: fix exporter default IP binding<b=
r>
<br>
Roi Dayan (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix leak of flow indexed pools<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: release representor interrupt handler<br>
=C2=A0 =C2=A0 =C2=A0 common/mlx5: release unused mempool entries<br>
<br>
Ronak Doshi (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/vmxnet3: fix mapping of mempools to queues<br>
<br>
Rongwei Liu (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect flow action memory leak<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flow aging race condition<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: remove counter alignment<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix meter mark allocation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect meter index leak<br>
<br>
Satha Rao (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix null SQ access<br>
<br>
Serhii Iliushyk (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ntnic: fix potential format overflow<br>
<br>
Shai Brandes (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ena: fix PCI BAR mapping on 64K page size<br>
=C2=A0 =C2=A0 =C2=A0 net/ena/base: fix unsafe memcpy on invalid memory<br>
<br>
Shaiq Wani (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix adding special words<br>
<br>
Shani Peretz (6):<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix DMA mask validation with IOVA mode option<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix MTU initialization<br>
=C2=A0 =C2=A0 =C2=A0 app/crypto-perf: fix plaintext size exceeds buffer siz=
e<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: fix MAC address propagation in 802.3ad mo=
de<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix null dereference in modify header<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix Tx metadata pattern template mismatch<br=
>
<br>
Sivaprasad Tummala (4):<br>
=C2=A0 =C2=A0 =C2=A0 eal/x86: enable timeout in AMD power monitor<br>
=C2=A0 =C2=A0 =C2=A0 examples/l3fwd-power: fix telemetry command registrati=
on<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix spurious CPU wakeups<br>
=C2=A0 =C2=A0 =C2=A0 examples/l3fwd: add Tx burst size configuration option=
<br>
<br>
Stephen Hemminger (9):<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix free of not allocated object<br>
=C2=A0 =C2=A0 =C2=A0 test/argparse: change initialization to workaround LTO=
<br>
=C2=A0 =C2=A0 =C2=A0 dmadev: fix debug build with tracepoints<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix metering cleanup<br>
=C2=A0 =C2=A0 =C2=A0 pdump: handle primary process exit<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix uninitialized variable<br>
=C2=A0 =C2=A0 =C2=A0 examples/server_node_efd: fix format overflow<br>
=C2=A0 =C2=A0 =C2=A0 examples/vdpa: fix format overflow<br>
=C2=A0 =C2=A0 =C2=A0 bus/fslmc: fix const pointer in device name parsing<br=
>
<br>
Sucharitha Sarananaga (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: refactor RSA verification<br>
<br>
Sunil Kumar Kori (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix max number of SQB buffers in clean up=
<br>
<br>
Tathagat Priyadarshi (1):<br>
=C2=A0 =C2=A0 =C2=A0 gro: fix payload corruption in coalescing packets<br>
<br>
Thierry Herbelot (1):<br>
=C2=A0 =C2=A0 =C2=A0 config/arm: enable NUMA for Neoverse N2<br>
<br>
Thomas Monjalon (12):<br>
=C2=A0 =C2=A0 =C2=A0 efd: fix AVX2 support<br>
=C2=A0 =C2=A0 =C2=A0 bus/pci: fix build with MinGW 13<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix build with MinGW 13<br>
=C2=A0 =C2=A0 =C2=A0 bbdev: fix build with MinGW 13<br>
=C2=A0 =C2=A0 =C2=A0 test/hash: check memory allocation<br>
=C2=A0 =C2=A0 =C2=A0 vdpa/mlx5: remove unused constant<br>
=C2=A0 =C2=A0 =C2=A0 crypto/mlx5: remove unused constants<br>
=C2=A0 =C2=A0 =C2=A0 regex/mlx5: remove useless constants<br>
=C2=A0 =C2=A0 =C2=A0 common/mlx5: remove useless constants<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: remove useless constants<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: remove unused macros<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix note in FreeBSD guide<br>
<br>
Tomasz Duszynski (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix async event handling<br>
<br>
Vamsi Attunuru (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: handle interrupt enable failure<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: fix mbuf data offset update<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: fix device start<br>
<br>
Vanshika Shukla (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix out-of-bounds access in UIO mapping<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/dpaa: fix resource leak<br>
<br>
Venkat Kumar Ande (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/axgbe: fix build with GCC 16<br>
<br>
Viacheslav Ovsiienko (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix ESP item validation to match on seqnum<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix ESP header match after UDP for group 0<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix ESP header match in strict mode<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flex flow item header length<br>
<br>
Vladimir Medvedkin (2):<br>
=C2=A0 =C2=A0 =C2=A0 fib6: fix memory leak on delete operation<br>
=C2=A0 =C2=A0 =C2=A0 fib6: fix tbl8 allocation check logic<br>
<br>
Wathsala Vithanage (4):<br>
=C2=A0 =C2=A0 =C2=A0 mcslock: fix memory ordering<br>
=C2=A0 =C2=A0 =C2=A0 ring: establish safe partial order in default mode<br>
=C2=A0 =C2=A0 =C2=A0 ring: establish a safe partial order in hts-ring<br>
=C2=A0 =C2=A0 =C2=A0 ring: establish safe partial order in RTS mode<br>
<br>
Xingui Yang (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix VLAN tag loss for short tunnel frame<br>
<br>
Yang Ming (2):<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix MP socket cleanup<br>
=C2=A0 =C2=A0 =C2=A0 crypto/ipsec_mb: fix QP release in secondary<br>
<br>
Yuan Wang (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix SCTP port filtering on E610<br>
<br>
Yunjian Wang (1):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix double fetch when dequeue offloading<br>
<br>
Zhichao Zeng (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix statistics<br>
<br>
</blockquote></div>

--0000000000005ad8470645817646--

