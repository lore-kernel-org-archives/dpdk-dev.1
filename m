Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B1C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 17:08:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FA15400D7;
	Thu, 24 Apr 2025 19:08:24 +0200 (CEST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id C5255400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 19:08:22 +0200 (CEST)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb12so1875188a12.1
 for <dev@dpdk.org>; Thu, 24 Apr 2025 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=interfacemasters.com; s=google; t=1745514502; x=1746119302; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tfv/KXF1j/z9mmU7AV6AcIk091WzulksWwel2BW2dws=;
 b=IBTNkYbl7yetXM8/IFpEq5/PqIMjTFIbn95S3GBIu3G8V4q3KvaWVK4V3/VKJSemnH
 kazLf0jqp3w+jtF1mxdU6ZhkfE9H3m9KcWyqo2Q/DtzmP3cCJVDpRGWJs8QRW6NscuHN
 jxulMZ4rl6/ZQSgHL+KOFF1A9OZG9PIX2sLo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745514502; x=1746119302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tfv/KXF1j/z9mmU7AV6AcIk091WzulksWwel2BW2dws=;
 b=Q2O7TBfcVsGmTePHl5EBZcz/B14Xib0dniFFRU7tWI7SikDjz2RzG9rTe8+Rc63Kiq
 a14TY/BrtpyyxWSP3CH2WjiA/CSkt2DwJni3xZbglnvx2PR3MJrDsA391wsw0aNaWElM
 CWAIFJ431scE/1aONUnNpGOadW3B7y8J/MsKoxcZZ5yoz59Kx6QJKOfH7BuKGKcawl6i
 IlYlGWwK2IXhh0UmJE+BOWOGJxPXI6LpccBEuJXU/z01DWCtkrTWiHlJbPr91qxamsJR
 w6SFOw7SFlxOcabi81L7QeYDeR9Gfsz18P/Pg2enr7whqTGtiRE0VOZfrlzJfuU2Y0Cr
 Fr/g==
X-Gm-Message-State: AOJu0Yxktcr+D4gHDNxXsfNu5XNZWhu3t6ei5ZJr+nKigBvapj8uAMLU
 EEHaJYPRZH1YSIJx+Nhltz7Hoz24DNoH4eIXPvofg7OkR55/eehAP2bUzqtoJx4=
X-Gm-Gg: ASbGncvgP4VTBdjPK1O38KkPFh4jaL6BFFpWZep8TH1eMd+RX5/2lJx+glZ1U/dwq2l
 J9o4Q8xrXiUGtYLc/LO6MDa69PG4pK8ZJUE5I6gUXVrf7nv/vU8h2Ifh6f1zpzeRBJD3g+3Kkxo
 FonWcOxPpJSMp0xRKKby/epTowuHjiWkXuaOt/TG+ZPWAUThj/lVo0GGa8pK44/NTWYv2Se8s8m
 pKA0rYCQeq7dJDY0awOEsgqpt6XGXfEJPlJ2RYfm6A+7QvF2myopVnHxDgbD8a9rMEof+2alzbt
 fuvwxoUJLAI353SGNjwfetChjMIXHD9hz6j439veqnqpqDsJrWmiM5CDR3qqGOs=
X-Google-Smtp-Source: AGHT+IE+2I/8SXQCOdC64DaP0/walrpr3nzcT+fbOmJYSdkN0MoTkASIqhAGDl/nRmFP5I/wU2BZzQ==
X-Received: by 2002:a17:906:4fca:b0:aca:c864:369a with SMTP id
 a640c23a62f3a-ace6b3a03e9mr34505966b.18.1745514502143; 
 Thu, 24 Apr 2025 10:08:22 -0700 (PDT)
Received: from fedora.. ([194.44.103.175]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace598f6823sm136355266b.79.2025.04.24.10.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 10:08:21 -0700 (PDT)
From: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
To: Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
Subject: [PATCH v2] trace: fix out of bounds write in __rte_trace_mem_get
Date: Thu, 24 Apr 2025 20:08:18 +0300
Message-ID: <20250424170818.23970-1-oleksandrn@interfacemasters.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
References: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
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

Offset should be aligned first before checking if there is free space for
another write.

Bugzilla ID: 1665
Fixes: 032a7e5499a0 ("trace: implement provider payload")

Signed-off-by: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
---
Specified correct "Fixes" commit.

 lib/eal/include/rte_trace_point.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index 8a317d31d2..343e0271b3 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -328,7 +328,7 @@ __rte_trace_mem_get(uint64_t in)
 			return NULL;
 	}
 	/* Check the wrap around case */
-	uint32_t offset = trace->offset;
+	uint32_t offset = RTE_ALIGN_CEIL(trace->offset, __RTE_TRACE_EVENT_HEADER_SZ);
 	if (unlikely((offset + sz) >= trace->len)) {
 		/* Disable the trace event if it in DISCARD mode */
 		if (unlikely(in & __RTE_TRACE_FIELD_ENABLE_DISCARD))
@@ -336,8 +336,6 @@ __rte_trace_mem_get(uint64_t in)

 		offset = 0;
 	}
-	/* Align to event header size */
-	offset = RTE_ALIGN_CEIL(offset, __RTE_TRACE_EVENT_HEADER_SZ);
 	void *mem = RTE_PTR_ADD(&trace->mem[0], offset);
 	offset += sz;
 	trace->offset = offset;
--
2.49.0

