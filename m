Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F01D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72378402CC;
	Fri, 23 Jan 2026 05:30:28 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id C91874068A
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:26 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso19572895e9.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142626;
 x=1769747426; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=BmDAr322pLh0kViQbBB3FUWgPzmLkqWOxTo53Wr8rE1qguTv0tisUX7Qk40zUrGxyT
 qnGi9Gm8cpcaCFaja/NAdepX/ENdvr6x/KPlDcRJi/8r9l3i3tzvVPSHbe+lvH99Tq7/
 Gs3S9EknOa3nkISV0UxUxFY1wBbZup3vBlIPuT7Y/5Zx2PgDJgH9vTa4hlFrkdpnIL5J
 s/aDmVHroq58qqooVKQTrUo6a1VlOMCYV3d4dWUEc8aWJXmx/5sRzhS9CKF+QQYL8Aeq
 GB69waP37zlEMWSrhLnW7OVzm4c4+8Pxq++MlosYg75l/xs7FmvH9DoP+DZpfa3q1wWr
 0uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142626; x=1769747426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=w+GioS1qn7g/YE47C5Q+eMhH5aikL2z9HwmVH9WSwy8LkZv2/scf51xLIugHe9iCOy
 CepyA5x4l7KHHF65qHpmKeufuS+w+Vr+UApVdLbjDN8HMKE66UwvLSAqDq7/SzPFEHee
 IWNFitmLzxACHE4ah0IcaH6TxKjr1LikNwfXgEh0eO/4a7jVpxHAlRwPEK+KLi0fREcl
 a61Z/DQVL4R+CQrwQEX4mKnRWNmDw1J1ouyQQNrS3fk5Z1S5IKHRGhGdXxhsvQiDJ6JG
 bTx7k4TBlwEtwL4cX32TGGZdMuscv3tQDzKPSSjL6/c3NxMnHBshRUQFbXM7lYDEOjHV
 Nh6g==
X-Gm-Message-State: AOJu0Yzl0u6B+Jb4oniNbzzjJOF46GVnDd54TUqJpShJPu8X4xYZt8UG
 nGHw8ak32pnxLTf371+zyVoHdiscj2KZ0kMSqmjb7wcH2UIqF1CErVszc2WvA8mHeVofnGp0RtE
 9qNs4
X-Gm-Gg: AZuq6aJxpeE8G7R60Q2sc5ACyNv3/n2e7Y9LJDhDXoHf45pwzcnW0sphGetwFJmc4tZ
 TB38LpMRI52+ZNFw+QnTrpOSxSxlE585beRxcq8ymHRLxj0xJnWer1tM1IxVp9qix4wFLo31jnC
 TI7zjepDMgOUe4B2cJIjDr6ye20t73/cayTWQlI7qNOO1nSQht7BruOgsX+pQHg6avHJCS1U2CL
 jSSriggaVGz+K31GeCnBcoDIbgVK/WzqxTqGVsmsHFXUDQ5j0kFMdu55jDIDoPcu10VWDXvrT0O
 uli6hdB+sX462/IELUh6tJjnqX8BrB8PRAwmkEW+oqgj/ewzXY2/2tVL/RxefB1SCk+OeYMQwid
 JVddi0icFE3mYVl8SAKLLmA1XD64/RhC9pLCgADOvIIfuXrCMJPs6JO5ADPJQ7JS7yKXFvt6Q5x
 g+FlrfzVNuEayDzdzTeoolgEjqfOiNXNL4Wdoxp48ccaZjzYbCSA==
X-Received: by 2002:a05:600c:8b11:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-4804c9ceea8mr25489025e9.34.1769142626411; 
 Thu, 22 Jan 2026 20:30:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v11 16/18] vhost: check for overflow in xstat name
Date: Thu, 22 Jan 2026 20:28:14 -0800
Message-ID: <20260123042945.159075-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
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

