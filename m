Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B602DCA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32975406B6;
	Fri,  9 Oct 2026 01:37:04 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 5A4C340653
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:01 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-8935f42e8f0so619701b3a.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502620;
 x=1792107420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2lpXFXBTNZaFdQ/QEQBzHea5S+oeyB+taHPKkIad/co=;
 b=ceAvss+wCTit2y+ojQR1Ztc++hmzaMUZTs1eTC92iQd42WJRHLDvVuOBVTCh7zAqxD
 A9OsHOptvCKU5MS0G73XNIHmeIDYB1YpboNbAr18wQaK2X0Voadg9gshrFAojSXGv6vs
 CisL1Luxy9w2yUNkJoplvf6NTSnuXKSxBxYqVoZaxr/zakZnvRuadK0jrAPtCRPIJoCv
 rYhjaTHVqmN0IVILL3/gnVK8oo+2nFSyCiqZQIT96f4+O4T2RIov+a2nyQej8QXF0wuD
 kAG+Gd4nCctJ3QWwOFofte7YiKJ3+Rha82dTnCA1qtG392Uk02I25m4DIvZbDLWbuQGl
 mh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502620; x=1792107420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2lpXFXBTNZaFdQ/QEQBzHea5S+oeyB+taHPKkIad/co=;
 b=OUf9LbTUsuOtI6Vi+fdmlQelZP2TXlhHUBcey572i84ACoLBh3seHSokLwY/ep8l9A
 u2EWiQmoTnpmI1OaCpoGQp9bKkGmdRUDXxD55wGdgOfavU7uTnQk7hS8Hcg88Gfgbcnx
 wlEYhlSfRacmTV0SYMEeAJWIgg+YmmADqCqX7TPivzVQur3YVfWemUHfHUoJ51iqVTju
 J4nRgo0ZJz/CM6VB2yV6hHUpZBsrxqO+yAz96zIRmXw/KbozfTXBGivVX+E3tHt50xxy
 pAeIraMHetMlWuVXqB9W1okrGNjZva4ZoDsvFswhlfjo1n5MLv6bc+JxNVGMB8fmaKKx
 02Ng==
X-Gm-Message-State: AFq9FYLzQFUORHlyAIkfui/Q3sz2ASDAr56/EzoEiR7JxuERHCAaC5xW
 FlEmgZMtATKFXAV3VKcoxd+E9S2BHW7Z/OGLA9s15GqOme/C5fcN8M4E2azyUahc26MqHM6OtKz
 LfSLI6ew=
X-Gm-Gg: AYBFou3nlj9Oi7Qj1ChoAIvvb2vCL3+md9MtiF/SvfvcLyClKXZL9zpULtlPhOM5a2C
 SH1YE2MEvACkaO96L0hwXa9vLpKP9ayMN7NysckQdOCpj0WjCs8+bmuv6hJDvtdkOUKL9ll1rN/
 rAoonTfzCNRN+98UxuPfiA0mSnw/CTVEERc8ojTmJKcXLVMXCL6IpG50SB0tZbB6LEN8YpCjboM
 6d/eLq+Rom8UZGRrCZi0xXk/iPSh5hDPuafNhodgkhKX4WEGKnGvTtJWWdI4toy1O+jfPBk5B2s
 2eGj/GE4iODIT2OcshyGklLHohRw0h8PRG3O76wKsnR66n+dii+fmAopY6sPEAI0sNISMVxaS8Y
 xuuV3d3QdBpMZPu2SXLXZMosgVpIREPV+5LwN0tTT/v0Wqa1jPI2cTwQ4fJu5vuAy5frtldyy1C
 rKa8HwVSKJRXsBTGFC76G5JVmpMVY/+LROI8MntJUQGT5g/QDia7itqxwmPJSZC6VKYMNp9vEBB
 r+RFwyv0sz704lLq87tcJZSr/D8wslfdD6RRg==
X-Received: by 2002:a05:6a00:3e12:b0:886:77eb:38fb with SMTP id
 d2e1a72fcca58-897c6e1b5f0mr53046b3a.25.1791502620503; 
 Thu, 08 Oct 2026 16:37:00 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 08/29] net/intel: replace rte_smp_rmb
Date: Thu,  8 Oct 2026 16:35:01 -0700
Message-ID: <20261008233649.1260843-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

Replace deprecated rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c     | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index b333444cbf..d01d869e1b 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1963,7 +1963,7 @@ ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		for (j = ICE_LOOK_AHEAD - 1; j >= 0; j--)
 			s[j] = rte_le_to_cpu_16(rxdp[j].wb.status_error0);
 
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 
 		/* Compute how many status bits were set */
 		for (j = 0, nb_dd = 0; j < ICE_LOOK_AHEAD; j++)
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 60222693fe..ce0a3dde34 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -1549,7 +1549,7 @@ ixgbe_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		for (j = 0; j < LOOK_AHEAD; j++)
 			s[j] = rte_le_to_cpu_32(rxdp[j].wb.upper.status_error);
 
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 
 		/* Compute how many status bits were set */
 		for (nb_dd = 0; nb_dd < LOOK_AHEAD &&
-- 
2.53.0

