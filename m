Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D6CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 02:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54A20402A7;
	Mon, 18 May 2026 04:45:46 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 8962040264
 for <dev@dpdk.org>; Mon, 18 May 2026 04:45:45 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2ee990e8597so5305347eec.1
 for <dev@dpdk.org>; Sun, 17 May 2026 19:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779072344;
 x=1779677144; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGRwGnhCXnPUx2UpH1GwGIHgxGPN3w5hanDOJ9Kp5Gk=;
 b=j0e/7gtqUs6/tx3J/LfJgftdpiFpxETtVqUPhaHxTbkXgduw+YdriNg7Bh2KftiQ2F
 ld01WS7ogxudQX6k58eVogPH5xMYkXweZstpc906UQdzTt12ZDhqeLUQDx9BXnxV3N/w
 B6K144Ffp3K5C0tio782FEDhzesqnCzVdn5OTHcJo9n1JkZXOhGZnF8QEYdVUhysHpHZ
 8T0/3ZHMQX1I+IDaNuWDsdz1V0G2a/Qc6HDrZim3DKJVAf81+2DSnEEP3KeJJX7daZ2b
 eWbAqj6dt/tTd4hVCyr5SN/ZT1dZsJCx6N25kjf7y3an78xcDESGPxEY0nR208cCEMt+
 TOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779072344; x=1779677144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGRwGnhCXnPUx2UpH1GwGIHgxGPN3w5hanDOJ9Kp5Gk=;
 b=cz1YrABCy3qqLkBj0/jPT4FdjqJvktRplAuQ00vE63yVTcE6NwJimxZC6pKspmYGb+
 f3pbyideiZEcUezNlrBHe7r3hFvjCdNzhfFWj1Zi358QtjsOtruVBz5RUU/HTiTP6IR3
 xYTxt5ZPHnLieINj9UAat/oDUSZ2r9RCTV9P95nRuR7bN4oWnthGvkMq6I0VaoRXXy+3
 grTn9tdM5uCg5TFFu+DAQcTcWZEmHxn1XL0TKRQXkPhPVQYT2cOvD8RDUtuqmop42AgD
 83WUgf5CpZDIiEJo6Irj8IloQCjtZfUZJTTdEIuZFV/Rb5sktNJXVJLZ0BkaFr2ntq6R
 yAFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HQPnD49TsXvYnWuc2B05Ey9d865Y2lFQRDT7FG98WbdoVx0poGSmlpipMI5lVkk8rlnQ=@dpdk.org
X-Gm-Message-State: AOJu0Ywb59+YRsIhyt6XwzNiIHeMZ3k/Ic0BZH2m9zTBL8Z0yBQjIVo2
 9FTBvLfNgyetNaHF3y4sHDRIdrVz8NsDDn9sq50iybehoWxgMyWX4Jv53bbRouAa9bM=
X-Gm-Gg: Acq92OEoKbXUzJ8rhsNSZK6xbPnc8iejvFAl9de7RgHKdaWnpMwdXzbfDDJbz/q57sf
 P1JS2I1wmNRK0BHsO8GmgRUN8szKL9BQu/VksrrIOb2MeMpM0FOH2Ot+EiPWPQvewHbbmODCHTz
 El8AeMZOQewYgWHC6EeRXC2Ex4HYE1XbUDZhfHhKVjROoBXza53bKV8eayWCOZn+ny/ZVXSR/e9
 i19WzFyJnkb+rffBadzrKlzuWArorzoLFZLudiCytWic0Wj4BojgxUHtG8yDD71PxCbB+NN7Has
 phX3ER9ysdJJezyI6co1y3ShxuscVPQalM2lFSlbItfnJNB0SOGlBCLYqc1hRVx37kdp057XDbb
 S3f8nJkhsd2/KlRi7tpL9pCjXVQd4fZ/JIxZ/cafS3KZTz7EDxGGnshIFO4JI5K7Jb3Y0jkpfXQ
 Mzq8D6bcbTyEcg4LbHda4DsBhCU3QtNv8KKShpgxi8RDfrZQ==
X-Received: by 2002:a05:7300:a907:b0:2f0:c8b5:3dc7 with SMTP id
 5a478bee46e88-30398680c36mr5975544eec.22.1779072344398; 
 Sun, 17 May 2026 19:45:44 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm16006844eec.3.2026.05.17.19.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 19:45:44 -0700 (PDT)
Date: Sun, 17 May 2026 19:45:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Denis Lyulin <lyulin.2003@mail.ru>
Cc: Ori Kam <orika@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Michael Baum <michaelba@nvidia.com>, dev@dpdk.org,
 stable@dpdk.org, adrien.mazarguil@6wind.com
Subject: Re: [PATCH] ethdev: fix pointer check in GENEVE and RAW flow copy
Message-ID: <20260517194541.577dbba0@phoenix.local>
In-Reply-To: <20260507112012.119140-1-lyulin.2003@mail.ru>
References: <20260507112012.119140-1-lyulin.2003@mail.ru>
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

On Thu,  7 May 2026 14:20:11 +0300
Denis Lyulin <lyulin.2003@mail.ru> wrote:

> When rte_flow_conv_item_spec() is called from rte_flow_conv_pattern(),
> the spec, last and mask pointers are checked separately. If the API
> is used incorrectly, the spec pointer may be NULL while last and mask
> may be valid pointers.
> 
> In rte_flow_conv_item_spec() for GENVE_OPT and RAW item types the spec
> pointer is used even if the function is called to copy last or mask.
> It may cause a NULL pointer (spec) dereference.
> 
> This commit adds extra check of item->spec and if it is NULL, does not
> copy further data relying on it
> 
> Fixes: 841a0445442d ("ethdev: fix GENEVE option item conversion")
> Cc: michaelba@nvidia.com
> Cc: adrien.mazarguil@6wind.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
> ---

AI spotted a couple issues here, please address.

Warnings
========

* lib/ethdev/rte_flow.c: RAW case guard is overly broad and regresses
  the LAST-without-spec path.

  The new wrapper `if (spec.raw && last.raw) { ... } else { tmp = 0; }`
  is too coarse. The original code only dereferences spec.raw on the
  SPEC and MASK paths:

    if (type == RTE_FLOW_CONV_ITEM_SPEC ||                  // uses spec, mask
        (type == RTE_FLOW_CONV_ITEM_MASK &&                 // uses spec, last, mask
         ((spec.raw->length & mask.raw->length) >=
          (last.raw->length & mask.raw->length))))
            tmp = spec.raw->length & mask.raw->length;
    else
            tmp = last.raw->length & mask.raw->length;      // uses last, mask only

  For type == RTE_FLOW_CONV_ITEM_LAST the else branch is taken and
  spec.raw is never touched. With the patch, when an item has
  item->last set but item->spec == NULL, the wrapper short-circuits
  to tmp = 0 and the `last` pattern is silently dropped (dst.raw->
  pattern stays NULL after the struct-initializer memcpy). The
  original code copied it correctly.

  rte_flow_conv_pattern() calls this function with type=LAST whenever
  src->last is non-NULL, regardless of src->spec, so this path is
  reachable through the public conv API.

  Note also that mask.raw is guaranteed non-NULL by the
  `item->mask ? item->mask : &rte_flow_item_raw_mask` fallback two
  lines above, so it does not need to participate in the guard.

  A more surgical guard preserves the LAST behaviour, e.g.:

    if (type == RTE_FLOW_CONV_ITEM_SPEC && spec.raw)
            tmp = spec.raw->length & mask.raw->length;
    else if (type == RTE_FLOW_CONV_ITEM_MASK && spec.raw && last.raw &&
             ((spec.raw->length & mask.raw->length) >=
              (last.raw->length & mask.raw->length)))
            tmp = spec.raw->length & mask.raw->length;
    else if (last.raw)
            tmp = last.raw->length & mask.raw->length;
    else
            tmp = 0;

Info
====

* The commit message attributes the bug only to calls from
  rte_flow_conv_pattern(), but the more directly reachable path is
  rte_flow_conv() with RTE_FLOW_CONV_OP_ITEM_MASK (rte_flow.c around
  line 1144), which validates only item->mask and leaves item->spec
  potentially NULL before invoking rte_flow_conv_item_spec() with
  type=MASK. Worth mentioning so reviewers can locate the trigger.

* The GENEVE_OPT hunk uses spec.geneve_opt->option_len to size the
  copy of src.geneve_opt->data, even when src is the mask (type=MASK)
  or the last (type=LAST). This pre-existing assumption (that
  spec.option_len describes the layout for all three) is preserved by
  the patch and is out of scope here, but worth a sanity check that
  the spec.option_len fallback to 0 (no copy) is the desired
  behaviour when only a mask is supplied via OP_ITEM_MASK.
