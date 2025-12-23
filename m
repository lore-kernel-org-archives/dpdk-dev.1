Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B79E6FE23
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 18:16:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7634940A73;
	Tue, 23 Dec 2025 19:14:56 +0100 (CET)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 3183B40669
 for <dev@dpdk.org>; Tue, 23 Dec 2025 19:14:53 +0100 (CET)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b7277324054so858760066b.0
 for <dev@dpdk.org>; Tue, 23 Dec 2025 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766513693;
 x=1767118493; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=sQ+tUKVsqTr2QwpMTVx8m71mX8e0+B90kcf7GIF8feqp/A9SIkrKNmPLD0oUkJJgR0
 H81oBwv/6t23AKXOw59zPRAjmEejrVNa0sX9uB2mmYZTKl85g0O+K4y2wMZ38JWSClMB
 53+63R6Lcr9AzBmShh4EuKGNoeVFdc9940pL8XgHJvP/L4B2dV1de3rhaZKfkzLhwzbE
 GEbIlN4lKCl6hcnKDXbCKmqVhbB4I15gxaWfvPPpwUDgPjoHVacp3i+6PSO6um8p11ez
 WNLQWcIZz8LN2t8fwelOQ8rCR6I9+haaA1OrulWD6Nmk8UQPfET0u7GIRgEe6X9ymoox
 Iizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766513693; x=1767118493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=XVtqKIk0eS4Cz4pR/kg+9jrS+3LLatmvOsDbzgfg0V9Uk0ly+Glghc7EUPS4L8Av+h
 aa/KFJiVOtFE/yaCUmmWKYAu+/SjKj6D9mcgZZOqCzfnvZSNqqBXw6Rr2sI8evU2Nv2G
 sy0NTGoPzcxsfjWyY/GGqUZ6FwQ47jk5VoKDRxlfPkj07AI5rgQkPJZdRVVsK2Uhy8mF
 NsWO9i2hXp4kEB59j7uwounpscloNQrl2V0AVZAYxeXfWUu4ofvyLM9OSir4rdCCi9H5
 kT4Wt1mYMIFEYql2vGTBYTbhPExYAxvS7fsmdXk/+E1U8/9pWR/N9L2sKDSRRSzsfVM0
 pX9g==
X-Gm-Message-State: AOJu0YzHZNWJFWIpPKKS5WON7a5SBwDdBcJDUNKP5kJGBYBSGR1NLxbe
 onZ48AYBSzCIJvCDyFdtuDJDiNGmxsQnl2A7F9VRfP+xKHm3JKyEdF4urAndoWRb49So9SAn7Y+
 PVPnSWb0=
X-Gm-Gg: AY/fxX47cYUSZ/nWw2QvzuWg3obvTBjS+oqxzLdDjNWGOIszW3N07FXKim+Fv9Nvbje
 8FuTx0bZ5zFEWyeXxyhbUNxOyYu1b2IOlPwiKVUWiubrjc47w1v7OWdTKSQwzFAsvDYd+kDA/Jq
 +EUdYdIVuj/RQpmNdaai1jgVSpivD31MWbZ1A9aR7vJUv24ZT6CxzOLXCNLDXW+HBzjUPgJ1AWA
 MRYiXModqX7xko/Ws5P6vPiwAkMW4Bb6QLUd+qKRxGMD0305FelPYcpY7LcSnYjtoyRx+uIEoDb
 F7RcX/uLHpGVH3s8nPus+FK6fo/dCA5GwGQgqOemrHqcVu2VA0qRi3Ranu1K7GaraViUqR25OUp
 96LHyABcpjOT8o2ELfk2hLRfdn0mXw34XK57MPVGmzbRnPPLMf/OsHlvZHACWbqC7B7uvatA52J
 jurzpiOyhPcNtySinequlPu0b6hgBIa9SC5SsSaxChLuosIaMrQA==
X-Google-Smtp-Source: AGHT+IEkERKCxpFTvpHyhcbPwFRGX4S1qHtdFRgi0XrQnF/K1vBvP9hot6fGgWAPnjnvFT/h1DhzAA==
X-Received: by 2002:a17:906:c104:b0:b73:8d2e:2d38 with SMTP id
 a640c23a62f3a-b8037222776mr1664440066b.50.1766513692683; 
 Tue, 23 Dec 2025 10:14:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037f3e271sm1495302566b.60.2025.12.23.10.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 10:14:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 18/18] lib: enable format overflow warnings
Date: Tue, 23 Dec 2025 10:13:16 -0800
Message-ID: <20251223181418.40834-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223181418.40834-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251223181418.40834-1-stephen@networkplumber.org>
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

Enable compiler checking of format overflow

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..8f5cfd28a5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -113,10 +113,6 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
-
 foreach l:libraries
     build = true
     reason = '<unknown reason>' # set if build == false to explain why
-- 
2.51.0

