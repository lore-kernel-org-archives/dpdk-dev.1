Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C87BEE4997
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Dec 2025 18:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B1364066B;
	Tue, 30 Dec 2025 19:59:00 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id 0BA5A40662
 for <dev@dpdk.org>; Tue, 30 Dec 2025 19:58:58 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b802d5e9f06so1326389366b.1
 for <dev@dpdk.org>; Tue, 30 Dec 2025 10:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767121137;
 x=1767725937; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMBrklVwDlDRPnbGYhl0T6Ag7Zr19aD1expN6irEiIg=;
 b=BSwHdT17LrQkTeIWJepbtyQBrCdqkf605Z6Q2gEp2YoqK7u4sYvu/RTEnWS1JhMJYm
 flmFkMZPC43q2YUUlMLvfT1AUN55mYf/px0beTjL8uuCOdBSd3B4xNW8lLEmjUJCKK62
 JNAgKsqeIXQ8snoKUe82X5mgGdDTmft8NAgZAVFaKGJsBrPlCJ2Pa6u22DA1PPZFAHtc
 nsuCtu9OWLxFyIt8XjDep8fwtK9GMAZHIeH8yC/ReGh78gAj6ZehFN+HA9FogLyokf1B
 COI3Hkyun8O9PwcCyTOnSwuy+UJx2MJsQOztSsssMIhEvji5EAzklMd6AV4wRUJLK1qQ
 bC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767121137; x=1767725937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMBrklVwDlDRPnbGYhl0T6Ag7Zr19aD1expN6irEiIg=;
 b=MWOwlNdEzbxLnhmtVw8v8p0rliNbNs6BIrPlO7bYfdDBc8q3krn7hciifeqxqI+W48
 XwbX39yFeu9viFB0lF+Ir9jAxxUmMioZ4+L0j484ISuhWQouiN+f/wwVIRLjuy8RfuqO
 6IBReV+6uOx5AFBHLQw1R4ODNxlWLd4UQNQUiKGiC0mhFAqC+NGIy6eCSx39psZPILH/
 BtgE5Cj/CQwSWRT2Tx3FFGTzwCgoh6QFm1QXTOhI9yalNyQ+CTuSMMMOosyocGHsxAlk
 ItFDynzIMFm88TM4N6g7Lrs9L9z1X0+YVPVaaSU4WJlfMydYqq1sMz+hjDZKWGiBMvkj
 fwwQ==
X-Gm-Message-State: AOJu0Yy2+lDdGQ9ynLhVdTs9Px3dNS/OYZs1HQvPJgKrL+QCJr96SJ8T
 A6EwuS0yEs+ibcSmRdmTs0xvperBknTIUyppsh80U2jSF/72M29hqOrsLgpkLlQkXqG3NoGpU2C
 uV5FpKRo=
X-Gm-Gg: AY/fxX5ibmyPc/XqokI77s2j8WiRtx6q0pnYSVXM1g5HO9Mvlm9MHVhTo1Eyx6KXhTb
 yUicJ8U81Vlgr4kJNCT615qFsYWJIn9GRoM8QAVTS4nMR1PeNGjMisCCfnoyi5KMz2XVuWc9k8y
 pWl5lZ1yv3WvukXRRyeNHCLQesRRyvBrZwCFbKwY1ZbJf2F/3NnMbFlpWfoao7hlc4yukoZcAHW
 DKfKODQf22CfrV9EmtUsIRgcSId5c9GRmopMRmI2BsmmyKcYkB3QeCb7aat7qUf8amw9GKMEdux
 URq9EKrQOq9JvjzIdnZ1SkuGvGHeKwRYmVOcL2FtcACJUfSslM7/MpOLnRxyUeq2hwDVy4hZvP9
 CiST1AXBojElioKEqoB5S8SAIB4yRxkoVqe7BIYc0VmYWNTStADHmAcDzwM/hT/OTL++WcMcbIB
 TZiTZnoZb5gHNQL8QWFv7ScAo78UfSjDwh3sfB0x+qtNiXO1QGyQ==
X-Google-Smtp-Source: AGHT+IH48S6SZb+y8WAG0fFP20GQrkEjJxe+TFlmBRygG+HXWuJpfkYThfpkOaa4C9qFX2m09kE9Rg==
X-Received: by 2002:a17:907:7ea2:b0:b80:2e49:692c with SMTP id
 a640c23a62f3a-b8036f112d1mr3134868666b.9.1767121137601; 
 Tue, 30 Dec 2025 10:58:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de0de1sm3745449366b.40.2025.12.30.10.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 10:58:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, gmuthukrishn@marvell.com,
 stable@dpdk.org
Subject: [PATCH v2 7/7] examples/fips_validation: avoid rte_memcpy() bug
Date: Tue, 30 Dec 2025 10:55:15 -0800
Message-ID: <20251230185837.301163-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230185837.301163-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
 <20251230185837.301163-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The code for copying example hash key values was calling rte_memcpy
but rte_memcpy is generating vector instruction that references
past the array.

In function ‘get_hash_oid’,
    inlined from ‘prepare_rsa_xform’ at ../examples/fips_validation/main.c:1607:12:
../examples/fips_validation/main.c:890:20: warning: array subscript ‘__m128i_u[0]’
  is partly outside array bounds of ‘uint8_t[15]’ {aka ‘unsigned char[15]’} [-Warray-bounds=]
  890 |                 id = id_sha1;
      |                 ~~~^~~~~~~~~
../examples/fips_validation/main.c: In function ‘prepare_rsa_xform’:
../examples/fips_validation/main.c:882:17: note: object ‘id_sha1’ of size 15
  882 |         uint8_t id_sha1[] = {0x30, 0x21, 0x30, 0x09, 0x06, 0x05,

Workaround is to replace rte_memcpy with memcpy.

Fixes: ae5ae3bf5996 ("examples/fips_validation: encode digest with hash OID")
Cc: gmuthukrishn@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/fips_validation/main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/examples/fips_validation/main.c b/examples/fips_validation/main.c
index f21826e9d7..daf273bc85 100644
--- a/examples/fips_validation/main.c
+++ b/examples/fips_validation/main.c
@@ -882,8 +882,8 @@ get_hash_oid(enum rte_crypto_auth_algorithm hash, uint8_t *buf)
 	uint8_t id_sha1[] = {0x30, 0x21, 0x30, 0x09, 0x06, 0x05,
 				0x2b, 0x0e, 0x03, 0x02, 0x1a, 0x05,
 				0x00, 0x04, 0x14};
-	uint8_t *id = NULL;
-	int id_len = 0;
+	const uint8_t *id;
+	size_t id_len;
 
 	switch (hash) {
 	case RTE_CRYPTO_AUTH_SHA1:
@@ -907,12 +907,10 @@ get_hash_oid(enum rte_crypto_auth_algorithm hash, uint8_t *buf)
 		id_len = sizeof(id_sha512);
 		break;
 	default:
-		id_len = -1;
-		break;
+		return -1;
 	}
 
-	if (id != NULL)
-		rte_memcpy(buf, id, id_len);
+	memcpy(buf, id, id_len);
 
 	return id_len;
 }
@@ -1614,8 +1612,8 @@ prepare_rsa_xform(struct rte_crypto_asym_xform *xform)
 			if (b_len) {
 				msg.len = env.digest_len + b_len;
 				msg.val = rte_zmalloc(NULL, msg.len, 0);
-				rte_memcpy(msg.val, b, b_len);
-				rte_memcpy(msg.val + b_len, env.digest, env.digest_len);
+				memcpy(msg.val, b, b_len);
+				memcpy(msg.val + b_len, env.digest, env.digest_len);
 				rte_free(env.digest);
 				env.digest = msg.val;
 				env.digest_len = msg.len;
-- 
2.51.0

