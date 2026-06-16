Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F17ECD98E1
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 21:07:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAA1A40DD8;
	Tue, 16 Jun 2026 23:07:09 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id DCB344068A
 for <dev@dpdk.org>; Tue, 16 Jun 2026 23:07:07 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-13981833e13so2404478c88.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781644027;
 x=1782248827; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3k1viQxeLy8Q7jEjNSal4EsIM09ttytqkRnUmS3+wQ=;
 b=e4T27CIMUtdIG9Y/onetJJzodkTsYaB6PASOe7MIpAeDPi8pUu4hI/1vZCYSUhPlId
 YuuFZbnoKLP3C6inb2lN89+PbCVO1Xm6gaYC/JP2PkHcApzah0O65186p+7i8duGUjcs
 A3I5B9MKx6Uh9e0sZ7xTrRXw1oi8431CBFmatpl1cTNm/9cz3ZU40Oad/r5OIViM5BPA
 OWnnhjBSxLG2HXHMxvvpxPXlE+3nBJNMBNFCmDhoyrt5kSP17ZJRYhghximElqcm5ZgK
 Jd6nkKrlcUmlQzcovaDPuScFNzhYxmh8yxB1gtdHWjTm66U/nxoDo0W7jxwNBD3bmeRJ
 YvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644027; x=1782248827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h3k1viQxeLy8Q7jEjNSal4EsIM09ttytqkRnUmS3+wQ=;
 b=Iz4/hWaNGw4ThPBBJgDyWJM4/lRunTAVyMWDON7WD87f6I07poq9JQb+7Yk8Ydqhu8
 58RUY8WMx4i/0aBG1obwD1WAPFU8TPpvSDsJcALpOsoQgtQ1TguhH9I1djBHgStecSM6
 tqCDhjUge9KxPhOSAEC2jVYwVIkz2JcL4fPvqdRIK/7bUs5bJII7z7ywbE7O0aI/tSTO
 8pu0M2dsEFfviRfRdwf24BP5MF6X88N1YWHTZupsYrsAMe6NZFBq2114ZWe4R71kIoB0
 fxUAAljvaBGeFuEQvuaEPwW9XcR9pn/In0/OYXBy0msKufJ0zDzOq8f6q2mkBR0miQHY
 VYsw==
X-Gm-Message-State: AOJu0YzPdyVVQ5aJA/VSIQcA5snGXfKPKTupKMhxuNUioVkQPYRx4cC2
 3gKhgsRj8qIYqbwSNYtliSO1UXol5tEFWFpkgh2KYC63LZ3m8O1h0NaSMHbpOPx3TxPuRYFhHzV
 0bKUP
X-Gm-Gg: Acq92OEVFgP+L7INPfEpQIm1MyJKVARrj+RPzNer3LHD6kmJ1fxPoEVMKKBLKEWn03H
 K6COcUjeAIyD2tnkP4PNF+9VpKmO/O5wAWExaXPY/Cvr+Tylz83T2ALMNs6q6yDF3iGI0qF9iB6
 GmEynMCiA4Fzdt9zbrRTW+hv7MuZDv8O2ZofsyawWnEmIxSBKZr3z2A1PEUBw3gSZMs7sQYINQM
 Y3NuDwa2qNI1uJ1xN+Ex/kw4s29wMv3ryAXhMdE6eFGNkYFnfW3SAXxyF6zl3lKoN0ADtsndUoc
 mJBf2jk2Ql+t0kX9Wem+gTRc1mv215PzXbbXPahBzDiiXFcz/hjHzDO4q+WvqWzeaKLIl6oqr05
 obguzGIGkyly4s88TNuPVOmtT156MSU+4kKPhO7uCMBw0houRowWjQRgCK/tAyNmVkoD0OAPLvJ
 t1fg6v5I4UYrwtuem2JoXZLGyBK6whCXhd2nQrjEuArlJte+yCuRNQSLfqbecQRA==
X-Received: by 2002:a05:7022:983:b0:139:8616:3849 with SMTP id
 a92af1059eb24-1398f631787mr335257c88.4.1781644026959; 
 Tue, 16 Jun 2026 14:07:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b96d6c4sm15118446c88.9.2026.06.16.14.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:07:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 5/6] ip_frag: reject oversized reassembled datagrams
Date: Tue, 16 Jun 2026 14:05:37 -0700
Message-ID: <20260616210656.464062-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616210656.464062-1-stephen@networkplumber.org>
References: <20260616210656.464062-1-stephen@networkplumber.org>
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
index 7c1659002b..0b44275b37 100644
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

