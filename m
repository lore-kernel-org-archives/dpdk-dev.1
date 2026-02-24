Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCD1EEC2BA
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 01:43:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08A054027F;
	Tue, 24 Feb 2026 02:43:05 +0100 (CET)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id A6334400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 02:43:03 +0100 (CET)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-896f44dc48dso45871766d6.2
 for <dev@dpdk.org>; Mon, 23 Feb 2026 17:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771897383;
 x=1772502183; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9oRoQ/Q4gsnCzZ4msg/n1o94HOBtk54JiIbKMrYFkz8=;
 b=RVvMor+ms8Omi1AcY0dfg/20Wi3gLA7opUdbSVFwnDy+CIlliEZZBKL9pt13dGd/zr
 vgZaQyBgmz+HbfTJhHfFE863cDvsjR5jpAfd+L29h+F0Z7BYR9jF+y++wUelPx4Ui52o
 hXnllBhxeJHXVL/3I1k5/DuDiJ8r6Qm/2fe+2pJwj6S/05dSH91aUVYYs7sLtUDPIJ7r
 LKuUytglylBDNlgwDtUOg0/f1HuopKbs/qdfFhcLd9Q5dRS29Pa/UjYk4WA0C++sxDEn
 Lvu/nHNsVr7u4DCZJGMiAixcmhe67Sjuex66M5f06Y0JalFXxEKqSoqq1rKcM2qwo/FW
 1d8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771897383; x=1772502183;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oRoQ/Q4gsnCzZ4msg/n1o94HOBtk54JiIbKMrYFkz8=;
 b=ITdg8t2S2Uq/rxtHkBpTNxnH3Vkn/GuyOskTxe1a9l3Qi3efAxoRnYfhCb0ru1/qgd
 oFLzmxP7//k2PVv8cYKsPfSBzOl7EtU3nOww5Hj2Dwr15vkUfMN8dcA4hXy0rR/dAESu
 KY6Xgw3ilyrrEf9xERvFFstq0vHHcF57/nWqZWpTs7jb7IGCOvY4uENxM68kiIOpBNeC
 8XV2FT4lYV1ZNb5N9yw+1YDrtMOLHvWx030wb2TBeBBoft0PBIG6aRjIbXkL1qy0Cqag
 oStzp9rZVtNIcD8tZP79PVPUCtdxFVVVRjJpU06s8vApEfuEdOo+y7QqPLYS0W+kwPTw
 suxw==
X-Gm-Message-State: AOJu0YySLcEBrJfmajcVUFc2VZ/RJMGo/pyIG2F0KC+xZn9np06u7Jpv
 3Q9WX+2u/enaQNzejJfnJ9/KF36C4qUhCqTC7xZy7vdvD5/9Z3corNn5coOKpB0FbYQr3qdHRH1
 WrCIM
X-Gm-Gg: ATEYQzy997JdecE4riNBxpWCiL0G7MhYcTxCiMPfEp23uWPfMEFaBsqKDCm8FjH0GGd
 WEtDXhEANkmQTgkShyji5U8vAIpZQw9XqlGBGPU/HkZk5aPfwB4M9jJX7/4It06H6VyZUPHpCrP
 vfrnMlwBs9E40TFRX+v+43ZK5cLlw8VKHmt5qwBhUyoadKFx8raZ7capqahObw1pKiyeG8Pulmq
 EUFRIt4dUgHVEGqFO0TczeBjjFcXD1eBCk0NcSLvWs6QcPs2hOtXIzOyg/tL2s3H4hvMaosZHlz
 wj9lFU+boPftxh1WrBK9RWNjwkbtwwxygZ3vo1fmE9J67ujKkk86WUhZysoQEnN1CT00zPHReX1
 XfJ7iQ8JTf+/mywzlUUGieeYemhBk+5v2nbB4pNptbrdYVxkrOX+FPbh3PdfwRbGS3CzdetlyaN
 7i/zrGSDeVvo60eJ2k0dasfRGcEvrQ4XG23IoiG9ufXnEEIv87sVTxA636G7qpVRzbRx1KlFC/
X-Received: by 2002:ad4:5cee:0:b0:880:5730:d3db with SMTP id
 6a1803df08f44-89979c7484bmr158839686d6.21.1771897382772; 
 Mon, 23 Feb 2026 17:43:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8997e242ffasm81902186d6.25.2026.02.23.17.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 17:43:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Matan Azrad <matan@nvidia.com>
Subject: [RFC] net/vdev_netvsc: disable auto-detection by default
Date: Mon, 23 Feb 2026 17:42:47 -0800
Message-ID: <20260224014259.443846-1-stephen@networkplumber.org>
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

The vdev_netvsc driver auto-injects itself on Hyper-V via an
RTE_INIT constructor. This interferes with tests on github actions
which uses Azure where the driver probes in forked subprocesses
and crashes on uninitialized interrupt instances.

Guard the auto-detection behind RTE_LIBRTE_VDEV_NETVSC_AUTO
(disabled by default). The driver must now be explicitly
requested with --vdev=net_vdev_netvsc.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/rte_config.h                    |  3 +++
 doc/guides/nics/vdev_netvsc.rst        | 11 ++++++-----
 doc/guides/rel_notes/release_26_03.rst |  8 ++++++++
 drivers/net/vdev_netvsc/vdev_netvsc.c  | 20 ++++++++++++++++++--
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/config/rte_config.h b/config/rte_config.h
index a2609fa403..e1977081e6 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -153,4 +153,7 @@
 /* DLB2 defines */
 // RTE_LIBRTE_PMD_DLB2_QUELL_STATS is not set
 
+/* vdev_netvsc defines */
+// RTE_LIBRTE_VDEV_NETVSC_AUTO is not set
+
 #endif /* _RTE_CONFIG_H_ */
diff --git a/doc/guides/nics/vdev_netvsc.rst b/doc/guides/nics/vdev_netvsc.rst
index 8dd5981947..4a3049ef42 100644
--- a/doc/guides/nics/vdev_netvsc.rst
+++ b/doc/guides/nics/vdev_netvsc.rst
@@ -65,8 +65,9 @@ a new NetVSC driver will be integrated.
 Runtime Configuration
 ---------------------
 
-This driver is invoked automatically in Hyper-V VM systems unless the user
-invoked it by command line using ``--vdev=net_vdev_netvsc`` EAL option.
+This driver can be invoked automatically if ``RTE_LIBRTE_VDEV_NETVSC_AUTO``
+is defined in the build configuration. Otherwise, it must be enabled
+using the ``--vdev=net_vdev_netvsc`` EAL command line option.
 
 The following device parameters are supported:
 
@@ -87,12 +88,12 @@ The following device parameters are supported:
 
 - ``ignore`` [int]
 
-  If nonzero, ignores the driver running (actually used to disable the
-  auto-detection in Hyper-V VM).
+  If auto-detection is enabled in the build, this parameter disables the
+  auto-detection of network interfaces.
 
 .. note::
 
    Not specifying either ``iface`` or ``mac`` makes this driver attach itself to
    all unrouted NetVSC interfaces found on the system.
    Specifying the device makes this driver attach itself to the device
-   regardless the device routes.
+   regardless of the device routes.
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index b4499ec066..43d5b89695 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -106,6 +106,14 @@ New Features
   Added handling of the key combination Control+L
   to clear the screen before redisplaying the prompt.
 
+* **Updated Microsoft vdev_netvsc driver.**
+
+  * Disabled automatic detection on Hyper-V/Azure by default.
+    The driver must now be explicitly requested with ``--vdev=net_vdev_netvsc``.
+    The previous auto-detection behavior can be restored by building with
+    ``RTE_LIBRTE_VDEV_NETVSC_AUTO`` defined.
+
+
 Removed Items
 -------------
 
diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..a0d9d2aea9 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -42,7 +42,9 @@
 #define VDEV_NETVSC_ARG_IFACE "iface"
 #define VDEV_NETVSC_ARG_MAC "mac"
 #define VDEV_NETVSC_ARG_FORCE "force"
+#ifdef RTE_LIBRTE_VDEV_NETVSC_AUTO
 #define VDEV_NETVSC_ARG_IGNORE "ignore"
+#endif
 #define VDEV_NETVSC_PROBE_MS 1000
 
 #define NETVSC_CLASS_ID "{f8615163-df3e-46c5-913f-f2d2f965ed0e}"
@@ -653,7 +655,9 @@ vdev_netvsc_vdev_probe(struct rte_vdev_device *dev)
 		VDEV_NETVSC_ARG_IFACE,
 		VDEV_NETVSC_ARG_MAC,
 		VDEV_NETVSC_ARG_FORCE,
+#ifdef RTE_LIBRTE_VDEV_NETVSC_AUTO
 		VDEV_NETVSC_ARG_IGNORE,
+#endif
 		NULL,
 	};
 	const char *name = rte_vdev_device_name(dev);
@@ -663,7 +667,9 @@ vdev_netvsc_vdev_probe(struct rte_vdev_device *dev)
 	unsigned int specified = 0;
 	unsigned int matched = 0;
 	int force = 0;
+#ifdef RTE_LIBRTE_VDEV_NETVSC_AUTO
 	int ignore = 0;
+#endif
 	unsigned int i;
 	int ret;
 
@@ -678,14 +684,18 @@ vdev_netvsc_vdev_probe(struct rte_vdev_device *dev)
 
 		if (!strcmp(pair->key, VDEV_NETVSC_ARG_FORCE))
 			force = !!atoi(pair->value);
+#ifdef RTE_LIBRTE_VDEV_NETVSC_AUTO
 		else if (!strcmp(pair->key, VDEV_NETVSC_ARG_IGNORE))
 			ignore = !!atoi(pair->value);
+#endif
 		else if (!strcmp(pair->key, VDEV_NETVSC_ARG_IFACE) ||
 			 !strcmp(pair->key, VDEV_NETVSC_ARG_MAC))
 			++specified;
 	}
+#ifdef RTE_LIBRTE_VDEV_NETVSC_AUTO
 	if (ignore)
 		goto ignore;
+#endif
 	if (specified > 1) {
 		DRV_LOG(ERR, "More than one way used to specify the netvsc"
 			" device.");
@@ -713,7 +723,9 @@ vdev_netvsc_vdev_probe(struct rte_vdev_device *dev)
 	}
 error:
 	++vdev_netvsc_ctx_inst;
+#ifdef RTE_LIBRTE_VDEV_NETVSC_AUTO
 ignore:
+#endif
 	rte_kvargs_free(kvargs);
 	/* Reset alarm if there are device context created */
 	if (vdev_netvsc_ctx_count) {
@@ -765,9 +777,12 @@ RTE_PMD_REGISTER_ALIAS(VDEV_NETVSC_DRIVER, eth_vdev_netvsc);
 RTE_PMD_REGISTER_PARAM_STRING(net_vdev_netvsc,
 			      VDEV_NETVSC_ARG_IFACE "=<string> "
 			      VDEV_NETVSC_ARG_MAC "=<string> "
-			      VDEV_NETVSC_ARG_FORCE "=<int> "
-			      VDEV_NETVSC_ARG_IGNORE "=<int>");
+#ifdef RTE_LIBRTE_VDEV_NETVSC_AUTO
+			      VDEV_NETVSC_ARG_IGNORE "=<int> ");
+#endif
+			      VDEV_NETVSC_ARG_FORCE "=<int>");
 
+#ifdef RTE_LIBRTE_VDEV_NETVSC_AUTO
 /** Compare function for vdev find device operation. */
 static int
 vdev_netvsc_cmp_rte_device(const struct rte_device *dev1,
@@ -808,3 +823,4 @@ RTE_INIT(vdev_netvsc_custom_scan_add)
 	if (rte_hypervisor_get() == RTE_HYPERVISOR_HYPERV)
 		rte_vdev_add_custom_scan(vdev_netvsc_scan_callback, NULL);
 }
+#endif /* RTE_LIBRTE_VDEV_NETVSC_AUTO */
-- 
2.51.0

