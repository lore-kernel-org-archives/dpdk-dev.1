Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69748C636B7
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 20:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B247402B8;
	Sun, 22 Feb 2026 21:48:20 +0100 (CET)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48]) by mails.dpdk.org (Postfix) with ESMTP id 31554402B8
 for <dev@dpdk.org>; Sun, 22 Feb 2026 21:48:18 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7d4be7c4ebeso2263435a34.1
 for <dev@dpdk.org>; Sun, 22 Feb 2026 12:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771793297;
 x=1772398097; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+9Pc2Q2ec13cBwL7Ir01hItcSSaDqFrJyfdjOZEZeAU=;
 b=UQsmRBjR/ju33ISUjylIpAboqtw7r2sE0I6XIC/tUdRRX3ph+AJI8j3XF0pzTX8a34
 EJG17IHPpSjYSUXatu9eC1bhqcyvNf9QDS7ysvzjt3lrExTh1yHouheNCWO13rKo73gv
 1/ujp5HAq2cnN+FckoOd4SJvynUrp+buCTsb2Ls0BDI5VfUixjMtuLRD1RUTB6zCdhfL
 yDSwFMa0JXTYjUCn+UTCJ8Kn/7/q34UdinZFHsg8gfJWo6FI/yywCd2H4Xw8wSCbeCjE
 bo+Ic481Y5mDEwkCn6XxZ0MbhBMBMwXMGo4Bcd+cEC00Jxy+tORVesMJPGDBAeJp1Ck3
 uZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771793297; x=1772398097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9Pc2Q2ec13cBwL7Ir01hItcSSaDqFrJyfdjOZEZeAU=;
 b=hNsM06EErtjHwMOgUwwEx5vtago77bLruXmEFYNzXomKgQvstKyJ3I0FwS6h/HoIqG
 MMMFzWdxV2Nt/JGCUqYnPL4U3GBq3JCyMNEexFEX9bQwP5B3uZI7fAj+f/LqGoNd1ymV
 MKuwyiJA0NWgfnETbqKQwQLDiBNW2HdVG5DNneRR4QFnzHEfSejSrMCVzEFU8iSbiqIf
 oUNxrBMncsxQ9Jj5jeHjLOJ17SnasYg78fLr28lONWjboPouIqTUz1p+CrbMHSt4GYbP
 bm93/jidoAGV3SmSH6xRQhbJeldNISQ1cxu6BTbiRudgnu45FmGeVvofHM9mHlxTKXMk
 m2NQ==
X-Gm-Message-State: AOJu0Yx8aHE55PR46AZmGHCU5bukx6+gXF+b+rSMGObqi53lVBXO/6K1
 71eoGKw6C+GOxs4ZIDXpPyigpbl0jsp449rR03hTdNz09iRPbZ6N4EXwO/Brqx+UEZM1aZK1gf+
 AlvhB
X-Gm-Gg: AZuq6aJf1pLb1vpGrx8jjwpo9BsA4muaWkh6lDvfJNYuVKI1o1MXd0rB/K68zHAt9Vq
 niqqh/FsHfhq4QotMT27k9pgdUExvAoOG7F/PWZxhkiE8O3wP/1o/FU45Kuf5gc/iodw4K98CLS
 pwFgw7C6WcgD0TRCDBxRY+zBd9iQhlVJTPpNt/J38qC5Cm5HNOYk7njeT2Nk7IcJIuOokYpNlW6
 cRYjs5Qsu5o5t4L6ILc5ADWb9ZcV1GW49XORGK0EMt/Hg2JuM7E0AC3zKCHHiTqNvSvC2fnpxwk
 G+akLESmIcYlY93EgDYHE/j39r0CECWZ+RXn+YncxX3VG1x6FjbPtCWZK3j3SnfN58lfeMd6miY
 rDvgL7/Go2USWV83m8xeA4PjjuW0XEyVDdVDLJa6Egh5YNUdEb73Hq7GaA5o3bpwvrIdEA+2Nu/
 VJs8Sq5Gq2HDDZej2YnXZC3aSC0DMVa5qmZUrymk1XhNwtTbTbZ6gqP/CPTIIfog==
X-Received: by 2002:a05:6830:6112:b0:7d1:87ef:2b01 with SMTP id
 46e09a7af769-7d52be3bcbdmr4133890a34.10.1771793297171; 
 Sun, 22 Feb 2026 12:48:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d0725dbsm5417940a34.29.2026.02.22.12.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 12:48:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Matan Azrad <matan@nvidia.com>
Subject: [RFC] net/vdev_netvsc: check for NetVSC device before auto-probe
Date: Sun, 22 Feb 2026 12:48:13 -0800
Message-ID: <20260222204813.773962-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The custom scan callback unconditionally injects net_vdev_netvsc into
the devargs list on any Hyper-V system without checking whether NetVSC
interfaces actually exist. This causes the eal_flags_vdev_opt_autotest
to fail on GitHub Actions runners (which are Azure/Hyper-V VMs) because
the vdev bus probes both the test's intended vdev and the injected
net_vdev_netvsc, which fails to initialize on systems without NetVSC
interfaces.

Check whether at least one NetVSC interface exists (via the sysfs
class_id check the driver already uses) before adding devargs in the
scan callback.

Fixes: 56252de779a6 ("net/vdev_netvsc: add automatic probing")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/vdev_netvsc/vdev_netvsc.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..0c7cd4aa4f 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -768,6 +768,32 @@ RTE_PMD_REGISTER_PARAM_STRING(net_vdev_netvsc,
 			      VDEV_NETVSC_ARG_FORCE "=<int> "
 			      VDEV_NETVSC_ARG_IGNORE "=<int>");
 
+/**
+ * Check whether any NetVSC interface exists on the system.
+ *
+ * @return
+ *   Nonzero value when at least one NetVSC interface is found, 0 otherwise.
+ */
+static int
+vdev_netvsc_any_netvsc_exists(void)
+{
+	struct if_nameindex *iface;
+	int ret = 0;
+	unsigned int i;
+
+	iface = if_nameindex();
+	if (iface == NULL)
+		return 0;
+	for (i = 0; iface[i].if_name != NULL; ++i) {
+		if (vdev_netvsc_iface_is_netvsc(&iface[i])) {
+			ret = 1;
+			break;
+		}
+	}
+	if_freenameindex(iface);
+	return ret;
+}
+
 /** Compare function for vdev find device operation. */
 static int
 vdev_netvsc_cmp_rte_device(const struct rte_device *dev1,
@@ -798,6 +824,9 @@ vdev_netvsc_scan_callback(__rte_unused void *arg)
 				VDEV_NETVSC_DRIVER_NAME);
 	if (dev)
 		return;
+	/* Only inject if at least one NetVSC interface actually exists. */
+	if (!vdev_netvsc_any_netvsc_exists())
+		return;
 	if (rte_devargs_add(RTE_DEVTYPE_VIRTUAL, VDEV_NETVSC_DRIVER_NAME))
 		DRV_LOG(ERR, "unable to add netvsc devargs.");
 }
-- 
2.51.0

