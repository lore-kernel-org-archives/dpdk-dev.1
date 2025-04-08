Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E9FC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 13:06:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC5E140EDC;
	Tue,  8 Apr 2025 15:06:00 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 1319640EDC
 for <dev@dpdk.org>; Tue,  8 Apr 2025 15:06:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZX5sV20wzz13LV9
 for <dev@dpdk.org>; Tue,  8 Apr 2025 21:05:18 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 07FFE180104
 for <dev@dpdk.org>; Tue,  8 Apr 2025 21:05:58 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 21:05:57 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <haijie1@huawei.com>,
 <liuyonglong@huawei.com>
Subject: [RFC 1/1] build: support ThreadSanitizer
Date: Tue, 8 Apr 2025 21:05:56 +0800
Message-ID: <20250408130556.1054041-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250408130556.1054041-1-huangdengdui@huawei.com>
References: <20250408130556.1054041-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

ThreadSanitizer is a tool that detects data races. It consists of a
compiler instrumentation module and a run-time library.
Typical slowdown introduced by ThreadSanitizer is about 5x-15x.
Typical memory overhead introduced by ThreadSanitizer is about 5x-10x.

UBSan is integrated with gcc and clang and can be enabled via a meson
option: -Db_sanitize=thread.

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 config/meson.build | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index f31fef216c..dca1e2b5a4 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -519,6 +519,20 @@ if get_option('b_sanitize') == 'address' or get_option('b_sanitize') == 'address
     endif
 endif
 
+if get_option('b_sanitize') == 'thread'
+    if is_windows
+        error('TSan is not supported on windows')
+    endif
+
+    if cc.get_id() == 'gcc'
+        tsan_dep = cc.find_library('tsan', required: true)
+        if (not cc.links('int main(int argc, char *argv[]) { return 0; }',
+                dependencies: tsan_dep))
+            error('broken dependency, "libtsan"')
+        endif
+    endif
+endif
+
 if get_option('default_library') == 'both'
     error( '''
  Unsupported value "both" for "default_library" option.
-- 
2.33.0

