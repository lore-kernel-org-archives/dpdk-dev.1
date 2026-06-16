Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC8DCD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 21:07:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6B7940289;
	Tue, 16 Jun 2026 23:07:02 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 5D6DF40268
 for <dev@dpdk.org>; Tue, 16 Jun 2026 23:07:01 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-13721dfd471so5592663c88.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781644020;
 x=1782248820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d9fydfeQmB+MubHqtoya78UuQH7mW4hCKDs70cF0O3g=;
 b=Ll3KXBLHB/sSMAy6uYsqtyP12RR39BOMHsCVR/KGg9nNW+aW2exkjSovARep4O19Aa
 RcgTVQgGL55aCNe9ZMwK1lRtNz72qmYVK459DzOVym+J+nkDVjk4QFBTAE8YC2Oe4pQR
 8fzmhliLDHHgHvEtcg7llN4vNHe5U3APo8wotEa0PRoVdLQ63MzXa2HiHsFPn91A1TJG
 wfg/8K7Kv3Wi1xSFGp3vgZByz8dKuNIQu4tEpcSLKmMPeWX67i7BOfEj96WUwZjpAS60
 jdoP0LGwkwYQj5ezQLIjoYo3PcVEGpveAFvNS552UEa7zbVpMcbJkDimZuDsamy5fjuz
 3jFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644020; x=1782248820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9fydfeQmB+MubHqtoya78UuQH7mW4hCKDs70cF0O3g=;
 b=Rnm9cAbg3uQS0CwyqD1TzL7aRC6lpMLXeE7NHM2RjgSFp1YVqcvrAiilNHQXT29XNT
 g9QSWRaVMyGN0c0sXSUgaU2N1C0ptqs+AIuvTCHTUcrDXySP2A9mO5uMvrIixQkVSB9R
 MXIbToGPja8uZ7ZFLM8TAVOXvZ9tywIxaGbmFcyf1w0ZkJyI7jlq0RTu+wsVczZgBdgE
 jJzzSHk6vF1JhGNhJO2yObS4khphd9xhJvn8vNd34m88wE8eqkGSu5LUMlpm6QatTff3
 aHH+4GAiTlt/NJDlwuG0h3EirYqcTLKL7lHx72Rfu8LWLo6JAk91kI/J6o5gPHKt72Rn
 Ih2w==
X-Gm-Message-State: AOJu0YzmXhfg4c9v1AOBViPHy72FQ4HRDQvvsNVE3mYcbEq7pCVUlEYt
 eV4kR05H1AP11VoFJFQPMK/uTn1P26x7uE7BOV/N/D56A2+qtXdB1Qfpcgld2YHNywz3yMTMfU3
 TuzC2
X-Gm-Gg: Acq92OFfrYQ/s0eqRB7di7TbYPp3uV7SvCmpeP6qBGMUh2naQAMyd8b5iTFZtB0BwEf
 DW2jZwepmBzkrVhe/gqZf62hEHtXeNfCmWHKezJoUg3q7Go2aYQyZclxRdNSFIuaoobMo+r03P2
 2YhXbRvMBco4hW0Mix02bmhyDeprZ51vf03iBZ7oViSesnIMLciJOwR41zWpXTHfpSzWaNxTXN0
 MxdDH8tuf9LUn8I2LWyqRdrkaUm6zD5NfuK/s2cDRuSdyIeZ+6EEbBO4W8u/AzwJwDUIZexnOvM
 dvUV7iQKrUYp9UslHCeY1P0X9CnMK50zPudN9Y7spnzYF9ocdcNofr+H5htYJQBcx8LWYHOeeGv
 YXW+V2r90DSWMHS92jcxiagckL0Nxf84GIOCrIIH33Yl2qtcEnJHrgcf60YpJL6lzZNOJ8ynnYX
 ac7MbqyH88dkILwyDvDLzFvPtKbyeYbzYeFEkQmp8PNMURUzAklI+Ttqx045zmlA==
X-Received: by 2002:a05:7022:910:b0:138:243e:ceb1 with SMTP id
 a92af1059eb24-1398f669484mr335230c88.6.1781644020161; 
 Tue, 16 Jun 2026 14:07:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b96d6c4sm15118446c88.9.2026.06.16.14.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:06:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/6] ip_frag: fix reassembly defects and add test
Date: Tue, 16 Jun 2026 14:05:32 -0700
Message-ID: <20260616210656.464062-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Stephen Hemminger (6):
  ip_frag: tolerate duplicate fragments
  ip_frag: discard datagrams with overlapping fragments
  ip_frag: include protocol in IPv4 reassembly key
  ip_frag: drop IPv6 fragments with unexpected headers
  ip_frag: reject oversized reassembled datagrams
  app/test: add test for IP reassembly

 app/test/meson.build              |   1 +
 app/test/test_reassembly.c        | 644 ++++++++++++++++++++++++++++++
 lib/ip_frag/ip_frag_internal.c    |  36 +-
 lib/ip_frag/rte_ipv4_reassembly.c |  17 +-
 lib/ip_frag/rte_ipv6_reassembly.c |  22 +-
 5 files changed, 714 insertions(+), 6 deletions(-)
 create mode 100644 app/test/test_reassembly.c

-- 
2.53.0

