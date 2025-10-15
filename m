Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F160CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 23:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2C6040ED6;
	Thu, 16 Oct 2025 01:09:43 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 5D7EC40E30
 for <dev@dpdk.org>; Thu, 16 Oct 2025 01:09:40 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b553412a19bso37434a12.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760569779;
 x=1761174579; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLGYWLwBJ9IDKdXHQIRg1D0W5eB3U6MxEJ105yjbrrU=;
 b=OuVJGnU9vW92gc/uX54AcEVCnsBQaZOe//yN70K3jrfVk6+7XwMmEtBw2WDAjUs5Uv
 K0jH7QUcqwCbCIQEimcmcXluaHh8ID/dZDkR/TAFy39yUOJWpNi+dk0GfmlBXPrWODmr
 z44Dk8MBFYfAb5aek/CfxuCNa8qG1gXRuu9zL1fR6gTJ8dmvWsQJ4abGLtUgKzLymCyZ
 gi3FOElpxGCsKSIjnH0FPuc0PJ0dUoSY2HUDYDcuiLMsnCeeUZeMqVjCnoz4NzGVnRlb
 65qub6ObMFx1u1hO3rHH7v3JXcoT/F31kQS9atLOHqtpL3t+o7RwXGJbGNWpSJx5fLi6
 8PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569779; x=1761174579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLGYWLwBJ9IDKdXHQIRg1D0W5eB3U6MxEJ105yjbrrU=;
 b=Ri9OkBIodOXiPBEoZkMnI3er74a85q2zDgrvTvw1GYXxpAI5tr2Zc6zjzdUClMwTqT
 6EK65RED0rzRaRzJmgsSuZKpPgqbGVnqs8US5c4Yt2RB3wSFJxXeeusd+wRKhfBwPc4m
 sSrOtDAMO7xWsjaXSHnixtLriAe/m6QNn804BrgxcVS4vznvpq/cLD0gqTBwvdhqB52+
 cEBtPlJrcrA4OZs2EpdZB9PEVZDKOEpEvdTIb/mqvYCtHUk7h6OXt97K7nKHFMVgYT/q
 9Pe8FwrhwIztDPORipPY5d258FHvR7i0d5LWxFuWkmeH3gX4K6Hef6H4uKeQxLVHxe2P
 6QjQ==
X-Gm-Message-State: AOJu0Yw6c6Zh463uYmSVBqd4LQ+R6et2VAO5ILWSbO7xW95mJCFE8YR+
 HmlLz+q3jGOyU98RDkl9b9/PovXrG1F2ae+4QOysUY00QKIR4RnZpLIpujbz9Pxl3g1VNJVugGR
 U+2Aa5vA=
X-Gm-Gg: ASbGncstDhn4SL8h4XLYrXLlF5/TCn9UDjIJZ0qfggAFJCv9fnPEcm3w2r+hzMTC5MA
 nt4yPfBcUl4ZPioeAthFT4ADdCvd+IGh+F9yuO0SlpFBxiM3Xuc9xg7wWEE4/jtmCuJC76rvI+u
 EZJlJhf8/VoHLYpZtdQjcW3imZau7c7qIOH9b9gFbuu9r7iFCtWpZ9Jv/j+JqIEPKuNKdTNtJE8
 PZO+YM3BlSGAAy0j4Be7+Tk2A3kSEC7XBgF8e1V/HLf5X/iIO0Jn9vlqd28QQzJIhLOAYbLty3o
 Q44Afo5q84EF7z0/udx6KyUZd51QEibW4uitZpMsrO5xlvdeyqRMJ7rEZb4GyiKSxyXoHnAinfu
 tWMx1enHo7gHl+QlbnHM2XiysXWyqtAr626PmomwNsArUZ6ZRH9QlvffAU1vsSsGivu535z2VOZ
 P2Yu/b885vkZVHvH9LNaOkcltI0FpL3T7uaDqQ3Ltq8OvDXTDGDnfXrAKYlmQu
X-Google-Smtp-Source: AGHT+IEK7tp9x8PjDlRDTWtGt4GcvcZXix+4ikxmYLhohz6+vfwKS6zylj+5rVvmF3fXy3rzVfvGbA==
X-Received: by 2002:a17:902:f68d:b0:25d:d848:1cca with SMTP id
 d9443c01a7336-290273ef145mr426050935ad.35.1760569779514; 
 Wed, 15 Oct 2025 16:09:39 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7de45sm7600155ad.54.2025.10.15.16.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 16:09:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, rohit.raj@nxp.com,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFT 3/3] net/dpaa2: make total rx descriptors per device
Date: Wed, 15 Oct 2025 16:07:39 -0700
Message-ID: <20251015230933.875860-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015230933.875860-1-stephen@networkplumber.org>
References: <20251015230933.875860-1-stephen@networkplumber.org>
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

The limit on number of receive descriptors should be per-device.
Discovered while looking at globally exported symbols.

Fixes: 35dc25d12792 ("net/dpaa2: warn on high Rx descriptor number")
Cc: rohit.raj@nxp.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 9 ++++-----
 drivers/net/dpaa2/dpaa2_ethdev.h | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 41678ce09b..32edff0554 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -79,7 +79,6 @@ bool dpaa2_enable_err_queue;
 bool dpaa2_print_parser_result;
 
 #define MAX_NB_RX_DESC		11264
-int total_nb_rx_desc;
 
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
@@ -720,9 +719,9 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	DPAA2_PMD_DEBUG("dev =%p, queue =%d, pool = %p, conf =%p",
 			dev, rx_queue_id, mb_pool, rx_conf);
 
-	total_nb_rx_desc += nb_rx_desc;
-	if (total_nb_rx_desc > MAX_NB_RX_DESC) {
-		DPAA2_PMD_WARN("Total nb_rx_desc exceeds %d limit. Please use Normal buffers",
+	priv->nb_rx_desc += nb_rx_desc;
+	if (priv->nb_rx_desc > MAX_NB_RX_DESC) {
+		DPAA2_PMD_WARN("Total nb_rx_desc exceeds %u limit. Please use Normal buffers",
 			       MAX_NB_RX_DESC);
 		DPAA2_PMD_WARN("To use Normal buffers, run 'export DPNI_NORMAL_BUF=1' before running dynamic_dpl.sh script");
 	}
@@ -1029,7 +1028,7 @@ dpaa2_dev_rx_queue_release(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 	memset(&cfg, 0, sizeof(struct dpni_queue));
 	PMD_INIT_FUNC_TRACE();
 
-	total_nb_rx_desc -= dpaa2_q->nb_desc;
+	priv->nb_rx_desc -= dpaa2_q->nb_desc;
 
 	if (dpaa2_q->cgid != DPAA2_INVALID_CGID) {
 		options = DPNI_QUEUE_OPT_CLEAR_CGID;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index ffc9ebadb8..aa3fcb9af0 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -385,6 +385,7 @@ struct dpaa2_dev_priv {
 	uint8_t num_tx_tc;
 	uint16_t qos_entries;
 	uint16_t fs_entries;
+	uint16_t nb_rx_desc;
 	uint8_t dist_queues;
 	uint8_t num_channels;
 	uint8_t en_ordered;
-- 
2.47.3

