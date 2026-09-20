Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6F8C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BA5740F1A;
	Sun, 20 Sep 2026 20:14:29 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 47C3740ED4
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:20 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso2331725a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928059;
 x=1790532859; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z1jcg9XpsJx/wXaCPHHeenJp5gggZaRxQ9VNIW3h2vM=;
 b=L+evd3Uqdu+/4C5PzVbyT8lxIZQsQeTNAgjz89Nz6r1iQaleR/GN8jycC0XTKfgB76
 5FinU07tZfiwBq7u5ckDPtN66W9Z57RAj+vkJbznCRzSpaLlJuzQLPMYfI6oipWWty+P
 k6STS2C5u5vyhkb/KHZuYKUwwb9sHOxWdf4tR0SjLuMDY4+/RUdpV4WbDDWwSDQMOqa7
 waWhswtdAlG+lu+rz9dH21sqCrradwlL3NKUU2QolkLwjPvcaZPjgrhECiNJbYjZnnF1
 HD3ankRuXIIYsxhnkwIglIkXrm3gHebUUI6id4HBl6qkTo1kylG27oCSTiZ6tGp9EGr3
 C+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928059; x=1790532859;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z1jcg9XpsJx/wXaCPHHeenJp5gggZaRxQ9VNIW3h2vM=;
 b=MH0fGtfhlHD22o4sF4rYhHioQ0GGmUxiRvHvospobbcrDEpjmuAFHEsC0WD66jf93y
 l3cwxgnPnXfk3y+KwMEmPrDUbHi8W87DiYHwzU6CohuyWwv42DbDgw8pLUZD4TiQLexm
 xtaR94MJQXY222mIMLBzZyAtUy6ZyWW9Fkw64KAeROiBtRihk6hfi9GJVMfbXso5N69v
 4Hssf1dMt+g9qlDfz/SB060T+kpEmN/CVDjeSbENutjGW/6bQNvSF3cz63la6DP6Q69e
 V/NhG+4SP1j0Vq/kDiBcx3/qMS0WlwCYW7z5Vd3x89n1hfO2JA0nhBc9BFMlTPWnp0LV
 5OCg==
X-Gm-Message-State: AFuF++mMoe/6G66RQy50kuqhWGp2m0idHOjksSkpc8W8N4gjVn7Cxp7C
 c/axNi4FBQ3whWd2ITDaaqlrskKb+4rbun1JDJqNTJRZyOil678+gBnWPwKVckKFqFc40nw9Ed4
 OdVZx
X-Gm-Gg: AYBFou2i6W2PuWLme+bEzteNZd+gaIG2/oAwkFD3B20cbT9+lW2KCyCgn6flKPvagN3
 U17H1h4si95kNpxAg+BRH9XywL24Zl58UHE/yUQuY5D4Wn8CpRKAYDOdcaT5TYITeHqilcvh7cX
 7Wav4l+4UH3wPeUygWfU2jXSvlfyEpWNmMycOwzKRq4YQ/gmwM2ETmoe26LXIO6aG8IKy4NdstT
 5hLFKZuRS959r5+Fpc1I6G0tsGtXLukt+/9Vguufi2NA2azxC7IzRPSNL2d51HXrCPZjPXJz157
 ouw6CPjHjM781uYHWh06ODjegnlJQl61CysRQiyoa6SKqk5Q9nNoVfFWa4eLV6wOEef+5lKp8a9
 M4f58x8El7Fj7KEt3Q3YGZ0nnH2QEhG8AWGVd+qtn28cj1ZjGAE27bJwGKRiRRHMmsy4Lb/M56R
 ar6pVPHeByClLC9Szf4s9mOClr7PT+bKwf4x7Z3NhKxHdvW7qV4JdshPaR/exjcagWUsyebKhnz
 t3yjq5qfPWKCW3SwB1CLNulk0L8YXB9q1MNnA==
X-Received: by 2002:a17:90b:17c5:b0:39d:ecc8:73b1 with SMTP id
 98e67ed59e1d1-39e54df9c06mr19169225a91.7.1789928059315; 
 Sun, 20 Sep 2026 11:14:19 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH v2 25/33] event/dsw: replace SMP barriers with release fences
Date: Sun, 20 Sep 2026 11:10:17 -0700
Message-ID: <20260920181347.747210-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

