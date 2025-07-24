Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1FC87FC5
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Jul 2025 16:15:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B5E41141;
	Thu, 24 Jul 2025 18:15:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 50FE840285
 for <dev@dpdk.org>; Thu, 24 Jul 2025 18:15:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753373736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=U2c00PgHrNE+cBX+IaLancDHjeC06MzFxU97prDjnNI=;
 b=D2h+LkbOZrVEUWj5GhPUm8mQo/NsbX/ThOI+LssgwgnQoPRdBaK0vufUls0cnxONSLSTSB
 Ch3kwkbVDNumXiLGFCIvj3bv+r6yvd7mmI6FZGzEnVdZvXKEzQPOw1Us/Hqnj6VtXMEqr1
 7mKWisxTNpRU8HVZy60vIb6lZICU/WM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-OCMIlTiNMD6iVnMumIaQCw-1; Thu,
 24 Jul 2025 12:15:33 -0400
X-MC-Unique: OCMIlTiNMD6iVnMumIaQCw-1
X-Mimecast-MFC-AGG-ID: OCMIlTiNMD6iVnMumIaQCw_1753373731
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0512D1800877; Thu, 24 Jul 2025 16:15:31 +0000 (UTC)
Received: from rh.redhat.com (unknown [10.44.33.255])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E8461956089; Thu, 24 Jul 2025 16:15:24 +0000 (UTC)
From: Kevin Traynor <ktraynor@redhat.com>
To: stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, yanghliu@redhat.com
Subject: 24.11.3 patches review and test
Date: Thu, 24 Jul 2025 17:15:11 +0100
Message-ID: <20250724161514.396245-1-ktraynor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dJ78MsJt6baC6Xk0yizXG1DZkilG0FV89ZZlqMQE9MQ_1753373731
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Here is a list of patches targeted for stable release 24.11.3.

The planned date for the final release is 12th August 2025.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v24.11.3-rc1

These patches are located at branch 24.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Kevin

---
Amiya Ranjan Mohakud (2):
      net/iavf: fix VLAN strip setting after enabling filter
      net/iavf: fix VLAN strip disabling for ADQ v2 capability

Anatoly Burakov (1):
      net/ixgbe: fix indentation

Andre Muezerie (1):
      net/mlx5: fix link on Windows

Ariel Otilibili (2):
      net/af_xdp: fix use after free in zero-copy Tx
      pcapng: fix null dereference in close

Arkadiusz Kusztal (2):
      crypto/qat: fix out-of-place header bytes in AEAD raw API
      crypto/qat: fix out-of-place chain/cipher/auth headers

Bing Zhao (2):
      net/mlx5: fix WQE size calculation for Tx queue
      examples/ntb: check more heap allocations

Bruce Richardson (9):
      net/fm10k/base: fix compilation warnings
      net/ixgbe/base: correct definition of endianness macro
      net/ixgbe/base: fix compilation warnings
      net/i40e/base: fix unused value warnings
      net/i40e/base: fix compiler warnings
      net/ice: fix support for 3 scheduler levels
      test/malloc: improve resiliency
      power/intel_uncore: fix crash closing uninitialized driver
      net/ixgbe/base: fix lock checker errors

Chaoyong He (6):
      net/nfp: fix crash with null RSS hash key
      net/nfp: fix hash key length logic
      app/testpmd: fix RSS hash key update
      net/nfp: standardize NFDk Tx descriptor endianness
      net/nfp: standardize Rx descriptor endianness
      net/nfp: standardize NFD3 Tx descriptor endianness

Chengwen Feng (3):
      app/testpmd: relax number of TCs in DCB command
      bus: cleanup device lists
      net/hns3: fix queue TC configuration on VF

Clemens Famulla-Conrad (1):
      dts: fix deterministic doc

Danylo Vodopianov (3):
      net/ntnic: avoid divide by zero
      net/ntnic: fix ring queue operation
      net/ntnic: remove unused code

Dariusz Sosnowski (7):
      net/mlx5: fix header modify action on group 0
      net/mlx5: validate GTP PSC QFI width
      net/mlx5: fix counter pool init error propagation
      net/mlx5: fix counter service cleanup on init failure
      net/mlx5: fix flex tunnel flow validation
      net/mlx5: fix VLAN stripping on hairpin queue
      net/mlx5: fix masked indirect age action validation

David Marchand (7):
      acl: fix build with GCC 15 on aarch64
      vhost: fix wrapping on control virtqueue rings
      eal: warn if no lcore is available
      test/lcore: fix race in per-lcore test
      common/mlx5: fix dependency detection on Windows
      doc: remove reference to deprecated --use-device option
      eal: add description of service corelist in usage

Dengdui Huang (12):
      net/hns3: fix integer overflow in interrupt unmap
      net/hns3: fix memory leak on failure
      net/hns3: fix extra wait for link up
      net/hns3: fix memory leak for indirect flow action
      net/hns3: fix interrupt rollback
      net/hns3: fix divide by zero
      net/hns3: fix resources release on reset
      net/hns3: fix CRC data segment
      mem: fix lockup on address space shortage
      net/hns3: check requirement for hardware GRO
      net/hns3: allow Tx vector when fast free not enabled
      net/hns3: fix Rx packet without CRC data

Dhanya Pillai (2):
      net/ice: fix flow creation failure
      net/i40e: fix RSS on plain IPv4

Edvard Fagerholm (1):
      eal/x86: fix C++ build

Eugenio Pérez (2):
      vhost: search virtqueues driver data in read-only area
      vhost: fix net control virtqueue used length

Gagandeep Singh (2):
      common/dpaax: fix PDCP key command race condition
      common/dpaax: fix PDCP AES only 12-bit SN

Gavin Li (1):
      net/mlx5: align PF and VF/SF MAC address handling

Gowrishankar Muthukrishnan (5):
      crypto/cnxk: fix uninitialized variable
      crypto/cnxk: fix out-of-bounds access in SM2
      crypto/openssl: include private exponent in RSA session
      test/crypto: fix RSA vector as per RFC 8017
      test/crypto: fix RSA decrypt validation

Gregory Etelson (7):
      net/mlx5: remove unsupported flow meter action in HWS
      net/mlx5: fix error notification for large flow patterns
      net/mlx5: fix mark action with shared Rx queue
      app/testpmd: fix flow random item token
      net/mlx5: fix access to auxiliary flow data
      common/mlx5: fix extraction of auxiliary device name
      bus/auxiliary: fix crash in cleanup

Ivan Malov (1):
      net/sfc: fix action order on start failure

Jake Freeland (1):
      bus/pci/bsd: fix device existence check

Jaromír Smrček (1):
      doc: add kernel options required for mlx5

Jedrzej Jagielski (1):
      net/ixgbe/base: fix link status for E610

Jiawen Wu (13):
      net/txgbe: fix ntuple filter parsing
      net/txgbe: fix raw pattern match for FDIR rule
      net/txgbe: fix packet type for FDIR filter
      net/txgbe: fix to create FDIR filter for SCTP packet
      net/txgbe: fix FDIR perfect mode for IPv6
      net/txgbe: fix to create FDIR filter for tunnel packet
      net/txgbe: fix reserved extra FDIR headroom
      net/txgbe: fix MAC control frame forwarding
      net/ngbe: fix MAC control frame forwarding
      net/txgbe: fix device statistics
      net/ngbe: fix device statistics
      net/txgbe: restrict VLAN strip configuration on VF
      net/txgbe: add LRO flag in mbuf when enabled

Junfeng Guo (1):
      net/mlx5: fix template flow rule identification

Kaiwen Deng (4):
      net/ixgbe: enable ethertype filter for E610
      net/e1000: fix igb Tx queue offloads capability
      net/e1000: fix xstats name
      net/ixgbe: skip MACsec stats for E610

Khadem Ullah (1):
      net/mlx5: fix crash on age query with indirect conntrack

Konstantin Ananyev (1):
      net/ixgbe: remove VLAs

Long Li (5):
      bus/vmbus: use Hyper-V page size
      net/netvsc: use Hyper-V page size
      net/netvsc: add stats counters from VF
      net/mana: check vendor ID when probing RDMA device
      bus/vmbus: align ring buffer data to page boundary

Long Wu (2):
      net/nfp: fix flow rule freeing
      net/nfp: fix control message overflow

Lukasz Krakowiak (2):
      net/ice/base: fix integer overflow
      net/ice/base: fix typo in device ID description

Maayan Kashani (5):
      net/mlx5: fix validation for GENEVE options
      net/mlx5: fix GRE flow item validation
      net/mlx5/hws: fix send queue drain on FW WQE destroy
      ethdev: fix error struct in flow configure
      net/mlx5: fix crash in HWS counter pool destroy

Madhuker Mythri (1):
      net/bonding: avoid RSS RETA update in flow isolation mode

Marat Khalili (1):
      buildtools/test: scan muti-line registrations

Mattias Rönnblom (1):
      eventdev: fix flag types consistency

Maxime Coquelin (1):
      net/mlx5: avoid setting kernel MTU if not needed

Mingjin Ye (2):
      net/ice: fix querying RSS hash for DCF
      net/ice: fix handling empty DCF RSS hash

Mohamed Feroz Abdul Majeeth (1):
      net/octeon_ep: increase mailbox timeout

Morten Brørup (1):
      eal/unix: fix log message for madvise failure

Nawal Kishor (1):
      common/cnxk: fix aura offset

Nithin Dabilpuram (1):
      common/cnxk: fix CQ tail drop

Nithinsen Kaithakadan (4):
      common/cnxk: fix qsize in CPT iq enable
      test/crypto: fix auth and cipher case IV length
      test/crypto: set to null after freeing operation
      common/cnxk: fix AES-CTR salt handling

Oleksandr Kolomeiets (1):
      net/ntnic: unmap DMA during queue release

Oleksandr Nahnybida (1):
      trace: fix overflow in per-lcore trace buffer

Paul Greenwalt (1):
      net/ice/base: fix media type check

Pavan Nikhilesh (3):
      event/cnxk: fix missing HW state checks
      eal: fix return value of lcore role
      doc: fix missing feature matrix for event device

Praveen Shetty (1):
      net/idpf: fix truncation of constant value

Pravin Pathak (6):
      event/dlb2: fix dequeue with CQ depth <= 16
      event/dlb2: fix validaton of LDB port COS ID arguments
      event/dlb2: fix num single link ports for DLB2.5
      event/dlb2: fix QID depth xstat
      event/dlb2: fix public symbol namespace
      app/eventdev: fix number of releases sent during cleanup

Radu Nicolau (3):
      crypto/virtio: fix driver cleanup
      crypto/qat: fix out-of-place chain/cipher/auth headers
      crypto/virtio: add request check on request side

Rahul Bhansali (2):
      net/cnxk: fix descriptor count update on reconfig
      net/cnxk: fix lock for security session operations

Rajesh Mudimadugula (2):
      vhost/crypto: fix cipher data length
      crypto/virtio: fix cipher data source length

Rakesh Kudurumalla (2):
      examples/ipsec-secgw: fix crash with IPv6
      examples/ipsec-secgw: fix crash in event vector mode

Robin Jarry (1):
      net: fix IPv6 check for IPv4 compat

Rui Ferreira (2):
      eal/linux: unregister alarm callback before free
      eal/freebsd: unregister alarm callback before free

Satheesh Paul (1):
      common/cnxk: fix E-tag pattern parsing

Shai Brandes (2):
      net/ena: fix control path interrupt mode
      net/ena: fix aenq timeout with low poll interval

Shani Peretz (1):
      app/crypto-perf: fix AAD offset alignment

Stephen Hemminger (4):
      net/qede: fix use after free
      bus/fslmc: fix use after free
      net/null: fix packet copy
      crypto/qat: fix size calculation for memset

Sucharitha Sarananaga (1):
      test/crypto: fix EdDSA vector description

Sunyang Wu (1):
      ethdev: keep promiscuous/allmulti value before disabling

Tanzeel Ahmed (1):
      examples/flow_filtering: fix make clean

Tejasree Kondoj (2):
      crypto/cnxk: fix QP stats
      crypto/cnxk: fix includes

Tirthendu Sarkar (1):
      event/dlb2: fix default credits based on HW version

Vanshika Shukla (1):
      crypto/dpaa2_sec: fix uninitialized variable

Viacheslav Ovsiienko (3):
      net/mlx5: fix hypervisor detection in VLAN workaround
      net/mlx5: fix out-of-order completions in ordinary Rx burst
      net/mlx5: fix maximal queue size query

Vidya Sagar Velumuri (2):
      net/octeon_ep: fix buffer refill
      crypto/cnxk: update SG list population

Volodymyr Fialko (1):
      examples/ipsec-secgw: fix number of queue pairs

Waldemar Dworakowski (1):
      net/ice/base: fix type conversion

Yan Lu (1):
      net/tap: fix qdisc add failure handling

Yang Ming (1):
      eal/linux: improve ASLR check

Yuan Wang (2):
      net/e1000: fix EEPROM dump
      net/ixgbe: fix port mask default value in filter

