Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520BBCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 22:28:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79CC340667;
	Wed,  5 Nov 2025 23:28:32 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 5351E402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 23:28:31 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-340bcc92c7dso1515509a91.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 14:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762381710;
 x=1762986510; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Y3st0c+hrJJcrHo5yTAAVx8VkZcdWVEjnA2Okzxa+k=;
 b=NiiIp3ezzL4MveHJlYiEW6a970Ql+Q4p3S2vqcV9mFgId8mo4P+/2slsd/4edHVa3+
 UHQlrioeeysZhlbLLE6oIuNKAIcd1D9srSCJelU+HYG1yP05SchDEQoIcvSINcvdorQr
 gkEruV6pNQgNix1mHg8glzKPruoT9aMmGmqV3GDaiQsPeDcNsbfyxBTK85oiw3lM6xEg
 +rvx9dtwfJHKLZJD+Xv5fQX+H5icd8pMs1+qvY5kzuBbeJyVtJJflnBjOY528MaV3QHJ
 x1gy8zXcRqJWBedncpRPyty/ThcE13TPMC0vrxAjqeU03Gdm9qhG7jbl/r1FVdBMzyI7
 vq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762381710; x=1762986510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Y3st0c+hrJJcrHo5yTAAVx8VkZcdWVEjnA2Okzxa+k=;
 b=UbpTzPaajY1VQf8W9KdfJEj7N1fjx8wn6a+DU+GcKWIujnYaE6NQLosQYKCtCRxjSK
 bArqo9iPSsI5rHfg0npv+VqPSqybgnHVtgxW4E2lUC7bOrv/X1SkgC3xnAP6GFjUBiV7
 qlK+nlQBpDdg69Y51thgzCTVniRr4kpRSGXUm3Y4ZdqL51dKW9v93IA8DAJpn44IWZ0q
 6kqo57pvRZAjgtDxtnEULL6WIbqBkDqi3OcTLHrqaCQmWxw+ij8Hodltk4mbhFprBCg4
 dE9AQmlq0F+79kyIK93eTvPy/yeU1W3Yi0cd9tguTasZEnyk4+7ZZreQZ7PUssbiXaGb
 lPqg==
X-Gm-Message-State: AOJu0YyuEgFDJd7K206jm3MUsC9mXWDWs4q68b+CkxOaRamyfB3Q3Q8L
 ReX4oLRL2zw14XVEIk2PqQ3nILq3N6xcmZq+d/q69dhe+kPArLr12UTJkYe3DfcgZQs0g9czrkQ
 cJvGu
X-Gm-Gg: ASbGncsiuRHHnPjCYEiX1YKmCCb9GMewvsrCrZyFkr8h+egRb8LaxWCZwx61sASLr8z
 3DI26xNu2d/6NajoeQNJU5vskag0Y9Qx+P0NdqQVwyG0jWMk+5FNYTO78fQnSm/8jJXIw5dGHkG
 Hh7A2xBWqji7KksMAZMhD3PECsVDaN67wRP0vLHKFC9HY/lPV2nhrieLkl+PkzSvMAH36b1KvQw
 wbsOnQDIuZ6kqmx03xMXZd759lBnnXxbLoNHtDA1TIidYbs6Cd5nD0aYXMUpHi5C1IIyBIBaGoC
 u/ekmYYLz5stZZafAriYxZEv7Uqac/BjxX8fV6FabL1TAQFgLPZABmfb005r8QwCh6D7YjHJhbH
 0cfJ5FRb75VYDeLvnIz1J8ificP8VO+nW5D/8D/dfzO5dkc7VYI7rrGnCePOUo03HUdSH1DRAai
 RnQ/Ogi1POxF3v4E+2pY2IxBrRGHE+g2ATBGJ2+mM=
X-Google-Smtp-Source: AGHT+IF9eQXQ+zJxhGrDA+QGTbP2jOybwtQY7LtAf7fbZEVwMSmHlpHwCwj35uwpF5T9gxf2XeaHmA==
X-Received: by 2002:a17:90b:3508:b0:340:68ee:ae5e with SMTP id
 98e67ed59e1d1-341cd0b6333mr1317699a91.4.1762381710286; 
 Wed, 05 Nov 2025 14:28:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341d05bf07dsm238788a91.18.2025.11.05.14.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 14:28:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] check-spdk: check that tag is on first line
Date: Wed,  5 Nov 2025 14:28:10 -0800
Message-ID: <20251105222827.904627-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031142018.49319-1-thomas@monjalon.net>
References: <20251031142018.49319-1-thomas@monjalon.net>
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

For C files the tag needs to be on the first line.
Add a check for that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/check-spdx-tag.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/devtools/check-spdx-tag.sh b/devtools/check-spdx-tag.sh
index 984825026e..cbb6cd3a8d 100755
--- a/devtools/check-spdx-tag.sh
+++ b/devtools/check-spdx-tag.sh
@@ -67,6 +67,17 @@ check_boilerplate() {
     $quiet || cat $tmpfile
 }
 
+check_firstline() {
+    if $verbose ; then
+	echo "Files with license text not on first line"
+	echo "-----------------------------------------"
+    fi
+    git grep -n SPDX-License-Identifier -- '*.[ch]' | awk -F: '$2 != 1 { print $1}' >$tmpfile
+
+    not_first=$(wc -l < $tmpfile)
+    $quiet || cat $tmpfile
+}
+
 while getopts qvh ARG ; do
 	case $ARG in
 		q ) quiet=true ;;
@@ -89,5 +100,8 @@ $verbose && echo
 check_boilerplate
 $verbose && echo
 
-echo "total: $missing_spdx missing SPDX, $wrong_license license errors, $warnings warnings"
+check_firstline
+$verbose && echo
+
+echo "total: $missing_spdx missing SPDX, $not_first not on first line, $wrong_license license errors, $warnings warnings"
 exit $((missing_spdx + wrong_license))
-- 
2.51.0

