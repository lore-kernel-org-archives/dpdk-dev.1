Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3DAFF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:20:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 855C340DCD;
	Tue,  7 Apr 2026 17:18:54 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id AD15A4065F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:53 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso3508343a91.2
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575133;
 x=1776179933; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ynQuc27OeVmDSvIAFeLAuQds3vBBTCV5ZQGgABvpKs=;
 b=qHV84U3ZUdJy2k1TnSmriVlpVpmbIOqrLJ4QjgsiJRkLFyRZU0uYGMu1nkNLNxw8LS
 cpUgcJ30F3K42WCmfSA7HcyI+rfsfa3oQmm6iIoGAV0sC750ANaGzm/gMhst3RzueNV6
 oTdmr/fgVlxbaDhoq+/2kX//ZdR5OWzdN/N3uZIVLfQ8BQSfObwHbVvElbcI33wdn/A1
 HKfusVQOQ4qq9fuAolFLofONdMOALchJGRoWeGYTj8yJuiuHrNxgJ7ebhE6/qhCyg8cS
 2d2oJaK66yHoy7eAazUbHNw/ntk7lh0QT0Ch9O0FthkazcOW0LRybb84uZv+jtZykhON
 LDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575133; x=1776179933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ynQuc27OeVmDSvIAFeLAuQds3vBBTCV5ZQGgABvpKs=;
 b=pl0YGuFT8Doywvn35QXNnmzFw5xpzQgz4RNtQlF7bJ0mMm697Ju16gfyvNRzyU0eFx
 9hP9ehQ8t6eFBqoq/sx2TuffCIjUi61Y8AnwQ62YXtnUeL0lbSK4WKRrOH6X7oC9Xcqn
 Tt5z2U74LMhrpOznzIBh+UIo3x2dVB5LJp1RfTJAVh3Jnt5PqKfsoRaTcV0+QoLnIKvk
 edI0BNr0sCHHZksTR0HFCDSxbHWfKABdT56GJTiZEcJzQu+Z5EtFEz6U3eM4auuOdXno
 gJI1RNBGACNWLp0A2PuMg8lZkN/TqnOClsMBp3ziiOUbsHnofByZv/KV83bdQU5Avebf
 6ndQ==
X-Gm-Message-State: AOJu0YxvENLEhP8S/hG6igWUZCpy80dgf9FFv4Pv4ms+/HqGwBekhViN
 AIeSQTDyaStHcZH0sQInv+2fzo1oo9jHyM9LWXVBTsG77tnjyGYrPHfaVe+KE5dkrIedxTKzgNy
 PIHcM
X-Gm-Gg: AeBDiesCDDuXjaq7LAUxWpVkypOGrEnFaufVrIsnJTMmraf6/QLV6lKFPnuYVNaQWXs
 ilbUP4i0jFH7MYj5NiLXik8Pda2Yj/NymQnTb55eQh0pEBu82aX2B49xzIpg1gehJTwIvZFcsLK
 z4Yfp/10XbvQ9okw+37IF0etZzaqFa8R+WULWS6nbyd3dFdX4qMVaG2+17PkekhR1OI8+EAI8jh
 wP9NmcerRwjz267XdBBdFkoYvtgCC0gs3T6z1Mqo1Ew/+zpoDVn92vVLNaxJIWyg4Kr1LaOq43c
 6f08YXq6NlkKJH5MfO+T3Zrv23lpYPsC53p+d0zdNhMuOlpWl47wJ9N4L5Iq4aC5Thv83X6vmTY
 wctvk5n4CJO4tr+sX+SPi2dPtDXWyiaNcCJUiufwICjsWtdyJTwMTBTT/li24rz6TkpJ2L4qmm4
 m/zfZ1YRR4GqUDV3bvpVkM1Vy3h6B5oi4y
X-Received: by 2002:a17:90b:38ce:b0:35d:a557:e44 with SMTP id
 98e67ed59e1d1-35de678fc34mr16135242a91.6.1775575132780; 
 Tue, 07 Apr 2026 08:18:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [PATCH v2 21/23] examples/l3fwd-graph: resolve shadow variable warning
Date: Tue,  7 Apr 2026 08:16:17 -0700
Message-ID: <20260407151732.272195-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Replace global optarg with parameter arg.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/l3fwd-graph/main.c      | 8 ++++----
 examples/l3fwd-graph/meson.build | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 92cdaa1ebe..01c65b0abd 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -454,16 +454,16 @@ parse_config(const char *q_arg)
 }
 
 static void
-parse_eth_dest(const char *optarg)
+parse_eth_dest(const char *arg)
 {
 	uint8_t c, *dest, peer_addr[6];
 	uint16_t portid;
 	char *port_end;
 
 	errno = 0;
-	portid = strtoul(optarg, &port_end, 10);
-	if (errno != 0 || port_end == optarg || *port_end++ != ',')
-		rte_exit(EXIT_FAILURE, "Invalid eth-dest: %s", optarg);
+	portid = strtoul(arg, &port_end, 10);
+	if (errno != 0 || port_end == arg || *port_end++ != ',')
+		rte_exit(EXIT_FAILURE, "Invalid eth-dest: %s", arg);
 	if (portid >= RTE_MAX_ETHPORTS)
 		rte_exit(EXIT_FAILURE,
 			 "eth-dest: port %d >= RTE_MAX_ETHPORTS(%d)\n", portid,
diff --git a/examples/l3fwd-graph/meson.build b/examples/l3fwd-graph/meson.build
index e3f4fa8df2..b3ceaadb59 100644
--- a/examples/l3fwd-graph/meson.build
+++ b/examples/l3fwd-graph/meson.build
@@ -11,4 +11,3 @@ sources = files(
         'main.c',
 )
 allow_experimental_apis = true
-cflags += no_shadow_cflag
-- 
2.53.0

