Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA918E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:14:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D95D740B8C;
	Tue,  3 Feb 2026 00:13:19 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 4874F40A6E
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:18 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so4083642f8f.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073998;
 x=1770678798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbGZ5gQLkvY+2ZPwjCvsVR9e+0+Q9iaezulTrdU3IPg=;
 b=m+Jj/mOUUuuL1oeDFOC76asOxQopcBIwUWf9+q0svT+wU6tGoYBm1eYla0YGAT7RJR
 uo12O+SloHd1wyW4NN8IwO0BEQ0CN30wXj+jphDyXGCb6yi4rLmU8G7HQVtmBBoxXCM8
 Be1vaDqUENf2Lk84MsDCMgjMnxL2niUeumnCWsGZOyCtBchKVfTTPKDAJt26BKILskXw
 08fNwYlHBsc82AI2RyQop3UId+lpaZMuV8bH5jfbhMwK9wfugbGPeR1c5BC6f6L0JT+q
 8JTVq4BiQsDBdsYaq0hF7QqcSf7mmwByUDOspiARvAuTF4vVhhueKen+tNCkC3HLrkcM
 FyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073998; x=1770678798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VbGZ5gQLkvY+2ZPwjCvsVR9e+0+Q9iaezulTrdU3IPg=;
 b=Ke6o6IWrHwhsqC///s9UycxAP11hIdoEOjAGyu1odiAIWMstne89hHuRu3BoORzpcU
 Z39aXMFFFgyOAnHia+GJ+hEflK0rO2ZVcRhGbc+bC+RNqxx5Wzp+tC8YV29Xt9lo7Ojh
 peY+fPmhmCjTggPIZFfdnoZi76WPg7B3gTAlEQ6PABFe3S673tb+P1JyGn4uN3cpglAS
 wj2j5S+uh2FSCH5mXTExeZ9HSZuanTPSGLaj1CnCIyIJIJhrpiSjz71d697tF9acK1RZ
 GFNaBc6X/PwpdFRLt9lBftw+Q6cpSF2p9YBpQDrHEh4DJFx8/Hs28INepcNzyTtyUWdj
 /Mmw==
X-Gm-Message-State: AOJu0YxRUP769oBI3HeFvkMZPja0kgfu8T283KpCXsIa8/y578c/pw7Z
 MkAP6UUxp0MP5oQj4RU8v0eXGI5qCT6WaU+s0H9mffWb2VycAD2HfaiKKyr1RKikV8tTPmfZ3U0
 knpLF
X-Gm-Gg: AZuq6aK9jEK+2tObIrfTk2TtmjZ53F6UNtwbwbveQwwHDrEnY9rxMbR9Oaxlp5Dc769
 KcMiV6By1PUjPgQ07mgUGNrzHwqR3ok6yqJz96D1emThR4CHrUYEe+7/gaTkobxuiAJYnCIA0oj
 uTNrhJfMtNdeg7YS3T4yx6v3pN1lr6tZRmJF91+fuTsDiqQgN35rrjaEiHbcrFtwbnULGhAKMox
 vj40oFQnUcwNVsZhK9SRFfoFfOzgh1p5TVxbpSCfTNa8ua0YT8hLL/0SE4dk/I4hsdAalZPbrQz
 zCuucjq+RPzazlSk5rGUKXHlQG9U9jb0HBz4hQX79RYfSoVMOj47PGHU9D+bg5bAYS+q+BORGWx
 Z8l9FmWtw/6L62X7I9CJ5PF/8kVcuiEQCUBOCEflLHlouu4ciZRP+LFrnfJ8CVGfpghl68wRSCl
 RPWnTdlc5VXYEAN+cGZhKbZj7VPxi0sSKUJ2pNdgxp0OAwthNV0Yf4KD46hknS
X-Received: by 2002:a05:6000:26c3:b0:435:91b6:f53 with SMTP id
 ffacd0b85a97d-435f3a6b868mr17156585f8f.8.1770073997921; 
 Mon, 02 Feb 2026 15:13:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v12 14/19] net/pcap: reject non-Ethernet interfaces
Date: Mon,  2 Feb 2026 15:09:17 -0800
Message-ID: <20260202231245.216433-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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
index a17c2a3986..fdec637988 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -603,6 +603,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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

