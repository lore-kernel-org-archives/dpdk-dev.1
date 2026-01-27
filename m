Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3795D340A4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8EE840EE1;
	Tue, 27 Jan 2026 17:33:16 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 5407840EDF
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:15 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso3684292f8f.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531595;
 x=1770136395; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXd3lefCqyeFmUQKQKVEzn7YKBdodMhP4sBYPSV8wck=;
 b=NKsyzzsXJ+28hEw9eXStGoU1Sp+QSaQz6or0CmlARo7S1nY1WM1IB02RCC83RUb/NZ
 LTXi1lp0LSNnc04xm+jYwsmKJhNQhLYxFngMU6PmaQM2aUrL8szX6BHG5TEaQUDRc1Y4
 yiRCBnrgVEKK7LrWsWdZMlKKB2ZIVVGoCusA8fqS9EkVvCGct2jh6R4qhZBUmRjYtmsI
 Djbna4ShXMyucBPJ3qPwz1xwCjNOFZ9VmY/5v5dQtDwJu1sMZ67ubHFy7K8Ymu5FoQpy
 YofOSaFl1Mjo/RpQKDJYUVdir6dLUIV1oY5uHnw490HDW1wRMhIQFFpkJZJPk8l1kkOM
 DBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531595; x=1770136395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CXd3lefCqyeFmUQKQKVEzn7YKBdodMhP4sBYPSV8wck=;
 b=SvEXDb/r/rqV5VW9ek2RGIG1eKPgWEmVx8TAlA7/f2uWiOhtF6DsoCfc1zcoGPCf2r
 OTkIcIfjqDOT2nKUU7E38G2GdsdwJ/ah8XICEOU/vNA32BELnc/LJCjQg7eniMLNzClA
 b14FL1gjwLRNQTvO3HP94o++rkY9nnAX1b+JjCs6Vwpo0b2y+AajIbuVV216e4aUmTMs
 IZv1A4/UwRaRdi2kwv3ntpNiEzrg6X9JkiXRR1VaRUKKouOiU9To34zNiQaAjLPMCbAJ
 IGOIFLbFrcksAcpxdqTQeEKF4sWHQRWx5BEf9YkYDzO0OpGRx4JszRCCsPDeDcm+5ApC
 lI0g==
X-Gm-Message-State: AOJu0YwS/bCsyi8llnoIfrQ3UKQuGnk1CY8sb7RnNf8+lanvmON5EOUB
 2EEc1SmhuCstqHhRpkgRi48hekdr9GnD1Ev5aVT4UvSmMMT6odeFf3u3ts8TeBqTzrRPh5iXLQq
 h6uLR
X-Gm-Gg: AZuq6aLjtMnKE4p8RsDwU94qtdmwQYLG6ZH5gIs29U8AgjHtpI94hvFUZF8nxG6g2t9
 DwK11WliuGg0ZLhtSpIHoSSSywWbS6dmFxqIaioCG+9UwfPg3YTfC6Xotiao9xKhln7pQdWqTGJ
 qAOGRfRbfa+Ifr+rYxbB7JvyfcoutGN3eWhRq3RJQZMCksoGzf5zCkQW0AflSd9PNHt2Fyfo2Ce
 2fsavQK3QV08N00nL6dvgjMD6CuS7fa8bU5Pa6vnAnjQCLiwMHf1idLDyAzV/jD92ghHps3342T
 BcQDFMQgAYa9dO+UB8ghz9y16BbEeMZoT5Eufy5vshtJeqwrh0OjR71rW01J++vLIvZlDJS22Fr
 m9YfCHzlaagcyQNLEEbIhaOupv/GSxibSO36YUlhNxOoyYdYYf70mA/i3p5dnGpx3SqDCx0DkSM
 QKkcq7kN5Tz4SaNiE92yiPdFpXxfyn/rSwZzBdR6XgQ1rq9QO3yQ==
X-Received: by 2002:a05:6000:2c01:b0:42b:3b55:8929 with SMTP id
 ffacd0b85a97d-435dd05be6emr3679067f8f.19.1769531594743; 
 Tue, 27 Jan 2026 08:33:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v13 05/17] telemetry: check for path overflow
Date: Tue, 27 Jan 2026 08:30:19 -0800
Message-ID: <20260127163258.75566-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

The unix domain socket path is limited, check for overflow.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/telemetry/telemetry_legacy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/telemetry/telemetry_legacy.c b/lib/telemetry/telemetry_legacy.c
index 89ec750c09..1d73282ba8 100644
--- a/lib/telemetry/telemetry_legacy.c
+++ b/lib/telemetry/telemetry_legacy.c
@@ -102,14 +102,17 @@ register_client(const char *cmd __rte_unused, const char *params,
 		return -1;
 	}
 	*strchr(data, '\"') = 0;
+	addrs.sun_family = AF_UNIX;
+	if (strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path)) >= sizeof(addrs.sun_path)) {
+		fprintf(stderr, "Client path too long\n");
+		return -1;
+	}
 
 	fd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
 	if (fd < 0) {
 		perror("Failed to open socket");
 		return -1;
 	}
-	addrs.sun_family = AF_UNIX;
-	strlcpy(addrs.sun_path, data, sizeof(addrs.sun_path));
 
 	if (connect(fd, (struct sockaddr *)&addrs, sizeof(addrs)) == -1) {
 		perror("\nClient connection error\n");
-- 
2.51.0

