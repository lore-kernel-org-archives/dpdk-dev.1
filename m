Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B64CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:37:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D16B40697;
	Wed, 14 Oct 2026 00:35:29 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7D16D4064E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:27 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e8d2574fd9so20123775ad.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930927;
 x=1792535727; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z1jcg9XpsJx/wXaCPHHeenJp5gggZaRxQ9VNIW3h2vM=;
 b=IYpKSTR+qNQrJjYrpnNvISD6IBbIObv2bF4QR+RQbM5lA7pSBqFqAqug+gUQpT6PTE
 jxWCXPuz/0bp4UL+qTeWrTkIShW8E13EPl72jMi/XMxzXevJOB/0Dbl8H4WuOBYWJlcC
 4OCAMvdUVEO9oZg0SFWnaNBGp283Q49ZROhMuTVzt+GruGyBJl8JmJouCikCWAjguM4/
 tHquoVkFd298RJO2J1AzQISViW1xY+hSccpEojuHGvHbK2AXNYp3quuo4YWqH91Fpiba
 N17fjkQQyxL9+tIZ4Z5z82kmceHQLmk00J+53mFtlVPPToEJhrw9S/TaKZEA0Mu8b/vs
 WHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930927; x=1792535727;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z1jcg9XpsJx/wXaCPHHeenJp5gggZaRxQ9VNIW3h2vM=;
 b=Mdlt7A6WjkI7+cW9C2yMLYx7Wcyest0jiTvpiZxrN96jWO1tuk/O3G7YfAFDRjt9AY
 OdDXIt93Hdz4oLyXuLmQrMwsFIMrJdyDiRmEKolvT7LT9gApwUChXXt12X83+gGnXAWG
 t2Gz9pK9khC2MxMeOd9aS33h+kcdBOk0YxzThbArO9PLwYgGjEqcEng4hYb77IglPQfn
 9Ch0fQaJCWV8NmoGLF8to21eyuSNXxbCngJ/dGLDyIcEVNI/LkJWHrSS8UtLZH8ia5rs
 E6UBLSJHyiNcaR7H1eUk5rRWexRewmjadgHUSsHFEwKKQdExIyRnbdTWfsc6lPD/KfuK
 qrBA==
X-Gm-Message-State: AFq9FYIM+mk//Z626UZNAANMaMR+q4i42tz+b0Dr4JyLMbDHaTW4n5ST
 S9uXCRRxM2D4LkLyFdguQMrzb5WjLfaPH8+q5lwV54K0vXyl/zjDeZtJAZ8MLDrJ63ulfzBxKIb
 YRTHsf7k=
X-Gm-Gg: AYBFou2kNeGULTmhWIQg92VIyRYDojmwXtDWCfgBeOiym4Tfb9PSNofuns2sQgTfB7t
 IML9u130wykCZdx2ssbYOlDXoBCVkm815bY7BB/5RwCi+qVz+vQ4pWiETeRtpAcz58QKcUJRSNq
 Ch1GyWI0dZZTV3HHr4sfHHsph1mBd1baBXHRwh+/HafVQU8qcPA6Can//sMo4YKJcaWzYVfJxvL
 X0xQJx9EXbyDbOVEZxHIyPoGu9ZA8M7ohXXASWpavwsNHliKMIOip1EhuZLRikq8oOI14+jLcSy
 PS13XzEX1i50gY/h6AApxzq8l8aNMu/PMB2phAiKmqv9fkZHWxMzaPAMRmbRLKldUZmKDvAqhck
 PDqSbSgEKn3CdReq1QtHsD3BTvTHJDmlzGfDhLkq7KsdgbWTwLmnNG5cTGca+iwDu97AVODWaKz
 9ZO4s7L7Z+JWCVs+1YuN3X1F8+nZV2KMF8CCSMp/gvZ0FnDxXWf8vaATGMSPk7lxlHzQN0jPN/2
 1zh0x8ltFFq1C71BRnBOpQGviRwq3zlpS7T2n7tp5+5gY6r0A==
X-Received: by 2002:a17:903:1663:b0:2df:83ce:724f with SMTP id
 d9443c01a7336-2e842abf78cmr132150385ad.30.1791930926666; 
 Tue, 13 Oct 2026 15:35:26 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH v4 25/29] event/dsw: replace SMP barriers with release fences
Date: Tue, 13 Oct 2026 15:22:38 -0700
Message-ID: <20261013222410.2257622-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

