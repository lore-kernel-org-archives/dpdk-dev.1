Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC32F43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:50:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4505240A84;
	Wed, 15 Apr 2026 16:48:30 +0200 (CEST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by mails.dpdk.org (Postfix) with ESMTP id B24494066C
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:28 +0200 (CEST)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-47018d341f8so4506966b6e.3
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264508;
 x=1776869308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8QDs6V+fwlf3ZfEYZI5tD0dAd1VWWkV/caeDmdp1XU=;
 b=d9aE0y3GD/bzlo4ehwQ/7hWTitmOFs3md1Bno1HJ8qRSNnxA3eMYG/XHEp+c8w3amu
 oc6izXVscUhM3aTswjPdHLONUK41kpd5F12Gw1J5s5Wy5UFr/PTz2CqCcp5TYP++W0lo
 xf5VFCJaVS9u+3Jszhbd56IIDq5bKB68NsqBPHGDawX77FgXdfX2CCFnEQq+iyJCsqCL
 YpkrK+jJYSYRjbB48oieGmbY0zawo5VcEwekX0qbqj6wfquc0ALbRnbbMFyhU/dwdybe
 Y38uMvxxFCff8t6gR+NHjHPjE7onVJaweZ8e5CGcskGCewNpBLp28ee7Yv8wbo0rHgVt
 WFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264508; x=1776869308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n8QDs6V+fwlf3ZfEYZI5tD0dAd1VWWkV/caeDmdp1XU=;
 b=l450cvaHtIUDpAws2k1NUv2VK3waAvjDfIKIOgTDitCTnJZ30Bu+Fz18trKHotUgDm
 XpMm5HogfusA077kypXroVnq/fZgVNm5Ufn5XkzNEBUsERWTmA5gyH+N8zGHD3MuLRIh
 BpFQOA/VgV7xufrEUnjFdNYoONylr9Jzj0ps8oT2izNeBlCksK03rMZxLzInbyx/k0x/
 pQZXCqXonX6qjzqPs2F3EPlUs6wujoddneHipQogx4vVDb6vNj+2d7Xu1F036kvDCxUP
 LeYjcbWc2/Zn3pkU0Ey/UigOnmaBC1B+m3VftWd8gPIM+4jaj0rSquAMf/cPS46g445S
 xvXQ==
X-Gm-Message-State: AOJu0YwuMqMlcvu98eKpAoa+e9X+OysHu5GlLT1li6l1VtLH2C8jrggZ
 FsqXUTApymZGT/w4AsWAyWIgHIBkntNjrC7aznoehZWJi2Qpm44vOkj3yRWajGXha5L97Ujj3Qb
 u7zm0
X-Gm-Gg: AeBDies3r1Txn6U6Vx1+Ryay5SHFwdi/RhZV3ak35qpjlZtrET1sMZEliz+4e810oEG
 lmDdN2GNLjUIvoCMtxHBxZaoqkNoBGe9didXDTv0AzxJ0wJwf14rcPopP+d9UJ8pO5EMJOGgtAz
 8ZtjFS+/CokkaA4qyNQD2+LkK5iG2pUCjM0obukOX6lNa55ZqvzaoT/7AKrJYD/55Pf2xTQvXyj
 alckwOcXStwNnxCOAKbYd5Rt6gJkA2TwTmt62Zeh5y8VLSjLFnDZhCtur7nb53Xp9Y5W5+47lai
 W92ozACUE0IiRlt02iAY4T2YBaGE7T7f+QdZjrwHjF+kFoFzVDb8MSog23wIF8425KOBebn/VjG
 tvU/ksj6+ldZ0TuFN3zOUfytM/N/ZVwvTg3Xw500wn/o+GdgAf9nth+p1lH7QcZT0DfmiofSGli
 jpWXcKvpW5gh/1Tu6i7pEAxaxNGqQbV2Jbc7t1eIz2JD4=
X-Received: by 2002:a05:6808:1b10:b0:45e:f91f:9730 with SMTP id
 5614622812f47-478a0f1c668mr11142276b6e.51.1776264507979; 
 Wed, 15 Apr 2026 07:48:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v23 16/24] net/pcap: reject non-Ethernet interfaces
Date: Wed, 15 Apr 2026 07:46:05 -0700
Message-ID: <20260415144717.226161-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

