Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBDCE83820
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:14:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11CAF40648;
	Mon, 16 Feb 2026 19:14:15 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 74DC54042E
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:13 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4376de3f128so2338126f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265653;
 x=1771870453; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJF+3JSbEIhDPiLXRkXTcx5bZ/4ZCzvdkGZq+q4bsL4=;
 b=VNvPdaafE9M4ZEcbU/ymtNe+khnCo+AG2pMwuKtsmrR9bNoLfBuaRZG/Pjmx9LBnGt
 xKjC5zUH4GXexkk0YTLr7u06YC4hesj7Ogv09s4/MDfKwPlgDHRZn+wf1Yg0LRv+xYI1
 yD+udiIkwOsGWcdbNUfsSN9s3Ns/geEXcoaK3E0XoaZCQb4OJSEe6y4CsVQkveCdMW6d
 BuzX0VsvI93JhQCvGkbqi2ztIW0HRY8tr6amW8bINFGNB4yfl8ykA08YkKyJu1C/rbQ6
 ylanhU0G4zuTyd3vCBrBnv9x7B6oaj9jsFo7KaO4Fbed86kJr0Z+WKVYvFzYi9mHYmsa
 xmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265653; x=1771870453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GJF+3JSbEIhDPiLXRkXTcx5bZ/4ZCzvdkGZq+q4bsL4=;
 b=EWDn5TzZwxvoHBNym2iIDkkZ1iCjY7YHvu9lfU46UOVtGxMtkPocpRQ4BU9rfYx6RH
 QgD9cFQ2YB0qZ+ErUEvB1CkHZFKe8R103elZsObim37hawDWmaYRoh0BnMS24q1pUNQf
 RO/0tDgjngBk8xmlaxiFQltmDLEgJfHaNZTa1xxMbSScARxOBWzh1MQPMmhwPf2sU1R6
 m65VQ6xWSVT7wYeJ/p92ruRNEKbmKAhrshbg4MKxsAfSXoluRzn2PdFe4XAURxPz1y1i
 i4GfXzWgLgqqUOp+QUkDEvYdmOOikrEE20E3NA+GFK/P8lwm0U8CS5QCSsJPzOn+nkVt
 SWLg==
X-Gm-Message-State: AOJu0YzrFm4RUwMwHIAAxhuYRiyim/HqTp1L3ke8Y6AyBFgZ07Lvazjl
 Bj34q/zXowEKA71+U9ZUvPuidmS0J9bZovjruQhg1H8sndsZ4RsWs5SqA5L3FVa+tHDDL3RLzLw
 8GLy6Ahg=
X-Gm-Gg: AZuq6aJFxEMV/QRPn8vAmf1PXfc3k59uAzyTlCM4Se0MJjky939rHEZPbMEV6aRTA6i
 WF4cr8USJCEEVLX4UAj4K0xNvE1zNizoJR+uhSPSeza/VxlvNRWUz4fCKEyW6oK4eXS8HQZFV5a
 RoYN1IPKlL/W0xUVnBsHvgE6EZZ4WDKFOkL4wjVCLGRZ8sxm1THclYEM9Bosna1TAprA+gO0UZf
 psjnr0yLtQ5mRApJ/Pmi3j0ATmeY+apDmoy7juIR5x7EvQ48JN0+yJAnxVLB5fH/of3yqYbg9om
 2qj6m2myas6z+8X7TmPGvtmWgg7xh3TZhb38jVZTHcuhL3X2pi5VpQ2flWpa6j/cdzmbPeJvQfz
 ZnquU/c3TnAa3p79rNxstGmT8uJOVcV6kx/3NHlxoBdMM9J9SIpVOVM/zotR4VUVnaV2k+t6zzB
 NUnOeHbCZMmNIwDYHEsQG2vwp6ROjZW+0RF3OQEsi2AfdXjX4EHkVfkHTtGr+q3w==
X-Received: by 2002:a05:6000:1ac6:b0:437:678a:5924 with SMTP id
 ffacd0b85a97d-4379db98627mr17724482f8f.32.1771265652918; 
 Mon, 16 Feb 2026 10:14:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 01/21] maintainers: update for pcap driver
Date: Mon, 16 Feb 2026 10:11:56 -0800
Message-ID: <20260216181407.428877-2-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b2f1ed2ba..93ac176573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

