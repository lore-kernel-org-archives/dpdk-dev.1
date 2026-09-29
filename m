Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EB1CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:45:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E51E242FCF;
	Tue, 29 Sep 2026 18:40:39 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id ACBCF42ED8
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:39:01 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8692a8568e9so1970677b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699941;
 x=1791304741; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=daIJXiSoXKhz8lpZgwqv/Nqoyvo7VuJEdsUWf0MAOQg=;
 b=jFF2ijEow6Y/+FdWhTRuuGqnWnsNbscGdPsWvreP9CV4mJ6xEgKJktDcZGaZJVwmNB
 1Aid2ceBD6Q3aS8RMOCOYbA7ND7wb40y7fuu5elEMWxkqauBhypiqUFqmlwJ1S3UXaqM
 4R9s3OZ9MrEcwDIfZmYWV2z1AONuBDf0u09DVu8lL3Yp4XhcL160VBaTiPQ0gPD61xN6
 qRf9hFUfcSLrUTbViE6l72HqN6K1k2c65U7jXsO8SkbQD5b0r06lI5L7Gs6K09Zrl+uM
 r+Z3GjWo6Stv2XLxulb2LcemzsI5CoI/wPUdmoi6ffVS/m/khAF7htBrvhxnlwsXswu3
 6Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699941; x=1791304741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=daIJXiSoXKhz8lpZgwqv/Nqoyvo7VuJEdsUWf0MAOQg=;
 b=IQO3pdYT+lWlEMiyb0RPStSsPyMGNWykTQH8Swya4rjXuqjvkNWZAe1Y5Ei0iljxrB
 zp73pkWDE20GzNv6PE0CS3cpZG1uUvda5+QhREo5Wug5SD+xdFMJ5Bb2HeZWG0q6sSUt
 CxLD6GAz/FDWZhtxM1qPLR/jRTJ7KYetR9WUhqzDmYa1CcbHUovgQdzI7sDGjGE8i5jN
 FGUN2smR3kPqIxyNdm+OQUOxJ4PCaCLMe/9wwZwobDavhbDVBowR2NWSqSNA0VGadK2/
 K0ETISFN8LdEmwLwBZn6S7GgBp5ZJ+2LvPBFiWJg5GcFoh2wrkKrlE6CsBahOn1lhccO
 P6HA==
X-Gm-Message-State: AFuF++klF581RrkgbK+W4RDLwD1PFywpETSSO1PUos2FI7J+P4ZHPjlV
 aaRoxEPR7v4dasplOEAjDVfXytEiPC++SHN2k2we2DYWEshG7nGV4euli0c7kMqIc/mbEsc03rs
 Ix8LMmjmRLA==
X-Gm-Gg: AYBFou04wiZiojZBTZpjJKVxO6HLjVfusNxQGC97UcrPJv7e7kSHhy/OU/aSOL3FO/M
 76HU99dtU8rnrlBhK+9VfvK6oZXb3iopmPyZXlhmOb6JwLTn9pxtqKCi2d0COKkTduQ56yImHXe
 Kx3V4dQr4XEyQKEyhnBKPlwZsuO7gQ0nikeBvxRHVbxt9i7U19FIeXTn4Z6+SVQsHai3mFZrlqU
 lo3BDdqjt6yIo8XI+TxXIJJUXyQ6URjH52m3njjMwmPaAWVtDwLP9HGzj0tZYks6zoKGxmbA1BP
 TMQ1fD94QD7/3ljqHnJW8j66Pc0IXIxG5AUe3I7diO/+VV+G55T9ILidjbufpLjZgxtS6K8ZdVM
 alpnK8ImwknHKBNVVvMZ3ymivbDMUMQoY9O8VDPdN20xhyCA2YxPS4npecpqfnUc2T/6vbqgseA
 +tKN/8+gjaHN/dKzdp15b9Y+I2pb4CpNIt+spDGIHfNpOXQH8W79dRXwgPWrVWyLjdzQihb3rYO
 oVLSuOXllrnWy5CQETKpz5o0yKWR+Oo7R8NbA==
X-Received: by 2002:a05:6a00:a801:b0:878:3538:8f7a with SMTP id
 d2e1a72fcca58-87e9f8210dfmr12412772b3a.40.1790699940825; 
 Tue, 29 Sep 2026 09:39:00 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:39:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH v2 60/61] net/cxgbe: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:37:03 -0700
Message-ID: <20260929163800.1108305-61-stephen@networkplumber.org>
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

