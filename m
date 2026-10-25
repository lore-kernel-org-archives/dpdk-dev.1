Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B189606A31B
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Oct 2026 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQQFTWZ9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A20E440275;
	Sun, 25 Oct 2026 02:46:50 +0100 (CET)
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 9628F40269
 for <dev@dpdk.org>; Sun, 25 Oct 2026 02:46:49 +0100 (CET)
Received: by mail-dy2-f7.google.com with SMTP id
 5a478bee46e88-33e5ae86ff2so1254077eec.0
 for <dev@dpdk.org>; Sat, 24 Oct 2026 18:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792892808; x=1793497608; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xEeUFBNzyYFPifXAiPAwW7l1XiaQ4Vr2JVo8quDYG7s=;
 b=JQQFTWZ9KUfh6jgvjtghUgVib/Zup0xN0Zp7dKoASeUmjFpdO4wH1cnyOSIoCtoM2c
 Vr7XijPgNY5Z6dIOqtWqGTKuNZ9a0ynwK6I+k6C2v6IhYmDxxtgy2i0SliIYIdIQ8JSD
 +V4DLJgbbNVNM7mOjp5kGQMJyQJd94UPVJuA3iafaSoukfPaabS17fzCFbi0WXhi7JZ2
 PKA2Z2kuQc1rjS9hD7MZpdhnbRDqIq56N0U7wxQJpoEclLFNorS2BdXrOLpX01ai6Sf+
 PIL7pIX7699suJtRhG1GRZ7Y0h8gKUIV4DVwVvJMVuhlHjP//jM/aB6LfMLguB5H1Ae3
 75lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792892808; x=1793497608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xEeUFBNzyYFPifXAiPAwW7l1XiaQ4Vr2JVo8quDYG7s=;
 b=LvzjWjulB9EZz7X7YC1oyDjsrOWOGcQUvNKChVIKhEpZxEDpJ3v8nGZobQITWUOU1I
 pUx8T+M320fbHUxaY1aiexMcotx5rCzCQKzemD7vmZ4YjXD9+J20bWfeXDUm2/Bv4x32
 DExr1k6AM2WTw7tEgB8EdxBrhH1vabY5XCOS1AtfXiMWuo0A2K1+runeTWR/Tz2wSGRl
 2LbCfa5/ymCaPa0lgTgyrkSWojekljmqjaNetnX+gGNlGBgq5BQbEcSPefz15EjbRmbq
 xZEhT4IpBq0JmWm5B0cX6M0nB3ugLhGCZTSSO1oIjkC2tp4pO5ubQZwdv0oKTv3dA8/r
 cOcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3++YlhjOAIW8tRS/C8kwMGt7HcSsrvs/eNk4jF9DXjANF+m4h1Pk0elJUdo+KTvv/Bq8=@dpdk.org
X-Gm-Message-State: AFq9FYJYHRDW/GAtbXSu1u5CVb22gwrmEO8I+QaRYPSIf5uuHQYm6RO4
 HI+GedFs1MLTqx63IfETsmGuaQTZgHiCtBvZiHNME/0u6UVNMJEukYF+
X-Gm-Gg: AYBFou0K8JCUdskcaRnC75KBk07EgQDnM2u60nigxl0LIp++GRaBTSG/NP5fDaBkz+3
 mPlZT9tbmq/9aAiRf/MLtyMfUAR68LBJvFHjwsOJXo11M9DOfBFglnERPahuRj5jNirqdl58Yux
 mThGdlq5Iv9fR+AI/O4/KYQGnEpW+657bYj2NzCsMNB3CM+6VS/N+0o01nabzJY2s+N03PHKCYy
 S8mdtOsZ7b8kTpK9l3EzLbsfGrPwq6vRnllRjwdgGYcBmjA4ZX9vfbbvvfb3MLeR1N15PWOy2dQ
 rhRJD4ayamBadFSIiloflMwMDi6QJTD8Jy/PnqqVonhLzsTac8DCU1njjmiYYVPuDcqmqZ/7HAX
 u0uvdOg5Ho1unrqrzPu2+nsUbx3KuC9QLWPAMVBOd7I/EmaHHr2VzU839ScumkaUYEMpIaVQ4zT
 yLo2DRvIJyit4IlX9fScLrYV64JVcTqLCF/PSzafhmm0qliOL9YwiAk8vk244ETbAPboKKp9nLf
 FbkqbIaoA6YOHUqR1xcSMPq0MGlkaiLPJ1l39+QPLBSP/MouZikHN9JGUANHamapMqdIxijRA==
X-Received: by 2002:a05:7022:4585:b0:185:8c9f:de82 with SMTP id
 a92af1059eb24-1993639e220mr6446630c88.33.1792892807415; 
 Sat, 24 Oct 2026 18:46:47 -0700 (PDT)
Received: from eloq.. (ik1-206-76773.vs.sakura.ne.jp. [153.120.7.27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8ec50bcsm23265222eec.23.2026.10.24.18.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 18:46:47 -0700 (PDT)
From: Chen Zhao <ch3nzhao@gmail.com>
To: weh@microsoft.com
Cc: thomas@monjalon.net, stephen@networkplumber.org, dev@dpdk.org,
 stable@dpdk.org
Subject: [PATCH] net/netvsc: fix event buffer leak on realloc failure
Date: Sun, 25 Oct 2026 01:46:33 +0000
Message-ID: <20261025014634.3295418-1-ch3nzhao@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Save the old pointer and free it on failure before resetting event_sz.

Fixes: 1f2766b7ee02 ("net/netvsc: resize event buffer as needed")
Cc: sthemmin@microsoft.com
Cc: stable@dpdk.org
Signed-off-by: Chen Zhao <ch3nzhao@gmail.com>
---
 .mailmap                     | 1 +
 drivers/net/netvsc/hn_rxtx.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

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
index 6f536610f2..4db6c933c9 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -1131,15 +1131,19 @@ uint32_t hn_process_events(struct hn_data *hv, uint16_t queue_id,
 
 		if (unlikely(ret == -ENOBUFS)) {
 			/* event buffer not large enough to read ring */
+			void *old_buf = rxq->event_buf;
 
 			PMD_DRV_LOG(DEBUG,
 				    "event buffer expansion (need %u)", len);
 			rxq->event_sz = len + len / 4;
-			rxq->event_buf = rte_realloc(rxq->event_buf, rxq->event_sz,
+			rxq->event_buf = rte_realloc(old_buf, rxq->event_sz,
 						     RTE_CACHE_LINE_SIZE);
 			if (rxq->event_buf)
 				goto retry;
-			/* out of memory, no more events now */
+			/*
+			 * out of memory, free the old buffer, no more events now
+			 */
+			rte_free(old_buf);
 			rxq->event_sz = 0;
 			break;
 		}
-- 
2.43.0

