Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF1C53219
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:59:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51C9E40E19;
	Wed, 29 Jul 2026 19:57:52 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id D1ED940616
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:44 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1364145a91.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347864;
 x=1785952664; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJi9wNwE2/KA4iQ1ynk0UUlHDuvRjnv8OvLiKhUVtqw=;
 b=rETWPL9iek0jP14LBF5ZDEsWKmSe8OlggPRer2KfVOUSFKGqY/x30MGfEmKaPtSlvj
 YNg+NHedbDGiIq2/sOC8tBpFeyPhrY0wbsVe0MaLsHzqSr9xzz4f5sM6s4544eFK5j2X
 V4rkB44c8Gy6OyAld7doVw4PrDVNCdsYkP5C1NuSFNQ9AgWro6viXWRCPNqvd8QnNWFj
 zG3KU+R9TUWu22N7wEql41+2yl/KTaBiyiv8A5JiTF//6UJBqQlpLihP3ykf+/jSBAka
 3tJEvTboE9cj5/XFBTHrVi0exPpwsby/dTNrGoL8fDjCHhHAWCYpLQIhpqlwlgoZXVNi
 ZrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347864; x=1785952664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xJi9wNwE2/KA4iQ1ynk0UUlHDuvRjnv8OvLiKhUVtqw=;
 b=Bu9NuAYD7gzEckPNOrORh/PG4yazdGPa/Gagioq/yFiiZFzApGFlAZYRQ67G6+VDtK
 /kWBgQQd/5hdLDYwGVNpSgT8+q2g21RGSlgLEdAQfn0mjjHWLgUQTgcgoeh/bTjtgibk
 polzio9mYyEOHVLvSIyZjCSZ3jZEg6kw0Kdnv5YMMNUKDhFmkCV7oJYYVI9c3lnUcjkC
 tIa/uLhascEqF3aRAH0kEb8toeTtDTQabROafdLH2EbLF+/ThDCLEy+0XNRlfutkSnBJ
 jU0aGffQW1cxYY43TzzxMzyRcRG0YKY7I4BEbydMJ8aOdQK6KH2Fxa5Wa8yYlhtAttXH
 tk/A==
X-Gm-Message-State: AOJu0Yyx2XmlnaoD17mc9ZEt10+pUSo8Pz8Me/HXJwDe8rldE3tOnLpR
 HpG970NUj3C24HkK3b8cWfR3XEM+X96avB6inm7kS82VnwLAg+wm+12fchXE/D1xT2QTM1T1omp
 YIpZo
X-Gm-Gg: AR+sD11TTAqiE8Jt3uN+33jNAylJr87HRbFOfRH+z6AEsaHCkTWpB8nXnjY6xiEFS/2
 wGsPOlxl77/TXqc4XlSKAwAXgp91FOhfmNzEMPv1IrJL9U4e0WH0RCbY4sjIV4mJ/b4iCOXRY92
 Sf4tC7OinavqZE7DQa+UuY37QCXrkHYvBeq2G/5zzn3AcZOk5S7/CTgQ8wbCA4shCLKd6aCS8SF
 EsAp6MSp3saR40vRmkBVPNFusMMYEywX6PdHIWsyuWhnur9uN57ucaXT2sEAq1EfSqagTfD7l7T
 bA7ULqMLltjwdPaWmYJhcHyBJwlNuOQSTjwgXTGG3GrQNthGenYlPUS1JIoaF25lEMSwFgFpRpQ
 4buER24QDYLz8ZfCbn0+0nuw9IDCFjPRM9Jw0Ne9lGBcica9Os9ofQmx/uR/37Ddg1GHsG0QEzk
 iyCvLjes01tpzh6zTKXk7Wi2ptOExmaCgRj+BQEpsreP+TqPXAce4x1t/JqQmJTXiWcU3/biztH
 kuSKwmRGFdmPh/tuA8XMQLzgmU=
X-Received: by 2002:a17:90b:1347:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-38f6a425a7emr7224420a91.5.1785347863987; 
 Wed, 29 Jul 2026 10:57:43 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [RFC 24/32] event/dsw: replace SMP barriers with release fences
Date: Wed, 29 Jul 2026 10:54:17 -0700
Message-ID: <20260729175715.165120-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

All four barriers publish flow table or ring updates before a
control message enqueue, which is release ordering. All are on the
migration control path, not per event.

The fences may in fact be removable: the control messages travel
through rte_ring, whose producer tail update is itself a release
store covering the preceding writes. Left in place here to keep
this a like for like conversion.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/dsw/dsw_event.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/event/dsw/dsw_event.c b/drivers/event/dsw/dsw_event.c
index 399d9f050e..82d3636b29 100644
--- a/drivers/event/dsw/dsw_event.c
+++ b/drivers/event/dsw/dsw_event.c
@@ -339,7 +339,7 @@ dsw_port_handle_pause_flows(struct dsw_evdev *dsw, struct dsw_port *port,
 	/* Make sure any stores to the original port's in_ring is seen
 	 * before the ctl message.
 	 */
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	dsw_port_ctl_enqueue(&dsw->ports[originating_port_id], &cfm);
 }
@@ -821,7 +821,7 @@ dsw_port_move_parallel_flows(struct dsw_evdev *dsw,
 		}
 	}
 
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	dsw_port_end_emigration(dsw, source_port, RTE_SCHED_TYPE_PARALLEL);
 }
@@ -1190,7 +1190,7 @@ dsw_port_move_emigrating_flows(struct dsw_evdev *dsw,
 		    dest_port_id;
 	}
 
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	dsw_port_drain_in_ring(source_port);
 	dsw_port_forward_emigrated_flows(dsw, source_port);
@@ -1213,7 +1213,7 @@ dsw_port_move_emigrating_flows(struct dsw_evdev *dsw,
 	/* Flow table update and migration destination port's enqueues
 	 * must be seen before the control message.
 	 */
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 
 	dsw_port_ctl_broadcast(dsw, source_port, DSW_CTL_UNPAUSE_REQ,
 			       source_port->emigration_target_qfs,
-- 
2.53.0

