Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B7E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6BCD40653;
	Sun, 28 Dec 2025 21:17:01 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 22D3E402DD
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:17:00 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47d182a8c6cso37257005e9.1
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953020;
 x=1767557820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNkO+XUdoZOjqD4z0s2b33/q1Rk7dJ2y6eYnWtMzRaQ=;
 b=yj4eSpNNnJrpvevbPZUrTMOyN2CVV+G6lyABdexuJ5UoqNqd6NN2PoSSHeV+fPttPf
 OTf1KUcg4spT+N8GJWGa/VrvsoQR8OZ3dXJnL5xBrWHTWjegsB40hNLlGSKYzL3Fca88
 qjLO8EL2xoG/LFfGqcO3xu9wPOUouK9TDQ63M8P2DUB/wBjXLnC1zQep1Wf8twvjx4gE
 5z9717g+kbm8zBSl+Jg53FipjtStOI2FbL4meoo5ZyV/9UajmamT0IawOncQ27A/bl3h
 K1V4AZ9mO93FYs1x2MuNcBDZXOJBB0hrQ6M7YOerS47oq5IAEYtVxoS1TwaPxcrjn1Qu
 Zlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953020; x=1767557820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TNkO+XUdoZOjqD4z0s2b33/q1Rk7dJ2y6eYnWtMzRaQ=;
 b=EavcCg7NBugJIxgADZpQvhwtEz5dzqf5pYfEG6GgJNAQPH6KfCq44BGyj8BEpfyL3J
 PZfVwAuAVe5/3xAsBEARsPP3YFrpR8TmRqF8OLdbxjqGkyz5TB+PQjUiZtKNqXtEHr9V
 XpgbyjpLsWiTAB3kSrSvfk2wvxqui7Oynfqef+oJfk4Q10/0XmWO/K/TMGW4mdYh0xGf
 NPnq++p7hnHi7NKoxaWQYU1ItABAUNDO1tkQEXlIss0OpnYbSotIbjssdEntVfEtj/vQ
 sgOX+wJuOAFvOQGXzHqsKwGrFzaNMTtFmNUGI1tA3xnCUYTwrm23ajIsEB4fNxd3NkJB
 GjAQ==
X-Gm-Message-State: AOJu0YzmcISV1x1ryXzI4Ety3BJhQ//aTVzFTdTij79sjmeFILHuDwvr
 SrGjMporXC0ISRxV2k4o2F5J2blxwYly2L4g9K5lQg3XlsUM2mIz12XOtfj6eRmNmMH2JQqRREl
 9ZCi+BJM=
X-Gm-Gg: AY/fxX4Devcti23mYraiBHCEMzqsZGFoMmIsdqTwebC9nlKZfdqP4QG+vaZ0U343BlR
 2PBFfH3HVrYrw8NmNlPzWM9vtsJ6Uf43Z6Nq6QK1W+UlVcpv0SKFnqpcMuJlX2gKpXHEKTyXZMs
 IyglTMju8TJbbDzCnorLAvwzi3hDZkTi9bp00WY+X4c8jOg8lv4AIUwWHLaKstsUcJ93BmqOaKf
 Jt0o1SrOwuEoZ5EbtN5qZtZ3UuoTWhdCgF/2rd/tBi8i3k9TRObJNRpN/xPkvPAXySzzpCjsIeb
 6FQwenquWu7kEmbwtCCKPTfdSaNjzob026zer50hsZ/FIuYwGhjZp5UVPYI37R48sTT9Nc2O0Vb
 nICvnGW1h4sRDagUon1SSfNOFvDIVsLPgIaQReI0m90HAY7EmJr3kUpbEEq0v7wmqLMaUE9IOk1
 X0+FDYQpzyP/SRZdgY0pgVR2vDmVuOe21V8r7PoFp09hUsrrwAi3wNAZ/F24gZ
X-Google-Smtp-Source: AGHT+IGrO6KweKorMXtVUIj6ch0K3SRV9uTzkiCf97ZYVGYRCoW7uvmvD4uK0xyjtI4klvjk/3BA5w==
X-Received: by 2002:a05:600c:1f8b:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47d4846e310mr139020675e9.21.1766953019568; 
 Sun, 28 Dec 2025 12:16:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a6c9d4sm226286005e9.3.2025.12.28.12.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:16:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/4] telemetry: replace perror with log
Date: Sun, 28 Dec 2025 12:10:52 -0800
Message-ID: <20251228201649.555898-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201649.555898-1-stephen@networkplumber.org>
References: <20251228201649.555898-1-stephen@networkplumber.org>
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

Use logging instead of print to stderr.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/telemetry/telemetry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry.c b/lib/telemetry/telemetry.c
index cf4324421d..b109d076d4 100644
--- a/lib/telemetry/telemetry.c
+++ b/lib/telemetry/telemetry.c
@@ -365,7 +365,7 @@ output_json(const char *cmd, const struct rte_tel_data *d, int s)
 	used += prefix_used;
 	used += strlcat(out_buf + used, "}", sizeof(out_buf) - used);
 	if (write(s, out_buf, used) < 0)
-		perror("Error writing to socket");
+		TMTY_LOG_LINE(ERR, "Error writing to socket: %s", strerror(errno));
 }
 
 static void
@@ -384,7 +384,7 @@ perform_command(const struct cmd_callback *cb, const char *cmd, const char *para
 		int used = snprintf(out_buf, sizeof(out_buf), "{\"%.*s\":null}",
 				MAX_CMD_LEN, cmd ? cmd : "none");
 		if (write(s, out_buf, used) < 0)
-			perror("Error writing to socket");
+			TMTY_LOG_LINE(ERR, "Error writing to socket: %s", strerror(errno));
 		return;
 	}
 	output_json(cmd, &data, s);
-- 
2.51.0

