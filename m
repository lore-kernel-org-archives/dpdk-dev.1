Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946C5C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:37:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBF9A40697;
	Tue, 30 Jun 2026 17:37:31 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 6375B40611
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:37:28 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30b6dad2382so8627373eec.0
 for <dev@dpdk.org>; Tue, 30 Jun 2026 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782833847;
 x=1783438647; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSziaTriju5DyBOpv4fkIbsn++AVoA68cfGSuGqt0o8=;
 b=DBKG1cyoUOZcrvruBWgQwphiYfFETOlbTzkYcTpJZtF0O8UvLg19rL+6wThahEnECm
 aAOz6Sf2bwD0VoHlnCGRYK2FLIatEYDJd+diQWmbtFgYgMxtiJ7ESRQrr1JWevXNe6w3
 W32AUgY2KIQsDPwvScuboXCtzM+x9YNI71d5hnOrvXMIrj5MYKiGvlw5kFEiq7kEn/Zs
 TLNzLGOoctbfvU1spq/K3HxlWZJZdcCCTofEwh97y6exZRxnsSQ2Uw0zN1eoEoi5ApN7
 IZ9K/t0Az6WGshRsXiwwr9GOE/WNS1Zgd8VnTHqJwHVAbTwy7CZVJE+Ick6JGmme16/Z
 vdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833847; x=1783438647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MSziaTriju5DyBOpv4fkIbsn++AVoA68cfGSuGqt0o8=;
 b=bMP83s/LUe7/qejPa54Sob9PrjUcNA7hHx/x9QPzoE3nmO6pQD2xc5XkLM5XkY+MbF
 NSD2XQIYFgjahTZ4lmfzScMbF/2oldbIuFmlvVZiC3w9hcQ5HX9wsypvJiP77vNtcubb
 KXrW8kjTIQNWjLyVXoRo8KyGCmxDf/OsfUszL4lSjVX/FD03zcJ7DB6+8etsdYX+CI7b
 UxcP0VgAZQTYHbmmoeY9Ul8djimr9XgBvACb18fCcLrRPkWPbrJfM5PnQ0iiK9n2rBcY
 kdhWzGWwkQICat074XsiwVVZtD+1jjy2wQfFQGGjuhPvfqSWU4fwXpyPNSWXcKjklJwR
 f8pw==
X-Gm-Message-State: AOJu0YyFzkYPt4RULKnnNPPMMYFtU0Vwi07z9SoxEOxfrX+fTDd/DmUJ
 3vjV9n10rswoxHd7SEc3+EQQXls0vyGSE5K1fYelIaw9NtExo9SYIQ5L6haFxmVs+WSO4Sp3cHp
 NkQZo
X-Gm-Gg: AfdE7cnHg9ANvAFeC3qoXw4udDcV1aD+/Jar8Q8etcnjeapYd2U92QDondHKO5RDKFS
 jaiEamEOwzlyElH1H9cVZSlcJq6ylZU4xEhG5WxJ23en/N2tzKqehiRibMuBbg1tO8XFctgH4Nw
 pu/hdPo8IigEY7S0Z+VkiAauUUkPc2lc39r/0VwjstpKz9zcVYI+YQoybm2TapouzJ/sx5ljA7e
 97s96KmYp0tzkpzg9IGrGaa31LjAPCD7xG/RoXAKA1vtOTcGbORJdpEwvzCG8piRPA2BQ58vId4
 cZolBw4wMy7UggKs304RnuD3yDwCsyyvWAOVZUHDKZwYojFyETNajUaN9gdh3t9t3WfNnlWdOER
 xq29u2aIDXB5Kp8bmg5tctXo61Pa0v1peZBmEVh4b1qEX+KEoefFhf9Oj7DGSEAsRhsjNfwn5Z5
 SBEU1atuQakLR+fOcDDnXgbYOWZptvaElgOqaQYmjOl/bNo6bMgARMmVpICPp93g==
X-Received: by 2002:a05:7301:1f09:b0:30b:e14e:b5e0 with SMTP id
 5a478bee46e88-30ee13a10e8mr2932695eec.34.1782833847098; 
 Tue, 30 Jun 2026 08:37:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm9072139eec.10.2026.06.30.08.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:37:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Samyak Jain <samyak.jain@amantyatech.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 1/8] ip_frag: tolerate duplicate fragments
Date: Tue, 30 Jun 2026 08:36:13 -0700
Message-ID: <20260630153723.525167-2-stephen@networkplumber.org>
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

The reassembly code tracked only a running byte total and reserved slots
for the first and last fragments, with no check for a fragment
duplicating data already received. A single duplicate could destroy a
recoverable datagram:
 - a duplicate first or last fragment collided with the reserved slot and
   sent the whole entry down the error path, freeing every collected
   fragment;
 - a duplicate intermediate fragment was appended to a new slot, inflating
   frag_size past total_size so reassembly never completed.

RFC 791 reassembly tolerates duplicates: a fragment covering bytes
already present carries no new information. Check for an exact duplicate
(stored fragment with the same offset and length) and drop only that
mbuf, before frag_size is updated, leaving the entry's accounting
unchanged.

Overlapping fragments with differing bounds are a separate issue
addressed in the next patch.

Reported-by: Samyak Jain <samyak.jain@amantyatech.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ip_frag/ip_frag_internal.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/ip_frag/ip_frag_internal.c b/lib/ip_frag/ip_frag_internal.c
index 382f42d0e1..9a03ef995a 100644
--- a/lib/ip_frag/ip_frag_internal.c
+++ b/lib/ip_frag/ip_frag_internal.c
@@ -89,7 +89,23 @@ struct rte_mbuf *
 ip_frag_process(struct ip_frag_pkt *fp, struct rte_ip_frag_death_row *dr,
 	struct rte_mbuf *mb, uint16_t ofs, uint16_t len, uint16_t more_frags)
 {
-	uint32_t idx;
+	uint32_t i, idx;
+
+	/*
+	 * Discard an exact duplicate fragment. If a previously stored fragment
+	 * already covers the same offset and length, this fragment carries no
+	 * new data. Reassembly is tolerant of duplicates (RFC 791), so drop
+	 * only this mbuf and keep the reassembly entry intact rather than
+	 * treating it as an error. Fragments overlapping an existing one with
+	 * different bounds are not handled here.
+	 */
+	for (i = 0; i != fp->last_idx; i++) {
+		if (fp->frags[i].mb != NULL && fp->frags[i].ofs == ofs &&
+				fp->frags[i].len == len) {
+			IP_FRAG_MBUF2DR(dr, mb);
+			return NULL;
+		}
+	}
 
 	fp->frag_size += len;
 
-- 
2.53.0

