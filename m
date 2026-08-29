Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43999C61DB9
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 02:45:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ED314025A;
	Sat, 29 Aug 2026 04:45:08 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 3623340151
 for <dev@dpdk.org>; Sat, 29 Aug 2026 04:45:07 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-398a4dcf289so455400a91.2
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787971506;
 x=1788576306; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UEBy45UURQDt34Y7CG+0PdU77VzPp1LtAk/+LY/LrJc=;
 b=ERxEQIF8ITfinOGz9a4Bx/2bq9XjnqlpmN8ErFK73ETpM/Jxb8rEp0Q9sxirmHj72P
 NZuL1ySmaCwVnPKnWxCwjcTsewLosKAscSvLBislZG4JT0TmW3i9uCEcLXl17jG/c4lq
 9qui6ollanC79KX8GylglGcKbMPDQ4HTOut0oe5i2qeF4/Ui69kCG2RlPNaX+7Jx1lhE
 XA0ZoxRYAkoGayMumiccg9FI3q8Okfu9JK7JNWJi2fE1J9BWcFcBp7tySX4LD64n0tqL
 SyCSxtBWKZgg3bx6lgyDI7EYMCsY7mPAcVTchcu05CBz34z6MBxLldihM81J5S5DbyBN
 KJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787971506; x=1788576306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UEBy45UURQDt34Y7CG+0PdU77VzPp1LtAk/+LY/LrJc=;
 b=HgR1OGbVak8/Wzr+tVS0jaNhavm4lfrvADT/34p43yDnUTKA4OXDhcqEbsKXiSTed/
 /zyomhS3PjFqMJk8rN3lMSivZxhCTwe/zaiyqnLzCFoF4vfV7+tqDQzSNshwQK43QR9M
 e5B0+EkJhzdL2BqaIBYt3P5OLyuCrGmcu2CTy4zJ3OUJY7W6O8BxHje88wGNZRut2t94
 Qsn/2fjBfDhDVS7TgicH+xBzkTDvoy1oALhkCL0K6+cEGv4NjcSFtKMbb2hcCewU6LzM
 KyNEmMbHHONJbUoUaTMcFB6w4rxSGQcIkE8ULDbDT/YHTgBPerBG/7xEqLlcx+a0ei9D
 izLg==
X-Gm-Message-State: AFuF++mjF1tA+VsGSxZGNjR4nVYHbOhEd+w/auhklbDaczO0ORxtqeWt
 Xhyk3H4o7fdnp3yDBJ7ZJl0NSHkB51tUIKEcAqkfE6TGoKo2msFSiL4XX2eATapHpcdVorYLt7+
 0MZe+
X-Gm-Gg: AYBFou0HtOMm2RfTN3+WxNiV/dt470CbdOIPUprG/uUWvAs8r6HVdbZSsX9CmfM38lf
 g77eY5rGMQDyH19VXVVTWEPoMubrHuPYnt0bsfcfvwnxq+wN4IgY/cGGPjUsHaYOqamYFUhK+NI
 gboM7U2n6CPW3vG4DtX4d/ILzHg1MqqI3OKMnWoYQCRH3i99NPdPaYhnstSZ78tQo3pZVFktsBP
 THoWCqiVLMB4JzNfU2o3jOxmSP+s3e4mC25ZiCCdSr27+NDexwftc6x3whoWeLm+Wd49Im9JR2k
 uwWD7zQO60XnD2+9C9ENsUaiy+Cec8Y61+sqcAZXERHGdTAczrfyobKpllPqhO3Wvo7MxIV+n63
 YAWphEwg7+IYRw+jUXPtrTYAjuJuL6W0fndBWHxle6Qra4zBO7DKaGHJmrCBTXi9jLIqlBwKt6E
 1ciSa4MTpHVvsQEMTrGq5j+liALvj4FuYZhxzCCKmgfCm8auo7AyZI6DIi9Pk90G6IOkouBWVpA
 g7BXD3wWVb046kyJgy99KJugn3JNJRdKlR7UQ==
X-Received: by 2002:a17:90b:1d04:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-396d0f75f2fmr21264663a91.11.1787971505067; 
 Fri, 28 Aug 2026 19:45:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b1992e05sm9651374a91.15.2026.08.28.19.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 19:45:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: [PATCH 1/2] examples/vm_power_manager: fix includes
Date: Fri, 28 Aug 2026 19:43:52 -0700
Message-ID: <20260829024455.1557201-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828215350.2861715-1-thomas.petazzoni@bootlin.com>
References: <20260828215350.2861715-1-thomas.petazzoni@bootlin.com>
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

Use include-what-you-use to get the correct set of includes
for this command.

Reported-by: Guillaume Gardet <Guillaume.Gardet@arm.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../vm_power_manager/guest_cli/vm_power_cli_guest.c  | 12 ++++++++----
 .../vm_power_manager/guest_cli/vm_power_cli_guest.h  |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
index 4114593cee..cd0d87d1e7 100644
--- a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
+++ b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.c
@@ -2,21 +2,25 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
-
-#include <stdint.h>
 #include <string.h>
 #include <stdio.h>
-#include <termios.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <stdlib.h>
 
-#include <cmdline_rdline.h>
 #include <cmdline_parse.h>
 #include <cmdline_parse_string.h>
 #include <cmdline_parse_num.h>
 #include <cmdline_socket.h>
 #include <cmdline.h>
+
+#include <rte_build_config.h>
 #include <rte_log.h>
 #include <rte_lcore.h>
 #include <rte_ethdev.h>
+#include <rte_errno.h>
+#include <rte_ether.h>
 
 #include <rte_power_cpufreq.h>
 #include <rte_power_guest_channel.h>
diff --git a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.h b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.h
index b578ec0723..a93fabfa8e 100644
--- a/examples/vm_power_manager/guest_cli/vm_power_cli_guest.h
+++ b/examples/vm_power_manager/guest_cli/vm_power_cli_guest.h
@@ -5,6 +5,8 @@
 #ifndef VM_POWER_CLI_H_
 #define VM_POWER_CLI_H_
 
+#include <rte_common.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.53.0

