Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A74C0218A
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 04:08:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A46A40DF8;
	Mon,  3 Feb 2025 05:07:25 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 34954406BC
 for <dev@dpdk.org>; Mon,  3 Feb 2025 05:06:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 0CE6C2054922; Sun,  2 Feb 2025 20:06:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CE6C2054922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738555608;
 bh=XX83F6jTPPstTVxG2Fp3urWxYW1XMHKRIECZhjpTpOM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lZMskbPe7Hb31dgZeriPG53ZzC7vr1zxRfzx/fwJ3U5tzuKyAptm6W1Yoq/LRPG1k
 Pry/YUQwUt8Lgr/n28PuFoG4nqgWMKhkVRMCekoE3ZF27K0+xeNMn/qF0fa5S0pd8i
 2lquCxwwIJhMW4JBkiPWuD2ZDfrL1Aypcj+uM9oM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v19 21/27] config: define no_wvla_cflag
Date: Sun,  2 Feb 2025 20:06:24 -0800
Message-Id: <1738555590-12753-22-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
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

We define no_wvla_cflag in a top directory so that it can be used by
meson.build files in lower directories that are not yet VLA-free.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 config/meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/config/meson.build b/config/meson.build
index 6aaad6d8a4..a251ce49b1 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -342,6 +342,14 @@ if cc.get_id() == 'intel'
         warning_flags += '-diag-disable=@0@'.format(i)
     endforeach
 endif
+
+no_wvla_cflag = []
+if cc.has_argument('-Wvla')
+    if not is_windows
+        no_wvla_cflag = '-Wno-vla'
+    endif
+endif
+
 foreach arg: warning_flags
     if cc.has_argument(arg)
         add_project_arguments(arg, language: 'c')
-- 
2.47.2.vfs.0.1

