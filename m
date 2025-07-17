Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1BBC83F34
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 18:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFA014013F;
	Thu, 17 Jul 2025 20:05:30 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 83FB7400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 20:05:29 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4ab53fce526so19452631cf.2
 for <dev@dpdk.org>; Thu, 17 Jul 2025 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752775528;
 x=1753380328; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBU6T65eorWr+xHfUJYeuPVPCiSeI7mBlGG60SmijpI=;
 b=bbVG4XnZQ/HMT5EgctKATFW1wFLWwdV4B3+6TyJPd/8HK0aoSYOdblJrvUhn2Mk00V
 PsP/XzVbsqfnd9jM4qVTUGbF3Jt8Wet2DiC6TDbHqSwbLeWm35Zna5qU3WAixWA4AXCI
 rnyOFf7EZnfT7fqOcPzNPmxMZrSBhzUW0Yx9huWqli6VW3vAAqPpou/IqQCYFeUP7Awj
 VY3/xMcVdUQ+jLUFML2S6spY5M1HTELn9WVez4di35h/lpys+Vb/As18MdhSdG8Ryf5f
 zaawtz9kIHIjSBGrPNFDov+z1dAL0WzM5zOpP7eyxuph+MjcJrKqNDCOkAnLz+n20LWN
 +TYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752775528; x=1753380328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBU6T65eorWr+xHfUJYeuPVPCiSeI7mBlGG60SmijpI=;
 b=rBQSUw6UgCvwGnbkHaV8tV1lVrA2+lN/3noUlqen4WrbZPCxodlB1IhxL0kzf01ZSu
 q/rmQBQ7MR/vFUcNoejSS0WYkYru5FADfErDxGwrHRFgM1o071L138t3pXTCCHmsOIDO
 T8qPA+9cUZMQsX4vC4Zp+0dCqLtsNSWaFaP2VSNWth8ji/HhP/p/bDc/wNvfJvXUGbfP
 ULeppGmN8CZuUb9+AAPvYkMZi1odTUZcxwFqC+0BkwxXYeuAwFcyZK9oLgwJLyzvq0O2
 8ZZRFDDmSHGXxdAS2sDNx+m6uk+YzYxrHq35laN+C5BoEesXvpYTORUOH7CmBClOO2mR
 Nx3Q==
X-Gm-Message-State: AOJu0YycIfKe3G1VoYdezg7o/UGrLcjNz1TzmgL8QaVcvlGqpTwrwzgD
 dBHxuE4XcLp7n0IGm35ZjzzoIdTnafxOTrp2ScZrld6RIG8usOll/wuqZFOZr/C1RKfamstgtLR
 DOrr8
X-Gm-Gg: ASbGncsf8Yhor0EC0dkX3iv4HneyGapLsWZFlEM+WFaDkPsRiRybLmiSGPLM7Ch6yjr
 +Rh6fzZgh57IYZnvOezEIhgnpwZ7JlT1XQav8Ps+2x2de/lfKTU9NbCOp6kzCq0FkCt2DVyaf7n
 tfWdvg4/W11O7NSI4S509b4l1fn3d2PhLoyvDXzeQ/tBPpY3lz65q2KhWiBCeKzyn5DGs5s7077
 cuUH76fyFCXIk47B7Ei1Aid0IC/dpMwwQsMndJz77oEPzDnd//asxkgev1rlBLTPfAbRpzsfJjD
 FjoOdBRInn26QyOP8/0oa7nxEz29onwe3Pq7n5KP7HFwzHZXxWG2dp6c/sCcy7q92fcwcufQhr4
 yw8hs4Wzf7VexmQNbsusDWaZuw9XUzB89KTOsx3Wq8X4A98EinMi4x7TaVJBHSL8Kex97Sg0DJ6
 U=
X-Google-Smtp-Source: AGHT+IFu6V0uDGvWEgd7zSo9dc7SqFFq+RrqIwGny0UDiLu3UPTdAXqNPaDK575X4fQRgb9b8qYFGw==
X-Received: by 2002:a05:622a:1999:b0:4ab:4d30:564f with SMTP id
 d75a77b69052e-4ab93df21dcmr119002461cf.47.1752775528247; 
 Thu, 17 Jul 2025 11:05:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab6d02cb7bsm49358671cf.66.2025.07.17.11.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 11:05:28 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:05:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250717110523.218ad108@hermes.local>
In-Reply-To: <20250710012021.7698-3-liujie5@linkdatatechnology.com>
References: <20250707115819.12826-14-liujie5@linkdatatechnology.com>
 <20250710012021.7698-1-liujie5@linkdatatechnology.com>
 <20250710012021.7698-3-liujie5@linkdatatechnology.com>
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

On Wed,  9 Jul 2025 21:20:10 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +s32 __rte_cold __sxe_rx_queue_setup(struct rx_setup *rx_setup, bool is_vf)
> +{

Please don't use __rte_cold in driver.
It really is only needed in the core code (for example rte_log)
as a way to tell compiler: "If the code path calls this function it
can not possibly be critical performance".

Putting it in driver is just clutter.
