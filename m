Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4B5108B91E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 01:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B64040A81;
	Wed, 25 Mar 2026 02:45:14 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3F2BC4042F
 for <dev@dpdk.org>; Wed, 25 Mar 2026 02:45:12 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id D13B020B6F01; Tue, 24 Mar 2026 18:45:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D13B020B6F01
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stephen@networkplumber.org,
 Long Li <longli@microsoft.com>
Subject: [PATCH 2/2] eal: add meson options for hotplug MP message buffer sizes
Date: Tue, 24 Mar 2026 18:45:06 -0700
Message-ID: <20260325014506.1866374-2-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260325014506.1866374-1-longli@microsoft.com>
References: <20260325014506.1866374-1-longli@microsoft.com>
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

Add meson build options to allow increasing the multi-process hotplug
message buffer limits at build time for deployments with many NICs:
- 'dev_mp_devargs_max_len' (default 128): max device args length
- 'mp_max_param_len' (default 256): max MP IPC message param length

Example: meson setup build -Ddev_mp_devargs_max_len=256 -Dmp_max_param_len=512

Guard the existing #defines with #ifndef so the meson-generated values
from rte_build_config.h take precedence when overridden.

Add a static_assert to ensure eal_dev_mp_req fits within the MP message
param buffer, catching misconfiguration at compile time.

Note: all primary and secondary processes must be built with the same
values, as these sizes affect shared IPC message struct layouts.

Signed-off-by: Long Li <longli@microsoft.com>
---
 config/meson.build          | 2 ++
 lib/eal/common/hotplug_mp.h | 6 ++++++
 lib/eal/include/rte_eal.h   | 2 ++
 meson_options.txt           | 4 ++++
 4 files changed, 14 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index 9ba7b9a338..d0c117dbc9 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -385,6 +385,8 @@ dpdk_conf.set('RTE_LIBEAL_USE_HPET', get_option('use_hpet'))
 dpdk_conf.set('RTE_ENABLE_STDATOMIC', get_option('enable_stdatomic'))
 dpdk_conf.set('RTE_ENABLE_TRACE_FP', get_option('enable_trace_fp'))
 dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
+dpdk_conf.set('RTE_MP_MAX_PARAM_LEN', get_option('mp_max_param_len'))
+dpdk_conf.set('EAL_DEV_MP_DEV_ARGS_MAX_LEN', get_option('dev_mp_devargs_max_len'))
 # values which have defaults which may be overridden
 dpdk_conf.set('RTE_MAX_VFIO_GROUPS', 64)
 dpdk_conf.set('RTE_DRIVER_MEMPOOL_BUCKET_SIZE_KB', 64)
diff --git a/lib/eal/common/hotplug_mp.h b/lib/eal/common/hotplug_mp.h
index 7221284286..df8f987ea6 100644
--- a/lib/eal/common/hotplug_mp.h
+++ b/lib/eal/common/hotplug_mp.h
@@ -6,13 +6,16 @@
 #define _HOTPLUG_MP_H_
 
 #include "rte_dev.h"
+#include "rte_eal.h"
 
 #define EAL_DEV_MP_ACTION_REQUEST      "eal_dev_mp_request"
 #define EAL_DEV_MP_ACTION_RESPONSE     "eal_dev_mp_response"
 
 #define EAL_DEV_MP_DEV_NAME_MAX_LEN RTE_DEV_NAME_MAX_LEN
 #define EAL_DEV_MP_BUS_NAME_MAX_LEN 32
+#ifndef EAL_DEV_MP_DEV_ARGS_MAX_LEN
 #define EAL_DEV_MP_DEV_ARGS_MAX_LEN 128
+#endif
 
 enum eal_dev_req_type {
 	EAL_DEV_REQ_TYPE_ATTACH,
@@ -27,6 +30,9 @@ struct eal_dev_mp_req {
 	int result;
 };
 
+static_assert(sizeof(struct eal_dev_mp_req) <= RTE_MP_MAX_PARAM_LEN,
+	"eal_dev_mp_req exceeds RTE_MP_MAX_PARAM_LEN, increase mp_max_param_len");
+
 /**
  * Register all mp action callbacks for hotplug.
  *
diff --git a/lib/eal/include/rte_eal.h b/lib/eal/include/rte_eal.h
index 7241f3be5d..aef431a88a 100644
--- a/lib/eal/include/rte_eal.h
+++ b/lib/eal/include/rte_eal.h
@@ -158,7 +158,9 @@ bool rte_mp_disable(void);
 
 #define RTE_MP_MAX_FD_NUM	253  /* The max amount of fds (see SCM_MAX_FD) */
 #define RTE_MP_MAX_NAME_LEN	64   /* The max length of action name */
+#ifndef RTE_MP_MAX_PARAM_LEN
 #define RTE_MP_MAX_PARAM_LEN	256  /* The max length of param */
+#endif
 struct rte_mp_msg {
 	char name[RTE_MP_MAX_NAME_LEN];
 	int len_param;
diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..c6d07a3308 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -48,6 +48,10 @@ option('mbuf_refcnt_atomic', type: 'boolean', value: true, description:
        'Atomically access the mbuf refcnt.')
 option('platform', type: 'string', value: 'native', description:
        'Platform to build, either "native", "generic" or a SoC. Please refer to the Linux build guide for more information.')
+option('mp_max_param_len', type: 'integer', value: 256, description:
+       'Maximum length of parameters in multi-process IPC messages.')
+option('dev_mp_devargs_max_len', type: 'integer', value: 128, description:
+       'Maximum length of device arguments in multi-process hotplug messages.')
 option('pkt_mbuf_headroom', type: 'integer', value: 128, description:
        'Default data offset (in bytes) in a packet buffer to leave room for additional headers.')
 option('enable_stdatomic', type: 'boolean', value: false, description:
-- 
2.43.0

