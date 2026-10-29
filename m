Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3397E606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Oct 2026 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mp++/DsE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56E18402AC;
	Sat, 31 Oct 2026 09:52:40 +0100 (CET)
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
 by mails.dpdk.org (Postfix) with ESMTPS id 8A66040151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:55:01 +0100 (CET)
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-3ab37ea4798so651257a91.0
 for <dev@dpdk.org>; Thu, 29 Oct 2026 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793292900; x=1793897700; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rGck87fXBfBYpsDcVatJnRyvcyAqht+QuhLnQFofFbo=;
 b=Mp++/DsEBlpUvl7xeJIJBoULvSKTesUFBbhml57Q59KiNLlPKuGnxMPjxOAmiC3VpK
 WvnbBX8OfNO042Kzh/3Pt9cPrvdm4W0KEf4aFc13AR8f6DTKqStXzvLbcEzV428RkBzw
 PMCUmlu8MGotdrguWlkol/UJBjV6ir5RN5bw3xXI9qODLr3EgOLivaadQ2rEpZVDEk8I
 nyIeUeUKOEH5u2Qr5HdMoIlzTJGMhpoX6qIaeGX037QQ3Qxw8fnrCUHT7j5nacvGc6WJ
 2AOZ8pRqYIRSvLzAtE2mpZ83n4KwJZxMTDMhreqDCez5ZezR+NMhH10k5BhBrrIgMb4C
 fNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292900; x=1793897700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rGck87fXBfBYpsDcVatJnRyvcyAqht+QuhLnQFofFbo=;
 b=BrR2uh0wCWw7Wb4KZ7YFOWpknr5B6c2yWj2PedRN9VNTAX3wLJKA2I3+r3132svjM3
 r2juM117Hm0NUEBeQo/hiqQNlIeCSWDvHkB19Xy04Z3QGi9Vbe487lj/NbZzpzXIluuo
 p1VoNniCYeejP1A0576Z8i7rBO6pS7DjPMTI9wlo+54OYkNvr3EvgXQZ1nSYPlE8U7/V
 Cc5QdSDBwR0PjwttAkf7FCygJrGLJ5CiIgFWhL3ith7XZuhazA76jhKpR1Ade0VCcXnk
 FzhoSBX7tj0P383BEoR5cSLaO06MZqxxoF8SNZ3kpi+DxiJfH+jExn18gnr/8GI49PJX
 W3HA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJzEopl1YfP7O5lWg0mPozTqEOM3wrTP0eOsiullGhItJUtdv9hWpyDgBSSKWDKMLOWhw=@dpdk.org
X-Gm-Message-State: AFq9FYLeXJLpVV0djOnCocPIfx/lsY8GbVDq/SRj5yEm4S2mdXfdKoJ9
 cb9AqkscvvHnnQ/sj91fnQNex4VnGWhGKYjcovoFx8LkzkI/ygHk5mZ0
X-Gm-Gg: AYBFou1pa9NQ9AA9NrQ2ghorBoosJJKqKAA+KT163tcCruJP4hxt2amZ/uDC0vcssYy
 y1xHfF5S5S7Il0FPz96djll6QMIX0Fibh+vjtAdM9Jtnnaptht0LCxLjFNsEQF7+PPEUL+QUXJJ
 APaJAPYMkBCq7JJoxP4SSAC4HdWkjGfwD/UbRzdYe/Xqn8cJAfPCRjD6+O86EJSFw5elgV6GXK6
 3Oylr/hBin/hMiGSSJxpVVd7UW49uHPdMCt+zaax2HiTemDzgKEfmNDYuUZtv5dWdDW7W28RjDC
 DYuUoMg5+lyIUXjlmTeeDz2psV3523YEEmjRJS6rOjneHObF+KJsgJBBGLQYzxgzCdC5w0OxM8B
 lJqHf+amPYogmXHHybzx2tiQXyq2b9sADtMdOZNpaWqBponqokFMVBpIWxvt/A8OqESQYY6QcL5
 e/FdKLuAN9N886g5jJDQoXN3QsgCPtGIFSI6gD72f18hyzZHfeCopmmjJIPeQTIjW9M2hXbXZcC
 fkr8+Qk3NJ+yEGWshb9jbid3blOgZaw8fO31JnMM+kFLmYHNyB6osGwHvmaAErIlah7acUvZOEn
 Uu/pePXUigJT2TRyvOpCxB7rLWXIeg==
X-Received: by 2002:a17:90b:3812:b0:3a7:ef4:164b with SMTP id
 98e67ed59e1d1-3ae57e33e41mr4707003a91.2.1793292899805; 
 Thu, 29 Oct 2026 09:54:59 -0700 (PDT)
Received: from eloq.. ([2a0e:97c0:7d3:30a6:29bf:145d:c4a4:c0b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e99b267sm4871057a91.14.2026.10.29.09.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:54:59 -0700 (PDT)
From: Chen Zhao <ch3nzhao@gmail.com>
To: weh@microsoft.com
Cc: thomas@monjalon.net, stephen@networkplumber.org, dev@dpdk.org,
 stable@dpdk.org
Subject: [PATCH v2] net/netvsc: fix event buffer leak on realloc failure
Date: Thu, 29 Oct 2026 16:54:52 +0000
Message-ID: <20261029165452.966911-1-ch3nzhao@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025014634.3295418-1-ch3nzhao@gmail.com>
References: <20261025014634.3295418-1-ch3nzhao@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 31 Oct 2026 09:52:38 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rte_realloc() failure overwrites event_buf and leaks the old allocation.
Use a temporary pointer and update event_buf and event_sz only on success,
preserving the existing buffer and size on failure.

Fixes: 1f2766b7ee02 ("net/netvsc: resize event buffer as needed")
Cc: stable@dpdk.org
Signed-off-by: Chen Zhao <ch3nzhao@gmail.com>
---
v2:
- Preserve the existing buffer and size on allocation failure.
- Update the buffer pointer and size only on success.
- Remove the obsolete Microsoft email address.

 .mailmap                     |  1 +
 drivers/net/netvsc/hn_rxtx.c | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..deae6514dd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -267,6 +267,7 @@ Charles Myers <charles.myers@spirent.com>
 Charles Stoll <charles.stoll@intel.com>
 Chas Williams <3chas3@gmail.com> <chas3@att.com>
 Chas Williams <3chas3@gmail.com> <ciwillia@brocade.com>
+Chen Zhao <ch3nzhao@gmail.com>
 Chenbo Xia <chenbox@nvidia.com> <chenbo.xia@intel.com>
 Cheng Jiang <honest.jiang@foxmail.com> <cheng1.jiang@intel.com>
 Cheng Liu <liucheng11@huawei.com>
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index 6f536610f2..f38fc33f7c 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -1131,17 +1131,19 @@ uint32_t hn_process_events(struct hn_data *hv, uint16_t queue_id,
 
 		if (unlikely(ret == -ENOBUFS)) {
 			/* event buffer not large enough to read ring */
+			uint32_t new_sz = len + len / 4;
+			void *new_buf;
 
 			PMD_DRV_LOG(DEBUG,
 				    "event buffer expansion (need %u)", len);
-			rxq->event_sz = len + len / 4;
-			rxq->event_buf = rte_realloc(rxq->event_buf, rxq->event_sz,
-						     RTE_CACHE_LINE_SIZE);
-			if (rxq->event_buf)
-				goto retry;
-			/* out of memory, no more events now */
-			rxq->event_sz = 0;
-			break;
+			new_buf = rte_realloc(rxq->event_buf, new_sz,
+					      RTE_CACHE_LINE_SIZE);
+			if (new_buf == NULL)
+				break;	/* out of memory, no more events now */
+
+			rxq->event_buf = new_buf;
+			rxq->event_sz = new_sz;
+			goto retry;
 		}
 
 		if (unlikely(ret <= 0)) {
-- 
2.43.0

