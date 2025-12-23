Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E28E6B26C
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 01:16:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FCF640296;
	Tue, 23 Dec 2025 02:16:12 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 7E22240265
 for <dev@dpdk.org>; Tue, 23 Dec 2025 02:16:11 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so33515845e9.2
 for <dev@dpdk.org>; Mon, 22 Dec 2025 17:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766452571;
 x=1767057371; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eubTQbkUiqWX6u8wEeAs1LUadxSUVH+r39CPzodMa8A=;
 b=b/hQSmCAEwWQMKb/opRNvZfB+xgaXTr8WKGoGkEri9BICZr6evAFjtXwSrFJGgr9Wd
 I7QcrKqJS56sd6UglLcnIx3tnVS6h1kDcikvQ1Ap/NI7LY7tOJdbyWzO+48XwUq7TCud
 4ZWaBzhhNAP8b5FZOqtfD8ZVWACY8FcykQ0NocxkklIK2Zxx9MbvBY1dMo+iC3W/PCmk
 gCd54xQH1TsfWbjeusKG57atBIv8Siw9B4bUMijP3dU14EcDipebxpSM8McBRDobQxr+
 BsxBPAvDipWkOQwoDFIW3xUjU9OuCr29CKxJnE2FVI+FpgbpaNaZHUbFGQRWrtOhG5g2
 2mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766452571; x=1767057371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eubTQbkUiqWX6u8wEeAs1LUadxSUVH+r39CPzodMa8A=;
 b=FDd84dOg7dfcBKiBhEinPeKksLgt4ODOvHvbLtZcpRSSXpyUN75EQ0osDKuXFcrBMO
 ziec1WCq4gsuDHgJrBS9kxYSHZExMg+te86eL32xoRW40Kst0p2jP9cSp3fgGBNml1C1
 wGGoM4bLR8IPct3MYC01eR/BEtVrqRZ7ON6AsTtUyDdnCxltr30ziXzmNwwI7G3yp7Bx
 8tkC1Ci4GXh5QD0XgG3Yf0XlyF2ZkfVWxssb4RQ8jMd3653b+wBkGqDn+DkxHIZtyEYC
 277G3QEzFgOprho2WPQb5ls0abKADO4+cUkPYplhR36Xd4ewmUpzvHn27h9H8AMkGYrG
 P8Yw==
X-Gm-Message-State: AOJu0YwXKSEejEaixyT44iPz8eyl6ATthfQCc4GPJ/u1yeyQMiQ6bi4C
 5/L1I03y0kBntpheoovxmkIADE7sfJsplwO0DNnh+M+/WncTzY6TPdp/FWPdrpFPZPU=
X-Gm-Gg: AY/fxX68pHalbUU4O+ovZfpZYRNpORoRzWyYKFwcMmim3ba7r88lHFOcBXaRv9J/mOj
 T0PyiRCdnuaBftQUW88N5Xn+OmyCMO6fQl02sAcd25Diu8mBeUo68HW+8ciK0EHf6ai2GzNoS98
 73pF57yDaD+nd4V2maxrirhyQQLGzj384ZvEq1D9jRQJRp5F1Ln5ce47h9Crbhzw0kPNjcE+e98
 2oC/edGYiRg8S0+DvWwtA8QSSf2Rb3Pa+jWvnv499TPwVc6KCJpUOP9sH/JtCSbGs7WKVRy/3Tz
 OYOyoxk+EWl9jeADJWfyI3uR/ChtVcPfVc1YFNsUIMZF5hLl0fjXcmIspqgNGP8svrzHDRqziIP
 dmkWisv+kICNpvmWjwTLj+Q9eTqu11bGnINdQsTfStZFiN9cJDv/vNSmOJAare4B6K4W/lhmUqd
 fkPSY1SrNtQKwgkiuiXc0p37gXzav9+uqGDda4EgXWlQvDESV+L+hQ
X-Google-Smtp-Source: AGHT+IGZuRud4+TQiooyiAcD3c4jfOQg7fsKwwxAyxdaTmcVaUZZXou++RTvJYE5qASCin/2evZ1vg==
X-Received: by 2002:a05:600c:a012:b0:47a:940a:c972 with SMTP id
 5b1f17b1804b1-47d1955b72emr128703785e9.4.1766452570832; 
 Mon, 22 Dec 2025 17:16:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm227883005e9.14.2025.12.22.17.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 17:16:10 -0800 (PST)
Date: Mon, 22 Dec 2025 17:16:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ciara Loftus <ciara.loftus@intel.com>
Cc: dev@dpdk.org
Subject: Re: [RFC 0/3] ethdev: introduce device reinitialisation API
Message-ID: <20251222171605.706e9f62@phoenix.local>
In-Reply-To: <20251017111109.1734792-1-ciara.loftus@intel.com>
References: <20251017111109.1734792-1-ciara.loftus@intel.com>
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

On Fri, 17 Oct 2025 11:11:06 +0000
Ciara Loftus <ciara.loftus@intel.com> wrote:

> This RFC arose from a discussion [1] around whether a generic API that
> performs device reset and reinitialisation would be useful. While the
> net effect of a call to such an API can be achieved with a sequence of
> calls to existing APIs (reset, configure, rx/tx queue_setup), the
> benefit of encapsulating this all under one API is twofold:
> 1. the burden is taken off the user for supplying the device
> configuration in the call, we use the existing device conf under the
> hood and only need the port_id as input.
> 2. it can prevent potential unnecessary/repeat reconfiguration steps.
> The PMD dev_reinit ops will only perform the necessary reconfiguration
> steps after the device reset.
> 
> Patch 1 implements the API, Patch 2 implements one example of the reinit
> op for the iavf driver and Patch 3 integrates the API into testpmd.
> 
> [1] https://mails.dpdk.org/archives/dev/2025-October/325386.html
> 
> Ciara Loftus (3):
>   ethdev: introduce device reinitialisation API
>   net/iavf: implement device reinitialisation callback
>   app/testpmd: support port reinitialisation


It is reasonable idea, but unfortunately eth_dev_ops is likely exposed enough
to applications that it could be an ABI change.

Also experimental symbol would have to be a 26.03 version.
