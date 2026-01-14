Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC16D3CC86
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 22:27:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2C904275B;
	Wed, 14 Jan 2026 23:25:41 +0100 (CET)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65]) by mails.dpdk.org (Postfix) with ESMTP id C71A740FDE
 for <dev@dpdk.org>; Wed, 14 Jan 2026 23:25:39 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso3011735e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768429539;
 x=1769034339; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRnFgh+xUBTgEY79gFYf/Awy1ntxj9YkuqDKG8xi2SA=;
 b=eBNLd6kDBjltYVLdBdyAypr17M6i5+WAKIPK06xDgd/Z3Ag4J6pZF3tsi0TDNYnuzJ
 W2PijALXDIzpo6p7K6Ak8s3IbAmtM8CUcWSGMeecZ+1p31ugwg0mRsVZMYlVVe3KtyX9
 R4mkGXNvntUumu7VaCHSS12BLpNP/ssK902Y32nYIQokir0vh/A2w8WwxFSOH+vqYDC5
 jH2CMCVNyWLNjc7h3jXLYeAS/6lKwC86JTxTT2lez++MX6t4aAI5jr+rYPTiiFVa3Zb+
 j98yrsZr6Bva+sGA65xwU4xUnY7lfflMfXB6E6ayJbdSSE2uUvqg5qQHl2VjRf4SbNN6
 bVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768429539; x=1769034339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cRnFgh+xUBTgEY79gFYf/Awy1ntxj9YkuqDKG8xi2SA=;
 b=ex7SZSzsuRokXG/qR7AT800iqVx9A8bnAiwfgAX+UhglTZ+8ohA2ezWEBYSxEM2Wg8
 aHr6zKnO2QSEK8Ofb23/IGBJUw+3UnP0FBOdURSFnsbBOx1PCMnjZHh5LxRW3UAyq7I7
 wU/aKEGoz5EpPlsCK69jPROAjUGKNo0I5OeKF4SzRQka5x3HVK/R9kmOo3lEdA8FTnDW
 yMQ3HZWziBS6dfgRs6JLvWn5IDqwgofirqqJ/+DA4DEFBH/J3nhTN1VOZBtn9jdwSIF1
 QXfqyFo6i/gc/nKgpsCCB8LJuZf8Ik0lqI2zAq3s18+GJHtG/PlEm5vylMOtkhn5EM9v
 2xhw==
X-Gm-Message-State: AOJu0YxwGM8DCt0lPGvJU5kqwZq3l1ibAxwJ0cQxA9P3VchPTaFjVVMy
 RvVz4HmzxGlgip/XXx+vXO3HvgN/nwN2IYILKD0I6L1BV6DTq9UHEvYgNBDrtL2tNIn0zYHWnw6
 2mtWcc/s=
X-Gm-Gg: AY/fxX5B13pJ4IwDeSmrKpoU7J1dMXE1nQ5pnohO2abWJBuxQoeXG9C1q3YkNZTYK7i
 WY8WL4q+jnV2kZMlslUcohDh/mnL1x5kXZXA9xHMhVLJlQu00ya+IL4W7NT6f7RmlItEKDtWI3V
 IKwQl9DpRAjqaWMsQ1IzHo3cJVCJeUzUL3LG7UNfG+KpEM0nQ+LnH2jCRcuw0SMT0fYhMYIp/Z7
 zcDiADXzfIEve0FMSDDjh0XdqPsS3kXt8LRb7xqcsxTBa4VUCWYky4PP2eJwJbS7/r8fnRAB6NV
 N+twMC0Nh/qZO8qH1//R0BSq2/J3cFuRDp9zp7YygvmNUYqMj6ZwMCZniTHEz0x7dOelLRNUJA9
 DrB3o6Kdp0AEypKHPU1FWn0CIExmvfBKTjrZjD8prpkhA1QGIZmncNxWbdJ51y3svqpSvZZ3AfA
 ciDqVKCzGUPwNhB3fc2XoJQdXWUXS25bTndQjFEB4zfGBU6geszg==
X-Received: by 2002:a05:600c:8b62:b0:479:1a0a:ebbe with SMTP id
 5b1f17b1804b1-47ee333b6b9mr50438025e9.14.1768429539349; 
 Wed, 14 Jan 2026 14:25:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f42907141sm12040355e9.9.2026.01.14.14.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 14:25:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 21/29] doc/guides: improve IP reassembly sample app guide
Date: Wed, 14 Jan 2026 14:22:02 -0800
Message-ID: <20260114222458.87119-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114222458.87119-1-stephen@networkplumber.org>
References: <20260114222458.87119-1-stephen@networkplumber.org>
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

Improve the IP reassembly sample application documentation:
- fix hyphenation of "run-time"
- replace "wouldn't" with "do not"
- fix "mbuf's" to "mbufs"
- add missing articles and spacing

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/sample_app_ug/ip_reassembly.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/sample_app_ug/ip_reassembly.rst b/doc/guides/sample_app_ug/ip_reassembly.rst
index 04b581a489..092084ba8c 100644
--- a/doc/guides/sample_app_ug/ip_reassembly.rst
+++ b/doc/guides/sample_app_ug/ip_reassembly.rst
@@ -12,7 +12,7 @@ Overview
 
 The application demonstrates the use of the DPDK libraries to implement packet forwarding
 with reassembly for IPv4 and IPv6 fragmented packets.
-The initialization and run- time paths are very similar to those of the :doc:`l2_forward_real_virtual`.
+The initialization and run-time paths are very similar to those of the :doc:`l2_forward_real_virtual`.
 The main difference from the L2 Forwarding sample application is that
 it reassembles fragmented IPv4 and IPv6 packets before forwarding.
 The maximum allowed size of reassembled packet is 9.5 KB.
@@ -53,11 +53,11 @@ where:
 *   --maxflows=FLOWS: determines maximum number of active fragmented flows (1-65535). Default value: 4096.
 
 *   --flowttl=TTL[(s|ms)]: determines maximum Time To Live for fragmented packet.
-    If all fragments of the packet wouldn't appear within given time-out,
+    If all fragments of the packet do not appear within given time-out,
     then they are considered as invalid and will be dropped.
     Valid range is 1ms - 3600s. Default value: 1s.
 
-To run the example in a Linux environment with 2 lcores (2,4) over 2 ports(0,2)
+To run the example in a Linux environment with 2 lcores (2,4) over 2 ports (0,2)
 with 1 Rx queue per lcore:
 
 .. code-block:: console
@@ -80,7 +80,7 @@ with 1 Rx queue per lcore:
     IP_RSMBL: entering main loop on lcore 2
     IP_RSMBL: -- lcoreid=2 portid=0
 
-To run the example in a Linux environment with 1 lcore (4) over 2 ports(0,2)
+To run the example in a Linux environment with 1 lcore (4) over 2 ports (0,2)
 with 2 Rx queues per lcore:
 
 .. code-block:: console
@@ -110,7 +110,7 @@ The default l3fwd_ipv6_route_array table is:
     :end-before: >8 End of default l3fwd_ipv6_route_array table.
 
 For example, for the fragmented input IPv4 packet with destination address: 100.10.1.1,
-a reassembled IPv4 packet be sent out from port #0 to the destination address 100.10.1.1
+a reassembled IPv4 packet will be sent out from port #0 to the destination address 100.10.1.1
 once all the fragments are collected.
 
 Explanation
@@ -142,7 +142,7 @@ consisting of up to ``RTE_LIBRTE_IP_FRAG_MAX_FRAG`` fragments.
 Mempools Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-The reassembly application demands a lot of mbuf's to be allocated.
+The reassembly application demands a lot of mbufs to be allocated.
 At any given time, up to (2 \* max_flow_num \* RTE_LIBRTE_IP_FRAG_MAX_FRAG \* <maximum number of mbufs per packet>)
 can be stored inside the fragment table waiting for remaining fragments.
 To keep mempool size under reasonable limits
-- 
2.51.0

