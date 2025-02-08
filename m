Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB63C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBC584066D;
	Sat,  8 Feb 2025 21:32:14 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id A880D40665
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:11 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so4968438a91.2
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046731;
 x=1739651531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGrAWg9m4MtEXr/sMnC/5/hCnU3kDaDFhtpQV6triho=;
 b=gxL7dOBSl53OgvKE2Xc/EHAwUm0xzRsRiB0UxZrqRbnWVT82e5idzh6XeLEB4Ry2F/
 fOSHwlHkD9sxtYazblsqhagJUebcqyhu6vrQj6nACGzAMP5fgBDccliBB1erHViyTCjs
 PjU33xLn1jhSyGDY2iyFBu1Yu7X5XdIg7wU9tLBVNLXZMJxqDovpDk2zt12GfjuceAsE
 ZlBTLVUQOGW88c2IcIGr9OgNikaNr2NnnX2wx4mte5Usrz/iCcN8puwHA4RL3Ci4Yiu9
 FLVMBMj9JVB6juu7y31BG0prTmsSQ9/S8kMbDcnuhelg/Wrrlb6Da/fFl45Mr0cOXs5t
 ilVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046731; x=1739651531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGrAWg9m4MtEXr/sMnC/5/hCnU3kDaDFhtpQV6triho=;
 b=vK3svO4rY78ZHEvXLRQytojLaxzg5PN4PlZesSH6h1a0h9t1+Na7i18taagRubj4UW
 INWtJpc+EbDQWZK92fStvNeuipsvLQUAqEv+ZhfiV9oXj7PV82H0+AT19F8R3uuIX/C3
 63WMVv+nT8/iGM6p9awbalCzPK8Bdne8G+A54d7EDdNppmdNji1V9JtE1Dh1v8IHQ153
 GRalf+HPhxZ9iz4UyUHBkLk8dF5FaCGp5aS229CwxbKLrtc/FJX0E0xriCjLRuM3OySs
 uhZGwWkX1Vnik2TO2NSuhjA2EAPrd5hP4vHgCPW/Fuc8Um/9rjm95uv2yby1lqqD/wOb
 ve8A==
X-Gm-Message-State: AOJu0Yysqa3jgRMYiGfG+q8JS3wxUL6Eb2hYI/qvmue+huZncp+S+qGt
 iuBUJbJtr7cc85JlYEprp12GwGM9Lj+phlxc3widTdKjuMn12g1ev4TVyboXeFJv8VoQPFy+Q+T
 m12Q=
X-Gm-Gg: ASbGnctn8PC0b8a+EF/73Xpx0SFfm/YkCscTnBlkVfTDdHLN+8i22P3xUl4uVadmoXS
 ZSo1Xq6d4yNVK3XIaaW7vR1VclioGKNtynDBe5T28nQoAgaBWU9KWa2ZxKp+7nKUwxCz2b6dsfo
 mKBcyS0lKc/2vfZcLPuK50hRZ+ZhKr9kJNoKx/xzuUghL6hRBExKid1iKoI48bNU9Qf8wOdggxO
 je+4kxSZeCR5FAcwIemBZ8qi4qiXq/dIGMAt4gZtSO/HGFDvMQkmKhRMeXeLGEDnSe48m5TfjN9
 swk3RgpFPlgKKZdvk+ANWeXYypwnp2Xl/MnEguLObwpmgjEPE/LhoAh7erPh7SGOOYaQ
X-Google-Smtp-Source: AGHT+IHX4/z1bmEbuleAuvIKti9u1cl1KRXkfcldyq7zC7EMIdr0iB5TEWN0vk2Kb/pDsIdk/tKBJQ==
X-Received: by 2002:a05:6a00:1d99:b0:728:e745:23cd with SMTP id
 d2e1a72fcca58-7305d421a40mr15751176b3a.3.1739046730853; 
 Sat, 08 Feb 2025 12:32:10 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 13/32] sched: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:05 -0800
Message-ID: <20250208203142.242284-14-stephen@networkplumber.org>
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
 lib/sched/rte_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index bbdb5d1d86..c9b955b8e8 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -1775,7 +1775,7 @@ rte_sched_queue_read_stats(struct rte_sched_port *port,
 	qe = s->queue_extra + subport_qindex;
 
 	/* Copy queue stats and clear */
-	memcpy(stats, &qe->stats, sizeof(struct rte_sched_queue_stats));
+	*stats = qe->stats;
 	memset(&qe->stats, 0, sizeof(struct rte_sched_queue_stats));
 
 	/* Queue length */
-- 
2.47.2

