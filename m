Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D6FD0048
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:09:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DF4840ED3;
	Sun,  1 Mar 2026 03:07:58 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id B9F3040E48
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:53 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8cb4136d865so438918785a.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330873;
 x=1772935673; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w98bzxAWFbtsalPfUIzvmoUwTVFRfnPZXyXtstNz1g4=;
 b=e+6L9S737PFnmyr/QQ5Y/HARd2mirp5VlfOhQGkFnQctPVlgDstf75zZbL1fOI9a3U
 Y9rwKxuhG9XkGMUM1F6V19zStrDLxgfF+qURxhF+96tkd+yVNW8eDFs2cYX/R1wsF8I2
 DXS6Neag7gENzztQCtnFmQFu4UEbBU1nNkyX0R3FzOxg11VnJm0PSOtOnpdL0+SzLf2U
 xuctSuss4mReE8zhRCKICFwce+nrQSh0OiZR8h+v4ZAHVRDPv1AZzNCUQmLydfuCcE3Z
 wjPMfjgPcLtdaM39f0l2gqtUZo1SS7z+iSsP6tTyokM69MEP4o+WNkHqM/2V1tjo+Nuz
 BogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330873; x=1772935673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w98bzxAWFbtsalPfUIzvmoUwTVFRfnPZXyXtstNz1g4=;
 b=kaN9g0wLG9IY8oEPZXFuI4o/9XFI8xdnY3TqTSNpnSxY8a5huHd8HBUX5HJhAWIwGw
 RYpX+t1AYZwgP1gB4mtN6K4lQ2ZbMIwcx99Hlkomne1lY0h2UHCrSYyYYpmy7p/K1cxg
 HWtooI4mmXXXcJYICc3ylakTqx8RK9V6UHg4J2sM3Qx+vlsSR9+6PKOHvgcoCh4ZRDLn
 nqpmP21VMmoBxKhqQO2gC2ut20OLOup8nUaeq+mJzPrZDth2Ba46STc4UL33E+Frie40
 dQk4dGgg48DV77twu0boszP8sFYrkwmVCcXdk5o82ujRuIERwSERViJTDIsBXgiaqWLB
 0W/Q==
X-Gm-Message-State: AOJu0Yxwet9ThRTemdklnGnchic2g6fpFd1EU2T7GhQxW3PSbGPZTrXx
 cESA1jX7J7nvCEXFZ+eumxsx9CL8JtEga7VhK7fiSA4T/PoWTuhrUgMyTuVHr0uDPPRgVPuWQe7
 l6UOz
X-Gm-Gg: ATEYQzwXTyCaYz2r7ejKFgqyXSEri37MM1VHG4Tp22YYv97+yZVENdvCngm4HbTgzGA
 doJOltOXrclmog5OszY1ZxkSSB8rQkLw/Z2FZR5xD/C9CLFmvF4WjWQGSYcTB3inVbUWovJy1Py
 ZSsWQrLzYAupNyNwwV25ik31t/oNu5c+3hHtBdauzFMmJRAjXO1vuAeWP5y4VUQUalSme/UljMz
 VB5AJYm/Uzqs05mvqPIkeQghfNQJdVsWSAu+KBU6Jg+7aotqQGj1j0F6E6mcG6icrAn4pIuUl6F
 0yAKuDzwMFteJnUj0eTohZ245gXP3fSJo9fiw73TzWgn4D5g12Zf1n9qaEIGPKbKbL6ZgU1b5sV
 e2jBW/43JYa/qfDuMzNp1QZHFWpWLfJd0kI+sJ3CLI4vtiVvq/993Cq/i/ojwql/IPnwu3k/hwl
 fHjLFeioLA8cx4w71AuzmT7MFLFmcu/G4IJ0c9WNqKEOEs0OVSFejLidMdEHom9A==
X-Received: by 2002:a05:620a:4720:b0:8cb:5442:d539 with SMTP id
 af79cd13be357-8cbc8dc28b1mr1082595785a.2.1772330873096; 
 Sat, 28 Feb 2026 18:07:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 17/23] net/pcap: avoid use of volatile
Date: Sat, 28 Feb 2026 18:05:50 -0800
Message-ID: <20260301020726.852401-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

Using volatile for statistics is not necessary since only one
thread is allowed to operate on a queue at a time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 1a9db50990..14edafb581 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -54,10 +54,10 @@ static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
 
 struct queue_stat {
-	volatile unsigned long pkts;
-	volatile unsigned long bytes;
-	volatile unsigned long err_pkts;
-	volatile unsigned long rx_nombuf;
+	uint64_t pkts;
+	uint64_t bytes;
+	uint64_t err_pkts;
+	uint64_t rx_nombuf;
 };
 
 struct queue_missed_stat {
@@ -908,11 +908,11 @@ eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	      struct eth_queue_stats *qstats)
 {
 	unsigned int i;
-	unsigned long rx_packets_total = 0, rx_bytes_total = 0;
-	unsigned long rx_missed_total = 0;
-	unsigned long rx_nombuf_total = 0, rx_err_total = 0;
-	unsigned long tx_packets_total = 0, tx_bytes_total = 0;
-	unsigned long tx_packets_err_total = 0;
+	uint64_t rx_packets_total = 0, rx_bytes_total = 0;
+	uint64_t rx_missed_total = 0;
+	uint64_t rx_nombuf_total = 0, rx_err_total = 0;
+	uint64_t tx_packets_total = 0, tx_bytes_total = 0;
+	uint64_t tx_packets_err_total = 0;
 	const struct pmd_internals *internal = dev->data->dev_private;
 
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS &&
-- 
2.51.0

