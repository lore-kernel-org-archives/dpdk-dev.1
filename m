Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0539C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56FB640612;
	Tue, 11 Mar 2025 16:53:16 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 471B94064C
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:53:14 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fec13a4067so8833403a91.2
 for <dev@dpdk.org>; Tue, 11 Mar 2025 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741708393;
 x=1742313193; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tr/tvLd79a683ldJPwJrV8IfLr9fKSWXXH0zkjWykQ=;
 b=1PISm/d+J0L1n+FsPqkgXnWtuZJodXJn6nzbqr0ae22ZUxvpEiX56J6naxiFNvUwwQ
 +irYETkQ3U0bGBNO+4bRndbh7DnNbSbfUTh5SIbjpWERQZX+CJ787tknDj+G9ORWi8Ew
 S1rb9oHJGBoCfQnj0pRvUWaLump/m+puRqlKIkhBKloU4fOYOy5oC4iXzVO38Xwyb+Yn
 4N6P044jDWAxEiD8xFUGRRqZoFYVZFIREutVsL245FBiRFefINd7JxlI/RE6srweyfec
 T2UchJb9fADslYsRFg5FOJ8RjBqfd5RkX7sPJYAWnf8KvyXhVL32D0K7YVUWVoQjs9qZ
 Eldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708393; x=1742313193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tr/tvLd79a683ldJPwJrV8IfLr9fKSWXXH0zkjWykQ=;
 b=uu15J7iZlkN9ZMdlJEQ5pDtM0Pl+0PB3QyP3206qLFiJSPI09wpbG8ipP8+bsZqn/d
 zJNiH3RXbPUrwEQYhm544XuRognZOqEDEJnGRVb/3zaGVWIHYLRdVglpDoz4sN0+s/hM
 NlG4ZXvRZmf9DWpxhRUZTlUZsyxDl9QrtvbifrMjzC4LXXRFz3OlbbZYAXYv+aElgPdB
 x4C1BW4uC/wD/xz5nUQE6EzBJJv1GcTJQU4TMEmATFABxplRcVT60NuwS3vkwynZEhUK
 noHIsSXDJUXpZC+3GDj28ztIcdrCh2ZyM0qG6Aqvdz5wI6n+ukv24knnisICNT9FpvzC
 SPYg==
X-Gm-Message-State: AOJu0Yy3TyNDu9evRKrS9cJciaNoieQ/8vExStpO2qpugpuMSUVWPdoT
 yuGSFx1OFM9JpeORYGh7jsyuRd8qvpzLzWtwfHJH8bzhL2ai1xzyokt5T/2ZrGZWsiUz2KwpFUQ
 /
X-Gm-Gg: ASbGncuwwvawqXB7BdrfSJY3BGoZLpq8PHBTFxdXj5vhii2k9HRFcahj/EakTqDRGg5
 cLreoY+vqM44Bf0qJHl0csWl84VR0t+JDCuGJZw6eEyzDtTbg7WjhvN7Bsg7O0IcykWiUeHrgX5
 5h2F2rk4pPvciIECpB/tPhpU/jD7+nzuQiEpmth1CUob9JniZfI/5wFYfR8ThGVkGRxKkb3HpVe
 eue0sjLjuf54Snz7xeH4DCIQJtID8QphPgab3PF7gsToA7nIaP1krylBLxo/Kb9CvUUV78tPgIu
 bq+JOE5izyz3fyjzusj/PHFwwUwgoxZpD8hyZ4qo5+LR93NLCefTZTqJLrs0/NtbWM5NE4PVrJd
 K/G0EK00X/oDUNdQHXg6OGA==
X-Google-Smtp-Source: AGHT+IGif9oxw1+rpP0X/yKDkZ58dHhufSj5XcTMmOOSYdnA1NM8BsuZ6zpwz6DYQYIa90WJcGuFIg==
X-Received: by 2002:a05:6a21:68c:b0:1f5:80a3:b006 with SMTP id
 adf61e73a8af0-1f58cb44e1dmr6834838637.21.1741708393537; 
 Tue, 11 Mar 2025 08:53:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af283576bc2sm9500013a12.38.2025.03.11.08.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:53:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>
Subject: [PATCH 3/4] regexdev: another unnecessary deref of function pointers
Date: Tue, 11 Mar 2025 08:51:31 -0700
Message-ID: <20250311155300.13410-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311155300.13410-1-stephen@networkplumber.org>
References: <20250311155300.13410-1-stephen@networkplumber.org>
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

The expression *dev->enqueue and dev->enqueue are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/regexdev/rte_regexdev.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/regexdev/rte_regexdev.h b/lib/regexdev/rte_regexdev.h
index b18a1d4251..1534e9f84a 100644
--- a/lib/regexdev/rte_regexdev.h
+++ b/lib/regexdev/rte_regexdev.h
@@ -1473,14 +1473,14 @@ rte_regexdev_enqueue_burst(uint8_t dev_id, uint16_t qp_id,
 	struct rte_regexdev *dev = &rte_regex_devices[dev_id];
 #ifdef RTE_LIBRTE_REGEXDEV_DEBUG
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
-	if (*dev->enqueue == NULL)
+	if (dev->enqueue == NULL)
 		return -ENOTSUP;
 	if (qp_id >= dev->data->dev_conf.nb_queue_pairs) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Invalid queue %d", qp_id);
 		return -EINVAL;
 	}
 #endif
-	return (*dev->enqueue)(dev, qp_id, ops, nb_ops);
+	return dev->enqueue(dev, qp_id, ops, nb_ops);
 }
 
 /**
@@ -1533,14 +1533,14 @@ rte_regexdev_dequeue_burst(uint8_t dev_id, uint16_t qp_id,
 	struct rte_regexdev *dev = &rte_regex_devices[dev_id];
 #ifdef RTE_LIBRTE_REGEXDEV_DEBUG
 	RTE_REGEXDEV_VALID_DEV_ID_OR_ERR_RET(dev_id, -EINVAL);
-	if (*dev->dequeue == NULL)
+	if (dev->dequeue == NULL)
 		return -ENOTSUP;
 	if (qp_id >= dev->data->dev_conf.nb_queue_pairs) {
 		RTE_REGEXDEV_LOG_LINE(ERR, "Invalid queue %d", qp_id);
 		return -EINVAL;
 	}
 #endif
-	return (*dev->dequeue)(dev, qp_id, ops, nb_ops);
+	return dev->dequeue(dev, qp_id, ops, nb_ops);
 }
 
 #ifdef __cplusplus
-- 
2.47.2

