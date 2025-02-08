Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB8BC0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:32:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8304C40656;
	Sat,  8 Feb 2025 21:32:07 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id BC2764064E
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:05 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso78174885ad.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046725;
 x=1739651525; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qeT7r4WiyXz9tJ6HeX7WbPfqgTjMbj+vgPGx8XOdZo4=;
 b=fYTauRDEneTY660xj4Ar3LoFYIQTqH0+rwedhfw27X9TOPITTxk+6aiAqqDxErmWaP
 /Dd1V/2SbV8ADaelqXXZb1Wez3R0hKPTiBLYxVflegPgwSd3QpDGEfpYVtoAHhsQlGwa
 R6Vv87tvQ69856xAnHHzqh2Q0Cq/Ta7edqaMBArR992iBb1u4oLkJ/T6DDbCNwa8vxKb
 rgc9kZJcdA8piaYpi+ze2dmIdRlBg68LXY0gm9F/c73ZtHV+A0wk9MX20qeYcD6w67dS
 j+G9RmddVvr36jPTITkwP2MlKnKCmIIyXd1txbUoIS1MgK0gjSb9GOO/w5U6CAiXUZfZ
 tp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046725; x=1739651525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qeT7r4WiyXz9tJ6HeX7WbPfqgTjMbj+vgPGx8XOdZo4=;
 b=DGDIA1dvCiV7gLu0/ndBIGDryBw2aGCRMHyiDI3xhk7bDKy7DwTomnrRlCbuDtLA/T
 EVsC2+4XR8/HtFeuX1AeXryvyDdghrxMO0TnrBqhjAc754kEthhBI5LKLo/aYkzHtQEC
 u4HXruU7DTfx7nROoHtOdrJm/zvDOMBVydfj69LKNwHE0C79VAcX5V8MUNK3WlpRywTC
 VP3seFyJnaX3jRExp4DkjhG3IyA0n4ftjCdEUBX3pEE5enJiRBnJx6Kec7IucyKH0r93
 zrKcoD8q1JdsxLxL2zETgjZs3KZbGTKxGhwIfw9JODYhwbdnGQvbLiQGHEh8rItoGjz9
 S76Q==
X-Gm-Message-State: AOJu0YwCA951Kkrrm812Om1fzUn4QuEyRR/XN7lfdKIK/VCe1RQM0iEA
 2AnRb9jFeNrCKHORzvx/Z8q85rzhLQME9ee5LxY+zLS7fktmZewhXaFBbHEFO+ZVumOp5FlvmeF
 8mcE=
X-Gm-Gg: ASbGncvlgzhB0iKHXUr5Q52UEfmJyMZ73DuiDd5KmcQyxG8FLfvgo6GORVCkpeFhhiz
 XZGwmh/1OmDq7WoMrh6iIizVxm0mXT7BlqprL94s5W7ECC7mp1rBvLWg0qA5I3QbGhESp89vjm9
 qd++QJwVFSteZtH8a8EBQohN23aQ4t4ygPwZHA8wq+6IK8xgA9LwwMo71V5zWexKMMqh2ZH85Fv
 WnC70iwjNK6xeIx2ENnwCCxtwABSMN6Yvah4x2dF8DMpOiN5KtrG3AxF+10GnSLVtKYaAS0Bfh3
 DNg9m8J6itApLzxmWBJQiZxEpixjHBGeNsznoP6CtSDrz9ynNQRARCKhvObd49nLk3uY
X-Google-Smtp-Source: AGHT+IFjP/kMmVsPq5cT1A6xwGwLVaSoKVdByS4dDW+x2jYH0kWRhHZBI6FjqbrUm8hEX6Q0NrQr1w==
X-Received: by 2002:a05:6a00:340a:b0:724:59e0:5d22 with SMTP id
 d2e1a72fcca58-7305d539f85mr15058362b3a.20.1739046724889; 
 Sat, 08 Feb 2025 12:32:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 08/32] event/dsw: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:00 -0800
Message-ID: <20250208203142.242284-9-stephen@networkplumber.org>
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
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/event/dsw/dsw_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/event/dsw/dsw_event.c b/drivers/event/dsw/dsw_event.c
index e68fb19890..399d9f050e 100644
--- a/drivers/event/dsw/dsw_event.c
+++ b/drivers/event/dsw/dsw_event.c
@@ -1078,8 +1078,7 @@ dsw_port_stash_any_migrating_events(struct dsw_port *port,
 			offset++;
 		} else if (offset > 0) {
 			struct rte_event *out_event = &events[i - offset];
-			rte_memcpy(out_event, in_event,
-				   sizeof(struct rte_event));
+			*out_event = *in_event;
 		}
 	}
 
-- 
2.47.2

