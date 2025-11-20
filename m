Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9F8CF9C57
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E21B40431;
	Thu, 20 Nov 2025 17:57:23 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 10DBA402D3
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:22 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-299d40b0845so17830385ad.3
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657841;
 x=1764262641; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1iAFFVvPz1aV6/Ny15xboN43D8m7FYGpAsMXGmQbcA=;
 b=I5uuq+I80lPE3yt4DRQWwpUfp5tEh9pWRKMTaql3v/jtQ+7x9O7XTUHAPrAgvUmVZ+
 A+BiXOw/8tk6VqTF6u+s7/JpVYTXUokVQAKY6wTs2GX8jkuyuJxJUY9yqpkbIXMzFUWT
 DZE4nczL6gl4pn/kBFSe7Nr3oiBWyvEDYansnMNRoUyeDvHeDCA7632q/3tlzTBIHpUs
 4wjmzua6PIcirgL31Y0yychU1yk2jFbCbdGmTmkFOAHnjJkWMEFyc4BgQTB5JGLpbz2Y
 3pMz8PJSe1Y3dPrvgT/35HQQBmdPOm35chlQdzPKrUI/nv39uMKFr5GofFiFOZmLQX+l
 yNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657841; x=1764262641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n1iAFFVvPz1aV6/Ny15xboN43D8m7FYGpAsMXGmQbcA=;
 b=p1fTOVqIsq6IpTil8WD52EyQ6SmcuF1BgFiJxm8cjdkz4u1MGaHaECkA410+JIjlAQ
 LPHonJslOdIye4qqM7sZKnWcBa10lMoMEaXSZ1Lw3OS7RRuiay3D4Ra79dNEyFoHm0kL
 7KLVX/cQqaXG19QbaW998bTuByBhBVI9xU7SDW9g2voan3QBFsBQ1t15JkzsVw5a0sH/
 OfoK2c71RtBmxsv9+wB/YLSVBJtayQ3NRz4dHzZB8bkzLxd8cCbi6+Q2rmx1+LaPGmJy
 rcqXRk4Btn/gaU3Vs5U0xGuPd/rckMTYQ90tKSlKvnzcB+k90l50ZgEE6ObB8BilhDUi
 lbrw==
X-Gm-Message-State: AOJu0YyF9KpfiyAXBrD43jIE6Te/2jxrxwFB9TN4ZaSrT59q8L4zXI9j
 o3CtHdyaTMe2Zz33+FxcotHq12aRJtKQvtZwHa9KAZJucge4QZ4e6u08d1Z19wecFdpHYFkf4zY
 LRw6k
X-Gm-Gg: ASbGncu1h/gXCAEa/I1p1Neta8jCJvf3+awNeqo6bqPGewApHJ11qR0Lz4uMM6c8Agx
 1+VtZdb+jeTkNzkbturh1hNUnwvuCJzLR3/5YCAe7aX3hbuYwF/vhab4XeiofRoYO7A0HU4F/yq
 VeMADg9+haZeF1ugEzid5ilG8t0ApBY911U3QX4PdyPwofmuNUKD7DdKEAQdWSWwub7sngWny3h
 syFjWu2zwBTuWMrxgLrwBsmtpg3fAcVZ7+FmBsTT8dtL6taZR9mT6rQDido5d1eovY6zUom8JOX
 AoGgknelbJ9nK5arIxIx4ZyBQOEShcNXSZqH1vnFbZksQ8ekKeDkOwANX+6hgNKS4Oc4KxdPFYW
 H3I8IDy96uzIEDRm4H0jywr2eNXkB4KsTVt9JtNjhnJKrGF+2hO+ApF9T620Ia+KAampOBDvUsH
 Afl1Fq1vakGzaCMTXBvuratQsyB/bxONH9s7wCPocPKlTenDNMrA==
X-Google-Smtp-Source: AGHT+IECPAup6LfpJ6nUy6uyS2SkLubaL8CTXa7VZ7zmzoIdKpecvhSLTpZwCUU38iEcB7ADtE0+rg==
X-Received: by 2002:a05:7022:504:b0:11b:9386:7ecf with SMTP id
 a92af1059eb24-11c938a1a74mr1715991c88.44.1763657838117; 
 Thu, 20 Nov 2025 08:57:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 3/8] test: avoid overflowing huge directory path
Date: Thu, 20 Nov 2025 08:55:31 -0800
Message-ID: <20251120165713.120238-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120165713.120238-1-stephen@networkplumber.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
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

Since the tests construct a mulit-part path in huge pages directory,
avoid overflowing the string buffer by limiting the possible
huge page directory.  Can never happen in real life, but compiler
gives warnings about string overflow that it could.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_eal_flags.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index c2e6c00edb..e21029255e 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -172,7 +172,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 	struct dirent *dirent = NULL;
 
 	char hugefile_prefix[PATH_MAX] = {0};
-	char hugedir[PATH_MAX] = {0};
+	char hugedir[PATH_MAX - NAME_MAX] = {0};
 	char line[PATH_MAX] = {0};
 
 	int fd, lck_result, result = 0;
@@ -873,7 +873,7 @@ test_no_huge_flag(void)
 static int
 test_misc_flags(void)
 {
-	char hugepath[PATH_MAX] = {0};
+	char hugepath[PATH_MAX - NAME_MAX] = {0};
 	char hugepath_dir[PATH_MAX] = {0};
 	char hugepath_dir2[PATH_MAX] = {0};
 	char hugepath_dir3[PATH_MAX] = {0};
-- 
2.51.0

