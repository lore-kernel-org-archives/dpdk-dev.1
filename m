Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6311C88E59
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 17:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A16740659;
	Sat, 12 Sep 2026 19:04:31 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 130F340659
 for <dev@dpdk.org>; Sat, 12 Sep 2026 19:04:30 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469a3490bso615465b3a.3
 for <dev@dpdk.org>; Sat, 12 Sep 2026 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789232669;
 x=1789837469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=03Wy+9HHmkmjwKYESMRu/1zej2nduhvdjG3WxA4efwo=;
 b=Dd7o6klE6+Owr+OLKdsOwIxc9pep+x+Oo3XE1esNGe4kFQCWosE8Aj+/1JxC9JIaF7
 ODNi6Mtif8Cmczs6GGAQlYNJpS+skzWcOOcsf2RJ/WaaYIC9pX613DNARVjbJK/PFmz3
 ezLJvHRdc4+Z01nVPIz34lvqnpgN44D6+gom/e5edCPBKA1mULtN7PLqCqlDGQGNakMw
 mS38ebqwrYt54szu3qx/9e2crrhk2GzJlTSFxxgItejOrlDkvZkVrF2HT59tXLwI5YMb
 0UyRajRZoJ54apfR7imYjLXjNxuLQOku89XtVLmDJId7+x53cFKzofp02GFl8qF8l+ZL
 l/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789232669; x=1789837469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=03Wy+9HHmkmjwKYESMRu/1zej2nduhvdjG3WxA4efwo=;
 b=Y+pRLPg4ki+EDLZtjJ3Ookd+0V4rkL1/W5IBp1zquPwynKnXTf6Fv5p3G0VY3bjfBz
 nojrU/6iyDRP/JzjLDaIdS+RM7QLoWLyKbT6ZEqQKIMAT4QUeb74WZmzh4eF8CBbjOfL
 tDMeXEOcmfxWoHyNXm9Zz/YRXX0tItNMRVb1Hm01GRTmTna9CBAfixG5ilRvYbkAz0qo
 RnGZcJsVXcUlK54tKCJmcmtEKIH5QzMM4JkM1rgbicn1DLWZ9ivPc8xdt1V6c8RmTLMy
 NZgSbC466AyRxagz+sNHwOXyEjugXKY1mfJa6KUOEeAdV8i7/ZcEoqeQnZp62xl+anu9
 GJWA==
X-Gm-Message-State: AFuF++lmM3obrFQdJSCQf3GYVxt1w8Jawxrof2IwbsWFDuUpixtyBvuF
 OaZH73sjwjRH/OmKB/xGnBkUMqdpWwTtH7n3xZ0StDzYRTvG99rDbZ93GQE3E2KePoOy6Q7cq1A
 J/xdR5P4=
X-Gm-Gg: AYBFou1l6Ury+lqsGlp1Z7uKE3jT5MOwCvmVjRDJ84SZdf+JMnphtktW6yGFD+JK2/3
 huMXnLJI4w5gOUJpQ55v/6/S7Ve63TFJPbVpnKSRDwoOjruzDFzff421DwE6ye3oTqKqICr5cB+
 3r3Oc6X7JL1BdPd9Af1E4KBEWwJzFBVLIhUtOMiNEiroehH29oAp1sQAcu1hYuwfr2vnYhzY9e3
 7JEnoHFjQ2UICTG+5WYvnT9QlfYmPsgrVbepZu/1KUARPOBVg0wiU8TeQco09UYSvCq+XGoTrwz
 d0oQftezVjGZHnEET4u9M2Dn8gbEjO8EedGbyf9cX+ppuwqL3hrR5Mkac5KxYQQOp6H0kNMdmm8
 KESl9CYw0Y0hhXdPCv35QeXgkXWr4slroWztClfJfU40EW8EYLVMA/5hdughSkFy3T4XyMXc1qI
 BCbTb9Wtz3I2nrrcKbCbD2jwmrDEsEkUQ3auMTTUIyH9ivgssJgWwwamrzhtziK+qXpG+HPZSQx
 6rF8JtX4hNPqi2WK4+GAo4JsaNF47OFs/EGxp4=
X-Received: by 2002:a05:6a21:3a43:b0:3da:4cc6:17d3 with SMTP id
 adf61e73a8af0-3db0e48db6amr7489319637.26.1789232669165; 
 Sat, 12 Sep 2026 10:04:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c655c2f0sm2719569a12.18.2026.09.12.10.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:04:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 9/9] net/mana: use common sysfs routines
Date: Sat, 12 Sep 2026 10:02:21 -0700
Message-ID: <20260912170338.486978-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912170338.486978-1-stephen@networkplumber.org>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260912170338.486978-1-stephen@networkplumber.org>
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

Read dev_port with the EAL routine rather than opening the file and
parsing it with fscanf().

The value was read with fscanf("%d") and is now converted with base
0, so a value with a leading zero would parse as octal. The kernel
does not print dev_port with leading zeros.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mana/mana.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 0b72f711a1..39bfb5b4b7 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -14,6 +14,7 @@
 #include <rte_kvargs.h>
 #include <rte_eal_paging.h>
 #include <rte_pci.h>
+#include <rte_sysfs.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/manadv.h>
@@ -1282,6 +1283,7 @@ get_port_mac(struct ibv_device *device, unsigned int port,
 	DIR *dir;
 	struct dirent *dent;
 	unsigned int dev_port;
+	unsigned long val;
 
 	MANA_MKSTR(path, "%s/device/net", device->ibdev_path);
 
@@ -1293,23 +1295,15 @@ get_port_mac(struct ibv_device *device, unsigned int port,
 		char *name = dent->d_name;
 		char *mac = NULL;
 
-		MANA_MKSTR(port_path, "%s/%s/dev_port", path, name);
-
 		/* Ignore . and .. */
 		if ((name[0] == '.') &&
 		    ((name[1] == '\0') ||
 		     ((name[1] == '.') && (name[2] == '\0'))))
 			continue;
 
-		file = fopen(port_path, "r");
-		if (!file)
-			continue;
-
-		ret = fscanf(file, "%u", &dev_port);
-		fclose(file);
-
-		if (ret != 1)
+		if (rte_sysfs_parse_uint(&val, "%s/%s/dev_port", path, name) != 0)
 			continue;
+		dev_port = val;
 
 		/* Ethernet ports start at 0, IB port start at 1 */
 		if (dev_port == port - 1) {
-- 
2.53.0

