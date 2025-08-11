Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85978CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 21:37:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15F58402ED;
	Mon, 11 Aug 2025 23:36:47 +0200 (CEST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id DAFE3402CC
 for <dev@dpdk.org>; Mon, 11 Aug 2025 23:36:44 +0200 (CEST)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-45a119dbc62so300215e9.3
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754948204;
 x=1755553004; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGyukfi9kUcYHBak2qXLHR2j8E4WLyo1o5cGnOn/cTs=;
 b=2QmCcouqFZI7WkT5S5RYjnieX/DMuryncX3s4JMut5UxTx5tnQfdwRkQxDyN/xoPIj
 e9O6GDeEqxayWtBj0mJdRl9rknAAoOsGxFoIV1Lh7DdGfHUGq1eWVhm/UONfF87Nu0jI
 S/+miMML2Jtn15bthvPD7V0cXOf5+DbUNCovZFIKDRM3h6At9Iq64Ai6XiM/0IRirqst
 4lwQ8YnpjafzzukkO6QVLXoD5u7RfYqPHocSIN+CzG+T31S5xMwgQiodswFHBDxT5wuz
 Oerose9crqnqsFeIbDfDWoUmY+2D/mxIMdEJudlIKd3joeoMUQlUaNAtJnjBpthMkkXX
 Prvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754948204; x=1755553004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGyukfi9kUcYHBak2qXLHR2j8E4WLyo1o5cGnOn/cTs=;
 b=eAnMmMlC7qJ39AQkWnRrI5P+2ubZeuh/Mm2Or75RNc4YZnRVaHgZRWtl8hDaWIvCKM
 w9oianZIUkt6iNkGpzpbpkVMkWGz2mqVOxd+L6cjqxOJfYOfVp0hYO9pgAO015VhSFUa
 wIHmtr3bKqpSul76PSII3YC6KzSvbPN4HR0GACVVlfNJM3tdsuYWg48vsESCA60zGx0v
 7Q5240L7MPXQ9NQBLqtKnb6c3gu9iASmH2GLngaAyDVURXmIrGEYFZIX+lcRMFR1ZFF6
 9oKJh0nH/BulET/MUQwkFDg+w0VoAdI7ZOn5edT/Gz5kIuhN+9cACUf+yflVYyFvVT8K
 8P5w==
X-Gm-Message-State: AOJu0YzN/r/GWplc92gLZOwVPUlWSljHZvW0feqyV3j50YsKKvqhUtZO
 F51q2BK/JuBtcLLSXPH0xAF7T54+rVtYfDdbX/yvRd4B2pONk3z4Szfng8PYCDdwEYnWiAanBVt
 pVELm
X-Gm-Gg: ASbGncv8Hn6UPpWMmCzZxg1bJIJZclPSAgdhuFxv/sNNHnicjFaX4oAGwwwqChzOqaG
 8cKoCs68cpJxD3No//fQuWHxQxTQjHvHzztqshrc8opdFY1t2v9gk/uRy/t7Q1QF5NhPO/VprGs
 rIa2Ss58697uaBa6KrluFHclJyYmtiPsbqKRl7poWRfzsZq20JgK+eWlZbotod4mJ+X4RH4aKK6
 WISAoaxVHBrdB1NASaH96P8q+knHlDcakvgTPdIeDIcAC/4wekfDIkiOhuI8Ij2qwWmJm+1NWU8
 bIhdK04nIp4h6hwGoMnzwzig4RGv39UYZ3Stxkq1+Vs8HIMiFjqOu2KxODib7thm+XAaCVMmTqs
 Lx1tpa0rm1I+4aapmeEzjCAboIRGu54G8Lb1o8pmPx/nD7fcqrVgvzVW7McFbouyY/Fy9fgZr
X-Google-Smtp-Source: AGHT+IHSrpNN2XPDqgV7SyBMFjKVLF/ZNrcv8+PRTZytnKgSXzDkXWYBt0BEAUsctNIBdRETWWs9TA==
X-Received: by 2002:a05:600c:1990:b0:456:1006:5418 with SMTP id
 5b1f17b1804b1-45a10ba2e85mr12125445e9.13.1754948204491; 
 Mon, 11 Aug 2025 14:36:44 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a053a9019sm84661445e9.21.2025.08.11.14.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 14:36:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 4/6] dumpcap: handle pdump requests from primary
Date: Mon, 11 Aug 2025 14:35:02 -0700
Message-ID: <20250811213632.16023-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811213632.16023-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The dumpcap secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 7b19c830b5..c734fc7b9d 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -528,6 +528,8 @@ cleanup_pdump_resources(void)
 		if (intf->opts.promisc_mode)
 			rte_eth_promiscuous_disable(intf->port);
 	}
+
+	rte_pdump_uninit();
 }
 
 /* Alarm signal handler, used to check that primary process */
@@ -659,6 +661,14 @@ static void dpdk_init(void)
 	if (rte_eal_init(eal_argc, eal_argv) < 0)
 		rte_exit(EXIT_FAILURE, "EAL init failed: is primary process running?\n");
 
+	/*
+	 * Register pdump callback handler.
+	 * Primary will notify all secondary processes of change.
+	 * No impact for this application, but need to reply.
+	 */
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "EAL pdump init failed\n");
+
 	/*
 	 * If no lcore argument was specified, then run this program as a normal process
 	 * which can be scheduled on any non-isolated CPU.
-- 
2.47.2

