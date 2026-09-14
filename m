Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB83C88E6F
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:38:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AF7D40ED9;
	Mon, 14 Sep 2026 19:37:52 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 03FCB41144
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:37:50 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469a34907so2174603b3a.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789407469;
 x=1790012269; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=03Wy+9HHmkmjwKYESMRu/1zej2nduhvdjG3WxA4efwo=;
 b=B0QRc9DWPUqqmiXodF44/E5ZO28TBHpqqejP737gOEDFgOOk023tRmyyGKZ+KxC2oO
 kDanE/EjRfKu4K5q42tV9Gcdlm4pgK1PWDBXtwOU3BMwupyg5Tf4AsiurO5cwhgNspGl
 nwgf7IIMUuYX2GEU1T2RtJt6DNEovgmX0Bgp2x5nbLUFLBYAJ0pjZMVbJUk/si2FPGLU
 10+0arq2jlvnW8VTbKdbOQxf1o/Y/fmqf2n3e6qniTLjBPXI4Uoidcg2wB4IuPFC5jEK
 IQq1CNIVlTQyoO1pp+04pWPyCiuAeSD3CtolLEEzTu2HQSlmlmpsoVC20c1BiIux7u5C
 onbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789407469; x=1790012269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=03Wy+9HHmkmjwKYESMRu/1zej2nduhvdjG3WxA4efwo=;
 b=ZQwGz6EA8S5REpu+KEcK5nZsI0ilzmg5fNjOeDQPBfPYd1gkNr9uv1mznVyWPhfDdk
 XLioa5gPLuqWG6QpOgKO3jjWi0qRWw76q2tyuutHonhnSvZ4U4z/ISpeUDPUa2z3Nnkt
 bCJUs/VJ2s9PRrPbXmrC4MFPcFNW0Tsok9g8yGdcdYKXbE7nxC3Hsq701K52QJO2pPdS
 Wv5fOvElHHW4tFpKwx704V6c5V/If2Uipfs5ZR7XeVoB9X2YqmW8LkMrTH/HDWSeb2ue
 NYxLQg3KZ7xkJ/IkDXYQIb2jMYPsYgt2qvGaEEEJo2cUDCeZc/gBqUSXF0SrWJJ5WVMV
 gvnQ==
X-Gm-Message-State: AFuF++n6HIAaoLYOdhH8WaYpFauFGraaYrFFQFRLm2t59+iO34QP/Vgd
 F9Jozy1Rd855zPPVNf4yxhyk29UZNPPjFpWGGxR/XYbwggd/cxJzEUjHrUOn3GJfUHKIMx8FHII
 LR+/3lPg=
X-Gm-Gg: AYBFou2DaMeTQYtB88aKXuLDLmN3QHcIlJnyqtbWFewMIjS7TK26iWNe4i6jBUL4Jm+
 5Fe5itvUg81Kjjp5LsCeiRvBJOwrkPmv6G9s8PLpo5AbmE+pDCMJqMHRb2C7Kesykhymt9qVECw
 oYi/q1sSU1JHCrsnwENCG+D3I97Pz9IBX8fXbRul3T3qlD86bbOp2eqWnJB6vNNmOU5yNT1/ut+
 MwnDS0IcJ/IBslqw0dxMoKoemf2xR1qtA4oq83S755wKTH+6o5/I2dvuFjy9uCngagYEnhx1g3X
 NF5oY4Ox2zQRdTRRjhgEkNw7ibybdR43+t90IXRTk/oXe8azC5DwywAg5QhyAiYw6rEHtgKzyH6
 JseBbgoCa3yJEo6K1nyYIDuBkoT0vgH+H/UE9UbpVb5xu6e985Udn9EEikVeHNIdaZhiiR82WS7
 v2+cCCpozrzd8WUmyo39WEAoI/rFEyhUIReMW+rZwoiDxRIYzadSSk3RD4yxariL0HzcUI5b+9a
 jrtptJNzh1sZNVmRRQtKOOQAe94B/EGaV3g9KTn/fasSaV7
X-Received: by 2002:a05:6a00:9082:b0:86b:73b4:30fa with SMTP id
 d2e1a72fcca58-86f83a3c70cmr7219935b3a.11.1789407469038; 
 Mon, 14 Sep 2026 10:37:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b286c49d2sm5159867b3a.10.2026.09.14.10.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:37:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 9/9] net/mana: use common sysfs routines
Date: Mon, 14 Sep 2026 10:36:22 -0700
Message-ID: <20260914173700.2795983-10-stephen@networkplumber.org>
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

