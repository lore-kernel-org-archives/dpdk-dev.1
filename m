Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D13ECA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 15:33:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7504D40667;
	Tue, 19 Aug 2025 17:33:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9993F40653
 for <dev@dpdk.org>; Tue, 19 Aug 2025 17:33:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755617621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QgNihuhEFHah1760jMHzc8rEVWeWq6/1Ska60jm6jOk=;
 b=AvH4Vlm0JReaQIAftAJij9lhh8Lr52GyOsdpnxHk/UqagTzpcc26XiSceBxyftlWtNZ9gX
 M5UKKa2YRAeHpjy3dqKHakfNeU9iJSZwCvefsh6gkDLlB7pykz19iqkKi5ec29n0EP/XLv
 i5lrj/NZbadQhqA+DyqTbZiRBWkcA5A=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-oXikUf0TNiK7cHvn0ncMMA-1; Tue, 19 Aug 2025 11:33:39 -0400
X-MC-Unique: oXikUf0TNiK7cHvn0ncMMA-1
X-Mimecast-MFC-AGG-ID: oXikUf0TNiK7cHvn0ncMMA_1755617618
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-61c0b691f1bso2697eaf.0
 for <dev@dpdk.org>; Tue, 19 Aug 2025 08:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617618; x=1756222418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QgNihuhEFHah1760jMHzc8rEVWeWq6/1Ska60jm6jOk=;
 b=rY/Ui1AWBBYXrlkgqussmMaBsRJ7et9UQNg8OqFisblDK4ihDHXioo+HRC+84GXTwy
 jEdI8oLVLlMgwAamOd9gVgZG1mddJuhcEY03D/wz+D5mHGYCNI+68VH0dPPdnVgXoVB0
 kjAW1J38EU6XRr90GuACAyvEVs9IxmBibGswv5QnlDqr/SQEIeUQ9shyZMgOlpn9U7t8
 dhqm/NI2T0f4FkqvBxye4GULuGptffxvuAsNzEhjQ/AOx2ZLUPggcaaSxApH405BMIW9
 2sj8pVFvCVMrTztNXJ5cSueuEN6q2eEauMunvofoGfq5f6OEV+orRS1D6711hUhnd/uT
 Fz0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5at5P/XCBIqNbsBmJ/k8hOMbI4zJPd7wDj7dSw9A4tAm/pOxR1wikoMk+ZSTe4oQDLlY=@dpdk.org
X-Gm-Message-State: AOJu0YwB0DzpXwzmPHJ3sTwGEd0T698anz8/i2UALtTB2U/OOypqrHAv
 5Ik3ySObbFdKftAXre/sI7CeHZvlAeyy3/H3I9AQAwOEbOWDp3kZmXNOqARTDrrUJ8R/tosBG3/
 AJOxzXB1//fq+8hz6NHojtgcqULIPvGLKFiblZ/PxM+Z3hdFwZoUb22YXc3ucgXu3NjRK2uvwR2
 /mfsHURwNLc69lfd96TcA=
X-Gm-Gg: ASbGncuwUSOsfUXhXyTKhrcdKhwP41PI/xca9VEOOHyiCkzuFLURAFibsZls0C2HqQ9
 EvcrQrVugIa56Sq/tu5ZDGAfrQRhsQxY3OHxuR6JfzNENjnc3EEXyTBnSvStpcIgRyTv7Iic8Xw
 HT4VLRay8XDntNdTUoYS0qag==
X-Received: by 2002:a05:6820:461b:b0:611:758f:1fa4 with SMTP id
 006d021491bc7-61d91b7c244mr1442956eaf.0.1755617618370; 
 Tue, 19 Aug 2025 08:33:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGsJQMu3PT5hEJxk80WDpGDC+KEvQv/tkno7HdHvvGbtmgVBCpLEqLUmR8cJQxX/vykVsvLzMTCDjL7cLwnbI=
X-Received: by 2002:a05:6820:461b:b0:611:758f:1fa4 with SMTP id
 006d021491bc7-61d91b7c244mr1442929eaf.0.1755617617835; Tue, 19 Aug 2025
 08:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250811134220.45579-1-xuemingl@nvidia.com>
In-Reply-To: <20250811134220.45579-1-xuemingl@nvidia.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Tue, 19 Aug 2025 23:33:26 +0800
X-Gm-Features: Ac12FXzan-ggG0aH0X-7uiRAV3ChUPEvClKDo7PDJ_C2pd-YiohADVJGUFZYesU
Message-ID: <CAGYh1E-1U9WiNvNAPnssFZ9k_r_VVD8fFnoodxFXDzzT8zk6GA@mail.gmail.com>
Subject: Re: 23.11.5 patches review and test
To: Xueming Li <xuemingl@nvidia.com>
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
 benjamin.walker@intel.com, 
 qian.q.xu@intel.com, yuan.peng@intel.com, zhaoyan.chen@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qsqn-0HysD97vJVJHKuro5LO7puIgOBmq3Sc8sBeWtw_1755617618
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000793d41063cb9945f"
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

--000000000000793d41063cb9945f
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
   - git log

commit 96ae1d570472620165484776205fe957294b9597

Author: Xueming Li <xuemingl@nvidia.com>

Date:   Mon Aug 11 21:33:43 2025 +0800

version: 23.11.5-rc1

Signed-off-by: Xueming Li <xuemingl@nvidia.com>


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>


Best Regards,
Yanghang Liu


On Mon, Aug 11, 2025 at 9:44=E2=80=AFPM Xueming Li <xuemingl@nvidia.com> wr=
ote:

> Hi all,
>
> Here is a list of patches targeted for stable release 23.11.5.
>
> The planned date for the final release is 15th August.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.11.5-rc1
>
> These patches are located at branch 23.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Xueming Li <xuemingl@nvidia.com>
>
> ---
> Amiya Ranjan Mohakud (1):
>       net/iavf: fix VLAN strip setting after enabling filter
>
> Anatoly Burakov (1):
>       net/ixgbe: fix indentation
>
> Ariel Otilibili (1):
>       net/af_xdp: fix use after free in zero-copy Tx
>
> Arkadiusz Kusztal (2):
>       crypto/qat: fix out-of-place header bytes in AEAD raw API
>       crypto/qat: fix out-of-place chain/cipher/auth headers
>
> Bing Zhao (2):
>       net/mlx5: fix WQE size calculation for Tx queue
>       examples/ntb: check more heap allocations
>
> Bruce Richardson (8):
>       net/fm10k/base: fix compilation warnings
>       net/ixgbe/base: correct definition of endianness macro
>       net/ixgbe/base: fix compilation warnings
>       net/i40e/base: fix unused value warnings
>       net/i40e/base: fix compiler warnings
>       test/malloc: improve resiliency
>       power/intel_uncore: fix crash closing uninitialized driver
>       net/ice: fix inconsistency in Rx queue VLAN tag placement
>
> Chaoyong He (5):
>       net/nfp: fix crash with null RSS hash key
>       net/nfp: fix hash key length logic
>       app/testpmd: fix RSS hash key update
>       net/nfp: standardize NFD3 Tx descriptor endianness
>       net/nfp: standardize NFDk Tx descriptor endianness
>
> Chengwen Feng (3):
>       app/testpmd: relax number of TCs in DCB command
>       bus: cleanup device lists
>       net/hns3: fix queue TC configuration on VF
>
> Clemens Famulla-Conrad (1):
>       dts: fix deterministic doc
>
> Dariusz Sosnowski (5):
>       net/mlx5: fix header modify action on group 0
>       net/mlx5: validate GTP PSC QFI width
>       net/mlx5: fix counter service cleanup on init failure
>       net/mlx5: fix VLAN stripping on hairpin queue
>       net/mlx5: fix masked indirect age action validation
>
> David Marchand (7):
>       acl: fix build with GCC 15 on aarch64
>       vhost: fix wrapping on control virtqueue rings
>       eal: warn if no lcore is available
>       test/lcore: fix race in per-lcore test
>       doc: remove reference to deprecated --use-device option
>       eal: add description of service corelist in usage
>       net/virtio: revert Tx free threshold fix
>
> Dengdui Huang (13):
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
>       net/hns3: allow Rx vector mode with VLAN filter
>       net/hns3: fix Rx packet without CRC data
>
> Dhanya Pillai (2):
>       net/ice: fix flow creation failure
>       net/i40e: fix RSS on plain IPv4
>
> Eugenio P=C3=A9rez (2):
>       vhost: fix net control virtqueue used length
>       vhost: search virtqueues driver data in read-only area
>
> Ferruh Yigit (1):
>       ethdev: convert string initialization
>
> Gagandeep Singh (2):
>       common/dpaax: fix PDCP key command race condition
>       common/dpaax: fix PDCP AES only 12-bit SN
>
> Gavin Li (1):
>       net/mlx5: align PF and VF/SF MAC address handling
>
> Gowrishankar Muthukrishnan (2):
>       crypto/openssl: include private exponent in RSA session
>       test/crypto: fix RSA decrypt validation
>
> Gregory Etelson (4):
>       net/mlx5: remove unsupported flow meter action in HWS
>       net/mlx5: fix mark action with shared Rx queue
>       common/mlx5: fix extraction of auxiliary device name
>       bus/auxiliary: fix crash in cleanup
>
> Hengqi Chen (1):
>       net/virtio: fix check of threshold for Tx freeing
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
> Jiawen Wu (11):
>       net/txgbe: fix ntuple filter parsing
>       net/txgbe: fix raw pattern match for FDIR rule
>       net/txgbe: fix MAC control frame forwarding
>       net/ngbe: fix MAC control frame forwarding
>       net/txgbe: fix device statistics
>       net/ngbe: fix device statistics
>       net/txgbe: restrict VLAN strip configuration on VF
>       net/txgbe: fix packet type for FDIR filter
>       net/txgbe: fix to create FDIR filter for SCTP packet
>       net/txgbe: fix reserved extra FDIR headroom
>       net/txgbe: add LRO flag in mbuf when enabled
>
> Kaiwen Deng (3):
>       net/e1000: fix xstats name
>       net/ixgbe: enable ethertype filter for E610
>       net/e1000: fix igb Tx queue offloads capability
>
> Khadem Ullah (1):
>       net/mlx5: fix crash on age query with indirect conntrack
>
> Long Li (5):
>       bus/vmbus: align ring buffer data to page boundary
>       bus/vmbus: use Hyper-V page size
>       net/netvsc: use Hyper-V page size
>       net/netvsc: add stats counters from VF
>       net/mana: check vendor ID when probing RDMA device
>
> Lukasz Krakowiak (2):
>       net/ice/base: fix integer overflow
>       net/ice/base: fix typo in device ID description
>
> Maayan Kashani (4):
>       net/mlx5/hws: fix send queue drain on FW WQE destroy
>       ethdev: fix error struct in flow configure
>       examples/multi_process: fix ports cleanup on exit
>       net/mlx5: fix crash in HWS counter pool destroy
>
> Madhuker Mythri (1):
>       net/bonding: avoid RSS RETA update in flow isolation mode
>
> Marat Khalili (1):
>       buildtools/test: scan muti-line registrations
>
> Maxime Coquelin (1):
>       net/mlx5: avoid setting kernel MTU if not needed
>
> Mingjin Ye (2):
>       net/ice: fix handling empty DCF RSS hash
>       net/ice: fix querying RSS hash for DCF
>
> Mohamed Feroz Abdul Majeeth (1):
>       net/octeon_ep: increase mailbox timeout
>
> Morten Br=C3=B8rup (1):
>       eal/unix: fix log message for madvise failure
>
> Nithin Dabilpuram (1):
>       common/cnxk: fix CQ tail drop
>
> Nithinsen Kaithakadan (3):
>       test/crypto: fix auth and cipher case IV length
>       test/crypto: set to null after freeing operation
>       common/cnxk: fix qsize in CPT iq enable
>
> Oleksandr Nahnybida (1):
>       trace: fix overflow in per-lcore trace buffer
>
> Pavan Nikhilesh (1):
>       eal: fix return value of lcore role
>
> Pravin Pathak (6):
>       event/dlb2: fix validaton of LDB port COS ID arguments
>       event/dlb2: fix num single link ports for DLB2.5
>       event/dlb2: fix QID depth xstat
>       event/dlb2: fix public symbol namespace
>       app/eventdev: fix number of releases sent during cleanup
>       event/dlb2: fix dequeue with CQ depth <=3D 16
>
> Radu Nicolau (2):
>       crypto/virtio: add request check on request side
>       crypto/virtio: fix driver cleanup
>
> Rahul Bhansali (2):
>       net/cnxk: fix descriptor count update on reconfig
>       common/cnxk: fix null pointer checks
>
> Rajesh Mudimadugula (3):
>       vhost/crypto: fix cipher data length
>       crypto/virtio: fix cipher data source length
>       crypto/virtio: fix driver ID
>
> Rakesh Kudurumalla (2):
>       examples/ipsec-secgw: fix crash with IPv6
>       examples/ipsec-secgw: fix crash in event vector mode
>
> Rui Ferreira (2):
>       eal/linux: unregister alarm callback before free
>       eal/freebsd: unregister alarm callback before free
>
> Satheesh Paul (1):
>       common/cnxk: fix E-tag pattern parsing
>
> Shani Peretz (1):
>       app/crypto-perf: fix AAD offset alignment
>
> Stephen Hemminger (5):
>       net/qede: fix use after free
>       bus/fslmc: fix use after free
>       net/null: fix packet copy
>       crypto/qat: fix size calculation for memset
>       latencystats: fix receive sample race
>
> Sunyang Wu (1):
>       ethdev: keep promiscuous/allmulti value before disabling
>
> Tanzeel Ahmed (1):
>       examples/flow_filtering: fix make clean
>
> Thomas Monjalon (1):
>       examples/multi_process: revert ports cleanup on exit
>
> Tirthendu Sarkar (1):
>       event/dlb2: fix default credits based on HW version
>
> Vanshika Shukla (1):
>       crypto/dpaa2_sec: fix uninitialized variable
>
> Viacheslav Ovsiienko (3):
>       net/mlx5: fix maximal queue size query
>       net/mlx5: fix hypervisor detection in VLAN workaround
>       net/mlx5: fix out-of-order completions in ordinary Rx burst
>
> Volodymyr Fialko (1):
>       examples/ipsec-secgw: fix number of queue pairs
>
> Xueming Li (1):
>       Revert "net/ice: fix inconsistency in Rx queue VLAN tag placement"
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

--000000000000793d41063cb9945f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div dir=3D"ltr" class=3D"gmail_signature"><div =
dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><fo=
nt face=3D"arial, sans-serif">I tested below 18 scenarios on RHEL 10.0 host=
 and didn&#39;t find any new dpdk issues.</font></div><div dir=3D"ltr"><ul>=
<li style=3D"margin-left:15px">VM with device assignment(PF) throughput tes=
ting(1G hugepage size): PASS</li><li style=3D"margin-left:15px">VM with dev=
ice assignment(PF) throughput testing(2M hugepage size) : PASS</li><li styl=
e=3D"margin-left:15px">VM with device assignment(VF) throughput testing: PA=
SS</li><li style=3D"margin-left:15px">PVP (host dpdk testpmd as vswitch) 1Q=
: throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-use=
r 2Q throughput testing: PASS</li><li style=3D"margin-left:15px">PVP vhost-=
user 1Q - cross numa node throughput testing: PASS</li><li style=3D"margin-=
left:15px">VM with vhost-user 2 queues throughput testing: PASS</li><li sty=
le=3D"margin-left:15px">vhost-user reconnect with dpdk-client, qemu-server(=
qemu reconnect): PASS</li><li style=3D"margin-left:15px">vhost-user reconne=
ct with dpdk-client, qemu-server(ovs reconnect): PASS</li><li style=3D"marg=
in-left:15px">PVP =C2=A0reconnect with dpdk-client, qemu-server: PASS</li><=
li style=3D"margin-left:15px">PVP 1Q live migration testing: PASS</li><li s=
tyle=3D"margin-left:15px">PVP 1Q cross numa node live migration testing: PA=
SS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 1Q live m=
igration testing: PASS</li><li style=3D"margin-left:15px">VM with ovs+dpdk+=
vhost-user 1Q live migration testing (2M): PASS</li><li style=3D"margin-lef=
t:15px">VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS</li><li=
 style=3D"margin-left:15px">VM with ovs+dpdk+vhost-user 4Q live migration t=
esting: PASS</li><li style=3D"margin-left:15px">Host PF + DPDK testing: PAS=
S</li><li style=3D"margin-left:15px">Host VF + DPDK testing: PASS</li></ul>=
</div><div><br><font face=3D"arial, sans-serif">Test Versions:<br><ul><li s=
tyle=3D"margin-left:15px">qemu-kvm-9.1.0</li><li style=3D"margin-left:15px"=
>kernel 6.12</li><li style=3D"margin-left:15px">libvirt 10.10</li><li style=
=3D"margin-left:15px">ovs 3.3</li><li style=3D"margin-left:15px">git log</l=
i></ul></font></div></div></div></div></div></div><blockquote style=3D"marg=
in:0 0 0 40px;border:none;padding:0px"><div><blockquote style=3D"margin:0px=
 0px 0px 40px;border:none;padding:0px"><font face=3D"arial, sans-serif">com=
mit 96ae1d570472620165484776205fe957294b9597</font></blockquote></div><div>=
<blockquote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px"><font=
 face=3D"arial, sans-serif">Author: Xueming Li &lt;<a href=3D"mailto:xuemin=
gl@nvidia.com">xuemingl@nvidia.com</a>&gt;</font></blockquote></div><div><b=
lockquote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px"><font f=
ace=3D"arial, sans-serif">Date: =C2=A0 Mon Aug 11 21:33:43 2025 +0800</font=
></blockquote></div><div><blockquote style=3D"margin:0px 0px 0px 40px;borde=
r:none;padding:0px"><font face=3D"arial, sans-serif">version: 23.11.5-rc1</=
font></blockquote></div><div><blockquote style=3D"margin:0px 0px 0px 40px;b=
order:none;padding:0px"><div class=3D"gmail_signature"><div class=3D"gmail_=
signature"><pre><font face=3D"arial, sans-serif">Signed-off-by: Xueming Li =
&lt;<a href=3D"mailto:xuemingl@nvidia.com">xuemingl@nvidia.com</a>&gt;</fon=
t></pre></div></div></blockquote></div></blockquote><div><div><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gm=
ail_signature"><font face=3D"arial, sans-serif"><ul><li style=3D"margin-lef=
t:15px">Test device : X540-AT2 NIC(ixgbe, 10G)</li></ul></font></div></div>=
</div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><font face=3D"aria=
l, sans-serif">Tested-by: Yanghang Liu &lt;<a href=3D"mailto:yanghliu@redha=
t.com" target=3D"_blank">yanghliu@redhat.com</a>&gt;</font></div></div></di=
v></div></div></div></div><div><br></div><div><br></div><div><div dir=3D"lt=
r" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D=
"ltr"><div>Best Regards,</div><div>Yanghang Liu<br></div></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, Aug 11, 2025 at 9:44=E2=80=AFPM Xueming L=
i &lt;<a href=3D"mailto:xuemingl@nvidia.com">xuemingl@nvidia.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
Here is a list of patches targeted for stable release 23.11.5.<br>
<br>
The planned date for the final release is 15th August.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv23.=
11.5-rc1" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpdk=
-stable/tag/?id=3Dv23.11.5-rc1</a><br>
<br>
These patches are located at branch 23.11 of dpdk-stable repo:<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/" rel=3D"noref=
errer" target=3D"_blank">https://dpdk.org/browse/dpdk-stable/</a><br>
<br>
Thanks.<br>
<br>
Xueming Li &lt;<a href=3D"mailto:xuemingl@nvidia.com" target=3D"_blank">xue=
mingl@nvidia.com</a>&gt;<br>
<br>
---<br>
Amiya Ranjan Mohakud (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix VLAN strip setting after enabling filter=
<br>
<br>
Anatoly Burakov (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix indentation<br>
<br>
Ariel Otilibili (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/af_xdp: fix use after free in zero-copy Tx<br>
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
Bruce Richardson (8):<br>
=C2=A0 =C2=A0 =C2=A0 net/fm10k/base: fix compilation warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: correct definition of endianness macro=
<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: fix compilation warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e/base: fix unused value warnings<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e/base: fix compiler warnings<br>
=C2=A0 =C2=A0 =C2=A0 test/malloc: improve resiliency<br>
=C2=A0 =C2=A0 =C2=A0 power/intel_uncore: fix crash closing uninitialized dr=
iver<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix inconsistency in Rx queue VLAN tag placem=
ent<br>
<br>
Chaoyong He (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix crash with null RSS hash key<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix hash key length logic<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix RSS hash key update<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: standardize NFD3 Tx descriptor endianness<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: standardize NFDk Tx descriptor endianness<br>
<br>
Chengwen Feng (3):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: relax number of TCs in DCB command<br>
=C2=A0 =C2=A0 =C2=A0 bus: cleanup device lists<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix queue TC configuration on VF<br>
<br>
Clemens Famulla-Conrad (1):<br>
=C2=A0 =C2=A0 =C2=A0 dts: fix deterministic doc<br>
<br>
Dariusz Sosnowski (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix header modify action on group 0<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: validate GTP PSC QFI width<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix counter service cleanup on init failure<=
br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix VLAN stripping on hairpin queue<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix masked indirect age action validation<br=
>
<br>
David Marchand (7):<br>
=C2=A0 =C2=A0 =C2=A0 acl: fix build with GCC 15 on aarch64<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix wrapping on control virtqueue rings<br>
=C2=A0 =C2=A0 =C2=A0 eal: warn if no lcore is available<br>
=C2=A0 =C2=A0 =C2=A0 test/lcore: fix race in per-lcore test<br>
=C2=A0 =C2=A0 =C2=A0 doc: remove reference to deprecated --use-device optio=
n<br>
=C2=A0 =C2=A0 =C2=A0 eal: add description of service corelist in usage<br>
=C2=A0 =C2=A0 =C2=A0 net/virtio: revert Tx free threshold fix<br>
<br>
Dengdui Huang (13):<br>
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
=C2=A0 =C2=A0 =C2=A0 net/hns3: allow Rx vector mode with VLAN filter<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix Rx packet without CRC data<br>
<br>
Dhanya Pillai (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix flow creation failure<br>
=C2=A0 =C2=A0 =C2=A0 net/i40e: fix RSS on plain IPv4<br>
<br>
Eugenio P=C3=A9rez (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix net control virtqueue used length<br>
=C2=A0 =C2=A0 =C2=A0 vhost: search virtqueues driver data in read-only area=
<br>
<br>
Ferruh Yigit (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: convert string initialization<br>
<br>
Gagandeep Singh (2):<br>
=C2=A0 =C2=A0 =C2=A0 common/dpaax: fix PDCP key command race condition<br>
=C2=A0 =C2=A0 =C2=A0 common/dpaax: fix PDCP AES only 12-bit SN<br>
<br>
Gavin Li (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: align PF and VF/SF MAC address handling<br>
<br>
Gowrishankar Muthukrishnan (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/openssl: include private exponent in RSA sessio=
n<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix RSA decrypt validation<br>
<br>
Gregory Etelson (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: remove unsupported flow meter action in HWS<=
br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix mark action with shared Rx queue<br>
=C2=A0 =C2=A0 =C2=A0 common/mlx5: fix extraction of auxiliary device name<b=
r>
=C2=A0 =C2=A0 =C2=A0 bus/auxiliary: fix crash in cleanup<br>
<br>
Hengqi Chen (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/virtio: fix check of threshold for Tx freeing<br>
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
Jiawen Wu (11):<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix ntuple filter parsing<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix raw pattern match for FDIR rule<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix MAC control frame forwarding<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix MAC control frame forwarding<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix device statistics<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix device statistics<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: restrict VLAN strip configuration on VF<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix packet type for FDIR filter<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix to create FDIR filter for SCTP packet<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: fix reserved extra FDIR headroom<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: add LRO flag in mbuf when enabled<br>
<br>
Kaiwen Deng (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix xstats name<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: enable ethertype filter for E610<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix igb Tx queue offloads capability<br>
<br>
Khadem Ullah (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix crash on age query with indirect conntra=
ck<br>
<br>
Long Li (5):<br>
=C2=A0 =C2=A0 =C2=A0 bus/vmbus: align ring buffer data to page boundary<br>
=C2=A0 =C2=A0 =C2=A0 bus/vmbus: use Hyper-V page size<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: use Hyper-V page size<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: add stats counters from VF<br>
=C2=A0 =C2=A0 =C2=A0 net/mana: check vendor ID when probing RDMA device<br>
<br>
Lukasz Krakowiak (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix integer overflow<br>
=C2=A0 =C2=A0 =C2=A0 net/ice/base: fix typo in device ID description<br>
<br>
Maayan Kashani (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix send queue drain on FW WQE destroy<b=
r>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix error struct in flow configure<br>
=C2=A0 =C2=A0 =C2=A0 examples/multi_process: fix ports cleanup on exit<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix crash in HWS counter pool destroy<br>
<br>
Madhuker Mythri (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: avoid RSS RETA update in flow isolation m=
ode<br>
<br>
Marat Khalili (1):<br>
=C2=A0 =C2=A0 =C2=A0 buildtools/test: scan muti-line registrations<br>
<br>
Maxime Coquelin (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: avoid setting kernel MTU if not needed<br>
<br>
Mingjin Ye (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix handling empty DCF RSS hash<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix querying RSS hash for DCF<br>
<br>
Mohamed Feroz Abdul Majeeth (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: increase mailbox timeout<br>
<br>
Morten Br=C3=B8rup (1):<br>
=C2=A0 =C2=A0 =C2=A0 eal/unix: fix log message for madvise failure<br>
<br>
Nithin Dabilpuram (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix CQ tail drop<br>
<br>
Nithinsen Kaithakadan (3):<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix auth and cipher case IV length<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: set to null after freeing operation<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix qsize in CPT iq enable<br>
<br>
Oleksandr Nahnybida (1):<br>
=C2=A0 =C2=A0 =C2=A0 trace: fix overflow in per-lcore trace buffer<br>
<br>
Pavan Nikhilesh (1):<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix return value of lcore role<br>
<br>
Pravin Pathak (6):<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix validaton of LDB port COS ID arguments=
<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix num single link ports for DLB2.5<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix QID depth xstat<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix public symbol namespace<br>
=C2=A0 =C2=A0 =C2=A0 app/eventdev: fix number of releases sent during clean=
up<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix dequeue with CQ depth &lt;=3D 16<br>
<br>
Radu Nicolau (2):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: add request check on request side<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix driver cleanup<br>
<br>
Rahul Bhansali (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix descriptor count update on reconfig<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix null pointer checks<br>
<br>
Rajesh Mudimadugula (3):<br>
=C2=A0 =C2=A0 =C2=A0 vhost/crypto: fix cipher data length<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix cipher data source length<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix driver ID<br>
<br>
Rakesh Kudurumalla (2):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix crash with IPv6<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix crash in event vector mode<b=
r>
<br>
Rui Ferreira (2):<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: unregister alarm callback before free<br>
=C2=A0 =C2=A0 =C2=A0 eal/freebsd: unregister alarm callback before free<br>
<br>
Satheesh Paul (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix E-tag pattern parsing<br>
<br>
Shani Peretz (1):<br>
=C2=A0 =C2=A0 =C2=A0 app/crypto-perf: fix AAD offset alignment<br>
<br>
Stephen Hemminger (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix use after free<br>
=C2=A0 =C2=A0 =C2=A0 bus/fslmc: fix use after free<br>
=C2=A0 =C2=A0 =C2=A0 net/null: fix packet copy<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix size calculation for memset<br>
=C2=A0 =C2=A0 =C2=A0 latencystats: fix receive sample race<br>
<br>
Sunyang Wu (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: keep promiscuous/allmulti value before disabli=
ng<br>
<br>
Tanzeel Ahmed (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/flow_filtering: fix make clean<br>
<br>
Thomas Monjalon (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/multi_process: revert ports cleanup on exit<b=
r>
<br>
Tirthendu Sarkar (1):<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix default credits based on HW version<br=
>
<br>
Vanshika Shukla (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/dpaa2_sec: fix uninitialized variable<br>
<br>
Viacheslav Ovsiienko (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix maximal queue size query<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix hypervisor detection in VLAN workaround<=
br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix out-of-order completions in ordinary Rx =
burst<br>
<br>
Volodymyr Fialko (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix number of queue pairs<br>
<br>
Xueming Li (1):<br>
=C2=A0 =C2=A0 =C2=A0 Revert &quot;net/ice: fix inconsistency in Rx queue VL=
AN tag placement&quot;<br>
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

--000000000000793d41063cb9945f--

