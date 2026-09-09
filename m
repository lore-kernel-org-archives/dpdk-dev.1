Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F79C79FB6
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 20:41:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51AFD4067D;
	Wed,  9 Sep 2026 22:41:04 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id B48054067A
 for <dev@dpdk.org>; Wed,  9 Sep 2026 22:41:02 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d9520b9155so53251645ad.3
 for <dev@dpdk.org>; Wed, 09 Sep 2026 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788986461;
 x=1789591261; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hEFEprXOBnEsD8oWCcoRF+Lcg9VGcphJyflo+kBS1RY=;
 b=s8VrIgS8ZK2eZ6SFl+gj15rPKdLHev9ggZKuXCgt1osOmJNH/XwqYC67UnDSNGL312
 FJ4zbet5Cr1afG/Y32l+2UOv77xFRaoZ3HYlxx/wCNRfwzk4i+x4xaC6HJWIxV/Ow9In
 sW4SZp3YHfz+pi48ierlMZSFUhTlDu2/QeRr53kUAoq6hbnLS7bSoonk6O6CrtSpL8wh
 DMkezpEOXImxvy7NSJ2S37M6ATLBAVvDMSChYcuvymUsVXvIzObsNrKAPLt5WYob/gyc
 D/jZFXuq3XJSKCnTZ7j/Z/6Gk9ABBoarfF+VOu7qYsvy/3ilOxlnBAHK+6FWvpCH80Ay
 Pk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986461; x=1789591261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hEFEprXOBnEsD8oWCcoRF+Lcg9VGcphJyflo+kBS1RY=;
 b=nLHidHAUHCcYvMY/sKOP5YPUp1g3a19ucilm5UE6r26AqVx6wBPQPwkHP/kljazkLm
 7C1fWrM5pkHX6Y7Yqyc9ZCD5yRhfrrrZlYF8GCz8fL6SZPpMo9Z7fPu8UepUHfNrA5LG
 nqv8hjpZLKBdmmtSRwDsEZ/zaIUweeXuuMRxnkVaNg4v6Y9xd9J0XnrMbKuG2mI4LZXv
 hDJMZirC9URVJYY5sdJNgyl1U5BQC4bylOu07Rb7ZWmZKtzK9MNc6pDzWGcQBZjicOzX
 QfuqOfjzU94zqf49/vKkULKIvyQCbYh+xmiTgBvw8NcHsd1FZSywUgLnNRYDfRP/bcWs
 2eLg==
X-Gm-Message-State: AFuF++mjfoUbd0eb77Qyj66lc8XctrBgJW8eVcANKb+0si4Kvka7gu+w
 /u1P/+rTHHteDl+ESwt4if3u6a5lR33RdrSHVZ1TsVJCbHmx5eFO8vp6lWSA22f50/+acYh/GMG
 LCOag
X-Gm-Gg: AYBFou03SmGBXT9toNOSDlfr3amxJLBIavshDYLxcaUEjDi8UPF9rNSlfytvmnpHVn+
 N3JLGQUTupc/LO9dV5VcUuDA9373tt4Y45uRk46lrKnqtxyJ0PQAfqGTW2gNCVJQCksPWMlSKH8
 1JMgN42mtEtXvfCM/wR9e2A+R7ID+Na4oeLR+lHoezPQ99Nsz+1h1PV3DWf6xQGnuBHfBJ1sOcJ
 ZDJDE425W1fMfUorpM/3m+qVFBDfqFSnB5AjTD+6QaZpRIwcvqWGNrrzVaRU/2sPv+wAUqP3pfb
 kHEvMk7ywRZ23Re+ImoNhiNPjO6OBy7pqr6BkZDWu4Nwwrgw5zLQ4uXhuGYCtkPzczJKTgCst48
 GwhGA+K4Go61GxpEVHxaEqM+fAUvAunTyJ4YB/wNvsXzJ5YU7TJM5eSJxsfx6aKQ798SKmoHbcT
 tnQCxT93gMiS+i0SL8JwTuo/2/JlXQPEoSZqoFNk/gGH7CZ7c+WbGwE61Z4Zm8FJvBRc5Ssxgz3
 j5D+pR4+mh3fd4Z4vmkhECThLtg+Lni12vpNio=
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-39b2610f2fbmr52195941a91.8.1788986461401; 
 Wed, 09 Sep 2026 13:41:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d770e4b96sm1350565a91.5.2026.09.09.13.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:41:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH] net/txgbe: validate numeric devargs
Date: Wed,  9 Sep 2026 13:40:52 -0700
Message-ID: <20260909204052.867168-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Be more careful about validating devargs numeric values.
Don't silently truncate to 16 bits, and check for empty
string or trailing garbage.

Fixes: f611dada1af8 ("net/txgbe: update link setup process of backplane NICs")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/txgbe/txgbe_ethdev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 111843023d..0734a1c63c 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -450,15 +450,21 @@ static int
 txgbe_handle_devarg(__rte_unused const char *key, const char *value,
 		  void *extra_args)
 {
-	uint16_t *n = extra_args;
+	uint16_t *arg = extra_args;
+	char *endp;
+	unsigned long num;
 
 	if (value == NULL || extra_args == NULL)
 		return -EINVAL;
 
-	*n = (uint16_t)strtoul(value, NULL, 10);
-	if (*n == USHRT_MAX && errno == ERANGE)
-		return -1;
+	errno = 0;
+	num = strtoul(value, &endp, 10);
+	if (*value == '\0' || *endp != '\0')
+		return -EINVAL;
 
+	if (num > UINT16_MAX || errno == ERANGE)
+		return -ERANGE;
+	*arg = (uint16_t)num;
 	return 0;
 }
 
-- 
2.53.0

