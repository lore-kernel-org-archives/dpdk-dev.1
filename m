Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DBBC021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:58:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A938A40A67;
	Thu, 20 Feb 2025 17:57:22 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id D1F274067B
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:16 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fc0bd358ccso2443470a91.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070636;
 x=1740675436; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSpVszLkGKZLFlBSiV4S1b0oZK9eCr0ep8q2Ibv3gXo=;
 b=UvG5IVP5s6ZQ3rO643FAqPHYB1ksu3rJSyDOdbjXTyd04urTMPxN2SAEoUPV+b9UAv
 N6hiA3jqrMvlUniHdvNmAdKkl2GH9FiX5VmsSO04V47gOyfuXRbIhrXrSSg3HTG4g4p4
 JnQ1UfvRnfU9UDlQSBpn/yw3F3vdqRPv/D4Z64HnC8fyhFwJm28gA/pBdPdULU9wwpzk
 jR6VBdg2kbB9Zp8N/Z/mCFEzHae4UgFbA0/xN4fPLbDavanMZZGXAQQqLNlkgkAwO+cp
 eILO0Jsre+i/4+8cYesh8pBDPRt5JrMh0YriHUTeqsXCNhY2igP7rXVbS8LkSeGvslLK
 kYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070636; x=1740675436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSpVszLkGKZLFlBSiV4S1b0oZK9eCr0ep8q2Ibv3gXo=;
 b=ghEPf8quLdtVWkgy9agxWOKlysakJlPHZHQ8bv7s8y0ZcbB0GzeJQDGAdq+LiYSckZ
 bdHpbFBaJjp5HnoroNreGyo8J2CLMihU9ce2sVVCVyjhJsossN8fUKFxxa4hMhCGYNh/
 iluXU6oiQ/H7zvnxVOfECPRE312XhcYpwtrp9dYgKxNiyH1BWCYyDTLY8iZ827x1yKte
 nCp09Xg51FhaKjEMBoUbIg5z7Vpf+XECLxJNicevgImaVOkTBbjEiXO2TW4q2e/I0+Pr
 JlMJGVwyiqP+r0wGvLdHPQvyO0sm31Tdn3RJtxquDjC0n+dc7CfPPhzVP2SjchAArwkm
 nJpA==
X-Gm-Message-State: AOJu0YwIc0yMFHBfPplqVA3PYnDVDZsWr8tXO5QVS1wpa6z3Peny4PAq
 ii6bpqTwDNCzQpMPjtdmuElrBFPdKw6MXUgwQVDlK8zPed2m1RoybzHFdqbg8ah57P1fBNNJjes
 0
X-Gm-Gg: ASbGncuwKkMRyQa044WWsSqmAx7dNRjqDROu7DguHVGi+JX2s1HUWf3lh4sA9C04iAc
 ltRA5x/IZlyYzF4JcTBR7Rk3VVEbrxujRsM+MdeC/iMwQeUCltp3FA8lCg72mc2jqQYLxunJdZr
 Ylc3TAj5C3XdEyBjcVQEDmA7qiUNnvSJ1Sr2zGNtYU5i+uhgYdWNmn8OeYKwi0mD9WfB95F61VD
 J6mUKmXZFm6eam4yGUJbP94IJUp6F2ZhDIU1yYLZ3CE24e10/2xxpCJyyl+sO0PGshpR9v2p24W
 77xHQrRogOvbY4KelSev0dOYTdKQxsPBInM2NUJ2vRscU8/za4GeQWt3fO17pj5SvkDd
X-Google-Smtp-Source: AGHT+IFierEfO0HBP6ukWrQkK9ip970pslN4rxTqEcII5hpdNJ+7OB9iOna8g/qEkH4iFHD2h5WOmg==
X-Received: by 2002:a17:90b:4d8b:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2fc40f0ecb4mr41846468a91.12.1740070636042; 
 Thu, 20 Feb 2025 08:57:16 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v3 14/14] security: remove unnecessary dereference
Date: Thu, 20 Feb 2025 08:55:28 -0800
Message-ID: <20250220165644.16421-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
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

The expressions *instance->ops->set_pkt_metadata and
instance->ops->set_pkt_metadata are equivalent in C.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/security/rte_security.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/security/rte_security.c b/lib/security/rte_security.c
index e5c862f5f5..1e980343fe 100644
--- a/lib/security/rte_security.c
+++ b/lib/security/rte_security.c
@@ -258,10 +258,9 @@ __rte_security_set_pkt_metadata(void *ctx, void *sess, struct rte_mbuf *m, void
 	RTE_PTR_OR_ERR_RET(instance, -EINVAL);
 	RTE_PTR_OR_ERR_RET(instance->ops, -EINVAL);
 #endif
-	if (*instance->ops->set_pkt_metadata == NULL)
+	if (instance->ops->set_pkt_metadata == NULL)
 		return -ENOTSUP;
-	return instance->ops->set_pkt_metadata(instance->device,
-					       sess, m, params);
+	return instance->ops->set_pkt_metadata(instance->device, sess, m, params);
 }
 
 const struct rte_security_capability *
-- 
2.47.2

