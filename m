Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD82CD342F
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 20:36:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 489164026E;
	Fri,  8 May 2026 22:36:12 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 3D2DE40150
 for <dev@dpdk.org>; Fri,  8 May 2026 22:36:11 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2ecf9e398f4so6326005eec.1
 for <dev@dpdk.org>; Fri, 08 May 2026 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778272570;
 x=1778877370; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JAkYxAvYnXSf807TH1wEzV+d1XVbbyga01wPbItfDAk=;
 b=OFpe2DJoeoYQHf8CB+dd/xxdWUaypjRmVSnolWyb+/A6k47Dwr20UV3otNL76K5+yJ
 gLpGiQrufgMHTF5R35sj5dkeUOy1pljHq6A+bYg88Pg/wdOJbEalBa2iPjs+T0xaGZox
 lgC5eoFsKi1v77NIzEdPHRAHFONspx1HrFnQTMiHWgK3M+P7E91AJXW26m3mKDjnp/mV
 tZpqGDjqC35iFZBaypb6Dz8lqT+1pICBuC1lezanX/zYUZPtlGsZFhPSShmadfLPeb2H
 No1Z4QC2CU/i5mvvn1PDoGPe0mI7dMdmwt3TQfVviqOIvHhr8CoQykEVw4jHEur2cpn9
 fnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272570; x=1778877370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAkYxAvYnXSf807TH1wEzV+d1XVbbyga01wPbItfDAk=;
 b=n0506cNuxv8AQzv1M8nfc8a+o0SEmmOr9vMv+m7Qy8RwrO7ZAWpCLobhRNKl19DS2D
 CewxIxl+cGiHQZVRvykSpMtn09a0fGQooRd7aqw07OtHEX0mICcKVW9HAlr/Ns+dBN/S
 EUQj1sHV20VdhetRqzgZbH8IsVljXonoYndHrwoPUodv+9Rt+V/8+AhNI+ww3QSD3o7Q
 l3e27sFoQLy73MWnGOMeB2jDdGQEk/3U+FIuMWl9bGNZiqSKKSzYIoMsIf2ZyX7uXt8T
 +ZxWOhReFlb980XJB81sgmGm2TMQoWL8+wRpnehn8UWPg9ti9O7eoyTuwxicpaNdjADj
 Is0A==
X-Gm-Message-State: AOJu0Yx3bTDNfDkPDihAvAJgfBjwPiiKAGbi3Whv98mpC3gIyfI4rjSM
 qwcJfOZVwyJxEjJW4yl5eiVpAwc8+8/v9oR4+B6FAmFAQCAw9ui/z1XCArcrIdbS+TYhZObDNpo
 /ffv7
X-Gm-Gg: Acq92OHJ3+sLNXWxi6qK9IlgZyBhNKpaTDbIKHiAfJSX/S0Kz7DnclxEizGnYu7dSKA
 3+xcJJTtjYEpeQgb1qjcigAOb1K3AIdz0qUt3lI3VGm2YtykiyZ2ZeMtX0vn74lKZoCir+gy8kL
 PQiyNGSwH2QJ0uSKfde/mlo104ca++SrKX1UpOnuTvSwxx1WzfFulKk+zbWQ2v3vfrOna7zfQzv
 +qRcBaiNEp5O6e5lyr5LA64FF9zMqewJMTiyIOnTGDN8mDm+n9KAUOT8/RTkUOG/dKNtzRMgnJ0
 88OFdYoZzSn4uDfSoz7J7drKCxJULGEsCBmFgqNX2+rqaZj90Cdivol8raIHCrazm2OMvIVIicd
 48NZrgKwnaf3DnH1AxI8JfMvKVvwf2ICt6XptjDsBUqZWFUtWTjkRGvDRaf5V0O82FOPKOTmcRq
 ZM8x3HacudlO07tH4ky5eSp+4ApjftNDcE
X-Received: by 2002:a05:7301:3d1a:b0:2d4:532e:7e45 with SMTP id
 5a478bee46e88-2f54cf5dd7fmr6490006eec.23.1778272569931; 
 Fri, 08 May 2026 13:36:09 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafcdsm4715146eec.6.2026.05.08.13.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 13:36:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/20] pktmbuf free bulk cleanups
Date: Fri,  8 May 2026 13:33:21 -0700
Message-ID: <20260508203607.1003036-1-stephen@networkplumber.org>
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

Looking at one driver noticed that rte_pktmbuf_free_bulk
was not being used. That motivated me to make a coccinelle
script to do a tree wide cleanup.

Then noticed that callers were having to check for NULL
before calling rte_pktmbuf_free_bulk, so changed it to
handle NULL array similar to free() and rte_free().

Do another tree wide pass to fix that and catch some
other unnecessary null checks in code.

Stephen Hemminger (20):
  devtools/cocci: add transform for rte_pktmbuf_free_bulk
  eventdev: use rte_pktmbuf_free_bulk
  gso: use rte_pktmbuf_free_bulk
  ip_frag: use rte_pktmbuf_free_bulk
  pipeline: use rte_pktmbuf_free_bulk
  port: use rte_pktmbuf_free_bulk
  net/af_xdp: use rte_pktmbuf_free_bulk
  net/cnxk: use rte_pktmbuf_free_bulk
  net/pfe: use rte_pktmbuf_free_bulk
  net/virtio: use rte_pktmbuf_free_bulk
  net/zxdh: use rte_pktmbuf_free_bulk
  app/compress-perf: use rte_pktmbuf_free_bulk
  mbuf: allow NULL array in rte_pktmbuf_free_bulk
  net/zxdh: remove unnecessary null check
  net/ice: remove unnecessary null check
  net/bnxt: remove unnecessary null check
  test: use rte_pktmbuf_free_bulk
  app/test-dma-perf: remove unnecessary null check
  app/test-compress-perf: remove unnecessary null check
  examples: use rte_pktmbuf_free_bulk

 .../comp_perf_test_common.c                   |  8 +--
 app/test-compress-perf/main.c                 |  6 +-
 app/test-dma-perf/benchmark.c                 |  6 +-
 app/test/sample_packet_forward.c              |  5 +-
 app/test/test_distributor.c                   |  4 +-
 app/test/test_dmadev.c                        |  6 +-
 app/test/test_ipfrag.c                        |  4 +-
 app/test/test_link_bonding.c                  | 13 ++---
 app/test/test_pmd_perf.c                      |  3 +-
 app/test/test_pmd_tap.c                       |  3 +-
 app/test/test_reorder.c                       | 12 ++--
 app/test/test_table_ports.c                   | 12 ++--
 app/test/test_table_tables.c                  | 21 +++----
 devtools/cocci/free_bulk.cocci                | 57 +++++++++++++++++++
 devtools/cocci/nullfree.cocci                 |  5 +-
 doc/guides/rel_notes/release_26_07.rst        |  5 ++
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  3 +-
 drivers/net/bnxt/tf_core/v3/tfo.c             |  6 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |  6 +-
 drivers/net/cnxk/cnxk_ethdev.c                |  5 +-
 drivers/net/intel/ice/ice_dcf_sched.c         |  6 +-
 drivers/net/pfe/pfe_ethdev.c                  |  4 +-
 drivers/net/virtio/virtio_rxtx.c              | 20 +++----
 drivers/net/zxdh/zxdh_np.c                    |  3 +-
 drivers/net/zxdh/zxdh_queue.c                 |  7 +--
 drivers/net/zxdh/zxdh_rxtx.c                  |  3 +-
 examples/bbdev_app/main.c                     |  4 +-
 examples/l2fwd-crypto/main.c                  |  4 +-
 .../client_server_mp/mp_client/client.c       |  7 +--
 .../client_server_mp/mp_server/main.c         |  5 +-
 examples/ntb/ntb_fwd.c                        | 12 ++--
 examples/packet_ordering/main.c               |  5 +-
 examples/server_node_efd/efd_node/node.c      |  7 +--
 examples/server_node_efd/efd_server/main.c    |  5 +-
 examples/vhost/main.c                         |  3 +-
 lib/eventdev/rte_event_eth_tx_adapter.c       |  4 +-
 lib/gso/gso_common.c                          |  5 +-
 lib/ip_frag/rte_ipv6_fragmentation.c          |  4 +-
 lib/mbuf/rte_mbuf.c                           |  3 +
 lib/mbuf/rte_mbuf.h                           |  1 +
 lib/pipeline/rte_pipeline.c                   |  4 +-
 lib/port/rte_port_fd.c                        |  6 +-
 lib/port/rte_swx_port_fd.c                    |  8 +--
 lib/port/rte_swx_port_source_sink.c           |  6 +-
 44 files changed, 152 insertions(+), 174 deletions(-)
 create mode 100644 devtools/cocci/free_bulk.cocci

-- 
2.53.0

