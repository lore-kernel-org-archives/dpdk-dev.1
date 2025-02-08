Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBEBC02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD77E402D7;
	Sat,  8 Feb 2025 21:32:16 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 997EA40650
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:13 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2f9bd7c480eso5786516a91.1
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046733;
 x=1739651533; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwumik8AL9gXNbaQcQoYUzwtaLs4pzRfeSyg3VNOr0g=;
 b=h4wgPFyVkwFbqnUA3VFNVaDfamreY9PxJhrSOlPQKfW+ppZ1B+yQcA4T+qNE9P2N70
 Ji3yHDdFK7SFF3OWS3NiVPZNfNumH/wmz6AJbQa7ufC1EbgBuYuvJQJ3JAuDdbFDfleE
 sv5B2nhPhPXZmw3ChHfpuUshHYaDSl0A7OnidUmzT0RFKSOGOhM6tnYirvV+Gkf42geQ
 japxbLzr3TETrnwlEmvSB9ltfKGmeIBT9/DRL8gMIDO9oABn8f2CH6z15TbqMJvMgX3M
 a0poLHEiQar82C9UmL4BWMicppGGmwYJfZX/wj0JllWYXs8+shH9QYU3mwvGMSDQmOme
 0bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046733; x=1739651533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwumik8AL9gXNbaQcQoYUzwtaLs4pzRfeSyg3VNOr0g=;
 b=Uomg9BU9cs0TmQqgHXHRTj3rLWIGyBGw7r17lAd06b76nREjtOQV3jZ7B5jA0azCod
 Q6p2iepyEB5SqlrqbHTPtlAtkfQ35Sn03JwiKpxjqSBsxLpeG3PrxOtUGr/jU2dLcjTn
 4p7eQ9qHBM1AQeoVtDQDWVNPZflrEZmW/SeoB0DvbHEbGJvYu01DGJ/Dv0RzV9KESTvG
 2udhWRV/GdagO2tgOQvOzm7Ghc7cC/eBDkJS16OSllYJR4RNx0WUlJ6gwl/NUTSFikRx
 /BuSiaOtmAe407LxpZQijroTLGn1tlZzvysOiRfWsQ0P7vqA4CTqev/I9+kofTsil7zV
 pIPQ==
X-Gm-Message-State: AOJu0Yzf9LTWtMxg11LW7f87ffIIIA4953XcaU8qNkPO7Sz8/m43U1Cq
 n0LQESj7aaTGAkEx1o5DEhEoccs4hosIGerle8fvw0E13clNdlA4D/dVf6zTb+Ob7EWR/nPaATS
 7Hh4=
X-Gm-Gg: ASbGncvPMYyb3Fhht8IVQEFzgLHrpux5SLXPtnWVNLf3iVrYEsaMhj/2MCVVq9tlKTJ
 qHcmkRAlToL4CtrvTwu+mTpMWNTNYW4BUTXFT790uX+uW8Diz50TFhtgjRI4lgqSpAIGi6ignby
 q6rBE4yB5FCYkwa7Hqdrt7jHtBxjyv28RJLMS1ZppgDf56vAGDmyKWKci1a1DVaN7ti42qUTkNh
 FyZC+UGjAoOuV7K66f5XQvt2KWxLaI8IHURSfzw/X84OX16Om14wuGEGoqC3Bsiu/hyVL1L6ofo
 Av2bpm8oiOLrYQ4PGTX5Q/jMq4q+jZTOjJWcP4h1KLVcs+QVmtaF/6RBPFQiN7d45Lb8
X-Google-Smtp-Source: AGHT+IEJWY8kDKGAFRT13tmS0EMay7XCzz5PIJEurrbktLjWvHWlaR2EtNX7iIO88MtWxTogNVALzQ==
X-Received: by 2002:a05:6a00:6f1a:b0:730:74f8:25b9 with SMTP id
 d2e1a72fcca58-73074f8430cmr4672837b3a.17.1739046732745; 
 Sat, 08 Feb 2025 12:32:12 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH 15/32] net/ntnic: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:07 -0800
Message-ID: <20250208203142.242284-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/nthw/flow_api/flow_id_table.c               | 4 ++--
 .../nthw/flow_api/profile_inline/flow_api_profile_inline.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/flow_id_table.c b/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
index a63f5542d1..61cec41590 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_id_table.c
@@ -99,7 +99,7 @@ uint32_t ntnic_id_table_get_id(void *id_table, union flm_handles flm_h, uint8_t
 	struct ntnic_id_table_element *element = ntnic_id_table_array_find_element(handle, new_id);
 	element->caller_id = caller_id;
 	element->type = type;
-	memcpy(&element->handle, &flm_h, sizeof(union flm_handles));
+	element->handle = flm_h;
 
 	rte_spinlock_unlock(&handle->mtx);
 
@@ -139,7 +139,7 @@ void ntnic_id_table_find(void *id_table, uint32_t id, union flm_handles *flm_h,
 
 	*caller_id = element->caller_id;
 	*type = element->type;
-	memcpy(flm_h, &element->handle, sizeof(union flm_handles));
+	*flm_h = element->handle;
 
 	rte_spinlock_unlock(&handle->mtx);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index ff8eb502f4..5565a7857c 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -3099,7 +3099,7 @@ static int convert_fh_to_fh_flm(struct flow_handle *fh, const uint32_t *packet_d
 	if (fh->type != FLOW_HANDLE_TYPE_FLOW)
 		return -1;
 
-	memcpy(&fh_copy, fh, sizeof(struct flow_handle));
+	fh_copy = *fh;
 	memset(fh, 0x0, sizeof(struct flow_handle));
 	fd = fh_copy.fd;
 
-- 
2.47.2

