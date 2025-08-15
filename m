Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5ACA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:26:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B53F54060F;
	Fri, 15 Aug 2025 18:26:41 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id DFCDC400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:26:39 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3b9d41bea3cso2002823f8f.0
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755275199;
 x=1755879999; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NS//jgbUSnkccYuJnAE053QhGzHpGGtE/3ikYfDs5Xo=;
 b=vXlEzMMkD9+gLTzfnSbeoUMEh145wQzYSnHGSMAIm1TqmukGubGtBCl+jWoHmDpBQ7
 kP1IuEJdtyfMAyGGDscUs8KpljcZi9aDxb25N4+mXysiQvTV6M1+0LcZfrduZ98/5Y2o
 A4aOpmm4gXfTyx7w7IlpPhxBGFqXkdKDLMBSdZa3cBe7YKPZxICtDZGqx6XS9ZccT6+C
 DAEvQG+tfXMo6QljDHhHmorLngFe4OnzT8XisVayGZFxVA6ufVftc+97b5ndJ0XZ8j5e
 GzYCmS1jOlM2VBQIkkvOPm4qZ1SwiG+JMyt3sK5olJ9bHKw7LolAOu8j76b+uLBBcber
 0iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275199; x=1755879999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NS//jgbUSnkccYuJnAE053QhGzHpGGtE/3ikYfDs5Xo=;
 b=YC6LO9V4QM2J0+pZpX6xJxCXWsSGxep81Wj4koTAFHryS4AYgBSkV2sr8GLlDhp8C7
 AWPLTj4LVVnFtcHIKRYqOTnRa+XEXoi5J5q2+xIa5HEIy1T2EU53UQrG2rN3zU2NW57W
 CkWSZdZOmeT7nha5IXKTFaOme3EPXqmVvJxOQ1QOtqdHck0AOCDxQ2oD8KTuboMqpT/x
 SYkOwQFxOf/t2TQLDdgl+IRqhSAPkM5fPMH4LWk737sZDINBWBZ2z4SHDZQYNR16xKaP
 g/lfrVsv0YsVSFzzeAndGteUKE3as+OpsXfjGp3G2JcPFCp8L7fNNP9dubcq6EvQy77q
 DQkA==
X-Gm-Message-State: AOJu0YzdKZknAjRbfGe5+f54TYsbN+9HJRRhRyjsO29neBOX9enxdeaG
 a9eeNKoMlXPK2Yqqmg2eQFwSMkASdLrhOKG79/QUBH338nFdW6Lr5ysLR/gYTp3CYpbx7vJ9nl0
 UThLN
X-Gm-Gg: ASbGncuo2J3L1C7FOibMBaKhMTpfWxYWTTNBkIlhJqUVdGPBYdMbI89l7XhxqEV1hKG
 iA8ugabHNt+tBzIYP2I9fYEJahZ93bko14qcQ7iSWmSfx9sxPL/MmJW5avjjl11Sv+DZUqYtZ8E
 Q/7gdeopo7DIQtof03ynMf35+cv/F0dkhVOoz8bqWPsKwER8FzSpzseUrIVFZAb676N/dZ8/cBO
 5jlevM3jz7cg9HJItjqTYe7HaJaPD5W3sc3UgWxjj3ObZcnUL/7C9vqCaBRScOXFLwF8nzAGzL7
 wn7EvvYWku49HXlL6Wbq7wx+qqyhGkUJhol6O+9lVspdq5DDdXDwXomzDzBbi0NBcxLXspXCnse
 YZPrS6rzQVOm6faNT8cVLj3+uH3meUK4sjLwDAgi6jIhiJr92v9+2hCdA6/z9RPgrORQ8TJHO
X-Google-Smtp-Source: AGHT+IGhBoMgm2Tg1R1kSRdVGvnLiGVKGoBJXdE0UmGlTpL8+/TyrNJFaepX+CtSmCfhVjaA4HuNjA==
X-Received: by 2002:a5d:5f53:0:b0:3b8:d3ae:26e with SMTP id
 ffacd0b85a97d-3bb69b7d31emr1766994f8f.53.1755275199534; 
 Fri, 15 Aug 2025 09:26:39 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9431sm2665278f8f.40.2025.08.15.09.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:26:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 2/7] ipsec: replace unnecessary comma operator
Date: Fri, 15 Aug 2025 09:26:18 -0700
Message-ID: <20250815162629.161782-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815162629.161782-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ipsec/misc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ipsec/misc.h b/lib/ipsec/misc.h
index fd4d3f5256..54dc5c2d4d 100644
--- a/lib/ipsec/misc.h
+++ b/lib/ipsec/misc.h
@@ -126,7 +126,8 @@ cpu_crypto_bulk(const struct rte_ipsec_session *ss,
 
 	const uint32_t vnum = RTE_DIM(vec);
 
-	j = 0, n = 0;
+	j = 0;
+	n = 0;
 	vofs = 0;
 	for (i = 0; i != num; i++) {
 
-- 
2.47.2

