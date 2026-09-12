Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D19C79FB6
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Sep 2026 06:34:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C85742E24;
	Sat, 12 Sep 2026 08:34:10 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 9ED8542E12
 for <dev@dpdk.org>; Sat, 12 Sep 2026 08:34:09 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so130692a12.1
 for <dev@dpdk.org>; Fri, 11 Sep 2026 23:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789194849;
 x=1789799649; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=03Wy+9HHmkmjwKYESMRu/1zej2nduhvdjG3WxA4efwo=;
 b=sQTkoYZlyBtmmW4oxKurWMn34v1n5n1N9llh5THv0voAMRyt0CIcmNWeoRkynnhzvp
 9yot3CoS7D41XKG1ssbPlcJlLbMjLiILnaVlVN88+whwHnrLOsJDpJGty7ECkNRVGJXS
 47qmSUKRGY6XdAspDUjnL7knuSHktifpCd2W15RB1KnBk+U/2TpKz7P2Ff0Wi++Qf/93
 gX1T66EcxSz/HRG+3iXdcwnEc4W037z7ykVZJPBrlaiPFPX6ng59khyS896MSnnj//z0
 LToXkv3ID4K9COlr/ETZdtrKo/DPbvTRvNBzOch704IhSm79aTmeH2dCkBKZ9JMlKXMx
 2Rww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789194849; x=1789799649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=03Wy+9HHmkmjwKYESMRu/1zej2nduhvdjG3WxA4efwo=;
 b=DHzYmpZShR4QiN3m1bPqkdgFWhcJHXmcbqKx7iYb0wf+alZa/rl4j406BagMDV1Uuz
 fkAGiKpGNbPW0m8fsw+vblAfdmTJqzGATbPKs53OV6Y4CC2Auf9xZejTWgAcM7abifCD
 3CsASqflcevRhQQTMVrOEIqh3KCWJW1dEGlgioQ3YuVu3OR2zAJf3eF0O/UFb6vpeEO0
 7sbgYdKhgTY9BDczwwgQzKbCud4PY3v/mnnaY2pxLCnsh0nB6lJnTS1SeX4M5SnMIkzp
 ad2XFvzBFNFlOmMBheBJKtO+IVR77yhAXv/EBM2gatvZqSyLb2XmO/Jx6dbkdHfMn6tk
 +0ZA==
X-Gm-Message-State: AFuF++m8F07mVc6i82e/bSBQJnheQPmXuyp7sO312AyqYVCSLsymV2DQ
 rlpNww00G560GIbJADbUrS9OdVf7qrTpSZiC1fx4JydhaJyApmbCT52T808bnWJ4Oid5Yzl7e2G
 9hBZw
X-Gm-Gg: AYBFou2mkxaOStKJpGd3wqwfCr3xRgUXkGM5s4mTE2J2nVtzGFioN0gCM3sRFfxXmNI
 ShUCEijL06Y2dk/5v52fj/sv0sNkms6LbND6OG4vNnvHcGqUP/3orQtZq9m/GZXIs2CR6AfQZcQ
 rzlJSvtCsv1HTsTSw/+TCtESM2LwmFdokSzv5kbnSvOpaLBsBwzyNaRE6aoUSM6+yycKydzF3hR
 KxPDL9Sb5tZ88KQeqyBH2f1a3VGgIU2McTZimF6ONUBbc6UfFox+QdVx/VwRXusA7JhxtXpaWte
 DarLGtpneYiFQntJf6DZ+uatl5D0VaRqMVuYRTxTV8DAGLQsE+LjC7P7D/xkVsGnXOEmSSxkJkb
 qQvrxqhN53aQy+CRXy8ECMvRC405Y88GeVt0AXCQfBm2MKZC7bH7sqoDnMDZMq4W7eGG1fS2cM0
 O448NhQuqPZ6XzW7HT26ck4/pdgc1XPR92UCs7Q9njpbR9LnP7tNjA6/ILj4ckBN01XvVXYyQuk
 4fjmG7CTNJpNfn8RSm+remgrcjRidZw0cQCLg==
X-Received: by 2002:a17:90b:2c86:b0:396:4dfb:5890 with SMTP id
 98e67ed59e1d1-39dbbe84fb6mr3038792a91.2.1789194848750; 
 Fri, 11 Sep 2026 23:34:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95424fccsm8661497a91.10.2026.09.11.23.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 23:34:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH 9/9] net/mana: use common sysfs routines
Date: Fri, 11 Sep 2026 23:30:28 -0700
Message-ID: <20260912063319.4117869-10-stephen@networkplumber.org>
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

