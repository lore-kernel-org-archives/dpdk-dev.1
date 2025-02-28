Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27DCC282C5
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 20:36:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 821BA402C2;
	Fri, 28 Feb 2025 21:36:09 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 12A2740280;
 Fri, 28 Feb 2025 21:36:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 36D83210D0DA; Fri, 28 Feb 2025 12:36:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36D83210D0DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740774967;
 bh=p+wHPSh0YdeFzJ5eImMuNa3NXk4tEx3N/lvIAhadYGw=;
 h=From:To:Cc:Subject:Date:From;
 b=lEO6QshD374gnWyFGbpIFolNjhuyDPDXtoZ/cewpbbIKtTzEiAzZyvvKGC6R/2hnM
 uCzE/mM5+sxFXbBE9gk+6bNOwjv/lM4LnW77XDvgn6ErfXNgyv1gHFgJrGSnu3piJB
 sFBLxM910jh9EG6oaIQL0dBZAi4fa+NpJhqjOqJk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Andre Muezerie <andremue@linux.microsoft.com>,
 stable@dpdk.org
Subject: [PATCH] config/x86: increase lcores for AMD EPYC in 'native' scenario
Date: Fri, 28 Feb 2025 12:35:46 -0800
Message-Id: <1740774946-20418-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

File config/meson.build has logic to move cpu_instruction_set from 'auto'
to 'native' or 'generic'.

When calling get_option('cpu_instruction_set') again from
config/x86/meson.build we get 'auto' again, instead of expected 'native'.

The fix is to not call get_option('cpu_instruction_set') again, just rely
on the work done by config/meson.build and trust that cpu_instruction_set
already has the correct value. Note that getting/processing
cpu_instruction_set is not x86-specific, so should be handled by
config/meson.build.

Fixes: fd8b058b322e ("config/x86: increase lcores for AMD EPYC cross build")
Cc: stable@dpdk.org

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 config/x86/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config/x86/meson.build b/config/x86/meson.build
index 47a5b0c04a..a6d917c78c 100644
--- a/config/x86/meson.build
+++ b/config/x86/meson.build
@@ -104,7 +104,6 @@ epyc_zen_cores = {
     '__znver1__':128
     }
 
-cpu_instruction_set = get_option('cpu_instruction_set')
 if cpu_instruction_set == 'native'
     foreach m:epyc_zen_cores.keys()
         if cc.get_define(m, args: machine_args) != ''
-- 
2.48.1.vfs.0.0

