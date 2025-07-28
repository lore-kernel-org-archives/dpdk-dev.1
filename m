Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48119C87FCE
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 09:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E3024042F;
	Mon, 28 Jul 2025 11:15:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 11242402EF
 for <dev@dpdk.org>; Mon, 28 Jul 2025 11:15:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753694101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qY0yqE/sfiYgiFg9OQxRWEm/l1ktqgtxbUBvzLTGm6k=;
 b=Sry0nptZSyxw/siAdZHQC8h7et1KviZW8GC7vEUkRCXslv3dVnIsnLjjA3uBWUEp6KFCpP
 SQe301Zic2zoGLQ1wS6CUTmURnKtHHxInPaIIPqHQdPkjD6W0T2eNG2c1ksLIs9jZP5gLM
 PKXVnGkI5CF4RAMPnoJuzDhRaamywA4=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-flxqPhafNY6Xf02I8DXlJg-1; Mon, 28 Jul 2025 05:14:59 -0400
X-MC-Unique: flxqPhafNY6Xf02I8DXlJg-1
X-Mimecast-MFC-AGG-ID: flxqPhafNY6Xf02I8DXlJg_1753694099
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2e92a214e2eso1936576fac.1
 for <dev@dpdk.org>; Mon, 28 Jul 2025 02:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753694099; x=1754298899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qY0yqE/sfiYgiFg9OQxRWEm/l1ktqgtxbUBvzLTGm6k=;
 b=u3/nhSTWAkHpIWeP+UdF4Sl3EJT8wjfznrPya6cAOdeYla1cGt9zgIW7qgX1FuuOkD
 erOvxRVU7/dWeKqGl6dXjMYtehQ+Pl7UXkcqWu8g0j0LwCscICOjXZ/+zD00iG0qaaS/
 d5Slrl/Ia2OmvgqV5m/Zs+PaAGeVfaPUeXx4qQ4JHejP+Sv17v71hYhlhvJzR/DR8QLS
 mgOsq5lTF7USpscy2Sml0vnSiLx18QmUbPpaciZuE5fubERVc1whZYXBbZccPrSF+b79
 Ga5lL1kta2b4lYBslQhh6wtSRHYOtIs3m7V9jppFSy+A09PIH4LjVImUnyzIqBOE62kp
 R4BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjLWALgdSV9KyZkbIOsrHKWweLdHvoH88iOQbdOR+QspFJ+Fn3/jErJeitCQCqdjcZQIk=@dpdk.org
X-Gm-Message-State: AOJu0YwC27VrY58iNbyFDpMlekEQzthK+o+DoPUSCIlGsjYcQi4P2/2m
 uB9JkKojsOZvdhv9w5BrPW6dI7VlTITpLTqFl8Su0roqUw/fYenj3H66TW438jd0hqLW4oUbpGs
 aXW52Pzol9RiLoCCDoibSrq9k0bqJcYsk9inT3V1/nR2koQ6GfFXZgiTx8c6KivlsyoOay0IUhJ
 +kmusEbXqgqfZJAmZ3v3c=
X-Gm-Gg: ASbGncurUhETucr7+1kvYg6yr4hiMNPZvEZNMAOfNTDmiXhVekz0z5eoj9pIjAs3zuX
 /Pnfxh2BPrXKWC/hi9c/K+UQnjBzSLBiPmFj9oR6bo6xtl4J1FDgSMVSn/x+zlFHVkomxqSdn0M
 HZNCCh/tS4tOE1p7dCSSaXDg==
X-Received: by 2002:a05:6820:f06:b0:618:fb51:c7a8 with SMTP id
 006d021491bc7-6190c9171c8mr8508515eaf.3.1753694098496; 
 Mon, 28 Jul 2025 02:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgGKZz2o1jtoT0cxgQC8ct3CrMPVhvqkFKlTg2AQwz7Dcf1zc+129zi3npD+qaTJ00lZH8NTa6/W96BXotmDM=
X-Received: by 2002:a05:6820:f06:b0:618:fb51:c7a8 with SMTP id
 006d021491bc7-6190c9171c8mr8508495eaf.3.1753694097972; Mon, 28 Jul 2025
 02:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250724161514.396245-1-ktraynor@redhat.com>
In-Reply-To: <20250724161514.396245-1-ktraynor@redhat.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Mon, 28 Jul 2025 17:14:46 +0800
X-Gm-Features: Ac12FXxzmjsG2_jAFnGoceo8VmF6zGPIY5m9KLyj_YurUxCr2K1zP_svbPELYCc
Message-ID: <CAGYh1E8dMW6p3RbikrcbdtNmcOq_VtbY2RBUn5oj26C18+MFqQ@mail.gmail.com>
Subject: Re: 24.11.3 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, 
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>, 
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pyN4X2c9OBZL1TN-7hiC6jb_Od4uEodwSJZ8oKV9ZlM_1753694099
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000c13547063af9b9f3"
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

--000000000000c13547063af9b9f3
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
   - git log

Commit 3fa2030f013bd7c7d102e576b37ee4dca83b9982

Author: Kevin Traynor <ktraynor@redhat.com>

Date:   Thu Jul 24 16:31:46 2025 +0100

    version: 24.11.3-rc1

Signed-off-by: Kevin Traynor <ktraynor@redhat.com>


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>

Best Regards,
Yanghang Liu


On Fri, Jul 25, 2025 at 12:15=E2=80=AFAM Kevin Traynor <ktraynor@redhat.com=
> wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.3.
>
> The planned date for the final release is 12th August 2025.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.11.3-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Kevin
>
> ---
> Amiya Ranjan Mohakud (2):
>       net/iavf: fix VLAN strip setting after enabling filter
>       net/iavf: fix VLAN strip disabling for ADQ v2 capability
>
> Anatoly Burakov (1):
>       net/ixgbe: fix indentation
>
> Andre Muezerie (1):
>       net/mlx5: fix link on Windows
>
> Ariel Otilibili (2):
>       net/af_xdp: fix use after free in zero-copy Tx
>       pcapng: fix null dereference in close
>
> Arkadiusz Kusztal (2):
>       crypto/qat: fix out-of-place header bytes in AEAD raw API
>       crypto/qat: fix out-of-place chain/cipher/auth headers
>
> Bing Zhao (2):
>       net/mlx5: fix WQE size calculation for Tx queue
>       examples/ntb: check more heap allocations
>
> Bruce Richardson (9):
>       net/fm10k/base: fix compilation warnings
>       net/ixgbe/base: correct definition of endianness macro
>       net/ixgbe/base: fix compilation warnings
>       net/i40e/base: fix unused value warnings
>       net/i40e/base: fix compiler warnings
>       net/ice: fix support for 3 scheduler levels
>       test/malloc: improve resiliency
>       power/intel_uncore: fix crash closing uninitialized driver
>       net/ixgbe/base: fix lock checker errors
>
> Chaoyong He (6):
>       net/nfp: fix crash with null RSS hash key
>       net/nfp: fix hash key length logic
>       app/testpmd: fix RSS hash key update
>       net/nfp: standardize NFDk Tx descriptor endianness
>       net/nfp: standardize Rx descriptor endianness
>       net/nfp: standardize NFD3 Tx descriptor endianness
>
> Chengwen Feng (3):
>       app/testpmd: relax number of TCs in DCB command
>       bus: cleanup device lists
>       net/hns3: fix queue TC configuration on VF
>
> Clemens Famulla-Conrad (1):
>       dts: fix deterministic doc
>
> Danylo Vodopianov (3):
>       net/ntnic: avoid divide by zero
>       net/ntnic: fix ring queue operation
>       net/ntnic: remove unused code
>
> Dariusz Sosnowski (7):
>       net/mlx5: fix header modify action on group 0
>       net/mlx5: validate GTP PSC QFI width
>       net/mlx5: fix counter pool init error propagation
>       net/mlx5: fix counter service cleanup on init failure
>       net/mlx5: fix flex tunnel flow validation
>       net/mlx5: fix VLAN stripping on hairpin queue
>       net/mlx5: fix masked indirect age action validation
>
> David Marchand (7):
>       acl: fix build with GCC 15 on aarch64
>       vhost: fix wrapping on control virtqueue rings
>       eal: warn if no lcore is available
>       test/lcore: fix race in per-lcore test
>       common/mlx5: fix dependency detection on Windows
>       doc: remove reference to deprecated --use-device option
>       eal: add description of service corelist in usage
>
> Dengdui Huang (12):
>       net/hns3: fix integer overflow in interrupt unmap
>       net/hns3: fix memory leak on failure
>       net/hns3: fix extra wait for link up
>       net/hns3: fix memory leak for indirect flow action
>       net/hns3: fix interrupt rollback
>       net/hns3: fix divide by zero
>       net/hns3: fix resources release on reset
>       net/hns3: fix CRC data segment
>       mem: fix lockup on address space shortage
>       net/hns3: check requirement for hardware GRO
>       net/hns3: allow Tx vector when fast free not enabled
>       net/hns3: fix Rx packet without CRC data
>
> Dhanya Pillai (2):
>       net/ice: fix flow creation failure
>       net/i40e: fix RSS on plain IPv4
>
> Edvard Fagerholm (1):
>       eal/x86: fix C++ build
>
> Eugenio P=C3=A9rez (2):
>       vhost: search virtqueues driver data in read-only area
>       vhost: fix net control virtqueue used length
>
> Gagandeep Singh (2):
>       common/dpaax: fix PDCP key command race condition
>       common/dpaax: fix PDCP AES only 12-bit SN
>
> Gavin Li (1):
>       net/mlx5: align PF and VF/SF MAC address handling
>
> Gowrishankar Muthukrishnan (5):
>       crypto/cnxk: fix uninitialized variable
>       crypto/cnxk: fix out-of-bounds access in SM2
>       crypto/openssl: include private exponent in RSA session
>       test/crypto: fix RSA vector as per RFC 8017
>       test/crypto: fix RSA decrypt validation
>
> Gregory Etelson (7):
>       net/mlx5: remove unsupported flow meter action in HWS
>       net/mlx5: fix error notification for large flow patterns
>       net/mlx5: fix mark action with shared Rx queue
>       app/testpmd: fix flow random item token
>       net/mlx5: fix access to auxiliary flow data
>       common/mlx5: fix extraction of auxiliary device name
>       bus/auxiliary: fix crash in cleanup
>
> Ivan Malov (1):
>       net/sfc: fix action order on start failure
>
> Jake Freeland (1):
>       bus/pci/bsd: fix device existence check
>
> Jarom=C3=ADr Smr=C4=8Dek (1):
>       doc: add kernel options required for mlx5
>
> Jedrzej Jagielski (1):
>       net/ixgbe/base: fix link status for E610
>
> Jiawen Wu (13):
>       net/txgbe: fix ntuple filter parsing
>       net/txgbe: fix raw pattern match for FDIR rule
>       net/txgbe: fix packet type for FDIR filter
>       net/txgbe: fix to create FDIR filter for SCTP packet
>       net/txgbe: fix FDIR perfect mode for IPv6
>       net/txgbe: fix to create FDIR filter for tunnel packet
>       net/txgbe: fix reserved extra FDIR headroom
>       net/txgbe: fix MAC control frame forwarding
>       net/ngbe: fix MAC control frame forwarding
>       net/txgbe: fix device statistics
>       net/ngbe: fix device statistics
>       net/txgbe: restrict VLAN strip configuration on VF
>       net/txgbe: add LRO flag in mbuf when enabled
>
> Junfeng Guo (1):
>       net/mlx5: fix template flow rule identification
>
> Kaiwen Deng (4):
>       net/ixgbe: enable ethertype filter for E610
>       net/e1000: fix igb Tx queue offloads capability
>       net/e1000: fix xstats name
>       net/ixgbe: skip MACsec stats for E610
>
> Khadem Ullah (1):
>       net/mlx5: fix crash on age query with indirect conntrack
>
> Konstantin Ananyev (1):
>       net/ixgbe: remove VLAs
>
> Long Li (5):
>       bus/vmbus: use Hyper-V page size
>       net/netvsc: use Hyper-V page size
>       net/netvsc: add stats counters from VF
>       net/mana: check vendor ID when probing RDMA device
>       bus/vmbus: align ring buffer data to page boundary
>
> Long Wu (2):
>       net/nfp: fix flow rule freeing
>       net/nfp: fix control message overflow
>
> Lukasz Krakowiak (2):
>       net/ice/base: fix integer overflow
>       net/ice/base: fix typo in device ID description
>
> Maayan Kashani (5):
>       net/mlx5: fix validation for GENEVE options
>       net/mlx5: fix GRE flow item validation
>       net/mlx5/hws: fix send queue drain on FW WQE destroy
>       ethdev: fix error struct in flow configure
>       net/mlx5: fix crash in HWS counter pool destroy
>
> Madhuker Mythri (1):
>       net/bonding: avoid RSS RETA update in flow isolation mode
>
> Marat Khalili (1):
>       buildtools/test: scan muti-line registrations
>
> Mattias R=C3=B6nnblom (1):
>       eventdev: fix flag types consistency
>
> Maxime Coquelin (1):
>       net/mlx5: avoid setting kernel MTU if not needed
>
> Mingjin Ye (2):
>       net/ice: fix querying RSS hash for DCF
>       net/ice: fix handling empty DCF RSS hash
>
> Mohamed Feroz Abdul Majeeth (1):
>       net/octeon_ep: increase mailbox timeout
>
> Morten Br=C3=B8rup (1):
>       eal/unix: fix log message for madvise failure
>
> Nawal Kishor (1):
>       common/cnxk: fix aura offset
>
> Nithin Dabilpuram (1):
>       common/cnxk: fix CQ tail drop
>
> Nithinsen Kaithakadan (4):
>       common/cnxk: fix qsize in CPT iq enable
>       test/crypto: fix auth and cipher case IV length
>       test/crypto: set to null after freeing operation
>       common/cnxk: fix AES-CTR salt handling
>
> Oleksandr Kolomeiets (1):
>       net/ntnic: unmap DMA during queue release
>
> Oleksandr Nahnybida (1):
>       trace: fix overflow in per-lcore trace buffer
>
> Paul Greenwalt (1):
>       net/ice/base: fix media type check
>
> Pavan Nikhilesh (3):
>       event/cnxk: fix missing HW state checks
>       eal: fix return value of lcore role
>       doc: fix missing feature matrix for event device
>
> Praveen Shetty (1):
>       net/idpf: fix truncation of constant value
>
> Pravin Pathak (6):
>       event/dlb2: fix dequeue with CQ depth <=3D 16
>       event/dlb2: fix validaton of LDB port COS ID arguments
>       event/dlb2: fix num single link ports for DLB2.5
>       event/dlb2: fix QID depth xstat
>       event/dlb2: fix public symbol namespace
>       app/eventdev: fix number of releases sent during cleanup
>
> Radu Nicolau (3):
>       crypto/virtio: fix driver cleanup
>       crypto/qat: fix out-of-place chain/cipher/auth headers
>       crypto/virtio: add request check on request side
>
> Rahul Bhansali (2):
>       net/cnxk: fix descriptor count update on reconfig
>       net/cnxk: fix lock for security session operations
>
> Rajesh Mudimadugula (2):
>       vhost/crypto: fix cipher data length
>       crypto/virtio: fix cipher data source length
>
> Rakesh Kudurumalla (2):
>       examples/ipsec-secgw: fix crash with IPv6
>       examples/ipsec-secgw: fix crash in event vector mode
>
> Robin Jarry (1):
>       net: fix IPv6 check for IPv4 compat
>
> Rui Ferreira (2):
>       eal/linux: unregister alarm callback before free
>       eal/freebsd: unregister alarm callback before free
>
> Satheesh Paul (1):
>       common/cnxk: fix E-tag pattern parsing
>
> Shai Brandes (2):
>       net/ena: fix control path interrupt mode
>       net/ena: fix aenq timeout with low poll interval
>
> Shani Peretz (1):
>       app/crypto-perf: fix AAD offset alignment
>
> Stephen Hemminger (4):
>       net/qede: fix use after free
>       bus/fslmc: fix use after free
>       net/null: fix packet copy
>       crypto/qat: fix size calculation for memset
>
> Sucharitha Sarananaga (1):
>       test/crypto: fix EdDSA vector description
>
> Sunyang Wu (1):
>       ethdev: keep promiscuous/allmulti value before disabling
>
> Tanzeel Ahmed (1):
>       examples/flow_filtering: fix make clean
>
> Tejasree Kondoj (2):
>       crypto/cnxk: fix QP stats
>       crypto/cnxk: fix includes
>
> Tirthendu Sarkar (1):
>       event/dlb2: fix default credits based on HW version
>
> Vanshika Shukla (1):
>       crypto/dpaa2_sec: fix uninitialized variable
>
> Viacheslav Ovsiienko (3):
>       net/mlx5: fix hypervisor detection in VLAN workaround
>       net/mlx5: fix out-of-order completions in ordinary Rx burst
>       net/mlx5: fix maximal queue size query
>
> Vidya Sagar Velumuri (2):
>       net/octeon_ep: fix buffer refill
>       crypto/cnxk: update SG list population
>
> Volodymyr Fialko (1):
>       examples/ipsec-secgw: fix number of queue pairs
>
> Waldemar Dworakowski (1):
>       net/ice/base: fix type conversion
>
> Yan Lu (1):
>       net/tap: fix qdisc add failure handling
>
> Yang Ming (1):
>       eal/linux: improve ASLR check
>
> Yuan Wang (2):
>       net/e1000: fix EEPROM dump
>       net/ixgbe: fix port mask default value in filter
>
>

--000000000000c13547063af9b9f3
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
=3D"margin-left:15px">ovs 3.3</li><li style=3D"margin-left:15px">git log</l=
i></ul></font></div></div></div></div></div><blockquote style=3D"margin:0 0=
 0 40px;border:none;padding:0px"><blockquote style=3D"margin:0 0 0 40px;bor=
der:none;padding:0px"><div><div class=3D"gmail_signature"><div><div class=
=3D"gmail_signature"><div><span style=3D"font-family:arial,sans-serif">Comm=
it 3fa2030f013bd7c7d102e576b37ee4dca83b9982</span></div></div></div></div><=
/div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none;paddin=
g:0px"><div><div class=3D"gmail_signature"><div><div class=3D"gmail_signatu=
re"><div><span style=3D"font-family:arial,sans-serif">Author: Kevin Traynor=
 &lt;<a href=3D"mailto:ktraynor@redhat.com">ktraynor@redhat.com</a>&gt;</sp=
an></div></div></div></div></div></blockquote><blockquote style=3D"margin:0=
 0 0 40px;border:none;padding:0px"><div><div class=3D"gmail_signature"><div=
><div class=3D"gmail_signature"><div><span style=3D"font-family:arial,sans-=
serif">Date: =C2=A0 Thu Jul 24 16:31:46 2025 +0100</span></div></div></div>=
</div></div></blockquote><blockquote style=3D"margin:0 0 0 40px;border:none=
;padding:0px"><div><div class=3D"gmail_signature"><div><div class=3D"gmail_=
signature"><div><span style=3D"font-family:arial,sans-serif">=C2=A0 =C2=A0 =
version: 24.11.3-rc1</span></div></div></div></div></div></blockquote><bloc=
kquote style=3D"margin:0 0 0 40px;border:none;padding:0px"><div><div class=
=3D"gmail_signature"><div><div class=3D"gmail_signature"><div><span style=
=3D"font-family:arial,sans-serif">Signed-off-by: Kevin Traynor &lt;<a href=
=3D"mailto:ktraynor@redhat.com">ktraynor@redhat.com</a>&gt;</span></div></d=
iv></div></div></div></blockquote></blockquote><div><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signa=
ture"><font face=3D"arial, sans-serif"><ul><li style=3D"margin-left:15px">T=
est device : X540-AT2 NIC(ixgbe, 10G)</li></ul></font></div></div></div><di=
v dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><div><font face=3D"arial, sans-se=
rif">Tested-by: Yanghang Liu &lt;<a href=3D"mailto:yanghliu@redhat.com" tar=
get=3D"_blank">yanghliu@redhat.com</a>&gt;</font></div></div></div></div></=
div></div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signature" da=
ta-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><=
div>Yanghang Liu<br></div></div></div></div><br></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fr=
i, Jul 25, 2025 at 12:15=E2=80=AFAM Kevin Traynor &lt;<a href=3D"mailto:ktr=
aynor@redhat.com">ktraynor@redhat.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
Here is a list of patches targeted for stable release 24.11.3.<br>
<br>
The planned date for the final release is 12th August 2025.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.=
11.3-rc1" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpdk=
-stable/tag/?id=3Dv24.11.3-rc1</a><br>
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
Amiya Ranjan Mohakud (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix VLAN strip setting after enabling filter=
<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix VLAN strip disabling for ADQ v2 capabili=
ty<br>
<br>
Anatoly Burakov (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix indentation<br>
<br>
Andre Muezerie (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix link on Windows<br>
<br>
Ariel Otilibili (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/af_xdp: fix use after free in zero-copy Tx<br>
=C2=A0 =C2=A0 =C2=A0 pcapng: fix null dereference in close<br>
<br>
Arkadiusz Kusztal (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix out-of-place header bytes in AEAD raw =
API<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix out-of-place chain/cipher/auth headers=
<br>
<br>
Bing Zhao (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix WQE size calculation for Tx queue<br>
=C2=A0 =C2=A0 =C2=A0 examples/ntb: check more heap allocations<br>
<br>
Bruce Richardson (9):<br>
=C2=A0 =C2=A0 =C2=A0 net/fm10k/base: fix compilation warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: correct definition of endianness macro=
<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: fix compilation warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e/base: fix unused value warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e/base: fix compiler warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix support for 3 scheduler levels<br>
=C2=A0 =C2=A0 =C2=A0 test/malloc: improve resiliency<br>
=C2=A0 =C2=A0 =C2=A0 power/intel_uncore: fix crash closing uninitialized dr=
iver<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: fix lock checker errors<br>
<br>
Chaoyong He (6):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix crash with null RSS hash key<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix hash key length logic<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix RSS hash key update<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: standardize NFDk Tx descriptor endianness<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: standardize Rx descriptor endianness<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: standardize NFD3 Tx descriptor endianness<br>
<br>
Chengwen Feng (3):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: relax number of TCs in DCB command<br>
=C2=A0 =C2=A0 =C2=A0 bus: cleanup device lists<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix queue TC configuration on VF<br>
<br>
Clemens Famulla-Conrad (1):<br>
=C2=A0 =C2=A0 =C2=A0 dts: fix deterministic doc<br>
<br>
Danylo Vodopianov (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/ntnic: avoid divide by zero<br>
=C2=A0 =C2=A0 =C2=A0 net/ntnic: fix ring queue operation<br>
=C2=A0 =C2=A0 =C2=A0 net/ntnic: remove unused code<br>
<br>
Dariusz Sosnowski (7):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix header modify action on group 0<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: validate GTP PSC QFI width<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix counter pool init error propagation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix counter service cleanup on init failure<=
br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flex tunnel flow validation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix VLAN stripping on hairpin queue<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix masked indirect age action validation<br=
>
<br>
David Marchand (7):<br>
=C2=A0 =C2=A0 =C2=A0 acl: fix build with GCC 15 on aarch64<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix wrapping on control virtqueue rings<br>
=C2=A0 =C2=A0 =C2=A0 eal: warn if no lcore is available<br>
=C2=A0 =C2=A0 =C2=A0 test/lcore: fix race in per-lcore test<br>
=C2=A0 =C2=A0 =C2=A0 common/mlx5: fix dependency detection on Windows<br>
=C2=A0 =C2=A0 =C2=A0 doc: remove reference to deprecated --use-device optio=
n<br>
=C2=A0 =C2=A0 =C2=A0 eal: add description of service corelist in usage<br>
<br>
Dengdui Huang (12):<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix integer overflow in interrupt unmap<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix memory leak on failure<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix extra wait for link up<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix memory leak for indirect flow action<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix interrupt rollback<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix divide by zero<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix resources release on reset<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix CRC data segment<br>
=C2=A0 =C2=A0 =C2=A0 mem: fix lockup on address space shortage<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: check requirement for hardware GRO<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: allow Tx vector when fast free not enabled<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix Rx packet without CRC data<br>
<br>
Dhanya Pillai (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix flow creation failure<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e: fix RSS on plain IPv4<br>
<br>
Edvard Fagerholm (1):<br>
=C2=A0 =C2=A0 =C2=A0 eal/x86: fix C++ build<br>
<br>
Eugenio P=C3=A9rez (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: search virtqueues driver data in read-only area=
<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix net control virtqueue used length<br>
<br>
Gagandeep Singh (2):<br>
=C2=A0 =C2=A0 =C2=A0 common/dpaax: fix PDCP key command race condition<br>
=C2=A0 =C2=A0 =C2=A0 common/dpaax: fix PDCP AES only 12-bit SN<br>
<br>
Gavin Li (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: align PF and VF/SF MAC address handling<br>
<br>
Gowrishankar Muthukrishnan (5):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: fix uninitialized variable<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: fix out-of-bounds access in SM2<br>
=C2=A0 =C2=A0 =C2=A0 crypto/openssl: include private exponent in RSA sessio=
n<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix RSA vector as per RFC 8017<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix RSA decrypt validation<br>
<br>
Gregory Etelson (7):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: remove unsupported flow meter action in HWS<=
br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix error notification for large flow patter=
ns<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix mark action with shared Rx queue<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix flow random item token<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix access to auxiliary flow data<br>
=C2=A0 =C2=A0 =C2=A0 common/mlx5: fix extraction of auxiliary device name<b=
r>
=C2=A0 =C2=A0 =C2=A0 bus/auxiliary: fix crash in cleanup<br>
<br>
Ivan Malov (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/sfc: fix action order on start failure<br>
<br>
Jake Freeland (1):<br>
=C2=A0 =C2=A0 =C2=A0 bus/pci/bsd: fix device existence check<br>
<br>
Jarom=C3=ADr Smr=C4=8Dek (1):<br>
=C2=A0 =C2=A0 =C2=A0 doc: add kernel options required for mlx5<br>
<br>
Jedrzej Jagielski (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: fix link status for E610<br>
<br>
Jiawen Wu (13):<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix ntuple filter parsing<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix raw pattern match for FDIR rule<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix packet type for FDIR filter<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix to create FDIR filter for SCTP packet<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix FDIR perfect mode for IPv6<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix to create FDIR filter for tunnel packet=
<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix reserved extra FDIR headroom<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix MAC control frame forwarding<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix MAC control frame forwarding<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix device statistics<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix device statistics<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: restrict VLAN strip configuration on VF<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: add LRO flag in mbuf when enabled<br>
<br>
Junfeng Guo (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix template flow rule identification<br>
<br>
Kaiwen Deng (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: enable ethertype filter for E610<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix igb Tx queue offloads capability<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix xstats name<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: skip MACsec stats for E610<br>
<br>
Khadem Ullah (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix crash on age query with indirect conntra=
ck<br>
<br>
Konstantin Ananyev (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: remove VLAs<br>
<br>
Long Li (5):<br>
=C2=A0 =C2=A0 =C2=A0 bus/vmbus: use Hyper-V page size<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: use Hyper-V page size<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: add stats counters from VF<br>
=C2=A0 =C2=A0 =C2=A0 net/mana: check vendor ID when probing RDMA device<br>
=C2=A0 =C2=A0 =C2=A0 bus/vmbus: align ring buffer data to page boundary<br>
<br>
Long Wu (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix flow rule freeing<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix control message overflow<br>
<br>
Lukasz Krakowiak (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix integer overflow<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix typo in device ID description<br>
<br>
Maayan Kashani (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix validation for GENEVE options<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix GRE flow item validation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix send queue drain on FW WQE destroy<b=
r>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix error struct in flow configure<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix crash in HWS counter pool destroy<br>
<br>
Madhuker Mythri (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: avoid RSS RETA update in flow isolation m=
ode<br>
<br>
Marat Khalili (1):<br>
=C2=A0 =C2=A0 =C2=A0 buildtools/test: scan muti-line registrations<br>
<br>
Mattias R=C3=B6nnblom (1):<br>
=C2=A0 =C2=A0 =C2=A0 eventdev: fix flag types consistency<br>
<br>
Maxime Coquelin (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: avoid setting kernel MTU if not needed<br>
<br>
Mingjin Ye (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix querying RSS hash for DCF<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix handling empty DCF RSS hash<br>
<br>
Mohamed Feroz Abdul Majeeth (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: increase mailbox timeout<br>
<br>
Morten Br=C3=B8rup (1):<br>
=C2=A0 =C2=A0 =C2=A0 eal/unix: fix log message for madvise failure<br>
<br>
Nawal Kishor (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix aura offset<br>
<br>
Nithin Dabilpuram (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix CQ tail drop<br>
<br>
Nithinsen Kaithakadan (4):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix qsize in CPT iq enable<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix auth and cipher case IV length<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: set to null after freeing operation<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix AES-CTR salt handling<br>
<br>
Oleksandr Kolomeiets (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ntnic: unmap DMA during queue release<br>
<br>
Oleksandr Nahnybida (1):<br>
=C2=A0 =C2=A0 =C2=A0 trace: fix overflow in per-lcore trace buffer<br>
<br>
Paul Greenwalt (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix media type check<br>
<br>
Pavan Nikhilesh (3):<br>
=C2=A0 =C2=A0 =C2=A0 event/cnxk: fix missing HW state checks<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix return value of lcore role<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix missing feature matrix for event device<br>
<br>
Praveen Shetty (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/idpf: fix truncation of constant value<br>
<br>
Pravin Pathak (6):<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix dequeue with CQ depth &lt;=3D 16<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix validaton of LDB port COS ID arguments=
<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix num single link ports for DLB2.5<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix QID depth xstat<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix public symbol namespace<br>
=C2=A0 =C2=A0 =C2=A0 app/eventdev: fix number of releases sent during clean=
up<br>
<br>
Radu Nicolau (3):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix driver cleanup<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix out-of-place chain/cipher/auth headers=
<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: add request check on request side<br>
<br>
Rahul Bhansali (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix descriptor count update on reconfig<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix lock for security session operations<br>
<br>
Rajesh Mudimadugula (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost/crypto: fix cipher data length<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix cipher data source length<br>
<br>
Rakesh Kudurumalla (2):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix crash with IPv6<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix crash in event vector mode<b=
r>
<br>
Robin Jarry (1):<br>
=C2=A0 =C2=A0 =C2=A0 net: fix IPv6 check for IPv4 compat<br>
<br>
Rui Ferreira (2):<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: unregister alarm callback before free<br>
=C2=A0 =C2=A0 =C2=A0 eal/freebsd: unregister alarm callback before free<br>
<br>
Satheesh Paul (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix E-tag pattern parsing<br>
<br>
Shai Brandes (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ena: fix control path interrupt mode<br>
=C2=A0 =C2=A0 =C2=A0 net/ena: fix aenq timeout with low poll interval<br>
<br>
Shani Peretz (1):<br>
=C2=A0 =C2=A0 =C2=A0 app/crypto-perf: fix AAD offset alignment<br>
<br>
Stephen Hemminger (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix use after free<br>
=C2=A0 =C2=A0 =C2=A0 bus/fslmc: fix use after free<br>
=C2=A0 =C2=A0 =C2=A0 net/null: fix packet copy<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix size calculation for memset<br>
<br>
Sucharitha Sarananaga (1):<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix EdDSA vector description<br>
<br>
Sunyang Wu (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: keep promiscuous/allmulti value before disabli=
ng<br>
<br>
Tanzeel Ahmed (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/flow_filtering: fix make clean<br>
<br>
Tejasree Kondoj (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: fix QP stats<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: fix includes<br>
<br>
Tirthendu Sarkar (1):<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix default credits based on HW version<br=
>
<br>
Vanshika Shukla (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/dpaa2_sec: fix uninitialized variable<br>
<br>
Viacheslav Ovsiienko (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix hypervisor detection in VLAN workaround<=
br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix out-of-order completions in ordinary Rx =
burst<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix maximal queue size query<br>
<br>
Vidya Sagar Velumuri (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: fix buffer refill<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: update SG list population<br>
<br>
Volodymyr Fialko (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix number of queue pairs<br>
<br>
Waldemar Dworakowski (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix type conversion<br>
<br>
Yan Lu (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/tap: fix qdisc add failure handling<br>
<br>
Yang Ming (1):<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: improve ASLR check<br>
<br>
Yuan Wang (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix EEPROM dump<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix port mask default value in filter<br>
<br>
</blockquote></div>

--000000000000c13547063af9b9f3--

