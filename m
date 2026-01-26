Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E0D19523
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 23:26:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BA2440DDB;
	Tue, 27 Jan 2026 00:25:06 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 7700F40DF8
 for <dev@dpdk.org>; Tue, 27 Jan 2026 00:25:04 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4316133f8f.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769469904;
 x=1770074704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=QUPa8IFL1P+GuAQUIw/4Orh1KWRkaznt66yIG1/7/Yj7uDK4Fm+pDEocGsnAFO+Kik
 3WXZMVKjxfnnQnqe2pnGpZGIgr0hNdqEKTRJ/cdYgPjgegWggYsw0ti5QOAv/a0HXipA
 WZ4+vEKOn/ZNvN8VjNpOTmyo0LUtZNyRn8JAdqXJCY7j28RRRqNiIZyRi8JxZTxGwsXm
 qaBcIyZXGiJY1J9zUxRxpt1CksW/+X31oejuM9xJeYsZrBcZxHe5HUGRRN/q15Q4GEvD
 z4UJ63vmcW54FM/MIP7hJrlrHSlAPS1baLs4COPO7pkEA9TvEjDl1NAhsezkf987ZkeK
 pE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769469904; x=1770074704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=RT+hP+KRkrsSVzszTPChTy1qsByyyMD+eKHOS77Ws0j5U+Zhn1SJR1RE78LmicaY74
 IQF8nzHoLdKmTvXp1q+QFsQqtrthclHA2A/WIEIRks3Eyb/5Yd7CoIf7L7NXotUoVGT6
 A86hTnbogBphlrpUPi6QzF3jIMXTOxm9UaM3gtqzDX3WZwnodCURf8zKB6ub1JiJ65ei
 RkhUNesGjUBcrSeoEqGaqfg5quutNC6GNa0w3uFsykBa6wHK9yT3FdnE/W7hUxVK5N0N
 uIKQitvYXtC0S9ORU1MEsBc4sdXtxX/IeBd4lBVnamH1liWXE8rm91GinS3Y0/n5p4Lz
 jQ4g==
X-Gm-Message-State: AOJu0Ywi7aj+A+ZcUfAZ/+UJPDhA/zaTOZrNI17A7I7N9tnkNb5/up/0
 SHDwaumsz+DQ4iiMvrLbV3M1XPB0eCm+57UqT3Y3mIl4L1nchu+wZZPEZLMwMq1cqB/Ayt2udXV
 clUwv
X-Gm-Gg: AZuq6aJXRUQBb6KH4022iIe+nQOOU3UvfMbAS7wphR/u+lV4fejUdqw0yCA9THvhO5A
 UrDqpIqeXWdHvGABgFVljG4MTebHEqhVDjf+5gV9uc05URc6+SpRyOprpnAy8YOeFdubH2x6g6K
 w7wSzZIcNW/nXoo4vgix6YsYNgMMU3CLLrGH3VB2z1TzX+quItNhuBX5lumFlBeG1yvF54bfVwI
 Lak6y2ZuIOwQk+BbWo11cX/qebu+N45RAMVu6q+2SdeCTYCZ6CABzADFZGU1Wcf/wNIqCrq/mmT
 Sp1JeJO1fI4g2g/cSuULB9Cm9NisBz5PSuWbBiX29A5zlsgv2m6A5JLXrsc2o1ANjC2VvQHMwXq
 b7QeZd4bFFSbR+N8vvJ47kHSSPba/yHshLB4Az2qe8DqJQOHtnmW282zTMcGJoW8Nblrbq/ij7c
 2uY9MyhBvcDdKGHKZ32Jy1h8wZ7djLdx5ldaNEz4R3Yddz/A0NYw==
X-Received: by 2002:a5d:5f83:0:b0:435:95c9:6897 with SMTP id
 ffacd0b85a97d-435ca399075mr9744541f8f.46.1769469904056; 
 Mon, 26 Jan 2026 15:25:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24a6fsm33711846f8f.16.2026.01.26.15.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 15:25:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v12 15/17] vhost: check for overflow in xstat name
Date: Mon, 26 Jan 2026 15:22:23 -0800
Message-ID: <20260126232428.276534-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126232428.276534-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260126232428.276534-1-stephen@networkplumber.org>
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

