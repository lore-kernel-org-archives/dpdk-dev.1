Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A1FF417F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 16:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31CCF402BE;
	Mon,  9 Mar 2026 17:03:54 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id 7DB7840261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 17:03:52 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7d73be007a1so2237113a34.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773072231;
 x=1773677031; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgdLBMqfmaeT63lmvrjO3P+agHPhMj3sprtChh/SIVU=;
 b=3WkNul/TME0q6qSeH6s3F/R3CKcmOUoJuK605kSiQ85izL35fzgpDTPMbYdmA8yRY3
 CteZB63148LB491mYQYgV/sqG+OJsGqKTA/m+GxrknokmvDvc95W9TriYJ/INVGOoDNt
 WZ9sMwwNM5cSSEJ4HA1rjdKIPBmAiINf2cp7wd2lvd6eZdFczF4fhyfoXk0uNwLQ8/Ck
 pQXXscqbdLiTf54YqLT0XbgftnPCh64muOYpDI1GhtKG5C8Cu4O44ae30CiOeD5OjbpC
 edBUAKdcr3GTydP+pMRmldDcvIrVyPw1xXJqwNfxwwUptX4qXl9O90H3YAd/SkpqJm3V
 KSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773072231; x=1773677031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EgdLBMqfmaeT63lmvrjO3P+agHPhMj3sprtChh/SIVU=;
 b=Vml2BIpgGStNBb73BtNqSu1bcuudctkzOcj1/tSGNlTQOH0DprPryLfeCXKFDhf4ea
 gVKhNRnotCU0dyBRSEK+l1Nw3jrDWflSBa7Q0UP/VfJd4U/uAHJ51e/Ki4ftpMZn++m3
 EUP8vPJSF5ptxpxdUOUnG/z+3gLzIcj5Ghby+NZz2PSEg6sCGma99gjL3jBUWQkk5Enj
 Qn4hoPSy71tw/0E6PlLF4PZGNi1P3lzRQ6ypSX1ZMz9BugmEy1aqN6jMupMhCQlBRvM9
 NVqOQcThx9Ip49ZrW8V+jcaU6rzrGUnXo8PWKOjdztrZOk2GWa54YzIWjBZjErWhRQo9
 qLyQ==
X-Gm-Message-State: AOJu0YwZuTijs04aPxNhsBKldO+o2FlZ2k1UnT9EV3hxH+9M0uo0S0WN
 Lx4gU+81IcwZlDwjPVZGF7qtTWuS+5c1cCjioKqsYk28ZrKk+D1lXMpGmZCWnDsDI4M=
X-Gm-Gg: ATEYQzzKGPWt5sNiuyFHQCqNoOr8c/kd7QSwRvQ73ka3SNq31golkwMIGAnwnwjLpiG
 xymj+RwwabSsjLR9ejh0cnmUmOMbBtJQZN2gWw/ofkXhkbcmnIaQSzqotyDA+f4Fex80FpAVnKv
 +BRtCgcpKFERtnQ9jWt3CsHXbcqYfPpREQRcP/hhhk9o7Axs6kmpZMsdWjcbed8zPRUFjMe9dF3
 uTdpMQ9j9YEYLGLTozp+GGyybmDeG/i+lXFhb2TufOpwcNLvD4Bf5Na/moUQe3dsRz0MKBhVLpW
 B6FxRYFrB7QBoAkBdqCnV0MEQ6YUf6xTEdWt0U+kFwJjlZ+x7EjZVYj3BXcFuNPL3l7tw4XyeTK
 D+Sfh6fHE50vMRpJJbgxYcg42j2C70MXTW2obuZLMuSXsv22Jbs9SAgzO0Nzsj8f9SYI/GsozMk
 pHx3z4Kzwo/4ydkWPNG021XWG5V1vLMoF1MCM=
X-Received: by 2002:a05:6808:c228:b0:45f:434:9c1c with SMTP id
 5614622812f47-466dca167cdmr6071850b6e.12.1773072231248; 
 Mon, 09 Mar 2026 09:03:51 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3adcsm5490610b6e.17.2026.03.09.09.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 09:03:50 -0700 (PDT)
Date: Mon, 9 Mar 2026 09:03:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Cc: <dev@dpdk.org>, <linville@tuxdriver.com>
Subject: Re: [PATCH v1 3/3] net/af_packet: support jumbo frames
Message-ID: <20260309090347.2fc2c74c@phoenix.local>
In-Reply-To: <20260306092013.2205076-4-xavier.guillaume@ovhcloud.com>
References: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
 <20260306092013.2205076-4-xavier.guillaume@ovhcloud.com>
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

On Fri, 6 Mar 2026 10:20:13 +0100
Xavier Guillaume <xavier.guillaume@ovhcloud.com> wrote:

> Derive max_rx_pktlen and max_mtu from the actual TPACKET ring
> frame size rather than the static RTE_ETHER_MAX_LEN (1518).
> This allows jumbo frame support when the user specifies a
> larger framesz devarg at vdev creation time, for example:
> 
>   --vdev=net_af_packet0,iface=eth0,framesz=9216
> 
> The advertised capabilities now accurately reflect what the
> configured ring can handle, avoiding both false limitations
> with large frames and false promises with small ones.
> 
> Signed-off-by: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
> ---

AI had this observation.

Patch 3: max_mtu subtracts RTE_ETHER_CRC_LEN, but the kernel
strips CRC before placing data in the TPACKET ring, so MTU is
understated by 4 bytes. This is conservative and safe, and
matches what af_xdp does, so probably fine as-is.
