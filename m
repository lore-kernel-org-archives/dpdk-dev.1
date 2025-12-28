Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC05E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:17:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0A0C402E8;
	Sun, 28 Dec 2025 21:16:57 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 526FD402DD
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:16:56 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso69416985e9.3
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953016;
 x=1767557816; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYm8Z6S/nzTR3PcaRYVIwEnYkFljxkxobdVEqRbu4+g=;
 b=xxiSNO8+OGBcLYByt7m9YeXpZEcursWCM92FErctLGIvbVLdat9RJLgWPfraN5e6Sm
 uwqyF00oqjrDCMU+B8bzk2rT1eRR8KAYAnG1RQvL1zZu48J618IucrVhUWj33Q0anMBT
 C8uVdZ+zMdpEi4iDo0QjcioGLtJFok4sV/JAIFfk8wsVSzF7MHxSuNVS532Tcxx8Mebz
 PVMiXwqmzVMjRlYfRFVwJ1u3aeAQVLCZRqcFAHLIMB0P1tRaFMzR30++pE4ebU1mQdt0
 1lxcf7/kiMgDqajBafnsCaOwR6AyZ1PGJISzKa5IYFODABb6qpttyWtijRhvMMDokbx8
 T0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953016; x=1767557816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VYm8Z6S/nzTR3PcaRYVIwEnYkFljxkxobdVEqRbu4+g=;
 b=VSotrRlw+9DnYeqcTTDcRUoTJZE/JDwNe/GkUh7OZia/nBaaopP0NmyYoc+leVgOmO
 Lq7+HfEMbx/5nKnzxtFOqYsLjcgmjoOeEdzl6ics2ZLkzIku4wLYL3Ep3ATI3gvd1qAQ
 jh7NGSYDhd08Lk+VM0D1ZG/eFesAJDSYEZLuVc/qlgCdzqCoz2alQc5WxNHxlRgTcdrB
 5AnEqnX0IosoI2tARoO+mk+48KYGJCjOMpw1UNPMSxX7BatzRsh+DU5lX1nYKNxQojWr
 cZxX2BVuFvkssxfatAPLchddczdD5DNpAw4L5XYK93f07uKlydirD93x/wnPIPybawDl
 AoWA==
X-Gm-Message-State: AOJu0Yyxp8zc1WKqAGRTk8RDvUgTnyvMZFXss5o7AGX6lH6ALad98Wjj
 FPp5cYdvOxMBhZzou4McfGxzcVrrjs3QsDT0mh/yfXwUx5UQThZIgqoxqsO2j+j5cE6nA2gBftJ
 Pi4lvGqM=
X-Gm-Gg: AY/fxX5oSrVamlaXbmZEymmVc0t/9SSat+GCHMfn4bsCxzyDxt+lRkZOqw+wGu8RBo4
 wSTIeHYjjx9asUpvrC0UA2ISU1gUEfOL3sg8KxLv76nOqletwy+Xuw2KBp2uN/J8Wif9YQN/0RE
 SLzx0B7I2OiILRwI1B+4wwYXh/P6gK+2NsrKIHZtQUBoYtDUR6b4N3Efr90eT/yJDsL8Q+PnuWC
 jX59B1pOACl67ZPdaq+4GJhvxLJgRRJDTfuR8/j5msV7iaXwvjp2HwRenLRQCziqJr3FwMQQs8X
 lEuvy4NtLNjrthUeO9rTbzA/T/4e4E21WJU6ZWN3+8UQc96z/CnIh3lKAw64fmE31Nh/Bbos+Nw
 Y0Gn03YP7tBPD+A8PIEnv/eFcy7/6ItJqulGc+tj44srID8AGg0xslW/xypuPSUd/FSAo/ABR0B
 V0H0Gm6aRGItsSnTodZkuqqUOPRC2ux8sAxB7K4Pe0mozj4m/cPQ==
X-Google-Smtp-Source: AGHT+IE6HBgvcDsRuhw8k0+NXMQ3hvE+Gzoe90sYF7G+xDdxgu358lxH7h12yXHMfHVVuV8C22fO4Q==
X-Received: by 2002:a05:600c:1d29:b0:477:df3:1453 with SMTP id
 5b1f17b1804b1-47d195a06abmr328426405e9.28.1766953015884; 
 Sun, 28 Dec 2025 12:16:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a6c9d4sm226286005e9.3.2025.12.28.12.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:16:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 1/4] checkpatches: warn if perror is used
Date: Sun, 28 Dec 2025 12:10:50 -0800
Message-ID: <20251228201649.555898-2-stephen@networkplumber.org>
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

The function perror is another way to print to stderr, which
should be discouraged in drivers and libraries.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 9a8199659f..1c6099ac82 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -73,7 +73,7 @@ check_forbidden_additions() { # <patch>
 
 	# no output on stdout or stderr
 	awk -v FOLDERS="lib drivers" \
-		-v EXPRESSIONS="\\\<printf\\\> \\\<fprintf\\\(stdout, \\\<fprintf\\\(stderr," \
+		-v EXPRESSIONS="perror\\\( \\\<printf\\\> \\\<fprintf\\\(stdout, \\\<fprintf\\\(stderr," \
 		-v RET_ON_FAIL=1 \
 		-v MESSAGE='Writing to stdout or stderr' \
 		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
-- 
2.51.0

