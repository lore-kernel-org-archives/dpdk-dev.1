Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50D8EA719A
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AA1A40A81;
	Sun, 19 Apr 2026 18:11:28 +0200 (CEST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44]) by mails.dpdk.org (Postfix) with ESMTP id B9EB140A76
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:26 +0200 (CEST)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-423b7100bedso2059042fac.2
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615086;
 x=1777219886; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53bPNBIcKDcH69qpDH8iPvsrSu1tnw+eBfV8DqF7GfI=;
 b=h6JY/B2NDgmwZOxNQdOBQexgt4cnpQhzFH+ojLf7gYnESamNQTQZt2WJV0D/3DPIxj
 zw/Y7iRgBlW0oR5nn43HtpcvqIMTWvXHZIpjKT4Wqv06shL5FZS5ewziVguT+9uSrHFF
 nIaEDptqpccjAI+jDN9O2mYdGfxbQdF9W7yGtwwyzoOpCzQ/gzihu5FfzQXRuyiVkDmv
 MkS8l5rvBQ0/auMQBq1ceVc0XE+kDrzK3VReqFEuKbr5kONBnUNJzewWJF+7+Ec5g4M4
 /UJcYJ4wFPEWkRi93TkkSvmhV0X6IH0n7c7TnFVO1ObJxnBxDbk/zaqkS3p4QS4I4ObN
 ugwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615086; x=1777219886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=53bPNBIcKDcH69qpDH8iPvsrSu1tnw+eBfV8DqF7GfI=;
 b=pHh7NBkiZhUhkPB4uS3XmUH1A2QQaAAjfzu8mvfdcfxpuVXeclt3GcZw5Ylrt4BQGq
 Q6DUCIKwzdqF+XYRmS0cQOMnYVD9s+SS5TVoKlOXK+QoF89kfpQiq347tvLMKe+FHmEq
 +KUcR5ZvQPdsptHA9CXM+yJqoaii7Fe+OwTfHSeHyk1Pi64ROHZ1X/wOfy3Srg50IVtw
 W9auZZMqVP4xeaSylONRCdp/iHL7lbSBzio+5z0889AaIlCFHFF26vixFB1uCvjo/usg
 ROX1UtQEcFvTtJOTMaIikhR4Li5X9lVqo9k2oP5BKzt+uTyvbM2gYAw06GORCFl0q4YB
 JP6Q==
X-Gm-Message-State: AOJu0YwRAarBEOyYO/JRzV7kQC5itmWJ1UIwypCX9XUsUii5oWOf7ihS
 a1pUxBIZxuuJ3MLt4q7xibqfCJi2JcN/njDJ+qK6MIJvr8U/W6gB2nlC47jm9dk1+i1IxK8qu22
 c9SUB
X-Gm-Gg: AeBDiesPUUQP47M4lXYv2kHjLxxZeDFsaZSrJyoOY0nZ1HipesIwrySDILcoUNv4qdT
 15h32ff102p6V37xpZb84LzHzk47ZeiFFG3WRSL4VRjEO24IPk2aiEl79oq1E+HHVagyIhVy/rV
 uVV0z9mxk6t/jnuEGzx8EsK32BsUewmuZWqy0JEhgvgVF9S/GYX+RBsGfJFThzvSmmPRnH/2XZS
 x3r3EgKHW0YsRSWDxVFCw79ndPOA4eVvHzikjVTGGS70+KKwLcuazSHenDNx685PAt0bwViJUNr
 NRD2KaWy2t5FnvZZEkhXASK4+ZpSOJWzuKnYdd+f5oubuBqerI2yVcmH7pY+MhGwDI48uFVPJMi
 Dfix++31AkMT67QwaS1SEZc/8B3YyoKKzRh2jj3f7Zqj3t7yuhgb2goPySs5CKtc9dJu+gIWKTy
 GHcFWCHiGHyOxZYOU/WimE26EqbMB6/YnTLsB6zQW6dpo=
X-Received: by 2002:a05:6820:6ac8:b0:694:852a:28b2 with SMTP id
 006d021491bc7-694852a2ea4mr71365eaf.2.1776615086057; 
 Sun, 19 Apr 2026 09:11:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v25 16/24] net/pcap: reject non-Ethernet interfaces
Date: Sun, 19 Apr 2026 09:09:49 -0700
Message-ID: <20260419161059.205954-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

The pcap PMD sends and receives raw Ethernet frames. If used with
an interface that has a different link type, packets will be malformed.

On FreeBSD and macOS, the loopback interface uses DLT_NULL which expects
a 4-byte address family header instead of an Ethernet header. Sending
Ethernet frames to such interfaces causes kernel warnings like:
  looutput: af=-1 unexpected

Add a check after pcap_activate() to verify the interface uses
DLT_EN10MB (Ethernet) link type and reject others with a clear error.

Fixes: 4c173302c307 ("pcap: add new driver")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 56f88f5b89..91d442504a 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -664,6 +664,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		goto error;
 	}
 
+	/*
+	 * Verify interface supports Ethernet link type.
+	 * Loopback on FreeBSD/macOS uses DLT_NULL which expects a 4-byte
+	 * address family header instead of Ethernet, causing kernel warnings.
+	 */
+	if (pcap_datalink(pc) != DLT_EN10MB) {
+		PMD_LOG(ERR, "%s: not Ethernet (link type %d)",
+			iface, pcap_datalink(pc));
+		goto error;
+	}
+
 	if (pcap_setnonblock(pc, 1, errbuf)) {
 		PMD_LOG(ERR, "Couldn't set non-blocking on %s: %s", iface, errbuf);
 		goto error;
-- 
2.53.0

