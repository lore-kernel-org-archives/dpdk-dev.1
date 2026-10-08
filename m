Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA74CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:39:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1712540DD2;
	Fri,  9 Oct 2026 01:37:47 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3386E40A81
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:45 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-878b44611ffso2791028b3a.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502664;
 x=1792107464; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z1jcg9XpsJx/wXaCPHHeenJp5gggZaRxQ9VNIW3h2vM=;
 b=iz2X1PRUyI+dIY3w0nV3r0wXtl4c5OAeyUYAKcGvBaZ7eH2x3qo9ASwKDtkv+bwwZ9
 S3BFtgnG0yG0da4AI2qNvMKHk4jcJ55fVnvONhwYVQ+QpMnU/iKA5TPaI53fbehKO9GB
 GWAYEdtRZHDm9l0ERsl0tDNacAAAPzE7n5eVGcBfUhhQjn8exSNs6jcc+x7wKBHOVlmv
 hmcDSk+ie4lIHDe2MZDmcZYLW6e99MWnEDOtVWEFdoEYT1N989pk5YtMfvkibwO9P0aP
 gdIH9WhetSzoXQp7mAqbEySE4Amcem+R9KAwSFjChVZAargZczd+mh1s7GwqSA9iOL4d
 7p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502664; x=1792107464;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z1jcg9XpsJx/wXaCPHHeenJp5gggZaRxQ9VNIW3h2vM=;
 b=McBC/KsG0byuVYV3hInq+pcRSQWzhbGoEaHChaVMWIcL7TDW2qXgBy8hm0TVvgQ/SC
 JvNYkbX+LhUcg33HRRX+o5TXXycDidl2pFzyba6qzs0AStrE5SAlJMqnTIrMC8oOwSWQ
 /yZyU7EQurQhMnjqQenIMkP3wnOhMqEA5oa/XOGf6VqmyeuHHXZFLbSfa0o7Xu/nkPjJ
 Z3VhR0WrnEntwK5ZGSOj+XkyMm+XjS9BXtV80t4D2xpLQwH4JhDhGGdhS+YZ/fwoHSvh
 vzm8z9kAIUZ6MczNdsdu3M/zOzBEax+KQhrBY1bPPB2lrvhftnOvwFPar0UL1eTBRPeP
 dZ+Q==
X-Gm-Message-State: AFuF++nZK/o/c2D5rpWR5AGZwhjgPxQZAxkZYcgkxVDXcKekp7wo+sBh
 rK2/wUZPLSE4Cgj1hL6zx19dKqnRNc/O+oo9dPJhMpLMDhF1q30SMNYeRlWs1m0L0qTzSEccq3Y
 q6wnDB6s=
X-Gm-Gg: AYBFou1Fcwbuv1eYG5lpxhyJY+TTHO80Yn/h7t5LWHY2NjDSgwl43gpT9e5FvOOI55P
 Q907/LY6cRkvkANRb9n1N+hMX/0gY6jg/AQnmfdBBs3vNcgikaLoe6nSSSLNIshahQr6IkrHV2w
 VnNdBk5K+bUn/kaKobpgTc6Q9sZfg4Vpjs1b1xPEKn8Xw2gIWQ2Lw4yLTEy4ZOpH+ooG6R710KV
 agnZJmsMp20vckaqqda7ooiAliRM7DXIGA08oNMqBVUHH2IE0WfASNHaLzp/9ZilrfWm7vf6y5l
 LnyU34S5d9A9kK05oI22DEDmfudn5PlWSu/LYQya+swgT1efqJjq6nPAkRKvN0PZuL05hZ+24lo
 OypxgdY6wY8Km8sTBDthVsAaw9vIkmJl9XktMGTgmcAyP8Li1OABKgKu9dQXWjtW+yG8dZjyzGG
 gFKyzxyr1Z6ELHCVoIhSHvlkEq9vLsH8re0Z2EwmKZ0TUWMyIRIAzzl5RZ9YE5A8yVbJP1Z+X6d
 /fGihAomXJQtrX2EChfJ5kqRiulwm3zK44raA==
X-Received: by 2002:a05:6a00:4b54:b0:871:b1b0:e495 with SMTP id
 d2e1a72fcca58-897c663be01mr54899b3a.15.1791502664388; 
 Thu, 08 Oct 2026 16:37:44 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH v3 25/29] event/dsw: replace SMP barriers with release fences
Date: Thu,  8 Oct 2026 16:35:18 -0700
Message-ID: <20261008233649.1260843-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
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

