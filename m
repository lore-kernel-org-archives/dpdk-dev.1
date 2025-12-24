Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9C7E78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47499409FA;
	Wed, 24 Dec 2025 23:13:47 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 0A0D14068A
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:46 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so236694f8f.2
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614425;
 x=1767219225; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpGHnIsN2Ox2MRGFB5IUG5mMZu0Z9brH2ZO6yXcHV8A=;
 b=nPd2UCuaRRIyqBsZ702DDEDzRA7zk5/6jDwOs9iquYW/J9svhlxLS3dcYIpCk9p5Tg
 AHpZU4ep8L4pqr/eBkm5T5q8JvIboG//ACB2UEq2nSKKwTJIeWtwX+b46pqAkDHwY1Vn
 t49NpAWhVbPuHpGlTkWQNQ/x+reY8XFUKEg9ROMtPH+vs37+NjmsIp+/RNVcF9Q7m4NT
 3d2QbYZ1dXMnpK/81m0Oq7CRnTOaCTZ3PLjYepuPKVvjyGmIF4f9d3HRMejCKmryd7CI
 Ao7SGKkgASc1e1+/LX06pa7HaVvyOrUs+1APcf63kvUIxSlBmGvkj8hdP0DcTO6qXsqj
 xtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614425; x=1767219225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CpGHnIsN2Ox2MRGFB5IUG5mMZu0Z9brH2ZO6yXcHV8A=;
 b=huUqoPFQfBoq138kvc0MOHfwTSUo6H8uIvfktFFSs6T6jJU0626cXWNjzOGoxIAUOw
 k8mZdhZ2JMknwuQ57nnfR9hPZvfuEq5tEzB4PrdGPC0wgO9k8iMqqcKtlPwlXpfSpVk4
 JF5jK+csxamGpJNA3I8OLrCDFyXfAChM12BExViG+plI+2slFPWEKR3AzFsrQ92VnqP6
 6u6vr0+LOO9qx3gEMdPR/1+NrbuGZ3tr4w9D5ZfMLCN1PXJwWhKW1VO8jpi3+TVq++7p
 O6YIoKw/zIyxSXKopaHD60CNou0xL5QOUSaLn1E+NgBep6DVcdyaqFrAKGHlJYSoP2j7
 yr1w==
X-Gm-Message-State: AOJu0YyUNZhd4/7oSCz/fF6/Rylvbst5qPqPjWceezTVvXrQvHNC9r5N
 eaxSLhuSSIzJST/YfPjuithAv6r+fVcP9TtJRCMpb2+FanEeDMZzJW19n24cqiOeUvRogyM6+In
 ILGsCsmk=
X-Gm-Gg: AY/fxX40oZWSCLyuHn7Pq+x8809sJBcfuLwRv9yrr0eogV1kizJ2Ey5ym4QOtsRfA5e
 kAZAQvGEFK5pWj3t2Q48F7q1ACxUZKVshaRQYh1Wq9Ks19PJSETvMjo5kB8wLbzEPv7l6ku3gai
 +nX8JMrkuoeRXVdStanrdkX6Kl4aTAEhq+E3qxArOeomDNbGb16um8DXOhhGKxZJaX7I+s9IC0r
 C/VX+kX4L2ofRKVNJufnbCDkZzUI1WoUVAEjIZY0u9kWJCNG9oXZIu7bj5LlEWHurCyr03ab2YA
 Wl2WFbrnVVoWgZnlJQH/llFNZEx7Qjb4Ts7i0s8mF6uEoA5eGsMC8LQXLNx+TKf7twzRVWexua0
 +0knTH0R+YS4+8PJ63RSUca9AoNT4QXIkm6PhRfxGfS9PMS0yllA1u2rvp3NkswtURVpjztAzNu
 yf9ZqNQHgkNYeIfuY4Z/szEsXLmtO+wEzyqvufhW62nrjWtEP2+g==
X-Google-Smtp-Source: AGHT+IGQvjWeJWTpOnBuScZigWFE8aU4HabD+UNprZAKXMk+bh2yDQQk78muljsnazMsUalrC4MOdA==
X-Received: by 2002:a05:6000:609:b0:431:342:ad41 with SMTP id
 ffacd0b85a97d-4324e6fa1a7mr22487969f8f.61.1766614425646; 
 Wed, 24 Dec 2025 14:13:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 13/18] eal: check tailq length
Date: Wed, 24 Dec 2025 14:11:54 -0800
Message-ID: <20251224221301.52714-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

The tailq name should not be allowed to exceed limits.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_tailqs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/common/eal_common_tailqs.c b/lib/eal/common/eal_common_tailqs.c
index 47080d75ac..7502836c6d 100644
--- a/lib/eal/common/eal_common_tailqs.c
+++ b/lib/eal/common/eal_common_tailqs.c
@@ -67,6 +67,11 @@ rte_eal_tailq_create(const char *name)
 {
 	struct rte_tailq_head *head = NULL;
 
+	if (strlen(name) >= sizeof(head->name)) {
+		EAL_LOG(ERR, "tailq name '%s' is too long", name);
+		return NULL;
+	}
+
 	if (!rte_eal_tailq_lookup(name) &&
 	    (rte_tailqs_count + 1 < RTE_MAX_TAILQ)) {
 		struct rte_mem_config *mcfg;
-- 
2.51.0

