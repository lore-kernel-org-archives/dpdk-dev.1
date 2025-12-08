Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF5D3ABEF
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 08:03:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 092B7402BA;
	Mon,  8 Dec 2025 09:03:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7C3D740280
 for <dev@dpdk.org>; Mon,  8 Dec 2025 09:03:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765181023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jaFQc7K85cv0SI655EWoiwyZm/CGiWJI9Ld5B5VB/Bo=;
 b=T2lFusqqRHjoFvZWzTCTWIwqFCmcGtcfZMPbtLlV9CvpOlLP+CX8YUqqKSQXz+lSRC891j
 Tx3hdFt5u/OJMpGUZ7kmp2EGZcJsvMlrc40MiSPvRGEIc9xl9o2VEaiyM24o+6CXd/YP7c
 5ev4MirIMNLmmqJxpWulCP9OHf7e5lo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-FeoxykR5OKeWDI1AtrjQXQ-1; Mon, 08 Dec 2025 03:03:41 -0500
X-MC-Unique: FeoxykR5OKeWDI1AtrjQXQ-1
X-Mimecast-MFC-AGG-ID: FeoxykR5OKeWDI1AtrjQXQ_1765181021
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-453109b60a5so2901332b6e.0
 for <dev@dpdk.org>; Mon, 08 Dec 2025 00:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765181021; x=1765785821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaFQc7K85cv0SI655EWoiwyZm/CGiWJI9Ld5B5VB/Bo=;
 b=ESVHurouECeNanpsdPCtTR0WiyJJHNKZtLCATy7uLTuQIF7siHjRacA+BUK2c6e7y7
 KT5oPWeQQGr6VBwzRmEm4jRI53RgsNFMgsi8ZLxOnyZAp9GW9fdbJ9v3nhQfasTl+f4C
 9buJrRrJI12uYnSPiY2iQTR2lp3VXfN+gwos92K/ss7nVNOKXW9+BcD8zUYlk844npVm
 5ETL9diKanayf5AtRzGmSMVUi4fbje++YCvfZLCA2sulQofHOsswH19g0EyuOP+gRZAU
 Z8fTf7beh8OKYYJxEDXytGWVLWDAgAjnFKH01xw4/uaI1BESIBTSlKnlR1bo62e3Vmtf
 exdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVRfMZwTnP4EHT9rNMovKF6IJuewdI9eKWkL93yJM0V3/doxqCY/smoJMHbLpKSlOBO1Q=@dpdk.org
X-Gm-Message-State: AOJu0YwyfXFDHRTY/q0/3FF6yRYQ1ZLrGcYeRcTX6nXrIj+ZQDLE7Qjw
 yEMGdkYrb/4YhCmVQAoigKDmaKSO2OHQuxwG630vh/s9kdJOJRYLW9hLVAplA6+45hnY7+Sfbc3
 7G9y14w+EXowC6mf9Tx7TR+ts/CrBfr9Ysi+czg078mh/2C8zTchHwwk4kFvkbKI4QPHyuGgyXm
 8qZNy9sefKPQ201Qhc2n8=
X-Gm-Gg: ASbGncsXm3gil9WxWNurrNby1eO0Su9zXqYBaCBYAL/3bcAmbUsDHGY+7oXU6OO7uDS
 7yZn6Chb+8BLf/PW1uv2ywEaVuTcSDp2GujY4V9I74hsBJjYOpT90nc5/ayGfjeVRST+X3mf6Wn
 wzKJfUKL60KvWu96fld/eeOEpt20/5d7ykoj7LE207YtvUf3quptePOJhP5pejJ3ZtdVE=
X-Received: by 2002:a05:6808:1507:b0:44d:bba7:df70 with SMTP id
 5614622812f47-4539e075aeemr2756246b6e.42.1765181020964; 
 Mon, 08 Dec 2025 00:03:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5RPiAs9Cdm10z0xkRh0RiWKf6XJDEhGBbi7S7DBvOKZZMUBJxApYMlXAiAdxJNCVQ9YoyXn+gLXl4kEmCQJg=
X-Received: by 2002:a05:6808:1507:b0:44d:bba7:df70 with SMTP id
 5614622812f47-4539e075aeemr2756229b6e.42.1765181020377; Mon, 08 Dec 2025
 00:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
In-Reply-To: <20251204005603.3236032-1-luca.boccassi@gmail.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Mon, 8 Dec 2025 16:03:29 +0800
X-Gm-Features: AQt7F2r_P2e1P-QlU6WvjJGRBHFIMhc4fjVrI5pcZaf60ujgWRu7nSbOeIM5wNM
Message-ID: <CAGYh1E-wQi5cn+ejg4+q+v4TvsBbYkGfpNQKr279gAunNzxzXQ@mail.gmail.com>
Subject: Re: 22.11.11 patches review and test
To: luca.boccassi@gmail.com
Cc: stable@dpdk.org, dev@dpdk.org, 
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Ian Stokes <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, 
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, 
 Kevin Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tdtg7Z_wzOHI2Ty0dLSAEpySvrT0JQzDi4SsysNYhjQ_1765181021
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000af275a06456c3b9b"
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

--000000000000af275a06456c3b9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested below 18 scenarios on RHEL 9.6 host and didn't find any new dpdk
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
   - kernel 5.14
   - libvirt 10.10
   - ovs 3.3
   - git describe
      - v22.11.11-rc1


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>


On Thu, Dec 4, 2025 at 8:56=E2=80=AFAM <luca.boccassi@gmail.com> wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 22.11.11.
>
> The planned date for the final release is December 18th.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv22.11.11-rc1
>
> These patches are located at branch 22.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Luca Boccassi
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
> Anatoly Burakov (3):
>       net/ice: remove indirection for FDIR filters
>       net/ice: fix memory leak in raw pattern parse
>       vfio: fix custom containers in multiprocess
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
> Bruce Richardson (8):
>       net/intel: fix assumption about tag placement order
>       net/ice: fix initialization with 8 ports
>       ethdev: fix VLAN filter parameter description
>       net/ice: fix vector Rx VLAN offload flags
>       net/fm10k: fix build with GCC 16
>       app/pdump: remove hard-coded memory channels
>       net/ice: fix path selection for QinQ Tx offload
>       net/iavf: revert check for PF Rx timestamp support
>
> Chengwen Feng (5):
>       dma/hisilicon: fix stop with pending transfers
>       test/dma: fix failure condition
>       net/hns3: fix overwrite mbuf in vector path
>       app/testpmd: fix DCB Tx port
>       app/testpmd: fix DCB Rx queues
>
> Chinh Cao (1):
>       net/ice/base: fix integer overflow on NVM init
>
> Ciara Loftus (3):
>       doc: fix feature list of ice driver
>       doc: fix feature list of iavf driver
>       net/e1000/base: fix crash on init with GCC 13
>
> Dariusz Sosnowski (6):
>       app/testpmd: fix conntrack action query
>       net/mlx5: fix min and max MTU reporting
>       net/mlx5: fix indirect flow age action handling
>       net/mlx5: fix Direct Verbs counter offset detection
>       net/mlx5: fix indirect RSS action hash
>       net/mlx5: fix error reporting on masked indirect actions
>
> David Marchand (21):
>       eal: fix plugin dir walk
>       cmdline: fix port list parsing
>       cmdline: fix highest bit port list parsing
>       tailq: fix lookup macro
>       hash: fix unaligned access in predictable RSS
>       graph: fix unaligned access in stats
>       eventdev: fix listing timer adapters with telemetry
>       cfgfile: fix section count with no name
>       baseband/acc: fix exported header
>       gpudev: fix driver header for Windows
>       drivers: fix some exported headers
>       test/debug: fix crash with mlx5 devices
>       net/tap: fix build with LTO
>       eventdev/crypto: fix build with clang 21
>       rawdev: fix build with clang 21
>       net/dpaa2: remove ethdev pointer from bus device
>       bus/ifpga: fix const pointer in device name parsing
>       crypto/caam_jr: fix const pointer in UIO filename parsing
>       net/enetfec: fix const pointer in UIO filename parsing
>       net/memif: fix const pointer in socket check
>       app/procinfo: fix const pointer in collectd format
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
> Gagandeep Singh (1):
>       net/dpaa2: fix shaper rate
>
> Gavin Li (1):
>       net/mlx5: fix multicast
>
> Gowrishankar Muthukrishnan (1):
>       crypto/virtio: fix cookies leak
>
> Gregory Etelson (5):
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
> Jacob Keller (3):
>       net/ice/base: fix memory leak in HW profile handling
>       net/iavf: fix check for PF Rx timestamp support
>       net/iavf: fix Rx timestamp validity check
>
> Jerin Jacob (2):
>       net/iavf: fix build with clang 21
>       lib: fix backticks matching in Doxygen comments
>
> Jiawen Wu (14):
>       net/txgbe: reduce memory size of ring descriptors
>       net/ngbe: reduce memory size of ring descriptors
>       net/txgbe: fix VF Rx buffer size in config register
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
>       doc: add device arguments in txgbe guide
>
> John Miller (1):
>       net/ark: remove double mbuf free
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
> Maayan Kashani (5):
>       net/mlx5: fix unsupported flow rule port action
>       net/mlx5: fix non-template age rules flush
>       net/mlx5: fix modify field action restriction
>       net/mlx5: fix device start error handling
>       app/testpmd: fix flex item link parsing
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
> Pavan Nikhilesh (1):
>       event/cnxk: fix Rx offload flags
>
> Prashant Gupta (1):
>       net/dpaa2: fix uninitialized variable
>
> Praveen Kaligineedi (1):
>       net/gve: allocate Rx QPL pages using malloc
>
> Radu Nicolau (2):
>       crypto/qat: fix source buffer alignment
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
> Rongwei Liu (2):
>       net/mlx5: fix flow aging race condition
>       net/mlx5: fix indirect meter index leak
>
> Shai Brandes (2):
>       net/ena: fix PCI BAR mapping on 64K page size
>       net/ena/base: fix unsafe memcpy on invalid memory
>
> Shaiq Wani (1):
>       net/ice/base: fix adding special words
>
> Shani Peretz (5):
>       eal: fix DMA mask validation with IOVA mode option
>       net/mlx5: fix MTU initialization
>       app/crypto-perf: fix plaintext size exceeds buffer size
>       net/bonding: fix MAC address propagation in 802.3ad mode
>       net/mlx5: fix Tx metadata pattern template mismatch
>
> Sivaprasad Tummala (1):
>       examples/l3fwd-power: fix telemetry command registration
>
> Stephen Hemminger (6):
>       dmadev: fix debug build with tracepoints
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
> Vanshika Shukla (2):
>       net/enetfec: fix out-of-bounds access in UIO mapping
>       net/dpaa: fix resource leak
>
> Venkat Kumar Ande (1):
>       net/axgbe: fix build with GCC 16
>
> Viacheslav Ovsiienko (2):
>       net/mlx5: fix ESP header match after UDP for group 0
>       net/mlx5: fix control flow leakage for external SQ
>
> Vladimir Medvedkin (1):
>       fib6: fix tbl8 allocation check logic
>
> Wathsala Vithanage (4):
>       ring: establish safe partial order in default mode
>       ring: establish a safe partial order in hts-ring
>       ring: establish safe partial order in RTS mode
>       eal: correct memory ordering in MCS lock
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

--000000000000af275a06456c3b9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font =
face=3D"arial, sans-serif">I tested below 18 scenarios on RHEL 9.6 host and=
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
div><div><br><font face=3D"arial, sans-serif">Test Versions:<br><ul><li sty=
le=3D"margin-left:15px">qemu-kvm-9.1.0</li><li style=3D"margin-left:15px">k=
ernel 5.14</li><li style=3D"margin-left:15px">libvirt 10.10</li><li style=
=3D"margin-left:15px">ovs 3.3</li><li style=3D"margin-left:15px">git descri=
be</li><ul><li style=3D"margin-left:15px">v22.11.11-rc1</li></ul></ul></fon=
t></div></div></div></div><div dir=3D"ltr" class=3D"gmail_signature"><div d=
ir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><font face=3D"arial, =
sans-serif"><ul><li style=3D"margin-left:15px">Test device : X540-AT2 NIC(i=
xgbe, 10G)</li></ul></font></div></div></div><div dir=3D"ltr" class=3D"gmai=
l_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div><font face=3D"arial, sans-serif">Tested-by: Yanghang Li=
u &lt;<a href=3D"mailto:yanghliu@redhat.com" target=3D"_blank">yanghliu@red=
hat.com</a>&gt;</font></div></div></div></div></div></div><br></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 4=
, 2025 at 8:56=E2=80=AFAM &lt;<a href=3D"mailto:luca.boccassi@gmail.com" ta=
rget=3D"_blank">luca.boccassi@gmail.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
Here is a list of patches targeted for stable release 22.11.11.<br>
<br>
The planned date for the final release is December 18th.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv22.=
11.11-rc1" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpd=
k-stable/tag/?id=3Dv22.11.11-rc1</a><br>
<br>
These patches are located at branch 22.11 of dpdk-stable repo:<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/" rel=3D"noref=
errer" target=3D"_blank">https://dpdk.org/browse/dpdk-stable/</a><br>
<br>
Thanks.<br>
<br>
Luca Boccassi<br>
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
Anatoly Burakov (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: remove indirection for FDIR filters<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix memory leak in raw pattern parse<br>
=C2=A0 =C2=A0 =C2=A0 vfio: fix custom containers in multiprocess<br>
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
Bruce Richardson (8):<br>
=C2=A0 =C2=A0 =C2=A0 net/intel: fix assumption about tag placement order<br=
>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix initialization with 8 ports<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix VLAN filter parameter description<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix vector Rx VLAN offload flags<br>
=C2=A0 =C2=A0 =C2=A0 net/fm10k: fix build with GCC 16<br>
=C2=A0 =C2=A0 =C2=A0 app/pdump: remove hard-coded memory channels<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix path selection for QinQ Tx offload<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: revert check for PF Rx timestamp support<br>
<br>
Chengwen Feng (5):<br>
=C2=A0 =C2=A0 =C2=A0 dma/hisilicon: fix stop with pending transfers<br>
=C2=A0 =C2=A0 =C2=A0 test/dma: fix failure condition<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix overwrite mbuf in vector path<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix DCB Tx port<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix DCB Rx queues<br>
<br>
Chinh Cao (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix integer overflow on NVM init<br>
<br>
Ciara Loftus (3):<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature list of ice driver<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature list of iavf driver<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix crash on init with GCC 13<br>
<br>
Dariusz Sosnowski (6):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix conntrack action query<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix min and max MTU reporting<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect flow age action handling<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix Direct Verbs counter offset detection<br=
>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect RSS action hash<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix error reporting on masked indirect actio=
ns<br>
<br>
David Marchand (21):<br>
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
=C2=A0 =C2=A0 =C2=A0 gpudev: fix driver header for Windows<br>
=C2=A0 =C2=A0 =C2=A0 drivers: fix some exported headers<br>
=C2=A0 =C2=A0 =C2=A0 test/debug: fix crash with mlx5 devices<br>
=C2=A0 =C2=A0 =C2=A0 net/tap: fix build with LTO<br>
=C2=A0 =C2=A0 =C2=A0 eventdev/crypto: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 rawdev: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: remove ethdev pointer from bus device<br>
=C2=A0 =C2=A0 =C2=A0 bus/ifpga: fix const pointer in device name parsing<br=
>
=C2=A0 =C2=A0 =C2=A0 crypto/caam_jr: fix const pointer in UIO filename pars=
ing<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix const pointer in UIO filename parsing=
<br>
=C2=A0 =C2=A0 =C2=A0 net/memif: fix const pointer in socket check<br>
=C2=A0 =C2=A0 =C2=A0 app/procinfo: fix const pointer in collectd format<br>
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
Gagandeep Singh (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix shaper rate<br>
<br>
Gavin Li (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix multicast<br>
<br>
Gowrishankar Muthukrishnan (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix cookies leak<br>
<br>
Gregory Etelson (5):<br>
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
Jacob Keller (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix memory leak in HW profile handling<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix check for PF Rx timestamp support<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix Rx timestamp validity check<br>
<br>
Jerin Jacob (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix build with clang 21<br>
=C2=A0 =C2=A0 =C2=A0 lib: fix backticks matching in Doxygen comments<br>
<br>
Jiawen Wu (14):<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: reduce memory size of ring descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: reduce memory size of ring descriptors<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix VF Rx buffer size in config register<br=
>
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
=C2=A0 =C2=A0 =C2=A0 doc: add device arguments in txgbe guide<br>
<br>
John Miller (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ark: remove double mbuf free<br>
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
Maayan Kashani (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix unsupported flow rule port action<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix non-template age rules flush<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix modify field action restriction<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix device start error handling<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix flex item link parsing<br>
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
Pavan Nikhilesh (1):<br>
=C2=A0 =C2=A0 =C2=A0 event/cnxk: fix Rx offload flags<br>
<br>
Prashant Gupta (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix uninitialized variable<br>
<br>
Praveen Kaligineedi (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: allocate Rx QPL pages using malloc<br>
<br>
Radu Nicolau (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix source buffer alignment<br>
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
Rongwei Liu (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flow aging race condition<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix indirect meter index leak<br>
<br>
Shai Brandes (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ena: fix PCI BAR mapping on 64K page size<br>
=C2=A0 =C2=A0 =C2=A0 net/ena/base: fix unsafe memcpy on invalid memory<br>
<br>
Shaiq Wani (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix adding special words<br>
<br>
Shani Peretz (5):<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix DMA mask validation with IOVA mode option<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix MTU initialization<br>
=C2=A0 =C2=A0 =C2=A0 app/crypto-perf: fix plaintext size exceeds buffer siz=
e<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: fix MAC address propagation in 802.3ad mo=
de<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix Tx metadata pattern template mismatch<br=
>
<br>
Sivaprasad Tummala (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/l3fwd-power: fix telemetry command registrati=
on<br>
<br>
Stephen Hemminger (6):<br>
=C2=A0 =C2=A0 =C2=A0 dmadev: fix debug build with tracepoints<br>
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
Vanshika Shukla (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: fix out-of-bounds access in UIO mapping<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/dpaa: fix resource leak<br>
<br>
Venkat Kumar Ande (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/axgbe: fix build with GCC 16<br>
<br>
Viacheslav Ovsiienko (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix ESP header match after UDP for group 0<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix control flow leakage for external SQ<br>
<br>
Vladimir Medvedkin (1):<br>
=C2=A0 =C2=A0 =C2=A0 fib6: fix tbl8 allocation check logic<br>
<br>
Wathsala Vithanage (4):<br>
=C2=A0 =C2=A0 =C2=A0 ring: establish safe partial order in default mode<br>
=C2=A0 =C2=A0 =C2=A0 ring: establish a safe partial order in hts-ring<br>
=C2=A0 =C2=A0 =C2=A0 ring: establish safe partial order in RTS mode<br>
=C2=A0 =C2=A0 =C2=A0 eal: correct memory ordering in MCS lock<br>
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

--000000000000af275a06456c3b9b--

