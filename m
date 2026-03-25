Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0B9108B91E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 01:45:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 202584027A;
	Wed, 25 Mar 2026 02:45:12 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 78E95400D6
 for <dev@dpdk.org>; Wed, 25 Mar 2026 02:45:10 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 08E7C20B6F01; Tue, 24 Mar 2026 18:45:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08E7C20B6F01
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stephen@networkplumber.org,
 Long Li <longli@microsoft.com>
Subject: [PATCH 1/2] eal: return error on devargs truncation in hotplug MP
 messages
Date: Tue, 24 Mar 2026 18:45:05 -0700
Message-ID: <20260325014506.1866374-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
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

The EAL hotplug multi-process messaging uses a fixed-size buffer
(EAL_DEV_MP_DEV_ARGS_MAX_LEN, 128 bytes) for device arguments.
When devargs exceeds this limit, strlcpy silently truncates the
string. This causes secondary processes to receive incomplete
devargs during hotplug re-add, leading to failed port
re-initialization.

For example, a MANA PCI device with 6 mac= arguments:

  mac=AA:BB:CC:DD:EE:01,mac=AA:BB:CC:DD:EE:02,
  mac=AA:BB:CC:DD:EE:03,mac=AA:BB:CC:DD:EE:04,
  mac=AA:BB:CC:DD:EE:05,mac=AA:BB:CC:DD:EE:06

produces a 131-byte devargs string that gets silently truncated
to 127 bytes, losing the last MAC address.

Return -E2BIG from rte_dev_probe() and rte_dev_remove() when
devargs would be truncated, instead of silently corrupting data.

Signed-off-by: Long Li <longli@microsoft.com>
---
 lib/eal/common/eal_common_dev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 7185de0cb9..de24d14d28 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -250,6 +250,11 @@ rte_dev_probe(const char *devargs)
 
 	memset(&req, 0, sizeof(req));
 	req.t = EAL_DEV_REQ_TYPE_ATTACH;
+	if (strlen(devargs) >= EAL_DEV_MP_DEV_ARGS_MAX_LEN) {
+		EAL_LOG(ERR, "devargs truncated (len %zu, max %d)",
+			strlen(devargs), EAL_DEV_MP_DEV_ARGS_MAX_LEN);
+		return -E2BIG;
+	}
 	strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
@@ -397,6 +402,12 @@ rte_dev_remove(struct rte_device *dev)
 
 	memset(&req, 0, sizeof(req));
 	req.t = EAL_DEV_REQ_TYPE_DETACH;
+	if (strlen(devargs) >= EAL_DEV_MP_DEV_ARGS_MAX_LEN) {
+		EAL_LOG(ERR, "devargs truncated (len %zu, max %d)",
+			strlen(devargs), EAL_DEV_MP_DEV_ARGS_MAX_LEN);
+		free(devargs);
+		return -E2BIG;
+	}
 	strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);
 	free(devargs);
 
-- 
2.43.0

