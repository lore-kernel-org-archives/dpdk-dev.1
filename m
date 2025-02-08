Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65A1C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66F9240651;
	Sat,  8 Feb 2025 21:32:06 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id CDDE140609
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:03 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-21f4500a5c3so57624505ad.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046723;
 x=1739651523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjrrdQzp86xm6MVD5Kb8geXtF1KgxOSOKLGq9JF6YA4=;
 b=QQrlHd68jjDz9m+nIs/08CZyjnaWz8af8j1NJUb9jpuPuWOXkTbLE9wFAj4qjGXMDf
 Z45vAGtX53V1a3PpjIBl+giOlo1ij15Sbzir6i1wqGeVHF+ubPuZm+E7+w7zOy9z6zNM
 2myDLY43xw6G0XvZKQJoG/JPX4UMHwSwftGlrdNvy4sVXcaKNLY9xco1XS7ErRdByPxh
 MCYqdHVZv/3dEbcPG+mHLVNhlr+KkZaFddtIoRJNQzPUVq8D5gG3sUxpqKurJPWMgKNp
 WW03+hzlirFpxWaWshTRUyj8L6hZEE0xtXwlSHYjUS/pUD+7dTe6nYOWoDuxtml4YIbh
 Dkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046723; x=1739651523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjrrdQzp86xm6MVD5Kb8geXtF1KgxOSOKLGq9JF6YA4=;
 b=cLlRqsdKQNHcpTalX1KbZf1/RD0quwFxEHF0xTqoPJu5FubBO3G/PfWnjG9NTdD/Y2
 evqrHKYE+zGj5GsFXpHrfZ5eyShYPuLhJo1Q3Dh1ODeQge0dSFm76zxhVVYnHJjCQnB9
 f4wjy71bShf1rbIk0MmBXDshnk3AKCNMhPbYwolqtEnx4d+OUzTHQnlwdMr/sBsge/f2
 yaeCj0TPBHclQvYetpshIGg7viI+e3gMuESUDiiI+qn+oALrAjwpQ9gl804bASAAQaUt
 PgNQPi1j05tHlXJtCxkNw0j0QgwHYVGGbU66xCulEfzWyRx/syApB7mqawQbgZ3cGKxP
 4/DQ==
X-Gm-Message-State: AOJu0YxAQWsfWg7dqOxYtHxjpWQG0yTZObzOsfwDaoLQLx+JCiMuR19h
 f0sD7iRL28JzYgRRG46kzGberYu9wqfsuGtSXZxBIG8rm8IFqJB9atX9elVqgJS8r6+ObTJUR1v
 p6Sg=
X-Gm-Gg: ASbGncuBCGn5/FpMdldomCiLojExmFIAiTv7ahbovZv9fPrawEMxY3bzXhFaUVHLbOv
 5+KRtsFzXCNALf4mEz8DiK7zqe90x48b8p/rLC9F3wamuTIlhLqC+NnebdPueyzgcSQUaBhU49N
 aquto9IU1Npm0/qKNLRcbWX7hpFmAjaB4heQEKFN8DeqZw3+QruGC6inZi8bk3tfAmJ0G2w6Atu
 vwCMkgLo3zSKwHFKF9nCrMu7b/eE6ONw8c6LGReMmcPZNrXvuUpTl5iGtmeLea8Pne1FpEofGL9
 LGFWqui4xFNB2ixip9ivPx6HyZ2SEOE6cNtIryH9jitNU2X7b7MLVSRzNMwa/uXT9q3k
X-Google-Smtp-Source: AGHT+IHUJccVsCjvlxqHGdqPYqweJS/ijYKyYNhnKXJC5riKALvWTEpSbdxHVllxoljuzHK5mU9byg==
X-Received: by 2002:a05:6a21:9211:b0:1ed:75f4:d285 with SMTP id
 adf61e73a8af0-1ee03a8dcbcmr13857574637.19.1739046722997; 
 Sat, 08 Feb 2025 12:32:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 07/32] event/dpaa2: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:21:59 -0800
Message-ID: <20250208203142.242284-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/dpaa2/dpaa2_eventdev.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 6c8ed3ff6b..95d9154b11 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -224,7 +224,7 @@ static void dpaa2_eventdev_process_parallel(struct qbman_swp *swp,
 
 	RTE_SET_USED(rxq);
 
-	rte_memcpy(ev, ev_temp, sizeof(struct rte_event));
+	*ev = *ev_temp;
 	rte_free(ev_temp);
 
 	qbman_swp_dqrr_consume(swp, dq);
@@ -243,7 +243,7 @@ static void dpaa2_eventdev_process_atomic(struct qbman_swp *swp,
 	RTE_SET_USED(swp);
 	RTE_SET_USED(rxq);
 
-	rte_memcpy(ev, ev_temp, sizeof(struct rte_event));
+	*ev = *ev_temp;
 	rte_free(ev_temp);
 	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
 	DPAA2_PER_LCORE_DQRR_SIZE++;
@@ -588,8 +588,7 @@ dpaa2_eventdev_port_link(struct rte_eventdev *dev, void *port,
 
 	for (i = 0; i < nb_links; i++) {
 		evq_info = &priv->evq_info[queues[i]];
-		memcpy(&dpaa2_portal->evq_info[queues[i]], evq_info,
-			   sizeof(struct dpaa2_eventq));
+		dpaa2_portal->evq_info[queues[i]] = *evq_info;
 		dpaa2_portal->evq_info[queues[i]].event_port = port;
 		dpaa2_portal->num_linked_evq++;
 	}
-- 
2.47.2

