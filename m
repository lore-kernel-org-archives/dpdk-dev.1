Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC5BD2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:14:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34799409FA;
	Sun,  7 Dec 2025 20:13:21 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 212894069F
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:19 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so42711655e9.3
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134799;
 x=1765739599; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=TC2ZRFKR68fAzqwSqRjYHtVrh9uMCujM33mAaZd9hGhmuf3DotFmoGnSA5DGxECNxF
 tDylMhXmdYeDHJdyIr17w3bZ6x9GgQKSLa1bYvytOcMiQMn/hDZ1WC4j2yNGX/rkVD+q
 Y7MawPa8P/VzxJyJtqzI4QYlWKA5HSFazAWLr7KPmGQe9qyedaBy8XSBD66OyxHEffeJ
 YUDhWmk6ZUxBxdDHFCF8nT4/R0mR70Z0RkbcsY4RwEuDvcExv/jOUrVAKx7KURV6TQXw
 EaWAiytlUYGVytIZVBoFdhxBsFQ/2PNg3VQ+ZKNCSiJvFRjjXJfUfufQ5g6rLJ1TDFuF
 QvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134799; x=1765739599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=NmZZ6zGq9ToWmA2kZjuVm8peCTfmROde5YhrLTLY3FsV40WsMlSGBuJt/t34AWSsqO
 fuDi5AzHbLa+8Ei1pVtQHDjt3iLw567JZ9lxuvxudA4t0AxEdUwKR+pkElSnpZbavFx4
 kcn4+RlzGZR/1yGsXo/lKjDuQpWdFBp8SemSKl3uLyYbfMylUKnmva6rNsJZKWacNmao
 vnAViFuFLOSkwlURXwd5MhmUtUxTtXibV6j8mbDBbGSsYvIxrLHbTDlPEU8RV+7Bz9Kj
 7vx0VUu+u1on00csbToV3zy1oO+UZCbadSNyjywHdHnjIl7fxlSNjj36i0oilnMaXVCJ
 bDUQ==
X-Gm-Message-State: AOJu0YxJ7DsKOuD5q2Jduy5APiu3Y7J6d5IEdkWPxM6fhznUD1qWdOl3
 O+geC0DGPqc3+DHrWXTuwJBi/61tMWDYrsPSeHeJuAlUKzTrrIVlafVRAGOH0N966lI4VVyKxY2
 YC1Cm
X-Gm-Gg: ASbGncuZE6JFndFBZjHpx0vU33wKdfiOudK2JOHJiQzfBpOc5iCUvl0xM87UTrRwXjg
 AGjFZsafv3s/MXfcCJ99b73ufr1awNyAzcXtvshW0YBPx8Ywc+NbMrywCHNE8k7tN+BAmZqnw+N
 Z0edg9S55wT9ZhmO7YAmrl+beXTLYGW7uUwXnNBHxMi3Ra9egqwhZn82RnCX0HIjSgutJS9kAib
 TU6kMOpP4PJ8IV/C4X7ydztIdp+y4RkMU4sOxT5O2M0X2RDEk+/f2iG41G6W7+qde0JvaQqVUbT
 ut01Es4q28aUbDNwYVjxqDPK/GhONpABQp3RivTQ0/6elMd5coftT9sKG+J/xeEdgvRmFT0zTht
 3jQaz4Z9130xI6nRzHjt+L1gPavcgVgUs9bpFKS54Lzk8uYy4r6SLcfIIY2XwpXHGdc6jTLsakp
 8nalG7VCU0KIB1v4WOzPF2Sh5ZSBkq+C5nOH/Q/v0y1m+lgJNUtg==
X-Google-Smtp-Source: AGHT+IHzlrXPOsAErIZ+Q3UFPXA2Bqo2GaJUw3tFx3kIfyjWV7FIoyf1UG51fUXFcgShd+k+jz3v0g==
X-Received: by 2002:a05:600c:358f:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-47939df3205mr74296845e9.7.1765134798704; 
 Sun, 07 Dec 2025 11:13:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v5 16/17] vhost: check for overflow in xstat name
Date: Sun,  7 Dec 2025 11:12:07 -0800
Message-ID: <20251207191242.165619-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

The snprintf to format an xstat name could overflow if called with
a long rte_vhost_stat_name. Check if that happens and warn.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/vhost/vhost.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 416f082dca..540f4e0635 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -2200,6 +2200,7 @@ rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 {
 	struct virtio_net *dev = get_device(vid);
 	unsigned int i;
+	int ret;
 
 	if (dev == NULL)
 		return -1;
@@ -2213,10 +2214,15 @@ rte_vhost_vring_stats_get_names(int vid, uint16_t queue_id,
 	if (name == NULL || size < VHOST_NB_VQ_STATS)
 		return VHOST_NB_VQ_STATS;
 
-	for (i = 0; i < VHOST_NB_VQ_STATS; i++)
-		snprintf(name[i].name, sizeof(name[i].name), "%s_q%u_%s",
-				(queue_id & 1) ? "rx" : "tx",
-				queue_id / 2, vhost_vq_stat_strings[i].name);
+	for (i = 0; i < VHOST_NB_VQ_STATS; i++) {
+		ret = snprintf(name[i].name, sizeof(name[i].name), "%s_q%u_%s",
+			       (queue_id & 1) ? "rx" : "tx",
+			       queue_id / 2, vhost_vq_stat_strings[i].name);
+		if (ret >= (int)sizeof(name[0].name))
+			VHOST_CONFIG_LOG("device", NOTICE, "truncated xstat '%s_q%u_%s'",
+					 (queue_id & 1) ? "rx" : "tx",
+					 queue_id / 2, vhost_vq_stat_strings[i].name);
+	}
 
 	return VHOST_NB_VQ_STATS;
 }
-- 
2.51.0

