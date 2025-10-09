Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87628CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13F18406BB;
	Fri, 10 Oct 2025 00:16:38 +0200 (CEST)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by mails.dpdk.org (Postfix) with ESMTP id 3A33D4067A
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:36 +0200 (CEST)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-b5515eaefceso1229998a12.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048195; x=1760652995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=enyuucUdnwPDtWbB3yAA0NdyxiQJpAIIvB91mAldYYKWvP+6ffkp5EOkvEguPJl7jp
 xII5bG5B7TSGCvKYwSH11DZYbW9+4D2vy7dRf68vXVoDqpK5Tz2lOvqShCNK6pl+wcmZ
 mxfYc7bE7lCmZrZbzdk52yLeK6e7BySfXLRaM6U6mbIjThfSYTY4yxAqishRYsaIrz+y
 I9XKCfMFm8MmXHh/HMra/nScSSCsU+3JDihWPp0v/V1TxIeiRtyldGn4NZcp5WhYP4Qc
 udkWmnTk0wgfE2OsgO1ikgNIuFjJ2VsCxZQk7dQCjKJGZ46DXD1aHT62SK7K7rrTA+Ar
 H4MA==
X-Gm-Message-State: AOJu0YyzYw5HzYwTsplTTu+AwXC49ilY6i5ZMxdqaSGJcS88es9tUYi5
 /M9jbzgPzxRznMvy9Z1ShlkkjJlmTGd+xxFNK3v2/kzhJMh7sh2hYGmmZkwyPIyloIdffPWwc3t
 cmODJqjArd3YKRyMj5RvVeJuf814nigB800+cDlit/9W1VkR8d19pBJbn8C2+vxN7Boj8zbT5wk
 2ih+rNlOIBv4F5cX4jkvXvn2VF8ddORokh//lQ4XyBJ0FFzP4ZplyemIXxD2JqpDzIrr9NLg==
X-Gm-Gg: ASbGnctM3JDCLtS2zbnOZhmDll8WJwwMI9dHkBqJzZ75xGR3jUoNdepixA/HbIwQMua
 aARhP8xe0Ekc/tbQJrRsYhSEjypIVkQYsENbmC6E6m4kZxZxH+fETGd6fv67ljg775Wee40kaKF
 wA5tBzUNlpaAInrEa/qrgxUnyOPh+7Y37irT/+3fO8ttgMgo+S6JYweW9pGdAJFl6WZR/aVeOTh
 Ji7XuqfMV2TZf68t1othZJuq+LS0/HwuIh19RuVowB3egSOPjIyxIXMfO9J5ELON2DAXMyrgKsl
 bXf6wTP79l4GzjqT5obpy1qSoNRKm1uqlwzUj2k+fyXxqeajImUeCmJJeFEYWameFE9LDiKCV/s
 00MR30GQC8QvAtQ8zwGTwBobCMT59+LtV+wiNOD6QV+aq1h8ko4pWQGJLJHNgmL658wX2E5eDDj
 mYLgCR1Ng=
X-Google-Smtp-Source: AGHT+IHI7koeqd/v8zXKjgpTPoWQcALWFxhf98l8/M8i8nArRwRgwzl3zh4QsT0w2JzDq5lGGllM942T+dHv
X-Received: by 2002:a05:6a20:1588:b0:2ec:f29:1005 with SMTP id
 adf61e73a8af0-32da8139317mr11523238637.16.1760048195334; 
 Thu, 09 Oct 2025 15:16:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-b678df59072sm41018a12.14.2025.10.09.15.16.34
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78ea15d3583so47762356d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048194; x=1760652994; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=akQiRjmxjcOeUJoT52x4miqUDCtMxCNoWKPGhOfL82k5nP8p8jHRnHhq6Vgo9o05Pk
 IbGwKj31NlSslSyYBZgohzDER0gjBe+ZtAr9I8KbUSb7o/9lFLQMehVyabS7OpCcsrCL
 KGG/Y8N6TT0+ZGKjI8cXOSTUGicP/pwnWI+fo=
X-Received: by 2002:a05:6214:260e:b0:70f:ac13:f04d with SMTP id
 6a1803df08f44-87b2106d71emr147821756d6.23.1760048193617; 
 Thu, 09 Oct 2025 15:16:33 -0700 (PDT)
X-Received: by 2002:a05:6214:260e:b0:70f:ac13:f04d with SMTP id
 6a1803df08f44-87b2106d71emr147821306d6.23.1760048193002; 
 Thu, 09 Oct 2025 15:16:33 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:32 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v2 45/54] net/bnxt: add meson build options for TruFlow
Date: Thu,  9 Oct 2025 18:11:20 -0400
Message-Id: <20251009221129.28256-46-manish.kurup@broadcom.com>
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

Add meson options for
1. TF template
2. TF feature bits

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 meson_options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..3354ef2b4f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -58,3 +58,7 @@ option('tests', type: 'boolean', value: true, description:
        'build unit tests')
 option('use_hpet', type: 'boolean', value: false, description:
        'use HPET timer in EAL')
+option('bnxt_tf_template', type: 'string', value: 'default', description:
+       'Truflow template selection')
+option('bnxt_tf_feat_bits', type: 'integer', value: 0, description:
+       'Truflow feature bits')
-- 
2.39.5 (Apple Git-154)

