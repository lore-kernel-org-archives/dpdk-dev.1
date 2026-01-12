Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F654D2502F
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 04:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D2B40A82;
	Mon, 12 Jan 2026 05:54:19 +0100 (CET)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47]) by mails.dpdk.org (Postfix) with ESMTP id 5B67540B8D
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:54:17 +0100 (CET)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b86f81d8051so198625166b.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768193657;
 x=1768798457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rs7RbH46fHMFA3yk69E1kXxyA9akz19oT9Ih6y7jxA=;
 b=HFsbG5ZBvzYE9PGYxFecJLeUYbWYZb+Jz7ZfCJtd6/WhYr8kTUqxHNVbg7gHr45LlN
 oZwaZ+DB/hiJho6+7cuv39jnNCS4fligW3ax9fAfRSLVmblSHmVHB8mpJOoJQpVWwiE0
 aAwlvJJvZqu13EPCClg9YmyamlqUhJsNHDZv+NyiakzyxZOU8JNAAf9NROCUdjfgRNYi
 O8jM0hX4oBgW6zm9F6JMDRL8f0oMW89Sf2xU3rFwUB8faidYbCrbLGqVORlIrGJpug/w
 +fI0zJY6OA8CFH0GFOp0vmYYoeUzcAo5VRVxEkXiWPghk6geqxdVtpsaplksceYj4NYU
 /A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768193657; x=1768798457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9rs7RbH46fHMFA3yk69E1kXxyA9akz19oT9Ih6y7jxA=;
 b=YdGN8vqWMK6vXZmw3SS87vhNqv+0AHAYw0zA+iSMEI9Yokn9xy35LZgE/Ez9FbKsQe
 uCCpiY1HpbdkyTIJr9PI3e3HRocwNNE14KYmqgOU9kO28N4Zm61o9RSEpv1bgb/oLdYN
 PJ175mLQaf4j5PDdx7QhjYjgOr/R75SE+vLuV4qF6YdxAMnlkPrFJz/N7cLlE0sZrLxF
 cOPGv0bfJnI7klZVh7yCb9q0Uat4YVMi+Lai+5U7Dc9W9+It2QubcCtaKxfXusfIz7vM
 GKBh1R9DkTb3Yg2stRnPO2xXIfnX4U1WOzQF2YHU1sS3hBRf6fUg1TxSNqntFixlQN8W
 nszw==
X-Gm-Message-State: AOJu0YxobNe2i/hBX+0YHlUQWiitPZb2kpRhneP7rkyngo8y+juYjnh9
 /FzKqF8EnZ7e1zSRtSDv+PIPf+WI4zmyBkpSr36YkS/syLtFd1XGJmDi+wAGt0bAtGHFQVIL5Z4
 ZQC+l
X-Gm-Gg: AY/fxX6r5kUURoBrw7TXeWRMYqj/Jtaa80dCDGUe6E3gSTFXKWLNlbXyyEf62IJA+Xm
 3gztbstBirg2yCqRbKi4jeSLMV2AdrONgRGMeKgLmLPPR0lUBmrYfaIBVjNljGqZFffRFOY5BE3
 ozYMMofW4uiy33M93YNmCjuQuGc41xDUsGNDkKf3+/mZaFQ9+Doidj6pUk8OecHm5yb1wpI3ENX
 8s87+VaSjyCPMFOpvQy7d4J8IWTkZefeyI8HiXvL4wrJ/LgWhL32IZHxXSJEI+DDMi7c7xXaOWw
 kVBrkln6tr/BTnkMPejjvGwOXezy0YpHuc8BJCXZtkLHWUycvFIO8CKwgQCPitTYtopBfy0ZluQ
 IPKA5p257RzTzRikdTLbD9x3+aS/0k4lcDZooghXz2Tno80KRNMFybI3b0LpyQ3A7av5jSfbCjJ
 C9NUIpwCR6F7Vhe3jWYTMGrXFRm/U6chjm3Qb9E+bn0io14sJgjA==
X-Google-Smtp-Source: AGHT+IF7eTVVEPTXSPV+M6dNTOZfHqE7dzV9ZGNf/NY2Vgg4CKF0Q8adsq6Km9rPnCZ7X6JB7cpnVw==
X-Received: by 2002:a17:907:2da8:b0:b76:d8cc:dfd9 with SMTP id
 a640c23a62f3a-b84299be953mr2085189866b.18.1768193656795; 
 Sun, 11 Jan 2026 20:54:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm534327166b.30.2026.01.11.20.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 20:54:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 6/7] test: increase gap in pcapng test
Date: Sun, 11 Jan 2026 20:50:19 -0800
Message-ID: <20260112045359.142999-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112045359.142999-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260112045359.142999-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Want to make sure that test takes long enough that 32 bit
counter wraps around.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 6e3df17525..f93bbb26ac 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -27,7 +27,6 @@
 
 #define TOTAL_PACKETS	4096
 #define MAX_BURST	64
-#define MAX_GAP_US	100000
 #define DUMMY_MBUF_NUM	2
 
 static struct rte_mempool *mp;
@@ -175,7 +174,7 @@ test_setup(void)
 }
 
 static int
-fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
+fill_pcapng_file(rte_pcapng_t *pcapng)
 {
 	struct dummy_mbuf mbfs;
 	struct rte_mbuf *orig;
@@ -190,11 +189,18 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		"Please collect your free cache miss.",
 		"Lockless and fearless - that’s how we roll in userspace."
 	};
+	/* How many microseconds does it take TSC to wrap around 32 bits */
+	const unsigned wrap_us
+		= (US_PER_S * (uint64_t)UINT32_MAX) / rte_get_tsc_hz();
+
+	/* Want overall test to take to wraparound at least twice. */
+	const unsigned int avg_gap = (2 * wrap_us)
+		/ (TOTAL_PACKETS / (MAX_BURST / 2));
 
 	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
-	for (count = 0; count < num_packets; count += burst_size) {
+	for (count = 0; count < TOTAL_PACKETS; count += burst_size) {
 		struct rte_mbuf *clones[MAX_BURST];
 		unsigned int i;
 
@@ -230,8 +236,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 			return -1;
 		}
 
-		/* Leave a small gap between packets to test for time wrap */
-		usleep(rte_rand_max(MAX_GAP_US));
+		rte_delay_us_block(rte_rand_max(2 * avg_gap));
 	}
 
 	return count;
@@ -468,7 +473,7 @@ test_write_packets(void)
 		goto fail;
 	}
 
-	count = fill_pcapng_file(pcapng, TOTAL_PACKETS);
+	count = fill_pcapng_file(pcapng);
 	if (count < 0)
 		goto fail;
 
-- 
2.51.0

