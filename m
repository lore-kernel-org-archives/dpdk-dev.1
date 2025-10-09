Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF94CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:15:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3719340666;
	Fri, 10 Oct 2025 00:15:29 +0200 (CEST)
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com
 [209.85.219.100])
 by mails.dpdk.org (Postfix) with ESMTP id B86A240658
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:27 +0200 (CEST)
Received: by mail-qv1-f100.google.com with SMTP id
 6a1803df08f44-87bb66dd224so13409486d6.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048127; x=1760652927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tG5Na/fogn9Ok5ZrBXJdy+bDvZYRR8UTEo3Vhj9VXlU=;
 b=M6+tB6P0AAIFDft+diKema7covXBL5tjJJtlSVqSFPMiO0XiUckTOVYBRv2cvkh+ow
 Z/qxJdIm2vhDl94IH7QxHgdeUhgRw4JSTWWD+LTajvca82ww0AP/VtI3DiPmGEFiRukE
 dS8EJfeqf2o++fXBkItLeUm+HyN40BXL5tpZniAElt178ajkcyTKXQVbzqzVn4GP7Kn4
 0L9HaHemhlIXTNE2kyAGH6qpX79VZqaslyQI+j2+GOyuDgP0nMkZmqr9s6NTmKEzwK6E
 z3m4VgLEhG3EMoF6t6qxUQU4oW+Up0V4yvhVOK8fhYcGMVlIWfxYBWtObRyiODB1srMg
 4yxA==
X-Gm-Message-State: AOJu0Yy9srQJZozHIrUZ1GGTiVmNMcu3BRfYz2imdvIO3qgo4VSB4m0E
 LA2NdJY/nEK87vVyp+NGMz4IBZYCrsU+ReoawiD5KxrQ7NjlHF51cpAJdfW1N/w1q9lBItg20bl
 UQ+KT7XYQrdAPl9UnYZvC0+zWiY/M88CjKKOLRg+1y6rl3vP5fb34r1CSuYgnLFXnD41QH53fo6
 +BaPyaAjJQPpEQRsCny4tJKlFx3d3fzVJkokoPHla5NGPAAZQzjChREPej6+yMrjEYh53C6Q==
X-Gm-Gg: ASbGnctnhN2FYW7PLwDb6Skam5Zh/I7TCS6fy8LBvK+L/PWe5FXmJu9rHxFGsdQx1eQ
 M0WWMYhWFQq5BZeuOpNJuca/RAb6AHBKoFxNvgj6LEwErmpHMjo0kH7sbVGORFUrFm9MKop+Buw
 vo3TJWvvo9P/HICoFMs3MW9YZnhTDcKe5X4xV/uyB6ggAtrHnLPsINjaf8IuhyzWTgMtHZZH3X2
 1z7EbitaVlDL+c3fVnnnqe8NhPpbpdeS3W0K/1tV0qM+fL0CtnQyjAaLYOkWH6cC+cmEiNLsdox
 9prwkey5h5fVTzxgLJ5dUL5pQeo9jZoURXrgkiCRuO7R9lRKP1fpsF6MZqeC9nB7/zGoRChD7zp
 ys+9CpmUy3Hi8NJ1QEGXv/9ecYRfB0KjCT22ZDabA47LLmsgsUkzC3FC4k799qCrnevPPnIMS7o
 1jkforjP8=
X-Google-Smtp-Source: AGHT+IFgQ5MxXL3kdQ6P95oe0c4OEZeDWNh7xUwIXlFgzi1GhROv/LVN7ojkXAS5dDonPdNMIRuaNcc+Iivt
X-Received: by 2002:a05:6214:4004:b0:766:ab7c:3e89 with SMTP id
 6a1803df08f44-87b2efc373amr120239276d6.64.1760048127031; 
 Thu, 09 Oct 2025 15:15:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87bc34507dbsm368956d6.6.2025.10.09.15.15.26
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4d602229d20so39681181cf.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048126; x=1760652926; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG5Na/fogn9Ok5ZrBXJdy+bDvZYRR8UTEo3Vhj9VXlU=;
 b=HQK4S7BtfTYZzSKshgyMvpeZpKEngXggJAP8qS5tn6o3QOVd3VqYzs7QGevJrlL7F1
 Hj6TjgoZGZbm6gTagpfO9eO64rJCxN4x5nNioWyucqOwnrA8WgZt8w0RuT1rxrnHXOkN
 6vK2EjnULM7RI/rpKkPUjoVkg6IPLk5IMpYsc=
X-Received: by 2002:a05:622a:1249:b0:4b5:de80:10f0 with SMTP id
 d75a77b69052e-4e6ead73f6dmr121631291cf.69.1760048125989; 
 Thu, 09 Oct 2025 15:15:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1249:b0:4b5:de80:10f0 with SMTP id
 d75a77b69052e-4e6ead73f6dmr121630791cf.69.1760048125404; 
 Thu, 09 Oct 2025 15:15:25 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:25 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v2 13/54] net/bnxt/tf_ulp: increase shared pool size to 32
Date: Thu,  9 Oct 2025 18:10:48 -0400
Message-Id: <20251009221129.28256-14-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

Increased the shared pool size for table scopes from 8 to 32.
So that 32 instances of application can be created.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 55adceb59f..af3e82a6a7 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -373,7 +373,7 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	if ((feat_bits & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)) {
 		if (!BNXT_PF(bp)) {
 			shared = true;
-			max_pools = 8;
+			max_pools = 32;
 		}
 	}
 
-- 
2.39.5 (Apple Git-154)

