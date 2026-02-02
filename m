Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C4CE7DEF2
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 15:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 264B040E0C;
	Mon,  2 Feb 2026 16:34:58 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 88E4C402D8
 for <dev@dpdk.org>; Mon,  2 Feb 2026 16:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770046494;
 bh=uL4WmbwZPleilheW1O7iiIXPVc1K2UeXwbZtWq6IEcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=goLks2HpZTA+0v7BXnyU3U1Kd5fThV9D1vZVoxZCtV0d7ItXCNB9d4/ElfBEfDDWH
 17XYGKtEJ6KTT8WSm4RK+hIaJeDkSCpnooKll1DQVBU2pcbC7IHEAoWd8vsX1m/eW5
 xgd80bJv2PnE3L37/YBhZ1Yw+Zbusw3+pIVBkj7HjZAnkVxAFIHMVoXLm/6ozZ4D0b
 HnjcYOSSwNLNUeLHI3vDxhtxTEOOCJH2nFUrmDIop0aP/P/eiISp8EyVEcceTCFY6G
 CPDMwkj8bZiqhceQu2JDQZ9Kh8ISx+oACbbzw8ex8tqNVoPHPUHZHbA0ZVQt5hsdBl
 mJEyqeL+ranIA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 614A61180072;
 Mon,  2 Feb 2026 16:34:54 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v6 3/8] net/nfb: add vdev as alternative device probe method
Date: Mon,  2 Feb 2026 16:34:44 +0100
Message-ID: <20260202153449.3295979-4-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202153449.3295979-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260202153449.3295979-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

VDEV are useful for NFB devices not represented by PCI device,
e.g. virtual or simulated devices.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/meson.build |   1 +
 drivers/net/nfb/nfb_vdev.c  | 106 ++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 drivers/net/nfb/nfb_vdev.c

diff --git a/drivers/net/nfb/meson.build b/drivers/net/nfb/meson.build
index d7a255c928..9e458dfb4a 100644
--- a/drivers/net/nfb/meson.build
+++ b/drivers/net/nfb/meson.build
@@ -16,6 +16,7 @@ ext_deps += dep
 
 sources = files(
         'nfb_ethdev.c',
+        'nfb_vdev.c',
         'nfb_rx.c',
         'nfb_rxmode.c',
         'nfb_stats.c',
diff --git a/drivers/net/nfb/nfb_vdev.c b/drivers/net/nfb/nfb_vdev.c
new file mode 100644
index 0000000000..b79f7ac416
--- /dev/null
+++ b/drivers/net/nfb/nfb_vdev.c
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Cesnet
+ */
+
+#include <rte_kvargs.h>
+#include <ethdev_vdev.h>
+
+#include "nfb.h"
+
+#define VDEV_NFB_DRIVER net_vdev_nfb
+#define VDEV_NFB_ARG_DEV "dev"
+
+static int
+vdev_nfb_vdev_probe(struct rte_vdev_device *dev)
+{
+	unsigned int count;
+	int ret = 0;
+	size_t len, pos;
+
+	struct nfb_probe_params params;
+
+	const char *vdev_name = rte_vdev_device_name(dev);
+	const char *vdev_args = rte_vdev_device_args(dev);
+	char *dev_params, *dev_params_mod;
+	struct rte_kvargs *kvargs;
+
+	kvargs = rte_kvargs_parse(vdev_args, NULL);
+	if (kvargs == NULL) {
+		NFB_LOG(ERR, "Failed to parse device arguments %s", vdev_args);
+		ret = -EINVAL;
+		goto err_parse_args;
+	}
+
+	dev_params = strdup(vdev_args);
+	if (dev_params == NULL) {
+		ret = -ENOMEM;
+		goto err_strdup_params;
+	}
+
+	params.device = &dev->device;
+	params.specific_init = NULL;
+	params.specific_device = NULL;
+	params.path = nfb_default_dev_path();
+	params.args = dev_params;
+	params.nfb_id = 0;
+	params.ep_index = -1;
+
+	len = strlen(dev_params) + 1;
+	pos = 0;
+	dev_params[pos] = '\0';
+
+	/* Parse parameters for virtual device */
+	for (count = 0; count != kvargs->count; ++count) {
+		const struct rte_kvargs_pair *pair = &kvargs->pairs[count];
+
+		if (!strcmp(pair->key, VDEV_NFB_ARG_DEV)) {
+			params.path = pair->value;
+		} else {
+			/* Clone non-vdev arguments, result is shorter or equal length */
+			dev_params_mod = dev_params + pos;
+			ret = snprintf(dev_params_mod, len, "%s%s=%s",
+					pos == 0 ? "" : ",", pair->key, pair->value);
+			if (ret < 0 || ret >= (signed int)len)
+				goto err_clone_args;
+			pos += ret;
+			len -= ret;
+		}
+	}
+
+	strlcpy(params.name, vdev_name, sizeof(params.name));
+
+	ret = nfb_eth_common_probe(&params);
+	if (ret)
+		goto err_nfb_common_probe;
+
+	free(dev_params);
+	rte_kvargs_free(kvargs);
+
+	return ret;
+
+err_nfb_common_probe:
+err_clone_args:
+	free(dev_params);
+err_strdup_params:
+	rte_kvargs_free(kvargs);
+err_parse_args:
+	return ret;
+}
+
+static int
+vdev_nfb_vdev_remove(struct rte_vdev_device *dev)
+{
+	return nfb_eth_common_remove(&dev->device);
+}
+
+/** Virtual device descriptor. */
+static struct rte_vdev_driver vdev_nfb_vdev = {
+	.probe = vdev_nfb_vdev_probe,
+	.remove = vdev_nfb_vdev_remove,
+};
+
+RTE_PMD_REGISTER_VDEV(VDEV_NFB_DRIVER, vdev_nfb_vdev);
+RTE_PMD_REGISTER_ALIAS(VDEV_NFB_DRIVER, eth_vdev_nfb);
+RTE_PMD_REGISTER_PARAM_STRING(net_vdev_nfb,
+		VDEV_NFB_ARG_DEV "=<string>"
+		);
-- 
2.52.0

