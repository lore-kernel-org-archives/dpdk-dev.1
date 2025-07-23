Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A62C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 16:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5E4240DF8;
	Wed, 23 Jul 2025 18:08:38 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mails.dpdk.org (Postfix) with ESMTP id 5CFBD40DF8;
 Wed, 23 Jul 2025 18:08:37 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-454f428038eso59842975e9.2; 
 Wed, 23 Jul 2025 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286917; x=1753891717; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NsK0TPIwnlDbTJCey5aiPYLvUm2Nadtd8NyXB0I7ECM=;
 b=cbdccH+nR4Y2hueX2C6XtDXARGnz7BI6CzrWcotSQ5659ubebPcoIntAy3X/sV0fpM
 k2tgGLXIx2aU44MkqDaYcq2iIurTaSUTg5TbhTwHRfDDv+5GRfwOuQBazEg0908POHmB
 w78qtYnqimX4QYEQuCCH8ZiN0sr5I36GqvkgaCEnxvdMpEd9jp0aBEJ1VF/xATnR+t0k
 3RXsFX4bg5eXN96aFrBg8RNse9WzPLG7ZaiI1vfMHtyseqwZKbvOuvj3WxWBH3R52xZ7
 K1qpwcvCrJc4XZvfM3upeM8ZTahBHpXNscXFyntZ1zhjCAtgpE3JtyGfz6XgIPWgUnML
 Cp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286917; x=1753891717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NsK0TPIwnlDbTJCey5aiPYLvUm2Nadtd8NyXB0I7ECM=;
 b=ZwwY8FjacMSM8LPlKny7pleZH0MewwN2iHEA94H1diLiLQBbDut95x5wdu1ggIo9XL
 aoZAGQX5hhi2vp8GdP4rnzwB+I78PRBeXxEl+Uu5vpPmO9qgEKO7G3VCRVPr2cVjma/Y
 NkaFni3rZtRVUMPZN+ZOLskW9+kBtCzPMgUCnY9N1xh3qNSPkhmBPlFYClH8j8lQWYfz
 vvE4yHRM33st1cEULshGlvr7NFqPIqGNmrQ8GZkNiaXWMnjR36X50Gcv7sLtMlVk+Tfl
 /kyrT6SazBqq3cteKlO2Hc6zhIjyCwri+wL1FJym26GS2jM9WDGJH2cEzuCEBMUszZ58
 dAlA==
X-Gm-Message-State: AOJu0Yyg4j1VKc3ATLl70ei0YHraXGTJLSaGHOwTTfS6YA/sVqdZ+vkn
 tpslw3SS9XMno/LYlEdnNPaMdenjA6UYV9jZe0Oer/IEnMCbkJviuqczUIXCHQ==
X-Gm-Gg: ASbGncsCIxgN3DRpXfr9LOnMdeco/k5qHuAH8lzkvNTDHfQcjkikKf90UZKeUquDiCm
 9c8IKAY00G8JJSsuOTFQy9PL3pSyVW+mzSzBZKaGGqRmIR0R2oeNiV0uC3AQxyL1GtZGNFMegpm
 AYg5G2cDWtGbZO6iM/74lOcNctv0r6BlciJ/0aM8VfvdtLvO4uyrH6oGl/HTNC2sLuJxtY4VqjR
 xKKgVo35wzYOIGwZbZU/g5aBTprIDvflBJYl8Efs964CIfUrHOKp/4En2UlMiKn8y35vC2kYG+j
 Qd49O1yoFx0NEs+DN1zrZTx/VVLt31MskuVanWV2ovTn0PlaVJOLH1yNbqxP3ffJL+jpwAP5UIy
 3vEM9vJMqt82dhh5m6R/fc4VOO7Lb
X-Google-Smtp-Source: AGHT+IHvkUVgfNzuz621BrealrWpVs7GfQEiCQ6wBgYq0M4/eEyY8Pz60qtZ4wsQ2Y/1S10CAJYniA==
X-Received: by 2002:a05:600c:4f0e:b0:456:11cb:b9c7 with SMTP id
 5b1f17b1804b1-45868d2a954mr31604045e9.25.1753286916426; 
 Wed, 23 Jul 2025 09:08:36 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:4ff9:8e9a:ab16:c98e])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45868ef50d8sm28684215e9.0.2025.07.23.09.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 09:08:35 -0700 (PDT)
From: luca.boccassi@gmail.com
To: stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Kevin Traynor <ktraynor@redhat.com>,
 Luca Boccassi <bluca@debian.org>, Pei Zhang <pezhang@redhat.com>,
 Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>
Subject: 22.11.9 patches review and test
Date: Wed, 23 Jul 2025 17:08:16 +0100
Message-ID: <20250723160822.1686060-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
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

Here is a list of patches targeted for stable release 22.11.9.

The planned date for the final release is by the 25th of August 2025.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.9-rc1

These patches are located at branch 22.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Luca Boccassi

---
Amiya Ranjan Mohakud (2):
      net/iavf: fix VLAN strip setting after enabling filter
      net/iavf: fix VLAN strip disabling for ADQ v2 capability

Anatoly Burakov (1):
      net/ixgbe: fix indentation

Ariel Otilibili (2):
      net/af_xdp: fix use after free in zero-copy Tx
      pcapng: fix null dereference in close

Arkadiusz Kusztal (2):
      crypto/qat: fix out-of-place header bytes in AEAD raw API
      crypto/qat: fix out-of-place chain/cipher/auth headers

Bing Zhao (2):
      net/mlx5: fix WQE size calculation for Tx queue
      examples/ntb: check more heap allocations

Bruce Richardson (7):
      net/fm10k/base: fix compilation warnings
      net/ixgbe/base: correct definition of endianness macro
      net/ixgbe/base: fix compilation warnings
      net/i40e/base: fix unused value warnings
      net/i40e/base: fix compiler warnings
      test/malloc: improve resiliency
      power/intel_uncore: fix crash closing uninitialized driver

Chaoyong He (1):
      app/testpmd: fix RSS hash key update

Chengwen Feng (3):
      app/testpmd: relax number of TCs in DCB command
      bus: cleanup device lists
      net/hns3: fix queue TC configuration on VF

Dariusz Sosnowski (5):
      net/mlx5: fix header modify action on group 0
      net/mlx5: validate GTP PSC QFI width
      net/mlx5: fix counter service cleanup on init failure
      net/mlx5: fix VLAN stripping on hairpin queue
      net/mlx5: fix masked indirect age action validation

David Marchand (5):
      ci: bump tested distributions in GHA
      acl: fix build with GCC 15 on aarch64
      eal: warn if no lcore is available
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
      net/hns3: allow Rx vector mode with VLAN filter

Dhanya Pillai (1):
      net/i40e: fix RSS on plain IPv4

Doug Foster (1):
      config/arm: add grace build config

Eugenio Pérez (1):
      vhost: search virtqueues driver data in read-only area

Gagandeep Singh (2):
      common/dpaax: fix PDCP key command race condition
      common/dpaax: fix PDCP AES only 12-bit SN

Gavin Li (1):
      net/mlx5: align PF and VF/SF MAC address handling

Gowrishankar Muthukrishnan (2):
      crypto/openssl: include private exponent in RSA session
      test/crypto: fix RSA decrypt validation

Gregory Etelson (3):
      net/mlx5: remove unsupported flow meter action in HWS
      common/mlx5: fix extraction of auxiliary device name
      bus/auxiliary: fix crash in cleanup

Hengqi Chen (1):
      net/virtio: fix check of threshold for Tx freeing

Jake Freeland (1):
      bus/pci/bsd: fix device existence check

Jiawen Wu (13):
      net/txgbe: fix ntuple filter parsing
      net/txgbe: fix raw pattern match for FDIR rule
      net/txgbe: fix packet type for FDIR filter
      net/txgbe: fix to create FDIR filter for SCTP packet
      net/txgbe: fix FDIR perfect mode for IPv6
      net/txgbe: fix reserved extra FDIR headroom
      net/txgbe: fix MAC control frame forwarding
      net/ngbe: fix MAC control frame forwarding
      net/txgbe: fix device statistics
      net/ngbe: fix device statistics
      net/txgbe: restrict VLAN strip configuration on VF
      net/txgbe: add LRO flag in mbuf when enabled
      net/txgbe: fix to create FDIR filter for tunnel packet

Kaiwen Deng (2):
      net/e1000: fix xstats name
      net/e1000: fix igb Tx queue offloads capability

Khadem Ullah (1):
      net/mlx5: fix crash on age query with indirect conntrack

Krzysztof Galazka (1):
      net/i40e/base: remove unused variables

Long Li (5):
      bus/vmbus: align ring buffer data to page boundary
      bus/vmbus: use Hyper-V page size
      net/netvsc: use Hyper-V page size
      net/netvsc: add stats counters from VF
      net/mana: check vendor ID when probing RDMA device

Luca Boccassi (1):
      Revert "net/virtio: fix check of threshold for Tx freeing"

Lukasz Krakowiak (2):
      net/ice/base: fix integer overflow
      net/ice/base: fix typo in device ID description

Maayan Kashani (2):
      ethdev: fix error struct in flow configure
      examples/multi_process: fix ports cleanup on exit

Madhuker Mythri (1):
      net/bonding: avoid RSS RETA update in flow isolation mode

Maxime Coquelin (1):
      net/mlx5: avoid setting kernel MTU if not needed

Mingjin Ye (1):
      net/ice: fix querying RSS hash for DCF

Morten Brørup (1):
      eal/unix: fix log message for madvise failure

Nithin Dabilpuram (1):
      common/cnxk: fix CQ tail drop

Nithinsen Kaithakadan (3):
      common/cnxk: fix qsize in CPT iq enable
      test/crypto: fix auth and cipher case IV length
      test/crypto: set to null after freeing operation

Oleksandr Nahnybida (1):
      trace: fix overflow in per-lcore trace buffer

Pavan Nikhilesh (1):
      eal: fix return value of lcore role

Pravin Pathak (4):
      event/dlb2: fix dequeue with CQ depth <= 16
      event/dlb2: fix validaton of LDB port COS ID arguments
      event/dlb2: fix num single link ports for DLB2.5
      app/eventdev: fix number of releases sent during cleanup

Radu Nicolau (3):
      crypto/virtio: add request check on request side
      crypto/virtio: fix driver cleanup
      crypto/qat: fix out-of-place chain/cipher/auth headers

Rahul Bhansali (3):
      net/cnxk: fix descriptor count update on reconfig
      common/cnxk: fix null pointer checks
      net/cnxk: fix lock for security session ops

Rajesh Mudimadugula (2):
      vhost/crypto: fix cipher data length
      crypto/virtio: fix cipher data source length

Rakesh Kudurumalla (2):
      examples/ipsec-secgw: fix crash with IPv6
      examples/ipsec-secgw: fix crash in event vector mode

Rui Ferreira (2):
      eal/linux: unregister alarm callback before free
      eal/freebsd: unregister alarm callback before free

Satheesh Paul (1):
      common/cnxk: fix E-tag pattern parsing

Shani Peretz (1):
      app/crypto-perf: fix AAD offset alignment

Stephen Hemminger (3):
      net/qede: fix use after free
      bus/fslmc: fix use after free
      net/null: fix packet copy

Sunyang Wu (1):
      ethdev: keep promiscuous/allmulti value before disabling

Thomas Monjalon (1):
      examples/multi_process: revert ports cleanup on exit

Tirthendu Sarkar (1):
      event/dlb2: fix default credits based on HW version

Viacheslav Ovsiienko (2):
      net/mlx5: fix maximal queue size query
      net/mlx5: fix hypervisor detection in VLAN workaround

Volodymyr Fialko (1):
      examples/ipsec-secgw: fix number of queue pairs

Yan Lu (1):
      net/tap: fix qdisc add failure handling

Yang Ming (1):
      eal/linux: improve ASLR check

Yuan Wang (2):
      net/e1000: fix EEPROM dump
      net/ixgbe: fix port mask default value in filter
