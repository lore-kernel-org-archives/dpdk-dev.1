Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD1EECD6EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8082B40A6C;
	Wed, 11 Feb 2026 23:22:03 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 7566040B8C
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:22:01 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4362c635319so2159994f8f.2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848521;
 x=1771453321; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAzJ4RtY2gdXt+eh0K5QjMwb60mtHtAiliOzwgLsemI=;
 b=gPfB7AWsFZIyUwcRrn/oNIrF4pixv2axYXhV5iRLb7L+UFs+Aqr8vQF44YjdzJDtxu
 B/RWIMD4KWvWigzaMJ+tI396VLcKRLy7wE+v+cfkItcIzka4yIQsaiyijhFQWChcpqNb
 VGXHOx5hxctDGkKtGrk6/yRVnmnRLpw+amjC+5KUpLR4r9wTt0bzEsBrnsI1Amz4SpFO
 MznWh2NpmCcwvWQKJNC0U3LrF+2942K4B32kN2PL9sHjp9b1uAjlPtphkI4wgPI1EF7V
 HNHub0Pl+M9WYRp6VCdasj6mrO3tUURaQx0SHiHfXSK7obzkYxOT54iHs+WwHwdU52/y
 miAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848521; x=1771453321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FAzJ4RtY2gdXt+eh0K5QjMwb60mtHtAiliOzwgLsemI=;
 b=AQGXYp1iQ5fMM77xbferSMkhraeFO+UgPRV8XvIJXmH0xB1TcXUgFvGxB2ehAyIZRM
 h47bWmqvM3JbGjSrVDmixKr1oJVyR2b2chlicqoDd+tJuapdvVgXK+KJIohzvpEyphYt
 lK1C2kgNNoWlQQJPV4sb48jLDysQUfPNJajpoYyoJnM1IUBmSKPeokPs0h9OiVVIoU07
 r4olhjv2J0EHU/i3XUlqlEUBuBQGy74LsN8T8WdouiA7SBGj959XKSKarTUnhQdVf5AD
 5v8s7G8sgWuHal8jk33VuQvXmCjjf+2/yQujsRU0nF/YqSOjnpMY/7Wb6QUfcgTIjNbm
 j7Lg==
X-Gm-Message-State: AOJu0YzrPld/AW1LQmq2GOra6e+Oud8LzhcXl+n88BVCW+sxkwIivFNa
 jNzKhnqDS/xD0Q167V0mgZ3F+SHVoazdBT3AguNI7aC/IdMDuYc6UO9h2GXJDKP3y/kPz0JYaku
 HwinY
X-Gm-Gg: AZuq6aKP5XYC7IeRldK1PTl/Vga05zvrYbY1OwyfB1VhRkPCO9hF3mhDF1nSX268CS5
 l6U36erK2psiiVV3beRFSFHs0LfnWQ3xtcLWIfcyWupePoo5gLBeA9VbNGecnfMUiIq/+W5KkHr
 9eYI2aKsF3AHbLocIKTQBgyBdgU3O1AA/HDQWghph0mOr9ohpjzXJul7jqyGfmUNZvFcN/2CqQK
 qrCKpi3A+KMp5IHdZpwY8BA3NBt9rTMtqLIiqyWPapJFDjKLOM6F0P8Mfg5tUL7xZR2AZT2VVEo
 ecIKfkxc2fAY4x0wPGT5j+cHiPTmgIhQwdjNyoyzTQz4w3misIMerybp4ZbJ7ONP+oPP4eyS22g
 v3HbHtEspZVEYy/Hxe+1BAr0rl6fjOU0R4IL+48nddQOnxjgalA62sFST5zOTh+BaZaMrBv+NDH
 xme/GBSE2cMZOHbDsiiLkYifEMiWoUE++nLdAdE/y01W2G3OiAtMc/fhlt6wUL5A==
X-Received: by 2002:a05:6000:310e:b0:437:7168:af5f with SMTP id
 ffacd0b85a97d-4378f1841d4mr297034f8f.49.1770848520983; 
 Wed, 11 Feb 2026 14:22:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:22:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v14 11/18] net/pcap: reject non-Ethernet interfaces
Date: Wed, 11 Feb 2026 13:09:44 -0800
Message-ID: <20260211222130.338797-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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
index 8e12f7cd0e..3522401b5e 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -669,6 +669,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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

