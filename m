Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A8E8383C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 21:43:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 674EC40395;
	Mon, 16 Feb 2026 22:43:20 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id C2A8A402C1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 22:43:18 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so40281605e9.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771278198;
 x=1771882998; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sgjnr4JDdNg3edigcLea2NEd2TB2zNxi9/tHoKd+6/8=;
 b=V39HIoFbDTbulZaQTEYdH15kB2nleeZgDfD86NJclcKLq5cY+RmLexo0axz9P8Fvg2
 DQl6Wy3VgU+UDwkfIVyGN0xErXLUHh6wnYGO0pCAvDcI5DEpN1brNILWHSNBq33l8ueh
 Y2WHL7y+wEGG6E5bDgiHQdt6oo1Udclb9lAdgkzfD4yJGM7Y63WVShd812SRsH1Avbw/
 e6ncu2mcPgia9Oc1Mp3+RHCXfkq7e0zg015HmJ678QVhv39hmFxtyw/d4C95oN5D836L
 XV8eyUDcPYa1EToddA4zJt/49rHJY4awhPc2flDcBOqpz0hdDUj+YXo6O6JkcNMDyUNz
 kCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771278198; x=1771882998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sgjnr4JDdNg3edigcLea2NEd2TB2zNxi9/tHoKd+6/8=;
 b=IzN3kNu/gaz8NgpnVm6fGu19+epGA3NUx+IoCKDdsveNE6Rl5LCEsHn8xHwGSYumby
 ZTq1Ngknh5NDfHfHh5d0YMEfsKbXsdJFzUqt45Q1S5O+k0tV8/XAGAgUGek7Y5tFML0W
 MhquKv518RjxVkR9ZB0J7Sdxjjqc+q4elLtXV2/KPChb2x1bMsJGw4E3v7Iom69W3QF4
 vZp+UsQ9Pgl9Ph0HG7KodnWfz0kHRbObEWn2LqG3liUfu2u1RAL070EUEEQH5rkiBzFo
 XaYBzEd3H48dFxe5MnoKbGfoT8FJlpF8Ne8MMQUcRkQReLGk0E0OVrhWKm6sv8KSsz3X
 KWfQ==
X-Gm-Message-State: AOJu0YzYnn/rzbM1u2jgRyVPSdw+VRrGnYy6ko53Cc01yN2QIMFDeId6
 bPIW7xcCTMXebDcT5tToNpmvyCzaPzohcDX/m8o24Caq4wfFoFaZT2VHxLE6I6OtwSYTzv2MCu2
 B2PZikrE=
X-Gm-Gg: AZuq6aJjbvuOrp/liEj4ieOahra39oBtv4YJ0MtdMS/EkZCRmoPPCPHBihnoUk66Ayf
 AcFTLrUhuDN/6HQxtOoU3h0PX6xDZntX90CHLN4kzMhGu9+LvIy3sAbI/+XrdsDDPqFcrSnT4Yl
 p6ERhmMlrGDlzi4aIznyJGTKlHJw/xRSJt7WD6pbeNRxWxSVMXmoB2fB1GkWsAULfcy4S+xARUC
 fCn6xYetkPpjqQ5PO3FrE/MJREm2kyYnlgpmyGD5pRAuWmzzEuPReG/uWcOeoExQXL9oOnaqjOV
 u3Ia0zC/hTZozBJf8P1wBI/BvGjunZT2VEdQrC3KCb+srptLfyiqfb9vLN3qPv/6+RAsGH8+Ect
 D7H/MLi0FEHfWIGR7At2O5YR6GEzxFqIjxU1/HTZmCQT/77KzreU0ncC6Fxg+gRMjHSE4z+FI9U
 YQR7/xK0VhMfxu1cFmmMNqdd+mU8HElexKAjA2iRI/nPcViacHinW1/TEI6i3KEA==
X-Received: by 2002:a05:6000:18a7:b0:435:9635:2943 with SMTP id
 ffacd0b85a97d-4379d60cc28mr19443278f8f.17.1771278198233; 
 Mon, 16 Feb 2026 13:43:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm32146354f8f.3.2026.02.16.13.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 13:43:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 1/8] pcapng: correct typo in comment
Date: Mon, 16 Feb 2026 13:37:58 -0800
Message-ID: <20260216214311.717492-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216214311.717492-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260216214311.717492-1-stephen@networkplumber.org>
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

Minor spelling typo.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index 2cc9e2040d..5789c2cdca 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -309,7 +309,7 @@ rte_pcapng_add_interface(rte_pcapng_t *self, uint16_t port, uint16_t link_type,
 
 	opt = pcapng_add_option(opt, PCAPNG_OPT_END, NULL, 0);
 
-	/* clone block_length after optionsa */
+	/* clone block_length after options */
 	memcpy(opt, &hdr->block_length, sizeof(uint32_t));
 
 	/* remember the file index */
-- 
2.51.0

