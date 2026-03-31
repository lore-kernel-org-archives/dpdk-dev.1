Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8851061B21
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:04:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E25A840285;
	Tue, 31 Mar 2026 05:04:58 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id AFA7F4025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:04:56 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so6949957eec.1
 for <dev@dpdk.org>; Mon, 30 Mar 2026 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774926295;
 x=1775531095; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNU0OgVZHtZmY/nUH+pUH5l8Y/lQHuzaTJZMsyM1gjw=;
 b=rn0cXhdAoc3ky0dyGS5K7rcmHL0gCiJYimmnlcaUqLoXyyiZm8LcxCqbqRBEkw/l7e
 GRR4ksi2HFTaiOIkblceqSNnjmymHftSlGo4qFKi26f3qCddn0P9wdRZKEOa6pNS7ztR
 GWMFu8x1BBbAGAuosVh5tbnavDUzbT6muRzMk40E0Cliw0gWA62hfvPtEKIynbgUa5Bv
 uGeQlO4N2MAoJdJB1grvS1zm8A3X2hNNo1+E9EqBS7bLTT7yTR92g8U+ALTQj/ycnif/
 TLK28P8vs+dIYl5GFVQ5CtTF4xgiuScDqx0ylLjLvOSbLXujL1jBbG+1rNA/cRo2no+/
 HH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774926295; x=1775531095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XNU0OgVZHtZmY/nUH+pUH5l8Y/lQHuzaTJZMsyM1gjw=;
 b=R/aTBCu5M+YP217MNpyBvUUpVl73TJaycGTkUlkzSv4bAmQFD5HZQpTdmJiDMNgHzm
 vOpU6RSBPvMA5Z7tnTCv2iCQDeaxtdCy9jAUJqvDD0UIlT/1pYrjoHdDTRUPaCQetAFe
 Rxx2zrom8DxJojEp2QPhYtQc6Pkbvf66AYdCZdXW0n+AqXwm5qGZqps1dATz35hr6fo5
 +yamv0wdsXXq6svdtF03kus/1EbTjBSRCOrvo437lWpikIe5wX/Gae8A6/Yg/UUkoSds
 o86C6J0xPKmnbbyxSf1KFMgbYGxHllvOR8P386r7V7nh1WwXAf7+/zo30pyODg2Q/0IL
 FFQw==
X-Gm-Message-State: AOJu0Yx3vpbqCIard44+L3pSL5QFWprRvVRF6M+j6eL6e3pWHnENj3Yh
 ykD6UXQFVDeZC11lEg85eE3hbkbeA9U11WNo9LmKEmmVPbMiewQo2T7b/ZjxF5l02Z0=
X-Gm-Gg: ATEYQzwLg/tpZshoBgGB24pnGLATri3znquqy1ZCqH25JBMXt8qDDk6Vha7SyY6eb8e
 jgY12H1LpvA5mZoTddZwAmI6cKa/PiVv92a6ODlr51QaMBll60Mv0wGf2qBUJj8/uAViEUHCI90
 +eF7MhzubS+N2uzxsbGLj9P6YZKIbvYql5jn4qfj7DhtD+dvOUIGU+OfO5ygkZrj3O3Pnl26oiD
 dzmmKDmN586pOb3q3xDS7wPY42ISkEI8yKPBlEmVJBj2zNnSeRst932/FSWJQuDW0vJdGehxHgt
 pGGI58kn8rRmznJzqOJwSVFz/z2bmc3v6p8y/InnjrVbY6KXuezZ1WftUAdvMj9tTDB6RCPT5DT
 jyPKGyOnT7KJ/IG0yH5I3ABVqzdcC3p7PziApEaVO6ETQ2j6pVZadn+TCKT47CuXMh3jsfVJ1kW
 qWjJOySXRIF158gzQ9PsAxK7V7tV2r8cX/QZw=
X-Received: by 2002:a05:7022:4393:b0:128:d396:f2e2 with SMTP id
 a92af1059eb24-12ab2857b2emr7522854c88.8.1774926295384; 
 Mon, 30 Mar 2026 20:04:55 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12abbe21787sm8950865c88.11.2026.03.30.20.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 20:04:55 -0700 (PDT)
Date: Mon, 30 Mar 2026 20:04:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] gro : improve GRO performance based on hash table
Message-ID: <20260330200450.5870c49a@phoenix.local>
In-Reply-To: <20251227174221.277640-1-kumaraparamesh92@gmail.com>
References: <20251116060634.262352-1-kumaraparamesh92@gmail.com>
 <20251227174221.277640-1-kumaraparamesh92@gmail.com>
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

On Sat, 27 Dec 2025 23:12:21 +0530
Kumara Parameshwaran <kumaraparamesh92@gmail.com> wrote:

> Use cuckoo hash library in GRO for flow flookup
> 
> Signed-off-by: Kumara Parameshwaran <kumaraparamesh92@gmail.com>
> ---

Since this did not get a through review, used AI review to find:

Review: [PATCH v3] gro : improve GRO performance based on hash table
(test file portion only -- app/test/test_gro.c)

The test rewrite is a significant improvement over the old hardcoded
byte arrays. Constructing packets programmatically and validating
headers and payloads makes the tests more readable and maintainable.
Several issues below.

Error 1: SYN packet in test_tcp4_mixed_flags has wrong IP total_length

build_ipv4_hdr is called with payload_len=1400 for every segment
including the SYN packet (seg 0), but the SYN packet has no payload
appended (goto skip_payload). The IP total_length field will claim
sizeof(rte_ipv4_hdr) + sizeof(rte_tcp_hdr) + 1400 = 1454 bytes,
but the actual mbuf only contains the headers (54 bytes after
Ethernet). This creates a malformed packet whose IP total_length
disagrees with the mbuf data_len/pkt_len. Should pass 0 as
payload_len for the SYN segment:

  uint16_t plen = (flag_options[seg] & RTE_TCP_SYN_FLAG) ? 0 : 1400;
  build_ipv4_hdr(ip, flows[flow].src_ip, flows[flow].dst_ip,
      plen, pkt_idx);

Error 2: test_tcp4_max_flows validates gro_pkts[flow] assuming
same ordering as flows[] array

The validation loop at the end of test_tcp4_max_flows iterates
flow = 0..31 and validates gro_pkts[flow] against flows[flow].
Unlike test_tcp4_multiple_flows which correctly searches for the
matching flow by IP address, this test assumes timeout_flush returns
packets in the same order they were inserted. GRO uses a hash table
internally and does not guarantee output ordering. The test should
search for each flow's packet as the other tests do.

Error 3: test_tcp4_max_flows error message prints wrong expected count

The assertion message says "should return %d packets" and passes
NUM_FLOWS_MAX (33) as the format argument, but the actual expected
value is NUM_FLOWS_MAX-1 (32):

  TEST_ASSERT(nb_gro_pkts == NUM_FLOWS_MAX-1,
      "GRO timeout flush should return %d packets returned %d",
      NUM_FLOWS_MAX, nb_gro_pkts);

Should be NUM_FLOWS_MAX-1 in the format argument to match the
assertion condition.

Warning 1: #define NUM_FLOWS, SEGS_PER_FLOW, TOTAL_PKTS redefined

These macros are defined identically inside both
test_tcp4_multiple_flows and test_tcp4_mixed_flags. Preprocessor
macros defined inside function bodies have file scope and persist
beyond the function. The second set of #defines will produce
compiler warnings about macro redefinition. Either define them
once at file scope, or use enum constants or local variables.

Warning 2: use of bare "uint" type

validate_merged_payload declares num_segments as "uint" which is
not a C standard type (it is a POSIX typedef). Use "unsigned int"
or "uint32_t" for portability.

Warning 3: resource leaks on early return in test functions

Every test function allocates mbufs in a loop and returns
TEST_FAILED immediately if any allocation or append fails, without
freeing previously allocated mbufs. While the teardown function
destroys the mempool, the GRO context may still hold references
to mbufs submitted before the failure. Consider using a goto
cleanup pattern.

Warning 4: unnecessary void * casts

Throughout the test, return values from rte_pktmbuf_append are
cast to struct pointers:

  eth = (struct rte_ether_hdr *)rte_pktmbuf_append(...)

rte_pktmbuf_append returns char * which in C converts implicitly
to any pointer type. The casts are unnecessary.

Warning 5: implicit pointer comparisons

Multiple instances of:

  if (!pkts_mb[pkt_idx])
  if (!eth)

Should use explicit NULL comparison per DPDK coding style:

  if (pkts_mb[pkt_idx] == NULL)

Info 1: srand(time(NULL)) is called in each test function
separately. Since the tests run sequentially and quickly, the
seed may be identical across tests, producing the same "random"
payloads. Consider seeding once in setup, or using a fixed seed
for reproducibility in regression testing.

Info 2: The comment block for max_flow_num/max_item_per_flow has
a blank "*" line at the start that looks like a formatting artifact.

