Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FE6C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:37:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBF0E4067B;
	Tue, 30 Jun 2026 17:37:28 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 6F36A40611
 for <dev@dpdk.org>; Tue, 30 Jun 2026 17:37:27 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30ec3dfbcd1so3880401eec.0
 for <dev@dpdk.org>; Tue, 30 Jun 2026 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782833846;
 x=1783438646; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BGCZD27RugnamVaMYOsVw4I9wUc55jlUERXfNItBWQ=;
 b=UXyhYVTNH5uTI0FGFkZIGxPgl73hbjM3/0EtVXL6zVi04L0C/JO/djvPjpfsFUuLVf
 EPK/PS55QF9KjdjB+naE4iYKoY6DsJYolnOmRFNpRcRicg7vJ/kaue9G000S5exIybPk
 m59nQKEoRxSs28c3PW1EAVZGCZ6p+X5a6cT8o5wD/fiQqS7pheueulh3PoH3aczRGywe
 AgUIFqvkW27dmaZpwaYzJXp7UKmingAE3ZRFg4dn/ppBPzyMnCie9yDf6XZajj11QAK8
 MC6Me/g5hpw34S6vz3cNRnF/wrj6F04wJybERgBRcwy1yOv8rKdGvDZ3ec83rDn386Ws
 RJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782833846; x=1783438646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5BGCZD27RugnamVaMYOsVw4I9wUc55jlUERXfNItBWQ=;
 b=gg1I3snYv2V39Z7kzGNEU8cXeIziXk/p/6JVd4P55UrvigGH6GbXD+YBR0Tgo93HeW
 nbLuLz8st8wqee4x9kGQoxfz7ZFhPX0H8aDIg9/p37/HTYDOFtWikGkgkbH491Hhvpyl
 m02IoSyn74cz3qQlLKYvpZOX/hwBNEwbsNqbWx3iMWQnGAtqBbWzvlltJrAbMKfiXzcA
 zf6kFPld4iXa+be1/31wDJKbDNx9S0E+0RRFnCF/VQxytWnk1sVBRMvllrbmjaboivTv
 q4/gwvqOF4FXLryDn+l+lvpGPX8AGKkPw97V3zMGBLkCM0OYEZx7PNpV1S8Vdq2yYo3F
 Qniw==
X-Gm-Message-State: AOJu0YzpHV9+HqdQiYr6wgZFnGPJt7tyIyQy92J41jselyIHCuTXLsWK
 I7eSJAX4X2FO2qKSSVzW54kuABFDqkDLInO3R8q8KHZm0316jZquC2Dk4I+/jip8vcCXOm7+R1x
 fXYFg
X-Gm-Gg: AfdE7ck9BTOoCizxT9l4giXNTbiBRYngbK07GwynMSWA8d3RiOKKHzVw4a1MDX/aPlN
 BC6jz8Bv/I0G+i6HB6U3scAaLfITiWtbH8q7YkHFRDMfZ9pi86ILzc+PTpwtJ4IB6oVfRhvXGpk
 MoEu67td7znVah71HF/BzmyDh8/mJjdFjieuHo9nl+JuX/PsG9J9lepFv3drbH6l7UH0c2/Txza
 5slNzpKun+Xzblaw9ReZq/UkB1iQaEovkVdYhpnkL6scBDs2t+Od7PptCuH7tGPCIG0Lm0IRJJe
 NT53JqGzlySOMp6g7x5SoWtnjj1k6p5HsWzZ3ej3B7j+edXv2Tfgcc2/ir6Ft1v12PTukhX7z6w
 ALu3vM7bpkJfs0xrAfMBpmuUp8YKP5gdAiKCuEXUpoMZY1wZyVxG9FSXfZgljzRdySrrmI75LTH
 RnVOE9OJPM12N4N4RQ3MTcekSPWLqkEoUPCS9SsidctVFqRJD2xBE3I7vJkYAAxQ==
X-Received: by 2002:a05:7300:2201:b0:30c:9f31:b611 with SMTP id
 5a478bee46e88-30ee12ee752mr3348789eec.3.1782833846011; 
 Tue, 30 Jun 2026 08:37:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2fc21casm9072139eec.10.2026.06.30.08.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 08:37:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/8] ip_frag: fix reassembly defects and add test
Date: Tue, 30 Jun 2026 08:36:12 -0700
Message-ID: <20260630153723.525167-1-stephen@networkplumber.org>
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

The IP reassembly library tracks only a running byte total and reserved
slots for the first and last fragments, with no coverage map. As a result
it mishandles duplicate, overlapping, oversized, and misheadered
fragments, and the IPv4 key is missing a field RFC 791 requires. There
was also no functional test to catch any of it.

These came out of reviewing a duplicate-fragment report on the list.

Patches 1 and 2 are interdependent: the overlap discard relies on the
duplicate handling so an exact duplicate is dropped on its own rather
than discarding the whole datagram. The rest are independent.

Patch 6 adds a functional test modeled on the Linux selftest ip_defrag.c.
It passes on this series; with any single fix reverted the matching case
fails.

Stephen Hemminger (8):
  ip_frag: tolerate duplicate fragments
  ip_frag: discard datagrams with overlapping fragments
  ip_frag: include protocol in IPv4 reassembly key
  ip_frag: drop IPv6 fragments with per-fragment headers
  ip_frag: reject oversized reassembled datagrams
  app/test: add test for IP reassembly
  ip_frag: remove use of rte_memcpy
  doc: add release note about ip_frag changes

 app/test/meson.build                   |   1 +
 app/test/test_reassembly.c             | 675 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_07.rst |   6 +
 lib/ip_frag/ip_frag_internal.c         |  40 +-
 lib/ip_frag/rte_ipv4_reassembly.c      |  17 +-
 lib/ip_frag/rte_ipv6_fragmentation.c   |   3 +-
 lib/ip_frag/rte_ipv6_reassembly.c      |  36 +-
 7 files changed, 767 insertions(+), 11 deletions(-)
 create mode 100644 app/test/test_reassembly.c

-- 
2.53.0

