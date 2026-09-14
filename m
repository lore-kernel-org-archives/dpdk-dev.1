Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D97C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:37:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BA52410E8;
	Mon, 14 Sep 2026 19:37:31 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id D2223410E3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:29 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469e25400so1823871b3a.0
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407449;
 x=1790012249; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JcDCqa41SUZYQc3ssPw0VoH00GkPI+KadSVaYbX95/M=;
 b=g90tgA7GQL3AopIbv1gAc/BgOuRPCOp8Otv1iYgF7PAY2L8NpdMmM5McVe1eB9BjIe
 FWhkiA+kPAoqpH4/Z8LANwLT8KADNLZVuXpr6Gfv5RaEHTJdwARL2NLOvjPK8OZ8OlWA
 H8nq7vbeIpqIXVdyrs2OzxVv9fq1hK3m8U9L+pbUIh8cSsr3co50VLHnWoQOAiUCNZC0
 ixoLTbyUxc63AERrzRAHCtFZ70Yk+XdlYUcayyJgGWh+3DuAf/jRHWePMBdUQUqG5NNP
 f0WFrQEavg5SBXkWx2rYJ9dGGRME8mKj2v01VMtkYu+H1lkg03SCKbtvLcM3kPsY+XJX
 5eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407449; x=1790012249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JcDCqa41SUZYQc3ssPw0VoH00GkPI+KadSVaYbX95/M=;
 b=oCuEm6G32AW+EL1Zl9LS/rpkRvEXDQ2YMUQ1bdNTgABR5oxqVAzRXWJWFUjeB6wsiu
 /+/m0LPjHL0YklJKsr1sEmCT6qNWt32cMmjMn3LEIUW4vyQt3POwMTgDbbnTksD9uqAG
 VhH5H8r0CQg8YzsbR9ZkPIN9b/Rr0KGOv36PnyICYwCyt3XdpW3IVY1WTTTJa/ki2U95
 qGZADjSvUgk2DWEvyauqKlj66i+McqsEWZoAAxPmg/y7O0LjNOuBCBwQvnRvpbsJQisa
 LMqMOa2yB4xOiVQpF1sIAZO4rU0GqUeySuZ0AXUwkoxliTC+YDhowBykOG6can4OI6fG
 zrsA==
X-Gm-Message-State: AFuF++kl0eV/iyGJ4CA59UjaZJOc1HrGd3qvMaqqLl+qYAo4Dl6Rc4kp
 Ze1buSBUMHNz08oxvGqd+NhwB1CRpQBteEuOZUkm2uL+sWBj9Bic7FCryhBcFIBspRdUbp169/A
 LBlIK9SI=
X-Gm-Gg: AYBFou3AZpTlFAoVuqnfVoulziG+Qc7kIiG3xyyyoVyy7ouaLprqh7GThbvMiw8t1OU
 OoPh/qtXT4vVXn09DmI9VpoCkAWwvS0xkW8k6En0xSWrIaTf3XZmja7OkxTGGy3SV0zF6ydkztF
 y3N0M0+RGH3c6FUJP5A8zoX7ilx0E1tzE1va/VsvVOQH532NPHz4pldvea2xQGfdtSijx6ZE2da
 ZTSKB64HZ48TefHvKcMVfE/Ybaj3JXE7SKYqs+buZsS0yNhRq5xP1lADU9Jrurv6U/FEjtURjzr
 CTMANw1PqVh+PgH1uBh+VVnm1H+u7mICh4sZU+gbis3tfAxy70VjGz0fUGMPoyMX1roEW2g5soS
 ZCMP9HBRP4dws5rwDoGzZMaT2hnXk6TwT0y60k51Y9VmHs2G9ZaJdrXveY9vfVkYh6IKvck/55m
 vHXmn7DNKgFyLOlXj6Mc+KNc1A9eWPM44qNN+o72snKOI+0mFnJwkEY+NQl+mtSWRBYCw/BNMkO
 oKDiI4ROEy1bjsnFIOjx1FaifG+4OkEkq/Wsg==
X-Received: by 2002:a05:6a00:148e:b0:848:67ca:bfd with SMTP id
 d2e1a72fcca58-86f858ed353mr7712368b3a.16.1789407449021; 
 Mon, 14 Sep 2026 10:37:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 4/9] bus/vmbus: use common sysfs routines
Date: Mon, 14 Sep 2026 10:36:17 -0700
Message-ID: <20260914173700.2795983-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914173700.2795983-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
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

Replace the open coded read in vmbus_uio_sysfs_read() with the EAL
routine. The range check and the -ERANGE return are unchanged.

Two things do change. On an open failure the helper now returns -EIO
rather than -errno; both callers only pass it to strerror(-err) in a
log message, so this is message text only. And subchannel_id and
monitor_id were read with fscanf("%u") and are now converted with
base 0, so a value with a leading zero would parse as octal. Neither
attribute is printed with leading zeros by the kernel.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/vmbus/linux/vmbus_uio.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index fbafc5027d..50e58f9b65 100644
--- a/drivers/bus/vmbus/linux/vmbus_uio.c
+++ b/drivers/bus/vmbus/linux/vmbus_uio.c
@@ -18,6 +18,7 @@
 #include <rte_malloc.h>
 #include <rte_bus_vmbus.h>
 #include <rte_string_fns.h>
+#include <rte_sysfs.h>
 
 #include "private.h"
 
@@ -334,27 +335,12 @@ int vmbus_uio_map_rings(struct vmbus_channel *chan)
 static int vmbus_uio_sysfs_read(const char *dir, const char *name,
 				unsigned long *val, unsigned long max_range)
 {
-	char path[PATH_MAX];
-	FILE *f;
-	int ret;
-
-	snprintf(path, sizeof(path), "%s/%s", dir, name);
-	f = fopen(path, "r");
-	if (!f) {
-		VMBUS_LOG(ERR, "can't open %s:%s",
-			  path, strerror(errno));
-		return -errno;
+	if (rte_sysfs_parse_uint(val, "%s/%s", dir, name) < 0) {
+		VMBUS_LOG(ERR, "can't read %s/%s", dir, name);
+		return -EIO;
 	}
 
-	if (fscanf(f, "%lu", val) != 1)
-		ret = -EIO;
-	else if (*val > max_range)
-		ret = -ERANGE;
-	else
-		ret = 0;
-	fclose(f);
-
-	return ret;
+	return *val > max_range ? -ERANGE : 0;
 }
 
 static bool vmbus_uio_ring_present(const struct rte_vmbus_device *dev,
-- 
2.53.0

