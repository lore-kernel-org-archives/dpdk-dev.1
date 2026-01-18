Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81986D4A5F4
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 17:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0BDB4066D;
	Sun, 18 Jan 2026 17:59:54 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 34A9440669
 for <dev@dpdk.org>; Sun, 18 Jan 2026 17:59:54 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47ee4338e01so14286295e9.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755594;
 x=1769360394; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=Ak7ElmG0yfk0HIqRpr9wD7lY7Qwykg91DpJhKzb5x6+6k1qY9Xsvoxil3ZW03I0KKd
 rb/B8YErLvshMTK8fqPTyhjiznADtzgN6YKGhuQSjstSog7SIhu8dlv/4LLV2CT3Es5R
 EbukaBnqzd2KgxIVdiP74EE9LSj65H/O3u9Ot7iI7TduTRvqTbuSBx4ujrxDHk/7PpXf
 iyNniMIqdn0UTFjhnJY3OLka0QohyxEHlsc8q1KxI2u6XaSFL3w9FtjrNyuN231zCLMN
 /SglK75zL7aFvu/gVqaDwJMUdvvymM8j4282zFmSAIYg08cM9eAlq7fY6BMTsfbgQuyO
 QMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755594; x=1769360394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cd7akozSsdeQa0U3i8382NeuuwGw6toUTFm7mBxAmKM=;
 b=hGFv+QRbTbQdAgPyD6XbPzHFkKKzcrMrVBft4yWytpDoNdh2U1GxWa62bvNFR3ve0A
 Y/oNb5MBVlII3tcGCRR1+UN1D4sF8NFAKGRxAv+7FF8QinzsPihzn6L/8Vc+Q8xTyTJc
 Av+ShzFDI7CHFwvk7A1oD3lM77biXelVhCt+pbqIYAATDjsUK62g/Do2QMVVyPpc9kU4
 tUAKWvvQCnUgUuAC6Z60JePeI47iQd0o/KqXmqN5dnThK+IdQASipmdUb2QLgWCQXQ+f
 LBTd75VhoOuByqqMPaDysXktQRbZZNWaamvOep8r8cV2OfUqpmDeJI12Wn0wA3KYMgsD
 8VcQ==
X-Gm-Message-State: AOJu0YzpZoFxpeyTT9+3L5rtWQ3a/m/YJgJNjKBmw2VP9sxFO5YmQ906
 NaBweR7JH+lOQ/FdsZTmg4b0DB6mv6X1uG6znAY99B6dJquKzhP+XTuFGHOSFomkXv9cFTMkSoD
 iAaUA
X-Gm-Gg: AY/fxX6sI7uNKxO5f18qOIcOClJJpre+QM7uT+bwWfgmZ85z+vM+WLeyrVil7R8zv9B
 DbQob2p6WDNaxNmDqARRb+X1LCqMS2v2yMOeFXN0MWMV7utIcJqGAWv9mcLTTJfpaN9mg5J4xmE
 NAl3UK61vlQMZFnAH2PY7dLUjtlega+QazQde+QJhAkOIj93AEKYDxdjpLvTOk+uRoKLkDOWgKA
 PzAh6t3qKOYfIQ+snrSuBMsy+Al2KAzNT13Rdr/MqOf5Y2kaOfgY7aCQZHmrcD+SdqFc2ZTJnLe
 6XpA4vQVWTpPdwVAd0mCtu7M2uq2rpVojvad/R8hy5iNxX8XEXXLKtzmMHqR1Ua0cNBtYVPyIcn
 9tPoRrtDzk833uLt+nlJfh+nJJ0qqgvD4HttOQTEzhcvKYYizvuP6elj57ufiyaoBy++J8GJcMs
 jXr87VbZ6hhjvS3VKw/Z63uhB/ChpSzn3KcdWWaci8YLdV/21mjA==
X-Received: by 2002:a05:600c:34d6:b0:47e:e20e:bbb7 with SMTP id
 5b1f17b1804b1-4801eb1080amr105754445e9.25.1768755593817; 
 Sun, 18 Jan 2026 08:59:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.08.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:59:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 02/11] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Sun, 18 Jan 2026 08:58:37 -0800
Message-ID: <20260118165944.41374-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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

No need to use rte_malloc or rte_memcpy in the short
code to get MAC address.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_osdep_freebsd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 20556b3e92..32e4a2bee7 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -8,9 +8,6 @@
 #include <net/if_dl.h>
 #include <sys/sysctl.h>
 
-#include <rte_malloc.h>
-#include <rte_memcpy.h>
-
 #include "pcap_osdep.h"
 
 int
@@ -41,19 +38,19 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	if (len == 0)
 		return -1;
 
-	buf = rte_malloc(NULL, len, 0);
+	buf = malloc(len);
 	if (!buf)
 		return -1;
 
 	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
-		rte_free(buf);
+		free(buf);
 		return -1;
 	}
 	ifm = (struct if_msghdr *)buf;
 	sdl = (struct sockaddr_dl *)(ifm + 1);
 
-	rte_memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
+	memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
 
-	rte_free(buf);
+	free(buf);
 	return 0;
 }
-- 
2.51.0

