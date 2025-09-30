Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BC3CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFE21410D2;
	Tue, 30 Sep 2025 09:06:22 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 1D5D8402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:40 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-77636fb28f6so20496207b3.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192659; x=1759797459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=PjikdFQgNu0j2tA4nvpZ2yU6h4MpZoibr+snkRKocXW7sOb5t0KBfxIX4zE3Ts8jBI
 Gh/irNqHRBtGCJPJr1L8/bw6UEuNQIbDTqxNBwtBrXQpGgLnSPjef/+mRMr7xuPKH2Cu
 9bQrmYImFewfxSuQerom3ZXqTQM1Bviwla0owdBSRp/j92NAcc3GhRPSAQE+yxIO/Vdq
 6StmWUS7FK5g0nhbyjLO1BIq/8ze7g4R4HqS8IB3cgkzseBIu7PkmsfHY/VBUfI9gQsp
 B787FWY9ZW1/mpbYyDRqGJZDPGI7uIZ0V87IyFlbOPOLZYxyY1mlbCZ0EAncJul/PNVU
 WYHA==
X-Gm-Message-State: AOJu0YzjP/pH+4xZaO6xviBUBluf9YjqK2kwGjAaiSHpKsNmKO4fAp45
 dfZ9SgwZa1ed19adQEujYdvUsw5zgcg8y0lZ9ALDOR4pml/bJEfJs97nFi4cgP9R8CsYFnS+ZE3
 3zy1I/AOChQHiaJoIf575eFBRhbAX1v3IMDGO88GoSwPoUPGREH+SFTwcGwMJsphTqXsEjai0ap
 oHiMy8xqdD0MZSqh7THe1DSeZSn9LACvImz93m1hfARQgyyD9odcIWswPZPieZ9X5gfmi4Mw==
X-Gm-Gg: ASbGncseckb1nVQEhJ+VihzddlX/XiUls9WceoQdZDOcTF+ww146Vh7i90gwCkfnSEo
 GgsuO7/O2GSA48TnPBesoXz+9klHJ2vPh9kmTjlp4aqkDahCTf61vvkDZXmcQOcPcX4Smbu0lpQ
 LkkccH2inSQZARTAK+T5I3QsNP+fkFR1VgHs/4StV7iVnr/WT06j7xQb2ouvvipqOan9ONgSWzh
 7myyOI3Jd2hsdeTU+OZALvFXcd9ghIU03U8Vkw6iKNEUALb7wZgd+xC3VU6/7OFwSM+3AajChrd
 ry1LpaBzC24u+hS71z9dPe1fpgNI9oEqVbU/UyhQJkKDifFLXD/ifqWHb6/citS5ZoNV+bA121n
 6p7F/LCcsjwdWLmsh6Q5aorcmNBjOnHzrMZsr++lHIRkOhSOSmeczwt2QpqZB/BKwI4Giod8+I+
 wyjw==
X-Google-Smtp-Source: AGHT+IH3j9BaNsXsn9kry9o+h1QBmIDW5ezRYI8SuKbmOAiW1sIknjQhf6pN/lNzK7v34EmJkWNKCcLaqkaf
X-Received: by 2002:a05:690e:160a:b0:636:1784:c5ff with SMTP id
 956f58d0204a3-6361a7156eemr15045701d50.11.1759192659323; 
 Mon, 29 Sep 2025 17:37:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-765cf0f7308sm6437857b3.16.2025.09.29.17.37.39
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7810af03a63so8807382b3a.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192658; x=1759797458; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=P2cgGlU4+Pm0o0ncA+RLL0BzFjTZwhLaJSfOUD3zmQ2C6zD6rBOOlj0eFVW46daTNR
 U+0V4hYvQYJ4Zmnpczm+QWXweVM1hvsCArRBaBiMOC3M/IuOmcT0UxFUfwXIZ7f4yBF7
 C7Jj5mV6HG4k9JnvaqtecSwfUgKMEW0kEG5GY=
X-Received: by 2002:a05:6a20:2d2a:b0:311:f99e:e7ce with SMTP id
 adf61e73a8af0-311f99ee951mr5295456637.55.1759192657824; 
 Mon, 29 Sep 2025 17:37:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d2a:b0:311:f99e:e7ce with SMTP id
 adf61e73a8af0-311f99ee951mr5295429637.55.1759192657336; 
 Mon, 29 Sep 2025 17:37:37 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:36 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH 45/54] net/bnxt: add meson build options for TruFlow
Date: Mon, 29 Sep 2025 20:35:55 -0400
Message-Id: <20250930003604.87108-46-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

