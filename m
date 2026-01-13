Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE832D30CC1
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D4E840613;
	Tue, 13 Jan 2026 21:23:53 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id EB8E040613
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:23:51 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so1329554066b.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335831;
 x=1768940631; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=aEqkytldxpoRDMqcoPPggOP3ihgzDM1Q98XdRJBT+nD2aBzVQfoddlNt1tfptcnX2w
 ln+PpsE/5bDTuOkwLfAvcdympYLy45DelH+DAh6Q7XekOhjYHrGjKLQKM467dqbpYWTx
 e9qyTOb+FbX+LBHOUQOjjnXdzVcmbCcfbeUCVPL0feyHYMKK3xLUPkstR47vSOu13OOB
 MoaEpVre4ekmqFkTGUXX10dzU6AqhqEl0CwYZmm5WQz4aMLRU4Gr3snzb0m14HyGfBzm
 hUyd6CmSf+yVP8gj1DZ9w/hPVL7mnRHKLU157VJUiI0jzROoM84pGHch54I6/ugi0bpC
 wI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335831; x=1768940631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=m+6VYlaGrNLDgSuKauioW03x6rRZjNEj/jABRHfr5E2Pb1N0LZjOVcAtWgwlfMcdbC
 0II7H6CrbnrL3z1AI+4tgnX9FJozqLupwRzBFPmY5gmUbAlhBEYWPTX+OozweZHlQYRn
 smMfinpQuTTDEQWvVv3VSX5H+obBCWvqZBZ47LNb6B/BsR6zR5OqfODCimFIgyMsgs7s
 +NOb26EDlOdzccbif3JRWv/Jjf5iYo58A9jvakTqLWkwNk4OOeEgz0AIIydgZvz20Zur
 9mrckV3UNyMu3RcWBjtvi/zhQBG4o58R4XS1g8LMtyUGLbrtmHr/xygBEb8J2NRx45UU
 QzGQ==
X-Gm-Message-State: AOJu0YwmQtvscM2zFCNBakcKytHTM9RA+1M/9DTcVwIpFLydH/OP15PK
 I8XtZ0La6mtponCAKQGw/NSPU5ww58GtJAH+0aQEsrBNcMczx0221tWQ+w8nE79Osgzlh04BCeq
 h0CSH
X-Gm-Gg: AY/fxX6SMLSMykntHbst8gHntyeebP7q2yAJWUWUtlG9DgYIqOmepRjFiArjZ9i1dmX
 bg9UYaU1Nh6ZOzUVxwPAkJ6+HPjFU0K3J/hheUpsuSQeQqjhif7Bl2k24BZ4Zt7H7i4yjZSpHYE
 mxfNdpF8CwaWEuEO0SXqfNJSmRGN6CDpx5e5aGBDlvCoEfdFJFTAs4502nGdPohn8bR6E5wN+m2
 t3XzCis+2dqqIKk8ytVcUiaMitLwHCtw9vGRSBPYLHrb3sr2/NocZd017chHMGEzouLTdcpCtiS
 5h439wk6Z6o918Dtf+Qnw2AVlbrfd2wS32ZcZX74M8hIIbc4Q1h5lfQc3p5lOB05DcE76Q+mR2X
 4RdItDicS33JTLOUdWT/r5J5lDe7OIpzs2PUuijYI+vzqRMDj+KESu8a4gfCbj6Qy0hZ+I1/soJ
 t/OPU5qj3i0wuUmsyWyN8TCb8NYeuOSDZkn26s2t8dtyDLxn+x9XS+huJw1Ty6
X-Received: by 2002:a17:906:ef0c:b0:b86:edaf:5553 with SMTP id
 a640c23a62f3a-b87612c9380mr32270666b.59.1768335831529; 
 Tue, 13 Jan 2026 12:23:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:23:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v10 09/18] eal: avoid format overflow when handling addresses
Date: Tue, 13 Jan 2026 12:21:48 -0800
Message-ID: <20260113202329.35190-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

