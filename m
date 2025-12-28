Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A05ED3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:21:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D98A040B8D;
	Sun, 28 Dec 2025 21:20:06 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 7673F40A7A
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:20:04 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso37260785e9.1
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953204;
 x=1767558004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=ZczF8zPkUtQFEoUFIntxuaKrb+d5a/CxB5lUQxBDmQpssB/5p8tN78tWJ3uBAKZL25
 MtZRTaYok8h2jA32eJissgHr6y5s8wMrlEU2+khbS2dmwfX0LT3OrqiXoXZiTce2Xo2H
 NvQbarMh0vQLAZe5yA2oht4FGdjkFZ1JL0/HzA2eS/1k20u0SolBp61GI1TVTNriwR4m
 f7QSq9wehub+LeKjy1Dl+Tudy5mqMM+S1/sy9vY2RLjKsjlSOr8OCk0VrO9DQ2rCn+rQ
 0fegvz1uGen/5PrV8ycMn2mtxqzHr2RNK3iolhrj6URJK87UlrsjQk8qE0NNW+VWWEWm
 hw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953204; x=1767558004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=tc4pPRttWKBQOK5/25wO/rV4UvTGs3b5634mEronkQ9G6ldk7fwd/02MwauGQQOCMs
 6dE6zQVOoHnkPcFrkUa1INuIPKs50LCeFlywHiMmxUUPmQxEVQ9qSG9CoPRF8ot8OQsy
 JiF8JeNUwGIIkXG8ddN8OSXGiNhqqiA2MmCFda7SwLdR14GXNbtM4JJW/XkPEYW8UqZd
 dRVCFaCUU2+XKDnoJC5DSrpZE/w8ceG2LwGJ7XIVdFYsuEXPhtT9iJSRvlluytmaTut0
 NBRNoRyxq9iEm50A69C53V52+UrwV6DtWMvR/mOhfhjlNsZZLd7OIMWEC2Uufx1mgtS+
 L+cg==
X-Gm-Message-State: AOJu0YyCmD0Pfi7m+MAjX+naubqX8rUDxZZnBZ8GuPS5vhrsZSi7b/C2
 R4jzMdHz37gH+J4ExIeoMFo+RHF1Z4vJmD8klDGHMwl/kkyMptQD5Whhwu4uD3F+zT9Mx0mXdLg
 zwi5P/6k=
X-Gm-Gg: AY/fxX4OXCDitRq6XaMkJvwPMtr6RpUolv+WGkCHDUGqKQvuwX7HdLF/5i3T8jhjRaD
 +sapGzpJwxeT+EIZ04yEjdVJLcT9IBiDdUO4H4Szfl6IOI6V7ymxaMpcHM/+ksL+pA5XhDlDZI0
 Ae0DYwr913e/EwNU9ofwzVac7k935GOHnkuzc/aZGEtWWTbBaPlhr7h+5Lu4J4iwtwad0gGkfYF
 QDfO0/IovY4DP+pt3fSQHSWNzv0smGLhAkITkpmcQz9P6XegaNeIfs12QHNApX9XCfPjZXvhKYv
 czEtPylAmxDeM4fFUhotIFqwANGOhUU/JtfR+4IbSENz2dj981Cd85RBik2Rujn77b1vZn/aQfV
 5WPgnFyvURDo+gW5PPk8JYNY+dhrn59TV/YqyHI9n5cOzFKBJnLpU78neTsb+cD9LHPyw9XiBJA
 f3C7FDHdqESpSNCYKLN6VPoiQzNKbdOxgfF7wgjW6rB0llxZex9y14xV6FryOr
X-Google-Smtp-Source: AGHT+IGesLywOPswnq8zQRbk86BVHL6chHYTXmAib89bBMA7BYKraRLwt2VDgviQISWuP002aMccyg==
X-Received: by 2002:a05:600c:828d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d1954a14dmr334142405e9.9.1766953204075; 
 Sun, 28 Dec 2025 12:20:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:20:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v8 16/18] vhost: check for overflow in xstat name
Date: Sun, 28 Dec 2025 10:56:19 -0800
Message-ID: <20251228201236.547268-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

