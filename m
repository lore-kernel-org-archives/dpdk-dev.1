Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51BBD3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53F32402E1;
	Sat,  6 Dec 2025 19:44:46 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id EDE174068E
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:44 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so26012365e9.3
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046684;
 x=1765651484; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=B8Wxfy/hDbYrnvKe08WAmR8NQoaivXpxLYCDB6OSntWtyCqFC/MABeGYhFiQnrKPBS
 67nsLTk8titdaondwU8JUQlk/m3U70CiaSzz25o6tmcclqKDPRZGaLr+rNY3BxCMGcXx
 gH3Ly6HNixo3EyANIz7LzkQ7qp4fVIewyOtfZprhRv0zJ8XL1NP3BA9ioIW2AJMdcR8t
 KZBCjNbf0SLY5BOOPghzq/1k6LY+RnZKuzRDFBb3x9/0ecYw1yBX2Dw0Dk+vEPM6eAbH
 fShXDHuGEs5NGyMRYPL8+XHbIJkHS4AIFUvuYc/nCeZOaggD0qBtYBGyTC5FhyX3fS5q
 perA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046684; x=1765651484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=LQ44c93oTmS2LUnyvxKzsO1EucAjwVif6MtJcooyzrTRKB60GRHZ1AXosSx1JCSsv+
 l9eKKZAjYaxYu+ZcGPpRb8k3Z3cHxRQRiG7gKhQxqcC0/aP17JGejkoBzDG8FCxP19on
 OFGvGMlgZSWInKivJh4z0Z9g/JUIdViZRdJo0kzW8J5ybY09x0kHbQu9fc87iaCBvEFL
 3B+3QNPLGdWmeKCsS4A4iGqHL9NgV2c/j12Qk8CVonIhGrtRaBTe8eL8GsgB1dc/4aX5
 P5YJUjmRiO5ZS4SVhY13r/i0qEbksSUMqrXEfZono9GtQQIIVkxJEv3ErsHtPwlp2etj
 wiaA==
X-Gm-Message-State: AOJu0Yx/KLtqowydYopo6399ko2dW4fsZhJGcoHi355VyLH+uXxaa1EQ
 Kut2qJBm0TGBWb1bMa28dxBLG/xjA7OOLWqHcnNlWpsN00OHlo8INzYLsk2j531NtqmOpOAW3AQ
 +5ly0
X-Gm-Gg: ASbGncsOHWswMdUlgOns7DJt4EyOQMFi2rb2W4kRjMglFKABjzyOH6MBCsOemffXKl5
 049pIhI0QqmTaBMUIreCp4gYw8pwV4RUeWbd6ctx3HU0R5lsjgayKsCRXf87+IlXEPtZVEOYl2h
 UD70XNjxkjAPlYTT6Yh6PjM9UHXtc0NAnQZebg9khvY07q5S4FKMGpbRHwzemgPb2cjVnxN0R/F
 90oF3bgABgtTY+3LwqkzXGSBJccVjUgl2EfdIiwPPh7G57IolTU+sRS9OuixxZl/MDN6RzjeW00
 rDDniAynMfSL/HbkewuLFnLzF4dFs+fL73+d+T1TR1XxzODZb+RuVT9hMPdwTtMTXlhfovU0sYp
 +oJpfIs6/VN8+SEBRezGgvBaWxg5SwBzL4t6UhrbqRYrBxyUNBZ4Co51XiM4SFNb84JzrWCEPxa
 /Kdbsc4zmqZrp/Jwtd18xcaR0GyKWBdRzeSFtUv0Y4+BBs+85Y/g==
X-Google-Smtp-Source: AGHT+IF/hknLygRIPRf32iYT6SHR1ilmjhikBLM+aR6cQnCMaDxYD9K+Ab2/RjSfgs3ZXpWRKfU4Mg==
X-Received: by 2002:a5d:5f93:0:b0:42b:40b5:e681 with SMTP id
 ffacd0b85a97d-42f89f10168mr3334410f8f.26.1765046684528; 
 Sat, 06 Dec 2025 10:44:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v4 15/16] vhost: check for overflow in xstat name
Date: Sat,  6 Dec 2025 10:43:16 -0800
Message-ID: <20251206184410.542725-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

