Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB41C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 Aug 2025 13:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC96B40E17;
	Tue,  5 Aug 2025 15:23:26 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 882B840E15
 for <dev@dpdk.org>; Tue,  5 Aug 2025 15:23:25 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-76bc5e68d96so4555256b3a.3
 for <dev@dpdk.org>; Tue, 05 Aug 2025 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754400205;
 x=1755005005; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2UxOC/mUCoKcC7CWr4shFwhDbxbIBYmx3D4YgKE0q4U=;
 b=jA244cgbpd2B/vJhAjN+0PT/+Af0NyXX1Kw0Yc8Y/2D2jsynD6yBJopx6/6ysvxuwW
 KjN4AwlGxip+C49zplRzIYwWikXpE9Es6aHMBr7vgjVA4id0dOqB2KDtv1yS92oCYOcl
 wdiQNVHYNuGBe3lXRzSPmjR9XO+POfDRBNg7ld1GAeXitLN9QZ/nmJZiSf8Z1OzWr4Fr
 3U9Acau/5twFuA5J6hJFuoBLDy2Vd6FDSJx0cJ/t63BvZryPIeA2Yatw8SxPlmOLcWFJ
 yj7S41v8YPLe0HFvT50+5FLDQduixQEqKGA8aWFPzB7MuG807eLm5lwtNVah3SBdBHKy
 FzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754400205; x=1755005005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2UxOC/mUCoKcC7CWr4shFwhDbxbIBYmx3D4YgKE0q4U=;
 b=r3KxYWy2yjpb7iqquM4MRk6NgpuXua1KkZAww6HZ88wZbky+eilERkEbI5OHPXfNs5
 dSFq4aeWr0G4cdVWEf54Pk8Vt4AnQ0Mncdlrkj+IoWLpM7xmXHdzgHC0x+zb57nb4V/A
 qSlCopEm/2Fub20z/ReLO1zglBsaW+RlaggOLwCBOg4o064DgeEVO+DP1NYHfg8yyYLP
 lM2bWnCO7J9M9hbKYWp3dMiDVv7o3jPiaJahVVDZYw2EFQr4HeBKlraBxnJKjPglI3A4
 p7BB6qH/7cvX4Ms64fhwdZjNeIh3QZuYFY1TXEN/VnKn0ZSuSaVH9qLTwvnFcp6N4XPj
 rcpQ==
X-Gm-Message-State: AOJu0Yy3hdqBWOXvS1FdP0X5yJ69lx4xFkRsmhQtLeZb6AzYFL0JH91B
 vgU2t284nUTq9mEDTwcTpSyPH29j3AmBh1t6kdzGJBr5BCh3q6nAbwq6QS4y0RaPNYw=
X-Gm-Gg: ASbGncv87o1XnVC6bxM+nDuHb/dgTKYio0/OlmHpjAl0MjNV4zP/FCgkQ4GUGGCpG1o
 bHzMZSlWhv8KF/xhWzHBDmGTisO/b8qC4eg4FkrfXnajt1q6S+hprjX8Xhu7+kTNudOUkMEM78Y
 DVRRrPbjEbBaNyvYGiiBmCyDuvHyWzwoHhpN8Y8u8Gu4QKN5pmbSqGJVGXjwCF6KXCFUuLgD5TD
 iJUxhKaWABdNz4qd1F6IKQLBGzYyLcR5ETIEZ/NxdIzxDT3KsLvJdoNesmwoNRKilOPJGvLneUk
 PoiJ1L24rvzg5rM+g9dTUJcHGK8sZfIQqz+EddWxyz8AiffvCGCGSLUX2yi6I5qfRdDHcWXCb2v
 i6kFz3oI5+fLDe+lCzq4MGsyYdburMMkJRRL99Pa5s1at4J+o
X-Google-Smtp-Source: AGHT+IEZxJpADhL0aIfYE8yGjO5LiPueLyLZWs5snH8yDt2h58bIPA46yjmJ/PaO2/7pdfGokCOvDA==
X-Received: by 2002:a05:6a00:3d0f:b0:732:2484:e0ce with SMTP id
 d2e1a72fcca58-76bec4c537amr16142528b3a.17.1754400204594; 
 Tue, 05 Aug 2025 06:23:24 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd9b3b3d4sm11324659b3a.10.2025.08.05.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 06:23:24 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] net/mlx5: fix connection tracking state item validation
Date: Tue,  5 Aug 2025 09:23:17 -0400
Message-ID: <20250805132318.480413-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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

This patch validate a connection tracking state when matching
'conntrack is' in rte_flow rules. The conntract possible CT states
are SYN_RECV, ESTABLISHED, FIN_WAIT, CLOSE_WAIT, LAST_ACK and
TIME_WAIT. Therefore the maximum possible value to match on
in rte_flow is TIME_WAIT but mlx5 allowed matching on any values.

This patch validate the CT state item.
Fixes: aca19061e4b9 ('net/mlx5: validate connection tracking item')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 7b9e5018b8..750385cd42 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -3290,6 +3290,11 @@ mlx5_flow_dv_validate_item_aso_ct(struct rte_eth_dev *dev,
 						  NULL,
 						  "Conflict status bits");
 	}
+	if (spec->flags > RTE_FLOW_CONNTRACK_STATE_TIME_WAIT)
+		return rte_flow_error_set(error, EINVAL,
+					RTE_FLOW_ERROR_TYPE_ITEM,
+					NULL,
+					"Invalid CT state matching \n");
 	/* State change also needs to be considered. */
 	*item_flags |= MLX5_FLOW_LAYER_ASO_CT;
 	return 0;
-- 
2.43.0

