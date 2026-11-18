Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D264606A325
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XNE2SY39
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C219402DA;
	Thu, 19 Nov 2026 00:44:20 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mails.dpdk.org (Postfix) with ESMTPS id C30224029D
 for <dev@dpdk.org>; Thu, 19 Nov 2026 00:44:18 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so12210195e9.3
 for <dev@dpdk.org>; Wed, 18 Nov 2026 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795045458; x=1795650258; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xS+XCOv2wNdao51o+pkQWnLM/dvTH4FiE8hBSPYODGs=;
 b=XNE2SY39MHkNbwhg1q2tVSJtm1LQJ8ocWvu8E+nrpIG8Tvg9bwowI3v+2n9f6wOcQy
 qZXMrlhovfUdmDc4rUvQ6zan+trQN+k6WCtMW51thqJ2LWRkXG+zIgv5KLd+IkmNTftE
 ktw5PZVQj17l1LJxJkvijiDOem6ZuK6UNU+i9mocy7K3ypRZhOnBUl/L8FeVPZWDTJU7
 m6egIGgKwZl3MVO2q1/MPnL0dWHv+6lX4JEXtr3zf4wWyz7J6hJJuDjatAYNrUPGPrm0
 9YxnTR59n1Xw/vr3nKx26HSfoe94xBoigo2JmRBop8a5C4T7B0mVbeFfkgpJ8z6aXyrh
 KutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795045458; x=1795650258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xS+XCOv2wNdao51o+pkQWnLM/dvTH4FiE8hBSPYODGs=;
 b=yBTlhd0jRTBcJTVF4laBjg8eBGgxqVcZs4UPpbxd64sRKGIQ/KZuAjXkiCTnEsPHZh
 at+QjmjRCmSxdYTDBrqj90U8LLiZ2DjP2NT9/9RdcZiTRzrxjdx+jcDydcOIpPW/2b4R
 5pn2O0O3CIrkKOgFLkc360JGoFoB27sCTbL8TnCG4ZYc8lbbWKajF1CkVsKW31G9kQ6n
 wfURw2vFab8rnPmOO5SXoDN/XXrpvMZbTsy/HUJgsI9UUV2/m6dUq+foI+D/EVjt6ubN
 511YfY64siigjBfBQw8lQIShAUp1ZL0RYiOwfermyVJRmhPk8pXTjO1Fh889QQOoOF7Z
 dhZQ==
X-Gm-Message-State: APuU4Z956wxM61fuigvXMJ0XWW7hi4pKErRE6aWHprt4p5peSqLboJ2+
 bZ7CkcCkw3AOGGQfA23Wc7nw4IMPdZFpOkTrw/lIcgG1W5pFlfcEYsrT/ENmFyvd
X-Gm-Gg: AYBFou12K1mtGabI3PYbPqvkOglAsQrb1HP1O/oXziqh/sp88BUeeBnzVRQmUN00Prj
 trb2/ePCgJVuuVVr5OyqpyWviqzaFF9d0NQlTXVe1tADTyE0OFXHRsvnc9K7S5hqtQ7j3YvEsTA
 U0uH0lHIMhkHrhmmXK+ue7YzxAjloFP0Mge5hoU7BxyrQFijrM6+Nlejovf4TxmabZxS8crFPvg
 EVZxcc9U2ws1gExqqqX7vA9280dEL+IXFrhoC+fc7rxcagPne+tki8T8DRL5ITEdDZrSVzSho6r
 HviYA84w8By0ZmV++7x1ZeSt03EV1YL1Dz3yAxvoX385eDSPmkmt83rLgsqayAQzVBtAYwh5E0w
 AJadeAVAqr5mq/yYK6GotfXkIcsrbQ6hpBi03mBPqRzwvNe5Bl0jV4tPbHAuYSzVUVeiQ0Gj5a8
 pSHJdjR/4yL/7cnW0W8bU2HeI74u+SwbX+eLSvEKIeyt2jvWPmvshTKQmobQqEUjKVC8t5d5Kci
 5p0w6V73uSILAqKftNgjH0FODmGoo/umtuHySW9N+p51FYNDZ1rbb8bpnV3LFpe7yOb+DxQGxiN
 mJ6iMYTHSjbS259lPrsM1qRYccUW7WiPGA==
X-Received: by 2002:a05:600c:620c:b0:4bb:665c:a078 with SMTP id
 5b1f17b1804b1-4bb7da4917bmr80084305e9.28.1795045458194; 
 Wed, 18 Nov 2026 15:44:18 -0800 (PST)
Received: from localhost ([2a01:4b00:d036:ae00:972b:85eb:206e:ff36])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb8452912asm6783065e9.15.2026.11.18.15.44.17
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:44:17 -0800 (PST)
From: luca.boccassi@gmail.com
To: dev@dpdk.org
Subject: [PATCH] maintainers: update email address
Date: Wed, 18 Nov 2026 23:44:01 +0000
Message-ID: <20261118234407.1688949-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Luca Boccassi <luca.boccassi@gmail.com>

Switch to my primary email address.

Cc: stable@dpdk.org

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fcb4ef5fa..e3bad69299 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -70,7 +70,7 @@ M: Patrick Robb <patrickrobb1997@gmail.com>
 T: git://dpdk.org/next/dpdk-next-dts
 
 Stable Branches
-M: Luca Boccassi <bluca@debian.org>
+M: Luca Boccassi <luca.boccassi@gmail.com>
 M: Kevin Traynor <ktraynor@redhat.com>
 M: Xueming Li <xuemingl@nvidia.com>
 T: git://dpdk.org/dpdk-stable
-- 
2.47.3

