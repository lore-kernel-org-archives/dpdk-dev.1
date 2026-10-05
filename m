Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F89DCA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:50:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46BB740E09;
	Tue,  6 Oct 2026 01:50:57 +0200 (CEST)
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com
 [74.125.82.227]) by mails.dpdk.org (Postfix) with ESMTP id 0BB1240A6B
 for <dev@dpdk.org>; Tue,  6 Oct 2026 01:50:56 +0200 (CEST)
Received: by mail-dy1-f227.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso736409eec.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791244255; x=1791849055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YCLgTfJSIB+q7VHh6xSP+9pkWJNwpxGJcnWtzFcmUE4=;
 b=YFlvNHHJElYXa6t/ZKK0a433EBfPw7CPQLI6p49f0DnVcxZjU4WulzJ0dOyUrAA4mt
 H2llZxr66De+ikRwyZUBPPg3XlqeK4xj2DXsRkOnZfeNWDU4cMxb/ZdXqQ3Sc8uNYE72
 iFW00IiCySIq86b+rXOdwXdGvCazfkuSXi5wDX5uQZG2W/E/5JyZMFF2n7nbofTdAcLq
 g1vWr7TNvyyn1Te2uw/3FKdHQK1OTlDkDSMNszSniy5yoxYYrTtOJmvQb4SRPP4/kQLw
 i1h6PSZmMKqa5fX26h52pMIy19ay2FIqxjFj2FQIL/shDHPnlAbP5xyLRx/6MOtPgacL
 xeSA==
X-Gm-Message-State: AFuF++lDEmUJpuqVIRCUGSy3hiC1HRhIBbdP9RC6Q10VtmsEY2lGhgXz
 O4R9lANN2IymFvzHQaz8oOZkxNY1b3bQ1ctldvetTKzLpU2Mfspb3fMVPV+soWkyOw8dFaMsuIf
 vkZZ/mhOuLvfJOunvBQwYzw2gavlPF4ZoqpcnopS1VKLuC16MLr9Qo3B1BRul12EPXjX9yLMGb/
 RE6lpJH5+24L0crHbQxM42Vy+bjN4pvQGxHi6f4KfjnDfMGIPyzGHaEqcqYa13wNqwqxjVoA==
X-Gm-Gg: AYBFou1EcOhbYCs7IENW9ZHwbRvwqHWtmSAkgXUbU8F7E7B4vjO7uu7X5sRKxIpr7ds
 NlCB+DMHnq6mGeNFdCqn1Kki2mI5h/Iz6AhsrhdEMyY2PfaoE3r2rl82NLoYOKOdDZ0crwk4lLF
 6c+8VxIGMrC8jbtc1cyOcbPNc9gVQreYTeBNetHks8bMBe0ld0IpgCnektoxra/bMJx0CGWpy2o
 vpDhgtwQcdwuutjWex9yqIpkGddP1E9SwMcU5+CpqRNtT839RUyxWyi6YEIRlHiD4ynb6vLPfe0
 kJcpoekOgdM+09H/u8av8GXbGsEZ6MdUSp9DeNUHo14eChOJbaYlhalxyWkLbQXUvjkCoxwXZIR
 jxjpzIy2SyZUof5J/3JISoNpBD3uFaAFzl4U36ZmogrUpCXwcsNivqWV6SZoWA+ys/ftgk1vX7W
 r2Jnr+DaitxwIA5VTjKeSX0wOVVvIt9BJLl3g=
X-Received: by 2002:a05:7301:4201:b0:351:48f7:c0b0 with SMTP id
 5a478bee46e88-35148f7c289mr609697eec.38.1791244254726; 
 Mon, 05 Oct 2026 16:50:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-35146a45b40sm5790eec.21.2026.10.05.16.50.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:50:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5339732335dso26267611cf.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791244253; x=1791849053; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YCLgTfJSIB+q7VHh6xSP+9pkWJNwpxGJcnWtzFcmUE4=;
 b=dWBPtBh9avaiUdkWMbb56VLIJ6vLMoS8FQbB/xYNF2GiaLn+MnAnVPx5ZSMiosY7Et
 HmDjl3MC5SJWXCDKm59kNLp8OyokpuYSoE4aShiwYqyeRFGUCwi4KjaOyE/AhkoZc0xa
 3Q5BbOOpMcvn7nsoVMtS17TWD3d2v7nT3Lv3Q=
X-Received: by 2002:a05:622a:4d07:b0:532:d845:d46d with SMTP id
 d75a77b69052e-533bc67b17cmr236954491cf.5.1791244253195; 
 Mon, 05 Oct 2026 16:50:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4d07:b0:532:d845:d46d with SMTP id
 d75a77b69052e-533bc67b17cmr236954121cf.5.1791244252570; 
 Mon, 05 Oct 2026 16:50:52 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398aa0baesm107791721cf.13.2026.10.05.16.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 16:50:52 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joey Zhong <xiaozhen.zhong@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix HA timer spinlock leak
Date: Mon,  5 Oct 2026 18:50:49 -0500
Message-Id: <20261005235049.27024-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Joey Zhong <xiaozhen.zhong@broadcom.com>

ulp_ha_mgr_timer_cb() acquires the global ULP context spinlock via
bnxt_ulp_cntxt_entry_acquire(). When myclient_cnt is transiently 0,
the function did a bare return without calling
bnxt_ulp_cntxt_entry_release(), leaking the lock and deadlocking all
subsequent flow operations on the device.

Replace the bare return with goto cb_restart, matching every other
error path in the callback: it releases the lock and restarts the
timer. Since a zero client count is transient, restarting the timer
is the correct behavior, so the misleading "kill timer" log message
is updated accordingly.

Fixes: 1993b267dbcb ("net/bnxt: cleanup ULP parser and mapper")
Cc: stable@dpdk.org

Signed-off-by: Joey Zhong <xiaozhen.zhong@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_ha_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_ha_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_ha_mgr.c
index 7b7c10d360..d558f78c8c 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_ha_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_ha_mgr.c
@@ -256,8 +256,8 @@ ulp_ha_mgr_timer_cb(void *arg)
 	myclient_cnt = bnxt_ulp_cntxt_num_shared_clients_get(ulp_ctx);
 	if (myclient_cnt == 0) {
 		BNXT_DRV_DBG(ERR,
-			     "PANIC Client Count is zero kill timer\n.");
-		return;
+			     "Client Count is zero, skip and restart timer.\n");
+		goto cb_restart;
 	}
 
 	tfp = bnxt_ulp_cntxt_tfp_get(ulp_ctx, BNXT_ULP_SESSION_TYPE_SHARED_WC);
-- 
2.31.1

