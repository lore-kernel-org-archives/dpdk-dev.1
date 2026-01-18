Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F5C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 13:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70D9A402E6;
	Sun, 18 Jan 2026 14:27:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 55DD74026D
 for <dev@dpdk.org>; Sun, 18 Jan 2026 14:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768742832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUefPcopL3f0Q4svtDOuTsEkbKoAwj72r4AtKczWY4M=;
 b=Mjm2/6Yl+WxP8dSimu9htq6BfmbaTbTUohrRD6c10CbuT+fAjoI1HGBQ0pfSIiXbumsr3V
 +rRbb1Ckcw3BjYgmC0p4pLnUdUpEsuykHduaOzVEQAJhB94h4bM1BQ2oLhMcxbUui5qCs9
 trFEsqlD/vzPC7nmHDIcG/Zq802HP8U=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-4vsdPYS4Mm-e3Fvn2MWjFg-1; Sun, 18 Jan 2026 08:27:11 -0500
X-MC-Unique: 4vsdPYS4Mm-e3Fvn2MWjFg-1
X-Mimecast-MFC-AGG-ID: 4vsdPYS4Mm-e3Fvn2MWjFg_1768742830
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7cfd1080f66so4276232a34.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 05:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768742830; x=1769347630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUefPcopL3f0Q4svtDOuTsEkbKoAwj72r4AtKczWY4M=;
 b=BTKkaA+NB+hVEIAlddUYD0fxRkHhAS2HRk0QNsnkKGJx5ELbMOso33AZw9efx90Umq
 ZHwGuc261cj4B4gWPcmICk80643luk6+4PD8K1XhDPwJrYm9qDPZcVZZoyz9On5qafn9
 LW9z1X2Tn7lEN9hrcuhA5mvaoCmSR2aCGnzaGwXl6vjczEq83BPOwoheq5JAY5wFLbJJ
 wsyAEVwci8C7y60fN0qCZ5wYFipc+zFvXcUuhoY3YRDEs9AODQujGGUw518KJ55Aej0l
 s1ML8VMAKvp0sT9cCc8H8ALU/aRGCYwIW7vpQgr4aUbiFGCMrmjsTsw1n8G1z6VHkPvQ
 +p/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX89ODZOV39PqVHRs3Mwo7EFlmkbg16B3W1E4ZsZ/VATAArq/EXjgpTZIxoFglxLi7TMcg=@dpdk.org
X-Gm-Message-State: AOJu0YxnSGZsnG4GoXynebAQ7T3ywLzI7YX2kqZjVde8lrftPAIleELc
 UeO+9XoixOcSUmyzBJRyri2Sh067PKuG0++Zn9WCzmPDrK0MzGSAjNxOvXPbYh7GSKwwLTaF6VK
 u62/lpcBGk0vdNoLlkjrQ+pTW70u7n2/pPBUN0Mr/pNjx2WAs26NkZqWWY1MuHbg47eG5pwD7cg
 B0gHF8oz+57VA9MUAq0Hw=
X-Gm-Gg: AY/fxX4q580/km/s8HdoBUi/KJGtLVe7iB9iyPewff2zwdaVeUl3bTO8Uak65Rlk/rt
 /W7KqzyNt7E6iTtxYGJp+mHuwttMbuYENtwz5lrBf+qKiYJNcx/Hi1R7gbGOqr5Wkx8/ZAsn2yi
 XJiAhd61TBxjTgNPRNKC3q/o18aIicguyoad7g99dirUToemJsvG7tfK/396O1Ot6FHH4=
X-Received: by 2002:a05:6820:190f:b0:659:9a49:8ecb with SMTP id
 006d021491bc7-66117a472f1mr3619073eaf.79.1768742830271; 
 Sun, 18 Jan 2026 05:27:10 -0800 (PST)
X-Received: by 2002:a05:6820:190f:b0:659:9a49:8ecb with SMTP id
 006d021491bc7-66117a472f1mr3619057eaf.79.1768742829777; Sun, 18 Jan 2026
 05:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20260107100017.158232-1-shperetz@nvidia.com>
In-Reply-To: <20260107100017.158232-1-shperetz@nvidia.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Sun, 18 Jan 2026 21:26:58 +0800
X-Gm-Features: AZwV_QioPofU08N6PxSAFnHypABQJghiJdqxm_rVXCrWKrsr5qq1lgaOfmr3azk
Message-ID: <CAGYh1E8eFYCHeoyCmhAHEQu7qOxFZc+CGA2OTt-FAmdmhCnxSQ@mail.gmail.com>
Subject: Re: 23.11.6 patches review and test
To: Shani Peretz <shperetz@nvidia.com>
Cc: stable@dpdk.org, dev@dpdk.org, 
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 benjamin.walker@intel.com, David Christensen <drc@linux.vnet.ibm.com>, 
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>, 
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>, 
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>, 
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 qian.q.xu@intel.com, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 yuan.peng@intel.com, zhaoyan.chen@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Hc49M7DcT9fCkikpFJrwJvQLJCiN2uOHT3t2yGlnIuE_1768742830
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000001179fb0648a988cc"
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

--0000000000001179fb0648a988cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested below 18 scenarios on RHEL 10.0 host and didn't find any new dpdk
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

   - qemu-kvm-9.1.0
   - kernel 6.12
   - libvirt 10.10
   - ovs 3.3
   - git describe
      - v23.11.6-rc1
   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>


On Wed, Jan 7, 2026 at 6:01=E2=80=AFPM Shani Peretz <shperetz@nvidia.com> w=
rote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.6.
>
> The planned date for the final release is January 22th.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.6-rc1
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Shani
>
> ---
> Aarnav JP (1):
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
> Anurag Mandal (1):
>       net/i40e: fix symmetric Toeplitz hashing for SCTP
>
> Bing Zhao (1):
>       app/flow-perf: fix rules array length
>
> Brick Yang (2):
>       net/dpaa2: fix L3/L4 checksum results
>       net/dpaa2: receive packets with additional parse errors
>
> Bruce Richardson (10):
>       net/ice: fix vector Rx VLAN offload flags
>       net/intel: fix assumption about tag placement order
>       net/ice: fix VLAN tag reporting on Rx
>       doc: fix display of commands in cpfl guide
>       net/ice: fix initialization with 8 ports
>       ethdev: fix VLAN filter parameter description
>       net/fm10k: fix build with GCC 16
>       app/pdump: remove hard-coded memory channels
>       telemetry: make socket handler typedef private
>       net/ice: fix path selection for QinQ Tx offload
>
> Chengwen Feng (7):
>       dma/hisilicon: fix stop with pending transfers
>       test/dma: fix failure condition
>       net/hns3: fix overwrite mbuf in vector path
>       app/dma-perf: fix use after free
>       app/dma-perf: fix on-flight DMA when verifying data
>       app/testpmd: fix DCB Tx port
>       app/testpmd: fix DCB Rx queues
>
> Chinh Cao (1):
>       net/ice/base: fix integer overflow on NVM init
>
> Ciara Loftus (5):
>       net/iavf: fix Tx vector path selection logic
>       doc: fix feature list of ice driver
>       doc: fix feature list of iavf driver
>       net/e1000/base: fix crash on init with GCC 13
>       net/idpf: fix queue setup with TSO offload
>
> Dariusz Sosnowski (8):
>       app/testpmd: fix conntrack action query
>       net/mlx5: fix min and max MTU reporting
>       net/mlx5/hws: fix TIR action support in FDB
>       net/mlx5: fix indirect flow age action handling
>       net/mlx5: fix Direct Verbs counter offset detection
>       net/mlx5: fix indirect RSS action hash
>       net/mlx5: fix error reporting on masked indirect actions
>       net/mlx5: fix flow tag indexes support on root table
>
> David Marchand (19):
>       test/telemetry: fix test calling all commands
>       eal: fix plugin dir walk
>       cmdline: fix port list parsing
>       cmdline: fix highest bit port list parsing
>       tailq: fix lookup macro
>       hash: fix unaligned access in predictable RSS
>       graph: fix unaligned access in stats
>       eventdev: fix listing timer adapters with telemetry
>       cfgfile: fix section count with no name
>       baseband/acc: fix exported header
>       eventdev: do not include driver header in DMA adapter
>       gpudev: fix driver header for Windows
>       drivers: fix some exported headers
>       test/debug: fix crash with mlx5 devices
>       net/tap: fix build with LTO
>       eventdev/crypto: fix build with clang 21
>       rawdev: fix build with clang 21
>       vhost: fix external buffer in VDUSE
>       net/dpaa2: remove ethdev pointer from bus device
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
> Ferruh Yigit (1):
>       ethdev: convert string initialization
>
> Gagandeep Singh (2):
>       net/dpaa2: fix shaper rate
>       bus/dpaa: improve cleanup
>
> Gowrishankar Muthukrishnan (1):
>       crypto/virtio: fix cookies leak
>
> Gregory Etelson (6):
>       net/mlx5: fix storage of shared Rx queues
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
> Jacob Keller (3):
>       net/ice/base: fix memory leak in HW profile handling
>       net/iavf: fix check for PF Rx timestamp support
>       net/iavf: fix Rx timestamp validity check
>
> Jasper Tran O'Leary (1):
>       net/gve: free device resources on close
>
> Jerin Jacob (3):
>       net/iavf: fix build with clang 21
>       test: fix build with clang 21
>       lib: fix backticks matching in Doxygen comments
>
> Jiawen Wu (18):
>       net/txgbe: reduce memory size of ring descriptors
>       net/ngbe: reduce memory size of ring descriptors
>       net/txgbe: fix VF Rx buffer size in config register
>       net/txgbe: add device arguments for FDIR
>       net/txgbe: fix maximum number of FDIR filters
>       net/txgbe: fix FDIR mode clearing
>       net/txgbe: fix FDIR drop action for L4 match packets
>       net/txgbe: fix FDIR rule raw relative for L3 packets
>       net/txgbe: switch to FDIR when ntuple filter is full
>       net/txgbe: remove unsupported flow action mark
>       doc: add device arguments in txgbe guide
>       net/txgbe: fix FDIR perfect mode for IPv6
>       net/txgbe: fix to create FDIR filter for tunnel packet
>       net/txgbe: fix FDIR filter for SCTP tunnel
>       net/txgbe: filter FDIR match flex bytes for tunnel
>       net/ngbe: fix checksum error counter
>       net/txgbe: fix checksum error counter
>       net/txgbe: fix FDIR input mask
>
> John Miller (1):
>       net/ark: remove double mbuf free
>
> Joshua Washington (7):
>       net/gve: do not write zero-length descriptors
>       net/gve: validate Tx packet before sending
>       net/gve: fix disabling interrupts on DQ
>       net/gve: free Rx mbufs if allocation fails on ring setup
>       net/gve: send whole packet when mbuf is large
>       net/gve: clean when insufficient Tx descriptors
>       net/gve: add DQO Tx descriptor limit
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
> Maayan Kashani (5):
>       net/mlx5: fix unsupported flow rule port action
>       net/mlx5: fix non-template age rules flush
>       net/mlx5: fix modify field action restriction
>       app/testpmd: fix flex item link parsing
>       net/mlx5: fix device start error handling
>
> Mattias R=C3=B6nnblom (1):
>       bitops: improve power of 2 alignment documentation
>
> Maxime Coquelin (2):
>       vhost: add VDUSE virtqueue ready state polling workaround
>       vhost: fix virtqueue info init in VDUSE vring setup
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
> Nupur Uttarwar (1):
>       net/mlx5/hws: fix buddy memory allocation
>
> Pandi Kumar Maharajan (1):
>       net/ice/base: fix memory leak in recipe handling
>
> Prashant Gupta (1):
>       net/dpaa2: fix uninitialized variable
>
> Radu Nicolau (2):
>       crypto/qat: fix ECDH
>       test/crypto: fix vector initialization
>
> Robin Jarry (3):
>       net/tap: fix interrupt callback crash after failed start
>       buildtools/pmdinfogen: fix warning with python 3.14
>       graph: fix updating edge with active graph
>
> Roi Dayan (3):
>       net/mlx5: fix leak of flow indexed pools
>       net/mlx5: release representor interrupt handler
>       common/mlx5: release unused mempool entries
>
> Ronak Doshi (1):
>       net/vmxnet3: fix mapping of mempools to queues
>
> Rongwei Liu (3):
>       net/mlx5: fix indirect flow action memory leak
>       net/mlx5: fix meter mark allocation
>       net/mlx5: fix indirect meter index leak
>
> Satha Rao (1):
>       common/cnxk: fix null SQ access
>
> Shai Brandes (2):
>       net/ena: fix PCI BAR mapping on 64K page size
>       net/ena/base: fix unsafe memcpy on invalid memory
>
> Shaiq Wani (1):
>       net/ice/base: fix adding special words
>
> Shani Peretz (7):
>       eal: fix DMA mask validation with IOVA mode option
>       net/mlx5: fix MTU initialization
>       app/crypto-perf: fix plaintext size exceeds buffer size
>       net/bonding: fix MAC address propagation in 802.3ad mode
>       net/mlx5: fix Tx metadata pattern template mismatch
>       net/hns3: fix atomic API usage for LTS compatibility
>       Revert "net/mlx5: align PF and VF/SF MAC address handling"
>
> Sivaprasad Tummala (3):
>       eal/x86: enable timeout in AMD power monitor
>       examples/l3fwd-power: fix telemetry command registration
>       net/mlx5: fix spurious CPU wakeups
>
> Stephen Hemminger (6):
>       dmadev: fix debug build with tracepoints
>       net/nfp: fix metering cleanup
>       pdump: handle primary process exit
>       net/mlx5: fix uninitialized variable
>       examples/server_node_efd: fix format overflow
>       examples/vdpa: fix format overflow
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
> Thomas Monjalon (11):
>       efd: fix AVX2 support
>       bus/pci: fix build with MinGW 13
>       net/mlx5: fix build with MinGW 13
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
> Vamsi Attunuru (2):
>       net/octeon_ep: fix device start
>       net/octeon_ep: fix mbuf data offset update
>
> Vanshika Shukla (2):
>       net/enetfec: fix out-of-bounds access in UIO mapping
>       net/dpaa: fix resource leak
>
> Venkat Kumar Ande (1):
>       net/axgbe: fix build with GCC 16
>
> Viacheslav Ovsiienko (5):
>       net/mlx5/hws: fix ESP header match in strict mode
>       net/mlx5/hws: fix ESP header match in strict mode
>       net/mlx5: fix ESP header match after UDP for group 0
>       net/mlx5: fix control flow leakage for external SQ
>       net/mlx5: fix flex flow item header length
>
> Vladimir Medvedkin (1):
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
> Yunjian Wang (1):
>       vhost: fix double fetch when dequeue offloading
>
> Zhichao Zeng (1):
>       net/ice: fix statistics
>
>

--0000000000001179fb0648a988cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font =
face=3D"arial, sans-serif">I tested below 18 scenarios on RHEL 10.0 host an=
d didn&#39;t find any new dpdk issues.</font></div><div dir=3D"ltr"><ul><li=
 style=3D"margin-left:15px">VM with device assignment(PF) throughput testin=
g(1G hugepage size): PASS</li><li style=3D"margin-left:15px">VM with device=
 assignment(PF) throughput testing(2M hugepage size) : PASS</li><li style=
=3D"margin-left:15px">VM with device assignment(VF) throughput testing: PAS=
S</li><li style=3D"margin-left:15px">PVP (host dpdk testpmd as vswitch) 1Q:=
 throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-user=
 2Q throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-u=
ser 1Q - cross numa node throughput testing: PASS</li><li style=3D"margin-l=
eft:15px">VM with vhost-user 2 queues throughput testing: PASS</li><li styl=
e=3D"margin-left:15px">vhost-user reconnect with dpdk-client, qemu-server(q=
emu reconnect): PASS</li><li style=3D"margin-left:15px">vhost-user reconnec=
t with dpdk-client, qemu-server(ovs reconnect): PASS</li><li style=3D"margi=
n-left:15px">PVP =C2=A0reconnect with dpdk-client, qemu-server: PASS</li><l=
i style=3D"margin-left:15px">PVP 1Q live migration testing: PASS</li><li st=
yle=3D"margin-left:15px">PVP 1Q cross numa node live migration testing: PAS=
S</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1Q live mi=
gration testing: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+v=
host-user 1Q live migration testing (2M): PASS</li><li style=3D"margin-left=
:15px">VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS</li><li =
style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 4Q live migration te=
sting: PASS</li><li style=3D"margin-left:15px">Host PF + DPDK testing: PASS=
</li><li style=3D"margin-left:15px">Host VF + DPDK testing: PASS</li></ul><=
/div><div><font face=3D"arial, sans-serif">Test Versions:</font></div><div>=
<ul><li><span style=3D"font-family:arial,sans-serif">qemu-kvm-9.1.0</span><=
/li><li><span style=3D"font-family:arial,sans-serif">kernel 6.12</span></li=
><li><span style=3D"font-family:arial,sans-serif">libvirt 10.10</span></li>=
<li><span style=3D"font-family:arial,sans-serif">ovs 3.3</span></li><li><sp=
an style=3D"font-family:arial,sans-serif">git describe</span></li><ul><li><=
span style=3D"font-family:arial,sans-serif">v23.11.6-rc1</span></li></ul><l=
i><span style=3D"font-family:arial,sans-serif">Test device : X540-AT2 NIC(i=
xgbe, 10G)</span></li></ul></div></div></div></div><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signa=
ture"><div dir=3D"ltr"><div><font face=3D"arial, sans-serif">Tested-by: Yan=
ghang Liu &lt;<a href=3D"mailto:yanghliu@redhat.com" target=3D"_blank">yang=
hliu@redhat.com</a>&gt;<br></font></div></div></div></div></div></div><br><=
/div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jan 7, 2026 at 6:01=E2=80=AFPM Shani Peretz &l=
t;<a href=3D"mailto:shperetz@nvidia.com">shperetz@nvidia.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
Here is a list of patches targeted for stable release 23.11.6.<br>
<br>
The planned date for the final release is January 22th.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.=
11.6-rc1" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpdk=
-stable/tag/?id=3Dv23.11.6-rc1</a><br>
<br>
These patches are located at branch 23.11 of dpdk-stable repo:<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/" rel=3D"noref=
errer" target=3D"_blank">https://dpdk.org/browse/dpdk-stable/</a><br>
<br>
Thanks.<br>
<br>
Shani<br>
<br>
---<br>
Aarnav JP (1):<br>
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
Anurag Mandal (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e: fix symmetric Toeplitz hashing for SCTP<br>
<br>
Bing Zhao (1):<br>
=C2=A0 =C2=A0 =C2=A0 app/flow-perf: fix rules array length<br>
<br>
Brick Yang (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix L3/L4 checksum results<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: receive packets with additional parse error=
s<br>
<br>
Bruce Richardson (10):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix vector Rx VLAN offload flags<br>
=C2=A0 =C2=A0 =C2=A0 net/intel: fix assumption about tag placement order<br=
>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix VLAN tag reporting on Rx<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix display of commands in cpfl guide<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix initialization with 8 ports<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix VLAN filter parameter description<br>
=C2=A0 =C2=A0 =C2=A0 net/fm10k: fix build with GCC 16<br>
=C2=A0 =C2=A0 =C2=A0 app/pdump: remove hard-coded memory channels<br>
=C2=A0 =C2=A0 =C2=A0 telemetry: make socket handler typedef private<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix path selection for QinQ Tx offload<br>
<br>
Chengwen Feng (7):<br>
=C2=A0 =C2=A0 =C2=A0 dma/hisilicon: fix stop with pending transfers<br>
=C2=A0 =C2=A0 =C2=A0 test/dma: fix failure condition<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix overwrite mbuf in vector path<br>
=C2=A0 =C2=A0 =C2=A0 app/dma-perf: fix use after free<br>
=C2=A0 =C2=A0 =C2=A0 app/dma-perf: fix on-flight DMA when verifying data<br=
>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix DCB Tx port<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix DCB Rx queues<br>
<br>
Chinh Cao (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix integer overflow on NVM init<br>
<br>
Ciara Loftus (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix Tx vector path selection logic<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature list of ice driver<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature list of iavf driver<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix crash on init with GCC 13<br>
=C2=A0 =C2=A0 =C2=A0 net/idpf: fix queue setup with TSO offload<br>
<br>
Dariusz Sosnowski (8):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix conntrack action query<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix min and max MTU reporting<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix TIR action support in FDB<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect flow age action handling<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix Direct Verbs counter offset detection<br=
>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect RSS action hash<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix error reporting on masked indirect actio=
ns<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flow tag indexes support on root table<b=
r>
<br>
David Marchand (19):<br>
=C2=A0 =C2=A0 =C2=A0 test/telemetry: fix test calling all commands<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix plugin dir walk<br>
=C2=A0 =C2=A0 =C2=A0 cmdline: fix port list parsing<br>
=C2=A0 =C2=A0 =C2=A0 cmdline: fix highest bit port list parsing<br>
=C2=A0 =C2=A0 =C2=A0 tailq: fix lookup macro<br>
=C2=A0 =C2=A0 =C2=A0 hash: fix unaligned access in predictable RSS<br>
=C2=A0 =C2=A0 =C2=A0 graph: fix unaligned access in stats<br>
=C2=A0 =C2=A0 =C2=A0 eventdev: fix listing timer adapters with telemetry<br=
>
=C2=A0 =C2=A0 =C2=A0 cfgfile: fix section count with no name<br>
=C2=A0 =C2=A0 =C2=A0 baseband/acc: fix exported header<br>
=C2=A0 =C2=A0 =C2=A0 eventdev: do not include driver header in DMA adapter<=
br>
=C2=A0 =C2=A0 =C2=A0 gpudev: fix driver header for Windows<br>
=C2=A0 =C2=A0 =C2=A0 drivers: fix some exported headers<br>
=C2=A0 =C2=A0 =C2=A0 test/debug: fix crash with mlx5 devices<br>
=C2=A0 =C2=A0 =C2=A0 net/tap: fix build with LTO<br>
=C2=A0 =C2=A0 =C2=A0 eventdev/crypto: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 rawdev: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix external buffer in VDUSE<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: remove ethdev pointer from bus device<br>
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
Ferruh Yigit (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: convert string initialization<br>
<br>
Gagandeep Singh (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix shaper rate<br>
=C2=A0 =C2=A0 =C2=A0 bus/dpaa: improve cleanup<br>
<br>
Gowrishankar Muthukrishnan (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix cookies leak<br>
<br>
Gregory Etelson (6):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix storage of shared Rx queues<br>
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
Jacob Keller (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix memory leak in HW profile handling<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix check for PF Rx timestamp support<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix Rx timestamp validity check<br>
<br>
Jasper Tran O&#39;Leary (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: free device resources on close<br>
<br>
Jerin Jacob (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 test: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 lib: fix backticks matching in Doxygen comments<br>
<br>
Jiawen Wu (18):<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: reduce memory size of ring descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: reduce memory size of ring descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix VF Rx buffer size in config register<br=
>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: add device arguments for FDIR<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix maximum number of FDIR filters<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR mode clearing<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR drop action for L4 match packets<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR rule raw relative for L3 packets<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: switch to FDIR when ntuple filter is full<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: remove unsupported flow action mark<br>
=C2=A0 =C2=A0 =C2=A0 doc: add device arguments in txgbe guide<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR perfect mode for IPv6<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix to create FDIR filter for tunnel packet=
<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR filter for SCTP tunnel<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: filter FDIR match flex bytes for tunnel<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix checksum error counter<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix checksum error counter<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR input mask<br>
<br>
John Miller (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ark: remove double mbuf free<br>
<br>
Joshua Washington (7):<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: do not write zero-length descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: validate Tx packet before sending<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: fix disabling interrupts on DQ<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: free Rx mbufs if allocation fails on ring set=
up<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: send whole packet when mbuf is large<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: clean when insufficient Tx descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: add DQO Tx descriptor limit<br>
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
Maayan Kashani (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix unsupported flow rule port action<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix non-template age rules flush<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix modify field action restriction<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix flex item link parsing<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix device start error handling<br>
<br>
Mattias R=C3=B6nnblom (1):<br>
=C2=A0 =C2=A0 =C2=A0 bitops: improve power of 2 alignment documentation<br>
<br>
Maxime Coquelin (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: add VDUSE virtqueue ready state polling workaro=
und<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix virtqueue info init in VDUSE vring setup<br=
>
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
Nupur Uttarwar (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix buddy memory allocation<br>
<br>
Pandi Kumar Maharajan (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix memory leak in recipe handling<br>
<br>
Prashant Gupta (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix uninitialized variable<br>
<br>
Radu Nicolau (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix ECDH<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix vector initialization<br>
<br>
Robin Jarry (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/tap: fix interrupt callback crash after failed sta=
rt<br>
=C2=A0 =C2=A0 =C2=A0 buildtools/pmdinfogen: fix warning with python 3.14<br=
>
=C2=A0 =C2=A0 =C2=A0 graph: fix updating edge with active graph<br>
<br>
Roi Dayan (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix leak of flow indexed pools<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: release representor interrupt handler<br>
=C2=A0 =C2=A0 =C2=A0 common/mlx5: release unused mempool entries<br>
<br>
Ronak Doshi (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/vmxnet3: fix mapping of mempools to queues<br>
<br>
Rongwei Liu (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect flow action memory leak<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix meter mark allocation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect meter index leak<br>
<br>
Satha Rao (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix null SQ access<br>
<br>
Shai Brandes (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ena: fix PCI BAR mapping on 64K page size<br>
=C2=A0 =C2=A0 =C2=A0 net/ena/base: fix unsafe memcpy on invalid memory<br>
<br>
Shaiq Wani (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix adding special words<br>
<br>
Shani Peretz (7):<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix DMA mask validation with IOVA mode option<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix MTU initialization<br>
=C2=A0 =C2=A0 =C2=A0 app/crypto-perf: fix plaintext size exceeds buffer siz=
e<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: fix MAC address propagation in 802.3ad mo=
de<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix Tx metadata pattern template mismatch<br=
>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix atomic API usage for LTS compatibility<b=
r>
=C2=A0 =C2=A0 =C2=A0 Revert &quot;net/mlx5: align PF and VF/SF MAC address =
handling&quot;<br>
<br>
Sivaprasad Tummala (3):<br>
=C2=A0 =C2=A0 =C2=A0 eal/x86: enable timeout in AMD power monitor<br>
=C2=A0 =C2=A0 =C2=A0 examples/l3fwd-power: fix telemetry command registrati=
on<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix spurious CPU wakeups<br>
<br>
Stephen Hemminger (6):<br>
=C2=A0 =C2=A0 =C2=A0 dmadev: fix debug build with tracepoints<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix metering cleanup<br>
=C2=A0 =C2=A0 =C2=A0 pdump: handle primary process exit<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix uninitialized variable<br>
=C2=A0 =C2=A0 =C2=A0 examples/server_node_efd: fix format overflow<br>
=C2=A0 =C2=A0 =C2=A0 examples/vdpa: fix format overflow<br>
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
Thomas Monjalon (11):<br>
=C2=A0 =C2=A0 =C2=A0 efd: fix AVX2 support<br>
=C2=A0 =C2=A0 =C2=A0 bus/pci: fix build with MinGW 13<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix build with MinGW 13<br>
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
Vamsi Attunuru (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: fix device start<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: fix mbuf data offset update<br>
<br>
Vanshika Shukla (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix out-of-bounds access in UIO mapping<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/dpaa: fix resource leak<br>
<br>
Venkat Kumar Ande (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/axgbe: fix build with GCC 16<br>
<br>
Viacheslav Ovsiienko (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix ESP header match in strict mode<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix ESP header match in strict mode<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix ESP header match after UDP for group 0<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix control flow leakage for external SQ<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flex flow item header length<br>
<br>
Vladimir Medvedkin (1):<br>
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
Yunjian Wang (1):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix double fetch when dequeue offloading<br>
<br>
Zhichao Zeng (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix statistics<br>
<br>
</blockquote></div>

--0000000000001179fb0648a988cc--

