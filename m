Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590CECA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1F5F42FE9;
	Thu,  1 Oct 2026 00:44:38 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 5E16342FB2
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:35 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so3309887a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808274;
 x=1791413074; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bbZqzIiZcVBdPox3SPCPOWClMD5C53lVc1duTCzSSgk=;
 b=AjtPtOoVHwDVnPhjuaTs0w6GSNb1opWAgFg/azFQPGgFo9c/h+N/5auVpyGtQqRW/d
 KGgyQs7/DfK2u9Wn1sYlG3CEyOn/iwBqmmFs/C1gd3GuoL0AJm5gyLLyognwyG0JqkEu
 XABf5azn6vWLpfzSga0y4QMcpsiD2RW1pcuBnBPrLYnwhw8m+ffacTd0nzN0LpQMvVD3
 IIklLlyKUsjQrYGP1KLBYxf1s/bA3ZuxUfSF1U5CtpzJUWI4RM4dsiTbAJohACOEeH+l
 Jd8a3+0ewn+JKAwDilMIL9B6IXnANpLGtryiB5D1yAHH0Wytc8zHO5VtcjBGr8WbAFsr
 HPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808274; x=1791413074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bbZqzIiZcVBdPox3SPCPOWClMD5C53lVc1duTCzSSgk=;
 b=q0O8bQzSMfaLofSddq4gQqgK187qze3CT+oZK4DBlK2kTaoTRMEX+80aRp4vH8aGU4
 /7CCUkteqX3DAlAuX0quTCv42BOsIt1RHVhxLcPAm3Vql1D+mGeojnuQsdRK3B4h9R7o
 NAwdzntZ4dsBbOmnMN+T9PumrAi94J5//ffG+1uQar01dylSCAJ4jlxql1aMDFXjHgf9
 gHVsDzDatB3hCwcRp87pcszh/Da+5QYewArW9g+A0+MXK034NQ4PHrVpfxnLEDVQNutC
 2SEl1EUtT2vXsqHn5+Qnd6Sl4N1t2BUBvE2ZQtbbvQFhvjJZLEZxEgqYbz47O0ngsefh
 Zmag==
X-Gm-Message-State: AFq9FYJW21Vr9xblNQ//4ZaI+VaBtrnbHdzDlOlxzbN1Jh5sfxHjyWbx
 ZzD60X6JNU+ckf/F67+LWs6lsW6JfDiNeY4hciAoW4yCoaailfZUx1Vx5BpP4nLMmQyaafKulti
 20Hl0O/s=
X-Gm-Gg: AYBFou2iTlj2F4+SXBlesf60DpubWuNFFsUdSh2+fil4DH5bslvRsj+jt6pta1BU7pM
 pEgGJ9Vrt7geJQAbbGx3h3XNlOur4X33goobouil8gkHkP4D+/weGyxCriG+nKuhpdBJHi2RwnM
 5naj8BlOKzwNDe/XGBA6l4eX3B97Nncz1Yh033bc+6PCjeJ5k27F/wfgFkJtwoMetT45Pl1RZcC
 mycL+s5JOjpSAx1X6sUDqFRqpb/64mdHaw2FpebNsBKv0m+BBc6Vy0uNvcEuIfhFWSPlMs8cH5Y
 sdOEXaK9DIfCGQ1jyENDqFzRtxUmce58uqEJ11vNCTCpY190eyd7RjM8ErR+1RSIwbFgGJCZXmB
 7+d9B5nIkFcf+Np65Wlr+HYGP3guqY6bCT4Y+fF4HjRel6aVO+TqPXeIDUvXYN2RAkmEurnDGBy
 WI0jr/EscXlZUKbtCHNx0sdvItCuJ+6ilqp7oFC4C0KRejXFCBuPReSRsPLQPFle0tOZ4spuazV
 k4Fik9ikDh3JY7LvOfdvRjikVKHmr7UpztPUg==
X-Received: by 2002:a17:90b:258b:b0:3a0:a4fb:e738 with SMTP id
 98e67ed59e1d1-3a4d1b97940mr2546147a91.54.1790808274474; 
 Wed, 30 Sep 2026 15:44:34 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 48/65] net/sfc: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:06 -0700
Message-ID: <20260930224340.58580-49-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

sfc_kvarg_long_handler() only checked that strtol() consumed at least one
character, so trailing garbage such as "5abc" was accepted, and errno was
never checked, so an out of range value was silently taken as LONG_MAX or
LONG_MIN.

It did nothing beyond that conversion, so drop it and use the new
rte_kvargs_handle_long(). The callers keep their long variables and their
own range checks.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sfc/sfc.c        |  2 +-
 drivers/net/sfc/sfc_kvargs.c | 19 -------------------
 drivers/net/sfc/sfc_kvargs.h |  2 --
 drivers/net/sfc/sfc_port.c   |  2 +-
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/net/sfc/sfc.c b/drivers/net/sfc/sfc.c
index 39cd8d519a..3d460cc222 100644
--- a/drivers/net/sfc/sfc.c
+++ b/drivers/net/sfc/sfc.c
@@ -1213,7 +1213,7 @@ sfc_kvarg_rxd_wait_timeout_ns(struct sfc_adapter *sa)
 	value = SFC_RXD_WAIT_TIMEOUT_NS_DEF;
 
 	rc = sfc_kvargs_process(sa, SFC_KVARG_RXD_WAIT_TIMEOUT_NS,
-				sfc_kvarg_long_handler, &value);
+				rte_kvargs_handle_long, &value);
 	if (rc != 0)
 		return rc;
 
diff --git a/drivers/net/sfc/sfc_kvargs.c b/drivers/net/sfc/sfc_kvargs.c
index eb36fa98ca..d67f822dd2 100644
--- a/drivers/net/sfc/sfc_kvargs.c
+++ b/drivers/net/sfc/sfc_kvargs.c
@@ -107,25 +107,6 @@ sfc_kvarg_bool_handler(__rte_unused const char *key,
 	return 0;
 }
 
-int
-sfc_kvarg_long_handler(__rte_unused const char *key,
-		       const char *value_str, void *opaque)
-{
-	long value;
-	char *endptr;
-
-	if (!opaque)
-		return -EINVAL;
-
-	value = strtol(value_str, &endptr, 0);
-	if (endptr == value_str)
-		return -EINVAL;
-
-	*(long *)opaque = value;
-
-	return 0;
-}
-
 int
 sfc_kvarg_string_handler(__rte_unused const char *key,
 			 const char *value_str, void *opaque)
diff --git a/drivers/net/sfc/sfc_kvargs.h b/drivers/net/sfc/sfc_kvargs.h
index 4dcc61e973..99de772d2d 100644
--- a/drivers/net/sfc/sfc_kvargs.h
+++ b/drivers/net/sfc/sfc_kvargs.h
@@ -88,8 +88,6 @@ int sfc_kvargs_process_opt(struct sfc_adapter *sa, const char *key_match,
 
 int sfc_kvarg_bool_handler(const char *key, const char *value_str,
 			   void *opaque);
-int sfc_kvarg_long_handler(const char *key, const char *value_str,
-			   void *opaque);
 int sfc_kvarg_string_handler(const char *key, const char *value_str,
 			     void *opaque);
 
diff --git a/drivers/net/sfc/sfc_port.c b/drivers/net/sfc/sfc_port.c
index 33b53f7ac8..d0652b612b 100644
--- a/drivers/net/sfc/sfc_port.c
+++ b/drivers/net/sfc/sfc_port.c
@@ -488,7 +488,7 @@ sfc_port_attach(struct sfc_adapter *sa)
 	kvarg_stats_update_period_ms = SFC_MAC_STATS_UPDATE_PERIOD_MS_DEF;
 
 	rc = sfc_kvargs_process(sa, SFC_KVARG_STATS_UPDATE_PERIOD_MS,
-				sfc_kvarg_long_handler,
+				rte_kvargs_handle_long,
 				&kvarg_stats_update_period_ms);
 	if ((rc == 0) &&
 	    ((kvarg_stats_update_period_ms < 0) ||
-- 
2.53.0

