Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D102C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 790FC40609;
	Mon, 20 Jul 2026 10:00:57 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id D769C402EB
 for <dev@dpdk.org>; Mon, 20 Jul 2026 10:00:55 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso7063765e9.1
 for <dev@dpdk.org>; Mon, 20 Jul 2026 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534455; x=1785139255; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AcWIpN/vBaKAiRs4rEZ3PJ962/Gpeytc3794JW5y7Ow=;
 b=XdkwwRuQCdMJ+pBLizxmQSWW78I3Fix1fYGEBxu32d5TGl1VmJRG57X7RW7jMSfDh/
 ql5zBdt9WsOBomsM59D72ITw05FX2u8NMJOuVTWibS993BBHfA4AARUyqJ4bjCqobFxI
 Kmlf9HOazu20v022/7mRVOR3fDicKceg6jorjxc6IEkHO7SFttxe/CseiEPCXIHNHtYA
 VusnDI5JLeUMdfi4hsZdLlkSjAx5nMcVt+ZDoWQZZmpK205lyjJGy+499AYzCSownBeC
 KXXlrjdBwkqdmjFrO7I3USUcNF7wN/NDcoVC68h2nlYEx1lCNujMtD3krM6Oqllt0gqE
 x1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534455; x=1785139255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AcWIpN/vBaKAiRs4rEZ3PJ962/Gpeytc3794JW5y7Ow=;
 b=KHHCqQbLuaOiYiVppEXvHSdSAMEKze+Zk/eEx3/bqlfbCWiIkQewTsedMbmPcDhY/P
 8txTCX3ZXE2+3x+4jxhfnjMQBQvNYIN8d5SFodDV7v0xeX7Zq4BOnXFYJ5oE+NrTUfMe
 YF0qsdokMHCqBZdtwckRRELzti4dtWICoGdC9Is9p/nAIIv/6xcClm+ngiV56wJnrmAo
 Se93fsvbJPmaYD1kvmPu2o/n5oUIe3lNk6Twz5so1EFVypXnK13xU+PHjEPMjEf2f42n
 BPwdubBgBjJMXU79Wmtd0xxJ6xw8qSALTNTthC7j2nKHsIMmWQZ557G8atA84gn5SX7M
 tpaQ==
X-Gm-Message-State: AOJu0YzTeXhtaokJEtTQn597kZpSDIFgRBnjTGDlVWpTDbvEGuCjt8IG
 CllMuoW8AmexqbMFruQ22gjAKRUPyly/OiDCnR+dPkQygg2QAqBvvoZUYqylyA==
X-Gm-Gg: AfdE7cn+6Lx10epTrs4eMb8gu75T6GGmMmHVAcb6ZG7m7BNOTwj7FmbNFr2ReJPhAxT
 eEpQ6iShNESwzt2CM1EO7OiAnnPAF96GSPaDgZ20zQTHjuYqxS35QfLSupgyhIKDFwNYp/hiLgH
 a0sqHwC0fBmjmsk8yNlfmLu/csYMmoE8PxNXrXSbBhcnGoigTnflxBM2JFr+KOCWqj0q78zwP+f
 BbW0aKMERRlmJHD7Y+mjqIZSijRaC3FKy0rYKoHWvLVkOxB2B+bslJs0/TuxXLsLBtbFzMJ3iXs
 6MZmo76o8LRKZoOZotQF0msTL9vmLcaJPwcr3tcG/tesP4s4bLT6d5mAeVY03lkigRKQAPDZUQF
 HdK9gcL/uRl1tBDhSpyHbF/6GvV8o2UMsM7R4mkwetCcLrFQuK+8dyo0LvatbvGDsYcMPsxbpWP
 Zosdd/StHoD3n/iFmPWgJrkAdCpMiRk6By4obIbd0n
X-Received: by 2002:a05:600d:9:b0:495:5e07:649b with SMTP id
 5b1f17b1804b1-4955e16aca3mr31809615e9.24.1784534455303; 
 Mon, 20 Jul 2026 01:00:55 -0700 (PDT)
Received: from freepad.sicorp.iliad.local (free-mobile.vlq16.iliad.fr.
 [213.36.7.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a47de7sm267351545e9.7.2026.07.20.01.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:00:54 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, sivaprasad.tummala@amd.com,
 Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 1/6] examples/l3fwd-power: factor out Rx interrupt sleep path
Date: Mon, 20 Jul 2026 10:00:30 +0200
Message-ID: <20260720080035.673782-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720080035.673782-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
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

The interrupt and legacy main loops carry an identical block that arms
the Rx queue interrupts of the lcore, sleeps until one triggers and
disarms them again. Move it to a helper so the following fixes touch a
single place.

No functional change.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd-power/main.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 705cab8f2d..764899217c 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -910,6 +910,14 @@ static int event_register(struct lcore_conf *qconf)
 	return 0;
 }
 
+static void
+rx_interrupt_wait(struct lcore_conf *qconf)
+{
+	turn_on_off_intr(qconf, 1);
+	sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
+	turn_on_off_intr(qconf, 0);
+}
+
 /* Main processing loop. 8< */
 static int main_intr_loop(__rte_unused void *dummy)
 {
@@ -1054,11 +1062,7 @@ static int main_intr_loop(__rte_unused void *dummy)
 			else {
 				/* suspend until rx interrupt triggers */
 				if (intr_en) {
-					turn_on_off_intr(qconf, 1);
-					sleep_until_rx_interrupt(
-							qconf->n_rx_queue,
-							lcore_id);
-					turn_on_off_intr(qconf, 0);
+					rx_interrupt_wait(qconf);
 					/**
 					 * start receiving packets immediately
 					 */
@@ -1372,11 +1376,7 @@ main_legacy_loop(__rte_unused void *dummy)
 			else {
 				/* suspend until rx interrupt triggers */
 				if (intr_en) {
-					turn_on_off_intr(qconf, 1);
-					sleep_until_rx_interrupt(
-							qconf->n_rx_queue,
-							lcore_id);
-					turn_on_off_intr(qconf, 0);
+					rx_interrupt_wait(qconf);
 					/**
 					 * start receiving packets immediately
 					 */
-- 
2.43.0

