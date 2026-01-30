Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3122E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:36:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6D864067E;
	Fri, 30 Jan 2026 18:35:28 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 58F1940655
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:20 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4806f9e61f9so12640765e9.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794520;
 x=1770399320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OYnphkl7l0Fgb3pC6pKzmkYv2U/o4zBQBdonD1IoTw=;
 b=1nJMYWeowPsRxHljYIUG54UpfnoRcwl++yarIPP5+qmkwxsxdgS3hSG4w1Q9z/SaT7
 D0YglJmTcOrrSxJXlzVRZ+jMcMapcAulUy7zReNb6hNqs2i7lq0SH3Ksmm516fAIEl+W
 PXJ2LSEGXtHAyHBlQRdWZpcjW94ZGw6Vkh42hkE5RqjnWxnQNjNMzQrW6ccLqMbNdlLw
 /PDHyoHdTZV+TlxPhhhoxODwww8mzSd5pxTjy/m9RWus8VG3fl+oOUgPMppW4tBQBL2H
 XkrBVFBw1YMhDHACbiqw2se91Hl/Hp94//lXIxg0iMTkA90SgJMkc0ElCqUlX4rR/wxz
 EpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794520; x=1770399320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6OYnphkl7l0Fgb3pC6pKzmkYv2U/o4zBQBdonD1IoTw=;
 b=DmYsTZjQ/zKggUNSxi910onvIw0zHLedpNdDFy7Xskmgws3gHTmzqmo8wJXD4faWkW
 hn7RIQhs1VR4QK2N88+lYs34tQZzIhCAvHlBySwHXelB2Rycqg7ETMgSOG7d3CfBEd7H
 JNQIeX0fi5JTwxTofIazxEu+dLiDNTUTcG21ejjs307iClf6ldbBI7AbQMEhkTbvZdPS
 USggW82DtyrnVp6xcIBixX+4K6+UCenUGahKQZuXHN2KOfEmz/bnusjWAQXz/m8S1bpQ
 C2rFfqNUjxDwI24FBubw9kJL4SdTLQZR8c425cvo/OL92Ce0OJVk05QF8Mw5y3rZnbr9
 VZcA==
X-Gm-Message-State: AOJu0YxBoLGioxqC6VtpOq00doAe9FA5NzxrGoeqBZGPxdYfcEc7mHTs
 wFlBOaefk5cMXSINg9G18ksfQ0W2MBkqKfivXgeEeBFk8V2O5b5qvoqHIGIu8obWKoBVukohJDx
 BBCvx
X-Gm-Gg: AZuq6aK1dliJsVlgLgxWn7U+Qk4F+SjkYe3oCBG78WZ2Z+at/+QxKKtO8S3we67PRPl
 s+QVkTQ5CKNNWzOT6NeEYkgPpZlJ1ri0hC5gsbxFl1m7g9741FK36ZezWMA523WShJis5f1AIUe
 hkSga1jqmp57sTb35jYLO71McMJVlcm7sV6zWIJYqM0OrKUuUKmfAu4Ixb9aZP7NkqEScr73ZPQ
 5T0cY0CFjJATE78OV2OVmNC315OLA5eX5Rkxco+hNqT7UOwMfZ1eO1n+pGD4uIwYoxo7jqLlltY
 ifo9Zt3enXNKIcZaQuvvTRDSfB5Y79J/mggNHofQsQgrtAPzWCVTXl/TNmCgCcMgqv6tsFrcSDf
 0j1HEeAqJR1im8YBj+oTplpSXdyY1KIQOQGcl7WGZQC0MHwhOtIHbWh2Gf70auzAIDrQrIaiz/k
 qtvwNjJIKWTbhl6l+wPOkmcVxfohdoHd3G58KxOJE6GA3XCtNyfw==
X-Received: by 2002:a05:600c:474d:b0:47e:e952:86ca with SMTP id
 5b1f17b1804b1-482db4486e9mr47779795e9.2.1769794519917; 
 Fri, 30 Jan 2026 09:35:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v11 14/19] net/pcap: reject non-Ethernet interfaces
Date: Fri, 30 Jan 2026 09:33:27 -0800
Message-ID: <20260130173447.14546-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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
index 90bedb6286..f1965449eb 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -578,6 +578,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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
2.51.0

