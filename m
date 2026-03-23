Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80071F483EB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 19:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E206402D6;
	Mon, 23 Mar 2026 20:51:51 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 91F6640268
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:51:50 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1271257ae53so624036c88.1
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774295510;
 x=1774900310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTAsyxHWsyE1tET8NA2uepOvQCx9FTpl59X5oZgxyRI=;
 b=ZJhuXQtNJ+JdYeBJERQCEDDHgJKTCrpCGEMpEmBRvUCukKAr1Wb0Oy2XDpca1gKk8K
 BFX6g2ocgYxiEiQ7i/wV4yQH7vdmHbwagW8nbt5MLs2XuUdPmE3cPePmHD2zETtxMt2L
 duV5FqFHFmckZxC948yRXvN/PnZc+c28vB6cQD9A2y7YKL6Xf8fJSdjEry1ax+8GcYJZ
 McvfV/quvgA5gR3N7+7GrzjiCIkC7mWOYyUEVicIxjLIBEbE2GyfLb54tNehCKiqy3TT
 VeywjFRLXIQmfVWY7jIy2KYvyyAtBJenKmR3ClsdOvliwOImdxKWPMyLFC6m1j3Z51M2
 ur8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295510; x=1774900310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rTAsyxHWsyE1tET8NA2uepOvQCx9FTpl59X5oZgxyRI=;
 b=Q6Wb1Rv6vYEHAA0zT7J6GROzEhFPQ5cDj8Rqa/3iSh6ubBMraxULgtjCcjQS8kXXKt
 TlS/UCEp+Geh7QS64NblJVnkx6+Vgu3lupC3sCGSYY6p4CCyxQy4lNMXAThXv/mab9g+
 LNUK9DPoy74hyIF2sT/d1ioKBFKrVcZoe3hoKVB/k+C+8bodf3UEX6nE3E0LN61XvPcR
 KquEYVf12MVIt76rZ4qQIw56QZPHVF68kv6Tc9mN71x3zAqq0CDGmm1/1hBiZDFolBN2
 Rt5JAnDFtJNpyXJyO/5B5HbdpS4v6pApzq1j66BnuUpnFMCJiffdQX87JqAFze0aoVGg
 gSgg==
X-Gm-Message-State: AOJu0Ywt+mNdlqt+ITFLQb61dQ+BEvNCnoQAZ60t37NRJWf4u0OJeFwA
 3J9Savd5WXZ1W+K6N1IXpnBrtknDr01X1IbE1ihOW5SgBWLuqwtH76azgq+nZHe/uVg=
X-Gm-Gg: ATEYQzwoUil/RLfLBPpp4HYzFdReV4ID/+o3KRcJwK2gxJ2G+kAUYtmhprWhoXXBk+v
 ffkWqllTbj7njapbv0XpC+jvuUj2IFROFgOEnmDFQvX/Jog930qW2rmeljrTI6UauqvpFlM/77k
 MjMd1cuEX16qUkb0p8voYpu2bZKJXjw/zxk7L8rceieX0YzXFb7VhSVlyZk6UdD7uyQfbDGMtEH
 vtYxDKzr8TlFwhyMzyCLjCPOdv8dySZlrOvfh/AMxxbAk2OFuTnGF5/2N85gA3MDJc6foUgTwcg
 nacR10UWBxWPPMU7MGaRgheDEOVpPj//f7jmNaFlQ7YpvAsDWz6MXTE6qhiVRHtl+mZDAWgMcP/
 2Rqed1Nj0BAZ44G2TGyOlcQv8mzAi1ibTMz3Gfg1hqwMIoT4IKeVY995t/I4v24E3KST13Ywbx4
 BgMjx30pWWbNBJJcfQiLlLjEK1X1Yx91Er/xA=
X-Received: by 2002:a05:7022:612:b0:128:d4db:447b with SMTP id
 a92af1059eb24-12a726fac5fmr5855915c88.38.1774295509528; 
 Mon, 23 Mar 2026 12:51:49 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a736cf7e1sm9386958c88.15.2026.03.23.12.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:51:49 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:51:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [PATCH v7 1/7] net/hinic3: add support for new SPx series NIC
Message-ID: <20260323125147.7ff35d8f@phoenix.local>
In-Reply-To: <20260323080455.2699-2-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260323080455.2699-1-wff_light@vip.163.com>
 <20260323080455.2699-2-wff_light@vip.163.com>
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

On Mon, 23 Mar 2026 16:04:44 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
> index 3d2ed19eb8..a29c460c6a 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -81,6 +81,14 @@ New Features
>    * Added application-initiated device reset.
>    * Added support for receive flow steering.
>  
> +* **Updated Huawei hinic3 ethernet driver.**
> +
> +  * Added support for Huawei new SPx NICs, include SP230 and SP920(DPU).

Minor grammar note: should be "including" not "include" here.
