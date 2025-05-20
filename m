Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94333C54E71
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 21:17:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE61240E18;
	Tue, 20 May 2025 23:17:29 +0200 (CEST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52]) by mails.dpdk.org (Postfix) with ESMTP id A4AA440E17
 for <dev@dpdk.org>; Tue, 20 May 2025 23:17:28 +0200 (CEST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6015f8d4b7dso1450933a12.1
 for <dev@dpdk.org>; Tue, 20 May 2025 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747775848;
 x=1748380648; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hO/cMzxTHbkWA++oAb82gQcYn/NnauoGuwobhvTtZlo=;
 b=gzWg8zmhEQM9pF8Hm8EbcNQVPa5Ke6hcifFR6A/2Hfvc3PenQawKyFCIHZIh5v43Mf
 uMt8EHf81+VwGd0gLp4Ufv3ot55YFIgZdJiGmLQcstbISF4ssqiLBsoR2ejhT2m9xncq
 ONsIihSzH48FJGbLF3cHLdMzZ9CuTOfZgAaC/3xtT48ALBBbrASp1HgO29vM5OWlNycr
 ns6pTlsfrNilYD9vJb0gT6tNz4j9s/6U+9p44QGTnfgZ0AB7aP5ca30bCwjaD73n6thF
 9rJZl1Abpynpe4Dss6VN1tOtptvgVJVAEOgSgZ084dPgGe2ilok+HidKvHg5Uqlx7qR4
 xv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747775848; x=1748380648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hO/cMzxTHbkWA++oAb82gQcYn/NnauoGuwobhvTtZlo=;
 b=s3ohuwFvJCSsxeORB4Rz2VCTCIxLFfT/9y/pTnDx+1FKWiVd4z+ilFQgvXIWZhykAS
 DTK7c08CAN2JIEOsBdEbdYLXYADKCZUaQnXLStgQpDQI2JlJJG9ayvivzloy539laM7g
 Ngr/dYdC9UfG9vDewkZN8wRC71T49UXDivWgotdTNoSoOYovrNsxob8YH48/M/nQYjfa
 B8ENwMaSczxjpET26xWEa0Xqkj4STQBnO414lVyxQa2n+8+dcg56WtE1tBH4Bdt/LGvv
 tQqgpJ7zR5mt4/vC7/ZyXmXphjjXkgJ4O1nT1W/E3BCuhavKzloyEh1VBKcAkrFXJcTr
 VPYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXg1+QfReUTflffuSKBOz5A4/gRCarNC4buMhP/njCm83/aPN9bTtZBk2kP0jIDeHlZzE=@dpdk.org
X-Gm-Message-State: AOJu0YyBetvvrNWeQTspxIsp7uK5o3+O8qVnFqTHqF3aLHUGnAdSvzhi
 jNtTbRE5b8H0U1jimIVfyDW1oi1rWBsJXicK+qj5iY5VOnd0dAE0P3wR9qM60gQP5Nc=
X-Gm-Gg: ASbGncvi+o6b+LmVClpe3sqCZ98hjF77a6BiKSvJyycNNS/Zv66IwDQrnW4nNCzH53y
 secXVqvXS6hcTSy6duJPDZE1tKdZE0PPIudTA1HPG3csJQlEqCg772bzsryws2sNVkBiSS/r5c0
 Yr93AbXGzAj+40ibM4KPmGGesnYuV52swYzdcq2aBWSDYofuJN2PUUcMNwHOwme6p8KolYoPYRA
 7j0LKfRdX++TwW4DqyoY//+DYT6oCzlOpmlyaNvvTqHvDjXzawJXGZBmzADLp8+vixRPB8dVrSc
 vj5u+dqBDuIIsp+epxaxT8dwRCB5AKpEtHDJ14rQchXroC1znoQTk5gAhDsnI0dw0XRv9TwaXy1
 QGFK4+/aY27LttFB0Ne8Gwq6cJvw+xDEHY0h6uD0=
X-Google-Smtp-Source: AGHT+IGYeOeEzc4DoFqwTFLWtF3kGBAkhLy3NobN+1ZtOBD24O7Z1JvhGDdrlSGbzGZs8+dtgm49hA==
X-Received: by 2002:a05:6402:254f:b0:602:1b8b:2904 with SMTP id
 4fb4d7f45d1cf-6021b8b2cbdmr2546480a12.0.1747775848077; 
 Tue, 20 May 2025 14:17:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ae3b630sm7687570a12.76.2025.05.20.14.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 14:17:27 -0700 (PDT)
Date: Tue, 20 May 2025 14:17:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH 2/2] app/testpmd: clear stale internal len information
Message-ID: <20250520141711.0b9d481f@hermes.local>
In-Reply-To: <20250519160711.4024414-2-skori@marvell.com>
References: <20250519160711.4024414-1-skori@marvell.com>
 <20250519160711.4024414-2-skori@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 19 May 2025 21:36:56 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> hdr_lens is used to maintain header lengths after parsing packets.
> When port receives different type of packets (say first is VXLAN
> packet and second is GRE packet).
> 
> For first packet, L2/L3/L4 lengths are set for inner and outer header
> alongwith tunnel_len.
> 
> Now for second packet, tunnel_len is added more than its size it
> contains stale value which further leads to wrong header pointers.
> 
> Hence clearing stale information before processing each packet.
> 
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>

The initialization of hdr_lens then becomes redundant.

Maybe better to just move it into the loop.

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index fa0002d321..203af35cf0 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -627,7 +627,6 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
        uint32_t rx_bad_outer_l4_csum;
        uint32_t rx_bad_outer_ip_csum;
        struct testpmd_offload_info info;
-       struct rte_net_hdr_lens hdr_lens = {0};
        uint32_t ptype;
 
        /* receive a burst of packet */
@@ -666,6 +665,8 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 #endif
 
        for (i = 0; i < nb_rx; i++) {
+               struct rte_net_hdr_lens hdr_lens = {0};
+
                if (likely(i < nb_rx - 1))
                        rte_prefetch0(rte_pktmbuf_mtod(pkts_burst[i + 1],
                                                       void *));
~/DPDK/main $ 
