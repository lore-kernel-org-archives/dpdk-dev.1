Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D558C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:25:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28CE0402F1;
	Tue,  4 Feb 2025 17:23:14 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 31B604066D
 for <dev@dpdk.org>; Tue,  4 Feb 2025 17:22:50 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 8E3CC210D0CB; Tue,  4 Feb 2025 08:22:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E3CC210D0CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686168;
 bh=aU95CxSQ32eGwxTs9PzkQr4sApQZ2NfhPJCOkkqcfpg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pLI6/OPH+CRduu6OK3xuRYEmzpBQ3iLzV7WwVKniA3WPWq10KI3cpMlaopZcN24Aw
 4N5LA4Mm9vMtwW1ZpWA2JXsW23rr7+QZTGTSNUZ3lVKwtHfacHwjPGK3sn9RTqIyG/
 ZFQNfHqoypxxtJs647BwjU/8KxyvBc7GRbFT6GhE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: konstantin.ananyev@huawei.com, thomas@monjalon.net,
 david.marchand@redhat.com, Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v20 27/27] config: add -Wvla project-wide
Date: Tue,  4 Feb 2025 08:22:04 -0800
Message-Id: <1738686124-16173-28-git-send-email-andremue@linux.microsoft.com>
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

Add -Wvla project-wide so that VLAs are not allowed by default. This
is to avoid new VLAs from being introduced.

Meson files in directories which are not yet VLA-free have already
been updated with -Wno-vla to avoid build breaks.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 config/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config/meson.build b/config/meson.build
index a251ce49b1..710206095b 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -345,6 +345,7 @@ endif
 
 no_wvla_cflag = []
 if cc.has_argument('-Wvla')
+    add_project_arguments('-Wvla', language: 'c')
     if not is_windows
         no_wvla_cflag = '-Wno-vla'
     endif
-- 
2.47.2.vfs.0.1

