Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773B2C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:18:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E91742E77;
	Sun, 18 Jan 2026 20:14:45 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 550ED42E6C
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:44 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-655ae329d6bso4373995a12.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763684;
 x=1769368484; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDvOKxnwgihGCOKPT981KZXpPd8PK2XAegVaFDS7YJo=;
 b=aM1XUASRLYiCPoE9CpmONHjkUDj7YJIaG6bISEmUdmdGBs5psBubApMzmKw1s3dNaa
 EpAw1OTFJZhP7vwd/9kU4FI10KDkG0YUsqWOQH4znE3AWS800Wj3nYAszdXU+wFpJFCi
 +LyLInHW13u4v/HEuuZvZK2pH/4ycp7ogCj5+XtlXA1rHzoK2Mxa2nsS2VRwEf/eSGz/
 4JNhzLYGS72MUyLFZDE2Ij1GbS8GQKq6Vm60Cwbkp74p8w6OkNTK+ICe5I84+43QKpYM
 ZKuhR+ztsNTnmxNIDlluV95r4I6amQjaa0BX601xCknO808BPII5YEeqlWerVUWsb/SX
 4EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763684; x=1769368484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hDvOKxnwgihGCOKPT981KZXpPd8PK2XAegVaFDS7YJo=;
 b=pkUKBX7LQBy9sWIfiwGi5Fj9rTyKT1MKxDZOdvDoDYg3P8apB4rDhtIVuPD+zcDgot
 oUn3wCvb78rquZCWsC8Ouion9xj66viS82fpAc8CTPn3unkSh9syO0VD3J0UtdkZz+4I
 XXMo3cMkTNpXOGwAxgn2rRO2C3YXU6vnqF49dKuh2BJRuItnmrPb2TTLhP/Oxbzz2xMr
 vGgtP2g6Oasl7lntXSeO44Huh2kHmPL3TCSWt6vp9fcp1MeCmH7Rk++MiH3ATXT2s1XK
 +dpFPX0rt/TUiY/QDV53gnOyK/U8/iHyJy3b/wc0hcKHJe5/pC+zKHlKOlCqMZcjRMyH
 GSRA==
X-Gm-Message-State: AOJu0Ywto8amN0TrvMmSKBV6YXWVYa3TIvy4QsD7dpvobuuUWPJLdxNp
 ONY7IEqpfKVdJr6avpH1gxwq5Nuo2sBG7eq8OLTTB/3oeKkisCKT8WFTJgfojJjHyuIKjFwS2Kp
 qpw8R
X-Gm-Gg: AY/fxX7rNI+S22Z915LI5Ns19Zo+xDVRJmM5y6AsBd2+EtyxG6OC68CXK4TEi4ls2Vk
 C3DBQtd/IQ0gtj3d9tb0EM0/Ypa/b4oueIWmDads0GWOiOYOdZLPKzvh8jpS9rcElg1EN/eWzg3
 hyPO/jgh99NvjzkJQeODDehXcA4hKuBb3eyPYnSBfpUUTRYJ2jSdNkK8SsISNqcYwF/OZN9i2nT
 41fADeRR/wU7/RViKdL2KezLEn7A33JxyThoL6N9HWg4P6fHyniA5A3oCswlPpqo18MZTmJurkq
 GdZJIVvpyunr+AxCbzT7zTHoxPwnB7OESQBE7N8iIfU0biJTPjLJhXJgeQ2YcdPl+NWgU7ccMWA
 oAlpdeS7snIOVvpNyyW9NHFJrAqKm7CPHGCStAvFi4LImjWalOTP7wQHO5Sw5iGYbITZJqZJvsR
 5i58Nq4ZdfiFceKtqTMU5CiMXfodW4K0mmAZ0B8Z7g4BNmT3ZdXs1/US0M4ZGV
X-Received: by 2002:a17:907:d0d:b0:b84:1fc7:9457 with SMTP id
 a640c23a62f3a-b87968d4039mr761648266b.8.1768763683857; 
 Sun, 18 Jan 2026 11:14:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 49/54] doc: correct incomplete sentence in ring library
 guide
Date: Sun, 18 Jan 2026 11:10:52 -0800
Message-ID: <20260118191323.241013-50-stephen@networkplumber.org>
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

Correct incomplete sentence "is shown in with" to "is shown in the figure
below, with".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ring_lib.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/ring_lib.rst b/doc/guides/prog_guide/ring_lib.rst
index 98ef003aac..8e1dec288d 100644
--- a/doc/guides/prog_guide/ring_lib.rst
+++ b/doc/guides/prog_guide/ring_lib.rst
@@ -43,7 +43,7 @@ The disadvantages:
 
 *   Having many rings costs more in terms of memory than a linked list queue. An empty ring contains at least N objects.
 
-A simplified representation of a Ring is shown in with consumer and producer head and tail pointers to objects stored in the data structure.
+A simplified representation of a Ring is shown in the figure below, with consumer and producer head and tail pointers to objects stored in the data structure.
 
 .. _figure_ring1:
 
-- 
2.51.0

