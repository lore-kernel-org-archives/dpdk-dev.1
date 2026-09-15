Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08F5C88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A20642E8B;
	Tue, 15 Sep 2026 21:22:50 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9CDFF42E6E
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:48 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so48211a91.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500168;
 x=1790104968; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H8S9mNpoubhZbTfn5u3gU7+1EIKiTmvtrj0A1uuyClY=;
 b=g43XUih0CAYhcXiDzI7pSJGZAwfi0SO55NUCy6JDAFu105GGGzHvKYCl5l9tXGzfWy
 8Fo6QXsOZnt9fEMfj0XcUhV9rP3F9SlNRcN3XLzsMxfrfq5Ly0TD/XOf/sGT1h/yG8yo
 TmI87LyQzc03MO/N0bx/pzO2q7gIxtScCtifbNEHlzCYhVYiMaWy/CrSE4cpCzyBqiaJ
 p4WHHlZTlTGEIrexkfQwpDdjUJKuhjpTVksGrl4ZQ1wH5R8zcLLAWi5Vpnjn2Pw4M0JT
 zyHzSCWMmAW0Is2bg6MZqHTULpKUgbmZ5G8Bl6hSdC+w7vQ0DhBv/ivOlI2qtmjM63y2
 6fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500168; x=1790104968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H8S9mNpoubhZbTfn5u3gU7+1EIKiTmvtrj0A1uuyClY=;
 b=YY1mD7HICXzoTCJ5W8dFis3xGXJ5ZcScjnZ+uy9TFrRo7OTOdw+ct6gV1pwsg/fvCy
 Fl9MezzgfzxzCqA8STJF2TmKsYcKnFwRQRQEjrQuZ9/p/ZbiTfRryND5T7DXuJH2uqMr
 4LVKmvpfApycssxjsw5e+wB4C5JTAsVaMRnKeEONu97tYJr7UV94L5pbSIUF1PuSQo90
 rLbCBvp5VsDXjKKcaO3D9uvSitj24ZYtDDYrDbpUu4NhUO4dfMOJsuJGOgr5Bbax718N
 kL7LhnnTO8nuD/m7Guo7vJr2P/pP5cBAAEcT7JObSQsFHcUw8naM503bsifMgFURHoM5
 rrLQ==
X-Gm-Message-State: AFuF++nEbdtyF3fzne/G9wW3CGJG497//vcMBj9R7Gt5wKu8zey8UY6s
 IBVZ1m+kSByNraAKbzKDAxGjEveQrqKA+5/OW2Uzb1EYT13sUPiUWfRIGqb4+WBvK/1Vx5JNnbF
 z8VMRk6Q2hQ==
X-Gm-Gg: AYBFou3qIfRR95PqFIKIOf0xWL+Hk3RLgVLRPGcVBRSQIjgl/ugorkvdVY7DZXsf0Mq
 /FarQP/JT8LcSvUhIX1yTBm8DflRXyFKQZ83DN774SjOtktQ+MwsjBmYWsx193hnufbAxlblniL
 3soy0izTBsWQlxnQXrDIAxZKZK2fTw3buOUUkw08t34zYnA/PsQa0Lv2IHxmm/mUg+lgp+S0O07
 qOC/7teN2htXQjq8VCSnWelI7FIcBCZ/v0QNNhhEDx0602vcNRRmn//QDzBoGyHoH2JLkIHPzm1
 bG2B/+8Cmaf2yMgSDFOtWjgb05QFUV4NXmUqgjNTDB7dXBoUDaDaSW2j4I2sy36nPZgp+SgwiMz
 1fZ0LPf4On9ExYMSKwNN8jiVsri4dgSzSirNl5GW4EQgNGTL8wIImMoaNjpBoI+PFzw24Vw0yMW
 Zf/AaYXgMBX6lVPM8TKJHibl0eaKYFJutDyJ1z7HvwBjMm/DTpbhGLUtKB1YjhJ+k9jkC7WPcOD
 DWXDVYD0d/KblCXYIIZCtf3HtVwhniZ5TsC/g==
X-Received: by 2002:a17:90b:3d8e:b0:39d:e1da:81e5 with SMTP id
 98e67ed59e1d1-39dfe11c04dmr5889132a91.11.1789500167674; 
 Tue, 15 Sep 2026 12:22:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 10/18] ipsec: use secure random for SAD hash seed
Date: Tue, 15 Sep 2026 12:21:08 -0700
Message-ID: <20260915192207.3926217-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

The hash initial value for the security association database was
taken from rte_rand(). A predictable hash seed lets an attacker pick
SPI values that collide in the same bucket and degrade lookups.

Use rte_random_bytes(), which is done once when the database is
created.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ipsec/ipsec_sad.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/ipsec/ipsec_sad.c b/lib/ipsec/ipsec_sad.c
index 15ea868f77..0ea797604e 100644
--- a/lib/ipsec/ipsec_sad.c
+++ b/lib/ipsec/ipsec_sad.c
@@ -300,7 +300,12 @@ rte_ipsec_sad_create(const char *name, const struct rte_ipsec_sad_conf *conf)
 	memcpy(sad->name, sad_name, sizeof(sad_name));
 
 	hash_params.hash_func = DEFAULT_HASH_FUNC;
-	hash_params.hash_func_init_val = rte_rand();
+	if (rte_random_bytes(&hash_params.hash_func_init_val,
+			     sizeof(hash_params.hash_func_init_val)) != 0) {
+		rte_free(sad);
+		rte_errno = EIO;
+		return NULL;
+	}
 	sad->init_val = hash_params.hash_func_init_val;
 	hash_params.socket_id = conf->socket_id;
 	hash_params.name = hash_name;
-- 
2.53.0

