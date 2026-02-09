Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57161E7E0D0
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 19:01:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D1A4042C;
	Mon,  9 Feb 2026 20:01:39 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 3B65D402F2
 for <dev@dpdk.org>; Mon,  9 Feb 2026 20:01:38 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so45983725e9.3
 for <dev@dpdk.org>; Mon, 09 Feb 2026 11:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770663698;
 x=1771268498; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46Q6nj+a5HlWTC5N2ONC73w0EDGS2CrZTvW8LV51ZuU=;
 b=1Mmp9Gey528RXGJbrToTGeDuZzjgbsj9Nu3kin9e60a4MEH6poecU0cxi21gWOPV/x
 0Nxo0aqnrhjSnKTFXnFGKa0+PFP8GITXjurYziIoGvL7TDo/b3n92SC6Hr+gbrmteNlx
 fg1i8b7jZ9cfE/jj5zZ/ncYGeb2H/fKuOIQvnmimhH89NCEWt4goDdYVLa4pgA+I4c9O
 cYGBMaOE87yHnIR4jZrVm5/aTWMiacqL4ygQtvJSIwrZSpGwqoPnUAcT/4RJvZIsndaW
 X5vMaufiMduOgzLXFgpu94WbQ1OW54s0JIBvG6pFjPg8jcz7UGunWN4s1PTPhS4WKGzp
 B1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770663698; x=1771268498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=46Q6nj+a5HlWTC5N2ONC73w0EDGS2CrZTvW8LV51ZuU=;
 b=wyaNmgJy3cpHo3dyISf8mcn+JNHRQ1V7XDU053qay0gZyqoGqBTlOxFE80Q9mKLgQc
 BssbmVDyRdiqHe2jN1PcSAKb1af/TAlbWWoXQ4tGfQitgJABVGwqPNSYiS/OHxQ7eQ1x
 ivW1XVn+DEsbDMzMeS+i7jHY164Ky1Ejsgxw2vns06LFBLoNrVRvnBdhyPUuLg9+J/Ng
 XyNLBTZ6Yl5JnQg0pYVfwALXcCItIc41b0v10kHsj2fyfPDFGDZ9v0eJOu3o/OeDeRB5
 QpthdWG+QE/mSf64bIgz1IXm0qOdQ4rTFYWb7EZeDNLUAmPgvOxYN8YII+dWwiFZgh1V
 4GCg==
X-Gm-Message-State: AOJu0Yx6cqTi0LyiYpcBYiHIYrfI1YDpE/GyuhNBKyIo/xXEx0kZJgab
 qOj5GPmYRcaj+6CSv1IpDiU6ghU0ojvOniu0MUvjAqTfHSOfi/xJVFea7+gVa04ZcSDXSl520Mt
 khzxB
X-Gm-Gg: AZuq6aICwOGR4s5hrafa6+6CSIqc8QU0XyG4mxPq3cHFL9XYESyz/POOtnrn4xgGYZ5
 1ZZRRbx7S8kkpnwENqOrFpOj16BEW3+YIolgMFBBD0R3ezdWZsNSdwJa72pOcNG+SC1Ql5p6N+d
 HHjL5D+pnCZo3lXA4rPpRkKcnGadSz0BGUzU4lddP4B1GwaCkMciMpnSy1HFFAn/gcbe5+RrI1C
 6Z7r+vfTJD//kdIKfnN7rR3Luus/Jc1etTXbVOmJO3aMkxgl/4bnhABWhiPqI0oAeNAwUrcHmeu
 rWAskxtUky4hSJ1Qn5g7X6w4S8BSbCEbDsMhRE7e6VM+FmBvNTlZ9EmdMWyNa/MwvqBhNrM1I8J
 HS7a4zL8jpJx4MFcHswdsNYUfRdaeOVJ3Q6228kWrs674PrRWHEQ8F6ti9bNlEBjW7siWwMsC5L
 BPwVNXh6BlWg+16Xpg1q/Q4mWSybLLjxwwT4ImXqxokCSSbBBwmvPd
X-Received: by 2002:a05:600c:5287:b0:480:6999:27ec with SMTP id
 5b1f17b1804b1-483201e49abmr187016455e9.13.1770663697611; 
 Mon, 09 Feb 2026 11:01:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e50casm7330765e9.8.2026.02.09.11.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 11:01:37 -0800 (PST)
Date: Mon, 9 Feb 2026 11:01:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v17 01/13] net/sxe: add base driver directory and doc
Message-ID: <20260209110132.57838f86@phoenix.local>
In-Reply-To: <20260209012458.506200-1-liujie5@linkdatatechnology.com>
References: <20260208115626.146863-13-liujie5@linkdatatechnology.com>
 <20260209012458.506200-1-liujie5@linkdatatechnology.com>
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

On Mon,  9 Feb 2026 09:24:46 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
> ---

Please do not blast so many revisions in a short amount of time.
The current suggestion is one revision per day.
