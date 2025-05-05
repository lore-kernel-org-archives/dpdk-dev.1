Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD901C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 19:47:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 786BF4025D;
	Mon,  5 May 2025 21:47:03 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0ED174003C
 for <dev@dpdk.org>; Mon,  5 May 2025 21:47:02 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 21D612115DC6; Mon,  5 May 2025 12:47:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21D612115DC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746474421;
 bh=FU7oUxl83VUcgOrI96dENewnHGkvvFtbDsAFdFqdgZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PLb1iBvkQVOZcd/bqE1+Bsc7Oaj3jJ2LGd1R7RPS22YRLICuAmYfFOewS10zhF68d
 DVD7rZ4Ho4VMR1gL2wIRuIa2eaGzc/4ue2TbYHikV3lY4kA78+2a9ew/nG/Jsy1sh3
 BqJKS2hr+ftR5gsigvJPJG/W2/Vnw3D0lM67MHbg=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
Date: Mon,  5 May 2025 12:46:45 -0700
Message-Id: <1746474405-5056-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling drivers on Windows, instances have been seen where a
temporary directory fails to get cleaned up due to
ERROR_SHARING_VIOLATION (32).

Code inspection did not reveal problems with the DPDK code and scripts,
and this issue was only seen on Windows. Adding a 1 second sleep before
cleaning up the temporary directory seems to be effective, but to
guarantee that this break does not happen anymore, flag
"ignore_cleanup_errors" is set to "True".

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 buildtools/gen-pmdinfo-cfile.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/buildtools/gen-pmdinfo-cfile.py b/buildtools/gen-pmdinfo-cfile.py
index 5fbd51658a..2ddbdb9502 100644
--- a/buildtools/gen-pmdinfo-cfile.py
+++ b/buildtools/gen-pmdinfo-cfile.py
@@ -6,9 +6,10 @@
 import subprocess
 import sys
 import tempfile
+import time
 
 _, tmp_root, ar, archive, output, *pmdinfogen = sys.argv
-with tempfile.TemporaryDirectory(dir=tmp_root) as temp:
+with tempfile.TemporaryDirectory(dir=tmp_root, ignore_cleanup_errors=True) as temp:
     paths = []
     for name in subprocess.run([ar, "t", archive], stdout=subprocess.PIPE,
                                check=True).stdout.decode().splitlines():
@@ -19,3 +20,10 @@
                            check=True, cwd=temp)
             paths.append(os.path.join(temp, name))
     subprocess.run(pmdinfogen + paths + [output], check=True)
+
+    if os.name == "nt":
+        # Instances have been seen on Windows where the temporary directory fails to get cleaned
+        # up due to ERROR_SHARING_VIOLATION (32).
+        # The sleep below is a mitigation for that issue, while ignore_cleanup_errors=True avoids
+        # failures when the issue is hit despite the mitigation.
+        time.sleep(1)
-- 
2.49.0.vfs.0.2

