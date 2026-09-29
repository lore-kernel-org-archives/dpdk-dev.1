Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51008CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6996B42EEA;
	Tue, 29 Sep 2026 18:38:54 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 2C41C4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:33 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-881d9da69b1so990810b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699912;
 x=1791304712; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vPcgafvEFDD2lNnPzleYBGM772lgfV+Hr/ka2dkEPDU=;
 b=0KYslJ20w4iJveKhFlqW37Y2eM4YtqJjVrgd52rUEcioRuENzBPfi0fe+uQGnyROHx
 aSpiCv6/T9qhxHjBbttRF+p2hy65pQobFVxTlNYv46xg5t7vPYuQwx0ly3e7FBznTJ8y
 QhYUtmZp3k/VFhaw5Y91fYMD25KMgJhny/JWM52JfJdvy7Ai8l2LtgyQpPbfa6iSdzjg
 L5qQN74cIrdiMcLCqhSfCh32wiU7KOjWiL3BV19qkikHlDPdIaDt07+njCxibHRk1jiw
 ZdOi+hXh3bJtTFsIk4vy5z/RiwXzsk97raODdfgf3AO9plzLbpDh4MiFFCJVjEKLHBo+
 UfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699912; x=1791304712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vPcgafvEFDD2lNnPzleYBGM772lgfV+Hr/ka2dkEPDU=;
 b=Yp0wARr4P7knRv5aAZqCDR43yViIaXPliyM9QYMv7C2HtJHI4VDYt6160h9+zISU9I
 9AMBWTluZRb0wm7VFT5x3R/yGUvVvPwwm7S3NkBu5+y4UINeQ2qjet8nLKXiv8jbn0qF
 9tVXqlIiKTybPKa0r6iALK5spe8KeNV7GhHjCPuUt7zc7YpZsxQfgriP2cey2IYcGDVh
 3pc7kHs6ujqurFgg9rUZo0zV9cfRTNWCeP0lUKY/Dq6HkRYpxevcgtJj9Upo6UGbr9tp
 P3ci0u/hnJdkbbE3KhlBrSNUmSzXV16aQDjmnX6z2pffNe6X2Gn4/ut5VzVg/HD1IIjG
 a7tw==
X-Gm-Message-State: AFuF++nG1zPuvNOb/cdxGvXakol4yBOltw3DX4mZ2OanzFpoHn/xHpxj
 Oy0+Zxh9rYEWVneHKNEXxyT/5vC1qh+Y6OHWlCmzI1WYd+fLnwDguZ661IgZQ0IKHGyf63dzKty
 44+3lH7I=
X-Gm-Gg: AYBFou239NKTzq0oa/OZHprqdtGpC1yA03zL3x1D7WblJ5z1lWY4anYnebHu6Evvb7C
 YzIsK7dapTMKd3sR05E2Go3sNQoyFFDWsJ8AuJThFj6Fxm0ZdsDuEjg8r73yM62dueqrKMYXHGl
 fweu2ihIcBe/yo9WLShRqYNh+/c80yqjPVArUSz//81aHxxpUl0zVbte65kP5oa8/6boMl7j6m+
 mBdXtzzpvPRZt6Y65Vv4gSdDjq8hMIS8ghkyWo3ytHXlynPwE8KL+wCEvQDRDNINj82bSiTczNH
 mRWpUV4yYtOhBN/tXR0tPLFrSGeuWskiZFidQ2aqvk2XRL9bhT/VkkojBWMZd+R4bG+JNJJUIOU
 OkNi4ohhrqVAWzt1pRYzdGeFeuH1FMLhwEKhu4SLxP4g7UWKjk6VjNW46b57kFtQA5Ckag3XoL5
 PhgVmf1UF3QesRQS+Z36urVKwXIgiWhJvcznzkEBkB7yBr1ldbq7P6qBJbsfOgbOA9C2IfXfdZ+
 3Rin0hz/czxl8aEBDWIMAUr1nPokt+vfwQ6NQ==
X-Received: by 2002:a05:6a00:94f2:b0:881:931c:cf56 with SMTP id
 d2e1a72fcca58-881931cdd63mr7437932b3a.47.1790699912328; 
 Tue, 29 Sep 2026 09:38:32 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Mingxia Liu <mingxia.liu@intel.com>
Subject: [PATCH v2 27/61] net/cpfl: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:30 -0700
Message-ID: <20260929163800.1108305-28-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

parse_bool() only tested errno for ERANGE and ignored the end pointer, so
"1junk" was accepted.

It also stored through an int pointer, but both device arguments are bool
fields, so parsing either wrote four bytes into a one byte object.

The handler did nothing beyond a range checked store of a boolean, so
drop it and pass rte_kvargs_handle_bool() directly, which stores a bool
and also accepts the usual spellings such as "on" and "true".

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Bugzilla ID: 2042
Fixes: 2d823ecd671c ("net/cpfl: support device initialization")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 32e0f81d99..60ec5af31b 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_atomic.h>
+#include <rte_kvargs.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
 #include <rte_malloc.h>
@@ -1558,27 +1559,6 @@ parse_vport(const char *key, const char *value, void *args)
 	return 0;
 }
 
-static int
-parse_bool(const char *key, const char *value, void *args)
-{
-	bool *i = args;
-	char *end;
-	int num;
-
-	errno = 0;
-
-	num = strtoul(value, &end, 10);
-
-	if (errno == ERANGE || (num != 0 && num != 1)) {
-		PMD_INIT_LOG(ERR, "invalid value:\"%s\" for key:\"%s\", value must be 0 or 1",
-			value, key);
-		return -EINVAL;
-	}
-
-	*i = (num == 1);
-	return 0;
-}
-
 static int
 enlist(uint16_t *list, uint16_t *len_list, const uint16_t max_list, uint16_t val)
 {
@@ -1756,12 +1736,12 @@ cpfl_parse_devargs(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adap
 	if (ret != 0)
 		goto fail;
 
-	ret = rte_kvargs_process(kvlist, CPFL_TX_SINGLE_Q, &parse_bool,
+	ret = rte_kvargs_process_opt(kvlist, CPFL_TX_SINGLE_Q, rte_kvargs_handle_bool,
 				 &adapter->base.is_tx_singleq);
 	if (ret != 0)
 		goto fail;
 
-	ret = rte_kvargs_process(kvlist, CPFL_RX_SINGLE_Q, &parse_bool,
+	ret = rte_kvargs_process_opt(kvlist, CPFL_RX_SINGLE_Q, rte_kvargs_handle_bool,
 				 &adapter->base.is_rx_singleq);
 	if (ret != 0)
 		goto fail;
-- 
2.53.0

