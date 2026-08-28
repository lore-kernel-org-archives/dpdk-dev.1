Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F11C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 21:54:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BF394025A;
	Fri, 28 Aug 2026 23:54:04 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mails.dpdk.org (Postfix) with ESMTP id DA64E40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 23:54:02 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BA75B1A18B0;
 Fri, 28 Aug 2026 21:54:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7ED9160537;
 Fri, 28 Aug 2026 21:54:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0E3B611C78131; 
 Fri, 28 Aug 2026 23:53:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787954037; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=jHjfWRHhYhnMoh6I+UcG03gjBNcTE3+VLAsMN1PM8q0=;
 b=JZ8Ow33AQ13PhdUwS5SzjbPgcImJkOrksK/nBY/yAJaV6vIIPWEVEfB45kwNoRla8zbG0i
 UhMqVURqI0SSSEXtzpPRr4AgBRgnXhNNN9305HfA3kWEwdEO8DP8Ed4LEWzOQ9IELRDDrf
 JMGt7y1Vz/eAGyaH653WkdxJYE5zp0TR6FtOJK4ICsSWZmzP8hus1N5esZKA8LiMnO+0Ek
 Cs+WIUtZvSzaAbGn/VD4G/46eJjmvoGWGL9k+dyBHvDiATOFdQn1eaDmZ6RxYSRLMXI0BE
 LKZDSdPoFHY8uQ0lFUVONbYP2t0ug9D6YLDIPrSb9xh4XC77Sk2Y5kVzsOga3A==
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: dev@dpdk.org
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Guillaume Gardet <guillaume.gardet@arm.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Lee Daly <lee.daly@intel.com>,
 Marcin Hajkowski <marcinx.hajkowski@intel.com>
Subject: [PATCH RESEND] examples/vm_power_manager: add missing <stdlib.h>
 header include for strtol
Date: Fri, 28 Aug 2026 23:53:50 +0200
Message-ID: <20260828215350.2861715-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Guillaume Gardet <Guillaume.Gardet@arm.com>

strtol is defined in stdlib.h

Fixes the following build failure:

../examples/vm_power_manager/guest_cli/vm_power_cli_guest.c: In function ‘cmd_query_freq_list_parsed’:
../examples/vm_power_manager/guest_cli/vm_power_cli_guest.c:208:42: error: implicit declaration of function ‘strtol’; did you mean ‘strtok’? [-Wimplicit-function-declaration]
  208 |                 lcore_id = (unsigned int)strtol(res->cpu_num, &ep, 10);
      |                                          ^~~~~~
      |                                          strtok

Fixes: 0e8f47491f090f44a4956429cb27f6942b6618b0 ("examples/vm_power: add command to query CPU frequency")
Signed-off-by: Guillaume Gardet <guillaume.gardet@arm.com>
[Thomas:
- retrieve patch from
https://build.opensuse.org/projects/openSUSE:42:Factory-Candidates-Check/packages/dpdk/files/0001-examples-vm_power_manager-add-missing-header.patch?expand=1
- improve commit message]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 examples/vm_power_manager/guest_cli/vm_power_cli_guest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
index 4114593cee..63a59c8b10 100644
--- a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
+++ b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <termios.h>
 
 #include <cmdline_rdline.h>
-- 
2.55.0

