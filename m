Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1E1CD3447
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:04:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DE2E4026D;
	Sun, 10 May 2026 00:04:15 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 026FB40269
 for <dev@dpdk.org>; Sun, 10 May 2026 00:04:14 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 2E8A57A0070;
 Sat,  9 May 2026 18:04:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Sat, 09 May 2026 18:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364253; x=
 1778450653; bh=7xzEpD/lvRPhw7DnRCEXzPwFMz83j9ayTQ/6wjSvb5s=; b=d
 I9TammIEH/ArLBC8Y89F+Y+AfJEQNvHfR79McgAxg59WG74u0gGC9oz9AuSGG6cU
 +ltlD2wORXJtVr73TiNB1RvblXaHjEm4wesvacvtj7mnTGB67fyOYYsUCCTvoNRe
 0ix7qkas9j2sY2NJVpCHz6o9xxTBgAs+Ipix+JJONMFepZcxVnaUsB5wmf+nPWw3
 7SVP1GIM3BTDBwC1rvVEH80uAqZU9ro5xDXznNgUHz7VFmeoNSVd7w0QngxxRmAw
 uooc3qMjmcX27WLAaT1wbBYEcJtrhek9vVXqW5WgaXLNtjEWTaW9dSpsZEyh0Yi6
 aEmB4miE7ODkI+gUaW2VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364253; x=1778450653; bh=7
 xzEpD/lvRPhw7DnRCEXzPwFMz83j9ayTQ/6wjSvb5s=; b=nX5ZCSiCjinrK5Y7n
 s9Edq9ayIWEC8fDDNblaFtGwGwZsbnNYLqGb9QvZPwUPtmsClCasviIPTtk0vrdB
 KjYJZ+D96KvQfqWfpk42YeVJ3en0i4Ipwq1mQCnCEzsZcr3Vtb9HVr9gB5mgRWZv
 CJmXjcYKE5FUMsLXKNOEKCVZ3ceCAIDe3D/IhuD2fpcUloRX7GPvPedNf1q/qb8N
 pU/ro1VbM2qaMLxGcy8HAFjSb7JBG2w7VLdgzeDud76lLnTzcYaDAo+NOU0JsudO
 aDejq3fFrnutzO4jeLYX7vJ9rAPbljFCIPVqyY/40t8RcLCvZLwYIfVhEm6AAFBe
 PfCWA==
X-ME-Sender: <xms:Xa__aTfp_XOLfQ9CavHzoGGW4bCViORoglGKlLrvvmYYQSmhy-Tdsg>
 <xme:Xa__aVijAvXLD-U0cfPEPYx81FgtpkoCIHrQo90ARMTnRDLG59Veq7NZD9E7NV-TF
 SZTEY7_ZI97zZ68BaCiJCLo9BE_nkFJS0kSX7Qx5m0xCGtic7PWWg>
X-ME-Received: <xmr:Xa__afSl_6TCRPUydlLHvmpgXtrkYkWs3ZnmkvsGcZCsvsewodVPBin6uCjdKEFgHNmf3CG2F-M5wIbpNLUC5t_xtAzkNx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:Xa__aWyAdl3PwDla0hb3-XhH1aNCar2Dea7ofpjnK_zuWzCh1U4BBw>
 <xmx:Xa__aSesroLPzl2EeFwieSA5tTNotGi1-DHQvePDGpdr1R7ntMBiFQ>
 <xmx:Xa__aaKf2EBBXT9TQbR1dzF9U9nJAn6dz8wsAYhy6kLqdiJJ8cWwXw>
 <xmx:Xa__abEBxsqb144xp1kob4t-6o8oknifcCKmHhxuwlhd0tRMJhotPQ>
 <xmx:Xa__aW_I53f5TyruVc4-8y-qVJ4XkXH1EErXLNp0Q8jbLDsseAqOBC7i>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/10] selective Rx
Date: Sat,  9 May 2026 23:56:51 +0200
Message-ID: <20260509220356.3679114-1-thomas@monjalon.net>
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
 app/test-pmd/testpmd.c                        |  69 ++++-
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
 drivers/net/mlx5/mlx5_rx.c                    | 162 ++++++-----
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
 35 files changed, 857 insertions(+), 271 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_split.py

-- 
2.54.0

