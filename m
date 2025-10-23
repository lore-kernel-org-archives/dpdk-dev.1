Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259B6CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 19:42:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54492402E1;
	Thu, 23 Oct 2025 21:42:42 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 00BD940144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 21:42:40 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7a2738daea2so1141157b3a.0
 for <dev@dpdk.org>; Thu, 23 Oct 2025 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761248560;
 x=1761853360; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PGV8O0G7FkIHi9yOSB6594xIfcZiB4CZgfqBxO4ltM=;
 b=22LvgjrNu3H9cE/KzHSnkCmagomhl/z+lcG/Gqak/Upqs0rVpelTpjbxMSot3iDLNb
 va/dTsVKiqsN95fv0pldHp41evCnVLvVMcuNY4oDxIh81FgLDZGL8pHKx75KfSXiFzsn
 r0ac6Ez4uHwe5QcVMMpCRzbeoa6QPrH9Cvu2p2CKVZdF0KhcPEbtgEgA/cl5vWCzZM6v
 3Aoo6ciCvIirm5QtkfnKk1qd1xlCsV6NJex+e3gGgNYM+i1ohHIlZ4ImpzKpHWRqWc+G
 i1HYILIS0+PAL0PqFGPVvyFXmMloql8H8qTyMwZ80klj7UBEi5DV4TztYuCOMtoBQcvL
 pRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761248560; x=1761853360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PGV8O0G7FkIHi9yOSB6594xIfcZiB4CZgfqBxO4ltM=;
 b=vrjMVaavpeWIKaADGYrARASNXaT5H0vBvBi6J8Gp3lrZdblC90ur7lFxiTIlTvlHSk
 vFW8q/V19a6v4Pvd46xgd/ZPcEv38If/LprrVfirk8tiqgZXbkCm1OKpJyRvV/mVGNfR
 6o5uk6NIzCFVKsoKNDtlTfqBHEP58gsF+mZYn7BDMFVO9dxwrrCl5w6lzT/RFmGMPlpn
 UDKGXmiBQmoo/dhUSRYaNrAxWNeLqufCdVR6NK8Y32zR69r6A7CFe/DaoDhxOvItc2Fz
 GmZVzvmMIkzyBcKpu25/Spjkx5RUrsvlG7uPXxLFhoMpjHCyhBFkP+GAymBaJ7wXasF7
 v9EA==
X-Gm-Message-State: AOJu0Yz3ojTzbe+KHbh2eYrx0H/xCr66Tij1yKxUE7VLMrXaPKY/Zp5g
 pyGq3TpVLe0CzaCCirxSau8+NPVFY9cuOhVKZQ8EBrOMA4nID8Nd/NY/AZUYcSyNrT8S2caDbXt
 RPxWW
X-Gm-Gg: ASbGncuPe5jUAw2m1X8KaM5o+QKCdICW9xR9HIZiJkYAJAV0jBvjKEVzMPiaPBKMINW
 a3wxnXLop/JjdWKszVoBBDBvbsWNpWHlOITMf2OCn6vBegijamAC6lk5IukRKNYVzQcGewiKFa2
 4JaXWA2VKbYLvJQiePO5wqgR9DWM6GpcG+DJ7ZhISrbblOAs9BXJCkqi0oz6glx0ya8ip+OGuZp
 au5q+YOPKkPxiWA990LWJh7PF2JAJimZG1Rs0/ux7aZgs4G5fOykMR9uPLgNT/jwSm5noZXv+vm
 /qh3ZVD/LZ4pf72cOmaVTm0h97IQSxdHHY3ZmEe/3R5SAPGw3YE/rc74d8w3y6xt49SLjE+06vv
 NcymU2XZ2uT9iqVRm7nG0hq4BuG72oXCGPd6YqWfX+PI1X2HdmtSVHCy13p5V7/ZniMVaZNBkYF
 oDeYPgpa1hyhwG0ZXmSXC+2tHgfV2nSd9g4QiwK+A=
X-Google-Smtp-Source: AGHT+IGjKcbpy80hSusTAxUKzrdWKcb7Z2SBQWD8b5guikpSXa0Mo0dhZ/GKlhCjENfju09E0W5rPg==
X-Received: by 2002:a05:6a20:5493:b0:250:429b:9e6d with SMTP id
 adf61e73a8af0-334a86142e1mr32219593637.44.1761248559994; 
 Thu, 23 Oct 2025 12:42:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6cf4e15a80sm2884768a12.22.2025.10.23.12.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 12:42:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [RFC 1/3] common/cnxk: replace variable length state array
Date: Thu, 23 Oct 2025 12:41:31 -0700
Message-ID: <20251023194237.197681-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023194237.197681-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
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

The cipher function is always called with in_len = 16
and there is an existing define for that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_aes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_aes.c b/drivers/common/cnxk/roc_aes.c
index d84feb546a..e51cf532d7 100644
--- a/drivers/common/cnxk/roc_aes.c
+++ b/drivers/common/cnxk/roc_aes.c
@@ -157,9 +157,10 @@ static void
 cipher(uint8_t *in, uint8_t *out, uint32_t *ks, uint32_t key_rounds, uint8_t in_len)
 {
 	uint8_t data_word_len = in_len / sizeof(uint32_t);
-	uint32_t state[data_word_len];
+	uint32_t state[AES_HASH_KEY_LEN / sizeof(uint32_t)];
 	unsigned int i, round;
 
+	RTE_ASSERT(data_word_len <= AES_HASH_KEY_LEN);
 	memcpy(state, in, sizeof(state));
 
 	/* AddRoundKey(state, w[0, Nb-1]) // See Sec. 5.1.4 */
-- 
2.51.0

