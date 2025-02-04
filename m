Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE71FC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:24:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C90E40F35;
	Tue,  4 Feb 2025 17:23:05 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A81BC4060B
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 4397A210D0C2; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4397A210D0C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686168;
 bh=XX83F6jTPPstTVxG2Fp3urWxYW1XMHKRIECZhjpTpOM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BtxQyvzMUHjvUWUmaLV5aVy8NVGLtGlGfd+qQkYDHHUd5iHH8hP2JQars8LwdxvMi
 VuMR6VyoP+Mbz6Fj+TfP+q3kQNyCySv1sF493XOR9tjqbaJ6xZwdebKIUiEYwBQ8XP
 I+m3SezGLgGPVGKwtHcyy8wXP/DGfpukr4sHVpso=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v20 21/27] config: define no_wvla_cflag
Date: Tue,  4 Feb 2025 08:21:58 -0800
Message-Id: <1738686124-16173-22-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738686124-16173-1-git-send-email-andremue@linux.microsoft.com>
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

