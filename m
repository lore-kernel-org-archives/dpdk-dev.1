Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D17CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0C1940666;
	Tue, 11 Nov 2025 23:19:07 +0100 (CET)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id E353840395
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:19:04 +0100 (CET)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-bbabfe5f2a2so121702a12.3
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762899544;
 x=1763504344; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HujxemZgYKE9r4VHymrwt64ZpD0p+l0xqOVeVWryfaA=;
 b=ig3s6bmNzfBEjh5KTBhbu5OXprBNxu6EC22BuQK457AeUwT8SKWdDfihZRw2Fo99gZ
 TPhJTIxt/3j4Hb1BJ9hFCg1AnWQfgz3KmQ1nHbNJ2OHzMm5iOgb7Gg9UGODuLvg/5+/i
 tVDxc+eEHPgUZVsA9Kx3bsGBGES4oK5+iZsh2Pd8T4HepW9PM38CnBH2nC/4mSNsrww9
 YBAqh3+Qcq9wYa5V+RZg+kfQnl/2lPusxes/LH4+gJnyLX1mJ/GzPwdlpJ4Z39vr3Aik
 819cfmJKMLs4egocgzCFGmx/Cye1SZRmpFjjc5894/8i5f6LURMtCAmxItSjdYGTtsxm
 nNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899544; x=1763504344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HujxemZgYKE9r4VHymrwt64ZpD0p+l0xqOVeVWryfaA=;
 b=JGMjZNBYOrmRyYVGKNtbE2uwXMf6B6xz2pWh/FOKs9O2ZBXDiXFCSVaP7oWTq6ZWGA
 xb6MhJ2CEO4lgHZwvDL+gf8aaP1tr7UsQw0b+cs/gjSrXjJoGPV8Yid++2p0RjGIxfv3
 EbIi2wKEcfBAK176VmjNmCu4BrsuOGcs2/W+2VyJmMZYarTSbQ/SvfuIhLfeUzh5StOF
 3lDjaOrMcNnzLFFpBnK0hCR6GTUbx6krLszwfPKGWg5gLW97VeGTO4aY3WXwIi64ET98
 kdlgvksOy8Bsim1oCvAL7f69Q0yXvJSfSkc6Npq8olxweeNqiGBGlBU/RNLEpHnnwsd/
 gM7A==
X-Gm-Message-State: AOJu0Yz2ChZeh0Q2GtYLBDY3liQ+BiSnaCevfVu7w2WtMWUHvMMOFVQp
 +6oJs32PbOf+68rRi+L7urfnWj2W/ahj0dGGkcDcsQ9YCEPdmap6lMMZ/EVp0E1YjUIWyZYqfxU
 r2P2l
X-Gm-Gg: ASbGncsL7ygYyB6pTnImQk+fzYDI2ZR3/qnPqmy8kWd7BP/ht5dBMGZ8PFJO6lag0nL
 WPbN0qGksNhdsyhL2pI55FS7QgcdvBe35VvtIMbYyFc4Rp8APegWOO62ipV8TNUCrnXcmoOchE3
 UJi0yq/xe96CALPMuSNbRY6no+9Z9byTRCWtKfGY2nen5NwtOY4jns+TtcI18v2hmp/RIyYMyH6
 8mcTnltvY9HPMN7aIZPZ29hTROGEfxtMfpsoLduKy7lYmu2Jt3D7sNcBFXiwklmuXlhKoTDJbT8
 OXwSdadjefZ+PrM1w9Dd3jGnGUgiKhaLWLp8uN7s95RyS5IaT/ak8SsPunV22pWrgKh1zLJ7dU6
 S1ySJTj6taGLtY9R0OK2vG8YEL8IknB4iun4Zs2Qdrj8mfhwAply4PpoDvrEUTXUVy27Vkd0hwe
 npdBW6CdgV8q59PODhOXaAjIHoDZm4ut/73yjsP1CvO9vre5qHQQ==
X-Google-Smtp-Source: AGHT+IGYnnfPt65SZs9rZSSmwAg0a4DFogN/jk/rWZ1itXzSkJ8XjJOmSdSG+bPQ4CRXLtJqwbg6gQ==
X-Received: by 2002:a17:903:286:b0:298:3e3a:ae6 with SMTP id
 d9443c01a7336-2984edd2d45mr9936615ad.48.1762899543933; 
 Tue, 11 Nov 2025 14:19:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072e5a5sm157001a91.11.2025.11.11.14.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:19:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 3/7] examples/ip_reassembly: add check before formatting
 name
Date: Tue, 11 Nov 2025 14:17:20 -0800
Message-ID: <20251111221857.443752-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111221857.443752-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
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

In theory, lcore and queue could be so large that mbuf pool name
could overflow. But that can never happen since lcore and queue
will be in range. Add a check so that static tools know that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ip_reassembly/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 17ae76d4ba..25b904dbd4 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -884,6 +884,13 @@ setup_queue_tbl(struct rx_queue *rxq, uint32_t lcore, uint32_t queue)
 
 	nb_mbuf = RTE_MAX(nb_mbuf, (uint32_t)NB_MBUF);
 
+	/* Should never happen but check so that pool name won't be too long. */
+	if (lcore > RTE_MAX_LCORE || queue > RTE_MAX_QUEUES_PER_PORT) {
+		RTE_LOG(ERR, IP_RSMBL, "invalid lcore %u or queue %u",
+			lcore, queue);
+		return -1;
+	}
+
 	snprintf(buf, sizeof(buf), "mbuf_pool_%u_%u", lcore, queue);
 
 	rxq->pool = rte_pktmbuf_pool_create(buf, nb_mbuf, MEMPOOL_CACHE_SIZE, 0,
-- 
2.51.0

