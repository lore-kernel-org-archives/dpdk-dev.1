Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8FCC55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:45:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3D1A402F1;
	Tue,  4 Aug 2026 17:45:58 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7139B40285
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:45:57 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d032846c95so54404805ad.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858356;
 x=1786463156; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PYYsIR/otj9q+KxnMLTNATYFtlGSABLSX6nUBtcQ8AA=;
 b=KqtlAXxXFrkrJk7sigAJMBU432FyiJyNO5lH8q1AcBxbOHbq+5IUsealCKYX3TO5eT
 egJJIAF0SuqL2aB7D8YkJvfXlLHDftcBEg6W32KhqeS1Us2DBq+YY2RSJndqVZb+7wBQ
 eB817nyZg1EuzTofRDklU6aM1XUMlKmHf2VaR01Wxfs4IIVnxa89F0LOX6RtG+In0S3E
 ed6p8SmGtK40fRnslfBgeceaZirWTkaHvlLlrwxjudgUy9l5UCs7ElB5m8qq8bl9gbfr
 ivME6y00AUEoQ1B3niiAlqPrZ8hnLTF/OmTjZrHsUA0on5yO1pCeCeB5sO6OZmjz4IxW
 7Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858356; x=1786463156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PYYsIR/otj9q+KxnMLTNATYFtlGSABLSX6nUBtcQ8AA=;
 b=WPvMiDxIyNeBi42QZmdciIVnxTAUobQomKjvnvWMjQbdS2cz3j1AJ6twdz3wg1wAdx
 iJLFg6VDNPMpvsOsS1L8NJAHELSlzY9FbLIXcHFIkt69UrfA5EulRG/RZ1T7NC/g4ZUn
 7r37xHWkqiMGmE6lC7BmgtjBrLCYIpJkq24Nrcgq9sUlrqo9ltHu9lORn7R/C/98g4f6
 M3QVMi5WlNehUEwfW4JBnr3k/xY03bV4mHcH6Ig+qIPCsVHipdwEt8hDoI9oeS8wSQZj
 480cKU8+G+PcGq6fK77f3SkDj1jhr0tEbEJl9DeFCc0qgSK6Y4j8WQ9prsikJJpuseGK
 MEXg==
X-Gm-Message-State: AOJu0YxRIPJ5UnKH5OYlSw9R0S8hKDOrszf1H+/owMYapZHSDe+DatIX
 ZCaLQWkBnecUeAGd2jTEcaqWhtarqq5d0aZChiG4C2/ulpnmtKi5tBc+FIKNpqeDriBtUtq8nk1
 E7LDX
X-Gm-Gg: AR+sD10xBVzVrehHhGDla6qqDi1+tzHssklWSrtQeHa0jRetBgKdjJ3x2s3oqBT6r1M
 /N0K/c1mqegZJSQmZs3sBALDVSEu76rwuc1Jq/I92ehVLignI7qQ2f1kc1pnWdUUytiGc02Er4i
 IIFp0vikVqIROoo8hf8717LL35U1mACCKUqHGni89iDOzfyC2ZAReJXsnIV2TBCbhPKjEXU84eY
 1DZU2j7ULDgtRumho4LeV1sSfAtxugw0v+idWIlE1NTU8WXeB0LBtWCA7Ket11K+EKIjUekQc/x
 zP8d1E9rsx/AYRuTC0yFGmMFzLY4IQcviUYRqPrOmkxM3PdbTl9r8PaPkOnu9bb/3xs/tI5IAcR
 TIdqnx57PYH530vmY2iSrijpnGKBVm8ZbWpeMXnNSd5g2xtkPpPue3c3tt3kBl81PgWi6Uou4bI
 RIXMyJnZMibOCKd9kqn2ki2HBk7IVFHST6dtP3+fK88kTVd7zWpaonXSOh+sscdujtygr6Auu3b
 8lYXSQ9Zw9a0mxloBTR4b7ZdBQ=
X-Received: by 2002:a17:902:da81:b0:2ba:6518:a6d4 with SMTP id
 d9443c01a7336-2d05224fa5emr146614995ad.20.1785858356195; 
 Tue, 04 Aug 2026 08:45:56 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:45:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/23] ethdev: isolate legacy flow director
Date: Tue,  4 Aug 2026 08:44:48 -0700
Message-ID: <20260804154549.148691-1-stephen@networkplumber.org>
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

There is more to do here, but with no Intel hardware and no standalone
tests for this code, I have kept to mechanical refactoring.

v3:
- fix some include issues in test
- drop i40e specific flow_director_filter
- cleanup unused stuff in testpmd

v2:
- fix enetfec driver not built on x86
- reword commit messages based on AI review

Stephen Hemminger (23):
  drivers/net: remove unused include in dpaa
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
 doc/guides/rel_notes/release_26_11.rst        |  19 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  54 +----
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
 drivers/net/r8169/r8169_rxtx.c                |  18 +-
 drivers/net/rnp/rnp_rxtx.c                    |   6 +
 drivers/net/sfc/sfc_dp.c                      |   1 +
 drivers/net/txgbe/txgbe_ethdev.h              |   1 +
 examples/l2fwd-macsec/main.c                  |   2 +
 examples/l3fwd-graph/main.c                   |   1 +
 examples/l3fwd/l3fwd.h                        |   2 +
 lib/ethdev/ethdev_driver.h                    |  36 ---
 lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h}  |  58 ++++-
 lib/ethdev/meson.build                        |   2 +-
 lib/ethdev/rte_ethdev.h                       |  13 +-
 lib/ethdev/sff_8472.c                         |   3 +-
 lib/gro/gro_tcp4.c                            |   9 +-
 lib/gro/gro_tcp6.c                            |   9 +-
 lib/gro/gro_vxlan_tcp4.c                      |  10 +-
 lib/gro/gro_vxlan_udp4.c                      |   9 +-
 lib/gro/rte_gro.c                             |   9 +-
 lib/node/udp4_input.c                         |  17 +-
 70 files changed, 311 insertions(+), 844 deletions(-)
 rename lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h} (91%)

-- 
2.53.0

