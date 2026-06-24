Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B261CD4F26
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 00:05:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E8E3402E5;
	Wed, 24 Jun 2026 02:05:52 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id AA48F40299;
 Wed, 24 Jun 2026 02:05:49 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id F0F6F20B7169; Tue, 23 Jun 2026 17:05:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0F6F20B7169
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, david.marchand@redhat.com, Long Li <longli@microsoft.com>
Subject: [PATCH v2] eal: return error on devargs truncation in hotplug MP
 messages
Date: Tue, 23 Jun 2026 17:05:31 -0700
Message-ID: <20260624000531.1562655-1-longli@microsoft.com>
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

Return -E2BIG from rte_dev_probe() when devargs would be truncated,
instead of silently corrupting data. rte_dev_remove() does not need
the same check because the length was already validated at probe time.

Fixes: 244d5130719c ("eal: enable hotplug on multi-process")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
v2:
 - Added Fixes: tag and Cc: stable@dpdk.org.
 - Moved the length check before memset() in rte_dev_probe().
 - Removed the redundant length check from rte_dev_remove();
   devargs length is already validated at probe time.
 - Dropped the [2/2] meson-options patch from this series; it will
   be sent separately.

 lib/eal/common/eal_common_dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
index 48b631532a..f3fc4d585e 100644
--- a/lib/eal/common/eal_common_dev.c
+++ b/lib/eal/common/eal_common_dev.c
@@ -271,6 +271,12 @@ rte_dev_probe(const char *devargs)
 	struct rte_device *dev;
 	int ret;
 
+	if (strlen(devargs) >= EAL_DEV_MP_DEV_ARGS_MAX_LEN) {
+		EAL_LOG(ERR, "devargs truncated (len %zu, max %d)",
+			strlen(devargs), EAL_DEV_MP_DEV_ARGS_MAX_LEN);
+		return -E2BIG;
+	}
+
 	memset(&req, 0, sizeof(req));
 	req.t = EAL_DEV_REQ_TYPE_ATTACH;
 	strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);
-- 
2.43.0

