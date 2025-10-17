Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257ACCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 253F942E24;
	Fri, 17 Oct 2025 17:02:56 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0D81842E1C
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:55 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b6093f8f71dso1383902a12.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713374;
 x=1761318174; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtOYMKF3F5/NGklNLuzJzGFNHPESV/rKYXHJffDjLSI=;
 b=cCcM9XYAU6kTW7AWSROANFmq/buL0+Wcn0DisfDte2XreLoc09k7BA0aDl5doovecR
 f+BE5nY5+IFyQ1OsLWbeyfz+ertiEIL4cSDCTJCl/ZE3ctqGEctbzimuJfzkFfiQnJ8V
 jN79igC4SzlLd6jtpmNm6LnBFb2oLuGqohHzq3pTncJWrF+GBYmIXtKrOdahd7AaL/85
 vVJRHwoAdmXydrhvUtZ1coH182Y2wSg0ysOZ5gmc+4Ce54Y0JynW1TF9niuVBX7ZwOgW
 n6/wNYO0cWa/HlhMtL5o87kN2qcaCRmvw6oi7ETTbx6JPA5eDvhvcx/b2/h+D/Jiwl75
 nbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713374; x=1761318174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtOYMKF3F5/NGklNLuzJzGFNHPESV/rKYXHJffDjLSI=;
 b=EgFby9cYPvdGL7R16Hl/Z4ADfhqioxP40TE45MW6lqnBk0czDglmQjWOb74oimCO4c
 XJVRCp+IpWoGWLAsls7GKTS1wMmEDEkCllPLErOrNjRbn7jlcOd7FtABRS0ktrO5BIeI
 w9PX9FCyiBDbCKvHSiBU2A9cSS867FAjnw15E9gfZBpfOm+YNQLsjhF/JBHqo6SMrtS1
 CTil13k7RpbnkIKvcP+Hs9g3c5eCVCgtIA/Pl3E90N57l+upGzj5WYlexqy1PArXE6va
 N7PmfcHOES0dOknRf8ZuxlkSFnZUO8fh6iXp97eSzwqFg+czWkQG58ep8szHXg9bQFME
 7JZg==
X-Gm-Message-State: AOJu0YychZVtqpWFllwpkRgzgYKQfuzMUha146KdW3zHMgQvHkxK8ewW
 l4kKzmHl9y0hNWtszIgfnHNDZlnZEDNyZ61y0FQv0zOxeZslLKarkV8jTvVNN6Jh7X65L6PfUw7
 H1smgpmc=
X-Gm-Gg: ASbGncsqTr59B/AHY85LF7HvBKgiXuudatp+EXLXAvuFBccxK4i4ve1eZAH9BlvRgp6
 d2VjDbffYFnnBAwkVkDQ+t/EE/kbydazxIl/l6sHFXi1l/BWFU7A7JflD7S54ppTgA83Sea15Ib
 Ucxyi6dPBV9hjS9bXeKQTl3bPorHNNXBAn99ZDkBSk5BMvS4VvV5DzLQJOgVFi+TvPDJP3dPJTN
 gwXWHZ6L3CaXgGSwEfJGk3o8VwE47OH6NFQYtjXw0YGvdHC8xhrmrFCMoypIiatmOTpO6LLYe+R
 GOwqQFtlQCPIRUrSTUmIFsk69rsgB6gfO/ZxkLeLYFonvMSrwB0EJv92sBEo/UKSG+zMnFQWQel
 GdVBzURULbp3MbPzA5/rjqE5gu2R4J/79OHOviWs6MfdjJeM5UxKbz/6RRRBr2lA4CxR/60YiOH
 6yUolnftX6StTEoEvCt/xcIAw+v+3anlnJZaq57GR2sLg2guzItaVnyGV0tlfc
X-Google-Smtp-Source: AGHT+IHSDc276ioxVv3nvCGuqtHSTe3oixjBK4quKYjB9hlV9wDEDziXFGRkzvfK1wPTTNLW7HMAQw==
X-Received: by 2002:a17:902:ec87:b0:27a:6c30:49c with SMTP id
 d9443c01a7336-290ca4fab50mr56014775ad.27.1760713372907; 
 Fri, 17 Oct 2025 08:02:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH v5 5/8] examples: remove unnecessary use of comma operator
Date: Fri, 17 Oct 2025 08:02:06 -0700
Message-ID: <20251017150241.28511-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-event/l2fwd_event_generic.c | 2 +-
 examples/l3fwd/l3fwd_event_generic.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/l2fwd-event/l2fwd_event_generic.c b/examples/l2fwd-event/l2fwd_event_generic.c
index d805264744..73a264d8a3 100644
--- a/examples/l2fwd-event/l2fwd_event_generic.c
+++ b/examples/l2fwd-event/l2fwd_event_generic.c
@@ -207,7 +207,7 @@ l2fwd_event_queue_setup_generic(struct l2fwd_resources *rsrc,
 	}
 
 	event_q_conf.event_queue_cfg |= RTE_EVENT_QUEUE_CFG_SINGLE_LINK;
-	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST,
+	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST;
 	ret = rte_event_queue_setup(event_d_id, event_q_id, &event_q_conf);
 	if (ret < 0)
 		rte_panic("Error in configuring event queue for Tx adapter\n");
diff --git a/examples/l3fwd/l3fwd_event_generic.c b/examples/l3fwd/l3fwd_event_generic.c
index d86439df52..3a18001b74 100644
--- a/examples/l3fwd/l3fwd_event_generic.c
+++ b/examples/l3fwd/l3fwd_event_generic.c
@@ -190,7 +190,7 @@ l3fwd_event_queue_setup_generic(uint32_t event_queue_cfg)
 	}
 
 	event_q_conf.event_queue_cfg |= RTE_EVENT_QUEUE_CFG_SINGLE_LINK;
-	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST,
+	event_q_conf.priority = RTE_EVENT_DEV_PRIORITY_HIGHEST;
 	ret = rte_event_queue_setup(event_d_id, event_q_id, &event_q_conf);
 	if (ret < 0)
 		rte_panic("Error in configuring event queue for Tx adapter\n");
-- 
2.47.3

