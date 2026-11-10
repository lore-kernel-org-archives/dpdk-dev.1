Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A5606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dBOu+lSD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9099D40E30;
	Tue, 10 Nov 2026 14:40:55 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mails.dpdk.org (Postfix) with ESMTPS id DE76B4027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 10:42:45 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so1190088f8f.3
 for <dev@dpdk.org>; Tue, 10 Nov 2026 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794303765; x=1794908565; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7QD4JsPE7nmErzaF5tHl0tKvc0A6dv/Iif1Hcw1LOxY=;
 b=dBOu+lSD4c1s8n3SYDoeO0oh6FvXc/AneXBmCqYv8V3TXVxeY65/gzMG1xl3agTTd+
 9rrMZEdbjWckUKkPbsh//0hUeiP6bRONoxPHPv5Ncyt1amSGVJ47FKjbNEGp3eQBATuu
 6x8PgZaruRwmB5ut17H1au1VaYMuiiHqMzhTL1KLmxdtkcgUhansfOZSsEbUgn/Bf8q8
 wbvYgSOhKpjuyUOLY3cim3jwLBsbdrnGwZzetYYQfp/Z8ZmbvJ7NRCgYJzaIMqXLISRy
 zAsCZt12Y07yuXJbhSLWtUmyE+2cdDrE1AteU1jfUyC+VP7+RbYBLNeXbcoHckN9qfR2
 FMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794303765; x=1794908565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7QD4JsPE7nmErzaF5tHl0tKvc0A6dv/Iif1Hcw1LOxY=;
 b=xe5TmwmaOv4xFjCc/qAdzXUBXYP7jzapALCkIrwL0zH6CkWblRzv0NXusKjaX4i0Yg
 GKONUySb8rSbWa/kW5cTYBwy+hoq28VbQPNVD7iT1W3aOH1qoEYk7CVIJ04K7wZC05JN
 BG/1WuoLaSFX1cOgUNtbiEUyV+Ddep+83wjausr/NcmhEvMSN+m4iaU63I3NmpAAzoJF
 Hg5Ch2qc3R7NCTxN12rYZ2r6pTxDOfNO91YPsfRxJAl+q+yAoTAyMEbP0u9OnM7BM6Pv
 pojD39219ss+VXLWL/+IJZWmiN3d0kkgegQK00aFxqffqBEIkNSn0XDK5K700cZbfsfP
 6MQA==
X-Gm-Message-State: APuU4Z87dLpCZAigan/BnKyqmLto52q75zAnQuBd8A16xFJFMZy50txH
 1mokyhIpi+WYSry0PMdwISAqRQgmukYJbeVfC1U2aCa6d7LIMq1VxAu51705ZBaY
X-Gm-Gg: AYBFou0FgGu1X35ZEoHGuOliPpZzyJ4f4t46fCGyvNJV5sJ71LQiF4kG9urOwBiEZ/B
 Y1XUa6FOLqwljFTLxBAaypcfF8zoNUv2Cco/hMTWOzrFw7THsohf4q4EVXJDYw4gxcjdcur0U7b
 Rg0k4utCXJi5BlsXxY1GV1rZ1EcRslDU+xaIjzBPrUsbet59NtB3EnHDUQ4DjyluJTldrN3xUyd
 D2amP6W/Jk+ntG/MoTNykuiESZAYL51EcAMktMGHQRB2K3NBcRaT7cMCs1LL+YqqHL3MBDIg7ar
 ttmM3YuQR1196JOMkgYOucW+SZ/cRvCxNYx2b/J2IKgtATh6XLhlaKuUD/mFdXv5O4ewZz/74JC
 r05yw88stYUytsTi3xtsEQmErm86ze0f0JP4n609DiNa8Al1M9Lbo5s42DFCiPU3qu+QwnAFlyD
 yM0KkCssCq7wDxndR47Dm4Dq5XCRN/75JWGGidJjOT5MhAXwe5r60YWy4flkC/xKmZKwOT/p0O/
 YlCaFnkKStVlgUsnvi34t4MTIc2CkHQUbOxAncPUutNzBRJCC4g243ZU5hBUUhJeklZ/2+Z2HjM
 1EEx4fIy1zSXMaNcnXqFj2MAkIAEdYVDC701E7J4ZdpkrbbZqCrfukbaOVh+QHr+/GML3r0KzBs
 dFPtvAHzkY9ouoOEAResVR23M2xGBfpyDMPWetPFtVahm3Ps=
X-Received: by 2002:a05:600c:474c:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4ba0234f937mr33682535e9.25.1794303765161; 
 Tue, 10 Nov 2026 01:42:45 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net
 ([131.189.143.225]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983585923bsm4227849f8f.11.2026.11.10.01.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 01:42:44 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>,
 Long Li <longli@kernel.org>, Aditya Garg <gargaditya@microsoft.com>
Subject: [PATCH] net/mana: do not block Rx interrupt calls during a reset
Date: Tue, 10 Nov 2026 09:42:43 +0000
Message-ID: <20261110094243.151321-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109142127.7a54ee80@phoenix.local>
References: <20261109142127.7a54ee80@phoenix.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 14:40:54 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rx interrupt enable and disable wait for reset_ops_lock and then
return -EBUSY if a reset is in progress. The reset thread holds that
lock across the teardown (mana_dev_stop(), the RESET_ENTER request
to secondary processes, mana_dev_close()) and across the re-probe,
and each request to the secondaries may take up to
MANA_MP_REQ_TIMEOUT_SEC. An lcore that calls rx_intr_enable or
rx_intr_disable during one of those steps blocks for that long,
only to get -EBUSY.

Retry the trylock while the device is active, and return -EBUSY as
soon as it is not. Outside a reset the lock is held only by another
queue's doorbell write or event read, so the wait stays short; once
a reset has started, the caller returns at once.

Suggested-by: Wei Hu <weh@microsoft.com>
Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
Applies on next-net for-main, on top of efa36b47334d ("net/mana: fix
Rx interrupt enable failing on lock contention"). Squash it into that
commit if you prefer.

Follow-up to Wei's review and the AI review note:
https://inbox.dpdk.org/dev/20261109142127.7a54ee80@phoenix.local/

Builds with meson -Dwerror=true (gcc 14, rdma-core 56). With no reset
in progress the calls take the lock and run the same code as before,
so the Azure results in efa36b47334d still apply. A MANA reset cannot
be triggered on demand on Azure, so the reset path is untested.

The burst_state gate stays a possible follow-up for main.

 drivers/net/mana/mana.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index f624cde6b9..eea9dac253 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -451,14 +451,21 @@ mana_reset_trylock(struct mana_priv *priv)
 }
 
 /*
- * Like mana_reset_trylock(), but wait for the lock. Used by Rx interrupt
- * enable/disable, which every queue calls on each sleep and wakeup: they
- * must not fail just because another queue holds the lock for a moment.
+ * Like mana_reset_trylock(), but wait while another queue holds the lock.
+ * Used by Rx interrupt enable/disable, which every queue calls on each
+ * sleep and wakeup: they must not fail just because another queue holds
+ * the lock for a moment. Once a reset has started, fail at once instead
+ * of waiting for its teardown or re-probe step.
  */
 static int
 mana_reset_lock(struct mana_priv *priv)
 {
-	pthread_mutex_lock(&priv->reset_ops_lock);
+	while (pthread_mutex_trylock(&priv->reset_ops_lock)) {
+		if (rte_atomic_load_explicit(&priv->dev_state,
+		    rte_memory_order_relaxed) != MANA_DEV_ACTIVE)
+			return -EBUSY;
+		rte_pause();
+	}
 
 	if (rte_atomic_load_explicit(&priv->dev_state,
 	    rte_memory_order_acquire) != MANA_DEV_ACTIVE) {
-- 
2.52.0

