Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F7CD73EAA
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:15:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 690D640661;
	Fri, 30 Jan 2026 02:14:33 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 0AC9F40685
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:15 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso13197725e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735654;
 x=1770340454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OYnphkl7l0Fgb3pC6pKzmkYv2U/o4zBQBdonD1IoTw=;
 b=whHT36tuLYoFxyelPLrZLfJJmTgYhN8eQgRLGJnB/Rf936a1XW/IqKag5arEM1aYe9
 uYCfqF0F4MVEG/3j0oXg+zhyNp2MyTqW/JNHWK6r+s4amr5F31djkKZ1vMmpn6yCOktT
 TKB0BuJrRPvO6Pbu9kPJpv+D1RT0ctymTLBasbVaJpXlLlJGraJzOqUn8cMrW4/WNw+d
 J5jCeRv6GLafSNqYG8ash7U5y0s8cPLBXDsMOHQFn4rbLT6ARPR9zy3kdHhRn2PWWaUJ
 us/bOC/bNfDqrMlVy/eJaJdia6Ta5l32pzrUfaqxijcr2owIzwAz5efi+YMO8NNTPAWD
 KLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735655; x=1770340455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6OYnphkl7l0Fgb3pC6pKzmkYv2U/o4zBQBdonD1IoTw=;
 b=atPZLll3yH9AhtlM+J6w1+OGNX5AQOuVSzE1xxuiJ+BOj9w7QizCElO3SMfQ0lIozN
 23t+CHdGZXuGuEu8Jp/EF2zZdXZMbd74MkVS9rmM90AMPkaXD1NaRDSTpkGUtk1xf+wB
 nfRi67JctgI0DT9/cZOXA2iLUmgrtvs4iwYQvMvzKy9Mdg0VTf52vrXuS2h/f/E3IRqu
 WgS4uTiNMVP0LGNZrQUGTTojzgYirYf31ZAMf5cfos68+fgIPK0jShk42HpfEURHMJk8
 oogSEXWpMeUSS6ljPHeT7OsSGvXAV6vKZ43/iW24BV8h1QLRTUS0sh1j/UqU2wxgVbQD
 ZaCA==
X-Gm-Message-State: AOJu0Ywy8GcWmxeq78OdtPbmJpxXuFnFTVPufgfYuuUdXLdrr+VfwzZq
 i3SeiXYuY3qOiRZpGMmn3OmqeI5r/aRQuPYLRgryzNhJTovU7RkLxlWi7jukvClYeiLVphhBPvu
 Tl85Z
X-Gm-Gg: AZuq6aKn/AmOEDam6oP/V8/v+0Sg2AU2GQRJ3uXe2vybbEkY8Lw2rfXUT2Kt8dSEmTA
 qvsxCpcpaWL7ZO25p1DjPRY1jlX2rds9O0MmQYtzOdoW3/ef5rMZ9UlkDXopzlJBDzYFMiYg2Mj
 uyEfiVFNZOIvMw2D4b/PeF1mMMTCfasD/LA3Qhgk1vlcaKl5T41Wt0ck0vF2BNcYKODnzSiw4fX
 mIOyjrudMcA870p26LeLpnd8c50/dVaoPJgzH9xr2Tyc+Y8sXACpC8mOTh9mDrNW0bI0JUnD+Uz
 wRslE6ZjeHIy6ChNlBlhoJzFbtZvQoG2kHKDE9IxChWskfNj0RGczzA+lI8KS27/otSMTAke2fq
 oSHlkqmpPo/nw9Nk4KW7/5Hvukc3Ie25Dki7W1H3+VnU/QTY1vRIRoZETMYktGw/4XUpU9BchIM
 P/3lblg9TOIRd8W0LoNnqRgAkRRzL61qhOHX8vHqlYfbhL96ahQw==
X-Received: by 2002:a05:600c:3b96:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-482db49978emr9969645e9.26.1769735654597; 
 Thu, 29 Jan 2026 17:14:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v10 14/19] net/pcap: reject non-Ethernet interfaces
Date: Thu, 29 Jan 2026 17:12:30 -0800
Message-ID: <20260130011344.204233-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

