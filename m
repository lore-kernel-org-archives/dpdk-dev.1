Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4A4C79FBD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63F1C410FD;
	Wed,  9 Sep 2026 17:04:56 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 3160840EF1
 for <dev@dpdk.org>; Wed,  9 Sep 2026 17:04:55 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so46907365e9.2
 for <dev@dpdk.org>; Wed, 09 Sep 2026 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788966295; x=1789571095; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AcWIpN/vBaKAiRs4rEZ3PJ962/Gpeytc3794JW5y7Ow=;
 b=gcT9rMqBG41fwq8lk7S/ddEG0UZs+s4zY9UHHUuuPvVoBMyKaiAhlTqjfPc6U9b739
 pYGhSAhHO7fx44ML+1zrIX3vzB9EI+jdSPuIYjZZ057ugBhiSD9bIY0ImdKpb6rY9edB
 gOjiz5AO/eiaigsWWqAXMVfhgybko0/ngzSjB6381fp7GTzTe0Ge77TLIaqpPiVdv5F2
 tysSN5DkbKr5wfVLtBtsVKa9Ad+I3YRca4lZe2to1ygHRN4Xx05ShofWiVShY8JVwEhG
 kwg+5DQYktKOI0G2oq8EP8NoSwBlRlj1vBKnpqQvuABGx4AGY3lyn4HhZZTRhSzgrtQr
 /DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788966295; x=1789571095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AcWIpN/vBaKAiRs4rEZ3PJ962/Gpeytc3794JW5y7Ow=;
 b=oF4M7pkw8SLcl/yuxcsLPs5+kafn0ScCfYLsMBipratDCn3vAWB5UO9NL5+il/AnaD
 fN940k4Wlou7H3zRNOsi3m75D+sbt1kRXntc/tT8Lna9jdKVyWGWRXB6LgOs678Py0+P
 Rds5nK8IMYHj9y7rUYk7rkyDbIen865MY8I0w4IXL2Ssh+gaGM04Y3AkeX6kJ0cwvjA4
 eOuGAmHwoDFW3Y9Q7gkh35oAfocTHMT3xWx0hVS0QgmGsuW0tCM4LDUYNNIiJ8pCwKb9
 y8qegMGxQsc9VNckAm1Coxi30S6CsE7FU9w5jAfXQJIsfF/hVDG3r+3Iz0tVzcsWkqMx
 c/hA==
X-Gm-Message-State: AFuF++knLrtuDFfAFjwaZp16SuJ6ss0O/bXlcKo8I6QmE1hX42uYtG3H
 wYWbiUwDamxje0/x80FHCNT7/KBfR8aREK65EbV7aDtFmNxhf05moncMnOIvuA==
X-Gm-Gg: AYBFou1j16YckWUil45lbVA7M86ehxpWg9TA34SuCgZYdwR5OhJGHCuz3HT+ECLBtMS
 IdS6dBnjMc1CXU+dRSEhDkmyWy8s+9R6tA9SzO7MT4sIQsc5TecLnrEHGeZczGKZz9YMA7euMhc
 cqQY9xoXK9Qud8/2aG7H1Los0jW55bb2kmhQ5aPBNf5qXkb16LgJxXBJQWb7WtCYPkMdptbZfYR
 jXKlCjpSFV3J3cKtcastl10jL348wjM7yUcbLRTpsP4Ufa4G/d1tBFtC5Nc+c7tGUs6b65LvYG2
 xuHUaMCOoOivJQ6qhJf5wj1DhJmXhr2Rn4ViJzMzdY/rYkwQY1/+xaNouImAioXyfXkxDe5GmXF
 RWlk12E5f5w5DnfXIn4ZztFJYF4AZeeouSDahmQjZEOCajo6nDIy+2RzZ3JGpjK4kG4HZ8vF53o
 Hiko4S54+8Pf3zxsGB5NpKmRO2ruOHhQkxpRyD6lEr5zkdv7tjUmPjupwKNyrqpHi5QD9wNgsIS
 rGS1kiMcV9lj5qE9zoeVkUmdjUqTJduA0zTQxI6BqhQTN4Xt7pPbArt6QEf
X-Received: by 2002:a05:600d:8481:20b0:49c:fde6:8b39 with SMTP id
 5b1f17b1804b1-49cfde68bacmr236168165e9.29.1788966294642; 
 Wed, 09 Sep 2026 08:04:54 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm589954875e9.6.2026.09.09.08.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:04:54 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, anatoly.burakov@intel.com,
 sivaprasad.tummala@amd.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 1/6] examples/l3fwd-power: factor out Rx interrupt sleep
 path
Date: Wed,  9 Sep 2026 17:04:44 +0200
Message-ID: <20260909150449.856295-2-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909150449.856295-1-maxime@leroys.fr>
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260909150449.856295-1-maxime@leroys.fr>
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

