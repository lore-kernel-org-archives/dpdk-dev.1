Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0A0CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 15:20:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E681D4027F;
	Thu, 18 Jun 2026 17:20:12 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 04B9540268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 17:20:11 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-30beab3af9eso2917464eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781796011;
 x=1782400811; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dW/sA0lCZcm+CfuqftlbOPSL/96tpxfnvXbSYDjh6vs=;
 b=XPQ9JrdIjwdFDCf4VMrLFBZcVtqOPpoKSrpyeZE+Q09W+VaeHXpHk4Pn/Jy5tm+a3I
 MVvYrR0wzTABw+BsK7IlBxHJgqr/dPUU537Qp79LpjC3SFW8KvCfXhm5/TTLz90cByKZ
 F/Mv8nn+n4iVeLCCJNQA+j5uEfXo9h2tV/n0aAnWiG8bhbPWyiLKdokRHfbvWwsktaxo
 eIVZc+a+U4Jnr6qrKfddQBngcsRqQ4H9cgVO9s7KyKlnbO86F0xvKpFjotfrXSTiXTls
 j65Ymcq+m+M0WTeMFrJiCyM8AfAj0VazknBrhRosVI49ge0UM4oqCrsk3SXhJH+Gszzu
 7b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796011; x=1782400811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dW/sA0lCZcm+CfuqftlbOPSL/96tpxfnvXbSYDjh6vs=;
 b=ih5a3F/5cKQ/MCyH6x/l4+pfR6n07tHyqguGfbv+luSRp64KBg0gCN14Ojwi244sii
 oIBJ2uiKe1EoWJZ2cGOBEvZqNlxSZ+P8gwygdvG6Vhl9AgDBMF2MEXkcntSrJHVk9o7G
 lXlBjPK1Ft5CCEtMVyl8isBhG+2Dj/Qn6zpFJjEfbftK93WH88JDz89vXBJdvQr+4qPK
 O81c9ANjQOg2XAckFKoH7LquytXzYR+3bZSGgxa3qlN+554ZOc/EIob9c0hYfwt34WqP
 jzSg64FOXWkDcGG8wVSDwmyw4XCJ+w2V2EvFGUMB8co25liXxrmbB8ISs5dBTKxbz+W2
 /vqA==
X-Gm-Message-State: AOJu0Ywy9DdKJ0GDZi/AJ2hTQDqeXI7hPDPNXcjTK6wlJaHdXCtsJ1gV
 GI6hR5m6QVXYfb+4tBrvQ7E4AYN8ZJd+6iDDfF8F1CIP5CffGrM4CFHMKbrjcHMXDdk=
X-Gm-Gg: AfdE7ckAa+ZDR6IiNcwMe/dgxY65WxcAQ/Q+SC+MBxmZzMQIcDEbv3tA53pttH1/+PB
 S5DPlf0bcV0icTmRS/cy0kxMuj/UpehSwFcibMwiuNlZujApynYZm7qMS+b9xly05xs3/j73D0D
 TvsRiYtEEXDzR5veerlhyFmVZC449r1R2JGULPuKyxN3gucODsXF8oIFIiwdgspLxaqYISoyia3
 +ppQQulq0t6kdTTkFIhZsh98d2WHUNnlcIBG16nuU0aljJoBHuti67FnIVqvxzHJVVDW+GeNJYY
 yvIsl7aJyCbA9X78w8vDwL/aUgrvgOkccGyYZCVa4+uEUEnHiPs/xsLmE7IfQ6QkH/rxOfxsnoe
 VeIRw3mAqct50e2t9Et1NW1Pre/Fhobk/wnIfTAQ/elEroa4hTWtyiP7TR06TIQonngvKjEaVRQ
 +xXE8Ef08sByzTjsTvgz9BdBfl7QeXKWZf6jdhGwUhKfX7eA1eXYbfIQ==
X-Received: by 2002:a05:7301:228a:b0:2e6:e504:5431 with SMTP id
 5a478bee46e88-30bc9f53fe3mr6744876eec.22.1781796010748; 
 Thu, 18 Jun 2026 08:20:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bc50631f2sm6622865eec.12.2026.06.18.08.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 08:20:10 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:20:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, Marek Kasiewicz
 <marek.kasiewicz@intel.com>
Subject: Re: [PATCH v3 1/1] pcapng: add user-supplied timestamp support
Message-ID: <20260618082007.7a9c1e00@phoenix.local>
In-Reply-To: <20260618144432.312767-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
 <20260618144432.312767-1-dawid.wesierski@intel.com>
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

On Thu, 18 Jun 2026 10:44:29 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> +static inline struct rte_mbuf *
>  rte_pcapng_copy(uint16_t port_id, uint32_t queue,
>  		const struct rte_mbuf *m, struct rte_mempool *mp,
>  		uint32_t length,
> -		enum rte_pcapng_direction direction, const char *comment);
> +		enum rte_pcapng_direction direction, const char *comment)
> +{
> +	return rte_pcapng_copy_ts(port_id, queue, m, mp, length, direction,
> +				  comment, 0);
> +}
>  

Switching from function to inline in header would cause ABI breakage.
New build would not have old function to runtime linking.

In this case, please just keep the old function name but add
a parameter using function versioning.


