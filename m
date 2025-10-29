Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE101CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:23:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F288D40A77;
	Wed, 29 Oct 2025 17:23:18 +0100 (CET)
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com
 [209.85.219.98]) by mails.dpdk.org (Postfix) with ESMTP id B7B2C40B94
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:23:17 +0100 (CET)
Received: by mail-qv1-f98.google.com with SMTP id
 6a1803df08f44-87c11268b97so1082656d6.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754997; x=1762359797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=qvCVAJh+yHaH5p3kvK4DCQkfM4Ociwsh+hJfJDguwSOj0aeAMjelWl4PtjXIXa6Rv6
 shBfWjxsswDIYYBU7PK8mjq/mvY8rF1eZay66Vl9SNbYUO+8pxkNj5I6jMgiM5oXNMcX
 MUBMjr4c4N5bvImpGiAUU5/q3UkH3RyURqHJPHqkEHv8dqBFVlo2CleHPkgQcop1P86i
 5QeLFVdvgFmGm0RQLiZNwPoqsEhW7nU/FlARIK2xSt+kruiHdFhSPAXT05pNtbLkEdvE
 wDjLL59KXoiyNn1Z1qq9EBlYbkVlVwKiNflOry7E+V47iLEEkNu+gXmoJdw4k9nbVIcP
 TDQA==
X-Gm-Message-State: AOJu0YzsfviBGU6aCt9EN2JLnO/R/WgchMhCLrCRQ5n2x0IBvdFaSyG4
 QWmLBthe7ZqmdN7TnOVFXKHugSPYREryXK6Oxe4pqvHwNaJEpm1VHRgpA312NTsNFNfQG4/em7C
 SS1Poiup4idPQofcK8GQLvNFtwkLa3HiwG07qjUVA+XhZsaL3ufaA6zkbiScSw6qyH6CBXSy2TN
 r772i3N5W+HLogAfFz9kmQusyoiBCr9STOWvmS9ZvkPy7CCNAU+lv79dAP8Z8U4QXFkbJWEQ==
X-Gm-Gg: ASbGncsw5r1uehko2F1mjIngSe6hJwwUE72bwt1gNTtcs9YEZeKEU2AbGNAzR6yhugw
 mxljw9F6xPZWzbyl+juLBekroxOuXUXD9YwgydFpfsFOjdFZKasQ3Fz4MFlPb06iq8fqpBYMMAZ
 UtlHCVG665RdWF8ZhaIkpNqODy40hwCnsmfMFASN6lIghHzuJzbFsUngG/LAW62cJbItDynmLB0
 DKGyKOoAwwRcmdDjPrupkCdeIZrEovcs3JyWfIxbn+ssyoR8cF0/RUupDeARCB/6j5ByGl2+jk/
 i8Oa+c6Shb+IG0R2MkePRMChWE4xqKBR7Fg+AiRelDOBj0JTmsoR5jBwOkqmjxgFd10hpgRmgh2
 QbcKO8QtVTt6IE6iUUwjVbtAPw6hVFo33FaUYUqiJTwjn2RuU3BzUCyF1j2yenuE8OI4lOF3K5z
 RwH+8u+J6JitSbs3ycJqNG6XDb8iXnNA+G0vgI
X-Google-Smtp-Source: AGHT+IFO4HYKaz/PZ7yiTEEtjeFP8ptj1daFNDT9PjpZ27aSi5Rlr26xl5eYHfTpx3KbHIoq+eGv3FN5mQ13
X-Received: by 2002:a05:6214:202b:b0:791:34a5:8682 with SMTP id
 6a1803df08f44-88009c08d8bmr48196976d6.38.1761754996908; 
 Wed, 29 Oct 2025 09:23:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87fc491f133sm13911466d6.11.2025.10.29.09.23.16
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:23:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-89e83837fadso1518975485a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754996; x=1762359796; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=PZ7YGIIy6fy70vP3pVYhQ6ugOHqmdJr9wXhybUkBkMRCTvojWtulpmk1sWC7MqtPVu
 L933j17vkqPGt4xTscxXHdmlpkQX+urHO1zuKxi0icKI5/iS2gReVNS2bkQvDGE/gBHe
 XVe69OiId3qkmjS4mLhTtLRcgOsnD8Upy4KSU=
X-Received: by 2002:a05:620a:468c:b0:892:76c6:8356 with SMTP id
 af79cd13be357-8a8e6e38319mr515833285a.81.1761754995849; 
 Wed, 29 Oct 2025 09:23:15 -0700 (PDT)
X-Received: by 2002:a05:620a:468c:b0:892:76c6:8356 with SMTP id
 af79cd13be357-8a8e6e38319mr515825385a.81.1761754995001; 
 Wed, 29 Oct 2025 09:23:15 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.23.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:23:14 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v5 48/57] net/bnxt: add meson build options for TruFlow
Date: Wed, 29 Oct 2025 12:07:03 -0400
Message-Id: <20251029160712.58519-49-manish.kurup@broadcom.com>
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

