Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E57CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 203C0402AB;
	Tue,  2 Jun 2026 23:50:28 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 5AF76402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:50:26 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 985651D0006B;
 Tue,  2 Jun 2026 17:50:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Tue, 02 Jun 2026 17:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437025; x=
 1780523425; bh=iJgCfzm+U+IGDt03rL6SyVPVYLQRpVEaVtJapzWZk9c=; b=q
 34KBzmnf7mHn6Wzvo23h+f0mR7E/uNzkW2Tp7iQukCDUZHPbZbb4bCyIKFeoQ81b
 wUdESik/PATEYehQsdOdEsR/MTUHoq0AUzuuZdGhfUXoiTF9J390xejnf4n04FTx
 /jCkj0ws344Gjm8tzuR94J2ahJ8VZptKihhwuC1+cHR+hSXnPlHnKHUTQ8pkyRj2
 LIRRATYzBMvTGuI/ZRA+E8f0ppKhf8aHi2a7q+oh/wvHAjynBWB6yjugp2AY+nEf
 8pZhFl/NxeJoJRj2lEn26rn7DpPNIRR6cfnrUFwHCBSVYN76RU+OJ6/t2s99nnCe
 X4g1wfm/KV9xBwei6A38Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437025; x=1780523425; bh=i
 JgCfzm+U+IGDt03rL6SyVPVYLQRpVEaVtJapzWZk9c=; b=eK8lpMVs59j0zvwoz
 c61e7XDNfYi3aIuOl7njB/yci9sZHd2q4wVr7MBAHc/R2WbnXvWoIdFDbHVA4VoG
 4gQv+6qInynchfw6LkyGQms1hj6P+LC9vLqGiKRqYkgE7y8IgP3Wy8HWE5MA8xIo
 Op7jQQsHVFhB6rky8akJjZDupOwjgvAPVM+0jfdAuD8ng6Ltffx/xYs4vL+51N0a
 3mqy5tr6nLAosOlVOmb4s22g+RVq7q4hOcBhNTwXU1TH+aukQWYmuJUX0V5H3v57
 D/hsRW3WMZYwceZLVtTKJnM2ngKBmUPWIXYKDK/d9O1BsWZGaq8Wtp3ywCEuUN0T
 c/sFg==
X-ME-Sender: <xms:IVAfaianqUs7EBUu2WckI2hm8FULVXpqeOWxPApfgZ8JZa5R-0D7jQ>
 <xme:IVAfahs8G3BnM9RNexDYD9_bVuxA5dsneu9P6tW6Drb_NWydcYTFAa4MKJrNoX5oG
 wD_UR7uejVI1d4SUFs_3rvPo_iZ44Jbf-h3D--Bwhu4KU8euoKS>
X-ME-Received: <xmr:IVAfavviexWE1S6y9c-c2Zb-GQV24zu48H8KsqgmclxxGkZQO_jz2J7T3uZOBqVWxKR4tHh6zQNyacw9XLUSPfy-8Bezu9k>
X-ME-Proxy-Cause: dmFkZTGLViGudKsDyOQu7nlm3XZoPyesT9J8ZxOjQv8yq/MS1wAtj7j/V43Ic8lLIHpkM6
 u24csRGGOkjs/xNroLPu8HoNMq3e+8KP1NdqdSASIoO1axjHcjiZOnVqcJ07F1Hjk3y36h
 cOeSppG+igu2yT5H7V4wx+FFyjv+hJThrxxIWnTfg+f53qnusY+JeNkBxIBphEIWRawUW8
 ZOckHyfoXvSira7ocBEEgW0JlZI/VwLw1KxI16ukL54AOtHUKBt6rrwo13xrAhPxd4duBh
 nuMJPl5ZZJ3y7Z1atoozu4BpCMZ49HNleOgNEFAuqdsKfKkox402xD1lavnWn5WRw4/ffT
 0H+hBpMkLVhQchlup2Nh1PQ5x4sVVVB5JMg270a1dd7t4ND25VYKLPcIbX7/uOc3t83F5M
 l+SI1QirY3ICcGEIin3209duebQ5xjo7ZHSOBz6vrhAh0C5HsXbDf8xzmJv0c1Q3jf+sy5
 rmsFDLYbLl8sbY4aGp5nYLepwLMYMv7m4hlIpHVTwAbdWJCYVBTeO5Dk764Dl3Zlmb7ASZ
 F94j8uAkhYuVn5iNB6Yb+L+gCpDGdkEpR+DzeOsUlPese3KF/5THjBljUD1Nn2dsqdTV9i
 3UQm8GM+qemH9zQIxgeAHvgshOm2aSdMH+QkQQwGiuDYIbDwH43Ccz9jJFig
X-ME-Proxy: <xmx:IVAfamfGpDW6bpco0G05xHw3bEmHYwyLl6d4b97iTrtF60ITQO8k2A>
 <xmx:IVAfagb6pU5Iquh5hoyfrFdkDlKZuW5vT89DDHnHlkk5P-zMpNK5Xw>
 <xmx:IVAfapUhr3TSCgURa8dolzCuky3WUqFil6ameN30SikeLrM__rMBmg>
 <xmx:IVAfaiio3xs2aD4l49LWOFR5DyIDCr0KGuTgwtNGb42K7Ha8gqV95w>
 <xmx:IVAfapbm3KkW1nY2r8aDPk58CRMTGFY_XkcYUTSBoLyX3bFRaT7Mdkjw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 00/10] selective Rx
Date: Tue,  2 Jun 2026 23:49:12 +0200
Message-ID: <20260602215022.3698662-1-thomas@monjalon.net>
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
 drivers/net/mlx5/mlx5_rx.c                    | 186 ++++++++-----
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
 35 files changed, 880 insertions(+), 274 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_split.py

-- 
2.54.0

