Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B04C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE0B64279A;
	Mon, 14 Sep 2026 07:52:07 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 8E52D410EE
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:06 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso2866724a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365126;
 x=1789969926; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bbZqzIiZcVBdPox3SPCPOWClMD5C53lVc1duTCzSSgk=;
 b=D9AJYlrmHZ7rhR92CSY6kXBgEJOywSAa0QnlzL75eo/jDCBOYH/Ipg9sAiP/aS3ojA
 g93mT/DJrPMFfiup+UlZ3rLvnMjUDGc1fJ7JDBpf2HSZ65eO+ZvuLQJjO8ukXW+fOVqX
 0Ov2t3uJJ8/LcgkoFqLNKLJMI/bh9Q51oiKit4eRwztaTHJEk1FWOXjHuqBN5EpMYEPr
 9fTZeuBUIC5EkJlrnOWKLjFqYjN+4zpiLpIP5886q8io+YeqpoN5JhgeAsO6NJlr4kDU
 AFpspyvq/BMhnAmzUP7cvnTvGCELuBFkzR/AFhze8GEjfGYzoT656TFfa1VAiMIAc4xZ
 VD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365126; x=1789969926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bbZqzIiZcVBdPox3SPCPOWClMD5C53lVc1duTCzSSgk=;
 b=KrncbDmOJ+bBK3y9tHYF6aSz7unVqkP12VDQXotkPMLDGYqtq4N3InRyVkMyOsmONT
 W8azL6aOns6qoXiR298WgWBghLSfT7ZPcR6bCUSSh2gi9r5UVqLLfBhQC9jzBM7fw2h/
 Lcvt6zGNc6VZBN5LIFtXEQYubFx6gJvArGH8C8nYDzc6b2iv45eY5RP0ujpgLekaSQeE
 6ZWPqUUOCVUbVlMVRpJqVh5aoku00hU7FaCLgnIkvjlMs/kS4biZKN0kbrcFSaM0+qpp
 tUWNlz4gFW4MTi92dn1onNjy4Y47t9kL39E+KiCPQznksjHBLKGa2AjkUWlB4oYsstGT
 wxEw==
X-Gm-Message-State: AFuF++mqc5riKMq7rc7Vh2gaQ+AEn5N0oHnT1PNmeFg/ALWUXKFjo5nw
 KV8Unzobue79m4inXx9NqV6GDcHgKIF2strgddkBuG1I7SWNPfAGbZQClt6RX6IlwpkA0Z6rmv7
 7oyd7TBI=
X-Gm-Gg: AYBFou30Y6HrrQ/l+S+KfPCd9RDNXI5enZGMp+mkVkL8zqB6e3UodBUxPXaLd+4Aadn
 ZuIlZp5OlIXe9/e4UP37DEW6wN4fnGPPT4dYtzSrsK+H60DkvmKzcihPHVgu+CpnyaJ/1n5CbwS
 Vb6PltROEePLcPwvfLsiQctpKAYrLdPB1i0XXCIYQq/AgDIMzNPVfIPk1hSBCFUX/VHC2N2iTDs
 WOh5VkDXs9HykPBlGOW6cHjdpLEm0u24CEeUcwteIrsR1E4NqpNxjhiDt/yy+e2oNIeVBa1+gdx
 9HJlq+w/+2FtXhdNPaWXVJ6FNWXzl1j7HMI2Dydcd1ahbOu9JOAGNFiCZJwKhgm7dkSKNyC0LTC
 4ZqYvcEoRwNNTqvk1Li4LVSuWAfvyIK+Sqo37/Tv4fN2vCJs80J4YW0QMLD7PdElo2/8hoyLdzr
 RuCvllXv/2VLJCBoLw+Gdlz2knQeoUTzE75WSnQqAIoUYMOUa3+eUyktw3huNKz29gTkDdO7FAp
 ePINB5fexZ0kZNe0KeFOL7IeYo1H2nMO+ccFw==
X-Received: by 2002:a17:90b:264d:b0:399:1f8b:d255 with SMTP id
 98e67ed59e1d1-39debf6d6cemr2658419a91.5.1789365125707; 
 Sun, 13 Sep 2026 22:52:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 48/62] net/sfc: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:19 -0700
Message-ID: <20260914054912.755403-49-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

