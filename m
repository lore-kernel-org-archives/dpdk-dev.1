Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373F0EB362C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 20:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F5B440A87;
	Mon,  2 Mar 2026 21:00:49 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id AC28D4028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 21:00:47 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-506cb1b63d0so59778461cf.2
 for <dev@dpdk.org>; Mon, 02 Mar 2026 12:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772481647;
 x=1773086447; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xfJ+WZKrwvqhnZ/g2czvZcL9GqobH3fv/DEOGzQb+4=;
 b=xLo7J8w2cOf/NTrBpA1f68biogCm0xCV750d1eEz6d1ruQtnquuGSGeQBKJxCIX/+9
 aSBSILipe+Qy6atvII4kQUFu0/dJkE8GAMhaL5h7JvHNIdUNGRk7yTvpFnDbD8ES+Brg
 fG920IiYZPjFWdOr7IB10VCA7nAx5WOk4jW4EtpX3M8h8gT+lkJlrOpBiLNqefkpAZ0+
 zruBNX02VvQv8dCcgB4wKjiNdh61OO7Mx9OUqvJpl4gSau3IxOWnvvt2FYYXxNr5tOIL
 xwHqI0p+bE1LQ7OGLtnjfRvOb1Hd4XgjpsDjtfaB+MsAYpEr0LjVbS9vxob1aoD3PhMR
 oSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772481647; x=1773086447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/xfJ+WZKrwvqhnZ/g2czvZcL9GqobH3fv/DEOGzQb+4=;
 b=B5khn2c+90WnMPj399rhUTI7ybwt0+j4HPFurPiqQMWN3/bv0gHeR5D6iKfOi3nfHO
 4em0ZKEBLSzJgudYo7l3WRnr+M7qnK2VYsykV6uyWcmJo+vYc0JTegbiSB4mcUcrE43n
 Nz8a8RxTNwYdGWHOTtE/HCRvyXZD9UnbYUJ5RS94gcMsn9cWWTtmHYstTdbC3W90TuB9
 m4DP9Y2UI1VJiS8LBdfWmY3MasuNpWgOPvH6OpCefoNRUWu+otWEGH1VpHlHZ2pz0WTm
 2IXF1/E8HFfLYMLmmDP4bmBTMlC0iNcVfZLStkYmpiuCHIX+BobUjmFRjor/zya/tWYK
 qMAQ==
X-Gm-Message-State: AOJu0YyXcVXzEuDBG3EceDRP40Z1QU4YbuOSGxW9YafUa7J5G0h3yinI
 xXfvMfwmrAs/G/GIA5cB1bphjsqvkwYsA7z0O2fgrZBVLLEOjWM/YktwV3+WuNPn0qzJcrJ1p21
 f6xHKgSI=
X-Gm-Gg: ATEYQzwjMzwl6mzoP6VNz49LN5rBwgrtJqdI/sISdFRE/YkjHsAKgwHP0UwgEZfSodg
 1/eFh9pQNEOU9Q58ChYVpMuBQl0ZIFCk2r0U6UpMWOlI/wSC33x2uNnNHWz7Du/AmSBsqQ7FqxE
 Xl0FCzgy27uwQz3IiBOE4KsQu5zyKOzwbwbN2oFWUnD648uymqSv4NKc1OAEm7uBj7qnIv/r8nx
 40EGj2TrKFquiTeZJ2oKdk4AAHMlr55pOGdTIz6wfYlBqr1t82x9M4D+zaxioPDDtBYHSnn0zP+
 23zokdeJJo83cROmHBCv3vebpti446wWnAzUcWFwD3c/9hfUR9znJF9t6tkePdMPcZSezvEmddt
 2fFoyFNSEN4z5YnfM5QsltF2KByMpV8EClURc/JetK5s/gYVdS0xD+MHqOvxhtUHjXkMHefimPH
 nJ6LP+FYTkZI0OPVA0h8gDJDQesY2C808huQclU69yPchk98qRS/0WueO0jHsJ2f7X
X-Received: by 2002:ac8:7f83:0:b0:502:9a94:2f9c with SMTP id
 d75a77b69052e-5075284ae62mr149949551cf.44.1772481646716; 
 Mon, 02 Mar 2026 12:00:46 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a02f359f2sm14954806d6.24.2026.03.02.12.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 12:00:46 -0800 (PST)
Date: Mon, 2 Mar 2026 12:00:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Long Li <longli@microsoft.com>, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2] app/testpmd: add configurable flow count for txonly
 multi-flow
Message-ID: <20260302120043.7817639a@phoenix.local>
In-Reply-To: <20260227224405.61074-1-stephen@networkplumber.org>
References: <20260226191625.1049670-1-longli@microsoft.com>
 <20260227224405.61074-1-stephen@networkplumber.org>
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

On Fri, 27 Feb 2026 14:43:19 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The txonly multi-flow mode generates 64 unique UDP source ports per
> lcore by cycling the high byte from 0xC0 to 0xFF. On SmartNICs with
> limited hardware flow table caching, this fixed count can exhaust the
> flow cache and degrade receive-side performance.
> 
> Add --txonly-flows=N command line parameter and 'set txonly-flows'
> runtime command to limit the number of unique source ports per lcore
> to between 1 and 64. The default remains 64 to preserve existing
> behavior.
> 
> The source port encoding is unchanged: the low byte carries the lcore
> ID (avoiding atomics) and the high byte cycles through N values
> starting at 0xC0. Total unique flows = txonly_nb_flows * active_lcores.
> 
> Reported-by: Long Li <longli@microsoft.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Tested-by: Long Li <longli@microsoft.com>

Applied to next-net (after fixing spelling errors).
