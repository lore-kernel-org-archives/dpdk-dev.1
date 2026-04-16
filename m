Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C39F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5F3340E0A;
	Thu, 16 Apr 2026 20:52:08 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id BE1B840DC9
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:04 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2de831d2b20so4433523eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365524;
 x=1776970324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8QDs6V+fwlf3ZfEYZI5tD0dAd1VWWkV/caeDmdp1XU=;
 b=NBNlp/0BwD77Jsy7ViiqVdkPDdFnXXkCoY6mS6XvthbZA/NhvF0hLcVTmshNGOTrFJ
 B/5oswwYB1YFxlD6jhQEk2aujysTDJbE2VPZgbb0HzO2ASm+QyM/9JtIkqDu531BgiGg
 2n6c7FJEVgtTerQtH2yiRSdNkRFg8EsJVk5QaAYZqjilW4moP3w/7NVG2j+aQTK9CEx5
 lZag0SxTdknZI2fLir2Ubv6l0D1YyVTY+5CmePCKMTx7G62tNYIrPr2Zp+LaWelbbHeH
 T3lHsDZZA/y41f8RuIzrUWrXYzJSPHuo/PFoA3cey75EpBIdTYsSg/jXYZyHdADPYV2x
 pH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365524; x=1776970324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n8QDs6V+fwlf3ZfEYZI5tD0dAd1VWWkV/caeDmdp1XU=;
 b=kWHU+IrfGLngBxlj8K0PI+Ceib6j1p2xqHMlYN1pC0hQYNO31m5THHLiJ1i6QKHOVx
 0Lq7leb/oK+TPXFgmoz4B9rJ51eWSK5dj7Jqg/5T4DKGoRi423BitNO2lNAmh60KMsdG
 m10r+Qmyqibr0YFhJQSgsHfaFNIGZyZBxcQVbUKMoTM7zIwwe1EQLAVs8JxCk6E02Meu
 ac1S8UuITyHXPpGWkaMI64dI6EFl2yxMji+OVcsyH/az52dVuGku01drlWVjPtq6IR4p
 2xe0/gLlF5tHYLWomBWDeOH1ZIRJijaKabi3Xc7jC7K1uTokty96Nll/NIRWrcBD7g8Q
 2G7g==
X-Gm-Message-State: AOJu0YyQpVFX4xjjyTvFmPAX5A0SS1ZLNz0EVrlB6DBU/BnEh3N0K5xl
 oyG/WtV0jMlpTuns3+Bef6P/5gqfvGrOVHouWsK6bMsgAsSBlY4Mpl5WS+pAUd8FR5RMAVPTw9z
 mI9ux
X-Gm-Gg: AeBDiesUe92NZvQoRIfephCl+gFiVm8OnfRcc3bZsZAtBQMsFcj1tW9SV7doGMCKSDj
 nH14zywLHYlbNUW8UigU4KiinuDRi6wUjS1u1pEmhu/sMaSnNAGXon38WSb84J634ElgeOl4eAs
 JRASA+syJNFqqmy3abix0W5/BVAISLCvZXX9DoQEXQwrCzCHnouCDy5sTmMWszy9XXtPRjldllZ
 mglnEGH5FffGfHCpkQelMbHW42Oz7RT6/ufzptJiYKsfWnd4pCdRyeuC7T0N3upnDLh4pYgHNY+
 oZ/tbIHweVa1vi5DP3CIA9LATz22kyBpDTjSrbgDUtOEVGhIbabvtna5/rsfXIhyGOzz5RoGcJN
 BFQxbwfR5OSWp4EHzv1G3JSty6lhwPC9f0sY30T2THn4JMxqu7JiiWBujNssxS2EN7mXlBKTtPJ
 UAJsHoKFroUTfeJrMbdd8P9jhcMEUEorihsR5INHlh5H4=
X-Received: by 2002:a05:7301:19ab:b0:2c5:b23e:48a6 with SMTP id
 5a478bee46e88-2e2e5afd067mr287860eec.23.1776365523720; 
 Thu, 16 Apr 2026 11:52:03 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:52:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v24 16/24] net/pcap: reject non-Ethernet interfaces
Date: Thu, 16 Apr 2026 11:48:33 -0700
Message-ID: <20260416185144.1359260-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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
index fbd45c18b3..01b26184e6 100644
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

