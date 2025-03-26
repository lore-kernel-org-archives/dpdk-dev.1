Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17612C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 11:51:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8DF5402DF;
	Wed, 26 Mar 2025 12:51:40 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by mails.dpdk.org (Postfix) with ESMTP id 59D01402DA;
 Wed, 26 Mar 2025 12:51:39 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3545362f8f.0; 
 Wed, 26 Mar 2025 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742989898; x=1743594698; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fFI2ZYOy+PQP28V5h5l09cesQFbIMsfjz35Sm+5pm6A=;
 b=nruS4jbeVyArNcYbLGMUfqIjIVhmFEqAwxrxFkqjRRejd3tbpZJ87gSS9CbQL97enl
 FYoZ83ifCTzMOzjqpJ7GdhCc76Qs9afy1YSddVxHckgYKnM6PUZcqVYgDR0c96q0C2Kx
 tHpwY/mI5DNKmTfNpNAf+nP9nwWIVkrtjj9U6c9rUgWMBKTvm83i5uYLkzKW47GUg4u0
 S6wiTGdotRtl/4uU7RhoyoznF0IKeZ+rv2hdN0wZBjZoewZPTehWoIdWCHeVQZahwwjE
 I5QtwJn1hdsb/mLKP+YE3hnVjGzLbv19XbLcLyqFv6BW5B5vNXEgmae4EyQJEa/KfCbn
 Nh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742989898; x=1743594698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFI2ZYOy+PQP28V5h5l09cesQFbIMsfjz35Sm+5pm6A=;
 b=P+vvvL0QdyCO61lKvXNJ5n8Ftrg7vDx9RG+/CHqm9Hn0/sCIqTFlGAbiURTpdCMxTJ
 FQNJx3hC1Y4fDu++WypHvmB7j0I9bh7CGIqPCUDpm+DR54UQXGbkY/mLH0CJRias13wm
 lRmEdQE/UxEJdkfQspp8ZJxRKWuVT+7aVzbvDl+N3/W+4tVIKFSkfWG7K3/z8COV4sAF
 hf9eSvx23Fe1W6dBkhDp7pdKj/+5UgNcIQKXdxiGtL2IkImQYgznIrwzM+47ZmuWupVx
 oi35TopVqcK2IGvz9Wpb72SfAMkbLXlzC3pFbfDXZ7aCdCDnoYnMuQFmrTM2i8k/LioO
 9SLw==
X-Gm-Message-State: AOJu0YwKlkav27QDsWtOFgP2eGEfN0Xty1n6jrQNZWNBKGj254z+oD14
 Q7tTd9rZEMkt0gECKZVlZioXJtBAUb+HEla/Dp4wHPN5cSCHeijIvgk/EQ==
X-Gm-Gg: ASbGncviESoK1OJZ+S7Rx0XRUshCiXNLTovrb8HKOw4J+ZxMf51dnBFBuUnMROJ/YSp
 q6EPDGpq2Kf3t+UUQtchtgnIB9mvcRf7FFMGC2EhYK249x+VG5RpAfHR0RBAEbiIJOptK6/Be4+
 5ak1npeS+NGdg0/ayMCICaoVjT6nW5OSBuBHulbFdKHTNNHu8h+hGBnOxbASL10KNO6CDVo9F4v
 fNFfxENAX7CkM4FhXG6D7t9ofJnJ0Kp75/FvNvN/+YjuLtAaCuozotkIO6k4P/TKb3FUcn53a4M
 YMezSeJ1U/VWUdsQkAIOAZeDYSfn5SA+NjEdCiN4e1si34eW9hI=
X-Google-Smtp-Source: AGHT+IFlR63Qw/5r4gG9WVTKZ8yCA389xmabhuwe8mUV3etHHqeEQGWBIzjvNFkO+9ZzCYOjZeBrJg==
X-Received: by 2002:a05:6000:43c9:b0:391:2f15:c1f4 with SMTP id
 ffacd0b85a97d-3997f95b727mr11340827f8f.55.1742989898341; 
 Wed, 26 Mar 2025 04:51:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:c885:591e:b773:689e])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43d43f332adsm232715165e9.3.2025.03.26.04.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 04:51:37 -0700 (PDT)
From: luca.boccassi@gmail.com
To: stable@dpdk.org
Cc: dev@dpdk.org, Ali Alnubani <alialnu@nvidia.com>,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Kevin Traynor <ktraynor@redhat.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>
Subject: 22.11.8 patches review and test
Date: Wed, 26 Mar 2025 11:51:17 +0000
Message-ID: <20250326115132.1444530-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
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

Here is a list of patches targeted for stable release 22.11.8.

The planned date for the final release is 2025/04/10.

Please help with testing and validation of your use cases and report
any issues/results with reply-all to this mail. For the final release
the fixes and reported validations will be added to the release notes.

A release candidate tarball can be found at:

    https://dpdk.org/browse/dpdk-stable/tag/?id=v22.11.8-rc1

These patches are located at branch 22.11 of dpdk-stable repo:
    https://dpdk.org/browse/dpdk-stable/

Thanks.

Luca Boccassi

---
Aleksandr Loktionov (2):
      net/igc/base: fix MAC address hash bit shift
      net/e1000/base: fix MAC address hash bit shift

Amir Avivi (2):
      net/igc/base: fix iterator type
      net/e1000/base: fix iterator type

Anatoly Burakov (3):
      net/e1000/base: correct mPHY access logic
      net/e1000: fix crashes in secondary processes
      net/ixgbe: fix crashes in secondary processes

Andre Muezerie (5):
      eal/x86: fix some intrinsics header include for Windows
      net/bnxt: fix indication of allocation
      common/idpf: fix void function returning a value
      net/intel: fix void functions returning a value
      stack: fix pop in C11 implementation

Andrew Boyer (1):
      doc: update ionic driver guide

Ariel Otilibili (5):
      net/sfc: remove unnecessary assignment
      net/enetfec: remove useless assignment
      use Python raw string notation
      eal/linux: remove useless assignments
      mempool: fix errno in empty create

Arkadiusz Kusztal (1):
      test/crypto: fix check for OOP header data

Barbara Skobiej (3):
      net/igc/base: fix data type in MAC hash
      net/e1000/base: fix data type in MAC hash
      net/e1000/base: fix reset for 82580

Bruce Richardson (6):
      net/iavf: remove reset of Tx prepare function pointer
      net/intel: fix build with icx
      test/dma: fix pointers in IOVA as PA mode
      net/iavf: check interrupt registration failure
      net/iavf: fix crash on app exit on FreeBSD
      eal: fix undetected NUMA nodes

Carolyn Wyborny (1):
      net/e1000/base: skip management check for 82575

Chengwen Feng (2):
      app/testpmd: show all DCB priority TC map
      app/testpmd: avoid crash in DCB config

David Marchand (2):
      net/mlx5: fix leak in HWS flow counter action
      ci: point at GitHub mirror

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

Ferruh Yigit (1):
      ethdev: convert string initialization

Gavin Hu (1):
      net/mlx5: fix polling CQEs

Gowrishankar Muthukrishnan (3):
      crypto/virtio: fix data queues iteration
      examples/vhost_crypto: fix user callbacks
      crypto/openssl: validate incorrect RSA signature

Gregory Etelson (1):
      net/mlx5: fix IPIP tunnel verification

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

Kevin Traynor (1):
      vhost: add null callback checks

Konstantin Ananyev (1):
      test/ring: fix init with custom number of lcores

Long Li (3):
      net/netvsc: scan all net devices under the PCI device
      net/netvsc: remove device if its net devices removed
      net/mana: fix multi-process tracking

Long Wu (1):
      net/bonding: fix dedicated queue setup

Maayan Kashani (7):
      net/mlx5: adjust actions per rule limitation
      net/mlx5: fix flush of non-template flow rules
      net/mlx5: fix GRE flow match with SWS
      net/mlx5: fix LACP packet handling in isolated mode
      net/mlx5/hws: fix crash using represented port without ID
      net/mlx5/hws: fix GTP flags matching
      net/mlx5: fix GRE matching on root table

Matthew Smith (1):
      net/ice: fix dropped packets when using VRRP

Minggang Li (Gavin) (1):
      net/mlx5: fix Netlink socket leak

Mingjin Ye (1):
      net/ixgbe: fix minimum Rx/Tx descriptors

Nawal Kishor (1):
      common/cnxk: fix atomic load in batch ops

Nicolas Chautru (1):
      test/bbdev: update FFT test vectors

Nithin Dabilpuram (1):
      common/cnxk: fix inbound IPsec SA setup

Nithinsen Kaithakadan (1):
      examples/ipsec-secgw: fix IV length in CTR 192/256

Pawel Malinowski (2):
      net/igc/base: fix semaphore timeout value
      net/e1000/base: fix semaphore timeout value

Przemyslaw Ciesielski (4):
      net/igc/base: fix bitwise operation type
      net/igc/base: fix NVM data type in bit shift
      net/e1000/base: fix bitwise operation type
      net/e1000/base: fix NVM data type in bit shift

Rahul Bhansali (1):
      net/cnxk: fix NIX send header L3 type

Rajesh Mudimadugula (1):
      crypto/virtio: fix redundant queue free

Sangtani Parag Satishbhai (1):
      net/bnxt: fix crash when representor is re-attached

Sasha Neftin (3):
      net/igc/base: increase PHY power up delay
      net/igc/base: reset loop variable
      net/igc/base: fix LTR for i225

Shani Peretz (1):
      bus/pci: fix registered device name

Shaokai Zhang (2):
      test/crypto: fix AES-ECB test lengths
      test/crypto: remove unused variable

Shijith Thotton (1):
      test/event: fix number of queues in eventdev conf

Stephen Hemminger (21):
      crypto/cnxk: fix build with GCC 15
      net/thunderx/base: fix build with GCC 15
      build: force GCC 15 to initialize padding bits
      raw/cnxk_gpio: fix file descriptor leak
      net/i40e: remove duplicate code
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
      test/bonding: fix active backup receive test
      doc: fix feature flags for queue start/stop
      app/testpmd: fix out-of-bound reference in offload config
      pdump: clear statistics when enabled

Tejasree Kondoj (1):
      examples/ipsec-secgw: fix cryptodev and eventdev IDs

Tudor Cornea (1):
      net/af_packet: fix socket close on device stop

Vamsi Attunuru (1):
      common/cnxk: fix DPI mailbox structure

Viacheslav Ovsiienko (1):
      net/mlx5: fix hardware packet type translation

Vladimir Medvedkin (1):
      net/ice: fix memory leak in scalar Rx

Wathsala Vithanage (1):
      crypto/openssl: fix CMAC auth context update

Yang Ming (2):
      eal/linux: fix memseg length in legacy mem init
      net/iavf: fix mbuf release in Arm multi-process

Yunjian Wang (2):
      vhost: check GSO size validity
      vhost: check descriptor chains length

Zaiyu Wang (1):
      net/txgbe: remove useless condition for SW-FW sync
