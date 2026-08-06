Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3692FC55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:10:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 111F64027E;
	Thu,  6 Aug 2026 07:10:16 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 7C3BF4021E
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:14 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so1823499a12.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993013;
 x=1786597813; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aBhIdxQmcsf+CUil5E2RWOUHGl+5CKywJrCLZt1B4qg=;
 b=AujQIMN97lAYGd7v8xWDqbjfq/tW76rpIf5vD9g0oyxfgTuAmozt+ylBVtS6O4iyUw
 Hjgs6hfZskbpljYXAxFGCCs+lBY9imA5fUbGP4mByQs7I1aEQhmTEwKHbS4qMAl8rkuu
 DoH7A/i0hc7sog880dMYeDDVkqKDbbWCz4dWxea+IO92suwPhSDKjiWBZdpx12VDW9lU
 7dEINYAgkUx5T/oQBz3GiCTcbnJz/JaKAMytG/rBY3XePMHh7lx1IDxiZ1p+yrG4rot3
 G4TpBjbbsLqeoFXlO2TGx7OTKXEL157FGSeQbaMk6Y1qdWO51RviT91ZEau5qGrLfUqn
 786A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993013; x=1786597813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aBhIdxQmcsf+CUil5E2RWOUHGl+5CKywJrCLZt1B4qg=;
 b=QCh+Bh2Ot3LSpUVRU/xE6Qlnex30MFIStnKWdtQI99SmP4wr7dJDyMjN2xAEoh+BTY
 FQeinXV3xg8ymu/I0/aq/eL+KKqp/EXoHOCX3G75zjvpO1uSfMjxJs+xqLSbyxtIe1qp
 m7GHIRxzCZIlb0AZXoETPIahqMe5VHzSKwQxNURXFEt0DtaqF4ohGbICZSncN63uHlNX
 Os7unz93JV6HF3SLGhXJ0SZO+zCKlX2u92sLmmILyORg5lzS2I+gV2vb7ZE8bUK2XJFH
 5eBiwpWc1zWuqpXCYwhZH5bQyierRpnQdLSR6UPb5j4az4Ijvtj+KsV/GVB14AXxtDMT
 mvyg==
X-Gm-Message-State: AOJu0Yx9QiIF2gl2NB6QKUyb64748ISTkvpJX0bvBSE/4KO3NkfttZXE
 6tHqBE7VaY/wME5rLc3fY9UXSfS0li3f+052KobK7sJaiH7Wtuei2Aqcv1MzEv+hZ3Gtm30Gobn
 AOUquK6A=
X-Gm-Gg: AR+sD13WWhCJeppEljGolJ1hfjrOawoB+r95RKDc10c/3kfmhAEY7ei+JGPMeKcWxv7
 Vg18QuVj/SHtcXlCA93Di85e+YGkYuzuYAzHwfq8UYZ+rUzJyU3SXOKzIHZzvWssY7SEpGxWElT
 nRVMtTTNBTkm4dw+3FsuYIFHsJp7WWW4RP448IdEpA1/L+03qS1bOo9yVSG0VPi7RI+aorJnQy3
 Xm5lNfkodBotYYXYCHoadDEGAm+bn+uj4ztGgt8nMcnYs/9nK06rbxn68a8oY6eVrusq4zUBcSL
 7lTY0K8gHGqCmyhuwyF9QR4iyd3TICcBlAtC1iOVzS9sZhuy1itP/8bCuNfhvgD2b7j3XP/4u5S
 IIAfj2BIfMQMJ6KCzweWDgBoaorm4HLRVcGHze7wRM+2HBDGxTXspIHsQMKegd0AoPYahIHxm/4
 uAdKLq7k60o78lAu0MccmKGukITYKfODLvAb3rBh6OgF8V1oarnIgF5L6n2AAiot0rNKaVvmuE0
 QJlUpwX46wPg1qCZs57EXnJyJI=
X-Received: by 2002:a05:6a20:7f81:b0:3c3:a0cd:9d27 with SMTP id
 adf61e73a8af0-3cb85ea2b4fmr13090500637.26.1785993007397; 
 Wed, 05 Aug 2026 22:10:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/23] ethdev: refactor remaining uses of flow director
Date: Wed,  5 Aug 2026 22:08:54 -0700
Message-ID: <20260806051004.166778-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

The original flow support in DPDK was Intel-specific and built around
the flow director feature. It was superseded by the generic rte_flow
API introduced in the 17.02 release. The direct API calls to flow
director were removed in 20.11, but the data structures were never
removed and drivers still use them. Some Intel drivers also carry
driver-specific APIs related to flow director.

These vestiges mean applications can still see flow director data
structures, since rte_ethdev.h pulls in rte_eth_ctrl.h. It also means
several drivers and libraries have come to depend on network header
definitions arriving indirectly.

Since drivers still need these definitions, rte_eth_ctrl.h is renamed
to ethdev_fdir.h and the remaining bits in ethdev_driver.h are folded
into it. This is a driver SDK header, not public API, and exists only
so that drivers still carrying legacy flow director state have
somewhere to get these definitions. New drivers should not use it.

Applications relying on the indirect includes will need to add explicit
ones; this is a source level change only, with no ABI impact. The fdir
option of the testpmd "show port" and "clear port" commands is also
removed.

v4 - fix AI review comments
   - fix build of enetfec
   - cleanup more leftovers from flow director in testpmd

Stephen Hemminger (23):
  drivers/net: remove unused include in dpaa and dpaa2
  ethdev: use DPDK byte order conversion
  net/ixgbe: remove experimental FDIR API
  net/i40e: remove experimental FDIR API
  app/testpmd: remove support for flow director
  app/testpmd: move str_to_flowtype to i40e
  app/test: include headers directly
  gro: include headers directly
  crypto/dpaa_sec: include UDP header
  net/gve: include UDP, SCTP and TCP headers
  net/nfp: break implicit dependency on rte_eth_ctrl.h
  net/mana: include used network headers
  node: get UDP header
  net/rnp: include network headers
  net/r8169: get network headers
  net/ngbe: include network protocol headers
  examples: include network headers
  net/mlx5: include rte_flow as needed
  net/sfc: include rte_flow
  net/intel/common: include network headers
  net/enetfec: add missing sys/types.h include
  ethdev, drivers: isolate flow director
  doc: add release note about rte_ethdev changes

 app/test-eventdev/test_pipeline_common.h      |   1 +
 app/test-pmd/cmdline.c                        |  21 +-
 app/test-pmd/config.c                         | 225 ------------------
 app/test-pmd/testpmd.h                        |   6 -
 app/test/test_bpf.c                           |  20 +-
 app/test/test_security_inline_macsec.c        |   2 +
 app/test/test_security_inline_proto.c         |   1 +
 doc/api/doxy-api-index.md                     |   1 -
 doc/guides/nics/i40e.rst                      |  46 ----
 doc/guides/rel_notes/release_26_11.rst        |  24 ++
 doc/guides/testpmd_app_ug/intro.rst           |   4 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  56 +----
 drivers/crypto/dpaa_sec/dpaa_sec.h            |   2 +
 drivers/net/dpaa/dpaa_ptp.c                   |   1 -
 drivers/net/dpaa2/dpaa2_ptp.c                 |   1 -
 drivers/net/enetfec/enet_regs.h               |   2 +
 drivers/net/gve/gve_ethdev.h                  |  13 +-
 drivers/net/hinic/hinic_pmd_ethdev.h          |   2 +
 drivers/net/hinic3/hinic3_ethdev.h            |   1 +
 drivers/net/intel/common/tx_scalar.h          |   3 +
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   2 +-
 drivers/net/intel/e1000/e1000_ethdev.h        |   1 +
 drivers/net/intel/e1000/igc_filter.h          |   2 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   5 +-
 drivers/net/intel/i40e/i40e_fdir.c            | 140 -----------
 drivers/net/intel/i40e/i40e_flow.c            |   3 +-
 drivers/net/intel/i40e/i40e_testpmd.c         |  51 ++++
 drivers/net/intel/i40e/rte_pmd_i40e.c         |  34 ---
 drivers/net/intel/i40e/rte_pmd_i40e.h         |  33 ---
 drivers/net/intel/iavf/iavf_fsub.c            |   2 +-
 drivers/net/intel/iavf/iavf_hash.c            |   2 +-
 drivers/net/intel/ice/ice_acl_filter.c        |   2 +-
 drivers/net/intel/ice/ice_ethdev.h            |   2 +
 drivers/net/intel/ice/ice_generic_flow.c      |   1 +
 drivers/net/intel/ice/ice_hash.c              |   2 +-
 drivers/net/intel/ice/ice_switch_filter.c     |   2 +-
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        |   2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   6 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          | 117 ---------
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |  34 ---
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.h       |  32 ---
 drivers/net/mana/mana.c                       |  26 +-
 drivers/net/mana/tx.c                         |   3 +
 drivers/net/mlx5/mlx5_ethdev.c                |   1 +
 drivers/net/mlx5/mlx5_flow.h                  |   1 +
 drivers/net/mlx5/mlx5_txq.c                   |   1 +
 drivers/net/mlx5/mlx5_utils.c                 |   1 +
 drivers/net/mlx5/mlx5_utils.h                 |   1 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   1 +
 drivers/net/nfp/nfp_ethdev.c                  |   6 +-
 drivers/net/nfp/nfp_net_common.h              |   4 +-
 drivers/net/ngbe/ngbe_rxtx.c                  |   4 +
 drivers/net/r8169/r8169_rxtx.c                |  19 +-
 drivers/net/rnp/rnp_rxtx.c                    |   6 +
 drivers/net/sfc/sfc_dp.c                      |   1 +
 drivers/net/txgbe/txgbe_ethdev.h              |   1 +
 examples/l2fwd-macsec/main.c                  |   2 +
 examples/l3fwd-graph/main.c                   |   1 +
 examples/l3fwd/l3fwd.h                        |   2 +
 lib/ethdev/ethdev_driver.h                    |  36 ---
 lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h}  |  62 ++++-
 lib/ethdev/meson.build                        |   2 +-
 lib/ethdev/rte_ethdev.h                       |  13 +-
 lib/ethdev/sff_8472.c                         |   4 +-
 lib/gro/gro_tcp4.c                            |   9 +-
 lib/gro/gro_tcp6.c                            |   9 +-
 lib/gro/gro_vxlan_tcp4.c                      |  10 +-
 lib/gro/gro_vxlan_udp4.c                      |   9 +-
 lib/gro/rte_gro.c                             |   9 +-
 lib/node/udp4_input.c                         |  17 +-
 71 files changed, 324 insertions(+), 848 deletions(-)
 rename lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h} (90%)

-- 
2.53.0

