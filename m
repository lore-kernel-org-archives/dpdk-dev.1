Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABAC55182
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2768C40272;
	Mon,  3 Aug 2026 18:53:10 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 23EE940269
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:08 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca97d139d8dso1980601a12.2
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775987;
 x=1786380787; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rvT6VRytPxfGvfrAzbOV92YHkVWXG9GLpqEC/TfK8Dk=;
 b=vEQj2dRCz/KSS4rs8GKQ8ruQijGhsXe8kmhcergh3XVJJFCqBYemVeuKLjw4NLQ/3d
 iUet7Xxam48ZtnP5yMvIjc3EikQOXWuC1dSSSJ4kw1NWEU4yK8gCSHAiTrT720AbS4mj
 jTykMKGtwlSZYUyk061Egd2btwxrGXm6OMpfYPKCFhgTuFoZ/hYgI0d+y9Y1Vq8Is+IH
 44sOpWp1LSIbgksdFbimKsBOZcfhGa14HpQzY8E/+UTAMh6Sd5chErKa2F+Y8VUXxMza
 4fu2Ar1/8kud1ojQCpgvLUP1kZMfITpPe0NyIwJRb1WGr1su8DqiH1QkcS2vnMiKJ9Qn
 ggpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775987; x=1786380787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rvT6VRytPxfGvfrAzbOV92YHkVWXG9GLpqEC/TfK8Dk=;
 b=C3a/fagcOyI2FxTWiBIbfPsRtTqv+bQkJZNGNpBb7jBfRF4kr3uT3az2lyclamFEnf
 xBzig5Fj21u75EqJ7p+qRSjaD4qdRxWj4URCowxHbUIBTNYD4dXNs6wSDSfTW0lW5Zq8
 +u2LrsT3ySk8XZKsrjqdoY33GOX2O0e6WiYSZX+bhzPxxFLe9nvJg9MthUqlySaWKDyl
 5vtqK7uW5TX0LzXYS9IUVyTEAWoLJRhyzxyBdQ3GUSS1gHEmOQxp1WsT9nQfhuwBS9xi
 XdiZjfl9UW4Db3jy1we60d0c6OelClNy6lyc3gq5PUrModVDuUoHfZClSXgpo5py08ql
 NeoA==
X-Gm-Message-State: AOJu0Ywzo9xyP88+Mv9Nqda+NUSNoe753241j6P270ZsqgqwnGMt0ZaO
 7/SLKdc2qOUFzYLRrEOCn65nwPrWpTkzzYPrypYnfENQl5Izajx9D8iTE8bfFi7BRHsEV08VK3D
 MXk5Y
X-Gm-Gg: AR+sD131FBilFpOpnR5040YNn6ZA+JLswb5TSezdPQsoAVPnHHqBodu8ixu5pbpZbgV
 gUpzoAMtaSCGfKCFNMlNqHailBibEqAPiLuXwX2UpEZ6QEZTacczS/SgKukCh487UnJ5R9aVjIW
 IG7hhc6I6x9DYlQUQC1m4FmjeThlkAEj83JdumRbzCf9zF1fwmcWuS7IMD+Dlp9Vlu3RYAVS3bm
 CmYvqo6IXJHFnJfrC7t+GsLLd60znhXaGF3ZFs34xWHJnStLen82SkvhBSEJfYpMrT1VZh8frv+
 PnQbOPxkGpGJYLzZIolLua4dOFcp6+hn3b3bhepCROT0hLZE3dRvTodNH31wAlujqiUK+RE3v4H
 LvU1m92eLZBhC2lcxJxunyWOPS2PVtWcxXcJeuOFGCtdaUNcwSSwoXHYb3UId14H5Xy7sIjQwiL
 eSIdm4RydIxb9DERJnXhmEroFVXfoDz0Obufn9UOcJ6ir508NKmaJXo3iB++QvEFZygTW3DVzAG
 FGAmB88o3wZxoXzJSKsikmdbB4=
X-Received: by 2002:a05:6a20:6a1e:b0:3c8:e313:8d42 with SMTP id
 adf61e73a8af0-3c92a77e60fmr10387935637.31.1785775986932; 
 Mon, 03 Aug 2026 09:53:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/22] ethdev: clean up legacy flow director
Date: Mon,  3 Aug 2026 09:51:46 -0700
Message-ID: <20260803165304.289869-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

There is more to do here, but with no Intel hardware and no standalone
tests for this code, I have kept to mechanical refactoring.

v2:
- fix enetfec driver not built on x86
- reword commit messages based on AI review

Stephen Hemminger (22):
  drivers/net: remove unused include in dpaa
  ethdev: use DPDK byte order conversion
  net/ixgbe: remove experimental FDIR API
  net/i40e: remove experimental FDIR API
  app/testpmd: remove support for flow director
  net/gve: include IP, UDP and TCP headers
  crypto/dpaa_sec: include UDP header
  net/nfp: break implicit dependency on rte_eth_ctrl.h
  net/mana: include used network headers
  gro: include headers directly
  app/test: include headers directly
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
 app/test-pmd/cmdline.c                        |  21 +--
 app/test-pmd/config.c                         | 163 ------------------
 app/test-pmd/testpmd.h                        |   3 -
 app/test/test_bpf.c                           |  18 +-
 app/test/test_security_inline_macsec.c        |   2 +
 app/test/test_security_inline_proto.c         |   1 +
 doc/api/doxy-api-index.md                     |   1 -
 doc/guides/rel_notes/release_26_11.rst        |  19 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  36 ----
 drivers/crypto/dpaa_sec/dpaa_sec.h            |   2 +
 drivers/net/dpaa/dpaa_ptp.c                   |   1 -
 drivers/net/dpaa2/dpaa2_ptp.c                 |   1 -
 drivers/net/enetfec/enet_regs.h               |   2 +
 drivers/net/gve/gve_ethdev.h                  |   3 +
 drivers/net/hinic/hinic_pmd_ethdev.h          |   2 +
 drivers/net/hinic3/hinic3_ethdev.h            |   1 +
 drivers/net/intel/common/tx_scalar.h          |   3 +
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   2 +-
 drivers/net/intel/e1000/e1000_ethdev.h        |   1 +
 drivers/net/intel/e1000/igc_filter.h          |   2 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   5 +-
 drivers/net/intel/i40e/i40e_fdir.c            | 140 ---------------
 drivers/net/intel/i40e/i40e_flow.c            |   3 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c         |  34 ----
 drivers/net/intel/i40e/rte_pmd_i40e.h         |  33 ----
 drivers/net/intel/iavf/iavf_fsub.c            |   2 +-
 drivers/net/intel/iavf/iavf_hash.c            |   2 +-
 drivers/net/intel/ice/ice_acl_filter.c        |   2 +-
 drivers/net/intel/ice/ice_ethdev.h            |   2 +
 drivers/net/intel/ice/ice_generic_flow.c      |   1 +
 drivers/net/intel/ice/ice_hash.c              |   2 +-
 drivers/net/intel/ice/ice_switch_filter.c     |   2 +-
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        |   2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   6 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          | 117 -------------
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |  34 ----
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.h       |  32 ----
 drivers/net/mana/mana.c                       |   2 +
 drivers/net/mana/tx.c                         |   3 +
 drivers/net/mlx5/mlx5_ethdev.c                |   1 +
 drivers/net/mlx5/mlx5_flow.h                  |   1 +
 drivers/net/mlx5/mlx5_txq.c                   |   1 +
 drivers/net/mlx5/mlx5_utils.c                 |   1 +
 drivers/net/mlx5/mlx5_utils.h                 |   1 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   1 +
 drivers/net/nfp/nfp_ethdev.c                  |   6 +-
 drivers/net/nfp/nfp_net_common.h              |   1 +
 drivers/net/ngbe/ngbe_rxtx.c                  |   4 +
 drivers/net/r8169/r8169_rxtx.c                |   3 +
 drivers/net/rnp/rnp_rxtx.c                    |   6 +
 drivers/net/sfc/sfc_dp.c                      |   1 +
 drivers/net/txgbe/txgbe_ethdev.h              |   1 +
 examples/l2fwd-macsec/main.c                  |   2 +
 examples/l3fwd-graph/main.c                   |   1 +
 examples/l3fwd/l3fwd.h                        |   2 +
 lib/ethdev/ethdev_driver.h                    |  36 ----
 lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h}  |  58 +++++--
 lib/ethdev/meson.build                        |   2 +-
 lib/ethdev/rte_ethdev.h                       |  13 +-
 lib/ethdev/sff_8472.c                         |   3 +-
 lib/gro/gro_tcp4.c                            |   1 +
 lib/gro/gro_vxlan_tcp4.c                      |   4 +-
 lib/gro/gro_vxlan_udp4.c                      |   1 +
 lib/gro/rte_gro.c                             |   1 +
 lib/node/udp4_input.c                         |   1 +
 67 files changed, 165 insertions(+), 701 deletions(-)
 rename lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h} (91%)

-- 
2.53.0

