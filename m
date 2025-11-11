Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF96CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:19:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF13C402EF;
	Tue, 11 Nov 2025 23:19:08 +0100 (CET)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id BDBDE40612
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:19:05 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7aad4823079so194720b3a.0
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762899545;
 x=1763504345; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LptPlSMiLcrnBm7MdWvcF7UrvDAdR36h7sf0n/TbYaQ=;
 b=RyBkDgER2UQUTlLey/rtFIaIJBG8eOuzAhjW8uhGiLdbl4PSXJ8yzR3AVJENHffqYv
 oNEfg4wcMajD69y4xYbBwrEpOJ6AyXEpPAk2KuyWsgmnhQoOaaNzfnzLEhMXK4xvTe9H
 zIalNKW7eDcL8mU/ujsB5jE7jvQurvajIOYQqPr8NZ37SpVYrhACsglBvK9uYClW2b1G
 D5mn5HUeDbA8KRc1aAKz5IJRTNFSTspYUAr93LoXvMrTfEo1vF0GkMF0AkPDUnk7lYsO
 Fl9s6bWH8mT8BS/zWuP7GrXypkpVCYY796o8l8cUXMdDfhMa+1UwMeqlKQJ1JxrOpDJs
 6Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899545; x=1763504345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LptPlSMiLcrnBm7MdWvcF7UrvDAdR36h7sf0n/TbYaQ=;
 b=D7uMrN6HPIvOycbbYxK8c/d1NDUkuwfYI5eKW3ntRDtq3JOYQST4jaGr5eqOWRmmQz
 VtCitsRlgkQkZo6Vl7ulfVGnW0+45iPGrluXIQuDZUpfw0DsTR8K24QLkvZP2hgi8q2g
 iitdR0zKMjjLyFtpUT2BwoVezGsKmZpRbSOB767nBeehMbiyN1Xa5N9TsFBm0abCKxf0
 2RDgS4lTeo2RB9cGVmehp7b7ozNzvW8R8H/evj9KY33aEC/DZ01R9GdJ/3UmMZvfYZiS
 CnfPYq8xiwLsWnG4HXpJajsrpM7mVJxnVh0SJt/EYG2eKxW6Sk+g16zpDepP5BI/Xd0x
 +eGQ==
X-Gm-Message-State: AOJu0YxYUzadqvcjcHNzwlUPX1FL9HPpKhGKcjAOF6y/Bg1ddRJuLhpg
 YGrFH15vlKBErQGbsx+DdEwuxFwboaQMEFJ6rJEwWxiIdH976pR0KFp5upvI9g3Jvq7lGxx0ggF
 r+vd4
X-Gm-Gg: ASbGncvH2nGcbyEBl3Hhb3NhcFmt6uA2cJz7zFDdpBYa/JL0UBZkyg5mfHO9o9+UIlM
 r57DAE8x3fh254m2rjNYuhGehc3b09Xr3XQBSd2lv2tggUe3vTSAtzWHK2No9NLOLM+D+Feapcn
 83nDn5lAb33qT4e8TxMqKfOgDNj86jehg30+PJS29GyzmvaLJ93h4C57qH4NPqijZE4RvXuqA61
 oAlJZveDfIritmg0OxYHmz08cDgFgjQLLLfkjlZW6q94Etl3uhT9F0fevcNbt3CCMZy82vUW6Ia
 KkCtRdJw3onYM0O68x6i8cnQ+J2n7ZFBm26XL22RKEtPBCwDBH87i2NHFJOEgcYoF7/NFyHHn8Q
 w4kHEpi7bIEVj+3NUQPVhRmIF7iLWoLtdLPw2G+DnIjRrLlFbr62WEXrFXlENxNIo6r3OdKsWBp
 RcuoXPE6iw5MbDj/8O1V+NKiJT+y3rGfSGJLHBtLLxsbTNF6EUwg==
X-Google-Smtp-Source: AGHT+IF8G0Yot7M25fzpSrS85SZZtnYA2hVODyKiQklC/ccdjCZJh0IpA/44oT7wy7vIiMMFvEZylA==
X-Received: by 2002:a17:90b:3803:b0:340:b501:7b7d with SMTP id
 98e67ed59e1d1-343dddfc5damr954019a91.14.1762899544988; 
 Tue, 11 Nov 2025 14:19:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072e5a5sm157001a91.11.2025.11.11.14.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:19:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 4/7] examples: re-enable format truncation warning
Date: Tue, 11 Nov 2025 14:17:21 -0800
Message-ID: <20251111221857.443752-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111221857.443752-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
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

There were several hidden bugs in examples because format
truncation warning was disabled.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/meson.build b/examples/meson.build
index 8e8968a1fa..25d9c88457 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -78,10 +78,9 @@ else
     examples = get_option('examples').split(',')
     allow_skips = false # error out if we can't build a requested app
 endif
+
 default_cflags = machine_args
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
+
 default_ldflags = dpdk_extra_ldflags
 if get_option('default_library') == 'static' and not is_windows
     default_ldflags += ['-Wl,--export-dynamic']
-- 
2.51.0

