Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608ACD37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E35940666;
	Fri,  5 Dec 2025 21:16:00 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id E798340653
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:15:58 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so25896205e9.0
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965758;
 x=1765570558; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=fhGZgvujVjdJDAuzpe9ynvW0El9u9+PxB3QmS1pAbay3UHTfffvrhBxz8yXT3T5J1n
 RQT49qSPpllq/um2zWWeukJVlvMqA0+T1DzqmzVjB0MFEeVZWjU3BafhkQo7mlfIMPNk
 J5o/htGnEivALnHJ8THGHJi3d7Y0acfZ0ghnbMH+HuD9CvXcDynR8btk0MVeAY3Xd1kC
 GU+G4R0Jt0i1YPVrSDgw7aI86c5TWgirwkADm92sS9q8x+vUDMjW/BxBukdBgO6nduJM
 ouzYVufiKGGWFP8HxS6ci0kuvOci7vyPP9xeh8jcnzWwHGmOPLrzTyGA3muMWfaRR8X2
 T8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965758; x=1765570558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=McwFTb37h0BHqjoSYIaqoKG8Bo+EFlLCXBUKf3ll+eqrNzmUGRxjnJeC6G7yllYwBe
 tDuV90Ic/l5VlJZMFcosv1x3gMj2jb25YPr6KHLWVHyKvIpTVof8Rx6DqcfXliqmtbb+
 NN162GVTAMnuHJTgzJMq29HT6TyhYxGnIFQJk6jtWLTew1Z4KN2p0kpbTlhi541f/LQS
 CWcVPldFjtGwEac86IFbSulA1QiiEsRTy9lRXH4/bkVJgvOOe4d1zrlahUhc8GWvEdZE
 aGtsWpDrIlgx3Vx6vQGGznPNw6PvaEmvhUtQMqIHplBaV2pmbL3HCsadFpjqei1Td+Gr
 KTsA==
X-Gm-Message-State: AOJu0YzYsi5UlH7fATLy+q6kGQctNOEqMY5KxH9a+zrQaA0p40T117M8
 cpO+1OLpMyo6fDOzYMfdXQD95n7OiOFL30byT3++gYIqN0xGktU5a90mpsNPktL698hsNLtG0xs
 EpV4I
X-Gm-Gg: ASbGncsENUHeS90MFgWWV7/kPu7bJ5VuFtGx1p7sR6Rpl/r/RXUOKTXH79oQbyrWqWd
 /cGlzGDAcz+50BtmE9CR+n3dbw4VfLwdGkJL8sHjrHYmwAB+py8jm8f3PuzydD2yweG58UHEIc+
 Kn2J2D5SyQnWUxCAA6mZM5hhqG7jZe1pHYnjJ6Y9h3Wt486HgCw0QwiSQ9QAl4NqWxBqCsi+fhu
 SAdiV7SJ9QS8x+tR7lY6Ba9TfwQnqz0in25RpDqC8al+4X/5fkVBUGORA8RWRnm1qOJlTmjUnBX
 8R66WKl05Ms8w5k5RLEHQYR9YVnwD139RFmmyeRiLOucKFJs7r2A5uXU/hGqkvVw3jj46wVbMcJ
 jaTWO3HuAWbgZS0R3oYA+gHhtVuehMRbB9oHHsur2ai1iio8dsAwAbuLbQIlvp/p0uEDfoi4Xbr
 ZUZJLxNcXaeMDtAZ+iImNMS1n5AU1yokXa5Au5VtZx21HS03to9Q==
X-Google-Smtp-Source: AGHT+IG+REFDihbf0LsOhClAPOaFpnho7pBAwT4qpvRy5MV3i4W3KHJYyIHhbDIErIr6g7ljdrmeYw==
X-Received: by 2002:a05:600c:4f54:b0:477:b642:9dbf with SMTP id
 5b1f17b1804b1-47939e48e88mr4522435e9.32.1764965758532; 
 Fri, 05 Dec 2025 12:15:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:15:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 08/16] eal: avoid format overflow when handling addresses
Date: Fri,  5 Dec 2025 12:11:37 -0800
Message-ID: <20251205201537.251131-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..2633857db5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,7 +1153,7 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
+#define ADDR_STR			20	/* 16 bytes 64 bit + 0x */
 
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
-- 
2.51.0

