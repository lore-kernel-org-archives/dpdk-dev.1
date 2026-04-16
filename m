Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29014F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93A68406B6;
	Thu, 16 Apr 2026 20:47:55 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id AC58240A76
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:53 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c63e942f3so1650779c88.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365273;
 x=1776970073; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=DNpKoP+vj7nCmOTo2stZz/JUcH/vs+7O+CfUBsliF09babcpyqOcP0el0JQHXl+VtC
 IRJmUnJrn2qGFjLRhLedSmnwWF04jCGkwH4RJpYZ/QKuLvMIfbJVYtR447sOMoislQo2
 nSZzX/GnSDOOH3eYKIVCajTgCLbfny5ZuusQcv5EbO2YkcF6z2rsm0gunymVuTVvA6ri
 O2WrjlPOLgVCqJ/apxEwLifLksBCeW6gkqAEO8bXHrqm+czLzeq4qA1dqrF9NvSqjfbZ
 Jrx24wSPTLXFSEWSWUe/TJVSbLySvetdDI35RxfFMVUT5Cn3pE/hqg8euvoi8AxpYW25
 DryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365273; x=1776970073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fns9HMM4d3YH9P170C5Ks4p6FiIa/zNkb3rsNjQNKjM=;
 b=M3oALfkqrDq8/l+neTutHvw/TuY/5bCj9COBUbRLz08yprRb01yH8mZgUMzcTnK8G0
 T4rr7e6ONWTGM0zIaca/69+1Sa3+RsFecYV7m7PVaAdA9r6EibnvPZJcjK23SPYtYEpH
 wwL46Pf8tDoZ9+uInBjDlYlCso/B5xtgKkthNFUnREZ4V3teTfxw2+cDldSTwvUhGo58
 AiTa9B+94+wHwFwP0tlo4G2Iwbp+t18D5uM8tOQuLM1Z7i+emoO7KtrsoCxRCgYsSKwK
 +IK2ZsTeB/kzIpaxL1NQ8sqNuDkWBjE/hI052Qv18Yk/h234cvibeY748Uj1+484NJlw
 aaAQ==
X-Gm-Message-State: AOJu0YwYe8XUAXSEwZWTW/4UTyRul1xZKypWWHy7FQIHfzZo0Y5sQKA/
 T3LLSTaS/ix3yragRUxICWKx1RdzyjJj15tQrnVhdGX0MB3l4K9qMC/etLUygZqhTCM5q9nimmD
 Y1EVM
X-Gm-Gg: AeBDietcX9JGJqMMyri7IFJNACzYLEgMEUMXDPYbRmPW6OML+2d34Uu9RZFRTefdCM4
 UmEH7ukHK3x7WvXPyM0MvNh/bdGOCji4X0l0p6hhQEhNi/i8HfTICgNK+YTtFJOfwXRmbbeROKa
 2Z7jFM3gtzitjHelHXix+HEd8CqCe0Mew9N11BeLTA92QvZag7s8D1ye/ZovCrd5wckAAylBwEr
 Avhh1arxiXmREuDYDYwg0v+47op+/24jWuuKJ9h8BmkbZOwtPbjn22Fs44kHODJjEeAlJ6Ujvdj
 wvY10aZkU/6VAoyLtb1orZsPqQNx8szyBgjWG1qogGWE/dq2axQCc9JqI1m8+yJVkBjXCHggX+Q
 Qjz+1aBSIX5LyH78X2M+L4ZtjAB5gC2kIPNuroRn71aRD979bqP1mVI0qQFE3QdBPyGwHb6LMmp
 D+NljxTzallzAMpInOjvJ2kG0dCiA31e4hHwaX7FXEGfI=
X-Received: by 2002:a05:7300:ed0d:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-2e2e3d686c4mr246433eec.3.1776365272714; 
 Thu, 16 Apr 2026 11:47:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 10/24] net/pcap: clean up TX dumper return value and types
Date: Thu, 16 Apr 2026 11:45:32 -0700
Message-ID: <20260416184731.1347342-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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

Use uint32_t for packet lengths to match rte_pktmbuf_pkt_len()
return type. Split rte_pktmbuf_read() out of the pcap_dump() call
and add RTE_ASSERT for bogus mbuf detection. Remove incorrect
err_pkts accounting since the dumper loop cannot partially fail,
and return the loop index for consistency with eth_pcap_tx.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index ca08b8e342..8df66ebb96 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -407,7 +407,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		size_t len, caplen;
+		uint32_t len, caplen;
+		const uint8_t *data;
 
 		len = rte_pktmbuf_pkt_len(mbuf);
 		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
@@ -415,15 +416,16 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
+
+		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
+
+		/* This could only happen if mbuf is bogus pkt_len > data_len */
+		RTE_ASSERT(data != NULL);
+		pcap_dump((u_char *)dumper, &header, data);
 
 		num_tx++;
 		tx_bytes += caplen;
+
 		rte_pktmbuf_free(mbuf);
 	}
 
@@ -435,9 +437,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	pcap_dump_flush(dumper);
 	dumper_q->tx_stat.pkts += num_tx;
 	dumper_q->tx_stat.bytes += tx_bytes;
-	dumper_q->tx_stat.err_pkts += nb_pkts - num_tx;
 
-	return nb_pkts;
+	return i;
 }
 
 /*
-- 
2.53.0

