Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53143CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55D2A4021F;
	Thu, 28 May 2026 14:48:06 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 5051F4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 14:48:05 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id B01D9EC00EB;
 Thu, 28 May 2026 08:48:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 28 May 2026 08:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972484; x=
 1780058884; bh=FZo8yx9uaWHo8OOwdD0nrmuTUoGfOyzvyLsnGju81iI=; b=d
 epAsZQgztNGXcuqRH4LJWbx4S/qFwzSnN7NnQrIo2YsKq4UmJNrW9VO7VGGZjE2g
 umPhq/KczNw4lXP/oOhaig4vCZLrbBIrf42mDLXJEb6ZEYkbMWBo+TDOgnDywIuw
 X/T6tKOShZLOZGPLYTXBuDD5P4KS8ef9Leqp47kvgSdM/hvBFJAd5rFCJVKA4wu1
 INEYt5BbdSUnfYBA35wbmTdAfjNYrhiqTjCmAxK/WBt71ddtmt8Xqdmc/ULMpxG5
 89P99gZX3dLaOf20nQu/idJ0CtlcNXhya9BujgnP3k73rpbY68XYkETzGFQPYdQT
 55PBTWw3WaU7Tfx9KR19A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972484; x=1780058884; bh=F
 Zo8yx9uaWHo8OOwdD0nrmuTUoGfOyzvyLsnGju81iI=; b=WEO4be+d+o0TyKdkw
 FYbBqG/v1y/zz4UReMXTe/6lA/G5GLWxkSCPzWBn1KJltQhSRPvVuPRZkTMinPLa
 fNesAigiA0YYep5C3k1koXItxd11lQGd9nx9+UPukkiHNPwul2uim0KIfro6NC1L
 /RVYjm49kilQ651J5x4kg2CO7SYcthXVF8o/4F1WxqKvmOHRn06sHkReMKltqmoL
 HgPrIKvfdJW5pM+nKqoOrjr9DAdPjwC9iHMlV+EDLg7G7X3FAG35CttITSj7T4ay
 UPrzMq2+k3HzwszjNInh0Kr2kkooBEJUCYPbFBlm/EvY+kDYDbDF/RyzMQWcWOqb
 wF8Dw==
X-ME-Sender: <xms:hDkYaq25UnODM9T0M2lfu4j5jXKubqW5qEkxVjyegNKiFVXWIdT9sA>
 <xme:hDkYapZpMWAtxv86TgsLx2tlpRbj9NzULPLeYm9bxewWwv7TRUEbcFComf_PnvEjw
 wjzO9eERp3f3BxVVhw8_88ECLOMqktYNdKf6YXq-AmcYfiPEBQ>
X-ME-Received: <xmr:hDkYalrCLdOlHd5WS_b6-drcUeWSAos7PqcX8ZoIiODquet34vjks9Qo14EOxLjTBqh9TSRxp1zPQikbHFYOk8RQJ-27RS8>
X-ME-Proxy-Cause: dmFkZTEFn7AQHI48n9AODvJpJqUxdk72sZf0QLbOirQK2oyoi+UcGmNWDkA8MQxq/UNVpS
 kxC5Io4+kU3Fbdr2iWwXxCfnXp+UEUJi+bqAIR0An7WYiX1o8NsYAUQ+pI7oK7Eon+l6Qc
 5smSvBkE8YwlgQX4htbges5IHO+VQGpWCeK47LL9uKaWZSkQ5SQ07Hb2BFZLFyK7uXMXjg
 a1gXgJJv4QvNCyHA6ug7ni4QQm0Rb3dKyMtJ29hsub5yqp48T7fXlGEH0ytXZYMruyvqZu
 mw8vrT/WMNUWiTcH4tjJGnAZ2M5JgoyGW1r2WTRcytlCKxhVBJsOOZMhAqWbv+aQjxKVSO
 UQd1+7mh4xRmDugKYaPM1YA1rh/9I5eOUgXlj7L0eTH6IyulP0AKdsRgTZoFU2DpfcC/F5
 tXevixZ72OOhb/XI1UCPaMfZiiYbdxj6SE17DX5edLtSm+EFzFxTX7+FQ40VGutmS5fT6T
 yIHJcuMvEpD9vTt6H2L9mQm2KAiBAMGR+jXjSplvunD/cZGhodvKGdeIGObI+Fp8hap/16
 7vq8fRRFQQ8+XL4Icd9g40G2Etxeo0XZ/g48i9kzytWI9siMbxyRbJziiEAqmFyZDZVlMN
 wVs53vkJT1cK3ZNmGMLAkE4C/2RfcMAy6oC1rz37wdID5nddUdPhuIHhwhSw
X-ME-Proxy: <xmx:hDkYato7pBaMh5mFjAr-Us6aDS8slJ3ksrfHTC_DZe7nbgOX2IF-3w>
 <xmx:hDkYav1N9J69-TSYdyIMH_n56b5CMF_oudpkMB776pJyrRsdtgfdAA>
 <xmx:hDkYasDLLJ9PTQP6v-DXdvHPfvNaoutQn5-wu84ns6dyBQc2UNE5HQ>
 <xmx:hDkYane-50MgiOAZLAvqKdIg7aToJkOl1y5Xvqjomw6TFnEats4YzQ>
 <xmx:hDkYahUs4UzUjvr938jZypLcQ-rkpA2V_lTa-lQ97A_AZ-AKjp6Q0yJ2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/10] selective Rx
Date: Thu, 28 May 2026 14:46:27 +0200
Message-ID: <20260528124758.1984528-1-thomas@monjalon.net>
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
 drivers/net/mlx5/mlx5_rx.c                    | 102 ++++---
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
 35 files changed, 831 insertions(+), 239 deletions(-)
 create mode 100644 dts/tests/TestSuite_rx_split.py

-- 
2.54.0

