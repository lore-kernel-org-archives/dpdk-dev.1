Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D8606A33E
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o44+26XC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC2C940395;
	Tue, 24 Nov 2026 19:06:01 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mails.dpdk.org (Postfix) with ESMTPS id BE82140693
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:06:00 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso34814905e9.1
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543560; x=1796148360; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6zYvkqVrVMG9nxu+3OL2fpFWTqGT3YE/3HTUO3XWqZE=;
 b=o44+26XCuBZ5ZEBoL0hvfgpDDLGsmYkS9tbRvM9JD5ljKkQGmz7y1tP6IkoW1YpyIs
 rxg7MNaKvW9i8UBhGTbeBCIs9tz0u0HUGFgLw/rSR2lNZVCdhZgYsBvo7K6QEvajPg2o
 l4lzRTkylhZq/pU+WOMiluYB34q8d9eQgadscyANDCCBfanE0EmbPcxPaIVR4q5x5Ya5
 e14GpOLSoFpfkwoxOgcJAIq7KLy0ACRRLUYYcxVlmF9lLtErxV5+MfpuZqRl1K2Y/MTz
 AJPQ3Q1qv+AnyQ0zRW3rZVrlRbj6BicSR1lwtCB1vCzsJ0MxsZ2Hu1CET3pyJ0wOE3uE
 +c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543560; x=1796148360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6zYvkqVrVMG9nxu+3OL2fpFWTqGT3YE/3HTUO3XWqZE=;
 b=w+5XTNzlRyLVayMpDHK30xiPKPj3dvc0Z3Iu0ZIqk8mDbS+Lpi1P0PzpyRHdtzUpSH
 V89ZllSnF0HXyEtdUHMN4PG0+udsaVxQPWMFAPYz8xb5y7LnmM5jFhMaqkWCcBOIj6hE
 OShvpQcA+m7i2rIpdWIlDHdgaVAXT4ApHYlnuMESOfSD1w2AG2QDKSobwwFVKJeNKIrd
 bXv43qWLqvMlsyNw/ZpbXR5vC3+oUJYtX8KF0xxwH22zXlgCm7U4ChceJtTKtSvVsheU
 QWE6zkZ1ktluj/OGQ2S3m5QnSKzikJx5gFdOhGWVutJ4NdtBY7CIff92n0IFnxuxHWRi
 k7XQ==
X-Gm-Message-State: APuU4Z9sWdnGIPUyLPylEGRFSHxYNGxqr83KrZ1GKgl1RRuwa8Pr2v1n
 oJ4gUGoIr3hgDonAZ8SLq8rUI4f6Es1sbTZs8L4uqeMJ9r1pPeA9Eu+G
X-Gm-Gg: AZFdTZdBVFhNqvcQDk2wMC6OJJOZfareiJZldVhszx9Zv2Mx8UE8NB1IjAbYyGI9bhQ
 udl77FO7CBWQqIOk342S7D8KAxrmWb3CVnCzFlIoMy4SGi8ncmoPZVfkh9cMUgP8ftqNNe1e6JM
 VmwuidqxZ1Om/LlVaAsFbMe3d+kF/fm9nxQtJ6DFS906hL6L6DTEJ/610+fKB9ImqRBSGWj079z
 WJznMf806vcogNUWGegOfvuX+9IrV7RUCYRMLfkr5i6jrYVrRcBtboqfKmzzxWl/cBUK6gUKJIs
 p3Z5CcECfHQrlMEkCgg5nZLczR4KhlafOeom2/3Nu6a5qFM1OYKn4b6JY3yjQf4pKpRiS3IwpPP
 lVvsuXkwLJHSCm726/jkMwzYx1Y82xXHVIiDSz7NSORst+Cxn3Ml7zokXm6MuvCc5t0WGWleLAO
 sXyEw8mp+nyIHyQObYDdpXPMWogjzcR+ekVkkud0K6vAeXBrTuhkqkkM5nnf6CkV++15rga/Gv9
 2YvhTNhiQRQmpYWAOyUdy387B+lgNV/AAyeeHc7uo/m2rJ8zaM8pDzEJ80umomnrJlp4YaXccUo
 c6ExeKGH2h8x2Egf+919n0CDSZ8j0YtM3J7wSjbBzGP5CydKOkt6hww2PrDt
X-Received: by 2002:a05:600c:820d:b0:4bb:5de1:e912 with SMTP id
 5b1f17b1804b1-4bb887c3ae7mr309405965e9.1.1795543560177; 
 Tue, 24 Nov 2026 10:06:00 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b8e564e39asm891424f8f.57.2026.11.24.10.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:05:59 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org, rjarry@redhat.com, Maxime Leroy <maxime@leroys.fr>,
 stable@dpdk.org
Subject: [RFC 4/5] app/test-fib: fix byte order of addresses read from file
Date: Tue, 24 Nov 2026 19:04:14 +0100
Message-ID: <20261124180415.1099828-5-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180415.1099828-1-maxime@leroys.fr>
References: <20261124180415.1099828-1-maxime@leroys.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The IPv4 addresses of a lookup file (-t) are parsed with inet_pton()
and kept in network byte order, while the lookup takes them in host
byte order, like the addresses generated by the tool and the routes
read from a file. On a little endian machine every address of the
file is looked up byte-swapped, and a file written with -u is not
read back as it was written.

Convert the IPv4 addresses to host byte order when they are read.

Fixes: 103809d032cd ("app/test-fib: add test application for FIB")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 app/test-fib/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/app/test-fib/main.c b/app/test-fib/main.c
index dd1a6d7297..05f9b9a1c7 100644
--- a/app/test-fib/main.c
+++ b/app/test-fib/main.c
@@ -525,6 +525,7 @@ parse_lookup(FILE *f, int af)
 {
 	int ret, i = 0;
 	uint8_t *tbl = (uint8_t *)config.lookup_tbl;
+	uint32_t *tbl4 = config.lookup_tbl;
 	int step = (af == AF_INET) ? 4 : 16;
 	char *s;
 
@@ -535,6 +536,8 @@ parse_lookup(FILE *f, int af)
 		ret = inet_pton(af, s, &tbl[i]);
 		if (ret != 1)
 			return -EINVAL;
+		if (af == AF_INET)
+			tbl4[i / step] = rte_be_to_cpu_32(tbl4[i / step]);
 		i += step;
 	}
 	return 0;
-- 
2.43.0

