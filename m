Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A6EC44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 17:03:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 094A342DDC;
	Wed, 21 Jan 2026 18:03:43 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 9130C427C5
 for <dev@dpdk.org>; Wed, 21 Jan 2026 18:03:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1769015018;
 bh=gxH7z4B+Kfejsaoqh3eGfHxidHDEay5S1b5NLTpjDfs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gJT/sB5lYf9Bdmm/RRRXp61RPE2zJmOvaCV7+A9wxsoQX/k2vr7pZtul02UlkADH+
 +d41jCviyJjIrvvaVrM//Yuu9Bml3cPwVtPNszQTSYhNb6pvHaYJ/ovtiu3wQZYPrZ
 VtqYqdVSPblVMNx1PyroY19BJQxH62xdtWDOIDtPTHA0JXVEW64FEqPzj1FdMwBagY
 M79+oGHzZo+aRTH8hrvI44rEgJqUYxxtzlzH/mJsfwOd0IDPKHal5qDN9bAQZPtwPG
 QfrRcQkCuKQ3eL/8sXS1M6uMyQ/Tr4hh+trqiXr8YRHyJRQB72NGkbSgMl+evjeg1t
 BQ7tVCDNNpEjQ==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 68A6D1180081;
 Wed, 21 Jan 2026 18:03:38 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH v3 3/8] net/nfb: add vdev as alternative device probe method
Date: Wed, 21 Jan 2026 18:03:28 +0100
Message-ID: <20260121170333.272985-4-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121170333.272985-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260121170333.272985-1-spinler@cesnet.cz>
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
 drivers/net/nfb/nfb_vdev.c  | 100 ++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
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
index 0000000000..adda148056
--- /dev/null
+++ b/drivers/net/nfb/nfb_vdev.c
@@ -0,0 +1,100 @@
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
+
+	struct nfb_init_params params;
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
+	params.args = dev_params;
+	params.path = nfb_default_dev_path();
+	params.nfb_id = 0;
+
+	dev_params_mod = dev_params;
+
+	dev_params_mod[0] = 0;
+
+	/* Parse parameters for virtual device */
+	for (count = 0; count != kvargs->count; ++count) {
+		const struct rte_kvargs_pair *pair = &kvargs->pairs[count];
+
+		if (!strcmp(pair->key, VDEV_NFB_ARG_DEV)) {
+			params.path = pair->value;
+		} else {
+			/* Clone non-vdev arguments, result is shorter or equal length */
+			ret = sprintf(dev_params_mod, "%s%s=%s",
+					dev_params_mod == dev_params ? "" : ",",
+					pair->key, pair->value);
+			if (ret < 0)
+				goto err_clone_args;
+			dev_params_mod += ret;
+		}
+	}
+
+	strlcpy(params.name, vdev_name, sizeof(params.name));
+
+	ret = nfb_eth_common_probe(&dev->device, NULL, NULL, &params, -1);
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

