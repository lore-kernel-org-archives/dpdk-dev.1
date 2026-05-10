Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C06CD3427
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 16:20:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F151540270;
	Sun, 10 May 2026 18:20:05 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 25DCE4026C
 for <dev@dpdk.org>; Sun, 10 May 2026 18:20:04 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f7020a928eso4703908eec.1
 for <dev@dpdk.org>; Sun, 10 May 2026 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778430003;
 x=1779034803; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Cti8Vl1ZPm0+m5Nbu+i9KSwUskMQZ1KumsTsc4KO8U=;
 b=I85dBDqFeLXuODubP6LclKbuZsvpUJWoVf0LHHiKHWtW4DepmaQPjUjJ6C3o6ttmTc
 x3U3fdPL7LG7wOFt2Wwp9xYBlW9AVAuCU5MMUQwXUIZP8Tj8VwlCCdeTYBlUmwDNQ1Pe
 Hi60JBsG4pxrr7L2RxRjqw3WmO0I+05iva8W6ZQzPcfdjcD6FTUfPuHmQMN+BlDNpG/T
 bq50HsfhOIRyB1KN+zN4XJ/FkIJ2fET9JYGQf4BAHlbYT0zUYzsuqNKOl8/LxVVFBWKt
 7NsxcfhlS1NSdys0nKAcCxAyU59onb38O6GBX8ivFXBGb+qvfzXUmdLWYwr7R0eLkP00
 ss4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778430003; x=1779034803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Cti8Vl1ZPm0+m5Nbu+i9KSwUskMQZ1KumsTsc4KO8U=;
 b=MZOF7jFyF8mY25xe4zMwyZXLxYzSVOUL8/7AQxnnG78eGvVyFOz5sPYE1C/g6Wc59o
 HP6AykdD+caXU6BraND+syPYkBB9DWGo1Q++ObmNhsHa8gb2VVohbPKEWgH1nCFNe7Gb
 wryxFaWA8xYv2/08jvZEKqaDzmFwVPsyfFkqwNcKnESuGe94Gl9cP15yOvzB1dL5AGmW
 ZuWQdEOpRAne+VImdEv+cugE6650hKlYU0eJVQ/J9j7XCd+7ZP4I7kxfRn/BsKgsT0Fq
 6OyWn0Gas3npTOtl3CGUSo9u9p8hAfbNGjwmj0J3wDRcPsnmCMAgrRr5sqChCNTLiSv3
 nLfA==
X-Gm-Message-State: AOJu0YxZ30LmkyGYXBUOUOHUUf72FVux9mJvbvrjYfWu7WnyY5xjHRDy
 6wGvSQ8MUA6SgQ4joBJ1wSIUG9G5+FJbKQsQQhyqwkavDvPV/n7SGELek/wHblnSfVZUAgUInu2
 fWm7Qb1Y=
X-Gm-Gg: Acq92OHLxC/q0wm7MWMgkaABmKB72BlP0pH0lfKb3P+hqJKR2JVXTZy2EM5tg/X/auE
 2sXff40XWwonrSsgWdE+EJqpaQ9H2hVPlPnyhiqE9N5jba6csZJf7egQQRsSStGKxQwoa51cSxq
 6CW49fcjUPDLhkV2O8sGy7lM4Yua1C2zrz/SJCZaI8+KuI0GidB12Mc0Xf8hD5eQklEpxf8qykt
 9r67Ioi+yWcbfMKOmVzHhiCwoe6zV1o/9DhOIzM94OaWuU80TAu/u04efYp7Si5ef1fwMx0Czvb
 f5w5+XEOACtA3t9Tb6LipFVZ3U9ia96r0RRvNl/GJPwADb69tbJQNwNkmisRWp1wKVqMMTOR5TN
 4StEV5n4v++QYAaLTD1P/f/qGaqPCoeJmiZc+bOwFloKWkfZYIUt85dngXGYfDLi9FC4rUeN/Ce
 fub6/j+eJqzwwZSFBK+HdRwp4YEVMB4oVqLCBgGU0p6Sa50A==
X-Received: by 2002:a05:7300:f690:b0:2ea:7901:8d72 with SMTP id
 5a478bee46e88-2f54a87e863mr10330695eec.17.1778430002720; 
 Sun, 10 May 2026 09:20:02 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e3e285sm11986229eec.27.2026.05.10.09.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 09:20:02 -0700 (PDT)
Date: Sun, 10 May 2026 09:19:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/10] selective Rx
Message-ID: <20260510091959.77a3262e@phoenix.local>
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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

On Sat,  9 May 2026 23:56:51 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> This is a new feature in ethdev with tests and mlx5 implementation.
> Selective Rx allows to receive partial data,
> saving some hardware bandwidth.
> 
> Note 1: mlx5 support patch is not correctly indented
> to make review easier. An indent patch follows to be squashed.
> 
> Note 2: DTS patch is an attempt to test the feature on day 1,
> it is not mandatory if it is blocking the merge.

Larger patch needed bigger AI model than default CI.

On v2 of the selective Rx series:

[PATCH v2 03/10] app/testpmd: support selective Rx

  Warning: regression for the existing "--rxpkts only" case.

  The new condition

    if (rx_pkt_nb_segs > 1 || rx_pkt_nb_offs > 0)

  enters the new path even when rx_pkt_nb_offs == 0, which used to
  go through "rx_seg->offset = i < rx_pkt_nb_offs ? ... : 0;".
  In the new code, seg_offset falls back to next_offset:

    seg_offset = i < rx_pkt_nb_offs ?
                 rx_pkt_seg_offsets[i] : next_offset;
    ...
    rx_seg->offset = seg_offset;
    next_offset = seg_offset + rx_seg->length;

  With "--rxpkts=14,64" (nb_offs=0), iteration 0 gives offset=0
  length=14 next_offset=14; iteration 1 gives seg_offset=14,
  so rx_seg[1].offset = 14. Old code set offset=0 for both.

  Per the commit message, the new path is intended only when
  rxoffs and rxpkts are both specified. Either restrict the
  condition to rx_pkt_nb_offs > 0, or keep the old offset
  assignment for the no-offsets case, e.g.:

    seg_offset = i < rx_pkt_nb_offs ? rx_pkt_seg_offsets[i] :
                 (rx_pkt_nb_offs > 0 ? next_offset : 0);

  Info: the trailing discard length

    rx_seg->length = dev_info.max_rx_pktlen - next_offset;

  is uint32_t-uint16_t assigned to a uint16_t length field.
  Truncates if max_rx_pktlen exceeds 65535. Edge case but
  worth a clamp.

[PATCH v2 06/10] net/mlx5: support selective Rx

  Error: NULL pointer dereference in mlx5_rx_burst() when the
  first Rx segment has a NULL mempool.

  The CQE polling and pkt assignment are now nested inside
  "if (seg->pool) { ... }":

      if (seg->pool) {
          rep = rte_mbuf_raw_alloc(seg->pool);
          ...
          if (!pkt) {
              cqe = ...
              len = mlx5_rx_poll_len(...);
              ...
              pkt = seg;
              ...
              PKT_LEN(pkt) = len;
              ...
          }
          ...
      }
      if (len > DATA_LEN(seg)) {
          ...
      }
      if (seg->pool) {
          DATA_LEN(seg) = len;
          data_seg_len += len;
      }
      PKT_LEN(pkt) = RTE_MIN(PKT_LEN(pkt), data_seg_len);

  When rxq elt 0 is a null mbuf (seg->pool == NULL), the entire
  if (seg->pool) block is skipped: pkt stays NULL, len stays 0.
  len > DATA_LEN(seg) is false (DATA_LEN was set to seg->length
  in rxq_alloc_elts_sprq). Control falls through to
  "PKT_LEN(pkt) = RTE_MIN(...)" with pkt == NULL.

  This is reachable from testpmd "--rxoffs=N --rxpkts=M" with
  N > 0, which produces [discard, real, discard]. mlx5_rxq_new
  only rejects configurations where every segment has NULL mp;
  it does not reject first-null configurations. Patch 10's
  selective_rx_payload_only and selective_rx_two_segments tests
  both produce first-null layouts.

  Options: reject first-null configurations in mlx5_rxq_new(),
  or hoist the CQE-polling block out of "if (seg->pool)" so
  pkt and len are established regardless, and guard the trailing
  PKT_LEN/stats/data_seg_len reset with "if (pkt)".

  Info: the rx_seg->offset semantics for non-discard segments
  with selective Rx active are not documented anywhere added in
  patch 02. The struct comment still reads "Data offset from
  beginning of mbuf data buffer". With patch 03 emitting
  cumulative wire offsets into rx_seg->offset for real segments
  (e.g. rx_seg[2].offset = 128 for "--rxoffs=0,128 --rxpkts=14,64"),
  mbuf data is placed at +128 in the data buffer, wasting the
  first 128 bytes of headroom. If that placement is intentional,
  the struct doc should say so; if not, real segments need
  offset=0 and only discard segments carry wire-position info.

Note: patch 07 must be squashed into 06 before merging, as the
commit message states. The bug above persists through 07 (same
code, just reindented).

