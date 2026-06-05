Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C65CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 17:46:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E823D402E0;
	Fri,  5 Jun 2026 19:46:43 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 0FD3F4021F
 for <dev@dpdk.org>; Fri,  5 Jun 2026 19:46:42 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304cf518c9dso2801148eec.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780681602;
 x=1781286402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lASHN9Id+KPFwFW1YeXOgFPd4y83qTz0uJAw3HW+5aE=;
 b=zPMqy7h2wD/wjC78jnUl/1BwzxvPbnNnxRcvsn/5KM9C0DbkzApNq29u6/Qz6GMHq5
 t60V6ptVsbJ7Jkxnir6v3P+qvq5j8DpLqhVGpDm6x2vDKqNrKtPzsNJsoyhbMD7HBm85
 Ye/XWHjEDfeog4Q4eZbcQz7bZ32iRZ2orcGOxzHT8WMVB7TUlKZ9pvWeRBm45GjmkkAG
 255brLTg/UV3nFdD7rSucMxVsV+Xf6LKod5KXjn0VgrYOmqMNPaO1P++6+R3+GiR2PW1
 v9ndECpwpbVHGGJp3+07Z0u0+0lAc6zkSiqEpOqfg/lnkKoToW7KrhmnZLvRWEXyNqz4
 VDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780681602; x=1781286402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lASHN9Id+KPFwFW1YeXOgFPd4y83qTz0uJAw3HW+5aE=;
 b=YQ4k+6MgHLvrBkKQUV8iqywzUAXLtsl9Iai6ogP8EQkSyMtuANZW1d0pB2eWM6O6Z+
 SL7i+GBbtbm0ouSPY+3Y3Sz/mENTeeMOWS8xJTnVzDRz278EH3hP3Lf90GEWwdC2TVqQ
 kX5305sU+jXOm0km+SgxF2o9ojryxBZaGATtyQdp+mmUW4iGrk7S6ZyX/InytrrDtJbO
 PMsYddCiSv/2xwSQPC6mbwjR14fIBrhoc0mi0EJn7DKpfm9MIF4OI9SiyHQiHtp0pTkZ
 YlfnpitnyExPNcMazIOsGXNa3qS61YUCmHfN6qWXEvUo7bc+BFowxVk5vboqm5U7gkrG
 FhWQ==
X-Gm-Message-State: AOJu0YyA77xnbgLwruOdIo1ER9bOywCDo7MBligX2UQg5NsbUQ04R+8A
 amkJMK2GNiYL9ol+corP8oQzg8AJ2okUmj775DdA0I0U25SVblqFYoUaMywvMsMhlNYQYMHz4th
 Q2V/h
X-Gm-Gg: Acq92OHH3V1Yg6rOY3gQc+IsafzzmFDUBcCnhcLgFgZL/WGnIxOUoBbCTSC/znSjWAy
 /Ad16v2+atdRvOUfTl0KQAqHspsJ9OQlnH4hBJ6KKDydV92ztQtQ4zH8EfbJ/gro6To2y5w9cEO
 1iNiSPC6044omgCE75Q6hO+FqLx/Se/ptN3NLZKcwA7z1QNIr1LZxXxqQMxMnnb24bI4klzMtlE
 DlBTDQY0iETIPjJCXQ/+X280xfYL2OTA1WYFf7SEAJRRFafpvnep2SKqYY3DNbI3soknOOOhcQV
 j6MIet6thTjAXKtxJG96erx50uDFXPC9Jo2qZF7pWQnyej+Et/qoU4teV6lqb5M4tKT4mDEQkQz
 Xc+9mX5bD6WVHbTDcqQzof6Qv4luKWEqdgRmhdJ4FWVCB4d8tRmQ70bnnv0KjzprEgRzF/esk+L
 gJlxJy3yAi3ozs/nOUG8uvHjBuJftKvQj9duYR3q+r5/JPD/+w4QtZjmbuDWrEI5mmPbkssnn8t
 y/hUTqE7gk=
X-Received: by 2002:a05:7300:ec15:b0:2ed:e14:7f5c with SMTP id
 5a478bee46e88-3077b2d99efmr2341792eec.32.1780681601768; 
 Fri, 05 Jun 2026 10:46:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df8076csm8933759eec.29.2026.06.05.10.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 10:46:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH] security: harden telemetry parameter parsing
Date: Fri,  5 Jun 2026 10:46:36 -0700
Message-ID: <20260605174636.218232-1-stephen@networkplumber.org>
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

The cryptodev security telemetry handlers parsed dev_id/capa_id with
strtoul() and no overflow or range check, so an out-of-range dev_id
(e.g. 256) silently truncated to a valid device in
rte_cryptodev_is_valid_dev(). isdigit() was also called on a plain
(signed) char, which is undefined for high-bit input.
The parser was also using strtok() which is not thread safe.

Use a validated parse helper and reject malformed input rather than
logging and continuing. This also drops the thread-unsafe strtok() in
the crypto_caps handler.

Fixes: 259ca6d1617f ("security: add telemetry endpoint for capabilities")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/security/rte_security.c | 41 ++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index c47fe44da0..0d89f8af3f 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -7,6 +7,8 @@
 #include <stdalign.h>
 #include <ctype.h>
 #include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
 
 #include <eal_export.h>
 #include <rte_cryptodev.h>
@@ -474,6 +476,25 @@ security_capabilities_from_dev_id(int dev_id, const void **caps)
 	return 0;
 }
 
+/* Parse an unsigned integer parameter, returning the value or -EINVAL.
+ * 'max' must be <= INT_MAX.
+ */
+static int
+telemetry_parse_uint(const char *str, char **end, unsigned long max)
+{
+	unsigned long val;
+
+	if (str == NULL || !isdigit((unsigned char)*str))
+		return -EINVAL;
+
+	errno = 0;
+	val = strtoul(str, end, 0);
+	if (errno != 0 || val > max)
+		return -EINVAL;
+
+	return (int)val;
+}
+
 static int
 security_handle_cryptodev_sec_caps(const char *cmd __rte_unused, const char *params,
 				   struct rte_tel_data *d)
@@ -485,13 +506,10 @@ security_handle_cryptodev_sec_caps(const char *cmd __rte_unused, const char *par
 	int dev_id;
 	int rc;
 
-	if (!params || strlen(params) == 0 || !isdigit(*params))
+	dev_id = telemetry_parse_uint(params, &end_param, RTE_CRYPTO_MAX_DEVS - 1);
+	if (dev_id < 0 || *end_param != '\0')
 		return -EINVAL;
 
-	dev_id = strtoul(params, &end_param, 0);
-	if (*end_param != '\0')
-		CDEV_LOG_ERR("Extra parameters passed to command, ignoring");
-
 	rc = security_capabilities_from_dev_id(dev_id, (void *)&capabilities);
 	if (rc < 0)
 		return rc;
@@ -513,24 +531,19 @@ security_handle_cryptodev_crypto_caps(const char *cmd __rte_unused, const char *
 {
 	const struct rte_security_capability *capabilities;
 	struct rte_tel_data *crypto_caps;
-	const char *capa_param;
 	int dev_id, capa_id;
 	int crypto_caps_n;
 	char *end_param;
 	int rc;
 
-	if (!params || strlen(params) == 0 || !isdigit(*params))
+	dev_id = telemetry_parse_uint(params, &end_param, RTE_CRYPTO_MAX_DEVS - 1);
+	if (dev_id < 0 || *end_param != ',')
 		return -EINVAL;
 
-	dev_id = strtoul(params, &end_param, 0);
-	capa_param = strtok(end_param, ",");
-	if (!capa_param || strlen(capa_param) == 0 || !isdigit(*capa_param))
+	capa_id = telemetry_parse_uint(end_param + 1, &end_param, INT_MAX);
+	if (capa_id < 0 || *end_param != '\0')
 		return -EINVAL;
 
-	capa_id = strtoul(capa_param, &end_param, 0);
-	if (*end_param != '\0')
-		CDEV_LOG_ERR("Extra parameters passed to command, ignoring");
-
 	rc = security_capabilities_from_dev_id(dev_id, (void *)&capabilities);
 	if (rc < 0)
 		return rc;
-- 
2.53.0

