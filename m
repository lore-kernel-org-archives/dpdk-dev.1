Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E3606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=PIadbXnK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5CFE40609;
	Tue, 17 Nov 2026 17:07:35 +0100 (CET)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 88E4C406BB
 for <dev@dpdk.org>; Tue, 17 Nov 2026 17:07:33 +0100 (CET)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8b271e573adso2199068b3a.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 08:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794931652;
 x=1795536452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w/fxgnVwYR0BUh/v3SgSOw46TY/q0FUiJC9brLDMjHA=;
 b=PIadbXnKuR6adZg8LtZgHsFLSKOCKBYwYbXGsMURPxEUaDqktLJLX8G/9vuH5kq7zJ
 YZOS/PS9VRZ15wbzK8APEkU6FSkZdOh2sYLt29prnkzv1FRyNHIrAS2CUXDwlVzVblXN
 LvHyhUfco4wAuCAApFykvy/x3xzypcrPV6kJK/vv0r6VDXn0l9/sDKFRPVoHYATpHc4b
 5oTKQIvF5/FFU8GHZ+TzkJlRJXx0PgnzoGMwdKUDH9rMKMG/pMxrEIfnpYdk9IrAl5ra
 0CNRHvny/ipP8CFLFxgwUskGEMif8a1eef+dkDv1dVXlaPZHPl8v4YreBmXN5ScZ2PfF
 EZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794931652; x=1795536452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w/fxgnVwYR0BUh/v3SgSOw46TY/q0FUiJC9brLDMjHA=;
 b=fUrRGtqjGr4QnfHFTKRdEYh6Py14lb7mJ32sVLFr0xHU/qkqbwB8IcIACB4OEOORFA
 zB6M7CPjRJUpN9TkqPGd+UaYCILW7jsqamM0iKO71RdTTtFbZDvh/55IAZYSpCTYrBrb
 kw9axWH4fyeG/HolRtBykot3Y/sJYMc8aDJcVFO+14r22hf+eW09htJzdFp5vD1gl4I4
 70yg5Jx6I+769kf8VHB07hmxF/Lgmv53iFqgLsS7nPkWpRbwaDzJHsciMtiUsu5izpoP
 KKm+GMxh1VomjSNyMDWpPvVwLMQfIUDtn0iwFhKHwI9/8/930LIywtpdyp0gZVcKhDe8
 Fu6A==
X-Gm-Message-State: APuU4Z954pOt1RR/uGopvh4NPsSPeX+ZbfaSFXDyDSA5W/y098pTEMUK
 8sbKY5tnZOVH11zFgHR2XI+SkGYlzdetxHJDtRDXrMSCm93YlcB7tZnQrVfwW9dcGfHM1UcDha5
 f6Y7/Rmk=
X-Gm-Gg: AYBFou0D5EgVX0/vethb92Kee+xzgEQ1/9btMlp7fOZZXvGAhEnbFqjrZHkI2A0zc8h
 I1fmKTCZrLdEUz0m4XJcXaPs0BAheN+uPQJqRnDoASMazQGf1SaMJdukrsjBqRkx6BqQ4RwDUJ5
 q73XQ2ETM7wVbhRbDv0uEhtGvVY5bOJlaghJ/ssuvRlF4F2tjvMjFcWUCSrOqcCXiZu5wMSJ+bP
 E0k4wWVRxio4K8wn5+4tz778MgciSHvHaZFrYCot8jpcQUhTRzD4tcQQlfmpnNc4GIes52+2ERa
 6bRWNTGlQgRHMorlu5/UwDd67WLVRJbFVhWIthm80TB95fcL/BAKbJpY9AVLiad+XwPhuCjAxqS
 Riz62LXbQ56WaoMG6L362J+JAM7hfFqf20RYmszrOYge7cnBoXKj0UABLKE06RWVxnwQyiNWPyr
 bqf/LQ3P0gUAmxy2n606sNRyEeydVJ5LDknXfy0kCDA7dAWuLneD1paL73h5/fle9DhKPHQF6no
 CfCIufmZG0seZ5S8rT9ILK1dz0lrNEMCUYpmkWks+WiOfUJgq/+CmWQkPWIcLaSb1+WsqKO2RXz
 nOeWdyKY5ORDiR1m6wd/A75RJUvw3sJ5HaR5eq2uN2docUrCjAXNqV7quBRK+5RAnMXb7d0=
X-Received: by 2002:a05:6a00:1990:b0:8b5:b3c9:ff71 with SMTP id
 d2e1a72fcca58-8beb374decemr12691590b3a.7.1794931651845; 
 Tue, 17 Nov 2026 08:07:31 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c5b40c3d33sm9403b3a.49.2026.11.17.08.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:07:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH 1/4] app/dumpcap: fix packet count overshoot
Date: Tue, 17 Nov 2026 08:06:19 -0800
Message-ID: <20261117160727.388470-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117160727.388470-1-stephen@networkplumber.org>
References: <20261117160727.388470-1-stephen@networkplumber.org>
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

When a packet count was given with -c or -a packets:NUM,
the capture could write up to a whole burst (32) of extra
packets because the count was only checked after each burst.
Limit the burst to the number of packets still wanted.

Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 46a6cb251e..c4790988e5 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -945,12 +945,15 @@ pcap_write_packets(pcap_dumper_t *dumper,
 static int process_ring(dumpcap_out_t out, struct rte_ring *r)
 {
 	struct rte_mbuf *pkts[BURST_SIZE];
-	unsigned int avail, n;
+	unsigned int avail, n, burst = BURST_SIZE;
 	static unsigned int empty_count;
 	ssize_t written;
 
-	n = rte_ring_sc_dequeue_burst(r, (void **) pkts, BURST_SIZE,
-				      &avail);
+	/* don't capture more than the requested number of packets */
+	if (stop.packets != 0 && stop.packets - packets_received < burst)
+		burst = stop.packets - packets_received;
+
+	n = rte_ring_sc_dequeue_burst(r, (void **) pkts, burst, &avail);
 	if (n == 0) {
 		/* don't consume endless amounts of cpu if idle */
 		if (empty_count < SLEEP_THRESHOLD)
-- 
2.53.0

