Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D10606A324
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 23:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD71F40274;
	Mon,  2 Nov 2026 00:21:45 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by mails.dpdk.org (Postfix) with ESMTPS id C214940264
 for <dev@dpdk.org>; Mon,  2 Nov 2026 00:21:43 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36a18fc7a38so3826951eec.1
 for <dev@dpdk.org>; Sun, 01 Nov 2026 15:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kev009.com; s=google; t=1793575302; x=1794180102; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NzVS8cSzOPZvbIh2JnyIkdgoEcdX9sLEKihuwt86nZo=;
 b=oH9/MTLXWCiW5K5rTbyv/wiQIAnT1OvYJoIvPfg0+gofEvRjCo2dh2E4RX7CZK8fXe
 eGtk1kAuYpOmvALYQPUnML0dH7L1HqkJVe4A2bkqrzZbos/YdkRO1j7nJNGAoG9rmfVr
 XV7uv3Lj5X8sl8jfV6kbHxCfNUySUeNkVjltY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575302; x=1794180102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NzVS8cSzOPZvbIh2JnyIkdgoEcdX9sLEKihuwt86nZo=;
 b=szoxIF2NeGwGZgR0dDK26ofaF22M4vIytwU304WYyQuLiCObUUiFrYJnQwPFCSGHPU
 KsvbTQ0hkyRcs8JAyFvqLX3A4oTjIl6r/bTTJnLX41bKRW7sp/1e8rfaiEELeFVuWRBs
 sKcPEP2fFsL4sXqlZlm1EtB+kRyRgnm7YpTFo0LlSf1H3nfy17DH2z/dQs5Z9E9kL6Sm
 1gEUCAkXDvOHp14BBE4QOMuyl0S6sKJ6ItBJr4PYB+elkdP6kJNhR+KfKgjQUuXGDvMZ
 5K15APlNfeNIBYzRsiJpq/Tj+qHGBPVEnuDh6JSM6kziJns2GNYWzUiERgcprx25KXm3
 o8+w==
X-Gm-Message-State: APuU4Z/o1qHTsT5eaqtDyPktuF/3+30y+Rv+XqkfsUwlb7RO5SIzLYDW
 BMLgeHbWrV6B0WEppgf6p5VpB01wsVoCDGVD/xz/rC0EvA2lX9Vu/lm4i2CYnPT8YAM9B9PgqC3
 mWj06HGLe
X-Gm-Gg: AYBFou21L02qB31AlEpV2gJ1rPvYtd1FZbhUuQSG14onC1NVzUR2xY3JI48rewMPsEB
 UpLGMja0hxI1VvqGk8FYhx7tfNGpSDl1HLnwLiRxAO1giMQs2B7VilDS/C6fVBj1x7oUm2PYsHM
 aqw0I8VEfW+pMoSP6f4hrDfR3sgT7+Nftc1zxcpX6ro/q/Fr4riR4wPwVeAD3GFk08Mt8mb/X0d
 SqulwzLXntci36VSqVVKv332J66LB+9HkTtrsppXDJ9SeHrezHCiOnVPr004wBBVeCXte92AxhM
 5PW5/th+RsgLlTidtEUTPydtPmg4jo8NoFjC1ntm8Ql6cHTiHo6MfZ2OGrzB0JOYb4kSwceKiM5
 jRwssep8MhtvJkfpC8xH15KT1BiYjmvJOm86QF4lI84BEJWacr2vg3R118A1cCCEDDBV2d1kd/a
 XLWF+7nLiBwdvgaKe5No2WK1FCmdIjcqfqzvyTvl3xjBn0hc+9yqYRN6TArUB2ZECfVMgzKXgCW
 S8MveJoR5NySPyIDRufNIqhBIwGk9922NxAqFCrdxqzh5DDCpDWTWEVS2S9ePdqUa72hSoYNZvq
 NQJRt8XepZGD8Wif3p+N+IqWF5ghEMEFOKIWhUMVl71pDPfrcG9z2FHKneOOs51OBvOpASa/Yax
 1z3xIQIgvLHvtg3cO1LC8MuDP3Meeb6wfP6dAhrviVN3PIXrIl1Ij4Uo/FLUkbaqvWSYjFmsema
 rpNuqfvY8=
X-Received: by 2002:a05:7300:c01c:20b0:36a:54a0:6b4c with SMTP id
 5a478bee46e88-36a54a06b95mr9006090eec.25.1793575301764; 
 Sun, 01 Nov 2026 15:21:41 -0800 (PST)
Received: from kev-ws-aurora.cv0.bbox.io ([172.83.102.10])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm36318950eec.26.2026.11.01.15.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 15:21:41 -0800 (PST)
From: Kevin Bowling <kevin.bowling@kev009.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Soumyadeep Hore <soumyadeep.hore@intel.com>, stable@dpdk.org
Subject: [PATCH] net/iavf: fix AdminQ polling after interrupt setup failure
Date: Sun,  1 Nov 2026 16:21:40 -0700
Message-ID: <20261101232140.94324-1-kevin.bowling@kev009.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,TVD_FROM_1,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The device alarm skips AdminQ processing when the PF advertises WB_ON_ITR.
However, this capability does not guarantee that interrupt registration
succeeds. FreeBSD nic_uio cannot register device interrupts, so the VF
still needs alarm polling. Without it, commands such as RSS configuration
and statistics queries time out and device configuration fails.

Record whether AdminQ uses alarm polling instead of deriving that choice
from the PF capability. Initialize polling on each device initialization
and disable it only after interrupt registration and enablement succeed.
If enablement fails, unregister the callback before retaining polling.
Keep the shared PHC alarm and unconditional alarm cancellation unchanged.

Validated the backport to 25.11.4 on FreeBSD with an E810 ice PF: the stock
PMD failed configuration in three trials, while the correction passed 45
queue restarts, 42 full device resets and 6,432 exactly received frames.

Fixes: 388f0b348065 ("net/iavf: reuse device alarm for PHC sync")
Cc: stable@dpdk.org

Signed-off-by: Kevin Bowling <kevin.bowling@kev009.com>
---
GitHub review: https://github.com/DPDK/dpdk/pull/125

 .mailmap                             |  1 +
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 17 +++++++++++------
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 492bb56acb..5c666ba171 100644
--- a/.mailmap
+++ b/.mailmap
@@ -889,6 +889,7 @@ Keith Wiles <keith.wiles@intel.com> <keith.wiles@windriver.com>
 Kent Wires <kent.wires@intel.com>
 Kerem Aksu <kerem.aksu@i2i-systems.com>
 Keunhong Lee <dlrmsghd@gmail.com>
+Kevin Bowling <kevin.bowling@kev009.com>
 Kevin Laatz <kevin.laatz@intel.com>
 Kevin Lampis <klampis@solarflare.com>
 Kevin Liu <kevinx.liu@intel.com>
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 8b826662c6..5550e57c35 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -399,6 +399,7 @@ struct iavf_adapter {
 	bool phc_sync_paused;
 	struct iavf_devargs devargs;
 	bool mac_primary_set;
+	bool adminq_polling; /* Interrupt setup fell back to alarm polling. */
 	uint16_t tpid;  /* VLAN tag identifier */
 };
 
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index fd1067c252..47aa6ecb6f 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -2924,15 +2924,15 @@ void
 iavf_dev_alarm_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
-	struct iavf_info *vf;
+	struct iavf_adapter *adapter;
 	if (dev == NULL || dev->data == NULL || dev->data->dev_private == NULL)
 		return;
 
-	vf = IAVF_DEV_PRIVATE_TO_VF(dev->data->dev_private);
+	adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct iavf_hw *hw = IAVF_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint32_t icr0;
 
-	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)) {
+	if (adapter->adminq_polling) {
 		iavf_disable_irq0(hw);
 
 		/* read out interrupt causes */
@@ -3107,13 +3107,18 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
 			&eth_dev->data->mac_addrs[0]);
 
+	adapter->adminq_polling = true;
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR &&
 			/* register callback func to eal lib */
 			rte_intr_callback_register(pci_dev->intr_handle,
-				   iavf_dev_interrupt_handler, (void *)eth_dev) == 0)
-
+				   iavf_dev_interrupt_handler, (void *)eth_dev) == 0) {
 		/* enable uio intr after callback register */
-		rte_intr_enable(pci_dev->intr_handle);
+		if (rte_intr_enable(pci_dev->intr_handle) == 0)
+			adapter->adminq_polling = false;
+		else
+			rte_intr_callback_unregister_sync(pci_dev->intr_handle,
+						  iavf_dev_interrupt_handler, eth_dev);
+	}
 
 	rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
 			  iavf_dev_alarm_handler, eth_dev);

base-commit: c981dcfe134e4c641951ee15a76de0b56aafb05a
-- 
2.56.0

