Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD61CD1171A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:27:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E68824067A;
	Tue,  2 Dec 2025 18:26:42 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id EEC5B40663
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:40 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8b2da83f721so4112885a.1
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696400;
 x=1765301200; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/I3ThTGCZBmL7Op+6ZMEhT9G3EbDnB67mK8XQEbO/s=;
 b=HvdxfDRP+DexPhvbOpVE+fGThscPPPA5cZA6CfCWhD2qkapML3K+P6zTmf2G4o0+Eq
 AQRuAOq6t5wSBxkrCj/9uGtwnXoE/HjgiBTQZeWx7c6i4wRwqdvO2zRhzi2ARr3lDb2u
 A+hVInh+MMl/imc/G/TZ3qJxpcbStd0wZb3a3DSj1EAKUbc9kX/BtybmDzL9eTu3NUgw
 EWyFr8xq7twzwGB2XJnYWkiS67AZMEiz0Yq5qJwmmsBg6n3AbJb4mQbFV7l34qQEJ1Ff
 MpHKWaUhI1eLuIh8iqvXtWsd1YqQ6NjvITdTa/HULGpGfDX8V34JMklcFQTU+Z5JvE91
 23kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696400; x=1765301200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v/I3ThTGCZBmL7Op+6ZMEhT9G3EbDnB67mK8XQEbO/s=;
 b=wBBuOuyk5WgSnC7Xggxpm6mGgqslCSvD+j6LlF9mLHYLXvL+gaxsC/quPS53+edHei
 RW4uWrs1T6pXmzQh/TegA6HqUtu5j5L0m4vxi5/4PPcEr2rihv2REP/7rYkUFuguyoZk
 sBzYB+NHxLIGIRSnbzqT6EgH01Wqb9s/xYOls7cQqSKeZiIQoYvMDTuA0KD9Ig/POPMZ
 EeDU5qg5VDhl+v9YbXgzZCfuuzXpdxJ6r/SIxSNqrSIvr3Ig/ZL4hCBVaja11VZkeEJ4
 BbGL1fZHVrCYZLLg6I3yETA+J0CphM/OStx9NBlLVNL+8jwBN4vdJ2S2Hc257Y5GDQY3
 toUw==
X-Gm-Message-State: AOJu0YzQzga9LT01nxU55mkBpzotqe8aFO/cKYhWMFKTlUPXQDvvfJKu
 XUOWqf5Enbu9/QmWm/Hp/I9w9PE13CQ9UJF7gKQRF2Gc+Lq2/XLb6YlQKdnqImVgiCKbqIHAEdL
 soqM9
X-Gm-Gg: ASbGncuKT8/uW0Sk+FUxPkO605X3ML/y8ixUiinLT7HgStH1jQT7KKs2lQVPAd2BfXl
 ZT4TL0BhZeAdiu5UjBKtpENuoK8n7v4/oSyTuO9ENZJ/BjPurlFougnPXp6KQGM29CRGdbIQcbL
 B6N9FyD90oVFq2PjO6kttficP42LlA9UbFKhkCU8gNe8k4Jh45tLnTiKNi1p4cRR4YxCEramRUh
 6VHUECl0J3bOKt3dJsA4XLR8bnXLlwRggIH3XJ998G81rV5l+dAS/kgBtBqidO/ZIy1NKRVAbdl
 tp/AENM2zSqA1wO0othCy3G3AgwGaoSEJmDLNiH2aE5ugiIZvsQMG4IBTCMd3KUmpo4rkonQ2aH
 Y5aM9tIbrrusC/2RBtxIW8+8k5ltXoWffGmKvfKEsnc9Cj8tZkpNpOUeFjHT/RfLfqueN7EbJ4C
 9Dh4XrVjQgCoJmnv4n87Vs9411dTHjJDw+zNgtYtmo3Vk9axwzHA==
X-Google-Smtp-Source: AGHT+IFwHqA0OXp4cGKwMPJj/eJG0U7epylfSn4GEAftNvBtR0UMPCdpSeMzrBKcxCZzRWrVC0OrfQ==
X-Received: by 2002:a05:620a:459e:b0:8ac:70cd:8727 with SMTP id
 af79cd13be357-8b5ac067f41mr546773785a.11.1764696400069; 
 Tue, 02 Dec 2025 09:26:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 7/8] eal: add check for sysfs path overflow
Date: Tue,  2 Dec 2025 09:24:33 -0800
Message-ID: <20251202172626.283094-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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

It shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

