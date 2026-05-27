Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5C7CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 15:38:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31C034027D;
	Wed, 27 May 2026 17:38:47 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 3C0C74026C
 for <dev@dpdk.org>; Wed, 27 May 2026 17:38:46 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso5370002eec.0
 for <dev@dpdk.org>; Wed, 27 May 2026 08:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779896325;
 x=1780501125; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBgLhc7ROWdsIZNUYbMOz113S9g64QhXq1qUTrd3vI4=;
 b=YDopdqLnmWCSXIVyB8KS/CcV1JhrcEq0Nr14uir0uL5q3t+4xrKdOj1AmBtRh94zbi
 PSj/oNgxLZs0TY22eLTIh9d7UF0CshekqowpwM/VVJGLbrXFnGzbgBL9towcTeJ4zzAX
 tpZE//MQlQYshjXjb/viUhYI6gbZ5wtJolEnYxcpZQiR0W9E3znOLUoQMAHXnpvWCsXC
 qs8vUb2/chxJA/oqo1o93g0mQF8iI1uK1JdZpbys0MxRC0GTw44kRFo3ynsqqmevNOyt
 gGwY4/nDbws2GN7GIhDf/RUaBWknj78KnYhlNThYZD1YKjlcj94R6/7uT7ghW6EHtJD6
 VC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896325; x=1780501125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JBgLhc7ROWdsIZNUYbMOz113S9g64QhXq1qUTrd3vI4=;
 b=BupJySzTfHXTnMHdJhwR/ttzY/rSV8ZW4wKwOqUaJwXr8S/fj67/uaj1mFXMXSSnjp
 +9USWJWppcISMmWnq6/DeMSIyCUL5ZPb85TVCtHL+lbp2Di/ABreQfZu5OKCMVOLHoVN
 eNh69l1USHbX+XTbeY+SYzuZ+J75Hu4SHOoSXOMhRF2AOt4D8SHHJFBDCKrZh47y47qs
 OTYbPmdoXFH0SJNUB9qRCF1CMgfc08XHsyTyuNLg3YDMwo6k+b/xOBjzK5V4QfpkZ9jo
 RleOJSsNCC9WBq/JdHSGqNFfGDvPgdHTBs+Hti0rt8tK5ohCJE6PI4fJxB0guOUC4nNY
 uGUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tnIQc8d/lPaG3Zx2lQjs4RFPLQdwDvncVgU+Wcy/A2P03bWFxscOJd9AzkqdYC96LbFA=@dpdk.org
X-Gm-Message-State: AOJu0YyQ/RVzIUfDYvZp/HayVxMkZ6wdu7gm8qNGwb8kGU/c0DEaKhhf
 gHe01L/8l3LZ9umJYogy2P+QPJVeggUu9S3hwmJYA0uEEM9R01k7kMvgscofy0h2vS8=
X-Gm-Gg: Acq92OEh0kihY79attnpBWvbBK6NGr60IVPaYErTF6Yb9pxvu7gFZUUZK3MJ94TRgGW
 DYXbPOsMvcCcNAY0jmeSfDM1+eezeg3kS72AFPVrYufz74EgIPjoFopk5oR7SAq7ZRLFKYSX4/E
 LG5g9I32s/kq44bLSdY2PQFGNOJglhwQzr5kmWVjVkooVh4Q0r3+WiGMjiIlSj4Sr3gnTDDUPSq
 AN2E9xzgH++g41QcbzBM10bqY6IchtZLHvmHt5Bd2Bx24mATksRcThqkRZ3YYJu2I4liKqXMibO
 +8hQ+J89UCaaywl+zTuVMxwk3k2fWWidxmhNC9Y0wWYQVWMioPCR3MRb8XMrzWwXFgiDwGnKWKM
 +3NAkC3Oc4bAJvb3bTdIwlai7MUhU03mKrvkNSNIYbZZ6rz4d0b3LEWnaEZqb4UtzslSlF2eHr6
 HmcxZpAcxEDMTf9ym+FwWUOpmNOVJNYMRwTtzb4fb0Gop8XnXbKGFs3PMZyVv3oPmtH9UyhR/gd
 8c=
X-Received: by 2002:a05:7300:cb86:b0:2ee:ade0:e0bf with SMTP id
 5a478bee46e88-304491fba87mr11143925eec.30.1779896325127; 
 Wed, 27 May 2026 08:38:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304522314a4sm12818112eec.18.2026.05.27.08.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:38:44 -0700 (PDT)
Date: Wed, 27 May 2026 08:38:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: James Raphael Tiovalen <jamestiotio@gmail.com>
Cc: orika@nvidia.com, thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH 1/2] ethdev: fix out-of-bounds write in GENEVE option
 conversion
Message-ID: <20260527083842.32de94f6@phoenix.local>
In-Reply-To: <20260526181159.287633-2-jamestiotio@gmail.com>
References: <20260526181159.287633-1-jamestiotio@gmail.com>
 <20260526181159.287633-2-jamestiotio@gmail.com>
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

On Wed, 27 May 2026 02:11:58 +0800
James Raphael Tiovalen <jamestiotio@gmail.com> wrote:

> rte_flow_conv_item_spec() is documented to truncate output to the
> caller-supplied buffer size. For RTE_FLOW_ITEM_TYPE_GENEVE_OPT, the
> deep-copy of the variable-length option data was gated on `size > 0`
> instead of `size >= off + tmp`, the form used by the sibling RAW
> branch. A caller passing a buffer just large enough for the header
> struct had adjacent memory clobbered by up to `option_len * 4` bytes of
> option payload.
> 
> Align the GENEVE_OPT guard with the RAW one.
> 
> Fixes: 841a0445442d ("ethdev: fix GENEVE option item conversion")
> Cc: stable@dpdk.org
> 
> Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
> ---

Does not apply to current main branch.
There were recent fixes in this area.
Rebase and resubmit please.
