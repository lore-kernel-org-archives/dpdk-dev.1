Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C291C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0602C41144;
	Sun, 18 Jan 2026 20:14:02 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 779D2410D4
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:00 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-65378ba2ff7so6247578a12.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763640;
 x=1769368440; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rpdyv2edsKm/9wMdvYeRKZpjakERGAID/imRqAcFhoo=;
 b=Sy2sH65hjZM5PHj/l8EbwE45nc5JIdWzOjd3K9YS4Fc59XFPa8XGQ9ZCK4/+482cHl
 xcvMMxPdY/kNz1oAptidx3/qss5V1ZquRc8ZmeK8jxuNabKsda/gekbYacbpKc45Hkqz
 1f2uw+ALo5ayJvdk0rXJ7Y3gJDiOyJN+5JjQRaY1o95Ad0JKEWvroXNJJTyxLA+S0U8y
 bmTSeFTTDvKkaY2qrbHzDrWuHbLMLCpSghs1q8d4uUuPEUyYPb5cWSqAcH+p41oLev7s
 TbKG8SKlRTRcboy36pobLTOgoH0nkNc73AwJH7PSha0GhCu4TUnPVtHVwQxPeiEtwYyN
 91Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763640; x=1769368440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rpdyv2edsKm/9wMdvYeRKZpjakERGAID/imRqAcFhoo=;
 b=FkEKgzq9AeoGj5O43HcU5TLedcbczW8ooHjQNZuH+5iKWu+rNPbUYRlOA5leb/+nXR
 Njg76uPY+AvNU+43+ki9tSp85DnZj2XmzTgORXyQ/CGmSvtf5gj4bH3Rsvq5l8ExmCHd
 umWwnmrPrRgolhvfJflD62wQeDM0Dooq1MAbdWwSfHzeaRmyD7X2Rp4jXMyt7EKeZ0/l
 EStLlCDLmWMsfo6hE72nrsX/PsfMA95D2iFCnlz22I8ohcioTloz3xGeMdjEjGaXs+vD
 zLKtEUUnOlWsHEknBRcdcPC1nf9lZzz4ycqtk2c6h7woqfDTxYnHcTkVbcl0QcQM61xz
 M8YA==
X-Gm-Message-State: AOJu0Yz9/MpIqoxgZCGVvQqC2M15jRxoTz6Sr1+HY4d0an7y9UiZ9PM1
 YGdsnLHz1O1mpIIQrJqym6bFDTp6KiylPRD7f3TI3Wq9tyeZpcZ9hBfPmAuoQKtd9zOBgXPX0Ae
 H3IFx
X-Gm-Gg: AY/fxX6ypfMeVhS+XSYYwxc1KjDQKNrKGyNUTr7d9aS4esX5IDatMyPyioolma3FHRx
 0w/sS4sDRe1zOT1Pek/akJLczbBwkbu2SD4R2EJV+ZSg76oKjHNj3i8ZVRzCQ5pi82CFgaqjWio
 iqa/wNao+U/VIQJZOFqFeyPvIVMVp3Lp6EZWCuyjFxqWDicJUmuxYgN12GU0XCCLigwI96EBTEv
 2p3Pecz90MuwDZu3TxDZb/DrBCIXg16qoGNNn3ewbCqQIen++ULZojMQ7mJC4iWIzAgQ/aZlF5K
 Czkk3EWXtphPMFVqh9GsDZe7PJVcZPtPCyozSwOACbZ7t1Ev30/MbT9WfHfXkdFl3/re8hElieV
 xavpFATxHR+wiJnz7oEChOzgaH1fqzwKVwLRuzXw0mtke2wH/PHohterBDk0RETycNCuUrD9F5X
 ItqhvQUPTRwuL+2LpLz0ce/ljc5bhau4hNi5/0+aptsh2iSAgZFQ==
X-Received: by 2002:a17:907:940a:b0:b84:206f:c0c5 with SMTP id
 a640c23a62f3a-b8796aee53emr758382966b.34.1768763640021; 
 Sun, 18 Jan 2026 11:14:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:13:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 20/54] doc: correct grammar in GSO guide
Date: Sun, 18 Jan 2026 11:10:23 -0800
Message-ID: <20260118191323.241013-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct "GSO library use" to "GSO library uses".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/generic_segmentation_offload_lib.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/generic_segmentation_offload_lib.rst b/doc/guides/prog_guide/generic_segmentation_offload_lib.rst
index 618297044b..90ef80765b 100644
--- a/doc/guides/prog_guide/generic_segmentation_offload_lib.rst
+++ b/doc/guides/prog_guide/generic_segmentation_offload_lib.rst
@@ -206,7 +206,7 @@ To segment an outgoing packet, an application must:
 
 #. Set the appropriate ol_flags in the mbuf.
 
-   - The GSO library use the value of an mbuf's ``ol_flags`` attribute to
+   - The GSO library uses the value of an mbuf's ``ol_flags`` attribute to
      determine how a packet should be segmented. It is the application's
      responsibility to ensure that these flags are set.
 
-- 
2.51.0

