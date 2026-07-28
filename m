Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B69DC531F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 16:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C9B406BB;
	Tue, 28 Jul 2026 18:38:15 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 0873E40A73
 for <dev@dpdk.org>; Tue, 28 Jul 2026 18:38:11 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ca2fad0ae38so2900818a12.3
 for <dev@dpdk.org>; Tue, 28 Jul 2026 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785256691;
 x=1785861491; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TRXXFrPywKuv5t++MaJeH/BlZCW/9cnsO9kIzwOeZGs=;
 b=bDn2oFdUFHPQopmJhQoFuTnMZ0L8EU7W+OGQQU7c/QuURdBDJ2/OhOV9Igb3X72E5L
 ekwii+AZ+wRQ/7U2Is03ZdCXMWRlVC1yjzyAarwvmLESVhteN0nMqnAuB03pBrfkRMdz
 /1rArJdNP02yay21Bg1WGS6Fid+xxe8/lIp5dOyyuqjjFyTea3bozFT4UxEtc0vuHbvq
 KlLWy+/i3kkcJAhj3VCo8vXjdBvrkDSLkte8hTC4jfhAsCbBo+vhEoA9HmOG+7FJgs2u
 M5XSL1bKfOJyVE1BEZMzpwpfTpRtuj1U/XuTBR1YInn5M8BHnhsLAOo4AmpS2GQvNerG
 q/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785256691; x=1785861491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TRXXFrPywKuv5t++MaJeH/BlZCW/9cnsO9kIzwOeZGs=;
 b=ShBHHejkCVT2k3n1N1SMPocqOaB0Nx4WFlVu+qFNYPTWw6ml7GxzjQr2UsncgyaFG/
 4Mu/N+LYFLYeb4fJ+90brg7JmghxkMAYIquv+M0349/K7ORoPI8E01zE6EXJ0JjlIiKx
 fHCgD9UgCfwjU2+a93ELq+7tn1vpQ5dAMEOC5whQ1Rqzs2t9roeH4gWe4VEhQMhVZ7Nq
 NPBWwNecWOJJSuqP94eoF+SGKmohmuyg9LDMNi8xAqH8gpXL1NmHDOzZd0vdmSosoG/h
 Q/VU66qLizxLRGwDdnVzWthYifl/Px020Ym7t1p4J2tpcj4Bv1lFMe+GdSJaVcPXpu/F
 dzFQ==
X-Gm-Message-State: AOJu0YzCDkQFArJZh3r9JiCpH0Kph60k3toaDyQbIHZ6d2hIBH6tS29K
 eNfZ6OF/v1G44LpWVLcd8s1WBPP7UHmuNT2NXZ5a4UImJCCrRZtMXATd6UdMaYcDHSVKyzKVJUf
 YZkyx
X-Gm-Gg: AR+sD11T3u0kANt6RDN4jiCNX4JMigifBsumf1XkkVRU7GjasTVxlVnZlRForI8lNvv
 s++75/SxtfKd5i5AXRJxW3Cks3DA9gFIsSwYEf8ClumZXEg9Y6V0dlVMgE60J1RKzNzTh5Jw428
 oOIGUoarlfo84tXr3hjaf0PlZuJvSkqG2oDaQNdzrrEJXZcENg3l45TjsTl9DoHSvWcCXyC2rxH
 BBttTbEBSyedfpYpquGXS0ih4McKLmihhHJEc8Th/LvYPCDySr+2eCxyONhDmoWeV1PvWC4zioq
 pQ0QCsJaz7IxIy2P5KzKEzdkESIhK+Or0GRorjp4ipifQ1mjmI3EYRqF9fOcdTZBHf+642HlyvW
 BkZTlcO+EwmUbJTJPE9CfavNvqv4z/FIJkZvLp0Z1ZzC9PW5953VxYHz7Sghm0kbMv98ih7LsuP
 iJGNgui4vxjvT7G8kv7pRoAYgnMXqO64s6HMzJUpAC
X-Received: by 2002:a05:6a20:2588:b0:3c6:61b9:917c with SMTP id
 adf61e73a8af0-3c8aaf7ae84mr3635946637.11.1785256691097; 
 Tue, 28 Jul 2026 09:38:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504cc63f3sm334754eec.16.2026.07.28.09.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 09:38:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 7/7] doc: remove packet framework images
Date: Tue, 28 Jul 2026 09:35:15 -0700
Message-ID: <20260728163713.364168-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724164520.192203-1-stephen@networkplumber.org>
References: <20260724164520.192203-1-stephen@networkplumber.org>
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

Remove no longer used documentation images.
Split out as standalone patch to workaround patchwork encoding
issues.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/img/figure32.png          | Bin 11603 -> 0 bytes
 doc/guides/prog_guide/img/figure33.png          | Bin 65216 -> 0 bytes
 doc/guides/prog_guide/img/figure34.png          | Bin 11581 -> 0 bytes
 doc/guides/prog_guide/img/figure35.png          | Bin 75012 -> 0 bytes
 doc/guides/prog_guide/img/figure37.png          | Bin 6934 -> 0 bytes
 doc/guides/prog_guide/img/figure38.png          | Bin 7372 -> 0 bytes
 doc/guides/prog_guide/img/figure39.png          | Bin 55986 -> 0 bytes
 .../sample_app_ug/img/test_pipeline_app.png     | Bin 67410 -> 0 bytes
 8 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 doc/guides/prog_guide/img/figure32.png
 delete mode 100644 doc/guides/prog_guide/img/figure33.png
 delete mode 100644 doc/guides/prog_guide/img/figure34.png
 delete mode 100644 doc/guides/prog_guide/img/figure35.png
 delete mode 100644 doc/guides/prog_guide/img/figure37.png
 delete mode 100644 doc/guides/prog_guide/img/figure38.png
 delete mode 100644 doc/guides/prog_guide/img/figure39.png
 delete mode 100644 doc/guides/sample_app_ug/img/test_pipeline_app.png

diff --git a/doc/guides/prog_guide/img/figure32.png b/doc/guides/prog_guide/img/figure32.png
deleted file mode 100644
index 5215113fd9d533ff56526e21e1832bc7a6cabd04..0000000000000000000000000000000000000000
Binary files a/doc/guides/prog_guide/img/figure32.png and /dev/null differ
diff --git a/doc/guides/prog_guide/img/figure33.png b/doc/guides/prog_guide/img/figure33.png
deleted file mode 100644
index f0670eb0053da643e1ee932ee3f30fdd0aa973e6..0000000000000000000000000000000000000000
Binary files a/doc/guides/prog_guide/img/figure33.png and /dev/null differ
diff --git a/doc/guides/prog_guide/img/figure34.png b/doc/guides/prog_guide/img/figure34.png
deleted file mode 100644
index caa2517a4013acbfc7c405866abfa180dbcacb63..0000000000000000000000000000000000000000
Binary files a/doc/guides/prog_guide/img/figure34.png and /dev/null differ
diff --git a/doc/guides/prog_guide/img/figure35.png b/doc/guides/prog_guide/img/figure35.png
deleted file mode 100644
index 42053f006745dbe7e02869817995e2b38dc56932..0000000000000000000000000000000000000000
Binary files a/doc/guides/prog_guide/img/figure35.png and /dev/null differ
diff --git a/doc/guides/prog_guide/img/figure37.png b/doc/guides/prog_guide/img/figure37.png
deleted file mode 100644
index 20be4aaa6de8040339e0db4200a5e800816f14b7..0000000000000000000000000000000000000000
Binary files a/doc/guides/prog_guide/img/figure37.png and /dev/null differ
diff --git a/doc/guides/prog_guide/img/figure38.png b/doc/guides/prog_guide/img/figure38.png
deleted file mode 100644
index 261c561f98a98d572c9247b7187b33f7e03002ce..0000000000000000000000000000000000000000
Binary files a/doc/guides/prog_guide/img/figure38.png and /dev/null differ
diff --git a/doc/guides/prog_guide/img/figure39.png b/doc/guides/prog_guide/img/figure39.png
deleted file mode 100644
index d2db6a499a0f764b9e661b905b0f136ea871b457..0000000000000000000000000000000000000000
Binary files a/doc/guides/prog_guide/img/figure39.png and /dev/null differ
diff --git a/doc/guides/sample_app_ug/img/test_pipeline_app.png b/doc/guides/sample_app_ug/img/test_pipeline_app.png
deleted file mode 100644
index d322a9e46e5e714126988a76456c9eae41635879..0000000000000000000000000000000000000000
Binary files a/doc/guides/sample_app_ug/img/test_pipeline_app.png and /dev/null differ
-- 
2.53.0

