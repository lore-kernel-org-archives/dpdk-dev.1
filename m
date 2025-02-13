Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512C3C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:19:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AE1340696;
	Thu, 13 Feb 2025 23:18:45 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 3B96B40677
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:42 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2fa8ada664fso2284721a91.3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485121;
 x=1740089921; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTtX4AHkbt56cyz6ePjfJ2NXdYZ+Ear04KnwLkajDA0=;
 b=ui4KATQqjthOd6ShqkSSAjJ/moVrnEk+kHs6bbYWWw2yU5kKiNi4e9d+udkfW475J8
 EoKaxDQHvTDiSf8cdAJ4SeE5qqtlUViII1F5arcHprMYltuqE7mTUW8CBdUNWpuTdBic
 fmmf6m4LW0aW9X321HybXX82ErnhnQ4UplmT7j38EGE+IplY81Xip2/4loycZZnXIx7o
 LUfCLQcQRUvxGUPIzxNo3qNKoWrTZQkakh2XQYkMj2OKBDnQABUyG37oo8FKm3erR+DB
 lkisbGkDX/u2aicZ8mY8v8VZmUKIVyFgFmC7HE/UtDCW2fOCJagCARzAs6STyUWk6cz0
 WKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485121; x=1740089921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTtX4AHkbt56cyz6ePjfJ2NXdYZ+Ear04KnwLkajDA0=;
 b=WaofCFy9Ei1FTiCbDtGoWWaIAKwn2BNWINmwVLeZPei4/M04nMlQvXdMG2J2KyMQzp
 oYlYKic+5bgdget73YVJTVbHKCkIpskMjg2mPhvTez4PKOnfQdiRoJy5xKG5tx+YKdk5
 x/me1z4EqGVS3KYLqoaNqwnK/l8h/jHzjs4Mn1y/WUjY6T9Er8yi80FUXXGPHi4V3tuA
 XvwWoag6PGY4oukcZhUCRwcikr15EAM30SYXDP63cB/VqgjhqGao/MnGbbSodZ0TbN0Y
 Pqo6lDB/9rIxe/o7GMzdVqfb2mA/+ss1XP2ZNMhDx4RAiyZ+Mjw3Ti7gpph+Az8wuQt3
 tf0w==
X-Gm-Message-State: AOJu0Yyy/lXNfMM5Obj9GJDoZQ6yhLOrxV43K2OETd1jTBmjiL/UaDbz
 3fiV/7Ab81Sfcwxn0yPaTQ8zu1drY8v/y5p2JRqrYqigQwJx7urhNZaXbEUyzXOFXeZaeOVFHle
 L
X-Gm-Gg: ASbGncsj4O7pAPhS5Cv0K44Qlurfcwdx1WhbL3rsRsmy3JS3MSy291rHMt0pcc99tUs
 9OHQpAd5pcBfoZHWZL6Sd2dFlVD0UPfnQM67hG/Bmb+vxU7KwKXuly+ZGWflnkePj8FpomFvmna
 sBiVCkYKHpiI3z5twpc+0SjAlFG8ZooHmVYIaQfjdySywwHVNB9Xu2Y0ic3ZAgcNjZ0o8MyuwAd
 2tvLYttjee0RlajoVXsbe5xmN26lREconJpVdx0Wc4wOBIsr7xCC7Ka4XJTkMaT/kKZTaK/8DGK
 rDu2mR+U14ksOrjFC79AgSCOsqmYFS3mosUs7jIX/2HuBFhu345IyP3x6zVOb9mKjvw2
X-Google-Smtp-Source: AGHT+IGGvmGNN267d7rVUdQsw3aCkxG3LAezro+VNXH5fOVJl3Lg4SoWcln4uJhhvyF6u/w8+pNnVw==
X-Received: by 2002:a17:90b:4d0f:b0:2ee:ad18:b30d with SMTP id
 98e67ed59e1d1-2fbf5bb2fe4mr11731041a91.6.1739485121442; 
 Thu, 13 Feb 2025 14:18:41 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 08/11] test: remove unneeded memset
Date: Thu, 13 Feb 2025 14:16:21 -0800
Message-ID: <20250213221819.1856769-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

Since tmp is not used later in the function, this memset
is unnecessary. Even though this is harmless,
it causes tools that look for security issues
around memset to flag this a bug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_cmdline_cirbuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/app/test/test_cmdline_cirbuf.c b/app/test/test_cmdline_cirbuf.c
index 8ac326cb02..1be357abf6 100644
--- a/app/test/test_cmdline_cirbuf.c
+++ b/app/test/test_cmdline_cirbuf.c
@@ -281,8 +281,6 @@ test_cirbuf_string_add_del_reverse(void)
 		printf("Error: buffer should have been empty!\n");
 		return -1;
 	}
-	/* clear tmp buffer */
-	memset(tmp, 0, sizeof(tmp));
 
 	/*
 	 * reinitialize circular buffer
-- 
2.47.2

