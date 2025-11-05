Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BCECCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 19:20:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB2604060A;
	Wed,  5 Nov 2025 20:20:47 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 0D681402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 20:20:46 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-477549b3082so1294095e9.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 11:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762370445;
 x=1762975245; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz6eCQ1ahsyAcyucGy4B/aa4OuzkzQ260qHOPSn3xkQ=;
 b=AU59rlsQHcCvj93jMVcLBHnhdPauI9t8vPjXtgRiRUGQaifBUtc6Afz+aFBNrvmmsk
 6fvA2h6YuC2nTxJXjBoO314OUqQ/HhugUUrgsGPIp4l3+YTC4IZyCBKxQ0iYNkqn0+F2
 zUwXwwv0dJLCvB4Vkkz2SGNj2vFdQMdiI5dgSclwfsDnTKVpq5RJ4EpQ07CAofNMB1Du
 VhlKCQRaMKZMmt64SSaMpGcD9cwKoWxOgweqQjKSAj6tuR7XeKEUvInLOg3Zk7T5oXVe
 HcpItpAH0J1TJ6l43lfTZAHusjJtZpPmFEUbaK65FSo0ROvROaHZ0iqQDOD7Oz0X0lGX
 hBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762370445; x=1762975245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz6eCQ1ahsyAcyucGy4B/aa4OuzkzQ260qHOPSn3xkQ=;
 b=DNjLE4qEy5PEtCH0zpK2R8MX9V0D/muaTU/D7Aij4B3gJ1On2p/ptDzLyHHmpQH4ue
 807xvnuwOPEHI7zSMKhkcqdzBpM2KNlcaJF9jn63gXeN1l7OP1yIqoFgoL2kBO49oLhG
 YOEo5iI+ZS450w1bsnKlRlSzcZOX9V9oYReKBY4icqge7hVvR1det0+hIuT7WopqqWVm
 kXvrUxikNQEBAabYABr7CqhHkE9i3nuo5OCwIFqMr0BhXZlvwL0cHRJaelFK347/MLIm
 3Ul/WykkOVz/ew4LrUaI9UAUS+wVBD6jh9dqjH55H/7w21rCgam100wE51rqEW1qpyOq
 FTnQ==
X-Gm-Message-State: AOJu0YwF86dOzR2COIAQBg3r+sMH9HdYMTe1V1njVO5EYiYWEZVa4w0I
 9iJeecjQeN17RIDwqjvhT3LhgHh+lUOymdS/DNN51OWb1oIHJ6eDXHLjUEe3QhgtH1g=
X-Gm-Gg: ASbGncvhu/ssLF1VbOZifYEI+id9KWBsf8vYZnzhkaaaekl+UWhfMjHPqWDBo2QvsjZ
 71Q0hy9mDZDo7bgm2/LAIlqCM0CrdAHCJm2vMUJfZBBfKOF8rJ7yQJQpyeyDYtoD8ApnRIlULkA
 BYQJrsU8/gDEHlRGXtmdiM1e4Ovi+xxi+CmN7LVAmtK1MNIVFdkkvfv67Z+5Hgz9CcTGIiVnyDY
 1Dr6c9ZzjTUqh7Ycxunt7YeJZAVb+80sXGYfyOEwLfZ+rKZqa9oXBu7ojfPcZPSfFcHC9VAnpF8
 pOE6z/+gwHWCFghnwsAYCNzkkgOT5cedxvdmRkW1jGJawsTHMECdiuBJ1cQwg40A1rhEoHvyllM
 6buFV8xjjhN6TmRRJhyiJ2EdPkATxl0luKaGhnH82jduwFMash/evp6iI6m8dE0wJdP0UcMgDCD
 BC0VBlnD7ASgp286i2rTDP9cCpQBqk6AcP9w==
X-Google-Smtp-Source: AGHT+IGQ2YtCAibwBcg7C6K3ttJz53RfVSqI+zCjUTGJled+txO11PT/DmFIi1fRiN2RGJBsV81rQg==
X-Received: by 2002:a05:600c:524d:b0:46e:436c:2191 with SMTP id
 5b1f17b1804b1-4775ce12cbcmr39106485e9.25.1762370445467; 
 Wed, 05 Nov 2025 11:20:45 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477558d983fsm48618095e9.8.2025.11.05.11.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:20:45 -0800 (PST)
Date: Wed, 5 Nov 2025 11:20:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <thomas@monjalon.net>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 1/2] ethdev: make representor parameter more explicit
Message-ID: <20251105112039.1db64906@phoenix>
In-Reply-To: <20251105174839.323085-1-getelson@nvidia.com>
References: <20251028095831.53669-1-getelson@nvidia.com>
 <20251105174839.323085-1-getelson@nvidia.com>
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

Looks good as is, a couple of minor observations.

> +	/* pfX... or (pfX)... */
> +	if ((str[0] == 'p' && str[1] == 'f') ||
> +	    (str[0] == '(' && str[1] == 'p' && str[2] == 'f')) {

This is correct but seem like it is getting verbose.
If there are more cases than this looking for prefix, might be
useful to have helper function.

Looks like devargs could use some better pattern matching,
lots of string handling already in this code.
String processing in C is often an error trap.

> +		if (str != NULL && str[0] == ')') {
> +			str++; /* advance past ")" */
> +			eth_da->flags =
> +				RTE_ETH_DEVARG_IGNORE_PF_REPRESENTOR;

Can't that go on one line, max line length in DPDK is 100.
Is there a case where there could be multiple devargs flags?



