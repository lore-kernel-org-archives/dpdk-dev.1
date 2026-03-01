Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B78FD0048
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:08:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB152402DC;
	Sun,  1 Mar 2026 03:07:40 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6BA0440BA2
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:38 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8cb3fb47559so402008185a.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330858;
 x=1772935658; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwwYkZLERL/NvPhVkvbEFYQtg6xiIbmLV+xoN1tKQ0s=;
 b=sRs6QqwOwVtQLhQ9P1HaU359SJgxruUcWVygWBSq8mAl9apu4s1ePpV5ElWRmIOMvD
 MorskkZ5tnIHYHz6EFRV1ne6gTL5WwLQn2omEecM53P5OhVZjFMAyrlSLKVSGKrSUSxp
 9fjAiJwjfpR+b2JQFdJUoVpr1M95Cu4IdV9KYWOIA7YYQklJ3pnafrWVxzwTTPquBt9l
 P4UgfrapB5tIpDtg3V37HrYnzO+2gBRwDvR4m2CdElJ/GVkbL5YVJQMRz7guYg1V+Ol7
 wngamV5mBWyQ6WvHG14Y5WcP7Re0AnoTwcYJ6UdxnB7GGkwXIK0ThRb+yPo1kRJf5iig
 LS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330858; x=1772935658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RwwYkZLERL/NvPhVkvbEFYQtg6xiIbmLV+xoN1tKQ0s=;
 b=BlaCjzliqOnXQHVcC42TIXZnjEH8fPlN0m233mEaJ9JBwOAAxEDUQSSTDQPAjA+adc
 sNw8v9A9nS5nVg/VHtu+7Ccv3Pn/ohUhMikWQt4ChuUo7pemB1T239Afcjjb9dzKRouj
 zNHsgZ/AFWEpDG7fA5rirLLCwmvN/RUlduk9NbwooruplBvIDbG4dXtqSWPgslU3jNPL
 8MnMDrmZ5KSaUbvXSmqhNzbO/qh1q+pjhR8w4ZaUo1g5sewRy+/D3kqZpZs8xoR51Aov
 zaL70udxcwoaI6TQqlnh8aQKJqSbpkgZLXPmMGHufPiZCjei99fqFHuu0OGNRGxOthNd
 JwCQ==
X-Gm-Message-State: AOJu0YzwIaC9Ay4lju58emS8hcuEmDhK8lZVnQFOWuad16PlIupAFmxH
 mEXox7URr1+LJXKyRbcx85CsAnaBONeiQWuOPv8++bFA7ede3jqb0NgA6JkuziWaKQZuq/fueKP
 j9EFP
X-Gm-Gg: ATEYQzzfoquLDSZwzF4TewSmo+G2kCFOet5NJhglq3rGsgu+KHXrnmp/618/C4bnV1p
 D9sk7C4QhJXrJprxBfIu1aWrM8MvTpzYfDZ5U54G9MOtC7E6ThYcibGifC4FfzyvwPPRMoEIluV
 WS4z9+3ZqbRZREkdDme5zBlTWoUmJoygr9XCBTZTaKv2dN2BqNLkXljdRrN5yWYdXK9NcI3zWi7
 ifDZzgY3X2agWhvPmlg/D3MOncYgVb1TAo6UjAkyiEZisj7lnyv2zzffmh1ys8vwlDdbvjCQX28
 kjfoyqK55La11nnOXvV9zNUiUoORFQsaB4Z1UkU4exVaRxEGjdKfzbmaXZqMy5B7U3f9KpwrHWm
 iKUpAW5w8BBKpSNFZ357HX+tWalkvOBOjpgXyFtUZ8T9jmxsmiN/gKqH+hzSVJNyPrQsKCNesdQ
 KSr0JzrUG3qAouUMOaXLuACVCGrEoTt+kOQinbF/ogs3B/HnBuared+fQWCRCYdw==
X-Received: by 2002:a05:620a:7004:b0:8c6:670c:953f with SMTP id
 af79cd13be357-8cbc8e008ddmr1036976685a.58.1772330857757; 
 Sat, 28 Feb 2026 18:07:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 03/23] doc: update features for PCAP PMD
Date: Sat, 28 Feb 2026 18:05:36 -0800
Message-ID: <20260301020726.852401-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..c4f0360a06 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = Y
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.51.0

