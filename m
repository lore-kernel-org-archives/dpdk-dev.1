Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BBBCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:37:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E818402ED;
	Thu, 30 Oct 2025 18:37:42 +0100 (CET)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52]) by mails.dpdk.org (Postfix) with ESMTP id BA8824060B
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:37:39 +0100 (CET)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-3d1cf5c2805so1302355fac.2
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761845859;
 x=1762450659; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA8EiWVnhpMp6cbDfPELHixzWAeKYEMozJfdgptVuIU=;
 b=Nsw2OxepSIMapmL1ttcvfmGzsn/6PPqrPgl/0hgWddyPn6XkzAwFOZ7cimvK4cWA+b
 eiXfdrn76S0m482yq1+Gy96nw+eUBaxlhpx30rEk5KobWFN0KiDBZQ/9rsOpkPba4X1L
 uKBPpGngTWYMa0Tw8IdvoOrVvwPB87Sk3sVngRksl0UwsGo9b75odfmXkKO49AS4ANte
 IwKrsnl7ZEOtYGwFqzSIrhrvqnqaykiPt1EhNax2FSVTHca9QXTAbTz1OmVuKGUe55PB
 CZ0iIJW/I2NtmHTPcsIDyK8C4xmjDS9SL7q1y/tMmLiq2VHezFvfkotNHaTfTpm4MNRO
 J/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761845859; x=1762450659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rA8EiWVnhpMp6cbDfPELHixzWAeKYEMozJfdgptVuIU=;
 b=lAMeYMx/9QJ/dcbb9Vi1gYTNEimMCk47Wn5W5JjndlHuX5xyisqFA63gOugKgThZ9z
 aOIdagvc6kmhL52olL+OLQM4hu+ElVC27qUvsc3uSL9Bo208PQR6vuiZ/HzBRNH8OSCB
 pLK9F/u7tkfyrSp+cOyw/Dt6HWlm4O1FrPNOUMlyN4ezBnspdQ7Db9+JEUgdORFxvmmX
 f0Qey+1IUXbjfIBeun6rMy4dFLlMTlKOGHv2tAxWI4FUpDEV6ycwyxOLLFiykal4fbEN
 ybdXafFaaPPYtXHAywedUPSo3qnZlgsODB3syvRwIfSwnrt2gr0C89IX9wpFs3LimU1E
 GJng==
X-Gm-Message-State: AOJu0Yx94b2iviZQU5+rrfVGe6XcO+y62DPSLofNCp4jjPzUymzbb0yO
 9BZzPDN+pL1O0gfrVS3MBpuz7y2wmhBMXCJ9NEFudlldPMck6cbRcbn11K5uok6PGYa3c1Iic1f
 V2ndR
X-Gm-Gg: ASbGncsqFIHNMchrEQfXulCjoBTQIy8CsBiX0w8bg0PsJww+9f1AIpXqUV9KcxdyNkG
 Cy5WFmEi6bh7EmAPqkdT29IYHD/S2eBf67T9md8e/7IOIELYAzFD4IfD3fYeqi4L3QqWAmNfbDy
 rFqqSJZnwCRJvjjUF3ZTn5JVyasA0aujSyJN2T/FlZ0056ufkLSLpz9kYkuJHQ5mW5ipX2eKTxI
 5t/6xktS/0twFBNHN7sCaXhB4QSC3X74RZkP/k/P4RvNNAx2IHLjwhTZC0jGjStYp24BOucd8Le
 V8mNVCs95I1oPHPDfnTnmzH6vuhCJSGw5nIo0edeziQVr9dM693OVVVMKD1fZJfF9FRnBIDX7R6
 tWPwakfj03MhPguntFsWlDJReA63O7CTrfvponMxmnqjFXA8tweBpoWoKu+jt94OQA+sHO0t1is
 LQgtmrFRJXKlAfNxsqUYVY3YP6BgsBavXo1gWz7Yc=
X-Google-Smtp-Source: AGHT+IEbSXIARkHm8dgwnyfL6k1N8KybVVveNvGEhkhvOVvxYVVGv3Pr8+nuh8LGqzquwdnUJEGmKQ==
X-Received: by 2002:a05:6870:a116:b0:3d3:5fd8:a464 with SMTP id
 586e51a60fabf-3dacdb71ebbmr249825fac.35.1761845858917; 
 Thu, 30 Oct 2025 10:37:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e20f1396sm6057278fac.3.2025.10.30.10.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:37:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 2/5] bpf: use rte_pktmbuf_free_bulk
Date: Thu, 30 Oct 2025 10:34:10 -0700
Message-ID: <20251030173732.246435-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030173732.246435-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
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

When rte_pktmbuf_free_bulk is faster because it does single
mempool operation rather than per-packet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_pkt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..087ac0f244 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -177,8 +177,7 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 
 	if (drop != 0) {
 		/* free filtered out mbufs */
-		for (i = 0; i != k; i++)
-			rte_pktmbuf_free(dr[i]);
+		rte_pktmbuf_free_bulk(dr, k);
 	} else {
 		/* copy filtered out mbufs beyond good ones */
 		for (i = 0; i != k; i++)
-- 
2.51.0

