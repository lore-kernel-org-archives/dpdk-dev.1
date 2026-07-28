Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82AFC54F4C
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:12:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C55D0402E3;
	Tue, 28 Jul 2026 16:12:40 +0200 (CEST)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id 0EBD34014F
 for <dev@dpdk.org>; Tue, 28 Jul 2026 16:12:38 +0200 (CEST)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-667bae10ba3so3713582d50.2
 for <dev@dpdk.org>; Tue, 28 Jul 2026 07:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785247958;
 x=1785852758; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bL3hWrWYeUCELeJKAjhoGAU4Rrce3e+1Dgy4+1pWmPw=;
 b=QH0NBkKymr5EsBpzvgBgx/j7BXRGYfbcdAQtzAs6WCYGlJ3zDb93ek7ebOjjzzqXoC
 JbgZWruWWY1MlYSNOObKBluE6J10F57wVbYbllB+3cVfqeS/2yBRD0zU981prkHuucUP
 IB6ChlcgPmVPNQH7MaHPpT3cFkc5QfqgW3+PbuKhxtcMAwI8cF7fw/dDbGROr/Y9J7JP
 cgwYpv7SyC5Y102aGTxnMloRa0z7T7f1AMXRy2wyJWIJmn9trUAhmTFxL3Oba+do8G3f
 74/XoWa9I6w22EeVMw3x4/t4BewFxEL1NGs5oOUyEldWFG4NbsDuaQOTz+093Dz7/lFd
 GnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247958; x=1785852758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bL3hWrWYeUCELeJKAjhoGAU4Rrce3e+1Dgy4+1pWmPw=;
 b=jG4fhYqsS++Wu/YWcEbQmxfX3edKt2kn6JORcfAnZts9zFIlmAM8WR2IAFOVD0rm0N
 ApAn62Tt86hbLoeS/VouGI7E99pKP0O5sXNjj2IjBoBfI6uPJoi5D5EYGpKKLV0qtUOc
 k98p5qPZ3gYRxb/u2R8l4W8PuLeP1aAqQfwab2EoQySGsUJzOhiOikywLm9s3xH0JT1i
 gqIi3GpqDEpRJ0xaA0s1XGKhk5RqFmKyKIYpCgDbulnP9hlmtMxCR+1CZD/6TW6sNZ67
 kMnyxiOdQDMmfj4jhEluVF3fwwvChY3wCxikiBm6530EafhrMRTOcO5KGXtETS6WK8Dw
 nryQ==
X-Gm-Message-State: AOJu0YxJe35fvQaQGd4UsUfw10V9tL7+2ewpxM0TtvMiPTliOAPxDFmJ
 OrYUQauzCSNmw3mB9AkZQhEXj135tsp8Z60UDrq32O1RUdunPISOhJSbkdLWGFin9kx3EETUt2h
 EusdJ
X-Gm-Gg: AR+sD12tIEnswRuuTtXCWpat0lhzU0yF18VuU9uE5mpzGSevvn3UWqkxMUUyjsddmrs
 ylyhKB8Ptdm+FKqMUJ5srVR9uoWdHW76t5j6PjFYv6KiseWLOPfPZ5RHt+BAZIfIEFNkx+BvRE8
 9mNcGA6sIGIcZQnERGy4nZPe+KVgUwLAsBWo7OLGDGcnnK8Mew55jQNdp4hnLh0SEJfBKbgF4GV
 2HCT4+xA1XZxGCjc46qCAbW8PjKDpJKyhltIOnUJYZBJKTOZJwzm/T6Bf4s04Z1jrh5nELrtu/h
 dedz33g37iQwdtQlIf9yTT8wUbI5Xl8ACl3PAD/2ceVX9DrBM+5oFRcurSUbKJzvU2d76wAW8JU
 YDccVX3Jj+p6gljkWBAXpzN3Bad/YFTA6EpQxlWFJGgF5OddS4XGq6oDwHedOEZkvpJ0elg60fo
 0JKTCdi23N6urNXATPyO8+CY7wNNI2CHVCKuSiz/nv
X-Received: by 2002:a53:de09:0:b0:667:af05:2e89 with SMTP id
 956f58d0204a3-6690580fcf7mr615274d50.74.1785247958196; 
 Tue, 28 Jul 2026 07:12:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-668c6f6aea3sm5065610d50.12.2026.07.28.07.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:12:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH 3/3] ml/cnxk: remove unnecessary NULL check
Date: Tue, 28 Jul 2026 07:11:45 -0700
Message-ID: <20260728141229.93878-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728141229.93878-1-stephen@networkplumber.org>
References: <20260728141229.93878-1-stephen@networkplumber.org>
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

No need to check for NULL before calling rte_free.
Found by cocci/nullfree.cocci script.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/ml/cnxk/tvmrt_ml_model.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ml/cnxk/tvmrt_ml_model.c b/drivers/ml/cnxk/tvmrt_ml_model.c
index 319c53a05b..90bb286822 100644
--- a/drivers/ml/cnxk/tvmrt_ml_model.c
+++ b/drivers/ml/cnxk/tvmrt_ml_model.c
@@ -133,10 +133,8 @@ tvmrt_ml_model_blob_parse(struct rte_ml_model_params *params, struct tvmrt_ml_mo
 	goto cleanup;
 
 error:
-	for (i = 0; i < ML_TVMRT_MODEL_OBJECT_MAX; i++) {
-		if (object[i].buffer != NULL)
-			rte_free(object[i].buffer);
-	}
+	for (i = 0; i < ML_TVMRT_MODEL_OBJECT_MAX; i++)
+		rte_free(object[i].buffer);
 
 cleanup:
 	archive_read_close(a);
-- 
2.53.0

