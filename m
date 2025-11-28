Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23629D116F5
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 22:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E0C640684;
	Fri, 28 Nov 2025 23:44:46 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1DB0E4065F
 for <dev@dpdk.org>; Fri, 28 Nov 2025 23:44:39 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4ee04609ffaso8811261cf.3
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764369878;
 x=1764974678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=IRSZZUUgnUYM331MPsQ2lBFDGcwD0534bkdThSDKxR+XBGq+L2uStYDfPNn1Mei/sJ
 7ziINTMpdOnpfCwlqt8R+V/uSg34O356K7En3PgGgsHaOGmiN8aozs27cXlDkCU+SStB
 v9aDICVWBkR6MBGatIbcjwUq3/UJznuxWyHtnDf18gmTyADytaIKhrQl0IGU7QVs1mnQ
 yn509FSZCI+0Ls94LhUd6Kt+LWFu1pJsZG803X+/OI9922VrSpvU0y5zcuexL25Aj4+l
 4Ce6idL46Q3+D5viwtQsOH9isX9vt+yQ4V3Q2bo/BfEC7WBF3P6i8mcGh4KfnbQtXDbN
 IL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369878; x=1764974678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=RcUkWXjWhLc1IlVnUUKyYLzRRpQgC4mDo8XEXjN9PMzvJ97afsWMkqxmPQC2JTj6Mb
 ydZdbeoA2pL1wYLuDL4OOCIh0EwOLkyKP/2sRuseQe5VypXk5onB9cH7JGRYxNP5v4cI
 GpwU5Fx+vlJaQoKuzuJi/QQjreRFcWKEAJOlv2c0sb1UsqNsVwiRvh3gannZJtyLcvsP
 H/efqki2GS5FbfHAuZZw0vIKehUqgvNvu6RV0EdiMAjbanrq7JXq7uR9I4qhStyJA/Z+
 rfLEWKIAlJiznWi/IZUqUsR8Rqs8t1vBZnSkTfV/dhTfbTg/SKOVPPHDfBW4UBkGDT5q
 7Ayw==
X-Gm-Message-State: AOJu0YxoVYlmzqt6fKbtRcABATdANHwRUYjF6it+dHVH15a9pl3KBGac
 zBb2XBEPgi1nHpPOWgeRFUNqQ/6E56O2WY9qKJV0RwomB6Q7xMb0pztHU2mRUqkUc5dJ4mV3kw7
 AUot6
X-Gm-Gg: ASbGncvpIyWQDELLJl+vRl1ZugqWFZPnhYZIKZMIwPMFkCzPzKn01daBRAC/6suB10a
 WZfAUmRXRhW2FUa8E/GCPsl4L8d1Hbit0bs1qgwWgDKXBcqbGBNSSnumWEjqw67vHu9JB1dxf6F
 OdmGU4SyG67DIxuq8oV67iv4qoCzW8HFs29fBYbachkoIOs0FlI1TQtUXQzlv2WYwGCquNBEus8
 No4G0aZM1XoRVM7C+8s4y9xualZPc9lqXgcdmkzzMN0W1XVnniZyHjDPCjszEowf+aI0j6STLgW
 0TB5IYBMrR9JMmklkBUCgX190Gi1N/ZHS+Bh4h//7wC+wlQHpI/VXavyEyCCvhfNqTu9zPSO815
 v4mDRnX+j3IgjXPoW+FZD1tlI0Xd+yeahkECfey2e+nmqDGO3++lqqYrDz9pC/WOw0NLFcEiquu
 RkAxzIaz6baM8a1jfZAWlTGWOuYIkjRt5XZylkV/WqRb35OFEmpQ==
X-Google-Smtp-Source: AGHT+IE1oH0Wf+By5CXjrRu7hMpwbm4xWcWos222yQOBnMBxjtDhD+OcCYQvwhpulc3iFQYNKIiF+g==
X-Received: by 2002:ac8:7c43:0:b0:4ee:2787:3a73 with SMTP id
 d75a77b69052e-4efbd8cbe35mr230672261cf.7.1764369878427; 
 Fri, 28 Nov 2025 14:44:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-886524e2b8asm37022216d6.16.2025.11.28.14.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:44:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 10/10] test: re-enable format-truncation warnings
Date: Fri, 28 Nov 2025 14:42:13 -0800
Message-ID: <20251128224420.195013-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251128224420.195013-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251128224420.195013-1-stephen@networkplumber.org>
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

Tests should be built with warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..b00260c0e9 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -260,7 +260,6 @@ cflags += no_wvla_cflag
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
-        '-Wno-format-truncation',
 ]
 
 foreach arg: extra_flags
-- 
2.51.0

