Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6B5C982D8
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63E48410EA;
	Sun, 20 Sep 2026 20:14:30 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 808AF40ED1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:21 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so1715113a91.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928061;
 x=1790532861; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9SRYJA6kGluYRuHR+7eOHy9YKHPYkjSgvmYyE4dZVz0=;
 b=mBXfuhb0RKyhgwnB6Ky93S8TlWdJ/r4XAsMinQ5kqhBymJ/Ja4R57iLFyfIECUlWoL
 kAEjX7wu2vCJTeqfQoVntA1NA4bYc+30nFeohOaYybbaO2ftn+V6Qk9Bf7W+qxNx02KO
 YXIhbziuOONGq4kXh1tVGkn/kduMsM7BQFnD6YdCdRlVwUX2gncmyMYNIEaTaK42y9SC
 wup9Piav8Y9UtLLCqgmutShx6BzVBEXJw7YCmrlmmq9xYKnG13O4aNjVuuyAeJCOTzS+
 Aok4m5h+IaKjNARLO+u8Z2FeTeZpW9NJHSdd9xMFqozsEOhkE4A2ZbH9axBbpbEe99Uh
 /Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928061; x=1790532861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9SRYJA6kGluYRuHR+7eOHy9YKHPYkjSgvmYyE4dZVz0=;
 b=gCFYK50eFPPGg2fVTGqwYtExuG3WjvfqxFus2M89xGxkb2R2syF/Xm8dRcVrhSzkgp
 3uhFR7FOBdUpe95IfKo951TMH87xm4cX+6YLNwgMEJHtFHIeiyg4S8vLIAK0VC484rKJ
 wQioMriZYOwn8gs8NANKHtuHByyLflYIxRMzhIR64iCCZU3cga/DVRCJv98B/nWNoacF
 KQoCxlMhfpOAbK841kU6Q7iboEbiYFy/FKv8DbFBwEyhLk3cFUHoqz5M/z4lIfwnPpAV
 aaPJqAd0yG65XVC90XfcMrM9Wkv4Hz59IotnJ7kN+sthzpoJI207VWAB6pAfeO5Js3EI
 D6Og==
X-Gm-Message-State: AFuF++lNRGuxRdhlQTRFlcqAwm/2XAFOUowVCyQhUvyhj5OokPxjX8tw
 67EZAMKFm8A00feTUFwz4LSzLbk0m9yd3LyikpCdc5A3AnErw5y811/hzi0RYIqZ5OkRCmoixDX
 h2qz/
X-Gm-Gg: AYBFou3hlTnOWRLfMHSyQfosZTjmgq6jo+KIO60llI6JKFLkyVPwo9sZh1MG8sKnH0y
 mct513kk80W7iOZNClJ7Ttf7kNsg/qEIar7/nLT3hQzEe1fE2vV+Jsc9lGiReSaL26EPygZgFqL
 YsCslcqsjc8RfINPN5QLAMpjDvryH6GQ94asFPtGd2OLwT+dJHFr6yhhuRcB1Yt+v0QD7B2ORhU
 vzvq4Ha6jcoMBTX4WKIgejdtJjJG3zXPqU65Vs5xF/4S1SydR4feJBDh0p4TiTxsRgj2+uEqAfH
 pKRPyOZsrN8H+rI+hlkZuNid91+Sk/bC5Ssh2gYPnGVp/N9k5v0AoYX0h2dWEhBuvDzYdvx8sRY
 y3IbmYXp/K9s/K9f6b1Hq8Zaw1Kq/RTDFtqsuciI5YM45bnqFLaPa0bC75aSWdAtrc0C/yhfYhk
 Re+B4D1OkudZDt5HXQ/1NcFqTiMyrvQRw6WFFG44yX2NPMa5vZUakpq4B2wFNOpLl5E6k6lECY+
 oTM/jNkvCiYMP2elM2BDP7CMMZUPxxbqjElE5UMYtv34Jie
X-Received: by 2002:a17:90a:38c4:b0:3a0:3881:eabe with SMTP id
 98e67ed59e1d1-3a03881eb2cmr2015146a91.5.1789928060604; 
 Sun, 20 Sep 2026 11:14:20 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liang Ma <liangma@bytedance.com>, Peter Mccarthy <peter.mccarthy@intel.com>
Subject: [PATCH v2 26/33] event/opdl: replace SMP barriers with C11 atomics
Date: Sun, 20 Sep 2026 11:10:18 -0700
Message-ID: <20260920181347.747210-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

Publishing the port becomes a release store of the configured flag;
the barrier after clearing started becomes a release fence. Both
are control path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/opdl/opdl_evdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/event/opdl/opdl_evdev.c b/drivers/event/opdl/opdl_evdev.c
index ffa65ef930..1450fa5ae8 100644
--- a/drivers/event/opdl/opdl_evdev.c
+++ b/drivers/event/opdl/opdl_evdev.c
@@ -200,8 +200,9 @@ opdl_port_setup(struct rte_eventdev *dev,
 	p->queue_id = OPDL_INVALID_QID;
 	p->external_qid = OPDL_INVALID_QID;
 	dev->data->ports[port_id] = p;
-	rte_smp_wmb();
-	p->configured = 1;
+	/* Release publishes port setup before the configured flag */
+	rte_atomic_store_explicit((uint8_t __rte_atomic *)&p->configured, 1,
+				  rte_memory_order_release);
 	device->nb_ports++;
 	return 0;
 }
@@ -477,7 +478,7 @@ opdl_stop(struct rte_eventdev *dev)
 
 	device->started = 0;
 
-	rte_smp_wmb();
+	rte_atomic_thread_fence(rte_memory_order_release);
 }
 
 static int
-- 
2.53.0

