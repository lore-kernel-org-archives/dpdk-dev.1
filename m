Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F7D2CDFE
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:30:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C97FB40A67;
	Fri,  5 Dec 2025 03:30:01 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 3ED554068E
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:29:58 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4ee19b1fe5dso18653441cf.0
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901797;
 x=1765506597; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=dJ/06zOjtC8wMwf1HJ+RmVzqo1SZNbDZi+Mz8VFfJfW3ezYh4w2n9RpxzN5XCOHXQq
 PZoktSuKdRmTvYPPSdUjhM/9LFZQk/jsJow+KNu/Krkw/7RfYiY0Kt55TiwWF2m656rx
 k27+C1W1uXyyvRcUeWz8XFNOdb/KJanQ+Qs/8P5zeKhKZST3ypkJvK/uLY/zbQbDOU1F
 NLuWTvDKwY/ebo27V/p1NnDzZP6Fk+DoBj9IlMsqaDmO910v4g7zjPwQe8eYo2bLyHR9
 gZx1dPgtp4yEdIJ2wK+WgrDqzd8PxetUbj3Hcn3q6XEfi9LO9701BT0aQ6T9xaClZelz
 bDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901797; x=1765506597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3vmW0EapljQF36KN4JI48XscDOxvks/pvjTAp8iLdZ8=;
 b=s4KRBljGaZU92OwGrFUKgVhtKgBYtR8ZNcOVf5wJ+ucoid+BANoWkulsDurjZyUKAM
 0FFq52/6QrXSxsJo//dXF3JYRtTO0cVo7CoIBpNC05jIiJ/PswbQddOprScZ1ijQD0SJ
 vMOTzHCDJ9wVn+IuPIeQr0P0TWwcbpbQtDDmHYNgEcOxm4AgoPF+yUy+OC9bPTFqdT0q
 PbYwFHR/E4tSCMPxNZHJTqqCvNwFHD3twopJyQup8lIy17RCCS9wq7dzU8w8LZzR0iPS
 VJ5krbI17fyI86TODvNP/KYgHIShNbbM1PT5+zn5g5yYmv7S+5kqupctZiSSFC6AbiDB
 vAsA==
X-Gm-Message-State: AOJu0YzZIMJU6FTby2F7jWVdXZhXMU2HNgo0JQZAVyLx2psfKecwdpmP
 Ga5LnawVEotLs0TQBcnLVacfG8iFjG7QPWVPrsCmBngyHAz5AQJVuwAtjH6hlz7oINqzoUsyXlL
 ulZuT
X-Gm-Gg: ASbGncvQM4a38eoGe10qaaT0dPNKoxhyQ6ee9gEdU2E5RTLBMW1aVZen73Y5Y4JMJl5
 YmO4z4lZXV5QtMCc/t2X/VN9dLLbpbi43bEju1gZ0qlr0DYxQ+iHQAWS4R9M2z0U7Di4xmPI6Wr
 CyApRGHvUgcNw2QoV7NS7fRQKiBdw1hzdetO/9THo2lcW/JCpbqw2UokbBfnm2x5526KG0WkWFy
 OwCr1th+GKsI2t5EnyjBY1NcCgZCflsqX6qFltXzW/nhRHcuE0U/DQXuNVVpt2qQvuKINiE8GoR
 g83fjOPTPtbWFWeubydX4YgI1LJ1BdpDiNByiRxToBN97esQVGc1VKQT3TqKYvvjwBGMABpHD3B
 LtfHQnA//wERimFh+JNnH/m41Bj8RhrYtlXwcCoMz/RXHFZVsvkfczPPhU6r5dvU4PE5/bkyJgx
 a4hitRW9MLjOagJGmisewZxe2ge0wMLnqTdOp8q6m/KS1Iv5crTg==
X-Google-Smtp-Source: AGHT+IGpQ4e9Jm1UhylYTGoAZ8j0kYTMC/xBth0E9pW2J7YN1TK65M7AO7OwVFk8cvoj9Q9S6aBJYg==
X-Received: by 2002:a05:622a:1105:b0:4ef:bd1c:69ef with SMTP id
 d75a77b69052e-4f023a16314mr71910041cf.31.1764901797413; 
 Thu, 04 Dec 2025 18:29:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:29:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 05/14] graph: avoid overflowing comment buffer
Date: Thu,  4 Dec 2025 18:28:14 -0800
Message-ID: <20251205022948.327743-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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

The library builds a pcapng comment to put on each packet but
the buffer is not big enough for the largest possible graph
node name, etc. Change to use asprintf() to allow any
string length. Note, if asprintf() fails it is better to
still log the packet without comment so no data is lost.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/graph/graph_pcap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/graph/graph_pcap.c b/lib/graph/graph_pcap.c
index 08dcda0d28..602be79ced 100644
--- a/lib/graph/graph_pcap.c
+++ b/lib/graph/graph_pcap.c
@@ -194,7 +194,7 @@ graph_pcap_dispatch(struct rte_graph *graph,
 			      uint16_t nb_objs)
 {
 	struct rte_mbuf *mbuf_clones[RTE_GRAPH_BURST_SIZE];
-	char buffer[GRAPH_PCAP_BUF_SZ];
+	char *comment = NULL;
 	uint64_t i, num_packets;
 	struct rte_mbuf *mbuf;
 	ssize_t len;
@@ -207,19 +207,22 @@ graph_pcap_dispatch(struct rte_graph *graph,
 	if (num_packets > nb_objs)
 		num_packets = nb_objs;
 
-	snprintf(buffer, GRAPH_PCAP_BUF_SZ, "%s: %s", graph->name, node->name);
+	/* put a comment on all these packets */
+	if (asprintf(&comment, "%s: %s", graph->name, node->name) < 0)
+		graph_err("asprintf for comment failed.");
 
 	for (i = 0; i < num_packets; i++) {
 		struct rte_mbuf *mc;
 		mbuf = (struct rte_mbuf *)objs[i];
 
 		mc = rte_pcapng_copy(mbuf->port, 0, mbuf, pkt_mp, mbuf->pkt_len,
-				     0, buffer);
+				     0, comment);
 		if (mc == NULL)
 			break;
 
 		mbuf_clones[i] = mc;
 	}
+	free(comment);
 
 	/* write it to capture file */
 	len = rte_pcapng_write_packets(pcapng_fd, mbuf_clones, i);
-- 
2.51.0

