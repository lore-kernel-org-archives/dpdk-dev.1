Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD3CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 20:53:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0071B40677;
	Fri,  5 Jun 2026 22:53:06 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3FC2240677
 for <dev@dpdk.org>; Fri,  5 Jun 2026 22:53:04 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51778069c31so18027311cf.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780692783;
 x=1781297583; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lASHN9Id+KPFwFW1YeXOgFPd4y83qTz0uJAw3HW+5aE=;
 b=YPEoJUTpVpZf6zd0k4Jo/7KMDMIhHwteq1RntW6CVdS0XLNsOMioEXUS6Nh6aPJwyJ
 8tmFfKeT5UjGfvyPetAoX5H6GzF1W3puChNS59t6+r1OLlyx+MD6iili1PuMfssB4Hay
 9jU5XQ7Yfl1DMkqx9nEJy/fB43jNeQ1Toe3QGcDxNgsX3pqSv8e7jMBziF6pAxSSPw7a
 mAzS+LRv5Te7/69RQqCHGdtlaAG0DxFSERYcr57bAnxUfaMWP/6FA4t8O/urMU7NwgLG
 dE07jNLu8dMPLRhlPK5Co2TlmGARLkcosprRXEe42mWmoSSNj7Vz3sKvTfQfkmZxBD8U
 KTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780692783; x=1781297583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lASHN9Id+KPFwFW1YeXOgFPd4y83qTz0uJAw3HW+5aE=;
 b=hw1vpesg/z6WP0iYklN6F6lf0V74erp7hIEVgauBbY4kNHivDvbtQh6LmtzZnU7ivv
 j13QiNOy+FYdApEA7a2fWc9KeuTSeXOOxDiUqfvVnO6urBsyk+/BgcsDAiVo3emBCChk
 Ab5NeqYTDCMScFsAGzvtT37Ub2j+6V/Y5GrMapun38ur0kmvqRqZBPyDeXUDXZyOMqL0
 nH/vJbKgrOB6vl/bJO7XiBXXi+Lg3uk2qZ4QXthnAK6t0c1uk+h3tBATrVnMFZfZfi5q
 283ef9b7k5YBieQts3uAbD4m4k1lH0p9Qqdob9yXCpn8uNV2JNKKEg8EQCfdUtxaxY4M
 A/xQ==
X-Gm-Message-State: AOJu0YwpyrxHkB82hH1FibkkIfuBJFgEj2tWuxzWFzX+HdyzXrzsyJTx
 kEYpmAcVQJP+urwfH+mWXoJdlA1JXAnyoo2WMJ033/yjwWad8BjTIrZC+rEip9Otc0l5iNiHj0h
 Tucqv
X-Gm-Gg: Acq92OH0W3M3PhRNfvLwh4HQ7coPQRQA5U1CD4d5k+ix/Yb+/G6ocsB1QGcjdK2BLXO
 cZXsoVcfz2TTBNkds/+u5mpbQC1R7cZZDOLjoASUwHL/SDVQL6VxrDBztakTXHJsDy+l5U9MQEY
 Eg9KU8cFE2dSjkRgNqi14EHzrcZMwiI8qIZyLnY6EGBRuxPwBm0VaQR3j26b+F9xrbJ2RsV74sX
 /VEphu801OIbbzyVVnm32M7Uv/rADkhN0iFY3Mkn/hx4qA+5kDk8NO+95lx0FPvatGeRdLDneHL
 Y7b5rCtyDX4bqtBfNUrwIRXue84BFXs0vsbBXuwWszLDJnRjsInuvCjVHb8cdz+fV2Pcztv8i10
 EpyrcNbJY+lPlhstgVWjLawUSEVXFtUJD6MKAGaqXsSn9OKL0WwW4w+DhKchtfolZ2LWSkY0+ln
 iy9B/f/Vj0S2chSsnb/uxGzWARwChHgUNfz+wawlmeRS9Zb1DlznZMKSJ0/qqhbSDXzzxZ7782
X-Received: by 2002:a05:622a:58e:b0:517:773d:15cb with SMTP id
 d75a77b69052e-51795a2b959mr78411511cf.13.1780692783325; 
 Fri, 05 Jun 2026 13:53:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm90072906d6.41.2026.06.05.13.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 13:53:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH 4/8] security: harden telemetry parameter parsing
Date: Fri,  5 Jun 2026 13:51:01 -0700
Message-ID: <20260605205253.520196-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605205253.520196-1-stephen@networkplumber.org>
References: <20260605205253.520196-1-stephen@networkplumber.org>
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

