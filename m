Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFCBD2502E
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 01:14:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 362484067E;
	Mon, 12 Jan 2026 02:14:39 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 43DE14028F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 02:14:38 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so2506948f8f.2
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768180478;
 x=1768785278; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOV7FklVgPPow992vBcvMeb96SBRq1G5LAmSGiZozd0=;
 b=UMJyZxieIeZZcqR1GoDQN0WtEpQApSTaBSt/+zFsHoB0XxQ/2tUiJQCe5IZRab1e6H
 66soA5JB4RnfL7m2krfmvIJYVPPo8ZeTY58+pYPbkFFW/jBVNEK7caQua5Vy3BPnJEII
 /GTeSHGpdIAwQ2ed1HG0LLi4C9qH4tflAowd0FgmvayiB+UvapLwDt2JcAh8xbXK/qns
 qN0sr5JyHYP/2lyzzqJ/0vNEi+GCn4e5VPr7piTMTe6m8aYUMhdAMiqzyrp/pIUo52L/
 oEWYYlE1KKXWtsQr0Ag77leavnBIXbQowi2joMLAt5s5ILpmq5/vF9PYssAXqTH36NLW
 HgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768180478; x=1768785278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NOV7FklVgPPow992vBcvMeb96SBRq1G5LAmSGiZozd0=;
 b=u1UviYysLoR6ABEIwNGuDPrLbaGOnfJeslA3/VyWClAHl1M5G4yukDdeD8zHETettS
 TjPxCWSlxqyN8gFRtaR3I70YobvBRYGcFd/MVoiuMfbMu+j/UV92auw9JNiX2fA89IpT
 5LxFvWmY42pSU8hDp/rUKRy/FvxNXsipWPxbQYIe3dM6T7H1PrbFqLvKnWL5okRKGrJP
 1MDMH3l4VUhYlkXGKhUtbNnzoMEkMW8oLUi1I8ZRFLushanIXA9fQHCJxJ8/JKlPzLJR
 oLQBuhc5sSybRHquIV9wZtkJAeSCTCBEOe1K4MYW5NxZ2MabkH9DhoDy6L4nG5zsSPy6
 c4Xg==
X-Gm-Message-State: AOJu0YyoJ9LASIP1ysrZnlvKbB4gk/pb0JKV+YJvWNSDdLb0AiiHHmt+
 hEeFN5Hfy54zxi/vGnbhwPRyAMYlVJTGRfpCKzcdiVwRIFhitKhxSjQPcuYq3YDWV+9SGtShglI
 m751O
X-Gm-Gg: AY/fxX7wcuKunkFyBIhv5CBZXtTBQmrJJxvFgJ5ErYC8Uw8QxLZPTNgTfVVRDblyjH0
 s9OVeb7J4UpJy7mzB70+CKwfCp0KQ+5OSFwPFJ15vbNuvCvxCNozwSSnp5u1kfiWtUAo03NkOaB
 mPRXoo7z6/11YercD5ik5tkoNtkoooPLz4q4UlEawOBo1Az0v0Id3vpcfrPDZ2xGgcuYuUNN85i
 M4tF0kp7aoYr4ljptQmzoWMfn17iRaaYSdF9MgG55eOEfxSIlFZmLO/n0rCgY/G7/wtJglaeUrw
 VfQoguVXUUZBOK0EKTzUL9+X8+lA8aYay2yuMZqQzCcez1/7vlilxzWNJQXB3AUkzI0RZJ288Iz
 lqq3L5tCMuqLxDIjwu4/BIDI5c73mqj6NAbz4d94A+GTWFhUgll3uGJftbQaTnri7QYgzFuqE9Y
 uJOCPmdApxYsVIYcBTa2VHOzgvLxu5WfShyKbjbCEx84O2ZMoeX0eK
X-Google-Smtp-Source: AGHT+IGw72ci/8c2Wxj/0kYSmfMexPGWu6fbtjcLB6loJ9+fMKNPUoRAnIf4cow4GZulKreMfjx2Eg==
X-Received: by 2002:a5d:64e6:0:b0:431:4c6:724d with SMTP id
 ffacd0b85a97d-432c3795286mr21214390f8f.29.1768180477744; 
 Sun, 11 Jan 2026 17:14:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff1e9sm37360864f8f.41.2026.01.11.17.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 17:14:37 -0800 (PST)
Date: Sun, 11 Jan 2026 17:14:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: Re: [PATCH 1/2] net/nfb: remove unused flag
Message-ID: <20260111171431.71788862@phoenix.local>
In-Reply-To: <20260101181345.201601-1-stephen@networkplumber.org>
References: <20260101181345.201601-1-stephen@networkplumber.org>
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

On Thu,  1 Jan 2026 10:13:43 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The configure callback does use the device argument.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/nfb/nfb_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
> index 98119d70fd..5f1b11a961 100644
> --- a/drivers/net/nfb/nfb_ethdev.c
> +++ b/drivers/net/nfb/nfb_ethdev.c
> @@ -181,7 +181,7 @@ nfb_eth_dev_stop(struct rte_eth_dev *dev)
>   *   0 on success, a negative errno value otherwise.
>   */
>  static int
> -nfb_eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
> +nfb_eth_dev_configure(struct rte_eth_dev *dev)
>  {
>  	int ret;
>  	struct pmd_internals *internals = dev->data->dev_private;

Queued to next-net
