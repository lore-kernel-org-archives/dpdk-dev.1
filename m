Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5597AE92FD6
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 20:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E6C54068A;
	Mon, 29 Dec 2025 21:49:00 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id AC25440695
 for <dev@dpdk.org>; Mon, 29 Dec 2025 21:48:58 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1516077f8f.2
 for <dev@dpdk.org>; Mon, 29 Dec 2025 12:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767041338;
 x=1767646138; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=Z8xffsORl68Nz/+2KnltACT55+SH/Cu/h4RrZELY17CPEaZ80i5xFt9CIcagK40SbM
 r4cwXofKr8P2TZH2y6Yg6wFQtEK4KWUipsEqy6daPSvmu9DzEFMw/r3M6lHYFSBeENcE
 +l1pIHNQ5s1tV+SMvVzukUbpbUmtLGItwVMfim1ic7fmqiRvmca0W/tEY3+xZq6JIyZw
 TOa0S5E8lwUWGaYMJf9Tlo+6jVUKx2eOJ9pksogPv7LElvWNFBgKxmDIYITqBQpKc8xh
 OoyCYLPE6jWNosKaLgnB3/oHlvJqiMEUs53j6JSYF7GGC7OGeavVAmfFTNBDc9nDQTfV
 3XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767041338; x=1767646138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=Y1MpwVh0XrRQLBAw5kE+2gfje4lOapzqHxyiY1KsJ0Zg5AeSIEtoWFvXQg1qBKwzo7
 xNn3MJML4plCzkDldmSZtbhk8aa5saBa/c59hEdu7o2kxVMBO+cwCqYlqOVULpVNsO52
 MYM72IlfHV7oL1Xn2/ONN/eaZrImIf9jkeUrvoyz4f+MZPv+PswDLSCArG6qQUP7J9+/
 bf/frU25DpG8iyfn9MRCGthbRtHixJwKfiI6OJNnN2xZO0JEWh8u2bdJjE1I6KfjLXP0
 YXLz7WbiKM8nmEKMsmLHYAdvwxQiwacSTDVPbaX4ep1YDBDrmcPwjwBBmSN7+Y2sdXck
 HZ7A==
X-Gm-Message-State: AOJu0YzZgWHCrlCyHkqj00SBMMGqJ63ELG6p04ghlkH7meWmQEkYYPC9
 o1XNq/9OEtYoFge9j08JDJBA6zATsQ5UJzz4ll6IoTxZ0vjYRKDb5GuYxH3tpNREXiZISmH+uNV
 Y79YOISU=
X-Gm-Gg: AY/fxX68HqxAI3Ob7e5f3jMONaq22K2SJAYDk2zXcTkdaAU8IB9AcQU4VjLvv8bDA6m
 mTAmmfk4FNtmGhDg6pq/RSgstp/JFs5dafzSK7f9jauwYTFckmxetjJsCO49x/wN8APTcdVEppz
 ozR6u58DzisLldftfD4RFV1HU6jVdqNMJrMxy9aeDg7OrERxNOjBFMyMl42B2koppvxPTwY9z+H
 LBSCE7gor8CgG56WiMHqyO9GMerNhAh3iPPx7YIqlOOVZiXpd8x5JsvMFNdWSeeSxluIz9o7E/S
 Z3iximp5dyiaPWvU6/emzD/kAMwxxJGUIghg0dOa4Q7bFcpR4OGziKuiv69Ei/Ow/+xjjwXP8NN
 O2KFRxxUTJzRHxRvlYFuED38kiJYL5lTBaCbB7Hbi+zwxrz0p+Jy9Xc87c8cnfFhOfDsfVsIiGk
 sYF+2nb1s7Ys+czuVqcFLuDwym3NhWY9OATyRX+epLQMmnLsJ41w==
X-Google-Smtp-Source: AGHT+IF4ejvdcnwi8pmkVf9ex2wBKUgng3rJqYwOO/k+VsH2ntBF1ZscT9FXeZluOkpJrNjQljX/9A==
X-Received: by 2002:a05:6000:250e:b0:431:266:d142 with SMTP id
 ffacd0b85a97d-4324e4c90b9mr39026757f8f.26.1767041338293; 
 Mon, 29 Dec 2025 12:48:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2c4fsm64676298f8f.42.2025.12.29.12.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:48:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v9 16/18] vhost: check for overflow in xstat name
Date: Mon, 29 Dec 2025 11:38:14 -0800
Message-ID: <20251229204818.61231-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229204818.61231-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251229204818.61231-1-stephen@networkplumber.org>
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

