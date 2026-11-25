Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F59606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=qh/z1WYl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF0F240696;
	Wed, 25 Nov 2026 15:06:36 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTPS id 2F9CB4064F
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:31 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=/nk9TSky1Ybo+YfZTaDfitcQphKDGSje/Sf/nyiCcOU=;
 b=qh/z1WYlE9FTupEnEOl8C3T5fi8n4mOz22C46h2Lubnk+vOMms9hTHKGQZlk7epyk0BCDAdde
 98Y6+FiAE+ybj/vtzDhBQEGYpGBAxTD7vp/kfnzFV5tnZU/MkqWebXA2S16u0FdD2LxJErzO0I6
 MLdULcc7fSkKANO05zDa3hI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jZM0X41Lvz1cyQR;
 Wed, 25 Nov 2026 22:06:04 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id DDAD54055B;
 Wed, 25 Nov 2026 22:06:28 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:28 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 9/9] power: add uncore frequency telemetry
Date: Wed, 25 Nov 2026 22:06:15 +0800
Message-ID: <20261125140616.3965843-10-yangshuaisong@h-partners.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
References: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Huisong Li <lihuisong@huawei.com>

The uncore power management API exposes frequency information that is
useful for runtime monitoring, but currently can only be queried through
application code calling the API directly. This makes it inconvenient
for operators to inspect uncore frequency status on a running DPDK
application.

Add telemetry endpoints to the power library so that uncore frequency
information can be queried externally via the standard DPDK telemetry
interface (e.g. dpdk-telemetry tool), without writing dedicated
application code.

Two commands are registered:
- /power/uncore/curr_freq: returns the current frequency index for a
  given package and die.
- /power/uncore/avail_freqs: returns the available frequencies for a
  given package and die.

Both commands take "pkg,die" as parameters and require the uncore power
environment to be initialized.

Documentation is updated to describe the new telemetry commands.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 doc/guides/prog_guide/power_man.rst    |  23 +++++
 doc/guides/rel_notes/release_26_11.rst |   6 ++
 lib/power/meson.build                  |   3 +-
 lib/power/rte_power_telemetry.c        | 129 +++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 1 deletion(-)
 create mode 100644 lib/power/rte_power_telemetry.c

diff --git a/doc/guides/prog_guide/power_man.rst b/doc/guides/prog_guide/power_man.rst
index 40ba7850a7..1af5adeec3 100644
--- a/doc/guides/prog_guide/power_man.rst
+++ b/doc/guides/prog_guide/power_man.rst
@@ -302,6 +302,29 @@ Get Num Pkgs
 Get Num Dies
   Get the number of dies on a given package.
 
+Uncore Telemetry
+~~~~~~~~~~~~~~~~
+
+The power library provides telemetry commands to query uncore frequency
+information for a given package and die.
+The uncore power management environment must be initialized before using
+these commands. The parameters are specified as a comma-separated pair
+``pkg,die`` (e.g. ``0,0``).
+
+#. Get the current frequency index for a given package and die::
+
+     --> /power/uncore/curr_freq,0,0
+     {"/power/uncore/curr_freq": {"pkg": 0, "die": 0, "curr_freq_idx": 3}}
+
+#. Get the available frequencies for a given package and die::
+
+     --> /power/uncore/avail_freqs,0,0
+     {"/power/uncore/avail_freqs": {"pkg": 0, "die": 0, "num_freqs": 4,
+      "0": 1800000000, "1": 2000000000, "2": 2200000000, "3": 2400000000}}
+
+For more information on how to use the Telemetry interface, see
+the :doc:`../howto/telemetry`.
+
 References
 ----------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dbb9cb6d93..2386f57614 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -342,6 +342,12 @@ New Features
   Added the ``hisi_uncore`` driver for managing uncore frequency on
   Hisilicon platforms via the Linux devfreq sysfs interface.
 
+* **Added uncore frequency telemetry.**
+
+  Added ``/power/uncore/curr_freq`` and ``/power/uncore/avail_freqs``
+  telemetry commands to query the current frequency index and the
+  available frequencies of a given uncore package and die.
+
 * **Added graph profiling.**
 
   Added build time configurable graph node profiling statistics
diff --git a/lib/power/meson.build b/lib/power/meson.build
index d89fb55514..292d31bf8a 100644
--- a/lib/power/meson.build
+++ b/lib/power/meson.build
@@ -20,6 +20,7 @@ sources = files(
         'rte_power_pmd_mgmt.c',
         'rte_power_qos.c',
         'rte_power_uncore.c',
+        'rte_power_telemetry.c',
 )
 headers = files(
         'rte_power_cpufreq.h',
@@ -33,4 +34,4 @@ driver_sdk_headers = files(
         'power_uncore_ops.h',
 )
 
-deps += ['timer', 'ethdev']
+deps += ['timer', 'ethdev', 'telemetry']
diff --git a/lib/power/rte_power_telemetry.c b/lib/power/rte_power_telemetry.c
new file mode 100644
index 0000000000..0217c39734
--- /dev/null
+++ b/lib/power/rte_power_telemetry.c
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <rte_telemetry.h>
+#include <rte_power_uncore.h>
+
+#include "power_common.h"
+
+static int
+parse_uncore_param(const char *params, unsigned int *pkg, unsigned int *die)
+{
+	unsigned long pkg_id, die_id;
+	char *end = NULL;
+
+	if (params == NULL || params[0] == '\0' || !isdigit((unsigned char)params[0]))
+		return -EINVAL;
+
+	pkg_id = strtoul(params, &end, 0);
+	if (end == NULL || *end != ',')
+		return -EINVAL;
+	die_id = strtoul(end + 1, &end, 0);
+	if (*end != '\0')
+		return -EINVAL;
+
+	if (pkg_id > UINT_MAX || die_id > UINT_MAX)
+		return -EINVAL;
+
+	*pkg = (unsigned int)pkg_id;
+	*die = (unsigned int)die_id;
+
+	return 0;
+}
+
+static int
+handle_power_uncore_curr_freq(const char *cmd __rte_unused, const char *params,
+		struct rte_tel_data *d)
+{
+	unsigned int pkg, die;
+	uint32_t curr_idx;
+	int ret;
+
+	if (rte_power_get_uncore_env() == RTE_UNCORE_PM_ENV_NOT_SET)
+		return -EINVAL;
+
+	ret = parse_uncore_param(params, &pkg, &die);
+	if (ret != 0)
+		return ret;
+
+	if (pkg >= rte_power_uncore_get_num_pkgs())
+		return -EINVAL;
+	if (die >= rte_power_uncore_get_num_dies(pkg))
+		return -EINVAL;
+
+	curr_idx = rte_power_get_uncore_freq(pkg, die);
+	if (curr_idx == (uint32_t)RTE_POWER_INVALID_FREQ_INDEX)
+		return -EINVAL;
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_uint(d, "pkg", pkg);
+	rte_tel_data_add_dict_uint(d, "die", die);
+	rte_tel_data_add_dict_uint(d, "curr_freq_idx", curr_idx);
+	return 0;
+}
+
+static int
+handle_power_uncore_avail_freqs(const char *cmd __rte_unused, const char *params,
+		struct rte_tel_data *d)
+{
+	unsigned int pkg, die;
+	uint32_t *freqs;
+	char key[12];
+	int num_freqs;
+	int ret;
+	int i;
+
+	if (rte_power_get_uncore_env() == RTE_UNCORE_PM_ENV_NOT_SET)
+		return -EINVAL;
+
+	ret = parse_uncore_param(params, &pkg, &die);
+	if (ret != 0)
+		return ret;
+
+	if (pkg >= rte_power_uncore_get_num_pkgs())
+		return -EINVAL;
+	if (die >= rte_power_uncore_get_num_dies(pkg))
+		return -EINVAL;
+
+	num_freqs = rte_power_uncore_get_num_freqs(pkg, die);
+	if (num_freqs <= 0)
+		return -EINVAL;
+
+	freqs = malloc(sizeof(uint32_t) * num_freqs);
+	if (freqs == NULL)
+		return -ENOMEM;
+
+	if (rte_power_uncore_freqs(pkg, die, freqs, num_freqs) != num_freqs) {
+		free(freqs);
+		return -EINVAL;
+	}
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_uint(d, "pkg", pkg);
+	rte_tel_data_add_dict_uint(d, "die", die);
+	rte_tel_data_add_dict_uint(d, "num_freqs", num_freqs);
+
+	for (i = 0; i < num_freqs; i++) {
+		snprintf(key, sizeof(key), "%d", i);
+		rte_tel_data_add_dict_uint(d, key, freqs[i]);
+	}
+
+	free(freqs);
+	return 0;
+}
+
+RTE_INIT(power_uncore_init_telemetry)
+{
+	rte_telemetry_register_cmd("/power/uncore/curr_freq", handle_power_uncore_curr_freq,
+			"Returns the current frequency index of an uncore domain. "
+			"Parameters: int pkg, int die");
+	rte_telemetry_register_cmd("/power/uncore/avail_freqs", handle_power_uncore_avail_freqs,
+			"Returns the available frequencies of an uncore domain. "
+			"Parameters: int pkg, int die");
+}
-- 
2.33.0

