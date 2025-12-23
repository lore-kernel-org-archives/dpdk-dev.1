Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F4DE6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:16:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54590406B4;
	Tue, 23 Dec 2025 19:14:53 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 1091E4069F
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:50 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so955051466b.1
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513690;
 x=1767118490; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=oMMe7WpC/iNZQ4keVZnC6KXb0UACjrccOZPt/0L4hOmh2bAygDPM75PGpkVQr8zzIa
 fZLpUgCeAQ1wa/EeYLupOY174/sfLWEeoiX8UOi+YivVvSqzbpmkc0Zx0tcGmvQK/+L0
 QsrbiEaMt67QBFqcXxgz5nkwB1zakk0KBPNXCUMuwdAGjXnXUFILzVYWvLha9y6gxCp/
 1IZBUO38Y+AT23WRzOEiu3PgZn3+Ipqes9Cz5tykeJ0+mtFjB3KQWTwESnMnCA9Zsz/X
 e43y00w0XWXXnRAhdSLjrM/NZfTXVm1xegGWKuOE5S9+/oMsWE1n0m1w7/OOGnH97dst
 zzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513690; x=1767118490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKp1X4rFlug1AFpiyy0DPS6oNK1tESDzYaGwfxLvZh4=;
 b=ZqVOoHhG4a8X8khGh8tDSqDrJDRPL6rL5pQbwy6tL1v31ZcylBTmMIhNpR40ZDjWCu
 cUJFxrIQQ2gyO4c18OqID4QJmtDN55133T8aushv1g5imJYe3cwK1t3MB4cYzhEvD23w
 XrqhkvmAJ1uFNNYDjdhmG6dxSELz54M+XPjHE1fZj6lcz/oac4/O1Cx4HzNzQXWWtg3j
 kKeH4y6T1s0BiUv02EgkSD19gxb3xXAhLcdcGDSEHO9DsIOVV539s+T2dBNSDrItoAfq
 6ZGxk8Bh1MnM3hVB6EIijgIrKTKElWsuoXNqDBGr6HrsLGm0Kr/wC1g3tJqx3O8VGmXn
 zFow==
X-Gm-Message-State: AOJu0Yz3Zoe6E5fiTJsn71no7ssW6xNF78DDFHum1xKS97R4xm7x7QKU
 wgW5yjN4lx2djqvKGUMeSw5h/WsRAH7gnk6oUHl+//m3yGgKVpelh2xklVNzp6MWol2LFfi6IUy
 uGwAdFQQ=
X-Gm-Gg: AY/fxX4V0mz2J2JahSbIkWn74sls7Cd0q4rKqhKsmMvC84A7/d16BqkegQTP6LkS25i
 ep4K0R4OYW4NaIyxQZIivONW+WpOI0FaKDhPkoNrtUmUHszNRK9Ohp5kg7vJsyR9opXyjN5BYiI
 1vIU4wvrKAWdgwd/S6VHIxVBFOdMfLR3TBW+8mGuU2q5QdHhoFm+qKgWSZK5gf/i/BRwsH0Puz5
 tepw+xWlqEAK/8BcGdN2DchekUaOS3zsKxUcFEoqGnnq26IfArdmM1MZXmVWV4XcIAaorw5xJjB
 b3vkChVOsaaY64uwgk1zx9l0odqrhkoiJNf6SWpSLmWq/kfxsQcQ5HF+0shf9osjfx1RreYxGSL
 dDnegX3lPevmg546GorwAbIFs/QEa/vQfiqgF3NL5N5Wv41M50fk77v82060fe0qQlbrhyB2TUf
 CHrpDwj/sLPVLVoyz42hsdi805ocPqoU6A3yQbwoQuQqwwezMAatPvFPXjrpLY
X-Google-Smtp-Source: AGHT+IGQjbRUGBUZbxX9B9mvXZ2r14wKbc9CBisIfxiLevq1bIspLrojxl4Cz9X/FUixWs/DwS14HA==
X-Received: by 2002:a17:907:a4b:b0:b73:210a:44e with SMTP id
 a640c23a62f3a-b803717902bmr1660054166b.30.1766513689624; 
 Tue, 23 Dec 2025 10:14:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 16/18] vhost: check for overflow in xstat name
Date: Tue, 23 Dec 2025 10:13:14 -0800
Message-ID: <20251223181418.40834-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

