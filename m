Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2AE7DF13
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:52:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B0024027D;
	Mon,  2 Feb 2026 18:52:53 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 6AA234026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:52:52 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so4550409f8f.3
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770054772;
 x=1770659572; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=1nlGPC5bWU5Zrv/VMevooD3NWWP3PN/nDS/67onWt0g=;
 b=QiGIXNkztvX0Dcvxrvh5NizfKwzV8if9M6euKIz/XnxAPVl5L1YEY+W3Pga6B6zluJ
 95x0AcFyrDMwBaATH6GpxOleAfUW2toGzcSXX1ozC/tktuhWLmITrBGUAzcxtErqg7+E
 Ev1F67HYIbi/9F4+BmvYSiCHbgYHrzC/Sa86nnql6jaf0VpAckkKvbFbYEgMo4q02ui9
 0UspcanOjDyuav45cmik4vTlKI4bUF3/MrbR3JYncSbEwxtz0PIbKWHPvtvCBoJCuA/3
 lPlvgB0N2bgSkaLZIGvBF7PwTJWj5v7wo+iRPd/fAq25KpGrGw/1I8IW/qELwuhp6VE7
 RRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054772; x=1770659572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1nlGPC5bWU5Zrv/VMevooD3NWWP3PN/nDS/67onWt0g=;
 b=AH091OBesIOiDOCv3P6zrU6yT5h0SkXgxuJuR5Mlrev3fBubatDwAfP7KVPKmKvfbt
 MIh/RFaaR1L9TDSt3b3sJXT5CpDf2jUDPZ1NDL8+vT3HY0fGtm9i2TfipUQ7tOWlrN/f
 8fsNoLv4h53eVaeZ6XHhudOPtUlcqaMSvWQsZu1m2cz2F4p19E+ML4V6B8XHHY4nKRKS
 lEyRB2TcZMwcdx7vAm/vVhz8/q/iUli8UYKoSIfWoluJW0587b8rg/S3id60F6iJIV69
 FTrJpyjJ2xzrLRpsiwWzibuE/I5h/4mw2qIQMBhRCA4ryxe36Wyk80uAyaZH9CNF6UQK
 TfWQ==
X-Gm-Message-State: AOJu0YyKMId+RpqAnyI0qsMQFehjHM3x0hY2SET/dX+dIcMSk0lnd0yv
 +XSQVnv8wY9G2aLCl2V1RYjyLNRe+C6gmqr2pji+jxHll2MA+d1gWNCZIYePLJ9C8Cpfs5MF0CJ
 mHMSb
X-Gm-Gg: AZuq6aKRsJjBlKkFs3dE+Ag15eTfvOymsLlysmLqmZ06gXQa30dyR9tlZ3bygnjt4VP
 av13CZhLw/cktXZsfpfvLYQQ/X/D1N8lzJSnONhehKvzPsee+MQJpTwKLKI6C7fgtp3bxoU7Wha
 jSOSr5DEtGBYYJu/jBkRWc4OdMdDfv0K/s4RCzgfUCjDf1Fkv5HMUZ1Pus18BZU6/TXWwHZLVVO
 X6ZKSsDaLHZxBRYHK/1FWXdoQRmxQFTfjFF/zq+lEH2snyWxlNFDxy9buIfMn0J81dgVVA4SGV5
 VKaqfkOCn4V4OffK2ybbKjDGWXh7Fu61iEuKam2l70/u087nnZ9IiimGJYaaGlC1VHlhbRjJmss
 w6PwIghPIAd9blVuFKL9pFAbdPSSowr4iZyj1WHSiBa+sMZ1kp84PLDOoRkIMFvshAlVXNwPNDP
 MVj0RKeVi5me4OtUiEO1QhRfA4QMmf4/7OKIt0uDknCPigE77yGti0H+hxKiXCCTQ=
X-Received: by 2002:a05:6000:26c3:b0:435:91b6:f53 with SMTP id
 ffacd0b85a97d-435f3a6b868mr16108598f8f.8.1770054771934; 
 Mon, 02 Feb 2026 09:52:51 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354d43sm49731120f8f.43.2026.02.02.09.52.50
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:52:51 -0800 (PST)
Date: Mon, 2 Feb 2026 09:52:46 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [REVIEW] doc/nfb: cleanup and update guide
Message-ID: <20260202095246.1888b43c@phoenix.local>
In-Reply-To: <20260202174235.20628-1-stephen@networkplumber.org>
References: <20260202153449.3295979-9-spinler@cesnet.cz>
 <20260202174235.20628-1-stephen@networkplumber.org>
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

On Mon,  2 Feb 2026 09:42:35 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> ## Patch 3/8: net/nfb: add vdev as alternative device probe method
> 
> ### Errors
> None.
> 
> ### Warnings
> 
> 1. **Unnecessary cast of void pointer** (nfb_vdev.c:62)
>    ```c
>    ret = rte_kvargs_process(kvlist, NFB_ARG_PORT,
>            nfb_eth_dev_create_for_ifc_by_port, (void *)&ifc_params);
>    ```
>    The cast `(void *)` is unnecessary in C.
> 
> 2. **Missing newline at end of file** (nfb_vdev.c)
>    - The file appears to end without a trailing newline after line 108.
> 
> ### Info
> - Useful addition for virtual/simulated NFB devices.

The first is a "meh" not a serious issue

Not sure why false positive #2 happens.
