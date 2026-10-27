Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24154606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sE2WekOA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8245740151;
	Wed, 28 Oct 2026 10:01:01 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTPS id 6E2CE400D7
 for <dev@dpdk.org>; Tue, 27 Oct 2026 19:21:23 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e8da6ef7ddso399485ad.3
 for <dev@dpdk.org>; Tue, 27 Oct 2026 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793125282; x=1793730082; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JEBjBlV0DLAJWOKBsaJgjB8/U5TR4ShJI8fGSA9/I84=;
 b=sE2WekOAkPXfKaf6QYRGEcEHnCYcu4yxDL7CQOu3+5u/wdGeRbG8aI2tLybquSxIdT
 I8Zih9ccRs800/gwsa3v/qp8zZ0kUwpFXaiAXc9PUgC43uGiepBOqMwLDk/VSHGSvjpq
 +B3m5SPEj9qoY3Ovukce8AF9RxEpfyv+QkAZ3xDy6OjmIm0/x7Ke/l2DQvlHHba7Dv5/
 dmEsbImzftRq/W35f0g0YA4c73NpKGied0A2cl2ZdcWlR5hSNjWDBfTYkG+hn8xAmZZE
 X9OK/U/EAwcATki6DMTvR7C7FO/PgcuFI2fA6iLIoLmxBgRlilyBIIjcG9dA/kKpzA30
 jk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125282; x=1793730082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JEBjBlV0DLAJWOKBsaJgjB8/U5TR4ShJI8fGSA9/I84=;
 b=YRgQdYRyOSdNHVjVH0HI8AIK7R2ISBr8EocEDIA1OAhwb6w6WdMs6CJxt7gsumTSA3
 Gz1PlJDf0fPGOQHRx0jbRULurX1LuSU2ehyaaVoUgXI2Tem5lVTl+pFDT3JRuws396eR
 kNduNiwucadfMq79L1bcFtrzBCM4b6oCtx5vaVuMFEEqZ+tSkEpO/92sUKuvp/qJbQ8m
 LRLVKuAf9300x7zfGIQGJlaF52qeBab1pgpErgd9yRshYGLyoGY1CKwx9/TXiGM7c1j+
 yD4n2P4HHytUEGfiJpqpY7Wly4jXEOksYmAAoxKK8KbQahrUOhpD5liV27wPnhjjyP9w
 Iuhw==
X-Gm-Message-State: AFq9FYJNr7r76zgx8PExlE6EpGp5147Gg3l48IaMPN5QIfQ0HThyUnX3
 a3StWztezlvM5czZmmkjXdcGBcTp5kJU6Yw9NHJ6ZikTZ6VDbcskImpx30tfMEqs
X-Gm-Gg: AYBFou0aU/lrou34Tm4EHhvWXB5ur4PO3j1MTfavU/OZJmb+iwzYuZoxBAoNlyXl/V7
 /5OkhHpU+I3p1K7NQ8QbEUNpDUM+kMqEZ1nEnUWP9bZiwpqNo9FYFQ3bayM5fJpbs7YTSMRIMKG
 HqZW3FT5OvDLum7Hvb/naiIlZy48jb1fhvZTrp12+aDcBZyiJqPYaC/8TI2x8Sz9wR/ZdyYf6XR
 vJRy2gZ5wP5FHUxlL6BRLH82829SiyO/ERjSlof1h/VzyC19QXwnvvWiG8C0q4UewJLuAqvJS6F
 XXdFaMeBGT4Eu7dVrVw2316Qfw7eQlGpx4DwM7vexwEN3sXpPcZYni9cC+4W/8esWiGegfnabxe
 zY0IIwuRMXyBkdWjbnE3/KwlGTKFJV3cw4pM51ewoQv+Oqxl88V0ig70QLxyZV2q64edPAOeTZU
 2YyaCzqFqXinPz2WMvIa7hsGicQEhLf6HvfEelU1Ee9KZQG5XY+Ck+vW5Q8Sq1AtKFyQAtds8mV
 h0g4uY2HpARxud4ymT39dmxj7gxesNGe42xMyjSCnYI1kdlo07PegAV4F3pcQHzkbblTVRVCGS2
 R9APy7OSvsen9+/hr2hkPK1ibBLh2Qw=
X-Received: by 2002:a17:902:cccd:b0:2e9:a090:dd69 with SMTP id
 d9443c01a7336-2eb00506cd3mr1609575ad.39.1793125281619; 
 Tue, 27 Oct 2026 11:21:21 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c84d6csm13054585ad.55.2026.10.27.11.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 11:21:21 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: weh@microsoft.com,
	longli@microsoft.com,
	stephen@networkplumber.org
Subject: [PATCH v3 0/2] net/mana: fix tx burst error handling and add TSO
 support
Date: Tue, 27 Oct 2026 18:21:13 +0000
Message-ID: <20261027182115.3666158-1-tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 10:01:00 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes transmit burst error handling and adds hardware TCP
segmentation offload (TSO) for the Microsoft Azure MANA PMD.

Patch 1 drops packets that fail validation, counting them in
stats.errors and consuming them, so rte_eth_tx_burst() maintains a
contiguous prefix and short returns reflect only ring backpressure.
It also clamps segment limits to MAX_SGL_ENTRIES_FOR_TRANSMIT.

Patch 2 implements hardware TSO for IPv4 and IPv6 TCP traffic,
formatting SGE0 for headers and subsequent SGEs for payload, handling
GDMA work request flags, advertising RTE_ETH_TX_OFFLOAD_TCP_TSO, and
handling non-TSO fallback checksums.

Hardware TSO segmentation was verified on Azure Standard_D8ds_v6 (kernel
6.8.0-1067-azure, MANA PCI 7870:00:00.0; driver reports no firmware
version) between two VMs on one subnet using an earlier revision of
this series:
- VM A ran testpmd txonly, modified locally to emit TCP packets with
  RTE_MBUF_F_TX_TCP_SEG set (not part of this series), after
  "csum set ip hw 0", "csum set tcp hw 0" and "tso set 1460 0".
- VM B captured the frames with tcpdump on its kernel interface, GRO off.
- A 4000-byte IPv4 packet in a single mbuf, in mbufs with a header-only
  first segment, and in mbufs with payload in the first segment, each
  arrived as 1514, 1514 and 1080 byte frames with consecutive TCP
  sequence numbers, per-segment IP IDs and valid IP and TCP checksums.
- Plain UDP with "tso set 0" was unaffected.
- The drop paths (packets exceeding segment limit, oversized MSS or
  header) and IPv6 TSO were not exercised on hardware.

The v3 changes (hardware field bounds for MSS and header length,
loop bound, unsegmented fallback checksum masking, and dev_info limit
advertisement) were compile-tested but have not been re-run on hardware.

v3:
- Patch 1: no changes.
- Patch 2:
  * Mask RTE_MBUF_F_TX_TCP_SEG in the non-TSO fallback branch so
    rte_ipv4_phdr_cksum / rte_ipv6_phdr_cksum calculate the full L4
    length into the pseudo-header checksum.
  * Reject invalid TSO packets (tso_segsz > MANA_TSO_MAX_SEGSZ or
    gso_hs > UINT8_MAX) to prevent hardware bitfield truncations.
  * Reflect the extra SGE for TSO in dev_info by setting nb_seg_max to
    max_sge - 1 (keeping nb_mtu_seg_max as max_sge) instead of a mana.rst
    limitation note.
  * Bound the TSO segment walk by expected_sge and verify SGE count.
  * Streamline commit message and cover letter.

v2:
- Patch 1:
  * Drop unsendable packets and return a separate consumed count (nb_done)
    instead of breaking out of the burst; break only when the ring is full.
  * Move MAX_SGL_ENTRIES_FOR_TRANSMIT clamp from patch 2 to patch 1, and
    clamp dev_info nb_seg_max and nb_mtu_seg_max.
- Patch 2:
  * Use the drop path for all per-packet TSO validation failures.
  * Honour implied TCP checksum when RTE_MBUF_F_TX_TCP_SEG is set but the
    packet is unsegmented.
  * Move GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 adjacent to
    struct gdma_work_request.
  * Add release notes entry and update mana.ini feature matrix.

Tathagat Priyadarshi (2):
  net/mana: fix transmit burst error handling
  net/mana: add hardware TSO support

 doc/guides/nics/features/mana.ini      |   1 +
 doc/guides/rel_notes/release_26_11.rst |   4 +
 drivers/net/mana/gdma.c                |   5 +
 drivers/net/mana/mana.c                |   9 +-
 drivers/net/mana/mana.h                |   9 +-
 drivers/net/mana/tx.c                  | 206 +++++++++++++++++++++----
 6 files changed, 195 insertions(+), 39 deletions(-)

-- 
2.43.0

