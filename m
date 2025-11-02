Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D10CCFA02
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 15:57:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3C4A4042E;
	Sun,  2 Nov 2025 16:56:54 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0631340395;
 Sun,  2 Nov 2025 16:56:53 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 78547EC02E9;
 Sun,  2 Nov 2025 10:56:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sun, 02 Nov 2025 10:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1762099012; x=
 1762185412; bh=ZoGlj7EEiF6ctPfahWJ/LkEh9JjWhlwc+x1piuWi8CI=; b=i
 BPjAbQFAfJWmjI8mlyIWHE4Gj97fzPUP7cfrl0WiIE7xHFJkK0duVRJBOdH+DqTg
 Xl71tLHMF8Aw/o/e6hobDiPy92ftmL+r0DJ8Wl7xeBjmTrZ+c45Y5tDnxhYmUrbf
 by4cBKD2Z5EomKbvTzNBETtgoXbA/CRz0cnlsjZhT+KVsYTocEIZFPaxw1kJnv4e
 lQX+4Z0EKRlT159vwB0LfjfC8RYbXWCOHL9P0eQlbHLb6wWYMHynIyryf1aw+UVK
 qLakXSvoSeWrbchN6LzH8tOOdEXuj9SpuQWBs/vj00Vuh185W+e7/+pRWknUeCKb
 2rcwQymvLg4yZDuwKyvVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762099012; x=1762185412; bh=Z
 oGlj7EEiF6ctPfahWJ/LkEh9JjWhlwc+x1piuWi8CI=; b=syTbXDrp0kDbGF2Oe
 ASEhhVHzJ9jdecGX4sY4kAKsWfdNHvkca5adn+I9RyuP6e+d6LxdftgWF2Iqjl3x
 O0Pkk4Jt6kO8Bv6Tlgr1rjsd0RnRzspK5chHwYdZfORvWGWiy/N64vvEPtE5+6pA
 a7DjN2RPGG3pIhnozrj0yIxS74LnzL+yUZ/Iu15GDfNvfsvv1SHqJ6mGVpW6TKnr
 vBIaLevFlvJvbp81H1GjDx6aO20/0wCENNBmIIaSAv+h+jGwt2qOnqSJo+8lnxG1
 wCuzsZYRd7hPz7vYR3ha3pI/vx3Z8iEFjVGfeF0AVdJzI8p5eUClDR6nOzCDnfTn
 udmfQ==
X-ME-Sender: <xms:RH8HafbwM5SwNx6tmg-3ydreuNFQGz54bMhZ2_GnaIZLx2NZ8NTUuw>
 <xme:RH8HaZW7ksrDP_9I8gPKj3l9wecemWHo6dHH-jKze2V2NwSvpX4sRbde5Cgm1Fqnb
 HlHn8_dbvoDNNf4CsNP98LTFfgUAtdg875yFhQty8bolEDb7pCmxQ>
X-ME-Received: <xmr:RH8HaQ8zZkYmyO8SHnrjOnWl47JBNsGlqrbfn2sQHI6cQtzOr3eT3zlcFMAGNBMbGCmG1hBnSD7U0CgEUa0rDWhN6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepmhgrthgrnhesnhhv
 ihguihgrrdgtohhmpdhrtghpthhtoheprhiiihgurghnvgesnhhvihguihgrrdgtohhmpd
 hrtghpthhtohepthgrlhhshhhnsehnvhhiughirgdrtghomhdprhgtphhtthhopehshhhi
 rhhikhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghgrkhhhihhlsehmrghrvhgvlh
 hlrdgtohhm
X-ME-Proxy: <xmx:RH8Haa87Bd47DUoExw_K4L_gNH4ZTCWMjwoa4uCneiwfrL360sJS7g>
 <xmx:RH8HaYR_ce6htYa9df_O0js243d-_xeMeaL2Ndozb4DTScz9re5wHg>
 <xmx:RH8HaWdRQxPVV4lpFvgeH1DgjyvOWx_JjHcJhdEX78wH5RfrZK4OJQ>
 <xmx:RH8HaUAHdVMk-smfo-lvqlhwag7s85wMXfltYJ42pcSwBHyQFSD1bw>
 <xmx:RH8HaT2LY_OiTY4CVe0KHgyDf9LQW6mJeW27BZgIg2C4rQgyLneENngE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 10:56:50 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Matan Azrad <matan@nvidia.com>,
 Raja Zidane <rzidane@nvidia.com>, Tal Shnaiderman <talshn@nvidia.com>,
 Shiri Kuzin <shirik@nvidia.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH 2/5] crypto/mlx5: remove unused constants
Date: Sun,  2 Nov 2025 16:53:01 +0100
Message-ID: <20251102155617.4001783-3-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251102155617.4001783-1-thomas@monjalon.net>
References: <20251102155617.4001783-1-thomas@monjalon.net>
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

The constant MLX5_CRYPTO_LOG_NAME was never used.
The constant MLX5_CRYPTO_MAX_SEGS was not used after the fix below.

Fixes: ba707cdb6da2 ("crypto/mlx5: fix queue size configuration")
Fixes: a7c86884f150 ("crypto/mlx5: introduce Mellanox crypto driver")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/crypto/mlx5/mlx5_crypto.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 78a9e3d0fe..6b36a3ece5 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -19,9 +19,7 @@
 #include "mlx5_crypto.h"
 
 #define MLX5_CRYPTO_DRIVER_NAME crypto_mlx5
-#define MLX5_CRYPTO_LOG_NAME pmd.crypto.mlx5
 #define MLX5_CRYPTO_MAX_QPS 128
-#define MLX5_CRYPTO_MAX_SEGS 56
 
 #define MLX5_CRYPTO_FEATURE_FLAGS(wrapped_mode) \
 	(RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO | RTE_CRYPTODEV_FF_HW_ACCELERATED | \
-- 
2.51.0

