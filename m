Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E144BC3601B
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:25:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBE8D4065D;
	Thu,  3 Apr 2025 01:24:55 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 7319940656
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:24:53 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c5e39d1db2so16905585a.3
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636293;
 x=1744241093; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UI2tTP5STXxqQD1JzZfwIJKUWqB2PP+Wr4PkrgGsjzA=;
 b=yV1QKqSwODkxxKajCukvQWft+ihH1YwqZhbQQso1DsszxHvems155Ul7He1dLKuduS
 IweKNFzMIozpxG9o6DzpfTTHLi+SA6xli4qjiiKkt7oanBNLvOo4JtBBjGHDD5DkVvE6
 fPMEY+eLSsTnP21squ4yBsWA/j0sFEyGJ2vrpzaLaXujACLfFpoyE36BvPcM/C2OVbVI
 ty5uYQ1vB11tvBw4TuWnsAAqZyFHQjDjI8gQbxDtnl0SYWJfvOOsSWH5sFJA0hSDjFe1
 Yd2uqJWn/87Uwo+ptu/vTKUuCap+qjLS1LXrBnK2aa0h3NSOoxK2fGOnFAlfYe+76ZNi
 Fhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636293; x=1744241093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UI2tTP5STXxqQD1JzZfwIJKUWqB2PP+Wr4PkrgGsjzA=;
 b=K4u0NTafVt+oROgtt3/TFVBaN/j3LFoJlPThKuPuQoz9IycbAarNoA+4bkjymu7QDj
 ke4yTtSddqibqlOwoVjbs6Hzdx/VOy03VTD7PZcaPnlh69k0wkvgXp6UIra4RYDfmYn6
 2C1p6qIn+Sn47wuWs/zFIouLP7DEGU0/Morw6+5NuF4mf9ozxkQo+joBk0WsLILLWKxu
 GpZ0Tl8TBo9cGckQDCBwIcsVHeEXsveTywCq7Sh9SImA83SirCrcPxrvgeYgJYENTGu+
 KBj9Vqvr2sqR025CKbPqUGcpPamhSFVYOpAxcau/FVAWduCCeVMzx85hGAoQffntW71O
 7bgw==
X-Gm-Message-State: AOJu0YyGZCorvUSRbcHuGFpQ+FT4PQLiC/6Ql9aV8gN5iFuuUCana9kL
 MK6YLD4ih0WMyGD7dhGVcJOBi055XCNgXdXUmQBXBtzCuDOdO79oZtrMlm4rQ4OOZUDfsrSKn+l
 S
X-Gm-Gg: ASbGncu1S0sz5WqV+4GS5Bq/pp+sfVFbbboQQu3MMZxHV7OAvwZ6yDwQFTbVZy1Xz/P
 /hVVQwTgcL3wPW6QYkdnSGITE+wBibMbvHOGvqLrYCxt9GsRVaM8eCJBIq4n8JXTSsiOtyftr+0
 h/dygx3V4lF6PzdKs1svw4QJOXMwr+3EPC35n+DC44JxVOATIBP0lurFFUC/LRJdq8wTxkls12o
 CkrXz6lh14cslHwHv72YyldFAPxJixq5LiT03lu+MPF+pVhTTjjkvzvpY9jFJB7NoWZR1skwCRI
 UOIyt1EMOzhw08l6vp5cTGGYAI6KVRu1YdLB6I4mT0J6qAGlqjy/+vTZP0i7ng48H5zHfJTTO0U
 HBViTtc82NWgBo1LZvA==
X-Google-Smtp-Source: AGHT+IFy7GfIveDJ/Y25ws4vbM3edz0FCjUZJt6ikGE1YsEB3f7PWl9vkx4KiXTAkLTm2Pm4BwCBUg==
X-Received: by 2002:a05:6214:dab:b0:6e8:f88f:b96b with SMTP id
 6a1803df08f44-6eed5f616e6mr321011006d6.9.1743636292866; 
 Wed, 02 Apr 2025 16:24:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH v12 04/10] examples: remove term sanity
Date: Wed,  2 Apr 2025 16:23:14 -0700
Message-ID: <20250402232441.440346-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
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

Do not use non-inclusive terms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ipsec-secgw/event_helper.c | 2 +-
 examples/ipv4_multicast/main.c      | 2 +-
 examples/qos_sched/args.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/examples/ipsec-secgw/event_helper.c b/examples/ipsec-secgw/event_helper.c
index fc9fa1b000..b2f387e2c2 100644
--- a/examples/ipsec-secgw/event_helper.c
+++ b/examples/ipsec-secgw/event_helper.c
@@ -2106,7 +2106,7 @@ eh_launch_worker(struct eh_conf *conf, struct eh_app_worker_params *app_wrkr,
 		goto clean_and_exit;
 	}
 
-	/* Verify sanity of the matched worker */
+	/* Verify validity of the matched worker */
 	if (eh_verify_match_worker(match_wrkr) != 1) {
 		EH_LOG_ERR("Failed to validate the matched worker");
 		goto clean_and_exit;
diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index 1eed645d02..3bfab37012 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -258,7 +258,7 @@ mcast_out_pkt(struct rte_mbuf *pkt, int use_clone)
 	hdr->pkt_len = (uint16_t)(hdr->data_len + pkt->pkt_len);
 	hdr->nb_segs = pkt->nb_segs + 1;
 
-	__rte_mbuf_sanity_check(hdr, 1);
+	__rte_mbuf_verify(hdr, 1);
 	return hdr;
 }
 /* >8 End of mcast_out_kt. */
diff --git a/examples/qos_sched/args.c b/examples/qos_sched/args.c
index 886542b3c1..1e77e8c547 100644
--- a/examples/qos_sched/args.c
+++ b/examples/qos_sched/args.c
@@ -386,7 +386,7 @@ app_parse_args(int argc, char **argv)
 		return -1;
 	}
 
-	/* sanity check for cores assignment */
+	/* check for cores assignment */
 	for(i = 0; i < nb_pfc; i++) {
 		if (qos_conf[i].rx_core >= RTE_MAX_LCORE) {
 			RTE_LOG(ERR, APP, "pfc %u: invalid RX lcore index %u\n", i + 1,
-- 
2.47.2

