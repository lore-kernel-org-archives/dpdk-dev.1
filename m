Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846BECF9C51
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:58:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3C7740661;
	Thu, 20 Nov 2025 17:57:30 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 4A3664065B
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:27 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-bc59a785697so1036768a12.0
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657846;
 x=1764262646; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=xprlBi37kzS1hmi4JrndZKCdfOxDQP/ueE7bMKYJ4yDRD5XfnDcTwA0nxZcwlG9IH5
 T4pCQCwNPACRCb+a7/Iq6abUednRLndjDTkmLdoDMdE9HrH/mcrBC9jJAX/oncwYt+n1
 vFtBXu4Ooud2yAjjDZe5XG/7yzX1k2JmpgeTYaKcYdrSbCc0UZr2LhQbWJOsQ1dWTokA
 uG+jgv6GAsrfMpHju+OscMY1JE+dSXNBrHMKfQgXG1FC1JSdzU1iF1JPD4NGLZF5Spat
 IM9V+aZ27SZVch/Dg3MoNEn4Np5Adq/E5f0Pwo48LUnKdEhJrtRU9RIcMHfQw+4fPfND
 v6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657846; x=1764262646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=j34YwgDYYtK/4zwKd9oS5IT5+WSXBdFqmaUK5p8H/ogxqtuIAu4HWnzWgdsJ+fzD9h
 76bYEcKuNv8keuojsUq2XNx8qVIAJWyoHluGSh+FG5CRsMXV1cyfe+15jbiydA92unrp
 mKmYfED7niFHAQne8v80BF1ly+tiA2CaNBvpMgtoOScL9dRPFFlperfQtIwQstJRJlK1
 7QYll2aifPoh/4GZXTfdSOFa7eKH6n6U6Gsh+s5WxTep3VpPJVdo0fr+U1DiTL1d1nop
 2m0CZwH0edi0YhvhWXB+x6neM/veX0y1KDD1ekWb+BQFrEJLHKnKciixl1XdZ2lPYOC2
 i2eA==
X-Gm-Message-State: AOJu0YzpWEB0PvM9qDLEuw4/Z2lzgfOBXtRsQbeBPNQhiShJ13eeavU3
 nRviXgfhUN9yV/TUUxEOKd71qjv6NlOAya5mVQ6RO5jX0D3t3+K4tRSoeqPoZgrStWW323XdoqB
 2Fozn
X-Gm-Gg: ASbGncsqLmJ9fzoEPXTaQ5max/eAZP3hvc5+UDPPharIb/1n1ge4bwLX8Igsyqrh36u
 JJ/wY3g7Gzm7GNAU5pw7CD5QV0PFrKmJMjUe0+yGaox2EwN6Z1GOuPtNe9M7qP5NYkyQaXT08Ez
 FlRG9V4QT9QRsBuQsb3DOY+h0ab4Po76p/ryuPUbmMuxe3tXv9GTLQdJCVI5A98SmJ051YXyUh4
 ZY2D2F1YY7mIE/B/5/CBqZnqx7R0NfLksf3OZL4UWdI0gcjgLUsSvFi+nocFztyOAlg3cGRpoQF
 6yZFPUMI6iOp41UyZ5Dj0UOwD1J0Rl3CaDy7UseIHTfitiFIzrGDyU28cV0t+DiDa522Jv+q1L6
 MVhLlqnUsgg6Ji0wbtTzTl5FTeGNvLzamQt4cPP6SaG/SQZjMrkSqsZCPFJRJzKo/f4Mvds+9u+
 j4ynlUPbOoTeY4j8ymNqoh3ibjK1Ew3ND87mn4sxJEOR9/Hwa4fQ==
X-Google-Smtp-Source: AGHT+IGxS39b1TlwFmFb+lJqu6P+yMG702weQgSAWpCo+QMRRhErdRKHvwvRucVIIWavOqkdu79dFg==
X-Received: by 2002:a05:7022:ff47:b0:119:e569:fba5 with SMTP id
 a92af1059eb24-11c9575081emr1135361c88.20.1763657846336; 
 Thu, 20 Nov 2025 08:57:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 8/8] test: re-enable format-truncation warnings
Date: Thu, 20 Nov 2025 08:55:36 -0800
Message-ID: <20251120165713.120238-9-stephen@networkplumber.org>
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

