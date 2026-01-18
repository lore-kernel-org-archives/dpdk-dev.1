Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BCC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:15:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A02B42707;
	Sun, 18 Jan 2026 20:14:07 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id 091C04161A
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:05 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-64bea6c5819so6048129a12.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763644;
 x=1769368444; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TOr96H7fH3mKjIL0bRc6v7l2xR9FPNagRBKBRGNmJUU=;
 b=1AGZzTh5d4f9C37GE9NSW7KH7r7jQ3TI7yJFzRf49Ubp5AqRUXDaUW0wGEiYkL+1b9
 6MEEXw+IptT/Rqlz72hu6iYM1zlhuN9RebpR35xWLlEtjArioTdpVHA7Njj5XdFFHooj
 ugejpsEX7uJXiXiDHPaodm39VuefceuDL04iCYCKd6v9a6dUvynP7XvQMCQG0iePwuuw
 9ag/FlyzI8G+d1WzvVQKAEZcGwxKRXImUfUMKXZTPuIDSpMhp8fCjZcGc2cDljqkUzeS
 /fCvfWfgIQj0yWGD9XgGuCEYRE5B18hEdD/MlrPOU0pY32OiQTAyb9iImCkciQ1vGCCl
 6NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763644; x=1769368444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TOr96H7fH3mKjIL0bRc6v7l2xR9FPNagRBKBRGNmJUU=;
 b=xGEDXRk4b0ZO0QFmYZK5Sy1PaLDZCZdmcT+x+fCL9F6X7YPHdaTJ/aogO+eSnp6izC
 agjUxzrFvZjHWQixGig9zJwJZL7iX+dnXZJNmMqLUm4iQetBthJ+XZJlzalkAHdfbiWc
 TNzA1jpQo63xs7Y8VzZeRFXbgxFSD7Nvb4u0gDCyBGYNyJ+Xr834LXJoTQfWCxBcIv/H
 nQdn1/1vgU4Pra/iQphR5ZSzuIiKJ7o7bmgJl1RsMH63HR7PbpaZXsmF5MsfNjUbXLxv
 AV/NU1rO9Ifi7XJgseeGkISkOKSnCXsmLkUP9d3uBVdGPstfcGpy7fcc5uWaW5K40oQs
 vsng==
X-Gm-Message-State: AOJu0Yyt/IOGteyA6D1Z8mVjZCnMYYxmCCkwaGoGgk4t/7uaUPJDsn4M
 EawG4JRa/ZV+Pqi6i7YgA9I/IK2qOmSJUmRbA59oN8NjDCJ5AREZuCcjPcdxsy4U9i6Wwbf+c3z
 cM+LL
X-Gm-Gg: AY/fxX77kM28ZgVpsppkQRl5z1sCcvnTiJTHVgjL55PUfIwDMj4idqw4yf+EBZYe/Qe
 FfXa0gA57GLt8h3XiZfLv1/68WSzHYwOaQetfvUHFjs+7fR9F6iszwIT+BfjNIUEwE7DdvXty3H
 7EqzbH7dvQrxXXu8IEFbjxhfMbZ3UdHI5Z12PN7svAIOyljeG46TXIu3luLv3BDwkMJFHBNUjjJ
 b0rwbyi61MV0i1KjEQoyJViPk2CLmrG3S2ej/gT76Wvj3QEm1Tb/lGyPvbScXLZOF2u3PwMnapI
 3qsOGDuSZIfd83pmpjmfGDjVicbMR66N5KWBG2byHmPsizGBPxu+rFE7+/2UVtlw7PpWKM22HkJ
 RYEiyh85AHckXpAouuYNhG9S327S+j1i7zZfM04GlhJ8fLU5SXfnCu3K9VS6c7bGZQekk9+5hdL
 MIWfIZ4YHRHWRNzeA5T+09eiZ1/ue+Wu4QIhmw8FPneK82XYFI8w==
X-Received: by 2002:a17:907:cd0e:b0:b87:10fd:b590 with SMTP id
 a640c23a62f3a-b87932b766cmr762068266b.60.1768763644581; 
 Sun, 18 Jan 2026 11:14:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 23/54] doc: correct grammar and typos in IP fragment guide
Date: Sun, 18 Jan 2026 11:10:26 -0800
Message-ID: <20260118191323.241013-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct several documentation issues:
- Change "It's data field" to "Its data field" (possessive not
  contraction)
- Change typo "filed" to "field"
- Change "mechanism have to be" to "mechanism has to be"
- Change "mbuf's to be allocated" to "mbufs to be allocated"
- Change misplaced period in function name reference

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/ip_fragment_reassembly_lib.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/guides/prog_guide/ip_fragment_reassembly_lib.rst b/doc/guides/prog_guide/ip_fragment_reassembly_lib.rst
index b14289eb73..aa05ce8a46 100644
--- a/doc/guides/prog_guide/ip_fragment_reassembly_lib.rst
+++ b/doc/guides/prog_guide/ip_fragment_reassembly_lib.rst
@@ -18,12 +18,12 @@ For each fragment two new mbufs are created:
 *   Direct mbuf -- mbuf that will contain L3 header of the new fragment.
 
 *   Indirect mbuf -- mbuf that is attached to the mbuf with the original packet.
-    It's data field points to the start of the original packets data plus fragment offset.
+    Its data field points to the start of the original packets data plus fragment offset.
 
 Then L3 header is copied from the original mbuf into the 'direct' mbuf and updated to reflect new fragmented status.
 Note that for IPv4, header checksum is not recalculated and is set to zero.
 
-Finally 'direct' and 'indirect' mbufs for each fragment are linked together via mbuf's next filed to compose a packet for the new fragment.
+Finally 'direct' and 'indirect' mbufs for each fragment are linked together via mbuf's next field to compose a packet for the new fragment.
 
 The caller has an ability to explicitly specify which mempools should be used to allocate 'direct' and 'indirect' mbufs from.
 
@@ -41,7 +41,7 @@ Each IP packet is uniquely identified by triple <Source IP address>, <Destinatio
 
 Note that all update/lookup operations on Fragment Table are not thread safe.
 So if different execution contexts (threads/processes) will access the same table simultaneously,
-then some external syncing mechanism have to be provided.
+then some external syncing mechanism has to be provided.
 
 Each table entry can hold information about packets consisting of up to RTE_LIBRTE_IP_FRAG_MAX (by default: 8) fragments.
 
@@ -62,15 +62,15 @@ instead of reinserting existing keys into alternative locations, ip_frag_tbl_add
 Also, entries that resides in the table longer then <max_cycles> are considered as invalid,
 and could be removed/replaced by the new ones.
 
-Note that reassembly demands a lot of mbuf's to be allocated.
+Note that reassembly demands a lot of mbufs to be allocated.
 At any given time up to (2 \* bucket_entries \* RTE_LIBRTE_IP_FRAG_MAX \* <maximum number of mbufs per packet>)
 can be stored inside Fragment Table waiting for remaining fragments.
 
 Packet Reassembly
 ~~~~~~~~~~~~~~~~~
 
-Fragmented packets processing and reassembly is done by the rte_ipv4_frag_reassemble_packet()/rte_ipv6_frag_reassemble_packet.
-Functions. They either return a pointer to valid mbuf that contains reassembled packet,
+Fragmented packets processing and reassembly is done by the rte_ipv4_frag_reassemble_packet()/rte_ipv6_frag_reassemble_packet()
+functions. They either return a pointer to valid mbuf that contains reassembled packet,
 or NULL (if the packet can't be reassembled for some reason).
 
 These functions are responsible for:
-- 
2.51.0

