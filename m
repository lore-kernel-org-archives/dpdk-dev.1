Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31864C0218A
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 21:57:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 325354275C;
	Thu, 30 Jan 2025 22:56:13 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0B95640E48
 for <dev@dpdk.org>; Thu, 30 Jan 2025 22:55:46 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id DF979210C325; Thu, 30 Jan 2025 13:55:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF979210C325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738274144;
 bh=Kvsm1P7JlyZAW3koRmi6myrB2JIfooKZecWvm+NWQos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qA3RNlTRmW2kvcgHTTWP5r5Pon9RVfo3OE/95RRif36MFUTb5D4e3Nm9OBspaYugt
 81b5IFcm60KdmNeXdN6/45ZPOOw8V6E+H2rdwefWHtHZO4xfWEN3vzD+svJDZxDXU1
 c88fmMnkFueJLF5AHkwfLZ2iEyKxlNUMnVZ1RJHc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v18 26/26] config: add -Wvla project-wide
Date: Thu, 30 Jan 2025 13:55:35 -0800
Message-Id: <1738274135-2086-27-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738274135-2086-1-git-send-email-andremue@linux.microsoft.com>
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

Add -Wvla project-wide so that VLAs are not allowed by default. This
is to avoid new VLAs from being introduced.

Meson files in directories which are not yet VLA-free have already
been updated with -Wno-vla to avoid build breaks.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 config/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config/meson.build b/config/meson.build
index 6be928e04b..78f79b9a4d 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -345,6 +345,7 @@ endif
 
 no_vla_cflag = []
 if cc.has_argument('-Wvla')
+    add_project_arguments('-Wvla', language: 'c')
     if not is_windows
         no_vla_cflag = '-Wno-vla'
     endif
-- 
2.47.2.vfs.0.1

