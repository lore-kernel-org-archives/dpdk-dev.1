Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2841C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 07:26:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D87240263;
	Fri,  1 Aug 2025 09:26:28 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id E788E40156
 for <dev@dpdk.org>; Fri,  1 Aug 2025 09:26:27 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-31ee880f7d2so1878565a91.0
 for <dev@dpdk.org>; Fri, 01 Aug 2025 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1754033187; x=1754637987; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RUmsKLO1d/QRyiYHp5wAq+gcZn04wmDtxPDtuF/s+gU=;
 b=Z/whK0V/mNOAhOd/tIIAydJINE4Zbk3Lu75+c664sYFlEej1X70a6QWdKYUL0Uaf8D
 hOvheqivUtDheAyOapQmHkp331QDXxX821gibdyxqGvZX74OC1PxzrNxdSxVRlkt9dhQ
 kURJ0MNrR0syfK4owBmixTlWQqG8C3YupXhqfXWhzVLqJh68gWWRmhXJRscjVE2UjRNV
 Fl6b6jwYl6dn1+6TBdByNkFVAxP2bWucTxszmIfJTgJKXhaIByCYXHp+xxkw6QKP+1/v
 /x0+6t/lhYH8r7XDZhh/RG1OT9U4Oh9fW3WEYGO1lbuwgpATqEnuTcK8sjRsUwhyG5Jx
 lkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754033187; x=1754637987;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RUmsKLO1d/QRyiYHp5wAq+gcZn04wmDtxPDtuF/s+gU=;
 b=UkbiDLdVjPc+jhcA5uMMNblQogYjJziwHbcEoPTwtNeNNg69gU6Ryv7buobQky3Luu
 tTc47yiBmYJqbCpdn8sbmRgpaS2PqXYC00hRKC+o8K2QlhsuNAcVP4BC4WH5xZ0rnGPx
 s1sk3SHCu/aLBLQ8y7Mipz7gKwbI7YIG+YbWFDj/Jwv02nUVL8EX90A6Wd5p/OZvjrsW
 Apq3iXptYjeBu7+lnX3Cev7GXVOexrBIJfkks6eyFoxPYaCg2EvZDMbU3XB6YE5X3t2j
 7HkCserJniOHSJNk/9LzMk2J2FtS/dnBKX9Kmz7R5ve0Ry3sx3x/nbC/wmZolVDypkmn
 hHYw==
X-Gm-Message-State: AOJu0Ywdgc0+4owalWc5zwMAlU6V2mt5SfEKeatQhuEmDbvIkQYzwqTX
 z4WWrRa3ooDq/60X9U5PtLVSAzSmV/J0kwnV6LFcJHzsY338cWM0zW+EJXu5IgUat/ZZOclt89T
 nTlGHkzNd38piihZK1QRdDlj4kl4WohKEsaCfbddzdGYUepj97LIwKCQ=
X-Gm-Gg: ASbGncsZcrrIipZuWjYYElIArv5enHRNIVXbHlahmvl+KszLYqIMXX0MpMASQjcwCau
 pgATemlON0ObH4MLWkeGcx6BKKP5xH8mhFuuQGYunIhAFmuQecq2AWOhUd7VW7iBJbXkvvlohlQ
 1ePAjjMf6OhH5hy3UZT4IpSWSxIjIwAX1+XP6CIO0/k3N/cMmjTSn5KTBXdUUDVuceIzkH52ViQ
 9h1kZFZIA==
X-Google-Smtp-Source: AGHT+IEHpDomf3aY9Kg8dMSUQF3c+wM/6+wi4SJJW0YUifKzSPvmuWe626NuRPAJjnej8nshBc6x/GAEwMc3awhtjNE=
X-Received: by 2002:a17:90b:5286:b0:313:17e3:7ae0 with SMTP id
 98e67ed59e1d1-31f5de7bac5mr13193486a91.34.1754033186528; Fri, 01 Aug 2025
 00:26:26 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 1 Aug 2025 00:26:26 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 1 Aug 2025 00:26:26 -0700
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Mime-Version: 1.0
In-Reply-To: <CABsP7wOFAsE2-BmnHZW1c3rOkkrUWfox7qrbim6zmP6gbmJqzg@mail.gmail.com>
X-Original-From: Su Sai <susai.ss@bytedance.com>
References: <CABsP7wOFAsE2-BmnHZW1c3rOkkrUWfox7qrbim6zmP6gbmJqzg@mail.gmail.com>
From: Su Sai <susai.ss@bytedance.com>
Date: Fri, 1 Aug 2025 00:26:26 -0700
X-Gm-Features: Ac12FXyi5fIqFa2IujNJI8r1bO1qhHh0O7RD1Pw9rQ-Hv2bEEvnqGLJs3UBYV1Y
Message-ID: <CABsP7wMkh1WuvJLVt-+yQAevCr83oGTO7o-THOb4_z6MTTgZXQ@mail.gmail.com>
Subject: [PATCH] net/cksum: compute raw cksum for several segments
To: dev@dpdk.org
Cc: Su Sai <susai.ss@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
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

The rte_raw_cksum_mbuf function is used to compute
the raw checksum of a packet.
If the packet payload stored in multi mbuf, the function
will goto the hard case. In hard case,
the variable 'tmp' is a type of uint32_t,
so rte_bswap16 will drop high 16 bit.
Meanwhile, the variable 'sum' is a type of uint32_t,
so 'sum += tmp' will drop the carry when overflow.
Both drop will make cksum incorrect.
This commit fixes the above bug.

Signed-off-by: Su Sai <susai.ss@bytedance.com>
---
 .mailmap            |  1 +
 lib/net/rte_cksum.h | 26 +++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..838b544a97 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1891,3 +1891,4 @@ Zoltan Kiss <zoltan.kiss@schaman.hu>
<zoltan.kiss@linaro.org>
 Zorik Machulsky <zorik@amazon.com>
 Zyta Szpak <zyta@marvell.com> <zr@semihalf.com>
 Zyta Szpak <zyta@marvell.com> <zyta.szpak@semihalf.com>
+Su Sai <susai.ss@bytedance.com>
diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
index a8e8927952..aa584d5f8d 100644
--- a/lib/net/rte_cksum.h
+++ b/lib/net/rte_cksum.h
@@ -80,6 +80,25 @@ __rte_raw_cksum_reduce(uint32_t sum)
 	return (uint16_t)sum;
 }

+/**
+ * @internal Reduce a sum to the non-complemented checksum.
+ * Helper routine for the rte_raw_cksum_mbuf().
+ *
+ * @param sum
+ *   Value of the sum.
+ * @return
+ *   The non-complemented checksum.
+ */
+static inline uint16_t
+__rte_raw_cksum_reduce_u64(uint64_t sum)
+{
+	uint32_t tmp;
+
+	tmp = __rte_raw_cksum_reduce((uint32_t)sum);
+	tmp += __rte_raw_cksum_reduce((uint32_t)(sum >> 32));
+	return __rte_raw_cksum_reduce(tmp);
+}
+
 /**
  * Process the non-complemented checksum of a buffer.
  *
@@ -119,8 +138,9 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 {
 	const struct rte_mbuf *seg;
 	const char *buf;
-	uint32_t sum, tmp;
+	uint32_t tmp;
 	uint32_t seglen, done;
+	uint64_t sum;

 	/* easy case: all data in the first segment */
 	if (off + len <= rte_pktmbuf_data_len(m)) {
@@ -157,7 +177,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 	for (;;) {
 		tmp = __rte_raw_cksum(buf, seglen, 0);
 		if (done & 1)
-			tmp = rte_bswap16((uint16_t)tmp);
+			tmp = rte_bswap32(tmp);
 		sum += tmp;
 		done += seglen;
 		if (done == len)
@@ -169,7 +189,7 @@ rte_raw_cksum_mbuf(const struct rte_mbuf *m,
uint32_t off, uint32_t len,
 			seglen = len - done;
 	}

-	*cksum = __rte_raw_cksum_reduce(sum);
+	*cksum = __rte_raw_cksum_reduce_u64(sum);
 	return 0;
 }

-- 
2.39.2 (Apple Git-143)
