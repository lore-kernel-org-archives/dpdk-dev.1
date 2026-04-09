Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8EAF31E24
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 15:24:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 878F64028D;
	Thu,  9 Apr 2026 17:24:04 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 2B5554028D
 for <dev@dpdk.org>; Thu,  9 Apr 2026 17:24:03 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c287eb77fso660c88.1
 for <dev@dpdk.org>; Thu, 09 Apr 2026 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775748242;
 x=1776353042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4eRs9D0tVYEnDvBc3YYuHoRTY1JBCFaugO2FQvrac4=;
 b=nsJgse3s058T3t6yciPhPIsEizIqzJFN13CCNIzTVPHRvwUEImtbTsZ0f1IDAYIwSX
 +mvQgW/ykwtVyYUodn8heRyf81bC3pu27O3pD2ZfG6J4FsPzK/gbDMbTlx//lYFufNhI
 P60mvHbmRP4y0Qeary3ux2I40XIyF/MwNQKa+vQPgRRPw4FKj1ObtDIdZi+2js6CGMC4
 eWJbNK4F6UPlb5wCffv+PJe5Pxc2SRW+9IIGqY6MmsMOKWtUueSoCI/2vg1Rt59BBNBY
 WKPClaLotfR4o/sFnMQcnLDzgHD5VccIA+agdbKGz+RAUeUP9fGSz7Sk6cReK0FgQuOm
 /JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775748242; x=1776353042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J4eRs9D0tVYEnDvBc3YYuHoRTY1JBCFaugO2FQvrac4=;
 b=dIWwfN7JVfkCm3Y+CSKDVhgI0s0v3XwbqZzYQdPaqFK3Rl8T9RQEJuSX8OyjdnsyXt
 uzURlACgukRvfQhwcQ+AJJnvTIPi4dfcApkeSCAl2o/uNDfX2r/zmdPqXRPIN0Yq1CXB
 yJ2F7GHD2vfzpwNzlhcjYlUSk38xwTxOFfN7xfrlb5l0yMZeF5tJvTXKVfQf5WdbvpO6
 L1WSujITyJ7Dcd2DB1xmYi4WpTgF5wVObQpCh+l1YL8rm7+RM2NKTxwRNizVCt8X22mI
 59lUbxTT636vGTuh/5mnep2BeyvRqqBW1i2vQCqVdTIXRRuk45boCUkfOZoE2m1PIM4w
 1gAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6wvg+Ll3ZmYimdYZ9mpoE7GZEjvnJzheq8p5Zypu3sjgc1FpQ7k8y4tfYbtkQQ55KlE4=@dpdk.org
X-Gm-Message-State: AOJu0YyT46QqLLsPTVdZ1VxglL2mGUYn1/TGgBcYfJyIB26NP1VcXt0C
 IT8iH4CHx1q85kWjOOGYQRFbJGU1aFG6G6aGZmy2JEF7g0dd6LTxQ4faLYzamf9CVuk=
X-Gm-Gg: AeBDievvAY7dGGmho6mTvHIkOVC/f+UfdJHv94K/ZybCfZrapH3hWWZ8y+lKS5AyALZ
 DGl756bg2xuqsG1n+1cEzRvo+E6SHcEOYgZjnmP8MjIJ06cFFwuEsnBJJ68cgb5MVsc4C0dete0
 HgEGaK/vxFILibLFDAFhLcnMauojeWB0Fj1ryU5vUM6OiD8mQ6w0YwolbYag0mzpwzUBZfNBZ0Z
 OX9eeW0RLlJjI7qsiQQ8l7amtW+tBQJYZglrS0whRVD3y93L3nCLiB5HA2FOsbiw5GE/WIELag/
 DrtjazvRVhhaISg5Ws+tS79Axi2y0YqY0FWdtGMgxK4WxLFbjXi/a9ngJPANVxMJsJPu+RWAUAi
 sZEFcVFguzR/qEAe7xZWeEO0KtdT5wa5yHr+gKjgLaNNCp69Ord74mo3FPJLcZg4r02Ykq7vcOb
 z5ZAW4ry5HBFH957Qqp3dSv5CN/V1wrenjA6A=
X-Received: by 2002:a05:7022:b9f:b0:128:cf86:d1cb with SMTP id
 a92af1059eb24-12c28c0fcbamr2250477c88.31.1775748241835; 
 Thu, 09 Apr 2026 08:24:01 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d5627c44fcsm35726eec.23.2026.04.09.08.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:24:01 -0700 (PDT)
Date: Thu, 9 Apr 2026 08:23:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, Reshma
 Pattan <reshma.pattan@intel.com>, Aman Singh <aman.deep.singh@intel.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>, Anatoly Burakov <anatoly.burakov@intel.com>, Cristian
 Dumitrescu <cristian.dumitrescu@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [RFC] ethdev: add buffer size parameter to
 rte_eth_dev_get_name_by_port()
Message-ID: <20260409082358.1cddcf06@phoenix.local>
In-Reply-To: <445dc90b-081a-4ab0-bd3f-924557dcac9a@oktetlabs.ru>
References: <20260409013658.965613-1-stephen@networkplumber.org>
 <c04d3145-d6e9-4583-b49c-82341ea9b0aa@oktetlabs.ru>
 <addcKzXuZYV19F3P@bricha3-mobl1.ger.corp.intel.com>
 <445dc90b-081a-4ab0-bd3f-924557dcac9a@oktetlabs.ru>
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

On Thu, 9 Apr 2026 12:05:35 +0300
Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru> wrote:

> >>
> >> As far as I know typically variable declaration and code are not mixed
> >> in DPDK.
> >>  
> > 
> > AFAIK That used to be the case because early versions of DPDK targetting a
> > very early C standard. More recently, we've started allowing this sort of
> > use, which makes the code more readable IMHO and easier to work with too as
> > commenting out blocks when debugging leads to fewer unused variable warnings.
> > 
> > /Bruce  
> 
> Bruce, thanks for the clarification.


I started doing this more to avoid uninitalized variable hazards.
