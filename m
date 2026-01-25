Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B901E63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 20:24:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E4DC402C3;
	Sun, 25 Jan 2026 21:24:39 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id ABF1B40269
 for <dev@dpdk.org>; Sun, 25 Jan 2026 21:24:32 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so32655735e9.3
 for <dev@dpdk.org>; Sun, 25 Jan 2026 12:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769372672;
 x=1769977472; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14kTjmK8Zzlgc4PJeXfqEAeQp+VHNEc9mnWkpk8fJbw=;
 b=TNkaGO8i3QQfobST6canAyVj2LTyfFWKvnMeKrv394TU5f5+qOlYnVZAI83Jld0zIY
 w/IibjylkIHFAChTEna6X18EAoNFcDmYOAZuUPDO1bnn7yV+fNz45XxF2qQYSbKzR5lJ
 efSxFGVdVWVSJyGO9HZ3vFooSBYf3dxpJmiFVgoGUWYRgFAjZhZTNwHTj8WDpWos13qo
 yxWuwcu9MjFvLCSy/AAr+Kbor3d7zvJVMMRdgjvyWRRwPB3RcwL4blvjZRAz2Zm72hO8
 EgzPPbH7u6zm9scdbEPJ6wIw/pgc+A2TBb7W3P7UOBVpGWh2VtKZfuhA7nI5VoNv/nNL
 IWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769372672; x=1769977472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=14kTjmK8Zzlgc4PJeXfqEAeQp+VHNEc9mnWkpk8fJbw=;
 b=mQqDBTCijjG3ywqhKpBR2tAqkPxJ56MbpMVG2UhNdTPFTnS2pOjfueLO1yWnrhqxnl
 VvymUcuWdVp6a57LjabgMhIYgacPbZfyC6+FFj6nLywadrW+J5ybMW5ujeN5jzEkAkKG
 6CbMTc8zsuZ5LXTZAix7rg14HlH5dzDvqUJXLY0BM0jIMpX1FwA3by1tB2i1z7uLwsa0
 s3kOv2NRyf68cnzSkzME3qt+m7TX7owzNK1qUXEeT0TN9qL+YQ/wGWhfTKpqrnw9v0k/
 JqalHRDeO26CIBpvTuCTtpOogur4G8C1KPGIfXe7VFYMVuZ2h013rTahYaKBaMCPCSkG
 bsZg==
X-Gm-Message-State: AOJu0Yx6iF49w1lFgf30efYT7QbaHq9bPD2UW94G0vWD1PgHq5xwbnft
 +xfFkQwRJYfiiFMnRfnzAavhdcSdADeldCUsboPxhUACKx8aqIdT0o7lQKpTR456pNKMHK45uku
 53cu6
X-Gm-Gg: AZuq6aIYB+NTmo+9aYXErF+Jx4j4gf7b2oApUx9ewj0Al3WhohqKmCW0IlcY1gVL7g3
 +rbgbWFWXqHGi02thex8dGo5BhhMMxLFjEkq+5yZ61vgagJR98+P1+AGiD6eQ/96DD0OxT9u2sh
 aZ7ARLMmTKxJ8VB2g2cen3ZiKQuQQPT0PqhLKslLd8mqzeQOWzpy3FDIGf9cS3YOZqp/kLIvbup
 FaaecJU7IeGm9BsPQeKvoE/sWSg1BpYCWBzTDuiif41vrpaTtV0tAMe+8XQQTu971g340EJtJgk
 WTDweqzV1Nug3v48wlGsWuVcD92DP3XdlJAvoaHlQSM9lHKgg5TiBu3OszlLZYWkYn/aTOlxHFf
 Jz3k0GIbFm0F/G1OE/VrTREVUU+lcQ/dGjMaQTzH/+wY9oOyNbjta5NsVNnr0CWVlvzZ5oast3k
 RBi2H0j8HChnFXAmhBMAEpP9kVL9VRgphJ3tKW5/CniL6DJOsfxif/RloPYOEy
X-Received: by 2002:a05:600c:34cc:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-4806111cb9bmr8998185e9.15.1769372672118; 
 Sun, 25 Jan 2026 12:24:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24bedsm23682024f8f.17.2026.01.25.12.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 12:24:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v7 1/5] net/null: cleanup info response
Date: Sun, 25 Jan 2026 12:23:01 -0800
Message-ID: <20260125202425.532542-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125202425.532542-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260125202425.532542-1-stephen@networkplumber.org>
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

The info_get callback doesn't need to check its args
since already done by ethdev.

The maximum receive packet length is limited by the mbuf
packet length argument which is 32 bits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst | 4 ++++
 drivers/net/null/rte_eth_null.c        | 9 ++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 15dabee7a1..9f2f2ff58f 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated NULL ethernet driver.**
+
+  * Changed info response to match mbuf limits.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..3e743a23a9 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -298,17 +298,12 @@ static int
 eth_dev_info(struct rte_eth_dev *dev,
 		struct rte_eth_dev_info *dev_info)
 {
-	struct pmd_internals *internals;
-
-	if ((dev == NULL) || (dev_info == NULL))
-		return -EINVAL;
+	struct pmd_internals *internals = dev->data->dev_private;
 
-	internals = dev->data->dev_private;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = (uint32_t)-1;
+	dev_info->max_rx_pktlen = UINT32_MAX;
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
-	dev_info->min_rx_bufsize = 0;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
 
 	dev_info->reta_size = internals->reta_size;
-- 
2.51.0

