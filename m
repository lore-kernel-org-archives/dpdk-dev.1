Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571F9CCF2C4
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DCC040659;
	Sat, 17 Oct 2026 22:36:39 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 4FF7040659
 for <dev@dpdk.org>; Sat, 17 Oct 2026 22:36:37 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-89ff475a152so270844b3a.3
 for <dev@dpdk.org>; Sat, 17 Oct 2026 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792269396;
 x=1792874196; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2HDcM4wsHA4Hl6GihBy1L1P2cvxTiS6fiMpMelTugtA=;
 b=mdMGa8F+psDI5dO72t6STB3GQNXLEj7sPvClexpwShZV3zFwucRU24XIGdHhj2vX8H
 AwNpMNGzWuyUmgHEk+/64iuhE11G/bEhmnskwvLqGcQn7G5at4aKk+KJLk5Ym7VAF4U1
 FKXff9dCqp8Pdbqz3K4fyrN2V5+/xT7N8rmvgeNBZkdC9FlOAlqQgN/3jWWRjWQlnP03
 iwAlJNPEtGCdbPfH1C31Yw2kfvalRf8ZcEKX7Kylfv+QiDbzsj+VVTia03jTQ4RT2iaC
 tJrx3mWrUboNM0YJ4w3mKc59iNJOjicVUaT576nUvjdIolrXVoF+KIQEuOJr56ceJzSA
 c5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792269396; x=1792874196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2HDcM4wsHA4Hl6GihBy1L1P2cvxTiS6fiMpMelTugtA=;
 b=i2PsPAmN+GR0PUnFnyb0yOyr8e8vw9A0MNNhq1Rs4543ebsjniSYQAaHPsC854dpFe
 M5qSxt0L6e2rCy16u32rltXkaYrJn9GE8lJIS7GYf/nom/tVlqFIjZHG7Gb0wS/wxluf
 4QBV+qKe/VWskQJbsIohwwJxbfJlaQM0YzZkV0x5uAxOhAVO9oOzilk0IcnonRSFwpRE
 BrdeM7xffO4wCHJjlRHmhRiZqy5exC9GEm+uat6WluEKslLx9YOMBtGuWWUnGDiF4+1D
 uf51K2uRfrUSOqemI7gteW9ewIQZHW4DOX+RqEADczkOQPzbhVJnrqs//+oRNW6VYi0x
 3lRg==
X-Gm-Message-State: AFq9FYIVcUMDrTZd3PsxHxBvkm+TLFKA8EBl9Hz517HVMqaIHd3owqBw
 oWUcPX9M0lAqAczNsH+1ucn2ORp4JTjOCNeiLgqRfFBkQc687obxDd2cOmXvYRvlRi2hb1j1CGF
 /n4MKJQU=
X-Gm-Gg: AYBFou3XAk8VubHbPAWxHxOUNZVItQeeCc2dceU2j90q1i8LjcRwDVrcHaW2Pta2pxq
 ESlPpbTsYpd9pGKumjDx0b/nJ8FH0U4X1FodzOV1dn+xp1cyHGHeYTQVe8Ovq2t244wk+APuMTr
 SQb+krfUlsVrkIVxSBiNqN2d0HhlFF9PiNtioNk1iZRdNAABx6hs9qot4q4642dO5IqVMQuoKa+
 Z++Wpd+AaxafunmnaeNbHuFw3L2f3NOL0YLvi1WrzejH847QbCnu1YXxcm/xsAHGOO2WrxCySmE
 rZDJDEkMi9JYP4bUw0xSGwO+niqW2OoxzPtzoQJdtH+FtqU+rtldEU9F9jnOln5l9okXfpfV/TH
 1tspYeRCWF3hsKtjVknlQNnE7ZKEXrpztlpYn0jSvAm/SIIZNA1Kwm0ADfTymG75hsjaO9uEptn
 tcUq+xHHelrBm06YTg1pVkHDIW09V3Tx+JF/HK9z7Hfvcsvt15q2RV+h+qZ+rYLAurfgcUeHwWH
 L+7GLVQ0OGO2ozetrfPY6xd/mq3l1Qcv10J6ipj2GOgKa0O
X-Received: by 2002:a05:6a00:1492:b0:89f:c441:580a with SMTP id
 d2e1a72fcca58-8a04be36815mr2565939b3a.36.1792269396438; 
 Sat, 17 Oct 2026 13:36:36 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f57653ea9sm2451929b3a.32.2026.10.17.13.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 13:36:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Harman Kalra <hkalra@marvell.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [RFC 3/3] eal/linux: close alarm timerfd on cleanup
Date: Sat, 17 Oct 2026 13:35:05 -0700
Message-ID: <20261017203621.3136254-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017203621.3136254-1-stephen@networkplumber.org>
References: <20261017203621.3136254-1-stephen@networkplumber.org>
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

The timerfd used for alarms is never closed on EAL cleanup.
FreeBSD was fixed to close it, do the same on Linux.

Fixes: 90b13ab8d4f7 ("alarm: remove direct access to interrupt handle")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_alarm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index a1433eb867..5f8655ea11 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -61,6 +61,7 @@ rte_eal_alarm_cleanup(void)
 	int ret = rte_intr_callback_unregister_sync(intr_handle,
 						eal_alarm_callback, (void *)-1);
 	if (ret >= 0) {
+		rte_intr_fd_close(intr_handle);
 		rte_intr_instance_free(intr_handle);
 		intr_handle = NULL;
 		handler_registered = 0;
-- 
2.53.0

