Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D84C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:16:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C96F2427BD;
	Sun, 18 Jan 2026 20:14:16 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 2AF22427BA
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:14 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b8718187eb6so553485166b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763654;
 x=1769368454; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GB/jRFr2ZxwLjNLTQEZmQyjPSWybFXwC6iX/zxR7jNU=;
 b=nYIQ9Jf8xjeYvoOXLBih1NryYvrObTpnSY4K1HnnQmWMRMQ1E7759EGS67mQwazI9m
 aMIrOe36VollmKnCtHUOcWYRRPhL74Ns+TnDhGPIRjxUoaP+a61CYyvWSUKMURZckD2K
 M69MfI4K+OWUxD9st07qSChfbFCclVELMXBa8u9R1d8SzDdfZOgo4GYkjv94CR5BGHYj
 hPROwAblYsfP763eEY6M5l02Mis8ZoUjFFtVMR/TWjngw4w45RvcBNAPrpYnToXhW7Rs
 rHAd9R909EGP/ES2z7Zku6A5VcD5vvCNRnkaGRX5wvbeNkHzFzFSzTRGlbnNmADhOrhy
 Xx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763654; x=1769368454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GB/jRFr2ZxwLjNLTQEZmQyjPSWybFXwC6iX/zxR7jNU=;
 b=tpefJTzlNNRpCKOQ7l/y6AzV8DTLT2Rqa+dDpMd1phWsVEDj7zI02diypbaryq2+aC
 hDHdH9NJjW2xirjhSzb06F1mfCHqckKTEMwefm0ks5GLz6nl1lMbWvSgwdpjg5Pf0l0X
 4Qf0tY2aRrBcIMU6dU+m7YJlxWhp0yPluE2RIUDuRXHHhxfKcLvrsrviUdAtcu0BN1MQ
 QbRuWA8L9tswgABirqM/Vgf6xpvr0tGB9M8UjopDFC2UPoIGxaRhWMnZvlbMPkEYfInx
 HfwTF3h1ekdYGfSvJyIHlowpYDj6STOV1/GrndLP435oS3YZ9CczatgugKlGq3CAaXL9
 3cgw==
X-Gm-Message-State: AOJu0Yx7b1szE+CLk0+ccn6tWznHEnLnBfalp8ZbmyznNqq7IaCMafOe
 Uvz8x8RJ+MO/HwonTepIybVQQuBNxpptAke1r7mbHed/D8G0vhest8I+HiJ6cnTqOrgN5tMNnHQ
 YmAND
X-Gm-Gg: AY/fxX6w5Tp7xOiYQrLBrjl0zJ69MoUHkfQDpopK/8sRHukp2pGXKHKXhby+lTfSdh5
 M9QGsYgeSCgVgBA84GVWZXeM3959cQAK73umqCF1TVXvTLa7ynodWyCOiPqZAuNlKMlcbRcSWhn
 XKJVL/kHlOO1InuJCd+45quxr2CWYtTX2ceciOKVuIz6/KRV9sjls6EYGdJJFpVAfcBgV6EE242
 L2AZ4JGu5iof7kFn1W++lXmWCecuoqAhaYHXLf+JbmA4yZbmKYQtu+cBJVzOJi/417kp271prfx
 7TnSHJnMnm2XeUHOAPoDTPles9cH0PncOvU4KGk0bKhsTJQYIW7jynn1DwoJHMbqRwYw/f7tXLV
 51pUxwxp2aDEv/jhsu4d6VjN7lPrbaj8RZ3ErWfVkims14kJ/HVE3BoAtX3Q/QBunm3YGPpTqrQ
 YPR+KSvsE3GVM/2MoWz2kHTVMu2CBFs5FHHz1rdijOksT4ZQ0mOg==
X-Received: by 2002:a17:906:fe03:b0:b87:d839:ae8 with SMTP id
 a640c23a62f3a-b87d8396e16mr65943266b.54.1768763653712; 
 Sun, 18 Jan 2026 11:14:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 29/54] doc: correct grammar and typo in LPM6 guide
Date: Sun, 18 Jan 2026 11:10:32 -0800
Message-ID: <20260118191323.241013-30-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct several documentation issues:
- Change "IP address be looked up" to "IP address to be looked up"
- Change "search process have finished" to "search process has finished"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/lpm6_lib.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/lpm6_lib.rst b/doc/guides/prog_guide/lpm6_lib.rst
index 2c3eb10857..41b9d8a837 100644
--- a/doc/guides/prog_guide/lpm6_lib.rst
+++ b/doc/guides/prog_guide/lpm6_lib.rst
@@ -68,7 +68,7 @@ The main data structure is built using the following elements:
 
 *   A number of tables, configurable by the user through the API, with 2^8 entries
 
-The first table, called tbl24, is indexed using the first 24 bits of the IP address be looked up,
+The first table, called tbl24, is indexed using the first 24 bits of the IP address to be looked up,
 while the rest of the tables, called tbl8s,
 are indexed using the rest of the bytes of the IP address, in chunks of 8 bits.
 This means that depending on the outcome of trying to match the IP address of an incoming packet to the rule stored in the tbl24
@@ -103,7 +103,7 @@ The first field can either contain a number indicating the tbl8 in which the loo
 or the next hop itself if the longest prefix match has already been found.
 The depth or length of the rule is the number of bits of the rule that is stored in a specific entry.
 The flags are used to determine whether the entry/table is valid or not
-and whether the search process have finished or not respectively.
+and whether the search process has finished or not respectively.
 
 Both types of tables share the same structure.
 
-- 
2.51.0

