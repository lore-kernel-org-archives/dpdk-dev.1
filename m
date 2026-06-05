Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5DECD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 917BA402C3;
	Sat,  6 Jun 2026 01:35:07 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 0CBEF4028F
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:35:06 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 90050EC01AE;
 Fri,  5 Jun 2026 19:35:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 19:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702505; x=
 1780788905; bh=SCb2jltJz1xzzeDED3PMZqFIO1ZcbcbJ4Vkqze8ZUnY=; b=t
 4JRhT+U9pSNBE1VBB4JlSvuGgSBpTRX+YEXFOU7MMb7VbscrYeOTAnasfQ9c9zQ2
 uMIPmapnuyGKv3Kh8yyloqdLB9A50FzU6X56DptrwjNhyMoB3Y8vvL1ldibFHxOY
 +k6qb+jB2Lu8kmRTj/22WaUqn9tqgxxA0gVt/Lw1wsxXeIPSX9+G16uDCwkYUBIL
 x2U/oKeOsvWiZKa1CbwJ7OWMsLqSNeAnJRIh4bBMmrfFXbU1ncDYRu77RwkbbYyy
 PsRe7jJyMwMW0LxZRLl5AR0+IH5waEBzIzRDcEQrSHoY67fW3ay/RmUxwq5rKal1
 khFZmXYt65fj1vsArXRQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702505; x=1780788905; bh=S
 Cb2jltJz1xzzeDED3PMZqFIO1ZcbcbJ4Vkqze8ZUnY=; b=Sq0XViARQPpDGK2K6
 7fr1hQPmrnQ40ALLQlNZEzzjjzCTMWh1+wpuPtaseApr2JvZA6ZY9cDrjeeMdxC6
 r8peUhFAshIcEd0P7sCPI+Kjyjf45uvSPfNRDWvorFZcFDMoZ1s4MVaa99Iu9Z+a
 +kvBwW5plulvDQIythOHZ3qbMFPH5pzXFYkIoJYXFh7HS7X0GDh/9kzr6sG+pwiC
 xQYVmqVjD/04P1eEHdqEenZEcnli57pgQQnlRAvjDQ8kJTBhCYOTico1wUZsGU02
 UQCu6n+mWdJNVA/9SeQP9B0y8RWJa3DcF+i7mZFoGZf8jN+ISAAhR7iLzUPjS/Vw
 E9GfQ==
X-ME-Sender: <xms:KV0jam9lGUK8D-qLtIf4l8Fuky6cegUnaz_y5-JzC6pvGuXCiwPurw>
 <xme:KV0jajDX8HtlO9wkSNwnfwcjGHNTusbIm5-pCMd4e0WeQYnvAtu1ODTp8g89BtxI-
 lp5WVDgaS6XnyCV4kdPmUunmmT3_eo8RilSQKLx2p3gW0fPv7k4BLc>
X-ME-Received: <xmr:KV0jauzIHzbaU-AlS6feUdNnDmkxjIt0KuXGV49RV9f6XrpcWwOa4KQJufKlED0VwCLNnPJogamgGNH6t45STFKElWRW9xg>
X-ME-Proxy-Cause: dmFkZTF8TioU96Tq8QejfEYWkQIUsOFAOK0FW7DC0LiMj/WHoJBthbNIYQLZhbAbsRQFO2
 lhUgktCKGre+6Hnm7PQXDfi1me7GJ21rd3W+s+oTHe2orhprMWu2vu6WchUqxiyReLNIP/
 h3ejxiJXKpjK7apdIpmRIiSOfY1fUBhqsQ0e82bQFHzyD22eDCAo38hZuDD/ypb4Oztk6q
 OeXfKEwFSxXbs9e3Sev8qr5ihJ1wJqhq/BCqlbt+MotFGfBijxQCyHb3Pfm3eEogn9mTf7
 rZwf/OFQ2wp3HTDchj9Os4Lo4khXvPNfnxTbVv7CQBS9l+7W8MnadGcXfmGvlq8RLz+3ZY
 rMTdb1+NNt5LaGyh+GjG249XTrUxpdgv05ZbxY0j6OAV/4DPbNhu0XuEQay8dgzqclmNw/
 RjdhnwA4QYORhJ8ER7UxyJAIS9tVRNdXJEvIdsk2e7DTm6k3KvcJ2xnQPg8Bj49GSRGfJJ
 icJDu7GsmTZUizWg0KSLOdMyYla4g8pc/90LGF01vfPLDyn+b4e+8uMrk0BK5b/QMOFmqM
 kzjLnnrkqS+Vz4/UzNoi59wChDrDqLOFn8TBmhz3Mfm8rFNNA7imTWfx5T6+QS6T6FjTEd
 vZoRvXIho7Z25x3NQIrlknUFSnbQ51sqQwPX/bA2/Dvt0/mNOD2RH/MQvyXw
X-ME-Proxy: <xmx:KV0jagQ0MFTYAmOsPYZ4DChNziFExhfSelH1-ZlP9KL_bWyGO7WnWw>
 <xmx:KV0jat-zOscY_CITuBr94iBa6WXC6nH3tdZ-Vk9HRuyzeZPfQ-N66g>
 <xmx:KV0javo4B-3xXODhyo4qRChPfjDD2wEbDDcDj6PcCqHzp0LzxgKyqg>
 <xmx:KV0jailcgqV6zVUhlwygQEw0K-Qk1unta7tHharc5BG0Hd8iEQsyHg>
 <xmx:KV0jamccphSeihmHqti-CnkXDXp2S0rJnoHh0r8Lpf89nMD0_B1bsKgy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 00/10] selective Rx
Date: Sat,  6 Jun 2026 01:33:40 +0200
Message-ID: <20260605233456.3017423-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260202160903.254621-1-getelson@nvidia.com>
References: <20260202160903.254621-1-getelson@nvidia.com>
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

This is a new feature in ethdev with tests and mlx5 implementation.
Selective Rx allows to receive partial data,
saving some hardware bandwidth.

v2: rework after Gregory
v3: fix bugs found with AI by Stephen
v4: fix packet type in DTS test
v5: fix mlx5 Rx to handle discarding first segment
v6: fix reindent patch
v7: fix mlx5 CQE error handling + outdated mcqe + redundant assignment
v8: use --mbuf-size 0 in testpmd instead of changing --rxoffs behaviour
v9: fix testpmd and DTS

Gregory Etelson (4):
  ethdev: introduce selective Rx
  app/testpmd: support selective Rx
  common/mlx5: add null MR functions
  net/mlx5: support selective Rx

Thomas Monjalon (6):
  app/testpmd: print Rx split capabilities
  net/mlx5: fix Rx split segment counter type
  common/mlx5: remove callbacks for MR registration
  dts: fix topology capability comparison
  dts: use specific types for Rx/Tx offloads
  dts: add selective Rx tests

 app/test-pmd/cmdline.c                        |   2 +-
 app/test-pmd/config.c                         |  17 ++
 app/test-pmd/parameters.c                     |   5 +-
 app/test-pmd/testpmd.c                        |  48 +--
 app/test-pmd/testpmd.h                        |  16 +
 devtools/libabigail.abignore                  |   7 +
 doc/guides/nics/features.rst                  |  14 +
 doc/guides/nics/features/default.ini          |   1 +
 doc/guides/nics/features/mlx5.ini             |   1 +
 doc/guides/nics/mlx5.rst                      |  86 ++++--
 doc/guides/rel_notes/release_26_07.rst        |  11 +
 doc/guides/testpmd_app_ug/run_app.rst         |  16 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |   3 +-
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  53 ++--
 drivers/common/mlx5/mlx5_common.c             |   6 +-
 drivers/common/mlx5/mlx5_common_mr.c          |  37 +--
 drivers/common/mlx5/mlx5_common_mr.h          |  29 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |  31 +-
 drivers/compress/mlx5/mlx5_compress.c         |   4 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |   2 -
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   6 +-
 drivers/net/mlx5/mlx5.c                       |   7 +
 drivers/net/mlx5/mlx5.h                       |   4 +-
 drivers/net/mlx5/mlx5_ethdev.c                |  25 ++
 drivers/net/mlx5/mlx5_flow_aso.c              |  21 +-
 drivers/net/mlx5/mlx5_flow_hw.c               |  11 +-
 drivers/net/mlx5/mlx5_flow_quota.c            |   6 +-
 drivers/net/mlx5/mlx5_hws_cnt.c               |  19 +-
 drivers/net/mlx5/mlx5_rx.c                    | 187 +++++++-----
 drivers/net/mlx5/mlx5_rx.h                    |   5 +-
 drivers/net/mlx5/mlx5_rxq.c                   |  95 ++++--
 drivers/net/mlx5/mlx5_trigger.c               |  64 +++-
 dts/api/capabilities.py                       |   2 +
 dts/api/testpmd/__init__.py                   |  17 ++
 dts/api/testpmd/config.py                     |  11 +-
 dts/api/testpmd/types.py                      |   6 +
 dts/framework/params/__init__.py              |  14 +
 dts/framework/params/types.py                 |   5 +-
 dts/framework/testbed_model/capability.py     |  10 +-
 dts/tests/TestSuite_rx_split.py               | 277 ++++++++++++++++++
 lib/ethdev/rte_ethdev.c                       |  24 +-
 lib/ethdev/rte_ethdev.h                       |  17 +-
 42 files changed, 921 insertions(+), 301 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_split.py

-- 
2.54.0

