Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABDEC982C3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:31:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93D9F42EDA;
	Fri, 16 Jan 2026 22:31:10 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 713BA42EB7
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:31:09 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so1857404f8f.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768599069;
 x=1769203869; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DLZfJO7a+9BXdWXOB4N+x8tNNMQ1aNaCrNKUkbeclQ=;
 b=VotDkQ3EMbFK4L7fw/XGD47DAE5wufnpZABdN750r9NNG3ExxwZZrDfToI1E/B7Unz
 I0Bzxv3WwsYAHH8TigN9jsM3wKTE+07++Jzf5h4wNI8C3vU/3fQoMA0/65G3BTXaIk5L
 UpLZI/LHQRqDSpiy2angtG+AqGaIzjxY9ZKYy5LR77GPSAw+y9ZgRiJhFD9stM6bSkjr
 0sHAzManA4ROf+2ntMi1J5/ydQeXk4MV94cUZr0D1tUTyZTmzcGi6xqSh+wwzm1hK5xO
 R/f2P3PXOwX00M4Tce8wrZtZDQJfS6Hdj983bcqjK30JFtmMv+kBzhEBcOjhPSxfCouM
 PBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768599069; x=1769203869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6DLZfJO7a+9BXdWXOB4N+x8tNNMQ1aNaCrNKUkbeclQ=;
 b=FUZVU0AILjldjpYlmcTitzYZms+SaexahmBua0m26gjsBnlA6ducL/PgkEPEYELSHe
 B/Y+G/JD+v5K9fVRYiy66nFpwKri1THm4ZkKn2AZ/bEICcXcivNppTYfTGgysZB64QjB
 xWez6SoeA1wU2ePmhIlmTcMCvYX2J3fJnervb1Qw1AI3LfialfKZblbzhg9WuWgTkoU6
 KWFM2fKW1B03uaM065S7bddFnif2mUHLSlfjqKI+mynAceW0ASa6RpwcIoMY1r+vFIei
 Ka1T9hQxXb7xDq0IpDJsLUCyuY8oc1ZRcdHvmi1hCfTYJNaGbsJY/Q2Fpf7BFL6/CW5+
 2iGA==
X-Gm-Message-State: AOJu0YxYbCnFFH1cCQL/iQCuOcyN1ZIvlmR9CF4J8Odi8pT/X6rBQTv6
 MDoAXmBGCwNdbsVewF6YyDo+fCPARqlgxf0wW43ibrMq5HyI2eaJ4jogCU615hh9bX9nkySOyOZ
 hK0NE
X-Gm-Gg: AY/fxX4Sux8dFHGEeA4v88SOOcch8XqZlFYxYos2ZQwjAAiJqFvyD1/+46LCfljzbVw
 p6Sl/BTCL3AjvXSLV+8MKip5wwSF2xgpF0D/qhV/icMOWF+N5sEQZFJuLtEI6y+Pp7offquMmgC
 4p362kQJ19GVf/7TP8dB7w2soQsyD8u95BT8LtGm5WxKIYiqI7/lwjbRPUp5kZX6yf9ryDGMv+t
 Y2LAcmx6aTHePPMp9WsMaJ6M8BqMq8Zhdq5u27dO2iTNYIuAo38gjzXvn5W1y5oFgT5fTO38wcp
 ZRDVdEeRk4U834DO0WUAotTSPYK1/n1Zk86TwZuMV2eWi0HGzmEgJTDrzCya2AX7icu7us5NifE
 jH0rTYmLMOIk6jl08EStDSwvqra1e+HbZAWVqmmyctwZaVRxyEXFzSwvIQqR907KxDZByr0c73m
 ARTFG6ZFbgnFqOw+vl/hysB1lJutXkTZtuei7s9hCtZSzJdj/WEA==
X-Received: by 2002:a05:6000:4021:b0:432:c0e6:cfda with SMTP id
 ffacd0b85a97d-4356996f134mr4324034f8f.7.1768599069036; 
 Fri, 16 Jan 2026 13:31:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996e2d8sm7398759f8f.28.2026.01.16.13.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:31:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>
Subject: [PATCH 2/5] doc: correct grammar in rte_flow guide
Date: Fri, 16 Jan 2026 13:29:33 -0800
Message-ID: <20260116213100.110419-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116213100.110419-1-stephen@networkplumber.org>
References: <20260116213100.110419-1-stephen@networkplumber.org>
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

Remove duplicate article "an" in phrase "a single an item".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ethdev/flow_offload.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/ethdev/flow_offload.rst b/doc/guides/prog_guide/ethdev/flow_offload.rst
index 1cd904e1ee..d51926a47c 100644
--- a/doc/guides/prog_guide/ethdev/flow_offload.rst
+++ b/doc/guides/prog_guide/ethdev/flow_offload.rst
@@ -109,7 +109,7 @@ However, ``rte_eth_dev_configure()`` may fail if any rules remain,
 so the application must flush them before attempting a reconfiguration.
 Keeping may be unsupported for some types of rule items and actions,
 as well as depending on the value of flow attributes transfer bit.
-A combination of a single an item or action type
+A combination of a single item or action type
 and a value of the transfer bit is called a rule feature.
 For example: a COUNT action with the transfer bit set.
 To test if rules with a particular feature are kept, the application must try
-- 
2.51.0

