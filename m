Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38029FD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4F4640DD1;
	Tue, 10 Mar 2026 17:14:04 +0100 (CET)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45]) by mails.dpdk.org (Postfix) with ESMTP id EC976402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:02 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d7422b4ff1so1122294a34.3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159242;
 x=1773764042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7GlG/KJ1tj7qnEpgY/TO1m7JeU4M1J6zwlDzF+0VIY=;
 b=IdoMQZI7B7DvA+JyrgO6+6ImFfVzldmOv0fX2Usp0uuCkn1XUJAXQ7qaEecflafecY
 KOLEQ6J/a553yQqfEXYSrn4TAtotXE+3MAwCEtQWLuNzuhqy7UEeppb18H7RbhFwOQrS
 Od8PVXw6C+mXeVzdtABmE7ZJt5XDOKIzdr81kSlHZ8GIALdxPo9xaSgOpLD36owckpOi
 FjT91hV6x5y17Tc/QdoYP6CtGWppna99dtRizSXps3Klx95qyq3+zGPQMXZOfz3ueZEG
 EucFed/RV4qUQBfohFIagvQ0GkOH9dHgVfGaNtPBurOh4nyGzym4QBOj0iH5JkC6JvQa
 ENlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159242; x=1773764042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7GlG/KJ1tj7qnEpgY/TO1m7JeU4M1J6zwlDzF+0VIY=;
 b=P2Z/VHdV1JFZLmrgG8+Mri5OkfzQhmbP9/LED6BiBvcCWDJVtHpftjtmAr/H8Tt/pn
 SCpPnYRH4/JptnaKBAOBZXAwNYEnnXe9t3iGBcLrEZIysJ43AkHwQZz6JhfJQB/k7tWz
 qZc2ioSTQ4rBI7YBtSw7V6t/AJaTough3YGClP3IOTWUv4lOwWA5CN3YxLvjhxNtj3IG
 a7qHrLb1RnDHuAe/bGkgq7EY9JPdgahQYk3/vIikhmC9wY6zBgqGOaQMp6uoLYXDe0qT
 rCcT98xG8EFCl03fMTHitcSzAGF9K4v4htieCl0p9wXZDQYe/HDg+PWZIXyQmskTml0Z
 HhBA==
X-Gm-Message-State: AOJu0Yz0wpRgfVF6UdV6OCGq0Gs+w5sSegKu2lum9iqq0CeKXDuFIUKa
 rlgtSbA5wu+3xUROVb6HujCKMfIJVc7lKhPZfUr5sCY6gFrMoBw6KXjZwIM1qiBAKeMgqJWGYLp
 rONoIBoE=
X-Gm-Gg: ATEYQzwsG8+vM4o8Z+4SnN8wEKJtjZAc7dIKl8jf1iSVlyxGiffgoz2vWA/Olbx8x3A
 VjsG61UX1RBi+PRKO2j/EG5UgDz58O9RWuRIKTXiAV0Mp7RN6AEioNxJaWxwtTXOgrqJr2fdmsD
 o+dxOhWf3ZsSY2BVF1ywcpGZCq2TcwEr8oiqfE2D1hQa+7KWcsuNURTxXSYqRZwXwkoT6bQepnf
 HLmGDpaJNQBlP/fiFezbHWTDq7E9cTYwl1ey4XPOen8LsccQfeZ0Qg3vfmM9MU9kBFoQgWrqtER
 0UV748XNVvz4Xhoci01+eiP1BLsX842dy5hMkf1ui1eUTytWIm06mSljo9tpM8/KBZmPPEB0uk+
 EU+Ln08egZt3N3CTqz7ZhPXkf/Bi+n3SiSz3Na6eJ8JqskJ7nrPzQ7zZLyXjEg5yHd4x2KDPgHM
 SexjELOdCU2mLs6pTIDrM9ELYYGf1FInF7
X-Received: by 2002:a05:6830:81c6:b0:7d7:43d6:5847 with SMTP id
 46e09a7af769-7d743d65c4amr4917871a34.26.1773159242020; 
 Tue, 10 Mar 2026 09:14:02 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v20 01/25] maintainers: update for pcap driver
Date: Tue, 10 Mar 2026 09:09:39 -0700
Message-ID: <20260310161356.194553-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eb8e9dc22..a8e375ddab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1116,6 +1116,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

