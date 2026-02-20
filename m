Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1D9C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:50:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCD5540B95;
	Fri, 20 Feb 2026 06:49:00 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id AE72D40A67
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:54 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-89577f866d6so22902256d6.0
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566534;
 x=1772171334; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ey8Xsq4IJZS08ChCN8pkumEwQb5D/iCTl6VE8x3Opo=;
 b=q2/4lWgK+0lxbatIRnewxYcpozDQUTKs1sLNHp/j/JJaLJ/GHPZJwJInxNQO7GgYo/
 Mc7vwlpXgYXDOPbd9/SxCanwDCM00CZw+KL1MDUEgB+qG1L/bYdovYV1nju22JF/P7Kc
 xwd04KOyg/5n1qaZkQ9HBPMQsj4lfsd2Z1EnkRY9srxIyQTe2ISI+ySWlTwgzSFlsWfq
 2Hz6NIJWk1PLf8HQ4/Yz5VoEwGJlkpATogbo/LcVOXkqzzMSo4UquC11VktbOOwENleQ
 JW9OfA/tie/JqyATiH8EdBw4NTiDxU66Pl4ja0fdCx3W/qOHRQxfL1CfIm7EhI/i4t4F
 zoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566534; x=1772171334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Ey8Xsq4IJZS08ChCN8pkumEwQb5D/iCTl6VE8x3Opo=;
 b=n+vIkbuL4eNe1emPfVCTSuwXuemUTAHYUNZpjmxvxvaTxEtp4o4j53fOKos8Alr4zT
 JfWgttSbma65YKH/NwQLksTbYDSece7/yaCH/G3uyADzo6DApwwAy1PfdBgfdko4xy3K
 6kUgwbRr5TDDupp5XSsS6rY+HyqUNSAwhLvmiLoX3Fib+u8zy9E3XxQ3TxqqreF+gjAG
 VeuWhd3v6iR/tvZRC+UTxgreJOB3kZQ+pfKCnOvoKz5fE/WrEbefoOzH847ogC4YzvvJ
 KKLWWE591wha3wZC2jW2HxQGsxloqxlVAHa7SK6MRisqDsA7SR1UOTZHrO82KcuAwQ8o
 pR5g==
X-Gm-Message-State: AOJu0Yxt3SefGvZDgncAv+nWNRsxrinLAd9kDlyfJZQoqzN7cEZcNMFW
 CwRWRO2A5Y0Qo30cYh1cSWbR5uq5QFmFq61jbUi0aIvKhneeiDWdSJrK/4rTzfsc5SjOz94zlfD
 4qsV0
X-Gm-Gg: AZuq6aKzxBY/cU8Lf8gRzRCsdcue5itIGtlxwY7yMn8c2zd9aEvaFDQf12wCC54Pxt7
 lQxOGD4mAsho5meZ/YrloFVyMaYw+MAKWWSigxTwh3QARAbHzIyloxT8L72HVJpYD8vfkEw0kXR
 B8x9U0iVvHktuss4w0Aua/Sbod9Q26ENn2d8q2H5pSgfM6Y4Md3uHozkUgZdCn3JlHO1YrhmBMv
 odtkFQfnmdRmmnS9Ys/2PZRM6rfM77w1l5qXnuEk5smcN/Q9vAPDRJDo7JJfjMtw4fODUQvrvWE
 WafiiijDDUU76ViH1bOoJwYYCKWJWk9/nb6uIYwDXuqKjWT0ojPBGXH5RutuqFUB+48mupzYaNE
 01fkVl5eZ1O5vcpI+TKF/VO+8mo6mz5wTPzeLlwUA46+dXbHzwRmW+bs9LhzNq00ElPuh9Dk24V
 zz5JE+Kv8IxLD2ONDnjkinTDLKUE+PXFKWnLm9yZMDWFoHQKRkvyDtMeDOtlFJaQ==
X-Received: by 2002:a05:6214:1308:b0:896:f42f:bf15 with SMTP id
 6a1803df08f44-89971a7118fmr7494146d6.10.1771566534061; 
 Thu, 19 Feb 2026 21:48:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v17 15/23] net/pcap: reject non-Ethernet interfaces
Date: Thu, 19 Feb 2026 21:45:50 -0800
Message-ID: <20260220054834.1632201-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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
index f0c50093f5..6fb21c96bb 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -671,6 +671,17 @@ open_iface_live(const char *iface, pcap_t **pcap)
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

