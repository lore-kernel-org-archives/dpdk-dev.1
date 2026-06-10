Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73703CD98CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 18:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 344B142708;
	Wed, 10 Jun 2026 20:32:34 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id E03BB402A7
 for <dev@dpdk.org>; Wed, 10 Jun 2026 20:32:32 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 52BF5EC0047;
 Wed, 10 Jun 2026 14:32:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 14:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1781116352; x=1781202752; bh=AjCsPgDzhEJIng3dl/yMC
 IpotHE0NlcD3DLSDNyAioE=; b=rUdZwOBZvMRZEqWWv6NuTYmJyz4/HQ7IzH3l+
 nc/jw7OhcZmhqlocbyXWNDteGYdthP7J+EmnrFm9GRcohajz5ugTgEvqhW6c/mNL
 Ckzzu4EyJNM7RmSJJ50U6KOEA4jiNaN9Ar+YBltLq3kcN5KE0QWqc1tesaNXaNVf
 fhsOYlrP7Qd/0/WXSzeEeOtDSePZmtdBzaryp5B/pzwhjHzWvAEzfyyX5xueM96u
 czhV9eO+uE5CZO6JT3Bl/u/GY5lptQY9G+6GAP7rPZRZ53ElLJ+FW9UpHcBkEnYE
 QR2U/486gbQVcbpGCF+qV0TkKSuVsUdB6C6Oh4HOh61TSOjtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1781116352; x=1781202752; bh=AjCsPgDzhEJIng3dl/yMCIpotHE0NlcD3DL
 SDNyAioE=; b=JZRrYG8EkCgqEk7sWOeyJqQoUZ89ZFC+FP69kxpATOCJ16Jlnv/
 sFq5rNPs+wvM+8unW9EFwRED6ecumRDrpbFqzT59G6E3bSjZyW/4n/aE2ryD4BOP
 h/Q5D9bjFYwoMzbc7/UGFqIu70Q8R1l6L+KyEmAk0zvfOSxcPapnU07oXQsbaAcS
 DCtXrZfDxjB7mt3/CFahwwDEAM42YdSCxqrj3sftX98KoSkcUG4eJZpmd8TQ/L2H
 wEQm9U0r1jqac2e7GmlBO+ksBJ83RlIb4WQUa8AeuYL/DSW3KxRV0pynGrDBQ9Hj
 Ap8313NdaYQUYDpqzbd1/BsKv95u9vhENVA==
X-ME-Sender: <xms:wK0patfNJaflUek1bVh448B5XJXXmmWOgFHelqChK4GzdBS4ffIwpQ>
 <xme:wK0pak2B0DFdTlOvoVYl3pC2Q3twlKjX3XmJxdwlHkzPyz-l1-tmku4wAi57Y-Hyt
 D-IYYgCkeRN1lusVPyGHJoRY-DaQRB1torjBTZ0K3BbSlSi4exTLQ>
X-ME-Received: <xmr:wK0pamgzwDQFEND7Tvq2DhpvQJEgnZTvKsryWH44SqxTtqSuenFcYWoxpEVzhydr0Qtcsvrh1hnuZQACEQn2frP2pASFpwg>
X-ME-Proxy-Cause: dmFkZTGkx1hVSFHCG47hofgHmA1oAAN51GwV+HpdlQ7sbrTlpit+DLmrbWx4FToB+oRFmu
 1wIfFWCUMqaG7Zq2E2TmK/cChottCC8lkhwnj++NGRGIPYxOw6daQPS9MKkDzJoAH9MF2M
 LOSAaHHyBYMXIM18IdRKc0Xw/eUBNVUPjXgheukdQMnos0k91OPHQPksTJSZkJ0TWyC9sa
 LfIGjjKlM8xJ0IkhRf5Uxi5D+grRJ4Txmaq9BPyjsPWQYRJNnXYA8Swh2nEwXOgwvAnyMC
 /S0vqvpkzpIkpi8rGo/qpxickG1yGo8UC6VhDWPKy+fhRMpMPv4cz2hqAkWAR+y7kBsJHE
 UnmQvVXW/a6bPw+9JVneHWlqItWDQLdxsu94muSs2s5negFJThWP5pKFHz17QzUtDVcoIw
 JB9JL1l418ADfSf6LHozWvQI8WWZ0kgIhSN1HqUzIpnbMACY5HN0joACi1muOZJqfFUbnl
 HTt6fn0lSa7qU6+X3kwM0A2BCNnNFrNiXY3Vsm02oN3BH3hanHvpFImtZZasjhakGgcBvE
 AkN6DFY0vVaKgVt99NQCWycO1x5QhsqSautpt2a83xK4SFCWfpY8yICJMnPO1GEh+7Ph09
 +nH9EbwaWJXVmX7trwPxvLNlfR/jqxpbMaqiWczIRuLuX9UdE//XyETB5vQQ
X-ME-Proxy: <xmx:wK0paqRbY-zebYDTB26Ll4uJPi-VutfU0KZU4dqI4NAJHT3wp5IxZw>
 <xmx:wK0panjgnYZfvsjyCDR36OJ1AVZfsN_ngUjfdcqkWDbA_wE4WwZiFw>
 <xmx:wK0paq7e5ZHBESKL8vGvABhyHhRi-ww1ambmA79TIeKjK9oHGGHM4g>
 <xmx:wK0pakCl6dtZDXbwQ257a34ygZFN5klRxn1STsh6brEv2WvyB6acog>
 <xmx:wK0pavSUBY0jqCjLvQyFAH7eiVCE4qYka1aESCj0bGrL59iWsDxKsKJu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 14:32:31 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH] dts: avoid Scapy MAC resolution in Rx split test
Date: Wed, 10 Jun 2026 20:32:18 +0200
Message-ID: <20260610183218.751941-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
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

The test gets the Ethernet header length from Scapy with len(Ether()).

When building DTS API documentation, Sphinx imports the test module
and shows this warning:
WARNING: MAC address to reach destination not found. Using broadcast.

Use a dummy MAC address so Scapy no longer performs
destination resolution during import.

Fixes: 01c70544cffd ("dts: add selective Rx tests")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 dts/tests/TestSuite_rx_split.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split.py
index 0c7913bbd8..5f5a2e6187 100644
--- a/dts/tests/TestSuite_rx_split.py
+++ b/dts/tests/TestSuite_rx_split.py
@@ -27,7 +27,7 @@
 from framework.test_suite import TestSuite, func_test
 
 PAYLOAD = bytes(range(256))
-ETHER_HDR_LEN = len(Ether())
+ETHER_HDR_LEN = len(Ether(dst="00:00:00:00:00:00"))
 IP_HDR_LEN = len(IP())
 ETHER_IP_HDR_LEN = ETHER_HDR_LEN + IP_HDR_LEN
 ETHER_MIN_FRAME_LEN = 60
-- 
2.54.0

