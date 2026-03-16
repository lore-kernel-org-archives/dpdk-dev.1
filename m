Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E22F53D65
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:15:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94EBA4025E;
	Mon, 16 Mar 2026 16:15:11 +0100 (CET)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47]) by mails.dpdk.org (Postfix) with ESMTP id 34090400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 16:15:10 +0100 (CET)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6653b589a78so2045875a12.3
 for <dev@dpdk.org>; Mon, 16 Mar 2026 08:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674110; cv=none;
 d=google.com; s=arc-20240605;
 b=gQqZe2hMZAm/tsKbO+nRsKq6AIZONAg86JRL7vLVh0im/wltwhwfnNrsVYjUM6CQY1
 e5dPOaL1A6fQPUmvHexCkYjnvwDp7+kGWe4n8lq56aCHu/6+XXDkKr2tw57cnHQ1oSz7
 qJpQ7+WagDQw9ilYEExc1I8SxxmOVKvb2cJtFaeiJV35bZWCGFeoaHr98T/t3Ks9d7yj
 JiGZ85P1Uq3FW+68FHS04ld1h2twe7uGmTvar8o90DZRLsVmnxwe/lMGTunLFH+PfB3y
 bUwrpfd+jmovFiaAeKu1Tx4/co1L367R9B1RW9yV38aY5VZQ2ALRx17NG06NcWdptmNV
 IUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ri7qxm9NYLe1bTR1YCo392z+0jehFIbTh1NdLIHLiTY=;
 fh=wstv09w7RRp1gtjDrdZ5lGXNxP9lXUK5bMZedz9Ds5U=;
 b=a2a8hNc7SlU3XigYX9tcBbJBXt1E7b9hMftVNXkeSns0k/TNvUT+JCXqTBCe4BxI12
 2dLMzMW7uA4APjdKkrAPOELatWGEO8pYl2l80Yv5YulJN2PIlyur4L/byCduA5Lsmzur
 lppiGyedPHuHRuXumFucbM1VmSn+n81/9okgIM9Shj8ze1pTIDzj0LXN52fBZfI2NI4x
 /f1Do5z8a+0wogrbw3F8Qy/pAdoalmgeMymOzWhF0S6bGJeee0h4bQqiHuPRJRy/dBtI
 Risr31FwIR+EhPE2fF0mCVy2h66JhLvLFsU2s/tcaiL1viNyx0qjTbGBMEkzMbQ/vNnF
 wUsw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773674110; x=1774278910; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ri7qxm9NYLe1bTR1YCo392z+0jehFIbTh1NdLIHLiTY=;
 b=RvYwuUxy9AQjiOCsCE26C+K3dxF3ddUBeEvVvvjegZHrntiZaMqbmFbfXSaT8SoBkq
 3TdVK8yulvPpCd2Hh9I7NYq4215XJVnnKepAUAQuRc6JvBQt4KGQrSw5xPHF9zzDiYIH
 ThMxncfmr7uJxHPBYcsYvzmmALxAx9Lc1bIkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773674110; x=1774278910;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ri7qxm9NYLe1bTR1YCo392z+0jehFIbTh1NdLIHLiTY=;
 b=Ow7MSnEAu9C3RjDb+4q+Vt8Q2iLQPrcGuEU5QnEGVO7ldRCQrkUDrj1E1KGABfQR7U
 cRi/NUIYJZe0fz1cR2r6TAGbVptO8zu7VU/BqKlQ5YQ4FHjrQpnJNjOJxyfuDuNK96QW
 LJ55rHllmDraRqktOjK6705xW6ahpa8e6F1p7846osagE1qZiecWpzoUpCasV1MZIJaz
 OImlwmqMwzxdx94hh+Sy3vqfliW1ZsRz+SXD8WigCFb+p/XM1IDdCBFLkG6t1JhBd4lB
 rydUtd/++icwpld1Nt0z+UtOCBiVZIXJ9FUpsevuf+HPDhMzNgDLMg38xqXcP2rD8Pnm
 2XoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXugci0rcEQAgwl6/8ZF07vIb7ysqwQ3TtA6T6hfPyghhjWhXmKfEk5Ybzn9xjhwojssaA=@dpdk.org
X-Gm-Message-State: AOJu0YzkZe0shcJoRbFdsw63rwtbRyhD6tj8ArJhDmlthH64SBWrN+cb
 7spcsL5taJzzZiSPXox5Qi9tvswj2ZBEznixmah32GbPB8HKHnzWcKf+OxNz4yFS6SLa+LZHEWc
 phwa/ZITH+LpiLAxhVXQgJeolRZHWjugGpHlK47u7ng==
X-Gm-Gg: ATEYQzy5RCOXMXsrZ4kJt4lFM8nPut5HhWmF1JERd/mw5nOtr7znTQv1WjiNMBni8fB
 5j39wcsPlc8jsgA7jWVvzcRLuCRPAJTjbkfb1ann4geF87yVcD95k/GsBaTmjKq6PoW+6se4UpR
 hsUrXnVu8ZZudkcPh/zcRvIWU94np5+IbHjvePgKN35dNCMvBO4Q18pvUO0VaquxY5QIKwLNCVV
 qp8s7dyjuh5DTwI/FtSspOLqPrfO6BeQZVdyH00tw80LzkUKzEZdkATXZiB2xhfewjJ65nQdjON
 86CulnSIu35cADPAZyVe0MrhXy48PB297vrhD/Ms2Q==
X-Received: by 2002:a05:6402:5194:b0:663:8540:177a with SMTP id
 4fb4d7f45d1cf-663bac1d6ddmr7979347a12.29.1773674109750; Mon, 16 Mar 2026
 08:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260312203630.96473-1-dmarx@iol.unh.edu>
In-Reply-To: <20260312203630.96473-1-dmarx@iol.unh.edu>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 16 Mar 2026 11:14:58 -0400
X-Gm-Features: AaiRm52sUrDg3tWPMvU1UFz_VOl2K31M_79r_pyRoyC_ETtFRf9QwDCBRR3UB1w
Message-ID: <CABJ3N2XV-FCcfZBE09DnYqrQd-W=G=LsVmS3rxdpYWzuyr9y=g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dts: update verbose output regex for VXLAN packets
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000426125064d25af88"
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

--000000000000426125064d25af88
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>

--000000000000426125064d25af88
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr">Reviewed-by: Andrew Bailey &lt;<a href="mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt;</div></div>

--000000000000426125064d25af88--
