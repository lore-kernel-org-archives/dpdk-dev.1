Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A919D232C7
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE9C64066C;
	Fri,  9 Jan 2026 02:21:21 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 3085D40279
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:21:20 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so31267415e9.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921680;
 x=1768526480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=0UYCaDiewwTM/TiBhWKCzCI4uzCdo8Geni7ZewOTnCE=;
 b=un1jEXi/1kohSm3m7aVKy/S0ltLQ1kY2VRu0T5ZtAQ35nVS1PBRFFxRDpx0/JQek1t
 cRmgKuuN0Rk+itmbXOIymJuguRF499P0Um9iz10SnCwZvHtur/3hRl/Byl2BgGqEEcnX
 wcgERyJC45y/XYEc09CyvkeLW7wineeuhL0w3jw4jf4/xl8dbmEAopV0R6R0DPLLTCuD
 xas78BmLYSmZ+IP7C40EXKF7HrghHxtA1IkxcrxxYSpl5S+qmp4J4OY2St5wCoOcrP6W
 tyV9ztOZGGaq8U3BHR6qrAwYKCXQ7oSl8LF/r2SG4rQmgc7sAU8qKL5nump9Y4uX5mZm
 f5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921680; x=1768526480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0UYCaDiewwTM/TiBhWKCzCI4uzCdo8Geni7ZewOTnCE=;
 b=q9OKfPrRe83KEam55WU0fVo5vYHqEyop8MDVVAuwPJFCPPPw2j8JrbNW+wVWedMpr9
 BRfmo0Kxlmw3E1cdUERJheDXcd8djYF7YTzbj3SeL87l63noT+t4/Ayn8nrrXV8v20kR
 QMUzNKU6/5IBEd1O/Y6q7msp0JuPSW5OqscMpdcVyfXvgC631AajEU7Q/iYaNYPVcHnD
 05fPczMJIB1kQqDuc2VIC+y/kPC5nAEJQ7gkaRTF9ukMtG82SOLWSYwzjTqkOoWFlvHA
 62H1r0vMeToG+B0VJpwrYRTA1jRBPMFKaCEq97hgHnPxWcwk2BMbzACLuygHxbQ2D7R/
 6MBg==
X-Gm-Message-State: AOJu0YwL/2+gnfQrGfwZsQWxnxrkv+8YhOlkRZOFsOdNXQT8hs+6iDPJ
 Sq2UtUjrheq1+k3UfqhN64cpro1sUZKYGPv2FJosPk4VISG9YJ1Czfa2xWhLYV70KmbHX49ygXk
 0qU16
X-Gm-Gg: AY/fxX4LQOYQec1DE9qQmVR+TEOV75/W0WSJcYLLKlJv7tIuA2RKn+1y655t9T3R6er
 8vB4xBhr4OtRW+eCJ2RR1OwEsnXjIlKlIAM/vDQu6SzUXnQSaGdUtWKgeO9zGDHp4tpKGJtEjnH
 2CbCBdCOoERIcviicOwSLd9gdqg6BHLvHc/tY06pgOiuIURGXZ1Ecdpu6RRu8HYVR5Ne1Ixh+/X
 4LQImsm5N8yXv+d7LjV9WrXbc02iOo89O/NXceLnEIf48da1+0ZrGrxEpQzSlFq+GcRZqmczXGP
 HYvwyncIwwscnt28Mx3cAlReqiCj7uDlrq/VPqMSVGKF225IqoOsSrq29JWX2sL4pxrHi+Wrg34
 vPCLTHEZzFMIL9kl6RXY7fJZlsYHyEN2g36PQnHl95ac71GiSz9gHNKhrtmGQpPx+c8ZqSk6ub7
 lxkzE/yjmEoHDtfrfJL0q9KOBspJrVAPoJewWuGAk3gRCQtScy+J2+
X-Google-Smtp-Source: AGHT+IE6hdxISSvjzPEhrGBshCrhYXKsnUsY4yL0JvPsE9myKta13qHaAYezSkaA/lpNtDV9gWFdfA==
X-Received: by 2002:a05:600c:a106:b0:47d:73a4:45a7 with SMTP id
 5b1f17b1804b1-47d84b3badfmr92612295e9.24.1767921679718; 
 Thu, 08 Jan 2026 17:21:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6f0e15sm176256815e9.10.2026.01.08.17.21.18
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:21:19 -0800 (PST)
Date: Thu, 8 Jan 2026 17:21:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH v3 3/3] test: add a test for null PMD
Message-ID: <20260108172113.04a982c4@phoenix.local>
In-Reply-To: <20260108204449.176087-4-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260108204449.176087-1-stephen@networkplumber.org>
 <20260108204449.176087-4-stephen@networkplumber.org>
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

On Thu,  8 Jan 2026 12:40:48 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> Add a test for null PMD including different packet sizes
> and lockless transmit.
> 
> Original version of  test was generated with Claude based off
> of existing test_pmd_ring.c with some cleanup afterwards.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test/meson.build     |   1 +
>  app/test/test_pmd_null.c | 968 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 969 insertions(+)
>  create mode 100644 app/test/test_pmd_null.c
> 
> diff --git a/app/test/meson.build b/app/test/meson.build
> index efec42a6bf..a45991ec34 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -141,6 +141,7 @@ source_file_deps = {
>      'test_per_lcore.c': [],
>      'test_pflock.c': [],
>      'test_pie.c': ['sched'],
> +    'test_pmd_null.c': ['net_ring', 'ethdev', 'bus_vdev'],

Should be net_null here not net_ring
