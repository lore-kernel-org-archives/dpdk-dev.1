Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82031CE8D72
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 18:21:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BABA0410F2;
	Fri, 14 Nov 2025 19:21:41 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1B10D40E34
 for <dev@dpdk.org>; Fri, 14 Nov 2025 19:21:40 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-297dc3e299bso23455305ad.1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763144499;
 x=1763749299; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ik5AV/o0iZhNX/IC+e8skCAbPQW21LRZvHzicZMeepc=;
 b=d9L9S/WF8kaU8CaDR9PCUW0HKabgv4mU2FBLtrbXsaukCOYcEELiZIp3TDiwY5wtY+
 i5LDDHxVzA3Xyyjil0VgoVmJ57x3Q+jU3lGQcra6fD97I2ssfFsZw1C8ve9Fjrhxiqts
 9pdvIieZuEAeMC/NedDBnHEg6dPJAkTjopQiGY3qKYvE0K6MPsHQaxNcnKmm0f7Rw58d
 Rgz76CLbc+0HR0ziOsYit6Pa00rYOyFMC313ZKSqPQ/sAvW9Ox17/XFWcb1IWPhEch8X
 u+NGx8Igqb3crs7kX+B7Gz5Pto8x1xvk0fmO7EjYgHATiGv63w+pwNRH7GNuKr3EEQ50
 yylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763144499; x=1763749299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ik5AV/o0iZhNX/IC+e8skCAbPQW21LRZvHzicZMeepc=;
 b=CGuLLx9ulCxf0Xc6gcxMxn9dSvuzUm7U2j0mv7H+0BO6SpLUxRH0z/oSOGQZpYWuKs
 f9ZEEUFitGxQb89QaNX9QO7DMJxxMrzGDB9Aio+kXNypZeL2vc7li+u4geMWigZVLYy7
 v2hBP6/s/O2A9B5vy5s/nmOty9s0HsYtRw3jzCHwyMgGkmCKcxUTXq8QmXLkKRZ85cy9
 vgEROrRpSi0NdUnZzchOWIOCd+D77bK64JDPD05aNka6GImvcajifZgH27C0uMc2iWMy
 kqmNGRcuddEzcp9pC7UyE83DLtAYr5+h3UC6xjxLc0kplI/J3FdXNW2AFGch8DvvnsKE
 gJDA==
X-Gm-Message-State: AOJu0Yz/kIVNUkv+aHn0PEtFcwk2NImJDQXnF756SffDGdYHgp+Ev0ip
 SWsID0xy8tzFUrR+8glW57BEtMNcHZROJBY6jUTgauKddmnyx1JW58vU9xSuiznP9a9YiFdv0XU
 EB2MQ
X-Gm-Gg: ASbGncv1ebn2Ke145Ygyk5b2qg+jE4ZnNumFqo8RKkw10LL8A/j/FfJ0uXgkzUev2du
 B5b5AB9nxgB90veC8Ne3HhHaTh2OHwC+KxCaJvDjDUmYUzZPnACE33nxe9fEtVRey3YsXrnd8m9
 ou3Swiem85WyibBjo0jENeICOvqWcDnf8XVjCdgOjQdWFWiEmJtGJLZbaEHZzCO2o42nfFYP8lu
 7EG3owebhBN0x4lFPNhP0hAgyR9FsHbAhzPV6adF5aNJxZYYsAcJU5heq6ACDYoTJZdziDvzYxO
 gq75kCVhVJdKfu23cfCGAkUCQLlw9elUmXp/MVOG/fmMrl1mrTnV3pWtw8lRe+ou0+XWcF3K3R9
 qEcgs0YNsHwlDjEXr0/4l+Ex7Q9vw1awqMzRqH/rwI8s3Rj7pC66Qwb/8jGLktjU3ofiRbPptta
 DSk/vSzXgYbuZBlxwUiZ+i7fPvgAi4l5LTeQiFQFAkyQsfAicXRg==
X-Google-Smtp-Source: AGHT+IFfRM5C/bNNHgNpkfax08FMnBbb1mlSlEcRq6eHTcR6M0oGSBIBoRuN9UFwsfZ6QVq8R/79xQ==
X-Received: by 2002:a17:903:3c47:b0:298:35c:c313 with SMTP id
 d9443c01a7336-2986a75f3camr44038225ad.61.1763144499116; 
 Fri, 14 Nov 2025 10:21:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29864b00fc9sm37998265ad.40.2025.11.14.10.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 10:21:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/e1000: add check for filter mask range
Date: Fri, 14 Nov 2025 10:21:31 -0800
Message-ID: <20251114182131.1296580-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Gcc-16 complains about possible reference outside of array
when managing flex filter. This is a false positive because the
filter length can never be that long, but compiler can't detect
that. Add guard rail check to only loop over possible array.

../drivers/net/intel/e1000/igb_ethdev.c:4265:23: note: at offset 152 into destination object of size 176 allocated by ‘rte_zmalloc’
 4265 |         flex_filter = rte_zmalloc("e1000_flex_filter",
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 4266 |                         sizeof(struct e1000_flex_filter), 0);
      |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/intel/e1000/igb_ethdev.c:4280:50: warning: writing 64 bytes into a region of size 0 [-Wstringop-overflow=]
 4280 |                 flex_filter->filter_info.mask[i] = mask;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/e1000/igb_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index f4e2a6442e..66988cd90d 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -4270,7 +4270,8 @@ eth_igb_add_del_flex_filter(struct rte_eth_dev *dev,
 	flex_filter->filter_info.len = filter->len;
 	flex_filter->filter_info.priority = filter->priority;
 	memcpy(flex_filter->filter_info.dwords, filter->bytes, filter->len);
-	for (i = 0; i < RTE_ALIGN(filter->len, CHAR_BIT) / CHAR_BIT; i++) {
+	for (i = 0; i < RTE_ALIGN(filter->len, CHAR_BIT) / CHAR_BIT
+		     && i < E1000_FLEX_FILTERS_MASK_SIZE; i++) {
 		mask = 0;
 		/* reverse bits in flex filter's mask*/
 		for (shift = 0; shift < CHAR_BIT; shift++) {
-- 
2.51.0

