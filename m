Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673B7103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5138140EAB;
	Wed, 25 Mar 2026 03:40:45 +0100 (CET)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 0FE9A40E3E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:42 +0100 (CET)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so4002042eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406441;
 x=1775011241; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NX1pS/PcrBeeucS8iydyCeNpL2nf39oNO3PCw77HldY=;
 b=bVaIUm9QSJ8ku+SFXcK9nvrw+vsW/1WrIcXN6hUpswVTGrhBi76XM4y7e7gvnLCC7p
 Du1VaNNeryveWatR5bnrqebG+wAEbwDxDVnC1JL7vCfsqYbzMEK2wYPtbPBuy9gpgQ8+
 w+Rt+BqgJnJypR8lg928upOcDyIbcDyaL0jfqfYdRxzroE2KHzJ8QOdT9nBLN+wuhhBx
 I1kr9kpjxzWgNWohSLo3eW4jSWPoYUZubIrIHaaRwU4QwFaUEfTDFmtWW6x257GXb9Sb
 CRrZ101e01XhrRlsehs8qm63hzO6hweIVkG8vVmbVxrsdKVSZpyvB5ZFldLDGaA7V2tP
 B8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406441; x=1775011241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NX1pS/PcrBeeucS8iydyCeNpL2nf39oNO3PCw77HldY=;
 b=czNAM7JRMloAvhnZZCEvzqjmjLWWVumvlnw6+veie9Q0u28qxOSlWmd+Lh4k9sKtCe
 pWzabEjRoHQzQM3B43L2AhUtsyLGK6Bg8v/HIWuvWRsXYVLza05es5EOMVBq+ljvkMKQ
 qVqIujT5mbmlPRqyNRgyKoYhKOIUKSbxeTyxr879+IJ7yjNMxYnJZ4tPMhjWotgQdIQj
 zEgGHECvoRM3W0a2y88onvjXBwY92EczawifCW2lSoFhOjVU41guwUtH2W9Saf7LFARN
 oAij2KZjAjdLG0NURyWof9XQUiEsTceED7HXidxfTExzHyw4hDbe/Z2Yy0cmRxPxA/x+
 YCrw==
X-Gm-Message-State: AOJu0Yw5bRLXMjNrE9uyvCtjUCRedgNWWsPi462ioM+Qn9/9BwvDK66n
 9f38J2q7yuLRamTyFyqcbAi2eWjtLMkUc4+de4OQUn8Lp3tNSvqJKShRx6JFQ8rKnqO6pD2uQAi
 hcyjb
X-Gm-Gg: ATEYQzzVHktrtu7UJwyDoNp4VKrw/scgUiFEh2FHb1lQvB263tDdK3huxZEUXwcFnlC
 NYGdh69uQpxCjeB6IAUIl9wPpl+qfYUB/wWBm1GZHnKv6+Mk+7+zdKVAphG2S5gZyiigv3BI4iE
 qQTU7GYzjnR8xYe/+Xl3lavqaoUMzjP1rKXlg0j8oJ15joPsOflA6kjDwvcUSQpHlwiXVUh6pz4
 MZOspjgL7WaxkJZ9tAc6wq4nhHpPRsDOtjST5Qrl0tmk3BDwHolpT0j8lucBkvMzIDFvK/NikxL
 Xh7PtB1BcOeIp91P1D2ABEM8Q63wzp/B/R9gZZxXcX0Q2XTFqNYcvTuj6CjiyekV7owRE2z19tK
 jB/12bcfk4HOJ4A7XWVPipqjsKcmULd03oBHN4j9vMVUFZaPRo2aY4OELszp6MoO53Gnll/XJtk
 YP9mvW9Uo8fBqZkBb07fctfH2eAMVG8rVIO9msnxTMTgc=
X-Received: by 2002:a05:7301:5f09:b0:2c1:2706:b41c with SMTP id
 5a478bee46e88-2c15d2524bamr1041253eec.6.1774406441077; 
 Tue, 24 Mar 2026 19:40:41 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v21 17/25] net/pcap: reject non-Ethernet interfaces
Date: Tue, 24 Mar 2026 19:37:48 -0700
Message-ID: <20260325024018.1275209-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
index 86a7d22cc6..dd640a82c4 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -638,6 +638,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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

