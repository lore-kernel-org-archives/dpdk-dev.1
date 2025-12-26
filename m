Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC98E8FDB5
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Dec 2025 20:07:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09B4140267;
	Fri, 26 Dec 2025 21:07:53 +0100 (CET)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50]) by mails.dpdk.org (Postfix) with ESMTP id 0746540262
 for <dev@dpdk.org>; Fri, 26 Dec 2025 21:07:51 +0100 (CET)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-64d80a47491so8638498a12.1
 for <dev@dpdk.org>; Fri, 26 Dec 2025 12:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766779671;
 x=1767384471; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8AqslaoZh2w+tocBMUE///t3LRr8m4qsvcWWBLMJS7Y=;
 b=2FNHbRrFK0eNrDH4HbSQs96FOitCDYDBaVb1pTwz4t/omotxl3AsC1cnjdH3WT0rL5
 JsFEVBl8RvKOeyeDnflYoA1nzRKT0jj82lD8+XrYEqep/jkzIx6IqtfVxtKli9p6A0mW
 jD4q/u5IhggFXUDpjivo7Ua8bNaCbUJN9TP27K3IEHWj5bc0OGoq4DAjQL3FMiTFxRuE
 iAEjS5JyQz7Ut+ZASVipzWzYUNR8nhq05ChOwe9AL+GNRYtC88CXAToEEvX8yKza4upm
 RBOr/zuhkiUPBjmJjDO9qSfchj0/zfYgbSyyED/A36CGmJ3beCaK5SiQQhuqJlT/XqoX
 8LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766779671; x=1767384471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8AqslaoZh2w+tocBMUE///t3LRr8m4qsvcWWBLMJS7Y=;
 b=WwFkil7ZVsNf1x/i4uy41o6+hVPYvJtHfSm7RHVIhg/xYfI5ABSVhglBduamTlQGJq
 nUAJ5dJS44P3rIf8s0v6LN3WsjYPlnM4Kvy12iLz88Yov+0J3iAcZZqMVjAIbr5OqJl0
 w83HKUjPmVG+c0cyxlUVg6bj0SKwiTtgBb8i9U7iw/k8u8QdLRepdpG6v91+U+ai07kO
 aYTkbW557VRUPIuIK5FPtbce6ig+5jYgaZOWW1NVAlb+NrW+uEF9UeebS76jw7NHwkWl
 SWhMpsqsd/eQAYXaIr6u4G/0UPtU0V2NHwpo7/KPa2JvbCirHeNU33BRSJPiA9B+m9yK
 DnTw==
X-Gm-Message-State: AOJu0Yys/81LXyte2K0zkMHboneRcFoRWArpOSsWhfK+sYkfgOrUPv+y
 4cehreIFIqrWAr5e0IUh7i+UvU+UXxU5afU7CyNDKPRwhekf1yQZlAo6c0IEQnADm2s=
X-Gm-Gg: AY/fxX5PnATbcrkPfzr444E+OxLP9Zn863coddubghlzJPg38adO1z+sAT4e+dqCEQi
 nE3SgX4r3f5okSAgC9cZRHXA/iUDzvlYb2AX5q0dREtT8gErFoRs1dWEO9AbPiayaYHfkxFawB7
 5kVK3f7sefIZX0ByPYZSN88YKSs3fUgtLPPq63Yz2GmwNw6Js5SQJnyUN2WARyOpMC7NdFAl3qt
 tLM+ekNiFv6BzxCURfNpWHkBtSM2nthOL2FInDZCbSfublbe/arvC/+RkCFV9S6eRX8QGkMWZ7L
 6JpZFE57z6WQf08RPA0TLVqHTcnMIomchsTzEmuPna19ciA6VVE02xT4uZTtYqLKfR8UxgpkoO0
 ogXiLoAMxh79bHRMJd01lon8jAPEvvD6K5kM4N+qk1EFNvJu+QLOgINWp8MrQszU+0Nw/KzWy8L
 UZ7byA0bQoPN30r5jT8EAHBHuPrfkUfkeluio3goErlYm/I+eNZbKgSvDhd1ZTaM4=
X-Google-Smtp-Source: AGHT+IHAvmwjiSOF5NTTdjc5qRD+023mHeVBaaQiP+9syklAn0MIzhPxdU8F8sLDHCgkNsr7+2/dew==
X-Received: by 2002:a05:6402:26d5:b0:64d:4149:4924 with SMTP id
 4fb4d7f45d1cf-64d41494bb3mr19703724a12.4.1766779670855; 
 Fri, 26 Dec 2025 12:07:50 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599844sm23912635a12.25.2025.12.26.12.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 12:07:50 -0800 (PST)
Date: Fri, 26 Dec 2025 12:07:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, wisamm@nvidia.com
Subject: Re: [PATCH] doc: update flow-perf.rst --query-rate option description
Message-ID: <20251226120744.2351fb83@phoenix.local>
In-Reply-To: <20251226015057.49408-1-sunyang.wu@jaguarmicro.com>
References: <20251226015057.49408-1-sunyang.wu@jaguarmicro.com>
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

On Fri, 26 Dec 2025 09:50:57 +0800
Sunyang Wu <sunyang.wu@jaguarmicro.com> wrote:

> Update the --query-rate option description in flow-perf.rst
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---
>  doc/guides/tools/flow-perf.rst | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/doc/guides/tools/flow-perf.rst b/doc/guides/tools/flow-perf.rst
> index 5d7ae86cb0..a289ba482b 100644
> --- a/doc/guides/tools/flow-perf.rst
> +++ b/doc/guides/tools/flow-perf.rst
> @@ -89,21 +89,6 @@ The command line options are:
>  
>  *	``--query-rate``
>  	Enable query rate calculations.
> -	The application measures the rate of flow rule query operations.
> -	After inserting the specified number of flow rules, the application
> -	queries each rule sequentially and measures the total time taken.
> -	The query rate is calculated as the number of query operations divided
> -	by the total time.
> -
> -	Example usage with query rate calculation:
> -
> -	.. code-block:: console
> -
> -	    sudo ./dpdk-test-flow_perf -a 08:00.0 -- --ingress --ether --ipv4 --queue --rules-count=100000 --query-rate
> -
> -	The query rate measurement follows the same window-based approach as
> -	insertion and deletion rate measurements, using the window size
> -	configured via --rules-batch.
>  
>  *	``--dump-socket-mem``
>  	Dump the memory stats for each socket before the insertion and after.

The description in the guide is awkward to read and unclear.
But dropping the complete description is not the best way to resolve it.

I would recommend rewriting (maybe using AI) and make it clea what the
test measures and what the expected result is.
