Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE885FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:18:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7A4B40665;
	Tue,  7 Apr 2026 17:18:01 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 9038E4025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:00 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso3605873a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575080;
 x=1776179880; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEZLuga7cpeGXIQd1/VGncWLRSe/YYuEzr+NNY08BC0=;
 b=fJZ/5G5XAT6FsTsTCEF9S4eK9h4q6WXyTI4ASOpO4B7dsaz0ZZ4dK4cs3tidGfBIIp
 FmhKvGi8sg8oNEqhe00qSiTYlvUceUXZXMHhH+AYXloTHjKNfOipQYJc8LeBgLr4t0cu
 H6Yxnw1/+Pc8w/gRQUdBhc5gyISf4RSG+uA7YQDAbtYFDgSndcF+iwa2g4opKAsjKb8g
 hwBVYYEtvoz5ku28HA8OPUZ7ta8fsk441BQKjBSgwEWseqodtvQHbgYQkisSmAXdkIEY
 1DI0dXx7VFeT7tu71k5lymE0XQalzmtGyuQxqCxYu+1EWTN5Si945mtK0IcQSXj8N5mz
 kWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575080; x=1776179880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DEZLuga7cpeGXIQd1/VGncWLRSe/YYuEzr+NNY08BC0=;
 b=F35tlbXKR7K5QLoZVfK0Cuwp5EsDkmVbjFpVdJlzBlA8e+KSl957CBGElQHo+rUTHx
 16FwrrY6co0N7hMWFvYUlNDpsfAPVTvsJQ7qrlXYzWrkF+zq3cxA2dDwEa23ratjKshW
 +u25Kq7W5RlIF1in0elXjIHfS1RiFqd6Z1ZhNrKJEqtWaJ9UloZM9HfB0Y4ZpfMH//5O
 CVRBJjJlcoNMvM+sJRxZHKsXu7uXNO9dUoHqBxM2EmaL0at1pvvrthu8eReMNn3uEhSd
 ZyWK5YY0dSgONIwUQyvwkqhWG/uFv1jtXfr//I1JyApbf6XySTO19d+4ouz88HTzg92g
 k38g==
X-Gm-Message-State: AOJu0YyIODPmdkUXnNdvXhqq6vbrNr9XAkzrEp5OYzj/M0ibW2Cw42Oy
 G7Tt5KOdeTEFXInVEPZ+5oU1P8nwJ/SFchRjtDINItyt+odd5QJiNgfVXW+Y8kgMYMryeZd3cCv
 q16+k
X-Gm-Gg: AeBDievpsLAzgnRkYytEJNQQpSgvUtz7SMjSmXxBlkFCKUf5lFkNo9R5Ehuf+jYIo1C
 kp7VJh6sb+rOrSoGYHBuPvOMdvIR6dI6MOkNdALX+yT94ngQjy1/oxhzAwZER/reXkFNaXSZZV2
 Y25FuQco19qPxd8vhDm03MzNxRlmRske/WveZAlynlvaRSQ3ns0uA1jTlXA07Yi67Be9r+9GxeM
 pPenkeh9Mz0G44r+ypSa94QR2FDgCrIFeRWy5peOI/QdsLng3Nqhtl4oyWjkg+pPcPliEvOpFiy
 5R4ZXXOnbD6CBvzi6AzWMQkWISij2n/zrcuzi6vueJlyj/HaMo225sdtPH+U6ZurHOLDnejhSB8
 ueTGTt/JhuiygWh2v2QnkC0dEqQi127oGnO58dftUl168eLexm5HC1ahCdShV6U5ghLZUsu2mF7
 WuaQ8sujq29m02GkZGlfFRC4UiCfNefT+Yi843jrbqKnI=
X-Received: by 2002:a05:6a21:339e:b0:366:19e9:f43 with SMTP id
 adf61e73a8af0-39f2ed92544mr19116091637.6.1775575079681; 
 Tue, 07 Apr 2026 08:17:59 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:17:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 06/23] examples/vmdq: resolve shadow variable warning
Date: Tue,  7 Apr 2026 08:16:02 -0700
Message-ID: <20260407151732.272195-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Rename parameter of get_eth_conf to avoid conflicting
with global variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/vmdq/main.c      | 8 ++++----
 examples/vmdq/meson.build | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/examples/vmdq/main.c b/examples/vmdq/main.c
index 12ef5bffc2..8c9d885090 100644
--- a/examples/vmdq/main.c
+++ b/examples/vmdq/main.c
@@ -135,19 +135,19 @@ static struct rte_ether_addr vmdq_ports_eth_addr[RTE_MAX_ETHPORTS];
 
  /* Building correct configuration for vdmq. 8< */
 static inline int
-get_eth_conf(struct rte_eth_conf *eth_conf, uint32_t num_pools)
+get_eth_conf(struct rte_eth_conf *eth_conf, uint32_t max_pools)
 {
 	struct rte_eth_vmdq_rx_conf conf;
 	unsigned i;
 
-	conf.nb_queue_pools = (enum rte_eth_nb_pools)num_pools;
-	conf.nb_pool_maps = num_pools;
+	conf.nb_queue_pools = (enum rte_eth_nb_pools)max_pools;
+	conf.nb_pool_maps = max_pools;
 	conf.enable_default_pool = 0;
 	conf.default_pool = 0; /* set explicit value, even if not used */
 
 	for (i = 0; i < conf.nb_pool_maps; i++) {
 		conf.pool_map[i].vlan_id = vlan_tags[i];
-		conf.pool_map[i].pools = (1UL << (i % num_pools));
+		conf.pool_map[i].pools = (1UL << (i % max_pools));
 	}
 
 	*eth_conf = vmdq_conf_default;
diff --git a/examples/vmdq/meson.build b/examples/vmdq/meson.build
index 6fcde9815c..441678bbe5 100644
--- a/examples/vmdq/meson.build
+++ b/examples/vmdq/meson.build
@@ -10,4 +10,3 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

