Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B5C88E45
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:34:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7418642D2E;
	Sat, 12 Sep 2026 08:33:49 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 7643942D2E
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:33:48 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so246632a91.2
 for <dev@dpdk.org>; Fri, 11 Sep 2026 23:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789194827;
 x=1789799627; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JcDCqa41SUZYQc3ssPw0VoH00GkPI+KadSVaYbX95/M=;
 b=fW5JHCo0+r7keyTwmiC8qQC6EnmgXlTQEvdVdBsxwn1eZDFrDEiFjR+PBCN6HcwY0Y
 8R0uznGFIcxyAFQtR8hzJcOrM323lu+pvdOTlFecypvRFtLNKNzP184rPp8JjvVdhN68
 dQ6Wa429sx+v0ziF+fMCYyuHhizV/o0mLa0RvGedPXWso3q4sT5Tx+oBJKD1HVu0ONHb
 jFBVYP4+9eASLFA+JkE7eFu4ox6YLO8rRZSHsHJM3/i2/6J15z2mjdfep4BsCHLKwsri
 2AP8wd1F/rFl7jk0sXxfh05H4dWfz90E6PdCj+vUPuzrm8zC3cjC74AJ3bYHnCC4zY7g
 Z0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194827; x=1789799627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JcDCqa41SUZYQc3ssPw0VoH00GkPI+KadSVaYbX95/M=;
 b=ofvVDaZqidXepK/TVaRofYdR7swBjiNJmCUAsrvzVJWqODHd2NtZluJrS3o/aZiWeE
 i1n/tgJMNRZ6Qs5o2DyBj0FlruCTkfsilCVBBzrsLoXGKpmNArGEIqw8MLut3oeRj4mh
 AC4ty90kxZqEcDD7EqtIKF3buGCTisOGkLObHp5e848wUX2+trNGAJHaj/gu7iPlX6id
 eS0gtLWP74NHh2YKk0S3Tr7DQCzCg+czARPj4sC3Fhte4LoBAz1LtOjz5MGB0XazRJTq
 BQsXThsWzgKCns5+Qucwqygfw1R1yfxjdIBOJ3BFQ3Knp1gD31Wdn54Ovfe0c8BixFMW
 wW/g==
X-Gm-Message-State: AFuF++lYTMTLue+gEnfoIzxtRorHHi/q3B2bEkobqgeL7yLR71R9FTVI
 cfKhBWPCRcrmUSZwN6u59BeNPryGEiXkp4p0oOmK6m+Ex5al0uvyv0yIFvnj4pw1/wMIrxN/xoo
 GjEGH7gk=
X-Gm-Gg: AYBFou38aCdPh5ZwsL/a0E6urO5oUFkKH7fainNcOIxyKW30F9cL2fjCjhBWfBrdPle
 OkxgJsuD9ss4dHeK1nC0RVh+DMStaEfPsrDa3V61qvUKUa7l3upkOp7af3F176VmdWBe1wXM31n
 K0HLsaWriSm9Xyfig2DC1K3X7Ik2yFYsaiqX3F4i7pV7aqZgvrmR7sRZAzH5POyMiencMZ7PhlI
 LqzJaXmawr5FmoBx7Sq3pPQXYI2WWEMMEXqImm/HDMABGb4p3uVCA1Uq8K94PkmoRTOZ2Rv2W7n
 X2DvqZsESSPf3dAJWH/Mn3i0ePHUYUeYxfbUXLvS/vpWGhv1/kl7OYj3Pd21v0KuDLoSDYQLaLE
 0zu6kneylsnXnK8pW/bdwqo3GtKKa+qAJe/sAnBmDlD5XA99zBLMWipYELLArs7b2qPGi9YO1GO
 lQjySQWdFkSAuNVMPKBOFyInT4WlBPyjjAK2rsoUjBcaE1aetKj0t782xN2Y7peShNxEftIsA7y
 4BvBcOvjeUV4gO6oZSFeTVlevcIou4mkaZxrQ==
X-Received: by 2002:a17:90b:1d51:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-39dbc1d770emr2877895a91.11.1789194827615; 
 Fri, 11 Sep 2026 23:33:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm8661497a91.10.2026.09.11.23.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 23:33:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH 4/9] bus/vmbus: use common sysfs routines
Date: Fri, 11 Sep 2026 23:30:23 -0700
Message-ID: <20260912063319.4117869-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912063319.4117869-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
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

