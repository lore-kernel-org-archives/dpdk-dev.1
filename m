Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6362C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 15:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE8D240666;
	Tue, 11 Mar 2025 16:53:17 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 42C1E40650
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:53:15 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-224341bbc1dso75218235ad.3
 for <dev@dpdk.org>; Tue, 11 Mar 2025 08:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741708394;
 x=1742313194; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZWhu02xUDou2fDTvpz9cyQyUpS6zq3oL8ccdJCygGo=;
 b=2PjHoKhb3/3MzoVHQh+BWloDVnTrIceB2XA1xdIf+Nnyf2B7EwspysQqTtjb6uiReP
 m+Uht3JEFJhSCeENtYDLRGLqljKTzFlrvCdwoJQ/gHPE6sZw302JrWmQ8UvYa7IkrBhZ
 Ff5wXPqEmfO/ayxz9RmEn7eYP21Lj2LeFnBVthItpp4ANA8FB+/xKkPnaJvcB2/VEIgT
 g/30sKaF69j+kOQDsz4EUshtbrsBlkFwqqBfegUkrkcjaFnSFGVAFub3NrPnZVtAEYde
 /TTvTnIA20qEGXx8loi9dia179OpqImfEWeHhwkfFGm6/3AtLzp0jVE3saWLhZ6aY+d8
 aqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741708394; x=1742313194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZWhu02xUDou2fDTvpz9cyQyUpS6zq3oL8ccdJCygGo=;
 b=S6q2U2OXmvTeOjBDZq5iIi4zEZ/f9ZczVLHTtvWxMCp9iB1ePxMNVq6BrEpWFFljtU
 aQBQw/GR9ypJYRk6ZEvgXWjM4Ybotf9OwBJ6UgJMltlne/sTlPNk1CeNMi7n2MOFVTb0
 ZQjdeMwOXXI3H0SdvCW7XnR9PKJCFwtgzRft5q1zDqnchJFGSnF7/JhTktisEHPpAuWd
 i5Oa13Uvgu77PdsjQjDKPj+Jjojtli153x3Y1bWgUnUTSjZb7jO8+miANKwoer0vnrZv
 vNIwtYBMuRGl3tKS8xjKiPPqXZPWsYPPLnwVlalI6zQ0c+xSaMqFkyxpEkMErqziVWTY
 mweA==
X-Gm-Message-State: AOJu0YwT2v+bemnuz46mfP0iTfc9xb5e8cotbooUY8dvxUIiz/2C7b7v
 oe97i2T5zpzv2Z8l1yY8TOoEpMs2xfaRDn4lpoSmX4cC2+mEXEtSDpPe575LgSf9u7OpY0emETs
 t
X-Gm-Gg: ASbGncuC+CNv2GQhSgfpekXQri3OtNRsYsby6TrgI3AADPdOI2j8EmQ2pHVHSA58aTf
 4KrR6xMrKwMvDPjPebO5x8wSDPxvRVYwyvqYxawuEyy6b67gdt/9AwwmMaGWb+Z00dI7GVo5xLw
 NNCwY94kStnl/B/GqhEbDL51l/75Ra0Wtj/OPebD0paFNOyfre12LogviwIoOBr3hKpPinj89tL
 v7oWjQuLngwRW6bcWVV5/DmLqOF2b3NlH6NrmVzYoY6QP2kKE4+XyMGAoYwxVAQ/i0xDONW9iDj
 EoefNQEmNdUn9k9WckhgpUvluVaWr9S1YtvvyNfQqtBoiBPpw7FDSh0PDLMehDHBTKV3dqZqGe9
 9IRMa3MvNATg41grfpbhFkMuXlzAsW7f7
X-Google-Smtp-Source: AGHT+IHoxiTy3LYWvObKOqLUrT9FSyTVlIlQ0u75Pi0C0TNyfqpf0Q+BSlAaieG3q60cpDg37NT/Yw==
X-Received: by 2002:a05:6a00:1911:b0:736:3be3:3d77 with SMTP id
 d2e1a72fcca58-736eb87c200mr5549393b3a.16.1741708394324; 
 Tue, 11 Mar 2025 08:53:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af283576bc2sm9500013a12.38.2025.03.11.08.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 08:53:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH 4/4] vhost: remove unnecessary deref of function pointers
Date: Tue, 11 Mar 2025 08:51:32 -0700
Message-ID: <20250311155300.13410-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311155300.13410-1-stephen@networkplumber.org>
References: <20250311155300.13410-1-stephen@networkplumber.org>
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

Since it is a function pointer,
the expression *dev->extern_ops.pre_msg_handle and
dev->extern_ops.pre_msg_handle are the same.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/vhost/vhost_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 26dc0bde97..45f2b71e36 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -3186,7 +3186,7 @@ vhost_user_msg_handler(int vid, int fd)
 	handled = false;
 	if (dev->extern_ops.pre_msg_handle) {
 		RTE_BUILD_BUG_ON(offsetof(struct vhu_msg_context, msg) != 0);
-		msg_result = (*dev->extern_ops.pre_msg_handle)(dev->vid, &ctx);
+		msg_result = dev->extern_ops.pre_msg_handle(dev->vid, &ctx);
 		switch (msg_result) {
 		case RTE_VHOST_MSG_RESULT_REPLY:
 			send_vhost_reply(dev, fd, &ctx);
@@ -3238,7 +3238,7 @@ vhost_user_msg_handler(int vid, int fd)
 	if (msg_result != RTE_VHOST_MSG_RESULT_ERR &&
 			dev->extern_ops.post_msg_handle) {
 		RTE_BUILD_BUG_ON(offsetof(struct vhu_msg_context, msg) != 0);
-		msg_result = (*dev->extern_ops.post_msg_handle)(dev->vid, &ctx);
+		msg_result = dev->extern_ops.post_msg_handle(dev->vid, &ctx);
 		switch (msg_result) {
 		case RTE_VHOST_MSG_RESULT_REPLY:
 			send_vhost_reply(dev, fd, &ctx);
-- 
2.47.2

