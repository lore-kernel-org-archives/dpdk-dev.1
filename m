Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48093E83822
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:15:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C818B406A2;
	Mon, 16 Feb 2026 19:14:35 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 1CCED40A73
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:33 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-436e8758b91so2845687f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265673;
 x=1771870473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMEnF4aWKEn4yS5uXlZBT2jDAFSUpS9iYQsfD77ZOic=;
 b=vBKoUK2prLVNNZgYWeYkSqpTiKYNqzrLURpzNCjOoZuKuxmlHo8MtKksjLJB+hxCUc
 5yI4ptOOApxZCwVTZj4Vs3CuNHgNrtRt+XdEzEc3SCbCTRaJfMey8q5qzigGb7nSiHvy
 hzIoDRwg0A2hudIO6xDHAP48S6QJLwRkr3Qo1Eg9CyYzNMZPx6sgOX//EpB8MVBuDvrL
 vWER/HDo2cbfD77DZH8+duKpmgSEQPYvKbJejX1VUiz+HvR/768KH58dGuzcF1qlgJLi
 IGbn70J+J4gAD5FbMH6s2V/aRDbKujFfGDA6BYMq4mdtQpj24JZP9V54+5IK9grhAEzK
 4Sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265673; x=1771870473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eMEnF4aWKEn4yS5uXlZBT2jDAFSUpS9iYQsfD77ZOic=;
 b=WQ9hEYfRiNY16EFHwkAAJgP0TEcAkygrcDSF9g1iUeAZVdcGwSUoCAeUL2wd8UzUfP
 OuVZf8pvDVlt/Lq9kmCu47V9Thm2i4bR1sAMhEaWl5rOdL6xDqSlK5rRY01ed47UWDND
 Q67ZFPzZOMUTyWKanNAM+baodsAV+6gyV27XWAfgEzaUNGlQRj0X33iqUfEFyBYc4WqC
 VJ07lVUNW6G0QztTWDhItLFZivlIrTA4BwCaNe6cgN/He+M5XajhvUjV998nZHMkGozP
 IfdbaVjLh2cAmNADFXDdQU1uE4vGYTD+r1lRinvIWGyQe60wFaD4AEFOSCtRfKe7IEbM
 4oGA==
X-Gm-Message-State: AOJu0YyIqDxGIh364WPwaulPq601jEpR3Hw1BfzvV/XDpndNvoNKB4AQ
 S/fz0cfbZZfcdLVruNdZ9emBeDl/Svd93/ZRkBPqHG2RZYjYRxHEcXY89WiSuJluKEYLHYquNls
 frU1/JN4=
X-Gm-Gg: AZuq6aIKEAWyE/kVx4d2n21Hv1Ey3CUVhYj49WouIB7QJbjwUlKl/bFH1A5tocXG76L
 nmZXNgagnE1oiR0Kranx4Qgb2AZektogIMoWjj6Afrq8qkf38pRvWnirGxFmRmZACA/Rogd8d//
 p4mKgqo9kUkCzkTZ7FIWiECZ4RGd/ZEweonf9A52vd3HS45fwU2TRRrXwzBfcCjET83hN5TM+g+
 GxQsPd4bFl5KbyX4hMjjlwTdn5cpoCrbIxwkSMhdQ6rMRQSdVZxI3X8SmuhG1sSrK/Bm6/gtHNP
 e5kRhXKjhj0yhFB6mooe3mEf4DxjZVtKhS4kDjA7Ilzt023iROF5E5r9YzHlnfa6L3tp4FeSnwC
 Pjr2oDPE8+kh+vBi1b3ssJt3kYEnt2+dotfLJ8cH4VfzFMmzN9xaBdV8EunONK+Y1otMUQRuccv
 KGgT78p0IVum2ameHspB4yD9BfKQrdl/jdzFs5M/5OxPLRZjGwqrCbox2QE1Sbrg==
X-Received: by 2002:a05:6000:24ca:b0:436:19de:3e5 with SMTP id
 ffacd0b85a97d-4379da8fff8mr11719059f8f.0.1771265672593; 
 Mon, 16 Feb 2026 10:14:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v16 14/21] net/pcap: reject non-Ethernet interfaces
Date: Mon, 16 Feb 2026 10:12:09 -0800
Message-ID: <20260216181407.428877-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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
index 79a8c63b72..676b928484 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -668,6 +668,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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

