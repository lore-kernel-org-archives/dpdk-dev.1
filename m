Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16873C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E16BC40A6C;
	Tue, 30 Jun 2026 17:37:42 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 53EA3406BC
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:37:33 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30bbe98c3f0so939696eec.0
 for <dev@dpdk.org>; Tue, 30 Jun 2026 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782833852;
 x=1783438652; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KyU0YnqxSGX7YJw9w2a3Tb9GMF3tR5rVB3ahj3FXdo=;
 b=mnxAODBA+zaW3zEbP8t9b7wPXdrKMoFTB1Snff60BMaPk+xMw6iPAahKvQhcsgf76D
 102BQjcGUWegDsQZF7E7L2F78JvE/54NLytI2P5tlr0+MDxajtWZDe7OU4E1gHh3EQ6y
 b8J2AZxMJa+YpQmCqcjiPmEgHKC2XKpi4zXol4wHWyeQvdsgWBgv1GQ3bL+ksNoSZwjq
 zcu7DD0ukAMDA2JZrdOudfFbP/V7CK1Md6DxkouGGJhZnvY/DvzDDWMIb9BdxLUJ9j78
 RLULDSmuCPgp5muJECZSSEvO6QFCBmY/knFlJaRSqjoTijXY459kgaSBXgfqG+1QquqZ
 af8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833852; x=1783438652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7KyU0YnqxSGX7YJw9w2a3Tb9GMF3tR5rVB3ahj3FXdo=;
 b=cDOVZCB+/zpJsFkxNQ9k0Q3Nm/mzRklTKZdiQMrlCP3FySYSTs7lEL6mnC1GF0Evbm
 7Y2w5d4bIRme/I6KjiyqUIty8b8H1LCv+HwvmnqY27jaIWkCMtdJwFD56zYUkt9jArJO
 NfSQx96W0DmI0YX4lVO2gb2qiyTJFx2jMWU5GIEiQKQPi0GnReuhuEw96K5x/sOgrUIG
 9lLhWkYQjxU+L+fLQxeb9IvG2oe8pZneujYJOxJKXUSkhOSKO/+vsVp2HHMyD/CJequM
 dJldJ5rQpeqjR6tKn+jBWMUdrAaonAcCZdcaFrGn5xjC0oxhf9Dttw1Qn/HIbzMJWgz1
 eY/w==
X-Gm-Message-State: AOJu0YwPPVKlaNejic1JRoigoCo0Z+pRg4+TJP5Q908lbMaZ2zYOmSOE
 QQbV9CnWP86isbfnNe5dAF1Rkr4yiSOUfSV179yLhZlJhJJG+xjqZwa3jH5ha45LDhON1eoZH/7
 bhFul
X-Gm-Gg: AfdE7ckExntcGTDk6HGejnWwMeXtkSTT6FOsNPNtCWoHyyYx9QqsQwG1Fz0TgnEgQaA
 mB0Jpc9i31eweunj/SxSWE9gfZD0F9z+9FKVtJE/Ws1piY1P9xf98ug0hZf/KHNZ5od4EtYsA5T
 Gsbi2/YGlNznMRLrKaF25kftxljpAVD1VjDcZ2GzByPMPhRulycU9UxFbwyT/mROmdEFIuMszIN
 ZSzx7fxmTwQ799yBCT8VzAUMO4AZbSTqd1gUF2EWu1za3wci63kAIGt2VsJQtz3eOTMXtWcR/1z
 HXDNhH2+R1BMCiwlFira1B5Cddqk6pB/jnRlAd7mEEXv20zRme8RN+6pfh6LxVL1XKn4v6IRk4Z
 zJF9rc++sLbS7xKXFeBwzTzre78LWKD2JAQ6Xws0Ic53AYb38YlcQUR653llLYkw38rwUCMfzfY
 CxNLiA90LQdnkdqD6Q1x7mnIWRqsNDPDWRXjU69wfEMTGM4Lcdoi8=
X-Received: by 2002:a05:7300:7242:b0:30c:ab4d:da33 with SMTP id
 5a478bee46e88-30ee1412116mr3028315eec.37.1782833852037; 
 Tue, 30 Jun 2026 08:37:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm9072139eec.10.2026.06.30.08.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:37:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 5/8] ip_frag: reject oversized reassembled datagrams
Date: Tue, 30 Jun 2026 08:36:17 -0700
Message-ID: <20260630153723.525167-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630153723.525167-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260630153723.525167-1-stephen@networkplumber.org>
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

The reassembled total length of a packet must not exceed 65535.
A fragment with a high offset could drive the sum past that,
causing silent truncation since IP payload_len/total_length is 16 bits.

When reassembling a packet the total length should not be allowed
to exceed 65535. A fragment with high offset could drive the sum
past that, causing silent truncation.

A valid datagram never exceeds 65535 bytes, so reject any fragment
whose resulting length would exceed that.
Fold the test into the existing zero-length check.

Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ip_frag/rte_ipv4_reassembly.c | 9 +++++++--
 lib/ip_frag/rte_ipv6_reassembly.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/ip_frag/rte_ipv4_reassembly.c b/lib/ip_frag/rte_ipv4_reassembly.c
index 980f7a3b77..727fc58243 100644
--- a/lib/ip_frag/rte_ipv4_reassembly.c
+++ b/lib/ip_frag/rte_ipv4_reassembly.c
@@ -136,8 +136,13 @@ rte_ipv4_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 		tbl, tbl->max_cycles, tbl->entry_mask, tbl->max_entries,
 		tbl->use_entries);
 
-	/* check that fragment length is greater then zero. */
-	if (ip_len <= 0) {
+	/*
+	 * Drop fragments with no payload, and any fragment whose end would
+	 * make the reassembled datagram exceed the maximum IPv4 size. The
+	 * total_length field is 16 bits, so otherwise it is silently
+	 * truncated while the mbuf still holds the full length.
+	 */
+	if (ip_len <= 0 || ip_ofs + ip_len + mb->l3_len > UINT16_MAX) {
 		IP_FRAG_MBUF2DR(dr, mb);
 		return NULL;
 	}
diff --git a/lib/ip_frag/rte_ipv6_reassembly.c b/lib/ip_frag/rte_ipv6_reassembly.c
index b6f623d53b..9aa2f2d08b 100644
--- a/lib/ip_frag/rte_ipv6_reassembly.c
+++ b/lib/ip_frag/rte_ipv6_reassembly.c
@@ -174,8 +174,13 @@ rte_ipv6_frag_reassemble_packet(struct rte_ip_frag_tbl *tbl,
 		tbl, tbl->max_cycles, tbl->entry_mask, tbl->max_entries,
 		tbl->use_entries);
 
-	/* check that fragment length is greater then zero. */
-	if (ip_len <= 0) {
+	/*
+	 * Drop fragments with no payload, and any fragment whose end would
+	 * make the reassembled payload exceed 65535 bytes. The payload_len
+	 * field is 16 bits, so otherwise it is silently truncated while the
+	 * mbuf still holds the full length.
+	 */
+	if (ip_len <= 0 || ip_ofs + ip_len > UINT16_MAX) {
 		IP_FRAG_MBUF2DR(dr, mb);
 		return NULL;
 	}
-- 
2.53.0

