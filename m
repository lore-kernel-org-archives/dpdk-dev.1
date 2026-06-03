Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486C3CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:45:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 434B8402C4;
	Wed,  3 Jun 2026 20:45:11 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 661DF402BC
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:45:09 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5E40E7A0171;
 Wed,  3 Jun 2026 14:45:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Wed, 03 Jun 2026 14:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780512308; x=
 1780598708; bh=bELBc5Wi56flnX+Rc42hrDA5mNATNCBzqrzWO7SScnI=; b=v
 Dp9b5ZScZY6B7OWoM/HrzmyNSYoNSIA8kYMQG1Dph6wldtJlslYC3eqTzPbalZIk
 S5ijFR6aTYw59YVqWExXFWpxUid15PCe3hn2YEXLpkNDQNGm3lEz/+4wGzMEI+Vn
 hWblxxEq5l9tezp+p2FbctNUm361ricfT3c+XfZ0gC++UmDyv8gLGKFJzOtWB8+Z
 fkbjw2qwOvXnkqR46dgSgPOkZurIYOOvM2bLruyCjUVSxpW88FqQhqNiizKp2F3Q
 F5gKmwZqgmHpBoWSJMS5pwO23Lv7CEF70c4/64BIT6pUR1684rKDF6pi9RKw6T61
 viljlGJBf9Wphw5n2MkjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780512308; x=1780598708; bh=b
 ELBc5Wi56flnX+Rc42hrDA5mNATNCBzqrzWO7SScnI=; b=CgWZLrUCnndvhS+9k
 RJDDfLgOuvIdDGW3X4qOkT3G58to+4Dhyh9VkXDN766V/uxgfTb1eLQ7rnFRcs72
 i98DO+gek8mJZQ10fIOte0sppAkJIdEe4E5KEflILHDH9Uhl5J/Ljnt/RJEtZ5VH
 N96JpxVadagfOIIZ4LyZk+xmyxyvLOKYIL0TbgIj9Z/+6YI8iyKtTC6o1Rp2YjEu
 uBXFIjG3N9Tsv84TgLP53WVL8UTWZJiLs4VXpFqsSwjEgGkBG24GKT8Onxg8gg8k
 m//4SDF7NZDkKd5VfhsKfDySPmRYYdT9YOxen+VhAtxqhHZdTTmMKkEOD/7UafJi
 +HAdQ==
X-ME-Sender: <xms:M3Ygauc72XfmDJc2VZHIp4JL8kUQSE1fkJXl6hugNfWdFThWYvfpUg>
 <xme:M3Ygakj47n8Cwb-yiHWVwuREGBxY4H-tHH8ilsEc0cs8h2DhqqrXAcCDD8yfTstis
 j6mMDhReXT_FUuMUuqlXt9NFVCsFvgzcdSbXVa4IIymDbc-_uLY>
X-ME-Received: <xmr:M3YgaiRwL43kYljsfCQjTR24azS84QuFLrs5vHkGVbhaekmoWhVQu91Qs4g2wOokCRCDxfAMLlPL1wYZG_wdRboR_WMVBEM>
X-ME-Proxy-Cause: dmFkZTG3Cc37AEZv9gWLWp72Aes+17oTj2cMnam3xuZtyjtHoUerOWgaegF+YA5caRZxlN
 +CpkgXX/LN++ffhiXBWkGJbYR1ThI8q93cgy6Xrsdc2JOur3G+hwonLVgkZqZlxQfN01Q0
 HpCgGzFYmnGyurvfbaioIV5f6QOcRha0Y8fP0mOSR//IE6g+GyuDMiZMJK5pvJgOcqQ2v5
 RHmzDuOrWL/PsjNYI3fdzrpjl2tywyPsPRvhLE/JMnVlC+JivaixKJ8G6by84edoJi/2rf
 yBve3yBsXPqOXBzqLSIl3TiGCTdVziTKrhNFOc/ZaL0dbux7VBMxS4tmA78RDPom42yZPi
 rkfU46JZbnLvnyi0WTKBt9WJWy9x3O7rgE/MjuRPnuE7cCkBpoQ2cJUL01nYBtW/s8WUQn
 LY/yJM9sy5r31CHi2Ep3Tinwbd2Dw4CxT6WJvQh1rN8CyGNUOnPZAEQq5rM9z5fynQ/Okd
 FAu9kclNDiSKXxy6Qg+xSMdPZsyNIbbqcgU7IIn69IZO6nEIouPXoSAWbMf/iZSu/uMZWF
 R+KB2ZIWsW3nm72lmNayeTXo8XQWiWMh65EXWM4SRKF+LV9J3H1y4NsGJotzqTdPdekoNV
 qbEuHIQ51o9vSwbKRYw4KAn0eMShJaNYn60Lm5gtvkenjUvGJqh8u9qSc7ug
X-ME-Proxy: <xmx:M3Ygaty2ti2rhKaNCd7T18RxlgpakpqFOeLV2XmEUKf7CZOr_9qPuA>
 <xmx:M3Ygatd5Li7rzsgjH3P7pDfRVXTUlkUpE-aVSgd20trGw02Y545x-A>
 <xmx:M3YgapJTT1fll66jLHiUXeMYw403xUScmD6CK_RnwSRt0sFqRkVOdw>
 <xmx:M3YgauE-OgIHRMxKDcsgw_S4cKnbh8pZgIOfxvM2DGn-WntSC7KKgA>
 <xmx:NHYgap_sVv3cr4MxOEDfJ5FX_9E8jYLJXVobjxtFz5P8JEFKwQFsThQF>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 14:45:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 00/10] selective Rx
Date: Wed,  3 Jun 2026 20:23:23 +0200
Message-ID: <20260603184503.652030-1-thomas@monjalon.net>
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

Note 1: mlx5 support patch is not correctly indented
to make review easier. An indent patch follows to be squashed.

Note 2: DTS patch is an attempt to test the feature on day 1,
it is not mandatory if it is blocking the merge.

v2: rework after Gregory
v3: fix bugs found with AI by Stephen
v4: fix packet type in DTS test
v5: fix mlx5 Rx to handle discarding first segment
v6: fix reindent patch
v7: fix mlx5 CQE error handling + outdated mcqe + redundant assignment


Gregory Etelson (4):
  ethdev: introduce selective Rx
  app/testpmd: support selective Rx
  common/mlx5: add null MR functions
  net/mlx5: support selective Rx

Thomas Monjalon (6):
  app/testpmd: print Rx split capabilities
  net/mlx5: fix Rx split segment counter type
  net/mlx5: reindent previous changes
  common/mlx5: remove callbacks for MR registration
  dts: fix topology capability comparison
  dts: add selective Rx tests

 app/test-pmd/config.c                         |  17 ++
 app/test-pmd/testpmd.c                        |  71 ++++-
 devtools/libabigail.abignore                  |   7 +
 doc/guides/nics/features.rst                  |  14 +
 doc/guides/nics/features/default.ini          |   1 +
 doc/guides/nics/features/mlx5.ini             |   1 +
 doc/guides/nics/mlx5.rst                      |  86 ++++--
 doc/guides/rel_notes/release_26_07.rst        |  11 +
 doc/guides/testpmd_app_ug/run_app.rst         |  20 ++
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  53 ++--
 drivers/common/mlx5/mlx5_common.c             |   6 +-
 drivers/common/mlx5/mlx5_common_mr.c          |  37 ++-
 drivers/common/mlx5/mlx5_common_mr.h          |  29 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |  31 ++-
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
 drivers/net/mlx5/mlx5_rx.c                    | 187 ++++++++-----
 drivers/net/mlx5/mlx5_rx.h                    |   5 +-
 drivers/net/mlx5/mlx5_rxq.c                   |  75 +++--
 drivers/net/mlx5/mlx5_trigger.c               |  64 ++++-
 dts/api/capabilities.py                       |   2 +
 dts/api/testpmd/__init__.py                   |  17 ++
 dts/api/testpmd/types.py                      |   6 +
 dts/framework/testbed_model/capability.py     |  10 +-
 dts/tests/TestSuite_rx_split.py               | 262 ++++++++++++++++++
 lib/ethdev/rte_ethdev.c                       |  24 +-
 lib/ethdev/rte_ethdev.h                       |  14 +-
 35 files changed, 881 insertions(+), 274 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_split.py

-- 
2.54.0

