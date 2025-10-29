Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB476CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:21:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E52F40A87;
	Wed, 29 Oct 2025 17:21:49 +0100 (CET)
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com
 [209.85.219.100])
 by mails.dpdk.org (Postfix) with ESMTP id DC450406B4
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:21:41 +0100 (CET)
Received: by mail-qv1-f100.google.com with SMTP id
 6a1803df08f44-87dfba1b278so1051286d6.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754901; x=1762359701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=OBJ/OcDNKw5xciz9ZbyfRWsBHoBhtUDKEUcKKBEtAGJ7Kwue7fJPzxuW4K0hT7T9a1
 M87Af7NwPgDRTRFinKdzBH1f9/3Yx9PD0jvhozxjBwxcQbCheCkhGajyYHPDaoQZFF4E
 b9bfLvjKuKN82G6xSAOrbydHzsbuToYWBAsavpp3T4+Hoy9Ln7izE76BGwAWTuGs0PqX
 nNcbT5LaYo0OfTpjmVV8b24WY84wJ18bUVRM7AslswcX66aGyFr8wVQTg65b5kffjVu9
 fiwMAAOajWg9FxbEdUNKR1aIO/qK6EyRASAeM3C66RAn5Z70v74Sl2QrMj38UESV/we6
 crFw==
X-Gm-Message-State: AOJu0YwucOCkA+6wIxqFBo/NxKbkytdNEZDltDg183tFmTXcH2IU9K5G
 /LtwabTPV3CppWNkzYhbal3aYL5relSsj3ofVWz6iV/iDyC17Q+KBVNZCbCReH5+cHU/q2LJllo
 fgDMSdTn3AozTbAJa/qvZ14Y5yIn4z4U9IcpmfddRIStK5wlN/CYun2lZLhAM1nxnMpKjH4d67z
 Jt3A9hX5sv/8xz4Xt75M+5g2j3TRKXO2DdHcx191c4CekzN+Ah8+an86gbgqyBNuqD+evAlA==
X-Gm-Gg: ASbGncsPkES151BlteGQPkIfDUs9Ho95TDYFL9d+L0jJcM66aZutIFvewZsRRwvxujN
 pVug6qPzaaThowutBY7XVcReGY75/QNsI4hk/jC1ZZ8PNO4C9XVeJG3X12+H+h90SxKx7lyVJ5s
 gTY+NyUwPqcIwswpv82fhdCTpLuJg32BMsLp1sQzWBm7wsGOGpJE8yrsnC0gLDYJW416BhgiByH
 DtBIWiPKI4C2ti9FtgRtR06e0scOaDRk39oyB66NSQIjjBsnxsBdxMms+yBIJ32B8QxlaI88bgC
 GD8q068fBxFUHxN9rH7AkD7NBAH8fnLwrIwTQk5V00VFfbsw9d7NExLzeWLnvgMrjaAZWmkus0d
 b1sA/ivTpQDMbSBMu6J9KldERXgPLGmsCTh2bdWBT5YGnD3fSvTwRLrRRyS6gPCoa7nlYhTjNP0
 z/51ETca0QqSndCE8sUpxBBjAESvGn67EUezf+
X-Google-Smtp-Source: AGHT+IHOItMqHB612xPWKF1Fqt0Xo8Yh3Cq9H5YF7T+Ywqxx+WJAlKcTohhtYh1+Z2XKDeK3RDBr4KaQYWHU
X-Received: by 2002:ad4:5d44:0:b0:87e:d590:89b7 with SMTP id
 6a1803df08f44-88009afcaa5mr49693136d6.19.1761754901115; 
 Wed, 29 Oct 2025 09:21:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87fc49dbba7sm13939136d6.34.2025.10.29.09.21.40
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:21:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a65ae81245so890560385a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754900; x=1762359700; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oavr6P14Ga+9mOP8Zv1wxARmZGE0+nWEp/GV2lao90=;
 b=Gvj+r9SRkiV8xgh7/nLemHjTWGiMgPJbojmL+2s7Bb0U5R7WO0LN1nymJ1q1uLElze
 l4wlclwr/rAtlT/YIXuh4dQHMeh32+G51lmQM/JnsOKfJL0ol0XBlR1MP2IS1lFjovDL
 Qw6hFld1ijuVkBh3uVHbf6Wa3jjd6UKFzU9z8=
X-Received: by 2002:a05:620a:462a:b0:890:492:cbc7 with SMTP id
 af79cd13be357-8a8e5f929f9mr443431285a.78.1761754900078; 
 Wed, 29 Oct 2025 09:21:40 -0700 (PDT)
X-Received: by 2002:a05:620a:462a:b0:890:492:cbc7 with SMTP id
 af79cd13be357-8a8e5f929f9mr443426385a.78.1761754899527; 
 Wed, 29 Oct 2025 09:21:39 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.21.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:21:39 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 44/57] net/bnxt: additional rss configuration cleanup
Date: Wed, 29 Oct 2025 12:06:59 -0400
Message-Id: <20251029160712.58519-45-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

If the rss hash type is set to none and the ports are stopped and
started again, the check for rss hash type was not allowing the
bnxt driver to populate the correct rx rings in the vnic rss list.
This causes the subsequent calls to rss configuration fail since
the rss list is not configured and have stale data causing the
firmware to reject the rss configuration.

The rss hash type of none should not be ignored during configuration,
it is a valid configuration and should be applied. When rss hash
type is none, the rss context is disabled and there should be no
rss algorithm applied to the incoming traffic.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 00b02821c9..939f35e3da 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6331,7 +6331,7 @@ int bnxt_vnic_rss_configure(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	if (vnic->fw_vnic_id == INVALID_HW_RING_ID)
 		return 0;
 
-	if (!(vnic->rss_table && vnic->hash_type))
+	if (vnic->rss_table == NULL)
 		return 0;
 
 	if (BNXT_CHIP_P5_P7(bp))
-- 
2.39.5 (Apple Git-154)

