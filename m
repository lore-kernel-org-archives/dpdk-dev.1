Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CBBCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Nov 2025 15:57:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0961340651;
	Sun,  2 Nov 2025 16:57:06 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 5888640650;
 Sun,  2 Nov 2025 16:57:05 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 07FFFEC0204;
 Sun,  2 Nov 2025 10:57:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Sun, 02 Nov 2025 10:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1762099025; x=
 1762185425; bh=WWTpJI7Nh65bKu5AlpABeFRc/uYPYaG6xGUmrVDyaws=; b=n
 VeYaHWYFH2Ep44Y/bYLA1zXjy+urGmeXHP8yxLRNzwcCY/WxXFxDlyuSda9oiCrG
 aqxQaHY9Iq3yoLjmyJvMq/5YU03ZMZ/2dgLNx485BDRpylenx6Iyo6P57TO8E4z2
 egBvRRgGHUDgK4/grhKCfWlOW1i9v2SuceTQQOVaVarq+tuw503Mddg7OIhfilgy
 ogpfKWTBXWnxbWZXOlcrz/lfwgiIsDosB3YmcnSsRJRaib5km/d0/Lp+p56tr0Do
 kG2KNYsMEt6K5zdta1dcsTjEz1FExzPZl1ESODlyj124MCJBHThdHDBqASm5HfXz
 oktYx1gQ89y53k9iRbCIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1762099025; x=1762185425; bh=W
 WTpJI7Nh65bKu5AlpABeFRc/uYPYaG6xGUmrVDyaws=; b=CVz21DEe46UDrcb7S
 62MUxHe37xfXPrJXZhPXgNjqRJIlv7uHC6jCErcfA7C32LYwTR6D0nMOsWo0d+y8
 bHCLnWMjKJZG97WhaTuJTec44KRLr3hk2Wj7KLwg7X8+vC1kF+64ULJz82wYqr19
 71kQxOvM7kK1P8YwSEGKYlDGQVXyYrfvm9c4klDbMdanYx84YOj76s+h5b0hKxXL
 LbLtXrFH/NGQJzSNxtAYLaEDd72UfW4to5yujle9sCteBqvB/om3TOvDVrL3EqgU
 nr0XvGVRyppTQQBQieq4TqulLaYwHbuqutBBlzO1Zyy7dysxnQiSJNAYDK9MnGxy
 9yOtQ==
X-ME-Sender: <xms:UH8Had9wKcRAEi4LkcB9VkZ8cpHc3HYco3UOtq_yk19mWpv76s4oaA>
 <xme:UH8HaZ06oFv9hUsV7EiFuNTmeCDDoK1ByNFhtz3B6yP7X5a5og6HH9XDsTl6bseM5
 SwQS62rOZOHy6ZVEjdIpba19o10OAIL_ZNcxpELT38PLNZNlyRH>
X-ME-Received: <xmr:UH8HaagQN_BOjV1UzhF5l-Qvinhmbl_lmqdbnjfYuPC6mAHYoMTLzi7iArgYX_aB4dbumoiI2iN2vRDn7tayaLqkmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedufedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegushhoshhnohif
 shhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirggthhgvshhlrghvohesnh
 hvihguihgrrdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhr
 tghpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepshhurghnmh
 hinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrthgrnhesnhhvihguihgr
 rdgtohhmpdhrtghpthhtohepgihuvghmihhnghhlsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:UH8HaRaGsx0G26w3HbhBDCkfh-1-JcXs9IgBLS7sD3i9KWGeswqMHA>
 <xmx:UH8HaeX8Hx3mXfpSdg_vNdROWSiUlymoK-o1-9I2XfXG9sAyyyYLJQ>
 <xmx:UH8HaRELXkJAepjBtESKSxRonhI7n8YFHh7hXK4iOZr2sCOc4w9Rbw>
 <xmx:UH8HaQYHkkr1AyOg8VjFj80qpNRPKYjTn5aaqedPF5NZ1pLmygntkQ>
 <xmx:UH8HaRkDSd1j3WRF3nNetjYtAEFlIjrw8rZbBRCgmzgN5ey03mPDQ4a4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 10:57:02 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>,
 Nelio Laranjeiro <nelio.laranjeiro@6wind.com>,
 Adrien Mazarguil <adrien.mazarguil@6wind.com>,
 Ophir Munk <ophirmu@nvidia.com>, Tal Shnaiderman <talshn@nvidia.com>
Subject: [PATCH 4/5] common/mlx5: remove useless constants
Date: Sun,  2 Nov 2025 16:53:03 +0100
Message-ID: <20251102155617.4001783-5-thomas@monjalon.net>
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

All these constants were unused since their introduction:

- MLX5_DRV_PROBE_AGAIN
- MLX5_NL_BUF_SIZE
- MLX5DV_FLOW_TABLE_TYPE_RDMA_RX
- IB_QPT_RAW_PACKET

Fixes: ad435d320473 ("common/mlx5: add bus-agnostic layer")
Fixes: ccdcba53a3f4 ("net/mlx5: use Netlink to add/remove MAC addresses")
Fixes: 03e1f7f760d8 ("net/mlx5: create flow matcher object on Windows")
Fixes: 358fbb018310 ("net/mlx5: support multi-packet Rx queue on Windows")
Cc: stable@dpdk.org

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/common/mlx5/linux/mlx5_nl.c         | 2 --
 drivers/common/mlx5/mlx5_common.h           | 3 ---
 drivers/common/mlx5/windows/mlx5_win_defs.h | 2 --
 3 files changed, 7 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 8753d3127c..d53543a113 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -28,8 +28,6 @@
 #endif
 
 
-/* Size of the buffer to receive kernel messages */
-#define MLX5_NL_BUF_SIZE (32 * 1024)
 /* Send buffer size for the Netlink socket */
 #define MLX5_SEND_BUF_SIZE 32768
 /* Receive buffer size for the Netlink socket */
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index b49f0c850e..214ddcb8b3 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -575,9 +575,6 @@ typedef int (mlx5_class_driver_probe_t)(struct mlx5_common_device *cdev,
  */
 typedef int (mlx5_class_driver_remove_t)(struct mlx5_common_device *cdev);
 
-/** Device already probed can be probed again to check for new ports. */
-#define MLX5_DRV_PROBE_AGAIN 0x0004
-
 /**
  * A structure describing a mlx5 common class driver.
  */
diff --git a/drivers/common/mlx5/windows/mlx5_win_defs.h b/drivers/common/mlx5/windows/mlx5_win_defs.h
index d60df6fd37..d98725eea8 100644
--- a/drivers/common/mlx5/windows/mlx5_win_defs.h
+++ b/drivers/common/mlx5/windows/mlx5_win_defs.h
@@ -184,7 +184,6 @@ enum mlx5dv_flow_table_type {
 #define MLX5DV_FLOW_TABLE_TYPE_NIC_RX	MLX5_IB_UAPI_FLOW_TABLE_TYPE_NIC_RX
 #define MLX5DV_FLOW_TABLE_TYPE_NIC_TX	MLX5_IB_UAPI_FLOW_TABLE_TYPE_NIC_TX
 #define MLX5DV_FLOW_TABLE_TYPE_FDB	MLX5_IB_UAPI_FLOW_TABLE_TYPE_FDB
-#define MLX5DV_FLOW_TABLE_TYPE_RDMA_RX	MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_RX
 
 struct mlx5dv_flow_match_parameters {
 	size_t match_sz;
@@ -263,6 +262,5 @@ enum {
 #define MLX5_MIN_SINGLE_STRIDE_LOG_NUM_BYTES 6
 #define MLX5_MAX_SINGLE_STRIDE_LOG_NUM_BYTES 13
 #define MLX5_EXT_MIN_SINGLE_WQE_LOG_NUM_STRIDES 3
-#define IB_QPT_RAW_PACKET 8
 
 #endif /* MLX5_WIN_DEFS_H */
-- 
2.51.0

