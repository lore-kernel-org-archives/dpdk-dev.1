Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD596D0E6F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 14:46:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BA9E40A84;
	Tue, 25 Nov 2025 15:46:17 +0100 (CET)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6493D402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 15:46:15 +0100 (CET)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so6334566b3a.1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 06:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764081974;
 x=1764686774; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3qcuK7XfmQ4m0UbRzVgBJGFmt1uE+eVlH1l1lQfXIus=;
 b=gJ92+gf+NKRZlP5UNZmBnPhZJDC+f2P+E4u8uIXr+ceKTWBwfeGqG+zjlZRzuuB3er
 QiZDYr5nSS3KsFFz/m0ZQ2JLXHaCMkO5Aq3P297Ec5tvntIrXRQQVS2yU6Plmojxu12g
 +rtmZJRd4vy301GwEsyFvTlaeLma/COTZ3PuXhyIVrgz9yeErNoST/pyRVxUecqY9VLY
 mO0Nw30JWLCM3hB3xvXWCxdUqmt0NPbBcXY4Wum/hgX2ReHaabhqIxpTX8MLXzVDUh9P
 OkkVbhHEnLaprnEaLc75s28wBGXrQsssJphMOelo5xNYz2shI87Cj2rQ7Zdur3HEcmzg
 5bSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764081974; x=1764686774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qcuK7XfmQ4m0UbRzVgBJGFmt1uE+eVlH1l1lQfXIus=;
 b=Qaxs+yrwC07AzWLRF1AipX9DT1g/7LgBcBwabnxI5C/Hz3dAccYrybvifhaQmd90i7
 I9cHRZXNlfmo+Qm1vBxqv0yLL5ufbhux/SKxzwJqOnTsAK0DV2GkYtFXTn/+Q9VMWEZP
 k/scoeetgI5N5a4Am+4dtF3J9fdEevVUgHhDvJ8nPqJ4mVzMYvOjxZZ223u9Mzskr63o
 qdaL4SMRQAt8K8wH5O66HvNuTZI2n96YvQEn81oiRylhJVPlIr3iRhlJCRQYIMVxAofW
 hnEK4pBE6XXDx/nx0uqnl/msIambB6sTUDhRMbXXouheBOBd7qWPtfoPDb1Wg0VT0cRr
 yCRg==
X-Gm-Message-State: AOJu0Yy4QdEOmNBm5W7ur+oHP4DWBszoUyxXTA7+JdqBxFGVucEB+tmH
 1eq4NUqvCRs985xWXIu7+DCm2MfCKldE6fcvSrkIbywmV/Aopvvk62RGHlQW0M0nRZKU6b/eXTL
 Zx/Ms
X-Gm-Gg: ASbGncv/xJSq8oTLDUQi4jCGwG6yXQWKjnsKRq1+Sy+bm0nWa69KkSuWqR0P+YiKrFB
 ed8EGvO70K/wwUg4vdqEpi09RyLfHuIVHDfuazNK7guJCrRDU7NpYc2BQRUNh78jYsNdDKvzCX4
 MkS801qFKUq3WMvRUfELxtSv9fhUIV0DLqAotEGG/RFN8xBXsD8aR1ajxGNgPKjj4H7JGjIfeyx
 IV5IMuk4LDAddJ/rMt4EFhcF2ZO9t4OLRSiTomsYwNbJ2k42oZzkuBRDPus0LwFOkapF37+ORXa
 Zt5uJ6HIOwAmQHG56Q6e6qc1VYdbbljLkciqAfrGRINrKnaZmnCawvVo01HNSwwET0PIXWbLdw8
 +dVwYZP2UkHNEeriip9tw398oX7lHCHlBdtUn93jMfgS3BDUPQXJ0835Ua1hKV+FedaDpjf1IEX
 khxtd+ZFC/y5//bAzNioVrF+ivJC2xOiiyk8z9LqsGezv/4bdPvA==
X-Google-Smtp-Source: AGHT+IFGI7gdR7kngg6xxZmbjkpR6y++osx46zuPCZrgPXiaP1YFPFTzTvcR/+H+4PNwl5c161XM+g==
X-Received: by 2002:a05:701b:2203:b0:11b:a3a7:65be with SMTP id
 a92af1059eb24-11c9d715238mr7005684c88.16.1764081974275; 
 Tue, 25 Nov 2025 06:46:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e5674csm82594011c88.8.2025.11.25.06.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:46:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>
Subject: [PATCH] bus/fslmc: fix warning in device scan
Date: Tue, 25 Nov 2025 06:46:10 -0800
Message-ID: <20251125144610.37661-1-stephen@networkplumber.org>
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

With latest glibc (Fedora Rawhide):
../drivers/bus/fslmc/fslmc_bus.c: In function ‘rte_fslmc_parse’:
../drivers/bus/fslmc/fslmc_bus.c:298:15: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   298 |         t_ptr = strchr(sep, '.');
       |               ^
Fixes: e67a61614d0b ("bus/fslmc: support device iteration")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/fslmc/fslmc_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 4529ec5085..abdb0ad50d 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -242,7 +242,7 @@ static int
 rte_fslmc_parse(const char *name, void *addr)
 {
 	uint16_t dev_id;
-	char *t_ptr;
+	const char *t_ptr;
 	const char *sep;
 	uint8_t sep_exists = 0;
 	int ret = -1;
-- 
2.51.0

