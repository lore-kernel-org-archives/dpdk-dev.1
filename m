Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725CBC55162
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3991340272;
	Sun,  2 Aug 2026 20:18:41 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 39947400D6
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:39 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso2470784a91.3
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694718;
 x=1786299518; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qZl6xE/TWQ53bJusaR1b0VlPYmHcxSfSirJJsL7yIO8=;
 b=PMPQkcACfIm2fpEaYjhOCY0D7Qoa2nnUDpmPSbw2qyyvaWiDbKHN6sXiz3TEV9kUpc
 mkkCiX6zGxBqewQ9tGb8RgNIoLxpJ9g4G7K2bYLF/1/7FoH5o1MSCegCrSX9yblZfwjk
 koHPNIITRCiwAvAX+yyldbHMNciys4lMmeowOcMsVLujkUaN4+YCN5K+5yE3rxsA1bn1
 6y6DN1S4ykl9HK/3i0PlsSRnBiWRKrtSxQX3kFwZPMlmC0yZoEPnicromYn1pAlO+XHQ
 X2YyCPbbg13jE+suA1KiYuVa3HHBCZzn87V//O9xTdeqDl6lsgouSWCg1sXBdBaKGDHI
 Nu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694718; x=1786299518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qZl6xE/TWQ53bJusaR1b0VlPYmHcxSfSirJJsL7yIO8=;
 b=O43fAUhyqyBWlCq754c9YNGjZCyPqnMLKH87wV9eiU345Oi+kH2Uu8LANvyHWudQo1
 WJY/Lt0yR0IXbyIJx9lp0MPnuJF62+1QobTk0nDUwJSlxuWnoBjqF03x9enBo5bUnelN
 Gq23Nq1I2NJKzq90JtzjVFWz0lusb2xeViFV0X5GrygdsYBwKJUKrOTVtTdsfLi5COTt
 mRXOlrf2Ciz9q/5Qgd6EGqYsyTjspBKXFmKMwGv2+PhoVf0x96ISg+sl2tEgbjhX0rrI
 hAuRpGVs7oyYCR7O2p0N+LoCdRFEgAzbpMD7Y5XKWw8iypWXm/jkuEX2GRN6YaBmY9wp
 JLQA==
X-Gm-Message-State: AOJu0YwFEhwXc69YQ07/yyu9I9XnOdSFnEfjbd6y1LpeowK3lYsm2qsn
 UKWDpY0fQi6MBOsFHhOwyS9I6/Z41hQflcpENbqdsHmg+B/TIHwUuf1dlCl/E/gGv6Ya/rcuQDQ
 nhCTk
X-Gm-Gg: AR+sD10qtIHokgpqHN4SWymuEnCr0/Q6S71iVND4j1mNqyo+Xgvf/8SZ8p9jSWo2S5i
 jB3ZzHjB3Lo8CpwnjDVJQBcKu015uOMym/VxFhZM0DGdrEERrO8vvmfDrZLLu/7XdEa57ez7Yz/
 9mUgB3MUAhjSHsbIRNqVsLAiGIDRDlIP0kMhxHb46L/NZCqbE4DZbHprtCZVd4dStNlWxQoNmho
 mtyAYlojxPzAOUULoTyld1+Sb4a5hiqHnf7SUTybTrHlxZ8DNGUTqGblTid1WfPLc3RsgwZD2ek
 XxRq226/bRuxopk/ZYTjB28lkUXYo9nSLUf1ta/U6yj2d3EqizUHQWcEnxRcc+rOOS2L8wvQwIA
 lQLMJ/UVrHIM1+jRCzvSYtsr6Bq0x7RUi34XehsBqMfakNEtVcs1U1ZDbivT/813cqKtzE42CDo
 /Kjxyqcire0MWc4GwAFV3yXC2ie8avSNvc8FMRh3o6gNKxDnHBlQQobhKxnr3IdnEfL9MKPFnyb
 /0J3S6evBl3RQFJB1EcrRCBFN4=
X-Received: by 2002:a17:90b:562e:b0:369:a359:b181 with SMTP id
 98e67ed59e1d1-38fbc4ae534mr6763768a91.23.1785694717930; 
 Sun, 02 Aug 2026 11:18:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 00/21] ethdev: isolate legacy flow director
Date: Sun,  2 Aug 2026 11:15:05 -0700
Message-ID: <20260802181835.476887-1-stephen@networkplumber.org>
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

The original flow support in DPDK was Intel specific and built around
the flow director feature.  It was superseded by the generic rte_flow
API, and the legacy filter API was deprecated in 17.02 and removed in
20.11.  What survived that removal are the data structures: they were
never deleted, only relocated, and they remain wired into ethdev's
public headers.

The visible cost is include pollution.  Because rte_ethdev.h pulls in
rte_eth_ctrl.h, which pulls in rte_flow.h, every application including
rte_ethdev.h also gets rte_ether.h, rte_ip.h, rte_tcp.h, rte_udp.h and
rte_sctp.h.  A number of drivers and libraries have come to depend on
that, without saying so.

This series breaks that chain.

  01-02  Remove an unused include, and drop the last use of ntohl()
         in ethdev in favour of the rte_byteorder macros.

  03-04  Remove the flow director private APIs from ixgbe and i40e.
         These are experimental, so no deprecation notice is required.

  05     Remove flow director support from testpmd.  The testpmd CLI
         is not a stable interface, but "show port fdir" disappearing
         is user visible, so it is called out in the release notes.

  06-19  Include hygiene.  Each of these adds the network protocol
         headers that a driver, library, test or example was getting
         indirectly.  No functional change; each patch stands alone
         and can be acked by its maintainer without reading the rest
         of the series.

  20     Move the remaining legacy definitions out of rte_eth_ctrl.h
         and ethdev_driver.h into a single lib/ethdev/ethdev_fdir.h,
         included only by the drivers that need it, and drop the
         include from rte_ethdev.h.

  21     Release notes.

ethdev_fdir.h is a transitional home, not a new interface.  It is a
driver SDK header, is not part of the public API, and exists only so
that the drivers still carrying legacy flow director state have
somewhere to get these definitions.  New drivers should not use it.
The intent is to delete it once ixgbe and i40e no longer need it.

This does not touch RTE_ETH_FLOW_* in rte_ethdev.h, which has users
beyond flow director, nor the flow director state still held inside
individual drivers.

Applications that were relying on the indirect includes will need to
add explicit ones; this is a source level change only, with no ABI
impact.

Build tested on x86_64 and aarch64, gcc and clang, with
-Dexamples=all -Dtests=true -Denable_driver_sdk=true.

There is still more to do here but since I don't have Intel
hardware and there is no standalone tests for this stuff
will stick to mechanical refactoring.


Stephen Hemminger (21):
  net/dpaa, net/dpaa2: remove unused include
  ethdev: use byte order instead of ntohl
  net/ixgbe: remove experimental FDIR API
  net/i40e: remove experimental FDIR API
  app/testpmd: remove support for flow director
  net/gve: include IP, UDP and TCP header
  crypto/dpaa_sec: include UDP header
  net/nfp: break implicit dependency on rte_eth_ctrl.h
  net/mana: include used network headers
  gro: include headers directly
  test: include headers directly
  node: get UDP header
  net/rnp: include network headers
  net/r8169: get network headers
  net/ngbe: include network protocol headers
  examples: include network headers
  net/mlx5: include rte_flow as needed
  net/sfc: include rte_flow
  net/intel: include network headers
  ethdev, drivers: isolate flow director
  doc: add release not about rte_ethdev changes

 app/test-eventdev/test_pipeline_common.h      |   1 +
 app/test-pmd/cmdline.c                        |  21 +--
 app/test-pmd/config.c                         | 163 ------------------
 app/test-pmd/testpmd.h                        |   3 -
 app/test/test_bpf.c                           |   3 +
 app/test/test_security_inline_macsec.c        |   2 +
 app/test/test_security_inline_proto.c         |   1 +
 doc/api/doxy-api-index.md                     |   1 -
 doc/guides/rel_notes/release_26_11.rst        |  13 ++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  36 ----
 drivers/crypto/dpaa_sec/dpaa_sec.h            |   2 +
 drivers/net/dpaa/dpaa_ptp.c                   |   1 -
 drivers/net/dpaa2/dpaa2_ptp.c                 |   1 -
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
 66 files changed, 147 insertions(+), 696 deletions(-)
 rename lib/ethdev/{rte_eth_ctrl.h => ethdev_fdir.h} (91%)

-- 
2.53.0

