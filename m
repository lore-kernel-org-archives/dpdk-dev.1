Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BD5FCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:52:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88ED940E37;
	Tue, 10 Mar 2026 03:50:00 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id DD2F340E26
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:56 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d743ba241aso1218899a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110996;
 x=1773715796; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnBsbHBwSIvlq1lvk2FkFq5FF7lU2Ti3XJUgqMCu/E0=;
 b=GAE7m6bRMNxtHkWbKs1N+OYiL0g2OM6wV9M8MsDJdp36DhXaXrYLycEbdSHYTmpZoZ
 GflqCmU/caFjCLZB2sK5EArJv8j8wVvHnosBkVfH4WQ7U0Uejc8jjUN/QNvAWHWt1LUM
 oab7W+Hq70NBIDIlaS68YkUWjcckc888t6y8n2y40EUhSJ8XFp5WhMaUDTj3trD70WZZ
 bFB6dQ4L9njkBE0QQM7VNcAFC6bpRsvxc5AStGuzCfWsJ5uDZiFEwfUJosrS+gzDYhy8
 kjCnyEZiyJ84CFZw8/0ZaKWNedJwq8kHgpz/bt/SfU/bBoZaL5faBu/a9/jUy1J47iyC
 LzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110996; x=1773715796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bnBsbHBwSIvlq1lvk2FkFq5FF7lU2Ti3XJUgqMCu/E0=;
 b=mpQiTrNWbEb73HFpQinMcLnmiA0euzuszD3N/d/hQbwERqlBOp8MNaagc41DowqScM
 1PHrlLU8mdDEaizXqEAsffa4j3BedmbSHjtmqmhW6Px2UlLpHJRxe/V2vNYH+BNyd1T1
 HOXNLBmS7duRy/xkWqIsWR1TFhjBIkUqCEapnujb304ZPu3y6biXBUl82eB9oTaGXl9I
 KBAV/r4VGHTzGm0/r0+T1197rf5QLWXcpTCtrFPmX6JwAtFtX7d7BbYrySrOHajhFp7j
 AnhD5ucJh1EhPM7M1JBFWIiSgnDMOGIn4+EDGUAFE5vBxkZyUsrKNCtf8Pfodlj4qVGS
 oI0g==
X-Gm-Message-State: AOJu0Yxc58gWxhrJlmGQHd3EFCkl6JceXvKZYItaJS8+cVfU4SEbTTMY
 TG0JulkZ6lXWw1m6kl+VJm0zTJ05HO2Bw93OdeIMHCXladQf1gZ8YSnWTSVVo4EVBX1VsPbtoGy
 IYzRH31Y=
X-Gm-Gg: ATEYQzxjuVtMIRlh15KQ0vMWHSNZVFLuIHgH431WnmlldS9SoLD2mbBmh5P+JT4P+Rf
 zgTWSmF1GFH+KsCVf01vWkYQ5iPjya+bannxpkebhg62WrqJi9QOnHqN5UBKFRhpxvZaZwiEzWX
 2Lh+AxXjxEgsIbFt0+6S1fdMIGXGsC9lx8GmkY699IYfpuUa/0cpFjp5xjECy9DkNA5V4iQXq+E
 v8yq1mXB69GbZymj4Fs0LkF4bs2OGRwAUP2C9RQ+NATmIvg54JJzcxTftBee74tacH64vfI05XI
 Lw37/kOWSfkXbdnSccB2QpdIMzo4fshd2Rzrz+OX/wX9oIuaNmDQgQQ5aAlr520Or5aAzog84tm
 2UJY0EhX1X2INNsWnfeFsjQEpUNAKMmFF9pEwhjioIVvF88XlGtiJG1P0RLNvvKx823i7MnDiKs
 znU7y0QB1PqMItF/0UVX8qjYJFdpUm/iMg
X-Received: by 2002:a05:6830:4101:b0:7d1:90d6:403 with SMTP id
 46e09a7af769-7d726f3c158mr9262590a34.16.1773110996264; 
 Mon, 09 Mar 2026 19:49:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 25/25] check patch warn in test
Date: Mon,  9 Mar 2026 19:48:00 -0700
Message-ID: <20260310024925.476543-26-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

---
 app/test/test_pmd_pcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_pmd_pcap.c b/app/test/test_pmd_pcap.c
index 3b0a7e1348..4662e6675d 100644
--- a/app/test/test_pmd_pcap.c
+++ b/app/test/test_pmd_pcap.c
@@ -1912,7 +1912,7 @@ set_iface_up_down(const char *ifname, int up)
 static const char *
 find_lsc_test_iface(void)
 {
-	static const char *candidates[] = { "dummy0", "disc0" };
+	static const char * const candidates[] = { "dummy0", "disc0" };
 	unsigned int i;
 
 	for (i = 0; i < RTE_DIM(candidates); i++) {
-- 
2.51.0

