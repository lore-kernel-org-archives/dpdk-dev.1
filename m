Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0059BCCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:48:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64397406A2;
	Wed, 29 Apr 2026 20:47:51 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id C91F3406A2
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:47:48 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12c8f9846c8so142389c88.0
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777488468;
 x=1778093268; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ezz8cMrd5rAmdGKGrdQl/SVrqXGWrao9JHddaZjx3CA=;
 b=rrceBvstbkXODij3WO8/2WR15SY5kT2m38ak7Ly769I2LL6uWHRpUeOrrELJi0DGxG
 v86Hi2vF28uwkj1wGYqvyg/gN2Kx3+QvkXM+EhL8hcq6gXagiuotmziHXUhbE/ZY3djZ
 NpA8ZrEwgkyg0/AK7RL5orZwu9Ccps2QGapGLb7VNPrk7+9D3WAG3tNhPIiAZtuxNQQ3
 +Af/HamLrU//K88Er0E1ib/Wz3Zra9pAC8FtaH+jkuGmMiLi9lJTGv6wJbjOuO6yGx6w
 EoWWd/sWidSv1r8iGZkpf3BMkoqiS9QvxDZnoCY749TBz0ZCbt7UJve6uX2XGGI7JbbI
 4tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488468; x=1778093268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ezz8cMrd5rAmdGKGrdQl/SVrqXGWrao9JHddaZjx3CA=;
 b=KPYrff4lPcrwntzbTTvA1PwGLhmt/EC3bVd56GqR4uLgOlSK61ZFfLIBvpzVoC/Ozs
 3EoPKRMYSY2X9RSXDVecK6a6Vo9TGKWVGrJcgkuGAXGqtDvTuxigvup08qw5SMglHH43
 movdx4u1rHDac7MACoSCYERJh3WCVeTjjoK9W9wmJiX+Ujwh9Cqa/hNhl1wmGd5gJknP
 87WRurUqNNgRm/EaLuaBBU9NQaC9X4NPavpXLLA4aUKQCdvZ6j+03QVIqVxe2lUAT+qo
 7Su6or3cD9rmNwgMfPt8jP40KQcnZPQrtXRL/udjmtqNwnCAXtHp91YV4jhWCzumsuGT
 V2mA==
X-Gm-Message-State: AOJu0YzbjWUzCSF6kynafCB+1KmDAMxqgbL9zkANcK0svTseleU6Elpr
 M5ksNAMxJo+FhCduTyE/jITd4oAPfPGrzswzehiHmhej12DRhCoSvogN3+YxDiZw4vqPzOOPCeK
 h8b7H
X-Gm-Gg: AeBDievx4m6WYc1IE1RXKINSISjaCWJW7JKVGr2G0DW4lhur4gu3hPQY8/LHLFI4O8t
 SAnQiWrxG681/yqnCpzCZJUSpOZDxhU/IFr9hopsjEGeMON835cuJcGg62qSkXidzmHdq1W0IBu
 GB0iFSn2tVLAtACOUnQR6y+RPS1vbI/drGtt4HTZToyhc2HuSR+SdghNSoxsUl/EL4bN6fbwvcg
 z4KFBaIRX3QBHVnxIdg9EgiE70pbHBP+ueeFwmEmhnz89n2X68ppCQUW0tsXE8rW+O181TOctkK
 hk17O5H9YW+8r813WzOYMkwrojJMu2sOdzSqLvy18JIFxPwAQJlxzk4GCGuONMCmTM502dZEzhZ
 +btViUWNgoX7cfiNp8db2uxxNiY+mo2dtgdye37F5eY9L4b1CIfTn7zr/r2qZnOhpZiNbjd4lkc
 slIk8GC0ddhC8BdQ00ifL7XmaCjoW+0dF2Ij1VF1LhRCI=
X-Received: by 2002:a05:7301:1693:b0:2c9:ee15:a0d6 with SMTP id
 5a478bee46e88-2ed0a177736mr3931425eec.29.1777488467878; 
 Wed, 29 Apr 2026 11:47:47 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm3271027eec.24.2026.04.29.11.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:47:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Igor Russkikh <irusskikh@marvell.com>,
 Pavel Belous <pavel.belous@aquantia.com>
Subject: [PATCH v3 4/7] net/atlantic: fix mbox_mutex for multi-process
Date: Wed, 29 Apr 2026 11:46:41 -0700
Message-ID: <20260429184739.706250-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429184739.706250-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260429184739.706250-1-stephen@networkplumber.org>
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

The Atlantic driver supports secondary processes. The mbox_mutex in
aq_hw_s lives in dev_private (shared memory) and must be initialized
with PTHREAD_PROCESS_SHARED.

Bugzilla ID: 662
Fixes: e9924638f5c9 ("net/atlantic: add FW mailbox guard mutex")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/atlantic/atl_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_ethdev.c
index 2925dc2478..f8744da221 100644
--- a/drivers/net/atlantic/atl_ethdev.c
+++ b/drivers/net/atlantic/atl_ethdev.c
@@ -5,6 +5,7 @@
 #include <rte_string_fns.h>
 #include <ethdev_pci.h>
 #include <rte_alarm.h>
+#include <rte_thread.h>
 
 #include "atl_ethdev.h"
 #include "atl_common.h"
@@ -405,7 +406,7 @@ eth_atl_dev_init(struct rte_eth_dev *eth_dev)
 
 	hw->aq_nic_cfg = &adapter->hw_cfg;
 
-	pthread_mutex_init(&hw->mbox_mutex, NULL);
+	rte_thread_mutex_init_shared(&hw->mbox_mutex);
 
 	/* disable interrupt */
 	atl_disable_intr(hw);
-- 
2.53.0

