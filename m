Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25318C36014
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 08:05:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26B0E40DDA;
	Tue,  1 Apr 2025 10:05:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 532B440DC9
 for <dev@dpdk.org>; Tue,  1 Apr 2025 10:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743494749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y3T2/9GZslZxC9aBNbIbm8hVAs/5IQUlzXDrwAkCjPo=;
 b=TnDzi87Qe2wihnGvtOUeupyDsKFezkL+IuWZwptX4OwW7QzvxauFtxmwBqx6CF1E9pXvAH
 xP7eof2EJ+tyA9VkO6L5aw2DP0dUEgC579r8nY9PEdGHjRGqUD4+maGbcE85JVou5sFuV7
 /fvGPKcNDkFgnTujVdAb1t8VxNwjrhY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-ax8Zlci4MUWFt_xIDSDqUg-1; Tue, 01 Apr 2025 04:05:46 -0400
X-MC-Unique: ax8Zlci4MUWFt_xIDSDqUg-1
X-Mimecast-MFC-AGG-ID: ax8Zlci4MUWFt_xIDSDqUg_1743494746
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-601e778b584so3794499eaf.3
 for <dev@dpdk.org>; Tue, 01 Apr 2025 01:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743494746; x=1744099546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y3T2/9GZslZxC9aBNbIbm8hVAs/5IQUlzXDrwAkCjPo=;
 b=ncwL4dudOtF/PJUhT4x2bQSm/RQPUndzyBThOfP2TTLuRcg/bZkCZ49y6pm7ofp41n
 71ndA7dF8gwuYL0IR5m7HnP1a5+CnVNwahGecRhi07RW7aXnIf4fUma5tKNWR4YXNLsW
 RsI4KJ6/dwDgLt/RNRHr4TuewpG+lFM32C9TBJ79oIgN3nJhDEIzHglp9pb4RbJU1NL2
 Nk5PplngUcoRflPKIeXuhVXaDBu6PLgb69c533LFSfpgTe+0ujx5mrHsqyn6VPKUEI3B
 10YV+qGA7ob3yFgXnbikM3ERBICe02kmwIiHyWRZqfgMFeG/RDlzuUWyxgTgYhpBQcvB
 VHtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIt0UEneHY7E4U98erxgNmAxKuktTp9M9mEmIi7GzJelzwVb4blDfLkK2X3LFSUxdG8xs=@dpdk.org
X-Gm-Message-State: AOJu0YzXc1tJZ/p2eAdMuQqulrF2lezo6xDp9zePV3hsmI8BPNMzAOqh
 2y0MuLUisZQ8fZI/OIeimFoKooJu5QMjxcZbAdDt0A4Rg0RjJhV8cdMWTR17iHum5TloL9R7eG5
 izF/klQ9+MF5pubgRC70cDAyJhNrzQ2Aq35fnakk5LeCgO5Jb1wya8y6TgrUHgift6cnuF3p5aU
 1akX75Vq30xTkjiN4=
X-Gm-Gg: ASbGncv/yKiErkVMH24+JiNSfAAApKVNzLjMkYTC2wSeR3bgQni2miO2T++eoRQzZtM
 44DyviWpgeBUAYtWp+IJiq3EnF7q/3Hx3jVJue9RHL/HYM/sP/+ezSBUV6GrrLf3k9xlDLLVK/Q
 ==
X-Received: by 2002:a05:6870:5253:b0:29e:69d9:8847 with SMTP id
 586e51a60fabf-2cbcefe8cd0mr6822823fac.0.1743494745610; 
 Tue, 01 Apr 2025 01:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0h454+Sc6GHu5RVnXFE/BD2MoPx75NWwyq1HHeh3Dv5EnHpW2SMT0/3JJg1+r4oPw9kqP6GXgelc/qbspvro=
X-Received: by 2002:a05:6870:5253:b0:29e:69d9:8847 with SMTP id
 586e51a60fabf-2cbcefe8cd0mr6822798fac.0.1743494745138; Tue, 01 Apr 2025
 01:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250328101435.250876-1-ktraynor@redhat.com>
In-Reply-To: <20250328101435.250876-1-ktraynor@redhat.com>
From: Yanghang Liu <yanghliu@redhat.com>
Date: Tue, 1 Apr 2025 16:05:34 +0800
X-Gm-Features: AQ5f1Jqg1_6SnqNjZ8NAAZSsFDEJ1XtH9rOP2obYTxX444xC1Dg2sfHf26C9cNo
Message-ID: <CAGYh1E-zRSFQ_FirFsuwKqcDgV6Ks9Q362R0Hd3p7K0bh4ws8Q@mail.gmail.com>
Subject: Re: 24.11.2 patches review and test
To: Kevin Traynor <ktraynor@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, 
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Ian Stokes <ian.stokes@intel.com>, Jerin Jacob <jerinj@marvell.com>, 
 John McNamara <john.mcnamara@intel.com>, Ju-Hyoung Lee <juhlee@microsoft.com>, 
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>, 
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Chao Yang <chayang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 39wj1K1EPCgucJliit7q90U_EpeZIu1RRmVDIjusfB0_1743494746
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f3c7630631b30010"
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

--000000000000f3c7630631b30010
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested below 18 scenarios on RHEL 9.2 hosts and didn't find any new dpdk
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

   - qemu-kvm-7.2.0
   - kernel 5.14
   - libvirt 9.0
   - ovs 3.1
   - git log

commit 03f2ed63a5f4e4b57365e358b49095ef4a82cf7d
Author: Kevin Traynor <ktraynor@redhat.com>
Date:   Wed Mar 26 17:10:40 2025 +0000
version: 24.11.2-rc1
Signed-off-by: Kevin Traynor <ktraynor@redhat.com>


   - Test device : X540-AT2 NIC(ixgbe, 10G)

Tested-by: Yanghang Liu <yanghliu@redhat.com>


Best Regards,
Yanghang Liu

On Fri, Mar 28, 2025 at 6:14=E2=80=AFPM Kevin Traynor <ktraynor@redhat.com>=
 wrote:

> Hi all,
>
> Here is a list of patches targeted for stable release 24.11.2.
>
> The planned date for the final release is 14 April.
>
> Please help with testing and validation of your use cases and report
> any issues/results with reply-all to this mail. For the final release
> the fixes and reported validations will be added to the release notes.
>
> A release candidate tarball can be found at:
>
>     https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.11.2-rc1
>
> These patches are located at branch 24.11 of dpdk-stable repo:
>     https://dpdk.org/browse/dpdk-stable/
>
> Thanks.
>
> Kevin
>
> ---
> Ajit Khaparde (2):
>       net/bnxt: fix Rx handler
>       net/bnxt: fix epoch bit calculation
>
> Aleksandr Loktionov (2):
>       net/igc/base: fix MAC address hash bit shift
>       net/e1000/base: fix MAC address hash bit shift
>
> Alex Vesker (1):
>       net/mlx5/hws: fix DV FT type convert
>
> Alexander Kozyrev (1):
>       net/mlx5/hws: fix fragmented packet type matching
>
> Amir Avivi (2):
>       net/igc/base: fix iterator type
>       net/e1000/base: fix iterator type
>
> Anatoly Burakov (4):
>       net/e1000/base: correct mPHY access logic
>       net/e1000: fix crashes in secondary processes
>       net/ixgbe: fix crashes in secondary processes
>       doc: add no-IOMMU mode in devbind tool guide
>
> Andre Muezerie (6):
>       eal/x86: fix some intrinsics header include for Windows
>       eventdev: fix format string data type in log messages
>       net/bnxt: fix indication of allocation
>       common/idpf: fix void function returning a value
>       net/intel: fix void functions returning a value
>       stack: fix pop in C11 implementation
>
> Andrew Boyer (1):
>       doc: update ionic driver guide
>
> Ariel Otilibili (8):
>       examples/flow_filtering: remove duplicate assignment
>       net/sfc: remove unnecessary assignment
>       net/octeon_ep: remove useless assignment
>       net/enetfec: remove useless assignment
>       buildtools: fix some Python regex syntax warnings
>       use Python raw string notation
>       eal/linux: remove useless assignments
>       mempool: fix errno in empty create
>
> Arkadiusz Kusztal (3):
>       test/crypto: fix check for OOP header data
>       crypto/qat: fix SM3 state size
>       common/qat: fix devargs parsing
>
> Barbara Skobiej (3):
>       net/igc/base: fix data type in MAC hash
>       net/e1000/base: fix data type in MAC hash
>       net/e1000/base: fix reset for 82580
>
> Bing Zhao (3):
>       net/mlx5: fix leak of flow action data list
>       net/mlx5: fix unneeded stub flow table allocation
>       net/mlx5: fix flow group ID for action translation
>
> Bruce Richardson (9):
>       net/iavf: remove reset of Tx prepare function pointer
>       net/intel: fix build with icx
>       event/dlb2: fix event weight handling in SSE code path
>       test/dma: fix pointers in IOVA as PA mode
>       net/iavf: check interrupt registration failure
>       net/iavf: fix crash on app exit on FreeBSD
>       eal: fix undetected NUMA nodes
>       net/ixgbe: add checks for E610 VF
>       dma/idxd: add device ids for new HW versions
>
> Carolyn Wyborny (1):
>       net/e1000/base: skip management check for 82575
>
> Chaoyong He (2):
>       net/nfp: fix firmware load from flash
>       net/nfp: fix init failure handling
>
> Chengwen Feng (2):
>       app/testpmd: show all DCB priority TC map
>       app/testpmd: avoid crash in DCB config
>
> Dan Nowlin (1):
>       net/ixgbe/base: add missing buffer copy for ACI
>
> Dariusz Sosnowski (1):
>       net/mlx5: fix NAT64 register selection
>
> David Marchand (7):
>       random: defer seeding to EAL init
>       power: defer lcore variable allocation
>       eal/x86: defer power intrinsics variable allocation
>       ci: build with MSVC in GHA
>       net/mlx5: fix leak in HWS flow counter action
>       ci: point at GitHub mirror
>       ci: fix ccache for Ubuntu 22.04
>
> Dean Marx (1):
>       dts: fix pass rate edge case in results
>
> Dengdui Huang (3):
>       net/hns3: fix mbuf freeing in simple Tx path
>       net/hns3: fix copper port initialization
>       net/hns3: fix reset timeout
>
> Dima Ruinskiy (5):
>       net/igc/base: fix deadlock when writing i225 register
>       net/igc/base: fix infinite loop
>       net/igc/base: fix typo in LTR calculation
>       net/igc/base: fix unused value
>       net/e1000/base: fix unchecked return
>
> Gavin Hu (1):
>       net/mlx5: fix polling CQEs
>
> Gowrishankar Muthukrishnan (5):
>       crypto/virtio: fix data queues iteration
>       vhost/crypto: skip fetch before vring init
>       examples/vhost_crypto: fix user callbacks
>       crypto/cnxk: fix asymmetric operation status code
>       crypto/openssl: validate incorrect RSA signature
>
> Gregory Etelson (2):
>       net/mlx5: fix IPIP tunnel verification
>       net/mlx5: fix mark action validation in FDB mode
>
> Huisong Li (1):
>       ethdev: fix functions available in new device event
>
> Jakub Buchocki (1):
>       net/e1000/base: fix uninitialized variable
>
> Jianping Zhao (1):
>       vhost: clear ring addresses when getting vring base
>
> Jie Hai (2):
>       net/hns3: remove PVID info dump for VF
>       net/hns3: rename RAS module
>
> Junfeng Guo (1):
>       net/mlx5: fix actions translation error overwrite
>
> Kevin Traynor (3):
>       vhost: add null callback checks
>       net/mlx5: fix crash with null flow list creation
>       doc: fix year of final LTS release
>
> Konstantin Ananyev (2):
>       test/ring: fix init with custom number of lcores
>       gro: fix unprocessed IPv4 packets
>
> Lingli Chen (1):
>       doc: add two more tested Intel NICs in 24.11
>
> Long Li (3):
>       net/netvsc: scan all net devices under the PCI device
>       net/netvsc: remove device if its net devices removed
>       net/mana: fix multi-process tracking
>
> Long Wu (3):
>       net/nfp: fix VF link speed
>       net/bonding: fix dedicated queue setup
>       net/nfp: fix representor port statistics
>
> Luca Vizzarro (2):
>       dts: fix MTU set command
>       dts: fix smoke tests docstring
>
> Lukasz Krakowiak (1):
>       net/ixgbe/base: fix TSAM checking return value
>
> Maayan Kashani (14):
>       net/mlx5: adjust actions per rule limitation
>       net/mlx5: fix crash in non-template metadata split
>       net/mlx5: fix flush of non-template flow rules
>       net/mlx5: fix GRE flow match with SWS
>       net/mlx5: fix hairpin queue release
>       net/mlx5: fix LACP packet handling in isolated mode
>       net/mlx5/hws: fix crash using represented port without ID
>       net/mlx5: fix non-template set VLAN VID
>       net/mlx5: fix error info in actions construct
>       net/mlx5/hws: fix GTP flags matching
>       net/mlx5: fix non-template flow validation
>       net/mlx5: fix non-template flow validation on create
>       net/mlx5: fix flow matching GENEVE options
>       net/mlx5: fix GRE matching on root table
>
> Matthew Smith (1):
>       net/ice: fix dropped packets when using VRRP
>
> Maxime Coquelin (3):
>       vhost: fix log when setting max queue num
>       vhost: reset packets count when not ready
>       vhost: fix FD entries cleanup
>
> Michael Baum (2):
>       common/mlx5: add device duplication function
>       net/mlx5: fix GENEVE parser cleanup
>
> Minggang Li (Gavin) (3):
>       net/mlx5: fix Netlink socket leak
>       doc: add VXLAN matching requirement in mlx5 guide
>       app/testpmd: use VXLAN flow flags from user if set
>
> Mingjin Ye (1):
>       net/ixgbe: fix minimum Rx/Tx descriptors
>
> Nawal Kishor (1):
>       common/cnxk: fix atomic load in batch ops
>
> Nicolas Chautru (2):
>       test/bbdev: update FFT test vectors
>       baseband/acc: fix queue setup failure clean up
>
> Nithin Dabilpuram (2):
>       ptr_compress: fix build with Arm SVE
>       common/cnxk: fix inbound IPsec SA setup
>
> Nithinsen Kaithakadan (1):
>       examples/ipsec-secgw: fix IV length in CTR 192/256
>
> Pawel Malinowski (2):
>       net/igc/base: fix semaphore timeout value
>       net/e1000/base: fix semaphore timeout value
>
> Peng Zhang (1):
>       net/nfp: fix multi-PF control flag
>
> Peter Spreadborough (4):
>       net/bnxt: fix dead code
>       net/bnxt: fix overflow
>       net/bnxt: fix overflow
>       net/bnxt: address uninitialized variables
>
> Piotr Krzewinski (1):
>       service: fix getting service lcore attributes
>
> Piotr Kwapulinski (2):
>       net/ixgbe/base: remove 2.5/5G from auto-negotiation for E610
>       net/ixgbe/base: fix driver hang in VM
>
> Praveen Kaligineedi (1):
>       net/gve: allocate Rx QPL pages using malloc
>
> Przemyslaw Ciesielski (4):
>       net/igc/base: fix bitwise operation type
>       net/igc/base: fix NVM data type in bit shift
>       net/e1000/base: fix bitwise operation type
>       net/e1000/base: fix NVM data type in bit shift
>
> Rahul Bhansali (1):
>       net/cnxk: fix NIX send header L3 type
>
> Rajesh Mudimadugula (1):
>       crypto/virtio: fix redundant queue free
>
> Raslan Darawsheh (1):
>       doc: add tested platforms with NVIDIA NICs in 24.11
>
> Robin Jarry (1):
>       log: fix double free on cleanup
>
> Sangtani Parag Satishbhai (1):
>       net/bnxt: fix crash when representor is re-attached
>
> Sasha Neftin (3):
>       net/igc/base: increase PHY power up delay
>       net/igc/base: reset loop variable
>       net/igc/base: fix LTR for i225
>
> Shai Brandes (1):
>       net/ena: fix missing default LLQ policy
>
> Shani Peretz (2):
>       bus/pci: fix registered device name
>       examples/flow_filtering: fix IPv4 matching snippet
>
> Shaokai Zhang (2):
>       test/crypto: fix AES-ECB test lengths
>       test/crypto: remove unused variable
>
> Shijith Thotton (1):
>       test/event: fix number of queues in eventdev conf
>
> Stephen Hemminger (23):
>       crypto/cnxk: fix build with GCC 15
>       net/thunderx/base: fix build with GCC 15
>       examples/flow_filtering: fix build with GCC 15
>       test/bonding: fix active backup receive test
>       log: fix systemd journal socket open
>       build: force GCC 15 to initialize padding bits
>       net/cpfl: fix representor parsing log
>       raw/cnxk_gpio: fix file descriptor leak
>       eal: fix devargs layers parsing out of bounds
>       net/qede: fix debug messages array
>       examples/ptpclient: fix message parsing
>       net/hinic: fix flow type bitmask overflow
>       crypto/dpaa2_sec: fix bitmask truncation
>       crypto/dpaa_sec: fix bitmask truncation
>       event/dpaa: fix bitmask truncation
>       net/dpaa: fix bitmask truncation
>       net/dpaa2: fix bitmask truncation
>       net/qede: fix nested loops
>       examples/l3fwd: fix socket ID check
>       common/cnxk: fix null check
>       doc: fix feature flags for queue start/stop
>       app/testpmd: fix out-of-bound reference in offload config
>       pdump: clear statistics when enabled
>
> Tejasree Kondoj (1):
>       examples/ipsec-secgw: fix cryptodev and eventdev IDs
>
> Thierry Herbelot (1):
>       ethdev: fix registers info request
>
> Thomas Monjalon (1):
>       cryptodev: fix C++ include
>
> Tudor Cornea (1):
>       net/af_packet: fix socket close on device stop
>
> Vamsi Attunuru (1):
>       common/cnxk: fix DPI mailbox structure
>
> Viacheslav Ovsiienko (1):
>       net/mlx5: fix hardware packet type translation
>
> Vladimir Medvedkin (4):
>       net/ixgbe: fix E610 support in flow engine
>       net/ice: fix memory leak in scalar Rx
>       net/ice: fix flows handling
>       net/ice: fix flow engines order
>
> Wathsala Vithanage (1):
>       crypto/openssl: fix CMAC auth context update
>
> Wei Hu (1):
>       net/mana: do not ring short doorbell for every mbuf alloc
>
> Yang Ming (2):
>       eal/linux: fix memseg length in legacy mem init
>       net/iavf: fix mbuf release in Arm multi-process
>
> Yunjian Wang (2):
>       vhost: check GSO size validity
>       vhost: check descriptor chains length
>
> Zaiyu Wang (2):
>       net/ngbe: fix WOL and NCSI capabilities
>       net/txgbe: remove useless condition for SW-FW sync
>
> Zerun Fu (2):
>       net/nfp: fix multiple PFs check from NSP
>       net/nfp: fix misuse of function return values
>
>

--000000000000f3c7630631b30010
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font =
face=3D"arial, sans-serif">I tested below 18 scenarios on RHEL 9.2 hosts an=
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
/div><div><br><font face=3D"arial, sans-serif">Test Versions:<br><ul><li st=
yle=3D"margin-left:15px">qemu-kvm-7.2.0</li><li style=3D"margin-left:15px">=
kernel 5.14</li><li style=3D"margin-left:15px">libvirt 9.0</li><li style=3D=
"margin-left:15px">ovs 3.1</li><li style=3D"margin-left:15px">git log</li><=
/ul></font></div></div></div></div></div><blockquote style=3D"margin:0px 0p=
x 0px 40px;border:none;padding:0px"><blockquote style=3D"margin:0px 0px 0px=
 40px;border:none;padding:0px"><div class=3D"gmail_signature"><div class=3D=
"gmail_signature">commit 03f2ed63a5f4e4b57365e358b49095ef4a82cf7d<br>Author=
: Kevin Traynor &lt;<a href=3D"mailto:ktraynor@redhat.com">ktraynor@redhat.=
com</a>&gt;<br>Date: =C2=A0 Wed Mar 26 17:10:40 2025 +0000<br>version: 24.1=
1.2-rc1<br>Signed-off-by: Kevin Traynor &lt;<a href=3D"mailto:ktraynor@redh=
at.com">ktraynor@redhat.com</a>&gt;<font face=3D"arial, sans-serif"></font>=
</div></div></blockquote></blockquote><div><div dir=3D"ltr" class=3D"gmail_=
signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_signature"><fon=
t face=3D"arial, sans-serif"><ul><li style=3D"margin-left:15px">Test device=
 : X540-AT2 NIC(ixgbe, 10G)</li></ul></font></div></div></div><div dir=3D"l=
tr" class=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gm=
ail_signature"><div dir=3D"ltr"><div><font face=3D"arial, sans-serif">Teste=
d-by: Yanghang Liu &lt;<a href=3D"mailto:yanghliu@redhat.com" target=3D"_bl=
ank">yanghliu@redhat.com</a>&gt;</font></div></div></div></div></div></div>=
<div><br></div><div><br></div><div><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Best Regards,</div><div>Yanghang Liu</div></div></=
div></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 28, 2025 at 6:14=E2=80=AFPM Kev=
in Traynor &lt;<a href=3D"mailto:ktraynor@redhat.com">ktraynor@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi=
 all,<br>
<br>
Here is a list of patches targeted for stable release 24.11.2.<br>
<br>
The planned date for the final release is 14 April.<br>
<br>
Please help with testing and validation of your use cases and report<br>
any issues/results with reply-all to this mail. For the final release<br>
the fixes and reported validations will be added to the release notes.<br>
<br>
A release candidate tarball can be found at:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"https://dpdk.org/browse/dpdk-stable/tag/?id=3Dv24.=
11.2-rc1" rel=3D"noreferrer" target=3D"_blank">https://dpdk.org/browse/dpdk=
-stable/tag/?id=3Dv24.11.2-rc1</a><br>
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
Ajit Khaparde (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix Rx handler<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix epoch bit calculation<br>
<br>
Aleksandr Loktionov (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix MAC address hash bit shift<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix MAC address hash bit shift<br>
<br>
Alex Vesker (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix DV FT type convert<br>
<br>
Alexander Kozyrev (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix fragmented packet type matching<br>
<br>
Amir Avivi (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix iterator type<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix iterator type<br>
<br>
Anatoly Burakov (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: correct mPHY access logic<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000: fix crashes in secondary processes<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix crashes in secondary processes<br>
=C2=A0 =C2=A0 =C2=A0 doc: add no-IOMMU mode in devbind tool guide<br>
<br>
Andre Muezerie (6):<br>
=C2=A0 =C2=A0 =C2=A0 eal/x86: fix some intrinsics header include for Window=
s<br>
=C2=A0 =C2=A0 =C2=A0 eventdev: fix format string data type in log messages<=
br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix indication of allocation<br>
=C2=A0 =C2=A0 =C2=A0 common/idpf: fix void function returning a value<br>
=C2=A0 =C2=A0 =C2=A0 net/intel: fix void functions returning a value<br>
=C2=A0 =C2=A0 =C2=A0 stack: fix pop in C11 implementation<br>
<br>
Andrew Boyer (1):<br>
=C2=A0 =C2=A0 =C2=A0 doc: update ionic driver guide<br>
<br>
Ariel Otilibili (8):<br>
=C2=A0 =C2=A0 =C2=A0 examples/flow_filtering: remove duplicate assignment<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/sfc: remove unnecessary assignment<br>
=C2=A0 =C2=A0 =C2=A0 net/octeon_ep: remove useless assignment<br>
=C2=A0 =C2=A0 =C2=A0 net/enetfec: remove useless assignment<br>
=C2=A0 =C2=A0 =C2=A0 buildtools: fix some Python regex syntax warnings<br>
=C2=A0 =C2=A0 =C2=A0 use Python raw string notation<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: remove useless assignments<br>
=C2=A0 =C2=A0 =C2=A0 mempool: fix errno in empty create<br>
<br>
Arkadiusz Kusztal (3):<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix check for OOP header data<br>
=C2=A0 =C2=A0 =C2=A0 crypto/qat: fix SM3 state size<br>
=C2=A0 =C2=A0 =C2=A0 common/qat: fix devargs parsing<br>
<br>
Barbara Skobiej (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix data type in MAC hash<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix data type in MAC hash<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix reset for 82580<br>
<br>
Bing Zhao (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix leak of flow action data list<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix unneeded stub flow table allocation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flow group ID for action translation<br>
<br>
Bruce Richardson (9):<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: remove reset of Tx prepare function pointer<=
br>
=C2=A0 =C2=A0 =C2=A0 net/intel: fix build with icx<br>
=C2=A0 =C2=A0 =C2=A0 event/dlb2: fix event weight handling in SSE code path=
<br>
=C2=A0 =C2=A0 =C2=A0 test/dma: fix pointers in IOVA as PA mode<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: check interrupt registration failure<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix crash on app exit on FreeBSD<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix undetected NUMA nodes<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: add checks for E610 VF<br>
=C2=A0 =C2=A0 =C2=A0 dma/idxd: add device ids for new HW versions<br>
<br>
Carolyn Wyborny (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: skip management check for 82575<br>
<br>
Chaoyong He (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix firmware load from flash<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix init failure handling<br>
<br>
Chengwen Feng (2):<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: show all DCB priority TC map<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: avoid crash in DCB config<br>
<br>
Dan Nowlin (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: add missing buffer copy for ACI<br>
<br>
Dariusz Sosnowski (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix NAT64 register selection<br>
<br>
David Marchand (7):<br>
=C2=A0 =C2=A0 =C2=A0 random: defer seeding to EAL init<br>
=C2=A0 =C2=A0 =C2=A0 power: defer lcore variable allocation<br>
=C2=A0 =C2=A0 =C2=A0 eal/x86: defer power intrinsics variable allocation<br=
>
=C2=A0 =C2=A0 =C2=A0 ci: build with MSVC in GHA<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix leak in HWS flow counter action<br>
=C2=A0 =C2=A0 =C2=A0 ci: point at GitHub mirror<br>
=C2=A0 =C2=A0 =C2=A0 ci: fix ccache for Ubuntu 22.04<br>
<br>
Dean Marx (1):<br>
=C2=A0 =C2=A0 =C2=A0 dts: fix pass rate edge case in results<br>
<br>
Dengdui Huang (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix mbuf freeing in simple Tx path<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix copper port initialization<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: fix reset timeout<br>
<br>
Dima Ruinskiy (5):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix deadlock when writing i225 register<=
br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix infinite loop<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix typo in LTR calculation<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix unused value<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix unchecked return<br>
<br>
Gavin Hu (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix polling CQEs<br>
<br>
Gowrishankar Muthukrishnan (5):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix data queues iteration<br>
=C2=A0 =C2=A0 =C2=A0 vhost/crypto: skip fetch before vring init<br>
=C2=A0 =C2=A0 =C2=A0 examples/vhost_crypto: fix user callbacks<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: fix asymmetric operation status code<br>
=C2=A0 =C2=A0 =C2=A0 crypto/openssl: validate incorrect RSA signature<br>
<br>
Gregory Etelson (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix IPIP tunnel verification<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix mark action validation in FDB mode<br>
<br>
Huisong Li (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix functions available in new device event<br=
>
<br>
Jakub Buchocki (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix uninitialized variable<br>
<br>
Jianping Zhao (1):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: clear ring addresses when getting vring base<br=
>
<br>
Jie Hai (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: remove PVID info dump for VF<br>
=C2=A0 =C2=A0 =C2=A0 net/hns3: rename RAS module<br>
<br>
Junfeng Guo (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix actions translation error overwrite<br>
<br>
Kevin Traynor (3):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: add null callback checks<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix crash with null flow list creation<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix year of final LTS release<br>
<br>
Konstantin Ananyev (2):<br>
=C2=A0 =C2=A0 =C2=A0 test/ring: fix init with custom number of lcores<br>
=C2=A0 =C2=A0 =C2=A0 gro: fix unprocessed IPv4 packets<br>
<br>
Lingli Chen (1):<br>
=C2=A0 =C2=A0 =C2=A0 doc: add two more tested Intel NICs in 24.11<br>
<br>
Long Li (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: scan all net devices under the PCI device<=
br>
=C2=A0 =C2=A0 =C2=A0 net/netvsc: remove device if its net devices removed<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/mana: fix multi-process tracking<br>
<br>
Long Wu (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix VF link speed<br>
=C2=A0 =C2=A0 =C2=A0 net/bonding: fix dedicated queue setup<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix representor port statistics<br>
<br>
Luca Vizzarro (2):<br>
=C2=A0 =C2=A0 =C2=A0 dts: fix MTU set command<br>
=C2=A0 =C2=A0 =C2=A0 dts: fix smoke tests docstring<br>
<br>
Lukasz Krakowiak (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: fix TSAM checking return value<br>
<br>
Maayan Kashani (14):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: adjust actions per rule limitation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix crash in non-template metadata split<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flush of non-template flow rules<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix GRE flow match with SWS<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix hairpin queue release<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix LACP packet handling in isolated mode<br=
>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix crash using represented port without=
 ID<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix non-template set VLAN VID<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix error info in actions construct<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5/hws: fix GTP flags matching<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix non-template flow validation<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix non-template flow validation on create<b=
r>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix flow matching GENEVE options<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix GRE matching on root table<br>
<br>
Matthew Smith (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix dropped packets when using VRRP<br>
<br>
Maxime Coquelin (3):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix log when setting max queue num<br>
=C2=A0 =C2=A0 =C2=A0 vhost: reset packets count when not ready<br>
=C2=A0 =C2=A0 =C2=A0 vhost: fix FD entries cleanup<br>
<br>
Michael Baum (2):<br>
=C2=A0 =C2=A0 =C2=A0 common/mlx5: add device duplication function<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix GENEVE parser cleanup<br>
<br>
Minggang Li (Gavin) (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix Netlink socket leak<br>
=C2=A0 =C2=A0 =C2=A0 doc: add VXLAN matching requirement in mlx5 guide<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: use VXLAN flow flags from user if set<br>
<br>
Mingjin Ye (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix minimum Rx/Tx descriptors<br>
<br>
Nawal Kishor (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix atomic load in batch ops<br>
<br>
Nicolas Chautru (2):<br>
=C2=A0 =C2=A0 =C2=A0 test/bbdev: update FFT test vectors<br>
=C2=A0 =C2=A0 =C2=A0 baseband/acc: fix queue setup failure clean up<br>
<br>
Nithin Dabilpuram (2):<br>
=C2=A0 =C2=A0 =C2=A0 ptr_compress: fix build with Arm SVE<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix inbound IPsec SA setup<br>
<br>
Nithinsen Kaithakadan (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix IV length in CTR 192/256<br>
<br>
Pawel Malinowski (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix semaphore timeout value<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix semaphore timeout value<br>
<br>
Peng Zhang (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix multi-PF control flag<br>
<br>
Peter Spreadborough (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix dead code<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix overflow<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix overflow<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: address uninitialized variables<br>
<br>
Piotr Krzewinski (1):<br>
=C2=A0 =C2=A0 =C2=A0 service: fix getting service lcore attributes<br>
<br>
Piotr Kwapulinski (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: remove 2.5/5G from auto-negotiation fo=
r E610<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe/base: fix driver hang in VM<br>
<br>
Praveen Kaligineedi (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/gve: allocate Rx QPL pages using malloc<br>
<br>
Przemyslaw Ciesielski (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix bitwise operation type<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix NVM data type in bit shift<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix bitwise operation type<br>
=C2=A0 =C2=A0 =C2=A0 net/e1000/base: fix NVM data type in bit shift<br>
<br>
Rahul Bhansali (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/cnxk: fix NIX send header L3 type<br>
<br>
Rajesh Mudimadugula (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/virtio: fix redundant queue free<br>
<br>
Raslan Darawsheh (1):<br>
=C2=A0 =C2=A0 =C2=A0 doc: add tested platforms with NVIDIA NICs in 24.11<br=
>
<br>
Robin Jarry (1):<br>
=C2=A0 =C2=A0 =C2=A0 log: fix double free on cleanup<br>
<br>
Sangtani Parag Satishbhai (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/bnxt: fix crash when representor is re-attached<br=
>
<br>
Sasha Neftin (3):<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: increase PHY power up delay<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: reset loop variable<br>
=C2=A0 =C2=A0 =C2=A0 net/igc/base: fix LTR for i225<br>
<br>
Shai Brandes (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/ena: fix missing default LLQ policy<br>
<br>
Shani Peretz (2):<br>
=C2=A0 =C2=A0 =C2=A0 bus/pci: fix registered device name<br>
=C2=A0 =C2=A0 =C2=A0 examples/flow_filtering: fix IPv4 matching snippet<br>
<br>
Shaokai Zhang (2):<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: fix AES-ECB test lengths<br>
=C2=A0 =C2=A0 =C2=A0 test/crypto: remove unused variable<br>
<br>
Shijith Thotton (1):<br>
=C2=A0 =C2=A0 =C2=A0 test/event: fix number of queues in eventdev conf<br>
<br>
Stephen Hemminger (23):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/cnxk: fix build with GCC 15<br>
=C2=A0 =C2=A0 =C2=A0 net/thunderx/base: fix build with GCC 15<br>
=C2=A0 =C2=A0 =C2=A0 examples/flow_filtering: fix build with GCC 15<br>
=C2=A0 =C2=A0 =C2=A0 test/bonding: fix active backup receive test<br>
=C2=A0 =C2=A0 =C2=A0 log: fix systemd journal socket open<br>
=C2=A0 =C2=A0 =C2=A0 build: force GCC 15 to initialize padding bits<br>
=C2=A0 =C2=A0 =C2=A0 net/cpfl: fix representor parsing log<br>
=C2=A0 =C2=A0 =C2=A0 raw/cnxk_gpio: fix file descriptor leak<br>
=C2=A0 =C2=A0 =C2=A0 eal: fix devargs layers parsing out of bounds<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix debug messages array<br>
=C2=A0 =C2=A0 =C2=A0 examples/ptpclient: fix message parsing<br>
=C2=A0 =C2=A0 =C2=A0 net/hinic: fix flow type bitmask overflow<br>
=C2=A0 =C2=A0 =C2=A0 crypto/dpaa2_sec: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 crypto/dpaa_sec: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 event/dpaa: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/dpaa2: fix bitmask truncation<br>
=C2=A0 =C2=A0 =C2=A0 net/qede: fix nested loops<br>
=C2=A0 =C2=A0 =C2=A0 examples/l3fwd: fix socket ID check<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix null check<br>
=C2=A0 =C2=A0 =C2=A0 doc: fix feature flags for queue start/stop<br>
=C2=A0 =C2=A0 =C2=A0 app/testpmd: fix out-of-bound reference in offload con=
fig<br>
=C2=A0 =C2=A0 =C2=A0 pdump: clear statistics when enabled<br>
<br>
Tejasree Kondoj (1):<br>
=C2=A0 =C2=A0 =C2=A0 examples/ipsec-secgw: fix cryptodev and eventdev IDs<b=
r>
<br>
Thierry Herbelot (1):<br>
=C2=A0 =C2=A0 =C2=A0 ethdev: fix registers info request<br>
<br>
Thomas Monjalon (1):<br>
=C2=A0 =C2=A0 =C2=A0 cryptodev: fix C++ include<br>
<br>
Tudor Cornea (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/af_packet: fix socket close on device stop<br>
<br>
Vamsi Attunuru (1):<br>
=C2=A0 =C2=A0 =C2=A0 common/cnxk: fix DPI mailbox structure<br>
<br>
Viacheslav Ovsiienko (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mlx5: fix hardware packet type translation<br>
<br>
Vladimir Medvedkin (4):<br>
=C2=A0 =C2=A0 =C2=A0 net/ixgbe: fix E610 support in flow engine<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix memory leak in scalar Rx<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix flows handling<br>
=C2=A0 =C2=A0 =C2=A0 net/ice: fix flow engines order<br>
<br>
Wathsala Vithanage (1):<br>
=C2=A0 =C2=A0 =C2=A0 crypto/openssl: fix CMAC auth context update<br>
<br>
Wei Hu (1):<br>
=C2=A0 =C2=A0 =C2=A0 net/mana: do not ring short doorbell for every mbuf al=
loc<br>
<br>
Yang Ming (2):<br>
=C2=A0 =C2=A0 =C2=A0 eal/linux: fix memseg length in legacy mem init<br>
=C2=A0 =C2=A0 =C2=A0 net/iavf: fix mbuf release in Arm multi-process<br>
<br>
Yunjian Wang (2):<br>
=C2=A0 =C2=A0 =C2=A0 vhost: check GSO size validity<br>
=C2=A0 =C2=A0 =C2=A0 vhost: check descriptor chains length<br>
<br>
Zaiyu Wang (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/ngbe: fix WOL and NCSI capabilities<br>
=C2=A0 =C2=A0 =C2=A0 net/txgbe: remove useless condition for SW-FW sync<br>
<br>
Zerun Fu (2):<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix multiple PFs check from NSP<br>
=C2=A0 =C2=A0 =C2=A0 net/nfp: fix misuse of function return values<br>
<br>
</blockquote></div>

--000000000000f3c7630631b30010--

