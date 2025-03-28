Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296D2C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 10:14:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80902402E6;
	Fri, 28 Mar 2025 11:14:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 22C02402C1
 for <dev@dpdk.org>; Fri, 28 Mar 2025 11:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743156895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mfaLfNiF8cMQQdsKC0KgUok+bhUg21dkq3jLY3rBDgw=;
 b=HU7yUjzKLKRwbU/dfZqpeCNTUuAAPWZ/OOdg5QthPAeDRN3CX4uBEAvYufBVkOCnQLEt+Z
 N7JuXFvnNs8pUJgKOXQSc+TNp8a6mpyI1/tTbxdYndj9Nc97MLJ0Wil7rkrHZjQk/TcS0W
 dF4ieFPjuBDKqrUyneECVGxoBMrrPbE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-cSrfpI_aPRqFKftQ1Cu1DA-1; Fri,
 28 Mar 2025 06:14:52 -0400
X-MC-Unique: cSrfpI_aPRqFKftQ1Cu1DA-1
X-Mimecast-MFC-AGG-ID: cSrfpI_aPRqFKftQ1Cu1DA_1743156890
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E224190308B; Fri, 28 Mar 2025 10:14:50 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.32.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F15B21828A9E; Fri, 28 Mar 2025 10:14:43 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, yanghliu@redhat.com
Subject: 24.11.2 patches review and test
Date: Fri, 28 Mar 2025 10:14:33 +0000
Message-ID: <20250328101435.250876-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5CM2JETjkNAkYLQf_gDIGb3uxGb__NnrNfKBO8PjBeY_1743156890
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Hi all,

Here is a list of patches targeted for stable release 24.11.2.

The planned date for the final release is 14 April.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.2-rc1

These patches are located at branch 24.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Kevin

---
Ajit Khaparde (2):
      net/bnxt: fix Rx handler
      net/bnxt: fix epoch bit calculation

Aleksandr Loktionov (2):
      net/igc/base: fix MAC address hash bit shift
      net/e1000/base: fix MAC address hash bit shift

Alex Vesker (1):
      net/mlx5/hws: fix DV FT type convert

Alexander Kozyrev (1):
      net/mlx5/hws: fix fragmented packet type matching

Amir Avivi (2):
      net/igc/base: fix iterator type
      net/e1000/base: fix iterator type

Anatoly Burakov (4):
      net/e1000/base: correct mPHY access logic
      net/e1000: fix crashes in secondary processes
      net/ixgbe: fix crashes in secondary processes
      doc: add no-IOMMU mode in devbind tool guide

Andre Muezerie (6):
      eal/x86: fix some intrinsics header include for Windows
      eventdev: fix format string data type in log messages
      net/bnxt: fix indication of allocation
      common/idpf: fix void function returning a value
      net/intel: fix void functions returning a value
      stack: fix pop in C11 implementation

Andrew Boyer (1):
      doc: update ionic driver guide

Ariel Otilibili (8):
      examples/flow_filtering: remove duplicate assignment
      net/sfc: remove unnecessary assignment
      net/octeon_ep: remove useless assignment
      net/enetfec: remove useless assignment
      buildtools: fix some Python regex syntax warnings
      use Python raw string notation
      eal/linux: remove useless assignments
      mempool: fix errno in empty create

Arkadiusz Kusztal (3):
      test/crypto: fix check for OOP header data
      crypto/qat: fix SM3 state size
      common/qat: fix devargs parsing

Barbara Skobiej (3):
      net/igc/base: fix data type in MAC hash
      net/e1000/base: fix data type in MAC hash
      net/e1000/base: fix reset for 82580

Bing Zhao (3):
      net/mlx5: fix leak of flow action data list
      net/mlx5: fix unneeded stub flow table allocation
      net/mlx5: fix flow group ID for action translation

Bruce Richardson (9):
      net/iavf: remove reset of Tx prepare function pointer
      net/intel: fix build with icx
      event/dlb2: fix event weight handling in SSE code path
      test/dma: fix pointers in IOVA as PA mode
      net/iavf: check interrupt registration failure
      net/iavf: fix crash on app exit on FreeBSD
      eal: fix undetected NUMA nodes
      net/ixgbe: add checks for E610 VF
      dma/idxd: add device ids for new HW versions

Carolyn Wyborny (1):
      net/e1000/base: skip management check for 82575

Chaoyong He (2):
      net/nfp: fix firmware load from flash
      net/nfp: fix init failure handling

Chengwen Feng (2):
      app/testpmd: show all DCB priority TC map
      app/testpmd: avoid crash in DCB config

Dan Nowlin (1):
      net/ixgbe/base: add missing buffer copy for ACI

Dariusz Sosnowski (1):
      net/mlx5: fix NAT64 register selection

David Marchand (7):
      random: defer seeding to EAL init
      power: defer lcore variable allocation
      eal/x86: defer power intrinsics variable allocation
      ci: build with MSVC in GHA
      net/mlx5: fix leak in HWS flow counter action
      ci: point at GitHub mirror
      ci: fix ccache for Ubuntu 22.04

Dean Marx (1):
      dts: fix pass rate edge case in results

Dengdui Huang (3):
      net/hns3: fix mbuf freeing in simple Tx path
      net/hns3: fix copper port initialization
      net/hns3: fix reset timeout

Dima Ruinskiy (5):
      net/igc/base: fix deadlock when writing i225 register
      net/igc/base: fix infinite loop
      net/igc/base: fix typo in LTR calculation
      net/igc/base: fix unused value
      net/e1000/base: fix unchecked return

Gavin Hu (1):
      net/mlx5: fix polling CQEs

Gowrishankar Muthukrishnan (5):
      crypto/virtio: fix data queues iteration
      vhost/crypto: skip fetch before vring init
      examples/vhost_crypto: fix user callbacks
      crypto/cnxk: fix asymmetric operation status code
      crypto/openssl: validate incorrect RSA signature

Gregory Etelson (2):
      net/mlx5: fix IPIP tunnel verification
      net/mlx5: fix mark action validation in FDB mode

Huisong Li (1):
      ethdev: fix functions available in new device event

Jakub Buchocki (1):
      net/e1000/base: fix uninitialized variable

Jianping Zhao (1):
      vhost: clear ring addresses when getting vring base

Jie Hai (2):
      net/hns3: remove PVID info dump for VF
      net/hns3: rename RAS module

Junfeng Guo (1):
      net/mlx5: fix actions translation error overwrite

Kevin Traynor (3):
      vhost: add null callback checks
      net/mlx5: fix crash with null flow list creation
      doc: fix year of final LTS release

Konstantin Ananyev (2):
      test/ring: fix init with custom number of lcores
      gro: fix unprocessed IPv4 packets

Lingli Chen (1):
      doc: add two more tested Intel NICs in 24.11

Long Li (3):
      net/netvsc: scan all net devices under the PCI device
      net/netvsc: remove device if its net devices removed
      net/mana: fix multi-process tracking

Long Wu (3):
      net/nfp: fix VF link speed
      net/bonding: fix dedicated queue setup
      net/nfp: fix representor port statistics

Luca Vizzarro (2):
      dts: fix MTU set command
      dts: fix smoke tests docstring

Lukasz Krakowiak (1):
      net/ixgbe/base: fix TSAM checking return value

Maayan Kashani (14):
      net/mlx5: adjust actions per rule limitation
      net/mlx5: fix crash in non-template metadata split
      net/mlx5: fix flush of non-template flow rules
      net/mlx5: fix GRE flow match with SWS
      net/mlx5: fix hairpin queue release
      net/mlx5: fix LACP packet handling in isolated mode
      net/mlx5/hws: fix crash using represented port without ID
      net/mlx5: fix non-template set VLAN VID
      net/mlx5: fix error info in actions construct
      net/mlx5/hws: fix GTP flags matching
      net/mlx5: fix non-template flow validation
      net/mlx5: fix non-template flow validation on create
      net/mlx5: fix flow matching GENEVE options
      net/mlx5: fix GRE matching on root table

Matthew Smith (1):
      net/ice: fix dropped packets when using VRRP

Maxime Coquelin (3):
      vhost: fix log when setting max queue num
      vhost: reset packets count when not ready
      vhost: fix FD entries cleanup

Michael Baum (2):
      common/mlx5: add device duplication function
      net/mlx5: fix GENEVE parser cleanup

Minggang Li (Gavin) (3):
      net/mlx5: fix Netlink socket leak
      doc: add VXLAN matching requirement in mlx5 guide
      app/testpmd: use VXLAN flow flags from user if set

Mingjin Ye (1):
      net/ixgbe: fix minimum Rx/Tx descriptors

Nawal Kishor (1):
      common/cnxk: fix atomic load in batch ops

Nicolas Chautru (2):
      test/bbdev: update FFT test vectors
      baseband/acc: fix queue setup failure clean up

Nithin Dabilpuram (2):
      ptr_compress: fix build with Arm SVE
      common/cnxk: fix inbound IPsec SA setup

Nithinsen Kaithakadan (1):
      examples/ipsec-secgw: fix IV length in CTR 192/256

Pawel Malinowski (2):
      net/igc/base: fix semaphore timeout value
      net/e1000/base: fix semaphore timeout value

Peng Zhang (1):
      net/nfp: fix multi-PF control flag

Peter Spreadborough (4):
      net/bnxt: fix dead code
      net/bnxt: fix overflow
      net/bnxt: fix overflow
      net/bnxt: address uninitialized variables

Piotr Krzewinski (1):
      service: fix getting service lcore attributes

Piotr Kwapulinski (2):
      net/ixgbe/base: remove 2.5/5G from auto-negotiation for E610
      net/ixgbe/base: fix driver hang in VM

Praveen Kaligineedi (1):
      net/gve: allocate Rx QPL pages using malloc

Przemyslaw Ciesielski (4):
      net/igc/base: fix bitwise operation type
      net/igc/base: fix NVM data type in bit shift
      net/e1000/base: fix bitwise operation type
      net/e1000/base: fix NVM data type in bit shift

Rahul Bhansali (1):
      net/cnxk: fix NIX send header L3 type

Rajesh Mudimadugula (1):
      crypto/virtio: fix redundant queue free

Raslan Darawsheh (1):
      doc: add tested platforms with NVIDIA NICs in 24.11

Robin Jarry (1):
      log: fix double free on cleanup

Sangtani Parag Satishbhai (1):
      net/bnxt: fix crash when representor is re-attached

Sasha Neftin (3):
      net/igc/base: increase PHY power up delay
      net/igc/base: reset loop variable
      net/igc/base: fix LTR for i225

Shai Brandes (1):
      net/ena: fix missing default LLQ policy

Shani Peretz (2):
      bus/pci: fix registered device name
      examples/flow_filtering: fix IPv4 matching snippet

Shaokai Zhang (2):
      test/crypto: fix AES-ECB test lengths
      test/crypto: remove unused variable

Shijith Thotton (1):
      test/event: fix number of queues in eventdev conf

Stephen Hemminger (23):
      crypto/cnxk: fix build with GCC 15
      net/thunderx/base: fix build with GCC 15
      examples/flow_filtering: fix build with GCC 15
      test/bonding: fix active backup receive test
      log: fix systemd journal socket open
      build: force GCC 15 to initialize padding bits
      net/cpfl: fix representor parsing log
      raw/cnxk_gpio: fix file descriptor leak
      eal: fix devargs layers parsing out of bounds
      net/qede: fix debug messages array
      examples/ptpclient: fix message parsing
      net/hinic: fix flow type bitmask overflow
      crypto/dpaa2_sec: fix bitmask truncation
      crypto/dpaa_sec: fix bitmask truncation
      event/dpaa: fix bitmask truncation
      net/dpaa: fix bitmask truncation
      net/dpaa2: fix bitmask truncation
      net/qede: fix nested loops
      examples/l3fwd: fix socket ID check
      common/cnxk: fix null check
      doc: fix feature flags for queue start/stop
      app/testpmd: fix out-of-bound reference in offload config
      pdump: clear statistics when enabled

Tejasree Kondoj (1):
      examples/ipsec-secgw: fix cryptodev and eventdev IDs

Thierry Herbelot (1):
      ethdev: fix registers info request

Thomas Monjalon (1):
      cryptodev: fix C++ include

Tudor Cornea (1):
      net/af_packet: fix socket close on device stop

Vamsi Attunuru (1):
      common/cnxk: fix DPI mailbox structure

Viacheslav Ovsiienko (1):
      net/mlx5: fix hardware packet type translation

Vladimir Medvedkin (4):
      net/ixgbe: fix E610 support in flow engine
      net/ice: fix memory leak in scalar Rx
      net/ice: fix flows handling
      net/ice: fix flow engines order

Wathsala Vithanage (1):
      crypto/openssl: fix CMAC auth context update

Wei Hu (1):
      net/mana: do not ring short doorbell for every mbuf alloc

Yang Ming (2):
      eal/linux: fix memseg length in legacy mem init
      net/iavf: fix mbuf release in Arm multi-process

Yunjian Wang (2):
      vhost: check GSO size validity
      vhost: check descriptor chains length

Zaiyu Wang (2):
      net/ngbe: fix WOL and NCSI capabilities
      net/txgbe: remove useless condition for SW-FW sync

Zerun Fu (2):
      net/nfp: fix multiple PFs check from NSP
      net/nfp: fix misuse of function return values

