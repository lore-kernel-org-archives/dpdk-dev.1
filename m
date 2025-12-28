Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE9DD3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:17:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6B0240656;
	Sun, 28 Dec 2025 21:17:03 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 0325B40611
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:17:01 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so45526475e9.1
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953021;
 x=1767557821; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNwriemO45kRzhvnG/3exzlfe6K4SY6kJRkxe0GwPwE=;
 b=SultJ4rDj7a3DqznpYlHj/EWirq8FaL48JI0PrJqu19NnmFepKhisqvqyI7fdlr8BM
 LMWDcjX1EjSRTxXoupJ78gS8k9yXRUJoYZ+LATBkj+cYq5FCcYX5t21n/bs5qQ6cUP0o
 Ib7fbfwMbrJmc/XbM3egAk6bd9obBp+V55977nzJ9lWPXp01Nwh2kFCGW3TsRJGOXT43
 glopcucozm347VBOkLcQ6NEjG5qaU6/0V1Gn0yXvHqdDFSwIwpP+hm5AeL+o4qz4/IbX
 vWmEwIDLEl8x+z2bnnhFdwsSL+CU2ihd7kts1C6mUcUlUTMjsjQfnExsQcZHcCv8KE1W
 690g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953021; x=1767557821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kNwriemO45kRzhvnG/3exzlfe6K4SY6kJRkxe0GwPwE=;
 b=BE0wWDxzxdw22eOvlMLmPelADpGnyoZT8aitFdJcQkBVVECPb1T2h4BLqxXUKNr7pU
 4cOqBBBVB1TdVcpKrsSrkcVFU3J4rsoeaQ84hXE0Tuf+zxbJIs1jSg1MbIXMWVuJ5k7B
 2ERYyjuAgbyUHTu5VL95uIW8LYw3no0knW1q2xRO9IZuLoXJ4ZsLx1l0L6zoCKhmE4QX
 OgheqqOTrY/KOcOkhopYxPn4lfOslKNVN0S5pzOFeTISlHAnA8qTkdLNRj6taY8CxIRH
 +bWD8AnFf1Fjv5VpytGuUsY0+DnpMl+kKNpSCoUkWzgh8pW6g3nqc7dV74yk1sXfzSV3
 FD/w==
X-Gm-Message-State: AOJu0YyZ3MBdT3Ka/d2BoJnDHYATRpAjV0UJYiUlchlwRTZAwdnpGs9t
 xfMbHO/fIJGc1F4Pn530k3EHNglRppLBsim7e+JA+PF++11TeYPlnPBx3Qth0bP9di70EPCRTgV
 +rrFQl4s=
X-Gm-Gg: AY/fxX5XW2O1uuO320ad7+VI/sbUtGguQwdVEOQo/TLTc00+N0zH++RzXdY6/fb0aHz
 l9u7KAeWk9Cw0l92lUEiz1/k39iCWn08uCemM9Ia0pkWmz1ubCp5KOTti8tqQ10tlY4ZJTpx1Fu
 puz67Qd7ONpoKHN/8uaLCoJxWMIu0Vwe381NsWEV/MtOmQQdzg/2PTQNrbWXN/9d+8ofjYeaFq9
 FGoNgbjAhLEeuXIZHr1Je1afe7pyUMaEhVaUYM0mRtpBJuT/KL6RrvRcqObZGcHUDAn5aQvatEw
 ELjrIVPtiz7bHgfXWv5vMxNDjC2RIcWwpPUfWTxI4cqxJGrsxdtKbNUhMuJixZJybJpXdAaCZXR
 3ZaAkBDA03t2kEY0sSfOqOlDW3rGWvfwHPjTmUX0uuqA++3gsJ36WqemWt9GXvNIwPBfEh46M4e
 ehu4eqTotFqwL1FWZQVJyZFjmn2T8tXZqpDnZwpuRDBs7ry3DtHA==
X-Google-Smtp-Source: AGHT+IErQdA5HdT0q+UUVUbOWdxxQ/Y3VEim0hEaE7j2mo4yTn0w4crrNmY4sv0AAHaOqU2sB461uA==
X-Received: by 2002:a05:600c:4fc6:b0:477:7b16:5fa6 with SMTP id
 5b1f17b1804b1-47d1953b3bemr304151185e9.3.1766953021506; 
 Sun, 28 Dec 2025 12:17:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a6c9d4sm226286005e9.3.2025.12.28.12.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:17:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 4/4] common/dpaax: replace use of perror with log
Date: Sun, 28 Dec 2025 12:10:53 -0800
Message-ID: <20251228201649.555898-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201649.555898-1-stephen@networkplumber.org>
References: <20251228201649.555898-1-stephen@networkplumber.org>
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

Use log functions instead of perror.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/dpaax/dpaa_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/dpaax/dpaa_of.c b/drivers/common/dpaax/dpaa_of.c
index 23035f530d..d44c893bb4 100644
--- a/drivers/common/dpaax/dpaa_of.c
+++ b/drivers/common/dpaax/dpaa_of.c
@@ -117,7 +117,7 @@ iterate_dir(struct dirent **d, int num, struct dt_dir *dt)
 		case DT_DIR:
 			subdir = malloc(sizeof(*subdir));
 			if (!subdir) {
-				perror("malloc");
+				DPAAX_LOG(ERR, "malloc failed");
 				return -ENOMEM;
 			}
 			strlcpy(subdir->node.node.name, d[loop]->d_name,
-- 
2.51.0

