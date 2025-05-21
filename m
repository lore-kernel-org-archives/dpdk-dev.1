Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CCFC54E65
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 22:24:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75DCB42E4E;
	Thu, 22 May 2025 00:24:17 +0200 (CEST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53]) by mails.dpdk.org (Postfix) with ESMTP id 3059240ED1
 for <dev@dpdk.org>; Thu, 22 May 2025 00:24:16 +0200 (CEST)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6023cf146d3so2448122a12.3
 for <dev@dpdk.org>; Wed, 21 May 2025 15:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747866255;
 x=1748471055; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+EZQkfmMX1wJj7TTwxjEswh1zfyrpziJlXmrBqPfyY=;
 b=eVs2GqNaKmST1v2n8WnrUCL69J6Tk78eCq9Q+cqZpM+LR2OjQMmMt5FRgxp0uu8Rjt
 +Y+1qa1gSEIxLIKfCnd29D8TUra8IrDj+4vwAUJhaF3rwL4KdE7jxU4Hqx5jLwjJ2v+e
 XD/KmsFQi4vSnWHg+6TIqglnH9b2716LlQX0Hyx1ksN6IaulQq2MKqSYTmsgAVnG/Z7E
 l9mJmNrDXmNMYwReWBdWYgvA3pZze3WASlRRMskm1hklA4sNt7cf/Xv4SwudwT6XxcKq
 y3ip33TIsj0UvfdiENvySNtlu7UzJmHkOG9AFU+ZRXsH5HUdbfi6XN3nP6H3GPZsccg0
 bfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866255; x=1748471055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+EZQkfmMX1wJj7TTwxjEswh1zfyrpziJlXmrBqPfyY=;
 b=wkSDoiTExA7muV8YWtnb0lSrc/wBQQBfU/b3jL5VEIY1HgiouxH4pLxSz5YNuyLXEu
 MpmADrKD5e30bdg8ReNM37hcBwHvOym5JtYZ9+pI9ZSi5fP/3tIxgAnj9MWiF1A0i2ju
 C4VJ/idGcIi4MGXzYNbHK2S2zzQxDtCg0Uw7s87aBbG681d7dV8I1y7W+WFI8rjre7NS
 2GmCSLUndgRzJEZFVJxK0gwK9COMuK3QzT/oOteiXdxGTYit/uMnuzn+GJ2aiuwYqqA2
 7mazsggabQmsLvmHfM93j5v1qWqTGULay2SonTMMY0CFdpjHnfSMxXx2d02jiq0gbuPO
 9BAg==
X-Gm-Message-State: AOJu0Yy04w2jilbx0UOYsMQGP0FwYRMmDmwUIKqyWR5kMTXupFkwzp68
 QnvNkF5I0bOZsmPAv1mE8DYnrMxSqpG3plU7rfpiDbH9P0xFm/p6pefMqJSyCDAj574=
X-Gm-Gg: ASbGncvQo5OkNaZQo18R0vprUdKDawYtg8KjjEy5qmuqqhfmVX6Nmct+IZW/DTAxjoD
 a8hipt24umQxLtwHePgvIznlPb5x/l3iYvPMbLD1jlroC/2w8+/y+O9fiSlG0XEAzLqob0SQZO7
 cO2OJ0yGB8zMCdeZvkrtgaO6WTaYwOIiih2rZUqqWFpyRS296uJm4WVW6BiPulGoDdBYASlH3Zo
 b6T+3E6DpHFL987VFYPIj7ad2P+DX0EctDy8oSbDI5G1F1xGFZ62AnGLrhqPELFlt2NSlG9T39x
 K91QppX5xMZra28GSA/ApzzX88PXYFH2jp0kno5fNtXv255OLEejowfJYLzIhYD+33RiSUIBXQC
 XC3zapnyGjfkHwBTgAYwcHtL+x2qF
X-Google-Smtp-Source: AGHT+IGLJPM2AhlRuyZ7g16Y2xYIwumTH+N38bNr38J30oj8tBX+TNRiiYsvD9ibYNnpNkb0ma0eIA==
X-Received: by 2002:a05:6402:27cf:b0:602:225e:1d2f with SMTP id
 4fb4d7f45d1cf-602225e2f1cmr5506789a12.9.1747866255415; 
 Wed, 21 May 2025 15:24:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60203c21233sm3814101a12.71.2025.05.21.15.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:24:15 -0700 (PDT)
Date: Wed, 21 May 2025 15:24:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v1 2/2] app/testpmd: sort commands by help string
Message-ID: <20250521152409.37302820@hermes.local>
In-Reply-To: <608636ba99de43497d42f41787fec7005cc2e52b.1747227723.git.anatoly.burakov@intel.com>
References: <9d6e0ff75abe0185c5a03aecba3269668860a1f7.1747227723.git.anatoly.burakov@intel.com>
 <608636ba99de43497d42f41787fec7005cc2e52b.1747227723.git.anatoly.burakov@intel.com>
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

On Wed, 14 May 2025 14:02:12 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> When using '?' to find commands, it occasionally is difficult to find the
> needed commands because all commands are not in alphabetical order, but
> rather can be ordered rather arbitrarily.
> 
> To address this, use help string to order commands. This sacrifices some
> amount of grouping (i.e. when tm commands go one after another), but may
> improve discoverability (and most similar commands tend to have similar
> help strings and will be located closer together anyway).
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---

Sorting is good, but why not pre-sort builtin_ctx and make it const?

