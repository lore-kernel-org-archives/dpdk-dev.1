Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F12EA8123
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:45:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12C7740609;
	Tue, 10 Feb 2026 15:45:13 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 50BBC400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:45:11 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so19403715e9.3
 for <dev@dpdk.org>; Tue, 10 Feb 2026 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770734711;
 x=1771339511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr3zgWZ+V3zqaEolDhbRTp6j9jlSUGAHB9FntM2m+hw=;
 b=YWJ7IYTjsnqrOgu7D4eVBTAkcs9YuHWuv4M7cqDdpC/LK/S5J8wNH202h/Bt6aXHSW
 JqHyvTna2ELJhB7eCGIMraQmzBmqYJFpHdAbo8rdIi4MqrWV1spBrEtkH37fHGQFLSpi
 uMFzOeYGeHBmpItuQPZ3d1z5fktcCGBFiS5XQ+w8GQqwaXPs3k9u5dAXZwOCUtPmKHFi
 Nf1pPg0RJh8GAOGDluDvFF36iNbuL/zoyD5qqceSp1jDGfrEFKDa9jDflOcULjiro/Or
 9H8tH16Tbo9dF72jTpVhu2fHvT4RMMRrcrpsdYrbd3HOsM2YbXR+kRt/MvutFUl82hgM
 a83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770734711; x=1771339511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tr3zgWZ+V3zqaEolDhbRTp6j9jlSUGAHB9FntM2m+hw=;
 b=hgOFq/y/5SKPipG6ehnXTKDH37zrP4Euldcgcz8kJI7EwpdcUESOwUxYcRI/b7z+ic
 d5SwBTAYfyBLOM80O3SYU03KPtdFOdpqcv9ktZq63UVBVpWZKIxFWFN16bHY3lTt0x68
 jsAG885t+hmjDwGzQLLev3jZHGgA/eG1vtsurKxtIPwpN8JtdzXJfTcftREQQi0pLSU9
 Zi/r8CvkCygWjHOUtu2TGWp9qrTvleJkIW05DGw0irRjMHdo1edEH4EZ3uK7n1sdY8gy
 3vdnuTuADExkrjQB0DPGU1slqgTGB/Oz2FxZnVG0eKoLIzTBRTL5L9hH/Su6GEhOSLHj
 1yjw==
X-Gm-Message-State: AOJu0YzV45bhKH0VPAw+udNcanxW7z77BWJtxcMTs6SIHScB1njWbaw9
 SDzqAE0yoy6TwKgaEHYLkonTOiCoQpfmofei3iCeAgXU/eJKu2tYFbjxUlEqkHubu1xzuTimYOi
 3OU+Z
X-Gm-Gg: AZuq6aLs315OQ63dU/Hzs6iG8LBWJzl5PxXb0uO9qoMEB8exRUxbIot5XSKGLj6Ki7y
 cqN8PE50/f+vK3OKOkBXFiannJDXacUSLQTj5PcrUg559xKgSIUD6j3ZnV/i7sEbIsMjeoBzYNS
 Pl1lfRL4XeVapdnxPTx5Z9wkVj+6fQM1CXAqfkCXEkbMC8J5oBX1pt5es8kEDTAb1fZ00ZvHEQG
 ZtDuGeXS69/qRRWCEUXLYypL49CL4iEofGM0LFfgnKgVfBFLENr/2x5sBsDGNojecttinskNTjK
 RiVHL4iVmcs0ijhoP+jsBtCQtAwQrBO2RpnwHua4Fx/qgg7WVcBCT/BFbb7GZz/nZz2txUV+631
 zkrcRuZuOkRC0GBC0hJrPV38Jy7dx0258y7OyBV4dI+dKdkpH7BJ08ED2fodiOY8wfVB7UjS/jE
 bgiHKLlF3bFLUy5q1adO/zQzgAEENNemsrR14IKL1MH9ah+ajrJiMd29ZxCeTJ3BrW
X-Received: by 2002:a05:600c:5307:b0:47d:264e:b435 with SMTP id
 5b1f17b1804b1-483209669f6mr186554875e9.22.1770734710837; 
 Tue, 10 Feb 2026 06:45:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm59241875e9.8.2026.02.10.06.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 06:45:10 -0800 (PST)
Date: Tue, 10 Feb 2026 06:45:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 0/6] flow_parser: add shared parser library
Message-ID: <20260210064506.5e0475f6@phoenix.local>
In-Reply-To: <20260202113659.24052-1-sismis@dyna-nic.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
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

On Mon,  2 Feb 2026 12:36:52 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> This series extracts the testpmd flow CLI parser into a reusable library,
> enabling external applications to parse rte_flow rules using testpmd syntax.
> 
> Motivation
> ----------
> External applications like Suricata IDS [1] need to express hardware filtering
> rules in a consistent, human-readable format. Rather than inventing custom
> syntax, reusing testpmd's well-tested flow grammar provides immediate
> compatibility with existing documentation and user knowledge.
> 
> Note: This library provides only one way to create rte_flow structures.
> Applications can also construct rte_flow_attr, rte_flow_item[], and
> rte_flow_action[] directly in C code.
> 
> Design
> ------
> The library (librte_flow_parser) exposes the following APIs:
> - rte_flow_parser_parse_attr_str(): Parse attributes only
> - rte_flow_parser_parse_pattern_str(): Parse patterns only
> - rte_flow_parser_parse_actions_str(): Parse actions only
> 
> Testpmd is updated to use the library, ensuring a single
> maintained parser implementation.
> 
> Testing and Demo
> -------
> - Functional tests in dpdk-test
> - Example application: examples/flow_parsing

I am working on being able to use null PMD to exercise rte_flow.
Will add another automated test to exercise flow parser in automated test.
