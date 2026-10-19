Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA9BCCF2DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:14:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 415AC40656;
	Mon, 19 Oct 2026 12:14:25 +0200 (CEST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45]) by mails.dpdk.org (Postfix) with ESMTP id A59EC4060F
 for <dev@dpdk.org>; Mon, 19 Oct 2026 12:14:23 +0200 (CEST)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b8f5e2ce5eso1998925e87.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792404863; x=1793009663; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QAbIsh78UKMRclubZgwEZGJ+b0QkQylT3y+sAdhMCl0=;
 b=XiOIgD0VQXRFUVUm4qEL3ni5xImQgaWHOaON/131Y4Cdua6P741NCnwnGk+ZSthHsv
 WpaUaNTuolSzzIyX2VZta499YHesqYWcEPeM8QDdNC56S1EXW3vMrrOu3tNWpm+ROMP6
 rH0kibX2JAeC6kwagXQRhONuTVwi4wEy/6sMm2Q1A4M+P84JCvxdb5nwSpXVqcOiWmRW
 7oiCXinaHDhoRDL4XnZ/Dyvd0v0+MceeIhYXVUwhcA2VNzIqI/5C1uEmg3nUN/3JOlgA
 Kce0eE/6PvRCR3J2+5Sob+97l9DSooXXcXuKuJqzp0Nw/2+OQ8U5yAFkT1XyJbpLEBsr
 23yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792404863; x=1793009663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QAbIsh78UKMRclubZgwEZGJ+b0QkQylT3y+sAdhMCl0=;
 b=oyMszpUKK1X+YDNfE4txcAZnH3DR0waGNTYxXnRvIndqXGEU3YNzKOcrxOtiQIWkxC
 00p6MIkvtq2Q1p+VEHOG11uNEv5q7fFWkKI9o8O6td4MFtNcv4U5iallcqjAmX0r4ws3
 kHJZotTIs0hzXhl0gNZLRlCFYBzzVGZmiMJD/5NIgwgN9msaT3hUwYhPD3sQffw4BdoM
 V1iflTEu7KmAyThmapEvTDDbzTnKVLyHujhkN8CSfb38/5opBUy3ScJ+djuRHPZkus9G
 oGmxEeNndj/4ZridtQ6x+ncwyLKs9mn+4/Kxj+MQJmnYwFJMRZq/8luybTltui54JTAo
 /0Kw==
X-Gm-Message-State: AFq9FYKSfqtfsseC0sxjU24kkpWFRQWS4lmpBuuk6LOZC9iVRo1o/XMF
 V2iBvTq2wmt2otgK2J1lrdYecsWBR4RRktRIZkFrpuTBp2J0ZAmx+RJE
X-Gm-Gg: AYBFou3f5DQJRWLX/8XXPbjjWXEieO6Iz8ejhNPwtQ8hqw6R292hNoApesY7+vyTCGK
 /L7hJ3DYF0rw70vG5GvW5mQ7GjfKgJmv0ApZYrNumd1i1wiNvPwUyJ9TvB3v0TVGHUbkXjp545M
 KHxvz+6kEYR0Zkda5lebWYSLKbLw9+yvfIHK/ZEcMwjK/23KLLUnt2sY+0Ta01b5sWya5St/3m7
 8MZkslCH0lYWwxJZ8e+bp7lSTRelutax77Jfb63TATWxel7IaoeiHR6gTyz1tzry6HkXlWYN9Az
 xn7nyCFlRQzhtESHa18yaDrGgvW8H5pN17qgtRq1TFV6hTPA/oUczkQfcMyFN0MNoXog51wAYDh
 YROkoSv9jCfi08nUIVgoOFI9xzlf00oce5nPi5/Co5+Ko1ZouerpQlKI5Sj0tAMeR9FzAwEZgRT
 o3szufLsOji1SqAoZ320PnR1SYV3cLYuGFIOegYbOJO2xJrNREgYz+9ur89yRhEudOXA1Rfe/NU
 7i8Ms6gSVULcy1F5lxA1jtkLkkWumASe6yNwveev7vk6ZmXpomk0UqrB/uKp4z92OSgLicqf1za
 mXQElqQ1FdC7HJU6swXc4gM53yw=
X-Received: by 2002:a05:6512:401f:b0:5be:559d:97ca with SMTP id
 2adb3069b0e04-5be559d9d8bmr1393058e87.22.1792404862660; 
 Mon, 19 Oct 2026 03:14:22 -0700 (PDT)
Received: from WIN-IOON1T0QF6O.lan ([188.134.42.34])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be4a53cecasm1944585e87.55.2026.10.19.03.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:14:22 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org,
	Alexey Simakov <bigalex934@gmail.com>,
	stable@dpdk.org
Subject: [PATCH] ip_frag: fix IPv6 fragmentation of short packets
Date: Mon, 19 Oct 2026 13:13:33 +0300
Message-ID: <20261019101333.71145-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.53.0
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

rte_ipv6_fragment_packet() does not check that the first mbuf segment
is large enough to hold the IPv6 header, unlike the IPv4 version,
which validates data_len against the header length.

With data_len < 40, in_seg_data_pos starts past the end of the
segment, the expression (in_seg->data_len - in_seg_data_pos)
underflows and the loop never advances to the next segment, so it
keeps producing fragments and writing past the end of pkts_out.

Reject such packets with -EINVAL, as rte_ipv4_fragment_packet() does.

Fixes: 0aa31d7a5929 ("ip_frag: add IPv6 fragmentation support")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 lib/ip_frag/rte_ipv6_fragmentation.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/ip_frag/rte_ipv6_fragmentation.c b/lib/ip_frag/rte_ipv6_fragmentation.c
index c81f2402e3..fac72f84d2 100644
--- a/lib/ip_frag/rte_ipv6_fragmentation.c
+++ b/lib/ip_frag/rte_ipv6_fragmentation.c
@@ -89,6 +89,14 @@ rte_ipv6_fragment_packet(struct rte_mbuf *pkt_in,
 	    unlikely(mtu_size < RTE_IPV6_MIN_MTU))
 		return -EINVAL;
 
+	/*
+	 * Check that the first segment is big enough to hold the IPv6
+	 * header; otherwise in_seg_data_pos starts past its end, the
+	 * difference below underflows and the loop never terminates.
+	 */
+	if (unlikely(pkt_in->data_len < sizeof(struct rte_ipv6_hdr)))
+		return -EINVAL;
+
 	/*
 	 * Ensure the IP payload length of all fragments (except the
 	 * last fragment) are a multiple of 8 bytes per RFC2460.
-- 
2.53.0

