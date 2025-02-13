Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2A6C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:19:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5585C4067B;
	Thu, 13 Feb 2025 23:18:42 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id BF55E4065A
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:38 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f9f6a2fa8dso2096243a91.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485118;
 x=1740089918; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=CSaSRG0E/z03hwa/iwf1i0AVCC2Vaij3Qk8uO2UCzwZZ3Q/7v3WGvPSkJse/sxUJrz
 9NMWHZXtLMn/C/XQvcczq8WRMmc1j2AY+qcCTGNpve2sjLfxP5Hjenk1UUbadSGu0dKk
 /GMe4hhSHUQt5KAhrG6EUzrI5d6eYaW1qcTiazvKF7EfjWV6FbWKuFH1xgufqb2OzoK8
 6OXaomc6PpDcpbH+ah8JXBiQETMYhBwouBplbiTU3ePDW++YxaulmjiwXAFB22Y1qehp
 VDA2+sR/UHT6MFyWTyIoGsWGjxurqOiB07O07gqZmDCCyaOqWHr1N777riqKxGi7lBLx
 wgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485118; x=1740089918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=WhDC4NKKRVyI/4oFWcKHhee/irc0mn79/E3vNK1uOZ1jAh0pk3dz2zbMJocPo/xbVs
 QptEy3tLTHs1Geyl2XwT3RzqPjmnJxUtJLOwKUGCAcAeqYWdqWIpu+bKdFfOGTeqcZ8o
 BTOP3KtmH4d7pdRoeMr4aMGMy7B3gt+J7R/QehX4If+RcamQ+l8v8BL4jEuOnA79OQlJ
 6wDZEXm9d4cznX/N9AIFP+mfKHImb7HmJZifsPI/BaDpTOOnmJo1hlvJVicK2Wn8TYWb
 ZO46+4YwanOT1BLDB0sI0MxwdedCGUZkiE8E7k5B8vTLO5XO7QHn9zu9cVcYvg8joH3+
 LqmQ==
X-Gm-Message-State: AOJu0YztZYpgR1MmfQxvWe8Sn1mwuYFtAs2zYxx7rc2kvlVSxbA2lDAo
 22XG6JqpN2imRY3a4LpbtPK+OsrWOK2J93BSvLON+NmMRmA3bkySCRsKQm1A/wuRIxrL+nuCaTn
 8
X-Gm-Gg: ASbGncsK3NG98XUBMFhKrT86GofREgVAf/AiszUPJiqkyIi0UyPBmI7CKCeU9YRQclg
 VhBvACArqkRAzIpL6h11LPY7KfynCXoYNf0y1wpUVzxjRTcy8Nh9lT2ytRJyAFjR4hskVi82qGC
 f1OCcbdA5BlOxQCAXFte8180tzpUT+B+FEnWcH8NndzoGF1zPTgZsp0AxT6AeX2JwQh9ystCbQh
 abrKwN4nshuSEl9MYWpEFQj1NwUwHkfnHiocML9V3I+tkCbIH/NVtKoEGspKIwqrdHZMkeq0rmW
 yTMTE2Tz3ra6UiZs0maHOEyCBEJneeS5b+cQXo7c7iLV0deDeXuLgcuipjBOdi0a/UHy
X-Google-Smtp-Source: AGHT+IGOAjHk2vC4vhzW8yqZ96uMcKSaWxD26flwsqsCAKGvkQKEhHfBL3j9cUXT6SbC07GIqt8TeQ==
X-Received: by 2002:a17:90b:520f:b0:2f1:30c8:6e75 with SMTP id
 98e67ed59e1d1-2fbf5c6b7fcmr11968729a91.32.1739485118010; 
 Thu, 13 Feb 2025 14:18:38 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v6 06/11] bus/uacce: remove memset before free
Date: Thu, 13 Feb 2025 14:16:19 -0800
Message-ID: <20250213221819.1856769-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

Doing memset before free maybe removed by compiler, and
is flagged by security scanning tools as potential problem.
In this case the memset is unnecessary.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/bus/uacce/uacce.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 9ca048122d..cc1e42d56a 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -454,7 +454,6 @@ uacce_cleanup(void)
 		dev->device.driver = NULL;
 
 free:
-		memset(dev, 0, sizeof(*dev));
 		free(dev);
 	}
 
-- 
2.47.2

