Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED1C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:55:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54FBE42E6A;
	Mon, 14 Sep 2026 07:52:52 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 8597242E6A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:50 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so1351230a91.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365170;
 x=1789969970; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=daIJXiSoXKhz8lpZgwqv/Nqoyvo7VuJEdsUWf0MAOQg=;
 b=CUAxh7VOCzvJtCl3n2ht5CHvfty+t2QLr3+9Y1U3eQCehS/sYn3OcU4i1qJyjS+I1E
 g2Xsg0mxF0Fj2vdo8M6WZeWHfFfAmkhrQx8k6qJ1RH8T02UfBPlLFD1ITPbmix35Lsxp
 KnwRoGT756W+BNfw8ob+RMzNS9E4t/EpJTMvA5IaOWRSIVDibfER83bwq1EiWQhMuwlB
 ArgsEse/kBqgua6IUoDCMpmozRH13o/MWEzO+E8LkGoK28Rijqq2rfzusocjRHY//IPN
 PXzVNj1BZpfb0ZZr/0hPPnM00YMO7EP/+m9kSieSE11r0u27etSKZTBzhiOAbMhpVxGJ
 9fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365170; x=1789969970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=daIJXiSoXKhz8lpZgwqv/Nqoyvo7VuJEdsUWf0MAOQg=;
 b=lbBBil7UcFJiQig8t7lbWDF9QsFCMW/R9QDXSEZqECoKjo6nOs4Vub96U96PgFjntg
 rwcZFUoyMFhISIDUpk36ucbXdbMWSk3bHGk59hgVWamqf0JsahbmGCQNyYiFjRojVkA8
 gXeSyDmihK7KBTaGpZac5Ag5Ye5enjOVExxIli+k2Q7r3DnaDVI3aZa2xxS9N7fnqzyv
 cr8G9wmJUu3KS+Abi8C002+xcv4aCMCEwj356kd/9o0Kz772EfSWpUXG+AbgZXSYdGWk
 0VErRKQbKtmYm2hlI6iwPuwNIyZpXZ6cU8gRybgigRbgkbk+kVDSSTw6O4ZlHz5LUIDK
 A4JA==
X-Gm-Message-State: AFuF++nCzceAWuxaKqI9arFarsqjXki1TgLe1KBptv3WsmfJKY+NAYt0
 6BuIHJ3iSfZwDD6Y7rad5+ZX/bSXtMQS8QEJWfdSxIVn1rjumSdLsqZRI1nj7VIGiT+f2Rd/SK/
 Xn/fc
X-Gm-Gg: AYBFou3ZNXN2/2Zq2BPwQfk874yCcmzZLGJP09s3jENOZLXJqZP3oECbWZpo49H1jIh
 HGMOMiL5FCyCByInfvqrDsTwjkixAZ8SQYQx9cBOhPzlWtYiFktdhsEARpXOsbEChEyUFA1PBDO
 21qr7NgC4OaZcU1vmPNzCkJ6bVNrS9SRXKKxNaeB6OIHzdrfXRTKj2NhxidHeVe9dZ2LERxNLsB
 5BnSEtJBmp27xdJIUInnpUQHWyFDaVNT1W74aad8luTzBMhzm2G+C3I+rsYSReq4WUA7YmKo54J
 3jlPbWvtZoPoPtQ4an+dKoPOC8Vczkg39Ne0Rl7hvBqgyq6TYKe5gZTqBpF1ZZnYWh0VgLC9wd0
 nmRAIrTuKBQ7YD991HQ43Y0VWzknTTxZBG2oPKAhY1PJroCxswdaNkDT3Jy3nHGrxbuev5CQr57
 1pqYE0Kl+Scllk9wh5FzWpD5UfhSmRxYqj7QnOIqXCYp+ovM0QJASyXSIgt7truy1NykMzRWfVK
 rB/MdomByA9XF05fyLYuHlkajnhPzf+U+ASSw==
X-Received: by 2002:a17:90b:1d4f:b0:39d:ee45:9bec with SMTP id
 98e67ed59e1d1-39dee459e57mr1593994a91.22.1789365169662; 
 Sun, 13 Sep 2026 22:52:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH 61/62] net/cxgbe: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:32 -0700
Message-ID: <20260914054912.755403-62-stephen@networkplumber.org>
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

check_devargs_handler() is a single handler shared by all five device
arguments, which dispatches on the key to decide how to parse the value.

The dispatch is done with strncmp(key, NAME, strlen(key)), which compares
only as many bytes as the key given by the user is long, so a short key
matches a longer name by prefix. That is harmless today because
rte_kvargs_process() has already selected the pairs by exact key, but it
means the handler cannot tell which argument it was called for except by
accident.

The filtermode and filtermask branch checks errno without clearing it
first, so a stale ERANGE from unrelated earlier code rejects a valid
mask. The boolean branch tests only for "1" and silently ignores
anything else, so "keep_ovlan=yes" leaves the default in place without
complaint.

Pass the handler to cxgbe_get_devargs() instead of having one handler
work out what it was called for: rte_kvargs_handle_hex32() for the two
masks, which are documented as hexadecimal, and rte_kvargs_handle_bool()
for the three flags.

The masks are still read as hexadecimal with or without a 0x prefix, so
"filtermode=44" is unchanged. The flags now also accept "y", "yes",
"on" and "true" as well as "1", and a value which is not a boolean at
all is rejected rather than ignored.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cxgbe/cxgbe_main.c | 38 ++++++----------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/net/cxgbe/cxgbe_main.c b/drivers/net/cxgbe/cxgbe_main.c
index 2ed21f2d66..e0eefae6c1 100644
--- a/drivers/net/cxgbe/cxgbe_main.c
+++ b/drivers/net/cxgbe/cxgbe_main.c
@@ -744,36 +744,8 @@ void cxgbe_print_port_info(struct adapter *adap)
 	}
 }
 
-static int check_devargs_handler(const char *key, const char *value, void *p)
-{
-	if (!strncmp(key, CXGBE_DEVARG_CMN_KEEP_OVLAN, strlen(key)) ||
-	    !strncmp(key, CXGBE_DEVARG_CMN_TX_MODE_LATENCY, strlen(key)) ||
-	    !strncmp(key, CXGBE_DEVARG_VF_FORCE_LINK_UP, strlen(key))) {
-		if (!strncmp(value, "1", 1)) {
-			bool *dst_val = (bool *)p;
-
-			*dst_val = true;
-		}
-	}
-
-	if (!strncmp(key, CXGBE_DEVARG_PF_FILTER_MODE, strlen(key)) ||
-	    !strncmp(key, CXGBE_DEVARG_PF_FILTER_MASK, strlen(key))) {
-		u32 *dst_val = (u32 *)p;
-		char *endptr = NULL;
-		u32 arg_val;
-
-		arg_val = strtoul(value, &endptr, 16);
-		if (errno || endptr == value)
-			return -EINVAL;
-
-		*dst_val = arg_val;
-	}
-
-	return 0;
-}
-
 static int cxgbe_get_devargs(struct rte_devargs *devargs, const char *key,
-			     void *p)
+			     arg_handler_t handler, void *p)
 {
 	struct rte_kvargs *kvlist;
 	int ret = 0;
@@ -788,7 +760,7 @@ static int cxgbe_get_devargs(struct rte_devargs *devargs, const char *key,
 	if (!rte_kvargs_count(kvlist, key))
 		goto out;
 
-	ret = rte_kvargs_process(kvlist, key, check_devargs_handler, p);
+	ret = rte_kvargs_process(kvlist, key, handler, p);
 
 out:
 	rte_kvargs_free(kvlist);
@@ -807,7 +779,8 @@ static void cxgbe_get_devargs_int(struct adapter *adap, bool *dst,
 	if (!pdev)
 		return;
 
-	ret = cxgbe_get_devargs(pdev->device.devargs, key, &devarg_value);
+	ret = cxgbe_get_devargs(pdev->device.devargs, key,
+				rte_kvargs_handle_bool, &devarg_value);
 	if (ret)
 		return;
 
@@ -825,7 +798,8 @@ static void cxgbe_get_devargs_u32(struct adapter *adap, u32 *dst,
 	if (!pdev)
 		return;
 
-	ret = cxgbe_get_devargs(pdev->device.devargs, key, &devarg_value);
+	ret = cxgbe_get_devargs(pdev->device.devargs, key,
+				rte_kvargs_handle_hex32, &devarg_value);
 	if (ret)
 		return;
 
-- 
2.53.0

