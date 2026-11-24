Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09E606A329
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lM0+xe4W
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 049AB4066C;
	Tue, 24 Nov 2026 19:03:30 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 805C54064E
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:28 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso3702120f8f.1
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543408; x=1796148208; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g12hK6KC9IGtzMITZ9VllOwVEmvbI7enqCfjDw7wuJ0=;
 b=lM0+xe4WRrzNf/RWqNY0GgX5sUsxA0a24VN4gZkSniQVZ0eMeUiKuO3HEFKR5yycsA
 7aP0GMPrxvSKyXzabjMYTgkjUeYAa0G/KMg355kPmekri75OtFmZqze9mBqZtaztAJsC
 EIvp2lBWSUpLOBPTCn+6FGCIBEwZ7MhZbKttHstGsJV5bfhL6xr1CFhSPLEe9eMF+iFh
 0//WLgYzcovMqnXu0x0IHakv8kBeNe7iNo2tqkDlw8Ag4MlCyym0tF5pC4p1Roy0TH7c
 glzO6fU2sDUFUPOTTrC91o0r3PplBJFTxxA8+SPd8gNtFDhYu4BLDPxpRhJf4E2VQ4Ma
 S3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543408; x=1796148208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g12hK6KC9IGtzMITZ9VllOwVEmvbI7enqCfjDw7wuJ0=;
 b=zKJvuXucAdIyh19HkTqs60qD6qdzsUGykzrjUPtSOSjzZVVeft1fiyeRTieowVQgql
 Xp74Acgj8pvjIctFOBILOLXZk62xu6V851P0+I4RjdFiCZhJtA7LlhlohR1jpGtVB0R/
 pi8iw/qviPLGlOaoMQS4IxhysRHhHSUZTgu/h0S29408fxSJUMzFgxLOnU+SMwanMjAJ
 NX4exurVfgtwbgc7pkp5w07WpD/6jAgbOk/OMdd7vlqGuGPR1n74hK4EX3TPZcce+fdf
 WCeoZllhYZs9dwU3Xxerw9ooCczRuxl26jwuLjBY/JFp+ZE+/wTBKadB62bZ4QVVXgMt
 l+Pw==
X-Gm-Message-State: APuU4Z/YURvf2cIji8iRk4UonynmDL/mjofC3q24vbCz8wjMvd93B27H
 kjoorSsPxc+1W+eUZnz/LARmPkgdVraIwy8NMGHK8V7V179M3MK5YhM3MCoa+w==
X-Gm-Gg: AZFdTZfd2Z3HoQ5U7jcBNeGCCkPXL890pdD6aq9RcWcwZtEgm3q7ouKGJz5jKkZvyW+
 GrHs2MDEmj9AIs4P+LddAMXOLFwTBb1ZWkQEzbx99ITB1s2ZXT80E3Y0kvrwBgsEDisFfcDeqPh
 HEPaNtnmMl3Xkp+CWrXSVbmbhduitYOkjfK02sEgGT35j/BcCzd/VH3K2DZJiDxGwJ3V1mq0KC6
 CuwLVsFUf6mo6WKwQIU9+WyrMCk1eyOXHj1Crz6kaJf6AZ3VvL0Ebk1+toEVWxWaZvjG9jfpIFC
 TjAsiy14i7L/wjRrztwbIbjQ0LPt63cgLhPWDT//kqtosEzmVIyk/epYF2I99NDEm3oU2SHYrNA
 wypsVzPgXJ22bLrzaO/fOKP48E3v/7WT8IiImhkkXK8jiPPm1CIXWqCVyvtTXGYk8SYOCj/8WmV
 EoW9SEZ3/IAPgBAsoet9NDVTZ9sCCJebLryD8lN0dDlUDaHlWfcw7PiDwtbNH+DMC6H+olTeSkJ
 y1uiIqUDXuAtMSvA+sKATrURqy/b5uaVwnwg1XEtOgfrkbx8QgLHsQoS3tgUkq2flmpj/YI24fe
 eLbwOoco8bl0aGWeY7n+hBNpp1go3yXaqqzhhcKqa0XtwfgLpGAsWCYDb5/G
X-Received: by 2002:a05:6000:26cb:b0:4ac:f59:60de with SMTP id
 ffacd0b85a97d-4ac0f596109mr33292734f8f.18.1795543407834; 
 Tue, 24 Nov 2026 10:03:27 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b5f6sm27516102f8f.34.2026.11.24.10.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:27 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 04/13] examples/l3fwd: zero-initialize FIB6 config struct
Date: Tue, 24 Nov 2026 19:02:40 +0100
Message-ID: <20261124180249.1099506-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FIB6 configuration is filled field by field, which leaves any
field added to struct rte_fib6_conf uninitialized.
Zero-initialize it.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 examples/l3fwd/l3fwd_fib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
index 32c8847130..38f947f970 100644
--- a/examples/l3fwd/l3fwd_fib.c
+++ b/examples/l3fwd/l3fwd_fib.c
@@ -640,7 +640,7 @@ void
 setup_fib(const int socketid)
 {
 	struct rte_eth_dev_info dev_info;
-	struct rte_fib6_conf config;
+	struct rte_fib6_conf config = { 0 };
 	struct rte_fib_conf config_ipv4 = { 0 };
 	int i;
 	int ret;
-- 
2.43.0

